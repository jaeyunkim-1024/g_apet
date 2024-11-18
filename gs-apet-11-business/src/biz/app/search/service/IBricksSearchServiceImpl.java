package biz.app.search.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import org.codehaus.jackson.JsonNode;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.fasterxml.jackson.databind.MapperFeature;

import biz.app.brand.model.BrandBaseSearchVO;
import biz.app.contents.model.SeriesSO;
import biz.app.contents.model.SeriesVO;
import biz.app.display.dao.DisplayDao;
import biz.app.display.model.DisplayCornerSO;
import biz.app.goods.model.GoodsFiltAttrSearchVO;
import biz.app.goods.model.GoodsFiltGrpSearchVO;
import biz.app.search.dao.SearchDao;
import biz.app.search.model.IBricksResultVO;
import biz.app.search.model.LogContentVO;
import biz.app.search.model.LogMemberVO;
import biz.app.search.model.PopWordVO;
import biz.app.search.model.RecommendTagVO;
import biz.app.search.model.SearchSO;
import biz.app.search.model.ShopBrandVO;
import biz.app.search.model.ShopDbGoodsVO;
import biz.app.search.model.ShopGoodsVO;
import biz.app.search.model.TvSeriesVO;
import biz.app.search.model.TvVideoVO;
import framework.common.constants.CommonConstants;
import framework.common.enums.SearchApiSpec;
import framework.common.util.DateUtil;
import framework.common.util.SearchApiUtil;
import framework.front.model.Session;
import lombok.extern.slf4j.Slf4j;

/**
 * 사이트 IBricksSearchServiceImpl
 * @author		pkt
 * @since		2021.02.19
 */
@Slf4j
@Service
@Transactional
public class IBricksSearchServiceImpl implements IBricksSearchService {
	@Autowired
	private SearchApiUtil searchApiUtil;
	
	@Autowired 
	private Properties webConfig;
	
	@Autowired
	private DisplayDao displayDao;
	
	@Autowired
	private SearchDao searchDao;
	
	@Override
	public List<RecommendTagVO> getRecommendTagList(Session session, String tagGb) throws Exception {
		Map<String,String> requestParam = new HashMap<String,String>();
        requestParam.put("MBR_NO", String.valueOf(session.getMbrNo())); 
//		requestParam.put("MBR_NO", "2");
		requestParam.put("PET_NO", String.valueOf(session.getPetGbCd()));
//		requestParam.put("PET_NO", "0");
        requestParam.put("FROM", "1");
        requestParam.put("SIZE", "8"); 			        
        
        List<RecommendTagVO> tagList = new ArrayList<>();
        
        String res = null;
        if("P".equals(tagGb)) {						//마이펫 맞춤추천(P)
        	requestParam.put("TARGET_INDEX","pet-tag");
        	res = searchApiUtil.getResponse(SearchApiSpec.SRCH_API_IF_RECOMMEND, requestParam);
        } else if("A".equals(tagGb)) {		//내 활동 맞춤추천(A)
        	requestParam.put("TARGET_INDEX","action-tag");
        	res = searchApiUtil.getResponse(SearchApiSpec.SRCH_API_IF_RECOMMEND, requestParam);
        } else {													//관심태그 맞춤추천(I)
        	requestParam.put("TARGET_INDEX","interest-tag");
        	res = searchApiUtil.getResponse(SearchApiSpec.SRCH_API_IF_RECOMMEND, requestParam);
        }
        if(res != null) {
        	ObjectMapper objectMapper = new ObjectMapper();
        	Map<String, Object> resMap = objectMapper.readValue(res, Map.class);
        	Map<String, Object> statusMap = (Map)resMap.get("STATUS");
        	if( ((Integer)statusMap.get("CODE")).equals(200) ) {
        		Map<String, Object> dataMap = (Map)resMap.get("DATA");
    		
        		if( (int)dataMap.get("TOTAL") > 0 ) {
        			List<Map<String, Object>> items = (List)dataMap.get("ITEM");
        			RecommendTagVO vo;
        			for(Map<String, Object> item : items ) {
        				vo = new RecommendTagVO();
        				vo.setTagNm((String)item.get("TAG"));
        				tagList.add(vo);
        			}
        		}
        	}
		}

		return tagList;
	}

