package framework.common.constants;

import framework.common.util.FileUtil;

/**
 * 공통 상수 정의
 * 
 * @author valueFactory
 * @since 2017. 02. 16.
 */
public class CommonConstants {
	
	//======================================================================================================
	//== 상수 정의
	//======================================================================================================

	/****************************
	 * 개발환경 구분
	 ****************************/
	public static final String ENVIRONMENT_GB_LOCAL = "local";
	public static final String ENVIRONMENT_GB_DEV = "dev";
	public static final String ENVIRONMENT_GB_STG = "stg";
	public static final String ENVIRONMENT_GB_OPER = "prd";

	/****************************
	 * 프로젝트 구분
	 ****************************/
	public static final String PROJECT_GB_FRONT = "front";
	public static final String PROJECT_GB_ADMIN = "admin";
	public static final String PROJECT_GB_BATCH = "batch";
	public static final String PROJECT_GB_INTERFACE = "interface";
	
	/****************************
	 * ModelMap Key
	 ****************************/
	public static final String MODEL_MAP_KEY_VIEW = "view";
	public static final String MODEL_MAP_KEY_SESSION = "session";
	
	/****************************
 	 * 채널
	 ****************************/
	public static final Long DEFAULT_CHANNEL_ID = 1L;
	public static final Long OPENMARKET_11ST_CHANNEL_ID = 2L;
	
	/****************************
	 * CACHE
 	 ****************************/
	public static final String CACHE_CODE = "cache_code";
	public static final String CACHE_CODE_GROUP = "cache_code_group";
	public static final String CACHE_CODE_VALUE = "cache_code_value";
		
	/****************************
 	 * Controller Result Code
	 ****************************/
	public static final String CONTROLLER_RESULT_CODE = "resultCode";
	public static final String CONTROLLER_RESULT_MSG = "resultMsg";
	public static final String CONTROLLER_RESULT_CODE_SUCCESS = "S";
	public static final String CONTROLLER_RESULT_CODE_FAIL = "F";
	public static final String CONTROLLER_RESULT_CODE_LEAVE = "L";
	public static final String CONTROLLER_RESULT_CODE_NOT_USE = "N";
	
	/****************************
 	 * View Name
	 ****************************/
	public static final String JSON_VIEW_NAME = "jsonView";
	public static final String EXCEL_VIEW_NAME = "excelView";
	public static final String IMAGE_VIEW_NAME = "imageView";
	public static final String FILE_VIEW_NAME = "fileView";
	public static final String FILE_URL_VIEW_NAME = "fileUrlView";
	public static final String FILE_NCP_VIEW_NAME = "fileNcpView";
	public static final String FILE_All_VIEW_NAME = "fileAllView";
	public static final String FILE_LIST_CNT = "cnt";
	
	/****************************
 	 * Param Name
	 ****************************/
	public static final String EXCEL_PARAM_NAME = "excelParam";
	public static final String EXCEL_LIST_PARAM_NAME = "excelListParam";
	public static final String EXCEL_PASSWORD = "excelPassword";
	public static final String EXCEL_PARAM_FILE_NAME = "excelFileName";
	public static final String FILE_PARAM_NAME = "fileParam";
	public static final String EXCEL_PARAM_FILE_NAME_DATE_FORMAT = "excelFileNameDateFormat";

	
	public static final String HTTP_SESSION = "_http_session";

	public static final String SESSION_ID_COOKIE_NAME = "JSESSIONID";
	public static final String SESSION_ID_OBJECT_NAME = "sessionId";
	
	public static final int RECORD_COUNT_PAGE = 10;

	/****************************
 	 * Exception
	 ****************************/
	public static final int AJAX_LOGIN_SESSION_ERROR = 450;
	public static final String EXCEPTION_MESSAGE_COMMON = "business.exception.";
	public static final String LOG_EXCEPTION_STACK_TRACE = "EXCEPTION STACK TRACE";
	public static final String LOG_EXCEPTION_STACK_TRACE_SKIPPED = "EXCEPTION STACK TRACE SKIPPED";
	
	
	public static final String COMMON_DATE_FORMAT = "yyyy-MM-dd HH:mm:ss";
	public static final String COMMON_START_DATE = "2020-11-01 00:00:00";
	public static final String COMMON_END_DATE = "9999-12-31 23:59:59";
	public static final String COMMON_DATE_STRING_FORMAT = "yyyyMMddHHmmss";
	
	public static final String COMMON_RESET_EMAIL = "test@test.com";
	public static final String COMMON_RESET_MOBILE = "010-0000-0000";
	
	public static final String PERIOD_YEAR = "YEAR";
	public static final String PERIOD_MONTH = "MONTH";
	public static final String PERIOD_DAY = "DAY";
	
	public static final String LOG_EXCEPTION_SET_PROPERTY = "FAILURE TO SET FILE OF PROPERTIES";
	public static final String LOG_EXCEPTION_DATE = "DATE ERROR";
	public static final String LOG_EXCEPTION_DELETE_FILE ="FAIL TO DELETE OF FILE";
	
	/** 비회원 번호 */
	public static final Long NO_MEMBER_NO = 0L;
	public static final String NO_MEMBER_NM = "GUEST";
	
	/** SYSTEM 사용자 번호 */
	public static final Long SYSTEM_USR_NO = 900000002L;
	
	/** Batch 사용자 번호 */
	public static final Long COMMON_BATCH_USR_NO = 900000002L;
	
	/** Batch client ip */
	public static final String COMMON_CLIENT_IP = "127.0.0.2";
	
	/** INTERFACE 사용자 번호 openAPI */
	public static final Long INTERFACE_USR_NO = 900000003L;
	
	
	/****************************
	 * 비밀번호 초기화 시 전송 수단
	 ****************************/
	public static final String SEND_PSWD_MEANS_CD_EMAIL = "email";			// 이메일
	public static final String SEND_PSWD_MEANS_CD_SMS = "sms";				// SMS
	
	
	public static final String MOBILE_APP_ID = "veci";
	

	/** 메인 BRAND 초성검색 구분용 */
	public static final String INIT_CHAR_K = "K";					// 한글
	public static final String INIT_CHAR_E = "E";					// 영문
	
	/** 클레임 신청 유형 코드 */
	public static final String CLAIM_ACCEPT_TP_ALL = "ALL";			// 전체
	public static final String CLAIM_ACCEPT_TP_PART = "PART";		// 상품단위
	
	/****************************
	 * 상품이미지
	 ****************************/
	
	/** 상품 임시 저장 단계 */
	public static final String GOODS_SAVE_STEP = "GOODS_SAVE_STEP";
	/** 상품 임시 저장 단계 : 기본 정보 */
	public static final String GOODS_SAVE_STEP_10 = "10"; 
	/** 상품 임시 저장 단계 : 렌탈/구매 정보 */
	public static final String GOODS_SAVE_STEP_20 = "20"; 
	/** 상품 임시 저장 단계 : 단품 정보 */
	public static final String GOODS_SAVE_STEP_30 = "30"; 
	/** 상품 임시 저장 단계 : 상품 이미지 */
	public static final String GOODS_SAVE_STEP_40 = "40"; 
	/** 상품 임시 저장 단계 : 상세 정보 */
	public static final String GOODS_SAVE_STEP_50 = "50"; 
	/** 상품 임시 저장 단계 : 전시 정보 */
	public static final String GOODS_SAVE_STEP_60 = "60"; 
	/** 상품 임시 저장 단계 : 사양 정보 */
	public static final String GOODS_SAVE_STEP_70 = "70"; 
	/** 상품 임시 저장 단계 : 전체 저장 */
	public static final String GOODS_SAVE_STEP_ALL = "99"; 
	
	
	
	//======================================================================================================
	//== 공통 코드 정의
	//======================================================================================================

	
	/****************************
	 * Common
	 ****************************/
	
	/** 기능 구분 코드 */
	public static final String ACT_GB = "ACT_GB";
	/** 기능 구분 코드 : 메인화면 */
	public static final String ACT_GB_10 = "10";				
	/** 기능 구분 코드 : 목록조회 */
	public static final String ACT_GB_20 = "20";				
	/** 기능 구분 코드 : 상세조회 */
	public static final String ACT_GB_30 = "30";				
	/** 기능 구분 코드 : 등록 */
	public static final String ACT_GB_40 = "40";				
	/** 기능 구분 코드 : 수정 */
	public static final String ACT_GB_50 = "50";				
	/** 기능 구분 코드 : 삭제 */
	public static final String ACT_GB_60 = "60";				
	/** 기능 구분 코드 : 저장 */
	public static final String ACT_GB_70 = "70";				
	/** 기능 구분 코드 : 서브화면 */
	public static final String ACT_GB_80 = "80";				
	/** 기능 구분 코드 : 팝업화면 */
	public static final String ACT_GB_90 = "90";				
	
	
	/** 사용자 그룹 코드 */
	public static final String USR_GRP = "USR_GRP";
	/** 사용자 그룹 코드 : 내부사용자 */
	public static final String USR_GRP_10 = "10";				
	/** 사용자 그룹 코드 : 업체사용자 */
	public static final String USR_GRP_20 = "20";				
	
	
	/** 사용자 구분 코드 */
	public static final String USR_GB = "USR_GB";
	/** 사용자 구분 코드 : 관리자 */
	public static final String USR_GB_1010 = "1010";			
	/** 사용자 구분 코드 : MD */
	public static final String USR_GB_1020 = "1020";			
	/** 사용자 구분 코드 : 임의 발급 */
	public static final String USR_GB_1030 = "1030";			
	/** 사용자 구분 코드 : CS 담당 */
	@Deprecated
	public static final String USR_GB_1031 = "1031";
	/** 사용자 구분 코드 : CS총괄 */
	public static final String USR_GB_1050 = "1050";
	/** 사용자 구분 코드 : 상위업체관리자 */
	@Deprecated
	public static final String USR_GB_2010 = "2010";			
	/** 사용자 구분 코드 : 하위업체관리자 */
	@Deprecated
	public static final String USR_GB_2020 = "2020";			
	/** 사용자 구분 코드 : 제휴사 관리자 */
	public static final String USR_GB_2030 = "2030";			
	
	/** 사용자 구분 : BO 관리자 */
	public static final String USR_GB_BO = "BO";			
	/** 사용자 구분 : PO 관리자 */
	public static final String USR_GB_PO = "PO";			
	

	/** 접근 권한 코드 **/
	public static final String AUTH_NO = "AUTH_NO";
	/** 접근 권한 코드 : 메뉴 권한 **/
	public static final String AUTH_NO_10 = "10";
	
	
	/** 사용자 상태 코드 */
	public static final String USR_STAT = "USR_STAT";
	@Deprecated
	/** 사용자 상태 코드 : 임시비밀번호 발급 */
	public static final String USR_STAT_10 = "10";				
	/** 사용자 상태 코드 : 사용 */
	public static final String USR_STAT_20 = "20";				
	/** 사용자 상태 코드 : 기간만료 */
	public static final String USR_STAT_30 = "30";				
	/** 사용자 상태 코드 : 사용불가 */
	public static final String USR_STAT_40 = "40";				
	
	
	/** 신청자 구분 코드 */
	public static final String APCT_GB = "APCT_GB";
	/** 신청자 구분 코드 : 개인 */
	public static final String APCT_GB_10 = "10";				
	/** 신청자 구분 코드 : 법인 */
	public static final String APCT_GB_20 = "20";				
	
	
	/** 첨부 파일 수 */
	public static final String ATCH_FL_CNT = "ATCH_FL_CNT";
	
	
	/** 게시판 유형 코드 */
	public static final String BBS_TP = "BBS_TP";
	/** 게시판 유형 코드 : 공지사항 */
	public static final String BBS_TP_10 = "10";				
	/** 게시판 유형 코드 : 이용후기 */
	public static final String BBS_TP_11 = "11";				
	/** 게시판 유형 코드 : FAQ */
	public static final String BBS_TP_20 = "20";				
	/** 게시판 유형 코드 : 게시판 */
	public static final String BBS_TP_30 = "30";				
	/** 게시판 유형 코드 : 매거진 */
	public static final String BBS_TP_40 = "40";				
	/** 게시판 유형 코드 : 동영상 */
	public static final String BBS_TP_41 = "41";				
	
	/** 게시판 구분 이름 : 공지 */
	public static final String BBS_GB_NM_NOTICE = "공지";
	/** 게시판 구분 이름 : 입점 / 제휴문의 */
	public static final String BBS_GB_NM_PARTNER = "입점제휴문의";
	/** 게시판 구분 이름 : 입점 및 제휴 관련 문의 공지사항*/ 
	public static final String BBS_GB_NM_PARTNER_INFO = "입점 제휴 문의 안내";
		
	
	
	/** 게시 상태 코드*/
	public static final String BBS_STAT_CD = "BBS_STAT_CD";
	/** 게시 상태 코드 : 게시 예정*/
	public static final String BBS_STAT_WILL = "10";
	/** 게시 상태 코드 : 게시 중*/
	public static final String BBS_STAT_SHOW = "20";			
	/** 게시 상태 코드 : 게시 중지*/
	public static final String BBS_STAT_PAUSE = "30";			
	
	/** 게시판 상단 고정 여부 */
	public static final String TOP_FIX_YN = "TOP_FIX_YN";
	/** 게시판 상단 고정 여부 : 예 */
	public static final String TOP_FIX_YN_Y = "Y";
	/** 게시판 상단 고정 여부 : 아니오 */
	public static final String TOP_FIX_YN_N = "N";
	
	/** POC 메뉴 코드 */
	public static final String POC_MENU = "POC_MENU";
	/** POC 메뉴 코드 */
	public static final String POC_MENU_01 = "01";
	/** POC 메뉴 코드 */
	public static final String POC_MENU_02 = "02";
	
	/** POC 구분 코드 */
	public static final String POC_GB = "POC_GB";
	/** POC구분 코드 : web*/
	public static final String POC_WEB = "10";	
	/** POC구분 코드 : 안드로이드*/
	public static final String POC_ANDR = "20";		
	/** POC구분 코드 : IOS*/
	public static final String POC_IOS = "30";				
			
	/** 파일 사용 여부 */
	public static final String FL_USE_YN = "FL_USE_YN";
	/** 파일 사용 여부 : 사용 */
	public static final String FL_USE_YN_Y = "Y";				
	/** 파일 사용 여부 : 사용안함 */
	public static final String FL_USE_YN_N = "N";				
	
	
	/** 구분 사용 여부 */
	public static final String GB_USE_YN = "GB_USE_YN";
	/** 구분 사용 여부 : 예 */
	public static final String GB_USE_YN_Y = "Y";				
	/** 구분 사용 여부 : 아니오 */
	public static final String GB_USE_YN_N = "N";				
	
	
	/** 비밀 사용 여부 */
	public static final String SCR_USE_YN = "SCR_USE_YN";
	
	
	/** 채널 구분 코드 */
	public static final String CHNL_GB = "CHNL_GB";
	/** 채널 구분 코드 : 자사 */
	public static final String CHNL_GB_10 = "10";				
	/** 채널 구분 코드 : 제휴채널 */
	public static final String CHNL_GB_20 = "20";				

	
	/** 공통 여부 */
	public static final String COMM_YN = "COMM_YN";
	/** 공통 여부 : 예 */
	public static final String COMM_YN_Y = "Y";					
	/** 공통 여부 : 아니오 */
	public static final String COMM_YN_N = "N";					

	
	/** 삭제여부 */
	public static final String DEL_YN = "DEL_YN";
	/** 삭제여부 : 예 */
	public static final String DEL_YN_Y = "Y";					
	/** 삭제여부 : 아니오 */
	public static final String DEL_YN_N = "N";					

	
	/** 전시여부 */
	public static final String DISP_YN = "DISP_YN";
	/** 전시여부 : 예 */
	public static final String DISP_YN_Y = "Y";					
	/** 전시여부 : 아니오 */
	public static final String DISP_YN_N = "N";					


	/** 노출여부 */
	public static final String SHOW_YN = "SHOW_YN";
	/** 노출여부 : 예 */
	public static final String SHOW_YN_Y = "Y";					
	/** 노출여부 : 아니오 */
	public static final String SHOW_YN_N = "N";					
	
	
	/** 사용유무 */
	public static final String USE_YN = "USE_YN";
	/** 사용유무 : 사용 */
	public static final String USE_YN_Y = "Y";					
	/** 사용유무 : 사용안함 */
	public static final String USE_YN_N = "N";					
	
	
	/** 데이터 상태 코드 */
	public static final String DATA_STAT = "DATA_STAT";
	/** 데이터 상태 코드 : 비활성 */
	public static final String DATA_STAT_00 = "00";				
	/** 데이터 상태 코드 : 활성 */
	public static final String DATA_STAT_01 = "01";				
	/** 데이터 상태 코드 : 삭제 */
	public static final String DATA_STAT_02 = "02";				

	
	/** 이메일 도메인 */
	public static final String EMAIL_ADDR = "EMAIL_ADDR";
	
	
	/** 이메일 유형 코드 */
	public static final String EMAIL_TP = "EMAIL_TP";
	/** 이메일 유형 코드 : 회원가입 */
	public static final String EMAIL_TP_100 = "100";			
	/** 이메일 유형 코드 : 회원 임시 이메일 발송 */
	public static final String EMAIL_TP_110 = "110";			
	/** 이메일 유형 코드 : 임시 비밀번호 발급 */
	public static final String EMAIL_TP_120 = "120";			
	/** 이메일 유형 코드 : 관리자 회원가입 */
	public static final String EMAIL_TP_130 = "130";			
	/** 이메일 유형 코드 : 회원탈퇴 */
	public static final String EMAIL_TP_140 = "140";			
	/** 이메일 유형 코드 : 회원 아이디 찾기 */
	public static final String EMAIL_TP_150 = "150";			
	/** 이메일 유형 코드 : 주문 접수 */
	public static final String EMAIL_TP_200 = "200";			
	/** 이메일 유형 코드 : 미입금 확인 */
	public static final String EMAIL_TP_210 = "210";			
	/** 이메일 유형 코드 : 주문 완료 */
	public static final String EMAIL_TP_220 = "220";			
	/** 이메일 유형 코드 : 상품 발송 */
	public static final String EMAIL_TP_230 = "230";			
	/** 이메일 유형 코드 : 배송 완료 */
	public static final String EMAIL_TP_240 = "240";			
	/** 이메일 유형 코드 : 주문 취소 */
	public static final String EMAIL_TP_300 = "300";			
	/** 이메일 유형 코드 : 반품 신청 */
	public static final String EMAIL_TP_310 = "310";			
	/** 이메일 유형 코드 : 교환 신청 */
	public static final String EMAIL_TP_320 = "320";			
	/** 이메일 유형 코드 : 환불 완료 */
	public static final String EMAIL_TP_330 = "330";			
	/** 이메일 유형 코드 : 1:1 문의 답변 */
	public static final String EMAIL_TP_400 = "400";			
	

	/** SMS 구분 코드 */
	public static final String SMS_GB = "SMS_GB";
	/** SMS 구분 코드 : SMS */
	public static final String SMS_GB_10 = "10";				
	/** SMS 구분 코드 : LMS */
	public static final String SMS_GB_20 = "20";				
	
	
	/** SMS 유형 코드 */
	public static final String SMS_TP = "SMS_TP";
	/** SMS 유형 코드 : 회원가입 */
	public static final String SMS_TP_100 = "100";				
	/** SMS 유형 코드 : ID 찾기 */
	public static final String SMS_TP_110 = "110";				
	/** SMS 유형 코드 : 임시 비밀번호 발급 */
	public static final String SMS_TP_120 = "120";				
	/** SMS 유형 코드 : 휴면계정 안내 */
	public static final String SMS_TP_130 = "130";				
	/** SMS 유형 코드 : 회원탈퇴 */
	public static final String SMS_TP_140 = "140";				
	/** SMS 유형 코드 : 관리자 회원 가입 */
	public static final String SMS_TP_150 = "150";				
	/** SMS 유형 코드 : 미입금 확인 */
	public static final String SMS_TP_210 = "210";				
	/** SMS 유형 코드 : 주문 완료 */
	public static final String SMS_TP_220 = "220";				
	/** SMS 유형 코드 : 상품 발송 */
	public static final String SMS_TP_230 = "230";				
	/** SMS 유형 코드 : 배송 완료 */
	public static final String SMS_TP_240 = "240";				
	/** SMS 유형 코드 : 주문 취소 */
	public static final String SMS_TP_300 = "300";				
	/** SMS 유형 코드 : 반품 신청 */
	public static final String SMS_TP_310 = "310";				
	/** SMS 유형 코드 : 교환 신청 */
	public static final String SMS_TP_320 = "320";				
	/** SMS 유형 코드 : 환불 완료 */
	public static final String SMS_TP_330 = "330";				
	/** SMS 유형 코드 : 적립금 소멸 안내 */
	public static final String SMS_TP_500 = "500";				
	/** SMS 유형 코드 : 배치 에러 안내 */
	public static final String SMS_TP_900 = "900";				
	
		
	/** 초성 구분 */
	public static final String INIT_CHAR_GB = "INIT_CHAR_GB";
	/** 초성 구분 : 한글 */
	public static final String INIT_CHAR_GB_KO = "KO";			
	/** 초성 구분 : 영문 */
	public static final String INIT_CHAR_GB_EN = "EN";			

	
	/** 초성 */
	public static final String INIT_CHAR = "INIT_CHAR";
	/** 초성 : ㄱ */
	public static final String INIT_CHAR_K1 = "K1";				
	/** 초성 : ㄴ */
	public static final String INIT_CHAR_K2 = "K2";				
	/** 초성 : ㄷ */
	public static final String INIT_CHAR_K3 = "K3";				
	/** 초성 : ㄹ */
	public static final String INIT_CHAR_K4 = "K4";				
	/** 초성 : ㅁ */
	public static final String INIT_CHAR_K5 = "K5";				
	/** 초성 : ㅂ */
	public static final String INIT_CHAR_K6 = "K6";				
	/** 초성 : ㅅ */
	public static final String INIT_CHAR_K7 = "K7";				
	/** 초성 : ㅇ */
	public static final String INIT_CHAR_K8 = "K8";				
	/** 초성 : ㅈ */
	public static final String INIT_CHAR_K9 = "K9";				
	/** 초성 : ㅊ */
	public static final String INIT_CHAR_K10 = "K10";			
	/** 초성 : ㅋ */
	public static final String INIT_CHAR_K11 = "K11";			
	/** 초성 : ㅌ */
	public static final String INIT_CHAR_K12 = "K12";			
	/** 초성 : ㅍ */
	public static final String INIT_CHAR_K13 = "K13";			
	/** 초성 : ㅎ */
	public static final String INIT_CHAR_K14 = "K14";			
	/** 초성 : A */
	public static final String INIT_CHAR_E1 = "E1";				
	/** 초성 : B */
	public static final String INIT_CHAR_E2 = "E2";				
	/** 초성 : C */
	public static final String INIT_CHAR_E3 = "E3";				
	/** 초성 : D */
	public static final String INIT_CHAR_E4 = "E4";				
	/** 초성 : E */
	public static final String INIT_CHAR_E5 = "E5";				
	/** 초성 : F */
	public static final String INIT_CHAR_E6 = "E6";				
	/** 초성 : G */
	public static final String INIT_CHAR_E7 = "E7";				
	/** 초성 : H */
	public static final String INIT_CHAR_E8 = "E8";				
	/** 초성 : I */
	public static final String INIT_CHAR_E9 = "E9";				
	/** 초성 : J */
	public static final String INIT_CHAR_E10 = "E10";			
	/** 초성 : K */
	public static final String INIT_CHAR_E11 = "E11";			
	/** 초성 : L */
	public static final String INIT_CHAR_E12 = "E12";			
	/** 초성 : M */
	public static final String INIT_CHAR_E13 = "E13";			
	/** 초성 : N */
	public static final String INIT_CHAR_E14 = "E14";			
	/** 초성 : O */
	public static final String INIT_CHAR_E15 = "E15";			
	/** 초성 : P */
	public static final String INIT_CHAR_E16 = "E16";			
	/** 초성 : Q */
	public static final String INIT_CHAR_E17 = "E17";			
	/** 초성 : R */
	public static final String INIT_CHAR_E18 = "E18";			
	/** 초성 : S */
	public static final String INIT_CHAR_E19 = "E19";			
	/** 초성 : T */
	public static final String INIT_CHAR_E20 = "E20";			
	/** 초성 : U */
	public static final String INIT_CHAR_E21 = "E21";			
	/** 초성 : V */
	public static final String INIT_CHAR_E22 = "E22";			
	/** 초성 : W */
	public static final String INIT_CHAR_E23 = "E23";			
	/** 초성 : X */
	public static final String INIT_CHAR_E24 = "E24";			
	/** 초성 : Y */
	public static final String INIT_CHAR_E25 = "E25";			
	/** 초성 : Z */
	public static final String INIT_CHAR_E26 = "E26";			
	/** 초성 : ETC */
	public static final String INIT_CHAR_E27 = "E27";			
	
	
	/** 월 코드 */
	public static final String MM = "MM";
	
	
	/** 기간 선택 코드 */
	public static final String SELECT_PERIOD = "SELECT_PERIOD";
	/** 기간 선택 코드 : 당일 */
	public static final String SELECT_PERIOD_10 = "10";			
	/** 기간 선택 코드  : 최근일주일 */
	public static final String SELECT_PERIOD_20 = "20";			
	/** 기간 선택 코드  : 15일 */
	public static final String SELECT_PERIOD_30 = "30";			
	/** 기간 선택 코드  : 1개월 */
	public static final String SELECT_PERIOD_40 = "40";			
	/** 기간 선택 코드 : 3개월 */
	public static final String SELECT_PERIOD_50 = "50";			
	/** 기간 선택 코드 : 3일  == 추가함*/
	public static final String SELECT_PERIOD_60 = "60";			
	
	
	/****************************
	 * 회원
	 ****************************/
	
	/** SNS 구분 코드 */
	public static final String SNS_GB = "SNS_GB";
	/** SNS 구분 코드 : 페이스북 */	
	public static final String SNS_GB_10 = "10";				
	/** SNS 구분 코드 : 카카오톡 */
	public static final String SNS_GB_20 = "20";				
	/** SNS 구분 코드 : 구글 */
	public static final String SNS_GB_30 = "30";				
	/** SNS 구분 코드 : 트위터 */
	public static final String SNS_GB_40 = "40";	
	
	
	/** 가입 환경 코드*/
	public static final String JOIN_ENV = "JOIN_ENV";
	/** 가입 환경 코드 : WEB_PC */
	public static final String JOIN_ENV_WEB_PC = "10";				
	/** 가입 환경 코드 : WEB_MOBILE */
	public static final String JOIN_ENV_WEB_MOB = "20";				
	/** 가입 환경 코드 : APP_IOS */
	public static final String JOIN_ENV_APP_IOS = "30";				
	/** 가입 환경 코드 : APP_ANDROID */
	public static final String JOIN_ENV_APP_ANDROID = "40";				
	
	
	/** 가입 경로 코드 */
	public static final String JOIN_PATH = "JOIN_PATH";
	/** 가입 경로 코드 : 하루 */
	public static final String JOIN_PATH_10 = "10";				
	/** 가입 경로 코드 : 펫츠비 */
	public static final String JOIN_PATH_20 = "20";				
	/** 가입 경로 코드 : 어바웃펫 */
	public static final String JOIN_PATH_30 = "30";				
	
	/** SNS가입 경로 코드 */
	public static final String SNS_LNK_CD = "SNS_LNK";
	/** SNS가입 경로 코드 : 네이버 */
	public static final String SNS_LNK_CD_10 = "10";				
	/** SNS가입 경로 코드 : 카카오 */
	public static final String SNS_LNK_CD_20 = "20";				
	/** SNS가입 경로 코드 : 구글 */
	public static final String SNS_LNK_CD_30 = "30";				
	/** SNS가입 경로 코드 : 애플 */
	public static final String SNS_LNK_CD_40 = "40";
	/** SNS가입 경로 코드 : BO 회원 목록 검색 위해 */
	public static final String SNS_LNK_CD_ALL = "A";
	
	/*
	public static final String JOIN_PATH = "JOIN_PATH";
	*//** 가입 경로 코드 : 인터넷 검색 *//*
	public static final String JOIN_PATH_10 = "10";				
	*//** 가입 경로 코드 : 블로그/카페 등을 통해 *//*
	public static final String JOIN_PATH_20 = "20";				
	*//** 가입 경로 코드 : SNS(소셜네트워크서비스)를 통해 *//*
	public static final String JOIN_PATH_30 = "30";				
	*//** 가입 경로 코드 : 드라마/영화 등 협찬을 통해 *//*
	public static final String JOIN_PATH_40 = "40";				
	*//** 가입 경로 코드 : 잡지 등 지면광고를 통해 *//*
	public static final String JOIN_PATH_50 = "50";				
	*//** 가입 경로 코드 : 친구나 지인 등의 소개 *//*
	public static final String JOIN_PATH_60 = "60";				
	*//** 가입 경로 코드 : 옥외 광고 및 전시를 통해 *//*
	public static final String JOIN_PATH_70 = "70";				
	*//** 가입 경로 코드 : 기타 *//*
	public static final String JOIN_PATH_90 = "90";				
*/	
	
	/** 인증 방법 코드 */
	public static final String CTF_MTD = "CTF_MTD";
	/** 인증 방법 코드 : I-PIN 인증 */
	public static final String CTF_MTD_10 = "10";				
	/** 인증 방법 코드 : 휴대폰 인증 */
	public static final String CTF_MTD_20 = "20";	

	/** 회원 수신 정보 코드*/
	public static final String RCV_INFO_CD = "RCV_INFO_CD";
	/** 이메일*/
	public static final String RCV_INFO_EMAIL = "10";
	/** SMS*/
	public static final String RCV_INFO_SMS = "20";

	/** 성별 */
	public static final String GD_GB = "GD_GB";
	/** 성별 : 남성 */
	public static final String GD_GB_1 = "10";					
	/** 성별 : 여성 */
	public static final String GD_GB_0 = "20";					

	
	/** 국적 구분 코드 */
	public static final String NTN_GB = "NTN_GB";
	/** 국적 구분 코드 : 내국인 */
	public static final String NTN_GB_10 = "10";					
	/** 국적 구분 코드 : 외국인 */
	public static final String NTN_GB_20 = "20";					
	
	
	/** 기본 배송지 여부 */
	public static final String DFT_YN = "DFT_YN";
	/** 기본 배송지 여부 : 기본 배송지 */
	public static final String DFT_YN_Y = "Y";					
	/** 기본 배송지 여부 : 일반 배송지 */
	public static final String DFT_YN_N = "N";					
	
	
	/** 우편번호구분 */
	public static final String MAPPING = "MAPPING";
	/** 우편번호구분 : 구우편번호 */
	public static final String MAPPING_10 = "10";				
	/** 우편번호구분 : 새우편번호 */
	public static final String MAPPING_20 = "20";				
	
	
	/** 수신 여부 코드 */
	public static final String RCV_YN = "RCV_YN";
	/** 수신 여부 코드 : 수신함 */
	public static final String RCV_YN_Y = "RCV_YN_Y";			
	/** 수신 여부 코드 : 수신안함 */
	public static final String RCV_YN_N = "RCV_YN_N";			
	
	
	/** 이메일 수신 여부 */
	public static final String EMAIL_RCV_YN = "EMAIL_RCV_YN";
	/** 이메일 수신 여부 : 예 */
	public static final String EMAIL_RCV_YN_Y = "Y";			
	/** 이메일 수신 여부 : 아니오 */
	public static final String EMAIL_RCV_YN_N = "N";			
	
	
	/** SMS 수신 여부 */
	public static final String SMS_RCV_YN = "SMS_RCV_YN";
	/** SMS 수신 여부 : 예 */
	public static final String SMS_RCV_YN_Y = "Y";				
	/** SMS 수신 여부 : 아니오 */
	public static final String SMS_RCV_YN_N = "N";					

	
	/** GS포인트 연계 상태 코드 */
	public static final String GSPT_STATE = "GSPT_STATE";
	/** GS포인트 연계 상태 코드 : 연계*/
	public static final String GSPT_STATE_10 = "10";				
	/** GS포인트 연계 상태 코드 : 해지*/
	public static final String GSPT_STATE_20 = "20";					
	/** GS포인트 연계 상태 코드 : 미연계*/
	public static final String GSPT_STATE_30 = "30";					
	
	
	/** 회원 상태 코드 */
	public static final String MBR_STAT_CD = "MBR_STAT";
	/** 회원 상태 코드 : 정상 */
	public static final String MBR_STAT_10 = "10";				
	/** 회원 상태 코드 : 미사용 */
	public static final String MBR_STAT_20 = "20";				
	/** 회원 상태 코드 : 휴면 */
	public static final String MBR_STAT_30 = "30";				
	/** 회원 상태 코드 : 중복 */
	public static final String MBR_STAT_40 = "40";				
	/** 회원 상태 코드 : 탈퇴 */
	public static final String MBR_STAT_50 = "50";				
	/** 회원 상태 코드 : 블랙 */
	public static final String MBR_STAT_60 = "60";				
	/** 회원 상태 코드 : 정지 */
	public static final String MBR_STAT_70 = "70";				
	/** 회원 상태 코드 : 부당거래정지 */
	public static final String MBR_STAT_80 = "80";				
	
	
	/** 회원 등급 혜택 코드 */
	public static final String GRD_BNFT_TP = "DFT_YN";
	/** 회원 등급 혜택 코드 : 할인 쿠폰 */
	public static final String GRD_BNFT_TP_10 = "10";			
	/** 회원 등급 혜택 코드 : 무료배송 쿠폰 */
	public static final String GRD_BNFT_TP_20 = "20";			
	/** 회원 등급 혜택 코드 : 생일 축하 쿠폰 */
	public static final String GRD_BNFT_TP_30 = "30";			
	/** 회원 등급 혜택 코드 : 구매 적립율(바로방문) */
	public static final String GRD_BNFT_TP_40 = "40";			
		
	
	/** 회원 등급 코드 */
	public static final String MBR_GRD_CD = "MBR_GRD";
	/** 회원 등급 코드 : VVIP */
	public static final String MBR_GRD_10 = "10";				
	/** 회원 등급 코드 : VIP */
	public static final String MBR_GRD_20 = "20";				
	/** 회원 등급 코드 : 패밀리 */
	public static final String MBR_GRD_30 = "30";				
	/** 회원 등급 코드 : 웰컴 */
	public static final String MBR_GRD_40 = "40";				

	/** 회원 검색어*/
	public static final String SRCH_GB = "SRCH_GB";
	/** 회원 검색어 : 검색어 */
	public static final String SRCH_GB_10 = "10";				
	
	/** 포인트 구분 코드 */
	public static final String PNT_GB = "PNT_GB";
	/** 포인트 구분 코드 : 주문 */
	public static final String PNT_GB_10 = "PNT_GB_10";			
	
	
	/** 적립금 처리 코드 */
	public static final String SVMN_PRCS = "SVMN_PRCS";
	/** 적립금 처리 코드 : 적립 */
	public static final String SVMN_PRCS_10 = "10";				
	/** 적립금 처리 코드 : 차감 */
	public static final String SVMN_PRCS_20 = "20";				

	
	/** 적립금 처리 사유 코드 */
	public static final String SVMN_PRCS_RSN = "SVMN_PRCS_RSN";
	/** 적립금 처리 사유 코드 : 결제 취소 */
	public static final String SVMN_PRCS_RSN_110 = "110";		
	/** 적립금 처리 사유 코드 : 결제 사용 */
	public static final String SVMN_PRCS_RSN_210 = "210";		
	/** 적립금 처리 사유 코드 : 관리자 차감 */
	public static final String SVMN_PRCS_RSN_220 = "220";		
	/** 적립금 처리 사유 코드 : 적립 취소 */
	public static final String SVMN_PRCS_RSN_230 = "230";		
	/** 적립금 처리 사유 코드 : 적립금소멸 */
	public static final String SVMN_PRCS_RSN_290 = "290";		

	
	/** 적립금 사유 코드 */
	public static final String SVMN_RSN = "SVMN_RSN";
	/** 적립금 사유 코드 : 회원 가입 */
	public static final String SVMN_RSN_110 = "110";
	/** 적립금 사유 코드 : 회원 보상 */
	public static final String SVMN_RSN_120 = "120";			
	
	public static final String SVMN_RSN_210 = "210";			
	/** 적립금 사유 코드 : 상품평 */
	public static final String SVMN_RSN_220 = "220";			
	/** 적립금 사유 코드 : 프로모션 */
	public static final String SVMN_RSN_310 = "310";			
	/** 적립금 사유 코드 : 이벤트참여 */
	public static final String SVMN_RSN_320 = "320";			
	/** 적립금 사유 코드 : 이벤트당첨 */
	public static final String SVMN_RSN_330 = "330";			
	/** 적립금 사유 코드 : 기타 */
	public static final String SVMN_RSN_900 = "900";			

	
	/** 적립금 유효 기간 코드 */
	public static final String SVMN_VLD_PRD = "SVMN_VLD_PRD";
	/** 적립금 유효 기간 코드 : 년 */
	public static final String SVMN_VLD_PRD_10 = "10";			
	/** 적립금 유효 기간 코드 : 월 */
	public static final String SVMN_VLD_PRD_20 = "20";			
	/** 적립금 유효 기간 코드 : 일 */
	public static final String SVMN_VLD_PRD_30 = "30";			
	
	
	/** 회원 탈퇴 사유 코드 */
	public static final String MBR_LEV_RSN = "MBR_LEV_RSN";
	/** 회원 탈퇴 사유 코드 :할인혜택 부족 */
	public static final String MBR_LEV_RSN_10 = "10";			
	/** 회원 탈퇴 사유 코드 : 상품가격과 품질 불만 */
	public static final String MBR_LEV_RSN_20 = "20";			
	/** 회원 탈퇴 사유 코드 : 교환/환불 불만 */
	public static final String MBR_LEV_RSN_30 = "30";			
	/** 회원 탈퇴 사유 코드 : A/S불만 */
	public static final String MBR_LEV_RSN_40 = "40";			
	/** 회원 탈퇴 사유 코드 : 개인정보의 노출 우려 */
	public static final String MBR_LEV_RSN_50 = "50";			
	/** 회원 탈퇴 사유 코드 : 서비스이용안함 */
	public static final String MBR_LEV_RSN_60 = "60";
	/** 회원 탈퇴 사유 코드 : 기타 */
	public static final String MBR_LEV_RSN_80 = "90";			
	
	
	/** sns 회원 상태 코드 */
	public static final String SNS_STAT = "SNS_STAT";
	/** sns 회원 상태 코드 : 계정연결 */
	public static final String SNS_STAT_10 = "10";			
	/** sns 회원 상태 코드 : 계정해지 */
	public static final String SNS_STAT_20 = "20";			
	/** sns 회원 상태 코드 : 계정휴면 */
	public static final String SNS_STAT_30 = "30";			
	/** sns 회원 상태 코드 : 계정탈퇴 */
	public static final String SNS_STAT_40 = "40";			
	
