package biz.app.goods.service;

import java.util.List;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import biz.app.goods.dao.FiltAttrMapDao;
import biz.app.goods.model.FiltAttrMapPO;


/**
* <pre>
* - 프로젝트명	: gs-apet-11-business
* - 패키지명 	: biz.app.goods.service
* - 파일명 	: FiltAttrMapServiceImpl.java
* - 작성일	: 2021. 1. 6.
* - 작성자	: valfac
* - 설명 		: 필터 매핑 서비스 impl
* </pre>
*/
@Transactional
@Service("filtAttMapService")
public class FiltAttrMapServiceImpl implements FiltAttrMapService {

	@Autowired
	private FiltAttrMapDao filtAttrMapDao;
	
	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: FiltAttrMapServiceImpl.java
	* - 작성일	: 2021. 1. 6.
	* - 작성자 	: valfac
	* - 설명 		: 필터 매핑 등록
	* </pre>
	*
	* @param goodsId
	* @param filtAttrMapList
	* @return
	*/
	@Override
	public void insertFiltAttrMap(String goodsId, List<FiltAttrMapPO> filtAttrMapList) {
		
		if(CollectionUtils.isNotEmpty(filtAttrMapList)) {
			for(FiltAttrMapPO po : filtAttrMapList ) {
				po.setGoodsId(goodsId);
				filtAttrMapDao.insertFiltAttrMap(po);
			}
		}
		
	}

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: FiltAttrMapServiceImpl.java
	* - 작성일	: 2021. 1. 7.
	* - 작성자 	: valfac
	* - 설명 		: 필터 속성 매핑 수정
	* </pre>
	*
	* @param goodsId
	* @param filtAttrMapList
	*/
	@Override
	public void updateFiltAttrMap(String goodsId, List<FiltAttrMapPO> filtAttrMapList) {
		filtAttrMapDao.deleteFiltAttrMap(goodsId);
		insertFiltAttrMap(goodsId, filtAttrMapList);
	}

}