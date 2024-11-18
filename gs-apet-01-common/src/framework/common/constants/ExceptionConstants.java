package framework.common.constants;

/**
 * 에러 상수 정의
 * 
 * @author valueFactory
 * @since 2015. 06. 11.
 */
public final class ExceptionConstants {
 

	// =======================================================
	// 공통 : COM
	// =======================================================
	/**  */
	public static final String ERROR_CODE_DEFAULT = "COM0000";

	/** 업로드 하실수 없는 파일입니다. */
	public static final String BAD_EXE_FILE_EXCEPTION = "COM0001";

	/** 제한된 용량을 초가하였습니다. */
	public static final String BAD_SIZE_FILE_EXCEPTION = "COM0002";

	/** 캐시 생성중 오류가 발생하였습니다. */
	public static final String ERROR_CACHE = "COM0003";

	/** 파라미터 오류입니다. */
	public static final String ERROR_PARAM = "COM0004";

	/** FTP CONNECT 오류 입니다. */
	public static final String ERROR_FTP_CONNECT = "COM0005";

	/** FTP FILE PATH 오류 입니다. */
	public static final String ERROR_FTP_FILEPATH = "COM0006";

	/** FTP FILE 오류 입니다. */
	public static final String ERROR_FTP_FILE = "COM0007";

	/** 잘못된 요청입니다. */
	public static final String ERROR_REQUEST = "COM0008";

	/** 사용자 권한이 없습니다. */
	public static final String ERROR_USER_AUTH = "COM0009";

	/** 해당 파일이 존재하지 않습니다. */
	public static final String ERROR_FILE_NOT_FOUND = "COM0010";

	/** front 공통 에러 */
	public static final String ERROR_CODE_FRONT_DEFAULT = "COM0011";

	/** 잘못된 경로로 접근하였습니다. */
	public static final String ERROR_NO_PATH = "COM0012";

	/** PNG, GIF, JPG 이미지만 등록이 가능합니다. */
	public static final String BAD_EXE_IMAGE_FILE_EXCEPTION = "COM0013";

	/** 메일 전송 내역이 존재하지 않습니다. */
	public static final String ERROR_EMAIL_SEND_HISTORY_NO_EXISTS = "COM0014";

	/** 메일 전송 Mapping 정보가 존재하지 않습니다. */
	public static final String ERROR_EMAIL_SEND_HISTORY_MAP_NO_EXISTS = "COM0015";

	/** NAS COPY 오류 */
	public static final String ERROR_NAS_COPY = "COM0016";

	/** NAS DELETE 오류 */
	public static final String ERROR_NAS_DELETE = "COM0017";
	
	/** 로그인 후 업로드하여 주십시오. */
	public static final String UPLOAD_LOGIN_REQUIRED = "COM0018";
	
	/** 로그인 후 시도하여 주십시오. */
	public static final String TRY_LOGIN_REQUIRED = "COM0019";

	/** main database no selected */
	public static final String ERROR_MAINDB_REQUIRED = "COM0099";

	/** File access permission error */
	public static final String ERROR_FILE_ACCESS_PERMISSION = "COM9000";
	
	/** CIS 연동에 실패하였습니다. */
	public static final String ERROR_CIS_ERROR = "COM0020";
	
	/** 양식에 맞는 엑셀파일을 업로드해 주세요. */
	public static final String ERROR_EXCEL_TEMPLATE_NOT_MATCHED = "COM5000";

	/** 엑셀 파일의 회원 번호와 일치하는 회원이 없습니다. */
	public static final String ERROR_EXCEL_TEMPLATE_NOT_MATCHED_MEMBER = "COM5001";
	
	/** 서비스에 접속할 수 없습니다. */
	public static final String ERROR_SERVER_ERROR = "COM9500";
	
	/** 서비스에 접속할 수 없습니다. */
	public static final String ERROR_NO_CONNECT = "COM9501";
	
	/** 요청하신 페이지를 찾을 수 없습니다. */
	public static final String ERROR_NOT_FOUND = "COM9404";
	
	/** 이메일 발송에 실패했어요. */
	public static final String ERROR_EMAIL_SEND_FAIL = "COM0021";

	/** 데이터 파싱 오류입니다. */
	public static final String ERROR_DATA_PARSE_FAIL = "COM0022";
	
	/** PNG, GIF, JPG 이미지만 등록이 가능합니다. */
	public static final String BAD_EXE_PROFILE_IMAGE_FILE_EXCEPTION = "COM001313";

	// =======================================================
	// 로그인 : LGN
	// =======================================================

	/** 로그인이 필요합니다. */
	public static final String ERROR_CODE_LOGIN_REQUIRED = "LGN0000";

	/** 세션이 종료 되었습니다. */
	public static final String ERROR_CODE_LOGIN_SESSION = "LGN0001";

	/** 사용자 아이디, 패스워드 를 확인해 주세요. */
	public static final String ERROR_CODE_LOGIN_FAIL = "LGN0002";

	/** 사용자 상태가 올바르지 않습니다. 관리자에게 문의바랍니다. */
	public static final String ERROR_CODE_LOGIN_STATUS_FAIL = "LGN0003";

	/** 30일간 로그인되지 않은 계정입니다. 담당자에서 잠금해제 신청을 해주세요. */
	public static final String ERROR_CODE_LOGIN_STATUS_QSC = "LGN0004";


	/** 로그인이 필요합니다. (팝업) */
	public static final String ERROR_CODE_LOGIN_REQUIRED_POP = "LGN0005";

	/** 아이디가 잘못 입력되었습니다. -> 아이디 또는 비밀번호를 다시 확인해주세요 */
	public static final String ERROR_CODE_LOGIN_ID_FAIL = "LGN0006";

	/** 비밀번호가 잘못 입력되었습니다. -> 아이디 또는 비밀번호를 다시 확인해주세요 */
	public static final String ERROR_CODE_LOGIN_PW_FAIL = "LGN0007";
	
	/**비밀번호 오류횟수가 5회입니다. 비밀번호를 재설정해주세요. */
	public static final String ERROR_CODE_BO_PW_FAIL_CNT  = "LGN0008";
	
	/** 비밀번호가 초기화되었습니다. 비밀번호를 변경하시기 바랍니다. */
	public static final String ERROR_CODE_BO_PW_RESET_FAIL_CNT  = "LGN0009";
	
	/** 비밀번호 유효기가 만료되었습니다. PW변경 후 서비스 이용 가능합니다. 지금 바로 비밀번호를 변경하시겠습니까? */
	public static final String ERROR_CODE_PSWD_HIST_FAIL  = "LGN0010";
	
	/** 기존 비밀번호와 동일한 비밀번호로는 변경할 수 없습니다. */
	public static final String ERROR_CODE_PSWD_UPDATE_ERROR  = "LGN0011";
	
	/** 비밀번호가 5회 이상 실패했습니다. 비밀번호 찾기로 임시비밀번호를 발급받으시기 바랍니다. */
	public static final String ERROR_CODE_FO_PW_FAIL_CNT  = "LGN0012";
	
