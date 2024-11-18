package biz.app.brand.service;

import java.util.List;

import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import biz.app.brand.dao.BrandDao;
import biz.app.brand.model.BrandBasePO;
import biz.app.brand.model.BrandBaseSO;
import biz.app.brand.model.BrandBaseVO;
import biz.app.brand.model.BrandCategoryVO;
import biz.app.brand.model.BrandGoodsPO;
import biz.app.brand.model.BrandGoodsSO;
import biz.app.brand.model.BrandGoodsVO;
import biz.app.brand.model.BrandInitialVO;
import biz.app.brand.model.BrandPO;
import biz.app.brand.model.BrandSO;
import biz.app.brand.model.BrandTop10VO;
import biz.app.brand.model.BrandVO;
import biz.app.brand.model.CompanyBrandPO;
import biz.app.brand.model.DisplayBrandTreeVO;
import biz.app.display.dao.DisplayDao;
import biz.app.display.model.DisplayBannerVO;
import biz.app.display.model.DisplayBrandPO;
import biz.app.display.model.DisplayCategoryVO;
import biz.app.display.service.DisplayService;
import biz.app.goods.model.GoodsBaseSO;
import biz.app.goods.model.GoodsBaseVO;
import biz.app.goods.model.GoodsListVO;
import biz.app.st.model.StStdInfoPO;
import biz.app.system.model.CodeDetailVO;
import biz.common.service.BizService;
import biz.interfaces.cis.model.response.goods.CisBrandVO;
import biz.interfaces.cis.service.CisGoodsService;
import framework.admin.constants.AdminConstants;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import framework.common.util.FileUtil;
import framework.common.util.FtpImgUtil;
import framework.common.util.StringUtil;
import lombok.extern.slf4j.Slf4j;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.brand.service
* - 파일명		: BrandServiceImpl.java
* - 작성일		: 2016. 4. 15.
* - 작성자		: snw
* - 설명		: 브랜드 서비스
* </pre>
*/
@Slf4j
@Transactional
@Service("brandService")
public class BrandServiceImpl implements BrandService {

	@Autowired
	private BrandDao brandDao;

	@Autowired
	private DisplayDao displayDao;

	
	@Autowired
	private BizService bizService;
	

	@Autowired
	private DisplayService displayService;
	
	@Autowired
	private CisGoodsService cisGoodsService;
	
	//-------------------------------------------------------------------------------------------------------------------------//
	//- Common area
	//-------------------------------------------------------------------------------------------------------------------------//

	/*
	 * 브랜드 단건 조회
	 * @see biz.app.brand.service.BrandService#getBrand(java.lang.Long)
	 */
	@Override
	@Transactional(readOnly=true)
	public BrandBaseVO getBrand(Long bndNo) {
		BrandBaseSO so = new BrandBaseSO();
		so.setBndNo(bndNo);
		return brandDao.getBrand(so);
	}


	//-------------------------------------------------------------------------------------------------------------------------//
	//- Admin area
	//-------------------------------------------------------------------------------------------------------------------------//

