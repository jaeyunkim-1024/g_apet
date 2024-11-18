package front.web.view.mypage.controller;

import java.util.List;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import biz.app.goods.model.GoodsBaseVO;
import biz.app.goods.model.GoodsCommentPO;
import biz.app.goods.model.GoodsCommentSO;
import biz.app.goods.model.GoodsCommentVO;
import biz.app.goods.service.GoodsCommentService;
import biz.app.order.model.OrderDetailSO;
import biz.app.petlog.model.PetLogBaseSO;
import framework.common.annotation.LoginCheck;
import framework.common.constants.CommonConstants;
import framework.common.util.StringUtil;
import framework.front.constants.FrontConstants;
import framework.front.model.Session;
import front.web.config.tiles.TilesView;
import front.web.config.view.ViewBase;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("mypage")
public class MyCommentController {

	@Autowired private GoodsCommentService goodsCommentService;
	

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-31-front
	* - 파일명		: MyCommentController.java
	* - 작성일		: 2021. 3. 11.
	* - 작성자		: pcm
	* - 설명		: 나의 상품 후기 페이지
	* </pre>
	* @param map
	* @param session
	* @param view
	* @return
	*/
	@RequestMapping(value="goodsCommentList")
	@LoginCheck
	public String goodsCommentList( ModelMap map, Session session, ViewBase view, @RequestParam(value="selectTab", required=false) String selectTab , String popYn){
		OrderDetailSO so = new OrderDetailSO();
		so.setMbrNo(session.getMbrNo());
		so.setGoodsEstmRegYn(FrontConstants.COMM_YN_N);
		List<GoodsCommentVO> bfVOList = goodsCommentService.getMyGoodsComment(so);
		
		
		so.setGoodsEstmRegYn(FrontConstants.COMM_YN_Y);
		List<GoodsCommentVO> aftVOList = goodsCommentService.getMyGoodsComment(so);
		
		if(StringUtil.isNotEmpty(selectTab)) {
			map.put("selectTab", selectTab);
		}

		view.setSeoSvcGbCd(FrontConstants.SEO_SVC_GB_CD_40);
		map.put("bfVOList", bfVOList);
		map.put("aftVOList", aftVOList);
		map.put("session", session);
		map.put("view", view);
		map.put("popYn", popYn);
	return TilesView.mypage(new String[]{"comment", "indexMyCommentView"});
	}

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-31-front
	* - 파일명		: MyCommentController.java
	* - 작성일		: 2021. 3. 11.
	* - 작성자		: pcm
	* - 설명		: 나의 상품 후기 리스트 조회
	* </pre>
	* @param map
	* @param session
	* @param view
	* @return
	*/
	@RequestMapping(value="myCommentList")
	public String myCommentList( ModelMap map, Session session, ViewBase view, String bfAftCheck){
		String path = "";
		OrderDetailSO so = new OrderDetailSO();
		so.setMbrNo(session.getMbrNo());
		log.debug("bfAftCheck:::", bfAftCheck);
		if(bfAftCheck != null && bfAftCheck.equals("bf")) {
			so.setGoodsEstmRegYn(FrontConstants.COMM_YN_N);
			List<GoodsCommentVO> bfVOList = goodsCommentService.getMyGoodsComment(so);
			map.put("bfVOList", bfVOList);
			path = "includeMyBfComment";
		}else if(bfAftCheck != null && bfAftCheck.equals("aft")){
			so.setGoodsEstmRegYn(FrontConstants.COMM_YN_Y);
			List<GoodsCommentVO> aftVOList = goodsCommentService.getMyGoodsComment(so);
			map.put("aftVOList", aftVOList);
			path = "includeMyAftComment";
		}
		
		map.put("session", session);
		map.put("view", view);
	return TilesView.mypage(new String[]{"comment", "include", path});
	}
	
