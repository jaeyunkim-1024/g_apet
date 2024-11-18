package admin.web.view.goods.controller;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import admin.web.config.view.View;
import biz.app.goods.model.GoodsCommentDetailPO;
import biz.app.goods.model.GoodsCommentDetailReplyVO;
import biz.app.goods.model.GoodsCommentImageVO;
import biz.app.goods.model.GoodsCommentSO;
import biz.app.goods.model.GoodsCommentVO;
import biz.app.goods.service.GoodsCommentDetailService;
import biz.app.goods.service.GoodsCommentService;
import framework.admin.util.AdminSessionUtil;
import framework.admin.util.LogUtil;
import framework.common.util.DateUtil;
import framework.common.util.StringUtil;
import lombok.extern.slf4j.Slf4j;

/**
 * <pre>
 * - 프로젝트명	: 41.admin.web
 * - 파일명		: GoodsCommentPopController.java
 * - 작성일		: 2020. 12. 31.
 * - 작성자		: yjs01
 * - 설명		: 상품후기 팝업 관리
 * </pre>
 */
@Slf4j
@Controller
public class GoodsCommentPopController {

	@Autowired
	private GoodsCommentService goodsCommentService;

	@Autowired
	private GoodsCommentDetailService goodsCommentDetailService;

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: GoodsController.java
	 * - 작성일		: 2021. 01. 04.
	 * - 작성자		: yjs01
	 * - 설명		: 일반 상품후기 팝업 관리
	 * </pre>
	 *
	 * @param model
	 * @param po
	 * @return
	 */
	@RequestMapping(value = "/goods/goodsCommentNormalPopup.do")
	public String popupGoodsCommentNormalView(Model model, GoodsCommentDetailPO po) {
		// 상품후기 상세 조회
		GoodsCommentVO goodsCommentVO = goodsCommentService.getGoodsComment(po);
		model.addAttribute("goodsComment", goodsCommentVO);
		model.addAttribute("DetailPO", po);

		// 상품 후기 신고내역 조회
		List<GoodsCommentDetailReplyVO> goodsCommentRptpRsnInfoListVO = goodsCommentDetailService.getGoodsCommentRptpRsnInfoList(po.getGoodsEstmNo());
		model.addAttribute("rptpRsnInfoListVO", goodsCommentRptpRsnInfoListVO);

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
	@RequestMapping(value = "/goods/goodsCommentDetailUpdate.do")
	public String goodsCommentDetailUpdate(Model model, GoodsCommentDetailPO po) {
		if (log.isDebugEnabled()) {
			log.debug("==================================================");
			log.debug("= {}", "Goods CommentDetailUpdate");
			log.debug("==================================================");
		}
		po.setSysUpdrNo(AdminSessionUtil.getSession().getUsrNo());
		po.setSysUpdDtm(DateUtil.getTimestamp());
		long updateCnt = goodsCommentDetailService.updateGoodsCommentDetail(po);
		if(updateCnt > 0){
			model.addAttribute("goodsEstmNo", po.getGoodsEstmNo());
			model.addAttribute("goodsBestYn", po.getGoodsBestYn());
		}
		return View.jsonView();
	}

	@RequestMapping(value = "/goods/goodsCommentDetailBestUpdate.do")
	public String goodsCommentDetailBestUpdate(Model model, GoodsCommentDetailPO po) {
		if (log.isDebugEnabled()) {
			log.debug("==================================================");
			log.debug("= {}", "Goods CommentDetailBestUpdate");
			log.debug("==================================================");
		}
		po.setSysUpdDtm(DateUtil.getTimestamp());
		po.setSysUpdrNo(AdminSessionUtil.getSession().getUsrNo());
		long updateCnt = goodsCommentDetailService.updateGoodsCommentBestDetail(po);
		if(updateCnt > 0){
			model.addAttribute("goodsEstmNo", po.getGoodsEstmNo());
			model.addAttribute("goodsBestYn", po.getGoodsBestYn());
		}
		return View.jsonView();
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: GoodsController.java
	 * - 작성일		: 2021. 01. 04.
	 * - 작성자		: yjs01
	 * - 설명		: 펫로그 상품후기 팝업 관리
	 * </pre>
	 *
	 * @param model
	 * @param po
	 * @return
	 */
	@RequestMapping(value = "/goods/goodsCommentPetLogPopup.do")
	public String popupGoodsCommentPetLogView(Model model, GoodsCommentSO so) {
		 
		// 상품후기&펫로그 상세 조회
		GoodsCommentVO goodsCommentVO = goodsCommentService.getPetLogGoodsComment(so);
		if(!StringUtil.isEmpty(goodsCommentVO) && !StringUtil.isEmpty(goodsCommentVO.getImgPathAll())) {
			goodsCommentVO.setImgPathList(goodsCommentVO.getImgPathAll().split("[|]"));
		}
		
		model.addAttribute("goodsComment", goodsCommentVO);

		//신고 목록 조회
		List<GoodsCommentDetailReplyVO> goodsCommentRptpRsnInfoListVO = goodsCommentDetailService.getPetLogGoodsCommentRptpRsnInfoList(so.getGoodsEstmNo());
		model.addAttribute("rptpRsnInfoListVO", goodsCommentRptpRsnInfoListVO);
		
		return "/goods/goodsCommentDetailPetLogView";
	}

}
