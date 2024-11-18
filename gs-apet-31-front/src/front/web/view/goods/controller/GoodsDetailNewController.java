package front.web.view.goods.controller;

import java.lang.reflect.InvocationTargetException;
import java.util.*;

import biz.app.display.model.*;
import biz.app.goods.model.*;
import biz.app.member.model.MemberIoAlarmPO;
import biz.app.member.model.MemberIoAlarmVO;
import biz.app.member.service.MemberIoAlarmService;
import biz.app.system.model.CodeDetailVO;
import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.beanutils.BeanUtilsBean;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang3.ArrayUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.*;

import biz.app.attribute.model.AttributePO;
import biz.app.attribute.model.AttributeVO;
import biz.app.attribute.model.AttributeValueVO;
import biz.app.contents.model.ApetContentsGoodsMapSO;
import biz.app.contents.model.VodVO;
import biz.app.delivery.model.DeliveryChargePolicySO;
import biz.app.delivery.model.DeliveryChargePolicyVO;
import biz.app.delivery.service.DeliveryChargePolicyService;
import biz.app.display.service.DisplayService;
import biz.app.display.service.SeoService;
import biz.app.goods.service.GoodsCommentService;
import biz.app.goods.service.GoodsCstrtPakService;
import biz.app.goods.service.GoodsDescService;
import biz.app.goods.service.GoodsDetailService;
import biz.app.goods.service.GoodsDtlInqrHistService;
import biz.app.goods.service.GoodsIconService;
import biz.app.goods.service.GoodsNotifyService;
import biz.app.goods.service.GoodsService;
import biz.app.goods.service.TwcProductService;
import biz.app.member.model.MemberCouponPO;
import biz.app.member.model.MemberGradeVO;
import biz.app.member.service.MemberAddressService;
import biz.app.member.service.MemberCouponService;
import biz.app.order.service.OrderDlvrAreaService;
import biz.app.promotion.model.CouponBaseVO;
import biz.app.promotion.model.ExhibitionVO;
import biz.app.tag.model.TagBaseVO;
import biz.app.tag.service.TagService;
import biz.common.service.CacheService;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import framework.common.util.DateUtil;
import framework.common.util.NhnShortUrlUtil;
import framework.common.util.StringUtil;
import framework.front.constants.FrontConstants;
import framework.front.model.Session;
import framework.front.util.FrontSessionUtil;
import front.web.config.constants.FrontWebConstants;
import front.web.config.tiles.TilesView;
import front.web.config.util.ImagePathUtil;
import front.web.config.view.ViewBase;
import lombok.extern.slf4j.Slf4j;

import javax.servlet.http.HttpServletRequest;

/**
 * <pre>
 * - 프로젝트명 : 31.front.web
 * - 패키지명   : front.web.view.goods.controller
 * - 파일명     : GoodsDetailNewController.java
 * - 작성일     : 2021. 03. 15.
 * - 작성자     : valfac
 * - 설명       :
 * </pre>
 */
@Slf4j
@Controller
@RequestMapping("goods")
public class GoodsDetailNewController {

	@Autowired private MessageSourceAccessor message;

	@Autowired private Properties webConfig;

	/* 상품, 카테고리 조회 */
	@Autowired private GoodsService goodsService;

	@Autowired private GoodsDetailService goodsDetailService;

	@Autowired private GoodsIconService goodsIconService;

	@Autowired private DeliveryChargePolicyService deliveryChargePolicyService;

	@Autowired private CacheService cacheService;

	@Autowired private MemberCouponService memberCouponService;

	@Autowired private MemberAddressService memberAddressService;

	@Autowired private TagService tagService;
	
	@Autowired private GoodsDtlInqrHistService goodsDtlInqrHistService;
	
	@Autowired private GoodsCommentService goodsCommentService;

	@Autowired private GoodsCstrtPakService goodsCstrtPakService;

	@Autowired private GoodsDescService goodsDescService;

	@Autowired private GoodsNotifyService goodsNotifyService;

	@Autowired private TwcProductService twcProductService;

	@Autowired private DisplayService displayService;
	
	@Autowired private SeoService seoService;

	@Autowired private OrderDlvrAreaService orderDlvrAreaService;

	@Autowired private MemberIoAlarmService memberIoAlarmService;

	@Autowired private NhnShortUrlUtil NhnShortUrlUtil;

	@Autowired private MessageSourceAccessor msg;

