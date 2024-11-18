package framework.front.constants;

import framework.common.constants.CommonConstants;

/**
 * Front Constants
 * 
 * @author valueFactory
 * @since 2015. 06. 11.
 */
public class FrontConstants extends CommonConstants {

	public static final int AJAX_LOGIN_POPUP_SESSION_ERROR = 460;

	public static final String CACHE_DISPLAY_CATEGORY = "cache_display_category";

	public static final Integer PAGE_ROWS_1 = 1;
	public static final Integer PAGE_ROWS_2 = 2;
	public static final Integer PAGE_ROWS_3 = 3;
	public static final Integer PAGE_ROWS_4 = 4;
	public static final Integer PAGE_ROWS_5 = 5;
	public static final Integer PAGE_ROWS_6 = 6;
	public static final Integer PAGE_ROWS_8 = 8;
	public static final Integer PAGE_ROWS_9 = 9;
	public static final Integer PAGE_ROWS_10 = 10;
	public static final Integer PAGE_ROWS_12 = 12;
	public static final Integer PAGE_ROWS_15 = 15;	
	public static final Integer PAGE_ROWS_16 = 16;
	public static final Integer PAGE_ROWS_18 = 18;
	public static final Integer PAGE_ROWS_20 = 20;
	public static final Integer PAGE_ROWS_25 = 25;
	public static final Integer PAGE_ROWS_30 = 30;
	public static final Integer PAGE_ROWS_40 = 40;
	public static final Integer PAGE_ROWS_24 = 24;
	public static final Integer PAGE_ROWS_100 = 100;
	
	public static final String	SORD_ASC = "asc";
	public static final String	SORD_DESC = "desc";

	public static final String FORBIDDEN_VIEW_NAME = "exception/forbidden";
	public static final String NOT_FOUND_VIEW_NAME = "exception/error404";
	public static final String XSS_VIEW_NAME = "exception/xss-no-access";
	public static final String EXCEPTION_VIEW_NAME = "exception/error";
	public static final String EXCEPTION_VIEW_GOODS = "common/exception/goodsError";
	public static final String FORBIDDEN_FORWARD = "forward:/error/403/";
	public static final String NOT_FOUND_FORWARD = "forward:/error/404/";
	public static final String EXCEPTION_FORWARD = "forward:/error/500/";
	public static final String PAYMENTEXCEPTION_VIEW_NAME = "common/exception/paymentError";

	/** 게시판 : 공지사항 아이디 */
	public static final String BBS_ID_NOTICE 	= "dwNotice";
	/** 게시판 : FAQ 아이디 */
	public static final String BBS_ID_FAQ		= "dwFaq";
	
	/** 비밀번호 체크 타입 : 회원정보수정 */
	public static final String PSWD_CHECK_TYPE_INFO = "MNG";
	/** 비밀번호 체크 타입 : 회원탈퇴 */
	public static final String PSWD_CHECK_TYPE_LEAVE = "LEV";

	/** 장바구니 주문 유형 : 일반 주문 */
	public static final String CART_ORDER_TYPE_NORMAL = "NORMAL";
	/** 장바구니 주문 유형 : 바로 주문 */
	public static final String CART_ORDER_TYPE_ONCE = "ONCE";

	/** 로그인 화면 유형 : 비회원 주문 */
	public static final String LOGIN_TYPE_NO_MEM_ORDER = "NMOD";
	/** 로그인 화면 유형 : 비회원 주문 조회 */
	public static final String LOGIN_TYPE_NO_MEM_ORDER_SEARCH = "NMODS";

	/** 휴면관련 세션 Param */
	public static final String SESSION_MEMBER_MBR_NO = "mbrNo";

	/** 주문관련 세션 Param */
	public static final String SESSION_ORDER_PARAM_NAME = "order";
	public static final String SESSION_ORDER_PARAM_TYPE = "orderType";
	public static final String SESSION_ORDER_PARAM_CART_IDS = "cartIds";
	public static final String SESSION_ORDER_PARAM_CART_GOODS_CP_INFOS = "cartGoodsCpInfos";
	public static final String SESSION_ORDER_PARAM_CART_YN = "cartYn";
	public static final String SESSION_ORDER_PARAM_CART_IDS_SEPARATOR = "^";

	/** 비회원관련 세션 Param */
	public static final String SESSION_NO_MEMBER_ORDER_NO_PARAM_NAME = "noMemOrdNo";
	public static final String SESSION_NO_MEMBER_CHECK_CODE_PARAM_NAME = "noMemCheckCd";
	
