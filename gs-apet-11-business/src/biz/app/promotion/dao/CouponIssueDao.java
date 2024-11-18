package biz.app.promotion.dao;

import biz.app.member.model.MemberCouponPO;
import biz.app.promotion.model.CouponBasePO;
import biz.app.promotion.model.CouponIssuePO;
import biz.app.promotion.model.CouponIssueSO;
import biz.app.promotion.model.CouponIssueVO;
import framework.common.dao.MainAbstractDao;
import org.springframework.stereotype.Repository;

@Repository
public class CouponIssueDao extends MainAbstractDao {

	private static final String BASE_DAO_PACKAGE = "couponIssue.";
     
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: CouponIssueDao.java
	* - 작성일		: 2016. 5. 10.
	* - 작성자		: kyh
	* - 설명		: 등록된 쿠폰 여부 체크
	* </pre>
	* @param ctfCd
	* @return
	*/
	public CouponIssueVO getCouponIssue(CouponIssueSO so){
		return (CouponIssueVO)selectOne(BASE_DAO_PACKAGE + "getCouponIssue", so);
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: CouponIssueDao.java
	* - 작성일		: 2016. 5. 10.
	* - 작성자		: kyh
	* - 설명		: 유효 쿠폰 여부 체크
	* </pre>
	* @param ctfCd
	* @return
	*/
	public Integer checkCouponCnt(Integer cpNo){
		return selectOne(BASE_DAO_PACKAGE + "checkCouponCnt", cpNo);
	} 
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: CouponIssueDao.java
	* - 작성일		: 2016. 5. 10.
	* - 작성자		: kyh
	* - 설명		: 등록된 쿠폰 상태 update
	* </pre>
	* @param ctfCd
	* @return
	*/
	public int updateCouponIssue(CouponIssuePO po){ 
		return update(BASE_DAO_PACKAGE + "updateCoupon", po);
	}

	public int updateCouponIsuueBatch(CouponIssuePO po){
		return update_batch(BASE_DAO_PACKAGE + "updateCoupon", po);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: biz.app.promotion.dao
	 * - 작성일		: 2021. 08. 12.
	 * - 작성자		: 김세영
	 * - 설명			: 쿠폰 발급 대기 데이터 삭제 coupon_issue_stb 
	 * </pre>
	 * @param so
	 * @return
	 */
	public int deleteCouponIssueStb (CouponIssueVO so) {
		return delete(BASE_DAO_PACKAGE+"deleteCouponIssueStb", so );
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: biz.app.promotion.dao
	 * - 작성일		: 2021. 08. 12.
	 * - 작성자		: 김세영
	 * - 설명			: 쿠폰 발급 대기 Cnt
	 * </pre>
	 * @param po
	 * @return
	 */
	public Integer getMemberCouponStbCnt(MemberCouponPO po){
		return selectOne(BASE_DAO_PACKAGE + "getMemberCouponStbCnt", po);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: biz.app.promotion.dao
	 * - 작성일		: 2021. 08. 18.
	 * - 작성자		: 김세영
	 * - 설명			: 회원 쿠폰 발급 대기 등록
	 * </pre>
	 * @param so
	 * @return
	 */
	public int insertMemberCouponIssueStb(MemberCouponPO po){
		return insert(BASE_DAO_PACKAGE + "insertMemberCouponIssueStb", po);
	}

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명		: biz.app.promotion.dao
	* - 작성일		: 2021. 8. 12.
	* - 작성자		: cjw01
	* - 설명		: 쿠폰 목록 paging count
	* </pre>
	* @param ctfCd
	* @return
	*/
	public Integer getCouponIssueCnt(CouponIssuePO po){
		return selectOne(BASE_DAO_PACKAGE + "getCouponIssueCnt", po);
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: CouponIssueDao.java
	* - 작성일		: 2021. 8. 26.
	* - 작성자		: cjw01
	* - 설명		: 쿠폰코드 update
	* </pre>
	* @param ctfCd
	* @return
	*/
	public int updateCouponCode(CouponIssuePO po){ 
		return update(BASE_DAO_PACKAGE + "updateCouponCode", po);
	}

	public int deleteCouponCode(CouponIssuePO po) {
		return delete(BASE_DAO_PACKAGE+"deleteCouponCode", po);
	}
}
