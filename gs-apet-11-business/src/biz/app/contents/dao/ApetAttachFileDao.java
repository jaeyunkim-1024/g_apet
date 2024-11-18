package biz.app.contents.dao;

import org.springframework.stereotype.Repository;

import biz.app.contents.model.ApetAttachFilePO;
import biz.app.contents.model.ApetAttachFileVO;
import framework.common.dao.MainAbstractDao;
import framework.common.util.StringUtil;


/**
 * <h3>Project : 11.business</h3>
 * <pre>Apet 첨부 파일 DAO</pre>
 * 
 * @author ValueFactory
 */
@Repository
public class ApetAttachFileDao extends MainAbstractDao {
	private static final String BASE_DAO_PACKAGE = "apetAttachFile.";

	/**
	 * <pre>Apet 첨부 파일 등록</pre>
	 * 
	 * @author valueFactory
	 * @param ApetAttachFilePO
	 * @return int
	 */
	public int insertApetAttachFile(ApetAttachFilePO po) {
		po.setPhyPath(StringUtil.removeProtocol(po.getPhyPath()));
		return insert(BASE_DAO_PACKAGE + "insertApetAttachFile", po);
	}
	
	/**
	 * <pre>Apet 첨부 파일 수정</pre>
	 * 
	 * @author valueFactory
	 * @param ApetAttachFilePO
	 * @return int
	 */
	public int updateApetAttachFile(ApetAttachFilePO po) {
		po.setPhyPath(StringUtil.removeProtocol(po.getPhyPath()));
		return update(BASE_DAO_PACKAGE + "updateApetAttachFile", po);
	}

	/**
	 * <pre>Apet 첨부 파일 삭제</pre>
	 * 
	 * @author valueFactory
	 * @param ApetAttachFilePO
	 * @return int
	 */
	public int deleteApetAttatchFile(ApetAttachFilePO po) {
		return delete(BASE_DAO_PACKAGE+"deleteApetAttatchFile", po);
	}
	
	/**
	 * <pre>Apet 첨부 파일 이력 등록</pre>
	 * 
	 * @author valueFactory
	 * @param ApetAttachFilePO
	 * @return int
	 */
	public int insertApetAttachFileHist(ApetAttachFileVO vo) {
		return insert(BASE_DAO_PACKAGE + "insertApetAttachFileHist", vo);
	}
}
