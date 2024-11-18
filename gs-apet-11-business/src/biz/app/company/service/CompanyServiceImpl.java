package biz.app.company.service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Properties;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.codehaus.jackson.JsonGenerator;
import org.codehaus.jackson.map.DeserializationConfig;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.node.ObjectNode;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.fasterxml.jackson.databind.DeserializationFeature;

import biz.app.brand.model.BrandBaseSO;
import biz.app.brand.model.BrandBaseVO;
import biz.app.brand.model.CompanyBrandPO;
import biz.app.brand.model.CompanyBrandVO;
import biz.app.brand.service.BrandService;
import biz.app.company.dao.CompanyDao;
import biz.app.company.model.ApiPermitIpSO;
import biz.app.company.model.CompAcctPO;
import biz.app.company.model.CompAcctVO;
import biz.app.company.model.CompanyBasePO;
import biz.app.company.model.CompanyBaseVO;
import biz.app.company.model.CompanyCclPO;
import biz.app.company.model.CompanyCclVO;
import biz.app.company.model.CompanyChrgPO;
import biz.app.company.model.CompanyChrgVO;
import biz.app.company.model.CompanyRequest;
import biz.app.company.model.CompanySO;
import biz.app.delivery.dao.DeliveryChargePolicyDao;
import biz.app.delivery.model.DeliveryChargePolicyPO;
import biz.app.delivery.model.DeliveryChargePolicySO;
import biz.app.display.dao.DisplayDao;
import biz.app.display.model.DisplayCategoryPO;
import biz.app.display.model.DisplayCategorySO;
import biz.app.display.model.DisplayCategoryVO;
import biz.app.goods.model.StGoodsMapPO;
import biz.app.login.dao.AdminLoginDao;
import biz.app.login.model.UserLoginHistPO;
import biz.app.st.model.StStdInfoPO;
import biz.app.st.model.StStdInfoVO;
import biz.app.system.dao.UserDao;
import biz.app.system.model.AuthorityVO;
import biz.app.system.model.UserBaseSO;
import biz.app.system.model.UserBaseVO;
import biz.common.service.BizService;
import biz.interfaces.cis.service.CisIfLogService;
import framework.admin.constants.AdminConstants;
import framework.admin.model.Session;
import framework.admin.util.AdminSessionUtil;
import framework.cis.client.ApiClient;
import framework.cis.model.request.sample.SampleRequest;
import framework.cis.model.response.ApiResponse;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.enums.CisApiSpec;
import framework.common.exception.CustomException;
import framework.common.util.CisCryptoUtil;
import framework.common.util.FileUtil;
import framework.common.util.FtpImgUtil;
import framework.common.util.NhnObjectStorageUtil;
import framework.common.util.RequestUtil;
import framework.common.util.SessionUtil;
import framework.common.util.StringUtil;
import lombok.extern.slf4j.Slf4j;

/**
 * <pre>
 * - 프로젝트명	: 11.business
 * - 패키지명		: biz.app.member.service
 * - 파일명		: CompanyServiceImpl.java
 * - 작성자		: valueFactory
 * - 설명		: 업체 Service Implement
 * </pre>
 */
@Slf4j
@Service
@Transactional
public class CompanyServiceImpl implements CompanyService {

	@Autowired private CompanyDao companyDao;
	@Autowired private DeliveryChargePolicyDao deliveryChargePolicyDao;
	
	@Autowired private UserDao userDao;
	@Autowired private AdminLoginDao adminLoginDao;
	@Autowired private HttpServletRequest request;

	@Autowired private ApiClient apiClient;
	
	@Autowired private CisIfLogService cisIfLogService;
	
	@Autowired private CisCryptoUtil CisCryptoUtil;
	
	@Autowired private BizService bizService;
	
	@Autowired private DisplayDao displayDao;
	
	@Autowired private NhnObjectStorageUtil nhnObjectStorageUtil;
	
