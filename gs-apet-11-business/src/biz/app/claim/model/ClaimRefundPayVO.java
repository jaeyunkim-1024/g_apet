package biz.app.claim.model;

import java.util.List;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.claim.model
* - 파일명		: ClaimBaseVO.java
* - 작성일		: 2017. 3. 7.
* - 작성자		: snw
* - 설명			: 클레임 기본 VO
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class ClaimRefundPayVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 클레임 번호 */
	private String clmNo;

	/** 상품 합계 금액 */
	private Long goodsAmt;

	/** 원 취소된 배송 금액 */
	private Long orgDlvrcAmt;
	
	/** 쿠폰 할인 금액 */
	private Long	 cpDcAmt;
	
	/** 추가 쿠폰 할인 금액 */
	private Long addCpDcAmt;

	/** 신규 반품/교한 회수 배송비 금액 */
	private Long newRtnOrgDlvrcAmt;

	/** 추가 배송비 */
	private Long clmDlvrcAmt;
	
	/** MP 포인트 환불 사용금액 - 추가 사용금액 제외 */
	private Long mpRefundUseAmt;
	
	
	/** 클레임 환불 가격 List VO */
	private List<ClaimRefundPayDetailVO> claimRefundPayDetailListVO;

	/** 총 환불 금액 */
	public Long getTotAmt() {
		Long totAmt = 0L;
		
		for (ClaimRefundPayDetailVO vo : claimRefundPayDetailListVO) {
			totAmt += vo.getPayAmt();
		}
		
		return totAmt;
	}
	
	/** 총 환불 포인트 */
	public Long getTotPointAmt() {
		Long totPointAmt = 0L;
		
		for (ClaimRefundPayDetailVO vo : claimRefundPayDetailListVO) {
			if("80".equals(vo.getPayMeansCd())) {
				totPointAmt += vo.getPayAmt();
			}
		}
		
		return totPointAmt;
	}
	
	/** 은행 코드 */
	private String 	bankCd;

	/** 계좌 번호 */
	private String 	acctNo;

	/** 예금주 명 */
	private String 	ooaNm;
	
	/* 환불 배송비 */
	private Long refundDlvrAmt;
	/* 환불 추가배송비 */
	private Long refundAddDlvrAmt;

}