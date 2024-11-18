package biz.app.system.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import biz.app.system.model.CodeDetailPO;
import biz.app.system.model.CodeDetailSO;
import biz.app.system.model.CodeDetailVO;
import biz.app.system.model.CodeGroupPO;
import biz.app.system.model.CodeGroupSO;
import biz.app.system.model.CodeGroupVO;
import framework.common.dao.MainAbstractDao;

@Repository
public class CodeDao extends MainAbstractDao {

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: CodeDao.java
	 * - 작성일		: 2016. 3. 11.
	 * - 작성자		: valueFactory
	 * - 설명		: 그룹 코드 페이지 리스트
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<CodeGroupVO> pageCodeGroup(CodeGroupSO so) {
		return selectListPage("code.pageCodeGroup", so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: CodeDao.java
	 * - 작성일		: 2016. 3. 11.
	 * - 작성자		: valueFactory
	 * - 설명		: 그룹 코드 상세
	 * </pre>
	 * @param so
	 * @return
	 */
	public CodeGroupVO getCodeGroup(CodeGroupSO so) {
		return (CodeGroupVO) selectOne("code.getCodeGroup", so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: CodeDao.java
	 * - 작성일		: 2016. 3. 11.
	 * - 작성자		: valueFactory
	 * - 설명		: 그룹 코드 등록
	 * </pre>
	 * @param po
	 * @return
	 */
	public int insertCodeGroup(CodeGroupPO po) {
		return insert("code.insertCodeGroup", po);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: CodeDao.java
	 * - 작성일		: 2016. 3. 11.
	 * - 작성자		: valueFactory
	 * - 설명		: 그룹 코드 수정
	 * </pre>
	 * @param po
	 * @return
	 */
	public int updateCodeGroup(CodeGroupPO po) {
		return update("code.updateCodeGroup", po);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: CodeDao.java
	 * - 작성일		: 2016. 3. 11.
	 * - 작성자		: valueFactory
	 * - 설명		: 그룹 코드 삭제
	 * </pre>
	 * @param po
	 * @return
	 */
	public int deleteCodeGroup(CodeGroupPO po) {
		return update("code.deleteCodeGroup", po);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: CodeDao.java
	 * - 작성일		: 2016. 3. 11.
	 * - 작성자		: valueFactory
	 * - 설명		: 상세 코드 페이지 리스트
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<CodeDetailVO> pageCodeDetail(CodeDetailSO so) {
		return selectListPage("code.pageCodeDetail", so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: CodeDao.java
	 * - 작성일		: 2016. 3. 11.
	 * - 작성자		: tigerfive
	 * - 설명		: 상세 코드 페이지 리스트(API용)
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<biz.app.system.model.interfaces.CodeDetailVO> pageCodeDetailInterface(biz.app.system.model.interfaces.CodeDetailSO so) {
		return selectList("code.pageCodeDetailInterface", so);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: CodeDao.java
	 * - 작성일		: 2016. 3. 11.
	 * - 작성자		: valueFactory
	 * - 설명		: 상세 코드 상세
	 * </pre>
	 * @param so
	 * @return
	 */
	public CodeDetailVO getCodeDetail(CodeDetailSO so) {
		return (CodeDetailVO) selectOne("code.getCodeDetail", so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: CodeDao.java
	 * - 작성일		: 2016. 3. 11.
	 * - 작성자		: valueFactory
	 * - 설명		: 상세 코드 등록
	 * </pre>
	 * @param po
	 * @return
	 */
	public int insertCodeDetail(CodeDetailPO po) {
		return insert("code.insertCodeDetail", po);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: CodeDao.java
	 * - 작성일		: 2016. 3. 11.
	 * - 작성자		: valueFactory
	 * - 설명		: 상세 코드 수정
	 * </pre>
	 * @param po
	 * @return
	 */
	public int updateCodeDetail(CodeDetailPO po) {
		return update("code.updateCodeDetail", po);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: CodeDao.java
	 * - 작성일		: 2016. 3. 11.
	 * - 작성자		: valueFactory
	 * - 설명		: 상세 코드 삭제
	 * </pre>
	 * @param po
	 * @return
	 */
	public int deleteCodeDetail(CodeDetailPO po) {
		return update("code.deleteCodeDetail", po);
	}

	public List<CodeGroupVO> createAutoSearchKeyWord(CodeGroupSO so) {
		return selectList("code.createAutoSearchKeyWord",so);
	}
}
