package biz.interfaces.wms.constants;

import java.util.Arrays;
import java.util.Collection;
import java.util.stream.Collectors;
import java.util.stream.Stream;

public class WmsInterfaceConstant{

	/*
	 * 인터페이스 방향
	 */
	public enum Direction {
		
		  Send("S")	// 송신
		, Receipt("R")	// 수신
		;
		
		// DB 저장용
		private String code;
		private Direction(String code) {
			this.code = code;
		}
		public String getCode() {
			return code;
		}
	}
	
	/*
	 * 인터페이스 전문
	 */
	public enum WmsDocs {
		//단방향 -------------------------------//
		  IF_007(Direction.Send		, "wmsCommonCodeService"		 , "/ifsChannelService/commonReason"					)	//공통사유마스터
		, IF_008(Direction.Receipt	, "wmsCenterinfoService"		 														)	//물류센터마스터 :: /rest/V1/wms/centerinfo
		, IF_009(Direction.Receipt	, "wmsPostareaService"			 														)	//우편번호 권역매핑 :: /rest/V1/wms/postarea
		, IF_010(Direction.Receipt	, "wmsFixedrouteService"		 														)	//고정노선마스터 :: /rest/V1/wms/fixedroute
		, IF_039(Direction.Receipt	, "wmsSmsService"				 														)	//WMS SMS 발송 :: /rest/V1/wms/sms
		, IF_006(Direction.Send		, "wmsCustomerService"			 , "/ifsChannelService/customer"						)	//고객마스터
		, IF_004(Direction.Send		, "wmsSupplierService"			 , "/ifsChannelService/supplier"						)	//협력사마스터
		, IF_005(Direction.Send		, "wmsSupplierWorkingService"	 , "/ifsChannelService/supplierWorking"					)	//협력사월력(영업일)
		, IF_038(Direction.Send		, "wmsPurchaseMasterService"	 , "/ifsChannelService/purchaseMaster"					)	//매입마스터
		, IF_001(Direction.Send		, "wmsCategoryService"			 , "/ifsChannelService/itemGroup"						)	//상품그룹
		, IF_002(Direction.Send		, "wmsGoodsSerivce"				 , "/ifsChannelService/item"							)	//상품 
		, IF_034(Direction.Receipt	, "wmsGoodsSyncstockService"	 														)	//재고동기화 :: /rest/V1/wms/goods/syncstock
//		, IF_035(Direction.Receipt	, "wmsGoodsRealstockService"	 														)	//(IF_034와 통합) 재고동기화 변동분:: /rest/V1/wms/goods/realstock
		
		//주문 ----------------------------------//
		, IF_022(Direction.Send		, "wmsShipmentOrderService"		 , Boolean.TRUE, "/ifsChannelService/outboundOrder"		)	//출고지시정보(배송지시)
		, IF_023(Direction.Receipt	, "wmsDeliveryStatusService"	 , Boolean.TRUE											)	//플랫폼주문상태변경(출고진행상태,후계근포함) :: /rest/V1/wms/delivery/status
		, IF_025(Direction.Receipt	, "wmsDeliverySoldoutService"	 , Boolean.TRUE											)	//출고결품정보 :: /rest/V1/wms/delivery/soldout
		, IF_026(Direction.Send		, "wmsFinalizeSalesService"		 , Boolean.TRUE, "/ifsChannelService/finalizeSales"		)	//매출확정(후계근)
//		, IF_027(Direction.Receipt	, "wmsDeliveryShipmentService"	 , Boolean.TRUE											)	//출고확정 :: /rest/V1/wms/delivery/shipment
		, IF_024(Direction.Send		, "wmsCancelOrderService"		 , Boolean.TRUE, "/ifsChannelService/cancelOrder"		)	//주문취소
		, IF_029(Direction.Send		, "wmsReturnOrderService"		 , Boolean.TRUE, "/ifsChannelService/returnOrder"		)	//반품오더(반품신청)		
		, IF_030(Direction.Receipt	, "wmsReturnWearService"		 , Boolean.TRUE											)	//반품회수실적(반품회수)  :: /rest/V1/wms/return/wear
		, IF_045(Direction.Send		, "wmsCancelReturnOrderService"	 , Boolean.TRUE, "/ifsChannelService/returnWithdrawal"	)	//반품철회		
		, IF_037(Direction.Receipt	, "wmsDeliveryDelayService"		 , Boolean.TRUE											)	//배송지연알림(직배) :: /rest/V1/wms/delivery/delay
		, IF_040(Direction.Send		, "wmsTaxbillIssueRequestService", Boolean.TRUE, "/ifsChannelService/taxBillIssueRequest")	//세금계산서 발행요청
		, IF_043(Direction.Receipt	, "wmsTaxbillIssueResultService" , Boolean.TRUE											)	//세금계산서 발행결과 :: /rest/V1/wms/taxbill/issueResult
		;

