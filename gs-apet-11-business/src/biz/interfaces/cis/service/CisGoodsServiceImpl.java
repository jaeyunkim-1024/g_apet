package biz.interfaces.cis.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.lang3.StringUtils;
import org.codehaus.jackson.node.ObjectNode;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.databind.ObjectMapper;

import biz.app.brand.model.BrandBasePO;
import biz.app.goods.dao.CisGoodsDao;
import biz.app.goods.model.SkuInfoSO;
import biz.app.goods.model.SkuInfoVO;
import biz.app.statistics.model.GoodsSO;
import biz.interfaces.cis.model.request.goods.CisBrandPO;
import biz.interfaces.cis.model.request.goods.SkuInfoInsertPO;
import biz.interfaces.cis.model.request.goods.SkuInfoUpdatePO;
import biz.interfaces.cis.model.response.goods.CisBrandVO;
import biz.interfaces.cis.model.response.goods.SkuInfoInsertVO;
import biz.interfaces.cis.model.response.goods.SkuInfoUpdateVO;
import biz.interfaces.cis.model.response.goods.StockUpdateVO;
import framework.cis.client.ApiClient;
import framework.cis.model.request.shop.goods.StockRequest;
import framework.cis.model.response.ApiResponse;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.enums.CisApiSpec;
import framework.common.exception.CustomException;
import framework.common.util.StringUtil;
import lombok.extern.slf4j.Slf4j;

/**
 * <pre>
 * - 프로젝트명 : 11.business
 * - 패키지명   : biz.interfaces.cis.service
 * - 파일명     : CisGoodsServiceImpl.java
 * - 작성일     : 2021. 02. 01.
 * - 작성자     : lhj01
 * - 설명       :
 * </pre>
 */

@Slf4j
@Transactional
@Service("cisGoodsService")
public class CisGoodsServiceImpl implements CisGoodsService {

	@Autowired
	private MessageSourceAccessor message;

	@Autowired
	private ApiClient apiClient;
	
	@Autowired
	private CisGoodsDao cisGoodsDao;

	@Autowired
	private CisIfLogService cisIfLogService;
	
	@Autowired
	private MessageSourceAccessor messageSourceAccessor;

	/**
	 * [DB]단품 CIS 연동 수정 대상 조회
	 * @return
	 */
	@Override
	public List<SkuInfoVO> getStuInfoListForSend(SkuInfoSO so) {
		return cisGoodsDao.selectStuInfoListForSend(so);
	}
	
	/**
	 * 상품 일괄 등록 CIS용 조회
	 * @return
	 */
	@Override
	public SkuInfoVO getInfoForBulkCisSend(GoodsSO so) {
		return cisGoodsDao.getInfoForBulkCisSend(so);
	}

	/**
	 * [DB]상품 CIS 연동 수정 대상 조회
	 * @return
	 */
	@Override
	public List<SkuInfoVO> getPrdtInfoListForSend(SkuInfoSO so) {
		return cisGoodsDao.selectPrdtInfoListForSend(so);
	}

