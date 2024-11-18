package biz.app.order.model;

import lombok.Data;

/**
 * <pre>
 * - 프로젝트명	: gs-apet-31-front
 * - 패키지명	: front.web.view.order.model
 * - 파일명		: OrderAdbrixVO.java
 * - 작성일		: 2021. 04. 24.
 * - 작성자		: JinHong
 * - 설명		: 주문 adbrix VO 
 * </pre>
 */
@Data
public class OrderAdbrixVO {
	
	//장바구니 담기
	//adbrix
	private String goodsId;
	
	private String goodsNm;
	
	private Long salePrc;
	
	private Long orgSalePrc;
	
	private Integer buyQty;
	private Integer discount;
	
	private String dispClsfNm1;
	private String dispClsfNm2;
	private String dispClsfNm3;
	
	//GA
	private String bndNm;
	private String compNm;
	  
}
