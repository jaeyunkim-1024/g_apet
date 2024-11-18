package front.web.view.pettv;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import biz.app.brand.model.BrandBaseSO;
import biz.app.brand.model.BrandBaseVO;
import biz.app.contents.model.SeriesSO;
import biz.app.contents.model.SeriesVO;
import biz.app.contents.model.VodSO;
import biz.app.contents.model.VodVO;
import biz.app.contents.service.SeriesService;
import biz.app.contents.service.VodService;
import biz.app.goods.model.GoodsFiltGrpSO;
import biz.app.goods.model.GoodsFiltGrpVO;
import framework.common.constants.CommonConstants;
import framework.front.constants.FrontConstants;
import framework.front.model.Session;
import front.web.config.tiles.TilesView;
import front.web.config.view.ViewBase;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("tv/series")
public class PetTvSeriesController {
	
	@Autowired private SeriesService seriesService;
	@Autowired private VodService vodService;
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명    : gs-apet-31-front
	 * - 파일명        : TvDetailController.java
	 * - 작성일        : 2021. 2. 1.
	 * - 작성자        : YKU
	 * - 설명          : 시리즈 상세 페이지
	 * </pre>
	 * @param map
	 * @param session
	 * @param view
	 * @return
	 */
	@RequestMapping(value="petTvSeriesList" , method = RequestMethod.GET)
	public String petTvSeriesList(ModelMap map, Session session, ViewBase view, SeriesSO so){

		SeriesVO foGetSeries = seriesService.foGetSeries(so);
		List<SeriesVO> foGetSeason = seriesService.foGetSeason(so);
		map.put("foGetSeries", foGetSeries);
		map.put("foGetSeason", foGetSeason);
		
		VodSO vodSo = new VodSO();
		vodSo.setMbrNo(session.getMbrNo());
		vodSo.setSrisNo(so.getSrisNo());
		vodSo.setSesnNo(so.getSesnNo());
		
		List<VodVO> foSesnVodList = vodService.foSesnVodList(vodSo);
		map.put("foSesnVodList", foSesnVodList);
//		List<SeriesVO> foSeriesList = seriesService.foSeriesList(so);
//		map.put("foSeriesList", foSeriesList);
		
		map.put("so", vodSo);
		map.put("view", view);
		map.put("session", session);
		map.put("callParam", so.getCallParam());
		
		return  TilesView.layout("pettv",new String[]{ "petTvSeriesList"});
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명    : gs-apet-31-front
	 * - 파일명        : PetTvSeriesController.java
	 * - 작성일        : 2021. 3. 9.
	 * - 작성자        : YKU
	 * - 설명          : gnb 시리즈 목록 팝업
	 * </pre>
	 * @param map
	 * @param session
	 * @param view
	 * @param so
	 * @return
	 */
	@RequestMapping(value="getSeriesList" , method = RequestMethod.POST)
	public String getSeriesList(ModelMap map, Session session, ViewBase view, SeriesSO so){
	 	List<SeriesVO> foSeriesList = seriesService.foSeriesList(so);
	 	map.put("foSeriesList", foSeriesList);
		return  TilesView.layout("pettv",new String[]{ "petTvSeriesGnb"});
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명    : gs-apet-31-front
	 * - 파일명        : PetTvSeriesController.java
	 * - 작성일        : 2021. 4. 1.
	 * - 작성자        : YKU
	 * - 설명          : 최신/인기순
	 * </pre>
	 * @param map
	 * @param session
	 * @param view
	 * @param so
	 * @return
	 */
	@RequestMapping(value="getSesnList" , method = RequestMethod.POST)
	public String getSesnList(ModelMap map, Session session, ViewBase view, VodSO so){
		
		so.setMbrNo(session.getMbrNo());
		List<VodVO> foSesnVodList = vodService.foSesnVodList(so);
		map.put("foSesnVodList", foSesnVodList);
		
		return  TilesView.layout("pettv",new String[]{"petTvSesnList"});
	}
}
