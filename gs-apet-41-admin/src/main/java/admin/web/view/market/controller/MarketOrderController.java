package admin.web.view.market.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import admin.web.config.grid.GridResponse;
import admin.web.config.view.View;
import biz.app.market.model.MarketOrderConfirmPO;
import biz.app.market.model.MarketOrderListSO;
import biz.app.market.model.MarketOrderListVO;
import biz.app.market.service.MarketOrderService;
import biz.app.st.model.StStdInfoSO;
import framework.admin.constants.AdminConstants;
import framework.admin.model.Session;
import framework.admin.util.AdminSessionUtil;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import framework.common.util.DateUtil;
import lombok.extern.slf4j.Slf4j;

/**
* <pre>
* - 프로젝트명	: 41.admin.web
* - 패키지명		: admin.web.view.market.controller
* - 파일명		: MarketOrderController.java
* - 작성일		: 2017. 9. 21.
* - 작성자		: kimdp
* - 설명			: 오픈마켓 주문 Controller
* </pre>
*/
@Slf4j
@Controller
public class MarketOrderController {
	
	@Autowired	private MarketOrderService marketOrderService;
	
	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: MarketOrderController.java
	* - 작성일		: 2017. 9. 21.
	* - 작성자		: kimdp
	* - 설명			: 오픈마켓 주문 목록 조회 화면
	* </pre>
	* @param orderSO
	* @param br
	* @return
	*/
	@RequestMapping("/market/marketOrderListView.do")
	public String orderListView(ModelMap map) {

		/****************************
		 * 세션 정보
		 ****************************/
		Session session = AdminSessionUtil.getSession();
		map.put("session", session);
		
		/***********************
		 * 사이트 정보 조회
		 *************************/
		StStdInfoSO ssiso = new StStdInfoSO();

		/*
		 * 사용자 그룹이 업체사용자일 경우 업체 계약된 사이트 정보만 노출
		 */
		if(!AdminConstants.USR_GRP_10.equals(session.getUsrGrpCd()) ) {
			ssiso.setCompNo(session.getCompNo());
		}

		String marketSrchEndDtm = DateUtil.getNowDate();
		String marketSrchStartDtm = DateUtil.addDay("yyyyMMdd", -7);		
		
		String srchEndDtm = DateUtil.getNowDate();
		String srchStartDtm = DateUtil.addDay("yyyyMMdd", -7);

		map.put("marketSrchStartDtm", marketSrchStartDtm);
		map.put("marketSrchEndDtm", marketSrchEndDtm);
		
		map.put("srchStartDtm", srchStartDtm);
		map.put("srchEndDtm", srchEndDtm);

		return "/market/marketOrderListView";

	}
	
	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: MarketOrderController.java
	* - 작성일		: 2017. 9. 21.
	* - 작성자		: kimdp
	* - 설명			: 오픈마켓 주문 목록 조회(그리드)
	* </pre>
	* @param so
	* @return
	*/
	@ResponseBody
	@RequestMapping( value="/market/orderListGrid.do", method=RequestMethod.POST )
	public GridResponse orderListGrid(MarketOrderListSO so){
		List<MarketOrderListVO> list = marketOrderService.pageMarketOrderOrg( so );
		return new GridResponse( list, so );
	}	
	
	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명	: MarketOrderController.java
	* - 작성일	: 2017. 9. 27.
	* - 작성자	: schoi
	* - 설명		: Outbound API 주문 등록
	* </pre>
	* @param marketOrderConfirmPO
	* @return
	*/
	@RequestMapping("/market/marketOrderConfirm.do")
	public String marketOrderConfirm(Model model, MarketOrderConfirmPO marketOrderConfirmPO, BindingResult br) {
		if ( br.hasErrors() ) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		marketOrderService.insertMarketOrderConfirm(marketOrderConfirmPO);
		return View.jsonView();
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명	: MarketOrderController.java
	* - 작성일	: 2017. 10. 23.
	* - 작성자	: schoi
	* - 설명		: Outbound API 주문 수집
	* </pre>
	* @param String startDtm, String endDtm
	* @return
	*/
	@RequestMapping("/market/marketGetOrder.do")
	public String marketGetOrder(String startDtm, String endDtm) {
		marketOrderService.marketGetOrder(startDtm, endDtm);
		return View.jsonView();
	}

}
