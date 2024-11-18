package biz.app.pay.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.pay.model
* - 파일명		: PrsnPaySaveInfoVO.java
* - 작성일		: 2021. 1. 12.
* - 작성자		: valfac
* - 설명		: 기본결제수단 VO
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class BillingRegist extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 결제 번호 */

	private Long mbrNo;

	private String CardNo;

	private String ExpYear;

	private String ExpMonth;

	private String CardPw;

	private String IDNo;

	private String EncData;

	private String MID;

	private String Moid;

	private String EdiDate;

	private String SignData;

	private String BuyerName;

	private String BuyerEmail;

	private String BuyerTel;

	private String CharSet;

	private String EdiType;

	private String prsnCardBillNo;

	private String certifyPassword;
}