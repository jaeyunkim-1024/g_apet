package admin.web.view.contents.controller;

import java.text.Normalizer;
import java.util.ArrayList;
import java.util.List;

import framework.common.model.ExcelViewParam;
import framework.common.util.DateUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import admin.web.config.grid.GridResponse;
import admin.web.config.view.View;
import biz.app.contents.model.SeriesVO;
import biz.app.contents.model.VodGoodsPO;
import biz.app.contents.model.VodGoodsVO;
import biz.app.contents.model.VodPO;
import biz.app.contents.model.VodSO;
import biz.app.contents.model.VodVO;
import biz.app.contents.service.VodService;
import framework.admin.util.JsonUtil;
import framework.cis.client.ApiClient;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import framework.common.util.StringUtil;
import lombok.extern.slf4j.Slf4j;

/**
 * <pre>
 * - 프로젝트명	: 41.admin.web
 * - 패키지명		: admin.web.view.contents.controller
 * - 파일명		: ContentsController.java
 * - 작성자		: valueFactory
 * - 설명		: 컨텐츠 관리
 * </pre>
 */
@Slf4j
@Controller
public class VodController {

	@Autowired
	private VodService vodService;
	
	@Autowired
	ApiClient apiClient;
	
//	public static GenericObjectPool<StatefulRedisConnection<String, String>> pool = null; //sync & 비 클러스터모드 커넥션풀

