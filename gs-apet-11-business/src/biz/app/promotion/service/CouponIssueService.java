package biz.app.promotion.service;

import java.util.ArrayList;

import org.springframework.web.bind.annotation.RequestParam;

import biz.app.promotion.model.CouponBaseVO;
import biz.app.promotion.model.CouponIssuePO;
import biz.app.promotion.model.CouponIssueVO;
import biz.app.promotion.model.CouponIssueSO;
import biz.app.promotion.model.CouponSO;

public interface CouponIssueService {
	  
	/*
	 * 쿠폰 등록 
	 */
	void couponApply(CouponIssuePO po);
	

	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-41-admin
	 * - 파일명		: biz.app.promotion.service
	 * - 작성일		: 2021. 08. 12.
	 * - 작성자		: 김세영
	 * - 설명		:  쿠폰발급 삭제
	 * </pre>
	 * @param so
	 * @return
	 */
	public int deleteCouponIssueStb(ArrayList<CouponIssueVO> so);
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-41-admin
	 * - 파일명		: biz.app.promotion.service
	 * - 작성일		: 2021. 08. 12.
	 * - 작성자		: 김세영
	 * - 설명		:  수동 쿠폰 일괄 발급
	 * </pre>
	 * @param cpNo
	 * @param mbrNos
	 * @return
	 */
	public int insertMemberCouponList(Long cpNo, Long[] mbrNos);
	

	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-41-admin
	 * - 파일명		: biz.app.promotion.service
	 * - 작성일		: 2021. 08. 12.
	 * - 작성자		: 김세영
	 * - 설명		:  쿠폰발급 및 대기 여부 조회
	 * </pre>
	 * @param cpNo
	 * @param mbrNo
	 * @return
	 */
	public boolean selectCouponIssueStbYn(Long cpNo, Long mbrNo);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: CouponService.java
	 * - 작성일		: 2021. 8. 23.
	 * - 작성자		: cjw01
	 * - 설명		: 쿠폰발급 상세
	 * </pre>
	 * @param so
	 * @return
	 */
	public CouponIssueVO getCouponIssue(CouponIssueSO so);
}
