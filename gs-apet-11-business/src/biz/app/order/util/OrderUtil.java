package biz.app.order.util;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.Optional;

import org.apache.commons.collections.CollectionUtils;

import biz.app.cart.model.CartGoodsVO;
import biz.app.cart.model.CartGoodsVO.Coupon;
import framework.common.constants.CommonConstants;
import framework.common.util.StringUtil;

public final class OrderUtil {

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: OrderUtil.java
	* - 작성일		: 2017. 2. 21.
	* - 작성자		: snw
	* - 설명			: 적립금 계산
	* </pre>
	* @param buyAmt
	* @param svmnRate
	* @return
	*/
	public static Long getOrderSvmn(Long buyAmt, Double svmnRate) {
		return Math.round(buyAmt * (svmnRate / 100));
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: OrderUtil.java
	* - 작성일		: 2017. 2. 21.
	* - 작성자		: snw
	* - 설명			: 공급업체 분담 금액 계산
	* </pre>
	* @param prmtDcAmt
	* @param compDvdRate
	* @return
	*/
	public static Long getCompDvdAmt(Long prmtDcAmt, Double compDvdRate) {
		return Math.round(prmtDcAmt * (compDvdRate / 100));
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: OrderUtil.java
	* - 작성일		: 2017. 2. 28.
	* - 작성자		: snw
	* - 설명			: 비율계산
	* </pre>
	* @param totalAmt
	* @param targetAmt
	* @return
	*/
	public static Double getRate(Long totalAmt, Long targetAmt){
		Double result = targetAmt.doubleValue() / totalAmt.doubleValue();
		result = Math.round(result * 1000) / 1000.0;
		
		return result;
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: OrderUtil.java
	* - 작성일		: 2017. 6. 14.
	* - 작성자		: Administrator
	* - 설명			: 상품 수수료
	* </pre>
	* @param saleAmt
	* @param goodsCmsRate
	* @return
	*/
	public static Long getGoodsCms(Long saleAmt, Double goodsCmsRate) {
		return Math.round(saleAmt * (goodsCmsRate / 100));
	}
	
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: biz.app.order.util
	 * - 작성일		: 2021. 01. 29.
	 * - 작성자		: JinHong
	 * - 설명		: 장바구니 최적 상품쿠폰 세팅
	 * </pre>
	 * @param cartList
	 */
	public static void setCartOptimalGoodsCoupon(List<CartGoodsVO> cartList, boolean isSelected) {
		
		List<Coupon> calcCouponList = new ArrayList<>();
		List<Coupon> optimalCouponList = null;
		for(CartGoodsVO cartGoods : cartList) {
			List<Coupon> couponList = cartGoods.getCouponList();
			
			cartGoods.setSelCpDcAmt(0L);
			cartGoods.setSelTotCpDcAmt(0L);
			
			if (CommonConstants.SALE_PSB_00.equals(cartGoods.getSalePsbCd())) {
				setCalcCouponDcAmt(calcCouponList, cartGoods);
				
				if (isSelected) {
					boolean isExist = false;
					if(cartGoods.getSelMbrCpNo() != null) {
						for (Coupon coupon : couponList) {
							if (cartGoods.getSelMbrCpNo().equals(coupon.getMbrCpNo())) {
								cartGoods.setSelCpDcAmt(coupon.getDcAmt());
								cartGoods.setSelTotCpDcAmt(coupon.getTotDcAmt());
								cartGoods.setSelCpNo(coupon.getCpNo());
								isExist = true;
							}
						}
					}
					
					//상품 쿠폰 최소 구매금액 으로 제한될때 체크
					if(!isExist) {
						cartGoods.setSelMbrCpNo(null);
						cartGoods.setSelCpNo(null);
						cartGoods.setSelCpDcAmt(0L);
						cartGoods.setSelTotCpDcAmt(0L);
						
					}
				}
				
				if(CollectionUtils.isEmpty(couponList)) {
					cartGoods.setIsCpExist(false);
				}else {
					cartGoods.setIsCpExist(true);
				}
			}
		}
		optimalCouponList = getOptimalCouponList(calcCouponList);
		
		if (!isSelected) {
			for (Coupon coupon : optimalCouponList) {
				for (CartGoodsVO cartGoods : cartList) {
					if (coupon.getCartId().equals(cartGoods.getCartId())) {
						cartGoods.setOptimalMbrCpNo(coupon.getMbrCpNo());
						cartGoods.setSelMbrCpNo(coupon.getMbrCpNo());
						cartGoods.setSelCpDcAmt(coupon.getDcAmt());
						cartGoods.setSelTotCpDcAmt(coupon.getTotDcAmt());
						cartGoods.setSelCpNo(coupon.getCpNo());
					}
				}
			}
		}else{
			//선택했을 경우 최적쿠폰 번호
			for (Coupon coupon : optimalCouponList) {
				for (CartGoodsVO cartGoods : cartList) {
					if (coupon.getCartId().equals(cartGoods.getCartId())) {
						cartGoods.setOptimalMbrCpNo(coupon.getMbrCpNo());
					}
				}
			}
		}
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: biz.app.order.util
	 * - 작성일		: 2021. 01. 29.
	 * - 작성자		: JinHong
	 * - 설명		: 장바구니 상품별 쿠폰 할인 금액 계산 
	 * </pre>
	 * @param calcCouponList 계산 쿠폰 
	 * @param cartGoods		장바구니 상품
	 * @param couponList	쿠폰 리스트
	 */
	private static void setCalcCouponDcAmt(List<Coupon> calcCouponList, CartGoodsVO cartGoods) {
		List<Coupon> couponList = cartGoods.getCouponList();
		
		if (CollectionUtils.isNotEmpty(couponList)) {
			for (Coupon coupon : couponList) {
				long totDcAmt = 0L;
				long dcAmt = 0L;
				long salePrc = cartGoods.getPrmtDcPrc();
				
				//정율
				if (CommonConstants.CP_APL_10.equals(coupon.getCpAplCd())) {
					dcAmt = (long) Math.ceil(salePrc * Optional.ofNullable(coupon.getAplVal()).orElse(0L).doubleValue() / 100.0 / 10) * 10;
					//최대 할인금액
					if (coupon.getMaxDcAmt() != null && coupon.getMaxDcAmt() > 0 && coupon.getMaxDcAmt() < dcAmt) {
						dcAmt = coupon.getMaxDcAmt();
					}
				} else {
					dcAmt = (long) Math.ceil(Optional.ofNullable(coupon.getAplVal()).orElse(0L).doubleValue() / 10) * 10;
				}
				
				//복수 적용 여부
				if (CommonConstants.MULTI_APL_YN_Y.equals(coupon.getMultiAplYn())) {
					totDcAmt = dcAmt * cartGoods.getBuyQty();
				} else {
					totDcAmt = dcAmt;
				}
				
				/*if (dcAmt > salePrc) {
					totDcAmt = 0;
					dcAmt = 0;
				}*/
				
				if(dcAmt <= salePrc) {
					coupon.setDcAmt(dcAmt);
					coupon.setTotDcAmt(totDcAmt);
					coupon.setCartId(cartGoods.getCartId());
					calcCouponList.add(coupon);
				}
				
			}
			
			//쿠폰 할인금액 세팅안된 경우 삭제 쿠폰리스트
			cartGoods.getCouponList().removeIf(cp -> StringUtil.isEmpty(cp.getCartId()));
		}
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: biz.app.order.util
	 * - 작성일		: 2021. 02. 01.
	 * - 작성자		: JinHong
	 * - 설명		: 정렬 후 각 장바구니에 적용쿠폰 세팅
	 * </pre>
	 * @param couponList
	 * @return
	 */
	private static List<Coupon> getOptimalCouponList(List<Coupon> couponList) {
		// TODO : 최적쿠폰 적용 수정 , kjhvf01
		/* ex)  상품 쿠폰 A 는  상품 가, 나 에 중복적용되지 않음. 한상품에 한쿠폰
		 * 상품 A - 가 쿠폰 최대 
		 * 상품 B - 가 쿠폰 최대
		 * A 쿠폰 - 가쿠폰,  B - X  -> 현재 최적
		 * A 쿠폰 - 나 쿠폰,  B - 가 쿠폰 -> 진짜 최적 쿠폰 적용. 
		 * */
		List<Coupon> optimalCouponList = new ArrayList<Coupon>();

		if (CollectionUtils.isNotEmpty(couponList)) {

			couponList.sort(Comparator.comparing(Coupon::getTotDcAmt).reversed().thenComparing(Comparator.comparing(Coupon::getSysRegDtm).reversed()).thenComparing(Comparator.comparing(Coupon::getLeftSeconds)));

			for (Coupon coupon : couponList) {
				boolean isNoneMatch = optimalCouponList.stream()
						.noneMatch(x -> x.getCartId().equals(coupon.getCartId()) || x.getMbrCpNo().equals(coupon.getMbrCpNo()));
				if (isNoneMatch && coupon.getDcAmt() > 0) {
					optimalCouponList.add(coupon);
				}
			}
		}

		return optimalCouponList;
	}
}