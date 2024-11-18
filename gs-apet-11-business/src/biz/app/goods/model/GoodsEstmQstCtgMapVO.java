package biz.app.goods.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: gs-apet-11-business
* - 패키지명 	: biz.app.goods.model
* - 파일명 	: GoodsEstmQstCtgMapVO.java
* - 작성일	: 2021. 2. 15.
* - 작성자	: valfac
* - 설명 		: 상품 평가 문항 카테고리 매핑 VO 
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
@SuppressWarnings("serial")
public class GoodsEstmQstCtgMapVO extends BaseSysVO{

	/** 전시 분류 번호 */
	private String dispClsfNo;
	
	/** 평가 문항 번호 */
	private String estmQstNo;
	
	/** 전시 순서 */
	private String dispSeq;
	
	/** 문항 분류 */
	private String qstClsf;
	
	/** 문항 내용 */
	private String qstContent;
	
	/** 답변 유형 코드 */
	private String rplTpCd;
	
	/** 사용유무 */
	private String useYn;
	
	/** 항목 내용 */
	private String itemContent;
	
}
