package biz.interfaces.cis.model.request.order;

import framework.cis.model.request.ApiRequest;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = true)
public class ReturnInquirySO extends ApiRequest {

	private String rtnsNo;			 /** 반품번호 */
	private String shopOrdrNo;		 /** 상점주문번호 */
	private String clltOrdrNo;		 /** 수집처주문번호	*/
	private String srcStaDd;		 /** 검색시작일자 */
	private String srcEndDd;		 /** 검색종료일자 */
	private String allYn="N";		 /** 전체여부 */
	
}
