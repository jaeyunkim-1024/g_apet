package biz.app.system.model;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSysVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class BbsPocVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 게시판 글 아이디 */
	private Long lettNo;

	/**poc 번호 */
	private Long pocGbCd;


}