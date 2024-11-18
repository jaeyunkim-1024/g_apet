package biz.app.promotion.dao;

import java.util.List;
import java.util.Optional;

import biz.app.member.model.MemberBaseSO;
import biz.app.member.model.MemberBaseVO;
import biz.app.promotion.model.*;
import org.springframework.stereotype.Repository;

import biz.app.brand.model.BrandBaseVO;
import biz.app.company.model.CompanyBaseVO;
import biz.app.display.model.DisplayCategoryVO;
import biz.app.goods.model.GoodsBaseVO;
import biz.app.member.model.MemberCouponVO;
import biz.app.st.model.StStdInfoPO;
import biz.app.st.model.StStdInfoVO;
import framework.common.dao.MainAbstractDao;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.promotion.dao
* - 파일명		: CouponDao.java
* - 작성일		: 2016. 4. 19.
* - 작성자		: istrator
* - 설명		:
* </pre>
*/
@Repository
public class CouponDao extends MainAbstractDao {
	private static final String BASE_DAO_PACKAGE = "coupon.";

	public List<CouponBaseVO> pageCouponBase(CouponSO so) {
		return selectListPage(BASE_DAO_PACKAGE+"pageCouponBase", so);
	}

	public CouponBaseVO getCouponBase(CouponSO so) {
		return (CouponBaseVO) selectOne(BASE_DAO_PACKAGE+"getCouponBase", so);
	}

