package framework.common.util;


import java.io.UnsupportedEncodingException;
import java.lang.reflect.Field;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.Set;

import org.apache.commons.httpclient.HttpStatus;
import org.apache.commons.lang.StringEscapeUtils;
import org.apache.http.client.HttpClient;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.poi.ss.formula.functions.Vlookup;
import org.codehaus.jackson.JsonNode;
import org.codehaus.jackson.map.ObjectMapper;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.http.client.HttpComponentsClientHttpRequestFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.client.HttpStatusCodeException;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.databind.MapperFeature;

import framework.cis.model.response.ApiResponse;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.enums.CisApiSpec;
import framework.common.enums.SearchApiSpec;
import framework.common.exception.CustomException;
import framework.common.model.IBrickSearchFilterSO;
import framework.common.model.IBrickSearchSO;
import framework.common.nameStrategy.UpperNameStrategy;
import lombok.extern.slf4j.Slf4j;


@Component
@Slf4j
public class SearchApiUtil {
    @Autowired
    private Properties bizConfig;

    // api 호출
	public String getResponse(SearchApiSpec spec, Map<String,String> param) {
        try {
            HttpEntity<?> entity;
            ResponseEntity<String> responseEntity;
            String serverUrl = bizConfig.getProperty(spec.getApiUrl()) ;

            // $#39; -> ' 로 변환
//            if (param.containsKey("KEYWORD")) {
//            	String searchTxt = param.get("KEYWORD");
//            	if (StringUtil.isNotEmpty(searchTxt)) {
//            		searchTxt = StringUtil.replaceAll(searchTxt, "&#39;", "'");
//            		param.put("KEYWORD", searchTxt);
//            	}
//            	
//            }

            if (spec.getHttpMethod() == HttpMethod.POST) {
            	
            	if(SearchApiSpec.SRCH_API_IF_SEARCH.equals(spec)) {
            		IBrickSearchSO ibso = getObj(param);
            		ObjectMapper mapper = new ObjectMapper();
            		mapper.setPropertyNamingStrategy(new UpperNameStrategy());
            		String jsonInput = mapper.writeValueAsString(ibso);
            		
            		entity = new HttpEntity<String>(jsonInput, getHeaders(spec));
            	}else if (SearchApiSpec.SRCH_API_IF_AUTOCOMPLETE.equals(spec)) {
            		// POST 방식으로 변경됨에 따른 수정
            		param.put("SERVICENAME", "autocomplete");
            		entity = new HttpEntity<Map<String, String>>(param, getHeaders(spec));
            	}else if (SearchApiSpec.SRCH_API_IF_POPQUERY.equals(spec)) {
            		// POST 방식으로 변경됨에 따른 수정
            		param.put("SERVICENAME", "popquery");
            		entity = new HttpEntity<Map<String, String>>(param, getHeaders(spec));
            	}else if (SearchApiSpec.SRCH_API_IF_RECOMMEND_KEYWORD.equals(spec)) {
            		// POST 방식으로 변경됨에 따른 수정
            		param.put("SERVICENAME", "recommend_keyword");
            		entity = new HttpEntity<Map<String, String>>(param, getHeaders(spec));
            	}else {
            		entity = new HttpEntity<Map<String, String>>(param, getHeaders(spec));
            	}
            } else {
            	serverUrl += getStringFromRequestParam(param);
                entity = new HttpEntity<>(getHeaders(spec));
            }
			if (log.isInfoEnabled()) {
				log.info("SearchApi getApiId : {}", spec.getApiId());
				log.info("SearchApi getApiUrl : {}", serverUrl);
	            log.info("SearchApi Request Header :{}", entity.getHeaders());
	            log.info("SearchApi Request body :{}", entity.getBody());
			}            

            HttpComponentsClientHttpRequestFactory factory = new HttpComponentsClientHttpRequestFactory();
            factory.setConnectTimeout(300*1000); // 읽기시간초과, ms
            factory.setReadTimeout(300*1000); // 연결시간초과, ms       

            HttpClient httpClient = HttpClientBuilder.create()
                    .setMaxConnTotal(300)   // connection pool 적용
                    .setMaxConnPerRoute(20)  // connection pool 적용
                    .build();
                factory.setHttpClient(httpClient); // 동기실행에 사용될 HttpClient 세팅
            
            RestTemplate restTemplate = new RestTemplate(factory);
            responseEntity = restTemplate.exchange(serverUrl, spec.getHttpMethod(), entity, String.class);
            return responseEntity.getBody();

        } catch (HttpStatusCodeException e) {

            log.error("################ SEARCH API HttpStatusCodeException #####################");
            log.error("{}", e.getStatusCode());
//            switch (e.getStatusCode().value()) {
//                case HttpStatus.SC_BAD_REQUEST:
//                    throw new CustomException(ExceptionConstants.ERROR_API_BAD_REQUEST);
//                case HttpStatus.SC_FORBIDDEN:
//                    throw new CustomException(ExceptionConstants.ERROR_API_FORBIDDEN);
//                case HttpStatus.SC_NOT_FOUND:
//                    throw new CustomException(ExceptionConstants.ERROR_API_NOT_FOUND);
//                case HttpStatus.SC_METHOD_NOT_ALLOWED:
//                    throw new CustomException(ExceptionConstants.ERROR_API_METHOD_NOT_ALLOWED);
//                case HttpStatus.SC_NOT_ACCEPTABLE:
//                    throw new CustomException(ExceptionConstants.ERROR_API_NOT_ACCEPTABLE);
//                default:
//                    throw new CustomException(ExceptionConstants.ERROR_API_UNKNOWN);
//            }
       		return null;
        } catch (Exception e) {
        
            log.error("################ SEARCH API Exception #####################");
            log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
//            throw new CustomException(ExceptionConstants.ERROR_API_UNKNOWN);
        	return null;
        }
        
    }
    
