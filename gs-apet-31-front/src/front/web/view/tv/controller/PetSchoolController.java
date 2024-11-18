package front.web.view.tv.controller;


import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import biz.app.contents.model.ApetAttachFileVO;
import biz.app.contents.model.ApetContentsDetailPO;
import biz.app.contents.model.ApetContentsDetailSO;
import biz.app.contents.model.ApetContentsDetailVO;
import biz.app.contents.model.EduContsPO;
import biz.app.contents.model.EduContsSO;
import biz.app.contents.model.EduContsVO;
import biz.app.contents.model.PetLogMgmtSO;
import biz.app.contents.model.VodVO;
import biz.app.contents.service.EduContsService;
import biz.app.contents.service.VodService;
import biz.app.display.model.SeoInfoSO;
import biz.app.display.model.SeoInfoVO;
import biz.app.display.service.SeoService;
import biz.app.goods.model.GoodsImgVO;
import biz.app.goods.model.GoodsRelatedSO;
import biz.app.goods.service.GoodsService;
import biz.app.petlog.model.PetLogBaseVO;
import biz.app.system.model.CodeDetailVO;
import biz.app.tv.model.TvDetailSO;
import biz.app.tv.model.TvDetailVO;
import biz.common.service.CacheService;
import framework.admin.constants.AdminConstants;
import framework.common.constants.CommonConstants;
import framework.common.util.NhnShortUrlUtil;
import framework.common.util.StringUtil;
import framework.front.constants.FrontConstants;
import framework.front.model.Session;
import front.web.config.constants.FrontWebConstants;
import front.web.config.tiles.TilesView;
import front.web.config.util.ImagePathUtil;
import front.web.config.view.ViewBase;

import lombok.extern.slf4j.Slf4j;


/**
* <pre>
* - 프로젝트명		: 31.front.web
* - 패키지명		: front.web.view.pettv
* - 파일명		: PetSchoolController.java
* - 작성일		: 2021. 1. 21.
* - 작성자		: kwj
* - 설명			: 펫스쿨 Controller
* </pre>
*/
@Slf4j
@Controller
@RequestMapping("tv/school")
public class PetSchoolController {
	
	@Autowired private EduContsService eduContsService;
	@Autowired private CacheService cacheService;	
	@Autowired private SeoService seoService;
	@Autowired private GoodsService goodsService;
	@Autowired private NhnShortUrlUtil NhnShortUrlUtil;
	@Autowired private Properties bizConfig;
		
