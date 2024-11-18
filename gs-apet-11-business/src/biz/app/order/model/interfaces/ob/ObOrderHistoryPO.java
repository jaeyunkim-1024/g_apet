package biz.app.order.model.interfaces.ob;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.order.model.interfaces.ob
* - 파일명		: ObOrderHistoryPO.java
* - 작성일		: 2017. 9. 18.
* - 작성자		: schoi
* - 설명			: Outbound API 주문 VO
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class ObOrderHistoryPO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/****************************
	 * Outbound API 주문 이력 상세 정보
	 ****************************/

	/* 주문일련번호 */
	private Integer obApiSeq;

	/* 추가구성상품의원상품번호 */
	private Integer addPrdNo;

	/* 추가구성상품유무(Y:추가구성상품 있음,N:추가구성상품 없음) */
	private String addPrdYn;

	/* 묶음배송일련번호 */
	private Integer bndlDlvSeq;

	/* 묶음배송유무(Y:묶음배송,N:개별배송) */
	private String bndlDlvYn;

	/* 고객등급(10:우수고객,20:일반고객) */
	private String custGrdNm;

	/* 11번가주문번호 */
	private Long ordNo;

	/* 쇼핑몰주문번호 */
//	private String shopOrdNo;

	/* 마켓주문상태 */
//	private String marketOrdStd;

	/* 발주확인일시 */
	private String plCodrCnfDt;
	
	/* 11번가상품번호 */
	private Integer prdNo;

	/* 11번가상품명 */
	private String prdNm;

	/* 쇼핑몰매칭상품코드 */
//	private Integer shopPrdNo;

	/* 쇼핑몰상품명 */
//	private String shopPrdNm;

	/* 판매자상품번호 */
//	private String sellerPrdCd;

	/* 주문상품옵션코드 */
	private Integer prdStckNo;

	/* 주문상품옵션명 */
	private String slctPrdOptNm;

	/* 매칭옵션명 */
//	private String shopPrdOptNm;

	/* 주문순번 */
	private Integer ordPrdSeq;

	/* 수량 */
	private Integer ordQty;

	/* 판매가(객단가) */
	private Integer selPrc;

	/* 판매자할인금액 */
	private Integer sellerDscPrc;

	/* 판매자할인금액-각상품별 */
	private Integer lstSellerDscPrc;

	/* 11번가할인금액 */
	private Integer tmallDscPrc;

	/* 11번가할인금액-각상품별 */
	private Integer lstTmallDscPrc;

	/* 주문상품옵션결제금액 */
	private Integer ordOptWonStl;

	/* 주문총액 */
	private Integer ordAmt;

	/* 결제금액 */
	private Integer ordPayAmt;

	/* 송장번호 */
	private String invcNo;

	/* 배송비 */
	private Integer dlvCst;

	/* 배송비착불여부(01:선불,02:착불,03:무료) */
	private String dlvCstType;

	/* 도서산간배송비 */
	private Integer bmDlvCst;

	/* 도서산간배송비착불 여부(01:선불,02:착불,04:도서산간배송비 청구 필요 (선물하기 주문)) */
	private String bmDlvCstType;

	/* 배송번호 */
	private Integer dlvNo;

	/* 전세계배송여부 */
	private String gblDlvYn;

	/* 회원번호 */
	private Integer memNo;

	/* 회원id */
	private String memId;

	/* 구매자이름 */
	private String ordNm;

	/* 구매자우편번호 */
	private String ordMailNo;

	/* 구매자상세주소 */
	private String ordDtlsAddr;

	/* 구매자휴대폰번호 */
	private String ordPrtblTel;

	/* 주문자기본주소 */
	private String ordBaseAddr;

	/* 주문자전화번호 */
	private String ordTlphnNo;

	/* 주소유형(01:지번명,02:도로명) */
	private String typeAdd;

	/* 수령자명 */
	private String rcvrNm;

	/* 수령자핸드폰번호 */
	private String rcvrPrtblNo;

	/* 수령자전화번호 */
	private String rcvrTlphn;

	/* 배송지우편번호 */
	private Integer rcvrMailNo;

	/* 배송지우편번호순번 */
	private String rcvrMailNoSeq;

	/* 배송기본주소 */
	private String rcvrBaseAddr;

	/* 배송상세주소 */
	private String rcvrDtlsAddr;

	/* 배송시 요청사항 */
	private String ordDlvReqCont;

	/* 주문일시 */
	private String ordDt;

	/* 결제완료일시 */
	private String ordStlEndDt;

	/* 건물관리번호 */
	private String typeBilNo;

	/* 원클릭체크아웃 주문코드 */
	private Integer referSeq;

	/* 판매자 재고번호 */
	private String sellerStockCd;

	/* 희망배송일자(대형가전/가구) */
	private String appmtDdDlvDy;

	/* 폐가전수거여부(Y:폐가전 수거요청함,N:폐가전 수거요청안함) */
	private String appmtEltRefuseYn;

	/* 희망일배송 모델코드 */
	private String appmtSelStockCd;


}