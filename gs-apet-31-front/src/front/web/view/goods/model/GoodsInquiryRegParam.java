package front.web.view.goods.model;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.PopParam;

/**
* <pre>
* - 프로젝트명	: 31.front.web
* - 패키지명	: front.web.view.goods.model
* - 파일명		: GoodsInquiryRegParam.java
* - 작성일		: 2016. 4. 7.
* - 작성자		: snw
* - 설명		: 상품문의 등록 Param
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=true)
public class GoodsInquiryRegParam extends PopParam {


	private static final long serialVersionUID = 1L;

	/* 상품 아이디 */
	private String	goodsId;
}