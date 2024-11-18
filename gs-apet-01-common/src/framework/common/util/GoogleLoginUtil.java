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
import lombok.extern.slf4j.Slf4j;

/**
 * <pre>
* - 프로젝트명	: 31.front
* - 패키지명	: framework.common.util
* - 파일명		: GoogleLoginUtil.java
* - 작성일		: 2020. 12. 22.
* - 작성자		: ValueFactory
* - 설명		: GoogleLoginUtil
 * </pre>
 */
@Slf4j
@Component
public class GoogleLoginUtil extends DefaultApi20 implements SnsLoginUtil {
	@Autowired
	private Properties bizConfig;
	private String SESSION_STATE;

	private String clientId;
	private String clientSecret;
	private String redirectUri;
	private String authorizeApiUri;
	private String tokenApiUri;
	private String scopeApiUri;
	private String profileApiUri;
	private String revokeApiUri;

	@PostConstruct
	public void init() {
		this.SESSION_STATE = FrontConstants.SESSION_STATE_GOOGLE;
		this.redirectUri = bizConfig.getProperty("google.redirect.uri");
		this.clientId = bizConfig.getProperty("google.client.id");		
		this.clientSecret = bizConfig.getProperty("google.client.secret");		
		this.authorizeApiUri = "https://accounts.google.com/o/oauth2/v2/auth";
		this.scopeApiUri = "https://www.googleapis.com/auth/userinfo.profile https://www.googleapis.com/auth/userinfo.email";
		this.tokenApiUri = "https://accounts.google.com/o/oauth2/token";
		this.profileApiUri ="https://www.googleapis.com/oauth2/v3/userinfo";
		this.revokeApiUri = "https://accounts.google.com/o/oauth2/revoke";
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
	 * 구글 인증 코드 요청 URL 생성
	 * @param session
	 * @param type
	 * @return
	 */
	public String getAuthorizationUrl(HttpSession session) {
//		// 상태 토큰으로 사용할 랜덤 문자열 생성
		String state = generateState();
		setSession(session,state);
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		String goUrl = this.authorizeApiUri+"?scope="+scopeApiUri+"&access_type=offline&client_id="+this.clientId+"&response_type=code&redirect_uri="+redirectUri+"&state="+state;
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
		String sessionState = getSession(session);

		if (StringUtils.equals(sessionState, state)) {
			try {

				HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
				OAuth20Service oauthService = new ServiceBuilder(this.clientId)
						.apiKey(this.clientId)
						.apiSecret(this.clientSecret)
						.callback(this.redirectUri)
						.build(this);

				/* Scribe에서 제공하는 AccessToken 획득 기능으로 네아로 Access Token을 획득 */
				accessToken = oauthService.getAccessToken(code);

				if (log.isInfoEnabled()) {
					log.info("GoogleLoginApi accessToken : {}", accessToken.getAccessToken());
					log.info("GoogleLoginApi expiresIn : {}", accessToken.getExpiresIn());
					log.info("GoogleLoginApi refreshToken : {}", accessToken.getRefreshToken());
				}

			} catch (Exception e) {
				log.error("GoogleLoginApi getAccessToken error : {}", e);
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

			JSONObject obj = new JSONObject(result);
			userMap = new HashMap<String, String>();
			userMap.put("uuid", obj.getString("sub"));
			userMap.put("email", obj.isNull("email") ? null : obj.getString("email"));
			userMap.put("name", obj.getString("name"));
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