	/**
	* <pre>
	* - 프로젝트명		: 31.front.web
	* - 파일명		: PetSchoolController.java
	* - 작성일		: 2021. 1. 21.
	* - 작성자		: kwj
	* - 설명			: 펫스쿨 상세 화면
	* </pre>
	* @param map
	* @param session
	* @param ModelMap, Session, ViewBase, ApetContentsDetailSO 	
	* @return
	* @throws Exception
	*/
	@RequestMapping(value="indexTvDetail")
	public String petSchoolDetail(ModelMap map, Session session, ViewBase view, ApetContentsDetailSO so) throws Exception {
			
		//로그인 여부		
		so.setMbrNo(session.getMbrNo());
		
		if(StringUtil.isEmpty(so.getVdId())) {		
			map.put("eduConts", null);
			return TilesView.none(new String[]{"pettv", "petSchoolDetail"});  
		}		
		
		//기본정보 조회
		EduContsSO eso = new EduContsSO();
		eso.setVdId(so.getVdId());
		eso.setMbrNo(session.getMbrNo());
		EduContsVO eduContsDetail = eduContsService.getEduConts(eso);
		if(StringUtil.isNotEmpty(eduContsDetail)) {
			if(StringUtil.isNotEmpty(eduContsDetail.getDispYn()) && "N".equals(eduContsDetail.getDispYn())) {		
				map.put("eduConts", null);
				return TilesView.none(new String[]{"pettv", "petSchoolDetail"});  
			}
		}
		
		
		/*
		1. 펫스쿨 홈에서 진입(stepNo = null)
		1.1 시청이력이 있는 회원(로그인한)은 보던 부분부터 재생
		1.2 시청이력이 없거나 비회원인 경우 시작화면부터 재생
		
		2. 교육 완료에서 진입(stepNo != null)
		2.1 다시교육하기 클릭시 시작화면부터 재생
		2.2 모바일 상단 < 클릭시 교육 마지막 스텝 재생
		*/
		ApetContentsDetailVO histVo = new ApetContentsDetailVO();
		if(StringUtil.isEmpty(so.getStepNo())) {//펫스쿨 홈에서 진입
			if (!CommonConstants.NO_MEMBER_NO.equals(so.getMbrNo())) {
				histVo = eduContsService.getPetTvContsHistory(so);
				if(StringUtil.isNotEmpty(histVo) && "Y".equals(histVo.getCpltYn())) {//펫스쿨 시청 완료의 경우 시작화면으로 2021.04.13
					histVo.setStepNo(0L);
					histVo.setVdLnth(0L);
				}
			}
		}else {//교육 완료에서 진입
			histVo.setStepNo(so.getStepNo());
			histVo.setVdLnth(0L);
		}
		if(StringUtil.isEmpty(histVo) || StringUtil.isEmpty(histVo.getStepNo())) {//펫스쿨 홈에서 진입한 비회원			
			histVo = new ApetContentsDetailVO();
			histVo.setStepNo(0L);
			histVo.setVdLnth(0L);
		}
		
		//연관상품 조회
		GoodsRelatedSO gso = new GoodsRelatedSO();
		gso.setVdId(so.getVdId());
		gso.setStId(view.getStId());
		gso.setWebMobileGbCd(view.getDeviceGb());
		int relatedGoodsCount = goodsService.getGoodsRelatedWithTvCount(gso);
		//연관상품 대표이미지
		GoodsImgVO gvo = goodsService.getGoodsRelatedWithTvThumb(gso); 

		//찜, 좋아요 여부 확인
		VodVO interestVo = new VodVO();
		if (!CommonConstants.NO_MEMBER_NO.equals(eso.getMbrNo())) {
			interestVo=eduContsService.getInterestYn(eso);
		}
		
		// seo 정보
		SeoInfoSO seoSo = new SeoInfoSO();
		seoSo.setSeoSvcGbCd(FrontWebConstants.SEO_SVC_GB_CD_20);        // SEO 서비스 구분 코드
		view.setSeoSvcGbCd(FrontWebConstants.SEO_SVC_GB_CD_20);
		seoSo.setSeoTpCd(FrontWebConstants.SEO_TP_30);                        // SEO 유형 코드
		//seoSo.setSeoInfoNo(view.getSeoInfoNo());                                     // SEO 정보 번호
		SeoInfoVO seoInfo = seoService.getSeoInfoFO(seoSo, false);
		map.put("seoInfo", seoInfo);
		
		//공유하기 URL
		String oriUrl = "";
		if(StringUtil.isBlank(eduContsDetail.getSrtUrl())) {//short url 없을 시 생성한 후 업데이트
			String stDo = view.getStDomain();
			if (StringUtil.equals(bizConfig.getProperty("envmt.gb"), CommonConstants.ENVIRONMENT_GB_LOCAL)) {
				stDo = "https://dev.aboutpet.co.kr";
			}
			oriUrl = stDo+"/tv/school/indexTvShare?vdId="+so.getVdId();
			oriUrl = NhnShortUrlUtil.getUrl(oriUrl);
			if(StringUtil.isNotEmpty(oriUrl)) {
				//short url 저장
				EduContsPO epo = new EduContsPO();
				epo.setVdId(so.getVdId());
				epo.setSrtUrl(oriUrl);
				eduContsService.saveSrtUrl(epo);
			}
		}else {
			oriUrl = eduContsDetail.getSrtUrl();
		}
		
		map.put("eduConts", eduContsDetail);
		map.put("prpmCdList", this.cacheService.listCodeCache(AdminConstants.PRPM, null, null, null, null, null));
		map.put("relatedGoodsCount", relatedGoodsCount);
		map.put("session", session);
		map.put("histVo", histVo);
		map.put("interestVo", interestVo);
		map.put("shareUrl", oriUrl);
		map.put("goodsImg", gvo);
		map.put("histCnt", so.getHistCnt());
		map.put("linkYn", so.getLinkYn());
		map.put("histLoginCnt", so.getHistLoginCnt());
		map.put("goodsVal", so.getGoodsVal());
		
		return TilesView.none(new String[]{"pettv", "petSchoolDetail"});  
	}
	
