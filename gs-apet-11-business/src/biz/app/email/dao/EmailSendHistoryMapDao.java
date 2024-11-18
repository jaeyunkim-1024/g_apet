package biz.app.email.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import biz.app.email.model.EmailSendHistoryMapPO;
import biz.app.email.model.EmailSendHistoryMapSO;
import biz.app.email.model.EmailSendHistoryMapVO;
import framework.common.dao.MainAbstractDao;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.email.dao
* - 파일명		: EmailSendHistoryMapDao.java
* - 작성일		: 2017. 5. 18.
* - 작성자		: Administrator
* - 설명			: 이메일 전송 이력 MAP DAO
* </pre>
*/
@Repository
public class EmailSendHistoryMapDao extends MainAbstractDao {
	
	private static final String BASE_DAO_PACKAGE = "emailSendHistoryMap.";
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: EmailSendHistoryMapDao.java
	* - 작성일		: 2017. 5. 18.
	* - 작성자		: Administrator
	* - 설명			: 이메일 전송 이력 MAP 목록 조회
	* </pre>
	* @param so
	* @return
	*/
	public List<EmailSendHistoryMapVO> listEmailSendHistoryMap(EmailSendHistoryMapSO so){
		return selectList(BASE_DAO_PACKAGE + "listEmailSendHistoryMap", so);
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: EmailSendHistoryDao.java
	* - 작성일		: 2017. 5. 18.
	* - 작성자		: Administrator
	* - 설명			: 이메일 전송 이력 MAP 등록
	* </pre>
	* @param po
	* @return
	*/
	public int insertEmailSendHistoryMap(EmailSendHistoryMapPO po){
		return insert(BASE_DAO_PACKAGE + "insertEmailSendHistoryMap", po);
	}
}
