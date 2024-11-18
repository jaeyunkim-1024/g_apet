package biz.app.goods.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: gs-apet-11-business
* - 패키지명 	: biz.app.goods.model
* - 파일명 	: GoodsOptGrpVO.java
* - 작성일	: 2021. 1. 22.
* - 작성자	: valfac
* - 설명 		: SKU Base VO
* </pre>
*/
@Data
@SuppressWarnings("serial")
@EqualsAndHashCode(callSuper=false)
public class GoodsSkuBaseVO extends BaseSysVO {
	/** 상품Id */
	private String goodsId;
	/** sku코드 */
	private String skuCd;
	/** sku명 */
	private String skuNm;
	/** 모델명 */
	private String mdlNm;
	/** 원산지 */
	private String ctrOrg;
	/** 제조사 */
	private String mmft;
	/** 수입사 */
	private String importer;
	/** 매입업체번호 */
	private Long phsCompNo;
	/** 브랜드번호 */
	private Long bndNo;
	/** 수량 */
	private int stkQty;
	/** 수량 */
	private int realStkQty;
	
}