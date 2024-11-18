package front.web.view.goods.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import biz.app.goods.model.GoodsCommentImageVO;
import biz.app.goods.model.GoodsCommentPO;
import biz.app.goods.model.GoodsCommentSO;
import biz.app.goods.model.GoodsCommentVO;
import biz.app.goods.service.GoodsCommentService;
import biz.app.goods.service.GoodsService;
import biz.app.system.model.CodeDetailSO;
import biz.app.system.service.CodeService;
import framework.common.annotation.LoginCheck;
import framework.common.constants.CommonConstants;
import framework.common.util.StringUtil;
import framework.front.constants.FrontConstants;
import framework.front.model.Session;
import front.web.config.constants.FrontWebConstants;
import front.web.config.tiles.TilesView;
import front.web.config.view.ViewBase;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("goods")
public class GoodsCommentController {

	@Autowired private GoodsService goodsService;

	@Autowired private GoodsCommentService goodsCommentService;

	@Autowired private CodeService codeService;
	
	
	/**
	* <pre>
	* - 프로젝트명	: gs-apet-31-front
	* - 파일명		: GoodsController.java
	* - 작성일		: 2021. 2. 16.
	* - 작성자		: pcm
	* - 설명		: 상품 만족도 점수
	* </pre>
	* @param so
	* @return
	*/
	@RequestMapping(value="getGoodsCommentScore")
	public String getGoodsCommentScore(ModelMap map, ViewBase view, Session session, GoodsCommentSO so) {
		GoodsCommentVO vo = new GoodsCommentVO();
		//DlgtGoodsId
		vo = goodsCommentService.getGoodsCommentScore(so);
		map.put("scoreList", vo);
		map.put("estmList", vo.getGoodsEstmQstVOList());
		map.put("session", session);
		map.put("view", view);
		map.put("so", so);
		return TilesView.none(new String[]{"goods", "includeNew", "includeGoodsCommentScoreView"});
	}
	
	/**
	* <pre>
	* - 프로젝트명	: gs-apet-31-front
	* - 파일명		: GoodsCommentController.java
	* - 작성일		: 2021. 2. 23.
	* - 작성자		: pcm
	* - 설명		: 상품 포토 후기
	* </pre>
	* @param map
	* @param view
	* @param session
	* @param so
	* @return
	*/
	@RequestMapping(value="getGoodsPhotoComment")
	@ResponseBody
	public ModelMap getGoodsPhotoComment(GoodsCommentSO so) {
		ModelMap map = new ModelMap();
		so.setOffset(FrontWebConstants.PAGE_ROWS_10);
		List<GoodsCommentImageVO> voList = goodsCommentService.getGoodsPhotoComment(so);
		map.put("imgList", voList);
		map.put("so", so);
		return map;
	}

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-31-front
	* - 파일명		: GoodsCommentController.java
	* - 작성일		: 2021. 2. 26.
	* - 작성자		: pcm
	* - 설명		: 포토 상품평 더보기 리스트 팝업
	* </pre>
	* @param map
	* @param view	* @param session
	* @param so
	* @return
	*/
	@RequestMapping(value="getGoodsPhotoCommentPop")
	public String getGoodsPhotoCommentPop(ModelMap map, ViewBase view, Session session, GoodsCommentSO so) {
		List<GoodsCommentImageVO> voList = goodsCommentService.getGoodsPhotoCommentAll(so);

		map.put("imgList", voList);
		map.put("so", so);
		return TilesView.none(new String[]{"goods", "includeNew", "includeGoodsCommentPhotoList"});
	}

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-31-front
	* - 파일명		: GoodsCommentController.java
	* - 작성일		: 2021. 2. 25.
	* - 작성자		: pcm
	* - 설명		: 상품평 목록 조회
	* </pre>
	*/
	@RequestMapping(value="getGoodsCommentList")
	public String getGoodsCommentList(ModelMap map, Session session, GoodsCommentSO so) {
		so.setRows(FrontWebConstants.PAGE_ROWS_10);
		so.setSysRegrNo(session.getMbrNo());
		if(StringUtil.isEmpty(so.getSidx())) {
			so.setSidx("SYS_REG_DTM");
			so.setSord("DESC");
		}
		so.setGoodsEstmTp(FrontConstants.GOODS_ESTM_TP_NOR);
		
		List<GoodsCommentVO> vo = goodsCommentService.pageGoodsComment(so);
		
		if(vo != null && vo.size() != 0) {
			map.put("vo", vo);
		}
		map.put("session", session);
		map.put("so", so);
		return TilesView.none(new String[]{"goods", "includeNew", "includeGoodsCommentList"});
	}
	
