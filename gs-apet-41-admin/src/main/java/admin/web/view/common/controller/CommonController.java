package admin.web.view.common.controller;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.*;
import java.util.concurrent.TimeUnit;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;

import biz.app.system.model.*;
import biz.app.system.service.*;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.google.common.io.CharStreams;

import admin.web.config.grid.GridResponse;
import admin.web.config.view.View;
import admin.web.view.common.model.MemberParam;
import admin.web.view.common.model.UserParam;
import biz.app.company.model.CompanySO;
import biz.common.model.PushTargetPO;
import biz.common.model.SendPushPO;
import biz.common.model.SgrPushVO;
import biz.common.service.BizService;
import biz.interfaces.nicepay.constants.NicePayConstants;
import biz.interfaces.nicepay.model.request.data.CheckBankAccountReqVO;
import biz.interfaces.nicepay.model.response.data.CheckBankAccountResVO;
import biz.interfaces.nicepay.service.NicePayCommonService;
import framework.admin.constants.AdminConstants;
import framework.admin.model.Session;
import framework.admin.util.AdminSessionUtil;
import framework.admin.util.LogUtil;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import framework.common.model.FileVO;
import framework.common.model.FileViewParam;
import framework.common.model.HistorySO;
import framework.common.util.ClassUtil;
import framework.common.util.DateUtil;
import framework.common.util.FileUtil;
import framework.common.util.FtpFileUtil;
import framework.common.util.FtpImgUtil;
import framework.common.util.NaverMapUtil;
import framework.common.util.NhnObjectStorageUtil;
import framework.common.util.SgrCryptoUtil;
import framework.common.util.StringUtil;
import framework.common.util.TwcCryptoUtil;
import framework.front.constants.FrontConstants;
import lombok.extern.slf4j.Slf4j;
import net.minidev.json.JSONUtil;
import net.sf.json.util.JSONUtils;

/**
 * <pre>
 * - 프로젝트명	: 41.admin.web
 * - 패키지명		: admin.web.view.common.controller
 * - 파일명		: CommonController.java
 * - 작성자		: valueFactory
 * - 설명			: 공통
 * </pre>
 */
@Slf4j
@Controller
public class CommonController {

	@Autowired
	private Properties bizConfig;
	
	@Autowired
	private Properties webConfig;

	/**
	 * 사용자 서비스
	 */
	@Autowired
	private UserService userService;

	@Autowired
	private UserMessageService userMessageService;

	@Autowired
	private MenuService menuService;

	@Autowired
	private AuthService authService;
	
	@Autowired
	private NaverMapUtil naverMapUtil;
	
	@Autowired
	private NhnObjectStorageUtil nhnObjectStorageUtil;
	
	@Autowired
	private TwcCryptoUtil twcCryptoUtil;
	
	@Autowired
	private NicePayCommonService nicePayCommonService;
	
	@Autowired private MessageSourceAccessor message;
	
	@Autowired
	private BizService bizService;

