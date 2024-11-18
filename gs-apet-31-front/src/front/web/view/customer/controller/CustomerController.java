package front.web.view.customer.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import biz.app.system.model.BbsLetterSO;
import biz.app.system.model.BbsLetterVO;
import biz.app.system.service.BoardService;
import framework.common.constants.CommonConstants;
import framework.front.constants.FrontConstants;
import framework.front.model.Session;
import front.web.config.constants.FrontWebConstants;
import front.web.config.tiles.TilesView;
import front.web.config.view.ViewBase;
import front.web.config.view.ViewCustomer;
import front.web.config.view.ViewPopup;
import lombok.extern.slf4j.Slf4j;

/**
* <pre>
* - 프로젝트명	: 31.front.web
* - 패키지명		: front.web.view.customer.controller
* - 파일명		: CustomerController.java
* - 작성일		: 2017. 4. 20.
* - 작성자		: Administrator
* - 설명			: 고객센터 Controller
* </pre>
*/
@Slf4j
@Controller
@RequestMapping("customer")
public class CustomerController {

	@Autowired private BoardService boardService;
	@Autowired private MessageSourceAccessor message;
	
	/**
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명		: CustomerController.java
	* - 작성일		: 2017. 4. 20.
	* - 작성자		: Administrator
	* - 설명		: 고객센터 메인 화면
	* </pre>
	* @param map
	* @param session
	* @param view
	* @return
	*/
	@RequestMapping(value="indexCustomer")
	public String indexCustomer(ModelMap map, Session session, ViewBase view){

		BbsLetterSO so = new BbsLetterSO();
		
		// FAQ 자주하는 질문 TOP10
		so.setRcomYn(FrontWebConstants.COMM_YN_Y);
		List<BbsLetterVO> faqTopList = this.boardService.listBbsLetterTop(so);
		map.put("faqTopList", faqTopList);
		
		// 공지사항 목록
		so.setRows(FrontWebConstants.PAGE_ROWS_10);
		so.setSord(FrontWebConstants.SORD_DESC);
		so.setSidx("lett_no"); //정렬 컬럼 명
		so.setOpenYn(CommonConstants.COMM_YN_Y);
		so.setBbsId(FrontConstants.BBS_ID_NOTICE);
		List<BbsLetterVO> noticeList = this.boardService.pageBbsLetter(so);
		map.put("noticeList", noticeList);
		
		map.put("session", session);
		map.put("view", view);
		
		return TilesView.customer(new String[]{"indexCustomer"});
	}

	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 33.front.brand.web
	 * - 파일명		: CustomerController.java
	 * - 작성일		: 2017. 08. 01.
	 * - 작성자		: wyjeong
	 * - 설명		: 고객서비스 정책 팝업 
	 * </pre>
	 * @param map
	 * @param view
	 * @return
	 */
	@RequestMapping(value = "popupCsInfo")
	public String popupCsInfo(ModelMap map, ViewBase view) {

		view.setTitle(message.getMessage("front.web.view.customer.cs.info.popup.title"));
		map.put("view", view);
		
		return TilesView.popup(new String[] { "customer", "popupCsInfo" });
	}
}