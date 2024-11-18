package biz.app.market.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.market.model
* - 파일명	: MarketClaimConfirmVO.java
* - 작성일	: 2017. 10. 17.
* - 작성자	: schoi
* - 설명		: Outbound API 클레임 조회 VO
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class MarketClaimConfirmVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/****************************
	 * Outbound API 클레임 조회
	 ****************************/
	/* 상품 아이디 */
	private String goodsId;

	/* 상품 명 */
	private String goodsNm;
	
	/* 단품 번호 */
	private String itemNo;
	
	/* 단품 명 */
	private String itemNm;

}