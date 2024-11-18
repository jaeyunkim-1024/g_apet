package biz.app.goods.model;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSysVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class GoodsCommentImagePO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 상품 평가 번호 */
	private Long goodsEstmNo;

	/** 이미지 경로 */
	private String imgPath;

	/** 이미지 순번 */
	private Long imgSeq;

	/** 비디오 여부 */
	private String vdYn;

}