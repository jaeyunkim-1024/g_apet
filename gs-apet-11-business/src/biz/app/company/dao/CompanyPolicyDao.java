package biz.app.company.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import biz.app.company.model.CompanyPolicyPO;
import biz.app.company.model.CompanyPolicySO;
import biz.app.company.model.CompanyPolicyVO;
import framework.common.dao.MainAbstractDao;

/**
 * <pre>
 * - 프로젝트명	: 11.business
 * - 패키지명		: biz.app.company.dao
 * - 파일명		: CompanyPolicyDao.java
 * - 작성자		: valueFactory
 * - 설명		: 업체 정책 DAO
 * </pre>
 */
@Repository
public class CompanyPolicyDao extends MainAbstractDao {

	private static final String BASE_DAO_PACKAGE = "companyPolicy.";

	/**
	 * <pre>업체 정책 목록 조회</pre>
	 * 
	 * @author valueFactory
	 * @param so CompanyPolicySO
	 * @return
	 */
	public List<CompanyPolicyVO> listCompanyPolicy(CompanyPolicySO so) {
		return this.selectList(BASE_DAO_PACKAGE + "listCompanyPolicy", so);
	}

	
	/**
	 * <pre>업체 정책 페이지 목록 조회</pre>
	 * 
	 * @author valueFactory
	 * @param so CompanyPolicySO
	 * @return
	 */
	public List<CompanyPolicyVO> pageCompanyPolicy(CompanyPolicySO so) {
		return selectListPage(BASE_DAO_PACKAGE + "pageCompanyPolicy", so);
	}

	
	/**
	 * <pre>업체 정책 상세</pre>
	 * 
	 * @author valueFactory
	 * @param so CompanyPolicySO
	 * @return
	 */
	public CompanyPolicyVO getCompanyPolicy(CompanyPolicySO so) {
		return selectOne(BASE_DAO_PACKAGE + "getCompanyPolicy", so);
	}

	
	/**
	 * <pre>업체 정책 등록</pre>
	 * 
	 * @author valueFactory
	 * @param po CompanyPolicyPO
	 * @return
	 */
	public int insertCompanyPolicy(CompanyPolicyPO po) {
		return insert(BASE_DAO_PACKAGE + "insertCompanyPolicy", po);
	}

	
	/**
	 * <pre>업체 정책 수정</pre>
	 * 
	 * @author valueFactory
	 * @param po CompanyPolicyPO
	 * @return
	 */
	public int updateCompanyPolicy(CompanyPolicyPO po) {
		return update(BASE_DAO_PACKAGE + "updateCompanyPolicy", po);
	}

	
	/**
	 * <pre>업체 정책 삭제</pre>
	 * 
	 * @author valueFactory
	 * @param po CompanyPolicyPO
	 * @return
	 */
	public int deleteCompanyPolicy(CompanyPolicyPO po) {
		return delete(BASE_DAO_PACKAGE + "deleteCompanyPolicy", po);
	}

}
