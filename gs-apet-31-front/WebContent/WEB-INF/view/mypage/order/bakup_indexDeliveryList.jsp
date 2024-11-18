<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="/WEB-INF/tld/frame.tld" prefix="frame" %>
<%@ page import="front.web.config.constants.FrontWebConstants" %>
<%@ page import="framework.common.enums.ImageGoodsSize" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<script type="text/javascript">

	$(document).ready(function(){
		
		// 페이지 클릭 이벤트
		$("#delivery_list_page a").click(function(){
			var page =$(this).children("span").html();
			orderDeliveryList.setPage(page);
		});
		
	}); // End Ready

	$(function() {
		calendar.range("delivery_start_dt", "delivery_end_dt", {yearRange : 'c-10:c'});
	});

	
	/*
	 * 주문/배송 목록
	 */
	var orderDeliveryList = {
		// 재조회			
		reload : function(){
			$("#delivery_list_form").attr("target", "_self");
			$("#delivery_list_form").attr("action", "/mypage/order/indexDeliveryList");
			$("#delivery_list_form").submit();
		}
		// 기간버튼 클릭 시
		, setPeriod : function(period){
			$("input[name=period]").val(period);
			calendar.autoRange("delivery_start_dt", "delivery_end_dt", period);
			this.setSearchDate();
		}
		// 조회 버튼
		, search : function(){
			$("input[name=period]").val("");
			this.setSearchDate();
		}
		// 페이지 클릭
		, setPage : function(page){
			$("#delivery_list_page").val(page);
			this.reload();
		}
		, setSearchDate  : function(){
			var startDt = new Date($('#delivery_start_dt').val());
			var endDt = new Date($('#delivery_end_dt').val());
			
			var diff = endDt.getTime() - startDt.getTime(); 
			
			if ( 365 < Math.floor(diff/(1000*60*60*24)) ) {
				alert("조회기간은 최대 12개월까지 설정가능 합니다.");
				return;
			}
			
			// 조회시 페이징관련 변수 초기화
			$("#delivery_list_page").val("1");
			
			this.reload();			
		}
		
	}

	/*
	 * 주문/배송 목록 버튼
	 */
	var orderDeliveryListBtn = {
		// 상품 상세 이동
		goOrderDetail : function(ordNo){
			var inputs = "<input type=\"hidden\" name=\"ordNo\" value=\""+ordNo+"\"/>";
			jQuery("<form action=\"/mypage/order/indexDeliveryDetail\" method=\"get\">"+inputs+"</form>").appendTo('body').submit();
		}
		// 상품평 등록 팝업
		, openGoodsComment : function(sGoodsId, sOrdNo , sOrdDtlSeq){
			var options = {
					url : "/mypage/service/popupGoodsCommentReg",
					params : {goodsId : sGoodsId, goodsEstmNo : '', ordNo : sOrdNo, ordDtlSeq : sOrdDtlSeq},
					width : 580,
					height: 598,
					callBackFnc : "orderDeliveryList.reload",
					modal : true
				};
				pop.open("popupGoodsCommentReg", options);	
		}
		// 옵션 변경 팝업
		, openOptionChange : function(ordNo, ordDtlSeq){
			var params = {
				ordNo : ordNo,
				ordDtlSeq : ordDtlSeq,
				mode : "order",
				callBackFnc : "orderDeliveryListBtn.cbOptionChange"
			};
			pop.orderOptionChange(params);
		}
		// 옵션 변경 CallBack
		, cbOptionChange : function(){
			location.reload();
		}
		// 구매확정
		, purchase : function(ordNo, ordDtlSeq){
			if(confirm(' <spring:message code="front.web.view.mypage.order.detail.statcd.update.confirm" />')){ 
				var options = {
						   url : "<spring:url value='/mypage/order/purchaseProcess' />"
						, data : { ordNo : ordNo, ordDtlSeq : ordDtlSeq }
						, done : function(data){
							alert('<spring:message code="front.web.view.mypage.order.detail.statcd.update.success" />');	
							orderDeliveryList.reload();
						}
					}; 
				ajax.call(options);
			}
		}
		// 주문취소 페이지 
		, goCancelRequest : function(ordNo, ordDtlSeq){
			var action = "/mypage/order/indexCancelRequest";
			
			$("#delivery_list_ord_no").val(ordNo);
			$("#delivery_list_ord_dtl_seq").val(ordDtlSeq);
			$("#claim_request_list_form").attr("target", "_self");
			$("#claim_request_list_form").attr("method", "post");
			$("#claim_request_list_form").attr("action", action);
			$("#claim_request_list_form").submit();
		}
		// 교환 신청
		, goExchangeRequest : function(ordNo ,ordDtlSeq){
			var action = "/mypage/order/indexExchangeRequest";
			
			$("#delivery_list_ord_no").val(ordNo);
			$("#delivery_list_ord_dtl_seq").val(ordDtlSeq);
			$("#claim_request_list_form").attr("target", "_self");
			$("#claim_request_list_form").attr("method", "post");
			$("#claim_request_list_form").attr("action", action);
			$("#claim_request_list_form").submit();			
		}
		// 반품 신청
		, goReturnRequest : function(ordNo, ordDtlSeq, rtnIngYn, rtnPsbYn){
			
			if(rtnIngYn == "Y"){
				alert("<spring:message code='front.web.view.claim.refund.claim_ing' />");
				return;
			}

			if(rtnPsbYn != "Y"){
				alert("<spring:message code='front.web.view.claim.refund.claim_psb' />");
				return;
			}
			
			var action = "/mypage/order/indexReturnRequest";
			
			$("#delivery_list_ord_no").val(ordNo);
			$("#delivery_list_ord_dtl_seq").val(ordDtlSeq);
			$("#claim_request_list_form").attr("target", "_self");
			$("#claim_request_list_form").attr("method", "post");
			$("#claim_request_list_form").attr("action", action);
			$("#claim_request_list_form").submit();			
		}
	} 
	
