package biz.app.company.service;

import java.util.List;

import biz.app.brand.model.CompanyBrandVO;
import biz.app.company.model.ApiPermitIpSO;
import biz.app.company.model.CompAcctPO;
import biz.app.company.model.CompAcctVO;
import biz.app.company.model.CompanyBasePO;
import biz.app.company.model.CompanyBaseVO;
import biz.app.company.model.CompanyCclPO;
import biz.app.company.model.CompanyCclVO;
import biz.app.company.model.CompanyChrgVO;
import biz.app.company.model.CompanySO;
import biz.app.delivery.model.DeliveryChargePolicyPO;
import biz.app.display.model.DisplayCategoryVO;
import biz.app.goods.model.StGoodsMapPO;
import biz.app.st.model.StStdInfoVO;

/**
 * <pre>
 * - 프로젝트명	: 11.business
 * - 패키지명		: biz.app.company.service
 * - 파일명		: CompanyService.java
 * - 작성자		: valueFactory
 * - 설명		: 업체 Service
 * </pre>
 */
public interface CompanyService {

	/**
	 * <pre>업체 목록 조회</pre>
	 * 
	 * @author valueFactory
	 * @param so CompanySO
	 * @return 
	 */
	public List<CompanyBaseVO> pageCompany(CompanySO so);

	
	/**
	 * <pre>업체 목록, 내 하위업체 포함 조회</pre>
	 * 
	 * @author valueFactory
	 * @param so CompanySO
	 * @return 
	 */
	public List<CompanyBaseVO> pageCompanyPopup(CompanySO so);

	
	/**
	 * <pre>업체 목록 조회(WMS용)</pre>
	 * 
	 * @author valueFactory
	 * @param so CompanySO
	 * @return 
	 */
	public List<CompanyBaseVO> pageCompanyWms(CompanySO so);

	
	/**
	 * <pre>공급 업체 기본 상세</pre>
	 * 
	 * @author valueFactory
	 * @param so CompanySO
	 * @return 
	 */
	public CompanyBaseVO getCompany(CompanySO so);

	
	/**
	 * <pre>업체 등록 (사이트와 업체 매핑, 업체 정산, 업체 배송정책 등록 포함)</pre>
	 * 
	 * @author valueFactory
	 * @param po CompanyBasePO
	 * @return 
	 * @throws Exception 
	 */
	public void insertCompany(CompanyBasePO companyBasePO, CompanyCclPO companyCclPO, DeliveryChargePolicyPO deliveryChargePolicyPO) throws Exception;

	
	/**
	 * <pre>업체 수정</pre>
	 * 
	 * @author valueFactory
	 * @param po CompanyBasePO
	 * @return 
	 * @throws Exception 
	 */
	public void updateCompany(CompanyBasePO po) throws Exception;

	
	/**
	 * <pre>업체 정산 수수료 목록</pre>
	 * 
	 * @author valueFactory
	 * @param so CompanySO
	 * @return 
	 */
	public List<CompanyCclVO> listCompanyCcl(CompanySO so);

	
	/**
	 * <pre>업체 정산 수수료 등록</pre>
	 * 
	 * @author valueFactory
	 * @param po CompanyCclPO
	 * @return 
	 */
	public void insertCompanyCcl(CompanyCclPO po);

	
	/**
	 * <pre>업체 수수료 정책 조회</pre>
	 * 
	 * @author valueFactory
	 * @param po CompanyCclPO
	 * @return 
	 */
	public CompanyCclVO getCompCcl(CompanyCclPO po);
	
	
	/**
	 * <pre>업체 배송 정책 저장</pre>
	 * 
	 * @author valueFactory
	 * @param po DeliveryChargePolicyPO
	 * @return 
	 */
	public void saveCompanyDelivery(DeliveryChargePolicyPO po);

		
	/**
	 * <pre>업체 전시 매핑 페이지</pre>
	 * 
	 * @author valueFactory
	 * @param so CompanySO
	 * @return 
	 */
	public List<DisplayCategoryVO> pageCompDispMap(CompanySO so);

	
	/**
	 * <pre>업체 전시 매핑 (API용)</pre>
	 * 
	 * @author valueFactory
	 * @param so CompanySO
	 * @return 
	 */
	public List<biz.app.display.model.interfaces.DisplayCategoryVO> pageCompDispInterface(CompanySO so);

	
	/**
	 * <pre>업체 브랜드 매핑 목록 조회</pre>
	 * 
	 * @author valueFactory
	 * @param so CompanySO
	 * @return 
	 */
	public List<CompanyBrandVO> pageCompBrandMap(CompanySO so);

	
	/**
	 * <pre>상위 업체에 해당하는 사이트 목록 조회</pre>
	 * 
	 * @author valueFactory
	 * @param so CompanySO
	 * @return 
	 */
	public List<StStdInfoVO> getUpperCompStIdList(CompanySO so);

	
	/**
	 * <pre>업체 카테고리 목록 조회</pre>
	 * 
	 * @author valueFactory
	 * @param so CompanySO
	 * @return 
	 */
	public List<DisplayCategoryVO> listCompanyCategory(CompanySO so);

	
	/**
	 * <pre> 업체 관리 > 업체 정책 변경 관리  승인</pre>
	 * 
	 * @author valueFactory
	 * @param po DeliveryChargePolicyPO
	 * @return 
	 */
	public void updateCompanyDeliveryChargePolicy(DeliveryChargePolicyPO po);

	
	/**
	 * <pre>업체 수수료율 일괄 변경</pre>
	 * 
	 * @author valueFactory
	 * @param compNo 
	 * @param stId
	 * @param cmsRate
	 * @return 
	 */
	public int companyCmsRateChg(Long compNo, Long stId, Double cmsRate);

	
	/**
	 * <pre>상품 수수료율 일괄 변경 </pre>
	 * 
	 * @author valueFactory
	 * @param po StGoodsMapPO
	 * @return 
	 */
	public int goodsCmsRateChg(StGoodsMapPO po);

	
	/**
	 * <pre> API 허용 IP 여부 check</pre>
	 * 
	 * @author valueFactory
	 * @param so ApiPermitIpSO
	 * @return 
	 */
	public boolean checkApiPermitIp(ApiPermitIpSO so);

	
	/**
	 * <pre>API 허용 IP 등록 </pre>
	 * 
	 * @author valueFactory
	 * @param po StGoodsMapPO
	 * @return 
	 */
	public void insertApiPermitIp(Long compNo, String pmtIp);

	
	/**
	 * <pre>API 허용 IP 삭제 </pre>
	 * 
	 * @author valueFactory
	 * @param po StGoodsMapPO
	 * @return 
	 */
	public void deleteApiPermitIp(Long[] ipSeqs);

	
	/**
	 * <pre>API 허용 IP 목록 </pre>
	 * 
	 * @author valueFactory
	 * @param po StGoodsMapPO
	 * @return 
	 */
	public List<CompanyBaseVO> companyApiPermitIpList(CompanySO so);

	
	/**
	 * <pre>업체 계정으로 로그인 </pre>
	 * 
	 * @author valueFactory
	 * @param so CompanySO
	 * @return 
	 */
	public String compUserLogin(CompanySO so);
	
	public List getCisList();
	
	public List<CompAcctVO> listCompAcct(CompanySO so);
	
	public List<CompanyChrgVO> listCompanyChrg(CompanySO so);
	
	public int compNmDupCheck(CompanySO so);
	
	public void deleteImage(CompanyBasePO po, CompAcctPO acctPO);

}