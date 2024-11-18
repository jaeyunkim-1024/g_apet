package biz.app.goods.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: gs-apet-11-business
* - 패키지명 	: biz.app.goods.model
* - 파일명 	: GoodsCstrtPakVO.java
* - 작성일	: 2021. 1. 15.
* - 작성자	: valfac
* - 설명 		: 상품 묶음 구성 VO
* </pre>
*/
@Data
@SuppressWarnings("serial")
@EqualsAndHashCode(callSuper=false)
public class GoodsCstrtPakVO extends BaseSysVO {

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

	/** 묶음 상품 명 */
	private String goodsNm;
	
	/** 판매가 */
	private Long saleAmt;

	/** 단품 번호 */
	private Long itemNo;
	
	/** 속성 */
	private String attr1No;
	private String attr1Nm;
	private String attr1Val;
	private String attr2No;
	private String attr2Nm;
	private String attr2Val;
	private String attr3No;
	private String attr3Nm;
	private String attr3Val;
	private String attr4No;
	private String attr4Nm;
	private String attr4Val;
	private String attr5No;
	private String attr5Nm;
	private String attr5Val;
	
	private String attrNo;
	private String attrNm;
	private String attrValNo;
	private String attrVal;
	
	/** 최소 구매 수량 */
	private String minOrdQty;
	
	/** 최대 구매 수량 */
	private String maxOrdQty;
	
	/** 주문제작 여부 */
	private String ordmkiYn;
	
	/** 재입고 알람 여부 */
	private String ioAlmYn;
	
	/** 판매가능상태코드 */
	private String salePsbCd;
	
	/** 브랜드 번호 */
	private String bndNo;
	/** 브랜드 명 */
	private String bndNmKo;

	
	
	/** 상품 이미지 */
	private String imgPath;
	/** 순번 */
	private long rownum;
	
	/** 단품재고수랑  */
	private Integer webStkQty;

	
	/** 상품 상태 코드 */
	private String goodsStatCd;
}