package biz.app.order.service;

import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.Properties;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.ObjectUtils;

import biz.app.appweb.model.PushSO;
import biz.app.appweb.model.PushVO;
import biz.app.appweb.service.PushService;
import biz.app.cart.dao.CartDao;
import biz.app.cart.model.CartFreebieRtnVO;
import biz.app.cart.model.CartGoodsSO;
import biz.app.cart.model.CartGoodsSO.Cart;
import biz.app.cart.model.CartGoodsVO;
import biz.app.cart.model.CartGoodsVO.Freebie;
import biz.app.cart.model.CartPO;
import biz.app.cart.model.CartSO;
import biz.app.cart.model.CartVO;
import biz.app.cart.service.CartService;
import biz.app.claim.model.ClaimBasePO;
import biz.app.delivery.dao.DeliveryChargeDao;
import biz.app.delivery.model.DeliveryChargePO;
import biz.app.delivery.model.DeliveryChargeSO;
import biz.app.delivery.model.DeliveryChargeVO;
import biz.app.delivery.service.DeliveryChargeService;
import biz.app.goods.dao.GoodsCstrtSetDao;
import biz.app.goods.dao.GoodsPriceDao;
import biz.app.goods.dao.ItemDao;
import biz.app.goods.model.GoodsBaseSO;
import biz.app.goods.model.GoodsBaseVO;
import biz.app.goods.model.GoodsCstrtSetVO;
import biz.app.goods.service.GoodsStockService;
import biz.app.member.dao.MemberBaseDao;
import biz.app.member.dao.MemberCouponDao;
import biz.app.member.model.MemberAddressPO;
import biz.app.member.model.MemberBasePO;
import biz.app.member.model.MemberBaseSO;
import biz.app.member.model.MemberBaseVO;
import biz.app.member.model.MemberCouponPO;
import biz.app.member.model.MemberCouponSO;
import biz.app.member.model.MemberCouponVO;
import biz.app.member.service.MemberAddressService;
import biz.app.member.service.MemberCouponService;
import biz.app.member.service.MemberService;
import biz.app.order.dao.AplBnftDao;
import biz.app.order.dao.OrdDtlCstrtDao;
import biz.app.order.dao.OrdDtlCstrtDlvrMapDao;
import biz.app.order.dao.OrdSavePntDao;
import biz.app.order.dao.OrderBaseDao;
import biz.app.order.dao.OrderDao;
import biz.app.order.dao.OrderDetailDao;
import biz.app.order.dao.OrderDlvrAreaDao;
import biz.app.order.dao.OrderDlvraDao;
import biz.app.order.model.AplBnftPO;
import biz.app.order.model.AplBnftSO;
import biz.app.order.model.AplBnftVO;
import biz.app.order.model.BatchOrderVO;
import biz.app.order.model.CardcInstmntInfoSO;
import biz.app.order.model.CardcInstmntInfoVO;
import biz.app.order.model.OrdDtlCstrtDlvrMapPO;
import biz.app.order.model.OrdDtlCstrtPO;
import biz.app.order.model.OrdDtlCstrtVO;
import biz.app.order.model.OrdSavePntPO;
import biz.app.order.model.OrderAdbrixVO;
import biz.app.order.model.OrderBasePO;
import biz.app.order.model.OrderBaseSO;
import biz.app.order.model.OrderBaseVO;
import biz.app.order.model.OrderClaimVO;
import biz.app.order.model.OrderComplete;
import biz.app.order.model.OrderCoupon;
import biz.app.order.model.OrderDeliveryVO;
import biz.app.order.model.OrderDetailPO;
import biz.app.order.model.OrderDetailSO;
import biz.app.order.model.OrderDetailVO;
import biz.app.order.model.OrderDlvrAreaPO;
import biz.app.order.model.OrderDlvrAreaSO;
import biz.app.order.model.OrderDlvrAreaVO;
import biz.app.order.model.OrderDlvraPO;
import biz.app.order.model.OrderDlvraVO;
import biz.app.order.model.OrderException;
import biz.app.order.model.OrderListExcelVO;
import biz.app.order.model.OrderListSO;
import biz.app.order.model.OrderListVO;
import biz.app.order.model.OrderMsgVO;
import biz.app.order.model.OrderPayVO;
import biz.app.order.model.OrderReceiptVO;
import biz.app.order.model.OrderRegist;
import biz.app.order.model.OrderSO;
import biz.app.order.model.OrderStatusVO;
import biz.app.order.util.OrderUtil;
import biz.app.pay.dao.PayBaseDao;
import biz.app.pay.model.PayBasePO;
import biz.app.pay.model.PayBaseSO;
import biz.app.pay.model.PayBaseVO;
import biz.app.pay.model.PaymentException;
import biz.app.pay.model.PrsnCardBillingInfoPO;
import biz.app.pay.model.PrsnCardBillingInfoVO;
import biz.app.pay.model.PrsnPaySaveInfoPO;
import biz.app.pay.model.PrsnPaySaveInfoVO;
import biz.app.pay.service.PayBaseService;
import biz.app.pay.util.PayUtil;
import biz.app.promotion.dao.CouponDao;
import biz.app.promotion.model.CouponBaseVO;
import biz.app.promotion.model.CouponSO;
import biz.app.receipt.dao.CashReceiptDao;
import biz.app.receipt.model.CashReceiptGoodsMapPO;
import biz.app.receipt.model.CashReceiptPO;
import biz.app.system.dao.DepositAcctInfoDao;
import biz.app.system.model.CodeDetailVO;
import biz.app.system.model.DepositAcctInfoSO;
import biz.app.system.model.DepositAcctInfoVO;
import biz.app.system.model.PntInfoSO;
import biz.app.system.model.PntInfoVO;
import biz.app.system.service.CodeService;
import biz.app.system.service.PntInfoService;
import biz.common.model.SsgKkoBtnPO;
import biz.common.model.SsgMessageSendPO;
import biz.common.service.BizService;
import biz.common.service.CacheService;
import biz.interfaces.cis.model.request.order.SlotInquirySO;
import biz.interfaces.cis.model.response.order.SlotInquiryItemVO;
import biz.interfaces.cis.model.response.order.SlotInquiryVO;
import biz.interfaces.cis.service.CisOrderService;
import biz.interfaces.gsr.model.GsrException;
import biz.interfaces.gsr.model.GsrMemberPointPO;
import biz.interfaces.gsr.model.GsrMemberPointVO;
import biz.interfaces.gsr.service.GsrService;
import biz.interfaces.sktmp.constants.SktmpConstants;
import biz.interfaces.sktmp.model.SktmpLnkHistSO;
import biz.interfaces.sktmp.model.SktmpLnkHistVO;
import biz.interfaces.sktmp.model.request.apihub.ISR3K00110ReqVO;
import biz.interfaces.sktmp.model.response.apihub.ISR3K00110ResVO;
import biz.interfaces.sktmp.service.SktmpService;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import framework.common.util.CookieSessionUtil;
import framework.common.util.DateUtil;
import framework.common.util.MaskingUtil;
import framework.common.util.RequestUtil;
import framework.common.util.StringUtil;
import framework.front.constants.FrontConstants;
import lombok.extern.slf4j.Slf4j;

/**
 * <pre>
 * - 프로젝트명	: 11.business
 * - 패키지명		: biz.app.order.service
 * - 파일명		: OrderServiceImpl.java
 * - 작성일		: 2016. 3. 8.
 * - 작성자		: dyyoun
 * - 설명		: 주문 서비스 Impl
 * </pre>
 */
@Slf4j
@Service
@Transactional
public class OrderServiceImpl implements OrderService {

	@Autowired private CacheService cacheService;
	
	@Autowired private CodeService codeService;

	@Autowired private OrderBaseDao orderBaseDao;

	@Autowired private OrderDetailDao orderDetailDao;

	@Autowired private OrderDlvraDao orderDlvraDao;

	@Autowired private DeliveryChargeDao deliveryChargeDao;

	@Autowired private AplBnftDao aplBnftDao;

	@Autowired private PayBaseDao payBaseDao;

	@Autowired private Properties bizConfig;

	@Autowired private BizService bizService;

	@Autowired private CartService cartService;
	
	@Autowired private CartDao cartDao;
	
	@Autowired private MessageSourceAccessor message;

	@Autowired private OrderBaseService orderBaseService;

	@Autowired private PayBaseService payBaseService;

	@Autowired private MemberCouponService memberCouponService;

	@Autowired private DepositAcctInfoDao depositAcctInfoDao;

	@Autowired private CouponDao couponDao;

	@Autowired private CashReceiptDao cashReceiptDao;

	@Autowired private OrderDao orderDao;

	@Autowired private GoodsPriceDao goodsPriceDao;

	@Autowired private OrdDtlCstrtDao ordDtlCstrtDao;

	@Autowired private GsrService gsrService;

	@Autowired private GoodsStockService goodsStockService;

	@Autowired private MemberBaseDao memberBaseDao;
	
	@Autowired private PushService pushService;
	
	@Autowired private MemberAddressService memberAddressService;
	
	@Autowired private DeliveryChargeService deliveryChargeService;
	
	
	@Autowired private OrderDlvrAreaDao orderDlvrAreaDao;
	@Autowired private MemberCouponDao memberCouponDao;
	@Autowired private CisOrderService cisOrderService;
	@Autowired private GoodsCstrtSetDao goodsCstrtSetDao;
	
	@Autowired private OrdSavePntDao ordSavePntDao;
	
	@Autowired private ItemDao itemDao;
	
	@Autowired private OrdDtlCstrtDlvrMapDao ordDtlCstrtDlvrMapDao;
	
