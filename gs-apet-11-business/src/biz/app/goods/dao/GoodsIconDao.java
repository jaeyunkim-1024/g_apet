package biz.app.goods.dao;

import java.util.HashMap;
import java.util.List;

import biz.app.system.model.CodeDetailVO;
import org.springframework.stereotype.Repository;

import biz.app.goods.model.GoodsIconPO;
import biz.app.goods.model.GoodsIconVO;
import framework.common.dao.MainAbstractDao;

@Repository
public class GoodsIconDao extends MainAbstractDao {

	private static final String BASE_DAO_PACKAGE = "goodsIcon.";

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsIconDao.java
	 * - 작성일		: 2020. 12. 21.
	 * - 작성자		: valueFactory
	 * - 설명		: 상품 아이콘 삭제
	 * </pre>
	 * @param goodsId
	 * @return int
	 */
	public int deleteGoodsIcon (List<String> goodsIds, String usrDfn1Val, String usrDfn2Val ) {
		HashMap params = new HashMap();
		params.put("goodsIds", goodsIds);
		params.put("usrDfn1Val", usrDfn1Val);
		params.put("usrDfn2Val", usrDfn2Val);
		return delete(BASE_DAO_PACKAGE + "deleteGoodsIcon", params );
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsIconDao.java
	 * - 작성일		: 2020. 12. 21.
	 * - 작성자		: valueFactory
	 * - 설명		: 상품 아이콘 등록
	 * </pre>
	 * @param vo
	 * @return int
	 */
	public int insertGoodsIcon (GoodsIconPO po ) {
		return insert(BASE_DAO_PACKAGE + "insertGoodsIcon", po );
	}
	
	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsIconDao.java
	* - 작성일	: 2020. 12. 29.
	* - 작성자 	: valfac
	* - 설명 		: 상품 아이콘 조회
	* </pre>
	*
	* @param goodsId
	* @return
	*/
	public List<GoodsIconVO> listGoodsIcon(String goodsId) {
		return selectList(BASE_DAO_PACKAGE + "listGoodsIcon", goodsId);
	}

	public List<CodeDetailVO> listGoodsIconByGoodsId(String goodsId) {
		return selectList(BASE_DAO_PACKAGE + "listGoodsIconByGoodsId", goodsId);
	}
}
