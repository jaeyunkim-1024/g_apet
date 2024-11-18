package biz.app.sms.dao;

import java.util.List;

import org.springframework.stereotype.Repository;


import biz.app.sms.model.SmsHistPO;
import biz.common.model.EmSmtLogSO;
import biz.common.model.EmSmtLogVO;
import framework.common.dao.MainAbstractDao;

@Repository
public class SmsHistDao extends MainAbstractDao {

	public int insertSmsHist(SmsHistPO po){
		return insert("smsHist.insertSmsHist", po);
	}

	public int updateSmsHistResult(SmsHistPO po){
		return update("smsHist.updateSmsHistResult", po);
	}

	/**
	 *
	* <pre>
	* - 프로젝트명   : 11.business
	* - 패키지명   : biz.app.sms.dao
	* - 파일명      : SmsHistDao.java
	* - 작성일      : 2017. 6. 27.
	* - 작성자      : valuefactory 권성중
	* - 설명      :SMS 발송 이력 조회 테이블 존재여부
	* </pre>
	 */
	public List<String> getEmSmtLogTableName(){
		return selectList( "smsHist.getEmSmtLogTableName" );
	}
	/**
	 *
	* <pre>
	* - 프로젝트명   : 11.business
	* - 패키지명   : biz.app.sms.dao
	* - 파일명      : SmsHistDao.java
	* - 작성일      : 2017. 6. 27.
	* - 작성자      : valuefactory 권성중
	* - 설명      : SMS 발송 이력 조회 그리드
	* </pre>
	 */
	public List<EmSmtLogVO> pageEmSmtLogBase(EmSmtLogSO so){
		return selectListPage( "smsHist.pageEmSmtLogBase", so );
	}

}
