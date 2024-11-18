package biz.app.contents.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import biz.app.contents.model.ApetContentsGoodsMapPO;
import biz.app.contents.model.ApetContentsGoodsMapSO;
import biz.app.contents.model.ApetContentsGoodsMapVO;
import framework.common.dao.MainAbstractDao;


/**
 * <h3>Project : 11.business</h3>
 * <pre>Apet 컨텐츠 상품 매핑 DAO</pre>
 * 
 * @author ValueFactory
 */
@Repository
public class ApetContentsGoodsMapDao extends MainAbstractDao {
	private static final String BASE_DAO_PACKAGE = "apetContentsGoodsMap.";

	/**
	 * <pre>Apet 컨텐츠 상품 매핑 등록</pre>
	 * 
	 * @author valueFactory
	 * @param ApetContentsGoodsMapPO
	 * @return int
	 */
	public int insertApetContentsGoodsMap(ApetContentsGoodsMapPO po) {
		return insert(BASE_DAO_PACKAGE + "insertApetContentsGoodsMap", po);
	}
	
	/**
	 * <pre>Apet 컨텐츠 상품 매핑 삭제</pre>
	 * 
	 * @author valueFactory
	 * @param ApetContentsGoodsMapPO
	 * @return int
	 */
	public int deleteApetContentsGoodsMap(ApetContentsGoodsMapPO po) {
		return delete(BASE_DAO_PACKAGE + "deleteApetContentsGoodsMap", po);
	}
	
	/**
	 * <pre>Apet 컨텐츠 상품 매핑 목록</pre>
	 * 
	 * @author valueFactory
	 * @param ApetContentsGoodsMapSO
	 * @return List<ApetContentsGoodsMapVO>
	 */
	public List<ApetContentsGoodsMapVO> listApetContentsGoodsMap(ApetContentsGoodsMapSO so) {
		return selectList(BASE_DAO_PACKAGE + "listApetContentsGoodsMap", so);
	}
	
	/**
	 * <pre>Apet 컨텐츠 상품 매핑 이력 등록</pre>
	 * 
	 * @author valueFactory
	 * @param ApetContentsGoodsMapPO
	 * @return int
	 */
	public int insertApetContentsGoodsMapHist(ApetContentsGoodsMapVO vo) {
		return insert(BASE_DAO_PACKAGE + "insertApetContentsGoodsMapHist", vo);
	}
}
