package biz.app.claim.model;

import java.sql.Timestamp;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.claim.model
* - 파일명		: ClaimDetailVO.java
* - 작성일		: 2017. 3. 9.
* - 작성자		: snw
* - 설명			: 클레임 상세 VO
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class ClaimDetailVO extends BaseSysVO {

	private static final long serialVersionUID = 1L;

	/** 클레임 번호 */
	private String clmNo;

	/** 클레임 상세 상태 코드 */
	private String clmStatCd;

	/** 클레임 상세 순번 */
	private Integer clmDtlSeq;

	/** 클레임 유형 코드 */
	private String clmTpCd;

	/** 맞교환 여부 */
	private String	swapYn;

	/** 클레임 상세 유형 코드 */
	private String clmDtlTpCd;

	/** 클레임 상세 상태 코드 */
	private String clmDtlStatCd;

	/** 클레임 상세 노출 상태 코드, 사용자에게 보여줄 상태 코드 */
	private String clmDtlGrpStatCd;

	/** 클레임 사유 코드 */
	private String clmRsnCd;

	/** 회원 번호 */
	private Long mbrNo;

	/** 클레임 사유 내용 */
	private String clmRsnContent;
	
	/** 클레임 거부사유 내용 */
	private String clmDenyRsnContent;

	/** 주문 번호 */
	private String ordNo;

	/** 주문 상세 순번 */
	private Integer ordDtlSeq;

	/** 원 클레임 번호 */
	private String 	orgClmNo;

	/** 원 클레임 상세 순번 */
	private Integer 	orgClmDtlSeq;

	/** 상품 아이디 */
	private String goodsId;

	/** 묶음 상품 아이디 */
	private String pakGoodsId;
	
	/** 상품 명 */
	private String goodsNm;

	/** 단품 번호 */
	private Long itemNo;

	/** 단품 명 */
	private String itemNm;

	/** 딜 상품 아이디 */
	private String dealGoodsId;

	/** 전시 분류 번호 */
	private Long dispClsfNo;

	/** 전시 분류 명 */
	private String dispClsfNm;

	/** 업체상품 번호 */
	private String compGoodsId;

	/** 업체단품 번호 */
	private String compItemId;

	/** 결제 금액 */
	private Long payAmt;

	/** 결제 환불 금액 */
	private Long rfdPayTotAmt;
	
	/** 클레임 수량 */
	private Integer clmQty;

	/** 수수료 */
	private Long cms;

	/** 상품수수료율 */
	private Double goodsCmsnRt;

	private String	taxGbCd;

	/** 배송비 번호 */
	private Long		dlvrcNo;

	/** 배송 번호 */
	private Long		dlvrNo;

	/** 회수비 번호 */
	private Long		rtnDlvrcNo;

	/** 배송지 번호 */
	private Long		dlvraNo;

	/** 회수지 번호 */
	private Long		rtrnaNo;

	/** 업체 번호 */
	private Long 	compNo;

	/** 업체 명 */
	private String compNm;

	/** 상위 업체 번호 */
	private Long 	upCompNo;

	/** 클레임 완료 일시 */
	private Timestamp	clmCpltDtm;

	/** 접수 일시 */
	private Timestamp acptDtm;

	/** 취소 일시 */
	private Timestamp cncDtm;

	/** 회수 방법 코드 */
	private String	rtnMtdCd;

	/** 외부 클레임 상세 번호 */
	private String	outsideClmDtlNo;
	
	private String	stlNo;

	private String	dlvrCpltPicUrl;

	private String	dlvrSms;

	private String	twcTckt;

	private String	dlvrCpltYn;

	/** 상품 이미지 순번 */
	private Integer imgSeq;

	/** image 경로 */
	private String imgPath;

	/** 반전 image 경로 */
	private String rvsImgPath;

	/** 브랜드명 국문 */
	private String bndNmKo;

	private ClaimBaseVO claimBaseVO;
	
	/**********************
	 * 주문 상세 관련
	 **********************/
	/** 주문 상세 상태 */
	private String ordDtlStatCd;

	/** 주문 수량 */
	private Integer ordQty;

	/** 잔여 주문 수량 */
	private Integer rmnOrdQty;

	/** 반품 수량 */
	private Integer rtnQty;

	/** 잔여 결제 금액 */
	private Long rmnPayAmt;
	
	/** 상품 판매 금액 */
	private Long saleAmt;
	
	/** 상품 가격 번호 */
	private Long goodsPrcNo;
	
	/**********************
	 * 적용혜택 정보
	 **********************/
	/** 프로모션 할인 금액 */
	private Long prmtDcAmt;

	/** 상품 쿠폰 할인 금액 */
	private Long cpDcAmt;
	
	/** 장바구니 쿠폰 할인 금액 */
	private Long cartCpDcAmt;
	
	/********************
	 * 기타 참조 정보
	 ********************/
	/** 잔여 수량 */
	private Integer	rmnQty;
	

	/********************
	 * 클레임 상세 이미지 정보
	 ********************/
	/** 클레임 상세 사유 순번 */
	private Integer clmDtlRsnSeq;

	/** 사유 이미지 PATH */
	private String rsnImgPath;
	
	/** 상품 구성 유형 */
	private String goodsCstrtTpCd;
	
	/** 사은품 */
	private String subGoodsNm;
	
	/** 배송 처리 유형 */
	private String dlvrPrcsTpCd;
	
	/** 재고 수량 */
	private Integer stkQty = 0;
	
	/** 업체 구분 코드 */
  	private String compGbCd;

  	/** 잔여 클레임 수량 */
	private Integer rmnClmQty;

	/** 클레임의 클레임 여부 */
	private String clmChainYn;
	
	/** 클레임의 클레임 수량 합계 */
	private int clmQtySum;
	
	/** 사전예약 여부 */
	private String rsvGoodsYn;

}