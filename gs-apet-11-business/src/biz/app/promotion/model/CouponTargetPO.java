package biz.app.promotion.model;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSysVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class CouponTargetPO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 쿠폰 번호 */
	private Long cpNo;

	/** 적용 순번 */
	private Long aplSeq;

	/** 전시 분류 번 */
	private Long dispClsfNo;
	
	/** 기획전 번호 */
	private Long exhbtNo;
	
	/** 상품 아이디 */
	private String goodsId;
	
	
	/** 업체번호 */
	private Long compNo;
	/** 브랜드번호 */
	private Long bndNo;
	

}