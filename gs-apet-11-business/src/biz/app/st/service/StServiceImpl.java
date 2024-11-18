package biz.app.st.service;

import java.util.List;
import java.util.Objects;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import biz.app.company.dao.CompanyDao;
import biz.app.st.dao.StDao;
import biz.app.st.model.StPolicyPO;
import biz.app.st.model.StPolicySO;
import biz.app.st.model.StPolicyVO;
import biz.app.st.model.StStdInfoPO;
import biz.app.st.model.StStdInfoSO;
import biz.app.st.model.StStdInfoVO;
import biz.common.dao.BizDao;
import biz.common.service.BizService;
import framework.admin.constants.AdminConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import framework.common.util.FileUtil;
import framework.common.util.FtpImgUtil;
import framework.common.util.StringUtil;
import lombok.extern.slf4j.Slf4j;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.st.service
* - 파일명		: stServiceImpl.java
* - 작성일		: 2017. 1. 2.
* - 작성자		: hongjun
* - 설명		: 사이트 서비스
* </pre>
*/
@Slf4j
@Transactional
@Service("stService")
public class StServiceImpl implements StService {

	@Autowired
	private StDao stDao;

	@Autowired
	private BizDao bizDao;

	@Autowired
	private CompanyDao companyDao;

	@Autowired
	private BizService bizService;
	/*
	 * 사이트 목록 조회
	 * @see biz.app.st.service.StService#listStStdInfo(biz.app.st.model.StStdInfoSO)
	 */
	@Override
	public List<StStdInfoVO> listStStdInfo(StStdInfoSO so) {
		return stDao.listStStdInfo(so);
	}

	@Override
	public Long insertSt (StStdInfoPO stStdInfoPO) {
		if(log.isDebugEnabled() ) {
			log.debug("########## : " + "insertst" );
		}

		Long stId = null;

		if(log.isDebugEnabled() ) {
			log.debug("#################### : " + "사이트 등록" );
		}

		if(stStdInfoPO != null ) {
			String realImgPath = null;
			stId = bizDao.getSequence(AdminConstants.SEQUENCE_ST_STD_INFO_SEQ );
			stStdInfoPO.setStId(stId);

			if(log.isDebugEnabled() ) {
				log.debug("########## stId : {}", stId );
			}

			if(!StringUtil.isEmpty(stStdInfoPO.getLogoImgPath() ) ) {
				realImgPath = logoImageUpload (stStdInfoPO );
				if(log.isDebugEnabled() ) {
					log.debug("#################### realImgPath : " + realImgPath );
				}
				stStdInfoPO.setLogoImgPath(realImgPath );
			}

			// 사이트 기본 정보 등록
			stDao.insertStStdInfo(stStdInfoPO );

			// 사이트 매핑 정보 등록(0번 업체 - 시스템 관리자), 신규 사이트 등록 반드시 0번으로 매핑해서 등록해야 함.
			companyDao.insertStCompanyMap(stStdInfoPO);
		}

		return stId;
	}


	@Override
	public StStdInfoVO getStStdInfo (Long stId ) {
		return stDao.getStStdInfo(stId );
	}


	@Override
	public List<StStdInfoVO> pageStStdInfo (StStdInfoSO so ) {
		return stDao.pageStStdInfo(so );
	}


