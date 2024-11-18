package biz.app.search.model;

import java.util.List;

import biz.app.brand.model.BrandBaseSearchVO;
import biz.app.goods.model.GoodsFiltGrpSearchVO;
import lombok.Data;

@Data
public class IBricksResultVO {
	
	/** 총 반환 카운트 */
	private Long totalCount;
	
	/** 시리즈 카운트 */
	private Long seriesCount;
	
	/** 동영상 카운트 */
	private Long videoCount;
	
	/** 사용자 카운트 */
	private Long memberCount;
	
	/** 로그 동영상 카운트 */
	private Long contentCount;
	
	/** 브랜드 카운트 */
	private Long brandCount;
	
	/** 상품 카운트 */
	private Long goodsCount;
	
	/** 변경된 키워드 */
	private String spellerKeyword;
	
	/** TV-시리즈 */
	private List<TvSeriesVO> seriesList;
	
	/** TV-동영상 */
	private List<TvVideoVO> videoList;
	
	/** LOG - 펫로그 사용자 */
	private List<LogMemberVO> memberList;
	
	/** LOG - 펫로그 동영상 */
	private List<LogContentVO> contentList;
	
	/** SHOP - 브랜드 */
	private List<ShopBrandVO> brandList;
	
	/** SHOP - 상품 */
	private List<ShopDbGoodsVO> goodsList;
	
	/** SHOP - 필터리스트 */
	private List<GoodsFiltGrpSearchVO> filterList;

	/** SHOP - 필터브랜드리스트 */
	private List<BrandBaseSearchVO> filterBrandList;
}
