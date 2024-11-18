package biz.app.goods.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import biz.app.brand.model.BrandBaseSO;
import biz.app.brand.model.BrandBaseVO;
import biz.app.goods.model.FiltAttrMapSO;
import biz.app.goods.model.FiltAttrMapVO;
import biz.common.service.CacheService;
import framework.common.dao.MainAbstractDao;

/**
* <pre>
* - 프로젝트명	: gs-apet-11-business
* - 패키지명 	: biz.app.goods.dao
* - 파일명 	: FiltAttrMapDao.java
* - 작성일	: 2020. 12. 29.
* - 작성자	: valfac
* - 설명 		: 필터 속성 매핑
* </pre>
*/
@Repository
public class FilterDao extends MainAbstractDao {
	@Autowired private CacheService cacheService;

	private static final String BASE_DAO_PACKAGE = "filter.";
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명    : gs-apet-11-business
	 * - 파일명        : DisplayDao.java
	 * - 작성일        : 2021. 3. 31.
	 * - 작성자        : YKU
	 * - 설명          : 브랜드 필터 목록
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<BrandBaseVO> filterGoodsBrand(BrandBaseSO so) {
		return selectList(BASE_DAO_PACKAGE + "filterGoodsBrand", so);
	}
	
	public List<BrandBaseVO> filterGoodsBrandCache(BrandBaseSO so) {
		return cacheService.filterGoodsBrand(so);
	}

	/**
	 *
	 * <pre>	 * - 프로젝트명    : gs-apet-11-business
	 * - 파일명        : DisplayDao.java
	 * - 작성일        : 2021. 3. 31.
	 * - 작성자        : YKU
	 * - 설명          : 브랜드 필터 정보 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<BrandBaseVO> getFilterGoodsBrand(BrandBaseSO so) {
		return selectList(BASE_DAO_PACKAGE + "getFilterGoodsBrand", so);
	}

	/**
	 *
	 * <pre>
	 * - 프로젝트명    : gs-apet-11-business
	 * - 파일명        : GoodsDispDao.java
	 * - 작성일        : 2021. 3. 23.
	 * - 작성자        : YKU
	 * - 설명          : 필터 상세조건 목록
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<FiltAttrMapVO> filterGoodsCategory(FiltAttrMapSO so) {
		return selectList(BASE_DAO_PACKAGE + "filterGoodsCategory", so);
	}
}
