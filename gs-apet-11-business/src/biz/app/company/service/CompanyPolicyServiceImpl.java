package biz.app.company.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import biz.app.company.dao.CompanyPolicyDao;
import biz.app.company.model.CompanyPolicyPO;
import biz.app.company.model.CompanyPolicySO;
import biz.app.company.model.CompanyPolicyVO;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;

/**
 * <pre>
 * - 프로젝트명	: 11.business
 * - 패키지명		: biz.app.company.service
 * - 파일명		: CompanyPolicyService.java
 * - 작성자		: valueFactory
 * - 설명		: 업체 정책 Service Implement
 * </pre>
 */
@Service
@Transactional
public class CompanyPolicyServiceImpl implements CompanyPolicyService {

	@Autowired private CompanyPolicyDao companyPolicyDao;

	
	/**
	 * <pre>업체 정책 목록 조회</pre>
	 * 
	 * @author valueFactory
	 * @param so CompanyPolicySO
	 * @return
	 */
	@Override
	public List<CompanyPolicyVO> listCompanyPolicy(CompanyPolicySO so) {
		return companyPolicyDao.listCompanyPolicy(so);
	}

	
	/**
	 * <pre>업체 정책 페이지 목록 조회</pre>
	 * 
	 * @author valueFactory
	 * @param so CompanyPolicySO
	 * @return
	 */
	@Override
	public List<CompanyPolicyVO> pageCompanyPolicy(CompanyPolicySO so) {
		return companyPolicyDao.pageCompanyPolicy(so);
	}

	
	/**
	 * <pre>업체 정책 상세</pre>
	 * 
	 * @author valueFactory
	 * @param so CompanyPolicySO
	 * @return
	 */
	@Override
	public CompanyPolicyVO getCompanyPolicy(CompanyPolicySO so) {
		return companyPolicyDao.getCompanyPolicy(so);
	}

	
	/**
	 * <pre>업체 정책 등록</pre>
	 * 
	 * @author valueFactory
	 * @param po CompanyPolicyPO
	 * @return
	 */
	@Override
	public void insertCompanyPolicy(CompanyPolicyPO po) {
		int result = companyPolicyDao.insertCompanyPolicy(po);

		if (result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
	}

	
	/**
	 * <pre>업체 정책 수정</pre>
	 * 
	 * @author valueFactory
	 * @param po CompanyPolicyPO
	 * @return
	 */
	@Override
	public void updateCompanyPolicy(CompanyPolicyPO po) {
		int result = companyPolicyDao.updateCompanyPolicy(po);

		if (result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
	}

	
	/**
	 * <pre>업체 정책 삭제</pre>
	 * 
	 * @author valueFactory
	 * @param po CompanyPolicyPO
	 * @return
	 */
	@Override
	public void deleteListCompanyPolicy(CompanyPolicyPO po) {
		if (po.getArrCompPlcNo() != null && po.getArrCompPlcNo().length > 0) {
			for (Long compPlcNo : po.getArrCompPlcNo()) {
				po.setCompPlcNo(compPlcNo);
				int result = companyPolicyDao.deleteCompanyPolicy(po);
				if (result == 0) {
					throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
				}
			}
		}
	}

}