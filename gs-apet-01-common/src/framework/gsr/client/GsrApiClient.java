package framework.gsr.client;


import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.enums.GsrApiSpec;
import framework.common.exception.CustomException;
import framework.common.util.DateUtil;
import framework.common.util.StringUtil;
import framework.gsr.model.request.GsrApiRequest;
import framework.gsr.model.response.GsrApiResponse;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.http.client.HttpComponentsClientHttpRequestFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;

import java.net.InetAddress;
import java.net.SocketTimeoutException;
import java.net.UnknownHostException;
import java.security.SecureRandom;
import java.util.*;

/* <pre>
 * - 프로젝트명	: 01.common
 * - 패키지명	: framework.cis
 * - 파일명		: GsrApiClient.java
 * - 작성자		: 김재윤
 * - 설명		:
 * </pre>
 */
@Component
@Slf4j
public class GsrApiClient {
    @Autowired
    private Properties bizConfig;

    @Autowired
    private MessageSourceAccessor message;

    private ObjectMapper mapper = new ObjectMapper();

    public Map<String,Object> getResponse(GsrApiSpec spec, Map<String,String> param){
        Map<String,Object> result = new HashMap<>();
        try{
            GsrApiResponse res = getResponse(spec, new GsrApiRequest(bizConfig.get("aboutpet.gsr.div.code").toString(),bizConfig.get("aboutpet.gsr.store.code").toString(),param));
            TypeReference<Map<String, Object>> type = new TypeReference<Map<String,Object>>() {};
            result = mapper.convertValue(res.getResponseJson(),type);
        }catch(NullPointerException npe){
            result.put("result_code",ExceptionConstants.ERROR_GSR_API_NOT_RESPONSE);
            result.put("result_message",message.getMessage("business.exception."+ExceptionConstants.ERROR_GSR_API_NOT_RESPONSE));
            return result;
        }catch(CustomException cep){
            result.put("result_code",cep.getExCode());
            result.put("result_message",message.getMessage("business.exception."+cep.getExCode()));
            return result;
        }catch(SocketTimeoutException ste){
            log.error("########## Read Time Out ");
            result.put("result_code",ExceptionConstants.ERROR_GSR_API_NOT_RESPONSE);
            result.put("result_message",message.getMessage("business.exception."+ExceptionConstants.ERROR_GSR_API_NOT_RESPONSE));
        }catch(Exception e){
            log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE,e);
            result.put("result_code",ExceptionConstants.ERROR_GSR_API_SYSTEM);
            result.put("result_message",message.getMessage("business.exception."+ExceptionConstants.ERROR_GSR_API_SYSTEM));
            return result;
        }

        Boolean isSuccess = !(Arrays.asList(CommonConstants.GSR_RST_OK).indexOf(result.get("result_code").toString()) == -1);

