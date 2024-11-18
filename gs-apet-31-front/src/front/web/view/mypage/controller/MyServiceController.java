package front.web.view.mypage.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.Properties;

import org.apache.commons.lang.StringEscapeUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import biz.app.goods.model.GoodsBaseVO;
import biz.app.goods.model.GoodsCommentPO;
import biz.app.goods.model.GoodsCommentSO;
import biz.app.goods.model.GoodsCommentVO;
import biz.app.goods.model.GoodsInquirySO;
import biz.app.goods.model.GoodsInquiryVO;
import biz.app.goods.service.GoodsCommentService;
import biz.app.goods.service.GoodsInquiryService;
import biz.app.goods.service.GoodsService;
import biz.app.member.model.MemberAddressPO;
import biz.app.member.model.MemberAddressSO;
import biz.app.member.model.MemberAddressVO;
import biz.app.member.model.MemberCouponPO;
import biz.app.member.model.MemberCouponVO;
import biz.app.member.service.MemberAddressService;
import biz.app.member.service.MemberCouponService;
import biz.app.order.model.OrderDetailPO;
import biz.app.order.model.OrderDetailVO;
import biz.app.order.model.OrderSO;
import biz.app.promotion.model.CouponBaseVO;
import biz.app.promotion.model.CouponSO;
import biz.app.promotion.service.CouponService;
import biz.app.system.model.CodeDetailVO;
import biz.common.service.CacheService;
import framework.common.annotation.LoginCheck;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import framework.common.model.PopParam;
import framework.common.util.DateUtil;
import framework.common.util.StringUtil;
import framework.front.constants.FrontConstants;
import framework.front.model.Session;
import framework.front.util.FrontSessionUtil;
import front.web.config.constants.FrontWebConstants;
import front.web.config.page.Paging;
import front.web.config.tiles.TilesView;
import front.web.config.view.ViewBase;
import front.web.view.mypage.model.AddressEditParam;
import front.web.view.mypage.model.GoodsCommentRegParam;
import lombok.extern.slf4j.Slf4j;

/**
* <pre>
* - 프로젝트명	: 31.front.web
* - 패키지명	: front.web.view.mypage.controller
* - 파일명		: MyServiceController.java
* - 작성일		: 2016. 3. 2.
* - 작성자		: snw
* - 설명		: 서비스정보 Controller
* </pre>
*/
@Slf4j
@Controller
@RequestMapping("mypage/service")
public class MyServiceController {

	@Autowired private MessageSourceAccessor message;

	@Autowired private MemberAddressService memberAddressService;
	
	@Autowired private CacheService codeCacheService;
	
	@Autowired private GoodsInquiryService goodsInquiryService;
	
	@Autowired private GoodsCommentService goodsCommentService;

	@Autowired private GoodsService goodsService;
	
	@Autowired private Properties webConfig;
	
	@Autowired private Properties bizConfig;

	@Autowired private CacheService cacheService;

	@Autowired private CouponService couponService;

	@Autowired private MemberCouponService memberCouponService;

	/**
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명		: MyServiceController.java
	* - 작성일		: 2016. 3. 2.
	* - 작성자		: snw
	* - 설명		: 배송지 목록 화면
	* </pre>
	* @param map
	* @param so
	* @param session
	* @param view
	* @return
	* @throws Exception
	*/
	@LoginCheck
	@RequestMapping(value="indexAddressList")
	public String indexAddressList(ModelMap map, MemberAddressSO so, Session session, ViewBase view){

		so.setMbrNo(session.getMbrNo());

		List<MemberAddressVO> addressList = this.memberAddressService.listMemberAddress(so);
		
		view.setSeoSvcGbCd(FrontConstants.SEO_SVC_GB_CD_40);
		map.put("addressList", addressList);
		map.put("so", so);
		map.put("session", session);
		map.put("view", view);
		
		if(StringUtil.equals(view.getDeviceGb() , CommonConstants.DEVICE_GB_10)) {
			return "mypage/service/indexAddressList";
		}else {
			return "mypage/service/indexAddressListMo";
		}
		
	}


