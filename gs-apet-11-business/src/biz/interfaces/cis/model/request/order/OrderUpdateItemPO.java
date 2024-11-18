package biz.interfaces.cis.model.request.order;

import lombok.Data;

@Data
public class OrderUpdateItemPO {
	
	private String shopOrdrNo;          /** 상점 주문번호		- 필수*/   //aboutPet 주문번호     
	private String shopSortNo;          /** 상점 주문순번		- 필수*/   //aboutPet (주문상세순번_주문구성순번) 으로 조합 [주의!!]     
	private String dlvtTpCd;            /** 배송 유형 코드	- 필수*/       
	private String dlvGrpCd;            /** 배송 권역 코드 */
	private String dawnMallId;          /** 새벽배송 배송센터코드 - 당일/새벽배송일 경우 필수*/
	private String dlvReqDd;            /** 배송 요청일자 */

}