</script>

<div class="box_title_area">
	<h3>주문배송조회</h3>
	<div class="sub_text2">기간 및 날짜 조회를 통해 최근 5년간의 주문 이력('정보통신망법 제29조'에 의거)을 최대 12개월 설정하여 조회 가능합니다.</div>
</div>

<!-- 주문 조회 -->
<form id="delivery_list_form">
<div class="order_lookup_box mgt10">
	<dl>
		<dt>기간별 조회</dt>
		<dd>
			<div class="btn_period_group">
				<a href="#" id="period_type_1" 	class="btn_period <c:if test="${orderSO.period eq '1'}">on</c:if>" onclick="orderDeliveryList.setPeriod(1);return false;">1개월</a>
				<a href="#" id="period_type_3" 	class="btn_period <c:if test="${orderSO.period eq '3'}">on</c:if>" onclick="orderDeliveryList.setPeriod(3);return false;">3개월</a>
				<a href="#" id="period_type_6" 	class="btn_period <c:if test="${orderSO.period eq '6'}">on</c:if>" onclick="orderDeliveryList.setPeriod(6);return false;">6개월</a>
				<a href="#" id="period_type_12" class="btn_period <c:if test="${orderSO.period eq '12'}">on</c:if>" onclick="orderDeliveryList.setPeriod(12);return false;">12개월</a>
				<input type="hidden" name="period" value="<c:out value="${orderSO.period}" />" />
			</div>
		</dd>
	</dl>
	<dl class="mgl20">
		<dt>날짜조회</dt>
		<dd>
			<span class="datepicker_wrap">
				<input type="text" id="delivery_start_dt" name="ordAcptDtmStart" readonly="readonly" class="datepicker" value="<frame:timestamp date="${orderSO.ordAcptDtmStart}" dType="H" />" title="날짜" />
			</span>
			-
			<span class="datepicker_wrap">
				<input type="text" id="delivery_end_dt" name="ordAcptDtmEnd" readonly="readonly" class="datepicker" value="<frame:timestamp date="${orderSO.ordAcptDtmEnd}" dType="H" />" title="날짜" />
			</span>
		</dd>
	</dl>
	<a href="#" onclick="orderDeliveryList.search();return false;" class="btn_h25_type1 mgl10">조회</a>
