package biz.app.order.model;

import java.sql.Timestamp;
import java.util.List;

import biz.app.pay.model.PayBaseVO;
import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class OrderDetailTaxVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 주문 번호 */
	private String ordNo;

	/** 주문 상세 순번 */
	private Integer ordDtlSeq;

	/** 주문 상세 상태 코드 */
	private String ordDtlStatCd;

	/** 상품 아이디 */
	private String goodsId;

	/** 상품 명 */
	private String goodsNm;

	/** 단품 번호 */
	private Integer itemNo;

	/** 단품 명 */
	private String itemNm;

	/** 딜 상품 아이디 */
	private String dealGoodsId;

	/** 전시 분류 번호 */
	private String dispClsfNo;

	/** 업체 상품 번호 */
	private String compGoodsNo;

	/** 업체 단품 번호 */
	private String compItemNo;

	/** 판매 금액 */
	private Long saleAmt;

	/** 주문 수량 */
	private Long ordQty;

	/** 잔여 주문 수량 */
	private Long rmnOrdQty;

	/** 유효 주문 수량 */
	private Integer vldOrdQty;

	/** 결제 금액 */
	private Long payAmt;

	/** 공급 금액 */
	private Long splAmt;

	/** 상품수수료율 */
	private Double goodsCmsnRt;

	/** 상품 쿠폰 할인 금액 */
	private Long goodsCpDcAmt;

	/** 배송비 쿠폰 할인 금액 */
	private Long dlvrcCpDcAmt;


	/** 장바구니 쿠폰 할인 금액 */
	private Long cartCpDcAmt;

	/** 적립금 할인 금액 */
	private Long svmnDcAmt;


	/** 결제 번호 */
	private Integer payNo;

	/** 배송비 번호 */
	private Integer dlvrcNo;

	/** 업체 번호 */
	private Long compNo;

	/** 업체 명 */
	private String compNm;

	/** 업체 계약 번호 */
	private String compContrNo;

	/** 회원 번호 */
	private Integer mbrNo;


	/** 상품 준비 일시 */
	private Timestamp goodsPrpDtm;

	/** 출고 지시 일시 */
	private Timestamp ooCmdDtm;

	/** 출고 완료 일시 */
	private Timestamp ooCpltDtm;

	/** 배송 완료 일시 */
	private Timestamp dlvrCpltDtm;

	/** 상품 평가 등록 여부 */
	private String goodsEstmRegYn;

	/** 브랜드명 국문 */
	private String bndNmKo;

	//===============================================================
	// 현금영수증/세금계산서
	//===============================================================
	/** 현금 영수증 번호 */
	//private Integer cashRctNo;

	/** 원 현금 영수증 번호 */
	//private Long orgCashRctNo;

	/** 주문 클레임 구분 코드 */
	//private String ordClmGbCd;

	/** 클레임 번호 */
	private String clmNo;

	/** 클레임 상세 순번 */
	private Long clmDtlSeq;

	/** 현금 영수증 발급 유형 코드 */
	//private String crTpCd;

	/** 현금 영수증 상태 코드 */
	//private String cashRctStatCd;

	/** 신청자 구분 코드 */
	//private String apctGbCd;

	/** 사용 구분 코드 */
	//private String useGbCd;

	/** 발급 수단 코드 */
	//private String isuMeansCd;

	/** 발급 수단 번호 */
	//private String isuMeansNo;

	/** 발행 구분 코드 */
	//private String isuGbCd;

	/** 공급 금액 */
	//private Long taxSplAmt;

	/** 부가세 금액 */
	//private Long staxAmt;

	/** 봉사료 금액 */
	//private Long srvcAmt;

	/** 총 금액 */
	//private Long totAmt;

	/** 접수 일시 */
	//private Timestamp acptDtm;

	/** 처리자 번호 */
	//private Long prcsrNo;

	/** 연동 일시 */
	//private Timestamp lnkDtm;

	/** 연동 거래 번호 */
	//private String lnkDealNo;

	/** 연동 결과 코드 */
	//private String lnkRstCd;

	/** 연동 결과 메세지 */
	//private String lnkRstMsg;

	/** 메모 */
	//private String memo;

	//===============================================================
	// 세금계산서
	//===============================================================

	/** 세금 계산서 번호 */
	//private Integer taxIvcNo;

	/** 원 세금 계산서 번호 */
	//private Long orgTaxIvcNo;

	/** 세금 계산서 상태 코드 */
	//private String taxIvcStatCd;

	/** 업체 명 */
	//private String taxCompNm;

	/** 종목 */
	private String bizTp;

	/** 대표자 명 */
	private String ceoNm;

	/** 업태 */
	private String bizCdts;

	/** 사업자 번호 */
	private String bizNo;

	/** 우편 번호 구 */
	private String postNoOld;

	/** 우편 번호 신 */
	private String postNoNew;

	/** 도로 주소 */
	private String roadAddr;

	/** 도로 상세 주소 */
	private String roadDtlAddr;

	/** 지번 주소 */
	private String prclAddr;

	/** 지번 상세 주소 */
	private String prclDtlAddr;

	/** 상품 이미지 순번 */
	private Long imgSeq;

	/** 상품 이미지 경로 */
	private String imgPath;

	/** 결제 기본 List VO*/
	private List<PayBaseVO> payBaseVOList;

}