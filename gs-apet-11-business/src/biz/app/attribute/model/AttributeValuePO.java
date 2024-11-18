package biz.app.attribute.model;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSysVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class AttributeValuePO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 속성 번호 */
	private Long attrNo;

	/** 속성 값 번호 */
	private Long attrValNo;

	/** 속성 값 */
	private String attrVal;

	/** 사용 여부 */
	private String useYn;

	// 2017.08.30 추가
	private String attrNm;

}