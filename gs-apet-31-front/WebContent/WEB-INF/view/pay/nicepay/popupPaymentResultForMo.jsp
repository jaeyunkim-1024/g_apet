<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<tiles:insertDefinition name="blank">
<tiles:putAttribute name="script.include" value="script.order"/>
<tiles:putAttribute name="script.inline">

<%--
  Class Name  : popupAddressEdit.jsp 
  Description : 회원 주소록 목록 팝업
  Author      : 신남원
  Since       : 2016.04.26
  Modification Information 
	          수정일         	     수정자             수정내용
    ----------  -------  -------------------------------------------
    2016.04.26    신남원            최초 작성
--%>

<script type="text/javascript">

	$(function() {
		
		setTimeout(function() {
			if("${view.os}"=="${frontConstants.DEVICE_TYPE_20}" && "${view.deviceGb}"=="${frontConstants.DEVICE_GB_30}") {
				goResultIOS();
			} else {
				goResult();
			}
			
		}, 1500);
	});

	function goResult() {
		if(${result.paySuccess}) {
			opener.nicepayResultForMo(JSON.stringify($("#order_payment_result_form").serializeArray()));
			window.close();
		} else {
			ui.alert('${result.resultMsg}',{
				ycb:function(){
					window.close();
				},
				ybt:"<spring:message code='front.web.view.common.msg.confirmation'/>"
			});
			return;
		}
		
	}

	function goResultIOS() {

		if(${result.paySuccess}) {

			var parameters = {
					'func' : 'onClosePG',
					'parameters' : JSON.stringify($("#order_payment_result_form").serializeArray()),
					'callback': 'nicepayResultForMo'
				};
			// iOS(Dictionary)
			window.webkit.messageHandlers.AppJSInterface.postMessage(parameters);
		} else {
			ui.alert('${result.resultMsg}',{
				ycb:function(){
					var parameters = {
							'func' : 'onClosePG',
							'parameters' : JSON.stringify({}),
							'callback': 'blankCallback'
						};
					// iOS(Dictionary)
					window.webkit.messageHandlers.AppJSInterface.postMessage(parameters);
				},
				ybt:"<spring:message code='front.web.view.common.msg.confirmation'/>"
			});

			return;
		}
		
	}
	
	// 팝업닫기
	function closePop() {
		if("${view.os}"=="${frontConstants.DEVICE_TYPE_20}" && "${view.deviceGb}"=="${frontConstants.DEVICE_GB_30}") {
			var parameters = {
					'func' : 'onClosePG',
					'parameters' : JSON.stringify({}),
					'callback': 'blankCallback'
				};
			// iOS(Dictionary)
			window.webkit.messageHandlers.AppJSInterface.postMessage(parameters);
		} else {
			window.close();
		}
	}

</script>
</tiles:putAttribute>
<tiles:putAttribute name="content">
<main class="container page login srch agree" id="container">
	<div class="inr">
		<%-- 본문  --%>
		<div class="contents error-wrap-area" id="contents">
			
			<%-- 500 에러 --%>
			<div class="error-area">
				<div class="error">
					<p class="txt"><spring:message code='front.web.view.popup.payment.result.mo.msg.saving.payment.info'/></p>
					<p class="txt-s">
						<spring:message code='front.web.view.popup.payment.request.mo.msg.no.change.request.click.close'/>
					</p>
					<div class="btnSet">
						<a href="javascript:closePop();" class="btn c"><spring:message code='front.web.view.popup.payment.btn.close.title'/></a>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 본문 -->
	<form id="order_payment_result_form" name="order_payment_result_form">
		<input type="hidden" id="resultCode" name="resultCode" value="${map.resultCode }" />
		<input type="hidden" id="resultMsg" name="resultMsg" value="${map.resultMsg }" />
		<input type="hidden" id="payMethod" name="payMethod" value="${map.payMethod }" />
		<input type="hidden" id="amt" name="amt" value="${map.amt }" />
		<input type="hidden" id="tid" name="tid" value="${map.tid }" />
		<input type="hidden" id="authCode" name="authCode" value="${map.authCode }" />
		<input type="hidden" id="authDate" name="authDate" value="${map.authDate }" />
		<input type="hidden" id="goodsName" name="goodsName" value="${map.goodsName }" />

		<input type="hidden" id="cardCode"		name="cardCode"			value="${map.cardCode}"/>
		<input type="hidden" id="cardQuota"		name="cardQuota"		value="${map.cardQuota}"/>
		<input type="hidden" id="cardInterest"	name="cardInterest"		value="${map.cardInterest}"/>
		<input type="hidden" id="cardNo"		name="cardNo"			value="${map.cardNo}"/>
		<input type="hidden" id="bankCode"		name="bankCode"			value="${map.bankCode}"/>
		<input type="hidden" id="bankName"		name="bankName"			value="${map.bankName}"/>
		<input type="hidden" id="rcpType"		name="rcpType"			value="${map.rcpType}"/>
		<input type="hidden" id="rcptTID"		name="rcptTID"			value="${map.rcptTID}"/>
		<input type="hidden" id="rcptAuthCode"	name="rcptAuthCode"		value="${map.rcptAuthCode}"/>
		<input type="hidden" id="vbankBankCode"	name="vbankBankCode"	value="${map.vbankBankCode}"/>
		<input type="hidden" id="vbankBankName"	name="vbankBankName"	value="${map.vbankBankName}"/>
		<input type="hidden" id="vbankNum"		name="vbankNum"			value="${map.vbankNum}"/>
		<input type="hidden" id="vbankExpDate"	name="vbankExpDate"		value="${map.vbankExpDate}"/>
		<input type="hidden" id="vbankExpTime"	name="vbankExpTime"		value="${map.vbankExpTime}"/>
	</form>
</main>
</tiles:putAttribute>
</tiles:insertDefinition>