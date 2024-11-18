package front.web.view.common.controller;

import biz.app.display.model.PopupSO;
import biz.app.display.model.PopupVO;
import biz.app.display.service.PopupService;
import biz.app.member.model.MemberBaseSO;
import biz.app.member.model.MemberBaseVO;
import biz.app.member.model.MemberCertifiedLogPO;
import biz.app.member.service.MemberService;
import biz.app.mobileapp.model.MobileVersionAppVO;
import biz.app.mobileapp.model.MobileVersionSO;
import biz.app.mobileapp.service.MobileVersionService;
import biz.app.system.model.CodeDetailSO;
import biz.app.tag.model.TagBaseSO;
import biz.app.tag.model.TagBaseVO;
import biz.app.tag.service.TagService;
import biz.common.model.SearchEngineEventPO;
import biz.common.service.BizService;
import biz.common.service.CacheService;
import biz.interfaces.nicepay.model.response.ResponseCommonVO;
import framework.admin.constants.AdminConstants;
import framework.admin.util.LogUtil;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import framework.common.model.FileVO;
import framework.common.model.FileViewParam;
import framework.common.util.*;
import framework.front.constants.FrontConstants;
import framework.front.model.Session;
import framework.front.util.FrontSessionUtil;
import front.web.config.tiles.TilesView;
import front.web.config.view.ViewBase;
import kcb.module.v3.exception.OkCertException;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang3.StringUtils;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.crypto.BadPaddingException;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.UnsupportedEncodingException;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.*;
import java.util.concurrent.TimeUnit;

@Slf4j
@Controller
@RequestMapping("common")
public class CommonController {

	@Autowired
	private Properties bizConfig;
	
	@Autowired
	private Properties webConfig;

	@Autowired
	private CacheService cacheService;

	@Autowired
	private PopupService popupService;

	@Autowired
	private NaverMapUtil naverMapUtil;

	@Autowired
	private BizService bizService;

	@Autowired
	private MemberService memberService;

	@Autowired
	private NhnObjectStorageUtil nhnObjectStorageUtil;
	
	@Autowired
	private MobileVersionService mobileVersionService;
	
	@Autowired
	private MessageSourceAccessor message;