	/** 비밀번호가 초기화되었습니다. 비밀번호 찾기로 임시비밀번호를 발급받으시기 바랍니다. */
	public static final String ERROR_CODE_FO_PW_RESET_FAIL_CNT  = "LGN0013";
	
	/** 업체 상태가 올바르지 않습니다. 관리자에게 문의바랍니다. */
	public static final String ERROR_CODE_LOGIN_COMPANY_STATUS_FAIL = "LGN0100";
	
	/** 유효기간이 만료된 계정입니다. 담당자에서 잠금해제 신청을 해주세요. */
	public static final String ERROR_CODE_LOGIN_STATUS_LOCK = "LGN0101";

	/** 에러가 발생하였습니다. 다시 시도해주세요.*/
	public static final String ERROR_CODE_LOGIN_QUERY_UPDATE = "LGN0102";

	/** 관리자 시스템에 처음 접속하시는 분은 비밀번호 변경 후 이용해 주세요.  */
	public static final String ERROR_CODE_LOGIN_BO_FIRST= "LGN0103";

	/** 사용자님의 ID로 다른 단말기에서<BR> 로그인되었기에 <BR>자동로그아웃되었습니다. */
	public static final String ERROR_CODE_LOGIN_DUPLICATE= "LGN0104";

	/** 관리자시스템에 접속 후, 최근 30분간<BR>사용이 없으셨기에<BR>자동로그아웃되었습니다.*/
	public static final String ERROR_CODE_LOGIN_NOT_USED= "LGN0105";

	//FO로그인
	/** 휴면 시 : 휴면상태를 해제하시겠습니까?*/
	public static final String ERROR_CODE_LOGIN_SLEEP= "LGN0106";
	/** 중복 시 : 휴대폰번호 변경 되셨나요? 회원정보 수정 후 이용해주세요 */
	public static final String ERROR_CODE_LOGIN_DUPLICATE_PHONE = "LGN0107";
	/** 정지 시 : 보안 상의 문제로 서비스를 이용할 수 없습니다. 본인인증 후 이용해 주세요*/
	public static final String ERROR_CODE_LOGIN_STOP = "LGN0108";
	/** 부당거래정지 시 : 보안 상의 문제로 서비스를 이용할 수 없습니다. 서비스를 다시 이용하기 위해서는 고객센터로 문의해 주세요*/
	public static final String ERROR_CODE_LOGIN_UNFAIR_TRADE= "LGN0109";
	/** sns계정 연동 해체 한 경우 : 연동이 해제된 계정입니다. 다시 연동하시겠습니까?*/
	//public static final String ERROR_CODE_LOGIN_SNS_DISABLE= "LGN0110";

	/** 파트너 시스템에 처음 접속하시는 분은 비밀번호 변경 후 이용해 주세요.  */
	public static final String ERROR_CODE_LOGIN_PO_FIRST= "LGN0111";
	
	
	// =======================================================
	// 펫로그 : LOG
	// =======================================================
	/** 게시물 등록이 취소되었습니다.  */
	public static final String ERROR_CODE_PET_LOG_INSERT_FAIL= "LOG0001";
	
	
	// =======================================================
	// 기본관리 : SYS
	// =======================================================
	/** 이미 등록되어 있는 그룹 코드입니다. */
	public static final String ERROR_CODE_GROUP_DUPLICATION_FAIL = "SYS0000";

	/** 이미 등록되어 있는 코드입니다. */
	public static final String ERROR_CODE_DETAIL_DUPLICATION_FAIL = "SYS0001";

	/** 하위 메뉴가 있습니다. 메뉴기능은 최하위에서만 등록이 가능합니다. */
	public static final String ERROR_MENU_ACTION_FAIL = "SYS0002";

	/** 메인화면은 한개 이상 등록하실수 없습니다. */
	public static final String ERROR_MENU_ACTION_MAIN_FAIL = "SYS0003";

	/** 상위 메뉴에 메뉴기능이 등록되어 있습니다. */
	public static final String ERROR_MENU_BASE_TREE_FAIL = "SYS0004";

	/** 권한을 사용중인 사용자가 있습니다. */
	public static final String ERROR_AUTH_MENU_FAIL = "SYS0005";

	/** 하위 메뉴가 있습니다. 하위 메뉴를 먼저 삭제해 주세요. */
	public static final String ERROR_UP_MENU_FAIL = "SYS0006";

	/** 메뉴기능이 등록되어 있습니다. 메뉴 기능을 먼저 삭제해주세요. */
	public static final String ERROR_MENU_ACTION_DEL_FAIL = "SYS0007";

	/** 등록된 게시글이 존재합니다. */
	public static final String ERROR_BOARD_FAIL = "SYS0008";

	
	// =======================================================
	// 사용자 : USR
	// =======================================================
	/** 이미 등록되어 있는 운영자 ID 입니다. */
	public static final String ERROR_USER_DUPLICATION_FAIL = "USR0000";

	
	// =======================================================
	// 회원 : MBR
	// =======================================================
	/** 존재하지 않는 회원입니다. */
	public static final String ERROR_MEMBER_NO_MEMBER = "MBR0000";

	/** 현재 비밀번호를 확인하여 주십시오. */
	public static final String ERROR_MEMBER_PSWD_FAIL = "MBR0001";

	/** 관심상품에 이미 등록된 상품입니다. */
	public static final String ERROR_MEMBER_INTEREST_GOODS_DUPLICATE = "MBR0002";

	/** 중복된 회원이 존재합니다. */
	public static final String ERROR_MEMBER_DUPLICATION_FAIL = "MBR0003";

	/** 사용 가능한 적립금이 부족합니다. */
	public static final String ERROR_MEMBER_SAVED_MONEY_REDUCE_NO_RMN_AMT = "MBR0004";

	/** 적립금 이력이 존재하지 않습니다. */
	public static final String ERROR_MEMBER_SAVED_MONEY_NO_DATA = "MBR0005";

	/** 원 적립금을 초과하여 적립할 수 없습니다. */
	public static final String ERROR_MEMBER_SAVED_MONEY_NOT_OVER_SAVE = "MBR0006";

	/** 이미 사용 중인 이메일입니다. */
	public static final String ERROR_MEMBER_DUPLICATION_EMAIL = "MBR0007";

	/** 이미 사용 중인 휴대폰 번호입니다. */
	public static final String ERROR_MEMBER_DUPLICATION_MOBILE = "MBR0008";

	/** 회원정보 수정에 실패하였습니다. */
	public static final String ERROR_MEMBER_UPDATEINFO_FAIL = "MBR0009";

	/** 회원정보가 일치하지 않습니다. */
	public static final String ERROR_MEMBER_NOT_MATCH_MEMBER = "MBR0010";

	/** 이미 사용 중인 닉네임 입니다. */
	public static final String ERROR_MEMBER_DUPLICATION_NICK_NM = "MBR0011";

