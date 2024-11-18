package biz.app.goods.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.sql.Timestamp;

@Data
@EqualsAndHashCode(callSuper=false)
public class GoodsTotalCountVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 상품 관련영상 총개수 */
	private long goodsContentsTotal;
	/** 상품 후기 총개수 */
	private long goodsCommentTotal;
	/** 상품 펫로그 후기 총개수 */
	private long goodsPetlogTotal;
	/** 상품 Q&A 총개수 */
	private long goodsQnaTotal;

}