	@Autowired
	private TagService tagService;
	/**
	 * <pre>
	* - 프로젝트명	: gs-apet-31-front
	* - 파일명	: CommonController.java
	* - 작성일	: 2016. 5. 10.
	* - 작성자	: valfac
	* - 설명		: 공통 이미지 뷰어(임시 파일 업로드)
	 * </pre>
	 * 
	 * @param map
	 * @param filePath
	 * @return
	 */
	@RequestMapping(value = "/imageView")
	public String imageView(ModelMap map, @RequestParam("filePath") String filePath) {
		FileViewParam fileView = new FileViewParam();
		fileView.setFilePath(filePath);
		String[] rootPathArr = {bizConfig.getProperty("common.nas.base") + FileUtil.SEPARATOR + bizConfig.getProperty("common.nas.base.image")
								,bizConfig.getProperty("common.file.upload.base")};
		fileView.setRootPath(rootPathArr);
		map.put(AdminConstants.FILE_PARAM_NAME, fileView);
		return CommonConstants.IMAGE_VIEW_NAME;
	}

	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-31-front
	 * - 파일명	: CommonController.java
	 * - 작성일	: 2016. 5. 10.
	 * - 작성자	: valfac
	 * - 설명		: 공통 파일 업로드
	 * </pre>
	 * 
	 * @param mRequest
	 * @param uploadType
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/fileUploadResult", headers = "content-type=multipart/*", method = RequestMethod.POST)
	public ModelMap fileUploadResult(MultipartHttpServletRequest mRequest
			, @RequestParam("uploadType") String uploadType
			, @RequestParam(value="prefixPath", required=false) String prefixPath
			, HttpServletRequest request) {
		ModelMap model = new ModelMap();
		ResponseCommonVO resComVo = new ResponseCommonVO();
		try {
			LogUtil.log(uploadType);

			String userAgent = request.getHeader("user-agent");
			log.error("file upload user-agent :" + userAgent);
//			if (StringUtil.isNotEmpty(prefixPath) && userAgent.toLowerCase().indexOf("apet") > -1) {
//				throw new CustomException(ExceptionConstants.ERROR_NO_PATH);
//			}
			FileVO result = null;
			List<FileVO> results = new ArrayList<FileVO>();
			Iterator<String> fileIter = mRequest.getFileNames();
			while (fileIter.hasNext()) {
				MultipartFile mFile = mRequest.getFile(fileIter.next());
				String fileOrgName = mFile.getOriginalFilename();
				String exe = FilenameUtils.getExtension(fileOrgName);

				String[] fileFilter = null;
				Long fileSize = null;
				Boolean errorFlg = false;
				
				// 널바이트 체크
				if(mFile.getOriginalFilename().indexOf("%00") >0 || mFile.getOriginalFilename().indexOf("0x00") >0) {
					errorFlg = true;
				}
				
				switch (uploadType) {
				case "image":
					fileFilter = new String[] { "jpg", "jpeg", "png", "gif" };
					fileSize = (long) (15 * 1024 * 1024);
					break;
				case "profileimage":
					fileFilter = new String[] { "jpg", "jpeg", "png" };
					fileSize = (long) (15 * 1024 * 1024);
					break;
				case "mwebProfileimage":
					fileFilter = new String[] { "jpg", "jpeg", "png" };
					fileSize = (long) (15 * 1024 * 1024);
					break;
				case "jpg":
					fileFilter = new String[] { "jpg", "jpeg", "png" };
					fileSize = (long) (15 * 1024 * 1024);
					break;
				case "file":
					fileFilter = "jpg,jpeg,png,gif,bmp,txt,pdf,hwp,xls,xlsx,doc,docx,ppt,pptx".split(",");
					fileSize = (long) (5 * 1024 * 1024);
					break;
				case "inquiry":
					fileFilter = new String[] { "jpg", "png", "jpeg" };
					fileSize = (long) (20 * 1024 * 1024);
					break;
				default:
					errorFlg = true;
					break;
				}

				if (errorFlg) {
					if (StringUtil.isEmpty(prefixPath)) {
						throw new CustomException(ExceptionConstants.ERROR_REQUEST);
					} else {
						resComVo.setResultCode(ExceptionConstants.ERROR_REQUEST);
						resComVo.setResultMsg(message.getMessage("business.exception." + ExceptionConstants.ERROR_REQUEST));
						model.addAttribute("result", resComVo);
						return model;
					}
				}

				Boolean checkExe = true;
				for (String ex : fileFilter) {
					if (ex.equalsIgnoreCase(exe)) {
						checkExe = false;
					}
				}

				if (checkExe) {
					if (StringUtil.isEmpty(prefixPath)) {
						throw new CustomException(
								uploadType.equals("image") ? ExceptionConstants.BAD_EXE_IMAGE_FILE_EXCEPTION
										:  uploadType.equals("profileimage") ? ExceptionConstants.BAD_EXE_PROFILE_IMAGE_FILE_EXCEPTION //web
												: uploadType.equals("mwebProfileimage") ? ExceptionConstants.ERROR_MEMBER_IN_VALID_PRFL_IMG //mweb
														  :ExceptionConstants.BAD_EXE_FILE_EXCEPTION);
					} else {
						String errCode = uploadType.equals("image") ? ExceptionConstants.BAD_EXE_IMAGE_FILE_EXCEPTION
										:  uploadType.equals("profileimage") ? ExceptionConstants.BAD_EXE_PROFILE_IMAGE_FILE_EXCEPTION //web
												: uploadType.equals("mwebProfileimage") ? ExceptionConstants.ERROR_MEMBER_IN_VALID_PRFL_IMG //mweb
														: ExceptionConstants.BAD_EXE_FILE_EXCEPTION;
						resComVo.setResultCode(errCode);
						resComVo.setResultMsg(message.getMessage("business.exception." + errCode));
						model.addAttribute("result", resComVo);
						return model;
					}
				}

				if (mFile.getSize() > fileSize) {
					if (StringUtil.isEmpty(prefixPath)) {
						throw new CustomException(ExceptionConstants.BAD_SIZE_FILE_EXCEPTION);
					} else {
						resComVo.setResultCode(ExceptionConstants.BAD_SIZE_FILE_EXCEPTION);
						resComVo.setResultMsg(message.getMessage("business.exception." + ExceptionConstants.BAD_SIZE_FILE_EXCEPTION));
						model.addAttribute("result", resComVo);
						return model;
					}
				}

				String fileName = UUID.randomUUID() + "." + exe;
				String baseFilePath = "";
				if (StringUtil.isNotEmpty(prefixPath)) {
					if (!StringUtils.startsWith(prefixPath, FileUtil.SEPARATOR)) {
						prefixPath = FileUtil.SEPARATOR + prefixPath;
					}
					prefixPath = StringUtils.stripEnd(prefixPath, FileUtil.SEPARATOR);
					if (StringUtil.equals("image", uploadType) || StringUtil.equals("jpg", uploadType)) {
						baseFilePath = bizConfig.getProperty("common.nas.base") + File.separator + bizConfig.getProperty("common.nas.base.image") + prefixPath + FileUtil.SEPARATOR + fileName;
					} else {
						baseFilePath = bizConfig.getProperty("common.nas.base") + File.separator + bizConfig.getProperty("common.nas.base.file") + prefixPath + FileUtil.SEPARATOR + fileName;
					}
					
				} else {
					baseFilePath = bizConfig.getProperty("common.file.upload.base") + FileUtil.SEPARATOR
							+ DateUtil.getNowDate() + FileUtil.SEPARATOR + fileName;
				}
				
				baseFilePath = baseFilePath.replaceAll("\\.{2,}[/\\\\]", "");
				File file = new File(baseFilePath);
				if (!file.getParentFile().exists()) {
					file.getParentFile().mkdirs();
				}

				mFile.transferTo(file);
				result = new FileVO();
				result.setFileExe(exe);
				result.setFileName(fileOrgName);
				result.setFileSize(mFile.getSize());
				result.setFileType(mFile.getContentType());
				if (StringUtil.isNotEmpty(prefixPath)) {
					result.setFilePath(prefixPath + FileUtil.SEPARATOR + fileName);
				} else {
					result.setFilePath(baseFilePath);
				}
				results.add(result);
			}

			if (results.size() > 1) {
				model.addAttribute("file", results);
			} else {
				model.addAttribute("file", result);
			}
			if (StringUtil.isNotEmpty(prefixPath)) {
				resComVo.setResultCode(CommonConstants.IMG_UPLOAD_RESULT_SUCCESS);
				resComVo.setResultMsg(message.getMessage("business.com.result.msg.success"));
				model.addAttribute("result", resComVo);
			}
			return model;
		} catch (IllegalStateException | IOException e) {
			log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
			if (StringUtil.isEmpty(prefixPath)) {
				throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
			} else {
				resComVo.setResultCode(ExceptionConstants.ERROR_CODE_DEFAULT);
				resComVo.setResultMsg(message.getMessage("business.exception." + ExceptionConstants.ERROR_CODE_DEFAULT));
				model.addAttribute("result", resComVo);
				return model;
			}
		}
	}

	/**
	 * <pre>
	* - 프로젝트명	: gs-apet-31-front
	* - 파일명	: CommonController.java
	* - 작성일	: 2016. 5. 10.
	* - 작성자	: valfac
	* - 설명		: 공통 파일 업로드
	 * </pre>
	 * 
	 * @param mRequest
	 * @param uploadType
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/fileUploadNcpResult", headers = "content-type=multipart/*", method = RequestMethod.POST)
	public ModelMap fileUploadNcpResult(MultipartHttpServletRequest mRequest,
			@RequestParam("uploadType") String uploadType, @RequestParam("prePath") String prePath) {
		try {
			LogUtil.log(uploadType);

			FileVO vo = nhnObjectStorageUtil.upload(mRequest, uploadType, null, null, prePath);
			ModelMap model = new ModelMap();
			model.addAttribute("file", vo);
			return model;
		} catch (IllegalStateException e) {
			log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
	}

	@RequestMapping("/fileDownloadResult")
	public String fileDownloadResult(ModelMap map, @RequestParam("filePath") String filePath,
			@RequestParam(value = "fileName", required = false) String fileName
			, @RequestParam(value="imgYn", required=false) String imgYn) {

		FtpFileUtil ftpFileUtil = null;
		FtpImgUtil ftpImgUtil = null;

		String newFilePath = null;
		FileViewParam fileView = new FileViewParam();
		try {
			if (StringUtil.isNotEmpty(imgYn) && StringUtils.equals(CommonConstants.COMM_YN_Y, imgYn)) {
				if (StringUtils.equals(bizConfig.getProperty("envmt.gb"), CommonConstants.ENVIRONMENT_GB_LOCAL)) {
					fileView.setFilePath(filePath);
					fileView.setFileName(fileName);
					map.put(CommonConstants.FILE_PARAM_NAME, fileView);
					return CommonConstants.FILE_NCP_VIEW_NAME;
				} else {
					ftpImgUtil = new FtpImgUtil();
					newFilePath = ftpImgUtil.download(filePath);
				}
			} else {
				ftpFileUtil = new FtpFileUtil();
				newFilePath = ftpFileUtil.download(filePath);
			}
		} catch (Exception e) {
			throw new CustomException(ExceptionConstants.ERROR_FILE_NOT_FOUND);
		}

		if (StringUtil.isBlank(fileName)) {
			fileName = FilenameUtils.getName(newFilePath);
		}

		fileView.setFilePath(newFilePath);
		fileView.setFileName(fileName);
		map.put(CommonConstants.FILE_PARAM_NAME, fileView);

		return CommonConstants.FILE_VIEW_NAME;
	}

	@RequestMapping("/fileUrlDownloadResult")
	public String fileUrlDownloadResult(ModelMap map, @RequestParam("filePath") String filePath,
			@RequestParam(value = "fileName", required = false) String fileName) {
		sessionChk();
		FileViewParam fileView = new FileViewParam();

		if (StringUtil.isBlank(fileName)) {
			fileName = FilenameUtils.getName(filePath);
		}

		fileView.setFilePath(filePath);
		fileView.setFileName(fileName);
		map.put(CommonConstants.FILE_PARAM_NAME, fileView);

		return CommonConstants.FILE_URL_VIEW_NAME;
	}

	private void sessionChk() {
		if (!StringUtils.equals(bizConfig.getProperty("envmt.gb"), CommonConstants.ENVIRONMENT_GB_LOCAL)) {
			Session session = FrontSessionUtil.getSession();
			Long mbrNo = Optional.ofNullable(session.getMbrNo()).orElseGet(()->0l);
			
			if(Long.compare(mbrNo,0L)== 0){
				throw new CustomException(ExceptionConstants.TRY_LOGIN_REQUIRED);
			}
		}
	}

	@RequestMapping("/fileNcpDownloadResult")
	public String fileNcpDownloadResult(ModelMap map, @RequestParam("filePath") String filePath,
			@RequestParam(value = "fileName", required = false) String fileName) {
		sessionChk();
		FileViewParam fileView = new FileViewParam();

		if (StringUtil.isBlank(fileName)) {
			fileName = FilenameUtils.getName(filePath);
		}

		fileView.setFilePath(filePath);
		fileView.setFileName(fileName);
		map.put(CommonConstants.FILE_PARAM_NAME, fileView);

		return CommonConstants.FILE_NCP_VIEW_NAME;
	}

	/**
	 * <pre>
	* - 프로젝트명	: gs-apet-31-front
	* - 파일명	: CommonController.java
	* - 작성일	: 2016. 5. 19.
	* - 작성자	: jangjy
	* - 설명		: 공통 Select Ajax 뷰어
	 * </pre>
	 * 
	 * @param model
	 * @param so
	 * @return
	 */
	@RequestMapping("/codeSelectView")
	public String codeSelectView(ModelMap model, CodeDetailSO so) {

		model.put("codeSelectList", this.cacheService.listCodeCache(so.getGrpCd(), so.getUsrDfn1Val(),
				so.getUsrDfn2Val(), so.getUsrDfn3Val(), so.getUsrDfn4Val(), so.getUsrDfn5Val()));

		return TilesView.none(new String[] { "common", "codeSelectView" });
	}

