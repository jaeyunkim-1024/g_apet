package biz.interfaces.nicepay.client;

import java.lang.reflect.Field;
import java.lang.reflect.Modifier;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Date;
import java.util.List;
import java.util.Properties;
import java.util.stream.Collectors;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.httpclient.HttpStatus;
import org.apache.commons.lang3.StringUtils;
import org.json.XML;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.http.client.HttpComponentsClientHttpRequestFactory;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.util.ObjectUtils;
import org.springframework.web.client.HttpStatusCodeException;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.google.common.net.MediaType;
import com.google.gson.Gson;

import biz.interfaces.nicepay.constants.NicePayConstants;
import biz.interfaces.nicepay.model.request.RequestCommonVO;
import biz.interfaces.nicepay.model.response.ResponseCommonVO;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.enums.NicePayApiSpec;
import framework.common.exception.CustomException;
import framework.common.util.CryptoUtil;
import framework.common.util.StringUtil;
import lombok.extern.slf4j.Slf4j;

/**
 * <pre>
 * - 프로젝트명	: gs-apet-11-business
 * - 패키지명	: biz.interfaces.nicepay.client
 * - 파일명		: NicePayClient.java
 * - 작성일		: 2021. 01. 12.
 * - 작성자		: JinHong
 * - 설명		: NicePay Client
 * </pre>
 */
@Slf4j
public class NicePayClient<T extends RequestCommonVO> {

	private Properties bizConfig;
	
	private void setInit(T vo, String midGb) {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		ServletContext context = request.getSession().getServletContext();
		WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(context);

		this.bizConfig = (Properties) wContext.getBean("bizConfig");
		
		if(NicePayConstants.MID_GB_CERTIFY.equals(midGb)) {
			vo.setMID(bizConfig.getProperty("nicepay.api.certify.mid"));
			vo.setMerchanKey(bizConfig.getProperty("nicepay.api.certify.merchant.key"));
		}else if(NicePayConstants.MID_GB_SIMPLE.equals(midGb)) {
			vo.setMID(bizConfig.getProperty("nicepay.api.simple.mid"));
			vo.setMerchanKey(bizConfig.getProperty("nicepay.api.simple.merchant.key"));
		}else if(NicePayConstants.MID_GB_BILLING.equals(midGb)) {
			vo.setMID(bizConfig.getProperty("nicepay.api.billing.mid"));
			vo.setMerchanKey(bizConfig.getProperty("nicepay.api.billing.merchant.key"));
		}else if(NicePayConstants.MID_GB_FIX_ACCOUNT.equals(midGb)){
			vo.setMID(bizConfig.getProperty("nicepay.api.fixaccount.mid"));
			vo.setMerchanKey(bizConfig.getProperty("nicepay.api.fixaccount.merchant.key"));
		}else {
			throw new CustomException(ExceptionConstants.ERROR_PARAM);
		}
		
		Date now = new Date();
		SimpleDateFormat fmt = new SimpleDateFormat("yyyyMMddHHmmss");
		vo.setEdiDate(fmt.format(now));	//(yyyyMMddHHmmss, 14byte)
	}
	
	
	/**
	 * TID 안쓰는 경우
	 * @param vo
	 * @param midGb
	 */
	public NicePayClient(T vo, String midGb) {
		this.setInit(vo, midGb);
		
		Date now = new Date();
		SimpleDateFormat fmt = new SimpleDateFormat("yyyyMMddHHmmss");
		vo.setEdiDate(fmt.format(now));	//(yyyyMMddHHmmss, 14byte)
	}
	
	public NicePayClient(T vo, String midGb, String payMeans, String mediaGb) {
		this.setInit(vo, midGb);
		
		Date now = new Date();
		SimpleDateFormat fmt = new SimpleDateFormat("yyyyMMddHHmmss");
		vo.setEdiDate(fmt.format(now));	//(yyyyMMddHHmmss, 14byte)
		
		if(StringUtils.isEmpty(vo.getTID())) {
			SimpleDateFormat fmt2 = new SimpleDateFormat("yyMMddHHmmss");
			StringBuilder builder = new StringBuilder();
			builder.append(vo.getMID()).	// MID(10byte)
			append(payMeans).		// 지불수단(2byte) 
			append(mediaGb).		// 매체구분(2byte)
			append(fmt2.format(now)).	//시간정보(yyMMddHHmmss, 12byte) 
			append(StringUtil.randomNumeric(4)); //랜덤(4byte)
			vo.setTID(builder.toString());
		}
	}
	