	/**
	* <pre>
	* - 프로젝트명	: gs-apet-31-front
	* - 파일명		: GoodsController.java
	* - 작성일		: 2021. 2. 18.
	* - 작성자		: pcm
	* - 설명		: 상품 문의 삭제 
	* </pre>
	* @param po
	* @param session
	* @return
	*/
	@LoginCheck
	@RequestMapping(value="deleteGoodsComment")
	@ResponseBody
	public ModelMap deleteGoodsComment(GoodsCommentPO po, Session session){
		// 본인글에대한 삭제만 가능
		po.setSysRegrNo(session.getMbrNo());
		this.goodsCommentService.deleteGoodsComment(po);
		
		return new ModelMap();
	}	


	/**
	* <pre>
	* - 프로젝트명	: gs-apet-31-front
	* - 파일명		: GoodsCommentController.java
	* - 작성일		: 2021. 2. 26.
	* - 작성자		: pcm
	* - 설명		: 상품평 좋아요 체크
	* </pre>
	* @param view
	* @param session
	* @param po
	* @return
	*/
	@LoginCheck
	@RequestMapping(value="likeComment")
	@ResponseBody
	public ModelMap likeComment(ViewBase view, Session session, GoodsCommentPO po) {
		ModelMap map = new ModelMap();
		
		po.setSysRegrNo(session.getMbrNo());
		int count = goodsCommentService.likeComment(po);
		map.put("count", count);
		return map;
	}


	/**
	* <pre>
	* - 프로젝트명	: gs-apet-31-front
	* - 파일명		: GoodsCommentController.java
	* - 작성일		: 2021. 2. 26.
	* - 작성자		: pcm
	* - 설명		: 신고하기 팝업
	* </pre>
	* @param map
	* @param view	* @param session
	* @param so
	* @return
	*/
	@RequestMapping(value="commentReportPop")
	@LoginCheck
	public String commentReportPop(ModelMap map, ViewBase view, Session session, GoodsCommentSO so) {
		//신고 사유 공통 코드 조회
		CodeDetailSO codeSO = new CodeDetailSO();
		codeSO.setSidx("SORT_SEQ");
		codeSO.setSord("ASC");
		codeSO.setLimit(0);
		codeSO.setOffset(999);
		codeSO.setGrpCd(CommonConstants.RPTP_RSN);
		map.put("rptpRsnCdList", codeService.pageCodeDetail(codeSO));
		map.put("so", so);
		return TilesView.none(new String[]{"goods", "includeNew", "includeCommentReportPop"});
	}

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-31-front
	* - 파일명		: GoodsCommentController.java
	* - 작성일		: 2021. 3. 8.
	* - 작성자		: pcm
	* - 설명		: 상품평 신고
	* </pre>
	* @param view
	* @param session
	* @param po
	* @return
	*/
	@LoginCheck
	@RequestMapping(value="reportGoodsComment")
	@ResponseBody
	public ModelMap reportGoodsComment(ViewBase view, Session session, GoodsCommentPO po) {
		ModelMap map = new ModelMap();
		
		po.setSysRegrNo(session.getMbrNo());
		po.setGoodsEstmActnCd(CommonConstants.GOODS_ESTM_ACTN_RPT);
		goodsCommentService.reportGoodsComment(po);
		
		return map;
	}

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-31-front
	* - 파일명		: GoodsCommentController.java
	* - 작성일		: 2021. 2. 25.
	* - 작성자		: pcm
	* - 설명		: 상품평 목록 조회
	* </pre>
	*/
	@RequestMapping(value="getAllGoodsCommentDetail")
	public String getAllGoodsCommentDetail(ModelMap map, ViewBase view, Session session, GoodsCommentSO so) {
		so.setSysRegrNo(session.getMbrNo());
		if(StringUtil.isEmpty(so.getSidx())) {
			so.setSidx("SYS_REG_DTM");
			so.setSord("DESC");
		}
		so.setGoodsEstmTp(FrontConstants.GOODS_ESTM_TP_NOR);
		so.setAllSelectYn(FrontConstants.COMM_YN_Y);
		List<GoodsCommentVO> vo = goodsCommentService.pageGoodsComment(so);
		map.put("vo", vo);
		map.put("session", session);
		map.put("view", view);
		map.put("so", so);
		return TilesView.none(new String[]{"goods", "includeNew", "includeGoodsCommentPhotoDetailPop"});
	}

}
