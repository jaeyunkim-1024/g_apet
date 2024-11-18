package biz.interfaces.cis.model.request.order;

import java.util.List;

import framework.cis.model.request.ApiRequest;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = true)
public class ReturnInsertPO extends ApiRequest {

	private String rtnTpCd;			/** 반품유형코드 - 필수 */
	private String rtnDueDd;		/** 반품예정일자 - 필수 */
	private String rqstNm;			/** 요청자 이름  - 필수 */
	private String rqstTelNo;		/** 요청자 전화번호 */
	private String rqstCelNo;		/** 요청자 휴대전화 - 필수 */
	private String rqstZipcode;		/** 요청자 우편번호 - 필수 */
	private String rqstAddr;		/** 요청자 주소     - 필수 */
	private String rqstAddrDtl;		/** 요청자 주소 상세- 필수 */
	private String rmkTxt;			/** 비고 */

	/** itemList */
	private List<ReturnInsertItemPO> itemList;

}
