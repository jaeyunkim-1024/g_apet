package admin.web.view.goods.controller;

import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import admin.web.config.grid.GridResponse;
import admin.web.config.view.View;
import biz.app.goods.model.GoodsInquiryPO;
import biz.app.goods.model.GoodsInquirySO;
import biz.app.goods.model.GoodsInquiryVO;
import biz.app.goods.model.GoodsPO;
import biz.app.goods.service.GoodsInquiryService;
import framework.admin.util.AdminSessionUtil;
import framework.admin.util.JsonUtil;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import framework.common.util.StringUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class GoodsInquiryController {

	// 상품Q&A 관리
	@Autowired
	private GoodsInquiryService goodsInquiryService;

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: GoodsInquiryController.java
	 * - 작성일		: 2016. 5. 13.
	 * - 작성자		: valueFactory
	 * - 설명		: 상품Q&A 화면
	 * </pre>
	 *
	 * @param model
	 * @return
	 */
	@RequestMapping("/{gb}/goodsInquiryListView.do")
	public String goodsInquiryListView(Model model, @PathVariable String gb) {
		
		model.addAttribute("gb", gb);
		
		return "/goods/goodsInquiryListView";
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: GoodsInquiryController.java
	 * - 작성일		: 2016. 5. 13.
	 * - 작성자		: valueFactory
	 * - 설명		: 상품Q&A 리스트 [BO]
	 * </pre>
	 *
	 * @param so
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/*/goodsInquiryListGrid.do", method = RequestMethod.POST)
	public GridResponse goodsInquiryListGrid(GoodsInquirySO so) {
		if (StringUtil.isNotEmpty(so.getGoodsIdArea())) {
			so.setGoodsIds(StringUtil.splitEnter(so.getGoodsIdArea()));
		}

		// 업체사용자일 때 업체번호를 항상 조회조건에 사용하도록 수정함.
		if (StringUtils.equals(CommonConstants.USR_GRP_20, AdminSessionUtil.getSession().getUsrGrpCd())) {

			so.setCompNo(String.valueOf(AdminSessionUtil.getSession().getCompNo()));
		}

		List<GoodsInquiryVO> list = goodsInquiryService.listGoodsInquiryGrid(so);

		return new GridResponse(list, so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: GoodsInquiryController.java
	 * - 작성일		: 2016. 5. 16.
	 * - 작성자		: valueFactory
	 * - 설명		: 상품Q&A 리스트 전시상태 수정 [BO]
	 * </pre>
	 *
	 * @param model
	 * @param po
	 * @return
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping("/*/updateGoodsInquiryDisp.do")
	public String updateGoodsInquiryDisp(Model model,
			@RequestParam("goodsInquiryPOList") String goodsInquiryPOListStr) {
		JsonUtil jsonUt = new JsonUtil();
		GoodsPO goodsPO = new GoodsPO();

		if (StringUtil.isNotEmpty(goodsInquiryPOListStr)) {
			List<GoodsInquiryPO> goodsInquiryPOList = jsonUt.toArray(
					GoodsInquiryPO.class, goodsInquiryPOListStr);
			goodsPO.setGoodsInquiryPOList(goodsInquiryPOList);
		} else {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

		goodsInquiryService.updateGoodsInquiryDisp(goodsPO);

		return View.jsonView();
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: GoodsInquiryController.java
	 * - 작성일		: 2016. 5. 13.
	 * - 작성자		: valueFactory
	 * - 설명		: 상품Q&A 상세
	 * </pre>
	 *
	 * @param model
	 * @param so
	 * @return
	 */
	@RequestMapping(value = "/{gb}/goodsInquiryDetailView.do")
	public String goodsInquiryDetailView(Model model, GoodsInquirySO so, @PathVariable String gb) {
		// 상품 문의 번호
		Long goodsIqrNo = so.getGoodsIqrNo();

		// 상품Q&A 상세 조회
		GoodsInquiryVO goodsInquiryDetail = goodsInquiryService
				.getGoodsInquiryDetail(goodsIqrNo);

		model.addAttribute("goodsInquiryDetail", goodsInquiryDetail);
		model.addAttribute("gb", gb);
		
		return "/goods/goodsInquiryDetailView";
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: GoodsInquiryController.java
	 * - 작성일		: 2016. 5. 16.
	 * - 작성자		: valueFactory
	 * - 설명		: 상품Q&A 저장 [BO]
	 * </pre>
	 *
	 * @param model
	 * @param po
	 * @return
	 */
	@RequestMapping("/*/goodsInquiryUpdate.do")
	public String goodsInquiryUpdate(Model model, GoodsInquiryPO po) {
		goodsInquiryService.updateGoodsInquiry(po);

		return View.jsonView();
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: GoodsInquiryController.java
	 * - 작성일		: 2016. 5. 15.
	 * - 작성자		: valueFactory
	 * - 설명		: 상품Q&A 답변 화면 [BO]
	 * </pre>
	 *
	 * @param model
	 * @return
	 */
	@RequestMapping("/*/goodsReplyListView.do")
	public String goodsReplyListView(Model model) {
		return "/goods/goodsReplyListView";
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: GoodsInquiryController.java
	 * - 작성일		: 2016. 5. 15.
	 * - 작성자		: valueFactory
	 * - 설명		: 상품Q&A 답변 리스트 [BO]
	 * </pre>
	 *
	 * @param so
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/*/goodsReplyListGrid.do", method = RequestMethod.POST)
	public GridResponse goodsReplyListGrid(GoodsInquirySO so) {
		// 상품Q&A 답변 조회
		List<GoodsInquiryVO> list = goodsInquiryService.listGoodsReplyGrid(so);

		return new GridResponse(list, so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: GoodsInquiryController.java
	 * - 작성일		: 2016. 5. 15.
	 * - 작성자		: valueFactory
	 * - 설명		: 상품Q&A 답변 수정 [BO]
	 * </pre>
	 *
	 * @param model
	 * @param po
	 * @return
	 */
	@RequestMapping("/*/goodsReplyUpdate.do")
	public String goodsReplyUpdate(Model model, GoodsInquiryPO po) {
		goodsInquiryService.updateGoodsReply(po);

		return View.jsonView();
	}
}