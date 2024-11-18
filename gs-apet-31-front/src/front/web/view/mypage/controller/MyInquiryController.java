package front.web.view.mypage.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import biz.app.counsel.model.CounselPO;
import biz.app.counsel.model.CounselSO;
import biz.app.counsel.model.CounselVO;
import biz.app.counsel.service.CounselService;
import biz.app.member.model.MemberBaseSO;
import biz.app.member.model.MemberBaseVO;
import biz.app.member.service.MemberService;
import biz.app.system.model.CodeDetailVO;
import biz.common.model.AttachFileSO;
import biz.common.service.BizService;
import biz.common.service.CacheService;
import framework.common.annotation.LoginCheck;
import framework.common.constants.CommonConstants;
import framework.common.util.DateUtil;
import framework.common.util.StringUtil;
import framework.front.model.Session;
import framework.front.util.FrontSessionUtil;
import front.web.config.constants.FrontWebConstants;
import front.web.config.page.Paging;
import front.web.config.tiles.TilesView;
import front.web.config.view.ViewBase;
import front.web.config.view.ViewMyPage;
import lombok.extern.slf4j.Slf4j;


/**
* <pre>
* - 프로젝트명	: 31.front.web
* - 패키지명	: front.web.view.mypage.controller
* - 파일명		: MyInquiryController.java
* - 작성일		: 2016. 3. 2.
* - 작성자		: snw
* - 설명		: 문의 Controller
* </pre>
*/
@Slf4j
@Controller
@RequestMapping("mypage/inquiry")
public class MyInquiryController {

	@Autowired private CacheService cacheService;

	@Autowired private CounselService counselService;

	@Autowired private MemberService memberService;

	@Autowired private Properties webConfig;

	@Autowired
	private BizService bizService;

	/**
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명		: MyInquiryController.java
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
	@RequestMapping(value="indexRequest")
	public String indexRequest(ModelMap map, Session session, ViewBase view) {

		String menuGb = null;
		Long memNo = session.getMbrNo();

		if (memNo == 0) {
			menuGb = FrontWebConstants.MYPAGE_MENU_NOMEM_INQUIRY_REQUEST;
		} else {
			menuGb = FrontWebConstants.MYPAGE_MENU_INQUIRY_REQUEST;
			MemberBaseSO so = new MemberBaseSO();
			so.setMbrNo(memNo);

			MemberBaseVO member = this.memberService.getMemberBase(so);
			if (member.getEmail() != null && !member.getEmail().isEmpty()) {
				String[] emailInfo = member.getEmail().split("@");
				member.setEmailId(emailInfo[0]);
				member.setEmailAddr(emailInfo[1]);
			}
			map.put("member", member); // 회원정보 취득
		}

		map.put("session", session);
		map.put("view", view);
		map.put(FrontWebConstants.MYPAGE_MENU_GB, menuGb);

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

		// JSP 에서 비회원 로그인 판단할 때 사용함.
//		String newCheckCode = FrontSessionUtil.makeNoMemOrderCheckCode(session, session.getNoMemOrderInfo().getOrdNo());
//		if(newCheckCode.equals(session.getNoMemOrderInfo().getCheckCode())){
			// 비회원 로그인 상태 일 때
//			map.put("noMemberCheckCode", newCheckCode);
//		} else {
			// 비회원 로그인 상태 아닐 때
//			map.put("initNoMemberMenu", "Y");
//		}

		return TilesView.mypage(new String[] { "inquiry", "indexRequest" });
	}

	/**
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명		: MyInquiryController.java
	* - 작성일		: 2016. 3. 2.
	* - 작성자		: snw
	* - 설명		: 답변 목록  화면
	* </pre>
	* @param map
	* @param session
	* @param view
	* @return
	* @throws Exception
	*/
	@LoginCheck
	@RequestMapping(value="indexAnswerList")
	public String indexAnswerList(ModelMap map, Session session, ViewBase view, CounselSO so, String period){

		if(StringUtil.isEmpty(period)){
			period = "1";
		}

		so.setStId(view.getStId());
		so.setSidx("cusNo");
		so.setSord(FrontWebConstants.SORD_DESC);
		so.setRows(FrontWebConstants.PAGE_ROWS_10);
		so.setMbrNo(session.getMbrNo());
		so.setCusPathCd(CommonConstants.CUS_PATH_10);

		// 날짜 조회 param 설정
		so.setCusAcptDtmStart(DateUtil.convertSearchDate("S", so.getCusAcptDtmStart()));
		so.setCusAcptDtmEnd(DateUtil.convertSearchDate("E", so.getCusAcptDtmEnd()));

		// 상담상태 코드 취소상태 제외
		String[] temp = {FrontWebConstants.CUS_STAT_10, FrontWebConstants.CUS_STAT_20};
		so.setArrCusStatCd(temp);
		
		List<CounselVO> counselList = counselService.pageCounsel(so);

		for(CounselVO counsel : counselList){

			if (counsel.getFlNo() != null) {
				AttachFileSO attachFileSO = new AttachFileSO();
				attachFileSO.setFlNo(counsel.getFlNo());
				counsel.setFileList(bizService.listAttachFile(attachFileSO));
			}
		}
		map.put("period", period);
		map.put("counselList", counselList);
		map.put("paging", new Paging(so));
		map.put(FrontWebConstants.MYPAGE_MENU_GB, FrontWebConstants.MYPAGE_MENU_INQUIRY_ANSWER);
		// 상담 카테고리1 코드(문의유형) 취득
		map.put("cusCtg1CdList", this.cacheService.listCodeCache(CommonConstants.CUS_CTG1, CommonConstants.COMM_YN_N, null, null, null, null));
		// 상담 상태 코드 취득
		map.put("cusStatCdList", this.cacheService.listCodeCache(CommonConstants.CUS_STAT, null, null, null, null, null));
		
		map.put("session", session);
		map.put("view", view);
		
		return  TilesView.mypage(new String[]{"inquiry", "indexAnswerList"});
	}

	/**
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명	: MyInquiryController.java
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
	@RequestMapping(value="deleteInquiry", method=RequestMethod.POST)
	@ResponseBody
	public ModelMap deleteInquiry(Long cusNo, Session session) {

		this.counselService.cancelCounsel(cusNo, session.getMbrNo());

		return new ModelMap();
	}

}