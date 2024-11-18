package biz.app.goods.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import biz.app.goods.model.GoodsCautionPO;
import biz.app.goods.model.GoodsCautionSO;
import biz.app.goods.model.GoodsCautionVO;
import framework.common.dao.MainAbstractDao;



/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.goods.dao
* - 파일명		: GoodsCautionDao.java
* - 작성일		: 2016. 3. 3.
* - 작성자		: snw
* - 설명		: 상품 주의사항 DAO
* </pre>
*/
@Repository
public class GoodsCautionDao extends MainAbstractDao {

	private static final String BASE_DAO_PACKAGE = "goodsCaution.";

	//-------------------------------------------------------------------------------------------------------------------------//
	//- Front
	//-------------------------------------------------------------------------------------------------------------------------//

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsCautionDao.java
	* - 작성일		: 2016. 3. 3.
	* - 작성자		: snw
	* - 설명		: 상품 주의사항 목록 조회
	* </pre>
	* @param so
	* @return
	*/
	public List<GoodsCautionVO> listGoodsCaution(GoodsCautionSO so){
		return this.selectList(BASE_DAO_PACKAGE + "listGoodsCaution", so);
	}

	//-------------------------------------------------------------------------------------------------------------------------//
	//- Admin
	//-------------------------------------------------------------------------------------------------------------------------//


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsCautionDao.java
	* - 작성일		: 2016. 6. 14.
	* - 작성자		: valueFactory
	* - 설명			: 상품 주의사항 조회
	* </pre>
	* @param goodsId
	* @return
	*/
	public GoodsCautionVO getGoodsCaution (String goodsId ) {
		return (GoodsCautionVO)selectOne("goodsCaution.getGoodsCaution", goodsId );
	}


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsCautionDao.java
	* - 작성일		: 2016. 6. 14.
	* - 작성자		: valueFactory
	* - 설명			: 상품 주의사항 등록
	* </pre>
	* @param po
	* @return
	*/
	public int insertGoodsCaution (GoodsCautionPO po ) {
		return insert("goodsCaution.insertGoodsCaution", po );
	}


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsCautionDao.java
	* - 작성일		: 2016. 6. 14.
	* - 작성자		: valueFactory
	* - 설명			: 상품 주의사항 전시여부 처리
	* </pre>
	* @param goodsId
	* @return
	*/
	public int updateGoodsCationDispYn (GoodsCautionPO po ) {
		return update("goodsCaution.updateGoodsCationDispYn", po );
	}


}
