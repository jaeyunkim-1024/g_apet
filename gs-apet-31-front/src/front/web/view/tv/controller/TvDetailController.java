package front.web.view.tv.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.codehaus.jackson.JsonParseException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import biz.app.display.model.SeoInfoSO;
import biz.app.display.model.SeoInfoVO;
import biz.app.display.service.SeoService;
import biz.app.goods.model.GoodsRelatedSO;
import biz.app.goods.service.GoodsService;
import biz.app.tv.model.TvDetailPO;
import biz.app.tv.model.TvDetailSO;
import biz.app.tv.model.TvDetailVO;
import biz.app.tv.service.TvDetailService;
import framework.common.annotation.LoginCheck;
import framework.common.constants.CommonConstants;
import framework.common.enums.SearchApiSpec;
import framework.common.util.NhnShortUrlUtil;
import framework.common.util.SearchApiUtil;
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
* - 패키지명		: front.web.view.tv.controller
* - 파일명		: TvController.java
* - 작성일		: 2021. 01. 19.
* - 작성자		: LDS
* - 설명			: 펫 TV 상세 Controller
* </pre>
*/
@Slf4j
@Controller
public class TvDetailController {

	@Autowired private MessageSourceAccessor message;
	
	@Autowired private TvDetailService tvDetailService;
	
	@Autowired private SearchApiUtil searchApiClient;
	
	@Autowired private SeoService seoService;
	
	@Autowired private GoodsService goodsService;
	
	@Autowired private NhnShortUrlUtil NhnShortUrlUtil;

