package front.web.view.petshop.controller;

import java.io.IOException;
import java.security.SecureRandom;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Objects;
import java.util.Properties;
import java.util.Set;
import java.util.stream.Collectors;

import org.apache.commons.lang.StringUtils;
import org.codehaus.jackson.JsonParseException;
import org.codehaus.jackson.map.JsonMappingException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import biz.app.brand.model.BrandBaseSO;
import biz.app.brand.model.BrandBaseVO;
import biz.app.display.model.DisplayCategoryPO;
import biz.app.display.model.DisplayCategorySO;
import biz.app.display.model.DisplayCategoryVO;
import biz.app.display.model.DisplayCornerItemSO;
import biz.app.display.model.DisplayCornerSO;
import biz.app.display.model.DisplayCornerTotalVO;
import biz.app.display.model.SeoInfoSO;
import biz.app.display.model.SeoInfoVO;
import biz.app.display.service.DisplayService;
import biz.app.display.service.SeoService;
import biz.app.goods.model.GoodsBaseVO;
import biz.app.goods.model.GoodsDispSO;
import biz.app.goods.model.GoodsDispVO;
import biz.app.goods.model.GoodsDtlInqrHistSO;
import biz.app.goods.model.GoodsFiltAttrVO;
import biz.app.goods.model.GoodsFiltGrpSO;
import biz.app.goods.model.GoodsFiltGrpVO;
import biz.app.goods.service.FilterService;
import biz.app.goods.service.GoodsDispService;
import biz.app.goods.service.GoodsDtlInqrHistService;
import biz.app.login.service.FrontLoginService;
import biz.app.member.model.MemberBaseSO;
import biz.app.member.model.MemberBaseVO;
import biz.app.member.service.MemberService;
import biz.app.pet.model.PetBaseSO;
import biz.app.pet.service.PetService;
import biz.app.system.model.CodeDetailVO;
import biz.common.service.CacheService;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import framework.common.util.DateUtil;
import framework.common.util.SessionUtil;
import framework.common.util.StringUtil;
import framework.front.constants.FrontConstants;
import framework.front.model.Session;
import framework.front.util.FrontSessionUtil;
import front.web.config.constants.FrontWebConstants;
import front.web.config.tiles.TilesView;
import front.web.config.view.ViewBase;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("shop")
public class PetShopController {
	
	@Autowired private DisplayService displayService;
	@Autowired private SeoService seoService;
	@Autowired private Properties webConfig;
	@Autowired private GoodsDispService goodsDispService;
	@Autowired private GoodsDtlInqrHistService goodsDtlInqrHistService;
	@Autowired private FilterService filterService;
	@Autowired private MemberService memberService;
	@Autowired private PetService petService;
	@Autowired private CacheService cacheService;
	@Autowired private FrontLoginService frontLoginService;
	
