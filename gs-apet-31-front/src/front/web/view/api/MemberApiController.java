package front.web.view.api;

import biz.app.member.model.MemberBasePO;
import biz.app.member.model.NaverApiResultVO;
import biz.app.member.service.MemberApiService;
import biz.app.pet.service.PetService;
import biz.common.service.BizService;
import framework.common.model.NaverApiVO;
import framework.common.util.NaverApiSendUtil;
import framework.common.util.StringUtil;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.codec.binary.Base64;
import org.apache.commons.lang.StringUtils;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.*;

@Slf4j
@RestController
@RequestMapping("/affiliate/")
public class MemberApiController {

    /** API 인가용 key인 stm-api-key 네이버 제공 */
    /** NIF0001의 response-contents의 interlockSellerNo 와 NIF0002의 header의 affiliate-seller-key는 동일하며 네이버에서 개발 및 운영 환경에 맞게 제공 */
    /** AccessLicense : 어바웃펫으로 자체 발급된 API라이센스 제공 */

    @Autowired private BizService bizService;
    @Autowired private Properties bizConfig;
    @Autowired private NaverApiSendUtil naverApiSendUtil;
    @Autowired private PetService petService;
    @Autowired private MemberApiService memberApiService;

    /**
     * <p>
     *     [=== LIF-0001 ===]
     *     RequestMethod.POST
     *     A -제휴회원연동 웹페이지 API
     *     (네이버 펫윈도 ==> 어바웃펫 )
     *
     *     네이버에서 회원연동에 대한 사용자 수락 시
     *     어바웃펫의 LIF-0001 API를 호출하여 회원연동(네아로 인증 완료)에 대한 code와 token을 보낸다.
     *     어바웃펫에서는 token을 NIF-0001 API에 전송하여 회원정보를 조회한 후
     *     code를 네아로에서 회원정보 API에 전송하여 회원정보를 수신받아  어바웃펫 회원DB에 저장 후
     *     연동완료 에 대한 API를 호출한다 (NIF-0002, NIF-0005)
     *
     * </p>
     * @param request HttpServletRequest
     * @param pmap HashMap<String, Object>
     * @return
     */
    @RequestMapping(value="interlock/member/join", method = RequestMethod.POST, consumes = MediaType.APPLICATION_JSON_VALUE)
    public void lif0001(HttpServletRequest request, @RequestBody Map<String, Object> pmap) {
        memberJoin(pmap);
    }

    @RequestMapping(value="interlock/member/join", method = RequestMethod.POST, consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE)
    public void lif0001Form(HttpServletRequest request,@RequestBody MultiValueMap<String, Object> paramMap) {

        Map<String, Object> pmap = new HashMap<>();

        if(paramMap != null){
            for(Map.Entry<String, List<Object>> entry :paramMap.entrySet()){
                pmap.put(entry.getKey(), entry.getValue().get(0));
            }
        }

        memberJoin(pmap);
    }

