package biz.app.goods.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import biz.app.goods.model.GoodsDescHistPO;
import biz.app.goods.model.GoodsDescPO;
import biz.app.goods.model.GoodsDescSO;
import biz.app.goods.model.GoodsDescVO;
import framework.common.dao.MainAbstractDao;




/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.goods.dao
* - 파일명		: GoodsDescDao.java
* - 작성일		: 2016. 3. 3.
* - 작성자		: snw
* - 설명		: 상품 설명 DAO
* </pre>
*/
@Repository
public class GoodsDescDao extends MainAbstractDao {

	private static final String BASE_DAO_PACKAGE = "goodsDesc.";

	//-------------------------------------------------------------------------------------------------------------------------//
	//- Front
	//-------------------------------------------------------------------------------------------------------------------------//

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsDescDao.java
	* - 작성일		: 2016. 3. 3.
	* - 작성자		: snw
	* - 설명		: 상품 설명 상세 조회
	* </pre>
	* @param so
	* @return
	*/
	public GoodsDescVO getGoodsDesc(GoodsDescSO so){
		return this.selectOne(BASE_DAO_PACKAGE + "getGoodsDesc", so);
	}


	//-------------------------------------------------------------------------------------------------------------------------//
	//- 어드민
	//-------------------------------------------------------------------------------------------------------------------------//

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsDao.java
	* - 작성일		: 2016. 4. 21.
	* - 작성자		: valueFactory
	* - 설명			: 상품 상세 설명 등록
	* </pre>
	* @param po
	* @return
	*/
	public int insertGoodsDesc (GoodsDescPO po ) {
		return insert("goodsDesc.insertGoodsDesc", po );
	}


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsDao.java
	* - 작성일		: 2016. 4. 21.
	* - 작성자		: valueFactory
	* - 설명			: 상품 상세 설명 수정
	* </pre>
	* @param po
	* @return
	*/
	public int updateGoodsDesc (GoodsDescPO po ) {
		return update("goodsDesc.updateGoodsDesc", po );
	}


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsDao.java
	* - 작성일		: 2016. 4. 21.
	* - 작성자		: valueFactory
	* - 설명			: 상품 상세 설명 이력 등록
	* </pre>
	* @param po
	* @return
	*/
	public int insertGoodsDescHist (GoodsDescHistPO po ) {
		return insert("goodsDesc.insertGoodsDescHist", po );
	}


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsDescDao.java
	* - 작성일		: 2016. 5. 2.
	* - 작성자		: valueFactory
	* - 설명			: 상품 상세 설명 조회
	* </pre>
	* @param goodsId
	* @return
	*/
	public GoodsDescVO getGoodsDescAll (String goodsId ) {
		return (GoodsDescVO)selectOne("goodsDesc.getGoodsDescAll", goodsId );
	}


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsDescDao.java
	* - 작성일		: 2016. 5. 16.
	* - 작성자		: valueFactory
	* - 설명			: 상품 설명 조회
	* </pre>
	* @param goodsId
	* @return
	*/
	public List<GoodsDescVO> listGoodsDesc (String goodsId ) {
		return selectList("goodsDesc.listGoodsDesc", goodsId );
	}


}
