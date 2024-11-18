package front.web.view.mypage.controller;

import java.sql.Timestamp;
import java.util.List;

import javax.servlet.http.Cookie;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import biz.app.goods.model.GoodsBaseVO;
import biz.app.goods.model.GoodsDtlInqrHistPO;
import biz.app.goods.model.GoodsDtlInqrHistSO;
import biz.app.goods.service.GoodsDtlInqrHistService;
import biz.app.login.service.FrontLoginService;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import framework.common.util.CookieSessionUtil;
import framework.front.constants.FrontConstants;
import framework.front.model.Session;
import front.web.config.constants.FrontWebConstants;
import front.web.config.tiles.TilesView;
import front.web.config.view.ViewBase;
import lombok.extern.slf4j.Slf4j;


/**
* <pre>
* - 프로젝트명	: gs-apet-31-front
* - 패키지명 	: front.web.view.mypage.controller
* - 파일명 	: MyRecentGoodsController.java
* - 작성일	: 2021. 3. 10.
* - 작성자	: valfac
* - 설명 		: 나의 최근본 상품
* </pre>
*/
@Slf4j
@Controller
@RequestMapping("mypage")
public class MyRecentGoodsController {

	@Autowired private GoodsDtlInqrHistService goodsDtlInqrHistService;
	@Autowired private FrontLoginService frontLoginService;
	/**
	* <pre>
	* - 프로젝트명	: gs-apet-31-front
	* - 파일명	: MyPageController.java
	* - 작성일	: 2021. 3. 10.
	* - 작성자 	: valfac
	* - 설명 		: 최근본 상품
	* </pre>
	*
	* @param map
	* @param view
	* @param session
	* @return
	*/
	@RequestMapping(value = "indexRecentViews", method = RequestMethod.GET)
	public String indexRecentViews(ModelMap map, ViewBase view, Session session) {
		List<GoodsBaseVO> goodsDtlHistList = null;
		GoodsDtlInqrHistSO dtlHistSO = new GoodsDtlInqrHistSO();
		dtlHistSO.setWebMobileGbCd(view.getSvcGbCd());
		dtlHistSO.setRows(50);
		if(!session.getMbrNo().equals(CommonConstants.NO_MEMBER_NO) ) {		// DB 조회
			dtlHistSO.setMbrNo(session.getMbrNo());
			goodsDtlHistList = goodsDtlInqrHistService.listGoodsDtlInqrHist(dtlHistSO);
		}else {																// 쿠키 조회
			List<GoodsBaseVO> listCookie = frontLoginService.getRcntGoodsFromCookie();
			if(listCookie != null) {
				dtlHistSO.setCookieYn(CommonConstants.COMM_YN_Y);
				String[] goodsIds = new String[listCookie.size()];
				Timestamp  nowDtm = new Timestamp(System.currentTimeMillis());
				for(int i = 0 ; i < listCookie.size() ; i++) {
					//24시간 이내 상품만 추가
					long dif = nowDtm.getTime() - listCookie.get(i).getSysRegDtm().getTime();
					if(dif < 24*60*60*1000) {
						goodsIds[i] = listCookie.get(i).getGoodsId();
					}
				}
				dtlHistSO.setGoodsIds(goodsIds);
				if(goodsIds.length > 0) {
					goodsDtlHistList = goodsDtlInqrHistService.listGoodsDtlInqrHist(dtlHistSO);
				}
			}
		}
		view.setSeoSvcGbCd(FrontConstants.SEO_SVC_GB_CD_40);
		
		map.put("goodsDtlHistList", goodsDtlHistList);
		map.put("session", session);
		map.put("view", view);
		
		return TilesView.none(new String[] { "mypage", "goods", "indexRecentViews" });
	}
	
	/**
	* <pre>
	* - 프로젝트명	: gs-apet-31-front
	* - 파일명	: MyRecentGoodsController.java
	* - 작성일	: 2021. 3. 10.
	* - 작성자 	: valfac
	* - 설명 		: 최근 본 상품 삭제
	* </pre>
	*
	* @param map
	* @param session
	* @param view
	* @param so
	* @return
	*/
	@RequestMapping(value="deleteRecentGoods")
	@ResponseBody
	public ModelMap deleteRecentGoods(Session session, ViewBase view, GoodsDtlInqrHistPO po) {
		ModelMap map = new ModelMap();
		po.setMbrNo(session.getMbrNo());
		map.put("resultCnt", goodsDtlInqrHistService.deleteGoodsDtlInqrHist(po));
		return map;
	}
}