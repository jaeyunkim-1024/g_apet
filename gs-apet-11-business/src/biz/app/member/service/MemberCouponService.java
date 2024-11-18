package biz.app.member.service;

import biz.app.member.model.MemberCouponPO;
import biz.app.member.model.MemberCouponSO;
import biz.app.member.model.MemberCouponVO;

import java.sql.Timestamp;
import java.util.List;

public interface MemberCouponService {

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명		: MemberCouponService.java
	* - 작성일		: 2017. 2. 21.
	* - 작성자		: snw
	* - 설명			: 회원쿠폰 사용처리
	* </pre>
	* @param mbrCpNo
	* @param ordNo
	* @param ordDtlSeq
	* @return
	*/
	void updateMemberCouponUse(Long mbrCpNo, String ordNo);

	/**
	 *
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명		: MemberCouponService.java
	* - 작성일		: 2017. 3. 6.
	* - 작성자		: hjko
	* - 설명		:  마이페이지 > 혜택보기
	* </pre>
	* @param so
	* @return
	 */
	//public List<MemberCouponVO> listMemberCoupon(MemberCouponSO so) ;

	public Long insertMemberCoupon(MemberCouponPO po);

	public Long insertMemberCoupon(MemberCouponPO po,Boolean isBatch);

	public List<Long> insertMemberCoupon(MemberCouponPO po,Integer n);

	public List<MemberCouponVO> insertMemberCouponAll(MemberCouponPO po);


	/*
	 * 사용 가능 쿠폰 목록 조회
	 */
	List<MemberCouponVO> memberListCouponPage(MemberCouponSO so);

	/*
	 * 사용한 쿠폰 목록 조회 (front web)
	 */
	List<MemberCouponVO> memberListComCouponPage(MemberCouponSO so);

	/**
	 *
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: MemberCouponService.java
	 * - 작성일		: 2017. 3. 20.
	 * - 작성자		: hjko
	 * - 설명		: 마이페이지 > 쿠폰갯수 > 사용완료한 쿠폰 목록
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<MemberCouponVO> listMemberCoupon(MemberCouponSO so) ;

	/**
	 *
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명		: MemberCouponService.java
	* - 작성일		: 2017. 3. 20.
	* - 작성자		: hjko
	* - 설명		: 마이페이지 > 쿠폰갯수 > 사용완료한 쿠폰 목록
	* </pre>
	* @param so
	* @return
	 */
	public List<MemberCouponVO> listMemberUsedCoupon(MemberCouponSO so) ;

	/**
	 *
	* <pre>
	* - 프로젝트명		: gs-apet-11-business
	* - 파일명		: MemberCouponService.java
	* - 작성일		: 2017. 07.
	* - 작성자		: hjko
	* - 설명			: 마이페이지 > 쿠폰 > 쿠폰상세보기
	* </pre>
	* @param so
	* @return
	 */
	MemberCouponVO getMemberCouponDetail(MemberCouponSO so);
	
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
	public Integer getMemberCouponCountMyPage(MemberCouponSO so);

	public void memberCouponInsertLmsSend(Long mbrNo, MemberCouponVO sendCoupon);
	public void memberCouponResInsertLmsSend(Long mbrNo, MemberCouponVO sendCoupon);

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명		: MemberCouponService.java
	* - 작성일		: 2021. 8. 20.
	* - 작성자		: cjw01
	* - 설명			: 회원 쿠폰 발급 대기 대상 발급 처리
	* </pre>
	* @param cpNo
	* @param mbrNo
	* @return
	*/
	void updateCouponIsuStbUse(Long cpNo, Long mbrNo);
	void deleteCouponIsuStbUse();
}