	@Override
	public List<PopWordVO> getPopWordList() throws Exception {
		Map<String,String> requestParam = new HashMap<String,String>();
        
        List<PopWordVO> popWordList = new ArrayList<>();
        requestParam.put("LABEL", "all");
        
        String res = searchApiUtil.getResponse(SearchApiSpec.SRCH_API_IF_POPQUERY, requestParam);
        if(res != null) {
        	ObjectMapper objectMapper = new ObjectMapper();
        	Map<String, Object> resMap = objectMapper.readValue(res, Map.class);
        	Map<String, Object> statusMap = (Map)resMap.get("STATUS");
        	if( ((Integer)statusMap.get("CODE")).equals(200) ) {
        		Map<String, Object> dataMap = (Map)resMap.get("DATA");
    		
        		if( (int)dataMap.get("TOTAL") > 0 ) {
        			List<Map<String, Object>> items = (List)dataMap.get("ITEMS");
        			PopWordVO vo;
        			for(Map<String, Object> item : items ) {
        				vo = new PopWordVO();
        				vo.setIBricksRank((Integer)item.get("RANK"));
        				vo.setIBricksQuery((String)item.get("QUERY"));
        				vo.setIBricksCount((Integer)item.get("COUNT"));
        				vo.setIBricksDiff((Integer)item.get("DIFF"));
        				vo.setIBricksUpdown((String)item.get("UPDOWN"));
        				popWordList.add(vo);
        			}
        		}
        	}
		}

		return popWordList;
	}
	
	@Override
	public List<SeriesVO> getOriginalVodBnrFO() throws Exception {
		DisplayCornerSO so = new DisplayCornerSO();
		
		// BO에서 등록한 시리즈 목록
		so.setDispClsfNo(Long.valueOf(webConfig.getProperty("site.main.tv.disp.clsf.no")));
		so.setDispCornNo(Long.valueOf(webConfig.getProperty("disp.corn.no.tv.series.vod")));
		so.setPreviewDt(DateUtil.getNowDate());
		so.setRows(5);
		List<SeriesVO> seriesList = displayDao.pageDisplayCornerItemSeriesFO(so);

		if (seriesList.size() < so.getRows()) {
			int showCnt = so.getRows();
			int listCnt = seriesList.size();

			int minValCnt = showCnt - listCnt;

			SeriesSO sso = new SeriesSO();

			List<Long> srisIds = new ArrayList<Long>();
			for (int i = 0; i < seriesList.size(); i++) {
				srisIds.add(seriesList.get(i).getSrisNo());
			}
			sso.setSeriesList(srisIds);
			sso.setLimit(0);
			sso.setOffset(minValCnt);

			// 인기 오리지널 시리즈 목록
			List<SeriesVO> list = displayDao.getOriginSeries(sso);

			seriesList.addAll(list);
		}
		return seriesList;
	}

