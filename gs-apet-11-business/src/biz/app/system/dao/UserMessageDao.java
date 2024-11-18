package biz.app.system.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

 
import biz.app.system.model.UserMessageBasePO;
import biz.app.system.model.UserMessageBaseSO;
import biz.app.system.model.UserMessageBaseVO;
import framework.common.dao.MainAbstractDao;

@Repository
public class UserMessageDao extends MainAbstractDao {

	/**
	 * 
	* <pre>
	* - 프로젝트명   : 11.business
	* - 패키지명   : biz.app.system.dao
	* - 파일명      : UserMessageDao.java
	* - 작성일      : 2017. 5. 15.
	* - 작성자      : valuefactory 권성중
	* - 설명      : 메세지 리스트 
	* </pre>
	 */
	public List<UserMessageBaseVO> pageUserMessage(UserMessageBaseSO so) {
		return selectListPage("userMessage.pageUserMessage", so);
	}
	/**
	 * 
	* <pre>
	* - 프로젝트명   : 11.business
	* - 패키지명   : biz.app.system.dao
	* - 파일명      : UserMessageDao.java
	* - 작성일      : 2017. 5. 15.
	* - 작성자      : valuefactory 권성중
	* - 설명      : 메세지 상세조회
	* </pre>
	 */
	public UserMessageBaseVO getUserMessage(UserMessageBaseSO so) {
		return (UserMessageBaseVO) selectOne("userMessage.getUserMessage", so);
	}
	/**
	 * 
	* <pre>
	* - 프로젝트명   : 11.business
	* - 패키지명   : biz.app.system.dao
	* - 파일명      : UserMessageDao.java
	* - 작성일      : 2017. 5. 15.
	* - 작성자      : valuefactory 권성중
	* - 설명      : 메세지 존재유무 
	* </pre>
	 */
	@SuppressWarnings("all")
	public Integer existsUserMessage(Long usrNo) {
		Integer result = 0;
		try {
			result = selectOne("userMessage.existsUserMessage", usrNo);
		} catch (Exception e) {
			result = 0;
		} finally {
			return result;
		}
	}
	/**
	 * 
	* <pre>
	* - 프로젝트명   : 11.business
	* - 패키지명   : biz.app.system.dao
	* - 파일명      : UserMessageDao.java
	* - 작성일      : 2017. 5. 15.
	* - 작성자      : valuefactory 권성중
	* - 설명      :  쪽지 수신자목록 
	* </pre>
	 */
	public int insertNoteRcvrList(UserMessageBasePO po) {
		return insert("userMessage.insertNoteRcvrList", po);
	}
	/**
	 * 
	* <pre>
	* - 프로젝트명   : 11.business
	* - 패키지명   : biz.app.system.dao
	* - 파일명      : UserMessageDao.java
	* - 작성일      : 2017. 5. 15.
	* - 작성자      : valuefactory 권성중
	* - 설명      :  읽음 처리 
	* </pre>
	 */
	
	public int updateNoteRcvrList(UserMessageBasePO po) {
		return update("userMessage.updateNoteRcvrList", po);
	}
	/**
	 * 
	* <pre>
	* - 프로젝트명   : 11.business
	* - 패키지명   : biz.app.system.dao
	* - 파일명      : UserMessageDao.java
	* - 작성일      : 2017. 5. 15.
	* - 작성자      : valuefactory 권성중
	* - 설명      : 수신자 쪽지  삭제 
	* </pre>
	 */
	public int deleteNoteRcvrList(UserMessageBasePO po) {
		return update("userMessage.deleteNoteRcvrList", po);
	}
	
	/**
	 * 
	* <pre>
	* - 프로젝트명   : 11.business
	* - 패키지명   : biz.app.system.dao
	* - 파일명      : UserMessageDao.java
	* - 작성일      : 2017. 5. 24.
	* - 작성자      : valuefactory 권성중
	* - 설명      :   발신자 쪽지 삭제 
	* </pre>
	 */
	public int deleteUserNote(UserMessageBasePO po) {
		return update("userMessage.deleteUserNote", po);
	}
	
	
	/**
	 * 
	* <pre>
	* - 프로젝트명   : 11.business
	* - 패키지명   : biz.app.system.dao
	* - 파일명      : UserMessageDao.java
	* - 작성일      : 2017. 5. 15.
	* - 작성자      : valuefactory 권성중
	* - 설명      : 메세지 등록 1 insertUserNote 테이블 등록 
	* </pre>
	 */
	public int insertUserNote(UserMessageBasePO po) {
		return insert("userMessage.insertUserNote", po);
	}
	
	/**
	 * 
	* <pre>
	* - 프로젝트명   : 11.business
	* - 패키지명   : biz.app.system.dao
	* - 파일명      : UserMessageDao.java
	* - 작성일      : 2017. 5. 15.
	* - 작성자      : valuefactory 권성중
	* - 설명      :메세지 등록 2 insertUserMessage 테이블 등록 
	* </pre>
	 */
	public int insertUserMessage(UserMessageBasePO po) {
		return insert("userMessage.insertUserMessage", po);
	}
	
	  

}
