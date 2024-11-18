package framework.admin.constants;

import framework.common.constants.CommonConstants;

import java.util.LinkedHashMap;
import java.util.Map;

/**
 * Admin Constants
 * 
 * @author valueFactory
 * @since 2015. 06. 11
 */
public final class AdminConstants extends CommonConstants {

	// =======================================================
	// 공통 : COM
	// =======================================================
	
	/** 로그인 URL */
	public static final String LOGIN_URL = "/login/loginView.do";

	/** 메인 URL */
	public static final String MAIN_URL = "/main/mainView.do";

	/** CS 메인 URL */
	public static final String CS_MAIN_URL = "/main/mainCsView.do";

	/** Error View */
	public static final String ERROR_VIEW_NAME = "/error/error";

	/** 공통 세션 ATTRIBUTE */
	public static final String ADMIN_SESSION_SET_ATTRIBUTE = "adminSession";

	/** Layout 구분 */
	public static final String LAYOUT_DEFAULT = "defaultLayout";
	public static final String LAYOUT_MAIN = "contentsLayout";
	public static final String LAYOUT_POP = "popupLayout";

	public static final String VIEW_GB_TAB = "TAB";
	public static final String VIEW_GB_POP = "POP";


	
	// =======================================================
	// 로그인 : LGN
	// =======================================================
	
	public static final String RECENT_USED_TIME = "sessionCheck";
	
	public static final String SESSION_TIME_OUT = "sessionTimeOut";
	
	public static final String DUPLICATED_LOGOUT = "duplicatedLogout";
	
	// =======================================================
	// 기본관리 : SYS
	// =======================================================
	
	public static final Integer MENU_DEFAULT_NO = 0;

	
	// =======================================================
	// 사용자 : USR
	// =======================================================
	
	/** 사용자 로그인 인증값 */
	public static final String USER_LOGIN_CFT_CD = "userLoginCftCd";
	/** 사용자 비밀번호 재설정 인증값 */
	public static final String USER_PSWD_CFT_CD = "userPswdCftCd";
	/** 사용자 잘못된 인증값 */
	public static final String USER_WRONG_CFT= "userWrongCft";
	/**이전 비밀번호와 같은경우*/
	public static final String USER_PSWD_EQUAL= "userPswdEqual";
	/** po 사용자 최초 로그인 */
	public static final String PO_USER_FIRST_LOGIN = "poUserFirstLogin";
	

	/** 게시판 : 공지사항 아이디 */
	public static final String BBS_ID_NOTICE 	= "dwNotice";
	/** 게시판 : FAQ 아이디 */
	public static final String BBS_ID_FAQ		= "dwFaq";
	// =======================================================
	// 회원 : MBR
	// =======================================================

	// =======================================================
	// 전시 : DSP
	// =======================================================
	/** 비정형 페이지 펫샵 전시번호*/
	public static final Long DISP_CLSF_NO_PETSHOP = 300000164L;
	/** 비정형 페이지 펫TV 전시번호*/
	public static final Long DISP_CLSF_NO_PETTV = 300000171L;
	/** 비정형 페이지 펫로그 전시번호*/
	public static final Long DISP_CLSF_NO_PETLOG = 300000163L;
	// =======================================================
	// 마케팅 : PRO
	// =======================================================

	
	// =======================================================
	// 상품 : GDS
	// =======================================================

	/** 상품 일괄 변경 */
	/** 상품 상태 */
	public static final String GOODS_BULK_UPDATE_STAT = "STAT";
	/** 노출 여부 */
	public static final String GOODS_BULK_UPDATE_SHOW = "SHOW";
	/** 승인 */
	public static final String GOODS_BULK_UPDATE_APPR = "APPR";
	/** 수수료 비율 */
	public static final String GOODS_BULK_UPDATE_RATE = "RATE";
	/** 가격변경 */
	public static final String GOODS_BULK_UPDATE_PRICE = "PRICE";
	/** 아이콘 */
	public static final String GOODS_BULK_UPDATE_ICON = "ICON";
	/** 웹모바일 구분 */
	public static final String GOODS_BULK_UPDATE_DEVICE = "DEVICE";
	/** 삭제 */
	public static final String GOODS_BULK_UPDATE_REMOVE = "REMOVE";

