package front.web.view.goods.model;

import framework.common.model.PopParam;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: 31.front.web
* - 패키지명	: front.web.view.goods.model
* - 파일명		: GoodsCommentParam.java
* - 작성일		: 2016. 4. 11.
* - 작성자		: snw
* - 설명		: 상품 평가 상세 Param
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=true)
public class GoodsCommentParam extends PopParam {

	private static final long serialVersionUID = 1L;

	/* 상품 아이디 */
	private Long	goodsEstmNo;
	
	/* 상품정보 표시여부 */
	private String	goodsDisp;
}