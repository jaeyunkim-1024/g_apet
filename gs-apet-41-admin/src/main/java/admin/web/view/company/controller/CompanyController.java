package admin.web.view.company.controller;

import java.io.File;
import java.util.List;
import java.util.Objects;

import org.apache.commons.lang.RandomStringUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ObjectUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import admin.web.config.grid.GridResponse;
import admin.web.config.view.View;
import biz.app.brand.model.CompanyBrandPO;
import biz.app.brand.model.CompanyBrandVO;
import biz.app.company.model.CompAcctPO;
import biz.app.company.model.CompAcctVO;
import biz.app.company.model.CompanyBasePO;
import biz.app.company.model.CompanyBaseVO;
import biz.app.company.model.CompanyCclPO;
import biz.app.company.model.CompanyCclVO;
import biz.app.company.model.CompanyChrgPO;
import biz.app.company.model.CompanyChrgVO;
import biz.app.company.model.CompanyNoticePO;
import biz.app.company.model.CompanyNoticeSO;
import biz.app.company.model.CompanyNoticeVO;
import biz.app.company.model.CompanyPolicyPO;
import biz.app.company.model.CompanyPolicySO;
import biz.app.company.model.CompanyPolicyVO;
import biz.app.company.model.CompanySO;
import biz.app.company.service.CompanyNoticeService;
import biz.app.company.service.CompanyPolicyService;
import biz.app.company.service.CompanyService;
import biz.app.delivery.model.DeliveryChargePolicyPO;
import biz.app.delivery.model.DeliveryChargePolicySO;
import biz.app.delivery.model.DeliveryChargePolicyVO;
import biz.app.delivery.service.DeliveryChargePolicyService;
import biz.app.display.model.DisplayCategoryPO;
import biz.app.display.model.DisplayCategoryVO;
import biz.app.partner.model.PartnerInfoPO;
import biz.app.shop.model.ShopEnterFileSO;
import biz.app.shop.model.ShopEnterFileVO;
import biz.app.shop.model.ShopEnterSO;
import biz.app.shop.model.ShopEnterVO;
import biz.app.shop.service.ShopEnterService;
import biz.app.st.model.StStdInfoSO;
import biz.app.st.model.StStdInfoVO;
import biz.app.st.service.StService;
import framework.admin.constants.AdminConstants;
import framework.admin.model.Session;
import framework.admin.util.AdminSessionUtil;
import framework.admin.util.JsonUtil;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import framework.common.util.StringUtil;
import lombok.extern.slf4j.Slf4j;

/**
 * <pre>
 * - 프로젝트명	: 41.admin.web
 * - 패키지명		: admin.web.view.goods.controller
 * - 파일명		: CompanyController.java
 * - 작성자		: valueFactory
 * - 설명		: 업체 관리
 * </pre>
 */
@Slf4j
@Controller
public class CompanyController {

	// 업체 서비스
	@Autowired private CompanyService companyService;

	// 업체 게시판 서비스
	@Autowired private CompanyNoticeService companyNoticeService;

	// 업체 정책 서비스
	@Autowired
	private CompanyPolicyService companyPolicyService;

	// 입점문의 서비스
	@Autowired private ShopEnterService shopEnterService;

	// 배송정책 서비스
	@Autowired private DeliveryChargePolicyService deliveryChargePolicyService;
	
