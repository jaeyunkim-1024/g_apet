	<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
	<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
	<%@ page import="front.web.config.constants.FrontWebConstants" %> 
	<%@ page import="framework.common.constants.CommonConstants" %>
	<%@ page import="framework.common.enums.ImageGoodsSize" %>
	
	<c:set var="prcAreaDisplayStyle" value="${not empty oldStdOrdNo and oldStdOrdNo < orderSO.ordNo ? '' : 'style=\"display:none;\"' }" />
	
	<tiles:insertDefinition name="common">
	<tiles:putAttribute name="script.include" value="script.order"/>
	<tiles:putAttribute name="script.inline">
	<script type="text/javascript">
	
	var claimRefundVO;
	var returnRequestStep = 1;
	
		$(document).ready(function(){
			$("#header_pc").removeClass("mode0");
			$("#header_pc").addClass("mode16");
			$("#header_pc").attr("data-header", "set22");
			$("#header_pc").addClass("logHeaderAc");
			$(".mo-heade-tit .tit").html("반품 신청");	
			$(".mo-header-backNtn").removeAttr("onclick");
			$(".mo-header-backNtn").bind("click", function(){			
				
				if(returnRequestStep == 1){
					//이전페이지로
					if($("#mngb").val() == "OL"){				
						//리스트
						$("#mngb").remove();
						$("input[name='ordNo']").remove();
						$("#claim_request_list_form").attr("action", "/mypage/order/indexDeliveryList");
						$("#claim_request_list_form").submit();
					}else if("${mngb}" == "OD"){
						$("#claim_request_list_form").attr("action", "/mypage/order/indexDeliveryDetail");
						$("#claim_request_list_form").attr("method", "get");
						var ordNo = $("#ordNo").val();			
						var hidhtml = "<input type=\"hidden\" name=\"ordNo\"  value="+ ordNo +" /><input type=\"hidden\" name=\"mngb\"  value=\"OD\" />";
						$("#claim_request_list_form").append(hidhtml);
						$("#claim_request_list_form").submit();
						storageHist.goBack();
					}else{
						storageHist.goBack();
					}
				}else{
					//스텝1로
					stepChange();
				}		
			});
			
			//클레임사유 500자 제한
			$('textarea[name=clmRsnContent]').on('propertychange keyup input change paste ', function(){
				if($(this).val().length >= 500){
					$(this).val($(this).val().substring(0,500));
					ui.toast("내용은 500자까지 입력할 수 있어요.");
				}
			});
		}); 
		
		
	
		$(document).ready(function(){
			claimRefundVO = new Object();		
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
			//결제금액 계산 및 계좌입력 초기화 
			initCalculation();
			// 반품안내 확인 초기화
			//$("input:checkbox[name=checkAgree]").prop("checked", false);
			$("#clmRsnCd").val("");
			//getClaimRefundExcpect();
			$("#payAmt").val(0);
	
			dialog.create("order_payment_pay_dialog" , {width: 850, height:637, modal:true});
			
			$("#order_payment_pay_dialog").prev(".ui-dialog-titlebar").children("button").click(function(){
				inipay.close("B");
			});		
		});
		
		//초기값 설정
		function initCalculation(){
			$("#paymentAmt").html("0원");  
			$("#goodsAmt").html(0);
			$("#orgDlvrcAmt").html(0);
			$("#clmDlvrcAmt2").html(0);
			
			$("#cpDcAmtli").removeClass("color");
			$("#cpDcAmtPre").text("");
			$("#cpDcAmt").html(0);
			
			$("#clmDlvrcAmtli").removeClass("color");
			$("#clmDlvrcAmtPre").text("");
			$("#clmDlvrcAmt").html('0원');
			
			$("#allRefundPay .savePoint").html("0원");
			$("#mainRefundPay .savePoint").html("0원");
			$("#gsRefundPay .savePoint").html("0P");
			$("#mpRefundPay .savePoint").html("0C");
			$("#miRefundPay .savePoint").html("0원");
			$("#minusPay .savePoint").html("0원");
			
			
			//$("#refundAmt").html("");		
			$("li[id^=addAmt_]").remove()
			$("#txtDisabled").remove();
			
			$("#btnReturnlApply").remove();
			$("#btnSetlast").append("<a href=\"#\" data-content=\"\" data-url=\"/mypage/insertClaimCancelExchangeRefund\" onclick=\"insertReturnRequestList();return false;\" class=\"btn lg a\" id=\"btnReturnlApply\">다음</a>");
		} 
	
		
		function setClmQty() {		
			var arrClmQty = $("input[name=arrClmQty]");			
			for(var i=0; i <arrClmQty.length; i++){			
				$("#arrClmQty"+i).val(parseInt($("#clmQty"+i).val()));
				
				if($("#listCheckReturn"+i).is(":checked") == true){					
					$("#arrClmQty"+i).prop("disabled", false);
					$("#ordDtlSeq"+i).prop("disabled", false);
					$("#orgItemNo").val($("#orgItemNo"+i).val());
				}else{
					$("#arrClmQty"+i).prop("disabled", true);
					$("#ordDtlSeq"+i).prop("disabled", true);
					$("#orgItemNo"+i).prop("disabled", true);
					$("#orgItemNo").val("");
				}
			}		
		}
		
		/*
	    * 환불예상금액계산
	    */
		function getClaimRefundExcpect() {
			
			$("#btnReturnlApply").remove();
			$("#btnSetlast").append("<a href=\"#\" data-content=\"\" data-url=\"/mypage/insertClaimCancelExchangeRefund\" onclick=\"insertReturnRequestList();return false;\" class=\"btn lg a\" id=\"btnReturnlApply\">다음</a>");
			if (!clmQtyCheck()) {
				
				if($("input[name='arrListCheckReturn']").length > 0){			
					ui.alert("반품신청 상품을 선택하세요.",{					
						ybt:'확인'	
					});
					$("input[name='radioClmRsnCd']").prop("checked", false);
					$('.radio').removeClass('on');		
				}
				
				return;
			} else if (!clmRsnCdCheck()) {
				return;
			}
			
			setClmQty();
			
			var options = {
					url : "<spring:url value='/mypage/order/getClaimRefundExcpect' />"
					, data : $("#return_request_list_form").serialize()
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
			
			//$("#refundAmt").html("");
			$("li[id^=addAmt_]").remove();
			
			$("#orgDlvrcAmt").html(0);
			var refundAmtHtml = "";
	
			paymentAmt += parseInt(claimRefundVO.goodsAmt);
			$("#goodsAmt").html(fnComma(claimRefundVO.goodsAmt));
			
			if (claimRefundVO.refundDlvrAmt != undefined) {
				paymentAmt += parseInt(claimRefundVO.refundDlvrAmt);
				$("#orgDlvrcAmt").html(fnComma(claimRefundVO.refundDlvrAmt));
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
				//paymentAmt -= parseInt(claimRefundVO.cpDcAmt);
				paymentAmt -= parseInt(cpDcAmt);
				$("#cpDcAmt").html(fnComma(cpDcAmt));
				$("#cpDcAmtPre").text("-");
				$("#cpDcAmtli").addClass("color");
			}		
			
			$("#paymentAmt").html(fnComma(paymentAmt)+"원") ;  
	
			if (claimRefundVO.refundDlvrAmt != undefined && claimRefundVO.refundDlvrAmt < 0) {
				addAmt += parseInt(Math.abs(claimRefundVO.refundDlvrAmt));
			}
			
			if ((claimRefundVO.clmDlvrcAmt != undefined) || (claimRefundVO.reduceDlvrcAmt != undefined)) {
				var clmDlvrcAmt = claimRefundVO.clmDlvrcAmt  + claimRefundVO.reduceDlvrcAmt+claimRefundVO.addReduceDlvrcAmt;
				clmDlvrcAmt *= -1; 
				
// 				$("#clmDlvrcAmtli").addClass("color");
// 				if(clmDlvrcAmt < 0){
// 					$("#clmDlvrcAmtPre").text("-");
// 				} else {
// 					$("#clmDlvrcAmtPre").text("");
// 				}
				
				$("#clmDlvrcAmt").html(fnComma(clmDlvrcAmt)+'원');
			} 
			
			var extraDlvrcAmt = claimRefundVO.clmDlvrcAmt+ claimRefundVO.reduceDlvrcAmt;
			$("#clmDlvrcAmt2").html(fnComma(extraDlvrcAmt));
			if(extraDlvrcAmt != 0){
				$('#extraDlvrcPayMethod').show();
			} else {
				$('#extraDlvrcPayMethod').hide();
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
				$("#mpAddUsePnt").html("-"+fnComma(claimRefundVO.mpRefundAddUsePnt)+"원");
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
			
			if(Number(claimRefundVO.totAmt) < 0 || minusRefund > 0){
				
				var disableHtml = "<p class=\"info-t2\" id=\"txtDisabled\">환불 예정 금액이 마이너스(-)인 관계로 마이페이지에서 신청이 불가합니다. 고객센터로 문의해주세요.</p>";
				$("#price_area").append(disableHtml);
				
				/* $("#btnReturnlApply").remove();
				$("#btnSetlast").append("<a href=\"#\" class=\"btn lg a\" disabled id=\"btnReturnlApply\">반품 신청</a>"); */
				
			}
		}
		
		/*
		 * 수거지 변경
		 */
		function goAddressChange(ordNo){
			var params = { ordNo : ordNo
						, viewTitle :  "반품수거지 변경"
						, callBackFnc : 'cbAddressChangePop'
						, mode : "return"
					}
			//pop.popupDeliveryAddressEdit(params);
			
			var popUrl = "/mypage/order/popupDeliveryAddressEdit";		
			orderPopup.loadLayer("layers", popUrl, params, "", "cbAddressChangePop");
		}
		
		/*
		 * 수거지 변경 CallBack
		 */
		function cbAddressChangePop(data){
			$("#adrsNm").val(data.adrsNm);
			$("#mobile").val(data.mobile);
			$("#tel").val(data.tel);
			$("#dlvrMemo").val(data.dlvrMemo);
			
			$("#adrsNmView").text(data.adrsNm);
			$("#mobileView").text(fnMobilel(data.mobile));
			$("#telView").text(fnTel(data.tel));
			$("#dlvrMemoView").text(data.dlvrMemo);
			
			$("#roadDtlAddr").val(data.roadDtlAddr);
			$("#roadDtlAddrView").text(data.roadDtlAddr);		
			// 지번 상세내역을 입력 안받기 때문에 도로명 상세내역 입력
			//$("#prclDtlAddr").val(data.prclDtlAddr);
			$("#prclDtlAddr").val(data.roadDtlAddr);
			$("#prclDtlAddrView").text(data.roadDtlAddr);
			
			if (data.addressChanged == "Y") {
				$("#roadAddr").val(data.roadAddr);
				$("#postNoNew").val(data.postNoNew);
				$("#postNoOld").val(data.postNoOld);
	
				$("#roadAddrView").text(data.roadAddr);
				$("#postNoNewView").val(data.postNoNew);
				$("#postNoOldView").val(data.postNoOld);
				
				if (data.prclAddr != "") {
					$("#prclAddr").val(data.prclAddr);
					$("#prclAddrView").text(data.prclAddr);
				} else {
					$("#prclAddr").val(data.roadAddr);
					$("#prclAddrView").text(data.roadAddr);
				}
				
				$("#prclAddrViewDiv").show();
				
				getClaimRefundExcpect();
			}
		}
	
		//주문 반품 신청하기 button   
		function insertReturnRequestList(){
			//var rpAppChecked = $("input:checkbox[name=checkAgree]").is(":checked"); 
	
			if (!clmQtyCheck()) {			
				
				if($("input[name='arrListCheckReturn']").length > 0){			
					ui.alert("반품할 상품을 선택해주세요.",{					
						ybt:'확인'	
					});			
				}else{
					ui.alert('<spring:message code="front.web.view.claim_cancel.msg.clmQty" />',{					
						ybt:'확인'	
					});	
				}				
				return;
			} else if (!clmRsnCdCheck()) {
				ui.alert('<spring:message code="front.web.view.claim.msg.refund.claim_Rsn" />',{					
					ybt:'확인'	
				});			
				$("#clmRsnCd").focus();
				return;
			}else if ($.trim($("#clmRsnType").val()) == "" ) {			
			//판매자 귀책사유일경우
				
				if($("#clmRsnContent").val().length == 0 || $("#clmRsnContent").val() == ""){
					ui.toast('상세 사유를 입력해주세요.',{					
						ybt:'확인'	
					});			
					$("#clmRsnContent").focus();
					return;
				}
			
				if($("#clmRsnContent").val().length < 10){
					ui.alert('상세사유는 10자 이상 입력해주세요.',{					
						ybt:'확인'	
					});			
					$("#clmRsnContent").focus();
					return;
				}
				
				if($("#rtnImageArea").children('div').length-1 == 0){
					ui.alert('사진을 첨부해주세요',{					
						ybt:'확인'	
					});			
					$("#clmRsnContent").focus();
					return;
				}
				
			}
			if($("#clmRsnContent").val().length > 500){
				
				ui.alert('500자까지 입력 가능합니다.',{					
					ybt:'확인'	
				});			
				$("#clmRsnContent").focus();
				return;
				
			}else if (!payMeansCdCheck()) {
	    		return;
	    	}
					
			/* if(rpAppChecked){               //주문동의 여부    
				// 신청하기 
				if ( confirm('<spring:message code="front.web.view.claim.refund.confirm.claim_accept" />') ) {
					if (claimRefundVO.totAmt < 0) {
						$("#payAmt").val(Math.abs(claimRefundVO.totAmt));
					} else {
						$("#payAmt").val(0);
					}
	
					setClmQty();
					inipay.open();
				}
			
			} else {
				alert('<spring:message code="front.web.view.claim.msg.refund_info.check" />'); 
				$("input:checkbox[name=checkAgree]").focus();
				return;
			}   */
			
			if(returnRequestStep == 1 ){
	    		//반품불가능한 상품이 포함됐는지 체크 == 반품 도중 ord_dtl_stat_cd 가 변경된 경우 
	    		//STEP1 에서 체크 하라고 JIRA-1597에 언급.
	    		var arrClmQty = $("input[name=arrClmQty]");
	    		var checkedNos=[]; //0,1,2
				var checkedOrdDtlSeqs=[];//OrdDtlSeqs
				var checkedCnt = 0 ;
				var result = true;
				for(var i=0; i <arrClmQty.length; i++){
					if($("#listCheckReturn"+i).is(":checked") == true){
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
									 if(orderDetailList[i].ordDtlStatCd != "${FrontWebConstants.ORD_DTL_STAT_160}"){
										 changedSeqs[cnt] = checkedNos[j];
										 cnt++;
										 result = false;
									 }
								 }
							 }
						 }
						 if(!result){
							 ui.alert('<spring:message code="front.web.view.claim_return.msg.ordDtlStat" />',{
								ycb: function(){
									for(var i=0; i <changedSeqs.length; i++){
										var seq = changedSeqs[i];
										$("#listCheckReturn"+seq).prop("disabled", true);
										$("#listCheckReturn"+seq).prop("checked", false);
										$("#arrClmQty"+seq).prop("disabled", true);
										$("#ordDtlSeq"+seq).prop("disabled", true);
										$("#orgItemNo"+seq).prop("disabled", true);
										$("#orgItemNo").val("");  
									}
									initCalculation();
									$("input[name='radioClmRsnCd']").prop("checked", false);
									$('.radio').removeClass('on');		
								},
			  					ybt:'확인'	
			  				});
						 }
					}
				};
				ajax.call(options);
				if(!result){
					return;
				} else {
					//다음단계로
					stepChange();
					return;
				}
			}	
			
			ui.confirm('반품 신청 시 철회는 불가합니다.<br/>신청하시겠습니까? ',{ // 컨펌 창 띄우기
				ycb:function(){
					
					if (claimRefundVO.totAmt < 0) {
						$("#payAmt").val(Math.abs(claimRefundVO.totAmt));
					} else {
						$("#payAmt").val(0);
					}
					
					setClmQty();
					/* inipay.open(); */
					insertAccess();
				},
				ybt:'확인',
				nbt:'취소'	
			});		
		}
			
		function clmRefuseChk(){
			
			var arrClmQty = $("input[name=arrClmQty]");
			var totMkiQty = 0;
			for(var i=0; i <arrClmQty.length; i++){			
				
				if($("#listCheckReturn"+i).is(":checked") == true){					
// 					2021-04-17 각인상품이 있어도 반품 가능
// 					if($("#ordDtlSeq"+i).data("mki") == "Y"){
// 						totMkiQty += 1;
// 					}			
				}
			}
					
			if (totMkiQty > 0) {
				return false;
			}
			
			return true;		
		}
		
		function negative(){
			if($("#miRefundPay").find(".savePoint").text() == '0원'){
				ui.alert("환불 예정 금액이 마이너스(-)인 관계로 마이페이지에서 신청이 불가합니다. 고객센터로 문의해주세요.",{					
					ybt:'확인'	
				});	
			}else{
				ui.alert("추가 결제금액이 있을 경우, 반품 신청을 할 수 없습니다. 고객센터로 문의해주세요.",{					
					ybt:'확인'	
				});
			}
			
			
		}
		
		function stepChange(){
			if(returnRequestStep == 1){
				//2단계로
				$(".step1").css('display','none');
				$(".step2").css('display','block');
				$("#btnCancle").text("이전");
				
				var miRefunPayFlag = false;
				
				if($("#miRefundPay").find(".savePoint").text() !== "0원"){
					
					miRefunPayFlag = true;
				}	
				
				$("#btnReturnlApply").text("반품 신청");	
				if(Number(claimRefundVO.totAmt) < 0 || miRefunPayFlag){
					//버튼 disabled 처리
					$("#btnReturnlApply").attr("disabled",true);
					$("#btnReturnlApply").attr("onClick", "negative();return false;");
					
					//환불 문구 삭제 후 추가결제 문구 노출. 
					if(miRefunPayFlag){
						$("#txtDisabled").remove();
						
						var disableHtml = "<p class=\"info-t2\" id=\"txtDisabled\">추가 결제금액이 있을 경우, 마이페이지에서 신청이 불가합니다. 고객센터로 문의해주세요.</p>";
					}
					$("#price_area").append(disableHtml);
				}									
				returnRequestStep = 2;
			}else{
				//처음단계로
				$(".step1").css('display','block');
				$(".step2").css('display','none');
				$("#btnCancle").text("취소");
				
				$("#btnReturnlApply").remove();
				$("#btnSetlast").append("<a href=\"javascript:;\" data-content=\"\" data-url=\"/mypage/insertClaimCancelExchangeRefund\" onclick=\"insertReturnRequestList();return false;\" class=\"btn lg a\" id=\"btnReturnlApply\">다음</a>");			
				$("#btnReturnlApply").text("다음");
				returnRequestStep = 1;
			}
			returnRequestStep
		}
		
		function insertAccess(){
			var mbrNo = '${session.mbrNo}';
			var url = "<spring:url value='/mypage/insertClaimCancelExchangeRefund' />";
			var formUrl = "/mypage/order/indexReturnCompletion";
			
			/* if ("${session.mbrNo}" == "${FrontWebConstants.NO_MEMBER_NO}") {
				url = "<spring:url value='/mypage/noMemberInsertClaimCancelExchangeRefund' />";
			} */
			
			$("#bankCd option").not(":selected").attr("disabled", "");
			
			// 2021.05.06, ssmvf01
			var formData;
			if ("${view.deviceGb}" == "${frontConstants.DEVICE_GB_30}") {
				formData = $("#return_request_list_form :input[name!='imgPaths']").serialize();
			} else {
				formData = $("#return_request_list_form").serialize();
			}
			
			var options = {
					url : url
					, data : formData	// 2021.05.06, ssmvf01
					, done : function(data){
						if(data != null) {
							// 2021.05.06, ssmvf01
							if("${view.deviceGb}" == "${frontConstants.DEVICE_GB_30}" && $("div[id^=rtnImgArea_]").length > 0) {
								$("input[name=clmNo]").val(data.clmNo);
								
								onFileUpload(data.clmNo);
								return;
							}
							
							jQuery("<form action=\"" + formUrl + "\" method=\"post\"><input type=\"hidden\" name=\"clmNo\" value=\""+data.clmNo+"\" /></form>").appendTo('body').submit();
						}
					}
			};
			
			ajax.call(options);
		}
		
		function clmQtyCheck() {
			var clmQty = document.getElementsByName('clmQty');
			var totClmQty = 0;
			for(var i=0; i <clmQty.length; i++){		
				
				if($("#listCheckReturn"+i).is(":checked") == true){					
					totClmQty += parseInt($("#clmQty"+i).val());
				}
			}
			
			if (totClmQty ==0) {
				return false;
			}
	
	  		return true;
		}
	  
		function clmRsnCdCheck() {
			if(!$('input:radio[name="radioClmRsnCd"]').is(':checked')){
				return false;
			}
	    	
	  		return true;
	  	}
	  
	    // 결제 수단 코드 체크
	    function payMeansCdCheck() {
	    	var payMeansCd = $("#return_request_list_form #payMeansCd").val();
	    	//결제 수단코드 실시간계좌이체 : "20", 가상계좌 : "30", 무통장 : "40" 일 경우
	  		if(payMeansCd == "${FrontWebConstants.PAY_MEANS_30}" 
	  				|| payMeansCd == "${FrontWebConstants.PAY_MEANS_40}"){
	  			if($("#ooaNm").val()==""){  				
	  				ui.alert('<spring:message code="front.web.view.claim.msg.refund_ooaNm" />',{					
	  					ybt:'확인'	
	  				});
	  				$("#ooaNm").focus();
	  				return false;
	  			} 
	  			if($("#bankCd").val()==""){  				
	  				ui.alert('<spring:message code="front.web.view.claim.msg.refund_bankCd" />',{					
	  					ybt:'확인'	
	  				});  				
	  				$("#bankCd").focus();
	  				return false;
	  			}
	  			if($("#acctNo").val()==""){
	  				ui.alert('<spring:message code="front.web.view.claim.msg.refund_acctoNo" />',{					
	  					ybt:'확인'	
	  				});  				
	  				$("#acctNo").focus();
	  				return false;
	  			}
	  			if($("#refundBankAuth").val()==""){
	  				ui.alert('환불계좌 인증하시기 바랍니다.',{					
	  					ybt:'확인'	
	  				});  				  				
	  				return false;
	  			}		
	  			
	  		}
	    	
	  		return true;
	    }
	
		/*
		 * 취소, 교환, 반품 조회 화면 리로딩
		 */
		function searchClaimRequestList(){
			/*
			$("#claim_request_list_form").attr("target", "_self");
			//$("#claim_request_list_form").attr("action", "/mypage/order/indexClaimRequestList");
			$("#claim_request_list_form").attr("action", "/mypage/order/indexDeliveryList");		
			$("#claim_request_list_form").submit();
			*/
			
			if(returnRequestStep == 1){
				//이전페이지로
				if($("#mngb").val() == "OL"){				
					//리스트
					$("#mngb").remove();
					$("input[name='ordNo']").remove();
					$("#claim_request_list_form").attr("action", "/mypage/order/indexDeliveryList");
					
				}else if($("#mngb").val() == "OD"){
					//리스트
					//$("#mngb").remove();
					//$("input[name='ordNo']").remove();
					//상세페이지로
					$("#claim_request_list_form").attr("action", "/mypage/order/indexDeliveryDetail");
				}else{
					//반품신청리스트
					$("#claim_request_list_form").attr("action", "/mypage/order/indexClaimList");
				}
				$("#claim_request_list_form").attr("target", "_self");
				//$("#claim_request_list_form").attr("action", "/mypage/order/indexDeliveryList");		
				$("#claim_request_list_form").submit();	
			}else{
				//스텝1로
				stepChange();
			}
		}
		
		
		function clmRsnContent() {
			
			if($("#clmRsnContent").val() == ""){
				return false;
			}
		
			if($("#rtnImageArea").children('div').length-1 == 0){
				return false;
			}		
			
	  		return true;
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
					message : '결제가 취소되었습니다.' 					
				};
				$("#order_payment_pay_dialog").html("");
				
	
				inipay.cbResult(data, type);
			}	
		}
		
		
		
		
		//사진 첨부
		function imageUpload(){
			if("${view.deviceGb}" != "APP"){
				fileUpload.image(imageUploadCallBack)
			}else{
				callAppFunc("onOpenGallery");
			}
		}
		
		var maxfileSize = 0;	//업로드 가능한 파일 총 용량
		var orgFlNms = new Array();
		var phyPaths = new Array();
		var flSzs = new Array();
		
		function imageUploadCallBack(result){
			if("${view.deviceGb}" != "APP"){
				if($("div[id^=rtnImgArea_]").length > 4) {
					ui.alert('파일 첨부는 최대 5개까지 가능합니다',{					
						ybt:'확인'	
					});
					return false;
				}
				
				var area = "";
				var count = "1";
				area = $("div[id^=rtnImgArea_]").length!=0?$("div[id^=rtnImgArea_]").last()[0]:null;
				if(area != null && area != ""){
					count = parseInt(area.id.split('_')[1])+1;
				}
			
				var html = "";
				html += '<div class="picture swiper-slide" id="rtnImgArea_'+ count +'">';
				html += '<input type="hidden" name="fileName" id="fileName" value="'+result.file.fileName+'">';
				html += '<input type="hidden" name="fileSize" id="fileSize" value="'+result.file.fileSize+'">';
				html += '<input type="hidden" name="filePath" id="filePath" value="'+result.file.filePath+'">';
				html += '<input type="hidden" name="imgPaths" value="'+result.file.filePath+'" >';
				html += "<p class=\"img\">";			
				html += '<img class="img" name="\claimImg\" src="/common/imageView?filePath='+result.file.filePath+'" alt="사진">';
				html += "</p>";
				html += '<button type="button" class="remove-btn" id="del" onclick="deleteImage(this);">삭제</button>';
				html += '</div>';			
				$("#rtnImageArea").append(html);
				
				rtnImgCheck();
				
			}else{
				imageResult = JSON.parse(result);
				$("#imgPathView").attr("src" , imageResult.imageToBase64)
			}
		}
		
		function deleteImage(data){		
			$(data).parent('div').remove();
			rtnImgCheck();
		}	
		
		//이미지 갯수 체크
		function rtnImgCheck(){
			if($("#rtnImageArea").children('div').length-1 >= 5){			
				$("#btnRtnImage").unbind("click"); 
			}else{
				$("#btnRtnImage").bind("click");			
			}
			
		}
		
		$(function(){
			//이미지 삭제
			$("#return_request_list_form").on('click', 'button[name=delImg]', function(){
				$(this).parent('div').remove();
				rtnImgCheck();
			});
			
			
			$("input[name='radioClmRsnCd']:radio").change(function (){
				
				initCalculation();
				
				$("#clmRsnContent").attr("placeholder","내용을 입력해주세요. (최소 10자 이상)");
				$("#clmRsnType").val("");
				
				if($(this).val() == "210"){
					$("#clmRsnType").val("1");				
					$("#clmRsnContent").attr("placeholder","내용을 입력해주세요.");
				}			
				if($(this).val() == "280"){
					$("#clmRsnType").val("1");
					$("#clmRsnContent").attr("placeholder","내용을 입력해주세요.");
				}		
				
				//placeholder="내용을 입력해주세요." id="clmRsnContent"
				$('.radio').removeClass('on');										
				$(this).parent('.radio').addClass('on');				
				
							
				$("#clmRsnCd").val($(this).val());
				getClaimRefundExcpect();			
			});
			
			$(".uispiner .bt").click(function(){			
				if($(this).parents("div.untcart").find("input[name='arrListCheckReturn']").is(":checked") == true){			
					$("input[name='radioClmRsnCd']").prop("checked", false);
					$('.radio').removeClass('on');		
					initCalculation();
				}	
			});
			
			if($("input[name='arrListCheckReturn']").length > 0){
				$("input[name='arrListCheckReturn']").click(function(){
					$("input[name='radioClmRsnCd']").prop("checked", false);
					$("label.on").removeClass("on");
					initCalculation();
				});
			}
			
			
			$("#ooaNm, #bankCd, #acctNo").change(function(){
				$("#btnAccountChk").find("a").remove();			
				if($("#ooaNm").val()=="" || $("#bankCd").val()=="" || $("#acctNo").val()=="" ){
					$("#btnAccountChk").append("<a href=\"#\" data-content=\"${session.mbrNo }\" data-url=\"/mypage/order/getAccountName\" class=\"btn md\" disabled>계좌인증</a>");
				}else{
					$("#btnAccountChk").append("<a href=\"#\" onclick=\"AuthBank();return false;\" data-content=\"${session.mbrNo }\" data-url=\"/mypage/order/getAccountName\" class=\"btn md\">계좌인증</a>");	
				}			
			});
				
		});
		
		/*
		 * 환불계좌 인증 나이스페이
		 */
		function AuthBank(){
	
			if($("#ooaNm").val()==""){  				
				ui.alert('<spring:message code="front.web.view.claim.msg.refund_ooaNm" />',{					
					ybt:'확인'	
				});
				return false;
			} 
			if($("#bankCd").val()==""){  				
				ui.alert('<spring:message code="front.web.view.claim.msg.refund_bankCd" />',{					
					ybt:'확인'	
				});  				
				$("#bankCd").focus();
				return false;
			}
			if($("#acctNo").val()==""){
				ui.alert('<spring:message code="front.web.view.claim.msg.refund_acctoNo" />',{					
					ybt:'확인'	
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
								ui.toast('계좌인증에 성공하였습니다.');							
							}else{							
								ui.toast('계좌 인증에 실패하였습니다. 계좌 정보를 다시 확인해주세요');							
							}
						}else{
							ui.toast('계좌 인증에 실패하였습니다. 계좌 정보를 다시 확인해주세요');					
							
						}	
					}
			};
				
			ajax.call(options);
			$("#claim_account_form").empty();
		}
		
		//파일 업로드
		var fileUpload = {
			image: function (callback) {
				fileUpload.callBack = callback;
				fileUpload.fileForm("inquiry");
			},
			fileForm: function (type) {
				$("#fileUploadForm").remove();
				var html = [];
				html.push("<form name=\"fileUploadForm\" id=\"fileUploadForm\" method=\"post\" enctype=\"multipart/form-data\">");
				html.push("	<div style=\"display:none;\">");
				html.push("		<input type=\"file\" name=\"uploadFile\" id=\"inquiryUploadFile\" />");
				html.push("		<input type=\"hidden\" name=\"uploadType\" value=\"" + type + "\">");
				html.push("	</div>");
				html.push("</form>");
				$("body").append(html.join(''));
				$("#inquiryUploadFile").click();
			},
			
			afterFileSelect: function (file, exCode) {			
				var html = "";
				html += "<div class=\"picture swiper-slide\">";
				html += '<input type="hidden" name="fileName" value="'+file.file.fileName+'">';
				html += '<input type="hidden" name="fileSize" value="'+file.file.fileSize+'">';
				html += '<input type="hidden" name="filePath" value="'+file.file.filePath+'">';
				html += '<input type="hidden" name="imgPaths" value="'+file.file.filePath+'">';
				html += "<p class=\"img\">";
				html += "<img class=\"img\" src=\"../../_images/_temp/goods_1.jpg\" alt=\"사진\">";
				html += "</p>";
				html += "<button type=\"button\" class=\"remove-btn\" name=\"delImg\">삭제</button>";
				html += "</div>";			
				$("#rtnImageArea").append(html);		
				
				rtnImgCheck();
				
			},
			
			appResultImage : function(result){
				imageResult = JSON.parse(result);
				var area = "";
				var count = "1";		
				area = $("div[id^=rtnImgArea_]").length!=0?$("div[id^=rtnImgArea_]").last()[0]:null;
				
				if(area != null && area != ""){
					count = parseInt(area.id.split('_')[1])+1;
				}
				
				// ssmvf01
				if (count > 5) {
					ui.alert('파일 첨부는 최대 5개까지 가능합니다',{					
						ybt:'확인'	
					});
					return false;
				}
				
				var html = "";
				html += "<div class=\"picture swiper-slide\" id=\"rtnImgArea_"+ count +"\">";
				html += "<input type=\"hidden\" name=\"imgPaths\" value=\""+imageResult.imageToBase64+"\"/>";
				html += "<p class=\"img\">";			
				html += "<img class=\"img\" name=\"claimImg\" id=\"" + imageResult.fileId + "\" src=\"" + imageResult.imageToBase64 + "\" alt=\"사진\">";
				html += "</p>";
				html += "<button type=\"button\" onclick=\"callAppFunc('onDeleteImage',this);\" class=\"remove-btn\" name=\"delImg\" >삭제</button>";
				html += "</div>";			
				$("#rtnImageArea").append(html);
				
				rtnImgCheck();
			},
			appDeleteResultImage : function(result){
				var imageResult = $.parseJSON(result);
				$("#"+imageResult.fileId).parent("p").parent('div').remove();

				rtnImgCheck();
			}
			
		}
		
		// 2021.05.06, ssmvf01
		function onFileUpload(clmNo) {
			callAppFunc('onFileUpload', clmNo);
		}
		
		function callAppFunc(funcNm, obj) {
			console.log(funcNm);
			toNativeData.func = funcNm;
			if(funcNm == 'onOpenGallery'){ // 갤러리 열기
				// 데이터 세팅
				toNativeData.useCamera = "P";
				toNativeData.usePhotoEdit = "N";
				toNativeData.galleryType = "P"
				//미리보기 영역에 선택된 이미지가 있을 경우.------------//
				let fileIds = new Array();
				let fileIdDivs = $("img[name=claimImg]");
				fileIdDivs.each(function(i, v) {
					fileIds[i] = $(this).attr("id");
				})
				toNativeData.fileIds = fileIds;
				//---------------------------------------//
				toNativeData.maxCount = 5;
				/* toNativeData.previewWidth = 188;
				toNativeData.previewHeight = 250; */
				toNativeData.callback = "fileUpload.appResultImage";
				toNativeData.callbackDelete = "fileUpload.appDeleteResultImage";
			}else if(funcNm == 'onDeleteImage'){ // 미리보기 썸네일 삭제
				// 데이터 세팅
				var fileId = $(obj).parent().find("img").attr("id");
							
				$(obj).parent().remove();
				
				// 데이터 세팅
				toNativeData.func = "onDeleteImage";
				toNativeData.fileId = fileId;
				toNativeData.callback = "rtnImgCheck";			
	
			}else if(funcNm == 'onFileUpload'){ // 파일 업로드
				// 데이터 세팅
				toNativeData.func = funcNm;
				toNativeData.prefixPath = "/claim/"+obj;	// 2021.05.06, ssmvf01
				toNativeData.callback = "onFileUploadCallBack";
	
			}else if(funcNm == 'onClose'){ // 화면 닫기
				// 데이터 세팅
				toNativeData.func = funcNm;
	
			}
			// 호출
			toNative(toNativeData);
		}
		
		// 2021.05.06, ssmvf01
		function onFileUploadCallBack(result) {
			var file = JSON.parse(result);
			var clmNo = $("input[name=clmNo]").val();
			var imgPaths = new Array();
			/* file.images[0].filePath */
			if(file.images.length != 0){
				for(var i = 0; i < file.images.length; i++){
					imgPaths.push(file.images[i].filePath);
				}
			}
			
			var options = {
				url : "<spring:url value='/mypage/appClaimImageSave' />"
				, data : { clmNo : clmNo, imgPaths : imgPaths }
				, done : function(result) {
					var formUrl = "/mypage/order/indexReturnCompletion";
					jQuery("<form action=\"" + formUrl + "\" method=\"post\"><input type=\"hidden\" name=\"clmNo\" value=\""+clmNo+"\" /></form>").appendTo('body').submit();
				}
			}
			ajax.call(options);
		}
		
		$(document).on("change", "#inquiryUploadFile", function () {
			waiting.start();
			$('#fileUploadForm').ajaxSubmit({
				url: '/common/fileUploadResult',
				dataType: 'json',
				success: function (result) {
					$("#fileUploadForm").remove();
					waiting.stop();
					fileUpload.callBack(result);
				},
				error: function (xhr, status, error) {
					waiting.stop();						
				}
			});
		});
	</script>
	</tiles:putAttribute>
	<tiles:putAttribute name="content">
		
		<c:if test="${view.deviceGb eq frontConstants.DEVICE_GB_10 }">
			<jsp:include page="/WEB-INF/tiles/include/lnb_my.jsp" />
			<jsp:include  page="/WEB-INF/tiles/include/menubar.jsp" />
		</c:if>
		
		<!-- 바디 - 여기위로 템플릿 -->
		<main class="container lnb page shop my" id="container">	
		
			<div id="order_payment_pay_dialog" style="display:none;" title="결제"></div>
			
			<form id="order_payment_form">
				<input type="hidden" id="ordNo" name="ordNo" value="${orderSO.ordNo}" /> 
				<input type="hidden" id="payAmt" name="payAmt" value="" />
				<input type="hidden" id="goodsNms" name="goodsNms" value="추가배송비" /> 
				<input type="hidden" id="payMeansCd" name="payMeansCd" value="${FrontWebConstants.PAY_MEANS_10}" />
				<input type="hidden" id="ordNm" name="ordNm" value="${order.ordNm}" /> 
				<input type="hidden" id="ordrEmail" name="ordrEmail" value="${order.ordrEmail}" /> 
				<input type="hidden" id="ordrMobile" name="ordrMobile" value="${order.ordrMobile}" /> 
			</form>
			
			<form id="claim_request_list_form" name="claim_request_list_form">
			
				<input type="hidden" id="mngb" name="mngb" value="${mngb}" />
				<input type="hidden" name="ordNo" value="${orderSO.ordNo}" />
				<input type="hidden" name="clmNo" value="" />  <!-- 2021.05.06, ssmvf01  -->
			</form>
			<form id="claim_account_form" name="claim_account_form" method="post"></form>		
				
			<div class="inr">			
				<!-- 본문 -->
				<div class="contents" id="contents">
					<div class="pc-tit">
						<h2>반품신청</h2>
					</div>
					
					<!-- 주문내역 -->
				<form id="return_request_list_form"  name="return_request_list_form">		
					<input type="hidden" id="ordNo" name="ordNo" value="${orderSO.ordNo}" /> 
					<input type="hidden" id="clmTpCd" name="clmTpCd" value="${CommonConstants.CLM_TP_20}"/>
					<input type="hidden" id="checkCode" name="checkCode" value="${checkCode}" />
					<%-- INIpay 결제 인증 리턴값 --%>
					<input type="hidden" id="order_payment_inipay_result" name="inipayStdCertifyInfo" value="" />
			<c:choose>
				<c:when test="${order ne '[]'}">
					<input type="hidden" id="payMeansCd" name="payMeansCd" value="${order.payMeansCd}" />	
					<input type="hidden" id="refundBankAuth" name="refundBankAuth" />
					<input type="hidden" id="orgItemNo" name="orgItemNo" />				
					<div class="oder-cancel border-on step1">
						<ul>
					
					<c:forEach items="${order.orderDetailListVO}" var="orderReturn" varStatus="idx">
				        <c:set value="${orderReturn.ordDtlStatCd}" var="ordDtlStatCd"/>
			            <c:set value="${idx.index}" var="index"/> 
						<c:set value="${orderReturn.rmnOrdQty - orderReturn.rtnQty - orderReturn.clmExcIngQty -  orderReturn.clmExcQty}" var="rmnOrdQty"/>
						<input type="hidden" id="ordDtlSeq${index}" name="arrOrdDtlSeq"  data-mki="${ orderReturn.mkiGoodsYn }" value="${orderReturn.ordDtlSeq}" />	
							<li style="display:${rmnOrdQty eq 0 or orderReturn.clmIngYn eq 'Y' ? 'none;' : 'block'}">
								<div class="untcart step1 <c:if test="${idx1.first}">cancel</c:if>">
									<label class="checkbox">
							<c:choose>
								<c:when test="${orderSO.ordDtlSeq eq orderReturn.ordDtlSeq }">
									<input type="checkbox" id="listCheckReturn${index}" name="arrListCheckReturn" checked="true"><span class="txt"></span>								
								</c:when>
								<c:otherwise>
									<input type="checkbox" id="listCheckReturn${index}" name="arrListCheckReturn"><span class="txt"></span>
								</c:otherwise>
							</c:choose>								
									</label>
									<div class="box">
										<div class="tops">
											<div class="pic">
											<a href="/goods/indexGoodsDetail?goodsId=${not empty orderReturn.pakGoodsId ? orderReturn.pakGoodsId : orderReturn.goodsId }" data-url="/goods/indexGoodsDetail?goodsId=${not empty orderReturn.pakGoodsId ? orderReturn.pakGoodsId : orderReturn.goodsId }">
											<%-- <frame:goodsImage  imgPath="${orderReturn.imgPath}" goodsId="${orderReturn.goodsId}" seq="${orderReturn.imgSeq}" size="${ImageGoodsSize.SIZE_70.size}" gb="" cls ="img" alt="${orderReturn.goodsNm}" /> --%>
											<img src="${fn:indexOf(orderReturn.imgPath, 'cdn.ntruss.com') > -1 ? orderReturn.imgPath : frame:optImagePath(orderReturn.imgPath, frontConstants.IMG_OPT_QRY_270)}" alt="${orderReturn.goodsNm }" class="img">
											</a></div>
											<div class="name">
												<div class="tit">${orderReturn.goodsNm}</div>
												<div class="stt"><frame:num data="${rmnOrdQty}" />개 
												 <c:choose>
													<c:when test="${not empty orderReturn.optGoodsNm}">	<!-- 상품 구성 유형 : 묶음 -->
													| ${fn:replace(orderReturn.optGoodsNm, '/', ' / ')}
													</c:when>
													<c:when test="${not empty orderReturn.pakItemNm}">	<!-- 상품 구성 유형 : 옵션 -->
													| 	${fn:replace(orderReturn.pakItemNm, '|', ' / ')}
													</c:when>
												</c:choose>											
												 </div>
												 <c:if test="${orderReturn.mkiGoodsYn eq 'Y' && not empty orderReturn.mkiGoodsOptContent }">
													<c:forTokens var="optContent" items="${orderReturn.mkiGoodsOptContent }" delims="|" varStatus="conStatus">	
														<div class="stt">각인문구${conStatus.count} : ${optContent}</div>
													</c:forTokens>
												</c:if>
												<input type="hidden" id="orgItemNo${index}" name="arrOrgItemNo" value="${orderReturn.itemNo}" />
												<div class="price">
													<span class="prc"><em class="p"><frame:num data="${orderReturn.saleAmt*rmnOrdQty}" /></em><i class="w">원</i></span>
												</div>
											</div>
										</div>
										<div class="amount">
											<div class="uispiner" data-min="1" data-max="${rmnOrdQty}">
											<input type="hidden" id="arrClmQty${index}" name="arrClmQty" value="0" />											
												<input type="text" value="${rmnOrdQty}" class="amt" disabled="" id="clmQty${index}" name="clmQty" data-saleamt="${orderReturn.saleAmt}" readonly>
												<button type="button" class="bt minus">수량더하기</button>
												<button type="button" class="bt plus">수량빼기</button>
											</div>
										</div>
									</div>
								</div>
							</li>
						</c:forEach>
												
						</ul>
					</div>
				
					<div class="exchange-area pc-reposition">
						<div class="item-box pc-reposition step1">
							<p class="tit">반품 사유 </p>
							<div class="sub-tit">사유 선택</div>
							<div class="flex-wrap t3">
								<input type="hidden" id="clmRsnCd" name="clmRsnCd" />
								<input type="hidden" id="clmRsnType" name="clmRsnType" />
								<div>
						<c:forEach items="${clmRsnList}" var="clmRsn" varStatus="idx1">
						
									<label class="radio">								
										<%-- <c:choose>
									    	<c:when test="${clmRsn.dtlCd == '210' || clmRsn.dtlCd == 280}">on</c:when>									
										    <c:otherwise>nonFix</c:otherwise>
										</c:choose> --%>																															
									<input type="radio" name="radioClmRsnCd" value="${clmRsn.dtlCd }">
									<span class="txt">${clmRsn.dtlNm}</span>
									
									<span class="speech-ballon">
										<c:choose>
										    <c:when test="${clmRsn.dtlCd == '210' || clmRsn.dtlCd == 280}">배송비 구매자 부담</c:when>									
										    <c:otherwise>배송비 판매자 부담 </c:otherwise>
										</c:choose>
									</span>								
									</label>								
							<c:if test="${idx1.index eq 1}">							
								</div>
								<div>							
							</c:if>						
						</c:forEach>							
								</div>
							</div>	
							<!-- <p class="info-t2">옵션(사이즈, 색상 등) 변경을 원하시는 경우는 마이페이지에서 신청이 불가합니다. 고객센터로 연락주시기 바랍니다.</p> -->
							<p class="sub-tit pc-reposition">상세 사유 입력</p>
							<div class="textarea">						
								<textarea placeholder="내용을 입력해주세요." id="clmRsnContent" name="clmRsnContent"></textarea>
							</div>
							<div class="btnSet onMo_b">
								<a href="#" onclick="imageUpload();return false;;" class="btn lg icon">
									사진 첨부하기
								</a>
							</div>						
							<div class="picture-area pc-change-design swiper-container">
								<div class="scroll-box swiper-wrapper" id="rtnImageArea">
									<!-- <div class="picture onWeb_ib swiper-slide">
										<div class="btnSet">
											<a href="#" onclick="ordRtn.imgAddBtn(); return false;" class="btn lg icon" id="btnRtnImage">
												사진 첨부하기
											</a>										
											<input type="file" id="imgAdd_rtn" onclick="ordRtn.imageUpload(); return false;" style="display: none;"/>
										</div>
									</div> -->							
									<div class="picture onWeb_ib swiper-slide">
										<div class="btnSet">
										
										<c:if test="${view.deviceGb eq 'PC' }">
											<a href="#" onclick="imageUpload();return false;" data-content="" data-url="/common/fileUploadResult" class="btn lg icon" id="btnRtnImage">사진 첨부하기</a>
										</c:if>	
										<c:if test="${view.deviceGb eq 'APP' }">		
											<a href="#" onclick="callAppFunc('onOpenGallery', this);" data-content="" data-url="/common/fileUploadResult class="btn lg icon" id="btnRtnImage">사진 첨부하기</a>										
										</c:if>																		
										
										</div>
									</div>								
								</div>
							</div>
							<p class="info-t1 t1">반품 사유를 확인할 수 있는 사진을 등록하시면 보다 신속하게 반품 진행됩니다.</p>
							<p class="info-t1 t1">이미지는 20MB 이내, JPG, JPEG, PNG 파일만 등록 가능합니다. (최대 5장 첨부 가능)</p>
						</div>
						<div class="item-box  pc-reposition step1">
							<p class="tit">수거지</p>
							<input type="hidden" id="adrsNm" name="adrsNm" value="" />
							<input type="hidden" id="mobile" name="mobile" value="" />
							<input type="hidden" id="tel" name="tel" value="" />
							<input type="hidden" id="roadAddr" name="roadAddr" value="" />
							<input type="hidden" id="roadDtlAddr" name="roadDtlAddr" value="" />
							<input type="hidden" id="dlvrMemo" name="dlvrMemo" value="" />
							<input type="hidden" id="postNoNew" name="postNoNew" value="" />
							<input type="hidden" id="postNoOld" name="postNoOld" value="" />
							<input type="hidden" id="prclAddr" name="prclAddr" value="" />
							<input type="hidden" id="prclDtlAddr" name="prclDtlAddr" value="" />
							
							<input type="hidden" id="postNoNewView" name="postNoNewView" value="${deliveryInfo.postNoNew}" />
							<input type="hidden" id="postNoOldView" name="postNoOldView" value="${deliveryInfo.postNoOld}" />
					<%-- 		<input type="hidden" id="prclAddrView" name="prclAddrView" value="${deliveryInfo.prclAddr}" /> --%>
					<%-- 		<input type="hidden" id="prclDtlAddrView" name="prclDtlAddrView" value="${deliveryInfo.prclDtlAddr}" /> --%>
							<div class="sub-tit c1">
								<span id="adrsNmView" name="adrsNmView"><c:out value="${deliveryInfo.gbNm}"/></span> 
					<%--			<a href="#" onclick="goAddressChange('${orderSO.ordNo}');return false;" class="btn sm">변경</a> --%>
							</div>
							<p class="txt-t1 pc-resize-tit">
							
							<c:choose>						
								<c:when test="${deliveryInfo.roadAddr ne null}">
									[<c:out value="${deliveryInfo.postNoNew}"/>] <span id="roadAddrView" name="roadAddrView"><c:out value="${deliveryInfo.roadAddr}"/></span> <span id="roadDtlAddrView" name="roadDtlAddrView"><c:out value="${deliveryInfo.roadDtlAddr}"/></span>
								</c:when>
								<c:otherwise>
									<c:choose>
										<c:when test="${deliveryInfo.prclAddr ne null &&  deliveryInfo.prclAddr ne ''}">
									 		<span id="prclAddrViewDiv" >[<c:out value="${deliveryInfo.postNoOld}"/>] <span id="prclAddrView" name="prclAddrView"><c:out value="${deliveryInfo.prclAddr}"/></span> <span id="prclDtlAddrView" name="prclDtlAddrView"><c:out value="${deliveryInfo.prclDtlAddr}"/></span></span>
										</c:when>
										<c:otherwise>
									 		<span id="prclAddrViewDiv" style="display: none;">[<c:out value="${deliveryInfo.postNoOld}"/>] <span id="prclAddrView" name="prclAddrView"></span> <span id="prclDtlAddrView" name="prclDtlAddrView"><c:out value="${deliveryInfo.prclDtlAddr}"/></span></span>
										</c:otherwise>
									</c:choose>
								</c:otherwise>
							</c:choose>
									
							</p>
							<p class="txt-t2 pc-resize-tit"><span id="adrsNmView" name="adrsNmView"><c:out value="${deliveryInfo.adrsNm}"/></span> / <span id="mobileView" name="mobileView"><frame:mobile data="${deliveryInfo.mobile}"/></span></p>
							<p class="txt-t2 pc-resize-tit"><span id="dlvrMemoView" name="dlvrMemoView"><c:out value="${deliveryInfo.dlvrMemo}"/></span></p>
						</div>
						<!-- step2 반품비용 확인 추가 -->
						<div class="item-box pc-reposition step2" style="border-top:0px; display:none;">
						<p class="tit">반품비용 확인</p>
							<div class="price-area">
								<div class="gray-box t02">
									<div class="list">
										<ul>
											<li>
												<p class="txt1">반품 배송비</p>
												<p class="txt3"><span id="clmDlvrcAmt2">0</span>원</p>
											</li>
											<li id="extraDlvrcPayMethod">
												<p class="txt1">결제방법</p>
												<p class="txt2"><span id=refundType>환불 금액에서 차감</span></p>
											</li>
										</ul>
									</div>
								</div>
							</div>
						</div>
						
						<div class="item-box pc-reposition step2" style="display:none;">
							<p class="tit">예상 환불 금액</p>
							<div class="price-area" id="price_area">
								<ul class="addPoint delivery mb0">
									<li id="allRefundPay" class="ttl"><span>환불 금액</span>	<span class="savePoint"></span></li>
									<li id="mainRefundPay" style="display: none;"><span></span>			<span class="savePoint"></span></li>
									<li id="gsRefundPay" style="display: none;"><span>GS&POINT 환불</span>				<span class="savePoint"></span></li>
									<li id="mpRefundPay" style="display: none;"><span>우주코인 환불</span>				<span class="savePoint"></span></li>
									<li id="miRefundPay" style="display: none;"><span>추가 결제금액 환불</span>				<span class="savePoint"></span></li>
									<li id="minusPay" style="display: none"><span>추가 결제금액</span>				<span class="savePoint"></span></li>
								</ul>
								
								<div class="list" id="refundAmt" ${prcAreaDisplayStyle }>
									<ul>
										<li>
											<p class="txt1">상품금액</p>   
											<p class="txt2"><span id="goodsAmt"></span>원</p> 
										</li>
										<li>
											<p class="txt1">배송비</p>
											<p class="txt2"><span id="orgDlvrcAmt"></span>원</p>
										</li>
										<li>
											<p class="txt1">쿠폰 할인</p>
											<p class="txt2" id="cpDcAmtli"><span id="cpDcAmtPre"></span><span id="cpDcAmt"></span>원</p>
										</li>
										<c:if test="${not empty payMpVO and not empty payMpVO.addUsePnt and payMpVO.addUsePnt gt 0}">
											<li>
												<p class="txt1">우주코인 추가할인</p>
												<p class="txt2 color" id="mpAddUsePnt"></p>  <!-- mpAddUsePnt-->
											</li>
										</c:if>
										<li>
											<p class="txt1">추가 배송비 
												<span class="alert_pop" data-pop="popCpnGud">

													<span class="bubble_txtBox" style="width:267px;">
														<span class="tit">추가 배송비</span>
														<span class="info-txt">
															<span>
																<span>
																	취소/반품/교환 시 발생한 배송비 금액입니다.
																</span>
																<span>
																	도서/산간지역의 경우 반품/교환 시 추가 배송비가 발생할 수 있습니다.
																</span>
																<span>
																	취소/반품/교환으로 인해 무료배송 조건이 충족되지 못할경우 배송비가 추가로 발생할 수 있습니다.
																</span>
															</span>
														</span>
													</span>
												</span>
											</p>
											<p class="txt2 color" id="clmDlvrcAmt">0원</p>
										</li>

									</ul>
								</div>
							</div>						
						</div>
					
					<c:if test="${order.payMeansCd eq FrontWebConstants.PAY_MEANS_30 or order.payMeansCd eq FrontWebConstants.PAY_MEANS_40}">	
						<div class="item-box pc-reposition step1">
							<p class="tit">환불 계좌 입력</p>
							<div class="member-input">
								<ul class="list">
									<li>
										<strong class="tit ">예금주</strong>
										<div class="input disabled">										
											<input type="text" title="예금주" id="ooaNm" name="ooaNm" onkeyup="specialCharlength(this);return false;" value="${session.mbrNo eq FrontWebConstants.NO_MEMBER_NO ? '' : session.mbrNm }">
										</div>
									</li>
									<li>
										<strong class="tit">은행선택</strong>
										<div class="select">									
											<select title="은행명선택" id="bankCd" name="bankCd">
												<frame:selectOption items="${bankCdList}" all="true" defaultName="선택" selectKey="${member.bankCd }"/>
											</select>										
										</div>
									</li>
									<li>
										<strong class="tit">계좌번호</strong>
										<div class="input flex" id="btnAccountChk">										
											<input type="text" title="계좌번호" placeholder="-없이 번호만 입력" id="acctNo" name="acctNo" onkeyup="NumberOnly(this);return false;" value="${member.acctNo }">
											<a href="#" class="btn md" data-content="${session.mbrNo }" data-url="/mypage/order/getAccountName" disabled>계좌인증</a>
										</div>
									</li>
								</ul>
							</div>							
						</div>
					</c:if>
					<c:if test="${(not empty payInfo.payMeansCd and payInfo.payMeansCd ne FrontWebConstants.PAY_MEANS_00 and payInfo.payMeansCd ne FrontWebConstants.PAY_MEANS_30)}">
						<div class="item-box pc-reposition last step2" style="display:none;">
							<p class="tit">환불수단</p>
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
										<span>일반결제</span><frame:codeValue items="${payMeansCdList}" dtlCd="${payInfo.payMeansCd}" />
									</c:when>
								</c:choose>		
								<c:if test="${payInfo.payMeansCd ne null and payInfo.payMeansCd ne FrontWebConstants.PAY_MEANS_00 and payInfo.payMeansCd ne FrontWebConstants.PAY_MEANS_30}">
									<br>
								</c:if>
								<%-- <c:if test="${payInfo.svmnAmt ne null and payInfo.svmnAmt ne 0}">
									<span>일반결제</span>포인트
								</c:if>	 --%>			
							</p>
						</div>
					</c:if>
						<div class="info-txt t2 pc-reposition step2" style="display:none;">						
							<ul>
								<li>반품은 상품 수거 후 상품 이상 유무를 확인한 뒤 주문 시 결제 수 단으로 환불됩니다.</li>
								<li>가상계좌 결제의 경우 입력하신 환불 계좌로 환불 됩니다.</li>
								<li>판매자 과실 사유로 인한 교환/반품은 비용 발생 없이 처리됩니다. </li>
								<li>판매자 과실 사유로 인한 교환/반품 신청 후 상품에 이상이 없을 경우 반송 처리 될 수 있으며, 배송비를 입금해주셔야 합니다.</li>
								<li>사은품이 있을 경우 같이 반송해야하며 사은품 누락 시 교환/반품이 불가할 수 있습니다.</li>
							</ul>												
						</div>					
						<div class="btnSet space pc-reposition" id="btnSetlast">
							<a href="#" data-content="" data-url="/mypage/order/indexClaimList" onclick="searchClaimRequestList();return false;" class="btn lg d" id="btnCancle">취소</a>						
						</div>
					</div>
				</c:when>
				<c:otherwise>	
					<div>
						반품 가능한 주문내역이 없습니다.
					</div>
				</c:otherwise>
			</c:choose>	
			
					</form>	
						
					
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
							<h1 class="tit">이용안내</h1>
							<button type="button" class="btnPopClose">닫기</button>
						</div>
					</div>
					<div class="pct">
						<main class="poptents">
							<ul class="tplist">
								<li>취소/반품/교환 시 발생한 배송비 금액입니다.</li>
								<li>도서/산간지역의 경우 반품/교환 시 추가 배송비가 발생할 수 있습니다.</li>
								<li>취소/반품/교환으로 인해 무료배송 조건이 충족되지 못할경우 배송비가 추가로 발생할 수 있습니다.</li>
							</ul>
						</main>
					</div>
				</div>
			</article>
		</div>
		<!-- 바디 - 여기 밑으로 템플릿 -->
	
	</tiles:putAttribute>
	</tiles:insertDefinition>
		