package biz.app.goods.service;

import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;

import biz.app.goods.model.*;
import biz.interfaces.cis.service.CisGoodsService;
import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.beanutils.BeanUtilsBean;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.ObjectUtils;

import biz.app.goods.dao.GoodsDao;
import biz.app.goods.dao.GoodsPriceDao;
import biz.app.goods.dao.ItemDao;
import biz.app.goods.validation.GoodsValidator;
import framework.admin.constants.AdminConstants;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import framework.common.util.DateUtil;
import lombok.extern.slf4j.Slf4j;

/**
* <pre>
* - 프로젝트명	: gs-apet-11-business
* - 패키지명 	: biz.app.goods.service
* - 파일명 	: GoodsPriceServiceImpl.java
* - 작성일	: 2021. 1. 7.
* - 작성자	: valfac
* - 설명 		: 상품 가격 서비스 impl
* </pre>
*/
@Transactional
@Slf4j
@Service("goodsPriceService")
public class GoodsPriceServiceImpl implements GoodsPriceService {

	@Autowired private CisGoodsService cisGoodsService;

	@Autowired
	private GoodsPriceDao goodsPriceDao;
	@Autowired
	private ItemDao itemDao;
	@Autowired
	private GoodsDao goodsDao;
	
	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsPriceServiceImpl.java
	* - 작성일	: 2021. 1. 7.
	* - 작성자 	: valfac
	* - 설명 		: 상품 가격 등록
	* </pre>
	*
	* @param goodsPricePO
	* @param goodsBasePO
	* @return
	*/
	public GoodsPricePO insertGoodsPrice(GoodsPricePO goodsPricePO, GoodsBasePO goodsBasePO) {
		
		goodsPricePO.setGoodsId(goodsBasePO.getGoodsId());
		goodsPricePO.setStId(goodsBasePO.getStId());

		if(!ObjectUtils.isEmpty(goodsPricePO)) {
			// interface 등록 때문에 추가. hjko
			if(ObjectUtils.isEmpty(goodsPricePO.getSaleStrtDtm())){
				goodsPricePO.setSaleStrtDtm(DateUtil.getTimestamp());
			}
			goodsPricePO.setGoodsAmtTpCd(AdminConstants.GOODS_AMT_TP_10);
			if(ObjectUtils.isEmpty(goodsPricePO.getSaleEndDtm())){
				goodsPricePO.setSaleEndDtm(DateUtil.getTimestamp(CommonConstants.COMMON_END_DATE, CommonConstants.COMMON_DATE_FORMAT) );
			}

			goodsPriceDao.insertGoodsPrice(goodsPricePO);
			
		} else if (StringUtils.equals(AdminConstants.GOODS_TP_30, goodsBasePO.getGoodsTpCd())) {
			// 사은품등록일 경우 goodsPricePO 가 NULL 일 것임. 그리고 사은품 가격을 0원으로 등록함.
			if (ObjectUtils.isEmpty(goodsPricePO)) {
				goodsPricePO = new GoodsPricePO();
			}
			// interface 등록 때문에 추가. hjko
			if(ObjectUtils.isEmpty(goodsPricePO.getSaleStrtDtm())){
				goodsPricePO.setSaleStrtDtm(DateUtil.getTimestamp() );
			}
			goodsPricePO.setGoodsAmtTpCd(AdminConstants.GOODS_AMT_TP_10 );
			goodsPricePO.setOrgSaleAmt(0L);
			goodsPricePO.setSaleAmt(0L);
			// interface 등록 때문에 추가. hjko
			if(ObjectUtils.isEmpty(goodsPricePO.getSaleEndDtm())){
				goodsPricePO.setSaleEndDtm(DateUtil.getTimestamp(CommonConstants.COMMON_END_DATE, CommonConstants.COMMON_DATE_FORMAT) );
			}
			goodsPriceDao.insertGoodsPrice(goodsPricePO );
		}
		
		return goodsPricePO;
	}

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsPriceServiceImpl.java
	* - 작성일	: 2021. 1. 13.
	* - 작성자 	: valfac
	* - 설명 	: 상품 가격 변경
	* </pre>
	*
	* @param po
	*/
	public void updateGoodsPrice(GoodsPricePO po) {
		
		GoodsValidator goodsValidator = new GoodsValidator();
		// 현재일시
		Timestamp now = DateUtil.getTimestamp();
		// 밸리 체크
		// 30분 체크 -> 실시간 변경 20210530
		if(po.isValidCheck()) {
			goodsValidator.validatePriceUpdate(po);
		}
		
		if(ObjectUtils.isEmpty(po.getSaleStrtDtm())) {
			po.setSaleStrtDtm(now);
		}
		
		if(ObjectUtils.isEmpty(po.getSaleEndDtm())) {
			po.setSaleEndDtm(DateUtil.getTimestamp(CommonConstants.COMMON_END_DATE, CommonConstants.COMMON_DATE_FORMAT));
		}
		
		// Bean 복사를 위한 처리
		BeanUtilsBean.getInstance().getConvertUtils().register(false, true, 0);
				
		GoodsPriceSO so = new GoodsPriceSO();
		so.setGoodsId(po.getGoodsId());
		so.setDelYn(CommonConstants.COMM_YN_N);
		List<GoodsPriceVO> list = goodsPriceDao.listGoodsPrice(so);
		int result;

		for(GoodsPriceVO price : list) {
			Timestamp orgStrtDtm = price.getSaleStrtDtm();
			Timestamp orgEndDtm = price.getSaleEndDtm();

			if(po.getSaleStrtDtm().compareTo(orgStrtDtm) <= 0 && po.getSaleEndDtm().compareTo(orgEndDtm) >= 0) {
				/*
				 * CASE 1 : org       A●------●B
				 * 	        insert  C●-----------●D
	 			*/
				log.debug("CASE 1");
				GoodsPricePO deletePO = new GoodsPricePO();
				deletePO.setGoodsPrcNo(price.getGoodsPrcNo());
				deletePO.setDelYn(CommonConstants.COMM_YN_Y);
				result = goodsPriceDao.deleteGoodsPrice(deletePO);
				
				if (result != 1) {
					throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
				}
				
			}else if(po.getSaleStrtDtm().compareTo(orgStrtDtm) > 0 && po.getSaleEndDtm().compareTo(orgEndDtm) < 0) {
				/*
				 * CASE 2 : org     A●-----------●B
				 * 	        insert     C○------○D
	 			*/
				log.debug("CASE 2");
				GoodsPricePO updatePO = new GoodsPricePO();
				try {
					BeanUtils.copyProperties(updatePO, price);
					updatePO.setSaleEndDtm(DateUtil.addSeconds(po.getSaleStrtDtm(), -1));
					//가격 CIS 전송여부 세팅
					updatePO.setCisYn(getCisYn(now, updatePO.getSaleStrtDtm(), updatePO.getSaleEndDtm(), po.getGoodsCstrtTpCd()));
					result = goodsPriceDao.updateGoodsPrice(updatePO);
					
					if (result != 1) {
						throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
					}
				} catch (Exception e) {
					log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
					throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
				}
				
				if (result != 1) {
					throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
				}
				
				GoodsPricePO insertPO = new GoodsPricePO();
				try {
					BeanUtils.copyProperties(insertPO, price);
					insertPO.setSaleStrtDtm(DateUtil.addSeconds(po.getSaleEndDtm(), 1));
					insertPO.setCisYn(getCisYn(now, insertPO.getSaleStrtDtm(), insertPO.getSaleEndDtm(), po.getGoodsCstrtTpCd()));
					result = goodsPriceDao.insertGoodsPrice(insertPO);
					
					if (result != 1) {
						throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
					}
				} catch (Exception e) {
					log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
					throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
				}
			}else if(po.getSaleStrtDtm().compareTo(orgStrtDtm) <= 0 && po.getSaleEndDtm().compareTo(orgEndDtm) < 0 && po.getSaleEndDtm().compareTo(orgStrtDtm) >= 0) {
				/*
				 * CASE 3 : org            A●--------●B
				 * 	        insert     C●-------○D
				 * include A=D
	 			*/
				log.debug("CASE 3");
				GoodsPricePO updatePO = new GoodsPricePO();
				
				try {
					BeanUtils.copyProperties(updatePO, price);
					updatePO.setSaleStrtDtm(DateUtil.addSeconds(po.getSaleEndDtm(), 1));
					updatePO.setCisYn(getCisYn(now, updatePO.getSaleStrtDtm(), updatePO.getSaleEndDtm(), po.getGoodsCstrtTpCd()));
					result = goodsPriceDao.updateGoodsPrice(updatePO);
					
					if (result != 1) {
						throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
					}
				} catch (Exception e) {
					log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
					throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
				}
			}else if(po.getSaleStrtDtm().compareTo(orgStrtDtm) > 0 && po.getSaleEndDtm().compareTo(orgEndDtm) >= 0 && po.getSaleStrtDtm().compareTo(orgEndDtm) <= 0) {
				/*
				 * CASE 3 : org        A●--------●B
				 * 	        insert          C○-------●D
				 * include C=B
	 			*/
				log.debug("CASE 4");
				GoodsPricePO updatePO = new GoodsPricePO();
				
				try {
					BeanUtils.copyProperties(updatePO, price);
					updatePO.setSaleEndDtm(DateUtil.addSeconds(po.getSaleStrtDtm(), -1));
					updatePO.setCisYn(getCisYn(now, updatePO.getSaleStrtDtm(), updatePO.getSaleEndDtm(), po.getGoodsCstrtTpCd()));
					result = goodsPriceDao.updateGoodsPrice(updatePO);
					
					if (result != 1) {
						throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
					}
				} catch (Exception e) {
					log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
					throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
				}
			}
		}

		po.setCisYn(getCisYn(now, po.getSaleStrtDtm(), po.getSaleEndDtm(), po.getGoodsCstrtTpCd()));
		result = goodsPriceDao.insertGoodsPrice(po);

		if(now.compareTo(po.getSaleStrtDtm()) >=0 && now.compareTo(po.getSaleEndDtm()) <= 0) {
			//해당 가격 CIS 전송
			//실패할 경우, 1분 배치에 마음을 기대보자
			if(StringUtils.equals(CommonConstants.GOODS_CSTRT_TP_ITEM, po.getGoodsCstrtTpCd())) {

				Integer cisNo = goodsDao.selectGoodsCisNo(po.getGoodsId());

				if(cisNo != null) {
					try {
						SkuInfoSO skuInfoSO = new SkuInfoSO();
						skuInfoSO.setGoodsId(po.getGoodsId());
						skuInfoSO.setBatchYn(CommonConstants.COMM_YN_N);
						skuInfoSO.setGoodsCstrtTpCd(po.getGoodsCstrtTpCd());
						skuInfoSO.setSendType("update");

						List<SkuInfoVO> skuInfoVOS = cisGoodsService.getStuInfoListForSend(skuInfoSO);

						HashMap cisResult = cisGoodsService.sendClsGoods(skuInfoSO.getSendType(), skuInfoSO.getGoodsCstrtTpCd(), skuInfoVOS);
						HashMap resultMsgMap = (HashMap) cisResult.get(po.getGoodsId());

						//CIS 응답코드
						String resCd = (String) resultMsgMap.keySet().toArray()[0];
						//CIS 응답메세지

						if(resCd.equalsIgnoreCase(CommonConstants.CIS_API_SUCCESS_CD)) {
							po.setCisYn(CommonConstants.COMM_YN_Y);
							goodsPriceDao.updateGoodsPriceCisYn(po);
						}

					} catch (Exception e) {}
				}
			}
		}
		
		// 사전예약 상품 할인일 경우 웹재고 update 20.03.03 , GOODS_TP_40 update 20.04.06
		if(StringUtils.equals(po.getGoodsAmtTpCd(), CommonConstants.GOODS_AMT_TP_60)){
			
			GoodsBaseVO goodsBaseVO = goodsDao.getGoodsDetail(po.getGoodsId());
			
			// 자사일 경우만 update COMP_GB_10, 사전예약은 한번만 사용한다고 가정한다... 확인필요.. 
			if(StringUtils.equals(goodsBaseVO.getCompGbCd(), CommonConstants.COMP_GB_10) ) {
				ItemPO itemPO = new ItemPO();
				itemPO.setItemNo(goodsBaseVO.getItemNo());
				itemPO.setWebStkQty(po.getRsvBuyQty());
				int itemResult = itemDao.updateItemWebStockQty(itemPO);
				
				if (itemResult < 1) {
					throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
				}
			}
			
			GoodsBasePO goodsBasePO = new GoodsBasePO();
			goodsBasePO.setGoodsId(goodsBaseVO.getGoodsId());
			goodsBasePO.setGoodsTpCd(CommonConstants.GOODS_TP_40);
			int tpCdCnt = goodsDao.updateGoodsTpCd(goodsBasePO);
			
			if(tpCdCnt < 1) {
				throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
			}
		}
		
		if (result != 1) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		
	}

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsPriceServiceImpl.java
	* - 작성일	: 2021. 1. 13.
	* - 작성자 	: valfac
	* - 설명 		: 현재 가격 조회
	* </pre>
	*
	* @param goodsId
	* @return
	*/
	@Override
	public GoodsPriceVO getCurrentGoodsPrice (String goodsId ) {
		return goodsPriceDao.getCurrentGoodsPrice(goodsId );
	}