	@RequestMapping(value = "home", method = {RequestMethod.GET, RequestMethod.POST})
//	public String petShopMain(ModelMap map, Session session, ViewBase view, DisplayCornerSO so, String goSection) throws Exception{
	public String petShopMain(ModelMap map, Session session, ViewBase view, DisplayCornerSO so) throws Exception{
		String dlgtPetGbCd = "";
		GoodsDispSO gso = new GoodsDispSO();
		// 최초 로딩 코너 수량 지정시 적용
		if(so.getDvsnCornerCnt() != null) {
			gso.setDvsnCornerCnt(so.getDvsnCornerCnt());
		}
		
		/* 20210720 펫샵홈 default pet 수정(CSR-1430). 공통코드를 통해 세팅하는 방향으로 수정. */
		Long dfLnbDispClsfNo = Long.valueOf(webConfig.getProperty("disp.clsf.no.petshop.cat"));
		Long dfCateCdl = Long.valueOf(webConfig.getProperty("disp.clsf.no.cat"));		
		//공통코드 조회. 코드상세의 사용자정의 1이 Y인 코드의 사용자정의 2,3 사용.
		List<CodeDetailVO> defaultPetList = cacheService.listCodeCache(CommonConstants.PET_SHOP_DEFAULT_PET, true, "Y", null, null, null, null);
		if(StringUtil.isNotEmpty(defaultPetList) && defaultPetList.size()>0) {
			dfLnbDispClsfNo = Long.valueOf(webConfig.getProperty(defaultPetList.get(0).getUsrDfn2Val()));
			dfCateCdl = Long.valueOf(webConfig.getProperty(defaultPetList.get(0).getUsrDfn3Val()));			
		}
		
		if(StringUtil.isEmpty(so.getLnbDispClsfNo())) {
			// 로그인 시 해당 펫으로 셋팅
			if(!session.getMbrNo().equals(CommonConstants.NO_MEMBER_NO)) {
				MemberBaseSO memberso = new MemberBaseSO();
				memberso.setStId(Long.valueOf(this.webConfig.getProperty("site.id")));
				memberso.setMbrNo(session.getMbrNo());

				Long lnbDispClsfNo = dfLnbDispClsfNo;
				Long cateCdl = dfCateCdl;
				
				if(CommonConstants.PET_GB_10.equals(session.getPetGbCd())) {
					lnbDispClsfNo = Long.valueOf(webConfig.getProperty("disp.clsf.no.petshop.dog"));
					cateCdl= Long.valueOf(webConfig.getProperty("disp.clsf.no.dog"));
				} else if(CommonConstants.PET_GB_20.equals(session.getPetGbCd())) {
					lnbDispClsfNo = Long.valueOf(webConfig.getProperty("disp.clsf.no.petshop.cat"));
					cateCdl = Long.valueOf(webConfig.getProperty("disp.clsf.no.cat"));
				} else if(CommonConstants.PET_GB_40.equals(session.getPetGbCd())) {
					lnbDispClsfNo = Long.valueOf(webConfig.getProperty("disp.clsf.no.petshop.fish"));
					cateCdl = Long.valueOf(webConfig.getProperty("disp.clsf.no.fish"));
				} else if(CommonConstants.PET_GB_50.equals(session.getPetGbCd())) {
					lnbDispClsfNo = Long.valueOf(webConfig.getProperty("disp.clsf.no.petshop.animal"));
					cateCdl = Long.valueOf(webConfig.getProperty("disp.clsf.no.animal"));
				}

				so.setLnbDispClsfNo(lnbDispClsfNo);	
				so.setCateCdL(cateCdl);	
				gso.setMbrNo(session.getMbrNo());
			}else {
				// 상품상세에서 넘어올 경우
				if(!StringUtil.isEmpty(so.getCateCdL())) {
					if(Long.valueOf(webConfig.getProperty("disp.clsf.no.dog")).equals(so.getCateCdL())) {
						so.setLnbDispClsfNo(Long.valueOf(webConfig.getProperty("disp.clsf.no.petshop.dog")));
					} else if (Long.valueOf(webConfig.getProperty("disp.clsf.no.cat")).equals(so.getCateCdL())) {
						so.setLnbDispClsfNo(Long.valueOf(webConfig.getProperty("disp.clsf.no.petshop.cat")));
					} else if (Long.valueOf(webConfig.getProperty("disp.clsf.no.fish")).equals(so.getCateCdL())) {
						so.setLnbDispClsfNo(Long.valueOf(webConfig.getProperty("disp.clsf.no.petshop.fish")));
					} else if (Long.valueOf(webConfig.getProperty("disp.clsf.no.animal")).equals(so.getCateCdL())) {
						so.setLnbDispClsfNo(Long.valueOf(webConfig.getProperty("disp.clsf.no.petshop.animal")));
					} else {
						//so.setLnbDispClsfNo(Long.valueOf(webConfig.getProperty("disp.clsf.no.petshop.dog")));
						so.setLnbDispClsfNo(dfLnbDispClsfNo);
						so.setCateCdL(dfCateCdl);	
					}
				}else {
					//so.setLnbDispClsfNo(Long.valueOf(webConfig.getProperty("disp.clsf.no.petshop.dog")));	// 300000173L
					//so.setCateCdL(Long.valueOf(webConfig.getProperty("disp.clsf.no.dog")));	// 12564
					so.setLnbDispClsfNo(dfLnbDispClsfNo);
					so.setCateCdL(dfCateCdl);
				}
			}
		}else {
			// LNB 반려동물(강아지/고양이) 변경처리
			if(!session.getMbrNo().equals(CommonConstants.NO_MEMBER_NO)) {
				gso.setMbrNo(session.getMbrNo());
				dlgtPetGbCd = displayService.updatePetGbCdLnbHistory(so.getLnbDispClsfNo(), session.getMbrNo());
				session.setPetGbCd(dlgtPetGbCd);
			}
			
			if(Long.valueOf(webConfig.getProperty("disp.clsf.no.petshop.dog")).equals(so.getLnbDispClsfNo())) {
				so.setCateCdL(Long.valueOf(webConfig.getProperty("disp.clsf.no.dog")));	// 12564
			} else if (Long.valueOf(webConfig.getProperty("disp.clsf.no.petshop.cat")).equals(so.getLnbDispClsfNo())) {
				so.setCateCdL(Long.valueOf(webConfig.getProperty("disp.clsf.no.cat")));
			} else if (Long.valueOf(webConfig.getProperty("disp.clsf.no.petshop.fish")).equals(so.getLnbDispClsfNo())) {
				so.setCateCdL(Long.valueOf(webConfig.getProperty("disp.clsf.no.fish")));
			} else if (Long.valueOf(webConfig.getProperty("disp.clsf.no.petshop.animal")).equals(so.getLnbDispClsfNo())) {
				so.setCateCdL(Long.valueOf(webConfig.getProperty("disp.clsf.no.animal")));
			}
		}
		
		gso.setStId(view.getStId());
		
		if(!session.getMbrNo().equals(CommonConstants.NO_MEMBER_NO)) {
			PetBaseSO pbSo = new PetBaseSO();
			pbSo.setMbrNo(session.getMbrNo());
			String petNos = petService.getPetNos(pbSo);
			if(StringUtil.isNotEmpty(petNos)) {
//				String[] petNoSplit = petNos.split(",");
//				
//				// 보안진단 처리 - 적절하지 않은 난수값 사용
//				SecureRandom random = new SecureRandom();
//				
//				String ranPetNo = petNoSplit[random.nextInt(petNoSplit.length)];
//				gso.setPetNo(Long.parseLong(ranPetNo));
//				map.put("petNo", ranPetNo);
				gso.setPetNos(petNos);
				map.put("petNos", petNos);
			}
		}
		
		gso.setDeviceGb(view.getDeviceGb());
		gso.setDispClsfNo(so.getCateCdL());	// 12564
		// BO 의 미리보기 시 previewDt 가 들어옴.
		if( StringUtil.isEmpty(so.getPreviewDt()) ) {					
			gso.setPreviewDt(DateUtil.getNowDate());
		}else {
			gso.setPreviewDt(so.getPreviewDt());
		}
		
		SessionUtil.setAttribute("gso",gso);
		List<DisplayCornerTotalVO> totalCornerList = displayService.dvsnCorner1(so.getLnbDispClsfNo(), gso);
		map.put("totalCornerList", totalCornerList);
		if(StringUtil.isNotEmpty(gso.getDispType())) {
			map.put("dispType", gso.getDispType());
		}
		
		SeoInfoSO seoSo = new SeoInfoSO();
		if(totalCornerList.size() > 0) {
			for ( DisplayCornerTotalVO cornerList : totalCornerList) {
				if(StringUtil.isNotEmpty(cornerList.getShortCutList())) {
					view.setDisplayShortCutList(cornerList.getShortCutList());
				}else if(StringUtil.isNotEmpty(cornerList.getTimeDealList())) {
					map.put("timeDealList", cornerList.getTimeDealList());
				}else if(StringUtil.isNotEmpty(cornerList.getSeoInfoNo())) {
					seoSo.setSeoInfoNo(cornerList.getSeoInfoNo());
				}
			}
		}
		view.setSeoSvcGbCd(FrontWebConstants.SEO_SVC_GB_CD_10);
		
		// seo 정보
		seoSo.setSeoSvcGbCd(view.getSeoSvcGbCd());
		seoSo.setSeoTpCd(FrontWebConstants.SEO_TP_30);
		SeoInfoVO seoInfo = seoService.getSeoInfoFO(seoSo, false);
				
		view.setDispClsfNo(so.getLnbDispClsfNo());		// 300000173
		
		// session에 현재 전시카테고리 번호 넣기
		session.setDispClsfNo(so.getLnbDispClsfNo());
		FrontSessionUtil.setSession(session); 
		
		map.put("seoInfo", seoInfo);
		map.put("session", session);
		SessionUtil.setAttribute("view",view);
		map.put("view", view);
		map.put("so", so);
		
		return "/petshop/indexPetShopMain1ST";
	}
	/**
	 *
	 * - 설명			: test
	 * </pre>
	 * @param view
	 * @param so
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="indexPetShopMain2ND", method=RequestMethod.POST)
	public String indexPetShopMain2ND(ModelMap map, Long dfLnbDispClsfNo, Long cateCdL) throws Exception{
		GoodsDispSO gso = (GoodsDispSO) SessionUtil.getAttribute("gso");
		ViewBase view = (ViewBase) SessionUtil.getAttribute("view");
		List<DisplayCornerTotalVO> totalCornerList = displayService.dvsnCorner2(dfLnbDispClsfNo, gso);
		if(totalCornerList.size() > 0) {
			for ( DisplayCornerTotalVO cornerList : totalCornerList) {
				if(StringUtil.isNotEmpty(cornerList.getShortCutList())) {
					view.setDisplayShortCutList(cornerList.getShortCutList());
				}else if(StringUtil.isNotEmpty(cornerList.getTimeDealList())) {
					map.put("timeDealList", cornerList.getTimeDealList());
				}
			}
		}
		map.put("totalCornerList", totalCornerList);
		map.put("view", view);
		map.put("dispType", gso.getDispType());
		DisplayCornerSO so = new DisplayCornerSO();
		so.setCateCdL(cateCdL);
		map.put("so", so);
		return "/petshop/indexPetShopMain2ND";
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명		: gs-apet-31-front
	 * - 파일명		: PetShopController.java
	 * - 작성일		: 2021. 2. 9. 
	 * - 작성자		: YJU
	 * - 설명			: 펫샵 라이브 여부check
	 * </pre>
	 * @param po
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="getDisplayBaseLiveCheck", method=RequestMethod.POST)
	public ModelMap getDisplayBaseLivecheck(DisplayCategorySO so){
		
		DisplayCategoryVO vo = displayService.getDisplayBase(so);
		ModelMap map = new ModelMap();
		map.put("liveYn", vo.getLiveYn());
		return map;
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명		: gs-apet-31-front
	 * - 파일명		: PetShopController.java
	 * - 작성일		: 2021. 2. 9. 
	 * - 작성자		: YJU
	 * - 설명			: 펫샵 라이브 여부 update
	 * </pre>
	 * @param po
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="liveOnOff", method=RequestMethod.POST)
	public ModelMap liveOnOff(DisplayCategoryPO po){
		ModelMap map = new ModelMap();
		displayService.liveOnOff(po);
		return map;
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명		: gs-apet-31-front
	 * - 파일명		: PetShopController.java
	 * - 작성일		: 2021. 3. 2. 
	 * - 작성자		: YJU
	 * - 설명			: 베스트 상품 목록 조회 화면
	 * </pre>
	 * @param map
	 * @param session
	 * @param view
	 * @param dispClsfCornNo
	 * @param so
	 * @return
	 */
	@RequestMapping(value="indexBestGoodsList", method=RequestMethod.GET)
	public String indexBestGoodsList(ModelMap map, Session session, ViewBase view, GoodsDispSO so) {
		
		// 1.lnb에서 넘어올 경우 dispCornType=BEST
		// 2.카테고리 클릭으로 넘어올경우 dispCornType=BEST
		// 3.전체보기로 넘어올 경우 
		// 	-> 수동 : getDispClsfCornNo 있고 , 자동 : getDispClsfCornNo 없고
		String dlgtPetGbCd = "";
		// LNB에서 넘어올 경우 
		if(!StringUtil.isEmpty(so.getDispCornType())) {
			if(!StringUtil.isEmpty(so.getLnbDispClsfNo())) {
				so.setDispClsfNo(so.getLnbDispClsfNo());
				// session에 현재 전시카테고리 번호 넣기
				session.setDispClsfNo(so.getLnbDispClsfNo());
				// LNB 반려동물(강아지/고양이) 변경처리
				if(!session.getMbrNo().equals(CommonConstants.NO_MEMBER_NO)) {
					dlgtPetGbCd = displayService.updatePetGbCdLnbHistory(so.getLnbDispClsfNo(), session.getMbrNo());
					session.setPetGbCd(dlgtPetGbCd);
				}
				
				FrontSessionUtil.setSession(session); 
			}
			
			so.setPreviewDt(DateUtil.getNowDate());
			List<DisplayCornerTotalVO> BestManualList = displayService.getBestManual(so);
			if(BestManualList.size() > 0) {
				so.setDispCornNo(BestManualList.get(0).getDispCornNo());
				so.setDispClsfCornNo(BestManualList.get(0).getDispClsfCornNo());
				so.setDispType(CommonConstants.GOODS_MAIN_DISP_TYPE_BEST_MANUAL);
			}else {
				so.setDispType(CommonConstants.GOODS_MAIN_DISP_TYPE_BEST_AUTO);
			}
		
		} else if(StringUtil.isEmpty(so.getDispCornType())) {
			// 전체보기로 넘어 올경우
			if(!StringUtil.isEmpty(so.getDispClsfCornNo())) {
				so.setDispType(CommonConstants.GOODS_MAIN_DISP_TYPE_BEST_MANUAL);
			}else {
				so.setDispType(CommonConstants.GOODS_MAIN_DISP_TYPE_BEST_AUTO);
			}
		}
		
		view.setDispClsfNo(so.getDispClsfNo());	// 300000173
		
		DisplayCornerItemSO dciSo = new DisplayCornerItemSO();
		dciSo.setDispClsfNo(so.getDispClsfNo());
		dciSo.setDispCornTpCd(CommonConstants.DISP_CORN_TP_30);
		view.setDisplayShortCutList(this.displayService.getBnrImgListFO(dciSo));
		
		// 전시 분류 번호 셋팅
		if(Long.valueOf(webConfig.getProperty("disp.clsf.no.petshop.dog")).equals(so.getDispClsfNo())) {
			so.setCateCdL(Long.valueOf(webConfig.getProperty("disp.clsf.no.dog")));	// 12564
		} else if (Long.valueOf(webConfig.getProperty("disp.clsf.no.petshop.cat")).equals(so.getDispClsfNo())) {
			so.setCateCdL(Long.valueOf(webConfig.getProperty("disp.clsf.no.cat")));
		} else if (Long.valueOf(webConfig.getProperty("disp.clsf.no.petshop.fish")).equals(so.getDispClsfNo())) {
			so.setCateCdL(Long.valueOf(webConfig.getProperty("disp.clsf.no.fish")));
		} else if (Long.valueOf(webConfig.getProperty("disp.clsf.no.petshop.animal")).equals(so.getDispClsfNo())) {
			so.setCateCdL(Long.valueOf(webConfig.getProperty("disp.clsf.no.animal")));
		}
		
		List<GoodsDispVO> bestGoodsList = goodsDispService.getGoodsBest(view.getStId(), session.getMbrNo(),	so.getDispType()
				, so.getDispClsfCornNo(), so.getCateCdL(), view.getDeviceGb(), 50
				, CommonConstants.COMM_YN_Y, CommonConstants.COMM_YN_N, null, 50, StringUtils.isNotEmpty(so.getPeriod()) ? so.getPeriod() : null);
		
		if (!StringUtil.equals(so.getDispType(), CommonConstants.GOODS_MAIN_DISP_TYPE_BEST_AUTO) && bestGoodsList.size() == 0) {
			so.setDispType(CommonConstants.GOODS_MAIN_DISP_TYPE_BEST_AUTO);
			
			bestGoodsList = goodsDispService.getGoodsBest(view.getStId(), session.getMbrNo(), so.getDispType()
					,so.getDispClsfCornNo(), so.getCateCdL(), view.getDeviceGb(), 50
					, CommonConstants.COMM_YN_Y, CommonConstants.COMM_YN_N, null, 50, StringUtils.isNotEmpty(so.getPeriod()) ? so.getPeriod() : null);
		}
		
		if (bestGoodsList.size() > 0) {

			Set<GoodsDispVO> bestGoodsCategorySet = new LinkedHashSet<>();

			// Auto
			if(StringUtils.equals(CommonConstants.GOODS_MAIN_DISP_TYPE_BEST_AUTO, so.getDispType())) {
				List<String> filterInfoArray = bestGoodsList.stream().map(GoodsDispVO::getFilterInfo).collect(Collectors.toList());
				int idx = 0;
				for(String filterInfoStr : filterInfoArray) {
					String[] filterInfo = filterInfoStr.split(",");
					int cateIdx = 0;
					for(String filter : filterInfo) {
						GoodsDispVO category = new GoodsDispVO();
						category.setCateSeq(Long.parseLong(filter.split("_")[0]));
						category.setCateNmM(filter.split("_")[1]);
						bestGoodsCategorySet.add(category);
						cateIdx ++;
					}
					idx ++;
				}
			} else {
				// Manual
				List<String> cateCdMStr = bestGoodsList.stream().map(GoodsDispVO::getCateCdMStr).collect(Collectors.toList());
				List<String> cateNmMStr = bestGoodsList.stream().map(GoodsDispVO::getCateNmM).collect(Collectors.toList());
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
						bestGoodsCategorySet.add(category);
						cateIdx ++;
					}
					idx ++;
				}
			}

