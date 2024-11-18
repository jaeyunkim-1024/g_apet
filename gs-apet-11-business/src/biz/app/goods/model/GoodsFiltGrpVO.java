package biz.app.goods.model;

import framework.common.model.BaseSysVO;
import lombok.*;

import java.util.List;

/**
* <pre>
* - 프로젝트명	: gs-apet-11-business
* - 패키지명 	: biz.app.goods.model
* - 파일명 	: GoodsFiltGrpVO.java
* - 작성일	: 2020. 12. 29.
* - 작성자	: valfac
* - 설명 		: 상품 필터 그룹 VO
* </pre>
*/
@Data
@SuppressWarnings("serial")
@EqualsAndHashCode(callSuper = true)
public class GoodsFiltGrpVO extends BaseSysVO {
	private Long filtGrpNo;			/* 필터 그룹 번호 	*/
	private String filtGrpMngNm;	/* 필터 그룹 관리명 	*/
	private String filtGrpShowNm;	/* 필터 그룹 노출명 	*/
	private Long dispClsfNo;		/* 전시카테고리 번호 	*/

	// 필터 검색 기능 ////////////////////////////////////////////////////////////////////////////////////////
	List<Integer> filtGrpNos;
	List<String> filtGrpMngNms;
	List<String> filtGrpShowNms;
	
	/** 상품 필터 속성 목록  */
	private List<GoodsFiltAttrVO> goodsFiltAttrList;
}
