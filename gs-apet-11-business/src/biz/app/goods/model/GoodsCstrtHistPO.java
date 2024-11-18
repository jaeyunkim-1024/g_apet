package biz.app.goods.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: gs-apet-11-business
* - 패키지명 	: biz.app.goods.model
* - 파일명 	: GoodsCstrtHistPO.java
* - 작성일	: 2021. 2. 17.
* - 작성자	: valfac
* - 설명 		: 상품 구성 히스토리
* </pre>
*/
@Data
@SuppressWarnings("serial")
@EqualsAndHashCode(callSuper=false)
public class GoodsCstrtHistPO extends BaseSysVO {

	/** 상품 아이디 */
	private String goodsId;
	
	/** 상품 구성 유형 코드 */
	private String goodsCstrtTpCd;
	
	/** 구성 이력 순번 */
	private Long cstrtHistSeq;
	
	/** 구성 JSON */
	private String cstrtJson;

}