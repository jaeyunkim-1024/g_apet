package biz.app.claim.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.claim.model
* - 파일명		: ClaimDetailPO.java
* - 작성일		: 2017. 3. 6.
* - 작성자		: snw
* - 설명			: 클레임 상세 PO
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class ClaimDetailPO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 클레임 번호 */
	private String clmNo;

	/** 클레임 상세 순번 */
	private Integer clmDtlSeq;

	/** 클레임 상세 유형 코드 */
	private String clmDtlTpCd;

	/** 클레임 상세 상태 코드 */
	private String clmDtlStatCd;

	/** 클레임 사유 코드 */
	private String clmRsnCd;

	/** 클레임 사유 내용 */
	private String clmRsnContent;
	
	/** 회원 번호 */
	private Long mbrNo;

	/** 주문 번호 */
	private String ordNo;

	/** 주문 상세 순번 */
	private Integer ordDtlSeq;

	/** 상품 아이디 */
	private String goodsId;

	/** 상품 아이디 */
	private String pakGoodsId;
	
	/** 상품 명 */
	private String goodsNm;

	/** 단품 번호 */
	private Long itemNo;

	/** 딜 상품 아이디 */
	private String dealGoodsId;

	/** 전시 분류 번호 */
	private Long dispClsfNo;

	/** 업체상품 번호 */
	private String compGoodsId;

	/** 업체단품 번호 */
	private String compItemId;

	/** 상품 가격 번호 */
	private Long 	goodsPrcNo;
	
	/** 판매 금액 */
	private Long saleAmt;

	/** 결제 금액 */
	private Long payAmt;

	/** 클레임 수량 */
	private Integer clmQty;

	/** 수수료 */
	private Long cms;

	/** 상품수수료율 */
	private Double goodsCmsnRt;
	
	private String	taxGbCd;
	
	/** 배송비 번호 */
	private Long		dlvrcNo;
	
	/** 회수비 번호 */
	private Long		rtnDlvrcNo;

	/** 배송지 번호 */
	private Long		dlvraNo;

	/** 회수지 번호 */
	private Long		rtrnaNo;
	
	/** 업체 번호 */
	private Long 	compNo;

	/** 상위 업체 번호 */
	private Long 	upCompNo;
	
	/** 회수 방법 코드 */
	private String	rtnMtdCd;

	/** 외부 클레임 상세 번호 */
	private String	outsideClmDtlNo;

	/** 원 배송비 번호 */
	private Long		orgDlvrcNo;
	
	/** 배송 완료 사진 URL */
	private String dlvrCpltPicUrl;
	
	/** 배송 완료 여부 */
	private String dlvrCpltYn;
	
	/** 배송 번호 */
	private Long dlvrNo;
	
	/***************************
	 * 참조 정보
	 ***************************/
//	/** 원 주문 상세의 배송비 번호 */
//	private Long ordDlvrcNo;
//	
//	/** 원 주문의 무료 배송 여부 */
//	private String ordFreeDlvrYn;
	
	/** 잔여 결제 금액 */
	private Long		rmnPayAmt;
	
	/** 잔여 수량 */
	private Integer	rmnQty;
	
	/** 상세 사유 사진 순번 */
	private Integer clmDtlRsnSeq;
	
	/** 상세 사유 사진 URL */
	private String imgPath;
	
	/** 상세 사유 사진 삭제 여부 */
	private String delYn;
	
	/** 클레임 거부 사유 */
	private String clmDenyRsnContent;
	
	/** 클레임상세 전체 배송완료여부 */
	private String clmDtlAllDlvrCpltYn;
	
	/** 감소 클레임 수량 */
	private Integer	reduceRmnClmQty;
	
	/** 감소 클레임 수량 */
	private Integer	rmnClmQty;
	
	/** 원 클레임 번호 */
	private String 	orgClmNo;

	/** 원 클레임 상세 순번 */
	private Integer 	orgClmDtlSeq;
}