    private void memberJoin(Map<String, Object> pmap){
        // print log
        naverApiSendUtil.printLog(pmap);

        // ==== request 처리==================================
        String reqCode = (String) pmap.get("code"); // access token 을 받아오기 위한 code
        String reqState = (String) pmap.get("state"); // BASE64로 인코딩된 값 : token, provisionIds, optionalIds
        String decode = new String(Base64.decodeBase64(reqState));

        JSONObject jsonObject = naverApiSendUtil.jsonParse(decode);

        // 사용자 인가용 API TOKEN : 유효시간 1시간
        String token = (String) jsonObject.get("token");
        // 동의한 약관 식별 번호 목록
        String[] provisionIds = null;
        if(jsonObject.get("provisionIds") != null){
            provisionIds = ((String) jsonObject.get("provisionIds")).split(",");
        }
        // 추가 약관 식별 번호 목록
        String[] optionIds = null;
        if(jsonObject.get("optionIds") != null){
            optionIds = ((String) jsonObject.get("optionIds")).split(",");
        }


        /* ============================================================
         * Call NIF-0001 API [-- 네이버 회원 정보 조회 --]
         ==============================================================*/
        NaverApiVO nif0001Vo = memberApiService.getNif0001(token);
        nif0001Vo.setProvisionIds(provisionIds);
        nif0001Vo.setOptionIds(optionIds);

        if(StringUtils.equals(NaverApiSendUtil.API_SUCCESS, nif0001Vo.getOperationResult())){
            // 제휴사연동스토어(브랜드번호)  동일 여부 확인
            if(Boolean.TRUE.equals(memberApiService.sellerNoEquals(nif0001Vo.getInterlockSellerNo()))){

                if(nif0001Vo.getInterlockMemberIdNo() == null || StringUtil.equals("", nif0001Vo.getInterlockMemberIdNo())){
                    log.error("[ERROR]  Call NIF-0001 API --> 네이버회원식별번호가 존재하지 않습니다.");
                }else{
                    //============================================================
                    // 네이버 사용자 프로필 API를 호출
                    //==============================================================
                    Map<String, String> userMap = memberApiService.getNaverUserProfile(reqCode);

                    //============================================================
                    // 회원 여부 확인 ( 존재 시 업데이트 )
                    //============================================================
                    NaverApiVO profile = new NaverApiVO();
                    profile.setSnsUuid(userMap.get("uuid"));
                    profile.setSnsLnkCd("10");
                    profile.setCiCtfVal(userMap.get("ciCtfVal"));
                    profile.setInterlockMemberIdNo(nif0001Vo.getInterlockMemberIdNo()); // 네이버 식별 번호
                    profile.setWorkType("update");
                    boolean existFlag = memberApiService.checkInterlock(profile);

                    // existFlag가 true 이면 회원정보가 존재하며 윗라인에서 이미 업데이트 진행 되었기 때문에 PASS
                    if(!existFlag){
                        // 회원정보 저장 (추가정보 : 네아로회원번호, Npay회원번호, CI )
                        userMap.put("intlkId", nif0001Vo.getInterlockMemberIdNo()); // 네이버 식별 번호
                        MemberBasePO po = memberApiService.insertInterlockMember(userMap, provisionIds, optionIds);
                        nif0001Vo.setAffiliateMemberIdNo(String.valueOf(po.getMbrNo()));
                        nif0001Vo.setToken(token);
                    }

                    //============================================================
                    // 저장 완료 후
                    // Call NIF-0002 API [-- 제휴회원연동 매핑 요청 --]
                    //==============================================================
                    NaverApiVO nif0002Vo = memberApiService.getNif0002(nif0001Vo);
                    if(StringUtils.equals(NaverApiSendUtil.API_SUCCESS, nif0002Vo.getOperationResult())){
                        log.error("==> 회원연동 완료");
                        // NIF-0005 최종 호출
                        memberApiService.getNif0005(nif0001Vo);
                        log.error("==> [NIF-0005]  API CALL");

                        // 펫윈도 펫정보 호출
                        try {
                            memberApiService.getPartnerPetInfo(nif0001Vo);
                        } catch (Exception e) {
                            log.error("==> [펫윈도] 펫정보 API CALL error");
                        }

                    }else{
                        log.error("[ERROR]  Call NIF-0002 API --> result : FAIL");
                    }
                }
            }else{
                log.error("[ERROR]  Call NIF-0001 API --> 유효하지 않은 제휴사연동스토어(브랜드번호) 번호 입니다.");
            }
        }else{
            log.error("[ERROR]  Call NIF-0001 API --> result : FAIL");
        }

    }

