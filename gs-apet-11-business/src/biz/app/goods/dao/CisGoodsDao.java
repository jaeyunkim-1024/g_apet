package biz.app.goods.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import biz.app.goods.model.SkuInfoSO;
import biz.app.goods.model.SkuInfoVO;
import biz.app.statistics.model.GoodsSO;
import framework.common.dao.MainAbstractDao;

/**
* <pre>
* - 프로젝트명	: gs-apet-11-business
* - 패키지명 	: biz.app.goods.dao
* - 파일명 	: CisGoodsDao.java
* - 작성일	: 2021. 2. 18.
* - 작성자	: valfac
* - 설명 		: CIS GOODS DAO
* </pre>
*/
@Repository
public class CisGoodsDao extends MainAbstractDao {

	private static final String BASE_DAO_PACKAGE = "cisGoods.";
	
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
	public List<SkuInfoVO> selectStuInfoListForSend(SkuInfoSO so){
		return selectList(BASE_DAO_PACKAGE + "selectStuInfoListForSend" , so);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsDao.java
	 * - 작성일		: 2021. 09. 23.
	 * - 작성자		:
	 * - 설명		: 상품 일괄 등록 CIS용 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public SkuInfoVO getInfoForBulkCisSend(GoodsSO so){
		return selectOne(BASE_DAO_PACKAGE + "getInfoForBulkCisSend" , so);
	}
	
	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: CisGoodsDao.java
	* - 작성일	: 2021. 2. 18.
	* - 작성자 	: valfac
	* - 설명 		: CIS 상품 연동 목록 조회
	* </pre>
	*
	* @param so
	* @return
	*/
	public List<SkuInfoVO> selectPrdtInfoListForSend(SkuInfoSO so){
		return selectList(BASE_DAO_PACKAGE + "selectPrdtInfoListForSend" , so);
	}
	
}
