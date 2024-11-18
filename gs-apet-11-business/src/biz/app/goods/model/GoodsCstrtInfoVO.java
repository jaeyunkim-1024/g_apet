package biz.app.goods.model;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class GoodsCstrtInfoVO extends GoodsBaseVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 상품 구성 구분 코드 */
	private String goodsCstrtGbCd;

	/** 구성 상품 아이디 */
	private String cstrtGoodsId;

	/** 사용 여부 */
	private String useYn;

}