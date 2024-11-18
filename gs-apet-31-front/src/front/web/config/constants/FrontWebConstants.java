package front.web.config.constants;

import framework.front.constants.FrontConstants;



/**
* <pre>
* - 프로젝트명	: 31.front.web
* - 패키지명	: front.web.config.constants
* - 파일명		: FrontWebConstants.java
* - 작성일		: 2016. 3. 2.
* - 작성자		: snw
* - 설명		:
* </pre>
*/
public class FrontWebConstants extends FrontConstants{

	public static final int AJAX_LOGIN_POPUP_SESSION_ERROR_OD = 461;
	public static final int AJAX_LOGIN_POPUP_SESSION_ERROR_ODS = 462;

	public static final int AJAX_LOGIN_SESSION_ERROR_OD = 451;
	public static final int AJAX_LOGIN_SESSION_ERROR_ODS = 452;


	public static final String EVENT_KIND_EXHIBITION = "h";

	public static final String CATEGORY_GB_NEW = "NEW";
	public static final String CATEGORY_GB_BEST = "BEST";
	public static final String CATEGORY_GB_NORMAL = "NORMAL";
	public static final String CATEGORY_GB_SEARCH = "SEARCH";

	/* 마이페이지 메뉴 관련 */
	public static final String MYPAGE_MENU_GB = "mgb";

	public static final String MYPAGE_MENU_ORDER_DELIVERY = "od";
	public static final String MYPAGE_MENU_ORDER_CLAIM = "oc";
	public static final String MYPAGE_MENU_ORDER_RECEIPT = "or";

	public static final String MYPAGE_MENU_INQUIRY_REQUEST = "iqr";
	public static final String MYPAGE_MENU_INQUIRY_ANSWER = "iqa";

	public static final String MYPAGE_MENU_CC_ASSEMBLE = "ca";

	public static final String MYPAGE_MENU_INTEREST_WISH = "itw";

	public static final String MYPAGE_MENU_BENEFIT_COUPON = "bc";
	public static final String MYPAGE_MENU_BENEFIT_SAVE_MONEY = "bsn";

	public static final String MYPAGE_MENU_SERVICE_ADDRESS = "sa";
	public static final String MYPAGE_MENU_SERVICE_GOODS_COMMENT = "sgc";
	public static final String MYPAGE_MENU_SERVICE_GOODS_INQUIRY = "sgi";

	public static final String MYPAGE_MENU_INFO_MANAGE = "ifm";
	public static final String MYPAGE_MENU_INFO_LEAVE = "ifl";

	public static final String MYPAGE_MENU_NOMEM_INQUIRY_REQUEST = "nmiqr";
	public static final String MYPAGE_MENU_NOMEM_ORDER_DELIVERY = "nmod";
	public static final String MYPAGE_MENU_NOMEM_ORDER_CLAIM = "nmoc";
	public static final String MYPAGE_MENU_NOMEM_ORDER_RECEIPT = "nmor";

	/* 고객센터 메뉴 관련 */
	public static final String CUSTOMER_MENU_GB = "cgb";
	
	public static final String CUSTOMER_MENU_FAQ = "cf";
	public static final String CUSTOMER_MENU_NOTICE = "cn";
	public static final String CUSTOMER_MENU_INQUIRY = "ci";
	public static final String CUSTOMER_MENU_CONTECT = "cc";

	/** 주문 진행상태 : 주문결제 */
	public static final String ORDER_STEP_2 ="step2";
	/** 주문 진행상태 : 주문완료 */
	public static final String ORDER_STEP_3 ="step3";

	/** 리스트 타입 : 일반 */
	public static final String LIST_TYPE_NORMAL = "NM";
	/** 리스트 타입 : 간편 */
	public static final String LIST_TYPE_SIMPLE = "SP";

	/** 상품 정렬 타입 : 신상품순 */
	public static final String SORT_TYPE_NEW = "NW";
	/** 상품 정렬 타입 : 인기상품순 */
	public static final String SORT_TYPE_POPULAR = "PP";
	/** 상품 정렬 타입 : 상품평순 */
	public static final String SORT_TYPE_COMMENT = "CM";
	/** 상품 정렬 타입 : 낮은가격순 */
	public static final String SORT_TYPE_PRICE_LOW = "PL";
	/** 상품 정렬 타입 : 높은가격순 */
	public static final String SORT_TYPE_PRICE_HIGH = "PH";
	/** 상품 정렬 타입 : 상품리뷰순 */
	public static final String SORT_TYPE_REVIEW = "RV";
	/** 정렬 타입 : 마감임박순 */
	public static final String SORT_TYPE_END_DTM = "ED";
	/** 정렬 타입 : 일주일이내 등록 */
	public static final String SORT_TYPE_WEEK = "WE";



