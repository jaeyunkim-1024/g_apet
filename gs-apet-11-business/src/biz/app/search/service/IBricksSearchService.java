package biz.app.search.service;

import java.util.List;
import java.util.Map;

import biz.app.contents.model.SeriesVO;
import biz.app.search.model.IBricksResultVO;
import biz.app.search.model.PopWordVO;
import biz.app.search.model.RecommendTagVO;
import framework.front.model.Session;

/**
 * <pre>
 * - 프로젝트명	: 11.business
 * - 패키지명	: biz.app.search.service
 * - 파일명		: IBricksSearchService.java
 * - 작성일		: 2021. 02. 19.
 * - 작성자		: hg.jeong
 * - 설명		:
 * </pre>
 */
public interface IBricksSearchService {
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명	: IBricksSearchService.java
	 * - 작성일		: 2021. 02. 19.
	 * - 작성자		: pkt
	 * - 설명		: 관심태그 맞춤추천, 마이펫 맞춤추천, 내 활동 맞춤추천
	 * </pre>
	 * @param tagGb 
	 * @param 
	 * @return
	 */		
	public List<RecommendTagVO> getRecommendTagList(Session session, String tagGb) throws Exception;
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명	: IBricksSearchService.java
	 * - 작성일		: 2021. 02. 22.
	 * - 작성자		: pkt
	 * - 설명		:  인기 검색어 추천
	 * </pre>
	 * @param 
	 * @return
	 */		
	public List<PopWordVO> getPopWordList() throws Exception;

	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명	: IBricksSearchService.java
	 * - 작성일		: 2021. 02. 23.
	 * - 작성자		: pkt
	 * - 설명		:  배너(인기 오리지널영상 배너 노출)
	 * </pre>
	 * @param 
	 * @return
	 */		
	public List<SeriesVO> getOriginalVodBnrFO() throws Exception;
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: IBricksSearchService.java
	 * - 작성일		: 2021. 03. 10.
	 * - 작성자		: KKB
	 * - 설명		: 검색 결과
	 * </pre>
	 * @param 
	 * @return
	 */		
	public IBricksResultVO getSearchResult(Map<String,String> requestParam, Session session, String deviceGb) throws Exception;
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명	: IBricksSearchService.java
	 * - 작성일	: 2021. 06. 08.
	 * - 작성자	: YJU
	 * - 설명		: 상품 상세검색 필터 및 브랜드 리스트
	 * </pre>
	 * @param 
	 * @return
	 */		
	public IBricksResultVO getSearchGoodsFilterResult(Map<String,String> requestParam, Session session, String deviceGb) throws Exception;
}