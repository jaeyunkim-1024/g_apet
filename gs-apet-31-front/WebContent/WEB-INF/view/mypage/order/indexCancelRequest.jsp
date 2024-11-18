	<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
	<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
	<%@ page import="front.web.config.constants.FrontWebConstants" %> 
	<%@ page import="framework.common.constants.CommonConstants" %>
	<%@ page import="framework.common.enums.ImageGoodsSize" %>
	
	<c:set var="prcAreaDisplayStyle" value="${not empty oldStdOrdNo and oldStdOrdNo < order.ordNo ? '' : 'style=\"display:none;\"' }" />
	
	<c:choose>
		<c:when test="${view.deviceGb eq frontConstants.DEVICE_GB_10 }">
			<c:set var="titleName" value="common" />
		</c:when>						
		<c:otherwise>
			<c:set var="titleName" value="mypage_mo_nomenubar" />
		</c:otherwise>					
	</c:choose>
	<tiles:insertDefinition name="${titleName }">	
	<tiles:putAttribute name="script.include" value="script.order"/>
	<tiles:putAttribute name="script.inline">
	<script type="text/javascript">
		
	var claimRefundVO;
		
		$(document).ready(function(){
			$("#header_pc").removeClass("mode0");
			$("#header_pc").addClass("mode16");
			$("#header_pc").attr("data-header", "set22");
			$("#header_pc").addClass("logHeaderAc");
			$(".mo-heade-tit .tit").html("<spring:message code='front.web.view.order.title.cancelrequest' />");		 
			
			$(".mo-header-backNtn").removeAttr("onclick");
			$(".mo-header-backNtn").bind("click", function(){			
				if("${mngb}" == "OL"){
					$("#claim_request_list_form").attr("action", "/mypage/order/indexDeliveryList");
					$("#claim_request_list_form").submit();
				}else if("${mngb}" == "OD"){
					$("#claim_request_list_form").attr("action", "/mypage/order/indexDeliveryDetail");
					$("#claim_request_list_form").attr("method", "get");
					var ordNo = $("#ordNo").val();			
					var hidhtml = "<input type=\"hidden\" name=\"ordNo\"  value="+ ordNo +" />";
					$("#claim_request_list_form").append(hidhtml);
					$("#claim_request_list_form").submit();
					storageHist.goBack();
				}else{
					storageHist.goBack();
				}			
			});
			
			//클레임사유 500자 제한
			$('textarea[name=clmRsnContent]').on('propertychange keyup input change paste ', function(){
				if($(this).val().length >= 500){
					$(this).val($(this).val().substring(0,500));
					ui.toast("<spring:message code='front.web.view.common.toast.available.numberofcharacter.maximum' />");
				}
			});
		});	
	
		$(document).ready(function(){ 
			claimRefundVO = new Object();
			
			//하단 GNB 안보이게
			/* 
			var deviceGb = "${view.deviceGb}"			
			if(deviceGb != "PC"){
				//$(".mode0").remove();
				$(".menubar").remove();
				//$("#footer").remove();
			}else{
				//$(".mode7").remove();
			}
			 */
			
		}); // End Ready
		
		$(document).off("click", ".uispiner .bt");
		$(document).off("click", ".uispiner .plus");
		$(document).off("click", ".uispiner .bt");
		$(document).off("click", ".uispiner .minus");
		$(document).on("click",".uispiner .plus",function(e){
			e.preventDefault();
			var $qtyObj = $(this).siblings(".amt");
			var cnt = $qtyObj[0].value*1;
			cnt += 1;
			var originSaleAmt = $qtyObj.data("saleamt");
			$(this).parent().parent().siblings().find('.name .price .p').text(fnComma(cnt*originSaleAmt));
		});
		
		$(document).on("click",".uispiner .minus",function(e){
			e.preventDefault();
			var $qtyObj = $(this).siblings(".amt");
			var cnt = $qtyObj[0].value*1;
			cnt -= 1;
			var originSaleAmt = $qtyObj.data("saleamt");
			$(this).parent().parent().siblings().find('.name .price .p').text(fnComma(cnt*originSaleAmt));
		});
	
		$(function() {
			$("input:checkbox[name=checkAgree]").prop("checked", false);
			//결제금액 계산 및 계좌입력 초기화 
			initCalculation();
			$("#clmRsnCd").val("");
			$("#payAmt").val(0);
	
			dialog.create("order_payment_pay_dialog" , {width: 850, height:637, modal:true});
			
			$("#order_payment_pay_dialog").prev(".ui-dialog-titlebar").children("button").click(function(){
				inipay.close("B");
			});
			
			$("input[name='radioClmRsnCd']:radio").change(function (){
				$("#clmRsnCd").val($(this).val());
				getClaimRefundExcpect();			
			});
			
			$(".uispiner .bt").click(function(){					
				if($(this).parents("div.untcart").find("input[name='arrListCheckCancel']").is(":checked") == true){			
					$("input[name='radioClmRsnCd']").prop("checked", false);
					$("#clmRsnCd").val("");
					initCalculation();
				}	
			});
			
			/* if($(".untcart").length == 1){
				$(".oder-cancel").eq(0).find("input[name='arrListCheckCancel']").prop("checked", true);
			} */
			
			if($("input[name='arrListCheckCancel']").length > 0){
				$("input[name='arrListCheckCancel']").click(function(){
					$("input[name='radioClmRsnCd']").prop("checked", false);
					$("#clmRsnCd").val("");
					initCalculation();
				});
			}
			
			$("#ooaNm, #bankCd, #acctNo").change(function(){
				$("#btnAccountChk").find("a").remove();			
				if($("#ooaNm").val()=="" || $("#bankCd").val()=="" || $("#acctNo").val()=="" ){
					$("#btnAccountChk").append("<a href=\"#\" data-content=\"${session.mbrNo }\" data-url=\"/mypage/order/getAccountName\" class=\"btn md\" disabled><spring:message code='front.web.view.order.prove.account.btn' /></a>");
				}else{
					$("#btnAccountChk").append("<a href=\"#\" onclick=\"AuthBank();return false;\" data-content=\"${session.mbrNo }\" data-url=\"/mypage/order/getAccountName\" class=\"btn md\"><spring:message code='front.web.view.order.prove.account.btn' /></a>");	
				}			
			});
		
		});
		
		//초기값 설정
		function initCalculation(){
			//$("#paymentAmt").html("<strong>0</strong>원");  
			//$("#goodsAddAmt").html("<strong>0</strong>원");
			$("#goodsAmt").html("<spring:message code='front.web.view.order.stting.default.value.won' />") ;
			$("#orgDlvrcAmt").html("<spring:message code='front.web.view.order.stting.default.value.won' />");
			$("#cpDcAmt").html("<spring:message code='front.web.view.order.stting.default.value.won' />");
			$("#mpAddUsePnt").html("<spring:message code='front.web.view.order.stting.default.value.won' />");
			$("#allRefundPay .savePoint").html("0원");
			$("#mainRefundPay .savePoint").html("0원");
			$("#gsRefundPay .savePoint").html("0P");
			$("#mpRefundPay .savePoint").html("0C");
			$("#miRefundPay .savePoint").html("0원");
			$("#minusPay .savePoint").html("0원");
			//$("#clmDlvrcAmt").html(0);
			//$("#refundAmt").html("");		
// 			$("#clmDlvrcAmtli").removeClass("color");
// 			$("#clmDlvrcAmtPre").text("");
			$("#clmDlvrcAmt").html("<spring:message code='front.web.view.order.stting.default.value.won' />");
			
			$("#addAmt").remove();		
			$("#txtDisabled").remove();
			$("#btnCancelApply").remove();
			$(".btnSet").append("<a href=\"#\" data-content=\"\" data-url=\"/mypage/insertClaimCancelExchangeRefund\" onclick=\"insertCancelList();return false;\" class=\"btn lg a\" id=\"btnCancelApply\"><spring:message code='front.web.view.order.title.cancelrequest' /></a>");
			
		}
		
		function setClmQty() {		
			var arrClmQty = $("input[name=arrClmQty]");			
			for(var i=0; i <arrClmQty.length; i++){			
				$("#arrClmQty"+i).val(parseInt($("#clmQty"+i).val()));
				
				if($("#listCheckCancel"+i).is(":checked") == true){					
					$("#arrClmQty"+i).prop("disabled", false);
					$("#ordDtlSeq"+i).prop("disabled", false);				
				}else{
					$("#arrClmQty"+i).prop("disabled", true);
					$("#ordDtlSeq"+i).prop("disabled", true);
				}
			}		
		}
		
		/*
	    * 환불예상금액계산
	    */
		function getClaimRefundExcpect() {		
			$("#txtDisabled").remove();	
			$("#btnCancelApply").remove();
			$(".btnSet").append("<a href=\"javascript:void(0);\" data-content=\"\" data-url=\"/mypage/insertClaimCancelExchangeRefund\" onclick=\"insertCancelList();return false;\" class=\"btn lg a\" id=\"btnCancelApply\" ><spring:message code='front.web.view.order.title.cancelrequest' /></a>");
			
			if (!clmQtyCheck()) {
				
				if($("input[name='arrListCheckCancel']").length > 0){			
					ui.alert("<spring:message code='front.web.view.order.chose.cancelrequest.products' />",{					
						ybt:'<spring:message code='front.web.view.common.msg.confirmation' />'	
					});
					$("input[name='radioClmRsnCd']").prop("checked", false);
					$("#clmRsnCd").val("");
				}
				
				return;
			} else if (!clmRsnCdCheck()) {			
				return;
			}		
			
			setClmQty();
				
			var options = {
					url : "<spring:url value='/mypage/order/getClaimRefundExcpect' />"
					, data : $("#cancel_request_list_form").serializeArray()
					, done : function(data){
						claimRefundVO = data.claimRefundVO;
						seRefundArea();
					}
			};
				
			ajax.call(options);
		}
	
		function seRefundArea() {
			var paymentAmt = 0;
			var addAmt = 0;
			var totalAmt = 0;
			$("#refundAmt").html("");
			var refundAmtHtml = "";
	
			paymentAmt += parseInt(claimRefundVO.goodsAmt);
			$("#goodsAmt").html(fnComma(claimRefundVO.goodsAmt)+"<spring:message code='front.web.view.common.moneyUnit.title' />");
			
			if (claimRefundVO.refundDlvrAmt != undefined) {
				paymentAmt += parseInt(claimRefundVO.refundDlvrAmt);
				// $("#orgDlvrcAmt").html(fnComma(claimRefundVO.orgDlvrcAmt-claimRefundVO.addOrgDlvrcAmt)+"<spring:message code='front.web.view.common.moneyUnit.title' />");
				$("#orgDlvrcAmt").html(fnComma(claimRefundVO.refundDlvrAmt)+"<spring:message code='front.web.view.common.moneyUnit.title' />");
			}
			
			if ((claimRefundVO.cpDcAmt != undefined && claimRefundVO.cpDcAmt > 0) || (claimRefundVO.cartCpDcAmt != undefined && claimRefundVO.cartCpDcAmt > 0)) {
				
				//제품쿠폰+장바구니쿠폰
				var cpDcAmt = 0;
				if (claimRefundVO.cpDcAmt != undefined && claimRefundVO.cpDcAmt > 0) {
					cpDcAmt += claimRefundVO.cpDcAmt
				}
				
				if (claimRefundVO.cartCpDcAmt != undefined && claimRefundVO.cartCpDcAmt > 0) {
					cpDcAmt += claimRefundVO.cartCpDcAmt
				}
				
				paymentAmt -= parseInt(claimRefundVO.cpDcAmt);
				$("#cpDcAmt").html("-"+ fnComma(cpDcAmt)+"<spring:message code='front.web.view.common.moneyUnit.title' />");
			}		
			
			//$("#paymentAmt").html("<strong>"+fnComma(paymentAmt)+"</strong><spring:message code='front.web.view.common.moneyUnit.title' />") ;  
	
			if (claimRefundVO.refundDlvrAmt != undefined && claimRefundVO.refundDlvrAmt < 0) {
				addAmt += parseInt(Math.abs(claimRefundVO.refundDlvrAmt));
			}
			
			if ((claimRefundVO.clmDlvrcAmt != undefined ) || (claimRefundVO.reduceDlvrcAmt != undefined )) {
				var clmDlvrcAmt = claimRefundVO.clmDlvrcAmt+claimRefundVO.reduceDlvrcAmt+claimRefundVO.addReduceDlvrcAmt;
				clmDlvrcAmt *= -1;
				
// 				$("#clmDlvrcAmtli").addClass("color");
// 				if(clmDlvrcAmt < 0){
// 					$("#clmDlvrcAmtPre").text("-");
// 				} else {
// 					$("#clmDlvrcAmtPre").text("");
// 				}
				
				$("#clmDlvrcAmt").html(fnComma(clmDlvrcAmt)+'<spring:message code='front.web.view.common.moneyUnit.title' />');
			} 
			
			var gsPoint = 0;
			var mpPoint = 0;
			var mainRefundPay;
			var minusRefund = 0;
			if(claimRefundVO.meansList!=null){
				for(var i=0; i<claimRefundVO.meansList.length; i++){
					if(claimRefundVO.meansList[i].payMeansCd =='${frontConstants.PAY_MEANS_81}'){
						mpPoint = claimRefundVO.meansList[i].refundAmt;
					}else if(claimRefundVO.meansList[i].payMeansCd=='${frontConstants.PAY_MEANS_80}'){
						gsPoint = claimRefundVO.meansList[i].refundAmt;
					}else{
						mainRefundPay = claimRefundVO.meansList[i];
					}
				}
				
				minusRefund = claimRefundVO.totAmt - ((mainRefundPay ?  mainRefundPay.refundAmt : 0 ) + claimRefundVO.mpRefundUsePnt + gsPoint);
			}
			
			var allRefundPay = claimRefundVO.totAmt;

			/* MP 포인트 재계산 사용여부 체크 - N Start */
			if(claimRefundVO.mpReCalculateYn == "N"){
				//이미 빼줌				
			/* MP 포인트 재계산 사용여부 체크 - N End */
			}else{
				if(claimRefundVO.mpRefundAddUsePnt != 0){
					allRefundPay = allRefundPay - claimRefundVO.mpRefundAddUsePnt;
				}
			}
			
			
			$("#allRefundPay").find(".savePoint").html(fnComma(allRefundPay)+"원");
					
			if(mainRefundPay && mainRefundPay.refundAmt > 0){
				$("#mainRefundPay").show();
				$("#mainRefundPay").find("span").eq(0).html(mainRefundPay.meansNm+" 환불");
				$("#mainRefundPay").find(".savePoint").html(fnComma(mainRefundPay.refundAmt)+"원");
			}else{
				$("#mainRefundPay").hide();
			}
			
			if(gsPoint != 0){
				$("#gsRefundPay").show();
				$("#gsRefundPay").find(".savePoint").html(fnComma(gsPoint)+"P");
			}else{
				$("#gsRefundPay").hide();
			}
			
			if(claimRefundVO.mpRefundUsePnt != 0){
				$("#mpRefundPay").show();
				$("#mpRefundPay").find(".savePoint").html(fnComma(claimRefundVO.mpRefundUsePnt)+"C");
			}else{
				$("#mpRefundPay").hide();
			}
			
			if(claimRefundVO.mpRefundAddUsePnt != 0){
				$("#mpAddUsePnt").closest("li").show();
				$("#mpAddUsePnt").html("-" + fnComma(claimRefundVO.mpRefundAddUsePnt)+"원");
			}else{
				$("#mpAddUsePnt").closest("li").hide();
			}
			
			// 마이너스 환불이 일어나서 결제했던 금액을 다시 되돌려줘야 할 때	
			if(minusRefund > 0){
				$("#miRefundPay").show();
				$("#miRefundPay").find(".savePoint").html(fnComma(minusRefund)+"원");
			}else{
				$("#miRefundPay").hide();
			}
			
			if(Number(claimRefundVO.totAmt) < 0){
				$("#minusPay").find(".savePoint").html(fnComma(Number(claimRefundVO.totAmt))+"원");
				$("#minusPay").show();
			}else{
				$("#minusPay").hide();
			}

				
			// 총 합계 금액이 0보다 작거나 마이너스 환불이 일어나서 결제했던 금액을 다시 되돌려줘야 할 때	
			if(Number(claimRefundVO.totAmt) < 0 || minusRefund > 0){
				if($("#miRefundPay").find(".savePoint").text() == '0원'){
					var disableHtml = "<p class=\"info-t2\" id=\"txtDisabled\"><spring:message code='front.web.view.order.minus.return.price.not.available.apply.call.customer.service' /></p>";
				}else{
					var disableHtml = "<p class=\"info-t2\" id=\"txtDisabled\">추가 결제금액이 있을 경우, 마이페이지에서 신청이 불가합니다. 고객센터로 문의해주세요.</p>";
				}
				$(".price-area").append(disableHtml);
				
				$("#btnCancelApply").remove();
				$(".btnSet").append("<a href=\"#\" class=\"btn lg a\" disabled id=\"btnCancelApply\"  onclick=\"negative();return false;\"><spring:message code='front.web.view.order.title.cancelrequest' /></a>");			
				
			}
		}
	     
		//신청하기 button
		function insertCancelList(){
			if (!clmQtyCheck()) {
				
				if($("input[name='arrListCheckCancel']").length > 0){			
					ui.alert("<spring:message code='front.web.view.order.chose.cancelrequest.products' />",{					
						ybt:'<spring:message code='front.web.view.common.msg.confirmation' />'	
					});			
				}else{
					ui.alert('<spring:message code="front.web.view.claim_cancel.msg.clmQty" />',{					
						ybt:'<spring:message code='front.web.view.common.msg.confirmation' />'	
					});		
				}		
				return;
			} else if (!clmRsnCdCheck()) {
				
				ui.alert('<spring:message code="front.web.view.claim_cancel.msg.clmRsnCd" />',{					
					ybt:'<spring:message code='front.web.view.common.msg.confirmation' />'	
				});			
				
				$("#clmRsnCd").focus();
				return;
			} else if (!payMeansCdCheck()) {
	    		return;
	    	} else {
	    		//취소불가능한 상품이 포함됐는지 체크 == 취소 도중 ord_dtl_stat_cd 가 변경된 경우 
	    		var arrClmQty = $("input[name=arrClmQty]");
	    		var checkedNos=[]; //0,1,2
				var checkedOrdDtlSeqs=[];
				var checkedCnt = 0 ;
				var result = true;
				for(var i=0; i <arrClmQty.length; i++){
					if($("#listCheckCancel"+i).is(":checked") == true){
						checkedOrdDtlSeqs[checkedCnt] = $("#ordDtlSeq"+i).val();
						checkedNos[checkedCnt] = i; //el에 붙은 no
						checkedCnt++;
					}
				}
				var options = {
					url : "<spring:url value='/mypage/order/checkOrderCurrentStatus'/>"
					, async : false
					, data : {
						ordNo : $('#ordNo').val()
					}
					, done : function(data){
						 var orderDetailList = data.order.orderDetailListVO;
						 var changedSeqs = [];
						 var cnt = 0;
						 for(var j=0; j<checkedOrdDtlSeqs.length; j++){
							 for(var i=0; i<orderDetailList.length; i++){
								 if(checkedOrdDtlSeqs[j] == orderDetailList[i].ordDtlSeq){
									 if(orderDetailList[i].ordDtlStatCd != "${FrontWebConstants.ORD_DTL_STAT_110}"
											 && orderDetailList[i].ordDtlStatCd != "${FrontWebConstants.ORD_DTL_STAT_120}"
											 	&& orderDetailList[i].ordDtlStatCd != "${FrontWebConstants.ORD_DTL_STAT_130}"){
										 changedSeqs[cnt] = checkedNos[j];
										 cnt++;
										 result = false;
									 }
								 }
							 }
						 }
						 if(!result){
							 ui.alert('<spring:message code="front.web.view.claim_cancel.msg.ordDtlStat" />',{
								ycb: function(){
									for(var i=0; i <changedSeqs.length; i++){
										var seq = changedSeqs[i];
										$("#listCheckCancel"+seq).prop("disabled", true);
										$("#listCheckCancel"+seq).prop("checked", false);
										$("#arrClmQty"+seq).prop("disabled", true);
										$("#ordDtlSeq"+seq).prop("disabled", true);
									}
									initCalculation();
									$("input[name='radioClmRsnCd']").prop("checked", false);
									$("#clmRsnCd").val("");
								},
			  					ybt:'<spring:message code='front.web.view.common.msg.confirmation' />'	
			  				});
						 }
					}
				};
				ajax.call(options);
				if(!result){
					return;
				}
	    	}	
	
			/* var exAppChecked = $("input:checkbox[name=checkAgree]").is(":checked");
			if(exAppChecked){               //취소안내사항 확인여부 여부
				if(confirm('<spring:message code="front.web.view.claim.confirm.cancel_accept" />')){    
					if (claimRefundVO.totAmt < 0) {
						$("#payAmt").val(Math.abs(claimRefundVO.totAmt));
					} else {
						$("#payAmt").val(0);
					}
					
					setClmQty();
					inipay.open();
				}
			} else {
				alert('<spring:message code="front.web.view.claim.msg.cancel_info.check" />'); 
				$("input:checkbox[name=checkAgree]").focus();
				return;
			} */
				
			
			ui.confirm('<spring:message code="front.web.view.claim.confirm.cancel_accept" />',{ // 컨펌 창 띄우기
				ycb:function(){
					
					if (claimRefundVO.totAmt < 0) {
						$("#payAmt").val(Math.abs(claimRefundVO.totAmt));
					} else {
						$("#payAmt").val(0);
					}
					
					/* setClmQty();
					inipay.open(); */
					insertAccess();
				},
				ybt:'<spring:message code='front.web.view.common.msg.confirmation' />',
				nbt:'<spring:message code='front.web.view.common.msg.cancel' />'	
			});		
			
		}
	
		function insertAccess(){
			var url = "<spring:url value='/mypage/insertClaimCancelExchangeRefund' />";
	
			/* if ("${session.mbrNo}" == "${FrontWebConstants.NO_MEMBER_NO}") {
				url = "<spring:url value='/mypage/noMemberInsertClaimCancelExchangeRefund' />";
			} */
			
			$("#bankCd option").not(":selected").attr("disabled", "");
			
			var options = {
					url : url
					, data : $("#cancel_request_list_form").serializeArray()
					, done : function(data){					
						if(data != null){
							jQuery("<form action=\"/mypage/order/indexCancelCompletion\" method=\"get\"><input type=\"hidden\" name=\"clmNo\" value=\""+data.clmNo+"\" /></form>").appendTo('body').submit();
						}
					}
			};		
			
			ajax.call(options);
		}
		
		function clmQtyCheck() {
			var clmQty = document.getElementsByName('clmQty');		
			if (clmQty.length > 0) {
				var totClmQty = 0;
				for(var i=0; i <clmQty.length; i++){
					
					if($("#listCheckCancel"+i).is(":checked") == true){					
						totClmQty += parseInt($("#clmQty"+i).val());
					}				
				}			
				
				if (totClmQty ==0) {
					return false;
				}
			}		
	
	  		return true
		}
	  
		function clmRsnCdCheck() {
			if($("#clmRsnCd").val() == ""){
				return false;
			} 
	    	
	  		return true;
	  	}
		
		function clmRsnContent() {
			if($("#clmRsnContent").val() == ""){
				return false;
			} 
	    	
	  		return true;
	  	}
	  
	    // 결제 수단 코드 체크
	    function payMeansCdCheck() {
			var payMeansCd = $("#cancel_request_list_form #payMeansCd").val();
	    	//결제 수단코드 가상계좌 : "30", 무통장 : "40" 일 경우
	  		if(payMeansCd == "${FrontWebConstants.PAY_MEANS_30}" || payMeansCd == "${FrontWebConstants.PAY_MEANS_40}"){
	  			if($("#ooaNm").val()==""){  				
	  				ui.alert('<spring:message code="front.web.view.claim.msg.refund_ooaNm" />',{					
	  					ybt:'<spring:message code='front.web.view.common.msg.confirmation' />'	
	  				});
	  				return false;
	  			} 
	  			if($("#bankCd").val()==""){  				
	  				ui.alert('<spring:message code="front.web.view.claim.msg.refund_bankCd" />',{					
	  					ybt:'<spring:message code='front.web.view.common.msg.confirmation' />'	
	  				});  				
	  				$("#bankCd").focus();
	  				return false;
	  			}
	  			if($("#acctNo").val()==""){
	  				ui.alert('<spring:message code="front.web.view.claim.msg.refund_acctoNo" />',{					
	  					ybt:'<spring:message code='front.web.view.common.msg.confirmation' />'	
	  				});  				
	  				$("#acctNo").focus();
	  				return false;
	  			}
	  			if($("#refundBankAuth").val()==""){
	  				ui.alert('환불계좌 인증하시기 바랍니다.',{					
	  					ybt:'<spring:message code='front.web.view.common.msg.confirmation' />'	
	  				});  				  				
	  				return false;
	  			}
	  			
			}
	
	  		return true;
	    }
		
		/*
		 * 취소, 교환, 반품, as조회 화면 리로딩
		 */
		function searchClaimRequestList(){
			
			if("${mngb}" == "OL"){
				$("#claim_request_list_form").attr("action", "/mypage/order/indexDeliveryList");
			}else if("${mngb}" == "OD"){
				$("#claim_request_list_form").attr("action", "/mypage/order/indexDeliveryDetail");
				$("#claim_request_list_form").attr("method", "get");
				var ordNo = $("#ordNo").val();		
				var mngb = "${mngb}";
				var hidhtml = "<input type=\"hidden\" name=\"ordNo\"  value="+ ordNo +" /><input type=\"hidden\" name=\"mngb\"  value="+mngb+" />";
				$("#claim_request_list_form").append(hidhtml);
			}else{
				$("#claim_request_list_form").attr("action", "/mypage/order/indexClaimList");	
			}
			
			$("#claim_request_list_form").attr("target", "_self");		
			$("#claim_request_list_form").submit();
		}
	
		/*******************
		 * INIpay 결제
		 *******************/
		 var inipay = {
			open : function(){
				if ($("#payAmt").val() > 0) {				
					dialog.open("order_payment_pay_dialog");
	
					var frameHegiht = $("#order_payment_pay_dialog").height() - 4;
					$("#order_payment_pay_dialog").append("	<iframe id=\"pay_frame\" name=\"pay_frame\" width=\"100%\" height=\""+frameHegiht+"px\"></iframe>");
					
					$("#order_payment_form").attr("target", "pay_frame");
					$("#order_payment_form").attr("action", "/pay/inipay/includeInipay");
					$("#order_payment_form").submit();
				} else {
					insertAccess();
				}
			}
			,cbResult : function(data, type){
				if(data.status == "S"){
					$("#order_payment_inipay_result").val(data.result);
					insertAccess();
				}else{
					alert(data.message);
				} 			
	
				if(type != "B"){
					dialog.close("order_payment_pay_dialog");
				}
			}
			,close : function(type){
				var data = {
					status : 'F',
					message : '<spring:message code='front.web.view.order.cancel.payment.msg' />' 					
				};
				$("#order_payment_pay_dialog").html("");
				
	
				inipay.cbResult(data, type);
			}	
		}
		
		 /*
		 * 환불계좌 인증 나이스페이
		 */
		 function AuthBank(){
	
				if($("#ooaNm").val()==""){  				
					ui.alert('<spring:message code="front.web.view.claim.msg.refund_ooaNm" />',{					
						ybt:'<spring:message code='front.web.view.common.msg.confirmation' />'	
					});
					return false;
				} 
				if($("#bankCd").val()==""){  				
					ui.alert('<spring:message code="front.web.view.claim.msg.refund_bankCd" />',{					
						ybt:'<spring:message code='front.web.view.common.msg.confirmation' />'	
					});  				
					$("#bankCd").focus();
					return false;
				}
				if($("#acctNo").val()==""){
					ui.alert('<spring:message code="front.web.view.claim.msg.refund_acctoNo" />',{					
						ybt:'<spring:message code='front.web.view.common.msg.confirmation' />'	
					});  				
					$("#acctNo").focus();
					return false;
				}
				
				var accountHtml ="";			
				accountHtml += "<input type=\"hidden\" name=\"BankCode\" value=\""+ $("#bankCd").val() +"\" />";
				accountHtml += "<input type=\"hidden\" name=\"AccountNo\" value=\""+ $("#acctNo").val() +"\" />";	
				
				$("#claim_account_form").append(accountHtml);		
				
				var options = {
						url : "<spring:url value='/mypage/order/getAccountName' />"
						, data : $("#claim_account_form").serializeJson()
						, done : function(data){
							 
							if(data.result == "0000"){
								var accountName = data.accountName;
								if($.trim($("#ooaNm").val()) == accountName){
									$("#refundBankAuth").val("Y");
									$("#ooaNm").prop("readonly", true);
									$("#acctNo").prop("readonly", true);
									$("#bankCd option").not(":selected").attr("disabled", "disabled");
									$("#btnAccountChk").find("a").remove();
									$("#btnAccountChk").append("<a href=\"#\" data-content=\"${session.mbrNo }\" data-url=\"/mypage/order/getAccountName\" class=\"btn md\" disabled>계좌인증</a>");
									ui.toast('<spring:message code='front.web.view.order.success.provenaccount.msg' />');							
								}else{							
									ui.toast('<spring:message code='front.web.view.order.fail.provenaccount.msg.check.again' />');							
								}
							}else{
								ui.toast('<spring:message code='front.web.view.order.fail.provenaccount.msg.check.again' />');					
								
							}	
						}
				};
					
				ajax.call(options);
				$("#claim_account_form").empty();
			}
		
		 function negative(){	
				if($("#miRefundPay").find(".savePoint").text() == '0원'){
					ui.alert("환불 예정 금액이 마이너스(-)인 관계로 마이페이지에서 신청이 불가합니다. 고객센터로 문의해주세요.",{					
						ybt:'확인'	
					});	
				}else{
					ui.alert("추가 결제금액이 있을 경우, 취소 신청을 할 수 없습니다. 고객센터로 문의해주세요.",{					
						ybt:'확인'	
					});
				}
		}
	</script>
	</tiles:putAttribute>
	
	<tiles:putAttribute name="content">
	
		<c:if test="${view.deviceGb eq frontConstants.DEVICE_GB_10 }">
			<jsp:include page="/WEB-INF/tiles/include/lnb_my.jsp" />
			<jsp:include  page="/WEB-INF/tiles/include/menubar.jsp" />
		</c:if>
	
		<!-- 바디 - 여기위로 템플릿 -->
		<main class="container lnb page shop my" id="container">	
	
			<div id="order_payment_pay_dialog" style="display:none;" title="<spring:message code='front.web.view.order.title.payment' />"></div>
			
			<form id="order_payment_form">
				<input type="hidden" id="ordNo" name="ordNo" value="${orderSO.ordNo}" /> 
				<input type="hidden" id="payAmt" name="payAmt" value="" />
				<input type="hidden" id="goodsNms" name="goodsNms" value="<spring:message code='front.web.view.order.title.extra.delivery.payment' />" /> 
				<input type="hidden" id="payMeansCd" name="payMeansCd" value="${FrontWebConstants.PAY_MEANS_10}" />
				<input type="hidden" id="ordNm" name="ordNm" value="${order.ordNm}" /> 
				<input type="hidden" id="ordrEmail" name="ordrEmail" value="${order.ordrEmail}" /> 
				<input type="hidden" id="ordrMobile" name="ordrMobile" value="${order.ordrMobile}" /> 
			</form>
			
			<form id="claim_request_list_form" name="claim_request_list_form" method="post"></form>		
			<form id="claim_account_form" name="claim_account_form" method="post"></form>
			
			<div class="inr">			
				<!-- 본문 -->
				<c:set var="claimCompNo" value="" /><!-- 비교용 업체 번호 -->
				
				<div class="contents" id="contents">
					<div class="pc-tit">
						<h2><spring:message code='front.web.view.order.title.cancelrequest.nospace' /></h2>
					</div>
					
			<c:choose>
				<c:when test="${order ne '[]'}">								
					
					<div class="oder-cancel border-on margin">
						<ul>
						
						<form id="cancel_request_list_form" name="cancel_request_list_form" method="post">
							<input type="hidden" id="ordNo" name="ordNo" value="${so.ordNo}" /> 
							<input type="hidden" id="clmTpCd" name="clmTpCd" value="${CommonConstants.CLM_TP_10}"/> 
							<input type="hidden" id="chkNumCheck" value="" />
							<input type="hidden" id="amtChkNumCheck" value="" />
							<%-- INIpay 결제 인증 리턴값 --%>
							<input type="hidden" id="order_payment_inipay_result" name="inipayStdCertifyInfo" value="" />
							
							<input type="hidden" id="payMeansCd" name="payMeansCd" value="${order.payMeansCd}" />
							<input type="hidden" id="refundBankCd" name="refundBankCd" value="${order.refundBankCd}" />
							<input type="hidden" id="refundAcctNo" name="refundAcctNo" value="${order.refundAcctNo}" />
							<input type="hidden" id="refundOoaNm" name="refundOoaNm" value="${order.refundOoaNm}" />
							<input type="hidden" id="refundBankAuth" name="refundBankAuth" />		
						
						
						<c:forEach items="${order.orderDetailListVO}" var="orderCancel" varStatus="idx1">
							<c:if test="${idx1.first}">
			                	<c:set var="claimCompNo" value="${orderCancel.compNo}" />
			              	</c:if>
						
							<c:set value="${orderCancel.ordDtlStatCd}" var="ordDtlStatCd"/>
							<c:set value="${idx1.index}" var="index"/>						
							
							<li>
							<c:if test="${ordDtlStatCd ne FrontWebConstants.ORD_DTL_STAT_110}">
								<input type="hidden" id="ordDtlSeq${index}" name="arrOrdDtlSeq" data-mki="${ orderCancel.mkiGoodsYn }"  value="${orderCancel.ordDtlSeq}" />
							</c:if>
								<div class="untcart <c:if test="${idx1.first}">cancel</c:if>">		
									<label class="checkbox">
								<c:choose>
									<c:when test="${ordDtlStatCd eq FrontWebConstants.ORD_DTL_STAT_110}">
										<input type="checkbox" checked="true" disabled="true"><span class="txt"></span>								
									</c:when>
									<c:otherwise>
										
										<c:choose>
											<c:when test="${!empty orderSO.ordDtlSeq}">										
												<input type="checkbox" id="listCheckCancel${index}" name="arrListCheckCancel" <c:if test="${orderSO.ordDtlSeq eq orderCancel.ordDtlSeq }">checked="true"</c:if> ><span class="txt"></span>								
											</c:when>
											<c:otherwise>
												<input type="checkbox" id="listCheckCancel${index}" name="arrListCheckCancel" checked="true"><span class="txt"></span>
											</c:otherwise>
										</c:choose>		
																		
										
									</c:otherwise>
								</c:choose>
									</label>								
									<div class="box">
										<div class="tops">
											<div class="pic"><a href="/goods/indexGoodsDetail?goodsId=${not empty orderCancel.pakGoodsId ? orderCancel.pakGoodsId : orderCancel.goodsId }" data-content=<c:out value="${orderCancel.goodsId }"/> data-url="/goods/indexGoodsDetail?goodsId=${not empty orderCancel.pakGoodsId ? orderCancel.pakGoodsId : orderCancel.goodsId }">
											<img src="${fn:indexOf(orderCancel.imgPath, 'cdn.ntruss.com') > -1 ? orderCancel.imgPath : frame:optImagePath(orderCancel.imgPath, frontConstants.IMG_OPT_QRY_500)}" alt="${orderCancel.goodsNm }" class="img">
											</a></div>
											<div class="name">
												<div class="tit"><c:out value="${orderCancel.goodsNm}" /><%-- (<c:out value="${orderCancel.ordDtlStatCd}" />) --%></div>
												<div class="stt"><frame:num data="${orderCancel.rmnOrdQty}" />개
												<c:choose>
													<c:when test="${not empty orderCancel.optGoodsNm}">	<!-- 상품 구성 유형 : 묶음 -->
													| ${fn:replace(orderCancel.optGoodsNm, '/', ' / ')}
													</c:when>
													<c:when test="${not empty orderCancel.pakItemNm}">	<!-- 상품 구성 유형 : 옵션 -->
													| 	${fn:replace(orderCancel.pakItemNm, '|', ' / ')}
													</c:when>
												</c:choose>									
												</div>
												<c:if test="${orderCancel.mkiGoodsYn eq 'Y' && not empty orderCancel.mkiGoodsOptContent }">
													<c:forTokens var="optContent" items="${orderCancel.mkiGoodsOptContent }" delims="|" varStatus="conStatus">	
														<div class="stt"><spring:message code='front.web.view.order.title.lettering' />${conStatus.count} : ${optContent}</div>
													</c:forTokens>
												</c:if>	
												<div class="price">
													<span class="prc"><em class="p"><frame:num data="${orderCancel.saleAmt*orderCancel.rmnOrdQty}" /></em><i class="w"><spring:message code='front.web.view.common.moneyUnit.title' /></i></span>
												</div>
											</div>
										</div>
										<div class="amount">
									<c:choose>
										<c:when test="${ordDtlStatCd eq FrontWebConstants.ORD_DTL_STAT_110}">	
											<div class="uispiner" data-min="${orderCancel.rmnOrdQty}" data-max="${orderCancel.rmnOrdQty}">
										</c:when>									
										<c:otherwise>									
											<div class="uispiner" data-min="1" data-max="${orderCancel.rmnOrdQty}">
										</c:otherwise>
									</c:choose>			
											<c:if test="${ordDtlStatCd eq FrontWebConstants.ORD_DTL_STAT_110}">																						
												<input type="text" value="${orderCancel.rmnOrdQty}" class="amt" disabled="" data-saleamt="${orderCancel.payAmt}" readonly>
											</c:if>
											<c:if test="${ordDtlStatCd ne FrontWebConstants.ORD_DTL_STAT_110}">
												<input type="hidden" id="arrClmQty${index}" name="arrClmQty" value="0"  disabled="true"/>
												<input type="text" value="${orderCancel.rmnOrdQty}" class="amt" disabled="" id="clmQty${index}" name="clmQty" data-saleamt="${orderCancel.saleAmt}" readonly>
											</c:if>	
												<button type="button" class="bt minus"><spring:message code='front.web.view.common.goodsPlus.title' /></button>
												<button type="button" class="bt plus"><spring:message code='front.web.view.common.goodsMinus.title' /></button>
											</div>
										</div>
									</div>
								</div>
							</li>
							
						</c:forEach>				
						
							
						</ul>
					</div>
					<div class="exchange-area pc-reposition">
						
						<div class="item-box pc-reposition">
							<p class="tit"><spring:message code='front.web.view.order.title.cancelreason' /></p>
							<div class="sub-tit"><spring:message code='front.web.view.order.title.choosing.cancelreason' /></div>
							<div class="flex-wrap">
								<input type="hidden" id="clmRsnCd" name="clmRsnCd" />
							<c:forEach items="${clmRsnList}" var="clmRsn">
								<label class="radio"><input type="radio" name="radioClmRsnCd" value="${clmRsn.dtlCd }"><span class="txt">${clmRsn.dtlNm}</span></label>
							</c:forEach>						
							
							</div>
							<!-- <p class="info-t2">옵션(사이즈, 색상 등) 변경을 원하시는 경우는 마이페이지에서 신청이 불가합니다. 고객센터로 연락주시기 바랍니다.</p> -->
							<p class="sub-tit pc-reposition"><spring:message code='front.web.view.order.title.wrtie.details.cancelreason' /></p>
							<div class="textarea">
								<textarea placeholder="<spring:message code='front.web.view.order.title.wrtie.content.please' />" id="clmRsnContent" name="clmRsnContent" ></textarea>
							</div>						
						</div>
						
						<div class="item-box pc-reposition">
							<p class="tit"><spring:message code='front.web.view.order.title.expectaion.of.returnpayment' /></p>
							<div class="price-area">
								<ul class="addPoint delivery mb0">
									<li id="allRefundPay" class="ttl"><span>환불 금액</span>	<span class="savePoint"></span></li>
									<li id="mainRefundPay" style="display: none;"><span></span>			<span class="savePoint"></span></li>
									<li id="gsRefundPay" style="display: none;"><span>GS&POINT 환불</span>				<span class="savePoint"></span></li>
									<li id="mpRefundPay" style="display: none;"><span>우주코인 환불</span>				<span class="savePoint"></span></li>
									<li id="miRefundPay" style="display: none"><span>추가 결제금액 환불</span>				<span class="savePoint"></span></li>
									<li id="minusPay" style="display: none"><span>추가 결제금액</span>				<span class="savePoint"></span></li>
								</ul>

								<div class="list" id="divCal" ${prcAreaDisplayStyle }>
									<ul>
										<li>
											<p class="txt1"><spring:message code='front.web.view.order.title.price.of.products' /></p>   
											<p class="txt2" id="goodsAmt"></p>  <!-- goodsTotalAmt -->
										</li>

										<li>
											<p class="txt1"><spring:message code='front.web.view.common.delivery.charge.title' /></p>
											<p class="txt2" id="orgDlvrcAmt"></p>   <!-- orgDlvrcAmt -->
										</li>
										<li>
											<p class="txt1"><spring:message code='front.web.view.order.title.coupon.discount' /></p>
											<p class="txt2 color" id="cpDcAmt"></p>  <!-- cpDcAmt-->
										</li>
										<c:if test="${not empty payMpVO and not empty payMpVO.addUsePnt and payMpVO.addUsePnt gt 0}">
											<li>
												<p class="txt1">우주코인 추가할인</p>
												<p class="txt2 color" id="mpAddUsePnt"></p>  <!-- mpAddUsePnt-->
											</li>
										</c:if>		
										<li>
											<p class="txt1"><spring:message code='front.web.view.order.title.extra.delivery.payment' /> 
												<span class="alert_pop" data-pop="popCpnGud"><!-- 04.20 : 추가 -->
													<span class="bubble_txtBox" style="width:267px;">
														<span class="tit"><spring:message code='front.web.view.order.title.extra.delivery.payment' /></span>
														<span class="info-txt">
															<span>
																<span>
																	<spring:message code='front.web.view.order.title.deliveryprice.of.cancel.return.exchange' />
																</span>
																<span>
																	<spring:message code='front.web.view.order.title.outside.of.city.pay.extra.deliverypayment' />
																</span>
																<span>
																	<spring:message code='front.web.view.order.title.no.free.deliverypayment.because.cancel.return.exchange' />
																</span>
															</span>
														</span>
													</span>
												</span>
											</p>
											<p class="txt2 color" id="clmDlvrcAmt">0원</p>
