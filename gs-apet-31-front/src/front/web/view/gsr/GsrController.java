package front.web.view.gsr;

import biz.app.member.dao.MemberBaseDao;
import biz.app.member.model.*;
import biz.app.member.service.MemberService;
import biz.app.system.model.CodeDetailVO;
import biz.common.service.BizService;
import biz.common.service.CacheService;
import biz.interfaces.gsr.dao.GsrLogDao;
import biz.interfaces.gsr.model.GsrMemberPointPO;
import biz.interfaces.gsr.model.GsrMemberPointSO;
import biz.interfaces.gsr.model.GsrMemberPointVO;
import biz.interfaces.gsr.service.GsrService;
import framework.common.annotation.LoginCheck;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import framework.common.util.RequestUtil;
import framework.common.util.StringUtil;
import framework.front.constants.FrontConstants;
import framework.front.model.Session;
import framework.front.util.FrontSessionUtil;
import front.web.config.constants.FrontWebConstants;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import java.util.*;

@Slf4j
@Controller
@RequestMapping("gsr/")
public class GsrController {
    @Autowired
    private GsrService gsrService;

    @Autowired
    private CacheService cacheService;

    @Autowired
    private MemberService memberService;

    @Autowired
    private BizService bizService;

    @Inject
    private GsrLogDao gsrLogDao;

    @Inject
    private MemberBaseDao memberBaseDao;

    @Autowired	private Properties bizConfig;

    @RequestMapping(value="indexGsrTest/")
    public String gsrPointTest(HttpServletRequest req){
        if (StringUtil.equals(bizConfig.getProperty("envmt.gb"), FrontConstants.ENVIRONMENT_GB_OPER)) {
            String clientIp = RequestUtil.getClientIp();
            CodeDetailVO allowList = cacheService.getCodeCache(CommonConstants.IP_ALLOW_LIST, CommonConstants.IP_ALLOW_LIST_10);
            if(allowList.getUsrDfn1Val().indexOf(clientIp) == -1){
                return FrontWebConstants.EXCEPTION_VIEW_NAME;
            }
        }
        return "sample/indexGsrTest";
    }

    private Object getDecrypt(String target){
        if(StringUtil.isEmpty(target)){
            return target;
        }
        return bizService.twoWayDecrypt(target);
    }

    /**
     * <pre>
     * - 프로젝트명	: 31.front.web
     * - 파일명	: GsrController.java
     * - 작성일	: 2021. 01. 14.
     * - 작성자	: 김재윤
     * - 설명		:  회원 등록
     * </pre>
     * @param
     * @param
     * @return
     */
    @ResponseBody
    @RequestMapping(value="joinToGsr")
    public MemberBaseVO joinToGsr(MemberBasePO po){
        String mbrNm = po.getMbrNm();
        String mobile = po.getMobile();
        String birth = po.getBirth();

        String encMbrNm = bizService.twoWayEncrypt(mbrNm);
        String encMobile = bizService.twoWayEncrypt(mobile);
        String encBirth= bizService.twoWayEncrypt(birth);

        po.setMbrNm(encMbrNm);
        po.setMobile(encMobile);
        po.setBirth(encBirth);

        return gsrService.saveGsrMember(po);
    }

    /**
     * <pre>
     * - 프로젝트명	: 31.front.web
     * - 파일명	: GsrController.java
     * - 작성일	: 2021. 01. 14.
     * - 작성자	: 김재윤
     * - 설명		:  [본인 인증]회원 가입 가능 여부 및 수정
     * </pre>
     * @param
     * @param
     * @return
     */
    @ResponseBody
    @RequestMapping(value="isGsrJoin")
    public Map<String,String> isGsrJoin(MemberBasePO po){
        return gsrService.checkJoin(po);
    }

    @ResponseBody
    @RequestMapping(value="useGsPoint")
    public GsrMemberPointVO useGsPoint(GsrMemberPointPO po){
        return gsrService.useGsPoint(po);
    }
    @ResponseBody
    @RequestMapping(value="useCancelGsPoint")
    public GsrMemberPointVO useCancelGsPoint(GsrMemberPointPO po){
        return gsrService.useCancelGsPoint(po);
    }
    @ResponseBody
    @RequestMapping(value="accumGsPoint")
    public GsrMemberPointVO accumGsPoint(GsrMemberPointPO po){
        return gsrService.accumGsPoint(po);
    }
    @ResponseBody
    @RequestMapping(value="accumCancelGsPoint")
    public GsrMemberPointVO accumCancelGsPoint(GsrMemberPointPO po){
        return gsrService.accumCancelGsPoint(po);
    }

