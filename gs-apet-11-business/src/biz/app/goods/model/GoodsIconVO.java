package biz.app.goods.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: gs-apet-11-business
* - 패키지명 	: biz.app.goods.model
* - 파일명 	: GoodsIconVO.java
* - 작성일	: 2020. 12. 29.
* - 작성자	: valfac
* - 설명 		: 상품 아이콘 VO
* </pre>
*/
@Data
@SuppressWarnings("serial")
@EqualsAndHashCode(callSuper=false)
public class GoodsIconVO extends BaseSysVO {

	/** 상품 아이디 */
	private String goodsId;
	
	/** 아이콘 코드 */
	private String goodsIconCd;

	/** 시작 일시 */
	private String strtDtm;
	
	/** 종료 일시 */
	private String endDtm;
}