	@Autowired private StService stService;

	
	/**
	 * <pre>업체 리스트 페이지</pre>
	 * 
	 * @author valueFactory
	 * @param 
	 * @return viewResolver path
	 */
	@RequestMapping("/company/companyListView.do")
	public String companyListView() {
		return "/company/companyListView";
	}

	
	/**
	 * <pre>업체 그리드 리스트, 계약업체목록조회</pre>
	 * 
	 * @author valueFactory
	 * @param so CompanySO
	 * @return DataGridResponse
	 */
	@ResponseBody
	@RequestMapping(value = "/company/companyListGrid.do", method = RequestMethod.POST)
	public GridResponse companyListGrid(CompanySO so) {

		/*
		 * 1. 통합어드민 : 상위업체번호 O, 내 업체번호 X 2. 입점업체 : 상위업체번호 X, 내 업체번호 O
		 */
		Session session = AdminSessionUtil.getSession();
		if (StringUtils.equals(CommonConstants.USR_GRP_10, session.getUsrGrpCd())) {
			// 입점업체 목록을 보여줘야 함.
			so.setUpCompNo(0L);
		} else if (StringUtils.equals(CommonConstants.USR_GRP_20, session.getUsrGrpCd())) {
			// 입점업체 자신만 보이면 됨.
			so.setUpCompNo(null);
			so.setCompNo(session.getCompNo());
		}

		List<CompanyBaseVO> list = companyService.pageCompany(so);
		return new GridResponse(list, so);
	}

	
	/**
	 * <pre>검색, 선택용 팝업화면(업체 그리드 리스트, 계약업체목록조회)</pre>
	 * 
	 * @author valueFactory
	 * @param so CompanySO
	 * @param showLowerCompany 
	 * @param showOnlyMainCompany
	 * @return DataGridResponse
	 */
	@ResponseBody
	@RequestMapping(value = "/company/popupCompanyListGrid.do", method = RequestMethod.POST)
	public GridResponse popupCompanyListGrid(CompanySO so) {
		List<CompanyBaseVO> list = companyService.pageCompanyPopup(so);
		return new GridResponse(list, so);
	}

	
	/**
	 * <pre> 업체 그리드 리스트, 하위업체목록조회</pre>
	 * 
	 * @author valueFactory
	 * @param so CompanySO
	 * @return DataGridResponse
	 */
	@ResponseBody
	@RequestMapping(value = "/company/subCompanyListGrid.do", method = RequestMethod.POST)
	public GridResponse subCompanyListGrid(CompanySO so) {

		/*
		 * 1. 통합어드민 : 상위업체번호 X, 내 업체번호 X 2. 입점업체 : 상위업체번호 X, 내 업체번호 O --> 상위업체번호
		 */
		Session session = AdminSessionUtil.getSession();
		if (StringUtils.equals(CommonConstants.USR_GRP_10, session.getUsrGrpCd())) {
			// 상위업체 번호가 0 이 아닌 입점업체 목록을 보여줘야 함.
			so.setUpCompNo(null);
			so.setAdminYn("Y");
		} else if (StringUtils.equals(CommonConstants.USR_GRP_20, session.getUsrGrpCd())) {
			// 입점업체 번호가 상위업체번호인 업체 목록을 조회
			so.setUpCompNo(session.getCompNo());

			// 로그인한(세션) 업체번호와 검색조건(업체명) 업체번호가 같으면 상위업체로만 조회하고, 다르면 하위업체번호를 검색조건으로 사용함.
			if (!Objects.isNull(so.getCompNo())) {
				so.setCompNo(session.getCompNo().compareTo(so.getCompNo()) == 0 ? null : so.getCompNo());
			}
		}

		List<CompanyBaseVO> list = companyService.pageCompany(so);
		return new GridResponse(list, so);
	}

	
	/**
	 * <pre>계약 업체 등록 화면</pre>
	 * 
	 * @author valueFactory
	 * @param 
	 * @return viewResolver path
	 */
	@RequestMapping("/company/companyInsertView.do")
	public String companyInsertView(Model model) {

		if (StringUtils.equals(CommonConstants.USR_GRP_10, AdminSessionUtil.getSession().getUsrGrpCd())) {
			model.addAttribute("USR_GRP_10", true);
		}

		return "/company/companyInsertView";
	}

	
	/**
	 * <pre>업체 상세 화면</pre>
	 * 
	 * @author valueFactory
	 * @param model
	 * @param so CompanySO
	 * @return viewResolver path
	 */
	@RequestMapping("/company/companyView.do")
	public String companyView(Model model, CompanySO so) {
		if (StringUtils.equals(CommonConstants.USR_GRP_10, AdminSessionUtil.getSession().getUsrGrpCd())) {
			model.addAttribute("USR_GRP_10", true);
		}

		model.addAttribute("companyBase", companyService.getCompany(so));

		StStdInfoSO stSO = new StStdInfoSO();
		stSO.setUseYn(CommonConstants.COMM_YN_Y);
		stSO.setCompNo(so.getCompNo());
		model.addAttribute("compStIds", stService.listStStdInfo(stSO));

		return "/company/companyView";
	}

	
	/**
	 * <pre>업체 등록</pre>
	 * 
	 * @author valueFactory
	 * @param model
	 * @param companyBasePO CompanyBasePO
	 * @param companyCclPO CompanyCclPO
	 * @param deliveryChargePolicyPO DeliveryChargePolicyPO
	 * @param companyBrandPOStr
	 * @param displayCategoryPOStr
	 * @return jsonView
	 * @throws Exception 
	 */
	@RequestMapping("/company/companyInsert.do")
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public String companyInsert(Model model, CompanyBasePO companyBasePO, CompanyCclPO companyCclPO, DeliveryChargePolicyPO deliveryChargePolicyPO,
			@RequestParam(value = "companyBrandPO", required = false) String companyBrandPOStr,
			@RequestParam(value = "compAcctPO", required = false) String compAcctPOStr,
			@RequestParam(value = "companyChrgPO", required = false) String companyChrgPOStr,
			BindingResult br) throws Exception {

		if (br.hasErrors()) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

		JsonUtil jsonUt = new JsonUtil();

		// 업체 브랜드
		List<CompanyBrandPO> companyBrandPOList = null;
		if (!StringUtil.isEmpty(companyBrandPOStr)) {
			companyBrandPOList = jsonUt.toArray(CompanyBrandPO.class, companyBrandPOStr);
			companyBasePO.setCompanyBrandPOList(companyBrandPOList);
		}
		
		// 업체 계좌
		List<CompAcctPO> compAcctPOList = null;
		if (!StringUtil.isEmpty(compAcctPOStr)) {
			compAcctPOList = jsonUt.toArray(CompAcctPO.class, compAcctPOStr);
			companyBasePO.setCompAcctPOList(compAcctPOList);
		}
		
		// 업체 담당자
		List<CompanyChrgPO> companyChrgPOList = null;
		if (!StringUtil.isEmpty(companyChrgPOStr)) {
			companyChrgPOList = jsonUt.toArray(CompanyChrgPO.class, companyChrgPOStr);
			companyBasePO.setCompanyChrgPOList(companyChrgPOList);
		}

		// 관리자(CommonConstants.USR_GRP_10) 가 등록한 배송비 정책이 아니면 무조건 승인과정을 거쳐야 함.
		deliveryChargePolicyPO.setUsrGrpCd(AdminSessionUtil.getSession().getUsrGrpCd());
		deliveryChargePolicyPO.setUsrNo(AdminSessionUtil.getSession().getUsrNo());

		companyService.insertCompany(companyBasePO, companyCclPO, deliveryChargePolicyPO);

		model.addAttribute("company", companyBasePO);
		
		return View.jsonView();
	}
	
	
	/**
	 * <pre>업체 수정</pre>
	 * 
	 * @author valueFactory
	 * @param model
	 * @param companyBasePO CompanyBasePO
	 * @param companyBrandPOStr
	 * @param displayCategoryPOStr
	 * @return jsonView
	 * @throws Exception 
	 */
	@RequestMapping("/company/companyUpdate.do")
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public String companyUpdate(Model model, CompanyBasePO companyBasePO,
			@RequestParam(value = "companyBrandPO", required = false) String companyBrandPOStr,
			@RequestParam(value = "compAcctPO", required = false) String compAcctPOStr,
			@RequestParam(value = "companyChrgPO", required = false) String companyChrgPOStr,
			BindingResult br) throws Exception {

		if (br.hasErrors()) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

		JsonUtil jsonUt = new JsonUtil();

		// 업체 브랜드
		List<CompanyBrandPO> companyBrandPOList = null;
		if (!StringUtil.isEmpty(companyBrandPOStr)) {
			companyBrandPOList = jsonUt.toArray(CompanyBrandPO.class, companyBrandPOStr);
			companyBasePO.setCompanyBrandPOList(companyBrandPOList);
		}
		
		// 업체 계좌
		List<CompAcctPO> compAcctPOList = null;
		if (!StringUtil.isEmpty(compAcctPOStr)) {
			compAcctPOList = jsonUt.toArray(CompAcctPO.class, compAcctPOStr);
			companyBasePO.setCompAcctPOList(compAcctPOList);
		}
		
		// 업체 담당자
		List<CompanyChrgPO> companyChrgPOList = null;
		if (!StringUtil.isEmpty(companyChrgPOStr)) {
			companyChrgPOList = jsonUt.toArray(CompanyChrgPO.class, companyChrgPOStr);
			companyBasePO.setCompanyChrgPOList(companyChrgPOList);
		}
		
		log.debug("companyBasePO====>" + companyBasePO);

		companyService.updateCompany(companyBasePO);
		model.addAttribute("company", companyBasePO);
		
		return View.jsonView();
	}

	
	/**
	 * <pre>업체 정산 화면</pre>
	 * 
	 * @author valueFactory
	 * @param model
	 * @param so CompanySO
	 * @return viewResolver path
	 */
	@RequestMapping("/company/companyCclViewPop.do")
	public String companyCclViewPop(Model model, CompanySO so) {
		model.addAttribute("company", so);
		return "/company/companyCclViewPop";
	}

	
	/**
	 * <pre>업체 정산 그리드 리스트</pre>
	 * 
	 * @author valueFactory
	 * @param so CompanySO
	 * @return DataGridResponse
	 */
	@ResponseBody
	@RequestMapping(value = "/company/companyCclListGrid.do", method = RequestMethod.POST)
	public GridResponse companyCclListGrid(CompanySO so) {
		List<CompanyCclVO> list = companyService.listCompanyCcl(so);
		return new GridResponse(list, so);
	}

	
	/**
	 * <pre>업체 정산 등록</pre>
	 * 
	 * @author valueFactory
	 * @param model
	 * @param po CompanyCclPO
	 * @return jsonView
	 */
	@RequestMapping("/company/companyCclInsert.do")
	public String companyCclInsert(Model model, CompanyCclPO po, BindingResult br) {
		if (br.hasErrors()) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		companyService.insertCompanyCcl(po);

		return View.jsonView();
	}

	
	/**
	 * <pre>업체 배송 상세</pre>
	 * 
	 * @author valueFactory
	 * @param model
	 * @param so DeliveryChargePolicySO
	 * @param viewDlvrPlcyDetail
	 * @return viewResolver path
	 */
	@RequestMapping("/company/companyDeliveryViewPop.do")
	public String companyDeliveryView(Model model, DeliveryChargePolicySO so, String viewDlvrPlcyDetail) {
		if (StringUtils.equalsIgnoreCase(CommonConstants.COMM_YN_Y, viewDlvrPlcyDetail)) {
			//model.addAttribute("companyDelivery", this.deliveryChargePolicyService.getDeliveryChargePolicy(so));
			model.addAttribute("companyDelivery", this.deliveryChargePolicyService.getDeliveryChargePolicyHistory(so));
		}

		model.addAttribute("company", so);
		// 상세보기 여부(Y:상세보기, N:배송정책 추가 등록)
		model.addAttribute("viewDlvrPlcyDetail", viewDlvrPlcyDetail);

		return "/company/companyDeliveryViewPop";
	}

	
	/**
	 * <pre> 업체 배송 그리드 리스트</pre>
	 * 
	 * @author valueFactory
	 * @param so DeliveryChargePolicySO
	 * @return DataGridResponse
	 */
	@ResponseBody
	@RequestMapping(value = "/company/companyDeliveryListGrid.do", method = RequestMethod.POST)
	public GridResponse companyDeliveryListGrid(DeliveryChargePolicySO so) {
		List<DeliveryChargePolicyVO> list = this.deliveryChargePolicyService.listDeliveryChargePolicy(so);
		return new GridResponse(list, so);
	}


