package admin.web.view.main.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import admin.web.config.grid.DataGridResponse;
import admin.web.config.grid.GridResponse;
import admin.web.config.view.View;
import biz.admin.service.AdminService;
import biz.app.company.model.CompanyNoticeSO;
import biz.app.company.service.CompanyNoticeService;
import biz.app.counsel.model.CsMainVO;
import biz.app.counsel.service.CounselService;
import biz.app.goods.model.GoodsBaseSO;
import biz.app.goods.model.GoodsBaseVO;
import biz.app.goods.service.GoodsService;
import biz.app.member.model.MemberMainVO;
import biz.app.member.service.MemberService;
import biz.app.promotion.model.ExhibitionSO;
import biz.app.promotion.service.ExhibitionService;
import biz.app.st.model.StStdInfoSO;
import biz.app.st.model.StStdInfoVO;
import biz.app.st.service.StService;
import biz.app.system.model.BbsLetterSO;
import biz.app.system.model.UserBaseSO;
import biz.app.system.model.UserBaseVO;
import biz.app.system.service.BoardService;
import biz.app.system.service.UserService;
import framework.admin.model.Session;
import framework.admin.util.AdminSessionUtil;
import framework.common.constants.CommonConstants;
import framework.common.util.ExcelUtil;
import framework.common.util.FtpFileUtil;
import framework.common.util.FtpImgUtil;
import framework.common.util.StringUtil;
import framework.common.util.image.ImageType;
import lombok.extern.slf4j.Slf4j;


/**
 * <pre>
 * - 프로젝트명	: 41.admin.web
 * - 패키지명	: admin.web.view.main.controller
 * - 파일명		: MainController.java
 * - 작성일		: 2016. 5. 26.
 * - 작성자		: valueFactory
 * - 설명			: 메인 관련 Controller
 * </pre>
 */
@Slf4j
@Controller
public class MainController {

	@Autowired
	private MemberService memberService;

	@Autowired
	private BoardService boardService;

	@Autowired
	private AdminService adminService;

	@Autowired
	private CounselService counselService;

	@Autowired
	private CompanyNoticeService companyNoticeService;

	@Autowired
	private UserService userService;

	@Autowired
	private StService stService;

	@Autowired
	private ExhibitionService exhibitionService;

	@Autowired
	private GoodsService goodsService;

	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: MainController.java
	* - 작성일		: 2017. 5. 26.
	* - 작성자		: Administrator
	* - 설명			: 상담원용 메인 화면
	* </pre>
	* @param model
	* @return
	*/
	@RequestMapping("/main/mainCsView.do")
	public String mainCsView(Model model) {

		return "/main/mainCsView";
	}

	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: MainController.java
	* - 작성일		: 2017. 5. 26.
	* - 작성자		: Administrator
	* - 설명			: 상담원 CTI 화면
	* </pre>
	* @param model
	* @return
	*/
	@RequestMapping("/main/tckView.do")
	public String tck(ModelMap map) {

		UserBaseSO ubso = new UserBaseSO();
		ubso.setArrUsrGbCd(new String[] {CommonConstants.USR_GB_1030, CommonConstants.USR_GB_1031});
		ubso.setUsrStatCd(CommonConstants.USR_STAT_20);
		List<UserBaseVO> userList =  this.userService.getUserList(ubso);

		StStdInfoSO ssiso = new StStdInfoSO();
		List<StStdInfoVO> stList = this.stService.listStStdInfo(ssiso);

		map.put("stList", stList);
		map.put("userList", userList);
		return "/main/tckView";
	}

	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: CounselCcController.java
	* - 작성일		: 2017. 5. 30.
	* - 작성자		: Administrator
	* - 설명			: 콜센터번호에 대한 사이트정보 조회
	* </pre>
	* @param so
	* @return
	*/
	@ResponseBody
	@RequestMapping( value="/main/getSiteCheck.do", method=RequestMethod.POST )
	public ModelMap getSiteCheck( String csTelNo) {

		StStdInfoVO siteInfo = null;

		StStdInfoSO so = new StStdInfoSO();
		so.setCsTelNo(csTelNo.replaceAll("-", ""));
		List<StStdInfoVO> stList = this.stService.listStStdInfo(so);

		ModelMap map = new ModelMap();

		if(CollectionUtils.isNotEmpty(stList) && stList.size() == 1){
			siteInfo = stList.get(0);
		}

		map.put("siteInfo", siteInfo);

		return map;
	}
	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: MainController.java
	* - 작성일		: 2017. 5. 26.
	* - 작성자		: Administrator
	* - 설명			: 일반 메인 화면
	* </pre>
	* @param model
	* @return
	*/
	@RequestMapping("/main/mainView.do")
	public String mainView(Model model) {
		log.debug("================================");
		log.debug("Start : " + "시작 페이지");
		log.debug("================================");

		return "/main/mainView";
	}
	