	@Override
	public Long insertBrand (BrandBasePO brandPO ) {
		
		Long bndNo = null;
		// 브랜드는 Base테이블에 이미지가 있어서 함께 등록을 위해서는..
		// 브랜드 번호를 미리 할당 받는다.
		bndNo = bizService.getSequence(AdminConstants.SEQUENCE_BRAND_BASE_SEQ );
		
		if(log.isDebugEnabled() ) {
			log.debug("########## : " + "insertBrand" );
			log.debug("########## bndNo : {}", bndNo );
			log.debug("#################### : " + "브랜드 등록" );
		}

		if(brandPO != null ) {
			String realImgPath = null;
			brandPO.setBndNo(bndNo );
			if(!StringUtil.isEmpty(brandPO.getBndItrdcImgPath() ) ) {
				realImgPath = brandImageUpload (brandPO , "1" );
				if(log.isDebugEnabled() ) {
					log.debug("#################### realImgPath 1 : " + realImgPath );
				}
				brandPO.setBndItrdcImgPath(realImgPath );
			}
			// 브랜드 모바일 소개 이미지경로 
			if(!StringUtil.isEmpty(brandPO.getBndItrdcMoImgPath() ) ) {
				realImgPath = brandImageUpload (brandPO ,"2");
				if(log.isDebugEnabled() ) {
					log.debug("#################### realImgPath 2 : " + realImgPath );
				}
				brandPO.setBndItrdcMoImgPath(realImgPath );
			}
			
			// 브랜드 썸네일  이미지경로 
			/*if(!StringUtil.isEmpty(brandPO.getTnImgPath() ) ) {
				realImgPath = brandImageUpload (brandPO ,"3" );
				if(log.isDebugEnabled() ) {
					log.debug("#################### realImgPath 3 : " + realImgPath );
				}
				brandPO.setTnImgPath(realImgPath );
			}*/
			
			// 브랜드 썸네일  이미지경로 
			/*if(!StringUtil.isEmpty(brandPO.getTnMoImgPath() ) ) {
				realImgPath = brandImageUpload (brandPO ,"4" );
				if(log.isDebugEnabled() ) {
					log.debug("#################### realImgPath 4 : " + realImgPath );
				}
				brandPO.setTnMoImgPath(realImgPath );
			}*/
			
			/*
			if(StringUtil.isNotBlank(brandPO.getBndGbCd()) && AdminConstants.BND_GB_30.equals(brandPO.getBndGbCd())){
				brandPO.setDlgtBndNo(null);
			}*/

			brandDao.insertBrandBase(brandPO );
			
			// cis 등록
			String cisResultMsg = "";
			try {
				CisBrandVO cisBrandVO = cisGoodsService.sendBrand(brandPO, "I");
				
				if(!cisBrandVO.getResCd().equalsIgnoreCase(CommonConstants.CIS_API_SUCCESS_CD)) {
					cisResultMsg = cisBrandVO.getResMsg();
					throw new CustomException(ExceptionConstants.ERROR_CIS_ERROR, new String[]{cisResultMsg});
				}
				
			} catch (Exception e) {
				throw new CustomException(ExceptionConstants.ERROR_CIS_ERROR, new String[]{cisResultMsg});
			}
			
			// 사이트와 브랜드 매핑 정보 등록
			if (brandPO.getStId() != null && brandPO.getStId().length > 0) {
				for(Long stId : brandPO.getStId()) {
					StStdInfoPO stStdInfoPO = new StStdInfoPO();
					stStdInfoPO.setStId(stId);
					stStdInfoPO.setBndNo(brandPO.getBndNo());
					
					int result = brandDao.insertStBrandMap(stStdInfoPO);
					if (result == 0) {
						throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
					}
				}
			}
			
			int result = 0 ;
			// 업체와 브랜드 매핑 정보 등록
			CompanyBrandPO companyBrandPO = new CompanyBrandPO();
			companyBrandPO.setBndNo(brandPO.getBndNo());
			result = brandDao.insertCompanyBrand(companyBrandPO);
			
			//카테고리 등록
			/*if(brandPO.getArrDispClsfNo() != null && brandPO.getArrDispClsfNo().length > 0){
				for(Long dispClsfNo : brandPO.getArrDispClsfNo()) {
					DisplayBrandPO displayBrandPO = new DisplayBrandPO();
					displayBrandPO.setBndNo(brandPO.getBndNo());
					displayBrandPO.setDispClsfNo(dispClsfNo);
					
					result = brandDao.insertDisplayBrand(displayBrandPO);

					if(result == 0) {
						throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
					}
				}
			}*/
			// new 상품등록 
			/*if(brandPO.getArrNewGoodsId() != null && brandPO.getArrNewGoodsId().length > 0){
				for(String goods : brandPO.getArrNewGoodsId()) {
					
					BrandGoodsPO brandGoodsPO = new BrandGoodsPO();
					brandGoodsPO.setBndNo(brandPO.getBndNo());
					brandGoodsPO.setGoodsId(goods);
					brandGoodsPO.setBndGoodsDispGb(AdminConstants.BND_GOODS_DISP_GB_10);
					result = brandDao.insertBrandGoods(brandGoodsPO);
					if(result == 0) {
						throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
					}
				}
			}*/
			// best 상품등록
			/*if(brandPO.getArrBestGoodsId() != null && brandPO.getArrBestGoodsId().length > 0){
				for(String goods : brandPO.getArrBestGoodsId()) {
					
					BrandGoodsPO brandGoodsPO = new BrandGoodsPO();
					brandGoodsPO.setBndNo(brandPO.getBndNo());
					brandGoodsPO.setGoodsId(goods);
					brandGoodsPO.setBndGoodsDispGb(AdminConstants.BND_GOODS_DISP_GB_20);
					result = brandDao.insertBrandGoods(brandGoodsPO);
					if(result == 0) {
						throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
					}
				}
			}*/
			
		}

		return bndNo;
	}
/*
	@Override
	public Long insertBrandOld (BrandBasePO brandPO, CompanyBrandPO companyPO ) {
		if(log.isDebugEnabled() ) {
			log.debug("########## : " + "insertBrand" );
		}
		Long bndNo = null;
		// 브랜드는 Base테이블에 이미지가 있어서 함께 등록을 위해서는..
		// 브랜드 번호를 미리 할당 받는다.
		bndNo = bizDao.getSequence(AdminConstants.SEQUENCE_BRAND_BASE_SEQ );
		if(log.isDebugEnabled() ) {
			log.debug("########## bndNo : {}", bndNo );
		}

		if(log.isDebugEnabled() ) {
			log.debug("#################### : " + "브랜드 등록" );
		}

		if(brandPO != null ) {
			String realImgPath = null;
			brandPO.setBndNo(bndNo );
			if(!StringUtil.isEmpty(brandPO.getBndItrdcImgPath() ) ) {
				realImgPath = brandImageUpload (brandPO );
				if(log.isDebugEnabled() ) {
					log.debug("#################### realImgPath : " + realImgPath );
				}
				brandPO.setBndItrdcImgPath(realImgPath );
			}
			if(StringUtil.isNotBlank(brandPO.getBndGbCd()) && AdminConstants.BND_GB_30.equals(brandPO.getBndGbCd())){
				brandPO.setDlgtBndNo(null);
			}

			brandDao.insertBrandBase(brandPO );
			
			// 사이트와 브랜드 매핑 정보 등록
			if (brandPO.getStId() != null && brandPO.getStId().length > 0) {
				for(Long stId : brandPO.getStId()) {
					StStdInfoPO stStdInfoPO = new StStdInfoPO();
					stStdInfoPO.setStId(stId);
					stStdInfoPO.setBndNo(brandPO.getBndNo());
					
					int result = brandDao.insertStBrandMap(stStdInfoPO);
					if (result == 0) {
						throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
					}
				}
			}
		}

		if(log.isDebugEnabled() ) {
			log.debug("#################### : " + "업체 브랜드 등록" );
		}
		if(companyPO != null ) {
			companyPO.setBndNo(bndNo );
			brandDao.insertCompanyBrand(companyPO );
		}

		return bndNo;
	}
*/
	@Override
	public BrandBaseVO getBrandBase (Long bndNo ) {
		return brandDao.getBrandBase(bndNo );
	}


