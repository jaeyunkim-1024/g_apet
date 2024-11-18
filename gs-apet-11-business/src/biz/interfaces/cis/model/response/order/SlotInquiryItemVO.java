package biz.interfaces.cis.model.response.order;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.Data;

@Data
@JsonIgnoreProperties(ignoreUnknown = true)
public class SlotInquiryItemVO{
	
	private String ymd;             /** 일자 */
	private String dlvtTpCd;        /** 배송유형코드 */
	private String mallId;          /** 배배송센터코드 */
	private String mallNm;          /** 배송센터이름 */
	private String dlvGrpCd;        /** 배송권역코드 */
	private String dlvGrpCdNm;      /** 배송권역이름 */
	private int    slotCnt;         /** 슬롯 할당수 */
	
	//당일배송 : 전날 11:30 이후 ~ 당일 11:30 주문수
	//새벽배송 : 전날 21:00 이후 ~ 당일 21:00 주문수
	//※ 주문 등록 시 전송되는 ordrDd 및 ordrTm 기준
	private int    usedCnt;         /** 슬롯 사용수 */

}
