package biz.app.mobileapp.service;

import java.util.List;
import java.util.Properties;

import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import biz.app.mobileapp.dao.MobileSplashDao;
import biz.app.mobileapp.model.MobileSplashPO;
import biz.app.mobileapp.model.MobileSplashSO;
import biz.app.mobileapp.model.MobileSplashVO;
import framework.admin.constants.AdminConstants;
import framework.common.constants.CommonConstants;
import framework.common.util.DateUtil;
import framework.common.util.FileUtil;
import framework.common.util.FtpImgUtil;
import framework.common.util.StringUtil;
import lombok.extern.slf4j.Slf4j;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.mobileapp.service
* - 파일명		: MobileVersionServiceImpl.java
* - 작성일		: 2017. 05. 11.
* - 작성자		: wyjeong
* - 설명		: 모바일 앱 버전 서비스
* </pre>
*/
@Slf4j
@Service
@Transactional
public class MobileSplashServiceImpl implements MobileSplashService {
	@Autowired private MobileSplashDao mobileSplashDao;
	
	@Autowired
	private Properties 	bizConfig;
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MobileSplashServiceImpl.java
	 * - 작성일		: 2017. 08. 14.
	 * - 작성자		: wyjeong
	 * - 설명		: Splash 페이지 목록 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	@Override
	public List<MobileSplashVO> pageMobileSplash(MobileSplashSO so) {
		return mobileSplashDao.pageMobileSplash(so);
	}
	
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MobileSplashServiceImpl.java
	 * - 작성일		: 2017. 08. 14.
	 * - 작성자		: wyjeong
	 * - 설명		: Splash 정보 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	@Override
	public MobileSplashVO getMobileSplash(MobileSplashSO so) {
		return mobileSplashDao.getMobileSplash(so);
	}
	
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MobileSplashServiceImpl.java
	 * - 작성일		: 2017. 08. 14.
	 * - 작성자		: wyjeong
	 * - 설명		: Splash 등록
	 * </pre>
	 * @param po
	 * @return
	 */
	@Override
	public int insertMobileSplash(MobileSplashPO po) {
		String realImgPath = "";
		if (StringUtil.isNotEmpty(po.getFilePath())) {
			realImgPath = imgUpload(po.getFilePath());
			
			if (log.isDebugEnabled()) {
				log.debug("#################### realImgPath : " + realImgPath);
			}
			String scheme = "https://";
			if (bizConfig.getProperty("image.domain").contains("dev")) {
				scheme = "http://";
			}
			po.setLink(scheme + bizConfig.getProperty("image.domain") + realImgPath);
		}
		
		if (po.getStatus() == 1) {
			mobileSplashDao.updatePrevSplash(po);
		}
		
		return mobileSplashDao.insertMobileSplash(po);
	}
	
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MobileSplashServiceImpl.java
	 * - 작성일		: 2017. 08. 14.
	 * - 작성자		: wyjeong
	 * - 설명		: Splash 수정
	 * </pre>
	 * @param so
	 * @return
	 */
	@Override
	public int updateMobileSplash(MobileSplashPO po) {
		
		MobileSplashVO vo = mobileSplashDao.getMobileSplash(new MobileSplashSO(po.getSplashNo()));
		String prevLink = vo.getLink();
		String prevLinkType = vo.getLinkType();
		
		String scheme = "https://";
		if (bizConfig.getProperty("image.domain").contains("dev")) {
			scheme = "http://";
		}
		String imgDomain = scheme + bizConfig.getProperty("image.domain");
		
		String realImgPath = "";
		
		// Image Type -> Link URL로 변경되었을 때 기존 이미지 삭제
		if (po.getLinkType().equals(CommonConstants.APP_SPLASH_TP_L) && prevLinkType.equals(CommonConstants.APP_SPLASH_TP_I)
				&& !po.getLink().equals(prevLink)) {
			try {
				prevLink = prevLink.substring(imgDomain.length(), prevLink.length());
				imgDelete(prevLink);
			} catch (Exception e) {
				log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
			}
		}
		// Link URL -> Image Type 로 변경되었을 때 이미지 업로드
		if (po.getLinkType().equals(CommonConstants.APP_SPLASH_TP_I) && prevLinkType.equals(CommonConstants.APP_SPLASH_TP_L)
				&& StringUtil.isNotEmpty(po.getFilePath())) {
			realImgPath = imgUpload(po.getFilePath());
			po.setLink(scheme + bizConfig.getProperty("image.domain") + realImgPath);
		}
		// Image Type -> Image Type 로 변경되었을 때 이미지 수정
		if (po.getLinkType().equals(CommonConstants.APP_SPLASH_TP_I) && prevLinkType.equals(CommonConstants.APP_SPLASH_TP_I)) {
			// 이미지 수정 없음
			//보안 진단. 불필요한 코드 (비어있는 IF문)
			/*if (StringUtil.isEmpty(po.getFilePath()) && StringUtil.isNotEmpty(po.getLink())) {	
				
			} 
			// 이미지 수정
			else*/ if (StringUtil.isNotEmpty(po.getFilePath())) {	// 이미지 수정
				try {
					prevLink = prevLink.substring(imgDomain.length(), prevLink.length());
					imgDelete(prevLink);
				} catch (Exception e) {
					log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
				}
				
				realImgPath = imgUpload(po.getFilePath());
				po.setLink(scheme + bizConfig.getProperty("image.domain") + realImgPath);
			}
		}	
			
		if (po.getStatus() == 1) {
			mobileSplashDao.updatePrevSplash(po);
		}
		
		return mobileSplashDao.updateMobileSplash(po);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MobileSplashServiceImpl.java
	 * - 작성일		: 2017. 08. 14.
	 * - 작성자		: wyjeong
	 * - 설명		: Splash 이미지 업로드
	 * </pre>
	 * 
	 * @param imgPath
	 * @return
	 */
	private String imgUpload(String imgPath) {
		FtpImgUtil ftpImgUtil = new FtpImgUtil();
		
		String adminConstantsPath = AdminConstants.SPLASH_IMAGE_PATH;
		String ext = FilenameUtils.getExtension(imgPath);
		
		String filename = DateUtil.calDate("yyyyMMddhhmmssSSS");
		String realImgPath = adminConstantsPath + FileUtil.SEPARATOR + filename+ "." + ext;
		ftpImgUtil.upload(imgPath, realImgPath);
		
		return realImgPath;
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MobileSplashServiceImpl.java
	 * - 작성일		: 2017. 08. 14.
	 * - 작성자		: wyjeong
	 * - 설명		: Splash 이미지 삭제
	 * </pre>
	 * 
	 * @param imgPath
	 * @return
	 */
	private void imgDelete(String imgPath) {
		FtpImgUtil ftpImgUtil = new FtpImgUtil();
		ftpImgUtil.delete(imgPath);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MobileSplashServiceImpl.java
	 * - 작성일		: updateMobileSplash
	 * - 작성자		: wyjeong
	 * - 설명		: Splash 삭제
	 * </pre>
	 * @param so
	 * @return
	 */
	@Override
	public int deleteMobileSplash(MobileSplashPO po) {
		String scheme = "https://";
		if (bizConfig.getProperty("image.domain").contains("dev")) {
			scheme = "http://";
		}
		String imgDomain = scheme + bizConfig.getProperty("image.domain");
		
		// Image Type 이면 이미지 파일 삭제
		if (po.getLinkType().equals(CommonConstants.APP_SPLASH_TP_I)) {
			try {
				String link = po.getLink();
				link = link.substring(imgDomain.length(), link.length());
				imgDelete(link);
				
			imgDelete(po.getLink());
			} catch (Exception e) {
				log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
			}
		}
		
		return mobileSplashDao.deleteMobileSplash(po);
	}
	
}
