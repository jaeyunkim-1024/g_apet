package biz.app.goods.model;

import java.util.List;

import framework.common.model.BaseSearchVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: gs-apet-11-business
* - 패키지명 	: biz.app.goods.model
* - 파일명 	: GoodsFiltGrpSO.java
* - 작성일	: 2020. 12. 30.
* - 작성자	: valfac
* - 설명 		: 상품 필터 그룹 SO
* </pre>
*/
@Data
@SuppressWarnings("serial")
@EqualsAndHashCode(callSuper = true)
public class GoodsFiltGrpSO extends BaseSearchVO<GoodsFiltGrpSO> {
	private Long filtGrpNo;		/* 필터 그룹 번호 	*/
	private String filtGrpMngNm;	/* 필터 그룹 관리명 	*/
	private String filtGrpShowNm;	/* 필터 그룹 노출명 	*/
	
	/** 전시 번호 배열 */
	private Long[] dispClsfNos;
	
	/** 상품 아이디 */
	private String goodsId;
	
	/** 전시 번호 */
	private Long dispClsfNo;
	
	/** 검색 필터 리스트 */
	private List<String> filters;
	private List<Integer> bndNos;
	private List<String> goodsIds;
	

}
