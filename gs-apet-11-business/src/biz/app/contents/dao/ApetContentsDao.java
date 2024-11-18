package biz.app.contents.dao;

import org.springframework.stereotype.Repository;

import biz.app.contents.model.ApetContentsPO;
import biz.app.contents.model.EduContsVO;
import framework.common.dao.MainAbstractDao;


/**
 * <h3>Project : 11.business</h3>
 * <pre>apet 컨텐츠 DAO</pre>
 * 
 * @author ValueFactory
 */
@Repository
public class ApetContentsDao extends MainAbstractDao {
	private static final String BASE_DAO_PACKAGE = "apetContents.";

	/**
	 * <pre>apet 컨텐츠 등록</pre>
	 * 
	 * @author valueFactory
	 * @param ApetContentsPO
	 * @return int
	 */
	public int insertApetContents(ApetContentsPO po) {
		return insert(BASE_DAO_PACKAGE + "insertApetContents", po);
	}
	
	/**
	 * <pre>apet 컨텐츠 수정</pre>
	 * 
	 * @author valueFactory
	 * @param ApetContentsPO
	 * @return int
	 */
	public int updateApetContents(ApetContentsPO po) {
		return update(BASE_DAO_PACKAGE + "updateApetContents", po);
	}
	
	/**
	 * <pre>apet 컨텐츠 이력 등록</pre>
	 * 
	 * @author valueFactory
	 * @param ApetContentsPO
	 * @return int
	 */
	public int insertApetContentsHist(EduContsVO vo) {
		return insert(BASE_DAO_PACKAGE + "insertApetContentsHist", vo);
	}
}
