package biz.interfaces.cis.model.request.order;

import java.util.List;

import framework.cis.model.request.ApiRequest;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = true)
public class OrderUpdatePO extends ApiRequest {

	private String shopOrdrNo;      /** 상점 주문번호		- 필수*/
	private String recvNm;          /** 수령자 이름 		- 필수*/
	private String recvTelNo;       /** 수령자 전화번호 */
	private String recvCelNo;       /** 수령자 휴대전화	- 필수*/
	private String recvZipcode;     /** 수령자 우편번호	- 필수 */
	private String recvAddr;        /** 수령자 주소 		- 필수*/
	private String recvAddrDtl;     /** 수령자 주소 상세 */
	private String gateNo;          /** 공동현관 출입번호 */
	
	/** itemList */
	private List<OrderUpdateItemPO> itemList;
}
