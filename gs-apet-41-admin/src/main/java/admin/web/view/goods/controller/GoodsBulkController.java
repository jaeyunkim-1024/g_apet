package admin.web.view.goods.controller;

import admin.web.config.view.View;
import biz.app.batch.model.BatchLogPO;
import biz.app.batch.service.BatchService;
import biz.app.goods.model.*;
import biz.app.goods.service.GoodsBulkService;
import biz.app.goods.service.GoodsIconService;
import biz.app.goods.service.GoodsPriceService;
import biz.app.goods.validation.GoodsValidator;
import framework.admin.util.AdminSessionUtil;
import framework.common.constants.CommonConstants;
import framework.common.util.DateUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.stream.Collectors;

/**
 * <pre>
 * - 프로젝트명 : 41.admin.web
 * - 패키지명   : admin.web.view.goods.controller
 * - 파일명     : GoodsBulkController.java
 * - 작성일     : 2021. 01. 07.
 * - 작성자     : lhj01
 * - 설명       : 상품 일괄 관리
 * </pre>
 */

@Slf4j
@Controller
public class GoodsBulkController {

	@Autowired private GoodsPriceService goodsPriceService;

	@Autowired private BatchService batchService;

	@Autowired private GoodsBulkService goodsBulkService;

	@Autowired private GoodsIconService goodsIconService;

	@Autowired private MessageSourceAccessor message;

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: GoodsBulkController.java
	 * - 작성일		: 2021. 1. 15.
	 * - 작성자		: valueFactory
	 * - 설명		: 상품 일괄 업데이트 Layer View
	 * </pre>
	 *
	 * 상품 목록에서 일괄 업데이트 layer 호출
	 * @param model
	 * @param so
	 * @return
	 */
	@RequestMapping("/goods/goodsBulkUpdateLayerView.do")
	public String layerGoodsBulkUpdate(Model model, GoodsBaseSO so) {
		if (log.isDebugEnabled()) {
			log.debug("==================================================");
			log.debug("= {}", "Goods goodsBulkUpdateLayerView");
			log.debug("==================================================");
		}

		model.addAttribute("goodsSO", so);
		return "/goods/goodsBulkUpdateLayerView";
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: GoodsBulkController.java
	 * - 작성일		: 2021. 1. 15.
	 * - 작성자		: valueFactory
	 * - 설명			: 상품 일괄 업데이트
	 * </pre>
	 *
	 * @param model
	 * @param so
	 * @return
	 */
	@RequestMapping("/goods/goodsBulkUpdate.do")
	public String updateGoodsBulk(Model model, GoodsBasePO so) {
		if (log.isDebugEnabled()) {
			log.debug("==================================================");
			log.debug("= {}", "Goods updateGoodsBulk");
			log.debug("==================================================");
		}
		int successCnt = 0 ;

		String[] goodsIds = so.getGoodsIds();
		List<GoodsBasePO> goodsBasePOList = new ArrayList<>();
		for (String goodsId : goodsIds) {
			log.debug("##################### : " + goodsId);
			GoodsBasePO po = new GoodsBasePO();
			po.setGoodsId(goodsId);
			po.setGoodsStatCd(so.getGoodsStatCd());
			po.setShowYn(so.getShowYn());
			po.setWebMobileGbCd(so.getWebMobileGbCd());
			po.setBigo(so.getBigo());
			po.setSysUpdrNo(AdminSessionUtil.getSession().getUsrNo());
			goodsBasePOList.add(po);

			boolean result = false;
			try {
				result = goodsBulkService.updateGoods(so.getGoodsUpdateGb(), po);
			} catch (Exception e) {
				result = false;
			}
			if(result) {
				successCnt ++;
			}
		}

		model.addAttribute("successCnt", successCnt);

		return View.jsonView();
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: GoodsBulkController.java
	 * - 작성일		: 2021. 1. 11.
	 * - 작성자		: valueFactory
	 * - 설명		: 상품 가격 일괄 변경
	 * </pre>
	 *
	 * @param model
	 * @param list
	 * @return
	 */
	@RequestMapping(value = "/goods/saveGoodsBulkPrice.do", method = RequestMethod.POST)
	public String saveGoodsBulkPrice(Model model, @RequestBody ArrayList<GoodsPricePO> list) {
		if (log.isDebugEnabled()) {
			log.debug("==================================================");
			log.debug("= {}", "Goods saveGoodsBulkPrice");
			log.debug("==================================================");
		}
		int successCnt = 0 ;

		GoodsPricePO goodsPricePO = list.get(0);
		goodsPricePO.setValidCheck(true);
		GoodsValidator goodsValidator = new GoodsValidator();

		// 밸리 체크
		if(goodsPricePO.isValidCheck()) {
			goodsValidator.validatePriceUpdate(goodsPricePO);
		}

		for(GoodsPricePO po : list) {
			boolean result = true;

			try {
				po.setValidCheck(true);
				goodsPriceService.updateGoodsPrice(po);
			} catch (Exception e) {
				result = false;
			}

			if(result) {
				successCnt ++;
			}
		}

		model.addAttribute("successCnt", successCnt);

		return View.jsonView();
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 패키지명   : admin.web.view.goods.controller
	 * - 파일명      : GoodsController.java
	 * - 작성일		: 2020. 12. 21.
	 * - 작성자		: lhj01
	 * - 설명		: 상품 아이콘 등록/수정/삭제
	 * </pre>
	 * @param model
	 * @param goodsIconPOList
	 * @return
	 */
	@RequestMapping(value = "/goods/saveGoodsIcon.do", method = RequestMethod.POST)
	public String saveGoodsIcon(Model model, @RequestBody ArrayList<GoodsIconPO> list) {
		List<String> goodsIds = list.stream().map(p -> p.getGoodsId()).collect(Collectors.toList());

		int successCnt = goodsIconService.saveGoodsIcon(goodsIds, list, CommonConstants.USE_YN_N, CommonConstants.USE_YN_N);

		model.addAttribute("successCnt", successCnt);

		return View.jsonView();
	}

	/**
	 * 일회성입니다.
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/goods/sendGoodsCis.do", method = RequestMethod.GET)
	@ResponseBody
	public HashMap sendGoodsCis(Model model) {
		HashMap resultMap = new HashMap();

		BatchLogPO blpo = new BatchLogPO();

		blpo.setBatchId(CommonConstants.BATCH_GOODS_CIS_MANUAL_SEND);
		blpo.setBatchStrtDtm(DateUtil.getTimestamp());
		blpo.setSysRegrNo(CommonConstants.COMMON_BATCH_USR_NO);

		String batchRstCd= CommonConstants.BATCH_RST_CD_SUCCESS;
		String batchRstMsg= "";

		try {

			resultMap = goodsBulkService.sendGoodsCis();

			int productTotal = (int) resultMap.get("productTotal");
			int productSuccess = (int) resultMap.get("productSuccess");
			int productFail = (int) resultMap.get("productFail");

			batchRstMsg= "Success[ " +productTotal+ " + total, " +productSuccess+ " succeed, "+ productFail +" failed]";

		} catch (Exception e) {
			batchRstCd= CommonConstants.BATCH_RST_CD_FAIL;
			batchRstMsg= "Fail[Status:" + e.getMessage() +"]";

		}

		blpo.setBatchEndDtm(DateUtil.getTimestamp());
		blpo.setBatchRstCd(batchRstCd);
		blpo.setBatchRstMsg(batchRstMsg);

		batchService.insertBatchLog(blpo);

		return resultMap;
	}
}
