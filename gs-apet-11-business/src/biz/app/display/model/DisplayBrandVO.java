package biz.app.display.model;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSysVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class DisplayBrandVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 전시 분류 번호 */
	private Integer dispClsfNo;

	/** 브랜드 번호 */
	private Integer bndNo;

	/** 전시 우선 순위 */
	private Integer dispPriorRank;

	/** 브랜드 명 국문 */
	private String bndNmKo;

	/** 브랜드 구분 코드 */
	private String bndGbCd;
	
	/** 대표브랜드번호 */
	private Integer dlgtBndNo;

}