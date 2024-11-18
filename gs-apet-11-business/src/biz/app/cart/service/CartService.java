package biz.app.cart.service;

import java.util.List;
import java.util.Map;

import biz.app.cart.model.CartCouponDlvrcVO;
import biz.app.cart.model.CartCouponSO;
import biz.app.cart.model.CartCouponVO;
import biz.app.cart.model.CartFreebieRtnVO;
import biz.app.cart.model.CartGoodsSO;
import biz.app.cart.model.CartGoodsVO;
import biz.app.cart.model.CartPO;
import biz.app.cart.model.CartSO;
import biz.app.cart.model.CartVO;
import biz.app.cart.model.DeliveryChargeCalcVO;

/**
 * 장바구니 서비스
 * 
 * @author ValueFactory
 * @since 2016. 04. 26.
 */
public interface CartService {

	/**
	 * <pre>장바구니 상품 목록 조회</pre>
	 * 
	 * @param so
	 * @param localPostYn 도서 산간지역 여부
	 * @return
	 */
	List<CartGoodsVO> listCartGoods(CartGoodsSO so, String localPostYn, String [] goodsCpInfos, boolean isOrderPage);
	List<CartGoodsVO> listCartGoods(CartGoodsSO so, String localPostYn);
	
	/**
	 * <pre>장바구니 상세 조회</pre>
	 * 
	 * @param cartId
	 * @return
	 */
	CartVO getCart(String cartId);

	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: biz.app.cart.service
	 * - 작성일		: 2021. 01. 22.
	 * - 작성자		: JinHong
	 * - 설명		: 장바구니 등록(멀티)
	 * </pre>
	 * @param stId
	 * @param mbrNo
	 * @param ssnId
	 * @param goodsIdsStr
	 * @param buyQtys
	 * @param nowBuyYn
	 * @return
	 */
	public Map<String, Object> insertCart(Long stId, Long mbrNo, String ssnId, String[] goodsIdsStr, Integer[] buyQtys, String nowBuyYn);

	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: biz.app.cart.service
	 * - 작성일		: 2021. 01. 27.
	 * - 작성자		: JinHong
	 * - 설명		: 장바구니 수량, 체크여부 수정
	 * </pre>
	 * @param cartList
	 */
	public void updateCartBuyQtyAndCheckYn(List<CartPO> cartList);
	
	/**
	 * <pre>장바구니 수정(비회원 > 회원)
	 * 일반/바로구매 모두 수정</pre>
	 * 
	 * @param stId
	 * @param ssnId
	 * @param mbrNo
	 */
	void updateCartInfo(Long stId, String ssnId, Long mbrNo);

	
	/**
	 * <pre>장바구니 삭제 (멀티)</pre>
	 * 
	 * @param cartIds
	 */
	void deleteCart(String[] cartIds);

	
	/**
	 * <pre>장바구니 일괄 삭제(보관기간이 종료된 장바구니)</pre>
	 * 
	 * @param mbrYn
	 * @param nowBuyYn
	 * @param strgPeriod
	 */
	void deleteCart(String mbrYn, String nowBuyYn, Integer strgPeriod);

	
	/**
	 * <pre>장바구니 옵션 변경
	 *  - 일반장바구니
	 *     단품 & 수량
	 * </pre>
	 * 
	 * @param cartId
	 * @param ssnId
	 * @param mbrNo
	 * @param goodsId
	 * @param attrNos
	 * @param attrValNos
	 * @param buyQty
	 */
	void updateCartOption(String cartId, String ssnId, Long mbrNo, String goodsId, Long[] attrNos, Long[] attrValNos, Integer buyQty);

	
	/**
	 * <pre>장바구니 수량 변경</pre>
	 * 
	 * @param cartId
	 * @param buyQty
	 */
	void updateCartBuyQty(String cartId, Integer buyQty);

	
	/**
	 * <pre>현재 접속자의 일반장바구니 수(회원/비회원)</pre>
	 * 
	 * @param stId
	 * @param ssnId
	 * @param mbrNo
	 * @return
	 */
	public Integer getCartCnt(Long stId, String ssnId, Long mbrNo);

	
	/**
	 * <pre>장바구니에 적용 가능한  장바구니 쿠폰 목록 조회</pre>
	 * 
	 * @param so
	 * @return
	 */
	public List<CartCouponVO> listCartCoupon(CartCouponSO so);

	
	/**
	 * <pre>장바구니에 적용 가능한  배송비 쿠폰 목록 조회</pre>
	 * 
	 * @param so
	 * @return
	 */
	public CartCouponDlvrcVO getCartCouponDlvrc(CartCouponSO so);

	
	/**
	 * <pre>장바구니 상품 관심상품에 등록</pre>
	 * 
	 * @param cartIds
	 */
	void insertWishFromCart(String[] cartIds);
	
	
	/**
	 * <pre>상품 재고 체크</pre>
	 * 
	 * @param so
	 */
	public List<CartGoodsVO> listValidGoodsStock(CartSO so);
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: biz.app.cart.service
	 * - 작성일		: 2021. 02. 08.
	 * - 작성자		: JinHong
	 * - 설명		: 장바구니 연관상품 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<CartGoodsVO> listCartCstrtGoodsInfo(CartGoodsSO so);
	
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: biz.app.cart.service
	 * - 작성일		: 2021. 03. 17.
	 * - 작성자		: JinHong
	 * - 설명		: 사은품 체크
	 * </pre>
	 * @param goodsList
	 * @return
	 */
	public CartFreebieRtnVO checkCartFreebie(List<CartVO> goodsList);
	
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: biz.app.cart.service
	 * - 작성일		: 2021. 04. 28.
	 * - 작성자		: JinHong
	 * - 설명		: 장바구니 목록
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<CartVO> listCart(CartSO so);
	List<DeliveryChargeCalcVO> setDeliveryChargeCalc(List<DeliveryChargeCalcVO> deliveryChargeList, String localPostYn, String clmTpCd);
	
}
