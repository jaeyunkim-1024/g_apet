package biz.app.attribute.model;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSearchVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class AttributeValueSO extends BaseSearchVO<AttributeValueSO> {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 속성 번호 */
	private Integer attrNo;

	/** 속성 값 번호 */
	private Integer attrValNo;

	/** 속성 값 */
	private String attrVal;

	/** 사용 여부 */
	private String useYn;

}