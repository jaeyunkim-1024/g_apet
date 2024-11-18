package biz.app.company.service;

import java.util.List;

import biz.app.company.model.CompanyNoticePO;
import biz.app.company.model.CompanyNoticeSO;
import biz.app.company.model.CompanyNoticeVO;


/**
 * <pre>
 * - 프로젝트명	: 11.business
 * - 패키지명		: biz.app.company.service
 * - 파일명		: CompanyNoticeService.java
 * - 작성자		: valueFactory
 * - 설명		: 업체 공지 Service
 * </pre>
 */
public interface CompanyNoticeService {
	
	/**
	 * <pre>업체 공지사항 목록 조회</pre>
	 * 
	 * @author valueFactory
	 * @param so CompanyNoticeSO
	 * @return 
	 */
	public List<CompanyNoticeVO> listCompanyNotice(CompanyNoticeSO so);

	
	/**
	 * <pre>업체 공지사항 페이지 목록 조회</pre>
	 * 
	 * @author valueFactory
	 * @param so CompanyNoticeSO
	 * @return 
	 */
	public List<CompanyNoticeVO> pageCompanyNotice(CompanyNoticeSO so);

	
	/**
	 * <pre>업체 공지사항 상세</pre>
	 * 
	 * @author valueFactory
	 * @param so CompanyNoticeSO
	 * @return 
	 */
	public CompanyNoticeVO getCompanyNotice(CompanyNoticeSO so);

	
	/**
	 * <pre>업체 공지사항 등록</pre>
	 * 
	 * @author valueFactory
	 * @param po CompanyNoticePO
	 * @return 
	 */
	public void insertCompanyNotice(CompanyNoticePO po);

	
	/**
	 * <pre>업체 공지사항 수정</pre>
	 * 
	 * @author valueFactory
	 * @param po CompanyNoticePO
	 * @return 
	 */
	public void updateCompanyNotice(CompanyNoticePO po);

	
	/**
	 * <pre>업체 공지사항 삭제</pre>
	 * 
	 * @author valueFactory
	 * @param po CompanyNoticePO
	 * @return 
	 */
	public void deleteListCompanyNotice(CompanyNoticePO po);

}