	/** 추천상품타이틀 배너TEXT */
	public static final Integer DT_BIG_RECO_BNR_TITLE = 115;

	/** 베스트 타이틀 배너TEXT */
	public static final Integer DT_BIG_BEST_BNR_TITLE =97;

	/** 신상품 타이틀 배너TEXT */
	public static final Integer DT_BIG_NEW_BNR_TITLE =120;
	/** 신상품목록 */
	public static final Integer DT_BIG_NEW_GOODS =89;

	/** 베스트 리뷰 타이틀 배너TEXT */
	public static final Integer DT_BIG_EVAL_BNR_TITLE =121;
	/**  베스트 리뷰 */
	public static final Integer DT_BIG_GOODS_EVAL =90;


	/**  소카 코너목록 */
	/** 주력상품 목록 */
	public static final Integer DT_SMALL_BEST_GOODS = 74;

	/********** 비정형 매장 **********/
	/** 스페셜 */
	public static final Long DT_SPECIAL_NEW_BNRIMG = 84L;

	/** 이벤트 전시분류번호 */
	public static final Long DT_EVENT_DISP_CLSF_NO = 30120L;

	/** 블라스코 이벤트 전시분류번호 */
	public static final Long BL_EVENT_DISP_CLSF_NO = 30100196L;

	/** 이벤트 */
	public static final Long DT_EVENT_BNRIMG = 175L;

	/** 시리즈 */
	public static final Long DT_SERIES_BNRIMG =132L;




	/** 전시코너 타입코드 10 : 배너 HTML */
	public static final String DISP_CORN_TP_CD10 = "10";

	/** 전시코너 타입코드 20 : 배너 TEXT */
	public static final String DISP_CORN_TP_CD20 = "20";

	/** 전시코너 타입코드 30 : 배너 이미지 */
	public static final String DISP_CORN_TP_CD30 = "30";

	/** 전시코너 타입코드 40 : 배너 이미지(큐브) */
	public static final String DISP_CORN_TP_CD40 = "40";

	/** 전시코너 타입코드 50 : 배너 복합 */
	public static final String DISP_CORN_TP_CD50 = "50";

	/** 전시코너 타입코드 60 : 상품 */
	public static final String DISP_CORN_TP_CD60 = "60";

	/** 전시코너 타입코드 70 : 상품평 */
	public static final String DISP_CORN_TP_CD70 = "70";

	/** 카테고리 NEW : 신상품 전시코너번호 (상단배너이미지) */
	public static final Long NEW_CATEGORY_DISP_CORN_NO = 256L;
	public static final Long NEW_CATEGORY_DISP_CLSF_NO = 300000004L;

	/** 카테고리 NEW : 신상품 전시코너번호 (상품) */
	public static final Long NEW_CATEGORY_DISP_CORN_NO_GOODS = 230L;

	/** 카테고리 BEST : BEST 전시코너번호 (상품) */
	public static final Long BEST_CATEGORY_DISP_CORN_NO_GOODS = 237L;


	/** 브랜드 시리즈 : 브랜드 시리즈 전시분류번호 */
	public static final Long BRAND_SERIES_DISP_CLSF_NO = 30114L;

	public static final Long BRAND_SERIES_DISP_CORN_NO_TOP_BNRIMG = 132L;
	//public static final Integer BRAND_SERIES_DISP_CORN_NO_TOP_BNRIMG = 217;

	/** 브랜드 시리즈 : 브랜드 시리즈 전시코너번호(하단배너이미지) */
	public static final Long BRAND_SERIES_DISP_CORN_NO_BOTTOM_BNRIMG = 133L;
	//public static final Integer BRAND_SERIES_DISP_CORN_NO_BOTTOM_BNRIMG = 218;

	/**(조건)날짜 기간*/
	public static final String PERIOD_1 = "1";

	public static final String PERIOD_3 = "3";

	public static final String PERIOD_6 = "6";

	public static final String PERIOD_12 = "12";

	// =======================================================
	// 전시 : DSP
	// =======================================================
	/** 비정형 페이지 펫샵 전시번호*/
	public static final Long DISP_CLSF_NO_PETSHOP = 300000164L;
	/** 비정형 페이지 펫TV 전시번호*/
	public static final Long DISP_CLSF_NO_PETTV = 300000171L;
	/** 비정형 페이지 펫로그 전시번호*/
	public static final Long DISP_CLSF_NO_PETLOG = 300000163L;

	//SNS 연동하기 Session Key
	public static final String SESSION_CHECK_CODE = "checkCode";
	public static final String SESSION_SNS_LNK_CD_KEY = "connectSnsLnkCd";
	public static final String SESSION_SNS_CONNECT_MEMBER = "mbrNo";

}