	/*
	@Override
	public CompanyBrandVO getCompanyBrand (Long bndNo ) {
		return brandDao.getCompanyBrand(bndNo );
	}
*/

	@Override
	public List<BrandBaseVO> pageBrandBase (BrandBaseSO so ) {
		return brandDao.pageBrandBase(so );
	}


	@Override
	public int deleteBrand (Long[] bndNos ) {
		int rtnValue = 0;

		if(bndNos != null && bndNos.length > 0 ) {
			for(Long bndNo : bndNos ) {
				if(log.isDebugEnabled() ) {
					log.debug("########## bndNo : {}", bndNo );
				}

				// 이미지 삭제
				BrandBaseVO brandBase = brandDao.getBrandBase(bndNo );
				if(brandBase != null ) {
					// 브랜드 기본 삭제 
					if(!StringUtil.isEmpty(brandBase.getBndItrdcImgPath()) ) {
						brandImageDelete (brandBase.getBndItrdcImgPath());
					}
					//모바일 이미지 삭제 
					if(!StringUtil.isEmpty(brandBase.getBndItrdcMoImgPath()) ) {
						brandImageDelete (brandBase.getBndItrdcMoImgPath());
					}
					//썸네일 이미지 삭제 
					if(!StringUtil.isEmpty(brandBase.getTnImgPath()) ) {
						brandImageDelete (brandBase.getTnImgPath());
					}
					//썸네일 모바일 이미지 삭제 
					if(!StringUtil.isEmpty(brandBase.getTnMoImgPath()) ) {
						brandImageDelete (brandBase.getTnMoImgPath());
					}
				}
				//사이트와 브랜드 매핑 삭제		
				brandDao.deleteStStdBrand(bndNo);
				//업체와 브랜드 매핑 삭제
				brandDao.deleteCompanyBrand(bndNo );
				
				// 카테고리삭제 
				DisplayBrandPO deleteDisplayBrandPO = new DisplayBrandPO();
				deleteDisplayBrandPO.setBndNo(bndNo);
				brandDao.deleteDisplayBrand(deleteDisplayBrandPO); 
				
				// BrandGoods  삭제 
				BrandGoodsPO deleteBrandGoodsPO = new BrandGoodsPO();
				deleteBrandGoodsPO.setBndNo(bndNo);
				brandDao.deleteBrandGoods(deleteBrandGoodsPO);
				
				// BrandBase  삭제 
				brandDao.deleteBrandBase(bndNo );
				
				rtnValue ++;
			}
		}

		return rtnValue;
	}

