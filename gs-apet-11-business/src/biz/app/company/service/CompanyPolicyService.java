package biz.app.company.service;

import java.util.List;

import biz.app.company.model.CompanyPolicyPO;
import biz.app.company.model.CompanyPolicySO;
import biz.app.company.model.CompanyPolicyVO;

/**
 * <pre>
 * - 프로젝트명	: 11.business
 * - 패키지명		: biz.app.company.service
 * - 파일명		: CompanyPolicyService.java
 * - 작성자		: valueFactory
 * - 설명		: 업체 정책 Service
 * </pre>
 */
public interface CompanyPolicyService {

	/**
	 * <pre>업체 정책 목록 조회</pre>
	 * 
	 * @author valueFactory
	 * @param so CompanyPolicySO
	 * @return
	 */
	public List<CompanyPolicyVO> listCompanyPolicy(CompanyPolicySO so);

	
	/**
	 * <pre>업체 정책 페이지 목록 조회</pre>
	 * 
	 * @author valueFactory
	 * @param so CompanyPolicySO
	 * @return
	 */
	public List<CompanyPolicyVO> pageCompanyPolicy(CompanyPolicySO so);

	
	/**
	 * <pre>업체 정책 상세</pre>
	 * 
	 * @author valueFactory
	 * @param so CompanyPolicySO
	 * @return
	 */
	public CompanyPolicyVO getCompanyPolicy(CompanyPolicySO so);

	
	/**
	 * <pre>업체 정책 등록</pre>
	 * 
	 * @author valueFactory
	 * @param po CompanyPolicyPO
	 * @return
	 */
	public void insertCompanyPolicy(CompanyPolicyPO po);

	
	/**
	 * <pre>업체 정책 수정</pre>
	 * 
	 * @author valueFactory
	 * @param po CompanyPolicyPO
	 * @return
	 */
	public void updateCompanyPolicy(CompanyPolicyPO po);

	
	/**
	 * <pre>업체 정책 삭제</pre>
	 * 
	 * @author valueFactory
	 * @param po CompanyPolicyPO
	 * @return
	 */
	public void deleteListCompanyPolicy(CompanyPolicyPO po);

}