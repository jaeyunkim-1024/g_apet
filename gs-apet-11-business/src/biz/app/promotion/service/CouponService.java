package biz.app.promotion.service;

import java.util.List;

import biz.app.brand.model.BrandBaseVO;
import biz.app.company.model.CompanyBaseVO;
import biz.app.display.model.DisplayCategoryVO;
import biz.app.goods.model.GoodsBaseVO;
import biz.app.promotion.model.CouponBasePO;
import biz.app.promotion.model.CouponBaseVO;
import biz.app.promotion.model.CouponIssueVO;
import biz.app.promotion.model.CouponSO;
import biz.app.promotion.model.CouponTargetSO;
import biz.app.promotion.model.CouponTargetVO;
import biz.app.promotion.model.DisplayCouponTreeVO;
import biz.app.promotion.model.ExhibitionVO;
import biz.app.member.model.MemberCouponVO;

/**
 * get업무명		:	단권
 * list업무명	:	리스트
 * page업무명	:	리스트 페이징
 * insert업무명	:	입력
 * update업무명	:	수정
 * delete업무명	:	삭제
 * save업무명	:	입력 / 수정
 */
public interface CouponService {

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: CouponService.java
	 * - 작성일		: 2016. 5. 10.
	 * - 작성자		: valueFactory
	 * - 설명		: 쿠폰 페이징
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<CouponBaseVO> pageCouponBase(CouponSO so);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: CouponService.java
	 * - 작성일		: 2016. 5. 10.
	 * - 작성자		: valueFactory
	 * - 설명		: 쿠폰 상세
	 * </pre>
	 * @param so
	 * @return
	 */
	public CouponBaseVO getCouponBase(CouponSO so);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: CouponService.java
	 * - 작성일		: 2016. 5. 10.
	 * - 작성자		: valueFactory
	 * - 설명		: 쿠폰 등록
	 * </pre>
	 * @param po
	 */
	public void insertCoupon(CouponBasePO po);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: CouponService.java
	 * - 작성일		: 2016. 5. 10.
	 * - 작성자		: valueFactory
	 * - 설명		: 쿠폰 수정
	 * </pre>
	 * @param po
	 */
	public void updateCoupon(CouponBasePO po);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: CouponService.java
	 * - 작성일		: 2016. 5. 20.
	 * - 작성자		: valueFactory
	 * - 설명		: 쿠폰 삭제
	 * </pre>
	 * @param po
	 */
	public void deleteCoupon(CouponBasePO po);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: CouponService.java
	* - 작성일		: 2016. 4. 19.
	* - 작성자		: phy
	* - 설명		: 쿠폰 목록 조회
	* </pre>
	* @param so
	* @return
	*/
	public List<CouponBaseVO> listCouponZone(CouponSO so);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: CouponService.java
	 * - 작성일		: 2016. 5. 20.
	 * - 작성자		: valueFactory
	 * - 설명		: 쿠폰 상품 목록
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<CouponTargetVO> listCouponGoods(CouponSO so);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: CouponService.java
	 * - 작성일		: 2016. 5. 20.
	 * - 작성자		: valueFactory
	 * - 설명		: 쿠폰 제외 상품 목록
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<CouponTargetVO> listCouponGoodsEx(CouponSO so);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: CouponService.java
	 * - 작성일		: 2016. 5. 20.
	 * - 작성자		: valueFactory
	 * - 설명		: 쿠폰 전시 목록
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<DisplayCouponTreeVO> listCouponDisplayTree(CouponSO so);

/**
 * 
* <pre>
* - 프로젝트명   : 11.business
* - 패키지명   : biz.app.promotion.service
* - 파일명      : CouponService.java
* - 작성일      : 2017. 4. 7.
* - 작성자      : valuefactory 권성중
* - 설명      :홈 > 마케팅 관리 > 쿠폰 프로모션 > 쿠폰 등록 
* </pre>
 */
	public List<DisplayCouponTreeVO> listCouponShowDispClsf(CouponSO so);

	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: CouponService.java
	* - 작성일		: 2016. 4. 19.
	* - 작성자		: phy
	* - 설명		: 쿠폰 정보 조회
	* </pre>
	* @param so
	* @return
	*/
	public CouponBaseVO getCoupon(CouponSO so);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: CouponService.java
	* - 작성일		: 2016. 4. 19.
	* - 작성자		: Administrator
	* - 설명		: 쿠폰 대상 상품 조회
	* </pre>
	* @param so
	* @return
	*/
	public List<GoodsBaseVO> pageCouponTargetGoods(CouponTargetSO so);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: CouponService.java
	* - 작성일		: 2016. 4. 19.
	* - 작성자		: Administrator
	* - 설명		: 쿠폰 대상 카테고리 조회
	* </pre>
	* @param so
	* @return
	*/
	public List<DisplayCategoryVO> getCouponTargetCategory(CouponTargetSO so);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: CouponService.java
	 * - 작성일		: 2016. 5. 19.
	 * - 작성자		: valueFactory
	 * - 설명		: 사용자 쿠폰 목록
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<MemberCouponVO> pageMemberCoupon(CouponSO so);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: CouponService.java
	 * - 작성일		: 2016. 5. 19.
	 * - 작성자		: valueFactory
	 * - 설명		: 사용자 일련번호 쿠폰 목록(수동쿠폰)
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<CouponIssueVO> pageCouponIssue(CouponSO so);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: CouponService.java
	 * - 작성일		: 2016. 9. 05.
	 * - 작성자		: hjko
	 * - 설명		: 다운로드 쿠폰 받은 회원 목록
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<CouponIssueVO> pageDownCouponIssue(CouponSO so);
	
	public void updateBatchCouponCpStat();
	
	public String goodsDlvrcPayMth(String goodsId);
	
	
	/**
	 * 
	* <pre>
	* - 프로젝트명   : 11.business
	* - 패키지명   : biz.app.promotion.service
	* - 파일명      : CouponService.java
	* - 작성일      : 2017. 4. 19.
	* - 작성자      : valuefactory 권성중
	* - 설명      : 홈 > 마케팅 관리 > 쿠폰 프로모션 > 쿠폰 등록    // 쿠폰대상인 업체 인  업체 리스트
	* </pre>
	 */
	public List<CompanyBaseVO> 	listCouponTargetCompNo(CouponSO so);
	
	public List<BrandBaseVO> 	listCouponTargetBndNo(CouponSO so);
	
	public List<ExhibitionVO> 	listCouponTargetExhbtNo(CouponSO so);

	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: biz.app.promotion.service
	 * - 작성일		: 2020. 12. 21.
	 * - 작성자		: JinHong
	 * - 설명		:  쿠폰 복사
	 * </pre>
	 * @param so
	 * @return
	 */
	public CouponBasePO copyCoupon(CouponSO so);

	public String getCouponIsAllDownYn(CouponSO so);
}