	@RequestMapping(value="indexTvShare")
	public String petSchoolDetailShare(ModelMap map, Session session, ViewBase view, TvDetailSO so){
		
		//기본정보 조회
		EduContsSO eso = new EduContsSO();
		eso.setVdId(so.getVdId());
		eso.setMbrNo(session.getMbrNo());
		EduContsVO eduContsDetail = eduContsService.getEduConts(eso);
		
		//공유하기용
		TvDetailVO vvo = new TvDetailVO();		
		String ThumPt = "";
		List<ApetAttachFileVO> fileList = eduContsDetail.getFileList();
		for(ApetAttachFileVO fvo: fileList) {
			if(CommonConstants.CONTS_TP_10.equals(fvo.getContsTpCd())) {
				ThumPt = fvo.getPhyPath();
			}
		}			
		if(ThumPt.lastIndexOf("cdn.ntruss.com") < 0) {
			ThumPt = ImagePathUtil.imagePath(ThumPt, FrontConstants.IMG_OPT_QRY_560);
		}
		
		map.put("vdId", so.getVdId());
		map.put("img", ThumPt);
		map.put("desc", eduContsDetail.getContent());
		map.put("title", eduContsDetail.getTtl());
		map.put("sortCd", so.getSortCd());
		map.put("listGb", so.getListGb());
		map.put("gubun", "petschool");
		
		// seo 정보
		SeoInfoSO seoSo = new SeoInfoSO();
		seoSo.setSeoSvcGbCd(FrontWebConstants.SEO_SVC_GB_CD_20);        // SEO 서비스 구분 코드
		view.setSeoSvcGbCd(FrontWebConstants.SEO_SVC_GB_CD_20);
		seoSo.setSeoTpCd(FrontWebConstants.SEO_TP_30);                        // SEO 유형 코드
		SeoInfoVO seoInfo = seoService.getSeoInfoFO(seoSo, false);
		if(seoInfo != null) {
			map.put("site_name", seoInfo.getPageTtl());
		}else {
			map.put("site_name", "");
		}
		
		return TilesView.none(new String[]{"tv", "indexTvShare"});
	}
	