	/** sns회원가입 세션 Param*/
	public static final String SESSION_SNS_LOGIN_INFO = "snsLoginInfo";
	/** 회원가입 insert된 정보 세션 Param*/
	public static final String SESSION_JOIN_MEMBER_INFO = "joinMemberInfo";
	/** 회원가입 시 본인인증 값*/
	public static final String SESSION_JOIN_MEMBER_CRTF = "joinMemberCrtf";
	/** SNS로그인 시 리턴 URL */
	public static final String SESSION_LOGIN_RETURN_URL = "loginReturnUrl";
	/** 비밀번호 변경시 사용할 세션 */
	public static final String SESSION_UPDATE_PSWD = "updatePswd";
	/** 하루펫츠비 사용할 세션 */
	public static final String SESSION_UPDATE_HRPB = "updateHrpb";
	/** 하루펫츠비 비밀번호 변경시 사용할 세션 */
	public static final String SESSION_HRPB_UPDATE_PSWD = "updateHrpbPswd";
	/** 펫츠비 로그인 관련 otp 세션 */
	public static final String MEMBER_LOGIN_CFT_CD_PHONE = "memberLoginCtfCdPhone";
	public static final String MEMBER_LOGIN_CFT_CD_EMAIL = "memberLoginCtfCdEmail";
	/** sns로그인 시 스크립트에서 갖고온 토큰 저장*/
	public static final String SESSION_SNS_TOKEN = "snsToken";
	/** 추천받아 회원가입 시 sns로 회원가입 한 경우*/
	public static final String SESSION_INVITE_SNS = "inviteSns";
	/**로그인 상태 처리 시 쓸 mbrNo*/
	public static final String SESSION_LOGIN_MBR_NO = "loginMbrNo";
	/** sns 연동 시 기존회원 휴면인 경우 휴면 해제 후 연동하기 위한 세션*/
	public static final String SESSION_SNS_CONNECT_DORMANT = "snsConnectDormant";
	
	
	/** 전시 우선 순위 */
	public static final Long DISP_PRIOR_RANK_1 = 1L;
	
	/** 전시레벨 : 카테고리 상 */
	public static final Integer DISP_LVL_1 = 1;

	/** 전시레벨 : 카테고리 중 */
	public static final Long DISP_LVL_2 = 2L;

	/** 전시레벨 : 카테고리 하 */
	public static final Long DISP_LVL_3 = 3L;

	/** 모바일 최근 주문 검색 개월수 */
	public static final Long MO_RECENT_ORDER_PERIOD = 1L;
	
	// 최근 상품의 쿠키의 Key
	public static final Integer COOKIE_RECENT_MAX_COUNT = 50;
	/** 장바구니 담기 최대 수*/
	public static final Integer CART_MAX_COUNT = 50;
	
	public static final String COOKIE_POPUP_NAME = "#popDispClsfNo";
	
	public static final Long DEF_COMP_NO = 1L;

	public static final String SESSION_STATE_FACE_BOOK = "facebook_oauth_state";
	public static final String SESSION_STATE_KAKAO = "kakao_oauth_state";
	public static final String SESSION_STATE_GOOGLE = "google_oauth_state";
	public static final String SESSION_STATE_NAVER = "naver_oauth_state";
	public static final String SESSION_STATE_APPLE = "apple_oauth_state";

	/** 인증 방법 코드 */
	public static final String CTF_MTD = "CTF_MTD";
	/** 인증 방법 코드 : OTP인증 */
	public static final String CTF_MTD_OTP = "10";				
	/** 인증 방법 코드 : 본인인증(모바일) */
	public static final String CTF_MTD_MOBILE = "20";				
	/** 인증 방법 코드 : 이메일 */
	public static final String CTF_MTD_EMAIL = "30";	
	
	
	/** 인증유형코드 */
	public static final String CTF_TP = "CTF_CD";
	/** 인증유형코드: 회원가입 */
	public static final String CTF_TP_JOIN = "10";
	/** 인증유형코드: 비밀번호변경 */
	public static final String CTF_TP_UPD_PWD = "20";
	/** 인증유형코드 : 비밀번호 찾기*/
	public static final String CTF_TP_FIND_PWD = "30";
	/** 인증유형코드: 모바일 번호 변경 */
	public static final String CTF_TP_UPD_MOB = "40";
	/** 인증유형코드: GS&포인트 조회 */
	public static final String CTF_TP_GSR_POINT = "50";
	/** 인증유형코드: 간편카드 등록 */
	public static final String CTF_TP_CARD = "60";
	/** 인증유형코드: 상품주문 */
	public static final String CTF_TP_ORDER = "70";
	/** 인증유형코드: 기존회원인증 */
	public static final String CTF_TP_PBHR = "80";
	
	/** 쿠폰 팝업 유형 */
	/** 쿠폰 팝업 유형 : 장바구니(상품 쿠폰 조회) */
	public static final String CP_POP_TP_CART = "00";
	/** 쿠폰 팝업 유형 : 주문서 상품/배송비 쿠폰 */
	public static final String CP_POP_TP_ORD = "10";
	/** 쿠폰 팝업 유형 : 주문서 장바구니 쿠폰 */
	public static final String CP_POP_TP_ORD_CART = "20";
	
	// 최근 본 상품
	public static final String COOKIE_RECENT_GOODS = "apetRcntGoods";
	//아이디 저장 쿠키의 key
	public static final String COOKIE_REMEMBER_LOGIN_ID = "keepYn";
	//expire 시간
	public static final String COOKIE_SESSION_EXPIRE = "expire";
	
	/** PC 이벤트팝업 쿠키의 Key */
	public static final String COOKIE_POP_LAYER_EVENT_PC = "popLayerEvent_PC";
	/** MO 이벤트팝업 쿠키의 Key */
	public static final String COOKIE_POP_LAYER_EVENT_MO = "popLayerEvent_MO";
	/** APP 이벤트팝업 쿠키의 Key */
	public static final String COOKIE_POP_LAYER_EVENT_APP = "popLayerEvent_APP";
}