    @LoginCheck
    @ResponseBody
    @RequestMapping(value="updateGsrConnectInfo")
    public MemberBaseVO renewal(MemberBasePO po){
        Session session = FrontSessionUtil.getSession();
        Long mbrNo = session.getMbrNo();

        log.error("##### Check Session Value #####");
        log.error("##### mbrNo : {} #####",session.getMbrNo());
        log.error("##### LoginId : {} #####",session.getLoginId());

        String decLoginId = Optional.ofNullable(session.getLoginId()).orElseGet(()->"");
        if(StringUtil.isNotEmpty(decLoginId)){
            String loginId = bizService.twoWayEncrypt(decLoginId);
            po.setLoginId(loginId);
        }

        String decBirth = po.getBirth();
        String decMbrNm = po.getMbrNm();
        String decMobile = po.getMobile();

        String birth = bizService.twoWayEncrypt(decBirth);
        String mbrNm = bizService.twoWayEncrypt(decMbrNm);
        String mobile = bizService.twoWayEncrypt(decMobile);

        po.setMbrNo(mbrNo);
        po.setBirth(birth);
        po.setMbrNm(mbrNm);
        po.setMobile(mobile);

        //GS 정보 update -> GS 실패 하더라도, KCB 정보로 업데이트
        MemberBaseVO v = new MemberBaseVO();
        v = gsrService.saveGsrMember(po);
        //session 값 소실, 식별 불가일 때 return
        if(StringUtil.equals(Optional.ofNullable(v.getResultCode()).orElseGet(()->""),ExceptionConstants.ERROR_CODE_LOGIN_REQUIRED)){
            return v;
        }
        session.setGsptNo(v.getGsptNo());
        session.setCertifyYn(CommonConstants.COMM_YN_Y);
        FrontSessionUtil.setSession(session);

        //본인 인증 후, 핸드폰 번호로 080 시스템 동기화
        String mkngRcvYn = po.getMkngRcvYn();
        memberService.updateMemberMarketingAgree(mkngRcvYn,decMobile,CommonConstants.CHG_ACTR_MBR);

        //인증 로그 insert
        MemberCertifiedLogPO certpo = new MemberCertifiedLogPO();
        Long ctfLogNo = bizService.getSequence(CommonConstants.SEQUENCE_MEMBER_CERTIFIED_LOG_SEQ);
        certpo.setCtfLogNo(ctfLogNo);
        certpo.setCtfMtdCd(FrontConstants.CTF_MTD_MOBILE);
        certpo.setCtfTpCd(FrontConstants.CTF_TP_GSR_POINT);
        certpo.setCtfRstCd(FrontConstants.CERT_OK);
        certpo.setCiCtfVal(po.getCiCtfVal());
        certpo.setDiCtfVal(po.getDiCtfVal());
        certpo.setMbrNo(mbrNo);
        certpo.setSysRegrNo(mbrNo);
        memberService.insertCertifiedLog(certpo);

        return v;
    }

    /**
     * <pre>
     * - 프로젝트명	: 31.front.web
     * - 파일명	: GsrController.java
     * - 작성일	: 2021. 01. 14.
     * - 작성자	: 김재윤
     * - 설명		:  고객 포인트 조회
     * </pre>
     * @param
     * @param
     * @return
     */
    @ResponseBody
    @RequestMapping(value="getGsrMemberPoint")
    public GsrMemberPointVO getGsrMemberPoint(GsrMemberPointSO so){
        Long mbrNo = Optional.ofNullable(so.getMbrNo()).orElseGet(()->FrontSessionUtil.getSession().getMbrNo());
        String custNo = Optional.ofNullable(so.getCustNo()).orElseGet(()->FrontSessionUtil.getSession().getGsptNo());
        if(StringUtil.isEmpty(custNo) && Long.compare(mbrNo,CommonConstants.NO_MEMBER_NO) == 0){
            throw new CustomException(ExceptionConstants.ERROR_CODE_LOGIN_REQUIRED);
        }
        so.setCustNo(custNo);
        so.setMbrNo(mbrNo);
        return gsrService.getGsrMemberPoint(so);
    }

    /**
     * <pre>
     * - 프로젝트명	: 31.front.web
     * - 파일명	: GsrController.java
     * - 작성일	: 2021. 01. 14.
     * - 작성자	: 김재윤
     * - 설명		:  고객 카드포인트 상세 조회
     * </pre>
     * @param
     * @param
     * @return
     */
    @ResponseBody
    @RequestMapping(value="getGsrMemberCardPointInfo")
    public MemberSavedMoneyVO getGsrMemberPointCardDetailInfo(Long mbrNo){
        MemberSavedMoneyVO result = new MemberSavedMoneyVO();
        return result;
    }