	/**
	 * <pre>
	 * - 프로젝트명	: 31.front.web
	 * - 파일명		: TvDetailController.java
	 * - 작성일		: 2021. 01. 19.
	 * - 작성자		: LDS
	 * - 설명			: 펫 TV 영상 상세화면
	 * </pre>
	 * @param map
	 * @param session
	 * @param view
	 * @param so
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="tv/series/indexTvDetail")
	public String indexTvDetail(ModelMap map, Session session, ViewBase view, TvDetailSO so){
		
		if (!CommonConstants.NO_MEMBER_NO.equals(session.getMbrNo())) {
			so.setMbrNo(session.getMbrNo());
		} else {
			so.setSsnId(session.getSessionId());
		}
		so.setStId(view.getStId());
		
		map.put("session", session);
		map.put("view", view);
		map.put("so", so);
		
		SeoInfoSO seoSo = new SeoInfoSO();
		seoSo.setSeoSvcGbCd(FrontWebConstants.SEO_SVC_GB_CD_20);	// SEO 서비스 구분 코드
		seoSo.setSeoTpCd(FrontWebConstants.SEO_TP_10);				// SEO 유형 코드
		SeoInfoVO seoInfo = seoService.getSeoInfoFO(seoSo, false);
		map.put("seoInfo", seoInfo);
		
		return TilesView.layout("tv", new String[]{ "indexTvDetail"});
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 31.front.web
	 * - 파일명		: TvDetailController.java
	 * - 작성일		: 2021. 01. 19.
	 * - 작성자		: LDS
	 * - 설명			: 펫 TV 영상 상세 공유하기 화면(빈페이지)
	 * </pre>
	 * @param map
	 * @param session
	 * @param view
	 * @param so
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="tv/series/indexTvShare")
	public String indexTvShare(ModelMap map, Session session, ViewBase view, TvDetailSO so){
		
		//영상 상세정보 조회
		TvDetailVO tvDetailVO = tvDetailService.selectVdoDetailInfo(so);
		
		String thumPt = "";
		if(tvDetailVO.getAcPrflImgPath().lastIndexOf("cdn.ntruss.com") != -1) {
			thumPt = tvDetailVO.getAcPrflImgPath();
		}else {
			thumPt = ImagePathUtil.imagePath(tvDetailVO.getAcPrflImgPath(), FrontConstants.IMG_OPT_QRY_560);
		}
		
		String content = tvDetailVO.getContent().replaceAll("\r\n|\r|\n|\n\r", "<br>");
		map.put("vdId", so.getVdId());
		map.put("img", thumPt);
		map.put("desc", content);
		map.put("title", tvDetailVO.getTtl());
		map.put("sortCd", so.getSortCd());
		map.put("listGb", so.getListGb());
		map.put("gubun", "petTvDetail");
		
		SeoInfoSO seoSo = new SeoInfoSO();
		seoSo.setSeoSvcGbCd(FrontWebConstants.SEO_SVC_GB_CD_20);	// SEO 서비스 구분 코드
		seoSo.setSeoTpCd(FrontWebConstants.SEO_TP_10);				// SEO 유형 코드
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
	 * - 프로젝트명	: 31.front.web
	 * - 파일명		: TvDetailController.java
	 * - 작성일		: 2021. 01. 19.
	 * - 작성자		: LDS
	 * - 설명			: 영상 상세정보, 태그목록, 연관상품목록, 이전/다음 시리즈(시즌) 목록 정보, 추천TV 목록 조회
	 * </pre>
	 * @param 
	 * @return
	 * @throws IOException 
	 * @throws JsonMappingException 
	 * @throws JsonParseException 
	 */
	@RequestMapping("tv/series/selectPrevNextVdoListInfo")
	@ResponseBody
	public ModelMap selectPrevNextVdoListInfo(Session session, TvDetailSO so, ViewBase view) throws JsonParseException, JsonMappingException, IOException, Exception {
		ModelMap map = new ModelMap();
		
		so.setMbrNo(session.getMbrNo());
		
		//영상 태그 조회
		List<TvDetailVO> tagList = tvDetailService.selectVdoTagList(so);
		map.put("tagList", tagList);
		
		//영상 상세정보 조회
		TvDetailVO tvDetailVO = tvDetailService.selectVdoDetailInfo(so);
		
		if(tvDetailVO != null) {
			if(tvDetailVO.getSrtUrl() == null) {
				//단축URL 생성 후 저장
				String domainStr = "";
				if(view.getEnvmtGbCd().equals("local")) {
					domainStr = "https://dev.aboutpet.co.kr";
				}else {
					domainStr = view.getStDomain();
				}
		        String originUrl = domainStr+"/tv/series/indexTvShare?vdId="+so.getVdId()+"&sortCd=&listGb=HOME";
		        String shortUrl = NhnShortUrlUtil.getUrl(originUrl);
		        TvDetailPO tvDetailPO = new TvDetailPO();
		        tvDetailPO.setVdId(so.getVdId());
		        tvDetailPO.setSrtUrl(shortUrl);
		        tvDetailService.updateVdoShortUrl(tvDetailPO);
		        tvDetailVO.setSrtUrl(shortUrl);
			}
			
			int relatedGoodsCount = 0;
			//V-커머스 일때만 조회(10=일반, 20=V-커머스)
			if("20".equals(tvDetailVO.getVdTpCd())) {
				//연관상품 갯수 조회
				GoodsRelatedSO goodsRelatedSo = new GoodsRelatedSO();
				goodsRelatedSo.setVdId(so.getVdId());
				goodsRelatedSo.setWebMobileGbCd(view.getDeviceGb());
				goodsRelatedSo.setStId(view.getStId());
				relatedGoodsCount = goodsService.getGoodsRelatedWithTvCount(goodsRelatedSo);
				
				//연관상품 썸네일 조회
				tvDetailVO.setGoodsImgVO(goodsService.getGoodsRelatedWithTvThumb(goodsRelatedSo));
			}
			tvDetailVO.setGoodsCount(relatedGoodsCount);
			
			//추천일치율
			if (!CommonConstants.NO_MEMBER_NO.equals(session.getMbrNo()) && tvDetailVO != null) {
				try {
					Map<String,String> requestParam1 = new HashMap<String,String>();
			        requestParam1.put("INDEX", "TV"); //추천TV
			        requestParam1.put("MBR_NO", String.valueOf(so.getMbrNo())); 
			        requestParam1.put("CONTENT_ID", String.valueOf(so.getVdId())); //영상번호
			        String res1 = searchApiClient.getResponse(SearchApiSpec.SRCH_API_IF_RECOMMENDRATE, requestParam1);
			        String rate = "";
			        if(res1 != null) {
			        	ObjectMapper objectMapper = new ObjectMapper();
			        	Map<String, Object> resMap = objectMapper.readValue(res1, Map.class);
			        	Map<String, Object> statusMap = (Map)resMap.get("STATUS");
			        	if( ((Integer)statusMap.get("CODE")).equals(200) ) {
			        		Map<String, Object> dataMap = (Map)resMap.get("DATA");
			    		
			        		if( (int)dataMap.get("TOTAL") > 0 ) {
			        			Map<String, Object> items = (Map)dataMap.get("ITEM");
			        			rate = String.valueOf(items.get("RATE"));
			        		}
			        	}
					}
			        tvDetailVO.setRate(rate);
				}catch(Exception e) {
					// 보안성 진단. 오류메시지를 통한 정보노출
					//log.error(e.getMessage());
					log.error("exception when SRCH_API_IF_RECOMMENDRATE", e.getClass());
				}
			}
			map.put("tvDetailVO", tvDetailVO);
			
			//시리즈 목록 조회
			so.setSrisNo(tvDetailVO.getSrisNo());
			so.setRepeatYn(tvDetailVO.getRepeatYn());
			so.setSrisSeq(tvDetailVO.getSrisSeq());
			List<TvDetailVO> srisList = tvDetailService.selectVdoSrisList(so);
			map.put("srisList", srisList);
			
			if(srisList.size() > 0) {
				//이전 시리즈 정보 조회
				TvDetailVO prevSrisInfo = tvDetailService.selectVdoPrevSrisInfo(so);
				if(prevSrisInfo != null) {
					map.put("prevSrisInfo", prevSrisInfo);
				}else {
					//이전 시리즈 정보가 없으면(첫번째 시리즈) 마지막(등록순) 시리즈 정보 조회
					TvDetailVO LastSrisInfo = tvDetailService.selectVdoLastSrisInfo(so);
					map.put("prevSrisInfo", LastSrisInfo);
				}
				
				//다음 시리즈 정보 조회
				TvDetailVO nextSrisInfo = tvDetailService.selectVdoNextSrisInfo(so);
				if(nextSrisInfo != null) {
					map.put("nextSrisInfo", nextSrisInfo);
				}else {
					//다음 시리즈 정보가 없으면(마지막 시리즈) 첫번째(등록순) 시리즈 정보 조회
					TvDetailVO firstSrisInfo = tvDetailService.selectVdoFirstSrisInfo(so);
					map.put("nextSrisInfo", firstSrisInfo);
				}
			}
			
			//시즌 목록 조회
			so.setSesnNo(tvDetailVO.getSesnNo());
			List<TvDetailVO> sesnList = tvDetailService.selectVdoSesnList(so);
			map.put("sesnList", sesnList);
			
			if(sesnList.size() > 0) {
				//이전 시즌 정보 조회
				TvDetailVO prevSesnInfo = tvDetailService.selectVdoPrevSesnInfo(so);
				map.put("prevSesnInfo", prevSesnInfo);
				
				//다음 시즌 정보 조회
				TvDetailVO nextSesnInfo = tvDetailService.selectVdoNextSesnInfo(so);
				map.put("nextSesnInfo", nextSesnInfo);
			}
			
			try {
				Map<String,String> requestParam = new HashMap<String,String>();
		        requestParam.put("INDEX", "TV"); //추천 대상서비스(TV/LOG/SHOP)
		        requestParam.put("TARGET_INDEX", "tv-related-tv"); //TV영상에 대한 관련 영상
		        requestParam.put("MBR_NO", String.valueOf(so.getMbrNo())); 
		        requestParam.put("CONTENT_ID", String.valueOf(so.getVdId())); //영상번호
		        requestParam.put("FROM", "1");
		        requestParam.put("SIZE", "20");
		        
		        List<TvDetailVO> adviceVdoList = new ArrayList<TvDetailVO>();
		        String res = searchApiClient.getResponse(SearchApiSpec.SRCH_API_IF_RECOMMEND, requestParam);
		        if(res != null) {
		        	ObjectMapper objectMapper = new ObjectMapper();
		        	Map<String, Object> resMap = objectMapper.readValue(res, Map.class);
		        	Map<String, Object> statusMap = (Map)resMap.get("STATUS");
		        	if( ((Integer)statusMap.get("CODE")).equals(200) ) {
		        		Map<String, Object> dataMap = (Map)resMap.get("DATA");
		    		
		        		if( (int)dataMap.get("TOTAL") > 0 ) {
		        			List<Map<String, Object>> items = (List)dataMap.get("ITEM");
		        			TvDetailSO dtlSO = new TvDetailSO();
		        			dtlSO.setMbrNo(session.getMbrNo());
		        			
		        			//검색API에서 준 VD_ID 목록
		        			List<String> vdIdList = new ArrayList<String>();
		        			for(Map<String, Object> item : items) {
		        				vdIdList.add(String.valueOf(item.get("VD_ID")));
		        			}
		        			dtlSO.setVdIdList(vdIdList);
		        			
		        			adviceVdoList = tvDetailService.selectSimpleVdoDetailInfo(dtlSO);
		        			if(adviceVdoList.size() > 0) {
		        				for(TvDetailVO vo : adviceVdoList) {
		        					for(Map<String, Object> item : items ) {
		        						if(vo.getVdId().equals(String.valueOf(item.get("VD_ID")))) {
		        							vo.setTtl(String.valueOf(item.get("TTL")));
		        							vo.setAcPrflImgPath(String.valueOf(item.get("THUM_PATH")));
		        							vo.setRate(String.valueOf(item.get("RATE")));
		        						}
		        					}
		        				}
		        			}
		        			
		        			/*for(Map<String, Object> item : items ) {
		        				dtlSO.setVdId(String.valueOf(item.get("VD_ID")));
		        				dtlVO = tvDetailService.selectSimpleVdoDetailInfo(dtlSO);
		        				if(dtlVO != null) {
		        					dtlVO.setTtl(String.valueOf(item.get("TTL")));
		            				dtlVO.setAcPrflImgPath(String.valueOf(item.get("THUM_PATH")));
		            				dtlVO.setRate(String.valueOf(item.get("RATE")));
		            				adviceVdoList.add(dtlVO);
		        				}
		        			}*/
		        		}
		        	}
				}
		        map.put("adviceVdoList", adviceVdoList);
			}catch(Exception e) {
				// 보안성 진단. 오류메시지를 통한 정보노출
				//log.error(e.getMessage());
				log.error("Exception when SRCH_API_IF_RECOMMEND", e.getClass());
			}
		}
        
		return map;
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 31.front.web
	 * - 파일명		: TvDetailController.java
	 * - 작성일		: 2021. 01. 19.
	 * - 작성자		: LDS
	 * - 설명			: 영상 조회수 증가
	 * </pre>
	 * @param 
	 * @return
	 */
	@RequestMapping("tv/series/updateVdoHits")
	@ResponseBody
	public ModelMap updateVdoHits(Session session, TvDetailSO so) {
		int rsltCnt = 0;
		
		rsltCnt = tvDetailService.updateVdoHits(so);
		
		ModelMap map = new ModelMap();
		if(rsltCnt > 0) {
			map.put("actGubun", "success");
		}else {
			map.put("actGubun", "error");
		}
		
		return map;
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 31.front.web
	 * - 파일명		: TvDetailController.java
	 * - 작성일		: 2021. 01. 19.
	 * - 작성자		: LDS
	 * - 설명			: 영상 시청이력 저장
	 * </pre>
	 * @param 
	 * @return
	 */
	@RequestMapping("tv/series/saveVdoViewHist")
	@ResponseBody
	public ModelMap saveVdoViewHist(Session session, TvDetailPO po) {
		int rsltCnt = 0;
		
		//if(!CommonConstants.NO_MEMBER_NO.equals(session.getMbrNo())) {
		if(!CommonConstants.NO_MEMBER_NO.equals(po.getMbrNo())) {
			//시청이력 저장
			rsltCnt = tvDetailService.saveVdoViewHist(po);
		}
		
		ModelMap map = new ModelMap();
		if(rsltCnt > 0) {
			map.put("actGubun", "success");
		}else {
			map.put("actGubun", "error");
		}
		
		return map;
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 31.front.web
	 * - 파일명		: TvDetailController.java
	 * - 작성일		: 2021. 01. 19.
	 * - 작성자		: LDS
	 * - 설명			: 영상 좋아요, 찜 저장/해제
	 * </pre>
	 * @param 
	 * @return
	 */
	@RequestMapping("tv/series/saveVdoLikeDibs")
	@ResponseBody
	public ModelMap saveVdoLikeDibs(Session session, TvDetailPO po){
		int rs = 0;
		
		//if (!CommonConstants.NO_MEMBER_NO.equals(session.getMbrNo())) {
		if (!CommonConstants.NO_MEMBER_NO.equals(po.getMbrNo())) {
			//session.setMbrNo(1L);
			rs = tvDetailService.saveVdoLikeDibs(po);
		}
		
		ModelMap map = new ModelMap();
		if(rs == 1){
			map.put("actGubun", "add");
		}else if(rs ==2){
			map.put("actGubun", "remove");
		}else{
			map.put("actGubun", "error");
		}
		
		if("10".equals(po.getIntrGbCd())) {
			int likeCnt = tvDetailService.selectLikeCount(po);
			map.put("likeCnt", likeCnt);
		}
		
		return map;
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 31.front.web
	 * - 파일명		: TvDetailController.java
	 * - 작성일		: 2021. 01. 19.
	 * - 작성자		: LDS
	 * - 설명			: 영상 공유 저장
	 * </pre>
	 * @param 
	 * @return
	 */
	@RequestMapping("tv/series/insertVdoShare")
	@ResponseBody
	public ModelMap insertVdoShare(Session session, TvDetailPO po){
		int rsltCnt = 0;
		po.setMbrNo(session.getMbrNo());
		rsltCnt = tvDetailService.insertVdoShare(po);
		
		ModelMap map = new ModelMap();
		if(rsltCnt > 0) {
			map.put("actGubun", "success");
		}else {
			map.put("actGubun", "error");
		}
		
		return map;
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 31.front.web
	 * - 파일명		: TvDetailController.java
	 * - 작성일		: 2021. 02. 10.
	 * - 작성자		: LDS
	 * - 설명			: 마이페이지 > 최근 시청한 영상
	 * </pre>
	 * @param map
	 * @param session
	 * @param view
	 * @param so
	 * @return
	 * @throws Exception
	 */
	@LoginCheck
	@RequestMapping(value="tv/series/indexTvRecentVideo")
	public String indexTvRecentVideo(ModelMap map, Session session, ViewBase view, TvDetailSO so){
		
		if (!CommonConstants.NO_MEMBER_NO.equals(session.getMbrNo())) {
			so.setMbrNo(session.getMbrNo());
			
			//최근 시청한 영상 목록조회
			List<TvDetailVO> recentVdoList = tvDetailService.selectRecentVdoList(so);
			map.put("recentVdoList", recentVdoList);
		} else {
			so.setSsnId(session.getSessionId());
		}
		so.setStId(view.getStId());
		
		map.put("session", session);
		map.put("view", view);
		map.put("so", so);
		
		SeoInfoSO seoSo = new SeoInfoSO();
		view.setSeoSvcGbCd(FrontWebConstants.SEO_SVC_GB_CD_40);
		seoSo.setSeoSvcGbCd(view.getSeoSvcGbCd());	// SEO 서비스 구분 코드
		seoSo.setSeoTpCd(FrontWebConstants.SEO_TP_10);				// SEO 유형 코드
		SeoInfoVO seoInfo = seoService.getSeoInfoFO(seoSo, false);
		map.put("seoInfo", seoInfo);
		
		return TilesView.layout("tv", new String[]{ "indexTvRecentVideo"});
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 31.front.web
	 * - 파일명		: TvDetailController.java
	 * - 작성일		: 2021. 02. 10.
	 * - 작성자		: LDS
	 * - 설명			: 마이페이지 > 최근 시청한 영상 삭제
	 * </pre>
	 * @param 
	 * @return
	 */
	@RequestMapping("tv/series/deleteRecentVdo")
	@ResponseBody
	public ModelMap deleteRecentVdo(Session session, TvDetailPO po){
		int rsltCnt = 0;
		po.setMbrNo(session.getMbrNo());
		rsltCnt = tvDetailService.deleteRecentVdo(po);
		
		ModelMap map = new ModelMap();
		if(rsltCnt > 0) {
			map.put("actGubun", "success");
		}else {
			map.put("actGubun", "error");
		}
		
		return map;
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 31.front.web
	 * - 파일명		: TvDetailController.java
	 * - 작성일		: 2021. 02. 23.
	 * - 작성자		: LDS
	 * - 설명			: 설정 > 메인설정 화면
	 * </pre>
	 * @param map
	 * @param session
	 * @param view
	 * @param so
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="setting/indexSettingMain")
	public String indexTvDetail(ModelMap map, Session session, ViewBase view){
		
		map.put("session", session);
		map.put("view", view);
		
		SeoInfoSO seoSo = new SeoInfoSO();
		seoSo.setSeoSvcGbCd(FrontWebConstants.SEO_SVC_GB_CD_40);	// SEO 서비스 구분 코드
		seoSo.setSeoTpCd(FrontWebConstants.SEO_TP_10);				// SEO 유형 코드
		SeoInfoVO seoInfo = seoService.getSeoInfoFO(seoSo, false);
		map.put("seoInfo", seoInfo);
		
		return TilesView.layout("setting", new String[]{ "indexSettingMain"});
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 31.front.web
	 * - 파일명		: TvDetailController.java
	 * - 작성일		: 2021. 02. 23.
	 * - 작성자		: LDS
	 * - 설명			: 설정 > 동영상 자동재생 설정 화면
	 * </pre>
	 * @param map
	 * @param session
	 * @param view
	 * @param so
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="setting/indexSettingAutoPlay")
	public String indexSettingAutoPlay(ModelMap map, Session session, ViewBase view){

		map.put("session", session);
		map.put("view", view);
		
		SeoInfoSO seoSo = new SeoInfoSO();
		seoSo.setSeoSvcGbCd(FrontWebConstants.SEO_SVC_GB_CD_40);	// SEO 서비스 구분 코드
		seoSo.setSeoTpCd(FrontWebConstants.SEO_TP_10);				// SEO 유형 코드
		SeoInfoVO seoInfo = seoService.getSeoInfoFO(seoSo, false);
		map.put("seoInfo", seoInfo);
		
		return TilesView.layout("setting", new String[]{ "indexSettingAutoPlay"});
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 31.front.web
	 * - 파일명		: TvDetailController.java
	 * - 작성일		: 2021. 08. 19.
	 * - 작성자		: LDS
	 * - 설명			: 영상 좋아요 건수 조회
	 * </pre>
	 * @param 
	 * @return
	 */
	@RequestMapping("tv/series/selectLikeCount")
	@ResponseBody
	public ModelMap selectLikeCount(Session session, TvDetailPO po){
		ModelMap map = new ModelMap();
		
		int likeCnt = tvDetailService.selectLikeCount(po);
		map.put("likeCnt", likeCnt);
		
		return map;
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 31.front.web
	 * - 파일명		: TvDetailController.java
	 * - 작성일		: 2021. 08. 26.
	 * - 작성자		: LDS
	 * - 설명			: 영상 로그인한 회원의 좋아요, 찜 여부 확인
	 * </pre>
	 * @param 
	 * @return
	 */
	@RequestMapping("tv/series/selectVdoMbrLikeMarkCheck")
	@ResponseBody
	public ModelMap selectVdoMbrLikeMarkCheck(Session session, TvDetailPO po){
		ModelMap map = new ModelMap();
		
		if (!CommonConstants.NO_MEMBER_NO.equals(session.getMbrNo())) {
			po.setMbrNo(session.getMbrNo());
			String likeMarkCheck = tvDetailService.selectVdoMbrLikeMarkCheck(po);
			map.put("likeMarkCheck", likeMarkCheck);
			
			po.setIntrGbCd("10");
			int likeCnt = tvDetailService.selectLikeCount(po);
			map.put("likeCnt", likeCnt);
		}
		
		return map;
	}
	
}