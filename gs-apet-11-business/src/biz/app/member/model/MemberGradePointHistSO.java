package biz.app.member.model;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSearchVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class MemberGradePointHistSO extends BaseSearchVO<MemberGradePointHistSO> {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 회원 번호 */
	private Integer mbrNo;

}