	/** 정확한 이메일 주소를 입력하세요. */
	public static final String ERROR_MEMBER_IN_VALID_EMAIL = "MBR0012";

	/** 정확한 이메일 주소를 입력하세요. */
	public static final String ERROR_MEMBER_IN_VALID_PRFL_IMG = "MBR0013";
	

	/** 회원과 휴대폰 명의가 동일해야 이용이 가능합니다.  */
	public static final String ERROR_MEMBER_NOT_EQUAL_MBR_NM = "MBR0014";
	
	/** 인증시간이 초과했습니다. */
	public static final String ERROR_OVERTIME_CERT = "MBR0015";

	/** 인증번호가 틀렸습니다.다시 입력해주세요.  */
	public static final String ERROR_INVALID_CERT_KEY = "MBR0016";

	/** 고객님이 이전에 본인인증 했던 아이디를 찾았습니다. {0}로 로그인해서 이용해주세요. */
	public static final String ERROR_IS_ALREADY_INTEGRATE = "MBR0017";

	/** 고객님이 이전에 본인인증 했던 아이디를 찾았어요. {0}로 로그인해서 이용해주세요. */
	public static final String ERROR_IS_ALREADY_INTEGRATE_MSG = "MBR0018";
	
	// =======================================================
	// 전시 : DSP
	// =======================================================
	/** 사용중인 템플릿 입니다. */
	public static final String ERROR_DISPLAY_TEMPLATE_IN_USE = "DSP0000";

	/** 하위카테고리가 존재합니다. */
	public static final String ERROR_DISPLAY_CATEGORY_LOWER_IN_USE = "DSP0002";

	/** 대표 전시 상품이 존재하지 않습니다. */
	public static final String ERROR_DISPLAY_GOODS_DELEGATE_NO_USE = "DSP0003";

	/** 카테고리가 존재하지 않습니다. */
	public static final String ERROR_CATE_NO_DATA = "DSP0004";

	/** 카테고리 레벨이 정확하지 않습니다. */
	public static final String ERROR_CTG_NO_DATA = "DSP0005";

	/** 데이터가 존재하여 최하위 여부로 변경하실수 없습니다. */
	public static final String ERROR_DISPLAY_LEAF = "DSP0006";

	/** 상위 카테고리가 이미 최하위 카테고리 입니다. */
	public static final String ERROR_DISPLAY_UP_LEAF = "DSP0007";

	/** 해당몰의 전체 카테고리 정보가 존재하지 않습니다. */
	public static final String ERROR_ALLCATE_NO_DATA = "DSP0008";

	/** 존재하지 않는 판매자입니다. */
	public static final String ERROR_SELLER_NO_DATA = "DSP0009";

	
	// =======================================================
	// 마케팅 : PRO
	// =======================================================
	/** 이벤트가 존재하지 않습니다. */
	public static final String ERROR_PRO_NO_EVENT = "PRO0001";

	 /** 필수 입력값 에러 입니다.*/
	public static final String ERROR_EVENT_WIN_REGISTER_REQUIRED_FIELD = "PR00002";
	// =======================================================
	// 상품 : GDS
	// =======================================================
	/*상품 상세 페이지로 연결 할 수 없습니다. 유효하지 않은 상품이거나 사은품은 구매 불가합니다. 상품을 다시 확인 해 주세요.*/
	/** 상품 상세 페이지로 연결 할 수 없습니다.  */
	public static final String ERROR_GOODS_DENIED = "GDS0000";

	/** 상품문의는 본인만 삭제가 가능합니다. */
	public static final String ERROR_GOODS_INQUIRY_NO_EQUAL_MBR = "GDS0001";
	
	/** 상품평가는 본인만 수정이 가능합니다. */
	public static final String ERROR_GOODS_COMMENT_NO_EQUAL_MBR = "GDS0002";
	
	/** 상품이 존재하지 않습니다. */
	public static final String ERROR_GOODS_NO_DATA = "GDS0003";
	
	/** 선택하신 단품이 존재하지 않습니다. */
	public static final String ERROR_GOODS_NO_OPTION = "GDS0005";
	
	/** 판매기간 시작일이 현재시간 보다 적습니다.\n현재시작보다 크게 변경해주세요. */
	public static final String ERROR_GOODS_SALE_STRT_DTM = "GDS0007";

	/** 상품 가격 종료일시 수정에 실패했습니다. */
	public static final String ERROR_UPDATE_SALE_END_DTM = "GDS0008";

	/** 가격 시작일이 진행중인 가격 종료일 보다 커야합니다.*/
	public static final String ERROR_GOODS_SALE_END_DTM = "GDS0009";

	/** 변경하려는 종료일이 없습니다.*/
	public static final String ERROR_GOODS_SALE_END_DTM_NOT_EXIST = "GDS0010";
	
	/** 옵션명이 존재하지 않습니다. */
	public static final String ERROR_GOODS_ATTRNM_NOT_EXIST = "GDS0011";

	/** 옵션이 존재하지 않습니다. */
	public static final String ERROR_GOODS_ATTRNO_NOT_EXIST = "GDS0012";

	/** 상품의 현재 가격정보가 올바르지 않습니다. */
	public static final String ERROR_GOODS_PRICE_ILLEGAL_STATE = "GDS0013";

	/** 상품의 공급가, 수수료 정보가 올바르지 않습니다. */
	public static final String ERROR_GOODS_SPL_AMT_CMS_RATE_ILLEGAL = "GDS0014";
	
	/** 표시유통기한은 현재날짜보다 커야합니다. */
	public static final String ERROR_GOODS_EXP_DT = "GDS0015";

	/** 이미지 리사이징에 실패하였습니다. */
	public static final String ERROR_GOODS_IMAGE_RESIZE = "GDS0019";

	/** 이미 신고한 후기에요 */
	public static final String ERROR_GOODS_COMMENT_REPORT = "GDS0020";
	
	/** 판매기간 시작일이 현재시간 +30분 보다 적습니다. */
	public static final String ERROR_GOODS_SALE_STRT_DTM_ADD = "GDS0021";
	
	/** 진행중인  현재 가격이 상품 금액 유형 코드가 일반이 아닌 경우 수정이 불가합니다. */
	public static final String ERROR_GOODS_AMT_TP_10 = "GDS0022";

	
	// =======================================================
	// 주문/클레임 : ORD
	// =======================================================
	/** 주문금액과 결제금액이 일치하지 않습니다. */
	public static final String ERROR_ORDER_PAY_AMT_NO_MATCH = "ORD0001";

	/** 상품준비중인 상태에서만 송장등록이 가능합니다. */
	public static final String ERROR_DELIVERY_POSSIBLE_INVOICE_READY = "ORD0002";

	/** 회수지시인 상태에서만 송장등록이 가능합니다. */
	public static final String ERROR_DELIVERY_POSSIBLE_INVOICE_COMMAND = "ORD0003";

	/** 주문 정보나 배송 정보가 올바르지 않습니다. */
	public static final String ERROR_ORDER_CREATE_INFO = "ORD0006";

