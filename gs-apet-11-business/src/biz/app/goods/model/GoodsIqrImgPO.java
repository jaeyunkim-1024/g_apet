package biz.app.goods.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.goods.model
* - 파일명		: GoodsIqrImgVO.java
* - 작성일		: 2021. 02. 16.
* - 작성자		: pcm
* - 설명		: 상품 문의 이미지  Value Object
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class GoodsIqrImgPO extends BaseSysVO{

	private static final long serialVersionUID = 1L;

	/* 상품 문의 번호 */
	private Long goodsIqrNo;
	
	/* 이미지 순번 */
	private Long imgSeq;

	/* 이미지 경로 */
	private String imgPath;

	/* 동영상 여부 */
	private String vdYn;
}
