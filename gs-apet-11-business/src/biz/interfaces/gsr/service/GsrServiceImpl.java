package biz.interfaces.gsr.service;

import biz.app.member.dao.MemberBaseDao;
import biz.app.member.model.MemberBasePO;
import biz.app.member.model.MemberBaseSO;
import biz.app.member.model.MemberBaseVO;
import biz.app.member.service.MemberService;
import biz.app.order.dao.OrdSavePntDao;
import biz.app.order.model.OrdSavePntPO;
import biz.app.pay.dao.PayBaseDao;
import biz.app.pay.model.PayBasePO;
import biz.app.pay.model.PayBaseSO;
import biz.app.pay.model.PayBaseVO;
import biz.app.pay.model.PaymentException;
import biz.app.system.model.CodeDetailSO;
import biz.app.system.model.CodeDetailVO;
import biz.common.service.BizService;
import biz.interfaces.gsr.dao.GsrLogDao;
import biz.interfaces.gsr.model.*;
import biz.interfaces.gsr.util.GsrConvertUtil;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.enums.GsrApiSpec;
import framework.common.exception.CustomException;
import framework.common.util.DateUtil;
import framework.common.util.RequestUtil;
import framework.common.util.StringUtil;
import framework.gsr.client.GsrApiClient;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import javax.annotation.Nullable;
import java.net.InetAddress;
import java.net.UnknownHostException;
import java.security.SecureRandom;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.*;

@Slf4j
@Service
public class GsrServiceImpl implements GsrService{
    @Autowired private GsrApiClient gsrApiClient;
    @Autowired private GsrConvertUtil gsrConvertUtil;
    @Autowired private MemberBaseDao memberBaseDao;
    @Autowired private MemberService memberService;
    @Autowired private GsrLogDao gsrLogDao;
    @Autowired private PayBaseDao payBaseDao;
    @Autowired private BizService bizService;
    @Autowired private Properties webConfig;
    @Autowired private Properties bizConfig;
    @Autowired private OrdSavePntDao ordSavePntDao;

    private final String[] ordGsrLnkCd ={CommonConstants.GSR_LNK_USE_POINT,CommonConstants.GSR_LNK_USE_POINT_CANCEL
            ,CommonConstants.GSR_LNK_ACCUM_POINT,CommonConstants.GSR_LNK_USE_POINT_CANCEL};
    private final String[] petLogLikeGsrLnkCd ={CommonConstants.GSR_LNK_ACCUM_POINT_PET_LOG_LIKE};
    private final String[] petLogReviewGsrLnkCd ={CommonConstants.GSR_LNK_ACCUM_POINT_PET_LOG_REIVEW};

    private final String separateNotiMsg = "회원님의 GSR 멤버십 분리 보관이 해제 되었습니다.";

    private final String BT_IP_DEV = "10.20.23.9";          //개발계 BT PRIVATE IP
    private final String BT_IP_STG = "10.20.101.11";        //검증계 BT PRIVATE IP
    private final String BT_IP_PRD = "10.10.111.10";        //운영계 BT PRIVATE IP
    private final String BT_IP_LOCAL = "127.0.0.1";

    //회원 등록, 회원 가입 여부 -> ci 값 인코딩 X
    //회원 조회 -> ci 값 인코딩 O
    //암호화 되지 않은 값
    @Override
    public MemberBaseVO getGsrMemberBase(MemberBaseSO so) {
        Map<String,String> param = gsrConvertUtil.getGsrMemberSearchParam(so);
        Map<String,Object> resultMap = gsrApiClient.getResponse(GsrApiSpec.GSR_SELECT_MEMBER_INFO,param);
        insertHistAndMap(param,resultMap,CommonConstants.GSR_LNK_MBR_SELECT);
        MemberBaseVO vo = new MemberBaseVO();
        vo = gsrConvertUtil.convertResult2MemberBaseVO(resultMap);
        //탈퇴 회원
        if(StringUtil.equals(vo.getCustDelYn(),"Y")){
            vo.setGsptNo(null);
        }        
        return vo;
    }

