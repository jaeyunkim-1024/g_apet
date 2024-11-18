package admin.web.view.goods.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import biz.app.goods.model.GoodsCisPO;
import biz.app.goods.model.GoodsCisSO;
import biz.app.goods.model.GoodsCisVO;
import biz.app.goods.model.GoodsSkuBasePO;
import biz.app.goods.service.GoodsCisService;
import biz.app.goods.service.GoodsSkuService;
import framework.common.constants.CommonConstants;
import framework.common.util.DateUtil;
import lombok.extern.slf4j.Slf4j;


/**
 * 단품 상품 CIS MOCK
 * CIS에 API 제공.
 */
@Slf4j
@RestController
@RequestMapping(value = "/interface")
public class GoodsCisController {
	
	@Autowired
	private Properties bizConfig;

	@Autowired
	private GoodsCisService goodsCisService;

	@Autowired 
	private GoodsSkuService goodsSkuService;

	/**
	 * 단품 상품 조회(cis)
	 * Mock param.sample()의 데이터를 호출한다.
	 * @author yjs01
	 */
	@RequestMapping(value = "/goods/cis/info.do", method = RequestMethod.GET)
	public ResponseEntity<?> getGoodsCisInfo(HttpServletRequest request) throws Exception{
		GoodsCisSO param = new GoodsCisSO().sample();
		log.info("getGoodsCisInfo start param : {}", param);

		GoodsCisVO vo = goodsCisService.getGoodsCisInfo(param.sample());
		return new ResponseEntity<>(vo, HttpStatus.OK);
	}
	
	/**
	 * 단품 상품 등록(cis)
	 * Mock param.sample()의 데이터를 호출한다.
	 * @author yjs01
	 */
	@RequestMapping(value = "/goods/cis/insert.do", method = RequestMethod.GET)
	public ResponseEntity<?> insertGoodsCis(HttpServletRequest request
			, @RequestParam(name = "skuCd", required = false) String skuCd) throws Exception{
		GoodsCisPO param = new GoodsCisPO().sample();
		log.info("insertGoodsCis start param : {}", param);
		if(skuCd != null) {
			param.setSkuCd(skuCd);
			param.setStrdCd(skuCd);
		}
		GoodsCisVO.GoodsCisRes vo = goodsCisService.insertGoodsCis(param);
		return new ResponseEntity<>(vo, HttpStatus.OK);
	}
	
