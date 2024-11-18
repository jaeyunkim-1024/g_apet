package front.web.view.brand.controller;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Objects;
import java.util.Properties;
import java.util.Set;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import biz.app.brand.model.BrandBaseSO;
import biz.app.brand.model.BrandBaseVO;
import biz.app.brand.model.BrandInitialVO;
import biz.app.brand.model.BrandSO;
import biz.app.brand.service.BrandService;
import biz.app.display.model.DisplayCategoryVO;
import biz.app.display.model.DisplayCornerItemSO;
import biz.app.display.model.DisplayCornerTotalVO;
import biz.app.display.model.SeoInfoSO;
import biz.app.display.model.SeoInfoVO;
import biz.app.display.service.DisplayService;
import biz.app.display.service.SeoService;
import biz.app.goods.model.GoodsDispSO;
import biz.app.goods.model.GoodsDispVO;
import biz.app.goods.model.GoodsDtlInqrHistSO;
import biz.app.goods.service.GoodsDispService;
import biz.app.goods.service.GoodsDtlInqrHistService;
import biz.app.member.model.MemberInterestBrandPO;
import biz.app.member.service.MemberInterestBrandService;
import biz.app.system.model.CodeDetailSO;
import biz.app.system.model.CodeDetailVO;
import biz.app.system.service.CodeService;
import framework.common.annotation.LoginCheck;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
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


/**
* <pre>
* - 프로젝트명	: 31.front.web
* - 패키지명	: front.web.view.brand.controller
* - 파일명		: BrandController.java
* - 작성일		: 2016. 3. 2.
* - 작성자		: snw
* - 설명		: 브랜드 Controller
* </pre>
*/
@Slf4j
@Controller
@RequestMapping("brand")
public class BrandController {
	
	@Autowired private BrandService brandService;
	@Autowired private DisplayService displayService;
	@Autowired private CodeService codeService;
	@Autowired private MemberInterestBrandService memberInterestBrandService;
	@Autowired private GoodsDispService goodsDispService;
	@Autowired private GoodsDtlInqrHistService goodsDtlInqrHistService;
	@Autowired private SeoService seoService;

	@Autowired private Properties webConfig;
	@Autowired private NhnShortUrlUtil NhnShortUrlUtil;
	
	/**
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명		: BrandController.java
	* - 작성일		: 2016. 4. 15.
	* - 작성자		: snw
	* - 설명		: 시리즈/브랜드 화면
	* </pre>
	* @param map
	* @param session
	* @param view
	* @return
	* @throws Exception
	*/
	@RequestMapping(value="indexBrand")
	public String indexBrand(ModelMap map, Session session, ViewBase view){
		
		// 3depth 카테고리 조회
		List<DisplayCategoryVO> subCateList = view.getDisplayCategoryList().stream()
				.filter(item -> Objects.equals(item.getDispLvl(), 3L))
				.collect(Collectors.toList());
				
		List<Long> dispClsfNos = new ArrayList<>();
		for (DisplayCategoryVO cate : subCateList) {
			dispClsfNos.add(cate.getDispClsfNo());
		}
		
		// 1. TOP5 브랜드
		Long topDispClsfNo = Long.valueOf(webConfig.getProperty("disp.clsf.no.topbrand"));
		List<DisplayCornerTotalVO> list = displayService.getDisplayCornerItemTotalFO(topDispClsfNo, null);
		
		if (CollectionUtils.isNotEmpty(list) && list.get(0).getDispCornTpCd().equals(CommonConstants.DISP_CORN_TP_20))
			map.put("topBrandList", list.get(0).getListBanner());
		
		
		// 2. 카테고리별 브랜드 리스트
		BrandSO so = new BrandSO();
		so.setDispClsfNos(dispClsfNos);
		so.setStId(view.getStId());
		List<DisplayCategoryVO> brandList = brandService.listBrandByDisplayCategory(so);
				
		// 3. 브랜드 초성 리스트
		List<CodeDetailVO> initCharList = brandService.listBrandInitChar();
		List<CodeDetailVO> initCharKoCdList = initCharList.stream()
							.filter(item -> Objects.equals(item.getUsrDfn1Val(), CommonConstants.INIT_CHAR_GB_KO))
							.collect(Collectors.toList());
		List<CodeDetailVO> initCharEnCdList = initCharList.stream()
				.filter(item -> Objects.equals(item.getUsrDfn1Val(), CommonConstants.INIT_CHAR_GB_EN))
				.collect(Collectors.toList());
	
		
		// 4. 초성 첫 글자 브랜드 리스트
		List<BrandInitialVO> brandInitList = brandService.listBrandByInitChar(so);
		
		map.put("brandList", brandList);
		map.put("koInitList", initCharKoCdList);
		map.put("enInitList", initCharEnCdList);
		map.put("brandInitList", brandInitList);
		
		view.setTitle("BRAND");
		map.put("session", session);
		map.put("view", view);
		
		return TilesView.popup(new String[]{"brand", "indexBrand"}); 
	}

