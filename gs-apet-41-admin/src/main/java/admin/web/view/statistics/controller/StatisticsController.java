package admin.web.view.statistics.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import admin.web.config.grid.GridResponse;
import biz.app.brand.service.BrandService;
import biz.app.company.service.CompanyService;
import biz.app.statistics.model.MemberFlowReportVO;
import biz.app.statistics.model.OrderBestGoodsReportSO;
import biz.app.statistics.model.OrderBestGoodsReportVO;
import biz.app.statistics.model.OrderCategoryReportSO;
import biz.app.statistics.model.OrderCategoryReportVO;
import biz.app.statistics.model.OrderDailyReportSO;
import biz.app.statistics.model.OrderDailyReportVO;
import biz.app.statistics.model.StatsByCompBrandVO;
import biz.app.statistics.model.StatsSO;
import biz.app.statistics.service.StatisticsService;
import lombok.extern.slf4j.Slf4j;

/**
 * 네이밍 룰
 * 업무명View		:	화면
 * 업무명Grid		:	그리드
 * 업무명Tree		:	트리
 * 업무명Insert		:	입력
 * 업무명Update		:	수정
 * 업무명Delete		:	삭제
 * 업무명Save		:	입력 / 수정
 * 업무명ViewPop	:	화면팝업
 */

@Slf4j
@Controller
public class StatisticsController {

	@Autowired
	private StatisticsService statisticsService;

	@Autowired
	private CompanyService companyService;

	@Autowired
	private BrandService brandService;

