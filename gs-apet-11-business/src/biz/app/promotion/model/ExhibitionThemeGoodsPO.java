package biz.app.promotion.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.promotion.model
* - 파일명		: ExhibitionThemeGoodsPO.java
* - 작성일		: 2017. 6. 8..
* - 작성자		: hongjun
* - 설명		:
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class ExhibitionThemeGoodsPO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;
	
	/** 테마 번호 */
	private Long thmNo;
	
	/** 상품 번호 */
	private String goodsId;

	/** 전시 우선 순위 */
	private Integer dispPriorRank;

	/** 추가, 저장 여부 */
	private Integer isUpdate;
}