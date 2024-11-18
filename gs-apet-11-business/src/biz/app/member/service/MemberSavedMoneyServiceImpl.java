package biz.app.member.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import biz.app.member.dao.MemberBaseDao;
import biz.app.member.dao.MemberSavedMoneyDao;
import biz.app.member.dao.MemberSavedMoneyDetailDao;
import biz.app.member.model.MemberBasePO;
import biz.app.member.model.MemberSavedMoneyDetailPO;
import biz.app.member.model.MemberSavedMoneyPO;
import biz.app.member.model.MemberSavedMoneySO;
import biz.app.member.model.MemberSavedMoneyVO;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import lombok.extern.slf4j.Slf4j;


/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.member.service
* - 파일명		: MemberSavedMoneyServiceImpl.java
* - 작성일		: 2017. 2. 1.
* - 작성자		: snw
* - 설명			: 회원 적립금 서비스
* </pre>
*/
@Slf4j
@Transactional
@Service("memberSavedMoneyService")
public class MemberSavedMoneyServiceImpl implements MemberSavedMoneyService {

	@Autowired private MemberSavedMoneyDao memberSavedMoneyDao;

	@Autowired private MemberSavedMoneyDetailDao memberSavedMoneyDetailDao;

	@Autowired private MemberBaseDao memberBaseDao;

	@Autowired private Properties bizConfig;
	
	/*
	 * 회원 적립금 상세 조회
	 * @see biz.app.member.service.MemberSavedMoneyService#getMemberSavedMoney(biz.app.member.model.MemberSavedMoneySO)
	 */
	@Override
	public MemberSavedMoneyVO getMemberSavedMoney(MemberSavedMoneySO so) {
		return this.memberSavedMoneyDao.getMemberSavedMoney(so);
	}

	/*
	 * 회원 적립금 등록
	 * @see biz.app.member.service.MemberSavedMoneyService#insertMemberSavedMoney(biz.app.member.model.MemberSavedMoneyPO)
	 */
	@Override
	public void insertMemberSavedMoney(MemberSavedMoneyPO po) {

		/********************************
		 * 회원 적립금 등록
		 ********************************/
		/*
		 * 유효기간 설정
		 * 유효기간이 없는 경우 기본 기간으로 설정
		 */
		if((po.getVldDtm() == null || "".equals(po.getVldDtm())) && po.getVldPeriod() == null){
			po.setVldPeriod(Integer.valueOf(this.bizConfig.getProperty("member.savedMoney.vld.period")));
			po.setVldUnit(this.bizConfig.getProperty("member.savedMoney.vld.unit"));
		}
		
		int result = memberSavedMoneyDao.insertMemberSavedMoney(po);
		
		if(result != 1) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

		/********************************
		 * 회원 기본 잔여적립금에 추가
		 ********************************/
		MemberBasePO mbpo = new MemberBasePO();
		mbpo.setMbrNo(po.getMbrNo());
		mbpo.setSvmnRmnAmt(po.getSaveAmt());
		result = this.memberBaseDao.updateMemberBaseSavedMoney(mbpo);
		
		if(result != 1) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
				 
		
	}
	
