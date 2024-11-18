package biz.app.display.service;

import java.util.List;

import biz.app.display.model.PopupPO;
import biz.app.display.model.PopupSO;
import biz.app.display.model.PopupShowDispClsfPO;
import biz.app.display.model.PopupShowDispClsfVO;
import biz.app.display.model.PopupTargetPO;
import biz.app.display.model.PopupTargetVO;
import biz.app.display.model.PopupVO;

public interface PopupService {

	//-------------------------------------------------------------------------------------------------------------------------//
	//- Front
	//-------------------------------------------------------------------------------------------------------------------------//
	public List<PopupVO> listPopupFO(PopupSO so);

	//-------------------------------------------------------------------------------------------------------------------------//
	//- Admin
	//-------------------------------------------------------------------------------------------------------------------------//

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: PopupService.java
	* - 작성일		: 2016. 6. 24.
	* - 작성자		: eojo
	* - 설명		:
	* </pre>
	* @param so
	* @return
	*/
	public List<PopupVO> pagePopupList(PopupSO so);


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: PopupService.java
	* - 작성일		: 2016. 6. 27.
	* - 작성자		: valueFactory
	* - 설명			: popup Insert
	* </pre>
	* @param po
	* @param popupShowDispClsfPOList
	* @return
	*/
	public Integer insertPopup (PopupPO po, List<PopupShowDispClsfPO> popupShowDispClsfPOList,List<PopupTargetPO> popupTargetPOList );


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: PopupService.java
	* - 작성일		: 2016. 6. 27.
	* - 작성자		: valueFactory
	* - 설명			: 팝업 수정
	* </pre>
	* @param po
	* @param popupShowDispClsfPOList
	* @return
	*/
	public Integer updatePopup (PopupPO po, List<PopupShowDispClsfPO> popupShowDispClsfPOList ,List<PopupTargetPO> popupTargetPOList);


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: PopupService.java
	* - 작성일		: 2016. 6. 27.
	* - 작성자		: valueFactory
	* - 설명			: 팝업 조회
	* </pre>
	* @param popupNo
	* @return
	*/
	public PopupVO getPopup (Long popupNo );


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: PopupService.java
	* - 작성일		: 2016. 6. 27.
	* - 작성자		: valueFactory
	* - 설명			: 팝업 전시번호 조회
	* </pre>
	* @param popupNo
	* @return
	*/
	public List<PopupShowDispClsfVO> listPopupShowDispClsf (Long popupNo );
	
	/**
	 * 
	* <pre>
	* - 프로젝트명   : 11.business
	* - 패키지명   : biz.app.display.service
	* - 파일명      : PopupService.java
	* - 작성일      : 2017. 6. 5.
	* - 작성자      : valuefactory 권성중
	* - 설명      : 팝업상품그리드 
	* </pre>
	 */
	public List<PopupTargetVO> listpopupGoods(PopupSO so);
	

}