	/**
	 * - 작성일		: 2019. 12. 22
	 * - 작성자		: jylee
	 * - 설명 		: 임시 메쏘드. 상품 가격 배치 강제 구동. INSERT INTO GOODS_PRICE_INFO_TOTAL
	 */
	@RequestMapping("/main/batchGoodsPriceTotal.do")
	public String batchGoodsPriceTotal(Model model) {
		log.debug("================================");
		log.debug("Start : " + "상품 가격 배치 시작");
		log.debug("================================");

		Integer resultCnt = goodsService.batchGoodsPriceTotal();
		
		log.debug("================================");
		log.debug("Start : " + "상품 가격 배치 끝. 총"+resultCnt);
		log.debug("================================");
		
		model.addAttribute("resultMsg", "상품 가격 배치 끝");
		return "/tmp/tmpPage";
	}

	@RequestMapping("/main/dashBoard.do")
	public String dashBoard(Model model) {

		// CompanyNoticeSO companyNoticeSO = new CompanyNoticeSO();
		// companyNoticeSO.setRows(5);
		// companyNoticeSO.setDispYn(CommonConstants.DISP_YN_Y);
		// BbsLetterSO bonoticeSO = new BbsLetterSO();
		// bonoticeSO.setBbsId("bonotice");
		// bonoticeSO.setRows(5);
		// BbsLetterSO fonoticeSO = new BbsLetterSO();
		// fonoticeSO.setBbsId("fonotice");
		// fonoticeSO.setRows(5);

		// model.addAttribute("goodsList", goodsService.listGoodsMain());
		// model.addAttribute("salesStateList",
		// orderService.listSalesStateMain());
		// model.addAttribute("orderList", orderService.listOrderMain());
		// model.addAttribute("claimList", orderService.listClaimMain());
		// model.addAttribute("csCount", csService.getCsMain());
		// model.addAttribute("memberCount", memberService.getMemberMain());
		// model.addAttribute("companyBbsList",
		// companyNoticeService.pageCompanyNotice(companyNoticeSO));
		// model.addAttribute("bonoticeList",
		// boardService.pageBbsLetter(bonoticeSO));
		// model.addAttribute("fonoticeList",
		// boardService.pageBbsLetter(fonoticeSO));
		List<String[]> imageSizeList = ImageType.GOODS_IMAGE.imageSizeList();
		model.addAttribute("imgType",imageSizeList);
		return "/main/dashBoard";
	}

	@ResponseBody
	@RequestMapping(value = "/main/getDashBoardGoods.do")
	public DataGridResponse getDashBoardGoods() {

		return new DataGridResponse(adminService.listGoodsMain());
	}

	@ResponseBody
	@RequestMapping(value = "/main/getDashBoardGoodsNc.do")
	public DataGridResponse getDashBoardGoodsNc() {

		return new DataGridResponse(adminService.listGoodsMainNc());
	}

	@ResponseBody
	@RequestMapping(value = "/main/getDashBoardSales.do")
	public DataGridResponse getDashBoardSales() {

		return new DataGridResponse(adminService.listSalesStateMain());
	}

	@ResponseBody
	@RequestMapping(value = "/main/getDashBoardOrders.do")
	public DataGridResponse getDashBoardOrders() {

		return new DataGridResponse(adminService.listOrderMain());
	}

	@ResponseBody
	@RequestMapping(value = "/main/getDashBoardOrdNc.do")
	public DataGridResponse getDashBoardOrdNc() {

		return new DataGridResponse(adminService.listOrderMainNc());
	}

	@ResponseBody
	@RequestMapping(value = "/main/getDashBoardClaims.do")
	public DataGridResponse getDashBoardClaims() {

		return new DataGridResponse(adminService.listClaimMain());
	}

	@ResponseBody
	@RequestMapping(value = "/main/getDashBoardClaimsNc.do")
	public DataGridResponse getDashBoardClaimsNc() {

		return new DataGridResponse(adminService.listClaimMainNc());
	}

	@ResponseBody
	@RequestMapping(value = "/main/getDashBoardCS.do")
	public DataGridResponse getDashBoardCS() {

		ArrayList<CsMainVO> rows = new ArrayList<>();
		rows.add(counselService.getCsMain());
		return new DataGridResponse(rows);
	}

	@ResponseBody
	@RequestMapping(value = "/main/getDashBoardMembers.do")
	public DataGridResponse getDashBoardMembers() {

		ArrayList<MemberMainVO> rows = new ArrayList<>();
		rows.add(memberService.getMemberMain());
		return new DataGridResponse(rows);
	}

	@ResponseBody
	@RequestMapping(value = "/main/getDashBoardComNotice.do")
	public DataGridResponse getDashBoardComNotice() {

		CompanyNoticeSO companyNoticeSO = new CompanyNoticeSO();
		companyNoticeSO.setRows(5);
		companyNoticeSO.setDispYn(CommonConstants.DISP_YN_Y);

		Session session = AdminSessionUtil.getSession();
		if (StringUtils.equals(CommonConstants.USR_GRP_20, session.getUsrGrpCd())) {
			// 업체의 공지사항만 보면 됨
			companyNoticeSO.setCompNo(session.getCompNo());
		}

		return new DataGridResponse(companyNoticeService.pageCompanyNotice(companyNoticeSO));
	}