	/**
	 * <pre>업체 배송 저장</pre>
	 * 
	 * @author valueFactory
	 * @param po DeliveryChargePolicyPO
	 * @return jsonView
	 */
	@RequestMapping("/company/companyDeliverySave.do")
	public String companyDeliverySave(DeliveryChargePolicyPO po, BindingResult br) {
		if (br.hasErrors()) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

		// 관리자(CommonConstants.USR_GRP_10) 가 수정한 배송비 정책이 아니면 무조건 승인과정을 거쳐야 함.
		po.setUsrGrpCd(AdminSessionUtil.getSession().getUsrGrpCd());
		po.setUsrNo(AdminSessionUtil.getSession().getUsrNo());

		companyService.saveCompanyDelivery(po);

		return View.jsonView();
	}

	
	/**
	 * <pre>업체 배송 정책 삭제</pre>
	 * 
	 * @author valueFactory
	 * @param po DeliveryChargePolicyPO
	 * @return jsonView
	 */
	@RequestMapping("/company/companyDeliveryDel.do")
	public String companyDeliveryDel(DeliveryChargePolicyPO po, BindingResult br) {
		if (br.hasErrors()) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		this.deliveryChargePolicyService.deleteDeliveryChargePolicy(po);
		return View.jsonView();
	}

	
	/**
	 * <pre>업체 공지사항 목록 화면</pre>
	 * 
	 * @author valueFactory
	 * @param 
	 * @return viewResolver path
	 */
	@RequestMapping("/company/noticeListView.do")
	public String noticeListView() {
		return "/company/noticeListView";
	}

	
	/**
	 * <pre>업체 공지사항 그리드 리스트</pre>
	 * 
	 * @author valueFactory
	 * @param so CompanyNoticeSO
	 * @return DataGridResponse
	 */
	@ResponseBody
	@RequestMapping(value = "/company/noticeListGrid.do", method = RequestMethod.POST)
	public GridResponse noticeListGrid(CompanyNoticeSO so) {
		List<CompanyNoticeVO> list = companyNoticeService.pageCompanyNotice(so);
		return new GridResponse(list, so);
	}

	
	/**
	 * <pre>업체 공지사항 화면</pre>
	 * 
	 * @author valueFactory
	 * @param model
	 * @param so CompanyNoticeSO
	 * @return viewResolver path
	 */
	@RequestMapping("/company/noticeView.do")
	public String noticeView(Model model, CompanyNoticeSO so, BindingResult br) {
		if (br.hasErrors()) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

		// 공지사항 보기 요청일 때만 조회하고 글쓰기 요청일 때는 바로 화면 전환한다.
		if (!Objects.isNull(so.getCompNtcNo())) {
			model.addAttribute("notice", companyNoticeService.getCompanyNotice(so));
		}

		return "/company/noticeView";
	}