    //암호화 되지 않은 값을 보내야함
    @Override
    public Map<String,String> checkJoin(MemberBasePO po) {
        Map<String,String> result = new HashMap<>();

        //GS 가입되어있는지 확인
        MemberBaseSO so = new MemberBaseSO();
        so.setMbrNo(Optional.ofNullable(po.getMbrNo()).orElseGet(()->0L));
        so.setGsptNo(Optional.ofNullable(po.getGsptNo()).orElseGet(()->""));
        so.setCiCtfVal(Optional.ofNullable(po.getCiCtfVal()).orElseGet(()->""));
        so.setMbrNm(Optional.ofNullable(po.getMbrNm()).orElseGet(()->""));
        so.setMobile(Optional.ofNullable(po.getMobile()).orElseGet(()->""));
        so.setBirth(Optional.ofNullable(po.getBirth()).orElseGet(()->""));
        so.setGdGbCd(Optional.ofNullable(po.getGdGbCd()).orElseGet(()->""));

        MemberBaseVO check = getGsrMemberBase(so);

        //고객번호 존재할 시, 이미 등록된 회원
        // 30018 -> 고객정보 미존재
        // resultCode -> 없으면, 고객정보 존재 = GSPT_NO
        String gsptNo = Optional.ofNullable(check.getGsptNo()).orElseGet(()->"");
        String resultCode = Optional.ofNullable(check.getResultCode()).orElseGet(()->"");

        //등록된 회원 아닐 시, 가입 여부 확인 API 호출
        if(StringUtil.isEmpty(gsptNo)){
            Map<String,String> param = gsrConvertUtil.getIsJoinCheckParam(po);
            Map<String,Object> resultMap = gsrApiClient.getResponse(GsrApiSpec.GSR_CHECK_IS_JOIN_OR_UPDATE,param);

            insertHistAndMap(param,resultMap,CommonConstants.GSR_LNK_IS_JOIN);

            //응답코드 0000 일시, 존재하는 회원이며 파라미터 정보로 회원정보 update 됨을 의미
            resultCode = resultMap.get("result_code").toString();
            gsptNo = Optional.ofNullable(resultMap.get("cust_no")).orElseGet(()->"").toString();
        }
        //등록 된 회원 이면서, 분리보관이면
        else if(Optional.ofNullable(check.getIsSeparateYn()).orElseGet(()->false)){
            result.put("separateNotiMsg",separateNotiMsg);
        }

        result.put("gsptNo",gsptNo);
        result.put("resultCode",resultCode);
        return result;
    }

    @Override
    public MemberBaseVO saveGsrMember(MemberBasePO po) {
        MemberBaseVO rv;
        Long mbrNo = Optional.ofNullable(po.getMbrNo()).orElseGet(()->0l);

        log.error("##### Check Value At Service #####");
        log.error("##### mbrNo : {} #####",mbrNo);

        //방어 로직 추가 mbrNo 도 없고, loginId도 비어있을 때(=회원 식별 할 수 없을 떄)
        if(Long.compare(mbrNo,0L) == 0 && StringUtil.isEmpty(Optional.ofNullable(po.getLoginId()).orElseGet(()->""))){
            rv = new MemberBaseVO();
            rv.setResultCode(ExceptionConstants.ERROR_CODE_LOGIN_REQUIRED);
            rv.setSeparateNotiMsg("");
            rv.setGsptNo("");
            return rv;
        }

        //명의 검증 && KCB 정보로 MEMBER_BASE update
        String compCiCtfVal = Optional.ofNullable(po.getCiCtfVal()).orElseGet(()->"");
        if(StringUtil.isNotEmpty(compCiCtfVal)){
            //명의 검증
            checkMbrNm(mbrNo,compCiCtfVal);
            update(po);

            //본인을 제외한 동일 핸드폰 가진 회원 상태 UPDATE -> 2021.08.31 kjy01 변경
            if(StringUtil.isNotEmpty(Optional.ofNullable(po.getMobile()).orElseGet(()->""))){
                MemberBaseSO so = new MemberBaseSO();
                so.setMobile(po.getMobile());
                so.setLoginId(Optional.ofNullable(po.getLoginId()).orElseGet(()->""));

                //본인 포함 동일 핸드폰 번호 가진 회원 번호 리스트
                List<MemberBasePO> memberList = gsrLogDao.findMemberBaseByMobile(so);

                //mbrNo가 0L 으로 소실되었을 경우
                if(Long.compare(mbrNo,0L) == 0 && !StringUtil.isEmpty(so.getLoginId())){
                    MemberBaseVO self = memberBaseDao.getMemberBase(so);
                    mbrNo = self.getMbrNo();
                }

                if(!CollectionUtils.isEmpty(memberList) && memberList.size() > 1) {
                    //본인을 제외하고 회원이 있을 경우
                    try{
                        for(MemberBasePO target : memberList) {
                            if(Long.compare(mbrNo,0L) != 0 && Long.compare(mbrNo,target.getMbrNo()) != 0){
                                target.setMbrStatCd(CommonConstants.MBR_STAT_40);
                                target.setSysUpdrNo(mbrNo);
                                memberBaseDao.updateMemberBase(target);
                                memberBaseDao.insertMemberBaseHistory(target);
                            }else if(!StringUtil.equals(so.getLoginId(),target.getLoginId())){
                                target.setMbrStatCd(CommonConstants.MBR_STAT_40);
                                target.setSysUpdrNo(-11L);
                                memberBaseDao.updateMemberBase(target);
                                memberBaseDao.insertMemberBaseHistory(target);
                            }else{
                                log.error("####### Not Exists Same Mobile Number ####### ");
                            }
                        }
                    }catch(NullPointerException npe){
                        log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE,npe);
                        log.error("####### Not Exists Same Mobile Number ####### ");
                    }
                }
            }
        }

