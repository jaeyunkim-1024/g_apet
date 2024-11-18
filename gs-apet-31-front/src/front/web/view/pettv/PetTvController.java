package front.web.view.pettv;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.stream.Collectors;

import org.apache.commons.lang.StringUtils;
import org.codehaus.jackson.JsonParseException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import biz.app.banner.model.BannerVO;
import biz.app.contents.model.SeriesVO;
import biz.app.contents.model.VodSO;
import biz.app.contents.model.VodVO;
import biz.app.contents.service.VodService;
import biz.app.display.dao.DisplayDao;
import biz.app.display.model.DisplayCornerItemSO;
import biz.app.display.model.DisplayCornerSO;
import biz.app.display.model.DisplayCornerTotalVO;
import biz.app.display.model.SeoInfoSO;
import biz.app.display.model.SeoInfoVO;
import biz.app.display.service.DisplayService;
import biz.app.display.service.SeoService;
import biz.app.goods.model.GoodsDispSO;
import biz.app.goods.model.GoodsRelatedSO;
import biz.app.goods.service.GoodsService;
import biz.app.member.model.MemberBasePO;
import biz.app.member.model.MemberBaseSO;
import biz.app.member.model.MemberBaseVO;
import biz.app.member.service.MemberService;
import biz.app.system.model.CodeDetailVO;
import biz.app.tag.model.TagBaseSO;
import biz.app.tag.model.TagBaseVO;
import biz.app.tag.service.TagService;
import biz.app.tv.model.TvDetailPO;
import biz.app.tv.service.TvDetailService;
import biz.common.service.CacheService;
import framework.common.constants.CommonConstants;
import framework.common.enums.SearchApiSpec;
import framework.common.util.DateUtil;
import framework.common.util.NhnShortUrlUtil;
import framework.common.util.SearchApiUtil;
import framework.common.util.StringUtil;
import framework.front.model.Session;
import front.web.config.constants.FrontWebConstants;
import front.web.config.tiles.TilesView;
import front.web.config.view.ViewBase;
import lombok.extern.slf4j.Slf4j;

/**
* <pre>
* - 프로젝트명	: 31.front.web
* - 패키지명		: front.web.view.pettv.controller
* - 파일명		: petTvController.java
* - 작성일		: 2017. 4. 19.
* - 작성자		: cja
* - 설명			: 펫TV Contorller
* </pre>
*/

@Slf4j
@Controller
public class PetTvController {
	
	@Autowired 
	private DisplayService displayService;
	
	@Autowired 
	private Properties webConfig;

	@Autowired 
	private MemberService memberService;
		
	@Autowired
	private SearchApiUtil searchApiUtil;
	
	@Autowired
	private VodService vodService;
	
	@Autowired 
	private SeoService seoService;
	
	@Autowired 
	private DisplayDao displayDao;
	
	@Autowired 
	private CacheService cacheService;
	
	@Autowired private NhnShortUrlUtil NhnShortUrlUtil;
	
	@Autowired private TvDetailService tvDetailService;
	
	@Autowired private GoodsService goodsService;
	
	@Autowired private TagService tagService;
	
	/**
	 * <pre>
	 * - 메소드명	: petTvMainView
	 * - 작성일	: 2020. 06. 09.
	 * - 작성자	: CJA
	 * - 설명		: 펫TV 메인 화면
	 * </pre>
	 * 
	 * @param map
	 * @param view
	 * @param session
	 * @param so
	 * @return String
	 * @throws Exception
	 */
	@RequestMapping(value = "/tv/home", method = RequestMethod.GET)
	public String petTvMainView(ModelMap map, ViewBase view, Session session, DisplayCornerSO so) throws Exception {
		// BO 의 미리보기 시 previewDt 가 들어옴.
		if( StringUtil.isEmpty(so.getPreviewDt()) ) {
			so.setPreviewDt(DateUtil.getNowDate());
		}
		
		//비정형 펫tv 전시 분류 번호
		Long dispClsfNo = Long.valueOf(webConfig.getProperty("site.main.tv.disp.clsf.no"));
		
		so.setDispClsfNo(dispClsfNo);
		
		//비정형 펫tv 전시 코너의 따른 리스트
		List<DisplayCornerTotalVO> cornerList = displayService.getPetTvDisplayCornerItemTotalFO(dispClsfNo, session, so);
		
		view.setSeoSvcGbCd(FrontWebConstants.SEO_SVC_GB_CD_20);
		
		//seo 정보
		SeoInfoSO seoSo = new SeoInfoSO();
		seoSo.setSeoInfoNo(cornerList.get(0).getSeoInfoNo());
		seoSo.setSeoSvcGbCd(view.getSeoSvcGbCd());
		SeoInfoVO seoInfo = seoService.getSeoInfoFO(seoSo, false);
		
		map.put("cornerList", cornerList);
		map.put("session", session);
		map.put("seoInfo", seoInfo);
		map.put("view", view);
		
		return "/pettv/petTvMainView";
	}
	
	/**
	 * <pre>
	 * - 메소드명	: petTvMainView
	 * - 작성일	: 2020. 06. 09.
	 * - 작성자	: CJA
	 * - 설명		: 펫TV 메인 > 관심 태그 변경(클릭시) 관련 영상 리스트
	 * </pre>
	 * 
	 * @param session
	 * @param so
	 * @return ModelMap
	 */
	@ResponseBody
	@RequestMapping(value = "/tv/tvTagVodList", method = RequestMethod.POST)
	public ModelMap tvTagVodList(Session session, TagBaseSO so) {
		ModelMap modelmap = new ModelMap();
		
		so.setRows(FrontWebConstants.PAGE_ROWS_10);
		so.setSidx("HITS");
		so.setSord("DESC");
		List<VodVO> list = displayService.tagVodList(so);
		
		//관심 태그 영상 랜덤 리스트
		//Collections.shuffle(list);
		
		modelmap.put("tagVodList", list);
		
		return modelmap;
	}
	
