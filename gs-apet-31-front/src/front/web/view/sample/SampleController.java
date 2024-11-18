package front.web.view.sample;

import java.io.IOException;
import java.net.Socket;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.Properties;

import javax.servlet.http.HttpServletRequest;

import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.scribejava.core.model.OAuth2AccessToken;

import biz.app.display.model.SeoInfoVO;
import biz.app.order.model.OrderDlvrAreaVO;
import biz.app.order.service.OrderDlvrAreaService;
import biz.interfaces.sktmp.constants.SktmpConstants;
import biz.interfaces.sktmp.model.request.MpPntApproveReqVO;
import biz.interfaces.sktmp.model.response.MpPntApproveResVO;
import biz.interfaces.sktmp.util.SktmpConvertUtil;
import framework.admin.constants.AdminConstants;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import framework.common.model.FileVO;
import framework.common.util.AppleLoginUtil;
import framework.common.util.FileUtil;
import framework.common.util.FtpImgUtil;
import framework.common.util.GoogleLoginUtil;
import framework.common.util.KakaoLoginUtil;
import framework.common.util.NaverLoginUtil;
import framework.common.util.NhnObjectStorageUtil;
import framework.common.util.SessionUtil;
import framework.common.util.StringUtil;
import framework.front.constants.FrontConstants;
import framework.front.model.Session;
import front.web.config.constants.FrontWebConstants;
import front.web.config.view.ViewBase;
import lombok.extern.slf4j.Slf4j;

/**
 * <pre>
* - 프로젝트명	: 31.front.web
* - 패키지명	: front.web.view.sample
* - 파일명		: SampleController.java
* - 작성일		: 2020. 12. 17.
* - 작성자		: ValueFactory
* - 설명		: SampleController
 * </pre>
 */
@Slf4j
@Controller
@RequestMapping(value = {"sample"})
public class SampleController {

	@Autowired	private Properties bizConfig;

	@Autowired	private NaverLoginUtil naverLoginUtil;

	@Autowired 	private KakaoLoginUtil kakaoLoginUtil;

	@Autowired 	private GoogleLoginUtil googleLoginUtil;

	@Autowired 	private AppleLoginUtil appleLoginUtil;

	@Autowired 	private NhnObjectStorageUtil nhnObjectStorageUtil;

	@Autowired 	private OrderDlvrAreaService orderDlvrAreaService;

	/**
	 * <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명		: SampleController.java
	* - 작성일		: 2020. 12. 22.
	* - 작성자		: KKB
	* - 설명		: 개발 목록
	 * </pre>
	 *
	 * @return view
	 */
	@RequestMapping(value = {"sampleList"})
	public String sampleList(ViewBase view, @RequestParam(required = false) String gb) {
		if (StringUtil.equals(bizConfig.getProperty("envmt.gb"), FrontConstants.ENVIRONMENT_GB_OPER)) {
			return FrontWebConstants.EXCEPTION_VIEW_NAME;
		}
		String viewUrl = "sample/sampleFoList";
		if(gb != null && gb.equals("bo")) {
			viewUrl = "sample/sampleBoList";
		}else if(gb != null && gb.equals("common")) {
			viewUrl = "sample/sampleCommonList";
		}
		return viewUrl;
	}

	/**
	 * <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명		: SampleController.java
	* - 작성일		: 2020. 12. 17.
	* - 작성자		: KKB
	* - 설명		: TILES SAMPLE 등록
	 * </pre>
	 *
	 * @return view
	 */
	@RequestMapping(value = {"sampleTilesCommon"})
	public String sampleTilesCommon(ViewBase view) {
		if (StringUtil.equals(bizConfig.getProperty("envmt.gb"), FrontConstants.ENVIRONMENT_GB_OPER)) {
			return FrontWebConstants.EXCEPTION_VIEW_NAME;
		}
		return "sample/sampleTiles";
	}

