package biz.app.goods.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import biz.app.brand.model.BrandBaseSO;
import biz.app.brand.model.BrandBaseVO;
import biz.app.goods.dao.FilterDao;
import biz.app.goods.model.FiltAttrMapSO;
import biz.app.goods.model.FiltAttrMapVO;


/**
* <pre>
* - 프로젝트명	: gs-apet-11-business
* - 패키지명 	: biz.app.goods.service
* - 파일명 	: FiltAttrMapServiceImpl.java
* - 작성일	: 2021. 1. 6.
* - 작성자	: valfac
* - 설명 		: 필터 매핑 서비스 impl
* </pre>
*/
@Transactional
@Service("filtService")
public class FilterServiceImpl implements FilterService {

	@Autowired private FilterDao filterDao;
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명    : gs-apet-11-business
	 * - 파일명        : DisplayServiceImpl.java
	 * - 작성일        : 2021. 3. 31.
	 * - 작성자        : YKU
	 * - 설명          : 브랜드 필터 목록
	 * </pre>
	 * @param so
	 * @return
	 */
	@Override
	public List<BrandBaseVO> filterGoodsBrand(BrandBaseSO so) {
		return filterDao.filterGoodsBrandCache(so);
	}

	/**
	 *
	 * <pre>
	 * - 프로젝트명    : gs-apet-11-business
	 * - 파일명        : DisplayServiceImpl.java
	 * - 작성일        : 2021. 3. 31.
	 * - 작성자        : YKU
	 * - 설명          : 브랜드 필터 정보 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	@Override
	public List<BrandBaseVO> getFilterGoodsBrand(BrandBaseSO so) {
		return filterDao.getFilterGoodsBrand(so);
	}

	/**
	 *
	 * <pre>
	 * - 프로젝트명    : gs-apet-11-business
	 * - 파일명        : FilterServiceImpl.java
	 * - 작성일        : 2021. 4. 1.
	 * - 작성자        : YKU
	 * - 설명          : 필터 상세조건 목록
	 * </pre>
	 * @param so
	 * @return
	 */
	@Override
	public List<FiltAttrMapVO> filterGoodsCategory(FiltAttrMapSO so) {
		return filterDao.filterGoodsCategory(so);
	}
}