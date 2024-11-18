package front.web.view.goods.controller;

import java.util.*;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import biz.app.petlog.model.PetLogBaseSO;
import biz.app.petlog.model.PetLogBaseVO;
import biz.app.petlog.service.PetLogService;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.ArrayUtils;
import org.apache.commons.lang.math.NumberUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import com.google.gson.Gson;

import biz.app.attribute.model.AttributePO;
import biz.app.attribute.model.AttributeVO;
import biz.app.brand.service.BrandService;
import biz.app.cart.service.CartService;
import biz.app.company.service.CompanyPolicyService;
import biz.app.delivery.model.DeliveryChargePolicyVO;
import biz.app.display.service.DisplayService;
import biz.app.event.service.EventService;
import biz.app.goods.model.GoodsAttributeVO;
import biz.app.goods.model.GoodsBaseSO;
import biz.app.goods.model.GoodsBaseVO;
import biz.app.goods.model.GoodsCommentSO;
import biz.app.goods.model.GoodsCommentVO;
import biz.app.goods.model.GoodsCstrtPakPO;
import biz.app.goods.model.GoodsCstrtPakVO;
import biz.app.goods.model.GoodsDescSO;
import biz.app.goods.model.GoodsDescVO;
import biz.app.goods.model.GoodsEstmQstVO;
import biz.app.goods.model.GoodsInquiryPO;
import biz.app.goods.model.GoodsInquirySO;
import biz.app.goods.model.GoodsInquiryVO;
import biz.app.goods.model.GoodsListSO;
import biz.app.goods.model.GoodsListVO;
import biz.app.goods.model.GoodsRelatedSO;
import biz.app.goods.model.ItemSO;
import biz.app.goods.model.ItemVO;
import biz.app.goods.service.GoodsCautionService;
import biz.app.goods.service.GoodsCommentService;
import biz.app.goods.service.GoodsCstrtPakService;
import biz.app.goods.service.GoodsDescService;
import biz.app.goods.service.GoodsDetailService;
import biz.app.goods.service.GoodsIconService;
import biz.app.goods.service.GoodsInquiryService;
import biz.app.goods.service.GoodsNotifyService;
import biz.app.goods.service.GoodsService;
import biz.app.goods.service.ItemService;
import biz.app.member.model.MemberAddressVO;
import biz.app.member.model.MemberBaseSO;
import biz.app.member.model.MemberBaseVO;
import biz.app.member.model.MemberGradeVO;
import biz.app.member.model.MemberInterestGoodsPO;
import biz.app.member.model.MemberInterestGoodsSO;
import biz.app.member.model.MemberInterestGoodsVO;
import biz.app.member.service.MemberAddressService;
import biz.app.member.service.MemberInterestGoodsService;
import biz.app.member.service.MemberService;
import biz.app.order.model.OrderDlvrAreaVO;
import biz.app.order.service.OrderDlvrAreaService;
import biz.app.petlog.model.PetLogGoodsSO;
import biz.app.petlog.model.PetLogGoodsVO;
import biz.app.promotion.service.ExhibitionService;
import biz.app.tag.model.TagBaseVO;
import biz.app.tag.service.TagService;
import biz.common.service.CacheService;
import framework.common.annotation.LoginCheck;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import framework.common.util.CookieSessionUtil;
import framework.common.util.DateUtil;
import framework.common.util.StringUtil;
import framework.front.constants.FrontConstants;
import framework.front.model.Session;
import front.web.config.constants.FrontWebConstants;
import front.web.config.tiles.TilesView;
import front.web.config.view.ViewBase;
import front.web.view.goods.model.GoodsCommentParam;
import front.web.view.goods.model.GoodsInquiryRegParam;
import front.web.view.goods.model.GoodsProdeinfoParam;
import lombok.extern.slf4j.Slf4j;

/**
 * <pre>
 * - 프로젝트명	: 31.front.web
 * - 패키지명	: front.web.view.goods.controller
 * - 파일명		: GoodsController.java
 * - 작성일		: 2016. 3. 2.
 * - 작성자		: snw
 * - 설명		: 상품 관련 Controller
 * </pre>
 */
@Slf4j
@Controller
@RequestMapping("goods")
public class GoodsController {

	@Autowired private CacheService codeCacheService;

	@Autowired private MessageSourceAccessor message;

	@Autowired private GoodsService goodsService;

	@Autowired private GoodsDescService goodsDescService;

	@Autowired private GoodsInquiryService goodsInquiryService;

	@Autowired private GoodsCommentService goodsCommentService;

	@Autowired private MemberService memberService;

	@Autowired private MemberInterestGoodsService memberInterestGoodsService;

	@Autowired private ItemService itemService;

	@Autowired private Properties webConfig;

	@Autowired private TagService tagService;

	@Autowired private OrderDlvrAreaService orderDlvrAreaService;

	@Autowired private MemberAddressService memberAddressService;

	@Autowired private GoodsDetailService goodsDetailService;

	@Autowired private GoodsCstrtPakService goodsCstrtPakService;

	@Autowired private PetLogService petLogService;

	/**
	 * <pre>
	 * - 프로젝트명	: 31.front.web
	 * - 파일명		: GoodsController.java
	 * - 작성일		: 2016. 5. 17.
	 * - 작성자		: shkim
	 * - 설명		: 상품상세 - 선택된 옵션으로 단품정보 조회
	 * </pre>
	 * @param goodsId
	 * @param attrNoList
	 * @param attrNoValList
	 * @return
	 */
	@RequestMapping("checkGoodsOption")
	@ResponseBody
	public ModelMap checkGoodsOption(ItemSO so){
		ModelMap map = new ModelMap();
		String[] arrAttrNo = so.getAttrNoList().split(",");			//속성번호 리스트
		String[] arrAttrValNo = so.getAttrValNoList().split(",");	//속성 값 번호 리스트

		Long[] arrAttrNoL = new Long[arrAttrNo.length];
		Long[] arrAttrValNoL = new Long[arrAttrValNo.length];

		for(int i=0; i<arrAttrNo.length; i++){
			arrAttrNoL[i] = Long.parseLong(arrAttrNo[i]);
		}
		for(int i=0; i<arrAttrValNo.length; i++){
			arrAttrValNoL[i] = Long.parseLong(arrAttrValNo[i]);
		}

//		ItemVO item = this.goodsService.checkGoodsOption(so);
		ItemVO item = this.itemService.getItem(so.getGoodsId(), arrAttrNoL, arrAttrValNoL);

		map.put("item", item);

		return map;
	}

