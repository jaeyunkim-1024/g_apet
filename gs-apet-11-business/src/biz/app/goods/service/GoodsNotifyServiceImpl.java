package biz.app.goods.service;

import java.util.List;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import biz.app.goods.dao.GoodsNotifyDao;
import biz.app.goods.model.GoodsNotifyPO;
import biz.app.goods.model.GoodsNotifySO;
import biz.app.goods.model.GoodsNotifyVO;
import biz.app.goods.model.NotifyInfoVO;
import biz.common.service.BizService;


/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.goods.service
* - 파일명		: GoodsNotifyServiceImpl.java
* - 작성일		: 2016. 4. 12.
* - 작성자		: snw
* - 설명		: 상품 고시 서비스
* </pre>
*/
@Transactional
@Service("goodsNotifyService")
public class GoodsNotifyServiceImpl implements GoodsNotifyService {

	@Autowired private GoodsNotifyDao goodsNotifyDao;

	@Autowired private BizService bizService;

	/*
	 * 상품고시 목록 조회 (상품의 고시정보 및 값정보)
	 * @see biz.app.goods.service.GoodsNotifyService#listGoodsNotifyUsed(java.lang.String)
	 */
	@Override
	@Transactional(readOnly = true, isolation = Isolation.READ_UNCOMMITTED, propagation = Propagation.SUPPORTS)
	public List<GoodsNotifyVO> listGoodsNotifyUsed(String goodsId) {
		GoodsNotifySO so = new GoodsNotifySO();
		so.setGoodsId(goodsId);
		return this.goodsNotifyDao.listGoodsNotifyUsed(so);
	}


	@Override
	public NotifyInfoVO getCheckGoodsNotify(String ntfId){
		return this.goodsNotifyDao.getCheckGoodsNotify(ntfId);
	}


	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsNotifyServiceImpl.java
	* - 작성일	: 2021. 1. 6.
	* - 작성자 	: valfac
	* - 설명 		: 상품고시 정보 등록
	* </pre>
	*
	* @param goodsId
	* @param goodsNotifyPOList
	*/
	@Override
	public void insertGoodsNotify(String goodsId, List<GoodsNotifyPO> goodsNotifyPOList) {
		if(CollectionUtils.isNotEmpty(goodsNotifyPOList)) {
			for(GoodsNotifyPO po : goodsNotifyPOList) {
				po.setGoodsId(goodsId);
				goodsNotifyDao.insertGoodsNotify(po);
			}
		}
	}

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsNotifyServiceImpl.java
	* - 작성일	: 2021. 1. 7.
	* - 작성자 	: valfac
	* - 설명 		: 상품 고시 정보 수정
	* </pre>
	*
	* @param goodsId
	* @param goodsNotifyPOList
	*/
	@Override
	public void updateGoodsNotify(String goodsId, List<GoodsNotifyPO> goodsNotifyPOList) {
		if(CollectionUtils.isNotEmpty(goodsNotifyPOList)) {
			goodsNotifyDao.deleteGoodsNotify(goodsId );
			insertGoodsNotify(goodsId, goodsNotifyPOList);
		}
	}

}