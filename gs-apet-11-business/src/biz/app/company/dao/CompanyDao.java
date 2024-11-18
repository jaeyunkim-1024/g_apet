package biz.app.company.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import biz.app.brand.model.BrandBaseSO;
import biz.app.brand.model.BrandBaseVO;
import biz.app.brand.model.CompanyBrandPO;
import biz.app.brand.model.CompanyBrandVO;
import biz.app.company.model.ApiPermitIpSO;
import biz.app.company.model.CompAcctPO;
import biz.app.company.model.CompAcctVO;
import biz.app.company.model.CompanyBasePO;
import biz.app.company.model.CompanyBaseVO;
import biz.app.company.model.CompanyCclPO;
import biz.app.company.model.CompanyCclVO;
import biz.app.company.model.CompanyChrgPO;
import biz.app.company.model.CompanyChrgVO;
import biz.app.company.model.CompanySO;
import biz.app.delivery.model.DeliveryChargePolicyVO;
import biz.app.display.model.DisplayCategoryPO;
import biz.app.display.model.DisplayCategoryVO;
import biz.app.goods.model.StGoodsMapPO;
import biz.app.st.model.StStdInfoPO;
import biz.app.st.model.StStdInfoVO;
import framework.common.dao.MainAbstractDao;


/**
 * <h3>Project : 11.business</h3>
 * <pre>공급업체 DAO</pre>
 * 
 * @author ValueFactory
 */
@Repository
public class CompanyDao extends MainAbstractDao {
	private static final String BASE_DAO_PACKAGE = "company.";

