package biz.app.goods.service;

import java.util.List;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import biz.app.goods.dao.GoodsTagMapDao;
import biz.app.goods.model.GoodsTagMapPO;
import biz.app.goods.model.GoodsTagMapVO;


/**
* <pre>
* - 프로젝트명	: gs-apet-11-business
* - 패키지명 	: biz.app.goods.service
* - 파일명 	: GoodsTagMapServiceImpl.java
* - 작성일	: 2020. 12. 29.
* - 작성자	: valfac
* - 설명 		: 상품 태그 매핑 serviceImpl
* </pre>
*/
@Transactional
@Service("goodsTagMapService")
public class GoodsTagMapServiceImpl implements GoodsTagMapService {

	@Autowired
	private GoodsTagMapDao goodsTagMapDao;


	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsTagMapServiceImpl.java
	* - 작성일	: 2021. 1. 6.
	* - 작성자 	: valfac
	* - 설명 		: 상품 태그 매핑 리스트
	* </pre>
	*
	* @param goodsId
	* @return
	*/
	@Override
	@Transactional(readOnly=true)
	public List<GoodsTagMapVO> listGoodsTagMap(String goodsId) {
		return goodsTagMapDao.listGoodsTagMap(goodsId);
	}
	
	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsTagMapServiceImpl.java
	* - 작성일	: 2021. 1. 6.
	* - 작성자 	: valfac
	* - 설명 		: 상품 태그 매핑 등록
	* </pre>
	*
	* @param goodsId
	* @param goodsTagMapList
	* @return
	*/
	@Override
	public void insertGoodsTagMap(String goodsId, List<GoodsTagMapPO> goodsTagMapList) {

		if(CollectionUtils.isNotEmpty(goodsTagMapList)) {
			for(GoodsTagMapPO po : goodsTagMapList ) {
				po.setGoodsId(goodsId);
				goodsTagMapDao.insertGoodsTagMap(po);
			}
		}

	}

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsTagMapServiceImpl.java
	* - 작성일	: 2021. 1. 7.
	* - 작성자 	: valfac
	* - 설명 		: 상품 태그 매핑 수정
	* </pre>
	*
	* @param goodsId
	* @param goodsTagMapList
	*/
	@Override
	public void updateGoodsTagMap(String goodsId, List<GoodsTagMapPO> goodsTagMapList) {
		
		goodsTagMapDao.deleteGoodsTagMap(goodsId);
		insertGoodsTagMap(goodsId, goodsTagMapList);
	}
	
	

}