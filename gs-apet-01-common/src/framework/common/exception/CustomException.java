package framework.common.exception;

import lombok.extern.slf4j.Slf4j;

/**
 * 사용자 Exception
 * 
 * @author valueFactory
 * @since 2017. 01. 23.
 */
@Slf4j
public class CustomException extends RuntimeException {

	private static final long serialVersionUID = 1L;

	private String	exCode;

	private String	loginType;

	private String[]	params;

	private String	returnUrl;

	public CustomException(String exCode) {
		this.exCode = exCode;

		log.error("[exCode] : " + exCode + "\n" + this.getMessage());
	}

	public CustomException(String exCode, String loginType) {
		this.exCode = exCode;
		this.loginType = loginType;

		log.error("[exCode] : " + exCode + ", loginType : " + loginType + "\n" + this.getMessage());
	}

	public CustomException(String exCode, String[] params) {
		this.exCode = exCode;
		
		//this.params = params;
		//보안진단 처리-Private 배열에 Public 데이터 할당
		this.params = new String[params.length];
		for(int i=0; i<params.length; ++i) {
			this.params[i] = params[i];
		}

		log.error("[exCode] : " + exCode + ", params : " + String.join(",",params) + "\n" + this.getMessage());
	}

	public CustomException(String exCode, String loginType, String returnUrl) {
		this.exCode = exCode;
		this.loginType = loginType;
		this.returnUrl = returnUrl;

		log.error("[exCode] : " + exCode + ", loginType : " + loginType + ", returnUrl : " + returnUrl + "\n" + this.getMessage());
	}

	public String getExCode() {
		return this.exCode;
	}

	public String getLoginType() {
		return this.loginType;
	}

	public String getReturnUrl() {
		return this.returnUrl;
	}

	public String[] getParams() {
		return this.params;
	}
}
