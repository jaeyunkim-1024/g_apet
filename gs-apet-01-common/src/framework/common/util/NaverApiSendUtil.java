package framework.common.util;

import framework.common.model.NaverApiVO;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.codehaus.jackson.map.ObjectMapper;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.*;
import org.springframework.http.client.HttpComponentsClientHttpRequestFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;
import javax.servlet.http.HttpServletRequest;
import java.io.*;
import java.net.URI;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

@Slf4j
@Component
public class NaverApiSendUtil {

    @Autowired
    public Properties bizConfig;

    /** 응답 결과 : SUCCESS */
    public static final String API_SUCCESS = "SUCCESS";
    /** 응답 결과 : FAIL */
    public static final String API_FAIL = "FAIL";


    /**API 인가용 key명*/
    public static final String API_KEY = "stm-api-key";
    /**store 인가용 key명*/
    public static final String AFFILIATE_SELLER_KEY = "affiliate-seller-key";
    public static final String CONTENT_TYPE_APPLICATION_JSON = "application/json";



    /** == 제휴사회원식별번호 == */
    public static final  String AFFILIATE_MEMBER_ID_NO = "affiliateMemberIdNo";
    /** == 네이버회원식별번호 ( == Npay 회원 번호) == */
    public static final  String INTERLOCK_MEMBER_ID_NO = "interlockMemberIdNo";
    /** == 제휴사연동스토어(브랜드)번호 == */
    public static final  String INTERLOCK_SELLER_NO = "interlockSellerNo";
    /** 토큰 */
    public static final  String TOKEN = "token";
    /** == 연동상태 == */
    public static final  String INTERLOCK = "interlock";
    /** == API 결과 == */
    public static final  String CONTENTS = "contents";
    /** == 실행결과 == */
    public static final  String OPERATION_RESULT = "operationResult";
    /** == 실행결과 메시지== */
    public static final  String OPERATION_RESULT_MSG = "operationResultMsg";

    /** == 네이버회원정보 / 제휴회원연동 매핑요청 / 제휴회원연동 매핑삭제 API URL == */
    public static final String NIF_1_2_4_URL = "/affiliate/marketing-members/interlock";
    /** == 제휴회원연동 매핑조회 API URL == */
    public static final String NIF_3_URL = "/affiliate/marketing-members/status";
    /** == 제휴회원연동완료 callback 웹페이지 API URL  == */
    public static final String NIF_5_URL = "/affiliate/callback";
    /** == 펫윈도 펫정보 URL  == */
    public static final String PET_INFO_URL = "/nsw-pet-partners/pets";

    public static final String API_RES_MEMBER_INTERLOCK_NORMAL = "회원연동 상태가 정상입니다.";
    public static final String API_RES_MEMBER_INTERLOCK_JOIN_SUCCESS = "회원연동이 정상적으로 완료되었습니다.";
    public static final String API_RES_WRONG_ENCRYPTION = "잘못된 암호화 정보입니다.";
    public static final String API_RES_INTERNAL_ENCRYPTION_PROBLEM = "내부 암호화를 진행하는 동안 문제가 발생했습니다.";
    public static final String API_RES_NO_MEMBER_INFO = "회원 연동 정보가 없습니다.";
    public static final String API_RES_METHOD_NOT_ALLOWED = "요청에 지정된 방법을 사용할 수 없습니다. POST만 사용가능합니다.";
    public static final String API_RES_NO_AUTH_KEY = "인증키(stm-api-key) 정보가 없습니다.";
    public static final String API_RES_INVALIDE_AUTH_KEY = "유효하지 않은 인증키(authKey) 입니다.";
    public static final String API_RES_INVALIDE_INTERLOCK_SELLER_NO = "유효하지 제휴사연동스토어 번호 입니다.";
    public static final String API_RES_NO_PET_INFO = "요청한 회원의 반려동물 정보가 없습니다.";
    public static final String API_RES_NO_AFFILIATE_MEMBER_ID_NO = "제휴사회원식별번호가 없습니다.";
    public static final String API_RES_REQ_SUCCESS = "요청 처리가 정상적으로 수행되었습니다.";
    public static final String MESSAGE = "message";
    public static final String STATUS = "status";

    public ObjectMapper mapper;

    public NaverApiSendUtil(){
        log.info("==> NaverApiSendUtil default constructor");
        mapper = new ObjectMapper();
    }