	/**
	 <pre>
	 * - 프로젝트명	: 31.front.web
	 * - 파일명		: GoodsController.java
	 * - 작성일		: 2021. 3. 12.
	 * - 작성자		: valfac
	 * - 설명		: 상품 상세 화면
	 * </pre>
	 * @param map
	 * @param goodsId
	 * @return
	 */
	@RequestMapping(value="{path:indexGoodsDetail|previewGoodsDetail|liveGoodsDetail}")
	public String goodsDetailView(@PathVariable String path, ModelMap map, Session session, ViewBase view, GoodsBaseSO goodsBaseSO ) {

		// view 펫샵 세팅
		view.setSeoSvcGbCd(FrontWebConstants.SEO_SVC_GB_CD_10);
		// 사이트 세팅
		goodsBaseSO.setStId(view.getStId());
		// 로그인 회원 세팅
		goodsBaseSO.setMbrNo(session.getMbrNo());
		// 웹/모바일 세팅
		String webMobileGbCd = view.getDeviceGb().equals(CommonConstants.DEVICE_GB_10) ? CommonConstants.WEB_MOBILE_GB_10: CommonConstants.WEB_MOBILE_GB_20;
		goodsBaseSO.setWebMobileGbCd(webMobileGbCd);
		// 회원 번호
		goodsBaseSO.setMbrNo(session.getMbrNo());
		// twc display 가능 카테고리 인지 확인 여부 
		goodsBaseSO.setTwcDispClsfNos(webConfig.getProperty("disp.corn.no.goods.twc").split(":"));
		// 어드민 접근 여부 체크
		if(StringUtils.equals("indexGoodsDetail", path)) {
			goodsBaseSO.setAdminNo(null);
		}
		goodsBaseSO.setAdminYn(null);

		/**
		 * CSR-1239 상품이 사은품으로 등록이 되어 있을 경우, 상품 상세 접근 막기
		 */
		String giftYn = goodsDetailService.getGoodsGiftYn(goodsBaseSO.getGoodsId());
		
		// 상품 기본
		GoodsBaseVO goodsBaseVO = goodsDetailService.getGoodsDetail(goodsBaseSO);
		
		if(StringUtils.equals(giftYn, CommonConstants.COMM_YN_Y) && StringUtils.equals(goodsBaseVO.getShowYn(), CommonConstants.COMM_YN_N)) {
			throw new CustomException(ExceptionConstants.ERROR_GOODS_DENIED);
		}

		//카테고리 메뉴
		//FIXME[상품, 이하정, 20210311] 소스 정리 필요, 일단 화면
		List<DisplayCategoryVO> displayCategories = goodsDetailService.listShopCategories();
		Set<DisplayCategoryVO> displayCategory1 = new LinkedHashSet<>();
		Set<DisplayCategoryVO> displayCategory2 = new LinkedHashSet<>();
		for(DisplayCategoryVO category : displayCategories) {
			DisplayCategoryVO category1 = new DisplayCategoryVO();
			category1.setDispClsfNo(category.getDispClsfNo1());
			category1.setDispClsfNm(category.getDispClsfNm1());

			displayCategory1.add(category1);

			DisplayCategoryVO category2 = new DisplayCategoryVO();
			category2.setDispClsfNo1(category.getDispClsfNo1());
			category2.setDispClsfNo(category.getDispClsfNo2());
			category2.setDispClsfNm(category.getDispClsfNm2());

			displayCategory2.add(category2);
		}

		
		// 상품 기본 정보 없을 경우 처리 필요...TODO
		if(ObjectUtils.isEmpty(goodsBaseVO)) {
			throw new CustomException(ExceptionConstants.ERROR_GOODS_DENIED);
		}

		// 상품 이미지 조회
		Map<String, Object> goodsImgMap = goodsService.getGoodsImg(goodsBaseSO.getGoodsId(), CommonConstants.IMG_TP_10);

		// 타임딜/재고임박 할인 정보
		List<GoodsPriceVO> goodsPrices = goodsDetailService.listGoodsPrices(goodsBaseSO.getGoodsId());

		// 기획전 정보
		List<ExhibitionVO> exhibitions = goodsDetailService.listGoodsExhibited(goodsBaseSO.getGoodsId(), goodsBaseSO.getWebMobileGbCd());

		// 할인 혜택
		MemberGradeVO memberGradeInfo = new MemberGradeVO();//goodsService.getMemberGradeInfo(session.getMbrNo());
		String mbrGrdCd = StringUtil.isNull(session.getMbrGrdCd()) ? CommonConstants.MBR_GRD_40 : session.getMbrGrdCd();
		CodeDetailVO codeVO = cacheService.getCodeCache(CommonConstants.MBR_GRD_CD, mbrGrdCd);
		memberGradeInfo.setGrdCd(codeVO.getDtlCd());
		memberGradeInfo.setGrdNm(codeVO.getDtlNm());
		memberGradeInfo.setStdOrdAmt(codeVO.getUsrDfn1Val());
		memberGradeInfo.setStdOrdCnt(codeVO.getUsrDfn2Val());
		memberGradeInfo.setSvmnRate(codeVO.getUsrDfn3Val());
		memberGradeInfo.setSvmnVldPrdCd(codeVO.getUsrDfn4Val());
		memberGradeInfo.setSvmnVldPrd(codeVO.getUsrDfn5Val());

		// 연관 태그
		List<TagBaseVO> tagList = tagService.listTagGoodsId(goodsBaseSO.getGoodsId());

		// 옵션 리스트
		goodsBaseSO.setGoodsCstrtTpCd(goodsBaseVO.getGoodsCstrtTpCd());
		List<GoodsBaseVO> goodsCstrtList = goodsDetailService.listGoodsCstrt(goodsBaseSO);

		if(FrontConstants.COMM_YN_Y.equals(goodsBaseSO.getAdminYn())) {
			//보안성 진단결과처리. 불필요한 코드 (비어있는 block문)
			log.debug("FrontConstants.COMM_YN_Y.equals(goodsBaseSO.getAdminYn())");
		} else {
			//상품 조회수 증가
			goodsService.updateGoodsHits(goodsBaseSO.getGoodsId());
		}

		if(CollectionUtils.isNotEmpty(goodsCstrtList)) {
			if(goodsBaseVO.getGoodsCstrtTpCd().equals(FrontConstants.GOODS_CSTRT_TP_ATTR) || goodsBaseVO.getGoodsCstrtTpCd().equals(FrontConstants.GOODS_CSTRT_TP_PAK) || goodsBaseVO.getGoodsCstrtTpCd().equals(FrontConstants.GOODS_CSTRT_TP_SET)){
				goodsBaseVO.setTotalSalePsbCd(goodsCstrtList.get(0).getTotalSalePsbCd());
			}else {
				goodsBaseVO.setTotalSalePsbCd(goodsBaseVO.getSalePsbCd());
			}
		}else {
			goodsBaseVO.setTotalSalePsbCd(goodsBaseVO.getSalePsbCd());
		}

		// 옵션 정보 조회(ITEM:단품 ATTR:옵션 SET:세트 PAK:묶음)
		ItemSO itemSO = new ItemSO();
		itemSO.setGoodsId(goodsBaseVO.getGoodsId());
		List<ItemVO> listItems = goodsService.listGoodsItems(itemSO);
		//첫번째 단품에 대한 정보 조회(조립비, 배송비 포함)
		if(goodsBaseVO.getGoodsCstrtTpCd().equals(FrontConstants.GOODS_CSTRT_TP_ITEM) || goodsBaseVO.getGoodsCstrtTpCd().equals(FrontConstants.GOODS_CSTRT_TP_SET)){
			ItemVO itemVO = listItems.stream().findFirst().orElse(new ItemVO());
			map.put("listItemSize", (listItems == null ? 0 : listItems.size()));
			map.put("listItems", itemVO);
		}else if(goodsBaseVO.getGoodsCstrtTpCd().equals(FrontConstants.GOODS_CSTRT_TP_ATTR)){
			List<AttributeVO> listAttr = goodsService.listGoodsItemsAttr(goodsBaseVO.getGoodsId(), CommonConstants.COMM_YN_Y, view.getSvcGbCd());
			map.put("listAttrs", listAttr);
		}else if(goodsBaseVO.getGoodsCstrtTpCd().equals(FrontConstants.GOODS_CSTRT_TP_PAK)){
			GoodsCstrtPakPO listPakSo = new GoodsCstrtPakPO();
			listPakSo.setGoodsId(goodsBaseVO.getGoodsId());
			listPakSo.setSoldOutYn("N");
			List<GoodsCstrtPakVO> listPak = goodsCstrtPakService.listPakGoodsCstrtPak(listPakSo);
			map.put("listPaks", listPak);
		}

		// SEO 정보
		SeoInfoSO seoSo = new SeoInfoSO();
		SeoInfoVO seoInfo = null;

		try{
			seoSo.setSeoSvcGbCd(FrontWebConstants.SEO_SVC_GB_CD_10);        // SEO 서비스 구분 코드
			seoSo.setSeoTpCd(FrontWebConstants.SEO_TP_20);                  // SEO 유형 코드
			seoSo.setSeoInfoNo(goodsBaseVO.getSeoInfoNo());                 // SEO 정보 번호

			seoInfo = seoService.getSeoInfoFO(seoSo, false);

			if(ObjectUtils.isEmpty(goodsBaseVO.getSeoInfoNo())) {
				seoInfo.setPageTtl(goodsBaseVO.getGoodsNm());
				seoInfo.setPageDscrt(goodsBaseVO.getGoodsNm());
				seoInfo.setOpenGraphImg(ImagePathUtil.imagePath(goodsImgMap.get("dlgtImgPath").toString(), FrontConstants.IMG_OPT_QRY_560));
			}
		} catch (Exception e){}

		map.putAll(goodsImgMap);   //상품 이미지
		map.addAttribute("dlgtImgSeq", goodsImgMap.get("dlgtImgSeq"));   //상품 이미지
		map.addAttribute("dlgtImgPath", goodsImgMap.get("dlgtImgPath"));   //상품 이미지
		map.addAttribute("view", view); // view
		map.addAttribute("svcGbCd", view.getSvcGbCd());
		map.addAttribute("session", session);
		map.addAttribute("goods", goodsBaseVO); //상품 기본 정보
		map.addAttribute("goodsPrices", goodsPrices); // 타임딜/재고임박 할인 정보
		map.addAttribute("exhibitions", exhibitions); // 기획전 정보
		map.addAttribute("memberGradeInfo", memberGradeInfo); // 할인혜택
		map.addAttribute("tagList", tagList);   //연관 태그
		map.addAttribute("seoInfo", seoInfo);   //SEO
		map.addAttribute("currentTime", DateUtil.getNowDateTime());
		
		//TODO 작업 필요
		map.addAttribute("displayCategory1", displayCategory1);
		map.addAttribute("displayCategory2", displayCategory2);
		map.addAttribute("displayCategories", displayCategories);
		
		map.addAttribute("callParam", goodsBaseSO.getCallParam());

		//묶음 상품
		map.addAttribute("goodsCstrtList", goodsCstrtList);   // 옵션 리스트

		return  TilesView.goods(new String[]{"goodsDetail"});
	}

