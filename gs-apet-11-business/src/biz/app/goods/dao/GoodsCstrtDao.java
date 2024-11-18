package biz.app.goods.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import biz.app.goods.model.GoodsCstrtHistPO;
import biz.app.goods.model.GoodsCstrtInfoPO;
import biz.app.goods.model.GoodsCstrtInfoSO;
import biz.app.goods.model.GoodsCstrtInfoVO;
import biz.app.st.model.StStdInfoVO;
import framework.common.dao.MainAbstractDao;

@Repository
public class GoodsCstrtDao extends MainAbstractDao {

	private static final String BASE_DAO_PACKAGE = "goodsCstrt.";

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
	* - 작성일		: 2016. 4. 21.
	* - 작성자		: valueFactory
	* - 설명			: 상품 구성품 등록
	* </pre>
	* @param po
	* @return
	*/
	public int insertGoodsCstrtInfo (GoodsCstrtInfoPO po ) {
		return insert(BASE_DAO_PACKAGE + "insertGoodsCstrtInfo", po );
	}


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsDao.java
	* - 작성일		: 2016. 4. 21.
	* - 작성자		: valueFactory
	* - 설명			: 상품 구성품 삭제
	* </pre>
	* @param goodsId
	* @return
	*/
	public int deleteGoodsCstrtInfo (String goodsId ) {
		return delete(BASE_DAO_PACKAGE + "deleteGoodsCstrtInfo", goodsId );
	}


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsCstrtDao.java
	* - 작성일		: 2016. 5. 3.
	* - 작성자		: valueFactory
	* - 설명			: 상품 구성품 조회
	* </pre>
	* @param goodsCstrtInfoSO
	* @return
	*/
	public List<GoodsCstrtInfoVO> listGoodsCstrtInfo (GoodsCstrtInfoSO goodsCstrtInfoSO ) {
		return selectList(BASE_DAO_PACKAGE + "listGoodsCstrtInfo", goodsCstrtInfoSO );
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsCstrtDao.java
	 * - 작성일		: 2016. 9. 05.
	 * - 작성자		: hjko
	 * - 설명		: 딜상품과 매핑된 사이트 정보 전체를 조회한다.
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<StStdInfoVO> listStStdInfoByDealGoods(GoodsCstrtInfoSO goodsCstrtInfoSO) {
		
		return selectList("inline.getStStdInfoGoodsById", goodsCstrtInfoSO);
	}
	
	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsCstrtDao.java
	* - 작성일	: 2021. 2. 17.
	* - 작성자 	: valfac
	* - 설명 		: 상품 구성 히스토리 등록
	* </pre>
	*
	* @param po
	* @return
	*/
	public int insertGoodsCstrtHist (GoodsCstrtHistPO po ) {
		return insert(BASE_DAO_PACKAGE + "insertGoodsCstrtHist", po );
	}
}