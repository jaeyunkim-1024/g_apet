package biz.app.goods.model;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSearchVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class GoodsImgSO extends BaseSearchVO<GoodsImgSO> {

	/** UID */
	private static final long serialVersionUID = 1L;

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
	
	/** 이미지 타입 */
	private String imgTpCd;

}