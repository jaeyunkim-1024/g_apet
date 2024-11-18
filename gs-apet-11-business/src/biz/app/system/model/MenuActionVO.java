package biz.app.system.model;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSysVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class MenuActionVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** URL */
	private String url;

	/** 기능 구분 코드 */
	private String actGbCd;

	/** 기능 명 */
	private String actNm;

	/** 사용 여부 */
	private String useYn;

	/** 메뉴 번호 */
	private Long menuNo;

	/** 기능 번호 */
	private Long actNo;

}