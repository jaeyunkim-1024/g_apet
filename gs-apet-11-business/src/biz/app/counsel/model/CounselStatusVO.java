package biz.app.counsel.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.counsel.model
* - 파일명		: CounselStatusVO.java
* - 작성일		: 2017. 6. 27.
* - 작성자		: Administrator
* - 설명			: 상담 요약정보 Value Object
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class CounselStatusVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 회원 구분 */
	private String	mbrGb;
	
	/** 주문 수 */
	private Integer	orderCnt;

	/** 클레임 진행 수 */
	private Integer	claimCnt;

	/** 환불 예정 수 */
	private Integer refundCnt;

	/** 환불 예정 금액 */
	private Long refundAmt;

	/** 1:1문의 진행 수 */
	private Integer cusWebCnt;

	/** 상담 진행 수 */
	private Integer cusCcCnt;

	/** 상품 평가 수 */
	private Integer goodsCmtCnt;

	/** 상품 문의 수 */
	private Integer goodsIqrCnt;
}
