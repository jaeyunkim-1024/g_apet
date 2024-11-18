package biz.app.contents.model;

import framework.common.model.BaseSearchVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: gs-apet-11-business
* - 패키지명 	: biz.app.contents.model
* - 파일명 	: ApetContentsGoodsMapSO.java
* - 작성일	: 2021. 2. 9.
* - 작성자	: valfac
* - 설명 		: 컨텐츠 상품 매핑 SO
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
@SuppressWarnings("serial")
public class ApetContentsGoodsMapSO extends BaseSearchVO<ApetContentsGoodsMapSO> {

	/** 영상 ID */
	private String vdId;

	/** 상품 번호 */
	private String goodsId;
	
	/** 영상 구분 코드 */
	private String vdGbCd;
	
	/** 전시 여부 */
	private String dispYn;
	
	/** 컨텐츠 타입 코드 */
	private String contsTpCd;

}