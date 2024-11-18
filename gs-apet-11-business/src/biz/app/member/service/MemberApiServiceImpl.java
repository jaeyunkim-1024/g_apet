package biz.app.member.service;

import biz.app.appweb.dao.TermsDao;
import biz.app.appweb.model.TermsSO;
import biz.app.appweb.model.TermsVO;
import biz.app.login.model.SnsMemberInfoPO;
import biz.app.member.dao.MemberBaseDao;
import biz.app.member.model.MemberAddressPO;
import biz.app.member.model.MemberBasePO;
import biz.app.member.model.MemberPetSubVO;
import biz.app.member.model.MemberPetVO;
import biz.app.pet.model.PetBasePO;
import biz.app.pet.model.PetBaseSO;
import biz.app.pet.model.PetBaseVO;
import biz.app.pet.model.PetDaPO;
import biz.app.pet.service.PetService;
import biz.common.service.BizService;
import com.github.scribejava.core.model.OAuth2AccessToken;
import com.naver.api.security.client.MACManager;
import com.naver.api.util.Type;
import framework.common.constants.CommonConstants;
import framework.common.model.NaverApiVO;
import framework.common.util.NaverApiSendUtil;
import framework.common.util.NaverLoginUtil;
import framework.common.util.RequestUtil;
import framework.common.util.StringUtil;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.methods.GetMethod;
import org.codehaus.jackson.JsonNode;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.node.ArrayNode;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.client.HttpStatusCodeException;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.annotation.PostConstruct;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.*;
import java.util.concurrent.Future;

@Slf4j
@Service
@Transactional
public class MemberApiServiceImpl implements MemberApiService{

    @Autowired private Properties bizConfig;
    @Autowired private NaverLoginUtil naverLoginUtil;
    @Autowired private NaverApiSendUtil naverApiSendUtil;
    @Autowired private MemberBaseDao memberBaseDao;
    @Autowired private TermsDao termsDao;
    @Autowired private MemberService memberService;
    @Autowired private BizService bizService;
    @Autowired private PetService petService;

    private String apiKey;
    /** application/json */
    private String applicationJson;

    /** N-네이버회원정보 조회 API */
    private String nif0001Url;
    /** N-제휴회원연동 매핑요청 API */
    private String nif0002Url;
    /** N-제휴회원연동 매핑조회 API */
    private String nif0003Url;
    /** N-제휴회원연동 매핑삭제 API */
    private String nif0004Url;
    /** N-제휴회원연동완료 callback 웹페이지API */
    private String nif0005Url;
    /** N-제휴회원연동완료 callback 웹페이지API */
    private String petwindoUrl;
    /** 제휴사연동스토어(브랜드)번호 */
    private String interlockSellerNo;

    @PostConstruct
    public void init(){
        log.info("==> initVariable start");
        /** 펫 서비스 */
        String url = bizConfig.getProperty("naver.interlock.api.url");
        String callBackUrl = bizConfig.getProperty("naver.interlock.api.callback.url");

        this.apiKey = bizConfig.getProperty("naver.stm.api.key");
        this.applicationJson = NaverApiSendUtil.CONTENT_TYPE_APPLICATION_JSON;
        this.interlockSellerNo = bizConfig.getProperty("naver.interlock.seller.no"); // (=) affiliate-seller-key
        this.nif0001Url = url + NaverApiSendUtil.NIF_1_2_4_URL;
        this.nif0002Url = url + NaverApiSendUtil.NIF_1_2_4_URL;
        this.nif0003Url = url + NaverApiSendUtil.NIF_3_URL;
        this.nif0004Url = url + NaverApiSendUtil.NIF_1_2_4_URL;
        this.nif0005Url = callBackUrl + NaverApiSendUtil.NIF_5_URL;
        this.petwindoUrl = url + bizConfig.getProperty("naver.pet.partner.id")+NaverApiSendUtil.PET_INFO_URL;
    }

    /**
     * 제휴사 연동스토어 번호 동일여부 체크
     */
    @Override
    public Boolean sellerNoEquals(String interlockSellerNo) {
        return StringUtil.equals(interlockSellerNo, this.interlockSellerNo);
    }

