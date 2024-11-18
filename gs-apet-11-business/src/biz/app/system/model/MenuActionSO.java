package biz.app.system.model;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSearchVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class MenuActionSO extends BaseSearchVO<MenuActionSO> {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 메뉴 번호 */
	private Long menuNo;

	/** 기능 번호 */
	private Integer actNo;

	/*url*/
	private String url;

	/*기능 구분 코드*/
	private String actGbCd;

}