package biz.app.claim.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class ClmDtlCstrtPO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 클레임 상세 구성 번호 */
	private int    clmDtlCstrtNo;

	/** 클레임 번호 */
	private String clmNo;

	/** 클레임 구성 순번 */
	private int    clmCstrtSeq;

	/** 클레임 상세 순번 */
	private int    clmDtlSeq;

	/** 구성 상품 아이디 */
	private String cstrtGoodsId;

	/** SKU 코드 */
	private String skuCd;

	/** 주문 상세 구성 번호 */
	private int    ordDtlCstrtNo;

	/** 구성 상품 구분 코드 */
	private String cstrtGoodsGbCd;
	
	/** BO 노출용 상품 구분 코드 */
	private String showCstrtGbCd;

	/** 구성 수량 */
	private int    cstrtQty;

	/** 원 판매 금액 */
	private int    orgSaleAmt;

	/** 판매 금액 */
	private int    saleAmt;

	/** CIS 클레임 번호 */
	private String cisClmNo;

	/** CIS 클레임 상세 순번 */
	private int    cisClmDtlSeq;

	/** CIS 상태 코드 */
	private String cisStatCd;

	/** 상품 명 */
	private String goodsNm;
	
	/** 주문 번호 */
	private String ordNo;
	
	/** 주문 상세 순번 */
	private Integer ordDtlSeq;
	
	/** 상세 구성 순번 */
	private Integer ordCstrtSeq;
	
	/** 클레임수량 */
	private Integer clmQty;
	
	/** 주문 상세 상태 코드*/
	private String ordDtlStatCd;
	
	/** 단품 번호 */
	private Long itemNo;
	
}