</div>
<!-- //주문 조회 -->

<!-- 조회내역 -->
<div class="mgt20">
	<div class="point3">
		※ <frame:timestamp date="${orderSO.ordAcptDtmStart}" dType="H" /> ~ <frame:timestamp date="${orderSO.ordAcptDtmEnd}" dType="H" /> 까지의 주문 총 <b class="point2">${orderSO.totalCount}건</b> 입니다.
		<span class="f_right">이전 주문 내역 보러가기 &gt;&nbsp;<a href="http://www.naver.com" class="btn_h20_type5" title="이전주문보기" target="_blank">이전주문보기</a></span>									
	</div>
	<table class="table_cartlist1 mgt10">
		<caption>주문내역</caption>
		<colgroup>
			<col style="width:14%">
			<col style="width:12%">	
			<col style="width:70px">
			<col style="width:*">
			<col style="width:10%">
			<col style="width:10%">
			<col style="width:10%">
		</colgroup>
		<thead>
			<tr>
				<th scope="col">주문번호</th>
				<th scope="col">결제금액</th>
				<th scope="col" colspan="2">상품정보</th>
				<th scope="col">배송/판매자</th>
				<th scope="col">주문상태</th>
				<th scope="col">주문변경</th>
			</tr>
		</thead>
		<tbody>