    /**
     * <p>
     *     [=== LIF-0002 ===]
     *     RequestMethod.GET
     *     A -제휴회원연동 매핑조회 API
     *     (네이버 펫윈도 ==> 어바웃펫 )
     * </p>
     * @param request HttpServletRequest
     * @param pmap HashMap<String, Object>
     * @return
     */
    @RequestMapping(value="interlock/member/status", method = RequestMethod.GET)
    public ResponseEntity<NaverApiResultVO> getMappingInfo(
            HttpServletRequest request, @RequestParam Map<String, Object> pmap) {

        // print log
        naverApiSendUtil.printLog(pmap);

        // 결과값 전달을 위한 MAP
        NaverApiResultVO responseData = new NaverApiResultVO();
        NaverApiVO vo = new NaverApiVO();

        // API 인가용 key 확인
        Map<String, Object> header = naverApiSendUtil.checkApiKey(request);
        if(!StringUtils.equals((String)header.get(NaverApiSendUtil.MESSAGE), "")){
            log.error("[API_ERROR] {}",(String)header.get(NaverApiSendUtil.MESSAGE));
            responseData.setResult(NaverApiSendUtil.API_FAIL, (String)header.get(NaverApiSendUtil.MESSAGE));
            return new ResponseEntity<NaverApiResultVO>(responseData, (HttpStatus) header.get(NaverApiSendUtil.STATUS));
        }

        // Request Parameter Info
        vo.setAffiliateMemberIdNo((String) pmap.get(NaverApiSendUtil.AFFILIATE_MEMBER_ID_NO)); // 제휴사회원식별번호
        vo.setInterlockMemberIdNo((String) pmap.get(NaverApiSendUtil.INTERLOCK_MEMBER_ID_NO)); // 네이버회원식별번호 ( = Npay회원번호)
        vo.setInterlockSellerNo((String) pmap.get(NaverApiSendUtil.INTERLOCK_SELLER_NO)); // 제휴사연동스토어(브랜드)번호

        // 제휴사연동스토어(브랜드번호)  동일 여부 확인
        if(Boolean.FALSE.equals(memberApiService.sellerNoEquals(vo.getInterlockSellerNo()))){
            log.error("[API_ERROR] {}", NaverApiSendUtil.API_RES_INVALIDE_INTERLOCK_SELLER_NO);
            responseData.setResult(NaverApiSendUtil.API_FAIL, NaverApiSendUtil.API_RES_INVALIDE_INTERLOCK_SELLER_NO);
            return new ResponseEntity<NaverApiResultVO>(responseData, HttpStatus.BAD_REQUEST);
        }

        // 제휴사회원식별번호 체크
        if(vo.getAffiliateMemberIdNo() == null || StringUtil.equals("", vo.getAffiliateMemberIdNo())){
            log.error("[API_ERROR] {}", NaverApiSendUtil.API_RES_NO_AFFILIATE_MEMBER_ID_NO);
            responseData.setResult(NaverApiSendUtil.API_FAIL, NaverApiSendUtil.API_RES_NO_AFFILIATE_MEMBER_ID_NO);
            return new ResponseEntity<NaverApiResultVO>(responseData, HttpStatus.BAD_REQUEST);
        }

        // 회원 연동 여부 확인
        vo.setSnsLnkCd("10");
        boolean interlockFlag = memberApiService.checkInterlock(vo);
        String resultCd = "";
        String resultMsg = "";

        if(interlockFlag){
            /* operationResult 연동상태 : Y */
            resultCd = NaverApiSendUtil.API_SUCCESS;
            resultMsg = NaverApiSendUtil.API_RES_MEMBER_INTERLOCK_NORMAL;

            /*contents*/
            responseData.setResultContents(NaverApiSendUtil.AFFILIATE_MEMBER_ID_NO, vo.getAffiliateMemberIdNo()); // 제휴사회원식별번호
            responseData.setResultContents(NaverApiSendUtil.INTERLOCK_MEMBER_ID_NO, vo.getInterlockMemberIdNo()); // 네이버회원식별번호
            responseData.setResultContents(NaverApiSendUtil.INTERLOCK_SELLER_NO, vo.getInterlockSellerNo()); // 제휴사연동스토어(브랜드)번호
            responseData.setResultContents(NaverApiSendUtil.INTERLOCK, true); // 연동상태

        }else{
            /* operationResult 연동상태 : N */
            resultCd = NaverApiSendUtil.API_FAIL;
            resultMsg = NaverApiSendUtil.API_RES_NO_MEMBER_INFO;
        }

        /* operationResult */
        responseData.setResult(resultCd, resultMsg);

        return new ResponseEntity<NaverApiResultVO>(responseData, HttpStatus.OK);
    }

