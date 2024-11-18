package biz.app.goods.model;

import biz.app.member.model.MemberIoAlarmVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * <pre>
 * - 프로젝트명 : 11.business
 * - 패키지명   : biz.app.goods.model
 * - 파일명     : GoodsIoAlmVO.java
 * - 작성일     : 2021. 04. 26.
 * - 작성자     : valfac
 * - 설명       :
 * </pre>
 */

@Data
@EqualsAndHashCode(callSuper=false)
public class GoodsIoAlmVO extends MemberIoAlarmVO {

	private String goodsCstrtTpCd;

	/** 묶음상품명 */
	private String pakGoodsNm;

	private String salePsbCd;
	private String webStkQty;
	private String imgPath;
	private String attr1Val;
	private String attr2Val;
	private String attr3Val;
	private String attr4Val;
	private String attr5Val;
	
	private String attrVal;
}
