package biz.app.system.service;

import java.util.List;

 
import biz.app.system.model.UserMessageBasePO;
import biz.app.system.model.UserMessageBaseSO;
import biz.app.system.model.UserMessageBaseVO;

/**
 * get업무명		:	단권
 * list업무명	:	리스트
 * page업무명	:	리스트 페이징
 * insert업무명	:	입력
 * update업무명	:	수정
 * delete업무명	:	삭제
 * save업무명	:	입력 / 수정
 */
public interface UserMessageService {

	/**
	 * 
	* <pre>
	* - 프로젝트명   : 11.business
	* - 패키지명   : biz.app.system.service
	* - 파일명      : UserMessageService.java
	* - 작성일      : 2017. 5. 15.
	* - 작성자      : valuefactory 권성중
	* - 설명      : 메세지리스트 
	* </pre>
	 */
	public List<UserMessageBaseVO> pageUserMessage(UserMessageBaseSO so);
	 /**
	  * 
	 * <pre>
	 * - 프로젝트명   : 11.business
	 * - 패키지명   : biz.app.system.service
	 * - 파일명      : UserMessageService.java
	 * - 작성일      : 2017. 5. 15.
	 * - 작성자      : valuefactory 권성중
	 * - 설명      : 메세지 상세조회
	 * </pre> 
	  */
	public UserMessageBaseVO getUserMessage(UserMessageBaseSO so);
	/**
	 * 
	* <pre>
	* - 프로젝트명   : 11.business
	* - 패키지명   : biz.app.system.service
	* - 파일명      : UserMessageService.java
	* - 작성일      : 2017. 5. 15.
	* - 작성자      : valuefactory 권성중
	* - 설명      : 메세지 존재 여부 
	* </pre>
	 */
	public Integer existsUserMessage(Long usrNo);
	/**
	 * 
	* <pre>
	* - 프로젝트명   : 11.business
	* - 패키지명   : biz.app.system.service
	* - 파일명      : UserMessageService.java
	* - 작성일      : 2017. 5. 15.
	* - 작성자      : valuefactory 권성중
	* - 설명      : 메세지 등록
	* </pre>
	 */
	public void insertUserMessage(UserMessageBasePO po);
	/**
	 * 
	* <pre>
	* - 프로젝트명   : 11.business
	* - 패키지명   : biz.app.system.service
	* - 파일명      : UserMessageService.java
	* - 작성일      : 2017. 5. 15.
	* - 작성자      : valuefactory 권성중
	* - 설명      :  쪽지삭제 
	* </pre>
	 */
	public void deleteUserMessage(UserMessageBasePO po);
	
 
 
}