	@RequestMapping("getGoodsOption")
	@ResponseBody
	public ModelMap getGoodsOption(String goodsId, ViewBase view){
		ModelMap map = new ModelMap();
		// 상품 기본정보 조회
		GoodsBaseSO mso = new GoodsBaseSO();
		if(view.getStId() != 0){
			mso.setStId(view.getStId());
		}
		mso.setWebMobileGbCd(CommonConstants.WEB_MOBILE_GB_10);
		mso.setGoodsId(goodsId);
		GoodsBaseVO goods = this.goodsService.getGoodsDetailFO(mso);
		Gson gson = new Gson();
		map.put("goods", goods);
		map.put("goodsData", gson.toJson(goods));

		// 옵션 정보 조회
		AttributePO attr = new AttributePO();
		attr.setGoodsId(goodsId);
//		List<AttributeVO>  goodsAttrList = this.goodsService.getItemList(attr);
		List<GoodsAttributeVO>  goodsAttrList = this.goodsService.listGoodsAttribute(goodsId, true);
		map.put("goodsAttrList", goodsAttrList);
		map.put("goodsAttrListData", gson.toJson(goodsAttrList));
		return map;
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 31.front.web
	 * - 파일명		: GoodsController.java
	 * - 작성일		: 2016. 4. 29.
	 * - 작성자		: snw
	 * - 설명		: 관심상품 등록
	 * </pre>
	 * @param session
	 * @param goodsId
	 * @return
	 * @throws Exception
	 */
	//@LoginCheck
	@RequestMapping("insertWish")
	@ResponseBody
	public ModelMap insertWish(Session session, String goodsId, String search, String returnUrl) {
		String actGubun = "error";
		if(session.getMbrNo().equals(CommonConstants.NO_MEMBER_NO)) {
			actGubun = "login";
		}else{
			MemberInterestGoodsPO po = new MemberInterestGoodsPO();
			po.setMbrNo(session.getMbrNo());
			po.setGoodsId(goodsId);
			po.setSysRegrNo(session.getMbrNo());
			int rs = this.memberInterestGoodsService.insertMemberInterestGoods(po, search);
			if     (rs == 1) {actGubun = "add";}
			else if(rs ==2)  {actGubun = "remove";}
		}
		ModelMap map = new ModelMap();
		map.put("actGubun", actGubun);
		return map;
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 31.front.web
	 * - 파일명		: GoodsController.java
	 * - 작성일		: 2016. 4. 7.
	 * - 작성자		: snw
	 * - 설명		: 상품상세화면의 상품문의 목록 조회
	 * </pre>
	 * @param map
	 * @param view
	 * @param goodsId
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="indexGoodsInquiryList")
	public String indexGoodsInquiryList(ModelMap map, ViewBase view, Session session, GoodsInquirySO so){

		so.setRows(FrontWebConstants.PAGE_ROWS_5);
		so.setSidx("sys_reg_dtm"); //정렬 컬럼 명
		so.setSord(FrontWebConstants.SORD_DESC);
		so.setStId(view.getStId());
		so.setDispYn(FrontWebConstants.COMM_YN_Y);

		List<GoodsInquiryVO> goodsInquiryList = this.goodsInquiryService.pageGoodsInquiry(so);

		map.put("goodsInquiryList", goodsInquiryList);
		map.put("goodsIqrStatCdList", this.codeCacheService.listCodeCache(FrontWebConstants.GOODS_IQR_STAT, null, null, null, null, null));
		map.put("so", so);
		map.put("view", view);
		map.put("session", session);

		return  TilesView.none(
				new String[]{"goods", "include", "includeGoodsInquiryList"}
		);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 31.front.web
	 * - 파일명		: GoodsController.java
	 * - 작성일		: 2016. 4. 11.
	 * - 작성자		: snw
	 * - 설명		: 상품문의 등록 팝업 화면
	 * </pre>
	 * @param map
	 * @param view
	 * @param session
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@LoginCheck()
	@RequestMapping(value="popupGoodsInquiryReg")
	public String popupGoodsInquiryReg(ModelMap map, ViewBase view, Session session, GoodsInquiryRegParam param){
		view.setTitle(this.message.getMessage("front.web.view.goods.inquiry.reg.pop.title"));

		MemberBaseSO so = new MemberBaseSO();
		so.setMbrNo(session.getMbrNo());
		MemberBaseVO member = this.memberService.getMemberBase(so);
		if(!"".equals(member.getEmail())){
			String[] emails = member.getEmail().split("@");
			if(emails.length > 0) {
				member.setEmailId(emails[0]);
			}
			if(emails.length > 1) {
				member.setEmailAddr(emails[1]);
			}
		}
		map.put("member", member);
		map.put("view", view);
		map.put("session", session);
		map.put("param", param);
		map.put("emailAddrCdList", this.codeCacheService.listCodeCache(CommonConstants.EMAIL_ADDR, null, null, null, null, null));

		return  TilesView.popup(new String[]{"goods", "popupGoodsInquiryReg"});
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 31.front.web
	 * - 파일명		: GoodsController.java
	 * - 작성일		: 2016. 4. 7.
	 * - 작성자		: snw
	 * - 설명		: 상품문의 등록
	 * </pre>
	 * @param goodsIqrNo
	 * @return
	 * @throws Exception
	 */
	@LoginCheck
	@RequestMapping(value="insertGoodsInquiry")
	@ResponseBody
	public ModelMap insertGoodsInquiry(GoodsInquiryPO po, Session session, String emailId, String emailAddr){

		po.setEqrrEmail(emailId + "@" + emailAddr);
		po.setEqrrMbrNo(session.getMbrNo());
		po.setSysRegrNo(session.getMbrNo());
		po.setStId(Long.valueOf(this.webConfig.getProperty("site.id")));

		this.goodsInquiryService.insertGoodsInquiry(po, "");

		return new ModelMap();
	}


	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-31-front
	 * - 파일명		: GoodsController.java
	 * - 작성일		: 2021. 2. 18.
	 * - 작성자		: pcm
	 * - 설명		: 상품 문의 삭제
	 * </pre>
	 * @param po
	 * @param session
	 * @return
	 */
	@LoginCheck
	@RequestMapping(value="deleteGoodsInquiry")
	@ResponseBody
	public ModelMap deleteGoodsInquiry(GoodsInquiryPO po, Session session){
		// 본인글에대한 삭제만 가능
		po.setEqrrMbrNo(session.getMbrNo());
		this.goodsInquiryService.deleteGoodsInquiry(po);

		return new ModelMap();
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 31.front.web
	 * - 파일명		: GoodsController.java
	 * - 작성일		: 2016. 4. 7.
	 * - 작성자		: snw
	 * - 설명		: 상품상세화면의 상품평가 목록 조회
	 * </pre>
	 * @param map
	 * @param view
	 * @param goodsId
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="indexGoodsCommentList")
	public String indexGoodsCommentList(ModelMap map, ViewBase view, Session session, GoodsCommentSO so){

		if(so.getCommentType() == null){
			so.setCommentType("");
		}

		if("P".equals(so.getCommentType())){
			so.setImgRegYn("Y");
			so.setRcomYn(null);
		}else if("B".equals(so.getCommentType())){
			so.setImgRegYn(null);
			so.setRcomYn("Y");
		}else if("N".equals(so.getCommentType())){
			so.setImgRegYn("N");
			so.setRcomYn(null);
		}else{
			so.setImgRegYn(null);
			so.setRcomYn(null);
		}

		so.setStId(view.getStId());
		so.setRows(FrontWebConstants.PAGE_ROWS_5);
		if(so.getSidx() == null || "".equals(so.getSidx())){
			so.setSidx("sys_reg_dtm"); //정렬 컬럼 명
		}
		so.setSord(FrontWebConstants.SORD_DESC);

		List<GoodsCommentVO> goodsCommentList = this.goodsCommentService.pageGoodsCommentAddBest(so);

		map.put("goodsCommentList", goodsCommentList);
		map.put("goodsCommentCount", this.goodsCommentService.getGoodsCommentCount(so));
		map.put("view", view);
		map.put("session", session);
		map.put("so", so);

		return  TilesView.none(
				new String[]{"goods", "include", "includeGoodsCommentList"}
		);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 31.front.web
	 * - 파일명		: GoodsController.java
	 * - 작성일		: 2016. 7. 27.
	 * - 작성자		: snw
	 * - 설명		: 상품 상세 설명 영역에 사용자 정의 영역
	 * </pre>
	 * @param map
	 * @param view
	 * @param session
	 * @return
	 */
	@RequestMapping(value="indexUserDefine")
	public String indexUserDefine(ModelMap map, ViewBase view, Session session, String goodsId){

		map.put("view", view);
		map.put("session", session);

		// 상품 상세
		GoodsDescSO gdso = new GoodsDescSO();
		gdso.setGoodsId(goodsId);
		gdso.setSvcGbCd(view.getSvcGbCd());
		GoodsDescVO goodsDesc = this.goodsDescService.getGoodsDesc(gdso);
		map.put("goodsDesc", goodsDesc);
		return  TilesView.none(
				new String[]{"goods", "include", "includeGoodsUserDefine"}
		);
	}



	/**
	 * <pre>
	 * - 프로젝트명	: 31.front.web
	 * - 파일명		: GoodsController.java
	 * - 작성일		: 2016. 3. 2.
	 * - 작성자		: snw
	 * - 설명		: 상품평 상세 팝업 화면
	 * </pre>
	 * @param map
	 * @param session
	 * @param view
	 * @param goods_id
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="popupGoodsCommentDetail")
	public String popupGoodsCommentDetail(ModelMap map, Session session, ViewBase view, GoodsCommentParam param){

		GoodsCommentVO goodsComment = this.goodsCommentService.getGoodsCommentBase(param.getGoodsEstmNo());

		// 상품평 상세 팝업 화면에 상품정보를 노출하는 경우
		if (CommonConstants.COMM_YN_Y.equals(param.getGoodsDisp())) {
			GoodsBaseVO goods = this.goodsService.getGoodsBase(goodsComment.getGoodsId());
			map.put("goods", goods);
		}

		view.setTitle(message.getMessage("front.web.view.goods.comment.detail.popup.title"));
		map.put("goodsComment", goodsComment);
		map.put("session", session);
		map.put("view", view);
		map.put("param", param);

		return TilesView.popup(
				new String[]{"goods","popupGoodsCommentDetail"}
		);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 31.front.web
	 * - 파일명		: ShowRoomController.java
	 * - 작성일		: 2016. 3. 2.
	 * - 작성자		: snw
	 * - 설명		: 상품 목록 조회 화면(전체 공통)
	 * </pre>
	 *
	 * @param session
	 * @param view
	 * @param so
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="indexGoodsList")
	public String indexGoodsList(ModelMap map, Session session, ViewBase view, GoodsListSO so, String targetId, String pos) {
		log.debug(">>>>>>>>>>>>>>>>>>>>>rows=" + so.getRows());

		if (session.getMbrNo() != 0) {
			so.setMbrNo(session.getMbrNo());
		}

		so.setStId(view.getStId());
		so.setDispCornNoBest(view.getDispCornNoBest());

		// 기본 rows가 10이므로 20으로 변경 처리
		if (so.getRows().equals(FrontWebConstants.PAGE_ROWS_10)) {
			so.setRows(FrontWebConstants.PAGE_ROWS_20);
		}

		if (StringUtil.isEmpty(pos)) {
			pos = "0";
		}

		if (StringUtil.isEmpty(so.getSortType())) {
			so.setSortType(FrontWebConstants.SORT_TYPE_POPULAR);
		}

		if (StringUtil.isEmpty(so.getCtgGb())) {
			so.setCtgGb(FrontWebConstants.CATEGORY_GB_NORMAL);
		}

		// WEB or Mobile에 따른 구분
		List<String> webMobileGbCds = new ArrayList<>();
		webMobileGbCds.add(FrontWebConstants.WEB_MOBILE_GB_00); // 전체
		webMobileGbCds.add(FrontWebConstants.WEB_MOBILE_GB_10); // 웹
		so.setWebMobileGbCds(webMobileGbCds);
		so.setWebMobileGbCd(FrontWebConstants.WEB_MOBILE_GB_10);

		switch (so.getSortType()) {
			case FrontWebConstants.SORT_TYPE_NEW:				// 신상품 순
				so.setSidx("SYS_REG_DTM");
				so.setSord(FrontWebConstants.SORD_DESC);
				break;
			case FrontWebConstants.SORT_TYPE_POPULAR:			// 인기상품 순
				so.setSidx("TOTAL_SCR");
				so.setSord(FrontWebConstants.SORD_ASC);
				break;
			case FrontWebConstants.SORT_TYPE_PRICE_LOW:			// 낮은가격 순
				so.setSidx("FO_SALE_AMT");
				so.setSord(FrontWebConstants.SORD_ASC);
				break;
			case FrontWebConstants.SORT_TYPE_PRICE_HIGH:		// 높은가격 순
				so.setSidx("FO_SALE_AMT");
				so.setSord(FrontWebConstants.SORD_DESC);
				break;
			case FrontWebConstants.SORT_TYPE_REVIEW:			// 리뷰많은 순
				so.setSidx("REVIEW_CNT");
				so.setSord(FrontWebConstants.SORD_DESC);
				break;
			default:
				break;
		}

		// 상품 리스트 조회
		List<GoodsListVO> goodsList = null;
		if (so.getCtgGb().equals("NORMAL") || so.getCtgGb().equals("BRAND")) {
			goodsList = goodsService.pageGoodsFO(so);
		}
		else if (so.getCtgGb().equals("BEST")) {
			if (so.getDispClsfNo() == null) {
				so.setDispClsfNo(Long.parseLong(CommonConstants.DISP_CLSF_10));
			}

			so.setRows(FrontWebConstants.PAGE_ROWS_100);
			goodsList = goodsService.pageBestGoods(so);
		}

		map.put("goodsList", goodsList);

		map.put("view", view);
		map.put("so", so);
		map.put("targetId", targetId);
		map.put("pos", pos);

		return TilesView.none(new String[] { "goods", "indexGoodsList" });
	}


	/**
	 * <pre>
	 * - 프로젝트명	: 31.front.web
	 * - 파일명		: ShowRoomController.java
	 * - 작성일		: 2016. 3. 2.
	 * - 작성자		: snw
	 * - 설명		: 상품 목록 조회 화면(전체 공통)
	 * </pre>
	 *
	 * @param session
	 * @param view
	 * @param so
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="indexSubGoodsList")
	public String indexSubGoodsList(ModelMap map, Session session, ViewBase view, GoodsListSO so, Long pos) {
		log.debug(">>>>>>>>>>>>>>>>>>>>>rows=" + so.getRows());

		if (session.getMbrNo() != 0) {
			so.setMbrNo(session.getMbrNo());
		}

		so.setStId(view.getStId());
		so.setDispCornNoBest(view.getDispCornNoBest());

		// 기본 rows가 10이므로 20으로 변경 처리
		if (so.getRows().equals(FrontWebConstants.PAGE_ROWS_10)) {
			so.setRows(FrontWebConstants.PAGE_ROWS_20);
		}

		if (pos == null) {
			pos = 0L;
		}

		if (StringUtil.isEmpty(so.getSortType())) {
			so.setSortType(FrontWebConstants.SORT_TYPE_POPULAR);
		}

		if (StringUtil.isEmpty(so.getCtgGb())) {
			so.setCtgGb(FrontWebConstants.CATEGORY_GB_NORMAL);
		}

		// WEB or Mobile에 따른 구분
		List<String> webMobileGbCds = new ArrayList<>();
		webMobileGbCds.add(FrontWebConstants.WEB_MOBILE_GB_00); // 전체
		webMobileGbCds.add(FrontWebConstants.WEB_MOBILE_GB_10); // 웹
		so.setWebMobileGbCds(webMobileGbCds);
		so.setWebMobileGbCd(FrontWebConstants.WEB_MOBILE_GB_10);

		switch (so.getSortType()) {
			case FrontWebConstants.SORT_TYPE_NEW:				// 신상품 순
				so.setSidx("SYS_REG_DTM");
				so.setSord(FrontWebConstants.SORD_DESC);
				break;
			case FrontWebConstants.SORT_TYPE_POPULAR:			// 인기상품 순
				so.setSidx("TOTAL_SCR");
				so.setSord(FrontWebConstants.SORD_ASC);
				break;
			case FrontWebConstants.SORT_TYPE_PRICE_LOW:			// 낮은가격 순
				so.setSidx("FO_SALE_AMT");
				so.setSord(FrontWebConstants.SORD_ASC);
				break;
			case FrontWebConstants.SORT_TYPE_PRICE_HIGH:		// 높은가격 순
				so.setSidx("FO_SALE_AMT");
				so.setSord(FrontWebConstants.SORD_DESC);
				break;
			case FrontWebConstants.SORT_TYPE_REVIEW:			// 리뷰많은 순
				so.setSidx("REVIEW_CNT");
				so.setSord(FrontWebConstants.SORD_DESC);
				break;
			default:
				break;
		}

		// 상품 리스트 조회
		List<GoodsListVO> goodsList = null;
		if (so.getCtgGb().equals("NORMAL") || so.getCtgGb().equals("BRAND")) {
			goodsList = goodsService.pageGoodsFO(so);
		}
		else if (so.getCtgGb().equals("BEST")) {
			if (so.getDispClsfNo() == null) {
				so.setDispClsfNo(Long.parseLong(CommonConstants.DISP_CLSF_10));
			}

			so.setRows(FrontWebConstants.PAGE_ROWS_100);
			goodsList = goodsService.pageBestGoods(so);
		}

		map.put("goodsList", goodsList);

		map.put("view", view);
		map.put("so", so);
		map.put("pos", pos);

		return TilesView.none(new String[] { "goods", "indexSubGoodsList" });
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 31.front.web
	 * - 파일명		: GoodsController.java
	 * - 작성일		: 2016. 7. 28.
	 * - 작성자		: kyh
	 * - 설명		: 벽 고정 설치 필수 상품 안내 팝업
	 * </pre>
	 * @param map
	 * @param view
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="popupGoodsProdeinfo")
	public String popupGoodsProdeinfo(ModelMap map, ViewBase view , GoodsProdeinfoParam param){
		view.setTitle(message.getMessage("front.web.view.goods.detail.prodeinfo.popup.title"));
		map.put("param", param);
		map.put("view", view);

		return TilesView.popup(
				new String[]{"goods", "popupGoodsProdeinfo"}
		);
	}

	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 34.front.brand.mobile
	 * - 파일명		: MyPageController.java
	 * - 작성일		: 2017. 5. 29.
	 * - 작성자		: tobe
	 * - 설명		: 공통 최근 본 상품
	 * </pre>
	 * @param map
	 * @param session
	 * @param view
	 * @param request
	 * @return
	 */
	@RequestMapping(value="indexRecentViews")
	@ResponseBody
	@Deprecated
	public ModelMap indexRecentViews(Session session, ViewBase view, HttpServletRequest request) {

		// 오늘본상품
		String recentGoods = "";
		try {
			recentGoods = CookieSessionUtil.getCookieValueDecURI(FrontWebConstants.COOKIE_RECENT_GOODS);
		} catch (Exception e) {
			// 보안성 진단. 오류메시지를 통한 정보노출
			log.warn("RecentGoods Cookie Read Error : ");
			//throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

		String[] recentGoodsArray = null;
		List<GoodsBaseVO> cookieGoodsList = null;
		GoodsBaseVO cookieGoods = null;

		if (StringUtils.isNotEmpty(recentGoods)) {
			recentGoodsArray = recentGoods.split("@@@");

			if (ArrayUtils.isEmpty(recentGoodsArray)) {

				cookieGoodsList = new ArrayList<>();

				for (String goods : recentGoodsArray) {

					String[] goodsInfo = goods.split(":::");

					cookieGoods = new GoodsBaseVO();

					cookieGoods.setGoodsId(goodsInfo[0]);
					cookieGoods.setGoodsNm(goodsInfo[1]);
					cookieGoods.setSaleAmt(Long.valueOf(goodsInfo[2]));
					cookieGoods.setDcAmt(Long.valueOf(goodsInfo[3]));
					cookieGoods.setImgSeq(Integer.valueOf(goodsInfo[4]));
					cookieGoods.setImgPath(goodsInfo[5]);

					cookieGoodsList.add(cookieGoods);
				}
			}
		}

		ModelMap map = new ModelMap();
		map.put("recentGoodsList", cookieGoodsList);
		map.put("session", session);
		map.put("view", view);

		return map;
	}

	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 34.front.brand.mobile
	 * - 파일명		: MyPageController.java
	 * - 작성일		: 2017. 3. 13.
	 * - 작성자		: hjko
	 * - 설명		: 마이페이지 > 최근본 상품 > 삭제
	 * </pre>
	 * @param session
	 * @param view
	 * @param request
	 * @param so
	 * @return
	 */
	@RequestMapping(value="deleteRecentViewGoods")
	@ResponseBody
	@Deprecated
	public ModelMap deleteRecentViewGoods( Session session, ViewBase view, HttpServletRequest request, GoodsBaseSO so){

		//log.debug("삭제할 최근 본 상품의 goodsIds >>>>>"+ so.getGoodsIds());

		String recentGoods = "";
		try {  // 기존 최근 본 상품 목록 쿠키
			recentGoods = CookieSessionUtil.getCookieValueDecURI(FrontWebConstants.COOKIE_RECENT_GOODS);
		} catch (Exception e) {
			// 보안성 진단. 오류메시지를 통한 정보노출
			log.warn("RecentGoods Cookie Read Error : ");
			//throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

		//log.debug("deleteRecentViewGoods recentGoods >>>>"+recentGoods);

		String[] recentGoodsArray = null;

		StringBuilder cookieVal = new StringBuilder(1024);

		if(StringUtils.isNotEmpty(recentGoods)){
			recentGoodsArray = recentGoods.split("@@@");
			//log.debug("recentGoodsArray> "+ recentGoodsArray);
			int cookieRecentGoodsCnt= recentGoodsArray.length;

			// 최근 본 상품 모두 삭제
			if(so.getGoodsIds().length==cookieRecentGoodsCnt ){
				Cookie cookie = new Cookie(FrontWebConstants.COOKIE_RECENT_GOODS, null);
				cookie.setMaxAge(0);
				CookieSessionUtil.setCookies(cookie);

			}else{  // 최근 본 상품 선택 삭제
				if(!ArrayUtils.isEmpty(recentGoodsArray)){

					for(String goods : recentGoodsArray){

						String[] goodsInfo = goods.split(":::");
						for(int i=0; i< so.getGoodsIds().length; i++){

							//log.debug("so >>>"+so.getGoodsIds()[i]);
							//log.debug("so.getGoodsIds()["+i+"] "+goodsInfo[0]);
							//log.debug("goodsInfo] "+goodsInfo[0]);
							if(so.getGoodsIds()[i].equals(goodsInfo[0])){
								break;
							}
							else{
								cookieVal.append(goodsInfo[0]+":::"+goodsInfo[1]+":::"+goodsInfo[2]+":::"+goodsInfo[3]+":::"+goodsInfo[4]+":::"+goodsInfo[5]+ "@@@");
							}
						}
					}
				}
			}

		}

		try {
			CookieSessionUtil.createCookieEncURI(FrontWebConstants.COOKIE_RECENT_GOODS, cookieVal.toString());
		} catch (Exception e) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		//log.debug("최근 본 상품목록>"+ cookieVal);

		return new ModelMap();
	}

	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 34.front.brand.mobile
	 * - 파일명		: MyPageController.java
	 * - 작성일		: 2017. 5. 29.
	 * - 작성자		: tobe
	 * - 설명		: 공통 최근 본 상품
	 * </pre>
	 * @param map
	 * @param session
	 * @param view
	 * @param request
	 * @return
	 */
	@RequestMapping(value="wishList")
	@ResponseBody
	public ModelMap indexRecentViews(MemberInterestGoodsSO so, Session session, ViewBase view, HttpServletRequest request){

		// 회원 관심 상품 목록
		so.setRows(FrontWebConstants.PAGE_ROWS_12);

		// 회원 관심 상품 검색 조건
		if(so.getSidx() == null){
			so.setSidx("SYS_REG_DTM");
		}else{
			so.setSidx(so.getSidx());
		}
		if(so.getSidx().equals("SYS_REG_DTM")){
			so.setSord(FrontWebConstants.SORD_DESC);
		}
		if(so.getSord() == null){
			so.setSord(FrontWebConstants.SORD_DESC);
		}else{
			so.setSord(so.getSord());
		}
		so.setMbrNo(session.getMbrNo());
		so.setStId(view.getStId());
		so.setWebMobileGbCd(FrontWebConstants.WEB_MOBILE_GB_10);

		// 회원 관심 상품  목록 조회
		List<MemberInterestGoodsVO> wishList = memberInterestGoodsService.pageMemberInterestGoods(so);

		ModelMap map = new ModelMap();
		map.put("wishList", wishList);
		map.put("session", session);
		map.put("view", view);

		return  map;
	}

	/**
	 * <pre>
	 * - 프로젝트명		: 31.front.web
	 * - 파일명		: MyInterestController.java
	 * - 작성일		: 2016. 5. 9.
	 * - 작성자		: phy
	 * - 설명			: 회원 관심 상품 삭제
	 * </pre>
	 * @param goodsIds
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("deleteWish")
	@ResponseBody
	public ModelMap deleteWish(String[] goodsIds, Session session) {

		Long mbrNo = session.getMbrNo();

		this.memberInterestGoodsService.deleteMemberInterestGoods(mbrNo, goodsIds);

		return new ModelMap();
	}

	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 33.front.brand.web
	 * - 파일명		: MyPageController.java
	 * - 작성일		: 2017. 3. 15.
	 * - 작성자		: hjko
	 * - 설명		: 마이페이지 > 회원 등급별 혜택 보기 팝업
	 * </pre>
	 * @param map
	 * @param view
	 * @return
	 */
	@RequestMapping(value="popupMemberGradeInfo")
	public String popupCashReceiptRequest(ModelMap map, ViewBase view){

		view.setTitle(message.getMessage("front.web.view.mypage.member.grade.info.popup.title"));

		map.put("mbrCodeList", this.codeCacheService.listCodeCache(FrontWebConstants.MBR_GRD_CD, null, null, null, null, null));
		map.put("view", view);

		return TilesView.popup(new String[] { "mypage", "popupMemberGradeInfo" });
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 31.front.web
	 * - 파일명		: GoodsController.java
	 * - 작성일		: 2020. 2. 3.
	 * - 작성자		: ksh
	 * - 설명		: 상품상세화면의 상품옵션 관련(html)
	 * </pre>
	 * @param ItemSO so
	 * @return
	 */
	@RequestMapping(value="indexGoodsOptions")
	public String indexGoodsOptions(ItemSO so){
		return  TilesView.none(
				new String[]{"goods", "include", so.getAttr1Val()}
		);
	}


	/**
	 * <pre>
	 * - 프로젝트명	: 31.front.web
	 * - 파일명		: GoodsController.java
	 * - 작성일		: 2021. 2. 16.
	 * - 작성자		: cyhvf01
	 * - 설명		: (공통) 연관 상품
	 * </pre>
	 * @param
	 * @return
	 */
	@RequestMapping(value="popupGoodsRelated/tv/{vdId}")
	public String indexTvRelatedGoods(HttpServletRequest request, HttpServletResponse response, ModelMap map, Session session, ViewBase view, @PathVariable String vdId) throws Exception {
		//, @PathVariable("goodsId") String goodsId

		GoodsRelatedSO so = new GoodsRelatedSO();
		so.setVdId(vdId);
		so.setStId(view.getStId());
		so.setWebMobileGbCd(view.getDeviceGb());
		so.setMbrNo(session.getMbrNo());
		/*List<String> petNos = session.getPetNos();*/
		//session.getPetNos(); 데이터 타입 변경
		List<String> petNos = new ArrayList<String>();
		if(StringUtil.isNotEmpty(session.getPetNos())) {
			String[] petNoSplit = session.getPetNos().split(",");
			for(String pNo : petNoSplit) {
				petNos.add(pNo);
			}
		}

		Long petNo = 0L;
		if(petNos != null && !petNos.isEmpty() && petNos.size()>0) {
			if(StringUtils.isNotEmpty(petNos.get(0)) && NumberUtils.isNumber(petNos.get(0)))  {
				petNo = Long.parseLong(petNos.get(0));
			}
		}
		so.setPetNo(petNo);

		List<GoodsBaseVO> list = goodsService.getGoodsRelatedWithTv(so);
		map.put("goodsList", list);

		Gson gson = new Gson();
		map.put("goodsListJson", gson.toJson(list));

		map.put("relatedWith", "TV");
		map.put("vdId", vdId);

		return  TilesView.none( new String[]{"goods", "common", "popupGoodsRelated"} );
	}

	@RequestMapping(value="popupGoodsRelated/petLog/{petLogNo}")
	public String indexPetLogRelatedGoods(HttpServletRequest request, HttpServletResponse response, ModelMap map, Session session, ViewBase view, @PathVariable Long petLogNo) throws Exception {
		//, @PathVariable("goodsId") String goodsId
		GoodsRelatedSO so = new GoodsRelatedSO();
		so.setPetLogNo(petLogNo);
		so.setStId(view.getStId());
		so.setWebMobileGbCd(view.getDeviceGb());
		so.setMbrNo(session.getMbrNo());
		/*List<String> petNos = session.getPetNos();*/
		//session.getPetNos(); 데이터 타입 변경
		List<String> petNos = new ArrayList<String>();
		if(StringUtil.isNotEmpty(session.getPetNos())) {
			String[] petNoSplit = session.getPetNos().split(",");
			for(String pNo : petNoSplit) {
				petNos.add(pNo);
			}
		}

		Long petNo = 0L;
		if(petNos != null && !petNos.isEmpty() && petNos.size()>0) {
			if(StringUtils.isNotEmpty(petNos.get(0)) && NumberUtils.isNumber(petNos.get(0)))  {
				petNo = Long.parseLong(petNos.get(0));
			}
		}
		so.setPetNo(petNo);

		PetLogBaseSO petLogBaseSo = new PetLogBaseSO();
		petLogBaseSo.setPetLogNo(so.getPetLogNo());
		PetLogBaseVO petLogBase = petLogService.getPetLogDetail(petLogBaseSo);
		map.put("petLogBase",petLogBase);
		
		so.setRvwYn(petLogBase.getRvwYn());
		so.setGoodsRcomYn(petLogBase.getGoodsRcomYn());
		//APETQA-3390 10개
		so.setLimit(10);

		List<GoodsBaseVO> list = goodsService.getGoodsRelatedWithPetLog(so);
		map.put("goodsList", list);

		Gson gson = new Gson();
		map.put("goodsListJson", gson.toJson(list));

		map.put("relatedWith", "LOG");
		map.put("petLogNo", petLogNo);
		map.put("session", session);

		return  TilesView.none( new String[]{"goods", "common", "layerGoodsRelated"} );
	}

	@RequestMapping(value="popupGoodsRelated/live")
	public String getRelatedGoodsWithLive(
			HttpServletRequest request, HttpServletResponse response, ModelMap map, Session session
			, GoodsRelatedSO so, ViewBase view) throws Exception {

		so.setStId(view.getStId());
		so.setWebMobileGbCd(view.getDeviceGb());
		so.setMbrNo(session.getMbrNo());
		so.setLimit(20);
		List<GoodsBaseVO> list = goodsService.getGoodsRelatedInGoods(so);
		map.put("goodsList", list);

		Gson gson = new Gson();
		map.put("goodsListJson", gson.toJson(list));
		map.put("relatedWith", "LIVE");

		return  TilesView.none( new String[]{"goods", "common", "popupGoodsRelated"} );
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 31.front.web
	 * - 파일명		: GoodsController.java
	 * - 작성일		: 2021. 2. 16.
	 * - 작성자		: cyhvf01
	 * - 설명		: (공통) 상품 요약
	 * </pre>
	 * @param
	 * @return
	 */
	@RequestMapping(value="popupGoodsSummary/{goodsId}")
	public String indexGoodsSummary(HttpServletRequest request, HttpServletResponse response, ModelMap map, Session session, ViewBase view, @PathVariable String goodsId) throws Exception {


		Long mbrNo = (session.getMbrNo() == 0 ? null : session.getMbrNo());
		GoodsBaseSO mso = new GoodsBaseSO();
		if(session.getMbrNo() != 0){
			mso.setMbrNo(session.getMbrNo());
		}
		if(view.getStId() != 0){
			mso.setStId(view.getStId());
		}
		// 웹/모바일 세팅
		String webMobileGbCd = view.getDeviceGb().equals(CommonConstants.DEVICE_GB_10) ? CommonConstants.WEB_MOBILE_GB_10: CommonConstants.WEB_MOBILE_GB_20;
		mso.setWebMobileGbCd(webMobileGbCd);
		// twc display 가능 카테고리 인지 확인 여부
		mso.setTwcDispClsfNos(webConfig.getProperty("disp.corn.no.goods.twc").split(":"));
		mso.setGoodsId(goodsId);

		//할인 혜택 getMemberGradeInfo
		MemberGradeVO memberGradeInfo = goodsService.getMemberGradeInfo(mbrNo);
		map.put("memberGradeInfo", memberGradeInfo);

		// 이미지 조회- goodsImgList
		Map<String, Object> goodsImgMap = goodsService.getGoodsImg(goodsId, CommonConstants.IMG_TP_10);
		map.putAll(goodsImgMap);

		// 상품 상세 아이콘 조회
		/*List<CodeDetailVO> goodsIconList = goodsIconService.listGoodsIconByGoodsId(goodsId);
		map.put("goodsIconList", goodsIconList);*/

		//평점 평균, 후기 갯수
		//상품기본정보 - 브랜드명, 브랜드링크, 상품명, 판매가,정상가,할인율,  MD 코멘트

		/*GoodsBaseVO goods = Optional.ofNullable(goodsService.getGoodsDetailFO(mso))
				.orElseThrow(() -> new CustomException(ExceptionConstants.ERROR_GOODS_NO_DATA));*/
		GoodsBaseVO goods = goodsDetailService.getGoodsDetail(mso);


		//상품 후기 평가 점수 조회
		GoodsCommentSO commentSO = new GoodsCommentSO();
		commentSO.setGoodsId(goods.getGoodsId());
		commentSO.setGoodsCstrtTpCd(goods.getGoodsCstrtTpCd());

		//전체 후기 수
		int commentTotalCnt = goodsCommentService.pageGoodsCommentCount(commentSO);
		map.put("commentTotalCnt", commentTotalCnt);

		if(StringUtils.equals(goods.getGoodsCstrtTpCd(), FrontConstants.GOODS_CSTRT_TP_PAK) ||
		StringUtils.equals(goods.getGoodsCstrtTpCd(), FrontConstants.GOODS_CSTRT_TP_ATTR)) {
			commentSO.setDlgtGoodsId(goods.getGoodsId());
		}
		//일반 후기가 5개 이상일 경우에만 구매 만족도 노출
		GoodsCommentVO commentVO = goodsCommentService.getGoodsCommentScore(commentSO);

		map.put("scoreList", commentVO);


		// 옵션 리스트
		mso.setGoodsCstrtTpCd(goods.getGoodsCstrtTpCd());
		List<GoodsBaseVO> goodsCstrtList = goodsDetailService.listGoodsCstrt(mso);

		// 구매여부 버튼.
		if(CollectionUtils.isNotEmpty(goodsCstrtList)) {
			if(goods.getGoodsCstrtTpCd().equals(FrontConstants.GOODS_CSTRT_TP_ATTR) || goods.getGoodsCstrtTpCd().equals(FrontConstants.GOODS_CSTRT_TP_PAK)){
				goods.setTotalSalePsbCd(goodsCstrtList.get(0).getTotalSalePsbCd());
			}else {
				goods.setTotalSalePsbCd(goods.getSalePsbCd());
			}
		}else {
			goods.setTotalSalePsbCd(goods.getSalePsbCd());
		}

		// 옵션 정보 조회(ITEM:단품 ATTR:옵션 SET:세트 PAK:묶음)
		ItemSO itemSO = new ItemSO();
		itemSO.setGoodsId(goods.getGoodsId());
		List<ItemVO> listItems = goodsService.listGoodsItems(itemSO);
		//첫번째 단품에 대한 정보 조회(조립비, 배송비 포함)
		if(goods.getGoodsCstrtTpCd().equals(FrontConstants.GOODS_CSTRT_TP_ITEM) || goods.getGoodsCstrtTpCd().equals(FrontConstants.GOODS_CSTRT_TP_SET)){
			ItemVO itemVO = listItems.stream().findFirst().orElse(new ItemVO());
			map.put("listItemSize", (listItems == null ? 0 : listItems.size()));
			map.put("listItems", itemVO);
		}else if(goods.getGoodsCstrtTpCd().equals(FrontConstants.GOODS_CSTRT_TP_ATTR)){
			List<AttributeVO> listAttr = goodsService.listGoodsItemsAttr(goods.getGoodsId(), CommonConstants.COMM_YN_Y, view.getSvcGbCd());
			map.put("listAttrs", listAttr);
		}else if(goods.getGoodsCstrtTpCd().equals(FrontConstants.GOODS_CSTRT_TP_PAK)){
			GoodsCstrtPakPO listPakSo = new GoodsCstrtPakPO();
			listPakSo.setGoodsId(goods.getGoodsId());
			listPakSo.setSoldOutYn("N");
			List<GoodsCstrtPakVO> listPak = goodsCstrtPakService.listPakGoodsCstrtPak(listPakSo);
			map.put("listPaks", listPak);
		}

		map.put("goods", goods);


		// 연관태그 조회
		List<TagBaseVO> tagList = tagService.listTagGoodsId(goodsId);
		map.put("tagList", tagList);

		//적립포인트
		// 배송 정책 조회
		if(goods.getDlvrcPlcNo() != null){
			ItemVO itemVO = listItems.stream().findFirst().orElse(new ItemVO());
			DeliveryChargePolicyVO deliveryChargePolicy = this.goodsService.getGoodsDeliveryChargePolicy(goods.getDlvrcPlcNo(), itemVO);
			map.put("deliveryChargePolicy", deliveryChargePolicy);
		}

		String postNo = "";
		if(mbrNo != null){
			MemberAddressVO memberAddress = memberAddressService.getMemberAddressDefault( mbrNo ) ;
			if(memberAddress != null) {
				postNo = memberAddress.getPostNoNew();
			}
		}
		List<OrderDlvrAreaVO> listDlvrPrcs = orderDlvrAreaService.getDlvrPrcsListFromTime(postNo);
		map.put("listDlvrPrcs", listDlvrPrcs);

		//옵션 정보 ?

		/*GoodsRelatedSO so = new GoodsRelatedSO();
		so.setGoodsId(goodsId);
		so.setMbrNo(session.getMbrNo());
		List<String> petNos = session.getPetNos();
		Long petNo = 0L;
		if(petNos != null && !petNos.isEmpty() && petNos.size()>0) {
			if(StringUtils.isNotEmpty(petNos.get(0))) {
				petNo = Long.parseLong(petNos.get(0));
			}
		}
		so.setPetNo(petNo);
		double rate = goodsService.getGoodsRecommendRate(so);*/

		map.addAttribute("currentTime", DateUtil.getNowDateTime());
		map.put("session", session);
		map.put("view", view);

		return  TilesView.none( new String[]{"goods", "common", "popupGoodsSummary"} );
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 31.front.web
	 * - 파일명		: GoodsController.java
	 * - 작성일		: 2021. 2. 16.
	 * - 작성자		: cyhvf01
	 * - 설명		: (공통) 옵션 선택
	 * </pre>
	 * @param
	 * @return
	 */
	@RequestMapping(value="popupGoodsOption")
	public String indexGoodsOptions(HttpServletRequest request, HttpServletResponse response, ModelMap map, Session session, ViewBase view, @RequestParam String goodsId) {
		return  TilesView.none( new String[]{"goods", "common", "option"} );
	}


	/**
	 *
	 * <pre>
	 * - 프로젝트명    : gs-apet-31-front
	 * - 파일명        : GoodsDetailController.java
	 * - 작성일        : 2021. 2. 22.
	 * - 작성자        : YKU
	 * - 설명          : 펫로그 후기 더보기
	 * </pre>
	 * @param map
	 * @param view
	 * @param session
	 * @param so
	 * @return
	 */
	@RequestMapping(value="indexPetLogCommentList")
	public String indexPetLogCommentList(ModelMap map, ViewBase view, PetLogGoodsSO so) {


		// PC는 18개씩 , MO/APP은 15개씩 노출
		if(StringUtil.equals(view.getDeviceGb() , CommonConstants.DEVICE_GB_10)) {
			so.setRows(FrontWebConstants.PAGE_ROWS_18);
		}else {
			so.setRows(FrontWebConstants.PAGE_ROWS_15);
		}

//		List<PetLogBaseVO> petLogReView = petLogService.pagePetLogBase(petSo);

		List<PetLogGoodsVO> petLogReView = goodsCommentService.petLogReview(so);
		//so.setTotalCount(petLogReView.size());

		map.put("petLogReView", petLogReView);
		map.put("petSo", so);
		map.put("view", view);
		return TilesView.none(new String[]{"goods", "include", "indexPetLogCommentList"});
	}

	/**
	 *
	 * <pre>
	 * - 프로젝트명    : gs-apet-31-front
	 * - 파일명        : GoodsController.java
	 * - 작성일        : 2021. 2. 24.
	 * - 작성자        : YKU
	 * - 설명          : 펫로그 후기 상세
	 * </pre>
	 * @param map
	 * @param session
	 * @param viewS
	 * @param so
	 * @return
	 */
	@RequestMapping(value="indexPetLogCommentDetailList")
	public String indexPetLogCommentDetailList( ModelMap map, Session session, ViewBase view, PetLogGoodsSO so , String index){
		so.setMbrNo(session.getMbrNo());
		List<PetLogGoodsVO> petLogReView = goodsCommentService.petLogReview(so);
		GoodsCommentSO goodsSo = new GoodsCommentSO();
		for(int i=0; i<petLogReView.size(); i++) {
			goodsSo.setGoodsEstmNo(petLogReView.get(i).getGoodsEstmNo());
			List<GoodsEstmQstVO> petLogGoodsList = goodsCommentService.getPageGoodsCommentEstmList(goodsSo);
			petLogReView.get(i).setPetLogGoodsList(petLogGoodsList);
		}
		so.setTotalCount(petLogReView.size());
		map.put("index", index);
		map.put("petLogReView", petLogReView);
		map.put("so", so);
		map.put("session" ,session);
		return  TilesView.none(new String[]{"goods", "include", "indexPetLogCommentDetailList"});
	}

	@RequestMapping(value="indexPetLogCommentDetailListPaging")
	public String indexPetLogCommentDetailListPaging( ModelMap map, Session session, ViewBase view, PetLogGoodsSO so ){
		so.setMbrNo(session.getMbrNo());
		
		List<PetLogGoodsVO> petLogReView = goodsCommentService.petLogReview(so);
		
		GoodsCommentSO goodsSo = new GoodsCommentSO();
		for(int i=0; i<petLogReView.size(); i++) {
			goodsSo.setGoodsEstmNo(petLogReView.get(i).getGoodsEstmNo());
			List<GoodsEstmQstVO> petLogGoodsList = goodsCommentService.getPageGoodsCommentEstmList(goodsSo);
			petLogReView.get(i).setPetLogGoodsList(petLogGoodsList);
		}
		so.setTotalCount(petLogReView.size());
		map.put("petLogReView", petLogReView);
		map.put("so", so);
		map.put("session" ,session);
		return  TilesView.none(new String[]{"goods", "include", "indexPetLogCommentDetailListPaging"});
	}


	/**
	 *
	 * <pre>
	 * - 프로젝트명    : gs-apet-31-front
	 * - 파일명        : GoodsController.java
	 * - 작성일        : 2021. 3. 21.
	 * - 작성자        : cyhvf01
	 * - 설명          : SGR 상품 목록 API
	 * </pre>
	 * @param map
	 * @param session
	 * @param viewS
	 * @param so
	 * @return
	 */
	@RequestMapping(value="indexGoodsListForSGR", method = RequestMethod.POST)
	public String indexxSgrGoodsList( ModelMap map, Session session, ViewBase view, GoodsBaseSO so) {
		String jsonStr = "";
		String resultStr = "정상";
		HashMap<String, Object> jsonMap = new HashMap();
		if(!NumberUtils.isNumber(so.getDispClsfNo()+"")
				&& StringUtil.isEmpty(so.getGoodsIdArea())
				//&& ArrayUtils.isEmpty(so.getGoodsIds())
				&& StringUtils.isEmpty(so.getSrchWord())
		) {
			resultStr = "카테고리,상품아이디,검색어 중 하나는 반드시 입력되어야 합니다.";
		}else{
			if(so.getPage() == 0) {so.setPage(1);}
			if(so.getRows() == 0) {so.setRows(CommonConstants.RECORD_COUNT_PAGE);}

			if(CommonConstants.NO_MEMBER_NO.equals(so.getMbrNo())) {
				so.setMbrNo(null);
			}

			so.setLimit((so.getPage()-1)*so.getRows());
			so.setOffset(so.getRows());
			if(!StringUtil.isEmpty(so.getGoodsIdArea())) {
				//so.setGoodsIds(StringUtil.splitEnter(so.getGoodsIdArea()));
				so.setGoodsIds( StringUtil.split(so.getGoodsIdArea(), ",") );
			}
			List<GoodsBaseVO> goodsList = goodsService.getSgrGoodsList(so);
			jsonMap.put("goodsList", goodsList);
		}

		jsonMap.put("result", resultStr);

		Gson gson = new Gson();
		jsonStr = gson.toJson(jsonMap);

		map.put("resultJsonStr", jsonStr);
		return  TilesView.none(new String[]{"goods", "common", "json"});
	}

	@ResponseBody
	@RequestMapping(value="petLogCmtDelete")
	public ModelMap petLogCmtDelete(PetLogGoodsVO vo, Session session) {

		log.info("logIasdsadadas" + vo);
		vo.setMbrNo(session.getMbrNo());
		 goodsService.petLogCmtDelete(vo);
		 return new ModelMap();
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: gs-apet-31-front
	 * - 파일명		: GoodsController.java
	 * - 작성일		: 2021. 6. 17.
	 * - 작성자		: 이동식
	 * - 설명			: 펫샵 > 상품상세 > 이미지 팝업
	 * </pre>
	 * @param map
	 * @param session
	 * @param viewS
	 * @param so
	 * @return
	 */
	@RequestMapping(value="includeGoodsCommentImgPop")
	public String includeGoodsCommentImgPop( ModelMap map, Session session, ViewBase view, PetLogGoodsSO so){
		so.setMbrNo(session.getMbrNo());
		map.put("so", so);
		map.put("session" ,session);
		return  TilesView.none(new String[]{"goods", "includeNew", "includeGoodsCommentImgPop"});
	}

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-31-front
	* - 파일명		: GoodsController.java
	* - 작성일		: 2021. 8. 5.
	* - 작성자		: pcm
	* - 설명		: 탈퇴회원 체크
	* </pre>
	* @param session
	* @return
	*/
	@ResponseBody
	@RequestMapping(value="mbrStatCheck")
	public String mbrStatCheck(Session session) {
		String result = "true";
		if(session.getMbrNo() != 0) {
			MemberBaseSO so = new MemberBaseSO();
			so.setMbrNo(session.getMbrNo());
			MemberBaseVO vo = memberService.getMemberBase(so);
			if(StringUtil.isNotEmpty(vo)) {
				if(StringUtil.equals(vo.getMbrStatCd(), FrontConstants.MBR_STAT_50)) {
					result = "false";
				}
			}else {
				result = "false";
			}
		}
		return result;
	}
}