	@Override
	public Long updateBrand (BrandBasePO brandPO ) {
		if(log.isDebugEnabled() ) {
			log.debug("########## : " + "updateBrand" );
		}
		Long bndNo = 0L;

		if(brandPO != null ) {
			bndNo = brandPO.getBndNo();
			// 기본정보 수정..
			String realImgPath = null;
			BrandBaseVO vo = getBrand(bndNo);
			//브랜드 기본 	
			if(StringUtil.isEmpty(brandPO.getBndItrdcImgPath()) && StringUtil.isNotEmpty(brandPO.getOrgBndItrdcImgPath() )) {	// 이미지 수정 없음
				brandPO.setBndItrdcImgPath(brandPO.getOrgBndItrdcImgPath() );
			} else if (StringUtil.isEmpty(brandPO.getBndItrdcImgPath()) && StringUtil.isEmpty(brandPO.getOrgBndItrdcImgPath() )) {	// 이미지 삭제
				if(StringUtil.isNotBlank(vo.getBndItrdcImgPath())){
					brandImageDelete(vo.getBndItrdcImgPath());
					brandPO.setBndItrdcImgPath(null );
				}
			} else if (!StringUtil.isEmpty(brandPO.getBndItrdcImgPath())) {	// 이미지 수정
				if(StringUtil.isNotBlank(brandPO.getOrgBndItrdcImgPath())){
					brandImageDelete(brandPO.getOrgBndItrdcImgPath());
				}

				realImgPath = brandImageUpload (brandPO ,"1");
				brandPO.setBndItrdcImgPath(realImgPath );
			}
			//브랜드 모바일 기본 
			if(StringUtil.isEmpty(brandPO.getBndItrdcMoImgPath()) && StringUtil.isNotEmpty(brandPO.getOrgBndItrdcMoImgPath() )) {	// 이미지 수정 없음
				brandPO.setBndItrdcMoImgPath(brandPO.getOrgBndItrdcMoImgPath() );
			} else if (StringUtil.isEmpty(brandPO.getBndItrdcMoImgPath()) && StringUtil.isEmpty(brandPO.getOrgBndItrdcMoImgPath() )) {	// 이미지 삭제
				if(StringUtil.isNotBlank(vo.getBndItrdcMoImgPath())){
					brandImageDelete(vo.getBndItrdcMoImgPath());
					brandPO.setBndItrdcMoImgPath(null );
				}
			} else if (!StringUtil.isEmpty(brandPO.getBndItrdcMoImgPath())) {	// 이미지 수정
				if(StringUtil.isNotBlank(brandPO.getOrgBndItrdcMoImgPath())){
					brandImageDelete(brandPO.getOrgBndItrdcMoImgPath());
				}

				realImgPath = brandImageUpload (brandPO ,"2" );
				brandPO.setBndItrdcMoImgPath(realImgPath );
			}
			
			//브랜드 썸네일 이미지 
			if(StringUtil.isEmpty(brandPO.getTnImgPath()) && StringUtil.isNotEmpty(brandPO.getOrgTnImgPath())) {	// 이미지 수정 없음
				brandPO.setTnImgPath(brandPO.getOrgTnImgPath() );
			} else if (StringUtil.isEmpty(brandPO.getTnImgPath()) && StringUtil.isEmpty(brandPO.getOrgTnImgPath() )) {	// 이미지 삭제
				if(StringUtil.isNotBlank(vo.getTnImgPath())){
					brandImageDelete(vo.getTnImgPath());
					brandPO.setTnImgPath(null );
				}
			} else if (!StringUtil.isEmpty(brandPO.getTnImgPath())) {	// 이미지 수정
//				if(StringUtil.isNotBlank(orgBndItrdcImgPath)){
//					brandImageDelete(orgBndItrdcImgPath);
//				}

				realImgPath = brandImageUpload (brandPO ,"3" );
				brandPO.setTnImgPath(realImgPath );
			}
			
			//브랜드 썸네일 모바일 이미지 
			if(StringUtil.isEmpty(brandPO.getTnMoImgPath()) && StringUtil.isNotEmpty(brandPO.getOrgTnMoImgPath())) {	// 이미지 수정 없음
				brandPO.setTnMoImgPath(brandPO.getOrgTnMoImgPath() );
			} else if (StringUtil.isEmpty(brandPO.getTnMoImgPath()) && StringUtil.isEmpty(brandPO.getOrgTnMoImgPath())) {	// 이미지 삭제
				if(StringUtil.isNotBlank(vo.getTnImgPath())){
					brandImageDelete(vo.getTnImgPath());
					brandPO.setTnMoImgPath(null );
				}
			} else if (!StringUtil.isEmpty(brandPO.getTnMoImgPath())) {	// 이미지 수정
//				if(StringUtil.isNotBlank(orgBndItrdcImgPath)){
//					brandImageDelete(orgBndItrdcImgPath);
//				}

				realImgPath = brandImageUpload (brandPO,"4"  );
				brandPO.setTnMoImgPath(realImgPath );
			}
			
			brandDao.updateBrandBase(brandPO );
			
			// 브랜드 cis 수정
			String cisResultMsg = "";
			try {
				CisBrandVO cisBrandVO = cisGoodsService.sendBrand(brandPO, "U");
				log.debug("cis ::: " + cisBrandVO);
				
				if(!cisBrandVO.getResCd().equalsIgnoreCase(CommonConstants.CIS_API_SUCCESS_CD)) {
					cisResultMsg = cisBrandVO.getResMsg();
					throw new CustomException(ExceptionConstants.ERROR_CIS_ERROR, new String[]{cisResultMsg});
				}
				
			} catch (Exception e) {
				throw new CustomException(ExceptionConstants.ERROR_CIS_ERROR, new String[]{cisResultMsg});
			}
			
			// 사이트와 브랜드 매핑정보 삭제 후 재등록
			int result;
			brandDao.deleteStBrandMap(brandPO);
			
			if (brandPO.getStId() != null && brandPO.getStId().length > 0) {
				for (Long stId : brandPO.getStId()) {
					StStdInfoPO stStdInfoPO = new StStdInfoPO();
					stStdInfoPO.setStId(stId);
					stStdInfoPO.setBndNo(brandPO.getBndNo());
		
					result = brandDao.insertStBrandMap(stStdInfoPO);
		
					if (result == 0) {
						throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
					}
				}
			}
			/*
			// 카테고리삭제 
			DisplayBrandPO deleteDisplayBrandPO = new DisplayBrandPO();
			deleteDisplayBrandPO.setBndNo(brandPO.getBndNo());
			brandDao.deleteDisplayBrand(deleteDisplayBrandPO); 
			
			//카테고리 등록
			if(brandPO.getArrDispClsfNo() != null && brandPO.getArrDispClsfNo().length > 0){
				for(Long dispClsfNo : brandPO.getArrDispClsfNo()) {
					DisplayBrandPO displayBrandPO = new DisplayBrandPO();
					displayBrandPO.setBndNo(brandPO.getBndNo());
					displayBrandPO.setDispClsfNo(dispClsfNo);
					
					result = brandDao.insertDisplayBrand(displayBrandPO);

					if(result == 0) {
						throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
					}
				}
			}
			
			// BrandGoods  삭제후 재등록 
			BrandGoodsPO deleteBrandGoodsPO = new BrandGoodsPO();
			deleteBrandGoodsPO.setBndNo(brandPO.getBndNo());
			brandDao.deleteBrandGoods(deleteBrandGoodsPO);
			
			 
			if(brandPO.getArrNewGoodsId() != null && brandPO.getArrNewGoodsId().length > 0){
				for(String goods : brandPO.getArrNewGoodsId()) {
					
					BrandGoodsPO brandGoodsPO = new BrandGoodsPO();
					brandGoodsPO.setBndNo(brandPO.getBndNo());
					brandGoodsPO.setGoodsId(goods);
					brandGoodsPO.setBndGoodsDispGb(AdminConstants.BND_GOODS_DISP_GB_10);
					result = brandDao.insertBrandGoods(brandGoodsPO);
					if(result == 0) {
						throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
					}
				}
			}
			
			if(brandPO.getArrBestGoodsId() != null && brandPO.getArrBestGoodsId().length > 0){
				for(String goods : brandPO.getArrBestGoodsId()) {
					
					BrandGoodsPO brandGoodsPO = new BrandGoodsPO();
					brandGoodsPO.setBndNo(brandPO.getBndNo());
					brandGoodsPO.setGoodsId(goods);
					brandGoodsPO.setBndGoodsDispGb(AdminConstants.BND_GOODS_DISP_GB_20);
					result = brandDao.insertBrandGoods(brandGoodsPO);
					if(result == 0) {
						throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
					}
				}
			}
			*/
			
			
		}

		return bndNo;
	}
	/*
	@Override
	public Long updateBrand (BrandBasePO brandPO, CompanyBrandPO companyPO, String orgBndItrdcImgPath ) {
		if(log.isDebugEnabled() ) {
			log.debug("########## : " + "updateBrand" );
		}
		Long bndNo = brandPO.getBndNo();

		if(brandPO != null ) {
			// 기본정보 수정..
			String realImgPath = null;
			BrandBaseVO vo = getBrand(bndNo);

			if(StringUtil.isEmpty(brandPO.getBndItrdcImgPath()) && StringUtil.isNotEmpty(orgBndItrdcImgPath)) {	// 이미지 수정 없음
				brandPO.setBndItrdcImgPath(orgBndItrdcImgPath );
			} else if (StringUtil.isEmpty(brandPO.getBndItrdcImgPath()) && StringUtil.isEmpty(orgBndItrdcImgPath)) {	// 이미지 삭제
				if(StringUtil.isNotBlank(vo.getBndItrdcImgPath())){
					brandImageDelete(vo.getBndItrdcImgPath());
					brandPO.setBndItrdcImgPath(null );
				}
			} else if (!StringUtil.isEmpty(brandPO.getBndItrdcImgPath())) {	// 이미지 수정
//				if(StringUtil.isNotBlank(orgBndItrdcImgPath)){
//					brandImageDelete(orgBndItrdcImgPath);
//				}

				realImgPath = brandImageUpload (brandPO );
				brandPO.setBndItrdcImgPath(realImgPath );
			}
			brandDao.updateBrandBase(brandPO );
			
			// 사이트와 브랜드 매핑정보 삭제 후 재등록
			int result = brandDao.deleteStBrandMap(brandPO);
			
			if (brandPO.getStId() != null && brandPO.getStId().length > 0) {
				for (Long stId : brandPO.getStId()) {
					StStdInfoPO stStdInfoPO = new StStdInfoPO();
					stStdInfoPO.setStId(stId);
					stStdInfoPO.setBndNo(brandPO.getBndNo());
		
					result = brandDao.insertStBrandMap(stStdInfoPO);
		
					if (result == 0) {
						throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
					}
				}
			}
		}
		
		if(companyPO != null ) {
			// 삭제후 재등록
			brandDao.deleteCompanyBrand(bndNo );
			brandDao.insertCompanyBrand(companyPO );
		}

		return bndNo;
	}
*/

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BrandServiceImpl.java
	* - 작성일		: 2016. 5. 4.
	* - 작성자		: valueFactory
	* - 설명			: 브랜드 이미지 등록
	*                 1 브랜드 이미지  2 브랜드 모바일이미지 3 썸네일 이미지 4 썸네일 모바일 
	* </pre>
	* @param brandPO
	* @return
	*/
	public String brandImageUpload (BrandBasePO brandPO, String  imgType  ) {
		FtpImgUtil ftpImgUtil = new FtpImgUtil();
		String ext = null;
		String realImgPath = null;
		String brandPOGetPath = null;
		String adminConstantsPath = null; 
		
		if (  "1".equals(imgType)   ){
			brandPOGetPath = brandPO.getBndItrdcImgPath();
			adminConstantsPath = AdminConstants.BRAND_IMAGE_PATH  ;
		}else if ("2".equals(imgType)   ){
			brandPOGetPath = brandPO.getBndItrdcMoImgPath();
			adminConstantsPath = AdminConstants.BRANDMO_IMAGE_PATH  ;
		}else if ("3".equals(imgType) ){
			brandPOGetPath = brandPO.getTnImgPath();
			adminConstantsPath = AdminConstants.BRANDTN_IMAGE_PATH  ;
		}else if ("4".equals(imgType) ){
			brandPOGetPath = brandPO.getTnMoImgPath();
			adminConstantsPath = AdminConstants.BRANDTNMO_IMAGE_PATH  ;
		}
		 
		ext = FilenameUtils.getExtension(brandPOGetPath );
		//realImgPath = adminConstantsPath + FileUtil.SEPARATOR + String.valueOf(brandPO.getBndNo() ) + "." + ext;
		realImgPath = ftpImgUtil.uploadFilePath(brandPOGetPath, adminConstantsPath + FileUtil.SEPARATOR + String.valueOf(brandPO.getBndNo()));
		if(log.isDebugEnabled() ) {
			log.debug("#################### realImgPath : " + realImgPath );
		}

		ftpImgUtil.upload(brandPOGetPath, realImgPath );
		return realImgPath;
	}
	 
	 
	 
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BrandServiceImpl.java
	* - 작성일		: 2016. 5. 4.
	* - 작성자		: valueFactory
	* - 설명			: 브랜드 이미지 삭제
	* </pre>
	* @param brandPO
	*/
	public void brandImageDelete (String orgBndItrdcImgPath ) {
		FtpImgUtil ftpImgUtil = new FtpImgUtil();

		if(log.isDebugEnabled() ) {
			log.debug("#################### brandImageDelete : ");
		}

		ftpImgUtil.delete(orgBndItrdcImgPath );
	}


