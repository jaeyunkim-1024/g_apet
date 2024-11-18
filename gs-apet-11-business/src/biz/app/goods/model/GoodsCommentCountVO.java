package biz.app.goods.model;

import java.io.Serializable;

import lombok.Data;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.goods.model
* - 파일명		: GoodsCommentVO.java
* - 작성일		: 2016. 4. 7.
* - 작성자		: snw
* - 설명		: 상품평가 데이터 수 Value Object
* </pre>
*/
@Data
public class GoodsCommentCountVO implements Serializable {

	private static final long serialVersionUID = 1L;

	/* 상품평가 전체 수 */
	private Integer totalCnt;
	/* 상품평가 포토 수 */
	private Integer photoCnt;
	/* 상품평가 추천 수 */
	private Integer rcomCnt;
	/* 상품문의 수 */
	private Integer inquiryCnt;

}
