package biz.app.goods.service;

import java.util.Map;

import biz.interfaces.cis.service.CisIfLogService;
import org.codehaus.jackson.map.DeserializationConfig;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import biz.app.goods.model.GoodsCisPO;
import biz.app.goods.model.GoodsCisSO;
import biz.app.goods.model.GoodsCisVO;
import framework.cis.client.ApiClient;
import framework.cis.model.response.ApiResponse;
import framework.common.enums.CisApiSpec;

/**
* <pre>
* - 프로젝트명	: gs-apet-11-business
* - 패키지명 	: biz.app.goods.service
* - 파일명 	: GoodsSkuServiceImpl.java
* - 작성일	: 2021. 1. 12.
* - 작성자	: YJS01
* - 설명 		: 단품 상품 CRUD
* </pre>
*/
@SuppressWarnings("unchecked")
@Transactional
@Service("GoodsCisService")
public class GoodsCisServiceImpl implements GoodsCisService {

	@Autowired
	private ApiClient apiClient;

	@Autowired
	private CisIfLogService cisIfLogService;

	/**
	 * 단품 상품 조회 CIS
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@Override
	public GoodsCisVO getGoodsCisInfo(GoodsCisSO param) throws Exception {
		ObjectMapper objectMapper = new ObjectMapper();
		objectMapper.configure(DeserializationConfig.Feature.FAIL_ON_UNKNOWN_PROPERTIES, false);
		Map<String, String> mapParam = new ObjectMapper().readValue(objectMapper.writeValueAsString(param), Map.class);
		ApiResponse on = apiClient.getResponse(CisApiSpec.IF_S_SELECT_SKU_INFO, mapParam);
		GoodsCisVO itemList = objectMapper.readValue(on.getResponseJson(), GoodsCisVO.class);

		return itemList;
	}

	/**
	 * 단품 상품 등록 CIS
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@Override
	public GoodsCisVO.GoodsCisRes insertGoodsCis(GoodsCisPO param) throws Exception {
		ObjectMapper objectMapper = new ObjectMapper();
		objectMapper.configure(DeserializationConfig.Feature.FAIL_ON_UNKNOWN_PROPERTIES, false);
		Map<String, String> mapParam = objectMapper.readValue(objectMapper.writeValueAsString(param), Map.class);
		ApiResponse on = apiClient.getResponse(CisApiSpec.IF_R_INSERT_SKU_INFO, mapParam);
		GoodsCisVO.GoodsCisRes itemList = objectMapper.readValue(objectMapper.writeValueAsString(on.getResponseJson()), GoodsCisVO.GoodsCisRes.class);
		return itemList;
	}

	/**
	 * 단품 상품 수정 CIS
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@Override
	public GoodsCisVO.GoodsCisRes updateGoodsCis(GoodsCisPO param) throws Exception {
		ObjectMapper objectMapper = new ObjectMapper();
		objectMapper.configure(DeserializationConfig.Feature.FAIL_ON_UNKNOWN_PROPERTIES, false);
		Map<String, String> mapParam = objectMapper.readValue(objectMapper.writeValueAsString(param), Map.class);
		ApiResponse on = apiClient.getResponse(CisApiSpec.IF_R_UPDATE_SKU_INFO, mapParam);
		GoodsCisVO.GoodsCisRes itemList = objectMapper.readValue(objectMapper.writeValueAsString(on.getResponseJson()), GoodsCisVO.GoodsCisRes.class);

		return itemList;
	}
}