	/**
	 * <pre>사이트 업체 매핑 리스트</pre>
	 * 
	 * @author valueFactory
	 * @param COMP_NO
	 * @return 
	 */
	public List<StStdInfoVO> getStStdInfoById(Long compNo) {
		return selectList(BASE_DAO_PACKAGE + "getStStdInfoById", compNo);
	}

	
	/**
	 * <pre>공급 업체 목록 조회</pre>
	 * 
	 * @author valueFactory
	 * @param so CompanySO
	 * @return 
	 */
	public List<CompanyBaseVO> pageCompany(CompanySO so) {
		return selectListPage(BASE_DAO_PACKAGE + "pageCompany", so);
	}

	
	/**
	 * <pre>공급 업체 목록, 내 하위업체 포함 조회</pre>
	 * 
	 * @author valueFactory
	 * @param so CompanySO
	 * @return 
	 */
	public List<CompanyBaseVO> pageCompanyPopup(CompanySO so) {
		return selectListPage(BASE_DAO_PACKAGE + "pageCompanyPopup", so);
	}

	
	/**
	 * <pre>공급 업체 목록 조회(WMS용)</pre>
	 * 
	 * @author valueFactory
	 * @param so CompanySO
	 * @return 
	 */
	public List<CompanyBaseVO> pageCompanyWms(CompanySO so) {
		return selectListPage(BASE_DAO_PACKAGE + "pageCompanyWms", so);
	}
	
	
	/**
	 * <pre>공급 업체 기본 상세</pre>
	 * 
	 * @author valueFactory
	 * @param so CompanySO
	 * @return 
	 */
	public CompanyBaseVO getCompany(CompanySO so) {
		return (CompanyBaseVO) selectOne(BASE_DAO_PACKAGE + "getCompany", so);
	}
	
	
	/**
	 * <pre>공급 업체 기본 등록</pre>
	 * 
	 * @author valueFactory
	 * @param po CompanyBasePO
	 * @return 
	 */
	public int insertCompany(CompanyBasePO po) {
		return insert(BASE_DAO_PACKAGE + "insertCompany", po);
	}
	
	
	/**
	 * <pre>공급 업체 기본 수정</pre>
	 * 
	 * @author valueFactory
	 * @param po CompanyBasePO
	 * @return 
	 */
	public int updateCompany(CompanyBasePO po) {
		return update(BASE_DAO_PACKAGE + "updateCompany", po);
	}
	
	
	/**
	 * <pre>사이트와 공급 업체 매핑 정보 등록</pre>
	 * 
	 * @author valueFactory
	 * @param po StStdInfoPO
	 * @return 
	 */
	public int insertStCompanyMap(StStdInfoPO po) {
		return insert(BASE_DAO_PACKAGE + "insertStStdCompanyMap", po);
	}
	
	
	/**
	 * <pre>사이트와 공급 업체 매핑 정보 삭제</pre>
	 * 
	 * @author valueFactory
	 * @param po CompanyBasePO
	 * @return 
	 */
	public int deleteStCompanyMap(CompanyBasePO po) {
		return delete(BASE_DAO_PACKAGE + "deleteStStdCompanyMap", po);
	}
	
	
	/**
	 * <pre>공급 업체 정산 리스트</pre>
	 * 
	 * @author valueFactory
	 * @param so CompanySO
	 * @return 
	 */
	public List<CompanyCclVO> listCompanyCcl(CompanySO so) {
		return selectList(BASE_DAO_PACKAGE + "listCompanyCcl", so);
	}
	
	
	/**
	 * <pre>공급 업체 정산 등록</pre>
	 * 
	 * @author valueFactory
	 * @param po CompanyCclPO
	 * @return 
	 */
	public int insertCompanyCcl(CompanyCclPO po) {
		return insert(BASE_DAO_PACKAGE + "insertCompanyCcl", po);
	}
	
	
	/**
	 * <pre>공급 업체 최초 등록할 때 정산 정보 등록</pre>
	 * 
	 * @author valueFactory
	 * @param po CompanyCclPO
	 * @return 
	 */
	public int insertNewCompanyCcl(CompanyCclPO po) {
		return insert(BASE_DAO_PACKAGE + "insertNewCompanyCcl", po);
	}
	
	
	/**
	 * <pre>업체 존재 여부</pre>
	 * 
	 * @author valueFactory
	 * @param so CompanySO
	 * @return 
	 */
	public int existsCompanyCcl(CompanySO so) {
		return selectOne(BASE_DAO_PACKAGE + "existsCompanyCcl", so);
	}
	
	
	/**
	 * <pre>공급 업체 정산 수정</pre>
	 * 
	 * @author valueFactory
	 * @param po CompanyCclPO
	 * @return 
	 */
	public int updateCompanyCcl(CompanyCclPO po) {
		return update(BASE_DAO_PACKAGE + "updateCompanyCcl", po);
	}
	
	
	/**
	 * <pre>업체 배송정책 조회 [상품 등록시 사용]</pre>
	 * 
	 * @author valueFactory
	 * @param compNo
	 * @return 
	 */
	public List<DeliveryChargePolicyVO> listCompDlvrcPlc(Long compNo) {
		return selectList(BASE_DAO_PACKAGE + "listCompDlvrcPlc", compNo);
	}
	
	
	/**
	 * <pre>업체 수수료 정책 조회</pre>
	 * 
	 * @author valueFactory
	 * @param po CompanyCclPO
	 * @return 
	 */
	public CompanyCclVO getCompCcl(CompanyCclPO po) {
		return (CompanyCclVO) selectOne(BASE_DAO_PACKAGE + "getCompCcl", po);
	}
	
	
	/**
	 * <pre>전시카테고리와 공급 업체 매핑 정보 삭제</pre>
	 * 
	 * @author valueFactory
	 * @param po CompanyBasePO
	 * @return 
	 */
	public int deleteCompDispMap(CompanyBasePO po) {
		return delete(BASE_DAO_PACKAGE + "deleteCompDispMap", po);
	}
	
	
	/**
	 * <pre>전시카테고리와 공급 업체 매핑 정보 등록</pre>
	 * 
	 * @author valueFactory
	 * @param po DisplayCategoryPO
	 * @return 
	 */
	public int insertCompDispMap(DisplayCategoryPO po) {
		return insert(BASE_DAO_PACKAGE + "insertCompDispMap", po);
	}
	
	
	/**
	 * <pre>업체 전시 매핑 페이지</pre>
	 * 
	 * @author valueFactory
	 * @param so CompanySO
	 * @return 
	 */
	public List<DisplayCategoryVO> pageCompDispMap(CompanySO so) {
		return selectListPage(BASE_DAO_PACKAGE + "pageCompDispMap", so);
	}
	
	
	/**
	 * <pre>업체 전시 매핑 (API용)</pre>
	 * 
	 * @author valueFactory
	 * @param so CompanySO
	 * @return 
	 */
	public List<biz.app.display.model.interfaces.DisplayCategoryVO> pageCompDispInterface(CompanySO so) {
		return selectListPage(BASE_DAO_PACKAGE + "pageCompDispInterface", so);
	}
	
	
	/**
	 * <pre>업체 브랜드 매핑 목록 조회</pre>
	 * 
	 * @author valueFactory
	 * @param so CompanySO
	 * @return 
	 */
	public List<CompanyBrandVO> pageCompBrandMap(CompanySO so) {
		return selectListPage(BASE_DAO_PACKAGE + "pageCompBrandMap", so);
	}
	
	
	/**
	 * <pre>업체 브랜드 매핑 등록</pre>
	 * 
	 * @author valueFactory
	 * @param po CompanyBrandPO
	 * @return 
	 */
	public int insertCompanyBrand(CompanyBrandPO po) {
		return insert(BASE_DAO_PACKAGE + "insertCompanyBrand", po);
	}
	
	
	/**
	 * <pre>업체 브랜드 매핑 삭제</pre>
	 * 
	 * @author valueFactory
	 * @param po CompanyBasePO
	 * @return 
	 */
	public int deleteCompanyBrand(CompanyBasePO po) {
		return delete(BASE_DAO_PACKAGE + "deleteCompanyBrand", po);
	}
		
	
	/**
	 * <pre>상위 업체에 해당하는 사이트 목록 조회</pre>
	 * 
	 * @author valueFactory
	 * @param so CompanySO
	 * @return 
	 */
	public List<StStdInfoVO> getUpperCompStIdList(CompanySO so) {
		return selectList(BASE_DAO_PACKAGE + "getUpperCompStIdList", so);
	}
	