        //암호화 된 값(MEBER_BASE 업데이트 위해)
        MemberBaseVO v = memberBaseDao.getMemberBaseGsrRequiredParam(mbrNo);

        String encryMbrNm = po.getMbrNm();
        String encryMobile = po.getMobile();
        String encryBirth = Optional.ofNullable(po.getBirth()).orElseGet(()->v.getBirth());
        String mobile = bizService.twoWayDecrypt(po.getMobile());
        String mbrNm = bizService.twoWayDecrypt(po.getMbrNm());
        String birth = bizService.twoWayDecrypt(encryBirth);

        //이름,핸드폰번호,생일 복호화(gsr 등록) , 성별 구분 코드
        po.setMbrNm(mbrNm);
        po.setMobile(mobile);
        po.setGdGbCd(v.getGdGbCd());
        po.setBirth(birth);

        rv = new MemberBaseVO();
        Map<String,String> result = checkJoin(po);

        String gsptNo = result.get("gsptNo");
        String resultCode = result.get("resultCode");

        //gsptNo가 없고, 가입 가능 응답코드일 떄만(0000) 혹은 고객정보 미존재(R3700) 일 때
        log.error("#### IS JOIN RESULT_CDOE : {}",resultCode);
        if(StringUtil.isEmpty(gsptNo) && (
                                Arrays.asList(CommonConstants.GSR_RST_OK).contains(resultCode)
                            ||  StringUtil.equals(resultCode,ExceptionConstants.ERROR_GSR_API_NOT_FOUND)
                            ||  StringUtil.equals(resultCode,ExceptionConstants.ERROR_GSR_API_HOME_SHOP_MEMBER)
                ) ){
            Map<String,String> param = gsrConvertUtil.getRegisterParam(po);
            Map<String,Object> resultMap = new HashMap<String,Object>();

            resultMap = gsrApiClient.getResponse(GsrApiSpec.GSR_INSERT_MEMBER,param);
            gsptNo = Optional.ofNullable(resultMap.get("cust_no")).orElseGet(()->"").toString();
            insertHistAndMap(param,resultMap,CommonConstants.GSR_LNK_MBR_INSERT);
        }

        log.debug("######## gsptNo : {}",gsptNo);

        //GS 연계 실패 하더라도, KCB 인증값 업데이트
        if(StringUtil.isNotEmpty(gsptNo)){
            MemberBasePO upo = new MemberBasePO();
            upo.setMbrNo(po.getMbrNo());
            upo.setGsptNo(gsptNo);
            update(upo);
        }

        try{
            MemberBasePO histPo = new MemberBasePO();
            histPo.setMbrNo(mbrNo);
            memberBaseDao.insertMemberBaseHistory(histPo);
        }catch(Exception e){
            log.error("#### INSERT MEMBER BASE HISTORY ERROR : {}",e.getClass());
        }

        rv.setGsptNo(gsptNo);
        rv.setResultCode(resultCode);
        rv.setSeparateNotiMsg(Optional.ofNullable(result.get("separateNotiMsg")).orElseGet(()->""));

