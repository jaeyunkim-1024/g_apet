package framework.common.enums;

import org.springframework.http.HttpMethod;

import framework.common.constants.CommonConstants;
import lombok.Getter;

/**
 * <pre>
 * - 프로젝트명	:	01.common
 * - 패키지명	:	framework.common.enums
 * - 파일명	:	CisApiSpec.java
 * - 작성일	:	2020. 12. 21. 
 * - 작성자	:	 valuefactory
 * - 설 명		:
 * </pre>
 */
@Getter
public enum CisApiSpec {

	/** MDM 거래처 등록 */
	IF_R_INSERT_PRNT_INFO(CommonConstants.CIS_API_ID_IF_R_INSERT_PRNT_INFO, HttpMethod.POST, CommonConstants.CIS_API_SYSTEM_MDM, CommonConstants.CIS_API_CONTENT_TP_JSON, CommonConstants.CIS_API_RES_JSON),
	/** MDM 거래처 조회 */
	IF_S_SELECT_PRNT_LIST(CommonConstants.CIS_API_ID_IF_S_SELECT_PRNT_LIST, HttpMethod.POST, CommonConstants.CIS_API_SYSTEM_MDM, CommonConstants.CIS_API_CONTENT_TP_JSON, CommonConstants.CIS_API_RES_JSON),
	/** MDM 거래처 수정 */
	IF_R_UPDATE_PRNT_INFO(CommonConstants.CIS_API_ID_IF_R_UPDATE_PRNT_INFO, HttpMethod.POST, CommonConstants.CIS_API_SYSTEM_MDM, CommonConstants.CIS_API_CONTENT_TP_JSON, CommonConstants.CIS_API_RES_JSON),
	/** SHOP 상품 조회 */
	IF_S_SELECT_PRDT_INFO(CommonConstants.CIS_API_ID_IF_S_SELECT_PRDT_INFO, HttpMethod.POST, CommonConstants.CIS_API_SYSTEM_SHOP, CommonConstants.CIS_API_CONTENT_TP_JSON, CommonConstants.CIS_API_RES_JSON),
	/** SHOP 주문 등록 */
	IF_R_INSERT_ORDR_INFO(CommonConstants.CIS_API_ID_IF_R_INSERT_ORDR_INFO, HttpMethod.POST, CommonConstants.CIS_API_SYSTEM_SHOP, CommonConstants.CIS_API_CONTENT_TP_JSON, CommonConstants.CIS_API_RES_JSON),
	/** SHOP 주문 조회 */
	IF_S_SELECT_ORDR_LIST(CommonConstants.CIS_API_ID_IF_S_SELECT_ORDR_LIST, HttpMethod.POST, CommonConstants.CIS_API_SYSTEM_SHOP, CommonConstants.CIS_API_CONTENT_TP_JSON, CommonConstants.CIS_API_RES_JSON),
	/** SHOP 주문 취소 */
	IF_R_CANCEL_ORDR_INFO(CommonConstants.CIS_API_ID_IF_R_CANCEL_ORDR_INFO, HttpMethod.POST, CommonConstants.CIS_API_SYSTEM_SHOP, CommonConstants.CIS_API_CONTENT_TP_JSON, CommonConstants.CIS_API_RES_JSON),
	/** SHOP 반품 등록 */
	IF_R_RETURN_ORDR_INFO(CommonConstants.CIS_API_ID_IF_R_RETURN_ORDR_INFO, HttpMethod.POST, CommonConstants.CIS_API_SYSTEM_SHOP, CommonConstants.CIS_API_CONTENT_TP_JSON, CommonConstants.CIS_API_RES_JSON),
	/** SHOP 반품 조회 */
	IF_S_SELECT_RTNS_LIST(CommonConstants.CIS_API_ID_IF_S_SELECT_RTNS_LIST, HttpMethod.POST, CommonConstants.CIS_API_SYSTEM_SHOP, CommonConstants.CIS_API_CONTENT_TP_JSON, CommonConstants.CIS_API_RES_JSON),
	/** SHOP 반품 취소 */
	IF_R_CANCEL_RTNS_INFO(CommonConstants.CIS_API_ID_IF_R_CANCEL_RTNS_INFO, HttpMethod.POST, CommonConstants.CIS_API_SYSTEM_SHOP, CommonConstants.CIS_API_CONTENT_TP_JSON, CommonConstants.CIS_API_RES_JSON),
	/** SHOP 슬롯 조회 */
	IF_S_SELECT_SLOT_LIST(CommonConstants.CIS_API_ID_IF_S_SELECT_SLOT_LIST, HttpMethod.POST, CommonConstants.CIS_API_SYSTEM_SHOP, CommonConstants.CIS_API_CONTENT_TP_JSON, CommonConstants.CIS_API_RES_JSON),
	/** SHOP 권역 조회 */
	IF_S_SELECT_RNGE_LIST(CommonConstants.CIS_API_ID_IF_S_SELECT_RNGE_LIST, HttpMethod.POST, CommonConstants.CIS_API_SYSTEM_SHOP, CommonConstants.CIS_API_CONTENT_TP_JSON, CommonConstants.CIS_API_RES_JSON),
	/** SHOP 주문 수정 */
	IF_R_UPDATE_ORDR_INFO(CommonConstants.CIS_API_ID_IF_R_UPDATE_ORDR_INFO, HttpMethod.POST, CommonConstants.CIS_API_SYSTEM_SHOP, CommonConstants.CIS_API_CONTENT_TP_JSON, CommonConstants.CIS_API_RES_JSON),
	/** SHOP 반품 수정 */
	IF_R_UPDATE_RTNS_INFO(CommonConstants.CIS_API_ID_IF_R_UPDATE_RTNS_INFO, HttpMethod.POST, CommonConstants.CIS_API_SYSTEM_SHOP, CommonConstants.CIS_API_CONTENT_TP_JSON, CommonConstants.CIS_API_RES_JSON),
	/** 단품 상품 조회 */
	IF_S_SELECT_SKU_INFO(CommonConstants.CIS_API_ID_IF_S_SELECT_SKU_INFO, HttpMethod.POST, CommonConstants.CIS_API_SYSTEM_SHOP, CommonConstants.CIS_API_CONTENT_TP_JSON, CommonConstants.CIS_API_RES_JSON),
	/** 단품 상품 등록 */
	IF_R_INSERT_SKU_INFO(CommonConstants.CIS_API_ID_IF_R_INSERT_SKU_INFO, HttpMethod.POST, CommonConstants.CIS_API_SYSTEM_SHOP, CommonConstants.CIS_API_CONTENT_TP_JSON, CommonConstants.CIS_API_RES_JSON),
	/** 단품 상품 수정 */
	IF_R_UPDATE_SKU_INFO(CommonConstants.CIS_API_ID_IF_R_UPDATE_SKU_INFO, HttpMethod.POST, CommonConstants.CIS_API_SYSTEM_SHOP, CommonConstants.CIS_API_CONTENT_TP_JSON, CommonConstants.CIS_API_RES_JSON),
	/** 상품 등록 */
	IF_R_INSERT_PRDT_INFO(CommonConstants.CIS_API_ID_IF_R_INSERT_PRDT_INFO, HttpMethod.POST, CommonConstants.CIS_API_SYSTEM_SHOP, CommonConstants.CIS_API_CONTENT_TP_JSON, CommonConstants.CIS_API_RES_JSON),
	/** 상품 수정 */
	IF_R_UPDATE_PRDT_INFO(CommonConstants.CIS_API_ID_IF_R_UPDATE_PRDT_INFO, HttpMethod.POST, CommonConstants.CIS_API_SYSTEM_SHOP, CommonConstants.CIS_API_CONTENT_TP_JSON, CommonConstants.CIS_API_RES_JSON),
	/** 브랜드 등록 */
	IF_R_INSERT_BRAND_INFO(CommonConstants.CIS_API_ID_IF_R_INSERT_BRAND_INFO, HttpMethod.POST, CommonConstants.CIS_API_SYSTEM_SHOP, CommonConstants.CIS_API_CONTENT_TP_JSON, CommonConstants.CIS_API_RES_JSON),
	/** 브랜드 수정 */
	IF_R_UPDATE_BRAND_INFO(CommonConstants.CIS_API_ID_IF_R_UPDATE_BRAND_INFO, HttpMethod.POST, CommonConstants.CIS_API_SYSTEM_SHOP, CommonConstants.CIS_API_CONTENT_TP_JSON, CommonConstants.CIS_API_RES_JSON),
	/** 상품 재고 조회 */
	IF_S_SELECT_STOCK_LIST(CommonConstants.CIS_API_ID_IF_S_SELECT_STOCK_LIST, HttpMethod.POST, CommonConstants.CIS_API_SYSTEM_SHOP, CommonConstants.CIS_API_CONTENT_TP_JSON, CommonConstants.CIS_API_RES_JSON),
	/** 출고 차수 생성 여부 조회 */
	IF_R_CHECK_SHP_SEQ(CommonConstants.CIS_API_ID_IF_R_CHECK_SHP_SEQ, HttpMethod.POST, CommonConstants.CIS_API_SYSTEM_SHOP, CommonConstants.CIS_API_CONTENT_TP_JSON, CommonConstants.CIS_API_RES_JSON),
	/** 게이트웨이 */
	IF_R_GATEWAY_INFO(CommonConstants.CIS_API_ID_IF_R_GATEWAY_INFO, HttpMethod.POST, CommonConstants.CIS_API_SYSTEM_GATEWAY, CommonConstants.CIS_API_CONTENT_TP_JSON, CommonConstants.CIS_API_RES_JSON),
	;

	private String apiId;
	private HttpMethod httpMethod;
	private String systemType;
	private String headerType;
	private String returnType;

	private CisApiSpec(String apiId, HttpMethod httpMethod, String systemType, String headerType, String returnType) {
		this.apiId = apiId;
		this.httpMethod = httpMethod;
		this.systemType = systemType;
		this.headerType = headerType;
		this.returnType = returnType;
	}

}