	/**
	 * <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명		: SampleController.java
	* - 작성일		: 2020. 12. 17.
	* - 작성자		: KKB
	* - 설명		: 로그인 화면 호출
	 * </pre>
	 *
	 * @return view
	 */
	@RequestMapping(value = {"sampleLogin"})
	public String sampleLogin(ViewBase view) {
		if (StringUtil.equals(bizConfig.getProperty("envmt.gb"), FrontConstants.ENVIRONMENT_GB_OPER)) {
			return FrontWebConstants.EXCEPTION_VIEW_NAME;
		}
		SessionUtil.removeAttribute(FrontConstants.SESSION_SNS_LOGIN_INFO);
		return "sample/sampleLogin";
	}

	/**
	* - 설명		: 네이버 로그인 callback ( 코드로 토큰획득 > 사용자 정보 호출)
	 */
	@RequestMapping(value = {"naver/callback"})
	@Deprecated
	public String snsNaverCallback(HttpServletRequest request, Session session, ModelMap map, ViewBase view, String state, String code) {
		if (StringUtil.equals(bizConfig.getProperty("envmt.gb"), FrontConstants.ENVIRONMENT_GB_OPER)) {
			return FrontWebConstants.EXCEPTION_VIEW_NAME;
		}
		String storedState = naverLoginUtil.getSession(request.getSession());
		Map<String, String> userMap = null;
		if(storedState != null && storedState.equals(state)) {
			/* 접근 토큰 획득 */
			OAuth2AccessToken oauthToken = this.naverLoginUtil.getAccessToken(request.getSession(), code, state, "");
			if (oauthToken != null) {
				userMap = this.naverLoginUtil.getUserProfile(oauthToken);
				if (userMap != null) {
					String resultcode = userMap.get("resultcode");
					//보안 진단. 불필요한 코드 (비어있는 IF문)
					//if(resultcode != null && resultcode.equals("00")) {
						// 사용자 정보 사용 부분
					//}
				}
			}
		}
		return "sample/sampleLogin";
	}

	/**
	* - 설명		: 카카오 로그인 callback ( 코드로 토큰획득 > 사용자 정보 호출)
	 */
	@RequestMapping(value = {"kakao/callback"})
	@Deprecated
	public String snsKaKaoCallback(HttpServletRequest request, Session session, ModelMap map, ViewBase view, String state, String code) {
		if (StringUtil.equals(bizConfig.getProperty("envmt.gb"), FrontConstants.ENVIRONMENT_GB_OPER)) {
			return FrontWebConstants.EXCEPTION_VIEW_NAME;
		}
		String storedState = kakaoLoginUtil.getSession(request.getSession());
		Map<String, String> userMap = null;
		if(storedState != null && storedState.equals(state)) {
			/* 접근 토큰 획득 */
			OAuth2AccessToken oauthToken = this.kakaoLoginUtil.getAccessToken(request.getSession(), code, state, "");
			if (oauthToken != null) {
				userMap = this.kakaoLoginUtil.getUserProfile(oauthToken);
				//보안 진단. 불필요한 코드 (비어있는 IF문)
				//if (userMap != null) {
					// 사용자 정보 사용 부분
				//}
			}
		}
		return "sample/sampleLogin";
	}

