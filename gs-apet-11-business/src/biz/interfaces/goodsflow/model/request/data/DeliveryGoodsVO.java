package biz.interfaces.goodsflow.model.request.data;

import java.io.Serializable;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.itf.goodsflow.model.request.data
* - 파일명		: DeliveryGoods.java
* - 작성일		: 2017. 6. 12.
* - 작성자		: WilLee
* - 설명		:
 * </pre>
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class DeliveryGoodsVO implements Serializable {

	private static final long serialVersionUID = 1L;

	private String itemUniqueCode;

	private String ordNo;
	private Integer ordLineNo;
	// 주문번호 ord -> order
	private String orderNo;
	// 주문행 번호
	private Integer orderLine;


	private String itemCode;
	private String itemName;
	private String itemOption;
	private Integer itemQty;
	private Integer itemPrice;

	private String ordDate;
	private String paymentDate;

	private String defCode1;
	private String defCode2;
	
	private Integer dlvrNo;

}
