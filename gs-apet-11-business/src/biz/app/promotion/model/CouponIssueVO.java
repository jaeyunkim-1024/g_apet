package biz.app.promotion.model;

import java.sql.Timestamp;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class CouponIssueVO extends CouponBaseVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 발급 일련 번호 */
	private String isuSrlNo;
	
	/** 주문번호 */
	private String ordNo;
	
	/** 주문상세번호 */
	private Long ordDtlSeq;

	/** 회원 쿠폰 번호*/
	private Long mbrCpNo;
	
	/** 프로모션 매핑 적용 구분 코드 (쿠폰 : 20) */
	private String prmtAplGbCd;
	
	/** 사용 여부 */
	private String useYn;
	
	private String mbrNm;
	
	private Timestamp useDtm;
	
	private Long mbrNo;
}