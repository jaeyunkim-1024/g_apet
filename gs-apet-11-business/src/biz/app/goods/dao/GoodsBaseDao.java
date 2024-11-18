package biz.app.goods.dao;

import biz.app.goods.model.GoodsTotalCountVO;
import org.springframework.stereotype.Repository;

import biz.app.goods.model.GoodsBaseHistPO;
import biz.app.goods.model.GoodsBasePO;
import biz.app.goods.model.GoodsBaseSO;
import biz.app.goods.model.GoodsBaseVO;
import biz.app.goods.model.StGoodsMapPO;
import framework.common.dao.MainAbstractDao;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.goods.dao
* - 파일명		: GoodsBaseDao.java
* - 작성일		: 2017. 1. 31.
* - 작성자		: snw
* - 설명			: 상품 기본 DAO
* </pre>
*/
@Repository
public class GoodsBaseDao extends MainAbstractDao {

	private static final String BASE_DAO_PACKAGE = "goodsBase.";

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsBaseDao.java
	* - 작성일		: 2017. 1. 31.
	* - 작성자		: snw
	* - 설명			: 상품 기본 단건 조회
	* </pre>
	* @param goodsId
	* @return
	*/
	public GoodsBaseVO getGoodsBase(GoodsBaseSO so){
		return selectOne(BASE_DAO_PACKAGE + "getGoodsBase", so);
	}

	public GoodsTotalCountVO getGoodsTotalCount(String goodsId){
		return selectOne(BASE_DAO_PACKAGE + "getGoodsTotalCount", goodsId);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsBaseDao.java
	* - 작성일		: 2017. 1. 31.
	* - 작성자		: snw
	* - 설명			: 상품 등록
	* </pre>
	* @param po
	* @return
	*/
	public int insertGoodsBase (GoodsBasePO po ) {
		return insert(BASE_DAO_PACKAGE +  "insertGoodsBase", po );
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsBaseDao.java
	 * - 작성일		: 2020. 01. 17.
	 * - 작성자		: pkt
	 * - 설명		: 상품 수정
	 * </pre>
	 * 
	 * @param po
	 * @return
	 */
	public int updateGoodsBase(GoodsBasePO po) {
		return update(BASE_DAO_PACKAGE + "updateGoodsBase", po);
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsBaseDao.java
	* - 작성일		: 2020. 01. 17.
	* - 작성자		: pkt
	* - 설명		: 상품 이력 등록
	* </pre>
	* @param po
	* @return
	*/
	public int insertGoodsBaseHist(GoodsBaseHistPO po) {
		return insert(BASE_DAO_PACKAGE + "insertGoodsBaseHist", po);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsBaseDao.java
	 * - 작성일		: 2020. 01. 17.
	 * - 작성자		: pkt
	 * - 설명		: 사이트 상품 맵핑 삭제
	 * </pre>
	 * @param po
	 * @return
	 */
	public Integer deleteStGoodsMap(StGoodsMapPO po) {
		return delete(BASE_DAO_PACKAGE + "deleteStGoodsMap", po);
	}
	
	/**
	*
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsBaseDao.java
	* - 작성일		: 2020. 01. 17.
	* - 작성자		: pkt
	* - 설명		:
	* </pre>
	* @param po
	* @return
	*/
	public Integer insertStGoodsMap(StGoodsMapPO po) {
		return insert(BASE_DAO_PACKAGE + "insertStGoodsMap", po);
	}
	
	
	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsBaseDao.java
	* - 작성일	: 2021. 2. 26.
	* - 작성자 	: valfac
	* - 설명 		: cisNo 등록
	* </pre>
	*
	* @param cisNo
	* @return
	*/
	public int updateGoodsCisNo(Integer cisNo, String goodsId) {
		GoodsBasePO cisPO = new GoodsBasePO();
		cisPO.setGoodsId(goodsId);
		cisPO.setCisNo(cisNo);
		return update(BASE_DAO_PACKAGE + "updateGoodsCisNo", cisPO);
	}
}