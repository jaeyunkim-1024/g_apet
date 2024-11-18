package admin.web.view.goods.controller;

import admin.web.config.grid.GridResponse;
import admin.web.config.view.View;
import biz.app.goods.model.GoodsCommentImageVO;
import biz.app.goods.model.GoodsCommentPO;
import biz.app.goods.model.GoodsCommentSO;
import biz.app.goods.model.GoodsCommentVO;
import biz.app.goods.service.GoodsCommentService;
import framework.admin.util.AdminSessionUtil;
import framework.admin.util.LogUtil;
import framework.common.constants.CommonConstants;
import framework.common.util.StringUtil;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@Slf4j
@Controller
public class GoodsCommentController {

	// 상품후기 관리
	@Autowired	private GoodsCommentService goodsCommentService;

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: GoodsController.java
	 * - 작성일		: 2020. 12. 31.
	 * - 작성자		: valueFactory
	 * - 설명		: 상품후기 관리
	 * </pre>
	 *
	 * @param model
	 * @param so
	 * @return
	 */
	@RequestMapping(value = "/goods/goodsCommentListView.do")
	public String goodsCommentListView(Model model, GoodsCommentSO so) {
		if (log.isDebugEnabled()) {
			log.debug("==================================================");
			log.debug("= {}", "Goods PriceLayerView");
			log.debug("==================================================");
		}

		return "/goods/goodsCommentListView";
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: GoodsController.java
	 * - 작성일		: 2020. 12. 31.
	 * - 작성자		: valueFactory
	 * - 설명		: 상품후기 그리드
	 * </pre>
	 *
	 * @param model
	 * @param so
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/goods/goodsCommentGrid.do", method = RequestMethod.POST)
	public GridResponse goodsCommentGrid(Model model, GoodsCommentSO so) {
		if (log.isDebugEnabled()) {
			log.debug("########## : {} ", so.toString());
		}

		if (!StringUtil.isEmpty(so.getGoodsIdArea())) {
			so.setGoodsIds(StringUtil.splitEnter(so.getGoodsIdArea()));
		}

		// 업체사용자일 때 업체번호를 항상 조회조건에 사용하도록 수정함.
		if (StringUtils.equals(CommonConstants.USR_GRP_20, AdminSessionUtil.getSession().getUsrGrpCd())) {

			so.setCompNo(AdminSessionUtil.getSession().getCompNo());
		}
		List<GoodsCommentVO> list = goodsCommentService.pageGoodsCommentGrid(so);
		list.stream().forEach(v ->{
			if(StringUtil.isEmpty(v.getContent())) {
				v.setContent("[내용없음]");
			}
		});

		/*Integer rowNum = so.getTotalCount() - (((int)so.getPage()-1)*so.getRows());
		for(GoodsCommentVO v : list){
			v.setRowNum(Long.parseLong(rowNum.toString()));
			rowNum -=1;
		}*/

		return new GridResponse(list, so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: GoodsController.java
	 * - 작성일		: 2020. 12. 31.
	 * - 작성자		: valueFactory
	 * - 설명		: 상품후기 상세 조회
	 * </pre>
	 *
	 * @param model
	 * @param so
	 * @return
	 */
	@RequestMapping(value = "/goods/goodsCommentDetailView.do")
	public String goodsCommentDetailView(Model model, GoodsCommentSO so) {
		if (log.isDebugEnabled()) {
			log.debug("==================================================");
			log.debug("= {}", "Goods Comment Detail");
			log.debug("==================================================");
			LogUtil.log(so);
		}

		Long goodsEstmNo = so.getGoodsEstmNo();

		// 상품후기 상세 조회
		GoodsCommentVO goodsCommentVO = goodsCommentService.getGoodsComment(so);

		// 상품후기 이미지 조회
		List<GoodsCommentImageVO> goodsCommentImageVOList = goodsCommentService
				.listGoodsCommentImage(goodsEstmNo);

		model.addAttribute("goodsComment", goodsCommentVO);
		model.addAttribute("goodsCommentImageList", goodsCommentImageVOList);

		return "/goods/goodsCommentDetailView";
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: GoodsController.java
	 * - 작성일		: 2020. 12. 31.
	 * - 작성자		: valueFactory
	 * - 설명		: 상품후기 수정
	 * </pre>
	 *
	 * @param model
	 * @param po
	 * @return
	 */
	@RequestMapping(value = "/goods/goodsCommentUpdate.do")
	public String goodsCommentUpdate(Model model, GoodsCommentPO po) {
		if (log.isDebugEnabled()) {
			log.debug("########## : {} ", po.toString());
		}

		goodsCommentService.updateGoodsCommentBo(po);

		model.addAttribute("goodsEstmNo", po.getGoodsEstmNo());
		return View.jsonView();
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: GoodsController.java
	 * - 작성일		: 2020. 12. 31.
	 * - 작성자		: valueFactory
	 * - 설명		: 상품후기 일괄 수정 조회
	 * </pre>
	 *
	 * @param model
	 * @param so
	 * @return
	 */
	@RequestMapping("/goods/goodsCommentBatchUpdateLayerView.do")
	public String goodsCommentBatchUpdateLayerView(Model model,
												   GoodsCommentSO so) {
		if (log.isDebugEnabled()) {
			log.debug("==================================================");
			log.debug("= {}", "Goods goodsCommentBatchUpdateLayerView");
			log.debug("==================================================");
		}

		model.addAttribute("GoodsComment", so);
		return "/goods/goodsCommentBatchUpdateLayerView";
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: GoodsController.java
	 * - 작성일		: 2020. 12. 31.
	 * - 작성자		: valueFactory
	 * - 설명		: 상품후기 일괄 수정
	 * </pre>
	 *
	 * @param model
	 * @param so
	 * @return
	 */
	@RequestMapping("/goods/goodsCommentBatchUpdate.do")
	public String goodsCommentBatchUpdate(Model model, GoodsCommentSO so) {
		if (log.isDebugEnabled()) {
			log.debug("==================================================");
			log.debug("= {}", "Goods Comment BatchUpdate");
			log.debug("==================================================");
		}

		Long[] goodsEstmNos = so.getGoodsEstmNos();
		List<GoodsCommentPO> goodsCommentPOList = new ArrayList<>();

		for (Long goodsEstmNo : goodsEstmNos) {
			log.debug("##################### : " + Arrays.toString(goodsEstmNos));
			GoodsCommentPO po = new GoodsCommentPO();
			po.setGoodsEstmNo(goodsEstmNo);
			po.setSysDelYn(so.getSysDelYn());

			goodsCommentPOList.add(po);
		}

		int updateCnt = goodsCommentService.updateGoodsCommentBatch(goodsCommentPOList);
		model.addAttribute("updateCnt", updateCnt);
		return View.jsonView();
	}

}