    //Header 가져오기
    private HttpHeaders getHeaders(SearchApiSpec spec) {
        HttpHeaders headers = new HttpHeaders();
        headers.set("Content-Type", spec.getContentType());

        return headers;
    }
    
    //요청 파라미터->String 변환
    private String getStringFromRequestParam(Map<String,String> param){
        StringBuilder str = new StringBuilder();
        Set<String> keys = param.keySet();
        for(String key : keys){
        	str.append("&"+key+"=");
        	str.append(param.get(key));
        }
        //log.info("-> RequestParam : \n {}",str);
        return str.toString();
    }
    
    // 파람 obj 변경
    private IBrickSearchSO getObj(Map<String,String> param) {
    	IBrickSearchSO ibso = new IBrickSearchSO();
    	param.forEach((key, value) -> {
			if(key.equals("KEYWORD")) {
				value = StringEscapeUtils.unescapeHtml(value);
				ibso.setKEYWORD(value);
			}else if(key.equals("INDEX")) {
				ibso.setINDEX(value);
			}else if(key.equals("TARGET_INDEX")) {	
				ibso.setTARGET_INDEX(value);
			}else if(key.equals("SORT")) {	
				ibso.setSORT(value);
			}else if(key.equals("FROM")) {	
				ibso.setFROM(value);
			}else if(key.equals("SIZE")) {	
				ibso.setSIZE(value);
			}else if(key.equals("PET_GB_CD")) {
				ibso.setPET_GB_CD(value.split(","));
			}else if(key.equals("BND_NO")) {
				ibso.setBND_NO(value.split(","));
			}else if(key.equals("FILTER")) {
				List<IBrickSearchFilterSO> soList = new ArrayList<IBrickSearchFilterSO>();
				String thisValue = value.replaceAll("&quot;", "\"");
				com.fasterxml.jackson.databind.ObjectMapper jacksonMapper =  new com.fasterxml.jackson.databind.ObjectMapper().configure(MapperFeature.ACCEPT_CASE_INSENSITIVE_PROPERTIES, true);
				try {
					soList = Arrays.asList(jacksonMapper.readValue(thisValue, IBrickSearchFilterSO[].class));
				}catch (Exception e) {
					log.error(e.getMessage());
				}
				ibso.setFILTER(soList);
			}else if(key.equals("WEB_MOBILE_GB_CD")){
				ibso.setWEB_MOBILE_GB_CD(value);
			}else if(key.equals("CATEGORY")){
				ibso.setCATEGORY(value);
			}
		});
    	return ibso;
    }
}