	@Autowired private MemberService memberService;
	@Autowired private PntInfoService pntInfoService;
	@Autowired private SktmpService sktmpService;
	/*
	 * 주문 등록 - 비활성화 상태로 등록
	 *
	 * @see biz.app.order.service.OrderService#insertOrder(biz.app.order.model.OrderRegist)
	 */
	@Override
	@Transactional(propagation = Propagation.NOT_SUPPORTED)
	public String insertOrder(OrderRegist ordRegist, OrderComplete ordComplete) {

		// 주문번호 채번
		String ordNo = this.orderBaseDao.getOrderNo();

		Long totalDlvrAmt = 0L;			// 총 배송비


		// 주문 프로세스 결과 코드
		String orderPrcsRstCd = CommonConstants.ORD_PRCS_RST_0000;
		String orderPrcsRstMsg = null;
		String exceptionCd = null;


		//------------------------------------------------
		// 변수 선언부
		//------------------------------------------------

		// 주문 기본정보
		OrderBasePO orderBase = new OrderBasePO();

		// 주문배송지 관련 선언
		OrderDlvraPO orderDlvra = null;
		Long ordDlvraNo = null;
		MemberAddressPO mapo = null;

		// 기본 결제수단 관련 선언
		PrsnPaySaveInfoPO prsnPaySaveInfo = null;

		// 주문상세 관련 선언
		List<OrderDetailPO> orderDetailList = new ArrayList<>();
		OrderDetailPO orderDetail = null;
		Integer orderDetailSeq = 0;
		Long totalGoodsPayAmt = 0L;

		// 주문상세구성 관련 선언
		List<OrdDtlCstrtVO> ordDtlCstrtList = new ArrayList<OrdDtlCstrtVO>();
		OrdDtlCstrtPO ordDtlCstrt = null;
		OrdDtlCstrtVO ordDtlCstrtVO = null;
		Integer ordDtlCstrtSeq = 0;


		// 배송비 관련 선언
		List<DeliveryChargePO> deliveryChargeList = new ArrayList<>();
		DeliveryChargePO deliveryCharge = null;
		Long dlvrcNo = null;

		// 쿠폰 정보
		List<OrderCoupon> goodsCouponList = new ArrayList<>();
		List<OrderCoupon> cartCouponList = new ArrayList<>();
		List<OrderCoupon> dlvrcCouponList = new ArrayList<>();
		OrderCoupon orderCoupon = null;

		// 적용혜택 관련 선언
		List<AplBnftPO> aplBnftList = new ArrayList<>();
		AplBnftPO aplBnft = null;

		// 결제 정보
		List<PayBasePO> payBaseList = new ArrayList<>();
		PayBasePO payBase = null;
		
		try {
			//------------------------------------------------
			// 1. 주문 쿠폰정보 생성
			//------------------------------------------------
			if (ordRegist.getCpInfos() != null && ordRegist.getCpInfos().length > 0) {

				for (String cpInfos : ordRegist.getCpInfos()) {
					String[] cpInfo = cpInfos.split("\\|");

					if(!cpInfo[2].trim().isEmpty()){

						// 0:구분, 1:장바구니아이디, 2:회원쿠폰번호, 3:할인단가, 4:할인금액, 5:쿠폰번호
						orderCoupon = new OrderCoupon();
						orderCoupon.setCpKindCd(cpInfo[0]);
						orderCoupon.setMbrCpNo(Long.valueOf(cpInfo[2]));
						// 할인금액의 경우 Math.Ceil함수로인하여 소수점이 발생할수 있으므로 소수점단위 삭제
						if (cpInfo[4] != null && !"".equals(cpInfo[4])) {
							int idx = cpInfo[4].indexOf('.');

							if (idx > -1) {
								cpInfo[4] = cpInfo[4].substring(0, idx);
							}

						}
						orderCoupon.setCpDcAmt(Long.valueOf(cpInfo[4]));

						orderCoupon.setCpNo(Long.valueOf(cpInfo[5]));

						if (CommonConstants.CP_KIND_10.equals(orderCoupon.getCpKindCd())) {
							orderCoupon.setCartId(cpInfo[1]);
							orderCoupon.setCpUnitAmt(Long.valueOf(cpInfo[3]));
							goodsCouponList.add(orderCoupon);
						} else if (CommonConstants.CP_KIND_20.equals(orderCoupon.getCpKindCd())) {

							cartCouponList.add(orderCoupon);
						} else if (CommonConstants.CP_KIND_30.equals(orderCoupon.getCpKindCd())) {
							//orderCoupon.setPkgDlvrNo(Integer.valueOf(cpInfo[1]));
							orderCoupon.setDlvrcPlcNo(Long.valueOf(cpInfo[1]));
							dlvrcCouponList.add(orderCoupon);
						}
					}

				}
			}

			//------------------------------------------------
			// 2. 주문 기본 정보 설정
			//------------------------------------------------

			// - 주문상태는 null로 설정 : 주문완료 후 설정
			// - 데이터상태는 비활성화 처리
			orderBase.setOrdNo(ordNo);
			orderBase.setStId(ordRegist.getStId());
			orderBase.setMbrNo(ordRegist.getMbrNo());
			orderBase.setOrdMdaCd(ordRegist.getOrdMdaCd());
			orderBase.setChnlId(ordRegist.getChnlId());
			//orderBase.setMbrGrdCd(ordRegist.getMbrGrdCd());
			orderBase.setOrdNm(ordRegist.getOrdNm());
			orderBase.setOrdrId(ordRegist.getOrdrId());
			orderBase.setOrdrEmail(ordRegist.getOrdrEmail());
			orderBase.setOrdrTel(ordRegist.getOrdrTel());
			orderBase.setOrdrMobile(ordRegist.getOrdrMobile());
			orderBase.setOrdrIp(ordRegist.getOrdrIp());
			orderBase.setOrdDtlCnt(ordRegist.getCartIds().length);
			orderBase.setDataStatCd(CommonConstants.DATA_STAT_00);
			orderBase.setOutsideOrdNo(null);
			orderBase.setDlvrPrcsTpCd(ordRegist.getDlvrPrcsTpCd());

			// 주문 기본 등록
			int ordBaseResult = this.orderBaseDao.insertOrderBase(orderBase);

			if (ordBaseResult != 1) {
				throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
			}

			//------------------------------------------------
			// 3. 주문 배송지 정보 설정
			//------------------------------------------------

			// 주문 배송지 번호 생성
			ordDlvraNo = this.bizService.getSequence(CommonConstants.SEQUENCE_ORDER_DLVRA_NO);

			orderDlvra = new OrderDlvraPO();
			orderDlvra.setOrdDlvraNo(ordDlvraNo);
			orderDlvra.setOrdNo(ordNo);
			orderDlvra.setAdrsNm(ordRegist.getAdrsNm());
			orderDlvra.setGbNm(ordRegist.getGbNm());
			orderDlvra.setTel(ordRegist.getAdrsTel());
			orderDlvra.setMobile(ordRegist.getAdrsMobile());
			orderDlvra.setPostNoNew(ordRegist.getPostNoNew());
			orderDlvra.setPostNoOld(ordRegist.getPostNoOld());
			orderDlvra.setPrclAddr(ordRegist.getPrclAddr());

			// 지번상세주소에 대한 입력을 받지 않으므로 없을 경우 도로명주소 상세를 입력
			if (ordRegist.getPrclDtlAddr() == null || "".equals(ordRegist.getPrclDtlAddr())) {
				orderDlvra.setPrclDtlAddr(ordRegist.getRoadDtlAddr());
			} else {
				orderDlvra.setPrclDtlAddr(ordRegist.getPrclDtlAddr());
			}
			orderDlvra.setRoadAddr(ordRegist.getRoadAddr());
			orderDlvra.setRoadDtlAddr(ordRegist.getRoadDtlAddr());
			orderDlvra.setGoodsRcvPstCd(ordRegist.getGoodsRcvPstCd());
			orderDlvra.setGoodsRcvPstEtc(ordRegist.getGoodsRcvPstEtc());
			orderDlvra.setPblGateEntMtdCd(ordRegist.getPblGateEntMtdCd());
			orderDlvra.setPblGatePswd(ordRegist.getPblGatePswd());
			orderDlvra.setDlvrDemandYn(ordRegist.getDlvrDemandYn());
			orderDlvra.setDlvrDemand(ordRegist.getDlvrDemand());

			//회원 정보 주소 반영 여부
			if(ordRegist.getMbrDlvraNo() == null) {
				//배송지 없는 경우
				if (CommonConstants.COMM_YN_Y.equals(ordRegist.getMbrAddrInsertYn())) {
					mapo = new MemberAddressPO();
					mapo.setMbrNo(ordRegist.getMbrNo());
					mapo.setGbNm(ordRegist.getGbNm());
					mapo.setAdrsNm(ordRegist.getAdrsNm());
					mapo.setTel(ordRegist.getAdrsTel());
					mapo.setMobile(ordRegist.getAdrsMobile());
					mapo.setPostNoNew(ordRegist.getPostNoNew());
					mapo.setPostNoOld(ordRegist.getPostNoOld());
					mapo.setPrclAddr(ordRegist.getPrclAddr());
					mapo.setPrclDtlAddr(ordRegist.getRoadDtlAddr()); // 지번상세주소에 대한 입력을 받지 않으므로 도로명주소 상세를 입력
					mapo.setRoadAddr(ordRegist.getRoadAddr());
					mapo.setRoadDtlAddr(ordRegist.getRoadDtlAddr());
					mapo.setGoodsRcvPstCd(ordRegist.getGoodsRcvPstCd());
					mapo.setGoodsRcvPstEtc(ordRegist.getGoodsRcvPstEtc());
					mapo.setPblGateEntMtdCd(ordRegist.getPblGateEntMtdCd());
					mapo.setPblGatePswd(ordRegist.getPblGatePswd());
					mapo.setDlvrDemand(ordRegist.getDlvrDemand());
					mapo.setDlvrDemandYn(ordRegist.getDlvrDemandYn());
					//배송지 없는 경우 기본배송지로 등록
					mapo.setDftYn("Y");
				}
			}else {
				//배송지 있는경우 결제 시 배송지 업데이트
				MemberAddressPO addrPO = new MemberAddressPO();
				addrPO.setMbrDlvraNo(ordRegist.getMbrDlvraNo());
				addrPO.setGbNm(ordRegist.getGbNm());
				addrPO.setAdrsNm(ordRegist.getAdrsNm());
				addrPO.setTel(ordRegist.getAdrsTel());
				addrPO.setMobile(ordRegist.getAdrsMobile());
				addrPO.setPostNoNew(ordRegist.getPostNoNew());
				addrPO.setPostNoOld(ordRegist.getPostNoOld());
				addrPO.setPrclAddr(ordRegist.getPrclAddr());
				addrPO.setPrclDtlAddr(ordRegist.getRoadDtlAddr()); // 지번상세주소에 대한 입력을 받지 않으므로 도로명주소 상세를 입력
				addrPO.setRoadAddr(ordRegist.getRoadAddr());
				addrPO.setRoadDtlAddr(ordRegist.getRoadDtlAddr());
				addrPO.setGoodsRcvPstCd(ordRegist.getGoodsRcvPstCd());
				addrPO.setGoodsRcvPstEtc(ordRegist.getGoodsRcvPstEtc());
				addrPO.setPblGateEntMtdCd(ordRegist.getPblGateEntMtdCd());
				addrPO.setPblGatePswd(ordRegist.getPblGatePswd());
				addrPO.setDlvrDemand(ordRegist.getDlvrDemand());
				addrPO.setDlvrDemandYn(ordRegist.getDlvrDemandYn());
				
				int mbrUpdResult = memberAddressService.updateMemberAddress(addrPO);
				if (mbrUpdResult != 1) {
					throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
				}
			}
			
			

			//------------------------------------------------
			// 4. 주문 상세 정보 (적용 혜택, 배송비, 사은품 설정)
			//------------------------------------------------

			// 4-1. 장바구니 아이디가 존재하지 않는 경우
			if (ordRegist.getCartIds() == null || ordRegist.getCartIds().length == 0) {
				throw new CustomException(ExceptionConstants.ERROR_ORDER_NO_GOODS);
			}

			// 4-2. 장바구니로부터 상품 조회

			List<Cart> soList = new ArrayList<>();
			Cart tempCart = null;
			
			for(String cartId : ordRegist.getCartIds()) {
				tempCart = new Cart();
				tempCart.setCartId(cartId);
				for(OrderCoupon goodsCoupon : goodsCouponList) {
					if(cartId.equals(goodsCoupon.getCartId())) {
						tempCart.setSelMbrCpNo(goodsCoupon.getMbrCpNo());
					}
				}
				soList.add(tempCart);
			}

			CartGoodsSO cso = new CartGoodsSO();
			cso.setWebMobileGbCd(ordRegist.getWebMobileGbCd());
			cso.setStId(ordRegist.getStId());
			cso.setMbrNo(ordRegist.getMbrNo());
			cso.setCartList(soList);

			// 웹 모바일 구분 (상품 가격 조회 시 필요)
			/*if (CommonConstants.ORD_MDA_20.equals(ordRegist.getOrdMdaCd())) {
				cso.setWebMobileGbCd(CommonConstants.WEB_MOBILE_GB_20);
			} else {
				cso.setWebMobileGbCd(CommonConstants.WEB_MOBILE_GB_10);
			}*/
			List<CartGoodsVO> cartList = this.cartService.listCartGoods(cso, ordRegist.getLocalPostYn());
			
			List<CartVO> goodsList = new ArrayList<>();
			CartVO tempCart2 = null;
			for(CartGoodsVO tempVO : cartList) {
				tempCart2 = new CartVO();
				tempCart2.setGoodsId(tempVO.getGoodsId());
				tempCart2.setBuyQty(tempVO.getBuyQty());
				goodsList.add(tempCart2);
			}
			
			CartFreebieRtnVO frbRtn = cartService.checkCartFreebie(goodsList);
			List<Freebie> frbList = frbRtn.getFreebieList();
			
			// 4-2-1. 조회된 상품목록이 존재하지 않을 경우
			if (cartList == null || cartList.isEmpty()) {
				throw new CustomException(ExceptionConstants.ERROR_ORDER_NO_GOODS);
			}

			for (CartGoodsVO cart : cartList) {
				//주문 구성 순번 초기화
				ordDtlCstrtSeq = 0;
				//------------------------------------------------
				// 1) Validation : 상품이 주문가능한 상태와 재고 상태 체크
				if (!CommonConstants.SALE_PSB_00.equals(cart.getSalePsbCd())) {
					if (CommonConstants.SALE_PSB_30.equals(cart.getSalePsbCd())) {
						throw new CustomException(ExceptionConstants.ERROR_ORDER_WEB_STK_QTY);
					}

					throw new CustomException(ExceptionConstants.ERROR_ORDER_SALE_PSB);
				}


				//------------------------------------------------
				// 2) 주문 상세 정보 설정
				orderDetailSeq++;

				orderDetail = new OrderDetailPO();
				orderDetail.setOrdNo(ordNo);
				orderDetail.setOrdDtlSeq(orderDetailSeq);
				orderDetail.setOrdDtlStatCd(null);					// 주문완료시 처리
				orderDetail.setGoodsId(cart.getGoodsId());
				orderDetail.setGoodsNm(cart.getGoodsNm());
				orderDetail.setItemNo(cart.getItemNo());
				orderDetail.setItemNm(cart.getItemNm());
				orderDetail.setPakGoodsId(cart.getPakGoodsId());
				orderDetail.setDispClsfNo(cart.getDispClsfNo());
				orderDetail.setCompGoodsId(cart.getCompGoodsId());
				orderDetail.setCompItemId(cart.getCompItemId());
				orderDetail.setOrdQty(cart.getBuyQty());
				orderDetail.setRmnOrdQty(cart.getBuyQty());
				orderDetail.setGoodsPrcNo(cart.getGoodsPrcNo());
				if(CommonConstants.GOODS_AMT_TP_60.equals(cart.getGoodsAmtTpCd())) {
					orderDetail.setRsvGoodsYn(CommonConstants.COMM_YN_Y);
				}
				orderDetail.setSaleAmt(cart.getSalePrc());
				orderDetail.setPayAmt(cart.getSalePrc());
				orderDetail.setRmnPayAmt(0L);
				orderDetail.setTaxGbCd(cart.getTaxGbCd());			// 과세 구분 코드
				orderDetail.setOrdDlvraNo(ordDlvraNo);				// 배송지 번호
				orderDetail.setFreeDlvrYn(cart.getFreeDlvrYn());	// 상품 : 무료 배송 여부
				orderDetail.setOrdSvmn(0L);
				orderDetail.setMdUsrNo(cart.getMdUsrNo());
				orderDetail.setCms(OrderUtil.getGoodsCms(cart.getSalePrc(), cart.getGoodsCmsRate()));	// 수수료
				orderDetail.setGoodsCmsnRt(cart.getGoodsCmsRate());										// 수수료율
				
				orderDetail.setMkiGoodsYn(cart.getMkiGoodsYn());
				orderDetail.setMkiGoodsOptContent(cart.getMkiGoodsOptContent());
				orderDetail.setHotDealYn(CommonConstants.COMM_YN_N);

				orderDetail.setCompNo(cart.getCompNo());
				orderDetail.setUpCompNo(cart.getUpCompNo());
				orderDetail.setMbrNo(ordRegist.getMbrNo());
				orderDetail.setOutsideOrdDtlNo(null);

				/**
				 * 세트상품 정보 select.
				 */
				ordDtlCstrt = new OrdDtlCstrtPO();
				ordDtlCstrt.setCstrtGoodsId(orderDetail.getGoodsId());
				List<OrdDtlCstrtVO> list = ordDtlCstrtDao.listOrdDtlCstrtForOrder(ordDtlCstrt);
				
				for(int i=0;i<list.size();i++) {
					OrdDtlCstrtVO vo = new OrdDtlCstrtVO();
					
					OrdDtlCstrtVO temp = list.get(i);
					// 일련번호
					vo.setOrdDtlCstrtNo(Integer.parseInt(String.valueOf(bizService.getSequence(CommonConstants.SEQUENCE_ORD_DTL_CSTRT))));
					vo.setOrdNo(ordNo); // 주문번호
					vo.setOrdDtlSeq(orderDetail.getOrdDtlSeq());
					vo.setOrdCstrtSeq(++ordDtlCstrtSeq);
					vo.setCstrtGoodsId(temp.getCstrtGoodsId());
					vo.setSkuCd(temp.getSkuCd());
					vo.setCstrtGoodsGbCd(temp.getCstrtGoodsGbCd());
					vo.setCstrtQty(temp.getCstrtQty());
					vo.setOrgSaleAmt(temp.getOrgSaleAmt());
					vo.setSaleAmt(temp.getSaleAmt());
					
					ordDtlCstrtList.add(vo);
				}

				//------------------------------------------------
				// 3) 프로모션 가격 할인 정보 적용 혜택에 등록
				if (cart.getPrmtDcAmt().longValue() > 0 && cart.getPrmtNo().longValue() > 0) {
					// 적용 혜택 생성
					aplBnft = new AplBnftPO();
					aplBnft.setOrdNo(ordNo);
					aplBnft.setOrdDtlSeq(orderDetail.getOrdDtlSeq());
					aplBnft.setAplBnftGbCd(CommonConstants.APL_BNFT_GB_10);
					aplBnft.setAplBnftTpCd(CommonConstants.APL_BNFT_TP_110);
					aplBnft.setAplNo(cart.getPrmtNo());
					aplBnft.setAplAmt(cart.getPrmtDcAmt());
					aplBnft.setRmnAplAmt(0L);
					aplBnft.setCncYn(CommonConstants.COMM_YN_N);
					aplBnft.setCompBdnAmt(OrderUtil.getCompDvdAmt(cart.getPrmtDcAmt(), cart.getPrmtCompDvdRate()));

					// 적용혜택 목록 추가
					aplBnftList.add(aplBnft);

					// 결제금액 제조정 (원 결제금액 - 프로모션 할인 금액)
					orderDetail.setPayAmt(orderDetail.getPayAmt() - cart.getPrmtDcAmt());
				}


				//------------------------------------------------
				// 4) 배송비 정보 설정
				boolean addDlvrChage = false;			// 배송비 추가 여부

				// 배송비 정보 생성 - 묶은 주문과 일반 주문을 나누어 계산한다.
				if (CommonConstants.COMM_YN_Y.equals(cart.getPkgDlvrYn())) {
					// 배송비 정보가 기 등록되었는지 판단
					// - 존재하는 경우 배송비번호만 설정
					// - 미 존재시 신규 추가
					boolean dlvrChargeExists = false;	// 묶음 배송비 추가 여부
					if (deliveryChargeList != null && !deliveryChargeList.isEmpty()) {
						for (DeliveryChargePO dcpo : deliveryChargeList) {
							// 동일한 배송비 패키지 번호가 배송비목록에 존재하는지 체크
							if (dcpo.getPkgDlvrNo().equals(cart.getPkgDlvrNo())) {
								dlvrChargeExists = true;
								dlvrcNo = dcpo.getDlvrcNo();
							}
						}
					}

					if (dlvrChargeExists) {
						orderDetail.setDlvrcNo(dlvrcNo);
					} else {
						addDlvrChage = true;
					}

				} else {
					addDlvrChage = true;
				}

				// 배송비 정보 추가
				if (addDlvrChage) {
					dlvrcNo = this.bizService.getSequence(CommonConstants.SEQUENCE_DLVRC_NO_SEQ);

					deliveryCharge = new DeliveryChargePO();
					deliveryCharge.setDlvrcNo(dlvrcNo);
					deliveryCharge.setOrgDlvrAmt(cart.getPkgOrgDlvrAmt() + cart.getPkgAddDlvrAmt());	// 원배송비는 기본배송비 + 추가배송비
					deliveryCharge.setRealDlvrAmt(cart.getPkgDlvrAmt() + cart.getPkgAddDlvrAmt());		// 실배송비는 실배송비 + 추가배송비
					deliveryCharge.setAddDlvrAmt(cart.getPkgAddDlvrAmt());
					deliveryCharge.setCostGbCd(CommonConstants.COST_GB_10);
					deliveryCharge.setDlvrcCdtCd(cart.getDlvrcCdtCd());
					deliveryCharge.setDlvrcCdtStdCd(cart.getDlvrcCdtStdCd());
					deliveryCharge.setDlvrcPayMtdCd(cart.getDlvrcPayMtdCd());
					deliveryCharge.setDlvrcPlcNo(cart.getDlvrcPlcNo());
					deliveryCharge.setDlvrcStdCd(cart.getDlvrcStdCd());
					deliveryCharge.setBuyPrc(cart.getDlvrcBuyPrc());
					deliveryCharge.setBuyQty(cart.getDlvrcBuyQty());
					deliveryCharge.setDlvrStdAmt(cart.getDlvrcDlvrAmt());
					deliveryCharge.setAddDlvrStdAmt(cart.getDlvrcAddDlvrAmt());
					deliveryCharge.setPrepayGbCd(CommonConstants.PREPAY_GB_10);		// 선착불코드는 주문시 결제방법코드가 선불만 존재하므로 고정 값
					deliveryCharge.setPkgDlvrNo(cart.getPkgDlvrNo());				// 장바구니 묶음 배송비 번호

					totalDlvrAmt += cart.getPkgDlvrAmt() + cart.getPkgAddDlvrAmt();

					deliveryChargeList.add(deliveryCharge);

					// 주문상세에 배송비 번호 설정
					orderDetail.setDlvrcNo(dlvrcNo);
				}


				//------------------------------------------------
				// 5) 적용혜택 정보 설정 : 상품 쿠폰
				if (goodsCouponList != null && !goodsCouponList.isEmpty()) {
					for (OrderCoupon ordCoupon : goodsCouponList) {
						// 장바구니 번호가 동일한 경우
						if (cart.getCartId().equals(ordCoupon.getCartId())) {
							aplBnft = new AplBnftPO();
							aplBnft.setOrdNo(ordNo);
							aplBnft.setOrdDtlSeq(orderDetail.getOrdDtlSeq());
							aplBnft.setAplBnftGbCd(CommonConstants.APL_BNFT_GB_20);
							aplBnft.setAplBnftTpCd(CommonConstants.APL_BNFT_TP_210);
							aplBnft.setAplNo(ordCoupon.getCpNo());
							aplBnft.setMbrCpNo(ordCoupon.getMbrCpNo());
							aplBnft.setAplAmt(ordCoupon.getCpUnitAmt());
							aplBnft.setRmnAplAmt(0L);

							// 업체 분담금액 계산
							Long compBdnAmt;

							CouponSO cpso = new CouponSO();
							cpso.setMbrCpNo(ordCoupon.getMbrCpNo());
							CouponBaseVO couponBase = this.couponDao.getCouponBase(cpso);

							if (couponBase != null) {
								compBdnAmt = OrderUtil.getCompDvdAmt(ordCoupon.getCpDcAmt(), couponBase.getSplCompDvdRate());
							} else {
								throw new CustomException(ExceptionConstants.ERROR_COUPON_NO_DATA);
							}

							aplBnft.setCompBdnAmt(compBdnAmt);
							aplBnft.setCncYn(CommonConstants.COMM_YN_N);

							// 적용혜택 목록 추가
							aplBnftList.add(aplBnft);

							// //결제금액 제조정 (원결제금액 - 쿠폰 할인 금액)
							orderDetail.setPayAmt(orderDetail.getPayAmt() - ordCoupon.getCpUnitAmt());

						}
					}
				}

				totalGoodsPayAmt += orderDetail.getPayAmt() * orderDetail.getOrdQty();

				orderDetailList.add(orderDetail);

				List<OrdDtlCstrtVO> duplCheckList = new ArrayList<OrdDtlCstrtVO>();
				//------------------------------------------------
				// 6) 사은품 정보 및 적용혜택 정보 설정
				if (CollectionUtils.isNotEmpty(frbList) && CollectionUtils.isNotEmpty(cart.getFreebieList())) {
					for (Freebie freebie : cart.getFreebieList()) {
						//주문 사은품 목록 비교
						boolean isExistFrb = frbList.stream().anyMatch(frb -> frb.getGoodsId().equals(freebie.getGoodsId()));
						if(isExistFrb) {
							int frbQty = Integer.parseInt(String.valueOf(cart.getFreebieList().stream().filter(vo -> freebie.getGoodsId().equals(vo.getGoodsId())).count()));
							// 주문수량 보다 많을 경우만 사은품 지급 2021-03-28
							// 주문수량 보다  적을경우는 아예 지급하지 않음
							if(!duplCheckList.stream().anyMatch(vo -> freebie.getGoodsId().equals(vo.getCstrtGoodsId()))) {
								ordDtlCstrtVO = new OrdDtlCstrtVO();
								
								// 일련번호
								ordDtlCstrtVO.setOrdDtlCstrtNo(Integer.parseInt(String.valueOf(bizService.getSequence(CommonConstants.SEQUENCE_ORD_DTL_CSTRT))));
								ordDtlCstrtVO.setOrdNo(ordNo); // 주문번호
								ordDtlCstrtVO.setOrdDtlSeq(orderDetail.getOrdDtlSeq());
								ordDtlCstrtVO.setOrdCstrtSeq(++ordDtlCstrtSeq);
								ordDtlCstrtVO.setCstrtGoodsId(freebie.getGoodsId());
								ordDtlCstrtVO.setSkuCd(freebie.getSkuCd());
								ordDtlCstrtVO.setCstrtGoodsGbCd(CommonConstants.CSTRT_GOODS_GB_30);
								//사은품은 orderDetail 당 1개 증정- 계산 시 ordQty * cstrtQty
								ordDtlCstrtVO.setCstrtQty(frbQty);
								ordDtlCstrtVO.setOrgSaleAmt(freebie.getOrgSaleAmt());
								ordDtlCstrtVO.setSaleAmt(freebie.getSaleAmt());
								
								// 사은품 목록 추가
								ordDtlCstrtList.add(ordDtlCstrtVO);
								duplCheckList.add(ordDtlCstrtVO);
							}
							// 적용혜택 정보 생성
							aplBnft = new AplBnftPO();
							aplBnft.setOrdNo(ordNo);
							aplBnft.setOrdDtlSeq(orderDetail.getOrdDtlSeq());
							aplBnft.setAplBnftGbCd(CommonConstants.APL_BNFT_GB_10);
							aplBnft.setAplBnftTpCd(CommonConstants.APL_BNFT_TP_120);
							//max(prmtNo)
							aplBnft.setAplNo(freebie.getPrmtNo());
							aplBnft.setRmnAplAmt(0L);
							aplBnft.setCncYn(CommonConstants.COMM_YN_N);
							
							// 적용혜택 목록 추가
							aplBnftList.add(aplBnft);
						}
					}
				}
			}

			//------------------------------------------------
			// 7) 배송비 쿠폰 적용
			if (dlvrcCouponList != null && !dlvrcCouponList.isEmpty()) {

				// 배송지 쿠폰 사용내역이 존재하나 배송비 내역이 존재하지 않은 경우 에러
				if (deliveryChargeList == null || deliveryChargeList.isEmpty()) {
					throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
				}

				for (OrderCoupon ordCoupon : dlvrcCouponList) {
					for (int i = 0; i < deliveryChargeList.size(); i++) {
						deliveryCharge = deliveryChargeList.get(i);

						// 배송 패키지 번호 동일한 경우 할인 적용
						// 2020.03.16 변경 - 배송정책 번호 별 쿠폰 적용
						if (ordCoupon.getDlvrcPlcNo().equals(deliveryCharge.getDlvrcPlcNo())) {

							deliveryCharge.setCpNo(ordCoupon.getCpNo());
							deliveryCharge.setMbrCpNo(ordCoupon.getMbrCpNo());
							deliveryCharge.setCpDcAmt(ordCoupon.getCpDcAmt());

							Long realDlvrAmt = deliveryCharge.getRealDlvrAmt() - ordCoupon.getCpDcAmt();

							totalDlvrAmt -= ordCoupon.getCpDcAmt();

							deliveryCharge.setRealDlvrAmt(realDlvrAmt);
							deliveryChargeList.set(i, deliveryCharge);
						}
					}
				}
			}
			//------------------------------------------------
			// 8) 장바구니 쿠폰 적용
			if (cartCouponList != null && !cartCouponList.isEmpty()) {

				for (OrderCoupon ordCoupon : cartCouponList) {
					// 장바구니 쿠폰 정보
					CouponSO cpso = new CouponSO();
					cpso.setMbrCpNo(ordCoupon.getMbrCpNo());
					CouponBaseVO couponBase = this.couponDao.getCouponBase(cpso);

					if (couponBase == null) {
						throw new CustomException(ExceptionConstants.ERROR_COUPON_NO_DATA);
					}

					// 전체 주문금액 totalGoodsPayAmt
					Long cartTotalDcAmt = ordCoupon.getCpDcAmt();	// 장바구니 전체 할인 금액
					Long rmnTotalDcAmt = ordCoupon.getCpDcAmt();	// 장바구니 잔여 할인 금액
					Long cpDcAmt;									// 주문상세 단위 할인 금액
					Long cpUnitAmt;									// 주문상세 단위 단가 금액

					for (int i = 0; i < orderDetailList.size(); i++) {
						orderDetail = orderDetailList.get(i);

						Long orderDetailPayAmt = orderDetail.getPayAmt() * orderDetail.getOrdQty();

						// 주문 상세단위 총 결제금액에 따른 금액 계산
						if (i == orderDetailList.size() - 1) {
							cpDcAmt = rmnTotalDcAmt;
						} else {
							cpDcAmt = (long) (cartTotalDcAmt * OrderUtil.getRate(totalGoodsPayAmt, orderDetailPayAmt));
						}

						// 주문상세단위 단가 계산
						cpUnitAmt = cpDcAmt / orderDetail.getOrdQty();

						// 10단위 값 내림 처리
						cpUnitAmt = (long) Math.floor((cpUnitAmt.doubleValue() / 10.0)) * 10;

						// 기존 계산된 쿠폰할인금액을 단가로 계산 후 재설정
						cpDcAmt = cpUnitAmt * orderDetail.getOrdQty();

						// 잔여 총 할인 금액 계산
						rmnTotalDcAmt = rmnTotalDcAmt - cpDcAmt;

						// 8-1) 적용 혜택 생성
						aplBnft = new AplBnftPO();
						aplBnft.setOrdNo(orderDetail.getOrdNo()); 
						aplBnft.setOrdDtlSeq(orderDetail.getOrdDtlSeq());
						aplBnft.setAplBnftGbCd(CommonConstants.APL_BNFT_GB_20);
						aplBnft.setAplBnftTpCd(CommonConstants.APL_BNFT_TP_220);
						aplBnft.setAplNo(ordCoupon.getCpNo());
						aplBnft.setRmnAplAmt(0L);
						aplBnft.setMbrCpNo(ordCoupon.getMbrCpNo());
						aplBnft.setAplAmt(cpUnitAmt);

						// 8-2) 업체 분담금액 계산
						Long compBdnAmt = OrderUtil.getCompDvdAmt(cpUnitAmt, couponBase.getSplCompDvdRate());
						aplBnft.setCompBdnAmt(compBdnAmt);
						aplBnft.setCncYn(CommonConstants.COMM_YN_N);


						// 8-3) 주문상세 결제 금액 갱신
						// 결제금액 재조정 (원결제금액 - 쿠폰 할인 금액)
						orderDetail.setPayAmt(orderDetail.getPayAmt() - cpUnitAmt);

						// 8-4) 장바구니 할인 잔여 금액 처리
						if (i == orderDetailList.size() - 1 && rmnTotalDcAmt > 0) {
							aplBnft.setRmnAplAmt(rmnTotalDcAmt);
							orderDetail.setRmnPayAmt(rmnTotalDcAmt * -1);
						}

						// 적용혜택 목록 추가
						aplBnftList.add(aplBnft);
						// 주문 상세 목록 갱신
						orderDetailList.set(i, orderDetail);
					}
				}
			}

			Long totalGoodsPayAmtAfterCartDc = 0L;

			for (int i = 0; i < orderDetailList.size(); i++) {
				orderDetail = orderDetailList.get(i);
				totalGoodsPayAmtAfterCartDc += orderDetail.getPayAmt() * orderDetail.getOrdQty();
			}

			//기준금액 : 결제금액 - 배송비 - 사용포인트(GS 포인트, MP 포인트)
			Long stdAmt = ordRegist.getPayAmt() - totalDlvrAmt;
			
			//------------------------------------------------
			// 9) GS 포인트 계산
			//------------------------------------------------
			//2021-06-14 실시간 조회로 DB CodeService 조회
			//2021-07-26 DB 조회로 변경
			PntInfoSO pntSO = new PntInfoSO();
			pntSO.setPntTpCd(CommonConstants.PNT_TP_GS);
			PntInfoVO gsPntVO = pntInfoService.getPntInfo(pntSO);
			
			if(gsPntVO != null) {
				double gsPntRate = gsPntVO.getSaveRate() == null ? 0d : gsPntVO.getSaveRate()  * 0.01;
				
				if(stdAmt < 0) {
					stdAmt = 0L;
				}
				for (int i = 0; i < orderDetailList.size(); i++) {
					orderDetail = orderDetailList.get(i);
					
					Long orderDetailPayAmt = orderDetail.getPayAmt() * orderDetail.getOrdQty();
					//준회원 일 경우 적립포인트 0
					if(stdAmt.equals(0L) || totalGoodsPayAmtAfterCartDc.equals(0L)) {
						orderDetail.setIsuSchdPnt(0);
					}else {
						// 기준금액 * (주문디테일지불금액 / 전체 주문금액) * 지급비율
						int savePoint = (int) Math.ceil(stdAmt.doubleValue()* (orderDetailPayAmt.doubleValue() / totalGoodsPayAmtAfterCartDc.doubleValue()) * gsPntRate);
						orderDetail.setIsuSchdPnt(savePoint);
					}
					
					orderDetailList.set(i, orderDetail);
				}
			}

			
			//환불 : 주결제 -> GS 포인트 -> MP 포인트
			//------------------------------------------------
			// 5-1. 결제 정보 설정 : MP 포인트
			//------------------------------------------------
			if (ordRegist.getUseMpPoint() != null && ordRegist.getUseMpPoint().intValue() > 0) {

				// 결제정보 생성
				payBase = new PayBasePO();
				Long payNo = this.bizService.getSequence(CommonConstants.SEQUENCE_PAY_BASE_SEQ);

				payBase.setPayNo(payNo);
				payBase.setOrdClmGbCd(CommonConstants.ORD_CLM_GB_10);
				payBase.setOrdNo(ordNo);
				payBase.setPayGbCd(CommonConstants.PAY_GB_10);
				payBase.setPayAmt(ordRegist.getUseMpPoint());
				payBase.setPayStatCd(CommonConstants.PAY_STAT_00);			// 입금대기
				payBase.setPayMeansCd(CommonConstants.PAY_MEANS_81);
				payBase.setCncYn(CommonConstants.COMM_YN_N);

				payBaseList.add(payBase);
			}
			
			
			pntSO = new PntInfoSO();
			pntSO.setPntTpCd(CommonConstants.PNT_TP_MP);
			PntInfoVO mpPntVO = pntInfoService.getPntInfo(pntSO);
			
			if(mpPntVO != null && StringUtils.isNotEmpty(ordRegist.getMpCardNo())) {
				ISR3K00110ReqVO saveReq = new ISR3K00110ReqVO();
				saveReq.setEBC_NUM1(ordRegist.getMpCardNo());
				saveReq.setGOODS_CD(mpPntVO.getIfGoodsCd());
				ISR3K00110ResVO saveRes = sktmpService.getMpSaveRmnCount(saveReq);
				
				//MP 포인트 데이터 생성 - 포인트 카드번호있을 경우 적립 or 사용 포인트 있는경우
				if((ordRegist.getUseMpPoint() != null && ordRegist.getUseMpPoint().intValue() > 0)
						|| (stdAmt > 0 && saveRes != null && Integer.valueOf(saveRes.getACCUM_CNT()) > 0)) {
					
					
					//적립 예정 포인트 계산
					Long saveSchdPnt = 0L;
					Long addSaveSchdPnt = 0L;
					Double saveRate = mpPntVO.getSaveRate() == null ? 0D : mpPntVO.getSaveRate() * 0.01;
					Double addSaveRate = mpPntVO.getAddSaveRate() == null ? 0D : mpPntVO.getAddSaveRate() * 0.01;
					
					
					if(saveRes != null && Integer.valueOf(saveRes.getACCUM_CNT()) > 0) {
						Long allSavePnt = (long)Math.floor(stdAmt.doubleValue() * (saveRate + addSaveRate));
						
						if(!allSavePnt.equals(0L)) {
							Long maxSavePnt = mpPntVO.getMaxSavePnt() == null ? 0L : mpPntVO.getMaxSavePnt();
							
							if(!maxSavePnt.equals(0L)) {
								if(allSavePnt > maxSavePnt) {
									allSavePnt = maxSavePnt;
								}
							}
							
							if(!addSaveRate.equals(0D)) {
								saveSchdPnt = (long)Math.floor(stdAmt.doubleValue() * saveRate);
								addSaveSchdPnt = allSavePnt - saveSchdPnt;
							}else {
								saveSchdPnt = allSavePnt;
								addSaveSchdPnt = 0L;
							}
						}
					}
					
					Long mpLnkHistNo = this.bizService.getSequence(CommonConstants.SEQUENCE_SKTMP_LNK_HIST_SEQ);
					SktmpLnkHistVO mpVO = new SktmpLnkHistVO();
					mpVO.setMpLnkHistNo(mpLnkHistNo);
					mpVO.setPntNo(mpPntVO.getPntNo());
					mpVO.setOrdNo(ordNo);
					mpVO.setMpRealLnkGbCd(CommonConstants.MP_REAL_LNK_GB_10);
					mpVO.setCardNo(ordRegist.getMpCardNo());
					mpVO.setPinNo(ordRegist.getPinNo());
					mpVO.setIfGoodsCd(mpPntVO.getIfGoodsCd());
					
					Long dealAmt = 0L;
					//적립 횟수가 없는 경우 사용포인트와 동일하게 요청
					if(Integer.valueOf(saveRes.getACCUM_CNT()) == 0 && stdAmt > 0) {
						dealAmt = Optional.ofNullable(ordRegist.getRealUseMpPoint()).orElse(0L);
					}else {
						dealAmt = stdAmt + Optional.ofNullable(ordRegist.getRealUseMpPoint()).orElse(0L);
					}
					
					mpVO.setDealAmt(dealAmt);
					if(ordRegist.getUseMpPoint() != null && ordRegist.getUseMpPoint().intValue() > 0) {
						mpVO.setMpLnkGbCd(CommonConstants.MP_LNK_GB_10);
						mpVO.setUsePnt(ordRegist.getRealUseMpPoint());
						mpVO.setAddUsePnt(ordRegist.getUseMpPoint() - ordRegist.getRealUseMpPoint());
					}else {
						mpVO.setMpLnkGbCd(CommonConstants.MP_LNK_GB_30);
					}
					
					mpVO.setSaveSchdPnt(saveSchdPnt);
					mpVO.setAddSaveSchdPnt(addSaveSchdPnt);
					
					sktmpService.insertSktmpLnkHist(mpVO);
					
					OrderBasePO ordBasePO = new OrderBasePO();
					ordBasePO.setOrdNo(ordNo);
					ordBasePO.setMpLnkHistNo(mpLnkHistNo);
					
					this.orderBaseDao.updateOrderBase(ordBasePO);
				}
				
			}
			
			//------------------------------------------------
			// 5-2. 결제 정보 설정 : GS 포인트
			//------------------------------------------------
			if (ordRegist.getUseGsPoint() != null && ordRegist.getUseGsPoint().intValue() > 0) {
				// 결제정보 생성
				payBase = new PayBasePO();
				Long payNo = this.bizService.getSequence(CommonConstants.SEQUENCE_PAY_BASE_SEQ);

				payBase.setPayNo(payNo);
				payBase.setOrdClmGbCd(CommonConstants.ORD_CLM_GB_10);
				payBase.setOrdNo(ordNo);
				payBase.setPayGbCd(CommonConstants.PAY_GB_10);
				payBase.setPayAmt(ordRegist.getUseGsPoint());
				payBase.setPayStatCd(CommonConstants.PAY_STAT_00);			// 입금대기
				payBase.setPayMeansCd(CommonConstants.PAY_MEANS_80);
				payBase.setCncYn(CommonConstants.COMM_YN_N);

				payBaseList.add(payBase);
			}
			
			

			//------------------------------------------------
			// 6. 데이터 저장
			//------------------------------------------------

			// 1) 주문배송지 등록
			int orderDlvraResult = this.orderDlvraDao.insertOrderDlvra(orderDlvra);

			if (orderDlvraResult != 1) {
				throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
			}
			
			if (mapo != null) {
				int mbrAdrsResult = memberAddressService.insertMemberAddress(mapo);
				if (mbrAdrsResult != 1) {
					throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
				}
			}
			

			// 2) 주문상세
			if (orderDetailList != null && !orderDetailList.isEmpty()) {
				int orderDetailResult = 0;
				for (OrderDetailPO po : orderDetailList) {
					orderDetailResult = this.orderDetailDao.insertOrderDetail(po);

					if (orderDetailResult != 1) {
						throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
					}
				}
			} else {
				throw new CustomException(ExceptionConstants.ERROR_ORDER_NO_GOODS);
			}

			// 3) 주문상세구성  세트/단품/사은품
			if (ordDtlCstrtList != null && !ordDtlCstrtList.isEmpty()) {
				int ordDtlCstrtResult = 0;

				for (OrdDtlCstrtVO vo : ordDtlCstrtList) {
					ordDtlCstrtResult = this.ordDtlCstrtDao.insertOrdDtlCstrt(vo);

					if (ordDtlCstrtResult != 1) {
						throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
					}
				}

			} else {
				throw new CustomException(ExceptionConstants.ERROR_ORDER_NO_GOODS);
			}

			// 4) 배송비
			if (deliveryChargeList != null && !deliveryChargeList.isEmpty()) {
				int deliveryChargeResult = 0;
				for (DeliveryChargePO po : deliveryChargeList) {
					deliveryChargeResult = this.deliveryChargeDao.insertDeliveryCharge(po);

					if (deliveryChargeResult != 1) {
						throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
					}
				}
			}

			// 5) 적용혜택
			if (aplBnftList != null && !aplBnftList.isEmpty()) {
				int aplbnftResult = 0;
				for (AplBnftPO po : aplBnftList) {
					aplbnftResult = this.aplBnftDao.insertAplBnft(po);

					if (aplbnftResult != 1) {
						throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
					}
				}
			}

			// 6) 결제 정보
			if (payBaseList != null && !payBaseList.isEmpty()) {
				int payBaseResult = 0;
				for (PayBasePO po : payBaseList) {
					payBaseResult = this.payBaseDao.insertPayBase(po);

					if (payBaseResult != 1) {
						throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
					}
				}
			}

			// 7) 주문 배송 권역 매핑
			if(CommonConstants.DLVR_PRCS_TP_20.equals(ordRegist.getDlvrPrcsTpCd()) || CommonConstants.DLVR_PRCS_TP_21.equals(ordRegist.getDlvrPrcsTpCd())) {
				//새벽/당일일 경우
				OrderDlvrAreaPO dlvrAreaPO = new OrderDlvrAreaPO();
				dlvrAreaPO.setOrdDt(ordRegist.getOrdDt());
				dlvrAreaPO.setDlvrAreaNo(ordRegist.getDlvrAreaNo());
				dlvrAreaPO.setOrdNo(ordNo);
				orderDlvrAreaDao.insertOrderDlvrAreaMap(dlvrAreaPO);
			}
			
			//------------------------------------------------
			// 8. 결제금액 검증
			//------------------------------------------------
			Long checkPayAmt = this.orderDao.getOrderRealPayAmt(ordNo);

			if (!checkPayAmt.equals(ordRegist.getPayAmt())) {
				throw new CustomException(ExceptionConstants.ERROR_ORDER_PAY_AMT_NO_MATCH);
			}
			
			PayBasePO pbpo = null;
			Long payNo = null;
			boolean addReceipt = false;			// 영수증(현금/세금계산서) 발급대상 여부
			
			// 결제 수단 별 결제 처리 정보 설정
			// 적립금 100% 사용한 경우 결제수단이 존재하지 않으므로 결제 정보를 등록하지 않음
			if (ordComplete.getPayMeansCd() != null && !"".equals(ordComplete.getPayMeansCd())) {
				// 결제 정보 등록
				boolean isInsert = true;
				pbpo = new PayBasePO();
				payNo = this.bizService.getSequence(CommonConstants.SEQUENCE_PAY_BASE_SEQ);
				pbpo.setPayNo(payNo);
				pbpo.setPayMeansCd(ordComplete.getPayMeansCd());

				pbpo.setOrdClmGbCd(CommonConstants.ORD_CLM_GB_10);
				pbpo.setOrdNo(ordNo);
				pbpo.setPayGbCd(CommonConstants.PAY_GB_10);
				pbpo.setPayStatCd(CommonConstants.PAY_STAT_00);		// 결제 상태는 기본 '입금대기', 수단별 결제완료 처리
				pbpo.setCncYn(CommonConstants.COMM_YN_N);

				// 신용카드
				if (CommonConstants.PAY_MEANS_10.equals(ordComplete.getPayMeansCd())) {

					pbpo.setPayStatCd(CommonConstants.PAY_STAT_01);
					if(StringUtils.isNotEmpty(ordComplete.getAuthDate()))
						pbpo.setPayCpltDtm(DateUtil.getTimestamp(ordComplete.getAuthDate(), "yyMMddHHmmss"));
					pbpo.setPayAmt(ordComplete.getAmt());
					pbpo.setStrId(ordComplete.getMid());
					pbpo.setDealNo(ordComplete.getTid());
					pbpo.setCardcCd(ordComplete.getCardcCd());
					pbpo.setCardNo(ordComplete.getCardNo());
					pbpo.setHalbu(ordComplete.getHalbu()); // 할부개월수

					if(StringUtils.equals(ordComplete.getCardInterest(), "1")){ // 무이자 여부
						pbpo.setFintrYn(CommonConstants.COMM_YN_Y);
					}else{
						pbpo.setFintrYn(CommonConstants.COMM_YN_N);
					}

					pbpo.setCfmNo(ordComplete.getAuthCode());
					pbpo.setCfmRstCd(ordComplete.getResultCode());
					pbpo.setCfmRstMsg(ordComplete.getResultMsg());
					if(StringUtils.isNotEmpty(ordComplete.getAuthDate()))
						pbpo.setCfmDtm(DateUtil.getTimestamp(ordComplete.getAuthDate(), "yyMMddHHmmss"));

				}
				// 빌링
				else if (CommonConstants.PAY_MEANS_11.equals(ordComplete.getPayMeansCd())) {

					pbpo.setPayStatCd(CommonConstants.PAY_STAT_01);
					if(StringUtils.isNotEmpty(ordComplete.getAuthDate()))
						pbpo.setPayCpltDtm(DateUtil.getTimestamp(ordComplete.getAuthDate(), "yyMMddHHmmss"));
					pbpo.setPayAmt(ordComplete.getAmt());
					pbpo.setStrId(ordComplete.getMid());
					pbpo.setDealNo(ordComplete.getTid());
					pbpo.setCardcCd(ordComplete.getCardCode());
					pbpo.setCardNo(ordComplete.getCardNo());
					pbpo.setHalbu(ordComplete.getHalbu());

					/**
					 * 이 부분은 필요없음
					 */
					if(StringUtils.equals(ordComplete.getCardInterest(), "1")){
						pbpo.setFintrYn(CommonConstants.COMM_YN_Y);
					}else{
						pbpo.setFintrYn(CommonConstants.COMM_YN_N);
					}

					pbpo.setCfmNo(ordComplete.getAuthCode());
					pbpo.setCfmRstCd(ordComplete.getResultCode());
					pbpo.setCfmRstMsg(ordComplete.getResultMsg());
					if(StringUtils.isNotEmpty(ordComplete.getAuthDate()))
						pbpo.setCfmDtm(DateUtil.getTimestamp(ordComplete.getAuthDate(), "yyMMddHHmmss"));

				}
				// 실시간 계좌이체
				else if (CommonConstants.PAY_MEANS_20.equals(ordComplete.getPayMeansCd())) {
					addReceipt = true;

					pbpo.setPayStatCd(CommonConstants.PAY_STAT_01);
					if(StringUtils.isNotEmpty(ordComplete.getAuthDate()))
						pbpo.setPayCpltDtm(DateUtil.getTimestamp(ordComplete.getAuthDate(), "yyMMddHHmmss"));
					pbpo.setPayAmt(ordComplete.getAmt());
					pbpo.setStrId(ordComplete.getMid());
					pbpo.setDealNo(ordComplete.getTid());
					pbpo.setBankCd(ordComplete.getBankCode());
					pbpo.setCfmNo(ordComplete.getAuthCode());
					pbpo.setCfmRstCd(ordComplete.getResultCode());
					pbpo.setCfmRstMsg(ordComplete.getResultMsg());
					if(StringUtils.isNotEmpty(ordComplete.getAuthDate()))
						pbpo.setCfmDtm(DateUtil.getTimestamp(ordComplete.getAuthDate(), "yyMMddHHmmss"));

				}
				// 가상계좌
				else if (CommonConstants.PAY_MEANS_30.equals(ordComplete.getPayMeansCd())) {
					addReceipt = true;

					pbpo.setPayAmt(ordComplete.getAmt());
					pbpo.setStrId(ordComplete.getMid());
					pbpo.setDealNo(ordComplete.getTid());
					pbpo.setBankCd(ordComplete.getBankCode());
					pbpo.setAcctNo(ordComplete.getVbankNum());

					pbpo.setOoaNm(bizConfig.getProperty("account.depositor.name")); //응답 메시지 예금주명 없음.
					if(StringUtils.isNotEmpty(ordComplete.getAuthDate()))
						pbpo.setBankCd(StringUtils.substring(ordComplete.getVbankBankCode(), 1)); // nice은행코드에서 앞에 0 빼면 은행코드
					pbpo.setCfmNo(ordComplete.getAuthCode());
					pbpo.setCfmRstCd(ordComplete.getResultCode());
					pbpo.setCfmRstMsg(ordComplete.getResultMsg());
					if(StringUtils.isNotEmpty(ordComplete.getAuthDate()))
						pbpo.setCfmDtm(DateUtil.getTimestamp(ordComplete.getAuthDate(), "yyMMddHHmmss"));
					pbpo.setDpstSchdDt(ordComplete.getVbankExpDate() + ordComplete.getVbankExpTime());
					pbpo.setDpstSchdAmt(ordComplete.getAmt());

				}
				// 무통장
				else if (CommonConstants.PAY_MEANS_40.equals(ordComplete.getPayMeansCd())) {
					addReceipt = true;

					pbpo.setPayStatCd(CommonConstants.PAY_STAT_00);
					pbpo.setPayAmt(ordComplete.getPayAmt());

					// 입금예정일자 및 예정 금액
					pbpo.setDpstSchdDt(PayUtil.getSchdDt());
					pbpo.setDpstSchdAmt(ordComplete.getPayAmt());

					// 무통장 계좌 정보 조회 및 설정
					DepositAcctInfoSO daiso = new DepositAcctInfoSO();
					daiso.setAcctInfoNo(ordComplete.getAcctInfoNo());
					DepositAcctInfoVO depositAcctInfo = this.depositAcctInfoDao.getDepositAcctInfo(daiso);

					if (depositAcctInfo != null) {
						pbpo.setBankCd(depositAcctInfo.getBankCd());
						pbpo.setAcctNo(depositAcctInfo.getAcctNo());
						pbpo.setOoaNm(depositAcctInfo.getOoaNm());
						pbpo.setDpstrNm(ordComplete.getDpstrNm());
					} else {
						throw new OrderException(ExceptionConstants.ERROR_CODE_DEFAULT);
					}

				}
				// 네이버 페이
				else if (CommonConstants.PAY_MEANS_70.equals(ordComplete.getPayMeansCd())) {

					pbpo.setPayStatCd(CommonConstants.PAY_STAT_01);
					if(StringUtils.isNotEmpty(ordComplete.getAuthDate()))
						pbpo.setPayCpltDtm(DateUtil.getTimestamp(ordComplete.getAuthDate(), "yyMMddHHmmss"));
					pbpo.setPayAmt(ordComplete.getAmt());
					pbpo.setStrId(ordComplete.getMid());
					pbpo.setDealNo(ordComplete.getTid());
					//pbpo.setCardcCd(ordComplete.getCardcCd());
					pbpo.setCfmNo(ordComplete.getAuthCode());
					pbpo.setCfmRstCd(ordComplete.getResultCode());
					pbpo.setCfmRstMsg(ordComplete.getResultMsg());
					if(StringUtils.isNotEmpty(ordComplete.getAuthDate()))
						pbpo.setCfmDtm(DateUtil.getTimestamp(ordComplete.getAuthDate(), "yyMMddHHmmss"));

				}
				// KAKAOPAY
				else if (CommonConstants.PAY_MEANS_71.equals(ordComplete.getPayMeansCd())) {

					pbpo.setPayStatCd(CommonConstants.PAY_STAT_01);
					if(StringUtils.isNotEmpty(ordComplete.getAuthDate()))
						pbpo.setPayCpltDtm(DateUtil.getTimestamp(ordComplete.getAuthDate(), "yyMMddHHmmss"));
					pbpo.setPayAmt(ordComplete.getAmt());
					pbpo.setStrId(ordComplete.getMid());
					pbpo.setDealNo(ordComplete.getTid());
					//pbpo.setCardcCd(ordComplete.getCardcCd());
					pbpo.setCfmNo(ordComplete.getAuthCode());
					pbpo.setCfmRstCd(ordComplete.getResultCode());
					pbpo.setCfmRstMsg(ordComplete.getResultMsg());
					if(StringUtils.isNotEmpty(ordComplete.getAuthDate()))
						pbpo.setCfmDtm(DateUtil.getTimestamp(ordComplete.getAuthDate(), "yyMMddHHmmss"));

				}
				// PAYCO
				else if (CommonConstants.PAY_MEANS_72.equals(ordComplete.getPayMeansCd())) {

					pbpo.setPayStatCd(CommonConstants.PAY_STAT_01);
					if(StringUtils.isNotEmpty(ordComplete.getAuthDate()))
						pbpo.setPayCpltDtm(DateUtil.getTimestamp(ordComplete.getAuthDate(), "yyMMddHHmmss"));
					pbpo.setPayAmt(ordComplete.getAmt());
					pbpo.setStrId(ordComplete.getMid());
					pbpo.setDealNo(ordComplete.getTid());
					//pbpo.setCardcCd(ordComplete.getCardcCd());
					pbpo.setCfmNo(ordComplete.getAuthCode());
					pbpo.setCfmRstCd(ordComplete.getResultCode());
					pbpo.setCfmRstMsg(ordComplete.getResultMsg());
					if(StringUtils.isNotEmpty(ordComplete.getAuthDate()))
						pbpo.setCfmDtm(DateUtil.getTimestamp(ordComplete.getAuthDate(), "yyMMddHHmmss"));

				}
				//0원 결제
				else if(CommonConstants.PAY_MEANS_00.equals(ordComplete.getPayMeansCd())) {
					//포인트 결제 없을 시에 insert 
					if (CollectionUtils.isEmpty(payBaseList)) {
						pbpo.setPayStatCd(CommonConstants.PAY_STAT_01);
						pbpo.setPayCpltDtm(DateUtil.getTimestamp());
						pbpo.setPayAmt(ordComplete.getPayAmt());
					}else {
						isInsert = false;
					}
				}
				
				//0원 결제 - 포인트 등록되었을 시 insert X
				if(isInsert) {
					pbpo.setLnkRspsRst(ordComplete.getLnkRspsRst()); // json Message db저장
					this.payBaseDao.insertPayBase(pbpo);
				}
			}

		} catch (CustomException e) {
			orderPrcsRstCd = CommonConstants.ORD_PRCS_RST_1000;
			orderPrcsRstMsg = this.message.getMessage(CommonConstants.EXCEPTION_MESSAGE_COMMON + e.getExCode());
			exceptionCd = e.getExCode();
		} catch (Exception e) {
			orderPrcsRstCd = CommonConstants.ORD_PRCS_RST_1000;
			orderPrcsRstMsg = this.cacheService.getCodeName(CommonConstants.ORD_PRCS_RST, orderPrcsRstCd);
			exceptionCd = ExceptionConstants.ERROR_CODE_DEFAULT;
		}

		if (exceptionCd != null) {
			log.error("[주문 등록 프로세스 오류] 주문번호 : " + ordNo);
			log.error("[주문 등록 프로세스 오류] 처리결과코드 : " + orderPrcsRstCd);
			log.error("[주문 등록 프로세스 오류] 처리결과메세지 : " + orderPrcsRstMsg);
			this.orderBaseService.updateOrderBaseProcessResult(ordNo, orderPrcsRstCd, orderPrcsRstMsg, CommonConstants.DATA_STAT_02);

			throw new CustomException(exceptionCd);
		}

		return ordNo;
	}

