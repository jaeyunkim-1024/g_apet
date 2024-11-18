package biz.interfaces.nicepay.model.request;

import java.io.Serializable;

import lombok.Data;
import lombok.EqualsAndHashCode;


/**
 * <pre>
 * - 프로젝트명	: gs-apet-11-business
 * - 패키지명	: biz.interfaces.nicepay.model.request
 * - 파일명		: RequestForm.java
 * - 작성일		: 2021. 01. 12.
 * - 작성자		: JinHong
 * - 설명		: nicePay Request Common Form
 * </pre>
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class RequestCommonVO implements Serializable {
	private static final long serialVersionUID = 1L;
	
	/** transaction 아이디 생성규칙
	 * 보안진단 처리 : 주석으로 된 시스템 주요 정보 삭제 
	*/
	private String TID;
	
	/** 상점 ID */
	private String MID;
	
	/** 상점 key */
	private String MerchanKey;
	
	/** 위변조 검증 Data 
	 * Hex(SHA256(MID + ReceiptAmt + EdiDate + Moid + MerchantKey))
	 * */
	private String SignData;
	
	/** 전문생성일시. (YYYYMMDDHHMISS) */
	private String EdiDate;
	
	/** 응답파라메터 인코딩 방식
	 * 가맹점 서버의 encoding 방식 전달
	 * 예시) utf-8 / euc-kr(Default) 
	*/
	private String CharSet;
	
	/** 응답전문 유형 (default(미설정): JSON / KV(설정): Key=Value형식 응답) */
	private String EdiType;
}
