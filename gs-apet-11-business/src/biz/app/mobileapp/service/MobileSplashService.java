package biz.app.mobileapp.service;

import java.util.List;

import biz.app.mobileapp.model.MobileSplashPO;
import biz.app.mobileapp.model.MobileSplashSO;
import biz.app.mobileapp.model.MobileSplashVO;


/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.mobileapp.service
* - 파일명		: MobileSplashService.java
* - 작성일		: 2017. 08. 14.
* - 작성자		: wyjeong
* - 설명		: 모바일 앱 Splash 서비스 interface
* </pre>
*/
public interface MobileSplashService {
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MobileSplashService.java
	 * - 작성일		: 2017. 08. 14.
	 * - 작성자		: wyjeong
	 * - 설명		: Splash 페이지 목록 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<MobileSplashVO> pageMobileSplash(MobileSplashSO so);
	
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MobileSplashService.java
	 * - 작성일		: 2017. 08. 14.
	 * - 작성자		: wyjeong
	 * - 설명		: Splash 정보 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public MobileSplashVO getMobileSplash(MobileSplashSO so);
	
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MobileSplashService.java
	 * - 작성일		: 2017. 08. 14.
	 * - 작성자		: wyjeong
	 * - 설명		: Splash 등록
	 * </pre>
	 * @param po
	 * @return
	 */
	public int insertMobileSplash(MobileSplashPO po);
	
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MobileSplashService.java
	 * - 작성일		: 2017. 08. 14.
	 * - 작성자		: wyjeong
	 * - 설명		: Splash 수정
	 * </pre>
	 * @param so
	 * @return
	 */
	public int updateMobileSplash(MobileSplashPO po);
	
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MobileSplashService.java
	 * - 작성일		: updateMobileSplash
	 * - 작성자		: wyjeong
	 * - 설명		: Splash 삭제
	 * </pre>
	 * @param so
	 * @return
	 */
	public int deleteMobileSplash(MobileSplashPO po);
}
