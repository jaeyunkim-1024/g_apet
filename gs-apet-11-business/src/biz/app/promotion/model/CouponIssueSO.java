package biz.app.promotion.model;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSearchVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class CouponIssueSO extends BaseSearchVO<CouponIssueSO> {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 쿠폰 번호 */
	private Long cpNo;

	/** 발급 일련 번호 */
	private String isuSrlNo;

	/** 회원 쿠폰 번호 */
	private Long mbrCpNo;

	/** 회원 번호 */
	private Long mbrNo;
}