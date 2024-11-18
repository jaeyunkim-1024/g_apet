<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<tiles:insertDefinition name="blank">
<tiles:putAttribute name="script.include" value="script.order"/>
<tiles:putAttribute name="script.inline">
<%--
  Class Name  : popupPaymentRequestForMo.jsp 
  Description : 모바일 결제 팝업
  Author      : jjy01
  Since       : 2021.03.21
  Modification Information 
	          수정일         	     수정자             수정내용
    ----------  -------  -------------------------------------------
    2021.03.21    정정용            최초 작성
    2021.08.24    이재찬            결제 요청 파라미터 변경
--%>
<script type="text/javascript">
	$(function() {
		setTimeout(function() {
			 goPay()
		}, 1500);
	});

	function goPay() {
		document.order_payment_form.action = "https://web.nicepay.co.kr/v3/v3Payment.jsp";
		document.order_payment_form.method = "post";
		document.order_payment_form.acceptCharset="euc-kr";
		document.order_payment_form.submit();
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
					<p class="txt"><spring:message code='front.web.view.popup.payment.request.mo.msg.encrypting.pay.information'/></p>
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
	<form id="order_payment_form" name="order_payment_form">
		<%--NICEPAY 인증 요청--%>
		<input type="hidden" name="GoodsName" id="goodsName" value="${param.GoodsName }">									<%--상품이름(필수)[40] --%>
		<input type="hidden" name="Amt" id="amt" value="${param.Amt }">														<%--결제금액(필수)[12]--%>
		<input type="hidden" name="MID" id="mid" value="${param.MID }">														<%--상점아이디(필수)[10]--%>
		<input type="hidden" name="EdiDate" id="ediDate" value="${param.EdiDate}"/>											<%--전문생성일시(필수)[30]--%>
		<input type="hidden" name="Moid" id="moid" value="${param.Moid }">													<%--상점주문번호(필수)[64]--%>
		<input type="hidden" name="SignData" id="signData" value="${param.SignData}"/>										<%--위변조검증데이터(필수)[500]--%>
		<input type="hidden" name="BuyerName" id="buyerName" value='${param.ordNm}'>										<%--구매자이름[30]--%>
		<input type="hidden" name="BuyerTel" id="buyerTel" value='${param.ordrMobile}'>										<%--구매자전화번호[40]--%>
		<input type="hidden" name="ReturnURL" id="returnUrl" value="${param.ReturnURL}">									<%--ReturnURL[500]--%>
		<input type="hidden" name="PayMethod" id="payMethod" value="${param.PayMethod }">									<%--결제수단[10]--%>
		<input type="hidden" name="ReqReserved" id="reqReserved" value="${param.ReqReserved}"/>								<%--상점정보전달용예비필드[500]--%>
		<input type="hidden" name="BuyerEmail" id="buyerEmail" value='${param.ordrEmail}'>									<%--구매자이메일[60]--%>
		<input type="hidden" name="TransType" id="transType" value="0"/>													<%--0:일반거래/1:에스크로거래[1]--%>
		<input type="hidden" name="CharSet" id="charSet" value="${param.CharSet}"/>											<%--가맹점 서버의 encoding 방식전달--%>
		<%--앱일 경우만 파라미터 전달--%>
		<c:if test="${view.deviceGb eq frontConstants.DEVICE_GB_30 }">
		<input type="hidden" name="WapUrl" id="WapUrl" value="${param.WapUrl }">											<%--결제완료 후 돌아올 앱스키마[500]--%>
		<input type="hidden" name="IspCancelUrl" id="IspCancelUrl" value="${param.IspCancelUrl }">							<%--취소버튼클릭시 돌아올 앱스키마[500]--%>
		</c:if>
		<input type="hidden" name="SelectCardCode" id="selectCardCode" value="${param.SelectCardCode }">					<%--결제수단 카드사 코드[2]--%>
		<input type="hidden" name="ShopInterest" id="shopInterest" value="${param.ShopInterest}"/>							<%--상점무이자 사용여부[1]--%>
		<%--가상계좌 추가 요청 파라미터 전달--%>
		<input type="hidden" name="VbankExpDate" id="vBankExpDate" value="${param.VbankExpDate }">							<%--가상계좌입금만료일(YYYYMMDD)(필수)[12]--%>
		<%--휴대폰 소액결제 추가 요청 파라미터 전달--%>
		<input type="hidden" name="GoodsCl" id="goodsCl" value="1"/>														<%--휴대폰상품구분(0:컨텐츠/1:현물)(필수)[1]--%>
		<%--결제창 직접 호출 옵션 파라미터 전달--%>
		<input type="hidden" name="DirectShowOpt" id="directShowOpt" value="${param.DirectShowOpt}"/>						<%--인증결제창 직접호출설정(필수)[100]--%>
		<input type="hidden" name="DirectCardPointFlag" id="directCardPointFlag" value="${param.DirectCardPointFlag}"/>		<%--카드포인트사용옵션[1]--%>
		<input type="hidden" name="DirectEasyPay" id="directEasyPay" value="${param.DirectEasyPay}"/>						<%--간편결제제휴사인증창 바로호출 옵션[4]--%>
		<input type="hidden" name="DirectCouponYN" id="directCouponYN" value="${param.DirectCouponYN}"/>					<%--신용카드쿠폰자동적용여부[1]--%>
		<input type="hidden" name="NicepayReserved" id="nicepayReserved" value="${param.NicepayReserved}"/>					<%--나이스페이복합옵션[500]--%>
		<input type="hidden" name="SelectQuota" id="selectQuota" value="${param.SelectQuota}"/>								<%--할부개월제한[2]--%>
		<%--카카오페이 옵션 파라미터 전달--%>
		<input type="hidden" name="EasyPayCardCode" id="easyPayCardCode" value="${param.EasyPayCardCode}"/>					<%--간편결제카드코드[2]--%>
		<input type="hidden" name="EasyPayQuota" id="easyPayQuota" value="${param.EasyPayQuota}"/>							<%--간편결제할부개월[2]--%>
		<%--페이코 옵션 파라미터 전달--%>
		<input type="hidden" name="EasyPayShopInterest" id="easyPayShopInterest" value="${param.EasyPayShopInterest}"/>		<%--간편결제상점 무이자사용여부[1]--%>
		<input type="hidden" name="EasyPayQuotaInterest" id="easyPayQuotaInterest" value="${param.EasyPayQuotaInterest}"/>	<%--간편결제상점 무이자설정[2]--%>
		<input type="hidden" name="PaycoClientId" id="paycoClientId" value="${param.PaycoClientId}"/>						<%--페이코자동로그인ID--%>
		<input type="hidden" name="PaycoAccessToken" id="paycoAccessToken" value="${param.PaycoAccessToken}"/>				<%--페이코자동로그인토큰--%>
		<%--네이버페이 옵션 파라미터 전달--%>
		<input type="hidden" name="EasyPayMethod" id="easyPayMethod" value="${param.EasyPayMethod}"/>						<%--간편결제지불수단지정--%>
	</form>
</main>
</tiles:putAttribute>
</tiles:insertDefinition>