	/**
	 * <pre>업체 공지사항 체크 삭제</pre>
	 * 
	 * @author valueFactory
	 * @param model
	 * @param po CompanyNoticePO
	 * @return jsonView
	 */
	@RequestMapping("/company/noticeListDelete.do")
	public String noticeListDelete(CompanyNoticePO po, BindingResult br) {
		if (br.hasErrors()) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		companyNoticeService.deleteListCompanyNotice(po);
		return View.jsonView();
	}

	
	/**
	 * <pre>업체 공지사항 등록</pre>
	 * 
	 * @author valueFactory
	 * @param model
	 * @param po CompanyNoticePO
	 * @return jsonView
	 */
	@RequestMapping("/company/noticeInsert.do")
	public String noticeInsert(Model model, CompanyNoticePO po, BindingResult br) {
		if (br.hasErrors()) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		companyNoticeService.insertCompanyNotice(po);
		model.addAttribute("notice", po);
		return View.jsonView();
	}


	/**
	 * <pre>업체 공지사항 수정</pre>
	 * 
	 * @author valueFactory
	 * @param model
	 * @param po CompanyNoticePO
	 * @return jsonView
	 */
	@RequestMapping("/company/noticeUpdate.do")
	public String noticeUpdate(Model model, CompanyNoticePO po, BindingResult br) {
		if (br.hasErrors()) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		companyNoticeService.updateCompanyNotice(po);
		model.addAttribute("notice", po);
		return View.jsonView();
	}


