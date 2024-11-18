package biz.common.dao;

import java.util.List;

import biz.app.system.model.CodeDetailVO;
import org.springframework.stereotype.Repository;

import biz.app.system.model.CodeGroupVO;
import biz.common.model.AttachFilePO;
import biz.common.model.AttachFileSO;
import biz.common.model.AttachFileVO;
import framework.common.dao.MainAbstractDao;


/**
 * <pre>
 * - 프로젝트명	: 11.business
 * - 패키지명	: biz.common.dao
 * - 파일명		: BizDao.java
 * - 작성일		: 2016. 3. 3.
 * - 작성자		: snw
 * - 설명		: 비지니스 DAO
 * </pre>
 */
@Repository
public class BizDao extends MainAbstractDao {

	private static final String BASE_DAO_PACKAGE = "bizCommon.";

	public List<CodeGroupVO> listCodeAll(){
		return selectList(BASE_DAO_PACKAGE + "listCodeAll");
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BizDao.java
	* - 작성일		: 2016. 4. 11.
	* - 작성자		: valueFactory
	* - 설명			: get Sequence
	* </pre>
	* @param sequence
	* @return
	*/
	public Long getSequence (String sequence ) {
		return selectOne("bizCommon.getSequence", sequence );
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: BizDao.java
	 * - 작성일		: 2016. 5. 16.
	 * - 작성자		: valueFactory
	 * - 설명		: 파일 목록
	 * </pre>
	 * @param po
	 * @return
	 */
	public List<AttachFileVO> listAttachFile(AttachFileSO so) {
		return selectList("bizCommon.listAttachFile", so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: BizDao.java
	 * - 작성일		: 2016. 5. 16.
	 * - 작성자		: valueFactory
	 * - 설명		: 파일 등록
	 * </pre>
	 * @param po
	 * @return
	 */
	public int insertAttachFile(AttachFilePO po) {
		return insert("bizCommon.insertAttachFile", po);
	}

	public int deleteAttachFile(AttachFilePO po) {
		return update("bizCommon.deleteAttachFile", po);
	}

	/** 관심태그 공통코드에 없는 건 삭제 */
	public int initInterestTag() {return delete_batch("bizCommon.initInterestTag",null);}
}
