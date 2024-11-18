package framework.common.util;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Properties;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import framework.cis.client.ApiClient;
import framework.cis.model.request.gateway.GatewayRequest;
import framework.cis.model.response.ApiResponse;
import framework.common.enums.CisApiSpec;
import lombok.extern.slf4j.Slf4j;
import net.sf.json.JSONArray;

/**
 * <pre>
 * - 프로젝트명	: 01.common
 * - 패키지명		: framework.common.util
 * - 파일명		: NhnCaptchaUtil.java
 * - 작성일		: 2021. 1. 27. 
 * - 작성자		: VALFAC
 * - 설 명			: 네이버 shortUrl Util
 * </pre>
 */
@Component
@Slf4j
public class NhnShortUrlUtil {

	@Autowired
	private Properties bizConfig;
	
	@Autowired
	private ApiClient apiClient;

	public String getUrlDirect(String orgUrl) {
		String clientId = bizConfig.getProperty("naver.cloud.client.id");// 애플리케이션 클라이언트 아이디값";
		String clientSecret = bizConfig.getProperty("naver.cloud.client.secret");// 애플리케이션 클라이언트 시크릿값";
		String shortUrl = null;
		try {
			String apiURL = bizConfig.getProperty("naver.get.short.url.api.url");
			URL url = new URL(apiURL);
			HttpURLConnection con = (HttpURLConnection)url.openConnection();
			con.setRequestMethod("POST");
			con.setRequestProperty("Content-Type", "application/json");
			con.setRequestProperty("X-NCP-APIGW-API-KEY-ID", clientId);
			con.setRequestProperty("X-NCP-APIGW-API-KEY", clientSecret);
			con.setDoOutput(true);
			// post request
			JSONObject json = new JSONObject();
			json.put("url", orgUrl);
			String postParams = json.toString();
			DataOutputStream wr = new DataOutputStream(con.getOutputStream());
			wr.writeBytes(postParams);
			wr.flush();
			wr.close();
			int responseCode = con.getResponseCode();
			//보안 진단. 부적절한 자원 해제 (IO)
			BufferedReader br = null;
			try {
				if(responseCode==200) { // 정상 호출
					br = new BufferedReader(new InputStreamReader(con.getInputStream()));
				} else {  // 오류 발생
					br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
				}
				String inputLine;
				StringBuffer response = new StringBuffer();
				while ((inputLine = br.readLine()) != null) {
					response.append(inputLine);
				}
				br.close();
				JSONObject obj = new JSONObject(response.toString());
				shortUrl = obj.getJSONObject("result").getString("url");
			} catch (IOException e1) {
				log.error("NhnShortUrlUtil getUrl error e1 : {}", e1);
				throw new Exception(e1);
			} finally {
				if(br != null) {
					br.close();
				}
			}
			
		} catch (Exception e) {
			log.error("NhnShortUrlUtil getUrl error : {}", e);
		}
		return shortUrl;
	}
	
	public String getUrl(String orgUrl) {
		String shortUrl = null;
		GatewayRequest request = new GatewayRequest();
		request.setRequestUrl(bizConfig.getProperty("naver.get.short.url.api.url"));
		request.setRequestMethod("POST");
		JSONObject json = new JSONObject();
		json.put("url", orgUrl);
		String postParams = json.toString();
		request.setRequestData(postParams);
		request.setContentType("application/json");
		request.setCharacterSet("UTF-8");
		JSONArray jsArr = new JSONArray(); 
		net.minidev.json.JSONObject jsObj = new net.minidev.json.JSONObject();
		jsObj.put("value", bizConfig.getProperty("naver.cloud.client.id"));
		jsObj.put("key", "X-NCP-APIGW-API-KEY-ID");
		jsArr.add(jsObj);
		jsObj.clear();
		jsObj.put("value", bizConfig.getProperty("naver.cloud.client.secret"));
		jsObj.put("key", "X-NCP-APIGW-API-KEY");
		jsArr.add(jsObj);
		jsObj.clear();
		jsObj.put("value", "application/json");
		jsObj.put("key", "Content-Type");
		jsArr.add(jsObj);
		jsObj.clear();
		request.setHeader(jsArr);
		ApiResponse ar = apiClient.getResponse(CisApiSpec.IF_R_GATEWAY_INFO, request);
		JSONObject obj = new JSONObject(ar.getResponseJson().get("resTxt").getTextValue());
		shortUrl = obj.getJSONObject("result").getString("url");
		return shortUrl;
	}

	//회원 초대 링크
	public String getInviteUrl(String frdRcomKey,String returnUrl){
		String orgUrl = bizConfig.getProperty("aboutpet.invite.lnk");
		orgUrl = orgUrl.replace("{frdRcomKey}",frdRcomKey);
		if(StringUtil.isNotEmpty(returnUrl)){
			orgUrl = "&returnUrl="+returnUrl;
		}
		return getUrl(orgUrl);
	}
}
