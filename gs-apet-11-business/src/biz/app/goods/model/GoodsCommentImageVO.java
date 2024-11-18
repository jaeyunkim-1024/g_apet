package biz.app.goods.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.goods.model
* - 파일명	: GoodsCommentImageVO.java
* - 작성일	: 2016. 4. 11.
* - 작성자	: jangjy
* - 설명		: 상품 평가 이미지 Value Object
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class GoodsCommentImageVO extends BaseSysVO {
	
	private static final long serialVersionUID = 1L;
	
	/** 번호 */
	private Integer rownum;

	/** 상품 평가 번호 */
	private Long goodsEstmNo;
	
	/** 이미지 경로  */
	private String imgPath;
	
	/** 이미지 경로  */
	private Integer imgSeq;

	/** 동영상 여부  */
	private String vdYn;
	
	//
	/* 이미지 등록 수 */
	private Integer imgCnt;
	
}
