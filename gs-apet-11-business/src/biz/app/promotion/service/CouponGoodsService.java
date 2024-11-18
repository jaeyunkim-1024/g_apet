package biz.app.promotion.service;

import biz.app.member.model.MemberCouponPO;
import biz.app.promotion.model.CouponTargetGoodsVO;
import biz.app.promotion.model.CouponTargetSO;
import framework.common.exception.CustomException;

import java.util.List;

public interface CouponGoodsService {

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: CouponGoodsService.java
	 * - 작성일		: 2021. 2. 17.
	 * - 작성자		: yjs01
	 * - 설명		: 상품 상세 쿠폰 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	List<CouponTargetGoodsVO> listCouponTargetGoodsDetail(CouponTargetSO so);
	List<CouponTargetGoodsVO> pageCouponTargetGoodsDetail(CouponTargetSO so);
	int pageCouponTargetGoodsDetailCount(CouponTargetSO so);
	int insertCouponGoodsMember(CouponTargetGoodsVO couponVo, MemberCouponPO po);
	MemberCouponPO couponGoodsMemberValidation(CouponTargetGoodsVO coupon) throws CustomException;
}
