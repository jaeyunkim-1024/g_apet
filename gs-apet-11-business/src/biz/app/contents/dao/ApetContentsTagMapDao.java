package biz.app.contents.dao;

import org.springframework.stereotype.Repository;

import biz.app.contents.model.ApetContentsTagMapPO;
import biz.app.contents.model.ApetContentsTagMapVO;
import framework.common.dao.MainAbstractDao;


/**
 * <h3>Project : 11.business</h3>
 * <pre>Apet 컨텐츠 태그 매핑 DAO</pre>
 * 
 * @author ValueFactory
 */
@Repository
public class ApetContentsTagMapDao extends MainAbstractDao {
	private static final String BASE_DAO_PACKAGE = "apetContentsTagMap.";

	/**
	 * <pre>Apet 컨텐츠 태그 매핑 등록</pre>
	 * 
	 * @author valueFactory
	 * @param ApetContentsTagMapPO
	 * @return int
	 */
	public int insertApetContentsTagMap(ApetContentsTagMapPO po) {
		return insert(BASE_DAO_PACKAGE + "insertApetContentsTagMap", po);
	}
	
	/**
	 * <pre>Apet 컨텐츠 태그 매핑 삭제</pre>
	 * 
	 * @author valueFactory
	 * @param ApetContentsTagMapPO
	 * @return int
	 */
	public int deleteApetContentsTagMap(ApetContentsTagMapPO po) {
		return delete(BASE_DAO_PACKAGE+"deleteApetContentsTagMap", po);
	}
	
	/**
	 * <pre>Apet 컨텐츠 태그 매핑 이력 등록</pre>
	 * 
	 * @author valueFactory
	 * @param ApetContentsTagMapPO
	 * @return int
	 */
	public int insertApetContentsTagMapHist(ApetContentsTagMapVO vo) {
		return insert(BASE_DAO_PACKAGE + "insertApetContentsTagMapHist", vo);
	}
}