        return rv;
    }

    /*
      @param : gsptNo
      @param : mbrNm ( 암호화 된 값 )
      @param : mobile ( 암호화 된 값 )
      @param : birth  ( 암호화 된 값 )
    */
    @Override
    public void update(MemberBasePO po) {
        if(Long.compare(Optional.ofNullable(po.getMbrNo()).orElseGet(()->0L),0)!=0){
            po.setDeviceToken(null);
            po.setDeviceTpCd(null);
            po.setMbrStatCd(CommonConstants.MBR_STAT_10);       //정상 값으로
            po.setMbrGbCd(CommonConstants.MBR_GB_CD_10);        //정회원으로
            po.setCtfYn(CommonConstants.COMM_YN_Y);             //인증여부 Y -> KCB로 인증을 하였으니

            //배치가 아닐 경우, RequestUtil
            if(!StringUtil.equals(webConfig.getProperty("project.gb"),CommonConstants.PROJECT_GB_BATCH)){
                po.setUpdrIp(bizService.twoWayEncrypt(RequestUtil.getClientIp()));
            }

            //api 호출 성공 하여 처리
            if(StringUtil.isNotEmpty(Optional.ofNullable(po.getCiCtfVal()).orElseGet(()->"")) || StringUtil.isNotEmpty(Optional.ofNullable(po.getGsptNo()).orElseGet(()->""))){
                po.setGsptUseYn(CommonConstants.USE_YN_Y);
                po.setGsptStateCd(CommonConstants.GSPT_STATE_10);
            }
            memberBaseDao.updateMemberBase(po);
        }
    }

    @Override
    public GsrMemberPointVO getGsrMemberPoint(GsrMemberPointSO so) {
        String custNo = Optional.ofNullable(so.getCustNo()).orElseGet(()->getGsptNo(so.getMbrNo()));
        GsrMemberPointVO gsvo;
        if(StringUtil.isNotEmpty(custNo)){
            //분리 보관 된 회원인지 확인
            Map<String,String> checkParam = new HashMap<>();
            checkParam.put("cust_no",custNo);
            MemberBaseVO cvo = gsrConvertUtil.convertResult2MemberBaseVO(gsrApiClient.getResponse(GsrApiSpec.GSR_SELECT_MEMBER_INFO,checkParam));

            //탈퇴 분리 보관 확인
            String custDelYn = cvo.getCustDelYn();
            if(StringUtil.equals(custDelYn,"Y")){
                //재가입
                /*MemberBasePO reJoin = memberBaseDao.getSaveGsrMemberBaseInfoByGsptNo(custNo);
                MemberBaseVO re = saveGsrMember(reJoin);
                custNo = re.getGsptNo();*/
                gsvo = new GsrMemberPointVO();
            }else{
                so.setCustNo(custNo);
                Map<String,String> param = gsrConvertUtil.getSelectMemberPointParam(so);
                Map<String,Object> resultMap = new HashMap<String,Object>();

                resultMap = gsrApiClient.getResponse(GsrApiSpec.GSR_SELECT_MEMBER_POINT,param);
                gsvo = gsrConvertUtil.convertResult2GsrMemberPointVO(resultMap);
                gsvo.setCustNo(custNo);

                //분리보관 해제 시
                if(cvo.getIsSeparateYn()){
                    gsvo.setSeparateNotiMsg(separateNotiMsg);
                }
                insertHistAndMap(param,resultMap,CommonConstants.GSR_LNK_POTIN_SELECT);
            }
        }else{
            //CI
            gsvo = new GsrMemberPointVO();
        }
        return gsvo;
    }

    //주문 시에만 사용
    @Override
    public GsrMemberPointVO useGsPoint(GsrMemberPointPO po) {
        po.setAccumUseType(CommonConstants.GSR_POINT_USE);
        po.setDealSp(CommonConstants.GSR_DEAL_SALED);
        po = validCheck(po,CommonConstants.GSR_LNK_USE_POINT);
        return callSaveGsrMemberPoint(po,CommonConstants.GSR_LNK_USE_POINT);
    }

    //주문 시에만 사용
    @Override
    public GsrMemberPointVO useCancelGsPoint(GsrMemberPointPO po) {
        po.setAccumUseType(CommonConstants.GSR_POINT_USE);
        po.setDealSp(CommonConstants.GSR_DEAL_RETURN);
        po.setSaleAmt("0");
        po = validCheck(po,CommonConstants.GSR_LNK_USE_POINT_CANCEL);
        return callSaveGsrMemberPoint(po,CommonConstants.GSR_LNK_USE_POINT_CANCEL);
    }

    //주문 시에만 사용
    @Override
    public GsrMemberPointVO accumGsPoint(GsrMemberPointPO po) {
        po.setAccumUseType(CommonConstants.GSR_POINT_ACCUM);
        po.setDealSp(CommonConstants.GSR_DEAL_SALED);
        po = validCheck(po,CommonConstants.GSR_LNK_ACCUM_POINT);
        return callSaveGsrMemberPoint(po,CommonConstants.GSR_LNK_ACCUM_POINT);
    }

    //펫 로그 좋아요 카운트 시 적립
    @Override
    public GsrMemberPointVO petLogPotinAccumtByCount(GsrMemberPointPO po) {
        po.setAccumUseType(CommonConstants.GSR_POINT_ACCUM);
        po.setDealSp(CommonConstants.GSR_DEAL_SALED);
        po = validCheck(po,CommonConstants.GSR_LNK_ACCUM_POINT_PET_LOG_LIKE);
        return callSaveGsrMemberPoint(po,CommonConstants.GSR_LNK_ACCUM_POINT_PET_LOG_LIKE);
    }

    @Override
    public GsrMemberPointVO petLogReviewAccumPoint(GsrMemberPointPO po) {
        po.setAccumUseType(CommonConstants.GSR_POINT_ACCUM);
        po.setDealSp(CommonConstants.GSR_DEAL_SALED);
        po = validCheck(po,CommonConstants.GSR_LNK_ACCUM_POINT_PET_LOG_REIVEW);
        GsrMemberPointVO gmpvo = callSaveGsrMemberPoint(po,CommonConstants.GSR_LNK_ACCUM_POINT_PET_LOG_REIVEW);

        if(StringUtil.isNotEmpty(Optional.ofNullable(gmpvo.getApprNo()).orElseGet(()->""))){
            // GS포인트 이력 저장
            OrdSavePntPO pntPO = new OrdSavePntPO();
            pntPO.setSaveUseGbCd(CommonConstants.SAVE_USE_GB_10); // 적립
            pntPO.setDealGbCd(CommonConstants.DEAL_GB_30);		  // 후기등록
            pntPO.setMbrNo(po.getMbrNo());
            pntPO.setOrdNo(po.getOrdNoForCheck());						// 주문 번호
            pntPO.setGspntNo(po.getCustNo());
            pntPO.setPnt((StringUtil.isNotBlank(po.getPoint()))?Integer.valueOf(po.getPoint()):0);
            pntPO.setDealNo(gmpvo.getApprNo());
            pntPO.setDealDtm(new Timestamp(System.currentTimeMillis()));
            pntPO.setSysRegrNo(po.getMbrNo());
            ordSavePntDao.insertGsPntHist(pntPO);
        }

        return gmpvo;
    }

    //취소는 일괄 적용
    @Override
    public GsrMemberPointVO accumCancelGsPoint(GsrMemberPointPO po) {
        po.setAccumUseType(CommonConstants.GSR_POINT_ACCUM);
        po.setDealSp(CommonConstants.GSR_DEAL_RETURN);
        po.setSaleAmt("0");
        po = validCheck(po,CommonConstants.GSR_LNK_USE_POINT_CANCEL);
        return callSaveGsrMemberPoint(po,CommonConstants.GSR_LNK_USE_POINT_CANCEL);
    }

    //필수값( 주문번호+주문 상세 번호 , 포인트 , 판매금액 ) 유효성 체크
    private GsrMemberPointPO validCheck(GsrMemberPointPO po,String gsrLnkCd){
        String rcptNo = Optional.ofNullable(po.getRcptNo()).orElseThrow(()->new GsrException(ExceptionConstants.ERROR_GSR_API_NECESSARY_FIELD_POINT_RCPT_NO,po,gsrLnkCd));
        String point = Optional.ofNullable(po.getPoint()).orElseGet(()->"");
        String saleAmt = Optional.ofNullable(po.getSaleAmt()).orElseGet(()->"");
        String saleDate = Optional.ofNullable(po.getSaleDate()).orElseGet(()->"");
        String saleEndDt = Optional.ofNullable(po.getSaleEndDt()).orElseGet(()->"");

        if(StringUtil.isEmpty(saleEndDt)
                || StringUtil.isEmpty(saleDate) || StringUtil.isEmpty(point)
                || (StringUtil.equals(po.getDealSp(), CommonConstants.GSR_DEAL_SALED) && StringUtil.isEmpty(saleAmt))){
            throw new GsrException(ExceptionConstants.ERROR_GSR_API_NECESSARY_FIELD_POINT_INFO,po,gsrLnkCd);
        }

        // 영수증 번호(=주문 번호) 유효성(숫자만 가능)
        /*rcptNo = rcptNo.substring(1);
        if(!rcptNo.matches ("(^\\d*$)")){
            throw new GsrException(ExceptionConstants.ERROR_GSR_API_NECESSARY_FIELD_POINT_RCPT_NO_ONLY_NUMBER,po,gsrLnkCd);
        }*/

        //yyyyMMdd
        saleDate = saleDate.replaceAll("-","");
        if(saleDate.length() != 8){
            throw new GsrException(ExceptionConstants.ERROR_GSR_API_INVALID_DATE_FORMAT,po,gsrLnkCd);
        }
        //HHSSmm
        saleEndDt = saleEndDt.replaceAll("-","");
        if(saleEndDt.length() != 6){
            throw new GsrException(ExceptionConstants.ERROR_GSR_API_INVALID_TIMESTAMP_FORMAT,po,gsrLnkCd);
        }

        po.setSaleDate(saleDate);
        po.setSaleEndDt(saleEndDt);
        po.setRcptNo(rcptNo);

        //배치 일 때
        if(StringUtil.equals(webConfig.getProperty("project.gb"),CommonConstants.PROJECT_GB_BATCH)){
            try {
                InetAddress local = InetAddress.getLocalHost();
                String remoteAddr = local.getHostAddress();
                po.setIpAddr(remoteAddr);
            } catch (UnknownHostException e) {
                //개발
                if (StringUtil.equals(bizConfig.getProperty("envmt.gb"), CommonConstants.ENVIRONMENT_GB_DEV)){
                    po.setIpAddr(BT_IP_DEV);
                }
                //검증
                else if (StringUtil.equals(bizConfig.getProperty("envmt.gb"), CommonConstants.ENVIRONMENT_GB_STG)){
                    po.setIpAddr(BT_IP_STG);
                }
                //운영
                else if (StringUtil.equals(bizConfig.getProperty("envmt.gb"), CommonConstants.ENVIRONMENT_GB_OPER)){
                    po.setIpAddr(BT_IP_PRD);
                }else{
                    po.setIpAddr(BT_IP_LOCAL);
                }
            }
        }else{
            po.setIpAddr(RequestUtil.getClientIp());
        }

        return po;
    }
    private GsrMemberPointVO callSaveGsrMemberPoint(GsrMemberPointPO po,String gsrLnkCd){
        String custNo = Optional.ofNullable(po.getCustNo()).orElseGet(()->getGsptNo(po.getMbrNo()));

        GsrMemberPointVO result;
        if(StringUtil.isNotEmpty(custNo)){
            String orgRcptNo = po.getRcptNo();  //주문 번호 담아서 넘겨줌
            String rcptNo = getRcptNo();
            po.setRcptNo(rcptNo);
            po.setCustNo(custNo);

            //필수 파라미터 -> 포인트 사용 취소 및 포인트 적립 취소 시 필수값(org_appr_no,org_appr_date)
            Boolean isPointUseCancle = StringUtil.equals(po.getPntType(),CommonConstants.GSR_POINT_TYPE_USE)
                    && StringUtil.equals(po.getAccumUseType(),CommonConstants.GSR_POINT_USE)
                    && StringUtil.equals(po.getDealSp(),CommonConstants.GSR_DEAL_RETURN);

            Boolean isPointAccumCancle = StringUtil.equals(po.getPntType(),CommonConstants.GSR_POINT_TYPE_ACCUM)
                    && StringUtil.equals(po.getAccumUseType(),CommonConstants.GSR_POINT_ACCUM)
                    && StringUtil.equals(po.getDealSp(),CommonConstants.GSR_DEAL_RETURN);
            
            //정상적으로 포인트 사용 및 포인트 적립이 안된 거래를 취소 할 때
            if(isPointUseCancle || isPointAccumCancle){
                String orgApprNo = Optional.ofNullable(po.getOrgApprNo()).orElseThrow(()->new PaymentException(ExceptionConstants.ERROR_GSR_API_NOT_EXSITS_APPR));
                String orgApprDate = Optional.ofNullable(po.getOrgApprDate()).orElseGet(
                        ()-> DateUtil.getTimestampToString(DateUtil.getTimestamp(), "yyyyMMdd"));
                po.setOrgApprNo(orgApprNo);
                po.setOrgApprDate(orgApprDate);
            }

            Map<String,String> param = gsrConvertUtil.getSaveMemberPointPamram(po);

            //CRM 고객 정보 조회
            MemberBaseSO so = new MemberBaseSO();
            so.setGsptNo(custNo);
            MemberBaseVO vo = getGsrMemberBase(so);
            String custDelYn = vo.getCustDelYn();
            Map<String,Object> resultMap = new HashMap<String,Object>();

            // 탈퇴 일 경우
            //cust_del_yn 처리 ( N : 정상 ,S : 분리 보관 , Y : 탈퇴 )
            if(StringUtil.equals(custDelYn,"Y")) {
                //재가입 시켜야하는지 확인 필요(요건 없음)
                /*MemberBasePO reJoin = memberBaseDao.getSaveGsrMemberBaseInfoByGsptNo(custNo);
                MemberBaseVO re = saveGsrMember(reJoin);
                custNo = re.getGsptNo();
                param.replace("cust_no",custNo);*/
                throw new PaymentException(ExceptionConstants.ERROR_GSR_API_DEL_MEMBER);
            }else{
                //정상 호출
                try{
                    resultMap = gsrApiClient.getResponse(GsrApiSpec.GSR_SAVE_MEMBER_POINT,param);
                    result = gsrConvertUtil.convertResult2GsrMemberPointVO(resultMap);
                    // GS 포인트만 반영되었을 시, 실패되더라도 주문 진행으로 로직 개발
                    // MP(우주코인)과 동일한 흐름 진행을 위해 통신 실패 혹은 정상 승인이 안되었을 경우, 주문 X 위해 Exception 추가
                    if(StringUtil.isEmpty(Optional.ofNullable(result.getApprNo()).orElseGet(()->""))){
                        throw new PaymentException(result.getResultCode());
                    }
                    result.setCustNo(custNo);
                }catch(Exception e){
                    throw new PaymentException(ExceptionConstants.ERROR_CODE_DEFAULT);
                }
            }

        }else{
            result = new GsrMemberPointVO();
            result.setResultCode(ExceptionConstants.ERROR_GSR_API_IS_NOT_EXISTS);
        }
        return result;
    }

    public String getRcptNo(){
        SecureRandom secure = new SecureRandom();
        Integer s = secure.nextInt(999);
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmssSSS"); //SSS가 밀리세컨드 표시
        Calendar calendar = Calendar.getInstance();
        String rcptNo = dateFormat.format(calendar.getTime()) + s.toString();
        return rcptNo;
    }

    public List<GsrLnkHistVO> gsrLinkedHistoryGrid(GsrLnkHistSO so){
        List<GsrLnkHistVO> list = gsrLogDao.gsrLinkedHistoryGrid(so);
        return list;
    }

    @Override
    public String getGsptNo(Long mbrNo){
        MemberBaseSO mso = new MemberBaseSO();
        mso.setMbrNo(mbrNo);
        MemberBaseVO check = memberBaseDao.getMemberBase(mso);
        MemberBasePO p = new MemberBasePO();

        String gsptNo = Optional.ofNullable(check.getGsptNo()).orElseGet(()->"");
        String ciCtfVal = Optional.ofNullable(check.getCiCtfVal()).orElseGet(()->"");
        //CI 값은 있으나, GS 번호만 없을 때
        if(StringUtil.isEmpty(gsptNo) && StringUtil.isNotEmpty(ciCtfVal)){
            p.setMbrNo(check.getMbrNo());
            p.setCiCtfVal(check.getCiCtfVal());
            p.setMbrNm(check.getMbrNm());
            p.setMobile(check.getMobile());
            p.setMobileCd(check.getMobileCd());
            p.setBirth(check.getBirth());
            p.setGdGbCd(check.getGdGbCd());
            MemberBaseVO v = saveGsrMember(p);
            gsptNo = v.getGsptNo();
        }
        return gsptNo;
    }

    @Override
    public void checkMbrNm(Long mbrNo,String newCiCtfVal){
        MemberBaseSO s = new MemberBaseSO();
        s.setMbrNo(mbrNo);
        MemberBaseVO v = memberBaseDao.getMemberBase(s);
        String orgCiCtfVal = Optional.ofNullable(v.getCiCtfVal()).orElseGet(()->"");

        //기존에 인증한 CI값이 있으나, 새로 요청한 값이 다를 때
        if(StringUtil.isNotEmpty(orgCiCtfVal) && !StringUtil.equals(orgCiCtfVal,newCiCtfVal)){
            throw new CustomException(ExceptionConstants.ERROR_MEMBER_NOT_EQUAL_MBR_NM);
        }
    }

    private void insertHistAndMap(Map<String,String> param, Map<String,Object> resultMap, String gsrLnkCd){
        insertHistAndMap(param,resultMap,gsrLnkCd,null,null);
    }

    private void insertHistAndMap(Map<String,String> param, Map<String,Object> resultMap, String gsrLnkCd,@Nullable String orgRcptNo ){
        insertHistAndMap(param,resultMap,gsrLnkCd,orgRcptNo,null);
    }

    private void insertHistAndMap(Map<String,String> param, Map<String,Object> resultMap, String gsrLnkCd
            , @Nullable  String orgRcptNo
            ,   @Nullable String ordNoForCheck){
        GsrLnkHistPO po = new GsrLnkHistPO();
        po.setGsrLnkCd(gsrLnkCd);
        try{
            po.setReqParam(new ObjectMapper().writeValueAsString(param));
        }catch(JsonProcessingException jpe){
            po.setReqParam(jpe.getMessage());
        }
        String reqScssYn = "Y";
        String rstCd = "00000";
        if(Arrays.asList(CommonConstants.GSR_RST_OK).indexOf(Optional.ofNullable(resultMap.get("result_code")).orElseGet(()->"00000").toString()) == -1){
            reqScssYn = "N";
            rstCd = resultMap.get("result_code").toString();
        }
        po.setGsptNo(Optional.ofNullable(resultMap.get("cust_no")).orElseGet(()->"").toString());
        po.setReqScssYn(reqScssYn);
        po.setRstCd(rstCd);

        if(StringUtil.equals(webConfig.getProperty("project.gb"),CommonConstants.PROJECT_GB_BATCH)){
            po.setSysRegrNo(CommonConstants.COMMON_BATCH_USR_NO);
        }

        gsrLogDao.insertGsrLnkHist(po);

        //영수증 번호 존재 시
        if(orgRcptNo != null){
            GsrLnkMapPO mapPo = new GsrLnkMapPO();

            String rcptNo = param.get("rcpt_no");
            String gsptNo = param.get("cust_no");
            String orgApprNo = Optional.ofNullable(param.get("org_appr_no")).orElseGet(()->"").toString();
            String orgApprDate = Optional.ofNullable(param.get("org_appr_date")).orElseGet(()->"").toString();
            String apprNo = Optional.ofNullable(resultMap.get("appr_no")).orElseGet(()->"").toString();
            String apprDate = Optional.ofNullable(resultMap.get("appr_date")).orElseGet(()->"").toString();

            mapPo.setRcptNo(rcptNo);
            mapPo.setGsptNo(gsptNo);
            mapPo.setOrgApprNo(orgApprNo);
            mapPo.setOrgApprDate(orgApprDate);
            mapPo.setApprNo(apprNo);
            mapPo.setApprDate(apprDate);
            if(StringUtil.equals(webConfig.getProperty("project.gb"),CommonConstants.PROJECT_GB_BATCH)){
                mapPo.setSysRegrNo(CommonConstants.COMMON_BATCH_USR_NO);
            }

            //사용 구분에 따른 컬럼 SET
            //주문
            if(Arrays.asList(ordGsrLnkCd).indexOf(gsrLnkCd)>-1){
                mapPo.setOrdNo(orgRcptNo);
            }
            //펫 로그 좋아요
            else if(Arrays.asList(petLogLikeGsrLnkCd).indexOf(gsrLnkCd)>-1){
                mapPo.setPetLogNo(Long.parseLong(orgRcptNo));
            }
            //펫 로그 후기
            else if(Arrays.asList(petLogReviewGsrLnkCd).indexOf(gsrLnkCd)>-1){
                mapPo.setGoodsEstmNo(Long.parseLong(orgRcptNo));
            }

            //펫로그 상품 후기 일시
            if(StringUtil.equals(gsrLnkCd,CommonConstants.GSR_LNK_ACCUM_POINT_PET_LOG_REIVEW)){
                mapPo.setOrdNo(ordNoForCheck);
            }
            gsrLogDao.insertGsrLnkMap(mapPo);
        }
    }

    @Override
    public Integer getRcptNoCnt(GsrLnkMapSO so) {
        return Optional.ofNullable(gsrLogDao.getRcptNoCnt(so)).orElseGet(()->0);
    }

    @Override
    public List<CodeDetailVO> listCodeDetailVO(String grpCd) {
        CodeDetailSO so = new CodeDetailSO();
        so.setGrpCd(grpCd);
        return gsrLogDao.listCodeDetailVO(so);
    }

    @Override
    public CodeDetailVO getCodeDetailVO(String grpCd, String dtlCd) {
        CodeDetailSO so = new CodeDetailSO();
        so.setGrpCd(grpCd);
        so.setDtlCd(dtlCd);
        CodeDetailVO result = Optional.ofNullable(gsrLogDao.getCodeDetailVO(so)).orElseGet(()->new CodeDetailVO());
        return result;
    }

    @Override
    public void getGsrPointAccumeForPetLogReview() {
        List<GsrMemberPointPO> list = gsrLogDao.getGsrPointAccumeForPetLogReview();

        for(GsrMemberPointPO po : list){
            if(StringUtil.isNotEmpty(Optional.ofNullable(po.getCustNo()).orElseGet(()->""))){
                po.setSaleAmt("0");
                petLogReviewAccumPoint(po);
            }
        }
    }

    @Override
    public PayBaseVO getPayBase(PayBaseSO so) {
        so.setPayMeansCd(CommonConstants.PAY_MEANS_80);
        return payBaseDao.getPayBase(so);
    }

    @Override
    public void updatePayBaseComplete(PayBasePO po) {
        try{
            if(payBaseDao.updatePayBaseComplete(po) == 0){
                log.error("### GsrService PayBase Update Failed ###");
            }
        }catch(Exception e){
            log.error("### GsrService PayBase Update Failed ###");
            log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE,e);
        }
    }

    @Override
    public void insertPayBase(PayBasePO po) {
        try{
            if(payBaseDao.insertPayBase(po) == 0){
                log.error("### GsrService PayBase Insert Failed ###");
            }
        }catch(Exception e){
            log.error("### GsrService PayBase Insert Failed ###");
            log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE,e);
        }
    }
}


