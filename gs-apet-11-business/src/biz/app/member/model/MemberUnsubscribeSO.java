package biz.app.member.model;

import framework.common.model.BaseSearchVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class MemberUnsubscribeSO extends BaseSearchVO<MemberUnsubscribeSO> {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 회원 번호 */
	private Long mbrNo;

	private String clientTelNo;
	
	private String[] clientTelNos;

}