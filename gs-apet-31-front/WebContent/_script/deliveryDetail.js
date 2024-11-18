/* 
 * 2021.05.31 사용안함으로 확인됨 
 */

/*constants*/
const NO_MEMBER_NO = 0;
const CLM_TP_20 = "20";

/*message*/
const FRONT_WEB_VIEW_MYPAGE_ORDER_DETAIL_STATCD_UPDATE_CONFIRM = "구매를 확정하시겠습니까?";
const FRONT_WEB_VIEW_MYPAGE_ORDER_DETAIL_STATCD_UPDATE_SUCCESS = "구매확정이 완료되었습니다.";
const FRONT_WEB_VIEW_CLAIM_REFUND_CLAIM_ING = "진행 중인 반품이 완료 되어야 반품신청을 할 수 있습니다.";
const FRONT_WEB_VIEW_CLAIM_EXCHANGE_CLAIM_ING = "진행 중인 교환이 완료 되어야 교환신청을 할 수 있습니다.";
const FRONT_WEB_VIEW_CLAIM_EXCHANGE_CLAIM_PSB = "교환이 불가능한 상품입니다.";
const FRONT_WEB_VIEW_CLAIM_REFUND_CLAIM_PSB = "반품이 불가능한 상품입니다.";
const FRONT_WEB_VIEW_CLAIM_CONFIRM_CLAIM_REFUND = "반품 접수를 철회하시겠습니까?";
const FRONT_WEB_VIEW_CLAIM_CONFIRM_CLAIM_EXCHANGE = "교환 접수를 철회하시겠습니까?";
const FRONT_WEB_VIEW_CLAIM_CLAIM_REFUND_SUCCESS = "반품 접수가 철회되었습니다.";
const FRONT_WEB_VIEW_CLAIM_CLAIM_EXCHANGE_SUCCESS = "주문 취소가 완료되었습니다.";
/*
 * 주문/배송 상세 버튼
 */
