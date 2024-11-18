package biz.interfaces.cis.model.request.order;

import framework.cis.model.request.ApiRequest;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = true)
public class SlotInquirySO extends ApiRequest {

	private String dlvtTpCd;        /** 배송유형코드  필수 	- 20 : 당일배송, 21 : 새벽배송 */ 
	private String ymd;             /** 일자yyyyMMdd 필수	- 당일배송 : 11:30 이후에는 내일 날짜로 조회 요청, 새벽배송 : 21:00 이후에는 내일 날짜로 조회 요청*/
	private String mallId;          /** 배송센터코드 */ 
	private String dlvGrpCd;        /** 배송권역코드 */ 
	private String zipcode;         /** 우편번호 */     
}