	/**
	 * 단품 상품 수정(cis)
	 * Mock param.sample()의 데이터를 호출한다.
	 * @author yjs01
	 */
	@ResponseBody
	@RequestMapping(value = "/goods/cis/update.do", method = RequestMethod.GET)
	public ResponseEntity<?> updateGoodsCis(HttpServletRequest request) throws Exception{
		GoodsCisPO param = new GoodsCisPO().sample();
		log.info("updateGoodsCis start param : {}", param);

		GoodsCisVO.GoodsCisRes vo = goodsCisService.updateGoodsCis(param);
		return new ResponseEntity<>(vo, HttpStatus.OK);
	}
	
	
	/**
	 *  [API] cis에서 호출하는 재고 수량 업데이트
	 */
	@ResponseBody
	@RequestMapping(value = "/goods/cis/apiUpdateGoodsStockQty.do", method = RequestMethod.POST)
	public ResponseEntity<String> apiUpdateGoodsStockQty( @RequestBody Map<String, Object> param, HttpServletRequest request ) {

		log.error("----------------- [ START ] apiUpdateGoodsStockQty -----------------");
		log.error("apiUpdateGoodsStockQty param: " +  param);
		
		Map<String, Object> resultMapBody = new HashMap<String, Object>();
		int requestApiGoodsCount = 0;
		int successCount = 0;
		int failCount = 0;
		
		resultMapBody.put("status", "200");
		resultMapBody.put("message", "");
		resultMapBody.put("requestGoodsCount", Integer.toString(requestApiGoodsCount));
		resultMapBody.put("successCount", Integer.toString(successCount));
		resultMapBody.put("failCount", Integer.toString(failCount));
		
		// 업데이트 되지 않은  goodsId를 저장함.
		ArrayList<String> updateFailGoodsIdList = new ArrayList<String>();
		resultMapBody.put("updateFailGoodsIdList", updateFailGoodsIdList);
		
		HttpHeaders httpHeaders = new HttpHeaders();
		httpHeaders.add("Content-Type", "application/json; charset=UTF-8");
			
		try {	

			if ( param == null ) {
				resultMapBody.put("status", "400");
				resultMapBody.put("message", "Parameter is null");
				resultMapBody.put("requestGoodsCount", Integer.toString(requestApiGoodsCount));
				resultMapBody.put("successCount", Integer.toString(successCount));
				resultMapBody.put("failCount", Integer.toString(failCount));
	
				log.error("400 param null. apiUpdateGoodsStockQty - response : {}", resultMapBody.toString());
				return returnResultEntity(resultMapBody, httpHeaders);
			}
			
			JSONObject paramJSONObject = new JSONObject(param);
			String paramApiKey = (String)paramJSONObject.get("apiKey");	
			String cisApiKey = bizConfig.getProperty("cis.api.key.mdm");
			
			if ( ! StringUtils.equals( cisApiKey, paramApiKey ) ) {
				resultMapBody.put("status", "400");
				resultMapBody.put("message", "APIKEY not correct.");
				resultMapBody.put("requestGoodsCount", Integer.toString(requestApiGoodsCount));
				resultMapBody.put("successCount", Integer.toString(successCount));
				resultMapBody.put("failCount", Integer.toString(failCount));
				
				log.error("400 api key error. apiUpdateGoodsStockQty - response : {}", resultMapBody.toString());
				return returnResultEntity(resultMapBody, httpHeaders);
			}
	
			ArrayList<Map> itemList =(ArrayList<Map>)paramJSONObject.get("itemList");
			
			if ( itemList == null  || itemList.size() == 0) {
				resultMapBody.put("status", "400");
				resultMapBody.put("message", "Parameter ==>> itemList is null or size() is 0");
				resultMapBody.put("requestGoodsCount", Integer.toString(requestApiGoodsCount));
				resultMapBody.put("successCount", Integer.toString(successCount));
				resultMapBody.put("failCount", Integer.toString(failCount));
				
				log.error("400 itemList is null. apiUpdateGoodsStockQty - response : {}", resultMapBody.toString());
				return returnResultEntity(resultMapBody, httpHeaders);
			}
			
			// CIS에서 요청한 총 업데이트 요청 개수
			requestApiGoodsCount = itemList.size(); 
			
			for ( int i=0; i< itemList.size(); i++ ) {
				
				Map<String, Object> item = (Map<String, Object>)itemList.get(i);
				
				// CIS에서 skuCd키로 GoodsId를 준다. 혼돈하지 말것 !! {"skuCd" : "GI123456"}
				if ( StringUtils.isEmpty( (String)item.get("skuCd")) ) {
					resultMapBody.put("status", "400");
					resultMapBody.put("message", "goodsId is Empty.");
					resultMapBody.put("requestGoodsCount", Integer.toString(requestApiGoodsCount));
					resultMapBody.put("successCount", Integer.toString(successCount));
					resultMapBody.put("failCount", Integer.toString(failCount));
					
					log.error("400 goodsId is empty. apiUpdateGoodsStockQty - response : {}", resultMapBody.toString());
					return returnResultEntity(resultMapBody, httpHeaders);
				}
	
				if (item.get("stockAbl") == null ) {
					resultMapBody.put("status", "400");
					resultMapBody.put("message", "stockAbl is null. skuCd(goodsId) is " + item.get("skuCd") );
					resultMapBody.put("requestGoodsCount", Integer.toString(requestApiGoodsCount));
					resultMapBody.put("successCount", Integer.toString(successCount));
					resultMapBody.put("failCount", Integer.toString(failCount));
					updateFailGoodsIdList.add((String)item.get("skuCd"));
					
					log.error("400 stockAbl is null. apiUpdateGoodsStockQty - response : {}", resultMapBody.toString());
					return returnResultEntity(resultMapBody, httpHeaders);
				}
				
				// 재고 수량
				Object stockAblObj = item.get("stockAbl");
		
				if ( stockAblObj instanceof Integer ) { // 재고값을 숫자로 입력 했을때 . 10, 22 ..
					if ( StringUtils.isEmpty(stockAblObj.toString()) ) {
						
						resultMapBody.put("status", "400");
						resultMapBody.put("message", "stockAbl is empty. skuCd(=GoodsId) is " + item.get("skuCd") );
						resultMapBody.put("requestGoodsCount", Integer.toString(requestApiGoodsCount));
						resultMapBody.put("successCount", Integer.toString(successCount));
						resultMapBody.put("failCount", Integer.toString(failCount));
						updateFailGoodsIdList.add((String)item.get("skuCd"));
						
						log.error("400 stockAbl(Integer) is empty. apiUpdateGoodsStockQty - response : {}", resultMapBody.toString());
						return returnResultEntity(resultMapBody, httpHeaders);
					}
				} else if ( stockAblObj instanceof String ) { // 재고값을 String으로 줬을때 에러처리. "", "10" .... 
					
					resultMapBody.put("status", "400");
					resultMapBody.put("message", "stockAbl type is String. stockAble type must be int.  skuCd(=goodsId) is " + item.get("skuCd") );
					resultMapBody.put("requestGoodsCount", Integer.toString(requestApiGoodsCount));
					resultMapBody.put("successCount", Integer.toString(successCount));
					resultMapBody.put("failCount", Integer.toString(failCount));
					updateFailGoodsIdList.add((String)item.get("skuCd"));
					
					log.error("400 stockAbl(String) is emptyapiUpdateGoodsStockQty - response : {}", resultMapBody.toString());
					return returnResultEntity(resultMapBody, httpHeaders);
				}
			
				// CIS에서 skuCd키로 GoodsId를 준다. 혼돈하지 말것 !! {"skuCd" : "GI123456"}
				String goodsId = (String)item.get("skuCd"); 
				int stockAbl = ((Integer)item.get("stockAbl")).intValue();
	
				GoodsSkuBasePO po = new GoodsSkuBasePO();
				po.setGoodsId(goodsId);
				po.setStkQty(stockAbl);
				po.setSysUpdrNo(CommonConstants.COMMON_BATCH_USR_NO);
				po.setSysRegDtm(DateUtil.getTimestamp());
	
				try {
					if( StringUtils.isNotEmpty(goodsId) ) {
						
						int result = goodsSkuService.updateSkuBase(po);
		
						if(result > 0) {
							successCount++;
							// log.error("정상 DB업데이트 GOODS_ID={} : 수량={}", goodsId, Integer.toString(stockAbl));
						} else {
							failCount++;
							updateFailGoodsIdList.add(goodsId);
							log.error("!!업데이트 안됨!!. 예를들어  1) ITEM 테이블에 goods_id가 없을 수 있음. 2) SKU_BASE 테이블에 ITEM 테이블의 sku_cd가 없을 수 있음.  GOODS_ID={} : 수량={}", goodsId, Integer.toString(stockAbl));
						}
					}
					
				} catch (Exception e) {
					
					failCount++;
					
					log.error("API 내부 500 에러 발생 . GOODS_ID={} : 수량={}", goodsId, Integer.toString(stockAbl) );
					log.error ("에러 메시지: ", e);
					
					resultMapBody.put("status", "500");
					resultMapBody.put("message", "Internal Server Error at updating at goodsId:" + goodsId );
					resultMapBody.put("requestGoodsCount", Integer.toString(requestApiGoodsCount));
					resultMapBody.put("successCount", Integer.toString(successCount));
					resultMapBody.put("failCount", Integer.toString(failCount));
					
					log.error("500. server error. apiUpdateGoodsStockQty - response : {}", resultMapBody.toString());
					return returnResultEntity(resultMapBody, httpHeaders);
				}	
			}
				
			resultMapBody.put("status", "200");
			resultMapBody.put("message", "API Updating success.");
			resultMapBody.put("requestGoodsCount", Integer.toString(requestApiGoodsCount));
			resultMapBody.put("successCount", Integer.toString(successCount));
			resultMapBody.put("failCount", Integer.toString(failCount));
			
			log.error("[정상응답] apiUpdateGoodsStockQty - response : {}", resultMapBody.toString());
			log.error("----------------- [ END ] apiUpdateGoodsStockQty -----------------");
			
			return returnResultEntity(resultMapBody, httpHeaders);
		
		} catch (Exception e) {
			
			log.error("API apiUpdateGoodsStockQty함수에서  에러 발생 ." );
			log.error ("에러 메시지: ", e);
			
			Map<String, Object> result = new HashMap<String, Object>();
			result.put("status", "500");
			result.put("message", "Internal Server Error at apiUpdateGoodsStockQty()" );
			
			HttpHeaders header = new HttpHeaders();
			httpHeaders.add("Content-Type", "application/json; charset=UTF-8");
			
			return new ResponseEntity( new JSONObject(result), header, HttpStatus.OK );
				
		}
		

	}
	
	public ResponseEntity<String> returnResultEntity( Map<String, Object> resultMapBody , HttpHeaders httpHeaders) {
		
		try {
			
			return new ResponseEntity( new JSONObject(resultMapBody), httpHeaders, HttpStatus.OK );
			
		} catch (Exception e) {
			
			log.error("API returnResultEntity함수에서  에러 발생 ." );
			log.error ("에러 메시지: ", e);
			
			Map<String, Object> result = new HashMap<String, Object>();
			result.put("status", "500");
			result.put("message", "Internal Server Error at returnResultEntity()" );
			
			HttpHeaders header = new HttpHeaders();
			httpHeaders.add("Content-Type", "application/json; charset=UTF-8");
			
			return new ResponseEntity( new JSONObject(result), header, HttpStatus.OK );
			
		}
		
	}
    
	
}
