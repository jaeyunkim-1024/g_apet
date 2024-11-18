package biz.app.banner.service;

import java.util.List;
import java.util.Properties;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import biz.app.banner.dao.BannerDao;
import biz.app.banner.model.BannerPO;
import biz.app.banner.model.BannerSO;
import biz.app.banner.model.BannerTagMapPO;
import biz.app.banner.model.BannerTagMapSO;
import biz.app.banner.model.BannerTagMapVO;
import biz.app.banner.model.BannerVO;
import biz.app.tag.model.TagBaseVO;
import biz.common.service.BizService;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import framework.common.util.DateUtil;
import framework.common.util.FileUtil;
import framework.common.util.FtpFileUtil;
import framework.common.util.FtpImgUtil;
import lombok.extern.slf4j.Slf4j;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.banner.service
* - 파일명		: BannerServiceImpl.java
* - 작성일		: 2016. 4. 15.
* - 작성자		: CJA
* - 설명		: 배너 서비스
* </pre>
*/
@Slf4j
@Transactional
@Service("bannerService")
public class BannerServiceImpl implements BannerService {

	@Autowired
	private BannerDao bannerDao;

	@Autowired
	private Properties bizConfig;
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BannerServiceImpl.java
	* - 작성일		: 2016. 6. 2.
	* - 작성자		: CJA
	* - 설명		: 배너 등록
	* </pre>
	* @param po
	* @return
	*/
	@Override
	public void insertBanner(BannerPO po, BannerTagMapPO tpo, String[] tagNo) {
		
		Long bnrNo = bannerDao.getBnrSeq();
		
		po.setBnrNo(bnrNo);
		
		//배너 pc 이미지 등록
		if(po.getBnrImgPath() != null && po.getBnrImgPath() != "") {
			String orgFileStr = po.getBnrImgPath();
			
			FtpImgUtil ftpImgUtil = new FtpImgUtil();
			String filePath = ftpImgUtil.uploadFilePath(orgFileStr, CommonConstants.BANNER_IMAGE_PATH + FileUtil.SEPARATOR + bnrNo);
			ftpImgUtil.upload(orgFileStr, filePath);
			
			po.setBnrImgPath(filePath);
		}
		
		//배너 mo 이미지 등록
		if(po.getBnrMobileImgPath() != null && po.getBnrMobileImgPath() != "") {
			String orgFileStr = po.getBnrMobileImgPath();
			
			FtpImgUtil ftpImgUtil = new FtpImgUtil();
			String filePath = ftpImgUtil.uploadFilePath(orgFileStr, CommonConstants.BANNER_IMAGE_PATH + FileUtil.SEPARATOR + bnrNo);
			ftpImgUtil.upload(orgFileStr, filePath);
			
			po.setBnrMobileImgPath(filePath);
		}
		
		int result = bannerDao.insertBanner(po);
		
		if(result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		} else {
			BannerTagMapPO bpo = new BannerTagMapPO();
			
			if(tagNo != null && tagNo.length > 0) {
				for(int i = 0; i < tagNo.length; i++) {
					bpo.setBnrNo(po.getBnrNo());
					bpo.setTagNo(tagNo[i]);
					
					bannerDao.insertBannerTag(bpo);
				}
			}
		}
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BannerServiceImpl.java
	* - 작성일		: 2016. 6. 2.
	* - 작성자		: CJA
	* - 설명		: 배너 ID 체크
	* </pre>
	* @param bnrId
	* @return
	*/
	@Override
	public int bannerIdCheck(String bnrId) {
		return bannerDao.bannerIdCheck(bnrId);
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BannerServiceImpl.java
	* - 작성일		: 2016. 6. 2.
	* - 작성자		: CJA
	* - 설명		: 배너 그리드 리스트
	* </pre>
	* @param so
	* @return
	*/
	public List<BannerVO> bannerListGrid(BannerSO so) {
		return bannerDao.bannerListGrid(so);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BannerServiceImpl.java
	* - 작성일		: 2016. 6. 2.
	* - 작성자		: CJA
	* - 설명		: 배너 상세
	* </pre>
	* @param so
	* @return
	*/
	@Override
	public BannerVO getBanner(BannerSO so) {
		return bannerDao.getBanner(so);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BannerServiceImpl.java
	* - 작성일		: 2016. 6. 2.
	* - 작성자		: CJA
	* - 설명		: 배너 수정
	* </pre>
	* @param po
	* @return
	*/
	@Override
	public int updateBanner(BannerPO po, BannerTagMapPO tpo, String[] tagNo) {
		
		//배너 pc 이미지 등록
		if(po.getBnrImgPath() != null && po.getBnrImgPath() != "") {
			FtpImgUtil ftpImgUtil = new FtpImgUtil();
			if(po.getBnrImgPath().startsWith(bizConfig.getProperty("common.file.upload.base"))) {
				String orgFileStr = po.getBnrImgPath();
				String filePath = ftpImgUtil.uploadFilePath(orgFileStr, CommonConstants.BANNER_IMAGE_PATH + FileUtil.SEPARATOR + po.getBnrNo());
				ftpImgUtil.upload(orgFileStr, filePath);
				
				po.setBnrImgPath(filePath);
			}
		}
		
		//배너 mo 이미지 등록
		if(po.getBnrMobileImgPath() != null && po.getBnrMobileImgPath() != "") {
			FtpImgUtil ftpImgUtil = new FtpImgUtil();
			if(po.getBnrMobileImgPath().startsWith(bizConfig.getProperty("common.file.upload.base"))) {
				String orgFileStr = po.getBnrMobileImgPath();
				String filePath = ftpImgUtil.uploadFilePath(orgFileStr, CommonConstants.BANNER_IMAGE_PATH + FileUtil.SEPARATOR + po.getBnrNo());
				ftpImgUtil.upload(orgFileStr, filePath);
				
				po.setBnrMobileImgPath(filePath);
			}
		}
		
		int result = bannerDao.updateBanner(po);
		
		if(result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		} else {
			BannerTagMapPO bpo = new BannerTagMapPO();
			
			if(tagNo != null && tagNo.length > 0) {
				bpo.setBnrNo(po.getBnrNo());
				this.deleteAllBannerTag(bpo);
				
				for(int i = 0; i < tagNo.length; i++) {
					bpo.setBnrNo(po.getBnrNo());
					bpo.setTagNo(tagNo[i]);
					
					bannerDao.insertBannerTag(bpo);
				}
			} else {
				bpo.setBnrNo(po.getBnrNo());
				this.deleteAllBannerTag(bpo);
			}
		}
		return result;
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BannerServiceImpl.java
	* - 작성일		: 2016. 6. 2.
	* - 작성자		: CJA
	* - 설명		: 배너 삭제
	* </pre>
	* @param po
	* @return
	*/
	@Override
	public int deleteBanner(BannerPO po) {
		return bannerDao.deleteBanner(po);
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BannerServiceImpl.java
	* - 작성일		: 2016. 6. 2.
	* - 작성자		: CJA
	* - 설명		: 배너 페이지 리스트
	* </pre>
	* @param so
	* @return
	*/
	@Override
	public List<BannerVO> pageBanner(BannerSO so) {
		List<BannerVO> list = bannerDao.pageBanner(so);
		
		return list;
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BannerServiceImpl.java
	* - 작성일		: 2016. 6. 2.
	* - 작성자		: CJA
	* - 설명		: 배너 사용여부 수정
	* </pre>
	* @param po
	* @return
	*/
	@Override
	public int updateUseYn(BannerPO po) {
		return bannerDao.updateUseYn(po);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BannerServiceImpl.java
	* - 작성일		: 2016. 6. 2.
	* - 작성자		: CJA
	* - 설명		: 배너 태그 등록
	* </pre>
	* @param po
	* @return
	*/
	@Override
	public int insertBannerTag(BannerTagMapPO po) {
		return bannerDao.insertBannerTag(po);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BannerServiceImpl.java
	* - 작성일		: 2016. 6. 2.
	* - 작성자		: CJA
	* - 설명		: 배너 태그 수정
	* </pre>
	* @param po
	* @return
	*/
	@Override
	public int updateBannerTag(BannerTagMapPO po) {
		return bannerDao.updateBannerTag(po);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BannerServiceImpl.java
	* - 작성일		: 2016. 6. 2.
	* - 작성자		: CJA
	* - 설명		: 배너 태그 삭제
	* </pre>
	* @param po
	* @return
	*/
	@Override
	public int deleteAllBannerTag(BannerTagMapPO po) {
		return bannerDao.deleteAllBannerTag(po);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BannerServiceImpl.java
	* - 작성일		: 2016. 6. 2.
	* - 작성자		: CJA
	* - 설명		: 배너 태그 맵 리스트
	* </pre>
	* @param po
	* @return
	*/
	@Override
	public List<BannerTagMapVO> getBannerTagList(BannerSO so) {
		return bannerDao.getBannerTagList(so);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BannerServiceImpl.java
	* - 작성일		: 2016. 6. 2.
	* - 작성자		: CJA
	* - 설명		: 배너 베이스 태그
	* </pre>
	* @param po
	* @return
	*/
	@Override
	public TagBaseVO getTagBase(BannerTagMapSO so) {
		return bannerDao.getTagBase(so);
	}
	
}