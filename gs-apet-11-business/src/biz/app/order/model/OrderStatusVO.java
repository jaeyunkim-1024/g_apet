package biz.app.order.model;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class OrderStatusVO {

	/** 주문 접수 상품 */
	private Integer ordAcpt;

	/** 주문 완료 상품 */
	private Integer ordCmplt;

	/** 상품 준비중 상품 */
	private Integer ordShpRdy;

	/** 배송중 상품 */
	private Integer ordShpIng;

	/** 배송 완료 상품 */
	private Integer ordShpCmplt;

	/** 구매 확정 상품 */
	private Integer pchseCnfm;

	/** 주문 취소 상품 */
	private Integer ordCncl;

}
