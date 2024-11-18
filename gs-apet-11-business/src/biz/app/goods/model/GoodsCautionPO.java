package biz.app.goods.model;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSysVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class GoodsCautionPO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 순번 */
	private Long seq;

	/** 내용 */
	private String content;

	/** 전시 여부 */
	private String dispYn;

	/** 상품 아이디 */
	private String goodsId;

}