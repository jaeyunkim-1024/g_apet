package biz.app.order.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class OrdDtlCstrtPO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 주문 상세 구성 번호 */
	private Integer ordDtlCstrtNo;
	
	/** 주문 번호 */
	private String ordNo;
	
	/** 주문 상세 순번 */
	private Integer   ordDtlSeq;
	
	/** 주문 구성 순번 */
	private Integer   ordCstrtSeq;
	
	/** 구성 상품 아이디 */
	private String cstrtGoodsId;
	
	/** SKU 코드 */
	private String skuCd;
	
	/** 구성 상품 구분 코드 */
	private String cstrtGoodsGbCd;
	
	/** 구성 수량 */
	private Integer   cstrtQty;
	
	/** 원 판매 금액 */
	private Integer   orgSaleAmt;
	
	/** 판매 금액 */
	private Integer   saleAmt;
	
	/** CIS 주문 번호 */
	private String cisOrdNo;
	
	/** CIS 주문 상세 순번 */
	private Integer   cisOrdDtlSeq;
	
	/** CIS 상태 코드 */
	private String cisStatCd;
	
	/** CIS 화주 코드 */
	private String cisApiOwnrCd;
	/** CIS 물류 센터 코드 */
	private String cisApiWareCd;
	
}