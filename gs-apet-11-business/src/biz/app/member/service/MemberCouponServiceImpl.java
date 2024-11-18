package biz.app.member.service;

import java.net.URLEncoder;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Optional;
import java.util.Properties;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jcraft.jsch.SftpException;

import biz.app.appweb.model.PushSO;
import biz.app.appweb.model.PushVO;
import biz.app.appweb.service.PushService;
import biz.app.event.dao.FrontEventDao;
import biz.app.member.dao.MemberBaseDao;
import biz.app.member.dao.MemberCouponDao;
import biz.app.member.model.MemberBaseSO;
import biz.app.member.model.MemberBaseVO;
import biz.app.member.model.MemberCouponPO;
import biz.app.member.model.MemberCouponSO;
import biz.app.member.model.MemberCouponVO;
import biz.app.promotion.dao.CouponDao;
import biz.app.promotion.dao.CouponIssueDao;
import biz.app.promotion.model.CouponBaseVO;
import biz.app.promotion.model.CouponIssuePO;
import biz.app.promotion.model.CouponIssueSO;
import biz.app.promotion.model.CouponIssueVO;
import biz.app.promotion.model.CouponSO;
import biz.app.promotion.service.CouponService;
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
import framework.common.util.FileUtil;
import framework.common.util.StringUtil;
import framework.front.constants.FrontConstants;
import framework.front.util.FrontSessionUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Transactional
@Service("memberCouponService")
public class MemberCouponServiceImpl implements MemberCouponService {

	@Autowired private MemberCouponDao memberCouponDao;
	@Autowired private CouponDao couponDao;
	@Autowired private CouponIssueDao couponIssueDao;

	@Autowired private BizService bizService;

	@Autowired private StService stService;

	@Autowired private CouponService couponService;
	@Autowired private PushService pushService;

	@Autowired private CacheService cacheService;

	@Autowired
	private Properties bizConfig;

	@Autowired private MemberBaseDao memberBaseDao;

	@Autowired private FrontEventDao frontEventDao;

	/*
	 * 회원쿠폰 사용처리
	 * @see biz.app.member.service.MemberCouponService#updateMemberCouponUse(biz.app.member.model.MemberCouponPO)
	 */
	@Override
	public void updateMemberCouponUse(Long mbrCpNo, String ordNo) {

		MemberCouponSO mcso = new MemberCouponSO();
		mcso.setMbrCpNo(mbrCpNo);
		MemberCouponVO memberCoupon = this.memberCouponDao.getMemberCoupon(mcso);

		if(memberCoupon != null){
			/*******************************
			 * Validation
			 *******************************/
			/*
			 * 쿠폰 사용 여부 체크
			 */
			if(CommonConstants.COMM_YN_Y.equals(memberCoupon.getUseYn())){
				throw new CustomException(ExceptionConstants.ERROR_COUPON_USE);
			}
			/*
			 * 쿠폰 사용 기간 체크
			 */
			if(!CommonConstants.COMM_YN_Y.equals(memberCoupon.getUsePsbYn())){
				throw new CustomException(ExceptionConstants.ERROR_COUPON_NO_PERIOD);
			}

			/*******************************
			 * 쿠폰 사용 처리
			 *******************************/
			MemberCouponPO mcpo = new MemberCouponPO();
			mcpo.setMbrCpNo(mbrCpNo);
			if(ordNo != null){
				mcpo.setOrdNo(ordNo);
			}
			this.memberCouponDao.updateMemberCouponUse(mcpo);
		}else{
			throw new CustomException(ExceptionConstants.ERROR_COUPON_NO_DATA);
		}
	}

	@Override
	public Long insertMemberCoupon(MemberCouponPO po) {
		return insertMemberCoupon(po,false);
	}

