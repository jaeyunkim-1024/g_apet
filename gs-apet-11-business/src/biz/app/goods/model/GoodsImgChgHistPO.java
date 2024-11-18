package biz.app.goods.model;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSysVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class GoodsImgChgHistPO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 상품 이미지 변경 이력 순번 */
	private Long goodsImgChgHistSeq;

	/** 상품 아이디 */
	private String goodsId;

	/** 이미지 순번 */
	private Integer imgSeq;

	/** 이미지 경로 */
	private String imgPath;

	/** 반전 이미지 경로 */
	private String rvsImgPath;

	/** 대표 여부 */
	private String dlgtYn;

}