package biz.app.company.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import biz.app.company.model.CompanyNoticePO;
import biz.app.company.model.CompanyNoticeSO;
import biz.app.company.model.CompanyNoticeVO;
import framework.common.dao.MainAbstractDao;

/**
 * <h3>Project : 11.business</h3>
 * 
 * <pre>
 * 업체 공지 DAO
 * </pre>
 * 
 * @author ValueFactory
 */
@Repository
public class CompanyNoticeDao extends MainAbstractDao {

	private static final String BASE_DAO_PACKAGE = "companyNotice.";

	/**
	 * <pre>업체 공지사항 목록 조회</pre>
	 * 
	 * @author valueFactory
	 * @param so CompanyNoticeSO
	 * @return 
	 */
	public List<CompanyNoticeVO> listCompanyNotice(CompanyNoticeSO so) {
		return this.selectList(BASE_DAO_PACKAGE + "listCompanyNotice", so);
	}

	
	/**
	 * <pre>업체 공지사항 페이지 목록 조회</pre>
	 * 
	 * @author valueFactory
	 * @param so CompanyNoticeSO
	 * @return 
	 */
	public List<CompanyNoticeVO> pageCompanyNotice(CompanyNoticeSO so) {
		return selectListPage(BASE_DAO_PACKAGE + "pageCompanyNotice", so);
	}

	
	/**
	 * <pre>업체 공지사항 상세</pre>
	 * 
	 * @author valueFactory
	 * @param so CompanyNoticeSO
	 * @return 
	 */
	public CompanyNoticeVO getCompanyNotice(CompanyNoticeSO so) {
		return (CompanyNoticeVO) selectOne(BASE_DAO_PACKAGE + "getCompanyNotice", so);
	}

	
	/**
	 * <pre>업체 공지사항 등록</pre>
	 * 
	 * @author valueFactory
	 * @param po CompanyNoticePO
	 * @return 
	 */
	public int insertCompanyNotice(CompanyNoticePO po) {
		return insert(BASE_DAO_PACKAGE + "insertCompanyNotice", po);
	}

	
	/**
	 * <pre>업체 공지사항 수정</pre>
	 * 
	 * @author valueFactory
	 * @param po CompanyNoticePO
	 * @return 
	 */
	public int updateCompanyNotice(CompanyNoticePO po) {
		return update(BASE_DAO_PACKAGE + "updateCompanyNotice", po);
	}

	
	/**
	 * <pre>업체 공지사항 삭제</pre>
	 * 
	 * @author valueFactory
	 * @param po CompanyNoticePO
	 * @return 
	 */
	public int deleteCompanyNotice(CompanyNoticePO po) {
		return delete(BASE_DAO_PACKAGE + "deleteCompanyNotice", po);
	}

}
