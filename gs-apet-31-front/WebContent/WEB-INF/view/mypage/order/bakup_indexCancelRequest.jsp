<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="/WEB-INF/tld/frame.tld" prefix="frame" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page import="front.web.config.constants.FrontWebConstants" %> 
<%@ page import="framework.common.constants.CommonConstants" %>
<%@ page import="framework.common.enums.ImageGoodsSize" %>

<script type="text/javascript">
	var claimRefundVO;

	$(document).ready(function(){ 
		claimRefundVO = new Object();
	}); // End Ready

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
	});
	
	//초기값 설정
	function initCalculation(){
		$("#paymentAmt").html("<strong>0</strong>원");  
		$("#goodsAddAmt").html("<strong>0</strong>원");
		$("#goodsTotalAmt").html("<strong>0</strong>원");
		$("#goodsAmt").html(0) ;
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
		$("#goodsAmt").html(fnComma(claimRefundVO.goodsAmt));
		
		if (claimRefundVO.orgDlvrcAmt != undefined && claimRefundVO.orgDlvrcAmt > 0) {
			paymentAmt += parseInt(claimRefundVO.orgDlvrcAmt);
			$("#orgDlvrcAmt").html(fnComma(claimRefundVO.orgDlvrcAmt));
		}
		if (claimRefundVO.cpDcAmt != undefined && claimRefundVO.cpDcAmt > 0) {
			paymentAmt -= parseInt(claimRefundVO.cpDcAmt);
			$("#cpDcAmt").html(fnComma(claimRefundVO.cpDcAmt));
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
	}
     
	//신청하기 button
	function insertCancelList(){
		if (!clmQtyCheck()) {
			alert('<spring:message code="front.web.view.claim_cancel.msg.clmQty" />');
			return;
		} else if (!clmRsnCdCheck()) {
			alert('<spring:message code="front.web.view.claim_cancel.msg.clmRsnCd" />');
			$("#clmRsnCd").focus();
			return;
		} else if (!payMeansCdCheck()) {
    		return;
    	}

		var exAppChecked = $("input:checkbox[name=checkAgree]").is(":checked");
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
		}
	}

	function insertAccess(){
		var url = "<spring:url value='/mypage/insertClaimCancelExchangeRefund' />";

		if ("${session.mbrNo}" == "${FrontWebConstants.NO_MEMBER_NO}") {
			url = "<spring:url value='/mypage/noMemberInsertClaimCancelExchangeRefund' />";
		}
		
		var options = {
				url : url
				, data : $("#cancel_request_list_form").serializeArray()
				, done : function(data){					
					if(data != null){
						jQuery("<form action=\"/mypage/order/indexCancelCompletion\" method=\"post\"><input type=\"hidden\" name=\"clmNo\" value=\""+data.clmNo+"\" /></form>").appendTo('body').submit();
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
				totClmQty += parseInt($("#clmQty"+i).val());
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
  
    // 결제 수단 코드 체크
    function payMeansCdCheck() {
		var payMeansCd = $("#cancel_request_list_form #payMeansCd").val();
    	//결제 수단코드 가상계좌 : "30", 무통장 : "40" 일 경우
  		if(payMeansCd == "${FrontWebConstants.PAY_MEANS_30}" || payMeansCd == "${FrontWebConstants.PAY_MEANS_40}"){
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
	 * 취소, 교환, 반품, as조회 화면 리로딩
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
	<h3>주문취소</h3>
	<div class="sub_text2">취소하실 상품을 확인하신 후 취소수량과 사유를 선택하세요.</div>
</div>

<div class="order_number_box mgt10">
	<dl>
		<dt>주문번호</dt>
		<dd>
			<strong class="point2">${so.ordNo}</strong>
		</dd>
	</dl>
</div>
<form id="claim_request_list_form" name="claim_request_list_form" method="post"></form>
<form id="cancel_request_list_form" name="cancel_request_list_form" method="post">
	<input type="hidden" id="ordNo" name="ordNo" value="${so.ordNo}" /> 
	<input type="hidden" id="clmTpCd" name="clmTpCd" value="${CommonConstants.CLM_TP_10}"/> 
	<input type="hidden" id="chkNumCheck" value="" />
	<input type="hidden" id="amtChkNumCheck" value="" />
	<%-- INIpay 결제 인증 리턴값 --%>
	<input type="hidden" id="order_payment_inipay_result" name="inipayStdCertifyInfo" value="" />
	<!-- 주문내역 -->
	<table class="table_cartlist1 mgt20" id="cancelList">
		<caption>주문내역</caption>
		<colgroup>
			<col style="width:70px">
			<col style="width:auto">
			<col style="width:10%">
			<col style="width:11%">
			<col style="width:10%">
			<col style="width:10%">
		</colgroup>
		<thead>
			<tr>
				<th scope="col" colspan="2">상품정보</th>
				<th scope="col">판매가</th>
				<th scope="col">수량</th>
				<th scope="col">취소수량</th>
				<th scope="col">배송/판매자</th>
			</tr>
		</thead>
		<tbody>
			<c:set var="compSpan" value="1"/><!-- rowspan 설정 값 -->
			<c:set var="claimCompSpan" value=""/><!-- rowspan 적용 영역 -->
			<c:set var="claimCompNo" value="" /><!-- 비교용 업체 번호 -->
			
			<c:choose>
				<c:when test="${order ne '[]'}">
					<input type="hidden" id="payMeansCd" name="payMeansCd" value="${order.payMeansCd}" />
					<input type="hidden" id="refundBankCd" name="refundBankCd" value="${order.refundBankCd}" />
					<input type="hidden" id="refundAcctNo" name="refundAcctNo" value="${order.refundAcctNo}" />
					<input type="hidden" id="refundOoaNm" name="refundOoaNm" value="${order.refundOoaNm}" />
					<c:forEach items="${order.orderDetailListVO}" var="orderCancel" varStatus="idx1">
						<c:if test="${idx1.first}">
		                	<c:set var="claimCompNo" value="${orderCancel.compNo}" />
		              	</c:if>
					
						<c:set value="${orderCancel.ordDtlStatCd}" var="ordDtlStatCd"/>
						<c:set value="${idx1.index}" var="index"/> 
						<tr>
							<c:if test="${ordDtlStatCd ne FrontWebConstants.ORD_DTL_STAT_110}">
								<input type="hidden" id="ordDtlSeq${index}" name="arrOrdDtlSeq"  value="${orderCancel.ordDtlSeq}" />
							</c:if>
							<td class="img_cell v_top"><a href="/goods/indexGoodsDetail?goodsId=<c:out value="${orderCancel.goodsId}"/>"><frame:goodsImage  imgPath="${orderCancel.imgPath}" goodsId="${orderCancel.goodsId}" seq="${orderCancel.imgSeq}" size="${ImageGoodsSize.SIZE_70.size}" gb="" /></a></td>
							<td class="align_left v_top">
								<div class="product_name">
									<a href="#">[<c:out value="${orderCancel.bndNmKo}" />] <c:out value="${orderCancel.goodsNm}" />(<span><frame:num data="${orderCancel.rmnOrdQty}" />개</span>)</a> 
									<div class="product_option">
										<span><c:out value="${orderCancel.itemNm}" /></span>
									</div>
								</div>
							</td>
							<td><frame:num data="${orderCancel.saleAmt - orderCancel.prmtDcAmt}" />원
							</td>
							<td><frame:num data="${orderCancel.rmnOrdQty}" /></td>
							<td>
								<c:if test="${ordDtlStatCd eq FrontWebConstants.ORD_DTL_STAT_110}">
									<frame:num data="${orderCancel.rmnOrdQty}" />
								</c:if>							
								<c:if test="${ordDtlStatCd ne FrontWebConstants.ORD_DTL_STAT_110}">
									<input type="hidden" id="arrClmQty${index}" name="arrClmQty" value="0" />
									<select class="select1" title="수량선택" id="clmQty${index}" name="clmQty" onchange="getClaimRefundExcpect();return false;">
										<option value="0" >선택</option>
										<c:forEach var="i" begin="1" end="${orderCancel.rmnOrdQty}" step="1" varStatus="idx2">
											<option value="${i}">${i}</option>
										</c:forEach>
									</select>
								</c:if>
							</td>
							<c:choose>
								<c:when test="${idx1.first}">
									<td id="comp_span_${orderCancel.ordNo}_${idx1.index}" class="rowspan">
										<c:set var="claimCompSpan" value="${idx1.index}"/>
										<div>${orderCancel.compNm}</div>
									</td>
								</c:when>
								<c:otherwise>
									<!--  업체번호가 같을 경우 -->
									<c:if test="${claimCompNo eq orderCancel.compNo}">
									   	<c:set var="compSpan" value="${compSpan + 1}"/>
										<script>
											$("#comp_span_${orderCancel.ordNo}_${claimCompSpan}").attr("rowspan", '${compSpan}');
										</script>
									</c:if>
								
									<!--  업체 번호가 다를 경우 -->
									<c:if test="${claimCompNo ne orderCancel.compNo}">
										<c:set var="compSpan" value="1"/>
									   	<c:set var="claimCompSpan" value="${idx1.index}"/>
									   	<c:set var="claimCompNo" value="${orderCancel.compNo}" />
										<td id="comp_span_${orderCancel.ordNo}_${idx1.index}" class="rowspan" rowspan="1">
											<div>${orderCancel.compNm}</div>
										</td>
									</c:if>
								</c:otherwise>
							</c:choose>
	<%-- 							<c:if test="${idx1.first}"> --%>
	<%-- 								<c:choose> --%>
	<%-- 								<c:when test="${fn:length(order.orderDetailListVO) > 1}"> --%>
	<%-- 									<c:set var="class_divide" value=""/> --%>
	<%-- 									<c:set var="rowspan_divide" value="${fn:length(order.orderDetailListVO)}"/> --%>
	<%-- 								</c:when> --%>
	<%-- 								<c:otherwise> --%>
	<%-- 									<c:set var="class_divide" value="_n"/> --%>
	<%-- 									<c:set var="rowspan_divide" value=""/> --%>
	<%-- 								</c:otherwise> --%>
	<%-- 								</c:choose> --%>
	<%-- 								<td class="rowspan<c:out value="${class_divide}"/>" rowspan="<c:out value="${rowspan_divide}"/>"> --%>
	<!-- 									<select title="취소사유선택" class="order_cancel_slt" id="clmRsnCd" name="clmRsnCd" onchange="selectClmRsnCd();return false;"> -->
	<!-- 										<option value="">선택하세요</option>  -->
	<%-- 										<frame:selectOption items="${clmRsnList}" all="true" />  --%>
	<!-- 									</select> -->
	<!-- 									<textarea title="취소사유입력" class="order_cancel_ta" id="clmRsnContent" name="clmRsnContent" onkeyup="specialCharRemove(this);return false;" readonly="readonly" placeholder="내용입력" style="display:none;"></textarea> -->
	<!-- 								</td> -->
	<%-- 							</c:if> --%>
						</tr>
						<c:if test="${idx1.last}">
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
													취소사유*
												</th>
												<td>
													<select title="취소사유선택" class="order_cancel_slt" id="clmRsnCd" name="clmRsnCd" onchange="getClaimRefundExcpect();return false;">
														<option value="">선택하세요</option> 
														<frame:selectOption items="${clmRsnList}" all="true" /> 
													</select>
												</td>
											</tr>
										</tbody>
									</table>
								</td>
							</tr>
						</c:if>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<tr>
						<td colspan="8" class="nodata">취소/교환/반품 가능한 주문내역이 없습니다.</td>
					</tr>
				</c:otherwise>
			</c:choose>
		</tbody>
	</table>
<!-- // 주문내역 -->

	<c:if test="${order ne '[]'}">
		<div class="mgt30" >
			<c:if test="${order.orderDetailListVO[0].ordDtlStatCd ne FrontWebConstants.ORD_DTL_STAT_110}">
				<!-- 환불 예상 금액 -->
				<div class="box_title_area">
					<h3>환불결제정보</h3>
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
									<th scope="col">취소금액</th>
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
											<dd>(-)<span id="cpDcAmt"></span> 원</dd>
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
											<div class="point3 mgt10">- 입력하신 환불정보는 환불처리 이외의 목적으로는 이용되지 않으며, 환불대상이 아닌 환불정보는 1개월 후 파기됩니다.</div>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
						<!-- //환불계좌정보 --> 
					</c:if>
				</c:if>				
				<div class="note_box1 mgt30">
					<ul class="ul_list_type1">
						<li>주문취소가 가능한 상품에만 주문취소 버튼이 표시됩니다.<br/>('주문접수' 또는 '결제완료' 상태에서만 취소가 가능합니다.)</li>
						<li>묶음배송 상품 중 일부 취소로 무료배송 조건에 충족하지 않을 경우 고객이 배송비를 부담합니다.</li>
						<li>취소 후 환불은 결제수단에 따라 환불 소요기간이 상이합니다. 보다 상세 내용은 [상품페이지-배송/교환/환불] 에서 확인 가능합니다.</li>
					</ul>
				</div>
				<!-- 취소동의영역  -->	
				<div class="mgt15 pdl5">
					<label class="mgl10"><input type="checkbox" id="checkAgree" name="checkAgree"/> <strong class="point4">취소 안내 사항을 확인하였습니다.</strong></label>	
				</div>
				<!--// 취소동의영역  -->
				<div class="btn_area_center mgt45">
					<a href="#" class="btn_h60_type1" onclick="insertCancelList();return false;">신청하기</a>
					<a href="#" class="btn_h60_type2 mgl6" onclick="searchClaimRequestList();return false;">취소</a>
				</div>
			</div>
		</div>
	</c:if>
</form>