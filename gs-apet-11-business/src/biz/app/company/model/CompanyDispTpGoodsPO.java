package biz.app.company.model;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSysVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class CompanyDispTpGoodsPO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;
	
	/** 업체 번호 */
	private Long compNo;
	
	/** 상품 번호 */
	private String goodsId;

	/** 전시 우선 순위 */
	private Integer dispPriorRank;
}