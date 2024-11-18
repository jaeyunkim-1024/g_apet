package biz.app.order.model;

import java.sql.Timestamp;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class OrderCreateExcelPO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 주문 번호 */
	private String ordNo;

	/** 주문 상태 코드 */
	private String ordStatCd;

	/** 주문 매체 코드 */
	private String ordMdaCd;

	/** 페이지 구분 코드 */
	private String pageGbCd;

	/** 회원 번호 */
	private Integer mbrNo;

	/** 회원 명 */
	private String mbrNm;

	/** 회원 등급 코드 */
	private String mbrGrdCd;

	/** 주문자 명 */
	private String ordNm;

	/** 주문자 이메일 */
	private String ordrEmail;

	/** 주문자 전화 */
	private String ordrTel;

	/** 주문자 휴대폰 */
	private String ordrMobile;

	/** 주문자 IP */
	private String ordrIp;

	/** 주문 접수 일시 */
	private Timestamp ordAcptDtm;

	/** 주문 완료 일시 */
	private Timestamp ordCpltDtm;

	/** 주문 취소 일시 */
	private Timestamp ordCncDtm;

	/** 주문 상세 카운트 */
	private Integer ordDtlCnt;

	/** 결제 금액 합계 */
	private Long payAmtTotal;

	/** 주문 비밀번호 */
	private String pswd;

	/** 외부 주문 번호 */
	private String outsideOrdNo;

	/** 주문전체취소 */
	private String cancelAll;

	/** 주문자 ID */
	private String ordrId;

	//=====================================================
	// order_detail
	//=====================================================

	/** 주문 번호 */
//	private String ordNo;

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

//	/** 대표전시번호 */
//	private String mastDispNo;

	/** 전시 분류 번호 */
	private String dispClsfNo;

	/** 업체상품 번호 */
	private String compGoodsNo;

	/** 업체단품 번호 */
	private String compItemNo;

	/** 판매 금액 */
	private Long saleAmt;

	/** 주문 수량 */
	private Integer ordQty;

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

	/** 조립비 쿠폰 할인 금액 */
	private Long asbcCpDcAmt;

	/** 장바구니 쿠폰 할인 금액 */
	private Long cartCpDcAmt;

	/** 적립금 할인 금액 */
	private Long svmnDcAmt;

	/** 결제 번호 */
	private Integer payNo;

	/** 배송비 번호 */
	private Integer dlvrcNo;

	/** 조립비 번호 */
	private Integer asbcNo;

	/** 업체 번호 */
	private Long compNo;

	/** 업체 명 */
	private String compNm;

	/** 업체 계약 번호 */
	private String compContrNo;

	/** 회원 번호 */
//	private Integer mbrNo;

	/** 배송 희망 일자 */
	private String dlvrHopeDt;

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

	/** 주문 접수 일시 */
//	private Timestamp ordAcptDtm;

	/** 실 배송 금액 */
	private Long realDlvrAmt;

	/** 실 조립 금액 */
	private Long realAsbAmt;

	/** 주문 상세 상태 수 */
	private Integer ordDtlStatCdCount;

	/** 외부 주문 상세 번호 */
	private String outsideOrdDtlNo;

	//=====================================================
	// delivery
	//=====================================================
	/** 배송 번호 */
	private Integer dlvrNo;

	/** 주문 클레임 구분 코드 */
	private String ordClmGbCd;

	/** 주문 번호 */
//	private String ordNo;

	/** 주문 상세 순번 */
//	private Integer ordDtlSeq;

	/** 클레임 번호 */
	private String clmNo;

	/** 클레임 상세 순번 */
	private Integer clmDtlSeq;

	/** 배송 처리 유형 코드 */
	private String dlvrPrcsTpCd;

	/** 택배사 코드 */
	private String hdcCd;

	/** 송장 번호 */
	private String invNo;

	/** 배송정책번호 */
	private Integer dlvrcPlcNo;

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

	/** 전화 */
	private String tel;

	/** 휴대폰 */
	private String mobile;

	/** 이메일 */
	private String email;

	/** 수취인 명 */
	private String adrsNm;

	/** 배송 메모 */
	private String dlvrMemo;

	/** 직배송아이디 */
	private String areaId;

	/** 배송 층 */
	private Long dlvrFlr;

	/** 엘리베이터 유무 */
	private String elvtYn;

	//=====================================================
	// pay_base
	//=====================================================
	/** 결제 번호 */
//	private Integer payNo;

	/** 원 결제 번호 */
	private Long orgPayNo;

	/** 주문 클레임 구분 코드 */
//	private String ordClmGbCd;

	/** 주문 번호 */
//	private String ordNo;

	/** 클레임 번호 */
//	private String clmNo;

	/** 결제 연동 코드 */
	private String payLnkCd;

	/** 결제 수단 코드 */
	private String payMeansCd;

	/** 결제 상태 코드 */
	private String payStatCd;

	/** 결제 완료 일시 */
	private Timestamp payCpltDtm;

	/** 결제 금액 */
//	private Long payAmt;

	/** 회원 번호 */
//	private Integer mbrNo;

	/** 상점아이디 */
	private String strId;

	/** 거래 번호 */
	private String dealNo;

	/** 승인 번호 */
	private String cfmNo;

	/** 승인 일시 */
	private Timestamp cfmDtm;

	/** 승인 결과 코드 */
	private String cfmRstCd;

	/** 승인 결과 메세지 */
	private String cfmRstMsg;

	/** 카드사 코드 */
	private String cardcCd;

	/** 은행 코드 */
	private String bankCd;

	/** 계좌 번호 */
	private String acctNo;

	/** 예금주 명 */
	private String ooaNm;

	/** 입금자 명 */
	private String dpstrNm;

	/** 입금 예정 일자 */
	private String dpstSchdDt;

	/** 입금 예정 금액 */
	private Long dpstSchdAmt;

	/** 입금 확인 메세지 */
	private String dpstCheckMsg;

	/** 부가 비용 금액 */
	private Long adtCostAmt;

}