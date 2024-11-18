package biz.app.goods.model;

import framework.cis.model.request.ApiRequest;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.sql.Timestamp;

/**
* <pre>
* - 프로젝트명	: gs-apet-11-business
* - 패키지명 	: biz.interfaces.cis.model.request.goods
* - 파일명 	: SkuInfoSO.java
* - 작성일	: 2021. 2. 18.
* - 작성자	: valfac
* - 설명 		: CIS 상품 SO
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper = true)
public class SkuInfoSO extends ApiRequest {

	/** 상품 구성 유형 - ITEM:단품 ATTR:옵션 SET:세트 PAK:묶음 */
	private String goodsCstrtTpCd;
	
	/** 배치 여부 */
	private String batchYn;
	
	/** 상품 아이디 */
	private String goodsId;
	
	/** 전송 타입 */
	private String sendType;
	
	/** 전송 일시 */
	private Timestamp sendDtm;
}
