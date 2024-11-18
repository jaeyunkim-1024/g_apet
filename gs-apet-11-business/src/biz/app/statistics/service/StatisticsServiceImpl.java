package biz.app.statistics.service;

import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import biz.app.statistics.dao.StatisticsDao;
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
import framework.common.constants.CommonConstants;

@Service
@Transactional
public class StatisticsServiceImpl implements StatisticsService {

	@Autowired
	private StatisticsDao statisticsDao;
	
	@Override
	@Transactional(readOnly=true)
	public List<OrderDailyReportVO> orderDailyReportListGrid(OrderDailyReportSO so) {
		return statisticsDao.orderDailyReportListGrid(so);
	}
	
	@Override
	@Transactional(readOnly=true)
	public List<OrderCategoryReportVO> orderCategoryReportListGrid(OrderCategoryReportSO so) {
		return statisticsDao.orderCategoryReportListGrid(so);
	}

	/*  ebiz 기간별 리스트
	 * @see biz.app.statistics.service.StatisticsService#listOuterMallSalesListGrid(biz.app.statistics.model.CorpSO)
	 */
	@Override
	@Transactional(readOnly=true)
	public List<StatsByPeriodVO> ebizPeriodSalesListGrid(StatsSO so) {
		return statisticsDao.ebizPeriodSalesListGrid(so);
	}

	/*  ebiz 판매유형별 리스트
	 * @see biz.app.statistics.service.StatisticsService#listOuterMallSalesListGrid(biz.app.statistics.model.CorpSO)
	 */
	@Override
	@Transactional(readOnly=true)
	public List<StatsByClassVO> ebizClassSalesListGrid(StatsSO so) {
		return statisticsDao.ebizClassSalesListGrid(so);
	}

	/*  ebiz 입점업체 / 판매대행 매출비교 리스트
	 * @see biz.app.statistics.service.StatisticsService#listOuterMallSalesListGrid(biz.app.statistics.model.CorpSO)
	 */
	@Override
	@Transactional(readOnly=true)
	public List<StatsByCompVO> ebizSalesListGrid(StatsSO so) {
		return statisticsDao.ebizSalesListGrid(so);
	}

	/*  ebiz 입점업체 / 판매대행 상품판매순위 리스트
	 * @see biz.app.statistics.service.StatisticsService#listOuterMallSalesListGrid(biz.app.statistics.model.CorpSO)
	 */
	@Override
	@Transactional(readOnly=true)
	public List<StatsBySaleRankVO> ebizSalesRankListGrid(StatsSO so) {
		return statisticsDao.ebizSalesRankListGrid(so);
	}


	/*  ebiz 시리즈별 매출현황 리스트
	 * @see biz.app.statistics.service.StatisticsService#listOuterMallSalesListGrid(biz.app.statistics.model.CorpSO)
	 */
	@Override
	@Transactional(readOnly=true)
	public List<StatsBySeriesVO> ebizSeriesSalesListGrid(StatsSO so) {
		return statisticsDao.ebizSeriesSalesListGrid(so);
	}

	/*  ebiz 대카테고리별 매출현황 리스트
	 * @see biz.app.statistics.service.StatisticsService#listOuterMallSalesListGrid(biz.app.statistics.model.CorpSO)
	 */
	@Override
	@Transactional(readOnly=true)
	public List<StatsByLCtgVO> ebizLargeSalesListGrid(StatsSO so) {
		return statisticsDao.ebizLargeSalesListGrid(so);
	}

	/*  ebiz 중카테고리별 매출현황 리스트
	 * @see biz.app.statistics.service.StatisticsService#listOuterMallSalesListGrid(biz.app.statistics.model.CorpSO)
	 */
	@Override
	@Transactional(readOnly=true)
	public List<StatsByMCtgVO> ebizMiddleSalesListGrid(StatsSO so) {
		return statisticsDao.ebizMiddleSalesListGrid(so);
	}

	/* 기획팀 지역별 / 상픔주문 통계 리스트
	 * @see biz.app.statistics.service.StatisticsService#listOuterMallSalesListGrid(biz.app.statistics.model.CorpSO)
	 */
	@Override
	@Transactional(readOnly=true)
	public List<StatsByAreaVO> planningTeamByAreaListGrid(StatsSO so) {
		return statisticsDao.planningTeamByAreaListGrid(so);
	}

	/* 기획팀 상품별 판매 통계 & 판매 순위 리스트
	 * @see biz.app.statistics.service.StatisticsService#listOuterMallSalesListGrid(biz.app.statistics.model.CorpSO)
	 */
	@Override
	@Transactional(readOnly=true)
	public List<StatsByGoodsVO> planningTeamByGoodsListGrid(StatsSO so) {
		return statisticsDao.planningTeamByGoodsListGrid(so);
	}

	/* 외부몰(샤방넷) 매출별 리스트
	 * @see biz.app.statistics.service.StatisticsService#listOuterMallSalesListGrid(biz.app.statistics.model.CorpSO)
	 */
	@Override
	@Transactional(readOnly=true)
	public List<StatsOuterVO> outerMallSalesListGrid(StatsSO so) {
		return statisticsDao.outerMallSalesListGrid(so);
	}

	/* 외부몰(샤방넷) 상품옵션별 리스트
	 * @see biz.app.statistics.service.StatisticsService#listOuterMallSalesListGrid(biz.app.statistics.model.CorpSO)
	 */
	@Override
	@Transactional(readOnly=true)
	public List<StatsOuterVO> outerMallSalesOptListGrid(StatsSO so) {
		return statisticsDao.outerMallSalesOptListGrid(so);
	}

