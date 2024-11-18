package biz.app.claim.model;

import java.io.Serializable;
import java.util.List;

import lombok.Data;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.claim.model
* - 파일명		: ClaimRefundVO.java
* - 작성일		: 2017. 3. 6.
* - 작성자		: snw
* - 설명			: 클레임 환불 VO
* </pre>
*/
@Data
public class ClaimRefundVO implements Serializable {

	/** UID */
	private static final long serialVersionUID = 1L;

	/****************************
	 * 환불 금액 정보
	 ****************************/
	
	//=========결제 정보============
	/** 상품금액 */
	private Long		goodsAmt;
	
	/** 상품 쿠폰 할인 금액 */
	private Long		cpDcAmt;
	
	/** 장바구니 쿠폰 할인 금액 */
	private Long		cartCpDcAmt;
	//=========차감 정보============
	
	/** 원배송비 */
	private Long 	orgDlvrcAmt;
	
	/** 클레임 대상 실배송비 */
	private Long 	realDlvrAmt;
	
	/** 무료배송 깨졋을 경우 -환불금액, 유료배송일경우 +환불금액 */
	private Long 	reduceDlvrcAmt;
	
	/** 반품/교환비 */
	private Long		clmDlvrcAmt;
	// 추가 원 배송 금액 : 배송비
	private long clmDlvrcAmtCostGb10;
	// 추가 원 배송 금액 : 회수비
	private long clmDlvrcAmtCostGb20;
	
	/** 환불 예정 금액 */
	private Long		totAmt;
	
	//=========환불정보============
	
	/** 추가 환불 배송 금액 */
	private Long addReduceDlvrcAmt;
	
	/** 추가 원 배송 금액 */
	private Long addOrgDlvrcAmt;
	private long refundDlvrAmt;
	
	/** 수단별 환불 금액 단, 환불예정금액이 0원 이상일 경우에만 */
	private List<Means> meansList;
	
	/** MP 포인트 사용금액*/
	private Long mpRefundUsePnt;
	
	/** MP 포인트 추가 사용금액*/
	private Long mpRefundAddUsePnt;
	

	/* MP 포인트 재계산 사용여부 체크 - N Start */
	private String mpReCalculateYn;
	/* MP 포인트 재계산 사용여부 체크 - N End */
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 패키지명		: biz.app.claim.model
	* - 파일명		: ClaimRefundVO.java
	* - 작성일		: 2017. 4. 19.
	* - 작성자		: Administrator
	* - 설명			: 환불 수단 정보
	* </pre>
	*/
	@Data
	public static class Means{
		
		/** 결제 수단 코드 */
		private String	payMeansCd;
		
		/** 환불 수단명 */
		private String	meansNm;

		/** 환불 금액 */
		private Long		refundAmt;

	}
	
}