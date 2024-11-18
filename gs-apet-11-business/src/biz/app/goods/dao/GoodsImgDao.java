package biz.app.goods.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import biz.app.goods.model.GoodsImgChgHistPO;
import biz.app.goods.model.GoodsImgPO;
import biz.app.goods.model.GoodsImgSO;
import biz.app.goods.model.GoodsImgVO;
import framework.common.dao.MainAbstractDao;

@Repository
public class GoodsImgDao extends MainAbstractDao {

	//private static final String BASE_DAO_PACKAGE = "goodsImg.";

	//-------------------------------------------------------------------------------------------------------------------------//
	//- Front
	//-------------------------------------------------------------------------------------------------------------------------//

	//-------------------------------------------------------------------------------------------------------------------------//
	//-
	//-------------------------------------------------------------------------------------------------------------------------//

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsDao.java
	* - 작성일		: 2016. 4. 19.
	* - 작성자		: valueFactory
	* - 설명			: 상품 이미지 등록
	* </pre>
	* @param po
	* @return
	*/
	public int insertGoodsImg (GoodsImgPO po ) {
		return insert("goodsImg.insertGoodsImg", po );
	}


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsDao.java
	* - 작성일		: 2016. 4. 19.
	* - 작성자		: valueFactory
	* - 설명			: 상품 이미지 이력 등록
	* </pre>
	* @param po
	* @return
	*/
	public int insertGoodsImgChgHist (GoodsImgChgHistPO po ) {
		return insert("goodsImg.insertGoodsImgChgHist", po );
	}


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsDao.java
	* - 작성일		: 2016. 4. 19.
	* - 작성자		: valueFactory
	* - 설명			: 상품 이미지 수정
	* </pre>
	* @param po
	* @return
	*/
	public int updateGoodsImg (GoodsImgPO po ) {
		return update("goodsImg.updateGoodsImg", po );
	}


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsDao.java
	* - 작성일		: 2017. 8. 8.
	* - 작성자		: hongjun
	* - 설명			: 상품 이미지 대표여부 일괄 변경
	* </pre>
	* @param po
	* @return
	*/
	public int updateGoodsImgDlgtYnN (GoodsImgPO po ) {
		return update("goodsImg.updateGoodsImgDlgtYnN", po );
	}


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsImgDao.java
	* - 작성일		: 2016. 5. 3.
	* - 작성자		: valueFactory
	* - 설명			: 상품 이미지 조회
	* </pre>
	* @param goodsImgSO
	* @return
	*/
	public List<GoodsImgVO> listGoodsImg (GoodsImgSO goodsImgSO) {
		return selectList("goodsImg.listGoodsImg", goodsImgSO);
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsImgDao.java
	* - 작성일		: 2016. 5. 13.
	* - 작성자		: valueFactory
	* - 설명			: 상품 이미지 삭제
	* </pre>
	* @param po
	* @return
	*/
	public int deleteGoodsImg (GoodsImgPO po ) {
		return update("goodsImg.deleteGoodsImg", po );
	}


	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsImgDao.java
	 * - 작성일		: 2021. 4. 23.
	 * - 작성자		: valueFactory
	 * - 설명		: 상품 이미지 삭제
	 * </pre>
	 * @param goodsId
	 * @param imgSeqs
	 * @return
	 */
	public int deleteGoodsImgBySeq (String goodsId, List<Integer> imgSeqs) {
		Map<String, Object> params = new HashMap();
		params.put("goodsId", goodsId);
		params.put("imgSeqs", imgSeqs);
		return update("goodsImg.deleteGoodsImgBySeq", params );
	}


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsImgDao.java
	* - 작성일		: 2016. 5. 16.
	* - 작성자		: valueFactory
	* - 설명			: 상품 이미지 조회
	* </pre>
	* @param goodsId
	* @return
	*/
	public List<GoodsImgVO> listGoodsImaAll (String goodsId ) {
		return selectList("goodsImg.listGoodsImaAll", goodsId );
	}


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsImgDao.java
	* - 작성일		: 2016. 6. 28.
	* - 작성자		: valueFactory
	* - 설명			: 상품 이미지 조회
	* </pre>
	* @param so
	* @return
	*/
	public GoodsImgVO getGoodsImage (GoodsImgSO so ) {
		return (GoodsImgVO) selectOne("goodsImg.getGoodsImage", so );
	}

	public GoodsImgVO getGoodsMainImg (String goodsId) {
		return (GoodsImgVO) selectOne("goodsImg.getGoodsMainImg", goodsId );
	}
}
