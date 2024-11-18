package biz.app.goods.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: gs-apet-11-business
* - 패키지명 	: biz.app.goods.model
* - 파일명 	: GoodsDtlInqrHistVO.java
* - 작성일	: 2021. 3. 9.
* - 작성자	: valfac
* - 설명 		: 최근 본 상품 VO
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
@SuppressWarnings("serial")
public class GoodsDtlInqrHistVO extends BaseSysVO {

	/** 상품 아이디 */
	private String goodsId;
	
	/** 회원번호 */
	private Long mbrNo;

	/** 조회수 */
	private Integer hits;

}