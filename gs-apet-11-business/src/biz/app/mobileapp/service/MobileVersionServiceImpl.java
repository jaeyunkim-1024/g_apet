package biz.app.mobileapp.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import biz.app.mobileapp.dao.MobileVersionDao;
import biz.app.mobileapp.model.MobileVersionAppVO;
import biz.app.mobileapp.model.MobileVersionPO;
import biz.app.mobileapp.model.MobileVersionSO;
import biz.app.mobileapp.model.MobileVersionVO;
import lombok.extern.slf4j.Slf4j;

/**
 * <pre>
 * - 프로젝트명	: 11.business
 * - 패키지명		: biz.app.mobileapp.service
 * - 파일명		: MobileVersionServiceImpl.java
 * - 작성일		: 2017. 05. 11.
 * - 작성자		: wyjeong
 * - 설명			: APP 버전관리 서비스
 * </pre>
 */
@Slf4j
@Service
@Transactional
public class MobileVersionServiceImpl implements MobileVersionService {
	@Autowired private MobileVersionDao mobileVersionDao;
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MobileVersionServiceImpl.java
	 * - 작성일		: 2017. 05. 11.
	 * - 작성자		: wyjeong
	 * - 설명			: APP 버전관리 페이지 목록 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	@Override
	public List<MobileVersionVO> pageMobileVersion(MobileVersionSO so) {
		return mobileVersionDao.pageMobileVersion(so);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MobileVersionServiceImpl.java
	 * - 작성일		: 2017. 05. 11.
	 * - 작성자		: wyjeong
	 * - 설명			: APP 버전관리 정보 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	@Override
	public MobileVersionVO getMobileVersion(MobileVersionSO so) {
		return mobileVersionDao.getMobileVersion(so);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MobileVersionServiceImpl.java
	 * - 작성일		: 2017. 05. 11.
	 * - 작성자		: wyjeong
	 * - 설명			: APP 버전관리 앱 버전 존재여부 체크
	 * </pre>
	 * @param so
	 * @return
	 */
	@Override
	public Integer checkMobileVersion(MobileVersionSO so) {
		return mobileVersionDao.checkMobileVersion(so);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MobileVersionServiceImpl.java
	 * - 작성일		: 2017. 05. 11.
	 * - 작성자		: wyjeong
	 * - 설명			: APP 버전관리 등록
	 * </pre>
	 * @param so
	 * @return
	 */
	@Override
	public int insertMobileVersion(MobileVersionPO po) {
		int rsltCnt = mobileVersionDao.insertMobileVersion(po);
		
		if(rsltCnt > 0) {
			mobileVersionDao.updateBeforeVersionMarketRegDtmToday(po);
		}
		
		return rsltCnt; 
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MobileVersionServiceImpl.java
	 * - 작성일		: 2017. 05. 11.
	 * - 작성자		: wyjeong
	 * - 설명			: APP 버전관리 수정
	 * </pre>
	 * @param so
	 * @return
	 */
	@Override
	public int updateMobileVersion(MobileVersionPO po) {
		return mobileVersionDao.updateMobileVersion(po);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MobileVersionServiceImpl.java
	 * - 작성일		: 2017. 05. 11.
	 * - 작성자		: wyjeong
	 * - 설명			: APP 버전관리 삭제
	 * </pre>
	 * @param so
	 * @return
	 */
	@Override
	public int deleteMobileVersion(MobileVersionPO po) {
		return mobileVersionDao.deleteMobileVersion(po);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MobileVersionServiceImpl.java
	 * - 작성일		: 2017. 05. 16.
	 * - 작성자		: wyjeong
	 * - 설명			: APP 버전관리 정보 목록 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	@Override
	public List<MobileVersionVO> listAppVersion(MobileVersionSO so) {
		return mobileVersionDao.listAppVersion(so);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MobileVersionServiceImpl.java
	 * - 작성일		: 2017. 05. 11.
	 * - 작성자		: DSLEE
	 * - 설명			: APP 최신버전 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public MobileVersionAppVO selectNewMobileVersionInfo(MobileVersionSO so) {
		return mobileVersionDao.selectNewMobileVersionInfo(so);
	}
	
}