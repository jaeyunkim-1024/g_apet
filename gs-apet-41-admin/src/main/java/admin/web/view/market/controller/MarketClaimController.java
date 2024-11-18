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
import biz.app.market.model.MarketClaimListSO;
import biz.app.market.model.MarketClaimListVO;
import biz.app.market.model.MarketClaimConfirmPO;
import biz.app.market.service.MarketClaimService;
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
* - 파일명		: marketClaimController.java
* - 작성일		: 2017. 9. 21.
* - 작성자		: kimdp
* - 설명			: 오픈마켓 클레임 Controller
* </pre>
*/
@Slf4j
@Controller
public class MarketClaimController {
	
	@Autowired	private MarketClaimService marketClaimService;
	
	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: marketClaimController.java
	* - 작성일		: 2017. 9. 21.
	* - 작성자		: kimdp
	* - 설명			: 오픈마켓 클레임(취소) 목록 조회 화면
	* </pre>
	* @param orderSO
	* @param br
	* @return
	*/
	@RequestMapping("/market/marketClaimCancelListView.do")
	public String claimCancelListView(ModelMap map) {

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

		return "/market/marketClaimCancelListView";

	}
	
	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: marketClaimController.java
	* - 작성일		: 2017. 9. 21.
	* - 작성자		: kimdp
	* - 설명			: 오픈마켓 클레임(취소) 목록 조회(그리드)
	* </pre>
	* @param so
	* @return
	*/
	@ResponseBody
	@RequestMapping( value="/market/claimCancelListGrid.do", method=RequestMethod.POST )
	public GridResponse claimCancelListGrid(MarketClaimListSO so){
		so.setClmCd("10");
		List<MarketClaimListVO> list = marketClaimService.pageMarketClaimOrg( so );
		return new GridResponse( list, so );
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명	: MarketClaimController.java
	* - 작성일	: 2017. 10. 17.
	* - 작성자	: schoi
	* - 설명		: Outbound API 클레임 취소
	* </pre>
	* @param marketCancelConfirmPO
	* @return
	*/
	@RequestMapping("/market/marketClaimCancelConfirm.do")
	public String marketClaimCancelConfirm(Model model, MarketClaimConfirmPO marketClaimConfirmPO, BindingResult br) {
		if ( br.hasErrors() ) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		marketClaimService.insertMarketClaimCancelConfirm(marketClaimConfirmPO);
		return View.jsonView();
	}

	
	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: marketClaimController.java
	* - 작성일		: 2017. 9. 21.
	* - 작성자		: kimdp
	* - 설명			: 오픈마켓 클레임(반품) 목록 조회 화면
	* </pre>
	* @param orderSO
	* @param br
	* @return
	*/
	@RequestMapping("/market/marketClaimReturnListView.do")
	public String claimReturnListView(ModelMap map) {

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

		return "/market/marketClaimReturnListView";

	}
	
	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: marketClaimController.java
	* - 작성일		: 2017. 9. 21.
	* - 작성자		: kimdp
	* - 설명			: 오픈마켓 클레임(반품) 목록 조회(그리드)
	* </pre>
	* @param so
	* @return
	*/
	@ResponseBody
	@RequestMapping( value="/market/claimReturnListGrid.do", method=RequestMethod.POST )
	public GridResponse claimReturnListGrid(MarketClaimListSO so){
		so.setClmCd("20");
		List<MarketClaimListVO> list = marketClaimService.pageMarketClaimOrg( so );
		return new GridResponse( list, so );
	}	
	
	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: marketClaimController.java
	* - 작성일		: 2017. 9. 21.
	* - 작성자		: kimdp
	* - 설명			: 오픈마켓 클레임(교환) 목록 조회 화면
	* </pre>
	* @param orderSO
	* @param br
	* @return
	*/
	@RequestMapping("/market/marketClaimExchangeListView.do")
	public String claimExchangeListView(ModelMap map) {

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

		return "/market/marketClaimExchangeListView";

	}
	
	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: marketClaimController.java
	* - 작성일		: 2017. 9. 21.
	* - 작성자		: kimdp
	* - 설명			: 오픈마켓 클레임(교환) 목록 조회(그리드)
	* </pre>
	* @param so
	* @return
	*/
	@ResponseBody
	@RequestMapping( value="/market/claimExchangeListGrid.do", method=RequestMethod.POST )
	public GridResponse claimExchangeListGrid(MarketClaimListSO so){
		so.setClmCd("30");
		List<MarketClaimListVO> list = marketClaimService.pageMarketClaimOrg( so );
		return new GridResponse( list, so );
	}	
	
	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명	: MarketOrderController.java
	* - 작성일	: 2017. 10. 23.
	* - 작성자	: schoi
	* - 설명		: Outbound API 클레임 취소 수집
	* </pre>
	* @param String startDtm, String endDtm
	* @return
	*/
	@RequestMapping("/market/marketGetClaimCancel.do") 
	public String marketGetClaimCancel(String startDtm, String endDtm) {
		marketClaimService.marketGetClaimCancel(startDtm, endDtm);
		return View.jsonView();
	}
}