    @Override
    public void createTokenCookie(String key, String value) {
        Cookie tokenCookie = new Cookie(key, value);
        tokenCookie.setMaxAge(60*60);
    }

    @Override
    public String getTokenCookie(String key){
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
        Cookie[] cookies = request.getCookies();
        String token = "";
        if(cookies != null && cookies.length > 0){
            for(Cookie cookie : cookies){
                if(StringUtil.equals(cookie.getName(), key)){
                    token = cookie.getValue();
                    break;
                }
            }
        }
        return token;
    }

    /**
     * accessToken 및 네이버 사용자 정보를 받음
     */
    @Override
    public Map<String, String> getNaverUserProfile(String code) {

        String storedState = naverLoginUtil.getSESSION_STATE();

        /* ============================================================
             * code을 이용하여 네이버 Access Token 받기
        ==============================================================*/
        OAuth2AccessToken accessToken = naverLoginUtil.getAccessToken(null, code, storedState, null);

        /* ============================================================
             * Access Token을 이용하여 네이버 사용자 프로필 API를 호출
         ==============================================================*/
        return naverLoginUtil.getUserProfile(accessToken);
    }

    /**
     * [=== NIF-0001 ===] : AboutPet ==> Naver
     * N-네이버회원정보 조회 API
     */
    @Override
    public NaverApiVO getNif0001(String token) {

        NaverApiVO vo = new NaverApiVO();

        /* REQUEST INFO*/
        Map<String, Object> requestParam = new HashMap<>();
        requestParam.put(NaverApiSendUtil.TOKEN, token);

        vo.setTargetUrl(this.nif0001Url);
        vo.setHttpMethod(HttpMethod.GET);
        vo.setHeaderContentType(this.applicationJson);
        vo.setHeaderApiKey(this.apiKey);
        vo.setRequestParamByGet(requestParam);

        ObjectMapper mapper = new ObjectMapper();
        JsonNode jsonNode = null;

        try {

            ResponseEntity<String> result = naverApiSendUtil.getApiResponse(vo);
            jsonNode = mapper.readTree(result.getBody());

            if(result.getStatusCode().equals(HttpStatus.OK) ){

                if(jsonNode.has(NaverApiSendUtil.OPERATION_RESULT)){
                    // SET 실행결과
                    vo.setOperationResult(jsonNode.get(NaverApiSendUtil.OPERATION_RESULT).getTextValue());

                    if(StringUtil.equals(vo.getOperationResult(), NaverApiSendUtil.API_SUCCESS)){

                        if(jsonNode.has(NaverApiSendUtil.CONTENTS)){
                            JsonNode contents = jsonNode.get(NaverApiSendUtil.CONTENTS);
                            // SET 네이버회원식별번호
                            vo.setInterlockMemberIdNo(contents.get(NaverApiSendUtil.INTERLOCK_MEMBER_ID_NO).getTextValue());
                            // SET 제휴사연동스토어(브랜드)번호 ( = 셀러(계정)을 인증 UUID  = store 인가용 key)
                            vo.setInterlockSellerNo(contents.get(NaverApiSendUtil.INTERLOCK_SELLER_NO).getTextValue());
                            vo.setHeaderAffiliateSellerKey(contents.get(NaverApiSendUtil.INTERLOCK_SELLER_NO).getTextValue());
                        }
                    }else{
                        // response operationResult : FAIL
                        log.error("==> [ERROR]  NIF0001 response operationResult : FAIL");
                        getErrorResult(mapper.readTree(result.getBody()));
                    }
                }

            }else{
                log.error("==> [ERROR]  NIF0001 response  STATUS : {}", result.getStatusCode() );
                getErrorResult(mapper.readTree(result.getBody()));
            }

        }catch(HttpStatusCodeException e){
            String error = e.getResponseBodyAsString();
            log.error("==> [ERROR]  NIF0001 API  : {}", error );
        }catch (IOException ie){
            log.error("==> [ERROR]  NIF0001 response  : {}", ie.getMessage() );
        }

        return vo;
    }

