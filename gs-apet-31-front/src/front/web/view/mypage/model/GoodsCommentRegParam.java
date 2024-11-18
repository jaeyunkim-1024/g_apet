package front.web.view.mypage.model;

import framework.common.model.PopParam;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: 31.front.web
* - 패키지명	: front.web.view.mypage.model
* - 파일명	: GoodsCommentRegParam.java
* - 작성일	: 2016. 4. 11.
* - 작성자	: jangjy
* - 설명		: 상품평가 등록 Param
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=true)
public class GoodsCommentRegParam extends PopParam {


	private static final long serialVersionUID = 1L;

	/* 상품 아이디 */
	private String	goodsId;
	/* 상품 평가 번호 */
	private Integer	goodsEstmNo;
	/* 주문 번호 */
	private String	ordNo;
	/* 주문 상세 순번 */
	private Integer	ordDtlSeq;
	
}