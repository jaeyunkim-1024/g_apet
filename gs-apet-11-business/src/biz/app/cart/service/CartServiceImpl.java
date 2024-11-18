package biz.app.cart.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import biz.app.cart.dao.CartDao;
import biz.app.cart.model.CartCouponDlvrcVO;
import biz.app.cart.model.CartCouponSO;
import biz.app.cart.model.CartCouponVO;
import biz.app.cart.model.CartFreebieRtnVO;
import biz.app.cart.model.CartGoodsSO;
import biz.app.cart.model.CartGoodsSO.Cart;
import biz.app.cart.model.CartGoodsVO;
import biz.app.cart.model.CartPO;
import biz.app.cart.model.CartSO;
import biz.app.cart.model.CartVO;
import biz.app.cart.model.DeliveryChargeCalcVO;
import biz.app.goods.dao.GoodsBaseDao;
import biz.app.goods.dao.GoodsCstrtSetDao;
import biz.app.goods.model.GoodsBaseSO;
import biz.app.goods.model.GoodsBaseVO;
import biz.app.goods.model.GoodsCstrtSetVO;
import biz.app.goods.model.ItemSO;
import biz.app.goods.model.ItemVO;
import biz.app.goods.service.ItemService;
import biz.app.member.dao.MemberInterestGoodsDao;
import biz.app.member.model.MemberInterestGoodsPO;
import biz.app.member.model.MemberInterestGoodsSO;
import biz.app.member.model.MemberInterestGoodsVO;
import biz.app.order.util.OrderUtil;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import framework.common.util.StringUtil;
import framework.front.constants.FrontConstants;
import lombok.extern.slf4j.Slf4j;

/**
 * 장바구니 서비스 Implement
 * 
 * @author ValueFactory
 * @since 2016. 04. 26.
 */
@Slf4j
@Transactional
@Service("cartService")
public class CartServiceImpl implements CartService {

	@Autowired private CartDao cartDao;

	@Autowired private ItemService itemService;

	@Autowired private MemberInterestGoodsDao memberInterestGoodsDao;

	@Autowired private GoodsBaseDao goodsBaseDao;
	
	@Autowired private GoodsCstrtSetDao goodsCstrtSetDao;
	
	@Autowired private MessageSourceAccessor message;

	public static final String CART_PARAM_SPLIT_SEPER = "\\:";
	
	/**
	 * <pre>장바구니 상품 목록 조회</pre>
	 * 
	 * @param so
	 * @param localPostYn 도서 산간지역 여부
	 * @return
	 */
	
	@Override
	public List<CartGoodsVO> listCartGoods(CartGoodsSO so, String localPostYn) {
		return this.listCartGoods(so, localPostYn, null, false);
	}
	
	@Override
	@Transactional(readOnly = true)
	public List<CartGoodsVO> listCartGoods(CartGoodsSO so, String localPostYn, String [] goodsCpInfos, boolean isOrderPage) {
		
		//비회원인 경우
		if(StringUtils.isNotEmpty(so.getSsnId())) {
			//비회원 장바구니 최초 ssnId 저장
			HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
			Cookie[] cookies = request.getCookies();
			String cartTempKey = ""; 
			if(cookies != null){
		         
				for(int i=0; i < cookies.length; i++){
					Cookie c = cookies[i] ;
		            if(c.getName().equals("CART_TEMP_KEY")) {
		            	cartTempKey = c.getValue() ;
		            	break;
		            }
				}
			}
			
			if(StringUtils.isNotEmpty(cartTempKey)) {
				so.setSsnId(cartTempKey);
			}
		}
		
		List<CartGoodsVO> cartList = null;
		boolean isSelected = false;
		if(CollectionUtils.isEmpty(so.getCartList())) {
			cartList = this.cartDao.listCartGoods(so);
			
			if (CollectionUtils.isNotEmpty(cartList)) {
				for(CartGoodsVO vo : cartList) {
					if (CollectionUtils.isNotEmpty(vo.getTotalSalePsbCdList())) {
						vo.setTotalSalePsbCd(vo.getTotalSalePsbCdList().get(0).getSalePsbCd());
					}
				}
			}
			
			//바로구매 nowBuyYn
			
			if(goodsCpInfos != null && goodsCpInfos.length > 0) {
				for(CartGoodsVO vo : cartList) {
					for(String goodsCpInfo : goodsCpInfos) {
						/* 
						 * cartId:goodsId:itemNo:pakGoodsId:selMbrCpNo
						*/
						String [] splitVal = goodsCpInfo.split(":");
						if(splitVal.length == 5) {
							String goodsId = splitVal[1];
							String itemNo = Optional.ofNullable(splitVal[2]).orElse("");
							String pakGoodsId = Optional.ofNullable(splitVal[3]).orElse("");
							if(vo.getGoodsId().equals(goodsId)  
									&& (vo.getItemNo() == null ? "" : vo.getItemNo().toString()).equals(itemNo) 
									&& Optional.ofNullable(vo.getPakGoodsId()).orElse("").equals(pakGoodsId)) {
								String cpInfo = splitVal[4];
								vo.setSelMbrCpNo(Long.parseLong(cpInfo));
							}
						}
					}
				}
				isSelected = true;
			}
			if (CollectionUtils.isNotEmpty(cartList) && !CommonConstants.NO_MEMBER_NO.equals(so.getMbrNo())) {
				// 장바구니 최적 상품쿠폰 적용
				OrderUtil.setCartOptimalGoodsCoupon(cartList, isSelected);
			}
		}else {
			//param
			List<Cart> soList = so.getCartList();
			String[] cartIds = new String[soList.size()];
			for (int i = 0; i < soList.size(); i++) {
				cartIds[i] = soList.get(i).getCartId();
			}
			so.setCartIds(cartIds);
			
			cartList = this.cartDao.listCartGoods(so);
			
			if (CollectionUtils.isNotEmpty(cartList) && !CommonConstants.NO_MEMBER_NO.equals(so.getMbrNo())) {
				for(CartGoodsVO vo : cartList) {
					for(Cart cartSO : soList) {
						if(vo.getCartId().equals(cartSO.getCartId())) {
							vo.setSelMbrCpNo(cartSO.getSelMbrCpNo());
						}
					}
				}
				isSelected = true;
				
				//로그인 -> 주문서
				if(isOrderPage && goodsCpInfos == null) {
					isSelected = false;
				}
				// 장바구니 선택 쿠폰 적용
				OrderUtil.setCartOptimalGoodsCoupon(cartList, isSelected);
			}
		}
		
		List<DeliveryChargeCalcVO> typeCartList = new ArrayList<>();
		typeCartList.addAll(cartList);
		setDeliveryChargeCalc(typeCartList, localPostYn, null); // shallow copy
		
		log.debug("listCartGoods : {}", cartList);
		
		return cartList;
	}


