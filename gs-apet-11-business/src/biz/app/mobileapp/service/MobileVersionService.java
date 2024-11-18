package biz.app.mobileapp.service;

import java.util.List;

import biz.app.mobileapp.model.MobileVersionAppVO;
import biz.app.mobileapp.model.MobileVersionPO;
import biz.app.mobileapp.model.MobileVersionSO;
import biz.app.mobileapp.model.MobileVersionVO;

/**
 * <pre>
 * - 프로젝트명	: 11.business
 * - 패키지명		: biz.app.mobileapp.service
 * - 파일명		: MobileVersionService.java
 * - 작성일		: 2017. 05. 11.
 * - 작성자		: wyjeong
 * - 설명			: APP 버전관리 서비스 interface
 * </pre>
 */
public interface MobileVersionService {
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MobileVersionService.java
	 * - 작성일		: 2017. 05. 11.
	 * - 작성자		: wyjeong
	 * - 설명			: APP 버전관리 페이지 목록 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<MobileVersionVO> pageMobileVersion(MobileVersionSO so);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MobileVersionService.java
	 * - 작성일		: 2017. 05. 11.
	 * - 작성자		: wyjeong
	 * - 설명			: APP 버전관리 정보 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public MobileVersionVO getMobileVersion(MobileVersionSO so);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MobileVersionService.java
	 * - 작성일		: 2017. 05. 11.
	 * - 작성자		: wyjeong
	 * - 설명			: APP 버전관리 앱 버전 존재여부 체크
	 * </pre>
	 * @param so
	 * @return
	 */
	public Integer checkMobileVersion(MobileVersionSO so);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MobileVersionService.java
	 * - 작성일		: 2017. 05. 11.
	 * - 작성자		: wyjeong
	 * - 설명			: APP 버전관리 등록
	 * </pre>
	 * @param so
	 * @return
	 */
	public int insertMobileVersion(MobileVersionPO po);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MobileVersionService.java
	 * - 작성일		: 2017. 05. 11.
	 * - 작성자		: wyjeong
	 * - 설명			: APP 버전관리 수정
	 * </pre>
	 * @param so
	 * @return
	 */
	public int updateMobileVersion(MobileVersionPO po);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MobileVersionService.java
	 * - 작성일		: 2017. 05. 11.
	 * - 작성자		: wyjeong
	 * - 설명			: APP 버전관리 삭제
	 * </pre>
	 * @param so
	 * @return
	 */
	public int deleteMobileVersion(MobileVersionPO po);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MobileVersionService.java
	 * - 작성일		: 2017. 05. 16.
	 * - 작성자		: wyjeong
	 * - 설명			: APP 버전관리 정보 목록 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<MobileVersionVO> listAppVersion(MobileVersionSO so);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MobileVersionService.java
	 * - 작성일		: 2017. 05. 11.
	 * - 작성자		: DSLEE
	 * - 설명			: APP 최신버전 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public MobileVersionAppVO selectNewMobileVersionInfo(MobileVersionSO so);
	
}