package biz.app.system.model;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSysVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class MenuBasePO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 메뉴 명 */
	private String menuNm;

	/** 정렬 순서 */
	private Long sortSeq;

	/** 사용 여부 */
	private String useYn;

	/** 메뉴 번호 */
	private Long menuNo;

	/** 상위 메뉴 번호 */
	private Long upMenuNo;

}