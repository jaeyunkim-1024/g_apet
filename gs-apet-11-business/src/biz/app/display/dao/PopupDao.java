package biz.app.display.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import biz.app.display.model.PopupPO;
import biz.app.display.model.PopupSO;
import biz.app.display.model.PopupShowDispClsfPO;
import biz.app.display.model.PopupShowDispClsfVO;
import biz.app.display.model.PopupTargetPO;
import biz.app.display.model.PopupTargetVO;
import biz.app.display.model.PopupVO;
import framework.common.dao.MainAbstractDao;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
public class PopupDao extends MainAbstractDao {

	//private static final String BASE_DAO_PACKAGE = "popup.";

	//-------------------------------------------------------------------------------------------------------------------------//
	//- Front
	//-------------------------------------------------------------------------------------------------------------------------//

	public List<PopupVO> listPopupFO(PopupSO so) {
		return selectList("popup.listPopupFO",so);
	}

	//-------------------------------------------------------------------------------------------------------------------------//
	//- Admin
	//-------------------------------------------------------------------------------------------------------------------------//

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: PopupDao.java
	* - 작성일		: 2016. 6. 24.
	* - 작성자		: eojo
	* - 설명		:
	* </pre>
	* @param so
	* @return
	*/
	public List<PopupVO> pagePopupList(PopupSO so) {
		return selectListPage("popup.pagePopupList", so);
	}


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: PopupDao.java
	* - 작성일		: 2016. 6. 27.
	* - 작성자		: valueFactory
	* - 설명			: 팝업 등록
	* </pre>
	* @param po
	* @return
	*/
	public int insertPopup (PopupPO po ) {
		return insert("popup.insertPopup", po );
	}


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: PopupDao.java
	* - 작성일		: 2016. 6. 27.
	* - 작성자		: valueFactory
	* - 설명			: 팝업 수정
	* </pre>
	* @param po
	* @return
	*/
	public int updatePopup (PopupPO po ) {
		return update("popup.updatePopup", po );
	}


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: PopupDao.java
	* - 작성일		: 2016. 6. 27.
	* - 작성자		: valueFactory
	* - 설명			: 팝업 조회
	* </pre>
	* @param popupNo
	* @return
	*/
	public PopupVO getPopup (Long popupNo ) {
		return (PopupVO)selectOne("popup.getPopup", popupNo );
	}


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: PopupDao.java
	* - 작성일		: 2016. 6. 27.
	* - 작성자		: valueFactory
	* - 설명			: 팝업 전시번호 등록
	* </pre>
	* @param po
	* @return
	*/
	public int insertPopupShowDispClsf (PopupShowDispClsfPO po ) {
		return insert("popup.insertPopupShowDispClsf", po );
	}


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: PopupDao.java
	* - 작성일		: 2016. 6. 27.
	* - 작성자		: valueFactory
	* - 설명			: 팝업 전시번호 삭제
	* </pre>
	* @param popupNo
	* @return
	*/
	public int deletePopupShowDispClsf (Integer popupNo ) {
		return delete("popup.deletePopupShowDispClsf", popupNo );
	}


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: PopupDao.java
	* - 작성일		: 2016. 6. 27.
	* - 작성자		: valueFactory
	* - 설명			: 팝업 전시번호 조회
	* </pre>
	* @param popupNo
	* @return
	*/
	public List<PopupShowDispClsfVO> listPopupShowDispClsf (Long popupNo ) {
		return selectList("popup.listPopupShowDispClsf", popupNo );
	}
	/**
	 * 
	* <pre>
	* - 프로젝트명   : 11.business
	* - 패키지명   : biz.app.display.dao
	* - 파일명      : PopupDao.java
	* - 작성일      : 2017. 6. 5.
	* - 작성자      : valuefactory 권성중
	* - 설명      :   팝업상품그리드 
	* </pre>
	 */
	public List<PopupTargetVO> listpopupGoods(PopupSO so) {
		return selectList("popup.listpopupGoods", so);
	}
	/**
	 * 
	* <pre>
	* - 프로젝트명   : 11.business
	* - 패키지명   : biz.app.display.dao
	* - 파일명      : PopupDao.java
	* - 작성일      : 2017. 6. 5.
	* - 작성자      : valuefactory 권성중
	* - 설명      :  팝업 상품 등록 
	* </pre>
	 */
	public int insertGoodsPopupMap (PopupTargetPO po ) {
		return insert("popup.insertGoodsPopupMap", po );
	}
	/**
	 * 
	* <pre>
	* - 프로젝트명   : 11.business
	* - 패키지명   : biz.app.display.dao
	* - 파일명      : PopupDao.java
	* - 작성일      : 2017. 6. 5.
	* - 작성자      : valuefactory 권성중
	* - 설명      : 팝업상품 삭제 
	* </pre>
	 */
	public int deleteGoodsPopupMap (Integer popupNo ) {
		return delete("popup.deleteGoodsPopupMap", popupNo );
	}
	
}
