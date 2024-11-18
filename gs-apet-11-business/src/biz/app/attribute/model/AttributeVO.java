package biz.app.attribute.model;

import java.util.List;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSysVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class AttributeVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 속성 번호 */
	private Long attrNo;

	/** 속성 명 */
	private String attrNm;

	/** 사용 여부 */
	private String useYn;

	private List<AttributeValueVO> attributeValueList;
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	/** 추가 */
	private String attrValNo;
	private String attrVal;
	private String attrValJson;
	private String goodsId;

}