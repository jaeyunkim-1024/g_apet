package biz.app.goods.model;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSearchVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class ItemAttrHistSO extends BaseSearchVO<ItemAttrHistSO> {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 단품 속성 이력번호 */
	private Integer itemAttrHistNo;

	/** 단품 번호 */
	private Integer itemNo;

	/** 속성1 번호 */
	private Integer attr1No;

	/** 속성1 값번호 */
	private Integer attr1ValNo;

	/** 속성2 번호 */
	private Integer attr2No;

	/** 속성2 값번호 */
	private Integer attr2ValNo;

	/** 속성3 값번호 */
	private Integer attr3Valno;

	/** 속성3 번호 */
	private Integer attr3No;

	/** 속성4 번호 */
	private Integer attr4No;

	/** 속성4 값번호 */
	private Integer attr4ValNo;

	/** 속성5 번호 */
	private Integer attr5No;

	/** 속성5 값번호 */
	private Integer attr5ValNo;

	/** 사용 여부 */
	private String useYn;

	/** 노출 순서 */
	private Integer showSeq;

}