<!-- 											<div class="dd"> -->
<!-- 												<span class="prc c_r" id="clmDlvrcAmtli"><em class="p" id="clmDlvrcAmtPre"></em><i class="w" id="clmDlvrcAmt"></i>원</span> -->
<!-- 											</div> -->
										</li>	

									</ul>
								</div>
								
							</div>						
						</div>
						<c:if test="${order.payMeansCd eq FrontWebConstants.PAY_MEANS_30 or order.payMeansCd eq FrontWebConstants.PAY_MEANS_40}">	
						<div class="item-box pc-reposition">
							<p class="tit"><spring:message code='front.web.view.order.title.write.returnaccount' /></p>
							<div class="member-input">
								<ul class="list">
									<li>
										<strong class="tit "><spring:message code='front.web.view.order.title.accountholder' /></strong>
										<div class="input disabled">										
											<input type="text" title="<spring:message code='front.web.view.order.title.accountholder' />" id="ooaNm" name="ooaNm" onkeyup="specialCharRemoveSpace(this);return false;" value="${session.mbrNo eq FrontWebConstants.NO_MEMBER_NO ? '' : session.mbrNm }">
										</div>
									</li>
									<li>
										<strong class="tit"><spring:message code='front.web.view.order.title.choose.bank' /></strong>
										<div class="select">									
											<select title="<spring:message code='front.web.view.order.title.choose.bankname' />" id="bankCd" name="bankCd">
												<frame:selectOption items="${bankCdList}" all="true" defaultName="<spring:message code='front.web.view.common.choice.title' />" selectKey="${member.bankCd }"/>
											</select>										
										</div>
									</li>
									<li>
										<strong class="tit"><spring:message code='front.web.view.order.title.your.account' /></strong>
										<div class="input flex" id="btnAccountChk">										
											<input type="text" title="<spring:message code='front.web.view.order.title.your.account' />" placeholder="<spring:message code='front.web.view.order.title.only.account.number' />" id="acctNo" name="acctNo" onkeyup="NumberOnly(this);return false;" value="${member.acctNo }">
											<a href="#" class="btn md" data-content="${session.mbrNo }" data-url="/mypage/order/getAccountName" disabled><spring:message code='front.web.view.order.prove.account.btn' /></a>
										</div>
										<p class="validation-check" id="checkAccount" style="display:none;"><spring:message code='front.web.view.order.title.please.check.your.account.again' /></p>
									</li>
								</ul>
							</div>							
						</div>
					</c:if>
					<c:if test="${(not empty payInfo.payMeansCd and payInfo.payMeansCd ne FrontWebConstants.PAY_MEANS_00 and payInfo.payMeansCd ne FrontWebConstants.PAY_MEANS_30)}">
						<div class="item-box pc-reposition last">						
							<p class="tit"><spring:message code='front.web.view.order.title.returnpayment.way' /></p>
							<p class="means">
								<c:choose>		 
									<c:when test="${payInfo.payMeansCd eq FrontWebConstants.PAY_MEANS_10}">	
										<span><frame:codeValue items="${payMeansCdList}" dtlCd="${payInfo.payMeansCd}" /></span>				
										<frame:codeValue items="${cardcCdList}" dtlCd="${payInfo.cardcCd}"/>(${payInfo.maskedCardNo })							
									</c:when>
									<c:when test="${payInfo.payMeansCd eq FrontWebConstants.PAY_MEANS_20}">
										<span><frame:codeValue items="${payMeansCdList}" dtlCd="${payInfo.payMeansCd}" /></span>
										<frame:codeValue items="${bankCdList}" dtlCd="${payInfo.bankCd}"/>
									</c:when>
									<%-- <c:when test="${payInfo.payMeansCd eq FrontWebConstants.PAY_MEANS_30}">
										<span><frame:codeValue items="${payMeansCdList}" dtlCd="${payInfo.payMeansCd}" /></span>
										<frame:codeValue items="${bankCdList}" dtlCd="${payInfo.bankCd}"/>(<c:out value="${payInfo.acctNo}"/>)						
									</c:when> --%>
									<c:when test="${payInfo.payMeansCd ne null and payInfo.payMeansCd ne FrontWebConstants.PAY_MEANS_00 and payInfo.payMeansCd ne FrontWebConstants.PAY_MEANS_30}">
										<span><spring:message code='front.web.view.order.title.normal.payment' /></span><frame:codeValue items="${payMeansCdList}" dtlCd="${payInfo.payMeansCd}" />
									</c:when>
								</c:choose>		
								<c:if test="${payInfo.payMeansCd ne null and payInfo.payMeansCd ne FrontWebConstants.PAY_MEANS_00 and payInfo.payMeansCd ne FrontWebConstants.PAY_MEANS_30}">
									<br>
								</c:if>
								<%-- <c:if test="${payInfo.svmnAmt ne null and payInfo.svmnAmt ne 0}">
									<span><spring:message code='front.web.view.order.title.normal.payment' /></span><spring:message code='front.web.view.order.title.point' />
								</c:if> --%>					
							</p>
						</div>
					</c:if>
						<div class="info-txt t2 pc-reposition">
							<ul>
								<li>
									<spring:message code='front.web.view.order.title.message.of.payment' />								
								</li>							
							</ul>
						</div>
						<div class="btnSet space pc-reposition">
							<a href="#" data-content="" data-url="/mypage/order/indexClaimList" onclick="searchClaimRequestList();return false;" class="btn lg d"><spring:message code='front.web.view.common.msg.cancel' /></a>						
						</div>						
					</div>
					
				</form>	
				</c:when>
				<c:otherwise>
					<div>
						<spring:message code='front.web.view.order.title.no.available.canceled.orderlists' />
					</div>								
				</c:otherwise>
			</c:choose>	
					
				</div>			
						
				
	
			</div>		
		</main>
		
		<div class="layers">
			<!-- 04.20 : 추가 -->
			<!-- 쿠폰이용안내 -->
			<!-- @@ PC에선 하단 팝업.  MO에선 툴팁으로 해달래요 ㅜㅜ -->
			<article class="popBot popCpnGud" id="popCpnGud">
				<div class="pbd">
					<div class="phd">
						<div class="in">
							<h1 class="tit"><spring:message code='front.web.view.order.title.information.use' /></h1>
							<button type="button" class="btnPopClose"><spring:message code='front.web.view.common.close.btn' /></button>
						</div>
					</div>
					<div class="pct">
						<main class="poptents">
							<ul class="tplist">
								<li><spring:message code='front.web.view.order.title.deliveryprice.of.cancel.return.exchange' /></li>
								<li><spring:message code='front.web.view.order.title.outside.of.city.pay.extra.deliverypayment' /></li>
								<li><spring:message code='front.web.view.order.title.no.free.deliverypayment.because.cancel.return.exchange' /></li>
							</ul>
						</main>
					</div>
				</div>
			</article>
		</div>
		<!-- 바디 - 여기 밑으로 템플릿 -->
	
	</tiles:putAttribute>
	</tiles:insertDefinition>