<c:choose>
<c:when test="${!empty orderList}">
	<c:forEach items="${orderList}" var="orderBase" varStatus="idx">
		<c:set var="rowspan_class" value="_n" />
		<c:set var="rowspan_cnt" value="${fn:length(orderBase.orderDetailListVO)}"/>
			
		<c:if test="${rowspan_cnt > 1}">
			<c:set var="rowspan_class" value="" />
		</c:if>

		<c:forEach items="${orderBase.orderDetailListVO}" var="orderDetail" varStatus="dIdx">
			<tr>
			<%-- 주문번호 및 결제금액 영역 --%>
   	  		<c:if test="${dIdx.first}">
	   	  		<!-- 주문 번호 -->
                <td class="rowspan<c:out value="${rowspan_class}"/>" <c:if test="${rowspan_cnt  > 1}">rowspan="<c:out value="${rowspan_cnt}"/>"</c:if>>
					<div><a href="#" onclick="orderDeliveryListBtn.goOrderDetail('${orderBase.ordNo}');return false;" class="order_number">${orderBase.ordNo}</a></div>
					<div class="mgt4"><span class="order_date01">(<frame:timestamp date="${orderBase.ordAcptDtm}" dType="H" />)</span></div>
					<div class="mgt4"><a href="#" class="btn_h20_type6" onclick="orderDeliveryListBtn.goOrderDetail('${orderBase.ordNo}');return false;">주문상세보기</a></div>
					
				<c:if test="${orderBase.cncPsbYn eq FrontWebConstants.COMM_YN_Y}">
					<c:if test="${fn:length(orderBase.orderDetailListVO) > 1}">
						<div class="mgt4">
							<a href="#" class="btn_h20_type6" onclick="orderDeliveryListBtn.goCancelRequest('${orderBase.ordNo}', '');return false;">주문전체취소</a>
						</div>
					</c:if>
				</c:if>
				</td>
	   	  		<!-- // 주문 번호 -->
	   	  		<!-- 결제 금액 -->
				<td class="rowspan<c:out value="${rowspan_class}"/>" <c:if test="${rowspan_cnt > 0}">rowspan="<c:out value="${rowspan_cnt}"/>"</c:if>>
					<frame:num data="${orderBase.payAmtTotal}" />원
				</td>
	   	  		<!-- // 결제 금액 -->
   	  		</c:if>
			<%-- // 주문번호 및 결제금액 영역 --%>
   			<%-- 주문상품, 배송/판매자, 진행상태, 주문관리 영역 --%>
   				<!-- 상품 이미지 -->
				<td class="img_cell v_top">
					<a href="/goods/indexGoodsDetail?goodsId=<c:out value="${orderDetail.goodsId }"/>">
					<frame:goodsImage goodsId="${orderDetail.goodsId}" seq="${orderDetail.imgSeq}" imgPath="${orderDetail.imgPath}" size="${ImageGoodsSize.SIZE_70.size}" gb="" />
					</a>
				</td>
				<!-- // 상품 이미지 -->
				<!-- 상품정보 -->
				<td class="align_left v_top">
					<div class="product_name">
						<a href="/goods/indexGoodsDetail?goodsId=${orderDetail.goodsId }"> [${orderDetail.bndNmKo}] ${orderDetail.goodsNm}</a>
                        <div class="product_option">
                            <span>${orderDetail.itemNm}</span>
							<c:if test="${(orderDetail.itemMngYn eq FrontWebConstants.COMM_YN_Y) and ((orderDetail.ordDtlStatCd eq FrontWebConstants.ORD_DTL_STAT_110) or (orderDetail.ordDtlStatCd eq FrontWebConstants.ORD_DTL_STAT_120))}">
								<a href="#" class="btn_h16_type2" onclick="orderDeliveryListBtn.openOptionChange('${orderBase.ordNo}', '${orderDetail.ordDtlSeq}');return false;">옵션변경</a>
							</c:if>
						</div>
						<div class="product_cost">
                            <frame:num data="${orderDetail.saleAmt - orderDetail.prmtDcAmt}"/>원						  
							/ ${orderDetail.rmnOrdQty - orderDetail.rtnQty - orderDetail.clmExcIngQty}개	
						</div>
					</div>
				</td>
				<!-- // 상품정보 -->
				<!--  배송/판매자 정보 -->
				<td>
					<c:out value="${orderDetail.compNm}" />
				</td>
				<!--  // 배송판매자 정보 -->
				<!-- 진행상태 -->
				<td>
					<div>
						<frame:codeValue items="${ordDtlStatCdList}" dtlCd="${orderDetail.ordDtlStatCd}" type="S"/>
						<c:if test="${orderDetail.ordDtlStatCd eq FrontWebConstants.ORD_DTL_STAT_150 or orderDetail.ordDtlStatCd eq FrontWebConstants.ORD_DTL_STAT_160}">
						<!-- 2017.9.29, 배송조회 연동 중단 처리 -->
                        <%--
							<c:if test="${orderDetail.clmIngYn eq FrontWebConstants.COMM_YN_N  and orderDetail.vldOrdQty > 0}">
								<div>
								   <a href="#" onclick="openDeliveryInquire('${orderBase.ordNo}', '${orderDetail.ordDtlSeq}', '${FrontWebConstants.ORD_CLM_GB_10}');return false;" class="btn_h20_type6 fix_w65">배송조회</a>
								</div>					 
							</c:if>
						--%>
						</c:if>
						<c:if test="${  orderDetail.ordDtlStatCd eq FrontWebConstants.ORD_DTL_STAT_170}">
							<c:if test="${session.mbrNo ne FrontWebConstants.NO_MEMBER_NO }">
								<c:if test="${ orderDetail.goodsEstmRegYn ne FrontWebConstants.COMM_YN_Y  }">
				                    <div>
				                        <a href="#" onclick="orderDeliveryListBtn.openGoodsComment('${orderDetail.goodsId}','${orderBase.ordNo}','${orderDetail.ordDtlSeq}');return false;" class="btn_h20_type6 fix_w65">리뷰작성</a>
				                    </div>  
				                </c:if>
								<c:if test="${ orderDetail.goodsEstmRegYn eq FrontWebConstants.COMM_YN_Y  }">
									<div>
									   <a href="/mypage/service/indexGoodsCommentList" class="btn_h20_type6 fix_w65 btn_disabled">리뷰보기</a>
				                    </div>        
								</c:if>
							</c:if>
							<!-- 2017.9.29, 배송조회 연동 중단 처리 -->
                            <%--
							<div>
							   <a href="#" onclick="openDeliveryInquire('${orderBase.ordNo}', '${orderDetail.ordDtlSeq}', '${FrontWebConstants.ORD_CLM_GB_10}');return false;" class="btn_h20_type6 fix_w65">배송조회</a>
							</div>
							--%>
						</c:if>
					</div>
				</td>
				<!-- // 진행상태 -->
				<!-- 주문 관리 -->
				<td>
					<c:if test="${(orderDetail.ordDtlStatCd eq FrontWebConstants.ORD_DTL_STAT_120 
									or (orderDetail.ordDtlStatCd eq FrontWebConstants.ORD_DTL_STAT_110 and fn:length(orderBase.orderDetailListVO) eq 1)) 
									and orderDetail.rmnOrdQty > 0}">      
		                <div>
						   <a href="#" class="btn_h20_type6 fix_w65" onclick="orderDeliveryListBtn.goCancelRequest('${orderBase.ordNo}', '${orderDetail.ordDtlSeq}');return false;">주문취소</a>
						</div>
					</c:if> 
		 			<c:if test="${orderDetail.ordDtlStatCd eq FrontWebConstants.ORD_DTL_STAT_160}">
						<c:if test="${orderDetail.clmIngYn eq FrontWebConstants.COMM_YN_N and orderDetail.vldOrdQty > 0 }">
					         <div>
					             <a href="#" onclick="orderDeliveryListBtn.purchase('<c:out value='${orderBase.ordNo}' />', '<c:out value='${orderDetail.ordDtlSeq}' />');return false;" class="btn_h20_type6 fix_w65">구매확정</a>
				             </div>
						</c:if>
		 				<c:if test="${orderDetail.rmnOrdQty - orderDetail.rtnQty - orderDetail.clmExcIngQty > 0 }">
							<div>
							   <a href="#" class="btn_h20_type6 fix_w65" onclick="orderDeliveryListBtn.goReturnRequest('${orderBase.ordNo}','${orderDetail.ordDtlSeq}' , '${orderDetail.rtnIngYn}', '${orderDetail.rtnPsbYn}');return false;">반품신청</a>
							</div>
							<div>
							   <a href="#" class="btn_h20_type6 fix_w65" onclick="orderDeliveryListBtn.goExchangeRequest('${orderBase.ordNo}','${orderDetail.ordDtlSeq}');return false;" >교환신청</a>
							</div>
		 				</c:if>
					</c:if>
				</td>
				<!-- // 주문 관리 -->
			</tr>			
		</c:forEach>
	</c:forEach>
