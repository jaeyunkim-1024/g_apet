package front.web.view.mypage.controller;

import java.util.List;
import java.util.Properties;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import biz.app.member.model.MemberBaseSO;
import biz.app.member.model.MemberBaseVO;
import biz.app.member.model.MemberCouponSO;
import biz.app.member.model.MemberCouponVO;
import biz.app.member.model.MemberSavedMoneySO;
import biz.app.member.model.MemberSavedMoneyVO;
import biz.app.member.service.MemberCouponService;
import biz.app.member.service.MemberService;
import biz.app.promotion.model.CouponIssuePO;
import biz.app.promotion.service.CouponIssueService;
import biz.common.service.BizService;
import biz.common.service.CacheService;
import framework.common.annotation.LoginCheck;
import framework.common.constants.CommonConstants;
import framework.common.util.DateUtil;
import framework.front.model.Session;
import front.web.config.constants.FrontWebConstants;
import front.web.config.tiles.TilesView;
import front.web.config.view.ViewBase;
import front.web.config.view.ViewMyPage;
import front.web.config.view.ViewPopup;
import front.web.view.mypage.model.CouponApplyParam;
import lombok.extern.slf4j.Slf4j;

/**
* <pre>
* - 프로젝트명	: 31.front.web
* - 패키지명	: front.web.view.mypage.controller
* - 파일명		: MyBenefitController.java
* - 작성일		: 2016. 3. 2.
* - 작성자		: snw ,kyh
* - 설명		: 관심상품 Controller
* </pre>
*/
@Slf4j
@Controller
@RequestMapping("mypage/benefit")
public class MyBenefitController {

	@Autowired private BizService bizService;

	@Autowired private MemberCouponService memberCouponService;

	@Autowired private CouponIssueService couponIssueService;

	@Autowired private MessageSourceAccessor message;

	@Autowired private Properties bizConfig;

	@Autowired private CacheService codeCacheService;

	@Autowired private MemberService memberService;

	/**
	 *
	* <pre>
	* - 프로젝트명	: 33.front.brand.web
	* - 파일명		: MyBenefitController.java
	* - 작성일		: 2017. 3. 17.
	* - 작성자		: hjko
	* - 설명		: 마이페이지 > 혜택보기 > 사용 가능한 쿠폰 목록
	* </pre>
	* @param map
	* @param so
	* @param session
	* @param view
	* @return
	 */
	@LoginCheck
	@RequestMapping(value="indexCouponPossibleList")
	public String indexCouponPossibleList(ModelMap map, MemberCouponSO so, Session session, ViewBase view){

		so.setRows(FrontWebConstants.PAGE_ROWS_10); // 한페이지에 데이터 10건씩
		so.setSidx("cp_no"); //정렬 컬럼 명
		so.setSord(FrontWebConstants.SORD_DESC);
		so.setMbrNo(session.getMbrNo());
		so.setUseYn(CommonConstants.USE_YN_N);
		so.setWebMobileGbCd(FrontWebConstants.WEB_MOBILE_GB_10);

		List<MemberCouponVO> memberCouponPossibleList = this.memberCouponService.memberListCouponPage(so);

		map.put("memberCouponPossibleList", memberCouponPossibleList);
		map.put("session", session);
		map.put("view", view);
		map.put(FrontWebConstants.MYPAGE_MENU_GB, FrontWebConstants.MYPAGE_MENU_BENEFIT_COUPON);
		map.put("so", so);

		return  TilesView.mypage(new String[]{"benefit", "indexCouponPossibleList"});
	}

	/**
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명		: MyBenefitController.java
	* - 작성일		: 2016. 3. 2.
	* - 작성자		: snw,kyh
	* - 설명		: 사용한 쿠폰 화면
	* </pre>
	* @param map
	* @param session
	* @param view
	* @return
	* @throws Exception
	*/
	@LoginCheck
	@RequestMapping(value="indexCouponCompletionList")
	public String indexCouponCompletionList(ModelMap map, MemberCouponSO so, Session session, ViewBase view){

		so.setRows(FrontWebConstants.PAGE_ROWS_10); // 한페이지에 데이터 10건씩
		so.setSidx("cp_no"); //정렬 컬럼 명
		so.setSord(FrontWebConstants.SORD_DESC);
		so.setMbrNo(session.getMbrNo());
		so.setUseYn(CommonConstants.USE_YN_Y);

		List<MemberCouponVO> memberCouponComList = this.memberCouponService.memberListComCouponPage(so);

		map.put("memberCouponComList", memberCouponComList);
		map.put("session", session);
		map.put("view", view);
		map.put(FrontWebConstants.MYPAGE_MENU_GB, FrontWebConstants.MYPAGE_MENU_BENEFIT_COUPON);
		map.put("so", so);

		return  TilesView.mypage(new String[]{"benefit", "indexCouponCompletionList"});
	}

