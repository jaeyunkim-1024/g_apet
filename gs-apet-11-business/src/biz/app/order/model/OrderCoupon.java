package biz.app.order.model;

import java.io.Serializable;

import lombok.Data;

/**
 * <pre>
 * - 프로젝트명	: 11.business
 * - 패키지명		: biz.app.order.model
 * - 파일명		: OrderCoupon.java
 * - 작성일		: 2017. 2. 16.
 * - 작성자		: snw
 * - 설명		: 주문시 사용된 쿠폰 정보
 * </pre>
 */
@Data
public class OrderCoupon implements Serializable {

	private static final long serialVersionUID = 1L;

	/** 쿠폰 종류 코드 */
	private String cpKindCd;

	/** 장바구니 아이디 */
	private String cartId;

	/** 패키지 배송비 번호 */
	private Integer pkgDlvrNo;

	/** 회원 쿠폰 번호 */
	private Long mbrCpNo;

	/** 쿠폰 단가 금액 */
	private Long cpUnitAmt;

	/** 쿠폰 할인 금액 */
	private Long cpDcAmt;

	/** 쿠폰 번호 */
	private Long cpNo;
	
	/** 배송 정책 번호 */
	private Long dlvrcPlcNo;
}
