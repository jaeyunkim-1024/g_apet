package biz.interfaces.cis.model.request.order;

import java.util.List;

import framework.cis.model.request.ApiRequest;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = true)
public class OrderInsertPO extends ApiRequest {

	/** 주문자 이름 - 필수 */
	private String ordrNm;

	/** 주문자 전화번호 */
	private String ordrTelNo;

	/** 주문자 휴대전화 */
	private String ordrCelNo;

	/** 주문자 이메일 */
	private String ordrEmail;

	/** 수령자 이름 - 필수 */
	private String recvNm;

	/** 수령자 전화번호 */
	private String recvTelNo;

	/** 수령자 휴대전화 - 필수 */
	private String recvCelNo;

	/** 수령자 우편번호 - 필수 */
	private String recvZipcode;

	/** 수령자 주소 - 필수 */
	private String recvAddr;

	/** 수령자 주소 상세 */
	private String recvAddrDtl;

	/** 할인금액 */
	private int dcAmt=0;
	
	/** 쿠폰금액 */
	private int cpnAmt=0;
	
	/** 배송비 */
	private int dlvAmt=0;

	/** 공동현관 출입번호 */
	private String gateNo;

	/** 주문 일자 - 필수 */
	private String ordrDd;

	/** 주문 시간 */
	private String ordrTm;

	/** 비고 */
	private String rmkTxt;

	//private String ordrNo;
	//private String shopCd;
	
	/** itemList */
	private List<OrderInsertItemPO> itemList;
}
