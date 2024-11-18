package framework.common.util;

import java.math.BigInteger;
import java.security.SecureRandom;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

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
* - 파일명		: KakaoLoginUtil.java
* - 작성일		: 2020. 12. 28.
* - 작성자		: ValueFactory
* - 설명		: 카카오 로그인 연동 API
* </pre>
*/
@Slf4j
@Component
public class KakaoLoginUtil extends DefaultApi20 implements SnsLoginUtil {
	@Autowired
	private Properties bizConfig;
	private String SESSION_STATE;

	private String clientId;
	private String clientSecret;
	private String redirectUri;
	private String authorizeApiUri;
	private String tokenApiUri;
	private String profileApiUri;
	private String unlinkApiUri;

	@PostConstruct
	public void init() {
		this.SESSION_STATE = FrontConstants.SESSION_STATE_KAKAO;
		this.redirectUri = bizConfig.getProperty("kakao.redirect.uri");//"/callback/kakaoLogin/";		
		this.clientId = this.bizConfig.getProperty("kakao.app.key.restapi");
		this.clientSecret = this.bizConfig.getProperty("kakao.app.secret");
		this.authorizeApiUri = "https://kauth.kakao.com/oauth/authorize";
		this.tokenApiUri = "https://kauth.kakao.com/oauth/token";
		this.profileApiUri = "https://kapi.kakao.com/v2/user/me";
		this.unlinkApiUri = "https://kapi.kakao.com/v1/user/unlink";

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
	 * 카카오 인증 코드 요청 URL 생성
	 * @param session
	 * @param type
	 * @return
	 */
	public String getAuthorizationUrl(HttpSession session) {
		// 상태 토큰으로 사용할 랜덤 문자열 생성
		String state = generateState();
		setSession(session,state);
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		String url = request.getRequestURL().toString();
		String uri = request.getRequestURI().toString();
		String domain = url.replace(uri, "");
		String goUrl = this.authorizeApiUri+"?response_type=code&client_id="+this.clientId+"&redirect_uri="+redirectUri+"&state="+state;
	    return goUrl;
	}
	
	public String generateState()
	{
	    SecureRandom random = new SecureRandom();
	    return new BigInteger(130, random).toString(32);
	}
	
	/* http session에 데이터 저장 */
	private void setSession(HttpSession session,String state) {
		session.setAttribute(SESSION_STATE, state);
	}

	/* http session에서 데이터 가져오기 */
	public String getSession(HttpSession session){
		return (String) session.getAttribute(SESSION_STATE);
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
				
				OAuth20Service oauthService =new ServiceBuilder(this.clientId)
					.apiSecret(this.clientSecret)
					.build(this);

				OAuthRequest request = new OAuthRequest(Verb.POST, this.tokenApiUri);
				request.addParameter("grant_type", "authorization_code");
				request.addParameter("client_id", this.clientId);
				request.addParameter("client_secret", this.clientSecret);
				HttpServletRequest httpRequest = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
				String url = httpRequest.getRequestURL().toString();
				String uri = httpRequest.getRequestURI().toString();
				String domain = url.replace(uri, "");
				request.addParameter("redirect_uri", this.redirectUri);
				request.addParameter("code", code);
	
		        Response response = oauthService.execute(request);
	
				String body = response.getBody();
				JSONObject obj = new JSONObject(body);
				accessToken = new OAuth2AccessToken(obj.getString("access_token"), obj.getString("token_type"), obj.getInt("expires_in"), obj.getString("refresh_token"), null, null);
	
				if (log.isInfoEnabled()) {
					log.info("KakaoLoginApi accessToken : {}", accessToken.getAccessToken());
					log.info("KakaoLoginApi expiresIn : {}", accessToken.getExpiresIn());
					log.info("KakaoLoginApi refreshToken : {}", accessToken.getRefreshToken());
				}
			} catch (Exception e) {
				log.error("KakaoLoginApi getAccessToken error : {}", e);
			}
		}
	    return accessToken;
	}

	/**
	 * Access Token을 이용하여 카카오 사용자 정보 요청 API를 호출
	 * @param oauthToken
	 * @return
	 */
    @Override
    public Map<String, String> getUserProfile(OAuth2AccessToken oauthToken) {
    	Map<String, String> userMap = null;
    	String result = null;

    	try {
    		OAuth20Service oauthService = new ServiceBuilder(this.clientId)
				.apiSecret(this.clientSecret)
				.build(this);

			OAuthRequest request = new OAuthRequest(Verb.POST, this.profileApiUri);
			request.addHeader("Authorization", "Bearer " + oauthToken.getAccessToken());
			Response response = oauthService.execute(request);
			log.info("#### : {}",response);
			result = response.getBody();

			JSONObject obj = new JSONObject(result);
			JSONObject infoObj = obj.getJSONObject("kakao_account") ;
			userMap = new HashMap<String, String>();
			userMap.put("uuid", String.valueOf(obj.getLong("id")));
			userMap.put("email", infoObj.isNull("email") ? null : infoObj.getString("email"));
			userMap.put("gender", infoObj.isNull("gender") ? null : infoObj.getString("gender"));
			userMap.put("birthday", infoObj.isNull("birthday") ? null : infoObj.getString("birthday"));
			//birthyear 이랑 ci값 나중에 추가하기
			userMap.put("token", oauthToken.getAccessToken());
			userMap.put("reRefreshtoken", oauthToken.getRefreshToken());
			//userMap.put("resultJson", result.toString()); // 삭제예정
    	} catch (JSONException e) {
    		log.error("KakaoLoginApi getUserProfile error : {}", e);
    		userMap = new HashMap<String, String>();
    		userMap.put("uuid", null);
			userMap.put("email", null);
			userMap.put("name", null);
    	} catch (Exception e) {
    		log.error("KakaoLoginApi getUserProfile error : {}", e);
    		userMap = null;
    	}

    	return userMap;
	}

	/**
	 * 동의 해제
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

			request = new OAuthRequest(Verb.POST, this.unlinkApiUri);
			request.addHeader("Authorization", "Bearer " + accessToken);
			Response resp = oauthService.execute(request);
			response = resp.getBody();

			//{"id":123456789}
			if (log.isInfoEnabled()) {
				log.info("KakaoLoginApi deleteAccessToken result : {}", response);
			}

			JSONObject obj = new JSONObject(response);
			obj.getLong("id"); // 실패하면 id 대신 msg 와 code 가 존재

			result = CommonConstants.CONTROLLER_RESULT_CODE_SUCCESS;
		} catch (Exception e) {
			log.info("KakaoLoginApi deleteAccessToken error : {}", e);

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
			//"access_token":"wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww",
			//"token_type":"bearer",
			//"refresh_token":"zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz",  //optional
			//"expires_in":43199,
			//}
			if (log.isInfoEnabled()) {
				log.info("KakaoLoginApi refreshToken result : {}", response);
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

}
