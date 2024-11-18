package biz.app.order.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.order.model
* - 파일명		: OrderBasePO.java
* - 작성일		: 2017. 1. 23.
* - 작성자		: snw
* - 설명			: 주문 기본 PO
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class OrderBasePO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 주문 번호 */
	private String ordNo;

	/** 주문 상태 코드 */
	private String ordStatCd;

	/** 사이트 아이디 */
	private Long stId;

	/** 회원 번호 */
	private Long mbrNo;

	/** 주문 매체 코드 */
	private String ordMdaCd;

	/** 채널 ID */
	private Long chnlId;
	
	/** 회원 등급 코드 */
	private String mbrGrdCd;

	/** 주문자 명 */
	private String ordNm;

	/** 주문자 ID */
	private String ordrId;

	/** 주문자 이메일 */
	private String ordrEmail;

	/** 주문자 전화 */
	private String ordrTel;

	/** 주문자 휴대폰 */
	private String ordrMobile;

	/** 주문자 IP */
	private String ordrIp;

	/** 외부 주문 번호 */
	private String outsideOrdNo;

	/** 주문상세 갯수 */
	private Integer ordDtlCnt;

	/** 데이터 상태 코드 */
	private String dataStatCd;

	/** 주문 처리 결과 코드 */
	private String ordPrcsRstCd;
	
	/** 주문 처리 결과 메세지 */
	private String ordPrcsRstMsg;
	
	/** 주문 접수 일시 등록 여부 */
	private String ordAcptDtmYn;
	
	/** 주문 완료 일시 등록 여부 */
	private String ordCpltDtmYn;
	
	/** 배송 처리 유형 */
	private String dlvrPrcsTpCd;
	
	/** MP 연동 이력 번호 */
	private Long mpLnkHistNo;
}