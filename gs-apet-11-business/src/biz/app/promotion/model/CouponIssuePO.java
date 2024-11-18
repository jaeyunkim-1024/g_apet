package biz.app.promotion.model;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSysVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class CouponIssuePO extends BaseSysVO {

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

	/** 난수 번호 감소 개수 */
	private Long decreaseCnt;

}