	/** 현금영수증으로 접수나 승인된 건이 이미 존재합니다. */
	public static final String ERROR_CASH_RECEIPT_EXISTS = "ORD0007";

	/** 세금계산서로 접수나 승인된 건이 이미 존재합니다. */
	public static final String ERROR_TAX_INVOICE_EXISTS = "ORD0008";

	/** 현금영수증 재발행할 대상건이 존재하지 않습니다. */
	public static final String ERROR_CASH_RE_PUBLISH_NOT_EXISTS = "ORD0009";

	/** 장바구니 상품이 존재하지 않습니다. */
	public static final String ERROR_CART_NOT_EXISTS = "ORD0013";

	/** 클레임이 존재하지 않습니다. */
	public static final String ERROR_CLAIM_NOT_EXISTS = "ORD0014";

	/** 주문번호 및 이메일을 확인해 주세요. */
	public static final String ERROR_ORDER_NO_MATCH = "ORD0015";

	/** 주문상품이 존재하지 않습니다. */
	public static final String ERROR_ORDER_NO_GOODS = "ORD0016";

	/** 클레임에 이미 취소건이 존재 합니다. */
	public static final String ERROR_CLAIM_CANCEL_EXISTS = "ORD0017";

	/** 주문데이터의 상태가 이미 취소상태 입니다. */
	public static final String ERROR_ORDER_CANCEL_STATUS = "ORD0018";

	/** 주문 상세 데이터의 상태가 이미 취소상태 입니다. */
	public static final String ERROR_ORDER_DETAIL_CANCEL_STATUS = "ORD0019";

	/** 주문 상세 데이터의 상태가 취소 불가한 상태 입니다. */
	public static final String ERROR_ORDER_DETAIL_CANCEL_IMPOSSIBLE_STATUS = "ORD0020";

	/** 현금 영수증 취소 오류 입니다. */
	public static final String ERROR_ORDER_CANCEL_TAX_CASH = "ORD0021";

	/** 세금 계산서 취소 오류 입니다. */
	public static final String ERROR_ORDER_CANCEL_TAX_INVOICE = "ORD0022";

	/** 주문 정보가 존재하지 않습니다. */
	public static final String ERROR_ORDER_NO_BASE = "ORD0023";

	/** 결제정보가 존재하지 않습니다. */
	public static final String ERROR_ORDER_NO_PAY = "ORD0024";

	/** 배송정보가 존재하지 않습니다. */
	public static final String ERROR_ORDER_NO_DELIVERY = "ORD0025";

	/** 주문이 접수상태가 아닌 경우 결제완료하실 수 없습니다. */
	public static final String ERROR_PAY_COMPLETE_ORDER_STATUS = "ORD0026";

	/** 결제 승인에 실패하였습니다. */
	public static final String ERROR_ORDER_PAY_APPROVE_FAIL = "ORD0027";

	/** 동일한 단품으로 변경하실 수 없습니다. */
	public static final String ERROR_ORDER_NO_CHANGE_ITEM = "ORD0028";

	/** 배송 불가능한 상품이 존재합니다. */
	public static final String ERROR_ORDER_IMPOSSIBLE_GOODS = "ORD0029";

	/** 유효하지 않은 결제수단입니다. */
	public static final String ERROR_ORDER_PAY_MEAN = "ORD0030";

	/** 사용가능한 적립금이 없습니다. */
	public static final String ERROR_ORDER_NONE_SAVE_MONEY = "ORD0031";

	/** 단품에 추가할인금이 존재하므로 단품변경이 불가 합니다. */
	public static final String ERROR_ITEM_ADD_SALE_AMT_EXISTS = "ORD0032";

	/** 결제가 완료된 건입니다. */
	public static final String ERROR_PAY_COMPLETE_STATUS = "ORD0033";

	/** 완료할 수 있는 결제수단이 아닙니다. */
	public static final String ERROR_PAY_COMPLETE_MEANS = "ORD0034";

	/** 클레임 접수취소가 불가능한 상태입니다. */
	public static final String ERROR_CLAIM_ACCEPT_NO_CANCEL = "ORD0035";

	/** 신청 가능한 수량을 초과하였습니다. */
	public static final String ERROR_CLAIM_CLAIM_QTY = "ORD0036";

	/** 장바구니에 담길 상품이 존재하지 않습니다. */
	public static final String ERROR_ORDER_CART_ADD_NO_ITEM = "ORD0037";

	/** 상품의 최소구매수량보다 부족합니다. */
	public static final String ERROR_ORDER_CART_MIN_QTY = "ORD0038";

	/** 상품의 최대구매 수량을 초과하였습니다. */
	public static final String ERROR_ORDER_CART_MAX_QTY = "ORD0039";

	/** 장바구니에 동일한 옵션의 상품이 존재합니다. */
	public static final String ERROR_ORDER_CART_DUPLICATE_ITEM = "ORD0040";

	/** 적립금을 사용하실 수 없습니다. */
	public static final String ERROR_ORDER_NO_USE_SVMN = "ORD0041";

	/** 보유하신 적립금을 초과해서 사용하실 수 없습니다. */
	public static final String ERROR_ORDER_OVER_USE_SVMN = "ORD0042";

	/** 판매가 불가능한 상품이 존재합니다. */
	public static final String ERROR_ORDER_SALE_PSB = "ORD0043";

	/** 재고가 부족한 상품이 존재합니다. */
	public static final String ERROR_ORDER_WEB_STK_QTY = "ORD0044";

	/** 품절되었습니다. */
	public static final String ERROR_ORDER_ITEM_WEB_STK_QTY = "ORD0045";

	/** 현재 재고는 {}개 입니다. */
	public static final String ERROR_ORDER_ITEM_NOEW_WEB_STK_QTY = "ORD0046";

	/** 변경된 내역이 존재하지 않습니다. */
	public static final String ERROR_ORDER_CART_NO_OPTION_CHAGE = "ORD0047";

	/** 배송지시 대상건이 존재하지 않습니다. */
	public static final String ERROR_DELIVERY_STATUS_03_NOT_EXISTS = "ORD0048";

	/** 주문취소는 접수취소가 불가능 합니다. */
	public static final String ERROR_CLAIM_ACCEPT_NO_CANCEL_TP_CANCEL = "ORD0049";

	/** 접수가 불가능한 상태입니다. */
	public static final String ERROR_CLAIM_ACCEPT_STATUS = "ORD0050";

	/** 클레임 사유가 입력되지 않았습니다. */
	public static final String ERROR_CLAIM_NO_REASON = "ORD0051";

	/** 주문접수시에는 전체취소만 가능합니다. */
	public static final String ERROR_CLAIM_ALL_CANCEL_STAT_10 = "ORD0052";

	/** 주문 수량보다 재고가 부족합니다 . */
	public static final String ERROR_ORDER_ITEM_CHANGE_NO_WEB_STK_QTY = "ORD0053";

