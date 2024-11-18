package biz.app.goods.dao;

import biz.app.goods.model.GoodsSkuBasePO;
import biz.app.goods.model.GoodsSkuBaseVO;
import biz.app.goods.model.SkuInfoVO;
import framework.common.dao.MainAbstractDao;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * <pre>
 * - 프로젝트명 : business
 * - 패키지명   : biz.app.goods.dao
 * - 파일명     : GoodsSkuDao.java
 * - 작성일     : 2021. 01. 26.
 * - 작성자     : lhj01
 * - 설명       :
 * </pre>
 */

@Repository
public class GoodsSkuDao extends MainAbstractDao {

	private static final String BASE_DAO_PACKAGE = "GoodsSku.";

	public int insertSkuBase(GoodsSkuBasePO po) {return insert(BASE_DAO_PACKAGE + "insertSkuBase", po);}
	public int updateSkuBase(GoodsSkuBasePO po) {return update(BASE_DAO_PACKAGE + "updateSkuBase", po);}
	public int updateSkuBaseFo(GoodsSkuBasePO po) {return update(BASE_DAO_PACKAGE + "updateSkuBaseFo", po);}
	public int mergeSkuBase(GoodsSkuBasePO po) {
		return update(BASE_DAO_PACKAGE + "mergeSkuBase", po);
	}
	public GoodsSkuBaseVO getSkuBase(GoodsSkuBasePO po) {
		return selectOne(BASE_DAO_PACKAGE + "getSkuBase", po);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsDao.java
	 * - 작성일		: 2021. 01. 22.
	 * - 작성자		:
	 * - 설명		: CIS 단품 수정 대상 목록 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<SkuInfoVO> selectStuInfoListForSend(){
		return selectList(BASE_DAO_PACKAGE + "selectStuInfoListForSend");
	}

	public int updatePhsCompNo(String goodsId, Long phsCompNo) {
		Map<String,Object> params = new HashMap<String,Object>();
		params.put("goodsId", goodsId);
		params.put("phsCompNo", phsCompNo);
		return update(BASE_DAO_PACKAGE + "updatePhsCompNo", params);
	}
}