	@Autowired
	private PrivacyCnctService privacyCnctService;
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: CommonController.java
	 * - 작성일		: 2016. 5. 11.
	 * - 작성자		: valueFactory
	 * - 설명		: 에러 화면
	 * </pre>
	 * @return
	 */
	@RequestMapping("/common/error.do")
	public String error() {
		return View.errorView();
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: CommonController.java
	 * - 작성일		: 2016. 3. 23.
	 * - 작성자		: valueFactory
	 * - 설명		: 공통 이미지 뷰어(임시 파일 업로드)
	 * </pre>
	 * @param map
	 * @param filePath
	 * @return
	 */
	@RequestMapping("/common/imageView.do")
	public String imageView(ModelMap map, @RequestParam("filePath") String filePath) {
		FileViewParam fileView = new FileViewParam();
		fileView.setFilePath(filePath);
		String[] rootPathArr = {bizConfig.getProperty("common.nas.base") + FileUtil.SEPARATOR + bizConfig.getProperty("common.nas.base.image")
								,bizConfig.getProperty("common.file.upload.base")};
		fileView.setRootPath(rootPathArr);
		map.put(AdminConstants.FILE_PARAM_NAME, fileView);
		return View.imageView();
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: CommonController.java
	 * - 작성일		: 2016. 3. 23.
	 * - 작성자		: valueFactory
	 * - 설명		: 공통 파일 업로드
	 * </pre>
	 * @param model
	 * @param mRequest
	 * @param uploadType
	 * @return
	 */
	@RequestMapping("/common/fileUploadResult.do")
	public String fileUploadResult (Model model
		, MultipartHttpServletRequest mRequest
		, @RequestParam("uploadType") String uploadType
		, @RequestParam(value="filter", required=false) String filter
		, @RequestParam(value="maxFileSize", required=false) Double maxFileSize) {
		try {
			LogUtil.log(uploadType);

			FileVO result = new FileVO();
			Iterator<String> fileIter = mRequest.getFileNames();
			while (fileIter.hasNext()) {
				MultipartFile mFile = mRequest.getFile(fileIter.next());
				String fileOrgName = mFile.getOriginalFilename();
				String exe = FilenameUtils.getExtension(fileOrgName);

				String[] fileFilter = null;
				
				if(StringUtil.isNotBlank(filter)) {
					fileFilter = filter.split("\\|");
				} else {
					if(StringUtil.isNotBlank(uploadType)) {
						if("image".equals(uploadType)) {
							fileFilter = "jpg,jpeg,png,gif,svg,bmp".split(",");
							//이미지 업로드 시 15MB 제한
							maxFileSize = Optional.ofNullable(maxFileSize).orElse(15D);
						}
						if("file".equals(uploadType)) {
							fileFilter = "jpg,jpeg,png,gif,bmp,txt,pdf,hwp,xls,xlsx".split(",");
						}
						if("xls".equals(uploadType)) {
							fileFilter = "xls,xlsx".split(",");
						}
						if("imageFile".equals(uploadType)) {
							fileFilter = "jpg,jpeg,png,gif".split(",");
							maxFileSize = Optional.ofNullable(maxFileSize).orElse(15D);
						}
					}
				}

				if(fileFilter == null || fileFilter.length == 0 || mFile.getOriginalFilename().indexOf("%00") >0 || mFile.getOriginalFilename().indexOf("0x00") >0) {
					throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
				}
				/*
				 * TODO : 파일 크기 제한 정책 반영 필요.
				 * 각 파일 형식에 따라 제한 필요, xxx.x 까지 크기 표시
				 * 이미지 5MB 제한
				 * 지정 안했을 경우 20MB
				 * */
				maxFileSize = Optional.ofNullable(maxFileSize).orElse(20D);
				Long maxSize = (long)(maxFileSize * 1024 * 1024);

				Boolean checkExe = true;
				for(String ex : fileFilter){
					if(ex.equalsIgnoreCase(exe)){
						checkExe = false;
					}
				}

				if(checkExe){
					throw new CustomException(ExceptionConstants.BAD_EXE_FILE_EXCEPTION);
				}

				if(mFile.getSize() > maxSize) {
					 throw new CustomException(ExceptionConstants.BAD_SIZE_FILE_EXCEPTION, new String[] {String.format("%.1f", maxFileSize).concat("MB")}) ;
				}

				String fileName = UUID.randomUUID() + "." + exe;
				String filePath = bizConfig.getProperty("common.file.upload.base") + AdminConstants.TEMP_IMAGE_PATH + FileUtil.SEPARATOR + DateUtil.getNowDate() + FileUtil.SEPARATOR;
				File file = new File(filePath + fileName);
				if (!file.getParentFile().exists()) {
					file.getParentFile().mkdirs();
				}

				mFile.transferTo(file);
				result.setFileExe(exe);
				result.setFileName(fileOrgName);
				result.setFileSize(mFile.getSize());
				result.setFileType(mFile.getContentType());
				result.setFilePath(filePath + fileName);
			}
			model.addAttribute("file", result);
			return View.jsonView();
		} catch (IllegalStateException | IOException e) {
			log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: CommonController.java
	 * - 작성일		: 2016. 3. 23.
	 * - 작성자		: valueFactory
	 * - 설명		: 공통 파일 업로드
	 * </pre>
	 * @param model
	 * @param mRequest
	 * @param uploadType
	 * @return
	 */
	@RequestMapping("/common/fileUploadNcpResult.do")
	public String fileUploadNcpResult (Model model
		, MultipartHttpServletRequest mRequest
		, @RequestParam("uploadType") String uploadType
		, @RequestParam(value="filter", required=false) String filter
		, @RequestParam(value="maxFileSize", required=false) Double maxFileSize
		, @RequestParam("prePath") String prePath) {
		try {
			LogUtil.log(uploadType);
			FileVO vo = nhnObjectStorageUtil.upload(mRequest, uploadType, filter, maxFileSize, prePath);
			model.addAttribute("file", vo);
			return View.jsonView();
		} catch (IllegalStateException e) {
			log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: CommonController.java
	 * - 작성일		: 2021. 08. 12.
	 * - 작성자		: valueFactory
	 * - 설명		: 이미지 벌크 업로드
	 * </pre>
	 * @param model
	 * @param mRequest
	 * @param uploadType
	 * @return
	 */
	@RequestMapping("/common/bulkFileUploadResult.do")
	public String bulkFileUploadResult (Model model
		, MultipartHttpServletRequest mRequest
		, @RequestParam("uploadType") String uploadType
		, @RequestParam(value="filter", required=false) String filter
		, @RequestParam(value="maxFileSize", required=false) Double maxFileSize) {
		try {
			 List<MultipartFile> fileList = mRequest.getFiles("uploadFileBulk");
			 List<FileVO> resultList = new ArrayList<FileVO>();
			 LogUtil.log(uploadType);
			 
			 for (MultipartFile mFile : fileList) {
				 FileVO result = new FileVO();
				String fileOrgName = mFile.getOriginalFilename();
				String exe = FilenameUtils.getExtension(fileOrgName);

				String[] fileFilter = null;
				
				if(StringUtil.isNotBlank(filter)) {
					fileFilter = filter.split("\\|");
				} else {
					if(StringUtil.isNotBlank(uploadType)) {
						if("image".equals(uploadType)) {
							fileFilter = "jpg,jpeg,png,gif,svg,bmp".split(",");
							//이미지 업로드 시 15MB 제한
							maxFileSize = Optional.ofNullable(maxFileSize).orElse(15D);
						}
						if("file".equals(uploadType)) {
							fileFilter = "jpg,jpeg,png,gif,bmp,txt,pdf,hwp,xls,xlsx".split(",");
						}
						if("xls".equals(uploadType)) {
							fileFilter = "xls,xlsx".split(",");
						}
						if("imageFile".equals(uploadType)) {
							fileFilter = "jpg,jpeg,png,gif".split(",");
							maxFileSize = Optional.ofNullable(maxFileSize).orElse(15D);
						}
					}
				}

				if(fileFilter == null || fileFilter.length == 0 || mFile.getOriginalFilename().indexOf("%00") >0 || mFile.getOriginalFilename().indexOf("0x00") >0) {
					throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
				}
				/*
				 * 각 파일 형식에 따라 제한 필요, xxx.x 까지 크기 표시
				 * 이미지 5MB 제한
				 * 지정 안했을 경우 20MB
				 * */
				maxFileSize = Optional.ofNullable(maxFileSize).orElse(20D);
				Long maxSize = (long)(maxFileSize * 1024 * 1024);

				Boolean checkExe = true;
				for(String ex : fileFilter){
					if(ex.equalsIgnoreCase(exe)){
						checkExe = false;
					}
				}

				if(checkExe){
					throw new CustomException(ExceptionConstants.BAD_EXE_FILE_EXCEPTION);
				}

				if(mFile.getSize() > maxSize) {
					 throw new CustomException(ExceptionConstants.BAD_SIZE_FILE_EXCEPTION, new String[] {String.format("%.1f", maxFileSize).concat("MB")}) ;
				}

				String fileName = UUID.randomUUID() + "." + exe;
				String filePath = bizConfig.getProperty("common.file.upload.base") + AdminConstants.TEMP_IMAGE_PATH + FileUtil.SEPARATOR + DateUtil.getNowDate() + FileUtil.SEPARATOR;
				File file = new File(filePath + fileName);
				if (!file.getParentFile().exists()) {
					file.getParentFile().mkdirs();
				}

				mFile.transferTo(file);
				result.setFileExe(exe);
				result.setFileName(fileOrgName);
				result.setFileSize(mFile.getSize());
				result.setFileType(mFile.getContentType());
				result.setFilePath(filePath + fileName);
				resultList.add(result);
			 }
			model.addAttribute("resultList", resultList);
			return View.jsonView();
		} catch (IllegalStateException | IOException e) {
			log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: CommonController.java
	 * - 작성일		: 2016. 5. 11.
	 * - 작성자		: valueFactory
	 * - 설명		: 파일 다운로드
	 * </pre>
	 * @param map
	 * @param filePath
	 * @param fileName
	 * @return
	 */
	@RequestMapping("/common/fileDownloadResult.do")
	public String fileUploadResult(ModelMap map
		, @RequestParam("filePath") String filePath
		, @RequestParam(value="fileName", required=false) String fileName
		, @RequestParam(value="imgYn", required=false) String imgYn) {
		FtpFileUtil ftpFileUtil = null;
		FtpImgUtil ftpImgUtil = null;
		FileViewParam fileView = new FileViewParam();
		String newFilePath = "";
		if (StringUtil.isNotEmpty(imgYn) && StringUtils.equals(CommonConstants.COMM_YN_Y, imgYn)) {
			if (StringUtils.equals(bizConfig.getProperty("envmt.gb"), CommonConstants.ENVIRONMENT_GB_LOCAL)) {
				fileView.setFilePath(filePath);
				fileView.setFileName(fileName);
				map.put(AdminConstants.FILE_PARAM_NAME, fileView);
				return View.fileNcpDownload();
			} else {
				ftpImgUtil = new FtpImgUtil();
				newFilePath = ftpImgUtil.download(filePath);
			}
		} else {
			ftpFileUtil = new FtpFileUtil();
			newFilePath = ftpFileUtil.download(filePath);
		}
		

		if(StringUtil.isBlank(fileName)) {
			fileName = FilenameUtils.getName(newFilePath);
		}

		fileView.setFilePath(newFilePath);
		fileView.setFileName(fileName);
		map.put(AdminConstants.FILE_PARAM_NAME, fileView);

		return View.fileDownload();
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: CommonController.java
	 * - 작성일		: 2016. 5. 11.
	 * - 작성자		: valueFactory
	 * - 설명		: 파일 다운로드
	 * </pre>
	 * @param map
	 * @param filePath
	 * @param fileName
	 * @return
	 */
	@RequestMapping("/common/fileUrlDownloadResult.do")
	public String fileDownloadResult(ModelMap map
		, @RequestParam("filePath") String filePath
		, @RequestParam(value="fileName", required=false) String fileName
		, @RequestParam(value="imgYn", required=false) String imgYn) {

		FileViewParam fileView = new FileViewParam();

		if(StringUtil.isBlank(fileName)) {
			fileName = FilenameUtils.getName(filePath);
		}

		fileView.setFilePath(filePath);
		fileView.setFileName(fileName);
		map.put(AdminConstants.FILE_PARAM_NAME, fileView);

		return View.fileUrlDownload();
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: CommonController.java
	 * - 작성일		: 2016. 5. 11.
	 * - 작성자		: valueFactory
	 * - 설명		: 파일 다운로드
	 * </pre>
	 * @param map
	 * @param filePath
	 * @param fileName
	 * @return
	 */
	@RequestMapping("/common/fileDownload.do")
	public String fileDownload(ModelMap map
		, @RequestParam("filePath") String filePath
		, @RequestParam(value="fileName", required=false) String fileName
		, @RequestParam(value="imgYn", required=false) String imgYn) {
		FileViewParam fileView = new FileViewParam();

		fileView.setFilePath(filePath);
		fileView.setFileName(fileName);
		if (StringUtil.isNotEmpty(imgYn) && StringUtil.equals(CommonConstants.COMM_YN_Y, imgYn)) {
			String[] rootPathArr = {bizConfig.getProperty("common.nas.base") + FileUtil.SEPARATOR + bizConfig.getProperty("common.nas.base.image")};
			fileView.setRootPath(rootPathArr);
		}
		map.put(AdminConstants.FILE_PARAM_NAME, fileView);

		return View.fileDownload();
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: CommonController.java
	 * - 작성일		: 2016. 5. 11.
	 * - 작성자		: valueFactory
	 * - 설명		: 파일 다운로드
	 * </pre>
	 * @param map
	 * @param filePath
	 * @param fileName
	 * @return
	 */
	@RequestMapping("/common/fileUrlDownload.do")
	public String fileUrlDownload(ModelMap map
		, @RequestParam("filePath") String filePath
		, @RequestParam(value="fileName", required=false) String fileName
		, @RequestParam(value="imgYn", required=false) String imgYn) {
		sessionChk();
		FileViewParam fileView = new FileViewParam();

		fileView.setFilePath(filePath);
		fileView.setFileName(fileName);
		map.put(AdminConstants.FILE_PARAM_NAME, fileView);

		return View.fileUrlDownload();
	}

	private void sessionChk() {
		if (AdminSessionUtil.getSession() == null) {
			throw new CustomException(ExceptionConstants.TRY_LOGIN_REQUIRED);
		}
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: CommonController.java
	 * - 작성일		: 2016. 5. 11.
	 * - 작성자		: valueFactory
	 * - 설명		: 파일 다운로드
	 * </pre>
	 * @param map
	 * @param filePath
	 * @param fileName
	 * @return
	 */
	@RequestMapping("/common/fileNcpDownload.do")
	public String fileNcpDownload(ModelMap map
		, @RequestParam("filePath") String filePath
		, @RequestParam(value="fileName", required=false) String fileName) {
		sessionChk();
		FileViewParam fileView = new FileViewParam();

		fileView.setFilePath(filePath);
		fileView.setFileName(fileName);
		map.put(AdminConstants.FILE_PARAM_NAME, fileView);

		return View.fileNcpDownload();
	}

	@RequestMapping("/common/editorImageFileResult.do")
	public String editorImageFileResult(Model model, FileVO vo, @RequestParam(value="imgPath", required=false ) String imgPath){

		/********************************************************************
		 * 저장장치 특성상 하나의 폴더에 들어갈수 있는 파일이 제한적이므로
		 * 년도+월 단위의 중간 폴더 생성하여 저장
		 *******************************************************************/
		imgPath = imgPath + FileUtil.SEPARATOR + DateUtil.calDate("yyyyMM");

		FtpImgUtil ftpImgUtil = new FtpImgUtil();
		String newImgPath = AdminConstants.EDITOR_IMAGE_PATH + ftpImgUtil.uploadFilePath(vo.getFilePath(), imgPath);
		ftpImgUtil.upload(vo.getFilePath(), newImgPath);
		model.addAttribute("filePath", newImgPath);
		return View.jsonView();
	}


	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: CommonController.java
	 * - 작성일		: 2016. 3. 23.
	 * - 작성자		: valueFactory
	 * - 설명		: 공통 Select Ajax 뷰어
	 * </pre>
	 * @param model
	 * @param so
	 * @return
	 */
	@RequestMapping("/common/codeSelectView.do")
	public String codeSelectView(Model model, CodeDetailSO so) {
		if(log.isDebugEnabled() ) {
			log.debug("==================================================");
			LogUtil.log(so );
			log.debug("==================================================");
		}
		model.addAttribute("code", so);
		return "/common/codeSelectView";
	}

	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: CommonController.java
	* - 작성일		: 2016. 3. 22.
	* - 작성자		: valueFactory
	* - 설명			:
	* </pre>
	* @param model
	* @param viewName
	* @return
	*/
	@RequestMapping("/common/includeView.do")
	public String includeView (Model model, @RequestParam("viewName") String viewName ) {
		if(log.isDebugEnabled() ) {
			log.debug("==================================================");
			log.debug("= viewName : {}", viewName);
			log.debug("==================================================");
		}

		return viewName;
	}


	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: CommonController.java
	* - 작성일		: 2016. 3. 29.
	* - 작성자		: valueFactory
	* - 설명			:
	* </pre>
	* @param model
	* @param so
	* @return
	*/
	@RequestMapping("/common/codeUsrDfnValView.do")
	public String codeUsrDfnValView (Model model, CodeDetailSO so) {
		if(log.isDebugEnabled() ) {
			log.debug("==================================================");
			LogUtil.log(so );
			log.debug("==================================================");
		}
		model.addAttribute("code", so);
		return "/common/codeUsrDfnValView";
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: CommonController.java
	 * - 작성일		: 2016. 5. 11.
	 * - 작성자		: valueFactory
	 * - 설명		: 공급업체 검색 레이어
	 * </pre>
	 * @return
	 */
	@RequestMapping("/common/companySearchLayerView.do")
	public String companySearchLayerView(Model model, CompanySO so) {

		model.addAttribute("compStatCd", so.getCompStatCd());
		model.addAttribute("readOnlyCompStatCd", StringUtils.equalsIgnoreCase(so.getReadOnlyCompStatCd(), CommonConstants.COMM_YN_Y) ? Boolean.TRUE :  Boolean.FALSE);
		model.addAttribute("selectKeyOnlyCompStatCd", StringUtils.equalsIgnoreCase(so.getSelectKeyOnlyCompStatCd(), CommonConstants.COMM_YN_Y) ? Boolean.TRUE :  Boolean.FALSE);
		model.addAttribute("excludeCompStatCd", so.getExcludeCompStatCd());
		
		model.addAttribute("compTpCd", so.getCompTpCd());
		model.addAttribute("readOnlyCompTpCd", StringUtils.equalsIgnoreCase(so.getReadOnlyCompTpCd(), CommonConstants.COMM_YN_Y) ? Boolean.TRUE :  Boolean.FALSE);
		model.addAttribute("selectKeyOnlyCompTpCd", StringUtils.equalsIgnoreCase(so.getSelectKeyOnlyCompTpCd(), CommonConstants.COMM_YN_Y) ? Boolean.TRUE :  Boolean.FALSE);
		model.addAttribute("excludeCompTpCd", so.getExcludeCompTpCd());
		
		model.addAttribute("stId", so.getStId());
		model.addAttribute("stIds", so.getStIds());

		return "/common/companySearchLayerView";
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: CommonController.java
	 * - 작성일		: 2016. 5. 11.
	 * - 작성자		: valueFactory
	 * - 설명		: 사용자 검색 레이어
	 * </pre>
	 * @return
	 */
	@RequestMapping("/common/memberSearchLayerView.do")
	public String memberSearchLayerView(ModelMap map, MemberParam param) {
		map.put("param", param);
		return "/common/memberSearchLayerView";
	}

	/**
	 *
	* <pre>
	* - 프로젝트명   : 41.admin.web
	* - 패키지명   : admin.web.view.common.controller
	* - 파일명      : CommonController.java
	* - 작성일      : 2017. 5. 10.
	* - 작성자      : valuefactory 권성중
	* - 설명      :   MD 사용자 검색
	* </pre>
	 */
	@RequestMapping("/common/userSearchLayerView.do")
	public String userSearchLayerView(ModelMap map, UserParam param) {
		map.put("param", param);
		return "/common/userSearchLayerView";
	}

	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: CommonController.java
	* - 작성일		: 2017. 6. 1.
	* - 작성자		: Administrator
	* - 설명			: 사용자 목록 조회
	* </pre>
	* @param so
	* @return
	*/
	@ResponseBody
	@RequestMapping(value="/common/userListGrid.do", method=RequestMethod.POST)
	public GridResponse userListGrid(UserBaseSO so) {

//		// 2017.05.16, 이성용, 관리자가 아니지만 사용자 전체 대상 검색할 때 아래 조건을 통과하기 추가함.(예, 메시지 보내기의 사용자 목록 조회 기능)
//		if (StringUtils.equalsIgnoreCase(CommonConstants.COMM_YN_N, so.getSearchAllUser())) {
//			Session session = AdminSessionUtil.getSession();
//			if (StringUtils.equals(CommonConstants.USR_GB_2010, session.getUsrGbCd())) {
//				if (session.getCompNo().compareTo(so.getCompNo()) == 0) {
//					so.setCompNo(session.getCompNo());
//				}
//			} else if (StringUtils.equals(CommonConstants.USR_GB_2020, session.getUsrGbCd())) {
//				so.setCompNo(session.getCompNo());
//			}
//		}

		List<UserBaseVO> list = userService.pageUser(so);
		return new GridResponse(list, so);
	}

	@RequestMapping("/common/userInfoLayerView.do")
	public String userInfoLayerView(Model model) {
		UserBaseSO so = new UserBaseSO();
		so.setUsrNo(AdminSessionUtil.getSession().getUsrNo());
		UserBaseVO vo= userService.getUser(so);
		
		AuthoritySO authSo =new AuthoritySO();
		authSo.setUsrNo(AdminSessionUtil.getSession().getUsrNo());
		List<AuthorityVO> authList = authService.listUserAuth(authSo);
		String auths = "";
		for(AuthorityVO auth : authList) {
			auths += auth.getAuthNm()+" / ";
		}
		auths = auths.substring(0, auths.length()-2);
		vo.setAuthNm(auths);
		
		model.addAttribute("user", vo);
		
		return "/common/userUpdateLayerView";
	}

	@RequestMapping("/common/userInfoUpdate.do")
	public String userInfoUpdate(Model model, UserBasePO po, BindingResult br) {
		if ( br.hasErrors() ) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		userService.updateUserInfo(po);
		return View.jsonView();
	}


	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: CommonController.java
	* - 작성일		: 2016. 6. 13.
	* - 작성자		: valueFactory
	* - 설명			: 이력 조회 LAYER
	* </pre>
	* @param model
	* @param HistorySO
	* @return
	*/
	@RequestMapping("/common/historyLayerView.do")
	public String historyLayerView (Model model, HistorySO historySO ) {
		if (log.isDebugEnabled()) {
			log.debug("==================================================");
			log.debug("= {}", "historyLayerView");
			log.debug("==================================================");
		}

		model.addAttribute("HistorySO", historySO );
		return "/common/historyLayerView";
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: CommonController.java
	 * - 작성일		: 2017. 1. 4.
	 * - 작성자		: hongjun
	 * - 설명		: 사이트 검색 레이어
	 * </pre>
	 * @return
	 */
	@RequestMapping("/common/stSearchLayerView.do")
	public String stSearchLayerView() {
		return "/common/stSearchLayerView";
	}


	// 메세지 확인
	@RequestMapping("/common/existsUserMessage.do")
	public String existsUserMessage(Model model , Long usrNo ) {
		model.addAttribute("existsUserMessageCnt", userMessageService.existsUserMessage(usrNo));
		return View.jsonView();
	}


	@RequestMapping("/common/userMessageListViewPop.do")
	public String userMessageListViewPop(Model model, String mode ) {
		model.addAttribute("mode", StringUtils.isEmpty(mode) ? "RCV" : mode);
		return "/common/userMessageListViewPop";
	}
	/**
	 *
	* <pre>
	* - 프로젝트명   : 41.admin.web
	* - 패키지명   : admin.web.view.common.controller
	* - 파일명      : CommonController.java
	* - 작성일      : 2017. 5. 15.
	* - 작성자      : valuefactory 권성중
	* - 설명      : 메세지 리스트
	* </pre>
	 */
	@ResponseBody
	@RequestMapping(value="/common/userMessageListGrid.do", method=RequestMethod.POST)
	public GridResponse userMessageListGrid(Model model, UserMessageBaseSO so) {

		so.setUsrNo(AdminSessionUtil.getSession().getUsrNo());

	 	List<UserMessageBaseVO> list =  userMessageService.pageUserMessage(so);

	 	model.addAttribute("mode", so.getMode());
		return new GridResponse(list, so);
	}
	/**
	 *
	* <pre>
	* - 프로젝트명   : 41.admin.web
	* - 패키지명   : admin.web.view.common.controller
	* - 파일명      : CommonController.java
	* - 작성일      : 2017. 5. 15.
	* - 작성자      : valuefactory 권성중
	* - 설명      : 메세지 조회
	* </pre>
	 */
	@RequestMapping("/common/userMessageViewPop.do")
	public String userMessageViewPop(Model model , UserMessageBaseSO so) {
		//UserMessageBaseSO so = new UserMessageBaseSO();
		//so.setUsrNo(AdminSessionUtil.getSession().getUsrNo());
		if(so.getNoteNo() > 0 && so.getUsrNo()  > 0 ){
			model.addAttribute("userMessage", userMessageService.getUserMessage(so) );
		}
		model.addAttribute("mode", so.getMode());
		return "/common/userMessageViewPop";
	}

	/**
	 *
	* <pre>
	* - 프로젝트명   : 41.admin.web
	* - 패키지명   : admin.web.view.common.controller
	* - 파일명      : CommonController.java
	* - 작성일      : 2017. 5. 15.
	* - 작성자      : valuefactory 권성중
	* - 설명      : 메세지 보내기
	* </pre>
	 */
	@RequestMapping("/common/userMessageSend.do")
	public String messageSend(Model model, UserMessageBasePO po ) {
		po.setSndrNo(AdminSessionUtil.getSession().getUsrNo());
		userMessageService.insertUserMessage(po);
		model.addAttribute("userMessage", po);
		return View.jsonView();
	}
	/**
	 *
	* <pre>
	* - 프로젝트명   : 41.admin.web
	* - 패키지명   : admin.web.view.common.controller
	* - 파일명      : CommonController.java
	* - 작성일      : 2017. 5. 15.
	* - 작성자      : valuefactory 권성중
	* - 설명      :  메세지 삭제
	* </pre>
	 */
	@RequestMapping("/common/deleteUserMessage.do")
	public String deleteMessage(Model model, UserMessageBasePO po ) {
		userMessageService.deleteUserMessage(po);
		model.addAttribute("userMessage", po);
		return View.jsonView();
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	* - 패키지명   : admin.web.view.common.controller
	 * - 파일명		: CommonController.java
	* - 작성일		: 2017. 6. 16.
	* - 작성자		: hongjun
	 * - 설명			: 전시여부 일괄 수정 조회
	 * </pre>
	 *
	 * @param model
	 * @return
	 */
	@RequestMapping("/common/dispYnUpdateLayerView.do")
	public String exhibitionBaseDispYnUpdateLayerView(Model model) {
		return "/common/dispYnUpdateLayerView";
	}


	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 패키지명   : admin.web.view.common.controller
	 * - 파일명		: CommonController.java
	 * - 작성일		: 2018. 1. 24.
	 * - 작성자		: valueFactory
	 * - 설명		: 선택한 헤더 메뉴의 LNB 메뉴 목록 조회
	 * </pre>
	 *
	 * @param model
	 * @param url - 헤더 메뉴 URL
	 * @return
	 */
	@RequestMapping(value="/common/leftMenu.do")
	public String leftMenu(Model model, String url) {

		Session session = AdminSessionUtil.getSession();
		List<MenuBaseVO> list = menuService.listCommonMenu(session.getUsrNo());

		List<MenuBaseVO> leftList = new ArrayList<>();
		MenuBaseVO menuDetail = new MenuBaseVO();
		
		if(CollectionUtils.isNotEmpty(list)) {
			for(MenuBaseVO menuBaseVO : list) {
				if(menuBaseVO.getListMenuActionVO() != null && menuBaseVO.getListMenuActionVO().size() > 0){
					for(MenuActionVO menuActionVO : menuBaseVO.getListMenuActionVO()) {
						if(StringUtil.isNotBlank(menuActionVO.getUrl()) && url.indexOf(menuActionVO.getUrl()) > -1) {
							menuDetail.setActNm(menuActionVO.getActNm());
							menuDetail.setUrl(menuActionVO.getUrl());
							menuDetail.setMenuNo(menuBaseVO.getMenuNo());
							menuDetail.setMenuNm(menuBaseVO.getMenuNm());
							menuDetail.setMenuPathNm(menuBaseVO.getMenuPathNm());
							menuDetail.setMastMenuNo(menuBaseVO.getMastMenuNo());
							menuDetail.setUpMenuNo(menuBaseVO.getUpMenuNo());
						}
					}
				}
			}
		}
		
		// left 메뉴 로직
		if(CollectionUtils.isNotEmpty(list)) {
			for(MenuBaseVO menuBaseVO : list) {
				if(menuDetail.getMastMenuNo() != null && menuDetail.getMastMenuNo().equals(menuBaseVO.getMastMenuNo()) && menuBaseVO.getLevel().equals(2)) {
					MenuBaseVO menuVO = new MenuBaseVO();
					menuVO.setMenuNo(menuBaseVO.getMenuNo());
					menuVO.setMenuNm(menuBaseVO.getMenuNm());
					menuVO.setMenuPathNm(menuBaseVO.getMenuPathNm());
					menuVO.setMastMenuNo(menuBaseVO.getMastMenuNo());
					menuVO.setUpMenuNo(menuBaseVO.getUpMenuNo());
					if(menuBaseVO.getListMenuActionVO() != null && menuBaseVO.getListMenuActionVO().size() > 0) {
						for(MenuActionVO menuActionVO : menuBaseVO.getListMenuActionVO()) {
							if(StringUtil.isNotBlank(menuActionVO.getActGbCd()) && AdminConstants.ACT_GB_10.equals(menuActionVO.getActGbCd())) {
								menuVO.setActNm(menuActionVO.getActNm());
								menuVO.setUrl(menuActionVO.getUrl());
							}
						}
					}

					List<MenuBaseVO> levelList = new ArrayList<>();

					for(MenuBaseVO subVO : list) {
						if(subVO.getUpMenuNo() != null && menuVO.getUpMenuNo() != null && menuVO.getMenuNo().equals(subVO.getUpMenuNo())) {
							MenuBaseVO menuSubVO = new MenuBaseVO();
							menuSubVO.setMenuNo(subVO.getMenuNo());
							menuSubVO.setMenuNm(subVO.getMenuNm());
							menuSubVO.setMenuPathNm(subVO.getMenuPathNm());
							menuSubVO.setMastMenuNo(subVO.getMastMenuNo());
							menuSubVO.setUpMenuNo(subVO.getUpMenuNo());
							if(subVO.getListMenuActionVO() != null && subVO.getListMenuActionVO().size() > 0) {
								for(MenuActionVO menuActionVO : subVO.getListMenuActionVO()) {
									if(StringUtil.isNotBlank(menuActionVO.getActGbCd()) && AdminConstants.ACT_GB_10.equals(menuActionVO.getActGbCd())) {
										menuSubVO.setActNm(menuActionVO.getActNm());
										menuSubVO.setUrl(menuActionVO.getUrl());
									}
								}
							}
							levelList.add(menuSubVO);
						}
					}

					if(CollectionUtils.isNotEmpty(levelList)){
						menuVO.setListMenuBaseVO(levelList);
					}
					leftList.add(menuVO);
				}
			}
		}
					
		
		model.addAttribute("commonMenuDetail", menuDetail);
		model.addAttribute("leftMenuList", leftList);
		return View.jsonView();
	}
	
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 패키지명   : admin.web.view.common.controller
	 * - 파일명		: CommonController.java
	 * - 작성일		: 2018. 1. 24.
	 * - 작성자		: valueFactory
	 * - 설명		: 전체 메뉴 목록 조회
	 * </pre>
	 *
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/common/menuList.do")
	public String menuList(Model model) {

		Session session = AdminSessionUtil.getSession();
		List<MenuBaseVO> list = menuService.listCommonMenu(session.getUsrNo());

		List<MenuBaseVO> menuList = list.stream()
						.filter(item -> Objects.equals(item.getLevel(), 3))
						.collect(Collectors.toList());
		
		
		model.addAttribute("menuList", menuList);
		return View.jsonView();
	}

	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 패키지명   : admin.web.view.common.controller
	 * - 파일명		: CommonController.java
	 * - 작성일		: 2018. 8. 3.
	 * - 작성자		: valueFactory
	 * - 설명		: 선택한 메뉴의 제일 상위 메뉴 번호 조회
	 * </pre>
	 *
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/common/getMastMenuNo.do")
	public String getMastMenuNo(Model model, String menuUrl) {

		MenuBaseVO menu = menuService.getMastMenuNo(menuUrl);
		model.addAttribute("mastMenuNo", menu.getMastMenuNo());
		
		return View.jsonView();
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 패키지명   	: admin.web.view.common.controller
	 * - 파일명		: CommonController.java
	 * - 작성일		: 2020. 12. 30.
	 * - 작성자		: lds
	 * - 설명			: 행정안전부 주소검색 팝업
	 * </pre>
	 *
	 * @param model
	 * @return
	 */
	@RequestMapping("/common/moisPostLayerPopup.do")
	public String jusoLayerPopup(Model model) {
		return "/common/moisPostPopup";
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 패키지명   	: admin.web.view.common.controller
	 * - 파일명		: CommonController.java
	 * - 작성일		: 2020. 12. 30.
	 * - 작성자		: LDS
	 * - 설명			: 네이버지도 주소검색 API 호출(지번, 도로명으로 주소 세부정보를 검색)
	 * </pre>
	 *
	 * @param model
	 * @param srchText-주소
	 * @param lat-기준 좌표(위도)
	 * @param lon-기준 좌표(경도)
	 * @return
	 */
	@RequestMapping("/common/searchNaverMapGoApi.do")
	public String searchNaverMapGoApi(Model model, String srchText, String lat, String lon) {
		
		model.addAttribute("resBody", naverMapUtil.geocoding(srchText, lat, lon));
		
		return View.jsonView();
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 패키지명   	: admin.web.view.common.controller
	 * - 파일명		: CommonController.java
	 * - 작성일		: 2020. 12. 30.
	 * - 작성자		: LDS
	 * - 설명			: 네이버지도 주소검색 API 호출(좌표에 해당하는 법정동/행정동/지번주소/도로명주소 정보 조회)
	 * </pre>
	 *
	 * @param model
	 * @param srchText-주소
	 * @param lat-기준 좌표(위도)
	 * @param lon-기준 좌표(경도)
	 * @return
	 */
	@RequestMapping("/common/searchNaverMapGcApi.do")
	public String searchNaverMapGcApi(Model model, String lat, String lon) {
		
		model.addAttribute("resBody", naverMapUtil.coordToAddr(lat, lon));
		
		return View.jsonView();
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-41-admin
	 * - 파일명		: admin.web.view.common.controller
	 * - 작성일		: 2021. 01. 25.
	 * - 파일명		: CommonController.java
	 * - 작성자		: KSH
	 * - 설명		: SGR api ivKey
	 * </pre>
	 * @return String ivKey
	 */
	@ResponseBody
	@RequestMapping(value = "/common/getSgrAk.do")
	public String getSgrAk() throws Exception {
		return SgrCryptoUtil.getAuthKey();
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-41-admin
	 * - 파일명		: admin.web.view.common.controller
	 * - 작성일		: 2021. 01. 25.
	 * - 파일명		: CommonController.java
	 * - 작성자		: hjh
	 * - 설명			: twc 테스트 
	 * </pre>
	 * @return
	 */
/*	@RequestMapping(value = "/common/twcTest.do")
	public String twcTest(Model model, @RequestParam(value="loginId") String loginId, @RequestParam(value="userNo") String userNo) {
		String loginIdEnc = "";
		String userNoEnc = "";
		try {
			loginIdEnc = twcCryptoUtil.encryptWithKey(loginId, "");
			userNoEnc = twcCryptoUtil.encryptWithKey(userNo, "");
		} catch (Exception e) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		model.addAttribute("loginId", loginIdEnc);
		model.addAttribute("userNo", userNoEnc);
		return View.jsonView();
	}
	*/
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-41-admin
	 * - 파일명		: admin.web.view.common.controller
	 * - 작성일		: 2021. 03. 04.
	 * - 작성자		: JinHong
	 * - 설명		: 계좌인증
	 * </pre>
	 * @param model
	 * @param reqVO
	 * @return
	 */
	@RequestMapping("/common/reqCheckBankAccount.do")
	public String reqCheckBankAccount(Model model, String bankCd, String ooaNm, String acctNo) {
		
		if(StringUtil.isEmpty(bankCd) || StringUtil.isEmpty(ooaNm) || StringUtil.isEmpty(acctNo)) {
			throw new CustomException(ExceptionConstants.ERROR_PARAM);
		}
		
		boolean isOk = false;
		
		CheckBankAccountReqVO reqVO = new CheckBankAccountReqVO();
		reqVO.setBankCode(bankCd);
		reqVO.setAccountNo(acctNo);
		
		CheckBankAccountResVO res =  nicePayCommonService.reqCheckBankAccount(reqVO);
		
		if(res != null && NicePayConstants.COMMON_SUCCESS_CODE.equals(res.getResultCode())){
			if(ooaNm.trim().equals(res.getAccountName())) {
				isOk = true;
			}else {
				isOk = false;
				res.setResultMsg(message.getMessage("business.exception." + ExceptionConstants.ERROR_CERTIFY_ACCT_NM));
			}
		}
			
		model.addAttribute("isOk", isOk);
		model.addAttribute("res", res);
		
		return View.jsonView();
	}
	
	@RequestMapping("/common/interface/requestSendPush.do")
    public String requestSendPush(Model model, HttpServletRequest request) {
		String result = "";
		if (StringUtil.isNotEmpty(request.getHeader("iv_key"))) {
			try {
				String header = SgrCryptoUtil.decrypt(request.getHeader("iv_key"));
				int diff = (int) TimeUnit.MILLISECONDS.toMinutes(DateUtil.getTimestamp().getTime() - DateUtil.getTimestamp(header.split("\\|")[2], "yyyyMMddHHmmss").getTime());
				if (-5 < diff && 5 > diff) {
					com.fasterxml.jackson.databind.ObjectMapper jacksonMapper =  new com.fasterxml.jackson.databind.ObjectMapper();
					SgrPushVO vo = new SgrPushVO();
					try {
						vo  = jacksonMapper.readValue(CharStreams.toString(request.getReader()), SgrPushVO.class);
						SendPushPO po = new SendPushPO();
						List<PushTargetPO> target = new ArrayList<>();
						if (ClassUtil.objectAllFieldNullCheck(vo)) {
							result = "bad request";
						} else {
							for (String mbrNo : vo.getMbrNo()) {
								PushTargetPO ppo = new PushTargetPO();
								ppo.setTo(mbrNo);
								ppo.setLandingUrl(vo.getPushUrl());
								target.add(ppo);
							}
							po.setTitle(vo.getPushSubject());
							po.setBody(vo.getPushContent());
							po.setTarget(target);
							po.setLiveYn(CommonConstants.COMM_YN_Y);
							result = bizService.sendPush(po);
							if (StringUtil.isNotEmpty(result)) {
								result = "success";
							} else {
								result = "fail";
							}
						}
					} catch (IOException e) {
						log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
						result = "fail";
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

    	model.addAttribute("status", result);

    	return View.jsonView();
    }
	
	@RequestMapping("/common/reloadCodeFe.do")
    public String reloadCodeFe(Model model, HttpServletRequest request) {
		String scheme = "https://";
		String reqPath = "";
		String foDomain = webConfig.getProperty("site.fo.domain");
		if (StringUtil.equals(bizConfig.getProperty("envmt.gb"), FrontConstants.ENVIRONMENT_GB_LOCAL)) {
			scheme = "http://";
			foDomain = "localhost:8180";
		}
		reqPath = scheme + foDomain + "/common/V/zqWCJfhpFwx5vCb78hyg==";
		String result = "";
		try {
			URL url = new URL(reqPath);
			HttpURLConnection conn = (HttpURLConnection)url.openConnection();
			conn.setRequestProperty("iv_key", SgrCryptoUtil.getAuthKey());
			conn.setRequestMethod("POST");
			conn.setConnectTimeout(30000);
			conn.setReadTimeout(30000);
			conn.setDoInput(true);
			StringBuffer sc = new StringBuffer();
			String scLine = "";
			if (HttpURLConnection.HTTP_OK == conn.getResponseCode()) {
				BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "utf-8"));
				while((scLine = br.readLine()) != null) {
					sc.append(scLine);
				}
				br.close();
			} else {
				log.error("HttpStatus => Not OK : " + conn.getResponseCode());
				//throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
			}
			result = sc.toString();
		} catch (IOException e) {
			if (log.isDebugEnabled()) {		
				log.error("IOException =>" + e.getMessage());
			}
		}catch (Exception e) {
			if (log.isDebugEnabled()) {
				log.error("Exception =>" + e.getMessage());
			}
		}
		if (!StringUtil.equals(result, "success")) {
			log.error("cache reload Exception =>" + result);
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		return View.redirect("/main/mainView.do");
	}

	@RequestMapping("/common/{gb}/reloadFeCache.do")
    public String reloadFeCache(Model model, HttpServletRequest request, @PathVariable String gb) {
		String scheme = "https://";
		String reqPath = "";
		String foDomain = webConfig.getProperty("site.fo.domain");
		if (StringUtil.equals(bizConfig.getProperty("envmt.gb"), FrontConstants.ENVIRONMENT_GB_LOCAL)) {
			scheme = "http://";
			foDomain = "localhost:8180";
		}
		reqPath = scheme + foDomain + "/common/V/zqWCJfhpFwx5vCb78hyg==";
		String result = "";
		try {
			URL url = new URL(reqPath);
			HttpURLConnection conn = (HttpURLConnection)url.openConnection();
			conn.setRequestProperty("iv_key", SgrCryptoUtil.getAuthKey());
			conn.setRequestProperty("reloadGb", gb);
			conn.setRequestMethod("POST");
			conn.setConnectTimeout(30000);
			conn.setReadTimeout(30000);
			conn.setDoInput(true);
			StringBuffer sc = new StringBuffer();
			String scLine = "";
			if (HttpURLConnection.HTTP_OK == conn.getResponseCode()) {
				BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "utf-8"));
				while((scLine = br.readLine()) != null) {
					sc.append(scLine);
				}
				br.close();
			} else {
				log.error("HttpStatus => Not OK : " + conn.getResponseCode());
				//throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
			}
			result = sc.toString();
		} catch (IOException e) {
			if (log.isDebugEnabled()) {		
				log.error("IOException =>" + e.getMessage());
			}
		}catch (Exception e) {
			if (log.isDebugEnabled()) {
				log.error("Exception =>" + e.getMessage());
			}
		}
		if (!StringUtil.equals(result, "success")) {
			log.error("cache reload Exception =>" + result);
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		return View.redirect("/main/mainView.do");
	}


	@ResponseBody
	@RequestMapping(value="/common/privacy-access.do" , method=RequestMethod.POST)
	public Map la(PrivacyCnctHistPO po,String maskingUnlock){
		Map<String,Object> result = new HashMap<String,Object>();
		//개인정보 접속 이력
		Long cnctHistNo = Optional.ofNullable(po.getCnctHistNo()).orElseGet(() -> privacyCnctService.insertPrivacyCnctHist(po));
		result.put("cnctHistNo", cnctHistNo);
		po.setCnctHistNo(cnctHistNo);

		String colGbCd = Optional.ofNullable(po.getInqrGbCd()).orElseGet(()->AdminConstants.COL_GB_00);
		po.setColGbCd(colGbCd);

		String inqrGbCd = Optional.ofNullable(po.getInqrGbCd()).orElseGet(()->"");
		if(StringUtil.isEmpty(inqrGbCd)){
			inqrGbCd = StringUtil.equals(maskingUnlock,AdminConstants.COMM_YN_Y) ?
					AdminConstants.INQR_GB_10 : AdminConstants.INQR_GB_40;
		}
		po.setInqrGbCd(inqrGbCd);
		Long inqrHistNo = privacyCnctService.insertPrivacyCnctInquiry(po);
		result.put("inqrHistNo", inqrHistNo);

		return result;
	}

	@ResponseBody
	@RequestMapping(value="/common/updateQuery.do", method = RequestMethod.POST)
	public String updateQuery(PrivacyCnctHistPO po){
		String result = CommonConstants.CONTROLLER_RESULT_CODE_SUCCESS;
		privacyCnctService.updateExecSql(po);

		return result;
	}

	@RequestMapping(value="/common/fileDownloadAll.do" , method=RequestMethod.POST)
	public String fileDownloadAll(
			Model model,
			@RequestParam(value="fileNm")String[] fileNm,
			@RequestParam(value="filePath")String[] filePath,
			@RequestParam(value="cnt")int cnt,
			@RequestParam(value="seq",required = false)String seq
	){

		List<Map> success = new ArrayList<Map>();
		List<Map> fail = new ArrayList<Map>();

		for(int i=0;i<cnt;i++) {
			Map<String,String> file = new HashMap<String,String>();
			String exMsg = "";

			HashSet<String> images = new HashSet(Arrays.asList(new String[]{"jpg","jpeg","png","gif","svg","bmp"}));

			try{
				String exe = FilenameUtils.getExtension(fileNm[i]);

				FileViewParam fileView = new FileViewParam();
				FtpFileUtil ftpFileUtil;
				FtpImgUtil  ftpImgUtil;
				String newFilePath = "";

				if (images.contains(exe)){
					ftpImgUtil = new FtpImgUtil();
					newFilePath = ftpImgUtil.download(filePath[i]);
				} else {
					ftpFileUtil = new FtpFileUtil();
					newFilePath = ftpFileUtil.download(filePath[i]);
				}

				fileNm[i] =  StringUtil.isBlank(fileNm[i]) ? FilenameUtils.getName(newFilePath) : fileNm[i];

				fileView.setFilePath(newFilePath);
				fileView.setFileName(fileNm[i]);
				model.addAttribute(AdminConstants.FILE_PARAM_NAME + i, fileView);
			}catch(Exception e){
				exMsg = e.getMessage();
			}finally {
				file.put("filePath",filePath[i]);
				file.put("fileName",fileNm[i]);
				if(StringUtil.isNotEmpty(exMsg)){
					file.put("exMsg",exMsg);
					fail.add(file);
				}else{
					success.add(file);
				}
			}
		}

		model.addAttribute("success",success);
		model.addAttribute("fail",fail);
		model.addAttribute(CommonConstants.FILE_LIST_CNT, cnt);

		if(StringUtil.isNotEmpty(seq)){
			model.addAttribute("seq", seq);
		}

		return View.fileDownloadAll();

	}

}