	/**
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명		: MyServiceController.java
	* - 작성일		: 2016. 3. 2.
	* - 작성자		: snw
	* - 설명		: 배송지 추가/수정 팝업 화면
	* </pre>
	* @param map
	* @param session
	* @param view
	* @param param
	* @return
	* @throws Exception
	*/
	@LoginCheck
	@RequestMapping(value="popupAddressEdit")
	public String popupAddressEdit(ModelMap map, Session session, ViewBase view, AddressEditParam param , String popYn){

		MemberAddressVO address = null;

		if(StringUtil.isNotEmpty(param.getMbrDlvraNo())){
			address = this.memberAddressService.getMemberAddress(param.getMbrDlvraNo());
		}else{
			address = new MemberAddressVO();
			address.setMbrNo(session.getMbrNo());
		}
		
		map.put("popYn", popYn);
		map.put("address", address);
		map.put("param", param);
		map.put("goodsRcvPstList", this.cacheService.listCodeCache(CommonConstants.GOODS_RCV_PST, null, null, null, null, null));
		map.put("pblGateEntMtdList", this.cacheService.listCodeCache(CommonConstants.PBL_GATE_ENT_MTD, null, null, null, null, null));

		MemberAddressSO so = new MemberAddressSO();
		so.setMbrNo(session.getMbrNo());
		List<MemberAddressVO> addressList = this.memberAddressService.listMemberAddress(so);
		
		map.put("addressCnt", addressList.size());
		
		if(StringUtil.equals(view.getDeviceGb() , CommonConstants.DEVICE_GB_10)) {
			return "mypage/service/popupAddressEdit";
		}else {
			return "mypage/service/popupAddressEditMo";
		}
	}
	

	/**
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명		: MyServiceController.java
	* - 작성일		: 2016. 3. 2.
	* - 작성자		: snw
	* - 설명		: 배송지 등록
	* </pre>
	* @param session
	* @param po
	* @return
	* @throws Exception
	*/
	@LoginCheck
	@RequestMapping(value="insertAddress", method=RequestMethod.POST)
	@ResponseBody
	public int insertAddress(Session session, MemberAddressPO po) {
		
		po.setMbrNo(session.getMbrNo());
		po.setSysRegrNo(session.getMbrNo());

		int result = this.memberAddressService.insertMemberAddress(po);
		
		return result;
	}


	/**
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명		: MyServiceController.java
	* - 작성일		: 2016. 3. 2.
	* - 작성자		: snw
	* - 설명		: 배송지 수정
	* </pre>
	* @param session
	* @param po
	* @return
	* @throws Exception
	*/
	@LoginCheck
	@RequestMapping(value="updateAddress", method=RequestMethod.POST)
	@ResponseBody
	public int updateAddress(Session session, MemberAddressPO po) {
		
		po.setSysUpdrNo(session.getMbrNo());

		int result = this.memberAddressService.updateMemberAddress(po);
		
		return result;
	}


	/**
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명		: MyServiceController.java
	* - 작성일		: 2016. 3. 2.
	* - 작성자		: snw
	* - 설명		: 배송지 멀티 삭제
	* </pre>
	* @param session
	* @param mbr_dlvra_nos
	* @return
	* @throws Exception
	*/
	@LoginCheck
	@RequestMapping(value="deleteAddress", method=RequestMethod.POST)
	@ResponseBody
	public int deleteAddress(Session session, Long mbrDlvraNo) {
		
		int result = this.memberAddressService.deleteMemberAddress(mbrDlvraNo);
		
		return result;
	}

	/**
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명		: MyServiceController.java
	* - 작성일		: 2016. 3. 2.
	* - 작성자		: snw
	* - 설명		: 배송지 기본 설정
	* </pre>
	* @param session
	* @param po
	* @return
	* @throws Exception
	*/
	@LoginCheck
	@RequestMapping(value="updateAddressDefault", method=RequestMethod.POST)
	@ResponseBody
	public ModelMap updateAddressDefault(Session session, MemberAddressPO po) {
		
		po.setMbrNo(session.getMbrNo());
		po.setSysUpdrNo(session.getMbrNo());

		this.memberAddressService.updateMemberAddressDefault(po);
		
		return new ModelMap();
	}
	

