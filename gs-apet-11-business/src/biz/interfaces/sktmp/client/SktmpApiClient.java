package biz.interfaces.sktmp.client;


import java.util.Map;
import java.util.Properties;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.codec.binary.Base64;
import org.apache.commons.httpclient.HttpStatus;
import org.apache.commons.lang3.StringUtils;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.http.client.HttpComponentsClientHttpRequestFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.client.HttpStatusCodeException;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.google.gson.Gson;

import biz.interfaces.sktmp.model.response.ApihubResponseCommonVO;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import framework.common.util.CryptoUtil;
import lombok.extern.slf4j.Slf4j;

@Component
@Slf4j
public class SktmpApiClient {
	
	public static final String CONTENT_TYPE = "application/json;charset=utf-8";
    
	private Properties bizConfig;
	
    @SuppressWarnings({ "unchecked", "unused" })
	public <R extends ApihubResponseCommonVO> R getResponse(String apiId, Object param, Class<R> rtnClass) {
    	HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		ServletContext context = request.getSession().getServletContext();
		WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(context);

		this.bizConfig = (Properties) wContext.getBean("bizConfig");
		
		try {
			R res = null;
			log.info("=================== getResponse ===================");
			HttpEntity<?> entity;
			ResponseEntity<String> responseEntity;
			String serverUrl = bizConfig.getProperty("skt.membership.apihub.server").concat("/is/").concat(apiId).concat("/").concat(bizConfig.getProperty("skt.membership.apihub.api.key"));
			
			log.info("====================================");
			log.info(serverUrl);
			log.info("====================================");
			HttpHeaders headers = new HttpHeaders();
			headers.set("Content-Type", CONTENT_TYPE);
			entity = new HttpEntity<Object>(param, headers);
			
			log.info("Request Header :{}", entity.getHeaders());
			log.info("Request body :{}", entity.getBody());
			
			HttpComponentsClientHttpRequestFactory factory = new HttpComponentsClientHttpRequestFactory();
			factory.setConnectTimeout(5000); // 연결시간초과, ms
			factory.setReadTimeout(10000); // 읽기시간초과, ms

			RestTemplate restTemplate = new RestTemplate(factory);
			responseEntity = restTemplate.exchange(serverUrl, HttpMethod.POST, entity, String.class);

			 /** JSON : {"RESPONSE":{"HEADER":{"RESULT_CODE":"00","RESULT":"S","RESULT_MESSAGE":"서비스가 정상적으로 처리되었습니다."},"BODY":"암호화된 String 내용"}}*/
			log.info("Response Body {}", responseEntity.getBody());
			 
			String responseBody = responseEntity.getBody();
			ObjectMapper mapper = new ObjectMapper();
			Map<String, Object> dataMap = null;
			Map<String, Object> data = null;
			Map<String, Object> header = null;
			
			dataMap = mapper.readValue(responseBody, Map.class);
			data = (Map<String, Object>) dataMap.get("RESPONSE");
			if( data != null) {
				header = (Map<String, Object>) data.get("HEADER");
				String result = header.get("RESULT").toString();
				
				if( "S".equals(result) ) {
					String encBody = data.get("BODY").toString();
					String strBody = decrypt(encBody);
					Gson gson = new Gson();
					res = gson.fromJson(strBody, rtnClass);
					res.setRESPONSEBODY(StringUtils.trim(strBody));
				}else {
					res = rtnClass.newInstance();
				}
				
				res.setRESULT(result);
				res.setRESULT_CODE(header.get("RESULT_CODE") == null ? null : header.get("RESULT_CODE").toString());
				res.setRESULT_MESSAGE(header.get("RESULT_MESSAGE") == null ? null : header.get("RESULT_MESSAGE").toString());
			}else {
				//LOG
			}
			
			log.info("RES VO :{}", res.toString());
			return res;

		} catch (HttpStatusCodeException e) {
			log.error("{}", e.getStatusCode());
			switch (e.getStatusCode().value()) {
			case HttpStatus.SC_BAD_REQUEST:
				throw new CustomException(ExceptionConstants.ERROR_API_BAD_REQUEST);
			case HttpStatus.SC_FORBIDDEN:
				throw new CustomException(ExceptionConstants.ERROR_API_FORBIDDEN);
			case HttpStatus.SC_NOT_FOUND:
				throw new CustomException(ExceptionConstants.ERROR_API_NOT_FOUND);
			case HttpStatus.SC_METHOD_NOT_ALLOWED:
				throw new CustomException(ExceptionConstants.ERROR_API_METHOD_NOT_ALLOWED);
			case HttpStatus.SC_NOT_ACCEPTABLE:
				throw new CustomException(ExceptionConstants.ERROR_API_NOT_ACCEPTABLE);
			default:
				throw new CustomException(ExceptionConstants.ERROR_API_UNKNOWN);
			}

		} catch (Exception e) {
			log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
			throw new CustomException(ExceptionConstants.ERROR_API_UNKNOWN);
		}

	}

    private String decrypt(String data) throws Exception {
		byte[] decodeBase64 = Base64.decodeBase64(data);
		return CryptoUtil.decryptApiHub(new String(decodeBase64, "UTF-8"), bizConfig.getProperty("skt.membership.apihub.encrypt.key"));
	}
}
