package biz.interfaces.humuson.constants;

import framework.common.util.FileUtil;


/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.itf.humuson.constants
* - 파일명		: HumusonConstants.java
* - 작성일		: 2017. 5. 24.
* - 작성자		: Administrator
* - 설명			: Humuson 상수 정의
* </pre>
*/
public class HumusonConstants {

	/*****************************
	 * 주문취소/반품신청/교환신청 구분
	 ****************************/
	/** 클레임 유형 : 주문취소 */
	public static final String EMAIL_CLAIM_TP_01 = "01";
	/** 클레임 유형 : 반품신청 */
	public static final String EMAIL_CLAIM_TP_02 = "02";
	/** 클레임 유형 : 교환신청 */
	public static final String EMAIL_CLAIM_TP_03 = "03";

	/** 배송 유형 : 상품발송 */
	public static final String EMAIL_DLVR_TP_01 = "01";
	/** 배송 유형 : 배송완료 */
	public static final String EMAIL_DLVR_TP_02 = "02";

}