	@Autowired private Properties bizConfig;
	
	
	/**
	 * <pre>업체 목록 조회</pre>
	 * 
	 * @author valueFactory
	 * @param so CompanySO
	 * @return
	 */
	@Override
	@Transactional(readOnly = true)
	public List<CompanyBaseVO> pageCompany(CompanySO so) {
		List<CompanyBaseVO> list = companyDao.pageCompany(so);

		if (list != null && !list.isEmpty()) {
			for (CompanyBaseVO vo : list) {
				// 사업자 번호
				vo.setBizNo(StringUtil.bizNo(vo.getBizNo()));

				// 구 우편번호
				if (StringUtil.isNotEmpty(vo.getPostNoOld()) && vo.getPostNoOld().length() == 6) {
					vo.setPostNoOld(vo.getPostNoOld().substring(0, 3) + "-" + vo.getPostNoOld().substring(3, 6));
				}
			}
		}

		return list;
	}

	
	/**
	 * <pre>업체 목록, 내 하위업체 포함 조회</pre>
	 * 
	 * @author valueFactory
	 * @param so CompanySO
	 * @return 
	 */
	@Override
	@Transactional(readOnly = true)
	public List<CompanyBaseVO> pageCompanyPopup(CompanySO so) {
		List<CompanyBaseVO> list = companyDao.pageCompanyPopup(so);

		if (list != null && !list.isEmpty()) {
			for (CompanyBaseVO vo : list) {
				// 사업자 번호
				vo.setBizNo(StringUtil.bizNo(vo.getBizNo()));

				// 구 우편번호
				if (StringUtil.isNotEmpty(vo.getPostNoOld()) && vo.getPostNoOld().length() == 6) {
					vo.setPostNoOld(vo.getPostNoOld().substring(0, 3) + "-" + vo.getPostNoOld().substring(3, 6));
				}
			}
		}

		return list;
	}

	
	/**
	 * <pre>업체 목록 조회(WMS용)</pre>
	 * 
	 * @author valueFactory
	 * @param so CompanySO
	 * @return 
	 */
	@Override
	@Transactional(readOnly = true)
	public List<CompanyBaseVO> pageCompanyWms(CompanySO so) {
		List<CompanyBaseVO> list = companyDao.pageCompanyWms(so);

		if (list != null && !list.isEmpty()) {
			for (CompanyBaseVO vo : list) {
				// 사업자 번호
				vo.setBizNo(StringUtil.bizNo(vo.getBizNo()));

				// 구 우편번호
				if (StringUtil.isNotEmpty(vo.getPostNoOld()) && vo.getPostNoOld().length() == 6) {
					vo.setPostNoOld(vo.getPostNoOld().substring(0, 3) + "-" + vo.getPostNoOld().substring(3, 6));
				}
			}
		}

		return list;
	}

	
	/**
	 * <pre>공급 업체 기본 상세</pre>
	 * 
	 * @author valueFactory
	 * @param so CompanySO
	 * @return 
	 */
	@Override
	@Transactional(readOnly = true)
	public CompanyBaseVO getCompany(CompanySO so) {
		CompanyBaseVO vo = companyDao.getCompany(so);
		if (vo != null) {
			// 사업자 번호
			vo.setBizNo(StringUtil.bizNo(vo.getBizNo()));

			// 팩스
			vo.setFax(StringUtil.phoneNumber(vo.getFax()));

			// 구 우편번호
			if (StringUtil.isNotEmpty(vo.getPostNoOld()) && vo.getPostNoOld().length() == 6) {
				vo.setPostNoOld(vo.getPostNoOld().substring(0, 3) + "-" + vo.getPostNoOld().substring(3, 6));
			}
		}
		return vo;
	}

	
	/**
	 * <pre>업체 등록 (사이트와 업체 매핑, 업체 정산, 업체 배송정책 등록 포함)</pre>
	 * 
	 * @author valueFactory
	 * @param po CompanyBasePO
	 * @return 
	 * @throws Exception 
	 */
	@Override
	public void insertCompany(CompanyBasePO companyBasePO, CompanyCclPO companyCclPO, DeliveryChargePolicyPO deliveryChargePolicyPO) throws Exception {

		Long compNo = bizService.getSequence(CommonConstants.SEQUENCE_COMPANY_BASE_SEQ);
		
		companyBasePO.setCompNo(compNo);
		
		// 사업자 번호
		if (StringUtil.isNotBlank(companyBasePO.getBizNo())) {
			companyBasePO.setBizNo(companyBasePO.getBizNo().replace("-", ""));
		}

		// 구 우편번호
		if (StringUtil.isNotBlank(companyBasePO.getPostNoOld())) {
			companyBasePO.setPostNoOld(companyBasePO.getPostNoOld().replace("-", ""));
		}

		// 팩스
		// 전화번호는 '-' 도 포함하여 등록하므로 팩스도 동일한 기준으로 수정함.
		companyBasePO.setFax(companyBasePO.getFax().replace("-", ""));

		// 주소 상세
		companyBasePO.setPrclDtlAddr(companyBasePO.getRoadDtlAddr());
		companyBasePO.setCompStatCd(AdminConstants.COMP_STAT_20);

		// cis 등록 여부
		companyBasePO.setCisRegNo(compNo.toString());
		companyBasePO.setCisRegYn(companyCisApi(companyBasePO, CisApiSpec.IF_R_INSERT_PRNT_INFO));

		FtpImgUtil ftpImgUtil = new FtpImgUtil();
		if(companyBasePO.getBizLicImgPath() != null && companyBasePO.getBizLicImgPath() != "") {
			// 사업자등록증 이미지 등록
			String bizLicImgPath = ftpImgUtil.uploadFilePath(companyBasePO.getBizLicImgPath(), CommonConstants.COMPANY_IMG_PATH + FileUtil.SEPARATOR + companyBasePO.getCompNo());
			ftpImgUtil.upload(companyBasePO.getBizLicImgPath(), bizLicImgPath);
			companyBasePO.setBizLicImgPath(bizLicImgPath);
		}
		
		if(companyBasePO.getCisRegYn() != null && companyBasePO.getCisRegYn() != "" && companyBasePO.getCisRegYn().equals("N")) {
			companyBasePO.setCisRegNo(null);
		}
		
		int result = companyDao.insertCompany(companyBasePO);
		if (result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		
		companyDao.insertCompanyHist(companyBasePO);

		// 사이트와 업체간 매핑정보 등록(현재 사이트는 하나이지만 차후)
		if (companyBasePO.getStId() != null && companyBasePO.getStId().length > 0) {
			for (Long stId : companyBasePO.getStId()) {
				StStdInfoPO stStdInfoPO = new StStdInfoPO();
				stStdInfoPO.setStId(stId);
				stStdInfoPO.setCompNo(companyBasePO.getCompNo());

				result = companyDao.insertStCompanyMap(stStdInfoPO);
				if (result == 0) {
					throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
				}
			}
		}

		// 업체 브랜드 등록
//		companyDao.deleteCompanyBrand(companyBasePO);

		/*if (companyBasePO.getCompanyBrandPOList() != null && !companyBasePO.getCompanyBrandPOList().isEmpty()) {
			for (CompanyBrandPO bndpo : companyBasePO.getCompanyBrandPOList()) {
				bndpo.setCompNo(companyBasePO.getCompNo());

				result = companyDao.insertCompanyBrand(bndpo);

				if (result == 0) {
					throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
				}
			}
		}*/
		
		// 브랜드 자동등록(위탁/자사)
		if(companyBasePO.getCompTpCd() != CommonConstants.COMP_TP_30) {
			if (companyBasePO.getStId() != null && companyBasePO.getStId().length > 0) {
				for (Long stId : companyBasePO.getStId()) {
					BrandBaseSO so = new BrandBaseSO();
					so.setStId(stId);
					List<BrandBaseVO> brandBaseVOList = companyDao.listBrandBase(so);
					for(BrandBaseVO vo : brandBaseVOList) {
						CompanyBrandPO bndpo = new CompanyBrandPO();
						bndpo.setBndNo(Long.valueOf(vo.getBndNo()));
						bndpo.setCompNo(companyBasePO.getCompNo());
						bndpo.setDlgtBndYn(CommonConstants.COMM_YN_N);
						bndpo.setSysRegrNo(companyBasePO.getSysRegrNo());
						
						result = companyDao.insertCompanyBrand(bndpo);

						if (result == 0) {
							throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
						}						
					}
				}	
			}
		}

		// 업체 수수료 등록
		if(companyBasePO.getCompTpCd() != CommonConstants.COMP_TP_30) {
			if (companyBasePO.getStId() != null && companyBasePO.getStId().length > 0) {
				for (Long stId : companyBasePO.getStId()) {
					companyCclPO.setStId(stId);
	
					CompanyCclVO cclVO = new CompanyCclVO();
					// 하위업체 등록이면
					/*if (companyBasePO.getUpCompNo() > 0L) {
						// 상위업체의 수수료 정보 조회
						companyCclPO.setCompNo(companyBasePO.getUpCompNo());
						
						cclVO = companyDao.getCompCcl(companyCclPO);
						if(cclVO != null) {
							companyCclPO.setCmsRate(cclVO.getCmsRate());
						}
						
					}*/
	
//					if(cclVO != null) {
						// 등록할 업체번호를 다시 설정해준다.
						companyCclPO.setCompNo(companyBasePO.getCompNo());
						companyCclPO.setCmsRate(0D);
						result = companyDao.insertNewCompanyCcl(companyCclPO);
	
						if (result == 0) {
							throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
						}
//					}
				}
			}
		}
		// 0. 배송비 정책 - 등록 시작
		deliveryChargePolicyPO.setCompNo(companyBasePO.getCompNo());
		if (StringUtil.isNotBlank(deliveryChargePolicyPO.getRtnExcTel())) {
			deliveryChargePolicyPO.setRtnExcTel(deliveryChargePolicyPO.getRtnExcTel().replace("-", ""));
		}

		if (StringUtil.isNotBlank(deliveryChargePolicyPO.getRtnaPostNoOld())) {
			deliveryChargePolicyPO.setRtnaPostNoOld(deliveryChargePolicyPO.getRtnaPostNoOld().replace("-", ""));
		}
		deliveryChargePolicyPO.setRtnaPrclDtlAddr(deliveryChargePolicyPO.getRtnaRoadDtlAddr());

		if (StringUtil.isNotBlank(deliveryChargePolicyPO.getRlsaPostNoOld())) {
			deliveryChargePolicyPO.setRlsaPostNoOld(deliveryChargePolicyPO.getRlsaPostNoOld().replace("-", ""));
		}
		deliveryChargePolicyPO.setRlsaPrclDtlAddr(deliveryChargePolicyPO.getRlsaRoadDtlAddr());

		// 1. 배송비 정책 - 배송비 정책 이력테이블에 등록
		if (StringUtils.equals(CommonConstants.USR_GRP_10, deliveryChargePolicyPO.getUsrGrpCd())) {
			deliveryChargePolicyPO.setCfmUsrNo(deliveryChargePolicyPO.getUsrNo());
			deliveryChargePolicyPO.setCfmYn(CommonConstants.COMM_YN_Y);
		} else {
			deliveryChargePolicyPO.setCfmYn(CommonConstants.COMM_YN_N);
		}

		result = deliveryChargePolicyDao.insertDeliveryChargePolicyHistory(deliveryChargePolicyPO);
		if (result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

		// 2. 배송비 정책 - 관리자가 등록한 배송비 정책은 자동승인이므로 배송비 정책 테이블에 등록
		if (StringUtils.equals(CommonConstants.USR_GRP_10, deliveryChargePolicyPO.getUsrGrpCd())) {
			result = deliveryChargePolicyDao.insertDeliveryChargePolicy(deliveryChargePolicyPO);
			if (result == 0) {
				throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
			}
		}

		// 공급업체에 매핑된 전시 카테고리를 모두 삭제 후 재등록
//		companyDao.deleteCompDispMap(companyBasePO);

		/*if (companyBasePO.getDisplayCategoryPOList() != null && !companyBasePO.getDisplayCategoryPOList().isEmpty()) {
			for (DisplayCategoryPO displayCategoryPO : companyBasePO.getDisplayCategoryPOList()) {
				displayCategoryPO.setCompNo(companyBasePO.getCompNo());

				result = companyDao.insertCompDispMap(displayCategoryPO);

				if (result == 0) {
					throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
				}
			}
		}*/
		
		
		// 전시 카테고리 자동등록(위탁/자사)
		if(companyBasePO.getCompTpCd() != CommonConstants.COMP_TP_30) {
			if (companyBasePO.getStId() != null && companyBasePO.getStId().length > 0) {
				for (Long stId : companyBasePO.getStId()) {
					DisplayCategorySO so = new DisplayCategorySO();
					so.setStId(stId);
					List<DisplayCategoryVO> displayCategoryVOList = displayDao.listDisplayCategoryFO(so);

					ObjectMapper mapper = new ObjectMapper().configure(DeserializationConfig.Feature.FAIL_ON_UNKNOWN_PROPERTIES, false);
					for(int intIndex = 1; intIndex < displayCategoryVOList.size(); intIndex++) {
						DisplayCategoryVO vo = displayCategoryVOList.get(intIndex);
						if(vo.getLeafYn() != null && vo.getLeafYn() != "" && vo.getLeafYn().equals("Y")) {
							String voStr = mapper.writeValueAsString(vo);
							DisplayCategoryPO displayCategoryPO = mapper.readValue(voStr, DisplayCategoryPO.class);
							displayCategoryPO.setCompNo(companyBasePO.getCompNo());
							displayCategoryPO.setSysRegrNo(companyBasePO.getSysRegrNo());
							displayCategoryPO.setSysUpdrNo(companyBasePO.getSysUpdrNo());
							
							result = companyDao.insertCompDispMap(displayCategoryPO);

							if (result == 0) {
								throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
							}
						}
					}
				}
			}
		}
		
		// 계좌
		if(companyBasePO.getCompAcctPOList() != null && !companyBasePO.getCompAcctPOList().isEmpty()) {
			for(CompAcctPO compAcctPO : companyBasePO.getCompAcctPOList()) {
				compAcctPO.setCompNo(companyBasePO.getCompNo());
				
				if(compAcctPO.getAcctImgPath() != null && compAcctPO.getAcctImgPath() != "") {
					// 계좌 이미지 등록
					String acctImgPath = ftpImgUtil.uploadFilePath(compAcctPO.getAcctImgPath(), CommonConstants.COMPANY_IMG_PATH + FileUtil.SEPARATOR + companyBasePO.getCompNo());
					ftpImgUtil.upload(compAcctPO.getAcctImgPath(), acctImgPath);
					compAcctPO.setAcctImgPath(acctImgPath);
				}
				
				result = companyDao.insertCompAcct(compAcctPO);

				if (result == 0) {
					throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
				}
				
				// 계좌 히스토리
				companyDao.insertCompAcctHist(compAcctPO);
			}
		}
		
		// 담당자
		if(companyBasePO.getCompanyChrgPOList() != null && !companyBasePO.getCompanyChrgPOList().isEmpty()) {
			for(CompanyChrgPO companyChrgPO : companyBasePO.getCompanyChrgPOList()) {
				companyChrgPO.setCompNo(companyBasePO.getCompNo());
				result = companyDao.insertCompanyChrg(companyChrgPO);

				if (result == 0) {
					throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
				}
			}
		}
	}
	
	private String companyCisApi(CompanyBasePO companyBasePO, CisApiSpec ifGb) throws Exception {
		
		//////////////// CIS 인터페이스 ////////////////
		String returnCode = "";
		String statusCd = null;
		String returnValue = CommonConstants.COMM_YN_N;

		Long cisIfLogSeq = null;
		
		ApiResponse ar = null;
		ObjectNode on = null;

		try {
			
			CompanyRequest request = new CompanyRequest();

			// 거래처 코드
			request.setPrntCd(companyBasePO.getCisRegNo());			
			// 거래처 이름
			request.setPrntNm(companyBasePO.getCompNm());
			
			// 거래처 유형
//			if(ifGb.equals(CisApiSpec.IF_R_INSERT_PRNT_INFO)) {
				if(StringUtils.equalsIgnoreCase(companyBasePO.getCompTpCd(), CommonConstants.COMP_TP_10)) {	// 자사
					request.setPrntTpCd(CommonConstants.PRNT_TP_CD_MC);
				} else if(StringUtils.equalsIgnoreCase(companyBasePO.getCompTpCd(), CommonConstants.COMP_TP_20)) {	// 위탁사
					request.setPrntTpCd(CommonConstants.PRNT_TP_CD_CS);
				} else if(StringUtils.equalsIgnoreCase(companyBasePO.getCompTpCd(), CommonConstants.COMP_TP_30)) {	// 매입사
					request.setPrntTpCd(CommonConstants.PRNT_TP_CD_VD);
				}
//			}
			
			// 거래처 상태 및 거래 상태
			if(StringUtils.equalsIgnoreCase(companyBasePO.getCompStatCd(), CommonConstants.COMP_STAT_10)) {	// 등록
				request.setStatCd(CommonConstants.STAT_CD_N);
				request.setTrdStatCd(CommonConstants.TRD_STAT_CD_20);
			} else if(StringUtils.equalsIgnoreCase(companyBasePO.getCompStatCd(), CommonConstants.COMP_STAT_20)) {	// 정상
				request.setStatCd(CommonConstants.STAT_CD_N);
				request.setTrdStatCd(CommonConstants.TRD_STAT_CD_10);
			} else if(StringUtils.equalsIgnoreCase(companyBasePO.getCompStatCd(), CommonConstants.COMP_STAT_30)) {	// 중지
				request.setStatCd(CommonConstants.STAT_CD_N);
				request.setTrdStatCd(CommonConstants.TRD_STAT_CD_20);
			} else if(StringUtils.equalsIgnoreCase(companyBasePO.getCompStatCd(), CommonConstants.COMP_STAT_40)) {	// 종료
				request.setStatCd(CommonConstants.STAT_CD_D);
				request.setTrdStatCd(CommonConstants.TRD_STAT_CD_20);
			}
			
			
			// 화주코드 : 현재 펫츠비 하나밖에 없음.
			request.setOwnrCd(bizConfig.getProperty("cis.api.goods.ownrCd"));
			// 대표자 이름
			request.setCeoNm(CisCryptoUtil.encrypt(companyBasePO.getCeoNm()));
			// 사업자 번호
			request.setBizNo(CisCryptoUtil.encrypt(companyBasePO.getBizNo()));
			// 우편번호
			request.setZipcode(CisCryptoUtil.encrypt(companyBasePO.getPostNoNew()));
			// 주소
			request.setAddr(CisCryptoUtil.encrypt(companyBasePO.getRoadAddr()));
			// 상세 주소
			request.setAddrDtl(CisCryptoUtil.encrypt(companyBasePO.getRoadDtlAddr()));
			// 전화번호
			request.setTelNo(CisCryptoUtil.encrypt(companyBasePO.getTel()));
			// 팩스번호
			request.setFaxNo(CisCryptoUtil.encrypt(companyBasePO.getFax()));
			// 담당자 이름
			request.setChrgNm(CisCryptoUtil.encrypt(companyBasePO.getCsChrgNm()));
			// 담당자 전화번호
			request.setChrgTelNo(CisCryptoUtil.encrypt(companyBasePO.getTel()));
			// 담당자 휴대전화
			request.setChrgCelNo(CisCryptoUtil.encrypt(companyBasePO.getCsChrgTel()));
			// 담당자 이메일
			request.setChrgEmail(CisCryptoUtil.encrypt(companyBasePO.getDlgtEmail()));
			// 업태
			request.setBsnCdt(companyBasePO.getBizCdts());
			// 종목
			request.setBsnItm(companyBasePO.getBizTp());
			request.setStlCdtCd("");
			request.setIncmReadTm(companyBasePO.getIncmReadTm());
			
			ObjectMapper mapper = new ObjectMapper();
			cisIfLogSeq = cisIfLogService.insertCisIfLog(ifGb.getApiId(), mapper.writeValueAsString(request), CommonConstants.CIS_IF_REQ);
			
			ar = apiClient.getResponse(ifGb, request);
			
			on = (ObjectNode) ar.getResponseJson(); 
			
			returnCode = on.get("resCd").getValueAsText();
			
			statusCd = CommonConstants.CIS_API_SUCCESS_HTTP_STATUS_CD;
		} catch (CustomException e) {
			log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
			statusCd = e.getExCode();
		} finally {
			cisIfLogService.updateCisIfLog(ifGb.getApiId(), ar.getResponseBody(), CommonConstants.CIS_IF_RES, returnCode, on.get("resMsg").getValueAsText(), statusCd, cisIfLogSeq);
		}
		
		if(!returnCode.equals(CommonConstants.CIS_API_SUCCESS_CD)) 	{returnValue = CommonConstants.COMM_YN_N;}
		else														{returnValue = CommonConstants.COMM_YN_Y;}
		
		return returnValue;
	}

	
	/**
	 * <pre>업체 수정</pre>
	 * 
	 * @author valueFactory
	 * @param po CompanyBasePO
	 * @return 
	 * @throws Exception 
	 */
	@Override
	public void updateCompany(CompanyBasePO po) throws Exception {
		// 사업자 번호
		if (StringUtil.isNotBlank(po.getBizNo())) {
			po.setBizNo(po.getBizNo().replace("-", ""));
		}

		// 구 우편번호
		if (StringUtil.isNotBlank(po.getPostNoOld())) {
			po.setPostNoOld(po.getPostNoOld().replace("-", ""));
		}

		// 팩스
		if (StringUtil.isNotBlank(po.getFax())) {
			po.setFax(po.getFax().replace("-", ""));
		}

		// 주소 상세
		po.setPrclDtlAddr(po.getRoadDtlAddr());

		FtpImgUtil ftpImgUtil = new FtpImgUtil();
		if(po.getBizLicImgPathTemp() != null && po.getBizLicImgPathTemp() != "") {
			// 원본 삭제
			nhnObjectStorageUtil.delete(po.getBizLicImgPath());
			po.setBizLicImgPath(po.getBizLicImgPathTemp());
			
			String filePath = ftpImgUtil.uploadFilePath(po.getBizLicImgPath(), CommonConstants.PET_IMG_PATH + FileUtil.SEPARATOR + po.getCompNo());
			ftpImgUtil.upload(po.getBizLicImgPath(), filePath);
			po.setBizLicImgPath(filePath);
		}
		
		int result = companyDao.updateCompany(po);
		if (result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		
		companyDao.insertCompanyHist(po);

		// 사이트와 공급업체 매핑정보 삭제 후 재등록
		companyDao.deleteStCompanyMap(po);

		if (po.getStId() != null && po.getStId().length > 0) {
			for (Long stId : po.getStId()) {
				StStdInfoPO stStdInfoPO = new StStdInfoPO();
				stStdInfoPO.setStId(stId);
				stStdInfoPO.setCompNo(po.getCompNo());

				result = companyDao.insertStCompanyMap(stStdInfoPO);

				if (result == 0) {
					throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
				}
			}
		}

		// 업체 브랜드 등록
//		companyDao.deleteCompanyBrand(po);

		if (po.getCompanyBrandPOList() != null && !po.getCompanyBrandPOList().isEmpty()) {
			for (CompanyBrandPO bndpo : po.getCompanyBrandPOList()) {
				if(bndpo.getDlgtBndYn().equals(CommonConstants.COMM_YN_Y)) {
					bndpo.setCompNo(po.getCompNo());

					result = companyDao.updateCompanyBrand(bndpo);

					if (result == 0) {
						throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
					}	
					
					break;
				}
			}
		}
		
		// 계좌 삭제후 재등록
		companyDao.deleteCompAcct(po);
		
		// 계좌
		if(po.getCompAcctPOList() != null && !po.getCompAcctPOList().isEmpty()) {
			for(CompAcctPO compAcctPO : po.getCompAcctPOList()) {
				compAcctPO.setCompNo(po.getCompNo());
				
				if(compAcctPO.getAcctImgPathTemp() != null && compAcctPO.getAcctImgPathTemp() != "") {
					// 원본 삭제
					nhnObjectStorageUtil.delete(compAcctPO.getAcctImgPath());
					compAcctPO.setAcctImgPath(compAcctPO.getAcctImgPathTemp());
					
					String filePath = ftpImgUtil.uploadFilePath(compAcctPO.getAcctImgPath(), CommonConstants.PET_IMG_PATH + FileUtil.SEPARATOR + compAcctPO.getCompNo());
					ftpImgUtil.upload(compAcctPO.getAcctImgPath(), filePath);
					compAcctPO.setAcctImgPath(filePath);
				}
				
				result = companyDao.insertCompAcct(compAcctPO);

				if (result == 0) {
					throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
				}
				
				List<String> listAcctNo = companyDao.listCompAcctHist(compAcctPO);
				if(!listAcctNo.contains(compAcctPO.getAcctNo())) {
					// 계좌 히스토리
					companyDao.insertCompAcctHist(compAcctPO);	
				}
			}
		}
		
		// 담당자 삭제 후 재등록
		companyDao.deleteCompanyChrg(po);
		
		// 담당자
		if(po.getCompanyChrgPOList() != null && !po.getCompanyChrgPOList().isEmpty()) {
			for(CompanyChrgPO companyChrgPO : po.getCompanyChrgPOList()) {
				companyChrgPO.setCompNo(po.getCompNo());
				result = companyDao.insertCompanyChrg(companyChrgPO);

				if (result == 0) {
					throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
				}
			}
		}
		
		companyCisApi(po, CisApiSpec.IF_R_UPDATE_PRNT_INFO);
	}

	
	/**
	 * <pre>업체 정산 수수료 목록</pre>
	 * 
	 * @author valueFactory
	 * @param so CompanySO
	 * @return 
	 */
	@Override
	@Transactional(readOnly = true)
	public List<CompanyCclVO> listCompanyCcl(CompanySO so) {
		return companyDao.listCompanyCcl(so);
	}

	
	/**
	 * <pre>업체 정산 수수료 등록</pre>
	 * 
	 * @author valueFactory
	 * @param po CompanyCclPO
	 * @return 
	 */
	@Override
	public void insertCompanyCcl(CompanyCclPO po) {
		CompanySO so = new CompanySO();
		so.setCompNo(po.getCompNo());
		so.setStId(po.getStId());
		int rtn = companyDao.existsCompanyCcl(so);
		int result = 0;

		if (rtn > 0) {
			result = companyDao.updateCompanyCcl(po);
			if (result == 0) {
				throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
			}
			result = companyDao.insertCompanyCcl(po);
			if (result == 0) {
				throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
			}
		} else {
			result = companyDao.insertNewCompanyCcl(po);
			if (result == 0) {
				throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
			}
		}
	}

	
	/**
	 * <pre>업체 수수료 정책 조회</pre>
	 * 
	 * @author valueFactory
	 * @param po CompanyCclPO
	 * @return 
	 */
	@Override
	public CompanyCclVO getCompCcl(CompanyCclPO po) {
		return companyDao.getCompCcl(po);
	}
	
	
	/**
	 * <pre>업체 배송 정책 저장</pre>
	 * 
	 * @author valueFactory
	 * @param po DeliveryChargePolicyPO
	 * @return 
	 */
	@Override
	public void saveCompanyDelivery(DeliveryChargePolicyPO po) {
		DeliveryChargePolicySO so = new DeliveryChargePolicySO();
		so.setCompNo(po.getCompNo());
		so.setDlvrcPlcNo(po.getDlvrcPlcNo());

		if (StringUtil.isNotBlank(po.getRtnExcTel())) {
			po.setRtnExcTel(po.getRtnExcTel().replace("-", ""));
		}

		if (StringUtil.isNotBlank(po.getRtnaPostNoOld())) {
			po.setRtnaPostNoOld(po.getRtnaPostNoOld().replace("-", ""));
		}
		po.setRtnaPrclDtlAddr(po.getRtnaRoadDtlAddr());

		if (StringUtil.isNotBlank(po.getRlsaPostNoOld())) {
			po.setRlsaPostNoOld(po.getRlsaPostNoOld().replace("-", ""));
		}
		po.setRlsaPrclDtlAddr(po.getRlsaRoadDtlAddr());

		int result = 0;
		if (StringUtils.equalsIgnoreCase(CommonConstants.COMM_YN_Y, po.getViewDlvrPlcyDetail())) {
			Long targetDlvrcPlcNo = po.getDlvrcPlcNo();

			// 관리자일때만 바로 업데이트 하고 그 외 사용자는 이력테이블에 먼저 등록하고 승인과정을 거쳐야 함.
			if (StringUtils.equals(CommonConstants.USR_GRP_10, po.getUsrGrpCd())) {
				// 0. 배송비 정책 이력테이블에 수정사항을 등록함
				po.setCfmUsrNo(po.getUsrNo());
				po.setCfmYn(CommonConstants.COMM_YN_Y);

				result = deliveryChargePolicyDao.insertDeliveryChargePolicyHistory(po);
				if (result == 0) {
					throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
				}

				// 1. 배송비 정책 테이블에 수정사항을 업데이트함.
				po.setDlvrcPlcNo(targetDlvrcPlcNo);
				result = deliveryChargePolicyDao.updateDeliveryChargePolicy(po);
				if (result == 0) {
					throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
				}
			} else {
				po.setCfmYn(CommonConstants.COMM_YN_N);

				result = deliveryChargePolicyDao.insertDeliveryChargePolicyHistory(po);
				if (result == 0) {
					throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
				}
			}
		} else {
			// 관리자일때만 배송비 정책 테이블에 직접 등록함
			if (StringUtils.equals(CommonConstants.USR_GRP_10, po.getUsrGrpCd())) {
				po.setCfmUsrNo(po.getUsrNo());
				po.setCfmYn(CommonConstants.COMM_YN_Y);

				result = deliveryChargePolicyDao.insertDeliveryChargePolicyHistory(po);
				if (result == 0) {
					throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
				}

				result = deliveryChargePolicyDao.insertDeliveryChargePolicy(po);
				if (result == 0) {
					throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
				}
			} else {
				po.setCfmYn(CommonConstants.COMM_YN_N);

				result = deliveryChargePolicyDao.insertDeliveryChargePolicyHistory(po);
				if (result == 0) {
					throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
				}
			}
		}
	}

	
	/**
	 * <pre>업체 전시 매핑 페이지</pre>
	 * 
	 * @author valueFactory
	 * @param so CompanySO
	 * @return 
	 */
	@Override
	@Transactional(readOnly = true)
	public List<DisplayCategoryVO> pageCompDispMap(CompanySO so) {
		return companyDao.pageCompDispMap(so);
	}

	
	/**
	 * <pre>업체 전시 매핑 (API용)</pre>
	 * 
	 * @author valueFactory
	 * @param so CompanySO
	 * @return 
	 */
	@Override
	@Transactional(readOnly = true)
	public List<biz.app.display.model.interfaces.DisplayCategoryVO> pageCompDispInterface(CompanySO so) {
		return companyDao.pageCompDispInterface(so);
	}

	
	/**
	 * <pre>업체 브랜드 매핑 목록 조회</pre>
	 * 
	 * @author valueFactory
	 * @param so CompanySO
	 * @return 
	 */
	@Override
	@Transactional(readOnly = true)
	public List<CompanyBrandVO> pageCompBrandMap(CompanySO so) {
		return companyDao.pageCompBrandMap(so);
	}

	
	/**
	 * <pre>상위 업체에 해당하는 사이트 목록 조회</pre>
	 * 
	 * @author valueFactory
	 * @param so CompanySO
	 * @return 
	 */
	@Override
	public List<StStdInfoVO> getUpperCompStIdList(CompanySO so) {
		return companyDao.getUpperCompStIdList(so);
	}

	
	/**
	 * <pre>업체 카테고리 목록 조회</pre>
	 * 
	 * @author valueFactory
	 * @param so CompanySO
	 * @return 
	 */
	@Override
	public List<DisplayCategoryVO> listCompanyCategory(CompanySO so) {
		return companyDao.listCompanyCategory(so);
	}

	
	/**
	 * <pre> 업체 관리 > 업체 정책 변경 관리  승인</pre>
	 * 
	 * @author valueFactory
	 * @param po DeliveryChargePolicyPO
	 * @return 
	 */
	@Override
	public void updateCompanyDeliveryChargePolicy(DeliveryChargePolicyPO po) {
		int result = 0;

		// 01 히스토리 테이블 인서트
		result = deliveryChargePolicyDao.updateDeliveryChargePolicyHistory(po);
		if (result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		// 02 베이스 테이블 에 INSERT INTO
		result = deliveryChargePolicyDao.insertDeliveryChargePolicy(po);
		if (result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
	}

	
	/**
	 * <pre>업체 수수료율 일괄 변경</pre>
	 * 
	 * @author valueFactory
	 * @param compNo 
	 * @param stId
	 * @param cmsRate
	 * @return 
	 */
	@Override
	public int companyCmsRateChg(Long compNo, Long stId, Double cmsRate) {
		StGoodsMapPO po = new StGoodsMapPO();

		po.setCompNo(compNo);
		po.setStId(stId);
		po.setCmsRate(cmsRate);

		return companyDao.companyCmsRateChg(po);
	}


	/**
	 * <pre>상품 수수료율 일괄 변경</pre>
	 * 
	 * @author valueFactory
	 * @param po StGoodsMapPO
	 * @return 
	 */
	@Override
	public int goodsCmsRateChg(StGoodsMapPO po) {
		return companyDao.goodsCmsRateChg(po);
	}

	
	/**
	 * <pre> API 허용 IP 여부 check</pre>
	 * 
	 * @author valueFactory
	 * @param so ApiPermitIpSO
	 * @return 
	 */
	@Override
	public boolean checkApiPermitIp(ApiPermitIpSO so) {
		return StringUtils.equals(companyDao.getFlagApiPermitIp(so), CommonConstants.COMM_YN_Y);

	}
	
	
	/**
	 * <pre>API 허용 IP 등록</pre>
	 * 
	 * @author valueFactory
	 * @param po StGoodsMapPO
	 * @return 
	 */
	@Override
	public void insertApiPermitIp(Long compNo, String pmtIp) {
		CompanyBasePO po = new CompanyBasePO();
		po.setCompNo(compNo);
		po.setPmtIp(pmtIp);
		companyDao.insertApiPermitIp(po);
	}

	
	/**
	 * <pre>API 허용 IP 삭제</pre>
	 * 
	 * @author valueFactory
	 * @param po StGoodsMapPO
	 * @return 
	 */
	@Override
	public void deleteApiPermitIp(Long[] ipSeqs) {
		CompanyBasePO po = new CompanyBasePO();
		for (Long ipSeq : ipSeqs) {
			po.setIpSeq(ipSeq);
			companyDao.deleteApiPermitIp(po);
		}
	}

	
	/**
	 * <pre>API 허용 IP 목록</pre>
	 * 
	 * @author valueFactory
	 * @param po StGoodsMapPO
	 * @return 
	 */
	@Override
	public List<CompanyBaseVO> companyApiPermitIpList(CompanySO so) {
		return companyDao.companyApiPermitIpList(so);
	}

	
	/**
	 * <pre>업체 계정으로 로그인</pre>
	 * 
	 * @author valueFactory
	 * @param so CompanySO
	 * @return 
	 */
	@Override
	public String compUserLogin(CompanySO so) {

		String resultCode = null;

		UserBaseSO uso = new UserBaseSO();
		uso.setCompNo(so.getCompNo());
		uso.setUsrGbCd(CommonConstants.USR_GB_2030);	// 사용자 구분 '제휴사 관리자' -> BO에서 등록하는 PO계정은 제휴사 관리자 한명만 등록함.

		List<UserBaseVO> list = userDao.pageUser(uso);

		if (list != null && !list.isEmpty()) {
			// 세션삭제
			HttpSession sess = request.getSession(false);

			if (sess != null) {
				sess.invalidate();
			}

			UserBaseVO userData = list.get(0);
			
			//권한리스트 조회 
			uso.setUsrNo(userData.getUsrNo());
			List<AuthorityVO> authList = userDao.selectAuthNoListForSession(uso);
			List<Long> listAuth = new ArrayList<Long>();
			for(AuthorityVO auth : authList) {
				listAuth.add(auth.getAuthNo());
			}

			// 로그인 세션 생성
			Session session = new Session();

			session.setSessionId(SessionUtil.getSessionId());
			session.setUsrNo(userData.getUsrNo());
			session.setLoginId(userData.getLoginId());
			session.setUsrNm(userData.getUsrNm());
			session.setUsrStatCd(userData.getUsrStatCd());
			session.setCompNo(userData.getCompNo());
			session.setCompNm(userData.getCompNm());
			session.setCompStatCd(userData.getCompStatCd());
			session.setUsrGrpCd(userData.getUsrGrpCd());
			session.setAuthNos(listAuth);
			session.setUsrGbCd(userData.getUsrGbCd());
			session.setUpCompNo(userData.getUpCompNo());
			session.setUpCompNm(userData.getUpCompNm());
			session.setCtiId(userData.getCtiId());
			session.setCtiExtNo(userData.getCtiExtNo());
			session.setMdUsrNo(userData.getMdUsrNo());
			session.setLastLoginDtm(userData.getLastLoginDtm());
			AdminSessionUtil.setSession(session);

			// 로그인 이력 저장
			UserLoginHistPO po = new UserLoginHistPO();
			po.setUsrNo(userData.getUsrNo());
			po.setSysRegrNo(userData.getUsrNo());
			po.setLoginIp(RequestUtil.getClientIp());

			adminLoginDao.insertUserLoginHist(po);

			resultCode = CommonConstants.CONTROLLER_RESULT_CODE_SUCCESS;

		} else {
			resultCode = CommonConstants.CONTROLLER_RESULT_CODE_FAIL;
		}

		return resultCode;
	}
	
	@Override
	public List getCisList() {
		////////////////CIS 인터페이스 ////////////////
		String returnCode = "";
		String statusCd = null;
		
		Long cisIfLogSeq = null;
		
		ApiResponse ar = null;
		ObjectNode on = null;
		
		List itemList = new ArrayList();
		
		try {
			
			CompanyRequest request = new CompanyRequest();
//			request.setAllYn(CommonConstants.COMM_YN_Y);
			
			ObjectMapper mapper = new ObjectMapper();
			
			ar = apiClient.getResponse(CisApiSpec.IF_S_SELECT_PRNT_LIST, request);
			
			on = (ObjectNode) ar.getResponseJson(); 
			
			returnCode = on.get("resCd").getValueAsText();
			
//			itemList = (List) on.get("itemList");
		} catch (CustomException e) {
			log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
			statusCd = e.getExCode();
		}
		
		return itemList;
	}
	
	@Override
	public List<CompAcctVO> listCompAcct(CompanySO so) {
		return companyDao.listCompAcct(so);
	}
	
	@Override
	public List<CompanyChrgVO> listCompanyChrg(CompanySO so) {
		return companyDao.listCompanyChrg(so);
	}
	
	@Override
	public int compNmDupCheck(CompanySO so) {
		return companyDao.compNmDupCheck(so);
	}
	
	@Override
	public void deleteImage(CompanyBasePO po, CompAcctPO acctPO) {
		// TODO 조은지 : 서버 사진 삭제
		if(po.getBizLicImgPath() != null && po.getBizLicImgPath() != "") {
			po.setSysUpdrNo(AdminSessionUtil.getSession().getUsrNo());
			companyDao.deleteCompanyBaseImg(po);
		} else if(acctPO.getAcctImgPath() != null && acctPO.getAcctImgPath() != "") {
			acctPO.setSysUpdrNo(AdminSessionUtil.getSession().getUsrNo());
			companyDao.deleteCompAcctImg(acctPO);
		}
	}
}