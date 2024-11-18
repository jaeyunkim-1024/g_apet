package biz.app.sms.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import biz.app.sms.dao.SmsHistDao;
import biz.app.sms.dao.SmsReceiverDao;
import biz.app.sms.model.SmsHistPO;
import biz.app.sms.model.SmsReceiverPO;
import biz.common.model.EmSmtLogSO;
import biz.common.model.EmSmtLogVO;
import framework.common.constants.CommonConstants;
import lombok.extern.slf4j.Slf4j;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.sms.service
* - 파일명		: SmsHistoryServiceImpl.java
* - 작성일		: 2016. 4. 22.
* - 작성자		: snw
* - 설명		: SMS 이력 서비스
* </pre>
*/
@Slf4j
@Transactional
@Service("smsHistService")
public class SmsHistServiceImpl implements SmsHistService {
	
	
	@Autowired private SmsHistDao smsHistDao;

	@Autowired private SmsReceiverDao smsReceiverDao;

	/*
	 * SMS 이력 등록
	 * @see biz.app.sms.service.SmsHistService#insertSmsHist(biz.app.sms.model.SmsHistPO, java.lang.String[], java.lang.String[])
	 */
	@Override
	@Transactional(propagation=Propagation.REQUIRES_NEW)
	public void insertSmsHist(SmsHistPO po, String[] rcvrNos, String[] rcvrNms) {
	
		SmsReceiverPO srpo = new SmsReceiverPO();
		srpo.setSmsHistId(po.getSmsHistId());
		srpo.setSysRegrNo(po.getSysRegrNo());
		try{
			int result = this.smsHistDao.insertSmsHist(po);
			
			if(result == 1
					&& rcvrNos != null && rcvrNos.length > 0){
				for(int i=0; i < rcvrNos.length ; i++){
					srpo.setRcvSeq(Integer.valueOf(i + 1));
					srpo.setRcvrNo(rcvrNos[i]);
					if(rcvrNms != null && rcvrNms.length > 0){
						srpo.setRcvrNm(rcvrNms[i]);
					}else{
						srpo.setRcvrNm("");
					}
					this.smsReceiverDao.insertSmsReceiver(srpo);
				}
			}
			
		}catch(Exception e){
			log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
			//log.error("SMS HIST INSERT ERROR : PO = " + po.toString() + ", RCVR_NO = " + rcvrNos.toString() + ", RCVR_NM = " + rcvrNms.toString());
		}
	
		
	}

	/*
	 * SMS 전송 결과 등록
	 * @see biz.app.sms.service.SmsHistoryService#updateSmsHistResult(biz.app.sms.model.SmsHistPO)
	 */
	@Override
	public void updateSmsHistResult(SmsHistPO po) {
		this.smsHistDao.updateSmsHistResult(po);
	}
	
	/**
	 * 
	* <pre>
	* - 프로젝트명   : 11.business
	* - 패키지명   : biz.app.sms.service
	* - 파일명      : SmsHistServiceImpl.java
	* - 작성일      : 2017. 6. 27.
	* - 작성자      : valuefactory 권성중
	* - 설명      :  SMS 발송 이력 조회 테이블 존재여부 
	* </pre>
	 */
	public List<String> getEmSmtLogTableName(){
		List<String> rtn  = smsHistDao.getEmSmtLogTableName();
		List<String> returns = new ArrayList<>();
		for (String rt : rtn){
			returns.add(rt.substring(11));
		}
		return returns;
	}
	/**
	 * 
	* <pre>
	* - 프로젝트명   : 11.business
	* - 패키지명   : biz.app.sms.service
	* - 파일명      : SmsHistServiceImpl.java
	* - 작성일      : 2017. 6. 27.
	* - 작성자      : valuefactory 권성중
	* - 설명      :SMS 발송 이력 조회 그리드 
	* </pre>
	 */
	public List<EmSmtLogVO> pageEmSmtLogBase(EmSmtLogSO so){
		return smsHistDao.pageEmSmtLogBase( so);
	} 
	
 
	

	
}