	/**
	 * <pre>업체 정책 목록</pre>
	 * 
	 * @author valueFactory
	 * @param 
	 * @return viewResolver path
	 */
	@RequestMapping("/company/policyListView.do")
	public String policyListView() {
		return "/company/policyListView";
	}

	
	/**
	 * <pre>업체 정책 그리드 리스트</pre>
	 * 
	 * @author valueFactory
	 * @param so CompanyPolicySO
	 * @return DataGridResponse
	 */
	@ResponseBody
	@RequestMapping(value = "/company/policyListGrid.do", method = RequestMethod.POST)
	public GridResponse policyListGrid(CompanyPolicySO so) {
		Session session = AdminSessionUtil.getSession();
		if(StringUtils.equals(CommonConstants.USR_GRP_20, session.getUsrGrpCd())) {
			so.setUsrGrpCd(session.getUsrGrpCd());
			so.setCompNo(session.getCompNo());
		}		
		List<CompanyPolicyVO> list = companyPolicyService.pageCompanyPolicy(so);
		return new GridResponse(list, so);
	}

	
	/**
	 * <pre>업체 정책 상세</pre>
	 * 
	 * @author valueFactory
	 * @param model
	 * @param so CompanyPolicySO
	 * @return viewResolver path
	 */
	@RequestMapping("/company/policyView.do")
	public String policyView(Model model, CompanyPolicySO so, BindingResult br) {
		if (br.hasErrors()) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		model.addAttribute("policy", companyPolicyService.getCompanyPolicy(so));
		return "/company/policyView";
	}


