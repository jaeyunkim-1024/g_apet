package framework.common.enums;

import org.springframework.http.HttpMethod;

import framework.common.constants.CommonConstants;
import lombok.Getter;

/**
 * <pre>
 * - 프로젝트명	: gs-apet-01-common
 * - 패키지명	: framework.common.enums
 * - 파일명		: NicePayApiSpec.java
 * - 작성일		: 2021. 01. 12.
 * - 작성자		: JinHong
 * - 설명		: nicePay spec
 * </pre>
 */
@Getter
public enum NicePayApiSpec {
	/** 가상계좌 발급 요청 */
	IF_GET_VIRTUAL_ACCOUNT(CommonConstants.NICEPAY_API_ID_IF_GET_VIRTUAL_ACCOUNT, HttpMethod.POST, CommonConstants.NICEPAY_API_CONTENT_TP_FORM, CommonConstants.NICEPAY_API_RES_JSON),
	/** 예금주 성명 조회 */
	IF_CHECK_BANK_ACCOUNT(CommonConstants.NICEPAY_API_ID_IF_CHECK_BANK_ACCOUNT, HttpMethod.POST, CommonConstants.NICEPAY_API_CONTENT_TP_FORM, CommonConstants.NICEPAY_API_RES_JSON),
	/** 현금영수증 발급 요청 */
	IF_CASH_RECEIPT(CommonConstants.NICEPAY_API_ID_IF_CASH_RECEIPT, HttpMethod.POST, CommonConstants.NICEPAY_API_CONTENT_TP_FORM, CommonConstants.NICEPAY_API_RES_JSON),
	/** 승인 취소 요청 */
	IF_CANCEL_PROCESS(CommonConstants.NICEPAY_API_ID_IF_CANCEL_PROCESS, HttpMethod.POST, CommonConstants.NICEPAY_API_CONTENT_TP_FORM, CommonConstants.NICEPAY_API_RES_JSON),
	/** 고정계좌 과오납 요청 */
	IF_REGIST_FIX_ACCOUNT(CommonConstants.NICEPAY_API_ID_IF_REGIST_FIX_ACCOUNT, HttpMethod.POST, CommonConstants.NICEPAY_API_CONTENT_TP_FORM, CommonConstants.NICEPAY_API_RES_JSON)
	;
	
	private String apiId;
	private HttpMethod httpMethod;
	private String headerType;
	private String returnType;

	private NicePayApiSpec(String apiId, HttpMethod httpMethod, String headerType, String returnType) {
		this.apiId = apiId;
		this.httpMethod = httpMethod;
		this.headerType = headerType;
		this.returnType = returnType;
	}

}
