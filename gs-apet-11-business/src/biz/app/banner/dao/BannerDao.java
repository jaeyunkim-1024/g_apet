package biz.app.banner.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import biz.app.banner.model.BannerPO;
import biz.app.banner.model.BannerSO;
import biz.app.banner.model.BannerTagMapPO;
import biz.app.banner.model.BannerTagMapSO;
import biz.app.banner.model.BannerTagMapVO;
import biz.app.banner.model.BannerVO;
import biz.app.tag.model.TagBaseVO;
import framework.common.dao.MainAbstractDao;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.banner.dao
* - 파일명		: BanneDao.java
* - 작성일		: 2016. 4. 14.
* - 작성자		: CJA
* - 설명		: 배너 DAO
* </pre>
*/
@Repository
public class BannerDao extends MainAbstractDao {

	private static final String BASE_DAO_PACKAGE = "banner.";
	
	/**
	 * <pre>
	 * - Method 명	: insertBanner
	 * - 작성일		: 2020. 04. 07.
	 * - 작성자		: CJA
	 * - 설명		: 배너 등록
	 * </pre>
	 * @param po
	 * @return
	 */
	public int insertBanner(BannerPO po) {
		return insert(BASE_DAO_PACKAGE + "insertBanner", po);
	}
	
	/**
	 * <pre>
	 * - Method 명	: insertBanner
	 * - 작성일		: 2020. 04. 07.
	 * - 작성자		: CJA
	 * - 설명		: 배너 sequence
	 * </pre>
	 * @param po
	 * @return
	 */
	public Long getBnrSeq() {
		return selectOne(BASE_DAO_PACKAGE + "getBnrSeq");
	}
	
	/**
	 * <pre>
	 * - Method 명	: bannerIdCheck
	 * - 작성일		: 2020. 5. 27.
	 * - 작성자		: CJA
	 * - 설 명		: 배너 ID 중복 체크
	 * </pre>
	 *
	 * @param po
	 * @return
	 */
	public int bannerIdCheck(String bnrId) {
		return selectOne(BASE_DAO_PACKAGE + "bannerIdCheck", bnrId);
	}
	
	/**
	 * <pre>
	 * - Method 명	: bannerListGrid
	 * - 작성일		: 2020.04.07.
	 * - 작성자		: CJA
	 * - 설명		: 배너 리스트 그리드 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<BannerVO> bannerListGrid(BannerSO so){
		return selectListPage(BASE_DAO_PACKAGE + "bannerListGrid", so);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - Method 명	: getBanner
	 * - 작성일		: 2016. 3. 21.
	 * - 작성자		: CJA
	 * - 설명		: 배너 상세
	 * </pre>
	 * @param so
	 * @return
	 */
	public BannerVO getBanner(BannerSO so) {
		return selectOne(BASE_DAO_PACKAGE + "getBanner", so);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - Method 명	: updateBanner
	 * - 작성일		: 2016. 3. 21.
	 * - 작성자		: CJA
	 * - 설명		: 배너 수정
	 * </pre>
	 * @param so
	 * @return
	 */
	public int updateBanner(BannerPO po) {
		return update(BASE_DAO_PACKAGE + "updateBanner", po);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - Method 명	: deleteBanner
	 * - 작성일		: 2016. 3. 21.
	 * - 작성자		: CJA
	 * - 설명		: 배너 삭제
	 * </pre>
	 * @param so
	 * @return
	 */
	public int deleteBanner(BannerPO po) {
		return delete(BASE_DAO_PACKAGE + "deleteBanner", po);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - Method 명	: useYnChange
	 * - 작성일		: 2016. 3. 21.
	 * - 작성자		: CJA
	 * - 설명		: 배너 사용여부 수정
	 * </pre>
	 * @param so
	 * @return
	 */
	public int updateUseYn(BannerPO po) {
		return update(BASE_DAO_PACKAGE + "updateUseYn", po);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - Method 명	: pageBanner
	 * - 작성일		: 2016. 3. 21.
	 * - 작성자		: CJA
	 * - 설명		: 배너 페이지 리스트
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<BannerVO> pageBanner(BannerSO so) {
		return selectListPage(BASE_DAO_PACKAGE + "pageBanner", so);
	}
	
	/**
	 * <pre>
	 * - Method 명	: insertBannerTag
	 * - 작성일		: 2020. 04. 07.
	 * - 작성자		: CJA
	 * - 설명		: 배너 태그 등록
	 * </pre>
	 * @param po
	 * @return
	 */
	public int insertBannerTag(BannerTagMapPO po) {
		return insert(BASE_DAO_PACKAGE + "insertBannerTag", po);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - Method 명	: updateBannerTag
	 * - 작성일		: 2016. 3. 21.
	 * - 작성자		: CJA
	 * - 설명		: 배너 태그 수정
	 * </pre>
	 * @param so
	 * @return
	 */
	public int updateBannerTag(BannerTagMapPO po) {
		return update(BASE_DAO_PACKAGE + "updateBannerTag", po);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - Method 명	: deleteAllBannerTag
	 * - 작성일		: 2016. 3. 21.
	 * - 작성자		: CJA
	 * - 설명		: 배너 태그 삭제
	 * </pre>
	 * @param so
	 * @return
	 */
	public int deleteAllBannerTag(BannerTagMapPO po) {
		return delete(BASE_DAO_PACKAGE + "deleteAllBannerTag", po);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - Method 명	: getBannerTagList
	 * - 작성일		: 2016. 3. 21.
	 * - 작성자		: CJA
	 * - 설명		: 배너 태그 맵 리스트
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<BannerTagMapVO> getBannerTagList(BannerSO so) {
		return selectList(BASE_DAO_PACKAGE + "getBannerTagList", so);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - Method 명	: getTagBase
	 * - 작성일		: 2016. 3. 21.
	 * - 작성자		: CJA
	 * - 설명		: 배너 베이스 태그 불러오기
	 * </pre>
	 * @param so
	 * @return
	 */
	public TagBaseVO getTagBase(BannerTagMapSO so) {
		return selectOne(BASE_DAO_PACKAGE + "getTagBase", so);
	}
	
	public Long getMaxImageSequence (Long bnrNo){
		return this.selectOne(BASE_DAO_PACKAGE + "getMaxImageSequence", bnrNo);
	}
}