	/**
	 * <pre>업체 카테고리 목록 조회</pre>
	 * 
	 * @author valueFactory
	 * @param so CompanySO
	 * @return 
	 */
	public List<DisplayCategoryVO> listCompanyCategory(CompanySO so) {
		return selectList(BASE_DAO_PACKAGE + "listCompanyCategory", so);
	}

	
	/**
	 * <pre>업체 API 접근 IP 여부 조회</pre>
	 * 
	 * @author valueFactory
	 * @param so ApiPermitIpSO
	 * @return 
	 */
	public String getFlagApiPermitIp(ApiPermitIpSO so) {
		return (String) selectOne(BASE_DAO_PACKAGE + "getFlagApiPermitIp", so);
	}
	
	
	/**
	 * <pre>업체 수수료율 일괄 변경</pre>
	 * 
	 * @author valueFactory
	 * @param po StGoodsMapPO
	 * @return 
	 */
	public int companyCmsRateChg(StGoodsMapPO po) {
		return update(BASE_DAO_PACKAGE + "companyCmsRateChg", po);
	}
	

	/**
	 * <pre>상품 수수료율 일괄 변경 </pre>
	 * 
	 * @author valueFactory
	 * @param po StGoodsMapPO
	 * @return 
	 */
	public int goodsCmsRateChg(StGoodsMapPO po) {
		return update(BASE_DAO_PACKAGE + "goodsCmsRateChg", po);
	}

	
	/**
	 * <pre>업체별 API 허용 IP </pre>
	 * 
	 * @author valueFactory
	 * @param po StGoodsMapPO
	 * @return 
	 */
	public List<CompanyBaseVO> companyApiPermitIpList(CompanySO so) {
		return selectList(BASE_DAO_PACKAGE + "companyApiPermitIpList", so);
	}
	
	
	/**
	 * <pre>API 허용 IP 등록 </pre>
	 * 
	 * @author valueFactory
	 * @param po StGoodsMapPO
	 * @return 
	 */
	public int insertApiPermitIp(CompanyBasePO po) {
		return insert(BASE_DAO_PACKAGE + "insertApiPermitIp", po);
	}

	
	/**
	 * <pre>API 허용 IP 삭제 </pre>
	 * 
	 * @author valueFactory
	 * @param po StGoodsMapPO
	 * @return 
	 */
	public int deleteApiPermitIp(CompanyBasePO po) {
		return update(BASE_DAO_PACKAGE + "deleteApiPermitIp", po);
	}
	
	public int insertCompAcct(CompAcctPO po) {
		return insert(BASE_DAO_PACKAGE + "insertCompAcct", po);
	}
	
	public int insertCompanyChrg(CompanyChrgPO po) {
		return insert(BASE_DAO_PACKAGE + "insertCompanyChrg", po);
	}
	
	public int insertCompanyHist(CompanyBasePO po) {
		return insert(BASE_DAO_PACKAGE + "insertCompanyBaseHist", po);
	}
	
	public int insertCompAcctHist(CompAcctPO po) {
		return insert(BASE_DAO_PACKAGE + "insertCompAcctHist", po);
	}
	
	public List<CompAcctVO> listCompAcct(CompanySO so) {
		return selectList(BASE_DAO_PACKAGE + "listCompAcct", so);
	}
	
	public List<CompanyChrgVO> listCompanyChrg(CompanySO so) {
		return selectList(BASE_DAO_PACKAGE + "listCompanyChrg", so);
	}
	
	public int deleteCompAcct(CompanyBasePO po) {
		return delete(BASE_DAO_PACKAGE + "deleteCompAcct", po);
	}
	
	public int deleteCompanyChrg(CompanyBasePO po) {
		return delete(BASE_DAO_PACKAGE + "deleteCompanyChrg", po);
	}
	
	public List<String> listCompAcctHist(CompAcctPO po) {
		return selectList(BASE_DAO_PACKAGE + "listCompAcctHist", po);
	}
	
	public List<BrandBaseVO> listBrandBase(BrandBaseSO so) {
		return selectList(BASE_DAO_PACKAGE + "listBrandBase", so);
	}
	
	public int updateCompanyBrand(CompanyBrandPO po) {
		return update(BASE_DAO_PACKAGE + "updateCompanyBrand", po);
	}
	
	public int compNmDupCheck(CompanySO so) {
		return selectOne(BASE_DAO_PACKAGE + "compNmDupCheck", so);
	}
	
	public int deleteCompanyBaseImg(CompanyBasePO po) {
		return update(BASE_DAO_PACKAGE + "deleteCompanyBaseImg", po);
	}
	
	public int deleteCompAcctImg(CompAcctPO acctPO) {
		return update(BASE_DAO_PACKAGE + "deleteCompAcctImg", acctPO);
	}
}