	/**
	 * setDeliveryCharge 동일 로직. 주문, 환불에서 사용
	 * deliveryChargeList 는 order by 배송비 정책 번호
	 * 
	 * @param deliveryChargeList
	 * @param localPostYn
	 * @return
	 */
	@Override
	public List<DeliveryChargeCalcVO> setDeliveryChargeCalc(List<DeliveryChargeCalcVO> deliveryChargeList, String localPostYn, String clmTpCd) {
		
		DeliveryChargeCalcVO deliveryChargeCalc = null;

		if (deliveryChargeList != null && !deliveryChargeList.isEmpty()) {
			Integer pkgDlvrNo = 0;			// 묶음 배송 번호
			int pkgCartCnt = 0;				// 묶음 단위 장바구니 수
			Long bfrDlvrcNo = 0L;			// 이전 묶음 배송 번호
			List<Integer> pkgDlvrNoList = new ArrayList<>();		// 묶음 배송할 배송 번호 목록
			Long orgDlvrAmt = null;			// 원배송비
			Long realDlvrAmt = null;		// 실배송비
			Long addDlvrAmt = null;			// 추가배송비

			
			//------------------------------------------------
			// 1. 장바구니 별 배송비 계산
			//    - 장바구니 단건 무료배송이 아닌 경우에만 배송비 생성
			//------------------------------------------------
			for (int i = 0; i < deliveryChargeList.size(); i++) {
				deliveryChargeCalc = deliveryChargeList.get(i);
				
				/*if (CommonConstants.GOODS_AMT_TP_30.equals(cart.getGoodsAmtTpCd()) && CommonConstants.COMM_YN_Y.equals(cart.getBulkOrdEndYn())) {
					continue;
				}*/
				
				orgDlvrAmt = 0L;
				realDlvrAmt = 0L;
				addDlvrAmt = 0L;
				
				// 묶음 배송 번호 생성
				// - 배송 기준이 개당 부여이거나 배송비 정책 번호가 다른경우 묶음 배송 번호 증가
				// - 묶음 배송할 묶음 배송번호를 pkgDlvrNoList에 추가
				if (CommonConstants.DLVRC_CDT_10.equals(deliveryChargeCalc.getDlvrcCdtCd()) || !bfrDlvrcNo.equals(deliveryChargeCalc.getDlvrcPlcNo())) {
					// 묶음배송의 장바구니수 초기화
					pkgCartCnt = 0;
					pkgDlvrNo++;
				}

				pkgCartCnt++;

				
				// 실제 묶음 배송할 번호 목록 설정
				if (pkgCartCnt > 1) {
					// 기존에 묶음배송리스트에 존재하지 않은 경우에 추가
					boolean addPkgDlvrNo = false;
					if (pkgDlvrNoList != null && !pkgDlvrNoList.isEmpty()) {
						for (Integer pDlvrNo : pkgDlvrNoList) {
							if (pDlvrNo.equals(pkgDlvrNo)) {
								addPkgDlvrNo = true;
							}
						}
					}
					if (!addPkgDlvrNo) {
						pkgDlvrNoList.add(pkgDlvrNo);
					}
				}

				
				// 배송비 계산
				// - 상품단위 무료, 배송비 기준이 무료인 경우를 제외
				// - 배송비결제방법이 선불 부과되는 경우에만 계산해서 설정 (배송비 기본 : 0)
				if (!CommonConstants.COMM_YN_Y.equals(deliveryChargeCalc.getFreeDlvrYn()) && !CommonConstants.DLVRC_STD_10.equals(deliveryChargeCalc.getDlvrcStdCd())
						&& CommonConstants.DLVRC_PAY_MTD_10.equals(deliveryChargeCalc.getDlvrcPayMtdCd())) {
					// 개당 부여
					if (CommonConstants.DLVRC_CDT_10.equals(deliveryChargeCalc.getDlvrcCdtCd())) {
						// APETQA-7044
						if(deliveryChargeCalc.getBuyQty()>0) {
							orgDlvrAmt = deliveryChargeCalc.getDlvrcDlvrAmt() * deliveryChargeCalc.getBuyQty();
							realDlvrAmt = deliveryChargeCalc.getDlvrcDlvrAmt() * deliveryChargeCalc.getBuyQty();
						}else {
							orgDlvrAmt = deliveryChargeCalc.getDlvrcDlvrAmt();
							realDlvrAmt = 0L;
						}
					}
					// 주문당 부여
					else {
						if(deliveryChargeCalc.getBuyQty()>0) {
							orgDlvrAmt = deliveryChargeCalc.getDlvrcDlvrAmt();
							realDlvrAmt = deliveryChargeCalc.getDlvrcDlvrAmt();	
						} else {
							orgDlvrAmt = deliveryChargeCalc.getDlvrcDlvrAmt();
							realDlvrAmt = 0L;
						}
						
					}

					// 배송비 조건 기준 코드에 따른 부과
					// 1) 조건부 무료 (구매가격)
					if (CommonConstants.DLVRC_CDT_STD_20.equals(deliveryChargeCalc.getDlvrcCdtStdCd())) { 
						// 구매가격이 기준가격보다 크면 배송비 무료 처리
						// 배송비 무료 기준 - 쿠폰 할인금액 포함
						Long selTotCpDcAmt = deliveryChargeCalc.getSelTotCpDcAmt() == null ? 0L : deliveryChargeCalc.getSelTotCpDcAmt();
						if (deliveryChargeCalc.getBuyAmt() - selTotCpDcAmt >= deliveryChargeCalc.getDlvrcBuyPrc()) {
							realDlvrAmt = 0L;
						}

					}
					// 2) 조건부 무료 (구매수량)
					else if (CommonConstants.DLVRC_CDT_STD_30.equals(deliveryChargeCalc.getDlvrcCdtStdCd())
							&& deliveryChargeCalc.getBuyQty() >= deliveryChargeCalc.getDlvrcBuyQty()) { 
						// 구매수량이 기준수량보다 크면 배송비 무료 처리
						realDlvrAmt = 0L;
					}
				}

				// 도서 산간 지역일 경우 추가 배송비 설정
				// 무료배송이더라도 추가 배송비는 무조건 설정함
				if (CommonConstants.COMM_YN_Y.equals(localPostYn)) {
					if (CommonConstants.DLVRC_CDT_10.equals(deliveryChargeCalc.getDlvrcCdtCd())) {
						addDlvrAmt = deliveryChargeCalc.getDlvrcAddDlvrAmt() * deliveryChargeCalc.getBuyQty();
					} else {
						addDlvrAmt = deliveryChargeCalc.getDlvrcAddDlvrAmt();
					}
				}

				// 이전 배송비정책번호 및 상품 설정
				bfrDlvrcNo = deliveryChargeCalc.getDlvrcPlcNo();

				// 장바구니 목록 갱신
				deliveryChargeCalc.setPkgDlvrNo(pkgDlvrNo);
				deliveryChargeCalc.setPkgDlvrAmt(realDlvrAmt);
				deliveryChargeCalc.setPkgOrgDlvrAmt(orgDlvrAmt);
				deliveryChargeCalc.setPkgAddDlvrAmt(addDlvrAmt);
				
				deliveryChargeList.set(i, deliveryChargeCalc);

				log.debug("[1] 장바구니 = " + deliveryChargeCalc.toString());
			}

			
			//------------------------------------------------
			// 2. 배송비 묶음 처리
			//------------------------------------------------
			String pkgDlvrYn = null; 		// 묶음 배송 여부
			String pkgLeafYn = ""; 			// 묶음 배송 Leaf
			List<DeliveryChargeCalcVO> orgdeliveryChargeList = deliveryChargeList;

			for (int i = 0; i < deliveryChargeList.size(); i++) {
				deliveryChargeCalc = deliveryChargeList.get(i);
				
				/*if (CommonConstants.GOODS_AMT_TP_30.equals(cart.getGoodsAmtTpCd()) && CommonConstants.COMM_YN_Y.equals(cart.getBulkOrdEndYn())) {
					continue;
				}*/

				// 묶음 배송 여부 처리
				// - pkgDlvrNoList와 동일한 그룹번호를 가진 장바구니의 경우 묶음 배송
				pkgDlvrYn = CommonConstants.COMM_YN_N;

				if (pkgDlvrNoList != null && !pkgDlvrNoList.isEmpty()) {
					for (Integer pDlvrNo : pkgDlvrNoList) {
						if (deliveryChargeCalc.getPkgDlvrNo().equals(pDlvrNo)) {
							pkgDlvrYn = CommonConstants.COMM_YN_Y;
						}
					}
				}

				// 묶음 배송 leaf절 여부
				pkgLeafYn = CommonConstants.COMM_YN_N;

				if (CommonConstants.COMM_YN_Y.equals(pkgDlvrYn)) {
					if (i == deliveryChargeList.size() - 1) {
						pkgLeafYn = CommonConstants.COMM_YN_Y;
					} else {
						if (!deliveryChargeCalc.getPkgDlvrNo().equals(deliveryChargeList.get(i + 1).getPkgDlvrNo()))
							pkgLeafYn = CommonConstants.COMM_YN_Y;
					}
				}

				// 묶음 배송비 계산 - 묶음 배송일 경우
				if (CommonConstants.COMM_YN_Y.equals(pkgDlvrYn)) {
					deliveryChargeCalc = this.getPkgDlvrAmt(deliveryChargeCalc, orgdeliveryChargeList, localPostYn);
				}

				// 장바구니 목록 갱신
				deliveryChargeCalc.setPkgDlvrYn(pkgDlvrYn);
				deliveryChargeCalc.setPkgLeafYn(pkgLeafYn);
				
				deliveryChargeList.set(i, deliveryChargeCalc);

				log.debug("[2] 장바구니 = " + deliveryChargeCalc.toString());
			}
		}
		
		return deliveryChargeList;
	}

	
	/**
	 * <pre>장바구니 목록 중 동일한 묶음 배송비 중 가장 낮은 금액 책정 조건부 무료에 대한 재계산</pre>
	 * 
	 * @param cart
	 * @param cartList
	 * @param localPostYn 도서 산간지역 여부
	 * @return
	 */
	private DeliveryChargeCalcVO getPkgDlvrAmt(DeliveryChargeCalcVO cart, List<DeliveryChargeCalcVO> cartList, String localPostYn) {
		DeliveryChargeCalcVO result = cart;

		Long pkgDlvrAmt = 0L;
		String dlvrcCdtStdCd = "";
		Long totBuyAmt = 0L;
		Long totCpDcAmt = 0L;
		Integer totBuyQty = 0;
		Long dlvrcBuyPrc = 0L;			// 조건부 무료 기준 가격
		Integer dlvrcBuyQty = 0;		// 조건부 무료 기준 수량

		
		//------------------------------------------------
		// 1. 동일한 묶음 배송번호에 대한 상품단위 최소 배송비 찾기
		//------------------------------------------------
		boolean picked = false;
		for (DeliveryChargeCalcVO cartvo : cartList) {
			if (cart.getPkgDlvrNo().equals(cartvo.getPkgDlvrNo())) {

				// 구매 수량 = 0 인 경우는 최소 배송비로 택하지 않는다.
				if (cartvo.getBuyQty() < 1) {
					continue;
				}
				
				if (!picked) {
					pkgDlvrAmt = cartvo.getPkgDlvrAmt();
					picked = true;
				}
				
				// 묶음 배송 상품 단위의 총 구매금액 및 구매 수량 설정
				totBuyAmt += cartvo.getBuyAmt();
				totBuyQty += cartvo.getBuyQty();
				totCpDcAmt += cartvo.getSelTotCpDcAmt() == null ? 0L : cartvo.getSelTotCpDcAmt();
				dlvrcBuyPrc = cart.getDlvrcBuyPrc();
				dlvrcBuyQty = cart.getDlvrcBuyQty();
				dlvrcCdtStdCd = cart.getDlvrcCdtStdCd();
				
				// 최소 배송비 설정
				if (cartvo.getPkgDlvrAmt() < pkgDlvrAmt) {
					pkgDlvrAmt = cartvo.getPkgDlvrAmt();
				}
			}
		}

		
		//------------------------------------------------
		// 2. 배송비가 0보다 큰경우 특정요건에 대한 재계산
		//------------------------------------------------
		if (pkgDlvrAmt > 0) {
			// 1) 조건부 무료 (구매가격)
			if (CommonConstants.DLVRC_CDT_STD_20.equals(dlvrcCdtStdCd)) { 
				// 구매가격이 기준가격보다 크면 배송비 무료 처리
				
				if (totBuyAmt.longValue() - totCpDcAmt >= dlvrcBuyPrc.longValue()) {
					pkgDlvrAmt = 0L;
				}

			}
			// 2) 조건부 무료 (구매수량)
			else if (CommonConstants.DLVRC_CDT_STD_30.equals(dlvrcCdtStdCd)
					&& totBuyQty.intValue() >= dlvrcBuyQty.intValue()) { 
				// 구매수량이 기준수량보다 크면 배송비 무료 처리
				pkgDlvrAmt = 0L;
			}
		}

		result.setPkgDlvrAmt(pkgDlvrAmt);

		return result;
	}

	
	/**
	 * <pre>장바구니 상세 조회</pre>
	 * 
	 * @param cart
	 * @param cartList
	 * @param localPostYn 도서 산간지역 여부
	 * @return
	 */
	@Override
	public CartVO getCart(String cartId) {
		CartSO cso = new CartSO();
		cso.setCartId(cartId);
		
		return this.cartDao.getCart(cso);
	}