    /**
     * [=== NIF-0002 ===] : AboutPet ==> Naver
     * N-제휴회원연동 매핑요청 API
     */
    @Override
    public NaverApiVO getNif0002(NaverApiVO naVo) {
        NaverApiVO vo = new NaverApiVO();

        /* REQUEST INFO*/
        Map<String, Object> requestParam = new HashMap<>();
        requestParam.put(NaverApiSendUtil.TOKEN, naVo.getToken());
        requestParam.put(NaverApiSendUtil.AFFILIATE_MEMBER_ID_NO, naVo.getAffiliateMemberIdNo());

        vo.setTargetUrl(this.nif0002Url);
        vo.setHttpMethod(HttpMethod.POST);
        vo.setHeaderContentType(this.applicationJson);
        vo.setHeaderApiKey(this.apiKey);
        vo.setHeaderAffiliateSellerKey(this.interlockSellerNo);
        vo.setRequestParamByPost(requestParam);

        ObjectMapper mapper = new ObjectMapper();

        try{
            ResponseEntity<String> result = naverApiSendUtil.getApiResponse(vo);
            JsonNode jsonNode = mapper.readTree(result.getBody());

            if(jsonNode.has(NaverApiSendUtil.OPERATION_RESULT)){
                // SET 실행결과
                vo.setOperationResult(jsonNode.get(NaverApiSendUtil.OPERATION_RESULT).getTextValue());

                if(StringUtil.equals(vo.getOperationResult(), NaverApiSendUtil.API_SUCCESS)){
                    // 성공
                    log.error("==>  NIF-0002 제휴회원연동 매핑요청 API 성공 - 종료");
                }else{
                    log.error("==> [ERROR]  NIF0002 response operationResult : FAIL");
                    getErrorResult(mapper.readTree(result.getBody()));
                }
            }

        }catch (HttpStatusCodeException e){
            String error = e.getResponseBodyAsString();
            log.error("==> [ERROR]  NIF0002 API  : {}", error );
        } catch (IOException ioe) {
            log.error("==> [ERROR]  NIF0002 response  : {}", ioe.getMessage() );
        }
        return vo;
    }

    /**
     * [=== NIF-0003 ===] : AboutPet ==> Naver
     * N-제휴회원연동 매핑조회 API
     */
    @Override
    public NaverApiVO getNif0003(NaverApiVO naVo) {

        NaverApiVO vo = new NaverApiVO();

        /* REQUEST INFO*/
        Map<String, Object> requestParam = new HashMap<>();
        requestParam.put(NaverApiSendUtil.INTERLOCK_MEMBER_ID_NO, naVo.getInterlockMemberIdNo()); // 네이버페이회원식별번호
        requestParam.put(NaverApiSendUtil.AFFILIATE_MEMBER_ID_NO, naVo.getAffiliateMemberIdNo()); // 제휴사회원식별번호

        vo.setTargetUrl(this.nif0003Url);
        vo.setHttpMethod(HttpMethod.GET);
        vo.setHeaderContentType(this.applicationJson);
        vo.setHeaderApiKey(this.apiKey);
        vo.setHeaderAffiliateSellerKey(this.interlockSellerNo);
        vo.setRequestParamByPost(requestParam);

        ResponseEntity<String> result = null;
        ObjectMapper mapper = new ObjectMapper();
        JsonNode jsonNode = null;

        try{
            result = naverApiSendUtil.getApiResponse(vo);
        }catch(HttpStatusCodeException e){
            String error = e.getResponseBodyAsString();
            log.info("==> error : {}", error);
        }

        try {
            jsonNode = mapper.readTree(Objects.requireNonNull(result).getBody());
            if(jsonNode.has(NaverApiSendUtil.OPERATION_RESULT)){
                // SET 실행결과
                vo.setOperationResult(jsonNode.get(NaverApiSendUtil.OPERATION_RESULT).getTextValue());

                if(StringUtil.equals(vo.getOperationResult(), NaverApiSendUtil.API_SUCCESS)){
                    // 성공
                    if(jsonNode.has(NaverApiSendUtil.CONTENTS)){
                        JsonNode contents = jsonNode.get(NaverApiSendUtil.CONTENTS);

                        boolean interlock = contents.get("interlock").getValueAsBoolean();

                        if(interlock){
                            log.info("==>  NIF-0003 N-제휴회원연동 매핑조회 API 성공 - 연동중인상태");
                        }else{
                            log.info("==>  연동이해제되거나 연동되지 않은상태");
                        }
                    }
                }else{
                    log.info("==>  NIF-0003 N-제휴회원연동 매핑조회 API 실패 - 종료");
                }
            }
        } catch (IOException e) {
            log.error("==> [ERROR]  NIF0003 response  : {}", e.getMessage() );
        }

        return vo;
    }