	/*
	 * 회원 적립금 등록 (Multi)
	 * @see biz.app.member.service.MemberSavedMoneyService#insertMemberSavedMoneyList(java.lang.Long[], biz.app.member.model.MemberSavedMoneyPO)
	 */
	@Override
	public void insertMemberSavedMoneyList(Long[] arrMbrNo, MemberSavedMoneyPO po) {

		if(arrMbrNo != null && arrMbrNo.length > 0) {
			for(Long mbrNo : arrMbrNo){
				po.setMbrNo(mbrNo);
				this.insertMemberSavedMoney(po);
			}
		} else {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

	}	
	
	/*
	 * 회원 적립금 내역 등록
	 * @see biz.app.member.service.MemberSavedMoneyService#insertMemberSavedMoneyDetail(biz.app.member.model.MemberSavedMoneyDetailPO)
	 */
	@Override
	public int insertMemberSavedMoneyDetail(MemberSavedMoneyDetailPO po) {

		Long prcsAmt = 0L;
		MemberSavedMoneyDetailPO msmdpo = null;		// 적립금 소멸 처리할 데이터
		
		/*
		 * 회원 적립금 조회
		 */
		MemberSavedMoneySO msmso = new MemberSavedMoneySO();
		msmso.setMbrNo(po.getMbrNo());
		msmso.setSvmnSeq(po.getSvmnSeq());
		MemberSavedMoneyVO memberSavedMoney = this.memberSavedMoneyDao.getMemberSavedMoney(msmso);

		/*
		 * Validation : 적립 및 차감 가능 여부 체크
		 */

		if(memberSavedMoney != null){
			//적립
			if(CommonConstants.SVMN_PRCS_10.equals(po.getSvmnPrcsCd())){
				/*
				 * 원적립금애서 잔여금액을 뺀 금액을 초과하여 적립할 수 없음
				 */
				if((memberSavedMoney.getSaveAmt().longValue() - memberSavedMoney.getRmnAmt().longValue()) < po.getPrcsAmt()){
					throw new CustomException(ExceptionConstants.ERROR_MEMBER_SAVED_MONEY_NOT_OVER_SAVE);
				}else{
					prcsAmt = po.getPrcsAmt();
				}
				
				/*
				 * 원 적립금의 유효기간이 지난 경우 자동 소멸 처리
				 */
				if(CommonConstants.COMM_YN_N.equals(memberSavedMoney.getVldYn())){
					msmdpo = new MemberSavedMoneyDetailPO();
					msmdpo.setMbrNo(po.getMbrNo());
					msmdpo.setSvmnSeq(po.getSvmnSeq());
					msmdpo.setSvmnPrcsCd(CommonConstants.SVMN_PRCS_20);
					msmdpo.setSvmnPrcsRsnCd(CommonConstants.SVMN_PRCS_RSN_290);
					msmdpo.setPrcsAmt(po.getPrcsAmt());
					
					prcsAmt  = prcsAmt - msmdpo.getPrcsAmt();
				}
				
			//차감
			}else if(CommonConstants.SVMN_PRCS_20.equals(po.getSvmnPrcsCd())){
				/*
				 * 원 적립금의 잔여금액을 초과하여 차감 할 수 없음
				 */
				if(memberSavedMoney.getRmnAmt().longValue() < po.getPrcsAmt().longValue()){
					throw new CustomException(ExceptionConstants.ERROR_MEMBER_SAVED_MONEY_REDUCE_NO_RMN_AMT);
				}else{
					prcsAmt = po.getPrcsAmt() * -1;
				}
			}else{
				throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
			}
		}else{
			throw new CustomException(ExceptionConstants.ERROR_MEMBER_SAVED_MONEY_NO_DATA);
		}
		
		/********************************
		 * 회원 적립금 내역 등록
		 ********************************/
		int result = this.memberSavedMoneyDetailDao.insertMemberSavedMoneyDetail(po);

		if(result == 1){

			/*
			 * 복원된 적립금의 자동소멸 처리 데이터가 존재하는 경우
			 */
			if(msmdpo != null){
				result = this.memberSavedMoneyDetailDao.insertMemberSavedMoneyDetail(msmdpo);
				
				if(result != 1){
					throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
				}
			}
			
			if(prcsAmt != 0){
				/********************************
				 * 회원 적립금의 잔여금액 수정
				 ********************************/
				MemberSavedMoneyPO msmpo = new MemberSavedMoneyPO();
				msmpo.setMbrNo(po.getMbrNo());
				msmpo.setSvmnSeq(po.getSvmnSeq());
				msmpo.setSaveAmt(prcsAmt);
				
				result = this.memberSavedMoneyDao.updateMemberSavedMoneyRmnAmt(msmpo);
	
				if(result != 1) {
					throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
				}
				 
				/********************************
				 * 회원 기본의 잔여적립금 수정
				 ********************************/
				//회원 기본 적립금 잔여금액 업데이트
				MemberBasePO mbpo = new MemberBasePO();
				mbpo.setMbrNo(po.getMbrNo());
				mbpo.setSvmnRmnAmt(prcsAmt);
				result = this.memberBaseDao.updateMemberBaseSavedMoney(mbpo);
	
				if(result == 0) {
					throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
				}
				
				 
			}
		}else{
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

		return result;
	}
	
	/* 
	 * 회원의 사용가능한 적립금 목록 조회
	 * @see biz.app.member.service.MemberSavedMoneyService#listMemberSavedMoneyUsedPossible(java.lang.Long, java.lang.Long)
	 */
	@Override
	public List<MemberSavedMoneyVO> listMemberSavedMoneyUsedPossible(Long mbrNo, Long saveAmt) {
		List<MemberSavedMoneyVO> resultList = null;

		/*********************************
		 * 사용가능한 목록 조회
		 *********************************/
		MemberSavedMoneySO so = new MemberSavedMoneySO();
		so.setMbrNo(mbrNo);
		List<MemberSavedMoneyVO> savedMoneyList = this.memberSavedMoneyDao.listMemberSavedMoneyUsedPossible(so);

		/*********************************
		 * 사용가능한 목록 설정
		 *********************************/		
		Long addSaveAmt = 0L; //누적 적립금

		if(savedMoneyList != null && !savedMoneyList.isEmpty()){
			
			resultList = new ArrayList<>();
			
			for(int i=0; i<savedMoneyList.size(); i++){
				
				if(addSaveAmt < saveAmt){
					resultList.add(savedMoneyList.get(i));
					addSaveAmt += savedMoneyList.get(i).getRmnAmt();
				}else{
					break;
				}

			}

		}

		/***************************
		 * 적립금이 부족한 경우
		 **************************/
		if(addSaveAmt < saveAmt){
			throw new CustomException(ExceptionConstants.ERROR_MEMBER_SAVED_MONEY_REDUCE_NO_RMN_AMT);
		}
		
		return resultList;
	}	
	
}