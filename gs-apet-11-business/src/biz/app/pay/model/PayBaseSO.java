package biz.app.pay.model;

import java.sql.Timestamp;

import framework.common.model.BaseSearchVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.pay.model
* - 파일명		: PayBaseSO.java
* - 작성일		: 2017. 1. 12.
* - 작성자		: snw
* - 설명			: 결제 기본 SO
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class PayBaseSO extends BaseSearchVO<PayBaseSO> {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 결제 번호 */
	private Long payNo;
	
	/** 주문 클레임 구분 코드 */
	private String ordClmGbCd;
	
	/** 주문 번호 */
	private String ordNo;
	
	/** 클레임 번호 */
	private String clmNo;

	/** 결제 구분 코드 */
	private String payGbCd;
	
	/** 결제 구분 코드 : 배열 */
	private String payGbCds[];
	
	/** 결제 수단 코드 */
	private String payMeansCd;

	/** 결제 상태 코드 */
	private String payStatCd;
	
	/** 취소 여부 */
	private String 	cncYn;
	
	/** 거래 번호 */
	private String	dealNo;
	
	private boolean	cardReceiptSortYn = Boolean.FALSE  ;
	
	/** 계좌번호 */
	private String acctNo;
	
	/** 입금 시작일 */
	private Timestamp depositStartDtm;
	
	/** 입금 종료일 */
	private Timestamp depositEndDtm;
	
	/** 입금 검색 param */
	private String searchKey;
	private String searchValue;
	
	
}