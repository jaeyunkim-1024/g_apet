package biz.app.email.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import biz.app.email.dao.EmailSendHistoryDao;
import biz.app.email.dao.EmailSendHistoryMapDao;
import biz.app.email.model.EmailSendHistoryMapSO;
import biz.app.email.model.EmailSendHistoryMapVO;
import biz.app.email.model.EmailSendHistoryPO;
import biz.app.email.model.EmailSendHistorySO;
import biz.app.email.model.EmailSendHistoryVO;
import biz.app.system.model.CodeDetailVO;
import biz.common.service.CacheService;
import biz.interfaces.humuson.constants.HumusonConstants;
import biz.interfaces.humuson.dao.PostmanDao;
import biz.interfaces.humuson.model.DcgEmailMappingPO;
import biz.interfaces.humuson.model.DcgEmailPO;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import freemarker.template.utility.StringUtil;
import lombok.extern.slf4j.Slf4j;


/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.email.service
* - 파일명		: EmailSendServiceImpl.java
* - 작성일		: 2017. 5. 18.
* - 작성자		: Administrator
* - 설명			: 이메일 전송 서비스
* </pre>
*/
@Slf4j
@Transactional
@Service("emailSendService")
@Deprecated
public class EmailSendServiceImpl implements EmailSendService {
	

	@Autowired private CacheService cacheService;

	@Autowired private EmailSendHistoryDao emailSendHistoryDao;
	
	@Autowired private EmailSendHistoryMapDao emailSendHistoryMapDao;

	@Autowired private PostmanDao postmanDao;
	/*
	 * 이메일 전송 예정 목록 조회
	 * @see biz.app.email.service.EmailSendHistoryService#listEmailSendHistoryReq()
	 */
	@Override
	public List<Long> listEmailSendHistoryReq() {
		return this.emailSendHistoryDao.listEmailSendHistoryReq();
	}