	/**
	 * <pre>
	 * - 메소드명	: petTvMainView
	 * - 작성일	: 2020. 06. 09.
	 * - 작성자	: CJA
	 * - 설명		: 펫 스쿨 홈
	 * </pre>
	 * 
	 * @param map
	 * @param session
	 * @param view
	 * @param so
	 * @return String
	 */
	@RequestMapping(value = "/tv/petSchool{vdHist}")
	public String petSchool(ModelMap map, Session session, ViewBase view, VodSO so, @PathVariable String vdHist) {
		//로그인 시 펫스쿨 페이지 첫 진입 여부 확인
		if(!session.getMbrNo().equals(CommonConstants.NO_MEMBER_NO)) {
			MemberBaseSO mso = new MemberBaseSO();
			mso.setMbrNo(session.getMbrNo());
			
			MemberBaseVO memberVO = memberService.getMemberBase(mso);
			
			so.setMbrNo(session.getMbrNo());
			int cnt = displayService.selectEduWatchCount(so);
			
			/*
			 * 소개영상(교육Intro) 시청한 이력이 있으면 무조건 재진입으로 판단(PET_SCHL_YN='Y')
			 * 소개영상(교육Intro) 시청한 이력이 없고 교육영상 5초이상 시청한 이력으로 재진입으로 판단(PET_SCHL_YN='Y')
			 * 소개영상(교육Intro) 시청한 이력이 없고 교육영상 시청한 이력이 없으면 최초진입으로 판단(PET_SCHL_YN='N') 
			 */
			MemberBasePO po = new MemberBasePO();
			po.setMbrNo(session.getMbrNo());
			if( (StringUtil.isEmpty(memberVO.getPetSchlYn()) || memberVO.getPetSchlYn().equals("N")) && cnt > 0) {
				po.setPetSchlYn("Y");
				memberService.updateMemberBase(po);
				
				memberVO.setPetSchlYn("Y");
			}else if(memberVO.getPetSchlYn().equals("Y") && cnt == 0) {
				po.setPetSchlYn("N");
				memberService.updateMemberBase(po);
				
				memberVO.setPetSchlYn("N");
			}
			
			map.put("memberVO", memberVO);
		}
		
		//펫 구분
		List<CodeDetailVO> petGbList = cacheService.listCodeCache(CommonConstants.PET_GB, true, null, null, null, "Y", null);
		//M 카테고리 구분
		List<CodeDetailVO> mCtgList = cacheService.listCodeCache(CommonConstants.EUD_CONTS_CTG_M, true, null, null, null, null, null);
		
		String petGbCd = petGbList.get(0).getDtlCd();
		//메인 배너
		if(petGbList.size() > 0) {
			//펫tv 메인에서 진입시 펫스쿨영상 리스트의 petGbCd를 참조하여 펫스쿨홈 화면 구성. 우선순위 : 마지막 본 영상의 카테고리 > 로그인한 사용자의 대표 펫 카테고리 > 강아지 ( 기본 )  2021-05-14			
			//so.setPetGbCd(petGbList.get(0).getDtlCd());
			if(StringUtil.isNotEmpty(so.getPgCd())) {//카테고리를 넘겨 받았으면
				for(CodeDetailVO cvo : petGbList) {
					if(cvo.getDtlCd().equals(so.getPgCd())) {
						petGbCd = so.getPgCd();
					}
				}
			}else {
				if(!session.getMbrNo().equals(CommonConstants.NO_MEMBER_NO)) {//로그인 했으면..
					if(StringUtil.isNotEmpty(session.getPetGbCd())) {//대표펫 등록 했으면
						petGbCd = session.getPetGbCd();
					}
				}
			}
			so.setPetGbCd(petGbCd);
		}
		
		List<VodVO> mainBanner = displayService.schoolMainBanner(so);
		
		List<VodVO> educationList = null;
		
		List<VodVO> vodList = new ArrayList<>();
		
		if (petGbList.size() > 0 && mCtgList.size() > 0) {
			for (int i = 0; i < petGbList.size(); i++) {
				for (int j = 0; j < mCtgList.size(); j++) {
					VodSO bso = new VodSO();
					bso.setMbrNo(session.getMbrNo());
					bso.setPetGbCd(petGbCd);
					bso.setEudContsCtgMCd(mCtgList.get(j).getDtlCd());

					educationList = displayService.schoolEduVod(bso);
					
					for (VodVO eduWatchVO : educationList) {
						if (eduWatchVO.getLodCd().equals(CommonConstants.APET_LOD_10)) {
							eduWatchVO.setLodCd("1");
						} else if (eduWatchVO.getLodCd().equals(CommonConstants.APET_LOD_20)) {
							eduWatchVO.setLodCd("2");
						} else {
							eduWatchVO.setLodCd("3");
						}
					}
					
					vodList.addAll(educationList);
				}
				if(!StringUtil.isEmpty(vodList)) {
					break;
				}
			}
		}

		List<String> listGb = vodList.stream()
				.map(p -> p.getCtgMnm()).distinct()
				.collect(Collectors.toList());
		
		List<CodeDetailVO> petGbs = new ArrayList<>();
		List<VodVO> vodLists = new ArrayList<>();
		
		if (petGbList.size() > 0 && mCtgList.size() > 0) {
			for (int i = 0; i < petGbList.size(); i++) {
				for (int j = 0; j < mCtgList.size(); j++) {
					VodSO bso = new VodSO();
					bso.setMbrNo(session.getMbrNo());
					bso.setPetGbCd(petGbList.get(i).getDtlCd());
					bso.setEudContsCtgMCd(mCtgList.get(j).getDtlCd());

					educationList = displayService.schoolEduVod(bso);

					vodLists.addAll(educationList);
				}
				
				if(!StringUtil.isEmpty(vodLists)) {
					petGbs.add(petGbList.get(i));
					vodLists.clear();
				}
			}
		}
		
		map.put("vdHist", vdHist);
		map.put("petGbs", petGbs);
		map.put("listGb", listGb);
		map.put("mCtgList", mCtgList);
		map.put("petGbList", petGbList);
		map.put("mainBanner", mainBanner);
		map.put("educationList", vodList);
		map.put("view", view);
		map.put("session", session);
		map.put("petGbCd", petGbCd);
		
		return "/pettv/petSchoolList";
	}
	
	/**
	 * <pre>
	 * - 메소드명	: petTvMainView
	 * - 작성일	: 2020. 06. 09.
	 * - 작성자	: CJA
	 * - 설명		: 펫 스쿨 홈(강아지/고양이) 목록
	 * </pre>
	 * 
	 * @param  session
	 * @param  view
	 * @param  so
	 * @return ModelMap
	 */
	@ResponseBody
	@RequestMapping(value = "/tv/petSchoolGb", method = RequestMethod.POST)
	public ModelMap petSchoolGbList(Session session, ViewBase view, VodSO so) {
		ModelMap modelMap = new ModelMap();
		
		MemberBaseSO mso = new MemberBaseSO();
		mso.setMbrNo(session.getMbrNo());
		MemberBaseVO memberVO = memberService.getMemberBase(mso);
		
		//메인 배너
		List<VodVO> mainBanner = displayService.schoolMainBanner(so);
		List<CodeDetailVO> mCtgList = cacheService.listCodeCache(CommonConstants.EUD_CONTS_CTG_M, true, null, null, null, null, null);
		List<VodVO> educationList = null;
		List<VodVO> getList = new ArrayList<>();
		
		for (int i = 0; i < mCtgList.size(); i++) {
			VodSO bso = new VodSO();
			bso.setMbrNo(session.getMbrNo());
			bso.setPetGbCd(so.getPetGbCd());
			bso.setEudContsCtgMCd(mCtgList.get(i).getDtlCd());

			educationList = displayService.schoolEduVod(bso);
			getList.addAll(educationList);
		}
		
		List<String> listGb = getList.stream()
				.map(p -> p.getCtgMnm()).distinct()
				.collect(Collectors.toList());
		
		modelMap.put("memberVO", memberVO);
		modelMap.put("mainBanner", mainBanner);
		modelMap.put("view", view);
		modelMap.put("listGb", listGb);
		modelMap.put("getList", getList);
		modelMap.put("session", session);
		
		return modelMap;
	}
	