	/**
	 * 상품 상세
	 * @param goodsBaseSO
	 * @param session
	 * @param view
	 * @param map
	 * @return
	 */
	@RequestMapping(value="getGoodsDetail")
	public String getGoodsDetail(GoodsBaseVO goodsBaseVO, ViewBase view, ModelMap map) {
		// 웹/모바일 세팅
		String webMobileGbCd = view.getDeviceGb().equals(CommonConstants.DEVICE_GB_10) ? CommonConstants.WEB_MOBILE_GB_10: CommonConstants.WEB_MOBILE_GB_20;

		// 옵션 리스트
		GoodsBaseSO goodsBaseSO = new GoodsBaseSO();
		goodsBaseSO.setGoodsId(goodsBaseVO.getGoodsId());
		goodsBaseSO.setStId(view.getStId());
		goodsBaseSO.setWebMobileGbCd(webMobileGbCd);
		goodsBaseSO.setGoodsCstrtTpCd(goodsBaseVO.getGoodsCstrtTpCd());
		List<GoodsBaseVO> goodsCstrtList = goodsDetailService.listGoodsCstrt(goodsBaseSO);

		map.addAttribute("goodsCstrtList", goodsCstrtList);

		if(StringUtils.equals(goodsBaseVO.getIgdtInfoLnkYn(), FrontConstants.COMM_YN_Y) && goodsBaseVO.getIsTwcCategory()) {
			String twcGoodsId = goodsBaseVO.getGoodsId();
			String twcCompGoodsId = goodsBaseVO.getCompGoodsId();

			if(CollectionUtils.isNotEmpty(goodsCstrtList)) {
				twcGoodsId = goodsCstrtList.get(0).getGoodsId();
				twcCompGoodsId = goodsCstrtList.get(0).getCompGoodsId();
			}

			TwcProductVO twcProductVO = twcProductService.getTwcProduct(twcGoodsId, twcCompGoodsId);

			if(!ObjectUtils.isEmpty(twcProductVO)) {
				TwcProductNutritionVO twcProductNutritionVO = twcProductService.getTwcProductNutrition(twcProductVO.getId());

				map.put("twcProductVO", twcProductVO); // 상품 성분 정보
				map.put("twcProductNutritionVO", twcProductNutritionVO); // TWC 성분 영양 정보
			}
		}

		// 상품 고시정보
		List<GoodsNotifyVO> goodsNotifyList = goodsNotifyService.listGoodsNotifyUsed(goodsBaseVO.getGoodsId());

		map.put("goodsNotifyList", goodsNotifyList);

		return TilesView.goods(new String[]{"includeNew", "includeGoodsDesc"});
	}

	/**
	 *
	 * @return
	 */
	@RequestMapping(value="getGoodsOrdpanDetail")
	public String getGoodsOrdpanDetail(GoodsBaseSO goodsBaseSO, Session session, ViewBase view, ModelMap map) {

		// 옵션 정보 조회(ITEM:단품 ATTR:옵션 SET:세트 PAK:묶음)
		ItemSO itemSO = new ItemSO();
		itemSO.setGoodsId(goodsBaseSO.getGoodsId());
		List<ItemVO> listItems = goodsService.listGoodsItems(itemSO);

		//첫번째 단품에 대한 정보 조회(조립비, 배송비 포함)
		if(goodsBaseSO.getGoodsCstrtTpCd().equals(FrontConstants.GOODS_CSTRT_TP_ITEM) || goodsBaseSO.getGoodsCstrtTpCd().equals(FrontConstants.GOODS_CSTRT_TP_SET)){
			ItemVO itemVO = listItems.stream().findFirst().orElse(new ItemVO());
			map.put("listItemSize", (listItems == null ? 0 : listItems.size()));
			map.put("listItems", itemVO);
		}else if(goodsBaseSO.getGoodsCstrtTpCd().equals(FrontConstants.GOODS_CSTRT_TP_ATTR)){
			List<AttributeVO> listAttr = goodsService.listGoodsItemsAttr(goodsBaseSO.getGoodsId(), CommonConstants.COMM_YN_Y, view.getSvcGbCd());
			map.put("listAttrs", listAttr);
		}else if(goodsBaseSO.getGoodsCstrtTpCd().equals(FrontConstants.GOODS_CSTRT_TP_PAK)){
			GoodsCstrtPakPO listPakSo = new GoodsCstrtPakPO();
			listPakSo.setGoodsId(goodsBaseSO.getGoodsId());
			listPakSo.setSoldOutYn("N");
			List<GoodsCstrtPakVO> listPak = goodsCstrtPakService.listPakGoodsCstrtPak(listPakSo);
			map.put("listPaks", listPak);
		}

		map.addAttribute("session", session);

		return TilesView.goods(new String[]{"includeNew", "includeGoodsOrdpanDetail"});
	}

