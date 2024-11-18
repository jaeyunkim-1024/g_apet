package biz.app.system.model;

import java.sql.Timestamp;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSysVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class BbsLetterGoodsPO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 글 번호 */
	private Long lettNo;

	/** 상품아이디 */
	private String goodsId;

	/** 전시우선순위 */
	private Integer dispPriorRank;
	
	/** 상품 아이디 */
	private String[] arrGoodsId;

}