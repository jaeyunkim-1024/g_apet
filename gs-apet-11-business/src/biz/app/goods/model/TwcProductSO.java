package biz.app.goods.model;

import framework.common.model.BaseSearchVO;
import lombok.Data;
import lombok.EqualsAndHashCode;


/**
* <pre>
* - 프로젝트명	: gs-apet-11-business
* - 패키지명 	: biz.app.goods.model
* - 파일명 	: TwcProductSO.java
* - 작성일	: 2021. 1. 29.
* - 작성자	: valfac
* - 설명 		: 성분 정보 SO
* </pre>
*/
@Data
@SuppressWarnings("serial")
@EqualsAndHashCode(callSuper=false)
public class TwcProductSO extends BaseSearchVO<TwcProductSO> {

	/** 어바웃펫(펫츠비) 상품 코드 */
	private String productCode;
	
	/** 자체 상품 코드 */
	private String petsbeId;
}