	/**
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명		: BrandController.java
	* - 작성일		: 2016. 4. 15.
	* - 작성자		: snw
	* - 설명		: 브랜드 목록 화면
	* </pre>
	* @param map
	* @param session
	* @param view
	* @param bndNo
	* @return
	* @throws Exception
	*/
	@RequestMapping(value="indexBrandList")
	public String indexBrandList(ModelMap map, Session session, ViewBase view, BrandBaseSO so){
		
		//Site ID 조건
		so.setStId(view.getStId());
		
		map.put("params", so);
		String paramInitCharCd = so.getInitCharCd();
		String paramInitCharGb = so.getInitCharGb();
		
		//브랜드 국문
		so.setInitCharGb(CommonConstants.INIT_CHAR_GB_KO);
		List<BrandBaseSO> brandListKo = brandService.listBrand(so);
		int brandKoCnt = brandListKo.size();
		List<String> charKoList = new ArrayList<>();
		String initCharChk = "";
		for(int i=0;i < brandKoCnt;i++){
			BrandBaseSO vo = brandListKo.get(i);
			if(!initCharChk.equals(vo.getCharCdKo())){
				initCharChk = vo.getCharCdKo();
				charKoList.add(vo.getCharNmKo());
			}
		}
		map.put("charKoList", charKoList);
		map.put("brandListKo", brandListKo);
		
		//브랜드 영문
		so.setInitCharGb(CommonConstants.INIT_CHAR_GB_EN);
		List<BrandBaseSO> brandListEn = brandService.listBrand(so);
		int brandEnCnt = brandListEn.size();
		List<String> charEnList = new ArrayList<>();
		initCharChk = "";
		for(int i=0;i < brandEnCnt;i++){
			BrandBaseSO vo = brandListEn.get(i);
			if(!initCharChk.equals(vo.getCharCdEn())){
				initCharChk = vo.getCharCdEn();
				charEnList.add(vo.getCharNmEn());
			}
		}
		map.put("charEnList", charEnList);
		map.put("brandListEn", brandListEn);
		
		//초성검색 시 조회결과가 없을 경우 처리
		if(paramInitCharCd != null && !"".equals(paramInitCharCd)){
			if(paramInitCharGb != null && CommonConstants.INIT_CHAR_GB_EN.equals(paramInitCharGb) && CollectionUtils.isEmpty(charEnList)){
				CodeDetailSO codeSo = new CodeDetailSO();
				codeSo.setGrpCd(CommonConstants.INIT_CHAR);
				codeSo.setDtlCd(paramInitCharCd);
				CodeDetailVO vo = codeService.getCodeDetail(codeSo);				
				charEnList.add(vo.getDtlNm());
			}else if(paramInitCharGb != null && CommonConstants.INIT_CHAR_GB_KO.equals(paramInitCharGb) && CollectionUtils.isEmpty(charKoList)){
				CodeDetailSO codeSo = new CodeDetailSO();
				codeSo.setGrpCd(CommonConstants.INIT_CHAR);
				codeSo.setDtlCd(paramInitCharCd);
				CodeDetailVO vo = codeService.getCodeDetail(codeSo);				
				charKoList.add(vo.getDtlNm());
			}			
		}
		
		return TilesView.none(new String[]{"brand", "indexBrandList"});  
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명		: BrandController.java
	* - 작성일		: 2016. 4. 15.
	* - 작성자		: snw
	* - 설명		: 브랜드 상세 화면
	* </pre>
	* @param map
	* @param session
	* @param view
	* @param bndNo
	* @return
	* @throws Exception
	*/
	@RequestMapping(value="indexBrandDetail")
	public String indexBrandDetail(HttpServletRequest request, ModelMap map, Session session, ViewBase view, Long bndNo, BrandBaseSO so) {
		
		if(bndNo == null){
			throw new CustomException(ExceptionConstants.ERROR_PARAM);
		}
		// LNB로 전시 번호로 넘어올 경우	-> dispClsfNo2로
		// 마이찜리스트에서 넘어올 경우 -> session으로
		// 상품 상세에서 넘어올 경우 -> 그값 그대로
		String dlgtPetGbCd = "";
		// LNB 변경에서 넘어올 경우 -> bndNo, lnbDispClsfNo -> cateCdL필요
		if(!StringUtil.isEmpty(so.getLnbDispClsfNo())) {
			// LNB 반려동물(강아지/고양이) 변경처리
			if(!session.getMbrNo().equals(CommonConstants.NO_MEMBER_NO)) {
				dlgtPetGbCd = displayService.updatePetGbCdLnbHistory(so.getLnbDispClsfNo(), session.getMbrNo());
				session.setPetGbCd(dlgtPetGbCd);
			}
			// cateCdL -> 설정
			if(Long.valueOf(webConfig.getProperty("disp.clsf.no.petshop.dog")).equals(so.getLnbDispClsfNo())) {
				so.setCateCdL(Long.valueOf(webConfig.getProperty("disp.clsf.no.dog")));
			} else if (Long.valueOf(webConfig.getProperty("disp.clsf.no.petshop.cat")).equals(so.getLnbDispClsfNo())) {
				so.setCateCdL(Long.valueOf(webConfig.getProperty("disp.clsf.no.cat")));
			} else if (Long.valueOf(webConfig.getProperty("disp.clsf.no.petshop.fish")).equals(so.getLnbDispClsfNo())) {
				so.setCateCdL(Long.valueOf(webConfig.getProperty("disp.clsf.no.fish")));
			} else if (Long.valueOf(webConfig.getProperty("disp.clsf.no.petshop.animal")).equals(so.getLnbDispClsfNo())) {
				so.setCateCdL(Long.valueOf(webConfig.getProperty("disp.clsf.no.animal")));
			} 
			view.setDispClsfNo(so.getLnbDispClsfNo());
		}else {
			// bndNo으로 넘어올 경우
			if(!StringUtil.isEmpty(session.getDispClsfNo())) {
				view.setDispClsfNo(session.getDispClsfNo());
			}else {
				view.setDispClsfNo(Long.valueOf(webConfig.getProperty("disp.clsf.no.petshop.dog")));
			}
			
			if(StringUtil.isEmpty(so.getCateCdL())) {
				// cateCdL -> 설정
				if(Long.valueOf(webConfig.getProperty("disp.clsf.no.petshop.dog")).equals(view.getDispClsfNo())) {
					so.setCateCdL(Long.valueOf(webConfig.getProperty("disp.clsf.no.dog")));
				} else if (Long.valueOf(webConfig.getProperty("disp.clsf.no.petshop.cat")).equals(view.getDispClsfNo())) {
					so.setCateCdL(Long.valueOf(webConfig.getProperty("disp.clsf.no.cat")));
				} else if (Long.valueOf(webConfig.getProperty("disp.clsf.no.petshop.fish")).equals(view.getDispClsfNo())) {
					so.setCateCdL(Long.valueOf(webConfig.getProperty("disp.clsf.no.fish")));
				} else if (Long.valueOf(webConfig.getProperty("disp.clsf.no.petshop.animal")).equals(view.getDispClsfNo())) {
					so.setCateCdL(Long.valueOf(webConfig.getProperty("disp.clsf.no.animal")));
				}
			}
		}		
		// session에 현재 전시카테고리 번호 넣기
		session.setDispClsfNo(view.getDispClsfNo());
		FrontSessionUtil.setSession(session); 
		
//		so.setUseYn("Y");
		so.setStId(view.getStId());
		so.setMbrNo(session.getMbrNo());
		// 1. 브랜드 기본 정보 조회
		BrandBaseVO brand = brandService.getBrandDetail(so);
		// LNB ICON 리스트
		DisplayCornerItemSO dciSo = new DisplayCornerItemSO();
		dciSo.setDispClsfNo(view.getDispClsfNo());
		dciSo.setDispCornTpCd(CommonConstants.DISP_CORN_TP_30);
		view.setDisplayShortCutList(this.displayService.getBnrImgListFO(dciSo));

		GoodsDispSO gso = new GoodsDispSO();
		String deviceGb = view.getDeviceGb();
		gso.setStId(view.getStId());
		gso.setMbrNo(session.getMbrNo());
		gso.setDeviceGb(deviceGb);
		gso.setDispClsfNo(so.getCateCdL());
		gso.setBndNo(bndNo);
		gso.setSalePeriodYn(CommonConstants.COMM_YN_N);
		gso.setSaleOutYn(CommonConstants.COMM_YN_Y);
		
		List<GoodsDispVO> brandGoodsCategoryList = goodsDispService.getGoodsCategoryBrand(gso);
		int goodsCount = goodsDispService.countBrandGoods(gso);
		
		Set<GoodsDispVO> categorySet = new LinkedHashSet<>();
		if(brandGoodsCategoryList.size() > 0) {
			List<String> cateCdMStr = brandGoodsCategoryList.stream().map(GoodsDispVO::getCateCdMStr).collect(Collectors.toList());
			List<String> cateNmMStr = brandGoodsCategoryList.stream().map(GoodsDispVO::getCateNmM).collect(Collectors.toList());
			int idx = 0;
			for(String cateCdMarr : cateCdMStr) {
				String[] cateCdMs = cateCdMarr.split(",");
				String[] cateNmMs = cateNmMStr.get(idx).split(",");
				int cateIdx = 0;
				for(String cateCdM : cateCdMs) {
					String cateNmM = cateNmMs[cateIdx];
					GoodsDispVO category = new GoodsDispVO();
					category.setCateSeq(Long.parseLong(cateCdM.split("_")[0]));
					category.setCateCdM(Long.parseLong(cateCdM.split("_")[1]));
					category.setCateNmM(cateNmM.split("_")[1]);
					categorySet.add(category);
					cateIdx ++;
				}
				idx ++;
			}
		}
		
		ArrayList categoryList = new ArrayList(categorySet.stream().sorted(Comparator.comparing(GoodsDispVO::getCateSeq)).collect(Collectors.toList()));
		view.setSeoSvcGbCd(FrontWebConstants.SEO_SVC_GB_CD_10);

		// 공유하기
		String shortUrl = null;
		try {
			shortUrl = NhnShortUrlUtil.getUrl(view.getStDomain()+"/brand/brandShareView?bndNo="+so.getBndNo()+"&cateCdL="+so.getCateCdL());
		} catch (Exception e) {

		}

		map.put("shareUrl", shortUrl);
		map.put("brand", brand);
		map.put("categoryList", categoryList);
		map.put("goodsCount", goodsCount);
		map.put("session", session);
		map.put("view", view);
		map.put("so", so);
		
		return TilesView.none(new String[] { "brand", "indexBrandDetail" });
	}
	
	/**
	* <pre>
	* - 프로젝트명	: gs-apet-31-front
	* - 파일명		: BrandController.java
	* - 작성일		: 2021. 7. 14.
	* - 작성자		: pcm
	* - 설명		: 브랜드관 공유하기
	* </pre>
	* @param map
	* @param session
	* @param view
	* @param bndNo
	* @param cateCdL
	* @return
	*/
	@RequestMapping(value = "brandShareView")
	public String brandShareView(ModelMap map, Session session, ViewBase view, 
			@RequestParam(value="bndNo",required=false)String bndNo, 
			@RequestParam(value="cateCdL",required=false)String cateCdL) {
		String title = "";
		String imgPath = "";
		String desc = "";
		String orgPath = "";
		BrandBaseSO so = new BrandBaseSO();

		so.setStId(view.getStId());
		so.setBndNo(Long.parseLong(bndNo));
		so.setCateCdL(Long.parseLong(cateCdL));

		// 브랜드 기본 정보 조회
		BrandBaseVO vo = brandService.getBrandDetail(so);
		
		if(!StringUtil.isEmpty(vo)) {
			title = vo.getBndNm();
			desc = vo.getBndNm();
			
			/*if(!StringUtil.isEmpty(vo.getBndItrdcMoImgPath())) {
				orgPath = vo.getBndItrdcMoImgPath();
			}else {
				orgPath = vo.getBndItrdcImgPath();
			}
			
			if(StringUtil.isNotEmpty(orgPath)) {
				if(orgPath.lastIndexOf("cdn.ntruss.com") != -1) {
					imgPath = orgPath;
				}else {
					imgPath = ImagePathUtil.imagePath(orgPath, FrontConstants.IMG_OPT_QRY_560);
				}
			}*/
			
			GoodsDispSO gso = new GoodsDispSO();
			gso.setStId(view.getStId());
			gso.setMbrNo(session.getMbrNo());
			gso.setDeviceGb(view.getDeviceGb());
			gso.setDispClsfNo(so.getCateCdL());
			gso.setBndNo(so.getBndNo());
			gso.setSalePeriodYn(CommonConstants.COMM_YN_N);
			gso.setSaleOutYn(CommonConstants.COMM_YN_Y);
			gso.setOrder("SALE");
			gso.setPage(so.getPage());
			gso.setRows(FrontConstants.PAGE_ROWS_1);
			
			List<GoodsDispVO> goodsList = goodsDispService.getGoodsBrand(gso);
			if(!StringUtil.isEmpty(goodsList) && goodsList.size() > 0) {
				orgPath = goodsList.get(0).getImgPath();
				if(StringUtil.isNotEmpty(orgPath)){
					if(orgPath.lastIndexOf("cdn.ntruss.com") != -1) {
						imgPath = orgPath;
					}else {
						imgPath = ImagePathUtil.imagePath(orgPath, FrontConstants.IMG_OPT_QRY_560);
					}
				}
			}
		}
		
		map.put("img", imgPath);
		map.put("desc", desc);
		map.put("title", title);
		
		map.put("bndNo", bndNo);
		map.put("cateCdL", cateCdL);
		
		map.put("pageGb", "brand");
		
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
	 * - 프로젝트명		: gs-apet-31-front
	 * - 파일명		: BrandController.java
	 * - 작성일		: 2021. 3. 11. 
	 * - 작성자		: YJU
	 * - 설명			: 전시분류별 브랜드 상품
	 * </pre>
	 * @param map
	 * @param session
	 * @param view
	 * @param so
	 * @return
	 */
	@RequestMapping(value="getBrandGoodsList")
	public String getBrandGoodsList(ModelMap map, Session session, ViewBase view, BrandBaseSO so) {

		GoodsDispSO gso = new GoodsDispSO();
		String deviceGb = view.getDeviceGb();
		gso.setStId(view.getStId());
		gso.setMbrNo(session.getMbrNo());
		gso.setDeviceGb(deviceGb);
		gso.setDispClsfNo(so.getDispClsfNo());
		gso.setBndNo(so.getBndNo());
		gso.setSalePeriodYn(CommonConstants.COMM_YN_N);
		gso.setSaleOutYn(CommonConstants.COMM_YN_Y);
		gso.setOrder(so.getOrder());
		gso.setPage(so.getPage());
		gso.setRows(FrontConstants.PAGE_ROWS_20);
		
		List<GoodsDispVO> brandGoodsList = goodsDispService.getGoodsBrand(gso);
		int goodsCount = goodsDispService.countBrandGoods(gso);
		
		map.put("brandGoodsList", brandGoodsList);
		map.put("goodsCount", goodsCount);
		
		return TilesView.none(new String[]{"brand", "include", "brandDetail"});
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명		: gs-apet-31-front
	 * - 파일명		: BrandController.java
	 * - 작성일		: 2021. 3. 11. 
	 * - 작성자		: YJU
	 * - 설명			: 전시분류별 브랜드 상품
	 * </pre>
	 * @param map
	 * @param session
	 * @param view
	 * @param so
	 * @return
	 */
	@RequestMapping(value="getBrandGoodsPagingList")
	public String getBrandGoodsPagingList(ModelMap map, Session session, ViewBase view, BrandBaseSO so) {

		GoodsDispSO gso = new GoodsDispSO();
		gso.setStId(view.getStId());
		gso.setMbrNo(session.getMbrNo());
		gso.setDeviceGb(view.getDeviceGb());
		gso.setDispClsfNo(so.getDispClsfNo());
		gso.setBndNo(so.getBndNo());
		gso.setSalePeriodYn(CommonConstants.COMM_YN_N);
		gso.setSaleOutYn(CommonConstants.COMM_YN_Y);
		gso.setOrder(so.getOrder());
		gso.setPage(so.getPage());
		gso.setRows(FrontConstants.PAGE_ROWS_20);
		
		List<GoodsDispVO> goodsList = goodsDispService.getGoodsBrand(gso);
		
		map.put("goodsList", goodsList);
		map.put("so", so);
		
		return TilesView.none(new String[]{"brand", "include", "brandDetailPaging"});
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 32.front.mobile
	 * - 파일명		: BrandController.java
	 * - 작성일		: 2017. 02. 08.
	 * - 작성자		: wyjeong
	 * - 설명		: 관심 브랜드 등록
	 * </pre>
	 * 
	 * @param session
	 * @param bndNo
	 * @return
	 */
	@LoginCheck
	@ResponseBody
	@RequestMapping("insertWish")
	public ModelMap insertWish(Session session, Long bndNo) {

		MemberInterestBrandPO po = new MemberInterestBrandPO();
		po.setMbrNo(session.getMbrNo());
		po.setBndNo(bndNo);
		po.setSysRegrNo(session.getMbrNo());
		int rs = this.memberInterestBrandService.insertMemberInterestBrand(po);

		ModelMap map = new ModelMap();
		if (rs == 1) {
			map.put("actGubun", "add");
		} else if (rs == 2) {
			map.put("actGubun", "remove");
		} else {
			map.put("actGubun", "error");
		}
		return map;
	}
}