	/** 로그인 경로 코드 */
	public static final String LOGIN_PATH_CD = "LOGIN_PATH";
	/** 로그인 경로 코드 :네이버*/
	public static final String LOGIN_PATH_NAVER = "10";
	/** 로그인 경로 코드 :카카오*/
	public static final String LOGIN_PATH_KAKAO = "20";
	/** 로그인 경로 코드 :구글*/
	public static final String LOGIN_PATH_GOOGLE = "30";
	/** 로그인 경로 코드 : 애플*/
	public static final String LOGIN_PATH_APPLE = "40";
	/** 로그인 경로 코드 :어바웃펫*/
	public static final String LOGIN_PATH_ABOUTPET = "50";
	/** 로그인 경로 코드 : 하루 */
	public static final String LOGIN_PATH_HR = "60";
	/** 로그인 경로 코드 :펫츠비*/
	public static final String LOGIN_PATH_PB = "70";
	
	/****************************
	 * 업체
	 ****************************/
	
	/** 업태 */
	public static final String BIZ = "BIZ";
	
	
	/** 업체 구분 코드 */
	public static final String COMP_GB = "COMP_GB";
	/** 업체 구분 코드 : 자사 */
	public static final String COMP_GB_10 = "10";				
	/** 업체 구분 코드 : 외부업체 */
	public static final String COMP_GB_20 = "20";				

	
	/** 업체 상태 코드 */
	public static final String COMP_STAT = "COMP_STAT";
	/** 업체 상태 코드 : 등록 */
	public static final String COMP_STAT_10 = "10";				
	/** 업체 상태 코드 : 정상 */
	public static final String COMP_STAT_20 = "20";				
	/** 업체 상태 코드 : 중지 */
	public static final String COMP_STAT_30 = "30";				
	/** 업체 상태 코드 : 종료 */
	public static final String COMP_STAT_40 = "40";				

	
	/** 업체 유형 코드 */
	public static final String COMP_TP = "COMP_TP";
	/** 업체 유형 코드 : 자사 */
	public static final String COMP_TP_10 = "10";				
	/** 업체 유형 코드 : 위탁 */
	public static final String COMP_TP_20 = "20";				
	/** 업체 유형 코드 : 매입 */
	public static final String COMP_TP_30 = "30";				
	
	/** 업체 정책 구분 코드 */
	public static final String COMP_PLC_GB = "COMP_PLC_GB";
	/** 업체 정책 구분 코드 : 교환/환불정보 */
	public static final String COMP_PLC_GB_10 = "10";			

	
	/** 업체 부가 비용 코드 */
	public static final String COMP_ADT_COST = "COMP_ADT_COST";
	/** 업체 부가 비용 코드 : 수수료 */
	public static final String COMP_ADT_COST_10 = "10";			
	/** 업체 부가 비용 코드 : 패널티 */
	public static final String COMP_ADT_COST_20 = "20";			
	/** 업체 부가 비용 코드 : 샘플비 */
	public static final String COMP_ADT_COST_30 = "30";			
	/** 업체 부가 비용 코드 : 별도배송비 */
	public static final String COMP_ADT_COST_40 = "40";			

	
	/** 업체 정산 코드 */
	public static final String COMP_CCL = "COMP_CCL";
	/** 업체 정산 코드 : 수수료 */
	public static final String COMP_CCL_10 = "10";				
	/** 업체 정산 코드 : 매입가 */
	public static final String COMP_CCL_20 = "20";				

	
	/** 배송방법 코드 */
	public static final String COMP_DLVR_MTD = "COMP_DLVR_MTD";
	/** 배송방법 코드 : 택배 */
	@Deprecated
	public static final String COMP_DLVR_MTD_10 = "10";			
	
	
	/** 배송가능 지역 코드 */
	public static final String COMP_DLVR_PSB_AREA = "COMP_DLVR_PSB_AREA";
	/** 배송가능 지역 코드 : 전국 */
	public static final String COMP_DLVR_PSB_AREA_10 = "10";
	/** 배송가능 지역 코드 : 전국(도서산간추가금액) */
	public static final String COMP_DLVR_PSB_AREA_30 = "30";

	
	/** 배송비 조건 코드 */
	public static final String DLVRC_CDT = "DLVRC_CDT";
	/** 배송비 조건 코드 : 개당 부여 */
	public static final String DLVRC_CDT_10 = "10";				
	/** 배송비 조건 코드 : 주문당 부여 */
	public static final String DLVRC_CDT_20 = "20";				

	/** 배송비 비용 구분 코드 */
	public static final String DLVRC_COST_GB = "COST_GB";
	/** 배송비 비용 구분  코드 : 배송비 */
	public static final String DLVRC_COST_GB_SEND = "10";				
	/** 배송비 비용 구분  코드 : 회수비 */
	public static final String DLVRC_COST_GB_RETURN = "20";		
	
	/** 배송비 조건 기준 코드 */
	public static final String DLVRC_CDT_STD = "DLVRC_CDT_STD";
	/** 배송비 조건 기준 코드 : 유료배송 */
	public static final String DLVRC_CDT_STD_10 = "10";			
	/** 배송비 조건 기준 코드 : 조건부 무료배송(구매가격) */
	public static final String DLVRC_CDT_STD_20 = "20";			
	/** 배송비 조건 기준 코드 : 조건부 무료배송(구매수량) */
	public static final String DLVRC_CDT_STD_30 = "30";			


	/** 배송비 결제 방법 코드 */
	public static final String DLVRC_PAY_MTD = "DLVRC_PAY_MTD";
	/** 배송비 결제 방법 코드 : 선불 */
	public static final String DLVRC_PAY_MTD_10 = "10";			

	
	/** 배송비 기준 코드 */
	public static final String DLVRC_STD = "DLVRC_STD";
	/** 배송비 기준 코드 : 무료배송 */
	public static final String DLVRC_STD_10 = "10";				
	/** 배송비 기준 코드 : 배송비 추가 */
	public static final String DLVRC_STD_20 = "20";				
	
	
	/** 배송 방법 코드 */
	public static final String DLVR_MTD = "DLVR_MTD";
	/** 배송 방법 코드 : 택배 */
	public static final String DLVR_MTD_10 = "10";				
	
	
	/** 택배사 코드 */
	public static final String HDC = "HDC";
	/** 택배사 코드 : CJ대한통운 */
	public static final String HDC_01 = "01";					
	/** 택배사 코드 : 로젠택배 */
	public static final String HDC_02 = "02";					
	/** 택배사 코드 : KG로지스 */
	public static final String HDC_03 = "03";					
	/** 택배사 코드 : 우체국택배 */
	public static final String HDC_04 = "04";					
	/** 택배사 코드 : 한진택배 */
	public static final String HDC_05 = "05";					
	/** 택배사 코드 : 현대택배 */
	public static final String HDC_06 = "06";					
	/** 택배사 코드 : KGB택배 */
	public static final String HDC_07 = "07";					
	/** 택배사 코드 : GTX로지스 */
	public static final String HDC_08 = "08";					
	/** 택배사 코드 : 대신택배 */
	public static final String HDC_09 = "09";					
	/** 택배사 코드 : 일양로지스 */
	public static final String HDC_10 = "10";					
	/** 택배사 코드 : 경동택배 */
	public static final String HDC_11 = "11";					
	/** 택배사 코드 : 합동택배 */
	public static final String HDC_12 = "12";					
	/** 택배사 코드 : 천일택배 */
	public static final String HDC_13 = "13";					
	/** 택배사 코드 : 편의점택배 */
	public static final String HDC_14 = "14";					
	/** 택배사 코드 : FEDEX */
	public static final String HDC_15 = "15";					
	/** 택배사 코드 : UPS */
	public static final String HDC_16 = "16";					
	/** 택배사 코드 : TNT */
	public static final String HDC_17 = "17";					
	/** 택배사 코드 : GSM NtoN */
	public static final String HDC_18 = "18";					
	/** 택배사 코드 : 성원글로벌 */
	public static final String HDC_19 = "19";					
	/** 택배사 코드 : 범한판토스 */
	public static final String HDC_20 = "20";					
	/** 택배사 코드 : ACI Express */
	public static final String HDC_21 = "21";					
	/** 택배사 코드 : 대운글로벌 */
	public static final String HDC_22 = "22";					
	/** 택배사 코드 : CJ대한통운 국제특송 */
	public static final String HDC_23 = "23";					
	/** 택배사 코드 : USPS */
	public static final String HDC_24 = "24";					
	/** 택배사 코드 : i-parcel */
	public static final String HDC_25 = "25";					
	/** 택배사 코드 : AIR BOY Express */
	public static final String HDC_26 = "26";					
	/** 택배사 코드 : EMS */
	public static final String HDC_27 = "27";					
	/** 택배사 코드 : 한덱스 */
	public static final String HDC_28 = "28";					
	/** 택배사 코드 : DHL */
	public static final String HDC_29 = "29";					
	/** 택배사 코드 : KGL 네트웍스 */
	public static final String HDC_30 = "30";					
	/** 택배사 코드 : 굿투럭 */
	public static final String HDC_31 = "31";					
	/** 택배사 코드 : 건영택배 */
	public static final String HDC_32 = "32";					
	/** 택배사 코드 : SLX택배 */
	public static final String HDC_33 = "33";					
	/** 택배사 코드 : SF-Express */
	public static final String HDC_34 = "34";					
	/** 택배사 코드 : 한서호남택배 */
	public static final String HDC_35 = "35";					
	/** 택배사 코드 : GS */
	public static final String HDC_36 = "36";

	
	/** 입점 물류 유형 코드 */
	public static final String SE_DSTB_TP = "SE_DSTB_TP";
	/** 입점 물류 유형 코드 : 물류시설 자체보유 */
	public static final String SE_DSTB_TP_10 = "10";			
	/** 입점 물류 유형 코드 : 물류전문업체 위탁 */
	public static final String SE_DSTB_TP_20 = "20";			
	
	
	/** 입점 상품 유형 코드 */
	public static final String SE_GOODS_TP = "SE_GOODS_TP";
	/** 입점 상품 유형 코드 : 자제생산/제조 */
	public static final String SE_GOODS_TP_10 = "10";			
	/** 입점 상품 유형 코드 : 국내유통 */
	public static final String SE_GOODS_TP_20 = "20";			
	/** 입점 상품 유형 코드 : 수입 */
	public static final String SE_GOODS_TP_30 = "30";			

	/** 이미지 유형 코드 */
	public static final String IMG_TP = "IMG_TP";
	/** 이미지 유형 코드 : Square */
	public static final String IMG_TP_10 = "10";
	@Deprecated
	public static final String IMG_TP_11 = "11";				
	/** 이미지 유형 코드 : Rectangle */
	public static final String IMG_TP_20 = "20";				 
	/** 이미지 유형 코드 : banner */
	public static final String IMG_TP_30 = "30";				 
	
	/** 입점 판매 유형 코드 */
	public static final String SE_SALE_TP = "SE_SALE_TP";
	/** 입점 판매 유형 코드 : 온라인 */
	public static final String SE_SALE_TP_10 = "10";			
	/** 입점 판매 유형 코드 : 오프라인 */
	public static final String SE_SALE_TP_20 = "20";			
	/** 입점 판매 유형 코드 : 온오프라인 */
	public static final String SE_SALE_TP_30 = "30";			

	
	/** 입점 상태 코드 */
	public static final String SE_STAT = "SE_STAT";
	/** 입점 상태 코드 : 요청 */
	public static final String SE_STAT_10 = "10";				
	/** 입점 상태 코드 : 검토중 */
	public static final String SE_STAT_20 = "20";				
	/** 입점 상태 코드 : 승인 */
	public static final String SE_STAT_30 = "30";				
	/** 입점 상태 코드 : 거절 */
	public static final String SE_STAT_40 = "40";				

	
	/****************************
	 * 전시
	 ****************************/
	
	/** 전시 분류 코드 */
	public static final String DISP_CLSF = "DISP_CLSF";
	/** 펫샵*/
	public static final String DISP_CLSF_10 = "10";				
	/** 펫TV*/
	public static final String DISP_CLSF_11 = "11";				
	/** 펫로그*/
	public static final String DISP_CLSF_12 = "12";				
	/** 기획전*/
	public static final String DISP_CLSF_20 = "20";				
	/** 비정형 페이지*/
	public static final String DISP_CLSF_30 = "30";				
	/** 브랜드 카테고리*/
	public static final String DISP_CLSF_40 = "40";				
	/** 업체 카테고리*/
	public static final String DISP_CLSF_60 = "60";				
	
	/** 비정형 전시 분류 번호 - 펫로그*/
	public static final Long PETLOG_MAIN_DISP_CLSF_NO = 300000163L;
	
	/** 펫샵 전시 분류 번호 */
	/** 전시 분류 번호_강아지 */
	public static final Long PETSHOP_DOG_DISP_CLSF_NO = 12564L;
	/** 전시 분류 번호_고양이 */
	public static final Long PETSHOP_CAT_DISP_CLSF_NO = 12565L;
	/** 전시 분류 번호_관상어 */
	public static final Long PETSHOP_FISH_DISP_CLSF_NO = 14111L;
	/** 전시 분류 번호_소동물 */
	public static final Long PETSHOP_ANIMAL_DISP_CLSF_NO = 14196L;
	
	/** 비정형 전시 분류 번호 - 펫샵*/
	public static final Long PETSHOP_MAIN_DISP_CLSF_NO = 300000164L;
	/** 비정형 전시 분류 번호_강아지 */
	public static final Long PETSHOP_MAIN_DOG_DISP_CLSF_NO = 300000173L;
	/** 비정형 전시 분류 번호_고양이 */
	public static final Long PETSHOP_MAIN_CAT_DISP_CLSF_NO = 300000174L;
	/** 비정형 전시 분류 번호_관상어 */
	public static final Long PETSHOP_MAIN_FISH_DISP_CLSF_NO = 300000175L;
	/** 비정형 전시 분류 번호_소동물 */
	public static final Long PETSHOP_MAIN_ANIMAL_DISP_CLSF_NO = 300000176L;

	/** 비정형 전시 상품 상세 배너  */
	public static final Long PETSHOP_GOODS_BANNER_DISP_CLSF_NO = 504L;

	/** 펫샵 비정형매장 코너 번호 */
	/** 비정형 전시 코너 분류 번호_강아지 */
	public static final Long DISP_CORN_NO_DOG_TOP_BANNER = 505L;				/** 상단 배너 */
	public static final Long DISP_CORN_NO_DOG_SHORTCUT = 506L;					/** 바로가기 영역 */
	public static final Long DISP_CORN_NO_DOG_RECOMMEND_GOODS = 507L;			/** 사용자 맞춤 추천상품 */
	public static final Long DISP_CORN_NO_DOG_PET_REG_BANNER = 508L;			/** 반려동물 등록 배너 */
	public static final Long DISP_CORN_NO_DOG_OFFEN_GOODS = 509L;				/** 자주 구매한 상품 */
	public static final Long DISP_CORN_NO_DOG_TIME_DEAL = 510L;					/** 타임딜 */	
	public static final Long DISP_CORN_NO_DOG_AD_BANNER = 511L;					/** 광고배너 */
	public static final Long DISP_CORN_NO_DOG_STOCK_IMMINENT = 512L;			/** 재고 임박 : 폭풍할인 */
	public static final Long DISP_CORN_NO_DOG_EXPIRATION_DATE = 584L;			/** 유통기한 임박 : 폭풍할인 */
	public static final Long DISP_CORN_NO_DOG_MD_GOODS = 513L;					/** MD 추천상품*/
	public static final Long DISP_CORN_NO_DOG_BEST = 514L;						/** 베스트20*/
	public static final Long DISP_CORN_NO_DOG_ONLY_GOODS = 515L;				/** 펫샵 단독 상품*/	
	public static final Long DISP_CORN_NO_DOG_PACKAGE_GOODS = 516L;				/** 패키지 상품*/
	public static final Long DISP_CORN_NO_DOG_POPPETLOG = 517L;					/** 인기있는 펫로그 후기*/
	public static final Long DISP_CORN_NO_DOG_BATTOM_AD_BANNER = 518L;			/** 광고배너*/
	/** 비정형 전시 코너 분류 번호_고양이 */
	public static final Long DISP_CORN_NO_CAT_TOP_BANNER = 519L;				/** 상단 배너 */
	public static final Long DISP_CORN_NO_CAT_SHORTCUT = 520L;					/** 바로가기 영역 */
	public static final Long DISP_CORN_NO_CAT_RECOMMEND_GOODS = 521L;			/** 사용자 맞춤 추천상품 */
	public static final Long DISP_CORN_NO_CAT_PET_REG_BANNER = 535L;			/** 반려동물 등록 배너 */
	public static final Long DISP_CORN_NO_CAT_OFFEN_GOODS = 536L;				/** 자주 구매한 상품 */
	public static final Long DISP_CORN_NO_CAT_TIME_DEAL = 537L;					/** 타임딜 */	
	public static final Long DISP_CORN_NO_CAT_AD_BANNER = 538L;					/** 광고배너 */
	public static final Long DISP_CORN_NO_CAT_STOCK_IMMINENT = 539L;			/** 재고 임박 : 폭풍할인 */
	public static final Long DISP_CORN_NO_CAT_EXPIRATION_DATE = 585L;			/** 유통기한 임박 : 폭풍할인 */
	public static final Long DISP_CORN_NO_CAT_MD_GOODS = 540L;					/** MD 추천상품*/
	public static final Long DISP_CORN_NO_CAT_BEST = 541L;						/** 베스트20*/
	public static final Long DISP_CORN_NO_CAT_ONLY_GOODS = 542L;				/** 펫샵 단독 상품*/	
	public static final Long DISP_CORN_NO_CAT_PACKAGE_GOODS = 543L;				/** 패키지 상품*/
	public static final Long DISP_CORN_NO_CAT_POPPETLOG = 544L;					/** 인기있는 펫로그 후기*/
	public static final Long DISP_CORN_NO_CAT_BATTOM_AD_BANNER = 545L;			/** 광고배너*/
	/** 비정형 전시 코너 분류 번호_관상어 */
	public static final Long DISP_CORN_NO_FISH_TOP_BANNER = 546L;				/** 상단 배너 */
	public static final Long DISP_CORN_NO_FISH_SHORTCUT = 547L;					/** 바로가기 영역 */
	public static final Long DISP_CORN_NO_FISH_RECOMMEND_GOODS = 548L;			/** 사용자 맞춤 추천상품 */
	public static final Long DISP_CORN_NO_FISH_PET_REG_BANNER = 549L;			/** 반려동물 등록 배너 */
	public static final Long DISP_CORN_NO_FISH_OFFEN_GOODS = 550L;				/** 자주 구매한 상품 */
	public static final Long DISP_CORN_NO_FISH_TIME_DEAL = 551L;				/** 타임딜 */	
	public static final Long DISP_CORN_NO_FISH_AD_BANNER = 552L;				/** 광고배너 */
	public static final Long DISP_CORN_NO_FISH_STOCK_IMMINENT = 553L;			/** 재고 임박 : 폭풍할인 */
	public static final Long DISP_CORN_NO_FISH_EXPIRATION_DATE = 586L;			/** 유통기한 임박 : 폭풍할인 */
	public static final Long DISP_CORN_NO_FISH_MD_GOODS = 554L;					/** MD 추천상품*/
	public static final Long DISP_CORN_NO_FISH_BEST = 555L;						/** 베스트20*/
	public static final Long DISP_CORN_NO_FISH_ONLY_GOODS = 556L;				/** 펫샵 단독 상품*/	
	public static final Long DISP_CORN_NO_FISH_PACKAGE_GOODS = 557L;			/** 패키지 상품*/
	public static final Long DISP_CORN_NO_FISH_POPPETLOG = 558L;				/** 인기있는 펫로그 후기*/
	public static final Long DISP_CORN_NO_FISH_BATTOM_AD_BANNER = 559L;			/** 광고배너*/
	/** 비정형 전시 코너 분류 번호_소동물 */
	public static final Long DISP_CORN_NO_ANIMAL_TOP_BANNER = 522L;				/** 상단 배너 */
	public static final Long DISP_CORN_NO_ANIMAL_SHORTCUT = 523L;				/** 바로가기 영역 */
	public static final Long DISP_CORN_NO_ANIMAL_RECOMMEND_GOODS = 524L;		/** 사용자 맞춤 추천상품 */
	public static final Long DISP_CORN_NO_ANIMAL_PET_REG_BANNER = 525L;			/** 반려동물 등록 배너 */
	public static final Long DISP_CORN_NO_ANIMAL_OFFEN_GOODS = 526L;			/** 자주 구매한 상품 */
	public static final Long DISP_CORN_NO_ANIMAL_TIME_DEAL = 527L;				/** 타임딜 */	
	public static final Long DISP_CORN_NO_ANIMAL_AD_BANNER = 528L;				/** 광고배너 */
	public static final Long DISP_CORN_NO_ANIMAL_STOCK_IMMINENT = 529L;			/** 재고 임박 : 폭풍할인 */
	public static final Long DISP_CORN_NO_ANIMAL_EXPIRATION_DATE = 587L;		/** 유통기한 임박 : 폭풍할인 */
	public static final Long DISP_CORN_NO_ANIMAL_MD_GOODS = 530L;				/** MD 추천상품*/
	public static final Long DISP_CORN_NO_ANIMAL_BEST = 560L;					/** 베스트20*/
	public static final Long DISP_CORN_NO_ANIMAL_ONLY_GOODS = 531L;				/** 펫샵 단독 상품*/	
	public static final Long DISP_CORN_NO_ANIMAL_PACKAGE_GOODS = 532L;			/** 패키지 상품*/
	public static final Long DISP_CORN_NO_ANIMAL_POPPETLOG = 533L;				/** 인기있는 펫로그 후기*/
	public static final Long DISP_CORN_NO_ANIMAL_BATTOM_AD_BANNER = 534L;		/** 광고배너*/
	
	/** 전시 코너 타입 코드 */
	public static final String DISP_CORN_TP = "DISP_CORN_TP";

	/** 전시 코너 타입 코드 : 배너 HTMl */
	public static final String DISP_CORN_TP_10 = "10";			
	/** 전시 코너 타입 코드 : 배너 TEXT */
	public static final String DISP_CORN_TP_20 = "20";			
	/** 전시 코너 타입 코드 : 이미지+TEXT*/ 
	public static final String DISP_CORN_TP_30 = "30";						
	/** 전시 코너 타입 코드 : 상품 */
	public static final String DISP_CORN_TP_60 = "60";
	/** 전시 코너 타입 코드 : 영상 */
	public static final String DISP_CORN_TP_71 = "71";
	/** 전시 코너 타입 코드 : 배너 이미지+동영상+태그 */
	public static final String DISP_CORN_TP_72 = "72";
	/** 전시 코너 타입 코드 : 배너 이미지+동영상 */
	public static final String DISP_CORN_TP_73 = "73";			
	/** 전시 코너 타입 코드 : 시리즈 목록 */
	public static final String DISP_CORN_TP_74 = "74";
	/** 전시 코너 타입 코드 : 배너 */
	public static final String DISP_CORN_TP_75 = "75";
	/** 전시 코너 타입 코드 : 태그 리스트 */
	public static final String DISP_CORN_TP_80 = "80";
	/** 전시 코너 타입 코드 : 펫로그 회원 */
	public static final String DISP_CORN_TP_90 = "90";
	/** 전시 코너 타입 코드 : 펫로그 리스트 */
	public static final String DISP_CORN_TP_100 = "100";	
	/** 전시 코너 타입 코드 : 자동노출  */
	public static final String DISP_CORN_TP_110 = "110";
	/** 전시 코너 타입 코드 : 시리즈 Tag  */
	public static final String DISP_CORN_TP_130 = "130";
	/** 전시 코너 타입 코드 : 동영상 Tag  */
	public static final String DISP_CORN_TP_131 = "131";
	/** 전시 코너 타입 코드 : 시리즈 미고정  */
	public static final String DISP_CORN_TP_132 = "132";
	/** 전시 코너 타입 코드 : 동영상 미고정  */
	public static final String DISP_CORN_TP_133 = "133";
	
	/** 전시 노출 타입 코드 */
	public static final String DISP_SHOW_TP = "DISP_SHOW_TP";
	/** 전시 노출 타입 코드 : A type */
	public static final String DISP_SHOW_TP_10 = "10";			
	/** 전시 노출 타입 코드 : B type */
	public static final String DISP_SHOW_TP_20 = "20";			

	/** 전시 최하위 여부 */
	public static final String LEAF_YN = "LEAF_YN";
	/** 전시 최하위 여부 : 예 */
	public static final String LEAF_YN_Y = "Y";					
	/** 전시 최하위 여부 : 아니오 */
	public static final String LEAF_YN_N = "N";
	
	/** 전시 기간 설정 여부*/
	public static final String DISP_PRD_SET_YN = "DISP_PRD_SET_YN";
	
	/** 무제한*/
	public static final String DISP_PRD_SET_YN_Y = "Y";
	/** 기간 설정*/
	public static final String DISP_PRD_SET_YN_N = "N";
	
	/** 브랜드 콘텐츠 유형  */
	public static final String BND_CNTS_TP = "BND_CNTS_TP";
	/** 브랜드 콘텐츠 유형  : 기본형1 */
	public static final String BND_CNTS_TP_10 = "10";			
	/** 브랜드 콘텐츠 유형  : 기본형2 */
	public static final String BND_CNTS_TP_11 = "11";			
	/** 브랜드 콘텐츠 유형  : 콘텐츠형 */
	public static final String BND_CNTS_TP_20 = "20";			
	
	
	/** 브랜드 상품전시구분  */
	public static final String BND_GOODS_DISP_GB = "BND_GOODS_DISP_GB";
	/** 브랜드 상품전시구분 : NEW */
	public static final String BND_GOODS_DISP_GB_10 = "10";		
	/** 브랜드 상품전시구분 : BEST */
	public static final String BND_GOODS_DISP_GB_20 = "20";		

	
	/** 브랜드 유형 코드 */
	public static final String BND_TP = "BND_TP";
	/** 브랜드 유형 코드 : 일반 브랜드 */
	public static final String BND_TP_10 = "10";				
	/** 브랜드 유형 코드 : 특별 브랜드 */
	public static final String BND_TP_20 = "20";				


	/** 배너 구분 코드 */
	public static final String BNR_GB = "BNR_GB";
	/** 배너 구분 코드 : 이미지 */
	public static final String BNR_GB_10 = "10";				
	/** 배너 구분 코드 : 동영상 */
	public static final String BNR_GB_20 = "20";				
	/** 배너 구분 코드 : 텍스트 */
	public static final String BNR_GB_30 = "30";				
	/** 배너 구분 코드 : HTML */
	public static final String BNR_GB_40 = "40";				

	
	/** 콘텐츠 구분 코드 */
	public static final String CNTS_GB = "CNTS_GB";
	/** 콘텐츠 구분 코드 : 컨텐츠구분1 */
	public static final String CNTS_GB_10 = "10";				
	/** 콘텐츠 구분 코드 : 컨텐츠구분2 */
	public static final String CNTS_GB_20 = "20";				
	/** 콘텐츠 구분 코드 : 컨텐츠구분3 */
	public static final String CNTS_GB_30 = "30";				
	/** 콘텐츠 구분 코드 : 컨텐츠구분4 */
	public static final String CNTS_GB_40 = "40";				
	
	
	/** 상품전시구분  */
	public static final String GOODS_DISP_GB = "GOODS_DISP_GB";
	/** 상품전시구분  10 : 인기순 */
	public static final String GOODS_DISP_GB_10 = "10";			
	/** 상품전시구분  20 : 최신순 */
	public static final String GOODS_DISP_GB_20 = "20";			
	/** 상품전시구분  30 : 수동 */
	public static final String GOODS_DISP_GB_30 = "30";			
	
	
	/** 리스트 타입 코드  */
	public static final String LIST_TP = "LIST_TP";
	/** 리스트 타입 코드 : 2X2 */
	public static final String LIST_TP_22 = "22";				
	/** 리스트 타입 코드 : 2X3 */
	public static final String LIST_TP_23 = "23";				
	/** 리스트 타입 코드 : 2X4 */
	public static final String LIST_TP_24 = "24";				
	/** 리스트 타입 코드 : 2X5 */
	public static final String LIST_TP_25 = "25";				
	/** 리스트 타입 코드 : 3X3 */
	public static final String LIST_TP_33 = "33";				
	/** 리스트 타입 코드 : 4X4 */
	public static final String LIST_TP_44 = "44";				
	/** 리스트 타입 코드 : 3X4 */
	public static final String LIST_TP_34 = "34";				
	/** 리스트 타입 코드 : 4X5 */
	public static final String LIST_TP_45 = "45";				
	/** 리스트 타입 코드 : 3X5 */
	public static final String LIST_TP_35 = "35";				
	/** 리스트 타입 코드 : 5X5 */
	public static final String LIST_TP_55 = "55";				
	
	
	/** 팝업 유형 코드 */
	public static final String POPUP_TP = "POPUP_TP";
	/** 팝업 유형 코드 : 일반 */
	public static final String POPUP_TP_10 = "10";				
	/** 팝업 유형 코드 : 상품 */
	public static final String POPUP_TP_20 = "20";				
	
	
	/** 웹 모바일 구분 코드 */
	public static final String WEB_MOBILE_GB = "WEB_MOBILE_GB";
	/** 웹 모바일 구분 코드 : 전체 */
	public static final String WEB_MOBILE_GB_00 = "00";			
	/** 웹 모바일 구분 코드 : PC */
	public static final String WEB_MOBILE_GB_10 = "10";			
	/** 웹 모바일 구분 코드 : MOBILE */
	public static final String WEB_MOBILE_GB_20 = "20";		
	/** 웹 모바일 구분 코드 : 오프라인 */
	public static final String WEB_MOBILE_GB_30 = "30";		
	
	/** SEO 유형 코드 */
	public static final String SEO_TP = "SEO_TP";
	/** SEO 유형 코드 : 공통 */
	public static final String SEO_TP_10 = "10";			
	/** SEO 유형 코드 : 상품 */
	public static final String SEO_TP_20 = "20";			
	/** SEO 유형 코드 : 카테고리 */
	public static final String SEO_TP_30 = "30";			
	/** SEO 유형 코드 : 브랜드 */
	public static final String SEO_TP_40 = "40";			
	/** SEO 유형 코드 : 기획전 */
	public static final String SEO_TP_50 = "50";			
	/** SEO 유형 코드 : 게시판 */
	public static final String SEO_TP_60 = "60";			
	/** SEO 유형 코드 : 기타 */
	public static final String SEO_TP_99 = "99";			

	/** OPEN GRAPH 유형 코드 */
	public static final String OPEN_GRAPH_TP = "OPEN_GRAPH_TP";
	/** OPEN GRAPH 유형 코드 : WEBSITE */
	public static final String OPEN_GRAPH_TP_WEBSITE 	= "WEBSITE";			
	/** OPEN GRAPH 유형 코드 : ARTICLE */
	public static final String OPEN_GRAPH_TP_ARTICLE 	= "ARTICLE";			
	/** OPEN GRAPH 유형 코드 : PRODUCTGRP */
	public static final String OPEN_GRAPH_TP_PRODUCTGRP = "PRODUCTGRP";			
	/** OPEN GRAPH 유형 코드 : PRODUCT */
	public static final String OPEN_GRAPH_TP_PRODUCT 	= "PRODUCT";			
	
	/** 사이트 구분*/
	public static final String SEO_SVC_GB_CD = "SEO_SVC_GB_CD";
	/** 펫샵*/
	public static final String SEO_SVC_GB_CD_10 = "10";		
	/** 펫TV*/
	public static final String SEO_SVC_GB_CD_20 = "20";		
	/** 펫로그*/
	public static final String SEO_SVC_GB_CD_30 = "30";
	/** 회원*/
	public static final String SEO_SVC_GB_CD_40 = "40";
	
	public static final String ST_SEO_PET_TV = "ST_SEO_PET_TV";
	/** 공통*/
	public static final String ST_SEO_PET_TV_10 = "10";		
	/** 카테고리*/
	public static final String ST_SEO_PET_TV_20 = "30"; 	
	/** 게시판*/
	public static final String ST_SEO_PET_TV_30 = "60";		
	
	public static final String ST_SEO_PET_LOG = "ST_SEO_PET_LOG";
	/** 공통*/
	public static final String ST_SEO_PET_LOG_10 = "10";	
	/** 게시판*/
	public static final String ST_SEO_PET_LOG_20 = "60"; 	

	/****************************
	 * 상품
	 ****************************/
	
	/** 상품 상태 코드 */
	public static final String GOODS_STAT = "GOODS_STAT";
	/** 상품 상태 코드 : 대기 */
	public static final String GOODS_STAT_10 = "10";			
	/** 상품 상태 코드 : 승인요청 */
	public static final String GOODS_STAT_20 = "20";			
	/** 상품 상태 코드 : 승인거절 */
	public static final String GOODS_STAT_30 = "30";			
	/** 상품 상태 코드 : 판매중(승인) */
	public static final String GOODS_STAT_40 = "40";			
	/** 상품 상태 코드 : 판매중지 */
	public static final String GOODS_STAT_50 = "50";			
	/** 상품 상태 코드 : 판매종료 */
	public static final String GOODS_STAT_60 = "60";
	/** 상품 상태 코드 : 삭제 */
	public static final String GOODS_STAT_70 = "70";


	/** 상품 판매 가능 상태  */
	public static final String SALE_PSB = "SALE_PSB";
	/** 상품 판매 가능 상태 : 정상 */
	public static final String SALE_PSB_00 = "00";				
	/** 상품 판매 가능 상태 : 판매중지 */
	public static final String SALE_PSB_10 = "10";				
	/** 상품 판매 가능 상태 : 판매종료 */
	public static final String SALE_PSB_20 = "20";				
	/** 상품 판매 가능 상태 : 품절 */
	public static final String SALE_PSB_30 = "30";				
	/** 상품 판매 가능 상태 : 구매가능 수량 초과 */
	public static final String SALE_PSB_40 = "40";				
	
	
	/** 상품 유형 코드 */
	public static final String GOODS_TP = "GOODS_TP";
	/** 상품 유형 코드 : 일반 */
	public static final String GOODS_TP_10 = "10";				
	/** 상품 유형 코드 : 핫딜 */
	public static final String GOODS_TP_20 = "20";				
	/** 상품 유형 코드 : 사은품 */
	public static final String GOODS_TP_30 = "30";				
	/** 상품 유형 코드 : 사전예약 */
	public static final String GOODS_TP_40 = "40";				

	/** 속성 노출 유형 코드 */
	public static final String ATTR_SHOW_TP = "ATTR_SHOW_TP";
	/** 속성 노출 유형 코드 : 기본 */
	public static final String ATTR_SHOW_TP_00 = "00";
	/** 속성 노출 유형 코드 : 콤보박스 */
	public static final String ATTR_SHOW_TP_10 = "10";       
	/** 속성 노출 유형 코드 : 컴포넌트 */
	public static final String ATTR_SHOW_TP_20 = "20";       

	/** 속성 코드 */
	public static final String ATTR = "ATTR";
	
	
	/** 판매 중지 사유 */
	public static final String CHG_RSN = "CHG_RSN";
	/** 판매 중지 사유 : 허위 정보 기재 */
	public static final String CHG_RSN_10 = "10";				
	/** 판매 중지 사유 : 저작권 침해 */
	public static final String CHG_RSN_20 = "20";				
	/** 판매 중지 사유 : 영업 방해 */
	public static final String CHG_RSN_30 = "30";				
	/** 판매 중지 사유 : 명예 훼손 */
	public static final String CHG_RSN_40 = "40";				
	/** 판매 중지 사유 : 경영상의 사유 */
	public static final String CHG_RSN_50 = "50";				
	/** 판매 중지 사유 : 위반사항 발생 */
	public static final String CHG_RSN_60 = "60";				
	/** 판매 중지 사유 : 구매자 피해발생 */
	public static final String CHG_RSN_70 = "70";				
	/** 판매 중지 사유 : 결제 부정행위 */
	public static final String CHG_RSN_80 = "80";				
	/** 판매 중지 사유 : 재판매 목적의 거래행위 */
	public static final String CHG_RSN_90 = "90";				
	/** 판매 중지 사유 : 시스템 부정행위 */
	public static final String CHG_RSN_100 = "100";				
	/** 판매 중지 사유 : 기타 금지행위 */
	public static final String CHG_RSN_110 = "110";				
	
	
	/** 상품 금액 유형 코드 */
	public static final String GOODS_AMT_TP = "GOODS_AMT_TP";
	/** 상품 금액 유형 코드 : 일반 */
	public static final String GOODS_AMT_TP_10 = "10";			
	/** 상품 금액 유형 코드 : 타임딜 */
	public static final String GOODS_AMT_TP_20 = "20";			
	/** 상품 금액 유형 코드 : 공동구매 */
	@Deprecated
	public static final String GOODS_AMT_TP_30 = "30";			
	/** 상품 금액 유형 코드 : 유통기한 임박 할인 */
	public static final String GOODS_AMT_TP_40 = "40";			
	/** 상품 금액 유형 코드 : 재고 임박 할인 */
	public static final String GOODS_AMT_TP_50 = "50";			
	/** 상품 금액 유형 코드 : 사전 예약 상품 */
	public static final String GOODS_AMT_TP_60 = "60";			
	
	
	/** 공동구매 종료 여부 */
	public static final String BULK_ORD_END_YN = "BULK_ORD_END_YN";
	/** 공동구매 종료 여부 - 종료 */
	public static final String BULK_ORD_END_YN_Y = "Y";			
	/** 공동구매 종료 여부 - 진행중 */
	public static final String BULK_ORD_END_YN_N = "N";			
	
	
	/** 상품 구성 구분 코드 */
	public static final String GOODS_CSTRT_GB = "GOODS_CSTRT_GB";
	/** 상품 구성 구분 코드 : 연관상품 */
	public static final String GOODS_CSTRT_GB_20 = "20";		


