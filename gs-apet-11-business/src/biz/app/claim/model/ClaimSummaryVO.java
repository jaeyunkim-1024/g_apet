package biz.app.claim.model;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class ClaimSummaryVO {

	/** 반품 접수 상품수 */
	private Integer rtnAcpt;
	
	/** 반품 진행중 상품수 */
	private Integer rtnIng;
	
	/** 반품 완료 상품수 */
	private Integer rtnCmplt;
	
	/** 교환 접수 상품수 */
	private Integer exchgAcpt;
	
	/** 교환 진행중 상품수 */
	private Integer exchgIng;
	
	/** 교환 완료 상품수 */
	private Integer exchgCmplt;
	
	/** Derived Attribute */
	public Integer getAllReturnClaimCount() {
		return this.getRtnAcpt() + this.getRtnIng() + this.getRtnCmplt();
	}
	
	public Integer getAllExchangeClaimCount() {
		return this.getExchgAcpt() + this.getExchgIng() + this.getExchgCmplt();
	}

}
