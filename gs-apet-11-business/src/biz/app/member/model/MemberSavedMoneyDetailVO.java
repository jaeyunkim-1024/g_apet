package biz.app.member.model;

import java.sql.Timestamp;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSysVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class MemberSavedMoneyDetailVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 회원 번호 */
	private Long mbrNo;

	/** 적립금 순번 */
	private Long svmnSeq;

	/** 이력 순번 */
	private Long histSeq;

	/** 적립금 처리 코드 */
	private String svmnPrcsCd;

	/** 적립금 처리 사유 코드 */
	private String svmnPrcsRsnCd;

	/** 처리 일시 */
	private Timestamp prcsDtm;

	/** 처리 금액 */
	private Long prcsAmt;

	/** 복원 금액 : 결제에 사용한 경우 복원된 금액 */
	private Long restoreAmt;

	/** 결제 번호 */
	private Long payNo;
}