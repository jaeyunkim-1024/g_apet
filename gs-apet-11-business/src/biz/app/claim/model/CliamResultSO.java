package biz.app.claim.model;

import java.util.List;

import biz.app.claim.model.ClaimRefundVO.Means;
import framework.common.model.BaseSearchVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class CliamResultSO extends BaseSearchVO<CliamResultSO> {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 주문 번호 */
	private String ordNo;

	/** 주문 상세 상태 코드 */
	private String ordDtlStatCd;

	/** 결제 수단 코드 */
	private String payMeansCd;

	/** 은행 코드 */
	private String bankCd;

	/** 계좌 번호 */
	private String acctNo;

	/** 예금주 명 */
	private String ooaNm;

	/****************************
	 * 환불 금액 정보
	 ****************************/
	/** 상품금액 */
	private Long		goodsAmt;
	
	/** 원배송비 */
	private Long 	orgDlvrcAmt;
	
	/** 반품/교환비 */
	private Long		clmDlvrcAmt;

	/** 환불 예정 금액 */
	private Long		totAmt;
	
	/** 수단별 환불 금액 단, 환불예정금액이 0원 이상일 경우에만 */
	private List<Means> meansList;
	
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

		/** 환불 수단명 */
		private String	meansNm;

		/** 환불 금액 */
		private Long		refundAmt;

	}

	/********************************
	 * 수거지 관한 내역
	 ********************************/
	/** 우편 번호 구 */
	private String postNoOld;

	/** 우편 번호 신 */
	private String postNoNew;

	/** 도로 주소 */
	private String roadAddr;

	/** 도로 상세 주소 */
	private String roadDtlAddr;

	/** 지번 주소 */
	private String prclAddr;

	/** 지번 상세 주소 */
	private String prclDtlAddr;

	/** 전화 */
	private String tel;

	/** 휴대폰 */
	private String mobile;

	/** 수취인 명 */
	private String adrsNm;

	/** 배송 메모 */
	private String dlvrMemo;

}