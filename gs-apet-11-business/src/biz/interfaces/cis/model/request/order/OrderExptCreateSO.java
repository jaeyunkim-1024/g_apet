package biz.interfaces.cis.model.request.order;

import framework.cis.model.request.ApiRequest;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = true)
public class OrderExptCreateSO extends ApiRequest {

	private String shopOrdrNo;		/** 상점 주문번호 - 필수 */
	private String shopSortNo;		/** 상점 주문순번 - 필수 */
}