package biz.twc.service;

import java.util.Properties;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.fasterxml.jackson.databind.ObjectMapper;

import biz.common.service.BizService;
import biz.twc.model.CounslorPO;
import biz.twc.model.TicketPO;
import framework.cis.client.ApiClient;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import lombok.extern.slf4j.Slf4j;


/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.twc.service
* - 파일명		: TwcServiceImpl.java
* - 작성일		: 2021.03.24
* - 작성자		: KKB
* - 설명		: TWC 서비스
* </pre>
*/
@Slf4j
@Service
@Transactional(value="TwcTransactionManager")
public class TwcServiceImpl implements TwcService {

	@Autowired private Properties bizConfig;
	
	@Autowired private ApiClient apiClient;
	
	@Autowired private BizService bizService;
	
	@Override
	public String sendCounselorInfo(CounslorPO po) {
		HttpHeaders headers = new HttpHeaders();
		headers.set("Content-Type", "application/json; charset=utf-8");
		ObjectMapper obm = new ObjectMapper();
		String JSONInput;
		try {
			JSONInput = obm.writeValueAsString(po);
		} catch (Exception e) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		HttpEntity<String> entity = new HttpEntity<String>(JSONInput, headers);
		String url = bizConfig.getProperty("twc.api.counsel");
		String result = bizService.convertToCisApi(url, HttpMethod.POST, entity);
		return result;
	}

	@Override
	public String sendTicketEvent(TicketPO po) {
		HttpHeaders headers = new HttpHeaders();
		headers.set("Content-Type", "application/json; charset=utf-8");
		ObjectMapper obm = new ObjectMapper();
		String JSONInput;
		try {
			JSONInput = obm.writeValueAsString(po);
		} catch (Exception e) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		HttpEntity<String> entity = new HttpEntity<String>(JSONInput, headers);
		String url = bizConfig.getProperty("twc.api.ticket");
		String result = bizService.convertToCisApi(url, HttpMethod.POST, entity);
		return result;
	}
}

