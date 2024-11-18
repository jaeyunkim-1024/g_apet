package admin.web.view.member.controller;

import admin.web.config.grid.GridResponse;
import admin.web.config.view.View;
import biz.app.contents.model.ContentsReplySO;
import biz.app.contents.model.ContentsReplyVO;
import biz.app.contents.model.PetLogMgmtSO;
import biz.app.contents.model.PetLogMgmtVO;
import biz.app.contents.service.PetLogMgmtService;
import biz.app.contents.service.ReplyService;
import biz.app.goods.model.GoodsBaseSO;
import biz.app.goods.model.GoodsBaseVO;
import biz.app.goods.model.GoodsCommentSO;
import biz.app.goods.model.GoodsCommentVO;
import biz.app.goods.service.GoodsCommentService;
import biz.app.member.model.*;
import biz.app.member.service.MemberCouponService;
import biz.app.member.service.MemberSavedMoneyService;
import biz.app.member.service.MemberService;
import biz.app.order.service.OrderService;
import biz.app.pay.model.PrsnCardBillingInfoPO;
import biz.app.pay.model.PrsnCardBillingInfoVO;
import biz.app.pay.model.PrsnPaySaveInfoVO;
import biz.app.pet.model.PetBaseSO;
import biz.app.pet.model.PetBaseVO;
import biz.app.pet.model.PetInclRecodeVO;
import biz.app.pet.service.PetService;
import biz.app.system.model.PrivacyCnctHistPO;
import biz.app.system.service.PrivacyCnctService;
import biz.app.tag.model.TagBaseSO;
import biz.app.tag.model.TagBaseVO;
import biz.common.model.EmailRecivePO;
import biz.common.model.EmailSendPO;
import biz.common.service.BizService;
import biz.common.service.CacheService;
import biz.interfaces.sktmp.model.SktmpCardInfoVO;
import framework.admin.constants.AdminConstants;
import framework.admin.model.Session;
import framework.admin.util.AdminSessionUtil;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import framework.common.model.BaseSearchVO;
import framework.common.model.ExcelViewParam;
import framework.common.util.DateUtil;
import framework.common.util.ExcelUtil;
import framework.common.util.MaskingUtil;
import framework.common.util.StringUtil;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.codec.binary.Hex;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.File;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.security.MessageDigest;
import java.text.SimpleDateFormat;
import java.util.*;

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
@Slf4j
@Controller
public class MemberController {

	/**
	 * 회원 서비스
	 */
	@Autowired private MemberService memberService;

	@Autowired private CacheService cacheService;

	@Autowired private PrivacyCnctService privacyCnctService;

	@Autowired private MemberSavedMoneyService memberSavedMoneyService;

	@Autowired private GoodsCommentService goodsCommentService;

	@Autowired private MemberCouponService memberCouponService;

	@Autowired private PetLogMgmtService petLogService;

	@Autowired private ReplyService replyService;

	@Autowired private PetService petService;

	@Autowired private OrderService orderService;

	@Autowired private PetLogMgmtService petLogMgmtService;

	@Autowired private BizService bizService;

	@Autowired 	private Properties bizConfig;

	@Autowired
	HttpServletRequest request;

	@Value("#{bizConfig['nicepay.api.billing.mid']}")
	private String unauthMerchantID;

	@Value("#{bizConfig['nicepay.api.billing.merchant.key']}")
	private String unauthMerchantKey;

	@Value("#{bizConfig['nicepay.billing.delete.api.url']}")
	private String billingDeleteUrl;

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: MemberController.java
	 * - 작성일		: 2016. 4. 21.
	 * - 작성자		: valueFactory
	 * - 설명		: 회원 목록 화면
	 * </pre>
	 * @return
	 */
	@RequestMapping("/member/memberSearchView.do")
	public String memberListView(HttpServletRequest req , Model model , MemberBaseSO so) {
		model.addAttribute("url",req.getRequestURI());
		model.addAttribute("search",so);
		return "/member/memberSearchView";
	}
	@RequestMapping("/member/memberListView.do")
	public String memberListView(Model model) {
		model.addAttribute("startValue",DateUtil.getDatePickerValue(-100,"Y"));
		model.addAttribute("endValue",DateUtil.getDatePickerValue(-100,"Y"));
		model.addAttribute("today",DateUtil.calDate("yyyy-MM-dd"));
		model.addAttribute("strtDtm",DateUtil.getDatePickerValue(-1,"M"));

		model.addAttribute("tags",cacheService.listCodeCache(CommonConstants.INT_TAG_INFO_CD, true, null, null, null, null, null));
		return "/member/memberListView";
	}

	@RequestMapping("/member/mbrNoExcelDownload.do")
	public String mbrNoExcelDownload(HttpServletResponse res, MemberBaseSO so, Model model){
		/*Long mbrNo = Optional.ofNullable(so.getMbrNo()).orElseGet(()->0l);
		String loginId = Optional.ofNullable(so.getMbrNm()).orElseGet(()->"");
		String nickNm = Optional.ofNullable(so.getNickNm()).orElseGet(()->"");
		String mobile = Optional.ofNullable(so.getMobile()).orElseGet(()->"");
		String mbrNm = Optional.ofNullable(so.getMbrNm()).orElseGet(()->"");
		String email = Optional.ofNullable(so.getEmail()).orElseGet(()->"");
		String rcomLoginId = Optional.ofNullable(so.getRcomLoginId()).orElseGet(()->"");

		Boolean isNotSeach = Long.compare(mbrNo,0L) == 0
				&& StringUtil.isEmpty(loginId) && StringUtil.isEmpty(nickNm)
				&& StringUtil.isEmpty(mobile) && StringUtil.isEmpty(mbrNm)
				&& StringUtil.isEmpty(email) && StringUtil.isEmpty(rcomLoginId) ;*/

		//so.setRows(9999999);
		//List<MemberBaseVO> list = isNotSeach ? new ArrayList<>() : memberService.listMemberGrid(so);
		res.setHeader("Set-Cookie", "fileDownload=true; path=/");//중요
		
		so.setIsExcelDown("Y");
		List<MemberBaseVO> list = so.getIsNotSearch() != CommonConstants.COMM_YN_Y ? memberService.listMemberGrid(so) : new ArrayList<>();
		String[] headerName = {"회원 번호"};
		String[] fieldName = {"mbrNo"};

		model.addAttribute(CommonConstants.EXCEL_PARAM_NAME, new ExcelViewParam("MbrNoList", headerName, fieldName, list));
		model.addAttribute(CommonConstants.EXCEL_PARAM_FILE_NAME, "MbrNoList");
		return View.excelDownload();
	}