	/**
	* <pre>
	* - 프로젝트명		: 31.front.web
	* - 파일명		: PetSchoolController.java
	* - 작성일		: 2021. 1. 29.
	* - 작성자		: kwj
	* - 설명			: 펫스쿨 완료 화면
	* </pre>
	* @param map
	* @param session
	* @param ModelMap, Session, ViewBase, ApetContentsDetailSO 	
	* @return
	* @throws Exception
	*/
	@RequestMapping(value="indexTvComplete")
	public String indexTvComplete(ModelMap map, Session session, ViewBase view, EduContsSO so){
				
		if(StringUtil.isEmpty(so.getVdId())) {		
			map.put("EduContsVO", null);
			return TilesView.none(new String[]{"pettv", "petSchoolComplete"});  
		}
		so.setMbrNo(session.getMbrNo());	
		
		//기본정보 조회
		EduContsVO eduContsDetail = eduContsService.getEduConts(so);
		if(StringUtil.isNotEmpty(eduContsDetail)) {
			if(StringUtil.isNotEmpty(eduContsDetail.getDispYn()) && "N".equals(eduContsDetail.getDispYn())) {		
				map.put("EduContsVO", null);
				return TilesView.none(new String[]{"pettv", "petSchoolComplete"});  
			}
		}
				
		//찜, 좋아요 여부 확인
		VodVO interestVo = new VodVO();
		//마이펫 등록 여부
		String mypetYn = "N";		
		if (!CommonConstants.NO_MEMBER_NO.equals(so.getMbrNo())) {
			interestVo=eduContsService.getInterestYn(so);
			mypetYn = eduContsService.getMyPetYn(so);
		}
		//펫스쿨 따라잡기 인기영상 리스트(공통코드에 등록 후 사용)		
		List<PetLogBaseVO> catchList = new ArrayList<PetLogBaseVO>();
		String catchShowYn = "N";//펫스쿨 따라잡기 인기영상 노출 여부
		CodeDetailVO cdvo = cacheService.getCodeCache(AdminConstants.PETSCHOOL_PETLOG, AdminConstants.PETSCHOOL_PETLOG_10);		
		if(StringUtil.isNotEmpty(cdvo)) {
			String petLogNos = cdvo.getUsrDfn1Val(); 
			catchShowYn = cdvo.getUseYn();
			PetLogMgmtSO pso = new PetLogMgmtSO();
			if(StringUtil.isNotBlank(petLogNos)) {
				String[] petLogs = petLogNos.replace(" ", "").split(",");
				Long[] petLogLongs = new Long[petLogs.length];
				for(int i=0; i < petLogs.length; i++) {
					petLogLongs[i] = Long.parseLong(petLogs[i]);
				}
				pso.setPetLogNos(petLogLongs);			
				catchList= eduContsService.listPetSchoolCatch(pso);
			}
		}
		
		
		//다음교육 리스트 
		if(StringUtil.isNotEmpty(eduContsDetail)) {
			so.setPetGbCd(eduContsDetail.getPetGbCd());
			so.setEudContsCtgMCd(eduContsDetail.getEudContsCtgMCd());
		}		
		List<VodVO> contsList = eduContsService.getApetContentsList(so);		
		
		// seo 정보
		SeoInfoSO seoSo = new SeoInfoSO();
		seoSo.setSeoSvcGbCd(FrontWebConstants.SEO_SVC_GB_CD_20);        // SEO 서비스 구분 코드
		view.setSeoSvcGbCd(FrontWebConstants.SEO_SVC_GB_CD_20);
		seoSo.setSeoTpCd(FrontWebConstants.SEO_TP_30);                        // SEO 유형 코드
		//seoSo.setSeoInfoNo(view.getSeoInfoNo());                                     // SEO 정보 번호
		SeoInfoVO seoInfo = seoService.getSeoInfoFO(seoSo, false);
		map.put("seoInfo", seoInfo);
		map.put("interestVo", interestVo);
		map.put("mypetYn", mypetYn);
		map.put("contsList", contsList);
		map.put("session", session);
		map.put("catchList", catchList);
		map.put("EduContsVO", eduContsDetail);
		//20210414 추가. 펫스쿨완료 -> 펫로그등록 ->펫스쿨완료로 돌아왔을때 처리
		map.put("petLogYn", so.getPetLogYn());
		map.put("histCnt", so.getHistCnt());
		map.put("histLoginCnt", so.getHistLoginCnt());
		map.put("catchShowYn", catchShowYn);
		
		return TilesView.none(new String[]{"pettv", "petSchoolComplete"});  
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 31.front.web
     * - 파일명		: PetSchoolController.java
	 * - 작성일		: 2021. 2. 2.
	 * - 작성자		: kwj
	 * - 설명			: 펫스쿨 찜보관 저장
	 * </pre>
	 * @param 
	 * @return
	 */
	@RequestMapping("saveContsInterest")
	@ResponseBody
	public ModelMap saveContsInterest(Session session, ApetContentsDetailPO po, String deleteYn){
		ModelMap map = new ModelMap();
				
		int rsltCnt = 0;
		po.setMbrNo(session.getMbrNo());		
		if (!CommonConstants.NO_MEMBER_NO.equals(po.getMbrNo())) {
			//찜보관 저장
			rsltCnt = eduContsService.saveContsInterest(po, deleteYn);
		}		
		map.put("rsltCnt", rsltCnt);		
		return map;
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 31.front.web
     * - 파일명		: PetSchoolController.java
	 * - 작성일		: 2021. 3. 3.
	 * - 작성자		: kwj
	 * - 설명			: 펫스쿨 조회수 저장
	 * </pre>
	 * @param 
	 * @return
	 */
	@RequestMapping("saveContsHit")
	@ResponseBody
	public ModelMap saveContsHit(Session session, EduContsPO po){
		ModelMap map = new ModelMap();				
		int rsltCnt = eduContsService.saveContsHit(po);
		map.put("rsltCnt", rsltCnt);		
		return map;
	}
	
	
}