	/**
	 * <pre>
	 * - 메소드명	: petTvMainView
	 * - 작성일	: 2020. 06. 09.
	 * - 작성자	: CJA
	 * - 설명		: 관심태그 영상 리스트 화면
	 * </pre>
	 * 
	 * @param map
	 * @param session
	 * @param view
	 * @param so
	 * @return String
	 */
	@RequestMapping(value = "/tv/hashTagList", method = RequestMethod.GET)
	public String hashTagList(ModelMap map, Session session, ViewBase view, TagBaseSO so) throws Exception {
		so.setSidx("HITS");
		so.setSord("DESC");
		so.setRows(12);
		so.setMbrNo(session.getMbrNo());
		
		//관심 태그 첫번재 영상 리스트
		List<VodVO> tagVodList = displayService.tagVodList(so);
		if(!tagVodList.isEmpty()) {
			for(int i = 0; i < tagVodList.size(); i++) {
				//ShortUrl 생성
				if(tagVodList.get(i).getSrtUrl() == null) {
					//단축URL 생성 후 저장
					String domainStr = "";
					if(view.getEnvmtGbCd().equals("local")) {
						domainStr = "https://dev.aboutpet.co.kr";
					}else {
						domainStr = view.getStDomain();
					}
					
					String originUrl = domainStr+"/tv/series/indexTvShare?vdId="+tagVodList.get(i).getVdId()+"&sortCd=&listGb=HOME";
			        String shortUrl = NhnShortUrlUtil.getUrl(originUrl);
			        TvDetailPO tvDetailPO = new TvDetailPO();
			        tvDetailPO.setVdId(tagVodList.get(i).getVdId());
			        tvDetailPO.setSrtUrl(shortUrl);
			        tvDetailService.updateVdoShortUrl(tvDetailPO);
			        tagVodList.get(i).setSrtUrl(shortUrl);
				}
				
				//태그
				VodSO vso = new VodSO();
				vso.setVdId(tagVodList.get(i).getVdId());
				List<VodVO> tag = vodService.listGetTag(vso);
				tagVodList.get(i).setTagList(tag);
				
				int relatedGoodsCount = 0;
				//V-커머스 일때만 조회(10=일반, 20=V-커머스)
				if("20".equals(tagVodList.get(i).getVdTpCd())) {
					//연관상품 개수
					GoodsRelatedSO goodsRelatedSo = new GoodsRelatedSO();
					goodsRelatedSo.setVdId(tagVodList.get(i).getVdId());
					goodsRelatedSo.setWebMobileGbCd(view.getDeviceGb());
					goodsRelatedSo.setStId(view.getStId());
					relatedGoodsCount  = goodsService.getGoodsRelatedWithTvCount(goodsRelatedSo);
				}
				tagVodList.get(i).setGoodsCount(relatedGoodsCount);
			}
		}
		
		TagBaseVO tvo = tagService.getTagInfo(so);
		
		VodSO vso = new VodSO();
		
		//랜덤으로 시리즈 가져오기
		VodVO random = vodService.srisRandom(vso);
		
		map.put("so", so);
		map.put("random", random);
		map.put("tvo", tvo);
		map.put("optimalVodList", tagVodList);
		map.put("session", session);
		map.put("view", view);
		
		return "/pettv/hashtagList";
	}
	
	/**
	 * <pre>
	 * - 메소드명	: petTvMainView
	 * - 작성일	: 2020. 06. 09.
	 * - 작성자	: CJA
	 * - 설명		: 관심태그 영상 리스트 목록 더보기
	 * </pre>
	 * 
	 * @param map
	 * @param session
	 * @param view
	 * @param so
	 * @param page
	 * @return String
	 */
	@RequestMapping(value = "/tv/moreVideo", method = RequestMethod.POST)
	public String moreVideo(ModelMap map, Session session, ViewBase view, TagBaseSO so , Integer page) throws Exception {
		so.setSidx("HITS");
		so.setSord("DESC");
		so.setRows(12);
		so.setPage(page);
		so.setMbrNo(session.getMbrNo());
		
		//관심 태그 추가 영상 리스트
		List<VodVO> tagVodList = displayService.tagVodList(so);
		if(!tagVodList.isEmpty()) {
			for(int i = 0; i < tagVodList.size(); i++) {
				//ShortUrl 생성
				if(tagVodList.get(i).getSrtUrl() == null) {
					//단축URL 생성 후 저장
					String domainStr = "";
					if(view.getEnvmtGbCd().equals("local")) {
						domainStr = "https://dev.aboutpet.co.kr";
					}else {
						domainStr = view.getStDomain();
					}
					
					String originUrl = domainStr+"/tv/series/indexTvShare?vdId="+tagVodList.get(i).getVdId()+"&sortCd=&listGb=HOME";
			        String shortUrl = NhnShortUrlUtil.getUrl(originUrl);
			        TvDetailPO tvDetailPO = new TvDetailPO();
			        tvDetailPO.setVdId(tagVodList.get(i).getVdId());
			        tvDetailPO.setSrtUrl(shortUrl);
			        tvDetailService.updateVdoShortUrl(tvDetailPO);
			        tagVodList.get(i).setSrtUrl(shortUrl);
				}
				
				VodSO vso = new VodSO();
				vso.setVdId(tagVodList.get(i).getVdId());
				//태그
				List<VodVO> tag = vodService.listGetTag(vso);
				tagVodList.get(i).setTagList(tag);
				
				int relatedGoodsCount = 0;
				//V-커머스 일때만 조회(10=일반, 20=V-커머스)
				if("20".equals(tagVodList.get(i).getVdTpCd())) {
					//연관상품 개수
					GoodsRelatedSO goodsRelatedSo = new GoodsRelatedSO();
					goodsRelatedSo.setVdId(tagVodList.get(i).getVdId());
					goodsRelatedSo.setWebMobileGbCd(view.getDeviceGb());
					goodsRelatedSo.setStId(view.getStId());
					relatedGoodsCount  = goodsService.getGoodsRelatedWithTvCount(goodsRelatedSo);
				}
				tagVodList.get(i).setGoodsCount(relatedGoodsCount);
			}
		}
		
		map.put("optimalVodList", tagVodList);
		map.put("so", so);
		
		return "/pettv/hashtagListPaging";
	}
	
	/**
	 * <pre>
	 * - 메소드명	: petTvMainView
	 * - 작성일	: 2020. 06. 09.
	 * - 작성자	: CJA
	 * - 설명		: 해시태그 모아보기 화면
	 * </pre>
	 * 
	 * @param map
	 * @param session
	 * @param view
	 * @param so
	 * @return String
	 */
	@RequestMapping(value = "/tv/collectTags", method = RequestMethod.GET)
	public String collectTags(ModelMap map, Session session, ViewBase view, TagBaseSO so) {
		so.setSidx("SYS_REG_DTM");
		so.setSord("DESC");
		so.setRows(12);
		
		//태그 모아보기 영상 리스트
		List<VodVO> tagVodList = displayService.tagVodList(so);
		
		TagBaseVO tvo = tagService.getTagInfo(so);
		
		map.put("tvo", tvo);
		map.put("so", so);
		map.put("tagVodList", tagVodList);
		map.put("session", session);
		map.put("view", view);
		map.put("callParam", so.getCallParam());
		
		return "/pettv/collectTags";
	}
	
	/**
	 * <pre>
	 * - 메소드명	: petTvMainView
	 * - 작성일	: 2020. 06. 09.
	 * - 작성자	: CJA
	 * - 설명		: 해시태그 모아보기 목록 더보기
	 * </pre>
	 * 
	 * @param map
	 * @param session
	 * @param view
	 * @param so
	 * @param page
	 * @return String
	 */
	@RequestMapping(value = "/tv/collectTagsPaging", method = RequestMethod.POST)
	public String collectTagsPaging(ModelMap map, Session session, ViewBase view, TagBaseSO so, Integer page) {
		so.setSord("DESC");
		so.setRows(12);
		so.setPage(page);
		
		//태그 모아보기 영상 리스트
		List<VodVO> tagVodList = displayService.tagVodList(so);
		
		TagBaseVO tvo = tagService.getTagInfo(so);
		
		map.put("tvo", tvo);
		map.put("so", so);
		map.put("tagVodList", tagVodList);
		map.put("session", session);
		map.put("view", view);
		map.put("callParam", so.getCallParam());
		
		return "/pettv/collectTagsPaging";
	}
	