	/**
	 * <pre>영상 리스트 페이지</pre>
	 * 
	 * @author valueFactory
	 * @param 
	 * @return viewResolver path
	 */
	@RequestMapping("/contents/vodListView.do")
	public String vodListView() {
		return "/contents/vodListView";
	}

//	private static void testSetValue(String key, String value) { 
//		try (StatefulRedisConnection<String, String> connection = pool.borrowObject()) { //pool을 이용해서 커맨드 실행 
//			connection.sync().set(key, value); 
//			value = connection.sync().get(key); 
//		catch (RedisConnectionException e) { 
//		} catch (Exception e) {
//			e.printStackTrace(); 
//		 
//		}
//	}
//
//	@SuppressWarnings("unchecked")
//	private static GenericObjectPool<StatefulRedisConnection<String, String>> nonClusterPoolUsage() { 
//		RedisClient client = RedisClient.create("127.0.0.1:16379"); 
//		client.setOptions(ClientOptions.builder().autoReconnect(true).build()); 
//		return ConnectionPoolSupport.createGenericObjectPool(() -> client.connect(), createPoolConfig()); 
//	}
//
//	@SuppressWarnings("rawtypes")
//	private static GenericObjectPoolConfig createPoolConfig() { 
//		GenericObjectPoolConfig poolConfig = new GenericObjectPoolConfig(); 
//		poolConfig.setMaxTotal(20); 
//		poolConfig.setMaxIdle(10); 
//		// "true" will result better behavior when unexpected load hits in production 
//		// "false" makes it easier to debug when your maxTotal/minIdle/etc settings need adjusting. 
//		poolConfig.setBlockWhenExhausted(true); 
//		poolConfig.setMaxWaitMillis(1000); poolConfig.setMinIdle(5); return poolConfig; 
//	
//	}

	
	/**
	 * <pre>영상 그리드 리스트</pre>
	 * 
	 * @author valueFactory
	 * @param so ContentsSO
	 * @return DataGridResponse
	 */
	@ResponseBody
	@RequestMapping(value = "/contents/vodListGrid.do", method = RequestMethod.POST)
	public GridResponse vodListGrid(VodSO so) {
		so.setVdGbCd(CommonConstants.VD_GB_20);
		List<VodVO> list = vodService.pageVod(so);
		return new GridResponse(list, so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: VodController.java
	 * - 작성일		: 2020. 12. 18.
	 * - 작성자		: valueFactory
	 * - 설명			: 영상 전시 상태 일괄 업데이트
	 * </pre>
	 *
	 * @param model
	 * @param so
	 * @return
	 */
	@RequestMapping("/contents/batchUpdateDisp.do")
	public String batchUpdateDisp(Model model, VodSO so) {
		if (log.isDebugEnabled()) {
			log.debug("==================================================");
			log.debug("= {}", "Vod BatchUpdateDisp");
			log.debug("==================================================");
		}
		int updateCnt = 0 ;
		
		String[] vdIds = so.getVdIds();
		List<VodPO> vodPOList = new ArrayList<>();
		for (String vdId : vdIds) {
			VodPO po = new VodPO();
			po.setVdId(vdId);
			po.setDispYn(so.getDispYn());
			vodPOList.add(po);
		}
		updateCnt = vodService.batchUpdateDisp(vodPOList);
		model.addAttribute("updateCnt", updateCnt);
		return View.jsonView();
	}

	/**
	 * <pre>영상 상세 화면</pre>
	 * 
	 * @author valueFactory
	 * @param model
	 * @param so VodSO
	 * @return viewResolver path
	 */
	@RequestMapping("/contents/vodDetailView.do")
	public String vodView(Model model, VodSO so) {
		VodVO vo = vodService.getVod(so);
		model.addAttribute("vod", vo);
		model.addAttribute("allSeries", vodService.getSeriesAll());
		model.addAttribute("seasonBySeries", vodService.getSeasonBySrisNo(vo.getSrisNo()));
		model.addAttribute("tags", vodService.getTagsByVdId(vo.getVdId()));
		model.addAttribute("goods", vodService.getGoodsByVdId(vo.getVdId()));
		return "/contents/vodDetailView";
	}
	
	/**
	 * <pre>영상 등록 화면</pre>
	 * 
	 * @author valueFactory
	 * @param model
	 * @param 
	 * @return viewResolver path
	 */
	@RequestMapping("/contents/vodInsertView.do")
	public String vodInsertView(Model model) {
		model.addAttribute("allSeries", vodService.getSeriesAll());
		return "/contents/vodInsertView";
	}

	/**
	 * <pre>영상 등록</pre>
	 * 
	 * @author valueFactory
	 * @param model
	 * @param VodPO po
	 * @param goodsMapPoStr
	 * @return jsonView
	 */
	@RequestMapping("/contents/vodInsert.do")
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public String vodInsert(Model model, VodPO vodPo,
			@RequestParam(value = "goodsMapPo", required = false) String goodsMapPoStr,
			BindingResult br) {

		if (br.hasErrors()) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

		JsonUtil jsonUt = new JsonUtil();

		// 상품 연동
		List<VodGoodsPO> vodGoodsPoList = null;
		if (!StringUtil.isEmpty(goodsMapPoStr)) {
			vodGoodsPoList = jsonUt.toArray(VodGoodsPO.class, goodsMapPoStr);
			vodPo.setVodGoodsPoList(vodGoodsPoList);
		}

		log.debug("vodPo====>" + vodPo);

		vodService.insertVod(vodPo);
		model.addAttribute("vod", vodPo);
		
		return View.jsonView();
	}

	/**
	 * <pre>시리즈 리스트</pre>
	 * 
	 * @author valueFactory
	 * @param model
	 * @param 
	 * @return List<>
	 */
	@ResponseBody
	@RequestMapping(value = "/contents/listSeries.do", method = RequestMethod.POST)
	public List<SeriesVO> listSeries() {
		return vodService.getSeriesAll();
	}
	
	/**
	 * <pre>시즌 리스트</pre>
	 * 
	 * @author valueFactory
	 * @param model
	 * @param 
	 * @return List<>
	 */
	@ResponseBody
	@RequestMapping(value = "/contents/listSeason.do", method = RequestMethod.POST)
	public List<SeriesVO> listSeason(Long srisNo) {
		return vodService.getSeasonBySrisNo(srisNo);
	}

	/**
	 * <pre>영상 수정</pre>
	 * 
	 * @author valueFactory
	 * @param model
	 * @param VodPO po
	 * @param goodsMapPoStr
	 * @return jsonView
	 */
	@RequestMapping("/contents/vodUpdate.do")
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public String companyUpdate(Model model, VodPO vodPo,
			@RequestParam(value = "goodsMapPo", required = false) String goodsMapPoStr,
			BindingResult br) {

		if (br.hasErrors()) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

		JsonUtil jsonUt = new JsonUtil();

		// 상품 연동
		List<VodGoodsPO> vodGoodsPoList = null;
		if (!StringUtil.isEmpty(goodsMapPoStr)) {
			vodGoodsPoList = jsonUt.toArray(VodGoodsPO.class, goodsMapPoStr);
			vodPo.setVodGoodsPoList(vodGoodsPoList);
		}

		log.debug("vodPo====>" + vodPo);

		vodService.updateVod(vodPo);
		model.addAttribute("vod", vodPo);
		
		return View.jsonView();
	}
	
	/**
	 * <pre>영상 조회 팝업 화면</pre>
	 * 
	 * @author valueFactory
	 * @param model
	 * @param VodSO so
	 * @return viewResolver path
	 */
	@RequestMapping("/contents/vodSearchLayerView.do")
	public String vodSearchLayerView(Model model, VodSO so) {
		model.addAttribute("vodSearchInfo", so);
		;model.addAttribute("allSeries", vodService.getSeriesAll());
		return "/contents/vodSearchLayerView";
	}

	/**
	 * <pre>연동 상품 리스트</pre>
	 * 
	 * @author valueFactory
	 * @param model
	 * @param 
	 * @return viewResolver path
	 */
	@ResponseBody
	@RequestMapping(value="/contents/vodGoodsListGrid.do", method=RequestMethod.POST)
	public GridResponse vodGoodsListGrid(VodSO so) {
		List<VodGoodsVO> list = vodService.listVodGoods(so);

		return new GridResponse(list, so);
	}

	/**
	 * 영상 엑셀다운로드
	 * @param model
	 * @param so
	 * @return
	 */
	@RequestMapping(value = "/contents/vodListExcelDownload.do", method = RequestMethod.POST)
	public String vodListExcelDownload(Model model, VodSO so){

		so.setVdGbCd(CommonConstants.VD_GB_20);
		so.setExcelMode("Y");
		List<VodVO> vodList = vodService.excelDownVodList(so);

		List<VodVO> tmpVoList = new ArrayList<>();

		for(VodVO vo : vodList){
			// 한글 자음 모음 나뉘는 현상을 정상적으로 표시
			vo.setVodNm(Normalizer.normalize( vo.getVodNm(), Normalizer.Form.NFC));
			tmpVoList.add(vo);
		}

		String[] headerName = {"영상ID", "영상이름", "파일명", "썸네일명", "영상타입", "시리즈타입", "시리즈", "시즌", "공유수", "조회수", "좋아요", "댓글수", "전시상태", "등록일", "수정일"};
		String[] fieldName = {"vdId", "ttl", "vodNm", "thumNm", "tpNm", "srisTpNm", "srisNm", "sesnNm", "shareCnt", "hits", "likeCnt", "replyCnt", "dispYn", "sysRegDtm", "sysUpdDtm"};

		model.addAttribute(CommonConstants.EXCEL_PARAM_FILE_NAME_DATE_FORMAT, "yyyyMMddHHmmss");
		model.addAttribute(CommonConstants.EXCEL_PARAM_NAME, new ExcelViewParam("vod_list", headerName, fieldName, tmpVoList));
		model.addAttribute(CommonConstants.EXCEL_PARAM_FILE_NAME, "영상목록");
		return View.excelDownload();
	}

}