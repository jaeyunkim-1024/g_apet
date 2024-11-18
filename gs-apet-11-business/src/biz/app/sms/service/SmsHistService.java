package biz.app.sms.service;

import java.util.List;

import biz.app.sms.model.SmsHistPO;
import biz.common.model.EmSmtLogSO;
import biz.common.model.EmSmtLogVO;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.sms.service
* - 파일명		: SmsHistoryService.java
* - 작성일		: 2016. 4. 22.
* - 작성자		: snw
* - 설명		: SMS 이력 서비스 Interface
* </pre>
*/
public interface SmsHistService {


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: SmsHistoryService.java
	* - 작성일		: 2016. 4. 22.
	* - 작성자		: snw
	* - 설명		: SMS 이력 등록
	* </pre>
	* @param po
	* @throws Exception
	*/
	void insertSmsHist(SmsHistPO po, String[] rcvrNos, String[] rcvrNms);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: SmsHistoryService.java
	* - 작성일		: 2016. 4. 22.
	* - 작성자		: snw
	* - 설명		: SMS 전송 결과 등록
	* </pre>
	* @param po
	* @throws Exception
	*/
	void updateSmsHistResult(SmsHistPO po);
	
	/**
	 * 
	* <pre>
	* - 프로젝트명   : 11.business
	* - 패키지명   : biz.app.sms.service
	* - 파일명      : SmsHistService.java
	* - 작성일      : 2017. 6. 27.
	* - 작성자      : valuefactory 권성중
	* - 설명      :SMS 발송 이력 조회 테이블 존재여부 
	* </pre>
	 */
	public List<String> getEmSmtLogTableName();
	/**
	 * 
	* <pre>
	* - 프로젝트명   : 11.business
	* - 패키지명   : biz.app.sms.service
	* - 파일명      : SmsHistService.java
	* - 작성일      : 2017. 6. 27.
	* - 작성자      : valuefactory 권성중
	* - 설명      :  SMS 발송 이력 조회 그리드 
	* </pre>
	 */
	public List<EmSmtLogVO> pageEmSmtLogBase(EmSmtLogSO so);
	
	
	
}