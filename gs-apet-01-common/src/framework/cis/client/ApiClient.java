package framework.cis.client;

import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import org.apache.commons.httpclient.HttpStatus;
import org.apache.commons.lang3.StringUtils;
import org.codehaus.jackson.JsonNode;
import org.codehaus.jackson.JsonProcessingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.json.XML;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.http.client.HttpComponentsClientHttpRequestFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.client.HttpStatusCodeException;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;

import framework.cis.model.request.ApiRequest;
import framework.cis.model.response.ApiResponse;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.enums.CisApiSpec;
import framework.common.exception.CustomException;
import lombok.extern.slf4j.Slf4j;
import net.minidev.json.JSONObject;
import net.sf.json.JSONException;

/* <pre>
* - 프로젝트명	: 01.common
* - 패키지명	: framework.cis
* - 파일명		: ApiClient.java
* - 작성자		: valueFactory
* - 설명		:
* </pre>
*/
@Component
@Slf4j
public class ApiClient {

	@Autowired
	private Properties bizConfig;

	@Autowired
	private Properties webConfig;

	public ApiResponse getResponse(CisApiSpec spec, ApiRequest param) {
		return getResponse(spec, param, null, null);
	}
	
	public ApiResponse getResponse(CisApiSpec spec, Map<String, String> param) {
		return getResponse(spec, null, null, param);
	}
	
