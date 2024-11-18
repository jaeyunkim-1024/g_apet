package biz.app.goods.dao;

import biz.app.goods.model.*;
import framework.common.dao.MainAbstractDao;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;

/**
 * FIXME[상품, 이하정, 20210113] 개별 작업용
 */
@Repository
public class GoodsBulkDao extends MainAbstractDao {

	private static final String BASE_DAO_PACKAGE = "goodsBulk.";

	//-------------------------------------------------------------------------------------------------------------------------//
	//- 어드민
	//-------------------------------------------------------------------------------------------------------------------------//
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsDao.java
	* - 작성일		: 2021. 1. 11.
	* - 작성자		: lhj01
	* - 설명			: 상품 가격 목록
	* </pre>
	* @param so
	* @return
	*/
	public List<GoodsBulkPriceVO> pageGoodsBulkPrice(GoodsBaseSO so) {
		return selectListPage(BASE_DAO_PACKAGE+"pageGoodsBulkPrice", so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsDao.java
	 * - 작성일		: 2016. 4. 29.
	 * - 작성자		: valueFactory
	 * - 설명		: 상품 수정 [일괄 변경]
	 * </pre>
	 * @param po
	 * @return
	 */
	public HashMap<String, Object> updateGoodsBatch (String goodsUpdateGb, GoodsBasePO po ) {
		HashMap<String, Object> params = new HashMap<>();
		params.put("goodsUpdateGb", goodsUpdateGb);
		params.put("goodsCstrtTpCd", "");
		params.put("cisNo", null);
		params.put("po", po);

		int updateCnt = update(BASE_DAO_PACKAGE+"updateGoodsBatch", params );
		params.put("updateCnt", updateCnt);

		return params;
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsDao.java
	 * - 작성일		: 2021. 3. 29.
	 * - 작성자		: valueFactory
	 * - 설명		: 베스트 상품 등록 [배치, 프로시저 호출]
	 * </pre>
	 * @param po
	 * @return
	 */
	public int callGoodsBestProc(String argBaseDt) {
		return insert (BASE_DAO_PACKAGE+"callGoodsBestProc", argBaseDt);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsDao.java
	 * - 작성일		: 2021. 3. 29.
	 * - 작성자		: valueFactory
	 * - 설명		: 베스트 상품 등록 [배치, 프로시저 호출]
	 * </pre>
	 * @param po
	 * @return
	 */
	public int callGoodsStatProc() {
		return insert (BASE_DAO_PACKAGE+"callGoodsStatProc");
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsDao.java
	 * - 작성일		: 2021. 5. 25.
	 * - 작성자		: valueFactory
	 * - 설명		: 상품 전체 카테고리 전시 순위 집계 등록 [배치, 프로시저 호출]
	 * </pre>
	 * @param po
	 * @return
	 */
	public int callGoodsDispAllCtgProc() {
		return insert (BASE_DAO_PACKAGE+"callGoodsDispAllCtgProc");
	}
}