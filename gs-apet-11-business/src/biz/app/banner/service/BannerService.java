package biz.app.banner.service;

import java.util.List;

import biz.app.banner.model.BannerPO;
import biz.app.banner.model.BannerSO;
import biz.app.banner.model.BannerTagMapPO;
import biz.app.banner.model.BannerTagMapSO;
import biz.app.banner.model.BannerTagMapVO;
import biz.app.banner.model.BannerVO;
import biz.app.tag.model.TagBaseVO;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.banner.service
* - 파일명		: BannerService.java
* - 작성일		: 2016. 4. 15.
* - 작성자		: CJA
* - 설명		: 배너 서비스 Interface
* </pre>
*/
public interface BannerService {

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: BannerService.java
	 * - 작성일		: 2016. 5. 11.
	 * - 작성자		: CJA
	 * - 설명		: 배너 등록
	 * </pre>
	 * @param po
	 * @return
	 */
	public void insertBanner(BannerPO po, BannerTagMapPO tpo, String[] tagNo);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: BannerService.java
	 * - 작성일		: 2016. 5. 11.
	 * - 작성자		: CJA
	 * - 설명		: 배너 ID 체크
	 * </pre>
	 * @param so
	 * @return
	 */
	public int bannerIdCheck(String bnrId);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: BannerService.java
	 * - 작성일		: 2016. 5. 11.
	 * - 작성자		: CJA
	 * - 설명		: 배너 그리드 리스트
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<BannerVO> bannerListGrid(BannerSO so);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: BannerService.java
	 * - 작성일		: 2016. 5. 11.
	 * - 작성자		: CJA
	 * - 설명		: 배너 상세
	 * </pre>
	 * @param so
	 * @return
	 */
	public BannerVO getBanner(BannerSO so);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: BannerService.java
	 * - 작성일		: 2016. 5. 11.
	 * - 작성자		: CJA
	 * - 설명		: 배너 수정
	 * </pre>
	 * @param so
	 * @return
	 */
	public int updateBanner(BannerPO po, BannerTagMapPO tpo, String[] tagNo);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: BannerService.java
	 * - 작성일		: 2016. 5. 11.
	 * - 작성자		: CJA
	 * - 설명		: 배너 삭제
	 * </pre>
	 * @param so
	 * @return
	 */
	public int deleteBanner(BannerPO po);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: BannerService.java
	 * - 작성일		: 2016. 5. 11.
	 * - 작성자		: CJA
	 * - 설명		: 배너 사용여부 수정
	 * </pre>
	 * @param so
	 * @return
	 */
	public int updateUseYn(BannerPO po);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: BannerService.java
	 * - 작성일		: 2016. 5. 11.
	 * - 작성자		: CJA
	 * - 설명		: 배너 페이징
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<BannerVO> pageBanner(BannerSO so);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: BannerService.java
	 * - 작성일		: 2016. 5. 11.
	 * - 작성자		: CJA
	 * - 설명		: 배너 태그 등록
	 * </pre>
	 * @param so
	 * @return
	 */

	public int insertBannerTag(BannerTagMapPO po);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: BannerService.java
	 * - 작성일		: 2016. 5. 11.
	 * - 작성자		: CJA
	 * - 설명		: 배너 태그 수정
	 * </pre>
	 * @param so
	 * @return
	 */

	public int updateBannerTag(BannerTagMapPO po);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: BannerService.java
	 * - 작성일		: 2016. 5. 11.
	 * - 작성자		: CJA
	 * - 설명		: 배너 태그 삭제
	 * </pre>
	 * @param so
	 * @return
	 */
	public int deleteAllBannerTag(BannerTagMapPO po);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: BannerService.java
	 * - 작성일		: 2016. 5. 11.
	 * - 작성자		: CJA
	 * - 설명		: 배너 태그 맵 리스트
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<BannerTagMapVO> getBannerTagList(BannerSO so);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: BannerService.java
	 * - 작성일		: 2016. 5. 11.
	 * - 작성자		: CJA
	 * - 설명		: 배너 베이스 태그
	 * </pre>
	 * @param so
	 * @return
	 */
	public TagBaseVO getTagBase(BannerTagMapSO so);
}