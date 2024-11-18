package biz.app.system.model;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSysVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class AuthorityPO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 권한 번호 */
	private Long authNo;

	/** 권한 명 */
	private String authNm;

	/** 사용 여부 */
	private String useYn;

	/** 메인 URL */
	private String mnUrl;

	/** 메뉴 번호 리스트 */
	private Long[] arrMenuNo;

	/** 메뉴 번호 */
	private Long menuNo;

}