	/* 외부몰(샤방넷) 판매매출순위 리스트
	 * @see biz.app.statistics.service.StatisticsService#listOuterMallSalesListGrid(biz.app.statistics.model.CorpSO)
	 */
	@Override
	@Transactional(readOnly=true)
	public List<StatsOuterVO> outerMallSalesRankListGrid(StatsSO so) {
		return statisticsDao.outerMallSalesRankListGrid(so);
	}

	/* 상품 상품옵션별 리스트
	 * @see biz.app.statistics.service.StatisticsService#listOuterMallSalesListGrid(biz.app.statistics.model.CorpSO)
	 */
	@Override
	@Transactional(readOnly=true)
	public List<StatsGoodsVO> goodsSalesOptListGrid(StatsSO so) {
		return statisticsDao.goodsSalesOptListGrid(so);
	}

	/* 상품 판매순위 리스트
	 * @see biz.app.statistics.service.StatisticsService#listOuterMallSalesListGrid(biz.app.statistics.model.CorpSO)
	 */
	@Override
	@Transactional(readOnly=true)
	public List<StatsGoodsVO> goodsSalesRankListGrid(StatsSO so) {
		return statisticsDao.goodsSalesRankListGrid(so);
	}

	/* WMS원산지별재고통계 리스트
	 * @see biz.app.statistics.service.StatisticsService#listWmsCountryGrid(biz.app.statistics.model.MemberSO)
	 */
	@Override
	@Transactional(readOnly=true)
	public List<DayWmsStockTotalVO> listWmsCountryGrid(DayWmsStockTotalSO so) {
		return statisticsDao.listWmsCountryGrid(so);
	}

	/* WMS창고별재고통계 리스트
	 * @see biz.app.statistics.service.StatisticsService#listWmsWareHouseGrid(biz.app.statistics.model.MemberSO)
	 */
	@Override
	@Transactional(readOnly=true)
	public List<DayWmsStockTotalVO> listWmsWareHouseGrid(DayWmsStockTotalSO so) {
		return statisticsDao.listWmsWareHouseGrid(so);
	}



	/* WMS업체별재고통계 리스트
	 * @see biz.app.statistics.service.StatisticsService#listWmsCompanyGrid(biz.app.statistics.model.MemberSO)
	 */
	@Override
	@Transactional(readOnly=true)
	public List<DayWmsStockTotalVO> listWmsCompanyGrid(DayWmsStockTotalSO so) {
		return statisticsDao.listWmsCompanyGrid(so);
	}

	/* WMS 발주현황 월별집계 리스트
	 * @see biz.app.statistics.service.StatisticsService#listWmsCompanyGrid(biz.app.statistics.model.MemberSO)
	 */
	@Override
	@Transactional(readOnly = true)
	public List<MonthWmsPoTotalVO> listWmsPoGrid(MonthWmsPoTotalSO so) {

		if (StringUtils.equals(CommonConstants.SUM_GB_10, so.getSumGbCd())) {
			// 업체별
			return statisticsDao.listWmsPoCompGrid(so);
		} else {
			// 시리즈별
			return statisticsDao.listWmsPoSeriesGrid(so);
		}
	}

	/* WMS 출고 통계 리스트
	 * @see biz.app.statistics.service.StatisticsService#listWmsCompanyGrid(biz.app.statistics.model.MemberSO)
	 */
	@Override
	@Transactional(readOnly=true)
	public List<WmsOutOrdTotalVO> listWmsOutOrdGrid(WmsOutOrdTotalSO so) {
		return statisticsDao.listWmsOutOrdGrid(so);
	}
	//-------------------------------------------------------------------------------------------------------------------------------------------
	// tobemall
	//-------------------------------------------------------------------------------------------------------------------------------------------
	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: StatisticsController.java
	* - 작성일		: 2017.08.01
	* - 작성자		: hjko
	* - 설명		: 업체&브랜드별 실적
	* </pre>
	* @param StatsSO
	* @return List<StatsByCompBrandVO>
	*/
	@Override
	@Transactional(readOnly=true)
	public List<StatsByCompBrandVO> compBrandSalesListGrid(StatsSO so){
		return statisticsDao.compBrandSalesListGrid(so);
	}

	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: StatisticsController.java
	* - 작성일		: 2017.08.01
	* - 작성자		: hjko
	* - 설명		: 가입탈퇴현황
	* </pre>
	* @param StatsSO
	* @return  List<MemberFlowReportVO>
	*/
	@Override
	@Transactional(readOnly=true)
	public List<MemberFlowReportVO> memberStatsListGrid(StatsSO so){
		return statisticsDao.memberStatsListGrid(so);
	}
	
	/**
	  * 
	 * <pre>
	 * - 프로젝트명   : 11.business
	 * - 패키지명   : biz.app.statistics.service
	 * - 파일명      : StatisticsServiceImpl.java
	 * - 작성일      : 2017. 8. 1.
	 * - 작성자      : valuefactory 권성중
	 * - 설명      :상품별실적 그리드 
	 * </pre>
	  */ 
	@Override
	@Transactional(readOnly=true) 
	public List<OrderBestGoodsReportVO> goodsSalesList(OrderBestGoodsReportSO so) {
		return statisticsDao.goodsSalesList(so);  
	}
}