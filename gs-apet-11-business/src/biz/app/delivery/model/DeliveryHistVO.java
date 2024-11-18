package biz.app.delivery.model;

import java.sql.Timestamp;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSysVO;


/**
* <pre>
* - 프로젝트명	: gs-apet-11-business
* - 패키지명 	: biz.app.delivery.model
* - 파일명 	: DeliveryHistVO.java
* - 작성일	: 2021. 9. 8.
* - 작성자	: valfac
* - 설명 		: 배송 이력 VO
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class DeliveryHistVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 배송 히스토리 번호 */
	private Long dlvrHistNo;
	
	/** 배송 번호 */
	private Long dlvrNo;

	/** 주문 클레임 구분 코드 */
	private String ordClmGbCd;

	/** 배송 구분 코드 */
	private String dlvrGbCd;

	/** 배송 유형 코드 */
	private String dlvrTpCd;

	/** 배송 처리 유형 코드 */
	private String dlvrPrcsTpCd;

	/** 주문 배송지 번호 */
	private Long ordDlvraNo;

	/** 택배사 코드 */
	private String hdcCd;

	/** 송장 번호 */
	private String invNo;

	/** 배송 지시 일시 */
	private String dlvrCmd;

	/** 배송 완료 일시 */
	private String dlvrCplt;
	
	/** 출고 완료 일시 */
	private String ooCplt;
	
	/** 배송 지시 일시 */
	private Timestamp dlvrCmdDtm;
	
	/** 배송 완료 일시 */
	private Timestamp dlvrCpltDtm;
	
	/** 출고 완료 일시 */
	private Timestamp ooCpltDtm;

	/** CIS 출고 여부 */
	private String cisOoYn;
	/** CIS 출고 번호 */
	private String cisOoNo;
	/** CIS 택배사 코드 */
	private String cisHdcCd;
	/** CIS 송장 번호 */
	private String cisInvNo;
	/** CIS 배송 완료 실행 */
	private String cisDlvrCpltExe;
	/** CIS 배송 완료 사진 URL */
	private String cisDlvrCpltPicUrl;
	/** CIS 배송 완료 여부 */
	private String cisDlvrCpltYn;
	/** CIS 배송 SMS */
	private String cisDlvrSms;

	/** 주문번호 */
	private String ordNo;
	
	/** 주문상세번호 */
	private Long ordDtlSeq;
	
	/** 클레임번호 */
	private String clmNo;
	
	/** 클레임상세번호 */
	private Long clmDtlSeq;
	
	/** 주문상세상태코드 */
	private String ordDtlStatCd;
	
	/** 클레임상세상태코드 */
	private String clmDtlStatCd;
	
	/** 굿스플로 아이템 코드 */
	private String itemUniqueCode;
	
}