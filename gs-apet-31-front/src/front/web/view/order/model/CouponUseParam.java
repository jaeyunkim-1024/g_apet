package front.web.view.order.model;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.PopParam;

/**
* <pre>
* - 프로젝트명	: 31.front.web
* - 패키지명		: front.web.view.order.model
* - 파일명		: CouponUseParam.java
* - 작성일		: 2017. 6. 5.
* - 작성자		: Administrator
* - 설명			: 쿠폰 사용 팝업 Param
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=true)
public class CouponUseParam extends PopParam {
	
	private static final long serialVersionUID = 1L;
	
	/** 사용 상품 쿠폰 검색 list*/
	private String selGoodsCouponListStr;
	
	/** 사용 장바구니 쿠폰 검색 list*/
	private String selCartCouponListStr;
	
	/** 사용 배송비 쿠폰 */
	private String selDlvrcCouponStr;
	
	/** 쿠폰 팝업 호출 유형 
	 *  CART - 장바구니에서 호출(상품쿠폰조회)
	 *  ORD - 주문서 상품/배송비 쿠폰
	 *  ORD_CART - 주문서 장바구니쿠폰
	 *  */
	private String cpPopTp;
	
	/** 장바구니 쿠폰 적용 결제 금액 */
	private Long totGoodsAmt;
	
	/** 배송비 쿠폰 적용 결제 금액 */
	private Long totLocalGoodsAmt;
	
	/** 장바구니 쿠폰 - 적용 쿠폰 번호 */
	private Long cartSelMbrCpNo;
		
	
	
	
	/*         사용안함      */
	/** 장바구니 아이디 */
	private String[] cartIds;

	/** 패키지 배송비 번호 */
	private Integer[]		pkgDlvrNos;
	
	/** 패키지 배송비 금액 */
	private Long[] 		pkgDlvrAmts;
}