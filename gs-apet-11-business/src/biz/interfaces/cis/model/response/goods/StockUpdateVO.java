package biz.interfaces.cis.model.response.goods;

import framework.cis.model.response.shop.GoodsResponse;
import lombok.Data;

/**
 * <pre>
 * - 프로젝트명 : business
 * - 패키지명   : biz.interfaces.cis.model.response.goods
 * - 파일명     : StockUpdateVO.java
 * - 작성일     : 2021. 02. 01.
 * - 작성자     : lhj01
 * - 설명       :
 * </pre>
 */

public class StockUpdateVO extends GoodsResponse<StockUpdateVO.Stock> {

	@Data
	public static class Stock {
		private int skuNo;          //단품 번호,    CIS에서 관리하는 단품 번호
		private String skuCd;		//단품 코드,    상점에서 관리하는 단품 코드
		private int stock;          //재고
		private int stockSft;       //안전 20210430 원복
		private int stockAbl;       //재고_가용,    100
		private int stockBlk;       //재고_불량,    0
		private String expDdYmd;    //유통기한,     (YMD) 20200101

		public Stock(){}
	}
}
