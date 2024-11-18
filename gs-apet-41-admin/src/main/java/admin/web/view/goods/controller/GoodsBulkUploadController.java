package admin.web.view.goods.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import biz.app.goods.validation.GoodsValidator;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import admin.web.config.grid.GridResponse;
import admin.web.config.view.View;
import biz.app.attribute.model.AttributeSO;
import biz.app.attribute.model.AttributeValueVO;
import biz.app.goods.model.GoodsBulkUploadPO;
import biz.app.goods.model.GoodsBulkUploadSO;
import biz.app.goods.service.GoodsBulkUploadService;
import biz.app.goods.service.GoodsService;
import biz.app.goods.service.ItemService;
import biz.app.st.model.StStdInfoSO;
import biz.app.st.model.StStdInfoVO;
import biz.app.st.service.StService;
import biz.app.system.model.CodeDetailVO;
import biz.common.service.CacheService;
import framework.admin.constants.AdminConstants;
import framework.admin.util.JsonUtil;
import framework.admin.util.LogUtil;
import framework.common.constants.CommonConstants;
import framework.common.util.ExcelUtil;
import framework.common.util.FtpImgUtil;
import framework.common.util.StringUtil;
import framework.common.util.excel.ExcelData;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class GoodsBulkUploadController {

	@Autowired
	private GoodsBulkUploadService goodsBulkUploadService;

	@Autowired
	private GoodsService goodsService;

	@Autowired
	private CacheService cacheService;

	@Autowired
	private StService stService;

	@Autowired
	private ItemService itemService;

	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: GoodsBulkUploadController.java
	* - 작성일		: 2016. 5. 23.
	* - 작성자		: valueFactory
	* - 설명			: 상품 일괄등록 화면
	* </pre>
	* @param model
	* @return
	*/
	@RequestMapping("/goods/goodsBulkUploadView.do")
	public String goodsBulkUploadView (Model model ) {
		if(log.isDebugEnabled() ) {
			log.debug("==================================================");
			log.debug("= {}", "GOODS 일괄 등록");
			log.debug("==================================================");
		}

		return "/goods/goodsBulkUploadView";
	}

	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: GoodsBulkUploadController.java
	* - 작성일		: 2016. 5. 24.
	* - 작성자		: valueFactory
	* - 설명			: Excel Upload
	* </pre>
	* @param model
	* @param filePath
	* @param fileName
	* @return
	*/
	@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping(value="/goods/uploadExcelGrid.do", method=RequestMethod.POST)
	public GridResponse uploadExcelGrid (Model model
			, GoodsBulkUploadSO so
			, @RequestParam("filePath") String filePath
			, @RequestParam("fileName") String fileName
			, @RequestParam("colName") String[] colNames ) {

		if(log.isDebugEnabled() ) {
			log.debug("==================================================");
			log.debug("= {}", "uploadExcelGrid");
			log.debug("==================================================");
			LogUtil.log(so );
		}

		log.debug(" colNames >>> {}",  Arrays.toString(colNames));

		// 가지고온 Grid의 헤더와 엑셀을 맵핑 한다.
		// 그리드 순서와 엑셀순서..
		String[][] headerMap = null;
		ExcelData excelData = new ExcelData(null, null);

		if(StringUtil.isNotEmpty(filePath) ) {
			File excelFile = new File(filePath);// 파싱할 Excel File

			if(colNames != null && colNames.length > 0 ) {
				headerMap = new String[colNames.length][2];
				for(int i = 0, colLength = colNames.length; i < colLength; i++) {
					headerMap[i][0] = String.valueOf(i + 1);
					headerMap[i][1] = colNames[i];

					log.debug(" headerMap[i][0] >>> {}", headerMap[i][0]);
					log.debug(" headerMap[i][1] >>> {}", headerMap[i][1]);
				}
			}

			// 상품 업로드
			if(AdminConstants.UPLOAD_GB_GOODS_BASE.equals(so.getUploadGb()) ) {

				try {
					log.debug(" headerMap >>> {}" + Arrays.toString(headerMap));

					excelData = ExcelUtil.parse(excelFile, GoodsBulkUploadPO.class, headerMap );
				} catch (Exception e) {
					log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
				}

				List<GoodsBulkUploadPO> goodsBulkUploadPOList = excelData.getData();
				if(CollectionUtils.isNotEmpty(goodsBulkUploadPOList)) {
					if(goodsBulkUploadPOList.size() > 0) {
						goodsBulkUploadPOList = goodsBulkUploadService.validateBulkUpladGoods(goodsBulkUploadPOList );
						excelData.setData(goodsBulkUploadPOList );
					}
				}
			}

			// 읽은 파일 삭제
			if(!excelFile.delete()) {
				log.error("Fail to delete of file. GoodsBulkUploadController.uploadExcelGrid::excelFile.delete {}");
			}
		}

		return new GridResponse( CollectionUtils.isEmpty(excelData.getData()) ? new ArrayList<Map<String,Object>>() : excelData.getData(), so );
	}


	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: GoodsBulkUploadController.java
	* - 작성일		: 2016. 5. 24.
	* - 작성자		: valueFactory
	* - 설명			: 상품 일괄 업로드
	* </pre>
	* @return
	*/
	@RequestMapping(value="/goods/bulkUploadGoods.do")
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public String bulkUploadGoods (Model model
			, GoodsBulkUploadSO so
			, @RequestParam("GoodsBulkUploadPO") String goodsBulkUploadStr ) {

		if(log.isDebugEnabled() ) {
			log.debug("==================================================");
			log.debug("= {} GOODS 일괄 등록" , goodsBulkUploadStr    );
			log.debug("==================================================");
		}
		log.debug("= {} GOODS 일괄 등록" , goodsBulkUploadStr    );

		JsonUtil jsonUt = new JsonUtil();

		List<GoodsBulkUploadPO> goodsBulkUploadPOList = null;
		if(StringUtil.isNotEmpty(goodsBulkUploadStr) ) {
			// Line Feed 특수문자 공백으로 바꿈.
			goodsBulkUploadPOList = jsonUt.toArray(GoodsBulkUploadPO.class, goodsBulkUploadStr.replaceAll("&#10;", StringUtils.EMPTY) );
			if(CollectionUtils.isNotEmpty(goodsBulkUploadPOList)) {

				GoodsValidator goodsValidator = new GoodsValidator();

				if(goodsBulkUploadPOList != null && !goodsBulkUploadPOList.isEmpty()) {
					for (GoodsBulkUploadPO goodsBulkPO : goodsBulkUploadPOList) {
						goodsBulkPO.setNtfId("35");
						log.debug("= {} GOODS 일괄 등록", goodsBulkPO.toString());

						// 최종적으로 다시 한번 검사
						if (!goodsValidator.validateGoodsBase(goodsBulkPO)) {
							// 오류가 있으면 다음것 진행
							continue;
						}

						try {
							goodsBulkUploadService.uploadGood(goodsValidator, goodsBulkPO);

							goodsBulkPO.setSuccessYn(CommonConstants.COMM_YN_Y);
							goodsBulkPO.setResultMessage(goodsBulkPO.getGoodsId());
						} catch (CustomException e) {
							goodsBulkPO.setSuccessYn(CommonConstants.COMM_YN_N);
							goodsBulkPO.setResultMessage(String.join("\n",e.getParams()));
						} catch (Exception e) {
							goodsBulkPO.setSuccessYn(CommonConstants.COMM_YN_N);
							goodsBulkPO.setResultMessage(ExceptionConstants.ERROR_CODE_DEFAULT);
						}
					}

					// temp 폴더  삭제
					new FtpImgUtil().deleteTempFolders();
				}
			}
		}
		model.addAttribute("goodsBulkUploadPOList", goodsBulkUploadPOList);
		return View.jsonView();
	}

	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: GoodsBulkUploadController.java
	* - 작성일		: 2016. 7. 19.
	* - 작성자		: valueFactory
	* - 설명			: 일괄업로드 템플릿 가이드 VIEW
	* </pre>
	* @param model
	* @param so
	* @return
	*/
	@RequestMapping("/goods/goodsBulkUploadGuidePopView.do")
	public String goodsBulkUploadGuidePopView(Model model ) {
		if (log.isDebugEnabled()) {
			log.debug("==================================================");
			log.debug("= {}", "상품 일괄 업로드 템플릿 가이드 View");
			log.debug("==================================================");
		}
		// site 목록
		StStdInfoSO stStdInfoSO= new StStdInfoSO();
		stStdInfoSO.setUseYn(CommonConstants.COMM_YN_Y);
		List<StStdInfoVO> stStdInfoVOList = stService.listStStdInfo(stStdInfoSO);

		//과세 구분 코드 목록
		List<CodeDetailVO> taxGbList = cacheService.listCodeCache("TAX_GB", null, null, null, null, null);

		//속성 목록
		AttributeSO attributeSO = new AttributeSO();
		attributeSO.setUseYn("Y");
		List<AttributeValueVO> attributeList = itemService.listAttribute(attributeSO);

		// 웹 모바일 구분
		List<CodeDetailVO> webMobileGbList = cacheService.listCodeCache("WEB_MOBILE_GB", null, null, null, null, null);

		model.addAttribute("stStdInfoVOList",stStdInfoVOList);
		model.addAttribute("taxGbList",taxGbList);
		model.addAttribute("attributeList",attributeList);
		model.addAttribute("webMobileGbList",webMobileGbList);

		return "/goods/goodsBulkUploadGuidePopView";
	}

}
