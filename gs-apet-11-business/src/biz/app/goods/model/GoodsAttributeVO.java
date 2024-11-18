package biz.app.goods.model;

import lombok.Data;
import lombok.EqualsAndHashCode;

import java.util.List;

import biz.app.attribute.model.AttributeValueVO;
import framework.common.model.BaseSysVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class GoodsAttributeVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 상품 아이디 */
	private String goodsId;

	private Long itemNo;
	/*************************
	 * 속성 관련 컬럼
	 *************************/
	
	/** 속성 번호 */
	private Integer attrNo;

	/** 속성 명 */
	private String attrNm;

	/** 사용 여부 */
	private String useYn;

	/** 전시우선순위 */
	private Integer dispPriorRank;
	
	/** 상품 속성 값 목록 */
	private List<AttributeValueVO> goodsAttrValueList;
}