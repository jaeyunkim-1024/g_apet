package biz.app.member.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.member.model
* - 파일명		: MemberSavedMoneyPO.java
* - 작성일		: 2017. 2. 1.
* - 작성자		: snw
* - 설명			: 회원 적립금 PO
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class MemberSavedMoneyPO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 회원 번호 */
	private Long mbrNo;

	/** 적립금 순번 */
	private Long svmnSeq;

	/** 적립금 처리 코드 10:적립, 20: 차감 */
	private String svmnPrcsCd;

	/** 적립금 처리 사유 코드 */
	private String svmnPrcsRsnCd;

	/** 적립금 사유코드  */
	private String svmnRsnCd;

	/** 기타 사유 */
	private String etcRsn;

	/** 적립 금액 */
	private Long saveAmt;

	/** 주문 번호 */
	private String ordNo;

	/** 주문 상세 순번 */
	private Integer ordDtlSeq;

	/** 상품 평가 번호 */
	private Long goodsEstmNo;

	/** 유효 기간 */
	private Integer vldPeriod;

	/** 유효 기간 단위 */
	private String vldUnit;

	/** 유효기간 */
	private String vldDtm;

}