	@Autowired
	private MessageSourceAccessor messageSourceAccessor;

	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: StatisticsController.java
	* - 작성일		: 2017. 8. 1.
	* - 작성자		: hongjun
	* - 설명		: 일 주문 현황
	* </pre>
	* @param model
	* @return
	*/
	@RequestMapping("/statistics/dailySalesListView.do")
	public String dailySalesListView(ModelMap map) {
//		String totalDt = DateUtil.addDay("yyyyMMdd", -1);
//		map.put("totalDt", totalDt);
		return "/statistics/dailySalesListView";
	}

	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: StatisticsController.java
	* - 작성일		: 2017. 8. 1.
	* - 작성자		: hongjun
	* - 설명		: 일 주문 현황 리스트
	* </pre>
	* @param model
	* @return
	*/
	@ResponseBody
	@RequestMapping(value = "/statistics/orderDailyReportListGrid.do", method = RequestMethod.POST)
	public GridResponse orderDailyReportListGrid(OrderDailyReportSO so) {
		so.setTotalDt(so.getTotalDt().replace("-", ""));
		List<OrderDailyReportVO> list = statisticsService.orderDailyReportListGrid(so);
		return new GridResponse(list, so);
	}

	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: StatisticsController.java
	* - 작성일		: 2017. 8. 1.
	* - 작성자		: hongjun
	* - 설명		: 카테고리 별 판매 실적
	* </pre>
	* @param model
	* @return
	*/
	@RequestMapping("/statistics/categorySalesListView.do")
	public String categorySalesListView(Model model) {
		return "/statistics/categorySalesListView";
	}

	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: StatisticsController.java
	* - 작성일		: 2017. 8. 2.
	* - 작성자		: hongjun
	* - 설명		: 카테고리 별 판매 실적 리스트
	* </pre>
	* @param model
	* @return
	*/
	@ResponseBody
	@RequestMapping(value = "/statistics/orderCategoryReportListGrid.do", method = RequestMethod.POST)
	public GridResponse orderDailyReportListGrid(OrderCategoryReportSO so) {
		so.setTotalDtStart(so.getTotalDtStart().replace("-", ""));
		so.setTotalDtEnd(so.getTotalDtEnd().replace("-", ""));
		List<OrderCategoryReportVO> list = statisticsService.orderCategoryReportListGrid(so);
		return new GridResponse(list, so);
	}
















































	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: StatisticsController.java
	* - 작성일		: 2017.08.01
	* - 작성자		: hjko
	* - 설명		: 업체&브랜드별 실적 보기
	* </pre>
	* @param model
	* @return
	*/
	@RequestMapping("/statistics/compBrandSalesView.do")
	public String compBrandSalesView(Model model) {
		return "/statistics/compBrandSalesView";
	}


	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: StatisticsController.java
	* - 작성일		: 2017.08.01
	* - 작성자		: hjko
	* - 설명		: 업체&브랜드별 실적 목록
	* </pre>
	* @param model
	* @return
	*/
	@ResponseBody
	@RequestMapping(value = "/statistics/compBrandSalesListGrid.do", method = RequestMethod.POST)
	public GridResponse compBrandSalesListGrid(StatsSO so) {
		so.setStartDtm(so.getStartDtm().replace("-", ""));
		so.setEndDtm(so.getEndDtm().replace("-", ""));
		List<StatsByCompBrandVO> list = statisticsService.compBrandSalesListGrid(so);
		return new GridResponse(list, so);
	}

	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: StatisticsController.java
	* - 작성일		: 2017.08.01
	* - 작성자		: hjko
	* - 설명		: 가입 탈퇴현황 보기
	* </pre>
	* @param model
	* @return
	*/
	@RequestMapping("/statistics/memberStatsView.do")
	public String memberStatsView(Model model) {
		return "/statistics/memberStatsView";
	}

	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: StatisticsController.java
	* - 작성일		: 2017.08.01
	* - 작성자		: hjko
	* - 설명		: 가입 탈퇴현황 목록
	* </pre>
	* @param model
	* @return
	*/
	@ResponseBody
	@RequestMapping(value = "/statistics/memberStatsListGrid.do", method = RequestMethod.POST)
	public GridResponse memberStatsListGrid(StatsSO so) {
		so.setStartDtm(so.getStartDtm().replace("-", ""));
		so.setEndDtm(so.getEndDtm().replace("-", ""));
		List<MemberFlowReportVO> list = statisticsService.memberStatsListGrid(so);
		return new GridResponse(list, so);
	}







	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: StatisticsController.java
	* - 작성일		:
	* - 작성자		:
	* - 설명		:  ebiz 기간별
	* </pre>
	* @param model
	* @return
	*/
	/*@RequestMapping("/statistics/ebizPeriodSalesListView.do")
	public String ebizPeriodSalesListView(Model model) {
		return "/statistics/ebizPeriodSalesListView";
	}
*/
	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: StatisticsController.java
	* - 작성일		:
	* - 작성자		:
	* - 설명		:  ebiz 기간별 리스트
	* </pre>
	* @param model
	* @return
	*/
	/*@ResponseBody
	@RequestMapping(value="/statistics/ebizPeriodSalesListGrid.do", method=RequestMethod.POST)
	public GridResponse ebizPeriodSalesListGrid(StatsSO so) {
		List<StatsByPeriodVO> list = statisticsService.ebizPeriodSalesListGrid(so);
		return new GridResponse(list, so);
	}*/

	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: StatisticsController.java
	* - 작성일		:
	* - 작성자		:
	* - 설명		:  ebiz 판매유형별
	* </pre>
	* @param model
	* @return
	*/
	/*@RequestMapping("/statistics/ebizClassSalesListView.do")
	public String ebizClassSalesListView(Model model) {
		return "/statistics/ebizClassSalesListView";
	}*/

	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: StatisticsController.java
	* - 작성일		:
	* - 작성자		:
	* - 설명		:  ebiz 판매유형별 리스트
	* </pre>
	* @param model
	* @return
	*/
	/*@ResponseBody
	@RequestMapping(value="/statistics/ebizClassSalesListGrid.do", method=RequestMethod.POST)
	public GridResponse ebizClassSalesListGrid(StatsSO so) {
		List<StatsByClassVO> list = statisticsService.ebizClassSalesListGrid(so);
		return new GridResponse(list, so);
	}*/

	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: StatisticsController.java
	* - 작성일		:
	* - 작성자		:
	* - 설명		:  ebiz 입점업체 / 판매대행 매출비교
	* </pre>
	* @param model
	* @return
	*/
	/*@RequestMapping("/statistics/ebizSalesListView.do")
	public String ebizSalesListView(Model model) {
		CompanySO companySo = new CompanySO();
		companySo.setSidx("comp_nm");
		companySo.setRows(9999999);
		List<CompanyBaseVO> companyList = companyService.pageCompanyWms(companySo);

		model.addAttribute("companyList", companyList);

		return "/statistics/ebizSalesListView";
	}*/

	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: StatisticsController.java
	* - 작성일		:
	* - 작성자		:
	* - 설명		:  ebiz 입점업체 / 판매대행 매출비교 리스트
	* </pre>
	* @param model
	* @return
	*/
	/*@ResponseBody
	@RequestMapping(value="/statistics/ebizSalesListGrid.do", method=RequestMethod.POST)
	public GridResponse ebizSalesListGrid(StatsSO so) {
		List<StatsByCompVO> list = statisticsService.ebizSalesListGrid(so);
		return new GridResponse(list, so);
	}*/

	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: StatisticsController.java
	* - 작성일		:
	* - 작성자		:
	* - 설명		:  ebiz 입점업체 / 판매대행 상품판매순위
	* </pre>
	* @param model
	* @return
	*/
	/*@RequestMapping("/statistics/ebizSalesRankListView.do")
	public String ebizSalesRankListView(Model model) {
		CompanySO companySo = new CompanySO();
		companySo.setSidx("comp_nm");
		companySo.setRows(9999999);
		List<CompanyBaseVO> companyList = companyService.pageCompanyWms(companySo);

		model.addAttribute("companyList", companyList);

		return "/statistics/ebizSalesRankListView";
	}*/

	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: StatisticsController.java
	* - 작성일		:
	* - 작성자		:
	* - 설명		:  ebiz 입점업체 / 판매대행 상품판매순위 리스트
	* </pre>
	* @param model
	* @return
	*/
	/*@ResponseBody
	@RequestMapping(value="/statistics/ebizSalesRankListGrid.do", method=RequestMethod.POST)
	public GridResponse ebizSalesRankListGrid(StatsSO so) {
		List<StatsBySaleRankVO> list = statisticsService.ebizSalesRankListGrid(so);
		return new GridResponse(list, so);
	}*/

	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: StatisticsController.java
	* - 작성일		:
	* - 작성자		:
	* - 설명		:  ebiz 시리즈별 매출현황
	* </pre>
	* @param model
	* @return
	*/
	/*@RequestMapping("/statistics/ebizSeriesSalesListView.do")
	public String ebizSeriesSalesListView(Model model) {
		BrandBaseSO brandBaseSO = new BrandBaseSO();
		brandBaseSO.setBndGbCd("10");
		brandBaseSO.setRows(9999999);
		List<BrandBaseVO> list = brandService.pageBrandBase(brandBaseSO);

		model.addAttribute("seriesList", list);

		return "/statistics/ebizSeriesSalesListView";
	}*/

	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: StatisticsController.java
	* - 작성일		:
	* - 작성자		:
	* - 설명		:  ebiz 시리즈별 매출현황 리스트
	* </pre>
	* @param model
	* @return
	*/
	/*@ResponseBody
	@RequestMapping(value="/statistics/ebizSeriesSalesListGrid.do", method=RequestMethod.POST)
	public GridResponse ebizSeriesSalesListGrid(StatsSO so) {
		List<StatsBySeriesVO> list = statisticsService.ebizSeriesSalesListGrid(so);
		return new GridResponse(list, so);
	}*/

	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: StatisticsController.java
	* - 작성일		:
	* - 작성자		:
	* - 설명		:  ebiz 대카테고리별 매출현황
	* </pre>
	* @param model
	* @return
	*/
	/*@RequestMapping("/statistics/ebizLargeSalesListView.do")
	public String ebizLargeSalesListView(Model model) {
		return "/statistics/ebizLargeSalesListView";
	}*/

	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: StatisticsController.java
	* - 작성일		:
	* - 작성자		:
	* - 설명		:  ebiz 대카테고리별 매출현황 리스트
	* </pre>
	* @param model
	* @return
	*/
	/*@ResponseBody
	@RequestMapping(value="/statistics/ebizLargeSalesListGrid.do", method=RequestMethod.POST)
	public GridResponse ebizLargeSalesListGrid(StatsSO so) {
		List<StatsByLCtgVO> list = statisticsService.ebizLargeSalesListGrid(so);
		return new GridResponse(list, so);
	}*/

	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: StatisticsController.java
	* - 작성일		:
	* - 작성자		:
	* - 설명		:  ebiz 중카테고리별 매출현황
	* </pre>
	* @param model
	* @return
	*/
	/*@RequestMapping("/statistics/ebizMiddleSalesListView.do")
	public String ebizMiddleSalesListView(Model model) {
		return "/statistics/ebizMiddleSalesListView";
	}*/

	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: StatisticsController.java
	* - 작성일		:
	* - 작성자		:
	* - 설명		:  ebiz 중카테고리별 매출현황 리스트
	* </pre>
	* @param model
	* @return
	*/
	/*@ResponseBody
	@RequestMapping(value="/statistics/ebizMiddleSalesListGrid.do", method=RequestMethod.POST)
	public GridResponse ebizMiddleSalesListGrid(StatsSO so) {
		List<StatsByMCtgVO> list = statisticsService.ebizMiddleSalesListGrid(so);
		return new GridResponse(list, so);
	}*/

	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: StatisticsController.java
	* - 작성일		:
	* - 작성자		:
	* - 설명		: 기획팀 지역별 / 상픔주문 통계
	* </pre>
	* @param model
	* @return
	*/
	/*@RequestMapping("/statistics/planningTeamByAreaListView.do")
	public String planningTeamByAreaListView(Model model) {
		return "/statistics/planningTeamByAreaListView";
	}*/

	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: StatisticsController.java
	* - 작성일		:
	* - 작성자		:
	* - 설명		: 기획팀 지역별 / 상픔주문 통계 리스트
	* </pre>
	* @param model
	* @return
	*/
	/*@ResponseBody
	@RequestMapping(value="/statistics/planningTeamByAreaListGrid.do", method=RequestMethod.POST)
	public GridResponse planningTeamByAreaListGrid(StatsSO so) {
		List<StatsByAreaVO> list = statisticsService.planningTeamByAreaListGrid(so);
		return new GridResponse(list, so);
	}*/

	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: StatisticsController.java
	* - 작성일		:
	* - 작성자		:
	* - 설명		: 기획팀 상품별 판매 통계 & 판매 순위
	* </pre>
	* @param model
	* @return
	*/
	/*@RequestMapping("/statistics/planningTeamByGoodsListView.do")
	public String planningTeamByGoodsListView(Model model) {
		return "/statistics/planningTeamByGoodsListView";
	}*/

	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: StatisticsController.java
	* - 작성일		:
	* - 작성자		:
	* - 설명		: 기획팀 기획팀 상품별 판매 통계 & 판매 순위 리스트
	* </pre>
	* @param model
	* @return
	*/
	/*@ResponseBody
	@RequestMapping(value="/statistics/planningTeamByGoodsListGrid.do", method=RequestMethod.POST)
	public GridResponse planningTeamByGoodsListGrid(StatsSO so) {
		List<StatsByGoodsVO> list = statisticsService.planningTeamByGoodsListGrid(so);
//		for(StatsByGoodsVO temp : list) {
//			LogUtil.log(temp );
//		}
		return new GridResponse(list, so);
	}*/

	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: StatisticsController.java
	* - 작성일		:
	* - 작성자		:
	* - 설명		: 외부몰(샤방넷) 매출별
	* </pre>
	* @param model
	* @return
	*/
	/*@RequestMapping("/statistics/outerMallSalesListView.do")
	public String outerMallSalesListView(Model model) {
		return "/statistics/outerMallSalesListView";
	}*/

	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: StatisticsController.java
	* - 작성일		:
	* - 작성자		:
	* - 설명		: 외부몰(샤방넷) 매출별 리스트
	* </pre>
	* @param model
	* @return
	*/
	/*@ResponseBody
	@RequestMapping(value="/statistics/outerMallSalesListGrid.do", method=RequestMethod.POST)
	public GridResponse outerMallSalesListGrid(StatsSO so) {
		List<StatsOuterVO> list = statisticsService.outerMallSalesListGrid(so);
		return new GridResponse(list, so);
	}*/

	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: StatisticsController.java
	* - 작성일		:
	* - 작성자		:
	* - 설명		: 외부몰(샤방넷) 상품옵션별
	* </pre>
	* @param model
	* @return
	*/
	/*@RequestMapping("/statistics/outerMallSalesOptListView.do")
	public String outerMallSalesOptListView(Model model) {
		return "/statistics/outerMallSalesOptListView";
	}*/

	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: StatisticsController.java
	* - 작성일		:
	* - 작성자		:
	* - 설명		: 외부몰(샤방넷) 상품옵션별 리스트
	* </pre>
	* @param model
	* @return
	*/
	/*@ResponseBody
	@RequestMapping(value="/statistics/outerMallSalesOptListGrid.do", method=RequestMethod.POST)
	public GridResponse outerMallSalesOptListGrid(StatsSO so) {
		List<StatsOuterVO> list = statisticsService.outerMallSalesOptListGrid(so);
		return new GridResponse(list, so);
	}*/

	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: StatisticsController.java
	* - 작성일		:
	* - 작성자		:
	* - 설명		: 외부몰(샤방넷) 판매매출순위
	* </pre>
	* @param model
	* @return
	*/
	/*@RequestMapping("/statistics/outerMallSalesRankListView.do")
	public String outerMallSalesRankListView(Model model) {
		CompanySO companySo = new CompanySO();
		companySo.setRows(9999999);
		List<CompanyBaseVO> companyList = companyService.pageCompany(companySo);

		model.addAttribute("companyList", companyList);

		return "/statistics/outerMallSalesRankListView";
	}
*/
	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: StatisticsController.java
	* - 작성일		:
	* - 작성자		:
	* - 설명		: 외부몰(샤방넷) 판매매출순위 리스트
	* </pre>
	* @param model
	* @return
	*/
	/*@ResponseBody
	@RequestMapping(value="/statistics/outerMallSalesRankListGrid.do", method=RequestMethod.POST)
	public GridResponse outerMallSalesRankListGrid(StatsSO so) {
		List<StatsOuterVO> list = statisticsService.outerMallSalesRankListGrid(so);
		return new GridResponse(list, so);
	}*/

	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: StatisticsController.java
	* - 작성일		:
	* - 작성자		:
	* - 설명		: 상품 상품옵션별
	* </pre>
	* @param model
	* @return
	*/
	/*@RequestMapping("/statistics/goodsSalesOptListView.do")
	public String goodsSalesOptListView(Model model) {
		return "/statistics/goodsSalesOptListView";
	}*/

	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: StatisticsController.java
	* - 작성일		:
	* - 작성자		:
	* - 설명		: 상품 상품옵션별 리스트
	* </pre>
	* @param model
	* @return
	*/
	/*@ResponseBody
	@RequestMapping(value="/statistics/goodsSalesOptListGrid.do", method=RequestMethod.POST)
	public GridResponse goodsSalesOptListGrid(StatsSO so) {
		List<StatsGoodsVO> list = statisticsService.goodsSalesOptListGrid(so);
		return new GridResponse(list, so);
	}*/

	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: StatisticsController.java
	* - 작성일		:
	* - 작성자		:
	* - 설명		: 상품 판매순위
	* </pre>
	* @param model
	* @return
	*/
	/*@RequestMapping("/statistics/goodsSalesRankListView.do")
	public String goodsSalesRankListView(Model model) {
		return "/statistics/goodsSalesRankListView";
	}*/

	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: StatisticsController.java
	* - 작성일		:
	* - 작성자		:
	* - 설명		: 상품 판매순위 리스트
	* </pre>
	* @param model
	* @return
	*/
	/*@ResponseBody
	@RequestMapping(value="/statistics/goodsSalesRankListGrid.do", method=RequestMethod.POST)
	public GridResponse goodsSalesRankListGrid(StatsSO so) {
		List<StatsGoodsVO> list = statisticsService.goodsSalesRankListGrid(so);
		return new GridResponse(list, so);
	}*/

	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: StatisticsController.java
	 * - 작성일		:
	 * - 작성자		:
	 * - 설명		:
	 * </pre>
	 * @param model
	 * @return
	 */
	/*@RequestMapping("/statistics/wmsCountryListView.do")
	public String wmsCountryListView(Model model) {
		return "/statistics/wmsCountryListView";
	}*/

	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: StatisticsController.java
	 * - 작성일		:
	 * - 작성자		:
	 * - 설명		:
	 * </pre>
	 * @param so
	 * @return
	 */
	/*@ResponseBody
	@RequestMapping(value="/statistics/wmsCountryListGrid.do", method=RequestMethod.POST)
	public GridResponse wmsCountryListGrid(DayWmsStockTotalSO so) {
		List<DayWmsStockTotalVO> list = statisticsService.listWmsCountryGrid(so);
		return new GridResponse(list, so);
	}*/

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: StatisticsController.java
	 * - 작성일		:
	 * - 작성자		:
	 * - 설명		: 엑셀 다운로드
	 * </pre>
	 * @param model
	 * @param so
	 * @return
	 */
	/*@RequestMapping("/statistics/wmsCountryListExcelDownload.do")
	public String wmsCountryListExcelDownload(ModelMap model, DayWmsStockTotalSO so) {
		so.setRows(999999999);
		List<DayWmsStockTotalVO> list = statisticsService.listWmsCountryGrid(so);

		String[] headerName = {
				 messageSourceAccessor.getMessage("column.stockAmount")
				, messageSourceAccessor.getMessage("column.componentRate")
		};

		String[] fieldName = {
				 "stkAmt"
				, "rate"
		};

		String day = so.getBaseDt();
		String excelTitle = "DayWMSCountry" + day;

		model.addAttribute(CommonConstants.EXCEL_PARAM_NAME, new ExcelViewParam(excelTitle, headerName, fieldName, list));
		model.addAttribute(CommonConstants.EXCEL_PARAM_FILE_NAME, excelTitle);

		return View.excelDownload();
	}*/

	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: StatisticsController.java
	 * - 작성일		:
	 * - 작성자		:
	 * - 설명		:
	 * </pre>
	 * @param model
	 * @return
	 */
	/*@RequestMapping("/statistics/wmsWareHouseListView.do")
	public String wmsWareHouseListView(Model model) {
		return "/statistics/wmsWareHouseListView";
	}*/

	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: StatisticsController.java
	 * - 작성일		:
	 * - 작성자		:
	 * - 설명		:
	 * </pre>
	 * @param so
	 * @return
	 */
	/*@ResponseBody
	@RequestMapping(value="/statistics/wmsWareHouseListGrid.do", method=RequestMethod.POST)
	public GridResponse wmsWareHouseListGrid(DayWmsStockTotalSO so) {
		List<DayWmsStockTotalVO> list = statisticsService.listWmsWareHouseGrid(so);
		return new GridResponse(list, so);
	}*/

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: StatisticsController.java
	 * - 작성일		: .
	 * - 작성자		:
	 * - 설명		: 엑셀 다운로드
	 * </pre>
	 * @param model
	 * @param so
	 * @return
	 */
	/*@RequestMapping("/statistics/wmsWareHouseListExcelDownload.do")
	public String wmsWareHouseListExcelDownload(ModelMap model, DayWmsStockTotalSO so) {
		so.setRows(999999999);
		List<DayWmsStockTotalVO> list = statisticsService.listWmsWareHouseGrid(so);

		String[] headerName = {
				  messageSourceAccessor.getMessage("column.whs_nm")
				, messageSourceAccessor.getMessage("column.stockAmount")
				, messageSourceAccessor.getMessage("column.componentRate")
		};

		String[] fieldName = {
				 "whsNm"
				, "stkAmt"
				, "rate"
		};

		String day = so.getBaseDt();
		String excelTitle = "DayWMSWareHouse" + day;

		model.addAttribute(CommonConstants.EXCEL_PARAM_NAME, new ExcelViewParam(excelTitle, headerName, fieldName, list));
		model.addAttribute(CommonConstants.EXCEL_PARAM_FILE_NAME, excelTitle);

		return View.excelDownload();
	}*/
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: StatisticsController.java
	 * - 작성일		:
	 * - 작성자		:
	 * - 설명		:
	 * </pre>
	 * @param model
	 * @return
	 */
	/*@RequestMapping("/statistics/wmsCompGbListView.do")
	public String wmsCompGbListView(Model model) {
		return "/statistics/wmsCompGbListView";
	}*/

	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: StatisticsController.java
	 * - 작성일		:
	 * - 작성자		:
	 * - 설명		:
	 * </pre>
	 * @param so
	 * @return
	 */
	/*@ResponseBody
	@RequestMapping(value="/statistics/wmsCompGbListGrid.do", method=RequestMethod.POST)
	public GridResponse wmsCompGbListGrid(DayWmsStockTotalSO so) {
		List<DayWmsStockTotalVO> list = null;
//		List<DayWmsStockTotalVO> list = statisticsService.listWmsCompGbGrid(so);
		return new GridResponse(list, so);
	}*/

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: StatisticsController.java
	 * - 작성일		: .
	 * - 작성자		:
	 * - 설명		: 엑셀 다운로드
	 * </pre>
	 * @param model
	 * @param so
	 * @return
	 */
	/*@RequestMapping("/statistics/wmsCompGbListExcelDownload.do")
	public String wmsCompGbListExcelDownload(ModelMap model, DayWmsStockTotalSO so) {
		so.setRows(999999999);
		List<DayWmsStockTotalVO> list = null;
//		List<DayWmsStockTotalVO> list = statisticsService.listWmsCompGbGrid(so);

		String[] headerName = {
				  messageSourceAccessor.getMessage("column.ordMda")
				, messageSourceAccessor.getMessage("column.stockAmount")
				, messageSourceAccessor.getMessage("column.componentRate")
				, messageSourceAccessor.getMessage("column.ctr_org")
				, messageSourceAccessor.getMessage("column.stockAmount")
				, messageSourceAccessor.getMessage("column.componentRate")
		};

		String[] fieldName = {
				 "bomCompGbNm"
				, "stkAmt"
				, "rate"
				, "bomCtrOrgNm"
				, "subStkAmt"
				, "subRate"
		};

		String day = so.getBaseDt();
		String excelTitle = "DayWMSCompGb" + day;

		model.addAttribute(CommonConstants.EXCEL_PARAM_NAME, new ExcelViewParam(excelTitle, headerName, fieldName, list));
		model.addAttribute(CommonConstants.EXCEL_PARAM_FILE_NAME, excelTitle);

		return View.excelDownload();
	}*/

	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: StatisticsController.java
	 * - 작성일		:
	 * - 작성자		:
	 * - 설명		:
	 * </pre>
	 * @param model
	 * @return
	 */
	/*@RequestMapping("/statistics/wmsCompanyListView.do")
	public String wmsCompanyListView(Model model) {
		return "/statistics/wmsCompanyListView";
	}*/

	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: StatisticsController.java
	 * - 작성일		:
	 * - 작성자		:
	 * - 설명		:
	 * </pre>
	 * @param so
	 * @return
	 */
	/*@ResponseBody
	@RequestMapping(value="/statistics/wmsCompanyListGrid.do", method=RequestMethod.POST)
	public GridResponse wmsCompanyListGrid(DayWmsStockTotalSO so) {
		List<DayWmsStockTotalVO> list = statisticsService.listWmsCompanyGrid(so);
		return new GridResponse(list, so);
	}*/

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: StatisticsController.java
	 * - 작성일		: .
	 * - 작성자		:
	 * - 설명		: 엑셀 다운로드
	 * </pre>
	 * @param model
	 * @param so
	 * @return
	 */
	/*@RequestMapping("/statistics/wmsCompanyListExcelDownload.do")
	public String wmsCompanyListExcelDownload(ModelMap model, DayWmsStockTotalSO so) {
		so.setRows(999999999);
		List<DayWmsStockTotalVO> list = statisticsService.listWmsCompanyGrid(so);

		String[] headerName = {
				  messageSourceAccessor.getMessage("column.comp_nm")
				, messageSourceAccessor.getMessage("column.stockAmount")
				, messageSourceAccessor.getMessage("column.componentRate")
		};

		String[] fieldName = {
				 "compNm"
				, "stkAmt"
				, "rate"
		};

		String day = so.getBaseDt();
		String excelTitle = "DayWMSCompany" + day;

		model.addAttribute(CommonConstants.EXCEL_PARAM_NAME, new ExcelViewParam(excelTitle, headerName, fieldName, list));
		model.addAttribute(CommonConstants.EXCEL_PARAM_FILE_NAME, excelTitle);

		return View.excelDownload();
	}*/

	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: StatisticsController.java
	 * - 작성일		:
	 * - 작성자		:
	 * - 설명		:
	 * </pre>
	 * @param model
	 * @return
	 */
	/*@RequestMapping("/statistics/wmsMonthPoListView.do")
	public String wmsMonthPoListView(Model model) {
		return "/statistics/wmsMonthPoListView";
	}*/

	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: StatisticsController.java
	 * - 작성일		:
	 * - 작성자		:
	 * - 설명		:
	 * </pre>
	 * @param so
	 * @return
	 */
	/*@ResponseBody
	@RequestMapping(value = "/statistics/wmsMonthPoListGrid.do", method = RequestMethod.POST)
	public GridResponse wmsMonthPoListGrid(MonthWmsPoTotalSO so) {
		List<MonthWmsPoTotalVO> list = statisticsService.listWmsPoGrid(so);
		return new GridResponse(list, so);
	}*/

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: StatisticsController.java
	 * - 작성일		: .
	 * - 작성자		:
	 * - 설명		: 엑셀 다운로드
	 * </pre>
	 * @param model
	 * @param so
	 * @return
	 */
	/*@RequestMapping("/statistics/wmsMonthPoListExcelDownload.do")
	public String wmsMonthPoListExcelDownload(ModelMap model, MonthWmsPoTotalSO so) {
		so.setRows(999999999);
		List<MonthWmsPoTotalVO> list = statisticsService.listWmsPoGrid(so);

		String[] headerName = {
				StringUtils.equals(so.getSumGbCd(), CommonConstants.SUM_GB_10)
						? messageSourceAccessor.getMessage("column.goods.comp_nm")
						: messageSourceAccessor.getMessage("column.series"),
				messageSourceAccessor.getMessage("column.poAmt01"), messageSourceAccessor.getMessage("column.poAmt02"),
				messageSourceAccessor.getMessage("column.poAmt03"), messageSourceAccessor.getMessage("column.poAmt99"),
				messageSourceAccessor.getMessage("column.compSumAmt"),
				messageSourceAccessor.getMessage("column.totRate"),
				messageSourceAccessor.getMessage("column.incRatio") };

		String[] fieldName = { "sumTgNm", "firstPoAmt", "secondPoAmt", "thirdPoAmt", "addPoAmt", "sumAmt", "rate",
				"incRatio" };

		String day = so.getBaseYm();
		String excelTitle = "DayWMSMonthPo" + day;

		model.addAttribute(CommonConstants.EXCEL_PARAM_NAME,
				new ExcelViewParam(excelTitle, headerName, fieldName, list));
		model.addAttribute(CommonConstants.EXCEL_PARAM_FILE_NAME, excelTitle);

		return View.excelDownload();
	}*/

	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: StatisticsController.java
	 * - 작성일		:
	 * - 작성자		:
	 * - 설명		:
	 * </pre>
	 * @param model
	 * @return
	 */
	/*@RequestMapping("/statistics/wmsOutOrdListView.do")
	public String wmsOutOrdListView(Model model) {
		return "/statistics/wmsOutOrdListView";
	}*/

	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: StatisticsController.java
	 * - 작성일		:
	 * - 작성자		:
	 * - 설명		:
	 * </pre>
	 * @param so
	 * @return
	 */
	/*@ResponseBody
	@RequestMapping(value = "/statistics/wmsOutOrdListGrid.do", method = RequestMethod.POST)
	public GridResponse wmsOutOrdListGrid(WmsOutOrdTotalSO so) {
		List<WmsOutOrdTotalVO> list = statisticsService.listWmsOutOrdGrid(so);
		return new GridResponse(list, so);
	}*/




	/**
	 *
	* <pre>
	* - 프로젝트명   : 41.admin.web
	* - 패키지명   : admin.web.view.statistics.controller
	* - 파일명      : StatisticsController.java
	* - 작성일      : 2017. 8. 1.
	* - 작성자      : valuefactory 권성중
	* - 설명      :상품별실적
	* </pre>
	 */
	@RequestMapping("/statistics/goodsSales.do")
	public String goodsSalesListView(Model model) {
		return "/statistics/goodsSalesListView";
	}


	/**
	*
	* <pre>
	* - 프로젝트명   : 41.admin.web
	* - 패키지명   : admin.web.view.statistics.controller
	* - 파일명      : StatisticsController.java
	* - 작성일      : 2017. 8. 1.
	* - 작성자      : valuefactory 권성중
	* - 설명      :상품별실적 그리드
	* </pre>
	 */
	@ResponseBody
	@RequestMapping(value = "/statistics/goodsSalesListGrid.do", method = RequestMethod.POST)
	public GridResponse goodsSalesListGrid(OrderBestGoodsReportSO so) {
		List<OrderBestGoodsReportVO> list = statisticsService.goodsSalesList(so);
		return new GridResponse(list, so);
	}
}