	/**
	 * [CIS]재고 조회
	 * @param allYn Y: 대상 전체 조회, NULL OR N : 하루전 변경된 대상
	 * @return
	 * @throws Exception
	 */
	@Override
	public StockUpdateVO getGoodsStockList(String allYn) throws Exception {
		ObjectMapper objectMapper = new ObjectMapper();
		StockUpdateVO vo = new StockUpdateVO();

		StockRequest stockRequest = new StockRequest();

		//Y: 대상 전체 조회, NULL OR N : 하루전 변경된 대상
		allYn = (StringUtil.isNotEmpty(allYn)) ? allYn : CommonConstants.COMM_YN_N;
		stockRequest.setAllYn(allYn);

		//API call log insert
		Long logNo = insertCisIfLog(CommonConstants.CIS_API_ID_IF_S_SELECT_STOCK_LIST, objectMapper.writeValueAsString(stockRequest));
		//API call
		ApiResponse ar = null;
		String httpStatusCd = CommonConstants.CIS_API_SUCCESS_HTTP_STATUS_CD;
		try {
			ar = apiClient.getResponse(CisApiSpec.IF_S_SELECT_STOCK_LIST, stockRequest);
		}catch(CustomException ce) {
			httpStatusCd = ce.getExCode();
		}

		//Response set
		if(ar != null) {
			vo = objectMapper.readValue(ar.getResponseBody(), StockUpdateVO.class);
		}

		//API call log update
		updateCisIfLog(CommonConstants.CIS_API_ID_IF_S_SELECT_STOCK_LIST, objectMapper.writeValueAsString(vo), vo.getResCd(), vo.getResMsg(), httpStatusCd, logNo);

		return vo;
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRES_NEW, rollbackFor = {Exception.class})
	public HashMap sendClsGoods(String sendType, String goodsCstrtTpCd, List<SkuInfoVO> list) {

		HashMap result = new HashMap();
		StringBuilder resultMessage = new StringBuilder(1024);

		try {
			for(SkuInfoVO vo : list) {
				Map<String, Object> resultMap = new HashMap<>();
				String resCd = new String();

				if(StringUtils.equals(sendType, "insert")) {
					SkuInfoInsertPO po = new SkuInfoInsertPO();
					BeanUtils.copyProperties(po, vo);
					SkuInfoInsertVO res = insertSkuInfo(po);
					resCd = res.getResCd();

					resultMessage.append(messageSourceAccessor.getMessage("admin.web.view.app.goods.cis.insert") + res.getResMsg());

					if(!resCd.equalsIgnoreCase(CommonConstants.CIS_API_SUCCESS_CD)) {
						resultMap.put(resCd, resultMessage.toString());
					}else {
						resultMap.put(resCd, StringUtils.equals(goodsCstrtTpCd, CommonConstants.GOODS_CSTRT_TP_ITEM) ? res.getSkuNo() : res.getPrdtNo());
					}
				} else if(StringUtils.equals(sendType, "update")) {
					SkuInfoUpdatePO po = new SkuInfoUpdatePO();
					BeanUtils.copyProperties(po, vo);
					SkuInfoUpdateVO res = updateSkuInfo(po, CommonConstants.COMM_YN_N);
					resCd = res.getResCd();

					resultMessage.append(messageSourceAccessor.getMessage("admin.web.view.app.goods.cis.update") + res.getResMsg());

					if(!resCd.equalsIgnoreCase(CommonConstants.CIS_API_SUCCESS_CD)) {
						resultMap.put(resCd, resultMessage.toString());
					}else {
						resultMap.put(resCd, StringUtils.equals(goodsCstrtTpCd, CommonConstants.GOODS_CSTRT_TP_ITEM) ? res.getSkuNo() : res.getPrdtNo());
					}
				}

				result.put(vo.getSkuCd(), resultMap);
			}

		} catch (Exception e) {
			log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
			throw new CustomException(ExceptionConstants.ERROR_CIS_ERROR, new String[]{resultMessage.toString()});
		}

		return result;
	}
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명	: GoodsServiceImpl.java
	 * - 작성일	: 2021. 2. 18.
	 * - 작성자 	: valfac
	 * - 설명 		: CIS 전송
	 * </pre>
	 * @param skuInfoSO
	 * @return hashMap(resCd, res.getResCd())
	 */
	@Override
	public HashMap sendClsGoods(SkuInfoSO skuInfoSO) {

		List<SkuInfoVO> list = new ArrayList<>();
		HashMap result = new HashMap();
		StringBuilder resultMessage = new StringBuilder(1024);

		if(StringUtils.equals(skuInfoSO.getGoodsCstrtTpCd(), CommonConstants.GOODS_CSTRT_TP_ITEM)) {
			list = getStuInfoListForSend(skuInfoSO);
		}else {
			list = getPrdtInfoListForSend(skuInfoSO);
		}

		try {
			for(SkuInfoVO vo : list) {
				Map<String, Object> resultMap = new HashMap<>();
				String resCd = new String();

				if(StringUtils.equals(skuInfoSO.getSendType(), "insert")) {
					SkuInfoInsertPO po = new SkuInfoInsertPO();
					BeanUtils.copyProperties(po, vo);
					SkuInfoInsertVO res = insertSkuInfo(po);
					resCd = res.getResCd();

					resultMessage.append(messageSourceAccessor.getMessage("admin.web.view.app.goods.cis.insert") + res.getResMsg());

					if(!resCd.equalsIgnoreCase(CommonConstants.CIS_API_SUCCESS_CD)) {
						resultMap.put(resCd, resultMessage.toString());
					}else {
						resultMap.put(resCd, StringUtils.equals(skuInfoSO.getGoodsCstrtTpCd(), CommonConstants.GOODS_CSTRT_TP_ITEM) ? res.getSkuNo() : res.getPrdtNo());
					}

				} else if(StringUtils.equals(skuInfoSO.getSendType(), "update")) {
					SkuInfoUpdatePO po = new SkuInfoUpdatePO();
					BeanUtils.copyProperties(po, vo);
					SkuInfoUpdateVO res = updateSkuInfo(po, CommonConstants.COMM_YN_N);
					resCd = res.getResCd();

					resultMessage.append(messageSourceAccessor.getMessage("admin.web.view.app.goods.cis.update") + res.getResMsg());
					
					if(!resCd.equalsIgnoreCase(CommonConstants.CIS_API_SUCCESS_CD)) {
						resultMap.put(resCd, resultMessage.toString());
					}else {
						resultMap.put(resCd, StringUtils.equals(skuInfoSO.getGoodsCstrtTpCd(), CommonConstants.GOODS_CSTRT_TP_ITEM) ? res.getSkuNo() : res.getPrdtNo());
					}
				}

				result.put(vo.getSkuCd(), resultMap);
			}

		} catch (Exception e) {
			log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
			throw new CustomException(ExceptionConstants.ERROR_CIS_ERROR, new String[]{resultMessage.toString()});
		}

		return result;
	}

