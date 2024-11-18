package biz.app.pay.model;

import java.sql.Timestamp;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSysVO;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.pay.model
* - 파일명		: PayBasePO.java
* - 작성일		: 2017. 1. 13.
* - 작성자		: snw
* - 설명			: 결제 기본 PO
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class PayBasePO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 결제 번호 */
	private Long 	payNo;

	/** 주문 클레임 구분 코드 */
	private String 	ordClmGbCd;

	/** 주문 번호 */
	private String 	ordNo;

	/** 클레임 번호 */
	private String 	clmNo;

	/** 결제 구분 코드 */
	private String 	payGbCd;
	
	/** 결제 수단 코드 */
	private String 	payMeansCd;

	/** 결제 상태 코드 */
	private String 	payStatCd;
	
	/** 원 결제 번호 */
	private Long 	orgPayNo;

	/** 결제 완료 일시 */
	private Timestamp payCpltDtm;

	/** 결제 금액 */
	private Long 	payAmt;

	/** 상점아이디 (외부연동시) */
	private String 	strId;

	/** 거래 번호 */
	private String 	dealNo;

	/** 승인 번호 */
	private String 	cfmNo;

	/** 승인 일시 */
	private Timestamp cfmDtm;

	/** 승인 결과 코드 */
	private String 	cfmRstCd;

	/** 승인 결과 메세지 */
	private String 	cfmRstMsg;

	/** 카드사 코드 */
	private String 	cardcCd;

	/** 카드번호 */
	private String 	cardNo;

	/** 할부개월수 */
	private String halbu;

	/** 무이자여부 */
	private String 	fintrYn;

	/** 은행 코드 */
	private String 	bankCd;

	/** 계좌 번호 */
	private String 	acctNo;

	/** 예금주 명 */
	private String 	ooaNm;

	/** 입금자 명 */
	private String 	dpstrNm;

	/** 입금 예정 일자 */
	private String 	dpstSchdDt;

	/** 입금 예정 금액 */
	private Long dpstSchdAmt;

	/** 입금 확인 메세지 */
	private String 	dpstCheckMsg;
	
	/** 취소 여부 */
	private String 	cncYn;
	
	/** 연동 응답 결과 */
	private String 	lnkRspsRst;
	
	/** 관리자 등록 여부 */
	private String 	mngrRegYn;
	
	/** 관리자 확인 여부 */
	private String 	mngrCheckYn;
	
	/** 입금 휴대폰 번호 */
	private String 	depositMobile;
	
	/** 미입금 메세지 전송 여부 */
	private String  ndpstMsgSndYn;
}