package biz.app.goods.model;

import framework.common.model.BaseSearchVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: gs-apet-11-business
* - 패키지명 	: biz.app.goods.model
* - 파일명 	: GoodsDtlInqrHistSO.java
* - 작성일	: 2021. 3. 9.
* - 작성자	: valfac
* - 설명 		: 최근 본 상품 SO
* </pre>
*/
@Data
@SuppressWarnings("serial")
@EqualsAndHashCode(callSuper=false)
public class GoodsDtlInqrHistSO extends BaseSearchVO<GoodsDtlInqrHistSO> {

	/** 상품 아이디 */
	private String goodsId;
	/** 회원번호 */
	private Long mbrNo;

	private Long stId;

	private String webMobileGbCd;

	private String[] goodsIds;
	
	private String cookieYn;

}