package biz.app.contents.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import biz.app.contents.model.ApetContentsDetailPO;
import biz.app.contents.model.ApetContentsDetailVO;
import biz.app.contents.model.EduContsSO;
import framework.common.dao.MainAbstractDao;


/**
 * <h3>Project : 11.business</h3>
 * <pre>Apet 컨텐츠 상세 DAO</pre>
 * 
 * @author ValueFactory
 */
@Repository
public class ApetContentsDetailDao extends MainAbstractDao {
	private static final String BASE_DAO_PACKAGE = "apetContentsDetail.";

	/**
	 * <pre>Apet 컨텐츠 상세 등록</pre>
	 * 
	 * @author valueFactory
	 * @param ApetContentsDetailPO
	 * @return int
	 */
	public int insertApetContentsDetail(ApetContentsDetailPO po) {
		return insert(BASE_DAO_PACKAGE + "insertApetContentsDetail", po);
	}
	
	/**
	 * <pre>Apet 컨텐츠 상세 목록</pre>
	 * 
	 * @author KKB
	 * @param  EduContsSO
	 * @return List<ApetContentsDetailPO>
	 */
	public List<ApetContentsDetailVO> getApetContentsDetail(EduContsSO so) {
		return selectList(BASE_DAO_PACKAGE + "getApetContentsDetail", so);
	}
	
	/**
	 * <pre>Apet 컨텐츠 상세 삭제</pre>
	 * 
	 * @author KKB
	 * @param  EduContsSO
	 * @return int
	 */
	public int deleteApetContentsDetail(ApetContentsDetailPO po) {
		return delete(BASE_DAO_PACKAGE + "deleteApetContentsDetail", po);
	}
	
	/**
	 * <pre>Apet 컨텐츠 상세 이력 등록</pre>
	 * 
	 * @author valueFactory
	 * @param ApetContentsDetailPO
	 * @return int
	 */
	public int insertApetContentsDetailHist(ApetContentsDetailVO vo) {
		return insert(BASE_DAO_PACKAGE + "insertApetContentsDetailHist", vo);
	}
}
