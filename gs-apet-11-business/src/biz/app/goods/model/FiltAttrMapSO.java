package biz.app.goods.model;

import java.util.List;

import framework.common.model.BaseSearchVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: gs-apet-11-business
* - 패키지명 	: biz.app.goods.model
* - 파일명 	: FiltAttrMapSO.java
* - 작성일	: 2020. 12. 29.
* - 작성자	: valfac
* - 설명 		: 필터 속성 매핑 SO
* </pre>
*/
@Data
@SuppressWarnings("serial")
@EqualsAndHashCode(callSuper = true)
public class FiltAttrMapSO extends BaseSearchVO<FiltAttrMapSO> {

	/** 검색 필터 리스트 */
	private List<String> filters;
}
