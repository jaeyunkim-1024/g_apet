package biz.app.member.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.member.model
* - 파일명		: MemberSavedMoneyDetailPO.java
* - 작성일		: 2017. 2. 1.
* - 작성자		: snw
* - 설명			: 회원 적립금 내역 PO
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class MemberSavedMoneyDetailPO extends BaseSysVO {

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

	/** 처리 금액 */
	private Long prcsAmt;

	/** 결제 번호 */
	private Long payNo;

}