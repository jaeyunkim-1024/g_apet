package biz.app.claim.model.interfaces;

import java.sql.Timestamp;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSysVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class ClaimListVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 클레임 번호 */
	private String clmNo;

	/** 사이트 ID */
	private Long stId;
	
	/** 주문 번호 */
	private String ordNo;

	/** 클레임 유형 코드 */
	private String clmTpCd;
	
	/** 클레임 상태 코드 */
	private String clmStatCd;
	
	/** 접수 일시 */
	private Timestamp acptDtm;

	/** 취소 일시 */
	private Timestamp cncDtm;

	/** 완료 일시 */
	private Timestamp cpltDtm;

	/****************************
	 * 클레임 상세 정보
	 ***************************/
	/** 클레임 상세 순번 */
	private Integer clmDtlSeq;

	/** 주문 상세 순번 */
	private Integer ordDtlSeq;
	
	/** 클레임 상세 유형 코드 */
	private String	clmDtlTpCd;

	/** 클레임 상세 상태 코드 */
	private String	clmDtlStatCd;
	
	/** 클레임 사유 코드 */
	private String clmRsnCd;

	/** 클레임 사유 내용 */
	private String clmRsnContent;
	
	/** 클레임 거부사유 내용 */
	private String clmDenyRsnContent;
	
	/** 상품 아이디 */
	private String goodsId;

	/** 상품 명 */
	private String goodsNm;

	/** 단품 번호 */
	private Long itemNo;

	/** 단품 명 */
	private String itemNm;

	/** 전시 분류 번호 */
	private Long dispClsfNo;
	
	/** 업체상품 번호 */
	private String compGoodsId;

	/** 업체단품 번호 */
	private String compItemId;
	
	/** 판매 금액 */
	private Long saleAmt;
	
	/** 결제 금액 */
	private Long payAmt;

	/** 클레임 수량 */
	private Integer clmQty;

	/** 클레임 완료 일시 */
	private Timestamp clmCpltDtm;
	
	/** 주문 수량 */
	private Long ordQty;

	/** 공급 금액 */
	private Long splAmt;

	/** 상품수수료율 */
	private Double goodsCmsnRt;

	/** 상품 쿠폰 할인 금액 */
	private Long goodsCpDcAmt;

	/** 배송비 쿠폰 할인 금액 */
	private Long dlvrcCpDcAmt;

	/** 조립비 쿠폰 할인 금액 */
	private Long asbcCpDcAmt;

	/** 장바구니 쿠폰 할인 금액 */
	private Long cartCpDcAmt;

	/** 적립금 할인 금액 */
	private Long svmnDcAmt;

	/** 결제 번호 */
	private Long payNo;

	/** 업체 번호 */
	private Long compNo;

	/** 업체 계약 번호 */
	private String compContrNo;

	/** 배송 번호 */
	private Long dlvrNo;
	
	/** 배송비 번호 */
	private Long dlvrcNo;

	/** 배송지 번호 */
	private Long dlvraNo; 
	
	/** 회수지 번호 */
	private Long  rtrnaNo;
	
	/** 조립비 번호 */
	private Integer asbcNo;

	/** 회원 번호 */
	private Integer mbrNo;

	/** 수거 지시 일시 */
	private Timestamp puCmdDtm;

	/** 수거 완료 일시 */
	private Timestamp puCpltDtm;

	/** 배송 희망 일자 */
	private String dlvrHopeDt;

	/** 상품 준비 일시 */
	private Timestamp goodsPrpDtm;

	/** 출고 지시 일시 */
	private Timestamp ooCmdDtm;

	/** 출고 완료 일시 */
	private Timestamp ooCpltDtm;

	/** 배송 완료 일시 */
	private Timestamp dlvrCpltDtm;

	/** 클레임 접수 일시 */
	private Timestamp clmAcptDtm;


	/** 클레임 취소 일시 */
	private Timestamp clmCncDtm;

	/** AS 희망 일자 */
	private String asHopeDt;

	/** AS 금액 */
	private Long asAmt;

	/** AS 기사 아이디 */
	private Long asDrvId;

	/** AS 기사 명 */
	private String asDrvNm;

	/** AS 비용 여부 */
	private String asCostYn;

	/** AS 이미지 파일명 */
	private String asImgFlnm;

	/** AS 이미지 경로명 */
	private String asImgPathnm;

	/** AS 카테고리1 코드 */
	private String asCtg1Cd;

	/** AS 카테고리2 코드 */
	private String asCtg2Cd;

	/** AS 카테고리3 코드 */
	private String asCtg3Cd;

	/** 메모 */
	private String memo;

	/** 주문 상세 상태 코드 */
	private String ordDtlStatCd;

	//================================================================================
	// ETC
	//================================================================================

	/** 결제 수단 코드 */
	private String payMeansCd;
	
	/**결제/환급완료일 */
	private Timestamp payCpltDtm;

	/** 결제/환급금액 */
	private Long payAmt2;
	
	/** 주문 번호 카운트 */
	private Integer ordDtlCnt;

	/** 주문 번호 일련번호 */
	private Integer ordDtlRowNum;

	/** 클레임 번호 카운트 */
	private Integer clmDtlCnt;

	/** 클레임 번호 일련번호 */
	private Integer clmDtlRowNum;

	/** 결제 금액 합계 */
	private Long payAmtTotal;

	//================================================================================
	// CLAIM_BASE
	//================================================================================



	/** 주문 매체 코드 */
	private String ordMdaCd;

	/** 접수자 번호 */
	private Integer acptrNo;

	/** 취소자 번호 */
	private Integer cncrNo;

	/** 완료자 번호 */
	private Integer cpltrNo;

	/** 회원명 */
	private String mbrNm;

	/** 접수자 명 */
	private String acptrNm;

	/** 취소자 명 */
	private String cncrNm;

	/** 완료자 명 */
	private String cpltrNm;

	/** 사이트 명 */
	private String stNm;

	/** 맞교환여부 */
	private String swapYn;
	
	/** 채널ID */
	private Integer chnlId;
}