	/**
	 * cis 전송 여부
	 * @param orgDtm
	 * @param strtDtm
	 * @param endDtm
	 * @param goodsCstrtTpCd
	 * @return
	 */
	protected String getCisYn (Timestamp orgDtm, Timestamp strtDtm, Timestamp endDtm, String goodsCstrtTpCd) {
		String cisYn = null;

		if(!StringUtils.equals(CommonConstants.GOODS_CSTRT_TP_ITEM, goodsCstrtTpCd)) {
			return null;
		}

		//비교날짜가 시작일시와 종료일시 사이에 포함되어 있지 않을 경우, CIS 전송 여부는 N으로 세팅한다.
		//어디냐 대체
		if(orgDtm.compareTo(strtDtm) >= 0 && orgDtm.compareTo(endDtm) <= 0) {
			//비교날짜가 시작일시와 종료일시 사이다
			//이미 전송되어 있거나..현재값 유지하자
		} else if(orgDtm.compareTo(strtDtm) < 0) {
			//비교날짜가 시작일시보다 전일 경우 CIS 전송 여부는 N으로 세팅한다.
			//아직 도래하지 않았기 때문
			cisYn = CommonConstants.COMM_YN_N;
		} else if(orgDtm.compareTo(endDtm) > 0) {
			//비교날짜가 종료일시보다 뒤일 경우 CIS 전송 여부는 Y으로 세팅한다.
			//이미 지나간 날짜이기 때문
			//cisYn = CommonConstants.COMM_YN_Y;
		}

		return cisYn;
	}

	public int editGoodsPriceCisYn(Long goodsPrcNo, String cisYn) {
		GoodsPricePO po = new GoodsPricePO();
		po.setGoodsPrcNo(goodsPrcNo);
		po.setCisYn(cisYn);
		return goodsPriceDao.updateGoodsPriceCisYn(po);

	}

}