package biz.app.ssgmessage.dao;

import org.springframework.stereotype.Repository;

import biz.common.model.SsgMessageSendPO;
import biz.common.model.SsgMessageSendSO;
import biz.common.model.SsgMessageSendVO;
import framework.common.dao.MainAbstractDao;
import framework.common.util.StringUtil;

@Repository
public class SsgDao extends MainAbstractDao {
	private static final String BASE_DAO_PACKAGE = "ssg.";

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 패키지명		: biz.app.ssgmessage.dao
	* - 파일명		: SsgDao.java
	* - 작성일		: 2021. 2. 1.
	* - 작성자		: Administrator
	* - 설명			: SMS 발송 DAO
	* </pre>
	*/
	public int insertSms(SsgMessageSendPO po) {
		return insert(BASE_DAO_PACKAGE + "insertSms", po);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 패키지명		: biz.app.ssgmessage.dao
	* - 파일명		: SsgDao.java
	* - 작성일		: 2021. 2. 1.
	* - 작성자		: Administrator
	* - 설명			: LMS/MMS 발송 DAO
	* </pre>
	*/
	public int insertMms(SsgMessageSendPO po) {
		if (StringUtil.isEmpty(po.getFsubject())) {
			po.setFsubject(null);
		}
		return insert(BASE_DAO_PACKAGE + "insertMms", po);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 패키지명		: biz.app.ssgmessage.dao
	* - 파일명		: SsgDao.java
	* - 작성일		: 2021. 2. 1.
	* - 작성자		: Administrator
	* - 설명			: 카카오 발송 DAO
	* </pre>
	*/
	public int insertKko(SsgMessageSendPO po) {
		return insert(BASE_DAO_PACKAGE + "insertKko", po);
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 패키지명		: biz.app.ssgmessage.dao
	* - 파일명		: SsgDao.java
	* - 작성일		: 2021. 3. 5.
	* - 작성자		: kwj
	* - 설명			: sms log 조회
	* </pre>
	*/
	public SsgMessageSendVO selectSmsLog(SsgMessageSendSO so) {
		return selectOne(BASE_DAO_PACKAGE + "selectSmsLog", so); 
	}

}
