	<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
	<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
	<%@ page import="front.web.config.constants.FrontWebConstants" %> 
	<%@ page import="framework.common.constants.CommonConstants" %>
	<%@ page import="framework.common.enums.ImageGoodsSize" %>
	
	<tiles:insertDefinition name="common">
	<tiles:putAttribute name="script.include" value="script.order"/>
	<tiles:putAttribute name="script.inline">
	<script type="text/javascript">
	/**
	 * 모바일 타이틀 수정 
	 */
	$(document).ready(function(){
		$("#header_pc").removeClass("mode0");
		$("#header_pc").addClass("mode16");
		$("#header_pc").attr("data-header", "set22");
		$(".mo-heade-tit .tit").html("구매 확정");
		$(".mo-header-backNtn").removeAttr("onclick");
		$(".mo-header-backNtn").bind("click", function(){
			
			if("${mngb}" == "OL"){
				$("#claim_request_list_form").attr("action", "/mypage/order/indexDeliveryList");
			}else if("${mngb}" == "OD"){
				$("#claim_request_list_form").attr("action", "/mypage/order/indexDeliveryDetail");
				$("#claim_request_list_form").attr("method", "get");
				var ordNo = $("#ordNo").val();			
				var hidhtml = "<input type=\"hidden\" name=\"ordNo\"  value="+ ordNo +" /> <input type=\"hidden\" name=\"mngb\"  value=\"OD\" />";
				$("#claim_request_list_form").append(hidhtml);
			}else{
				storageHist.goBack();
			}	
			
			$("#claim_request_list_form").attr("target", "_self");	
			$("#claim_request_list_form").submit();
			
			
		});
		//누적포인트 계산
		getPoint();
	}); // End Ready
	
		$(function(){
					
			if($("input[name='arrListCheckPurchase']").length > 0){
				
			}
			
			
			$("#allPurchase").click(function(){
				
				if($("#allPurchase").prop("checked")){
					
					$("input[type=checkbox]").each(function(){
						if(!$(this).prop("disabled")){
							$(this).prop("checked", true);
						}
					});						
				}else{
					$("input[type=checkbox]").prop("checked",false);
				}
				
			}); 
		
		});
		
		//신청하기 button
		function insertPurchaseList(){		
				
			if($("input[name='arrListCheckPurchase']:checked").length == 0){			
				ui.alert("구매확정할 상품을 선택해주세요.",{					
					ybt:'확인'	
				});
				return;
			} 
			
			if(true){
				//구매확정 불가능한 상품이 포함됐는지 체크 == 구매확정 도중 ord_dtl_stat_cd 가 변경된 경우 
	    		var arrQty = $("input[name='arrListCheckPurchase']");
	    		var checkedNos=[]; //0,1,2
				var checkedOrdDtlSeqs=[];//OrdDtlSeqs
				var checkedCnt = 0 ;
				var result = true;
				for(var i=0; i <arrQty.length; i++){
					if($("#listCheckPurchase"+i).is(":checked") == true){
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
									 if(orderDetailList[i].ordDtlStatCd != "${FrontWebConstants.ORD_DTL_STAT_160}"
											&& orderDetailList[i].ordDtlStatCd != "${FrontWebConstants.ORD_DTL_STAT_150}"){
										 changedSeqs[cnt] = checkedNos[j];
										 cnt++;
										 result = false;
									 }
								 }
							 }
						 }
						 if(!result){
							 ui.alert('<spring:message code="front.web.view.order_purchase.msg.ordDtlStat" />',{
								ycb: function(){
									for(var i=0; i <changedSeqs.length; i++){
										var seq = changedSeqs[i];
										$("#listCheckPurchase"+seq).prop("disabled", true);
										$("#listCheckPurchase"+seq).prop("checked", false);
										$("#ordDtlSeq"+seq).prop("disabled", true);
									}
								},
			  					ybt:'확인'	
			  				});
						 }
					}
				};
				ajax.call(options);
				if(!result){
					return;
				} 
			}
			
			ui.confirm('선택한 상품을 구매확정할까요?',{ // 컨펌 창 띄우기
				ycb:function(){				
					
					setPurchaseOrd();
					insertAccess();
				},
				ybt:'확인',
				nbt:'취소'	
			});		
			
		}
		
		
		function insertAccess(){
			var arrOrdDtlSeq = new Array();
			
			$("input[name=arrListCheckPurchase]:checked").each(function(){
				arrOrdDtlSeq.push($(this).data("id"));
			});	
			var url = "<spring:url value='/mypage/order/purchaseProcess' />";		
			var options = {
					url : url
					, data : {
						ordNo : $("#ordNo").val()
						, arrOrdDtlSeq : arrOrdDtlSeq
					}
					, done : function(data){					
						if(data != null){					
							jQuery("<form action=\"/mypage/order/indexPurchaseCompletion\" method=\"post\"><input type=\"hidden\" name=\"ordNo\" value=\""+data.ordNo+"\" /><input type=\"hidden\" name=\"arrOrdDtlSeq\" value=\""+data.arrOrdDtlSeq+"\" /></form>").appendTo('body').submit();
						}
					}
			};		
			
			ajax.call(options);
		}
	    
		
		function setPurchaseOrd() {		
			var arrListCheckPurchase = $("input[name=arrListCheckPurchase]");			
			for(var i=0; i <arrListCheckPurchase.length; i++){			
				
				if($("#listCheckPurchase"+i).is(":checked") == true){				
					$("#ordDtlSeq"+i).prop("disabled", false);				
				}else{				
					$("#ordDtlSeq"+i).prop("disabled", true);
				}
			}		
		}
		
		
		function searchPurchaseRequestList(){
			
			if("${mngb}" == "OL"){
				$("#claim_request_list_form").attr("action", "/mypage/order/indexDeliveryList");
			}else if("${mngb}" == "OD"){
				$("#claim_request_list_form").attr("action", "/mypage/order/indexDeliveryDetail");
				$("#claim_request_list_form").attr("method", "get");
				var ordNo = $("#ordNo").val();			
				var hidhtml = "<input type=\"hidden\" name=\"ordNo\"  value="+ ordNo +" />";
				$("#claim_request_list_form").append(hidhtml);
			}else{
				$("#claim_request_list_form").attr("action", "/mypage/order/indexClaimList");	
			}	
		
			
			$("#claim_request_list_form").attr("target", "_self");	
			$("#claim_request_list_form").submit();
		}
		
		
		//누적포인트 계산
		function getPoint(){
			var point = 0;
			var arrListCheckPurchase = $("input[name=arrListCheckPurchase]");			
			for(var i=0; i <arrListCheckPurchase.length; i++){			
				
				if($("#listCheckPurchase"+i).is(":checked") == true){				
					point += parseInt(arrListCheckPurchase[i].value);
					
				}
			}
	
			point = point.toLocaleString('ko-KR');
			
			$("#isuSchdPnt").html(point+"P");				
		
		}
		
	</script>
	</tiles:putAttribute>
	
	<tiles:putAttribute name="content">
	
		<c:if test="${view.deviceGb eq frontConstants.DEVICE_GB_10 }">
			<jsp:include page="/WEB-INF/tiles/include/lnb_my.jsp" />
			<jsp:include  page="/WEB-INF/tiles/include/menubar.jsp" />
		</c:if>
	
		<!-- 바디 - 여기위로 템플릿 -->
		<form id="claim_request_list_form" name="claim_request_list_form" method="post"></form>		
		<form id="purchase_request_list_form" name="purchase_request_list_form" method="post">
		<input type="hidden" id="ordNo" name="ordNo" value="${so.ordNo}" />
		<main class="container lnb page shop my" id="container">
			<div class="inr">			
				<!-- 본문 -->
				<div class="contents" id="contents">
					<div class="pc-tit">
						<h2>구매확정</h2>
					</div>
			<c:choose>
				<c:when test="${order ne '[]'}">	
					<div class="exchange-area pc-reposition">
						<div class="item-box pc-reposition t2 pdt">
							<div class="oder-cancel t2">
								<ul>
								<c:forEach items="${order.orderDetailListVO}" var="orderPurchase" varStatus="idx1">							
							
								<c:set value="${orderPurchase.ordDtlStatCd}" var="ordDtlStatCd"/>
								<c:set value="${idx1.index}" var="index"/>						
								<c:set value="${orderPurchase.rmnOrdQty - orderPurchase.rtnQty - orderPurchase.clmExcQty}" var="rmnOrdQty"/>		
									<input type="hidden" id="ordDtlSeq${index}" name="arrOrdDtlSeq"  value="${orderPurchase.ordDtlSeq}" />
									
									<c:if test="${rmnOrdQty > 0}" >								
									<li>
										<c:if test="${idx1.first}"><!-- label class="checkbox"><input type="checkbox" id="allPurchase"><span class="txt">전체 선택 </span></label--></c:if>
										<div class="untcart <c:if test="${idx1.first}">cancel</c:if>">
											
											<label class="checkbox">
										<c:choose>
											<c:when test="${orderPurchase.clmIngYn eq 'Y'}">
												<input type="checkbox" disabled="true"><span class="txt"></span>								
											</c:when>
											<c:otherwise>
												<!-- 구매확정페이지 들어왔을때 모든 상품 체크 -->
												<%-- <c:choose>
													<c:when test="${!empty orderSO.ordDtlSeq}">										
														<input type="checkbox" id="listCheckPurchase${index}" onClick="getPoint();" name="arrListCheckPurchase" value="${orderPurchase.isuSchdPnt }" <c:if test="${orderSO.ordDtlSeq eq orderPurchase.ordDtlSeq }">checked="true"</c:if> ><span class="txt"></span>								
													</c:when>
													<c:otherwise>
														<input type="checkbox" id="listCheckPurchase${index}" onClick="getPoint();" name="arrListCheckPurchase" checked="true" value="${orderPurchase.isuSchdPnt }"><span class="txt"></span>
													</c:otherwise>
												</c:choose> --%>											
												<input type="checkbox" id="listCheckPurchase${index}" onClick="getPoint();" name="arrListCheckPurchase" checked="true" value="${orderPurchase.isuSchdPnt }" data-id="${orderPurchase.ordDtlSeq }"><span class="txt"></span>
												
											</c:otherwise>
										</c:choose>
											</label>					
											
											<div class="box">
												<div class="tops">
													<div class="pic"><a href="/goods/indexGoodsDetail?goodsId=${not empty orderPurchase.pakGoodsId ? orderPurchase.pakGoodsId : orderPurchase.goodsId }" data-content="${not empty orderPurchase.pakGoodsId ? orderPurchase.pakGoodsId : orderPurchase.goodsId }" data-url="/goods/indexGoodsDetail?goodsId=${not empty orderPurchase.pakGoodsId ? orderPurchase.pakGoodsId : orderPurchase.goodsId }">												
													<img src="${fn:indexOf(orderPurchase.imgPath, 'cdn.ntruss.com') > -1 ? orderPurchase.imgPath : frame:optImagePath(orderPurchase.imgPath, frontConstants.IMG_OPT_QRY_270)}" alt="${orderPurchase.goodsNm }" class="img">
													</a></div>
													<div class="name">
														<div class="tit" style="padding-top:0px"><c:out value="${orderPurchase.goodsNm}" /></div>
														<div class="stt"><frame:num data="${rmnOrdQty}" />개 
														<c:choose>
															<c:when test="${orderPurchase.goodsCstrtTpCd eq FrontWebConstants.GOODS_CSTRT_TP_PAK && not empty orderPurchase.optGoodsNm}">	<!-- 상품 구성 유형 : 묶음 -->
															/ ${fn:replace(orderPurchase.optGoodsNm, '/', ' / ')}
															</c:when>
															<c:when test="${orderPurchase.goodsCstrtTpCd eq FrontWebConstants.GOODS_CSTRT_TP_ATTR && not empty orderPurchase.pakItemNm}">	<!-- 상품 구성 유형 : 옵션 -->
															/ ${fn:replace(orderPurchase.pakItemNm, '|', ' / ')}
															</c:when>
														</c:choose>
														<c:if test="${orderPurchase.mkiGoodsYn eq 'Y' && not empty orderPurchase.mkiGoodsOptContent }">
															<c:forTokens var="optContent" items="${orderPurchase.mkiGoodsOptContent }" delims="|" varStatus="conStatus">	
																<div class="stt">각인문구${conStatus.count} : ${optContent}</div>
															</c:forTokens>
														</c:if>
														
														</div>
														<div class="price">
															<span class="prc"><em class="p"><frame:num data="${(orderPurchase.saleAmt - orderPurchase.prmtDcAmt)*rmnOrdQty}" /></em><i class="w">원</i></span>
														</div>
													</div>
												</div>
											</div>
										</div>
									</li>
									</c:if>
								</c:forEach>
										
								</ul>
							</div>
						</div>
						<div class="info-txt">
							<ul>
								<li>구매확정 이후에는 <span class="fc_blue">반품 및 교환이 불가</span>하므로 반드시 상품을 배송 받으신 후 진행해주세요.</li>
								<li>구매확정 시 포인트가 적립됩니다.</li>
							</ul>
						</div>
						<div class="bts">
							<div class="btnSet space pc-reposition">
								<a href="#" data-content="" data-url="" onclick="searchPurchaseRequestList();return false;" class="btn lg d">취소</a>										
								<a href="#" data-content="" data-url="/mypage/insertClaimCancelExchangeRefund" onclick="insertPurchaseList();return false;" class="btn lg a">구매확정</a>						
							</div>
						</div>
					</div>
			</c:when>			
		</c:choose>		
					
					
				</div>
	
			</div>
		</main>			
		</form>
	
		
		<div class="layers">			
		</div>
		<!-- 바디 - 여기 밑으로 템플릿 -->
	
	</tiles:putAttribute>
	</tiles:insertDefinition>