package biz.interfaces.cis.model.request.order;

import framework.cis.model.request.ApiRequest;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = true)
public class RngeInquirySO extends ApiRequest {

	private String dlvtTpCd;        /** 배송유형코드	필수	- 20 : 당일배송, 21 : 새벽배송*/ 
	private String zipcode;         /** 우편번호 */     
}
