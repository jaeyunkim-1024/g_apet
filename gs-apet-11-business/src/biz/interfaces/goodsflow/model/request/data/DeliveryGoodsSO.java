package biz.interfaces.goodsflow.model.request.data;

import java.io.Serializable;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.itf.goodsflow.model.request.data
* - 파일명		: DeliveryGoodsSO.java
* - 작성일		: 2017. 6. 14.
* - 작성자		: WilLee
* - 설명		:
 * </pre>
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class DeliveryGoodsSO implements Serializable {

	private static final long serialVersionUID = 1L;

	private String transUniqueCode;

	private Long dlvrNo;

	private String dlvrGbCd;

}
