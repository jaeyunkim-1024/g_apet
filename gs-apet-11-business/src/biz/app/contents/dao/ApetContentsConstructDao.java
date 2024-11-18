package biz.app.contents.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import biz.app.contents.model.ApetContentsConstructPO;
import biz.app.contents.model.ApetContentsConstructVO;
import biz.app.contents.model.EduContsSO;
import framework.common.dao.MainAbstractDao;


/**
 * <h3>Project : 11.business</h3>
 * <pre>Apet 컨텐츠 구성 DAO</pre>
 * 
 * @author ValueFactory
 */
@Repository
public class ApetContentsConstructDao extends MainAbstractDao {
	private static final String BASE_DAO_PACKAGE = "apetContentsConstruct.";

	/**
	 * <pre>Apet 컨텐츠 구성 등록</pre>
	 * 
	 * @author valueFactory
	 * @param ApetContentsConstructPO
	 * @return int
	 */
	public int insertApetContentsConstruct(ApetContentsConstructPO po) {
		return insert(BASE_DAO_PACKAGE + "insertApetContentsConstruct", po);
	}
	
	/**
	 * <pre>Apet 컨텐츠 구성 목록</pre>
	 * 
	 * @author KKB
	 * @param  EduContsSO
	 * @return List<ApetContentsConstructVO>
	 */
	public List<ApetContentsConstructVO> getApetContentsConstruct(EduContsSO so) {
		return selectList(BASE_DAO_PACKAGE + "getApetContentsConstruct", so);
	}
	
	/**
	 * <pre>Apet 컨텐츠 구성 삭제</pre>
	 * 
	 * @author valueFactory
	 * @param ApetContentsConstructPO
	 * @return int
	 */
	public int deleteApetContentsConstruct(ApetContentsConstructPO po) {
		return delete(BASE_DAO_PACKAGE + "deleteApetContentsConstruct", po);
	}
	
	/**
	 * <pre>Apet 컨텐츠 구성 이력 등록</pre>
	 * 
	 * @author valueFactory
	 * @param ApetContentsConstructPO
	 * @return int
	 */
	public int insertApetContentsConstructHist(ApetContentsConstructVO vo) {
		return insert(BASE_DAO_PACKAGE + "insertApetContentsConstructHist", vo);
	}
}