	@ResponseBody
	@RequestMapping("/member/unlockPrivacyMasking.do")
	public Long unlockPrivacyMasking(PrivacyCnctHistPO po) {
        po.setColGbCd(AdminConstants.COL_GB_00);
		po.setInqrGbCd(AdminConstants.INQR_GB_10);
		return privacyCnctService.insertPrivacyCnctInquiry(po);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: MemberController.java
	 * - 작성일		: 2016. 4. 21.
	 * - 작성자		: valueFactory
	 * - 설명		: 회원 목록 그리드
	 * </pre>
	 * @param so
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/member/memberListGrid.do", method=RequestMethod.POST)
	public GridResponse memberListGrid(MemberBaseSO so,BindingResult br) {
		/*Long mbrNo = Optional.ofNullable(so.getMbrNo()).orElseGet(()->0l);
		String loginId = Optional.ofNullable(so.getMbrNm()).orElseGet(()->"");
		String nickNm = Optional.ofNullable(so.getNickNm()).orElseGet(()->"");
		String mobile = Optional.ofNullable(so.getMobile()).orElseGet(()->"");
		String mbrNm = Optional.ofNullable(so.getMbrNm()).orElseGet(()->"");
		String email = Optional.ofNullable(so.getEmail()).orElseGet(()->"");
		String rcomLoginId = Optional.ofNullable(so.getRcomLoginId()).orElseGet(()->"");

		Boolean isNotSeach = Long.compare(mbrNo,0L) == 0
				&& StringUtil.isEmpty(loginId) && StringUtil.isEmpty(nickNm)
				&& StringUtil.isEmpty(mobile) && StringUtil.isEmpty(mbrNm)
				&& StringUtil.isEmpty(email) && StringUtil.isEmpty(rcomLoginId) ;
		
		List<MemberBaseVO> list = isNotSeach ? new ArrayList<>() : memberService.listMemberGrid(so);*/
		List<MemberBaseVO> list = so.getIsNotSearch() != CommonConstants.COMM_YN_Y ? memberService.listMemberGrid(so) : new ArrayList<>();
		return new GridResponse(list, so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: MemberController.java
	 * - 작성일		: 2016. 4. 21.
	 * - 작성자		: valueFactory
	 * - 설명		: 회원 상세 화면
	 * </pre>
	 * @param model
	 * @param so
	 * @param br
	 * @return
	 */
	@RequestMapping("/*/memberView.do")
	public String memberView(Model model ,MemberBaseSO so, MemberAddressSO memberAddressSO ,String viewGb, BindingResult br) {
		if(br.hasErrors()) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		model.addAttribute("member", memberService.getMemberBaseBO(so));

		// LayOut 설정
		String layOut = AdminConstants.LAYOUT_DEFAULT;

		if(AdminConstants.VIEW_GB_POP.equals(viewGb)){
			layOut = AdminConstants.LAYOUT_POP;
		}
		model.addAttribute("layout", layOut);

		return "/member/memberView";
	}

	@ResponseBody
	@RequestMapping(value="/member/memberSavedMoneyListGrid.do", method=RequestMethod.POST)
	public GridResponse memberSavedMoneyListGrid(MemberSavedMoneySO so) {
		List<MemberSavedMoneyVO> list = memberService.pageMemberSavedMoney(so);
		return new GridResponse(list, so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: MemberController.java
	 * - 작성일		: 2016. 4. 21.
	 * - 작성자		:
	 * - 설명		: 회원 적립금 상세 그리드목록
	 * </pre>
	 * @param so
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/member/memberSavedMoneyDetailListGrid.do", method=RequestMethod.POST)
	public GridResponse memberSavedMoneyDetailListGrid(MemberSavedMoneyDetailSO so) {
		List<MemberSavedMoneyDetailVO> list = memberService.listMemberSavedMoneyDetail(so);
		return new GridResponse(list, so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: MemberController.java
	 * - 작성일		: 2016. 4. 21.
	 * - 작성자		: valueFactory
	 * - 설명		: 회원 배송지 목록
	 * </pre>
	 * @param so
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/member/memberAddressListGrid.do", method=RequestMethod.POST)
	public GridResponse memberAddressListGrid(MemberAddressSO so) {
		so.setSidx("SYS_REG_DTM");
		so.setSord("DESC");
		List<MemberAddressVO> list = memberService.listMemberAddress(so);
		return new GridResponse(list, so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: MemberController.java
	 * - 작성일		: 2021. 03. 16.
	 * - 작성자		: 김재윤
	 * - 설명		: 회원 간편 카드 결제 목록
	 * </pre>
	 * @param so
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/member/memberCardListGrid.do", method=RequestMethod.POST)
	public GridResponse memberCardListGrid(MemberBaseSO so) {
		so.setRows(5);
		so.setSidx("PCBI.SYS_REG_DTM");
		List<PrsnCardBillingInfoVO> list = memberService.listMemberCardBillingInfo(so);
		Integer rowIndex = so.getTotalCount() - (((int)so.getPage()-1)*so.getRows());
		for(PrsnCardBillingInfoVO v : list){
			v.setRowIndex(rowIndex);
			rowIndex -=1;
		}
		return new GridResponse(list, new BaseSearchVO<>());
	}

	@ResponseBody
	@RequestMapping(value = "/member/card-delete.do" , method = RequestMethod.POST)
	public Map registBillingCard(PrsnCardBillingInfoPO pcbipo) throws Exception {
		PrsnCardBillingInfoVO cardBillInfo = memberService.getBillCardInfo(pcbipo);
		Long mbrNo = pcbipo.getMbrNo();
		int registCardCnt = cardBillInfo.getRegistCardCnt();
		String merchantID = unauthMerchantID;
		String merchantKey = unauthMerchantKey;
		DataEncrypt sha256Enc 	= new DataEncrypt();
		String ediDate			= getyyyyMMddHHmmss();
		String moid = cardBillInfo.getPgMoid();
		String bid = cardBillInfo.getPgBid();
		String hashString = sha256Enc.encrypt(merchantID + ediDate + moid + bid + merchantKey);


		StringBuffer requestData = new StringBuffer();

		requestData.append("BID=").append(cardBillInfo.getPgBid()).append("&");
		requestData.append("MID=").append(merchantID).append("&");
		requestData.append("EdiDate=").append(ediDate).append("&");
		requestData.append("Moid=").append(cardBillInfo.getPgMoid()).append("&");
		requestData.append("SignData=").append(hashString).append("&");
		requestData.append("CharSet=").append("utf-8").append("&");
		requestData.append("EdiType=").append("JSON");

		String resultJsonStr = connectToServer(requestData.toString(), billingDeleteUrl);

		log.debug("==================================================================");
		log.debug("NICEPAY : BILLING DELETE RESULT: {} ", resultJsonStr);
		log.debug("==================================================================");

		String ResultCode 	= ""; // 결과 코드
		String ResultMsg 	= ""; // 결과 메시지
		HashMap resultData = new HashMap();
		Map<String,String> map = new HashMap<String,String>();

		if(!"ERROR".equals(resultJsonStr)){

			resultData = jsonStringToHashMap(resultJsonStr);
			ResultCode 	= (String)resultData.get("ResultCode");
			ResultMsg 	= (String)resultData.get("ResultMsg");

			// 삭제 성공
			if(CommonConstants.NICEPAY_BILLING_DELETE_SUCCESS.equals(ResultCode)) {

				// 빌링 정보 update > data 삭제로 변경 2021.04.14(지종근차장 요청사항 : 유준희실장 confirm)
				PrsnCardBillingInfoPO delpo = new PrsnCardBillingInfoPO();

				delpo.setPrsnCardBillNo(pcbipo.getPrsnCardBillNo());
				delpo.setMbrNo(mbrNo);

				orderService.deleteBillCardInfo(delpo);

				// 삭제한 카드가 기본결제수단일때 기본결제수단 TABLE DATA 삭제 처리
				PrsnPaySaveInfoVO ppsivo =  memberService.getMemberPaySaveInfo(mbrNo);

				if(ppsivo != null){
					if(ppsivo.getPayMeansCd() != null && !"".equals(ppsivo.getPayMeansCd())){
						if(CommonConstants.PAY_MEANS_11.equals(ppsivo.getPayMeansCd())){


							if(Integer.parseInt(ppsivo.getPrsnCardBillNo()) == pcbipo.getPrsnCardBillNo()){

								memberService.deletePrsnSavePayInfo(mbrNo);
							}

						}
					}
				}

				// 모든 카드가 삭제 되었다면 member_base 간편카드 인증 비밀번호 초기화
				if(registCardCnt == 1){

					MemberBasePO mbpo = new MemberBasePO();

					mbpo.setRemoveBillYn(CommonConstants.COMM_YN_Y);
					mbpo.setMbrNo(mbrNo);

					memberService.updateMemberBase(mbpo);
				}

				map.put("resultCode", ResultCode);
				map.put("resultMsg", ResultMsg);

			}else{
				// 삭제 실패
				map.put("resultCode", ResultCode);
				map.put("resultMsg", ResultMsg);

			}
		}else{
			throw new CustomException(ExceptionConstants.ERROR_REQUEST);
		}
		return map;
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: MemberController.java
	 * - 작성일		: 2021. 08. 05.
	 * - 작성자		: hjh
	 * - 설명		: 회원 우주코인 멤버십 목록
	 * </pre>
	 * @param so
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/member/memberSktmpListGrid.do", method=RequestMethod.POST)
	public GridResponse memberSktmpListGrid(MemberBaseSO so) {
		so.setSidx("MCI.SYS_REG_DTM");
		so.setSord("DESC");
		List<SktmpCardInfoVO> list = memberService.listMemberSktmpCardInfo(so);
		
		Integer rowIndex = so.getTotalCount() - (((int)so.getPage()-1)*so.getRows());
		for(SktmpCardInfoVO v : list){
			v.setRowIndex(rowIndex);
			rowIndex -=1;
		}
		
		return new GridResponse(list, so);
	}

	private final synchronized String getyyyyMMddHHmmss(){
		SimpleDateFormat yyyyMMddHHmmss = new SimpleDateFormat("yyyyMMddHHmmss");
		return yyyyMMddHHmmss.format(new Date());
	}

	// SHA-256 형식으로 암호화
	private static class DataEncrypt{
		MessageDigest md;
		String strSRCData = "";
		String strENCData = "";
		String strOUTData = "";

		public String encrypt(String strData){
			String passACL = null;
			MessageDigest md = null;
			try{
				md = MessageDigest.getInstance("SHA-256");
				md.reset();
				md.update(strData.getBytes());
				byte[] raw = md.digest();
				passACL = encodeHex(raw);
			}catch(Exception e){
				log.debug("암호화 에러" + e.toString());
			}
			return passACL;
		}

		public String encodeHex(byte [] b){
			char [] c = Hex.encodeHex(b);
			return new String(c);
		}
	}
	public String connectToServer(String data, String reqUrl) throws Exception{
		HttpURLConnection conn 		= null;
		BufferedReader resultReader = null;
		PrintWriter pw 				= null;
		URL url 					= null;

		int statusCode = 0;
		StringBuffer recvBuffer = new StringBuffer();
		try{
			url = new URL(reqUrl);
			conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("POST");
			conn.setConnectTimeout(3000);
			conn.setReadTimeout(5000);
			conn.setDoOutput(true);

			pw = new PrintWriter(conn.getOutputStream());
			pw.write(data);
			pw.flush();

			statusCode = conn.getResponseCode();
			resultReader = new BufferedReader(new InputStreamReader(conn.getInputStream(), "utf-8"));
			for(String temp; (temp = resultReader.readLine()) != null;){
				recvBuffer.append(temp).append("\n");
			}

			if(!(statusCode == HttpURLConnection.HTTP_OK)){
				throw new Exception();
			}

			return recvBuffer.toString().trim();
		}catch (Exception e){
			return "9999";
		}finally{
			recvBuffer.setLength(0);

			try{
				if(resultReader != null){
					resultReader.close();
				}
			}catch(Exception ex){
				resultReader = null;
			}

			try{
				if(pw != null) {
					pw.close();
				}
			}catch(Exception ex){
				pw = null;
			}

			try{
				if(conn != null) {
					conn.disconnect();
				}
			}catch(Exception ex){
				conn = null;
			}
		}
	}
	//JSON String -> HashMap 변환
	private static HashMap jsonStringToHashMap(String str) throws Exception{
		HashMap dataMap = new HashMap();
		JSONParser parser = new JSONParser();
		try{
			Object obj = parser.parse(str);
			JSONObject jsonObject = (JSONObject)obj;

			Iterator<String> keyStr = jsonObject.keySet().iterator();
			while(keyStr.hasNext()){
				String key = keyStr.next();
				Object value = jsonObject.get(key);

				dataMap.put(key, value);
			}
		}catch(Exception e){

		}
		return dataMap;
	}

	@RequestMapping("/member/memberUpdateLayerView.do")
	public String memberUpdateLayerView(Model model,String mbrStatCd) {
		model.addAttribute("mbrStatCd",mbrStatCd);
		return "/member/memberUpdateLayerView";
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: MemberController.java
	 * - 작성일		: 2016. 4. 21.
	 * - 작성자		: valueFactory
	 * - 설명		: 회원 정보 수정
	 * </pre>
	 * @param model
	 * @param po
	 * @param br
	 * @return
	 */
	@RequestMapping("/member/memberUpdate.do")
	public String memberUpdate(Model model, MemberBasePO po, BindingResult br) {
		if ( br.hasErrors() ) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		memberService.updateMemberBase(po);
		return View.jsonView();
	}

	@ResponseBody
	@RequestMapping("/member/updateMemberStatCd.do")
	public Long updateMemberStatCd(MemberBasePO po , PrivacyCnctHistPO cnctpo){
		po.setSysUpdrNo(AdminSessionUtil.getSession().getUsrNo());
		memberService.updateMemberStatCd(po);
		if(Long.compare(Optional.ofNullable(cnctpo.getCnctHistNo()).orElseGet(()->0L),0L) != 0){
			cnctpo.setColGbCd(AdminConstants.COL_GB_20);
			cnctpo.setInqrGbCd(AdminConstants.INQR_GB_20);
			privacyCnctService.insertPrivacyCnctInquiry(cnctpo);
		}
		return po.getMbrNo();
	}

	@RequestMapping("/member/memberHumanCancellationUpdate.do")
	public String memberHumanCancellationUpdate(Model model, MemberBasePO po, BindingResult br) {
		if ( br.hasErrors() ) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		memberService.updateMemberHumanCancellation(po);
		return View.jsonView();
	}

	@RequestMapping("/member/memberMbrGrdUpdate.do")
	public String memberMbrGrdUpdate(Model model, MemberBasePO po, BindingResult br) {
		if ( br.hasErrors() ) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		memberService.updateMemberMbrGrdCd(po);
		return View.jsonView();
	}

	@RequestMapping("/member/memberAddressSave.do")
	public String memberAddressSave(Model model, MemberAddressPO po, BindingResult br) {
		if ( br.hasErrors() ) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		memberService.saveMemberAddress(po);
		return View.jsonView();
	}


	@RequestMapping("/member/memberSavedMoneyInsert.do")
	public String memberSavedMoneyInsert(Model model, MemberSavedMoneyPO po, BindingResult br) {
		if ( br.hasErrors() ) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

		po.setSvmnPrcsCd(CommonConstants.SVMN_PRCS_10);

		this.memberSavedMoneyService.insertMemberSavedMoney(po);
		return View.jsonView();
	}

	@RequestMapping("/member/memberSavedMoneyListView.do")
	public String memberSavedMoneyListView() {
		return "/member/memberSavedMoneyListView";
	}

	@RequestMapping("/member/memberSavedMoneyListInsert.do")
	public String memberSavedMoneyListInsert(Model model, Long[] arrMbrNo, MemberSavedMoneyPO po, BindingResult br) {
		if ( br.hasErrors() ) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

		po.setSvmnPrcsCd(CommonConstants.SVMN_PRCS_10);

		this.memberSavedMoneyService.insertMemberSavedMoneyList(arrMbrNo, po);
		return View.jsonView();
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: MemberController.java
	 * - 작성일		: 2016. 9 27.
	 * - 작성자		: hjko
	 * - 설명		: 관리자가 회원 적립금 차감
	 * </pre>
	 * @param model
	 * @param po
	 * @param br
	 * @return
	 */
	@RequestMapping("/member/memberSavedMoneyRemove.do")
	public String memberSavedMoneyRemove(Model model, MemberSavedMoneyPO po, BindingResult br) {
		if ( br.hasErrors() ) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

		po.setSvmnPrcsCd(CommonConstants.SVMN_PRCS_20);
		po.setSvmnPrcsRsnCd(CommonConstants.SVMN_PRCS_RSN_220);
		// 차감일 때 SVMN_RSN 코드는 없음.

		memberService.memberSavedMoneyRemove(po);

		return View.jsonView();
	}

	/**
	 *
	 * <pre>
	 * - 프로젝트명   : 41.admin.web
	 * - 패키지명   : admin.web.view.member.controller
	 * - 파일명      : MemberController.java
	 * - 작성일      : 2017. 4. 25.
	 * - 작성자      : valuefactory 권성중
	 * - 설명      :   사용자 이력 히스토리 그리드
	 * </pre>
	 */
	@ResponseBody
	@RequestMapping(value="/member/memberBaseHistoryListGrid.do", method=RequestMethod.POST)
	public GridResponse memberBaseHistoryListGrid(MemberBaseSO so) {
		//log.debug("☆☆☆☆☆☆☆☆ : {} ", so.toString());
		List<MemberBaseVO> list = memberService.listMemberBaseHistory(so);
		return new GridResponse(list, so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: MemberController.java
	 * - 작성일		: 2017. 5. 29.
	 * - 작성자		: Administrator
	 * - 설명			: 회원 적립금 이력 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	@ResponseBody
	@RequestMapping( value="/member/memberSavedMoneyHist.do", method=RequestMethod.POST )
	public GridResponse memberSavedMoneyHist( MemberSavedMoneySO so ) {
		// 최근 목록 수
		so.setSidx("SYS_REG_DTM"); //정렬 컬럼 명
		so.setSord(AdminConstants.SORD_DESC);
		so.setPrcsDtmStart(DateUtil.convertSearchDate("S", so.getPrcsDtmStart()));
		so.setPrcsDtmEnd(DateUtil.convertSearchDate("E", so.getPrcsDtmEnd()));
		// 적립금 이력 목록 취득
		List<MemberSavedMoneyVO> memberSavedMoneyList = memberService.pageMemberSavedMoneyHist(so);
		return new GridResponse(memberSavedMoneyList, so);
	}


	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: MemberController.java
	 * - 작성일		: 2017. 5. 29.
	 * - 작성자		: Administrator
	 * - 설명			: 사용 완료 쿠폰 목록 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	@ResponseBody
	@RequestMapping( value="/member/memberCouponCompletionListGrid.do", method=RequestMethod.POST )
	public GridResponse memberCouponCompletionListGrid( MemberCouponSO so  ) {

		so.setSidx("MC.SYS_REG_DTM"); //정렬 컬럼 명
		so.setSord(AdminConstants.SORD_DESC);
		so.setMbrNo(so.getMbrNo());
		so.setUseYn(CommonConstants.USE_YN_Y);

		List<MemberCouponVO> memberCouponComList = this.memberCouponService.memberListComCouponPage(so);

		return new GridResponse(memberCouponComList, so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: MemberController.java
	 * - 작성일		: 2017. 5. 29.
	 * - 작성자		: Administrator
	 * - 설명			: 회원의 사용가능한 쿠폰 목록 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	@ResponseBody
	@RequestMapping( value="/member/memberCouponPossibleListGrid.do", method=RequestMethod.POST )
	public GridResponse memberCouponPossibleListGrid( MemberCouponSO so  ) {

		so.setSidx("MC.SYS_REG_DTM"); //정렬 컬럼 명
		so.setSord(AdminConstants.SORD_DESC);
		so.setMbrNo(so.getMbrNo());
		so.setUseYn(CommonConstants.USE_YN_N);
		List<MemberCouponVO> memberCouponPossibleList = this.memberCouponService.memberListCouponPage(so);
		return new GridResponse(memberCouponPossibleList, so);
	}

	/**
	 *
	 * <pre>
	 * - 프로젝트명   : 41.admin.web
	 * - 패키지명   : admin.web.view.member.controller
	 * - 파일명      : MemberController.java
	 * - 작성일      : 2017. 7. 25.
	 * - 작성자      : valuefactory 권성중
	 * - 설명      :  비밀번호 초기화
	 * </pre>
	 */
	@RequestMapping("/member/memberPasswordUpdate.do")
	public String memberPasswordUpdate(Model model, MemberBasePO po, BindingResult br) {
		if ( br.hasErrors() ) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		memberService.memberPasswordUpdate(po);

		//이력 등록
		try {
			memberService.insertMemberBaseHistory(po.getMbrNo());
		} catch (Exception e) {
			log.error("41.admin.web.MemberController.memberPasswordUpdate : {} ", po.getMbrNo());
		}

		return View.jsonView();
	}

	@RequestMapping(value="/member/getMemberBaseInShort.do" , method=RequestMethod.GET)
	public String getMemberBase(MemberBaseSO so , Model model , PrivacyCnctHistPO po){
		if(StringUtil.isNull(so.getLoginId()) && StringUtil.isNull(so.getMobile()) && StringUtil.isNull(so.getEmail())
				&& Long.compare(Optional.ofNullable(so.getMbrNo()).orElseGet(()->0L),0L) == 0){
			return "/member/memberBaseInfo";
		}
		MemberBaseVO member = memberService.getMemberBaseInShort(so);
		if(StringUtil.equals(member.getBirth(),"00000000")){
			member.setBirth(null);
		}
		Long mbrNo = Optional.ofNullable(member.getMbrNo()).orElseGet(()->0L);

		if(Long.compare(mbrNo,0L) != 0){
			model.addAttribute("member",member);

			//개인정보 접속 이력
			po.setActGbCd(AdminConstants.ACT_GB_10);
			Long cnctHistNo = Optional.ofNullable(po.getCnctHistNo()).orElseGet(()->privacyCnctService.insertPrivacyCnctHist(po));
			model.addAttribute("cnctHistNo",cnctHistNo);

			//이미 조회한 상태이면 넘어온 값 SET 유지, 아니면 이력 INSERT
			po.setCnctHistNo(cnctHistNo);
			po.setColGbCd(AdminConstants.COL_GB_00);
			po.setMbrNo(mbrNo);
			po.setInqrGbCd(StringUtil.equals(so.getMaskingUnlock(),AdminConstants.COMM_YN_Y) ?
					AdminConstants.INQR_GB_10 : AdminConstants.INQR_GB_40);
			Long inqrHistNo = Optional.ofNullable((po.getInqrHistNo())).orElseGet(()->privacyCnctService.insertPrivacyCnctInquiry(po));
			model.addAttribute("inqrHistNo",inqrHistNo);
		}

		return "/member/memberBaseInfo";
	}

	@RequestMapping(value="/member/memberDetailLayerPop.do")
	public String memberDetailLayerPop(MemberBaseSO so,Model model){
		MemberBaseVO member = memberService.getMemberBaseBO(so);
		if(StringUtil.equals(member.getBirth(),"00000000")){
			member.setBirth(null);
		}
		model.addAttribute("member",member);

		return "/member/memberDetailLayerPop";
	}

	@RequestMapping(value="/member/updateMemberRcvYn.do")
	public String updatePrivacyMarketingRcvYn(Model model,MemberBasePO po){
		Long mbrNo = po.getMbrNo();
		MemberBaseSO so = new MemberBaseSO();
		so.setMbrNo(mbrNo);
		so.setMaskingUnlock(AdminConstants.COMM_YN_Y);
		MemberBaseVO vo = memberService.getMemberBaseInShort(so);
		String mobile = vo.getMobile().replaceAll("-","");
		po.setMobile(mobile);
		po.setChgActrCd(AdminConstants.CHG_ACTR_MBR);
		model.addAttribute("sysUpdDtm",memberService.updateMemberRcvYn(po));
		return View.jsonView();
	}


	//회원 관리 - 서브탭 시작

	@RequestMapping("/member/memberPayView.do")
	public String memberPayView(Model model,MemberBaseSO so){
		model.addAttribute("so",so);
		return "/member/memberTab/memberPayView";
	}

	@RequestMapping("/member/memberPetLogView.do")
	public String memberPetLogView(Model model,MemberBaseSO so){
		model.addAttribute("so",so);
		return "/member/memberTab/memberPetLogView";
	}

	@ResponseBody
	@RequestMapping(value = "/member/listMemberPetLog.do", method = RequestMethod.POST)
	public GridResponse listPetLog(PetLogMgmtSO so,String maskingUnlock) {
		if (log.isDebugEnabled()) {
			log.debug("==================================================");
			log.debug("= {}", "petlog listPetLog");
			log.debug("==================================================");
		}

		Session session = AdminSessionUtil.getSession();
		if(so.getTag() != null && !"".equals(so.getTag())) {
			String[] tags = so.getTag().replace(" ", "").split(",");
			so.setTags(tags);
		}
//		so.setRows(5);
		List<PetLogMgmtVO> list = petLogMgmtService.pagePetLog(so);

		for(PetLogMgmtVO v : list){
			String loginId = v.getLoginId();
			loginId = bizService.twoWayDecrypt(loginId);

			loginId = StringUtil.equals(maskingUnlock,AdminConstants.COMM_YN_Y) ? loginId : MaskingUtil.getId(loginId);
			v.setLoginId(loginId);
		}

		return new GridResponse(list, so);
	}


	@RequestMapping("/member/memberGoodsReview.do")
	public String memberGoodsReview(Model model,MemberBaseSO so){
		model.addAttribute("so",so);
		return "/member/memberTab/memberGoodsReview";
	}

	@ResponseBody
	@RequestMapping("/member/listGoodsCommentView.do")
	public GridResponse goodsCommentGrid(GoodsCommentSO so,String maskingUnlock){
		// 업체사용자일 때 업체번호를 항상 조회조건에 사용하도록 수정함.
		Session session = AdminSessionUtil.getSession();
		String usrGrpCd = Optional.ofNullable(session.getUsrGrpCd()).orElseGet(()->"");
		if (StringUtils.equals(CommonConstants.USR_GRP_20, usrGrpCd)) {
			so.setCompNo(AdminSessionUtil.getSession().getCompNo());
		}

		List<GoodsCommentVO> list = new ArrayList<GoodsCommentVO>();
		if(Long.compare(Optional.ofNullable(so.getEstmMbrNo()).orElseGet(()->0L),0L)!=0){
			so.setSidx("Y.SYS_REG_DTM");
			so.setSord("DESC");
//			so.setRows(5);
			list = Optional.ofNullable(goodsCommentService.pageGoodsCommentGrid(so)).orElseGet(()->new ArrayList<>());

			list.stream().forEach(v ->{
				if(StringUtil.isEmpty(v.getContent())) {
					v.setContent("[내용없음]");
				}
			});
			/*Integer rowNum = so.getTotalCount() - (((int)so.getPage()-1)*so.getRows());
			for(GoodsCommentVO v : list){
				v.setRowNum(Long.parseLong(rowNum.toString()));
				rowNum -=1;
			}*/
		}

		return new GridResponse(list, so);
	}

	@RequestMapping("/member/memberReplyView.do")
	public String memberCommentView(Model model,MemberBaseSO so){
		model.addAttribute("so",so);
		return "/member/memberTab/memberReplyView";
	}

	@ResponseBody
	@RequestMapping("/member/listMemberReply.do")
	public GridResponse listMembeReply(MemberBaseSO so){
		ContentsReplySO rso = new ContentsReplySO();
		rso.setSidx("T1.SYS_REG_DTM");
		rso.setSord("DESC");
		List<ContentsReplyVO> list = new ArrayList<ContentsReplyVO>();
		Integer page = Optional.ofNullable(so.getPage()).orElseGet(()->1);
		if(Long.compare(Optional.ofNullable(so.getMbrNo()).orElseGet(()->0L),0L) != 0){
			rso.setPage(page);
//			rso.setRows(5);
			rso.setMbrNo(so.getMbrNo());
			list = memberService.listMemberReply(rso);

			Integer rowNum = rso.getTotalCount() - (((int)rso.getPage()-1)*rso.getRows());
			for(ContentsReplyVO v : list){
				v.setRowNum(Long.parseLong(rowNum.toString()));
				rowNum -=1;
			}
		}
		return new GridResponse(list,rso);
	}

	@RequestMapping("/member/memberReportView.do")
	public String memberReportView(Model model,MemberBaseSO so){
		model.addAttribute("so",so);
		return "/member/memberTab/memberReportView";
	}

	@ResponseBody
	@RequestMapping("/member/listMemberReport.do")
	public GridResponse listMemberReport(MemberBaseSO so){
		List<ContentsReplyVO> list = new ArrayList<ContentsReplyVO>();
		Long mbrNo = Optional.ofNullable(so.getMbrNo()).orElseGet(()->0L);
		if(Long.compare(mbrNo,0L) != 0){
//			so.setRows(5);
			so.setSidx("T1.SYS_REG_DTM");
			so.setSord("DESC");
			list = memberService.listMemberReportList(so);

			Integer rowIndex = so.getTotalCount() - (((int)so.getPage()-1)*so.getRows());
			for(ContentsReplyVO v : list){
				v.setRowIndex(Long.parseLong(rowIndex.toString()));
				rowIndex -=1;
			}
		}
		return new GridResponse(list,so);
	}

	@RequestMapping("/member/memberTagFollow.do")
	public String memberTag(Model model,MemberBaseSO so){
		model.addAttribute("so",so);
		return "/member/memberTab/memberTagFollow";
	}

	@ResponseBody
	@RequestMapping("/member/listMemberTagFollow.do")
	public GridResponse listMemberTagFollow(Model model,TagBaseSO so){
		Long mbrNo = Optional.ofNullable(so.getMbrNo()).orElseGet(()->0L);
		List<TagBaseVO> list = new ArrayList<TagBaseVO>();
		if(Long.compare(mbrNo,0L) != 0){
			so.setSidx("FMT.SYS_REG_DTM");
			so.setSord("DESC");
//			so.setRows(99);

			list = memberService.listMemberTagFollow(so);

			Integer rowIndex = so.getTotalCount() - (((int)so.getPage()-1)*so.getRows());
			for(TagBaseVO v : list){
				v.setRowIndex(Long.parseLong(rowIndex.toString()));
				rowIndex -=1;
			}
		}
		return new GridResponse(list,so);
	}

	@RequestMapping("/member/memberRecommandView.do")
	public String memberRecommandView(Model model,MemberBaseSO so){
		model.addAttribute("so",so);
		return "/member/memberTab/memberRecommandView";
	}

	@ResponseBody
	@RequestMapping(value={"/member/listMemberRecommandedListGrid.do","/member/listMemberRecommandingListGrid.do"})
	public GridResponse listRecommandListGrid(MemberBaseSO so){
		List<MemberBaseVO> list = new ArrayList<>();
		if(Long.compare(Optional.ofNullable(so.getMbrNo()).orElseGet(()->0L),0L) != 0){
			so.setSidx("MB.SYS_REG_DTM");
			so.setSord("DESC");
			so.setRows(10);
			list = StringUtil.equals(so.getRecommandGbCd(),AdminConstants.RECOMMAND_GB_10) ?
					memberService.listRecommandedList(so) : memberService.listRecommandingList(so) ;
			Boolean maskingFlag = StringUtil.equals(so.getMaskingUnlock(),AdminConstants.COMM_YN_N);

			Integer rowIndex = so.getTotalCount() - (((int)so.getPage()-1)*so.getRows());
			for(MemberBaseVO vo : list){
				//복호화
				vo.setMbrNm(bizService.twoWayDecrypt(vo.getMbrNm()));
				vo.setEmail(bizService.twoWayDecrypt(vo.getEmail()));
				vo.setMobile(bizService.twoWayDecrypt(vo.getMobile()));

				String rcomMbrNm = Optional.ofNullable(vo.getRcomMbrNm()).orElseGet(()->"");
				String rcomLoginId = Optional.ofNullable(vo.getRcomLoginId()).orElseGet(()->"");
				String loginId = Optional.ofNullable(vo.getLoginId()).orElseGet(()->"");
				vo.setRcomMbrNm(StringUtil.isNotEmpty(rcomMbrNm) ? bizService.twoWayDecrypt(vo.getRcomMbrNm()) : rcomMbrNm);
				vo.setLoginId(StringUtil.isNotEmpty(rcomMbrNm) ? bizService.twoWayDecrypt(vo.getLoginId()) : rcomLoginId);
				vo.setRcomLoginId(StringUtil.isNotEmpty(rcomMbrNm) ? bizService.twoWayDecrypt(vo.getRcomLoginId()) : loginId);

				String mobile = Optional.ofNullable(vo.getMobile()).orElseGet(()->"")
						.replaceFirst("(^02|[0-9]{3})([0-9]{3,4})([0-9]{4})$", "$1-$2-$3");
				vo.setMobile(mobile);

				if(maskingFlag){
					//마스킹 처리
					vo.setMbrNm(MaskingUtil.getName(vo.getMbrNm()));
					vo.setRcomMbrNm(MaskingUtil.getName(vo.getRcomMbrNm()));
					vo.setLoginId(MaskingUtil.getId(vo.getLoginId()));
					vo.setRcomLoginId(MaskingUtil.getId(vo.getRcomLoginId()));
					vo.setEmail(MaskingUtil.getEmail(vo.getEmail()));
					vo.setMobile(MaskingUtil.getTelNo(vo.getMobile()));
				}

				vo.setRowIndex(Long.parseLong(rowIndex.toString()));
				rowIndex -=1;
			}
		}

		return new GridResponse(list, so);
	}

	@RequestMapping("/member/memberFollowView.do")
	public String memberFollowView(Model model,MemberBaseSO so){
		model.addAttribute("so",so);
		return "/member/memberTab/memberFollowView";
	}

	@RequestMapping("/member/memberGoodsIoView.do")
	public String memberGoodsIoView(Model model,MemberBaseSO so){
		model.addAttribute("so",so);
		String domain = bizConfig.getProperty("cookie.domain");
		model.addAttribute("domain", domain);
		return "/member/memberTab/memberGoodsIoView";
	}

	@ResponseBody
	@RequestMapping("/member/listMemberGoodsIoList.do")
	public GridResponse listMemberGoodsIoList(GoodsBaseSO so){
		List<GoodsBaseVO> list = new ArrayList<GoodsBaseVO>();
		if(Long.compare(Optional.ofNullable(so.getMbrNo()).orElseGet(()->0L),0L) != 0){
			so.setSidx("ALM_SND_DTM");
			so.setSord("ASC");
			list =  memberService.listMemberGoodsIoList(so);
		}
		return new GridResponse(list,so);
	}

	@RequestMapping("/member/memberCsListView.do")
	public String memberCsListView(Model model,MemberBaseSO so){
		model.addAttribute("so",so);
		return "/member/memberTab/memberCsListView";
	}

	@RequestMapping("/member/membeTabDetailLayerView.do")
	public String membeTabDetailLayerView(Model model
				,	String sysRegDtm
				,	String path
				, 	@RequestParam(value="hits",required = false)String hits
				, 	@RequestParam(value="gbCd",required = false)String gbCd
				, 	@RequestParam(value="grpCd",required = false)String grpCd
				, 	@RequestParam(value="report",required = false)String report
				, 	@RequestParam(value="ttl",required = false)String ttl
				, 	@RequestParam(value="content",required = false)String content
				, 	@RequestParam(value="tags",required = false)String tags
				, 	@RequestParam(value="thumbNail",required = false)String thumbNail
		){
		model.addAttribute("sysRegDtm",sysRegDtm);
		model.addAttribute("path",path);
		model.addAttribute("hits",hits);
		model.addAttribute("gbCd",gbCd);
		model.addAttribute("grpCd",grpCd);
		model.addAttribute("report",report);
		model.addAttribute("ttl",ttl);
		model.addAttribute("content",content);
		model.addAttribute("tags",tags);
		model.addAttribute("thumbNail",thumbNail);

		return "/member/memberTab/membeTabDetailLayerView";
	}

	@RequestMapping(value = {"/member/memberCouponLayerPop.do","/member/memberMobileHistoryLayerPop.do","/member/memberAddressViewPop.do" , "/member/memberSimpleCardListViewPop.do","/member/memberSktmpLayerPop.do"})
	public String incMemberInfo(Model model, MemberBaseSO so,String type){
		model.addAttribute("member",memberService.getMemberBaseInShort(so));
		model.addAttribute("type",type);
		return "/member/include/incMemberInfo";
	}



	@ResponseBody
	@RequestMapping("/member/listMemberMdnChangeHistory.do")
	public GridResponse listMemberMdnChangeHistory(MemberBaseSO so){
		so.setRows(10);
		so.setSidx("MAX(HIST_STRT_DTM)");
		so.setSord("DESC");
		List<MemberBaseVO> list = memberService.listMemberMdnChangeHistory(so);
		return new GridResponse(list,so);
	}

	@ResponseBody
	@RequestMapping("/member/getSession.do")
	public String getSession(Session session) {
		if(AdminSessionUtil.isAdminSession()) {
			return CommonConstants.CONTROLLER_RESULT_CODE_SUCCESS;
		}else {
			return CommonConstants.CONTROLLER_RESULT_CODE_FAIL;
		}

	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: MemberController.java
	 * - 작성일		: 2020. 12. 28.
	 * - 작성자		: valueFactory
	 * - 설명		: 펫 상세
	 * </pre>
	 * @param model
	 * @param so
	 * @return
	 */
	@RequestMapping("/member/memberPetView.do")
	public String memberPetView(Model model,MemberBaseSO so){
		model.addAttribute("mbrNo", so.getMbrNo());
		return "/member/memberPetView";
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: MemberController.java
	 * - 작성일		: 2020. 12. 30.
	 * - 작성자		: valueFactory
	 * - 설명		: 펫 목록 리스트
	 * </pre>
	 * @param so
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/member/petListGrid.do", method=RequestMethod.POST)
	public GridResponse petListGrid(PetBaseSO so) {
		List<PetBaseVO> list = petService.listPetBase(so);
		return new GridResponse(list, so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: MemberController.java
	 * - 작성일		: 2020. 12. 30.
	 * - 작성자		: valueFactory
	 * - 설명		: 접종내역 리스트
	 * </pre>
	 * @param so
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/member/petInclListGrid.do", method=RequestMethod.POST)
	public GridResponse petInclListGrid(PetBaseSO so) {
		List<PetInclRecodeVO> list = petService.pagePetInclRecode(so);
		return new GridResponse(list, so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: MemberController.java
	 * - 작성일		: 2020. 12. 31.
	 * - 작성자		: valueFactory
	 * - 설명		: 접종 증명서 이미지 레이어
	 * </pre>
	 * @param model
	 * @param so
	 * @return
	 */
	@RequestMapping("/member/petInclCtfcImageLayerView.do")
	public String petInclCtfcImageLayerView(Model model,PetBaseSO so){
		model.addAttribute("imgPath", so.getImgPath());
		return "/member/petInclCtfcImageLayerView";
	}
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: MemberController.java
	 * - 작성일		: 2021 .01 .07
	 * - 작성자		: 이지희
	 * - 설명		: 회원 목록 (팝업) - 최신결제일자 순
	 * </pre>
	 * @param so
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/member/memberListPopupGrid.do", method=RequestMethod.POST)
	public GridResponse memberListPopupGrid(MemberBaseSO so) {
		/*if (!StringUtil.isEmpty(so.getMbrNoArea())) {
			so.setMbrNos(StringUtil.splitEnter(so.getMbrNoArea()));
		}*/
		if(so.getSearchType().equals("")) so.setNickNm(so.getSearchWord());
		if(so.getSearchType() != null &&  !so.getSearchType().equals("nickNm") && !so.getSearchType().equals("mbrNo")) {
			so.setSearchWord(so.getSearchWord() != null && !so.getSearchWord().equals("") ? bizService.twoWayEncrypt(so.getSearchWord()) : null);
		}

		if(so.getMobile() != null && !so.getMobile().equals("")) {
			so.setMobile(bizService.twoWayEncrypt(so.getMobile().replaceAll("-","")));

		}
		List<MemberBaseVO> list = memberService.listPopupMemberBase(so);

		for(MemberBaseVO vo : list){
			String decryptMob = Optional.ofNullable(vo.getMobile()).orElseGet(()->"");
			String mobile = decryptMob.replaceFirst("(^02|[0-9]{3})([0-9]{3,4})([0-9]{4})$", "$1-$2-$3");
			vo.setMobile(mobile);
			vo.setMbrNm(MaskingUtil.getName(vo.getMbrNm()));
			vo.setLoginId(MaskingUtil.getId(vo.getLoginId()));
			vo.setMobile(MaskingUtil.getTelNo(vo.getMobile()));
			vo.setEmail(MaskingUtil.getEmail(vo.getEmail()));
		}
		return new GridResponse(list, so);
	}

	@ResponseBody
	@RequestMapping(value="/member/listFollowerMe" )
	public GridResponse listFollowerMe(MemberBaseSO so){
		List<MemberBaseVO> list = new ArrayList<MemberBaseVO>();
		if(Long.compare(Optional.ofNullable(so.getMbrNoFollowed()).orElseGet(()->0L),0l)!=0){
//			so.setRows(5);
			so.setSidx("MB.SYS_REG_DTM");
			so.setSord("ASC");
			list = memberService.listFollowerMe(so);

			/*Integer rowNum = so.getTotalCount() - (((int)so.getPage()-1)*so.getRows());
			for(MemberBaseVO v : list){
				v.setRowNum(Long.parseLong(rowNum.toString()));
				rowNum -=1;
			}*/
		}
		return new GridResponse(list, so);
	}

	@ResponseBody
	@RequestMapping(value="/member/listImFollowing" )
	public GridResponse listImFollowing(MemberBaseSO so){
		List<MemberBaseVO> list = new ArrayList<MemberBaseVO>();
		if(Long.compare(Optional.ofNullable(so.getMbrNo()).orElseGet(()->0L),0l)!=0){
//			so.setRows(5);
			so.setSidx("MB.SYS_REG_DTM");
			so.setSord("ASC");
			list = memberService.listImFollowing(so);
		}
		return new GridResponse(list, so);
	}

	@RequestMapping(value="/affiliate/orderListView.do")
	public String orderListView(Model model){
		return "/affiliate/orderListView";
	}

	@RequestMapping(value="/affiliate/counselListView.do")
	public String counselListView(Model model){
		return "/affiliate/counselListView";
	}


	@RequestMapping(value="/member/memberTwcCsListView.do")
	public String indexTwcCsList(Model model){
		return "/member/twcTab/indexTwcCsList";
	}

	@RequestMapping(value="/member/memberTwcSmsListView.do")
	public String indexTwcSmsList(Model model){
		return "/member/twcTab/indexTwcSmsList";
	}
	@RequestMapping(value="/member/memberTwcEsacalationView.do")
	public String indexTwcEscalation(Model model){
		return "/member/twcTab/indexTwcEscalation";
	}

	@RequestMapping(value="/member/emailUpdateViewPop.do")
	public String emailUpdateViewPop(Model model, @RequestParam(value="nickNm", required=false) String nickNm) {
		model.addAttribute("nickNm", nickNm);
		return "/member/emailUpdateViewPop";
	}

	@ResponseBody
	@RequestMapping(value="/member/ctfSendEmail.do")
	public String ctfSendEmail(MemberBaseSO so) {
		EmailSendPO emailPO = new EmailSendPO();
		emailPO.setTmplNo((long)50); //일단 하드코딩

		emailPO.setSenderAddress("hello@aboutpet.co.kr"); //테스트

		//수신자 정보
		List<EmailRecivePO> recipients = new ArrayList<EmailRecivePO>();

		EmailRecivePO revPO = new EmailRecivePO();
		revPO.setAddress(so.getEmail());

		Map<String,String> map = new HashMap<String, String>();
		String ctfNo = StringUtil.randomNumeric(6);
		if(StringUtil.isNotEmpty(so.getNickNm())) {
			map.put("nick_nm", so.getNickNm()+"님");
		}else {
			map.put("nick_nm", "");
		}
		map.put("ctf_email_no", ctfNo);
		map.put("ctf_type","관리자 회원 이메일 변경");
		revPO.setParameters(map);
		recipients.add(revPO);

		emailPO.setRecipients(recipients);

		bizService.sendEmail(emailPO);

		return ctfNo;
	}

	@ResponseBody
	@RequestMapping(value = "/member/emailDupCheck.do")
	public String emailDupCheck(MemberBaseSO so) {
		int result = memberService.getDuplicateChcekWhenBlur(so);

		if(result > 0) {
			return CommonConstants.CONTROLLER_RESULT_CODE_FAIL;
		} else {
			return CommonConstants.CONTROLLER_RESULT_CODE_SUCCESS;
		}
	}

	@ResponseBody
	@RequestMapping(value = "/member/emailUpdate.do")
	public String emailUpdate(MemberBasePO po) {
		int result = memberService.emailUpdate(po);

		if(result > 0) {
			return CommonConstants.CONTROLLER_RESULT_CODE_SUCCESS;
		} else {
			return CommonConstants.CONTROLLER_RESULT_CODE_FAIL;
		}
	}

	/**
	 * 회원번호 전환 메인화면
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/member/memberPhoneDecView")
	public String memberPhoneDecView(Model model) {
		return "/member/memberPhoneDecListView";
	}

	/**
	 * 회원번호 전환 목록
	 * @param so
	 * @param br
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/member/memberPhoneDecListGrid.do", method=RequestMethod.POST)
	public GridResponse memberPhoneDecListGrid(MemberBaseSO so,BindingResult br) {

		List<MemberBaseVO> list = so.getIsNotSearch() != CommonConstants.COMM_YN_Y ? memberService.listMemberGrid(so) : new ArrayList<>();
		return new GridResponse(list, so);
	}


	/**
	 * 회원번호 엑셀업로드 [로컬 테스트용]
	 * @param model
	 * @param fileName
	 * @param filePath
	 * @return
	 */
	@RequestMapping(value = "/member/memberPhoneExcelDownloadBack.do", method = RequestMethod.POST)
	public String memberPhoneExcelDownloadLocal(
			Model model,
			MemberBaseSO so,
			@RequestParam("fileName") String fileName,
			@RequestParam("filePath") String filePath) {

		List<MemberBaseVO> memberListVo = null;
		List<MemberBaseVO> memberList = new ArrayList<>();

		String[][] data = new String[][]{
				 {"891097","tdqtD+nTyaKbmAeti2abPmJMVfU8e0YROLEk4guVnDE="}
				, {"927069","dSjuNXyxvYVtvUyRQElbWfO5ZtAEvl6DGUAcfrHMu1o="}
		};

		for(int i=0; i<data.length; i++){

			MemberBaseVO user = new MemberBaseVO();

			user.setMbrNo(Long.valueOf(data[i][0]));
			user.setMobile(bizService.twoWayDecrypt(data[i][1]));

			memberList.add(user);

			log.debug("#### user : "+user.toString());

		}


		String[] headerName = {"회원 번호", "핸드폰"};
		String[] fieldName = {"mbrNo", "mobile"};

		model.addAttribute(CommonConstants.EXCEL_PARAM_NAME, new ExcelViewParam("MbrNoPhoneList", headerName, fieldName, memberList));
		model.addAttribute(CommonConstants.EXCEL_PARAM_FILE_NAME, "MbrNoPhoneList");
		return View.excelDownload();

	}

	/**
	 * 회원번호 엑셀업로드
	 * @param model
	 * @param fileName
	 * @param filePath
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/member/memberPhoneExcelCheck.do", method = RequestMethod.POST)
	public ModelMap memberPhoneExcelCheck(
			Model model,
			MemberBaseSO so,
			@RequestParam("fileName") String fileName,
			@RequestParam("filePath") String filePath) {

		List<MemberBaseVO> memberListVo = null;
		List<MemberBaseVO> memberList = new ArrayList<>();
		ModelMap map = new ModelMap();

		if(fileName != null && !"".equals(fileName)) {

			File excelFile = null;
			if (StringUtil.isNotEmpty(filePath)) {
				excelFile = new File(filePath);
			}

			String[] headerMap = new String[]{"회원 번호"};
			String[] fieldMap = new String[]{"mbrNo"};

			try {
				// 엑셀데이타
				memberListVo = ExcelUtil.parse(excelFile, MemberBaseVO.class, fieldMap, 1);

				log.debug(">>>>> memberListVo : "  + memberListVo.toString());
			} catch (Exception e) {
				log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
				throw new CustomException(ExceptionConstants.ERROR_FILE_NOT_FOUND);
			}

			ArrayList<String> headerList = ExcelUtil.getHeaderList(excelFile);
			boolean validateYn = true;

			// 기존 엑셀 양식과 업로드 받은 엑셀 양식 비교
			if(headerMap.length != headerList.size()) {
				validateYn = false;
			}else {
				for(int i = 0 ; i < headerMap.length ; i ++) {
					log.info("headerMap : " + headerMap[i]);
					log.info("headerList : " + headerList.get(i));
					log.info("equals : " + StringUtil.equals(headerMap[i], headerList.get(i)));
					if(!StringUtil.equals(headerMap[i], headerList.get(i))) {
						validateYn = false;
					}
				}
			}

			// 엑셀 양식이 맞지 않을 경우
			if(!validateYn) {
				throw new CustomException(ExceptionConstants.ERROR_EXCEL_TEMPLATE_NOT_MATCHED);
			}

			String[] arrMbrNos = new String[memberListVo.size()];

			if (CollectionUtils.isNotEmpty(memberListVo)) {
				int idx=0;
				for(MemberBaseVO mVO : memberListVo) {
					if (mVO.getMbrNo() == null || mVO.getMbrNo() == 0L) {
						throw new CustomException(ExceptionConstants.ERROR_EXCEL_TEMPLATE_NOT_MATCHED);
					}

					arrMbrNos[idx] = mVO.getMbrNo().toString();
					idx++;
				}

				MemberBaseSO mbSO = new MemberBaseSO();
				mbSO.setMbrNos(arrMbrNos);
				mbSO.setRows(arrMbrNos.length);
				mbSO.setOffset(50);
				memberList = memberService.memberPhoneList(mbSO);

				map.put("diffCnt", memberListVo.size() - memberList.size());

			} else {
				throw new CustomException(ExceptionConstants.ERROR_EXCEL_TEMPLATE_NOT_MATCHED);
			}
		}

		map.put("result", "SUCCESS");
		return map;
	}

	/**
	 * 회원번호 엑셀다운로드
	 * @param model
	 * @param fileName
	 * @param filePath
	 * @return
	 */
	@RequestMapping(value = "/member/memberPhoneExcelDownload.do", method = RequestMethod.POST)
	public String memberPhoneExcelDownload(
			Model model,
			MemberBaseSO so,
			@RequestParam("fileName") String fileName,
			@RequestParam("filePath") String filePath) {

		List<MemberBaseVO> memberListVo = null;
		List<MemberBaseVO> memberList = new ArrayList<>();

		if(fileName != null && !"".equals(fileName)) {

			File excelFile = null;
			if (StringUtil.isNotEmpty(filePath)) {
				excelFile = new File(filePath);
			}

			String[] fieldMap = new String[]{"mbrNo"};

			try {
				// 엑셀데이타
				memberListVo = ExcelUtil.parse(excelFile, MemberBaseVO.class, fieldMap, 1);

				log.debug(">>>>> memberListVo : "  + memberListVo.toString());
			} catch (Exception e) {
				log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
				throw new CustomException(ExceptionConstants.ERROR_FILE_NOT_FOUND);
			}

			// 읽은 파일 삭제
			if (!excelFile.delete()) {
				log.error("Fail to delete of file. PushController.pushMsgSendExcelUploadExec::excelFile.delete {}");
			}

			String[] arrMbrNos = new String[memberListVo.size()];

			if (CollectionUtils.isNotEmpty(memberListVo)) {
				int idx=0;
				for(MemberBaseVO mVO : memberListVo) {
					if (mVO.getMbrNo() == null || mVO.getMbrNo() == 0L) {
						throw new CustomException(ExceptionConstants.ERROR_EXCEL_TEMPLATE_NOT_MATCHED);
					}
					arrMbrNos[idx] = mVO.getMbrNo().toString();
					idx++;
				}

				MemberBaseSO mbSO = new MemberBaseSO();
				mbSO.setMbrNos(arrMbrNos);
				mbSO.setRows(arrMbrNos.length);
				mbSO.setOffset(50);
				memberList = memberService.memberPhoneList(mbSO);
			} else {
				throw new CustomException(ExceptionConstants.ERROR_EXCEL_TEMPLATE_NOT_MATCHED);
			}
		}

		String[] headerName = {"No", "회원 번호", "성명", "연락처"};
		String[] fieldName = {"sysRegrNo", "mbrNo", "mbrNm", "mobile"};

		model.addAttribute(CommonConstants.EXCEL_PASSWORD,DateUtil.getNowDate());
		model.addAttribute(CommonConstants.EXCEL_PARAM_NAME, new ExcelViewParam("MbrNoPhoneList", headerName, fieldName, memberList));
		model.addAttribute(CommonConstants.EXCEL_PARAM_FILE_NAME, "MbrNoPhoneList");
		return View.excelDownload();

	}

	@ResponseBody
	@RequestMapping(value = "/member/excelUploadFileInit.do", method = RequestMethod.POST )
	public ModelMap excelUploadFileInit(Model model,
			MemberBaseSO so,
			@RequestParam("fileName") String fileName,
			@RequestParam("filePath") String filePath) {

		ModelMap map = new ModelMap();
		try {
			File excelFile = null;
			if (StringUtil.isNotEmpty(filePath)) {
				excelFile = new File(filePath);
			}

			if (!excelFile.delete()) {
				log.error("Fail to delete of file. PushController.pushMsgSendExcelUploadExec::excelFile.delete {}");
			}

			map.put("result", "S");

		} catch (Exception e) {
			map.put("result", "F");
		}
		return map;
	}

}