	/** 반품/교환은 전체 신청이 불가능 합니다. */
	public static final String ERROR_CLAIM_ACCEPT_RTN_EXC_NO_ALL = "ORD0054";

	/** 반품/교환은 상품단위로 신청이 가능합니다. */
	public static final String ERROR_CLAIM_RTN_EXC_GOODS_POSSIBLE = "ORD0055";

	/** 클레임이 진행중입니다. */
	public static final String ERROR_ORDER_CLAIM_ING = "ORD0056";

	/** 취소된 주문입니다. */
	public static final String ERROR_ORDER_CANCEL_COMPLETE = "ORD0057";

	/** 구매완료는 배송중/배송완료 상태에서만 가능합니다. */
	public static final String ERROR_ORDER_DETAIL_PURCHASE = "ORD0058";

	/** 클레임 진행중에만 가능합니다. */
	public static final String ERROR_ORDER_CLAIM_ING_POSSIBLE = "ORD0059";

	/** 클레임 유형이 일치하지 않습니다. */
	public static final String ERROR_ORDER_CLAIM_NO_TP = "ORD0060";

	/** 회수완료 상태에서만 가능합니다. */
	public static final String ERROR_ORDER_CLAIM_WITHDRAW_COMPLETE = "ORD0061";

	/** 클레임 상품이 존재하지 않습니다. */
	public static final String ERROR_CLAIM_NO_GOODS = "ORD0062";

	/** 회수완료가 불가능한 상태입니다. */
	public static final String ERROR_CLAIM_WITHDRAW_IMPOSSIBLE = "ORD0063";
	
	/** 송장번호 입력이 불가능한 상태입니다. */
	public static final String ERROR_ORDER_CLAIM_EXCEL_IMPOSSIBLE = "ORD0064";

	/** 현재 주문상태에서는 단품변경이 불가능합니다. */
	public static final String ERROR_ORDER_NO_CHANGE_ITEM_STATUS = "ORD0065";

	/** 반품접수취소는 반품접수 및 반품회수지시 상태에서만 가능 합니다. */
	public static final String ERROR_CLAIM_ACCEPT_NO_CANCEL_TP_RETURN = "ORD0066";

	/** 교환접수취소는 교환회수접수 및 교환회수지시 또는 교환배송접수 및 교환배송지시 에만 가능 합니다. */
	public static final String ERROR_CLAIM_ACCEPT_NO_CANCEL_TP_EXCHANGE = "ORD0067";

	/** 기존 진행중인 반품이 존재하는 경우 반품접수를 하실 수 없습니다. */
	public static final String ERROR_CALIM_ACCEPT_RETRUN_DUPLICATE = "ORD0068";

	/** 구매확정이 불가능한 상태입니다. */
	public static final String ERROR_ORDER_IMPOSSIBLE_PURCHASE = "ORD0069";

	/** 판매가가 다른 옵션으로 변경이 불가능합니다. */
	public static final String ERROR_ORDER_OPTION_CHANGE_NO_MATCH_AMT = "ORD0070";

	/** 장바구니에 상품을 최대 50개까지 추가할 수 있어요 먼저 추가한 상품을 삭제 후 추가해주세요 */
	public static final String ERROR_CART_MAX_CNT = "ORD0071";
	
	/** 이미 장바구니에 추가되었어요 */
	public static final String ERROR_CART_EXIST = "ORD0072";
	
	/** 배송지 변경이 불가능한 주문 상태가 존재합니다. */
	public static final String ERROR_ORDER_DLVRA_CHANGE_STAT = "ORD0073";
	
	/** 차수가 생성되어 수정이 불가능합니다. */
	public static final String ERROR_ORDER_DLVRA_CHANGE_CIS_RETURN = "ORD0074";
	
	/** 예금주 성명이 일치하지 않습니다.*/
	public static final String ERROR_CERTIFY_ACCT_NM = "ORD0075";
	
	/** 차수가 생성되어 주문 취소가 불가능합니다. */
	public static final String ERROR_ORDER_CANCEL_CIS_RETURN_ERROR = "ORD0076";
	
	/** CIS 주문 취소 오류로 주문 취소가 불가능합니다. */
	public static final String ERROR_CIS_ORDER_CANCEL = "ORD0077";

	/** 주문 상세 구성 상품이 존재하지 않습니다. */
	public static final String ERROR_ORDER_DTL_CSTRT_GOODS = "ORD0078";
	
	/** CIS 배송지 변경 인터페이스 중 오류가 발생했습니다. */
	public static final String ERROR_CIS_DLVRA_UPDATE_ERROR = "ORD0079";
	
	/** {0}된 상품으로 구매가 불가능합니다. */
	public static final String ERROR_INSERT_CART_ERROR = "ORD0080";
	
	/** CIS 출고 차수 생성 여부 인터페이스 중 오류가 발생했습니다. */
	public static final String ERROR_CIS_GET_EXPT_CREATE_ERROR = "ORD0081";
	
	/** 반품 완료는 클레임 상세 전체 건만 가능합니다. */
	public static final String ERROR_CLM_RETURN_COMPLETE_ERROR = "ORD0082";
	
	//100 ~  - 주문서 체크
	/** 상품 배송 예정일이 변경되었어요 배송일을 다시 확인해주세요 */
	public static final String ERROR_CHANGE_ORD_DT = "ORD0100";
	
	//900 ~  - OrderComplete 체크
	/** 배송이 마감되었습니다. 다시 주문하시기 바랍니다. */
	public static final String ERROR_DLVR_SLOT_CLOSE = "ORD0900";
	
	// =======================================================
	// 결제 : PAY
	// =======================================================

	/** 현금 환불 내역이 존재하지 않습니다. */
	public static final String ERROR_PAY_CASHE_REFUND_NO_EXISTS = "PAY0001";

	/** 현금 환불은 진행 상태에서만 가능합니다. */
	public static final String ERROR_PAY_CASHE_REFUND_COMPLETE_STATUS = "PAY0002";

	/** 원 결제정보가 존재하지 않습니다. */
	public static final String ERROR_PAY_NO_ORG_INFO = "PAY0003";

	/** 환불가능한 결제금액이 부족합니다. */
	public static final String ERROR_PAY_AMT_LESS = "PAY0004";


	/** 기본결제수단 등록 불가. */
	public static final String ERROR_SAVE_DEFAULT_PAY_METHOD = "PAY0005";

	/** PG사로부터 결제실패통보를 받았습니다. */
	public static final String ERROR_PG_FAIL = "PAY0006";

	/** 빌링 임시 등록 실패. */
	public static final String ERROR_SAVE_TEMP_PRSN_BILL = "PAY0007";

	/** 빌링 등록 실패. */
	public static final String ERROR_SAVE_PRSN_BILL = "PAY0008";

	/** 결제를 취소하셨습니다. (9993) */
	public static final String ERROR_PG_CANCEL = "PAY0009";

	/** PG사와 통신에 일시적인 장애가 있습니다. */
	public static final String ERROR_PG_CONNECTION = "PAY0010";