	//-------------------------------------------------------------------------------------------------------------------------//
	//- Front area
	//-------------------------------------------------------------------------------------------------------------------------//


	@Override
	@Transactional(readOnly=true)
	public List<DisplayCategoryVO> listBrandCate() {
		return this.brandDao.listBrandCate();
	}

	/* (non-Javadoc)
	 * @see biz.app.brand.service.BrandService#listLowestCate(biz.app.brand.model.BrandSO)
	 */
	@Override
	//@Transactional(readOnly=true)
	public List<BrandCategoryVO> listLowestCate(BrandSO so) {
		return this.brandDao.listLowestCate(so);
	}

	
	public List<BrandVO> listSeries(BrandSO so) {
		return this.brandDao.listSeries(so);
	}
	
	/**
	 *
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: DisplayServiceImpl.java
	* - 작성일		: 2017. 2. 7.
	* - 작성자		: hg.jeong
	* - 설명		: 메인 BRAND
	* </pre>
	* @param String
	* @return
	 */		
	@Override
	public List<BrandVO> listInitCharBrand(BrandPO po){
		return brandDao.listInitCharBrand(po);
	}		
	
	
	/**
	 * 브랜드
	 * 카테고리 트리 
	 */
	@Override 
	@Transactional(readOnly=true)
	public List<DisplayBrandTreeVO> listBrandDisplayTree(BrandSO so) {
		return brandDao.listBrandDisplayTree(so);
	}
	