	/**
	 * <pre>
	 * - 프로젝트명		: gs-apet-11-business
	 * - 메서드명		: getTempPayInfo
	 * - 작성일		: 2021. 04. 27.
	 * - 작성자		: sorce
	 * - 설명			: 주문임시 저장 정보
	 * </pre>
	 * @param ordNo
	 * @return
	 */
	public OrderComplete getTempPayInfo(String ordNo) {
		return orderDao.getTempPayInfo(ordNo);
	}

	/*
	 * 주문 완료 - 주문접수 & 결제완료
	 *
	 * @see
	 * biz.app.order.service.OrderService#insertOrderComplete(biz.app.order.model.OrderComplete)
	 */
	@Override
	@Transactional
	public void insertOrderComplete(OrderComplete ordComplete) {

		// 주문 프로세스 결과 코드
		String orderPrcsRstCd = null;
		String orderPrcsRstMsg = null;
		String exceptionCd = null;

		OrderBaseVO orderBase = null;
		PayBaseSO pbso = null;
		List<PayBaseVO> payBaseList = null;
		MemberBaseVO mbvo = null;
		String ordStatCd = null;
		String dataStatCd = null;
		String ordDtlStatCd = null;

		//GS 포인트 사용 결과 객체
		GsrMemberPointVO result = null;
		try {
			// 주문 기본 조회
			OrderBaseSO obso = new OrderBaseSO();
			obso.setOrdNo(ordComplete.getOrdNo());
			orderBase = this.orderBaseDao.getOrderBase(obso);
			//------------------------------------------------
			// 1. Validation
			//------------------------------------------------

			// 회원 상태 검증
			if (ordComplete.getMbrNo() == null || CommonConstants.NO_MEMBER_NO.equals(ordComplete.getMbrNo())) {
				throw new PaymentException(ExceptionConstants.ERROR_MEMBER_NO_MEMBER, ordComplete);
			}else {
				MemberBaseSO mbso = new MemberBaseSO();
				mbso.setMbrNo(ordComplete.getMbrNo());
				mbvo = memberService.getMemberBase(mbso);
				if(mbvo == null || !CommonConstants.MBR_STAT_10.equals(mbvo.getMbrStatCd())) {
					throw new PaymentException(ExceptionConstants.ERROR_MEMBER_NO_MEMBER, ordComplete);
				}
			}
						
			// 주문 번호 검증
			if (ordComplete.getOrdNo() == null || "".equals(ordComplete.getOrdNo())) {
				throw new PaymentException(ExceptionConstants.ERROR_ORDER_NO_BASE, ordComplete);
			}

			// 결제금액 검증
			Long checkPayAmt = this.orderDao.getOrderRealPayAmt(ordComplete.getOrdNo());

			if (!checkPayAmt.equals(ordComplete.getPayAmt())) {
				throw new PaymentException(ExceptionConstants.ERROR_ORDER_PAY_AMT_NO_MATCH, ordComplete);
			}
			

			if (orderBase == null) {
				throw new PaymentException(ExceptionConstants.ERROR_ORDER_NO_BASE, ordComplete);
			}
			
			// 주문 상세
			// - 단품별 웹재고 차감
			// - 주문 상세 상태 : 접수

			// 주문 상세 목록 조회
			OrderDetailSO odso = new OrderDetailSO();
			odso.setOrdNo(orderBase.getOrdNo());
			List<OrderDetailVO> orderDetailList = this.orderDetailDao.listOrderDetail(odso);
			
			
			//재고 체크
			List<String> goodsIds = new ArrayList<>();
			List<CartGoodsVO> checkList = new ArrayList<>();
			List<CartGoodsVO> checkSumList = new ArrayList<>();
			
			for(OrderDetailVO detail : orderDetailList) {
				if(CommonConstants.GOODS_CSTRT_TP_SET.equals(detail.getGoodsCstrtTpCd())) {
					List<GoodsCstrtSetVO> setList = goodsCstrtSetDao.listGoodsCstrtSet(detail.getGoodsId());
					for(GoodsCstrtSetVO set : setList) {
						CartGoodsVO temp = new CartGoodsVO();
						temp.setGoodsId(set.getSubGoodsId());
						temp.setBuyQty(detail.getOrdQty() * set.getCstrtQty());
						checkList.add(temp);
					}
				}else if(CommonConstants.GOODS_CSTRT_TP_ITEM.equals(detail.getGoodsCstrtTpCd())){
					CartGoodsVO temp = new CartGoodsVO();
					temp.setGoodsId(detail.getGoodsId());
					temp.setBuyQty(detail.getOrdQty());
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
			
			if(stkList.stream().anyMatch(vo -> !CommonConstants.SALE_PSB_00.equals(vo.getSalePsbCd()))) {
				throw new PaymentException(ExceptionConstants.ERROR_ORDER_SALE_PSB, ordComplete);
			}
			
			//슬롯 재고 체크 
			OrderDlvrAreaSO ordAreaSO = new OrderDlvrAreaSO();
			ordAreaSO.setOrdNo(ordComplete.getOrdNo());
			OrderDlvrAreaVO ordAreaVO = orderDlvrAreaDao.getOrdDlvrAreaInfo(ordAreaSO);
			if(ordAreaVO != null) {
				OrderDlvrAreaSO areaSO = new OrderDlvrAreaSO();
				areaSO.setDlvrAreaNo(ordAreaVO.getDlvrAreaNo());
				areaSO.setPostNo(ordAreaVO.getPostNo());
				OrderDlvrAreaVO areaVO = orderDlvrAreaDao.getDlvrAreaInfo(areaSO);
				
				//어바웃펫 슬롯수량 체크 제거
				SlotInquirySO cisSO = new SlotInquirySO();
				cisSO.setDlvtTpCd(areaVO.getDlvrPrcsTpCd());
				cisSO.setYmd(ordAreaVO.getOrdDt());
				cisSO.setZipcode(areaVO.getPostNo());
				cisSO.setMallId(areaVO.getDlvrCntrCd());
				cisSO.setDlvGrpCd(areaVO.getDlvrAreaCd());
				
				try {
					SlotInquiryVO slotVO = cisOrderService.listSlot(cisSO);
					
					if(CommonConstants.CIS_API_SUCCESS_CD.equals(slotVO.getResCd())) {
						List<SlotInquiryItemVO> itemList = slotVO.getItemList();
						
						for(SlotInquiryItemVO item : itemList) {
							if(item.getSlotCnt() <= item.getUsedCnt()) {
								throw new PaymentException(ExceptionConstants.ERROR_DLVR_SLOT_CLOSE, ordComplete);
							}
						}
					}
				} catch (Exception e) {
					log.error("CIS 슬롯 조회 인터페이스 오류");
					e.printStackTrace();
					throw new PaymentException(ExceptionConstants.ERROR_DLVR_SLOT_CLOSE, ordComplete);
				}
				
			}
			
				
			//------------------------------------------------
			// 2. 주문 접수 처리
			//------------------------------------------------
			orderPrcsRstCd = CommonConstants.ORD_PRCS_RST_2000;

			// 적용 혜택 - 쿠폰사용 내역 회원 쿠폰에 반영
			List<Long> mbrCpNoList = this.aplBnftDao.listAplBnftMbrCpNo(ordComplete.getOrdNo());

			if (mbrCpNoList != null && !mbrCpNoList.isEmpty()) {
				for (Long mbrCpNo : mbrCpNoList) {
					this.memberCouponService.updateMemberCouponUse(mbrCpNo, ordComplete.getOrdNo());
				}
			}


			// 배송비 - 쿠폰사용 내역 회원 쿠폰에 반영
			DeliveryChargeSO dcso = new DeliveryChargeSO();
			dcso.setOrdNo(ordComplete.getOrdNo());
			dcso.setMbrCpUseYn(CommonConstants.COMM_YN_Y);
			List<DeliveryChargeVO> deliveryChargeList = this.deliveryChargeDao.listDeliveryCharge(dcso);

			if (deliveryChargeList != null && !deliveryChargeList.isEmpty()) {
				for (DeliveryChargeVO dcvo : deliveryChargeList) {
					if (dcvo.getMbrCpNo() != null) {
						this.memberCouponService.updateMemberCouponUse(dcvo.getMbrCpNo(), ordComplete.getOrdNo());
					}
				}
			}

			if (orderDetailList != null && !orderDetailList.isEmpty()) {
				// 단품 웹재고 차감 : 상품의 웹재고 관리하는 경우
				for (OrderDetailVO orderDetail : orderDetailList) {
					OrderDetailSO cstrtSO = new OrderDetailSO();
					cstrtSO.setOrdNo(orderDetail.getOrdNo());
					cstrtSO.setOrdDtlSeq(orderDetail.getOrdDtlSeq());
					
					List<OrdDtlCstrtVO> cstrtList = ordDtlCstrtDao.listOrdDtlCstrt(cstrtSO);
					for(OrdDtlCstrtVO cstrt : cstrtList) {
						goodsStockService.updateStockQty(cstrt.getCstrtGoodsId(), (orderDetail.getOrdQty() * cstrt.getCstrtQty()) * -1);
					}
					
					//장바구니 바로구매 시 - 장바구니 삭제
					
					String cartYn = CookieSessionUtil.getCookie(FrontConstants.SESSION_ORDER_PARAM_CART_YN);
					if(CommonConstants.COMM_YN_Y.equals(cartYn)) {
						CartSO cartSO = new CartSO();
						cartSO.setGoodsId(orderDetail.getGoodsId());
						cartSO.setItemNo(orderDetail.getItemNo());
						cartSO.setPakGoodsId(orderDetail.getPakGoodsId());
						cartSO.setNowBuyYn("N");
						cartSO.setMbrNo(orderDetail.getMbrNo());
						CartVO cartVO = cartDao.getCart(cartSO);
						
						if(cartVO != null) {
							CartPO cartPO = new CartPO();
							cartPO.setCartId(cartVO.getCartId());
							cartDao.deleteCart(cartPO);
						}
					}
				}

				// 주문 상세 상태 설정
				ordDtlStatCd = CommonConstants.ORD_DTL_STAT_110;
				
				
			} else {
				throw new PaymentException(ExceptionConstants.ERROR_ORDER_NO_GOODS, ordComplete);
			}

			// 주문 기본
			// - 주문 상태 : 접수
			// - 데이터 상태 : 활성화

			// 주문 상태 및 데이터 상태 설정
			ordStatCd = CommonConstants.ORD_STAT_10;
			dataStatCd = CommonConstants.DATA_STAT_01;


			//------------------------------------------------
			// 3. 주문 결제 처리
			//------------------------------------------------
			orderPrcsRstCd = CommonConstants.ORD_PRCS_RST_3000;

			boolean addReceipt = false;			// 영수증(현금/세금계산서) 발급대상 여부
			PayBasePO pbpo = null;
			Long payNo = null;


			// 결제 수단별 결제정보 처리
			// - 결제정보 등록
			// - 결제완료 처리

			// 결제 수단 별 결제 처리 정보 설정
			// 적립금 100% 사용한 경우 결제수단이 존재하지 않으므로 결제 정보를 등록하지 않음
			if (ordComplete.getPayMeansCd() != null && !"".equals(ordComplete.getPayMeansCd())) {
				// 결제 정보 등록
				boolean isInsert = true;
				pbpo = new PayBasePO();
				pbpo.setPayNo(ordComplete.getPayNo());
				pbpo.setPayMeansCd(ordComplete.getPayMeansCd());

				pbpo.setOrdClmGbCd(CommonConstants.ORD_CLM_GB_10);
				pbpo.setOrdNo(ordComplete.getOrdNo());
				pbpo.setPayGbCd(CommonConstants.PAY_GB_10);
				pbpo.setPayStatCd(CommonConstants.PAY_STAT_00);		// 결제 상태는 기본 '입금대기', 수단별 결제완료 처리
				pbpo.setCncYn(CommonConstants.COMM_YN_N);

				// 신용카드
				if (CommonConstants.PAY_MEANS_10.equals(ordComplete.getPayMeansCd())) {

					pbpo.setPayStatCd(CommonConstants.PAY_STAT_01);
					pbpo.setPayCpltDtm(DateUtil.getTimestamp(ordComplete.getAuthDate(), "yyMMddHHmmss"));
					pbpo.setPayAmt(ordComplete.getAmt());
					pbpo.setStrId(ordComplete.getMid());
					pbpo.setDealNo(ordComplete.getTid());
					pbpo.setCardcCd(ordComplete.getCardcCd());
					pbpo.setCardNo(ordComplete.getCardNo());
					pbpo.setHalbu(ordComplete.getCardQuota()); // cardQuota에 할부개월수

					if(StringUtils.equals(ordComplete.getCardInterest(), "1")){ // 무이자 여부
						pbpo.setFintrYn(CommonConstants.COMM_YN_Y);
					}else{
						pbpo.setFintrYn(CommonConstants.COMM_YN_N);
					}

					pbpo.setCfmNo(ordComplete.getAuthCode());
					pbpo.setCfmRstCd(ordComplete.getResultCode());
					pbpo.setCfmRstMsg(ordComplete.getResultMsg());
					pbpo.setCfmDtm(DateUtil.getTimestamp(ordComplete.getAuthDate(), "yyMMddHHmmss"));

				}
				// 빌링
				else if (CommonConstants.PAY_MEANS_11.equals(ordComplete.getPayMeansCd())) {

					pbpo.setPayStatCd(CommonConstants.PAY_STAT_01);
					pbpo.setPayCpltDtm(DateUtil.getTimestamp(ordComplete.getAuthDate(), "yyMMddHHmmss"));
					pbpo.setPayAmt(ordComplete.getAmt());
					pbpo.setStrId(ordComplete.getMid());
					pbpo.setDealNo(ordComplete.getTid());
					pbpo.setCardcCd(ordComplete.getCardCode());
					pbpo.setCardNo(ordComplete.getCardNo());

					pbpo.setHalbu(ordComplete.getHalbu());

					if(StringUtils.equals(ordComplete.getCardInterest(), "1")){
						pbpo.setFintrYn(CommonConstants.COMM_YN_Y);
					}else{
						pbpo.setFintrYn(CommonConstants.COMM_YN_N);
					}

					pbpo.setCfmNo(ordComplete.getAuthCode());
					pbpo.setCfmRstCd(ordComplete.getResultCode());
					pbpo.setCfmRstMsg(ordComplete.getResultMsg());
					pbpo.setCfmDtm(DateUtil.getTimestamp(ordComplete.getAuthDate(), "yyMMddHHmmss"));

				}
				// 실시간 계좌이체
				else if (CommonConstants.PAY_MEANS_20.equals(ordComplete.getPayMeansCd())) {
					addReceipt = true;

					pbpo.setPayStatCd(CommonConstants.PAY_STAT_01);
					pbpo.setPayCpltDtm(DateUtil.getTimestamp(ordComplete.getAuthDate(), "yyMMddHHmmss"));
					pbpo.setPayAmt(ordComplete.getAmt());
					pbpo.setStrId(ordComplete.getMid());
					pbpo.setDealNo(ordComplete.getTid());
					pbpo.setBankCd(ordComplete.getBankCode());
					pbpo.setCfmNo(ordComplete.getAuthCode());
					pbpo.setCfmRstCd(ordComplete.getResultCode());
					pbpo.setCfmRstMsg(ordComplete.getResultMsg());
					pbpo.setCfmDtm(DateUtil.getTimestamp(ordComplete.getAuthDate(), "yyMMddHHmmss"));

				}
				// 가상계좌
				else if (CommonConstants.PAY_MEANS_30.equals(ordComplete.getPayMeansCd())) {
					addReceipt = true;

					pbpo.setPayAmt(ordComplete.getAmt());
					pbpo.setStrId(ordComplete.getMid());
					pbpo.setDealNo(ordComplete.getTid());
					pbpo.setBankCd(ordComplete.getBankCode());
					pbpo.setAcctNo(ordComplete.getVbankNum());

					pbpo.setOoaNm(bizConfig.getProperty("account.depositor.name")); //응답 메시지 예금주명 없음.
					pbpo.setBankCd(StringUtils.substring(ordComplete.getVbankBankCode(), 1)); // nice은행코드에서 앞에 0 빼면 은행코드
					pbpo.setCfmNo(ordComplete.getAuthCode());
					pbpo.setCfmRstCd(ordComplete.getResultCode());
					pbpo.setCfmRstMsg(ordComplete.getResultMsg());
					pbpo.setCfmDtm(DateUtil.getTimestamp(ordComplete.getAuthDate(), "yyMMddHHmmss"));
					pbpo.setDpstSchdDt(ordComplete.getVbankExpDate() + ordComplete.getVbankExpTime());
					pbpo.setDpstSchdAmt(ordComplete.getAmt());

				}
				// 무통장
				else if (CommonConstants.PAY_MEANS_40.equals(ordComplete.getPayMeansCd())) {
					addReceipt = true;

					pbpo.setPayStatCd(CommonConstants.PAY_STAT_00);
					pbpo.setPayAmt(ordComplete.getPayAmt());

					// 입금예정일자 및 예정 금액
					pbpo.setDpstSchdDt(PayUtil.getSchdDt());
					pbpo.setDpstSchdAmt(ordComplete.getPayAmt());

					// 무통장 계좌 정보 조회 및 설정
					DepositAcctInfoSO daiso = new DepositAcctInfoSO();
					daiso.setAcctInfoNo(ordComplete.getAcctInfoNo());
					DepositAcctInfoVO depositAcctInfo = this.depositAcctInfoDao.getDepositAcctInfo(daiso);

					if (depositAcctInfo != null) {
						pbpo.setBankCd(depositAcctInfo.getBankCd());
						pbpo.setAcctNo(depositAcctInfo.getAcctNo());
						pbpo.setOoaNm(depositAcctInfo.getOoaNm());
						pbpo.setDpstrNm(ordComplete.getDpstrNm());
					} else {
						throw new PaymentException(ExceptionConstants.ERROR_CODE_DEFAULT, ordComplete);
					}

				}
				// 네이버 페이
				else if (CommonConstants.PAY_MEANS_70.equals(ordComplete.getPayMeansCd())) {

					pbpo.setPayStatCd(CommonConstants.PAY_STAT_01);
					pbpo.setPayCpltDtm(DateUtil.getTimestamp(ordComplete.getAuthDate(), "yyMMddHHmmss"));
					pbpo.setPayAmt(ordComplete.getAmt());
					pbpo.setStrId(ordComplete.getMid());
					pbpo.setDealNo(ordComplete.getTid());
					//pbpo.setCardcCd(ordComplete.getCardcCd());
					pbpo.setCfmNo(ordComplete.getAuthCode());
					pbpo.setCfmRstCd(ordComplete.getResultCode());
					pbpo.setCfmRstMsg(ordComplete.getResultMsg());
					pbpo.setCfmDtm(DateUtil.getTimestamp(ordComplete.getAuthDate(), "yyMMddHHmmss"));

				}
				// KAKAOPAY
				else if (CommonConstants.PAY_MEANS_71.equals(ordComplete.getPayMeansCd())) {

					pbpo.setPayStatCd(CommonConstants.PAY_STAT_01);
					pbpo.setPayCpltDtm(DateUtil.getTimestamp(ordComplete.getAuthDate(), "yyMMddHHmmss"));
					pbpo.setPayAmt(ordComplete.getAmt());
					pbpo.setStrId(ordComplete.getMid());
					pbpo.setDealNo(ordComplete.getTid());
					//pbpo.setCardcCd(ordComplete.getCardcCd());
					pbpo.setCfmNo(ordComplete.getAuthCode());
					pbpo.setCfmRstCd(ordComplete.getResultCode());
					pbpo.setCfmRstMsg(ordComplete.getResultMsg());
					pbpo.setCfmDtm(DateUtil.getTimestamp(ordComplete.getAuthDate(), "yyMMddHHmmss"));

				}
				// PAYCO
				else if (CommonConstants.PAY_MEANS_72.equals(ordComplete.getPayMeansCd())) {

					pbpo.setPayStatCd(CommonConstants.PAY_STAT_01);
					pbpo.setPayCpltDtm(DateUtil.getTimestamp(ordComplete.getAuthDate(), "yyMMddHHmmss"));
					pbpo.setPayAmt(ordComplete.getAmt());
					pbpo.setStrId(ordComplete.getMid());
					pbpo.setDealNo(ordComplete.getTid());
					//pbpo.setCardcCd(ordComplete.getCardcCd());
					pbpo.setCfmNo(ordComplete.getAuthCode());
					pbpo.setCfmRstCd(ordComplete.getResultCode());
					pbpo.setCfmRstMsg(ordComplete.getResultMsg());
					pbpo.setCfmDtm(DateUtil.getTimestamp(ordComplete.getAuthDate(), "yyMMddHHmmss"));

				}
				//0원 결제
				else if(CommonConstants.PAY_MEANS_00.equals(ordComplete.getPayMeansCd())) {
					//포인트 결제 없을 시에 insert 
					if (CollectionUtils.isEmpty(payBaseList)) {
						pbpo.setPayStatCd(CommonConstants.PAY_STAT_01);
						pbpo.setPayCpltDtm(DateUtil.getTimestamp());
						pbpo.setPayAmt(ordComplete.getPayAmt());
					}else {
						isInsert = false;
					}
				}
				
				//0원 결제 - 포인트 등록되었을 시 insert X
				if(isInsert) {
					pbpo.setLnkRspsRst(ordComplete.getLnkRspsRst()); // json Message db저장
					this.payBaseDao.updatePayBaseApproval(pbpo);
				}


				//------------------------------------------------
				// 4. 영수증 발행 처리
				//------------------------------------------------
				if (addReceipt && (StringUtils.equals(ordComplete.getRcpType(), "1")||StringUtils.equals(ordComplete.getRcpType(), "2"))) {
					// 1) 현금영수증 정보 저장
					// 현금영수증 번호
					/**
					 * RcptTid 값이 있는 경우 현금영수증이 있다고 판단 하는 것으로 
					 * RcptType (0:발행안함, 1:소득공제, 2:지출증빙)
					 * RcptAuthCode 승인번호
					 */
					Long cashRctNo = this.bizService.getSequence(CommonConstants.SEQUENCE_CASH_RCT_NO_SEQ);

					CashReceiptPO crpo = new CashReceiptPO();
					crpo.setCashRctNo(cashRctNo);
					crpo.setCrTpCd(CommonConstants.CR_TP_10);
					// 발행으로 처리
					crpo.setCashRctStatCd(CommonConstants.CASH_RCT_STAT_20);
					crpo.setUseGbCd(ordComplete.getUseGbCd());
					crpo.setStrId(ordComplete.getStrId());

					// 금액 계산
					// 현재 과세상품만 존재하므로 결제금액(상품금액+배송비)에 대해 부가세 계산하여 처리
					Long payAmt = ordComplete.getPayAmt();
					Long staxAmt = Math.round(payAmt.doubleValue() / 1.1 * 0.1);
					Long splAmt = payAmt - staxAmt;
					Long srvcAmt = 0L;

					crpo.setPayAmt(ordComplete.getPayAmt());
					crpo.setSplAmt(splAmt);
					crpo.setStaxAmt(staxAmt);
					crpo.setSrvcAmt(srvcAmt);
					
					if(StringUtils.equals(ordComplete.getRcpType(), "1")) {
						crpo.setUseGbCd(CommonConstants.USE_GB_10);
					}else if(StringUtils.equals(ordComplete.getRcpType(), "2")) {
						crpo.setUseGbCd(CommonConstants.USE_GB_20);
					}
					
					
					crpo.setIsuGbCd(CommonConstants.ISU_GB_10); // PG결제시 발행되는 현금영수증은 자동으로 고정
					// 발급 수단 번호 - 값없음 삭제
					// 발급 수단 코드 - 값없음 삭제

					// 현금영수증 TID
					crpo.setLnkDealNo(ordComplete.getRcptTID());
					// 현금영수증 결과 코드 
					crpo.setLnkRstMsg(pbpo.getLnkRspsRst());
					// 현금영수증 저장
					int cashReceiptResult = this.cashReceiptDao.insertCashReceipt(crpo);

					if (cashReceiptResult == 0) {
						throw new PaymentException(ExceptionConstants.ERROR_CODE_DEFAULT, ordComplete);
					}


					// 2) 현금영수증 상품매핑테이블 저장
					CashReceiptGoodsMapPO crgmpo = null;

					for (OrderDetailVO orderDetail : orderDetailList) {
						crgmpo = new CashReceiptGoodsMapPO();
						crgmpo.setCashRctNo(cashRctNo);
						crgmpo.setOrdClmNo(orderDetail.getOrdNo());
						crgmpo.setOrdClmDtlSeq(orderDetail.getOrdDtlSeq());
						crgmpo.setAplQty(orderDetail.getOrdQty());
						int cashReceiptGoodsMapResult = this.cashReceiptDao.insertCashReceiptGoodsMap(crgmpo);

						if (cashReceiptGoodsMapResult == 0) {
							throw new PaymentException(ExceptionConstants.ERROR_CODE_DEFAULT, ordComplete);
						}
					}

				}

			}
			
			// 결제 정보 : 포인트
			// - 포인트 결제 상태 변경
			// - 포인트 사용내역 > 회원 포인트에 반영

			// 입금 대기인 포인트 결제 내역 조회
			//포인트 exception 사용 취소 처리 안하기 위해 마지막로직.
			pbso = new PayBaseSO();
			pbso.setOrdClmGbCd(CommonConstants.ORD_CLM_GB_10);
			pbso.setOrdNo(orderBase.getOrdNo());
			pbso.setPayGbCd(CommonConstants.PAY_GB_10);
			pbso.setPayMeansCd(CommonConstants.PAY_MEANS_80);
			pbso.setPayStatCd(CommonConstants.PAY_STAT_00);
			payBaseList = this.payBaseDao.listPayBase(pbso);


			//GS 포인트 응답
			if (payBaseList != null && !payBaseList.isEmpty()) {
				for (PayBaseVO payBase : payBaseList) {
					// 포인트 결제완료
					pbpo = new PayBasePO();
					
					// GS포인트 API 호출 - 결제에 사용한 GS포인트 차감
					GsrMemberPointPO gmppo = new GsrMemberPointPO();

					Date today = new Date();

					SimpleDateFormat date = new SimpleDateFormat("yyyyMMdd");
					SimpleDateFormat time = new SimpleDateFormat("hhmmss");
					
					Long payAmt = (ordComplete.getPayAmt() != null ? ordComplete.getPayAmt() : 0L)+(payBase.getPayAmt()!=null ? payBase.getPayAmt().longValue() : 0L);
					
					gmppo.setRcptNo(ordComplete.getOrdNo());
					gmppo.setCustNo(ordComplete.getGsptNo());
					gmppo.setSaleAmt(Long.toString(payAmt));
					gmppo.setPoint(Long.toString(payBase.getPayAmt()));
					gmppo.setSaleDate(date.format(today));
					gmppo.setSaleEndDt(time.format(today));

					result = gsrService.useGsPoint(gmppo);
					if(StringUtil.isNotEmpty(Optional.ofNullable(result.getApprNo()).orElseGet(()->""))){
						pbpo.setDealNo(result.getApprNo());
						pbpo.setCfmNo(result.getApprNo());
						pbpo.setCfmDtm(new Timestamp(today.getTime()));
						pbpo.setCfmRstMsg(result.getResultMessage());
						pbpo.setPayNo(payBase.getPayNo());

						int payResult = this.payBaseDao.updatePayBaseComplete(pbpo);

						if (payResult != 1) {
							throw new PaymentException(ExceptionConstants.ERROR_CODE_DEFAULT, ordComplete);
						}

						// 포인트 사용 이력 저장
						OrdSavePntPO pntPO = new OrdSavePntPO();
						pntPO.setSaveUseGbCd(CommonConstants.SAVE_USE_GB_30); // 사용
						pntPO.setDealGbCd(CommonConstants.DEAL_GB_10);		  // 결제
						pntPO.setMbrNo(ordComplete.getMbrNo());
						pntPO.setGspntNo(ordComplete.getGsptNo());
						pntPO.setPayAmt(payAmt);
						pntPO.setPnt((payBase.getPayAmt()!=null)? payBase.getPayAmt().intValue() : 0);
						pntPO.setDealNo(result.getApprNo());
						pntPO.setOrdNo(ordComplete.getOrdNo());
						pntPO.setDealDtm(new Timestamp(today.getTime()));
						pntPO.setSysRegrNo(ordComplete.getMbrNo());
						ordSavePntDao.insertGsPntHist(pntPO);

					}else{
						pbpo.setDealNo(null);
						pbpo.setCfmNo(null);
						pbpo.setPayStatCd(CommonConstants.PAY_STAT_00);
						pbpo.setCfmDtm(new Timestamp(today.getTime()));

						pbpo.setCfmRstMsg("최초 결제 시, 포인트 사용 요청 실패");
						pbpo.setCfmRstCd(result.getResultCode());

						pbpo.setPayNo(payBase.getPayNo());

						payBaseDao.updatePayBaseComplete(pbpo);
					}
				}
			}
			
			
			//MP 포인트 전문 승인 요청
			if(orderBase.getMpLnkHistNo() != null) {
				PntInfoSO pntSO = new PntInfoSO();
				pntSO.setPntTpCd(CommonConstants.PNT_TP_MP);
				PntInfoVO mpPntVO = pntInfoService.getPntInfo(pntSO);
				
				SktmpLnkHistSO mpSO = new SktmpLnkHistSO();
				mpSO.setMpLnkHistNo(orderBase.getMpLnkHistNo());
				SktmpLnkHistVO mpVO = sktmpService.getSktmpLnkHist(mpSO);
				
				// 주문 시  MP 포인트 상품코드와 다를경우 에러 처리
				if(!mpVO.getIfGoodsCd().equals(mpPntVO.getIfGoodsCd()) ) {
					throw new PaymentException(ExceptionConstants.ERROR_SKTMP_SAME_IF_GOODS_CD, ordComplete,result);
				}
				
				ISR3K00110ReqVO saveReq = new ISR3K00110ReqVO();
				saveReq.setEBC_NUM1(mpVO.getCardNo());
				saveReq.setGOODS_CD(mpPntVO.getIfGoodsCd());
				ISR3K00110ResVO saveRes = sktmpService.getMpSaveRmnCount(saveReq);
				
				//적립되는거였다가 완료시점에 적립안되는경우
				if(mpVO.getSaveSchdPnt() != null &&  mpVO.getSaveSchdPnt() > 0 && saveRes != null && Integer.valueOf(saveRes.getACCUM_CNT()) == 0) {
					throw new PaymentException(ExceptionConstants.ERROR_SKTMP_ACCUM_POINT, ordComplete,result);
				}
				
				mpVO.setCiCtfVal(mbvo.getCiCtfVal());
				sktmpService.reqMpApprove(mpVO, CommonConstants.ORD_CLM_GB_10, null);
				if(mpVO.getResCd() != null) {
					if(!SktmpConstants.RES_SUCCESS_CODE.equals(mpVO.getResCd())) {
						throw new PaymentException("SKTMP"+mpVO.getResCd(), ordComplete,result);
					}	
				}else {
					throw new PaymentException(ExceptionConstants.ERROR_SKTMP_RESPONSE, ordComplete,result);
				}
					
				// 결제 정보 : MP 포인트
				pbso = new PayBaseSO();
				pbso.setOrdClmGbCd(CommonConstants.ORD_CLM_GB_10);
				pbso.setOrdNo(orderBase.getOrdNo());
				pbso.setPayGbCd(CommonConstants.PAY_GB_10);
				pbso.setPayMeansCd(CommonConstants.PAY_MEANS_81);
				pbso.setPayStatCd(CommonConstants.PAY_STAT_00);
				PayBaseVO payBase = this.payBaseDao.getPayBase(pbso);
				
				if (payBase != null) {
					pbpo = new PayBasePO();
					
					Date today = new Date();
					
					pbpo.setDealNo(mpVO.getDealNo());
					pbpo.setCfmNo(mpVO.getCfmNo());
					pbpo.setCfmRstMsg(mpVO.getCfmRstMsg());
					pbpo.setCfmDtm(new Timestamp(today.getTime()));
					pbpo.setCfmRstCd(mpVO.getResCd());
					pbpo.setCfmRstMsg("정상");
					pbpo.setPayNo(payBase.getPayNo());
					
					int payResult = this.payBaseDao.updatePayBaseComplete(pbpo);

					if (payResult != 1) {
						throw new PaymentException(ExceptionConstants.ERROR_CODE_DEFAULT, ordComplete , result);
					}
				}
				
			}

			//------------------------------------------------
			// 5. 주문 완료 처리
			//------------------------------------------------
			orderPrcsRstCd = CommonConstants.ORD_PRCS_RST_4000;

			// 주문 결제 상태 체크
			boolean payComplete = this.payBaseService.checkPayStatus(ordComplete.getOrdNo());

			// 주문 관련 상태 변경 : 결제가 전체 완료된 경우
			// - 주문 상세 상태 설정 > 주문완료
			// - 주문 기본 상태 설정 > 주문완료


			//가상계좌 결제 시에만 주문상태 - 주문접수로
			if (payComplete) {
				// 주문 상세 상태 > 완료
				ordDtlStatCd = CommonConstants.ORD_DTL_STAT_120;

				// 주문 상태 설정 > 완료
				ordStatCd = CommonConstants.ORD_STAT_20;
			}


			// 주문 및 상세 상태 처리
			OrderDetailPO odpo = new OrderDetailPO();
			odpo.setOrdNo(ordComplete.getOrdNo());
			odpo.setOrdDtlStatCd(ordDtlStatCd);
			int orderDetailResult = orderDetailDao.updateOrderDetail(odpo);

			if (orderDetailResult == 0) {
				throw new PaymentException(ExceptionConstants.ERROR_CODE_DEFAULT, ordComplete);
			}

			OrderBasePO obpo = new OrderBasePO();
			obpo.setOrdNo(ordComplete.getOrdNo());
			obpo.setOrdStatCd(ordStatCd);
			obpo.setDataStatCd(dataStatCd);
			obpo.setOrdPrcsRstCd(CommonConstants.ORD_PRCS_RST_0000);
			obpo.setOrdPrcsRstMsg(this.cacheService.getCodeName(CommonConstants.ORD_PRCS_RST, CommonConstants.ORD_PRCS_RST_0000));
			int orderBaseResult = this.orderBaseDao.updateOrderBase(obpo);

			if (orderBaseResult != 1) {
				throw new PaymentException(ExceptionConstants.ERROR_CODE_DEFAULT, ordComplete);
			}
		} catch (CustomException e) {
			orderPrcsRstMsg = this.message.getMessage(CommonConstants.EXCEPTION_MESSAGE_COMMON + e.getExCode());
			exceptionCd = e.getExCode();
			log.debug(e.getMessage());
			e.printStackTrace();
		} catch (PaymentException e) {
			orderPrcsRstMsg = this.message.getMessage(CommonConstants.EXCEPTION_MESSAGE_COMMON + e.getExCode());
			exceptionCd = e.getExCode();
			log.debug(e.getMessage());
			e.printStackTrace();
		} catch(GsrException e){
			orderPrcsRstMsg = this.message.getMessage(CommonConstants.EXCEPTION_MESSAGE_COMMON + e.getExCode());
			exceptionCd = e.getExCode();
			log.debug(e.getMessage());
			e.printStackTrace();
		}catch (Exception e) {
			orderPrcsRstMsg = this.cacheService.getCodeName(CommonConstants.ORD_PRCS_RST, orderPrcsRstCd);
			exceptionCd = ExceptionConstants.ERROR_CODE_DEFAULT;
			log.debug(e.getMessage());
			e.printStackTrace();
		}

		if (exceptionCd != null) {
			if (orderBase != null && !orderBase.getOrdNo().isEmpty()) {
				log.error("[주문 완료 프로세스 오류] 주문번호 : " + ordComplete.getOrdNo());
				log.error("[주문 완료 프로세스 오류] 처리결과코드 : " + orderPrcsRstCd);
				log.error("[주문 완료 프로세스 오류] 처리결과메세지 : " + orderPrcsRstMsg);
				throw new PaymentException(exceptionCd, ordComplete,result);
			}
		}
	}

	/**
	 * 최초~세번째 구매 감사 쿠폰 지급 처리 - 2021.03.29, by kek01
	 * 구매 확정시 쿠폰 지급 처리로 변경됨 - 2021.05.03, by kek01
	 * (주의사항) 반드시 구매확정 UPDATE 후에 이 함수를 호출 해야됨
	 * @param orderNo
	 */
	@Override
	@Transactional
	public void giveFirstOrderThanksCoupon(String orderNo){
		//주문 상세 목록 조회
		OrderDetailSO odso = new OrderDetailSO();
		odso.setOrdNo(orderNo);
		List<OrderDetailVO> orderDetailList = this.orderDetailDao.listOrderDetail(odso);
		
		//나의 회원번호 SET
		Long myMbrNo = 0L;
		if(orderDetailList.size() > 0) {
			myMbrNo = orderDetailList.get(0).getMbrNo();
		}

		//어바웃펫 신규 회원일때 만 해당됨
		MemberBaseSO memso = new MemberBaseSO();
		memso.setMbrNo(myMbrNo);
		MemberBaseVO memvo = memberBaseDao.getMemberBase(memso);
		
		if(memvo != null && CommonConstants.JOIN_PATH_30.equals(StringUtil.nvl(memvo.getJoinPathCd(), ""))) {
			
			//구매 감사 쿠폰정보 GET
			CodeDetailVO cupnCodeVo1 = this.cacheService.getCodeCache(CommonConstants.AUTO_ISU_COUPON, CommonConstants.AUTO_ISU_COUPON_FIRSTORDER); //최초
			CodeDetailVO cupnCodeVo2 = this.cacheService.getCodeCache(CommonConstants.AUTO_ISU_COUPON, CommonConstants.AUTO_ISU_COUPON_SECNDORDER); //두번째
	//		CodeDetailVO cupnCodeVo3 = this.cacheService.getCodeCache(CommonConstants.AUTO_ISU_COUPON, CommonConstants.AUTO_ISU_COUPON_THIRDORDER); //세번째
			
			//구매 감사 쿠폰지급 여부 체크
			MemberCouponSO mso = new MemberCouponSO();
			mso.setMbrNo(myMbrNo);
			mso.setCpNo(cupnCodeVo1.getUsrDfn1Val() != null ? Long.valueOf(cupnCodeVo1.getUsrDfn1Val()) : null); //최초
			MemberCouponVO giveCupnvo1 = memberCouponDao.getMemberCouponDetail(mso);
			mso.setCpNo(cupnCodeVo2.getUsrDfn1Val() != null ? Long.valueOf(cupnCodeVo2.getUsrDfn1Val()) : null); //두번째
			MemberCouponVO giveCupnvo2 = memberCouponDao.getMemberCouponDetail(mso);
	//		mso.setCpNo(cupnCodeVo3.getUsrDfn1Val() != null ? Long.valueOf(cupnCodeVo3.getUsrDfn1Val()) : null); //세번째
	//		MemberCouponVO giveCupnvo3 = memberCouponDao.getMemberCouponDetail(mso);
	
			//구매 감사 쿠폰이 1건이라도 미지급된 경우이면
			if(giveCupnvo1 == null || giveCupnvo2 == null) {
				
				//구매확정 리스트 조회
				OrderDetailSO so = new OrderDetailSO();
				so.setMbrNo(myMbrNo);
				int ordPurchaseEndCnt = orderDetailDao.getOrderPurchaseConfirmCntByMbrNo(so);
				
				if(ordPurchaseEndCnt > 0) {
					if(ordPurchaseEndCnt == 1) {
						//최초 구매 감사 쿠폰 미지급시 발행
						if(giveCupnvo1 == null) {
							giveMemberCoupon(myMbrNo, cupnCodeVo1);
						}
						
					}else {
						//최초 구매 감사 쿠폰 미지급시 발행
						if(giveCupnvo1 == null) {
							giveMemberCoupon(myMbrNo, cupnCodeVo1);
						}
						//두번째 구매 감사 쿠폰 미지급시 발행
						if(giveCupnvo2 == null) {
							giveMemberCoupon(myMbrNo, cupnCodeVo2);
						}
					}
				}
			}
		}
	}
	
	/**
	 * 쿠폰 지급
	 * @param myMbrNo
	 * @param orderNo
	 * @param purchasCodeVo
	 */
	public Long giveMemberCoupon(Long myMbrNo, CodeDetailVO purchasCodeVo) {
		Long mbrCpNo = 0L;
		if(purchasCodeVo.getUseYn().equals("Y")) {
			MemberCouponPO mcPo = new MemberCouponPO();
			mcPo.setCpNo(Long.parseLong(purchasCodeVo.getUsrDfn1Val()));
			mcPo.setMbrNo(myMbrNo);
			mcPo.setSysRegrNo(myMbrNo);
			mcPo.setIsuTpCd(CommonConstants.ISU_TP_10);
			try {
				mbrCpNo = memberCouponService.insertMemberCoupon(mcPo);
			}catch(Exception e) {
				log.error(e.getMessage());
			}
		}
		return mbrCpNo;
		
	}
	
	/**
	 * 추천인 쿠폰 지급처리(피추천인이 최초 구매확정 처리시 1회만 쿠폰 지급처리) - 2021.04.12, by kek01
	 * 피추천인 = 주문한 사람 - 2021.06.03
	 * 추천인 = 주문한 사람이 가입 할 때 추천한 사람 - 2021.06.03
	 * 지급 쿠폰 = 동일 - 2021.06.03
	 * @param orderDetailList
	 * @param currOrdNo
	 */
	@Override
	@Transactional
	public void giveRecommandThanksCoupon(String orderNo) {
		CodeDetailVO rcomCodeVo = this.cacheService.getCodeCache(CommonConstants.AUTO_ISU_COUPON, CommonConstants.AUTO_ISU_COUPON_LNK_REWARD2);
		//추천인 지급 공통코드 사용여부 Y일 때만
		if(rcomCodeVo.getUseYn().equals("Y")) {
			//주문 상세 목록 조회
			OrderDetailSO odso = new OrderDetailSO();
			odso.setOrdNo(orderNo);
			List<OrderDetailVO> orderDetailList = this.orderDetailDao.listOrderDetail(odso);

			//나의 회원번호 SET
			Long myMbrNo = 0L;
			if(orderDetailList.size() > 0) {
				myMbrNo = orderDetailList.get(0).getMbrNo();

				//추천인 정보 GET
				MemberBaseSO bso = new MemberBaseSO();
				bso.setMbrNo(myMbrNo);
				Long myRcomMbrNo = Optional.ofNullable(memberBaseDao.getRecommanderInfo(bso)).orElseGet(()->0L); //추천인 회원번호

				/*
					TO-DO :: 운영에서 현재 RCOM_LOGIN_ID에 암호화 처리 안된 이메일이 들어간 ROW 존재(마이그 회원들임)
					그 중 MBR_NO가 17020,18958,18994,21574 의 회원들의 RCOM_LOGIN_ID 를 가진 회원들은 존재하지 않음(존재하는 회원들이 있음). 처리 필요
				 */
				//추천인 정보 있을 때만
				if(Long.compare(myRcomMbrNo,CommonConstants.NO_MEMBER_NO) != 0){
					//추천인 쿠폰 지급여부 체크
					MemberCouponSO mso = new MemberCouponSO();
					mso.setCpNo(rcomCodeVo.getUsrDfn1Val() != null ? Long.valueOf(rcomCodeVo.getUsrDfn1Val()) : null); //추천인 쿠폰번호
					mso.setMbrNo(myRcomMbrNo);
					MemberCouponVO rcomCupnvo = Optional.ofNullable(memberCouponDao.getMemberCouponDetail(mso)).orElse(null);

					//추천인 쿠폰이 미지급된 상태라면 지급처리
					if(rcomCupnvo == null) {
						MemberCouponPO mcPo = new MemberCouponPO();
						mcPo.setCpNo(Long.parseLong(rcomCodeVo.getUsrDfn1Val()));
						mcPo.setMbrNo(myRcomMbrNo);
						mcPo.setSysRegrNo(myRcomMbrNo);
						mcPo.setIsuTpCd(CommonConstants.ISU_TP_10);
						mcPo.setOrdNo(orderNo);
						try {
							memberCouponService.insertMemberCoupon(mcPo);
						}catch(Exception e) {
							log.error(e.getMessage());
						}
					}
				}
			}else{
				log.error("###################### There isn't ROW TABLE : ORDER_BASE , {}",orderNo);
			}
		}else{
			log.error("###################### Plz Check Code GRP_CD : {} \n DTL_CD : {} \n USE_YN : {} \n USR_DFN1_VAL : {}"
					,rcomCodeVo.getGrpCd(),rcomCodeVo.getDtlCd(),rcomCodeVo.getUseYn(),rcomCodeVo.getUsrDfn1Val());
		}

	}
	
	/*
	 * 원주문 목록 페이징 조회
	 *
	 * @see
	 * biz.app.order.service.OrderService#pageOrderOrg(biz.app.order.model.OrderSO)
	 */
	@Override
	@Transactional(readOnly = true)
	public List<OrderListVO> pageOrderOrg(OrderListSO so) {
		Integer rownum = 0;
		List<OrderListVO> baseData = this.orderDao.pageOrderOrg(so);
		List<OrderListVO> returnData = new ArrayList<>();

		for (OrderListVO temp : baseData) {
			int cnt = temp.getOrderDetalListVO().size();
			rownum = 0;

			for (OrderListVO orderListVO : temp.getOrderDetalListVO()) {

				rownum++;
				orderListVO.setOrdDlvNum(rownum);
				if( "member".equals(so.getSearchTypeExcel()) && rownum != 1) orderListVO.setRealDlvrAmt(0l);  // 엑셀에서 배송비는 첫 상품에만 부과로 표시
				orderListVO.setOrdDlvCnt(cnt);
				orderListVO.setDlvrcNo(temp.getDlvrcNo());

				returnData.add(orderListVO);
			}
		}

		return returnData;
	}
	
	/*
	 * 원주문 목록 페이징 조회 - Excel
	 *
	 * @see
	 * biz.app.order.service.OrderService#pageOrderOrg(biz.app.order.model.OrderSO)
	 */
	@Override
	@Transactional(readOnly = true)
	public List<OrderListExcelVO> orderOrgExcel(OrderListSO so) {
		Integer rownum = 0;
		List<OrderListExcelVO> baseData = this.orderDao.orderOrgExcel(so);
		List<OrderListExcelVO> returnData = new ArrayList<>();

		for (OrderListExcelVO temp : baseData) {
			int cnt = temp.getOrderDetalListVO().size();
			rownum = 0;

			for (OrderListExcelVO orderListVO : temp.getOrderDetalListVO()) {
				if (StringUtil.equals(orderListVO.getMkiGoodsYn(), CommonConstants.COMM_YN_Y)) {
					String[] mkiGoodsArr = null;
					String mkiGoodsStr = "";
					if (orderListVO.getMkiGoodsOptContent().indexOf("|") > -1) {
						mkiGoodsArr = orderListVO.getMkiGoodsOptContent().split("\\|");
						for(int i=0; i<mkiGoodsArr.length; i++) {
							mkiGoodsStr += "각인문구 " + (i+1) + " : " + mkiGoodsArr[i];
							if (i == mkiGoodsArr.length-1) {
								break;
							}
							mkiGoodsStr += ", ";
						}
					} else {
						mkiGoodsArr = new String[] {orderListVO.getMkiGoodsOptContent()};
						mkiGoodsStr = "각인문구 1 : " + mkiGoodsArr[0];
					}
					orderListVO.setMkiGoodsOptContent(mkiGoodsStr);
				}
				rownum++;
				orderListVO.setOrdDlvNum(rownum);
				if(rownum != 1) orderListVO.setRealDlvrAmt(0l);  // 엑셀에서 배송비는 첫 상품에만 부과로 표시
				orderListVO.setOrdDlvCnt(cnt);
				orderListVO.setDlvrcNo(temp.getDlvrcNo());

				returnData.add(orderListVO);
			}
		}

		return returnData;
	}
	
	/*
	 * 원주문 목록 페이징 조회 - Excel
	 *
	 * @see
	 * biz.app.order.service.OrderService#pageOrderOrg(biz.app.order.model.OrderSO)
	 */
	@Override
	@Transactional(readOnly = true)
	public List<OrderListExcelVO> orderAdjustExcel(OrderListSO so) {
		Integer rownum = 0;
		List<OrderListExcelVO> baseData = this.orderDao.orderAdjustExcel(so);
		List<OrderListExcelVO> returnData = new ArrayList<>();

		for (OrderListExcelVO temp : baseData) {
			int cnt = temp.getOrderDetalListVO().size();
			rownum = 0;

			for (OrderListExcelVO orderListVO : temp.getOrderDetalListVO()) {

				rownum++;
				orderListVO.setOrdDlvNum(rownum);
				orderListVO.setOrdDlvCnt(cnt);
				orderListVO.setDlvrcNo(temp.getDlvrcNo());
				orderListVO.setBizNo(StringUtil.bizNo(orderListVO.getBizNo()));
				returnData.add(orderListVO);
			}
		}

		return returnData;
	}


	/*
	 * 원주문 목록 페이징 조회 (API용)
	 *
	 * @see
	 * biz.app.order.service.OrderService#pageOrderOrg(biz.app.order.model.OrderSO)
	 */
	@Override
	@Transactional(readOnly = true)
	public List<biz.app.order.model.interfaces.OrderListVO> pageOrderOrgInterface(OrderListSO so) {
		return this.orderDao.pageOrderOrgInterface(so);
	}


	/*
	 * 주문 결제 정보
	 *
	 * @see biz.app.order.service.OrderService#getOrderPayInfo(java.lang.String)
	 */
	@Override
	public OrderPayVO getOrderPayInfo(String ordNo) {
		return this.orderDao.getOrderPayInfo(ordNo);
	}
	
	/*
	 * 프론트 결제 정보 조회
	 *
	 * @see biz.app.order.service.OrderService#getFrontPayInfo(java.lang.String)
	 */
	@Override
	public OrderPayVO getFrontPayInfo(String ordNo) {
		OrderPayVO orderPayVO = orderDao.getFrontPayInfo(ordNo);
		
		if(!ObjectUtils.isEmpty(orderPayVO.getOrdNo())) {
			
			// 배송비 조회
			ClaimBasePO claimBasePO = new ClaimBasePO();
			claimBasePO.setOrdNo(ordNo);
			claimBasePO.setUseYn("Y");
			/** 주문 상세 여부 -> 클레임 등록 전인데도 계산시 insert 된 건이 조회되어서 추가- */
			claimBasePO.setOrdDetailYn("Y");
			claimBasePO = deliveryChargeService.selectDeliveryCharge(claimBasePO);
			
			orderPayVO.setOrgDlvrAmt(claimBasePO.getOrgDlvrcAmt());
			orderPayVO.setClmDlvrcAmt(claimBasePO.getClmDlvrcAmt());
//			orderPayVO.setRefundAddDlvrAmt(0L);
			orderPayVO.setRefundDlvrAmt(claimBasePO.getRefundDlvrAmt());
			
	//		orderPayVO.setRefundDlvrAmt(claimBasePO.getRefundDlvrAmt());
	//		orderPayVO.setRefundAddDlvrAmt(claimBasePO.getClmDlvrcAmt());
	//		orderPayVO.setOrgDlvrAmt(claimBasePO.getOrgDlvrcAmt());
		}
		
		log.debug("getFrontPayInfo return : "+orderPayVO.toString());
		return orderPayVO;
	}
	
	/*
	 * 스냅샷에서 프론트 결제 주문/클레임 배송비, 추가배송비 조회
	 *
	 * @see biz.app.order.service.OrderService#getFrontPayRefundDlvrFromSnapshot(biz.app.order.model.OrderSO)
	 */
	@Override
	public OrderPayVO getFrontPayRefundDlvrFromSnapshot(OrderSO orderSO) {
		return deliveryChargeDao.getFrontPayRefundDlvrFromSnapshot(orderSO);
	}

	/*
	 * 주문/배송조회 리스트
	 *
	 * @see
	 * biz.app.order.service.OrderService#pageOrderDeliveryList(biz.app.order.model.OrderSO)
	 */
	@Override
	public List<OrderDeliveryVO> pageOrderDeliveryList(OrderSO orderSO) {
		return orderDao.pageOrderDeliveryList(orderSO);
	}

	/**
	 * <pre>
	 * - 프로젝트명		: gs-apet-11-business
	 * - 메서드명		: pageOrderDeliveryList
	 * - 작성일		: 2021. 04. 15.
	 * - 작성자		: sorce
	 * - 설명			: 임시메서드 기존 리스트 에러 안나도록
	 * </pre>
	 * @param orderSO
	 * @return
	 */
	public List<OrderBaseVO> pageOrderDeliveryList2ndE( OrderSO orderSO ) {
		return orderDao.pageOrderDeliveryList2ndE(orderSO);
	}
	
	/*
	 * 무통장/가상계좌 미입금된 목록 조회
	 *
	 * @see biz.app.order.service.OrderService#listPaymentAdviceEmail()
	 */
	@Override
	public List<BatchOrderVO> listPaymentAdviceEmail() {
		return orderDao.listPaymentAdviceEmail();
	}

	/*
	 * 가상계좌 1시간 경과 후 미입금된 목록 조회
	 *
	 * @see biz.app.order.service.OrderService#listNdpstMsgSendKko()
	 */
	@Override
	public List<OrderMsgVO> listNdpstMsgSendKko() {
		return orderDao.listNdpstMsgSendKko();
	}

	/*
	 * 계산서/영수증 조회 및 신청 리스트 조회
	 *
	 * @see
	 * biz.app.order.service.OrderService#pageOrderReceiptList(biz.app.order.model.OrderSO)
	 */
	@Override
	public List<OrderReceiptVO> pageOrderReceiptList(OrderSO so) {
		return this.orderDao.pageOrderReceiptList(so);
	}


	/*
	 * 취소/교환/반품 신청 가능 주문 리스트 조회
	 *
	 * @see
	 * biz.app.order.service.OrderService#pageClaimRequestList(biz.app.order.model.OrderSO)
	 */
	@Override
	public List<OrderClaimVO> pageClaimRequestList(OrderSO orderSO) {
		return this.orderDao.pageClaimRequestList(orderSO);
	}


	/*
	 * 나의 최근 주문현황
	 *
	 * @see
	 * biz.app.order.service.OrderService#listOrderCdCountList(biz.app.order.model.OrderSO)
	 */
	@Override
	public OrderStatusVO listOrderCdCountList(OrderSO orderSO) {
		return this.orderDao.listOrderCdCountList(orderSO);
	}


	/*
	 * 주문 취소 리스트 조회
	 *
	 * @see
	 * biz.app.order.service.OrderService#listCancelDetailList(biz.app.order.model.OrderSO)
	 */
	@Override
	public List<OrderDeliveryVO> listCancelDetail(OrderSO so) {
		return this.orderDao.listCancelDetail(so);
	}
	
	/*
	 * 주문 리스트 조회
	 *
	 * @see
	 * biz.app.order.service.OrderService#listCancelDetailList(biz.app.order.model.OrderSO)
	 */
	@Override
	public List<OrderDeliveryVO> listClaimDetail(OrderSO so) {
		return this.orderDao.listClaimDetail(so);
	}

	/*
	 * 주문  구매확정 리스트 조회
	 *
	 * @see
	 * biz.app.order.service.OrderService#listCancelDetailList(biz.app.order.model.OrderSO)
	 */
	@Override
	public List<OrderDeliveryVO> listPurchaseDetail(OrderSO so) {
		return this.orderDao.listPurchaseDetail(so);
	}


	/*
	 * 주문 교환 리스트 조회
	 *
	 * @see
	 * biz.app.order.service.OrderService#listCancelDetailList(biz.app.order.model.OrderSO)
	 */
	@Override
	public List<OrderDeliveryVO> listExchangeDetail(OrderSO so) {
		return this.orderDao.listExchangeDetail(so);
	}


	/*
	 * 나의 최근 주문 목록
	 *
	 * @see
	 * biz.app.order.service.OrderService#listMyRecentOrderGoods(biz.app.order.model.OrderSO)
	 */
	@Override
	public List<OrderDetailVO> listMyRecentOrderGoods(OrderSO os) {
		return this.orderDao.listMyRecentOrderGoods(os);
	}


	/*
	 * 주문에 해당하는 적용 혜택 목록 조회
	 *
	 * @see biz.app.order.service.OrderService#listOrderAplBnft(biz.app.order.model.AplBnftSO)
	 */
	@Override
	public List<AplBnftVO> listOrderAplBnft(AplBnftSO abso) {
		return orderDao.listOrderAplBnft(abso);
	}


	/*
	 * front 구매영수증 팝업
	 *
	 * @see
	 * biz.app.order.service.OrderService#listPurchaseReceipt(biz.app.order.model.OrderSO)
	 */
	@Override
	public List<OrderDetailVO> listPurchaseReceipt(OrderSO orderSO) {
		return orderDao.listPurchaseReceipt(orderSO);
	}


	/*
	 * Front 1:1문의 주문정보 선택
	 *
	 * @see
	 * biz.app.order.service.OrderService#pageOrderDeliveryList(biz.app.order.model.OrderSO)
	 */
	@Override
	public List<OrderDeliveryVO> pageOrderInfoList(OrderSO orderSO) {

		List<OrderDeliveryVO> listOrderProdList = null;
		List<OrderDeliveryVO> listOrderNo = orderDao.pageOrderInfoList(orderSO);

		Map<String, Object> param = new HashMap<>();

		if (!listOrderNo.isEmpty()) {
			String[] arrOrderNo = new String[listOrderNo.size()];

			for (int i = 0; i < listOrderNo.size(); i++) {
				// 주문번호
				arrOrderNo[i] = listOrderNo.get(i).getOrdNo();
			}
			orderSO.setArrOrdNo(arrOrderNo);

			param.put("ordAcptDtmStart", orderSO.getOrdAcptDtmStart());
			param.put("ordAcptDtmEnd", orderSO.getOrdAcptDtmEnd());
			param.put("mbrNo", orderSO.getMbrNo());
			param.put("arrOrdNo", orderSO.getArrOrdNo());
			param.put("ordDtlStatCd", orderSO.getOrdDtlStatCd());

		}

		listOrderProdList = orderDao.listOrderProdList(param);

		return listOrderProdList;
	}


	/*
	 * batch. 미입금된 주문 목록 조회
	 *
	 * @see
	 * biz.app.order.service.OrderService#listUnpaidOrder()
	 */
	public List<OrderDetailVO> listUnpaidOrder() {
		return orderDetailDao.listUnpaidOrder();
	}

	/*
	 * 주문 반품 리스트 조회
	 *
	 * @see
	 * biz.app.order.service.OrderService#listCancelDetailList(biz.app.order.model.OrderSO)
	 */
	@Override
	public List<OrderDeliveryVO> listReturnDetail(OrderSO so) {
		return this.orderDao.listReturnDetail(so);
	}

	@Override
	public void saveDefaultPayMethod(PrsnPaySaveInfoPO ppsipo) {

		int result = this.orderDao.saveDefaultPayMethod(ppsipo);

		if ( result == 0 ) {
			throw new OrderException( ExceptionConstants.ERROR_SAVE_DEFAULT_PAY_METHOD);
		} else {
			// 간편결제 카드 pk 가 null이 아니면 간편결제 카드 기본 여부 업데이트
			if (StringUtil.isNotEmpty(ppsipo.getPrsnCardBillNo())) {
				result = this.orderDao.updateDefaultPrsnCard(ppsipo);
			} else {
				ppsipo.setPrsnCardBillNo(null);
				result = this.orderDao.updateDefaultPrsnCard(ppsipo);
			}
		}
	}

	@Override
	public PrsnPaySaveInfoVO getCashReceiptSaveInfo(Long mbrNo) {
		return orderDao.getCashReceiptSaveInfo(mbrNo);
	}
	
	@Override
	public Integer saveCashReceiptSaveInfo(PrsnPaySaveInfoPO po) {
		return orderDao.saveCashReceiptSaveInfo(po);
	}
	
	/* (non-Javadoc)
	 * @see biz.app.order.service.OrderService#getCardcInstmntInfo(biz.app.order.model.CardcInstmntInfoSO)
	 */
	@Override
	public List<CardcInstmntInfoVO> getCardcInstmntInfo(CardcInstmntInfoSO so) {
		return orderDao.getCardcInstmntInfo(so);
	}

	@Override
	public String insertRegistBillCardTemp(PrsnCardBillingInfoPO pcbipo) {

		int prsnCardBillNo = this.orderDao.insertRegistBillCardTemp(pcbipo);

		String tempPrsnCardBillNo = Integer.toString(prsnCardBillNo);

		if ( tempPrsnCardBillNo == null || "".equals(tempPrsnCardBillNo) ) {
			throw new OrderException( ExceptionConstants.ERROR_SAVE_TEMP_PRSN_BILL);
		}

		if(pcbipo.getSimpScrNo() != null && !"".equals(pcbipo.getSimpScrNo())){
			this.updateBillPassword(pcbipo);
		}

		return tempPrsnCardBillNo;
	}

	@Override
	public void updateRegistBillCard(PrsnCardBillingInfoPO pcbipo) {

		int result = orderDao.updateRegistBillCard(pcbipo);

		if (result != 1) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
	}

	@Override
	public String getBillingKey(String prsnCardBillNo){

		return orderDao.getBillingKey(prsnCardBillNo);
	}

	@Override
	public Map<String, Object> checkBillPassword(PrsnCardBillingInfoPO pcbipo) {

		Map<String, Object> result = new HashMap<>();

		PrsnCardBillingInfoVO pcbivo = orderDao.getBillInfo(pcbipo.getMbrNo());

		if(pcbivo.getBillInputFailCnt() != null && pcbivo.getBillInputFailCnt() >= 4) { //5번 실패해야만 하지만 0부터 시작이므로 4로 설정
			result.put("exCode", ExceptionConstants.ERROR_CODE_FO_PW_FAIL_CNT);
			return result;
		}

		String simpScrNo = bizService.oneWayEncrypt(pcbipo.getSimpScrNo());
		//비밀번호 틀린 경우
		if (!pcbivo.getSimpScrNo().equals(simpScrNo)) {

			result.put("exCode", ExceptionConstants.ERROR_CODE_LOGIN_PW_FAIL);
			//비밀번호입력 실패수 증가
			PrsnCardBillingInfoPO failpo = new PrsnCardBillingInfoPO();

			failpo.setMbrNo(pcbipo.getMbrNo());

			orderDao.updateInputFailCnt(failpo);

			return result;
		}

		return result;
	}

	@Override
	public void updateBillPassword(PrsnCardBillingInfoPO pcbipo) {

		int result = orderDao.updateBillPassword(pcbipo);

		if (result != 1) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		} else {
			// 이력등록
			MemberBasePO po  = new MemberBasePO();
			po.setMbrNo(pcbipo.getMbrNo());
			po.setUpdrIp(bizService.twoWayEncrypt(RequestUtil.getClientIp()));

			if(memberBaseDao.insertMemberBaseHistory(po) == 0){
				throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
			}
		}

	}

	@Override
	public void resetInputFailCnt(PrsnCardBillingInfoPO pcbipo) {

		int result = orderDao.resetInputFailCnt(pcbipo);

		if (result != 1) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

	}

	@Override
	public int getBillInputFailCnt(Long mbrNo){

		return orderDao.getBillInputFailCnt(mbrNo);
	}

	@Override
	public void deleteBillCardInfo(PrsnCardBillingInfoPO delpo) {

		int result = orderDao.deleteBillCardInfo(delpo);

		if (result != 1) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

	}
	
	@Override
	public void sendMessage(String ordNo, String clmNo, String tmplCd, Integer ordDtlSeq) {
		this.sendMessage(ordNo, clmNo, tmplCd, ordDtlSeq, null, null);
	}

	@Override
	public void sendMessage(String ordNo, String clmNo, String tmplCd, Integer ordDtlSeq, Integer[] arrOrdDtlSeq) {
		this.sendMessage(ordNo, clmNo, tmplCd, ordDtlSeq, arrOrdDtlSeq, null);
	}

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: OrderServiceImpl.java
	* - 작성일	: 2021. 4. 23.
	* - 작성자 	: valfac
	* - 설명 		: 주문 메세지 send
	* </pre>
	*
	* @param ordNo
	* @param clmNo
	* @param tmplCd
	*/
	@Override
	public void sendMessage(String ordNo, String clmNo, String tmplCd, Integer ordDtlSeq, Integer[] arrOrdDtlSeq, String invNo) {
		
 		
		OrderSO orderSO = new OrderSO();
		orderSO.setOrdNo(ordNo);
		orderSO.setClmNo(clmNo);
		if (arrOrdDtlSeq != null) {
			orderSO.setArrOrdDtlSeq(arrOrdDtlSeq);
		} else {
			orderSO.setOrdDtlSeq(ordDtlSeq);
		}
		
		// 송장번호 세팅 - 송장단위로 알림톡 발송시
		if(invNo != null) {
			orderSO.setInvNo(invNo);
		}
		
		if(!StringUtils.isEmpty(clmNo)) {
			orderSO.setMsgType("clm");
		}else if(StringUtils.equals(tmplCd, "K_M_ord_00015") || StringUtils.equals(tmplCd, "K_M_ord_0016") || StringUtils.equals(tmplCd, "K_M_ord_0017") || StringUtils.equals(tmplCd, "K_M_ord_0018") || StringUtils.equals(tmplCd, "K_M_ord_0008")) {
			orderSO.setMsgType("dlv");
		}else {
			orderSO.setMsgType("default");
		}
		
		List<OrderMsgVO> msgInfoList = orderDao.listOrderMsgInfo(orderSO);
		
		SimpleDateFormat sDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		SsgMessageSendPO msg = new SsgMessageSendPO();

		PushSO pso = new PushSO();
		
		if(!StringUtils.isEmpty(tmplCd)) {
			pso.setTmplCd(tmplCd);
		}else if(CommonConstants.PAY_MEANS_30.equals(msgInfoList.get(0).getPayMeansCd())) {
			if(CommonConstants.PAY_STAT_00.equals(msgInfoList.get(0).getPayStatCd())) {
				pso.setTmplCd("K_M_ord_0012"); //가상계좌 주문완료 (입금대기시)
			}else {
				pso.setTmplCd("K_M_ord_0014"); //가상계좌 입금완료시
			}
		} else {
			pso.setTmplCd("K_M_ord_0014"); //결제완료
		}
		
		PushVO pvo = pushService.getNoticeTemplate(pso); // 템플릿 조회
		
		for(OrderMsgVO msgInfo: msgInfoList) {
			log.error("[오류아님 확인용] ### 알림톡 발송 - ordNo:"+msgInfo.getOrdNo());
			boolean isOrderDtmCheck = true;
			// 3일 이내 주문시 발송 4,5,6,7,8
			if(StringUtils.equals(pvo.getTmplCd(), "K_M_ord_00015") || StringUtils.equals(pvo.getTmplCd(), "K_M_ord_0016") || StringUtils.equals(pvo.getTmplCd(), "K_M_ord_0017") || StringUtils.equals(pvo.getTmplCd(), "K_M_ord_0018") || StringUtils.equals(pvo.getTmplCd(), "K_M_ord_0008")) {
				isOrderDtmCheck = msgInfo.getIsOrderDtmCheck();
			}
			
			if(pvo != null && isOrderDtmCheck) {
				String message = pvo.getContents(); //템플릿 내용
				message = message.replace("${mbr_nm}", msgInfo.getOrdNm());
				
				message = message.replace("${ord_acpt_dtm}", msgInfo.getOrdAcptDtm() != null ? sDate.format(msgInfo.getOrdAcptDtm()) : ""); // 주문접수일시
				message = message.replace("${order_date}", msgInfo.getOrdCpltDtm() != null ? sDate.format(msgInfo.getOrdCpltDtm())  : ""); // 주문완료일시
				if(!StringUtils.isEmpty(clmNo)) {
					message = message.replace("${order_clm_date}", msgInfo.getClmAcptDtm() != null ? sDate.format(msgInfo.getClmAcptDtm()) : ""); // 주문취소,반품,교환 일시
					message = message.replace("${rtna_road_addr}", msgInfo.getClmRtnaRoadAddr() != null ? msgInfo.getClmRtnaRoadAddr() : ""); // 회수지 주소
					message = message.replace("${road_addr}", msgInfo.getClmRoadAddr() != null ? msgInfo.getClmRoadAddr() : "");  //배송지 주소
				}else {
					message = message.replace("${road_addr}", msgInfo.getRoadAddr() != null ? msgInfo.getRoadAddr() : "");
				}
				
				message = message.replace("${order_no}", msgInfo.getOrdNo());
				message = message.replace("${goods_nm}", msgInfo.getGoodsNm() != null ? msgInfo.getGoodsNm() : "");
				int ordQty = msgInfo.getExtraOrdCnt()-1;
				if(ordQty > 0 ) {
					message = message.replace("${extra_ord_cnt}", "외 "+ordQty+"개");
				} else {
					message = message.replace("${extra_ord_cnt}", "");
				}
				message = message.replace("${pay_amt}", StringUtil.formatMoney(msgInfo.getPayAmt().toString()));
				message = message.replace("${bank_nm}", msgInfo.getBankNm() != null ? msgInfo.getBankNm() : "");
				message = message.replace("${acct_no}", msgInfo.getAcctNo() != null ? msgInfo.getAcctNo().toString() : "");
				if(msgInfo.getDpstSchdDt() != null) {
					SimpleDateFormat dtFormat = new SimpleDateFormat("yyyyMMddHHmmss");
					SimpleDateFormat fDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); //같은 형식으로 맞춰줌
					String strNewDtFormat = "";
					try {
						Date dpstSchdDt = dtFormat.parse(msgInfo.getDpstSchdDt());
						strNewDtFormat = fDate.format(dpstSchdDt);	
					} catch (ParseException e) {
						e.printStackTrace();
					}
					message = message.replace("${final_date}", strNewDtFormat);
				}else {
					message = message.replace("${final_date}", "");
				}
				
				message = message.replace("${hdc_cd_nm}", msgInfo.getHdcCdNm() != null ? msgInfo.getHdcCdNm() : ""); // 배송업체 orderBase HDC_CD_NM
				message = message.replace("${inv_no}", msgInfo.getInvNoNm() != null ? msgInfo.getInvNoNm() : ""); // 송장번호 orderBase DFT_INV_NO
				message = message.replace("${pay_means_nm}", msgInfo.getPayMeansNm() != null ? msgInfo.getPayMeansNm() : ""); // 결제수단
			
				msg.setFmessage(message);// 템플릿 내용 replace(데이터 바인딩)
				msg.setSndTypeCd(CommonConstants.SND_TYPE_30); // 카카오
				msg.setFdestine(msgInfo.getOrdrMobile());
				msg.setFtemplatekey(pvo.getTmplCd());//템플릿 키
				msg.setMbrNo(msgInfo.getMbrNo());
				msg.setFuserid(String.valueOf(msgInfo.getMbrNo()));
				
				if(!StringUtils.equals(pvo.getTmplCd(), "K_M_ord_0012") && !StringUtils.equals(pvo.getTmplCd(), "K_M_ord_0013") && !StringUtils.equals(pvo.getTmplCd(), "K_M_ord_0014")) {
					String today = DateUtil.getTimestampToString(DateUtil.getTimestamp(), "yyyyMMdd");
					Calendar limitSendStartTime = DateUtil.getCalendar(today);
					Calendar limitSendEndTime = DateUtil.getCalendar(today);
					Calendar reservTime = DateUtil.getCalendar(today);
				
					limitSendStartTime.add(Calendar.HOUR_OF_DAY, 8);
					limitSendEndTime.add(Calendar.HOUR_OF_DAY, 21);
					reservTime.add(Calendar.HOUR_OF_DAY, 32);
					 
//					현재 시간이 8시~21사이가 아니면 익일 오전 8시 예약 발송  
					if( !DateUtil.isPast(sDate.format(limitSendStartTime.getTime())) && !DateUtil.isPast(sDate.format(limitSendEndTime.getTime()))
							) {
						msg.setNoticeTypeCd(CommonConstants.NOTICE_TYPE_10);// 즉시
					}else {
						msg.setFsenddate(DateUtil.getTimestamp(sDate.format(reservTime.getTime()), "yyyyMMddHHmmss"));
						msg.setNoticeTypeCd(CommonConstants.NOTICE_TYPE_20);// 예약
					}
				} else {
					msg.setNoticeTypeCd(CommonConstants.NOTICE_TYPE_10);// 즉시
				}
				
				// 알림톡 버튼 '배송 조회하기' setting start
				if(StringUtils.equals(pvo.getTmplCd(), "K_M_ord_0016") || StringUtils.equals(pvo.getTmplCd(), "K_M_ord_0018")) {
					List<SsgKkoBtnPO> list = new ArrayList<>();
					SsgKkoBtnPO sKPo = new SsgKkoBtnPO();
					sKPo.setBtnName(this.message.getMessage("business.msg.select.delevery"));
					sKPo.setBtnType(CommonConstants.KKO_BTN_TP_DS);
					list.add(sKPo);
					msg.setButtionList(list);
				}
				// 알림톡 버튼 '배송 조회하기' setting end
				
				bizService.sendMessage(msg);
			}
		
		}
		
	}

