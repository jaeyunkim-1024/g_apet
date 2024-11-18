package biz.app.display.model;

import java.util.List;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSysVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class DisplayGoodsShowroomPO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 전시 분류 번호 */
	private Integer dispClsfNo;

	/** 상품 번호 */
	private String goodsId;

	/** 쇼룸 전시 분류 번호 */
	private Integer srDispClsfNo;
}