</c:when>
<c:otherwise>
			<tr>
				<td colspan="7" class="nodata">최근 주문내역이 없습니다.</td>
			</tr>
</c:otherwise>
</c:choose>
		</tbody>
	</table>
	
	<!-- 페이징 -->
	<span id="spanOrderListPaging">
		<input type="hidden" id="delivery_list_page" name="page" value="<c:out value="${orderSO.page}" />" />
		<input type="hidden" id="delivery_list_rows" name="rows" value="<c:out value="${orderSO.rows}" />" />
		<frame:listPage recordPerPage="${orderSO.rows}" currentPage="${orderSO.page}" totalRecord="${orderSO.totalCount}" indexPerPage="5" id="delivery_list_page" />
	</span> 
	<!-- 페이징 -->
	<!-- // 조회내역 -->
	
	<!-- 주문배송조회 안내 -->
	<div class="note_box1 mgt30">
		<h2 class="title">주문배송조회 안내</h2>
		<ul class="ul_list_type1">
			<li>주문이 정상적으로 완료되지 않은 경우 주문배송조회가 되지 않습니다.</li>
			<!-- 서비스 축소 
			<li>주문상품의 배송조회 버튼을 클릭하시면 배송추적이 가능합니다.</li>
			<li>구매하신 상품의 배송추적은 발송 다음날 오전 이후부터 가능합니다.</li>
			 -->
			<li>결제금액은 주문 시 배송비, 적립금, 쿠폰 할인 등에 따라 달라질 수 있으며, 자세한 정보를 확인하시려면 주문상세보기 버튼을 클릭하세요.</li>
			<li>배송완료 후 구매확정을 하지 않은 경우 배송이 완료일로부터 7일 경과 후, 8일째 자동으로 구매확정 됩니다.</li>
			<li>구매확정 이후에는 반품 또는 교환 처리는 어려우니 신중히 결정해주시기 바랍니다.</li>
			<li><b>2017년 8월 8일 이전 주문 내역은 조회내역 상단에 '이전주문보기' 클릭 후 로그인하여 확인 바랍니다.</b></li>
		</ul>
	</div>
	<!-- //주문배송조회 안내 -->