	@SuppressWarnings({ "unlikely-arg-type", "unchecked" })
	@Override
	public IBricksResultVO getSearchResult(Map<String, String> requestParam, Session session, String deviceGb){
		ObjectMapper mapper = new ObjectMapper();
		JsonNode resultJsonNode = null;
		log.info("requestParam >>>>" + requestParam);
		try {
			resultJsonNode = mapper.readTree(searchApiUtil.getResponse(SearchApiSpec.SRCH_API_IF_SEARCH, requestParam));
		} catch (IOException e1) {
			// 보안성 진단. 오류메시지를 통한 정보노출
			//log.error(e1.getMessage());
			log.error("Exception when getSearchResult deserialize JSON", e1.getClass());
		}
		IBricksResultVO irvo = new IBricksResultVO();
		if(resultJsonNode != null && resultJsonNode.get("STATUS") != null && CommonConstants.CIS_API_SUCCESS_HTTP_STATUS_CD.equals(resultJsonNode.get("STATUS").get("CODE").getValueAsText())) {
			JsonNode resultData = resultJsonNode.get("DATA");
			irvo.setTotalCount(resultData.get("TOTAL").getValueAsLong());
			irvo.setSpellerKeyword(resultData.get("SPELLER_KEYWORD").getValueAsText());
			for (int i=0; i <  resultData.get("ITEM").size() ; i++) {
				JsonNode item = resultData.get("ITEM").get(i);
				JsonNode itemResult = item.get("RESULT");
				com.fasterxml.jackson.databind.ObjectMapper jacksonMapper =  new com.fasterxml.jackson.databind.ObjectMapper().configure(MapperFeature.ACCEPT_CASE_INSENSITIVE_PROPERTIES, true);
				if("se_tv_series".equals(item.get("TARGET_NAME").getValueAsText())){			// TV-시리즈
					irvo.setSeriesCount(item.get("COUNT").getValueAsLong());
					List<TvSeriesVO> seriesList = new ArrayList<TvSeriesVO>();
					try {
					seriesList = Arrays.asList(jacksonMapper.readValue(itemResult.toString(), TvSeriesVO[].class));
					}catch (Exception e) {
						// 보안성 진단. 오류메시지를 통한 정보노출
						//log.error(e.getMessage());
						log.error("Exception when getSearchResult make seriesList", e.getClass());
					}
					irvo.setSeriesList(seriesList);
				}else if("se_tv_video".equals(item.get("TARGET_NAME").getValueAsText())){		// TV-동영상
					irvo.setVideoCount(item.get("COUNT").getValueAsLong());
					List<TvVideoVO> videoList = new ArrayList<TvVideoVO>();
					try {
						videoList = Arrays.asList(jacksonMapper.readValue(itemResult.toString(), TvVideoVO[].class));
					}catch (Exception e) {
						// 보안성 진단. 오류메시지를 통한 정보노출
						//log.error(e.getMessage());
						log.error("Exception when getSearchResult make videoList", e.getClass());
					}
					irvo.setVideoList(videoList);
				}else if("se_log_member".equals(item.get("TARGET_NAME").getValueAsText())){		// LOG - 펫로그 사용자
					irvo.setMemberCount(item.get("COUNT").getValueAsLong());
					List<LogMemberVO> memberList = new ArrayList<LogMemberVO>();
					try {
						memberList = Arrays.asList(jacksonMapper.readValue(itemResult.toString(), LogMemberVO[].class));
					}catch (Exception e) {
						// 보안성 진단. 오류메시지를 통한 정보노출
						//log.error(e.getMessage());
						log.error("Exception when getSearchResult make memberList", e.getClass());
					}
					irvo.setMemberList(memberList);
				}else if("se_log_content".equals(item.get("TARGET_NAME").getValueAsText())){	// LOG - 펫로그 
					irvo.setContentCount(item.get("COUNT").getValueAsLong());
					List<LogContentVO> contentList = new ArrayList<LogContentVO>();
					try {
						contentList = Arrays.asList(jacksonMapper.readValue(itemResult.toString(), LogContentVO[].class));
					}catch (Exception e) {
						// 보안성 진단. 오류메시지를 통한 정보노출
						//log.error(e.getMessage());
						log.error("Exception when getSearchResult make contentList", e.getClass());
					}
					irvo.setContentList(contentList);
				}else if("se_shop_brand".equals(item.get("TARGET_NAME").getValueAsText())){		// SHOP - 브랜드
					irvo.setBrandCount(item.get("COUNT").getValueAsLong());
					List<ShopBrandVO> brandList = new ArrayList<ShopBrandVO>();
					try {
						brandList = Arrays.asList(jacksonMapper.readValue(itemResult.toString(), ShopBrandVO[].class));
					}catch (Exception e) {
						// 보안성 진단. 오류메시지를 통한 정보노출
						//log.error(e.getMessage());
						log.error("Exception when getSearchResult make brandList", e.getClass());
					}
					irvo.setBrandList(brandList);
				}else if("se_shop_goods".equals(item.get("TARGET_NAME").getValueAsText())){		// SHOP - 상품
					irvo.setGoodsCount(item.get("COUNT").getValueAsLong());
					List<ShopGoodsVO> goodsList = new ArrayList<ShopGoodsVO>();
					List<ShopDbGoodsVO> dbList = null;
					try {
						goodsList = Arrays.asList(jacksonMapper.readValue(itemResult.toString(), ShopGoodsVO[].class));
						String[] goodsIds = new String[goodsList.size()];
						for(int j=0 ; j < goodsList.size() ; j++) {
							goodsIds[j] = goodsList.get(j).getGoods_id();
						}
						SearchSO sso = new SearchSO();
						sso.setGoodsIds(goodsIds);
						sso.setMbrNo(session.getMbrNo());
						sso.setDeviceGb(deviceGb);
						dbList = searchDao.getListGoods(sso);
					}catch (Exception e) {
						// 보안성 진단. 오류메시지를 통한 정보노출
						//log.error(e.getMessage());
						log.error("Exception when getSearchResult make goodsList", e.getClass());
					}
					irvo.setGoodsList(dbList);
				}
			}
		}
		return irvo;
	}