	/**
	 * FIXME cstrtTotalSalePsbCd 체크
	 * 상품 상세 장바구니
	 * @return
	 */
	@RequestMapping(value="getGoodsOrdpanCartNavs")
	public String getGoodsOrdpanCartNavs(GoodsBaseVO goodsBaseVO, Session session, ViewBase view, ModelMap map) {

		// 옵션 리스트
		GoodsBaseSO goodsBaseSO = new GoodsBaseSO();
		goodsBaseSO.setGoodsId(goodsBaseVO.getGoodsId());
		goodsBaseSO.setGoodsCstrtTpCd(goodsBaseVO.getGoodsCstrtTpCd());
		List<GoodsBaseVO> goodsCstrtList = goodsDetailService.listGoodsCstrt(goodsBaseSO);

		if(CollectionUtils.isNotEmpty(goodsCstrtList)) {
			if(goodsBaseVO.getGoodsCstrtTpCd().equals(FrontConstants.GOODS_CSTRT_TP_ATTR) || goodsBaseVO.getGoodsCstrtTpCd().equals(FrontConstants.GOODS_CSTRT_TP_PAK)){
				goodsBaseVO.setTotalSalePsbCd(goodsCstrtList.get(0).getTotalSalePsbCd());
			}else {
				goodsBaseVO.setTotalSalePsbCd(goodsBaseVO.getSalePsbCd());
			}
		}else {
			goodsBaseVO.setTotalSalePsbCd(goodsBaseVO.getSalePsbCd());
		}

		map.put("goods", goodsBaseVO);

		return TilesView.goods(new String[]{"includeNew", "includeGoodsOrdpanCartNavs"});
	}

	/**
	 * 일치율
	 * @return
	 */
	@RequestMapping(value="getGoodsRate")
	public String getGoodsRate(GoodsBaseSO goodsBaseSO, Session session, ViewBase view, ModelMap map) {
		// 일치율
		try{
			// 사용자 관심상품 일치 RATE
			double recommendGoodsRate = goodsDetailService.getGoodsRecommendRate(view.getStId(), goodsBaseSO.getGoodsId(), session.getMbrNo(), FrontConstants.SEO_SVC_SHOP);
			//TODO 50%이상 & 소수점 없이 정수로 표출
			if(recommendGoodsRate > 49.0){
				map.put("recommendGoodsRate", recommendGoodsRate);
			}

		}catch(Exception e){
			log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
		}

		return TilesView.goods(new String[]{"includeNew", "includeGoodsRate"});
	}

	/**
	 * 사은품 목록 조회
	 * @return
	 */
	@RequestMapping(value="listGoodsGifts")
	public String listGoodsGifts(GoodsBaseSO goodsBaseSO, ModelMap map) {
		List<GoodsGiftVO> goodsGifts = goodsDetailService.listGoodsGifts(goodsBaseSO.getGoodsId(), goodsBaseSO.getGoodsCstrtTpCd());
		map.put("goodsGifts", goodsGifts);

		return TilesView.goods(new String[]{"includeNew", "includeGoodsGifts"});
	}

	/**
	 * TWC 성분 조회
	 * @param goodsId
	 * @param compGoodsId
	 * @param igdtInfoLnkYn
	 * @param isTwcCategory
	 * @param map
	 * @return
	 */
	@RequestMapping(value="getTwcProduct")
	public String getTwcProduct(String twcGoodsId, String twcCompGoodsId, ModelMap map) {
		TwcProductVO twcProductVO = twcProductService.getTwcProduct(twcGoodsId, twcCompGoodsId);

		if(!ObjectUtils.isEmpty(twcProductVO)) {
			TwcProductNutritionVO twcProductNutritionVO = twcProductService.getTwcProductNutrition(twcProductVO.getId());

			map.put("twcProductVO", twcProductVO); // 상품 성분 정보
			map.put("twcProductNutritionVO", twcProductNutritionVO); // TWC 성분 영양 정보
		}

		return TilesView.goods(new String[]{"includeNew", "includeGoodsProductDetail"});
	}

	/**
	 * 최근 본 상품 목록 조회
	 * @return
	 */
	@RequestMapping(value="listRecentGoods")
	public String listGoodsRecentList(GoodsBaseSO goodsBaseSO, Session session, ViewBase view, ModelMap map) {
		// 최근 본 상품
		GoodsDtlInqrHistSO dtlHistSO = new GoodsDtlInqrHistSO();
		dtlHistSO.setGoodsId(goodsBaseSO.getGoodsId());
		dtlHistSO.setMbrNo(session.getMbrNo());
		dtlHistSO.setWebMobileGbCd(view.getSvcGbCd());
		dtlHistSO.setLimit(0);
		dtlHistSO.setRows(goodsBaseSO.getRows());

		// 7일이전 데이터 삭제
		goodsDtlInqrHistService.deleteOldGoodsDtlInqrHist(dtlHistSO);
		
		// 최근 본 상품 조회
		List<GoodsBaseVO> recentGoods = goodsDtlInqrHistService.listGoodsDtlInqrHist(dtlHistSO);
		
		// 현재 상품 최근 본 상품 등록
		GoodsBaseVO goodsBaseVO = new GoodsBaseVO();
		try {
			BeanUtilsBean.getInstance().getConvertUtils().register( false, true, 0 );
			BeanUtils.copyProperties(goodsBaseVO, goodsBaseSO);
			// 등록
			goodsDtlInqrHistService.setRecentGoods(session.getMbrNo(), goodsBaseVO);
		} catch (IllegalAccessException | InvocationTargetException e) {
			log.error("listGoodsRecomdDetail Error : {}", e);
		} 
		
		map.addAttribute("recentGoods", recentGoods); // 최근 본 상품
		return TilesView.goods(new String[]{"includeNew", "includeGoodsRecentDetail"});
	}

