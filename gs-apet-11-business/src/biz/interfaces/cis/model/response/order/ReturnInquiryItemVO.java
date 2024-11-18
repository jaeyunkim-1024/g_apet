package biz.interfaces.cis.model.response.order;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.Data;

@Data
@JsonIgnoreProperties(ignoreUnknown = true)
public class ReturnInquiryItemVO{
	
	private String rtnsNo;			/** 반품번호 */
	private int    itemNo;			/** 품목번호 */
	private String ordrNo;			/** 주문번호 */
	private int    sortNo;			/** 주문순번 */
	private String rtnTpCd;			/** 반품유형코드 */
	private String rtnDueDd;		/** 반품예정일자 */
	private int    ea;				/** 수량 */
	private String statCd;			/** 상태코드 */
	private String rqstNm;			/** 요청자명 */
	private String rqstTelNo;		/** 요청자전화번호 */
	private String rqstCelNo;		/** 요청자휴대전화 */
	private String rqstZipcode;		/** 요청자우편번호 */
	private String rqstAddr;		/** 요청자주소 */
	private String rqstAddrDtl;		/** 요청자주소상세 */
	private String dlvCmpyCd;		/** 택배사 코드 */
	private String rmkTxt;			/** 비고 */
	private String exchgYn;			/** 교환반품여부 - 교환:Y */
	private String createDate;		/** 등록일시 */

}