	@Override // cpNo 와 mbrNo 및 isuTpCd만 사전에 set
	public Long insertMemberCoupon(MemberCouponPO po, Boolean isBatch) {
		//자동 발급 쿠폰 여부
		Boolean isAutoIsuuCp = false;
		//난수 생성 쿠폰 일시
		String isuSrlNo = Optional.ofNullable(po.getIsuSrlNo()).orElseGet(()->"");
		if(StringUtil.isNotEmpty(isuSrlNo)){
			CouponIssueSO ciso = new CouponIssueSO();
			ciso.setIsuSrlNo(isuSrlNo);
			CouponIssueVO civo = Optional.ofNullable(couponIssueDao.getCouponIssue(ciso)).orElseThrow(()->new CustomException(ExceptionConstants.ERROR_COUPON_NO_DATA)); // 쿠폰 번호를 다시 확인해주세요.
			po.setCpNo(civo.getCpNo());
		}

		//회원 번호 없을 시 Exception
		Long mbrNo = Optional.ofNullable(po.getMbrNo()).orElseThrow(()->new CustomException(ExceptionConstants.ERROR_MEMBER_NO_MEMBER));
		if(Long.compare(mbrNo,CommonConstants.NO_MEMBER_NO) == 0){
			throw new CustomException(ExceptionConstants.ERROR_MEMBER_NO_MEMBER);
		}
		
		//쿠폰 번호 없을 시 Exception
		Long cpNo = Optional.ofNullable(po.getCpNo()).orElseThrow(()->new CustomException(ExceptionConstants.ERROR_COUPON_NO_DATA));
		
		CouponSO cso = new CouponSO();
		cso.setCpNo(cpNo);

		CouponBaseVO coupon = Optional.ofNullable(couponService.getCoupon(cso)).orElseThrow(()->new CustomException(ExceptionConstants.ERROR_COUPON_NO_DATA)); // 쿠폰번호를 다시 확인해주세요.
		
		//자동 발급 쿠폰
		List<Long> autoIsuCpNos = new ArrayList<Long>();
		try{
			cacheService.listCodeCache(FrontConstants.AUTO_ISU_COUPON,true,null,null,null,null,null).stream().forEach(v->{
				String usr1 = Optional.ofNullable(v.getUsrDfn1Val()).orElseGet(()->"");
				if(StringUtil.isNotEmpty(usr1)){
					//이벤트 관련 일 떄 , 구분자 ; ( [0] : 쿠폰 번호  , [1] : 쿠폰 지급 횟수 )
					if(StringUtil.equals(v.getDtlCd(),CommonConstants.AUTO_ISU_COUPON_EVENT)){
						Long cn = Long.parseLong(usr1.split(";")[0]);
						autoIsuCpNos.add(cn);
					}else{
						autoIsuCpNos.add(Long.parseLong(usr1));
					}
				}
			});
		}catch(NumberFormatException nfe){
			log.error("### Plz Check usrDfn1Val Number Format");
		}catch(ArrayIndexOutOfBoundsException aie){
			log.error("### Plz Check usrDfn1Val Format ( ex : 쿠폰번호;지급횟수 ) ");
		}catch(Exception e){
			log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE,e);
		}
		isAutoIsuuCp = autoIsuCpNos.indexOf(coupon.getCpNo()) > -1;
		
		MemberBaseSO s = new MemberBaseSO();
		s.setMbrNo(mbrNo);
		MemberBaseVO v = memberBaseDao.getMemberBase(s);

		//정회원, 준회원 발급 조건 유효성 체크(자동 지급 쿠폰 제외)
		if(autoIsuCpNos.size() > 0 && !isAutoIsuuCp){
			String mbrGbCd = "";
			if(isBatch){
				mbrGbCd = v.getMbrGbCd();
			}else{
				mbrGbCd = FrontSessionUtil.getSession().getMbrGbCd();
			}
			
			String isuTgCd = coupon.getIsuTgCd();
			if(!StringUtil.equals(isuTgCd,FrontConstants.ISU_TG_00)){
				// 발급 대상 코드가 준회원이지만, 해당 회원이 준회원 아닐 때
				if(StringUtil.equals(isuTgCd,FrontConstants.ISU_TG_10) && !StringUtil.equals(mbrGbCd,FrontConstants.MBR_GB_CD_20)){
					throw new CustomException(ExceptionConstants.ERROR_COUPON_NOT_MATCHED_ASSOCIATE_MBR);
				}
				// 발급 대상 코드가 정회원이지만, 해당 회원이 정회원이 아닐 때
				if(StringUtil.equals(isuTgCd,FrontConstants.ISU_TG_20) && !StringUtil.equals(mbrGbCd,FrontConstants.MBR_GB_CD_10)){
					throw new CustomException(ExceptionConstants.ERROR_COUPON_NOT_MATCHED_INTERGRATED_MBR);
				}
			}
		}
		
		//회원등급 유효성 체크
		if (coupon.getMbrGrdCd() != null && coupon.getMbrGrdCd().length() > 0) {
			String[] arrMbrGrdCd = coupon.getMbrGrdCd().split(",");
			String mbrGrdCd = v.getMbrGrdCd();
			
			int cntMbrGrdCd = 0;
			for (String cpMbrGrdCd : arrMbrGrdCd) {
				if(StringUtil.equals(mbrGrdCd, cpMbrGrdCd)){
					cntMbrGrdCd++;
				}
			}
			// 아쉽지만 쿠폰 발급대상이 아니에요.
			if(cntMbrGrdCd == 0){
				throw new CustomException(ExceptionConstants.ERROR_COUPON_NOT_MATCHED_MBR_GRD);
			}
		}
		
		//쿠폰 유효기간
		long today = System.currentTimeMillis();
		long aplStrtDtm = coupon.getAplStrtDtm().getTime();
		long aplEndDtm = coupon.getAplEndDtm().getTime();
		Timestamp useStrtDtm = null;
		Timestamp useEndDtm = null;
		Long diff = null;
		Double d = null;

