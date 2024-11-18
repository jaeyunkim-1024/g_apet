package batch.excute.member;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.stereotype.Component;

import biz.app.appweb.model.PushSO;
import biz.app.appweb.model.PushVO;
import biz.app.appweb.service.PushService;
import biz.app.batch.model.BatchLogPO;
import biz.app.batch.service.BatchService;
import biz.app.member.model.MemberCouponPO;
import biz.app.member.model.MemberCouponVO;
import biz.app.member.service.MemberBatchService;
import biz.app.member.service.MemberCouponService;
import biz.app.member.service.MemberService;
import biz.app.promotion.model.CouponIssueVO;
import biz.app.st.model.StStdInfoVO;
import biz.app.st.service.StService;
import biz.app.system.model.CodeDetailVO;
import biz.common.model.SsgMessageSendPO;
import biz.common.service.BizService;
import biz.common.service.CacheService;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import framework.common.util.DateUtil;
import framework.common.util.StringUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class MemberCouponExecute {
    @Autowired
    private CacheService cacheService;

    @Autowired
    private MemberBatchService memberBatchService;

    @Autowired
    private PushService pushService;

    @Autowired
    private BizService bizService;

    @Autowired
    private BatchService batchService;

    @Autowired
    private StService stService;

    @Autowired
    private MessageSourceAccessor message;

    @Autowired
    private MemberService memberService;

	@Autowired
	private MemberCouponService memberCouponService;

    //회원 쿠폰 만료 시, LMS 발송
    public void memberCouponExpire(){
        BatchLogPO blpo = new BatchLogPO();
        blpo.setBatchId(CommonConstants.BT_MBR_COUPON_EXPIRE);
        blpo.setBatchStrtDtm(DateUtil.getTimestamp());
        Integer totalCnt = 0;
        Integer success = 0;
        Integer failed = 0;

        try{
            CodeDetailVO expireCouponLms = cacheService.getCodeCache(CommonConstants.VARIABLE_CONSTANTS,CommonConstants.VARIABLE_CONSTANTS_COUPON_EXPIRE_DAY);
            
            //쿠폰 만료 안내 공통 코드 - 사용여부  Y 일 때만
            if(StringUtil.equals(expireCouponLms.getUseYn(),CommonConstants.COMM_YN_Y)){
                String leftDaysStr = cacheService.getCodeCache(CommonConstants.VARIABLE_CONSTANTS,CommonConstants.VARIABLE_CONSTANTS_COUPON_EXPIRE_DAY).getUsrDfn1Val().trim();
                Integer expire = Integer.parseInt(leftDaysStr);

                //만료 기간 3일 남은 회원 쿠폰 가져오기
                List<MemberCouponVO> list = memberBatchService.listMemberCouponExpire(expire);
                totalCnt = list.size();

                //공통 바인드 변수
                StStdInfoVO stInfo = stService.getStStdInfo(CommonConstants.DEFAULT_ST_ID);
                String csTelNo = Optional.ofNullable(stInfo.getCsTelNo()).orElseGet(()->CommonConstants.DEFAULT_CS_TEL_NO);
                if(csTelNo.length() == 7){
                    csTelNo = csTelNo.substring(0,3) + "-"+csTelNo.substring(3);
                }else if(csTelNo.length() == 8){
                    csTelNo = csTelNo.substring(0,4) + "-"+csTelNo.substring(4);
                }

                //템플릿 정보 가져오기 ( 쿠폰 만료 안내 템플릿 )
                CodeDetailVO template= cacheService.getCodeCache(CommonConstants.TMPL_NO,CommonConstants.TMPL_COPON_EXPIRE);
                Long tmplNo = Long.parseLong(template.getUsrDfn1Val().trim());
                String sendType = template.getUsrDfn2Val();

                // 2. 템플릿 조회
                PushSO pso = new PushSO();
                pso.setTmplNo(tmplNo);
                PushVO pvo = pushService.getNoticeTemplate(pso);

                //발송
                for(MemberCouponVO v : list){
                    Long mbrNo = v.getMbrNo();
                    String mbrNm = bizService.twoWayDecrypt(v.getMbrNm());
                    String mobile = bizService.twoWayDecrypt(v.getMobile());
                    
                    //이름과 핸드폰 번호 존재 및 마케팅 수신 여부 Y 이면서 만료 안내가 Y인 경우에만 발송
                    if(StringUtil.isNotEmpty(mobile) && StringUtil.isNotEmpty(mbrNm)
                            && StringUtil.equals(v.getExprItdcYn(),CommonConstants.COMM_YN_Y)){
                        SsgMessageSendPO msg = new SsgMessageSendPO();
                        // 1. SMS / LMS
                        msg.setFuserid(String.valueOf(mbrNo));

                        //템플릿 내용
                        String tmplContents = pvo.getContents();
                        String useEndDtmStr = DateUtil.timeStamp2Str(v.getUseEndDtm(),"yyyy.MM.dd");

                        tmplContents = StringUtil.replaceAll(tmplContents,CommonConstants.PUSH_TMPL_VRBL_20,mbrNm);
                        tmplContents = StringUtil.replaceAll(tmplContents,CommonConstants.PUSH_TMPL_VRBL_120,v.getCpNm());
                        tmplContents = StringUtil.replaceAll(tmplContents,CommonConstants.PUSH_TMPL_VRBL_300,csTelNo);
                        tmplContents = StringUtil.replaceAll(tmplContents,CommonConstants.PUSH_TMPL_VRBL_140,useEndDtmStr); //쿠폰 종료일
                        tmplContents = StringUtil.replaceAll(tmplContents,CommonConstants.PUSH_TMPL_VRBL_290,v.getLeftDays().toString()); //쿠폰 종료일 디데이

                        msg.setFsubject(pvo.getSubject()); //템플릿 제목 set
                        msg.setFmessage(tmplContents);// 템플릿 내용 replace(데이터 바인딩)
                        msg.setFdestine(mbrNm);
                        msg.setSndTypeCd(sendType); // MMS/LMS/SMS
                        msg.setFdestine(mobile);
                        msg.setMbrNo(mbrNo);

                        // CASE : 1현재 시간이 8시~21사이가 아니면 익일 오전 8시 예약 발송
                        SimpleDateFormat sDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                        String today = DateUtil.getTimestampToString(DateUtil.getTimestamp(), "yyyyMMdd");
                        Calendar limitSendStartTime = DateUtil.getCalendar(today);
                        Calendar limitSendEndTime = DateUtil.getCalendar(today);
                        Calendar reservTime = DateUtil.getCalendar(today);

                        limitSendStartTime.add(Calendar.HOUR_OF_DAY, 8);	//오전 8시
                        limitSendEndTime.add(Calendar.HOUR_OF_DAY, 21);	//오후 21시
                        reservTime.add(Calendar.HOUR_OF_DAY, 32);		//다음날 오전 8시

                        // CASE 2 :현재 시간이 8시~21사이가 아니면 익일 오전 8시 예약 발송
                        if( !DateUtil.isPast(sDate.format(limitSendStartTime.getTime())) && !DateUtil.isPast(sDate.format(limitSendEndTime.getTime()))
                        ) {
                            msg.setNoticeTypeCd(CommonConstants.NOTICE_TYPE_10);// 즉시
                        }else {
                            msg.setFsenddate(DateUtil.getTimestamp(sDate.format(reservTime.getTime()), "yyyyMMddHHmmss"));
                            msg.setNoticeTypeCd(CommonConstants.NOTICE_TYPE_20);// 예약
                        }

                        try{
                            if(bizService.sendMessage(msg) > 0){
                                success +=1;
                            }else{
                                failed +=1;
                            }
                        }catch(Exception e){
                            log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE,e);
                            failed +=1;
                        }finally {
                            blpo.setBatchRstCd(CommonConstants.BATCH_RST_CD_SUCCESS);
                        }
                    }else{
                        log.debug("############# Mobile and MbrNm is Null : {}" , mbrNo );
                        failed +=1;
                    }
                }
            }else{
                log.debug("############# Coupon Expire Lms Code UseYn is N");
            }
        }catch(Exception e){
            log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE,e);
            blpo.setBatchRstCd(CommonConstants.BATCH_RST_CD_FAIL);
        }finally{
            String rstMsg = message.getMessage("batch.log.result.msg.member.coupon.expire.result"
                    ,new String[]{totalCnt.toString(),success.toString(),failed.toString()});
            blpo.setBatchRstMsg(rstMsg);
            batchService.insertBatchLog(blpo);
        }
    }

    //회원 패밀리 등급 쿠폰 지급
    public void insertMemberFaimliyCoupon(){
        String mbrGrdCd = CommonConstants.MBR_GRD_30;
        BatchLogPO blpo = new BatchLogPO();
        blpo.setBatchId(CommonConstants.BT_MBR_GRD_FAMILIY_COUPON_INSERT);
        blpo.setBatchStrtDtm(DateUtil.getTimestamp());
        int result = 0;

       try{
           List<CodeDetailVO> list = cacheService.listCodeCache(CommonConstants.AUTO_ISU_COUPON,true,null,mbrGrdCd,null,null,null);
           List<Long> cpNos = new ArrayList<Long>();
           List<String> dtlCds = new ArrayList<String>();
           
           //공통 코드 등록 안되어거나 전부다 N일 때
           if(!list.isEmpty()){
               for(CodeDetailVO code : list){
                   if(StringUtil.isNotEmpty(code.getUsrDfn1Val())){
                       dtlCds.add(code.getDtlCd());
                       cpNos.add(Long.parseLong(code.getUsrDfn1Val()));
                   }else{
                       log.error("##### {} is UsrDfn1Val is Null",code.getDtlCd());
                   }
               }

               MemberCouponPO po = new MemberCouponPO();
               po.setMbrGrdCd(mbrGrdCd);
               po.setDtlCds(dtlCds);
               
               if(!dtlCds.isEmpty()){
                   result = memberBatchService.insertMemberGrdCoupon(po,cpNos);
                   blpo.setBatchRstMsg("###### Success : " + result);
                   blpo.setBatchRstCd(CommonConstants.BATCH_RST_CD_SUCCESS);
               }else{
                   //자동 지급 공통 코드에 쿠폰 번호가 아무것도 등록 안되었을 때
                   throw new CustomException(ExceptionConstants.ERROR_COUPON_NO_DATA);
               }
           }else{
               //공통 코드 등록 안되어 있거나 전부다 N일 때
               throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
           }
       }catch(CustomException cep){
           log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE,cep);
           blpo.setBatchRstCd(cep.getExCode());
           if(StringUtil.equals(cep.getExCode(),ExceptionConstants.ERROR_COUPON_NO_DATA)){
               blpo.setBatchRstMsg("#### usrDfn1Val is empty, CouponNo is Not registered");
           }
           else if(StringUtil.equals(cep.getExCode(),ExceptionConstants.ERROR_CODE_DEFAULT)){
               blpo.setBatchRstMsg("#### Not Registered Code or Not Exist useYn is Y");
           }
       }catch(Exception e){
           log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE,e);
           blpo.setBatchRstCd(CommonConstants.BATCH_RST_CD_FAIL);
           blpo.setBatchRstMsg(e.getClass() + "," + e.getMessage().substring(0,2000)+"...");
       }
       finally {
           blpo.setSysRegrNo(CommonConstants.COMMON_BATCH_USR_NO);
           blpo.setSysUpdrNo(CommonConstants.COMMON_BATCH_USR_NO);
           blpo.setBatchEndDtm(DateUtil.getTimestamp());

           batchService.insertBatchLog(blpo);
       }
    }

    //회원 VIP 등급 쿠폰 지급
    public void insertMemberVipCoupon(){
        String mbrGrdCd = CommonConstants.MBR_GRD_20;
        BatchLogPO blpo = new BatchLogPO();
        blpo.setBatchId(CommonConstants.BT_MBR_GRD_VIP_COUPON_INSERT);
        blpo.setBatchStrtDtm(DateUtil.getTimestamp());
        int result = 0;

        try{
            List<CodeDetailVO> list = cacheService.listCodeCache(CommonConstants.AUTO_ISU_COUPON,true,null,mbrGrdCd,null,null,null);
            List<Long> cpNos = new ArrayList<Long>();
            List<String> dtlCds = new ArrayList<String>();

            //공통 코드 등록 안되어거나 전부다 N일 때
            if(!list.isEmpty()){
                for(CodeDetailVO code : list){
                    if(StringUtil.isNotEmpty(code.getUsrDfn1Val())){
                        dtlCds.add(code.getDtlCd());
                        cpNos.add(Long.parseLong(code.getUsrDfn1Val()));
                    }else{
                        log.error("##### {} is UsrDfn1Val is Null",code.getDtlCd());
                    }
                }

                MemberCouponPO po = new MemberCouponPO();
                po.setMbrGrdCd(mbrGrdCd);
                po.setDtlCds(dtlCds);

                if(!dtlCds.isEmpty()){
                    result = memberBatchService.insertMemberGrdCoupon(po,cpNos);
                    blpo.setBatchRstMsg("###### Success : " + result);
                    blpo.setBatchRstCd(CommonConstants.BATCH_RST_CD_SUCCESS);
                }else{
                    //자동 지급 공통 코드에 쿠폰 번호가 아무것도 등록 안되었을 때
                    throw new CustomException(ExceptionConstants.ERROR_COUPON_NO_DATA);
                }
            }else{
                //공통 코드 등록 안되어 있거나 전부다 N일 때
                throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
            }
        }catch(CustomException cep){
            log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE,cep);
            blpo.setBatchRstCd(cep.getExCode());
            if(StringUtil.equals(cep.getExCode(),ExceptionConstants.ERROR_COUPON_NO_DATA)){
                blpo.setBatchRstMsg("#### usrDfn1Val is empty, CouponNo is Not registered");
            }
            else if(StringUtil.equals(cep.getExCode(),ExceptionConstants.ERROR_CODE_DEFAULT)){
                blpo.setBatchRstMsg("#### Not Registered Code or Not Exist useYn is Y");
            }
        }catch(Exception e){
            log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE,e);
            blpo.setBatchRstCd(CommonConstants.BATCH_RST_CD_FAIL);
            blpo.setBatchRstMsg(e.getClass() + "," + e.getMessage().substring(0,2000)+"...");
        }
        finally {
            blpo.setSysRegrNo(CommonConstants.COMMON_BATCH_USR_NO);
            blpo.setSysUpdrNo(CommonConstants.COMMON_BATCH_USR_NO);
            blpo.setBatchEndDtm(DateUtil.getTimestamp());

            batchService.insertBatchLog(blpo);
        }
    }

    //회원 VVIP 등급 쿠폰 지급
    public void insertMemberVvipCoupon(){
        String mbrGrdCd = CommonConstants.MBR_GRD_10;
        BatchLogPO blpo = new BatchLogPO();
        blpo.setBatchId(CommonConstants.BT_MBR_GRD_VVIP_COUPON_INSERT);
        blpo.setBatchStrtDtm(DateUtil.getTimestamp());
        int result = 0;

        try{
            List<CodeDetailVO> list = cacheService.listCodeCache(CommonConstants.AUTO_ISU_COUPON,true,null,mbrGrdCd,null,null,null);
            List<Long> cpNos = new ArrayList<Long>();
            List<String> dtlCds = new ArrayList<String>();

            //공통 코드 등록 안되어거나 전부다 N일 때
            if(!list.isEmpty()){
                for(CodeDetailVO code : list){
                    if(StringUtil.isNotEmpty(code.getUsrDfn1Val())){
                        dtlCds.add(code.getDtlCd());
                        cpNos.add(Long.parseLong(code.getUsrDfn1Val()));
                    }else{
                        log.error("##### {} is UsrDfn1Val is Null",code.getDtlCd());
                    }
                }

                MemberCouponPO po = new MemberCouponPO();
                po.setMbrGrdCd(mbrGrdCd);
                po.setDtlCds(dtlCds);

                if(!dtlCds.isEmpty()){
                    result = memberBatchService.insertMemberGrdCoupon(po,cpNos);
                    blpo.setBatchRstMsg("###### Success : " + result);
                    blpo.setBatchRstCd(CommonConstants.BATCH_RST_CD_SUCCESS);
                }else{
                    //자동 지급 공통 코드에 쿠폰 번호가 아무것도 등록 안되었을 때
                    throw new CustomException(ExceptionConstants.ERROR_COUPON_NO_DATA);
                }
            }else{
                //공통 코드 등록 안되어 있거나 전부다 N일 때
                throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
            }
        }catch(CustomException cep){
            log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE,cep);
            blpo.setBatchRstCd(cep.getExCode());
            if(StringUtil.equals(cep.getExCode(),ExceptionConstants.ERROR_COUPON_NO_DATA)){
                blpo.setBatchRstMsg("#### usrDfn1Val is empty, CouponNo is Not registered");
            }
            else if(StringUtil.equals(cep.getExCode(),ExceptionConstants.ERROR_CODE_DEFAULT)){
                blpo.setBatchRstMsg("#### Not Registered Code or Not Exist useYn is Y");
            }
        }catch(NumberFormatException nfe){
            log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE,nfe);
            blpo.setBatchRstCd(CommonConstants.BATCH_RST_CD_FAIL);
            blpo.setBatchRstMsg("#### usrDfn1Val is Not Correct , Plz Check usrDfn1Val required Number");
        }
        catch(Exception e){
            log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE,e);
            blpo.setBatchRstCd(CommonConstants.BATCH_RST_CD_FAIL);
            blpo.setBatchRstMsg(e.getClass() + "," + e.getMessage().substring(0,2000)+"...");
        }
        finally {
            blpo.setSysRegrNo(CommonConstants.COMMON_BATCH_USR_NO);
            blpo.setSysUpdrNo(CommonConstants.COMMON_BATCH_USR_NO);
            blpo.setBatchEndDtm(DateUtil.getTimestamp());

            batchService.insertBatchLog(blpo);
        }
    }

    //회원 쿠폰 발급 대기 대상 발급 처리
    public void insertMemberStbCoupon(){

		/* 매일 6시 수행 */
		log.error("[ NOT ERROR ] ============== 회원 쿠폰 발급 대기 대상 발급 처리 배치 시작 ==============");
		
		MemberCouponPO po = new MemberCouponPO();
		CouponIssueVO couponIssue = new CouponIssueVO();
		int totalCnt = 0;
		int successCnt = 0;
		int failCnt = 0;
		BatchLogPO blpo = new BatchLogPO();
		String RstMsg = "";

        try{
			blpo.setBatchStrtDtm(DateUtil.getTimestamp());
			blpo.setBatchId(CommonConstants.BATCH_STB_COUPON);
			blpo.setBatchEndDtm(DateUtil.getTimestamp());
			
			// 데이터(사용) 보관주기 - 1일(다음 배치 때)
			memberCouponService.deleteCouponIsuStbUse();

			// 당일이 '적용시작일시' 일 경우
			List<MemberCouponVO> voList = memberBatchService.listCouponIsuStbBatch();

			totalCnt = voList.size();

			for(MemberCouponVO vo : voList) {
				po.setCpNo(vo.getCpNo());
				po.setMbrNo(vo.getMbrNo());
				po.setIsuTpCd(CommonConstants.ISU_TP_10);
				po.setIsuSrlNo("");
				po.setUseYn(CommonConstants.USE_YN_N);
				po.setSysRegrNo(vo.getMbrNo());

				Long result = memberCouponService.insertMemberCoupon(po, true);
				log.error("[ NOT ERROR ] insertMemberCoupon end " + result.toString());
				log.error("[ NOT ERROR ] insertMemberCoupon end " + po);
				if(result != null){
					memberCouponService.updateCouponIsuStbUse(vo.getCpNo(), vo.getMbrNo());
					successCnt++;
				}else{
					failCnt++;
				}
			}

			blpo.setBatchRstCd(CommonConstants.BATCH_RST_CD_SUCCESS);
			RstMsg = "Success [" + totalCnt + " total, " + successCnt + " success, " + failCnt + " failed]";
			blpo.setBatchRstMsg(RstMsg);

        }catch(Exception e){
			log.error("[ ERROR ] ============== Exception ============== " + e.getMessage());
			blpo.setBatchRstCd(CommonConstants.BATCH_RST_CD_FAIL);
			RstMsg = "Fail [" + totalCnt + " total, " + successCnt + " success, " + failCnt + " failed]";
			blpo.setBatchRstMsg(RstMsg);
        }finally {
            blpo.setSysRegrNo(CommonConstants.COMMON_BATCH_USR_NO);
            blpo.setSysUpdrNo(CommonConstants.COMMON_BATCH_USR_NO);
            blpo.setBatchEndDtm(DateUtil.getTimestamp());

            batchService.insertBatchLog(blpo);
			log.error("[ NOT ERROR ] ============== 회원 쿠폰 발급 대기 대상 발급 처리 배치 종료 ==============");
        }
    }

}
