package biz.app.market.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.market.model
* - 파일명	: MarketClaimConfirmPO.java
* - 작성일	: 2017. 10. 17.
* - 작성자	: schoi
* - 설명		: Outbound API 클레임 VO
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class MarketClaimConfirmPO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/****************************
	 * Outbound API 클레임 이력 상세 정보
	 ****************************/
	/* 클레임 일련번호 */
	private Long clmSeq;

	/* 클레임 일련번호 */
	private Long[] arrClmSeq;
	
	/* 클레임 번호 */
	private String clmNo;
	
	/* 사이트 ID */
	private Integer stId;
	
	/* 회원 번호 */
	private Integer mbrNo;
	
	/* 클레임 코드(10:취소,20:반품,30:교환) */
	private String clmTpCd;
	
	/* 클레임 상태 코드 */
	private String clmStatCd;
	
	/* 주문 매체 코드 */
	private String ordMdaCd;
	
	/* 채널 ID */
	private Integer chnlId;
	
	/* 맞 교환 여부 */
	private String swapYn;
	
	//==========================================
	
	/* 클레임 상세 번호 */
	private Integer clmDtlSeq;
	
	/* 클레임 상세 유형 코드 */
	private String clmDtlTpCd;
	
	/* 클레임 상세 상태 코드 */
	private String clmDtlStatCd;
	
	/* 클레임 사유 코드 */
	private String clmRsnCd;
	
	/* 클레임 사유 내용 */
	private String clmRsnContent;
	
	/* 클레임 거부 사유 내용 */
	private String clmDenyRsnContent;
	
	/* 주문 번호 */
	private String ordNo;
	
	/* 주문 상세 순번 */
	private Integer ordDtlSeq;
	
	/* 단품 번호 */
//	private Integer itemNo;
	
	/* 단품 명 */
//	private String itemNm;
	
	/* 판매 금액 */
	private Long saleAmt;
	
	/* 결제 금액 */
	private Long payAmt;
	
	/* 잔여 결제 금액 */
	private Long rmnPayAmt;
	
	/* 과세 구분 코드 */
	private String taxGbCd;
	
	/* 배송비 번호 */
	private Integer dlvrcNo;
	
	/* 회수비 번호 */
	private Integer rtnDlvrcNo;
	
	/* 배송지 번호 */
	private Integer dlvraNo;
	
	/* 회수지 번호 */
	private Integer rtrnaNo;
	
	/* 배송 번호 */
	private Integer dlvrNo;
	
	/* 회수 방법 코드 */
	private String rtnMtdCd;
	
	//==========================================

	/* Outbound API 이력 구분(20:발주확인할내역(결재완료_목록조회),21:발주확인처리,22:발송처리(배송중_처리),23:판매불가처리,30:취소신청목록조회,31:취소승인처리,32:취소거부처리,33:교환신청목록조회,34:교환승인처리,35:교환거부처리,36:반품신청목록조회,37:반품승인처리,38:반품거부처리) */
	private Integer obApiCd;

	//==========================================
	
	/* 마켓명(10:11번가,20:G마켓) */
	private String marketNm;
	
	/* 판매자아이디 */
	private String sellerId;
	
	/* 클레임 상태 */
	private String clmStat;
	
	/* 쇼핑몰매칭상품코드 */
	private String shopPrdNo;
	
	/* 쇼핑몰매칭상품명 */
	private String shopPrdNm;
	
	/* 판매자상품번호 */
	private String sellerPrdCd;
	
	/* 주문상품옵션코드 */
	private Integer prdStckNo;
	
	/* 쇼핑몰매칭옵션명 */
	private String shopPrdOptNm;

	/* 클레임 옵션명 */
	private String clmSlctPrdOptNm;
	
	/* 클레임 요청 일시 */
//	private String clmReqDt;

	/* 처리상태(10:취소수집,11:취소승인,12:취소거부,13:취소완료,19:취소수집에러,20:반품수집,21:반품승인,22:반품거부,23:반품완료,29:반품수집에러,30:교환수집,31:교환승인,32:교환거부,33:교환보류,34:교환완료,39:교환수집에러) */
	private String procCd;
	
	/* 클레임처리자ID */
	private String shopClmId;
	
	/* 클레임완료일시 */
	private String shopClmDt;
	
}