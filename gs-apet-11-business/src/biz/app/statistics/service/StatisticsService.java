package biz.app.statistics.service;

import java.util.List;

import biz.app.statistics.model.DayWmsStockTotalSO;
import biz.app.statistics.model.DayWmsStockTotalVO;
import biz.app.statistics.model.MemberFlowReportVO;
import biz.app.statistics.model.MonthWmsPoTotalSO;
import biz.app.statistics.model.MonthWmsPoTotalVO;
import biz.app.statistics.model.OrderBestGoodsReportSO;
import biz.app.statistics.model.OrderBestGoodsReportVO;
import biz.app.statistics.model.OrderCategoryReportSO;
import biz.app.statistics.model.OrderCategoryReportVO;
import biz.app.statistics.model.OrderDailyReportSO;
import biz.app.statistics.model.OrderDailyReportVO;
import biz.app.statistics.model.StatsByAreaVO;
import biz.app.statistics.model.StatsByClassVO;
import biz.app.statistics.model.StatsByCompBrandVO;
import biz.app.statistics.model.StatsByCompVO;
import biz.app.statistics.model.StatsByGoodsVO;
import biz.app.statistics.model.StatsByLCtgVO;
import biz.app.statistics.model.StatsByMCtgVO;
import biz.app.statistics.model.StatsByPeriodVO;
import biz.app.statistics.model.StatsBySaleRankVO;
import biz.app.statistics.model.StatsBySeriesVO;
import biz.app.statistics.model.StatsGoodsVO;
import biz.app.statistics.model.StatsOuterVO;
import biz.app.statistics.model.StatsSO;
import biz.app.statistics.model.WmsOutOrdTotalSO;
import biz.app.statistics.model.WmsOutOrdTotalVO;

/**
 * get업무명	:	단권
 * list업무명	:	리스트
 * page업무명	:	리스트 페이징
 * insert업무명	:	입력
 * update업무명	:	수정
 * delete업무명	:	삭제
 * save업무명	:	입력 / 수정
 */
/**
 * <pre>
 * - 프로젝트명	: 11.business
 * - 패키지명	: biz.app.display.service
 * - 파일명		: DisplayService.java
 * - 작성일		: 2016. 5. 18.
 * - 작성자		: jhlee
 * - 설명		:
 * </pre>
 */
