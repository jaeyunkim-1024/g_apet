package biz.app.company.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class CompanyPolicyPO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 업체 번호 */
	private Long compNo;

	/** 업체 정책 구분 코드 */
	private String compPlcGbCd;

	/** 전시 여부 */
	private String dispYn;

	/** 업체 정책 번호 */
	private Long compPlcNo;

	/** 내용 */
	private String content;

	/** 정렬 순서 */
	private Integer sortSeq;

	private String delYn;

	/** 업체 정책 번호 */
	private Long[] arrCompPlcNo;

	private String compStatCd;

}