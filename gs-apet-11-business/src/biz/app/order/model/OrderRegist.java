package biz.app.order.model;

import java.io.Serializable;

import lombok.Data;

/**
 * <pre>
 * - 프로젝트명	: 11.business
 * - 패키지명		: biz.app.order.model
 * - 파일명		: OrderRegist.java
 * - 작성일		: 2017. 1. 23.
 * - 작성자		: snw
 * - 설명		: 주문 등록 정보
 * </pre>
 */
@Data
public class OrderRegist implements Serializable {

	private static final long serialVersionUID = 1L;

	/******************
	 * 주문 정보
	 ******************/
	private Long stId;				// 사이트 아이디

	private String ordMdaCd;		// 주문 매체 코드

	private Long chnlId;			// 채널ID

	private String WebMobileGbCd;	//웹 모바일 구분
	
	/******************
	 * 주문 상품 정보
	 ******************/
	private String[] cartIds;		// 장바구니 아이디

	
	/******************
	 * 주문자 정보
	 ******************/
	private Long mbrNo;				// 주문자 회원 번호

	private String mbrGrdCd;		// 회원 등급 코드 (회원일 경우)

	private String ordNm; 			// 주문자 명

	private String ordrId; 			// 주문자 ID (회원일 경우)

	private String ordrEmail; 		// 주문자 이메일

	private String ordrTel; 		// 주문자 연락처

	private String ordrMobile; 		// 주문자 핸드폰

	private String ordrIp; 			// 주문자 IP

	
	/******************
	 * 배송지 정보
	 ******************/
	private String adrsNm;			// 수취인 명
	
	private String gbNm;				// 배송지 명 

	private String adrsTel;			// 전화

	private String adrsMobile;		// 휴대폰

	private String postNoOld;		// 우편번호 구

	private String prclAddr;		// 지번 주소

	private String prclDtlAddr;		// 지번 상세 주소

	private String postNoNew;		// 우편번호 신

	private String roadAddr;		// 도로명 주소

	private String roadDtlAddr;		// 도로명 상세 주소

	private String dlvrMemo;		// 배송 메모

	private String localPostYn;		// 도서산간지역여부
	
	private Long mbrDlvraNo;		// 배송지 번호 
	
	
	/******************
	 * 적용혜택 정보
	 ******************/
	private String[] cpInfos; 		// 쿠폰 사용정보

	
	/******************
	 * 결제 정보
	 ******************/
	private Long payAmt;			// 전체 결제 금액 : 실결제 총금액 

	//사용안함
	private Long svmnUseAmt; 		// 적립금 사용 금액
	
	private Long useGsPoint; 		// GS 포인트 사용 금액
	
	private Long realUseMpPoint; 	// 실제 MP 포인트 사용 금액
	private Long useMpPoint; 		// MP 포인트 사용 금액
	
	/******************
	 * 배송요청사항 관련
	 ******************/
	private String dlvrPrcsTpCd; // 배송구분 (새벽배송, 당일배송, 택배배송)
	
	private String goodsRcvPstCd;   // 상품수령위치코드

	private String goodsRcvPstEtc;  // 상품수령위치 기타

	private String pblGateEntMtdCd; // 공동현관출입방법코드

	private String pblGatePswd; //공동현관 비밀번호

	private String dlvrDemand;  // 배송요청사항
	
	private String dlvrDemandYn;  // 배송요청사항 등록 여부
	
	/** 회원 주소 등록 여부*/
	private String mbrAddrInsertYn;
	
	/******************
	 * 주문 배송 권역 매핑
	 ******************/
	/** 배송일자 */
	private String ordDt;
	
	/** 배송 권역 번호 */
	private Long dlvrAreaNo;
	
	private String mbrGbCd;
	
	/******************
	 * MP 포인트
	 ******************/
	
	private String mpCardNo;
	
	private String pinNo;
}
