package biz.interfaces.goodsflow.model.response.data;

import java.io.Serializable;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.itf.goodsflow.model.response.data
* - 파일명		: Invoice.java
* - 작성일		: 2017. 5. 31.
* - 작성자		: WilLee
* - 설명			:
 * </pre>
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class InvoiceVO implements Serializable {

	private static final long serialVersionUID = 1L;

	private String logisticsCode;

	private String invoiceNo;

	private boolean isOk;

	public void setIsOk(boolean isOk) {
		this.isOk = isOk;
	}

	public boolean getIsOk() {
		return isOk;
	}

	public boolean isOk() {
		return isOk;
	}

}
