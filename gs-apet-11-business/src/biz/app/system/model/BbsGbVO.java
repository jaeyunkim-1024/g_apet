package biz.app.system.model;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSysVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class BbsGbVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 게시판 아이디 */
	private String bbsId;

	/** 게시판 구분 번호 */
	private Long bbsGbNo;

	/** 게시판 구분 명 */
	private String bbsGbNm;

}