	@Override
	public List<OrderMsgVO> listOrderCompInfo(OrderSO so) {
		// 알림 발송 업체 목록
		List<OrderMsgVO> ordCompList = new ArrayList<OrderMsgVO>();
		
		// 업체 주문 정보 조회
		List<OrderMsgVO> compList = orderDao.listOrderCompInfo(so);
		
		if (CollectionUtils.isNotEmpty(compList)) {
			String tsStr = DateUtil.getTimestampToString(so.getOrdAcptDtmStart(), "yyyyMMddHHmmss");
			String timeStr = tsStr.substring(8, 14);
			
			Calendar cal = Calendar.getInstance();
			cal.set(Calendar.HOUR_OF_DAY, Integer.parseInt(timeStr.substring(0, 2)));
			String timeHour = String.valueOf(cal.get(Calendar.HOUR_OF_DAY));
			
			for(OrderMsgVO omvo : compList) {
				OrderSO coso = new OrderSO();
				coso.setOrdAcptDtmStart(so.getOrdAcptDtmStart());
				coso.setOrdAcptDtmEnd(so.getOrdAcptDtmStart());
				coso.setCompNo(omvo.getCompNo());
				coso.setOrdDtlStatCd(so.getOrdDtlStatCd());
				
				String ordCletCharAlmCd = omvo.getOrdCletCharAlmCd();
				
				if (StringUtil.equals(timeHour, CommonConstants.ORD_CLET_CHAR_ALM_09)) {
					// 배치 hour '09'일 경우
					if (ordCletCharAlmCd.contains(CommonConstants.ORD_CLET_CHAR_ALM_12) && ordCletCharAlmCd.contains(CommonConstants.ORD_CLET_CHAR_ALM_15)) {
						coso.setOrdAcptDtmCompSearch("search18");
					} else if (ordCletCharAlmCd.contains(CommonConstants.ORD_CLET_CHAR_ALM_12)) {
						coso.setOrdAcptDtmCompSearch("search21");
					} else if (ordCletCharAlmCd.contains(CommonConstants.ORD_CLET_CHAR_ALM_15)) {
						coso.setOrdAcptDtmCompSearch("search18");
					} else {
						coso.setOrdAcptDtmCompSearch("search01");
					}
				} else if (StringUtil.equals(timeHour, CommonConstants.ORD_CLET_CHAR_ALM_12)) {
					// 배치 hour '12'일 경우
					if (ordCletCharAlmCd.contains(CommonConstants.ORD_CLET_CHAR_ALM_09) && ordCletCharAlmCd.contains(CommonConstants.ORD_CLET_CHAR_ALM_15)) {
						coso.setOrdAcptDtmCompSearch("search03");
					} else if (ordCletCharAlmCd.contains(CommonConstants.ORD_CLET_CHAR_ALM_09)) {
						coso.setOrdAcptDtmCompSearch("search03");
					} else if (ordCletCharAlmCd.contains(CommonConstants.ORD_CLET_CHAR_ALM_15)) {
						coso.setOrdAcptDtmCompSearch("search21");
					} else {
						coso.setOrdAcptDtmCompSearch("search01");
					}
				} else if (StringUtil.equals(timeHour, CommonConstants.ORD_CLET_CHAR_ALM_15)) {
					// 배치 hour '15'일 경우
					if (ordCletCharAlmCd.contains(CommonConstants.ORD_CLET_CHAR_ALM_09) && ordCletCharAlmCd.contains(CommonConstants.ORD_CLET_CHAR_ALM_12)) {
						coso.setOrdAcptDtmCompSearch("search03");
					} else if (ordCletCharAlmCd.contains(CommonConstants.ORD_CLET_CHAR_ALM_09)) {
						coso.setOrdAcptDtmCompSearch("search06");
					} else if (ordCletCharAlmCd.contains(CommonConstants.ORD_CLET_CHAR_ALM_12)) {
						coso.setOrdAcptDtmCompSearch("search03");
					} else {
						coso.setOrdAcptDtmCompSearch("search01");
					}
				}
				
				// 위탁업체 주문건 수집 쿼리 (주문건수, 업체 담당자 mobile)
				List<OrderMsgVO> listCompInfo = orderDao.listOrderCompMobile(coso);
				for(OrderMsgVO ocivo : listCompInfo) {
					ordCompList.add(ocivo);
				}
			}
		}
		
		return ordCompList;
	}