	/** 입력방법코드 */
	public static final String INPUT_MTD = "INPUT_MTD";
	/** 입력방법코드 : INPUT */
	public static final String INPUT_MTD_10 = "10";				
	/** 입력방법코드 : TEXT */
	public static final String INPUT_MTD_20 = "20";				
	
	
	/** 서비스 구분 코드 */
	public static final String SVC_GB = "SVC_GB";
	/** 서비스 구분 코드 : PC */
	public static final String SVC_GB_10 = "10";				
	/** 서비스 구분 코드 : MOBILE */
	public static final String SVC_GB_20 = "20";
	
	/** 노출 영역 구분 코드 */
	public static final String SHOW_AREA_GB = "SHOW_AREA_GB";
	/** 노출 영역 구분 코드 : 상단 */
	public static final String SHOW_AREA_GB_10 = "10";				
	/** 노출 영역 구분 코드 : 하단 */
	public static final String SHOW_AREA_GB_20 = "20";				
	
	/** 관리여부 코드 */
	public static final String MNG_YN = "MNG_YN";
	/** 관리여부 코드 : 관리함 */
	public static final String MNG_YN_Y = "Y";					
	/** 관리여부 코드 : 관리안함 */
	public static final String MNG_YN_N = "N";					
	
	
	/** 단품 상태 코드 */
	public static final String ITEM_STAT = "ITEM_STAT";
	/** 단품 상태 코드 : 판매중 */
	public static final String ITEM_STAT_10 = "10";				
	/** 단품 상태 코드 : 판매중지 */
	public static final String ITEM_STAT_20 = "20";				
	
	
	/** 인기 설정 코드 */
	public static final String PPLRT_SET = "PPLRT_SET";
	/** 인기 설정 코드 : 자동 */
	public static final String PPLRT_SET_10 = "10";				
	/** 인기 설정 코드 : 수동 */
	public static final String PPLRT_SET_20 = "20";				
	
	
	/** 상품 문의 상태 코드 */
	public static final String GOODS_IQR_STAT = "GOODS_IQR_STAT";
	/** 상품 문의 상태 코드 : 대기중 */
	public static final String GOODS_IQR_STAT_10 = "10";
	/** 상품 문의 상태 코드 : 답변완료 */
	public static final String GOODS_IQR_STAT_20 = "20";
	
	/** 상품 문의 액션 코드 */
	public static final String GOODS_IQR_ACTN = "GOODS_IQR_ACTN";
	/** 상품 문의 상태 코드 : 좋아요 */
	public static final String GOODS_IQR_ACTN_LIKE = "LIKE";
	/** 상품 문의 상태 코드 : 신고 */
	public static final String GOODS_IQR_ACTN_RPT = "RPT";
	
	/** 주문제작여부 */
	public static final String ORDMKI_YN = "ORDMKI_YN";
	/** 주문제작여부 : 주문제작 */
	public static final String ORDMKI_YN_Y = "Y";					
	/** 주문제작여부 : 일반 */
	public static final String ORDMKI_YN_N = "N";
	
	/** :  */
	public static final String ORD_PROPS = "ORD_PROPS";
	/** 주문 properties : 가격 비노출 주문 번호 */
	public static final String ORD_PROPS_10 = "10";

	/** 상품 구성 유형 */
	public static final String GOODS_CSTRT_TP = "GOODS_CSTRT_TP";
	/** 상품 구성 유형 : 단품 */
	public static final String GOODS_CSTRT_TP_ITEM = "ITEM";
	/** 상품 구성 유형 : 옵션 */
	public static final String GOODS_CSTRT_TP_ATTR = "ATTR";
	/** 상품 구성 유형 : 세트 */
	public static final String GOODS_CSTRT_TP_SET = "SET";
	/** 상품 구성 유형 : 묶음 */
	public static final String GOODS_CSTRT_TP_PAK = "PAK";

	/** 사은품 가능 여부 */
	public static final String FRB_PSB_YN = "FRB_PSB_YN";
	/** 사은품 가능 여부 : 가능 */
	public static final String FRB_PSB_YN_Y = "Y";					
	/** 사은품 가능 여부 : 판매전용 */
	public static final String FRB_PSB_YN_N = "N";
	
	/** 사은품 유형 : 1+1 */
	public static final String GOODS_FRB_TP_1PLUS1 = "1PLUS1";
	/** 사은품유형 : 2+1 */
	public static final String GOODS_FRB_TP_2PLUS1 = "2PLUS1";
	/** 사은품 유형 : 사은품 */
	public static final String GOODS_FRB_TP_GIFT = "GIFT";
	public static final String GOODS_FRB_TP_GIFTP = "GIFTP";
	/** 사은품 유형 : 기타 */
	public static final String GOODS_FRB_TP_ETC = "ETC";
	
	/** 샵링커 전송 여부 */
	public static final String SHOPLINKER_SND_YN = "SHOPLINKER_SND_YN";
	/** 샵링커 전송 여부  : 전송 */
	public static final String SHOPLINKER_SND_YN_Y = "Y";					
	/** 샵링커 전송 여부  : 전송안함 */
	public static final String SHOPLINKER_SND_YN_N = "N";
	
	/** 상품 출처 코드 */
	public static final String GOODS_SRC = "GOODS_SRC";
	/** 상품 출처 코드 : 해당없음 */
	public static final String GOODS_SRC_00 = "00";					
	/** 상품 출처 코드 : 해외구매대행 */
	public static final String GOODS_SRC_10 = "10";
	/** 상품 출처 코드 : 병행수입 */
	public static final String GOODS_SRC_20 = "20";
	/** 상품 출처 코드 : 주문제작 */
	public static final String GOODS_SRC_30 = "30";
	
	/** 판매_유형_코드 */
	public static final String SALE_TP = "SALE_TP";
	/** 판매_유형_코드  : 일반 */
	public static final String SALE_TP_10 = "10";
	/** 판매_유형_코드  : 도매 */
	public static final String SALE_TP_20 = "20";
	/** 판매_유형_코드  : 렌탈 */
	public static final String SALE_TP_30 = "30";
	/** 판매_유형_코드  : 대여 */
	public static final String SALE_TP_40 = "40";
	/** 판매_유형_코드  : 예약판매 */
	public static final String SALE_TP_50 = "50";
	/** 판매_유형_코드  : 구매대행 */
	public static final String SALE_TP_60 = "60";
	
	/** 주요 사용 연령대 코드 */
	public static final String STP_USE_AGE = "STP_USE_AGE";
	/** 주요 사용 연령대 코드 : 전연령 */
	public static final String STP_USE_AGE_ALL = "ALL";
	/** 주요 사용 연령대 코드 : 성인 */
	public static final String STP_USE_AGE_ADULT = "ADULT";
	/** 주요 사용 연령대 코드 : 청소년 */
	public static final String STP_USE_AGE_TEEN = "TEEN";
	/** 주요 사용 연령대 코드 : 아동 */
	public static final String STP_USE_AGE_CHILD = "CHILD";
	/** 주요 사용 연령대 코드 : 유아 */
	public static final String STP_USE_AGE_BABY = "BABY";
	
	/** 주요 사용 성별 코드 */
	public static final String STP_USE_GD = "STP_USE_GD";
	/** 주요 사용 성별 코드 : 무관 */
	public static final String STP_USE_GD_NONE = "NONE";
	/** 주요 사용 성별 코드 : 남성 */
	public static final String STP_USE_GD_MALE = "MALE";
	/** 주요 사용 성별 코드 : 여성 */
	public static final String STP_USE_GD_FEMALE = "FEMALE";
	/** 주요 사용 성별 코드 : 공용 */
	public static final String STP_USE_GD_UNI = "UNI";

	/** 상품 후기 유형 코드 */
	public static final String GOODS_ESTM_TP = "GOODS_ESTM_TP";

	/** 일반 */
	public static final String GOODS_ESTM_TP_NOR = "NOR";
	/** 펫로그*/
	public static final String GOODS_ESTM_TP_PLG = "PLG";

	/** 상품 평점 유형 */
	public static final String GOODS_ESTM_SCR_TP = "GOODS_ESTM_SCR_TP";

	/** 상품 문의 액션 코드 */
	public static final String GOODS_ESTM_ACTN = "GOODS_ESTM_ACTN";
	/** 상품 문의 상태 코드 : 좋아요 */
	public static final String GOODS_ESTM_ACTN_LIKE = "LIKE";
	/** 상품 문의 상태 코드 : 신고 */
	public static final String GOODS_ESTM_ACTN_RPT = "RPT";
	
	/** 답변 유형 코드 */
	public static final String RPL_TP = "RPL_TP";
	/** 답변 유형 코드 : 항목 */
	public static final String RPL_TP_ITEM = "ITEM";
	/** 답변 유형 코드 : 점수 */
	public static final String RPL_TP_SCORE = "SCORE";	
	
	/** 펫샵*/
	public static final String SEO_SVC_SHOP = "SHOP";		
	/** 펫TV*/
	public static final String SEO_SVC_TV = "TV";		
	/** 펫로그*/
	public static final String SEO_SVC_LOG = "LOG";
	
	/** 원산지 cd 임시... */
	public static final String ORIGIN_CD = "ORIGIN_CD";
	
	/****************************
	 * 마케팅
	 ****************************/
	
	/** 적용 혜택 구분 */
	public static final String APL_BNFT_GB = "APL_BNFT_GB";
	/** 적용 혜택 구분 : 프로모션 */
	public static final String APL_BNFT_GB_10 = "10";			
	/** 적용 혜택 구분 : 쿠폰 */
	public static final String APL_BNFT_GB_20 = "20";			
	

	/** 적용 혜택 유형 */
	public static final String APL_BNFT_TP = "APL_BNFT_TP";
	/** 적용 혜택 유형 : 가격할인 */
	public static final String APL_BNFT_TP_110 = "110";			
	/** 적용 혜택 유형 : 사은품 */
	public static final String APL_BNFT_TP_120 = "120";			
	/** 적용 혜택 유형 : 상품 쿠폰 */
	public static final String APL_BNFT_TP_210 = "210";			
	/** 적용 혜택 유형 : 장바구니 쿠폰 */
	public static final String APL_BNFT_TP_220 = "220";			
	

	/** 사이트 프로모션 적용 코드 */
	public static final String PRMT_APL_GB = "PRMT_APL_GB";
	/** 사이트 프로모션 적용 코드 : 프로모션 */
	public static final String PRMT_APL_GB_10 = "10";			
	/** 사이트 프로모션 적용 코드 : 쿠폰 */
	public static final String PRMT_APL_GB_20 = "20";			
	/** 사이트 프로모션 적용 코드 : 이벤트 */
	public static final String PRMT_APL_GB_30 = "30";			
	
	
	/** 프로모션 적용 코드 */
	public static final String PRMT_APL = "PRMT_APL";
	/** 프로모션 적용 코드 : 정율 */
	public static final String PRMT_APL_10 = "10";				
	/** 프로모션 적용 코드 : 정액 */
	public static final String PRMT_APL_20 = "20";				
	

	/** 프로모션 종류 코드 */
	public static final String PRMT_KIND = "PRMT_KIND";
	/** 프로모션 종류 코드 : 가격할인 */
	public static final String PRMT_KIND_10 = "10";				
	/** 프로모션 종류 코드 : 사은품 */
	public static final String PRMT_KIND_20 = "20";				
	/** 프로모션 종류 코드 : 적립금 */
	public static final String PRMT_KIND_30 = "30";				

	
	/** 프로모션 상태 코드 */
	public static final String PRMT_STAT = "PRMT_STAT";
	/** 프로모션 상태 코드 : 승인전 */
	public static final String PRMT_STAT_10 = "10";				
	/** 프로모션 상태 코드 : 진행 */
	public static final String PRMT_STAT_20 = "20";				
	/** 프로모션 상태 코드 : 중단 */
	public static final String PRMT_STAT_30 = "30";				

	
	/** 프로모션 대상 코드 */
	public static final String PRMT_TG = "PRMT_TG";
	/** 프로모션 대상 코드 : 전체 */
	public static final String PRMT_TG_10 = "10";				
	/** 프로모션 대상 코드 : 상품 */
	public static final String PRMT_TG_20 = "20";				
	/** 프로모션 대상 코드 : 전시 카테고리 */
	public static final String PRMT_TG_30 = "30";				
	/** 프로모션 대상 코드 : 기획전 */
	public static final String PRMT_TG_40 = "40";				
	/** 프로모션 대상 코드 : 공급사 */
	public static final String PRMT_TG_50 = "50";				
	/** 프로모션 대상 코드 : 브랜드 */
	public static final String PRMT_TG_60 = "60";				
		
	
	/** 쿠폰 상태 코드 */
	public static final String CP_STAT = "CP_STAT";
	/** 쿠폰 상태 코드 : 승인전 */
	public static final String CP_STAT_10 = "10";				
	/** 쿠폰 상태 코드 : 진행 */
	public static final String CP_STAT_20 = "20";				
	/** 쿠폰 상태 코드 : 중단 */
	public static final String CP_STAT_30 = "30";				
	/** 쿠폰 상태 코드 : 종료 */
	public static final String CP_STAT_40 = "40";				
	
	
	/** 쿠폰 대상 코드 */
	public static final String CP_TG = "CP_TG";
	
	/** 쿠폰 대상 코드 : 전체상품 */
	public static final String CP_TG_10 = "10";
	/** 쿠폰 대상 코드 : 특정 상품 */
	public static final String CP_TG_20 = "20";
	/** 쿠폰 대상 코드 : 특정 카테고리 */
	public static final String CP_TG_30 = "30";
	/** 쿠폰 대상 코드 : 특정 기획전 */
	public static final String CP_TG_40 = "40";
	/** 쿠폰 대상 코드 : 특정 공급사 */
	@Deprecated
	public static final String CP_TG_50 = "50";
	/** 쿠폰 대상 코드 : 특정 브랜드 */
	public static final String CP_TG_60 = "60";
	
	
	/** 쿠폰 적용 코드 */
	public static final String CP_APL = "CP_APL";
	/** 쿠폰 적용 코드 : 정율 */
	public static final String CP_APL_10 = "10";				
	/** 쿠폰 적용 코드 : 정액 */
	public static final String CP_APL_20 = "20";				
	

	/** 쿠폰 발급 코드 */
	public static final String CP_ISU = "CP_ISU";
	/** 쿠폰 발급 코드 : 무제한 */
	public static final String CP_ISU_10 = "10";				
	/** 쿠폰 발급 코드 : 제한 */
	public static final String CP_ISU_20 = "20";				

	
	/** 쿠폰 종류 코드 */
	public static final String CP_KIND = "CP_KIND";
	/** 쿠폰 종류 코드 : 상품 */
	public static final String CP_KIND_10 = "10";				
	/** 쿠폰 종류 코드 : 장바구니 */
	public static final String CP_KIND_20 = "20";				
	/** 쿠폰 종류 코드 : 배송비 */
	public static final String CP_KIND_30 = "30";				

	
	/** 쿠폰 지급 방식 코드 */
	public static final String CP_PVD_MTH = "CP_PVD_MTH";

	/** 쿠폰 지급 방식 코드 : 다운로드 */
	public static final String CP_PVD_MTH_10 = "10";
	/** 쿠폰 지급 방식 코드 : 난수입력 */
	public static final String CP_PVD_MTH_20 = "20";
	/** 쿠폰 지급 방식 코드 : 자동 */
	public static final String CP_PVD_MTH_30 = "30";
	/** 쿠폰 지급 방식 코드 : 수동 */
	public static final String CP_PVD_MTH_40 = "40";
	/** 쿠폰 지급 방식 코드 : 코드입력 */
	public static final String CP_PVD_MTH_50 = "50";


	/** 유효 기간 코드 */
	public static final String VLD_PRD = "VLD_PRD";
	/** 유효 기간 코드 : 발급일 */
	public static final String VLD_PRD_10 = "10";				
	/** 유효 기간 코드 : 일자지정 */
	public static final String VLD_PRD_20 = "20";				
	
	/** 중복 사용 여부 */
	public static final String MULTI_APL_YN = "MULTI_APL_YN";
	/** 중복 사용 여부 : 단수적용 */
	public static final String MULTI_APL_YN_N = "N";				
	/** 중복 사용 여부 : 단수적용 */
	public static final String MULTI_APL_YN_Y = "Y";		
	
	
	/** 중복 사용 여부 */
	public static final String DUPLE_USE_YN = "DUPLE_USE_YN";
	/** 중복 사용 여부 : 사용가능 */
	public static final String DUPLE_USE_YN_Y = "Y";			
	/** 중복 사용 여부 : 사용불가능 */
	public static final String DUPLE_USE_YN_N = "N";			

	
	/** 발급 대상 코드 */
	public static final String ISU_TG = "ISU_TG";
	/** 발급 대상 코드 : 전체 */
	public static final String ISU_TG_00 = "00";	
	/** 발급 대상 코드 : 준회원 */
	public static final String ISU_TG_10 = "10";		
	/** 발급 대상 코드 : 정회원 */
	public static final String ISU_TG_20 = "20";				
	
	/** 발행 구분 코드 */
	public static final String ISU_GB = "ISU_GB";
	/** 발행 구분 코드 : 자동 발급 */
	public static final String ISU_GB_10 = "10";				
	/** 발행 구분 코드 : 수동 발급 */
	public static final String ISU_GB_20 = "20";				

	
	/** 발급 주체 코드 */
	public static final String ISU_HOST = "ISU_HOST";
	/** 발급 주체 코드 : 통합몰 */
	public static final String ISU_HOST_10 = "10";				
	/** 발급 주체 코드 : 공급업체 */
	public static final String ISU_HOST_20 = "20";				
	
	
	/** 발급 유형 코드 */
	public static final String ISU_TP = "ISU_TP";
	/** 발급 유형 코드 : 시스템 */
	public static final String ISU_TP_10 = "10";				
	/** 발급 유형 코드 : 다운로드 */
	public static final String ISU_TP_20 = "20";				
	/** 발급 유형 코드 : CS */
	public static final String ISU_TP_30 = "30";				
	/** 발급 유형 코드 : 클레임 재발행 */
	public static final String ISU_TP_40 = "40";				
	
	/** 외부 쿠폰 코드 */
	public static final String OUTSIDE_CP = "OUTSIDE_CP";
	
	/** 외부 쿠폰 코드 : 네이버*/
	public static final String OUTSIDE_CP_10 = "10";
	
	/** 쿠폰 복원 가능 여부 */
	public static final String CP_RSTR_YN = "CP_RSTR_YN";


	/** 이벤트 구분 코드 */
	public static final String EVENT_GB = "EVENT_GB";
	/** 이벤트 구분 코드 : 안내 */
	public static final String EVENT_GB_10 = "10";
	/** 이벤트 구분 코드 : 개인정보 수집 */
	public static final String EVENT_GB_20 = "20";
	/** 이벤트 구분 코드 : 퀴즈 */
	public static final String EVENT_GB_30 = "30";

	/** 기획전 구분 코드 */
	public static final String EXHBT_GB = "EXHBT_GB";
	/** 기획전 구분 코드 : 특별 기획전 */
	public static final String EXHBT_GB_10 = "10";				
	/** 기획전 구분 코드 : 일반 기획전 */
	public static final String EXHBT_GB_20 = "20";						

	
	/** 기획전 승인 상태 코드 */
	public static final String EXHBT_STAT = "EXHBT_STAT";
	/** 기획전 승인 상태 코드 : 승인 대기 */
	public static final String EXHBT_STAT_10 = "10";			
	/** 기획전 승인 상태 코드 : 승인 */
	public static final String EXHBT_STAT_20 = "20";			
	/** 기획전 승인 상태 코드 : 반려 */
	public static final String EXHBT_STAT_30 = "30";			
	/** 기획전 승인 상태 코드 : 종료 */
	public static final String EXHBT_STAT_40 = "40";			
	
	/** 전시 레벨3 */
	public static final Long DISP_LVL_3 = 3L;
	
	/****************************
	 * 주문
	 ****************************/
	
	/** 주문 클레임 구분 코드 */
	public static final String ORD_CLM_GB = "ORD_CLM_GB";
	
	/** 주문 클레임 구분 코드 : 주문 */
	public static final String ORD_CLM_GB_10 = "10";
	/** 주문 클레임 구분 코드 : 클레임 */
	public static final String ORD_CLM_GB_20 = "20";
	
	
	/** 주문 상태 코드 */
	public static final String ORD_STAT = "ORD_STAT";
	
	/** 주문 상태 코드 : 주문접수 */
	public static final String ORD_STAT_10 = "10";
	/** 주문 상태 코드 : 주문완료 */
	public static final String ORD_STAT_20 = "20";
	
	
	/** 주문 상세 상태 */
	public static final String ORD_DTL_STAT = "ORD_DTL_STAT";
	
	/** 주문 상세 상태 : 주문접수 */
	public static final String ORD_DTL_STAT_110 = "110";
	/** 주문 상세 상태 : 주문완료 */
	public static final String ORD_DTL_STAT_120 = "120";
	/** 주문 상세 상태 : 배송지시 */
	public static final String ORD_DTL_STAT_130 = "130";
	/** 주문 상세 상태 : 배송준비중 */
	public static final String ORD_DTL_STAT_140 = "140";
	/** 주문 상세 상태 : 배송중 */
	public static final String ORD_DTL_STAT_150 = "150";
	/** 주문 상세 상태 : 배송완료 */
	public static final String ORD_DTL_STAT_160 = "160";
	/** 주문 상세 상태 : 구매확정 */
	public static final String ORD_DTL_STAT_170 = "170";

	
	/** 주문 매체 코드 */
	public static final String ORD_MDA = "ORD_MDA";
	
	/** 주문 매체 코드 : PC */
	public static final String ORD_MDA_10 = "10";
	/** 주문 매체 코드 : MOBILE */
	public static final String ORD_MDA_20 = "20";

	
	/** 주문 처리 상태 */
	public static final String ORD_PRCS_RST = "ORD_PRCS_RST";

	/** 주문 처리 상태 : 정상처리 */
	public static final String ORD_PRCS_RST_0000 = "0000";
	/** 주문 처리 상태 : 주문 전 처리 오류 */
	public static final String ORD_PRCS_RST_1000 = "1000";
	/** 주문 처리 상태 : 기본정보 처리 오류 */
	public static final String ORD_PRCS_RST_2000 = "2000";
	/** 주문 처리 상태 : 결제정보 처리 오류 */
	public static final String ORD_PRCS_RST_3000 = "3000";
	/** 주문 처리 상태 : 주문완료 처리 오류 */
	public static final String ORD_PRCS_RST_4000 = "4000";
	/** 주문 처리 상태 : 주문 후 처리 오류 */
	public static final String ORD_PRCS_RST_5000 = "5000";
	/** 주문 처리 상태 : 롤백 처리 오류 */
	public static final String ORD_PRCS_RST_8000 = "8000";
	/** 주문 처리 상태 : 기타오류 */
	public static final String ORD_PRCS_RST_9000 = "9000";
	
	
	/** 비용 구분 코드 */
	public static final String COST_GB = "COST_GB";
	
	/** 비용 구분 코드 : 배송비 */
	public static final String COST_GB_10 = "10";
	/** 비용 구분 코드 : 회수비 */
	public static final String COST_GB_20 = "20";

	/** 구성 상품 구분 코드 */
	public static final String CSTRT_GOODS_GB = "CSTRT_GOODS_GB";
	/** 구성 상품 구분 코드 : 단품 */
	public static final String CSTRT_GOODS_GB_10 = "10";
	/** 구성 상품 구분 코드 : 세트 */
	public static final String CSTRT_GOODS_GB_20 = "20";
	/** 구성 상품 구분 코드 : 사은품 */
	public static final String CSTRT_GOODS_GB_30 = "30";
	
	/** 배송 지연 기간  */
	public static final String DLVR_DELAY_PRD = "DLVR_DELAY_PRD";

	/** 배송 지연 기간 : 해당없음 */
	public static final String DLVR_DELAY_PRD_10 = "10";
	/** 배송 지연 기간 : 3일째 */
	public static final String DLVR_DELAY_PRD_30 = "30";
	/** 배송 지연 기간 : 4일째 */
	public static final String DLVR_DELAY_PRD_40 = "40";
	/** 배송 지연 기간 : 5일째 */
	public static final String DLVR_DELAY_PRD_50 = "50";
	/** 배송 지연 기간 : 6일째 */
	public static final String DLVR_DELAY_PRD_60 = "60";
	/** 배송 지연 기간 : 7일째 */
	public static final String DLVR_DELAY_PRD_70 = "70";
	/** 배송 지연 기간 : 7일 초과 */
	public static final String DLVR_DELAY_PRD_80 = "80";
	
	
	/** 배송 구분 */
	public static final String DLVR_GB = "DLVR_GB";
	
	/** 배송 구분 : 출고 */
	public static final String DLVR_GB_10 = "10";
	/** 배송 구분 : 회수 */
	public static final String DLVR_GB_20 = "20";
	
	
	/** 배송 처리 유형 코드 */
	public static final String DLVR_PRCS_TP = "DLVR_PRCS_TP";

	/** 배송 처리 유형 코드 : 택배 */
	public static final String DLVR_PRCS_TP_10 = "10";
	/** 배송 처리 유형 코드 : 당일배송 */
	public static final String DLVR_PRCS_TP_20 = "20";
	/** 배송 처리 유형 코드 : 새벽배송 */
	public static final String DLVR_PRCS_TP_21 = "21";

	
	/** 선착불 구분 코드 */
	public static final String PREPAY_GB = "PREPAY_GB";
	
	/** 선착불 구분 코드 : 선불 */
	public static final String PREPAY_GB_10 = "10";
	/** 선착불 구분 코드 : 착불 */
	public static final String PREPAY_GB_20 = "20";
		
	
	/** 배송 유형 코드 */
	public static final String DLVR_TP = "DLVR_TP";

	/** 배송 유형 코드 : 정상출고 */
	public static final String DLVR_TP_110 = "110";
	/** 배송 유형 코드 : 교환출고 */
	public static final String DLVR_TP_120 = "120";
	/** 배송 유형 코드 : 반품회수 */
	public static final String DLVR_TP_210 = "210";
	/** 배송 유형 코드 : 교환회수 */
	public static final String DLVR_TP_220 = "220";

	
	/** 결제 구분 코드 */
	public static final String PAY_GB = "PAY_GB";

	/** 결제 구분 코드 : 결제 */
	public static final String PAY_GB_10 = "10";
	/** 결제 구분 코드 : 환불 */
	public static final String PAY_GB_20 = "20";
	/** 결제 구분 코드 : 입금(마이너스 환불) */
	public static final String PAY_GB_30 = "30";
	/** 결제 구분 코드 : 환불(마이너스 환불) */
	public static final String PAY_GB_40 = "40";
	
	/** 포인트 유형 */
	public static final String PNT_TP = "PNT_TP";
	
	/** 포인트 유형 : GS 포인트 */
	public static final String PNT_TP_GS = "GS";
	
	/** 포인트 유형 : MP 포인트 */
	public static final String PNT_TP_MP = "MP";
	
	/** 포인트 프로모션 구분 */
	public static final String PNT_PRMT_GB = "PNT_PRMT_GB";
	
	/** 포인트 프로모션 구분 : 일반 */
	public static final String PNT_PRMT_GB_10 = "10";
	
	/** 포인트 프로모션 구분 : 부스트업 */
	public static final String PNT_PRMT_GB_20 = "20";
	
	/**  MP 연동 구분 코드 */
	public static final String MP_LNK_GB = "MP_LNK_GB";
	
	/**  MP 연동 구분 코드 :  사용 적립*/
	public static final String MP_LNK_GB_10 = "10";
	
	/**  MP 연동 구분 코드 :  사용 적립 취소 */
	public static final String MP_LNK_GB_20 = "20";
	
	/**  MP 연동 구분 코드 :  적립 */
	public static final String MP_LNK_GB_30 = "30";

	/**  MP 연동 구분 코드 :  적립 취소 */
	public static final String MP_LNK_GB_40 = "40";
	
	/**  MP 실 연동 구분 코드 */
	public static final String MP_REAL_LNK_GB = "MP_REAL_LNK_GB";
	
	/**  MP 실 연동 구분 코드 :  결제 */
	public static final String MP_REAL_LNK_GB_10 = "10";
	
	/**  MP 실 연동 구분 코드 :  결제 취소 */
	public static final String MP_REAL_LNK_GB_20 = "20";
	
	/** 결제 수단 코드 */
	public static final String PAY_MEANS = "PAY_MEANS";

	/** 결제 수단 코드 : 0원 결제 */
	public static final String PAY_MEANS_00 = "00";
	
	/** 결제 수단 코드 : 신용카드 */
	public static final String PAY_MEANS_10 = "10";
	
	/** 결제 수단 코드 : 신용카드  빌링 결제 */
	public static final String PAY_MEANS_11 = "11";

	/** 결제 수단 코드 : 실시간계좌이체 */
	public static final String PAY_MEANS_20 = "20";
	
	/** 결제 수단 코드 : 가상계좌 */
	public static final String PAY_MEANS_30 = "30";
	
	/** 결제 수단 코드 : N pay */
	public static final String PAY_MEANS_70 = "70";
	
	/** 결제 수단 코드 : 카카오페이 */
	public static final String PAY_MEANS_71 = "71";
	
	/** 결제 수단 코드 : PAYCO */
	public static final String PAY_MEANS_72 = "72";
	
	/** 결제 수단 코드 : GS 포인트 */
	public static final String PAY_MEANS_80 = "80";
	
	/** 결제 수단 코드 : MP 포인트 */
	public static final String PAY_MEANS_81 = "81";
	
	/** 결제 수단 코드 : 무통장 */
	@Deprecated
	public static final String PAY_MEANS_40 = "40";
	/** 결제 수단 코드 : 적립금 */
	@Deprecated
	public static final String PAY_MEANS_50 = "50";
	/** 결제 수단 코드 : 외부몰 */
	@Deprecated
	public static final String PAY_MEANS_90 = "90";
	
	/** 결제 상태 코드 */
	public static final String PAY_STAT = "PAY_STAT";

	/** 결제 상태 코드 : 입금 대기 */
	public static final String PAY_STAT_00 = "00";
	/** 결제 상태 코드 : 결제 완료 */
	public static final String PAY_STAT_01 = "01";
	
	/** 적립 포인트 구분 코드 */
	@Deprecated public static final String SAVE_PNT_GB = "SAVE_PNT_GB";
	/** 적립 포인트 구분 코드 : 적립 */
	@Deprecated public static final String SAVE_PNT_GB_10 = "10";				
	/** 적립 포인트 구분 코드 : 취소 */
	@Deprecated public static final String SAVE_PNT_GB_20 = "20";		
	/** 적립 포인트 구분 코드 : 사용 */
	@Deprecated public static final String SAVE_PNT_GB_30 = "30";
	
	/** 적립 사용 구분 코드 */
	public static final String SAVE_USE_GB = "SAVE_USE_GB";
	/** 적립 포인트 구분 코드 : 적립 */
	public static final String SAVE_USE_GB_10 = "10";				
	/** 적립 포인트 구분 코드 : 취소 */
	public static final String SAVE_USE_GB_20 = "20";		
	/** 적립 포인트 구분 코드 : 사용 */
	public static final String SAVE_USE_GB_30 = "30";
	
	/** 거래 구분 코드 **/
	public static final String DEAL_GB = "DEAL_GB";
	/** 거래 구분 코드 : 결제 **/
	public static final String DEAL_GB_10 = "10";
	/** 거래 구분 코드 : 결제 취소 **/
	public static final String DEAL_GB_20 = "20";
	/** 거래 구분 코드 : 후기 등록 **/
	public static final String DEAL_GB_30 = "30";
	/** 거래 구분 코드 : 후기 좋아요 **/
	public static final String DEAL_GB_40 = "40";
	
		
	/** 은행 코드 */
	public static final String BANK = "BANK";
	
	/** 은행 코드 : 기업은행 */
	public static final String BANK_03 = "03";
	/** 은행 코드 : 국민은행 */
	public static final String BANK_04 = "04";
	/** 은행 코드 : 수협은행 */
	public static final String BANK_07 = "07";
	/** 은행 코드 : 농협은행 */
	public static final String BANK_11 = "11";
	/** 은행 코드 : 우리은행 */
	public static final String BANK_20 = "20";
	/** 은행 코드 : SC제일은행 */
	public static final String BANK_23 = "23";
	/** 은행 코드 : 한국씨티은행 */
	public static final String BANK_27 = "27";
	/** 은행 코드 : 대구은행 */
	public static final String BANK_31 = "31";
	/** 은행 코드 : 부산은행 */
	public static final String BANK_32 = "32";
	/** 은행 코드 : 광주은행 */
	public static final String BANK_34 = "34";
	/** 은행 코드 : 제주은행 */
	public static final String BANK_35 = "35";
	/** 은행 코드 : 전북은행 */
	public static final String BANK_37 = "37";
	/** 은행 코드 : 경남은행 */
	public static final String BANK_39 = "39";
	/** 은행 코드 : 새마을금고 */
	public static final String BANK_45 = "45";
	/** 은행 코드 : 신협 */
	public static final String BANK_48 = "48";
	/** 은행 코드 : 우체국 */
	public static final String BANK_71 = "71";
	/** 은행 코드 : 하나은행 */
	public static final String BANK_81 = "81";
	/** 은행 코드 : 신한은행 */
	public static final String BANK_88 = "88";					
	
	
	/** 카드사 코드 */
	public static final String CARDC = "CARDC";
	/** 카드사 코드 : BC*/
	public static final String CARDC_01 = "01";
	/** 카드사 코드 : KB국민 */
	public static final String CARDC_02 = "02";
	/** 카드사 코드 : 하나(외환) */
	public static final String CARDC_03 = "03";
	/** 카드사 코드 : 삼성 */
	public static final String CARDC_04 = "04";
	/** 카드사 코드 : 신한 */
	public static final String CARDC_06 = "06";
	/** 카드사 코드 : 현대 */
	public static final String CARDC_07 = "07";
	/** 카드사 코드 : 롯데 */
	public static final String CARDC_08 = "08";
	/** 카드사 코드 : 씨티 */
	public static final String CARDC_11 = "11";
	/** 카드사 코드 : NH농협 */
	public static final String CARDC_12 = "12";
	/** 카드사 코드 : 수협 */
	public static final String CARDC_13 = "13";
	/** 카드사 코드 : 우리 */
	public static final String CARDC_15 = "15";
	/** 카드사 코드 : 광주*/
	public static final String CARDC_21 = "21";
	/** 카드사 코드 : 전북 */
	public static final String CARDC_22 = "22";
	/** 카드사 코드 : 제주 */
	public static final String CARDC_23 = "23";
	/** 무이자 여부 : N */
	public static final String FREE_INTEREST_YN_N = "0";
	/** 무이자 여부 : Y */
	public static final String FREE_INTEREST_YN_Y = "1";
	/** 할부 개월 : 일시불 */
	public static final String SINGLE_INSTMNT = "00";


	/** 과세 구분 코드 */
	public static final String TAX_GB = "TAX_GB";
	/** 과세 구분 코드 : 과세 */
	public static final String TAX_GB_10 = "10";				
	/** 과세 구분 코드 : 면세 */
	public static final String TAX_GB_20 = "20";				
	/** 과세 구분 코드 : 영세 */
	public static final String TAX_GB_30 = "30";				
	
	
	/** 현금 영수증 상태 코드 */
	public static final String CASH_RCT_STAT = "CASH_RCT_STAT";
	
	/** 현금 영수증 상태 코드 : 접수 */
	public static final String CASH_RCT_STAT_10 = "10";	
	/** 현금 영수증 상태 코드 : 발행 */
	public static final String CASH_RCT_STAT_20 = "20";
	/** 현금 영수증 상태 코드 : 취소 */
	public static final String CASH_RCT_STAT_30 = "30";
	/** 현금 영수증 상태 코드 : 오류 */
	public static final String CASH_RCT_STAT_90 = "90";			

	
	/** 현금 영수증 발행 유형 코드 */
	public static final String CR_TP = "CR_TP";
	/** 현금 영수증 발행 유형 코드 : 발행요청 */
	public static final String CR_TP_10 = "10";
	/** 현금 영수증 발행 유형 코드 : 발행취소 */
	public static final String CR_TP_20 = "20";
	
		
	/** 발급 수단 코드 */
	public static final String ISU_MEANS = "ISU_MEANS";

	/** 발급 수단 코드 : 주민등록번호 */
	public static final String ISU_MEANS_10 = "10";
	/** 발급 수단 코드 : 휴대폰번호 */
	public static final String ISU_MEANS_20 = "20";
	/** 발급 수단 코드 : 사업자등록번호 */
	public static final String ISU_MEANS_30 = "30";
	

	/** 사용 구분 코드 */
	public static final String USE_GB = "USE_GB";
	
	/** 사용 구분 코드 : 소득공제용 */
	public static final String USE_GB_10 = "10";
	/** 사용 구분 코드 : 사업자지출증빙용 */
	public static final String USE_GB_20 = "20";
	
	
	/** 세금 계산서 상태 코드 */
	public static final String TAX_IVC_STAT = "TAX_IVC_STAT";
	
	/** 세금 계산서 상태 코드 : 접수 */
	public static final String TAX_IVC_STAT_01 = "01";
	/** 세금 계산서 상태 코드 : 승인 */
	public static final String TAX_IVC_STAT_02 = "02";
	/** 세금 계산서 상태 코드 : 에러 */
	public static final String TAX_IVC_STAT_03 = "03";
	/** 세금 계산서 상태 코드 : 취소 */
	public static final String TAX_IVC_STAT_04 = "04";
	/** 세금 계산서 상태 코드 : 취소예정 */
	public static final String TAX_IVC_STAT_05 = "05";
	
	
	/** 클레임 유형 코드 */
	public static final String CLM_TP = "CLM_TP";
	
	/** 클레임 유형 코드 : 주문취소 */
	public static final String CLM_TP_10 = "10";	
	/** 클레임 유형 코드 : 반품 */
	public static final String CLM_TP_20 = "20";
	/** 클레임 유형 코드 : 교환 */
	public static final String CLM_TP_30 = "30";
	
	
	/** 클레임 상세 유형 코드 */
	public static final String CLM_DTL_TP = "CLM_DTL_TP";
	
