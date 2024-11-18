package biz.interfaces.cis.model.response.order;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.Data;

@Data
@JsonIgnoreProperties(ignoreUnknown = true)
public class RngeInquiryItemVO{
	
	private String dlvtTpCd;            /** 배송유형코드 - 20 : 당일배송, 21 : 새벽배송 */
	private String zipcode;             /** 우편번호 */
	private String sido;                /** 시/도 */
	private String gugun;               /** 구/군 */
	private String dong;                /** 동 */
	private String mallId;              /** 배송센터코드 */
	private String mallNm;              /** 배송센터이름 */
	private String dlvGrpCd;            /** 배송권역코드 */
	private String dlvGrpCdNm;          /** 배송권역이름 */
	private String turnNo;              /** 회차 */

}
