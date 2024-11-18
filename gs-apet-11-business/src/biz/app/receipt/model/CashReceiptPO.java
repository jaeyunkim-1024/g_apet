package biz.app.receipt.model;

import java.sql.Timestamp;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSysVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class CashReceiptPO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 현금 영수증 번호 */
	private Long cashRctNo;

	/** 원 현금 영수증 번호 */
	private Long orgCashRctNo;

	/** 주문 번호 */
	private String ordNo;

	/** 클레임 번호 */
	private String clmNo;
	
	/** 발행 유형 코드 */
	private String crTpCd;

	/** 현금 영수증 상태 코드 */
	private String cashRctStatCd;

	/** 사용 구분 코드 */
	private String useGbCd;

	/** 발급 수단 코드 */
	private String isuMeansCd;

	/** 발급 수단 번호 */
	private String isuMeansNo;

	/** 회원 번호 */
	private Long mbrNo;

	/** 처리자 번호 */
	private Long prcsrNo;

	/** 발행 구분 코드 */
	private String isuGbCd;

	/** 결제 금액 */
	private Long payAmt;
	
	/** 공급 금액 */
	private Long splAmt;

	/** 부가세 금액 */
	private Long staxAmt;

	/** 봉사료 금액 */
	private Long srvcAmt;

	/** 상점 아이디 */
	private String strId;
	
	/** 연동 일시 */
	private Timestamp lnkDtm;

	/** 연동 거래 번호 */
	private String lnkDealNo;

	/** 연동 결과 메세지 */
	private String lnkRstMsg;
	
	/** 승인 결과 코드 */
	private String cfmRstCd;
	
	/** 승인 결과 메세지 */
	private String cfmRstMsg;
	
	/** 주문 / 클레임 번호 */
	private String ordClmNo;

	/** 주문 / 클레임 상세 순번 */
	private Integer ordClmDtlSeq;

}