		// 인터페이스 방향
		private Direction direction;
		// process bean name :: Service 생성 후 annotation으로 정의
		private String beanName;
		// 주문관련 Interface 여부
		private Boolean isOrderDoc = Boolean.FALSE;
		// Send 전문의 요청 uri
		private String uri;
		
		// 인터페이스 전문 Constructor
		private WmsDocs(Direction direction, String beanName) {
			this.direction 	= direction;
			this.beanName	= beanName;
		}
		private WmsDocs(Direction direction, String beanName, String uri) {
			this.direction 	= direction;
			this.beanName	= beanName;
			this.uri		= uri;
		}
		private WmsDocs(Direction direction, String beanName, Boolean isOrderDoc) {
			this.direction = direction;
			this.beanName  = beanName;
			this.isOrderDoc= isOrderDoc;
		}
		private WmsDocs(Direction direction, String beanName, Boolean isOrderDoc, String uri) {
			this.direction = direction;
			this.beanName  = beanName;
			this.isOrderDoc= isOrderDoc;
			this.uri	   = uri;
		}		
		public Direction getDirection() {
			return direction;
		}
		public String getUri() {
			return uri;
		}
		public Boolean getOrderDoc() {
			return isOrderDoc;
		}
		public String getBeanName() {
			return beanName;
		}
		// enum type으로 변환
		public static WmsDocs findByName(String interfaceId) {
			return Arrays.stream(WmsDocs.values())
					.filter(v -> v.name().equals(interfaceId))
					.findAny()
					.orElse(null);
		}
		// WMS I/F 전문중 송신건만
		public static Collection<WmsDocs> getSendWmsDocs(){
			return Stream.of(WmsDocs.values())
					.filter(v -> Direction.Send.equals(v.getDirection()))
					.collect(Collectors.toSet())
					;
		}
		// WMS I/F 전문중 수신건만
		public static Collection<WmsDocs> getReceiptWmsDocs(){
			return Stream.of(WmsDocs.values())
					.filter(v -> Direction.Receipt.equals(v.getDirection()))
					.collect(Collectors.toSet())
					;
		}
	}
	
	/*
	 * 인터페이스 연관 테이블 정보
	 */
	public enum WmsSequences{
		  TableBase				("SEQ_WMS_INTERFACE_BASE"	, "WMS_INTERFACE_BASE")			// 송수신 내역
		, TableSend				("SEQ_WMS_INTERFACE_SEND"	, "WMS_INTERFACE_SEND")			// WMS_INTERFACE_SEND
		, TableReceipt			("SEQ_WMS_INTERFACE_RECEIPT", "WMS_INTERFACE_RECEIPT")		// 수신 내역
		, TableOrder			("SEQ_WMS_INTERFACE_ORDER"	, "WMS_INTERFACE_ORDER")		// 주문 송수신 내역
		, SequenceTransactionId	("SEQ_WMS_INTERFACE_BASE_TID")								// 송신시 transaction 채번
		; 

		// 시퀀스명 반환
		private String sequenceName;
		// 테이블명 반환
		private String tableName;
		// Constructor
		private WmsSequences(String sequenceName) {
			this.sequenceName	= sequenceName;
		}
		private WmsSequences(String sequenceName, String tableName) {
			this.sequenceName	= sequenceName;
			this.tableName 		= tableName;
		}
		public String getSequenceName() {
			return sequenceName;
		}
		public String getTableName() {
			return tableName;
		}
	}
	