    /**
     * <p>
     *     [=== LIF-0003 ===]
     *     RequestMethod.POST
     *     A - 제휴회원연동 매핑삭제 API
     *     (네이버 펫윈도 ==> 어바웃펫 )
     * </p>
     * @param request HttpServletRequest
     * @param pmap HashMap<String, Object>
     * @return
     */
    @RequestMapping(value="interlock/member/delete", method = RequestMethod.POST, consumes = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<NaverApiResultVO> deleteMappingInfo(
            HttpServletRequest request, @RequestBody Map<String, Object> pmap) {

        return memberDelete(request, pmap);
    }

    @RequestMapping(value="interlock/member/delete", method = RequestMethod.POST, consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE)
    public ResponseEntity<NaverApiResultVO> deleteMappingInfoForm(
            HttpServletRequest request, @RequestBody MultiValueMap<String, Object> paramMap) {

        Map<String, Object> pmap = new HashMap<>();

        if(paramMap != null){
            for(Map.Entry<String, List<Object>> entry :paramMap.entrySet()){
                pmap.put(entry.getKey(), entry.getValue().get(0));
            }
        }

        return memberDelete(request, pmap);
    }

    private ResponseEntity<NaverApiResultVO> memberDelete(HttpServletRequest request,Map<String, Object> pmap){

        // print log
        naverApiSendUtil.printLog(pmap);

        // 결과값 전달을 위한 MAP
        NaverApiResultVO response = new NaverApiResultVO();
        NaverApiVO vo = new NaverApiVO();

        // API 인가용 key 확인
        Map<String, Object> header = naverApiSendUtil.checkApiKey(request);
        if(!StringUtils.equals((String)header.get(NaverApiSendUtil.MESSAGE), "")){
            log.error("[API_ERROR] {}", (String)header.get(NaverApiSendUtil.MESSAGE));
            response.setResult(NaverApiSendUtil.API_FAIL, (String)header.get(NaverApiSendUtil.MESSAGE));
            return new ResponseEntity<NaverApiResultVO>(response, (HttpStatus) header.get(NaverApiSendUtil.STATUS));
        }

        // Request Parameter Info
        vo.setAffiliateMemberIdNo((String) pmap.get(NaverApiSendUtil.AFFILIATE_MEMBER_ID_NO)); // 제휴사회원식별번호
        vo.setInterlockMemberIdNo((String) pmap.get(NaverApiSendUtil.INTERLOCK_MEMBER_ID_NO)); // 네이버회원식별번호 ( = Npay회원번호)
        vo.setInterlockSellerNo((String) pmap.get(NaverApiSendUtil.INTERLOCK_SELLER_NO)); // 제휴사연동스토어(브랜드)번호

        boolean interlockFlag = memberApiService.deleteInterlock(vo);
        String resultCd = "";
        String resultMsg = "";

        if(interlockFlag){
            /* operationResult 연동상태 : Y */
            resultCd = NaverApiSendUtil.API_SUCCESS;
            resultMsg = "연동 해제가 완료되었습니다.";
            /*contents*/
            response.setResultContents(NaverApiSendUtil.AFFILIATE_MEMBER_ID_NO, vo.getAffiliateMemberIdNo()); // 제휴사회원식별번호
            response.setResultContents(NaverApiSendUtil.INTERLOCK_MEMBER_ID_NO, vo.getInterlockMemberIdNo()); // 네이버회원식별번호
            response.setResultContents(NaverApiSendUtil.INTERLOCK_SELLER_NO, vo.getInterlockSellerNo()); // 제휴사연동스토어(브랜드)번호
            response.setResultContents(NaverApiSendUtil.INTERLOCK, false); // 연동상태
        }else{
            /* operationResult 연동상태 : N */
            resultCd = NaverApiSendUtil.API_FAIL;
            resultMsg = "이미 연동해제되었거나 연동중인 회원이 아닙니다.";
        }
        /* operationResult */
        response.setResult(resultCd, resultMsg);

        return new ResponseEntity<NaverApiResultVO>(response, HttpStatus.OK);

    }

    /**
     * <p>
     *     RequestMethod.POST
     *     A - TWC 웹쳇 제공 (반려동물 정보 제공)
     *     (TWC ==> 어바웃펫 )
     * </p>
     * @param request HttpServletRequest
     * @param pmap HashMap<String, Object>
     * @return
     */
    @RequestMapping(value="interlock/pet/status", method = RequestMethod.GET)
    public ResponseEntity<NaverApiResultVO> webChat(
            HttpServletRequest request, @RequestParam Map<String, Object> pmap) {

        // 결과값 전달을 위한 MAP
        NaverApiResultVO responseData = new NaverApiResultVO();

        try{
            // print log
            naverApiSendUtil.printLog(pmap);
            NaverApiVO vo = new NaverApiVO();

            // API 인가용 key 확인
            Map<String, Object> header = naverApiSendUtil.checkApiKey(request);
            if(!StringUtils.equals((String)header.get(NaverApiSendUtil.MESSAGE), "")){
                log.error("[API_ERROR] {}",(String)header.get(NaverApiSendUtil.MESSAGE));
                responseData.setResult(NaverApiSendUtil.API_FAIL, (String)header.get(NaverApiSendUtil.MESSAGE));
                return new ResponseEntity<NaverApiResultVO>(responseData, (HttpStatus) header.get(NaverApiSendUtil.STATUS));
            }

            // Request Parameter Info
            if(pmap.get("mbrNo") instanceof Integer){
                vo.setMbrNo(Long.valueOf((Integer)pmap.get("mbrNo")));
            }else if(pmap.get("mbrNo") instanceof Long){
                vo.setMbrNo((Long) pmap.get("mbrNo"));
            }else if(pmap.get("mbrNo") instanceof String){
                vo.setMbrNo(Long.parseLong((String) pmap.get("mbrNo")));
            }
            vo.setSiteGb((String) pmap.get("siteGb"));

            if(vo.getMbrNo() == null || vo.getMbrNo() == 0){
                throw new Exception("mbrNo가 없습니다.");
            }

            if(vo.getSiteGb() == null || StringUtil.isEmpty(vo.getSiteGb())){
                throw new Exception("siteGb가 없습니다.");
            }

            // 반려동물 정보
            List<Map<String, Object>> voList = memberApiService.listPetBaseByPartner(vo);

            if(voList != null && !voList.isEmpty()){
                /* operationResult */
                responseData.setResult(NaverApiSendUtil.API_SUCCESS, NaverApiSendUtil.API_RES_REQ_SUCCESS);
                /*contents*/
                responseData.setResultContents("mbrNo", vo.getMbrNo());
                responseData.setResultContents("petList", voList);
            }else{
                /* operationResult */
                responseData.setResult(NaverApiSendUtil.API_FAIL, NaverApiSendUtil.API_RES_NO_PET_INFO);
                return new ResponseEntity<NaverApiResultVO>(responseData, HttpStatus.OK);
            }

        }catch (Exception e){
            /* operationResult */
            responseData.setResult(NaverApiSendUtil.API_FAIL, e.getMessage());
            return new ResponseEntity<NaverApiResultVO>(responseData, HttpStatus.INTERNAL_SERVER_ERROR);
        }

        return new ResponseEntity<NaverApiResultVO>(responseData, HttpStatus.OK);
    }

}
