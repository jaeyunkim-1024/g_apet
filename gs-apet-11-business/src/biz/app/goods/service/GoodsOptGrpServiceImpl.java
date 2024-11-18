package biz.app.goods.service;

import java.util.List;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import biz.app.goods.dao.GoodsOptGrpDao;
import biz.app.goods.model.GoodsOptGrpPO;
import biz.app.goods.model.GoodsOptGrpVO;

/**
* <pre>
* - 프로젝트명	: gs-apet-11-business
* - 패키지명 	: biz.app.goods.service
* - 파일명 	: GoodsOptGrpServiceImpl.java
* - 작성일	: 2021. 1. 22.
* - 작성자	: valfac
* - 설명 		: 상품 옵션 그룹 구성 서비스 impl
* </pre>
*/
@Transactional
@Service("goodsOptGrpService")
public class GoodsOptGrpServiceImpl implements GoodsOptGrpService {

	@Autowired
	private GoodsOptGrpDao goodsOptGrpDao;

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsOptGrpServiceImpl.java
	* - 작성일	: 2021. 1. 22.
	* - 작성자 	: valfac
	* - 설명 		: 옵션 그룹 상품 등록
	* </pre>
	*
	* @param GoodsOptGrpPOList
	* @param goodsId
	*/
	@Override
	public void insertGoodsOptGrp(List<GoodsOptGrpPO> goodsOptGrpPOList, String goodsId) {
		if(CollectionUtils.isNotEmpty(goodsOptGrpPOList)) {
			int rank = 1;
			for(GoodsOptGrpPO po : goodsOptGrpPOList) {
				po.setGoodsId(goodsId);
				po.setDispPriorRank(rank++);
				goodsOptGrpDao.insertGoodsOptGrp(po);				
			}
		}
	}

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsOptGrpServiceImpl.java
	* - 작성일	: 2021. 1. 22.
	* - 작성자 	: valfac
	* - 설명 		: 옵션 그룹 상품 리스트
	* </pre>
	*
	* @param goodsId
	* @return
	*/
	@Override
	public List<GoodsOptGrpVO> listGoodsOptGrp(String goodsId) {
		return goodsOptGrpDao.listGoodsOptGrp(goodsId);
	}

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsOptGrpServiceImpl.java
	* - 작성일	: 2021. 2. 25.
	* - 작성자 	: valfac
	* - 설명 		: 옵션 그룹 삭제
	* </pre>
	*
	* @param goodsId
	* @return
	*/
	@Override
	public int deleteGoodsOptGrp(String goodsId) {
		return goodsOptGrpDao.deleteGoodsOptGrp(goodsId);
	}
	
	
}