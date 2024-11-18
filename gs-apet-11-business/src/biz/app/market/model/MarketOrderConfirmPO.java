package biz.app.market.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.order.model.interfaces.ob
* - 파일명		: MarketOrderConfirmPO.java
* - 작성일		: 2017. 9. 25.
* - 작성자		: schoi
* - 설명			: Outbound API 주문 등록 VO
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class MarketOrderConfirmPO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/****************************
	 * Outbound API 주문 등록
	 ****************************/
	/* 주문일련번호 */
	private Long ordSeq;

	/* 주문일련번호 */
	private Long[] arrOrdSeq;
	
	/* 주문번호 */
	private String ordNo;
	
	/* 쇼핑몰 주문번호 */
	private String shopOrdNo;

	/* 주문 배송지 번호 */
	private Long ordDlvraNo;

	/* 주문 배송비 번호 */
	private Long dlvrcNo;

	//===========================
	/* 사이트 ID */
	private Integer stId;
	
	/* 회원 번호 */
	private Integer mbrNo;
	
	/* 주문 상태 코드 */
	private String ordStatCd;
	
	/* 주문 매체 코드 */
	private String ordMdaCd;
	
	/* 채널 ID */
	private Integer chnlId;
	
	/* 주문 처리 결과 코드 */
	private String ordPrcsRstCd;
	
	/* 주문 처리 결과 메세지 */
	private String ordPrcsRstMsg;
	
	/* 주문 데이터 상태 코드 */
	private String dataStatCd;
	
	/* 외부 주문 번호 */
	private String outsideOrdNo;
	
	//===========================
	/* 주문 상세 순번 */
	private Integer ordDtlSeq;
	
	/* 취소 수량*/
	private Integer cncQty;
	
	/* 반품 수량 */
	private Integer rtnQty;
	
	/* 잔여 결제 금액 */
	private Long rmnPayAmt;
	
	/* 주문 상세 상태 코드 */
	private String ordDtlStatCd;
	
	/* 과세 구분 코드 */
	private String taxGbCd;
	
	/* 핫딜 상품 여부 */
	private String hotDealYn;
	
	/* 상품평 등록 여부 */
	private String goodsEstmRegYn;
	
	/* 외부 주문 상세 번호 */
	private String outsideOrdDtlNo;
	
	//===========================
	/* 배송비 구분 코드 */
	private String costGbCd;
	
	/* 취소 여부 */
	private String cncYn;

	//===========================
	/* 쇼핑몰매칭상품코드 */
	private String shopPrdNo;
	
	/* 쇼핑몰매칭상품명 */
	private String shopPrdNm;
	
	/* 쇼핑몰매칭옵션명 */
	private String shopPrdOptNm;
	
	/* 처리상태(10:주문수집,19:주문수집에러,20:주문등록,29:주문등록에러) */
	private String procCd;

}