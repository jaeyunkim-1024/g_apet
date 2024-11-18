package biz.app.cart.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import biz.app.cart.model.CartCouponDlvrcVO;
import biz.app.cart.model.CartCouponSO;
import biz.app.cart.model.CartCouponVO;
import biz.app.cart.model.CartGoodsSO;
import biz.app.cart.model.CartGoodsVO;
import biz.app.cart.model.CartPO;
import biz.app.cart.model.CartSO;
import biz.app.cart.model.CartVO;
import framework.common.dao.MainAbstractDao;

/**
 * 장바구니 DAO
 * 
 * @author ValueFactory
 * @since 2017. 02. 07.
 */
@Repository
public class CartDao extends MainAbstractDao {

	private static final String BASE_DAO_PACKAGE = "cart.";

	
	/**
	 * <pre>장바구니 목록</pre>
	 * 
	 * @param so
	 * @return
	 */
	public List<CartVO> listCart(CartSO so) {
		return selectList(BASE_DAO_PACKAGE + "listCart", so);
	}

	/**
	 * <pre>장바구니 상품 목록 조회</pre>
	 * 
	 * @param so
	 * @return
	 */
	public List<CartGoodsVO> listCartGoods(CartGoodsSO so) {
		return selectList(BASE_DAO_PACKAGE + "listCartGoods", so);
	}

	
	/**
	 * <pre>장바구니 단건 조회</pre>
	 * 
	 * @param so
	 * @return
	 */
	public CartVO getCart(CartSO so) {
		return selectOne(BASE_DAO_PACKAGE + "getCart", so);
	}

	
	/**
	 * <pre>장바구니 등록</pre>
	 * 
	 * @param po
	 * @return
	 */
	public int insertCart(CartPO po) {
		return insert(BASE_DAO_PACKAGE + "insertCart", po);
	}

	
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: biz.app.cart.dao
	 * - 작성일		: 2021. 01. 27.
	 * - 작성자		: JinHong
	 * - 설명		: 장바구니 수량, 체크여부 수정
	 * </pre>
	 * @param po
	 * @return
	 */
	public int updateCartBuyQtyAndCheckYn(CartPO po) {
		return update(BASE_DAO_PACKAGE + "updateCartBuyQtyAndCheckYn", po);
	}
	
	
	/**
	 * <pre>장바구니 정보 수정(비회원 > 회원)</pre>
	 * 
	 * @param po
	 * @return
	 */
	public int updateCartInfo(CartPO po) {
		return update(BASE_DAO_PACKAGE + "updateCartInfo", po);
	}

	
	/**
	 * <pre>장바구니 삭제</pre>
	 * 
	 * @param po
	 * @return
	 */
	public int deleteCart(CartPO po) {
		return delete(BASE_DAO_PACKAGE + "deleteCart", po);
	}

	
	/**
	 * <pre>장바구니 구매수량 수정</pre>
	 * 
	 * @param po
	 * @return
	 */
	public int updateCartBuyQty(CartPO po) {
		return update(BASE_DAO_PACKAGE + "updateCartBuyQty", po);
	}

	
	/**
	 * <pre>장바구니 옵션 변경</pre>
	 * 
	 * @param po
	 * @return
	 */
	public int updateCartOption(CartPO po) {
		return update(BASE_DAO_PACKAGE + "updateCartOption", po);
	}

	
	/**
	 * <pre>장바구니(일반) 상품 수 조회</pre>
	 * 
	 * @param so
	 * @return
	 */
	public Integer getCartCnt(CartSO so) {
		return selectOne(BASE_DAO_PACKAGE + "getCartCnt", so);
	}

	/**
	 * <pre>장바구니에 적용 가능한 장바구니 쿠폰 목록 조회</pre>
	 * 
	 * @param so
	 * @return
	 */
	public List<CartCouponVO> listCartCoupon(CartCouponSO so) {
		return selectList(BASE_DAO_PACKAGE + "listCartCoupon", so);
	}

	
	/**
	 * <pre>장바구니에 적용 가능한 배송비 쿠폰 목록 조회</pre>
	 * 
	 * @param so
	 * @return
	 */
	public CartCouponDlvrcVO getCartCouponDlvrc(CartCouponSO so) {
		return selectOne(BASE_DAO_PACKAGE + "getCartCouponDlvrc", so);
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: CartDao.java
	* - 작성일		: 2020. 2. 14.
	* - 작성자		: valfac
	* - 설명			: 상품 재고 체크
	* </pre>
	* @param so
	* @return
	*/
	public List<CartGoodsVO> listValidGoodsStock(CartGoodsSO so){
		return selectList(BASE_DAO_PACKAGE + "listValidGoodsStock", so);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: biz.app.cart.dao
	 * - 작성일		: 2021. 02. 08.
	 * - 작성자		: JinHong
	 * - 설명		: 장바구니 연관상품 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<CartGoodsVO> listCartCstrtGoodsInfo(CartGoodsSO so){
		return selectList(BASE_DAO_PACKAGE + "listCartCstrtGoodsInfo", so);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: biz.app.cart.dao
	 * - 작성일		: 2021. 03. 17.
	 * - 작성자		: JinHong
	 * - 설명		: 사은품 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<CartGoodsVO.Freebie> listFreebie(String goodsId){
		return selectList(BASE_DAO_PACKAGE + "listFreebie", goodsId);
	}
	
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: biz.app.cart.dao
	 * - 작성일		: 2021. 03. 24.
	 * - 작성자		: JinHong
	 * - 설명		: 장바구니 상품 유효성 체크 
	 * </pre>
	 * @param so
	 * @return
	 */
	public CartGoodsVO getValidGoods(CartGoodsSO so){
		return selectOne(BASE_DAO_PACKAGE + "getValidGoods", so);
	}

	public List<CartGoodsVO> listCartValidGoods(CartGoodsSO so) {
		return selectList(BASE_DAO_PACKAGE + "listCartValidGoods", so);
	}
}