	/** 상품 일괄 업로드 */
	public static final String UPLOAD_GB_GOODS_BASE = "UPLOAD_GB_GOODS_BASE";
	public static final String UPLOAD_GB_NOTIFY = "UPLOAD_GB_NOTIFY";
	public static final String UPLOAD_GB_STOCK = "UPLOAD_GB_STOCK";
	public static final String UPLOAD_GB_GOODS_PRICE = "UPLOAD_GB_GOODS_PRICE";
	public static final String UPLOAD_GB_POS_GOODS_ID = "UPLOAD_GB_POS_GOODS_ID";
	
	/** 기본 상품 수수료 요율 */
	public static final Double CMS_DEFALUT_RATE = Double.valueOf(10.0);

	public static final String GOODS_EXCEL_DOWNLOAD_GOODS = "GOODS";
	public static final String GOODS_EXCEL_DOWNLOAD_CATEGORY = "CATEGORY";
	public static final String GOODS_EXCEL_DOWNLOAD_PRICE = "PRICE";

	/** 상품 목록 EXCEL 다운로드 HEADER */
	public static final Map<String, String> GOODS_EXCEL_DOWNLOAD_CATEGORY_HEADER= new LinkedHashMap<String, String>() {
		{
			put("GOODS_ID","상품코드");
			put("COMP_GOODS_ID","자체상품코드");
			put("GOODS_NM","상품명");
			put("GOODS_CSTRT_TP_NM","상품 구성 유형");
			put("GOODS_CODE","상품/단품의 코드와 상품명");
			put("CATEGORY", "카테고리");
		}
	};

	public static final Map<String, String> GOODS_EXCEL_DOWNLOAD_PRICE_HEADER= new LinkedHashMap<String, String>() {
		{
			put("GOODS_ID","상품코드");
			put("COMP_GOODS_ID","자체상품코드");
			put("GOODS_NM","상품명");
			put("GOODS_CSTRT_TP_NM","상품 구성 유형");
			put("GOODS_CODE","상품/단품의 코드와 상품명");
			put("GOODS_STAT_NM", "판매상태");
			put("COMPANY","공급사 구분");
			put("ORG_SALE_AMT","정상가");
			put("SPL_AMT","매입가");
			put("SALE_AMT","판매가");
			put("WEB_STK_QTY", "상품재고");
		}
	};

	/** 상품 전체 목록 EXCEL 다운로드 HEADER */
	public static final Map<String, String> GOODS_EXCEL_DOWNLOAD_GOODS_HEADER= new LinkedHashMap<String, String>() {
		{
			put("GOODS_ID","상품코드");
			put("COMP_GOODS_ID","자체상품코드");
			put("PRD_STD_ID","제품표준코드");
			put("IMG_PATH","이미지");
			put("BND_NM_KO","브랜드");
			put("GOODS_NM","상품명");
			put("COMP_GOODS_NM","위탁업체 상품명");
			put("GOODS_STAT_NM","상품상태");
			put("GOODS_CSTRT_TP_NM","상품 구성 유형");
			put("GOODS_CODE","상품/단품의 코드와 상품명");
			put("COMPANY","공급사 구분");
			put("PHS_COMP_NM","매입 업체명");
			put("ORG_SALE_AMT","정상가");
			put("SPL_AMT","매입가");
			put("SALE_AMT","판매가");
			put("CATEGORY","카테고리");
			put("FRB_PSB_YN","사은품 여부");
			put("MDL_NM","모델 명");
			put("WEB_MOBILE_GB_CD","웹 모바일 구분");
			put("WEB_SHOW_YN","PC쇼핑몰 노출상태");
			put("MOBILE_SHOW_YN","모바일쇼핑몰 노출상태");
			put("WEB_SALE_YN","PC쇼핑몰 판매상태");
			put("MOBILE_SALE_YN","모바일쇼핑몰 판매상태");
			put("PET_GB_NM","애완동물 종류");
			put("SOLD_OUT_YN","품절 여부");
			put("SHOPLINKER_SND_YN","샵링커 전송 여부");
			put("EXP_MNG_YN","유통기한 관리 여부");
			put("EXP_MONTH","유통기한(월)");
			put("FILTERS","필터");
			put("MMFT","제조사");
			put("CTR_ORG","원산지");
			put("STK_MNG_YN","재고관리여부");
			put("WEB_STK_QTY","상품재고");
			put("STK_QTY_SHOW_YN","재고 수량 노출 여부");
			put("MIN_ORD_QTY","최소구매수량");
			put("MAX_ORD_QTY","최대구매수량");
			put("SALE_DTM","판매기간");
			put("DLVR_AMT","배송비");
			put("FREE_DLVR_YN","무료배송 여부");
			put("RTN_PSB_YN","반품가능 여부");
			put("MD_RCOM_YN","MD 추천 여부");
			put("CHECK_POINT","체크 포인트");
			put("MD_RCOM_WDS","추천 메세지");
			put("WEB_CONTENT","PC쇼핑몰상세설명");
			put("MOBILE_CONTENT","모바일쇼핑몰상세설명");
			put("TAX_GB_NM","과세 구분");
			put("GOODS_CSTRT_INFO","관련상품 코드");
			put("ICON_STRT_DTM", "아이콘기간(시작)");
			put("ICON_END_DTM", "아이콘기간(끝)");
			put("ICONS_PERIOD","아이콘(기간제한용)");
			put("ICONS","아이콘(무제한용)");
			put("IGDT_INFO_LNK_YN","성분정보 연동여부");
			put("TWC_PRODUCT","상품 상세 정보");
			put("SND_YN","네이버쇼핑 노출여부");
			put("GOODS_SRC_NM","수입 및 제작 여부");
			put("SALE_TP_NM","판매 방식 구분");
			put("STP_USE_AGE_NM","주요사용연령대");
			put("STP_USE_GD_NM","주요사용성별");
			put("SRCH_TAG","검색태그");
			put("NAVER_CTG_ID","네이버 카테고리 ID");
			put("PRC_CMPR_PAGE_ID","가격비교 페이지 ID");
			put("DISP_CTG_PATH","상품평가 항목 그룹");
			put("IO_ALM_YN","재입고 알림 여부");
			put("SEO_INFO_YN","상품 개별 SEO 설정 여부");
			put("PAGE_TTL","타이틀");
			put("PAGE_ATHR","메타태그 작성자");
			put("PAGE_DSCRT","메타태그 설명");
			put("PAGE_KWD","메타태그 키워드");
			put("BIGO","비고");
			put("SYS_REG_DTM","등록일");
			put("SYS_UPD_DTM","수정일");
			put("HITS","조회");
			put("INTERST","관심");
			put("COMMENT","후기");
		}
	};