	/**
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명		: MyServiceController.java
	* - 작성일		: 2016. 3. 2.
	* - 작성자		: snw
	* - 설명		: Front 마이페이지 - 작성가능한 상품평 목록 화면
	* </pre>
	* @param map
	* @param session
	* @param view
	* @return
	* @throws Exception
	*/
	@LoginCheck
	@RequestMapping(value="indexGoodsComment")
	public String indexGoodsComment(ModelMap map, Session session, ViewBase view, OrderSO so){

		so.setSidx("sys_reg_dtm"); //정렬 컬럼 명
		so.setSord(FrontWebConstants.SORD_DESC);
		so.setMbrNo(session.getMbrNo());
		// 작성가능한 상품평 목록 조회
		List<OrderDetailVO> commentList = goodsCommentService.pageBeforeGoodsCommentList(so);
		map.put("commentList", commentList);
		map.put("paging", new Paging(so));
		map.put("session", session);	
		map.put("view", view);
		map.put(FrontWebConstants.MYPAGE_MENU_GB, FrontWebConstants.MYPAGE_MENU_SERVICE_GOODS_COMMENT);

		return  TilesView.mypage(new String[]{"service", "indexGoodsComment"});
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명	: MyServiceController.java
	* - 작성일	: 2016. 4. 11.
	* - 작성자	: jangjy
	* - 설명		: Front 마이페이지 - 상품평가 팝업 화면 초기표시
	* </pre>
	* @param map
	* @param view
	* @param session
	* @param param
	* @return
	* @throws Exception
	*/
	@LoginCheck
	@RequestMapping(value="popupGoodsCommentReg")
	public String popupGoodsCommentReg(ModelMap map, ViewBase view, Session session, GoodsCommentRegParam param){

		// 상품 정보 취득
		GoodsBaseVO goods = this.goodsService.getGoodsBase(param.getGoodsId());
		map.put("goods", goods);

		GoodsCommentVO goodsComment = null;
		if(param.getGoodsEstmNo() != null){	// 상품평 수정
			view.setTitle(this.message.getMessage("front.web.view.goods.comment.modify.popup.title"));
			
			// 작성된 상품평가 정보 조회
			goodsComment = this.goodsCommentService.getGoodsCommentBase(Long.valueOf(param.getGoodsEstmNo()));
			
			if(session.getMbrNo().intValue() != goodsComment.getEstmMbrNo()){
				throw new CustomException(ExceptionConstants.ERROR_GOODS_COMMENT_NO_EQUAL_MBR);
			}
			
		} else {	// 상품평 작성
			view.setTitle(this.message.getMessage("front.web.view.goods.comment.regist.popup.title"));
		}
		
		map.put("text", this.bizConfig.getProperty("member.savedMoney.text.amt"));
		map.put("photo", this.bizConfig.getProperty("member.savedMoney.photo.amt"));
		
		map.put("goodsComment", goodsComment);
		map.put("view", view);
		map.put("session", session);
		map.put("param", param);
		
		return  TilesView.popup(
				new String[]{"mypage", "service", "popupGoodsCommentReg"}
				);
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명	: MyServiceController.java
	* - 작성일	: 2016. 4. 12.
	* - 작성자	: jangjy
	* - 설명		: 상품평 등록
	* </pre>
	* @param GoodsCommentPO
	* @param OrderDetailPO
	* @param Session
	* @return
	* @throws Exception
	*/
	@LoginCheck
	@RequestMapping(value="insertGoodsComment")
	@ResponseBody
	public ModelMap insertGoodsComment(GoodsCommentPO gPo, OrderDetailPO oPo, Session session){

		// 상품평가  Param Object 설정
		gPo.setSysRegrNo(session.getMbrNo());
		gPo.setEstmMbrNo(session.getMbrNo());
		
		// 주문상세  Param Object 설정
		oPo.setGoodsEstmRegYn(CommonConstants.COMM_YN_Y);
		oPo.setSysUpdrNo(session.getMbrNo());
		
		gPo.setStId(Long.valueOf(this.webConfig.getProperty("site.id")));
		
		this.goodsCommentService.insertGoodsComment(gPo, oPo);
		
		return new ModelMap();
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명	: MyServiceController.java
	* - 작성일	: 2016. 4. 14.
	* - 작성자	: jangjy
	* - 설명		: 상품평 수정
	* </pre>
	* @param GoodsCommentPO
	* @param Session
	* @return
	* @throws Exception
	*/
	/*@LoginCheck
	@RequestMapping(value="updateGoodsComment")
	@ResponseBody
	public ModelMap updateGoodsComment(GoodsCommentPO po, Session session){

		po.setSysUpdrNo(session.getMbrNo());
		po.setEstmMbrNo(session.getMbrNo());
		
		this.goodsCommentService.updateGoodsComment(po);
		
		return new ModelMap();
	}*/
	
	/**
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명	: MyServiceController.java
	* - 작성일	: 2016. 4. 14.
	* - 작성자	: jangjy
	* - 설명		: 상품평 삭제
	* </pre>
	* @param GoodsCommentPO
	* @param Session
	* @return
	* @throws Exception
	*/
	@LoginCheck
	@RequestMapping(value="deleteGoodsComment")
	@ResponseBody
	public ModelMap deleteGoodsComment(Long goodsEstmNo, Session session){

		GoodsCommentPO po = new GoodsCommentPO();
		po.setGoodsEstmNo(goodsEstmNo);
		po.setEstmMbrNo(session.getMbrNo());
		
		this.goodsCommentService.deleteGoodsComment(po);
		
		return new ModelMap();
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명	: MyServiceController.java
	* - 작성일	: 2016. 4. 12.
	* - 작성자	: jangjy
	* - 설명		: Front 마이페이지 - 작성한 상품평 목록 화면
	* </pre>
	* @param map
	* @param session
	* @param view
	* @return
	* @throws Exception
	*/
	@LoginCheck
	@RequestMapping(value="indexGoodsCommentList")
	public String indexGoodsCommentList(ModelMap map, Session session, ViewBase view, GoodsCommentSO so){
		
		if (so.getPeriod() == null) {so.setPeriod("1");}
		so.setRows(FrontWebConstants.PAGE_ROWS_10);
		if(so.getSidx() == null || "".equals(so.getSidx())){
			so.setSidx("sys_reg_dtm"); //정렬 컬럼 명
		}
		so.setSord(FrontWebConstants.SORD_DESC);
		so.setEstmMbrNo(session.getMbrNo());
		
		// 날짜 조회 param 설정
		so.setSysRegDtmStart(DateUtil.convertSearchDate("S", so.getSysRegDtmStart()));
		so.setSysRegDtmEnd(DateUtil.convertSearchDate("E", so.getSysRegDtmEnd()));
		
		// 작성한 상품평 목록 조회
		List<GoodsCommentVO> goodsCommentList = goodsCommentService.pageAfterGoodsCommentList(so);
		map.put("goodsCommentList", goodsCommentList);
		map.put("paging", new Paging(so));
		map.put("view", view);
		map.put("session", session);
		map.put(FrontWebConstants.MYPAGE_MENU_GB, FrontWebConstants.MYPAGE_MENU_SERVICE_GOODS_COMMENT);

		return  TilesView.mypage(new String[]{"service", "indexGoodsCommentList"});
	}


	/**
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명		: MyServiceController.java
	* - 작성일		: 2016. 3. 2.
	* - 작성자		: snw
	* - 설명		: 마이페이지 - 상품문의 목록  화면
	* </pre>
	* @param map
	* @param session
	* @param view
	* @return
	* @throws Exception
	*/
	@LoginCheck
	@RequestMapping(value="indexGoodsInquiryList")
	public String indexGoodsInquiryList(ModelMap map, Session session, ViewBase view, GoodsInquirySO so){
		
		so.setSidx("sys_reg_dtm"); //정렬 컬럼 명
		so.setSord(FrontWebConstants.SORD_DESC);
		so.setRows(FrontWebConstants.PAGE_ROWS_10); // 한페이지에 데이터 10건씩
		so.setEqrrMbrNo(session.getMbrNo());
		so.setStId(Long.valueOf(this.webConfig.getProperty("site.id")));
		// 마이페이지 상품문의 목록 조회
		List<GoodsInquiryVO> goodsInquiryList = goodsInquiryService.pageMyGoodsInquiry(so);
		// 상품 문의 상태 코드 취득
		List<CodeDetailVO> goodsIqrStatCdList = this.codeCacheService.listCodeCache(CommonConstants.GOODS_IQR_STAT, null, null, null, null, null);
		
		map.put("goodsInquiry", goodsInquiryList);
		map.put("goodsIqrStatCdList", goodsIqrStatCdList);
		map.put("paging", new Paging(so));
		map.put("session", session);
		map.put("view", view);
		map.put(FrontWebConstants.MYPAGE_MENU_GB, FrontWebConstants.MYPAGE_MENU_SERVICE_GOODS_INQUIRY);

		return  TilesView.mypage(new String[]{"service", "indexGoodsInquiryList"});
	}
	
	
	@RequestMapping(value="popupAddressList")
	@Deprecated
	public String popupAddressList(ModelMap map, MemberAddressSO so, Session session, ViewBase view){

		so.setMbrNo(session.getMbrNo());

		List<MemberAddressVO> addressList = this.memberAddressService.listMemberAddress(so);
		
		map.put("addressList", addressList);
		map.put("so", so);
		map.put("session", session);
		map.put("view", view);
		
		return "mypage/service/indexAddressListPop";
	}

	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-31-front
	 * - 파일명		: MyShopController.java
	 * - 작성일		: 2016. 3. 2.
	 * - 작성자		: 김재윤
	 * - 설명		: 내 쇼핑 정보 관리 - 쿠폰존
	 * </pre>
	 * @param model
	 * @param session
	 * @param view
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/coupon")
	public String coupon(Model model, Session session, ViewBase view,CouponSO so
			,@RequestParam(value="r",required = false)String returnUrl
		){
		
		view.setSeoSvcGbCd(FrontWebConstants.SEO_SVC_GB_CD_40);
		
		so = getCouponZoneSearchCondition(session,so,view);
		List<CouponBaseVO> list = couponService.listCouponZone(so);
		list.stream().forEach(v->{
			String nt = v.getNotice();
			nt = StringEscapeUtils.unescapeHtml(nt);
			nt = nt.replaceAll("<p>","").replaceAll("&nbsp;","").replaceAll("</p>","<br>").replaceAll("</br>","<br>");
			if(StringUtil.isEmpty(nt.replaceAll(" <br>","").replaceAll("<br>","").replaceAll("\\s*","").trim())){
				v.setNotice(null);
			}else{
				String[] nts = nt.split("<br>");
				v.setNotice(nt);
				v.setNotices(nts);
			}
		});

		CouponSO mso = new CouponSO();
		mso.setWebMobileGbCdList(so.getWebMobileGbCdList());
		model.addAttribute("isCanDownYn",couponService.getCouponIsAllDownYn(mso));

		model.addAttribute("view",view);
		model.addAttribute("session",session);
		model.addAttribute("list",list);
		model.addAttribute("listSize",list.size());
		model.addAttribute("isLogin",Long.compare(session.getMbrNo(),0L) == 0 ? FrontConstants.COMM_YN_N : FrontConstants.COMM_YN_Y);
		model.addAttribute("returnUrl",returnUrl);
		model.addAttribute("p",so.getPage());
		model.addAttribute("t",so.getTotalPageCount());
		return TilesView.mypage(new String[]{"service","indexCouponZone"});
	}
	
	//쿠폰존 - 페이징
	@RequestMapping(value="/paging/coupon" , method=RequestMethod.GET)
	public String pagingCouponZone(Model model, Session session, ViewBase view,CouponSO so , @RequestParam(value="t")Integer totalPageCount){
		int page = Optional.ofNullable(so.getPage()).orElseGet(()->1);

		List<CouponBaseVO> list = new ArrayList<CouponBaseVO>();
		if(page<=totalPageCount){
			so = getCouponZoneSearchCondition(session,so,view);
			list = couponService.listCouponZone(so);
			list.stream().forEach(v->{
				String nt = v.getNotice();
				nt = StringEscapeUtils.unescapeHtml(nt);
				nt = nt.replaceAll("<p>","").replaceAll("&nbsp;","").replaceAll("</p>","<br>").replaceAll("</br>","<br>");
				if(StringUtil.isEmpty(nt.replaceAll(" <br>","").replaceAll("<br>","").replaceAll("\\s*","").trim())){
					v.setNotice(null);
				}else{
					String[] nts = nt.split("<br>");
					v.setNotice(nt);
					v.setNotices(nts);
				}
			});
		}

		model.addAttribute("list",list);
		model.addAttribute("listSize",list.size());
		model.addAttribute("p",so.getPage());
		model.addAttribute("t",totalPageCount);
		return TilesView.mypage(new String[]{"service","/paging/couponZoneBody"});
	}

	private CouponSO getCouponZoneSearchCondition(Session session,CouponSO so,ViewBase view){
		String mbrGbCd = Optional.ofNullable(session.getMbrGbCd()).orElseGet(()->"");
		Long mbrNo = Optional.ofNullable(session.getMbrNo()).orElseGet(()->0L);
		String deviceGb = view.getDeviceGb();
		
		//회원 번호 및 정렬 기준
		so.setMbrNo(mbrNo);
		so.setRows(20);
		so.setPage(Optional.ofNullable(so.getPage()).orElseGet(()->1));
		so.setSidx("CB.CP_APL_CD ASC, CB.APL_VAL DESC , CB.VLD_PRD_END_DTM ASC , CB.SYS_REG_DTM");
		so.setSord("DESC");
		
		//웹앱 모바일 구분
		List<String> webMobileGbCdList = new ArrayList<String>();
		webMobileGbCdList.add(CommonConstants.WEB_MOBILE_GB_00);
		if(StringUtil.equals(deviceGb,FrontConstants.DEVICE_GB_30) || StringUtil.equals(deviceGb,FrontConstants.DEVICE_GB_20)){
			webMobileGbCdList.add(CommonConstants.WEB_MOBILE_GB_20);
		}else{
			webMobileGbCdList.add(CommonConstants.WEB_MOBILE_GB_10);
		}
		so.setWebMobileGbCdList(webMobileGbCdList);
		
		//정회원,준회원 구분
		if(StringUtil.equals(mbrGbCd,FrontConstants.MBR_GB_CD_10)){
			so.setIsuTgCd(FrontConstants.ISU_TG_20);
		}else if(StringUtil.equals(mbrGbCd,FrontConstants.MBR_GB_CD_20)){
			so.setIsuTgCd(FrontConstants.ISU_TG_10);
		}else{
			so.setIsuTgCd(FrontConstants.ISU_TG_00);
		}

		return so;
	}

	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-31-front
	 * - 파일명		: MyShopController.java
	 * - 작성일		: 2016. 3. 2.
	 * - 작성자		: 김재윤
	 * - 설명		: 내 쇼핑 정보 관리 - 쿠폰 모두 받기
	 * </pre>
	 * @param model
	 * @param session
	 * @param view
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping("/allCouponDownload")
	public List<MemberCouponVO> allCouponDownload(MemberCouponPO po,String deviceGb){
		Session session = FrontSessionUtil.getSession();
		String mbrGbCd = session.getMbrGbCd();
		Boolean isCanDown = StringUtil.equals(mbrGbCd,FrontConstants.MBR_FLOW_GB_10) || StringUtil.equals(mbrGbCd,FrontConstants.MBR_FLOW_GB_20) ;
		if(!isCanDown){
			throw new CustomException(ExceptionConstants.ERROR_CODE_LOGIN_REQUIRED_POP);
		}
		po.setMbrNo(session.getMbrNo());
		
		//기기 구분
		List<String> webMobileGbCdList = new ArrayList<String>();
		webMobileGbCdList.add(CommonConstants.WEB_MOBILE_GB_00);
		if(StringUtil.equals(deviceGb,FrontConstants.DEVICE_GB_30) || StringUtil.equals(deviceGb,FrontConstants.DEVICE_GB_20)){
			webMobileGbCdList.add(CommonConstants.WEB_MOBILE_GB_20);
		}else{
			webMobileGbCdList.add(CommonConstants.WEB_MOBILE_GB_10);
		}
		po.setWebMobileGbCds(webMobileGbCdList);

		return memberCouponService.insertMemberCouponAll(po);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-31-front
	 * - 파일명		: MyShopController.java
	 * - 작성일		: 2016. 3. 2.
	 * - 작성자		: 김재윤
	 * - 설명		: 내 쇼핑 정보 관리 - 쿠폰 받기
	 * </pre>
	 * @param model
	 * @param session
	 * @param view
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping("/couponDownload")
	public String couponDownload(MemberCouponPO po){
		String result = FrontConstants.CONTROLLER_RESULT_CODE_FAIL;
		Session session = FrontSessionUtil.getSession();
		String mbrGbCd = session.getMbrGbCd();
		Boolean isCanDown = StringUtil.equals(mbrGbCd,FrontConstants.MBR_FLOW_GB_10) || StringUtil.equals(mbrGbCd,FrontConstants.MBR_FLOW_GB_20) ;
		if(!isCanDown){
			throw new CustomException(ExceptionConstants.ERROR_CODE_LOGIN_REQUIRED_POP);
		}

		po.setMbrNo(session.getMbrNo());
		po.setIsuTpCd(FrontConstants.ISU_TP_20);
		try{
			memberCouponService.insertMemberCoupon(po);
			result = FrontConstants.CONTROLLER_RESULT_CODE_SUCCESS;
		}catch(CustomException e){
			result = message.getMessage("business.exception."+e.getExCode());
		}
		return result;
	}
	
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-31-front
	 * - 파일명		: front.web.view.mypage.controller
	 * - 작성일		: 2021. 04. 06.
	 * - 작성자		: JinHong
	 * - 설명		: 배송요청사항 include
	 * </pre>
	 * @param map
	 * @param session
	 * @param view
	 * @return
	 */
	@RequestMapping(value = "includeDlvrDemand")
	public String includeDlvrDemand(ModelMap map, MemberAddressSO so, Session session, ViewBase view, MemberAddressVO po, PopParam param) {
		

		if(so.getMbrDlvraNo() != null) {
			MemberAddressVO address = this.memberAddressService.getMemberAddress(so.getMbrDlvraNo());
			if(StringUtils.isNotEmpty(po.getGoodsRcvPstCd())) {
				address.setGoodsRcvPstCd(po.getGoodsRcvPstCd());
			}
			if(StringUtils.isNotEmpty(po.getGoodsRcvPstEtc())) {
				address.setGoodsRcvPstEtc(po.getGoodsRcvPstEtc());
			}
			if(StringUtils.isNotEmpty(po.getPblGateEntMtdCd())) {
				address.setPblGateEntMtdCd(po.getPblGateEntMtdCd());
			}
			if(StringUtils.isNotEmpty(po.getPblGatePswd())) {
				address.setPblGatePswd(po.getPblGatePswd());
			}
			if(StringUtils.isNotEmpty(po.getDlvrDemand())) {
				address.setDlvrDemand(po.getDlvrDemand());
			}
			map.put("address", address);
		}else {
			map.put("address", po);
		}
		
		List<CodeDetailVO> goodsRcvPstCdList = cacheService.listCodeCache(CommonConstants.GOODS_RCV_PST, null, null, null, null, null);
		
		map.put("goodsRcvPstCdList", goodsRcvPstCdList);
		
		List<CodeDetailVO> pblGateEntMtdCdList = cacheService.listCodeCache(CommonConstants.PBL_GATE_ENT_MTD, null, null, null, null, null);
		
		map.put("pblGateEntMtdCdList", pblGateEntMtdCdList);
		
		map.put("so", so);
		map.put("session", session);
		map.put("view", view);
		map.put("param", param);
		
		return TilesView.none(new String[] {"mypage", "service", "include", "includeDlvrDemand" });
	}
	
}