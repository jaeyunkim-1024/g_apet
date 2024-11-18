package biz.interfaces.goodsflow.model.response.data;

import java.sql.Timestamp;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.itf.goodsflow.model.response.data
* - 파일명		: GoodsFlowDeliveryVO.java
* - 작성일		: 2017. 6. 14.
* - 작성자		: WilLee
* - 설명			:
 * </pre>
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class GoodsFlowDeliveryPO extends BaseSysVO {

	private static final long serialVersionUID = 1L;

	private String itemUniqueCode;

	private Long dlvrNo;

	private Integer dtlSeq;

	private Timestamp lnkDtm;

	private String lnkRstCd;

	private String lnkRstMsg;

}
