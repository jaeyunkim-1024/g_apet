package biz.app.goods.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: gs-apet-11-business
* - 패키지명 	: biz.app.goods.model
* - 파일명 	: GoodsFiltGrpPO.java
* - 작성일	: 2020. 12. 30.
* - 작성자	: valfac
* - 설명 		: 상품 필터 그룹 PO
* </pre>
*/
@Data
@SuppressWarnings("serial")
@EqualsAndHashCode(callSuper = true)
public class GoodsFiltGrpPO extends BaseSysVO {
	private Long filtGrpNo;			/* 필터 그룹 번호 	*/
	private String filtGrpMngNm;	/* 필터 그룹 관리명 	*/
	private String filtGrpShowNm;	/* 필터 그룹 노출명 	*/
	private String dispClsfNo;		/* 전시카테고리 번호 	*/
}

