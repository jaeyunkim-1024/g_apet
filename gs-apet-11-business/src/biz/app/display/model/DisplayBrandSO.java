package biz.app.display.model;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSearchVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class DisplayBrandSO extends BaseSearchVO<DisplayBrandSO> {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 전시 분류 번호 */
	private Long dispClsfNo;

	/** 브랜드 번호 */
	private Long bndNo;

	/** 전시 우선 순위 */
	private Long dispPriorRank;

	/** 브랜드 구분 코드 */
	private String bndGbCd;
	
	/** 대표브랜드 번호 */
	private Long dlgtBndNo;
	
	/** 최하위 전시카테고리번호 리스트 */
	private Long[] leafDispClsfNoList;
	
	/** 사이트 아이디 **/
	private Long stId;
}