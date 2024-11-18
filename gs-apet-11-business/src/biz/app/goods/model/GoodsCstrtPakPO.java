package biz.app.goods.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;


/**
* <pre>
* - 프로젝트명	: gs-apet-11-business
* - 패키지명 	: biz.app.goods.model
* - 파일명 	: GoodsCstrtPakPO.java
* - 작성일	: 2021. 1. 15.
* - 작성자	: valfac
* - 설명 		: 상품 묶음 구성 PO
* </pre>
*/
@Data
@SuppressWarnings("serial")
@EqualsAndHashCode(callSuper=false)
public class GoodsCstrtPakPO extends BaseSysVO {

	/** 상품 아이디  */
	private String goodsId;
	
	/** 묶음 상품 아이디  */
	private String subGoodsId;
	
	/** 구성 노출명  */
	private String cstrtShowNm;
	
	/** 전시 순서  */
	private Integer dispPriorRank;
	
	/** 전시 여부  */
	private String showYn;
	
	/** 품절 여부  */
	private String soldOutYn;
	
	/** 품절 제외 여부  */
	private String soldOutExceptYn;
	
	/** 상품 가격  */
	private String saleAmt;
	
	/* 속성 */
	private String attr1No;
	private String attr1ValNo;
	private String attr2No;
	private String attr2ValNo;
	private String attr3No;
	private String attr3ValNo;
	private String attr4No;
	private String attr4ValNo;
	private String attr5No;
	private String attr5ValNo;
	

}