package biz.app.goods.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.ObjectUtils;

import biz.app.goods.dao.GoodsCautionDao;
import biz.app.goods.model.GoodsCautionPO;
import biz.app.goods.model.GoodsCautionSO;
import biz.app.goods.model.GoodsCautionVO;



/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.goods.service
* - 파일명		: GoodsCautionServiceImpl.java
* - 작성일		: 2016. 3. 3.
* - 작성자		: snw
* - 설명		: 상품 주의사항 서비스
* </pre>
*/
@Transactional
@Service("goodsCautionService")
public class GoodsCautionServiceImpl implements GoodsCautionService {

	@Autowired private GoodsCautionDao goodsCautionDao;

	//-------------------------------------------------------------------------------------------------------------------------//
	//- Front
	//-------------------------------------------------------------------------------------------------------------------------//

	/*
	 * 상품 주의사항 목록 조회
	 * @see biz.app.goods.service.GoodsCautionService#listGoodsCaution(biz.app.goods.model.GoodsCautionSO)
	 */
	@Override
	@Transactional(readOnly=true)
	public List<GoodsCautionVO> listGoodsCaution(GoodsCautionSO so) {
		return this.goodsCautionDao.listGoodsCaution(so);
	}


	//-------------------------------------------------------------------------------------------------------------------------//
	//- Admin
	//-------------------------------------------------------------------------------------------------------------------------//


	@Override
	@Transactional(readOnly=true)
	public GoodsCautionVO getGoodsCaution (String goodsId ) {
		return goodsCautionDao.getGoodsCaution(goodsId );
	}

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsCautionServiceImpl.java
	* - 작성일	: 2021. 1. 6.
	* - 작성자 	: valfac
	* - 설명 		: 상품 주의사항 등록
	* </pre>
	*
	* @param goodsId
	* @param goodsCautionPO
	* @return
	*/
	@Override
	public void insertGoodsCaution(String goodsId, GoodsCautionPO goodsCautionPO) {
		
		if(!ObjectUtils.isEmpty(goodsCautionPO)) {
			goodsCautionPO.setGoodsId(goodsId);
			goodsCautionDao.insertGoodsCaution(goodsCautionPO);
		}
		
	}

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsCautionServiceImpl.java
	* - 작성일	: 2021. 1. 7.
	* - 작성자 	: valfac
	* - 설명 		: 상품 주의사항 수정
	* </pre>
	*
	* @param goodsId
	* @param goodsCautionPO
	*/
	@Override
	public void updateGoodsCaution(String goodsId, GoodsCautionPO goodsCautionPO) {
		
		if(!ObjectUtils.isEmpty(goodsCautionPO)) {
			goodsCautionPO.setGoodsId(goodsId );
			goodsCautionDao.updateGoodsCationDispYn(goodsCautionPO );
			goodsCautionDao.insertGoodsCaution(goodsCautionPO );
		}
	}
	
	

}