	/**
	 * [CIS]단품/상품 등록
	 * @param po
	 * @return
	 * @throws Exception
	 */
	@Override
	@Transactional(propagation = Propagation.NESTED)
	public SkuInfoInsertVO insertSkuInfo(SkuInfoInsertPO po) throws Exception {

		String cisApiId = "";
		
		if(StringUtils.equals(po.getGoodsCstrtTpCd(), CommonConstants.GOODS_CSTRT_TP_ITEM) ) {
			cisApiId = CommonConstants.CIS_API_ID_IF_R_INSERT_SKU_INFO;
		}else {
			return new SkuInfoInsertVO();
		}
		
		ObjectMapper objectMapper = new ObjectMapper();
		SkuInfoInsertVO vo = new SkuInfoInsertVO();

		objectMapper.setSerializationInclusion(JsonInclude.Include.NON_EMPTY);

		//API call log insert 배치로 넘어가자
		Long logNo = 0L;
		logNo = insertCisIfLog(cisApiId, objectMapper.writeValueAsString(po));

		//API call
		ApiResponse ar = null;
		String httpStatusCd = CommonConstants.CIS_API_SUCCESS_HTTP_STATUS_CD;
		Map<String, String> mapParam = objectMapper.readValue(objectMapper.writeValueAsString(po), Map.class);

		try {
			ar = apiClient.getResponse(CisApiSpec.IF_R_INSERT_SKU_INFO, mapParam);
		}catch(CustomException ce) {
			httpStatusCd = ce.getExCode();

			vo.setResCd(ce.getExCode());
			//vo.setResMsg(ce.getParams()[0]);
		}
		
		//Response set
		if(ar != null) {
			ObjectNode on = (ObjectNode) ar.getResponseJson();
			
			if(!on.has("resCd") && on.has("resMsg") && !StringUtils.isEmpty(on.get("resMsg").getValueAsText())) {
				updateCisIfLog(cisApiId, ar.getResponseBody(), on.get("resCd").getValueAsText(), on.get("resMsg").getValueAsText(), httpStatusCd, logNo);
				vo.setResMsg(on.get("resMsg").getValueAsText());
			}else {
				vo = objectMapper.readValue(ar.getResponseBody(), SkuInfoInsertVO.class);
				updateCisIfLog(cisApiId, objectMapper.writeValueAsString(vo), vo.getResCd(), vo.getResMsg(), httpStatusCd, logNo);
			}
		} else {
			updateCisIfLog(cisApiId, null, vo.getResMsg(), vo.getResMsg(), httpStatusCd, logNo);
		}

		return vo;
	}

	/**
	 * [CIS]단품 수정
	 * @param po
	 * @param batchYn
	 * @return
	 * @throws Exception
	 */
	@Override
	@Transactional(propagation = Propagation.NESTED)
	public SkuInfoUpdateVO updateSkuInfo(SkuInfoUpdatePO po, String batchYn) throws Exception {
		ObjectMapper objectMapper = new ObjectMapper();
		SkuInfoUpdateVO vo = new SkuInfoUpdateVO();

		objectMapper.setSerializationInclusion(JsonInclude.Include.NON_EMPTY);
		
		String cisApiId = "";
		
		if(StringUtils.equals(po.getGoodsCstrtTpCd(), CommonConstants.GOODS_CSTRT_TP_ITEM) ) {
			cisApiId = CommonConstants.CIS_API_ID_IF_R_UPDATE_SKU_INFO;
		}else {
			return new SkuInfoUpdateVO();
		}

		//API call log insert 배치로 넘어가자
		Long logNo = 0L;
		if(CommonConstants.COMM_YN_N.equals(batchYn)) {
			logNo = insertCisIfLog(cisApiId, objectMapper.writeValueAsString(po));
		}

		//API call
		ApiResponse ar = null;
		String httpStatusCd = CommonConstants.CIS_API_SUCCESS_HTTP_STATUS_CD;
		Map<String, String> mapParam = objectMapper.readValue(objectMapper.writeValueAsString(po), Map.class);

		try {
			ar = apiClient.getResponse(CisApiSpec.IF_R_UPDATE_SKU_INFO, mapParam);
		}catch(CustomException ce) {
			httpStatusCd = ce.getExCode();
		}

		//Response set
		if(ar != null) {
			
			ObjectNode on = (ObjectNode) ar.getResponseJson();
			
			if(!on.has("resCd") && on.has("resMsg") && !StringUtils.isEmpty(on.get("resMsg").getValueAsText())) {
				updateCisIfLog(cisApiId, "", "", on.get("resMsg").getValueAsText(), httpStatusCd, logNo);
				vo.setResCd(CommonConstants.CIS_API_FAIL_CD);
			}else {
				
				vo = objectMapper.readValue(ar.getResponseBody(), SkuInfoUpdateVO.class);
				
				if(CommonConstants.COMM_YN_N.equals(batchYn)) {
					//API call log update
					updateCisIfLog(cisApiId, objectMapper.writeValueAsString(vo), vo.getResCd(), vo.getResMsg(), httpStatusCd, logNo);
				}
			}
		}

		return vo;
	}