    /**
     * [=== NIF-0004 ===] : AboutPet ==> Naver
     * N-제휴회원연동 매핑삭제 API
     *   ( AboutPet ==> Naver )
     */
    @Override
    public NaverApiVO getNif0004(NaverApiVO naVo) {

        NaverApiVO vo = new NaverApiVO();

        /* REQUEST INFO*/
        Map<String, Object> requestParam = new HashMap<>();
        requestParam.put(NaverApiSendUtil.INTERLOCK_MEMBER_ID_NO, naVo.getInterlockMemberIdNo()); // 네이버페이회원식별번호
        requestParam.put(NaverApiSendUtil.AFFILIATE_MEMBER_ID_NO, naVo.getAffiliateMemberIdNo()); // 제휴사회원식별번호

        vo.setTargetUrl(this.nif0004Url);
        vo.setHttpMethod(HttpMethod.POST);
        vo.setHeaderContentType(this.applicationJson);
        vo.setHeaderApiKey(this.apiKey);
        vo.setHeaderAffiliateSellerKey(this.interlockSellerNo);
        vo.setRequestParamByPost(requestParam);

        ResponseEntity<String> result = null;
        ObjectMapper mapper = new ObjectMapper();
        JsonNode jsonNode = null;

        try{
            result = naverApiSendUtil.getApiResponse(vo);
        }catch(HttpStatusCodeException e){
            String error = e.getResponseBodyAsString();
            log.info("==> error : {}", error);
        }

        try {
            jsonNode = mapper.readTree(Objects.requireNonNull(result).getBody());
            if(jsonNode.has(NaverApiSendUtil.OPERATION_RESULT)){
                // SET 실행결과
                vo.setOperationResult(jsonNode.get(NaverApiSendUtil.OPERATION_RESULT).getTextValue());

                if(StringUtil.equals(vo.getOperationResult(), NaverApiSendUtil.API_SUCCESS)){
                    // 성공
                    log.info("==>  NIF-0004 N-제휴회원연동 매핑삭제 API 성공 - 종료");
                }else{
                    log.info("==>  NIF-0004 N-제휴회원연동 매핑삭제 API 실패 - 종료");
                }
            }
        } catch (IOException e) {
            log.error("==> [ERROR]  NIF0004 response  : {}", e.getMessage() );
        }

        return vo;
    }

    /**
     * [=== NIF-0005 ===] : AboutPet ==> Naver
     * N-제휴회원연동완료 callback 웹페이지 API
     *   ( AboutPet ==> Naver )
     */
    @Override
    public NaverApiVO getNif0005(NaverApiVO naVo) {
        NaverApiVO vo = new NaverApiVO();
        /* REQUEST INFO*/
        Map<String, Object> requestParam = new HashMap<>();
        requestParam.put(NaverApiSendUtil.TOKEN, naVo.getToken());
        requestParam.put(NaverApiSendUtil.INTERLOCK_SELLER_NO, naVo.getInterlockSellerNo());

        vo.setTargetUrl(this.nif0005Url);
        vo.setHttpMethod(HttpMethod.GET);
        vo.setHeaderContentType(this.applicationJson);
        vo.setRequestParamByGet(requestParam);
        naverApiSendUtil.getApiResponse(vo);
        return vo;
    }

