<script type="text/javascript">
	/*  order에서 공통으로 사용되는 js 영역입니다. */	
	
var orderCommon = {
	DLVRC_STD_10 : "${frontConstants.DLVRC_STD_10 }"	//무료 배송
	,DLVRC_STD_20 : "${frontConstants.DLVRC_STD_20 }"	//배송비 추가
	,DLVRC_CDT_10 : "${frontConstants.DLVRC_CDT_10 }"	//개당 부여
	,DLVRC_CDT_20 : "${frontConstants.DLVRC_CDT_20 }"	//주문당 부여
	,DLVRC_CDT_STD_10 : "${frontConstants.DLVRC_CDT_STD_10 }"	//유료배송
	,DLVRC_CDT_STD_20 : "${frontConstants.DLVRC_CDT_STD_20 }"	//조건부 무료배송(구매가격)
	,DLVRC_CDT_STD_30 : "${frontConstants.DLVRC_CDT_STD_30 }"	//조건부 무료배송(구매수량)
};
	
var orderPopup = {
	
	<%--  targetTag : <div class='layers'></div> 의 경우 layers --%>
	<%--  url : load될 html 주소 --%>
	<%--  params : 전달 value --%>
	<%--  popId : <article class='popLayer a popReceipt' id='popReceipt'>html</article>의 id 값--%>
	<%-- callBackFnOpen : 팝업창 open 실행 함수(공백일 경우 실행 없음)--%>
	<%--  callBackFnClose : 팝업창 close 실행 함수(공백일 경우 실행 없음)--%>
	
	loadLayer : function(targetTag, url, params, popId, callBackFnOpen, callBackFnClose ) {
		
		waiting.start(); 	<%--  common.js--%>
		
		if (params == null) {
			params = {};
		}
	 	
		$("."+ targetTag).load(
			url,
			params,
			function(response, status, xhr) {
				waiting.stop();		<%-- common.js--%>
				
				if (status === "error") {
					if (xhr.status === 460) {												
						$("."+ targetTag).empty();						
					}
	
					ajax.error(xhr.status, xhr.responseText);  <%--  common.js--%>
				}else{
					
					ui.popLayer.open(popId, {
						ocb:function(){
							if (callBackFnOpen != null && callBackFnOpen !== "" && callBackFnOpen !== undefined) {
								eval(callBackFnOpen + "()");
							}
						},
						ccb:function(){
							if (callBackFnClose != null && callBackFnClose !== "" && callBackFnClose !== undefined) {
								eval(callBackFnClose + "()");
							}
							$("."+ targetTag).empty();
						}
					});
					
				}				
		}); 		
	}		
}


/*constants*/
const NO_MEMBER_NO = 0;
const CLM_TP_20 = "20";

