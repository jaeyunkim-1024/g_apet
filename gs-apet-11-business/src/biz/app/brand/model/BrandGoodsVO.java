package biz.app.brand.model;

import lombok.Data;
import lombok.EqualsAndHashCode;
import biz.app.goods.model.GoodsBaseVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class BrandGoodsVO extends GoodsBaseVO {

	/** UID */
	private static final long serialVersionUID = 1L;
	/** 상품아이디 */
	private String goodsId;         
	/** 브랜드번호 */
	private Long bndNo;        
	/** 브랜드상품전시구분 */
	private String bndGoodsDispGb; 
	/** 전시우선순위 */
	private Long dispPriorRank ;    
	
	
}