	/**
	 * 
	* <pre>
	* - 프로젝트명   : 11.business
	* - 패키지명   : biz.app.brand.service
	* - 파일명      : BrandServiceImpl.java
	* - 작성일      : 2017. 2. 16.
	* - 작성자      : valuefctory 권성중
	* - 설명      : 브랜드 전시분류 리스트
	* </pre>
	 */
	@Override
	public List<DisplayBrandTreeVO> listBrandShowDispClsf (Long brandNo ) {
		 
		return brandDao.listBrandShowDispClsf(brandNo );
	}

	
	/**
	 * 브랜드 상품 리스트
	 */
	@Override
	@Transactional(readOnly=true)  
	public List<BrandGoodsVO> listBrandGoods(BrandGoodsSO so) { 
		return brandDao.listBrandGoods(so);
	}
	
	/**
	 * 브랜드 정보 조회
	 */
	@Override
	public BrandBaseVO getBrandDetail(BrandBaseSO so) {
		return brandDao.getBrandDetail(so);
	}
	
	/**
	 * 브랜드 NEW 상품 조회
	 */
	public List<GoodsListVO> listBrandNewGoods(GoodsBaseSO so) {
		return brandDao.listBrandNewGoods(so);
	}
	
	/**
	 * 브랜드 BEST 상품 조회
	 */
	public List<GoodsListVO> listBrandBestGoods(GoodsBaseSO so) {
		return brandDao.listBrandBestGoods(so);
	}
	