    /**
     * 네이버 펫윈도 펫정보 요청
     */
    @Override
    public void getPartnerPetInfo(NaverApiVO vo) throws Exception {

        String petInfoUrl = this.petwindoUrl;

        String queryString = "?affiliateMemberIdNo="+vo.getAffiliateMemberIdNo()+"&interlockMemberIdNo="+vo.getInterlockMemberIdNo()+"&interlockSellerNo="+vo.getInterlockSellerNo();

        petInfoUrl = petInfoUrl + queryString;

        // initialize MACManager. 어플리케이션 로딩 시 한번만 호출한다.
        MACManager.initialize(Type.FILE, "/NHNAPIGatewayKey.properties");

            /*
             APIGW서버시간과 어플리케이션 로컬시간의 차이를 보정해준다.(필수X) 어플리케이션 로딩 시 한번만 호출한다. 또는 025에러발생시 호출해준다.
             파라미터는 각각 connectionTimeoutMs, readTimeoutMs 값이다. 생략하면 디폴트값 30초 세팅.
             */
        Future<Long> future = MACManager.syncWithServerTimeByHttpAsync(30000, 30000);

        if(future != null){
            future.get(); // 위 syncWithServerTimeByHttpAsync 비동기 API 결과를 기달린다.(blocking 됨)
        }

        // syncWithServerTimeByHttpAsync 메소드 실행과 실제 getEncryptUrl 메소드 실행간에 간격이 어느 정도 있을 경우 위 future.get() 동기화 메소드 생략 가능하다.
        // Generate Encrypted url
        String encryptedUrl = MACManager.getEncryptUrl(petInfoUrl);

        // for Apache HTTP client.
        HttpClient client = new HttpClient();
        org.apache.commons.httpclient.HttpMethod method = new GetMethod(encryptedUrl);

        // call api of NAVER api-gateway
        client.executeMethod(method);

        log.info("==> method.getResponseBodyAsString() : {}", method.getResponseBodyAsString());

        ObjectMapper mapper = new ObjectMapper();
        JsonNode jsonNode = mapper.readTree(method.getResponseBodyAsString());
        ArrayNode arrayNode = (ArrayNode) jsonNode;

        if(arrayNode != null && arrayNode.size()>0){
            for(JsonNode jn : arrayNode){

                MemberPetVO mpVo = new MemberPetVO();

                mpVo.setMbrNo(Long.parseLong(vo.getAffiliateMemberIdNo()));
                mpVo.setPartnerCd("10");
                mpVo.setName(jn.get("name").getTextValue());
                mpVo.setType(StringUtil.equals(jn.get("type").getTextValue(),"DOG") ? "10" : "20");
                mpVo.setBreedName(jn.get("breedName").getTextValue());
                mpVo.setBirthday(jn.get("birthday").getTextValue());
                mpVo.setGender(StringUtil.equals(jn.get("gender").getTextValue(), "M") ? "10" : "20");
                mpVo.setImageUrl(jn.get("imageUrl").getTextValue());
                mpVo.setNeutralized((jn.get("neutralized").getBooleanValue()) ? "Y" : "N" );
                mpVo.setWeight(jn.get("weight").getDoubleValue());
                mpVo.setCreatedAt(jn.get("createdAt").getTextValue());
                mpVo.setUpdatedAt(jn.get("updatedAt").getTextValue());

                ArrayNode allergies = jn.has("allergies") ? (ArrayNode) jn.get("allergies") : null;
                ArrayNode features = (ArrayNode) jn.get("features");

                mpVo.setAllergyYn(allergies.size() > 0 ?" Y" : "N");
                mpVo.setWryDaYn(features.size() > 0 ?" Y" : "N");

                // pet_base_partner 등록
                int petBaseCnt = memberBaseDao.insertPetBasePartner(mpVo);
                log.info("==> insert petNo : {}", mpVo.getPetNo());

                if(petBaseCnt > 0 && mpVo.getPetNo() > 0){

                    List<MemberPetSubVO> allergieList = new ArrayList<>();
                    List<MemberPetSubVO> featureList = new ArrayList<>();

                    //List<String> tmpAallergies = new ArrayList<>();
                    //List<String> tmpFeatureList = new ArrayList<>();

                    // ============================================================================
                    if(features != null && features.size()>0){
                        for(JsonNode fe : features){
                            MemberPetSubVO po = new MemberPetSubVO();
                            po.setPetNo(mpVo.getPetNo());
                            po.setDaGbCd("10");
                            po.setDaCd(fe.get("id").getTextValue());
                            po.setDaCdNm(fe.get("name").getTextValue());
                            po.setSysRegrNo(Long.parseLong(vo.getAffiliateMemberIdNo()));
                            featureList.add(po);
                            //tmpFeatureList.add(fe.get("id").getTextValue());
                        }
                        // pet_da_partner 등록 (질환)
                        memberBaseDao.insertPetDaPartner(featureList);
                    }

                    // ============================================================================
                    if(allergies != null && allergies.size()>0){
                        for(JsonNode al : allergies){
                            MemberPetSubVO po = new MemberPetSubVO();
                            po.setPetNo(mpVo.getPetNo());
                            po.setDaGbCd("20");
                            po.setDaCd(al.get("id").getTextValue());
                            po.setDaCdNm(al.get("name").getTextValue());
                            po.setSysRegrNo(Long.parseLong(vo.getAffiliateMemberIdNo()));
                            allergieList.add(po);
                            //tmpAallergies.add(al.get("id").getTextValue());
                        }
                        // pet_da_partner 등록 (알러지)
                        memberBaseDao.insertPetDaPartner(allergieList);
                    }

                    // ============================================================================
                    // 등록된 펫 정보가 없을 경우 펫윈도에서 받은 정보를 등록해준다.
                    if(memberBaseDao.getMemberPetHasCnt(vo) == 0){
                        PetBasePO po = new PetBasePO();
                        PetDaPO daPo = new PetDaPO();

                        po.setMbrNo(mpVo.getMbrNo());
                        po.setImgPath("");
                        po.setPetGbCd(mpVo.getType()); // 고양이 / 개
                        po.setPetKindNm(mpVo.getBreedName()); // 품종명
                        po.setPetNm(mpVo.getName()); // 펫 이름
                        po.setPetGdGbCd(mpVo.getGender()); // 성별
                        po.setBirth(mpVo.getBirthday()); // 생일
                        po.setWeight(mpVo.getWeight()); // 몸무게
                        po.setAllergyYn(allergies.size() > 0 ?" Y" : "N"); // 알러지여부
                        po.setFixingYn(mpVo.getNeutralized()); // 중성화여부
                        po.setWryDaYn(features.size() > 0 ?" Y" : "N"); // 염려질환 여부

                        /*
                        네이버 펫윈도 와 어바웃펫의 질환 및 알러지에 대한 코드 매핑이 되어 있지 않아 저장로직 보류
                        daPo.setAllergyCds(tmpAallergies.toArray(new String[allergieList.size()])); // 펫 알러지
                        daPo.setWryDaCds(tmpFeatureList.toArray(new String[featureList.size()])); // 펫 염려질환
                        */

                        petService.insertPet(po, daPo, "PC");
                    }
                }
            }
        }
    }


