package biz.app.goods.model;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSysVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class ItemAttributeValuePO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 단품 번호 */
	private Long itemNo;

	/** 속성 값 번호 */
	private Long attrValNo;

	/** 속성 번호 */
	private Long attrNo;

}