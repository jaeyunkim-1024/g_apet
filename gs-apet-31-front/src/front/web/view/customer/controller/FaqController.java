package front.web.view.customer.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import biz.app.counsel.service.CounselService;
import biz.app.display.model.DisplayCornerSO;
import biz.app.display.model.DisplayCornerTotalVO;
import biz.app.system.model.BbsGbSO;
import biz.app.system.model.BbsGbVO;
import biz.app.system.model.BbsLetterSO;
import biz.app.system.model.BbsLetterVO;
import biz.app.system.service.BoardService;
import biz.app.tv.model.TvDetailPO;
import biz.common.service.CacheService;
import framework.common.constants.CommonConstants;
import framework.common.util.DateUtil;
import framework.common.util.StringUtil;
import framework.front.constants.FrontConstants;
import framework.front.model.Session;
import front.web.config.constants.FrontWebConstants;
import front.web.config.tiles.TilesView;
import front.web.config.view.ViewBase;
import front.web.config.view.ViewCustomer;
import lombok.extern.slf4j.Slf4j;


/**
* <pre>
* - 프로젝트명	: 31.front.web
* - 패키지명		: front.web.view.customer.controller
* - 파일명		: FaqController.java
* - 작성일		: 2017. 4. 20.
* - 작성자		: Administrator
* - 설명			: 고객센터 FAQ Controller
* </pre>
*/
@Slf4j
@Controller
@RequestMapping("customer/faq")
public class FaqController {
	@Autowired private CacheService cacheService;
	@Autowired private BoardService boardService;
	@Autowired private CounselService counselService;
	

	/**
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명		: MyCcController.java
	* - 작성일		: 2016. 4. 6.
	* - 작성자		: snw
	* - 설명		: FAQ 목록 화면
	* </pre>
	* @param map
	* @param so
	* @param session
	* @param view
	* @return
	* @throws Exception
	*/
	@RequestMapping(value="indexFaqList")
	public String indexFaqList(ModelMap map, BbsLetterSO so, Session session, ViewBase view){
		
		// 고객센터 메인에서 FAQ글번호 선택으로 인한 진입시, 공지사항목록 default조회를 위한 lettNo null처리
		Long lettNo = so.getLettNo() != null ? so.getLettNo() : null;
		so.setLettNo(null);
		
		List<BbsLetterVO> faqList = null;
		if (so.getBbsGbNo() == null) {
			// 자주하는 질문 TOP10
			so.setRcomYn(FrontWebConstants.COMM_YN_Y);
			faqList = this.boardService.listBbsLetterTop(so);
		}
		else {
			// FAQ 목록
			so.setSidx("lett_no"); //정렬 컬럼 명
			so.setRows(FrontWebConstants.PAGE_ROWS_10); // 한페이지에 데이터 10건씩
			so.setSord(FrontWebConstants.SORD_DESC);
			so.setOpenYn(CommonConstants.COMM_YN_Y);// 공개 여부
			so.setBbsId(FrontConstants.BBS_ID_FAQ);	// 게시판 아이디
			so.setBbsGbNo(so.getBbsGbNo());			// 게시판 구분 코드
			faqList = this.boardService.pageBbsLetter(so);
		}
		map.put("faqList", faqList);
		
		// FAQ카테고리
		BbsGbSO bbsGbSO = new BbsGbSO();
		bbsGbSO.setSidx("bbs_gb_no");
		bbsGbSO.setSord(FrontWebConstants.SORD_ASC);
		bbsGbSO.setBbsId(FrontConstants.BBS_ID_FAQ); // 보안진단 처리 - 주석으로 된 시스템 주요 정보 삭제
		List<BbsGbVO> faqGbList = this.boardService.listBbsGb(bbsGbSO);
		map.put("faqGbList", faqGbList);
		
		// 고객센터 메인에서 FAQ글번호 선택으로 인한 진입시, 공지사항목록 default조회후 선택한 글상세 펼침을 위한 변수 설정
		so.setLettNo(lettNo);
				
		map.put("session", session);
		map.put("view", view);
		map.put("so", so);
		map.put(FrontWebConstants.CUSTOMER_MENU_GB, FrontWebConstants.CUSTOMER_MENU_FAQ);

		return  TilesView.customer(new String[]{"indexFaqList"});
	}
	
	/**
	 * <pre>
	 * - 메소드명	: petTvMainView
	 * - 작성일	: 2020. 06. 09.
	 * - 작성자	: CJA
	 * - 설명		: FAQ 페이지
	 * </pre>
	 * 
	 * @param  session
	 * @param  view
	 * @param  model
	 * @throws Exception 
	 */
	@RequestMapping(value = "faqList", method = RequestMethod.GET)
	public String petTvMainView(ModelMap map, Model model, ViewBase view, Session session) {
		
		view.setSeoSvcGbCd(FrontWebConstants.SEO_SVC_GB_CD_40);
		
		BbsGbSO bbsGbSO = new BbsGbSO();
		
		//faq 구분 리스트
		bbsGbSO.setBbsId(FrontConstants.BBS_ID_FAQ);
		List<BbsGbVO> faqGbList = boardService.listBoardGb(bbsGbSO);
		
		BbsLetterSO so = new BbsLetterSO();
		
		so.setRows(999999);
		so.setBbsId(FrontConstants.BBS_ID_FAQ);
		so.setBbsGbNo("");
		List<BbsLetterVO> faqList = boardService.pageBbsLetter(so);
		
		map.put("faqGbList", faqGbList);
		map.put("faqList", faqList);
		map.put("session", session);
		map.put("view", view);
		
		return TilesView.none(new String[] { "mypage","include", "faq" });
	}
	
	/**
	 * <pre>
	 * - 메소드명	: petTvMainView
	 * - 작성일	: 2020. 06. 09.
	 * - 작성자	: CJA
	 * - 설명		: FAQ 구분값 별 리스트
	 * </pre>
	 * 
	 * @param  session
	 * @param  model
	 * @param  map
	 * @param  po
	 */
	@ResponseBody
	@RequestMapping(value = "faqGbList", method = RequestMethod.POST)
	public ModelMap faqList(ModelMap map, Model model, Session session, ViewBase view, BbsLetterSO so) {
		ModelMap modelmap = new ModelMap();
		 
		if(so.getBbsGbNo().equals("5")) {
			so.setBbsGbNo("");
		}
		
		so.setRows(999999);
		List<BbsLetterVO> faqList = boardService.pageBbsLetter(so);
		
		modelmap.put("faqList", faqList);
		
		return modelmap;
	}
	
	/**
	 * <pre>
	 * - 메소드명	: petTvMainView
	 * - 작성일	: 2020. 06. 09.
	 * - 작성자	: CJA
	 * - 설명		: FAQ 검색 리스트
	 * </pre>
	 * 
	 * @param  session
	 * @param  model
	 * @param  map
	 * @param  po
	 */
	@ResponseBody
	@RequestMapping(value = "searchFaq", method = RequestMethod.POST)
	public ModelMap searchFaq(ModelMap map, Model model, Session session, ViewBase view, BbsLetterSO so) {
		ModelMap modelmap = new ModelMap();
		
		so.setRows(999999);
		so.setBbsId(FrontConstants.BBS_ID_FAQ);
		so.setSearchType("ttl");
		
		List<BbsLetterVO> searchFaq = boardService.pageBbsLetter(so);
		
		modelmap.put("searchFaq", searchFaq);
		
		return modelmap;
	}
	
	
}