	/** 클레임 상세 유형 코드 : 주문취소 */
	public static final String CLM_DTL_TP_10 = "10";
	/** 클레임 상세 유형 코드 : 반품 */
	public static final String CLM_DTL_TP_20 = "20";
	/** 클레임 상세 유형 코드 : 교환회수 */
	public static final String CLM_DTL_TP_30 = "30";
	/** 클레임 상세 유형 코드 : 교환배송 */
	public static final String CLM_DTL_TP_40 = "40";
	
	
	/** 클레임 상태 코드 */
	public static final String CLM_STAT = "CLM_STAT";
	
	/** 클레임 상태 코드 : 접수 */
	public static final String CLM_STAT_10 = "10";
	/** 클레임 상태 코드 : 진행 */
	public static final String CLM_STAT_20 = "20";
	/** 클레임 상태 코드 : 완료 */
	public static final String CLM_STAT_30 = "30";
	/** 클레임 상태 코드 : 취소 */
	public static final String CLM_STAT_40 = "40";

	
	/** 클레임 상세 상태 코드 */
	public static final String CLM_DTL_STAT = "CLM_DTL_STAT";
	
	/** 클레임 상세 상태 코드 : 취소대기 */
	public static final String CLM_DTL_STAT_110 = "110";
	/** 클레임 상세 상태 코드 : 취소완료 */
	public static final String CLM_DTL_STAT_120 = "120";
	/** 클레임 상세 상태 코드 : 반품접수 */
	public static final String CLM_DTL_STAT_210 = "210";
	/** 클레임 상세 상태 코드 : 반품회수지시 */
	public static final String CLM_DTL_STAT_220 = "220";
	/** 클레임 상세 상태 코드 : 반품회수중 */
	public static final String CLM_DTL_STAT_230 = "230";
	/** 클레임 상세 상태 코드 : 반품회수완료 */
	public static final String CLM_DTL_STAT_240 = "240";
	/** 클레임 상세 상태 코드 : 반품거부완료 */
	public static final String CLM_DTL_STAT_250 = "250";
	/** 클레임 상세 상태 코드 : 반품승인완료 */
	public static final String CLM_DTL_STAT_260 = "260";
	/** 클레임 상세 상태 코드 : 교환회수접수 */
	public static final String CLM_DTL_STAT_310 = "310";
	/** 클레임 상세 상태 코드 : 교환회수지시 */
	public static final String CLM_DTL_STAT_320 = "320";
	/** 클레임 상세 상태 코드 : 교환회수중 */
	public static final String CLM_DTL_STAT_330 = "330";
	/** 클레임 상세 상태 코드 : 교환회수완료 */
	public static final String CLM_DTL_STAT_340 = "340";
	/** 클레임 상세 상태 코드 : 교환거부완료 */
	public static final String CLM_DTL_STAT_350 = "350";
	/** 클레임 상세 상태 코드 : 교환승인완료 */
	public static final String CLM_DTL_STAT_360 = "360";
	/** 클레임 상세 상태 코드 : 교환배송접수 */
	public static final String CLM_DTL_STAT_410 = "410";
	/** 클레임 상세 상태 코드 : 교환배송지시 */
	public static final String CLM_DTL_STAT_420 = "420";
	/** 클레임 상세 상태 코드 : 교환상품준비중 */
	public static final String CLM_DTL_STAT_430 = "430";
	/** 클레임 상세 상태 코드 : 교환배송중 */
	public static final String CLM_DTL_STAT_440 = "440";
	/** 클레임 상세 상태 코드 : 교환배송완료 */
	public static final String CLM_DTL_STAT_450 = "450";
	
	/** 클레임 상세 상태 코드 네임 : DB CODE DTL_NM이랑 SB문구 안맞는 부분 정의.*/
	
	/** 클레임 상세 상태 코드네임 : 반품신청 */
	public static final String CLM_DTL_STAT_210_NM = "반품신청";
	
	/** 클레임 상세 상태 코드네임 : 교환신청 */
	public static final String CLM_DTL_STAT_310_NM = "교환신청";
	
	/** 클레임 상세 상태 코드네임 : 반품거부 */
	public static final String CLM_DTL_STAT_250_NM = "반품거부";
	
	/** 클레임 상세 상태 코드네임 : 교환거부 */
	public static final String CLM_DTL_STAT_350_NM = "교환거부";
	
	/** 클레임 상세 상태 코드네임 : 교환진행중 : 420~440번 상태 값 표기 용*/
	public static final String CLM_DTL_STAT_EXC_ING_NM = "교환진행중";
	
	/** 클레임 상세 상태 코드네임 : 교환완료 : 450번 상태 값 표기 용 */
	public static final String CLM_DTL_STAT_CPLT_NM = "교환완료";
	
	/** 클레임 사유 코드 */
	public static final String CLM_RSN = "CLM_RSN";
	
	/** 클레임 사유 코드 : 단순변심 */
	public static final String CLM_RSN_110 = "110";
	/** 클레임 사유 코드 : 주문실수 */
	public static final String CLM_RSN_120 = "120";
	/** 클레임 사유 코드 : 배송지연 */
	public static final String CLM_RSN_130 = "130";
	/** 클레임 사유 코드 : 컨텐츠 상이/변경 */
	public static final String CLM_RSN_140 = "140";
	/** 클레임 사유 코드 : 가격/프로모션 변동 */
	public static final String CLM_RSN_150 = "150";
	/** 클레임 사유 코드 : 상품품절 */
	public static final String CLM_RSN_160 = "160";
	/** 클레임 사유 코드 : 가상계좌/무통장 미입금 자동 취소 */
	public static final String CLM_RSN_190 = "190";
	/** 클레임 사유 코드 : 단순변심 */
	public static final String CLM_RSN_210 = "210";
	/** 클레임 사유 코드 : 구성품 누락 */
	public static final String CLM_RSN_220 = "220";
	/** 클레임 사유 코드 : 파손 및 불량 */
	public static final String CLM_RSN_230 = "230";
	/** 클레임 사유 코드 : 제품하자 */
	public static final String CLM_RSN_240 = "240";
	/** 클레임 사유 코드 : 오배송 및 지연 */
	public static final String CLM_RSN_250 = "250";
	/** 클레임 사유 코드 : 출고지연 */
	public static final String CLM_RSN_260 = "260";
	/** 클레임 사유 코드 : 재고부족 */
	public static final String CLM_RSN_270 = "270";
	/** 클레임 사유 코드 : 주문실수 */
	public static final String CLM_RSN_280 = "280";
	/** 클레임 사유 코드 : 단순변심 */
	public static final String CLM_RSN_310 = "310";
	/** 클레임 사유 코드 : 사이즈/색상 변경 */
	public static final String CLM_RSN_320 = "320";
	/** 클레임 사유 코드 : 상품 누락 */
	public static final String CLM_RSN_330 = "330";
	/** 클레임 사유 코드 : 배송중 파손 */
	public static final String CLM_RSN_340 = "340";
	/** 클레임 사유 코드 : 제품하자 */
	public static final String CLM_RSN_350 = "350";
	/** 클레임 사유 코드 : 오배송 */
	public static final String CLM_RSN_360 = "360";
	/** 클레임 사유 코드 : 배송비 동봉 */
	public static final String CLM_RSN_370 = "370";				
	
	
	/** 귀책 사유 코드 */
	public static final String RSP_RSN = "RSP_RSN";
	
	/** 귀책 사유 코드 : 고객 */
	public static final String RSP_RSN_10 = "10";
	/** 귀책 사유 코드 : 업체 */
	public static final String RSP_RSN_20 = "20";
	
	
	/** 환불 유형 코드 */
	public static final String RFD_TP = "RFD_TP";
	
	/** 환불 유형 코드 : 주문취소환불 */
	public static final String RFD_TP_10 = "10";
	/** 환불 유형 코드 : 반품환불 */
	public static final String RFD_TP_20 = "20";
	
	
	/** 환불 상태 코드 */
	public static final String RFD_STAT = "RFD_STAT";
	
	/** 환불 상태 코드 : 접수 */
	public static final String RFD_STAT_10 = "10";
	/** 환불 상태 코드 : 진행 */
	public static final String RFD_STAT_20 = "20";
	/** 환불 상태 코드 : 완료 */
	public static final String RFD_STAT_30 = "30";
	/** 환불 상태 코드 : 취소 */
	public static final String RFD_STAT_40 = "40";

	/** 고정 계좌 */
	public static final String FIX_ACCT = "FIX_ACCT";
	
	
	/** 정산 지급 구분 코드 */
	public static final String ADJT_PAY_TP = "ADJT_PAY_TP";
	
	/** 정산 지급 구분 코드 : 지급 */
	public static final String ADJT_PAY_TP_1 = "1";
	/** 정산 지급 구분 코드 : 보류 */
	public static final String ADJT_PAY_TP_2 = "2";

	
	/** 업체 정산 주기 코드 */
	public static final String CCL_TERM = "CCL_TERM";
	/** 업체 정산 주기 코드 : 월 1회 */
	public static final String CCL_TERM_10 = "10";
	/** 업체 정산 주기 코드 : 월 2회 */
	public static final String CCL_TERM_20 = "20";
	/** 업체 정산 주기 코드 : 월 3회 */
	public static final String CCL_TERM_30 = "30";


	/** 정산 유형 코드 */
	public static final String CCL_TP = "CCL_TP";
	
	/** 정산 유형 코드 : 고정 수수료 */
	public static final String CCL_TP_10 = "10";	
	/** 정산 유형 코드 : 매출 구간별 수수료 */
	public static final String CCL_TP_20 = "20";	
	
	
	/** 정산 지급 상태 코드 */
	public static final String PVD_STAT = "PVD_STAT";
	
	/** 정산 지급 구분 코드 : 미지급 */
	public static final String PVD_STAT_10 = "10";
	/** 정산 지급 구분 코드 : 지급 */
	public static final String PVD_STAT_20 = "20";
	/** 정산 지급 구분 코드 : 보류 */
	public static final String PVD_STAT_30 = "30";

	
	/** 정산 주기 */
	public static final String STL_ORDER = "STL_ORDER";
	
	/** 정산 주기 : 1차 */
	public static final String STL_ORDER_1 = "1";
	/** 정산 주기 : 2차 */
	public static final String STL_ORDER_2 = "2";
	
	
	
	/** 정산 주문 유형 코드 */
	public static final String STL_ORD_TP = "STL_ORD_TP";
	
	/** 정산 주문 유형 코드 : 주문 */
	public static final String STL_ORD_TP_10 = "10";
	/** 정산 주문 유형 코드 : 반품 */
	public static final String STL_ORD_TP_20 = "20";
	/** 정산 주문 유형 코드 : 교환 */
	public static final String STL_ORD_TP_30 = "30";			

	
	/** 정산 상태 코드 */
	public static final String STL_STAT = "STL_STAT";
	/** 정산 상태 코드 : 대기 */
	public static final String STL_STAT_10 = "10";
	/** 정산 상태 코드 : 완료 */
	public static final String STL_STAT_20 = "20";
	
	/** 주문목록 정산 상태 코드 */
	public static final String ORD_LST_STL_STT = "ORD_LST_STL_STT";
	/** 주문목록 정산 상태 코드 : 정산 대기 */
	public static final String ORD_LST_STL_STT_10 = "10";
	/** 주문목록 정산 상태 코드 : 정산 완료 */
	public static final String ORD_LST_STL_STT_20 = "20";
	
	
	/****************************
	 * CS
	 ****************************/
	
	/** 상담 경로 코드 */
	public static final String CUS_PATH = "CUS_PATH";
	
	/** 상담 경로 코드 : WEB */
	public static final String CUS_PATH_10 = "10";
	/** 상담 경로 코드 : Call Center */
	public static final String CUS_PATH_20 = "20";
	
	
	/** 상담 상태 코드 */
	public static final String CUS_STAT = "CUS_STAT";
	
	/** 상담 상태 코드 : 답변대기 */
	public static final String CUS_STAT_10 = "10";
	/** 상담 상태 코드 : 답변완료 */
	public static final String CUS_STAT_20 = "20";
	
	
	/** 상담 유형 코드 */
	public static final String CUS_TP = "CUS_TP";
	
	/** 상담 유형 코드 : Inbound */
	public static final String CUS_TP_10 = "10";	
	/** 상담 유형 코드 : Outbound */
	public static final String CUS_TP_20 = "20";	
	/** 상담 유형 코드 : 수동등록 */
	public static final String CUS_TP_30 = "30";				
	
	
	/** 통화자 구분 코드 */
	public static final String CALL_GB = "CALL_GB";
	/** 통화자 구분 코드 : 고객 */
	public static final String CALL_GB_10 = "10";				
	/** 통화자 구분 코드 : 제3자 */
	public static final String CALL_GB_20 = "20";				
	/** 통화자 구분 코드 : 가족 */
	public static final String CALL_GB_30 = "30";				
	/** 통화자 구분 코드 : 지인 */
	public static final String CALL_GB_40 = "40";				
	/** 통화자 구분 코드 : 택배사 */
	public static final String CALL_GB_50 = "50";				
	/** 통화자 구분 코드 : 업체 */
	public static final String CALL_GB_60 = "60";				
	/** 통화자 구분 코드 : 본사 */
	public static final String CALL_GB_70 = "70";				
	/** 통화자 구분 코드 : 기타 */
	public static final String CALL_GB_80 = "80";				
	
	
	/** 응대 구분 코드 */
	public static final String RESP_GB = "RESP_GB";
	/** 응대 구분 코드 : 성공 */
	public static final String RESP_GB_10 = "10";				
	/** 응대 구분 코드 : 부재 */
	public static final String RESP_GB_20 = "20";				
	/** 응대 구분 코드 : 통화중끊김 */
	public static final String RESP_GB_30 = "30";				
	/** 응대 구분 코드 : 호전환 */
	public static final String RESP_GB_40 = "40";				
	
	
	/** 상담대분류 */
	public static final String CUS_CTG1 = "CUS_CTG1";
	/** 상담대분류 : 회원/정보관리 */
	public static final String CUS_CTG1_10 = "10";				
	/** 상담대분류 : 주문/결제 */
	public static final String CUS_CTG1_20 = "20";				
	/** 상담대분류 : 배송 */
	public static final String CUS_CTG1_30 = "30";				
	/** 상담대분류 : 반품/환불/교환/AS */
	public static final String CUS_CTG1_40 = "40";				
	/** 상담대분류 : 영수증/증빙서류 */
	public static final String CUS_CTG1_50 = "50";				
	/** 상담대분류 : 상품/이벤트 */
	public static final String CUS_CTG1_60 = "60";				
	/** 상담대분류 : 기타 */
	public static final String CUS_CTG1_70 = "70";				
	/** 상담대분류 : 수의사 상담 */
	public static final String CUS_CTG1_80 = "80";				
	
	
	/** 상담중분류 */
	public static final String CUS_CTG2 = "CUS_CTG2";


	/** 상담소분류 */
	public static final String CUS_CTG3 = "CUS_CTG3";

	
	/** 상담 회신 코드 */
	public static final String CUS_RPL = "CUS_RPL";
	/** 상담 회신 코드 : SMS */
	public static final String CUS_RPL_10 = "10";				
	/** 상담 회신 코드 : 이메일 */
	public static final String CUS_RPL_20 = "20";				


	/** 머리말/맺음말 유형 */
	public static final String REPLY_TYPE_TP = "REPLY_TYPE_TP";
	/** 머리말/맺음말 유형1 */
	public static final String REPLY_TYPE_TP_10 = "10";			
	/** 머리말/맺음말 유형2 */
	public static final String REPLY_TYPE_TP_20 = "20";			
	/** 머리말/맺음말 유형3 */
	public static final String REPLY_TYPE_TP_30 = "30";			
	
	
	/****************************
	 * 컨텐츠
	 ****************************/
	
	/** 컨텐츠 상태 코드 */
	public static final String CONTS_STAT = "CONTS_STAT";
	/** 노출 */
	public static final String CONTS_STAT_10 = "10";			
	/** 미노출 */
	public static final String CONTS_STAT_20 = "20";			
	/** 신고 차단 */
	public static final String CONTS_STAT_30 = "30";			
	
	/** 관심 구분 코드 */	
	public static final String INTR_GB = "INTR_GB";
	/** 좋아요 */
	public static final String INTR_GB_10 = "10";			
	/** 찜 */
	public static final String INTR_GB_20 = "20";			
	
	/** Apet 타입 코드 */	
	public static final String APET_TP = "APET_TP";
	/** SBS 영상 */
	public static final String APET_TP_10 = "10";			
	/** 오리지널 */
	public static final String APET_TP_20 = "20";			
	/** 펫 뉴스 */
	public static final String APET_TP_30 = "30";			
	
	/** 공유 채널 코드 */	
	public static final String SHR_CHNL = "SHR_CHNL";
	/** 카카오 */
	public static final String SHR_CHNL_10 = "10";			
	/** 네이버 */
	public static final String SHR_CHNL_20 = "20";			
	/** 구글 */
	public static final String SHR_CHNL_30 = "30";			
	/** 애플 */
	public static final String SHR_CHNL_40 = "40";

	/** 난이도 코드 */	
	public static final String APET_LOD = "APET_LOD";
	/** 쉬움 */
	public static final String APET_LOD_10 = "10";			
	/** 보통 */
	public static final String APET_LOD_20 = "20";			
	/** 어려움 */
	public static final String APET_LOD_30 = "30";			
	
	/** 영상 타입 코드 */	
	public static final String VD_TP = "VD_TP";	
	/** 일반 */
	public static final String VD_TP_10 = "10";
	/** V-커머스 */
	public static final String VD_TP_20 = "20";
	
	/** 영상 구분 코드 */	
	public static final String VD_GB = "VD_GB";	
	/** 교육 */
	public static final String VD_GB_10 = "10";
	/** 기타 */
	public static final String VD_GB_20 = "20";
	
	/** 영상 구분 코드 */	
	public static final String VOD_SORT_ORDER = "VOD_SORT_ORDER";
	/** 최근 등록 순 */
	public static final String VOD_SORT_ORDER_10 = "sysRegDtm";
	/** 조회수 높은 순 */
	public static final String VOD_SORT_ORDER_20 = "hits";
	/** 좋아요 높은 순 */
	public static final String VOD_SORT_ORDER_30 = "likeCnt";
	
	/** 구성 구분 코드 */
	public static final String CSTRT_GB = "CSTRT_GB";
	/** Tip */
	public static final String CSTRT_GB_10 = "10";
	/** QnA */
	public static final String CSTRT_GB_20 = "20";
	
	/** 시리즈 여부 */
	public static final String SERIES_YN = "SERIES_YN";
	/** 시리즈 */
	public static final String SERIES_YN_Y = "Y";			
	/** 단편 */
	public static final String SERIES_YN_N = "N";			
	
	/** 전시 상태 */
	public static final String DISP_STAT = "DISP_STAT";
	/** 전시 */
	public static final String DISP_STAT_Y = "Y";			
	/** 숨김 */
	public static final String DISP_STAT_N = "N";			
	
	/** 교육용 컨텐츠 카테고리_L_코드 */
	public static final String EUD_CONTS_CTG_L = "EUD_CONTS_CTG_L";
	/** 교육 */
	public static final String EUD_CONTS_CTG_L_10 = "10";			
	/** 교육  Intro */
	public static final String EUD_CONTS_CTG_L_20 = "20";			
	
	/** 교육용 컨텐츠 카테고리_M_코드 */
	public static final String EUD_CONTS_CTG_M = "EUD_CONTS_CTG_M";
	/** 기초 */
	public static final String EUD_CONTS_CTG_M_10 = "10";			
	/** 사회화 */
	public static final String EUD_CONTS_CTG_M_20 = "20";			
	/** 놀이 */
	public static final String EUD_CONTS_CTG_M_30 = "30";			
	/** 케어 */
	public static final String EUD_CONTS_CTG_M_40 = "40";			
	/** 기본행동 */
	public static final String EUD_CONTS_CTG_M_50 = "50";
	/** 습관화 */
	public static final String EUD_CONTS_CTG_M_60 = "60";
	
	/** 교육용 컨텐츠 카테고리_S_코드 */
	public static final String EUD_CONTS_CTG_S = "EUD_CONTS_CTG_S";
	/** 실내 */
	public static final String EUD_CONTS_CTG_S_10 = "10";			
	/** 실외 */
	public static final String EUD_CONTS_CTG_S_20 = "20";			
	
	/** 준비물 코드 */
	public static final String PRPM = "PRPM";
	/** 준비물 코드 : 간식 */
	public static final String PRPM_10 = "10";
	/** 준비물 코드 : 간식 2개 */
	public static final String PRPM_20 = "20";
	/** 준비물 코드 : 귀세정제 */
	public static final String PRPM_30 = "30";
	/** 준비물 코드 : 눈세정제 */
	public static final String PRPM_40 = "40";
	/** 준비물 코드 : 매트 */
	public static final String PRPM_50 = "50";
	/** 준비물 코드 : 발톱깎이 */
	public static final String PRPM_60 = "60";
	/** 준비물 코드 : 배변패드 */
	public static final String PRPM_70 = "70";
	/** 준비물 코드 : 빗 */
	public static final String PRPM_80 = "80";
	/** 준비물 코드 : 산책줄 */
	public static final String PRPM_90 = "90";
	/** 준비물 코드 : 울타리 */
	public static final String PRPM_100 = "100";
	/** 준비물 코드 : 입마개 */
	public static final String PRPM_110 = "110";
	/** 준비물 코드 : 장난감 */
	public static final String PRPM_120 = "120";
	/** 준비물 코드 : 종 */
	public static final String PRPM_130 = "130";
	/** 준비물 코드 : 종이컵 */
	public static final String PRPM_140 = "140";
	/** 준비물 코드 : 칫솔 */
	public static final String PRPM_150 = "150";
	/** 준비물 코드 : 켄넬 */
	public static final String PRPM_160 = "160";
	/** 준비물 코드 : 콩토이 */
	public static final String PRPM_170 = "170";
	/** 준비물 코드 : 클리커 */
	public static final String PRPM_180 = "180";
	/** 준비물 코드 : 터그 */
	public static final String PRPM_190 = "190";
	
	
	/** 썸네일 추출 방식 코드 */	
	public static final String THUM_AUTO_YN = "THUM_AUTO_YN";	
	/** 썸네일 추출 방식 코드 : 자동추출 */
	public static final String THUM_AUTO_YN_Y = "Y";
	/** 썸네일 추출 방식 코드 : 수동등록 */
	public static final String THUM_AUTO_YN_N = "N";
	
	/** 펫스쿨따라잡기인기영상 */
	public static final String PETSCHOOL_PETLOG = "PETSCHOOL_PETLOG";
	/** 인기영상펫로그번호 */
	public static final String PETSCHOOL_PETLOG_10 = "10";

	 /****************************
	 * APP/Web
	  ****************************/

	/** 배너 모바일 이미지 코드*/
	public static final String BNR_MO_IMG_GB = "BNR_MO_IMG_GB";
	/** 배너 모바일 이미지 코드 : 이미지 등록*/
	public static final String BNR_MO_IMG_GB_10 = "10";				
	/** 배너 모바일 이미지 코드 : img url 등록*/
	public static final String BNR_MO_IMG_GB_20 = "20";				

	/** 배너 이미지 코드*/
	public static final String BNR_IMG_GB = "BNR_IMG_GB";
	/** 배너 이미지 코드 : 이미지 등록*/
	public static final String BNR_IMG_GB_10 = "10";				
	/** 배너 이미지 코드 : img url 등록*/
	public static final String BNR_IMG_GB_20 = "20";
	
	/** 배너 타입별 상세 코드*/
	public static final String BNR_TP_CD = "BNR_TP_CD";
	/** 배너 타입별 상세 코드 : 띠 배너*/
	public static final String BNR_TP_CD_10 = "10";				
	/** 배너 타입별 상세 코드 : 샵 메인,특별기획전*/
	public static final String BNR_TP_CD_20 = "20";
	/** 배너 타입별 상세 코드 : 샵 서브메인 기획전 및 상세*/
	public static final String BNR_TP_CD_30 = "30";
	/** 배너 타입별 상세 코드 : 이벤트*/
	public static final String BNR_TP_CD_40 = "40";
	/** 배너 타입별 상세 코드 : 샵 카테고리 메인*/
	public static final String BNR_TP_CD_50 = "50";
	/** 배너 타입별 상세 코드 : TV 상단*/
	public static final String BNR_TP_CD_60 = "60";
	/** 배너 타입별 상세 코드 : 펫스쿨 홈*/
	public static final String BNR_TP_CD_70 = "70";
	
	/** 알림 메시지 템플릿 변수 코드 */
	public static final String PUSH_TMPL_VRBL = "PUSH_TMPL_VRBL";
	/** ${login_id} / 고객 아이디 */
	public static final String PUSH_TMPL_VRBL_10 = "${login_id}";		
	/** ${mbr_nm} / 고객 명 */
	public static final String PUSH_TMPL_VRBL_20 = "${mbr_nm}";		
	/** ${mall_name} / 업체 명 */
	public static final String PUSH_TMPL_VRBL_30 = "${mall_name}";		
	/** ${order_no} / 주문번호 */
	public static final String PUSH_TMPL_VRBL_40 = "${order_no}";		
	/** ${order_date} / 주문일자 */
	public static final String PUSH_TMPL_VRBL_50 = "${order_date}";		
	/** ${goods_nm} / 주문상품 */
	public static final String PUSH_TMPL_VRBL_60 = "${goods_nm}";		
	/** ${ctf_email_no} / 회원 이메일 인증번호*/
	public static final String PUSH_TMPL_VRBL_70 = "${ctf_email_no}";
	/** ${nick_nm} / 회원 닉네임 */
	public static final String PUSH_TMPL_VRBL_80 = "${nick_nm}";
	/** ${coupon_nm} / 쿠폰 명 */
	public static final String PUSH_TMPL_VRBL_120 = "${coupon_nm}";
	/** ${my_coupon_link} / 내 쿠폰 경로 */
	public static final String PUSH_TMPL_VRBL_130 = "${my_coupon_url}";
	/** ${coupon_end_date} / 쿠폰 종료일(yyyy.MM.dd) */
	public static final String PUSH_TMPL_VRBL_140 = "${coupon_end_date}";
	/** ${yyyy_mm_dd} / 년월일(yyyy년 mm월 dd일) */
	public static final String PUSH_TMPL_VRBL_280 = "${yyyy_mm_dd}";
	/** ${coupon_date} / 쿠폰 종료일 디데이 */
	public static final String PUSH_TMPL_VRBL_290 = "${coupon_date}";
	/** ${goods_id} / 상품아이디 */
	public static final String PUSH_TMPL_VRBL_320 = "${goods_id}";

	public static final String PUSH_TMPL_VRBL_330 = "${yyyy}";
	public static final String PUSH_TMPL_VRBL_340 = "${mm}";
	public static final String PUSH_TMPL_VRBL_350 = "${dd}";
	
	public static final String PUSH_TMPL_VRBL_360 = "${petLogUrl}";
	/** ${goods_iqr_no} / 상품Q&A */
	public static final String PUSH_TMPL_VRBL_370 = "${goods_iqr_no}";
	/** ${cus_no} / 1:1문의 */
	public static final String PUSH_TMPL_VRBL_380 = "${cus_no}";


	/** ${coupon_date} / 쿠폰 종료일 디데이 */
	public static final String PUSH_TMPL_VRBL_300 = "${cs_tel_no}";
	
	/** ${ctf_key} / 인증 번호 */
	public static final String PUSH_TMPL_VRBL_301 = "${ctf_key}";

	public static final String BBS_INSERT = "10";
	public static final String BBS_UPDATE = "20";
	public static final String BBS_DELETE = "30";
	
	/** 카테고리 코드 */
	public static final String CTG = "CTG";
	/** 카테고리 코드 : 서비스 */
	public static final String CTG_10 = "10";
	/** 카테고리 코드 : 장애 */
	public static final String CTG_20 = "20";
	/** 카테고리 코드 : 회원 */
	public static final String CTG_30 = "30";
	/** 카테고리 코드 : 주문 */
	public static final String CTG_40 = "40";
	/** 카테고리 코드 : 이벤트 */
	public static final String CTG_50 = "50";
	/** 카테고리 코드 : 펫TV */
	public static final String CTG_60 = "60";
	/** 카테고리 코드 : 펫로그 */
	public static final String CTG_70 = "70";
	/** 카테고리 코드 : 펫샵 */
	public static final String CTG_80 = "80";
	/** 카테고리 코드 : 공통 */
	public static final String CTG_90 = "90";
	/** 카테고리 코드 : 라이브 */
	public static final String CTG_100 = "100";
	
	
	/** 전송 방식 코드 */
	public static final String SND_TYPE = "SND_TYPE";
	/** 전송 방식 코드 : APP PUSH */
	public static final String SND_TYPE_10 = "10";
	/** 전송 방식 코드 : 문자(MMS/LMS/SMS) */
	public static final String SND_TYPE_20 = "20";
	/** 전송 방식 코드 : 알림톡 */
	public static final String SND_TYPE_30 = "30";
	/** 전송 방식 코드 : EMAIL */
	public static final String SND_TYPE_40 = "40";
	
	/** 발송 방식 코드 */
	public static final String NOTICE_TYPE = "NOTICE_TYPE";
	/** 발송 방식 코드 : 즉시 */
	public static final String NOTICE_TYPE_10 = "10";
	/** 발송 방식 코드 : 예약 */
	public static final String NOTICE_TYPE_20 = "20";
	
	/** 정보 구분 코드 */
	public static final String INFO_TP_CD = "INFO_TP_CD";
	/** 정보 구분 코드 : 정보성 */
	public static final String INFO_TP_CD_10 = "10";
	/** 정보 구분 코드 : 광고성 */
	public static final String INFO_TP_CD_20 = "20";
	
	/** 디바이스 구분 */
	public static final String DEVICE_GB = "DEVICE_GB";
	/** 디바이스 구분 : PC */
	public static final String DEVICE_GB_10 = "PC";
	/** 디바이스 구분 : MO */
	public static final String DEVICE_GB_20 = "MO";
	/** 디바이스 구분 : APP */
	public static final String DEVICE_GB_30 = "APP";
	
	/** 디바이스 종류 코드 */
	public static final String DEVICE_TYPE = "DEVICE_TYPE";
	/** 디바이스 종류 코드 : ANDROID */
	public static final String DEVICE_TYPE_10 = "10";
	/** 디바이스 종류 코드 : IOS */
	public static final String DEVICE_TYPE_20 = "20";
	/** 디바이스 종류 코드 : ALL */
	public static final String DEVICE_TYPE_30 = "30";
	
	/** 요청 결과 코드 */
	public static final String REQ_RST = "REQ_RST";
	/** 요청 결과 코드 : 성공 */
	public static final String REQ_RST_S = "S";
	/** 요청 결과 코드 : 실패 */
	public static final String REQ_RST_F = "F";
	
	/** 발송 결과 코드 */
	public static final String SND_RST = "SND_RST";
	/** 발송 결과 코드 : 성공 */
	public static final String SND_RST_S = "S";
	/** 발송 결과 코드 : 실패 */
	public static final String SND_RST_F = "F";
	
	/** 시스템 사용 여부 */
	public static final String SYS_USE_YN = "SYS_USE_YN";
	/** 시스템 사용 여부 : 사용 */
	public static final String SYS_USE_YN_Y = "Y";
	/** 시스템 사용 여부 : 사용 안 함 */
	public static final String SYS_USE_YN_N = "N";

	/** 카카오 버튼 타입 */
	public static final String KKO_BTN_TP = "KKO_BTN_TP";
	/** 카카오 버튼 타입 : WL */
	public static final String KKO_BTN_TP_WL = "WL";
	/** 카카오 버튼 타입 : AL */
	public static final String KKO_BTN_TP_AL = "AL";
	/** 카카오 버튼 타입 : DS */
	public static final String KKO_BTN_TP_DS = "DS";
	/** 카카오 버튼 타입 : BK */
	public static final String KKO_BTN_TP_BK = "BK";
	/** 카카오 버튼 타입 : MD */
	public static final String KKO_BTN_TP_MD = "MD";

	/****************************
	 * 통계
	 ****************************/
	
	/** 전시 상품 집계 구분 코드 */
	public static final String DISP_TOTAL_GB = "DISP_TOTAL_GB";
	/** 전시 상품 집계 구분 코드 : 전시 카테고리 */
	public static final String DISP_TOTAL_GB_10 = "10";			
	/** 전시 상품 집계 구분 코드 : 업체 카테고리 */
	public static final String DISP_TOTAL_GB_20 = "20";			
	/** 전시 상품 집계 구분 코드 : 브랜드 카테고리 */
	public static final String DISP_TOTAL_GB_30 = "30";			

	
	/** 회원 현황 구분 코드 */
	public static final String MBR_FLOW_GB = "MBR_FLOW_GB";
	/** 회원 현황 구분 코드 : 총 회원수 */
	public static final String MBR_FLOW_GB_10 = "10";			
	/** 회원 현황 구분 코드 : 신규 회원수 */
	public static final String MBR_FLOW_GB_20 = "20";			
	/** 회원 현황 구분 코드 : 이메일 수신 동의자 수 */
	public static final String MBR_FLOW_GB_30 = "30";			
	/** 회원 현황 구분 코드 : SMS 수신 동의자 수 */
	public static final String MBR_FLOW_GB_40 = "40";			
	/** 회원 현황 구분 코드 : 탈퇴 회원수 */
	public static final String MBR_FLOW_GB_50 = "50";			
	/** 회원 현황 구분 코드 : 휴면 계정 전환자수 */
	public static final String MBR_FLOW_GB_60 = "60";			
	
	
	/** 집계 구분 코드 */
	public static final String SUM_GB = "SUM_GB";
	/** 집계 구분 코드 : 전체 */
	public static final String SUM_GB_10 = "10";				
	/** 집계 구분 코드 : 대분류 */
	public static final String SUM_GB_20 = "20";				
	/** 집계 구분 코드 : 중분류 */
	public static final String SUM_GB_30 = "30";				
	/** 집계 구분 코드 : 소분류 */
	public static final String SUM_GB_40 = "40";				
	
	
	/** 집계 구분 코드 */
	public static final String TOTAL_GB = "TOTAL_GB";
	/** 집계 구분 코드 : 일별 */
	public static final String TOTAL_GB_10 = "10";				
	/** 집계 구분 코드 : 주간 */
	public static final String TOTAL_GB_20 = "20";				
	/** 집계 구분 코드 : 월별 */
	public static final String TOTAL_GB_30 = "30";				

	
	/****************************
	 * APP
	 ****************************/
	
	/** Splash 등록 상태 */
	public static final String APP_SPLASH_STATUS = "APP_SPLASH_STATUS";
	/** Splash 등록 상태 : 준비 */
	public static final String APP_SPLASH_STATUS_0 = "0";		
	/** Splash 등록 상태 : 사용중 */
	public static final String APP_SPLASH_STATUS_1 = "1";
	/** Splash 등록 상태 : 중지 */
	public static final String APP_SPLASH_STATUS_2 = "2";		
	

	/** Splash 링크 형식 */
	public static final String APP_SPLASH_TP = "APP_SPLASH_TP";
	/** Splash 링크 형식 : Image */
	public static final String APP_SPLASH_TP_I = "I";			
	/** Splash 링크 형식 : Link URL */
	public static final String APP_SPLASH_TP_L = "L";			
	
	
	/** APP 필수 업데이트 여부 */
	public static final String APP_UPDATE_YN = "APP_UPDATE_YN";
	/** APP 필수 업데이트 여부 : Major */
	public static final String APP_UPDATE_YN_Y = "Y";			
	/** APP 필수 업데이트 여부 : Minor */
	public static final String APP_UPDATE_YN_N = "N";			
	
	
	/** 모바일 OS 구분 */
	public static final String MOBILE_OS_GB = "MOBILE_OS_GB";
	/** 모바일 OS 구분 : 아이폰 */
	public static final String MOBILE_OS_GB_I = "I";			
	/** 모바일 OS 구분 : 안드로이드 */
	public static final String MOBILE_OS_GB_A = "A";			
	

	//======================================================================================================
	//== Sequence
	//======================================================================================================

		
	/****************************
	 * Common
	 ****************************/
	
	/** 사용자 기준 번호 */
	public static final Integer SEQUENCE_USR_DEFAULT_SEQ = 900000000;		
	
	/** 사용자, 관리자 일련번호 */
	public static final String SEQUENCE_USER_BASE_SEQ = "USER_BASE_SEQ";
	
	/** 사용자 권한 이력 일련번호 */
	public static final String SEQUENCE_USER_AUTH_HIST_SEQ = "USER_AUTH_HIST_SEQ";
	
	/** 사이트 ID */
	public static final String SEQUENCE_ST_STD_INFO_SEQ = "ST_STD_INFO_SEQ";
	
	/** 메뉴 일련번호 */
	public static final String SEQUENCE_MENU_BASE_SEQ = "MENU_BASE_SEQ";
	
	/** 메뉴 기능 일련번호 */
	public static final String SEQUENCE_MENU_ACTION_SEQ = "MENU_ACTION_SEQ";
	
	/** 권한 일련번호 */
	public static final String SEQUENCE_AUTHORITY_SEQ = "AUTHORITY_SEQ";
	
	/** 사이트 정책 순번 */
	public static final String SEQUENCE_ST_POLICY_SEQ = "ST_POLICY_SEQ";
	
	/** 채널 ID */
	public static final String SEQUENCE_CHNL_STD_INFO_SEQ = "CHNL_STD_INFO_SEQ";
	
	/** 처리 방침 번호 */
	public static final String SEQUENCE_PRIVACY_POLICY_SEQ = "PRIVACY_POLICY_SEQ";
	
	/** 무통장 계좌정보 */
	public static final String SEQUENCE_DEPOSIT_ACCT_INFO_SEQ = "DEPOSIT_ACCT_INFO_SEQ";
	
	/** 우편번호 순번 */
	public static final String SEQUENCE_ZIPCODE_SEQ = "ZIPCODE_SEQ";
	
	/** 쪽지수신자 목록 */
	public static final String SEQUENCE_NOTE_RCVR_LIST_SEQ = "NOTE_RCVR_LIST_SEQ";
	
	/** API 허용 IP */
	public static final String SEQUENCE_API_PERMIT_IP = "API_PERMIT_IP_SEQ";
	
	/** 파일 번호 */
	public static final String SEQUENCE_ATTACH_FILE_SEQ = "ATTACH_FILE_SEQ";
	
