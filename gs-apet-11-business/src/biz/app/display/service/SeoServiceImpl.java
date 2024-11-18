package biz.app.display.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import biz.app.display.dao.SeoDao;
import biz.app.display.model.SeoInfoPO;
import biz.app.display.model.SeoInfoSO;
import biz.app.display.model.SeoInfoVO;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import framework.common.util.StringUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@Transactional
public class SeoServiceImpl implements SeoService {

	@Autowired
	private SeoDao seoDao;

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayService.java
	 * - 작성일		: 2020. 12. 15
	 * - 작성자		: valueFactory
	 * - 설명		: SEO 정보 조회
	 * </pre>
	 * @param so
	 * @param SeoInfoVO
	 * @return
	 */
	@Override
	public SeoInfoVO getSeoInfo(SeoInfoSO so) {
		return seoDao.getSeoInfo(so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayService.java
	 * - 작성일		: 2020. 12. 15
	 * - 작성자		: valueFactory
	 * - 설명		: SEO 정보 등록/수정
	 * </pre>
	 * @param so
	 * @param SeoInfoVO
	 * @return
	 */
	@Override
	public int saveSeoInfo(SeoInfoPO po) {
		int result = 0;

		if (po.getSeoInfoNo() != null) {
			result = seoDao.updateSeoInfo(po);
		} else {
			result = seoDao.insertSeoInfo(po);
		}
		if (result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

		return result;
	}
	
	@Override
	@Transactional(readOnly = true, isolation = Isolation.READ_UNCOMMITTED, propagation = Propagation.SUPPORTS)
	public SeoInfoVO getSeoInfoFO(SeoInfoSO seoSO, boolean secretYn) {
		
		SeoInfoVO seoVO = new SeoInfoVO();
		
		if(StringUtil.isEmpty(seoSO.getSeoInfoNo()) && (StringUtil.isEmpty(seoSO.getSeoTpCd()) || StringUtil.equals(CommonConstants.SEO_TP_10, seoSO.getSeoTpCd()))) {	// 공통
			seoSO.setSeoTpCd(CommonConstants.SEO_TP_10);
			seoSO.setDftSetYn(CommonConstants.DFT_YN_Y);
			seoVO = seoDao.getSeoInfo(seoSO);
		} else if(StringUtil.isEmpty(seoSO.getSeoInfoNo())) {	// 유형
			seoSO.setDftSetYn(CommonConstants.DFT_YN_Y);
			seoVO = seoDao.getSeoInfo(seoSO);
		} else if(!StringUtil.isEmpty(seoSO.getSeoInfoNo())) { // 개별
			seoVO = seoDao.getSeoInfo(seoSO);
		}
		
		// 개인정보보호 여부
		if(secretYn) {
			SeoInfoVO secretSeoVO = new SeoInfoVO();
			secretSeoVO.setPageTtl(seoVO.getPageTtl());
			return secretSeoVO;
		} else {
			return seoVO;
		}
	}

}