	/*
	 * - 프로젝트명	: 31.front.web
	 * - 파일명		: GoodsDetailNewController.java
	 * - 작성일		: 2021. 08. 06.
	 * - 작성자		: valfac
	 * - 설명		: 최근본 상품 쿠키값 goodsId로 조회
	 * </pre>
	 * @param dtlHistSO
	 */
	@RequestMapping(value="getrecentGoodsLsit")
	public String getrecentGoodsLsit(GoodsDtlInqrHistSO dtlHistSO, ViewBase view, ModelMap map) {
		//최근본 상품
		dtlHistSO.setWebMobileGbCd(view.getSvcGbCd());
		dtlHistSO.setLimit(0);
		dtlHistSO.setCookieYn(CommonConstants.COMM_YN_Y);
		dtlHistSO.setRows(dtlHistSO.getRows());
		map.put("recentGoods", goodsDtlInqrHistService.listGoodsDtlInqrHist(dtlHistSO));
		return TilesView.goods(new String[]{"includeNew", "includeGoodsRecentDetail"});
	}
	
	/**
	 * 함께 많이 보는 상품 목록 조회
	 * @return
	 */
	@RequestMapping(value="listGoodsRecentDetail")
	public String listGoodsRecentDetail(GoodsBaseSO goodsBaseSO, Session session, ViewBase view, ModelMap map) {
		//ModelMap map = new ModelMap();

		// 웹/모바일 세팅
		String webMobileGbCd = view.getDeviceGb().equals(CommonConstants.DEVICE_GB_10) ? CommonConstants.WEB_MOBILE_GB_10: CommonConstants.WEB_MOBILE_GB_20;

		// 함께 많이 보는 상품 조회
		GoodsCstrtInfoSO goodsCstrtInfoSO = new GoodsCstrtInfoSO();
		goodsCstrtInfoSO.setGoodsId(goodsBaseSO.getGoodsId());
		goodsCstrtInfoSO.setWebMobileGbCd(webMobileGbCd);
		goodsCstrtInfoSO.setGoodsCstrtGbCd(FrontConstants.GOODS_CSTRT_GB_20);
		goodsCstrtInfoSO.setFrontYn(FrontConstants.COMM_YN_Y);
		if(session.getMbrNo() != null && session.getMbrNo() > 0){
			// 찜 리스트 조회 처리용
			goodsCstrtInfoSO.setMbrNo(session.getMbrNo());
		}
		List<GoodsCstrtInfoVO> goodsCstrtInfoList = goodsService.listGoodsCstrtInfo(goodsCstrtInfoSO);
		map.put("listGoodsCstrt", goodsCstrtInfoList);

		//return TilesView.goods(new String[]{"includeNew", "includeGoodsCstrtInfo"});
		return TilesView.goods(new String[]{"include", "includeGoodsRecentDetail"});
	}

	/**
	 * 상품 후기 평가 점수 조회
	 * @return
	 */
	@RequestMapping(value="getGoodsScore")
	public String getGoodsScore(GoodsBaseSO goodsBaseSO, ModelMap map) {
		//ModelMap map = new ModelMap();

		//상품 후기 평가 점수 조회
		GoodsCommentSO commentSO = new GoodsCommentSO();
		commentSO.setGoodsId(goodsBaseSO.getGoodsId());
		commentSO.setGoodsCstrtTpCd(goodsBaseSO.getGoodsCstrtTpCd());

		//전체 후기 수
		int commentTotalCnt = goodsCommentService.pageGoodsCommentCount(commentSO);
		map.put("commentTotalCnt", commentTotalCnt);
/*
		//일반 후기 수
		commentSO.setGoodsEstmTp(FrontConstants.GOODS_ESTM_TP_NOR);
		int norCommentCnt = goodsCommentService.pageGoodsCommentCount(commentSO);
		map.put("norCommentCnt", norCommentCnt);
*/
		if(StringUtils.equals(goodsBaseSO.getGoodsCstrtTpCd(), FrontConstants.GOODS_CSTRT_TP_PAK) ||
		StringUtils.equals(goodsBaseSO.getGoodsCstrtTpCd(), FrontConstants.GOODS_CSTRT_TP_ATTR)) {
			commentSO.setDlgtGoodsId(goodsBaseSO.getGoodsId());
		}
		//일반 후기가 5개 이상일 경우에만 구매 만족도 노출
		GoodsCommentVO commentVO = goodsCommentService.getGoodsCommentScore(commentSO);

		map.put("scoreList", commentVO);

		return TilesView.goods(new String[]{"includeNew", "includeGoodsScore"});
	}

	/**
	 * 상품 후기 평가 점수 조회
	 * @return
	 */
	@RequestMapping(value="getGoodsComment")
	public String getGoodsComment(GoodsBaseSO goodsBaseSO, ModelMap map) {
		//ModelMap map = new ModelMap();

		//상품 후기 평가 점수 조회
		GoodsCommentSO commentSO = new GoodsCommentSO();
		commentSO.setGoodsId(goodsBaseSO.getGoodsId());
		commentSO.setGoodsCstrtTpCd(goodsBaseSO.getGoodsCstrtTpCd());

		if(StringUtils.equals(goodsBaseSO.getGoodsCstrtTpCd(), FrontConstants.GOODS_CSTRT_TP_PAK) ||
				StringUtils.equals(goodsBaseSO.getGoodsCstrtTpCd(), FrontConstants.GOODS_CSTRT_TP_ATTR)) {
			commentSO.setDlgtGoodsId(goodsBaseSO.getGoodsId());
		}
		//일반 후기가 5개 이상일 경우에만 구매 만족도 노출
		GoodsCommentVO commentVO = goodsCommentService.getGoodsCommentScore(commentSO);

		map.put("scoreList", commentVO);
		map.put("estmList", commentVO.getGoodsEstmQstVOList());

		//상품 후기 정렬 옵션 조회
		if(goodsBaseSO.getGoodsCstrtTpCd().equals(FrontConstants.GOODS_CSTRT_TP_ATTR)||goodsBaseSO.getGoodsCstrtTpCd().equals(FrontConstants.GOODS_CSTRT_TP_PAK)) {
			List<GoodsBaseVO> commentCstrtList = goodsCstrtPakService.getCommentCstrtList(goodsBaseSO);
			map.put("commentCstrtList", commentCstrtList);
		}

		return TilesView.goods(new String[]{"includeNew", "includeGoodsCommentDetail"});
	}

