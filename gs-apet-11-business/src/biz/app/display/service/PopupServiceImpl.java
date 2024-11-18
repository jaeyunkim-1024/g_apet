package biz.app.display.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import biz.app.display.dao.PopupDao;
import biz.app.display.model.PopupPO;
import biz.app.display.model.PopupSO;
import biz.app.display.model.PopupShowDispClsfPO;
import biz.app.display.model.PopupShowDispClsfVO;
import biz.app.display.model.PopupTargetPO;
import biz.app.display.model.PopupTargetVO;
import biz.app.display.model.PopupVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@Transactional
public class PopupServiceImpl implements PopupService {

	@Autowired
	private PopupDao popupDao;

	//-------------------------------------------------------------------------------------------------------------------------//
	//- Front
	//-------------------------------------------------------------------------------------------------------------------------//

	/**
	 *
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: DisplayService.java
	* - 작성일		: 2016. 6. 24.
	* - 작성자		: hjko
	* - 설명		:  팝업 목록 가져오기
	* </pre>
	* @param so
	* @return
	 */
	@Override
	public List<PopupVO> listPopupFO(PopupSO so) {
		return popupDao.listPopupFO(so);
	}

	//-------------------------------------------------------------------------------------------------------------------------//
	//- Admin
	//-------------------------------------------------------------------------------------------------------------------------//


	/* 팝업 목록 리스트
	 * @see biz.app.display.service.PopupService#pagePopupList(biz.app.display.model.PopupSO)
	 */
	@Override
	public List<PopupVO> pagePopupList(PopupSO so) {
		return popupDao.pagePopupList(so);
	}


	@Override
	public Integer insertPopup (PopupPO po, List<PopupShowDispClsfPO> popupShowDispClsfPOList,List<PopupTargetPO> popupTargetPOList ) {
		Integer popupNo = null;

		if(po != null ) {
			popupDao.insertPopup(po);
			popupNo = po.getPopupNo();
		}

		if(popupShowDispClsfPOList != null && !popupShowDispClsfPOList.isEmpty()) {
			for(PopupShowDispClsfPO dispPO : popupShowDispClsfPOList ) {
				dispPO.setPopupNo(popupNo );
				popupDao.insertPopupShowDispClsf(dispPO );
			}
		}
		
		if(popupTargetPOList != null && !popupTargetPOList.isEmpty()) {
			for(PopupTargetPO popupTargetPO : popupTargetPOList ) {
				popupTargetPO.setPopupNo(popupNo );
				popupDao.insertGoodsPopupMap(popupTargetPO );
			}
		}
		return popupNo;
	}

	@Override
	public Integer updatePopup(PopupPO po, List<PopupShowDispClsfPO> popupShowDispClsfPOList ,List<PopupTargetPO> popupTargetPOList  ) {
		Integer popupNo = null;

		if(po != null ) {
			popupNo = po.getPopupNo();
			popupDao.updatePopup(po );
		}

		popupDao.deletePopupShowDispClsf(popupNo );
		if(popupShowDispClsfPOList != null && !popupShowDispClsfPOList.isEmpty()) {
			for(PopupShowDispClsfPO dispPO : popupShowDispClsfPOList ) {
				dispPO.setPopupNo(popupNo );
				popupDao.insertPopupShowDispClsf(dispPO );
			}
		}
		
		popupDao.deleteGoodsPopupMap(popupNo );
		if(popupTargetPOList != null && !popupTargetPOList.isEmpty()) {
			for(PopupTargetPO popupTargetPO : popupTargetPOList ) {
				popupTargetPO.setPopupNo(popupNo );
				popupDao.insertGoodsPopupMap(popupTargetPO );
			}
		}

		return popupNo;
	}


	@Override
	public PopupVO getPopup (Long popupNo ) {
		return popupDao.getPopup(popupNo );
	}


	@Override
	public List<PopupShowDispClsfVO> listPopupShowDispClsf (Long popupNo ) {
		return popupDao.listPopupShowDispClsf(popupNo );
	}

	
	@Override
	@Transactional(readOnly=true)
	public List<PopupTargetVO> listpopupGoods(PopupSO so) {
		 
		return popupDao.listpopupGoods(so);
	}



}