		//쿠폰 상태 확인
		if(CommonConstants.CP_STAT_20.equals(coupon.getCpStatCd())){
			// 적용시작일시
			//if(aplStrtDtm<=today && today<=aplEndDtm){
			if(today<=aplEndDtm){
				// 유효기간코드 10: 발급일, 20: 일자지정  , 사용시작일시와 사용종료일시 세팅
				if(CommonConstants.VLD_PRD_10.equals(coupon.getVldPrdCd())){
					String ss = DateUtil.getNowDate()+" 00:00:00";
					useStrtDtm = DateUtil.getTimestamp(ss, "yyyyMMdd 00:00:00") ;

					String e = DateUtil.addDays(DateUtil.getNowDate(), coupon.getVldPrdDay().intValue())+" 23:59:59" ;
					useEndDtm = DateUtil.getTimestamp(e, "yyyyMMdd HH:mm:ss");

					d = coupon.getAplVal().doubleValue();	// 남을 일수
				}else{
					useStrtDtm = coupon.getVldPrdStrtDtm();
					useEndDtm = coupon.getVldPrdEndDtm();

					diff = useEndDtm.getTime() - today;
					d = Math.ceil((diff)/(24*60*60*1000)); // 남은 일수
				}

				po.setUseStrtDtm(useStrtDtm);
				po.setUseEndDtm(useEndDtm);

				//해당 쿠폰을 발급 받은적이 있는지 체크

				//난수 쿠폰일 때는 시리얼 번호로 coupon_issue , 단 발급 수가 1인 난수쿠폰 제외
				if(StringUtil.equals(coupon.getCpPvdMthCd(),CommonConstants.CP_PVD_MTH_20)){
					if(StringUtil.isNotEmpty(isuSrlNo) && Long.compare(coupon.getCpIsuQty(),1L) != 0){
						MemberCouponPO isuSrlNoCp = new MemberCouponPO();
						isuSrlNoCp.setIsuSrlNo(isuSrlNo);
						if(Integer.compare(memberCouponDao.getMemberIsuCouponCnt(isuSrlNoCp),0) != 0){
							throw new CustomException(ExceptionConstants.ERROR_COUPON_ALREADY_DOWNLOAD); // 이미 등록된 쿠폰입니다.
						}
					}
				}
						
				if(Integer.compare(memberCouponDao.getMemberCouponCnt(po) ,0) != 0){
					throw new CustomException(ExceptionConstants.ERROR_COUPON_ALREADY_DOWNLOAD); // 이미 등록된 쿠폰입니다.
				}

				// 쿠폰 발급 수량이 제한일 경우
				if(CommonConstants.CP_ISU_20.equals(coupon.getCpIsuCd())){
					//난수 생성 쿠폰이고 발급 제한이 1일 경우 빌급 제한 유효성 검증 X
					String cpPvdMth = coupon.getCpPvdMthCd();
					Long limitCnt = coupon.getCpIsuQty();
					
					//발급 수량 체크 케이스
					/*
						CASE 1 : 난수면서, 제한이 1이 아닐 때
							혹은
						CASE 2 : 난수가 아닐 때
					 */
					Boolean isCheckIsuQty = (StringUtil.equals(cpPvdMth,CommonConstants.CP_PVD_MTH_20) && Long.compare(limitCnt,1L) != 0 )
							|| !StringUtil.equals(cpPvdMth,CommonConstants.CP_PVD_MTH_20) ;

					//현재 해당 쿠폰발급 수량 count
					Integer cpIsuQty = memberCouponDao.getCouponBaseIsuQty(po);
					if(isCheckIsuQty && cpIsuQty >= coupon.getCpIsuQty()) {
						throw new CustomException(ExceptionConstants.ERROR_COUPON_NO_AVAILABLE_QTY); //쿠폰 발급이 마감되었습니다.
					}
				}
			}else{
				throw new CustomException(ExceptionConstants.ERROR_COUPON_NO_PERIOD);	//발급 기간이 종료된 쿠폰입니다.
			}
		}else{
			throw new CustomException(ExceptionConstants.ERROR_COUPON_NO_NORMAL);	// 정상 쿠폰이 아닙니다.
		}

		po.setUseYn(CommonConstants.COMM_YN_N);
		Long mbrCpNo = 0L;
		po.setSysRegrNo(Optional.ofNullable(po.getSysRegrNo()).orElseGet(()->mbrNo));
		po.setSysUpdrNo(Optional.ofNullable(po.getSysUpdrNo()).orElseGet(()->mbrNo));
		