	@Override
	public IBricksResultVO getSearchGoodsFilterResult(Map<String, String> requestParam, Session session, String deviceGb) throws Exception {
		ObjectMapper mapper = new ObjectMapper();
		JsonNode resultJsonNode = null;
		log.info("requestParam >>>>" + requestParam);
		try {
			resultJsonNode = mapper.readTree(searchApiUtil.getResponse(SearchApiSpec.SRCH_API_IF_GOODS_FILTER_AGGREGATION, requestParam));
		} catch (IOException e1) {
			// 보안성 진단. 오류메시지를 통한 정보노출
			//log.error(e1.getMessage());
			log.error("Exception when getSearchResult deserialize JSON", e1.getClass());
		}
		IBricksResultVO irvo = new IBricksResultVO();
		com.fasterxml.jackson.databind.ObjectMapper jacksonMapper =  new com.fasterxml.jackson.databind.ObjectMapper().configure(MapperFeature.ACCEPT_CASE_INSENSITIVE_PROPERTIES, true);
		if(resultJsonNode != null && resultJsonNode.get("STATUS") != null && CommonConstants.CIS_API_SUCCESS_HTTP_STATUS_CD.equals(resultJsonNode.get("STATUS").get("CODE").getValueAsText())) {
			JsonNode resultData = resultJsonNode.get("DATA");
			for (int i=0; i <  resultData.get("BND_NM_AGG").size() ; i++) {
				JsonNode brandArr = resultData.get("BND_NM_AGG");
				
				List<BrandBaseSearchVO> filterBrandList = new ArrayList<BrandBaseSearchVO>();
				
				try {
					filterBrandList = Arrays.asList(jacksonMapper.readValue(brandArr.toString(), BrandBaseSearchVO[].class));
				}catch (Exception e) {
					// 보안성 진단. 오류메시지를 통한 정보노출
					//log.error(e.getMessage());
					log.error("Exception when getSearchResult make goodsList", e.getClass());
				}
				irvo.setFilterBrandList(filterBrandList);
			}
			
			for (int i=0; i <  resultData.get("FILT_AGG").size() ; i++) {
				JsonNode filterArr = resultData.get("FILT_AGG");
				JsonNode filterAttrsArr = filterArr.get(i).get("FILT_ATTRS");
				List<GoodsFiltGrpSearchVO> filterList = new ArrayList<GoodsFiltGrpSearchVO>();
				List<GoodsFiltAttrSearchVO> filterAttrsList = new ArrayList<GoodsFiltAttrSearchVO>();
				
				try {
					filterList = Arrays.asList(jacksonMapper.readValue(filterArr.toString(), GoodsFiltGrpSearchVO[].class));
					filterAttrsList = Arrays.asList(jacksonMapper.readValue(filterAttrsArr.toString(), GoodsFiltAttrSearchVO[].class));
					filterList.get(i).setFiltAttrs(filterAttrsList);
				}catch (Exception e) {
					// 보안성 진단. 오류메시지를 통한 정보노출
					//log.error(e.getMessage());
					log.error("Exception when getSearchResult make goodsList", e.getClass());
				}
				irvo.setFilterList(filterList);
			}
		}
		return irvo;
	}

}