	/** 게시판 */
	public static final String SEQUENCE_BBS_GB_SEQ = "BBS_GB_SEQ";
	public static final String SEQUENCE_BBS_LETTER_SEQ = "BBS_LETTER_SEQ";
	public static final String SEQUENCE_COMPANY_NOTICE_SEQ = "COMPANY_NOTICE_SEQ";
	public static final String SEQUENCE_COMPANY_POLICY_SEQ = "COMPANY_POLICY_SEQ";
	public static final String SEQUENCE_BBS_LETT_HIST_SEQ = "BBS_LETT_HIST_SEQ";
	
	/** 이메일 전송 이력 번호 */
	public static final String SEQUENCE_EMAIL_SEND_HIST_NO = "EMAIL_SEND_HIST_NO";

	/*개인 정보 접속 조회 내역 */
	public static final String SEQUENCE_PRIVACY_CNCT_INQUIRY_SEQ = "PRIVACY_CNCT_INQUIRY_SEQ";
	
	/** 시리즈 순번 */
	public static final String SEQUENCE_APET_CONTENTS_SERIES_SEQ = "APET_CONTENTS_SERIES_SEQ";
	
	/** 영상  파일 번호 */
	public static final String SEQUENCE_APET_ATTATCH_FILE_SEQ = "APET_ATTATCH_FILE_SEQ";
	
	/** 알림 메시지 발송 이력 통지 번호 */
	public static final String SEQUENCE_NOTICE_SEND_LIST_SEQ = "NOTICE_SEND_LIST_SEQ";
	
	/** 알림 메시지 템플릿 번호 */
	public static final String SEQUENCE_NOTICE_TMPL_INFO_SEQ = "NOTICE_TMPL_INFO_SEQ";

	/** CIS IF LOG 번호 */
	public static final String SEQUENCE_CIS_IF_LOG_NO = "CIS_IF_LOG_SEQ";

	/** 회원 입고알림 번호 */
	public static final String SEQUENCE_IO_ALARM_SEQ = "IO_ALARM_SEQ";

	/** GSR API 호출 이력 시퀀스 */
	public static final String SEQUENCE_GSR_LNK_HIST_SEQ = "GSR_LNK_HIST_SEQ";

	/** 빌링 SEQ */
	public static final String SEQUENCE_PRSN_CARD_BILLING_INFO_SEQ = "PRSN_CARD_BILLING_INFO_SEQ";
	
	/** 포인트 관리 SEQ */
	public static final String SEQUENCE_PNT_INFO_SEQ = "PNT_INFO_SEQ";
	
	/** 이벤트팝업 SEQ */
	public static final String SEQUENCE_EVTPOP_BASE_SEQ = "EVTPOP_BASE_SEQ";
	
	

	/** SKTMP API 호출 이력 시퀀스 */
	public static final String SEQUENCE_SKTMP_LNK_HIST_SEQ = "MP_LNK_HIST_SEQ";
	
	/** SKTMP 멤버십 정보 시퀀스 */
	public static final String SEQUENCE_SKTMP_CARD_INFO_SEQ = "MP_CARD_INFO_SEQ";
	
	/****************************
	 * 회원
	 ****************************/
	
	/** 회원 일련번호 */
	public static final String SEQUENCE_MEMBER_BASE_SEQ = "MEMBER_BASE_SEQ";
	
	/** 회원 배송지 번호 */
	public static final String SEQUENCE_MEMBER_ADDRESS_SEQ = "MEMBER_ADDRESS_SEQ";
	
	/** 회원 쿠폰 번호 */
	public static final String SEQUENCE_MEMBER_COUPON_SEQ = "MEMBER_COUPON_SEQ";
	
	/** 회원 업체 정보 */
	public static final String SEQUENCE_MEMBER_BIZ_INFO_SEQ = "MEMBER_BIZ_INFO_SEQ";

	/** 회원 약관 이력 번호*/
	public static final String SEQUENCE_TERMS_RCV_HISTORY_SEQ = "TERMS_RCV_HISTORY_SEQ";
	
	/** 회원 인증 로그 번호*/
	public static final String SEQUENCE_MEMBER_CERTIFIED_LOG_SEQ = "MEMBER_CERTIFIED_LOG_SEQ";

	/** 회원 마케팅 수신 여부 이력 번호 */
	public static final String SEQUENCE_MEMBER_MARKETING_AGREE_HISTORY_SEQ = "MEMBER_MARKETING_AGREE_HISTORY_SEQ";


	/****************************
	 * 업체
	 ****************************/
	
	/** 공급업체 일련번호 */
	public static final String SEQUENCE_COMPANY_BASE_SEQ = "COMPANY_BASE_SEQ";
	
	/** 공급업체 배송 정책 일련번호 */
	public static final String SEQUENCE_DELIVERY_CHARGE_POLICY_SEQ = "DELIVERY_CHARGE_POLICY_SEQ";

	/** 공급업체 정산 일련번호 */
	public static final String SEQUENCE_COMPANY_CCL_SEQ = "COMPANY_CCL_SEQ";
	
	/** 업체 이력테이블 일련번호 */
	public static final String SEQUENCE_COMPANY_BASE_HIST_SEQ = "COMPANY_BASE_HIST_SEQ";
	
	/** 업체 담당자 일련번호 */
	public static final String SEQUENCE_COMPANY_CHRG_SEQ = "COMPANY_CHRG_SEQ";
	
	/** 입점 번호 */
	public static final String SEQUENCE_SHOP_ENTER_SEQ = "SHOP_ENTER_SEQ";
	
	/** 업체 계좌 번호 */
	public static final String COMP_ACCT_SEQ = "COMP_ACCT_SEQ";
	
	/** 업체 계좌 히스토리 번호 */
	public static final String COMP_ACCT_SEQ_HIST = "COMP_ACCT_SEQ_HIST";
	
	
	/****************************
	 * 전시
	 ****************************/
	
	/** 전시 템플릿 번호 */
	public static final String SEQUENCE_DISPLAY_TEMPLATE_SEQ = "DISPLAY_TEMPLATE_SEQ";
	
	/** 전시 분류 번호 */
	public static final String SEQUENCE_DISPLAY_CATEGORY_SEQ = "DISPLAY_CATEGORY_SEQ";
	
	/** 전시 코너 번호 */
	public static final String SEQUENCE_DISPLAY_CORNER_SEQ = "DISPLAY_CORNER_SEQ";
	
	/** 전시 코너 분류 번호 MYSQL */
	public static final String SEQUENCE_DISP_CLSF_CORN_SEQ = "DISP_CLSF_CORN_SEQ";

	/** 전시 코너 분류 번호 ORACLE*/
	public static final String SEQUENCE_DISP_CLSF_CORNER_SEQ = "DISPLAY_CORNER_SEQ";
	
	/** 전시 배너 번호 MYSQL*/
	public static final String SEQUENCE_DISPLAY_BNR_SEQ = "DISPLAY_BNR_SEQ";

	/** 전시 배너 번호 ORACLE */
	public static final String SEQUENCE_DISPLAY_BANNER_SEQ = "DISPLAY_BANNER_SEQ";
	
	/** 전시 코너 아이템 번호 */
	public static final String SEQUENCE_DISPLAY_CORNER_ITEM_SEQ = "DISPLAY_CORNER_ITEM_SEQ";
	
	/** 팝업 번호 */
	public static final String SEQUENCE_POPUP_SEQ = "POPUP_SEQ";
	
	/** 브랜드 번호 */
	public static final String SEQUENCE_BRAND_BASE_SEQ = "BRAND_BASE_SEQ";
	
	/** 브랜드 콘텐츠 번호 */
	public static final String SEQUENCE_BRAND_CNTS_SEQ = "BRAND_CNTS_SEQ";
	
	/** 브랜드 콘텐츠 아이템 번호 */
	public static final String SEQUENCE_BRAND_CNTS_ITEM_SEQ = "BRAND_CNTS_ITEM_SEQ";

	/** SEO 정보번호 */
	public static final String SEQUENCE_SEO_INFO_NO_SEQ = "SEO_INFO_NO_SEQ";
	
	/** 전시 코너 아이템 태그 번호*/
	public static final String SEQUENCE_DISP_CORNER_ITEM_TAG_SEQ = "SEQUENCE_DISP_CORNER_ITEM_TAG_SEQ";

	/****************************
	 * APP/Web
	 ****************************/

	/** 배너 번호*/
	public static final String SEQUENCE_BANNER_SEQ = "SEQUENCE_BANNER_SEQ";
	
	/** 통합약관 번호 */
	public static final String SEQUENCE_TERMS_SEQ = "SEQUENCE_TERMS_SEQ";


	/****************************
	 * 상품
	 ****************************/
	
	/** 상품 번호 */
	public static final String SEQUENCE_GOODS_BASE_SEQ = "GOODS_BASE_SEQ";
	
	/** 상품 이력 번호 */
	public static final String SEQUENCE_GOODS_BASE_HIST_SEQ = "GOODS_BASE_HIST_SEQ";
	
	/** 단품 번호 */
	public static final String SEQUENCE_ITEM_SEQ = "ITEM_SEQ";

	/** 단품 이력 번호 */
	public static final String SEQUENCE_ITEM_HIST_SEQ = "ITEM_HIST_SEQ";
	
	/** 단품속성 번호 */
	public static final String SEQUENCE_ATTRIBUTE_SEQ = "ATTRIBUTE_SEQ";
	
	/** 속성값 번호 (속성별) */
	public static final String SEQUENCE_ATTR_VAL_NO_SEQ = "ATTR_VAL_NO_SEQ";
	
	/** 단품 옵션 이력 번호 */
	public static final String SEQUENCE_ITEM_ATTR_HIST_SEQ = "ITEM_ATTR_HIST_SEQ";
	
	/** 상품 이미지 이력 번호 */
	public static final String SEQUENCE_GOODS_IMG_CHG_HIST_SEQ = "GOODS_IMG_CHG_HIST_SEQ";
	
	/** 상품 상세 이력 번호 */
	public static final String SEQUENCE_GOODS_DESC_HIST_SEQ = "GOODS_DESC_HIST_SEQ";
	
	/** 상품 문의 번호 */
	public static final String SEQUENCE_GOODS_INQUIRY_SEQ = "GOODS_INQUIRY_SEQ";
	
	/**상품 문의 이미지 번호 */
	public static final String SEQUENCE_GOODS_IQR_IMG_SEQ = "GOODS_IQR_IMG_SEQ";

	/** 상품 코멘트 번호 */
	public static final String SEQUENCE_GOODS_COMMENT_SEQ = "GOODS_COMMENT_SEQ";

	/** 상품 코멘트 이미지 번호 */
	public static final String SEQUENCE_GOODS_COMMENT_IMAGE_SEQ = "GOODS_COMMENT_IMAGE_SEQ";
	
	/** 상품 평가 답변 번호 */
	public static final String SEQUENCE_GOODS_ESTM_RPL_SEQ = "GOODS_ESTM_RPL_SEQ";
	
	/** 상품 가격 번호 */
	public static final String SEQUENCE_GOODS_PRICE_SEQ = "GOODS_PRICE_SEQ";
	
	/** 상품 설명 공통 번호 */
	public static final String SEQUENCE_GOODS_DESC_COMM_SEQ = "GOODS_DESC_COMM_SEQ";

	/** 상품 필터 그룹(속성) 번호 */
	public static final String SEQUENCE_GOODS_FILT_GRP_NO = "GOODS_FILT_GRP_SEQ";
	public static final String SEQUENCE_GOODS_FILT_ATTR_NO = "GOODS_FILT_ATTR_SEQ";
	
	/** 상품 옵션 그룹 번호 */
	public static final String SEQUENCE_GOODS_OPT_GRP_SEQ = "GOODS_OPT_GRP_SEQ";

	/** 상품 재고 번호 */
	public static final String SEQUENCE_GOODS_SKU_SEQ = "GOODS_SKU_SEQ";
	
	/** 상품 구성 히스토리 번호 */
	public static final String SEQUENCE_GOODS_CSTRT_HIST_SEQ = "GOODS_CSTRT_HIST_SEQ";

	/** 적립 포인트 히스토리 번호 */
	@Deprecated
	public static final String SEQUENCE_SAVE_PNT_HIST_SEQ = "SAVE_PNT_HIST_SEQ";
	
	/** GS 포인트 히스토리 번호 */
	public static final String SEQUENCE_GS_PNT_HIST_SEQ = "GS_PNT_HIST_SEQ";
	
	/** 메인 전시 상품 조회 */
	/** 타임딜 DEAL */
	public static final String GOODS_MAIN_DISP_TYPE_DEAL = "DEAL";
	public static final String GOODS_MAIN_DISP_TYPE_DEAL_COUNT = "4";
	/** 타임딜 진행중 */
	public static final String GOODS_MAIN_DISP_TYPE_DEAL_NOW = "NOW";
	/** 타임딜 예고 */
	public static final String GOODS_MAIN_DISP_TYPE_DEAL_SOON = "SOON";
	/** 폭풍할인 DC */
	public static final String GOODS_MAIN_DISP_TYPE_DC = "DC";
	public static final String GOODS_MAIN_DISP_TYPE_STOCK = "STOCK";
	public static final String GOODS_MAIN_DISP_TYPE_EXPIRATION = "EXPIRATION";
	public static final String GOODS_MAIN_DISP_TYPE_DC_COUNT = "4";
	/** MD 추천 상품 MD */
	public static final String GOODS_MAIN_DISP_TYPE_MD = "MD";
	public static final String GOODS_MAIN_DISP_TYPE_MD_COUNT = "3";
	/** 베스트20 BEST */
	public static final String GOODS_MAIN_DISP_TYPE_BEST = "BEST";
	public static final String GOODS_MAIN_DISP_TYPE_BEST_COUNT = "20";
	/** 베스트20 수동 */
	public static final String GOODS_MAIN_DISP_TYPE_BEST_MANUAL = "MANUAL";
	/** 베스트20 자동 */
	public static final String GOODS_MAIN_DISP_TYPE_BEST_AUTO = "AUTO";
	/** 펫샵 단독 상품 PETSHOP */
	public static final String GOODS_MAIN_DISP_TYPE_PETSHOP = "PETSHOP";
	public static final String GOODS_MAIN_DISP_TYPE_PETSHOP_COUNT = "2";
	/** 패키지 상품 PACKAGE */
	public static final String GOODS_MAIN_DISP_TYPE_PACKAGE = "PACKAGE";
	public static final String GOODS_MAIN_DISP_TYPE_PACKAGE_COUNT = "3";
	/** 인기있는 펫로그후기 PETLOG */
	public static final String GOODS_MAIN_DISP_TYPE_PETLOG = "PETLOG";
	public static final String GOODS_MAIN_DISP_TYPE_PETLOG_COUNT = "10";
	
	public static final String GOODS_MAIN_DISP_TYPE_BANNER = "BANNER";
	public static final String GOODS_MAIN_DISP_TYPE_RCOM = "RCOM";
	public static final String GOODS_MAIN_DISP_TYPE_RCOM_COUNT = "40";
	public static final String GOODS_MAIN_DISP_TYPE_OFFEN = "OFFEN";
	public static final String GOODS_MAIN_DISP_TYPE_NEW = "NEW";
	
	/****************************
	 * 마케팅
	 ****************************/
	
	/** 쿠폰 번호 */
	public static final String SEQUENCE_COUPON_BASE_SEQ = "COUPON_BASE_SEQ";
	
	/** 쿠폰 타겟 순번 */
	public static final String SEQUENCE_COUPON_TARGET_SEQ = "COUPON_TARGET_SEQ";
	
	/** 프로모션 순번 */
	public static final String SEQUENCE_PROMOTION_BASE_SEQ = "PROMOTION_BASE_SEQ";
	
	/** 프로모션 타겟 순번 */
	public static final String SEQUENCE_PROMOTION_TARGET_SEQ = "PROMOTION_TARGET_SEQ";
	
	/** 프로모션 사은품 순번 */
	public static final String SEQUENCE_PROMOTION_FREEBIE_SEQ = "PROMOTION_FREEBIE_SEQ";
	
	/** 기획전 번호 */
	public static final String SEQUENCE_EXHBT_NO_SEQ = "EXHBT_NO_SEQ";
	
	/** 기획전 테마 번호 */
	public static final String SEQUENCE_EXHBT_THM_NO_SEQ = "EXHBT_THM_NO_SEQ";
	
	/** 이벤트 번호 */
	public static final String SEQUENCE_EVENT_BASE_SEQ = "EVENT_BASE_SEQ";

	/** 질문 정보 */
	public static final String SEQUENCE_QUESTION_INFO = "QUESTION_INFO_SEQ";

	/** 답변 정보 */
	public static final String SEQUENCE_ANSWER_INFO = "ANSWER_INFO_SEQ";

	/** 이벤트 추가 필드 번호*/
	public static final String SEQUENCE_EVENT_ADD_FIELD_SEQ = "EVENT_ADD_FIELD_SEQ";

	/** 이벤트 추가 항목 번호*/
	public static final String SEQUENCE_EVENT_COLLECT_ITEM_SEQ = "EVENT_COLLECT_ITEM_SEQ";

	/** 이벤트 당첨자 시퀀스*/
	public static final String SEQUENCE_EVENT_WIN_LIST_SEQ = "EVENT_WIN_LIST_SEQ";

	/** 이벤트 응모 정보 SEQ */
	public static final String SEQUENCE_EVENT_ENTRY_INFO_SEQ = "EVENT_ENTRY_INFO_SEQ";

	
	/****************************
	 * 주문
	 ****************************/
	
	/** 주문 사은품 */
	public static final String SEQUENCE_FRB_NO_SEQ = "FRB_NO_SEQ";
	
	/** 주문 메모 */
	public static final String SEQUENCE_MEMO_SEQ = "MEMO_SEQ";
	
	/** 주문 배송지 번호 */
	public static final String SEQUENCE_ORDER_DLVRA_NO = "ORD_DLVRA_NO";
	
	/** 배송 */
	public static final String SEQUENCE_DLVR_NO_SEQ = "DELIVERY_SEQ";

	/** 직배송 관리 순번 */
	public static final String SEQUENCE_DELIVER_DATE_SET_SEQ = "DELIVER_DATE_SET_SEQ";
	
	/** 직배송지역 순번 */
	public static final String SEQUENCE_DIRECT_DELIVER_SEQ = "DIRECT_DELIVER_SEQ";

	/** 배송비 */
	public static final String SEQUENCE_DLVRC_NO_SEQ = "DLVRC_NO_SEQ";
	
	/** 결제 */
	public static final String SEQUENCE_PAY_BASE_SEQ = "PAY_BASE_SEQ";
	
	/** 결제현금환불 */
	public static final String SEQUENCE_CASH_RFD_NO_SEQ = "CASH_RFD_NO_SEQ";
	
	/** 현금영수증 */
	public static final String SEQUENCE_CASH_RCT_NO_SEQ = "CASH_RCT_NO";
	
	/** 세금계산서 */
	public static final String SEQUENCE_TAX_IVC_NO_SEQ = "TAX_IVC_NO_SEQ";

	/** 주문상세구성 */
	public static final String SEQUENCE_ORD_DTL_CSTRT = "ORD_DTL_CSTRT";
	
	/** 주문상세구성 */
	public static final String SEQUENCE_CLM_DTL_CSTRT = "CLM_DTL_CSTRT";
	
	/** 배송 권역 정보 */
	public static final String SEQUENCE_DLVR_AREA_INFO_SEQ = "DLVR_AREA_INFO";
	
	/** 배송 히스토리 */
	public static final String SEQUENCE_DELIVERY_HISTORY_SEQ = "DELIVERY_HISTORY";
	
	
	
	/****************************
	 * CS
	 ****************************/
	
	/** CS */
	public static final String SEQUENCE_COUNSEL_SEQ = "COUNSEL_SEQ";
	
	/** CS 처리 번호 */
	public static final String SEQUENCE_COUNSEL_PROCESS_SEQ = "COUNSEL_PROCESS_SEQ";
	
	
	/****************************
	 * 통계
	 ****************************/
	
	
	
	/****************************
	 * APP
	 ****************************/
	
	public static final String SEQUENCE_MOBILE_VERSION_SEQ = "MOBILE_VERSION_SEQ";
	public static final String SEQUENCE_MOBILE_SPLASH_SEQ = "MOBILE_SPLASH_SEQ";
	
	
	/****************************
	 * TAG 관리
	 ****************************/

	public static final String SEQUENCE_TAG_GROUP_SEQ = "TAG_GROUP_SEQ";
	public static final String SEQUENCE_TAG_BASE_SEQ = "TAG_BASE_SEQ";
	public static final String SEQUENCE_TAG_TREND_SEQ = "TAG_TREND_SEQ";
	
	/****************************
	 * 영상 관리
	 ****************************/

	public static final String SEQUENCE_APET_CONTENTS_SEQ = "APET_CONTENTS_SEQ";
	public static final String SEQUENCE_APET_CONTENTS_HIST_SEQ = "APET_CONTENTS_HIST_SEQ";
	
	/****************************
	 * 댓글 관리
	 ****************************/

	public static final String SEQUENCE_APET_CONTENTS_REPLY_SEQ = "APET_CONTENTS_REPLY_SEQ";

	/****************************
	 * 반려 동물
	 ****************************/
	public static final String SEQUENCE_PET_BASE_SEQ = "PET_BASE_SEQ";

	public static final String SEQUENCE_PET_DA_SEQ = "PET_DA_SEQ";

	public static final String SEQUENCE_PET_INCL_RECODE_SEQ = "PET_INCL_RECODE";
	
	/****************************
	 * 펫로그
	 ****************************/
	public static final String SEQUENCE_PET_LOG_BASE_SEQ = "PET_LOG_BASE_SEQ";	
	public static final String SEQUENCE_PET_LOG_RPTP_SEQ = "PET_LOG_RPTP_SEQ";
	public static final String SEQUENCE_PET_LOG_REPLY_SEQ = "PET_LOG_REPLY_SEQ";
	public static final String SEQUENCE_PET_LOG_SHARE_SEQ = "PET_LOG_SHARE_SEQ";
	public static final String SEQUENCE_PET_LOG_INTEREST_SEQ = "PET_LOG_INTEREST_SEQ";
	public static final String SEQUENCE_PET_LOG_MENTION_MEMBER_SEQ = "PET_LOG_MENTION_MEMBER_SEQ";
	
	/****************************
	 * 펫TV
	 ****************************/
	public static final String SEQUENCE_PET_TV_SHARE_SEQ = "PET_TV_SHARE_SEQ";
	
	//======================================================================================================
	//== BATCH ID
	//======================================================================================================
	/** 예약 발송 배치 (이메일)*/
	public static final String BATCH_RSRV_EMAIL_SEND = "BATCH_RSRV_EMAIL_SEND";
	
	/** 예약 발송 배치 (PUSH)*/
	public static final String BATCH_RSRV_PUSH_SEND = "BATCH_RSRV_PUSH_SEND";
	
	/** 발송 결과 이력 조회 (이메일)*/
	public static final String BATCH_SENT_EMAIL_RST = "BATCH_SENT_EMAIL_RST";
	
	/** 발송 결과 이력 조회 (PUSH)*/
	public static final String BATCH_SENT_PUSH_RST = "BATCH_SENT_PUSH_RST";
	
	public static final String BATCH_GOODS_IMG_PRCS_LIST = "BT_GOODS_IMG_PRCS_LIST";

	/** 미입금 자동취소 */
	public static final String BATCH_ORD_CANCEL_UNPAID = "BT_ORD_CANCEL_ORDER_UNPAID";
	/** 미입금 안내 발송 (1시간 경과)*/
	public static final String BATCH_ORD_ALARM_UNPAID = "BT_ORD_ALARM_ORDER_UNPAID";
	
	/** 카드사 할부정보 조회 */
	public static final String BATCH_ORD_CARDC_INSTMNT_INFO = "BT_ORD_CARDC_INSTMNT_INFO";
	
	/*배송추척*/
	public static final String BATCH_ORD_REQUEST_TRACE = "BT_ORD_REQUEST_TRACE";
	
	public static final String BATCH_ORD_RECEIVE_TRACE = "BT_ORD_RECEIVE_TRACE";	
	public static final String BATCH_ORD_CASH_RECEIPT = "BT_ORD_CASH_RECEIPT";
	
	/** 구매 확정 */
	public static final String BATCH_ORD_PURCHASE_CONFIRM = "BT_ORD_PURCHASE_CONFIRM";
	/** 배송 지시 */
	public static final String BATCH_DLVR_CIS_DELIVERY_CMD = "BT_DLVR_CIS_DELIVERY_COMMAND";
	/** 배송 상태 변경 */
	public static final String BATCH_DLVR_CIS_DELIVERY_STATE_CHG = "BT_DLVR_CIS_DELIVERY_STATE_CHG";
	/** 회수 지시 */
	public static final String BATCH_DLVR_CIS_RETURN_CMD = "BT_DLVR_CIS_RETURN_COMMAND";
	/** 회수 상태 변경 */
	public static final String BATCH_DLVR_CIS_RETURN_STATE_CHG = "BT_DLVR_CIS_RETURN_STATE_CHG";
	/** 권역 조회 */
	public static final String BATCH_DLVR_AREA_INFO_CIS_SEARCH = "BT_DLVR_AREA_INFO_CIS_SEARCH";
	/** 위탁업체 배송안내 알림톡 */
	public static final String BATCH_DLVR_NOTICE_CONSIGN_ING = "BT_DLVR_NOTICE_CONSIGN_ING";
	/** 위탁업체 배송완료 알림톡 */
	public static final String BATCH_DLVR_NOTICE_CONSIGN_FINAL = "BT_DLVR_NOTICE_CONSIGN_FINAL";
	/** 위탁업체 주문건 수집문자 발송 */
	public static final String BATCH_COMPANY_ORD_NOTICE = "BT_COMPANY_ORD_NOTICE";
	
	/** EP 파일 생성 */
	public static final String BATCH_GOODS_EP_ALL = "BT_GOODS_EP_ALL";
	public static final String BATCH_GOODS_EP_SOME = "BT_GOODS_EP_SOME";
	
	public static final String BATCH_RST_CD_SUCCESS = "0000";
	public static final String BATCH_RST_CD_FAIL = "9999";

	public static final String BATCH_GOODS_STK_QTY_UPDATE = "BT_GOODS_STK_QTY_UPDATE";
	public static final String BATCH_GOODS_BEST_INSERT = "BT_GOODS_BEST_GOODS";

	public static final String BATCH_GOODS_STK_INFO_SELECT = "BT_GOODS_STK_INFO_SELECT";
	public static final String BATCH_GOODS_STK_INFO_SEND = "BT_GOODS_STK_INFO_SEND";
	public static final String BATCH_GOODS_IO_ALARM_SEND = "BT_GOODS_IO_ALARM_SEND";

	public static final String BATCH_GOODS_STAT_60_UPDATE = "BT_GOODS_STAT_60_UPDATE";
	public static final String BATCH_GOODS_DISPLAY_ALL_CTG = "BT_GOODS_DISPLAY_ALL_CTG";

	public static final String BATCH_TWC_SYNC_PRODUCT_REPLACE = "BT_TWC_SYNC_PRODUCT_REPLACE";
	public static final String BATCH_TWC_SYNC_PRODUCT_TABLE = "TWC_PRODUCT";

	public static final String BATCH_TWC_SYNC_NUTRITION_REPLACE = "BT_TWC_SYNC_NUTRITION_REPLACE";
	public static final String BATCH_TWC_SYNC_NUTRITION_TABLE = "TWC_PRODUCT_NUTRITION";
	public static final String BATCH_GOODS_CIS_MANUAL_SEND = "BT_GOODS_CIS_MANUAL_SEND";

	/** 080 수신거부 동기화 */
	public static final String BATCH_SYNC_UNSUBSCRIBES = "BATCH_SYNC_UNSUBSCRIBES";
	
	/** SMS 발송 결과 이력 저장 */
	public static final String BATCH_SENT_SMS_RST = "BATCH_SENT_SMS_RST";
	/** 알림톡 발송 결과 이력 저장 */
	public static final String BATCH_SENT_KKO_RST = "BATCH_SENT_KKO_RST";
	
	/** 회원 생일 축하 쿠폰 배치 */
	public static final String BATCH_BIRTHDAY_COUPON = "BATCH_BIRTHDAY_COUPON";

	/** 회원 휴면 사전 알람 배치 */
	public static final String BATCH_DORMANT_ALARM = "BATCH_DORMANT_ALARM";

	/** 회원 휴면 처리 배치 */
	public static final String BATCH_MEMBER_DORMANT = "BATCH_MEMBER_DORMANT";

	/** 회원 탈퇴 처리 배치 */
	public static final String BATCH_MEMBER_LEAVE = "BATCH_MEMBER_LEAVE";

	/** 회원 쿠폰 만료 안내 */
	public static final String BT_MBR_COUPON_EXPIRE = "BT_MBR_COUPON_EXPIRE";
	
	/** BO사용자 로그인 30일경과 상태변경 */
	public static final String BATCH_USER_STAT_UN_USED = "BATCH_USER_STAT_UN_USED";
	
	/** 반려동물 나이 계산 배치 */
	public static final String BATCH_PET_AGE_CALCULATE = "BATCH_PET_AGE_CALCULATE";

	/** 회윈 등급별 쿠폰 - 패밀리*/
	public static final String BT_MBR_GRD_FAMILIY_COUPON_INSERT = "BT_MBR_GRD_FAMILIY_COUPON_INSERT";
	/** 회윈 등급별 쿠폰 - VIP*/
	public static final String BT_MBR_GRD_VIP_COUPON_INSERT = "BT_MBR_GRD_VIP_COUPON_INSERT";
	/** 회윈 등급별 쿠폰 - VVIP*/
	public static final String BT_MBR_GRD_VVIP_COUPON_INSERT = "BT_MBR_GRD_VVIP_COUPON_INSERT";
	
	/** 회원 등급 배치*/
	public static final String BATCH_MEMBER_GRADE = "BATCH_MEMBER_GRADE";
	
	/** 회원 쿠폰 발급 대기 대상 발급 처리 배치 */
	public static final String BATCH_STB_COUPON = "BATCH_STB_COUPON";


	// ======================================================================================================
	// == 파일 PATH
	// ======================================================================================================
	
	/** 공통 PATH */
	public static final String COMMON_IMAGE_PATH = FileUtil.SEPARATOR + "common";
	
	/** 공통 PATH */
	public static final String TEMP_IMAGE_PATH = FileUtil.SEPARATOR + "temp";
	
	/** 사이트 이미지 PATH */
	public static final String ST_IMAGE_PATH = FileUtil.SEPARATOR + "st";
	
	/** 사이트 정책  */
	public static final String ST_POLICY_IMAGE_PTH = FileUtil.SEPARATOR + "st_policy";
	
	/** 개인정보보호정책 */
	public static final String PRIVACY_IMAGE_PTH = FileUtil.SEPARATOR + "privacy";
	
	/** 에디터 이미지 PATH */
	public static final String EDITOR_IMAGE_PATH = FileUtil.SEPARATOR + "editor";
	
	/** 게시판 이미지 PATH */
	public static final String BOARD_IMAGE_PATH = FileUtil.SEPARATOR + "board";
	
	/** EXCEL PATH */
	public static final String EXCEL_SAMPLE_PATH = FileUtil.SEPARATOR + "excel";
	
	/** 공지사항 파일 PATH */
	public static final String NOTICE_IMAGE_PATH = FileUtil.SEPARATOR + "notice";
	
	/** Email PATH */
	public static final String EMAIL_PATH = FileUtil.SEPARATOR + "email";
	
	/** 입점문의 파일 PATH */
	public static final String CONTECT_FILE_PATH = FileUtil.SEPARATOR + "contect";
	
	/** 업체 정책 내용 PATH */
	public static final String POLICY_CNTS_PATH = FileUtil.SEPARATOR + "policy";
	
	/** 전시 이미지 PATH */
	public static final String DISPLAY_IMAGE_PATH = FileUtil.SEPARATOR + "display";
	
	/** 전시분류(10) 이미지 PATH */
	public static final String DISP_CLSF_IMAGE_PATH = FileUtil.SEPARATOR + "dispclsf";
	
	/** 브랜드 이미지 PATH */
	public static final String BRAND_IMAGE_PATH = FileUtil.SEPARATOR + "brand";
	
	/** 브랜드 모바일 이미지 PATH */
	public static final String BRANDMO_IMAGE_PATH = FileUtil.SEPARATOR + "brandmo";

	/** 브랜드 썸네일 이미지 PATH */
	public static final String BRANDTN_IMAGE_PATH = FileUtil.SEPARATOR + "brandtn";

	/** 브랜드 썸네일 모바일 이미지 PATH */
	public static final String BRANDTNMO_IMAGE_PATH = FileUtil.SEPARATOR + "brandtnmo";
	
	/** 브랜드 콘텐츠 이미지 PATH */
	public static final String BRAND_CNTS_IMAGE_PATH = FileUtil.SEPARATOR + "brand_cnts";

	/** 브랜드 콘텐츠 아이템 이미지 PATH */
	public static final String BRAND_CNTS_ITEM_IMAGE_PATH = FileUtil.SEPARATOR + "brand_cnts_item";
	
	/** 팝업 */
	public static final String POPUP_IMAGE_PTH = FileUtil.SEPARATOR + "popup";

	/** 쿠폰 이미지 PATH */
	public static final String COUPON_IMAGE_PATH = FileUtil.SEPARATOR + "coupon";

	/** 이벤트 이미지 PATH */
	public static final String EVENT_IMAGE_PATH = FileUtil.SEPARATOR + "event";
	
	/** 기획전 이미지 PATH */
	public static final String EXHIBITION_IMAGE_PATH = FileUtil.SEPARATOR + "exhibition";

	/** 상품 설명 */
	public static final String GOODS_DESC_IMAGE_PTH = FileUtil.SEPARATOR + "goods_desc";
	
	/** 상품 설명 공통 */
	public static final String GOODS_DESC_COMM_IMAGE_PTH = FileUtil.SEPARATOR + "goods_desc_comm";
	
	/** 상품 주의사항 */
	public static final String GOODS_CAUTION_IMAGE_PTH = FileUtil.SEPARATOR + "goods_caution";
	
	/** 상품평 이미지 PATH */
	public static final String GOODS_COMMENT_IMAGE_PATH = FileUtil.SEPARATOR + "goods_comment";

	/** 1:1 문의 이미지 PATH */
	public static final String COUNSEL_IMAGE_PATH = FileUtil.SEPARATOR + "counsel";
	
	/** 클레임 이미지 PATH */
	public static final String CLAIM_IMAGE_PATH = FileUtil.SEPARATOR + "claim";

	/** 사용자 메시지 */
	public static final String USER_MESSAGE_IMAGE_PTH = FileUtil.SEPARATOR + "user_message";

	/** Splash 이미지 PATH */
	public static final String SPLASH_IMAGE_PATH = FileUtil.SEPARATOR + "splash";
	
	/** Banner 이미지 PATH */
	public static final String BANNER_IMAGE_PATH = FileUtil.SEPARATOR + "banner";
	
	/** 시리즈 이미지 PATH */
	public static final String SERIES_IMAGE_PATH = FileUtil.SEPARATOR + "series";
	
	/** 시즌 이미지 PATH */
	public static final String SEASON_IMAGE_PATH = FileUtil.SEPARATOR + "season";
	
	/** 펫 로그 이미지 PATH */
	public static final String PET_LOG_IMAGE_PATH = FileUtil.SEPARATOR + "log";
	
	/** VOD FILE PATH */
	public static final String VOD_FILE_PATH = FileUtil.SEPARATOR + "vod";
	
	/** 통합약관 관리 내용 이미지 PATH */
	public static final String TERMS_CONT_PATH = FileUtil.SEPARATOR + "terms_cont";
	
	/** 통합약관 관리 요약정보 이미지 PATH */
	public static final String TERMS_SMRY_CONT_PATH = FileUtil.SEPARATOR + "terms_smry_cont";
	
	/** 반려동물 이미지 PATH */
	public static final String PET_IMG_PATH = FileUtil.SEPARATOR + "pet";

	/** 반려동물 예방접종 이미지 PATH */
	public static final String PET_INCL_IMG_PATH = FileUtil.SEPARATOR + "petincl";

	/** 상품 평가 이미지 PATH */
	public static final String GOODS_COMMENT_IMG_PATH = FileUtil.SEPARATOR + "goodsComment";

	/** 상품 문의 이미지 PATH */
	public static final String GOODS_INQUIRY_IMG_PATH = FileUtil.SEPARATOR + "goodsInquiry";

	/** 회원 이미지 PATH */
	public static final String MBR_IMG_PATH = FileUtil.SEPARATOR + "member";
	
	/** 알림 발송 FILE PATH */
	public static final String PUSH_FILE_PATH = FileUtil.SEPARATOR + "push";
	
	
	/** 펫로그 파트너 이미지 PATH */
	public static final String PET_LOG_PARTNER_IMG_PATH = FileUtil.SEPARATOR + "petLogPartner";
	
	/** 업체 관련 이미지 */
	public static final String COMPANY_IMG_PATH = FileUtil.SEPARATOR + "company";
	
	/** 상품 PATH */
	public static final String GOODS_IMAGE_PATH = FileUtil.SEPARATOR + "goods";
	
	/** 이벤트팝업 PATH */
	public static final String EVTPOP_IMG_PATH = FileUtil.SEPARATOR + "evtpop";

	// ======================================================================================================
	// == EMMA
	// ======================================================================================================
	public static final String BROADCAST_YN = "BROADCAST_YN";
	public static final String BROADCAST_YN_Y = "Y";
	public static final String BROADCAST_YN_N = "N";

	public static final String SERVICE_TYPE = "SERVICE_TYPE";
	public static final String SERVICE_TYPE_SMS_MT = "0";
	public static final String SERVICE_TYPE_CALLBACK_URL = "1";
	public static final String SERVICE_TYPE_MMS_MT = "2";
	public static final String SERVICE_TYPE_LMS = "3";
	
	// ======================================================================================================
	// == SSG Agent (SMS/MMS/KKO)
	// ======================================================================================================
	/** 전송상태 */
	public static final String MSG_STATUS = "MSG_STATUS";
	/** 전송상태 : 전송대기 */
	public static final Long MSG_STATUS_READY = 0L;
	/** 전송상태 : 결과대기(GW전송완료) */
	public static final Long MSG_STATUS_SEND = 2L;
	/** 전송상태 : 결과수신완료 */
	public static final Long MSG_STATUS_COMPLETE = 3L;
	/** 전송상태 : 로그 이동 실패 */
	public static final Long MSG_STATUS_LOG_FAIL = 4L;
	/** 전송상태 : 임시 */
	public static final Long MSG_STATUS_TEMP = 9L;
	