		if(aplStrtDtm<=today){
			if(( isBatch ? memberCouponDao.insertMemberCouponIsBatch(po) : memberCouponDao.insertMemberCoupon(po)) == 0){
				throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
			}
			mbrCpNo = po.getMbrCpNo();

			//난수 생성(=시리얼 쿠폰) 일 때 , 단 발급 수가 1이 아닌 경우에만
			if(StringUtil.equals(coupon.getCpPvdMthCd(),CommonConstants.CP_PVD_MTH_20)){
				if(StringUtil.isNotEmpty(isuSrlNo) && Long.compare(coupon.getCpIsuQty(),1L) != 0){
					CouponIssuePO cipo = new CouponIssuePO();
					cipo.setCpNo(coupon.getCpNo());
					cipo.setMbrCpNo(mbrCpNo);
					cipo.setIsuSrlNo(isuSrlNo);
					if((isBatch ? couponIssueDao.updateCouponIsuueBatch(cipo) : couponIssueDao.updateCouponIssue(cipo)) == 0){
						throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
					}
				}
			}

			//발급 완료 및, 일림 여부 Y일 때 , 자동 지급 쿠폰 제외
			try{
				if(Long.compare(mbrCpNo,0L) != 0 && StringUtil.equals(coupon.getMsgSndYn(),CommonConstants.COMM_YN_Y) && !isAutoIsuuCp){
					MemberCouponVO sendCoupon = new MemberCouponVO();
					sendCoupon.setCpNm(coupon.getCpNm());
					memberCouponInsertLmsSend(mbrNo,sendCoupon);
				}
			}catch(Exception e){
				log.error("### invoke Exception When Seding Lms");
				if(!isBatch){
					log.error("### Cls : {}",e.getClass());
					log.error("### mbr-cp-no : {}",mbrCpNo);
					log.error("### mbr-no : {}",mbrNo);
				}
			}
		}else{
			// 쿠폰 발급 대기 등록(수동)
			if(StringUtil.equals(coupon.getCpPvdMthCd(),CommonConstants.CP_PVD_MTH_40)){
				if(( isBatch ? memberCouponDao.insertCouponIsuStbIsBatch(po) : memberCouponDao.insertCouponIsuStb(po)) == 0){
					throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
				}
			}else{
				throw new CustomException(ExceptionConstants.ERROR_COUPON_NO_PERIOD);	//발급 기간이 종료된 쿠폰입니다.
			}
		}
		return mbrCpNo;
	}

	@Override
	public void memberCouponInsertLmsSend(Long mbrNo , MemberCouponVO sendCoupon) {
		StStdInfoVO vo = stService.getStStdInfo(CommonConstants.DEFAULT_ST_ID);
		String csTelNo = Optional.ofNullable(vo.getCsTelNo()).orElseGet(()->CommonConstants.DEFAULT_CS_TEL_NO);
		if(csTelNo.length() == 7){
			csTelNo = csTelNo.substring(0,3) + "-"+csTelNo.substring(3);
		}else if(csTelNo.length() == 8){
			csTelNo = csTelNo.substring(0,4) + "-"+csTelNo.substring(4);
		}

		SsgMessageSendPO msg = new SsgMessageSendPO();

		//수신자 정보 ( 암호화 되어있으면 안됨 )
		MemberBaseSO s = new MemberBaseSO();
		s.setMbrNo(mbrNo);
		MemberBaseVO v = memberBaseDao.getMemberBase(s);
		String mbrNm = bizService.twoWayDecrypt(v.getMbrNm());
		String mobile = bizService.twoWayDecrypt(v.getMobile());
		String mkngRcvYn = v.getMkngRcvYn();
		
		//이벤트성(=마케팅 수신여부) 플래그 확인
		if(StringUtil.equals(mkngRcvYn,CommonConstants.COMM_YN_Y)){
			//이름,핸드폰 번호 체크
			if(StringUtil.isNotEmpty(mbrNm) && StringUtil.isNotEmpty(mobile)){
				CodeDetailVO template= cacheService.getCodeCache(CommonConstants.TMPL_NO,CommonConstants.TMPL_COPON_INSERT);
				Long tmplNo = Long.parseLong(template.getUsrDfn1Val().trim());
				String sendType = template.getUsrDfn2Val();

				// MMS/LMS/SMS
				msg.setSndTypeCd(sendType);
				msg.setMbrNo(mbrNo);
				msg.setFuserid(String.valueOf(mbrNo));

				PushSO pso = new PushSO();
				pso.setTmplNo(tmplNo);

				PushVO pvo = pushService.getNoticeTemplate(pso); // 템플릿 조회
				String tmplContents = pvo.getContents(); //템플릿 내용

				//발급 안내
				String domain = Optional.ofNullable(bizConfig.getProperty("cookie.domain")).orElseGet(()->vo.getStUrl());

				String encMbrNo = bizService.twoWayEncrypt(mbrNo.toString());
				encMbrNo = URLEncoder.encode(encMbrNo);
				String myCouponUrl = domain + "/mypage/info/go-coupon?t="+encMbrNo;
				String cpNm = sendCoupon.getCpNm();

				//공통 바인드 변수
				tmplContents = StringUtil.replaceAll(tmplContents,CommonConstants.PUSH_TMPL_VRBL_20,mbrNm);
				tmplContents = StringUtil.replaceAll(tmplContents,CommonConstants.PUSH_TMPL_VRBL_120,cpNm);
				tmplContents = StringUtil.replaceAll(tmplContents,CommonConstants.PUSH_TMPL_VRBL_300,csTelNo);
				tmplContents = StringUtil.replaceAll(tmplContents,CommonConstants.PUSH_TMPL_VRBL_130,myCouponUrl);

				//바인드 변수 쿠폰 속성으로 replace
				msg.setFsubject(pvo.getSubject()); //템플릿 제목 set
				msg.setFmessage(tmplContents); // 템플릿 내용 replace(데이터 바인딩)
				//수신자 번호 set
				msg.setFdestine(mobile);

				/*** 쿠폰발급 메세지는 야간 전송 여부 N **/

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

				int result = bizService.sendMessage(msg);
				if(result == 0){
					log.error("##### ERROR SENDING FAILED {}",sendCoupon.getMbrCpNo());
				}
			}
		}
	}

	//한명에게 같은 쿠폰 여러번 줄 때 사용(시리얼 제외)
	@Override
	public List<Long> insertMemberCoupon(MemberCouponPO po, Integer n) {
		List<Long> result = new ArrayList<Long>();

		//난수 생성 쿠폰 일시
		String isuSrlNo = Optional.ofNullable(po.getIsuSrlNo()).orElseGet(()->"");
		if(StringUtil.isNotEmpty(isuSrlNo)){
			CouponIssueSO ciso = new CouponIssueSO();
			ciso.setIsuSrlNo(isuSrlNo);
			CouponIssueVO civo = Optional.ofNullable(couponIssueDao.getCouponIssue(ciso)).orElseThrow(()->new CustomException(ExceptionConstants.ERROR_COUPON_NO_DATA)); // 쿠폰 번호를 다시 확인해주세요.
			po.setCpNo(civo.getCpNo());
		}

		Long mbrNo = po.getMbrNo();
		Long cpNo = Optional.ofNullable(po.getCpNo()).orElseThrow(()->new CustomException(ExceptionConstants.ERROR_COUPON_NO_DATA));

		CouponSO cso = new CouponSO();
		cso.setCpNo(cpNo);

		CouponBaseVO coupon = Optional.ofNullable(couponService.getCoupon(cso)).orElseThrow(()->new CustomException(ExceptionConstants.ERROR_COUPON_NO_DATA)); // 쿠폰번호를 다시 확인해주세요.

		//정회원, 준회원 발급 조건 유효성 체크
		String mbrGbCd = FrontSessionUtil.getSession().getMbrGbCd();
		String isuTgCd = coupon.getIsuTgCd();
		if(!StringUtil.equals(isuTgCd,FrontConstants.ISU_TG_00)){
			// 발급 대상 코드가 준회원이지만, 해당 회원이 준회원 아닐 때
			if(StringUtil.equals(isuTgCd,FrontConstants.ISU_TG_10) && !StringUtil.equals(mbrGbCd,FrontConstants.MBR_GB_CD_20)){
				throw new CustomException(ExceptionConstants.ERROR_COUPON_NOT_MATCHED_ASSOCIATE_MBR);
			}
			// 발급 대상 코드가 정회원이지만, 해당 회원이 정회원이 아닐 때
			if(StringUtil.equals(isuTgCd,FrontConstants.ISU_TG_20) && !StringUtil.equals(mbrGbCd,FrontConstants.MBR_GB_CD_10)){
				throw new CustomException(ExceptionConstants.ERROR_COUPON_NOT_MATCHED_INTERGRATED_MBR);
			}
		}

		//쿠폰 유효기간
		long today = System.currentTimeMillis();
		long aplStrtDtm = coupon.getAplStrtDtm().getTime();
		long aplEndDtm = coupon.getAplEndDtm().getTime();
		Timestamp useStrtDtm = null;
		Timestamp useEndDtm = null;
		Long diff = null;
		Double d = null;

		Boolean isCheckIsuQty = false;

		//쿠폰 상태 확인
		if(CommonConstants.CP_STAT_20.equals(coupon.getCpStatCd())){
			// 적용시작일시
			if(aplStrtDtm<=today && today<=aplEndDtm){
				// 유효기간코드 10: 발급일, 20: 일자지정  , 사용시작일시와 사용종료일시 세팅
				if(CommonConstants.VLD_PRD_10.equals(coupon.getVldPrdCd())){
					String ss = DateUtil.getNowDate()+" 00:00:00";
					useStrtDtm = DateUtil.getTimestamp(ss, "yyyyMMdd 00:00:00") ;

					String e = DateUtil.addDays(DateUtil.getNowDate(), coupon.getVldPrdDay().intValue())+" 23:59:59" ;
					useEndDtm = DateUtil.getTimestamp(e, "yyyyMMdd HH:mm:ss");

					d = coupon.getAplVal().doubleValue();	// 남을 일수
				}else{
					useStrtDtm = coupon.getVldPrdStrtDtm();
					useEndDtm = coupon.getVldPrdEndDtm();

					diff = useEndDtm.getTime() - today;
					d = Math.ceil((diff)/(24*60*60*1000)); // 남은 일수
				}

				po.setUseStrtDtm(useStrtDtm);
				po.setUseEndDtm(useEndDtm);
				
				//쿠폰 중복 발급 유효성 및 발급 제한 유효성 제외
			}else{
				throw new CustomException(ExceptionConstants.ERROR_COUPON_NO_PERIOD);	//발급 기간이 종료된 쿠폰입니다.
			}
		}else{
			throw new CustomException(ExceptionConstants.ERROR_COUPON_NO_NORMAL);	// 정상 쿠폰이 아닙니다.
		}

		po.setUseYn(CommonConstants.COMM_YN_N);

		//중복 지급 진행
		n = Optional.ofNullable(n).orElseGet(()->1);
		for(int i=0; i<n; i+=1){
			Long mcn = 0L;
			if(memberCouponDao.insertMemberCoupon(po) == 0){
				throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
			}
			mcn = po.getMbrCpNo();
			result.add(mcn);
		}

		//발급 완료 및, 일림 여부 Y일 때 , 자동 지급 쿠폰 제외 -> 같은 쿠폰이기에 지급 완료 후 가장 마지막에 지급한 mbrCpNo로 lms 로직 처리
		try{
			Long mbrCpNo = result.get(result.size()-1);
			if(Long.compare(mbrCpNo,0L) != 0 && StringUtil.equals(coupon.getMsgSndYn(),CommonConstants.COMM_YN_Y) ){
				MemberCouponVO sendCoupon = new MemberCouponVO();
				sendCoupon.setCpNm(coupon.getCpNm());
				memberCouponInsertLmsSend(mbrNo,sendCoupon);
			}
		}catch(Exception e){
			log.error("### invoke Exception When Seding Lms");
		}

		return result;
	}

	@Override
	public List<MemberCouponVO> insertMemberCouponAll(MemberCouponPO po) {
		List<MemberCouponVO> result = new ArrayList<>();
		Long mbrNo = Optional.ofNullable(po.getMbrNo()).orElseGet(()-> FrontSessionUtil.getSession().getMbrNo());
		if(Long.compare(mbrNo,0L) == 0){
			throw new CustomException(ExceptionConstants.ERROR_CODE_LOGIN_REQUIRED_POP);
		}
		CouponSO so = new CouponSO();
		so.setMbrNo(mbrNo);
		so.setCpShowYn(CommonConstants.COMM_YN_Y);		// 쿠폰존 노출 되는 쿠폰만
		so.setOutsideCpYn(CommonConstants.COMM_YN_N);	// 외부 쿠폰 아닌 것
		so.setCpStatCd(CommonConstants.CP_STAT_20);		// 진행 중인 쿠폰만 조회
		so.setRows(999999);
		so.setSidx("CB.CP_APL_CD ASC, CB.APL_VAL DESC , CB.VLD_PRD_END_DTM ASC , CB.SYS_REG_DTM");
		so.setSord("DESC");
		so.setWebMobileGbCdList(po.getWebMobileGbCds());

		List<CouponBaseVO> couponList = Optional.ofNullable(couponDao.pageCoupon(so)).orElseGet(()->new ArrayList<>());
		for(CouponBaseVO v : couponList){
			MemberCouponVO r = new MemberCouponVO();
			r.setCpNo(v.getCpNo());

			po.setCpNo(v.getCpNo());
			po.setMbrNo(po.getMbrNo());
			po.setUseYn(po.getUseYn());
			po.setSysRegrNo(po.getMbrNo());
			boolean check = StringUtil.equals(CommonConstants.COMM_YN_N,v.getCpDwYn())
					|| ( StringUtil.equals(CommonConstants.COMM_YN_N,v.getCpDwYn()) && StringUtil.equals(CommonConstants.COMM_YN_N,v.getCpDwYn()));

			if(check){
				try {
					po.setIsuTpCd(CommonConstants.ISU_TP_10);
					Long mbrCpNo = insertMemberCoupon(po,true);
					r.setMbrCpNo(mbrCpNo);
					r.setResultCode(CommonConstants.CONTROLLER_RESULT_CODE_SUCCESS);
				}catch(CustomException cep){
					log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, cep);
					r.setResultCode(cep.getExCode());
				}
			}else{
				r.setResultCode(CommonConstants.CONTROLLER_RESULT_CODE_FAIL);
			}
			result.add(r);
		}

		return result;
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: MemberCouponServiceImpl.java
	* - 작성일		: 2016. 5. 10.
	* - 작성자		: kyh
	* - 설명		: 사용 가능 쿠폰 목록 조회 - BO
	* @see biz.app.member.service.MemberCouponService#memberListCouponPage()
	* </pre>
	* @param session
	* @param pswd
	* @param type
	* @return
	* @throws Exception
	*/
	@Override
	@Transactional(readOnly=true)
	public List<MemberCouponVO> memberListCouponPage(MemberCouponSO so) {
		return this.memberCouponDao.memberListCouponPage(so);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: MemberCouponServiceImpl.java
	* - 작성일		: 2016. 5. 10.
	* - 작성자		: kyh
	* - 설명		: 사용 완료 쿠폰 목록 조회 - BO
	* @see biz.app.member.service.MemberCouponService#memberListComCouponPage()
	* </pre>
	* @param session
	* @param pswd
	* @param type
	* @return
	* @throws Exception
	*/
	@Override
	@Transactional(readOnly=true)
	public List<MemberCouponVO> memberListComCouponPage(MemberCouponSO so) {
		return this.memberCouponDao.memberListComCouponPage(so);
	}



	@Override
	@Transactional(readOnly=true)
	public List<MemberCouponVO> listMemberCoupon(MemberCouponSO so) {
		so.setUseYn(FrontConstants.USE_YN_N);
		String sIdx = Optional.ofNullable(so.getSidx()).orElseGet(()->"CB.CP_APL_CD ASC, CB.APL_VAL DESC , MC.USE_END_DTM ASC , CB.SYS_REG_DTM");
		String sOrd = Optional.ofNullable(so.getSord()).orElseGet(()->"DESC");
		so.setSidx(sIdx);
		so.setSord(sOrd);
		return memberCouponDao.listMemberCoupon(so);
	}

	@Override
	@Transactional(readOnly=true)
	public List<MemberCouponVO> listMemberUsedCoupon(MemberCouponSO so) {
		so.setUseYn(FrontConstants.USE_YN_Y);
		so.setSidx("MC.USE_DTM DESC , MC.USE_END_DTM");
		so.setSord("DESC");
		return memberCouponDao.listMemberCoupon(so);
	}
	
	/**
	 * 마이페이지 > 쿠폰 > 쿠폰상세보기
	 */
	@Override
	public MemberCouponVO getMemberCouponDetail(MemberCouponSO so) {
		return this.memberCouponDao.getMemberCouponDetail(so);
	}

	/**
	 * 마이페이지 > 회원 보유 쿠폰 갯수 조회
	 */
	@Override
	public Integer getMemberCouponCountMyPage(MemberCouponSO so) {
		return this.memberCouponDao.getMemberCouponCountMyPage(so);
	}
	
	
	/**
	 * 등급쿠폰 예약발송 
	 *
	 * @param mbrNo
	 * @param sendCoupon
	 */
	@Override
	public void memberCouponResInsertLmsSend(Long mbrNo , MemberCouponVO sendCoupon) {
		StStdInfoVO vo = stService.getStStdInfo(CommonConstants.DEFAULT_ST_ID);
		String csTelNo = Optional.ofNullable(vo.getCsTelNo()).orElseGet(()->CommonConstants.DEFAULT_CS_TEL_NO);
		if(csTelNo.length() == 7){
			csTelNo = csTelNo.substring(0,3) + "-"+csTelNo.substring(3);
		}else if(csTelNo.length() == 8){
			csTelNo = csTelNo.substring(0,4) + "-"+csTelNo.substring(4);
		}

		SsgMessageSendPO msg = new SsgMessageSendPO();

		//수신자 정보 ( 암호화 되어있으면 안됨 )
		String mbrNm = Optional.ofNullable(sendCoupon.getMbrNm()).orElseGet(()->"");
		String mobile = Optional.ofNullable(sendCoupon.getMobile()).orElseGet(()->"");
		if(StringUtil.isEmpty(mbrNm) || StringUtil.isEmpty(mobile)){
			MemberBaseSO s = new MemberBaseSO();
			s.setMbrNo(mbrNo);
			MemberBaseVO v = memberBaseDao.getMemberBase(s);
			mbrNm = bizService.twoWayDecrypt(v.getMbrNm());
			mobile = bizService.twoWayDecrypt(v.getMobile());
		}


		if(StringUtil.isNotEmpty(mbrNm) && StringUtil.isNotEmpty(mobile)){
//          현재 시간이 8시~21사이가 아니면 익일 오전 8시 예약 발송
			SimpleDateFormat sDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String today = DateUtil.getTimestampToString(DateUtil.getTimestamp(), "yyyyMMdd");
			Calendar limitSendStartTime = DateUtil.getCalendar(today);
			Calendar limitSendEndTime = DateUtil.getCalendar(today);
			Calendar reservTime = DateUtil.getCalendar(today);
		
			limitSendStartTime.add(Calendar.HOUR_OF_DAY, 8);
			limitSendEndTime.add(Calendar.HOUR_OF_DAY, 21);
			reservTime.add(Calendar.HOUR_OF_DAY, 32);
			 
//			현재 시간이 8시~21사이가 아니면 익일 오전 8시 예약 발송  
			if( !DateUtil.isPast(sDate.format(limitSendStartTime.getTime())) && !DateUtil.isPast(sDate.format(limitSendEndTime.getTime()))
					) {
				msg.setNoticeTypeCd(CommonConstants.NOTICE_TYPE_10);// 즉시
			}else {
				msg.setFsenddate(DateUtil.getTimestamp(sDate.format(reservTime.getTime()), "yyyyMMddHHmmss"));
				msg.setNoticeTypeCd(CommonConstants.NOTICE_TYPE_20);// 예약
			}		
			CodeDetailVO template= cacheService.getCodeCache(CommonConstants.TMPL_NO,CommonConstants.TMPL_COPON_INSERT);
			Long tmplNo = Long.parseLong(template.getUsrDfn1Val().trim());
			String sendType = template.getUsrDfn2Val();

			// MMS/LMS/SMS
			msg.setSndTypeCd(sendType);
			msg.setMbrNo(mbrNo);
			msg.setFuserid(String.valueOf(mbrNo));

			PushSO pso = new PushSO();
			pso.setTmplNo(tmplNo);

			PushVO pvo = pushService.getNoticeTemplate(pso); // 템플릿 조회
			String tmplContents = pvo.getContents(); //템플릿 내용

			//발급 안내
			String domain = Optional.ofNullable(bizConfig.getProperty("cookie.domain")).orElseGet(()->vo.getStUrl());

			String encMbrNo = bizService.twoWayEncrypt(mbrNo.toString());
			encMbrNo = URLEncoder.encode(encMbrNo);
			String myCouponUrl = domain + "/mypage/info/go-coupon?t="+encMbrNo;
			String cpNm = sendCoupon.getCpNm();

			//공통 바인드 변수
			tmplContents = StringUtil.replaceAll(tmplContents,CommonConstants.PUSH_TMPL_VRBL_20,mbrNm);
			tmplContents = StringUtil.replaceAll(tmplContents,CommonConstants.PUSH_TMPL_VRBL_120,cpNm);
			tmplContents = StringUtil.replaceAll(tmplContents,CommonConstants.PUSH_TMPL_VRBL_300,csTelNo);
			tmplContents = StringUtil.replaceAll(tmplContents,CommonConstants.PUSH_TMPL_VRBL_130,myCouponUrl);
//			msg.setNoticeTypeCd(CommonConstants.NOTICE_TYPE_10);// 즉시

			//바인드 변수 쿠폰 속성으로 replace
			msg.setFsubject(pvo.getSubject()); //템플릿 제목 set
			msg.setFmessage(tmplContents); // 템플릿 내용 replace(데이터 바인딩)

			//수신자 번호 set
			msg.setFdestine(mobile);

			//msg.setFcallback("발신자번호");//어바웃 펫 대표번호 1644-9601 일 때만 발송 됨. service 에서 자동처리 하고 있음.

			int result = bizService.sendMessage(msg);
			if(result == 0){
				log.error("##### ERROR SENDING FAILED {}",sendCoupon.getMbrCpNo());
			}
		}
	}

	/*
	 * 회원쿠폰 대기 정상처리
	 * @see biz.app.member.service.MemberCouponService#updateCouponIsuStbUse(biz.app.member.model.MemberCouponPO)
	 */
	@Override
	public void updateCouponIsuStbUse(Long cpNo, Long mbrNo) {

		/*******************************
		 * 쿠폰  발급 처리
		 *******************************/
		MemberCouponPO mcpo = new MemberCouponPO();
		mcpo.setCpNo(cpNo);
		mcpo.setMbrNo(mbrNo);
		this.memberCouponDao.updateCouponIsuStbUse(mcpo);
		
	}

	/*
	 * 회원쿠폰 대기 처리 삭제
	 * @see biz.app.member.service.MemberCouponService#updateCouponIsuStbUse(biz.app.member.model.MemberCouponPO)
	 */
	@Override
	public void deleteCouponIsuStbUse() {

		/*******************************
		 * 쿠폰 발급 삭제
		 *******************************/
		this.memberCouponDao.deleteCouponIsuStbUse();
		
	}
}
