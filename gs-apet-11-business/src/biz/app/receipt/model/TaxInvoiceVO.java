package biz.app.receipt.model;

import java.sql.Timestamp;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSysVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class TaxInvoiceVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 세금 계산서 번호 */
	private Long taxIvcNo;

	/** 원 세금 계산서 번호 */
	private Long orgTaxIvcNo;

	/** 주문 클레임 구분 코드 */
	private String ordClmGbCd;

	/** 주문 번호 */
	private String ordNo;

	/** 주문 상세 순번 */
	private Integer ordDtlSeq;

	/** 클레임 번호 */
	private String clmNo;

	/** 클레임 상세 순번 */
	private Integer clmDtlSeq;

	/** 세금 계산서 상태 코드 */
	private String taxIvcStatCd;

	/** 신청자 구분 코드 */
	private String apctGbCd;

	/** 회원 번호 */
	private Long mbrNo;

	/** 사용 구분 코드 */
	private String useGbCd;

	/** 발급 수단 코드 */
	private String isuMeansCd;

	/** 업체 명 */
	private String compNm;

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

	/** 주소 */
	private String addr;

	/** 공급 금액 */
	private Long splAmt;

	/** 부가세 금액 */
	private Long staxAmt;

	/** 총 금액 */
	private Long totAmt;

	/** 접수 일시 */
	private Timestamp acptDtm;

	/** 처리자 번호 */
	private Long prcsrNo;

	/** 연동 일시 */
	private Timestamp lnkDtm;

	/** 연동 거래 번호 */
	private String lnkDealNo;

	/** 연동 결과 코드 */
	private String lnkRstCd;

	/** 연동 결과 메세지 */
	private String lnkRstMsg;

	/** 메모 */
	private String memo;

}