	/**
	 * 사용자 맞춤 추천 상품 목록 조회
	 * @return
	 */
	@RequestMapping(value="listGoodsCustomDetail")
	public String listGoodsCustomDetail(GoodsBaseSO goodsBaseSO, Session session, ViewBase view, ModelMap map) {
		// START 사용자 맞춤 추천 상품
		GoodsRelatedSO goodsRelatedSO = new GoodsRelatedSO();
		goodsRelatedSO.setStId(view.getStId());
		goodsRelatedSO.setWebMobileGbCd(view.getDeviceGb());
		goodsRelatedSO.setGoodsId(goodsBaseSO.getGoodsId());
		if(session.getMbrNo() != null){
			goodsRelatedSO.setMbrNo(session.getMbrNo());
		}
		if(session.getPetNos() != null){
			String petNoStr = session.getPetNos().split(",")[0];
			goodsRelatedSO.setPetNo( Long.parseLong(petNoStr)>0 ? Long.parseLong(petNoStr) : 0L );
		}

		try{
			List<GoodsBaseVO> listRelated = goodsService.getGoodsRelatedWithSearch(goodsRelatedSO);
			map.put("listRelated", listRelated);
		}catch(Exception e){
			// 보안성 진단. 오류메시지를 통한 정보노출
			//e.printStackTrace();
			log.error("listRelated Error : {}", e);
		}

		//return TilesView.goods(new String[]{"includeNew", "includeGoodsRelated"});
		return TilesView.goods(new String[]{"include", "includeGoodsCustomDetail"});
	}

	/**
	 * SEO 정보
	 * @return
	 */
	@RequestMapping(value="getSeoInfo")
	@ResponseBody
	public ModelMap getSeoInfo(GoodsBaseSO goodsBaseSO, Session session, ViewBase view) {
		ModelMap map = new ModelMap();

		SeoInfoSO seoSo = new SeoInfoSO();
		SeoInfoVO seoInfo = null;

		try{
			seoSo.setSeoSvcGbCd(FrontWebConstants.SEO_SVC_GB_CD_10);    // SEO 서비스 구분 코드
			seoSo.setSeoTpCd(FrontWebConstants.SEO_TP_20);              // SEO 유형 코드
			//seoSo.setSeoInfoNo(seoSo.getSeoInfoNo());                 // SEO 정보 번호

			seoInfo = seoService.getSeoInfoFO(seoSo, false);

			if(ObjectUtils.isEmpty(seoSo.getSeoInfoNo())) {
				seoInfo.setPageTtl(goodsBaseSO.getGoodsNm());
				seoInfo.setPageDscrt(goodsBaseSO.getGoodsNm());
				//seoInfo.setOpenGraphImg(ImagePathUtil.imagePath(goodsImgMap.get("dlgtImgPath").toString(), FrontConstants.IMG_OPT_QRY_560));
			}
		} catch (Exception e){
			//fixme 에러 확인후 삭제
			//e.printStackTrace();
			log.error("getSeoInfoFO Error : {}", e);
		}

		map.put("seoInfo", seoInfo);

		return map;
	}

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-31-front
	* - 파일명	: GoodsDetailNewController.java
	* - 작성일	: 2021. 3. 15.
	* - 작성자 	: valfac
	* - 설명 		: 관련 영상 조회
	* </pre>
	*
	* @param goodsId
	* @return
	*/
	@RequestMapping(value="listContentsGoods")
	@ResponseBody
	public ModelMap listContentsGoods(ApetContentsGoodsMapSO apetContentsGoodsMapSO, Session session) {
		
		ModelMap map = new ModelMap();
		
		// 관련영상 목록 조회
		apetContentsGoodsMapSO.setRows(FrontConstants.PAGE_ROWS_10);
		
		List<VodVO> listGoodsContents = goodsDetailService.pageContentsGoods(apetContentsGoodsMapSO, session.getMbrNo(), 1l);

		map.addAttribute("listGoodsContents", listGoodsContents);
		map.addAttribute("contentsSO", apetContentsGoodsMapSO);
		
		return map;
		
	}

	/**
	 <pre>
	 * - 프로젝트명	: 31.front.web
	 * - 파일명		: GoodsController.java
	 * - 작성일		: 2021. 3. 11.
	 * - 작성자		: valfac
	 * - 설명		: 상품 쿠폰 정보
	 * </pre>
	 * @param map
	 * @param cpNo
	 * @return map
	 */
	@RequestMapping(value="getGoodsCoupon")
	@ResponseBody
	public ModelMap getGoodsCoupon(GoodsBaseSO goodsBaseSO, Session session, ViewBase view) {
		ModelMap map = new ModelMap();
		// 사이트 세팅
		goodsBaseSO.setStId(view.getStId());
		// 로그인 회원 세팅
		goodsBaseSO.setMbrNo(session.getMbrNo());
		// 웹/모바일 세팅
		String webMobileGbCd = view.getDeviceGb().equals(CommonConstants.DEVICE_GB_10) ? CommonConstants.WEB_MOBILE_GB_10: CommonConstants.WEB_MOBILE_GB_20;
		goodsBaseSO.setWebMobileGbCd(webMobileGbCd);

		if(StringUtils.isNotEmpty(goodsBaseSO.getGoodsCstrtTpCd())) {
			//옵션, 옵션묶음 쿠폰 받기
			List<GoodsBaseVO> goodsCstrtList = null;
			if(!CommonConstants.GOODS_CSTRT_TP_ITEM.equals(goodsBaseSO.getGoodsCstrtTpCd()) && !CommonConstants.GOODS_CSTRT_TP_SET.equals(goodsBaseSO.getGoodsCstrtTpCd())) {
				goodsCstrtList = goodsDetailService.listGoodsCstrt(goodsBaseSO);
				String[] goodsIds = goodsCstrtList.stream().map(GoodsBaseVO::getGoodsId).toArray(String[]::new);
				goodsBaseSO.setGoodsId(null);
				goodsBaseSO.setGoodsIds(ArrayUtils.addAll(new String[]{goodsBaseSO.getGoodsId()}, goodsIds));
			} else {

			}
		}

		List<CouponBaseVO> goodsCoupon = goodsDetailService.listGoodsCoupon(goodsBaseSO);
		map.addAttribute("goodsCoupon", goodsCoupon);

		return map;
	}