			ArrayList bestGoodsCategoryList = new ArrayList(bestGoodsCategorySet.stream().sorted(Comparator.comparing(GoodsDispVO::getCateSeq)).collect(Collectors.toList()));
			map.put("bestGoodsCategoryList", bestGoodsCategoryList);
		}

		view.setSeoSvcGbCd(FrontWebConstants.SEO_SVC_GB_CD_10);
		map.put("bestGoodsList", bestGoodsList);
		map.put("dispType", so.getDispType());
		map.put("so", so);
		map.put("session", session);
		map.put("view", view);

		return TilesView.none(new String[] { "petshop", "indexPetshopBestGoods" });
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명		: gs-apet-31-front
	 * - 파일명		: PetShopController.java
	 * - 작성일		: 2021. 2. 18. 
	 * - 작성자		: YJU
	 * - 설명			: 펫샵 베스트 상품 카테고리별 리스트
	 * </pre>
	 * @param view
	 * @param so
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping(value="getBestGoodsList", method=RequestMethod.POST)
	public ModelMap getBestGoodsList(ViewBase view, Session session, GoodsDispSO so){
		ModelMap map = new ModelMap();
		List<GoodsDispVO> getBestGoodsList = goodsDispService.getGoodsBest(so.getStId(), session.getMbrNo(), so.getDispType(), so.getDispClsfCornNo(), so.getDispClsfNo(), view.getDeviceGb(), so.getTotalCount(), CommonConstants.COMM_YN_Y, CommonConstants.COMM_YN_N, null, so.getTotalCount(), StringUtils.isNotEmpty(so.getDispType()) ? so.getPeriod() : null);
		map.put("getBestGoodsList", getBestGoodsList);
		return map;
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명		: gs-apet-31-front
	 * - 파일명		: PetShopController.java
	 * - 작성일		: 2021. 2. 18. 
	 * - 작성자		: YJU
	 * - 설명			: 검색 창 자동 문구 조회
	 * </pre>
	 * @param view
	 * @param so
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="getSearchInputAutoComplete", method=RequestMethod.POST)
	public ModelMap getSearchInputAutoComplete(ViewBase view, DisplayCornerItemSO so){
		ModelMap map = new ModelMap();
		so.setDispClsfNo(Long.valueOf(webConfig.getProperty("disp.clsf.no.petshop")));
		so.setDispCornTpCd(CommonConstants.DISP_CORN_TP_20);
		so.setOffset(1);
		map.put("searchBox", displayService.getBnrTextFO(so));
		return map;
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명		: gs-apet-31-front
	 * - 파일명		: PetShopController.java
	 * - 작성일		: 2021. 3. 2. 
	 * - 작성자		: YJU
	 * - 설명			: 상품 목록 조회 화면
	 * </pre>
	 * @param map
	 * @param session
	 * @param view
	 * @param dispClsfCornNo
	 * @param so
	 * @return
	 */
	@RequestMapping(value="indexGoodsList", method = {RequestMethod.GET, RequestMethod.POST})
	public String indexGoodsList(ModelMap map, Session session, ViewBase view, GoodsDispSO so) {
		String dlgtPetGbCd = "";
		// LNB에서 넘어올 경우 
		if(!StringUtil.isEmpty(so.getLnbDispClsfNo()) && !StringUtil.isEmpty(so.getDispCornType())) {
			so.setDispClsfNo(so.getLnbDispClsfNo());
			so.setPreviewDt(DateUtil.getNowDate());
			DisplayCornerTotalVO cornerVO = displayService.getCornerInfoToDispCornType(so);
			if(!StringUtil.isEmpty(cornerVO)) {
				so.setDispCornNo(cornerVO.getDispCornNo());
				so.setDispClsfCornNo(cornerVO.getDispClsfCornNo());
			}
			
			// session에 현재 전시카테고리 번호 넣기
			session.setDispClsfNo(so.getLnbDispClsfNo());
			// LNB 반려동물(강아지/고양이) 변경처리
			if(!session.getMbrNo().equals(CommonConstants.NO_MEMBER_NO)) {
				dlgtPetGbCd = displayService.updatePetGbCdLnbHistory(so.getLnbDispClsfNo(), session.getMbrNo());
				session.setPetGbCd(dlgtPetGbCd);
			}
			
			FrontSessionUtil.setSession(session); 
		}else if(StringUtil.isEmpty(so.getLnbDispClsfNo()) && !StringUtil.isEmpty(so.getDispCornType())) {
			so.setPreviewDt(DateUtil.getNowDate());
			DisplayCornerTotalVO cornerVO = displayService.getCornerInfoToDispCornType(so);
			if(!StringUtil.isEmpty(cornerVO)) {
				so.setDispCornNo(cornerVO.getDispCornNo());
				so.setDispClsfCornNo(cornerVO.getDispClsfCornNo());
			}
		}
		
		view.setDispClsfNo(so.getDispClsfNo());	// 300000173
		
		DisplayCornerItemSO dciSo = new DisplayCornerItemSO();
		dciSo.setDispClsfNo(so.getDispClsfNo());
		dciSo.setDispCornTpCd(CommonConstants.DISP_CORN_TP_30);
		view.setDisplayShortCutList(this.displayService.getBnrImgListFO(dciSo));
		
		// 전시 분류 번호 셋팅
		if(Long.valueOf(webConfig.getProperty("disp.clsf.no.petshop.dog")).equals(so.getDispClsfNo())) {
			so.setCateCdL(Long.valueOf(webConfig.getProperty("disp.clsf.no.dog")));	// 12564
		} else if (Long.valueOf(webConfig.getProperty("disp.clsf.no.petshop.cat")).equals(so.getDispClsfNo())) {
			so.setCateCdL(Long.valueOf(webConfig.getProperty("disp.clsf.no.cat")));
		} else if (Long.valueOf(webConfig.getProperty("disp.clsf.no.petshop.fish")).equals(so.getDispClsfNo())) {
			so.setCateCdL(Long.valueOf(webConfig.getProperty("disp.clsf.no.fish")));
		} else if (Long.valueOf(webConfig.getProperty("disp.clsf.no.petshop.animal")).equals(so.getDispClsfNo())) {
			so.setCateCdL(Long.valueOf(webConfig.getProperty("disp.clsf.no.animal")));
		}
		
		so.setStId(view.getStId());
		so.setMbrNo(session.getMbrNo());
		so.setDeviceGb(view.getDeviceGb());
		so.setPage((so.getPage()!= 0) ? so.getPage() : 0);
		if(StringUtil.equals(CommonConstants.GOODS_MAIN_DISP_TYPE_MD, so.getDispType())) {
			so.setRows(FrontConstants.PAGE_ROWS_18);		// 20으로 수정
		}else {
			so.setRows(FrontConstants.PAGE_ROWS_20);		// 20으로 수정
		}
		
		// get List
		DisplayCornerTotalVO cornerList = displayService.getGoodsList(so);
		String url = "/petshop/"+cornerList.getDispCornPage().replace("petshop", "indexPetshop").replace(".jsp", "");
	
		view.setSeoSvcGbCd(FrontWebConstants.SEO_SVC_GB_CD_10);
		map.put("cornerList", cornerList);
		map.put("so", so);
		map.put("session", session);
		map.put("view", view);

		return url;
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명		: gs-apet-31-front
	 * - 파일명		: PetShopController.java
	 * - 작성일		: 2021. 3. 2. 
	 * - 작성자		: YJU
	 * - 설명			: 상품 목록 조회 화면
	 * </pre>
	 * @param map
	 * @param session
	 * @param view
	 * @param dispClsfCornNo
	 * @param so
	 * @return
	 */
	@RequestMapping(value="getSortGoodsList", method = {RequestMethod.GET, RequestMethod.POST})
	public String getSortGoodsList(ModelMap map, Session session, ViewBase view, GoodsDispSO so) {
		map.put("filters", (so.getFilters() != null)? so.getFilters().stream().filter(p -> !"GIFTP".equals(p)).collect(Collectors.toList()): null);
		view.setDispClsfNo(so.getDispClsfNo());	// 300000173
		
		// 전시 분류 번호 셋팅
		if(Long.valueOf(webConfig.getProperty("disp.clsf.no.petshop.dog")).equals(so.getDispClsfNo())) {
			so.setCateCdL(Long.valueOf(webConfig.getProperty("disp.clsf.no.dog")));	// 12564
		} else if (Long.valueOf(webConfig.getProperty("disp.clsf.no.petshop.cat")).equals(so.getDispClsfNo())) {
			so.setCateCdL(Long.valueOf(webConfig.getProperty("disp.clsf.no.cat")));
		} else if (Long.valueOf(webConfig.getProperty("disp.clsf.no.petshop.fish")).equals(so.getDispClsfNo())) {
			so.setCateCdL(Long.valueOf(webConfig.getProperty("disp.clsf.no.fish")));
		} else if (Long.valueOf(webConfig.getProperty("disp.clsf.no.petshop.animal")).equals(so.getDispClsfNo())) {
			so.setCateCdL(Long.valueOf(webConfig.getProperty("disp.clsf.no.animal")));
		}
		
		so.setStId(view.getStId());
		so.setMbrNo(session.getMbrNo());
		so.setDeviceGb(view.getDeviceGb());
		// get List
		DisplayCornerTotalVO cornerList = displayService.getGoodsList(so);
		String url = "/petshop/goods/"+cornerList.getDispCornPage().replace("petshop", "corner").replace(".jsp", "");
		
		view.setSeoSvcGbCd(FrontWebConstants.SEO_SVC_GB_CD_10);
		map.put("cornerList", cornerList);
		map.put("so", so);
		map.put("session", session);
		map.put("view", view);

		return url;
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명		: gs-apet-31-front
	 * - 파일명		: PetShopController.java
	 * - 작성일		: 2021. 3. 10. 
	 * - 작성자		: YJU
	 * - 설명			: 펫샵 카테고리 상품 목록
	 * </pre>
	 * @param map
	 * @param session
	 * @param view
	 * @param so
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="indexCategory", method = RequestMethod.GET)
	public String indexCategory(ModelMap map, Session session, ViewBase view, GoodsDispSO so, String page) throws Exception {
		
		String dlgtPetGbCd = "";
		List<DisplayCategoryVO> allCategories = view.getDisplayCategoryList();
		
		List<DisplayCategoryVO> mCategories = allCategories.stream()
				.filter(item -> Objects.equals(item.getUpDispClsfNo(), so.getCateCdL()))
				.sorted(Comparator.comparing(DisplayCategoryVO::getDispPriorRank))
				.collect(Collectors.toList());
		
		if(StringUtil.isEmpty(so.getCateCdM())) {
			so.setCateCdM(mCategories.get(0).getDispClsfNo());
			so.setDispClsfNo(so.getCateCdM());
		}
		
		List<DisplayCategoryVO> sCategories = allCategories.stream()
				.filter(item -> Objects.equals(item.getDispLvl(), CommonConstants.DISP_LVL_3) && Objects.equals(item.getUpDispClsfNo(), so.getCateCdM()))
				.sorted(Comparator.comparing(DisplayCategoryVO::getDispPriorRank))
				.collect(Collectors.toList());
		
		// LNB에서 넘어올 경우 
		if(!StringUtil.isEmpty(so.getLnbDispClsfNo())) {
			List<DisplayCategoryVO> getCategories = allCategories.stream()
					.filter(item -> Objects.equals(item.getUpDispClsfNo(), so.getCateCdL()))
					.sorted(Comparator.comparing(DisplayCategoryVO::getDispPriorRank))
					.collect(Collectors.toList());
			
			so.setDispClsfNo(getCategories.get(0).getDispClsfNo());
			so.setCateCdM(getCategories.get(0).getDispClsfNo());
			// LNB 반려동물(강아지/고양이) 변경처리
			if(!session.getMbrNo().equals(CommonConstants.NO_MEMBER_NO)) {
				dlgtPetGbCd = displayService.updatePetGbCdLnbHistory(so.getLnbDispClsfNo(), session.getMbrNo());
				session.setPetGbCd(dlgtPetGbCd);
			}
		}else {
			if(StringUtil.isEmpty(so.getDispClsfNo2())) {
				if(Long.valueOf(webConfig.getProperty("disp.clsf.no.dog")).equals(so.getCateCdL())) {
					so.setLnbDispClsfNo(Long.valueOf(webConfig.getProperty("disp.clsf.no.petshop.dog")));
				} else if (Long.valueOf(webConfig.getProperty("disp.clsf.no.cat")).equals(so.getCateCdL())) {
					so.setLnbDispClsfNo(Long.valueOf(webConfig.getProperty("disp.clsf.no.petshop.cat")));
				} else if (Long.valueOf(webConfig.getProperty("disp.clsf.no.fish")).equals(so.getCateCdL())) {
					so.setLnbDispClsfNo(Long.valueOf(webConfig.getProperty("disp.clsf.no.petshop.fish")));
				} else if (Long.valueOf(webConfig.getProperty("disp.clsf.no.animal")).equals(so.getCateCdL())) {
					so.setLnbDispClsfNo(Long.valueOf(webConfig.getProperty("disp.clsf.no.petshop.animal")));
				} else {
					so.setLnbDispClsfNo(Long.valueOf(webConfig.getProperty("disp.clsf.no.petshop.dog")));
				}
			}else {
				so.setLnbDispClsfNo(Long.valueOf(so.getDispClsfNo2()));
			}
		}
		// dispClsfNo 클릭한 전시카테고리 -> 2 or 3
		// cateCdM 12569 - 사료 전시
		// cateCdL 12564 - 강아지  --> 배너
		// lnbDispClsfNo 300000173L
		if (so.getDispClsfNo() == null) {
			throw new CustomException(ExceptionConstants.ERROR_CATE_NO_DATA);
		}
		
		view.setDispClsfNo(so.getLnbDispClsfNo());	// 300000173
		
		// session에 현재 전시카테고리 번호 넣기
		session.setDispClsfNo(so.getLnbDispClsfNo());
		FrontSessionUtil.setSession(session);
		// 아이콘 리스트
		DisplayCornerItemSO dciSo = new DisplayCornerItemSO();
		dciSo.setDispClsfNo(so.getLnbDispClsfNo());
		dciSo.setDispCornTpCd(CommonConstants.DISP_CORN_TP_30);
		view.setDisplayShortCutList(this.displayService.getBnrImgListFO(dciSo));
		
		GoodsDispSO gso = new GoodsDispSO();
		gso.setStId(view.getStId());
		gso.setMbrNo(session.getMbrNo());
		gso.setDeviceGb(view.getDeviceGb());
		gso.setDispClsfNo(so.getDispClsfNo());
		gso.setCateCdM(so.getCateCdM());
		gso.setSalePeriodYn(CommonConstants.COMM_YN_N);
		gso.setSaleOutYn(CommonConstants.COMM_YN_Y);
		gso.setOrder(StringUtils.isNotEmpty(so.getOrder()) ? so.getOrder() : "SALE");
		gso.setPage(so.getPage());
		gso.setRows(FrontConstants.PAGE_ROWS_20);
		// 2dept 광고 배너
		List<DisplayCornerTotalVO> totalCornerList = displayService.getDisplayCornerItemCaterotyFO(gso, CommonConstants.DISP_CORN_TP_75);
		
		List<GoodsDispVO> categoryGoodsList = goodsDispService.getGoods(gso);
		int goodsCount = goodsDispService.countGoods(gso);

		view.setSeoSvcGbCd(FrontWebConstants.SEO_SVC_GB_CD_10);
		
		map.put("session", session);
		map.put("view", view);
		map.put("dispClsfNo", so.getCateCdM());
		map.put("totalCornerList", totalCornerList);
		map.put("categoryGoodsList", categoryGoodsList);
		map.put("goodsCount", goodsCount);
		map.put("so", so);
		map.put("mCategoryList", mCategories);
		map.put("sCategoryList", sCategories);
		
		return  TilesView.none(new String[]{"petshop", "indexPetShopCategory"});
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명		: gs-apet-31-front
	 * - 파일명		: PetShopController.java
	 * - 작성일		: 2021. 3. 4. 
	 * - 작성자		: YJU
	 * - 설명			: 카테고리 목록 (소분류)
	 * </pre>
	 * @param map
	 * @param session
	 * @param view
	 * @param so
	 * @param page
	 * @param searchVo
	 * @return
	 */
	@RequestMapping(value="getScateGoodsList")
	public String getScateGoodsList(ModelMap map, Session session, ViewBase view, GoodsDispSO so){

		GoodsDispSO gso = new GoodsDispSO();
		gso.setStId(view.getStId());
		gso.setMbrNo(session.getMbrNo());
		gso.setDeviceGb(view.getDeviceGb());
		gso.setDispClsfNo(so.getDispClsfNo());
		gso.setCateCdM(so.getCateCdM());
		gso.setFilters(so.getFilters());
		gso.setFilterCount(so.getFilters() != null ? so.getFilters().size() : 0);
		gso.setBndNos(so.getBndNos());
		gso.setSalePeriodYn(CommonConstants.COMM_YN_N);
		gso.setSaleOutYn(CommonConstants.COMM_YN_Y);
		gso.setOrder(so.getOrder());
		gso.setPage(so.getPage());
		gso.setRows(FrontConstants.PAGE_ROWS_20);
		// 3dept 추천상품
		List<DisplayCornerTotalVO> totalCornerList = displayService.getDisplayCornerItemCaterotyFO(gso, CommonConstants.DISP_CORN_TP_60);
		
		List<GoodsDispVO> categoryGoodsList = goodsDispService.getGoods(gso);
		int goodsCount = goodsDispService.countGoods(gso);
		
		view.setSeoSvcGbCd(FrontWebConstants.SEO_SVC_GB_CD_10);
		map.put("session", session);
		map.put("view", view);
		map.put("dispClsfNo", so.getDispClsfNo());
		map.put("totalCornerList", totalCornerList);
		map.put("categoryGoodsList", categoryGoodsList);
		map.put("goodsCount", goodsCount);
		map.put("so", so);
		
		return  TilesView.none(new String[]{"petshop", "include", "petShopCategory"});
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명		: gs-apet-31-front
	 * - 파일명		: PetShopController.java
	 * - 작성일		: 2021. 3. 4. 
	 * - 작성자		: YJU
	 * - 설명			: 카테고리 목록 페이징
	 * </pre>
	 * @param map
	 * @param session
	 * @param view
	 * @param so
	 * @param page
	 * @param searchVo
	 * @return
	 */
	@RequestMapping(value="getGoodsPagingList")
	public String getGoodsPagingList(ModelMap map, Session session, ViewBase view, GoodsDispSO so){

		GoodsDispSO gso = new GoodsDispSO();
		gso.setStId(view.getStId());
		gso.setMbrNo(session.getMbrNo());
		gso.setDeviceGb(view.getDeviceGb());
		if(!StringUtil.isEmpty(so.getDispClsfNo())) {
			gso.setDispClsfNo(so.getDispClsfNo());
		}
		gso.setCateCdM(so.getCateCdM());
		gso.setFilters(so.getFilters());
		gso.setFilterCount(so.getFilters() != null ? so.getFilters().size() : 0);
		gso.setBndNos(so.getBndNos());
		gso.setSalePeriodYn(CommonConstants.COMM_YN_N);
		gso.setSaleOutYn(CommonConstants.COMM_YN_Y);
		if(!StringUtil.isEmpty(so.getTags())) {
			gso.setTags(so.getTags());
			gso.setDispClsfNo(Long.valueOf(CommonConstants.DISP_CLSF_10));
		}
		gso.setOrder(so.getOrder());
		gso.setPage(so.getPage());
		gso.setRows(FrontConstants.PAGE_ROWS_20);
		
		List<GoodsDispVO> categoryGoodsList = goodsDispService.getGoods(gso);
		
		map.put("categoryGoodsList", categoryGoodsList);
		map.put("so", so);
		
		return  TilesView.none(new String[]{"petshop", "include", "petShopCategoryPaging"});
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명		: gs-apet-31-front
	 * - 파일명		: PetShopController.java
	 * - 작성일		: 2021. 3. 4. 
	 * - 작성자		: YJU
	 * - 설명			: 펫샵 코너 목록 페이징
	 * </pre>
	 * @param map
	 * @param session
	 * @param view
	 * @param so
	 * @param page
	 * @param searchVo
	 * @return
	 */
	@RequestMapping(value="getShopCornerPagingList")
	public String getShopCornerPagingList(ModelMap map, Session session, ViewBase view, GoodsDispSO so){
		so.setStId(view.getStId());
		so.setMbrNo(session.getMbrNo());
		so.setDeviceGb(view.getDeviceGb());
		
		// get List
		DisplayCornerTotalVO cornerList = displayService.getDispTypeCornerGoodsList(so);
		String url = "/petshop/goods/"+cornerList.getDispCornPage().replace("petshop", "corner").replace(".jsp", "Paging");
		map.put("cornerList", cornerList);
		map.put("so", so);
		
		return url;
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명    : gs-apet-31-front
	 * - 파일명        : PetShopController.java
	 * - 작성일        : 2021. 3. 15.
	 * - 작성자        : YKU
	 * - 설명          : 카테고리 필터팝업
	 * </pre>
	 * @param map
	 * @param session
	 * @param view
	 * @param so
	 * @return
	 */
	@RequestMapping(value="categoryFilterPop" , method = RequestMethod.POST)
	public String categoryFilterPop(ModelMap map, Session session, ViewBase view, GoodsFiltGrpSO so){
		//필터 팝업
		List<GoodsFiltGrpVO> filter = displayService.foCategoryFilterInfo(so);
		
//		FiltAttrMapSO filtso = new FiltAttrMapSO();
//		filtso.setFilters(so.getFilters());
//		if(StringUtil.isNotEmpty(filtso.getFilters())) {
//			List<FiltAttrMapVO> getFilter = filterService.filterGoodsCategory(filtso);
//			map.put("getFilter", getFilter);
//		}
//		
//		//브랜드 조회
		BrandBaseSO brandSo = new BrandBaseSO();
		brandSo.setBrandNos(so.getBndNos());
//		if(StringUtil.isNotEmpty(brandSo.getBrandNos())) {
//			List<BrandBaseVO> getBrand = filterService.getFilterGoodsBrand(brandSo);
//			map.put("getBrand", getBrand);
//		}
		
		map.put("filter", filter);
		map.put("so", so); 
		map.put("brandSo",  brandSo);
		
		return  TilesView.none(new String[]{"petshop", "include", "petShopCategoryFilterPop"});
	}
	
	@RequestMapping(value="tagFilterPop" , method = RequestMethod.POST)
	public String tagFilterPop(ModelMap map, Session session, ViewBase view, GoodsFiltGrpSO so){
		//필터 팝업
		List<GoodsFiltAttrVO> goodsFiltAttrList = goodsDispService.getFilterGroup(so.getGoodsIds());
		
//		List<GoodsFiltAttrVO> attrNm = goodsFiltAttrList.stream()
//										.map(p -> new GoodsFiltAttrVO(p.getFiltGrpMngNm(), p.getFiltGrpShowNm())).distinct()
//										.collect(Collectors.toList());		
		List<String> attrNm = goodsFiltAttrList.stream().map(p -> p.getFiltGrpMngNm()).distinct().collect(Collectors.toList());
		map.put("filters", goodsFiltAttrList);
		map.put("attrNm", attrNm);
		
		//브랜드 조회
		BrandBaseSO brandSo = new BrandBaseSO();
		brandSo.setBrandNos(so.getBndNos());
		
		map.put("so", so); 
		map.put("brandSo",  brandSo);
		
		return  TilesView.none(new String[]{"petshop", "include", "petshopTagFilterPop"});
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명    : gs-apet-31-front
	 * - 파일명        : PetShopController.java
	 * - 작성일        : 2021. 3. 22.
	 * - 작성자        : YKU
	 * - 설명          : 필터상품 카운트
	 * </pre>
	 * @param map
	 * @param session
	 * @param view
	 * @param so
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="getGoodsCount")
	public ModelMap getGoodsCount(Session session, ViewBase view, GoodsDispSO so){
		ModelMap map = new ModelMap();
		so.setStId(view.getStId());
		so.setMbrNo(session.getMbrNo());
		so.setDeviceGb(view.getDeviceGb());
		so.setSalePeriodYn(CommonConstants.COMM_YN_N);
		so.setSaleOutYn(CommonConstants.COMM_YN_Y);
		so.setFilterCount(so.getFilters() != null ? so.getFilters().size() : 0);
		
		int getGoodsCount = goodsDispService.countGoods(so);
		
		map.put("getGoodsCount", getGoodsCount);
		map.put("so", so);
		
		return map;
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명    : gs-apet-31-front
	 * - 파일명        : PetShopController.java
	 * - 작성일        : 2021. 4. 1.
	 * - 작성자        : YKU
	 * - 설명          : 필터 브랜드 목록
	 * </pre>
	 * @param view
	 * @param so
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="brandList", method=RequestMethod.POST)
	public ModelMap brandList(ViewBase view, BrandBaseSO so){
		ModelMap map = new ModelMap();
		List<BrandBaseVO> brand = filterService.filterGoodsBrand(so);
		map.put("brand", brand);
		return map;
	}
	
	@RequestMapping(value="indexLive", method = RequestMethod.GET)
	public String indexLive(ModelMap map, Session session, ViewBase view, GoodsDispSO so) throws Exception {
		
		if(!StringUtil.isEmpty(so.getDispClsfNo())) {
			if(Long.valueOf(webConfig.getProperty("disp.clsf.no.petshop.dog")).equals(so.getDispClsfNo())) {
				so.setCateCdL(Long.valueOf(webConfig.getProperty("disp.clsf.no.dog")));    // 12564
			}else if(Long.valueOf(webConfig.getProperty("disp.clsf.no.petshop.cat")).equals(so.getDispClsfNo())) {
				so.setCateCdL(Long.valueOf(webConfig.getProperty("disp.clsf.no.cat")));
			}else if(Long.valueOf(webConfig.getProperty("disp.clsf.no.petshop.fish")).equals(so.getDispClsfNo())) {
				so.setCateCdL(Long.valueOf(webConfig.getProperty("disp.clsf.no.fish")));
			}else if(Long.valueOf(webConfig.getProperty("disp.clsf.no.petshop.animal")).equals(so.getDispClsfNo())) {
				so.setCateCdL(Long.valueOf(webConfig.getProperty("disp.clsf.no.animal")));
			}

			view.setDispClsfNo(so.getDispClsfNo());

		}else {
			// LNB에서 넘어올 경우
			String dlgtPetGbCd = "";
			
			if(Long.valueOf(webConfig.getProperty("disp.clsf.no.petshop.dog")).equals(so.getLnbDispClsfNo())) {
				so.setCateCdL(Long.valueOf(webConfig.getProperty("disp.clsf.no.dog")));	// 12564
			} else if (Long.valueOf(webConfig.getProperty("disp.clsf.no.petshop.cat")).equals(so.getLnbDispClsfNo())) {
				so.setCateCdL(Long.valueOf(webConfig.getProperty("disp.clsf.no.cat")));
			} else if (Long.valueOf(webConfig.getProperty("disp.clsf.no.petshop.fish")).equals(so.getLnbDispClsfNo())) {
				so.setCateCdL(Long.valueOf(webConfig.getProperty("disp.clsf.no.fish")));
			} else if (Long.valueOf(webConfig.getProperty("disp.clsf.no.petshop.animal")).equals(so.getLnbDispClsfNo())) {
				so.setCateCdL(Long.valueOf(webConfig.getProperty("disp.clsf.no.animal")));
			}
			
			view.setDispClsfNo(so.getLnbDispClsfNo());
			// session에 현재 전시카테고리 번호 넣기
			session.setDispClsfNo(view.getDispClsfNo());
			// LNB 반려동물(강아지/고양이) 변경처리
			if(!session.getMbrNo().equals(CommonConstants.NO_MEMBER_NO)) {
				dlgtPetGbCd = displayService.updatePetGbCdLnbHistory(so.getLnbDispClsfNo(), session.getMbrNo());
				session.setPetGbCd(dlgtPetGbCd);
			}
			FrontSessionUtil.setSession(session);
		}

		//카테고리
		DisplayCornerItemSO dciSo = new DisplayCornerItemSO();
		dciSo.setDispClsfNo(view.getDispClsfNo());
		dciSo.setDispCornTpCd(CommonConstants.DISP_CORN_TP_30);
		view.setDisplayShortCutList(this.displayService.getBnrImgListFO(dciSo));
		view.setSeoSvcGbCd(FrontWebConstants.SEO_SVC_GB_CD_10);

		so.setDeviceGb(view.getDeviceGb());
		so.setMbrNo(session.getMbrNo());
		so.setDispClsfNo(so.getCateCdL());

		map.put("session", session);
		map.put("view", view);
		map.put("so", so);

		return "/petshop/indexLive";
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명		: gs-apet-31-front
	 * - 파일명		: PetShopController.java
	 * - 작성일		: 2021. 3. 10. 
	 * - 작성자		: YJU
	 * - 설명			: 펫샵 카테고리 신상품 목록
	 * </pre>
	 * @param map
	 * @param session
	 * @param view
	 * @param so
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="indexNewCategory", method = RequestMethod.GET)
	public String indexNewCategory(ModelMap map, Session session, ViewBase view, GoodsDispSO so, String page) throws Exception {
		
		String dlgtPetGbCd = "";
		// LNB변경으로 넘어올 경우 
		if(!StringUtil.isEmpty(so.getLnbDispClsfNo())) {
			// LNB 반려동물(강아지/고양이) 변경처리
			if(!session.getMbrNo().equals(CommonConstants.NO_MEMBER_NO)) {
				dlgtPetGbCd = displayService.updatePetGbCdLnbHistory(so.getLnbDispClsfNo(), session.getMbrNo());
				session.setPetGbCd(dlgtPetGbCd);
			}
		}else {
			// 버튼 클릭으로 넘어올 경우
			so.setLnbDispClsfNo(so.getDispClsfNo());
		}
		
		view.setDispClsfNo(so.getLnbDispClsfNo());	// 300000173
		
		// session에 현재 전시카테고리 번호 넣기
		session.setDispClsfNo(so.getLnbDispClsfNo());
		FrontSessionUtil.setSession(session); 
		// 아이콘 리스트
		DisplayCornerItemSO dciSo = new DisplayCornerItemSO();
		dciSo.setDispClsfNo(so.getLnbDispClsfNo());
		dciSo.setDispCornTpCd(CommonConstants.DISP_CORN_TP_30);
		view.setDisplayShortCutList(this.displayService.getBnrImgListFO(dciSo));
		
		// 전시 분류 번호 셋팅
		if(Long.valueOf(webConfig.getProperty("disp.clsf.no.petshop.dog")).equals(so.getLnbDispClsfNo())) {
			so.setCateCdL(Long.valueOf(webConfig.getProperty("disp.clsf.no.dog")));	// 12564
		} else if (Long.valueOf(webConfig.getProperty("disp.clsf.no.petshop.cat")).equals(so.getLnbDispClsfNo())) {
			so.setCateCdL(Long.valueOf(webConfig.getProperty("disp.clsf.no.cat")));
		} else if (Long.valueOf(webConfig.getProperty("disp.clsf.no.petshop.fish")).equals(so.getLnbDispClsfNo())) {
			so.setCateCdL(Long.valueOf(webConfig.getProperty("disp.clsf.no.fish")));
		} else if (Long.valueOf(webConfig.getProperty("disp.clsf.no.petshop.animal")).equals(so.getLnbDispClsfNo())) {
			so.setCateCdL(Long.valueOf(webConfig.getProperty("disp.clsf.no.animal")));
		}
		
		GoodsDispSO gso = new GoodsDispSO();
		String[] icons = {so.getDispCornType()};
		gso.setStId(view.getStId());
		gso.setMbrNo(session.getMbrNo());
		gso.setDeviceGb(view.getDeviceGb());
		
		if(StringUtil.isEmpty(so.getCateCdM())) {
			so.setCateCdM(so.getCateCdL());
		}
		
		gso.setDispClsfNo(so.getCateCdM());
		gso.setIcons(icons);
		gso.setSalePeriodYn(CommonConstants.COMM_YN_N);
		gso.setSaleOutYn(CommonConstants.COMM_YN_Y);
		gso.setOrder(StringUtils.isNotEmpty(so.getOrder()) ? so.getOrder() : "SALE");
		gso.setPage((so.getPage()!= 0) ? so.getPage() : 0);
		
		List<GoodsDispVO> newGoodsCategoryList = goodsDispService.getGoodsCategoryNew(gso);
		int goodsCount = goodsDispService.countGoodsNew(gso);
		Set<GoodsDispVO> categorySet = new LinkedHashSet<>();
		if(newGoodsCategoryList.size() > 0) {
			List<String> cateCdMStr = newGoodsCategoryList.stream().map(GoodsDispVO::getCateCdMStr).collect(Collectors.toList());
			List<String> cateNmMStr = newGoodsCategoryList.stream().map(GoodsDispVO::getCateNmM).collect(Collectors.toList());
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
		
		map.put("session", session);
		map.put("view", view);
		map.put("so", so);
		map.put("dispClsfNo", gso.getDispClsfNo());
		map.put("categoryList", categoryList);
		map.put("goodsCount", goodsCount);
		
		return  TilesView.none(new String[]{"petshop", "indexPetShopNewGoods"});
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명		: gs-apet-31-front
	 * - 파일명		: PetShopController.java
	 * - 작성일		: 2021. 3. 4. 
	 * - 작성자		: YJU
	 * - 설명			: 전시분류별 신상품 
	 * </pre>
	 * @param map
	 * @param session
	 * @param view
	 * @param so
	 * @param page
	 * @param searchVo
	 * @return
	 */
	@RequestMapping(value="getNewGoodsList")
	public String getNewGoodsList(ModelMap map, Session session, ViewBase view, GoodsDispSO so, String page){
		
		// DISP_LVL_3 dispClsfNo 12569 - 사료 전시
		// upDispClsfNo 12564 - 강아지  --> 배너
		// dispClsfNo2 300000173L
		// DISP_LVL_1 cateCdL
		// DISP_LVL_2 cateCdM
		
		GoodsDispSO gso = new GoodsDispSO();
		String[] icons = {so.getDispCornType()};
		gso.setStId(view.getStId());
		gso.setMbrNo(session.getMbrNo());
		gso.setDeviceGb(view.getDeviceGb());
		
		if(StringUtil.isEmpty(so.getCateCdM())) {
			so.setCateCdM(so.getCateCdL());
		}
		
		gso.setDispClsfNo(so.getCateCdM());
		gso.setIcons(icons);
		gso.setSalePeriodYn(CommonConstants.COMM_YN_N);
		gso.setSaleOutYn(CommonConstants.COMM_YN_Y);
		gso.setOrder(so.getOrder());
		gso.setRows(so.getRows());		// 20으로 수정
		
		List<GoodsDispVO> goodsList = goodsDispService.getGoodsNew(gso);
		int goodsCount = goodsDispService.countGoodsNew(gso);
		
		map.put("dispClsfNo", gso.getDispClsfNo());
		map.put("goodsList", goodsList);
		map.put("goodsCount", goodsCount);
		
		return  TilesView.none(new String[]{"petshop", "include", "petShopNewGoods"});
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명		: gs-apet-31-front
	 * - 파일명		: PetShopController.java
	 * - 작성일		: 2021. 3. 4. 
	 * - 작성자		: YJU
	 * - 설명			: 전시분류별 신상품 
	 * </pre>
	 * @param map
	 * @param session
	 * @param view
	 * @param so
	 * @param page
	 * @param searchVo
	 * @return
	 */
	@RequestMapping(value="getNewGoodsPagingList")
	public String getNewGoodsPagingList(ModelMap map, Session session, ViewBase view, GoodsDispSO so){
		
		// DISP_LVL_3 dispClsfNo 12569 - 사료 전시
		// upDispClsfNo 12564 - 강아지  --> 배너
		// dispClsfNo2 300000173L
		// DISP_LVL_1 cateCdL
		// DISP_LVL_2 cateCdM
		
		GoodsDispSO gso = new GoodsDispSO();
		String[] icons = {so.getDispCornType()};
		gso.setStId(view.getStId());
		gso.setMbrNo(session.getMbrNo());
		gso.setDeviceGb(view.getDeviceGb());
		
		if(StringUtil.isEmpty(so.getCateCdM())) {
			so.setCateCdM(so.getCateCdL());
		}
		
		gso.setDispClsfNo(so.getCateCdM());
		gso.setIcons(icons);
		gso.setSalePeriodYn(CommonConstants.COMM_YN_N);
		gso.setSaleOutYn(CommonConstants.COMM_YN_Y);
		gso.setOrder(so.getOrder());
		gso.setPage(so.getPage());
		gso.setRows(so.getRows());
		
		List<GoodsDispVO> goodsList = goodsDispService.getGoodsNew(gso);
		int goodsCount = goodsDispService.countGoodsNew(gso);
		
		map.put("goodsList", goodsList);
		map.put("so", so);
		
		return  TilesView.none(new String[]{"petshop", "include", "petShopNewGoodsPaging"});
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명		: gs-apet-31-front
	 * - 파일명		: PetShopController.java
	 * - 작성일		: 2021. 3. 10. 
	 * - 작성자		: YJU
	 * - 설명			: 펫샵 태그모아보기(상품 목록)
	 * </pre>
	 * @param map
	 * @param session
	 * @param view
	 * @param so
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="indexPetShopTagGoods", method = RequestMethod.GET)
	public String indexPetShopTagGoods(ModelMap map, Session session, ViewBase view, GoodsDispSO so, String page) throws Exception {

		GoodsDispSO gso = new GoodsDispSO();
		gso.setStId(view.getStId());
		gso.setMbrNo(session.getMbrNo());
		gso.setDeviceGb(view.getDeviceGb());
		gso.setTags(so.getTags());
		gso.setDispClsfNo(Long.valueOf(CommonConstants.DISP_CLSF_10));
		gso.setSalePeriodYn(CommonConstants.COMM_YN_N);
		gso.setSaleOutYn(CommonConstants.COMM_YN_Y);
		gso.setOrder(StringUtils.isNotEmpty(so.getOrder()) ? so.getOrder() : "SALE");
		gso.setPage(so.getPage());
		gso.setRows(FrontConstants.PAGE_ROWS_20);
		
		List<GoodsDispVO> categoryGoodsList = goodsDispService.getGoods(gso);

		//필터 조회
		if(categoryGoodsList.size() > 0) {
			List<String> goodsIds = categoryGoodsList.stream().map(GoodsDispVO::getGoodsId).collect(Collectors.toList());
			map.put("goodsIds",goodsIds);
			int goodsCount = goodsDispService.countGoods(gso);
			map.put("goodsCount", goodsCount);
		}
		
		map.put("session", session);
		map.put("view", view);
		map.put("so", so);
		map.put("categoryGoodsList", categoryGoodsList);
		
		return  TilesView.none(new String[]{"petshop", "indexPetShopTagGoods"});
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명		: gs-apet-31-front
	 * - 파일명		: PetShopController.java
	 * - 작성일		: 2021. 3. 4. 
	 * - 작성자		: YJU
	 * - 설명			: 태그상품 목록 sort
	 * </pre>
	 * @param map
	 * @param session
	 * @param view
	 * @param so
	 * @param page
	 * @param searchVo
	 * @return
	 */
	@RequestMapping(value="getSortTagGoodsList")
	public String getSortTagGoodsList(ModelMap map, Session session, ViewBase view, GoodsDispSO so, String page){
		
		GoodsDispSO gso = new GoodsDispSO();
		gso.setStId(view.getStId());
		gso.setMbrNo(session.getMbrNo());
		gso.setDeviceGb(view.getDeviceGb());
		gso.setFilters(so.getFilters());
		gso.setFilterCount(so.getFilters() != null ? so.getFilters().size() : 0);
		gso.setBndNos(so.getBndNos());
		gso.setTags(so.getTags());
		gso.setDispClsfNo(Long.valueOf(CommonConstants.DISP_CLSF_10));
		gso.setSalePeriodYn(CommonConstants.COMM_YN_N);
		gso.setSaleOutYn(CommonConstants.COMM_YN_Y);
		gso.setOrder(so.getOrder());
		gso.setPage(so.getPage());
		gso.setRows(FrontConstants.PAGE_ROWS_20);
		
		List<GoodsDispVO> categoryGoodsList = goodsDispService.getGoods(gso);
		int goodsCount = goodsDispService.countGoods(gso);
		
		map.put("session", session);
		map.put("view", view);
		map.put("categoryGoodsList", categoryGoodsList);
		map.put("goodsCount", goodsCount);
		map.put("so", so);
		
//		map.put("petSo", so.getPage());
		return  TilesView.none(new String[]{"petshop", "include", "petShopTagsGoods"});
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명    : gs-apet-31-front
	 * - 파일명        : PetShopController.java
	 * - 작성일        : 2021. 3. 22.
	 * - 작성자        : YKU
	 * - 설명          : 필터상품 카운트
	 * </pre>
	 * @param map
	 * @param session
	 * @param view
	 * @param so
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="getPackageGoodsCount")
	public ModelMap getPackageGoodsCount(Session session, ViewBase view, GoodsDispSO so){
		ModelMap map = new ModelMap();
		map.put("filters", so.getFilters());
		so.setStId(view.getStId());
		so.setMbrNo(session.getMbrNo());
		so.setDispType(CommonConstants.GOODS_MAIN_DISP_TYPE_PACKAGE);
		so.setFilters(so.getFilters());
		so.setDeviceGb(view.getDeviceGb());
		so.setSalePeriodYn(CommonConstants.COMM_YN_N);
		so.setSaleOutYn(CommonConstants.COMM_YN_N);
		int count = goodsDispService.countGoodsPackage(so);
		map.put("so", so);
		map.put("count", count);
		return map;
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명    : gs-apet-31-front
	 * - 파일명        : PetShopController.java
	 * - 작성일        : 2021. 3. 31.
	 * - 작성자        : PKT
	 * - 설명          : 배너 코너 아이템 조회
	 * </pre>
	 * @param map
	 * @param session
	 * @param view
	 * @param so
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="getDisplayCommonCornerItemFO")
	public ModelMap getDisplayCommonCornerItemFO(){
		ModelMap map = new ModelMap();
		//비정형 펫샵 공통 전시 분류 번호
		Long dispClsfNo = Long.valueOf(webConfig.getProperty("disp.clsf.no.petshop"));
		List<DisplayCornerTotalVO> list = displayService.getDisplayCornerItemTotalFO(dispClsfNo, null);
		map.put("cornerList", list);
		return map;
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명		: gs-apet-31-front
	 * - 파일명		: PetShopController.java
	 * - 작성일		: 2021. 4. 6. 
	 * - 작성자		: YJU
	 * - 설명			: 맞춤추천 다른 반려동물 조회
	 * </pre>
	 * @param map
	 * @param session
	 * @param view
	 * @param so
	 * @param page
	 * @return
	 */
	@RequestMapping(value="getRecOtherPetGoodsList", method=RequestMethod.GET)
	public String getRecOtherPetGoodsList(ModelMap map, Session session, ViewBase view, GoodsDispSO so) {
		
		if(StringUtil.isNotEmpty(so.getPetNos())) {
			String[] petNoSplit = so.getPetNos().split(",");
			
			// 보안진단 처리 - 적절하지 않은 난수값 사용
			SecureRandom random = new SecureRandom();
			
			String ranPetNo = petNoSplit[random.nextInt(petNoSplit.length)];
			so.setPetNo(Long.parseLong(ranPetNo));
		}
		
		so.setDeviceGb(view.getDeviceGb());
		List<GoodsDispVO> recommendGoodsList = displayService.getRecOtherPetGoodsList(so);
		
		map.put("recommendGoodsList", recommendGoodsList);
		map.put("so", so);
		map.put("view", view);

		return "/petshop/goods/cornerRecommendGoods";
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명    : gs-apet-31-front
	 * - 파일명        : PetShopController.java
	 * - 작성일        : 2021. 8. 10.
	 * - 작성자        : valFac
	 * - 설명          : 최근본 상품 단건 조회
	 * </pre>
	 * @param map
	 * @param session
	 * @param view
	 * @param so
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="getOneGoodsDtlInqrHist")
	public ModelMap getOneGoodsDtlInqrHist(Long mbrNo){
		ModelMap map = new ModelMap();
		GoodsBaseVO dtlHist = null;
		if(StringUtil.isNotEmpty(mbrNo) && !mbrNo.equals(CommonConstants.NO_MEMBER_NO)) {	// DB조회
			GoodsDtlInqrHistSO dtlHistSO = new GoodsDtlInqrHistSO();
			dtlHistSO.setMbrNo(mbrNo);
			dtlHist = goodsDtlInqrHistService.getOneGoodsDtlInqrHist(dtlHistSO);
		}else {															// 쿠키 조회
			List<GoodsBaseVO> listCookie = frontLoginService.getRcntGoodsFromCookie();
				if(listCookie != null && listCookie.size() > 0) {
					GoodsDtlInqrHistSO dtlHistSO = new GoodsDtlInqrHistSO();
					dtlHistSO.setCookieYn(CommonConstants.COMM_YN_Y);
					String[] goodsIds = {listCookie.get(0).getGoodsId()};
					dtlHistSO.setGoodsIds(goodsIds);
					dtlHist = goodsDtlInqrHistService.getOneGoodsDtlInqrHist(dtlHistSO);
				}
		}
		map.put("dtlHist", dtlHist);
		return map;
	}
}
