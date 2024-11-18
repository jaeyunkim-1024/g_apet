package biz.app.display.service;

import java.util.List;

import biz.app.display.model.EventPopupPO;
import biz.app.display.model.EventPopupSO;
import biz.app.display.model.EventPopupVO;

public interface EventPopupService {

	//-------------------------------------------------------------------------------------------------------------------------//
	//- Front
	//-------------------------------------------------------------------------------------------------------------------------//
	

	//-------------------------------------------------------------------------------------------------------------------------//
	//- Admin
	//-------------------------------------------------------------------------------------------------------------------------//

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: EventPopupService.java
	* - 작성일		: 2021. 7. 21.
	* - 작성자		: kwj
	* - 설명		: 팝업배너관리>팝업배너조회 그리드 조회
	* </pre>
	* @param EventPopupSO
	* @return
	*/
	public List<EventPopupVO> pageEventPopupList(EventPopupSO so);


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: EventPopupService.java
	* - 작성일		: 2021. 7. 21.
	* - 작성자		: kwj
	* - 설명		: 팝업배너관리>팝업배너등록
	* </pre>
	* @param EventPopupPO
	* @return
	*/
	public int insertEventPopup (EventPopupPO po);


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: EventPopupService.java
	* - 작성일		: 2021. 7. 21.
	* - 작성자		: kwj
	* - 설명		: 팝업배너관리>팝업배너수정
	* </pre>
	* @param EventPopupPO
	* @return
	*/
	public int updateEventPopup (EventPopupPO po);


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: EventPopupService.java
	* - 작성일		: 2021. 7. 21.
	* - 작성자		: kwj
	* - 설명		: 팝업배너관리>팝업배너상세
	* </pre>
	* @param EventPopupSO
	* @return
	*/
	public EventPopupVO getEventPopupDetail (EventPopupSO so );
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: EventPopupService.java
	* - 작성일		: 2021. 7. 21.
	* - 작성자		: kwj
	* - 설명		: 팝업배너관리>팝업배너삭제
	* </pre>
	* @param EventPopupPO
	* @return
	*/
	public int deleteEventPopup (EventPopupPO po);

}
