package batch.excute.member;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.servlet.http.HttpServletRequest;

import framework.common.exception.CustomException;
import org.codehaus.jackson.map.DeserializationConfig;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.fasterxml.jackson.core.type.TypeReference;

import biz.app.appweb.model.PushSO;
import biz.app.appweb.model.PushVO;
import biz.app.appweb.service.PushService;
import biz.app.batch.model.BatchLogPO;
import biz.app.batch.service.BatchService;
import biz.app.display.model.DisplayCategoryPO;
import biz.app.member.model.MemberAddressPO;
import biz.app.member.model.MemberAddressVO;
import biz.app.member.model.MemberBasePO;
import biz.app.member.model.MemberBaseSO;
import biz.app.member.model.MemberBaseVO;
import biz.app.member.model.MemberBizInfoPO;
import biz.app.member.model.MemberBizInfoVO;
import biz.app.member.model.MemberCouponPO;
import biz.app.member.model.MemberInterestGoodsPO;
import biz.app.member.model.MemberUnsubscribeVO;
import biz.app.member.service.MemberAddressService;
import biz.app.member.service.MemberBatchService;
import biz.app.member.service.MemberCouponService;
import biz.app.member.service.MemberDormantService;
import biz.app.member.service.MemberInterestGoodsService;
import biz.app.member.service.MemberLeaveService;
import biz.app.member.service.MemberSavedMoneyService;
import biz.app.system.model.CodeDetailVO;
import biz.common.model.SsgMessageSendPO;
import biz.common.service.BizService;
import biz.common.service.CacheService;
import framework.common.constants.CommonConstants;
import framework.common.util.DateUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class MemberExecute {

	@Autowired private MemberInterestGoodsService memberInterestGoodsService;

	@Autowired private Properties bizConfig;

	@Autowired private MemberBatchService memberBatchService;

	@Autowired private BizService bizService;

	@Autowired private BatchService batchService;

	@Autowired private MemberCouponService memberCouponService;

	@Autowired private CacheService cacheService;

	@Autowired private PushService pushService;

	@Autowired private MemberDormantService memberDormantService;

	@Autowired private MessageSourceAccessor message;

	@Autowired private MemberLeaveService memberLeaveService;




	/**
	* <pre>
	* - 프로젝트명	: 21.batch
	* - 파일명		: MemberExcute.java
	* - 작성일		: 2016. 7. 29.
	* - 작성자		: snw
	* - 설명		: 위시리스트 삭제
	* 등록일로부터 지정된 기간이 지난 위시리스트 삭제
	* </pre>
	*/
	//@Scheduled(cron = "0 40 4 * * *")
	public void cronWishDelete(){
		MemberInterestGoodsPO po = new MemberInterestGoodsPO();

		Long strgPeriod = Long.valueOf(this.bizConfig.getProperty("wish.list.expiry.date"));

		po.setStrgPeriod(strgPeriod);

		this.memberInterestGoodsService.deleteMemberInterestGoods(po);
	}


	/**
	* <pre>
	* - 프로젝트명	: 21.batch
	* - 파일명		: MemberExecute.java
	* - 작성일		: 2021. 03. 02.
	* - 작성자		: KSH
	* - 설명		: 080 수신거부 조회 및 동기화
	* </pre>
	*/
//	@Scheduled(fixedDelay=600000)
	public void syncUnsubscribes() {
		/***********************
		 * Batch Log Start
		 ***********************/
		BatchLogPO blpo = new BatchLogPO();
		blpo.setBatchId(CommonConstants.BATCH_SYNC_UNSUBSCRIBES);
		blpo.setBatchStrtDtm(DateUtil.getTimestamp());
		blpo.setSysRegrNo(CommonConstants.COMMON_BATCH_USR_NO);

		/***********************
		 * 080 수신거부 조회 및 동기화
		 ***********************/
		MemberUnsubscribeVO result = bizService.getUnsubscribes(CommonConstants.COMM_YN_Y);


		/***********************
		 * Batch Log End
		 ***********************/
		blpo.setBatchEndDtm(DateUtil.getTimestamp());
		blpo.setBatchRstCd(CommonConstants.BATCH_RST_CD_SUCCESS);
		String RstMsg = "Success["+result.getTotalCnt()+" total, "+result.getUpdateCnt()+" update, "+result.getFailCnt()+" failed]";
		blpo.setBatchRstMsg(RstMsg);

		if(result.getTotalCnt() != 0) {batchService.insertBatchLog(blpo);}
	}

	/**
	 * <pre>
	 * - 프로젝트명	:
	 * - 파일명		: MemberExecute.java
	 * - 작성일		: 2021. 3. 24.
	 * - 작성자		: 조은지
	 * - 설명			: 회원 생일 축하 쿠폰 발급 배치
	 * </pre>
	 */
	public void memberBirthdayCoupon() {

		/**
		 * 매일 자정 12시 수행
		 * 생일 일주일전 쿠폰 발급
		 */

		log.error("[ NOT ERROR ] ============== 회원 생일 축하 쿠폰 발급 배치 배치 시작 ==============");

		MemberCouponPO po = new MemberCouponPO();
		int totalCnt = 0;
		int successCnt = 0;
		int failCnt = 0;
		BatchLogPO blpo = new BatchLogPO();
		String RstMsg = "";

		try {

			blpo.setBatchStrtDtm(DateUtil.getTimestamp());
			blpo.setBatchId(CommonConstants.BATCH_BIRTHDAY_COUPON);
			blpo.setBatchEndDtm(DateUtil.getTimestamp());

			// 회원 구분이 '정회원', 회원 상태가 '정상', 생일 일주일전인 회원 조회
			List<MemberBaseVO> voList = memberBatchService.listMemberBaseForBirthdayBatch();

			totalCnt = voList.size();

			// 회원 생일 축하 쿠폰 공통코드 조회
			// 사용자 정의1값이 쿠폰 시퀀스임
			CodeDetailVO codeVO = cacheService.getCodeCache(CommonConstants.AUTO_ISU_COUPON, CommonConstants.AUTO_ISU_COUPON_BIRTHDAY);
			Long cpNo = Long.valueOf(codeVO.getUsrDfn1Val());

			po.setCpNo(cpNo);
			po.setIsuTpCd(CommonConstants.ISU_TP_10);
			po.setUseYn(CommonConstants.USE_YN_N);

			for(MemberBaseVO vo : voList) {
				po.setMbrNo(vo.getMbrNo());
				po.setSysRegrNo(vo.getMbrNo());

				Long result = memberCouponService.insertMemberCoupon(po, true);
				if(result != null)	{successCnt++;}
				else				{failCnt++;}
			}

			blpo.setBatchRstCd(CommonConstants.BATCH_RST_CD_SUCCESS);
			RstMsg = "Success [" + totalCnt + " total, " + successCnt + " success, " + failCnt + " failed]";
			blpo.setBatchRstMsg(RstMsg);

		}catch (Exception e){
			log.error("[ ERROR ] ============== Exception ============== " + e.getMessage());
			blpo.setBatchRstCd(CommonConstants.BATCH_RST_CD_FAIL);
			RstMsg = "Fail [" + totalCnt + " total, " + successCnt + " success, " + failCnt + " failed]";
			blpo.setBatchRstMsg(RstMsg);
		}finally {
			batchService.insertBatchLog(blpo);
			log.error("[ NOT ERROR ] ============== 회원 생일 축하 쿠폰 발급 배치 배치 종료 ==============");
		}

	}
	

	
	/**
	 * <pre>
	 * - 프로젝트명	: 
	 * - 파일명		: MemberExecute.java
	 * - 작성일		: 2021. 4. 1.
	 * - 작성자		: 조은지
	 * - 설명			: 휴면 예정 회원 알람 전송 배치 
	 * </pre>
	 */
	public void memberDomantAlarm() {
		/**
		 * 데일리 배치(오전 10시 수행)
		 * 휴면 예정인 회원들에게 SMS를 전송한다.
		 * SMS 전송 시점 : 휴면 처리 예정일 한달 전 
		 */

		SsgMessageSendPO msg = new SsgMessageSendPO();
		PushSO pso = new PushSO();
		pso.setSysCd(CommonConstants.SYS_MEMBER_DORMANT);
		
		PushVO pvo = pushService.getNoticeTemplate(pso); // 템플릿 조회
		String message2 = pvo.getContents().replace(CommonConstants.PUSH_TMPL_VRBL_280, DateUtil.addMonth("yyyy년 MM월 dd일", 1)); //템플릿 내용

		pso.setTmplNo(pvo.getTmplNo());
		msg.setSndTypeCd(CommonConstants.SND_TYPE_20); // MMS/LMS/SMS
		msg.setFsenddate(DateUtil.getTimestamp());
		
		int totalCnt = 0;
		int successCnt = 0;
		int failCnt = 0;
		
		BatchLogPO blpo = new BatchLogPO();
		blpo.setBatchStrtDtm(DateUtil.getTimestamp());
		
		/* 휴면 처리 한달 전 회원기본정보 조회 */
		List<MemberBaseVO> voList = memberBatchService.listMemberBaseForDomantAlarmBatch();
		
		totalCnt = voList.size();

		msg.setNoticeTypeCd(CommonConstants.NOTICE_TYPE_10);// 즉시
		
		for(MemberBaseVO vo : voList) {
			msg.setFuserid(String.valueOf(vo.getMbrNo()));
			msg.setFdestine(vo.getMobile());
			msg.setMbrNo(vo.getMbrNo());
			msg.setFmessage(message2.replace(CommonConstants.PUSH_TMPL_VRBL_10, vo.getLoginId()));
			
			int result = bizService.sendMessage(msg);
			if(result == 0)	{failCnt++;}
			else			{successCnt++;}
		}

		blpo.setBatchId(CommonConstants.BATCH_DORMANT_ALARM);
		blpo.setBatchEndDtm(DateUtil.getTimestamp());
		blpo.setBatchRstCd(CommonConstants.BATCH_RST_CD_SUCCESS);
		
		String RstMsg = "Success[" + totalCnt + " total, " + successCnt + " success, " + failCnt + " failed]";
		blpo.setBatchRstMsg(RstMsg);
		
		batchService.insertBatchLog(blpo);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 
	 * - 파일명		: MemberExecute.java
	 * - 작성일		: 2021. 4. 1.
	 * - 작성자		: 조은지
	 * - 설명			: 회원 휴면 배치
	 * </pre>
	 */
	public void memberDomant() {
		/**
		 * 데일리 배치(새벽 3시 수행)
		 * 1년간(년월일 기준) 로그인 이력이 없는 회원들에 대해 분리보관
		 * 
		 * === MEMBER_BASE ===
		 * 1. 보관DB로 복사시 모든 컬럼데이터 복사
		 * 2. 원DB 보관컬럼
		 * 	- MBR_NO			: 회원 번호
		 * 	- ST_ID				: 사이트 ID
		 * 	- LOGIN_ID			: 로그인 ID
		 * 	- NICK_NM			: 닉네임
		 * 	- MBR_STAT_CD		: 회원 상태 코드
		 * 	- DI_CTF_VAL		: DI 인증값
		 * 	- PSWD				: 비밀번호
		 * 	- PSWD_INIT_YN		: 비밀번호 초기화 여부
		 * 	- PSWD_CHG_DTM		: 비밀번호 변경 일시
		 * 	- LOGIN_FAIL_CNT	: 로그인 실패 수
		 * 	- LAST_LOGIN_DTM	: 최종 로그인 일시
		 * 	- PSWD_CHG_SCD_DTM	: 비밀번호 변경 예정일시	 
		 * 	- RCOM_LOGIN_ID		: 추천인 ID
		 * 
		 * === MEMBER_BIZ_INFO ===
		 * 1. 보관DB로 복사시 모든 컬럼데이터 복사
		 * 2. 원DB 보관컬럼
		 * 	- MBR_NO	: 회원 번호
		 * 	- BIZ_NO 	: 회사 번호
		 * 	- BIZ_ID	: 회사 아이디
		 * 
		 * === MEMBER_ADDRESS ===
		 * 1. 보관DB로 복사시 모든 컬럼데이터 복사
		 * 2. 원DB에서 로우 삭제
		 */
		
		/*int result = memberBatchService.procMemberDormantBatch();
		if(result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		} else {
			log.debug("회원 휴면 배치 완료");
		}*/
		
		String batchGb = "dormant";
		
		int dmbInsertCnt = 0;	// DORMANT_MEMBER_BASE insert 개수
		int dmbiInsertCnt = 0;	// DORMANT_MEMBER_BIZ_INFO insert 개수
		int dmaInsertCnt = 0;	// DORMANT_MEMBER_ADDRESS insert 개수
		
		int mbUpdateCnt = 0;	// MEMBER_BASE update 개수
		int mbiUpdateCnt = 0;	// MEMBER_BIZ_INFO update 개수
		int maDeleteCnt = 0;	// MEMBER_ADDRESS delete 개수
		
		BatchLogPO blpo = new BatchLogPO();
		blpo.setBatchStrtDtm(DateUtil.getTimestamp());
		
		blpo.setBatchId(CommonConstants.BATCH_MEMBER_DORMANT);
		blpo.setBatchEndDtm(DateUtil.getTimestamp());
		
		// 휴면 처리할 회원 정보 조회
		List<MemberBaseVO> listMemberBaseForDormantVO = memberBatchService.listMemberBaseForDormantOrLeave(batchGb);
		List<MemberBizInfoVO> listMemberBizInfoForDormantVO = memberBatchService.listMemberBizInfoForDormantOrLeave(batchGb);
		List<MemberAddressVO> listMemberAddressForDormantVO = memberBatchService.listMemberAddressForDormantOrLeave(batchGb);
		
		// 휴면 테이블로 이동시킬 회원 정보
		List<MemberBasePO> listMemberBasePO = new ArrayList<MemberBasePO>();
		List<MemberBizInfoPO> listMemberBizInfoPO = new ArrayList<MemberBizInfoPO>();
		List<MemberAddressPO> listMemberAddressPO = new ArrayList<MemberAddressPO>();

		ObjectMapper mapper = new ObjectMapper().configure(DeserializationConfig.Feature.FAIL_ON_UNKNOWN_PROPERTIES, false);
		
		try {
			for(MemberBaseVO vo : listMemberBaseForDormantVO) {
				String voStr = mapper.writeValueAsString(vo);
				MemberBasePO memberBasePO = mapper.readValue(voStr, MemberBasePO.class);
				listMemberBasePO.add(memberBasePO);
			}
			
			for(MemberBizInfoVO vo : listMemberBizInfoForDormantVO) {
				String voStr = mapper.writeValueAsString(vo);
				MemberBizInfoPO memberBizInfoPO = mapper.readValue(voStr, MemberBizInfoPO.class);
				listMemberBizInfoPO.add(memberBizInfoPO);
			}
			
			for(MemberAddressVO vo : listMemberAddressForDormantVO) {
				String voStr = mapper.writeValueAsString(vo);
				MemberAddressPO memberAddressPO = mapper.readValue(voStr, MemberAddressPO.class);
				listMemberAddressPO.add(memberAddressPO);
			}

			// 휴면 테이블로 이동
			if(listMemberBasePO.size() > 0) dmbInsertCnt = memberDormantService.insertDormantMemberBaseForBatch(listMemberBasePO);
			if(listMemberBizInfoPO.size() > 0) dmbiInsertCnt = memberDormantService.insertDormantMemberBizInfoForBatch(listMemberBizInfoPO);
			if(listMemberAddressPO.size() > 0) dmaInsertCnt = memberDormantService.insertDormantMemberAddressForBatch(listMemberAddressPO);
			
			// 원 테이블 데이터 업데이트 및 삭제
			if(listMemberBasePO.size() > 0) mbUpdateCnt = memberBatchService.updateMemberBaseForDormant(listMemberBasePO);
			if(listMemberBizInfoPO.size() > 0) mbiUpdateCnt = memberBatchService.updateMemberBizInfoForDormant(listMemberBizInfoPO);
			if(listMemberAddressPO.size() > 0) maDeleteCnt = memberBatchService.deleteMemberAddressForDormant(listMemberAddressPO);
			
			blpo.setBatchRstCd(CommonConstants.BATCH_RST_CD_SUCCESS);
		} catch(Exception e) {
			e.printStackTrace();
			blpo.setBatchRstCd(CommonConstants.BATCH_RST_CD_FAIL);
		} finally {
			String RstMsg = this.message.getMessage("batch.log.result.msg.member.dormant" , new Object[] { listMemberBaseForDormantVO.size(), dmbInsertCnt, mbUpdateCnt
																											, listMemberBizInfoForDormantVO.size(), dmbiInsertCnt, mbiUpdateCnt
																											, listMemberAddressForDormantVO.size(), dmaInsertCnt, maDeleteCnt });
			blpo.setBatchRstMsg(RstMsg);
			
			batchService.insertBatchLog(blpo);
		}
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 
	 * - 파일명		: MemberExecute.java
	 * - 작성일		: 2021. 4. 1.
	 * - 작성자		: 조은지
	 * - 설명			: 회원 탈퇴 배치
	 * </pre>
	 */
	public void memberLeave() {
		/**
		 * 데일리 배치(새벽 3시 수행)
		 * 배치 수행 시각 기준 이전날짜에 회원 탈퇴한 회원들에 한해 분리보관
		 * 
		 * === MEMBER_BASE ===
		 * 1. 보관DB로 복사시 제외컬럼
		 * 	- MBR_NM		: 회원 명
		 * 	- NICK_NM		: 닉네임
		 * 	- BIRTH			: 생일정보
		 * 	- CI_CTF_VAL	: CI 인증값
		 * 	- PSWD			: 비밀번호
		 * 	- TEL			: 전화번호
		 * 	- MOBILE		: 모바일
		 * 	- EMAIL			: 이메일
		 * 	- RCOM_LOGIN_ID	: 추천인 ID
		 * 	- UPDR_IP		: 수정자 IP
		 * 
		 * 2. 원DB 보관컬럼
		 * 	- MBR_NO		: 회원 번호
		 *	- ST_ID			: 사이트 ID
		 * 	- MBR_STAT_CD	: 회원 상태 코드
		 * 
		 * === MEMBER_BIZ_INFO ===
		 * 1. 보관DB로 복사시 제외컬럼
		 * 	- EMAIL				: 대표 이메일
		 * 	- CEO_NM			: 대표자 명
		 * 	- BIZ_LIC_NO		: 사업자 등록 번호
		 * 	- BIZ_LIC_IMG_PATH	: 사업자 등록증
		 * 	- DLGT_NO			: 대표 번호
		 * 	- CHRG_NM			: 담당자 이름
		 * 	- CHRG_TEL			: 담당자 전화번호
		 * 	- CHRG_MOBILE		: 담당자 휴대폰
		 * 	- CHRG_EMAIL		: 담당자 이메일
		 * 	- ACCT_NO			: 계좌 번호
		 * 	- OOA_NM			: 예금주
		 * 
		 * 2. 원DB 보관컬럼
		 * 	- MBR_NO	: 회원 번호
		 * 	- BIZ_NO	: 회사 번호
		 * 
		 * === MEMBER_ADDRESS ===
		 * 1. 분리보관하지 않음
		 * 2. 원DB에서 로우 삭제
		 */
		
		/*int result = memberBatchService.procMemberLeaveBatch();
		if(result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		} else {
			log.debug("회원 탈퇴 배치 완료");
		}*/
		
		String batchGb = "leave";
		
		int dmbInsertCnt = 0;	// LEAVE_MEMBER_BASE insert 개수
		int dmbiInsertCnt = 0;	// LEAVE_MEMBER_BIZ_INFO insert 개수
		
		int mbUpdateCnt = 0;	// MEMBER_BASE update 개수
		int mbiUpdateCnt = 0;	// MEMBER_BIZ_INFO update 개수
		int maDeleteCnt = 0;	// MEMBER_ADDRESS delete 개수
		
		BatchLogPO blpo = new BatchLogPO();
		blpo.setBatchStrtDtm(DateUtil.getTimestamp());
		
		blpo.setBatchId(CommonConstants.BATCH_MEMBER_LEAVE);
		blpo.setBatchEndDtm(DateUtil.getTimestamp());
		
		// 탈퇴 처리할 회원 정보 조회
		List<MemberBaseVO> listMemberBaseForLeaveVO = memberBatchService.listMemberBaseForDormantOrLeave(batchGb);
		List<MemberBizInfoVO> listMemberBizInfoForLeaveVO = memberBatchService.listMemberBizInfoForDormantOrLeave(batchGb);
		List<MemberAddressVO> listMemberAddressForLeaveVO = memberBatchService.listMemberAddressForDormantOrLeave(batchGb);
		
		// 탈퇴 테이블로 이동시킬 회원 정보
		List<MemberBasePO> listMemberBasePO = new ArrayList<MemberBasePO>();
		List<MemberBizInfoPO> listMemberBizInfoPO = new ArrayList<MemberBizInfoPO>();
		List<MemberAddressPO> listMemberAddressPO = new ArrayList<MemberAddressPO>();

		ObjectMapper mapper = new ObjectMapper().configure(DeserializationConfig.Feature.FAIL_ON_UNKNOWN_PROPERTIES, false);
		
		try {
			for(MemberBaseVO vo : listMemberBaseForLeaveVO) {
				String voStr = mapper.writeValueAsString(vo);
				MemberBasePO memberBasePO = mapper.readValue(voStr, MemberBasePO.class);
				listMemberBasePO.add(memberBasePO);
			}
			
			for(MemberBizInfoVO vo : listMemberBizInfoForLeaveVO) {
				String voStr = mapper.writeValueAsString(vo);
				MemberBizInfoPO memberBizInfoPO = mapper.readValue(voStr, MemberBizInfoPO.class);
				listMemberBizInfoPO.add(memberBizInfoPO);
			}
			
			for(MemberAddressVO vo : listMemberAddressForLeaveVO) {
				String voStr = mapper.writeValueAsString(vo);
				MemberAddressPO memberAddressPO = mapper.readValue(voStr, MemberAddressPO.class);
				listMemberAddressPO.add(memberAddressPO);
			}

			// 탈퇴 테이블로 이동
			if(listMemberBasePO.size() > 0) dmbInsertCnt = memberLeaveService.insertLeaveMemberBaseForBatch(listMemberBasePO);
			if(listMemberBizInfoPO.size() > 0) dmbiInsertCnt = memberLeaveService.insertLeaveMemberBizInfoForBatch(listMemberBizInfoPO);
			
			// 원 테이블 데이터 업데이트 및 삭제
			if(listMemberBasePO.size() > 0) mbUpdateCnt = memberBatchService.updateMemberBaseForLeave(listMemberBasePO);
			if(listMemberBizInfoPO.size() > 0) mbiUpdateCnt = memberBatchService.updateMemberBizInfoForLeave(listMemberBizInfoPO);
			if(listMemberAddressPO.size() > 0) maDeleteCnt = memberBatchService.deleteMemberAddressForLeave(listMemberAddressPO);
			
			blpo.setBatchRstCd(CommonConstants.BATCH_RST_CD_SUCCESS);
		} catch(Exception e) {
			e.printStackTrace();
			blpo.setBatchRstCd(CommonConstants.BATCH_RST_CD_FAIL);
		} finally {
			String RstMsg = this.message.getMessage("batch.log.result.msg.member.leave" , new Object[] { listMemberBaseForLeaveVO.size(), dmbInsertCnt, mbUpdateCnt
																											, listMemberBizInfoForLeaveVO.size(), dmbiInsertCnt, mbiUpdateCnt
																											, listMemberAddressForLeaveVO.size(), maDeleteCnt });
			blpo.setBatchRstMsg(RstMsg);
			
			batchService.insertBatchLog(blpo);
		}
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 
	 * - 파일명		: MemberExecute.java
	 * - 작성일		: 2021. 5. 20.
	 * - 작성자		: 이지희
	 * - 설명			: 회원 등급업 배치
	 * </pre>
	 */
	public void memberGrade() {
		
		BatchLogPO blpo = new BatchLogPO();
		blpo.setBatchStrtDtm(DateUtil.getTimestamp());
		blpo.setBatchId(CommonConstants.BATCH_MEMBER_GRADE);
		blpo.setBatchEndDtm(DateUtil.getTimestamp());
		
		Map<String, String> map = new HashMap<String, String>();
		
		int vvipRst = 0;
		int vipRst = 0;
		int familyRst = 0;
		int welcomeRst = 0;
		
		try {
			String env = bizConfig.getProperty("envmt.gb");
			map.put("env",env);
			
			//vvip
			map.put("start", "300000");
			map.put("end", null);
			map.put("grdCd", "10");
			vvipRst = memberBatchService.updateMemberGrade(map);
			
			//vip
			map.put("start", "200000");
			map.put("end", "299999");
			map.put("grdCd", "20");
			vipRst = memberBatchService.updateMemberGrade(map);
			
			//패밀리
			map.put("start", "100000");
			map.put("end", "199999");
			map.put("grdCd", "30");
			familyRst = memberBatchService.updateMemberGrade(map);
			
			//웰컴
			map.put("start",null );
			map.put("end", "100000");
			map.put("grdCd", "40");
			welcomeRst = memberBatchService.updateMemberGrade(map);
			
			blpo.setBatchRstCd(CommonConstants.BATCH_RST_CD_SUCCESS);
			
		} catch(Exception e) {
			e.printStackTrace();
			blpo.setBatchRstCd(CommonConstants.BATCH_RST_CD_FAIL);
		} finally {
			String RstMsg = this.message.getMessage("batch.log.result.msg.member.grade" , new Object[] {vvipRst, vipRst, familyRst, welcomeRst});
			blpo.setBatchRstMsg(RstMsg);
			
			batchService.insertBatchLog(blpo);
		}
		
	}
}