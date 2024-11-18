package biz.app.company.model;

import framework.common.model.BaseSearchVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class CompanyPolicySO extends BaseSearchVO<CompanyPolicySO> {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 업체 번호 */
	private Long compNo;

	/** 하위업체 번호 */
	private Long lowCompNo;

	/** 업체 정책 구분 코드 */
	private String compPlcGbCd;

	/** 전시 여부 */
	private String dispYn;

	/** 업체 정책 번호 */
	private Long compPlcNo;

	/** 내용 */
	private String content;

	private String compStatCd;

	/** 정렬 순서 */
	private Long sortSeq;

	private String delYn;

	/** 전체 하위업체 표시 플래그 */
	private String showAllLowCompany;
	
	private String usrGrpCd;
}