	@Override
	public Long updateSt (StStdInfoPO stStdInfoPO, String orgLogoImgPath) {
		if(log.isDebugEnabled() ) {
			log.debug("########## : " + "updateSt" );
		}
		Long stId = stStdInfoPO.getStId();

		if(!Objects.isNull(stStdInfoPO)) {
			String realImgPath = null;
			StStdInfoVO vo = stDao.getStStdInfo(stId);

			if(StringUtil.isEmpty(stStdInfoPO.getLogoImgPath()) && StringUtil.isNotEmpty(orgLogoImgPath)) {	// 이미지 수정 없음
				stStdInfoPO.setLogoImgPath(orgLogoImgPath );
			} else if (StringUtil.isEmpty(stStdInfoPO.getLogoImgPath()) && StringUtil.isEmpty(orgLogoImgPath)) {	// 이미지 삭제
				if(StringUtil.isNotBlank(vo.getLogoImgPath())){
					logoImageDelete(vo.getLogoImgPath());
					stStdInfoPO.setLogoImgPath(null );
				}
			} else if (!StringUtil.isEmpty(stStdInfoPO.getLogoImgPath())) {	// 이미지 수정
				realImgPath = logoImageUpload (stStdInfoPO );
				stStdInfoPO.setLogoImgPath(realImgPath );
			}

			stDao.updateStStdInfo(stStdInfoPO );
		}

		return stId;
	}


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: stServiceImpl.java
	* - 작성일		: 2017. 1. 4.
	* - 작성자		: hongjun
	* - 설명			: 로고 이미지 등록
	* </pre>
	* @param stStdInfoPO
	* @return
	*/
	public String logoImageUpload (StStdInfoPO stStdInfoPO ) {
		FtpImgUtil ftpImgUtil = new FtpImgUtil();
		//String ext = null;
		String realImgPath = null;
		
		//ext = FilenameUtils.getExtension(stStdInfoPO.getLogoImgPath() );
		realImgPath =  ftpImgUtil.uploadFilePath(stStdInfoPO.getLogoImgPath(), AdminConstants.ST_IMAGE_PATH + FileUtil.SEPARATOR + String.valueOf(stStdInfoPO.getStId()));
		if(log.isDebugEnabled() ) {
			log.debug("#################### realImgPath : " + realImgPath );
		}

		ftpImgUtil.upload(stStdInfoPO.getLogoImgPath(), realImgPath );
		return realImgPath;
	}


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: stServiceImpl.java
	* - 작성일		: 2017. 1. 4.
	* - 작성자		: hongjun
	* - 설명			: 로고 이미지 삭제
	* </pre>
	* @param orgLogoImgPath
	*/
	public void logoImageDelete (String orgLogoImgPath ) {
		FtpImgUtil ftpImgUtil = new FtpImgUtil();

		if(log.isDebugEnabled() ) {
			log.debug("#################### brandImageDelete : ");
		}

		ftpImgUtil.delete(orgLogoImgPath );
	}

	@Override
	public List<StStdInfoVO> getStList(StStdInfoSO so){
		return stDao.getStList(so);
	}


	/**
	 *
	* <pre>
	* - 프로젝트명   : 11.business
	* - 패키지명   : biz.app.st.service
	* - 파일명      : StServiceImpl.java
	* - 작성일      : 2017. 4. 24.
	* - 작성자      : valuefactory 권성중
	* - 설명      :홈 > 시스템 관리 > 사이트 관리 > 사이트 목록   > 사이트 상세 > 사이트 정책 목록
	* </pre>
	 */
	@Override
	@Transactional(readOnly=true)
	public List<StPolicyVO> listStPolicy(StPolicySO so) {
		return stDao.listStPolicy(so);
	}
	/**
	 *
	* <pre>
	* - 프로젝트명   : 11.business
	* - 패키지명   : biz.app.st.service
	* - 파일명      : StServiceImpl.java
	* - 작성일      : 2017. 4. 25.
	* - 작성자      : valuefactory 권성중
	* - 설명      :사이트 정책 등록 팝업
	* </pre>
	 */
	@Override
	public StPolicyVO getStPolicy(StPolicySO so) {
		return stDao.getStPolicy(so);
	}
	/**
	 *
	* <pre>
	* - 프로젝트명   : 11.business
	* - 패키지명   : biz.app.st.service
	* - 파일명      : StServiceImpl.java
	* - 작성일      : 2017. 4. 25.
	* - 작성자      : valuefactory 권성중
	* - 설명      :사이트 정책 저장
	* </pre>
	 */
	@Override
	public void stPolicySave(StPolicyPO po) {

		StPolicySO so = new StPolicySO();
		so.setStPlcNo(po.getStPlcNo());
		StPolicyVO vo = stDao.getStPolicy(so);

		int result = 0;

		if(vo != null) {
			result = stDao.updateStPolicy(po);
		} else {
			po.setStPlcNo(bizService.getSequence(AdminConstants.SEQUENCE_ST_POLICY_SEQ));

			result = stDao.insertStPolicy(po);
		}

		if(result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
	}
	/**
	 *
	* <pre>
	* - 프로젝트명   : 11.business
	* - 패키지명   : biz.app.st.service
	* - 파일명      : StServiceImpl.java
	* - 작성일      : 2017. 4. 25.
	* - 작성자      : valuefactory 권성중
	* - 설명      :사이트 정책 삭제
	* </pre>
	 */
	@Override
	public void stPolicyDelete(StPolicySO so) {
		int result = 0;
		if(so.getArrStPlcNo() != null && so.getArrStPlcNo().length > 0){
			for(Long stPlcNo : so.getArrStPlcNo()) {
				StPolicySO sso = new StPolicySO();
				sso.setStPlcNo(stPlcNo);
				StPolicyVO vo = stDao.getStPolicy(sso);
				if(vo != null) {
					result = stDao.stPolicyDelete(sso);
					if(result == 0) {
						throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
					}
				}
			}
		}
	}





}