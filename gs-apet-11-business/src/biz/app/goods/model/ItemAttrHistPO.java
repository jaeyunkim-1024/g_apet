package biz.app.goods.model;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSysVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class ItemAttrHistPO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 단품 속성 이력번호 */
	private Long itemAttrHistNo;

	/** 단품 번호 */
	private Long itemNo;

	/** 속성1 번호 */
	private Long attr1No;

	/** 속성1 명 */
	private String attr1Nm;

	/** 속성1 값 번호 */
	private Long attr1ValNo;

	/** 속성1 값 */
	private String attr1Val;

	/** 속성2 번호 */
	private Long attr2No;

	/** 속성2 명 */
	private String attr2Nm;

	/** 속성2 값 번호 */
	private Long attr2ValNo;

	/** 속성2 값 */
	private String attr2Val;

	/** 속성3 번호 */
	private Long attr3No;

	/** 속성3 명 */
	private String attr3Nm;

	/** 속성3 값 번호 */
	private Long attr3ValNo;

	/** 속성3 값 */
	private String attr3Val;

	/** 속성4 번호 */
	private Long attr4No;

	/** 속성4 명 */
	private String attr4Nm;

	/** 속성4 값 번호 */
	private Long attr4ValNo;

	/** 속성4 값 */
	private String attr4Val;

	/** 속성5 번호 */
	private Long attr5No;

	/** 속성5 명 */
	private String attr5Nm;

	/** 속성5 값 번호 */
	private Long attr5ValNo;

	/** 속성5 값 */
	private String attr5Val;

	/** 사용 여부 */
	private String useYn;

	/** 노출 순서 */
	private Long showSeq;

}