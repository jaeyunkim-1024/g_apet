package biz.interfaces.cis.model.response.order;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.Data;

@Data
@JsonIgnoreProperties(ignoreUnknown = true)
public class OrderInquiryExptVO{
	
	private String exptNo;		    /** 출고번호 */
	private String ordrNo;		    /** 주문번호 */
	private Long   sortNo;		    /** 주문순번 */
	private Long   reqEa;		    /** 출고 요청 수량 */
	private Long   expEa;		    /** 출고 확정 수량 */
	private Long   dlvEa;		    /** 배송 수량 */
	private String invcNo;		    /** 송장 번호 */
	private String dlvCmpyCd;	    /** 택배사 코드 */
	private String dawnCmplYn;      /** 당일/새벽배송 완료 여부 */
	private String dawnImgSrc;      /** 당일/새벽배송 이미지 경로 */

}