	/**
	 * <pre>업체 공지사항 등록</pre>
	 * 
	 * @author valueFactory
	 * @param model
	 * @param po CompanyPolicyPO
	 * @return jsonView
	 */
	@RequestMapping("/company/policyInsert.do")
	public String policyInsert(Model model, CompanyPolicyPO po, BindingResult br) {
		if (br.hasErrors()) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		companyPolicyService.insertCompanyPolicy(po);
		model.addAttribute("policy", po);
		return View.jsonView();
	}

	
	/**
	 * <pre>업체 공지사항 수정</pre>
	 * 
	 * @author valueFactory
	 * @param model
	 * @param po CompanyPolicyPO
	 * @return jsonView
	 */
	@RequestMapping("/company/policyUpdate.do")
	public String policyUpdate(Model model, CompanyPolicyPO po, BindingResult br) {
		if (br.hasErrors()) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		companyPolicyService.updateCompanyPolicy(po);
		model.addAttribute("policy", po);
		return View.jsonView();
	}

	
	/**
	 * <pre>업체 공지사항 삭제</pre>
	 * 
	 * @author valueFactory
	 * @param po CompanyPolicyPO
	 * @return jsonView
	 */
	@RequestMapping("/company/policyListDelete.do")
	public String policyListDelete(CompanyPolicyPO po, BindingResult br) {
		if (br.hasErrors()) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		companyPolicyService.deleteListCompanyPolicy(po);
		return View.jsonView();
	}

	
	/**
	 * <pre>입점문의목록 페이지</pre>
	 * 
	 * @author valueFactory
	 * @param 
	 * @return viewResolver path
	 */
	@RequestMapping("/company/contectListView.do")
	public String contectListView() {
		return "/company/contectListView";
	}

	
	/**
	 * <pre>입점업체 그리드 리스트</pre>
	 * 
	 * @author valueFactory
	 * @param so ShopEnterSO
	 * @return DataGridResponse
	 */
	@ResponseBody
	@RequestMapping(value = "/company/contectListGrid.do", method = RequestMethod.POST)
	public GridResponse contectListGrid(ShopEnterSO so) {
		List<ShopEnterVO> list = shopEnterService.pageContectList(so);
		return new GridResponse(list, so);
	}

	
	/**
	 * <pre>입점문의 상세 팝업</pre>
	 * 
	 * @author valueFactory
	 * @param model
	 * @param so ShopEnterSO
	 * @return viewResolver path
	 */
	@RequestMapping("/company/contectDetailViewPop.do")
	public String contectDetailViewPop(Model model, @ModelAttribute("contectDetailResult") ShopEnterSO so) {

		List<ShopEnterVO> contectDetail = shopEnterService.listShopEnterDetail(so);

		List<ShopEnterFileVO> shopEnterFileList = null;

		for (ShopEnterVO contect : contectDetail) {

			ShopEnterFileSO sefso = new ShopEnterFileSO();
			sefso.setSeNo(contect.getSeNo());

			shopEnterFileList = shopEnterService.listShopEnterFile(sefso);

			contect.setPhyPathList(shopEnterFileList);

		}

		model.addAttribute("contectDetail", contectDetail);

		return "/company/contectDetailViewPop";
	}

	
	/**
	 * <pre>업체 전시 매핑  그리드 리스트</pre>
	 * 
	 * @author valueFactory
	 * @param so CompanySO
	 * @return DataGridResponse
	 */
	@ResponseBody
	@RequestMapping(value = "/company/compDispMapListGrid.do", method = RequestMethod.POST)
	public GridResponse compDispMapListGrid(CompanySO so) {
		List<DisplayCategoryVO> list = companyService.pageCompDispMap(so);
		return new GridResponse(list, so);
	}

	
	/**
	 * <pre>업체 브랜드 매핑  그리드 리스트</pre>
	 * 
	 * @author valueFactory
	 * @param so CompanySO
	 * @return DataGridResponse
	 */
	@ResponseBody
	@RequestMapping(value = "/company/compBrandMapListGrid.do", method = RequestMethod.POST)
	public GridResponse compBrandMapListGrid(CompanySO so) {
		List<CompanyBrandVO> list = companyService.pageCompBrandMap(so);
		return new GridResponse(list, so);
	}

	
	/**
	 * <pre>하위 업체 목록</pre>
	 * 
	 * @author valueFactory
	 * @param model
	 * @param so CompanySO
	 * @return viewResolver path
	 */
	@RequestMapping("/company/subCompanyListView.do")
	public String subCompanyListView(Model model, CompanySO so) {

		// 업체사용자일 때 업체번호를 항상 등록조건에 사용하도록.
		Session session = AdminSessionUtil.getSession();
		if (StringUtils.equals(CommonConstants.USR_GRP_20, AdminSessionUtil.getSession().getUsrGrpCd())) {
			model.addAttribute("loginCompNo", session.getCompNo());
		}

		return "/company/subCompanyListView";
	}

	
	/**
	 * <pre>하위 업체 등록 화면</pre>
	 * 
	 * @author valueFactory
	 * @param model
	 * @param so CompanySO
	 * @return viewResolver path
	 */
	@RequestMapping("/company/subCompanyInsertView.do")
	public String subCompanyInsertView(Model model, CompanySO so) {

		Session session = AdminSessionUtil.getSession();
		log.debug("================================");
		log.debug("session ==========>" + session);
		log.debug("so ==========>" + so);
		if (StringUtils.equals(CommonConstants.USR_GRP_20, session.getUsrGrpCd())) {

			model.addAttribute("loginCompNo", session.getCompNo());
			model.addAttribute("loginCompNm", session.getCompNm());
			model.addAttribute("upCompNo", session.getUpCompNo());
			model.addAttribute("upCompNm", session.getUpCompNm());

			model.addAttribute("USR_GB_2020", StringUtils.equals(CommonConstants.USR_GB_2020, session.getUsrGbCd()));
		}

		if (session.getUpCompNo().equals(0L)) {
			so.setUpCompNo(session.getCompNo());
		} else {
			so.setUpCompNo(session.getUpCompNo());
		}

		if (StringUtils.equals(CommonConstants.USR_GRP_10, session.getUsrGrpCd())) {
			so.setUpCompNo(session.getUpCompNo());
		}

		List<StStdInfoVO> stStdInfoList = companyService.getUpperCompStIdList(so);

		model.addAttribute("upCompStList", stStdInfoList);

		return "/company/subCompanyInsertView";
	}

	
	/**
	 * <pre>하위 업체 상세</pre>
	 * 
	 * @author valueFactory
	 * @param model
	 * @param so CompanySO
	 * @return viewResolver path
	 */
	@RequestMapping("/company/subCompanyView.do")
	public String subCompanyView(Model model, CompanySO so) {

		Session session = AdminSessionUtil.getSession();
		log.debug("================================");
		log.debug("session ==========>" + session);
		log.debug("so ==========>" + so);
		if (StringUtils.equals(CommonConstants.USR_GRP_20, session.getUsrGbCd())) {

			model.addAttribute("loginCompNo", session.getCompNo());
			model.addAttribute("loginCompNm", session.getCompNm());
			model.addAttribute("upCompNo", session.getUpCompNo());
			model.addAttribute("upCompNm", session.getUpCompNm());

			model.addAttribute("USR_GB_2020", StringUtils.equals(CommonConstants.USR_GB_2020, session.getUsrGbCd()));
		}

		CompanyBaseVO companyBase = companyService.getCompany(so);

		log.debug("companyBase > " + companyBase);

		if (session.getUpCompNo().equals(0L)) {
			so.setUpCompNo(session.getCompNo());
		} else {
			so.setUpCompNo(session.getUpCompNo());
		}

		if (StringUtils.equals(CommonConstants.USR_GRP_10, session.getUsrGrpCd())) {
			if (!ObjectUtils.isEmpty(so) && !ObjectUtils.isEmpty(companyBase)) {
				so.setUpCompNo(companyBase.getUpCompNo());
			} else {
				so.setUpCompNo(session.getUpCompNo());
			}
		}

		if (StringUtils.equals(CommonConstants.USR_GRP_10, session.getUsrGrpCd()) && ObjectUtils.isEmpty(so.getUpCompNo())) {
			so.setUpCompNo(ObjectUtils.isEmpty(companyBase.getUpCompNo()) ? 0L : companyBase.getUpCompNo());
		}

		log.debug("after so ==========>" + so);
		List<StStdInfoVO> stStdInfoList = companyService.getUpperCompStIdList(so);

		model.addAttribute("companyBase", companyBase);
		model.addAttribute("upCompStList", stStdInfoList);

		return "/company/subCompanyView";
	}

	
	/**
	 * <pre>상위 업체 아이디로 상위업체의 사이트 목록 조회</pre>
	 * 
	 * @author valueFactory
	 * @param model
	 * @param so CompanySO
	 * @return jsonView
	 */
	@RequestMapping("/company/getUpperCompStList.do")
	public String getUpperCompStList(Model model, CompanySO so) {
		List<StStdInfoVO> compStList = companyService.getUpperCompStIdList(so);

		log.debug(" 상위 업체 compStList >>" + compStList);
		model.addAttribute("compStList", compStList);
		return View.jsonView();

	}

	
	/**
	 * <pre>업체 관리 > 하위 업체 관리 > 하위 업체 등록    전시 카테고리 추가 팝업</pre>
	 * 
	 * @author valueFactory
	 * @param so CompanySO
	 * @return viewResolver path
	 */
	@RequestMapping("/company/companyCategoryLayerView.do")
	public String companyCategoryLayerView(CompanySO so) {
		if (log.isDebugEnabled()) {
			log.debug("==================================================");
			log.debug("= {}", "  companyCategoryLayerView Search");
			log.debug("==================================================");
		}
		
		return "/company/companyCategoryLayerView";
	}

	
	/**
	 * <pre>하위 업체 그리드 리스트</pre>
	 * 
	 * @author valueFactory
	 * @param so CompanySO
	 * @return DataGridResponse
	 */
	@ResponseBody
	@RequestMapping(value = "/company/subCompNoListGrid.do", method = RequestMethod.POST)
	public GridResponse subCompNoListGrid(CompanySO so) {
		List<CompanyBaseVO> list = companyService.pageCompany(so);
		return new GridResponse(list, so);
	}

	
	/**
	 * <pre>업체 정책 변경 관리</pre>
	 * 
	 * @author valueFactory
	 * @param 
	 * @return viewResolver path
	 */
	@RequestMapping("/company/deliveryChargePolicyListView.do")
	public String deliveryChargePolicyListView() {
		return "/company/deliveryChargePolicyListView";
	}

	
	/**
	 * <pre>업체 정책 변경 관리</pre>
	 * 
	 * @author valueFactory
	 * @param so CompanySO
	 * @return DataGridResponse
	 */
	@ResponseBody
	@RequestMapping(value = "/company/deliveryChargePolicyListGrid.do", method = RequestMethod.POST)
	public GridResponse deliveryChargePolicyListGrid(CompanySO so) {

		Session session = AdminSessionUtil.getSession();
		if (StringUtils.equals(CommonConstants.USR_GB_1010, session.getUsrGbCd())) {
			// 통합관리자는 전체 배송정책 목록 조회 가능함. 기본은 MD 만 가능.
			so.setAdminYn(CommonConstants.COMM_YN_Y);
		}
		if(StringUtils.equals(CommonConstants.USR_GRP_20, session.getUsrGrpCd())) {
			so.setUsrGrpCd(session.getUsrGrpCd());
			so.setCompNo(session.getCompNo());
		}
		List<DeliveryChargePolicyVO> list = this.deliveryChargePolicyService.pageDeliveryChargePolicyHistory(so);

		return new GridResponse(list, so);
	}

	
	/**
	 * <pre>업체 정책 변경 관리 상세보기</pre>
	 * 
	 * @author valueFactory
	 * @param so CompanySO
	 * @return viewResolver path
	 */
	@RequestMapping("/company/companyDeliveryChargePolicyViewPop.do")
	public String companyDeliveryChargePolicyView(Model model, DeliveryChargePolicySO so, String viewDlvrPlcyDetail) {
		if (StringUtils.equalsIgnoreCase(CommonConstants.COMM_YN_Y, viewDlvrPlcyDetail)) {
			model.addAttribute("companyDelivery", this.deliveryChargePolicyService.getDeliveryChargePolicyHistory(so));
		}

		model.addAttribute("company", so);
		// 상세보기 여부(Y:상세보기, N:배송정책 추가 등록)
		model.addAttribute("viewDlvrPlcyDetail", viewDlvrPlcyDetail);

		return "/company/companyDeliveryChargePolicyViewPop";
	}

	
	/**
	 * <pre>업체 정책 변경 관리 승인</pre>
	 * 
	 * @author valueFactory
	 * @param po DeliveryChargePolicyPO
	 * @return jsonView
	 */
	@RequestMapping("/company/updateCompanyDeliveryChargePolicy.do")
	public String updateCompanyDeliveryChargePolicy(DeliveryChargePolicyPO po) {
		po.setSysUpdrNo(AdminSessionUtil.getSession().getUsrNo());
		companyService.updateCompanyDeliveryChargePolicy(po);
		return View.jsonView();
	}

	
	/**
	 * <pre>업체 수수료율 일괄 변경</pre>
	 * 
	 * @author valueFactory
	 * @param model
	 * @param compNo
	 * @param stId
	 * @param cmsRate
	 * @return jsonView
	 */
	@RequestMapping("/company/companyCmsRateChg.do")
	public String companyCmsRateChg(Model model, Long compNo, Long stId, Double cmsRate) {
		int rtn = companyService.companyCmsRateChg(compNo, stId, cmsRate);
		model.addAttribute("rtn", rtn);

		return View.jsonView();
	}

	
	/**
	 * <pre>API 허용 IP 조회 팝업</pre>
	 * 
	 * @author valueFactory
	 * @param model
	 * @param so CompanySO
	 * @return viewResolver path
	 */
	@RequestMapping("/company/companyApiPremitViewPop.do")
	public String companyApiPremitViewPop(Model model, CompanySO so) {
		model.addAttribute("company", so);
		return "/company/companyApiPremitViewPop";
	}

	
	/**
	 * <pre>API 허용 IP 등록</pre>
	 * 
	 * @author valueFactory
	 * @param compNo
	 * @param pmtIp
	 * @return jsonView
	 */
	@RequestMapping("/company/insertApiPermitIp.do")
	public String insertApiPermitIp(Long compNo, String pmtIp) {
		companyService.insertApiPermitIp(compNo, pmtIp);
		return View.jsonView();
	}

	
	/**
	 * <pre>API 허용 IP 삭제</pre>
	 * 
	 * @author valueFactory
	 * @param ipSeqs
	 * @return jsonView
	 */
	@RequestMapping("/company/deleteApiPermitIp.do")
	public String deleteApiPermitIp(Long[] ipSeqs) {
		companyService.deleteApiPermitIp(ipSeqs);
		return View.jsonView();
	}

	
	/**
	 * <pre>허용 IP 그리드 리스트</pre>
	 * 
	 * @author valueFactory
	 * @param so CompanySO
	 * @return DataGridResponse
	 */
	@ResponseBody
	@RequestMapping(value = "/company/companyApiPermitIpListGrid.do", method = RequestMethod.POST)
	public GridResponse companyApiPermitIpListGrid(CompanySO so) {
		List<CompanyBaseVO> list = companyService.companyApiPermitIpList(so);
		return new GridResponse(list, so);
	}

	
	/**
	 * <pre>API Key 생성</pre>
	 * 
	 * @author valueFactory
	 * @param model
	 * @return jsonView
	 */
	@RequestMapping("/company/apiKeyCreate.do")
	public String apiKeyCreate(Model model) {

		model.addAttribute("rtn",
				RandomStringUtils.randomAlphanumeric(8) + "-" + RandomStringUtils.randomAlphanumeric(4) + "-"
				+ RandomStringUtils.randomAlphanumeric(4) + "-" + RandomStringUtils.randomAlphanumeric(4) + "-"
				+ RandomStringUtils.randomAlphanumeric(12));

		return View.jsonView();
	}

	
	/**
	 * <pre>업체 계정으로 로그인</pre>
	 * 
	 * @author valueFactory
	 * @param model
	 * @param so CompanySO
	 * @return jsonView
	 */
	@RequestMapping(value = "/company/compUserLogin.do")
	public String compUserLogin(Model model, CompanySO so) {

		String resultMsg = null;

		String resultCode = companyService.compUserLogin(so);

		if (resultCode.equals(AdminConstants.CONTROLLER_RESULT_CODE_SUCCESS)) {
			resultMsg = "정상 처리 되었습니다.";

		} else if (resultCode.equals(AdminConstants.CONTROLLER_RESULT_CODE_FAIL)) {
			resultMsg = "해당 업체의 사용자계정이 없습니다.";
		}

		model.addAttribute(AdminConstants.CONTROLLER_RESULT_CODE, resultCode);
		model.addAttribute(AdminConstants.CONTROLLER_RESULT_MSG, resultMsg);

		return View.jsonView();
	}
	
