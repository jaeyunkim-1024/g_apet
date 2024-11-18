package biz.app.pay.model;

import framework.common.model.BaseSysVO;
import framework.common.util.StringUtil;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.sql.Timestamp;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.pay.model
* - 파일명		: PrsnCardBillingInfoVO.java
* - 작성일		: 2021. 1. 12.
* - 작성자		: valfac
* - 설명		: 개인 간편결제 VO
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class PrsnCardBillingInfoVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 결제 번호 */
	private Integer prsnCardBillNo;

	private Integer mbrNo;

	private String cardcNm;

	private String cardNo;

	private String simpScrNo;

	private Integer billInputFailCnt;

	private String pgMoid;

	private String pgTid;

	private String pgBid;

	private String pgAuthDate;

	private String pgCardCode;

	private String pgCardName;

	private String pgCardCl;

	private String pgAcquCardCode;

	private String pgAcquCardname;

	private String pgDelYn;

	private String useYn;

	private String cardColor;

	private Integer registCardCnt;

	private Integer rowIndex;

}