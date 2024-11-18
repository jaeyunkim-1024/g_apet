package front.web.view.customer.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import biz.app.counsel.model.CounselPO;
import biz.app.counsel.model.CounselSO;
import biz.app.counsel.model.CounselVO;
import biz.app.counsel.service.CounselService;
import biz.app.goods.model.GoodsInquirySO;
import biz.app.goods.model.GoodsInquiryVO;
import biz.app.goods.service.GoodsInquiryService;
import biz.app.member.model.MemberBaseSO;
import biz.app.member.model.MemberBaseVO;
import biz.app.member.service.MemberService;
import biz.app.system.model.CodeDetailVO;
import biz.common.service.BizService;
import biz.common.service.CacheService;
import framework.common.annotation.LoginCheck;
import framework.common.constants.CommonConstants;
import framework.common.util.DateUtil;
import framework.common.util.StringUtil;
import framework.front.constants.FrontConstants;
import framework.front.model.Session;
import front.web.config.constants.FrontWebConstants;
import front.web.config.page.Paging;
import front.web.config.tiles.TilesView;
import front.web.config.view.ViewBase;
import lombok.extern.slf4j.Slf4j;



@Slf4j
@Controller
@RequestMapping("customer/inquiry")
public class InquiryController {
	@Autowired private CacheService cacheService;
	@Autowired private CounselService counselService;
	@Autowired private GoodsInquiryService goodsInquiryService;
	@Autowired private MemberService memberService;
	@Autowired private Properties webConfig;
	@Autowired private BizService bizService;

	
	/**
	* <pre>
	* - 프로젝트명		: 31.front.web
	* - 패키지명		: front.web.view.customer.controller
	* - 파일명		: InquiryController.java
	* - 작성일		: 2017. 4. 20.
	* - 작성자		: Administrator
	* - 설명			: 고객센터 1:1문의 목록 Controller
	* </pre>
	*/
	@RequestMapping(value="indexInquiryList")
	public String indexInquiryList(ModelMap map, Session session, ViewBase view, CounselSO so){

		so.setStId(view.getStId());
		so.setSidx("cusNo");
		so.setSord(FrontWebConstants.SORD_DESC);
		so.setRows(FrontWebConstants.PAGE_ROWS_10);
		so.setCusPathCd(CommonConstants.CUS_PATH_10);
		if (StringUtil.isEmpty(so.getPeriod())) {
			so.setPeriod(1L);
		}

		// 날짜 조회 param 설정
		so.setCusAcptDtmStart(DateUtil.convertSearchDate("S", so.getCusAcptDtmStart()));
		so.setCusAcptDtmEnd(DateUtil.convertSearchDate("E", so.getCusAcptDtmEnd()));

		List<CounselVO> counselList = counselService.pageCounsel(so);

		map.put("counselList", counselList);
		map.put("paging", new Paging(so));
		map.put(FrontWebConstants.MYPAGE_MENU_GB, FrontWebConstants.MYPAGE_MENU_INQUIRY_ANSWER);
		// 상담 카테고리1 코드(문의유형) 취득
		map.put("cusCtg1CdList", this.cacheService.listCodeCache(CommonConstants.CUS_CTG1, CommonConstants.COMM_YN_N, null, null, null, null));
		// 상담 상태 코드 취득
		map.put("cusStatCdList", this.cacheService.listCodeCache(CommonConstants.CUS_STAT, null, null, null, null, null));

		map.put("session", session);
		map.put("view", view);
		map.put(FrontWebConstants.CUSTOMER_MENU_GB, FrontWebConstants.CUSTOMER_MENU_INQUIRY);

		return  TilesView.customer(new String[]{"indexInquiryList"});
	}
	
	
	/**
	* <pre>
	* - 프로젝트명		: 31.front.web
	* - 파일명		: InquiryController.java
	* - 작성일		: 2016. 3. 2.
	* - 작성자		: snw
	* - 설명			: 문의하기  화면
	* </pre>
	* @param map
	* @param session
	* @param view
	* @return
	* @throws Exception
	*/
	@LoginCheck
	@RequestMapping(value="indexRequest")
	public String indexRequest(ModelMap map, Session session, ViewBase view) {

		Long memNo = session.getMbrNo();
		
		MemberBaseSO so = new MemberBaseSO();
		so.setMbrNo(memNo);

		MemberBaseVO member = this.memberService.getMemberBase(so);
		if (member.getEmail() != null && !member.getEmail().isEmpty()) {
			String[] emailInfo = member.getEmail().split("@");
			member.setEmailId(emailInfo[0]);
			member.setEmailAddr(emailInfo[1]);
		}
		map.put("member", member); // 회원정보 취득
		map.put("session", session);
		map.put("view", view);
		map.put(FrontWebConstants.CUSTOMER_MENU_GB, FrontWebConstants.CUSTOMER_MENU_INQUIRY);
		
		// 문의유형 취득  (기타:130 제외)
		List<CodeDetailVO> cusCodeCache = this.cacheService.listCodeCache(CommonConstants.CUS_CTG1, "N", null, null, null, null);
		List<CodeDetailVO> cusCtg1CdList = new ArrayList<>();
		
		for(CodeDetailVO temp : cusCodeCache) {
			
			CodeDetailVO tempVO = new CodeDetailVO();
			
			if(!CommonConstants.CUS_CTG1_70.equals(temp.getDtlCd())) {
				
				tempVO.setDtlCd(temp.getDtlCd());
				tempVO.setDtlNm(temp.getDtlNm());
				tempVO.setUsrDfn1Val(temp.getUsrDfn1Val());
				tempVO.setUsrDfn2Val(temp.getUsrDfn2Val());
				
				cusCtg1CdList.add(tempVO);
				
			}
		}
		
		map.put("cusCtg1CdList", cusCtg1CdList);
		
		
		// 이메일 도메인 취득
		map.put("emailAddrCdList", this.cacheService.listCodeCache(CommonConstants.EMAIL_ADDR, null, null, null, null, null));

		return TilesView.customer(new String[] {"indexRequest"});
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명	: InquiryController.java
	* - 작성일	: 2016. 4. 7.
	* - 작성자	: jangjy
	* - 설명		: 1:1 문의하기 등록
	* </pre>
	* @param po
	* @param emailId
	* @param emailAddr
	* @param session
	* @return
	* @throws Exception
	*/
	@RequestMapping(value="insertInquiry", method=RequestMethod.POST)
	@ResponseBody
	public ModelMap insertInquiry(CounselPO po, String emailId, String emailAddr, Session session, ViewBase view) {

		po.setEqrrEmail(emailId + "@" + emailAddr);
		po.setEqrrMbrNo(session.getMbrNo());
		po.setStId(Long.valueOf(webConfig.getProperty("site.id")));
		
		
		this.counselService.insertCounselWeb(po, view.getDeviceGb());

		return new ModelMap();
	}
	
	/**
	 * <pre>
	 * - 메소드명	: petTvMainView
	 * - 작성일	: 2020. 06. 09.
	 * - 작성자	: CJA
	 * - 설명		: 마이 찜리스트 화면
	 * </pre>
	 * 
	 * @param  session
	 * @param  view
	 * @param  model
	 */
	@LoginCheck
	@RequestMapping(value = "/inquiryView", method = RequestMethod.GET)
	public String inquiryView(ModelMap map, Model model, ViewBase view, Session session, CounselSO so
			, @RequestParam(value="popupChk", required=false) String popupChk , String insertYn, String viewGb, String focusNo) {
		// 랜딩 url -> focus APET-1263
		viewGb = (StringUtil.isEmpty(viewGb)) ? "inquiry" : viewGb;
		focusNo = (StringUtil.isEmpty(focusNo)) ? null : focusNo;
		
		so.setMbrNo(session.getMbrNo());
		so.setStId(view.getStId());
		so.setCusPathCd(CommonConstants.CUS_PATH_10);
		so.setRows(999999);
		so.setSidx("SYS_REG_DTM");
		so.setSord("DESC");
		// 1:1 문의
		List<CounselVO> counselList = counselService.getCounselListFO(so);
		
		// 상품 Q&A
		GoodsInquirySO giSo = new GoodsInquirySO();
		giSo.setEqrrMbrNo(session.getMbrNo());
		List<GoodsInquiryVO> myQnaList = goodsInquiryService.getGoodsInquiryList(giSo);
		
		view.setSeoSvcGbCd(FrontConstants.SEO_SVC_GB_CD_40);
		model.addAttribute("popupChk", popupChk);		
		model.addAttribute("counselList", counselList);
		model.addAttribute("myQnaList", myQnaList);
		model.addAttribute("session", session);
		model.addAttribute("view", view);
		model.addAttribute("insertYn" , insertYn);
		model.addAttribute("viewGb" , viewGb);
		model.addAttribute("focusNo" , focusNo);
		
		return TilesView.none(new String[] { "mypage","inquiry", "inquiryView" });
	}
	
	@RequestMapping(value="inquiryViewPop")
	public String openInquiryWritePop(ModelMap map, ViewBase view, Session session, CounselVO vo) {
		List<CodeDetailVO> ctgList = cacheService.listCodeCache(CommonConstants.CUS_CTG1, true,	null, null, null, null, null);
		map.put("ctgList", ctgList);
		map.put("vo", vo);
		map.put("session", session);
		map.put("view", view);
		return TilesView.none(new String[] { "mypage","inquiry", "inquiryViewPop" });
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명	: InquiryController.java
	* - 작성일	: 2016. 4. 7.
	* - 작성자	: jangjy
	* - 설명		: 1:1 문의하기 등록
	* </pre>
	* @param po
	* @param emailId
	* @param emailAddr
	* @param session
	* @return
	* @throws Exception
	*/
	@RequestMapping(value="inquiryInsert", method=RequestMethod.POST)
	@ResponseBody
	public ModelMap inquiryInsert(CounselPO po, Session session, ViewBase view) {
		ModelMap map = new ModelMap();
		MemberBaseSO so = new MemberBaseSO();
		so.setMbrNo(session.getMbrNo());

		MemberBaseVO member = this.memberService.getMemberBase(so);
		
		po.setEqrrNm(session.getMbrNm());
		po.setEqrrEmail(bizService.twoWayDecrypt(member.getEmail()));
		po.setEqrrMobile(bizService.twoWayDecrypt(member.getMobile()));
		po.setEqrrMbrNo(session.getMbrNo());
		po.setEqrrTel(member.getTel());
		po.setStId(Long.valueOf(webConfig.getProperty("site.id")));

		if(StringUtil.isEmpty(po.getCusNo())) {
			this.counselService.insertInquiry(po, view.getDeviceGb());
		}
		else {
			this.counselService.updateInquiry(po, view.getDeviceGb());
		}

		map.addAttribute("cusNo", po.getCusNo());
		map.addAttribute("flNo", po.getFlNo());
		
		return map;
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명	: MyInquiryController.java
	* - 작성일	: 2016. 4. 7.
	* - 작성자	: jangjy
	* - 설명		: 1:1 문의하기 APP용 이미지 업로드
	* </pre>
	* @param po
	* @param session
	* @return
	* @throws Exception
	*/
	@RequestMapping(value="inquiryAppImgUpload", method=RequestMethod.POST)
	@ResponseBody
	public ModelMap inquiryAppImgUpload(CounselPO po) {

		ModelMap modelMap = new ModelMap();
		
		Long flNo = this.counselService.inquiryAppImgUpload(po);
		modelMap.addAttribute("flNo", flNo);
		return modelMap;
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명	: MyInquiryController.java
	* - 작성일	: 2016. 4. 7.
	* - 작성자	: jangjy
	* - 설명		: 1:1 문의하기 취소
	* </pre>
	* @param po
	* @param session
	* @return
	* @throws Exception
	*/
	@RequestMapping(value="inquiryCancel", method=RequestMethod.POST)
	@ResponseBody
	public ModelMap inquiryCancel(Long cusNo, Session session) {

		this.counselService.cancelCounsel(cusNo, session.getMbrNo());

		return new ModelMap();
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명	: MyInquiryController.java
	* - 작성일	: 2016. 4. 7.
	* - 작성자	: jangjy
	* - 설명		: 1:1 문의하기 취소
	* </pre>
	* @param po
	* @param session
	* @return
	* @throws Exception
	*/
	@RequestMapping(value="appInquiryImageUpdate", method=RequestMethod.POST)
	@ResponseBody
	public ModelMap appInquiryImageUpdate(Session session, CounselPO po) {

		this.counselService.appInquiryImageUpdate(po);

		return new ModelMap();
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명		: gs-apet-31-front
	 * - 파일명		: InquiryController.java
	 * - 작성일		: 2021. 8. 17. 
	 * - 작성자		: YJU
	 * - 설명			: 상품 qna 리스트 조회
	 * </pre>
	 * @param map
	 * @param session
	 * @param so
	 * @return
	 */
	@RequestMapping(value="getMyQnaList")
	public String getGoodsInquiryList(ModelMap map, Session session, GoodsInquirySO so) {
		List<GoodsInquiryVO> myQnaList = goodsInquiryService.getGoodsInquiryList(so);
		map.put("myQnaList", myQnaList);
		return TilesView.none(new String[] { "mypage","inquiry","include", "includeMyQnaList" });
	}
	
	@RequestMapping(value="getMyIqrList")
	public String getMyIqrList(ModelMap map, Session session, CounselSO so) {
		so.setMbrNo(session.getMbrNo());
		so.setSidx("SYS_REG_DTM");
		so.setSord("DESC");
		List<CounselVO> counselList = counselService.getCounselListFO(so);
		map.put("counselList", counselList);
		return TilesView.none(new String[] { "mypage","inquiry","include", "includeMyInquriyList" });
	}
}