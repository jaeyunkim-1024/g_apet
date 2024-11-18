package biz.app.goods.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import biz.app.goods.model.GoodsDispConnerPO;
import biz.app.goods.model.GoodsDispConnerVO;
import biz.app.goods.model.GoodsDispSO;
import biz.app.goods.model.GoodsDispVO;
import biz.common.service.CacheService;
import framework.common.dao.MainAbstractDao;

/**
 * <pre>
 * - 프로젝트명 : 11.business
 * - 패키지명   : biz.app.goods.dao
 * - 파일명     : GoodsDispDao.java
 * - 작성일     : 2021. 02. 15.
 * - 작성자     : valfac
 * - 설명       : 전시코너 상품 조회
 * </pre>
 */
@Repository
public class GoodsDispDao extends MainAbstractDao {
	@Autowired private CacheService cacheService;
	
	private static final String BASE_DAO_PACKAGE = "goodsDisp.";

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsDispDao.java
	 * - 작성일		: 2021. 06. 02.
	 * - 작성자		: valueFactory
	 * - 설명		: 전시 메인 상품 목록 조회
	 * </pre>
	 * @param so
	 * @return List
	 */
	public int countGoodsMain(GoodsDispSO so) {
		return selectOne(BASE_DAO_PACKAGE + "countGoodsMain", so);
	}
	public List selectGoodsMain(GoodsDispSO so) {
		return selectList(BASE_DAO_PACKAGE + "selectGoodsMain", so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsDispDao.java
	 * - 작성일		: 2021. 02. 15.
	 * - 작성자		: valueFactory
	 * - 설명		: 타임딜 상품 조회
	 * </pre>
	 * @param so
	 * @return List
	 */
	public List selectGoodsTimeDeal(GoodsDispSO so) {
		return selectList(BASE_DAO_PACKAGE + "selectGoodsTimeDeal", so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsDispDao.java
	 * - 작성일		: 2021. 02. 15.
	 * - 작성자		: valueFactory
	 * - 설명		: 폭풍할인 상품 조회
	 * </pre>
	 * @param so
	 * @return List
	 */
	public List selectGoodsDc(GoodsDispSO so) {
		return selectList(BASE_DAO_PACKAGE + "selectGoodsDc", so);
	}
	
	
	public List selectGoodsDcCache(GoodsDispSO so) {
		return cacheService.selectGoodsDc(so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsDispDao.java
	 * - 작성일		: 2021. 02. 15.
	 * - 작성자		: valueFactory
	 * - 설명		: MD 추천 상품 조회
	 * </pre>
	 * @param so
	 * @return List
	 */
	public List selectGoodsMd(GoodsDispSO so) {
		return selectList(BASE_DAO_PACKAGE + "selectGoodsMd", so);
	}
	
	public List selectGoodsMdCache(GoodsDispSO so) {
		return cacheService.selectGoodsMd(so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsDispDao.java
	 * - 작성일		: 2021. 02. 15.
	 * - 작성자		: valueFactory
	 * - 설명		: 베스트20 상품 조회
	 * </pre>
	 * @param so
	 * @return List
	 */
	public List callGoodsBestProc(GoodsDispSO so) {
		return selectList(BASE_DAO_PACKAGE + "callGoodsBestProc", so);
	}
	
	public List selectGoodsBestDay(GoodsDispSO so) {
		return selectList(BASE_DAO_PACKAGE + "selectGoodsBestDay", so);
	}

	public List selectGoodsBestManual(GoodsDispSO so) {
		return selectList(BASE_DAO_PACKAGE + "selectGoodsBestManual", so);
	}
	
	public List selectGoodsBestManualCache(GoodsDispSO so) {
		return cacheService.selectGoodsBestManual(so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsDispDao.java
	 * - 작성일		: 2021. 02. 15.
	 * - 작성자		: valueFactory
	 * - 설명		: 펫샵 단독 상품 조회
	 * </pre>
	 * @param so
	 * @return List
	 */
	public List selectGoodsPetShop(GoodsDispSO so) {
		return selectList(BASE_DAO_PACKAGE + "selectGoodsPetShop", so);
	}

	public int countGoodsPackage(GoodsDispSO so) { return selectOne(BASE_DAO_PACKAGE + "countGoodsPackage", so); }
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsDispDao.java
	 * - 작성일		: 2021. 02. 15.
	 * - 작성자		: valueFactory
	 * - 설명		: 패키지 상품 조회
	 * </pre>
	 * @param so
	 * @return List
	 */
	public List selectGoodsPackage(GoodsDispSO so) {
		return selectList(BASE_DAO_PACKAGE + "selectGoodsPackage", so);
	}
	
	public List selectGoodsPackageCache(GoodsDispSO so) {
		return cacheService.selectGoodsPackage(so);
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명		: gs-apet-11-business
	 * - 파일명		: GoodsDispDao.java
	 * - 작성일		: 2021. 3. 11. 
	 * - 작성자		: YJU
	 * - 설명			: 자주 구매한 상품 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public int countFrequentOrderGoods(GoodsDispSO so) { return selectOne(BASE_DAO_PACKAGE + "countFrequentOrderGoods", so); }
	
	public List selectFrequentOrderGoods(GoodsDispSO so) {
		return selectList(BASE_DAO_PACKAGE + "selectFrequentOrderGoods", so);
	}
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsDispDao.java
	 * - 작성일		: 2021. 02. 22.
	 * - 작성자		: valueFactory
	 * - 설명		: 팻로그 목록 조회
	 * </pre>
	 * @param so
	 * @return List
	 */
	public List selectDispPetLog(GoodsDispSO so) {
		return selectList(BASE_DAO_PACKAGE + "selectDispPetLog", so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsDispDao.java
	 * - 작성일		: 2021. 02. 15.
	 * - 작성자		: valueFactory
	 * - 설명		: 인기있는 펫로그후기 상품 조회
	 * </pre>
	 * @param so
	 * @return List
	 */
	public List selectGoodsPetLog(GoodsDispSO so) {
		return selectList(BASE_DAO_PACKAGE + "selectGoodsPetLog", so);
	}

	public int countGoods(GoodsDispSO so) { return selectOne(BASE_DAO_PACKAGE + "countGoods", so); }

	public List selectGoods(GoodsDispSO so) {
		return selectList(BASE_DAO_PACKAGE + "selectGoods", so);
	}
	
	public List selectGoodsCache(GoodsDispSO so) {
		return cacheService.selectGoods(so);
	}
	
	public List<GoodsDispConnerVO> getGoodsNoticeBanner(GoodsDispConnerPO so) {
		return selectList(BASE_DAO_PACKAGE + "getGoodsNoticeBanner", so);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsDispDao.java
	 * - 작성일		: 2021. 02. 15.
	 * - 작성자		: valueFactory
	 * - 설명		: 카테고리별 코너아이템 상품 조회
	 * </pre>
	 * @param so
	 * @return List
	 */
	public List selectGoodsCategory(GoodsDispSO so) {
		return selectList(BASE_DAO_PACKAGE + "selectGoodsCategory", so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsDispDao.java
	 * - 작성일		: 2021. 03. 05.
	 * - 작성자		: valueFactory
	 * - 설명		: 기획전 상품 조회
	 * </pre>
	 * @param so
	 * @return List
	 */
	public List selectGoodsExhibited(GoodsDispSO so) {
		return selectList(BASE_DAO_PACKAGE + "selectGoodsExhibited", so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsDispDao.java
	 * - 작성일		: 2021. 03. 05.
	 * - 작성자		: valueFactory
	 * - 설명		: 기획전 - 사전예약 상품 조회
	 * </pre>
	 * @param so
	 * @return List
	 */
	public List selectGoodsReserved(GoodsDispSO so) {
		return selectList(BASE_DAO_PACKAGE + "selectGoodsReserved", so);
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명		: gs-apet-11-business
	 * - 파일명		: GoodsDispDao.java
	 * - 작성일		: 2021. 3. 9. 
	 * - 작성자		: YJU
	 * - 설명			: 브랜드 상품 조회(총 상품수)
	 * </pre>
	 * @param so
	 * @return
	 */
	public int countBrandGoods(GoodsDispSO so) { return selectOne(BASE_DAO_PACKAGE + "countBrandGoods", so); }
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명		: gs-apet-11-business
	 * - 파일명		: GoodsDispDao.java
	 * - 작성일		: 2021. 3. 9. 
	 * - 작성자		: YJU
	 * - 설명			: 브랜드 상품 카테고리 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public List selectGoodsCategoryBrand(GoodsDispSO so) {
		return selectList(BASE_DAO_PACKAGE + "selectGoodsCategoryBrand", so);
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명		: gs-apet-11-business
	 * - 파일명		: GoodsDispDao.java
	 * - 작성일		: 2021. 3. 9. 
	 * - 작성자		: YJU
	 * - 설명			: 브랜드 상품 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public List selectGoodsBrand(GoodsDispSO so) {
		return selectList(BASE_DAO_PACKAGE + "selectGoodsBrand", so);
	}

	/**
	 *
	 * <pre>
	 * - 프로젝트명    : gs-apet-11-business
	 * - 파일명        : GoodsDispDao.java
	 * - 작성일        : 2021. 3. 17.
	 * - 작성자        : YKU
	 * - 설명          : 기획전 상품 count조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public int selectGoodsExhibitedCount(GoodsDispSO so) {
		return selectOne(BASE_DAO_PACKAGE + "selectGoodsExhibitedCount", so); 
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명		: gs-apet-11-business
	 * - 파일명		: GoodsDispDao.java
	 * - 작성일		: 2021. 3. 9. 
	 * - 작성자		: YJU
	 * - 설명			: 신상품 조회(총 상품수)
	 * </pre>
	 * @param so
	 * @return
	 */
	public int countGoodsNew(GoodsDispSO so) { return selectOne(BASE_DAO_PACKAGE + "countGoodsNew", so); }
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명		: gs-apet-11-business
	 * - 파일명		: GoodsDispDao.java
	 * - 작성일		: 2021. 3. 9. 
	 * - 작성자		: YJU
	 * - 설명			: 신상품 카테고리 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public List selectGoodsCategoryNew(GoodsDispSO so) {
		return selectList(BASE_DAO_PACKAGE + "selectGoodsCategoryNew", so);
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명		: gs-apet-11-business
	 * - 파일명		: GoodsDispDao.java
	 * - 작성일		: 2021. 4. 27. 
	 * - 작성자		: YJU
	 * - 설명			: 신상품 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public List selectGoodsNew(GoodsDispSO so) {
		return selectList(BASE_DAO_PACKAGE + "selectGoodsNew", so);
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명		: gs-apet-11-business
	 * - 파일명		: GoodsDispDao.java
	 * - 작성일		: 2021. 3. 25. 
	 * - 작성자		: YJU
	 * - 설명			: 상품번호 별 찜여부 YN
	 * </pre>
	 * @param so
	 * @return
	 */
	public GoodsDispVO getInterestGoodsYN(GoodsDispSO so) {
		return selectOne(BASE_DAO_PACKAGE + "getInterestGoodsYN", so); 
	}

	/**
	 *
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: GoodsDispDao.java
	 * - 작성일		: 2021. 4. 13
	 * - 작성자		: valfac
	 * - 설명		: 상품 필터 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public List selectFilterGroup(List<String> goodsIds) {
		return selectList(BASE_DAO_PACKAGE + "selectFilterGroup", goodsIds);
	}
}
