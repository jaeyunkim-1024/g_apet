package framework.common.util;

import java.math.BigInteger;
import java.security.SecureRandom;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;
import java.util.UUID;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import framework.front.constants.FrontConstants;
import org.apache.commons.lang3.StringUtils;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.github.scribejava.core.builder.ServiceBuilder;
import com.github.scribejava.core.builder.api.DefaultApi20;
import com.github.scribejava.core.model.OAuth2AccessToken;
import com.github.scribejava.core.model.OAuthRequest;
import com.github.scribejava.core.model.Response;
import com.github.scribejava.core.model.Verb;
import com.github.scribejava.core.oauth.OAuth20Service;

import framework.common.constants.CommonConstants;
import framework.common.exception.CustomException;
import lombok.Getter;
import lombok.extern.slf4j.Slf4j;

/**
* <pre>
* - 프로젝트명	: 31.front
* - 패키지명	: framework.common.util
* - 파일명		: NaverLoginUtil.java
* - 작성일		: 2020. 12. 28.
* - 작성자		: ValueFactory
* - 설명		: 네이버 로그인 연동 API
* </pre>
*/
@Slf4j
@Component
public class NaverLoginUtil extends DefaultApi20 implements SnsLoginUtil {
	@Autowired
	private Properties bizConfig;
	@Getter
	private String SESSION_STATE;

	private String clientId;
	private String clientSecret;
	private String redirectUri;
	private String authorizeApiUri;
	private String tokenApiUri;
	private String profileApiUri;

	@PostConstruct
	public void init() {
		//this.SESSION_STATE = FrontConstants.SESSION_STATE_NAVER;
		this.clientId = bizConfig.getProperty("naver.client.id");
		this.clientSecret = bizConfig.getProperty("naver.client.secret");
		this.redirectUri = this.bizConfig.getProperty("naver.redirect.uri");;
		this.authorizeApiUri = "https://nid.naver.com/oauth2.0/authorize";
		this.tokenApiUri = "https://nid.naver.com/oauth2.0/token";
		this.profileApiUri = "https://openapi.naver.com/v1/nid/me";
	}

	@Override
	public String getAccessTokenEndpoint() {
		return this.tokenApiUri;
	}

	@Override
	protected String getAuthorizationBaseUrl() {
	    return this.authorizeApiUri;
	}

	/**
	 * 네이버 인증 코드 요청 URL 생성
	 * @param session
	 * @param type
	 * @return
	 */
	public String getAuthorizationUrl(HttpSession session) {
		// 상태 토큰으로 사용할 랜덤 문자열 생성
		String state = generateState();
		//setSession(session,state);
		SESSION_STATE = state;
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		String url = request.getRequestURL().toString();
		String uri = request.getRequestURI().toString();
		String domain = url.replace(uri, "");
		String goUrl = this.authorizeApiUri+"?client_id="+this.clientId+"&response_type=code&redirect_uri="+redirectUri+"&state="+state;
	    return goUrl;
	}

	public String generateState()
	{
	    SecureRandom random = new SecureRandom();
	    return new BigInteger(130, random).toString(32);
	}

	/**
	 * 접근 토큰 획득
	 * @param session
	 * @param code
	 * @param state
	 * @param type
	 * @return accessToken
	 */
	@Override
	public OAuth2AccessToken getAccessToken(HttpSession session, String code, String state, String type) {
		OAuth2AccessToken accessToken = null;
		/* Callback으로 전달받은 세선검증용 난수값과 세션에 저장되어있는 값이 일치하는지 확인 */
//		String sessionState = getSession(session);
		String sessionState = SESSION_STATE;

		if (StringUtils.equals(sessionState, state)) {
			try {

				OAuth20Service oauthService = new ServiceBuilder(this.clientId)
					.apiSecret(this.clientSecret)
					.build(this);

				/* Scribe에서 제공하는 AccessToken 획득 기능으로 네아로 Access Token을 획득 */
				accessToken = oauthService.getAccessToken(code);
				log.debug("Naver accessToken : {}",accessToken); 
				if (log.isInfoEnabled()) {
					log.info("NaverLoginApi accessToken : {}", accessToken.getAccessToken());
					log.info("NaverLoginApi expiresIn : {}", accessToken.getExpiresIn());
					log.info("NaverLoginApi refreshToken : {}", accessToken.getRefreshToken());
				}

			} catch (Exception e) {
				log.error("NaverLoginApi getAccessToken error : {}", e);
			}
		}

		return accessToken;
	}
	