	@Override
	public void updateCartBuyQtyAndCheckYn(List<CartPO> cartList) {
		for(CartPO po : cartList) {
			int result = this.cartDao.updateCartBuyQtyAndCheckYn(po);
			
			if (result != 1) {
				throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
			}
		}
	}
	
	/**
	 * <pre>장바구니 등록(멀티)</pre>
	 * 
	 * @param stId
	 * @param mbrNo
	 * @param ssnId
	 * @param goodsIds
	 * @param itemNos
	 * @param buyQtys
	 * @param nowBuyYn
	 */
	
	@Override
	public Map<String, Object> insertCart(Long stId, Long mbrNo, String ssnId, String[] goodsIdsStr, Integer[] buyQtys, String nowBuyYn) {
		if (stId == null || (mbrNo == null && ssnId == null) || nowBuyYn == null || goodsIdsStr == null) {
			throw new CustomException(ExceptionConstants.ERROR_PARAM);
		}
		
		Map<String, Object> rtn = new HashMap<>();
		String rtnCode = null;
		String rtnMsg = null;
		//List<CartVO> failList = new ArrayList<>();
		/*
		 * goodsIdsStr 형태 :  goodsId:itemNo:grpGoodsId
		 * 단품,세트 - 'GI000054400:302558:'
		 * 옵션 - GIXXX:300040:GO444444
		 * pkgGoodsId : 옵션, 묶음 상품일 경우 묶은 상품 번호.
		 * */
		int failCnt = 0;

		// 바로구매 시 데이터 일괄 삭제
		if (CommonConstants.COMM_YN_Y.equals(nowBuyYn)) {
			CartPO cdPO = new CartPO();
			cdPO.setStId(stId);
			if (mbrNo != null && !CommonConstants.NO_MEMBER_NO.equals(mbrNo)) {
				cdPO.setMbrNo(mbrNo);
			} else {
				cdPO.setSsnId(ssnId);
			}
			cdPO.setNowBuyYn(nowBuyYn);
			this.cartDao.deleteCart(cdPO);
		}

		// 장바구니에 상품 등록
		if (goodsIdsStr != null && goodsIdsStr.length > 0) {
			CartPO ciPO = new CartPO();
			ciPO.setStId(stId);

			if (mbrNo != null && !CommonConstants.NO_MEMBER_NO.equals(mbrNo)) {
				ciPO.setMbrNo(mbrNo);
			} else {
				ciPO.setSsnId(ssnId);
			}
			ciPO.setNowBuyYn(nowBuyYn);
			
			for (int i = 0; i < goodsIdsStr.length; i++) {
				String[] arrGoodsIds = StringUtils.splitPreserveAllTokens(goodsIdsStr[i], CART_PARAM_SPLIT_SEPER);
				
				ciPO.setGoodsId(arrGoodsIds[0]);
				
				//2021-04-05 itemNo가 없이 넘어오는 경우가 있어서 추가.
				if(StringUtil.isEmpty(arrGoodsIds[1]) && arrGoodsIds[0] != null) {
					ItemSO itemSO = new ItemSO();
					itemSO.setGoodsId(arrGoodsIds[0]);
					List<ItemVO> itemList = this.itemService.listItem(itemSO);
					if(itemList.size()==1)
						ciPO.setItemNo(itemList.get(0).getItemNo());
				} else {
					ciPO.setItemNo(Long.parseLong(arrGoodsIds[1]));
				}
				
				ciPO.setPakGoodsId(StringUtil.isEmpty(arrGoodsIds[2]) ? null : arrGoodsIds[2]);
				ciPO.setBuyQty(buyQtys[i]);
				
				if(arrGoodsIds.length == 5) {
					ciPO.setMkiGoodsYn(arrGoodsIds[3]);
					ciPO.setMkiGoodsOptContent(arrGoodsIds[4]);
				}else {
					ciPO.setMkiGoodsYn(CommonConstants.COMM_YN_N);
				}
				
				CartSO so = new CartSO();
				so.setStId(ciPO.getStId());
				so.setMbrNo(ciPO.getMbrNo());
				so.setSsnId(ciPO.getSsnId());
				so.setGoodsId(ciPO.getGoodsId());
				so.setItemNo(ciPO.getItemNo());
				so.setPakGoodsId(ciPO.getPakGoodsId());
				so.setNowBuyYn(ciPO.getNowBuyYn());

				CartVO cart = this.cartDao.getCart(so);
				 
				// 기존 상품이 존재하는 경우 기존 장바구니 상품 삭제
				if (cart != null && CommonConstants.COMM_YN_N.equals(nowBuyYn)) {
					rtnCode = ExceptionConstants.ERROR_CART_EXIST;
					rtnMsg = message.getMessage("business.exception." + rtnCode);
					rtn.put("rtnCode", rtnCode);
					rtn.put("rtnMsg", rtnMsg);
					failCnt++;
					continue;
				}
				
				CartGoodsSO cartGoodsSO = new CartGoodsSO();
				cartGoodsSO.setGoodsId(ciPO.getGoodsId());
				cartGoodsSO.setBuyQty(ciPO.getBuyQty());
				CartGoodsVO valieGoods = cartDao.getValidGoods(cartGoodsSO);
				if(valieGoods != null && !CommonConstants.SALE_PSB_00.equals(valieGoods.getSalePsbCd())) {
					String msg = "";
					
					if(CommonConstants.SALE_PSB_10.equals(valieGoods.getSalePsbCd())) {
						msg = "판매중지";
					}else if(CommonConstants.SALE_PSB_20.equals(valieGoods.getSalePsbCd())) {
						msg = "판매종료";
					}else if(CommonConstants.SALE_PSB_30.equals(valieGoods.getSalePsbCd())) {
						msg = "품절";
					}else if(CommonConstants.SALE_PSB_40.equals(valieGoods.getSalePsbCd())) {
						msg = "구매가능 수량 초과";
					}
					
					rtnCode = ExceptionConstants.ERROR_INSERT_CART_ERROR;
					rtnMsg = message.getMessage("business.exception." + rtnCode, new String[] {msg});
					rtn.put("rtnCode", rtnCode);
					rtn.put("rtnMsg", rtnMsg);
					if(CommonConstants.COMM_YN_N.equals(nowBuyYn)) {
						failCnt++;
						continue;
					}else {
						return rtn;
					}
				} else if (valieGoods != null && CommonConstants.SALE_PSB_00.equals(valieGoods.getSalePsbCd())) {
					List<CartGoodsVO> setValidGoodsList = cartDao.listCartValidGoods(cartGoodsSO);
					if (CollectionUtils.isNotEmpty(setValidGoodsList) && !CommonConstants.SALE_PSB_00.equals(setValidGoodsList.get(0).getSalePsbCd())) {
						String msg = "";
						
						if(CommonConstants.SALE_PSB_10.equals(setValidGoodsList.get(0).getSalePsbCd())) {
							msg = "판매중지";
						}else if(CommonConstants.SALE_PSB_20.equals(setValidGoodsList.get(0).getSalePsbCd())) {
							msg = "판매종료";
						}else if(CommonConstants.SALE_PSB_30.equals(setValidGoodsList.get(0).getSalePsbCd())) {
							msg = "품절";
						}else if(CommonConstants.SALE_PSB_40.equals(setValidGoodsList.get(0).getSalePsbCd())) {
							msg = "구매가능 수량 초과";
						}
						
						rtnCode = ExceptionConstants.ERROR_INSERT_CART_ERROR;
						rtnMsg = message.getMessage("business.exception." + rtnCode, new String[] {msg});
						rtn.put("rtnCode", rtnCode);
						rtn.put("rtnMsg", rtnMsg);
						if(CommonConstants.COMM_YN_N.equals(nowBuyYn)) {
							failCnt++;
							continue;
						}else {
							return rtn;
						}
					}
				}
				
				if(CommonConstants.COMM_YN_N.equals(nowBuyYn)) {
					int cartCnt = this.cartDao.getCartCnt(so);
					
					if(cartCnt >= FrontConstants.CART_MAX_COUNT) {
						rtnCode = ExceptionConstants.ERROR_CART_MAX_CNT;
						rtnMsg = message.getMessage("business.exception." + rtnCode);
						rtn.put("rtnCode", rtnCode);
						rtn.put("rtnMsg", rtnMsg);
						failCnt++;
						continue;
					}
				}
				
				// 장바구니 신규 등록
				String cartId = String.valueOf(System.nanoTime()) + StringUtil.randomNumeric(2);
				ciPO.setCartId(cartId);
				
				int result = this.cartDao.insertCart(ciPO);
				if (result != 1) {
					throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
				}
				
			}
		} else {
			rtnCode = ExceptionConstants.ERROR_ORDER_CART_ADD_NO_ITEM;
			rtnMsg = message.getMessage("business.exception." + rtnCode);
			rtn.put("rtnCode", rtnCode);
			rtn.put("rtnMsg", rtnMsg);
			return rtn;
		}
		
		
		//전체 실패했을 경우 실패 노출
		if(failCnt != goodsIdsStr.length) {
			rtnCode = CommonConstants.CONTROLLER_RESULT_CODE_SUCCESS;
			rtn.put("rtnCode", rtnCode);
		}
		
		return rtn;
	}
	