	/**
	 * <pre>
	* - 프로젝트명	: gs-apet-31-front
	* - 파일명		: CommonController.java
	* - 작성일		: 2016. 6. 26.
	* - 작성자		: hjko
	* - 설명		:  팝업
	 * </pre>
	 * 
	 * @param map
	 * @param view
	 * @param so
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "popupCommon")
	public String popupCommon(ModelMap map, ViewBase view, @RequestParam Long popupNo) {

		PopupSO pso = new PopupSO();
		String stGbCd = "10";// CommonConstants.SHOW_GB_10;

		pso.setStId(view.getStId());
		pso.setStGbCd(stGbCd); // 사이트 구분 10:공통 20:A, 30:B
		pso.setSvcGbCd(view.getSvcGbCd()); // 서비스 구분코드 pc/mb
		pso.setPopupNo(popupNo);

		List<PopupVO> pvo = popupService.listPopupFO(pso);
		if (CollectionUtils.isNotEmpty(pvo)) {
			map.put("popup", pvo.get(0));
			view.setTitle(pvo.get(0).getPopupNm());
		}
		map.put("view", view);
		return TilesView.popup(new String[] { "common", "common", "popupCommon" });
	}

	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-31-front
	 * - 패키지명   	: front.web.view.common.controller
	 * - 파일명		: CommonController.java
	 * - 작성일		: 2020. 12. 30.
	 * - 작성자		: LDS
	 * - 설명			: 네이버지도 주소검색 API 호출(지번, 도로명으로 주소 세부정보를 검색)
	 * </pre>
	 *
	 * @param model
	 * @param       srchText-주소
	 * @param       lat-기준 좌표(위도)
	 * @param       lon-기준 좌표(경도)
	 * @return
	 */
	@RequestMapping("searchNaverMapGoApi")
	@ResponseBody
	public ModelMap searchNaverMapGoApi(@RequestParam(value = "srchText") String srchText,
			@RequestParam(value = "lat", required = false) String lat,
			@RequestParam(value = "lon", required = false) String lon) {
		ModelMap map = new ModelMap();

		map.put("resBody", naverMapUtil.geocoding(srchText, lat, lon));

		return map;
	}

	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-31-front
	 * - 패키지명   	: front.web.view.common.controller
	 * - 파일명		: CommonController.java
	 * - 작성일		: 2020. 12. 30.
	 * - 작성자		: LDS
	 * - 설명			: 네이버지도 주소검색 API 호출(좌표에 해당하는 법정동/행정동/지번주소/도로명주소 정보 조회)
	 * </pre>
	 *
	 * @param model
	 * @param       srchText-주소
	 * @param       lat-기준 좌표(위도)
	 * @param       lon-기준 좌표(경도)
	 * @return
	 */
	@RequestMapping("searchNaverMapGcApi")
	@ResponseBody
	public ModelMap searchNaverMapGcApi(@RequestParam(value = "lat") String lat,
			@RequestParam(value = "lon") String lon) {

		ModelMap map = new ModelMap();

		map.put("resBody", naverMapUtil.coordToAddr(lat, lon));

		return map;
	}

	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-31-front
	 * - 파일명		: front.web.view.common.controller
	 * - 작성일		: 2021. 01. 22.
	 * - 파일명		: CommonController.java
	 * - 작성자		: KKB
	 * - 설명		: 클릭 이벤트 테스트 전송
	 * </pre>
	 * 
	 * @param SearchEventPO
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/sendSearchEngineEvent")
	public String sendSearchEvent(SearchEngineEventPO po) {
		Session session = FrontSessionUtil.getSession();
		po.setMbr_no(String.valueOf(session.getMbrNo()));
		return bizService.sendClickEventToSearchEngineServer(po);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-31-front
	 * - 파일명		: front.web.view.common.controller
	 * - 작성일		: 2021. 01. 25.
	 * - 파일명		: CommonController.java
	 * - 작성자		: KKB
	 * - 설명		: PC / MO 구분 변경
	 * </pre>
	 * 
	 * @param returnUrl
	 * @param deviceGb
	 * @return view
	 */
	@RequestMapping("/chgDeviceGb")
	public String chgDeviceGb(String returnUrl, String deviceGb) {
		if (CommonConstants.DEVICE_GB_10.equalsIgnoreCase(deviceGb)) {
			CookieSessionUtil.createCookie(CommonConstants.DEVICE_GB, CommonConstants.DEVICE_GB_10);
		} else if (CommonConstants.DEVICE_GB_20.equalsIgnoreCase(deviceGb)) {
			CookieSessionUtil.createCookie(CommonConstants.DEVICE_GB, CommonConstants.DEVICE_GB_20);
		}
		return "redirect:" + returnUrl;
	}

	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-31-front
	 * - 파일명		: front.web.view.common.controller
	 * - 작성일		: 2021. 01. 25.
	 * - 파일명		: CommonController.java
	 * - 작성자		: KSH
	 * - 설명		: SGR api ivKey
	 * </pre>
	 * 
	 * @return String ivKey
	 */
	@ResponseBody
	@RequestMapping(value = "getSgrAk")
	public String getSgrAk() throws Exception {
		return SgrCryptoUtil.getAuthKey();
	}

	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-31-front
	 * - 파일명		: front.web.view.common.controller
	 * - 작성일		: 2021. 01. 25.
	 * - 파일명		: CommonController.java
	 * - 작성자		: KKB
	 * - 설명		: 본인 인증 팝업
	 * </pre>
	 * 
	 * @param deviceGb
	 * @return view
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("/okCertPop")
	public String okCertPop(HttpServletRequest request, ModelMap map, String popup, HttpSession session,
			String rqstCausCd, String mbrNo) {
		/**
		 * 1) phone_popup1: 팝업창을 띄우는 바닥페이지 역할. phone_popup2를 팝업으로 띄워준다. 2) phone_popup2:
		 * 모듈을 이용해 KCB Gateway와 통신 후, 연동용 정보(모듈토큰 등)로 인증창을 호출한다. 3) 인증창: 사용자가 실질적으로 인증을
		 * 수행하는 KCB의 인증팝업창. 인증이 성공 또는 실패되면 리턴 URL로 연동용 정보를 전달하고 종료된다. 4) phone_popup3:
		 * 리턴URL역할. 인증창에게 연동용 정보를 받고 모듈을 이용해 KCB Gateway와 통신 후, phone_popup1의
		 * form(kcbResultForm)에 값을 넣어주고 phone_popup4을 호출한다. 5) phone_popup4: 인증 결과를 표시한다
		 */
		
		if (popup == null || popup.equals("phone_popup1")) {
			//보안 진단. 부적절한 자원 해제 (IO)
			OutputStreamWriter output = null;
			try {
				output = new OutputStreamWriter(System.out);
				map.put("defaultEncoding", java.util.Locale.getDefault());
				map.put("fileEncoding", System.getProperty("file.encoding"));
				map.put("outEncoding", output.getEncoding());
				map.put("RQST_CAUS_CD", rqstCausCd); // 00:회원가입, 01:성인인증, 02:회원정보 수정, 03:비밀번호 찾기, 04:상품구매, 99:기타)
				return "common/okcert/phone_popup1";
			} catch (Exception e) {
				// 보안성 진단. 오류메시지를 통한 정보노출
				log.error("OKCERT ERROR :" , e);
				//e.printStackTrace();
			} finally {
				try {
					if(output != null) {
						output.close();
					}
				} catch (IOException e2) {
					log.error("okCertPop ERROR :",e2);
					e2.printStackTrace();
				}
			}
			
		} else if (popup.equals("phone_popup2")) {
			try {
				request.setCharacterEncoding("UTF-8");
			} catch (UnsupportedEncodingException e) {
				// 보안성 진단. 오류메시지를 통한 정보노출
				log.error("OKCERT ERROR :", e);
				//e.printStackTrace();
			}
			String SITE_NAME = bizConfig.getProperty("kcb.okcert.site_name"); // 요청사이트명
			String SITE_URL = bizConfig.getProperty("kcb.okcert.site_url");
			String CP_CD = bizConfig.getProperty("kcb.okcert.cp_cd"); // 회원사코드
			session.setAttribute("PHONE_CP_CD", CP_CD);
			String RETURN_URL = "https://" + request.getServerName() + ":443/common/okCertPop?popup=phone_popup3&mbrNo=" + mbrNo;// 인증 완료 후 리턴될 URL (도메인 포함 full path)
			if (StringUtil.equals(bizConfig.getProperty("envmt.gb"), CommonConstants.ENVIRONMENT_GB_LOCAL)) {
				RETURN_URL = "http://" + request.getServerName() + ":" + request.getServerPort() + "/common/okCertPop?popup=phone_popup3&mbrNo=" + mbrNo;
			}
			String RQST_CAUS_CD = rqstCausCd; // 00:회원가입, 01:성인인증, 02:회원정보 수정, 03:비밀번호 찾기, 04:상품구매, 99:기타
			// String CHNL_CD = request.getParameter("CHNL_CD"); // 채널 코드
			// String RETURN_MSG = ""; // 리턴메시지
			String target = bizConfig.getProperty("kcb.okcert.target"); // 테스트="TEST", 운영="PROD" : 휴대폰은 운영계만 운영
			String popupUrl = "https://safe.ok-name.co.kr/CommonSvl";// 운영 URL
			String svcName = "IDS_HS_POPUP_START";
			String thisRootPath = this.getClass().getResource("/").getPath();
			String pathStr = "/WEB-INF/";
			String subStringPath = thisRootPath.substring(0, thisRootPath.lastIndexOf(pathStr));
			String license = subStringPath + bizConfig.getProperty("kcb.okcert.license") + CP_CD + "_IDS_01_" + target
					+ "_AES_license.dat";

			JSONObject reqJson = new JSONObject();
			reqJson.put("RETURN_URL", RETURN_URL);
			reqJson.put("SITE_NAME", SITE_NAME);
			reqJson.put("SITE_URL", SITE_URL);
			reqJson.put("RQST_CAUS_CD", RQST_CAUS_CD);
			// reqJson.put("CHNL_CD", CHNL_CD);
			// reqJson.put("RETURN_MSG", RETURN_MSG);

			// ' 거래일련번호는 기본적으로 모듈 내에서 자동 채번되고 채번된 값을 리턴해줌.
			// ' 회원사가 직접 채번하길 원하는 경우에만 아래 코드를 주석 해제 후 사용.
			// ' 각 거래마다 중복 없는 String 을 생성하여 입력. 최대길이:20
			// reqJson.put("TX_SEQ_NO", "123456789012345");

			String reqStr = reqJson.toString();

			kcb.module.v3.OkCert okcert = new kcb.module.v3.OkCert();
			// ' callOkCert 메소드호출 : String license 파일 path로 라이센스 로드
			String resultStr = null;
			try {
				resultStr = okcert.callOkCert(target, CP_CD, svcName, license, reqStr);
			} catch (OkCertException e) {
				// 보안성 진단. 오류메시지를 통한 정보노출
				log.error("OKCERT ERROR :", e);
				//e.printStackTrace();
			}

			JSONObject resJson = new JSONObject(resultStr);

			String RSLT_CD = resJson.getString("RSLT_CD");
			String RSLT_MSG = resJson.getString("RSLT_MSG");
			// if(resJson.has("TX_SEQ_NO")) String TX_SEQ_NO =
			// resJson.getString("TX_SEQ_NO"); // 필요 시 거래 일련 번호 에 대하여 DB저장 등의 처리
			String MDL_TKN = "";

			boolean succ = false;

			if ("B000".equals(RSLT_CD) && resJson.has("MDL_TKN")) {
				MDL_TKN = resJson.getString("MDL_TKN");
				succ = true;
			}
			map.put("RSLT_CD", RSLT_CD);
			map.put("RSLT_MSG", RSLT_MSG);
			map.put("popupUrl", popupUrl);
			map.put("CP_CD", CP_CD);
			map.put("MDL_TKN", MDL_TKN);
			map.put("succ", succ);

			return "common/okcert/phone_popup2";
		} else if (popup != null && popup.equals("phone_popup3")) {
			// ' 처리결과 모듈 토큰 정보
			String MDL_TKN = request.getParameter("mdl_tkn");
			// ' KCB로부터 부여받은 회원사코드(아이디) 설정 (12자리)
			String CP_CD = (String) session.getAttribute("PHONE_CP_CD");
			String target = bizConfig.getProperty("kcb.okcert.target"); // 테스트="TEST", 운영="PROD"
			String svcName = "IDS_HS_POPUP_RESULT";
			String thisRootPath = this.getClass().getResource("/").getPath();
			String pathStr = "/WEB-INF/";
			String subStringPath = thisRootPath.substring(0, thisRootPath.lastIndexOf(pathStr));
			String license = subStringPath + bizConfig.getProperty("kcb.okcert.license") + CP_CD + "_IDS_01_" + target
					+ "_AES_license.dat";
			JSONObject reqJson = new JSONObject();

			reqJson.put("MDL_TKN", MDL_TKN);
			String reqStr = reqJson.toString();
			kcb.module.v3.OkCert okcert = new kcb.module.v3.OkCert();
			String resultStr = null;
			try {
				resultStr = okcert.callOkCert(target, CP_CD, svcName, license, reqStr);
			} catch (OkCertException e) {
				// 보안성 진단. 오류메시지를 통한 정보노출
				log.error("OKCERT ERROR :", e);
				//e.printStackTrace();
			}
			JSONObject resJson = new JSONObject(resultStr);

			String RSLT_CD = resJson.getString("RSLT_CD");
			String RSLT_MSG = resJson.getString("RSLT_MSG");
			String TX_SEQ_NO = resJson.getString("TX_SEQ_NO");

			String RSLT_NAME = "";
			String RSLT_BIRTHDAY = "";
			String RSLT_SEX_CD = "";
			String RSLT_NTV_FRNR_CD = "";

			String DI = "";
			String CI = "";
			String CI_UPDATE = "";
			String TEL_COM_CD = "";
			String TEL_NO = "";

			String RETURN_MSG = "";
			if (resJson.has("RETURN_MSG")) {
				RETURN_MSG = resJson.getString("RETURN_MSG");
			}

			if ("B000".equals(RSLT_CD)) {
				RSLT_NAME = resJson.getString("RSLT_NAME");
				RSLT_BIRTHDAY = resJson.getString("RSLT_BIRTHDAY");
				RSLT_SEX_CD = resJson.getString("RSLT_SEX_CD");
				RSLT_NTV_FRNR_CD = resJson.getString("RSLT_NTV_FRNR_CD");

				DI = resJson.getString("DI");
				CI = resJson.getString("CI");
				CI_UPDATE = resJson.getString("CI_UPDATE");
				TEL_COM_CD = resJson.getString("TEL_COM_CD");
				TEL_NO = resJson.getString("TEL_NO");
			}
			map.put("CP_CD", CP_CD);
			map.put("TX_SEQ_NO", TX_SEQ_NO);
			map.put("RSLT_CD", RSLT_CD);
			map.put("RSLT_MSG", RSLT_MSG);
			map.put("RSLT_NAME", RSLT_NAME);
			map.put("RSLT_BIRTHDAY", RSLT_BIRTHDAY);
			map.put("RSLT_SEX_CD", RSLT_SEX_CD);
			map.put("RSLT_NTV_FRNR_CD", RSLT_NTV_FRNR_CD);
			map.put("DI", DI);
			map.put("CI", CI);
			map.put("CI_UPDATE", CI_UPDATE);
			map.put("TEL_COM_CD", TEL_COM_CD);
			map.put("TEL_NO", TEL_NO);
			map.put("RETURN_MSG", RETURN_MSG);

			// 인증로그 등록 210203 leejh
			if ("B000".equals(RSLT_CD)) {
				Long ctfLogNo = this.bizService.getSequence(CommonConstants.SEQUENCE_MEMBER_CERTIFIED_LOG_SEQ);
				MemberCertifiedLogPO certpo = new MemberCertifiedLogPO();
				certpo.setCtfLogNo(ctfLogNo);
				certpo.setCtfMtdCd(FrontConstants.CTF_MTD_MOBILE);
				// certpo.setCtfTpCd(FrontConstants.CTF_TP_JOIN);
				certpo.setCiCtfVal(CI);
				certpo.setDiCtfVal(DI);
				certpo.setCtfRstCd(RSLT_CD);
				if (mbrNo == null || mbrNo.equals("") || mbrNo.equals("undefined")) {
					if(SessionUtil.getAttribute(FrontConstants.SESSION_LOGIN_MBR_NO) != null) {
						mbrNo = SessionUtil.getAttribute(FrontConstants.SESSION_LOGIN_MBR_NO).toString();
					}else {
						mbrNo = "0";
					}
				}
				certpo.setMbrNo(Long.parseLong(mbrNo));
				certpo.setSysRegrNo(FrontSessionUtil.getSession().getMbrNo() > 0 ? FrontSessionUtil.getSession().getMbrNo()
						: Long.parseLong(mbrNo));
				memberService.insertCertifiedLog(certpo);
	
				map.put("LOG_NO", certpo.getCtfLogNo());
			}

			return "common/okcert/phone_popup3";
		}
//			else if(popup != null && popup.equals("phone_popup4")) {
//			try {
//				request.setCharacterEncoding("UTF-8");
//			} catch (UnsupportedEncodingException e) {
//				log.error("OKCERT ERROR :"+e.toString());
//				e.printStackTrace();
//			} 
//
//			/* 공통 리턴 항목 */
//			String CP_CD		= request.getParameter("CP_CD");					// 고객사코드
//			String TX_SEQ_NO	= request.getParameter("TX_SEQ_NO");				// 거래번호
//			String RSLT_CD		= request.getParameter("RSLT_CD");					// 결과코드
//			String RSLT_MSG	= request.getParameter("RSLT_MSG");					// 결과메세지(UTF-8)
//			
//			String RSLT_NAME		= request.getParameter("RSLT_NAME");			// 성명(UTF-8)
//			String RSLT_BIRTHDAY	= request.getParameter("RSLT_BIRTHDAY");		// 생년월일
//			String RSLT_SEX_CD 		= request.getParameter("RSLT_SEX_CD");			// 성별코드* 성별 - M:남, F:여
//			String RSLT_NTV_FRNR_CD = request.getParameter("RSLT_NTV_FRNR_CD");		// 내외국인 구분* 내외국인구분 - L:내국인, F:외국인
//			
//			String DI = request.getParameter("DI");							// DI 값
//			String CI = request.getParameter("CI");							// CI 값 (CI_UPDATE가 홀수일 경우 사용)
//			String CI_UPDATE = request.getParameter("CI_UPDATE");			// CI 업데이트 횟수 (현재 ‘1’ 로 고정임)
//			String TEL_COM_CD = request.getParameter("TEL_COM_CD");			// 통신사코드* 통신사 - 01:SKT, 02:KT, 03:LGU+, 04:SKT알뜰폰, 05:KT알뜰폰, 06:LGU+알뜰폰
//			String TEL_NO = request.getParameter("TEL_NO");					// 휴대폰번호
//			
//			String RETURN_MSG = request.getParameter("RETURN_MSG");			// 리턴메시지
//			
//			map.put("CP_CD", CP_CD);
//			map.put("TX_SEQ_NO", TX_SEQ_NO);
//			map.put("RSLT_CD", RSLT_CD);
//			map.put("RSLT_MSG", RSLT_MSG);
//			
//			map.put("RSLT_NAME", RSLT_NAME);
//			map.put("RSLT_BIRTHDAY", RSLT_BIRTHDAY);
//			map.put("RSLT_SEX_CD", RSLT_SEX_CD);
//			map.put("RSLT_NTV_FRNR_CD", RSLT_NTV_FRNR_CD);
//			
//			map.put("DI", DI);
//			map.put("CI", CI);
//			map.put("CI_UPDATE", CI_UPDATE);
//			map.put("TEL_COM_CD", TEL_COM_CD);
//			map.put("TEL_NO", TEL_NO);
//			
//			map.put("RETURN_MSG", RETURN_MSG);
//			
//			return "common/okcert/phone_popup4";
//		}
		return "common/okcert/phone_popup1";
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-31-front
	 * - 파일명		: CommonController.java
	 * - 작성일		: 2021. 2. 23.
	 * - 작성자		: DSLEE
	 * - 설명			: App Api > 최신 앱버전 정보조회
	 * </pre>
	 * 
	 * @param mRequest
	 * @param uploadType
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "checkAppVersion")
	public ModelMap checkAppVersion(@RequestParam("mobileOs") String mobileOs) {
		ModelMap model = new ModelMap();
		ResponseCommonVO resComVo = new ResponseCommonVO();
		
		try {
			LogUtil.log(mobileOs);
			
			//최신 앱버전 정보 조회
			MobileVersionSO so = new MobileVersionSO();
			so.setMobileOs(mobileOs);
			MobileVersionAppVO vo = mobileVersionService.selectNewMobileVersionInfo(so);
			if(vo != null) {
				model.addAttribute("versionInfo", vo);
				
				resComVo.setResultCode(CommonConstants.IMG_UPLOAD_RESULT_SUCCESS);
				resComVo.setResultMsg(message.getMessage("business.nice.checkplus.check.msg.0"));
				model.addAttribute("result", resComVo);
			}else {
				resComVo.setResultCode(ExceptionConstants.ERROR_PARAM);
				resComVo.setResultMsg(message.getMessage("business.exception." + ExceptionConstants.ERROR_PARAM));
				model.addAttribute("result", resComVo);
			}
			
			return model;
		} catch (IllegalStateException e) {
			/*log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);*/
			
			resComVo.setResultCode(ExceptionConstants.ERROR_CODE_DEFAULT);
			resComVo.setResultMsg(message.getMessage("business.exception." + ExceptionConstants.ERROR_CODE_DEFAULT));
			model.addAttribute("result", resComVo);
			return model;
		}
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-31-front
	 * - 파일명		: CommonController.java
	 * - 작성일		: 2021. 3. 9.
	 * - 작성자		: KSH
	 * - 설명			: 닉네임으로 검색
	 * </pre>
	 * 
	 * @param nickNm
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "getNickNameList")
	public ModelMap getNickNameList(@RequestParam("nickNm") String nickNm) {
		sessionChk();
		ModelMap model = new ModelMap();
		List<MemberBaseVO> nickNameList = memberService.getNickNameList(nickNm);
		model.addAttribute("list", nickNameList);
		return model;
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-31-front
	 * - 파일명		: CommonController.java
	 * - 작성일		: 2021. 3. 12.
	 * - 작성자		: hjh
	 * - 설명			: 닉네임으로 회원 번호, 펫로그 URL 조회
	 * </pre>
	 * 
	 * @param nickNm
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "getMentionInfo")
	public ModelMap getMentionInfo(@RequestParam("nickNm") String nickNm) {
		ModelMap model = new ModelMap();
		MemberBaseVO mentionInfo = memberService.getMentionInfo(nickNm);
		model.addAttribute("info", mentionInfo);
		return model;
	}

	//현재 사용 안함 -> 점유 인증 하기 전, ci 값 있는지 확인 하는 로직. 추후 적용 가능 농후 2021.04.29 - 김재윤. 적용 안될 시 삭제 예정
	@ResponseBody
	@RequestMapping(value="check" , method = RequestMethod.POST)
	public Map check(MemberBaseSO so){
		MemberBaseVO v = memberService.getMemberBase(so);
		Map<String,String> resultMap = new HashMap<String,String>();
		resultMap.put("gb",v.getMbrGbCd());
		resultMap.put("isCiCtfYn",StringUtil.isNotEmpty(Optional.ofNullable(v.getCiCtfVal()).orElseGet(()->"")) ? CommonConstants.COMM_YN_Y : CommonConstants.COMM_YN_N);
		return resultMap;
	}


	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-31-front
	 * - 파일명		: CommonController.java
	 * - 작성일		: 2021. 04. 16.
	 * - 작성자		: kjy
	 * - 설명			: 점유 인증 위한 jsp 및 핸드폰 번호
	 * </pre>
	 *
	 * @return
	 */
	@RequestMapping(value="opt" , method = RequestMethod.GET)
	public String getMemberOpt(Model model,String mobile){
		model.addAttribute("mobile",mobile);
		return "/common/common/mobileOpt";
	}

	@ResponseBody
	@RequestMapping(value="generate" , method=RequestMethod.POST)
	public String optCertKeyGenerate(String mobile){
		String certKey = StringUtil.randomNumeric(6);
		String encCertKey = bizService.twoWayEncrypt(certKey);
		Integer sec = CommonConstants.OPT_EXPIRE_MINUTE * 60;
		Long expire = DateUtil.addSeconds(DateUtil.getTimestamp(),sec).getTime(); // expire 시간

		CookieSessionUtil.createCookie("ck",encCertKey);
		CookieSessionUtil.createCookie("ct",bizService.twoWayEncrypt(expire.toString()));

		Long mbrNo = Long.parseLong(bizService.twoWayDecrypt(CookieSessionUtil.getCookie("mbrNo")));
		memberService.sendCertLms(mbrNo,mobile,certKey);
		return sec.toString();
	}

	@ResponseBody
	@RequestMapping(value="verify",method = RequestMethod.POST)
	public String cert(String ctfKey){
		String result = CommonConstants.CONTROLLER_RESULT_CODE_FAIL;
		String encCtfKey = CookieSessionUtil.getCookie("ck");
		String orgCtfKey = bizService.twoWayDecrypt(encCtfKey);

		Long expire = Long.parseLong(bizService.twoWayDecrypt(CookieSessionUtil.getCookie("ct")));

		try{
			Long now = DateUtil.getTimestamp().getTime();
			if(Long.compare(now,expire) >= 0){
				throw new CustomException(ExceptionConstants.ERROR_OVERTIME_CERT);
			}
			if(!StringUtil.equals(ctfKey,orgCtfKey)){
				throw new CustomException(ExceptionConstants.ERROR_INVALID_CERT_KEY);
			}
			result = CommonConstants.CONTROLLER_RESULT_CODE_SUCCESS;
			CookieSessionUtil.createCookie("cyn",bizService.oneWayEncrypt(CommonConstants.COMM_YN_Y));
		}catch(CustomException cep){
			CookieSessionUtil.createCookie("cyn",bizService.oneWayEncrypt(CommonConstants.COMM_YN_N));
			result = message.getMessage("business.exception." + cep.getExCode());
		}

		return result;
	}
	
	@ResponseBody
	@RequestMapping(value="V/zqWCJfhpFwx5vCb78hyg==", method=RequestMethod.POST)
	public String reloadCode(HttpServletRequest request){
		String result = null;
		if (StringUtil.isNotEmpty(request.getHeader("iv_key"))) {
			try {
				String header = SgrCryptoUtil.decrypt(request.getHeader("iv_key"));
				int diff = (int) TimeUnit.MILLISECONDS.toMinutes(DateUtil.getTimestamp().getTime() - DateUtil.getTimestamp(header.split("\\|")[2], "yyyyMMddHHmmss").getTime());
				if (-5 < diff && 5 > diff) {
					String gb = request.getHeader("reloadGb");
					if (StringUtil.isEmpty(gb) || StringUtil.equals("10", gb)) {
						this.cacheService.listCodeCacheRefresh();
						result = "success";
					} else if (StringUtil.equals("20", gb)) {
						Long stId = Long.valueOf(this.webConfig.getProperty("site.id"));
						this.cacheService.listDisplayCategoryCacheRefresh(stId);
						result = "success";
					} else {
						result = "no mapping";
					}
				} else {
					result = "unauthorized";
				}
			} catch (Exception e1) {
				log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e1);
				result = "decryption error";
			}

		} else {
			result = "no header";
		}
		
		return result;
	}