	// =======================================================
	// 주문 : ORD
	// =======================================================

	public static final String SORD_DESC = "desc";

	public static final String GOODS_EXCEL_SAMPLE_FILE = "goodsSampleExcel.xlsx";

	public static final String GOODS_BULK_ATTR_VAL_DELIMETER = "/";
	public static final String GOODS_BULK_COMMA_DELIMETER = ",";
	public static final String GOODS_BULK_CARET_DELIMETER = "^";

	
	// =======================================================
	// 정산 : ADJ
	// =======================================================

	// =======================================================
	// 통계 : STA
	// =======================================================

	/** BO,PO 사용자 구분 */
	public static final String USR_SUB_GB_CD = "USR_SUB_GB_CD";

	public static final String USR_SUB_GB_10 = "10"; // BO 사용자
	public static final String USR_SUB_GB_20 = "20"; // PO 사용자	
	
	
	// =======================================================
	// 태그 : TAG
	// =======================================================
	
	public static final String TAG_STAT = "TAG_STAT";
	public static final String TAG_STAT_Y = "Y";
	public static final String TAG_STAT_N = "N";
	
	public static final String TAG_SRC = "TAG_SRC";
	/** 자동 생성 */
	public static final String TAG_SRC_A = "A";
	/** 외부 유입 */
	public static final String TAG_SRC_E = "E";
	/** 수동 작성 */
	public static final String TAG_SRC_M = "M";
	
	public static final String TAG_SORT_ORDER = "TAG_SORT_ORDER";
	public static final String TRD_TAG_SORT_ORDER = "TRD_TAG_SORT_ORDER";
	
	/* 회원 관리 - 댓글 목록 구분 코드 */
	public static final String REPLY_GB_CD = "REPLY_GB_CD";
	
	/** 펫 TV(어바웃 TV)  */
	public static final String REPLY_GB_10 = "10";
	/** 펫로그 */
	public static final String REPLY_GB_20 = "20";
	/** 상품 후기 */
	public static final String REPLY_GB_30 = "30";
	/** 이벤트 */
	public static final String REPLY_GB_40 = "40";

	/** 추천 받음 */
	public static final String RECOMMAND_GB_10 = "10";
	/** 추천 함 */
	public static final String RECOMMAND_GB_20 = "20";

	/*PO 권한 번호*/
	public static final String PO_AUTH_NO = "1";
}