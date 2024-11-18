package biz.interfaces.cis.model.response.order;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.Data;

@Data
@JsonIgnoreProperties(ignoreUnknown = true)
public class ReturnInsertItemVO{
	
	private String shopOrdrNo;		/** 상점 주문번호 */
	private String shopSortNo;		/** 상점 주문순번 */
	private String rtnsNo;			/** 반품번호 */     
	private int    itemNo;			/** 품목번호 */     

}