	/**
	 * <pre>장바구니 수정(비회원 > 회원)
	 * 일반/바로구매 모두 수정</pre>
	 * 
	 * @param stId
	 * @param ssnId
	 * @param mbrNo
	 */
	@Override
	public void updateCartInfo(Long stId, String ssnId, Long mbrNo) {
		if(StringUtils.isEmpty(ssnId)) return; // 비회원 쿠키값없으면 전환할 장바구니 없음.
		
		//비회원 장바구니 최초 ssnId 저장
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		Cookie[] cookies = request.getCookies();
		String cartTempKey = ""; 
		if(cookies != null){
	         
			for(int i=0; i < cookies.length; i++){
				Cookie c = cookies[i] ;
	            if(c.getName().equals("CART_TEMP_KEY")) {
	            	cartTempKey = c.getValue() ;
	            	break;
	            }
			}
		}
		
		if(StringUtils.isNotEmpty(cartTempKey)) { 
			ssnId = cartTempKey;
		}
		
		CartPO cuo = null;
		CartPO cdo = null;
		CartSO so = null;
		List<CartVO> cartList = null;

		
		//------------------------------------------------
		// 1. 바로구매 장바구니
		//------------------------------------------------

		// 1) 비회원 바로구매 장바구니 목록 조회
		so = new CartSO();
		so.setStId(stId);
		so.setSsnId(ssnId);
		so.setNowBuyYn(CommonConstants.COMM_YN_Y);
		cartList = this.cartDao.listCart(so);

		if (cartList != null && !cartList.isEmpty()) {
			// 회원 장바구니의 바로구매 데이터 일괄 삭제
			cdo = new CartPO();
			cdo.setStId(stId);
			cdo.setMbrNo(mbrNo);
			cdo.setNowBuyYn(CommonConstants.COMM_YN_Y);
			this.cartDao.deleteCart(cdo);

			// 비회원 장바구니의 바로구매 상품을 회원장바구니의 바로구매 상품으로 변경
			cuo = new CartPO();
			cuo.setStId(stId);
			cuo.setSsnId(ssnId);
			cuo.setMbrNo(mbrNo);
			cuo.setSysUpdrNo(mbrNo);
			cuo.setNowBuyYn(CommonConstants.COMM_YN_Y);
			this.cartDao.updateCartInfo(cuo);
		}

		
		//------------------------------------------------
		// 2. 일반 장바구니
		//------------------------------------------------
		// 비회원 일반 장바구니 목록 조회
		so = new CartSO();
		so.setStId(stId);
		so.setSsnId(ssnId);
		so.setNowBuyYn(CommonConstants.COMM_YN_N);
		cartList = this.cartDao.listCart(so);

		if (cartList != null && !cartList.isEmpty()) {
			CartSO cartSO = new CartSO();
			cartSO.setStId(stId);
			cartSO.setMbrNo(mbrNo);
			
			int cartCnt = this.cartDao.getCartCnt(cartSO);
			
			for (CartVO cart : cartList) {

				// 2. 기존 회원 장바구니에 동일한 상품이 존재하는지 체크
				CartSO mbso = new CartSO();
				mbso.setStId(stId);
				mbso.setMbrNo(mbrNo);
				mbso.setSsnId(null);
				mbso.setGoodsId(cart.getGoodsId());
				mbso.setItemNo(cart.getItemNo());
				mbso.setPakGoodsId(cart.getPakGoodsId());
				mbso.setNowBuyYn(CommonConstants.COMM_YN_N);
				CartVO mbCart = this.cartDao.getCart(mbso);

				// 존재하는 경우 회원 장바구니 상품을 삭제
				/*if (mbCart != null) {
					cdo = new CartPO();
					cdo.setStId(mbCart.getStId());
					cdo.setCartId(mbCart.getCartId());
					this.cartDao.deleteCart(cdo);
				}*/
				
				if(mbCart == null) {
					if(cartCnt >= FrontConstants.CART_MAX_COUNT) {
						//최대 수 넘어갈 경우 비회원 장바구니 삭제
						cdo = new CartPO();
						cdo.setStId(cart.getStId());
						cdo.setCartId(cart.getCartId());
						this.cartDao.deleteCart(cdo);
					}else {
						// 비회원 장바구니 상품을 회원으로 수정
						cuo = new CartPO();
						cuo.setStId(cart.getStId());
						cuo.setCartId(cart.getCartId());
						cuo.setSysUpdrNo(mbrNo);
						cuo.setMbrNo(mbrNo);
						int result = this.cartDao.updateCartInfo(cuo);
						
						if (result != 1) {
							throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
						}
						
						cartCnt++;
					}
				}

			}

		}

	}

	
	/**
	 * <pre>장바구니 삭제 (멀티)</pre>
	 * 
	 * @param cartIds
	 */
	@Override
	public void deleteCart(String[] cartIds) {
		CartPO po = new CartPO();
		int result = 0;

		if (cartIds != null && cartIds.length > 0) {
			for (String cartId : cartIds) {
				po.setCartId(cartId);
				result += this.cartDao.deleteCart(po);
			}

			if (result == 0) {
				throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
			}
		} else {
			throw new CustomException(ExceptionConstants.ERROR_PARAM);
		}

	}

	
	/**
	 * <pre>장바구니 일괄 삭제(보관기간이 종료된 장바구니)</pre>
	 * 
	 * @param mbrYn
	 * @param nowBuyYn
	 * @param strgPeriod
	 */
	@Override
	public void deleteCart(String mbrYn, String nowBuyYn, Integer strgPeriod) {
		CartPO cdPO = new CartPO();
		cdPO.setMbrYn(mbrYn);
		if (nowBuyYn != null) {
			cdPO.setNowBuyYn(nowBuyYn);
		}
		cdPO.setStrgPeriod(strgPeriod);
		this.cartDao.deleteCart(cdPO);
	}

	
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
	@Override
	@Deprecated
	public void updateCartOption(String cartId, String ssnId, Long mbrNo, String goodsId, Long[] attrNos, Long[] attrValNos, Integer buyQty) {
		Long newItemNo = null;
		boolean chageResult = false;

		//------------------------------------------------
		// 1. 정보 조회
		//------------------------------------------------

		// 상품 정보 조회
		GoodsBaseSO gbso = new GoodsBaseSO();
		gbso.setGoodsId(goodsId);
		GoodsBaseVO goodsBase = this.goodsBaseDao.getGoodsBase(gbso);

		// 기존 장바구니 조회
		CartSO so = new CartSO();
		so.setCartId(cartId);
		so.setNowBuyYn(CommonConstants.COMM_YN_N);
		CartVO cart = this.cartDao.getCart(so);

		
		//------------------------------------------------
		// 2. 해당 속성의 단품 찾기
		//------------------------------------------------
		if (goodsBase == null) {
			throw new CustomException(ExceptionConstants.ERROR_GOODS_NO_DATA);
		}

		// 단품관리를 하는 경우
		if (CommonConstants.COMM_YN_Y.equals(goodsBase.getItemMngYn())) {
			ItemVO item = this.itemService.getItem(goodsId, attrNos, attrValNos);

			if (item == null) {
				throw new CustomException(ExceptionConstants.ERROR_GOODS_NO_OPTION);
			}

			newItemNo = item.getItemNo();
			
		}
		// 단품관리를 하지 않는 경우
		else {
			newItemNo = cart.getItemNo();
		}

		if (cart == null) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		} 
		
		
		//------------------------------------------------
		// 3. 장바구니 단품 변경
		//------------------------------------------------

