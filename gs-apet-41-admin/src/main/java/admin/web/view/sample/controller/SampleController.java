package admin.web.view.sample.controller;

import java.io.IOException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;

import admin.web.config.grid.GridResponse;
import admin.web.config.view.View;
import biz.app.appweb.model.PushSO;
import biz.app.appweb.model.PushVO;
import biz.app.appweb.service.PushService;
import biz.app.member.model.MemberUnsubscribeVO;
import biz.app.st.model.StStdInfoSO;
import biz.app.st.model.StStdInfoVO;
import biz.app.st.service.StService;
import biz.common.model.EmailRecivePO;
import biz.common.model.EmailSendPO;
import biz.common.model.PushTargetPO;
import biz.common.model.PushTokenPO;
import biz.common.model.PushTokenSO;
import biz.common.model.SearchEngineEventPO;
import biz.common.model.SendPushPO;
import biz.common.model.SsgMessageRecivePO;
import biz.common.model.SsgMessageSendPO;
import biz.common.service.BizService;
import biz.interfaces.nicepay.model.request.data.CancelProcessReqVO;
import biz.interfaces.nicepay.model.request.data.CashReceiptReqVO;
import biz.interfaces.nicepay.model.request.data.CheckBankAccountReqVO;
import biz.interfaces.nicepay.model.request.data.VirtualAccountReqVO;
import biz.interfaces.nicepay.model.response.data.CancelProcessResVO;
import biz.interfaces.nicepay.model.response.data.CashReceiptResVO;
import biz.interfaces.nicepay.model.response.data.CheckBankAccountResVO;
import biz.interfaces.nicepay.model.response.data.VirtualAccountResVO;
import biz.interfaces.nicepay.service.NicePayCashReceiptService;
import biz.interfaces.nicepay.service.NicePayCommonService;
import biz.twc.model.CounslorPO;
import biz.twc.model.TicketPO;
import biz.twc.service.TwcService;
import framework.admin.constants.AdminConstants;
import framework.cis.client.ApiClient;
import framework.cis.model.request.sample.SampleRequest;
import framework.cis.model.response.ApiResponse;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import framework.common.model.FileVO;
import framework.common.model.PurgeParam;
import framework.common.util.FileUtil;
import framework.common.util.FtpImgUtil;
import framework.common.util.MaskingUtil;
import framework.common.util.NhnObjectStorageUtil;
import framework.common.util.NhnShortUrlUtil;
import framework.common.util.StringUtil;
import framework.common.util.TwcCryptoUtil;
import lombok.extern.slf4j.Slf4j;

/**
 * 네이밍 룰
 * 업무명View		:	화면
 * 업무명Grid		:	그리드
 * 업무명Tree		:	트리
 * 업무명Insert		:	입력
 * 업무명Update		:	수정
 * 업무명Delete		:	삭제
 * 업무명Save		:	입력 / 수정
 * 업무명ViewPop		:	화면팝업
 */

/**
 * <pre>
 * - 프로젝트명	: 41.admin.web
 * - 패키지명	: admin.web.view.sample.controller
 * - 파일명		: SampleController.java
 * - 작성일		: 2020. 12. 21.
 * - 작성자		: valueFactory
 * - 설명		: 쿠폰 리스트
 * </pre>
 */
@Slf4j
@Controller
public class SampleController {

	@Autowired
	private ApiClient apiClient;
	
	@Autowired
	private Properties bizConfig;
	
	@Autowired
	private NicePayCommonService nicePayCommonService;
	
	@Autowired
	private NicePayCashReceiptService nicePayCashReceiptService;
	
	@Autowired
	private BizService bizService;
		
	@Autowired
	private PushService pushService;
	
	@Autowired
	private StService stService;
	
	@Autowired
	private TwcService twcService;
	
	@Autowired
	private NhnObjectStorageUtil nhnObjectStorageUtil;
	
	private String msg;
	
	@Autowired
	private TwcCryptoUtil twcCryptoUtil;
	
