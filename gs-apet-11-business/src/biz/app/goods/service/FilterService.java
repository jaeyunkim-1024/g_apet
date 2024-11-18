package biz.app.goods.service;

import java.util.List;

import biz.app.brand.model.BrandBaseSO;
import biz.app.brand.model.BrandBaseVO;
import biz.app.goods.model.FiltAttrMapSO;
import biz.app.goods.model.FiltAttrMapVO;

/**
* <pre>
* - 프로젝트명	: gs-apet-11-business
* - 패키지명 	: biz.app.goods.service
* - 파일명 	: FiltAttrMapService.java
* - 작성일	: 2021. 1. 6.
* - 작성자	: valfac
* - 설명 		: 필터 속성 매핑 서비스
* </pre>
*/
public interface FilterService {

	/**
	 *
	 * <pre>
	 * - 프로젝트명    : gs-apet-11-business
	 * - 파일명        : DisplayService.java
	 * - 작성일        : 2021. 3. 31.
	 * - 작성자        : YKU
	 * - 설명          : 브랜드 필터 목록
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<BrandBaseVO> filterGoodsBrand(BrandBaseSO so);
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명    : gs-apet-11-business
	 * - 파일명        : DisplayService.java
	 * - 작성일        : 2021. 3. 31.
	 * - 작성자        : YKU
	 * - 설명          : 브랜드 필터 정보 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<BrandBaseVO> getFilterGoodsBrand(BrandBaseSO so);
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명    : gs-apet-11-business
	 * - 파일명        : GoodsDispService.java
	 * - 작성일        : 2021. 3. 23.
	 * - 작성자        : YKU
	 * - 설명          : 필터 상세조건 목록
	 * </pre>
	 * @param so
	 * @return
	 */
	List<FiltAttrMapVO> filterGoodsCategory (FiltAttrMapSO so);
	
}