</div>
</form>

<!-- 주문배송 절차안내 -->
<div class="box_title_area mgt30">
	<h3>주문배송 절차안내</h3>
</div>
<div class="order_shipping_process_table">
	<table>
		<caption>주문배송 절차 안내표</caption>
		<colgroup>
			<col style="width:20%" />
			<col style="width:20%" />
			<col style="width:20%" />
			<col style="width:20%" />
			<col style="width:auto;" />
		</colgroup>
		<tbody>
			<tr>
				<td class="process1">
					<div class="process_tit">
						<strong>주문접수</strong>
						<p>입금을<br />기다리고 있습니다.</p>
					</div>
					<div class="permit_list">
						<ul>
							<li>
								<strong>주문취소</strong>
								<strong class="permit">O</strong>
							</li>
							<li>
								<strong>교환/반품</strong>
								<strong class="permit">X</strong>
							</li>
						</ul>
					</div>
					<div class="described_area">
						※ 미입금시 7일 후 주문건은 삭제
					</div>
				</td>
				<td class="process2">
					<div class="process_tit">
						<strong>결제완료</strong>
						<p>결제가 <br />확인 되었습니다.</p>
					</div>
					<div class="permit_list">
						<ul>
							<li>
								<strong>주문취소</strong>
								<strong class="permit">O</strong>
							</li>
							<li>
								<strong>교환/반품</strong>
								<strong class="permit">X</strong>
							</li>
						</ul>
					</div>
					<div class="described_area">
						※ 결제당일 결제완료 처리
					</div>
				</td>
				<td class=" process3">
					<div class="process_tit">
						<strong>상품준비중</strong>
						<p>주문하신 상품을 <br /> 준비하고 있습니다.</p>
					</div>
					<div class="permit_list">
						<ul>
							<li>
								<strong>주문취소</strong>
								<strong class="permit">X</strong>
							</li>
							<li>
								<strong>교환/반품</strong>
								<strong class="permit">X</strong>
							</li>
						</ul>
					</div>
					<div class="described_area">
						※ 결제완료 후 1~2일 소요 <br />
						(상품/판매업체에 따라 다름)
					</div>
				</td>
				<td class="process4">
					<div class="process_tit">
						<strong>배송중</strong>
						<p>주문하신 상품이 배차<br />
						확정.출고되어 배송중입니다.</p>
					</div>
					<div class="permit_list">
						<ul>
							<li>
								<strong>주문취소</strong>
								<strong class="permit">X</strong>
							</li>
							<li>
								<strong>교환/반품</strong>
								<strong class="permit">X</strong>
							</li>
						</ul>
					</div>
					<div class="described_area">
						※ 결제완료 후 3~7일 소요<br />
					</div>
				</td>
				<td class="process5">
					<div class="process_tit">
						<strong>배송완료</strong>
						<p>고객님께서 상품을 <br />수령하셨습니다.</p>
					</div>
					<div class="permit_list">
						<ul>
							<li>
								<strong>주문취소</strong>
								<strong class="permit">X</strong>
							</li>
							<li>
								<strong>교환/반품</strong>
								<strong class="permit">O</strong>
							</li>
						</ul>
					</div>
					<div class="described_area">
						※ 배송확인 후 완료 처리
					</div>
				</td>
			</tr>
		</tbody>
	</table>
</div>

<form id="claim_request_list_form"> 
	<input type="hidden" id="delivery_list_ord_no" name="ordNo" value="" /> 
	<input type="hidden" id="delivery_list_ord_dtl_seq" name="ordDtlSeq" value="" /> 
	<input type="hidden" id="clmTpCd" name="clmTpCd" value=""/>
	<input type="hidden" id="checkCode" name="checkCode" value="" />
</form>
<!-- //주문배송 절차안내 -->