	/**
	 * 연관 브랜드 상품 조회(상품상세)
	 */
	public List<GoodsBaseVO> listBrandRelGoods(GoodsBaseSO so) {
		return brandDao.listBrandRelGoods(so);
	}
	
	/**
	 * 브랜드 기획전 조회
	 */
	public List<DisplayBannerVO> listBrandEvent(BrandBaseSO so) {
		return brandDao.listBrandEvent(so);
	}


	@Override
	public List<BrandTop10VO> listIndexTopBrand(Long stId) {
		return brandDao.listIndexTopBrand(stId);		
	}

	/**
	 *
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: DisplayServiceImpl.java
	* - 작성일		: 2017. 3. 20.
	* - 작성자		: hg.jeong
	* - 설명		: 검색 BRAND 초성 목록
	* </pre>
	* @param String
	* @return
	 */		
	@Override
	public List<BrandVO> listBrandChar(BrandPO po){
		return brandDao.listBrandChar(po);
	}		

	
	/**
	 *
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: DisplayServiceImpl.java
	* - 작성일		: 2017. 3. 24.
	* - 작성자		: hg.jeong
	* - 설명		: BRAND 초성 목록
	* </pre>
	* @param String
	* @return
	 */		
	@Override
	public List<CodeDetailVO> listBrandInitChar(){
		return brandDao.listBrandInitChar();
	}
	