	/**
	 * [DB]CIS 로그 저장
	 * @param cisApiId
	 * @param reqString
	 * @return
	 */
	public Long insertCisIfLog(String cisApiId, String reqString) {
		return cisIfLogService.insertCisIfLog(cisApiId, reqString, "전송");
	}

	/**
	 * [DB]CIS 로그 수정
	 * @param cisApiId
	 * @param resString
	 * @param resCd
	 * @param resMsg
	 * @param httpStatusCd
	 * @param logNo
	 * @return
	 * @throws Exception
	 */
	public Long updateCisIfLog(String cisApiId, String resString, String resCd, String resMsg, String httpStatusCd, Long logNo) throws Exception{
		return cisIfLogService.updateCisIfLog(cisApiId, resString, "응답완료", resCd, resMsg, httpStatusCd, logNo);
	}
	
	
	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: CisGoodsServiceImpl.java
	* - 작성일	: 2021. 4. 7.
	* - 작성자 	: valfac
	* - 설명 		: 브랜드 등록/수정
	* </pre>
	*
	* @param po
	* @return
	*/
	@Transactional(propagation = Propagation.REQUIRES_NEW)
	public CisBrandVO sendBrand(BrandBasePO brandPO, String type) throws Exception{
		
		// cis 전송
		String cisApiId;
		CisApiSpec specId;
		
		if(StringUtils.equals(type, "I")) {
			cisApiId = CommonConstants.CIS_API_ID_IF_R_INSERT_BRAND_INFO;
			specId = CisApiSpec.IF_R_INSERT_BRAND_INFO;
		} else {
			cisApiId = CommonConstants.CIS_API_ID_IF_R_UPDATE_BRAND_INFO;
			specId = CisApiSpec.IF_R_UPDATE_BRAND_INFO;
		}
		
		ObjectMapper objectMapper = new ObjectMapper();
		CisBrandVO vo = new CisBrandVO();
		CisBrandPO po = new CisBrandPO();
		
		po.setBrndNo(Long.valueOf(brandPO.getBndNo()).intValue());
		po.setBrndNm(brandPO.getBndNmKo());
		po.setUseYn(brandPO.getUseYn());

		objectMapper.setSerializationInclusion(JsonInclude.Include.NON_EMPTY);
		
		//API call log insert
		Long logNo = insertCisIfLog(cisApiId, objectMapper.writeValueAsString(po));

		//API call
		ApiResponse ar = null;
		String httpStatusCd = CommonConstants.CIS_API_SUCCESS_HTTP_STATUS_CD;
		Map<String, String> mapParam = objectMapper.readValue(objectMapper.writeValueAsString(po), Map.class);

		try {
			ar = apiClient.getResponse(specId, mapParam);
		}catch(CustomException ce) {
			httpStatusCd = ce.getExCode();
			vo.setResCd(ce.getExCode());
		}
			
		//Response set
		if(ar != null) {
			ObjectNode on = (ObjectNode) ar.getResponseJson();
			
			if(!on.has("resCd") && on.has("resMsg") && !StringUtils.isEmpty(on.get("resMsg").getValueAsText())) {
				updateCisIfLog(cisApiId, ar.getResponseBody(), on.get("resCd").getValueAsText(), on.get("resMsg").getValueAsText(), httpStatusCd, logNo);
				vo.setResMsg(on.get("resMsg").getValueAsText());
			}else {
				vo = objectMapper.readValue(ar.getResponseBody(), CisBrandVO.class);
				updateCisIfLog(cisApiId, objectMapper.writeValueAsString(vo), vo.getResCd(), vo.getResMsg(), httpStatusCd, logNo);
			}
		} else {
			updateCisIfLog(cisApiId, null, vo.getResMsg(), vo.getResMsg(), httpStatusCd, logNo);
		}

		return vo;
	}
}