	// =======================================================
	// 배송 : DLV
	// =======================================================
	/** 배송정보가 존재하지 않습니다. */
	public static final String ERROR_DELIVERY_NO_EXISTS = "DLV0001";
	
	/** 배송정보가 기 등록된 건입니다. */
	public static final String ERROR_DELIVERY_ALREADY_USED = "DLV0002";
	
	/** 사용가능한 송장번호가 아닙니다. */
	public static final String ERROR_DELIVERY_INVALID_INVNO = "DLV0003";
	
	/** 송장추적 연동 중 오류 발생했습니다. */
	public static final String ERROR_DELIVERY_REQUEST_TRACE = "DLV0004";
	
	/** 송장번호를 등록할 수 없는 상태입니다. */
	public static final String ERROR_DELIVERY_INVALID_ORDCLM_STATUS = "DLV0010";
	
	/** 송장정보 등록 중 오류 발생했습니다. */
	public static final String ERROR_DELIVERY_INVNO_PROCESS_ERROR = "DLV0011";
	
	/** 등록되지 않은 택배사 코드입니다. */
	public static final String ERROR_DELIVERY_INVALID_HDCCD = "DLV0088";
	
	/** 굿스플로우 배송정보가 연동 중 오류 발생했습니다. */
	public static final String ERROR_DELIVERY_GOODSFLOW_ERROR = "DLV0099";
	
	/** 송장정보 등록 중 알 수 없는 오류 발생했습니다. */
	public static final String ERROR_DELIVERY_PROCESS_ERROR = "DLV0100";

	
	// =======================================================
	// 정산 : ADJ
	// =======================================================

	
	// =======================================================
	// 통계 : STA
	// =======================================================

	
	// =======================================================
	// 쿠폰 : COP
	// =======================================================
	/** 쿠폰번호를 다시 확인해주세요. */
	public static final String ERROR_COUPON_NO_DATA = "COP0001";

	/** 이미 등록된 쿠폰입니다. */
	public static final String ERROR_COUPON_ALREADY_USED = "COP0002";

	/** 발급기간이 종료되었습니다. */
	public static final String ERROR_COUPON_NO_PERIOD = "COP0003";

	/** 해당 쿠폰은 중복 사용할 수 없습니다. */
	public static final String ERROR_COUPON_NO_DUPLICATION = "COP0004";

	/** 정상 쿠폰이 아닙니다. */
	public static final String ERROR_COUPON_NO_NORMAL = "COP0005";

	/** 삭제하실수 없는 쿠폰입니다. */
	public static final String ERROR_COUPON_DELETE_CHECK = "COP0006";

	/** 쿠폰 발급이 마감되었습니다. */
	public static final String ERROR_COUPON_NO_AVAILABLE_QTY = "COP0007";

	/** 이미 등록된 쿠폰입니다. */
	public static final String ERROR_COUPON_ALREADY_DOWNLOAD = "COP0008";

	/** 쿠폰 삭제에 실패했습니다. */
	public static final String ERROR_COUPON_DELETE = "COP0009";

	/** 이미 사용된 쿠폰입니다. */
	public static final String ERROR_COUPON_USE = "COP0010";

	/** 정회원만 다운로드 가능합니다. */
	public static final String ERROR_COUPON_NOT_MATCHED_INTERGRATED_MBR = "COP0011";

	/** 준회원만 다운로드 가능합니다. */
	public static final String ERROR_COUPON_NOT_MATCHED_ASSOCIATE_MBR = "COP0012";

	/** 아쉽지만 쿠폰 발급대상이 아니에요. */
	public static final String ERROR_COUPON_NOT_MATCHED_MBR_GRD = "COP0013";

	/** 쿠폰코드를 다시 확인해주세요. */
	public static final String ERROR_COUPON_CD_DATA = "COP0014";

	/** 발급중인 쿠폰과 쿠폰코드가 동일합니다. */
	public static final String ERROR_COUPON_SAME_DOWNLOAD = "COP0015";

	
	// =======================================================
	// 상담 : CNS
	// =======================================================
	/** 상담내역이 존재하지 않습니다. */
	public static final String ERROR_COUNSEL_NO_DATA = "CNS0001";

	/** 상담이 완료 또는 취소된 건은 처리내용을 등록하실 수 없습니다. */
	public static final String ERROR_COUNSEL_PROCESS_NO_INSERT = "CNS0002";

	/** 상담취소는 접수중인 경우에만 가능합니다. */
	public static final String ERROR_COUNSEL_NO_CANCEL_STATUS = "CNS0003";

	/** 상담 담당자 변경은 접수/처리중인 경우에만 가능합니다. */
	public static final String ERROR_COUNSEL_NO_CHARGE_STATUS = "CNS0004";

	/** 상담취소는 답변대기인 경우에만 가능합니다. */
	public static final String ERROR_COUNSEL_NO_CANCEL_STATUS_NOT_WAITING = "CNS0005";
	
	// =======================================================
	// CIS API
	// =======================================================
	public static final String ERROR_API_UNKNOWN = "API0000";
	public static final String ERROR_API_BAD_REQUEST = "API0400";
	public static final String ERROR_API_FORBIDDEN = "API0403";
	public static final String ERROR_API_NOT_FOUND = "API0404";
	public static final String ERROR_API_METHOD_NOT_ALLOWED = "API0405";
	public static final String ERROR_API_NOT_ACCEPTABLE = "API0406";
	public static final String ERROR_API_PROXY_AUTHENTICATION_REQUIRED = "API0407";
	public static final String ERROR_API_REQUEST_TIMEOUT = "API0408";
	public static final String ERROR_API_CONFLICT = "API0409";
	public static final String ERROR_API_GONE = "API0410";
	public static final String ERROR_API_LENGTH_REQUIRED = "API0411";
	public static final String ERROR_API_PRECONDITION_FAILED = "API0412";
	public static final String ERROR_API_REQUEST_TOO_LONG = "API0413";
	public static final String ERROR_API_REQUEST_URI_TOO_LONG = "API0414";
	public static final String ERROR_API_UNSUPPORTED_MEDIA_TYPE = "API0415";
	public static final String ERROR_API_REQUESTED_RANGE_NOT_SATISFIABLE = "API0416";
	public static final String ERROR_API_EXPECTATION_FAILED = "API0417";
	public static final String ERROR_API_INSUFFICIENT_SPACE_ON_RESOURCE = "API0419";
	public static final String ERROR_API_METHOD_FAILURE = "API0420";
	public static final String ERROR_API_UNPROCESSABLE_ENTITY = "API0422";
	public static final String ERROR_API_LOCKED = "API0423";
	public static final String ERROR_API_FAILED_DEPENDENCY = "API0424";
	public static final String ERROR_API_INTERNAL_SERVER_ERROR = "API0500";
	public static final String ERROR_API_NOT_IMPLEMENTED = "API0501";
	public static final String ERROR_API_BAD_GATEWAY = "API0502";
	public static final String ERROR_API_SERVICE_UNAVAILABLE = "API0503";
	public static final String ERROR_API_GATEWAY_TIMEOUT = "API0504";
	public static final String ERROR_API_HTTP_VERSION_NOT_SUPPORTED = "API0505";
	public static final String ERROR_API_INSUFFICIENT_STORAGE = "API0507";