    @Override
    public boolean checkInterlock(NaverApiVO vo) {

        boolean result = false;

        HashMap<String, Object> resultMap = memberBaseDao.checkInterlock(vo);

        if(resultMap != null){
            // print log
            naverApiSendUtil.printLog(resultMap);

            Long mbrNo = 0L;
            String snsUuid = "";
            Long intlkNo = 0L;

            try{
                mbrNo = Long.valueOf ((Integer)resultMap.get("mbrNo"));
                snsUuid = (String) resultMap.get("snsUuid");
                intlkNo = Long.valueOf ((Integer)resultMap.get("intlkNo"));
            }catch (NullPointerException ne){
                log.error("==> [ERROR]   : {}", ne.getMessage());
            }

            if(StringUtil.equals("update", vo.getWorkType())){
                /*
                    회원연동 시
                    MEMBER_BASE, SNS_MEMBER_INFO, MEMBER_PRTN_INTLK 를 확인 하여
                    모두 데이터가 존재하면 true
                    MEMBER_BASE, SNS_MEMBER_INFO 에 존재하지만
                    MEMBER_PRTN_INTLK 에 데이터가 없으면 해당 테이블만 추가해주고  true 를 반환한다.
                 */
                if(mbrNo > 0 && snsUuid != null && !StringUtil.equals("", snsUuid)){ // SNS_MEMBER_INFO에 존재
                    result = true;
                    if(intlkNo == 0){ // MEMBER_PRTN_INTLK에 없으면 추가 저장
                        vo.setMbrNo(mbrNo);
                        vo.setPetPrtnCd("10");
                        vo.setStatus("U"); // 회원연동 이전에 SNS가입으로 SNS_MEMBER_INFO 가 존재했던 회원
                        memberBaseDao.insertMemberPrtnIntlk(vo);
                    }
                }
            }else{
                /*
                    회원 매핑 조회 시
                    MEMBER_BASE, SNS_MEMBER_INFO, MEMBER_PRTN_INTLK 를 확인 하여
                    모두 데이터가 존재하면 true
                    아니면 false 반환
                 */
                if(mbrNo > 0 && snsUuid != null && !StringUtil.equals("", snsUuid) && intlkNo > 0){ // sns_member_info에 존재 , member_prtn_intlk에 존재
                    result = true;
                }
            }
        }
        return result;
    }

