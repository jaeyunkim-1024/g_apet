package biz.app.goods.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: gs-apet-11-business
* - 패키지명 	: biz.app.goods.model
* - 파일명 	: FiltAttrMapVO.java
* - 작성일	: 2020. 12. 29.
* - 작성자	: valfac
* - 설명 		: 필터 속성 매핑 VO
* </pre>
*/
@Data
@SuppressWarnings("serial")
@EqualsAndHashCode(callSuper = true)
public class FiltAttrMapVO extends BaseSysVO {
	
	/** 상품 아이디 */
	private String goodsId;
	
	/** 필터 그룹 번호 */
	private Long filtGrpNo;
	
	/** 필터 속성 번호 */
	private Long filtAttrSeq;
	
	/** 상품 checked 필터 속성 순번 */
	private Long checkedFiltAttrSeq;
	
	/** 필터 그룹 관리명 */
	private String filtGrpMngNm;
	
	/** 필터 속성 명 */
	private String filtAttrNm;
	
	/** 필터명 */
	private String filtId;
	
}