	// =======================================================
	// 업체 : COMP
	// =======================================================
	/** 등록된 업체기 존재 합니다. */
	public static final String ERROR_COMP_REG_EXIST = "COMP0001";
	
	
	// =======================================================
	// Tag 관리
	// =======================================================
	
	/** 하위 그룹이 있습니다. 하위 그룹을 먼저 삭제해 주세요. */
	public static final String ERROR_UP_TAG_FAIL = "TAG0001";
	public static final String ERROR_TAG_NO_DATA = "TAG0002";

	// =======================================================
	// GSR API ERROR
	// =======================================================
	/** 알 수 없는 상태 코드 입니다.*/
	public static final String ERROR_GSR_API_UNKNOWN_CODE = "GSR00001";
	/** 응답 값이 없습니다. */
	public static final String ERROR_GSR_API_NOT_RESPONSE = "GSR00002";
	/** 포인트 금액 및 판매 날짜를 확인해주세요.*/
	public static final String ERROR_GSR_API_NECESSARY_FIELD_POINT_INFO = "GSR00007";
	/** 이름을 확인해주세요.*/
	public static final String ERROR_GSR_API_NECESSARY_FIELD_MEMBER_INFO_MBR_NM = "GSR00008";
	/** 핸드폰 번호는 하이픈 없이 10~11자 입니다. */
	public static final String ERROR_GSR_API_NECESSARY_FIELD_MEMBER_INFO_MOBILE = "GSR00009";
	/** 생일은 특수문자 없이 년월일 8자리 입니다.*/
	public static final String ERROR_GSR_API_NECESSARY_FIELD_MEMBER_INFO_BIRTH = "GSR00010";
	/** CI 인증값을 확인해주세요.*/
	public static final String ERROR_GSR_API_NECESSARY_FIELD_MEMBER_INFO_CI = "GSR00011";
	/** 통신사를 확인해주세요.*/
	public static final String ERROR_GSR_API_NECESSARY_FIELD_MEMBER_INFO_TEL_GB = "GSR00012";
	/** 성별을 확인해주세요.*/
	public static final String ERROR_GSR_API_NECESSARY_FIELD_MEMBER_INFO_GD_GB_CD = "GSR00013";
	/** 영수증 번호(=주문 번호)는 20자를 넘을 수 없습니다.*/
	public static final String ERROR_GSR_API_NECESSARY_FIELD_POINT_RCPT_NO = "GSR00014";
	/** 영수증 번호(=주문 번호)는 숫자만 가능합니다. */
	public static final String ERROR_GSR_API_NECESSARY_FIELD_POINT_RCPT_NO_ONLY_NUMBER = "GSR00015";
	/** 거래 번호 및 거래 일시를 확인해주세요.(org_appr_no,org_appr_date) */
	public static final String ERROR_GSR_API_NECESSARY_FIELD_ORG_APPR_NO_AND_DATE = "GSR00016";
	/** 중복 된 회원 정보가 있습니다.*/
	public static final String ERROR_GSR_API_DUPLICATE_MEMBER = "GSR10003";
	/** 자료가 존재하지 않습니다. */
	public static final String ERROR_GSR_API_IS_NOT_EXISTS = "GSR10029";
	/** 고객 정보가 존재하지 않습니다.*/
	public static final String ERROR_GSR_API_NOT_FOUND = "GSR30018";
	/** 만 14세 미만은 가입할 수 없습니다.*/
	public static final String ERROR_GSR_API_LIMIT_AGE = "GSR7063";
	/** 시스템오류가 발생하였습니다.*/
	public static final String ERROR_GSR_API_SYSTEM = "GSR7999";
	/** 올바르지 않은 요청 입니다.*/
	public static final String ERROR_GSR_API_BAD_REQUEST = "GSR50002";
	/** CRM INSERT ERROR*/
	public static final String ERROR_GSR_API_INSERT_ERROR = "GSR1000";
	/** yyyyMMdd 형식으로 입력 해주세요. */
	public static final String ERROR_GSR_API_INVALID_DATE_FORMAT = "GSR00017";
	/** 시분초 6자리로 입력 해주세요. */
	public static final String ERROR_GSR_API_INVALID_TIMESTAMP_FORMAT = "GSR00018";
	/** GS 휴먼 고객 입니다. */
	public static final String ERROR_GSR_API_DORMANT_MEMBER = "GSR00019";
	/** GS 탈퇴 회원 입니다. */
	public static final String ERROR_GSR_API_DEL_MEMBER = "GSR00020";
	/** 포인트 사용 및 적립이 정상적으로 처리 안된 주문 입니다. */
	public static final String ERROR_GSR_API_NOT_EXSITS_APPR = "GSR00021";
	/** 홈쇼핑 회원 */
	public static final String ERROR_GSR_API_HOME_SHOP_MEMBER = "GSR7008";

	public static final String ERROR_PET_CNT = "PET00001";


	/*
	R3K 관련 EXCEPTION CODE , 메세지 정의 필요
	 */
	
	/** 소켓 통신 불가 시 */
	public static final String ERROR_R3K_SOCKET_OPEN = "R3K0001";
	
	/** 메세지 전송 시 */
	public static final String ERROR_R3K_SOCKET_SEND_MSG = "R3K0002";
	
	/** 소켓 포트 닫을 때 */
	public static final String ERROR_R3K_SOCKET_CLOSE = "R3K0003";
	
	/** 응답값이 정상이 아닐 때*/
	public static final String ERROR_R3K_SOCKET_RECEIVE = "R3K0004";
	
	// =======================================================
	// SKT MP 포인트 : SKTMP
	// =======================================================
	
	
	/** 재요청 필요 - 알수 없는 오류  */
	public static final String ERROR_SKTMP_RE_REQ_DEFAULT= "SKTMP100";
	
	/** 재요청 필요 - 1일 1회 적립  */
	public static final String ERROR_SKTMP_RE_REQ_DAY_ACCUM = "SKTMP101";
	
	/** 재요청 필요 - 이전 요청 오류  */
	public static final String ERROR_SKTMP_RE_REQ_PRE_ERROR= "SKTMP102";
	
	/** 1일 1회 초과 적립으로 재전송불가합니다.  */
	public static final String ERROR_SKTMP_OVER_ACCUM= "SKTMP200";
	
	/** 우주코인 이전 요청 건 오류로 클레임 접수가 불가능합니다.  */
	public static final String ERROR_SKTMP_REQ_PRE_ERROR= "SKTMP201";
	
	/** 우주코인 적립 정보가 변경되었습니다. 다시 주문해주세요.  */
	public static final String ERROR_SKTMP_ACCUM_POINT = "SKTMP997";
	
