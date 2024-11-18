package biz.app.system.model;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSearchVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class AuthoritySO extends BaseSearchVO<AuthoritySO> {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 권한 번호 */
	private Long authNo;

	/** 권한 명 */
	private String authNm;

	/** 사용 여부 */
	private String useYn;

	/** 사용자 번호 */
	private Long usrNo;

}