package biz.app.member.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class MemberGradePointHistPO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 회원 번호 */
	private Integer mbrNo;

	/** 등급 포인트 이력 번호 */
	private Integer grdPntHistNo;

	/** 포인트 */
	private Long pnt;

	/** 포인트 구분 코드 */
	private String pntGbCd;

	/** 주문 번호 */
	private String ordNo;
	
	/** 주문 상세 순번 */
	private Integer ordDtlSeq;

	/** 비고 */
	private String bigo;


}