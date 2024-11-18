package biz.app.member.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import biz.app.member.model.MemberInterestBrandPO;
import biz.app.member.model.MemberInterestBrandSO;
import biz.app.member.model.MemberInterestBrandVO;
import biz.app.member.model.MemberInterestGoodsSO;
import framework.common.dao.MainAbstractDao;


/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.member.dao
* - 파일명		: MemberInterestBrandDao.java
* - 작성일		: 2017. 02. 13.
* - 작성자		: wyjeong
* - 설명		: 회원 관심 브랜드 DAO
* </pre>
*/
@Repository
public class MemberInterestBrandDao extends MainAbstractDao {

	private static final String BASE_DAO_PACKAGE = "memberInterestBrand.";

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MemberInterestBrandDao.java
	 * - 작성일		: 2017. 02. 13.
	 * - 작성자		: wyjeong
	 * - 설명		: 회원관심브랜드 단건 조회
	 * </pre>
	 *
	 * @param so
	 * @return
	 */
	public MemberInterestBrandVO getMemberInterestBrand(MemberInterestBrandSO so) {
		return selectOne(BASE_DAO_PACKAGE + "getMemberInterestBrand", so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MemberInterestBrandDao.java
	 * - 작성일		: 2017. 02. 13.
	 * - 작성자		: wyjeong
	 * - 설명		: 회원 관심 브랜드 등록
	 * </pre>
	 *
	 * @param po
	 * @return
	 */
	public int insertMemberInterestBrand(MemberInterestBrandPO po) {
		return insert(BASE_DAO_PACKAGE + "insertMemberInterestBrand", po);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MemberInterestBrandDao.java
	 * - 작성일		: 2017. 02. 13.
	 * - 작성자		: wyjeong
	 * - 설명		: 회원 관심 브랜드 목록
	 * </pre>
	 *
	 * @param so
	 * @return
	 */
	public List<MemberInterestBrandVO> pageMemberInterestBrand(MemberInterestBrandSO so) {
		return selectListPage(BASE_DAO_PACKAGE + "pageMemberInterestBrand", so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MemberInterestBrandDao.java
	 * - 작성일		: 2017. 02. 13.
	 * - 작성자		: wyjeong
	 * - 설명		: 회원 관심 브랜드 삭제 (여러건)
	 * </pre>
	 *
	 * @param po
	 * @return
	 */
	public int deleteMemberInterestBrands(MemberInterestBrandPO po) {
		return delete(BASE_DAO_PACKAGE + "deleteMemberInterestBrands", po);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MemberInterestBrandDao.java
	 * - 작성일		: 2017. 02. 13.
	 * - 작성자		: wyjeong
	 * - 설명		: 회원 관심 브랜드 삭제
	 * </pre>
	 *
	 * @param po
	 * @return
	 */
	public int deleteMemberInterestBrand(MemberInterestBrandPO po) {
		return delete(BASE_DAO_PACKAGE + "deleteMemberInterestBrand", po);
	}

	/**
	 *
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: MemberInterestBrandDao.java
	* - 작성일		: 2017. 3. 14.
	* - 작성자		: hjko
	* - 설명		: 마이페이지 > 찜 > 찜한 브랜드 목록
	* </pre>
	* @param so
	* @return
	 */
	public List<MemberInterestBrandVO> listMemberInterestBrands(MemberInterestGoodsSO so) {
		return selectList(BASE_DAO_PACKAGE + "listMemberInterestBrands", so);
	}

	/**
	 *
	 * <pre>
	 * - 프로젝트명		: 11.business
	 * - 파일명		: MemberInterestBrandDao.java
	 * - 작성일		: 2017. 3. 14.
	 * - 작성자		: hjko
	 * - 설명			: 마이페이지 > 위시리스트 > 위시리스트 브랜드 목록
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<MemberInterestBrandVO> pageMemberInterestBrands(MemberInterestBrandSO so) {
		return selectListPage(BASE_DAO_PACKAGE + "pageMemberInterestBrands", so);
	}
}