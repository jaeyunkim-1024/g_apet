package biz.interfaces.cis.model.response.order;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.Data;

@Data
@JsonIgnoreProperties(ignoreUnknown = true)
public class OrderInsertItemVO{
	
	/** 주문번호 */
	private String ordrNo;
	
	/** 주문순번 */
	private int sortNo;
	
	/** 단품코드 */
	private String skuCd;
	
	/** 상점주문번호 */
	private String shopOrdrNo;
	
	/** 상점주문순번 */
	private String shopSortNo;

}
