package biz.app.search.model;

import framework.common.util.StringUtil;
import lombok.Data;

@Data
public class ShopGoodsVO {
	
	/** 상품 번호 */
	private String goods_id;
	
	/** 상품명 */
	private String goods_nm;	
	
	/** 가격 */
	private Long sale_amt;
	
	/** 브랜드 */
	private String bndNmKo;
	
	/** 이미지 */
	private String imgPath;	
	
	/** 품절 여부 */
	private String soldOutYn;
	
	/** 판매가 */
	private String foSaleAmt;
	
	/** 원판매가 */
	private String orgSaleAmt;
	
	public String getGoods_nm() {
		return (StringUtil.isBlank(goods_nm))?"":goods_nm.replaceAll("¶HS¶", "<span>").replaceAll("¶HE¶", "</span>");
	}
}
