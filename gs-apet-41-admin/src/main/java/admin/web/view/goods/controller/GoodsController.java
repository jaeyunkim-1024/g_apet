package admin.web.view.goods.controller;


import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import biz.app.goods.service.*;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import admin.web.config.grid.GridResponse;
import admin.web.config.view.View;
import biz.app.attribute.model.AttributePO;
import biz.app.attribute.model.AttributeSO;
import biz.app.attribute.model.AttributeVO;
import biz.app.attribute.model.AttributeValueVO;
import biz.app.attribute.service.AttributeService;
import biz.app.brand.model.CompanyBrandVO;
import biz.app.company.model.CompanyBaseVO;
import biz.app.company.model.CompanyCclVO;
import biz.app.company.model.CompanySO;
import biz.app.company.service.CompanyService;
import biz.app.contents.model.ApetContentsGoodsMapSO;
import biz.app.contents.model.ApetContentsGoodsMapVO;
import biz.app.delivery.model.DeliveryChargePolicyVO;
import biz.app.display.model.DisplayCategoryVO;
import biz.app.display.model.DisplayGoodsVO;
import biz.app.goods.model.GoodsBaseHistSO;
import biz.app.goods.model.GoodsBaseHistVO;
import biz.app.goods.model.GoodsBasePO;
import biz.app.goods.model.GoodsBaseSO;
import biz.app.goods.model.GoodsBaseVO;
import biz.app.goods.model.GoodsCautionVO;
import biz.app.goods.model.GoodsCstrtInfoPO;
import biz.app.goods.model.GoodsCstrtInfoSO;
import biz.app.goods.model.GoodsCstrtInfoVO;
import biz.app.goods.model.GoodsDescCommSO;
import biz.app.goods.model.GoodsDescPO;
import biz.app.goods.model.GoodsDescVO;
import biz.app.goods.model.GoodsEstmQstCtgMapSO;
import biz.app.goods.model.GoodsEstmQstVO;
import biz.app.goods.model.GoodsIconPO;
import biz.app.goods.model.GoodsIconVO;
import biz.app.goods.model.GoodsImgPO;
import biz.app.goods.model.GoodsImgSO;
import biz.app.goods.model.GoodsImgVO;
import biz.app.goods.model.GoodsNaverEpInfoVO;
import biz.app.goods.model.GoodsPO;
import biz.app.goods.model.GoodsPricePO;
import biz.app.goods.model.GoodsPriceSO;
import biz.app.goods.model.GoodsPriceVO;
import biz.app.goods.model.GoodsTagMapVO;
import biz.app.goods.model.ItemHistSO;
import biz.app.goods.model.ItemHistVO;
import biz.app.goods.model.ItemSO;
import biz.app.goods.model.ItemVO;
import biz.app.goods.model.NotifyInfoVO;
import biz.app.goods.model.NotifyItemSO;
import biz.app.goods.model.NotifyItemVO;
import biz.app.goods.model.StGoodsMapPO;
import biz.app.goods.model.StGoodsMapSO;
import biz.app.goods.model.StGoodsMapVO;
import biz.app.goods.model.TwcProductNutritionVO;
import biz.app.goods.model.TwcProductSO;
import biz.app.goods.model.TwcProductVO;
import biz.app.st.model.StStdInfoSO;
import biz.app.st.model.StStdInfoVO;
import biz.app.st.service.StService;
import biz.app.system.model.CodeDetailVO;
import biz.app.tag.model.TagBaseSO;
import biz.app.tag.service.TagService;
import biz.common.service.BizService;
import biz.common.service.CacheService;
import framework.admin.constants.AdminConstants;
import framework.admin.model.Session;
import framework.admin.util.AdminSessionUtil;
import framework.admin.util.JsonUtil;
import framework.admin.util.LogUtil;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import framework.common.model.CompareBeanPO;
import framework.common.model.ExcelViewParam;
import framework.common.util.BeanCompareUtil;
import framework.common.util.DateUtil;
import framework.common.util.StringUtil;
import framework.common.util.image.ImageType;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class GoodsController {

	@Autowired	private CacheService cacheService;

	// 상품 관리
	@Autowired	private GoodsService goodsService;

	@Autowired	private StService stService;

	// 단품 관리
	@Autowired	private ItemService itemService;

	// 상품 주의사항
	@Autowired	private GoodsCautionService goodsCautionService;

	// 상품 평가 항목
	@Autowired	private GoodsEstmService goodsEstmService;
	
	@Autowired	private BizService bizService;

	@Autowired	private AttributeService attributeService;
	
	@Autowired	private GoodsIconService goodsIconService;
	
	@Autowired	private GoodsTagMapService goodsTagMapService;

	@Autowired	private GoodsDescCommService goodsDescCommService;
	
	@Autowired	private GoodsPriceService goodsPriceService;
	
	@Autowired	private GoodsNaverEpInfoService goodsNaverEpInfoService;
	
	@Autowired	private TwcProductService twcProductService;

	@Autowired	private TagService tagService;

	@Autowired	private CompanyService companyService;

	@Autowired private Properties bizConfig;

	@Autowired private GoodsCommentService goodsCommentService;


	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: GoodsController.java
	 * - 작성일		: 2016. 4. 7.
	 * - 작성자		: valueFactory
	 * - 설명			: 상품 등록 VIEW
	 * </pre>
	 *
	 * @param model
	 * @return
	 */
	@RequestMapping( "/goods/{goodsCstrtTpCd}/goodsInsertView.do" )
	public String goodsInsertView(Model model, @PathVariable String goodsCstrtTpCd) {
		
		// 상품 유형
		model.addAttribute("goodsCstrtTpCd", goodsCstrtTpCd );
		
		// 품목군 코드 조회
		List<NotifyInfoVO> notifyInfoVOList = goodsService.listNotifyInfo();
		// 품목군 아이템 조회
		NotifyItemSO notifyItemSO = new NotifyItemSO();
		if(CollectionUtils.isNotEmpty(notifyInfoVOList)) {
			notifyItemSO.setNtfId(notifyInfoVOList.get(0).getNtfId());
			List<NotifyItemVO> notifyItemVOList = goodsService.listNotifyItem(notifyItemSO);
			model.addAttribute("notifyItem", notifyItemVOList );
		}

		model.addAttribute("notifyInfo", notifyInfoVOList );
		
		Session session = AdminSessionUtil.getSession();

		StStdInfoSO stStdInfoSO = new StStdInfoSO();

		if(!AdminConstants.USR_GRP_10.equals(session.getUsrGrpCd())){
			/*
			 * 상품등록 화면에서 수수료 정보 사용방법을 변경하였으므로 주석처리 함
			CompanyCclVO comCclVO = goodsService.getCompCcl(session.getCompNo());
			if (comCclVO == null) {
				// 조회가 되지 않은 경우 기본 값으로 설정
				comCclVO = new CompanyCclVO();
				comCclVO.setCmsRate(AdminConstants.CMS_DEFALUT_RATE);
			}

			model.addAttribute("cclPlc", comCclVO );
			*/

			// 배송 정책
			List<DeliveryChargePolicyVO> deliveryChargePolicyVOList = goodsService.listCompDlvrcPlc(session.getCompNo());

			// 배송 정책
			model.addAttribute("dlvrPlcList", deliveryChargePolicyVOList);

			// 업체사용자일 때 업체번호를 항상 조회조건에 사용하도록 수정함.
			if (StringUtils.equals(CommonConstants.USR_GRP_20, AdminSessionUtil.getSession().getUsrGrpCd())) {

				model.addAttribute("loginCompNo", session.getCompNo());
				stStdInfoSO.setCompNo(session.getCompNo());
			}
		}

		List<StStdInfoVO> siteList = stService.getStList(stStdInfoSO);
		model.addAttribute("siteList",siteList);
		
		// 아이콘 목록
		List<CodeDetailVO> limitedIconCodeList = cacheService.listCodeCache(AdminConstants.GOODS_ICON, true, CommonConstants.USE_YN_Y, null, null, null, null) ;
		List<CodeDetailVO> unlimitedIconCodeList = cacheService.listCodeCache(AdminConstants.GOODS_ICON, true, CommonConstants.USE_YN_N, CommonConstants.USE_YN_N, null, null, null) ;
		
		model.addAttribute("limitedIconCodeList", limitedIconCodeList);
		model.addAttribute("unlimitedIconCodeList", unlimitedIconCodeList);
		
		List<CodeDetailVO> originList = cacheService.listCodeCache(AdminConstants.ORIGIN_CD, true, null, null, null, null, null) ;
		model.addAttribute("originList", originList);

		return "/goods/goodsInsertView";
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: GoodsController.java
	 * - 작성일		: 2016. 4. 11.
	 * - 작성자		: valueFactory
	 * - 설명			: 단품 옵션 Sequence 조회
	 * </pre>
	 *
	 * @return
	 */
	@RequestMapping("/goods/getAttributeSeq.do")
	public String getAttributeSeq(Model model,
			@RequestParam(value = "seqId", required = true) String seqId) {

		if (log.isDebugEnabled()) {
			log.debug("==================================================");
			log.debug("= {}", "getAttributeSeq");
			log.debug("seqId : {}", seqId);
			log.debug("==================================================");
		}

		Long seqNo = bizService.getSequence(seqId);
		model.addAttribute("seqNo", seqNo);

		return View.jsonView();
	}
	
	/**
	* <pre>
	* - 프로젝트명	: gs-apet-41-admin
	* - 파일명	: GoodsController.java
	* - 작성일	: 2021. 1. 6.
	* - 작성자 	: valfac
	* - 설명 		: 상품 내용 중복 체크 
	* </pre>
	*
	* @param model
	* @param goodsDescCommSO
	* @return
	*/
	@RequestMapping("/goods/goodsDescCommCheck.do")
	public String goodsDescCommCheck(Model model, GoodsDescCommSO goodsDescCommSO) {
		
		int result = goodsDescCommService.checkDescComm(goodsDescCommSO);
		
		model.addAttribute("result", result);
		
		return View.jsonView();
	}
	

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: GoodsController.java
	 * - 작성일		: 2016. 4. 14.
	 * - 작성자		: valueFactory
	 * - 설명			: 상품 등록
	 * </pre>
	 *
	 * @param model
	 * @param goodsBaseStr
	 * @return
	 */
	@RequestMapping(value = "/goods/goodsInsert.do")
	public String goodsInsert(
			Model model,
			@RequestParam("goodsBasePO") String goodsBaseStr,
			@RequestParam(value = "goodsPricePO", required = false) String goodsPriceStr,
			@RequestParam(value = "goodsNaverEpInfoPO", required = false) String goodsNaverEpInfoStr,
			@RequestParam(value = "attributePO", required = false) String attributeStr,
			@RequestParam(value = "itemPO", required = false) String itemStr,
			@RequestParam(value = "optGrpPO", required = false) String optGrpStr,
			@RequestParam(value = "goodsNotifyPO", required = false) String goodsNotyfyStr,
			@RequestParam(value = "goodsCstrtInfoPO", required = false) String goodsCstrtInfoStr,
			@RequestParam(value = "displayGoodsPO", required = false) String displayGoodsPOStr,
			@RequestParam(value = "filtAttrMapPO", required = false) String filtAttrMapPOStr,
			@RequestParam(value = "goodsIconPO", required = false) String goodsIconPOStr,
			@RequestParam(value = "goodsTagMapPO", required = false) String goodsTagMapPOStr,
			@RequestParam(value = "goodsImgPO", required = false) String goodsImgStr,
			//@RequestParam(value = "goodsDescPO", required = false) String goodsDescStr,
			@RequestParam(value = "goodsCautionPO", required = false) String goodsCautionStr,
			@RequestParam(value = "stGoodsMapPO", required = false) String stGoodsMapStr, GoodsDescPO goodsDescPO) {

		GoodsPO goodsPO = new GoodsPO();
		
		// 상품 데이터 변환
		goodsPO = goodsService.setDataToGoodsPO(goodsBaseStr, goodsPriceStr, attributeStr, itemStr, goodsNotyfyStr, goodsCstrtInfoStr
				, displayGoodsPOStr, filtAttrMapPOStr, goodsIconPOStr, goodsTagMapPOStr, goodsImgStr, goodsCautionStr, stGoodsMapStr, goodsDescPO, optGrpStr, goodsNaverEpInfoStr);

		// 상품 등록
		GoodsBaseVO resultGoodsBaseVO = goodsService.insertGoods(goodsPO, attributeStr, true);
		
		model.addAttribute("result", resultGoodsBaseVO);

		return View.jsonView();
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: GoodsController.java
	 * - 작성일		: 2016. 4. 20.
	 * - 작성자		: valueFactory
	 * - 설명			:
	 * </pre>
	 *
	 * @param model
	 * @param notifyItemSO
	 * @return
	 */
	@RequestMapping(value = "/goods/notifyItemView.do")
	public String notifyItemView(Model model, NotifyItemSO notifyItemSO) {

		List<NotifyItemVO> notifyItemVOList = goodsService
				.listNotifyItem(notifyItemSO);
		model.addAttribute("notifyItem", notifyItemVOList);

		return "/goods/include/notifyItemView";
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: GoodsController.java
	 * - 작성일		: 2016. 4. 25.
	 * - 작성자		: valueFactory
	 * - 설명			: 공급업체 배송정책 조회
	 * </pre>
	 *
	 * @param model
	 * @param so
	 * @return
	 */
	@RequestMapping("/goods/compPlcList.do")
	public String compPlcList(Model model, GoodsBaseSO so) {

		if (log.isDebugEnabled()) {
			log.debug("==================================================");
			log.debug("= {}", "compPlcList");
			log.debug("==================================================");
			LogUtil.log(so);
		}

		Long compNo = so.getCompNo();
		// 배송 정책
		List<DeliveryChargePolicyVO> deliveryChargePolicyVOList = null;
		deliveryChargePolicyVOList = goodsService.listCompDlvrcPlc(compNo);
		// 수수료 정책
		CompanyCclVO comCclVO = null;
		//CompanyCclVO comCclVO = goodsService.getCompCcl(compNo);

		/* if (comCclVO == null) { */
			// 조회가 되지 않은 경우 기본 값으로 설정
			comCclVO = new CompanyCclVO();
			comCclVO.setCmsRate(AdminConstants.CMS_DEFALUT_RATE);
		/* } */

		// 업체가 속한 사이트 목록 가져오기 20170118  hjko 추가
		StStdInfoSO stso = new StStdInfoSO();
		stso.setCompNo(compNo);
		List<StStdInfoVO> stIdList = stService.getStList(stso);

		// 스타일 노출 관련.......
		//업체와 연결된 사이트 목록 가져오기
		StStdInfoSO ststdso = new StStdInfoSO();
		ststdso.setCompNo(compNo);
		List<StStdInfoVO> compStList =  stService.getStList(ststdso);
		log.debug("compStList >>"+compStList );
		model.addAttribute("compStList", compStList);

		// 업체가 가지고 있는 업체 브랜드 목록 가져오기 20170201. hjko 추가
		List<CompanyBrandVO> companyBrandList = goodsService.listCompanyBrand(compNo);

		model.addAttribute("companyBrandList", companyBrandList);

		model.addAttribute("dlvrPlcList", deliveryChargePolicyVOList);
		model.addAttribute("cclPlc", comCclVO);
		model.addAttribute("stIdList", stIdList);

		return View.jsonView();

	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: GoodsController.java
	 * - 작성일		: 2016. 4. 27.
	 * - 작성자		: valueFactory
	 * - 설명			: 상품 조회 팝업
	 * </pre>
	 *
	 * @param model
	 * @param so
	 * @return
	 */
	@RequestMapping("/goods/goodsSearchLayerView.do")
	public String goodsSearchLayerView(Model model, GoodsBaseSO so, String forceStSearchReadOnly) {
		if (log.isDebugEnabled()) {
			log.debug("==================================================");
			log.debug("= {}, {}", "Goods Search", so);
			log.debug("==================================================");
		}

		Boolean mallAdminSession = Boolean.FALSE;

		// 업체사용자일 때 업체번호를 항상 조회조건에 사용하도록 수정함.
		if (StringUtils.equals(CommonConstants.USR_GRP_10, AdminSessionUtil.getSession().getUsrGrpCd())) {
			mallAdminSession = Boolean.TRUE;
		} else {
			so.setCompNo(AdminSessionUtil.getSession().getCompNo());
		}

		if(so.getStIds() != null || StringUtil.isNotEmpty(so.getStId())) {
			// 업체가 속한 사이트 목록 가져오기
			StStdInfoSO stso = new StStdInfoSO();
			stso.setCompNo(so.getCompNo());

			if(StringUtil.isNotEmpty(so.getStId())) {
				stso.setStId(so.getStId());
			}
			List<StStdInfoVO> stIdList = stService.getStList(stso);

			if(so.getStIds() != null) {
				Long[] stIds = Arrays.stream(so.getStIds()).map(Long::parseLong).toArray(Long[]::new);
				stIdList = stIdList.stream().filter(p -> Arrays.stream(stIds).anyMatch(p.getStId()::equals)).collect(Collectors.toList());
			}

			model.addAttribute("siteList", stIdList);
		}

		// 태그 조회
		if(so.getTags() != null) {
			TagBaseSO tagBaseSO = new TagBaseSO();
			tagBaseSO.setTagNos(so.getTags());
			List tags = tagService.listTagBase(tagBaseSO);

			model.addAttribute("tags", tags);
		}

		// 업체 조회
		if(so.getCompNo() != null) {
			if(StringUtils.isEmpty(so.getCompNm())) {
				CompanySO companySO = new CompanySO();
				companySO.setCompNo(so.getCompNo());
				CompanyBaseVO companyBaseVO = companyService.getCompany(companySO);
				so.setCompNm(companyBaseVO.getCompNm());
			}
		}

		//대상 카테고리 조회
		if(so.getDispClsfNo() != null) {
			HashMap category = goodsService.getGoodsDisplayCategory(so.getDispClsfNo());
			model.addAttribute("category", category);
		}

		if(StringUtils.isNotEmpty(so.getGoodsCstrtTpCd())) {
			String[] goodsCstrtTpCds = so.getGoodsCstrtTpCds();
			if(goodsCstrtTpCds != null) {
				so.setGoodsCstrtTpCds(Stream.of(so.getGoodsCstrtTpCds(), new String[]{so.getGoodsCstrtTpCd()}).flatMap(Stream::of).toArray(String[]::new));
			} else {
				so.setGoodsCstrtTpCds(new String[]{so.getGoodsCstrtTpCd()});
			}

			so.setGoodsCstrtTpCd("");
		}

		/**
		 * 금액 유형 목록 조회 (정렬 때문에 코드 리스트 못 씀 )
		 * 일반	1
		 * 타임딜	2
		 * 공동구매	3
		 * 유통기한 임박 할인	4 -> 5
		 * 재고 임박 할인	5 -> 4
		 * 사전예약상품	6
		 */
		List<CodeDetailVO> amtTpCodeList = cacheService.listCodeCache(AdminConstants.GOODS_AMT_TP, true, null, null, null, null, null) ;
		amtTpCodeList.stream().forEach(p -> {
			if(p.getDtlCd().equals(AdminConstants.GOODS_AMT_TP_10)) {
				p.setSortSeq(Long.valueOf(1));
			} else if(p.getDtlCd().equals(AdminConstants.GOODS_AMT_TP_20)) {
				p.setSortSeq(Long.valueOf(2));
			} else if(p.getDtlCd().equals(AdminConstants.GOODS_AMT_TP_40)) {
				p.setSortSeq(Long.valueOf(4));
			} else if(p.getDtlCd().equals(AdminConstants.GOODS_AMT_TP_50)) {
				p.setSortSeq(Long.valueOf(3));
			} else {
			}});
		amtTpCodeList = amtTpCodeList.stream().sorted(Comparator.comparing(CodeDetailVO::getSortSeq)).collect(Collectors.toList());

		model.addAttribute("amtTpCodeList", amtTpCodeList);
		model.addAttribute("goodsSO", so);
		model.addAttribute("popup", "popup");
		model.addAttribute("mallAdminSession", mallAdminSession);
		model.addAttribute("forceStSearchReadOnly", StringUtils.equalsIgnoreCase(forceStSearchReadOnly, CommonConstants.COMM_YN_Y) ? Boolean.TRUE :  Boolean.FALSE);

		return "/goods/goodsSearchLayerView";
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: GoodsController.java
	 * - 작성일		: 2016. 4. 27.
	 * - 작성자		: valueFactory
	 * - 설명			: 상품 리스트
	 * </pre>
	 *
	 * @param so
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/goods/goodsBaseGrid.do", method = RequestMethod.POST)
	public GridResponse goodsBaseGrid(GoodsBaseSO so) {
		if (!StringUtil.isEmpty(so.getGoodsIdArea())) {
			so.setGoodsIds(StringUtil.splitEnter(so.getGoodsIdArea()));
		}

		if (!StringUtil.isEmpty(so.getGoodsNmArea())) {
			so.setGoodsNms(StringUtil.splitEnter(so.getGoodsNmArea()));
		}

		if (!StringUtil.isEmpty(so.getMdlNmArea())) {
			so.setMdlNms(StringUtil.splitEnter(so.getMdlNmArea()));
		}

		if (!StringUtil.isEmpty(so.getCompGoodsIdArea())) {
			so.setCompGoodsIds(StringUtil.splitEnter(so.getCompGoodsIdArea()));
		}

		if (!StringUtil.isEmpty(so.getBomCdArea())) {
			so.setBomCds(StringUtil.splitEnter(so.getBomCdArea()));
		}

		Session session = AdminSessionUtil.getSession();
		// 업체사용자일 때 업체번호를 항상 조회조건에 사용
		if (StringUtils.equals(CommonConstants.USR_GRP_20, session.getUsrGrpCd())) {
			so.setCompNo(session.getCompNo());
		}

		List<GoodsBaseVO> list = goodsService.pageGoodsBase(so);
		return new GridResponse(list, so);
	}

	@RequestMapping("/goods/goodsBaseExcelDownload.do")
	public String goodsBaseExcelDownload(ModelMap model, GoodsBaseSO so,@RequestParam(value="goodsIdNoStr",required = false)String goodsIdNoStr){

		if (!StringUtil.isEmpty(so.getGoodsIdArea())) {
			so.setGoodsIds(StringUtil.splitEnter(so.getGoodsIdArea()));
		}

		if (!StringUtil.isEmpty(so.getGoodsNmArea())) {
			so.setGoodsNms(StringUtil.splitEnter(so.getGoodsNmArea()));
		}

		if (!StringUtil.isEmpty(so.getMdlNmArea())) {
			so.setMdlNms(StringUtil.splitEnter(so.getMdlNmArea()));
		}

		if (!StringUtil.isEmpty(so.getBomCdArea())) {
			so.setBomCds(StringUtil.splitEnter(so.getBomCdArea()));
		}

		// 업체사용자일 때 업체번호를 항상 조회조건에 사용하도록 수정함.
		if (StringUtils.equals(CommonConstants.USR_GRP_20, AdminSessionUtil.getSession().getUsrGrpCd())) {

			so.setCompNo(AdminSessionUtil.getSession().getCompNo());
		}

		List<HashMap> list = goodsService.getGoodsBaseList(so);
		
		//선택 된 로우 있을 시
		if(StringUtil.isNotEmpty(goodsIdNoStr)){
			String[] goodsIdNos = goodsIdNoStr.split(",");
			list = list.stream().filter(v-> Arrays.asList(goodsIdNos).contains(v.get("GOODS_ID").toString())).collect(Collectors.toList());
		}

		//이미지 경로 변경 naverCloudOptimizer 로 변경
		String naverCloudOptimizerDomain = bizConfig.getProperty("naver.cloud.optimizer.domain");
		CodeDetailVO cdVo = cacheService.getCodeCache(CommonConstants.IMG_OPT_QRY, CommonConstants.IMG_OPT_QRY_300);
		if (!org.apache.commons.lang3.StringUtils.startsWith(cdVo.getUsrDfn1Val(), "?"))
			cdVo.setUsrDfn1Val("?" + cdVo.getUsrDfn1Val());

		List resultList = list.stream()
				.peek(m -> {
					m.put("IMG_PATH", naverCloudOptimizerDomain + m.get("IMG_PATH") + cdVo.getUsrDfn1Val());
					if(CommonConstants.GOODS_STAT_70.equals(m.get("GOODS_STAT_CD"))){
						m.put("GOODS_STAT_NM", "삭제");
					}
				})
				.collect(Collectors.toList());

		String[] headerName = null;
		String[] fieldName = null;

		// 상품 목록
		if(StringUtils.equals(so.getExcelType(), AdminConstants.GOODS_EXCEL_DOWNLOAD_GOODS)) {
			headerName = AdminConstants.GOODS_EXCEL_DOWNLOAD_GOODS_HEADER.values().toArray(new String[]{});
			fieldName = AdminConstants.GOODS_EXCEL_DOWNLOAD_GOODS_HEADER.keySet().toArray(new String[]{});

		} else if(StringUtils.equals(so.getExcelType(), AdminConstants.GOODS_EXCEL_DOWNLOAD_CATEGORY)) {
			// 카테고리
			headerName = AdminConstants.GOODS_EXCEL_DOWNLOAD_CATEGORY_HEADER.values().toArray(new String[]{});
			fieldName = AdminConstants.GOODS_EXCEL_DOWNLOAD_CATEGORY_HEADER.keySet().toArray(new String[]{});

		} else if(StringUtils.equals(so.getExcelType(), AdminConstants.GOODS_EXCEL_DOWNLOAD_PRICE)) {
			// 가격
			headerName = AdminConstants.GOODS_EXCEL_DOWNLOAD_PRICE_HEADER.values().toArray(new String[]{});
			fieldName = AdminConstants.GOODS_EXCEL_DOWNLOAD_PRICE_HEADER.keySet().toArray(new String[]{});
		}

		model.addAttribute(CommonConstants.EXCEL_PARAM_NAME, new ExcelViewParam("GoodsBase", headerName, fieldName, resultList));
		model.addAttribute(CommonConstants.EXCEL_PARAM_FILE_NAME, "GoodsBase" + "_" + so.getExcelType().toLowerCase());

		return View.excelDownload();
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: GoodsController.java
	 * - 작성일		: 2016. 4. 28.
	 * - 작성자		: valueFactory
	 * - 설명			: 단품 조회 팝업
	 * </pre>
	 *
	 * @param model
	 * @param so
	 * @return
	 */
	@RequestMapping("/goods/itemSearchLayerView.do")
	public String itemSearchLayerView(Model model, GoodsBaseSO so) {
		if (log.isDebugEnabled()) {
			log.debug("==================================================");
			log.debug("= {}", "Item Search");
			log.debug("==================================================");
		}

		// 업체사용자일 때 업체번호를 항상 조회조건에 사용하도록 수정함.
		if (StringUtils.equals(CommonConstants.USR_GRP_20, AdminSessionUtil.getSession().getUsrGrpCd())) {

			so.setCompNo(AdminSessionUtil.getSession().getCompNo());
		}

		model.addAttribute("goodsSO", so);
		return "/goods/itemSearchLayerView";
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: GoodsController.java
	 * - 작성일		: 2016. 4. 28.
	 * - 작성자		: valueFactory
	 * - 설명			: 단품 리스트 조회
	 * </pre>
	 *
	 * @param so
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/goods/itemGrid.do", method = RequestMethod.POST)
	public GridResponse itemGrid(GoodsBaseSO so) {
		if (log.isDebugEnabled()) {
			log.debug("########## : {} ", so.toString());
		}

		if (!StringUtil.isEmpty(so.getGoodsIdArea())) {
			so.setGoodsIds(StringUtil.splitEnter(so.getGoodsIdArea()));
		}

		if (!StringUtil.isEmpty(so.getGoodsNmArea())) {
			so.setGoodsNms(StringUtil.splitEnter(so.getGoodsNmArea()));
		}

		if (!StringUtil.isEmpty(so.getMdlNmArea())) {
			so.setMdlNms(StringUtil.splitEnter(so.getMdlNmArea()));
		}

		if (!StringUtil.isEmpty(so.getBomCdArea())) {
			so.setBomCds(StringUtil.splitEnter(so.getBomCdArea()));
		}

		if (!StringUtil.isEmpty(so.getItemNoArea())) {
			String[] itemNoList = StringUtil.splitEnter(so.getItemNoArea());
			Long[] itemNos = null;
			if (itemNoList != null && itemNoList.length > 0) {
				itemNos = new Long[itemNoList.length];
				for (int i = 0; i < itemNoList.length; i++) {
					itemNos[i] = Long.valueOf(itemNoList[i]);
				}
				so.setItemNos(itemNos);
			}
		}

		// 업체사용자일 때 업체번호를 항상 조회조건에 사용하도록 수정함.
		if (StringUtils.equals(CommonConstants.USR_GRP_20, AdminSessionUtil.getSession().getUsrGrpCd())) {

			so.setCompNo(AdminSessionUtil.getSession().getCompNo());
		}

		List<ItemVO> list = itemService.pageItem(so);
		return new GridResponse(list, so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: GoodsController.java
	 * - 작성일		: 2016. 4. 27.
	 * - 작성자		: valueFactory
	 * - 설명			: 상품 리스트
	 * </pre>
	 *
	 * @param model
	 * @param so
	 * @return
	 */
	@RequestMapping("/goods/goodsListView.do")
	public String goodsListView(Model model, GoodsBaseSO so) {
		if (log.isDebugEnabled()) {
			log.debug("==================================================");
			log.debug("= {}", "Goods Search");
			log.debug("==================================================");
		}

		Boolean mallAdminSession = Boolean.FALSE;

		// 업체사용자일 때 업체번호를 항상 조회조건에 사용하도록 수정함.
		if (StringUtils.equals(CommonConstants.USR_GRP_10, AdminSessionUtil.getSession().getUsrGrpCd())) {
			mallAdminSession = Boolean.TRUE;
		} else if (StringUtils.equals(CommonConstants.USR_GRP_20, AdminSessionUtil.getSession().getUsrGrpCd())) {
			so.setCompNo(AdminSessionUtil.getSession().getCompNo());
		}
		// 업체사용자일 때 업체번호를 항상 조회조건에 사용하도록 수정함.

		/**
		 * 수동 아이콘 목록 조회
		 */
		List<CodeDetailVO> iconCodeList = cacheService.listCodeCache(AdminConstants.GOODS_ICON, true, CommonConstants.USE_YN_N, CommonConstants.USE_YN_N, null, null, null) ;
		iconCodeList = iconCodeList.stream().sorted(Comparator.comparing(CodeDetailVO::getSortSeq)).collect(Collectors.toList());

		/**
		 * 금액 유형 목록 조회 (정렬 때문에 코드 리스트 못 씀 )
		 * 일반	1
		 * 타임딜	2
		 * 공동구매	3
		 * 유통기한 임박 할인	4 -> 5
		 * 재고 임박 할인	5 -> 4
		 * 사전예약상품	6
		 */
		List<CodeDetailVO> amtTpCodeList = cacheService.listCodeCache(AdminConstants.GOODS_AMT_TP, true, null, null, null, null, null) ;
		amtTpCodeList.stream().forEach(p -> {
			if(p.getDtlCd().equals(AdminConstants.GOODS_AMT_TP_10)) {
				p.setSortSeq(Long.valueOf(1));
			} else if(p.getDtlCd().equals(AdminConstants.GOODS_AMT_TP_20)) {
				p.setSortSeq(Long.valueOf(2));
			} else if(p.getDtlCd().equals(AdminConstants.GOODS_AMT_TP_40)) {
				p.setSortSeq(Long.valueOf(4));
			} else if(p.getDtlCd().equals(AdminConstants.GOODS_AMT_TP_50)) {
				p.setSortSeq(Long.valueOf(3));
			} else {
			}});
		amtTpCodeList = amtTpCodeList.stream().sorted(Comparator.comparing(CodeDetailVO::getSortSeq)).collect(Collectors.toList());

		model.addAttribute("goodsSO", so);
		model.addAttribute("mallAdminSession", mallAdminSession);
		model.addAttribute("iconCodeList", iconCodeList);
		model.addAttribute("amtTpCodeList", amtTpCodeList);

		return "/goods/goodsListView";
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: GoodsController.java
	 * - 작성일		: 2016. 4. 27.
	 * - 작성자		: valueFactory
	 * - 설명		: 상품 프로모션 적용가격 조회 팝업
	 * </pre>
	 *
	 * @param model
	 * @param so
	 * @return
	 */
	@RequestMapping("/goods/goodsPrmtPricePopView.do")
	public String goodsPrmtPricePopView(Model model, GoodsBaseSO so) {
		GoodsBaseVO goodsBaseVO = new GoodsBaseVO();
		goodsBaseVO.setGoodsId(so.getGoodsId());

		model.addAttribute("goodsBase", goodsBaseVO);

		return "/goods/goodsPrmtPricePopView";
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: GoodsController.java
	 * - 작성일		: 2016. 4. 27.
	 * - 작성자		: valueFactory
	 * - 설명		: 상품 프로모션 적용가격 조회 그리드
	 * </pre>
	 *
	 * @param model
	 * @param so
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/goods/goodsPrmtPricePopViewGrid.do", method = RequestMethod.POST)
	public GridResponse goodsPrmtPricePopViewGrid(Model model, GoodsBaseSO so) {

		List<GoodsPriceVO> goodsPrmtPriceList = goodsService.getGoodsPromotionPrice(so);

		return new GridResponse(goodsPrmtPriceList, so);
	}

	/**
	 *
	* <pre>
	* - 프로젝트명   : 41.admin.web
	* - 패키지명   : admin.web.view.goods.controller
	* - 파일명      : CompanyController.java
	* - 작성일      : 2017. 6. 19.
	* - 작성자      : valuefactory 권성중
	* - 설명      :   상품 배송비정책번호 일괄 변경
	* </pre>
	 */
	@RequestMapping("/goods/updateGoodsDlvrcPlcNoBatch.do")
	public String updateGoodsDlvrcPlcNoBatch(Model model, GoodsBaseSO goodsBase) {
		int rtn = goodsService.updateGoodsDlvrcPlcNoBatch(goodsBase);

		model.addAttribute("rtn", rtn);

		return View.jsonView();
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: GoodsController.java
	 * - 작성일		: 2016. 4. 29.
	 * - 작성자		: valueFactory
	 * - 설명			: 상품 복사 Layer
	 * </pre>
	 *
	 * @param model
	 * @param so
	 * @return
	 */
	@RequestMapping("/goods/goodsCopyLayerView.do")
	public String goodsCopyLayerView(Model model, GoodsBaseSO so) {
		if (log.isDebugEnabled()) {
			log.debug("==================================================");
			log.debug("= {}", "Goods CopyLayerView");
			log.debug("==================================================");
		}

		String goodsId = null;
		goodsId = so.getGoodsId();

		GoodsBaseVO goodsBase = goodsService.getGoodsSimpleInfo(goodsId);
		if(so.getStId() != null) {
			goodsBase.setStId(Long.toString(so.getStId()));
		}

		model.addAttribute("goodsBase", goodsBase);
		return "/goods/goodsCopyLayerView";
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: GoodsController.java
	 * - 작성일		: 2016. 4. 29.
	 * - 작성자		: valueFactory
	 * - 설명			: 상품 복사
	 * </pre>
	 *
	 * @param model
	 * @param so
	 * @return
	 */
	@RequestMapping(value = "/goods/goodsCopy.do")
	public String goodsCopy(Model model, GoodsBaseSO so) {
		if (log.isDebugEnabled()) {
			log.debug("==================================================");
			log.debug("= {}", "Goods Copy");
			log.debug("==================================================");
			LogUtil.log(so);
		}

		String goodsId = goodsService.copyGoods(so);

		model.addAttribute("goodsId", goodsId);
		return View.jsonView();
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: GoodsController.java
	 * - 작성일		: 2021. 3. 2.
	 * - 작성자		: valueFactory
	 * - 설명		: 후기 복사 Layer
	 * </pre>
	 *
	 * @param model
	 * @param so
	 * @return
	 */
	@RequestMapping("/goods/goodsCommentCopyLayerView.do")
	public String goodsCommentCopyLayerView(Model model, GoodsBaseSO so) {
		if (log.isDebugEnabled()) {
			log.debug("==================================================");
			log.debug("= {}", "Goods Copy Comment LayerView");
			log.debug("==================================================");
		}

		String goodsId = null;
		goodsId = so.getGoodsId();

		GoodsBaseVO goodsBase = goodsService.getGoodsSimpleInfo(goodsId);
		if(so.getStId() != null) {
			goodsBase.setStId(Long.toString(so.getStId()));
		}
		goodsBase.setFstGoodsId(goodsBase.getGoodsId());

		model.addAttribute("goodsBase", goodsBase);
		return "/goods/goodsCommentCopyLayerView";
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: GoodsController.java
	 * - 작성일		: 2021. 3. 2.
	 * - 작성자		: valueFactory
	 * - 설명		: 후기 복사
	 * </pre>
	 *
	 * @param model
	 * @param so
	 * @return
	 */
	@RequestMapping(value = "/goods/goodsCommentCopy.do")
	public String goodsCommentCopy(Model model, GoodsBaseSO so) {
		if (log.isDebugEnabled()) {
			log.debug("==================================================");
			log.debug("= {}", "Goods Comment Copy");
			log.debug("==================================================");
			LogUtil.log(so);
		}

		int dupCount = goodsCommentService.getDuplicateCommentCount(so);

		int result = goodsService.copyGoodsComment(so);

		model.addAttribute("dupCount", dupCount);
		model.addAttribute("result", result);
		return View.jsonView();
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: GoodsController.java
	 * - 작성일		: 2016. 5. 2.
	 * - 작성자		: valueFactory
	 * - 설명			: 상품 상세정보 조회
	 * </pre>
	 *
	 * @param model
	 * @param so
	 * @return
	 */
	@RequestMapping(value = "/*/goodsDetailView.do")
	public String goodsDetailView(Model model, String viewGb,  GoodsBaseSO so) {

		String goodsId = so.getGoodsId();

		// 상품 기본 정보 조회
		GoodsBaseVO goodsBaseVO = goodsService.getGoodsDetail(goodsId);
		if (goodsBaseVO == null) {
			// 상품이 존재하지 않습니다.
			throw new CustomException(ExceptionConstants.ERROR_GOODS_NO_DATA);
		}

		// 상품 유형
		model.addAttribute("goodsCstrtTpCd", goodsBaseVO.getGoodsCstrtTpCd() );
		
		so.setCompNo(goodsBaseVO.getCompNo());

		// 상품이 꽂히는 사이트 목록 조회.  hjko 추가. 2017.01.06
//		StGoodsMapSO stSo = new StGoodsMapSO();
//		stSo.setGoodsId(so.getGoodsId());
//		stSo.setCompNo(so.getCompNo());
//
//		List<StGoodsMapVO> siteList = goodsService.listStStdInfoGoods(stSo);
//		model.addAttribute("siteList",siteList);

		// 상품 기본 정보 조회
		model.addAttribute("goodsBase", goodsBaseVO);

		// 업체 배송정책 조회
		Long compNo = goodsBaseVO.getCompNo();
		// 배송 정책
		List<DeliveryChargePolicyVO> deliveryChargePolicyVOList = null;
		deliveryChargePolicyVOList = goodsService.listCompDlvrcPlc(compNo);
		
		model.addAttribute("dlvrPlcList", deliveryChargePolicyVOList);

		// 수수료 정책
		//CompanyCclVO comCclVO = goodsService.getCompCcl(compNo);
		CompanyCclVO comCclVO = null;
		/* if (comCclVO == null) { */
			// 조회가 되지 않은 경우 기본 값으로 설정
			comCclVO = new CompanyCclVO();
			comCclVO.setCmsRate(AdminConstants.CMS_DEFALUT_RATE);
		/* } */
		model.addAttribute("cclPlc", comCclVO);

		// 업체 브랜드 조회 hjko 추가
		List<CompanyBrandVO> companyBrandVOList = null;
		companyBrandVOList = goodsService.listCompanyBrand(compNo);
		model.addAttribute("companyBrandList", companyBrandVOList);

		// 상품 현재 가격 정보 조회
		GoodsPriceVO goodsPriceVO = goodsPriceService.getCurrentGoodsPrice(goodsId);
		model.addAttribute("goodsPrice", goodsPriceVO);
		
		// 네이버 ep 정보 조회
//		GoodsNaverEpInfoVO goodsNaverEpInfoVO = goodsNaverEpInfoService.getGoodsNaverEpInfo(goodsId);
		
//		model.addAttribute("goodsNaverEpInfoVO", goodsNaverEpInfoVO);

		// 상품 상세 설명 조회
		GoodsDescVO goodsDescVO = goodsService.getGoodsDescAll(goodsId);
		model.addAttribute("goodsDesc", goodsDescVO);

		// 상품 주의사항 조회
		GoodsCautionVO goodsCautionVO = goodsCautionService.getGoodsCaution(goodsId );
		model.addAttribute("goodsCaution", goodsCautionVO);

		// 품목군 코드 조회
		List<NotifyInfoVO> notifyInfoVOList = goodsService.listNotifyInfo();

		// 공정위 품목군 정보
		NotifyItemSO notifyItemSO = new NotifyItemSO();
		notifyItemSO.setGoodsId(goodsId);
		notifyItemSO.setNtfId(goodsBaseVO.getNtfId());
		List<NotifyItemVO> notifyItemVOList = goodsService.listNotifyItem(notifyItemSO);

		model.addAttribute("notifyInfo", notifyInfoVOList);
		model.addAttribute("notifyItem", notifyItemVOList);

		// 상품 옵션 조회
		List<AttributeVO> attributeVOList = itemService.listGoodsAttribute(so.getGoodsId());
		model.addAttribute("attribute", attributeVOList);

		// 상품 이미지 조회
		List<GoodsImgVO> goodsImgVOList = goodsService.listGoodsImg(goodsId);

		model.addAttribute("goodsImg", goodsImgVOList);
		
		// 상품 태그 
		List<GoodsTagMapVO> goodsTagMapList = goodsTagMapService.listGoodsTagMap(goodsId);
		
		model.addAttribute("goodsTagMapList", goodsTagMapList);
		
		// 아이콘 목록
		List<CodeDetailVO> limitedIconCodeList = cacheService.listCodeCache(AdminConstants.GOODS_ICON, true, CommonConstants.USE_YN_Y, null, null, null, null) ;
		List<CodeDetailVO> unlimitedIconCodeList = cacheService.listCodeCache(AdminConstants.GOODS_ICON, true, CommonConstants.USE_YN_N, CommonConstants.USE_YN_N, null, null, null) ;
		List<GoodsIconVO> goodsIconList = goodsIconService.listGoodsIcon(goodsId);
		
		model.addAttribute("limitedIconCodeList", limitedIconCodeList);
		model.addAttribute("unlimitedIconCodeList", unlimitedIconCodeList);
		model.addAttribute("goodsIconList", goodsIconList);

		// 성분 정보 단품을 제외한 상품구성은  대표상품 조회 
		if(StringUtils.equals(goodsBaseVO.getIgdtInfoLnkYn(), AdminConstants.COMM_YN_Y)) {
			TwcProductVO twcProductVO = new TwcProductVO();
			if(StringUtils.equals(goodsBaseVO.getGoodsCstrtTpCd(), CommonConstants.GOODS_CSTRT_TP_ITEM)) {
				twcProductVO = twcProductService.getTwcProduct(goodsId, goodsBaseVO.getCompGoodsId());
			}else {
				// 대표상품 정보 조회
				GoodsBaseVO dlgtSubGoodsInfo = goodsService.getDlgtSubGoodsInfo(goodsId, goodsBaseVO.getGoodsCstrtTpCd());
				twcProductVO = twcProductService.getTwcProduct(dlgtSubGoodsInfo.getGoodsId(), dlgtSubGoodsInfo.getCompGoodsId());
			}
			if(!ObjectUtils.isEmpty(twcProductVO)) {
				TwcProductNutritionVO twcProductNutritionVO = twcProductService.getTwcProductNutrition(twcProductVO.getId());
				model.addAttribute("twcProductVO",twcProductVO);
				model.addAttribute("twcProductNutritionVO",twcProductNutritionVO);
			}
		}
		
		// 수정 가능 여부 확인 카운트
		GoodsBaseVO checkPossibleCnt = goodsService.checkPossibleCnt(goodsId);
		model.addAttribute("checkPossibleCnt", checkPossibleCnt);
		
		// 상품 연관 영상 조회
		ApetContentsGoodsMapSO apetContentsGoodsMapSO = new ApetContentsGoodsMapSO();
		apetContentsGoodsMapSO.setGoodsId(goodsId);
		List<ApetContentsGoodsMapVO> contentList = goodsService.listApetContentsGoodsMap(apetContentsGoodsMapSO);
		
		model.addAttribute("contentList", contentList);

		Session session = AdminSessionUtil.getSession();
		// 업체사용자일 때 업체번호를 항상 조회조건에 사용하도록 수정함.
		if (StringUtils.equals(CommonConstants.USR_GRP_20, AdminSessionUtil.getSession().getUsrGrpCd())) {

			model.addAttribute("loginCompNo", session.getCompNo());
		}

		// 사용 확인 필요
		String layOut = AdminConstants.LAYOUT_DEFAULT;
		if(AdminConstants.VIEW_GB_POP.equals(viewGb)){
			layOut = AdminConstants.LAYOUT_POP;
		}
		model.addAttribute("layout", layOut);

		return "/goods/goodsDetailView";
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: GoodsController.java
	 * - 작성일		: 2016. 4. 28.
	 * - 작성자		: valueFactory
	 * - 설명			: 상품 전시정보 조회
	 * </pre>
	 *
	 * @param so
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/goods/dispCtgGrid.do", method = RequestMethod.POST)
	public GridResponse dispCtgGrid(GoodsBaseSO so) {
		if (log.isDebugEnabled()) {
			log.debug("########## : {} ", so.toString());
		}
		String goodsId = so.getGoodsId();
		List<DisplayGoodsVO> list = goodsService.listGoodsDispCtg(goodsId);
		return new GridResponse(list, so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: GoodsController.java
	 * - 작성일		: 2016. 5. 3.
	 * - 작성자		: valueFactory
	 * - 설명			: 상품 구성품 정보 리스트 조회
	 * </pre>
	 *
	 * @param so
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/goods/goodsCstrtGrid.do", method = RequestMethod.POST)
	public GridResponse goodsCstrtGrid(GoodsCstrtInfoSO so) {
		if (log.isDebugEnabled()) {
			log.debug("########## : {} ", so.toString());
		}
		// 사이트정보의 USE_YN 이 Y 일 때 조회함.
		so.setStUseYn(CommonConstants.COMM_YN_Y);

		List<GoodsCstrtInfoVO> list = goodsService.listGoodsCstrtInfo(so);
		return new GridResponse(list, so);
	}


	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: GoodsController.java
	 * - 작성일		: 2016. 5. 12.
	 * - 작성자		: valueFactory
	 * - 설명			: 상품 옵션 그리드 조회
	 * </pre>
	 *
	 * @param model
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/goods/goodsAttributeGrid.do", method = RequestMethod.POST)
	public GridResponse goodsAttributeGrid(Model model, AttributeSO so) {
		List<AttributeVO> list = itemService.listGoodsAttribute(so.getGoodsId());
		return new GridResponse(list, so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: GoodsController.java
	 * - 작성일		: 2016. 5. 12.
	 * - 작성자		: valueFactory
	 * - 설명			: 상품 단품 그리드 조회
	 * </pre>
	 *
	 * @param model
	 * @param so
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/goods/goodsItemGrid.do", method = RequestMethod.POST)
	public GridResponse goodsItemGrid(Model model, ItemSO so) {
		if (log.isDebugEnabled()) {
			log.debug("########## : {} ", so.toString());
		}

		//List<ItemVO> list = itemService.listGoodsItem(so.getGoodsId());
		List<ItemVO> resultList = itemService.listGoodsItem(so.getGoodsId());


		List<ItemVO> list = new ArrayList<>();

			for(ItemVO item : resultList ){
				JSONArray objArray = new JSONArray();

				if(item.getAttr1No() != null ){
					JSONObject obj = new JSONObject();
					obj.put("attrValNo", item.getAttr1ValNo());
					obj.put("attrNo", item.getAttr1No());
					objArray.put(obj);
				}
				if(item.getAttr2No() != null ){
					JSONObject obj = new JSONObject();
					obj.put("attrValNo", item.getAttr2ValNo());
					obj.put("attrNo", item.getAttr2No());
					objArray.put(obj);
				}
				if(item.getAttr3No() != null ){
					JSONObject obj = new JSONObject();
					obj.put("attrValNo", item.getAttr3ValNo());
					obj.put("attrNo", item.getAttr3No());
					objArray.put(obj);
				}
				if(item.getAttr4No() != null ){
					JSONObject obj = new JSONObject();
					obj.put("attrValNo", item.getAttr4ValNo());
					obj.put("attrNo", item.getAttr4No());
					objArray.put(obj);
				}
				if(item.getAttr5No() != null ){
					JSONObject obj = new JSONObject();
					obj.put("attrValNo", item.getAttr5ValNo());
					obj.put("attrNo", item.getAttr5No());
					objArray.put(obj);
				}

				item.setAttrValJson(objArray.toString());
				list.add(item);
			}

		return new GridResponse(list, so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: GoodsController.java
	 * - 작성일		: 2016. 5. 13.
	 * - 작성자		: valueFactory
	 * - 설명			:
	 * </pre>
	 *
	 * @return
	 */
	@RequestMapping(value = "/goods/goodsUpdate.do")
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public String goodsUpdate(
			Model model,
			@RequestParam("goodsBasePO") String goodsBaseStr,
			@RequestParam(value = "goodsNaverEpInfoPO", required = false) String goodsNaverEpInfoStr,
			@RequestParam(value = "attributePO", required = false) String attributeStr,
			@RequestParam(value = "itemPO", required = false) String itemStr,
			@RequestParam(value = "optGrpPO", required = false) String optGrpStr,
			@RequestParam(value = "goodsNotifyPO", required = false) String goodsNotyfyStr,
			@RequestParam(value = "goodsCstrtInfoPO", required = false) String goodsCstrtInfoStr,
			@RequestParam(value = "displayGoodsPO", required = false) String displayGoodsPOStr,
			@RequestParam(value = "filtAttrMapPO", required = false) String filtAttrMapPOStr,
			@RequestParam(value = "goodsIconPO", required = false) String goodsIconPOStr,
			@RequestParam(value = "goodsTagMapPO", required = false) String goodsTagMapPOStr,
			@RequestParam(value = "goodsImgPO", required = false) String goodsImgStr,
			@RequestParam(value = "goodsCautionPO", required = false) String goodsCautionStr ,
			@RequestParam(value = "stGoodsMapPO", required = false) String stGoodsMapStr,
			@RequestParam(value = "orgAttrDelete", required = false) String orgAttrDelete,
			GoodsDescPO goodsDescPO ){

		GoodsPO goodsPO = new GoodsPO();
		
		// 상품 데이터 변환
		goodsPO = goodsService.setDataToGoodsPO(goodsBaseStr, "", attributeStr, itemStr, goodsNotyfyStr, goodsCstrtInfoStr
				, displayGoodsPOStr, filtAttrMapPOStr, goodsIconPOStr, goodsTagMapPOStr, goodsImgStr, goodsCautionStr, stGoodsMapStr, goodsDescPO, optGrpStr, goodsNaverEpInfoStr);

		// 상품 수정
		GoodsBaseVO resultGoodsBaseVO = goodsService.updateGoods(goodsPO);
		model.addAttribute("result", resultGoodsBaseVO);
		
		return View.jsonView();
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: GoodsController.java
	 * - 작성일		: 2016. 5. 13.
	 * - 작성자		: valueFactory
	 * - 설명			: 상품 이미지 삭제
	 * </pre>
	 *
	 * @param model
	 * @param po
	 * @return
	 */
	@RequestMapping(value = "/goods/goodsImageDelete.do")
	public String goodsImageDelete(Model model, GoodsImgPO po) {
		if (log.isDebugEnabled()) {
			log.debug("==================================================");
			log.debug("= {}", "Goods Image Delete");
			log.debug("==================================================");
		}

		goodsService.deleteGoodsImg(po);

		return View.jsonView();
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: GoodsController.java
	 * - 작성일		: 2016. 5. 18.
	 * - 작성자		: valueFactory
	 * - 설명			: 상품 역마진 체크
	 * 				상품 등록시.. 가격과 카테고리 번호를 활용하여 체크
	 * </pre>
	 *
	 * @param model
	 * @param so
	 * @return
	 */
	@RequestMapping(value = "/goods/checkReverseMargin.do")
	public String checkReverseMargin(Model model, GoodsBaseSO so) {
		if (log.isDebugEnabled()) {
			log.debug("==================================================");
			log.debug("= {}", "Goods Check Reverse Margin");
			log.debug("==================================================");
		}

		return View.jsonView();
	}

	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: GoodsController.java
	* - 작성일		: 2016. 5. 13.
	* - 작성자		: joeunok
	* - 설명		: Deal 상품 목록
	* </pre>
	* @param model
	* @param po
	* @return
	*/
	@RequestMapping(value = "/goods/goodsDealListView.do")
	public String goodsDealListView(Model model) {
		if(log.isDebugEnabled()) {
			log.debug("Deal 상품");
		}
		return "/goods/goodsDealListView";
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: GoodsController.java
	 * - 작성일		: 2016. 5. 18.
	 * - 작성자		: joeunok
	 * - 설명		: SET 상품 / Deal 상품 그리드
	 * </pre>
	 * @param model
	 * @param po
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/goods/goodsSetGrid.do", method = RequestMethod.POST)
	public GridResponse goodsSetGrid(Model model, GoodsBaseSO goodsBaseSO) {

		if(!StringUtil.isEmpty(goodsBaseSO.getGoodsIdArea())) {
			goodsBaseSO.setGoodsIds(StringUtil.splitEnter(goodsBaseSO.getGoodsIdArea()) );
		}
		if(!StringUtil.isEmpty(goodsBaseSO.getGoodsNmArea())) {
			goodsBaseSO.setGoodsNms(StringUtil.splitEnter(goodsBaseSO.getGoodsNmArea()) );
		}

		// 업체사용자일 때 업체번호를 항상 조회조건에 사용하도록 수정함.
		if (StringUtils.equals(CommonConstants.USR_GRP_20, AdminSessionUtil.getSession().getUsrGrpCd())) {

			goodsBaseSO.setCompNo(AdminSessionUtil.getSession().getCompNo());
		}
		List<GoodsBaseVO> list = goodsService.pageGoodsBase(goodsBaseSO);
		return new GridResponse(list, goodsBaseSO);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: GoodsController.java
	 * - 작성일		: 2016. 5. 20.
	 * - 작성자		: joeunok
	 * - 설명		: 마스터 상품 단건
	 * </pre>
	 *
	 * @param model
	 * @return
	 */
	@RequestMapping("/goods/goodsDealView.do")
	public String goodsDealView(Model model, GoodsBasePO goodsBasePO) {

		if (log.isDebugEnabled()) {
			log.debug("goodsBasePO ===== {} ", goodsBasePO);
		}

		// 마스터 상품 단건 가져오기
		model.addAttribute("goodsBase", goodsService.getGoodsBase(goodsBasePO.getGoodsId()));

		return "/goods/goodsDealView";
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: GoodsController.java
	 * - 작성일		: 2016. 5. 18.
	 * - 작성자		: joeunok
	 * - 설명		: SET 상품 등록
	 * </pre>
	 *
	 * @param model
	 * @param po
	 * @return
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping("/goods/goodsSetInsert.do")
	public String goodsSetInsert(Model model,
			@RequestParam("goodsDealPOList") String goodsDealPOListStr,
			@RequestParam("goodsBasePO") String goodsBaseStr,
			@RequestParam(value = "goodsImgPO", required = false) String goodsImgStr,
			@RequestParam(value = "goodsPricePO", required = false) String goodsPriceStr,
			@RequestParam(value = "stGoodsMapPO", required = false) String stGoodsMapStr) {

		if (log.isDebugEnabled()) {
			log.debug("goodsDealPOListStr ===== {} ", goodsDealPOListStr);
		}

		if(log.isDebugEnabled() ) {
			log.debug("goodsBaseStr ===== {} ", goodsBaseStr);
		}

		if(log.isDebugEnabled() ) {
			log.debug("goodsPriceStr ===== {} ", goodsPriceStr);
		}

		if(log.isDebugEnabled() ) {
			log.debug("goodsImgStr ===== {} ", goodsImgStr);
		}

		JsonUtil jsonUt = new JsonUtil();
		GoodsPO goodsPO = new GoodsPO();

		// 상품 기본
		if (StringUtil.isNotEmpty(goodsBaseStr)) {
			GoodsBasePO goodsBasePO = (GoodsBasePO) jsonUt.toBean(
					GoodsBasePO.class, goodsBaseStr);
			goodsPO.setGoodsBasePO(goodsBasePO);
		} else {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

		// 사이트 정보
		List<StGoodsMapPO> stGoodsMapPOList = null;
		if(!StringUtil.isEmpty(stGoodsMapStr)){
			stGoodsMapPOList = jsonUt.toArray(StGoodsMapPO.class, stGoodsMapStr);
			goodsPO.setStGoodsMapPOList(stGoodsMapPOList);
		}

		// 구성 상품
		if (StringUtil.isNotEmpty(goodsDealPOListStr)) {
			List<GoodsCstrtInfoPO> goodsCstrtInfoPOList = jsonUt.toArray(
					GoodsCstrtInfoPO.class, goodsDealPOListStr);
			//--------------------------------------hjko 추가
			boolean firstYn = true;

			// 우선순위가 1로 설정된게 없을 경우
			// 가격 제일 낮은것이 무조건 1순위로 들어가도록 변환
			for(GoodsCstrtInfoPO temp : goodsCstrtInfoPOList){
				if(!temp.getDispPriorRank().equals(1)){
					firstYn=false;
				}
			}
			if(!firstYn){
				goodsCstrtInfoPOList.sort((obj1, obj2) -> {
					Integer tempInt = ( (obj1.getSaleAmt() > obj2.getSaleAmt()) ? 1:0 );
					return (obj1.getSaleAmt() < obj2.getSaleAmt()) ? -1: tempInt ;
				});
				//log.debug(" 가격으로 정렬한 구성상품목록 ====>"+goodsCstrtInfoPOList);
			}
			if(CollectionUtils.isNotEmpty(goodsCstrtInfoPOList)){
				GoodsCstrtInfoPO firstRow = goodsCstrtInfoPOList.get(0);
				firstRow.setDispPriorRank(1);
			}
			//log.debug("goodsCstrtInfoPOList====>"+goodsCstrtInfoPOList);
			goodsPO.setGoodsCstrtInfoPOList(goodsCstrtInfoPOList);
		} else {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

		// 상품 가격
		GoodsPricePO goodsPricePOList = null;
		if(!StringUtil.isEmpty(goodsPriceStr)) {
			goodsPricePOList = (GoodsPricePO)jsonUt.toBean(GoodsPricePO.class,goodsPriceStr);
			goodsPO.setGoodsPricePO(goodsPricePOList);
		}

		// 상품 이미지
		List<GoodsImgPO> goodsImgPOList = null;
		if(!StringUtil.isEmpty(goodsImgStr)) {
			goodsImgPOList = jsonUt.toArray(GoodsImgPO.class, goodsImgStr);
			goodsPO.setGoodsImgPOList(goodsImgPOList);

			if (log.isDebugEnabled()) {
				log.debug("goodsImgStr goodsImgPOList===== {} ", goodsImgPOList);
			}
		}

		// 상품 등록
		String goodsId = goodsService.insertGoodsSet(goodsPO);
		model.addAttribute("goodsId", goodsId);

		return View.jsonView();
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: GoodsController.java
	 * - 작성일		: 2016. 5. 20.
	 * - 작성자		: joeunok
	 * - 설명		: SET 상품 수정
	 * </pre>
	 *
	 * @param model
	 * @param po
	 * @return
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/goods/goodsSetUpdate.do")
	public String goodsSetUpdate(
			Model model,
			@RequestParam("updateGoodsBasePO") String updateGoodsBaseStr,
			@RequestParam("updateGoodsDealPOList") String updateGoodsDealPOListStr,
			@RequestParam(value="updateGoodsImgPO", required = false) String updateGoodsImgPOListStr,
			@RequestParam(value = "stGoodsMapPO", required = false) String stGoodsMapStr
			) {

		if(log.isDebugEnabled() ) {
			log.debug("updateGoodsBaseStr ===== {} ", updateGoodsBaseStr);
		}

		JsonUtil jsonUt = new JsonUtil();
		GoodsPO goodsPO = new GoodsPO();

		// 상품 기본
		if (StringUtil.isNotEmpty(updateGoodsBaseStr)) {
			GoodsBasePO goodsBasePO = (GoodsBasePO) jsonUt.toBean(
					GoodsBasePO.class, updateGoodsBaseStr);
			goodsPO.setGoodsBasePO(goodsBasePO);
		} else {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

		// 사이트 정보
		List<StGoodsMapPO> stGoodsMapPOList = null;
		if(!StringUtil.isEmpty(stGoodsMapStr)){
			stGoodsMapPOList = jsonUt.toArray(StGoodsMapPO.class, stGoodsMapStr);
			goodsPO.setStGoodsMapPOList(stGoodsMapPOList);
		}

		// 구성 상품
		if (StringUtil.isNotBlank(updateGoodsDealPOListStr)) {
			List<GoodsCstrtInfoPO> goodsCstrtInfoList = jsonUt.toArray(
					GoodsCstrtInfoPO.class, updateGoodsDealPOListStr);
			//--------------------------------------hjko 추가
			boolean firstYn = true;

			// 우선순위가 1로 설정된게 없을 경우
			// 가격 제일 낮은것이 무조건 1순위로 들어가도록 변환
			for(GoodsCstrtInfoPO temp : goodsCstrtInfoList){
				if(!temp.getDispPriorRank().equals(1)){
					firstYn=false;
				}
			}
			if(!firstYn){
				goodsCstrtInfoList.sort((obj1, obj2) -> {
					Integer tempInt = ( (obj1.getSaleAmt() > obj2.getSaleAmt()) ? 1:0 );
					return (obj1.getSaleAmt() < obj2.getSaleAmt()) ? -1: tempInt;
				});
			}
			if(CollectionUtils.isNotEmpty(goodsCstrtInfoList)){
				GoodsCstrtInfoPO firstRow = goodsCstrtInfoList.get(0);
				firstRow.setDispPriorRank(1);
			}
			goodsPO.setGoodsCstrtInfoPOList(goodsCstrtInfoList);
		} else {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

		// 상품 이미지
		List<GoodsImgPO> goodsImgPOList = null;
		if (!StringUtil.isEmpty(updateGoodsImgPOListStr)) {
			goodsImgPOList = jsonUt.toArray(GoodsImgPO.class, updateGoodsImgPOListStr);
			goodsPO.setGoodsImgPOList(goodsImgPOList);
		}

		String goodsId = goodsService.updateGoodsCstrtInfo(goodsPO);
		model.addAttribute("goodsId", goodsId);

		return View.jsonView();
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: GoodsController.java
	 * - 작성일		: 2016. 5. 20.
	 * - 작성자		: joeunok
	 * - 설명		: SET 상품 삭제
	 * </pre>
	 *
	 * @param model
	 * @param po
	 * @return
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping("/goods/goodsSetDelete.do")
	public String goodsSetDelete(Model model, @RequestParam("deleteGoodsStr") String deleteGoodsStr) {

		if (log.isDebugEnabled()) {
			log.debug("deleteGoodsStr ====== " + deleteGoodsStr);
		}

		JsonUtil jsonUt = new JsonUtil();
		GoodsPO goodsPO = new GoodsPO();

		if (StringUtil.isNotBlank(deleteGoodsStr)) {
			List<GoodsCstrtInfoPO> goodsIds = jsonUt.toArray(GoodsCstrtInfoPO.class, deleteGoodsStr);
			goodsPO.setGoodsCstrtInfoPOList(goodsIds);
		} else {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		goodsService.deleteSetGoods(goodsPO);

		return View.jsonView();
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: GoodsController.java
	 * - 작성일		: 2016. 5. 27.
	 * - 작성자		: joeunok
	 * - 설명		: SET 상품 목록
	 * </pre>
	 *
	 * @param model
	 * @param po
	 * @return
	 */
	@RequestMapping(value = "/goods/goodsSetListView.do")
	public String goodsSetListView(Model model) {
		if (log.isDebugEnabled()) {
			log.debug("SET 상품");
		}
		return "/goods/goodsSetListView";
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: GoodsController.java
	 * - 작성일		: 2016. 5. 27.
	 * - 작성자		: joeunok
	 * - 설명		: SET 상품 단건
	 * </pre>
	 *
	 * @param model
	 * @return
	 */
	@RequestMapping("/goods/goodsSetView.do")
	public String goodsSetView(Model model, GoodsBasePO goodsBasePO) {

		if (log.isDebugEnabled()) {
			log.debug("goodsBasePO ===== {} ", goodsBasePO);
		}

		String goodsId = null;
		goodsId = goodsBasePO.getGoodsId();

		// 마스터 상품 단건 가져오기
		model.addAttribute("goodsBase", goodsService.getGoodsBase(goodsId));

		// 상품 현재 가격 정보 조회
		GoodsPriceVO goodsPriceVO = goodsPriceService.getCurrentGoodsPrice(goodsId);
		model.addAttribute("goodsPrice", goodsPriceVO);

		// 상품 이미지 조회
		List<GoodsImgVO> goodsImgVOList = goodsService.listGoodsImg(goodsId);
		model.addAttribute("goodsImg",goodsImgVOList);

		return "/goods/goodsSetView";
	}


	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: GoodsController.java
	* - 작성일		: 2016. 6. 13.
	* - 작성자		: valueFactory
	* - 설명			:
	* </pre>
	* @param model
	* @param goodsBaseHistSO
	* @return
	*/
	@ResponseBody
	@RequestMapping(value = "/goods/goodsHistoryGrid.do", method = RequestMethod.POST)
	public GridResponse goodsHistoryGrid (Model model, GoodsBaseHistSO goodsBaseHistSO ) {
		if (log.isDebugEnabled()) {
			log.debug("==================================================");
			log.debug("= {}", "Goods History");
			log.debug("==================================================");
		}

		//String goodsId = goodsBaseHistSO.getGoodsId();
		List<GoodsBaseHistVO> goodsHistoy = goodsService.listGoodsBaseHist(goodsBaseHistSO );
		return new GridResponse(goodsHistoy, goodsBaseHistSO);
	}


	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: GoodsController.java
	* - 작성일		: 2016. 6. 15.
	* - 작성자		: valueFactory
	* - 설명			: 단품 변경 이력 조회
	* </pre>
	* @param model
	* @param itemHistSO
	* @return
	*/
	@ResponseBody
	@RequestMapping(value = "/goods/itemHistoryGrid.do", method = RequestMethod.POST)
	public GridResponse itemHistoryGrid (Model model, ItemHistSO itemHistSO ) {
		if (log.isDebugEnabled()) {
			log.debug("==================================================");
			log.debug("= {}", "Item History");
			log.debug("==================================================");
		}

		List<ItemHistVO> itemHistory = itemService.listItemHist(itemHistSO );
		List<CompareBeanPO> list = new ArrayList<>();

		String[] propertyNames = new String[]{
			"itemNm", "webStkQty"
			, "saleYn", "addSaleAmt", "itemStatCd"
			, "showSeq"
			};

		if(CollectionUtils.isNotEmpty(itemHistory)) {
			for(int i = 0; i< itemHistory.size(); i++ ) {
				ItemHistVO next = itemHistory.get(i );
				ItemHistVO before = null;
				if((i + 1 ) == itemHistory.size() ) {
					before = new ItemHistVO();
				} else {
					before = itemHistory.get(i + 1 );	// 등록된 것까지 출력
				}
				List<CompareBeanPO> comList = BeanCompareUtil.compareBean(next, before, propertyNames );
				list.addAll(comList );
			}
		}
		return new GridResponse(list, itemHistSO);

	}


	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: GoodsController.java
	* - 작성일		: 2016. 6. 17.
	* - 작성자		: valueFactory
	* - 설명			: 상품 가격 이력 조회
	* </pre>
	* @param model
	* @return
	*/
	@RequestMapping("/goods/goodsPriceHistoryLayerView.do")
	public String goodsPriceHistoryLayerView (Model model ) {
		if(log.isDebugEnabled() ) {
			log.debug("==================================================");
			log.debug("= {}", "Goods Price History Layer");
			log.debug("==================================================");
		}

		return "/goods/goodsPriceHistoryLayerView";
	}


	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: GoodsController.java
	* - 작성일		: 2016. 6. 17.
	* - 작성자		: valueFactory
	* - 설명			: 상품 가격 이력 조회
	* </pre>
	* @param model
	* @param so
	* @return
	*/
	@ResponseBody
	@RequestMapping(value = "/goods/goodsPriceHistoryGrid.do", method = RequestMethod.POST)
	public GridResponse goodsPriceHistoryGrid (Model model, GoodsBaseSO so ) {
		if (log.isDebugEnabled()) {
			log.debug("==================================================");
			log.debug("= {}", "Goods Price History");
			log.debug("==================================================");
		}

		String goodsId = so.getGoodsId();
		List<GoodsPriceVO> list = goodsService.listGoodsPriceHistory(goodsId );

		return new GridResponse(list, so );
	}


	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: GoodsController.java
	* - 작성일		: 2016. 6. 27.
	* - 작성자		: valueFactory
	* - 설명			: 사은품 등록 화면
	* </pre>
	* @param model
	* @return
	*/
	@RequestMapping("/goods/giftGoodsInsertView.do")
	public String giftGoodsInsertView (Model model ) {
		if (log.isDebugEnabled()) {
			log.debug("==================================================");
			log.debug("= {}", "GOODS 등록");
			log.debug("==================================================");
		}

		// 상품 이미지 조회
		List<GoodsImgVO> goodsImgVOList = goodsService.listGoodsImg("");
		model.addAttribute("goodsImg", goodsImgVOList );

		return "/goods/giftGoodsInsertView";
	}


	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: GoodsController.java
	* - 작성일		: 2016. 6. 27.
	* - 작성자		: valueFactory
	* - 설명			: 사은품 등록 화면
	* </pre>
	* @param model
	* @return
	*/
	@RequestMapping("/goods/giftGoodsDetailView.do")
	public String giftGoodsDetailView (Model model, GoodsBaseSO so ) {
		if (log.isDebugEnabled()) {
			log.debug("==================================================");
			log.debug("= {}", "Goods Detail");
			log.debug("==================================================");
			LogUtil.log(so);
		}

		String goodsId = null;
		goodsId = so.getGoodsId();

		// 상품 기본 정보 조회
		GoodsBaseVO goodsBaseVO = goodsService.getGoodsBase(goodsId);
		if (goodsBaseVO == null) {
			// 상품이 존재하지 않습니다.
			throw new CustomException(ExceptionConstants.ERROR_GOODS_NO_DATA);
		}

		// 상품 이미지 조회
		List<GoodsImgVO> goodsImgVOList = goodsService.listGoodsImg(goodsId);

		// 단품 정보 조회
		List<ItemVO> itemList = itemService.listGoodsItem(so.getGoodsId());
		ItemVO item = null;
		if(CollectionUtils.isNotEmpty(itemList)) {
			item = itemList.get(0 );
		}

		// 상품 기본 정보 조회
		model.addAttribute("goodsBase", goodsBaseVO);
		// 상품 이미지
		model.addAttribute("goodsImg", goodsImgVOList );
		// 단품
		model.addAttribute("item", item );

		return "/goods/giftGoodsDetailView";
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: GoodsController.java
	 * - 작성일		: 2020. 01. 17.
	 * - 작성자		: pkt
	 * - 설명		: 사은품 리스트
	 * </pre>
	 *
	 * @param model
	 * @param so
	 * @return
	 */
	@RequestMapping("/goods/giftGoodsListView.do")
	public String giftGoodsListView(Model model, GoodsBaseSO so) {
		if (log.isDebugEnabled()) {
			log.debug("==================================================");
			log.debug("= {}", "Goods Search");
			log.debug("==================================================");
		}

		// 업체사용자일 때 업체번호를 항상 조회조건에 사용하도록 수정함.
		if (StringUtils.equals(CommonConstants.USR_GRP_20, AdminSessionUtil.getSession().getUsrGrpCd())) {

			so.setCompNo(AdminSessionUtil.getSession().getCompNo());
		}

		model.addAttribute("goodsSO", so);
		return "/goods/giftGoodsListView";
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: GoodsController.java
	 * - 작성일		: 2020. 01. 17.
	 * - 작성자		: pkt
	 * - 설명		: 사은품 그리드 리스트
	 * </pre>
	 *
	 * @param so
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/goods/giftGoodsBaseGrid.do", method = RequestMethod.POST)
	public GridResponse giftGoodsBaseGrid(GoodsBaseSO so) {
		if (!StringUtil.isEmpty(so.getGoodsIdArea())) {
			so.setGoodsIds(StringUtil.splitEnter(so.getGoodsIdArea()));
		}

		so.setGoodsTpCd(CommonConstants.GOODS_TP_30);
		
		Session session = AdminSessionUtil.getSession();
		// 업체사용자일 때 업체번호를 항상 조회조건에 사용하도록 수정함.
		if (StringUtils.equals(CommonConstants.USR_GB_2010, AdminSessionUtil.getSession().getUsrGbCd())) {
			// 로그인한(세션) 업체번호와 검색조건(업체명) 업체번호가 같으면 상위업체로만 조회하고, 다르면 하위업체번호를 검색조건으로 사용함.
			// so.setCompNo(session.getCompNo().compareTo(so.getCompNo()) == 0 ? session.getCompNo() : so.getCompNo());

			// 하위업체 포함 검색이면
			//if (StringUtils.equalsIgnoreCase(CommonConstants.COMM_YN_Y, showLowerCompany)) {
			//	so.setUpCompNo(session.getCompNo());
			//}
		} else if (	StringUtils.equals(CommonConstants.USR_GB_2020, AdminSessionUtil.getSession().getUsrGbCd())) {
			so.setCompNo(session.getCompNo());
		}

		List<GoodsBaseVO> list = goodsService.pageGoodsBaseBO(so);
		return new GridResponse(list, so);
	}


	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: GoodsController.java
	 * - 작성일		: 2020. 01. 17.
	 * - 작성자		: pkt
	 * - 설명		: 사은품 수정
	 * </pre>
	 *
	 * @return
	 */
	@RequestMapping(value = "/goods/giftGoodsUpdate.do")
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public String giftGoodsUpdate(
			Model model,
			@RequestParam("goodsBasePO") String goodsBaseStr,
			@RequestParam(value = "goodsImgPO", required = false) String goodsImgStr,
			@RequestParam(value = "stGoodsMapPO", required = false) String stGoodsMapStr, GoodsDescPO goodsDescPO) {

		JsonUtil jsonUt = new JsonUtil();
		GoodsPO goodsPO = new GoodsPO();


		// 상품 기본
		GoodsBasePO goodsBasePO = (GoodsBasePO) jsonUt.toBean(
				GoodsBasePO.class, goodsBaseStr);
		
		goodsBasePO.setGoodsStatCd(CommonConstants.GOODS_STAT_40);		// 판매중
		goodsBasePO.setGoodsTpCd(CommonConstants.GOODS_TP_30); 			// 사은품

		goodsBasePO.setCusReqGoodsYn(CommonConstants.COMM_YN_N);
		goodsBasePO.setClctReqPsbYn(CommonConstants.COMM_YN_N);
		goodsBasePO.setPrcCmprLnkYn(CommonConstants.COMM_YN_N);
		
		goodsPO.setGoodsBasePO(goodsBasePO);

		// 상품 이미지
		List<GoodsImgPO> goodsImgPOList = null;
		if (!StringUtil.isEmpty(goodsImgStr)) {
			goodsImgPOList = jsonUt.toArray(GoodsImgPO.class, goodsImgStr);
			goodsPO.setGoodsImgPOList(goodsImgPOList);
		}


		// 상품과 사이트 정보 매핑
		List<StGoodsMapPO> stGoodsMapPOList = null;
		if(!StringUtil.isEmpty(stGoodsMapStr)){
			stGoodsMapPOList = jsonUt.toArray(StGoodsMapPO.class, stGoodsMapStr);
			goodsPO.setStGoodsMapPOList(stGoodsMapPOList);
		}

		// 상품 수정
		String goodsId = goodsService.updateGiftGoods(goodsPO);
		model.addAttribute("goodsId", goodsId);

		if (log.isDebugEnabled()) {
			log.debug("==================================================");
			log.debug("사은품 상품 수정 : {}", goodsId);
			log.debug("==================================================");
		}

		return View.jsonView();
	}

	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: GoodsController.java
	* - 작성일		: 2016. 6. 28.
	* - 작성자		: valueFactory
	* - 설명			: 상품 이미지 VIEW
	* </pre>
	* @param model
	* @param so
	* @return
	*/
	@RequestMapping("/goods/goodsImageLayerView.do")
	public String goodsImageLayerView (Model model, GoodsImgSO so ) {

		GoodsImgVO goodsImg = goodsService.getGoodsImage(so );

		String imgPath = null;

		if(goodsImg != null ) {
			imgPath = goodsImg.getImgPath();
		}

		List<GoodsImgVO> imgList = null;
		if(StringUtil.isNotEmpty(imgPath) ) {
			imgList = new ArrayList<>();
			for(String[] size : ImageType.GOODS_OPT_IMAGE.imageSizeList() ) {
				GoodsImgVO tempImg = new GoodsImgVO();
				tempImg.setImgPath(imgPath);
				tempImg.setImgOption(size[0]);
				tempImg.setImgSize(size[1]+"x"+size[2] );
				imgList.add(tempImg );
			}
		}

		model.addAttribute("imgList", imgList );
		model.addAttribute("goodsSO", so);

		return "/goods/goodsImageLayerView";
	}


	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: GoodsController.java
	 * - 작성일		: 2016. 9. 06.
	 * - 작성자		: hjko
	 * - 설명			: 세일 상품 리스트
	 * </pre>
	 *
	 * @param model
	 * @param so
	 * @return
	 */
	@RequestMapping("/goods/goodsSalePriceListView.do")
	public String goodsSalePriceListView(Model model, GoodsBaseSO so) {
		if (log.isDebugEnabled()) {
			log.debug("==================================================");
			log.debug("= {}", "goodsSalePriceList ");
			log.debug("==================================================");
		}

		// 업체사용자일 때 업체번호를 항상 조회조건에 사용하도록 수정함.
		if (StringUtils.equals(CommonConstants.USR_GRP_20, AdminSessionUtil.getSession().getUsrGrpCd())) {

			so.setCompNo(AdminSessionUtil.getSession().getCompNo());
		}

		model.addAttribute("goodsSO", so);
		return "/goods/goodsSalePriceListView";
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: GoodsController.java
	 * - 작성일		: 2016. 9. 07.
	 * - 작성자		: hjko
	 * - 설명			: 세일중인 상품 리스트
	 * </pre>
	 *
	 * @param so
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/goods/saleGoodsBaseGrid.do", method = RequestMethod.POST)
	public GridResponse saleGoodsBaseGrid(GoodsBaseSO so) {
		if (!StringUtil.isEmpty(so.getGoodsIdArea())) {
			so.setGoodsIds(StringUtil.splitEnter(so.getGoodsIdArea()));
		}

		if (!StringUtil.isEmpty(so.getGoodsNmArea())) {
			so.setGoodsNms(StringUtil.splitEnter(so.getGoodsNmArea()));
		}

		if (!StringUtil.isEmpty(so.getMdlNmArea())) {
			so.setMdlNms(StringUtil.splitEnter(so.getMdlNmArea()));
		}

//		if (!StringUtil.isEmpty(so.getBomCdArea())) {
//			so.setBomCds(StringUtil.splitEnter(so.getBomCdArea()));
//		}

		// 업체사용자일 때 업체번호를 항상 조회조건에 사용하도록 수정함.
		if (StringUtils.equals(CommonConstants.USR_GRP_20, AdminSessionUtil.getSession().getUsrGrpCd())) {

			so.setCompNo(AdminSessionUtil.getSession().getCompNo());
		}

		List<GoodsBaseVO> list = goodsService.pageSaleGoodsBase(so);
		return new GridResponse(list, so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: GoodsController.java
	 * - 작성일		: 2016. 9. 07.
	 * - 작성자		: hjko
	 * - 설명			: 세일 상품 가격 일괄 업데이트
	 * </pre>
	 *
	 * @param model
	 * @param so
	 * @return
	 */
	@RequestMapping("/goods/goodsSalePriceBatchUpdate.do")
	public String goodsSalePriceBatchUpdate(Model model, GoodsBaseSO so) {
		if (log.isDebugEnabled()) {
			log.debug("==================================================");
			log.debug("= {}", "Goods goodsSalePriceBatchUpdate");
			log.debug("==================================================");
		}

		// 세일가의 종료일시세팅
		Timestamp saleEndDtm = DateUtil.convertSearchDate("E",so.getSaleUpdateEndDate());

		DateFormat formatter = new SimpleDateFormat(CommonConstants.COMMON_DATE_FORMAT);
		Date date = null;
		try {
			date = formatter.parse(DateUtil.getTimestampToString(saleEndDtm, CommonConstants.COMMON_DATE_FORMAT));
		} catch (ParseException e){
			throw new CustomException( ExceptionConstants.ERROR_CODE_DEFAULT );
		}

		// 세일가 다음의 일반 가격의 시작일시세팅
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		calendar.add(Calendar.SECOND,+1);
		String startTime = DateUtil.getFormatDate(calendar, CommonConstants.COMMON_DATE_FORMAT);
		Timestamp saleStrtDtm =  DateUtil.getTimestamp(startTime, CommonConstants.COMMON_DATE_FORMAT);

		String[] goodsIds = so.getGoodsIds();
		long cntTotal = goodsIds.length;  // 총갯수

		long cntSuccess = 0; // 성공한 갯수
		long cntFail = 0; //실패한 갯수

		List<GoodsPricePO> list = new ArrayList<>();

		for (String goodsId : goodsIds) {

			GoodsPriceSO dso = new GoodsPriceSO();
			dso.setGoodsId(goodsId);
			dso.setSaleStrtDtm(saleStrtDtm);

			List<GoodsPriceVO> result =  goodsService.getNextPrice(dso);

			if(CollectionUtils.isNotEmpty(result)){
				for(GoodsPriceVO m : result){
					if(m.getGoodsId() != null){
						GoodsPricePO s = new GoodsPricePO();
						s.setGoodsId(m.getGoodsId());
						s.setSaleEndDtm(saleEndDtm);
						s.setSaleStrtDtm(saleStrtDtm);
						list.add(s);
					}
				}
			}
		}

		if(CollectionUtils.isNotEmpty(list)){
			cntSuccess = goodsService.updateSalePeriod(list);
		}
		cntFail = cntTotal - cntSuccess;
		log.debug("==================================================");
		log.debug("＃＃＃＃＃＃＃＃＃ 총 갯수 :"+ cntTotal);
		log.debug("＃＃＃＃＃＃＃＃＃ 가격 수정 성공한 갯수 :"+ cntSuccess);
		log.debug("＃＃＃＃＃＃＃＃＃ 가격 수정 실패한 갯수 :"+ cntFail);
		log.debug("==================================================");


		so.setCntTotal(cntTotal);
		so.setCntSuccess(cntSuccess);
		so.setCntFail(cntFail);

		model.addAttribute(so);

		return View.jsonView();

	}

	@ResponseBody
	@RequestMapping(value = "/goods/checkGoodsNmDup.do", method = RequestMethod.POST)
	public Map<String, String> checkGoodsNmDup(GoodsBaseSO so) {

		Map<String, String> result = new HashMap<>();

		if (log.isDebugEnabled()) {
			log.debug("########## : {} ", so.toString());
		}

		if (!StringUtil.isEmpty(so.getGoodsIdArea())) {
			so.setGoodsIds(StringUtil.splitEnter(so.getGoodsIdArea()));
		}

		if (!StringUtil.isEmpty(so.getGoodsNmArea())) {
			so.setGoodsNms(StringUtil.splitEnter(so.getGoodsNmArea()));
		}

		List<GoodsBaseVO> list = goodsService.pageGoodsBase(so);

		if (CollectionUtils.isNotEmpty(list)) {
			result.put("dupYn", CommonConstants.COMM_YN_Y);
		} else {
			result.put("dupYn", CommonConstants.COMM_YN_N);
		}

		return result;
	}

	@ResponseBody
	@RequestMapping(value="/goods/goodsCompDispMapListGrid.do", method=RequestMethod.POST)
	public GridResponse goodspCompDispMapListGrid(GoodsBaseSO so) {
		if (log.isDebugEnabled()) {
			log.debug("########## : {} ", so.toString());
		}
		String goodsId = so.getGoodsId();
		Long compNo = so.getCompNo();

		so.setGoodsId(goodsId);
		so.setCompNo(compNo);

		List<DisplayCategoryVO> list = goodsService.listCompDispMapGoods(so);

		return new GridResponse(list, so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: GoodsController.java
	 * - 작성일		: 2017. 5. 19.
	 * - 작성자		: valueFactory
	 * - 설명			:  attribute 목록 조회
	 * </pre>
	 *
	 * @return
	 */
	@RequestMapping("/goods/listAttribute.do")
	public String listAttribute(Model model){

		if (log.isDebugEnabled()) {
			log.debug("==================================================");
			log.debug("= {}", "listAttribute");
			log.debug("==================================================");
		}
		List<AttributeValueVO> result = new ArrayList<>();
		List<AttributeValueVO> aresult = new ArrayList<>();

		// 속성 attribute 조회
		AttributeSO so = new AttributeSO();
		so.setUseYn("Y");
		List<AttributeValueVO> bfresult = itemService.listAttribute(so);
		for(AttributeValueVO m : bfresult){
			AttributeValueVO t = new AttributeValueVO();
			t.setAttrNo(m.getAttrNo());
			t.setAttrNm(m.getAttrNm());
			t.setAttrValNo(m.getAttrValNo()+1);
			result.add(t);
		}
		AttributeValueVO temp = new AttributeValueVO();
		temp.setAttrNo(0L);
		temp.setAttrNm("선택");
		temp.setAttrValNo(0);
		aresult.add(temp);
		result.addAll(0,aresult);

		model.addAttribute("result", result);
		return View.jsonView();
	}

	@RequestMapping("/goods/optionCreatePopView.do")
	public String optionCreatePopView(Model model ){

		return "/goods/optionCreatePopView";
	}
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: GoodsController.java
	 * - 작성일		: 2017. 5. 24.
	 * - 작성자		: valueFactory
	 * - 설명			:  attribute 생성작업
	 * </pre>
	 *
	 * @return
	 */
	@RequestMapping("/goods/saveNewOption.do")
	public String saveNewOption(Model model,  AttributePO po){
		if (log.isDebugEnabled()) {
			log.debug("==================================================");
			log.debug("= {}", "saveNewOption");
			log.debug("==================================================");
		}
		// 새로 등록한 옵션이 기존에 있는지 확인,

		List<AttributeVO> rs = attributeService.checkAttributeExist(po);
		//log.debug("size>"+rs.size());
		if(CollectionUtils.isNotEmpty(rs)){

			model.addAttribute("result", rs);

		}else{

			// 새로 옵션 등록하기
			Long attrNo = null;
			po.setUseYn(CommonConstants.COMM_YN_Y);
			attrNo = attributeService.insertNewAttribute(po);

			log.debug("새로 등록된 attrNo >"+attrNo);
			model.addAttribute("result", "");

		}

		return View.jsonView();
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: GoodsController.java
	 * - 작성일		: 2017. 5. 29.
	 * - 작성자		: valueFactory
	 * - 설명			:  attributeVal 최대값 조회
	 * </pre>
	 *
	 * @return
	 */
	@RequestMapping("/goods/getMaxAttributeValue.do")
	public String getMaxAttributeValue(Model model, Long attrNo){

		if (log.isDebugEnabled()) {
			log.debug("==================================================");
			log.debug("= {}", "getMaxAttributeValue");
			log.debug("==================================================");
		}
		Integer result = 0 ;
		// 속성 attribute 조회
		AttributeSO so = new AttributeSO();
		so.setAttrNo(attrNo);
		so.setUseYn(CommonConstants.COMM_YN_Y);
		result= itemService.getMaxAttributeValue(so);

		log.debug("result"+result);
		model.addAttribute("result", result);
		return View.jsonView();
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: GoodsController.java
	 * - 작성일		: 2017. 8. 31.
	 * - 작성자		: valueFactory
	 * - 설명			:  attributeVal SEQUENCE 조회(ATTR_NO 에 대한)
	 * </pre>
	 *
	 * @return
	 */
	@RequestMapping("/goods/getSeqAttrValNo.do")
	public String getSeqAttrValNo(Model model, Long attrNo){

		if (log.isDebugEnabled()) {
			log.debug("==================================================");
			log.debug("= {}", "getSeqAttrValNo");
			log.debug("==================================================");
		}
		// 속성 attribute 조회
		AttributeSO so = new AttributeSO();
		so.setAttrNo(attrNo);
		so.setUseYn(CommonConstants.COMM_YN_Y);

		Long result = itemService.getSeqAttrValNo(so);

		log.debug("result"+result);
		model.addAttribute("result", result);
		return View.jsonView();
	}
	
	/**
	 *
	* <pre>
	* - 프로젝트명   : 41.admin.web
	* - 패키지명   : admin.web.view.goods.controller
	* - 파일명      : GoodsController.java
	* - 작성일      : 2017. 6. 15.
	* - 작성자      : valuefactory 권성중
	* - 설명      :  상품 수수료율
	* </pre>
	*/
	@RequestMapping("/goods/goodsCmsRatePopView.do")
	public String goodsCmsRatePopView(Model model, GoodsBaseSO so) {
		// 상품 현재 가격 정보 조회
		GoodsPriceVO goodsPriceVO = goodsPriceService.getCurrentGoodsPrice(so.getGoodsId());

		model.addAttribute("goodsBase", goodsPriceVO);

		return "/goods/goodsCmsRatePopView";
	}
	
	/**
	 *
	* <pre>
	* - 프로젝트명   : 41.admin.web
	* - 패키지명   : admin.web.view.goods.controller
	* - 파일명      : GoodsController.java
	* - 작성일      : 2017. 6. 15.
	* - 작성자      : valuefactory 권성중
	* - 설명      :  상품 수수료율 그리드
	* </pre>
	 */
	@ResponseBody
	@RequestMapping(value="/goods/goodsCmsRatePopViewGrid.do", method = RequestMethod.POST)
	public GridResponse goodsCmsRatePopViewGrid(Model model, StGoodsMapSO so) {

		List<StGoodsMapVO> goodsCmsRateList = goodsService.listStStdInfoGoods(so);

		return new GridResponse(goodsCmsRateList, so);
	}

	/**
	 *
	* <pre>
	* - 프로젝트명   : 41.admin.web
	* - 패키지명   : admin.web.view.goods.controller
	* - 파일명      : GoodsController.java
	* - 작성일      : 2017. 6. 15.
	* - 작성자      : valuefactory 권성중
	* - 설명      :  수수료율 수정
	* </pre>
	 */
	@RequestMapping(value = "/goods/updateStGoodsMap.do")
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public String updateStGoodsMap (Model model,
			@RequestParam(value = "stGoodsMapPO", required = false) String stGoodsMapPOStr ) {

		JsonUtil jsonUt = new JsonUtil();

		List<StGoodsMapPO> stGoodsMapPOList = null;
		if(StringUtil.isNotEmpty(stGoodsMapPOStr) ) {
			stGoodsMapPOList = jsonUt.toArray(StGoodsMapPO.class, stGoodsMapPOStr );
		}

		int rtn  = goodsService.updateStGoodsMap( stGoodsMapPOList  );

		if(rtn > 0){
			model.addAttribute("rtn", "S" );
		}else{
			model.addAttribute("rtn", "F" );
		}
		return View.jsonView();
	}

	@RequestMapping("/goods/compCmsRatePopView.do")
	public String compCmsRatePopView(Model model, GoodsBaseSO so) {
		GoodsBaseVO goodsBaseVO = new GoodsBaseVO();
		goodsBaseVO.setCompNo(so.getCompNo());
		goodsBaseVO.setSaleAmt(so.getSaleAmt());

		model.addAttribute("goodsBase", goodsBaseVO);

		return "/goods/compCmsRatePopView";
	}
	/**
	 *
	* <pre>
	* - 프로젝트명   : 41.admin.web
	* - 패키지명   : admin.web.view.goods.controller
	* - 파일명      : GoodsController.java
	* - 작성일      : 2017. 6. 15.
	* - 작성자      : valuefactory 권성중
	* - 설명      :  상품 수수료율 그리드
	* </pre>
	 */
	@ResponseBody
	@RequestMapping(value="/goods/compCmsRatePopViewGrid.do", method = RequestMethod.POST)
	public GridResponse compCmsRatePopViewGrid(Model model, StGoodsMapSO so) {

		List<StStdInfoVO> compCmsRateList = goodsService.listCompCmsRate(so);

		return new GridResponse(compCmsRateList, so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 패키지명   : admin.web.view.goods.controller
	 * - 파일명      : GoodsController.java
	 * - 작성일		: 2017. 6. 27.
	 * - 작성자		: hongjun
	 * - 설명		: 옵션 목록 화면
	 * </pre>
	 * @return
	 */
	@RequestMapping("/goods/attributeListView.do")
	public String attributeListView() {
		return "/goods/attributeListView";
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 패키지명   : admin.web.view.goods.controller
	 * - 파일명      : GoodsController.java
	 * - 작성일		: 2017. 6. 27.
	 * - 작성자		: hongjun
	 * - 설명		: 옵션 그리드
	 * </pre>
	 * @param so
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/goods/attributeGrid.do", method=RequestMethod.POST)
	public GridResponse attributeGrid(AttributeSO so) {
		List<AttributeVO> list = itemService.pageAttribute(so);
		return new GridResponse(list, so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 패키지명   : admin.web.view.goods.controller
	 * - 파일명      : GoodsController.java
	 * - 작성일		: 2017. 6. 27.
	 * - 작성자		: hongjun
	 * - 설명		: 옵션 상세 화면
	 * </pre>
	 * @param model
	 * @param so
	 * @return
	 */
	@RequestMapping("/goods/attributeView.do")
	public String attributeView(Model model, AttributeSO so) {
		model.addAttribute("attribute", itemService.getAttribute(so));

		return "/goods/attributeView";
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 패키지명   : admin.web.view.goods.controller
	 * - 파일명      : GoodsController.java
	 * - 작성일		: 2017. 6. 27.
	 * - 작성자		: hongjun
	 * - 설명		: 옵션 등록
	 * </pre>
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/goods/insertAttribute.do", method=RequestMethod.POST)
	public String insertAttribute(Model model, AttributePO po) {
		if (po.getAttrNo() == null) {
			Long attrNo = bizService.getSequence(AdminConstants.SEQUENCE_ATTRIBUTE_SEQ );
			po.setAttrNo(attrNo);
		}
		itemService.insertAttribute(po);
		model.addAttribute("attribute", po);
		return View.jsonView();
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 패키지명   : admin.web.view.goods.controller
	 * - 파일명      : GoodsController.java
	 * - 작성일		: 2017. 6. 27.
	 * - 작성자		: hongjun
	 * - 설명		: 옵션 삭제
	 * </pre>
	 * @param model
	 * @return
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value="/goods/deleteAttribute.do", method=RequestMethod.POST)
	public String deleteAttribute(Model model
			, @RequestParam(value = "attributeItemPO", required = false) String attributeItemPOStr) {
		int delCnt = 0;

		JsonUtil jsonUtil = new JsonUtil();

		List<AttributePO> attributeItemPOList = null;
		if (!StringUtil.isEmpty(attributeItemPOStr)) {
			attributeItemPOList = jsonUtil.toArray(AttributePO.class, attributeItemPOStr);

			for (AttributePO attributePO : attributeItemPOList) {
				delCnt += itemService.deleteAttribute(attributePO);
			}
		}

		model.addAttribute("delCnt", delCnt);
		return View.jsonView();
	}

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-41-admin
	* - 파일명	: GoodsController.java
	* - 작성일	: 2021. 2. 10.
	* - 작성자 	: valfac
	* - 설명 		: 상품 평가 레이어 팝업
	* </pre>
	*
	* @param model
	* @return
	*/
	@RequestMapping("/goods/goodsEstmLayerView.do")
	public String goodsEstmLayerView (Model model ) {
		return "/goods/goodsEstmLayerView";
	}
	
	/**
	* <pre>
	* - 프로젝트명	: gs-apet-41-admin
	* - 파일명	: GoodsController.java
	* - 작성일	: 2021. 2. 15.
	* - 작성자 	: valfac
	* - 설명 		: 상품 평가  카테고리 매핑 리스트
	* </pre>
	*
	* @param model
	* @param so
	* @return
	*/
	@ResponseBody
	@RequestMapping(value = "/goods/listGoodsEstmCategoryMap.do", method = RequestMethod.POST)
	public GridResponse listGoodsEstmCategoryMap(Model model, GoodsEstmQstCtgMapSO so) {

		List<GoodsEstmQstVO> list = goodsEstmService.listGoodsEstmQstCtgMap(so);

		return new GridResponse(list, so);
	}
	
	/**
	* <pre>
	* - 프로젝트명	: gs-apet-41-admin
	* - 파일명	: GoodsController.java
	* - 작성일	: 2021. 07. 29.
	* - 작성자 	: KKB
	* - 설명 	: 상품 수정 가능 카운트
	* </pre>
	*
	* @param model
	* @param so
	* @return
	*/
	@ResponseBody
	@RequestMapping(value = "/goods/checkPossibleCnt.do", method = RequestMethod.POST)
	public GoodsBaseVO checkPossibleCnt(Model model, String goodsId) {
		return goodsService.checkPossibleCnt(goodsId);
	}
}