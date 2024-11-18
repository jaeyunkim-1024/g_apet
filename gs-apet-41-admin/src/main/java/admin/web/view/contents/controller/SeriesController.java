package admin.web.view.contents.controller;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import admin.web.config.grid.GridResponse;
import admin.web.config.view.View;
import biz.app.contents.model.ApetAttachFilePO;
import biz.app.contents.model.ApetAttachFileVO;
import biz.app.contents.model.SeriesPO;
import biz.app.contents.model.SeriesSO;
import biz.app.contents.model.SeriesVO;
import biz.app.contents.service.SeriesService;
import biz.common.service.BizService;
import framework.admin.model.Session;
import framework.admin.util.AdminSessionUtil;
import framework.common.constants.CommonConstants;
import framework.common.model.ExcelViewParam;
import framework.common.util.StringUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class SeriesController {
	
	@Autowired	private SeriesService seriesService;
	@Autowired  private MessageSourceAccessor messageSourceAccessor;
	@Autowired  private BizService bizService;
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: SeriesController.java
	 * - 작성일		: 2020. 12. 21.
	 * - 작성자		: valueFactory
	 * - 설명			: 시리즈 관리 페이지
	 * </pre>
	 *
	 * @param model
	 * @param so
	 * @return
	 */
	@RequestMapping("/series/seriesListView.do")
	public String seriesListView(Model model, SeriesSO so) {
		if (log.isDebugEnabled()) {
			log.debug("==================================================");
			log.debug("= {}", "seriesListView");
			log.debug("==================================================");
		}	
		model.addAttribute("seriesSO", so);
		return "/contents/seriesListView";
	}
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: PetlogController.java
	 * - 작성일		: 2020. 12. 21.
	 * - 작성자		: valueFactory
	 * - 설명			: 시리즈 리스트
	 * </pre>
	 *
	 * @param so
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/series/listSeries.do", method = RequestMethod.POST)
	public GridResponse listSeries(SeriesSO so) {	
		if (log.isDebugEnabled()) {
			log.debug("==================================================");
			log.debug("= {}", "petlog listSeries");
			log.debug("==================================================");
		}

		Session session = AdminSessionUtil.getSession();		
		List<SeriesVO> list = seriesService.pageSeries(so);
		return new GridResponse(list, so);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: SeriesController.java
	 * - 작성일		: 2020. 12. 21.
	 * - 작성자		: valueFactory
	 * - 설명			: 시리즈 상세 페이지
	 * </pre>
	 *
	 * @param model
	 * @param so
	 * @return
	 */
	@RequestMapping("/series/seriesDetailView.do")
	public String seriesDetailView(Model model, SeriesSO so) {
		if (log.isDebugEnabled()) {
			log.debug("==================================================");
			log.debug("= {}", "seriesDetailView");
			log.debug("==================================================");
		}
		SeriesVO vo = new SeriesVO();
		if(so.getSrisNo() != null) {
			List<SeriesVO> list = seriesService.pageSeries(so);
			vo = list.get(0);
		}
		so.setSrisNo(vo.getSrisNo());
		so.setFlNo(vo.getFlNo());
		List<ApetAttachFileVO> attachList = seriesService.getAttachFiles(so);
		List<SeriesVO> tagList = seriesService.getSeriesTagMap(so);
		model.addAttribute("seriesVO", vo);
		model.addAttribute("attachList", attachList);		
		model.addAttribute("tagList", tagList);
		return "/contents/seriesInsertView";
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: PetlogController.java
	 * - 작성일		: 2020. 12. 24.
	 * - 작성자		: valueFactory
	 * - 설명			: 시즌 리스트
	 * </pre>
	 *
	 * @param so
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/series/listSeason.do", method = RequestMethod.POST)
	public GridResponse listSeason(SeriesSO so) {	
		if (log.isDebugEnabled()) {
			log.debug("==================================================");
			log.debug("= {}", "listSeason");
			log.debug("==================================================");
		}

		Session session = AdminSessionUtil.getSession();		
		//so.setRows(20);
		List<SeriesVO> list = seriesService.pageSeason(so);
		
		return new GridResponse(list, so);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: SeriesController.java
	 * - 작성일		: 2020. 12. 21.
	 * - 작성자		: valueFactory
	 * - 설명			: 시리즈 등록 페이지
	 * </pre>
	 *
	 * @param model
	 * @param so
	 * @return
	 */
	@RequestMapping("/series/seriesInsertView.do")
	public String seriesInsertView(Model model, SeriesSO so) {
		if (log.isDebugEnabled()) {
			log.debug("==================================================");
			log.debug("= {}", "seriesInsertView");
			log.debug("==================================================");
		}
		SeriesVO vo = new SeriesVO();

		model.addAttribute("seriesVO", vo);
		return "/contents/seriesInsertView";
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: SeriesController.java
	 * - 작성일		: 2020. 12. 21.
	 * - 작성자		: valueFactory
	 * - 설명			: 시리즈 전시상태 등록/수정
	 * </pre>
	 *
	 * @param model
	 * @param so
	 * @return
	 */
	@RequestMapping("/series/updateSeriesStat.do")
	public String updateSeriesStat(Model model, SeriesSO so, String seriesStatUpdateGb) {
		if (log.isDebugEnabled()) {
			log.debug("==================================================");
			log.debug("= {}", "updateSeriesStat");
			log.debug("==================================================");
		}
		int updateCnt = 0 ;
		Session session = AdminSessionUtil.getSession();		
		
		List<SeriesPO> seriesPOList = new ArrayList<>();
		Long[] srisNos = so.getSrisNos();	
		Long[] fiNos = so.getFlNos();

		for(int i=0; i < srisNos.length; i++) {
			SeriesPO po = new SeriesPO();
			po.setSrisNo(srisNos[i]);
			po.setFlNo(fiNos[i]);
			po.setDispYn(seriesStatUpdateGb);
			po.setSysUpdrNo(session.getUsrNo());
			seriesPOList.add(po);
		}
		updateCnt = seriesService.updateSeriesStat(seriesPOList);

		model.addAttribute("updateCnt", updateCnt);

		return View.jsonView();
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: SeriesController.java
	 * - 작성일		: 2020. 12. 21.
	 * - 작성자		: valueFactory
	 * - 설명			: 시리즈 등록/수정
	 * </pre>
	 *
	 * @param model
	 * @param so
	 * @return
	 */
	@RequestMapping("/series/updateSeries.do")
	public String updateSeries(Model model, SeriesPO po, String seriesStatUpdateGb) {
		if (log.isDebugEnabled()) {
			log.debug("==================================================");
			log.debug("= {}", "updateSeries");
			log.debug("==================================================");
		}
		int updateCnt = 0 ;
	
		Session session = AdminSessionUtil.getSession();
		po.setSysRegrNo(session.getUsrNo());
		po.setSysUpdrNo(session.getUsrNo());
		updateCnt = seriesService.updateSeries(po);

		model.addAttribute("updateCnt", updateCnt);

		return View.jsonView();
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: SeriesController.java
	 * - 작성일		: 2020. 12. 18.
	 * - 작성자		: valueFactory
	 * - 설명			: 시즌 등록 Layer View
	 * </pre>
	 *
	 * @param model
	 * @param so
	 * @return
	 */
	@RequestMapping("/series/popupSeasonInsert.do")
	public String popupSeasonInsert(Model model, SeriesSO so) {
		if (log.isDebugEnabled()) {
			log.debug("==================================================");
			log.debug("= {}", "series popupSeasonInsert");
			log.debug("==================================================");
		}
		SeriesVO vo = seriesService.getSeasonDetail(so);
		if(vo != null) {
			so.setFlNo(vo.getFlNo());		
			List<ApetAttachFileVO> attachList = seriesService.getAttachFiles(so);		
			model.addAttribute("attachList", attachList);
		}		
		model.addAttribute("SeriesVO", vo);
		return "/contents/seasonInsertViewPop";
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: SeriesController.java
	 * - 작성일		: 2020. 12. 28.
	 * - 작성자		: valueFactory
	 * - 설명			: 시즌 등록/수정
	 * </pre>
	 *
	 * @param model
	 * @param so
	 * @return
	 */
	@RequestMapping("/series/updateSeason.do")
	public String updateSeason(Model model, SeriesPO po, String seasonStatUpdateGb) {
		if (log.isDebugEnabled()) {
			log.debug("==================================================");
			log.debug("= {}", "updateSeason");
			log.debug("==================================================");
		}
		int updateCnt = 0 ;
		Session session = AdminSessionUtil.getSession();
		po.setSysRegrNo(session.getUsrNo());
		po.setSysUpdrNo(session.getUsrNo());
		updateCnt = seriesService.updateSeason(po);

		model.addAttribute("updateCnt", updateCnt);

		return View.jsonView();
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: SeriesController.java
	 * - 작성일		: 2020. 12. 28.
	 * - 작성자		: valueFactory
	 * - 설명			: 시즌 전시상태 일괄 수정
	 * </pre>
	 *
	 * @param model
	 * @param so
	 * @return
	 */
	@RequestMapping("/series/updateSeasonStat.do")
	public String updateSeasonStat(Model model, SeriesSO so, String seasonStatUpdateGb) {
		if (log.isDebugEnabled()) {
			log.debug("==================================================");
			log.debug("= {}", "updateSeasonStat");
			log.debug("==================================================");
		}
		int updateCnt = 0 ;
		Session session = AdminSessionUtil.getSession();		
		
		List<SeriesPO> seasonPOList = new ArrayList<>();
		Long[] sesnNos = so.getSesnNos();
		Long[] flNos = so.getFlNos();
		Long srisNo = so.getSrisNo();

		for(int i=0; i < sesnNos.length; i++) {
			SeriesPO po = new SeriesPO();
			po.setSrisNo(srisNo);
			po.setSesnNo(sesnNos[i]);
			po.setDispYn(seasonStatUpdateGb);
			po.setSysUpdrNo(session.getUsrNo());
			po.setFlNo(flNos[i]);
			seasonPOList.add(po);
		}
		updateCnt = seriesService.updateSeasonStat(seasonPOList);

		model.addAttribute("updateCnt", updateCnt);

		return View.jsonView();
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: SeriesController.java
	 * - 작성일		: 2021. 05. 13.
	 * - 작성자		: kwj
	 * - 설명			: 시리즈 삭제
	 * </pre>
	 *
	 * @param model
	 * @param so
	 * @return
	 */
	@RequestMapping("/series/deleteSeries.do")
	public String deleteSeries(Model model, SeriesSO so) {
		if (log.isDebugEnabled()) {
			log.debug("==================================================");
			log.debug("= {}", "deleteSeries");
			log.debug("==================================================");
		}
		int deleteCnt = 0 ;
		Session session = AdminSessionUtil.getSession();		
		
		List<SeriesPO> seriesPOList = new ArrayList<>();
		Long[] srisNos = so.getSrisNos();

		for(int i=0; i < srisNos.length; i++) {
			SeriesPO po = new SeriesPO();
			po.setSrisNo(srisNos[i]);			
			seriesPOList.add(po);
		}
		deleteCnt = seriesService.deleteSeries(seriesPOList);

		model.addAttribute("deleteCnt", deleteCnt);

		return View.jsonView();
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: SeriesController.java
	 * - 작성일		: 2021. 05. 13.
	 * - 작성자		: kwj
	 * - 설명			: 시즌 삭제
	 * </pre>
	 *
	 * @param model
	 * @param so
	 * @return
	 */
	@RequestMapping("/series/deleteSeason.do")
	public String deleteSeason(Model model, SeriesSO so) {
		if (log.isDebugEnabled()) {
			log.debug("==================================================");
			log.debug("= {}", "deleteSeason");
			log.debug("==================================================");
		}
		int deleteCnt = 0 ;
		Session session = AdminSessionUtil.getSession();		
		
		List<SeriesPO> seasonPOList = new ArrayList<>();
		Long[] sesnNos = so.getSesnNos();
		Long srisNo = so.getSrisNo();

		for(int i=0; i < sesnNos.length; i++) {
			SeriesPO po = new SeriesPO();
			po.setSrisNo(srisNo);
			po.setSesnNo(sesnNos[i]);	
			po.setSysUpdrNo(session.getUsrNo());			
			seasonPOList.add(po);
		}
		deleteCnt = seriesService.deleteSeason(seasonPOList);

		model.addAttribute("deleteCnt", deleteCnt);

		return View.jsonView();
	}
	
	

}
