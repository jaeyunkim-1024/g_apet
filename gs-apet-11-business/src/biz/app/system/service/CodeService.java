package biz.app.system.service;

import java.util.List;
import java.util.Map;

import biz.app.system.model.CodeDetailPO;
import biz.app.system.model.CodeDetailSO;
import biz.app.system.model.CodeDetailVO;
import biz.app.system.model.CodeGroupPO;
import biz.app.system.model.CodeGroupSO;
import biz.app.system.model.CodeGroupVO;

/**
 * get업무명		:	단권
 * list업무명	:	리스트
 * page업무명	:	리스트 페이징
 * insert업무명	:	입력
 * update업무명	:	수정
 * delete업무명	:	삭제
 * save업무명	:	입력 / 수정
 */
public interface CodeService {

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: CodeService.java
	 * - 작성일		: 2016. 3. 11.
	 * - 작성자		: valueFactory
	 * - 설명		: 그룹 코드 페이지 리스트
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<CodeGroupVO> pageCodeGroup(CodeGroupSO so);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: CodeService.java
	 * - 작성일		: 2016. 3. 11.
	 * - 작성자		: valueFactory
	 * - 설명		: 그룹 코드 상세
	 * </pre>
	 * @param so
	 * @return
	 */
	public CodeGroupVO getCodeGroup(CodeGroupSO so);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: CodeService.java
	 * - 작성일		: 2016. 3. 11.
	 * - 작성자		: valueFactory
	 * - 설명		: 그룹 코드 등록
	 * </pre>
	 * @param po
	 */
	public void insertCodeGroup(CodeGroupPO po);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: CodeService.java
	 * - 작성일		: 2016. 3. 11.
	 * - 작성자		: valueFactory
	 * - 설명		: 그룹 코드 수정
	 * </pre>
	 * @param po
	 */
	public void updateCodeGroup(CodeGroupPO po);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: CodeService.java
	 * - 작성일		: 2016. 3. 11.
	 * - 작성자		: valueFactory
	 * - 설명		: 그룹 코드 삭제
	 * </pre>
	 * @param po
	 */
	public void deleteCodeGroup(CodeGroupPO po);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: CodeService.java
	 * - 작성일		: 2016. 3. 11.
	 * - 작성자		: valueFactory
	 * - 설명		: 상세 코드 페이지 리스트
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<CodeDetailVO> pageCodeDetail(CodeDetailSO so);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: CodeService.java
	 * - 작성일		: 2016. 3. 11.
	 * - 작성자		: tigerfive
	 * - 설명		: 상세 코드 페이지 리스트 (API용)
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<biz.app.system.model.interfaces.CodeDetailVO> pageCodeDetailInterface(biz.app.system.model.interfaces.CodeDetailSO so);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: CodeService.java
	 * - 작성일		: 2016. 3. 11.
	 * - 작성자		: valueFactory
	 * - 설명		: 상세 코드 상세
	 * </pre>
	 * @param so
	 * @return
	 */
	public CodeDetailVO getCodeDetail(CodeDetailSO so);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: CodeService.java
	 * - 작성일		: 2016. 3. 11.
	 * - 작성자		: valueFactory
	 * - 설명		: 상세 코드 등록
	 * </pre>
	 * @param po
	 */
	public void insertCodeDetail(CodeDetailPO po);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: CodeService.java
	 * - 작성일		: 2016. 3. 11.
	 * - 작성자		: valueFactory
	 * - 설명		: 상세 코드 수정
	 * </pre>
	 * @param po
	 */
	public void updateCodeDetail(CodeDetailPO po);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: CodeService.java
	 * - 작성일		: 2016. 3. 11.
	 * - 작성자		: valueFactory
	 * - 설명		: 상세 코드 삭제
	 * </pre>
	 * @param po
	 */
	public void deleteCodeDetail(CodeDetailPO po);

	// 코드 포매터 적용 전 : kjy - 공통 코드, 검색어 자동 완성
	public Map<String,List<String>> createAutoSearchKeyWord(CodeGroupSO so);

}