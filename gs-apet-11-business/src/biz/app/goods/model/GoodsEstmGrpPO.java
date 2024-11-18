package biz.app.goods.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: gs-apet-11-business
* - 패키지명 	: biz.app.goods.model
* - 파일명 	: GoodsEstmGrpPO.java
* - 작성일	: 2020. 12. 21.
* - 작성자	: valfac
* - 설명 		: 상품 평가 그룹 PO
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class GoodsEstmGrpPO extends BaseSysVO{
	
	private static final long serialVersionUID = 1L;

	/** 평가 그룹 번호 */
	private Long estmGrpNo;
	
	/** 평가 그룹 이름 */
	private String estmGrpNm;
	
}
