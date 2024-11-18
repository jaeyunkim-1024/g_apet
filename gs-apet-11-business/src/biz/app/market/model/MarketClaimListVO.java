package biz.app.market.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.market.model
* - 파일명	: MarketClaimListVO.java
* - 작성일	: 2017. 10. 12.
* - 작성자	: kimdp
* - 설명		: Outbound API 클레임 VO
 * </pre>
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class MarketClaimListVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/****************************
	 * Outbound API 클레임 이력 상세 정보
	 ****************************/

	/* Outbound 이력 일련번호 */
	private Integer obApiSeq;

	/* 클레임 코드(10:취소,20:반품,30:교환) */
	private String clmCd;

	/* 클레임 요청 일시 */
	private String clmReqDt;

	/* 배송번호 */
	private Integer dlvNo;

	/* 묶음배송일련번호 */
	private Integer bndlDlvSeq;

	/* 사유코드에 대한 상세내역 */
	private String ordCnDtlsRsn;

	/* 클레임 수량 */
	private Integer ordCnQty;

	/* 클레임 등록주체(01:구매자 있음,02:판매자) */
	private String ordCnMnbdCd;

	/* 클레임 사유코드 */
	private String ordCnRsnCd;

	/* 11번가주문번호 */
	private Long ordNo;
	
	/* DCG클레임번호 */
	private String clmNo;	

	/* 쇼핑몰주문번호 */
	private String shopOrdNo;

	/* 외부몰 클레임 번호 */
	private Integer ordPrdCnSeq;

	/* 주문순번 */
	private Integer ordPrdSeq;

	/* 11번가상품번호 */
	private Integer prdNo;

	/* 원클릭체크아웃 주문코드 */
	private Integer referSeq;

	/* 무료교환 여부 현재 미사용 필드(10:무료교환,20:일반교환(유료)) */
	private String affliateBndlDlvSeq;

	/* 사유코드에 대한 상세내역 */
	private String clmReqCont;

	/* 클레임 수량 */
	private Integer clmReqQty;

	/* 클레임 사유코드 */
	private String clmReqRsn;

	/* 외부몰 클레임 번호 */
	private Integer clmReqSeq;

	/* 클레임 상태 */
	private String clmStat;

	/* 옵션명 */
	private String optName;

	/* 수거지 이름 */
	private String ordNm;

	/* 수거지 전화번호 */
	private String ordTlphnNo;

	/* 수거지 휴대폰번호 */
	private String ordPrtblTel;

	/* 수거지 우편번호 */
	private Integer rcvrMailNo;

	/* 수거지 우편번호 순번 */
	private String rcvrMailNoSeq;

	/* 수거지 기본주소 */
	private String rcvrBaseAddr;

	/* 수거지 기본주소 */
	private String rcvrDtlsAddr;

	/* 수거지 주소 유형(01:지번명,02:도로명) */
	private String rcvrTypeAdd;

	/* 수거지 건물관리번호 */
	private String rcvrTypeBilNo;

	/* 교환상품 발송방법(02:직접발송,06:11번가 지정반품택배,07:판매자 지정반품택배) */
	private String twMthd;

	/* 교환상품 수령지 이름 */
	private String exchNm;

	/* 교환상품 수령지 전화번호 */
	private String exchTlphnNo;

	/* 교환상품 수령지 휴대폰번호 */
	private String exchPrtblTel;

	/* 교환상품 수령지 우편번호 */
	private Integer exchMailNo;

	/* 교환상품 수령지 우편번호 순번 */
	private String exchMailNoSeq;

	/* 교환상품 수령지 기본주소 */
	private String exchBaseAddr;

	/* 교환상품 수령지 상세주소 */
	private String exchDtlsAddr;

	/* 교환상품 수령지 주소 유형(01:지번명,02:도로명) */
	private String exchTypeAdd;

	/* 교환상품 수령지 건물관리번호 */
	private String exchTypeBilNo;

	/* 교환배송비 */
	private Integer clmLstDlvCst;

	/* 11번가 지정반품 택배비 */
	private Integer appmtDlvCst;

	/* 결제방법(01:신용카드,02:포인트,03:박스에 동봉,04:판매자에게 직접송금) */
	private String clmDlvCstMthd;

	/* 수거송장번호 */
	private String twPrdInvcNo;

	/* 수거택배사코드 */
	private String dlvEtprsCd;

	/* KGL(해외배송) 택배사용유무 */
	private String kglUseYn;

	// ==========================================
	/* 일련번호 */
	private Integer clmSeq;

	/* 마켓명(10:11번가,20:G마켓) */
	private String marketNm;

	/* 마켓명(10:11번가,20:G마켓) */
	private String sellerId;

	/* 쇼핑몰매칭상품코드 */
	private String shopPrdNo;

	/* 쇼핑몰매칭상품명 */
	private String shopPrdNm;

	/* 판매자상품번호 */
	private String sellerPrdCd;

	/* 쇼핑몰매칭옵션명 */
	private String shopPrdOptNm;

	/* 클레임 옵션명 */
	private String clmPrdOptNm;

	/*
	 * 처리상태(10:취소수집,11:취소승인,12:취소거부,13:취소완료,19:취소수집에러,20:반품수집,21:반품승인,22:반품거부,23
	 * :반품완료,29:반품수집에러,30:교환수집,31:교환승인,32:교환거부,33:교환보류,34:교환완료,39:교환수집에러)
	 */
	private String procCd;

	/* 클레임처리자ID */
	private String shopClmId;

	/* 클레임완료일시 */
	private String shopClmDt;

	/* 클레임요청일&클레임처리완료일 */
	private String clmFullDt;

}