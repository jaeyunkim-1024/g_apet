package biz.app.company.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class CompanyPolicyVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 업체 번호 */
	private Integer compNo;

	/** 업체 명 */
	private String compNm;

	/** 업체 정책 구분 코드 */
	private String compPlcGbCd;

	/** 전시 여부 */
	private String dispYn;

	/** 업체 정책 번호 */
	private Integer compPlcNo;

	/** 업체 기본택배사 코드 */
	private String hdcCd;

	/** 내용 */
	private String content;

	/** 정렬 순서 */
	private Long sortSeq;

	private String goodsNm;

	private String delYn;

	private String compStatCd;
}