	@ResponseBody
	@RequestMapping(value="/company/getCisList.do")
	public List getCisList() {
		return companyService.getCisList();
	}
	

	@RequestMapping("/company/companyImageLayerView.do")
	public String petInclCtfcImageLayerView(Model model, @RequestParam(value="imgPath") String imgPath){
		model.addAttribute("imgPath", imgPath);
		return "/company/companyImageLayerView";
	}
	
	@ResponseBody
	@RequestMapping(value="/company/compAcctListGrid.do", method = RequestMethod.POST)
	public GridResponse companyAcctListGrid(CompanySO so) {
		List<CompAcctVO> list = companyService.listCompAcct(so);
		return new GridResponse(list, so);
	}
	
	@ResponseBody
	@RequestMapping(value="/company/companyChrgListGrid.do", method = RequestMethod.POST) 
	public GridResponse companyChrgListGrid(CompanySO so) {
		List<CompanyChrgVO> list = companyService.listCompanyChrg(so);
		return new GridResponse(list, so);
	}
	
	@ResponseBody
	@RequestMapping(value="/company/compNmDupCheck")
	public int compNmDupCheck(CompanySO so) {
		int result = companyService.compNmDupCheck(so);
		
		return result;
	}
	

	
	@ResponseBody
	@RequestMapping("/company/beforeImageDelete.do")
	public String beforeImageDelete(Model model, @RequestParam(value="imgPath") String imgPath) {
		File file = new File(imgPath);
		if(file.exists()) {
			file.delete();
		}
		return CommonConstants.CONTROLLER_RESULT_CODE_SUCCESS;
	}

	@ResponseBody
	@RequestMapping("/company/afterImageDelete.do")
	public String afterImageDelete(Model model, CompanyBasePO po, CompAcctPO acctPO) {
		companyService.deleteImage(po, acctPO);
		return CommonConstants.CONTROLLER_RESULT_CODE_SUCCESS;
	}
}