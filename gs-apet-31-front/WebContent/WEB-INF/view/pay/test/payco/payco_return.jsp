
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.*" %>
<%@ page import="javax.xml.ws.Response"%>
<%@ page import="com.fasterxml.jackson.databind.ObjectMapper" %>
<%@ page import="com.fasterxml.jackson.core.type.TypeReference" %>
<%@page import="com.fasterxml.jackson.databind.node.ArrayNode"%>
<%@page import="com.fasterxml.jackson.databind.JsonNode"%>
<%@ page import="java.io.IOException" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="com.util.PaycoUtil" %>
<%@ include file="common_include.jsp" %>
<% 
/**-----------------------------------------------------------------------
 * 재고수량 및 금액 정합성 검사(ver. Pay2)
 *------------------------------------------------------------------------
 * @Class payco_return.jsp
 * @author PAYCO기술지원<dl_payco_ts@nhnent.com>
 * @since 
 * @version
 * @Description 
 * - 구매예약페이지에서 재고수량 및 금액 정합성 검사를 하기위해 통신하는 API
 * - payco 결제 인증 후 호출되어 재고 및 금액 정합성 검사를 수행한다.
 * - 재고 및 금액에 이상이 없을 시 payco 결제승인 API 를 호출하여
 * - 응답에 따라 결제완료 여부를 판단한다.
 * param : response=JSON
 * return : 
 */
