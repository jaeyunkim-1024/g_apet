package biz.app.order.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.order.model
* - 파일명		: OrderDlvraPO.java
* - 작성일		: 2017. 1. 23.
* - 작성자		: snw
* - 설명			: 주문 배송지 PO
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class OrderDlvraPO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 주문 배송지 번호 */
	private Long ordDlvraNo;
	
	/** 주문 번호 */
	private String	ordNo;

	/** 클레임 번호 */
	private String	clmNo;
	
	/** 배송지 명 */
	private String	gbNm;

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
	
	/** 상품 수령 위치 코드 */
	private String	goodsRcvPstCd;
	
	/** 상품 수령 위치 기타 */
	private String	goodsRcvPstEtc;
	
	/** 배송 요청사항 여부 */
	private String	dlvrDemandYn;
	
	/** 공동 현관 출입 방법 코드 */
	private String	pblGateEntMtdCd;
	
	/** 공동 현관 비밀번호 */
	private String	pblGatePswd;
	
	/** 배송 요청사항 */
	private String	dlvrDemand;
	
}