	@ResponseBody
	@RequestMapping(value = "/main/getDashBoardBoNotice.do")
	public DataGridResponse getDashBoardBoNotice() {

		BbsLetterSO bonoticeSO = new BbsLetterSO();
		bonoticeSO.setBbsId("bonotice");
		bonoticeSO.setRows(5);
		return new DataGridResponse(boardService.pageBbsLetter(bonoticeSO));
	}

	@ResponseBody
	@RequestMapping(value = "/main/getDashBoardFoNotice.do")
	public DataGridResponse getDashBoardFoNotice() {

		BbsLetterSO fonoticeSO = new BbsLetterSO();
		fonoticeSO.setBbsId("fonotice");
		fonoticeSO.setRows(5);
		return new DataGridResponse(boardService.pageBbsLetter(fonoticeSO));
	}

	@ResponseBody
	@RequestMapping(value = "/main/getDashBoardCpNotice.do")
	public DataGridResponse getDashBoardCpNotice() {

		BbsLetterSO fonoticeSO = new BbsLetterSO();
		fonoticeSO.setBbsId("cpnotice");
		fonoticeSO.setRows(5);
		return new DataGridResponse(boardService.pageBbsLetter(fonoticeSO));
	}

	@ResponseBody
	@RequestMapping(value = "/main/getDashExhibition.do")
	public DataGridResponse getDashExhibition() {
		ExhibitionSO so = new ExhibitionSO();
		Session session = AdminSessionUtil.getSession();

		if (StringUtils.equalsIgnoreCase(CommonConstants.USR_GB_1020, session.getUsrGbCd())) {
			so.setMdUsrNo(session.getUsrNo());
		}

		return new DataGridResponse(exhibitionService.listExhibitionMainNc(so));
	}

	@RequestMapping("/main/test.do")
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public String test(@RequestParam("json") String json, @RequestParam("json2") String json2, @RequestParam("json3") String json3) {

//		BomBasePO po = (BomBasePO)jsonUt.toBean(BomBasePO.class ,json);
//		BomBaseVO p2 = (BomBaseVO)jsonUt.toBean(BomBaseVO.class ,json2);

//		List<BomBaseVO> list = jsonUt.toArray(BomBaseVO.class ,json3);
//		LogUtil.log(po);
//		LogUtil.log(p2);
//
//		for(BomBaseVO vo : list) {
//			LogUtil.log(vo);
//		}

		return View.jsonView();
	}

	@RequestMapping("/main/testPop.do")
	public String testPop(Model model) {
		log.debug("================================");
		log.debug("Start : " + "시작 페이지");
		log.debug("================================");
		return "/main/testPop";
	}

	@RequestMapping("/main/fileImgTest.do")
	public String fileImgTest(Model model, @RequestParam("filePath") String filePath, @RequestParam("fileName") String fileName) {
		FtpImgUtil ftpImgUtil = new FtpImgUtil();
		ftpImgUtil.upload(filePath, ftpImgUtil.uploadFilePath(filePath, "/test/test"));

		return View.jsonView();
	}

	@RequestMapping("/main/fileTest.do")
	public String fileTest(Model model, @RequestParam("filePath") String filePath, @RequestParam("fileName") String fileName) {
		FtpFileUtil ftpFileUtil = new FtpFileUtil();
		ftpFileUtil.upload(filePath, ftpFileUtil.uploadFilePath(filePath, "/test/test"));
		model.addAttribute("filePath", ftpFileUtil.uploadFilePath(filePath, "/test/test"));
		return View.jsonView();
	}


	@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping(value="/main/excelGrid.do", method=RequestMethod.POST)
	public GridResponse excelGrid (Model model
			, @RequestParam("filePath") String filePath
			, @RequestParam("fileName") String fileName
			, @RequestParam("colName") String[] colNames ) {

		GoodsBaseSO so = new GoodsBaseSO();
		log.debug("########## filePath : " + filePath );
		log.debug("########## fileName : " + fileName );
		log.debug("########## colNames : " + Arrays.toString(colNames) );

		for(int i = 0; i < colNames.length; i++ ) {
			log.debug("##### : " + colNames [i]);
		}

		int skipHeadCount = 1;
		List<GoodsBaseVO> goodsBaseVOList = null;

		if(!StringUtil.isEmpty(filePath) ) {
			File excelFile = new File(filePath);// 파싱할 Excel File

			try {
				goodsBaseVOList = ExcelUtil.parse(excelFile, GoodsBaseVO.class, colNames, skipHeadCount );
			} catch (Exception e) {
				log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
			}

			// 읽은 파일 삭제
			if(!excelFile.delete()) {
				log.error("Fail to delete of file. MainController.excelGrid::excelFile.delete {}");
			}
		
		}

		return new GridResponse(goodsBaseVOList, so );
	}
	
	
	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: MainController.java
	* - 작성일		: 2018. 01. 08.
	* - 작성자		: Administrator
	* - 설명		: Tab 메인 화면
	* </pre>
	* @param model
	* @return
	*/
	@RequestMapping("/adminView.do")
	public String adminView(Model model) {
		return "/main/adminView";
	}

}