var orderDeliveryDetailBtn = {
	// 배송지 수정
	goAddressEdit : function(ordNo){
		var params = {
				ordNo : ordNo
			, callBackFnc : "orderDeliveryDetailBtn.reload"
		};

		pop.popupDeliveryAddressEdit(params);
	}
	// 상품평 등록 팝업
	, openGoodsComment : function(sGoodsId, sOrdNo , sOrdDtlSeq){
		var options = {
				url : "/mypage/service/popupGoodsCommentReg",
				params : {goodsId : sGoodsId, goodsEstmNo : '', ordNo : sOrdNo, ordDtlSeq : sOrdDtlSeq},
				width : 580,
				height: 598,
				callBackFnc : "orderDeliveryDetailBtn.reload",
				modal : true
			};
			pop.open("popupGoodsCommentReg", options);
	}
	// 재조회
	, reload : function(){
		location.reload();
	}
	// 옵션 변경 팝업
	, openOptionChange : function(ordNo, ordDtlSeq){
		var params = {
			ordNo : ordNo,
			ordDtlSeq : ordDtlSeq,
			mode : "order",
			callBackFnc : "orderDeliveryDetailBtn.cbOptionChange"
		};
		pop.orderOptionChange(params);
	}
	// 옵션 변경 CallBack
	, cbOptionChange : function(){
		location.reload();
	}
	// 구매확정
	, purchase : function(ordNo, ordDtlSeq){
		if(confirm(FRONT_WEB_VIEW_MYPAGE_ORDER_DETAIL_STATCD_UPDATE_CONFIRM)){
			var options = {
					   url : "mypage/order/purchaseProcess"
					, data : { ordNo : ordNo, ordDtlSeq : ordDtlSeq }
					, done : function(data){
						alert(FRONT_WEB_VIEW_MYPAGE_ORDER_DETAIL_STATCD_UPDATE_SUCCESS);
						orderDeliveryDetailBtn.reload();
					}
				};
			ajax.call(options);
		}
	}
	// 주문취소 신청
	, goCancelRequest : function(ordNo, ordDtlSeq){
		var action = "/mypage/order/indexCancelRequest";

		$("#delivery_detail_ord_no").val(ordNo);
		$("#delivery_detail_ord_dtl_seq").val(ordDtlSeq);
		$("#claim_request_list_form").attr("target", "_self");
		$("#claim_request_list_form").attr("method", "post");
		$("#claim_request_list_form").attr("action", action);
		$("#claim_request_list_form").submit();
	}
	// 교환 신청
	, goExchangeRequest : function(ordNo ,ordDtlSeq, clmIngYn, rtnPsbYn){
		
		if(clmIngYn === "Y"){
			alert(FRONT_WEB_VIEW_CLAIM_EXCHANGE_CLAIM_ING);
			return;
		}

		if(rtnPsbYn !== "Y"){
			alert(FRONT_WEB_VIEW_CLAIM_EXCHANGE_CLAIM_PSB);
			return;
		}
		
		var action = "/mypage/order/indexExchangeRequest";

		$("#delivery_detail_ord_no").val(ordNo);
		$("#delivery_detail_ord_dtl_seq").val(ordDtlSeq);
		$("#claim_request_list_form").attr("target", "_self");
		$("#claim_request_list_form").attr("method", "post");
		$("#claim_request_list_form").attr("action", action);
		$("#claim_request_list_form").submit();
	}
	// 반품 신청
	, goReturnRequest : function(ordNo, ordDtlSeq, rtnIngYn, rtnPsbYn){
		if(rtnIngYn === "Y"){
			alert(FRONT_WEB_VIEW_CLAIM_REFUND_CLAIM_ING);
			return;
		}

		if(rtnPsbYn !== "Y"){
			alert(FRONT_WEB_VIEW_CLAIM_REFUND_CLAIM_PSB);
			return;
		}

		var action = "/mypage/order/indexReturnRequest";

		$("#delivery_detail_ord_no").val(ordNo);
		$("#delivery_detail_ord_dtl_seq").val(ordDtlSeq);
		$("#claim_request_list_form").attr("target", "_self");
		$("#claim_request_list_form").attr("method", "post");
		$("#claim_request_list_form").attr("action", action);
		$("#claim_request_list_form").submit();
	}
	// 구매영수증 팝업
	, openPurchaseReceipt : function(ordNo){
		var params = {
				ordNo : ordNo
				}
		pop.purchaseReceipt(params);
	}
	// 현금영수증 팝업
	, openCashReceipt : function(ordNo){
		var params = {
				ordNo : ordNo
			}
		pop.cashReceipt(params);
	}
	// 신용카드 영수증
	, openCreditCard : function(ordNo){
		var params = {
				ordNo : ordNo
			}
		pop.creditCard(params);
	}
	, openClaimDetail : function(clmNo, clmDtlSeq){
		var params = { clmNo : clmNo
				, clmDtlSeq : clmDtlSeq
				, viewTitle : "상세정보"
		}
		pop.popupCancelRefundInfo(params);
	}
	, cancelClaim : function (clmNo, clmTpCd, memberNo){
		var url = "";
		if(memberNo !== NO_MEMBER_NO){
			url = "/mypage/refundExchangeCancelRequest";
		}else{
			url = "/mypage/noMemberRefundExchangeCancelRequest";
		}

		var confirmMsg = "";

		if(clmTpCd === CLM_TP_20){
			confirmMsg = FRONT_WEB_VIEW_CLAIM_CONFIRM_CLAIM_REFUND;
		}else{
			confirmMsg = FRONT_WEB_VIEW_CLAIM_CONFIRM_CLAIM_EXCHANGE;
		}

		if(confirm(confirmMsg)){
			var options = {
				   url : url
				, data : {clmNo : clmNo}
				, done : function(data){
					if(clmTpCd === CLM_TP_20){
						alert(FRONT_WEB_VIEW_CLAIM_CLAIM_REFUND_SUCCESS);
					}else{
						alert(FRONT_WEB_VIEW_CLAIM_CLAIM_EXCHANGE_SUCCESS);
					}
					orderDeliveryDetailBtn.reload();
				}
			};
			ajax.call(options);
		}
	}
};