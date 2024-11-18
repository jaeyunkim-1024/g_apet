package biz.app.member.model;

import framework.common.model.BaseSearchVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class MemberSavedMoneyDetailSO extends BaseSearchVO<MemberSavedMoneyDetailSO> {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 회원 번호 */
	private Integer mbrNo;

	/** 적립금 순번 */
	private Integer svmnSeq;

	/** 결제 번호 */
	private Long 	payNo;

	/** 적립금 처리 코드 */
	private String	svmnPrcsCd;
	
	/** 적립금 처리 사유 코드 */
	 private String 	svmnPrcsRsnCd;
	
	
}