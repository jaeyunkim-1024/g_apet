<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="/WEB-INF/tld/frame.tld" prefix="frame" %> 
<%@ page import="front.web.config.constants.FrontWebConstants" %> 
<%@ page import="framework.common.constants.CommonConstants" %>
<%@ page import="framework.common.enums.ImageGoodsSize" %>

<script type="text/javascript">
	var claimRefundVO;

	$(document).ready(function(){
		claimRefundVO = new Object();
	}); // End Ready

	$(function() { 
		//결제금액 계산 및 계좌입력 초기화 
		initCalculation();
		// 반품안내 확인 초기화
		$("input:checkbox[name=checkAgree]").prop("checked", false);
		$("#clmRsnCd").val("");
		getClaimRefundExcpect();
		$("#payAmt").val(0);

		dialog.create("order_payment_pay_dialog" , {width: 850, height:637, modal:true});
		
		$("#order_payment_pay_dialog").prev(".ui-dialog-titlebar").children("button").click(function(){
			inipay.close("B");
		});
	});
	
	//초기값 설정
	function initCalculation(){
		$("#paymentAmt").html("<strong>0</strong>원");  
		$("#goodsAddAmt").html("<strong>0</strong>원");
		$("#goodsTotalAmt").html("<strong>0</strong>원");
		$("#goodsAmt").html(0);
		$("#orgDlvrcAmt").html(0);
		$("#cpDcAmt").html(0);
		$("#clmDlvrcAmt").html(0);
		$("#refundAmt").html("");
	}
	   
	function setClmQty() {		
		var arrClmQty = $("input[name=arrClmQty]");		
		for(var i=0; i <arrClmQty.length; i++){
			$("#arrClmQty"+i).val(parseInt($("#clmQty"+i).val()));
		}
	}
	
	/*
    * 환불예상금액계산
    */
	function getClaimRefundExcpect() {
		if (!clmQtyCheck()) {
			return;
		} else if (!clmRsnCdCheck()) {
			return;
		}
		
		setClmQty();
		
		var options = {
				url : "<spring:url value='/mypage/order/getClaimRefundExcpect' />"
				, data : $("#return_request_list_form").serializeArray()
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
		$("#orgDlvrcAmt").html(0);
		var refundAmtHtml = "";

		paymentAmt += parseInt(claimRefundVO.goodsAmt);
		$("#goodsAmt").html(fnComma(claimRefundVO.goodsAmt));
		
		if (claimRefundVO.orgDlvrcAmt != undefined && claimRefundVO.orgDlvrcAmt > 0) {
			paymentAmt += parseInt(claimRefundVO.orgDlvrcAmt);
			$("#orgDlvrcAmt").html(fnComma(claimRefundVO.orgDlvrcAmt));
		}
		if (claimRefundVO.cpDcAmt != undefined && claimRefundVO.cpDcAmt > 0) {
			paymentAmt -= parseInt(claimRefundVO.cpDcAmt);
			$("#cpDcAmt").html(fnComma(claimRefundVO.cpDcAmt));
			$("#cpDcAmtPre").text("(-)");
		}
		$("#paymentAmt").html("<strong>"+fnComma(paymentAmt)+"</strong>원") ;  

		if (claimRefundVO.orgDlvrcAmt != undefined && claimRefundVO.orgDlvrcAmt < 0) {
			addAmt += parseInt(Math.abs(claimRefundVO.orgDlvrcAmt));
		}
		
		if (claimRefundVO.clmDlvrcAmt != undefined && claimRefundVO.clmDlvrcAmt > 0) {
			addAmt += parseInt(claimRefundVO.clmDlvrcAmt);
		}
		$("#clmDlvrcAmt").html(fnComma(addAmt));
		$("#goodsAddAmt").html("<strong>"+fnComma(addAmt)+"</strong>원") ;
		
		var meansList = claimRefundVO.meansList;
		$(meansList).each(function(i) {			
			refundAmtHtml+="<dl>";
			refundAmtHtml+="	<dt>" + meansList[i].meansNm + "</dt>";
			refundAmtHtml+="	<dd>";
			refundAmtHtml+="		<span>" + fnComma(meansList[i].refundAmt) + "</span> 원<br />";
			refundAmtHtml+="	</dd>";
			refundAmtHtml+="</dl>";
        });
		$("#refundAmt").append(refundAmtHtml);
		$("#goodsTotalAmt").html("<strong>"+fnComma(claimRefundVO.totAmt)+"</strong>원") ;
		
		$("#refundAcctInfoAll").show();
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
		pop.popupDeliveryAddressEdit(params);
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
		var rpAppChecked = $("input:checkbox[name=checkAgree]").is(":checked"); 

		if (!clmQtyCheck()) {
			alert('<spring:message code="front.web.view.claim_return.msg.clmQty" />');
			return;
		} else if (!clmRsnCdCheck()) {
			alert('<spring:message code="front.web.view.claim_return.msg.clmRsnCd" />');
			$("#clmRsnCd").focus();
			return;
		} else if (!payMeansCdCheck()) {
    		return;
    	}
		
		if(rpAppChecked){               //주문동의 여부    
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
		}  
	}	
	
	function insertAccess(){
		var mbrNo = '${session.mbrNo}';
		var url = "<spring:url value='/mypage/insertClaimCancelExchangeRefund' />";
		var formUrl = "/mypage/order/indexReturnCompletion";
		
		if ("${session.mbrNo}" == "${FrontWebConstants.NO_MEMBER_NO}") {
			url = "<spring:url value='/mypage/noMemberInsertClaimCancelExchangeRefund' />";
		}
		
		var options = {
				url : url
				, data : $("#return_request_list_form").serialize()
				, done : function(data){
					if(data != null){
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
			totClmQty += parseInt($("#clmQty"+i).val());
		}
		
		if (totClmQty ==0) {
			return false;
		}

  		return true
	}
  
	function clmRsnCdCheck() {
		if($("#clmRsnCd").val() == ""){
			return false;
		}
    	
  		return true
  	}
  
    // 결제 수단 코드 체크
    function payMeansCdCheck() {
    	var payMeansCd = $("#return_request_list_form #payMeansCd").val();
    	//결제 수단코드 실시간계좌이체 : "20", 가상계좌 : "30", 무통장 : "40" 일 경우
  		if(payMeansCd == "${FrontWebConstants.PAY_MEANS_20}" || payMeansCd == "${FrontWebConstants.PAY_MEANS_30}" 
  				|| payMeansCd == "${FrontWebConstants.PAY_MEANS_40}"){
			if($("#ooaNm").val()==""){
  				alert('<spring:message code="front.web.view.claim.msg.refund_ooaNm" />');
  				$("#ooaNm").focus();
  				return false;
  			} 
  			if($("#bankCd").val()==""){
  				alert('<spring:message code="front.web.view.claim.msg.refund_bankCd" />');
  				$("#bankCd").focus();
  				return false;
  			}
  			if($("#acctNo").val()==""){
  				alert('<spring:message code="front.web.view.claim.msg.refund_acctoNo" />');
  				$("#acctNo").focus();
  				return false;
  			} 
  		}
    	
  		return true;
    }

	/*
	 * 취소, 교환, 반품 조회 화면 리로딩
	 */
	function searchClaimRequestList(){
		$("#claim_request_list_form").attr("target", "_self");
		$("#claim_request_list_form").attr("action", "/mypage/order/indexClaimRequestList");
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
				message : '결제가 취소되었습니다.' 					
			};
			$("#order_payment_pay_dialog").html("");
			

			inipay.cbResult(data, type);
		}	
	}
</script>

<div id="order_payment_pay_dialog" style="display:none;" title="결제">
</div>

<form id="order_payment_form">
	<input type="hidden" id="ordNo" name="ordNo" value="${orderSO.ordNo}" /> 
	<input type="hidden" id="payAmt" name="payAmt" value="" />
	<input type="hidden" id="goodsNms" name="goodsNms" value="추가배송비" /> 
	<input type="hidden" id="payMeansCd" name="payMeansCd" value="${FrontWebConstants.PAY_MEANS_10}" />
	<input type="hidden" id="ordNm" name="ordNm" value="${order.ordNm}" /> 
	<input type="hidden" id="ordrEmail" name="ordrEmail" value="${order.ordrEmail}" /> 
	<input type="hidden" id="ordrMobile" name="ordrMobile" value="${order.ordrMobile}" /> 
</form>

<div class="box_title_area">
	<h3>반품신청</h3>
	<div class="sub_text2">반품하실 상품을 확인하신 후 반품수량과 사유를 선택하세요.</div>
</div>

<div class="order_number_box mgt10">
	<dl>
		<dt>주문번호</dt>
		<dd>
			<strong class="point2">${orderSO.ordNo}</strong>
		</dd>
	</dl>
</div>
<form id="claim_request_list_form" name="claim_request_list_form"></form>

<!-- 주문내역 -->
<form id="return_request_list_form"  name="return_request_list_form">
	<input type="hidden" id="ordNo" name="ordNo" value="${orderSO.ordNo}" /> 
	<input type="hidden" id="clmTpCd" name="clmTpCd" value="${CommonConstants.CLM_TP_20}"/>
	<input type="hidden" id="checkCode" name="checkCode" value="${checkCode}" />
	<%-- INIpay 결제 인증 리턴값 --%>
	<input type="hidden" id="order_payment_inipay_result" name="inipayStdCertifyInfo" value="" />
	
	<table class="table_cartlist1 mgt20">
		<caption>주문내역</caption>
		<colgroup>
			<col style="width:70px">
			<col style="width:auto">
			<col style="width:15%">
			<col style="width:15%">
			<col style="width:15%">
			<col style="width:15%">
		</colgroup>
		<thead>
			<tr>
				<th scope="col" colspan="2">상품정보</th>
				<th scope="col">판매가</th>
				<th scope="col">수량</th>
				<th scope="col">반품수량</th>
				<th scope="col">배송/판매자</th>
			</tr>
		</thead>
		<tbody>
		    <c:choose>
				<c:when test="${order ne '[]'}">
					<input type="hidden" id="payMeansCd" name="payMeansCd" value="${order.payMeansCd}" />
			        <c:forEach items="${order.orderDetailListVO}" var="orderReturn" varStatus="idx">
				        <c:set value="${orderReturn.ordDtlStatCd}" var="ordDtlStatCd"/>
			            <c:set value="${idx.index}" var="index"/> 
						<c:set value="${orderReturn.rmnOrdQty - orderReturn.rtnQty - orderReturn.clmExcIngQty}" var="rmnOrdQty"/>
						<input type="hidden" id="ordDtlSeq${index}" name="arrOrdDtlSeq"  value="${orderReturn.ordDtlSeq}" /> 
					<tr>
						<td class="img_cell v_top"><a href="/goods/indexGoodsDetail?goodsId=<c:out value="${orderReturn.goodsId}"/>"><frame:goodsImage imgPath="${orderReturn.imgPath}" goodsId="${orderReturn.goodsId}" seq="${orderReturn.imgSeq}" size="${ImageGoodsSize.SIZE_70.size}" gb="" /></a></td>
						<td class="align_left v_top">
							<div class="product_name">
								<a href="#">[${orderReturn.bndNmKo}] ${orderReturn.goodsNm}(<frame:num data="${rmnOrdQty}" />개)</a> 
								<div class="product_option">
									<span>${orderReturn.itemNm}</span>
									<input type="hidden" id="orgItemNo" name="orgItemNo" value="${orderReturn.itemNo}" />
								</div>
							</div>
						</td>
						<td>
						     <frame:num data="${orderReturn.saleAmt - orderReturn.prmtDcAmt}" />원
						</td><td><frame:num data="${rmnOrdQty}" /></td>
						<td>
							<input type="hidden" id="arrClmQty${index}" name="arrClmQty" value="0" />
							<select class="select1" title="수량선택" id="clmQty${index}" name="clmQty" onchange="getClaimRefundExcpect();return false;">
								<option value="0" >선택</option>
								<c:forEach var="i" begin="1" end="${rmnOrdQty}" step="1" varStatus="idx">
									<option value="${i}">${i}</option>
								</c:forEach>
							</select>
						</td>
						<td>${orderReturn.compNm}</td> 
					</tr> 
					<tr>
						<td colspan="6" class="pd0">
							<table class="table_cartlist1_add">
								<caption>신청</caption>
								<colgroup>
									<col style="width:100px;" />
									<col />
								</colgroup>
								<tbody>
									<tr>
										<th>
											반품 사유*
										</th>
										<td>
											<select title="반품사유선택" class="order_cancel_slt" id="clmRsnCd" name="clmRsnCd" onchange="getClaimRefundExcpect();return false;">
												<option value="">선택하세요</option> 
												<frame:selectOption items="${clmRsnList}" all="true" /> 
											</select>
										</td>
									</tr>
								</tbody>
							</table>
						</td>
					</tr>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<tr>
						<td colspan="5" class="nodata">취소/교환/반품 가능한 주문내역이 없습니다.</td>
					</tr>
				</c:otherwise>
			</c:choose>
		</tbody>
	</table>
	
<!-- 	<table class="table_cartlist1 mgt30"> -->
<%-- 		<caption>주문내역</caption> --%>
<%-- 		<colgroup> --%>
<%-- 			<col style="width:15%">	 --%>
<%-- 			<col style="width:15%"> --%>
<%-- 			<col style="width:auto"> --%>
<%-- 			<col style="width:20%"> --%>
<%-- 			<col style="width:10%"> --%>
<%-- 		</colgroup> --%>
<!-- 		<thead> -->
<!-- 			<tr> -->
<!-- 				<th scope="col">받는사람</th> -->
<!-- 				<th scope="col">연락처</th> -->
<!-- 				<th scope="col">주소</th> -->
<!-- 				<th scope="col">배송메시지</th> -->
<!-- 				<th scope="col">반품 수거지</th> -->
<!-- 			</tr> -->
<!-- 		</thead> -->
<!-- 		<tbody> -->
<!-- 			<input type="hidden" id="adrsNm" name="adrsNm" value="" /> -->
<!-- 			<input type="hidden" id="mobile" name="mobile" value="" /> -->
<!-- 			<input type="hidden" id="tel" name="tel" value="" /> -->
<!-- 			<input type="hidden" id="roadAddr" name="roadAddr" value="" /> -->
<!-- 			<input type="hidden" id="roadDtlAddr" name="roadDtlAddr" value="" /> -->
<!-- 			<input type="hidden" id="dlvrMemo" name="dlvrMemo" value="" /> -->
<!-- 			<input type="hidden" id="postNoNew" name="postNoNew" value="" /> -->
<!-- 			<input type="hidden" id="postNoOld" name="postNoOld" value="" /> -->
<!-- 			<input type="hidden" id="prclAddr" name="prclAddr" value="" /> -->
<!-- 			<input type="hidden" id="prclDtlAddr" name="prclDtlAddr" value="" /> -->
			
<%-- 			<input type="hidden" id="postNoNewView" name="postNoNewView" value="${deliveryInfo.postNoNew}" /> --%>
<%-- 			<input type="hidden" id="postNoOldView" name="postNoOldView" value="${deliveryInfo.postNoOld}" /> --%>
	<%-- 		<input type="hidden" id="prclAddrView" name="prclAddrView" value="${deliveryInfo.prclAddr}" /> --%>
	<%-- 		<input type="hidden" id="prclDtlAddrView" name="prclDtlAddrView" value="${deliveryInfo.prclDtlAddr}" /> --%>
<!-- 			<tr> -->
<%-- 				<td><span id="adrsNmView" name="adrsNmView"><c:out value="${deliveryInfo.adrsNm}"/></span></td> --%>
<%-- 				<td><div><span id="mobileView" name="mobileView"><frame:mobile data="${deliveryInfo.mobile}"/></span></div> --%>
<%-- 					<c:if test="${deliveryInfo.tel ne null &&  deliveryInfo.tel ne ''}"> --%>
<%-- 					 	<div><span id="telView" name="telView"><frame:tel data="${deliveryInfo.tel}"/></span></div> --%>
<%-- 					</c:if> --%>
<!-- 				</td> -->
<!-- 				<td>  -->
<%-- 					<c:if test="${deliveryInfo.roadAddr ne null}"> --%>
<%-- 						<div>[도로명주소] <span id="roadAddrView" name="roadAddrView"><c:out value="${deliveryInfo.roadAddr}"/></span> <span id="roadDtlAddrView" name="roadDtlAddrView"><c:out value="${deliveryInfo.roadDtlAddr}"/></span></div> --%>
<%-- 					</c:if> --%>
<%-- 					<c:choose> --%>
<%-- 						<c:when test="${deliveryInfo.prclAddr ne null &&  deliveryInfo.prclAddr ne ''}"> --%>
<%-- 					 		<div id="prclAddrViewDiv" >[지번주소] <span id="prclAddrView" name="prclAddrView"><c:out value="${deliveryInfo.prclAddr}"/></span> <span id="prclDtlAddrView" name="prclDtlAddrView"><c:out value="${deliveryInfo.prclDtlAddr}"/></span></div> --%>
<%-- 						</c:when> --%>
<%-- 						<c:otherwise> --%>
<%-- 					 		<div id="prclAddrViewDiv" style="display: none;">[지번주소] <span id="prclAddrView" name="prclAddrView"></span> <span id="prclDtlAddrView" name="prclDtlAddrView"><c:out value="${deliveryInfo.prclDtlAddr}"/></span></div> --%>
<%-- 						</c:otherwise> --%>
<%-- 					</c:choose> --%>
<!-- 				</td> -->
<%-- 				<td><span id="dlvrMemoView" name="dlvrMemoView"><c:out value="${deliveryInfo.dlvrMemo}"/></span></td> --%>
<!-- 				<td> -->
<%-- 					<a href="#" class="btn_h20_type5" onclick="goAddressChange('${orderSO.ordNo}');return false;">변경</a> --%>
<!-- 				</td> -->
<!-- 			</tr> -->
<!-- 		</tbody> -->
<!-- 	</table> -->
	
	<div class="mgt30">
		<div class="box_title_area">
			<h3>반품 수거지</h3>&emsp;* 반품 접수 후 업체에서 수거지시를 하며, 1~3영업일 내 택배 기사님이 방문할 예정입니다.
			<div class="btn_area f_right">
				<a href="#" class="btn_h20_type5" onclick="goAddressChange('${orderSO.ordNo}');return false;">변경</a>
			</div>
		</div>
		<table class="table_type1">
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
			<colgroup>
				<col style="width:20%">
				<col style="width:80%">
			</colgroup>
			<tbody>
				<tr>
					<th>받으시는 분</th>
					<td><span id="adrsNmView" name="adrsNmView"><c:out value="${deliveryInfo.adrsNm}"/></span></td>
				</tr>
				<tr>
					<th>연락처</th>
					<td><div><span id="mobileView" name="mobileView"><frame:mobile data="${deliveryInfo.mobile}"/></span></div>
						<c:if test="${deliveryInfo.tel ne null &&  deliveryInfo.tel ne ''}">
						 	<div><span id="telView" name="telView"><frame:tel data="${deliveryInfo.tel}"/></span></div>
						</c:if>
					</td>
				</tr>
				<tr>
					<th>배송주소</th>
					<td> 
						<c:if test="${deliveryInfo.roadAddr ne null}">
							<div>[도로명주소] <span id="roadAddrView" name="roadAddrView"><c:out value="${deliveryInfo.roadAddr}"/></span> <span id="roadDtlAddrView" name="roadDtlAddrView"><c:out value="${deliveryInfo.roadDtlAddr}"/></span></div>
						</c:if>
						<c:choose>
							<c:when test="${deliveryInfo.prclAddr ne null &&  deliveryInfo.prclAddr ne ''}">
						 		<div id="prclAddrViewDiv" >[지번주소] <span id="prclAddrView" name="prclAddrView"><c:out value="${deliveryInfo.prclAddr}"/></span> <span id="prclDtlAddrView" name="prclDtlAddrView"><c:out value="${deliveryInfo.prclDtlAddr}"/></span></div>
							</c:when>
							<c:otherwise>
						 		<div id="prclAddrViewDiv" style="display: none;">[지번주소] <span id="prclAddrView" name="prclAddrView"></span> <span id="prclDtlAddrView" name="prclDtlAddrView"><c:out value="${deliveryInfo.prclDtlAddr}"/></span></div>
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
				<tr>
					<th>배송메세지</th>
					<td><span id="dlvrMemoView" name="dlvrMemoView"><c:out value="${deliveryInfo.dlvrMemo}"/></span></td>
				</tr>
			</tbody>
		</table>
	</div>

	<div class="mgt30" >
		<div class="box_title_area">
			<h3>환불예상금액</h3>
		</div>
		<div class="price_area">
			<div class="total_price">
				<table>
					<caption>총 결제 금액</caption>
						<colgroup>
							<col style="width:33%" />
							<col style="width:33%" />
							<col style="width:auto" />
						</colgroup>
						<thead>									
						<tr>
							<th scope="col">반품금액</th>
							<th scope="col" style="border-left:1px solid #dadada;">차감금액</th>
							<th scope="col">환불예정금액</th>
						</tr>
						</thead>
						<tbody>
						<tr>
							<td class="cost_cell border_other">
								<div class="posr">
									<span id="paymentAmt"></span> 
								</div>
							</td>
							<td class="cost_cell font_red">
								<div class="posr">
									<span class="icon_plus"><img src="<c:out value='${view.imgComPath}' />/common/total_count_th3.png" alt="-"></span>
									<span id="goodsAddAmt"></span>
								</div>
							</td>
							<td class="cost_cell">
								<div class="posr">
									<span class="icon_plus"><img src="<c:out value='${view.imgComPath}' />/common/total_count_th2.png" alt="="></span>
									<span id="goodsTotalAmt"></span>
								</div>
							</td>
						</tr> 
						<tr class="detail_cell">
							<td>
								<dl>
									<dt>상품금액</dt>
									<dd><span id="goodsAmt"></span> 원</dd>
								</dl>
								<dl>
									<dt>쿠폰할인</dt>
									<dd><span id="cpDcAmtPre"></span> <span id="cpDcAmt"></span> 원</dd>
								</dl>
								<dl>
									<dt>배송비</dt>
									<dd><span id="orgDlvrcAmt"></span> 원</dd>
								</dl>
							</td>
							<td>
								<dl>
									<dt>추가배송비</dt>
									<dd><span id="clmDlvrcAmt"></span> 원</dd>
								</dl>
							</td>
							<td id="refundAmt">
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<div class="mgt10" style="text-align: right;">* 부분취소/환불 시 최종 주문 금액이 할인 쿠폰 적용 기준을 충족하지 못할 경우, 환불 금액에서 쿠폰할인액이 차감됩니다.</div>
		<!-- //환불 예상 금액 -->
			
		<c:if test="${order.payMeansCd eq FrontWebConstants.PAY_MEANS_30 or order.payMeansCd eq FrontWebConstants.PAY_MEANS_40}">
			<!-- 환불계좌정보 -->
			<div class="mgt30">
				<div id="refundAcctInfo">
					<div class="box_title_area">
					<h3>환불 계좌정보</h3>
					</div>
					<table class="table_type1">
						<colgroup>
							<col style="width:20%">
							<col style="width:80%">
						</colgroup>
						<tbody>
							<tr>
								<th>환불계좌정보</th>
								<td>
									<div>
										<span class="label_tit_w50">예금주</span>
										<input type="text" title="예금주" style="width:151px;" id="ooaNm" name="ooaNm" onkeyup="specialCharRemoveSpace(this);return false;" value="${session.mbrNo eq FrontWebConstants.NO_MEMBER_NO ? '' : session.mbrNm }">
									</div>
									<div class="mgt10">
										<span class="label_tit_w50">계좌번호</span>
										<select class="select_type1" title="은행명선택" id="bankCd" name="bankCd">
											<frame:selectOption items="${bankCdList}" all="true" defaultName="선택" selectKey="${member.bankCd }"/> 
										</select>
										<input type="text" class="mgl6" title="계좌번호" style="width:151px;" id="acctNo" name="acctNo" onkeyup="NumberOnly(this);return false;" value="${member.acctNo }">
									</div>
									<div class="point3 mgt10">* 환불계좌정보가 실제정보와 일치하지 않을 경우 환불이 지연될 수 있으니 정확한 정보를 기재해 주시기 바랍니다.</div>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<!-- //환불계좌정보 --> 
			</c:if>
	
			<div class="note_box1 mgt30">
				<ul class="ul_list_type1">
					<li>반품은 배송완료 후 7일 이내 가능하며, 선택하신 반품사유에 따라 반품배송비가 발생될 수 있습니다.</li>
					<li>판매자귀책(제품하자, 오배송 등) 으로 요청 하셨더라도 상품 확인 결과에 따라 배송비가 차감 될 수 있습니다.</li>
					<li>포장 및 상품훼손, 또는 사용 여부에 따라 반품 및 환불이 어려울 수 있습니다.</li>
					<li>환불 불가한 경우에 대한 상세 내용은 [상품페이지-배송/교환/환불] 에서 확인 가능합니다.</li>
					<li>사은품 등이 포함되었을 경우, 함께 반품해 주셔야 합니다. </li>
					<li>환불은 반품완료 후 1~2영업일 내 처리됩니다.</li>
				</ul>
			</div>
			
			<div class="mgt15 pdl5">
				<label class="mgl10"><input type="checkbox" id="checkAgree" name="checkAgree"/> <strong class="point4">반품 안내 사항을 확인하였습니다.</strong></label>
			</div>
			<div class="btn_area_center mgt40">
				<a href="#" class="btn_h60_type1" onclick="insertReturnRequestList();return false;">반품신청하기</a>
				<a href="#" class="btn_h60_type2 mgl6" onclick="searchClaimRequestList();return false;">취소</a>
			</div>
		</div> 
	</div>
</form>
