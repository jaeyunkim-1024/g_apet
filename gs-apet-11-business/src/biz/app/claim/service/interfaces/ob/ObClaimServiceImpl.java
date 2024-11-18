package biz.app.claim.service.interfaces.ob;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import biz.app.claim.dao.interfaces.ob.ObClaimBaseDao;
import biz.app.claim.dao.interfaces.ob.ObClaimHistDao;
import biz.app.claim.model.interfaces.ob.ObClaimBasePO;
import biz.app.claim.model.interfaces.ob.ObClaimResponsePO;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import lombok.extern.slf4j.Slf4j;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.claim.service.interfaces.ob
* - 파일명	: ObClaimServiceImpl.java
* - 작성일	: 2017. 10. 13.
* - 작성자	: schoi
* - 설명		: Outbound API 클레임 서비스
* </pre>
*/
@Slf4j
@Service
@Transactional
public class ObClaimServiceImpl implements ObClaimService {

	@Autowired
	private ObClaimHistDao obClaimHistDao;
	
	@Autowired
	private ObClaimBaseDao obClaimBaseDao;	

	/****************************
	 * Outbound API 주문 클레임 이력 정보
	 ****************************/
	public void insertObClaimBase(ObClaimBasePO obClaimBasePO) {
		int obClaimBaseResult = this.obClaimBaseDao.insertObClaimBase(obClaimBasePO);
		
		if(obClaimBaseResult <= 0){
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}		
	}
	
	/****************************
	 * Outbound API 이력 상세 정보
	 ****************************/
	public void insertObClaimHistory (ObClaimBasePO obClaimBasePO) {
		int obClaimHistoryResult = this.obClaimHistDao.insertObClaimHistory(obClaimBasePO);
		
		if(obClaimHistoryResult != 1){
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
	}
	
	/****************************
	 * Outbound API Response 이력 상세 정보
	 ****************************/
	public void insertObClaimResponse (ObClaimResponsePO obClaimResponsePO) {
		int obClaimResponseResult = this.obClaimHistDao.insertObClaimResponse(obClaimResponsePO);
		
		if(obClaimResponseResult != 1){
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
	}

}

