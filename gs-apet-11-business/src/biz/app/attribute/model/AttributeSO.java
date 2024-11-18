package biz.app.attribute.model;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSearchVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class AttributeSO extends BaseSearchVO<AttributeSO> {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 상품 아이디 */
	private String goodsId;

	/** 사용 여부 */
	private String useYn;

	/** 속성 번호 */
	private Long attrNo;

	/** 속성 명 */
	private String attrNm;

	/** 추가 */
	private String attrValNo;
	private String attrVal;
	private String attrValJson;

	/* 순서 */
	private Long sortSeq;


}