	@RequestMapping(value="downloadGoodsCouponAll", method = RequestMethod.POST)
	@ResponseBody
	public ModelMap downloadGoodsCouponAll(@RequestBody List<Long> cpNos) {

		ModelMap map = new ModelMap();
		List<Long> successList = new ArrayList<>();
		int result = 0;

		Session session = FrontSessionUtil.getSession();
		String mbrGbCd = session.getMbrGbCd();

		for(Long cpNo : cpNos) {
			Boolean isCanDown = StringUtil.equals(mbrGbCd,FrontConstants.MBR_FLOW_GB_10) || StringUtil.equals(mbrGbCd,FrontConstants.MBR_FLOW_GB_20) ;

			if(isCanDown) {
				try {
					MemberCouponPO po = new MemberCouponPO();
					po.setMbrNo(session.getMbrNo());
					po.setCpNo(cpNo);
					po.setIsuTpCd(FrontConstants.ISU_TP_20);

					Long mbrCpNo = memberCouponService.insertMemberCoupon(po);
					//정상적으로 다운받았을 경우
					if(mbrCpNo > 0) {
						//성공 처리
						result ++;
						
						//성공한 쿠폰번호 담기
						successList.add(cpNo);
						
					} else {
						//다운못받음
					}
				} catch (Exception e) {
					log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
				}
			} else {
				//map.addAttribute("result", "fail");
			}
		}

		map.addAttribute("result", result);
		map.addAttribute("successList", successList);

		return map;
	}

	/**
	 <pre>
	 * - 프로젝트명	: 31.front.web
	 * - 파일명		: GoodsController.java
	 * - 작성일		: 2021. 3. 14.
	 * - 작성자		: valfac
	 * - 설명		: 상품 쿠폰 다운로드
	 * </pre>
	 * @param map
	 * @param cpNo
	 * @return map
	 */
	@RequestMapping(value="downloadGoodsCoupon", method = RequestMethod.POST)
	@ResponseBody
	public ModelMap downloadGoodsCoupon(Long cpNo) {
		log.debug("cpNo : {}", cpNo);

		ModelMap map = new ModelMap();
		int result = 0;
		String message = "";

		Session session = FrontSessionUtil.getSession();
		String mbrGbCd = session.getMbrGbCd();

		Boolean isCanDown = StringUtil.equals(mbrGbCd,FrontConstants.MBR_FLOW_GB_10) || StringUtil.equals(mbrGbCd,FrontConstants.MBR_FLOW_GB_20) ;

		if(isCanDown) {
			try {
				MemberCouponPO po = new MemberCouponPO();
				po.setMbrNo(session.getMbrNo());
				po.setCpNo(cpNo);
				po.setIsuTpCd(FrontConstants.ISU_TP_20);

				Long mbrCpNo = memberCouponService.insertMemberCoupon(po);
				//정상적으로 다운받았을 경우
				if(mbrCpNo > 0) {
					result ++;
				}
			} catch (CustomException e) {
				message = msg.getMessage("business.exception."+e.getExCode());

			}
		} else {
			//map.addAttribute("result", "fail");
		}

		map.addAttribute("result", result);
		map.addAttribute("message", message);

		return map;

	}

	/**
	 * 업체 배송 정보 조회
	 * @param goodsBaseSO
	 * @return
	 */
	@RequestMapping(value="getGoodsDeliveryInfo", method = RequestMethod.POST)
	@ResponseBody
	public ModelMap getGoodsDeliveryInfo(GoodsBaseSO goodsBaseSO) {
		ModelMap map = new ModelMap();

		// 업체 배송 정보
		DeliveryChargePolicySO dcpso = new DeliveryChargePolicySO();
		dcpso.setCompNo(goodsBaseSO.getCompNo());
		dcpso.setDlvrcPlcNo(goodsBaseSO.getDlvrcPlcNo());
		DeliveryChargePolicyVO deliveryChargePolicy = goodsDetailService.getDeliveryChargePolicy(dcpso);

		map.put("deliveryChargePolicy", deliveryChargePolicy);

		return map;
	}

