package biz.interfaces.cis.model.request.order;

import framework.cis.model.request.ApiRequest;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = true)
public class ReturnCancelPO extends ApiRequest {

	private String rtnsNo;		/** 반품번호 - 필수 */
	private int    itemNo;		/** 품목번호 - 필수 */
	private String statCd;		/** 상태코드 - 필수 */

}
