package biz.app.claim.model;

import java.io.Serializable;
import java.util.List;

import lombok.Data;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.claim.model
* - 파일명		: ClaimRegist.java
* - 작성일		: 2017. 3. 6.
* - 작성자		: snw
* - 설명			: 클레임 등록
* </pre>
*/
@Data
public class ClaimRegist implements Serializable {

	/** UID */
	private static final long serialVersionUID = 1L;

	/***************************
	 * 필수 변수
	 **************************/

	/** 주문 번호 */
	private String 	ordNo;

	/** 주문 매체 코드 */
	private String ordMdaCd;
	
	/** 클레임 유형 코드 */
	private String 	clmTpCd;

	/** 클레임 사유 코드 */
	private String	clmRsnCd;

	/** 클레임 사유 내용 */
	private String	clmRsnContent;
	
	/** CS 티켓 번호 */
	private String	twcTckt;
	

	/** 접수자 번호 */
	private Long		acptrNo;

	/*******************************
	 * 환불정보
	 *******************************/
	/** 은행 코드 */
	private String 	bankCd;

	/** 계좌 번호 */
	private String 	acctNo;

	/** 예금주 명 */
	private String 	ooaNm;
	
	/*******************************
	 * 변경된 배송지 정보
	 *******************************/
	/** 수취인 명 */
	private String	adrsNm;
	
	/** 전화 */
	private String	tel;
	
	/** 휴대폰 */
	private String	mobile;
	
	/** 우편번호 구 */
	private String	postNoOld;
	
	/** 지번 주소 */
	private String	prclAddr;
	
	/** 지번 상세 주소 */
	private String 	prclDtlAddr;
	
	/** 우편번호 신 */
	private String 	postNoNew;
	
	/** 도로명 주소 */
	private String	roadAddr;
	
	/** 도로명 상세 주소 */
	private String	roadDtlAddr;
	
	/** 배송 메모 */
	private String	dlvrMemo;

	/*******************************
	 * 교환의 맞교환 여부
	 *  - BO에서만 사용 가능
	 *******************************/
	private String	swapYn;
	
	/*******************************
	 * 추가 결제 정보
	 *******************************/
	
	/** 입금 은행 코드 */ 
	private String depositBankCd;
	/** 입금 예금주 명 */ 
	private String depositOoaNm;
	/** 입금  계좌번호*/ 
	private String depositAcctNo;
	/** 입금  금액 */ 
	private Long depositAmt;
	
	/** 입금자  휴대폰 번호*/ 
	private String depositMobile;
	
	/*
	 * INIpay 결제정보
	 */
	/** Web Standard 인증 정보 */ 
	private String inipayStdCertifyInfo;

	/** Web Mobile 인증 정보 */ 
	private String inipayMobileCertifyInfo;
	
	/*****************************************************************
	 * 클레임 유형별 변수 설정 방법
	 *  - 전체 클레임일 경우  : claimSubList 미설정 
	 *  - 상품단위 취소일 경우  : claimSubList 의 주문 상세 순번만 설정, 클레임수량 미설정
	 *  - 부분 클레임일 경우 주문상세순번과 클레임수량은 필수 입력
	 *****************************************************************/
	

	private Long orgItemNo;
	
	private List<ClaimSub> claimSubList;
	
	@Data
	public static class ClaimSub {
		
		/** 주문 상세 순번 */
		private Integer ordDtlSeq;

		/** 클레임 수량 */
		private Integer	clmQty;
		
		/*************************************
		 * 교환 변수
		 *  - 단품이 변경된 경우에만 입력
		 *  - 여러개 단품으로 변경된 경우도 가능
		 ************************************/
		/** 교환할 단품 번호 */
		private Long[] 	arrExcItemNo;
		/** 교환할 단품 수량 */
		private Integer[] 	arrExcQty;
	}
	
	
	/* 클레임 이미지 경로 */
	private List<String> imgPaths;
	
	
	/*******************************
	 * 변경된 교환 배송지 정보
	 *******************************/
	/** 수취인 명 */
	private String	chgAdrsNm;
	
	/** 전화 */
	private String	chgTel;
	
	/** 휴대폰 */
	private String	chgMobile;
	
	/** 우편번호 구 */
	private String	chgPostNoOld;
	
	/** 지번 주소 */
	private String	chgPrclAddr;
	
	/** 지번 상세 주소 */
	private String 	chgPrclDtlAddr;
	
	/** 우편번호 신 */
	private String 	chgPostNoNew;
	
	/** 도로명 주소 */
	private String	chgRoadAddr;
	
	/** 도로명 상세 주소 */
	private String	chgRoadDtlAddr;
	
	/** 배송 메모 */
	private String	chgDlvrMemo;
	
	/** 클레임 번호 */
	private String clmNo;
	
}