	/**
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명		: MyBenefitController.java
	* - 작성일		: 2016. 3. 2.
	* - 작성자		: snw
	* - 설명		: 적립금 적립/사용 목록 화면
	* </pre>
	* @param map
	* @param session
	* @param view
	* @return
	* @throws Exception
	*/
	@LoginCheck
	@RequestMapping(value="indexSaveMoneyUsedList")
	public String indexSaveMoneyUsedList(ModelMap map, Session session, ViewBase view, MemberSavedMoneySO so){

		// 사용가능한 적립금 조회
		MemberBaseSO mbso = new MemberBaseSO();
		mbso.setMbrNo(session.getMbrNo());
		MemberBaseVO member =  this.memberService.getMemberBase(mbso);
		map.put("svmnRmnAmt", member.getSvmnRmnAmt());

		// 1개월 이내의 소멸예정 적립금 취득
		Long lemnAmt = memberService.getLostExpectedMemberSavedMoney(session.getMbrNo());
		map.put("lemnAmt", lemnAmt == null ? 0 : lemnAmt);

		if (so.getPeriod() == null) {so.setPeriod("1");}
		so.setSidx("SYS_REG_DTM");
		so.setSord(FrontWebConstants.SORD_DESC);
		so.setRows(FrontWebConstants.PAGE_ROWS_5);
		so.setMbrNo(session.getMbrNo());

		// 날짜 조회 param 설정
		so.setPrcsDtmStart(DateUtil.convertSearchDate("S", so.getPrcsDtmStart()));
		so.setPrcsDtmEnd(DateUtil.convertSearchDate("E", so.getPrcsDtmEnd()));

		// 적립금 이력 목록 취득
		List<MemberSavedMoneyVO> memberSavedMoneyList = memberService.pageMemberSavedMoneyHist(so);
		map.put("memberSavedMoneyList", memberSavedMoneyList);

		// 적립금 사유 코드
		map.put("svmnRsnCdList", this.codeCacheService.listCodeCache(FrontWebConstants.SVMN_RSN, null, null, null, null, null));
		// 적립금 처리 코드
		map.put("svmnPrcsCdList", this.codeCacheService.listCodeCache(FrontWebConstants.SVMN_PRCS, null, null, null, null, null));
		// 적립금 처리 사유 코드
		map.put("svmnPrcsRsnCdList", this.codeCacheService.listCodeCache(FrontWebConstants.SVMN_PRCS_RSN, null, null, null, null, null));

		map.put("session", session);
		map.put("view", view);
		map.put(FrontWebConstants.MYPAGE_MENU_GB, FrontWebConstants.MYPAGE_MENU_BENEFIT_SAVE_MONEY);

		return  TilesView.mypage(new String[]{"benefit", "indexSaveMoneyUsedList"});
	}

	/**
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명		: MyBenefitController.java
	* - 작성일		: 2016. 3. 2.
	* - 작성자		: kyh
	* - 설명		: 쿠폰 등록 팝업 화면 호출
	* </pre>
	* @param map
	* @param view
	* @param param
	* @return
	* @throws Exception
	*/
	@LoginCheck()
	@RequestMapping(value="popupCouponApply")
	public String popupCouponApply(ModelMap map, ViewBase view, CouponApplyParam param){

		view.setTitle(message.getMessage("front.web.view.mypage.benefit.coupon.apply.popup.title"));
		map.put("view", view);
		map.put("param", param);

		return TilesView.popup(
				new String[]{"mypage", "benefit", "popupCouponApply"}
		);
	}

	/**
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명		: MyBenefitController.java
	* - 작성일		: 2016. 5. 10.
	* - 작성자		: snw
	* - 설명		: 쿠폰 등록
	* </pre>
	* @param session
	* @param pswd
	* @param type
	* @return
	* @throws Exception
	*/
	@LoginCheck()
	@RequestMapping(value="popCouponApply", method=RequestMethod.POST)
	@ResponseBody
	public ModelMap popupCouponApply(Session session, CouponIssuePO po, String isuSrlNo) {

		po.setIsuSrlNo(isuSrlNo);
		po.setSysRegrNo(session.getMbrNo());
		po.setMbrNo(session.getMbrNo());

		this.couponIssueService.couponApply(po);

		return new ModelMap();
	}
}