	/** 메시지 타입 */
	public static final String MSG_TP = "MSG_TP";
	/** 메시지 타입 : SMS */
	public static final Long MSG_TP_SMS = 0L;
	/** 메시지 타입 : LMS */
	public static final Long MSG_TP_LMS = 2L;
	/** 메시지 타입 : MMS */
	public static final Long MSG_TP_MMS = 3L;
	/** 메시지 타입 : KKO */
	public static final Long MSG_TP_KKO = 4L;
	/** 메시지 타입 : KKF */
	public static final Long MSG_TP_KKF = 6L;
	/** 메시지 타입 : KKI */
	public static final Long MSG_TP_KK0I = 7L;
	
	/** 재발송 메시지 타입 */
	public static final String RESEND_MSG_TP = "RESEND_MSG_TP";
	/** 재발송 메시지 타입 : SMS */
	public static final String RESEND_MSG_TP_SMS = "SMS";
	/** 재발송 메시지 타입 : LMS */
	public static final String RESEND_MSG_TP_LMS = "LMS";
	
	/** 메세지 혀용 목록 */
	public static final String MSG_ALLOW_LIST = "MSG_ALLOW_LIST";
	/** 메세지 혀용 목록 : message */
	public static final String MSG_ALLOW_LIST_10 = "10";
	
	/** fuser default : system */
	public static final String FUSER_DEFAULT = "SYSTEM";

	// ======================================================================================================
	// == Email
	// ======================================================================================================
	
	/** mall name */
	public static final String EMAIL_TITLE_ARG_MALL_NAME = "{mall_name}";
	
	
	// ======================================================================================================
	// == SMS
	// ======================================================================================================
	
	/** mall name */
	public static final String SMS_TITLE_ARG_MALL_NAME = "{mall_name}";
	/** mall name */
	public static final String SMS_MSG_ARG_MALL_NAME = "{mall_name}";
	/** URL */
	public static final String SMS_MSG_ARG_MALL_URL = "{mall_url}";
	/** 회원이름 */
	public static final String SMS_MSG_ARG_MBR_NAME = "{mbr_nm}";
	/** 회원이름 */
	public static final String SMS_MSG_ARG_USER_NAME = "{usr_nm}";
	/** 주문번호 */
	public static final String SMS_MSG_ARG_ORD_NO = "{ord_no}";
	/** 주문상품 */
	public static final String SMS_MSG_ARG_GOODS_NM = "{goods_nm}";
	/** 택배사 */
	public static final String SMS_MSG_ARG_HDC_NM = "{hdc_nm}";
	/** 송장번호 */
	public static final String SMS_MSG_ARG_INV_NO = "{inv_no}";
	/** 배송완료일 */
	public static final String SMS_MSG_ARG_DLVR_CPLT_DTM = "{dlvr_cplt_day}";
	/** 임시비밀번호 */
	public static final String SMS_MSG_ARG_TEMP_PSWD = "{temp_password}";
	/** 비밀번호 */
	public static final String SMS_MSG_ARG_PSWD = "{pswd}";
	/** 취소 금액 */
	public static final String SMS_MSG_ARG_CNCL_AMT = "{cncl_amt}";
	/** 클레임 사유 */
	public static final String SMS_MSG_ARG_CLM_RSN_CONTENT = "{clm_rsn_content}";
	/** 사용자 아이디 */
	public static final String SMS_MSG_ARG_USER_ID = "{user_id}";
	/** 사용자 아이디 */
	public static final String SMS_MSG_ARG_LOGIN_ID = "{login_id}";
	/** 환불금액 */
	public static final String SMS_MSG_ARG_REFUND_AMT = "{refund_amt}";
	/** 입금 기한 */
	public static final String SMS_MSG_ARG_DUE_DAY = "{due_day}";
	/** 은행 명 */
	public static final String SMS_MSG_ARG_BANK_NM = "{bank_nm}";
	/** 계좌번호 */
	public static final String SMS_MSG_ARG_ACCT_NO = "{acct_no}";
	/** 예금주 */
	public static final String SMS_MSG_ARG_OOA_NM = "{ooa_nm}";
	/** 입금 예정 금액 */
	public static final String SMS_MSG_ARG_DUE_AMT = "{due_amt}";
	/** 유저구분 */
	public static final String SMS_MSG_ARG_USR_GB = "{usr_gb}";
	/** 권한정보 */
	public static final String SMS_MSG_ARG_AUTH_NM = "{auth_nm}";
	/** 업체명 */
	public static final String SMS_MSG_ARG_COMP_NM = "{comp_nm}";

	
	// ======================================================================================================
	// == 굿스플로
	// ======================================================================================================
	
	/** 배송 상태 코드 */
	public static final String DLVR_STAT = "DLVR_STAT";
	/** 배송 상태 코드 : 집화 */
	public static final String DLVR_STAT_30 = "30";						
	/** 배송 상태 코드 : 배달완료 */
	public static final String DLVR_STAT_70 = "70";						
	/** 배송 상태 코드 : 오류 */
	public static final String DLVR_STAT_99 = "99";						
	
	public static final String GOODS_FLOW_STATUS_SUCCESS = "200";
	public static final String GOODS_FLOW_STATUS_NO_DATA = "204";
	public static final String GOODS_FLOW_STATUS_NO_AUTH = "401";
	public static final String GOODS_FLOW_STATUS_UNKOWN = "900";
	
	
	// ======================================================================================================
	// == 오픈마켓 연동
	// ======================================================================================================
	
	/** 오픈마켓 종류 */
	public static final String OPENMARKET_GB = "OPENMARKET_GB";
	
	/** 오픈마켓 종류  11번가 */
	public static final String OPENMARKET_GB_10 = "10";	

	/** 오픈마켓 주문 상태 코드 */
	public static final String MARKET_ORD_STAT = "MARKET_ORD_STAT";
	/** 오픈마켓 주문 상태 코드 : 결제완료 */
	public static final String MARKET_ORD_STAT_10 = "10";				
	/** 오픈마켓 주문 상태 코드 : 배송준비 */
	public static final String MARKET_ORD_STAT_20 = "20";				
	/** 오픈마켓 주문 상태 코드 : 배송완료 */
	public static final String MARKET_ORD_STAT_30 = "30";				
	/** 오픈마켓 주문 상태 코드 : 취소완료 */
	public static final String MARKET_ORD_STAT_40 = "40";					

	/** 오픈마켓 클레임 구분 코드 */
	public static final String MARKET_CLM_GB = "MARKET_CLM_GB";
	/** 오픈마켓 클레임 구분 코드 : 주문취소 */
	public static final String MARKET_CLM_GB_10 = "10";					
	/** 오픈마켓 클레임 구분 코드 : 교환 */
	public static final String MARKET_CLM_GB_20 = "20";					
	/** 오픈마켓 클레임 구분 코드 : 반품 */
	public static final String MARKET_CLM_GB_30 = "30";					
	
	/** 오픈마켓 클레임 상태 코드 */
	public static final String MARKET_CLM_STAT = "MARKET_CLM_STAT";
	/** 오픈마켓 클레임 상태 코드 : 취소요청 */
	public static final String MARKET_CLM_STAT_01 = "01";				
	/** 오픈마켓 클레임 상태 코드 : 취소완료 */
	public static final String MARKET_CLM_STAT_02 = "02";				
	/** 오픈마켓 클레임 상태 코드 : 반품신청 */
	public static final String MARKET_CLM_STAT_105 = "105";				
	/** 오픈마켓 클레임 상태 코드 : 반품완료 */
	public static final String MARKET_CLM_STAT_106 = "106";				
	/** 오픈마켓 클레임 상태 코드 : 교환신청 */
	public static final String MARKET_CLM_STAT_201 = "201";				
	/** 오픈마켓 클레임 상태 코드 : 교환승인 */
	public static final String MARKET_CLM_STAT_212 = "212";					
		
	
	// ======================================================================================================
	// == PAYCO 코드
	// ======================================================================================================
	/* 페이코 취소 타입 : 전체 취소 */
	public static final String PAYCO_CANCEL_TYPE_ALL = "ALL";			
	/* 페이코 취소 타입 : 부분 취소 */
	public static final String PAYCO_CANCEL_TYPE_PART = "PART";			
	/* 페이코 결제 채널 : PC */
	public static final String PAYCO_CHANNEL_PC = "PC";					
	/* 페이코 결제 채널 : Mobile */
	public static final String PAYCO_CHANNEL_MOBILE = "MOBILE";			
	
	
	// ======================================================================================================
	// == WMS
	// ======================================================================================================

	/** OPENAPI WMS 업체번호 */
	public static final long OPENAPI_WMS_COMP_NO = 1L;
	
	/** 구분 */
	public static final String DELIVER_GUBUN = "DELIVER_GUBUN";
	/** 구분 : 기간 */
	public static final String DELIVER_GUBUN_10 = "10";				
	/** 구분 : 이후 */
	public static final String DELIVER_GUBUN_20 = "20";				
	
	
	/** 창고 유형 */
	public static final String WMS_WAREHOUSE_TYPE = "WMS_WAREHOUSE_TYPE";
	
	/** 로케이션 유형 */
	public static final String WMS_LOCATION_TYPE = "WMS_LOCATION_TYPE";
	
	/** 기사 계약상태 */
	public static final String WMS_DRIVERCONT_STAT = "WMS_DRIVERCONT_STAT";
	
	/** 발주_검색_단종여부 */
	public static final String WMS_PO_SRCH_OPT_01 = "WMS_PO_SRCH_OPT_01";
	
	/** 발주_검색_검색구분 */
	public static final String WMS_PO_SRCH_OPT_02 = "WMS_PO_SRCH_OPT_02";

	/** 발주승인_검색_승인여부 */
	public static final String WMS_PO_SRCH_OPT_03 = "WMS_PO_SRCH_OPT_03";
	
	/** 발주입고_검색_입고상태 */
	public static final String WMS_IN_ORD_STATUS = "WMS_IN_ORD_STATUS";

	/** 발주입고_검색_입고상태 */
	public static final String WMS_OUT_ORD_STATUS = "WMS_OUT_ORD_STATUS";

	/** 입고_검색_입고유형 */
	public static final String WMS_IN_ORD_TYPE = "WMS_IN_ORD_TYPE";

	/** 출고_검색_출고유형 */
	public static final String WMS_OUT_ORD_TYPE = "WMS_OUT_ORD_TYPE";

	/** 창고이동-이동상태 */
	public static final String WMS_WHMOVE_STAT = "WMS_WHMOVE_STAT";

	/** 배차상태 */
	public static final String WMS_DISP_CHG_STATUS = "WMS_DISP_CHG_STATUS";

	/** 마감상태 */
	public static final String WMS_DEADLINE_STATUS = "WMS_DEADLINE_STATUS";
	
	/** 혜택 적용 방식 코드 */
	public static final String FVR_APL_METH = "FVR_APL_METH";
	/** 혜택 적용 방식 코드 : 정율 */
	public static final String FVR_APL_METH_10 = "10";				
	/** 혜택 적용 방식 코드 : 정액 */
	public static final String FVR_APL_METH_20 = "20";				
	
	/****************************
	 * 반려동물
	 ****************************/
	
	/** 펫 구분 코드 */
	public static final String PET_GB = "PET_GB";
	/** 미등록 */
	public static final String PET_GB_00 = "00";
	/** 강아지 */
	public static final String PET_GB_10 = "10";				
	/** 고양이 */
	public static final String PET_GB_20 = "20";				
	/** 기타 */
	public static final String PET_GB_30 = "30";				
	/** 관상어 */
	public static final String PET_GB_40 = "40";				
	/** 소동물 */
	public static final String PET_GB_50 = "50";				

	/** 반려동물 종류 구분 코드 */
	public static final String PET_KIND = "PET_KIND";
	
	
	
	/** 펫 TV VOD 채널 ID */
	public static final String VOD_GROUP_ID_PET_TV ="aboutPet_tv";
	/** 펫 로그 VOD 채널 ID */
	public static final String VOD_GROUP_ID_PET_LOG ="aboutPet_log";
	/** 펫 가이드 VOD 채널 ID */
	public static final String VOD_GROUP_ID_PET_GUIDE ="petGuide";

	
	/** 반려동물 건강수첩 접종안내 VOD 리스트 ID */
	public static final String INCL_VOD_LIST_ID ="healthHandBook";
	
	/** 기초 검사 명 FRONT*/
	public static final String INCL_BASIC ="기초";
	/** 정기 검사 명 FRONT*/
	public static final String INCL_REGULAR ="정기";
	
	/** 접종 구분 코드 */
	public static final String INCL_GB = "INCL_GB";	
	/** 기초접종 */
	public static final String INCL_GB_10 = "10";	
	/** 정기접종 */
	public static final String INCL_GB_20 = "20";	
	/** 항체가 검사 */
	public static final String INCL_GB_30 = "30";	
	/** 투약 */
	public static final String INCL_GB_40 = "40";	
	
	/** 접종 종류 코드 */
	public static final String INCL_KIND = "INCL_KIND";
	/** 종합백신 1차 */
	public static final String INCL_KIND_1001 = "1001";
	/** 종합백신 2차 */
	public static final String INCL_KIND_1002 = "1002";
	/** 종합백신 3차 */
	public static final String INCL_KIND_1003 = "1003";
	/** 종합백신 4차 */
	public static final String INCL_KIND_1004 = "1004";
	/** 종합백신 5차 */
	public static final String INCL_KIND_1005 = "1005";
	/** 코로나 장염(기초접종) */
	public static final String INCL_KIND_1006 = "1006";
	/** 켄넬코프(기초접종) */
	public static final String INCL_KIND_1007 = "1007";
	/** 인플루엔자(기초접종) */
	public static final String INCL_KIND_1008 = "1008";
	/** 광견병(기초접종) */
	public static final String INCL_KIND_1009 = "1009";
	/** 종합백신(정기접종) */
	public static final String INCL_KIND_1010 = "1010";
	/** 코로나 장염(정기접종) */
	public static final String INCL_KIND_1011 = "1011";
	/** 켄넬코프 (정기접종)*/
	public static final String INCL_KIND_1012 = "1012";
	/** 인플루엔자 (정기접종)*/
	public static final String INCL_KIND_1013 = "1013";
	/** 광견병 (정기접종)*/
	public static final String INCL_KIND_1014 = "1014";
	/** 종합백신 (항체가 검사)*/
	public static final String INCL_KIND_1015 = "1015";
	/** 코로나 장염 (항체가 검사) */
	public static final String INCL_KIND_1016 = "1016";
	/** 켄넬코프 (항체가 검사)*/
	public static final String INCL_KIND_1017 = "1017";
	/** 인플루엔자 (항체가 검사) */
	public static final String INCL_KIND_1018 = "1018";
	/** 광견병 (항체가 검사)*/
	public static final String INCL_KIND_1019 = "1019";
	
	/** 혼합예방백신 1차 */
	public static final String INCL_KIND_2001 = "2001";
	/** 혼합예방백신 2차 */
	public static final String INCL_KIND_2002 = "2002";
	/** 혼합예방백신 3차 */
	public static final String INCL_KIND_2003 = "2003";
	/** 전염성복막염 (기초접종)*/
	public static final String INCL_KIND_2004 = "2004";
	/** 광견병 (기초접종)*/
	public static final String INCL_KIND_2005 = "2005";
	/** 혼합예방백신 (정기접종)*/
	public static final String INCL_KIND_2006 = "2006";
	/** 전염성복막염 (정기접종)*/
	public static final String INCL_KIND_2007 = "2007";
	/** 광견병 (정기접종)*/
	public static final String INCL_KIND_2008 = "2008";
	/** 혼합예방백신 (항체가검사)*/
	public static final String INCL_KIND_2009 = "2009";
	/** 전염성복막염 (항체가검사)*/
	public static final String INCL_KIND_2010 = "2010";
	/** 광견병 (항체가검사)*/
	public static final String INCL_KIND_2011 = "2011";
	/** 내부기생충 */
	public static final String INCL_KIND_4001 = "4001";
	/** 외부기생충 */
	public static final String INCL_KIND_4002 = "4002";
	/** 심장사상충 */
	public static final String INCL_KIND_4003 = "4003";
	/** 직접입력 */
	public static final String INCL_KIND_9999 = "9999";
	
	/** 추가 접종 코드 */
	public static final String INCL_ADD = "INCL_ADD";
	/** 코로나장염 */
	public static final String INCL_ADD_10 = "10";
	/** 켄넬코프 */
	public static final String INCL_ADD_20 = "20";
	/** 인플루엔자 */
	public static final String INCL_ADD_30 = "30";
	/** 광견병 */
	public static final String INCL_ADD_40 = "40";
	
	
	
	
	/** 펫 성별 */
	public static final String PET_GD_GB = "PET_GD_GB";
	/** 수컷 */
	public static final String PET_GD_GB_10 = "10";
	/** 암컷 */
	public static final String PET_GD_GB_20 = "20";
	
	/** 반려동물 질병 구분 코드 */
	public static final String DA_GB = "DA_GB";
	/** 질환 */
	public static final String DA_GB_10 = "10";
	/** 알러지 */
	public static final String DA_GB_20 = "20";
	
	/** 반려동물 질병 코드*/
	public static final String DA = "DA";
	/** 피부 */
	public static final String DA_1001 = "1001";
	/** 눈 */
	public static final String DA_1002 = "1002";
	/** 눈물 */
	public static final String DA_1003 = "1003";
	/** 귀 */
	public static final String DA_1004 = "1004";
	/** 관절 */
	public static final String DA_1005 = "1005";
	/** 치아 */
	public static final String DA_1006 = "1006";
	/** 모질 */
	public static final String DA_1007 = "1007";
	/** 호흡기 */
	public static final String DA_1008 = "1008";
	/** 소화기 */
	public static final String DA_1009 = "1009";
	/** 체중 */
	public static final String DA_1010 = "1010";
	/** 노환 */
	public static final String DA_1011 = "1011";
	/** 신장 */
	public static final String DA_1012 = "1012";
	/** 소고기 */
	public static final String DA_2001 = "2001";
	/** 유제품 */
	public static final String DA_2002 = "2002";
	/** 밀 */
	public static final String DA_2003 = "2003";
	/** 닭 */
	public static final String DA_2004 = "2004";
	/** 달걀 */
	public static final String DA_2005 = "2005";
	/** 양고기 */
	public static final String DA_2006 = "2006";
	/** 콩 */
	public static final String DA_2007 = "2007";
	/** 옥수수 */
	public static final String DA_2008 = "2008";
	/** 돼지고기 */
	public static final String DA_2009 = "2009";
	/** 물고기 */
	public static final String DA_2010 = "2010";
	/** 밥 */
	public static final String DA_2011 = "2011";
	/** 소고기 */
	public static final String DA_2012 = "2012";
	/** 유제품 */
	public static final String DA_2013 = "2013";
	/** 물고기 */
	public static final String DA_2014 = "2014";
	/** 양고기 */
	public static final String DA_2015 = "2015";
	/** 밀 */
	public static final String DA_2016 = "2016";
	/** 닭 */
	public static final String DA_2017 = "2017";
	/** 옥수수 */
	public static final String DA_2018 = "2018";
	/** 달걀 */
	public static final String DA_2019 = "2019";
	
	
	/** 펫로그 상품추천 여부 */
	public static final String GOODS_RECOM_YN = "GOODS_RECOM_YN";
	/** Y */
	public static final String GOODS_RECOM_YN_Y = "Y";				
	/** N */
	public static final String GOODS_RECOM_YN_N = "N";				
	
	/** 펫로그 목록 정렬 순서 */
	public static final String PETLOG_ORDERING_TP = "PETLOG_ORDERING_TP";
	/** 최근등록순 */
	public static final String PETLOG_ORDERING_TP_10 = "10";				
	/** 조회수 높은순 */
	public static final String PETLOG_ORDERING_TP_20 = "20";				
	/** 좋아요 높은순 */
	public static final String PETLOG_ORDERING_TP_30 = "30";	
	
	/** 펫로그 컨텐츠 구분 */
	public static final String PETLOG_CONTS_GB = "PETLOG_CONTS_GB";
	/** 영상 */
	public static final String PETLOG_CONTS_GB_10 = "10";				
	/** 사진 */
	public static final String PETLOG_CONTS_GB_20 = "20";
	
	/** 펫로그 채널 */
	public static final String PETLOG_CHNL = "PETLOG_CHNL";
	/** 펫로그 */
	public static final String PETLOG_CHNL_10 = "10";				
	/** 상품 */
	public static final String PETLOG_CHNL_20 = "20";				
	/** 펫스쿨 */
	public static final String PETLOG_CHNL_30 = "30";
	/** 이벤트 */
	public static final String PETLOG_CHNL_40 = "40";

	/** 펫로그 전시 구분 */
	public static final String PETLOG_DISP_GB = "PETLOG_DISP_GB";
	/** 노출 */
	public static final String PETLOG_DISP_GB_10 = "10";				
	/** 미노출 */
	public static final String PETLOG_DISP_GB_20 = "20";				
	/** 신고차단 */
	public static final String PETLOG_DISP_GB_30 = "30";	
	
	/** 회원 구분 코드 */
	public static final String MBR_GB_CD = "MBR_GB";
	/** 회원 구분 코드 10 : 통합 회원 (GS&포인트) */
	public static final String MBR_GB_CD_10 = "10";							
	/** 회원 구분 코드 20 : 준회원 (하루/펫츠비) */
	public static final String MBR_GB_CD_20 = "20";							
	/** 회원 구분 코드 30 : 펫로그 파트너 */
	public static final String MBR_GB_CD_30 = "30";							
	/** 회원 구분 코드 40 : 제휴사 */
	public static final String MBR_GB_CD_40 = "40";							
	/** 회원 구분 코드 50 : B2B */
	public static final String MBR_GB_CD_50 = "50";							

	/* 통신사 구분 코드 */
	public static final String MOBILE_CD = "MOBILE_CD";
	/** SKT */
	public static final String MOBILE_CD_SKT = "01";							
	/** KT */
	public static final String MOBILE_CD_KT = "02";							
	/** LGT */
	public static final String MOBILE_CD_LGT = "03";							
	/** SKT알뜰폰 */
	public static final String MOBILE_CD_SKT_CLTH = "04";							
	/** KT알뜰폰 */
	public static final String MOBILE_CD_KT_CLTH = "05";							
	/** LG알뜰폰 */
	public static final String MOBILE_CD_LG_CLTH = "06";							

	/****************************
	 * CIS API
	 ****************************/
	public static final String CIS_API_SYSTEM_SHOP = "shop";
	public static final String CIS_API_SYSTEM_MDM = "mdm";
	public static final String CIS_API_SYSTEM_GATEWAY = "gateway";

	/** MDM 거래처 등록 */
	public static final String CIS_API_ID_IF_R_INSERT_PRNT_INFO = "IF_R_INSERT_PRNT_INFO";
	/** MDM 거래처 조회 */
	public static final String CIS_API_ID_IF_S_SELECT_PRNT_LIST = "IF_S_SELECT_PRNT_LIST";
	/** MDM 거래처 수정 */
	public static final String CIS_API_ID_IF_R_UPDATE_PRNT_INFO = "IF_R_UPDATE_PRNT_INFO";
	/** SHOP 상품 조회 */
	public static final String CIS_API_ID_IF_S_SELECT_PRDT_INFO = "IF_S_SELECT_PRDT_INFO";
	/** SHOP 주문 등록*/
	public static final String CIS_API_ID_IF_R_INSERT_ORDR_INFO = "IF_R_INSERT_ORDR_INFO";
	/** SHOP 주문 조회*/
	public static final String CIS_API_ID_IF_S_SELECT_ORDR_LIST = "IF_S_SELECT_ORDR_LIST";
	/** SHOP 주문 취소*/
	public static final String CIS_API_ID_IF_R_CANCEL_ORDR_INFO = "IF_R_CANCEL_ORDR_INFO";
	/** SHOP 반품 등록*/
	public static final String CIS_API_ID_IF_R_RETURN_ORDR_INFO = "IF_R_RETURN_ORDR_INFO";
	/** SHOP 반품 조회*/
	public static final String CIS_API_ID_IF_S_SELECT_RTNS_LIST = "IF_S_SELECT_RTNS_LIST";
	/** SHOP 반품 취소*/
	public static final String CIS_API_ID_IF_R_CANCEL_RTNS_INFO = "IF_R_CANCEL_RTNS_INFO";
	/** SHOP 슬롯 조회*/
	public static final String CIS_API_ID_IF_S_SELECT_SLOT_LIST = "IF_S_SELECT_SLOT_LIST";
	/** SHOP 권역 조회*/
	public static final String CIS_API_ID_IF_S_SELECT_RNGE_LIST = "IF_S_SELECT_RNGE_LIST";
	/** SHOP 주문 수정*/
	public static final String CIS_API_ID_IF_R_UPDATE_ORDR_INFO = "IF_R_UPDATE_ORDR_INFO";
	/** SHOP 반품 수정*/
	public static final String CIS_API_ID_IF_R_UPDATE_RTNS_INFO = "IF_R_UPDATE_RTNS_INFO";
	/** 상품단품조회 */
	public static final String CIS_API_ID_IF_S_SELECT_SKU_INFO = "IF_S_SELECT_SKU_INFO";
	/** 단품등록 */
	public static final String CIS_API_ID_IF_R_INSERT_SKU_INFO = "IF_R_INSERT_SKU_INFO";
	/** 단품수정 */
	public static final String CIS_API_ID_IF_R_UPDATE_SKU_INFO = "IF_R_UPDATE_SKU_INFO";
	/** 상품 등록 */
	public static final String CIS_API_ID_IF_R_INSERT_PRDT_INFO = "IF_R_INSERT_PRDT_INFO";
	/** 상품 수정 */
	public static final String CIS_API_ID_IF_R_UPDATE_PRDT_INFO = "IF_R_UPDATE_PRDT_INFO";
	/** 브랜드 등록 */
	public static final String CIS_API_ID_IF_R_INSERT_BRAND_INFO = "IF_R_INSERT_BRAND_INFO";
	/** 브랜드 수정 */
	public static final String CIS_API_ID_IF_R_UPDATE_BRAND_INFO = "IF_R_UPDATE_BRAND_INFO";
	/** 상품재고조회 */
	public static final String CIS_API_ID_IF_S_SELECT_STOCK_LIST = "IF_S_SELECT_STOCK_LIST";
	/** 출고 차수 생성 여부 조회 */
	public static final String CIS_API_ID_IF_R_CHECK_SHP_SEQ = "IF_R_CHECK_SHP_SEQ";
	/** 게이트웨이 */
	public static final String CIS_API_ID_IF_R_GATEWAY_INFO = "IF_R_GATEWAY_INFO";

	public static final String CIS_API_ID_IF_R_UPDATE_SKU_INFO_OWNR_CD = "PB";
	public static final String CIS_API_ID_IF_R_UPDATE_SKU_INFO_WARE_CD = "WH01";
	public static final String CIS_API_ID_IF_R_UPDATE_SKU_INFO_UNIT_NM = "EA";

	/** SHOP 주문 조회 - 상태코드 : 결제완료 */
	public static final String CIS_API_SELECT_ORDR_STAT_CD_02 = "02";
	/** SHOP 주문 조회 - 상태코드 : 상품준비 */
	public static final String CIS_API_SELECT_ORDR_STAT_CD_03 = "03";
	/** SHOP 주문 조회 - 상태코드 : 출고확정 */
	public static final String CIS_API_SELECT_ORDR_STAT_CD_04 = "04";
	/** SHOP 주문 조회 - 상태코드 : 배송완료 */
	public static final String CIS_API_SELECT_ORDR_STAT_CD_05 = "05";
	/** SHOP 주문 조회 - 상태코드 : 주문취소 */
	public static final String CIS_API_SELECT_ORDR_STAT_CD_99 = "99";
	
	/** SHOP 반품 조회 - 상태코드 : 반품대기 */
	public static final String CIS_API_SELECT_RTNS_STAT_CD_01 = "01";
	/** SHOP 반품 조회 - 상태코드 : 반품진행 */
	public static final String CIS_API_SELECT_RTNS_STAT_CD_02 = "02";
	/** SHOP 반품 조회 - 상태코드 : 반품완료 */
	public static final String CIS_API_SELECT_RTNS_STAT_CD_03 = "03";
	/** SHOP 반품 조회 - 상태코드 : 반품취소 */
	public static final String CIS_API_SELECT_RTNS_STAT_CD_99 = "99";
	
	/** 도착지 코드 */
	public static final String CIS_API_ARRV_CD_AP = "aboutPet";
	/** 출고 유형 코드 - 온라인 */
	public static final String CIS_API_DREL_TP_CD_SO1 = "SO1";
	/** 단위 - EA */
	public static final String CIS_API_UNIT_NM_EA = "EA";
	
	public static final String CIS_API_CONTENT_TP_JSON = "application/json;charset=utf-8";
	public static final String CIS_API_CONTENT_TP_XML = "application/xml";
	public static final String CIS_API_CONTENT_TP_MULTIPART = "multipart/form-data;charset=UTF-8";
	public static final String CIS_API_CONTENT_TP_TEXT = "text/xml;charset=UTF-8";

	public static final String CIS_API_RES_JSON = "json";
	public static final String CIS_API_RES_XML = "xml";
	
	public static final String CIS_API_SUCCESS_CD = "0000";
	public static final String CIS_API_FAIL_CD = "9999";
	public static final String CIS_API_FAIL_CD_0028 = "0028";
	public static final String CIS_API_EXCEPT = "E999";
	
	public static final String CIS_API_SUCCESS_HTTP_STATUS_CD = "200";
	

	/** 펫로그 신고사유 */
	public static final String RPTP_RSN = "RPTP_RSN";
	/** 광고성 스팸 */
	public static final String RPTP_RSN_10 = "10";	
	/** 부적절한 콘텐츠 */
	public static final String RPTP_RSN_20 = "20";				
	public static final String RPTP_RSN_30 = "30";
	
	/** 컨텐츠 유형 코드 */
	public static final String CONTS_TP = "CONTS_TP";

	/** 썸네일 */
	public static final String CONTS_TP_10 = "10";
	/** 상단 노출 이미지 */
	public static final String CONTS_TP_20 = "20";
	/** 웹툰 */
	public static final String CONTS_TP_30 = "30";
	/** 큰 배너 */
	public static final String CONTS_TP_40 = "40";
	/** 작은 배너 */
	public static final String CONTS_TP_50 = "50";
	/** 영상 */
	public static final String CONTS_TP_60 = "60";
	/** 썸네일 영상 */
	public static final String CONTS_TP_70 = "70";
	/** PC 배너 */
	public static final String CONTS_TP_80 = "80";
	/** 썸네일 다운로드 URL */
	public static final String CONTS_TP_90 = "90";
	

	/****************************
	 * PETRA
	 ****************************/
	/** Client Program */
	public static final String PETRA_CLIENT_PROGRAM = "APET";
	public static final String PETRA_ONE_WAY = "200";
	public static final String PETRA_TWO_WAY = "100";
	/** 아이콘 코드 */
	public static final String GOODS_ICON = "GOODS_ICON";
	
	public static final String GOODS_ICON_MDRC = "MDRC";

	/****************************
	 * 개인정보 접속 이력
	 ****************************/

	/*컬럼 구분 코드*/
	public static final String COL_GB_CD = "COL_GB_CD";

	/** 전체*/
	public static final String COL_GB_00 = "00";
	/** 전화 번호*/
	public static final String COL_GB_10 = "10";
	/** 회원 상태*/
	public static final String COL_GB_20 = "20";
	/** 배송지 */
	public static final String COL_GB_30 = "40";

	/*개인정보 조회  행위 구분 코드*/
	public static final String INQR_GB_CD = "INQR_GB_CD";

	/** 열람(개인정보 해제)*/
	public static final String INQR_GB_10 = "10";
	/** 수정*/
	public static final String INQR_GB_20 = "20";
	/** 삭제*/
	public static final String INQR_GB_30 = "30";
	/** 열람 */
	public static final String INQR_GB_40 = "40";
	/** 인쇄 */
	public static final String INQR_GB_50 = "50";
	/** 다운로드 */
	public static final String INQR_GB_60 = "60";
	/** 입력 */
	public static final String INQR_GB_70 = "70";

	
	
	/** 상태 코드 */
	public static final String STAT = "STAT";
	
	/** 정상 */
	public static final String STAT_10 = "10";
	/** 정지 */
	public static final String STAT_20 = "20";
	

	/**이용 약관 구분 코드*/
	public static final String TERMS_GB = "TERMS_GB";
	/** GS리테일 */
	public static final String TERMS_GB_GSR = "10";
	/** GS리테일-회원 */
	public static final String TERMS_GB_GSR_MEM = "101";
	/** GS리테일-회원 -이용약관*/
	public static final String TERMS_GB_GSR_MEM_TERM = "1001";
	/** GS리테일-회원 -개인정보처리방침*/
	public static final String TERMS_GB_GSR_MEM_PRIVACY = "1002";
	/** GS리테일-회원 -선택 개인정보 제3자 제공*/
	public static final String TERMS_GB_GSR_MEM_THIRD_CHC = "1003";
	/** GS리테일-회원 -필수 개인정보 제3자 제공(aboutPet)*/
	public static final String TERMS_GB_GSR_MEM_THIRD_REQ_ABP = "1004";
	
	
	/** 어바웃펫*/
	public static final String TERMS_GB_ABP = "20";
	/** 어바웃펫-회원 */
	public static final String TERMS_GB_ABP_MEM = "201";
	/** 어바웃펫-회원 -이용약관*/
	public static final String TERMS_GB_ABP_MEM_TERM = "2001";
	/** 어바웃펫-회원 -개인정보처리방침*/
	public static final String TERMS_GB_ABP_MEM_PRIVACY = "2002";
	/** 어바웃펫-회원 -위치 정보 동의*/
	public static final String TERMS_GB_ABP_MEM_LOCATION_INFO = "2003";
	/** 어바웃펫-회원 -필수 개인정보 제3자 제공(네이버)*/
	public static final String TERMS_GB_ABP_MEM_THIRD_REQ_NAVER = "2004";
	/** 어바웃펫-회원 -필수 개인정보 제3자 제공(GS리테일)*/
	public static final String TERMS_GB_ABP_MEM_THIRD_REQ_GSR = "2005";
	/** 어바웃펫-회원 -마케팅정보 수신 동의*/
	public static final String TERMS_GB_ABP_MEM_MARKETING = "2006";
	/** 어바웃펫-결제 */
	public static final String TERMS_GB_ABP_PAY = "102";
	/** 어바웃펫-결제 -개인정보 수집 및 이용 동의*/
	public static final String TERMS_GB_ABP_PAY_PRIVACY_SKTMP = "2011";
	/** 어바웃펫-결제 -제3자 제공 동의 */
	public static final String TERMS_GB_ABP_PAY_THIRD_REQ_SKTMP = "2012";
	
	
	/** 네이버*/
	public static final String TERMS_GB_NAVER = "30";
	/** 네이버-회원 */
	public static final String TERMS_GB_NAVER_MEM = "301";
	/** 네이버-회원 -선택 개인정보 제 3자 제공*/
	public static final String TERMS_GB_NAVER_MEM_THIRD_CHC = "3001";
	/** 네이버-회원 -필수 개인정보 제 3자 제공(aboutPet)*/
	public static final String TERMS_GB_NAVER_MEM_THIRD_REQ_ABP = "3002";

	//삭제할 것.
	/*선택 개인정보의 수집이용*/
	public static final String TERMS_GB_20 = "20";
	/*필수 개인정보의 수집 이용*/
	public static final String TERMS_GB_30 = "30";
	/*선택 마케팅정보 수신 동의*/
	public static final String TERMS_GB_40 = "40";
	/*선택 개인정보 제 3자 제공(GSR)*/
	public static final String TERMS_GB_50 = "50";
	/*필수 개인정보 제 3자 제공(GSR)*/
	public static final String TERMS_GB_60 = "60";
	/*선택 개인정보 제 3자 제공(NAVER)*/
	public static final String TERMS_GB_70 = "70";
	/*필수 개인정보 제 3자 제공(NAVER)*/
	public static final String TERMS_GB_80 = "80";
	/*필수 개인정보 처리 업무 위탁*/
	public static final String TERMS_GB_90 = "90";
	/*이용 약관*/
	public static final String TERMS_GB_100 = "100";

	
	
	/** 템플릿 - 시스템 코드 관련 공통 코드 */
	public static final String SYS_GB_CD = "SYS_GB_CD";

	/** 이용약관 관련 (마케팅,개인정보 등)*/
	public static final String SYS_GB_CD_TMPL = "SYS_TMPL";
	/** 휴면 안내 */
	public static final String SYS_GB_CD_SLEEP = "SYS_SLEEP";
	/** 데이터 3법 */
	public static final String SYS_GB_CD_DATA_LAW = "SYS_DTL";
	/** 데이터 3법 : 개인정보 */
	public static final String DATA_LAW_PERSONAL_INFO = "_001";
	/** 데이터 3법 : 신용정보 */
	public static final String DATA_LAW_CREDIT = "_002";
	/** 데이터 3법 : 정보 통신망법 */
	public static final String DATA_LAW_INFO_CMNC = "_003";
	/** 회원 휴면 사전 알림 */
	public static final String SYS_MEMBER_DORMANT = "SYS_MEMBER_DORMANT";
	
	/****************************
	 * NICEPAY API
	 ****************************/
	
	/** 가상계좌 발급 요청 */
	public static final String NICEPAY_API_ID_IF_GET_VIRTUAL_ACCOUNT = "IF_GET_VIRTUAL_ACCOUNT";
	
	/** 예금주 성명 조회 */
	public static final String NICEPAY_API_ID_IF_CHECK_BANK_ACCOUNT = "IF_CHECK_BANK_ACCOUNT";
	
	/** 현금영수증 발급 요청 */
	public static final String NICEPAY_API_ID_IF_CASH_RECEIPT = "IF_CASH_RECEIPT";
	
	/** 승인 취소 요청 */
	public static final String NICEPAY_API_ID_IF_CANCEL_PROCESS = "IF_CANCEL_PROCESS";
	
	/** 무이자 정보 조회 */
	public static final String NICEPAY_API_ID_IF_INTEREST_FREE = "IF_INTEREST_FREE";

