package front.web.view.order.model;

import lombok.Data;

/**
* <pre>
* - 프로젝트명	: 31.front.web
* - 패키지명	: front.web.view.order.model
* - 파일명		: OrderInfo.java
* - 작성일		: 2016. 5. 4.
* - 작성자		: snw
* - 설명		: 주문 결제 Request 정보
* </pre>
*/
@Data
public class CookieGoods {

	private String goodsId;
	
	private String goodsNm;
	
	private Long saleAmt;
	
	private Long dcAmt;
	
	private Long dcRate;
	
	private Integer imgSeq;
	
	private String imgPath;
	
	private String rvsImgPath;
	
	private String imgGoodsId;
	
	private Integer bndNo;
	
}