	/**
	 <pre>
	 * - 프로젝트명	: 31.front.web
	 * - 파일명		: GoodsController.java
	 * - 작성일		: 2021. 3. 16.
	 * - 작성자		: valfac
	 * - 설명		: 상품 상세
	 * </pre>
	 * @param map
	 * @param cpNo
	 * @return map
	 */
	@RequestMapping(value="getGoodsDesc", method = RequestMethod.POST)
	@ResponseBody
	public ModelMap getGoodsDesc(GoodsBaseSO goodsBaseSO) {
		ModelMap map = new ModelMap();
		Session session = FrontSessionUtil.getSession();
		Long mbrNo = session.getMbrNo();

		// 상품 상세
		GoodsDescVO goodsDesc = goodsService.getGoodsDescAll(goodsBaseSO.getGoodsId());

		// 상품 공통 상세
		Long dispCornNo = FrontConstants.PETSHOP_GOODS_BANNER_DISP_CLSF_NO;
		List<DisplayBannerVO> cornList = goodsDetailService.listDisplayBannerContents(dispCornNo);

		map.addAttribute("bannerContent", cornList); //상품 공통 상세
		map.addAttribute("goodsDesc", goodsDesc); //상품 상세

		return map;
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명		: GoodsController.java
	* - 작성일		: 2016. 4. 7.
	* - 작성자		: snw
	* - 설명		: 옵션상품 목록조회 
	* </pre>
	* @param map
	* @param view
	* @param goodsId
	* @return
	* @throws Exception
	*/
	@RequestMapping(value="getOptionGoodsList")
	public String getOptionGoodsList(ModelMap map, ViewBase view, Session session, GoodsCstrtPakPO so){

		List<GoodsCstrtPakVO> listOptionGoodsCstrtPak = goodsCstrtPakService.listOptionGoodsCstrtPak(so);

		map.put("listOptionGoodsCstrtPak", listOptionGoodsCstrtPak);
		map.put("so", so);
		map.put("view", view);
		map.put("session", session);
		
		return  TilesView.none(new String[]{"goods", "include", "includeOptionGoodsList"});
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명		: GoodsController.java
	* - 작성일		: 2016. 4. 7.
	* - 작성자		: snw
	* - 설명		: 옵션상품 목록조회 
	* </pre>
	* @param map
	* @param view
	* @param goodsId
	* @return
	* @throws Exception
	*/
	@RequestMapping(value="getPakGoodsList")
	public String getPakGoodsList(ModelMap map, ViewBase view, Session session, GoodsCstrtPakPO so){

		List<GoodsCstrtPakVO> listGoodsCstrtPak = goodsCstrtPakService.listPakGoodsCstrtPak(so);

		map.put("listGoodsCstrtPak", listGoodsCstrtPak);
		map.put("so", so);
		map.put("view", view);
		map.put("session", session);
		
		return  TilesView.none(new String[]{"goods", "include", "includePakGoodsList"});
	}
	/**
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명		: GoodsController.java
	* - 작성일		: 2016. 4. 7.
	* - 작성자		: snw
	* - 설명		: 옵션 목록조회 
	* </pre>
	* @param map
	* @param view
	* @param goodsId
	* @return
	* @throws Exception
	*/
	@RequestMapping(value="getOptionSetList")
	public String getOptionSetList(ModelMap map, ViewBase view, Session session, AttributePO so){

		so.setStId(Long.valueOf(this.webConfig.getProperty("site.id")));
		so.setWebMobileGbCd(view.getSvcGbCd());
		
		List<AttributeValueVO> listAttrSel = goodsService.listGoodsItemsAttrSel(so);
		
		map.put("listAttrsSel", listAttrSel);
		map.put("so", so);
		map.put("view", view);
		map.put("session", session);
		
		return  TilesView.none(new String[]{"goods", "include", "includeOptionSet"});
	}

	/**
	 * 공유하기 버튼 클릭시 url 생성
	 * @param goodsId
	 * @param view
	 * @return
	 */
	@RequestMapping(value="getGoodsShortUrl")
	@ResponseBody
	public String getGoodsShortUrl(String goodsId, ViewBase view) {
		String shortUrl = null;
		try {
			shortUrl = NhnShortUrlUtil.getUrl(view.getStDomain()+"/goods/goodsDetailShare?goodsId="+goodsId);
		} catch (Exception e) {
			log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
		}

		return shortUrl;
	}

	@RequestMapping(value = "goodsDetailShare")
	public String petLogShare(ModelMap map, Session session, ViewBase view, 
			@RequestParam(value="goodsId",required=false)String goodsId) {
		String title = "";
		String imgPath = "";
		String desc = "";
		String orgPath = "";
		GoodsBaseSO so = new GoodsBaseSO();
		so.setGoodsId(goodsId);
		
		GoodsBaseVO vo = goodsDetailService.getGoodsShareInfo(so);
		
		if(!StringUtil.isEmpty(vo)) {
			title = vo.getGoodsNm();
			desc = vo.getGoodsNm();
			
			orgPath = vo.getImgPath();
			
			if(orgPath.lastIndexOf("cdn.ntruss.com") != -1) {
				imgPath = orgPath;
			}else {
				imgPath = ImagePathUtil.imagePath(orgPath, FrontConstants.IMG_OPT_QRY_560);
			}
		}
		
		map.put("img", imgPath);
		map.put("desc", desc);
		map.put("title", title);
		map.put("goodsId", goodsId);
		
		map.put("pageGb", "goodsDetail");
		
		SeoInfoSO seoSo = new SeoInfoSO();
		seoSo.setSeoSvcGbCd(FrontWebConstants.SEO_SVC_GB_CD_20);	// SEO 서비스 구분 코드
		seoSo.setSeoTpCd(FrontWebConstants.SEO_TP_10);				// SEO 유형 코드
		SeoInfoVO seoInfo = seoService.getSeoInfoFO(seoSo, false);
		if(seoInfo != null) {
			map.put("site_name", seoInfo.getPageTtl());
		}else {
			map.put("site_name", "");
		}
		
		return TilesView.none(new String[]{"common", "common", "indexShareView"});
	}

	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 34.front.brand.mobile
	 * - 파일명		: GoodsDetailController.java
	 * - 작성일		: 2021. 2. 26.
	 * - 작성자		: valueFactory
	 * - 설명		: 입고 알림 등록.
	 * </pre>
	 * @param po
	 * @param session
	 * @param view
	 * @param request
	 * @return
	 */
	@RequestMapping(value="addIoAlarm")
	@ResponseBody
	public ModelMap addIoAlarm(MemberIoAlarmPO po, Session session, ViewBase view, HttpServletRequest request){
		ModelMap map = new ModelMap();

		String message = "added";
		if(session.getMbrNo().equals(CommonConstants.NO_MEMBER_NO)) {
			message = "login";
		}else{
			String goodsId = po.getGoodsId();
			if(org.apache.commons.lang3.StringUtils.isNotEmpty(goodsId)) {
				String[] goodsIds = goodsId.split(":");
				po.setGoodsId(goodsIds[0]);
				if(goodsIds.length>1) {
					po.setPakGoodsId(goodsIds[1]);
				}
			}
			po.setMbrNo(session.getMbrNo());
			po.setSysRegrNo(session.getMbrNo());

			GoodsBaseVO goodsBaseVO = this.goodsService.getGoodsBase(po.getGoodsId());
			if(CommonConstants.COMM_YN_N.contentEquals(goodsBaseVO.getIoAlmYn())) {
				message = "changed";
			}else{
				po.setDelYn(CommonConstants.COMM_YN_N);
				po.setSysDelYn(CommonConstants.COMM_YN_N);
				List<MemberIoAlarmVO> alarmList = memberIoAlarmService.getIoAlarm(po);
				if(alarmList == null || alarmList.isEmpty()) {
					int goodsIoAlmNo = memberIoAlarmService.insertIoAlarm(po);
					if(goodsIoAlmNo > 0){
						message = "add";	// 알림등록
					}else{
						log.debug("addIoAlarm fail");
						message = "fail";	// 알림등록
					}
				}else{
					// 이미 알림 등록된 상태
					MemberIoAlarmVO alarmVO = alarmList.stream().findFirst().orElse(new MemberIoAlarmVO());
					map.put("alarmVO", alarmVO);
					// alarmVO.getSysDelDtm()
					map.put("alarmSysRegDtm", DateUtil.getTimestampToString(alarmVO.getSysRegDtm(), "yyyy-MM-dd HH:mm"));
					log.debug("addIoAlarm added : {}", alarmVO);
				}
			}
		}

		map.put("message", message);
		map.put("session", session);
		map.put("view", view);

		return  map;
	}

/*<pre>
* - 프로젝트명	: 31.front.web
* - 파일명		: GoodsDetailController.java
* - 작성일		: 2021. 9. 23.
* - 작성자		: kjh02
* - 설명		:  재고수량 확인
* @param po
* </pre>*/
	@RequestMapping(value="getStkQty")
	@ResponseBody
	public ModelMap getStkQty(ItemPO po) {
		ModelMap map = new ModelMap();
		int stkQty = goodsService.getWebStkQty(po);
		map.put("stkQty",stkQty);
		return map;
		
	}


}