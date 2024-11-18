package biz.app.search.model;

import lombok.Data;

@Data
public class ShopDbGoodsVO {
	
	/** 상품 번호 */
	private String goodsId;
	
	/** 상품 번호 */
	private String goodsNm;
	
	/** 이미지 */
	private String imgPath;	
	
	/** 브랜드 */
	private String bndNmKo;
	
	/** 판매가능상태코드 */
	private String salePsbCd;
	
	/** 찜여부 */
	private String interestYn;
	
	
	private String foSaleAmt;
	
	private String orgSaleAmt;
	
	private String icons;
	
	/** 가격 정보 */
//	private String priceInfo;
		
//	public String getFoSaleAmt() {
//		return priceInfo.split("|")[1];
//	}
//	
//	public String getOrgSaleAmt() {
//		return priceInfo.split("|")[7];
//	}
}