    @Override
    public MemberBasePO insertInterlockMember(Map<String, String> userMap, String[] provisionIds, String[] optionIds) {

        MemberBasePO po = new MemberBasePO();
        SnsMemberInfoPO snsPo = new SnsMemberInfoPO();

        String naverTerms = bizConfig.getProperty("naver.interlock.api.terms");
        String[] naverTermArr = naverTerms.split("/");

        /*
            약관 동의 처리
            response 중 provisionIds, optionIds 에 포함된 항목은 Y로 나머지는 N으로 저장
         */
        JSONArray termsNoJsonArr = new JSONArray();
        TermsSO termsSO = new TermsSO();
        termsSO.setPocGbCd("10");
        List<TermsVO> termList = termsDao.listTermsForMemberJoin(termsSO);

        if(termList != null && !termList.isEmpty()
                && provisionIds != null && provisionIds.length > 0){

            for(String nTerms : naverTermArr){
                String agreeYn = "N";
                Long no = 0L;
                String[] terms = nTerms.split(",");

                for(TermsVO termsVO : termList){
                    if(StringUtil.equals(terms[0], termsVO.getTermsCd())){
                        no = termsVO.getTermsNo();
                        break;
                    }
                }

                for(String term : provisionIds){
                    if(StringUtil.equals(term, terms[1])){
                        agreeYn = "Y";
                        break;
                    }
                }

                if(no > 0){
                    JSONObject obj = new JSONObject();
                    obj.put("termsNo", no);
                    obj.put("rcvYn", agreeYn);
                    termsNoJsonArr.add(obj);

                }

                log.debug("==> termsCd : {} / termsNo : {} / agreeYn : {} / param : {}", terms[0], no, agreeYn, terms[1]);
            }
        }

        log.debug("==> termsNoJsonArr.toJSONString() : "+termsNoJsonArr.toJSONString());

        // 회원가입 (member_base)
        po.setMbrNm(userMap.get("name")); // 성명
        po.setEmail(userMap.get("email")); // 이메일
        po.setMobile(userMap.get("mobile")); // 핸드폰 번호
        po.setTermsNo(termsNoJsonArr.toJSONString()); // 이용약관 (type json string)
        po.setJoinEnvCd(CommonConstants.JOIN_ENV_WEB_PC);
        MemberAddressPO apo = new MemberAddressPO();
        po = this.memberService.insertMember(po, apo, "40"); // joinPathCd 네이버 40

        if(po != null && po.getMbrNo() > 0){
            /* ########### 회원기본이력 등록 ############ */
            po.setUpdrIp(bizService.twoWayEncrypt(RequestUtil.getClientIp()));
            memberBaseDao.insertMemberBaseHistory(po);

            /* ########### SNS 정보 등록 ##############*/
            snsPo.setSnsUuid(userMap.get("uuid"));
            snsPo.setMbrNo(po.getMbrNo());
            snsPo.setEmail(userMap.get("email"));
            snsPo.setSnsLnkCd(CommonConstants.SNS_LNK_CD_10);
            snsPo.setSnsStatCd(CommonConstants.SNS_STAT_10);
            snsPo.setSnsJoinYn(CommonConstants.COMM_YN_Y);
            memberBaseDao.upSertSnsMemberInfo(snsPo);

            /* ########### 회원 회원사 연동 (TABLE : MEMBER_PRTN_INTLK ) ##########*/
            NaverApiVO vo = new NaverApiVO();
            vo.setPetPrtnCd("10");// 네이버
            vo.setMbrNo(po.getMbrNo()); // 회원번호
            vo.setInterlockMemberIdNo(userMap.get("intlkId")); // Npay회원번호
            vo.setCiCtfVal(userMap.get("ciCtfVal")); // ci
            vo.setStatus("I"); // 회원연동으로 SNS_MEMBER_INFO 도 신규 추가된 경우
            memberBaseDao.insertMemberPrtnIntlk(vo);

        }

        return po;
    }