	/**
	 * Access Token을 이용하여 네이버 사용자 프로필 API를 호출
	 * @param oauthToken
	 * @return
	 */
	@Override
	public Map<String, String> getUserProfile(OAuth2AccessToken oauthToken) {
		Map<String, String> userMap = null;
		String result = null;

		try {
			OAuth20Service oauthService =new ServiceBuilder(this.clientId)
				.apiSecret(this.clientSecret)
				.build(this);

			OAuthRequest request = new OAuthRequest(Verb.GET, this.profileApiUri);
			oauthService.signRequest(oauthToken, request);
			Response response = oauthService.execute(request);
			result = response.getBody();

			log.error("@@@@@ [ERROR]  Naver profile Result : {}", result);

			JSONObject obj = new JSONObject(result);
			userMap = new HashMap<String, String>();
			userMap.put("resultcode", obj.isNull("resultcode")? null:obj.getString("resultcode"));
			userMap.put("uuid", obj.getJSONObject("response").getString("id"));
			userMap.put("email", obj.getJSONObject("response").isNull("email")? null:obj.getJSONObject("response").getString("email"));
			userMap.put("name", obj.getJSONObject("response").isNull("name")? null:obj.getJSONObject("response").getString("name"));
			userMap.put("gender", obj.getJSONObject("response").isNull("gender")? null:obj.getJSONObject("response").getString("gender"));
			userMap.put("birthday", obj.getJSONObject("response").isNull("birthday")? null:obj.getJSONObject("response").getString("birthday"));
			userMap.put("birthyear", obj.getJSONObject("response").isNull("birthyear")? null:obj.getJSONObject("response").getString("birthyear"));
			userMap.put("mobile", obj.getJSONObject("response").isNull("mobile")? null:obj.getJSONObject("response").getString("mobile"));
			userMap.put("ciCtfVal", obj.getJSONObject("response").isNull("ci")? null:obj.getJSONObject("response").getString("ci")); // 회원연동 작업 시 네이버에서 추가해줌
			userMap.put("token", oauthToken.getAccessToken());
			userMap.put("reRefreshtoken", oauthToken.getRefreshToken());
			userMap.put("resultJson", result.toString()); // 삭제예정
		} catch (JSONException e) {
			log.error("NaverLoginApi getUserProfile error : {}", e);
			userMap = new HashMap<String, String>();
			userMap.put("resultcode", null);
			userMap.put("uuid", null);
			userMap.put("email", null);
			userMap.put("name", null);
		} catch (Exception e) {
			log.error("NaverLoginApi getUserProfile error : {}", e);
			userMap = null;
		}

		return userMap;
	}
	
	/* 로그인용 */
	@Override
	public String getLoginAuthorizationUrl(HttpSession session) {
		return "";
	}

	/* 마이페이지용 */
	@Override
	public String getMypageAuthorizationUrl(HttpSession session) {
		return "";
	}
	
	/* PC 팝업 로그인용 */
	@Override
	public String getPopupLoginAuthorizationUrl(HttpSession session) {
		return "";
	}

	/**
	 * 동의 해제
	 * @param accessToken
	 * @param refreshToken
	 * @return
	 */
	@Override
	public String deleteAccessToken(String accessToken, String refreshToken) {
		String result = null;
		String response = null;
		OAuth20Service oauthService = null;
		OAuthRequest request = null;

		// 접근 토큰 갱신 후 accessToken으로 delete에 사용
		if (accessToken == null) {
			accessToken = this.refreshToken(refreshToken);

			if (accessToken == null) {
				return CommonConstants.CONTROLLER_RESULT_CODE_FAIL;
			}
		}

		try {
			oauthService = new ServiceBuilder(this.clientId)
				.apiSecret(this.clientSecret)
				.build(this);

			request = new OAuthRequest(Verb.GET, this.tokenApiUri);
			request.addParameter("grant_type", "delete");
			request.addParameter("client_id", this.clientId);
			request.addParameter("client_secret", this.clientSecret);
			request.addParameter("access_token", accessToken);
			request.addParameter("service_provider", "NAVER");
			Response resp = oauthService.execute(request);
			response = resp.getBody();

			//{"access_token":"c8ceMEjfnorlQwEisqemfpM1Wzw7aGp7JnipglQipkOn5Zp3tyP7dHQoP0zNKHUq2gY", "result":"success"}
			if (log.isInfoEnabled()) {
				log.info("NaverLoginApi deleteAccessToken result : {}", response);
			}

			JSONObject obj = new JSONObject(response);
			if (StringUtils.equals(obj.getString("result"), "success")) {
				result = CommonConstants.CONTROLLER_RESULT_CODE_SUCCESS;
			} else {
				result = CommonConstants.CONTROLLER_RESULT_CODE_FAIL;
			}
		} catch (Exception e) {
			log.error("NaverLoginApi deleteAccessToken error : {}", e);

			result = CommonConstants.CONTROLLER_RESULT_CODE_FAIL;
		}

		return result;
	}

	@Override
	public String refreshToken(String refreshToken) {
		String response = null;
		String accessToken = null;
		OAuth20Service oauthService = null;
		OAuthRequest request = null;

		try {
			oauthService =new ServiceBuilder(this.clientId)
				.apiSecret(this.clientSecret)
				.build(this);

			request = new OAuthRequest(Verb.GET, this.tokenApiUri);
			request.addParameter("grant_type", "refresh_token");
			request.addParameter("client_id", this.clientId);
			request.addParameter("client_secret", this.clientSecret);
			request.addParameter("refresh_token", refreshToken);
			Response resp = oauthService.execute(request);
			response = resp.getBody();

			//{
			//"access_token":"AAAAQjbRkysCNmMdQ7kmowPrjyRNIRYKG2iGHhbGawP0xfuYwjrE2WTI3p44SNepkFXME/NlxfamcJKPmUU4dSUhz+R2CmUqnN0lGuOcbEw6iexg",
			//"token_type":"bearer",
			//"expires_in":"3600"
			//}
			if (log.isInfoEnabled()) {
				log.info("NaverLoginApi refreshToken result : {}", response);
			}

			JSONObject obj = new JSONObject(response);
			accessToken = obj.getString("access_token");

			if (StringUtils.isBlank(accessToken)) {
				throw new CustomException("accessToken is blank");
			}
		} catch (Exception e) {
			log.error("NaverLoginApi refreshToken error : {}", e);
		}

		return accessToken;
	}

	/* 세션 유효성 검증을 위한 난수 생성기 */
	private String generateRandomString() {
		return UUID.randomUUID().toString();
	}

	/* http session에 데이터 저장 */
	private void setSession(HttpSession session,String state) {
		session.setAttribute(SESSION_STATE, state);
	}

	/* http session에서 데이터 가져오기 */
	public String getSession(HttpSession session){
		return (String) session.getAttribute(SESSION_STATE);
	}

}
