package biz.app.member.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import biz.app.member.model.MemberInterestGoodsPO;
import biz.app.member.model.MemberInterestGoodsSO;
import biz.app.member.model.MemberInterestGoodsVO;
import framework.common.dao.MainAbstractDao;


/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.member.dao
* - 파일명		: MemberInterestGoodsDao.java
* - 작성일		: 2016. 4. 26.
* - 작성자		: snw
* - 설명		: 회원 관심 상품 DAO
* </pre>
*/
@Repository
public class MemberInterestGoodsDao extends MainAbstractDao {

	private static final String BASE_DAO_PACKAGE = "memberInterestGoods.";

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: MemberInterestGoodsDao.java
	* - 작성일		: 2016. 4. 29.
	* - 작성자		: snw
	* - 설명		: 회원관심상품 단건 조회
	* </pre>
	* @param so
	* @return
	*/
	public MemberInterestGoodsVO getMemberInterestGoods(MemberInterestGoodsSO so){
		return selectOne(BASE_DAO_PACKAGE + "getMemberInterestGoods", so);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: MemberInterestGoodsDao.java
	* - 작성일		: 2016. 4. 26.
	* - 작성자		: snw
	* - 설명		: 회원 관심 상품 등록
	* </pre>
	* @param po
	* @return
	*/
	public int insertMemberInterestGoods(MemberInterestGoodsPO po){
		return insert(BASE_DAO_PACKAGE + "insertMemberInterestGoods", po);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: MemberInterestGoodsDao.java
	* - 작성일		: 2016. 5. 4.
	* - 작성자		: phy
	* - 설명		: 회원 관심 상품 목록
	* </pre>
	* @param so
	* @return
	*/
	public List<MemberInterestGoodsVO> pageMemberInterestGoods(MemberInterestGoodsSO so) {
		return selectListPage(BASE_DAO_PACKAGE + "pageMemberInterestGoods", so);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: MemberInterestGoodsDao.java
	* - 작성일		: 2016. 5. 9.
	* - 작성자		: phy
	* - 설명		: 회원 관심 상품 삭제
	* </pre>
	* @param po
	* @return
	*/
	public int deleteMemberInterestGoods(MemberInterestGoodsPO po){
		return delete(BASE_DAO_PACKAGE + "deleteMemberInterestGoods", po);
	}

	/**
	 *
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: MemberInterestGoodsDao.java
	* - 작성일		: 2017. 3. 14.
	* - 작성자		: hjko
	* - 설명		:  마이페이지 >찜 >상품 목록
	* </pre>
	* @param so
	* @return
	 */
	public List<MemberInterestGoodsVO> listMemberInterestGoods(MemberInterestGoodsSO so) {
		return selectList(BASE_DAO_PACKAGE + "listMemberInterestGoods", so);
	}

	/**
	 *
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: MemberInterestGoodsDao.java
	* - 작성일		: 2017. 3. 14.
	* - 작성자		: hjko
	* - 설명		: 마이페이지 >찜 > 찜상품 삭제
	* </pre>
	* @param po
	 */
	public int deleteMyInterestGoods(MemberInterestGoodsPO po) {
		return delete(BASE_DAO_PACKAGE + "deleteMemberInterestGoods", po);
	}

	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MemberInterestGoodsDao.java
	 * - 작성일		: 2017. 3. 14.
	 * - 작성자		: hjko
	 * - 설명		: 마이페이지 > 찜상품 개수
	 * </pre>
	 * @param po
	 */
	public int listMemberInterestGoodsCount(MemberInterestGoodsSO so) {
		return selectOne(BASE_DAO_PACKAGE + "listMemberInterestGoodsCount", so);
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MemberInterestGoodsDao.java
	 * - 작성일		: 2017. 07. 11.
	 * - 작성자		: wyjeong
	 * - 설명		: 회원 찜 상품 여부
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<MemberInterestGoodsVO> checkMemberInterestGoods(MemberInterestGoodsSO so) {
		return selectList(BASE_DAO_PACKAGE + "checkMemberInterestGoods", so);
	}
}