		// 기존단품과 신규단품이 다른경우
		if (!newItemNo.equals(cart.getItemNo())) {
			updateCartItem(cart.getStId(), cartId, ssnId, mbrNo, goodsId, newItemNo);
			cart = this.cartDao.getCart(so); // 변경된 내용으로 장바구니 재조회
			chageResult = true;
		}

		
		//------------------------------------------------
		// 4. 장바구니 수량 변경
		//------------------------------------------------
		
		// 기존 수량과 변경되는 수량이 다른 경우 - 단품이 변경 된경우
		if (buyQty.intValue() != cart.getBuyQty().intValue() || chageResult) {
			updateCartBuyQty(cart.getCartId(), buyQty);
			chageResult = true;
		}

		if (!chageResult) {
			throw new CustomException(ExceptionConstants.ERROR_ORDER_CART_NO_OPTION_CHAGE);
		}

	}

	
	/**
	 * <pre>장바구니 수량 변경</pre>
	 * 
	 * @param cartId
	 * @param buyQty
	 */
	@Override
	public void updateCartBuyQty(String cartId, Integer buyQty) {

		//------------------------------------------------
		// 1. 기존 장바구니 조회
		//------------------------------------------------
		CartSO so = new CartSO();
		so.setCartId(cartId);
		CartVO cart = this.cartDao.getCart(so);

		if (cart == null) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

		
		//------------------------------------------------
		// 2. 장바구니 수량 변경 Validation
		//    1) 최소 구매 수량보다 적을 경우
		//    2) 최대 구매 수량보다 큰경우
		//------------------------------------------------
		// 최소 구매수량 체크
		if (cart.getMinOrdQty() != null
				&& buyQty.intValue() < cart.getMinOrdQty().intValue()) {
			throw new CustomException(ExceptionConstants.ERROR_ORDER_CART_MIN_QTY);
		}

		// 재고 관리하는 경우
		if (CommonConstants.COMM_YN_Y.equals(cart.getStkMngYn())) {
			// 재고가 없는 경우
			if (cart.getWebStkQty().intValue() == 0 || (cart.getMinOrdQty() != null && cart.getMinOrdQty().intValue() > cart.getWebStkQty().intValue())) {
				throw new CustomException(ExceptionConstants.ERROR_ORDER_ITEM_WEB_STK_QTY);
			}

			// 재고는 존재하나 구매수량보다 부족 한 경우
			if ((buyQty.intValue() > cart.getWebStkQty().intValue())) {
				throw new CustomException(ExceptionConstants.ERROR_ORDER_ITEM_NOEW_WEB_STK_QTY, new String[] { String.valueOf(cart.getWebStkQty().intValue()) });
			}
		}

		// 최대 구매수량 체크
		if (cart.getMaxOrdQty() != null
				&& buyQty.intValue() > cart.getMaxOrdQty().intValue()) {
			throw new CustomException(ExceptionConstants.ERROR_ORDER_CART_MAX_QTY);
		}

		
		//------------------------------------------------
		// 3. 장바구니 수량 변경
		//------------------------------------------------
		CartPO po = new CartPO();
		po.setStId(cart.getStId());
		po.setCartId(cart.getCartId());
		po.setBuyQty(buyQty);

		int result = this.cartDao.updateCartBuyQty(po);

		if (result != 1) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
	}

	
	/**
	 * <pre>장바구니 단품 변경</pre>
	 * 
	 * @param cartId
	 * @param buyQty
	 */
	private void updateCartItem(Long stId, String cartId, String ssnId, Long mbrNo, String goodsId, Long newItemNo) {

		//------------------------------------------------
		// 1. 장바구니 단품 변경 Validation
		//    1) 기존 동일한 단품의 장바구니가 존재하는지 체크
		//------------------------------------------------
		CartSO so = new CartSO();
		so.setStId(stId);
		if (mbrNo != null && !CommonConstants.NO_MEMBER_NO.equals(mbrNo)) {
			so.setMbrNo(mbrNo);
		} else {
			so.setSsnId(ssnId);
		}
		so.setGoodsId(goodsId);
		so.setItemNo(newItemNo);
		so.setNowBuyYn(CommonConstants.COMM_YN_N);
		CartVO cart = this.cartDao.getCart(so);

		// 다른장바구니에 해당 단품이 존재하는 경우
		if (cart != null && !cartId.equals(cart.getCartId())) {
			throw new CustomException(ExceptionConstants.ERROR_ORDER_CART_DUPLICATE_ITEM);
		}

		
		//------------------------------------------------
		// 2. 장바구니 옵션 변경
		//------------------------------------------------
		CartPO po = new CartPO();
		po.setStId(stId);
		po.setCartId(cartId);
		po.setItemNo(newItemNo);

		int result = this.cartDao.updateCartOption(po);

		if (result != 1) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
	}

	
	/**
	 * <pre>현재 접속자의 일반장바구니 수(회원/비회원)</pre>
	 * 
	 * @param stId
	 * @param ssnId
	 * @param mbrNo
	 * @return
	 */
	@Override
	public Integer getCartCnt(Long stId, String ssnId, Long mbrNo) {
		CartSO so = new CartSO();
		so.setStId(stId);

		if (CommonConstants.NO_MEMBER_NO.equals(mbrNo)) {
			//비회원 장바구니 최초 ssnId 저장
			HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
			Cookie[] cookies = request.getCookies();
			String cartTempKey = ""; 
			if(cookies != null){
		         
				for(int i=0; i < cookies.length; i++){
					Cookie c = cookies[i] ;
		            if(c.getName().equals("CART_TEMP_KEY")) {
		            	cartTempKey = c.getValue() ;
		            	break;
		            }
				}
			}
			
			if(StringUtils.isNotEmpty(cartTempKey)) { 
				ssnId = cartTempKey;
			}
			
			so.setSsnId(ssnId);
		} else {
			so.setMbrNo(mbrNo);
		}

		return this.cartDao.getCartCnt(so);
	}
	
	/**
	 * <pre>장바구니에 적용 가능한  장바구니 쿠폰 목록 조회</pre>
	 * 
	 * @param mbrNo
	 * @param totGoodsAmt
	 * @return
	 */
	@Override
	public List<CartCouponVO> listCartCoupon(CartCouponSO so) {
		return this.cartDao.listCartCoupon(so);
	}

	
	/**
	 * <pre>장바구니에 적용 가능한  배송비 쿠폰 목록 조회</pre>
	 * 
	 * @param mbrNo
	 * @param cartIds
	 * @return
	 */
	@Override
	public CartCouponDlvrcVO getCartCouponDlvrc(CartCouponSO so) {
		return this.cartDao.getCartCouponDlvrc(so);
	}

	
	/**
	 * <pre>장바구니 상품 관심상품에 등록</pre>
	 * 
	 * @param cartIds
	 */
	@Override
	public void insertWishFromCart(String[] cartIds) {

		CartSO cso = null;
		CartVO cart = null;
		MemberInterestGoodsSO migso = null;
		MemberInterestGoodsPO migpo = null;
		MemberInterestGoodsVO miGoods = null;

		if (cartIds != null && cartIds.length > 0) {
			for (String cartId : cartIds) {
				cso = new CartSO();
				cso.setCartId(cartId);
				cart = this.cartDao.getCart(cso);

				if (cart != null) {
					migso = new MemberInterestGoodsSO();
					migso.setMbrNo(cart.getMbrNo());
					migso.setGoodsId(cart.getGoodsId());
					miGoods = this.memberInterestGoodsDao.getMemberInterestGoods(migso);

					if (miGoods == null) {
						migpo = new MemberInterestGoodsPO();
						migpo.setMbrNo(cart.getMbrNo());
						migpo.setGoodsId(cart.getGoodsId());
						migpo.setSysRegrNo(cart.getMbrNo());
						this.memberInterestGoodsDao.insertMemberInterestGoods(migpo);
					}
				} else {
					throw new CustomException(ExceptionConstants.ERROR_CART_NOT_EXISTS);
				}
			}

		} else {
			throw new CustomException(ExceptionConstants.ERROR_PARAM);
		}
	}
	
	@Override
	public List<CartGoodsVO> listValidGoodsStock(CartSO so) {
		List<CartVO> cartList = cartDao.listCart(so);
		
		List<String> goodsIds = new ArrayList<>();
		List<CartGoodsVO> checkList = new ArrayList<>();
		List<CartGoodsVO> checkSumList = new ArrayList<>();
		
		for(CartVO cart : cartList) {
			if(CommonConstants.GOODS_CSTRT_TP_SET.equals(cart.getGoodsCstrtTpCd())) {
				List<GoodsCstrtSetVO> setList = goodsCstrtSetDao.listGoodsCstrtSet(cart.getGoodsId());
				for(GoodsCstrtSetVO set : setList) {
					CartGoodsVO temp = new CartGoodsVO();
					temp.setGoodsId(set.getSubGoodsId());
					temp.setBuyQty(cart.getBuyQty() * set.getCstrtQty());
					checkList.add(temp);
				}
			}else if(CommonConstants.GOODS_CSTRT_TP_ITEM.equals(cart.getGoodsCstrtTpCd())){
				CartGoodsVO temp = new CartGoodsVO();
				temp.setGoodsId(cart.getGoodsId());
				temp.setBuyQty(cart.getBuyQty());
				checkList.add(temp);
			}
		}
		
		for(CartGoodsVO cart : checkList) {
			if(checkSumList.stream().anyMatch(vo -> cart.getGoodsId().equals(vo.getGoodsId()))) {
				for(int i=0; i<checkSumList.size(); i++) {
					if(cart.getGoodsId().equals(checkSumList.get(i).getGoodsId())){
						CartGoodsVO sum = checkSumList.get(i);
						sum.setBuyQty(sum.getBuyQty() + cart.getBuyQty());
					}
				}
			}else {
				CartGoodsVO temp = new CartGoodsVO();
				temp.setGoodsId(cart.getGoodsId());
				temp.setBuyQty(cart.getBuyQty());
				checkSumList.add(temp);
				goodsIds.add(cart.getGoodsId());
			}
		}
		
		CartGoodsSO cartGoodsSO = new CartGoodsSO();
		cartGoodsSO.setGoodsIds(goodsIds.toArray(new String[goodsIds.size()]));
		List<CartGoodsVO> stkList = cartDao.listValidGoodsStock(cartGoodsSO);
		
		for(CartGoodsVO vo : stkList) {
			if(CommonConstants.SALE_PSB_00.equals(vo.getSalePsbCd())) {
				CartGoodsVO chk = checkSumList.stream().filter(s -> s.getGoodsId().equals(vo.getGoodsId())).findFirst().get();
				if(chk.getBuyQty()  > vo.getStkQty()) {
					vo.setSalePsbCd(CommonConstants.SALE_PSB_40);
				}
			}
		}
		stkList = stkList.stream().filter(vo -> !CommonConstants.SALE_PSB_00.equals(vo.getSalePsbCd())).collect(Collectors.toList());
		return stkList;
	}
	
	@Override
	public List<CartGoodsVO> listCartCstrtGoodsInfo(CartGoodsSO so){
		return cartDao.listCartCstrtGoodsInfo(so);
	}


	@Override
	public CartFreebieRtnVO checkCartFreebie(List<CartVO> goodsList) {
		CartFreebieRtnVO rtn = new CartFreebieRtnVO();
		Boolean isOk = false;
		
		List<CartGoodsVO.Freebie> soldOutList = new ArrayList<>();
		List<CartGoodsVO.Freebie> lessStockList = new ArrayList<>();
		
		List<CartGoodsVO.Freebie> freebieList = new ArrayList<>();
		
		for(CartVO vo: goodsList) {
			List<CartGoodsVO.Freebie> tempList = cartDao.listFreebie(vo.getGoodsId());
			
			for(CartGoodsVO.Freebie frb : tempList) {
				/*
				 * 사은품 별 주문 수량 sum 
				*/
				Optional<CartGoodsVO.Freebie> optFrb = freebieList.stream().filter(fr -> fr.getGoodsId().equals(frb.getGoodsId())).findFirst();
				CartGoodsVO.Freebie findFrb = optFrb.orElse(frb);
				findFrb.setOrdQty(findFrb.getOrdQty() + vo.getBuyQty());
				
				if(!optFrb.isPresent()) {
					freebieList.add(findFrb);
				}
			}
		}
		
		//단품 세트 - 수량
		List<String> goodsStrList = goodsList.stream().map(CartVO::getGoodsId).collect(Collectors.toList());
		CartGoodsSO cartGoodsSO = new CartGoodsSO();
		cartGoodsSO.setGoodsIds(goodsStrList.toArray(new String[goodsStrList.size()]));
		
		List<CartGoodsVO> goodsInfoList = cartDao.listValidGoodsStock(cartGoodsSO);
		
		
		for(CartGoodsVO temp :goodsInfoList) {
			for(CartVO temp2 : goodsList) {
				if(temp.getGoodsId().equals(temp2.getGoodsId())) {
					temp.setBuyQty(temp2.getBuyQty());
				}
			}
		}
		
		List<CartGoodsVO> checkList = new ArrayList<>();
		
		for(CartGoodsVO cart : goodsInfoList) {
			if(CommonConstants.GOODS_CSTRT_TP_SET.equals(cart.getGoodsCstrtTpCd())) {
				List<GoodsCstrtSetVO> setList = goodsCstrtSetDao.listGoodsCstrtSet(cart.getGoodsId());
				for(GoodsCstrtSetVO set : setList) {
					CartGoodsVO temp = new CartGoodsVO();
					temp.setGoodsId(set.getSubGoodsId());
					temp.setBuyQty(cart.getBuyQty() * set.getCstrtQty());
					checkList.add(temp);
				}
			}else if(CommonConstants.GOODS_CSTRT_TP_ITEM.equals(cart.getGoodsCstrtTpCd())){
				CartGoodsVO temp = new CartGoodsVO();
				temp.setGoodsId(cart.getGoodsId());
				temp.setBuyQty(cart.getBuyQty());
				checkList.add(temp);
			}
		}
		
		//단품, 세트 주문에 사은품과 동일한 상품이 있는경우 수량 추가
		for(CartGoodsVO vo: checkList) {
			for(CartGoodsVO.Freebie frb : freebieList) {
				if(vo.getGoodsId().equals(frb.getGoodsId())) {
					frb.setOrdQty(frb.getOrdQty() + vo.getBuyQty());
				}
			}
		}

		List<CartGoodsVO.Freebie> orderFrbList = new ArrayList<>();
		
		for(int i=0; i<freebieList.size(); i++) {
			CartGoodsVO.Freebie frb = freebieList.get(i);
			if(frb.getQty() <= 0) {
				soldOutList.add(frb);
			}else if(frb.getQty() < frb.getOrdQty()) {
				lessStockList.add(frb);
			}else {
				orderFrbList.add(frb);
			}
		}
		
		if(soldOutList.size() > 0 && lessStockList.size() == 0) {
			rtn.setRtnCode("10");
			rtn.setFreebie(soldOutList.get(0));
		}else if(soldOutList.size() == 0 && lessStockList.size() > 0) {
			rtn.setRtnCode("20");
			rtn.setFreebie(lessStockList.get(0));
		}else if(soldOutList.size() > 0 && lessStockList.size() > 0) {
			rtn.setRtnCode("30");
			rtn.setFreebie(lessStockList.get(0));
		}else {
			isOk = true;
		}
		
		rtn.setIsOk(isOk);
		rtn.setFreebieList(orderFrbList);
		return rtn;
	}

	@Override
	public List<CartVO> listCart(CartSO so) {
		return cartDao.listCart(so);
	}
}