	public ApiResponse getResponse(CisApiSpec spec, ApiRequest param, List<MultipartFile> fileList, Map<String, String> paramMap) {

		ResponseEntity<String> responseEntity = null;
		try {
			log.info("=================== getResponse ===================");
			ApiResponse result = new ApiResponse();
			HttpEntity<?> entity;
			String serverUrl = bizConfig.getProperty("cis.api.server") + bizConfig.getProperty("cis.api.request.url." + spec.getApiId());
			
			log.info("====================================");
			log.info(serverUrl);
			log.info("====================================");
			if (param != null) {
				param.setApiKey(bizConfig.getProperty("cis.api.key." + spec.getSystemType()));
			}
			HttpHeaders headers = new HttpHeaders();

			// Content-Type 설정
			contentType(spec, headers);
			
//			if (param.getAddHeaders() != null) {
//				for (Map.Entry<String, String> header : param.getAddHeaders().entrySet()) {
//					headers.set(header.getKey(), header.getValue());
//				}
//			}
			if (spec.getHttpMethod() == HttpMethod.POST) {
				if (param != null) {
					entity = new HttpEntity<ApiRequest>(param, headers);
				} else {
					if (!paramMap.containsKey("apiKey")) {
						paramMap.put("apiKey", bizConfig.getProperty("cis.api.key." + spec.getSystemType()));
					}
					entity = new HttpEntity<Map<String, String>>(paramMap, headers);
				}
			} else {
				entity = new HttpEntity<ApiRequest>(headers);
			}
			log.info("Request Header :{}", entity.getHeaders());
			log.info("Request body :{}", entity.getBody());

			ObjectMapper om = new ObjectMapper();
			HttpComponentsClientHttpRequestFactory factory = new HttpComponentsClientHttpRequestFactory();
				factory.setConnectTimeout(60*1000); // 읽기시간초과, ms
				factory.setReadTimeout(60*1000); // 연결시간초과, ms

//			}
//			CloseableHttpClient httpClient = HttpClientBuilder.create()
//					.setMaxConnTotal(100)  // connection pool의 갯수
//					.setMaxConnPerRoute(5)  //  IP, Port 하나 당 연결 제한 갯수
//					.build();
//			factory.setHttpClient(httpClient);
			RestTemplate restTemplate = new RestTemplate(factory);
			responseEntity = restTemplate.exchange(serverUrl, spec.getHttpMethod(), entity, String.class);

			log.info("Response Body {}", responseEntity.getBody());

			JsonNode jsonNode = null;
			
			if (StringUtils.equals(spec.getReturnType(), CommonConstants.CIS_API_RES_JSON)) {
				try {
					jsonNode = om.readTree(responseEntity.getBody());
				} catch (JsonProcessingException e) {
					log.error("{}", e);
					jsonNode = catchSetResult(responseEntity, om);
				} catch (IOException e) {
					log.error("{}", e);
					jsonNode = catchSetResult(responseEntity, om);
				}
				result.setResponseJson(jsonNode);
				result.setResponseBody(responseEntity.getBody());
			} else {
				String xmlToJsonStr = "";
				try {
					xmlToJsonStr = XML.toJSONObject(responseEntity.getBody()).toString();
					jsonNode = om.readTree(xmlToJsonStr);
				} catch (JsonProcessingException | JSONException e) {
					log.error("{}", e);
					jsonNode = catchSetResult(responseEntity, om);
				} catch (IOException e) {
					log.error("{}", e);
					jsonNode = catchSetResult(responseEntity, om);
				}				

				log.info("##### Result Xml convert to JSON Str (field : resposeBody) : \n {}",xmlToJsonStr);
				log.info("##### JsonNode(field : rseponseJson) : \n {} ",jsonNode);				

				result.setResponseJson(jsonNode);
				result.setResponseBody(xmlToJsonStr);
			}

			return result;

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
			case HttpStatus.SC_PROXY_AUTHENTICATION_REQUIRED:
				throw new CustomException(ExceptionConstants.ERROR_API_PROXY_AUTHENTICATION_REQUIRED);
			case HttpStatus.SC_REQUEST_TIMEOUT:
				throw new CustomException(ExceptionConstants.ERROR_API_REQUEST_TIMEOUT);
			case HttpStatus.SC_CONFLICT:
				throw new CustomException(ExceptionConstants.ERROR_API_CONFLICT);
			case HttpStatus.SC_GONE:
				throw new CustomException(ExceptionConstants.ERROR_API_GONE);
			case HttpStatus.SC_LENGTH_REQUIRED:
				throw new CustomException(ExceptionConstants.ERROR_API_LENGTH_REQUIRED);
			case HttpStatus.SC_PRECONDITION_FAILED:
				throw new CustomException(ExceptionConstants.ERROR_API_PRECONDITION_FAILED);
			case HttpStatus.SC_REQUEST_TOO_LONG:
				throw new CustomException(ExceptionConstants.ERROR_API_REQUEST_TOO_LONG);
			case HttpStatus.SC_REQUEST_URI_TOO_LONG:
				throw new CustomException(ExceptionConstants.ERROR_API_REQUEST_URI_TOO_LONG);
			case HttpStatus.SC_UNSUPPORTED_MEDIA_TYPE:
				throw new CustomException(ExceptionConstants.ERROR_API_UNSUPPORTED_MEDIA_TYPE);
			case HttpStatus.SC_REQUESTED_RANGE_NOT_SATISFIABLE:
				throw new CustomException(ExceptionConstants.ERROR_API_REQUESTED_RANGE_NOT_SATISFIABLE);
			case HttpStatus.SC_EXPECTATION_FAILED:
				throw new CustomException(ExceptionConstants.ERROR_API_EXPECTATION_FAILED);
			case HttpStatus.SC_INSUFFICIENT_SPACE_ON_RESOURCE:
				throw new CustomException(ExceptionConstants.ERROR_API_INSUFFICIENT_SPACE_ON_RESOURCE);
			case HttpStatus.SC_METHOD_FAILURE:
				throw new CustomException(ExceptionConstants.ERROR_API_METHOD_FAILURE);
			case HttpStatus.SC_UNPROCESSABLE_ENTITY:
				throw new CustomException(ExceptionConstants.ERROR_API_UNPROCESSABLE_ENTITY);
			case HttpStatus.SC_LOCKED:
				throw new CustomException(ExceptionConstants.ERROR_API_LOCKED);
			case HttpStatus.SC_FAILED_DEPENDENCY:
				throw new CustomException(ExceptionConstants.ERROR_API_FAILED_DEPENDENCY);
			case HttpStatus.SC_INTERNAL_SERVER_ERROR:
				throw new CustomException(ExceptionConstants.ERROR_API_INTERNAL_SERVER_ERROR);
			case HttpStatus.SC_NOT_IMPLEMENTED:
				throw new CustomException(ExceptionConstants.ERROR_API_NOT_IMPLEMENTED);
			case HttpStatus.SC_BAD_GATEWAY:
				throw new CustomException(ExceptionConstants.ERROR_API_BAD_GATEWAY);
			case HttpStatus.SC_SERVICE_UNAVAILABLE:
				throw new CustomException(ExceptionConstants.ERROR_API_SERVICE_UNAVAILABLE);
			case HttpStatus.SC_GATEWAY_TIMEOUT:
				throw new CustomException(ExceptionConstants.ERROR_API_GATEWAY_TIMEOUT);
			case HttpStatus.SC_HTTP_VERSION_NOT_SUPPORTED:
				throw new CustomException(ExceptionConstants.ERROR_API_HTTP_VERSION_NOT_SUPPORTED);
			case HttpStatus.SC_INSUFFICIENT_STORAGE:
				throw new CustomException(ExceptionConstants.ERROR_API_INSUFFICIENT_STORAGE);
			default:
				throw new CustomException(ExceptionConstants.ERROR_API_UNKNOWN);
			}

		} catch (Exception e) {
			log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
			throw new CustomException(ExceptionConstants.ERROR_API_UNKNOWN);
		}

	}

	private JsonNode catchSetResult(ResponseEntity<String> responseEntity, ObjectMapper om)
			throws IOException, JsonProcessingException {
		JsonNode jsonNode;
		JSONObject jsObj = new JSONObject();
		jsObj.put("resMsg", responseEntity.getBody());
		jsonNode = om.readTree(jsObj.toJSONString());
		return jsonNode;
	}

	private void contentType(CisApiSpec spec, HttpHeaders headers) {
		headers.set("Content-Type", spec.getHeaderType());
	}
}