	/**
	 * <pre>
	 * - 메소드명	: petTvMainView
	 * - 작성일	: 2020. 06. 09.
	 * - 작성자	: CJA
	 * - 설명		: 해시태그 리스트 sort
	 * </pre>
	 * 
	 * @param session
	 * @param view
	 * @param so
	 * @param page
	 * @return ModelMap
	 */
	@ResponseBody
	@RequestMapping(value = "/tv/hashTagListSort", method = RequestMethod.POST)
	public ModelMap hashTagListSort(Session session, ViewBase view, TagBaseSO so, Integer page) {
		ModelMap modelMap = new ModelMap();
		
		so.setSord("DESC");
		so.setRows(12);
		so.setPage(page);
		
		List<VodVO> tagVodList = displayService.tagVodList(so);
		
		modelMap.put("so", so);
		modelMap.put("tagVodList", tagVodList);
		
		return modelMap;
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: gs-apet-31-front
	 * - 파일명		: PetTvController.java
	 * - 작성일		: 2021. 2. 4.
	 * - 작성자		: YKU
	 * - 설명			: PetTV 영상 리스트(맞춤, 신규, 인기)
	 * </pre>
	 * 
	 * @param map
	 * @param session
	 * @param view
	 * @param so
	 * @return String
	 * @throws IOException 
	 * @throws JsonMappingException 
	 * @throws JsonParseException
	 */
	@RequestMapping(value = "/tv/petTvList", method = RequestMethod.GET)
	public String petTvList(ModelMap map, Session session, ViewBase view, VodSO so) throws JsonParseException, JsonMappingException, IOException, Exception {
		Long dispClsfNo = Long.valueOf(webConfig.getProperty("site.main.tv.disp.clsf.no"));
		DisplayCornerSO cornSo = new DisplayCornerSO();
		cornSo.setMbrNo(session.getMbrNo());
		cornSo.setDispClsfNo(dispClsfNo);
		cornSo.setDispCornNo(so.getDispCornNo());
		
		if( StringUtil.isEmpty(cornSo.getPreviewDt()) ) {
			cornSo.setPreviewDt(DateUtil.getNowDate());
		}
		
		DisplayCornerTotalVO cornList = displayService.getCornList(cornSo);
		
		VodSO vso = new VodSO();
		vso.setMbrNo(session.getMbrNo());
		
		if(so.getDispCornNo().equals(Long.valueOf(webConfig.getProperty("disp.corn.no.tv.custom.vod")))) {
			// 사용자 맞춤 영상
			Map<String,String> requestParam = new HashMap<String,String>();
	        requestParam.put("INDEX","TV"); //추천대상서비스
	        requestParam.put("TARGET_INDEX","tv-optimal");
	        requestParam.put("MBR_NO", String.valueOf(session.getMbrNo())); 
	        requestParam.put("FROM", "1");
	        requestParam.put("SIZE", String.valueOf(FrontWebConstants.PAGE_ROWS_12));
	        List<VodVO> optimalVodList = new ArrayList<>();
	        
	        try {
	        	String res = searchApiUtil.getResponse(SearchApiSpec.SRCH_API_IF_RECOMMEND, requestParam);
		        if(res != null) {
		        	ObjectMapper objectMapper = new ObjectMapper();
		        	Map<String, Object> resMap = objectMapper.readValue(res, Map.class);
		        	Map<String, Object> statusMap = (Map)resMap.get("STATUS");
		        	
	        		if( ((Integer)statusMap.get("CODE")).equals(200) ) {
	        			Map<String, Object> dataMap = (Map)resMap.get("DATA");
	        			
	        			if( (int)dataMap.get("TOTAL") > 0 ) {
	        				so.setTotalCount((int)dataMap.get("TOTAL"));
	        				List<Map<String, Object>> items = (List)dataMap.get("ITEM");
	        				VodVO vo;
	        				for(Map<String, Object> item : items ) {
	        					vso.setVdId(String.valueOf(item.get("VD_ID")));
	        					vo = displayService.getVodDetail(vso); //영상 정보 조회
	        					if(vo != null) {
	        						vo.setTtl((String)item.get("TTL"));
		        					vo.setThumPath((String)item.get("THUM_PATH"));
		        					
	        						String str = (String)item.get("RATE");
		        					if (str.contains(".")) {
										int ids = str.indexOf(".");
										vo.setRate(str.substring(0, ids));
									} else {
									    vo.setIntRate(Integer.valueOf((String)item.get("RATE").toString()));
									}
		        					
	        						//ShortUrl 생성
		        					if(vo.getSrtUrl() == null) {
		        						//단축URL 생성 후 저장
		        						String domainStr = "";
		        						if(view.getEnvmtGbCd().equals("local")) {
		        							domainStr = "https://dev.aboutpet.co.kr";
		        						}else {
		        							domainStr = view.getStDomain();
		        						}
		        						
		        						String originUrl = domainStr+"/tv/series/indexTvShare?vdId="+vo.getVdId()+"&sortCd=&listGb=HOME";
		        				        String shortUrl = NhnShortUrlUtil.getUrl(originUrl);
		        				        TvDetailPO tvDetailPO = new TvDetailPO();
		        				        tvDetailPO.setVdId(vo.getVdId());
		        				        tvDetailPO.setSrtUrl(shortUrl);
		        				        tvDetailService.updateVdoShortUrl(tvDetailPO);
		        				        vo.setSrtUrl(shortUrl);
		        					}
		        			        
		        					//태그
		        					List<VodVO> tag = vodService.listGetTag(vso);
		        					vo.setTagList(tag);
		        					
		        					int relatedGoodsCount = 0;
		        					//V-커머스 일때만 조회(10=일반, 20=V-커머스)
		        					if("20".equals(vo.getVdTpCd())) {
		        						//연관상품 개수
			        					GoodsRelatedSO goodsRelatedSo = new GoodsRelatedSO();
			        					goodsRelatedSo.setVdId(vo.getVdId());
			        					goodsRelatedSo.setWebMobileGbCd(view.getDeviceGb());
			        					goodsRelatedSo.setStId(view.getStId());
			        					relatedGoodsCount  = goodsService.getGoodsRelatedWithTvCount(goodsRelatedSo);
		        					}
		        					vo.setGoodsCount(relatedGoodsCount);
	        					}
	        					
	        					optimalVodList.add(vo);
	        				}
	        				
	        				map.put("optimalVodList", optimalVodList);
	        			}
	        		}
				}
	        } catch (Exception e) {
	        	e.printStackTrace();
	        }
	        
	    //신규영상
		}else if(so.getDispCornNo().equals(Long.valueOf(webConfig.getProperty("disp.corn.no.tv.new.vod")))) {
			cornSo.setRows(FrontWebConstants.PAGE_ROWS_12);
			
			//BO에서 등록한 신규영상
			List<VodVO> newVodList = displayService.pageDisplayCornerItemNewVodFOList(cornSo);
			
			//연관상품 
			for(int i=0; i<newVodList.size(); i++) {
				int relatedGoodsCount = 0;
				//V-커머스 일때만 조회(10=일반, 20=V-커머스)
				if("20".equals(newVodList.get(i).getVdTpCd())) {
					//연관상품 개수
					GoodsRelatedSO goodsRelatedSo = new GoodsRelatedSO();
					goodsRelatedSo.setVdId(newVodList.get(i).getVdId());
					goodsRelatedSo.setWebMobileGbCd(view.getDeviceGb());
					goodsRelatedSo.setStId(view.getStId());
					relatedGoodsCount = goodsService.getGoodsRelatedWithTvCount(goodsRelatedSo);
				}
				newVodList.get(i).setGoodsCount(relatedGoodsCount);
				
				//ShortUrl 생성
				if(newVodList.get(i).getSrtUrl() == null) {
					//단축URL 생성 후 저장
					String domainStr = "";
					if(view.getEnvmtGbCd().equals("local")) {
						domainStr = "https://dev.aboutpet.co.kr";
					}else {
						domainStr = view.getStDomain();
					}
					String originUrl = domainStr+"/tv/series/indexTvShare?vdId="+newVodList.get(i).getVdId()+"&sortCd=&listGb=HOME";
			        String shortUrl = NhnShortUrlUtil.getUrl(originUrl);
			        TvDetailPO tvDetailPO = new TvDetailPO();
			        tvDetailPO.setVdId(newVodList.get(i).getVdId());
			        tvDetailPO.setSrtUrl(shortUrl);
			        tvDetailService.updateVdoShortUrl(tvDetailPO);
			        newVodList.get(i).setSrtUrl(shortUrl);
				}
			}
			
			map.put("optimalVodList", newVodList);
			
	        
		//인기영상
		}else if(so.getDispCornNo().equals(Long.valueOf(webConfig.getProperty("disp.corn.no.tv.popular.vod")))) {
			cornSo.setRows(FrontWebConstants.PAGE_ROWS_12);
			
			//BO에서 등록한 인기영상
			List<VodVO> vodList = displayService.pageDisplayCornerItemPopVodFOList(cornSo);
			
			if(vodList.size() < cornList.getShowCnt()) {
				int showCnt = cornList.getShowCnt().intValue();
				
				List<String> vdIds = new ArrayList<String>();
				for(int i = 0; i < vodList.size(); i++) {
					vdIds.add(vodList.get(i).getVdId());
				}
				
				vso.setVodList(vdIds);
				vso.setTpCd(CommonConstants.APET_TP_20);
				vso.setLimit(0);
				vso.setOffset(3);
				List<VodVO> vodNextList = displayService.pageDisplayCornerItemVodNexFO(vso);
				vodList.addAll(vodNextList);
				
				// 조회순 인기영상
				if (vodList.size() < cornList.getShowCnt().intValue()) {
					int listCnt = vodList.size();
					int minValCnt = showCnt - listCnt;

					VodSO popso = new VodSO();

					List<String> vdIdList = new ArrayList<String>();
					for (int i = 0; i < vodList.size(); i++) {
						vdIdList.add(vodList.get(i).getVdId());
					}

					popso.setVodList(vdIdList);
					popso.setLimit(0);
					popso.setOffset(minValCnt);
					List<VodVO> vodPopNextList = displayService.pageDisplayCornerItemVodNexFO(popso);
					vodList.addAll(vodPopNextList);
				}
			}
			
			for(int i=0; i<vodList.size(); i++) {
				int relatedGoodsCount = 0;
				//V-커머스 일때만 조회(10=일반, 20=V-커머스)
				if("20".equals(vodList.get(i).getVdTpCd())) {
					//연관상품 개수
					GoodsRelatedSO goodsRelatedSo = new GoodsRelatedSO();
					goodsRelatedSo.setVdId(vodList.get(i).getVdId());
					goodsRelatedSo.setWebMobileGbCd(view.getDeviceGb());
					goodsRelatedSo.setStId(view.getStId());
					relatedGoodsCount = goodsService.getGoodsRelatedWithTvCount(goodsRelatedSo);
				}
				vodList.get(i).setGoodsCount(relatedGoodsCount);
				
				//ShortUrl 생성
				if(vodList.get(i).getSrtUrl() == null) {
					//단축URL 생성 후 저장
					String domainStr = "";
					if(view.getEnvmtGbCd().equals("local")) {
						domainStr = "https://dev.aboutpet.co.kr";
					}else {
						domainStr = view.getStDomain();
					}
					String originUrl = domainStr+"/tv/series/indexTvShare?vdId="+vodList.get(i).getVdId()+"&sortCd=&listGb=HOME";
			        String shortUrl = NhnShortUrlUtil.getUrl(originUrl);
			        TvDetailPO tvDetailPO = new TvDetailPO();
			        tvDetailPO.setVdId(vodList.get(i).getVdId());
			        tvDetailPO.setSrtUrl(shortUrl);
			        tvDetailService.updateVdoShortUrl(tvDetailPO);
			        vodList.get(i).setSrtUrl(shortUrl);
				}
			}
			
			map.put("optimalVodList", vodList);
		}
		
		//랜덤으로 시리즈 가져오기
		VodVO random = vodService.srisRandom(so);
		map.put("so", so);
		map.put("cornSo", cornSo);
		map.put("view", view);
		map.put("random", random);
		map.put("session", session);
		
		return "/pettv/petTvList";
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: gs-apet-31-front
	 * - 파일명		: PetTvController.java
	 * - 작성일		: 2021. 5. 3.
	 * - 작성자		: YKU
	 * - 설명			: 신규영상 페이징
	 * </pre>
	 * 
	 * @param map
	 * @param session
	 * @param view
	 * @param cornSo
	 * @param so
	 * @return String
	 * @throws Exception 
	 */
	@RequestMapping("/tv/petTvPaging")
	public String petTvPaging(ModelMap map, Session session, ViewBase view, DisplayCornerSO cornSo, VodSO so) throws Exception{
		Long dispClsfNo = Long.valueOf(webConfig.getProperty("site.main.tv.disp.clsf.no"));
		cornSo.setMbrNo(session.getMbrNo());
		so.setMbrNo(session.getMbrNo());
		cornSo.setDispClsfNo(dispClsfNo);
		cornSo.setDispCornNo(cornSo.getDispCornNo());
		cornSo.setRows(FrontWebConstants.PAGE_ROWS_12); 
		if( StringUtil.isEmpty(cornSo.getPreviewDt()) ) {					
			cornSo.setPreviewDt(DateUtil.getNowDate());
		}
		
		if(so.getDispCornNo().equals(Long.valueOf(webConfig.getProperty("disp.corn.no.tv.custom.vod")))) {
			// 사용자 맞춤 영상
			Map<String,String> requestParam = new HashMap<String,String>();
	        requestParam.put("INDEX","TV"); //추천대상서비스
	        requestParam.put("TARGET_INDEX","tv-optimal");
	        requestParam.put("MBR_NO", String.valueOf(session.getMbrNo())); 
	        requestParam.put("FROM", String.valueOf(so.getPage()));
	        requestParam.put("SIZE", String.valueOf(FrontWebConstants.PAGE_ROWS_12));
	        cornSo.setRows(FrontWebConstants.PAGE_ROWS_12);
	        
	        List<VodVO> optimalVodList = new ArrayList<>();
	        
	        try {
	        	String res = searchApiUtil.getResponse(SearchApiSpec.SRCH_API_IF_RECOMMEND, requestParam);
		        if(res != null) {
		        	ObjectMapper objectMapper = new ObjectMapper();
		        	Map<String, Object> resMap = objectMapper.readValue(res, Map.class);
		        	Map<String, Object> statusMap = (Map)resMap.get("STATUS");
		        	
	        		if( ((Integer)statusMap.get("CODE")).equals(200) ) {
	        			Map<String, Object> dataMap = (Map)resMap.get("DATA");
	        			
	        			if( (int)dataMap.get("TOTAL") > 0 ) {
	        				cornSo.setTotalCount((int)dataMap.get("TOTAL"));
	        				List<Map<String, Object>> items = (List)dataMap.get("ITEM");
	        				VodVO vo;
	        				for(Map<String, Object> item : items ) {
	        					so.setVdId(String.valueOf(item.get("VD_ID")));
	        					vo = displayService.getVodDetail(so); //영상 정보 조회
	        					if(vo != null) {
	        						vo.setTtl((String)item.get("TTL"));
		        					vo.setThumPath((String)item.get("THUM_PATH"));
		        					
	        						String str = (String)item.get("RATE");
		        					if (str.contains(".")) {
										int ids = str.indexOf(".");
										vo.setRate(str.substring(0, ids));
									} else {
									    vo.setIntRate(Integer.valueOf((String)item.get("RATE").toString()));
									}
		        					
		        					//ShortUrl 생성
		        					if(vo.getSrtUrl() == null) {
		        						//단축URL 생성 후 저장
		        						String domainStr = "";
		        						if(view.getEnvmtGbCd().equals("local")) {
		        							domainStr = "https://dev.aboutpet.co.kr";
		        						}else {
		        							domainStr = view.getStDomain();
		        						}
		        						
		        						String originUrl = domainStr+"/tv/series/indexTvShare?vdId="+vo.getVdId()+"&sortCd=&listGb=HOME";
		        				        String shortUrl = NhnShortUrlUtil.getUrl(originUrl);
		        				        TvDetailPO tvDetailPO = new TvDetailPO();
		        				        tvDetailPO.setVdId(vo.getVdId());
		        				        tvDetailPO.setSrtUrl(shortUrl);
		        				        tvDetailService.updateVdoShortUrl(tvDetailPO);
		        				        vo.setSrtUrl(shortUrl);
		        					}
		        					
		        					//태그
		        					List<VodVO> tag = vodService.listGetTag(so);
		        					vo.setTagList(tag);
		        					
		        					int relatedGoodsCount = 0;
		        					//V-커머스 일때만 조회(10=일반, 20=V-커머스)
		        					if("20".equals(vo.getVdTpCd())) {
		        						//연관상품 개수
			        					GoodsRelatedSO goodsRelatedSo = new GoodsRelatedSO();
			        					goodsRelatedSo.setVdId(vo.getVdId());
			        					goodsRelatedSo.setWebMobileGbCd(view.getDeviceGb());
			        					goodsRelatedSo.setStId(view.getStId());
			        					relatedGoodsCount  = goodsService.getGoodsRelatedWithTvCount(goodsRelatedSo);
		        					}
		        					vo.setGoodsCount(relatedGoodsCount);
		        					
	        					}
	        					optimalVodList.add(vo);
	        				}
	        				
	        				map.put("optimalVodList", optimalVodList);
	        			}
	        		}
				}
	        } catch (Exception e) {
	        	e.printStackTrace();
	        }
	        
	    //신규영상
		}else if(so.getDispCornNo().equals(Long.valueOf(webConfig.getProperty("disp.corn.no.tv.new.vod")))) {
			List<VodVO> newVodList = displayService.pageDisplayCornerItemNewVodFOList(cornSo);
			
			//연관상품 
			for(int i=0; i<newVodList.size(); i++) {
				int relatedGoodsCount = 0;
				//V-커머스 일때만 조회(10=일반, 20=V-커머스)
				if("20".equals(newVodList.get(i).getVdTpCd())) {
					//연관상품 개수
					GoodsRelatedSO goodsRelatedSo = new GoodsRelatedSO();
					goodsRelatedSo.setVdId(newVodList.get(i).getVdId());
					goodsRelatedSo.setWebMobileGbCd(view.getDeviceGb());
					goodsRelatedSo.setStId(view.getStId());
					relatedGoodsCount = goodsService.getGoodsRelatedWithTvCount(goodsRelatedSo);
				}
				newVodList.get(i).setGoodsCount(relatedGoodsCount);
				
				//ShortUrl 생성
				if(newVodList.get(i).getSrtUrl() == null) {
					//단축URL 생성 후 저장
					String domainStr = "";
					if(view.getEnvmtGbCd().equals("local")) {
						domainStr = "https://dev.aboutpet.co.kr";
					}else {
						domainStr = view.getStDomain();
					}
					String originUrl = domainStr+"/tv/series/indexTvShare?vdId="+newVodList.get(i).getVdId()+"&sortCd=&listGb=HOME";
			        String shortUrl = NhnShortUrlUtil.getUrl(originUrl);
			        TvDetailPO tvDetailPO = new TvDetailPO();
			        tvDetailPO.setVdId(newVodList.get(i).getVdId());
			        tvDetailPO.setSrtUrl(shortUrl);
			        tvDetailService.updateVdoShortUrl(tvDetailPO);
			        newVodList.get(i).setSrtUrl(shortUrl);
				}
			}
			map.put("optimalVodList", newVodList);
		}
		
		map.put("view", view);
		map.put("session", session);
		map.put("cornSo", cornSo);
		map.put("so", so);
		
		return "/pettv/petTvListPaging";
	}
	
	/**
	 * <pre>
	 * - 메소드명	: petTvMainView
	 * - 작성일	: 2020. 06. 09.
	 * - 작성자	: CJA
	 * - 설명		: 펫샵 이벤트 페이지
	 * </pre>
	 * 
	 * @param map
	 * @param session
	 * @param view
	 * @param so
	 * @return String
	 * @throws IOException 
	 * @throws JsonMappingException 
	 * @throws JsonParseException
	 */
	@RequestMapping(value = "/event/shop/petshopEventList", method = RequestMethod.GET)
	public String petshopEventList(ModelMap map, Session session, ViewBase view, DisplayCornerSO so) throws JsonParseException, JsonMappingException, IOException {
		GoodsDispSO gso = new GoodsDispSO();
		
		if(!StringUtil.isEmpty(so.getLnbDispClsfNo())) {
			// 로그인 시
			// LNB 반려동물(강아지/고양이) 변경처리
			if(!session.getMbrNo().equals(CommonConstants.NO_MEMBER_NO)) {
				displayService.updatePetGbCdLnbHistory(so.getLnbDispClsfNo(), session.getMbrNo());
			}
			so.setDispClsfNo(so.getLnbDispClsfNo());
		}
		
		if( StringUtil.isEmpty(so.getPreviewDt()) ) {					
			gso.setPreviewDt(DateUtil.getNowDate());
		}else {
			gso.setPreviewDt(so.getPreviewDt());
		}
		
		// 1. 전시번호에 해당하는 코너목록 가져오기
		so.setPreviewDt(gso.getPreviewDt());
		List<DisplayCornerTotalVO> cornList = displayService.listDisplayClsfCornerDate(so);
		
		if(cornList.size() > 0) {
			DisplayCornerTotalVO tvo = new DisplayCornerTotalVO();
			tvo.setSeoInfoNo(cornList.get(0).getSeoInfoNo());
		}
		
		if(cornList.get(0).getDispCornNo().equals(Long.valueOf(webConfig.getProperty("disp.corn.no.dog.top.banner")))) {
			so.setDispCornNo(cornList.get(0).getDispCornNo());
			so.setRows(cornList.get(0).getShowCnt().intValue());
		} else if(cornList.get(0).getDispCornNo().equals(Long.valueOf(webConfig.getProperty("disp.corn.no.cat.top.banner")))){
			so.setDispCornNo(cornList.get(0).getDispCornNo());
			so.setRows(cornList.get(0).getShowCnt().intValue());
		} else if(cornList.get(0).getDispCornNo().equals(Long.valueOf(webConfig.getProperty("disp.corn.no.fish.top.banner")))) {
			so.setDispCornNo(cornList.get(0).getDispCornNo());
			so.setRows(cornList.get(0).getShowCnt().intValue());
		} else if(cornList.get(0).getDispCornNo().equals(Long.valueOf(webConfig.getProperty("disp.corn.no.animal.top.banner")))){
			so.setDispCornNo(cornList.get(0).getDispCornNo());
			so.setRows(cornList.get(0).getShowCnt().intValue());
		}
		so.setLimit(9999999);
		
		List<BannerVO> bannerList = displayDao.pageDisplayCornerItemBannerFO(so);
		
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
		
		DisplayCornerItemSO dciSo = new DisplayCornerItemSO();
		dciSo.setDispClsfNo(so.getDispClsfNo());
		dciSo.setDispCornTpCd(CommonConstants.DISP_CORN_TP_30);
		
		view.setDisplayShortCutList(this.displayService.getBnrImgListFO(dciSo));
		view.setDispClsfNo(so.getDispClsfNo());
		view.setSeoSvcGbCd(FrontWebConstants.SEO_SVC_GB_CD_10);
		
		map.put("bannerList", bannerList);
		map.put("session", session);
		map.put("view", view);
		map.put("so", so);
		
		return TilesView.none(new String[] { "petshop","include", "petshopEventList" });
	}
	
	/**
	 * <pre>
	 * - 메소드명	: PetTvController.java
	 * - 작성일	: 2020. 06. 21.
	 * - 작성자	: 이동식
	 * - 설명		: 시리즈 TAG & 시리즈(미고정) 리스트 화면
	 * </pre>
	 * 
	 * @param map
	 * @param view
	 * @param session
	 * @param cornSo
	 * @return String
	 * @throws Exception
	 */
	@RequestMapping(value = "/tv/seriesTagList", method = RequestMethod.GET)
	public String seriesTagList(ModelMap map, ViewBase view, Session session, DisplayCornerSO cornSo) throws Exception {
		Long dispClsfNo = Long.valueOf(webConfig.getProperty("site.main.tv.disp.clsf.no"));
		
		cornSo.setMbrNo(session.getMbrNo());
		cornSo.setDispClsfNo(dispClsfNo);
		cornSo.setPreviewDt(DateUtil.getNowDate());
		DisplayCornerTotalVO cornInfo = displayService.getCornList(cornSo); //코너 정보
		map.put("cornInfo", cornInfo);
		
		if(cornInfo.getDispCornTpCd().equals(CommonConstants.DISP_CORN_TP_130)) {
			List<TagBaseVO> tagList = displayService.pageDisplayCornerTagListFO(cornSo); // BO에서 등록한 태그 리스트
			
			if(!StringUtil.isEmpty(tagList)) {
				List<String> tagNoList = new ArrayList<>();
				for(TagBaseVO vo : tagList) {
					tagNoList.add(vo.getTagNo());
				}
				cornSo.setCornTagNoList(tagNoList);
				cornSo.setLimit(0);
				cornSo.setOffset(FrontWebConstants.PAGE_ROWS_12);
				
				List<SeriesVO> seriesTagList = displayService.selectSeriesTagList(cornSo);
				if(!StringUtil.isEmpty(seriesTagList)) {
					Collections.shuffle(seriesTagList);
					map.put("seriesTagList", seriesTagList);
				}
			}
		}else if(cornInfo.getDispCornTpCd().equals(CommonConstants.DISP_CORN_TP_132)) {
			cornSo.setRows(FrontWebConstants.PAGE_ROWS_12);
			cornSo.setDispCornTpCd(CommonConstants.DISP_CORN_TP_132);
			
			List<SeriesVO> seriesList = displayDao.pageDisplayCornerItemSeriesFO(cornSo); // BO에서 등록한 시리즈 리스트
			map.put("seriesTagList", seriesList);
			
			cornSo.setDispCornTpCd(null);
		}
			
		map.put("session", session);
		map.put("view", view);
		map.put("cornSo", cornSo);
		
		//랜덤으로 시리즈 가져오기
		VodSO vso = new VodSO();
		VodVO random = vodService.srisRandom(vso);
		map.put("random", random);
		
		return "/pettv/srisVdoTagList";
	}
	
	/**
	 * <pre>
	 * - 메소드명	: petTvMainView
	 * - 작성일	: 2020. 06. 21.
	 * - 작성자	: 이동식
	 * - 설명		: 시리즈(미고정) 리스트 목록 더보기
	 * </pre>
	 * 
	 * @param map
	 * @param session
	 * @param view
	 * @param cornSo
	 * @return String
	 */
	@RequestMapping(value = "/tv/seriesTagListMore", method = RequestMethod.POST)
	public String seriesTagListMore(ModelMap map, Session session, ViewBase view, DisplayCornerSO cornSo) throws Exception{
		Long dispClsfNo = Long.valueOf(webConfig.getProperty("site.main.tv.disp.clsf.no"));
		
		cornSo.setMbrNo(session.getMbrNo());
		cornSo.setDispClsfNo(dispClsfNo);
		cornSo.setRows(FrontWebConstants.PAGE_ROWS_12); 
		cornSo.setPreviewDt(DateUtil.getNowDate());
		cornSo.setDispCornTpCd(CommonConstants.DISP_CORN_TP_132);
		
		List<SeriesVO> seriesList = displayDao.pageDisplayCornerItemSeriesFO(cornSo); // BO에서 등록한 시리즈 리스트
		map.put("seriesTagList", seriesList);
		
		map.put("view", view);
		map.put("session", session);
		map.put("cornSo", cornSo);
		
		return "/pettv/seriesTagListPaging";
	}
	
	/**
	 * <pre>
	 * - 메소드명	: PetTvController.java
	 * - 작성일	: 2020. 06. 21.
	 * - 작성자	: 이동식
	 * - 설명		: 동영상 TAG & 동영상(미고정) 리스트 화면
	 * </pre>
	 * 
	 * @param map
	 * @param view
	 * @param session
	 * @param cornSo
	 * @return String
	 * @throws Exception
	 */
	@RequestMapping(value = "/tv/tagVodList", method = RequestMethod.GET)
	public String tagVodList(ModelMap map, ViewBase view, Session session, DisplayCornerSO cornSo) throws Exception {
		Long dispClsfNo = Long.valueOf(webConfig.getProperty("site.main.tv.disp.clsf.no"));
		
		cornSo.setMbrNo(session.getMbrNo());
		cornSo.setDispClsfNo(dispClsfNo);
		cornSo.setPreviewDt(DateUtil.getNowDate());
		DisplayCornerTotalVO cornInfo = displayService.getCornList(cornSo); //코너 정보
		map.put("cornInfo", cornInfo);
		
		if(cornInfo.getDispCornTpCd().equals(CommonConstants.DISP_CORN_TP_131)) {
			List<TagBaseVO> tagList = displayService.pageDisplayCornerTagListFO(cornSo); // BO에서 등록한 태그 리스트
			
			if(!StringUtil.isEmpty(tagList)) {
				List<String> tagNmList = new ArrayList<>();
				for(TagBaseVO vo : tagList) {
					tagNmList.add(vo.getTagNm());
				}
				
				String tagNms = StringUtils.join(tagNmList, ",");
				
				Map<String,String> requestParam = new HashMap<String,String>();
				requestParam.put("INDEX","TV"); //추천대상서비스
		        requestParam.put("TARGET_INDEX", "tag-related-tv"); //태그 관련 영상
		        requestParam.put("SIZE", String.valueOf(FrontWebConstants.PAGE_ROWS_12));
		        requestParam.put("TAG_NM", tagNms);
		        
		        String res = searchApiUtil.getResponse(SearchApiSpec.SRCH_API_IF_RECOMMEND, requestParam);
		        if(res != null) {
		        	List<VodVO> vodList = new ArrayList<>();
		        	
		        	ObjectMapper objectMapper = new ObjectMapper();
		        	Map<String, Object> resMap = objectMapper.readValue(res, Map.class);
		        	Map<String, Object> statusMap = (Map)resMap.get("STATUS");
		        	if( ((Integer)statusMap.get("CODE")).equals(200) ) {
		        		Map<String, Object> dataMap = (Map)resMap.get("DATA");
		    		
		        		if( (int)dataMap.get("TOTAL") > 0 ) {
		        			cornSo.setTotalCount((int)dataMap.get("TOTAL"));
		        			List<Map<String, Object>> items = (List)dataMap.get("ITEM");
		        			VodVO vo;
							VodSO vso = new VodSO();
							vso.setMbrNo(session.getMbrNo());
							
							for (Map<String, Object> item : items) {
								vso.setVdId(String.valueOf(item.get("VD_ID")));
								vo = displayService.getVodDetail(vso); //영상 정보 조회
								if(vo != null) {
									vo.setThumPath(String.valueOf(item.get("THUM_PATH")));
									
	        						//ShortUrl 생성
		        					if(vo.getSrtUrl() == null) {
		        						//단축URL 생성 후 저장
		        						String domainStr = "";
		        						if(view.getEnvmtGbCd().equals("local")) {
		        							domainStr = "https://dev.aboutpet.co.kr";
		        						}else {
		        							domainStr = view.getStDomain();
		        						}
		        						
		        						String originUrl = domainStr+"/tv/series/indexTvShare?vdId="+vo.getVdId()+"&sortCd=&listGb=HOME";
		        				        String shortUrl = NhnShortUrlUtil.getUrl(originUrl);
		        				        TvDetailPO tvDetailPO = new TvDetailPO();
		        				        tvDetailPO.setVdId(vo.getVdId());
		        				        tvDetailPO.setSrtUrl(shortUrl);
		        				        tvDetailService.updateVdoShortUrl(tvDetailPO);
		        				        vo.setSrtUrl(shortUrl);
		        					}
		        			        
		        					int relatedGoodsCount = 0;
		        					//V-커머스 일때만 조회(10=일반, 20=V-커머스)
		        					if("20".equals(vo.getVdTpCd())) {
		        						//연관상품 개수
			        					GoodsRelatedSO goodsRelatedSo = new GoodsRelatedSO();
			        					goodsRelatedSo.setVdId(vo.getVdId());
			        					goodsRelatedSo.setWebMobileGbCd(view.getDeviceGb());
			        					goodsRelatedSo.setStId(view.getStId());
			        					relatedGoodsCount  = goodsService.getGoodsRelatedWithTvCount(goodsRelatedSo);
		        					}
		        					vo.setGoodsCount(relatedGoodsCount);
		        					
		        					vodList.add(vo);
								}
							}
							
							map.put("tagVodList", vodList);
		        		}
		        	}
				}
			}
		}else if(cornInfo.getDispCornTpCd().equals(CommonConstants.DISP_CORN_TP_133)) {
			cornSo.setRows(FrontWebConstants.PAGE_ROWS_12);
			List<VodVO> vodList = displayService.pageDisplayCornerItemPopVodFOList(cornSo); // BO에서 등록한 동영상 리스트
			if(!StringUtil.isEmpty(vodList)) {
				for (VodVO vo : vodList) {
					//ShortUrl 생성
					if(vo.getSrtUrl() == null) {
						//단축URL 생성 후 저장
						String domainStr = "";
						if(view.getEnvmtGbCd().equals("local")) {
							domainStr = "https://dev.aboutpet.co.kr";
						}else {
							domainStr = view.getStDomain();
						}
						
						String originUrl = domainStr+"/tv/series/indexTvShare?vdId="+vo.getVdId()+"&sortCd=&listGb=HOME";
				        String shortUrl = NhnShortUrlUtil.getUrl(originUrl);
				        TvDetailPO tvDetailPO = new TvDetailPO();
				        tvDetailPO.setVdId(vo.getVdId());
				        tvDetailPO.setSrtUrl(shortUrl);
				        tvDetailService.updateVdoShortUrl(tvDetailPO);
				        vo.setSrtUrl(shortUrl);
					}
			        
					int relatedGoodsCount = 0;
					//V-커머스 일때만 조회(10=일반, 20=V-커머스)
					if("20".equals(vo.getVdTpCd())) {
						//연관상품 개수
						GoodsRelatedSO goodsRelatedSo = new GoodsRelatedSO();
						goodsRelatedSo.setVdId(vo.getVdId());
						goodsRelatedSo.setWebMobileGbCd(view.getDeviceGb());
						goodsRelatedSo.setStId(view.getStId());
						relatedGoodsCount  = goodsService.getGoodsRelatedWithTvCount(goodsRelatedSo);
					}
					vo.setGoodsCount(relatedGoodsCount);
				}
				
				map.put("tagVodList", vodList);
			}
			
		}
		
		map.put("session", session);
		map.put("view", view);
		map.put("cornSo", cornSo);
		
		//랜덤으로 시리즈 가져오기
		VodSO vso = new VodSO();
		VodVO random = vodService.srisRandom(vso);
		map.put("random", random);
		
		return "/pettv/srisVdoTagList";
	}
	
	/**
	 * <pre>
	 * - 메소드명	: petTvMainView
	 * - 작성일	: 2020. 06. 21.
	 * - 작성자	: 이동식
	 * - 설명		: 동영상(미고정) 리스트 목록 더보기
	 * </pre>
	 * 
	 * @param map
	 * @param session
	 * @param view
	 * @param cornSo
	 * @return String
	 */
	@RequestMapping(value = "/tv/tagVodListMore", method = RequestMethod.POST)
	public String tagVodListMore(ModelMap map, Session session, ViewBase view, DisplayCornerSO cornSo) throws Exception{
		Long dispClsfNo = Long.valueOf(webConfig.getProperty("site.main.tv.disp.clsf.no"));
		
		cornSo.setMbrNo(session.getMbrNo());
		cornSo.setDispClsfNo(dispClsfNo);
		cornSo.setRows(FrontWebConstants.PAGE_ROWS_12); 
		cornSo.setPreviewDt(DateUtil.getNowDate());
		
		// BO에서 등록한 동영상 리스트
		List<VodVO> vodList = displayService.pageDisplayCornerItemPopVodFOList(cornSo);
		if(!StringUtil.isEmpty(vodList)) {
			for (VodVO vo : vodList) {
				//ShortUrl 생성
				if(vo.getSrtUrl() == null) {
					//단축URL 생성 후 저장
					String domainStr = "";
					if(view.getEnvmtGbCd().equals("local")) {
						domainStr = "https://dev.aboutpet.co.kr";
					}else {
						domainStr = view.getStDomain();
					}
					
					String originUrl = domainStr+"/tv/series/indexTvShare?vdId="+vo.getVdId()+"&sortCd=&listGb=HOME";
			        String shortUrl = NhnShortUrlUtil.getUrl(originUrl);
			        TvDetailPO tvDetailPO = new TvDetailPO();
			        tvDetailPO.setVdId(vo.getVdId());
			        tvDetailPO.setSrtUrl(shortUrl);
			        tvDetailService.updateVdoShortUrl(tvDetailPO);
			        vo.setSrtUrl(shortUrl);
				}
		        
				int relatedGoodsCount = 0;
				//V-커머스 일때만 조회(10=일반, 20=V-커머스)
				if("20".equals(vo.getVdTpCd())) {
					//연관상품 개수
					GoodsRelatedSO goodsRelatedSo = new GoodsRelatedSO();
					goodsRelatedSo.setVdId(vo.getVdId());
					goodsRelatedSo.setWebMobileGbCd(view.getDeviceGb());
					goodsRelatedSo.setStId(view.getStId());
					relatedGoodsCount  = goodsService.getGoodsRelatedWithTvCount(goodsRelatedSo);
				}
				vo.setGoodsCount(relatedGoodsCount);
			}
			
			map.put("tagVodList", vodList);
		}
		
		map.put("view", view);
		map.put("session", session);
		map.put("cornSo", cornSo);
		
		return "/pettv/tagVodListPaging";
	}

}
