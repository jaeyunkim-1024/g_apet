package batch.excute.order;

import biz.app.batch.model.BatchLogPO;
import biz.app.batch.service.BatchService;
import biz.app.order.model.CardcInstmntInfoPO;
import biz.app.order.service.CardcInstmntInfoService;
import biz.interfaces.nicepay.model.response.data.InterestFreeInfoItemResVO;
import biz.interfaces.nicepay.model.response.data.InterestFreeInfoResVO;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import framework.common.util.DateUtil;
import framework.common.util.StringUtil;
import lombok.extern.slf4j.Slf4j;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.List;
import java.util.Properties;

@Slf4j
@Component
@EnableScheduling
public class CardcInstmntInfoExcute {

	@Autowired	private CardcInstmntInfoService cardcInstmntInfoService;
	@Autowired	private BatchService batchService;
	@Autowired	private MessageSourceAccessor message;
	@Autowired	Properties bizConfig;

	/**
	* <pre>
	* - 프로젝트명	: 21.batch
	* - 파일명		: CardcInstmntInfoExcute.java
	* - 작성일		: 2021. 4. 7.
	* - 작성자		: kek01
	* - 설명			: 카드사 할부 정보 저장
	* </pre>
	*/
//	@Scheduled(fixedDelay=300000)		//배치실행시 즉시실행 및 5분 단위로
	public void cronCardcInstmntInfo() {
		BatchLogPO blpo = new BatchLogPO();
		blpo.setBatchId(CommonConstants.BATCH_ORD_CARDC_INSTMNT_INFO);
		blpo.setBatchStrtDtm(DateUtil.getTimestamp());
		blpo.setSysRegrNo(CommonConstants.COMMON_BATCH_USR_NO);

		int successCnt = 0;
		int totalCnt = 0;

		//나이스페이 무이자 할부 조회 API 호출
		InterestFreeInfoResVO resvo = reqInterestFreeInfoNicepayAPI();
		List<InterestFreeInfoItemResVO> datas = resvo.getBody().getData();

		Timestamp currentDate = DateUtil.getTimestamp(DateUtil.getNowDateTime(), CommonConstants.COMMON_DATE_FORMAT);
		
		//카드사 할부 정보 저장
		for ( InterestFreeInfoItemResVO data : datas){
			totalCnt++;
			try {
				CardcInstmntInfoPO po = new CardcInstmntInfoPO();
				po.setCardcCd(data.getFnCd());				//카드사코드
				po.setMonth(data.getInstmntMon());			//개월수
				po.setInstmntTpCd(data.getInstmntType());	//할부유형
				po.setMinAmt(data.getMinAmt());				//최소금액
				po.setSysRegDtm(currentDate);
				po.setSysUpdDtm(currentDate);
				cardcInstmntInfoService.mergeCardcInstmntInfo(po);
				
				successCnt++;
			}catch(Exception ex) {
				ex.getMessage();
			}
		}

		//카드사 할부 정보 삭제 (갱신되지 않은 데이타 삭제)
		CardcInstmntInfoPO delpo = new CardcInstmntInfoPO();
		delpo.setSysUpdDtm(currentDate);
		cardcInstmntInfoService.deleteCardcInstmntInfo(delpo);
		
		
		/***********************
		 * Batch Log End
		 ***********************/
		blpo.setBatchEndDtm(DateUtil.getTimestamp());
		blpo.setBatchRstCd(CommonConstants.BATCH_RST_CD_SUCCESS);
		blpo.setBatchRstMsg(this.message.getMessage("batch.log.result.msg.order.delivery.command.success", new Object[]{totalCnt, successCnt, totalCnt-successCnt}));
		batchService.insertBatchLog(blpo);		
	}

	
	/**
	 * 나이스페이 무이자 할부 조회 API 호출
	 * @return
	 */
	public InterestFreeInfoResVO reqInterestFreeInfoNicepayAPI() {
		InterestFreeInfoResVO rslt = new InterestFreeInfoResVO();
		//------------------------
		//NicePay API URL
		//------------------------
        String baseUrl = bizConfig.getProperty("nicepay.mi.api.server");
		//log.debug(">>> NicePay API URL :: {}", baseUrl);
        
		//------------------------
		//NicePay Parameter SET
		//------------------------
		String currDate = DateUtil.calDate("yyyyMMddHHmmss");
		DataEncrypt sha256Enc = new DataEncrypt();
		String  hashString = sha256Enc.encrypt( CommonConstants.NICEPAY_INTEREST_FREE_SID +
												bizConfig.getProperty("nicepay.api.certify.mid") + 
												currDate +
												bizConfig.getProperty("nicepay.api.certify.merchant.key")
		);
        
        JSONObject jheader = new JSONObject();
        jheader.put("sid", 	 CommonConstants.NICEPAY_INTEREST_FREE_SID);
        jheader.put("trDtm", currDate);
        jheader.put("gubun", CommonConstants.NICEPAY_INTEREST_FREE_GUBUN_REQ);
        jheader.put("resCode", "");
        jheader.put("resMsg",  "");
        
        JSONObject jbody = new JSONObject();
        jbody.put("mid", 		bizConfig.getProperty("nicepay.api.certify.mid"));
        jbody.put("encKey", 	hashString);
        jbody.put("targetDt", 	DateUtil.getNowDate());
        
        JSONObject finalReqParams = new JSONObject ();
        finalReqParams.put("header", jheader);
        finalReqParams.put("body",jbody);

        //log.debug(">>> finalReqParam = "+finalReqParams.toString());
        HttpEntity<?> requestEntity = getHttpEntity("json", finalReqParams.toString());
        
		//------------------------
        //NicePay API Call
		//------------------------
        ResponseEntity<String> responseEntity = getTemplate().exchange(baseUrl, HttpMethod.POST, requestEntity, String.class);
		log.debug("### Response Body {}", responseEntity.getBody());

		ObjectMapper objectMapper = new ObjectMapper();
		objectMapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
		try {
			rslt = objectMapper.readValue(responseEntity.getBody(), InterestFreeInfoResVO.class);
			log.debug("### Response getDataCnt = {}", rslt.getBody().getDataCnt());
		} catch (IOException e) {
			log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE,e);
		}  catch (Exception e){
			log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE,new CustomException(ExceptionConstants.ERROR_DATA_PARSE_FAIL));
		}

		return rslt;
	}
	
	private RestTemplate getTemplate() {
		RestTemplate restTemplate = new RestTemplate();
		MappingJackson2HttpMessageConverter converter = new MappingJackson2HttpMessageConverter();
		restTemplate.getMessageConverters().add(converter);
		return restTemplate;
	}
	
    private HttpEntity<?> getHttpEntity(String appType, String params) {
        HttpHeaders requestHeaders = new HttpHeaders();
		requestHeaders.set("Content-Type", "application/" + appType);
		HttpEntity<?> entity;
        if ( "".equals(params) || StringUtil.isNull(params)) {
        	entity = new HttpEntity<Object>(requestHeaders);
        }else {
        	entity = new HttpEntity<Object>(params, requestHeaders);
        }
		log.debug("#### Request Header :{}", entity.getHeaders());
		log.debug("#### Request body :{}", entity.getBody());
		return entity;
    }	
}
