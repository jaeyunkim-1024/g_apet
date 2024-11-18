package biz.app.email.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import biz.app.email.model.EmailSendHistoryPO;
import biz.app.email.model.EmailSendHistorySO;
import biz.app.email.model.EmailSendHistoryVO;
import framework.common.dao.MainAbstractDao;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.email.dao
* - 파일명		: EmailSendHistoryDao.java
* - 작성일		: 2017. 5. 18.
* - 작성자		: Administrator
* - 설명			: 이메일 전송 이력 DAO
* </pre>
*/
@Repository
public class EmailSendHistoryDao extends MainAbstractDao {
	
	private static final String BASE_DAO_PACKAGE = "emailSendHistory.";
	

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: EmailSendHistoryDao.java
	* - 작성일		: 2017. 5. 18.
	* - 작성자		: Administrator
	* - 설명			: 이메일 전송 예정 목록 조회
	* </pre>
	* @param so
	* @return
	*/
	public List<Long> listEmailSendHistoryReq(){
		return selectList(BASE_DAO_PACKAGE + "listEmailSendHistoryReq");
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: EmailSendHistoryDao.java
	* - 작성일		: 2017. 5. 18.
	* - 작성자		: Administrator
	* - 설명			: 이메일 전송 이력 상세 조회
	* </pre>
	* @param so
	* @return
	*/
	public EmailSendHistoryVO getEmailSendHistory(EmailSendHistorySO so){
		return selectOne(BASE_DAO_PACKAGE + "getEmailSendHistory", so);
	}
	
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: EmailSendHistoryDao.java
	* - 작성일		: 2017. 5. 18.
	* - 작성자		: Administrator
	* - 설명			: 이메일 전송 이력 등록
	* </pre>
	* @param po
	* @return
	*/
	public int insertEmailSendHistory(EmailSendHistoryPO po){
		return insert(BASE_DAO_PACKAGE + "insertEmailSendHistory", po);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: EmailSendHistoryDao.java
	* - 작성일		: 2017. 5. 18.
	* - 작성자		: Administrator
	* - 설명			: 이메일 발송 요청 완료
	* </pre>
	* @return
	*/
	public int updateEmailSendHistoryReqComplete(EmailSendHistoryPO po){
		return update(BASE_DAO_PACKAGE + "updateEmailSendHistoryReqComplete", po);
	}
}
