package biz.app.promotion.model;

import java.util.List;

import framework.common.model.BaseSearchVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class CouponTargetSO extends BaseSearchVO<CouponTargetSO> {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 쿠폰 번호 */
	private Long cpNo;

	/** 적용 순번 */
	private Long aplSeq;

	/** 전시 분류 번 */
	private Long dispClsfNo;
	
	/** 회원 번호 */
	private Long mbrNo;

	/** 브랜드 번호 */
	private String bndId;

	/** 업체 번호 */
	private Long compNo;

	private List<String> webMobileGbCds;
	
	private String webMobileGbCd;
	
	/** 사이트 아이디 */
	private Long stId;
	private String goodsId;

}
