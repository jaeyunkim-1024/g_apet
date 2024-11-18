package biz.interfaces.goodsflow.model.request.data;

import java.io.Serializable;
import java.util.List;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.itf.goodsflow.model.request.data
* - 파일명		: Delivery.java
* - 작성일		: 2017. 6. 12.
* - 작성자		: WilLee
* - 설명		:
 * </pre>
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class DeliveryVO implements Serializable {

	private static final long serialVersionUID = 1L;

	private String inputType;
	private String dlvretType;
	private String transUniqueCode;
	private String sectionCode;
	private String sellerCode;

	private String fromName;
	private String fromZipCode;
	private String fromAddr1;
	private String fromAddr2;
	private String fromMobile;
	private String fromTelephone;
	private String toName;
	private String toZipCode;
	private String toAddr1;
	private String toAddr2;
	private String toMobile;
	private String toTelephone;

	private String logisticsCode;
	private String invoiceNo;
	private String invoicePrintDate;
	private String ordName;
	private String packingNo;
	private String payTypeCode;

	private String dlvrGbCd;
	
	private List<DeliveryGoodsVO> requestDetails;

}
