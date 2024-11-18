package framework.common.enums;

import org.springframework.http.HttpMethod;

import framework.common.constants.CommonConstants;
import lombok.Getter;


@Getter
public enum SearchApiSpec {

	/** 통합검색 */
	SRCH_API_IF_SEARCH(
			CommonConstants.SRCH_API_ID_SEARCH
			, HttpMethod.POST
			, CommonConstants.SRCH_API_URL_SEARCH
			, CommonConstants.CIS_API_CONTENT_TP_JSON
			, CommonConstants.CIS_API_RES_JSON)
	/** 자동완성 */
	, SRCH_API_IF_AUTOCOMPLETE(
			CommonConstants.SRCH_API_ID_AUTOCOMPLETE
			, HttpMethod.POST
			, CommonConstants.SRCH_API_URL_AUTOCOMPLETE
			, CommonConstants.CIS_API_CONTENT_TP_JSON
			, CommonConstants.CIS_API_RES_JSON)
	/** 인기검색어 */
	, SRCH_API_IF_POPQUERY(
			CommonConstants.SRCH_API_ID_POPQUERY
			, HttpMethod.POST
			, CommonConstants.SRCH_API_URL_POPQUERY
			, CommonConstants.CIS_API_CONTENT_TP_JSON
			, CommonConstants.CIS_API_RES_JSON)
	/** 추천검색어 */
	, SRCH_API_IF_RECOMMEND_KEYWORD(
			CommonConstants.SRCH_API_ID_RECOMMEND_KEYWORD
			, HttpMethod.POST
			, CommonConstants.SRCH_API_URL_RECOMMEND_KEYWORD
			, CommonConstants.CIS_API_CONTENT_TP_JSON
			, CommonConstants.CIS_API_RES_JSON)
	/** 상품 상세검색 상세조건 및 브랜드 집계 */
	, SRCH_API_IF_GOODS_FILTER_AGGREGATION(
			CommonConstants.SRCH_API_ID_GOODS_FILTER_AGGREGATION
			, HttpMethod.POST
			, CommonConstants.SRCH_API_URL_GOODS_FILTER_AGGREGATION
			, CommonConstants.CIS_API_CONTENT_TP_JSON
			, CommonConstants.CIS_API_RES_JSON)
	/** 추천(TV/LOG/SHOP/해쉬태그/사용자) */
	, SRCH_API_IF_RECOMMEND(
			CommonConstants.SRCH_API_ID_RECOMMEND
			, HttpMethod.POST
			, CommonConstants.SRCH_API_URL_RECOMMEND
			, CommonConstants.CIS_API_CONTENT_TP_JSON
			, CommonConstants.CIS_API_RES_JSON)
	/**사용자 액션로그 */
	, SRCH_API_IF_ACTION(
			CommonConstants.SRCH_API_ID_ACTION_KEYWORD
			, HttpMethod.POST
			, CommonConstants.SRCH_API_URL_ACTION
			, CommonConstants.CIS_API_CONTENT_TP_JSON
			, CommonConstants.CIS_API_RES_JSON)
	/** 추천일치율 */
	, SRCH_API_IF_RECOMMENDRATE(
			CommonConstants.SRCH_API_ID_RECOMMEND
			, HttpMethod.POST
			, CommonConstants.SRCH_API_URL_RECOMMENDRATE
			, CommonConstants.CIS_API_CONTENT_TP_JSON
			, CommonConstants.CIS_API_RES_JSON)
	;

	private String apiId;
	private HttpMethod httpMethod;
	private String apiUrl;
    private String contentType;
	private String returnType;


	private SearchApiSpec(String apiId, HttpMethod httpMethod, String apiUrl, String contentType, String returnType) {
		this.apiId = apiId;
		this.httpMethod = httpMethod;
		this.apiUrl = apiUrl;
		this.contentType = contentType;
		this.returnType = returnType;
	}

}
