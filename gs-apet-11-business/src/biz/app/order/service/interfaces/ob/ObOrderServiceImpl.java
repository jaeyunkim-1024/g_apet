package biz.app.order.service.interfaces.ob;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import biz.app.order.dao.interfaces.ob.ObOrderBaseDao;
import biz.app.order.dao.interfaces.ob.ObOrderHistDao;
import biz.app.order.model.interfaces.ob.ObApiBasePO;
import biz.app.order.model.interfaces.ob.ObOrderBasePO;
import biz.app.order.model.interfaces.ob.ObOrderHistoryPO;
import biz.app.order.model.interfaces.ob.ObOrderResponsePO;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import lombok.extern.slf4j.Slf4j;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.order.service.interfaces.ob
* - 파일명		: ObOrderServiceImpl.java
* - 작성일		: 2017. 9. 18.
* - 작성자		: schoi
* - 설명			: Outbound API 주문 서비스
* </pre>
*/
@Slf4j
@Service
@Transactional
public class ObOrderServiceImpl implements ObOrderService {

	@Autowired
	private ObOrderHistDao obOrderHistDao;
	
	@Autowired
	private ObOrderBaseDao obOrderBaseDao;

	/****************************
	 * Outbound API 이력 정보
	 ****************************/
	public void insertObApiBase (ObApiBasePO obApiBasePO) {
		int obApiBaseResult = this.obOrderHistDao.insertObApiBase(obApiBasePO);
		
		if(obApiBaseResult != 1){
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
	}
	
	/****************************
	 * Outbound API 주문 이력 정보
	 ****************************/
	public void insertObOrderBase(ObOrderBasePO obOrderBasePO) {
		String custGrdNm = obOrderBasePO.getObOrderHistoryPO().getCustGrdNm();
		String custGrdCd = ""; 
		
		if(custGrdNm.equals("일반고객")) {
			custGrdCd = "10";
		} else if(custGrdNm.equals("우수고객")) {
			custGrdCd = "20";
		}
		obOrderBasePO.getObOrderHistoryPO().setCustGrdNm(custGrdCd);
		
		int obOrderBaseResult = this.obOrderBaseDao.insertObOrderBase(obOrderBasePO);
		
		if(obOrderBaseResult <= 0){			
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}			
	}
	
	/****************************
	 * Outbound API 이력 상세 정보
	 ****************************/
	public void insertObOrderHistory (ObOrderHistoryPO obOrderHistoryPO) {
		int obOrderHistoryResult = this.obOrderHistDao.insertObOrderHistory(obOrderHistoryPO);
		
		if(obOrderHistoryResult != 1){
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
	}
	
	/****************************
	 * Outbound API Response 이력 상세 정보
	 ****************************/
	public void insertObOrderResponse (ObOrderResponsePO obOrderResponsePO) {
		int obOrderResponseResult = this.obOrderHistDao.insertObOrderResponse(obOrderResponsePO);
		
		if(obOrderResponseResult != 1){
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
	}

}