	/**
	 *
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: DisplayServiceImpl.java
	* - 작성일		: 2017. 3. 24.
	* - 작성자		: hg.jeong
	* - 설명		: BRAND 목록
	* </pre>
	* @param String
	* @return
	 */		
	@Override
	public List<BrandBaseSO> listBrand(BrandBaseSO so){
		return brandDao.listBrand(so);
	}	
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayServiceImpl.java
	 * - 작성일		: 2017. 05. 30.
	 * - 작성자		: wyjeong
	 * - 설명		: 전시분류별 브랜드 리스트 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	@Override
	public List<DisplayCategoryVO> listBrandByDisplayCategory(BrandSO so) {
		return brandDao.listBrandByDisplayCategory(so);
	}
	
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayServiceImpl.java
	 * - 작성일		: 2017. 06. 01.
	 * - 작성자		: wyjeong
	 * - 설명		: 전시분류별 초성 브랜드 리스트
	 * </pre>
	 * @param so
	 * @return
	 */
	@Override
	public List<BrandInitialVO> listBrandByInitChar(BrandSO so) {
		return brandDao.listBrandByInitChar(so);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayServiceImpl.java
	 * - 작성일		: 2017. 06. 08.
	 * - 작성자		: wyjeong
	 * - 설명		: StyleDCG 브랜드 리스트
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<BrandBaseVO> listBrandByStyle(BrandSO so) {
		return brandDao.listBrandByStyle(so);
	}
	
	@Override
	public int getSameBrandNameCount(BrandSO so) {
		return brandDao.getSameBrandNameCount(so);
	}
}