	/** 우주코인 관련 정보가 변경되었습니다. 다시 주문해 주세요.  */
	public static final String ERROR_SKTMP_SAME_IF_GOODS_CD = "SKTMP998";
	
	/** 우주코인 승인 요청 중 오류가 발생했습니다.                 */
	public static final String ERROR_SKTMP_RESPONSE = "SKTMP999";
	
    /** 취소불가 기취소거래                                                 */
	public static final String ERROR_SKTMP_ALREADY_CANCEL = "SKTMP01";
	/** 취급기관 오류                                                       */
	public static final String ERROR_SKTMP_AGENCY = "SKTMP14";
	/** 가맹점 코드 오류                                                    */
	public static final String ERROR_SKTMP_COMP_CODE = "SKTMP15";
	/** 통화코드 오류                                                       */
	public static final String ERROR_SKTMP_CURR = "SKTMP16";
	/** 거래금액 오류                                                       */
	public static final String ERROR_SKTMP_DEAL_AMT = "SKTMP17";
	/** TRACK II 오류                                                       */
	public static final String ERROR_SKTMP_CARD_NO = "SKTMP18";
	/** 취소구분(11:통신장애,12:지연응답,91:단말기취소등)오류               */          
	public static final String ERROR_SKTMP_CANCEL_GB = "SKTMP19";
	/** 취소할 승인번호 오류                                                */
	public static final String ERROR_SKTMP_CANCEL_APPR_NO = "SKTMP20";
	/** 전문 ID 오류                                                        */
	public static final String ERROR_SKTMP_MSG_ID = "SKTMP21";
	/** 상품코드 오류                                                       */
	public static final String ERROR_SKTMP_GOODS_CD = "SKTMP22";
	/** SK-T 제휴카드 아님                                                  */
	public static final String ERROR_SKTMP_NOT_PARTNER_CARD = "SKTMP28";
	/** SK-T 제휴 모네타 카드 아님                                          */
	public static final String ERROR_SKTMP_NOT_PARTNER_MN_CARD = "SKTMP29";
	/** 사용불능 카드. 고객센터 문의 요망                                   */    
	public static final String ERROR_SKTMP_UNUSEABLE_CARD = "SKTMP30";
	/** 사용정지 카드                                                       */
	public static final String ERROR_SKTMP_USE_STOP_CARD = "SKTMP31";
	/** 조회불능 카드                                                       */
	public static final String ERROR_SKTMP_NOT_SEARCH_CARD = "SKTMP32";
	/** 불량가맹점                                                          */
	public static final String ERROR_SKTMP_POOR_COMP = "SKTMP33";
	/** 말소가맹점                                                          */
	public static final String ERROR_SKTMP_NONE_COMP = "SKTMP34";
	/** 등록 VAN사 다름                                                     */
	public static final String ERROR_SKTMP_NOT_VAN = "SKTMP35";
	/** 말소 단말기                                                         */
	public static final String ERROR_SKTMP_NOT_DEVICE = "SKTMP36";
	/** 카드 유효기간 만료                                                  */
	public static final String ERROR_SKTMP_EXPIRE_CARD = "SKTMP37";
	/** 유효기간 표시                                                       */
	public static final String ERROR_SKTMP_NOTICE_CARD_DATE = "SKTMP38";
	/** 1일 사용 금액 한도 초과                                             */
	public static final String ERROR_SKTMP_DAY_USE_AMT = "SKTMP40";
	/** 연간 사용 금액 한도 초과                                            */
	public static final String ERROR_SKTMP_YEAR_USE_AMT = "SKTMP41";
	/** 1일 사용회수 한도 초과                                              */
	public static final String ERROR_SKTMP_DAY_USE_NUMBER = "SKTMP42";
	/** 연간 사용회수 한도 초과                                             */
	public static final String ERROR_SKTMP_YEAR_USE_NUMBER = "SKTMP43";
	/** 개인한도 소진                                                       */
	public static final String ERROR_SKTMP_LIMIT_AMT = "SKTMP45";
	/** 잔여 한도 부족                                                      */
	public static final String ERROR_SKTMP_LIMT_REMAIN = "SKTMP45";
	/** 거래금액이 실사용금액+부스트업 합계 금액 미달                       */          
	public static final String ERROR_SKTMP_BOOST_DEAL_AMT = "SKTMP46";
	/** 취소할 승인번호 없음                                                */
	public static final String ERROR_SKTMP_NOT_CANCEL_APPR_NO = "SKTMP50";
	/** 취소할 금액이 다름                                                  */
	public static final String ERROR_SKTMP_NOT_CANCEL_AMT = "SKTMP51";
	/** 해당회원아님                                                        */
	public static final String ERROR_SKTMP_NOT_MEMBER = "SKTMP52";
	/** 멤버쉽 번호 Update 필요                                             */
	public static final String ERROR_SKTMP_UPEDATE_CARD_NO = "SKTMP53";
	/** 고객 인증 오류                                                      */
	public static final String ERROR_SKTMP_CERT_MEMBER = "SKTMP54";
	/** 나이제한                                                            */
	public static final String ERROR_SKTMP_AGE = "SKTMP56";
	/** 거래요일오류                                                        */
	public static final String ERROR_SKTMP_DEAL_DATE = "SKTMP57";
	/** 이미가입되어있음                                                    */
	public static final String ERROR_SKTMP_ALREADY_MEMBER = "SKTMP58";
	/** PIM번호 불일치                                                      */
	public static final String ERROR_SKTMP_PIN_NO = "SKTMP60";
	/** 잘못된 PIN 번호 요청                                                */
	public static final String ERROR_SKTMP_WRONG_PIN_NO = "SKTMP71";
	/** Check기준 오류                                                      */
	public static final String ERROR_SKTMP_CHECK_STANDARD = "SKTMP80";
	/** VIP아님                                                             */
	public static final String ERROR_SKTMP_VIP = "SKTMP81";
	/** 잘못된 바코드 승인 요청                                             */
	public static final String ERROR_SKTMP_BARCODE = "SKTMP82";
	/** 잘못된 OTB로 승인 요청, 없는 OTB 번호                               */  
	public static final String ERROR_SKTMP_OTB = "SKTMP84";
	/** 30일 해지요청 유예상태로 적립 요청 오류                             */      
	public static final String ERROR_SKTMP_30_ACCUM= "SKTMP85";
	/** 30일 해지요청 유예상태로 할인 요청 오류                             */      
	public static final String ERROR_SKTMP_30_DISCOUNT = "SKTMP86";
	/** 재조회 카드사장애                                                   */
	public static final String ERROR_SKTMP_CARD_COMP_DB= "SKTMP90";
	/** 재조회 카드사장애                                                   */
	public static final String ERROR_SKTMP_CARD_COMP_SYSTEM = "SKTMP91";
	/** 승인거절                                                            */
	public static final String ERROR_SKTMP_APPR_REFUSE = "SKTMP92";
	/** 재조회 카드사장애                                                   */
	public static final String ERROR_SKTMP_CARD_COMP_REFUSE = "SKTMP99";
}