/*message*/
const FRONT_WEB_VIEW_MYPAGE_ORDER_DETAIL_STATCD_UPDATE_CONFIRM = "구매를 확정하시겠습니까?";
const FRONT_WEB_VIEW_MYPAGE_ORDER_DETAIL_STATCD_UPDATE_SUCCESS = "구매확정이 완료되었습니다.";
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
	
	, plgYn : "${session.petLogUrl != null && session.petLogUrl != '' ? 'Y':'N'}"
	, deviceGb : '${view.deviceGb}'
	, openGoodsComment : function(sGoodsId, sOrdNo , sOrdDtlSeq, sGoodsEstmNo, sGoodsEstmTP){
		
		if(sGoodsEstmNo == ""){
			if(orderDeliveryDetailBtn.deviceGb == 'APP' && orderDeliveryDetailBtn.plgYn == 'Y') {					
				$("#acSelect").remove();
				
				var layerCommentHtml = "";					
				layerCommentHtml += "<div class=\"acSelect t2\" id=\"acSelect\">";
				layerCommentHtml += "	<input type=\"text\" class=\"acSelInput\" readonly />";
				layerCommentHtml += "	<div class=\"head \">";
				layerCommentHtml += "		<div class=\"con\">";
				layerCommentHtml += "			<div class=\"tit\">후기작성</div>";
				layerCommentHtml += "			<a href=\"javascript:;\" class=\"close\" onClick=\"ui.selAc.close(this)\"></a>";
				layerCommentHtml += "		</div>";
				layerCommentHtml += "	</div>";
				layerCommentHtml += "	<div class=\"con\">";
				layerCommentHtml += "		<ul class=\"selReview\">";
				layerCommentHtml += "			<li onClick=\"orderDeliveryDetailBtn.openGoodsCommentNext('"+ sGoodsId +"', '"+ sOrdNo +"', '"+sOrdDtlSeq +"', '"+sGoodsEstmNo+"', 'NOR');\" name='norBtn'>";
				layerCommentHtml += "			<img src=\"../../_images/my/icon-review-normal@2x.png\">";
				layerCommentHtml += "			<span>일반 후기 작성</span>";
				layerCommentHtml += "			</li>";
				layerCommentHtml += "			<li onClick=\"orderDeliveryDetailBtn.openGoodsCommentNext('"+ sGoodsId +"', '"+ sOrdNo +"', '"+sOrdDtlSeq +"', '"+sGoodsEstmNo+"', 'PLG');\" name='plgBtn'>";
				layerCommentHtml += "			<img src=\"../../_images/my/icon-review-log@2x.png\">";
				layerCommentHtml += "			<span><spring:message code='front.web.view.new.menu.log'/> 후기 작성</span>";
				layerCommentHtml += "			</li>";
				layerCommentHtml += "		</ul>";
				layerCommentHtml += "	</div>";
				layerCommentHtml += "</div>";
				
				$("#emptyLayers").append(layerCommentHtml);
				
				ui.selAc.open('#acSelect');
				
			}else{
				var norBtn = "NOR";
				orderDeliveryDetailBtn.openGoodsCommentNext(sGoodsId, sOrdNo , sOrdDtlSeq, sGoodsEstmNo, norBtn);
			}
		}else{			
			
			orderDeliveryDetailBtn.openGoodsCommentNext(sGoodsId, sOrdNo , sOrdDtlSeq, sGoodsEstmNo, sGoodsEstmTP);
		}	
			
	}
	, openGoodsCommentNext : function(sGoodsId, sOrdNo , sOrdDtlSeq, sGoodsEstmNo, sGoodsEstmTp){	
		
		//수정
		if(sGoodsEstmNo != ""){					
			if( sGoodsEstmTp == "PLG" && orderDeliveryDetailBtn.deviceGb != "APP"){					
				ui.alert('펫로그 후기는 <br>모바일 앱에서 수정 가능합니다.');
				return false;					
			}
			
		}
		
		var url = "/mypage/commentWriteView"
		var html = '';
		html += '<input type="hidden" name="goodsId" value="'+ sGoodsId +'">';
		html += '<input type="hidden" name="goodsEstmTp" value="'+ sGoodsEstmTp +'">';
		html += '<input type="hidden" name="ordNo" value="'+ sOrdNo +'">';
		html += '<input type="hidden" name="ordDtlSeq" value="'+ sOrdDtlSeq +'">';
		html += '<input type="hidden" name="goodsEstmNo" value="'+ sGoodsEstmNo +'">';
		var goform = $("<form>",
			{ method : "post",
			action : url,
			target : "_self",
			html : html
			}).appendTo("body");
		goform.submit();
	}

	// 재조회 */
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
	/* , purchase : function(ordNo, ordDtlSeq){
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
	} */
	, purchase : function(ordNo, ordDtlSeq, ordDtlStatCd){
		
		if(ordDtlStatCd == "${frontConstants.ORD_DTL_STAT_150}" ){
						
			ui.confirm('<div class="info-txt t3"><ul><li>구매확정 이후에는 반품/교환이 불가하므로 상품을 배송 받으신 후에 구매확정을 해주세요.</li><li>상품을 배송받지 않은 상태에서 구매확정을 하신 경우 상품 미수령에 대한 책임은 구매자에게 있습니다.</li></ul></div>',{ // 컨펌 창 띄우기	
				//tit:"상품이 아직 배송중입니다.<br>구매확정을 진행하시겠습니까?",
				tit:"아직 배송중인 상품이 있어요<br>구매를 확정할까요?",						
				ycb:function(){
					orderDeliveryDetailBtn.purchaseNext(ordNo, ordDtlSeq);
				},					
				ybt:'예',
				nbt:'아니요'	
			});
		}else{
			orderDeliveryDetailBtn.purchaseNext(ordNo, ordDtlSeq);
		}				
	}
	, purchaseNext : function(ordNo, ordDtlSeq){
		var action = "/mypage/order/indexPurchaseRequest";				
		
		$("#delivery_detail_ord_no").val(ordNo);
		$("#delivery_detail_ord_dtl_seq").val(ordDtlSeq);
		$("#claim_request_list_form").attr("target", "_self");
		$("#claim_request_list_form").attr("method", "post");
		$("#claim_request_list_form").attr("action", action);
		$("#claim_request_list_form").submit();
	}
	// 주문취소 신청
	, goCancelRequest : function(ordNo, ordDtlSeq){
//		var action = "/mypage/order/indexCancelRequest";

// 		$("#delivery_detail_ord_no").val(ordNo);
// 		$("#delivery_detail_ord_dtl_seq").val(ordDtlSeq);
// 		$("#claim_request_list_form").attr("target", "_self");
// 		$("#claim_request_list_form").attr("method", "post");
// 		$("#claim_request_list_form").attr("action", action);
	
// 		$("#claim_request_list_form").submit();

		var action = "/mypage/order/indexCancelRequest";				
		var inputs = "<input type=\"hidden\" name=\"ordNo\" value=\""+ordNo+"\"/><input type=\"hidden\" name=\"ordDtlSeq\" value=\""+ordDtlSeq+"\"/>";
		jQuery("<form action=\"/mypage/order/indexCancelRequest\" method=\"get\">"+inputs+"</form>").appendTo('body').submit();
	}
	// 주문취소 페이지 
	, goCancelAllRequest : function(ordNo){
		
		if(ordNo == null || ordNo == undefined || ordNo == ""){			
			ui.alert("주문번호 오류입니다.",{					
				ybt:'확인'	
			});
			return;
		}else{	
		
			var url = "<spring:url value='/mypage/insertClaimCancelExchangeRefund' />";
			
			$("#delivery_detail_ord_no").val(ordNo);		
			$("#clm_tp_cd").val("${frontConstants.CLM_TP_10}");
			$("#clm_rsn_cd").val("${frontConstants.CLM_RSN_110}");
			
			
			ui.confirm('<div class="info-txt t3"><ul><li>입금대기 중에는 <span>전체 취소만 할 수 있어요. </li><li>일부 상품만 구매를 원하시는 경우, 취소 후 다시 주문해주세요</li></ul></div>',{ // 컨펌 창 띄우기
				tit:"주문을 취소할까요?",
				ycb:function(){
					var options = {
						url : url
						, data : $("#claim_request_list_form").serializeArray()
						, done : function(data){					
							if(data != null){
								ui.toast('주문 취소가 완료되었어요.',{
									sec:3000,
									ccb:function(){  // 토스트 닫히면 실행할 함수
										location.href="/mypage/order/indexDeliveryList";
									}
								});
								
							}
						}
					};		
					
					ajax.call(options);
				},					
				ybt:'예',
				nbt:'아니요'	
			});	
		
		}			
		
	}	
	// 교환 신청
	, goExchangeRequest : function(ordNo ,ordDtlSeq, clmIngYn, rtnIngYn){
		
		if(clmIngYn === "Y"){
			if(rtnIngYn == "Y"){
				ui.alert("<spring:message code ='front.web.view.claim.refund.claim.ing.refund'/>" ,{
					ybt:'확인'
				});
			}else{
				ui.alert("<spring:message code ='front.web.view.claim.refund.claim.ing.exchange'/>" ,{
					ybt:'확인'
				});
			}
			return;
		}
		
// 		var action = "/mypage/order/indexExchangeRequest";

// 		$("#delivery_detail_ord_no").val(ordNo);
// 		$("#delivery_detail_ord_dtl_seq").val(ordDtlSeq);
// 		$("#claim_request_list_form").attr("target", "_self");
// 		$("#claim_request_list_form").attr("method", "post");
// 		$("#claim_request_list_form").attr("action", action);
// 		$("#claim_request_list_form").submit();

		var action = "/mypage/order/indexExchangeRequest";				
		var inputs = "<input type=\"hidden\" name=\"ordNo\" value=\""+ordNo+"\"/><input type=\"hidden\" name=\"ordDtlSeq\" value=\""+ordDtlSeq+"\"/>";
		jQuery("<form action=\"/mypage/order/indexExchangeRequest\" method=\"get\">"+inputs+"</form>").appendTo('body').submit();
	}
	// 반품 신청
	, goReturnRequest : function(ordNo, ordDtlSeq, clmIngYn, rtnIngYn, rtnPsbYn){
		if(clmIngYn === "Y"){
			if(rtnIngYn == "Y"){
				ui.alert("<spring:message code ='front.web.view.claim.refund.claim.ing.refund'/>" ,{
					ybt:'확인'
				});
			}else{
				ui.alert("<spring:message code ='front.web.view.claim.refund.claim.ing.exchange'/>" ,{
					ybt:'확인'
				});
			}
			return;
		}

		if(rtnPsbYn !== "Y"){
			ui.alert(FRONT_WEB_VIEW_CLAIM_REFUND_CLAIM_PSB, {					
				ybt:'확인'
			});
			return;
		}

//		var action = "/mypage/order/indexReturnRequest";

// 		$("#delivery_detail_ord_no").val(ordNo);
// 		$("#delivery_detail_ord_dtl_seq").val(ordDtlSeq);
// 		$("#claim_request_list_form").attr("target", "_self");
// 		$("#claim_request_list_form").attr("method", "post");
// 		$("#claim_request_list_form").attr("action", action);
// 		$("#claim_request_list_form").submit();
		var action = "/mypage/order/indexReturnRequest";				
		var inputs = "<input type=\"hidden\" name=\"ordNo\" value=\""+ordNo+"\"/><input type=\"hidden\" name=\"ordDtlSeq\" value=\""+ordDtlSeq+"\"/>";
		jQuery("<form action=\"/mypage/order/indexReturnRequest\" method=\"get\">"+inputs+"</form>").appendTo('body').submit();
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
	, openCreditCard : function(tid){
		if("${view.deviceGb eq frontConstants.DEVICE_GB_30}"=="true") {
			/* var parameters = {
				"func" : "onOrderPage",
				"url" : "https://npg.nicepay.co.kr/issue/IssueLoader.do?TID="+tid+"&type=0",
				"title" : "카드영수증"
			};
			if("${view.os eq frontConstants.DEVICE_TYPE_10}"=="true") {
				// Android
				window.AppJSInterface.onOrderPage(JSON.stringify(parameters));
			} else {
				// iOS(Dictionary)
				window.webkit.messageHandlers.AppJSInterface.postMessage(parameters);
			} */
			toNativeData.func = "onTitleBarHidden";
			toNativeData.hidden = "N";
			toNativeData.title = "카드영수증";
			// 1. 팝업열기
			var status = "toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=yes,width=420,height=540";
			var url = "https://npg.nicepay.co.kr/issue/IssueLoader.do?TID="+tid+"&type=0";
			 //type 값 세팅 :: 매출전표: 0, 현금영수증: 1
			window.open(url,"popupIssue",status);
			
			toNative(toNativeData);
			
		} else {
			// 1. 팝업열기
			var status = "toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=yes,width=420,height=540";
			var url = "https://npg.nicepay.co.kr/issue/IssueLoader.do?TID="+tid+"&type=0";
			 //type 값 세팅 :: 매출전표: 0, 현금영수증: 1
			window.open(url,"popupIssue",status);
		}
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
	, openCashReceiptRequest: function(ordNo, payAmt, goodsNm){
		var popParam = {
			ordNo : ordNo,
			payAmt : payAmt,
			goodsNm : goodsNm
		}		
		var popUrl = "/mypage/order/popupCashReceiptRequest";
		
		orderPopup.loadLayer("layers", popUrl, popParam, "popReceipt");		
		
	}
	
	,goOrderClaimDetail : function(clmNo, clmTpCd){	
		if(clmNo == null || clmNo == undefined || clmNo == ""){			
			ui.alert("클레임번호 오류입니다.",{					
				ybt:'확인'	
			});
			return;
		}else{		
			
			var action = "/mypage/order/indexClaimDetail";				
			var inputs = "<input type=\"hidden\" name=\"clmNo\" value=\""+clmNo+"\"/>";
			if(clmTpCd != "${FrontWebConstants.CLM_TP_10}" ){
				inputs += "<input type=\"hidden\" name=\"clmTpCd\" value=\""+clmTpCd+"\"/>";
			}				
			jQuery("<form action=\"/mypage/order/indexClaimDetail\" method=\"get\">"+inputs+"</form>").appendTo('body').submit();
		}
	}
};

</script>