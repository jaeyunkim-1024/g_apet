package biz.app.goods.service;

import biz.app.goods.dao.GoodsBaseDao;
import biz.app.goods.dao.GoodsIoAlmDao;
import biz.app.goods.dao.ItemDao;
import biz.app.goods.model.*;
import biz.app.pay.model.PaymentException;
import framework.common.constants.ExceptionConstants;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import biz.app.goods.dao.GoodsSkuDao;
import framework.common.constants.CommonConstants;
import framework.common.util.StringUtil;
import lombok.extern.slf4j.Slf4j;

/**
 * <pre>
 * - 프로젝트명 : 11.business
 * - 패키지명   : biz.app.goods.service
 * - 파일명     : GoodsSkuServiceImpl.java
 * - 작성일     : 2021. 01. 26.
 * - 작성자     : lhj01
 * - 설명       :
 * </pre>
 */

@Slf4j
@Transactional
@Service("goodsSkuService")
public class GoodsSkuServiceImpl implements GoodsSkuService {

	@Autowired private GoodsSkuDao goodsSkuDao;
	@Autowired private ItemDao itemDao;
	@Autowired private GoodsBaseDao goodsBaseDao;
	@Autowired private GoodsIoAlmDao goodsIoAlmDao;

	/**
	 * 단품 등록시 재고 0 등록
	 * @param goodsBasePO
	 * @param skuCdList
	 */
	@Override
	public void insertSkuBase(GoodsBasePO goodsBasePO, ItemPO itemPO) {
		GoodsSkuBasePO goodsSkuBasePO = new GoodsSkuBasePO();
		try {
			BeanUtils.copyProperties(goodsSkuBasePO, goodsBasePO );
		} catch (Exception e) {
			log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
		}
		if(StringUtil.isNotEmpty(goodsSkuBasePO.getBndNo())) {
			//sku Cd
			goodsSkuBasePO.setSkuCd(itemPO.getSkuCd());
			//매입업체번호
			goodsSkuBasePO.setPhsCompNo(goodsBasePO.getPhsCompNo());
//			goodsSkuBasePO.setStkQty(itemPO.getWebStkQty()); 웹재고 등록 안함으로 변경됨
			goodsSkuBasePO.setSkuNm(goodsBasePO.getGoodsNm());

			goodsSkuDao.insertSkuBase(goodsSkuBasePO);
		}
	}

	/**
	 * 재고 업데이트 ( 배치 )
	 * @param po
	 * @return
	 */
	@Transactional
	public int updateSkuBase(GoodsSkuBasePO po) {
		int result = goodsSkuDao.updateSkuBase(po);

		if(result > 0) {
			//재입고 알림 대상 상품일 경우, 재고 업데이트
			if(StringUtils.equals(po.getIoTargetYn(), CommonConstants.COMM_YN_Y)) {

				GoodsIoAlmPO goodsIoAlmPO = new GoodsIoAlmPO();
				goodsIoAlmPO.setGoodsId(po.getGoodsId());
				goodsIoAlmPO.setStkQty(po.getStkQty());
				goodsIoAlmPO.setStkBtchDtm(po.getSysRegDtm());

				goodsIoAlmDao.updateIoAlmTgGoods(goodsIoAlmPO);
			}
		}

		return result;
	}

	public void updateSkuStockQty(String goodsId, long itemNo, String skuCd, Integer applyQty) {
		GoodsBaseSO gbso = new GoodsBaseSO();
		gbso.setGoodsId(goodsId);
		GoodsBaseVO goodsBase = this.goodsBaseDao.getGoodsBase(gbso);

		this.updateSkuStockQty(goodsBase, itemNo, skuCd, applyQty);

	}


	public void updateSkuStockQty(GoodsBaseVO goodsBase, long itemNo, String skuCd, Integer applyQty) {
		/*************************************
		 * 재고 관리를 하는 경우에만 증/차감
		 *************************************/
		if(CommonConstants.COMM_YN_Y.equals(goodsBase.getStkMngYn())){
			GoodsSkuBasePO goodsSkuBasePO = new GoodsSkuBasePO();
			goodsSkuBasePO.setGoodsId(goodsBase.getGoodsId());
			GoodsSkuBaseVO goodsSkuBaseVO = goodsSkuDao.getSkuBase(goodsSkuBasePO);

			/*
			 * 차감시 재고가 부족한 경우
			 */
			if(applyQty.intValue() < 0
				&& (applyQty.intValue() * -1) > goodsSkuBaseVO.getStkQty()){
				throw new PaymentException(ExceptionConstants.ERROR_ORDER_WEB_STK_QTY);
			}

			/*
			 * 증/차감 처리
			 */
			GoodsSkuBasePO po = new GoodsSkuBasePO();
			po.setGoodsId(goodsBase.getGoodsId());
			po.setStkQty(applyQty);

			int result = goodsSkuDao.updateSkuBaseFo(po);
		}

	}

}
