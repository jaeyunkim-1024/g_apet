package biz.interfaces.sktmp.constants;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.interfaces.sktmp.constants
* - 파일명		: SktmpConstants.java
* - 작성일		: 2021. 06. 28.
* - 작성자		: JinHong
* - 설명		: SKT MP 포인트 상수 정의
* </pre>
*/
public class SktmpConstants {
	
	/** ==================SKP MP Constants start ================= */
	
	/** 전문 유형 */
	/** MP 포인트 통합 승인/조회 요청 */
	public static final String MSG_TYPE_0500 = "0500";
	
	/** MP 포인트 통합 승인/조회 응답 */
	public static final String MSG_TYPE_0510 = "0510";
	
	/** MP 통합 취소 요청 */
	public static final String MSG_TYPE_0620 = "0620";
	
	/** MP 통합 취소 응답 */
	public static final String MSG_TYPE_0630 = "0630";
	
	/** 거래 구분 코드 : 승인 */
	public static final String DEAL_GB_APPROVE = "10";
	
	/** 거래 구분 코드 : 조회 */
	public static final String DEAL_GB_SEARCH = "20";
	
	/** 단말 : default */
	public static final String DEVICE_DEFALUT = "1000000000";
	
	/** 통화 코드 : 410 */
	public static final String CURR_KR = "410";
	
	/** 사용자 ID 구분 코드 : 사용자 ID  CHECK NO (아무것도 체크하지않음) */
	public static final String USER_ID_GB_00 = "00";
	/** 사용자 ID 구분 코드 : OTB */
	public static final String USER_ID_GB_01 = "01";
	/** 사용자 ID 구분 코드 : PIN & OTB */
	public static final String USER_ID_GB_02 = "02";
	/** 사용자 ID 구분 코드 : CI & OTB */
	public static final String USER_ID_GB_03 = "03";
	/** 사용자 ID 구분 코드 : CI & PIN & OTB */
	public static final String USER_ID_GB_04 = "04";
	/** 사용자 ID 구분 코드 : 리얼 멤버십 카드 번호 */
	public static final String USER_ID_GB_05 = "05";
	/** 사용자 ID 구분 코드 : PIN & 리얼 멤버십 카드 번호*/
	public static final String USER_ID_GB_06 = "06";
	/** 사용자 ID 구분 코드 : CI & 리얼 멤버십 카드 번호 */
	public static final String USER_ID_GB_07 = "07";
	/** 사용자 ID 구분 코드 : CI & PIN & 리얼 멤버십 카드 번호 */
	public static final String USER_ID_GB_08 = "08";
	/** 사용자 ID 구분 코드 : 미지정 */
	public static final String USER_ID_GB_09 = "09";
	
	/** 레인보우포인트 return byte 1 */
	/** 정상 멤버십 포인트 */
	public static final String USE_PNT_M = "M";
	/** 최종 잔여 포인트 사용시 */
	public static final String USE_PNT_L = "L";
	/** 최종 포인트 사용 후 */
	public static final String USE_PNT_R = "R";
	
	/** 레인보우포인트 return byte 2 */
	/** VIP 카드 */
	public static final String USER_GRD_V = "V";
	/** 일반 카드 */
	public static final String USER_GRD_A = "A";
	/** 골드 카드 */
	public static final String USER_GRD_G = "G";
	/** 실버 카드 */
	public static final String USER_GRD_S = "S";
	
	/** 취소 구분 코드 : 정상 취소 */
	public static final String CANCEL_GB_NORMAL = "91";

	/** 제휴사 코드 */
	public static final String PRTNR_CODE = "V798";

	/** 점포 코드 */
	public static final String STORE_CODE = "1001";

	/** 전문 성공 코드 */
	public static final String RES_SUCCESS_CODE = "00";
	
	/** ==================SKP MP Constants end ================= */
	
	
	/** ==================SKP MP API HUB start ================= */
	
	/** API HUB API ID */
	/** MP 포인트 조회 (가용, 적립예정) */
	public static final String SKT_MP_API_HUB_ISR3K00101 = "ISR3K00101";
	
	/** PIN 번호 체크 */
	public static final String SKT_MP_API_HUB_ISR3K00102 = "ISR3K00102";
	
	/** 소멸예정 포인트 조회하기 */
	public static final String SKT_MP_API_HUB_ISR3K00105 = "ISR3K00105";
	
	/** OTB 번호, PIN 번호로 멤버십카드번호 조회 */
	public static final String SKT_MP_API_HUB_ISR3K00106 = "ISR3K00106";
	
	/** 할인금액 및 잔여횟수 조회하기 */
	public static final String SKT_MP_API_HUB_ISR3K00107 = "ISR3K00107";
	
	/** 포인트 최대 사용 가능 금액 조회하기 */
	public static final String SKT_MP_API_HUB_ISR3K00108 = "ISR3K00108";
	
	/** 가용포인트 전환하기 */
	public static final String SKT_MP_API_HUB_ISR3K00109 = "ISR3K00109";
	
	/** 제휴사별 할인/적립/사용 횟수 제공 */
	public static final String SKT_MP_API_HUB_ISR3K00110 = "ISR3K00110";
	
	/** CI, MemebershipCardNumber 일치여부 확인 */
	public static final String SKT_MP_API_HUB_ISR3K00114 = "ISR3K00114";
	
	/** 전문 성공 코드 */
	public static final String API_HUB_SUCCESS_CODE = "00";
	
	/** ==================SKP MP API HUB end ================= */
}