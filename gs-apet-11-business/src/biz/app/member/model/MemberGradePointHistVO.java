package biz.app.member.model;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSysVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class MemberGradePointHistVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 회원 번호 */
	private Integer mbrNo;

	/** 등급 포인트 이력 번호 */
	private Integer grdPntHistNo;

	/** 포인트 */
	private Integer pnt;

	/** 포인트 구분 코드 */
	private String pntGbCd;

	/** 주문 번호 */
	private String ordNo;

	/** 비고 */
	private String bigo;

}