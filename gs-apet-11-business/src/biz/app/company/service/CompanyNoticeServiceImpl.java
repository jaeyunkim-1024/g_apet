package biz.app.company.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import biz.app.company.dao.CompanyNoticeDao;
import biz.app.company.model.CompanyNoticePO;
import biz.app.company.model.CompanyNoticeSO;
import biz.app.company.model.CompanyNoticeVO;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;

/**
 * <pre>
 * - 프로젝트명	: 11.business
 * - 패키지명		: biz.app.member.service
 * - 파일명		: CompanyNoticeServiceImpl.java
 * - 작성자		: valueFactory
 * - 설명		: 업체 공지 Service Implement
 * </pre>
 */
@Service
@Transactional
public class CompanyNoticeServiceImpl implements CompanyNoticeService {

	@Autowired private CompanyNoticeDao companyNoticeDao;

	/**
	 * <pre>업체 공지사항 목록 조회</pre>
	 * 
	 * @author valueFactory
	 * @param so CompanyNoticeSO
	 * @return
	 */
	@Override
	public List<CompanyNoticeVO> listCompanyNotice(CompanyNoticeSO so) {
		return this.companyNoticeDao.listCompanyNotice(so);
	}

	
	/**
	 * <pre>업체 공지사항 페이지 목록 조회</pre>
	 * 
	 * @author valueFactory
	 * @param so CompanyNoticeSO
	 * @return 
	 */
	@Override
	public List<CompanyNoticeVO> pageCompanyNotice(CompanyNoticeSO so) {
		return companyNoticeDao.pageCompanyNotice(so);
	}

	
	/**
	 * <pre>업체 공지사항 상세</pre>
	 * 
	 * @author valueFactory
	 * @param so CompanyNoticeSO
	 * @return 
	 */
	@Override
	public CompanyNoticeVO getCompanyNotice(CompanyNoticeSO so) {
		return companyNoticeDao.getCompanyNotice(so);
	}

	
	/**
	 * <pre>업체 공지사항 등록</pre>
	 * 
	 * @author valueFactory
	 * @param po CompanyNoticePO
	 * @return 
	 */
	@Override
	public void insertCompanyNotice(CompanyNoticePO po) {
		int result = companyNoticeDao.insertCompanyNotice(po);

		if (result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
	}

	
	/**
	 * <pre>업체 공지사항 수정</pre>
	 * 
	 * @author valueFactory
	 * @param po CompanyNoticePO
	 * @return 
	 */
	@Override
	public void updateCompanyNotice(CompanyNoticePO po) {
		int result = companyNoticeDao.updateCompanyNotice(po);

		if (result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
	}

	
	/**
	 * <pre>업체 공지사항 삭제</pre>
	 * 
	 * @author valueFactory
	 * @param po CompanyNoticePO
	 * @return 
	 */
	@Override
	public void deleteListCompanyNotice(CompanyNoticePO po) {
		if (po.getArrCompNtcNo() != null && po.getArrCompNtcNo().length > 0) {
			for (Long compNtcNo : po.getArrCompNtcNo()) {
				po.setCompNtcNo(compNtcNo);
				int result = companyNoticeDao.deleteCompanyNotice(po);
				if (result == 0) {
					throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
				}
			}
		}
	}

}