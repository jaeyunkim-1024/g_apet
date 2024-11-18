package biz.app.goods.model;

import framework.common.model.BaseSearchVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: gs-apet-11-business
* - 패키지명 	: biz.app.goods.model
* - 파일명 	: GoodsFiltAttrSO.java
* - 작성일	: 2020. 12. 30.
* - 작성자	: valfac
* - 설명 		: 상품 필터 속성 SO
* </pre>
*/
@Data
@SuppressWarnings("serial")
@EqualsAndHashCode(callSuper = true)
public class GoodsFiltAttrSO extends BaseSearchVO<GoodsFiltAttrSO> {
	private Long filtGrpNo;		/* 필터 그룹 번호 */
	private Long filtAttrSeq;	/* 필터 속성 순번 */
	private String filtAttrNm;		/* 필터 속성 명 	*/
	private String useYn;			/* 사용 여부 	*/


}