	/*
	 * 이메일 전송 처리
	 * @see biz.app.email.service.EmailSendService#sendDcgEmail(java.lang.Long)
	 */
	@Override
	public void sendDcgEmail(Long histNo) {
		
		DcgEmailPO depo = null;
		//List<DcgEmailMappingPO> dempoList = null;
		DcgEmailMappingPO dempo = null;
		int result = 0;
		
		/****************************
		 * 이메일 전송 예정 내역 조회
		 ****************************/
		EmailSendHistorySO eshso = new EmailSendHistorySO();
		eshso.setHistNo(histNo);
		
		EmailSendHistoryVO eshVO = this.emailSendHistoryDao.getEmailSendHistory(eshso);
		
		if(eshVO == null){
			throw new CustomException(ExceptionConstants.ERROR_EMAIL_SEND_HISTORY_NO_EXISTS);
		}
		/****************************
		 * 메일 유형에 따른 코드 조회
		 ****************************/
		CodeDetailVO emailTpVO = cacheService.getCodeCache(CommonConstants.EMAIL_TP, eshVO.getEmailTpCd());

		if(emailTpVO == null){
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

		String tableName= emailTpVO.getUsrDfn1Val();
		
		/***************************
		 * 메일 데이터 생성 및 저장
		 ***************************/
		depo = new DcgEmailPO();
		
		/*
		 * 이메일 유형에 따른 테이블 명 조회
		 */
		depo.setTableNm(tableName);
		depo.setToName(eshVO.getReceiverNm());
		depo.setToEmail(eshVO.getReceiverEmail());
		depo.setFromName(eshVO.getSenderNm());
		depo.setFromEmail(eshVO.getSenderEmail());
		depo.setSubJect(eshVO.getSubject());
		depo.setContents(eshVO.getContents());
		if(eshVO.getStId() != null){
			depo.setSiteId(StringUtil.leftPad(eshVO.getStId().toString(), 2, "0"));
		}
		depo.setMap1(eshVO.getMap01());
		depo.setMap2(eshVO.getMap02());
		depo.setMap3(eshVO.getMap03());
		depo.setMap4(eshVO.getMap04());
		depo.setMap5(eshVO.getMap05());
		depo.setMap6(eshVO.getMap06());
		depo.setMap7(eshVO.getMap07());
		depo.setMap8(eshVO.getMap08());
		depo.setMap9(eshVO.getMap09());
		depo.setMap10(eshVO.getMap10());
		depo.setMap11(eshVO.getMap11());
		depo.setMap12(eshVO.getMap12());
		depo.setMap13(eshVO.getMap13());
		depo.setMap14(eshVO.getMap14());
		depo.setMap15(eshVO.getMap15());
		depo.setMap16(eshVO.getMap16());
		depo.setMap17(eshVO.getMap17());
		depo.setMap18(eshVO.getMap18());
		depo.setMap19(eshVO.getMap19());
		depo.setMap20(eshVO.getMap20());
		depo.setMap21(eshVO.getMap21());
		depo.setMap22(eshVO.getMap22());
		depo.setMap23(eshVO.getMap23());
		depo.setMap24(eshVO.getMap24());
		depo.setMap25(eshVO.getMap25());
		depo.setMap26(eshVO.getMap26());
		depo.setMap27(eshVO.getMap27());
		depo.setMap28(eshVO.getMap28());
		depo.setMap29(eshVO.getMap29());
		depo.setMap30(eshVO.getMap30());
		depo.setMap31(eshVO.getMap31());
		depo.setMap32(eshVO.getMap32());
		depo.setMap33(eshVO.getMap33());
		depo.setMap34(eshVO.getMap34());
		depo.setMap35(eshVO.getMap35());
		depo.setMap36(eshVO.getMap36());

		/*
		 * 주문취소/반품신청/교환 신청 오류 관련하여 임시 생성
		 * - postman에서 템플릿을 수정하면서 mailcode가 삭제되었지만 실제 DB에서는 삭제가 되지 않고 필수값으로 되어 있어서 임시 적용
		 */
		if(CommonConstants.SMS_TP_300.equals(eshVO.getEmailTpCd())){
			depo.setMailCode(HumusonConstants.EMAIL_CLAIM_TP_01);
		}else if(CommonConstants.SMS_TP_310.equals(eshVO.getEmailTpCd())){
			depo.setMailCode(HumusonConstants.EMAIL_CLAIM_TP_02);
		}else if(CommonConstants.SMS_TP_320.equals(eshVO.getEmailTpCd())){
			depo.setMailCode(HumusonConstants.EMAIL_CLAIM_TP_03);
		}
		
		result = this.postmanDao.insertDcgEmail(depo);

		if(result != 1){
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

		/***************************
		 * 메일 Mapping 데이터 생성
		 ***************************/

		/*
		 * Mapping 테이블 존재할 경우 데이터 생성
		 */
		if(CommonConstants.COMM_YN_Y.equals(emailTpVO.getUsrDfn2Val())){
			EmailSendHistoryMapSO eshmso = new EmailSendHistoryMapSO();
			eshmso.setHistNo(eshVO.getHistNo());
			List<EmailSendHistoryMapVO> mapList = this.emailSendHistoryMapDao.listEmailSendHistoryMap(eshmso);
			
			if(mapList == null || mapList.isEmpty()){
				throw new CustomException(ExceptionConstants.ERROR_EMAIL_SEND_HISTORY_MAP_NO_EXISTS);
				
			}
			
			//dempoList = new ArrayList<DcgEmailMappingPO>();
			
			for(EmailSendHistoryMapVO eshm : mapList){
				dempo = new DcgEmailMappingPO();
				dempo.setTableNm(tableName);
				dempo.setListSeq(depo.getSeq());
				dempo.setLmap1(eshm.getMap01());
				dempo.setLmap2(eshm.getMap02());
				dempo.setLmap3(eshm.getMap03());
				dempo.setLmap4(eshm.getMap04());
				dempo.setLmap5(eshm.getMap05());
				dempo.setLmap6(eshm.getMap06());
				dempo.setLmap7(eshm.getMap07());
				dempo.setLmap8(eshm.getMap08());
				dempo.setLmap9(eshm.getMap09());
				dempo.setLmap10(eshm.getMap10());
				
				result = this.postmanDao.insertDcgEmailMapping(dempo);

				if(result != 1){
					throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
				}
			}
			
		}
			
		/**************************************
		 * 이메일 전송 이력의 전송 플래그 업데이트
		 **************************************/
		EmailSendHistoryPO eshpo = new EmailSendHistoryPO();
		eshpo.setHistNo(histNo);
		result = this.emailSendHistoryDao.updateEmailSendHistoryReqComplete(eshpo);
		
		if(result != 1){
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
	}

	
	
	
}