    /**
     * <p>
     *     헤더정보 확인
     *     - Authorization 유효정보 확인
     * </p>
     */
    public Map<String, Object> checkApiKey(HttpServletRequest request){
        HashMap<String, Object> resultMap = new HashMap<>();
        Enumeration<String> headers = request.getHeaderNames();
        String apiKey = "";
        while (headers.hasMoreElements()){
            String headerName = headers.nextElement();
            String value = request.getHeader(headerName);
            log.info("==> key : " + headerName + " / value : " + value);

            if(StringUtils.equals(headerName, API_KEY)){
                apiKey = value;
            }
        }

        if(apiKey == null || StringUtils.isEmpty(apiKey)){
            resultMap.put(MESSAGE, API_RES_NO_AUTH_KEY);
            resultMap.put(STATUS, HttpStatus.UNAUTHORIZED);
            return resultMap;
        }

        if(!StringUtils.equals(apiKey, bizConfig.getProperty("naver.stm.api.key"))){
            resultMap.put(MESSAGE, API_RES_INVALIDE_AUTH_KEY);
            resultMap.put(STATUS, HttpStatus.UNAUTHORIZED);
            return resultMap;
        }

        resultMap.put(MESSAGE, "");
        return resultMap;
    }

    public ResponseEntity<String> getApiResponse(NaverApiVO vo){

        HttpComponentsClientHttpRequestFactory factory = new HttpComponentsClientHttpRequestFactory();
        factory.setConnectTimeout(5*1000); // 연결시간초과, ms
        factory.setReadTimeout(30*1000); // 읽기시간초과, ms
        RestTemplate restTemplate = new RestTemplate(factory);

        ResponseEntity<String> responseEntity;

        HttpHeaders requestHeaders = new HttpHeaders();
        requestHeaders.add(HttpHeaders.CONTENT_TYPE, vo.getHeaderContentType());

        // api 인가용 key
        if(StringUtils.isNotEmpty(vo.getHeaderApiKey())){
            requestHeaders.add(API_KEY, vo.getHeaderApiKey());
        }

        // store 인가용 key
        if(StringUtils.isNotEmpty(vo.getHeaderAffiliateSellerKey())){
            requestHeaders.add(AFFILIATE_SELLER_KEY, vo.getHeaderAffiliateSellerKey());
        }

        URI baseUrl = null;
        HttpEntity entity = null;

        if(vo.getHttpMethod() == HttpMethod.POST){
            baseUrl = UriComponentsBuilder.fromUriString(vo.getTargetUrl()).build().toUri();
            entity = new HttpEntity(getParamString(vo.getRequestParamByPost()), requestHeaders);
        }else if(vo.getHttpMethod() == HttpMethod.GET){
            baseUrl = UriComponentsBuilder.fromUriString(vo.getTargetUrl()).queryParams(vo.getRequestParamByGet()).build().toUri();
            entity = new HttpEntity(requestHeaders);
        }

        log.info("====================================");
        log.info("==> String.valueOf(baseUrl) : {}", String.valueOf(baseUrl));
        log.info("====================================");

        responseEntity = restTemplate.exchange(baseUrl, vo.getHttpMethod(), entity, String.class);

        log.info("==> responseEntity.getStatusCode :"+ responseEntity.getStatusCode());
        log.info("==> responseEntity.getBody() :"+responseEntity.getBody());

        return responseEntity;

    }

    public JSONObject jsonParse(String jsonStr) {
        JSONParser jsonParser = new JSONParser();
        Object obj = null;
        try {
            obj = jsonParser.parse(jsonStr);
        } catch (ParseException e) {
            log.error("==> [ERROR]  json parse : {}", e.getMessage());
        }
        return (JSONObject) obj;
    }

    public String getParamString(Object obj){
        Map<String, Object> map = convertToMap(obj, Map.class);
        String result=null;
        try {
            result = mapper.writeValueAsString(map);
        } catch (IOException e) {
            log.error("==> [ERROR]  {}", e.getMessage());
        }
        return result;
    }

    public <S> S convertToMap(Object obj, Class<S> type2){
        return mapper.convertValue(obj, type2);
    }

    public void printLog(Map<String, Object> pmap){
        log.error("[not error] log용 ===========================================");
        if(pmap != null){
            for(Map.Entry<String, Object> entry : pmap.entrySet()){
                log.error("==> entry.getKey() : {}", entry.getKey());
                log.error("==> entry.getValue() : {}", entry.getValue());
            }
        }else{
            log.error("==> 데이터가 존재하지 않습니다.");
        }
        log.error("=======================================================");
    }
}