    /****** 데이터 보정 건 **/

    @ResponseBody
    @RequestMapping(value="correction")
    public Object correction(String gsptNos) throws Exception{

        Map<String, List<String>> result = new HashMap<String,List<String>>();
        String[] arr = gsptNos.split(",");
        List<String> man = new ArrayList<String>();
        List<String> woman = new ArrayList<String>();
        for(String gsptNo : arr){
            MemberBaseSO so = new MemberBaseSO();
            so.setGsptNo(gsptNo);
            MemberBaseVO gs = gsrService.getGsrMemberBase(so);

            if(StringUtil.equals(gs.getGdGbCd(),CommonConstants.GD_GB_1)){
                man.add(gsptNo);
            }
            if(StringUtil.equals(gs.getGdGbCd(),CommonConstants.GD_GB_0)){
                woman.add(gsptNo);
            }
        }

        result.put("man",man);
        result.put("woman",woman);

        return result;
    }

    @ResponseBody
    @RequestMapping(value="check")
    public Object check() throws Exception{
        return gsrLogDao.listCheckMember();
    }

    @ResponseBody
    @RequestMapping(value="getMemberBase")
    public Map geteMemberBase(MemberBaseSO so){
        Map<String,Object> resultMap = new HashMap<String,Object>();
        if(Long.compare(Optional.ofNullable(so.getMbrNo()).orElseGet(()->0L),0L)!=0){
            MemberBaseVO vo = memberService.getMemberBase(so);
            Map<String,Object> memberBaseMap = new HashMap<String,Object>();

            Long mbrNo = vo.getMbrNo();
            String gsptNo = Optional.ofNullable(vo.getGsptNo()).orElseGet(()->"");
            String mbrNm = (String)getDecrypt(vo.getMbrNm());
            String birth = (String)getDecrypt(vo.getBirth());
            String mobile = (String)getDecrypt(vo.getMobile());
            String mobileCd = vo.getMobileCd();
            String ciCtfVal = vo.getCiCtfVal();
            String gdGbCd = vo.getGdGbCd();
            String mbrGbCd = vo.getMbrGbCd();

            memberBaseMap.put("mbrNo",mbrNo);
            memberBaseMap.put("gsptNo",gsptNo);
            memberBaseMap.put("mbrGbCd",mbrGbCd);
            memberBaseMap.put("mbrNm",mbrNm);
            memberBaseMap.put("birth",birth);
            memberBaseMap.put("mobile",mobile);
            memberBaseMap.put("mobileCd",mobileCd);
            memberBaseMap.put("ciCtfVal",ciCtfVal);
            memberBaseMap.put("gdGbCd",gdGbCd);

            resultMap.put("mb",memberBaseMap);
        }
        if(StringUtil.isNotEmpty(Optional.ofNullable(so.getGsptNo()).orElseGet(()->""))){
            MemberBaseSO gso = new MemberBaseSO();
            gso.setGsptNo(so.getGsptNo());
            MemberBaseVO vo = gsrService.getGsrMemberBase(gso);
            Map<String,Object> gsrMemberBaseMap = new HashMap<String,Object>();

            String gsptNo = vo.getGsptNo();
            String mbrNm = vo.getMbrNm();
            String birth = vo.getBirth();
            String mobile = vo.getMobile();
            String mobilCd = vo.getMobileCd();
            String ciCtfVal = vo.getCiCtfVal();
            String gdGbCd = vo.getGdGbCd();

            gsrMemberBaseMap.put("gsptNo",gsptNo);
            gsrMemberBaseMap.put("mbrNm",mbrNm);
            gsrMemberBaseMap.put("birth",birth);
            gsrMemberBaseMap.put("mobile",mobile);
            gsrMemberBaseMap.put("mobilCd",mobilCd);
            gsrMemberBaseMap.put("ciCtfVal",ciCtfVal);
            gsrMemberBaseMap.put("gdGbCd",gdGbCd);

            resultMap.put("gs",gsrMemberBaseMap);
        }
        return resultMap;
    }

    @ResponseBody
    @RequestMapping(value="/batch-accum")
    public String accum(){
        String result = CommonConstants.CONTROLLER_RESULT_CODE_SUCCESS;

        try{
            gsrService.getGsrPointAccumeForPetLogReview();
        }catch(Exception e){
            log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE,e);
            result = CommonConstants.CONTROLLER_RESULT_CODE_FAIL;
        }

        return result;
    }

}
