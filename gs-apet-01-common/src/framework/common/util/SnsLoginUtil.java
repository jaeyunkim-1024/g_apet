package framework.common.util;

import java.util.Map;

import javax.servlet.http.HttpSession;

import com.github.scribejava.core.model.OAuth2AccessToken;

/**
* <pre>
* - 프로젝트명	: 32.front.mobile
* - 패키지명	: biz.app.member.api
* - 파일명		: SnsLoginApi.java
* - 작성일		: 2019. 03. 11.
* - 작성자		: JoonHyuck
* - 설명		: 소셜 로그인 연동 API 인터페이스
* </pre>
*/
public interface SnsLoginUtil {
	String getLoginAuthorizationUrl(HttpSession session);
	
	String getMypageAuthorizationUrl(HttpSession session);

	String getPopupLoginAuthorizationUrl(HttpSession session);
	
	OAuth2AccessToken getAccessToken(HttpSession session, String code, String state, String type);
	
	Map<String, String> getUserProfile(OAuth2AccessToken oauthToken);
	
	String deleteAccessToken(String accessToken, String refreshToken);
	
	String refreshToken(String refreshToken);

}
