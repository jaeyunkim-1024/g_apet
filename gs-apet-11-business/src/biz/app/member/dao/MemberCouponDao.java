package biz.app.member.dao;

import biz.app.member.model.MemberCouponPO;
import biz.app.member.model.MemberCouponSO;
import biz.app.member.model.MemberCouponVO;
import framework.common.dao.MainAbstractDao;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class MemberCouponDao extends MainAbstractDao {
	private static final String BASE_DAO_PACKAGE = "memberCoupon.";

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명		: MemberCouponDao.java
	* - 작성일		: 2016. 7. 5.
	* - 작성자		: snw
	* - 설명			: 회원쿠폰 사용 처리
	* </pre>
	* @param po
	* @return
	*/
	public int updateMemberCouponUse(MemberCouponPO po){
		return update(BASE_DAO_PACKAGE + "updateMemberCouponUse", po);
	}

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명		: MemberCouponDao.java
	* - 작성일		: 2016. 7. 5.
	* - 작성자		: snw
	* - 설명			: 회원쿠폰 복원 처리
	* </pre>
	* @param po
	* @return
	*/
	public int updateMemberCouponUseCancel(MemberCouponPO po){
		return update(BASE_DAO_PACKAGE + "updateMemberCouponUseCancel", po);
	}
	
	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명		: MemberCouponDao.java
	* - 작성일		: 2017. 2. 21.
	* - 작성자		: snw
	* - 설명			: 회원 쿠폰 상세 조회
	* </pre>
	* @param so
	* @return
	*/
	public MemberCouponVO getMemberCoupon(MemberCouponSO so){
		return selectOne(BASE_DAO_PACKAGE + "getMemberCoupon", so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: MemberCouponDao.java
	 * - 작성일		: 2021. 03. 01.
	 * - 작성자		: 김재윤
	 * - 설명			: 회원 쿠폰 발급
	 * </pre>
	 * @param so
	 * @return
	 */
	public int insertMemberCoupon(MemberCouponPO po){
		return insert(BASE_DAO_PACKAGE + "insertMemberCoupon", po);
	}

	public int insertMemberCouponIsBatch(MemberCouponPO po){
		return insert_batch(BASE_DAO_PACKAGE + "insertMemberCoupon", po);
	}

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명		: MemberCouponDao.java
	* - 작성일		: 2021. 03. 09.
	* - 작성자		:  BO - 회원 상세 검색 - 상세
	* - 설명		: 사용 가능 쿠폰 목록 조회
	* </pre>
	* @param ctfCd
	* @return
	*/
	public List<MemberCouponVO> memberListCouponPage(MemberCouponSO so){
		return selectListPage(BASE_DAO_PACKAGE + "pageMemberCoupon", so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: MemberCouponDao.java
	 * - 작성일		: 2021. 03. 09.
	 * - 작성자		:  BO - 회원 상세 검색 - 상세
	* - 설명		: 사용한 쿠폰 목록 조회
	* </pre>
	* @param ctfCd
	* @return
	*/
	public List<MemberCouponVO> memberListComCouponPage(MemberCouponSO so){
		return selectListPage(BASE_DAO_PACKAGE + "pageMemberCoupon", so);
	}

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명		: MemberCouponDao.java
	* - 작성일		: 2016. 5. 9.
	* - 작성자		: kyh
	* - 설명		: 쿠폰 목록 paging count
	* </pre>
	* @param ctfCd
	* @return
	*/
	public Integer getMemberCouponCnt(MemberCouponPO po){
		return selectOne(BASE_DAO_PACKAGE + "getMemberCouponCnt", po);
	}

	public Integer getMemberIsuCouponCnt(MemberCouponPO po){
		return selectOne(BASE_DAO_PACKAGE + "getMemberIsuCouponCnt", po);
	}

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명		: MemberCouponDao.java
	* - 작성일		: 2016. 5. 27.
	* - 작성자		: kyh
	* - 설명		    : 해당 쿠폰발급 수량 count
	* </pre>
	* @param ctfCd
	* @return
	*/
	public Integer getCouponBaseIsuQty(MemberCouponPO po){
		return selectOne(BASE_DAO_PACKAGE + "getCouponBaseIsuQty", po);
	}

	/**
	 *
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명		: MemberCouponDao.java
	* - 작성일		: 2017. 3. 6.
	* - 작성자		: hjko
	* - 설명		: 마이페이지 > 혜택보기 > 쿠폰북  => 사용 가능한 쿠폰 목록으로 변경
	* - 추가		: 2021.03.09 기준 - 사용 X (김재윤)
	* </pre>
	* @param so
	* @return
	 */
	public List<MemberCouponVO> listMemberCoupon(MemberCouponSO so) {
		return selectListPage(BASE_DAO_PACKAGE + "listMemberCoupon", so);
	}

	/**
	 *
	 * <pre>
	 * - 프로젝트명		: gs-apet-11-business
	 * - 파일명		: MemberCouponDao.java
	 * - 작성일		: 2017. 07.
	 * - 작성자		: hjko
	 * - 설명			: 마이페이지 > 쿠폰 > 쿠폰상세보기
	 * </pre>
	 * @param so
	 * @return
	 */
	public MemberCouponVO getMemberCouponDetail(MemberCouponSO so) {
		return selectOne(BASE_DAO_PACKAGE + "getMemberCouponDetail", so);
	}

	/**
	 *
	 * <pre>
	 * - 프로젝트명		: gs-apet-11-business
	 * - 파일명		: MemberCouponDao.java
	 * - 작성일		: 2021. 03. 08
	 * - 작성자		: 이지희
	 * - 설명			: 마이페이지 > 회원 보유쿠폰 갯수 조회 
	 * </pre>
	 * @param so
	 * @return
	 */
	public Integer getMemberCouponCountMyPage(MemberCouponSO so) {
		return selectOne(BASE_DAO_PACKAGE + "listMemberCouponCount", so);
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: MemberCouponDao.java
	* - 작성일		: 2021. 8. 6.
	* - 작성자		: kwj
	* - 설명		: 회원가입 시 신규가입이벤트 쿠폰 지급
	* </pre>
	* @param po
	* @return
	*/
	public int insertWelcomeEventCoupon(MemberCouponPO po){
		return insert(BASE_DAO_PACKAGE + "insertWelcomeEventCoupon", po);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: MemberCouponDao.java
	 * - 작성일		: 2021. 08. 19.
	 * - 작성자		: cjw01
	 * - 설명			: 쿠폰 대기 등록
	 * </pre>
	 * @param so
	 * @return
	 */
	public int insertCouponIsuStb(MemberCouponPO po){
		return insert(BASE_DAO_PACKAGE + "insertCouponIsuStb", po);
	}

	public int insertCouponIsuStbIsBatch(MemberCouponPO po){
		return insert_batch(BASE_DAO_PACKAGE + "insertCouponIsuStb", po);
	}

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명		: MemberCouponDao.java
	* - 작성일		: 2021. 8. 20.
	* - 작성자		: cjw01
	* - 설명			: 회원 쿠폰 발급 대기 대상 발급 처리
	* </pre>
	* @param po
	* @return
	*/
	public int updateCouponIsuStbUse(MemberCouponPO po){
		return update(BASE_DAO_PACKAGE + "updateCouponIsuStbUse", po);
	}
	
	public int deleteCouponIsuStbUse(){
		return delete(BASE_DAO_PACKAGE + "deleteCouponIsuStbUse");
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명		: gs-apet-11-business
	 * - 파일명		: MemberCouponDao.java
	 * - 작성일		: 2021. 08. 25
	 * - 작성자		: kwj
	 * - 설명			: 신규가입 선착순 쿠폰 이벤트. 당일 쿠폰 지급 개수. 
	 * </pre>
	 * @param so
	 * @return
	 */
	public Integer getWelcomeLimitCouponCount(MemberCouponSO so) {
		return selectOne(BASE_DAO_PACKAGE + "getWelcomeLimitCouponCount", so);
	}

}