public interface StatisticsService {

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: StatisticsService.java
	* - 작성일		: 2017. 8. 1.
	* - 작성자		: hongjun
	* - 설명		: 일 주문 현황 리스트
	* </pre>
	* @param so
	* @return
	*/
	public List<OrderDailyReportVO> orderDailyReportListGrid(OrderDailyReportSO so);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: StatisticsService.java
	* - 작성일		: 2017. 8. 2.
	* - 작성자		: hongjun
	* - 설명		: 카테고리 별 판매 실적 리스트 
	* </pre>
	* @param so
	* @return
	*/
	public List<OrderCategoryReportVO> orderCategoryReportListGrid(OrderCategoryReportSO so);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: StatisticsService.java
	* - 작성일		:
	* - 작성자		:
	* - 설명		:  ebiz 기간별 리스트
	* </pre>
	* @param so
	* @return
	*/
	public List<StatsByPeriodVO> ebizPeriodSalesListGrid(StatsSO so);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: StatisticsService.java
	* - 작성일		:
	* - 작성자		:
	* - 설명		:  ebiz 판매유형별 리스트
	* </pre>
	* @param so
	* @return
	*/
	public List<StatsByClassVO> ebizClassSalesListGrid(StatsSO so);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: StatisticsService.java
	* - 작성일		:
	* - 작성자		:
	* - 설명		:  ebiz 입점업체 / 판매대행 매출비교 리스트
	* </pre>
	* @param so
	* @return
	*/
	public List<StatsByCompVO> ebizSalesListGrid(StatsSO so);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: StatisticsService.java
	* - 작성일		:
	* - 작성자		:
	* - 설명		:  ebiz 시리즈별 매출현황 리스트
	* </pre>
	* @param so
	* @return
	*/
	public List<StatsBySeriesVO> ebizSeriesSalesListGrid(StatsSO so);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: StatisticsService.java
	* - 작성일		:
	* - 작성자		:
	* - 설명		:  ebiz 대카테고리별 매출현황 리스트
	* </pre>
	* @param so
	* @return
	*/
	public List<StatsByLCtgVO> ebizLargeSalesListGrid(StatsSO so);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: StatisticsService.java
	* - 작성일		:
	* - 작성자		:
	* - 설명		:  ebiz 중카테고리별 매출현황 리스트
	* </pre>
	* @param so
	* @return
	*/
	public List<StatsByMCtgVO> ebizMiddleSalesListGrid(StatsSO so);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: StatisticsService.java
	* - 작성일		:
	* - 작성자		:
	* - 설명		:  ebiz 입점업체 / 판매대행 상품판매순위 리스트
	* </pre>
	* @param so
	* @return
	*/
	public List<StatsBySaleRankVO> ebizSalesRankListGrid(StatsSO so);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: StatisticsService.java
	* - 작성일		:
	* - 작성자		:
	* - 설명		: 기획팀 지역별 / 상픔주문 통계 리스트
	* </pre>
	* @param so
	* @return
	*/
	public List<StatsByAreaVO> planningTeamByAreaListGrid(StatsSO so);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: StatisticsService.java
	* - 작성일		:
	* - 작성자		:
	* - 설명		: 기획팀 상품별 판매 통계 & 판매 순위 리스트
	* </pre>
	* @param so
	* @return
	*/
	public List<StatsByGoodsVO> planningTeamByGoodsListGrid(StatsSO so);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: StatisticsService.java
	* - 작성일		:
	* - 작성자		:
	* - 설명		: 외부몰(샤방넷) 매출별 리스트
	* </pre>
	* @param so
	* @return
	*/
	public List<StatsOuterVO> outerMallSalesListGrid(StatsSO so);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: StatisticsService.java
	* - 작성일		:
	* - 작성자		:
	* - 설명		: 외부몰(샤방넷) 상품옵션별 리스트
	* </pre>
	* @param so
	* @return
	*/
	public List<StatsOuterVO> outerMallSalesOptListGrid(StatsSO so);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: StatisticsService.java
	* - 작성일		:
	* - 작성자		:
	* - 설명		: 외부몰(샤방넷) 판매매출순위 리스트
	* </pre>
	* @param so
	* @return
	*/
	public List<StatsOuterVO> outerMallSalesRankListGrid(StatsSO so);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: StatisticsService.java
	* - 작성일		:
	* - 작성자		:
	* - 설명		: 상품 상품옵션별 리스트
	* </pre>
	* @param so
	* @return
	*/
	public List<StatsGoodsVO> goodsSalesOptListGrid(StatsSO so);


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: StatisticsService.java
	* - 작성일		:
	* - 작성자		:
	* - 설명		: 상품 판매순위 리스트
	* </pre>
	* @param so
	* @return
	*/
	public List<StatsGoodsVO> goodsSalesRankListGrid(StatsSO so);

	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: StatisticsService.java
	 * - 작성일		:
	 * - 작성자		:
	 * - 설명		:
	 * </pre>
	 * @return
	 */
	public List<DayWmsStockTotalVO> listWmsCountryGrid(DayWmsStockTotalSO so);

	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: StatisticsService.java
	 * - 작성일		:
	 * - 작성자		:
	 * - 설명		:
	 * </pre>
	 * @return
	 */
	public List<DayWmsStockTotalVO> listWmsWareHouseGrid(DayWmsStockTotalSO so);

	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: StatisticsService.java
	 * - 작성일		:
	 * - 작성자		:
	 * - 설명		:
	 * </pre>
	 * @return
	 */
	public List<DayWmsStockTotalVO> listWmsCompanyGrid(DayWmsStockTotalSO so);


		/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: StatisticsService.java
	 * - 작성일		:
	 * - 작성자		:
	 * - 설명		:
	 * </pre>
	 * @return
	 */
	public List<MonthWmsPoTotalVO> listWmsPoGrid(MonthWmsPoTotalSO so);

	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: StatisticsService.java
	 * - 작성일		:
	 * - 작성자		:
	 * - 설명		:
	 * </pre>
	 * @return
	 */
	public List<WmsOutOrdTotalVO> listWmsOutOrdGrid(WmsOutOrdTotalSO so);


	// -------------------------------------------------------------------------------------------------------------------------------
	// tobemall
	// -------------------------------------------------------------------------------------------------------------------------------

	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: StatisticsController.java
	* - 작성일		: 2017.08.01
	* - 작성자		: hjko
	* - 설명		: 업체&브랜드별 실적
	* </pre>
	* @param model
	* @return
	*/
	public List<StatsByCompBrandVO> compBrandSalesListGrid(StatsSO so);

	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: StatisticsController.java
	* - 작성일		: 2017.08.01
	* - 작성자		: hjko
	* - 설명		: 가입탈퇴현황
	* </pre>
	* @param model
	* @return
	*/
	public List<MemberFlowReportVO> memberStatsListGrid(StatsSO so);
	
	
	/**
	  * 
	 * <pre>
	 * - 프로젝트명   : 11.business
	 * - 패키지명   : biz.app.statistics.service
	 * - 파일명      : StatisticsService.java
	 * - 작성일      : 2017. 8. 1.
	 * - 작성자      : valuefactory 권성중
	 * - 설명      : 상품별실적 그리드 
	 * </pre>
	  */  
	public List<OrderBestGoodsReportVO> goodsSalesList(OrderBestGoodsReportSO so);	 
	
}