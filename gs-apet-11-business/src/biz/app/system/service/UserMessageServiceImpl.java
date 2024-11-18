package biz.app.system.service;

 
import java.util.List;
 

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import biz.app.system.dao.UserMessageDao;
import biz.app.system.model.UserMessageBasePO;
import biz.app.system.model.UserMessageBaseSO;
import biz.app.system.model.UserMessageBaseVO;
import biz.common.service.BizService;
import framework.admin.constants.AdminConstants;
import framework.admin.util.AdminSessionUtil;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
 
/**
 * 
* <pre>
* - 프로젝트명   : 11.business
* - 패키지명   : biz.app.system.service
* - 파일명      : UserMessageServiceImpl.java
* - 작성일      : 2017. 5. 15.
* - 작성자      : valuefactory 권성중
* - 설명      :  메세지 발수신 
* </pre>
 */
@Service
@Transactional
public class UserMessageServiceImpl implements UserMessageService {

	@Autowired private UserMessageDao userMessageDao;
	@Autowired private BizService bizService;

	/**
	 * 
	* <pre>
	* - 프로젝트명   : 11.business
	* - 패키지명   : biz.app.system.service
	* - 파일명      : UserMessageServiceImpl.java
	* - 작성일      : 2017. 5. 15.
	* - 작성자      : valuefactory 권성중
	* - 설명        : 쪽지리스트 
	* </pre>
	 */
	@Override
	@Transactional(readOnly=true)
	public List<UserMessageBaseVO> pageUserMessage(UserMessageBaseSO so) {
		return userMessageDao.pageUserMessage(so);
	} 
	/**
	 * 
	* <pre>
	* - 프로젝트명   : 11.business
	* - 패키지명   : biz.app.system.service
	* - 파일명      : UserMessageServiceImpl.java
	* - 작성일      : 2017. 5. 15.
	* - 작성자      : valuefactory 권성중
	* - 설명      : 쪽지조회 
	* </pre>
	 */
	@Override
	public UserMessageBaseVO getUserMessage(UserMessageBaseSO so) {
		UserMessageBaseVO vo = userMessageDao.getUserMessage(so);
		// 조회자와 수신인  아이디가 동일 할시 읽음 처리 
		if( AdminSessionUtil.getSession().getUsrNo().equals( vo.getUsrNo() ) && AdminConstants.COMM_YN_N.equals(vo.getRcvYn())   ){
			UserMessageBasePO po = new UserMessageBasePO();
			po.setUsrNo (so.getUsrNo());
			po.setNoteNo (so.getNoteNo());
			po.setRcvYn ( AdminConstants.COMM_YN_Y );
			userMessageDao.updateNoteRcvrList(po);
			
			vo = userMessageDao.getUserMessage(so);
		}	
		
		
		
		return vo;
	}
	/**
	 * 
	* <pre>
	* - 프로젝트명   : 11.business
	* - 패키지명   : biz.app.system.service
	* - 파일명      : UserMessageServiceImpl.java
	* - 작성일      : 2017. 5. 15.
	* - 작성자      : valuefactory 권성중
	* - 설명      : 쪽지 존재 여부
	* </pre>
	 */
	@Override
	public Integer existsUserMessage(Long usrNo) {
		return userMessageDao.existsUserMessage(usrNo);
	}
	
	/**
	 * 
	* <pre>
	* - 프로젝트명   : 11.business
	* - 패키지명   : biz.app.system.service
	* - 파일명      : UserMessageServiceImpl.java
	* - 작성일      : 2017. 5. 15.
	* - 작성자      : valuefactory 권성중
	* - 설명      : 쪽지등록
	* </pre>
	 */
	@Override
	public void insertUserMessage(UserMessageBasePO po) {
		int result = 0 ; 
		po.setNoteNo(bizService.getSequence(AdminConstants.SEQUENCE_NOTE_RCVR_LIST_SEQ));
		if (po.getArrUsrNo() != null && po.getArrUsrNo().length > 0) {
			for (Long usrNo : po.getArrUsrNo()) {
				po.setUsrNo(usrNo);
				result = userMessageDao.insertNoteRcvrList(po);
				if (result == 0) {
					throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
				}
			}
			result = userMessageDao.insertUserNote(po);
		}
		if(result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
	}
 
	/**
	 * 
	* <pre>
	* - 프로젝트명   : 11.business
	* - 패키지명   : biz.app.system.service
	* - 파일명      : UserMessageServiceImpl.java
	* - 작성일      : 2017. 5. 15.
	* - 작성자      : valuefactory 권성중
	* - 설명      :  쪽지삭제 
	* </pre>
	 */
	@Override
	public void deleteUserMessage(UserMessageBasePO po) {
		po.setDelYn(  AdminConstants.COMM_YN_Y );
		int result =  0 ; 
  
		if ("RCV".equals(po.getMode())){
			// 받은메세지삭제 
			result = userMessageDao.deleteNoteRcvrList(po);
		}else {
			//보낸메세지삭제 
			result = userMessageDao.deleteUserNote(po);
		}
		 
		 
		if(result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

		 
	}


}