    @Override
    public boolean deleteInterlock(NaverApiVO vo){

        vo.setSnsLnkCd("10");
        HashMap<String, Object> resultMap = memberBaseDao.checkInterlock(vo);

        Long mbrNo = 0L;
        String snsUuid = "";
        Long intlkNo = 0L;
        String status = "";

        try{
            mbrNo = Long.valueOf ((Integer)resultMap.get("mbrNo"));
        }catch (NullPointerException ne){
            log.error("==> [ERROR]   : {}", ne.getMessage());
        }

        try{
            snsUuid = (String) resultMap.get("snsUuid");
        }catch (NullPointerException ne1){
            log.error("==> [ERROR]   : {}", ne1.getMessage());
        }

        try{
            intlkNo = Long.valueOf ((Integer)resultMap.get("intlkNo"));
        }catch (NullPointerException ne3){
            log.error("==> [ERROR]   : {}", ne3.getMessage());
        }

        try{
            status = (String) resultMap.get("status");
        }catch (NullPointerException ne3){
            log.error("==> [ERROR]   : {}", ne3.getMessage());
        }


        vo.setMbrNo(mbrNo);
        vo.setSnsUuid(snsUuid);
        vo.setIntlkNo(intlkNo);
        if(StringUtil.equals("U", status)){
            // 기존 SNS 가입 시 정보 외 회원연동 결과 테이블만 삭제
            if(memberBaseDao.deleteMemberPrtnIntlk(vo) == 0) return false;

        }else{
            if(memberBaseDao.deleteInterlockSnsMemberInfo(vo) == 0) return false;

            if(memberBaseDao.deleteMemberPrtnIntlk(vo) == 0) return false;
        }

        return true;

    }

    @Override
    public List<Map<String, Object>> listPetBaseByPartner(PetBaseSO so) {
        return Optional.ofNullable(memberBaseDao.listPetBaseByPartner(so)).orElseGet(ArrayList::new);
    }

    @Override
    public List<Map<String, Object>> listPetBaseByPartner(NaverApiVO vo) {

        List<Map<String, Object>> petList = new ArrayList<>();

        // 반려동물 정보
        PetBaseSO so = new PetBaseSO();
        so.setMbrNo(vo.getMbrNo());

        List<PetBaseVO> aboutPetList;

        if(StringUtil.equals(vo.getSiteGb(), "1")){
            // 어바웃펫 등록 펫정보
            aboutPetList = petService.listPetBase(so);

            for(PetBaseVO petBaseVO : aboutPetList){
                Map<String, Object> tmpMap = new HashMap<>();
                tmpMap.put("petNo", petBaseVO.getPetNo());
                tmpMap.put("petNm", petBaseVO.getPetNm());
                tmpMap.put("petGbCd", petBaseVO.getPetGbCd());
                tmpMap.put("petGbCdNm", petBaseVO.getPetGbCdNm());
                petList.add(tmpMap);
            }

        }else{
            // 네이버연동 회원 펫윈도 펫정보
            petList = listPetBaseByPartner(so);
        }

        return petList;
    }

    private void getErrorResult(JsonNode jsonNode){

        final String MESSAGE = "message";

        if(jsonNode.has("code") && jsonNode.has(MESSAGE)){
            log.error("==> [ERROR] HttpStatus : {}", jsonNode.get("HttpStatus"));
            log.error("==> [ERROR] code : {}", jsonNode.get("code"));
            log.error("==> [ERROR] message : {}", jsonNode.get(MESSAGE));
            log.error("==> [ERROR] timestamp : {}", jsonNode.get("timestamp"));
            log.error("==> [ERROR] traceId : {}", jsonNode.get("traceId"));

            JsonNode invalidInputs = jsonNode.get("invalidInputs");

            log.error("==> [ERROR] invalidInputs.type : {}", invalidInputs.get("type"));
            log.error("==> [ERROR] invalidInputs.name : {}", invalidInputs.get("name"));
            log.error("==> [ERROR] invalidInputs.message : {}", invalidInputs.get(MESSAGE));
        }

    }

}