	public int insertCouponBase(CouponBasePO po) {
		return insert(BASE_DAO_PACKAGE+"insertCouponBase", po);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: CouponDao.java
	 * - 작성일		: 2017. 1. 09.
	 * - 작성자		: 이성용
	 * - 설명		: 사이트와 쿠폰 매핑 정보 등록
	 * </pre>
	 * @param po
	 * @return
	 */
	public int insertStCouponMap(StStdInfoPO po) {
		
		return insert(BASE_DAO_PACKAGE+"insertStStdCouponMap", po);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: CouponDao.java
	 * - 작성일		: 2017. 1. 09.
	 * - 작성자		: 이성용
	 * - 설명		: 사이트와 쿠폰 매핑 정보 삭제
	 * </pre>
	 * @param po
	 * @return
	 */	
	public int deleteStCouponMap(CouponBasePO po) {
		
		return delete(BASE_DAO_PACKAGE+"deleteStStdCouponMap", po);
	}

	public int updateCouponBase(CouponBasePO po) {
		return update(BASE_DAO_PACKAGE+"updateCouponBase", po);
	}

	public int deleteCouponBase(CouponBasePO po) {
		return delete(BASE_DAO_PACKAGE+"deleteCouponBase", po);
	}

	public int getCouponBaseDeleteCheck(CouponBasePO po) {
		return (Integer) selectOne(BASE_DAO_PACKAGE+"getCouponBaseDeleteCheck", po);
	}


	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명		: CouponDao.java
	* - 작성일		: 2020. 03. 04.
	* - 작성자		: 김재윤
	* - 설명			: FO 쿠폰 노출 목록
	* - 쿼리 조건 	: 	 쿠폰 지급 방식(=10,다운로드 고정)
	 * 					쿠폰 종류 코드,쿠폰 대상 코드, 쿠폰 상태 코드, 쿠폰 적용 코드 ,웹 모바일 구분 코드,
	 * 					외부 쿠폰 여부 , 등록일자(default 3년전)
	* </pre>
	* @param so
	* @return
	*/
	public List<CouponBaseVO> pageCoupon(CouponSO so) {
		return selectListPage(BASE_DAO_PACKAGE+"pageCoupon", so);
	}

	public List<CouponTargetVO> listCouponGoods(CouponSO so) {
		return selectList(BASE_DAO_PACKAGE+"listCouponGoods", so);
	}

	public List<CouponTargetVO> listCouponGoodsEx(CouponSO so) {
		return selectList(BASE_DAO_PACKAGE+"listCouponGoodsEx", so);
	}

	public List<DisplayCouponTreeVO> listCouponDisplayTree(CouponSO so) {
		return selectList(BASE_DAO_PACKAGE+"listCouponDisplayTree", so);
	}
	/**
	 * 
	* <pre>
	* - 프로젝트명   : 11.business
	* - 패키지명   : biz.app.promotion.dao
	* - 파일명      : CouponDao.java
	* - 작성일      : 2017. 4. 7.
	* - 작성자      : valuefactory 권성중
	* - 설명      :홈 > 마케팅 관리 > 쿠폰 프로모션 > 쿠폰 등록 
	* </pre>
	 */
	public List<DisplayCouponTreeVO> listCouponShowDispClsf(CouponSO so) {
		return selectList(BASE_DAO_PACKAGE+"listCouponShowDispClsf", so);
	}
	
	
	
	
	public int insertCouponTarget(CouponTargetPO po) {
		return insert(BASE_DAO_PACKAGE+"insertCouponTarget", po);
	}
	
	public int deleteCouponTarget(CouponBasePO po) {
		return delete(BASE_DAO_PACKAGE+"deleteCouponTarget", po);
	}

	public int insertCouponExTarget(CouponTargetPO po) {
		return insert(BASE_DAO_PACKAGE+"insertCouponExTarget", po);
	}

	public int deleteCouponExTarget(CouponBasePO po) {
		return delete(BASE_DAO_PACKAGE+"deleteCouponExTarget", po);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: CouponDao.java
	* - 작성일		: 2016. 4. 19.
	* - 작성자		: phy
	* - 설명		: 쿠폰 정보 조회
	* </pre>
	* @param so
	* @return
	*/
	public CouponBaseVO getCoupon(CouponSO so) {
		return (CouponBaseVO) selectOne(BASE_DAO_PACKAGE+"getCoupon", so);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: CouponDao.java
	* - 작성일		: 2016. 4. 19.
	* - 작성자		: phy
	* - 설명		: 쿠폰 대상 상품 조회
	* </pre>
	* @param sto
	* @return
	*/
	public List<GoodsBaseVO> pageCouponTargetGoods(CouponTargetSO sto) {
		return selectListPage(BASE_DAO_PACKAGE+"pageCouponTargetGoods", sto);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: CouponDao.java
	* - 작성일		: 2016. 4. 19.
	* - 작성자		: phy
	* - 설명		: 쿠폰 대상 카테고리 조회
	* </pre>
	* @param sto
	* @return
	*/
	public List<DisplayCategoryVO> getCouponTargetCategory(CouponTargetSO sto) {
		return selectList(BASE_DAO_PACKAGE+"getCouponTargetCategory", sto);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: CouponDao.java
	 * - 작성일		: 2016. 5. 19.
	 * - 작성자		: valueFactory
	 * - 설명		: 쿠폰 회원 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<MemberCouponVO> pageMemberCoupon(CouponSO so) {
		return selectListPage(BASE_DAO_PACKAGE+"pageMemberCoupon", so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: CouponDao.java
	 * - 작성일		: 2016. 5. 19.
	 * - 작성자		: valueFactory
	 * - 설명		: 쿠폰 수동 회원 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<CouponIssueVO> pageCouponIssue(CouponSO so) {
		return selectListPage(BASE_DAO_PACKAGE+"pageCouponIssue", so);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: CouponDao.java
	 * - 작성일		: 2016. 9. 05.
	 * - 작성자		: hjko
	 * - 설명		: 쿠폰 다운로드/자동 회원 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<CouponIssueVO> pageDownCouponIssue(CouponSO so){
		return selectListPage(BASE_DAO_PACKAGE+"pageDownCouponIssue", so);
	}

	public int insertCouponIssue(CouponIssuePO po) {
		return insert(BASE_DAO_PACKAGE+"insertCouponIssue", po);
	}

	public int deleteCouponIssue(CouponBasePO po) {
		return delete(BASE_DAO_PACKAGE+"deleteCouponIssue", po);
	}

	public int updateBatchCouponCpStat() {
		return update(BASE_DAO_PACKAGE+"updateBatchCouponCpStat");
	}

	public String goodsDlvrcPayMth(String goodsId) {

		return selectOne(BASE_DAO_PACKAGE+"goodsDlvrcPayMth", goodsId);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: CouponDao.java
	 * - 작성일		: 2016. 9. 05.
	 * - 작성자		: hjko
	 * - 설명		: 쿠폰과 매핑된 사이트 정보 전체를 조회한다.
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<StStdInfoVO> listStStdInfoByCoupon(CouponSO so) {
		
		return selectList("inline.getStStdInfoPrmtById", so);
	}
	
	
	
/**
 * 
* <pre>
* - 프로젝트명   : 11.business
* - 패키지명   : biz.app.promotion.dao
* - 파일명      : CouponDao.java
* - 작성일      : 2017. 4. 19.
* - 작성자      : valuefactory 권성중
* - 설명      : 홈 > 마케팅 관리 > 쿠폰 프로모션 > 쿠폰 등록    // 쿠폰대상인 업체 인  업체 리스트
* </pre>
 */
	public List<CompanyBaseVO> listCouponTargetCompNo(CouponSO so) {
		return selectList(BASE_DAO_PACKAGE+"listCouponTargetCompNo", so);
	}
	
	public List<BrandBaseVO> listCouponTargetBndNo(CouponSO so) {
		return selectList(BASE_DAO_PACKAGE+"listCouponTargetBndNo", so);
	}
	
	public List<ExhibitionVO> listCouponTargetExhbtNo(CouponSO so) {
		return selectList(BASE_DAO_PACKAGE+"listCouponTargetExhbtNo", so);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: biz.app.promotion.dao
	 * - 작성일		: 2020. 12. 21.
	 * - 작성자		: JinHong
	 * - 설명		: 쿠폰 대상 리스트
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<CouponTargetVO> listCouponTarget(CouponSO so) {
		return selectList(BASE_DAO_PACKAGE+"listCouponTarget", so);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: biz.app.promotion.dao
	 * - 작성일		: 2020. 12. 21.
	 * - 작성자		: JinHong
	 * - 설명		: 쿠폰 제외상품 리스트
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<CouponTargetVO> listCouponExGoods(CouponSO so) {
		return selectList(BASE_DAO_PACKAGE+"listCouponExGoods", so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: biz.app.promotion.dao
	 * - 작성일		: 2020. 12. 21.
	 * - 작성자		: 김재윤
	 * - 설명		: 반환 값 -> 다운로드 가능 쿠폰 수, 해당 회원이 다운로드 가능 쿠폰 중 실제로 다운로드 받은 쿠폰 수
	 * </pre>
	 * @param so
	 * @return
	 */
	public MemberCouponVO getCouponIsDownYn(CouponSO so){
		return selectOne(BASE_DAO_PACKAGE+"getCouponIsDownYn",so);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: biz.app.promotion.dao
	 * - 작성일		: 2021. 8. 12.
	 * - 작성자		: cjw01
	 * - 설명		: 쿠폰 회원등급 관리
	 * </pre>
	 * @param so
	 * @return
	 */
	public int insertCouponMbrGrd(CouponBasePO po) {
		return insert(BASE_DAO_PACKAGE+"insertCouponMbrGrd", po);
	}

	public int deleteCouponMbrGrd(CouponBasePO po) {
		return delete(BASE_DAO_PACKAGE+"deleteCouponMbrGrd", po);
	}
}