	public <R extends ResponseCommonVO> R getResponse(NicePayApiSpec spec, T param, String signData, Class<R> rtnClass) {
		param.setSignData(CryptoUtil.encryptSHA256(signData));
		return getResponse(spec, param, rtnClass);
	}
	
	/*public <R> R getResponse(NicePayApiSpec spec, Map<String, String> param, Class<R> rtnClass) {
		return getResponse(spec, null, null, param, rtnClass);
	}*/

	private <R extends ResponseCommonVO> R getResponse(NicePayApiSpec spec, T param, Class<R> rtnClass) {
		
		try {
			log.info("=================== getResponse ===================");
			HttpEntity<?> entity;
			ResponseEntity<String> responseEntity;
			String serverUrl = bizConfig.getProperty("nicepay.api.request.url." + spec.getApiId());
			
			log.info("====================================");
			log.info(serverUrl);
			log.info("====================================");
			HttpHeaders headers = new HttpHeaders();

			// Content-Type 설정
			contentType(spec, headers);
			
			if (spec.getHttpMethod() == HttpMethod.POST) {
				if( spec.getHeaderType().contains(MediaType.FORM_DATA.toString())) {
					List<Field> fieldList = getAllFields(param.getClass());
					
					// super class Key=Value 형태
					MultiValueMap<String, String> queryParams = new LinkedMultiValueMap<>();
					
					for(Field field : fieldList) {
						field.setAccessible(true);
						//final 변수 제외
						if ((field.getModifiers() & Modifier.FINAL) != Modifier.FINAL) {
							Object value = field.get(param);
							if (!ObjectUtils.isEmpty(value)) {
								queryParams.add(field.getName(), value.toString());
							}
						}
					}
					
					entity = new HttpEntity<>(queryParams, headers);
				}else {
					if (param != null) {
						entity = new HttpEntity<T>(param, headers);
					}else {
						entity = new HttpEntity<T>(headers);
					}
				}
			} else {
				entity = new HttpEntity<T>(headers);
			}
			log.info("Request Header :{}", entity.getHeaders());
			log.info("Request body :{}", entity.getBody());
			
			HttpComponentsClientHttpRequestFactory factory = new HttpComponentsClientHttpRequestFactory();
				factory.setConnectTimeout(5*1000); // 연결시간초과, ms
				factory.setReadTimeout(30*1000); // 읽기시간초과, ms

			RestTemplate restTemplate = new RestTemplate(factory);
			responseEntity = restTemplate.exchange(serverUrl, spec.getHttpMethod(), entity, String.class);

			log.info("Response Body {}", responseEntity.getBody());
			String body = "";
			 
			if (StringUtils.equals(spec.getReturnType(), CommonConstants.NICEPAY_API_RES_JSON)) {
				body = responseEntity.getBody();
			} else {
				body = XML.toJSONObject(responseEntity.getBody()).toString();
			}
			
			Gson gson = new Gson();
			R res = gson.fromJson(body, rtnClass);
			res.setResponseBody(StringUtils.trim(body));
			
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

	private void contentType(NicePayApiSpec spec, HttpHeaders headers) {
		headers.set("Content-Type", spec.getHeaderType());
	}
	
	@SuppressWarnings("rawtypes")
	private List<Field> getAllFields(Class clazz) {
	    if (clazz == null) {
	        return Collections.emptyList();
	    }

	    List<Field> result = new ArrayList<>(getAllFields(clazz.getSuperclass()));
	    List<Field> filteredFields = Arrays.stream(clazz.getDeclaredFields())
	      .collect(Collectors.toList());
	    result.addAll(filteredFields);
	    return result;
	}
}