	/** 고정계좌 과오납 등록 */
	public static final String NICEPAY_API_ID_IF_REGIST_FIX_ACCOUNT = "IF_REGIST_FIX_ACCOUNT";

	public static final String NICEPAY_API_CONTENT_TP_FORM = "application/x-www-form-urlencoded;charset=EUC-KR";

	public static final String NICEPAY_API_RES_JSON = "json";

	public static final String NICEPAY_BILLING_MDA = "16";

	public static final String NICEPAY_BILLING_PAY_METHOD = "01";

	public static final String NICEPAY_BILLING_PAYMENT_SUCCESS = "3001";

	public static final String NICEPAY_BILLING_REGIST_SUCCESS = "F100";

	public static final String NICEPAY_BILLING_DELETE_SUCCESS = "F101";
	
	/** 무이자 정보 조회 - SID */
	public static final String NICEPAY_INTEREST_FREE_SID = "0201001";
	/** 무이자 정보 조회 - GUBUN : 요청*/
	public static final String NICEPAY_INTEREST_FREE_GUBUN_REQ = "S";

	/****************************
	 ** GSR API
	 ****************************/

	/** server url*/
	public static final String GSR_API_SYSTEM_CRM ="crm";									/* CRM */
	public static final String GSR_API_SYSTEM_INTERGRATE_MEMBER ="intergrate";				/*통합 회원 정보 시스템 : 사용 안함*/

	/** WSDL */
	public static final String GSR_WSDL_CUSTOMER = "gsr.customer.service";					/* {http://provider}CustomerService */
	public static final String GSR_WSDL_LOGIN = "gsr.login.service";						/* {http://provider}LoginService */
	public static final String GSR_WSDL_POINT = "gsr.point.service";						/* {http://provider}PointService */

	/** 서비스 이름*/
	public static final String GSR_INSERT_MEMBER = "insert_member"; 								/*회원 등록*/
	public static final String GSR_CHECK_JOIN_OR_UPDATE = "check_join_or_update"; 					/*회원 가입 가능 여부 및 수정*/
	public static final String GSR_SELECT_MEMBER = "select_member";									/*고객 정보 조회*/
	public static final String GSR_RECOVER_SEPARATE_MEMBER_STORAGE = "recover_separate_member";		/*회원 분리 보관 복원*/
	public static final String GSR_SAVE_MEMBER_POINT = "save_member_point";							/*포인트 적립 사용*/
	public static final String GSR_SELECT_MEMBER_POINT = "select_member_point";						/*고객 포인트 조회*/
	public static final String GSR_SELECT_MEMBER_CPOINT = "select_member_cpoint";					/*고객 카드 포인트 상세 조회*/

	/** Content-type */
	public static final String GSR_API_CONTENT_TP = "application/xml;charset=UTF-8";

	public static final String SGR_RESULT_ENCODING_STATE_SUCCESS = "SUCCESS";
	public static final String SGR_RESULT_ENCODING_STATE_READY = "READY";
	public static final String SGR_RESULT_ENCODING_STATE_PROGRESSING = "PROGRESSING";
	public static final String SGR_RESULT_ENCODING_STATE_FAILED = "FAILED";

	/** GSR 연동 코드 */
	public static final String GSR_LNK = "GSR_LNK";
	/** 회원 조회 */
	public static final String GSR_LNK_MBR_SELECT = "00";
	/** 회원 등록 */
	public static final String GSR_LNK_MBR_INSERT = "10";
	/** 회원 등록 여부 확인 */
	public static final String GSR_LNK_IS_JOIN = "20";
	/** GSR 포인트 조회 */
	public static final String GSR_LNK_POTIN_SELECT = "30";
	/** GSR 포인트 사용 */
	public static final String GSR_LNK_USE_POINT = "40";
	/** GSR 포인트 사용 취소 */
	public static final String GSR_LNK_USE_POINT_CANCEL = "50";
	/** GSR 포인트 적립 */
	public static final String GSR_LNK_ACCUM_POINT = "60";
	/** GSR 포인트 적립 취소 */
	public static final String GSR_LNK_ACCUM_POINT_CANCEL = "70";
	/** GSR 포인트 적립 - 펫로그 좋아요  */
	public static final String GSR_LNK_ACCUM_POINT_PET_LOG_LIKE = "80";
	/** GSR 포인트 적립 - 펫로그 후기 작성 시 */
	public static final String GSR_LNK_ACCUM_POINT_PET_LOG_REIVEW = "90";
	
	/** 포인트 사유 코드 */
	public static final String PNT_RSN = "PNT_RSN";

	/** 포인트 사유 코드 :  주문(확정/취소/반품등) */
	public static final String PNT_RSN_ORDER = "100";
	/** 포인트 사유 코드 :  펫로그(등록/삭제) */
	public static final String PNT_RSN_PET_LOG = "200";
	/** 포인트 사유 코드 :  좋아요 100 */
	public static final String PNT_RSN_LIKE_100 = "310";
	/** 포인트 사유 코드 :  좋아요 500 */
	public static final String PNT_RSN_LIKE_500 = "320";
	/** 포인트 사유 코드 :  좋아요 1000 */
	public static final String PNT_RSN_LIKE_1000 = "330";
	/** 포인트 사유 코드 :  이벤트 참여 */
	public static final String PNT_RSN_EVENT_JOIN = "410";
	/** 포인트 사유 코드 :  이벤트 당첨 */
	public static final String PNT_RSN_EVENT_DONE = "420";
	/** 포인트 사유 코드 :  상품평(등록/삭제) */
	public static final String PNT_RSN_REVIEW = "500";
	/** 포인트 사유 코드 :  기타 */
	public static final String PNT_RSN_ETC = "900";
	
	/** 연동 처리 여부 */
	public static final String LNK_SUCC_YN = "LNK_SUCC_YN";
	/** 연동 처리 여부 :  Y */
	public static final String LNK_SUCC_YN_Y = "Y";
	/** 연동 처리 여부 :  N */
	public static final String LNK_SUCC_YN_N= "N";
	
	
	/** 에러 처리 여부 */
	public static final String ERR_PRCS_SCSS_YN = "ERR_PRCS_SCSS_YN";
	/** 에러 처리 여부 :  Y */
	public static final String ERR_PRCS_SCSS_YN_Y = "Y";
	/** 에러 처리 여부 :  N */
	public static final String ERR_PRCS_SCSS_YN_N= "N";
	
	
	/****************************
	 * 마케팅 관리 - 이벤트
	 ****************************/

	/** 이벤트 유형 코드 */
	public static final String EVENT_TP = "EVENT_TP";

	/** 이벤트 유형 코드 : 기본형*/
	public static final String EVENT_TP_10 = "10";
	/** 이벤트 유형 코드 : 응모형 */
	public static final String EVENT_TP_20 = "20";

	/** 이벤트 타입 코드 */
	public static final String EVENT_GB2_CD = "EVENT_GB2_CD";

	/** 이벤트 타입 코드 : 전체 */
	public static final String EVENT_GB2_CD_10 = "10";
	/** 이벤트 타입 코드  : 펫 tv*/
	public static final String EVENT_GB2_CD_20 = "20";
	/** 이벤트 타입 코드  : 펫 로그 */
	public static final String EVENT_GB2_CD_30 = "30";
	/** 이벤트 타입 코드  : 펫 샵 */
	public static final String EVENT_GB2_CD_40 = "40";

	/** 이벤트 상태 코드 */
	public static final String EVENT_STAT = "EVENT_STAT";
	/** 승인전 */
	public static final String EVENT_STAT_10 = "10";
	/** 진행중 */
	public static final String EVENT_STAT_20 = "20";
	/** 중단 */
	public static final String EVENT_STAT_30 = "30";
	/** 종료 */
	public static final String EVENT_STAT_40 = "40";

	/** 이벤트 수집 항목*/
	public static final String EVENT_CLCT_ITEM_CD = "EVENT_CLCT_ITEM_CD";

	/** 이름 */
	public static final String EVENT_CLCT_ITEM_NAME = "10";
	/** 연락처 */
	public static final String EVENT_CLCT_ITEM_TEL= "20";
	/** 이메일 */
	public static final String EVENT_CLCT_ITEM_EMAIL = "30";
	/** 집주소 */
	public static final String EVENT_CLCT_ITEM_ADDR = "40";
	/** SNS 게시물 URL*/
	public static final String EVENT_CLCT_ITEM_SNS = "50";

	/** 이벤트 추가 필드 유형 코드 */
	public static final String FLD_TP_CD = "FLD_TP_CD";
	/** 한줄 입력 */
	public static final String FLD_TP_CD_10 = "10";
	/** 여러줄 입력 */
	public static final String FLD_TP_CD_20 = "20";
	/** 라디오 버튼 */
	public static final String FLD_TP_CD_30 = "30";
	/** 체크 박스 */
	public static final String FLD_TP_CD_40 = "40";
	/** 셀렉트 박스 */
	public static final String FLD_TP_CD_50 = "50";
	/** 첨부파일 */
	public static final String FLD_TP_CD_60 = "60";
	/** 이미지 삽입 */
	public static final String FLD_TP_CD_70 = "70";


	/** 이벤트 퀴즈 구분 코드 */
	public static final String QST_TP_CD = "QST_TP_CD";
	/** 객관식 체크 박스 */
	public static final String QST_TP_10 = "10";
	/** 객관식 라디오 버튼 */
	public static final String QST_TP_20 = "20";
	/** 주관식 */
	public static final String QST_TP_30 = "30";

	/****************************
	 * CIS 거래처 관련
	 ****************************/
	public static final String CIS_IF_REQ = "전송";
	public static final String CIS_IF_RES = "응답완료";
	
	/** 거래처 유형 : 자사 */
	public static final String PRNT_TP_CD_MC = "MC";
	/** 거래처 유형 : 위탁사 */
	public static final String PRNT_TP_CD_CS = "CS";
	/** 거래처 유형 : 매입사 */
	public static final String PRNT_TP_CD_VD = "VD";
	/** 거래처 유형 : 배송사 */
	public static final String PRNT_TP_CD_CT = "CT";
	
	/** 상태 코드 : 정상 */
	public static final String STAT_CD_N = "N";
	/** 상태 코드 : 미사용 */
	public static final String STAT_CD_D = "D";
	
	/** 화주 코드 : 펫츠비 */
	public static final String OWNR_CD_PB = "PB";
	
	/** 거래 상태 : 거래중 */
	public static final String TRD_STAT_CD_10 = "10";
	/** 거래 상태 : 거래중단 */
	public static final String TRD_STAT_CD_20 = "20";

	/** 관심 태그*/
	public static final String INT_TAG_INFO_CD = "INT_TAG_INFO_CD";

	/** 강아지*/
	public static final String INT_TAG_INFO_DOG = "T000000009";
	/** 사료*/
	public static final String INT_TAG_INFO_FEED = "T000000010";
	/** 참치*/
	public static final String INT_TAG_INFO_TUNA = "T000000011";
	/** 관절*/
	public static final String INT_TAG_INFO_JOINT = "T000000012";
	/** 하네스*/
	public static final String INT_TAG_INFO_HARNESS = "T000000013";
	/** 건강관리*/
	public static final String INT_TAG_INFO_HEALTH = "T000000014";
	/** 배변패드*/
	public static final String INT_TAG_INFO_TOILET_PAD = "T000000016";
	/** 애견간식*/
	public static final String INT_TAG_INFO_PET_SNACK = "T000000018";
	/** 육포*/
	public static final String INT_TAG_INFO_JERKY = "T000000021";
	/** 닭가슴살*/
	public static final String INT_TAG_INFO_CK_BREAST = "T000000023";

	/****************************
	 * 검색 API
	 ****************************/
	/** 통합검색 */
	public static final String SRCH_API_ID_SEARCH = "search";
	public static final String SRCH_API_URL_SEARCH = "search.search.url.total";
	/** 자동완성 */
	public static final String SRCH_API_ID_AUTOCOMPLETE = "autocomplete";
	public static final String SRCH_API_URL_AUTOCOMPLETE = "search.search.url.autocomplete";
	/** 인기검색어 */
	public static final String SRCH_API_ID_POPQUERY = "autocomplete";
	public static final String SRCH_API_URL_POPQUERY = "search.search.url.popquery";
	/** 추천검색어 */
	public static final String SRCH_API_ID_RECOMMEND_KEYWORD = "autocomplete";
	public static final String SRCH_API_URL_RECOMMEND_KEYWORD = "search.search.url.recommend_keyword";
	/** 상품 상세검색 상세조건 및 브랜드 집계 */
	public static final String SRCH_API_ID_GOODS_FILTER_AGGREGATION = "aggregate goods";
	public static final String SRCH_API_URL_GOODS_FILTER_AGGREGATION = "search.search.url.aggregate_goods";	
	/** 추천(TV/LOG/SHOP/해쉬태그/사용자) */
	public static final String SRCH_API_ID_RECOMMEND = "recommend";
	public static final String SRCH_API_URL_RECOMMEND = "search.search.url.recommend";
	/** 추천일치율 */
	public static final String SRCH_API_URL_RECOMMENDRATE = "search.search.url.recommendRate";
	
	/** 관심태그변경 로그 등록*/
	public static final String SRCH_API_ID_ACTION_KEYWORD = "actionLog";
	public static final String SRCH_API_URL_ACTION= "search.log.url.action";

	/** 상품 수령 위치 */
	public static final String GOODS_RCV_PST = "GOODS_RCV_PST";
	/** 상품 수령 위치 : 문앞 */
	public static final String GOODS_RCV_PST_10 = "10";
	/** 상품 수령 위치 : 택배함 */
	public static final String GOODS_RCV_PST_20 = "20";
	/** 상품 수령 위치 : 경비실 */
	public static final String GOODS_RCV_PST_30 = "30";
	/** 상품 수령 위치 : 기타 */
	public static final String GOODS_RCV_PST_40 = "40";

	/** 공동 현관 비밀번호 */
	public static final String PBL_GATE_ENT_MTD = "PBL_GATE_ENT_MTD";
	/** 공동 현관 비밀번호 : 공동현관 비밀번호 입력 */
	public static final String PBL_GATE_ENT_MTD_10 = "10";
	/** 공동 현관 비밀번호 : 경비실 호출 */
	public static final String PBL_GATE_ENT_MTD_20 = "20";
	/** 공동 현관 비밀번호 : 필요 없음 */
	public static final String PBL_GATE_ENT_MTD_30 = "30";

	/****************************
	 * 검색어 자동완성
	 ****************************/
	/** 통합검색 */
	public static final String SEARCH_AUTO_COMPLETE_LABEL_TOTAL = "total_search";
	
	/** 해쉬태그 */
	public static final String SEARCH_AUTO_COMPLETE_LABEL_TAG = "pet_log_autocomplete";
	
	/****************************
	 * 반려동물 검색어 자동완성
	 ****************************/
	/** 강아지 */
	public static final String SEARCH_AUTO_COMPLETE_LABEL_DOG = "dog_name_autocomplete";
	/** 고양이 */
	public static final String SEARCH_AUTO_COMPLETE_LABEL_CAT = "cat_name_autocomplete";
	
	/** 시리즈 광고 노출 여부 */
	public static final String AD_YN = "AD_YN";
	/** 노출 */
	public static final String AD_YN_Y = "Y";			
	/** 미노출 */
	public static final String AD_YN_N = "N";

	/****************************
	 * 업체 담당자 
	 ****************************/
	public static final String COMP_CHRG_TP = "COMP_CHRG_TP";
	/** 기본 */
	public static final String COMP_CHRG_TP_10 = "10";
	/** 거래 */
	public static final String COMP_CHRG_TP_20 = "20";
	/** CS */
	public static final String COMP_CHRG_TP_30 = "30";
	/** 정산 */
	public static final String COMP_CHRG_TP_40 = "40";
	

	/****************************
	 * 네이버 PUSH 타입
	 ****************************/
	/** 기본 */
	public static final String PUSH_TYPE_DEFAULT = "default";
	/** 안드로이드 */
	public static final String PUSH_TYPE_ANDROID = "gcm";
	/** IOS */
	public static final String PUSH_TYPE_IOS = "apns";
	/** 네이버 PUSH 결과 코드 */
	public static final String PUSH_RESULT_SUCCESS = "202";
	
	
	/** image optimizer rule query string */
	public static final String IMG_OPT_QRY = "IMG_OPT_QRY";
	/** image optimizer rule query string : 배너 - type=m&w=244&h=137&quality=90&bgcolor=FFFFFF&extopt=3 */
	public static final String IMG_OPT_QRY_10 = "10";
	/** image optimizer rule query string : 배너 - type=m&w=388&h=188&quality=90&bgcolor=FFFFFF&extopt=3 */
	public static final String IMG_OPT_QRY_20 = "20";
	/** image optimizer rule query string : 상품 - type=m&w=178&h=178&quality=90&bgcolor=FFFFFF&extopt=3 */
	public static final String IMG_OPT_QRY_30 = "30";
	/** image optimizer rule query string : 배너 - type=m&w=750&h=176&quality=90&bgcolor=FFFFFF&extopt=3 */
	public static final String IMG_OPT_QRY_40 = "40";
	/** image optimizer rule query string : 배너 - type=m&w=650&h=472&quality=90&bgcolor=FFFFFF&extopt=3 */
	public static final String IMG_OPT_QRY_50 = "50";
	/** image optimizer rule query string : 상품 - type=m&w=70&h=70&quality=90&bgcolor=FFFFFF&extopt=3 */
	public static final String IMG_OPT_QRY_60 = "60";
	/** image optimizer rule query string : 상품 - type=f&w=490&h=279&quality=90&align=4 */
	public static final String IMG_OPT_QRY_70 = "70";
	/** image optimizer rule query string : 배너 - type=m&w=404&h=227&quality=90&bgcolor=FFFFFF&extopt=3 */
	public static final String IMG_OPT_QRY_80 = "80";
	/** image optimizer rule query string : 배너 - type=m&w=375&h=211&quality=90&bgcolor=FFFFFF&extopt=3 */
	public static final String IMG_OPT_QRY_90 = "90";
	/** image optimizer rule query string : 배너 - type=m&w=750&h=422&quality=90&bgcolor=FFFFFF&extopt=3 */
	public static final String IMG_OPT_QRY_100 = "100";
	/** image optimizer rule query string : 상품 - type=m&w=280&h=280&quality=90&bgcolor=FFFFFF&extopt=3 */
	public static final String IMG_OPT_QRY_110 = "110";
	/** image optimizer rule query string : 배너 - type=m&w=460&h=296&quality=90&bgcolor=FFFFFF&extopt=3 */
	public static final String IMG_OPT_QRY_120 = "120";
	/** image optimizer rule query string : 배너 - type=m&w=325&h=236&quality=90&bgcolor=FFFFFF&extopt=3 */
	public static final String IMG_OPT_QRY_130 = "130";
	/** image optimizer rule query string : 배너 - type=m&w=750&h=362&quality=90&bgcolor=FFFFFF&extopt=3 */
	public static final String IMG_OPT_QRY_140 = "140";
	/** image optimizer rule query string : 배너 - type=m&w=388&h=218&quality=90&bgcolor=FFFFFF&extopt=3 */
	public static final String IMG_OPT_QRY_150 = "150";
	/** image optimizer rule query string : 상품 - type=m&w=317&h=317&quality=90&bgcolor=FFFFFF&extopt=3 */
	public static final String IMG_OPT_QRY_160 = "160";
	/** image optimizer rule query string : 상품 - type=m&w=375&h=375&quality=90&bgcolor=FFFFFF&extopt=3 */
	public static final String IMG_OPT_QRY_170 = "170";
	/** image optimizer rule query string : 배너 - type=m&w=388&h=236&quality=90&bgcolor=FFFFFF&extopt=3 */
	public static final String IMG_OPT_QRY_180 = "180";
	/** image optimizer rule query string : 배너 - type=m&w=375&h=181&quality=90&bgcolor=FFFFFF&extopt=3 */
	public static final String IMG_OPT_QRY_190 = "190";
	/** image optimizer rule query string : 배너 - type=m&w=677&h=381&quality=90&bgcolor=FFFFFF&extopt=3 */
	public static final String IMG_OPT_QRY_200 = "200";
	/** image optimizer rule query string : 상품 - type=m&w=500&h=500&quality=90&bgcolor=FFFFFF&extopt=3 */
	public static final String IMG_OPT_QRY_210 = "210";
	/** image optimizer rule query string : 상품 - type=m&w=90&h=90&quality=90&bgcolor=FFFFFF&extopt=3 */
	public static final String IMG_OPT_QRY_220 = "220";
	/** image optimizer rule query string : LIVE 317X178 - type=m&w=317&h=178&quality=90&bgcolor=FFFFFF&extopt=3 */
	public static final String IMG_OPT_QRY_230 = "230";
	/** image optimizer rule query string : 상품 - type=f&w=375&h=214&quality=90&align=4 */
	public static final String IMG_OPT_QRY_240 = "240";
	/** image optimizer rule query string : 상품 - type=m&w=120&h=120&quality=90&bgcolor=FFFFFF&extopt=3 */
	public static final String IMG_OPT_QRY_250 = "250";
	/** image optimizer rule query string : 배너 - type=m&w=375&h=340&quality=90&bgcolor=FFFFFF&extopt=3 */
	public static final String IMG_OPT_QRY_260 = "260";
	/** image optimizer rule query string : 상품 - type=m&w=160&h=160&quality=90&bgcolor=FFFFFF&extopt=3 */
	public static final String IMG_OPT_QRY_270 = "270";
	/** image optimizer rule query string : 배너 - type=m&w=1010&h=360&quality=90&bgcolor=FFFFFF&extopt=3 */
	public static final String IMG_OPT_QRY_280 = "280";
	/** image optimizer rule query string : 배너 - type=m&w=335&h=162&quality=90&bgcolor=FFFFFF&extopt=3 */
	public static final String IMG_OPT_QRY_290 = "290";
	/** image optimizer rule query string : 배너 - type=m&w=750&h=680&quality=90&bgcolor=FFFFFF&extopt=3 */
	public static final String IMG_OPT_QRY_300 = "300";
	/** image optimizer rule query string : 배너 - type=m&w=1200&h=94&quality=90&bgcolor=FFFFFF&extopt=3 */
	public static final String IMG_OPT_QRY_310 = "310";
	/** image optimizer rule query string : 배너 - type=m&w=1200&h=250&quality=90&bgcolor=FFFFFF&extopt=3 */
	public static final String IMG_OPT_QRY_320 = "320";
	/** image optimizer rule query string : 배너 - type=f&w=375&h=88&quality=90&align=4 */
	public static final String IMG_OPT_QRY_330 = "330";
	/** image optimizer rule query string : 상품 - type=m&w=230&h=230&quality=90&bgcolor=FFFFFF&extopt=3 */
	public static final String IMG_OPT_QRY_340 = "340";
	/** image optimizer rule query string : 배너 - type=m&w=1200&h=226&quality=90&bgcolor=FFFFFF&extopt=3 */
	public static final String IMG_OPT_QRY_350 = "350";
	/** image optimizer rule query string : 통장사본 - type=m&w=1188&h=1682&quality=95&bgcolor=FFFFFF&extopt=3 */
	public static final String IMG_OPT_QRY_360 = "360";
	/** image optimizer rule query string : 회원 사진 - type=m&w=720&h=720&quality=95&bgcolor=FFFFFF&extopt=3 */
	public static final String IMG_OPT_QRY_370 = "370";
	/** image optimizer rule query string : 사업자 등록증 - type=m&w=1440&h=2560&quality=95&bgcolor=FFFFFF&extopt=3 */
	public static final String IMG_OPT_QRY_380 = "380";
	/** image optimizer rule query string : 이벤트 배너 - type=m&w=1440&h=810&quality=95&bgcolor=FFFFFF&extopt=3 */
	public static final String IMG_OPT_QRY_390 = "390";
	/** image optimizer rule query string : BO 대표 썸네일 - type=m&w=200&h=160&quality=95&bgcolor=FFFFFF&extopt=3 */
	public static final String IMG_OPT_QRY_400 = "400";
	/** image optimizer rule query string : BO 영상 썸네일 - type=m&w=100&h=100&quality=95&bgcolor=FFFFFF&extopt=3 */
	public static final String IMG_OPT_QRY_410 = "410";
	/** image optimizer rule query string : BO 상단노출이미지 - type=m&w=108&h=88&quality=95&bgcolor=FFFFFF&extopt=3 */
	public static final String IMG_OPT_QRY_420 = "420";
	/** image optimizer rule query string : FO TV상세추천썸네일 - type=m&w=130&h=73&quality=95&bgcolor=FFFFFF&extopt=3 */
	public static final String IMG_OPT_QRY_430 = "430";
	/** image optimizer rule query string : FO 펫로그 이미지 - type=m&w=600&h=799&quality=90&bgcolor=FFFFFF&extopt=3 */
	public static final String IMG_OPT_QRY_440 = "440";
	/** image optimizer rule query string : FO 펫로그 이미지 - type=m&w=355&h=446&quality=90&bgcolor=FFFFFF&extopt=3 */
	public static final String IMG_OPT_QRY_450 = "450";
	/** image optimizer rule query string : FO 펫로그 이미지 - type=m&w=188&h=250&quality=90&bgcolor=FFFFFF&extopt=3 */
	public static final String IMG_OPT_QRY_460 = "460";
	/** image optimizer rule query string : FO 펫로그 이미지 - type=m&w=226&h=270&quality=90&bgcolor=FFFFFF&extopt=3 */
	public static final String IMG_OPT_QRY_470 = "470";
	/** image optimizer rule query string : FO 펫로그 목록 이미지 - type=f&w=227&h=227&quality=90&align=4 */
	public static final String IMG_OPT_QRY_480 = "480";
	/** image optimizer rule query string : FO 펫로그 목록 이미지 - type=f&w=124&h=124&quality=90&align=4 */
	public static final String IMG_OPT_QRY_490 = "490";
	/** image optimizer rule query string : FO 펫로그 목록 이미지 - type=f&w=259&h=259&quality=90&align=4 */
	public static final String IMG_OPT_QRY_500 = "500";
	/** image optimizer rule query string : FO 펫로그 목록 이미지 - type=f&w=288&h=288&quality=90&align=4 */
	public static final String IMG_OPT_QRY_510 = "510";
	/** image optimizer rule query string : FO 펫로그 목록 이미지 - type=f&w=50&h=50&quality=90&align=4 */
	public static final String IMG_OPT_QRY_520 = "520";
	/** image optimizer rule query string : FO 펫로그 목록 이미지 - type=f&w=84&h=84&quality=90&align=4 */
	public static final String IMG_OPT_QRY_530 = "530";
	/** image optimizer rule query string : FO 펫로그 목록 이미지 - type=f&w=150&h=150&quality=90&align=4 */
	public static final String IMG_OPT_QRY_540 = "540";
	/** image optimizer rule query string : FO 펫TV 댓글 프로필 이미지 - type=f&w=28&h=28&quality=90&align=4 */
	public static final String IMG_OPT_QRY_550 = "550";
	/** image optimizer rule query string : FO SNS 공유하기 - type=f&w=800&h=400&quality=90&align=4 */
	public static final String IMG_OPT_QRY_560 = "560";
	/** image optimizer rule query string : FO 최근 본 영상 썸네일 - type=m&w=288&h=167&quality=90&bgcolor=FFFFFF&extopt=3 */
	public static final String IMG_OPT_QRY_570 = "570";
	/** image optimizer rule query string : pc 배너 - type=m&w=1010&h=210&quality=90&bgcolor=FFFFFF&extopt=3 */
	public static final String IMG_OPT_QRY_580 = "580";
	/** image optimizer rule query string : pc 상품 - type=m&w=201&h=201&quality=90&bgcolor=FFFFFF&extopt=3 */
	public static final String IMG_OPT_QRY_590 = "590";
	/** image optimizer rule query string : mo 상품 - type=m&w=111&h=111&quality=90&bgcolor=FFFFFF&extopt=3 */
	public static final String IMG_OPT_QRY_600 = "600";
	/** image optimizer rule query string : pc 상품 - ?type=m&w=216&h=216&quality=90&bgcolor=FFFFFF&extopt=3 */
	public static final String IMG_OPT_QRY_610 = "610";
	/** image optimizer rule query string : pc 배너 - type=m&w=1010&h=94&quality=90&bgcolor=FFFFFF&extopt=3 */
	public static final String IMG_OPT_QRY_620 = "620";
	/** image optimizer rule query string : pc 배너 - type=f&w=1010&h=80&quality=90&align=4 */
	public static final String IMG_OPT_QRY_630 = "630";
	/** image optimizer rule query string : 로그게시물 이미지(MO) - type=f&w=335&h=446&quality=90&align=4 */
    public static final String IMG_OPT_QRY_640 = "640";
    /** image optimizer rule query string : 로그게시물 이미지(PC) - type=f&w=600&h=799&quality=90&align=4 */
    public static final String IMG_OPT_QRY_650 = "650";
    /** image optimizer rule query string : 일반기획전 배너(MO) - type=f&w=335&h=162&quality=90&align=4 */
    public static final String IMG_OPT_QRY_660 = "660";
    /** image optimizer rule query string : 일반기획전 배너(PC) - type=f&w=1010&h=210&quality=90&align=4 */
    public static final String IMG_OPT_QRY_670 = "670";
    /** image optimizer rule query string : 일반기획전 상세 배너(MO) - type=f&w=375&h=181&quality=90&align=4 */
    public static final String IMG_OPT_QRY_680 = "680";
    /** image optimizer rule query string : 일반기획전 상세 배너(PC) - type=f&w=1200&h=250&quality=90&align=4 */
    public static final String IMG_OPT_QRY_690 = "690";
    /** image optimizer rule query string : 상품이미지섬네일 - type=f&w=70&h=70&quality=90&align=4 */
    public static final String IMG_OPT_QRY_700 = "700";
    /** image optimizer rule query string : 검색 시리즈 및 친구 - type=f&w=80&h=80&quality=90&align=4 */
    public static final String IMG_OPT_QRY_710 = "710";
    /** image optimizer rule query string : 검색 동영상 - type=f&w=288&h=167&quality=90&align=4 */
    public static final String IMG_OPT_QRY_720 = "720";
    /** image optimizer rule query string : 검색 게시물 - type=f&w=226&h=226&quality=90&align=4 */
    public static final String IMG_OPT_QRY_730 = "730";
    /** image optimizer rule query string : 검색 상품 - type=f&w=216&h=216&quality=90&align=4 */
    public static final String IMG_OPT_QRY_740 = "740";
    /** image optimizer rule query string : 모바일 띠배너 공통 - type=f&w=750&h=176&quality=100&align=4 */
	public static final String IMG_OPT_QRY_742 = "742";
	/** image optimizer rule query string : 모바일 샵 > 메인, 특별기획전 배너 - type=f&w=750&h=680&quality=100&align=4 */
	public static final String IMG_OPT_QRY_743 = "743";
	/** image optimizer rule query string : 모바일 샵 >  기획전, 기획전 상세, 진행중인이벤트 - type=f&w=750&h=362&quality=100&align=4 */
	public static final String IMG_OPT_QRY_744 = "744";
	/** image optimizer rule query string : 모바일 샵 > 카테고리 > 메인 배너, 모바일 TV > 펫스쿨 홈 배너(기본) - type=f&w=750&h=422&quality=100&align=4 */
	public static final String IMG_OPT_QRY_745 = "745";
	/** image optimizer rule query string : 모바일/PC TV > 최상단 배너 - type=f&w=650&h=472&quality=100&align=4 */
	public static final String IMG_OPT_QRY_746 = "746";
	/** image optimizer rule query string : 모바일 TV > 펫스쿨 홈 배너(작은배너) - type=f&w=750&h=176&quality=100&align=4 */
	public static final String IMG_OPT_QRY_747 = "747";	
	/** image optimizer rule query string : FO 펫로그 이미지 - type=f&w=188&h=250&quality=100&align=4 */
    public static final String IMG_OPT_QRY_748 = "748";  
    /** image optimizer rule query string : 677*381 시리즈홈 PC배너 - type=f&w=677&h=381&quality=100&align=4 */
    public static final String IMG_OPT_QRY_749 = "749";
    /** image optimizer rule query string : 288*167 시리즈홈 PC이미지 - type=f&w=288&h=167&quality=100&align=4 */
    public static final String IMG_OPT_QRY_750 = "750";
    /** image optimizer rule query string : 375*211 시리즈홈 MO배너 - type=f&w=375&h=211&quality=100&align=4 */
    public static final String IMG_OPT_QRY_751 = "751";
    /** image optimizer rule query string : 144*81 시리즈홈 MO이미지 - type=f&w=144&h=81&quality=100&align=4 */
    public static final String IMG_OPT_QRY_752 = "752";
    /** image optimizer rule query string : 244*137 시리즈목록 MO이미지 - type=f&w=244&h=137&quality=100&align=4 */
    public static final String IMG_OPT_QRY_753 = "753";
    /** image optimizer rule query string : 192*108 인기시리즈 MO이미지 - type=f&w=192&h=108&quality=100&align=4 */
    public static final String IMG_OPT_QRY_754 = "754";
    /** image optimizer rule query string : 250*141 인기시리즈 PC이미지 - type=f&w=250&h=141&quality=100&align=4 */
    public static final String IMG_OPT_QRY_755 = "755";
    /** image optimizer rule query string : 500*500 상품 상세(pc) : type=f&w=500&h=500&quality=90&align=4*/
    public static final String IMG_OPT_QRY_756 = "756";
    /** image optimizer rule query string : 360*360 상품 상세(mo) : type=f&w=360&h=360&quality=90&align=4*/
    public static final String IMG_OPT_QRY_757 = "757";
    /** image optimizer rule query string : 178*178 찜 리스트>펫샵 : type=f&w=178&h=178&quality=90&align=4*/
    public static final String IMG_OPT_QRY_758 = "758";
    /** image optimizer rule query string : 펫TV 홈 > 메인 배너(PC) - type=f&w=460&h=296&quality=100&align=4 */
    public static final String IMG_OPT_QRY_759 = "759";
    /** image optimizer rule query string : 펫TV 홈 > 메인 배너(MO) - type=f&w=920&h=592&quality=100&align=4 */
    public static final String IMG_OPT_QRY_760 = "760";
    /** image optimizer rule query string : 펫TV 홈 > 맟춤영상,인기영상,펫스쿨(PC) - type=f&w=244&h=137&quality=100&align=4 */
    public static final String IMG_OPT_QRY_761 = "761";
    /** image optimizer rule query string : 펫TV 홈 > 맟춤영상,인기영상,펫스쿨(MO) - type=f&w=488&h=274&quality=100&align=4 */
    public static final String IMG_OPT_QRY_762 = "762";
    /** image optimizer rule query string : 펫TV 홈 > 최근본영상(PC) - type=f&w=178&h=178&quality=100&align=4 */
    public static final String IMG_OPT_QRY_763 = "763";
    /** image optimizer rule query string : 펫TV 홈 > 최근본영상(MO) - type=f&w=356&h=356&quality=100&align=4 */
    public static final String IMG_OPT_QRY_764 = "764";
    /** image optimizer rule query string : 펫TV 홈 > 신규 영상(PC) - type=f&w=404&h=227&quality=100&align=4 */
    public static final String IMG_OPT_QRY_765 = "765";
    /** image optimizer rule query string : 펫TV 홈 > 신규 영상(MO) - type=f&w=808&h=454&quality=100&align=4 */
    public static final String IMG_OPT_QRY_766 = "766";
    /** image optimizer rule query string : 펫TV 홈 > 띠배너(PC) - type=f&w=1200&h=94&quality=100&align=4 */
    public static final String IMG_OPT_QRY_767 = "767";
    /** image optimizer rule query string : 펫TV 홈 > 관심 태그(PC) - type=f&w=288&h=167&quality=100&align=4 */
    public static final String IMG_OPT_QRY_768 = "768";
    /** image optimizer rule query string : 펫TV 홈 > 관심 태그(MO), 펫샵 카테고리 홈 > 상단배너(MO) - type=f&w=576&h=334&quality=100&align=4 */
    public static final String IMG_OPT_QRY_769 = "769";
    /** image optimizer rule query string : 펫TV 홈 > 오리지날배너(PC) - type=f&w=388&h=188&quality=100&align=4 */
    public static final String IMG_OPT_QRY_770 = "770";
    /** image optimizer rule query string : 펫TV 홈 > 오리지날배너(MO) - type=f&w=776&h=376&quality=100&align=4 */
    public static final String IMG_OPT_QRY_771 = "771";
    /** image optimizer rule query string : 펫로그 홈 > 이미지(PC) - type=f&w=600&h=799&quality=100&align=4 */
    public static final String IMG_OPT_QRY_772 = "772";
    /** image optimizer rule query string : 펫로그 홈 > 이미지(MO) - type=f&w=670&h=892&quality=100&align=4 */
    public static final String IMG_OPT_QRY_773 = "773";
    /** image optimizer rule query string : 펫로그 홈 > 띠배너(PC) - type=f&w=1200&h=94&quality=100&align=4 */
    public static final String IMG_OPT_QRY_774 = "774";
    /** image optimizer rule query string : 펫로그 홈 > 띠배너(MO) - type=f&w=750&h=176&quality=100&align=4 */
    public static final String IMG_OPT_QRY_775 = "775";
    /** image optimizer rule query string : 펫샵 홈 > 단독상품(PC) - type=f&w=490&h=279&quality=100&align=4 */
    public static final String IMG_OPT_QRY_776 = "776";
    /** image optimizer rule query string : 펫샵 홈 > 단독상품(MO) - type=f&w=750&h=428&quality=100&align=4 */
    public static final String IMG_OPT_QRY_777 = "777";
    /** image optimizer rule query string : 펫샵 카테고리 홈 > 상단배너(PC) - type=f&w=1010&h=360&quality=100&align=4 */
    public static final String IMG_OPT_QRY_778 = "778";
    /** image optimizer rule query string : 펫샵 이벤트 > 목록배너(PC) - type=f&w=1010&h=360&quality=100&align=4 */
    public static final String IMG_OPT_QRY_779 = "779";
    /** image optimizer rule query string : 마이찜리스트 > 영상 이미지(PC) - type=f&w=240&h=139&quality=100&align=4 */
    public static final String IMG_OPT_QRY_780 = "780";
    /** image optimizer rule query string : 마이찜리스트 > 영상 이미지(MO) - type=f&w=320&h=186&quality=100&align=4 */
    public static final String IMG_OPT_QRY_781 = "781";
    /** image optimizer rule query string : 마이찜리스트 > 펫스쿨(MO) - type=m&w=320&h=186&quality=100&bgcolor=000000&extopt=3 */
    public static final String IMG_OPT_QRY_782 = "782";
    /** image optimizer rule query string : 펫스쿨 영상 이미지(PC) - type=m&w=200&h=200&quality=100&bgcolor=FFFFFF&extopt=3 */
    public static final String IMG_OPT_QRY_783 = "783";
    /** image optimizer rule query string : 펫스쿨 영상 이미지(MO) - type=m&w=308&h=308&quality=100&bgcolor=FFFFFF&extopt=3 */
    public static final String IMG_OPT_QRY_784 = "784";
    /** image optimizer rule query string : 인기시리즈 프로필(PC) - type=f&w=72&h=72&quality=100&align=4 */
    public static final String IMG_OPT_QRY_785 = "785";
    /** image optimizer rule query string : 인기시리즈 프로필(MO) - type=f&w=144&h=144&quality=100&align=4 */
    public static final String IMG_OPT_QRY_786 = "786";
    /** image optimizer rule query string : 마이찜리스트 > 펫스쿨(PC) - type=m&w=240&h=139&quality=100&bgcolor=000000&extopt=3 */
    public static final String IMG_OPT_QRY_787 = "787";
    /** image optimizer rule query string : 배너 - type=m&w=408&h=296&quality=100&bgcolor=FFFFFF&extopt=3 */
	public static final String IMG_OPT_QRY_788 = "788";
	/** image optimizer rule query string : 배너 - type=m&w=650&h=472&quality=100&bgcolor=FFFFFF&extopt=3 */
	public static final String IMG_OPT_QRY_789 = "789";
	/** image optimizer rule query string : 배너(MO) - type=m&w=670&h=376&quality=100&bgcolor=FFFFFF&extopt=3 */
	public static final String IMG_OPT_QRY_790 = "790";
	/** image optimizer rule query string : 배너(PC) - type=m&w=388&h=218&quality=100&bgcolor=FFFFFF&extopt=3 */
	public static final String IMG_OPT_QRY_791 = "791";
	/** image optimizer rule query string : 배너 - type=m&w=750&h=176&quality=100&bgcolor=FFFFFF&extopt=3 */
	public static final String IMG_OPT_QRY_792 = "792";
	/** image optimizer rule query string : 펫 샵 홈 > 띠배너(PC) - type=f&w=1010&h=80&quality=100&align=4 */
    public static final String IMG_OPT_QRY_793 = "793";
    /** image optimizer rule query string : 720*720 상품 상세(mo) : type=f&w=720&h=720&quality=100&align=4*/
    public static final String IMG_OPT_QRY_794 = "794";
    /** image optimizer rule query string : 펫 샵 홈 > 띠배너(PC) - type=m&w=1010&h=80&quality=100&bgcolor=FFFFFF&extopt=3 */
    public static final String IMG_OPT_QRY_795 = "795";
    /** image optimizer rule query string : 검색 동영상-옵션변경 - type=m&w=288&h=167&quality=100&bgcolor=000000&extopt=3 */
    public static final String IMG_OPT_QRY_796 = "796";
    /** image optimizer rule query string : 공통>이벤트팝업 이미지 - type=f&w=320&h=372&quality=100&align=4 */
    public static final String IMG_OPT_QRY_797 = "797";
    
    	     
	/** 본인인증 성공 */
	public static final String CERT_OK = "B000";
	/** 본인인증 취소 */
	public static final String CERT_CANCEL = "B123";