	/*
	 * interface_base 테이블 송수신 상태
	 * 수신 : 대기 > 송수신완료
	 *        대기 > 요청실패(전문) or 응답실패(저장중)
	 * 송신 : 대기 > 송수신완료 or 요청실패
	 *        대기 > 송수신완료 or 응답실패
	 */
	public static enum BaseStatus{
		  Wait				("10", "대기")	
		, FinishTransaction	("20", "송수신완료")
		, FailRequest		("31", "요청실패")
		, FailResponse		("35", "응답실패")
		, Working			("40", "처리중")	
		, Finish			("50", "처리완료")	
		, Fail				("70", "처리실패")	
		, FailSome			("80", "처리일부실패")
		, NON				("90", "확인안됨")
		;
		private String code;
		private String message;
		private BaseStatus(String code, String message) {
			this.code = code;
			this.message = message;
		}
		public String getCode() {
			return code;
		}	
		public String getMessage() {
			return message;
		}
		public static BaseStatus findByName(String name) {
			return Arrays.stream(BaseStatus.values())
					.filter(v -> v.name().equals(name))
					.findAny()
					.orElse(null);
		}	
		public static BaseStatus findByCode(String code) {
			return Arrays.stream(BaseStatus.values())
					.filter(v -> v.getCode().equals(code))
					.findAny()
					.orElse(null);
		}		
	}
	
	/*
	 * interface_send 테이블 송신상태
	 */
	public static enum SendStatus{
		  Wait		("10"	, "대기")
		, Success	("20"	, "성공")
		, Fail		("30"	, "실패")
		;
		private String code;
		private String message;
		private SendStatus(String code, String message) {
			this.code = code;
			this.message = message;
		}
		public String getCode() {
			return code;
		}
		public String getMessage() {
			return message;
		}
		public static SendStatus findByName(String name) {
			return Arrays.stream(SendStatus.values())
					.filter(v -> v.name().equals(name))
					.findAny()
					.orElse(null);
		}
		public static SendStatus findByCode(String code) {
			return Arrays.stream(SendStatus.values())
					.filter(v -> v.getCode().equals(code))
					.findAny()
					.orElse(null);
		}
	}
	
	/*
	 * interface_receipt 테이블 수신상태
	 */
	public static enum ReceiptStatus{
		  Wait		("10"	, "대기")
		, Success	("20"	, "성공")
		, Fail		("30"	, "실패")
		;
		private String code;
		private String message;
		private ReceiptStatus(String code, String message) {
			this.code = code;
			this.message = message;
		}
		public String getCode() {
			return code;
		}
		public String getMessage() {
			return message;
		}
		public static ReceiptStatus findByName(String name) {
			return Arrays.stream(ReceiptStatus.values())
					.filter(v -> v.name().equals(name))
					.findAny()
					.orElse(null);
		}
		public static ReceiptStatus findByCode(String code) {
			return Arrays.stream(ReceiptStatus.values())
					.filter(v -> v.getCode().equals(code))
					.findAny()
					.orElse(null);
		}
		
	}
	
	/*
	 * interface_order 테이블 송수신상태
	 * 송신 : 대기 > 성공, 실패
	 *        응답실패
	 * 수신 : 대기 > 성공, 실패 
	 */
	public static enum OrderStatus{
		  Wait			("10"	, "대기")
		, Success		("20"	, "성공")
		, Fail			("30"	, "실패")
		, ResponseFail	("31"	, "응답실패")	// WMS에서 반환값으로 처리 (SUCCESS_YN)
		;
		private String code;
		private String message;
		private OrderStatus(String code, String message) {
			this.code = code;
			this.message = message;
		}
		public String getCode() {
			return code;
		}
		public String getMessage() {
			return message;
		}
		public static OrderStatus findByName(String name) {
			return Arrays.stream(OrderStatus.values())
					.filter(v -> v.name().equals(name))
					.findAny()
					.orElse(null);
		}
		public static OrderStatus findByCode(String code) {
			return Arrays.stream(OrderStatus.values())
					.filter(v -> v.getCode().equals(code))
					.findAny()
					.orElse(null);
		}
	}
	
	/* 응답시 처리결과 */
	public static enum ResponseResult{
		
		  Success	("Y")		// 전문, dsIn의 row 성공
		, Fail		("N")		// 전문의 실패
		, FailRow	("E")		// dsIn의 row 실패
		;
		private String code;
		private ResponseResult(String code) {
			this.code = code;
		}
		public String getCode() {
			return code;
		}
		public static ResponseResult findByCode(String code) {
			return Arrays.stream(ResponseResult.values())
					.filter(v -> v.getCode().equals(code))
					.findAny()
					.orElse(null);
		}		
	}

}
