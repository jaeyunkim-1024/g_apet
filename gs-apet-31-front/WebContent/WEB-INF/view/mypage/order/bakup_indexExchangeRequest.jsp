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
		// 교환안내 확인 초기화
		$("input:checkbox[name=checkAgree]").prop("checked", false);
		$("#clmRsnCd").val("");
		getClaimRefundExcpect();
		$("#payAmt").val(0);

		dialog.create("order_payment_pay_dialog" , {width: 850, height:637, modal:true});
		
		$("#order_payment_pay_dialog").prev(".ui-dialog-titlebar").children("button").click(function(){
			inipay.close("B");
		});		

		<c:forEach items="${orgGoodsAttrList}" var="orgGoodsAttr">
			$("#exchange_attrVal_${orgGoodsAttr.attrNo }").val("${orgGoodsAttr.attrValNo}");
		</c:forEach>
	});
	   
	function setClmQty() {		
		var arrClmQty = $("input[name=arrClmQty]");		
		for(var i=0; i <arrClmQty.length; i++){
			$("#arrClmQty"+i).val(parseInt($("#clmQty"+i).val()));
		}
	}
	
	/*
	* 반품/교환 사유에 따른 금액 재계산
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
				, data : $("#exchange_request_list_form").serializeArray()
				, done : function(data){
					claimRefundVO = data.claimRefundVO;
					seRefundArea();
				}
		};
		
		ajax.call(options);
	}

	function seRefundArea() {	
		$("#totAmt").html(fnComma(Math.abs(claimRefundVO.totAmt)));
	}
	
	/*
	 * 수거지 변경
	 */
	function goAddressChange(ordNo){
		var params = { ordNo : ordNo
					, viewTitle :  "교환수거지 변경"
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
	

	//주문 교환 신청하기 button   
	function insertExchangeRequestList(){
		if (!clmQtyCheck()) {
			alert('<spring:message code="front.web.view.claim_exchange.msg.clmQty" />');
			return;
		} else if (!clmRsnCdCheck()) {
			alert('<spring:message code="front.web.view.claim_exchange.msg.clmRsnCd" />');
			$("#clmRsnCd").focus();
			return;
		}

		var exAppChecked = $("input:checkbox[name=checkAgree]").is(":checked");
		if(exAppChecked){               //교환안내사항 확인여부 여부
			setClmQty();
  			fnExchange.check();
		} else {
			alert('<spring:message code="front.web.view.claim.msg.exchange_info.check" />'); 
			$("input:checkbox[name=checkAgree]").focus();
			return;
		}  
	}

	var fnExchange = {
		optionChange : function (ordNo, ordDtlSeq){
			var params = {
				ordNo : ordNo,
				ordDtlSeq : ordDtlSeq,
				mode : "exchange",
				callBackFnc : "fnExchange.choose"
			};
			pop.orderOptionChange(params);
		},
		choose : function (data){
			var attrValStr = "- 선택옵션 : ";
			$(data).each(function(i){
				$("#exchange_attrVal_"+data[i].attrNo).val(data[i].attrValNo);
				
				if (i > 0) { attrValStr += "/"; }
				attrValStr += data[i].attrVal;
				$("#itemNo").val(data[i].itemNo);
			});
			$("#optionSpan").text(attrValStr);
			
		},
		check : function (){
			var exchangeAttrVal = $("[id^=exchange_attrVal_]");
			
			if (exchangeAttrVal.length > 0) {
				var addFlag = true;
				// 속성번호 배열
				var arrAttrNo = [],
				// 속성 값 번호 배열
				arrAttrNoVal = [];
				
				$(exchangeAttrVal).each(function(index){
					arrAttrNo.push($("[id^=exchange_attrNo_]").eq(index).val());
					arrAttrNoVal.push($(this).val());
				});
				
				$("#exchange_request_list_form > #attr_no_list").val(arrAttrNo);
				$("#exchange_request_list_form > #attr_no_val_list").val(arrAttrNoVal);

				// 선택된 옵션조합으로 단품정보 조회
				var options = {
					url : "<spring:url value='/mypage/order/checkDeliveryGoodsOption' />",
					data : $("#exchange_request_list_form").serialize(),
					done : function(data){
						//console.debug(data);
						if(data.item == null){
							alert("<spring:message code='front.web.view.goods.detail.item.soldout' />");
							return;
						}
						if(data.item.webStkQty < 1){
							alert("<spring:message code='front.web.view.goods.detail.item.soldout' />");
							return;
						}
						if(data.item.addSaleAmt != $('#addSaleAmt').val()){
							alert("<spring:message code='front.web.view.mypage.order.option.price.different' />");
							return;
						}
						$("#itemNo").val(data.item.itemNo);
						
						if (claimRefundVO.totAmt < 0) {
							$("#payAmt").val(Math.abs(claimRefundVO.totAmt));
						} else {
							$("#payAmt").val(0);
						}
						
						inipay.open();
					}
				};
				ajax.call(options);
			} else {
				if (claimRefundVO.totAmt < 0) {
					$("#payAmt").val(Math.abs(claimRefundVO.totAmt));
				} else {
					$("#payAmt").val(0);
				}
				
				inipay.open();
			}
		}
	}
	
	function insertAccess(){
		var mbrNo = '${session.mbrNo}';
		var url = "<spring:url value='/mypage/insertClaimCancelExchangeRefund' />";
		var formUrl = "/mypage/order/indexExchangeCompletion";
		
		if ("${session.mbrNo}" == "${FrontWebConstants.NO_MEMBER_NO}") {
			url = "<spring:url value='/mypage/noMemberInsertClaimCancelExchangeRefund' />";
// 			formUrl = "/mypage/order/indexNoMemberExchangeCompletion";
		}
		
		var options = {
				url : url
				, data : $("#exchange_request_list_form").serialize()
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
			if ($("#orgItemNo").val() == $("#itemNo").val()) {
				if (!confirm('<spring:message code="front.web.view.claim.exchange.confirm.claim_Item_check" />') ) {
					return;
				}
			} else if (!confirm('<spring:message code="front.web.view.claim.exchange.confirm.claim_accept" />') ) {
				return;
			}
			
			if ($("#payAmt").val() > 0) {
				alert('<spring:message code="front.web.view.claim.msg.pay_amt" />')
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
	<h3>교환신청</h3>
	<div class="sub_text2">교환하실 상품을 확인하신 후 교환수량과 사유를 선택하세요.</div>
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
<form id="exchange_request_list_form"  name="exchange_request_list_form">
	<input type="hidden" id="ordNo" name="ordNo" value="${orderSO.ordNo}" />  
	<input type="hidden" id="clmTpCd" name="clmTpCd" value="${CommonConstants.CLM_TP_30}"/>
	<input type="hidden" id="checkCode" name="checkCode" value="${checkCode} }" />
	<input type="hidden" id="attr_no_list" name="attrNoList" value="" />
	<input type="hidden" id="attr_no_val_list" name="attrValNoList" value="" />
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
				<th scope="col">교환수량</th>
				<th scope="col">배송/판매자</th>
			</tr> 
		</thead>
		<tbody>
			<c:choose>
			<c:when test="${order ne '[]'}">
				<c:forEach items="${order.orderDetailListVO}" var="orderExchange" varStatus="idx">
					<c:set value="${orderExchange.ordDtlStatCd}" var="ordDtlStatCd"/>
					<c:set value="${idx.index}" var="index"/>
					<c:set value="${orderExchange.rmnOrdQty - orderExchange.rtnQty - orderExchange.clmExcIngQty}" var="rmnOrdQty"/>
					<input type="hidden" id="ordDtlSeq${index}" name="arrOrdDtlSeq"  value="${orderExchange.ordDtlSeq}" /> 
					<input type="hidden" id="goods_id" name="goodsId" value="${orderExchange.goodsId}" />
					<input type="hidden" id="orgItemNo" name="orgItemNo" value="${orderExchange.itemNo}" />
					<input type="hidden" id="itemNo" name="itemNo" value="${orderExchange.itemNo}" />
					<input type="hidden" id="dlvrcPlcNo" name="dlvrcPlcNo" value="${orderExchange.dlvrcPlcNo}" />
					<input type="hidden" id="addSaleAmt" name="addSaleAmt" value="${orderExchange.addSaleAmt}" />
					<tr>
						<td class="img_cell v_top"><a href="/goods/indexGoodsDetail?goodsId=<c:out value="${orderExchange.goodsId}"/>"><frame:goodsImage imgPath="${orderExchange.imgPath}" goodsId="${orderExchange.goodsId}" seq="${orderExchange.imgSeq}" size="${ImageGoodsSize.SIZE_70.size}" gb="" /></a></td>
						<td class="align_left v_top">
							<div class="product_name">
								<a href="#">[${orderExchange.bndNmKo}] ${orderExchange.goodsNm}(<frame:num data="${rmnOrdQty}" />개)</a> 
								<div class="product_option">
									<span>${orderExchange.itemNm}</span>
								</div>
								<c:if test="${orderExchange.itemMngYn eq FrontWebConstants.COMM_YN_Y}">
									<div class="product_option_exchange">
										<c:forEach items="${orgGoodsAttrList}" var="orgGoodsAttr">
											<input type="hidden" id="exchange_attrNo_${orgGoodsAttr.attrNo }" value="${orgGoodsAttr.attrNo }" />
											<input type="hidden" id="exchange_attrVal_${orgGoodsAttr.attrNo }" value="${orgGoodsAttr.attrValNo}" />
										</c:forEach>
										<span class="tit">교환옵션</span>
										<a href="#" class="btn_h16_type3" onclick="fnExchange.optionChange('${orderSO.ordNo}', '${orderSO.ordDtlSeq}');return false;">옵션변경</a>
										<span id="optionSpan">- 선택옵션 : ${orderExchange.itemNm}</span>
									</div>
								</c:if>
							</div>
						</td>
						<td><frame:num data="${orderExchange.saleAmt - orderExchange.prmtDcAmt}" />원</td>
						</td>
						<td><frame:num data="${rmnOrdQty}" /></td>
						<td>
							<input type="hidden" id="arrClmQty${index}" name="arrClmQty" value="0" />
							<select class="select1" title="수량선택" id="clmQty${index}" name="clmQty" onchange="getClaimRefundExcpect();return false;">
								<option value="0" >선택</option>
								<c:forEach var="i" begin="1" end="${rmnOrdQty}" step="1" varStatus="idx">
									<option value="${i}">${i}</option>
								</c:forEach>
							</select>
						</td>
						<td>${orderExchange.compNm}</td>
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
											교환 사유*
										</th>
										<td>
											<select title="교환사유선택" class="order_cancel_slt" id="clmRsnCd" name="clmRsnCd" onchange="getClaimRefundExcpect();return false;">
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
					
	<div class="mgt30">
		<div id="refundAcctInfo">
			<div class="box_title_area">
				<h3>교환 수거지</h3>&emsp;* 교환 접수 후 업체에서 수거지시를 하며, 1~3영업일 내 택배 기사님이 방문할 예정입니다.
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
						
		<div class="box_title_area mgt30">
			<h3>추가결제금액 </h3>&emsp;* 교환배송비는 카드결제만 가능하며, 박스 동봉을 원하시는 경우 1:1게시판 또는 고객센터(02-512-5293)를 통해 접수가 가능합니다.
		</div>
		<div class="plusCash_box">
			<div class="plusMsg">교환배송비</div>
			<div class="goodsTotalAmt">	
				<strong id="totAmt">0</strong>원
			</div>
		</div>
	</div>
</form>
<!-- //배송지 확인 -->
<div class="note_box1 mgt30">
	<ul class="ul_list_type1">
		<li>교환은 배송완료 후 7일 이내 가능하며, 선택하신 교환사유에 따라 교환배송비가 발생될 수 있습니다.</li> 
		<li>판매자귀책(제품하자, 오배송, 기타) 으로 요청 하셨더라도 상품 확인 결과에 따라 배송비 입금을 요청 드릴 수 있습니다.</li> 
		<li>교환배송비 동봉으로 교환 접수를 하신 경우 교환배송비가 동봉되지 않으면 교환처리가 지연될 수 있습니다.</li>
		<li>포장 및 상품훼손, 또는 사용 여부에 따라 교환이 어려울 수 있으며, 상세 내용은 [상품페이지-배송/교환/환불] 에서 확인 가능합니다.</li>
		<li>교환 상품 반송 시 운송장은 교환이 완료될 때까지 보관해주시기 바랍니다.</li>
		<li>상품 재고가 없어 교환이 어려운 경우, 환불 처리 될 수 있습니다.</li>
	</ul>
</div>

<div class="mgt15 pdl5">
	<label class="mgl10"><input type="checkbox" id="checkAgree" name="checkAgree"/> <strong class="point4">교환 안내 사항을 확인하였습니다.</strong></label>	
</div>
<div class="btn_area_center mgt40">
	<a href="#" class="btn_h60_type1" onclick="insertExchangeRequestList();return false;">교환신청하기</a>
	<a href="#" class="btn_h60_type2 mgl6" onclick="searchClaimRequestList();return false;">취소</a>
</div>