	/**
	* - 설명		: 구글 로그인 callback ( 코드로 토큰획득 > 사용자 정보 호출)
	 */
	@RequestMapping(value = {"google/callback"})
	@Deprecated
	public String snsGoogleCallback(HttpServletRequest request, Session session, ModelMap map, ViewBase view, String state, String code) {
		if (StringUtil.equals(bizConfig.getProperty("envmt.gb"), FrontConstants.ENVIRONMENT_GB_OPER)) {
			return FrontWebConstants.EXCEPTION_VIEW_NAME;
		}
		String storedState = kakaoLoginUtil.getSession(request.getSession());
		Map<String, String> userMap = null;
		if(storedState != null && storedState.equals(state)) {
			/* 접근 토큰 획득 */
			OAuth2AccessToken oauthToken = this.googleLoginUtil.getAccessToken(request.getSession(), code, state, "");
			if (oauthToken != null) {
				userMap = this.googleLoginUtil.getUserProfile(oauthToken);
				//보안 진단. 불필요한 코드 (비어있는 IF문)
				//if (userMap != null) {
					// 사용자 정보 사용 부분
				//}
			}
		}
		return "sample/sampleLogin";
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 31.front.web
	 * - 파일명		: SampleController.java
	 * - 작성일		: 2021. 1. 4.
	 * - 작성자		: LDS
	 * - 설명			: naverMap 생성 화면
	 * </pre>
	 *
	 * @return view
	 */
	@RequestMapping(value = {"sampleNaverMap"})
	public String sampleNaverMap(ViewBase view) {
		if (StringUtil.equals(bizConfig.getProperty("envmt.gb"), FrontConstants.ENVIRONMENT_GB_OPER)) {
			return FrontWebConstants.EXCEPTION_VIEW_NAME;
		}
		return "sample/sampleNaverMap";
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 31.front.web
	 * - 파일명		: SampleController.java
	 * - 작성일		: 2021. 1. 8.
	 * - 작성자		: LDS
	 * - 설명			: 행정안전부 우편번호 조회 화면
	 * </pre>
	 *
	 * @return view
	 */
	@RequestMapping(value = {"sampleMoisPost"})
	public String sampleMoisPost(ViewBase view) {
		if (StringUtil.equals(bizConfig.getProperty("envmt.gb"), FrontConstants.ENVIRONMENT_GB_OPER)) {
			return FrontWebConstants.EXCEPTION_VIEW_NAME;
		}
		return "sample/sampleMoisPost";
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 31.front.web
	 * - 파일명		: SampleController.java
	 * - 작성일		: 2021. 1. 11.
	 * - 작성자		: KKB
	 * - 설명		: 디바이스 / OS / 넓이로 MO및PC 구분 예시
	 * </pre>
	 *
	 * @return view
	 */
	@RequestMapping(value = {"sampleCheckView"})
	public String sampleCheckView(ViewBase view) { // ViewBase view 필수
		if (StringUtil.equals(bizConfig.getProperty("envmt.gb"), FrontConstants.ENVIRONMENT_GB_OPER)) {
			return FrontWebConstants.EXCEPTION_VIEW_NAME;
		}
		// 필요시 서비스 구분 및 펫 구분 지정
//		view.setSeoSvcGbCd(CommonConstants.SEO_SVC_GB_CD_10); //펫샵:10, 펫TV:20(default), 펫로그:30
//		view.setPetGb(CommonConstants.PET_GB_20); //강아지:10(default), 고양이: 20, 기타:30
		return "sample/sampleCheckView";
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 31.front.web
	 * - 파일명		: SampleController.java
	 * - 작성일		: 2021. 1. 25.
	 * - 작성자		: VLF
	 * - 설명		: VOD 관련 예시
	 * </pre>
	 *
	 * @return view
	 */
	@RequestMapping(value = {"sampleVodView"})
	public String sampleVodView(ViewBase view, Model model) { // ViewBase view 필수
		if (StringUtil.equals(bizConfig.getProperty("envmt.gb"), FrontConstants.ENVIRONMENT_GB_OPER)) {
			return FrontWebConstants.EXCEPTION_VIEW_NAME;
		}
		SeoInfoVO seoInfoVo = new SeoInfoVO();
		seoInfoVo.setPageTtl("Vod Upload Sample");
		model.addAttribute("seoInfo", seoInfoVo);
		return "sample/sampleVodView";
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 31.front.web
	 * - 파일명		: SampleController.java
	 * - 작성일		: 2021. 3. 8.
	 * - 작성자		: VLF
	 * - 설명		: 펫로그 태그 관련 예시
	 * </pre>
	 *
	 * @return view
	 */
	@RequestMapping(value = {"samplePetlogTagView"})
	public String samplePetlogTagView(ViewBase view, Model model, Session session) { // ViewBase view 필수
		if (StringUtil.equals(bizConfig.getProperty("envmt.gb"), FrontConstants.ENVIRONMENT_GB_OPER)) {
			return FrontWebConstants.EXCEPTION_VIEW_NAME;
		}
		SeoInfoVO seoInfoVo = new SeoInfoVO();
		seoInfoVo.setPageTtl("Petlog Tag Sample");
		model.addAttribute("seoInfo", seoInfoVo);
		model.addAttribute("session", session);
		return "sample/samplePetlogTagView";
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 31.front.web
	 * - 파일명		: SampleController.java
	 * - 작성일		: 2021. 1. 25.
	 * - 작성자		: VLF
	 * - 설명		: VOD 관련 예시
	 * </pre>
	 *
	 * @return view
	 */
	@RequestMapping(value = {"sampleImageView"})
	public String sampleImageView(ViewBase view, Model model) { // ViewBase view 필수
		if (StringUtil.equals(bizConfig.getProperty("envmt.gb"), FrontConstants.ENVIRONMENT_GB_OPER)) {
			return FrontWebConstants.EXCEPTION_VIEW_NAME;
		}
		SeoInfoVO seoInfoVo = new SeoInfoVO();
		seoInfoVo.setPageTtl("Image Upload Sample");
		model.addAttribute("seoInfo", seoInfoVo);
		return "sample/sampleImageView";
	}

	@ResponseBody
	@RequestMapping(value = {"imageUpload"})
	public ModelMap imageUpload(Model model, @RequestParam(value = "imgPath") String imgPath
			,@RequestParam(value = "imgNm") String imgNm) {
		ModelMap map = new ModelMap();
		if (StringUtil.equals(bizConfig.getProperty("envmt.gb"), CommonConstants.ENVIRONMENT_GB_OPER)) {
			return map;
		}
		FtpImgUtil ftpImgUtil = new FtpImgUtil();
		String filePath = ftpImgUtil.uploadFilePath(imgPath, AdminConstants.TEMP_IMAGE_PATH + FileUtil.SEPARATOR + "1");
		ftpImgUtil.upload(imgPath, filePath);
		FileVO vo = new FileVO();
		vo.setFilePath(filePath);
		vo.setFileName(imgNm);
		map.put("file", vo);
		return map;
	}

	@ResponseBody
	@RequestMapping(value = {"imageDelete"})
	public ModelMap imageDelete(Model model, @RequestParam(value = "imgPath") String imgPath) {
		ModelMap map = new ModelMap();
		if (StringUtil.equals(bizConfig.getProperty("envmt.gb"), CommonConstants.ENVIRONMENT_GB_OPER)) {
			return map;
		}
		nhnObjectStorageUtil.delete(imgPath);
		return map;
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 31.front.web
	 * - 파일명		: SampleController.java
	 * - 작성일		: 2021. 1. 27.
	 * - 작성자		: KKB
	 * - 설명		: KCB OkCert3 휴대폰 본인 인증 샘플 화면
	 * </pre>
	 *
	 * @return view
	 */
	@RequestMapping(value = {"sampleOkCert"})
	public String sampleOkCert(ViewBase view) { // ViewBase view 필수
		return "sample/sampleOkCert";
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 31.front.web
	 * - 파일명		: SampleController.java
	 * - 작성일		: 2021. 02. 08.
	 * - 작성자		: KKB
	 * - 설명		: Adbrix 샘플 페이지
	 * </pre>
	 *
	 * @return view
	 */
	@RequestMapping("sampleAdbrix")
	public String sampleAdbrix(ViewBase view) {
		return "sample/sampleAdbrix";
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 31.front.web
	 * - 파일명		: SampleController.java
	 * - 작성일		: 2021. 02. 22.
	 * - 작성자		: KKB
	 * - 설명		: Adbrix 샘플 inclued
	 * </pre>
	 *
	 * @return view
	 */
	@RequestMapping("sampleAdbrixProdHtml")
	public String sampleAdbrixProdHtml(Long prdIdx) {
		return "sample/sampleAdbrixProdHtml";
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 31.front.web
	 * - 파일명		: SampleController.java
	 * - 작성일		: 2021. 02. 16.
	 * - 작성자		: KKB
	 * - 설명		: app interface 샘플 화면
	 * </pre>
	 *
	 * @return view
	 */
	@RequestMapping("sampleAppInterface")
	public String sampleAppInterface(ViewBase view) {
		return "sample/sampleAppInterface";
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 31.front.web
	 * - 파일명		: SampleController.java
	 * - 작성일		: 2021. 02. 24.
	 * - 작성자		: KKB
	 * - 설명		: Google Analytics 샘플 화면
	 * </pre>
	 *
	 * @return view
	 */
	@RequestMapping("sampleGoogleAnalytics")
	public String sampleGoogleAnalytics(ViewBase view) {
		return "sample/sampleGoogleAnalytics";
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 31.front.web
	 * - 파일명		: SampleController.java
	 * - 작성일		: 2021. 02. 25.
	 * - 작성자		: KKB
	 * - 설명		: Google Analytics 샘플 inclued
	 * </pre>
	 *
	 * @return view
	 */
	@RequestMapping("sampleGaHtml")
	public String sampleGaHtml(Long itemidx) {
		return "sample/sampleGaHtml";
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 31.front.web
	 * - 파일명		: SampleController.java
	 * - 작성일		: 2021. 02. 17.
	 * - 작성자		: KKB
	 * - 설명		: kakao map 샘플 화면
	 * </pre>
	 *
	 * @return view
	 */
	@RequestMapping("sampleKakaoMap")
	public String sampleKaKaoMap(ViewBase view) {
		return "sample/sampleKakaoMap";
	}

	@RequestMapping("sampleOrder")
	public String sampleOrder(ViewBase view) {
		return "sample/sampleOrder";
	}

	@ResponseBody
	@RequestMapping(value = {"sampleDlvrInfo"})
	public ModelMap sampleDlvrInfo(Model model, String postNo) {
		ModelMap map = new ModelMap();
		List<OrderDlvrAreaVO> list = orderDlvrAreaService.getDlvrPrcsListFromTime(postNo);
		map.addAttribute("list", list);
		return map;
	}

	@ResponseBody
	@RequestMapping(value = {"sampleDlvrInfoForGoods"})
	public ModelMap sampleDlvrInfoForGoods(Model model, String postNo) {
		ModelMap map = new ModelMap();
		List<OrderDlvrAreaVO> list = orderDlvrAreaService.getDlvrPrcsListForGoodsDetail();
		map.addAttribute("list", list);
		return map;	}


	@RequestMapping(value="/indexSocketTest")
	public String sampleSocket(Model model,HttpServletRequest request){
		String protocal = "wss://";
		if (StringUtil.equals(bizConfig.getProperty("envmt.gb"), FrontConstants.ENVIRONMENT_GB_LOCAL)) {
			protocal = "ws://";
		}
		model.addAttribute("protocal",protocal);
		return "sample/indexSocketTest";
	}


	/*
		2021.07.08
		R3K 소켓 통신 샘플 URL 작성 - kjy01(김재윤)
	 */

	@ResponseBody
	@RequestMapping(value="/socket-open")
	public String sckOpen(MpPntApproveReqVO vo,@RequestParam(value="sample",required = false)String sample) throws IOException {
		String result = CommonConstants.CONTROLLER_RESULT_CODE_SUCCESS;
		Socket socket = null;
		Boolean isOpend = false;
		SktmpConvertUtil<MpPntApproveReqVO, MpPntApproveResVO> util = new SktmpConvertUtil<>();
		//msg 확인
		String request = "";

		//샘플 있으면
		if(StringUtil.isNotEmpty(Optional.ofNullable(sample).orElseGet(()->""))){
			request = sample;
		}else{
			String msgStr = util.getReqData(vo);
			request = SktmpConstants.PRTNR_CODE + util.encrypt(msgStr) + "\n";
		}

		log.info("##### 송신 전문 #####");
		log.info("\n"+request + "\n");
		log.info("##### ##### #####");


		try{
			String host = bizConfig.getProperty("skt.membership.socket.host");
			Integer port = Integer.parseInt(bizConfig.getProperty("skt.membership.socket.port"));

			if(!StringUtil.equals(bizConfig.getProperty("envmt.gb"), FrontConstants.ENVIRONMENT_GB_LOCAL)){
				socket= new Socket(host,port);
				log.info("#### Socket Opened!!!\n\n");
				isOpend = socket.isConnected();

				//정상적으로 열렸을 때만
				if(isOpend){
					byte[] buf = new byte[300];
					byte[] ret_buf = new byte[300];

					for(int i=0; i<5; i+=1){
						Integer n = i+1;
						log.info("### {} 회 호출 ",n);
						//메세지 전송
						buf = request.getBytes();
						socket.getOutputStream().write(buf,0,buf.length);
						socket.setSoTimeout(30000);	// 30초 동안 응답 없으면 Timeout

						/*---------------------------------------------------------------------
						서버 전송 메시지 수신
						---------------------------------------------------------------------*/
						int count=0;
						count = socket.getInputStream().read(ret_buf, 0, ret_buf.length);

						log.info("### Return Code : {}", count);

						// 정상 수신인 경우 for loop를 빠져나간다
						if( count == 192 ){
							break;
						}

						// 수신 오류인 경우 소켓 닫고 for loop 처음으로 돌아간다
						log.info("### Receive Error,,, Retry !!!!!");
						if( i == 5){
							log.info("### ERROR ,,, PLZ Parameter Check Or Server Check");
							throw new CustomException(ExceptionConstants.ERROR_R3K_SOCKET_RECEIVE);
						}
					} // end for loop

					String receive = new String(ret_buf).trim();
					log.info("########## receive : {}",receive);
					/*-------------------------------------------------
					메시지 복호화

					- Triple DES 알로리즘을 이용
						192bit 키를 생성하여 메시지를 복호화 한다.
				-------------------------------------------------*/
					MpPntApproveResVO res = new MpPntApproveResVO();
					util.getResData(receive,res);
					log.info("Convert Object Debug \n {}",res);
					result = new ObjectMapper().writeValueAsString(res);
				}
			}else{
				log.info("#### 로컬에선 소켓 오픈 불가능합니다.");
				result = "#### 로컬에선 소켓 오픈 불가능합니다.";
			}
		}catch(Exception e){
			log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE,e);
			result = e.getMessage();
		}finally {
			if(socket != null && isOpend){
				log.info("#### Socket close");
				socket.close();
			}
		}
		return result;
	}

	@CrossOrigin("*")
	@RequestMapping(value="socket-open-local")
	public String getReceiveForLocal(String send) throws IOException{
		String result = CommonConstants.CONTROLLER_RESULT_CODE_SUCCESS;
		Socket socket = null;
		Boolean isOpend = false;

		//msg 확인
		String request = "";

		log.info("##### 송신 전문 #####");
		log.info("\n"+send + "\n");
		log.info("##### ##### #####");

		try{
			String host = bizConfig.getProperty("skt.membership.socket.host");
			Integer port = Integer.parseInt(bizConfig.getProperty("skt.membership.socket.port"));

			socket= new Socket(host,port);
			log.info("#### Socket Opened!!!\n\n");
			isOpend = socket.isConnected();

			//정상적으로 열렸을 때만
			if(isOpend){
				byte[] buf = new byte[300];
				byte[] ret_buf = new byte[300];

				for(int i=0; i<5; i+=1){
					Integer n = i+1;
					log.info("### {} 회 호출 ",n);
					//메세지 전송
					buf = request.getBytes();
					socket.getOutputStream().write(buf,0,buf.length);
					socket.setSoTimeout(30000);	// 30초 동안 응답 없으면 Timeout

					/*---------------------------------------------------------------------
					서버 전송 메시지 수신
					---------------------------------------------------------------------*/
					int count=0;
					count = socket.getInputStream().read(ret_buf, 0, ret_buf.length);

					log.info("### Return Code : {}", count);

					// 정상 수신인 경우 for loop를 빠져나간다
					if( count == 192 ){
						break;
					}

					// 수신 오류인 경우 소켓 닫고 for loop 처음으로 돌아간다
					log.info("### Receive Error,,, Retry !!!!!");
					if( i == 5){
						log.info("### ERROR ,,, PLZ Parameter Check Or Server Check");
						throw new CustomException(ExceptionConstants.ERROR_R3K_SOCKET_RECEIVE);
					}
				} // end for loop

				String receive = new String(ret_buf).trim();
				log.info("########## receive : {}",receive);
				/*-------------------------------------------------
				메시지 복호화

				- Triple DES 알로리즘을 이용
					192bit 키를 생성하여 메시지를 복호화 한다.
			-------------------------------------------------*/
				result = receive;
			}
		}catch(Exception e){
			log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE,e);
			result = e.getMessage();
		}finally {
			if(socket != null && isOpend){
				log.info("#### Socket close");
				socket.close();
			}
		}
		return result;
	}

}