	/** 사이트 구분 */
	public static final String SITE_GB_BO = "BO";
	public static final String SITE_GB_PO = "PO";


	/** 자동 지급 쿠폰(DB 설계 없이, 공통 코드로 관리 */
	public static final String AUTO_ISU_COUPON = "AUTO_ISU_COUPON";

	/** 회원 가입 시, 자동 지급 쿠폰 - 사용자 정의 1 : CP_NO (2021.03.08 - CP_NO : 156 */
	public static final String AUTO_ISU_COUPON_WELCOME = "WELCOME";
	/** 가입 초대 코드로 지인이 가입 시, 초대 코드를 전달해준 회원에게 지급 되는 쿠폰 - 사용자 정의 1 : CP_NO : 173 */
	public static final String AUTO_ISU_COUPON_LNK_REWARD = "LNKREWARD";
	/** 추천인에게 지급 되는 쿠폰 -> 추천인 입력하고 가입한 사람 및 추천 당한 사람한테 지급 되는 쿠폰 */
	public static final String AUTO_ISU_COUPON_LNK_REWARD2 = "LNKREWARD2";
	/** 마케팅 수신 여부 동의 시, 지급(이벤트에서 진행되는 쿠폰) */
	public static final String AUTO_ISU_COUPON_MARKETING = "MARKETING";
	/** 회원 생일 축하 쿠폰 - 사용자 정의1 : CP_NO : 187(BO) 77(STG) */
	public static final String AUTO_ISU_COUPON_BIRTHDAY = "BIRTHDAY";
	/** 최초 주문 감사 쿠폰 */
	public static final String AUTO_ISU_COUPON_FIRSTORDER = "FIRSTORDER";
	/** 두번째 주문 감사 쿠폰 */
	public static final String AUTO_ISU_COUPON_SECNDORDER = "SECNDORDER";
	/** 세번째 주문 감사 쿠폰 */
	public static final String AUTO_ISU_COUPON_THIRDORDER = "THIRDORDER";
	/** 회원가입 배송비 쿠폰1 */
	public static final String AUTO_ISU_COUPON_WELCOMTR1 = "WELCOMTR1";
	/** 회원가입 배송비 쿠폰2 */
	public static final String AUTO_ISU_COUPON_WELCOMTR2 = "WELCOMTR2";
	/** 회원가입 배송비 쿠폰3*/
	public static final String AUTO_ISU_COUPON_WELCOMTR3 = "WELCOMTR3";

	/** 회원 등급 지급 쿠폰 - 패밀리 */
	public static final String AUTO_ISU_COUPON_FAMILIY = "FAMILIY";

	/** 회원 등급 지급 쿠폰 - VIP */
	public static final String AUTO_ISU_COUPON_VIP1 = "VIP1";
	public static final String AUTO_ISU_COUPON_VIP2 = "VIP2";

	/** 회원 등급 지급 쿠폰 - VVIP */
	public static final String AUTO_ISU_COUPON_VVIP1 = "VVIP1";
	public static final String AUTO_ISU_COUPON_VVIP2 = "VVIP2";
	public static final String AUTO_ISU_COUPON_VVIP3 = "VVIP3";

	/** 이벤트 관련 자동 지급 쿠폰 */
	public static final String AUTO_ISU_COUPON_EVENT = "EVENT";

	/* image upload 성공 */
	public static final String IMG_UPLOAD_RESULT_SUCCESS = "SUCCESS";

	/** 080 수신 거부 변경 주체 코드 */
	public static final String CHG_ACTR_CD = "CHG_ACTR_CD";

	/** 080 시스템(네이버) */
	public static final String CHG_ACTR_080 = "S";
	/** 회원 본인 */
	public static final String CHG_ACTR_MBR = "M";
	/** 관리자 */
	public static final String CHG_ACTR_ADM = "A";
	
	/** CIS 등록 여부 */
	public static final String CIS_REG_YN = "CIS_REG_YN";
	/** 등록 */
	public static final String CIS_REG_YN_Y = "Y";
	/** 미등록 */
	public static final String CIS_REG_YN_N = "N";

	/** CRM 성별 구분 코드 - 남자*/
	public static final String GSR_GENDER_GB_CD_MAN = "M";
	/** CRM 성별 구분 코드 - 여자*/
	public static final String GSR_GENDER_GB_CD_WOMAN = "F";

	/** CRM 통신사 구분 코드 - SKT*/
	public static final String GSR_MOBILE_CD_SKT = "01";
	/** CRM 통신사 구분 코드 - KT*/
	public static final String GSR_MOBILE_CD_KT = "02";
	/** CRM 통신사 구분 코드 - LG*/
	public static final String GSR_MOBILE_CD_LG = "03";

	/** CRM 회원 상태 코드 - 01*/
	public static final String GSR_MEMBER_STATUS_CODE_01 = "01";
	/** CRM 회원 상태 코드 - 02*/
	public static final String GSR_MEMBER_STATUS_CODE_02 = "02";

	/** CRM 포인트 타입 - 적립*/
	public static final String GSR_POINT_TYPE_ACCUM = "A1";
	/** CRN 포인트 타입 - 사용*/
	public static final String GSR_POINT_TYPE_USE = "B1";

	/** CRM 적립 사용 구분 - 적립*/
	public static final String GSR_POINT_ACCUM = "1";
	/** CRM 적립 사용 구분 - 사용*/
	public static final String GSR_POINT_USE = "2";

	/** CRM 거래 구분 - 매출 */
	public static final String GSR_DEAL_SALED = "1";
	/** CRM 거래 구분 - 반환 */
	public static final String GSR_DEAL_RETURN = "2";

	// GSR HTTP 응답 코드
	/** 정상*/
	public static final String[] GSR_RST_OK = {"00000","R7000"};
	/** GS 홈쇼핑 회원 */
	public static final String GSR_HOME_SHOP_MEMBER = "R7008";
	/** 중복*/
	public static final String GSR_RST_DUPLICATE = "10003";
	/** 존재하지 않음 */
	public static final String GSR_RST_IS_NOT_EXISTS = "10029";
	/** 못 찾음*/
	public static final String GSR_RST_NOT_FOUND = "30018";
	/** 올바르지 않은 요청*/
	public static final String GSR_RST_BAD_REQUEST = "50002";
	/** 만 14세 미만은 가입할 수 없습니다.*/
	public static final String GSR_RST_LIMIT_AGE = "R7063";
	/**시스템 오류 */
	public static final String GSR_RST_SYSTEM_ERROR = "R7999";
	/**휴면 고객 */
	public static final String GSR_RST_DORMANT_MEMBER = "R7056";
	/**거래가 정상적으로 이루어지지 않앗습니다.  */
	public static final String GSR_RST_NOT_APPR_ORDER = "R7502";
	/** GS POINT INSERT ERROR*/
	public static final String GSR_RST_SAVE_POINT_ERROR = "1000";
	/** 응답 값이 없습니다.*/
	public static final String GSR_RST_NOT_RESPONSE = "00002";

	// PG 결제수단
	/** 결제수단 : 간편결제(카드 인증결제) */
	public static final String PAY_METHOD_CERT = "CERT";

	/** 결제수단 : 간편결제(카드, 카카오페이, PAYCO, 네이버페이) */
	public static final String PAY_METHOD_CARD = "CARD";

	/** 결제수단 : 가상결제 */
	public static final String PAY_METHOD_VBANK = "VBANK";

	/** 결제수단 : 실시간계좌이체 */
	public static final String PAY_METHOD_BANK = "BANK";
	
	
	
	/** 약관 POC 구분 코드 */
	public static final String TERMS_POC_GB = "TERMS_POC_GB";
	/** 약관 POC구분 코드 : web*/
	public static final String TERMS_POC_WEB = "10";	
	/** 약관 POC구분 코드 : 안드로이드*/
	public static final String TERMS_POC_ANDR = "20";		
	/** 약관 POC구분 코드 : IOS*/
	public static final String TERMS_POC_IOS = "30";
	/** 약관 POC구분 코드 : MO*/
	public static final String TERMS_POC_MO = "40";


	/** 원산지 코드 : BANGLADESH */
	public static final String ORIGIN_CD_110 = "110";
	/** 원산지 코드 : BRASIL */
	public static final String ORIGIN_CD_120 = "120";
	/** 원산지 코드 : CAMBODIA */
	public static final String ORIGIN_CD_130 = "130";
	/** 원산지 코드 : CHINA */
	public static final String ORIGIN_CD_140 = "140";
	/** 원산지 코드 : COLOMBIA */
	public static final String ORIGIN_CD_150 = "150";
	/** 원산지 코드 : Cyprus */
	public static final String ORIGIN_CD_160 = "160";
	/** 원산지 코드 : DOMINICAN REPUBLIC */
	public static final String ORIGIN_CD_170 = "170";
	/** 원산지 코드 : EL SALVADOR */
	public static final String ORIGIN_CD_180 = "180";
	/** 원산지 코드 : EU(유럽연합) */
	public static final String ORIGIN_CD_190 = "190";
	/** 원산지 코드 : HAITI */
	public static final String ORIGIN_CD_200 = "200";
	/** 원산지 코드 : HONDURAS */
	public static final String ORIGIN_CD_210 = "210";
	/** 원산지 코드 : HONG KONG */
	public static final String ORIGIN_CD_220 = "220";
	/** 원산지 코드 : imported */
	public static final String ORIGIN_CD_230 = "230";
	/** 원산지 코드 : INDIA */
	public static final String ORIGIN_CD_240 = "240";
	/** 원산지 코드 : INDONESIA */
	public static final String ORIGIN_CD_250 = "250";
	/** 원산지 코드 : Laos */
	public static final String ORIGIN_CD_260 = "260";
	/** 원산지 코드 : MEXICO */
	public static final String ORIGIN_CD_270 = "270";
	/** 원산지 코드 : New Zealand */
	public static final String ORIGIN_CD_280 = "280";
	/** 원산지 코드 : PARKISTAN */
	public static final String ORIGIN_CD_290 = "290";
	/** 원산지 코드 : PHILIPPINE */
	public static final String ORIGIN_CD_300 = "300";
	/** 원산지 코드 : PORTUGAL */
	public static final String ORIGIN_CD_310 = "310";
	/** 원산지 코드 : SALVADOR */
	public static final String ORIGIN_CD_320 = "320";
	/** 원산지 코드 : SIRLANKA */
	public static final String ORIGIN_CD_330 = "330";
	/** 원산지 코드 : TAIWAN */
	public static final String ORIGIN_CD_340 = "340";
	/** 원산지 코드 : THAILAND */
	public static final String ORIGIN_CD_350 = "350";
	/** 원산지 코드 : TURKEY */
	public static final String ORIGIN_CD_360 = "360";
	/** 원산지 코드 : U.S.A */
	public static final String ORIGIN_CD_370 = "370";
	/** 원산지 코드 : VIETNAM */
	public static final String ORIGIN_CD_380 = "380";
	/** 원산지 코드 : 강원도 */
	public static final String ORIGIN_CD_390 = "390";
	/** 원산지 코드 : 경기도 */
	public static final String ORIGIN_CD_400 = "400";
	/** 원산지 코드 : 경상도 */
	public static final String ORIGIN_CD_410 = "410";
	/** 원산지 코드 : 과테말라 */
	public static final String ORIGIN_CD_420 = "420";
	/** 원산지 코드 : 국내 */
	public static final String ORIGIN_CD_430 = "430";
	/** 원산지 코드 : 국내/수입 */
	public static final String ORIGIN_CD_440 = "440";
	/** 원산지 코드 : 국내산 */
	public static final String ORIGIN_CD_450 = "450";
	/** 원산지 코드 : 국내제조 */
	public static final String ORIGIN_CD_460 = "460";
	/** 원산지 코드 : 국산 */
	public static final String ORIGIN_CD_470 = "470";
	/** 원산지 코드 : 그루지아 */
	public static final String ORIGIN_CD_480 = "480";
	/** 원산지 코드 : 그리스 */
	public static final String ORIGIN_CD_490 = "490";
	/** 원산지 코드 : 기타 */
	public static final String ORIGIN_CD_500 = "500";
	/** 원산지 코드 : 기타국가 */
	public static final String ORIGIN_CD_510 = "510";
	/** 원산지 코드 : 남아프리카공화국 */
	public static final String ORIGIN_CD_520 = "520";
	/** 원산지 코드 : 네덜란드 */
	public static final String ORIGIN_CD_530 = "530";
	/** 원산지 코드 : 네팔 */
	public static final String ORIGIN_CD_540 = "540";
	/** 원산지 코드 : 노르웨이 */
	public static final String ORIGIN_CD_550 = "550";
	/** 원산지 코드 : 뉴질랜드 */
	public static final String ORIGIN_CD_560 = "560";
	/** 원산지 코드 : 다국적OEM */
	public static final String ORIGIN_CD_570 = "570";
	/** 원산지 코드 : 대만 */
	public static final String ORIGIN_CD_580 = "580";
	/** 원산지 코드 : 대한민국 */
	public static final String ORIGIN_CD_590 = "590";
	/** 원산지 코드 : 덴마크 */
	public static final String ORIGIN_CD_600 = "600";
	/** 원산지 코드 : 도미니카 */
	public static final String ORIGIN_CD_610 = "610";
	/** 원산지 코드 : 독일 */
	public static final String ORIGIN_CD_620 = "620";
	/** 원산지 코드 : 독일(중국OEM) */
	public static final String ORIGIN_CD_630 = "630";
	/** 원산지 코드 : 라오스 */
	public static final String ORIGIN_CD_640 = "640";
	/** 원산지 코드 : 라트비아 */
	public static final String ORIGIN_CD_650 = "650";
	/** 원산지 코드 : 러시아공화국 */
	public static final String ORIGIN_CD_660 = "660";
	/** 원산지 코드 : 루마니아 */
	public static final String ORIGIN_CD_670 = "670";
	/** 원산지 코드 : 리비아 */
	public static final String ORIGIN_CD_680 = "680";
	/** 원산지 코드 : 리투아니아 */
	public static final String ORIGIN_CD_690 = "690";
	/** 원산지 코드 : 마다가스카르 */
	public static final String ORIGIN_CD_700 = "700";
	/** 원산지 코드 : 마카오 */
	public static final String ORIGIN_CD_710 = "710";
	/** 원산지 코드 : 말레이시아 */
	public static final String ORIGIN_CD_720 = "720";
	/** 원산지 코드 : 말레이시아/중국 */
	public static final String ORIGIN_CD_730 = "730";
	/** 원산지 코드 : 멕시코 */
	public static final String ORIGIN_CD_740 = "740";
	/** 원산지 코드 : 멕시코/말레이시아 */
	public static final String ORIGIN_CD_750 = "750";
	/** 원산지 코드 : 모로코 */
	public static final String ORIGIN_CD_760 = "760";
	/** 원산지 코드 : 모리셔스 */
	public static final String ORIGIN_CD_770 = "770";
	/** 원산지 코드 : 모리타니아 */
	public static final String ORIGIN_CD_780 = "780";
	/** 원산지 코드 : 몰다비아 */
	public static final String ORIGIN_CD_790 = "790";
	/** 원산지 코드 : 몰도바 */
	public static final String ORIGIN_CD_800 = "800";
	/** 원산지 코드 : 몽골 */
	public static final String ORIGIN_CD_810 = "810";
	/** 원산지 코드 : 미국 */
	public static final String ORIGIN_CD_820 = "820";
	/** 원산지 코드 : 미국(OEM) */
	public static final String ORIGIN_CD_830 = "830";
	/** 원산지 코드 : 미국(중국OEM) */
	public static final String ORIGIN_CD_840 = "840";
	/** 원산지 코드 : 미국외기타지역 */
	public static final String ORIGIN_CD_850 = "850";
	/** 원산지 코드 : 미얀마 */
	public static final String ORIGIN_CD_860 = "860";
	/** 원산지 코드 : 바레인 */
	public static final String ORIGIN_CD_870 = "870";
	/** 원산지 코드 : 방글라데시 */
	public static final String ORIGIN_CD_880 = "880";
	/** 원산지 코드 : 방글라데시OEM */
	public static final String ORIGIN_CD_890 = "890";
	/** 원산지 코드 : 방콕 */
	public static final String ORIGIN_CD_900 = "900";
	/** 원산지 코드 : 베트남 */
	public static final String ORIGIN_CD_910 = "910";
	/** 원산지 코드 : 베트남OEM */
	public static final String ORIGIN_CD_920 = "920";
	/** 원산지 코드 : 벨기에 */
	public static final String ORIGIN_CD_930 = "930";
	/** 원산지 코드 : 보스니아 */
	public static final String ORIGIN_CD_940 = "940";
	/** 원산지 코드 : 복합원산지 */
	public static final String ORIGIN_CD_950 = "950";
	/** 원산지 코드 : 볼리비아 */
	public static final String ORIGIN_CD_960 = "960";
	/** 원산지 코드 : 북한 */
	public static final String ORIGIN_CD_970 = "970";
	/** 원산지 코드 : 불가리아 */
	public static final String ORIGIN_CD_980 = "980";
	/** 원산지 코드 : 브라질 */
	public static final String ORIGIN_CD_990 = "990";
	/** 원산지 코드 : 사우디아라비아 */
	public static final String ORIGIN_CD_1000 = "1000";
	/** 원산지 코드 : 상세설명참조 */
	public static final String ORIGIN_CD_1010 = "1010";
	/** 원산지 코드 : 설명글참조 */
	public static final String ORIGIN_CD_1020 = "1020";
	/** 원산지 코드 : 세르비아 */
	public static final String ORIGIN_CD_1030 = "1030";
	/** 원산지 코드 : 수입 */
	public static final String ORIGIN_CD_1040 = "1040";
	/** 원산지 코드 : 스리랑카 */
	public static final String ORIGIN_CD_1050 = "1050";
	/** 원산지 코드 : 스웨덴 */
	public static final String ORIGIN_CD_1060 = "1060";
	/** 원산지 코드 : 스웨덴&3국OEM */
	public static final String ORIGIN_CD_1070 = "1070";
	/** 원산지 코드 : 스위스 */
	public static final String ORIGIN_CD_1080 = "1080";
	/** 원산지 코드 : 스코틀랜드 */
	public static final String ORIGIN_CD_1090 = "1090";
	/** 원산지 코드 : 스페인 */
	public static final String ORIGIN_CD_1100 = "1100";
	/** 원산지 코드 : 슬로바키아 */
	public static final String ORIGIN_CD_1110 = "1110";
	/** 원산지 코드 : 싱가포르 */
	public static final String ORIGIN_CD_1120 = "1120";
	/** 원산지 코드 : 아랍에미레이트 */
	public static final String ORIGIN_CD_1130 = "1130";
	/** 원산지 코드 : 아르메니아 */
	public static final String ORIGIN_CD_1140 = "1140";
	/** 원산지 코드 : 아르헨티나 */
	public static final String ORIGIN_CD_1150 = "1150";
	/** 원산지 코드 : 아시아기타 */
	public static final String ORIGIN_CD_1160 = "1160";
	/** 원산지 코드 : 아이슬란드 */
	public static final String ORIGIN_CD_1170 = "1170";
	/** 원산지 코드 : 아이티 */
	public static final String ORIGIN_CD_1180 = "1180";
	/** 원산지 코드 : 아일랜드 */
	public static final String ORIGIN_CD_1190 = "1190";
	/** 원산지 코드 : 아일랜드(대만OEM) */
	public static final String ORIGIN_CD_1200 = "1200";
	/** 원산지 코드 : 아프리카 */
	public static final String ORIGIN_CD_1210 = "1210";
	/** 원산지 코드 : 에스토니아 */
	public static final String ORIGIN_CD_1220 = "1220";
	/** 원산지 코드 : 엘살바도르 */
	public static final String ORIGIN_CD_1230 = "1230";
	/** 원산지 코드 : 영국 */
	public static final String ORIGIN_CD_1240 = "1240";
	/** 원산지 코드 : 영국(중국OEM) */
	public static final String ORIGIN_CD_1250 = "1250";
	/** 원산지 코드 : 오세아니아 */
	public static final String ORIGIN_CD_1260 = "1260";
	/** 원산지 코드 : 오스트레일리아 */
	public static final String ORIGIN_CD_1270 = "1270";
	/** 원산지 코드 : 오스트리아 */
	public static final String ORIGIN_CD_1280 = "1280";
	/** 원산지 코드 : 온두라스 */
	public static final String ORIGIN_CD_1290 = "1290";
	/** 원산지 코드 : 요르단 */
	public static final String ORIGIN_CD_1300 = "1300";
	/** 원산지 코드 : 우루과이 */
	public static final String ORIGIN_CD_1310 = "1310";
	/** 원산지 코드 : 우크라이나 */
	public static final String ORIGIN_CD_1320 = "1320";
	/** 원산지 코드 : 원료원산지하단참조 */
	public static final String ORIGIN_CD_1330 = "1330";
	/** 원산지 코드 : 원산지 */
	public static final String ORIGIN_CD_1340 = "1340";
	/** 원산지 코드 : 원양산 */
	public static final String ORIGIN_CD_1350 = "1350";
	/** 원산지 코드 : 유럽 */
	public static final String ORIGIN_CD_1360 = "1360";
	/** 원산지 코드 : 이디오피아 */
	public static final String ORIGIN_CD_1370 = "1370";
	/** 원산지 코드 : 이라크 */
	public static final String ORIGIN_CD_1380 = "1380";
	/** 원산지 코드 : 이란 */
	public static final String ORIGIN_CD_1390 = "1390";
	/** 원산지 코드 : 이스라엘 */
	public static final String ORIGIN_CD_1400 = "1400";
	/** 원산지 코드 : 이스라엘(중국OEM) */
	public static final String ORIGIN_CD_1410 = "1410";
	/** 원산지 코드 : 이집트 */
	public static final String ORIGIN_CD_1420 = "1420";
	/** 원산지 코드 : 이탈리아 */
	public static final String ORIGIN_CD_1430 = "1430";
	/** 원산지 코드 : 이태리 */
	public static final String ORIGIN_CD_1440 = "1440";
	/** 원산지 코드 : 인도 */
	public static final String ORIGIN_CD_1450 = "1450";
	/** 원산지 코드 : 인도네시아 */
	public static final String ORIGIN_CD_1460 = "1460";
	/** 원산지 코드 : 인디아 */
	public static final String ORIGIN_CD_1470 = "1470";
	/** 원산지 코드 : 일본 */
	public static final String ORIGIN_CD_1480 = "1480";
	/** 원산지 코드 : 일본(중국OEM) */
	public static final String ORIGIN_CD_1490 = "1490";
	/** 원산지 코드 : 전라도 */
	public static final String ORIGIN_CD_1500 = "1500";
	/** 원산지 코드 : 제주도 */
	public static final String ORIGIN_CD_1510 = "1510";
	/** 원산지 코드 : 조지아 */
	public static final String ORIGIN_CD_1520 = "1520";
	/** 원산지 코드 : 중국 */
	public static final String ORIGIN_CD_1530 = "1530";
	/** 원산지 코드 : 중국OEM */
	public static final String ORIGIN_CD_1540 = "1540";
	/** 원산지 코드 : 체코 */
	public static final String ORIGIN_CD_1550 = "1550";
	/** 원산지 코드 : 충청도 */
	public static final String ORIGIN_CD_1560 = "1560";
	/** 원산지 코드 : 칠레 */
	public static final String ORIGIN_CD_1570 = "1570";
	/** 원산지 코드 : 카나리아제도 */
	public static final String ORIGIN_CD_1580 = "1580";
	/** 원산지 코드 : 캄보디아 */
	public static final String ORIGIN_CD_1590 = "1590";
	/** 원산지 코드 : 캐나다 */
	public static final String ORIGIN_CD_1600 = "1600";
	/** 원산지 코드 : 케냐 */
	public static final String ORIGIN_CD_1610 = "1610";
	/** 원산지 코드 : 코스타리카 */
	public static final String ORIGIN_CD_1620 = "1620";
	/** 원산지 코드 : 콜롬비아 */
	public static final String ORIGIN_CD_1630 = "1630";
	/** 원산지 코드 : 콰테말라 */
	public static final String ORIGIN_CD_1640 = "1640";
	/** 원산지 코드 : 쿠웨이트 */
	public static final String ORIGIN_CD_1650 = "1650";
	/** 원산지 코드 : 크로와티아 */
	public static final String ORIGIN_CD_1660 = "1660";
	/** 원산지 코드 : 키프로스 */
	public static final String ORIGIN_CD_1670 = "1670";
	/** 원산지 코드 : 타이완 */
	public static final String ORIGIN_CD_1680 = "1680";
	/** 원산지 코드 : 태국 */
	public static final String ORIGIN_CD_1690 = "1690";
	/** 원산지 코드 : 터키 */
	public static final String ORIGIN_CD_1700 = "1700";
	/** 원산지 코드 : 투르크메니스탄 */
	public static final String ORIGIN_CD_1710 = "1710";
	/** 원산지 코드 : 튀니지 */
	public static final String ORIGIN_CD_1720 = "1720";
	/** 원산지 코드 : 파키스탄 */
	public static final String ORIGIN_CD_1730 = "1730";
	/** 원산지 코드 : 파푸아뉴기니 */
	public static final String ORIGIN_CD_1740 = "1740";
	/** 원산지 코드 : 페루 */
	public static final String ORIGIN_CD_1750 = "1750";
	/** 원산지 코드 : 포루투칼 */
	public static final String ORIGIN_CD_1760 = "1760";
	/** 원산지 코드 : 포르투갈 */
	public static final String ORIGIN_CD_1770 = "1770";
	/** 원산지 코드 : 폴란드 */
	public static final String ORIGIN_CD_1780 = "1780";
	/** 원산지 코드 : 프랑스 */
	public static final String ORIGIN_CD_1790 = "1790";
	/** 원산지 코드 : 프랑스OEM국가 */
	public static final String ORIGIN_CD_1800 = "1800";
	/** 원산지 코드 : 핀란드 */
	public static final String ORIGIN_CD_1810 = "1810";
	/** 원산지 코드 : 필리핀 */
	public static final String ORIGIN_CD_1820 = "1820";
	/** 원산지 코드 : 한국 */
	public static final String ORIGIN_CD_1830 = "1830";
	/** 원산지 코드 : 한국/독일 */
	public static final String ORIGIN_CD_1840 = "1840";
	/** 원산지 코드 : 한국/중국 */
	public static final String ORIGIN_CD_1850 = "1850";
	/** 원산지 코드 : 한국/태국 */
	public static final String ORIGIN_CD_1860 = "1860";
	/** 원산지 코드 : 해외사이트 원산지 미표기 */
	public static final String ORIGIN_CD_1870 = "1870";
	/** 원산지 코드 : 헝가리 */
	public static final String ORIGIN_CD_1880 = "1880";
	/** 원산지 코드 : 호주 */
	public static final String ORIGIN_CD_1890 = "1890";
	/** 원산지 코드 : 호주(중국OEM) */
	public static final String ORIGIN_CD_1900 = "1900";
	/** 원산지 코드 : 홍콩 */
	public static final String ORIGIN_CD_1910 = "1910";

	/** 기본 사이트 아이디(=어바웃펫 1번) */
	public static final Long DEFAULT_ST_ID = 1L;
	/** 기본 사이트 고객사번호(=어바웃펫 1번) */
	public static final String DEFAULT_CS_TEL_NO = "16449601";

	/** 휴면 전환 예정일에서만 쓰이는 기간 공통 코드 */
	public static final String DORMANT_PERIOD = "DORMANT_PERIOD";

	/** 7 */
	public static final String DORMANT_7_DAY = "10";
	/** 30 */
	public static final String DORMANT_30_DAY = "20";
	/** 60 */
	public static final String DORMANT_60_DAY = "30";
	
	/** 태그 출처 코드 */
	public static final String TAG_SRC = "TAG_SRC";
	/** 태그 출처 코드 : 자동생성 */
	public static final String TAG_SRC_A = "A";					
	/** 태그 출처 코드 : 외부유입 */
	public static final String TAG_SRC_E = "E";
	/** 태그 출처 코드 : 수동작성 */
	public static final String TAG_SRC_M = "M";

	/** 쿠폰 발급 안내 템플릿 **/
	public static final Long MEMBER_COUPON_INSERT_TMPL_NO = 104L;

	/** 쿠폰 만료 안내 템플릿 **/
	public static final Long MEMBER_COUPON_END_BEFORE = 105L;

	/** 점유 인증 템플릿 번호  **/
	public static final Long MEMBER_CERT_TMPL_NO = 140L;

	/** 쿠폰 만료 안내 d-day **/
	public static final Integer MEMBER_COUPON_END_DAY = 3;
	
	/** IP 혀용 목록 */
	public static final String IP_ALLOW_LIST = "IP_ALLOW_LIST";
	
	/** IP 혀용 목록 */
	public static final String IP_ALLOW_LIST_10 = "10";

	/** 내 정보 관리 - 점유 인증 유효 시간 */
	public static final Integer OPT_EXPIRE_MINUTE = 3;


	/** 템플릿 번호 동적으로 가져올 수 있게 */
	public static final String TMPL_NO = "TMPL_NO";
	
	/** 쿠폰 발급 안내 템플릿 번호 */
	public static final String TMPL_COPON_INSERT = "10";
	/** 쿠폰 만료 안내 템플릿 번호 */
	public static final String TMPL_COPON_EXPIRE = "20";
	/** 점유인증 템플릿 번호 */
	public static final String TMPL_ONE_TIME_PSWD = "30";
	/** 마케팅 수신 동의 템플릿 번호 */
	public static final String TMPL_MARKETING_Y = "40";
	/** 마케팅 수신 거부 템플릿 번호 */
	public static final String TMPL_MARKETING_N = "50";

	/** DB 컬럼 없이 관리하는 상수 값(동적 변경 위해 공통 코드 관리) , 사용자 정의 1 값 : 일수, 사용자 정의 2 값 : 단위*/
	public static final String VARIABLE_CONSTANTS = "VARIABLE_CONSTANTS";

	/** 내 정보 관리 - 점유 인증 유효 시간 */
	public static final String VARIABLE_CONSTANTS_OPT_EXPIRE_MINUTE = "10";
	/** 쿠폰 만료 안내 일 */
	public static final String VARIABLE_CONSTANTS_COUPON_EXPIRE_DAY = "20";
	/** 펫 로그 후기 등록 시 포인트 */
	public static final String VARIABLE_CONSTATNS_PET_LOG_REVIEW_PNT = "30";
	/** 펫 로그 좋아요 달성 시 포인트 */
	public static final String VARIABLE_CONSTATNS_PET_LOG_LIKE_PNT = "40";
	/** 세션 유효 시간 */
	public static final String VARIABLE_CONSTATNS_SESSION_EXPIRE = "50";
	/** 사용자 최종로그인 유효일 */
	public static final String VARIABLE_CONSTATNS_USER_LAST_LOGIN_VALID_DAY = "60";

	/** GS 좋아요 및 상품 후기 이벤트 기간*/
	public static final String GS_PNT_PERIOD = "GS_PNT_PERIOD";

	/** 좋아요 이벤트 기간 */
	public static final String GS_PNT_PERIOD_LIKE = "LIKE";

	/** 상품 후기 기간 */
	public static final String GS_PNT_PERIOD_REVIEW = "REVIEW";

	/** 예방접종 예정일 안내 템플릿 번호 */
	public static final String TMPL_ADD_INCL_DT = "60";
	/** 펫로그 댓글 템플릿 번호 */
	public static final String TMPL_PET_LOG_REPLY = "70";
	/** 펫로그 댓글 멘션 템플릿 번호 */
	public static final String TMPL_PET_LOG_REPLY_MENTION = "80";
	/** 펫로그 좋아요 템플릿 번호 */
	public static final String TMPL_PET_LOG_LIKE = "90";
	/** 펫로그 댓글 신고 템플릿 번호 */
	public static final String TMPL_PET_LOG_RPLY_RPTP = "100";
	/** 펫로그 게시물 신고 템플릿 번호 */
	public static final String TMPL_PET_LOG_RPTP = "110";
	/** 펫로그 팔로우 템플릿 번호 */
	public static final String TMPL_PET_LOG_FOLLOW = "120";
	
	/** 펫샵 디폴트 펫 */
	public static final String PET_SHOP_DEFAULT_PET = "PET_SHOP_DEFAULT_PET";
	/** 펫샵 디폴트 펫 강아지*/
	public static final String PET_SHOP_DEFAULT_PET_DOG = "10";
	/** 펫샵 디폴트 펫 고양이*/
	public static final String PET_SHOP_DEFAULT_PET_CAT = "20";
	/** 펫샵 디폴트 펫 관상어*/
	public static final String PET_SHOP_DEFAULT_PET_FISH = "30";
	/** 펫샵 디폴트 펫 소동물*/
	public static final String PET_SHOP_DEFAULT_PET_ANIMAL = "40";
	
	/** 이벤트 팝업 구분코드(게시구분) */
	public static final String EVTPOP_GB = "EVTPOP_GB";	
	/** 이벤트 팝업 구분코드  APP*/
	public static final String EVTPOP_GB_APP = "10";
	/** 이벤트 팝업 구분코드  WEB*/
	public static final String EVTPOP_GB_WEB = "20";
	/** 이벤트 팝업 구분코드  전체*/
	public static final String EVTPOP_GB_ALL = "30";
	
	/** 이벤트 팝업 게시 위치 코드*/
	public static final String EVTPOP_LOC = "EVTPOP_LOC";
	/** 이벤트 팝업 게시 위치 메인*/
	public static final String EVTPOP_LOC_MAIN = "10";
	/** 이벤트 팝업 게시 위치 TV*/
	public static final String EVTPOP_LOC_TV = "20";
	/** 이벤트 팝업 게시 위치 LOG*/
	public static final String EVTPOP_LOC_LOG = "30";
	/** 이벤트 팝업 게시 위치 SHOP*/
	public static final String EVTPOP_LOC_SHOP = "40";
	
	
	/** 이벤트 상태 코드*/
	public static final String EVTPOP_STAT = "EVTPOP_STAT";
	/** 이벤트 상태 코드 게시*/
	public static final String EVTPOP_STAT_OPEN = "10";
	/** 이벤트 상태 코드 미게시*/
	public static final String EVTPOP_STAT_CLOSE = "20";
	
	/** 신규가입쿠폰이벤트 */
	public static final String WELCOME_COUPON_EVENT = "WELCOME_COUPON_EVENT";	
	/** 신규가입 자동지급쿠폰이벤트 */
	public static final String WELCOME_COUPON_EVENT_10 = "10";
	/** 신규가입선착순 쿠폰이벤트 */
	public static final String WELCOME_COUPON_EVENT_20 = "20";
	
	/** 주문 수집 문자 알림 코드 */
	public static final String ORD_CLET_CHAR_ALM = "ORD_CLET_CHAR_ALM";
	/** 9시 */
	public static final String ORD_CLET_CHAR_ALM_09 = "09";
	/** 12시 */
	public static final String ORD_CLET_CHAR_ALM_12 = "12";
	/** 15시  */
	public static final String ORD_CLET_CHAR_ALM_15 = "15";
	
		
	
}