	/**
	* <pre>
	* - 프로젝트명	: gs-apet-31-front
	* - 파일명		: MyCommentController.java
	* - 작성일		: 2021. 3. 11.
	* - 작성자		: pcm
	* - 설명		: 상품 후기 작성
	* </pre>
	* @param map
	* @param view
	* @param session
	* @param so
	* @return
	*/
	@RequestMapping(value="commentWriteView")
	@LoginCheck
	public String commentWriteView(ModelMap map, ViewBase view, Session session, GoodsCommentSO so) {
		so.setEstmMbrNo(session.getMbrNo());
		GoodsBaseVO vo = goodsCommentService.commentWriteInfo(so);
		
		GoodsCommentVO commentVO = new GoodsCommentVO();
		if(so.getGoodsEstmNo() != null && so.getGoodsEstmNo() != 0) {
			so.setSysRegrNo(session.getMbrNo());
			commentVO = goodsCommentService.getGoodsComment(so);
			map.put("commentVO", commentVO);
			
			//펫로그 후기일 경우 작성중인 후기 이어서 작성하기인지 수정하기인지 구분 필요 InheritYn "Y" : 이어하기 "N" : 수정하기
			String InheritYn = "";
			if(goodsCommentService.inheritCheck(so) == 0 && StringUtil.isNotEmpty(commentVO.getGoodsEstmTp()) && commentVO.getGoodsEstmTp().equals(FrontConstants.GOODS_ESTM_TP_PLG)) { 
				InheritYn = CommonConstants.COMM_YN_Y;
			}else {
				InheritYn = CommonConstants.COMM_YN_N;
			}
			map.put("InheritYn", InheritYn);
		}
		
		if(StringUtil.isNotEmpty(commentVO.getPetLogNo())) {
			so.setPetLogNo(commentVO.getPetLogNo());
		}
		
		map.put("vo", vo);
		map.put("gso", so);
		map.put("session", session);
		map.put("view", view);
		return TilesView.mypage(new String[]{"comment", "indexMyCommentWriteView"});
	}

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-31-front
	* - 파일명		: MyCommentController.java
	* - 작성일		: 2021. 3. 11.
	* - 작성자		: pcm
	* - 설명		: 상품 후기 삭제
	* </pre>
	* @param po
	* @param session
	* @return
	*/
//	@LoginCheck
//	@RequestMapping(value="deleteMyComment")
//	@ResponseBody
//	public ModelMap deleteMyComment(GoodsCommentPO po, Session session){
//		// 본인글에대한 삭제만 가능
//		po.setSysRegrNo(session.getMbrNo());
//		this.goodsCommentService.deleteGoodsComment(po);
//		
//		return new ModelMap();
//	}	

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-31-front
	* - 파일명		: GoodsCommentController.java
	* - 작성일		: 2021. 2. 26.
	* - 작성자		: pcm
	* - 설명		: 상품평 등록
	* </pre>
	* @param view
	* @param session
	* @param po
	* @return
	*/
	@LoginCheck
	@RequestMapping(value="insertGoodsComment")
	@ResponseBody
	public ModelMap insertGoodsComment(ViewBase view, Session session, GoodsCommentPO po) {
		ModelMap map = new ModelMap();
		po.setEstmMbrNo(session.getMbrNo());
		po.setSysRegrNo(session.getMbrNo());
		po.setStId(view.getStId());
		
		goodsCommentService.insertGoodsComment(po, view.getDeviceGb());
		
		map.put("goodsEstmNo", po.getGoodsEstmNo());
		map.put("goodsId", po.getGoodsId());
		map.put("view", view);
		return map;
	}

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-31-front
	* - 파일명		: GoodsCommentController.java
	* - 작성일		: 2021. 3. 4.
	* - 작성자		: pcm
	* - 설명		: 상품평 수정
	* </pre>
	* @param view
	* @param session
	* @param po
	* @return
	*/
	@LoginCheck
	@RequestMapping(value="updateGoodsComment")
	@ResponseBody
	public ModelMap updateGoodsComment(ViewBase view, Session session, GoodsCommentPO po) {
		ModelMap map = new ModelMap();
		po.setEstmMbrNo(session.getMbrNo());
		po.setSysRegrNo(session.getMbrNo());
		po.setStId(view.getStId());
		goodsCommentService.updateGoodsComment(po, view.getDeviceGb());

		map.put("goodsEstmNo", po.getGoodsEstmNo());
		map.put("goodsId", po.getGoodsId());
		map.put("view", view);
		return map;
	}
	
	/**
	* <pre>
	* - 프로젝트명	: gs-apet-31-front
	* - 파일명		: MyCommentController.java
	* - 작성일		: 2021. 3. 22.
	* - 작성자		: pcm
	* - 설명		: 모바일 상품 평가 이미지 업로드
	* </pre>
	* @param view
	* @param session
	* @param po
	* @return
	*/
	@LoginCheck
	@RequestMapping(value="appCommentImageUpdate")
	@ResponseBody
	public ModelMap appCommentImageUpdate(ViewBase view, Session session, GoodsCommentPO po) {
		ModelMap map = new ModelMap();
		po.setSysRegrNo(session.getMbrNo());
		goodsCommentService.appCommentImageUpdate(po, view.getDeviceGb());
		
		return map;
	}

}
