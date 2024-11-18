package biz.app.goods.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import biz.app.goods.model.GoodsFiltGrpPO;
import biz.app.goods.model.GoodsFiltGrpSO;
import biz.app.goods.model.GoodsFiltGrpVO;
import framework.common.dao.MainAbstractDao;

/**
* <pre>
* - 프로젝트명	: gs-apet-11-business
* - 패키지명 	: biz.app.goods.dao
* - 파일명 	: GoodsFiltGrpDao.java
* - 작성일	: 2020. 12. 30.
* - 작성자	: valfac
* - 설명 		: 필터 그룹 DAO
* </pre>
*/
@Repository
public class GoodsFiltGrpDao extends MainAbstractDao {
	private static final String BASE_DAO_PACKAGE = "goodsFiltGrp.";

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsFiltGrpDao.java
	 * - 작성일		: 2020. 12. 17.
	 * - 작성자		: yjs01
	 * - 설명		: 상품 필터 그룹 등록
	 * </pre>
	 * @param po
	 * @return
	 */
	public int insertFiltGrp(GoodsFiltGrpPO po){
		return insert(BASE_DAO_PACKAGE + "filtGrpInsert", po );
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsFiltGrpDao.java
	 * - 작성일		: 2020. 12. 17.
	 * - 작성자		: yjs01
	 * - 설명		: 상품 필터 그룹 수정
	 * </pre>
	 * @param po
	 * @return
	 */
	public int updateFiltGrp(GoodsFiltGrpPO po){
		return update(BASE_DAO_PACKAGE + "filtGrpUpdate", po );
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsFiltGrpDao.java
	 * - 작성일		: 2020. 12. 17.
	 * - 작성자		: yjs01
	 * - 설명		: 상품 필터 그룹 삭제
	 * </pre>
	 * @param po
	 * @return
	 */
	public int deleteFiltGrp(GoodsFiltGrpPO po){
		return delete(BASE_DAO_PACKAGE + "filtGrpDelete", po );
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsFiltGrpDao.java
	 * - 작성일		: 2020. 12. 17.
	 * - 작성자		: yjs01
	 * - 설명		: 상품 필터 그룹 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<GoodsFiltGrpVO> getFiltGrpList(GoodsFiltGrpSO so){
		return selectList(BASE_DAO_PACKAGE + "getFiltGrpList", so );
	}

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsFiltGrpDao.java
	* - 작성일	: 2020. 12. 30.
	* - 작성자 	: valfac
	* - 설명 		: 
	* </pre>
	*
	* @param so
	* @return
	*/
	public GoodsFiltGrpVO getFiltGrpInfo(GoodsFiltGrpSO so){
		return selectOne(BASE_DAO_PACKAGE + "getFiltGrpInfo", so );
	}
	
	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsFiltGrpDao.java
	* - 작성일	: 2020. 12. 30.
	* - 작성자 	: valfac
	* - 설명 		: 필터 조회
	* </pre>
	*
	* @param so
	* @return
	*/
	public List<GoodsFiltGrpVO> listFilt(GoodsFiltGrpSO so) {
		return selectList(BASE_DAO_PACKAGE + "listFilt", so);
	}
}
