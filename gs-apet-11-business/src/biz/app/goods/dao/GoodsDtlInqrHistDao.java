package biz.app.goods.dao;

import java.util.List;

import biz.app.goods.model.GoodsDtlInqrHistVO;
import org.springframework.stereotype.Repository;

import biz.app.goods.model.GoodsBaseVO;
import biz.app.goods.model.GoodsDtlInqrHistPO;
import biz.app.goods.model.GoodsDtlInqrHistSO;
import framework.common.dao.MainAbstractDao;

/**
* <pre>
* - 프로젝트명	: gs-apet-11-business
* - 패키지명 	: biz.app.goods.dao
* - 파일명 	: GoodsDtlInqrHistDao.java
* - 작성일	: 2021. 3. 9.
* - 작성자	: valfac
* - 설명 		: 최근 본 상품
* </pre>
*/
@Repository
public class GoodsDtlInqrHistDao extends MainAbstractDao {

	private static final String BASE_DAO_PACKAGE = "goodsDtlInqrHist.";

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsDtlInqrHistDao.java
	* - 작성일	: 2021. 3. 9.
	* - 작성자 	: valfac
	* - 설명 		: 최근 본 상품 리스트
	* </pre>
	*
	* @param so
	* @return
	*/
	public List<GoodsBaseVO> listGoodsDtlInqrHist(GoodsDtlInqrHistSO so) {
		return selectList(BASE_DAO_PACKAGE + "listGoodsDtlInqrHist", so);
	}
	
	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsDtlInqrHistDao.java
	* - 작성일	: 2021. 4. 6.
	* - 작성자 	: valfac
	* - 설명 		: 최근 본 상품 페이징
	* </pre>
	*
	* @param so
	* @return
	*/
	public List<GoodsBaseVO> pageGoodsDtlInqrHist(GoodsDtlInqrHistSO so) {
		return selectListPage(BASE_DAO_PACKAGE + "pageGoodsDtlInqrHist", so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명	: GoodsDtlInqrHistDao.java
	 * - 작성일	: 2021. 3. 9.
	 * - 작성자 	: valfac
	 * - 설명 		: 최근 본 상품 조회
	 * </pre>
	 *
	 * @param so
	 * @return
	 */
	public GoodsDtlInqrHistVO getGoodsDtlInqrHist(GoodsDtlInqrHistPO po) {
		return selectOne(BASE_DAO_PACKAGE + "getGoodsDtlInqrHist", po);
	}

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsDtlInqrHistDao.java
	* - 작성일	: 2021. 3. 9.
	* - 작성자 	: valfac
	* - 설명 		: 최근 본 상품 등록
	* </pre>
	*
	* @param po
	* @return
	*/
	public int insertGoodsDtlInqrHist(GoodsDtlInqrHistPO po) {
		return insert(BASE_DAO_PACKAGE + "insertGoodsDtlInqrHist", po);
	}

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsDtlInqrHistDao.java
	* - 작성일	: 2021. 3. 9.
	* - 작성자 	: valfac
	* - 설명 		: 최근 본 상품 리스트 삭제
	* </pre>
	*
	* @param po
	* @return
	*/
	public int deleteGoodsDtlInqrHist(GoodsDtlInqrHistPO po) {
		return delete(BASE_DAO_PACKAGE + "deleteGoodsDtlInqrHist", po);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명	: GoodsDtlInqrHistDao.java
	 * - 작성일	: 2021. 4. 9.
	 * - 작성자 	: valfac
	 * - 설명 		: 최근 본지 올래된 상품 리스트 삭제
	 * </pre>
	 *
	 * @param po
	 * @return
	 */
	public int deleteOldGoodsDtlInqrHist(GoodsDtlInqrHistPO po) {
		return delete(BASE_DAO_PACKAGE + "deleteOldGoodsDtlInqrHist", po);
	}
	
	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsDtlInqrHistDao.java
	* - 작성일	: 2021. 3. 9.
	* - 작성자 	: valfac
	* - 설명 		: 최근 본 상품 수정
	* </pre>
	*
	* @param po
	* @return
	*/
	public int updateGoodsDtlInqrHist(GoodsDtlInqrHistPO po) {
		return update(BASE_DAO_PACKAGE + "updateGoodsDtlInqrHist", po);
	}
}