	@Override
	public List<OrderAdbrixVO> listCartAdbrix(CartGoodsSO so) {
		return orderDao.listCartAdbrix(so);
	}

	@Override
	public OrderBaseVO getMaskingOrderBaseVO(OrderBaseVO vo) {
		vo.setOrdrId(MaskingUtil.getId(vo.getOrdrId()));
		vo.setOrdNm(MaskingUtil.getName(vo.getOrdNm()));
		vo.setMbrNm(MaskingUtil.getName(vo.getMbrNm()));
		vo.setOrdrMobile(MaskingUtil.getTelNo(vo.getOrdrMobile()));
		vo.setOrdrTel(MaskingUtil.getTelNo(vo.getOrdrTel()));
		vo.setOrdrEmail(MaskingUtil.getEmail(vo.getOrdrEmail()));
		return vo;
	}
	@Override
	public OrderDlvraVO getMaskingOrderDlvraVO(OrderDlvraVO vo){
		if(vo != null) {
			vo.setAdrsNm(MaskingUtil.getName(vo.getAdrsNm()));
			vo.setTel(MaskingUtil.getTelNo(vo.getTel()));
			vo.setMobile(MaskingUtil.getTelNo(vo.getMobile()));
			vo.setRoadAddr(MaskingUtil.getAddress(vo.getRoadAddr(), vo.getRoadDtlAddr()));
			vo.setRoadDtlAddr(MaskingUtil.getMaskedAll(vo.getRoadDtlAddr()));
		}
		return vo;
	}

