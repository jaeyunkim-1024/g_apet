package biz.app.display.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import biz.app.display.model.EventPopupPO;
import biz.app.display.model.EventPopupSO;
import biz.app.display.model.EventPopupVO;
import framework.common.dao.MainAbstractDao;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
public class EventPopupDao extends MainAbstractDao {

	private static final String BASE_DAO_PACKAGE = "eventPopup.";

	//-------------------------------------------------------------------------------------------------------------------------//
	//- Front
	//-------------------------------------------------------------------------------------------------------------------------//


	//-------------------------------------------------------------------------------------------------------------------------//
	//- Admin
	//-------------------------------------------------------------------------------------------------------------------------//

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: EventPopupDao.java
	* - 작성일		: 2021. 7. 21.
	* - 작성자		: kwj
	* - 설명		: 팝업배너관리>팝업배너조회 그리드 조회
	* </pre>
	* @param EventPopupSO
	* @return
	*/
	public List<EventPopupVO> pageEventPopupList(EventPopupSO so) {
		return selectListPage(BASE_DAO_PACKAGE+"pageEventPopupList", so);
	}


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: EventPopupDao.java
	* - 작성일		: 2021. 7. 21.
	* - 작성자		: kwj
	* - 설명		: 팝업배너관리>팝업배너등록
	* </pre>
	* @param EventPopupPO
	* @return
	*/
	public int insertEventPopup (EventPopupPO po ) {
		return insert(BASE_DAO_PACKAGE+"insertEventPopup", po );
	}


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: EventPopupDao.java
	* - 작성일		: 2021. 7. 21.
	* - 작성자		: kwj
	* - 설명		: 팝업배너관리>팝업배너수정
	* </pre>
	* @param EventPopupPO
	* @return
	*/
	public int updateEventPopup (EventPopupPO po ) {
		return update(BASE_DAO_PACKAGE+"updateEventPopup", po );
	}


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: EventPopupDao.java
	* - 작성일		: 2021. 7. 21.
	* - 작성자		: kwj
	* - 설명		: 팝업배너관리>팝업배너상세
	* </pre>
	* @param EventPopupSO
	* @return
	*/
	public EventPopupVO getEventPopupDetail (EventPopupSO so ) {
		return (EventPopupVO)selectOne(BASE_DAO_PACKAGE+"getEventPopupDetail", so );
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: EventPopupDao.java
	* - 작성일		: 2021. 7. 21.
	* - 작성자		: kwj
	* - 설명		: 팝업배너관리>팝업배너삭제
	* </pre>
	* @param EventPopupPO
	* @return
	*/
	public int deleteEventPopup (EventPopupPO po ) {
		return delete(BASE_DAO_PACKAGE+"deleteEventPopup", po );
	}



}
