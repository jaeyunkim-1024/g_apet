package biz.interfaces.goodsflow.model.response.data;

import java.sql.Timestamp;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.itf.goodsflow.model.response.data
* - 파일명		: GoodsFlowDeliveryResultPO.java
* - 작성일		: 2017. 6. 23.
* - 작성자		: WilLee
* - 설명			:
 * </pre>
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class GoodsFlowDeliveryResultPO extends BaseSysVO {

	private static final long serialVersionUID = 1L;

	private String itemUniqueCode;

	private Integer prcsSrlNo;

	private String dlvrStatCd;

	private String dlvrPrcsDtm;

	private Timestamp lnkDtm;

	private String lnkRstCd;

	private String lnkRstMsg;

}