	@Autowired private NhnShortUrlUtil NhnShortUrlUtil;
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: SampleController.java
	 * - 작성일		: 2020. 12. 21.
	 * - 작성자		: KKB
	 * - 설명		: 개발 변경 사항에 대한 안내
	 * </pre>
	 * @return
	 */
	@RequestMapping("/sample/sampleGuideView.do")
	public String sampleGuideView() {
		if (StringUtil.equals(bizConfig.getProperty("envmt.gb"), CommonConstants.ENVIRONMENT_GB_OPER)) {
//			return View.errorView();
		}
		return "/sample/sampleGuideView";
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: SampleController.java
	 * - 작성일		: 2020. 12. 21.
	 * - 작성자		: KKB
	 * - 설명		: TILES에 관한 안내
	 * </pre>
	 * @return
	 */
	@RequestMapping("/sample/sampleTilesGuideView.do")
	public String sampleTilesGuideView() {
		if (StringUtil.equals(bizConfig.getProperty("envmt.gb"), CommonConstants.ENVIRONMENT_GB_OPER)) {
//			return View.errorView();
		}
		return "/sample/sampleTilesGuideView";
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: SampleController.java
	 * - 작성일		: 2021. 1. 5.
	 * - 작성자		: KSH
	 * - 설명		: CIS API Client Guide
	 * </pre>
	 * @return
	 */
	@RequestMapping("/sample/sampleCisApiClientGuideView.do")
	public String sampleCisApiClientGuideView(Model model) {
		if (StringUtil.equals(bizConfig.getProperty("envmt.gb"), CommonConstants.ENVIRONMENT_GB_OPER)) {
//			return View.errorView();
		}
		ApiResponse ar = null;

		// Map
		Map<String, String> queryString = new HashMap<String, String>();		
		queryString.put("allYn", "Y");
		
		// error 방지용 주석
//		ar = apiClient.getResponse(CisApiSpec.IF_S_SELECT_PRNT_LIST, queryString);

		// Object
		SampleRequest sampleRequest = new SampleRequest();
		sampleRequest.setAllYn("Y");
		
		// error 방지용 주석
//		ar = apiClient.getResponse(CisApiSpec.IF_S_SELECT_PRNT_LIST, sampleRequest);
//		ObjectNode on = (ObjectNode) ar.getResponseJson();
//		ObjectMapper objectMapper = new ObjectMapper(); 
//
//
//		List<SampleVO> itemList = new ArrayList<SampleVO>();
//		try {
//			itemList = objectMapper.readValue(on.get("itemList"), new TypeReference<ArrayList<SampleVO>>(){});
//		} catch (JsonParseException | JsonMappingException e) {
//			throw new IllegalArgumentException(CommonConstants.LOG_EXCEPTION_DATE);
//		} catch (IOException e) {
//			log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
//		}
//		model.addAttribute("itemList", itemList);
		return "/sample/sampleCisApiClientGuideView";
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: SampleController.java
	 * - 작성일		: 2021. 1. 4.
	 * - 작성자		: LDS
	 * - 설명			: Naver Map 안내
	 * </pre>
	 * @return
	 */
	@RequestMapping("/sample/sampleNaverMapView.do")
	public String sampleNaverMapView() {
		if (StringUtil.equals(bizConfig.getProperty("envmt.gb"), CommonConstants.ENVIRONMENT_GB_OPER)) {
//			return View.errorView();
		}
		return "/sample/sampleNaverMapView";
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: SampleController.java
	 * - 작성일		: 2021. 1. 8.
	 * - 작성자		: LDS
	 * - 설명			: 행정안전부 우편번호 안내
	 * </pre>
	 * @return
	 */
	@RequestMapping("/sample/sampleMoisPostView.do")
	public String sampleMoisPostView() {
		if (StringUtil.equals(bizConfig.getProperty("envmt.gb"), CommonConstants.ENVIRONMENT_GB_OPER)) {
//			return View.errorView();
		}
		return "/sample/sampleMoisPostView";
	}
	
	/**
	 * <pre>
	 * - Method 명	: naverCaptchaView
	 * - 작성일		: 2021. 1. 8.
	 * - 작성자		: valfac
	 * - 설  명		: 네이버 캡차 관련
	 * </pre>
	 *
	 * @return
	 */
	@RequestMapping("/sample/naverCaptchaView.do")
	public String naverCaptchaView(ModelMap map, @RequestParam(value = "type", required = false) String type) {
		if (StringUtil.equals(bizConfig.getProperty("envmt.gb"), CommonConstants.ENVIRONMENT_GB_OPER)) {
			return View.errorView();
		}
		if (StringUtil.isBlank(type)) {
			type = "image";
		}

		/*
		 * Map<String, String> result = NhnCaptchaUtil.genKey(type); map.put("key",
		 * result.get("key")); map.put("captcha",
		 * NhnCaptchaUtil.genCaptcha((result.get("key")), type)); map.put("type", type);
		 */
		return "/sample/naverCaptchaView";
	}

	@RequestMapping(value = "/sample/naverCaptcha.do")
	public String naverCaptcha(Model model, @RequestParam(value = "type", required = false) String type, @RequestParam(value = "path", required = false) String path) {
		if (StringUtil.equals(bizConfig.getProperty("envmt.gb"), CommonConstants.ENVIRONMENT_GB_OPER)) {
			return View.errorView();
		}
		if (StringUtil.isBlank(type)) {
			type = "image";
		}
		HashMap<String, String> map = new HashMap<String, String>();
		/*
		 * Map<String, String> result = NhnCaptchaUtil.genKey(type); map.put("key",
		 * result.get("key")); map.put("captcha",
		 * NhnCaptchaUtil.genCaptcha((result.get("key")), type));
		 * model.addAttribute("data", map); String uploadBase =
		 * bizConfig.getProperty("common.file.upload.base"); FileUtil.delete(uploadBase
		 * + path);
		 */
		return View.jsonView();
	}

	@RequestMapping(value = "/sample/checkCaptcha.do")
	public String checkCaptcha(Model model, @RequestParam(value="key") String key, @RequestParam(value="captchaValue") String captchaValue, @RequestParam(value = "type", required = false) String type, @RequestParam(value = "path", required = false) String path) {
		if (StringUtil.equals(bizConfig.getProperty("envmt.gb"), CommonConstants.ENVIRONMENT_GB_OPER)) {
			return View.errorView();
		}
		if (StringUtil.isBlank(type)) {
			type = "image";
		}
		/*
		 * Map<String, String> result = NhnCaptchaUtil.checkCaptcha(key, captchaValue,
		 * type); Map<String, String> rs = NhnCaptchaUtil.genKey(type);
		 * model.addAttribute("key", rs.get("key")); model.addAttribute("captcha",
		 * NhnCaptchaUtil.genCaptcha((rs.get("key")), type));
		 */
		//model.addAttribute("result", result.get("result"));
		String uploadBase = bizConfig.getProperty("common.file.upload.base");
		FileUtil.delete(uploadBase + path);
		return View.jsonView();
	}
	
	/**
	 * <pre>
	 * - Method 명	: naverShorturlView
	 * - 작성일		: 2021. 1. 8.
	 * - 작성자		: valfac
	 * - 설  명		: 네이버 shortUrl 관련
	 * </pre>
	 *
	 * @return
	 */
	@RequestMapping("/sample/shorturlView.do")
	public String shorturlView() {
		if (StringUtil.equals(bizConfig.getProperty("envmt.gb"), CommonConstants.ENVIRONMENT_GB_OPER)) {
//			return View.errorView();
		}
		return "/sample/naverShorturlView";
	}
	
	@ResponseBody
	@RequestMapping(value = "/sample/getShortUrl.do")
	public String getShortUrl(@RequestParam(value = "originUrl") String originUrl) {
		if (StringUtil.equals(bizConfig.getProperty("envmt.gb"), CommonConstants.ENVIRONMENT_GB_OPER)) {
//			return View.errorView();
		}
		return NhnShortUrlUtil.getUrl(originUrl);
	}
	
	@ResponseBody
	@RequestMapping(value = "/sample/getNaverApiHeader.do")
	public String getNaverApiHeader(@RequestParam(value = "apiUrl") String apiUrl
			,@RequestParam(value = "mtd") String mtd) {
		if (StringUtil.equals(bizConfig.getProperty("envmt.gb"), CommonConstants.ENVIRONMENT_GB_OPER)) {
//			return View.errorView();
		}
		Long timestamp = Timestamp.valueOf(LocalDateTime.now()).getTime();
		nhnObjectStorageUtil.makeSignature(apiUrl, mtd, String.valueOf(timestamp));
		if (!StringUtils.startsWith(apiUrl, "/")) {
			apiUrl = "/" + apiUrl;
		}
		return String.valueOf(timestamp) + "||" + nhnObjectStorageUtil.makeSignature(apiUrl, mtd, String.valueOf(timestamp));
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: SampleController.java
	 * - 작성일		: 2021. 1. 12.
	 * - 작성자		: KKB
	 * - 설명		: 마스킹 테스트 화면
	 * </pre>
	 * @return
	 */
	@RequestMapping("/sample/sampleMaskedStringView.do")
	public String sampleMaskedStringView() {
		if (StringUtil.equals(bizConfig.getProperty("envmt.gb"), CommonConstants.ENVIRONMENT_GB_OPER)) {
//			return View.errorView();
		}
		return "/sample/sampleMaskedStringView";
	}
	
	@RequestMapping(value = "/sample/petraEnc.do")
	public String petraEnc(Model model, @RequestParam(value="encStr") String encStr, @RequestParam(value="type") String type) {
		if (StringUtil.equals(bizConfig.getProperty("envmt.gb"), CommonConstants.ENVIRONMENT_GB_OPER)) {
//			return View.errorView();
		}
		String encTxt = null;
		if (StringUtils.equals(type, "two")) {
			encTxt = bizService.twoWayEncrypt(encStr);
		} else {
			encTxt = bizService.oneWayEncrypt(encStr);
		}
		model.addAttribute("result", encTxt);
		return View.jsonView();
	}
	
	@RequestMapping(value = "/sample/petraDec.do")
	public String petraDec(Model model, @RequestParam(value="decStr") String decStr) {
		if (StringUtil.equals(bizConfig.getProperty("envmt.gb"), CommonConstants.ENVIRONMENT_GB_OPER)) {
//			return View.errorView();
		}
		String decTxt = bizService.twoWayDecrypt(decStr);
		
		model.addAttribute("result", decTxt);
		return View.jsonView();
	}
	
	@RequestMapping(value = "/sample/twcEnc.do")
	public String twcEnc(Model model, @RequestParam(value="encStr") String encStr, @RequestParam(value="key") String key) {
		if (StringUtil.equals(bizConfig.getProperty("envmt.gb"), CommonConstants.ENVIRONMENT_GB_OPER)) {
//			return View.errorView();
		}
		String encTxt = "";
		try {
			encTxt = twcCryptoUtil.encryptWithKey(encStr, key);
		} catch (Exception e) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		model.addAttribute("result", encTxt);
		return View.jsonView();
	}
	
	@RequestMapping(value = "/sample/twcDec.do")
	public String twcDec(Model model, @RequestParam(value="decStr") String decStr, @RequestParam(value="key") String key) {
		if (StringUtil.equals(bizConfig.getProperty("envmt.gb"), CommonConstants.ENVIRONMENT_GB_OPER)) {
//			return View.errorView();
		}
		String decTxt = "";
		try {
			decTxt = twcCryptoUtil.decryptWithKey(decStr, key);
		} catch (Exception e) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		
		model.addAttribute("result", decTxt);
		return View.jsonView();
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: SampleController.java
	 * - 작성일		: 2021. 1. 12.
	 * - 작성자		: KKB
	 * - 설명		: 마스킹 테스트
	 * </pre>
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/sample/getMaskedString.do", method = RequestMethod.POST)
	public String getEduCategoryList(String type, String str, String idx) {
			if (type.equals("name")) {
				str = MaskingUtil.getName(str);
			}else if (type.equals("tel")){
				str = MaskingUtil.getTelNo(str);	
			}else if (type.equals("address")) {
				str = MaskingUtil.getAddress("",str);
			}else if (type.equals("email")) {
				str = MaskingUtil.getEmail(str);	
			}else if (type.equals("resNo")) {
				str = MaskingUtil.getResNo(str, Integer.parseInt(idx));
			}else if (type.equals("birth")) {
				str = MaskingUtil.getBirth(str);
			}else if (type.equals("drsLcnsNo")) {
				str = MaskingUtil.getDrsLcnsNo(str);
			}else if (type.equals("psprtNo")) {	
				str = MaskingUtil.getPrtNo(str);
			}else if (type.equals("card")) {
				str = MaskingUtil.getCard(str);
			}else if (type.equals("bizNo")) {
				str = MaskingUtil.getBizNo(str);
			}else if (type.equals("bankNo")) {
				str = MaskingUtil.getBankNo(str);
			}else if (type.equals("qrCode")) {
				str = MaskingUtil.getQrcode(str);
			}else if (type.equals("ip")) {
				str = MaskingUtil.getIp(str);
			}else if (type.equals("id")) {
				str = MaskingUtil.getId(str);
			}
		return str;
	}
	
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-41-admin
	 * - 파일명		: admin.web.view.sample.controller
	 * - 작성일		: 2021. 01. 14.
	 * - 작성자		: JinHong
	 * - 설명		: NICE PAY SAMPLE 기본 구성 정보 
	 * </pre>
	 * @return
	 */
	@RequestMapping("/sample/sampleNicePayBasicView.do")
	public String sampleNicePayBasicView() {
		if (StringUtil.equals(bizConfig.getProperty("envmt.gb"), CommonConstants.ENVIRONMENT_GB_OPER)) {
//			return View.errorView();
		}
		return "/sample/sampleNicePayBasicView";
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-41-admin
	 * - 파일명		: admin.web.view.sample.controller
	 * - 작성일		: 2021. 01. 14.
	 * - 작성자		: JinHong
	 * - 설명		: NICE PAY SAMPLE 현금 영수증 API 테스트
	 * </pre>
	 * @return
	 */
	@RequestMapping("/sample/sampleNicePayCashReceiptView.do")
	public String sampleNicePayCashReceiptView() {
		if (StringUtil.equals(bizConfig.getProperty("envmt.gb"), CommonConstants.ENVIRONMENT_GB_OPER)) {
//			return View.errorView();
		}
		return "/sample/sampleNicePayCashReceiptView";
	}
	
	
		
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-41-admin
	 * - 파일명		: admin.web.view.sample.controller
	 * - 작성일		: 2021. 02. 22.
	 * - 작성자		: JinHong
	 * - 설명		: NICE PAY SAMPLE 공통 API 테스트
	 * </pre>
	 * @return
	 */
	@RequestMapping("/sample/sampleNicePayCommonApiView.do")
	public String sampleNicePayCommonApiView() {
		if (StringUtil.equals(bizConfig.getProperty("envmt.gb"), CommonConstants.ENVIRONMENT_GB_OPER)) {
//			return View.errorView();
		}
		return "/sample/sampleNicePayCommonApiView";
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-41-admin
	 * - 파일명		: admin.web.view.sample.controller
	 * - 작성일		: 2021. 01. 14.
	 * - 작성자		: JinHong
	 * - 설명		: NICE PAY 현금영수증 승인 요청
	 * </pre>
	 * @param model
	 * @param reqVO
	 * @return
	 */
	@RequestMapping("/sample/reqCashReceipt.do")
	public String reqCashReceipt(Model model, CashReceiptReqVO reqVO) {
		if (StringUtil.equals(bizConfig.getProperty("envmt.gb"), CommonConstants.ENVIRONMENT_GB_OPER)) {
//			return View.errorView();
		}

		CashReceiptResVO res =  nicePayCashReceiptService.reqCashReceipt(reqVO);
		model.addAttribute("res", res);
		
		return View.jsonView();
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-41-admin
	 * - 파일명		: admin.web.view.sample.controller
	 * - 작성일		: 2021. 01. 14.
	 * - 작성자		: JinHong
	 * - 설명		: NICE PAY 승인 취소
	 * </pre>
	 * @param model
	 * @param reqVO
	 * @return
	 */
	@RequestMapping("/sample/reqCancelProcess.do")
	public String reqCancelProcess(Model model, CancelProcessReqVO reqVO, String midGb, String payMeans, String mdaGb) {
		if (StringUtil.equals(bizConfig.getProperty("envmt.gb"), CommonConstants.ENVIRONMENT_GB_OPER)) {
//			return View.errorView();
		}

		CancelProcessResVO res =  nicePayCommonService.reqCancelProcess(reqVO, midGb, payMeans, mdaGb);
		model.addAttribute("res", res);
		
		return View.jsonView();
	}
	
	@RequestMapping("/sample/reqCheckBankAccount.do")
	public String reqCheckBankAccount(Model model, CheckBankAccountReqVO reqVO) {
		if (StringUtil.equals(bizConfig.getProperty("envmt.gb"), CommonConstants.ENVIRONMENT_GB_OPER)) {
//			return View.errorView();
		}
		
		CheckBankAccountResVO res =  nicePayCommonService.reqCheckBankAccount(reqVO);
		model.addAttribute("res", res);
		
		return View.jsonView();
	}
	
	@RequestMapping("/sample/reqGetVirtualAccount.do")
	public String reqCheckBankAccount(Model model, VirtualAccountReqVO reqVO) {
		if (StringUtil.equals(bizConfig.getProperty("envmt.gb"), CommonConstants.ENVIRONMENT_GB_OPER)) {
//			return View.errorView();
		}
		
		VirtualAccountResVO res =  nicePayCommonService.reqGetVirtualAccount(reqVO);
		model.addAttribute("res", res);
		
		return View.jsonView();
	}
	
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-41-admin
	 * - 파일명		: admin.web.view.sample.controller
	 * - 작성일		: 2021. 01. 19.
	 * - 작성자		: KKB
	 * - 설명		: 네이버 아웃바운드 이메일 샘플 화면
	 * </pre>
	 * @param model
	 * @return
	 */
	@RequestMapping("/sample/sampleSendMailView.do")
	public String sampleSendMailView(Model model) {
		if (StringUtil.equals(bizConfig.getProperty("envmt.gb"), CommonConstants.ENVIRONMENT_GB_OPER)) {
//			return View.errorView();
		}
		return "/sample/sampleSendMailView";
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-41-admin
	 * - 파일명		: admin.web.view.sample.controller
	 * - 작성일		: 2021. 01. 19.
	 * - 작성자		: KKB
	 * - 설명		: 네이버 아웃바운드 이메일 템플릿 호출
	 * </pre>
	 * @param tmplNo
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/sample/sampleNoticeTemplate.do")
	public PushVO sampleNoticeTemplate(Long tmplNo) {
		PushSO pso = new PushSO();
		pso.setTmplNo(tmplNo);		
		return pushService.getNoticeTemplate(pso);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-41-admin
	 * - 파일명		: admin.web.view.sample.controller
	 * - 작성일		: 2021. 01. 19.
	 * - 작성자		: KKB
	 * - 설명		: 네이버 아웃바운드 이메일 샘플 발송
	 * </pre>
	 * @param EmailSendPO
	 * @return String
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@ResponseBody
	@RequestMapping("/sample/testEmail.do")
	public String testEmail(@RequestParam("emailJson") String emailJson, @RequestParam("recipientsJon") String recipientsJson) {
		if (StringUtil.equals(bizConfig.getProperty("envmt.gb"), CommonConstants.ENVIRONMENT_GB_OPER)) {
//			return View.errorView();
		}
		EmailSendPO email = new EmailSendPO();
		ObjectMapper mapper = new ObjectMapper().configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
		if (StringUtil.isNotEmpty(emailJson)) {
			try {
				email = mapper.readValue(emailJson, EmailSendPO.class);
			} catch (IOException e) {
				// 보안성 진단. 오류메시지를 통한 정보노출
				//e.printStackTrace();
				log.error("IOException when deserialize JSON", e.getClass());
			}
		}
		if (StringUtil.isNotEmpty(recipientsJson)) {
			List<EmailRecivePO> recipients = new ArrayList<EmailRecivePO>();
			try {
				recipients = Arrays.asList(mapper.readValue(recipientsJson, EmailRecivePO[].class));
//				recipients = mapper.readValue(recipientsJson, new TypeReference<List<EmailRecivePO>>() {});
			} catch (IOException e) {
				// 보안성 진단. 오류메시지를 통한 정보노출
				//e.printStackTrace();
				log.error("IOException when make list", e.getClass());
			}
			email.setRecipients(recipients);
		}
		return bizService.sendEmail(email);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-41-admin
	 * - 파일명		: admin.web.view.sample.controller
	 * - 작성일		: 2021. 01. 22.
	 * - 작성자		: KKB
	 * - 설명		: 클릭 이벤트 테스트 화면
	 * </pre>
	 * @param model
	 * @return
	 */
	@RequestMapping("/sample/sampleSendSearchEventView.do")
	public String sampleSendSearchEventView(Model model) {
		if (StringUtil.equals(bizConfig.getProperty("envmt.gb"), CommonConstants.ENVIRONMENT_GB_OPER)) {
//			return View.errorView();
		}
		return "/sample/sampleSendSearchEventView";
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-41-admin
	 * - 파일명		: admin.web.view.sample.controller
	 * - 작성일		: 2021. 01. 22.
	 * - 작성자		: KKB
	 * - 설명		: 클릭 이벤트 테스트 전송
	 * </pre>
	 * @param SearchEngineEventPO
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/sample/sampleSendSearchEventTest.do")
	public String sampleSendSearchEventTest(SearchEngineEventPO po) {
		if (StringUtil.equals(bizConfig.getProperty("envmt.gb"), CommonConstants.ENVIRONMENT_GB_OPER)) {
//			return View.errorView();
		}
		return bizService.sendClickEventToSearchEngineServer(po);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-41-admin
	 * - 파일명		: admin.web.view.sample.controller
	 * - 작성일		: 2021. 01. 28.
	 * - 작성자		: KSH
	 * - 설명		: SMS/MMS/KKO
	 * </pre>
	 * @param model
	 * @param reqVO
	 * @return
	 */
	@RequestMapping("/sample/sampleSendMessageView.do")
	public String sampleSendMessageView(Model model) {
		if (StringUtil.equals(bizConfig.getProperty("envmt.gb"), CommonConstants.ENVIRONMENT_GB_OPER)) {
//			return View.errorView();
		}
		StStdInfoSO so = new StStdInfoSO();
		so.setUseYn(CommonConstants.COMM_YN_Y);
		List<StStdInfoVO> list = stService.listStStdInfo(so);
		model.addAttribute("csTelNo", list.get(0).getCsTelNo());
		return "/sample/sampleSendMessageView";
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: admin.web.view.sample.controller
	 * - 작성일		: 2020. 12. 21.
	 * - 작성자		: VAL
	 * - 설명			: 알림 메시지 템플릿 선택 팝업
	 * </pre>
	 * @return
	 */
	@RequestMapping(value = "/sample/samplePushTemplateSelectView.do", method = RequestMethod.POST)
	public String samplePushTemplateSelectView(Model model, @RequestParam(value = "sndTypeCd", required = false) String sndTypeCd) {
		model.addAttribute("sndTypeCd", sndTypeCd);
		return "/sample/samplePushTemplateSelectViewPop";
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: admin.web.view.sample.controller
	 * - 작성일		: 2020. 12. 21.
	 * - 작성자		: VAL
	 * - 설명			: 알림 메시지 템플릿 목록 그리드
	 * </pre>
	 * @param so
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/sample/sampleListPushTemplateGrid.do", method = RequestMethod.POST)
	public GridResponse sampleListPushTemplateGrid(PushSO so) {
		List<PushVO> list = pushService.pageNoticeTemplate(so);
		return new GridResponse(list, so);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-41-admin
	 * - 파일명		: admin.web.view.sample.controller
	 * - 작성일		: 2021. 01. 19.
	 * - 작성자		: KSH
	 * - 설명		: SSG message 샘플 발송
	 * </pre>
	 * @param 
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/sample/testMessage.do")
	public String testMessage(@RequestParam("messageJson") String messageJson, @RequestParam("recipientsJon") String recipientsJson) {
		if (StringUtil.equals(bizConfig.getProperty("envmt.gb"), CommonConstants.ENVIRONMENT_GB_OPER)) {
//			return View.errorView();
		}
		SsgMessageSendPO message = new SsgMessageSendPO();

		ObjectMapper mapper = new ObjectMapper().configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
		if (StringUtil.isNotEmpty(messageJson)) {
			try {
				message = mapper.readValue(messageJson, SsgMessageSendPO.class);
			} catch (IOException e) {
				// 보안성 진단. 오류메시지를 통한 정보노출
				//e.printStackTrace();
				log.error("IOException when deserialize JSON in testMessage", e.getClass());
			}
		}
		int result = 0;
		if (StringUtil.equals(CommonConstants.NOTICE_TYPE_10, message.getNoticeTypeCd())) {
			message.setFsenddate(null);
		}
		if (StringUtil.isNotEmpty(recipientsJson)) {
			List<SsgMessageRecivePO> recipients = new ArrayList<SsgMessageRecivePO>();
			try {
				recipients = Arrays.asList(mapper.readValue(recipientsJson, SsgMessageRecivePO[].class));
				String tempMsg = message.getFmessage();
				
				for (SsgMessageRecivePO recipient : recipients) {
					message.setFdestine(recipient.getReceivePhone());
					msg = tempMsg;
					if (recipient.getParameters() != null) {
						recipient.getParameters().forEach((k, v)-> {
							if(k.indexOf("${") == 0) {
								msg = StringUtil.replaceAll(msg, k, v);
							} else {
								msg = StringUtil.replaceAll(msg, "${" + k + "}", v);
							}
						});
						message.setFmessage(msg);
					} else {
						msg = tempMsg;
						message.setFmessage(msg);
					}
					
					result = bizService.sendMessage(message);
				}
				
			} catch (IOException e) {
				e.printStackTrace();
			}
			message.setRecipients(recipients);
		}

		return String.valueOf(result);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-41-admin
	 * - 파일명		: admin.web.view.sample.controller
	 * - 작성일		: 2021. 02. 01.
	 * - 작성자		: KKB
	 * - 설명		: 토큰저장
	 * </pre>
	 * @param PushTokenPO
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/sample/sampleInsertDeviceToken.do")
	public String sampleInsertDeviceToken(PushTokenPO po) {
		if (StringUtil.equals(bizConfig.getProperty("envmt.gb"), CommonConstants.ENVIRONMENT_GB_OPER)) {
//			return View.errorView();
		}
		
		return bizService.insertDeviceToken(po);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-41-admin
	 * - 파일명		: admin.web.view.sample.controller
	 * - 작성일		: 2021. 02. 01.
	 * - 작성자		: KKB
	 * - 설명		: 토큰조회
	 * </pre>
	 * @param PushTokenSO
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/sample/sampleGetDeviceToken.do")
	public String sampleGetDeviceToken(PushTokenSO so) {
		if (StringUtil.equals(bizConfig.getProperty("envmt.gb"), CommonConstants.ENVIRONMENT_GB_OPER)) {
//			return View.errorView();
		}
		
		return bizService.getDeviceToken(so).toString();
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-41-admin
	 * - 파일명		: admin.web.view.sample.controller
	 * - 작성일		: 2021. 02. 02.
	 * - 작성자		: KKB
	 * - 설명		: 토큰 삭제
	 * </pre>
	 * @param PushTokenPO
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/sample/sampleDeleteDeviceToken.do")
	public String sampleGetDeviceToken(PushTokenPO po) {
		if (StringUtil.equals(bizConfig.getProperty("envmt.gb"), CommonConstants.ENVIRONMENT_GB_OPER)) {
//			return View.errorView();
		}
		
		return bizService.deleteDeviceToken(po);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-41-admin
	 * - 파일명		: admin.web.view.sample.controller
	 * - 작성일		: 2021. 02. 02.
	 * - 작성자		: KKB
	 * - 설명		: push 발송 테스트
	 * </pre>
	 * @param SendPushPO
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/sample/sampleSendPush.do")
	public String sampleSendPush(SendPushPO po,
			@RequestParam("targetList") String targetList) {
		if (StringUtil.equals(bizConfig.getProperty("envmt.gb"), CommonConstants.ENVIRONMENT_GB_OPER)) {
//			return View.errorView();
		}
		ObjectMapper mapper = new ObjectMapper().configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
		try {
			if(StringUtil.isNotEmpty(targetList)) {
				List<PushTargetPO> target =  Arrays.asList(mapper.readValue(targetList, PushTargetPO[].class));
				po.setTarget(target);
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		return bizService.sendPush(po);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-41-admin
	 * - 파일명		: admin.web.view.sample.controller
	 * - 작성일		: 2021. 02. 02.
	 * - 작성자		: KKB
	 * - 설명		: 네이버 센스 PUSH 샘플 화면
	 * </pre>
	 * @param model
	 * @return
	 */
	@RequestMapping("/sample/sampleSendPushView.do")
	public String sampleSendPushView(Model model ) {
		if (StringUtil.equals(bizConfig.getProperty("envmt.gb"), CommonConstants.ENVIRONMENT_GB_OPER)) {
//			return View.errorView();
		}
//		model.addAttribute("SendPushPO", new SendPushPO());
		return "/sample/sampleSendPushView";
	}
	
	/**
	 * <pre>
	 * - Method 명	: cdnView
	 * - 작성일		: 2021. 2. 8.
	 * - 작성자		: valfac
	 * - 설  명		: 네이버 Object Storage & CDN 관련
	 * </pre>
	 *
	 * @return
	 */
	@RequestMapping("/sample/cdnView.do")
	public String cdnView() {
		if (StringUtil.equals(bizConfig.getProperty("envmt.gb"), CommonConstants.ENVIRONMENT_GB_OPER)) {
//			return View.errorView();
		}
		return "/sample/cdnView";
	}
	
	/**
	 * <pre>
	 * - Method 명	: cdnView
	 * - 작성일		: 2021. 2. 8.
	 * - 작성자		: valfac
	 * - 설  명		: 네이버 Object Storage & CDN 관련
	 * </pre>
	 *
	 * @return
	 */
	@RequestMapping("/sample/imageUpload.do")
	public String imageUpload(Model model, @RequestParam(value = "imgPath") String imgPath
			,@RequestParam(value = "imgNm") String imgNm) {
		if (StringUtil.equals(bizConfig.getProperty("envmt.gb"), CommonConstants.ENVIRONMENT_GB_OPER)) {
//			return View.errorView();
		}
		FtpImgUtil ftpImgUtil = new FtpImgUtil();
		String filePath = ftpImgUtil.uploadFilePath(imgPath, AdminConstants.TEMP_IMAGE_PATH + FileUtil.SEPARATOR + "1");
		ftpImgUtil.upload(imgPath, filePath);
		FileVO vo = new FileVO();
		vo.setFilePath(filePath);
		vo.setFileName(imgNm);
		model.addAttribute("file", vo);
		return View.jsonView();
	}
	
	/**
	 * <pre>
	 * - Method 명	: cdnView
	 * - 작성일		: 2021. 2. 8.
	 * - 작성자		: valfac
	 * - 설  명		: 네이버 Object Storage & CDN 관련
	 * </pre>
	 *
	 * @return
	 */
	@RequestMapping("/sample/imageDelete.do")
	public String imageDelete(Model model, @RequestParam(value = "directImgPath") String directImgPath) {
		if (StringUtil.equals(bizConfig.getProperty("envmt.gb"), CommonConstants.ENVIRONMENT_GB_OPER)) {
//			return View.errorView();
		}
		nhnObjectStorageUtil.delete(directImgPath);
		return View.jsonView();
	}
	
	/**
	 * <pre>
	 * - Method 명	: cdnView
	 * - 작성일		: 2021. 2. 8.
	 * - 작성자		: valfac
	 * - 설  명		: 네이버 Object Storage & CDN 관련
	 * </pre>
	 *
	 * @return
	 */
	@RequestMapping("/sample/afterImageDelete.do")
	public String afterImageDelete(Model model, @RequestParam(value = "afterImgPath") String afterImgPath) {
		if (StringUtil.equals(bizConfig.getProperty("envmt.gb"), CommonConstants.ENVIRONMENT_GB_OPER)) {
//			return View.errorView();
		}
		nhnObjectStorageUtil.delete(afterImgPath);
		return View.jsonView();
	}
	
	/**
	 * <pre>
	 * - Method 명	: naverShorturlView
	 * - 작성일		: 2021. 1. 8.
	 * - 작성자		: valfac
	 * - 설  명		: 네이버 080 관련
	 * </pre>
	 *
	 * @return
	 */
	@RequestMapping("/sample/unsubscribesView.do")
	public String unsubscribesView() {
		if (StringUtil.equals(bizConfig.getProperty("envmt.gb"), CommonConstants.ENVIRONMENT_GB_OPER)) {
//			return View.errorView();
		}
		return "/sample/unsubscribesView";
	}
	
	/**
	 * <pre>
	 * - Method 명	: cdnView
	 * - 작성일		: 2021. 2. 8.
	 * - 작성자		: valfac
	 * - 설  명		: 080  수신거부 관련
	 * </pre>
	 *
	 * @return
	 */
	@RequestMapping("/sample/getUnsubscribes.do")
	public String getUnsubscribes(Model model, @RequestParam(value = "syncYn", required = false) String syncYn) {
		/*if (StringUtil.equals(bizConfig.getProperty("envmt.gb"), CommonConstants.ENVIRONMENT_GB_OPER)) {
			return View.errorView();
		}*/
		MemberUnsubscribeVO result = bizService.getUnsubscribes(syncYn);

		model.addAttribute("result", result);
		return View.jsonView();
	}
	
	/**
	 * <pre>
	 * - Method 명	: cdnView
	 * - 작성일		: 2021. 2. 8.
	 * - 작성자		: valfac
	 * - 설  명		: 080  수신거부 관련
	 * </pre>
	 *
	 * @return
	 */
	@RequestMapping("/sample/registUnsubscribes.do")
	public String registUnsubscribes(Model model, @RequestParam(value = "mobileArea") String mobileArea, @RequestParam(value = "unsubscribesType", required = false) String unsubscribesType) {
		/*if (StringUtil.equals(bizConfig.getProperty("envmt.gb"), CommonConstants.ENVIRONMENT_GB_OPER)) {
			return View.errorView();
		}*/
		String[] mobileArr = null;
		List<MemberUnsubscribeVO> list = new ArrayList<>();
		if (StringUtil.isNotEmpty(mobileArea)) {
			mobileArr = StringUtil.splitEnter(mobileArea);
		}
		if (StringUtil.isNotEmpty(unsubscribesType) && StringUtil.equals("delete", unsubscribesType)) {
			list = bizService.deleteUnsubscribes(mobileArr);
		} else {
			list = bizService.registUnsubscribes(mobileArr);
		}

		model.addAttribute("result", list);
		return View.jsonView();
	}
	
	/**
	 * <pre>
	 * - Method 명	: naverShorturlView
	 * - 작성일		: 2021. 1. 8.
	 * - 작성자		: valfac
	 * - 설  명		: 네이버 080 관련
	 * </pre>
	 *
	 * @return
	 */
	@RequestMapping("/sample/cdnPlusPurgeView.do")
	public String cdnPlusPurgeView() {
		
		return "/sample/cdnPlusPurgeView";
	}
	
	/**
	 * <pre>
	 * - Method 명	: cdnView
	 * - 작성일		: 2021. 2. 8.
	 * - 작성자		: valfac
	 * - 설  명		: purge 요청
	 * </pre>
	 *
	 * @return
	 */
	@RequestMapping("/sample/requestCdnPlusPurge.do")
	public String requestCdnPlusPurge(Model model, @RequestParam(value = "targetFileList") String fileArea, PurgeParam param) {
		/*if (StringUtil.equals(bizConfig.getProperty("envmt.gb"), CommonConstants.ENVIRONMENT_GB_OPER)) {
			return View.errorView();
		}*/
		String[] fileArr = null;
		if (StringUtil.isNotEmpty(fileArea)) {
			fileArr = StringUtil.splitEnter(fileArea);
			param.setTargetFileList(fileArr);
		}
		if (StringUtil.equals(CommonConstants.COMM_YN_Y, param.getIsWholePurge())) {
			param.setIsWholePurge("true");
		} else {
			param.setIsWholePurge("false");
		}

		model.addAttribute("result", nhnObjectStorageUtil.requestCdnPlusPurge(param).toString());
		return View.jsonView();
	}
	
	/**
	 * <pre>
	 * - Method 명	: naverShorturlView
	 * - 작성일		: 2021. 03. 24.
	 * - 작성자		: KKB
	 * - 설  명		: TWC 샘플 화면
	 * </pre>
	 *
	 * @return
	 */
	@RequestMapping("/sample/sampleTwc.do")
	public String sampleTwc() {
		return "/sample/sampleTwc";
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-41-admin
	 * - 파일명		: admin.web.view.sample.controller
	 * - 작성일		: 2021. 03. 24.
	 * - 작성자		: KKB
	 * - 설명		: TWC 상담원 가입 API
	 * </pre>
	 * @param SendPushPO
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/sample/sampleSendCounselorInfo.do")
	public String sampleSendCounselorInfo(CounslorPO po) {
		return twcService.sendCounselorInfo(po);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-41-admin
	 * - 파일명		: admin.web.view.sample.controller
	 * - 작성일		: 2021. 03. 24.
	 * - 작성자		: KKB
	 * - 설명		: TWC 티켓 이벤트 API
	 * </pre>
	 * @param SendPushPO
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/sample/sampleSendTicketEvent.do")
	public String sampleSendTicketEvent(TicketPO po) {
		return twcService.sendTicketEvent(po);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: SampleController.java
	 * - 작성일		: 2020. 12. 21.
	 * - 작성자		: KKB
	 * - 설명		: 개발 변경 사항에 대한 안내
	 * </pre>
	 * @return
	 */
	@RequestMapping("/sample/sampleSktMpView.do")
	public String sampleSktMpView() {
		if (StringUtil.equals(bizConfig.getProperty("envmt.gb"), CommonConstants.ENVIRONMENT_GB_OPER)) {
//			return View.errorView();
		}
		return "/sample/sampleSktMpView";
	}
	
}