	@ResponseBody
	@RequestMapping(value={"/check-nickNm","/check-id" , "/check-email","/check-rcom"} , method = RequestMethod.POST)
	public Integer duplicateCheck(MemberBaseSO so){
		so.setMbrNo(FrontSessionUtil.getSession().getMbrNo());
		return memberService.getDuplicateChcekWhenBlur(so);
	}

	@ResponseBody
	@RequestMapping(value="/init-code" , method = RequestMethod.POST)
	public String initListCodeCache(){
		log.debug("=====================================================");
		log.debug("= {}", "cache Init");
		log.debug("=====================================================");
		cacheService.listCodeCache();
		return "";
	}
	
	@ResponseBody
	@RequestMapping(value="/initCache" , method = RequestMethod.GET)
	public String initCache(){
		log.debug("=====================================================");
		log.debug("= {}", "cache Init All");
		log.debug("=====================================================");
		cacheService.initApetCache();
		return "";
	}	

	@ResponseBody
	@RequestMapping(value="check-banWord", method = RequestMethod.POST)
	public ModelMap banWord(MemberBaseSO so) {
		ModelMap map = new ModelMap();
		//금지어체크
		TagBaseSO tagso = new TagBaseSO();
		List<TagBaseVO> taglist = tagService.unmatchedGrid(tagso);
		for(TagBaseVO banTag : taglist) {
			if(!StringUtil.isEmpty(so.getLoginId()) && so.getLoginId().indexOf(banTag.getTagNm()) > -1) {
				map.put("returnCode", "banWord");
				return map;
			}
			if(!StringUtil.isEmpty(so.getNickNm()) && so.getNickNm().indexOf(banTag.getTagNm()) > -1) {
				map.put("returnCode", "banWord");
				return map;
			}
		}
		
		map.put("returnCode", "");
		return map;
	}
	
	/**
	 * <pre>
	* - 프로젝트명	: gs-apet-31-front
	* - 파일명	: CommonController.java
	* - 작성일	: 2021. 07. 01.
	* - 작성자	: KKB
	* - 설명	: 잘못된 접근시 노출 페이지
	* </pre>
	* 
	* @param type
	* @return
	*/
	@RequestMapping("/wrongAprch")
	public String wrongAprch(ModelMap map, String type) {
		map.put("type", type);
		return "/common/exception/wrongAprch";
	}
	
}