	@Override
	public List<GoodsBaseVO> listWebStkQty(GoodsBaseSO so) {
		return itemDao.listWebStkQty(so);
	}
	
	@Override
	public int deleteOrdDtlCstrtDlvrMap(String ordNo, Long ordDtlSeq) {
		
		int resultCnt = 0;
		
		// CSR-1533 배송지시 시 중복으로 들어간 ordDtlCstrtDlvrMap 삭제 후 다시 insert 처리 (대표 번호 제외 삭제 처리)
		if(StringUtils.isNotEmpty(ordNo) && ordDtlSeq > 0) {
			
			OrdDtlCstrtDlvrMapPO deleteOrdDtlCstrtDlvrMapPO = new OrdDtlCstrtDlvrMapPO();
			
			deleteOrdDtlCstrtDlvrMapPO.setOrdNo(ordNo);
			deleteOrdDtlCstrtDlvrMapPO.setOrdDtlSeq(ordDtlSeq);
			
			resultCnt = ordDtlCstrtDlvrMapDao.deleteOrdDtlCstrtDlvrMap(deleteOrdDtlCstrtDlvrMapPO);
			
			log.info("### deleteOrdDtlCstrtDlvrMap (배송 대표 번호 제외 삭제 처리) : "+ordNo+" , "+ordDtlSeq);
		}
		
		return resultCnt; 
					
	}
}