%>
<% 
	int totalPaymentAmt = 0;
	String xssCheckStr = "[-<>,!/\"'%;\\(\\)&[+]]";
	
	/* 인증 데이타 변수선언 */
	String reserveOrderNo 	   	   = request.getParameter("reserveOrderNo").replaceAll(xssCheckStr,"");			//주문예약번호
	String sellerOrderReferenceKey = request.getParameter("sellerOrderReferenceKey").replaceAll(xssCheckStr,"");	//가맹점주문연동키
	String paymentCertifyToken 	   = request.getParameter("paymentCertifyToken").replaceAll(xssCheckStr,"");		//결제인증토큰(결제승인시필요)
	
	if(request.getParameter("totalPaymentAmt").replaceAll(xssCheckStr,"") == null){								//총 결제금액
		totalPaymentAmt = 0;
	}else{
		totalPaymentAmt = (int)Float.parseFloat(request.getParameter("totalPaymentAmt").replaceAll(xssCheckStr,"").toString()); 
	}
	
	String cart_no				   = request.getParameter("cart_no").replaceAll(xssCheckStr,"");					//주문예약시 전달한 returnUrlParam ({"cart_no" : "A1234"}을 전송했었음.)
	String code      	   	       = request.getParameter("code").replaceAll(xssCheckStr,"");						//결과코드(성공 : 0)
	String message				   = request.getParameter("message").replaceAll(xssCheckStr,"");					//결과 메시지
	
	/* 승인데이타 변수선언 */
	String approval_orderNo 				= "";
	String approval_orderCertifyKey 		= "";
	String approval_sellerOrderReferenceKey = "";
	String approval_totalPaymentAmt 		= "";
	
	String approval_paymentTradeNo_card		= "";
	String approval_paymentMethodCode_card	= "";
	String approval_paymentMethodName_card	= "";
	String approval_tradeYmdt_card			= "";
	String approval_cardCompanyName_card	= "";
	String approval_cardCompanyCode_card	= "";
	String approval_cardNo_card				= "";
	
	String approval_paymentTradeNo_point	= "";
	String approval_paymentMethodCode_point = "";
	String approval_paymentMethodName_point = "";
	String approval_tradeYmdt_point		 	= "";
	
	ObjectMapper mapper = new ObjectMapper();		 //jackson json object
	PaycoUtil    util   = new PaycoUtil(serverType); //CommonUtil
	
	Boolean existStock  = true; //재고 존재 여부
	
	/* 결제 인증 성공시 */
	if(code.equals("0")){
		
		/* 수신된 데이터 중 필요한 정보를 추출하여
		 * 총 결제금액과 요청금액이 일치하는지 확인하고,	
		 * 결제요청 상품의 재고파악을 실행하여 
		 * PAYCO 결제 승인 API 호출 여부를 판단한다.
		 */
		/*----------------------------------------------------------------
		.. 가맹점 처리 부분
		..
		-----------------------------------------------------------------*/
		
		/* 요청금액이 일치하고 재고가 있다는 가정(existStock = true) */
		if(existStock){
			Map<String,Object> sendMap = new HashMap<String,Object>();
			sendMap.put("sellerKey", sellerKey);
			sendMap.put("reserveOrderNo", reserveOrderNo);
			sendMap.put("sellerOrderReferenceKey", sellerOrderReferenceKey);
			sendMap.put("paymentCertifyToken", paymentCertifyToken);
			sendMap.put("totalPaymentAmt", totalPaymentAmt);
			
			/* payco 결제승인 API 호출 */
			String result = util.payco_approval(sendMap,logYn);
			
			// jackson Tree 이용
			JsonNode node = mapper.readTree(result);
			
			if(node.path("code").toString().equals("0")){ 
				
				/* 결제승인 후 리턴된 데이터 중 필요한 정보를 추출하여
				 * 가맹점 에서 필요한 작업을 실시합니다.(예 주문서 작성 등..)
				 * 결제연동시 리턴되는 PAYCO주문번호(orderNo)와 주문인증키(orderCertifyKey)에 대해 
				 * 가맹점 DB 저장이 필요합니다.
				 */
				
				// 결제승인 후 리턴된 데이터 중 필요한 정보를 추출 예시
				approval_orderNo 				 = node.path("result").get("orderNo").textValue();
				approval_orderCertifyKey 		 = node.path("result").get("orderCertifyKey").textValue();
				approval_sellerOrderReferenceKey = node.path("result").get("sellerOrderReferenceKey").textValue();
				approval_totalPaymentAmt 		 = node.path("result").get("memberName").textValue();
				
				// orderProducts, paymentDetails 추출 예시
				ArrayNode arr = (ArrayNode)node.path("result").get("paymentDetails");
				
				for(int i = 0; i < arr.size(); i++){
					// paymentMethodCode : 31(신용카드)
					if(arr.get(i).get("paymentMethodCode").textValue().equals("31")){
						approval_paymentTradeNo_card	= arr.get(i).get("paymentTradeNo").textValue();
						approval_paymentMethodCode_card = arr.get(i).get("paymentMethodCode").textValue();
						approval_paymentMethodName_card = arr.get(i).get("paymentMethodName").textValue();
						approval_tradeYmdt_card		    = arr.get(i).get("tradeYmdt").textValue();
						// 신용카드 상세정보(cardSettleInfo) 추출 예시
						approval_cardCompanyName_card = arr.get(i).get("cardSettleInfo").get("cardCompanyName").textValue();
						approval_cardCompanyCode_card = arr.get(i).get("cardSettleInfo").get("cardCompanyCode").textValue();
						approval_cardNo_card 		  = arr.get(i).get("cardSettleInfo").get("cardNo").textValue();
					// paymentMethodCode : 98(페이코 포인트)	
					}else if(arr.get(i).get("paymentMethodCode").textValue().equals("98")){
						approval_paymentTradeNo_point	 = arr.get(i).get("paymentTradeNo").textValue();
						approval_paymentMethodCode_point = arr.get(i).get("paymentMethodCode").textValue();
						approval_paymentMethodName_point = arr.get(i).get("paymentMethodName").textValue();
						approval_tradeYmdt_point		 = arr.get(i).get("tradeYmdt").textValue();
						
					}
				 }
				
%>
				<html>
					<head>
						<title>주문 완료</title>
					</head>
					<script type="text/javascript">
						alert("주문이 정상적으로 완료되었습니다.");
						if(<%=isMobile%>){
							location.href = "index.jsp";
						}else{
							opener.location.href = "index.jsp";
							window.close();
						}
					</script>
					<body>			
					</body>
				</html>
<%		
			}else{
%>
				<html>
					<head>
						<title>결제 승인 실패</title>
					</head>
					<script type="text/javascript">
						alert("결제 승인에 실패했습니다. \n" + "code : <%=node.path("code").toString()%> \n" + "message : <%=node.path("message").textValue()%>");
						if(<%=isMobile%>){
							location.href = "index.jsp";
						}else{
							opener.location.href = "index.jsp";
							window.close();
						}
					</script>
					<body>			
					</body>
				</html>
<%				
			}
		}else{
%>
			<html>
				<head>
					<title>재고 부족</title>
				</head>
				<script type="text/javascript">
					alert("상품 재고가 부족합니다.");
					if(<%=isMobile%>){
						location.href = "index.jsp";
					}else{
						opener.location.href = "index.jsp";
						window.close();
					}
				</script>
				<body>			
				</body>
			</html>
<%		
		}
	/* 결제 인증 실패 */
	}else{
		if(code.equals("2222")){
			message = "사용자에 의해 취소된 주문입니다";
		}
%>
		<html>
			<head>
				<title>사용자 취소</title>
			</head>
			<script type="text/javascript">
				alert("<%=message %>");
				if(<%=isMobile%>){
					location.href = "index.jsp";
				}else{
					opener.location.href = "index.jsp";
					window.close();
				}
			</script>
			<body>			
			</body>
		</html>
<%		
	}
%>

