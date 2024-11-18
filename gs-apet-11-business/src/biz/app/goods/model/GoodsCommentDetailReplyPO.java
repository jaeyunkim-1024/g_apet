package biz.app.goods.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class GoodsCommentDetailReplyPO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/* 상품평 번호 */
	private String goodsEstmNo;


}