        //성공 시
        if(isSuccess){
            Map<String,Map<String,String>> rows = Optional.ofNullable(
                    (Map<String,Map<String,String>>)result.get("rows") )
                    .orElseGet(
                            ()->new HashMap<String,Map<String,String>>() );

            //회원 정보 조회 일 시, jsonObject에 row 존재
            if(rows.containsKey("row")){
                return (Map)rows.get("row");
            }else{
                return result;
            }
        }else{
            Object resultMeesageObj = Optional.ofNullable(result.get("result_message")).orElseGet(()->"");
            String resultMessage = resultMeesageObj.toString();
            String resultCode = convertResultCode(result.get("result_code").toString());

            Map<String,Object> errorMap = new HashMap<String,Object>();
            errorMap.put("result_code",resultCode);
            errorMap.put("result_message",convertResultMessage(spec.getServiceName(),resultCode,resultMessage));
            return errorMap;
        }
    }

    private String getProxyServerByWasIp(String propertyKey){
        String url = bizConfig.getProperty(propertyKey);
        try {
            InetAddress  local = InetAddress.getLocalHost();
            String serverPrivateIp = local.getHostAddress();

            //운영일 때만, 전용선이 2개인 인프라 환경임.
            if(StringUtil.equals(bizConfig.getProperty("envmt.gb"),CommonConstants.ENVIRONMENT_GB_OPER)){
                String server_instance_2 = bizConfig.getProperty("aboutpet.was.sec.private.ip");
                if(serverPrivateIp.indexOf(server_instance_2)>-1){
                    url = bizConfig.getProperty("gsr.server.url.crm.back.bone");
                }
            }
            log.error(" ########## start-point : {}", serverPrivateIp);
            log.error(" ########## end-point : {}", url);

        } catch (UnknownHostException e) {
            log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE,e);
        }
        return url;
    }

    private GsrApiResponse getResponse(GsrApiSpec spec, GsrApiRequest request) throws SocketTimeoutException {
        String propertyKey = "gsr.server.url." + spec.getSystemType();
        String url = getProxyServerByWasIp(propertyKey);

        String wsdl = bizConfig.getProperty(spec.getWsdl());
        String serverUrl =  url + wsdl;
        String serviceName = bizConfig.getProperty("gsr.request.url." + spec.getServiceName());
        HttpEntity<?> entity = null;
        ResponseEntity<String> responseEntity;
        GsrApiResponse result = new GsrApiResponse(serviceName);

        String responseBody = null;
        ObjectMapper om = new ObjectMapper();
        String xml = "";

        if (spec.getHttpMethod() == HttpMethod.POST) {
            if(StringUtil.equals(spec.getContentType(), CommonConstants.GSR_API_CONTENT_TP) ){
                Map<String,String> param = request.getRequestParam();
                xml = soapXml(param,serviceName);
                entity = new HttpEntity<String>(xml.toString(), header(spec));
            }else{
                entity = null;
            }
        } else {
            entity = new HttpEntity<>(header(spec));
        }
        HttpComponentsClientHttpRequestFactory factory = new HttpComponentsClientHttpRequestFactory();
        factory.setConnectTimeout(10*1000); // 읽기시간초과, ms
        factory.setReadTimeout(10*1000); // 연결시간초과, ms

        if(entity != null){
            if (StringUtil.equals(bizConfig.getProperty("envmt.gb"), CommonConstants.ENVIRONMENT_GB_LOCAL)){
                StringBuilder temp = new StringBuilder();
                log.info("#### 방화벽 ####");
                log.info("#### 로컬에선 연결 할 수 없습니다. ####");
                log.info("#### 로컬에서 테스트 위한 임시 응답값 생성 ####");
                if(StringUtil.equals(serviceName,"customerInfoLoad2")){
                    //고객 조회
                    temp.append("<soap:Envelope xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">");
                    temp.append("<soap:Body><ns2:customerInfoLoad2Response xmlns:ns2=\"http://provider\">");
                    temp.append("<gsc-was><result_code>00000</result_code><result_message>정상</result_message>");
                    temp.append("<rows><row>");
                    temp.append("<cust_no_gs></cust_no_gs>");
                    temp.append("<cust_no>B000007527790</cust_no>");
                    temp.append("<cust_del_yn>N</cust_del_yn>");
                    temp.append("<kor_name>김재윤</kor_name>");
                    temp.append("<gender>M</gender>");
                    temp.append("<bdate>19941024</bdate>");
                    temp.append("<ipin_ci_code>J4QZptySKOrnGE/vS/OvVeV2tuSun81kOwaqE75MGNXLTgFm5U3+1Zi5L/oXZEhp5/N73dQGLJDkKVX80qXnlg==</ipin_ci_code>");
                    temp.append("<ident_status_code>01</ident_status_code>");
                    temp.append("<com_co_div_code></com_co_div_code><ident_lv>01</ident_lv><foreign_yn>N</foreign_yn>");
                    temp.append("<birth_date>19941024</birth_date>");
                    temp.append("<birth_type>1</birth_type>");
                    temp.append("<wed_date></wed_date><wed_type></wed_type>");
                    temp.append("<e_mail></e_mail><e_mail_site></e_mail_site><email_yn>Y</email_yn><dm_yn>Y</dm_yn><dm_type></dm_type>");
                    temp.append("<tel_yn>Y</tel_yn><sms_yn>Y</sms_yn><tel_area></tel_area><tel_kuk></tel_kuk><tel_num></tel_num><tel></tel>");
                    temp.append("<hp1>010</hp1><hp2>3168</hp2><hp3>3430</hp3>");
                    temp.append("<hp>01031683430</hp>");
                    temp.append("<work_name></work_name><work_dept></work_dept><hobby1></hobby1><hobby2></hobby2><hobby3></hobby3>");
                    temp.append("<point>16093636</point>");
                    temp.append("<id></id>");
                    temp.append("<passwd_chg_date></passwd_chg_date>");
                    temp.append("<gs_web_id_yn></gs_web_id_yn>");
                    temp.append("<gsr_contract1>Y</gsr_contract1>");
                    temp.append("<gsr_contract2>Y</gsr_contract2>");
                    temp.append("<gsr_contract3>Y</gsr_contract3>");
                    temp.append("<gsr_contract4></gsr_contract4><gsr_contract5></gsr_contract5><gsr_contract6>Y</gsr_contract6><gsr_contract7></gsr_contract7>");
                    temp.append("<cvs_member_yn>N</cvs_member_yn>");
                    temp.append("<cntr_code>01,02,03,06</cntr_code>");
                    temp.append("<home_input_zip_code></home_input_zip_code><home_input_addr1></home_input_addr1><home_input_addr2></home_input_addr2><home_lot_zip_code></home_lot_zip_code>");
                    temp.append("<home_lot_addr1></home_lot_addr1><home_lot_addr2></home_lot_addr2><home_lot_pnu></home_lot_pnu><home_road_zip_code></home_road_zip_code><home_road_addr1></home_road_addr1><home_road_addr2></home_road_addr2><home_road_ref></home_road_ref><home_road_bldg_no></home_road_bldg_no><home_apt_name></home_apt_name><home_apt_dong></home_apt_dong><home_apt_ho></home_apt_ho><home_input_type></home_input_type><home_return_code></home_return_code><work_input_zip_code></work_input_zip_code><work_input_addr1></work_input_addr1><work_input_addr2></work_input_addr2><work_lot_zip_code></work_lot_zip_code><work_lot_addr1></work_lot_addr1><work_lot_addr2></work_lot_addr2><work_lot_pnu></work_lot_pnu><work_road_zip_code></work_road_zip_code><work_road_addr1></work_road_addr1><work_road_addr2></work_road_addr2><work_road_ref></work_road_ref><work_road_bldg_no></work_road_bldg_no><work_apt_name></work_apt_name><work_apt_dong></work_apt_dong><work_apt_ho></work_apt_ho><work_input_type></work_input_type><work_return_code></work_return_code><cashrcpt_no></cashrcpt_no><rest_reward>0</rest_reward><pay_member_yn>N</pay_member_yn><entp_cust_grade>04</entp_cust_grade><cvs_ace_grade_yn>N</cvs_ace_grade_yn><sm_ace_grade_yn>N</sm_ace_grade_yn><hnb_ace_grade_yn>N</hnb_ace_grade_yn><ecm_ace_grade_yn>N</ecm_ace_grade_yn></row></rows></gsc-was></ns2:customerInfoLoad2Response></soap:Body></soap:Envelope>");
                }else if(StringUtil.equals(serviceName,"pointInfoCustPointSearch")){
                    //포인트 조회
                    temp.append("<soap:Envelope xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">");
                    temp.append("<soap:Body><ns2:pointInfoCustPointSearchResponse xmlns:ns2=\"http://provider\">");
                    temp.append("<gsc-was><result_code>00000</result_code>");
                    temp.append("<result_message>정상</result_message><rows><row><cust_name>김재윤</cust_name><dd_use_lmt>0</dd_use_lmt><gsn_cust_yn>N</gsn_cust_yn><intgr_cust_no></intgr_cust_no><mm_rsv_lmt>0</mm_rsv_lmt><mm_use_lmt>0</mm_use_lmt><nextmm_vanish_intend_pt>0</nextmm_vanish_intend_pt><sum_dd_use_lmt>0</sum_dd_use_lmt><sum_dd_use_pssbl_pt>0</sum_dd_use_pssbl_pt><sum_mm_rsv_lmt>0</sum_mm_rsv_lmt><sum_mm_rsv_pssbl_pt>0</sum_mm_rsv_pssbl_pt><sum_mm_use_lmt>0</sum_mm_use_lmt><sum_mm_use_pssbl_pt>0</sum_mm_use_pssbl_pt>");
                    temp.append("<tot_rest_pt>1000000</tot_rest_pt>");
                    temp.append("<tot_rsv_pt>0</tot_rsv_pt>");
                    temp.append("<tot_trans_rcv_pt>0</tot_trans_rcv_pt>");
                    temp.append("<tot_use_accum_pt>4139941</tot_use_accum_pt>");
                    temp.append("<trans_impssbl_pt>0</trans_impssbl_pt>");
                    temp.append("<trans_pssbl_pt>16093636</trans_pssbl_pt>");
                    temp.append("</row></rows></gsc-was>");
                    temp.append("</ns2:pointInfoCustPointSearchResponse></soap:Body></soap:Envelope>");
                }else if(StringUtil.equals(serviceName,"pointInfoTrpntSave2")){
                    //포인트 사용
                    String apprDate = DateUtil.getTimestampToString(DateUtil.getTimestamp(),"yyyyMMdd");
                    SecureRandom secure = new SecureRandom();
                    Integer s = secure.nextInt(999);
                    String apprNo = s.toString() + apprDate.substring(0,7);
                    temp.append("<soap:Envelope xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">");
                    temp.append("<soap:Body><ns2:pointInfoTrpntSave2Response xmlns:ns2=\"http://provider\">");
                    temp.append("<gsc-was><result_code>00000</result_code>");
                    temp.append("<result_message>정상</result_message>");
                    temp.append("<appr_date>"+apprDate+"</appr_date>");
                    temp.append("<appr_no>"+apprNo+"</appr_no>");
                    temp.append("<cust_no_gs></cust_no_gs></gsc-was></ns2:pointInfoTrpntSave2Response></soap:Body></soap:Envelope>");
                    
                    //취소처리 실패했을 때 응답 값
                  /*  responseBody = "<soap:Envelope xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">" +
                            "<soap:Body><ns2:pointInfoTrpntSave2Response xmlns:ns2=\"http://provider\"><gsc-was>" +
                            "<result_code>R7502</result_code><result_message>사용 취소 할 수 있는 원거래가 존>재하지 않습니다.</result_message>" +
                            "<appr_date></appr_date><appr_no></appr_no><cust_no_gs>" +
                            "</cust_no_gs></gsc-was></ns2:pointInfoTrpntSave2Response></soap:Body>" +
                            "</soap:Envelope>";*/
                }else if(StringUtil.equals(serviceName,"customerInfoOwnAuthnRegisterCheck")){
                    //홈쇼핑 회원
                    temp.append("<soap:Envelope xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">");
                    temp.append("<soap:Body>");
                    temp.append("<ns2:customerInfoOwnAuthnRegisterCheckResponse xmlns:ns2=\"http://provider\">");
                    temp.append("<gsc-was>");
                    temp.append("<result_code>R7008</result_code>");
                    temp.append("<result_message>홈쇼핑 회원입니다.</result_message>");
                    temp.append("</gsc-was>");
                    temp.append("</ns2:customerInfoOwnAuthnRegisterCheckResponse>");
                    temp.append("</soap:Body>");
                    temp.append("</soap:Envelope>");
                }else{
                    log.info("임시 응답값 생성 중");
                }
                responseBody = temp.toString();
                log.info("#### 실제 통신은 개발계에서 확인해주세요. ####");
            }else{
                RestTemplate restTemplate = new RestTemplate(factory);
                responseEntity = restTemplate.exchange(serverUrl, spec.getHttpMethod(), entity, String.class);
                responseBody = responseEntity.getBody();
            }
        }

        log.error("========== The Request Soap Xml ===========\n {}",xml);
        log.error("========== Response ===========\n {}",responseBody);
        log.error("========== END ===========");

        result.setResponseBody(responseBody);
        return result;
    }

    //Header 가져오기
    private HttpHeaders header(GsrApiSpec spec) {
        HttpHeaders headers = new HttpHeaders();
        headers.set("Content-Type", spec.getContentType());
        return headers;
    }
    
    //요청 파라미터->XML 변환
    private String soapXml(Map<String,String> param,String serviceName){
        //회원 등록
        if(StringUtil.equals(serviceName,bizConfig.getProperty("gsr.request.url." + CommonConstants.GSR_INSERT_MEMBER))){
            param.remove("store_code");
            param.put("store_cd",bizConfig.getProperty("aboutpet.gsr.store.code"));
            param.put("req_sub_co_code",bizConfig.getProperty("aboutpet.gsr.req.sub.co.code"));
            param.put("sub_co_code",bizConfig.getProperty("aboutpet.gsr.sub.co.code"));
            param.put("cust_div_code",bizConfig.getProperty("aboutpet.gsr.cust.div.code"));
        }
        //고객 카드 포인트 조회
        if(StringUtil.equals(serviceName,bizConfig.getProperty("gsr.request.url." + CommonConstants.GSR_SELECT_MEMBER_CPOINT))){
            param.remove("div_code");
            param.remove("store_code");
        }
        //고객 포인트 사용 적립
        if(StringUtil.equals(serviceName,bizConfig.getProperty("gsr.request.url." + CommonConstants.GSR_SAVE_MEMBER_POINT))){
            param.put("trans_rsn_code",bizConfig.getProperty("aboutpet.gsr.trans.rsn.code"));
            param.put("prod_code",bizConfig.getProperty("aboutpet.gsr.prod.code"));
            param.put("reason_code","");
            param.put("pnt_apply_amt","0");         // 포인트 적립 합계
            param.put("card_no_sp","1");            // 카드번호구분 default : 1 ( 1:보너스 카드, 2:주민번호 )
        }
        
        //xml 생성
        StringBuilder xml = new StringBuilder("<soapenv:Envelope ");
        xml.append("xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" ");
        xml.append("xmlns:prov=\"http://provider\">\n");
        xml.append("<soapenv:Body>\n");
        xml.append("<prov:"+serviceName+">\n");
        Set<String> keys = param.keySet();
        for(String key : keys){
            //reason_code 는 값이 없더라도 SET
            if(StringUtil.equals(key,"reason_code") || StringUtil.isNotEmpty(param.get(key)) ){
                xml.append("<"+key+">");
                xml.append(param.get(key));
                xml.append("</"+key+">\n");
            }
        }
        xml.append("</prov:"+serviceName+">\n");
        xml.append("</soapenv:Body>\n");
        xml.append("</soapenv:Envelope>");

        return xml.toString();
    }

    private String convertResultCode(String cd){
        String resultCode = "";

        // GS API 응답 에러 코드는 숫자 형식 -> 어바웃펫 형식으로 치환
        switch (cd) {
            case CommonConstants.GSR_RST_DUPLICATE :
                resultCode = ExceptionConstants.ERROR_GSR_API_DUPLICATE_MEMBER;
                break;
            case CommonConstants.GSR_RST_IS_NOT_EXISTS:
                resultCode = ExceptionConstants.ERROR_GSR_API_IS_NOT_EXISTS;
                break;
            case CommonConstants.GSR_RST_NOT_FOUND:
                resultCode = ExceptionConstants.ERROR_GSR_API_NOT_FOUND;
                break;
            case CommonConstants.GSR_RST_BAD_REQUEST:
                resultCode = ExceptionConstants.ERROR_GSR_API_BAD_REQUEST;
                break;
            case CommonConstants.GSR_RST_LIMIT_AGE :
                resultCode = ExceptionConstants.ERROR_GSR_API_LIMIT_AGE;
                break;
            case CommonConstants.GSR_RST_SYSTEM_ERROR :
                resultCode = ExceptionConstants.ERROR_GSR_API_SYSTEM;
                break;
            case CommonConstants.GSR_RST_SAVE_POINT_ERROR :
                resultCode = ExceptionConstants.ERROR_GSR_API_INSERT_ERROR;
                break;
            case CommonConstants.GSR_RST_NOT_RESPONSE :
                resultCode = ExceptionConstants.ERROR_GSR_API_NOT_RESPONSE;
                break;
            case CommonConstants.GSR_RST_DORMANT_MEMBER :
                resultCode = ExceptionConstants.ERROR_GSR_API_DORMANT_MEMBER;
                break;
            case CommonConstants.GSR_RST_NOT_APPR_ORDER :
                resultCode = ExceptionConstants.ERROR_GSR_API_NOT_EXSITS_APPR;
                break;
            case CommonConstants.GSR_HOME_SHOP_MEMBER :
                resultCode = ExceptionConstants.ERROR_GSR_API_HOME_SHOP_MEMBER;
                break;
            default:
                resultCode = ExceptionConstants.ERROR_GSR_API_SYSTEM;
                break;
        }
        return resultCode;
    }

    //GSR 응답 메세지 서비스 별 분기처리
    private String convertResultMessage(String serviceName,String resultCode,String resultMessage){
        if(!StringUtil.equals(serviceName,CommonConstants.GSR_INSERT_MEMBER) && !StringUtil.equals(resultCode,ExceptionConstants.ERROR_GSR_API_INSERT_ERROR)){
            resultMessage = message.getMessage("business.exception."+resultCode);
        }
        return resultMessage;
    }
}
