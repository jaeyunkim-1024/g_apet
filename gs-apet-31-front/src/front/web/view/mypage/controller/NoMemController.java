package front.web.view.mypage.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import biz.common.service.BizService;
import framework.front.model.Session;
import front.web.config.constants.FrontWebConstants;
import front.web.config.tiles.TilesView;
import front.web.config.view.ViewBase;
import front.web.config.view.ViewMyPage;
import lombok.extern.slf4j.Slf4j;


/**
* <pre>
* - 프로젝트명	: 31.front.web
* - 패키지명	: front.web.view.mypage.controller
* - 파일명		: NoMemController.java
* - 작성일		: 2016. 3. 2.
* - 작성자		: snw
* - 설명		: 비회원메뉴 Controller
* </pre>
*/
@Slf4j
@Controller
@RequestMapping("mypage/nomem")
public class NoMemController {

	@Autowired private BizService bizService;
	
	@Autowired private MessageSourceAccessor message;

	/**
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명		: MyNoMemController.java
	* - 작성일		: 2016. 3. 2.
	* - 작성자		: snw
	* - 설명		: 주문/배송 상세 조회  화면
	* </pre>
	* @param map
	* @param session
	* @param view
	* @param ord_no
	* @return
	* @throws Exception
	*/
	@RequestMapping(value="order/indexDeliveryDetail")
	public String indexDeliveryDetail(ModelMap map, Session session, ViewBase view, @RequestParam String ord_no){

		map.put("session", session);
		map.put("view", view);
		map.put(FrontWebConstants.MYPAGE_MENU_GB, FrontWebConstants.MYPAGE_MENU_NOMEM_ORDER_DELIVERY);

		return  TilesView.mypage(new String[]{"order", "indexDeliveryDetail"});
	}
	

}