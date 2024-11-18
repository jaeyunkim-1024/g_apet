package front.web.view.goods.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import biz.app.goods.model.GoodsInquiryPO;
import biz.app.goods.model.GoodsInquirySO;
import biz.app.goods.model.GoodsInquiryVO;
import biz.app.goods.service.GoodsInquiryService;
import framework.common.annotation.LoginCheck;
import framework.common.constants.CommonConstants;
import framework.common.util.StringUtil;
import framework.front.model.Session;
import front.web.config.constants.FrontWebConstants;
import front.web.config.tiles.TilesView;
import front.web.config.view.ViewBase;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("goods")
public class GoodsQnaController {

	@Autowired private GoodsInquiryService goodsInquiryService;

	@Autowired private Properties webConfig;
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-31-front
	 * - 파일명		: GoodsController.java
	 * - 작성일		: 2021. 2. 16.
	 * - 작성자		: pcm
	 * - 설명		: 상품 qna 리스트 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	@RequestMapping(value="getGoodsInquiryList")
	public String getGoodsInquiryList(ModelMap map, Session session, GoodsInquirySO so) {
		so.setRows(FrontWebConstants.PAGE_ROWS_5);
		List<GoodsInquiryVO> list = new ArrayList<>();
		list = goodsInquiryService.getGoodsInquiryList(so);
		map.put("list", list);
		map.put("session", session);
		map.put("so", so);
		return TilesView.none(new String[]{"goods", "includeNew", "includeGoodsQnaList"});
	}

	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-31-front
	 * - 파일명		: GoodsController.java
	 * - 작성일		: 2021. 2. 18.
	 * - 작성자		: pcm
	 * - 설명		: 상품 qna 등록
	 * </pre>
	 * @param view
	 * @param session
	 * @param po
	 * @return
	 */
	@LoginCheck
	@RequestMapping(value="insertGoodsQna")
	@ResponseBody
	public ModelMap insertGoodsQna(ViewBase view, Session session, GoodsInquiryPO po) {
		ModelMap map = new ModelMap(); 
		po.setEqrrMbrNo(session.getMbrNo());
		po.setSysRegrNo(session.getMbrNo());
		if(StringUtil.isEmpty(po.getHiddenYn())) {
			po.setHiddenYn(CommonConstants.COMM_YN_N);
		}
		po.setStId(Long.valueOf(this.webConfig.getProperty("site.id")));
		goodsInquiryService.insertGoodsInquiry(po, view.getDeviceGb());
		
		map.put("goodsIqrNo", po.getGoodsIqrNo());
		map.put("view", view);
		return map;
	}

	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-31-front
	 * - 파일명		: GoodsController.java
	 * - 작성일		: 2021. 2. 18.
	 * - 작성자		: pcm
	 * - 설명		: 상품 qna 수정
	 * </pre>
	 * @param view
	 * @param session
	 * @param po
	 * @return
	 */
	@LoginCheck
	@RequestMapping(value="updateGoodsQna")
	@ResponseBody
	public ModelMap updateGoodsQna(ViewBase view, Session session, GoodsInquiryPO po) {
		ModelMap map = new ModelMap(); 
		po.setSysRegrNo(session.getMbrNo());
		goodsInquiryService.updateGoodsQna(po, view.getDeviceGb());
		map.put("goodsIqrNo", po.getGoodsIqrNo());
		map.put("view", view);
		return map;
	}

	@LoginCheck
	@RequestMapping(value="appInquiryImageUpdate")
	@ResponseBody
	public ModelMap appInquiryImageUpdate(ViewBase view, Session session, GoodsInquiryPO po) {
		ModelMap map = new ModelMap();
		po.setSysRegrNo(session.getMbrNo());
		goodsInquiryService.appInquiryImageUpdate(po, view.getDeviceGb());
		return map;
	}


	@RequestMapping(value="openGoodsQnaWritePop")
	public String openGoodsQnaWritePop(ModelMap map, ViewBase view, Session session, GoodsInquiryVO vo) {

		map.put("vo", vo);
		map.put("session", session);
		map.put("view", view);
		return TilesView.none(new String[]{"goods", "includeNew", "includeGoodsQnaWritePop"});
	}


}
