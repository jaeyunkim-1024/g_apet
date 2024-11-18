<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="/WEB-INF/tld/frame.tld" prefix="frame" %>
<%@ page import="front.web.config.constants.FrontWebConstants" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="framework.common.enums.ImageGoodsSize" %>

<script type="text/javascript">
	// 체크박스 선택한 주문번호
	var chkOrdNo = "";
	
	$(document).ready(function(){
		
		//$(".checkbox").attr('disabled', true);
		$("input[name=goodsIds]").attr('disabled', true);
		
		// 페이지 클릭 이벤트
		$("#order_list_page a").click(function(){
			var page =$(this).children("span").html();
			$("#order_list_page").val(page);
			searchPeriod();
		});
		
		// 검색기간 설정
		if('${orderSO.period }' == null || '${orderSO.period }' == ''){
			$("input[name=period]").val('15');
			$(".period15").addClass("active");
		}else{
			$("input[name=period]").val('${orderSO.period }');
		}
		
		// 주문데이처 펼침
		$('.btn_show_hide').click(function() {
			if($(this).hasClass('on')){
				$(this).removeClass('on').parents('.show_hide_box_head').next().hide();
			}else{
				$(this).addClass('on').parents('.show_hide_box_head').next().show();
			};
			return false;
		});
		
		// 라디오버튼 선책 (주문번호 다른 체크박스 선택시 이전 체크박스 해제)
		$(".radio").click(function(){
			
			var radioVal = $(this).val();
			
			// 전체 체크 해제
			//$(".checkbox:checked").prop('checked', false);
			//$(".checkbox").attr('disabled', true);
			$("input[name=goodsIds]:checked").prop('checked', false);
			$("input[name=goodsIds]").attr('disabled', true);
			
			// 선택항목 체크박스 활성화
			$("input[id^="+radioVal+"]").removeAttr('disabled');
			
		});
		
		// 체크박스 선책 (주문번호 다른 체크박스 선택시 이전 체크박스 해제)
		$("input[name=goodsIds]").click(function(){
			
			var sumText = $(this).val();
			var eachText = sumText.split("|");
			
			chkOrdNo = eachText[0];
		});
		
	}); // End Ready
	
	// Calendar 생성
	$(function() {
		calendar.range("start_dt", "end_dt", {yearRange : 'c-10:c'});
	});
	
	// 기간선택 시 날짜 설정
	function setPeriod(period) {
		$("input[name=period]").val(period);
		
		// 조회시 페이징관련 변수 초기화
		$("#order_list_page").val("1");
		
		if(period == '15'){
			calendar.autoRangeDay("start_dt", "end_dt", period);
			searchPeriod();
			
		}else {
			calendar.autoRange("start_dt", "end_dt", period);
			searchPeriod();
		}
	}
	
	function searchPeriod(){
		ajax.load("poppuOrderList", "/mypage/order/popupOrderList", $("#order_list_form").serializeJson());
	}
	
	// 취소버튼
	function goPage(){
		//$(".checkbox").attr('disabled', false);
		$("input[name=goodsIds]").attr('disabled', false);
		
		pop.close('<c:out value="${param.popId}" />'); 
	}
	
	// 주문정보 선택 후 확인버튼 (선택된 주문정보 값 넘김)
	function checkedOrder() {
		var orderInfo = new Array();
		var checkdOrderList = $("input[name=goodsIds]:checked");
		
		if(checkdOrderList.length > 0){
			for(var i=0; i < checkdOrderList.length; i++){
				
				orderInfo.push(
						$(checkdOrderList[i]).val()
				);
			}
		}
		
		var data = {
			orderInfo : orderInfo
		};
		
		//$(".checkbox").attr('disabled', false);
		$("input[name=goodsIds]").attr('disabled', false);
		
		<c:out value="${param.callBackFnc}" />(data);
		pop.close("<c:out value="${param.popId}" />");
	}
	
	/*
	 * 주문상세 페이지 이동
	 */
	function goOrderDetail(ordNo){
		var inputs = "<input type=\"hidden\" name=\"ordNo\" value=\""+ordNo+"\"/>";
		jQuery("<form action=\"/mypage/order/indexDeliveryDetail\" method=\"get\">"+inputs+"</form>").appendTo('body').submit();
	}
	
</script>

<form id="order_list_form">
	<input type="hidden" id="callBackFnc" name="callBackFnc" value="${param.callBackFnc}" />
	<input type="hidden" id="popId" name="popId" value="${param.popId}" />

<div id="poppuOrderList">
	<!-- pop_wrap -->
	<div class="pop_content_wrap">
		<!-- pop_contents -->
		<div class="pop_contents">
			<div class="note_box1">				
				<ul class="ul_list_type1">			
					<li>최근 3개월의 주문내역을 조회하실 수 있습니다.</li>
					<li>주문번호의 상품 별 문의가 가능합니다.</li>
					<li>주문내역이 없는 경우 [주문정보-문의없음]을 선택 후 문의해주시기 바랍니다.</li>
				</ul>
			</div>
		
		<style>
		.answerList_tab {height:40px;margin-bottom:30px;}
		.answerList_tab li {text-align:center;float:left;padding-top:9px; width:33.33333%;margin-left:-1px;height:40px; border:1px solid #dadada; background:#fff; color:#333; font-size:13px;box-sizing:border-box; }
		.answerList_tab li a {display:block;}
		.answerList_tab li.active {background:#666; color:#fff; font-size:13px}
		</style>
		
		<div class="orderList">
			<div class="answerList_tab mgt30">				
				<ul class="">
					<li class="period15 <c:if test="${orderSO.period eq '15'}">active</c:if>" ><a href="javascript:void(0)" id="period_type_15" onclick="setPeriod('15');return false;">15일</a></li>
					<li class="<c:if test="${orderSO.period eq '1'}">active</c:if>" ><a href="javascript:void(0)" id="period_type_1" onclick="setPeriod('1');return false;">1개월</a></li>
					<li class="<c:if test="${orderSO.period eq '3'}">active</c:if>" ><a href="javascript:void(0)" id="period_type_3" onclick="setPeriod('3');return false;">3개월</a></li>
				</ul>
				<input type="hidden" name="period" value="<c:out value="${orderSO.period}" />" />
			</div>
			
			<table class="table_cartlist1 mgt10">
				<caption>주문내역</caption>
				<colgroup>
					<col style="width:20%">				
					<col style="width:50px">
					<col style="width:70PX">
					<col style="width:*">
					<col style="width:15%">
				</colgroup>
				<thead>
					<tr>
						<th scope="col">주문번호</th>						
						<th scope="col" colspan="3">상품정보</th>
						<th scope="col">진행상태</th>					
					</tr>
				</thead>
				<tbody>
				
				<c:choose>
				<c:when test="${orderList ne '[]'}">
				<c:forEach items="${orderList}" var="orderList" varStatus="idx">
						<!-- 배송/판매자 영역 rowspan 관련 변수 -->
						<c:set var="compSpan" value="1"/><!-- rowspan 설정 값 -->
						<c:set var="oriCompSpan" value=""/><!-- rowspan 적용 영역 -->
						<c:set var="oriCompNo" value="" /><!-- 비교용 업체 번호 -->
						<c:forEach items="${orderList.orderDetailListVO}" var="orderDetailList" varStatus="dIdx">
						<c:set value="${orderDetailList.ordDtlStatCd}" var="ordDtlStatCd"/>
						<tr>
						<c:choose>
						<c:when test="${dIdx.first}">
							<c:set var="oriCompNo" value="${orderDetailList.compNo}" />
								<c:choose>
								<c:when test="${fn:length(orderList.orderDetailListVO) > 1}">
								<c:set var="class_divide" value=""/>
								<c:set var="rowspan_divide" value="${fn:length(orderList.orderDetailListVO)}"/>
								</c:when>
								<c:otherwise>
								<c:set var="class_divide" value="_n"/>
								<c:set var="rowspan_divide" value=""/>
								</c:otherwise>
								</c:choose>
								
								<td class="rowspan" rowspan="<c:out value="${rowspan_divide}"/>">
									<label for="aa"><input id="aa" type="radio" class="radio" name="mbrLevRsnCd" value="${orderList.ordNo }"></label>
									<div class="mgt4"><a href="javascript:void(0)" onclick="goOrderDetail('${orderList.ordNo}');return false;" class="order_number">${orderList.ordNo }</a></div>
									<div class="mgt4"><span class="order_date01">(<frame:timestamp date="${orderList.ordAcptDtm}" dType="H" />)</span></div>							
								</td>
								
								<td>
									<input type="checkbox" class="checkbox" title="선택" id="${orderList.ordNo }_${orderDetailList.ordDtlSeq }" name="goodsIds" value="${orderList.ordNo }|${orderDetailList.ordDtlSeq }|${orderDetailList.bndNmKo }|${orderDetailList.goodsNm }">
								</td>
								<td class="img_cell v_top">
									<a href="/goods/indexGoodsDetail?goodsId=<c:out value="${orderDetailList.goodsId }"/>">
									<frame:goodsImage goodsId="${orderDetailList.goodsId}" seq="${orderDetailList.imgSeq}" imgPath="${orderDetailList.imgPath}" size="${ImageGoodsSize.SIZE_70.size}" gb="" />
									</a>
								</td>
								<td class="align_left v_top">
									<div class="product_name">
										<a href="/goods/indexGoodsDetail?goodsId=<c:out value="${orderDetailList.goodsId }"/>">
										[<c:out value="${orderDetailList.bndNmKo}" />] <c:out value="${orderDetailList.goodsNm}" /></a>
									</div>
								</td>
						</c:when>
						<c:otherwise>
							<td>
								<input type="checkbox" class="checkbox" title="선택" id="${orderList.ordNo }_${orderDetailList.ordDtlSeq }" name="goodsIds" value="${orderList.ordNo }|${orderDetailList.ordDtlSeq }|${orderDetailList.bndNmKo }|${orderDetailList.goodsNm }">
							</td>
							
							<td class="img_cell v_top">
								<a href="/goods/indexGoodsDetail?goodsId=<c:out value="${orderDetailList.goodsId }"/>">
								<frame:goodsImage goodsId="${orderDetailList.goodsId}" seq="${orderDetailList.imgSeq}" imgPath="${orderDetailList.imgPath}" size="${ImageGoodsSize.SIZE_70.size}" gb="" />
								</a>
							</td>
		
							<td class="align_left v_top">
								<div class="product_name">
									<a href="/goods/indexGoodsDetail?goodsId=<c:out value="${orderDetailList.goodsId }"/>">[<c:out value="${orderDetailList.bndNmKo}" />] <c:out value="${orderDetailList.goodsNm}" /></a>
								</div>
							</td>
						</c:otherwise>
						</c:choose>
								<td>
									<div>
										<frame:codeValue items="${ordDtlStatCdList}" dtlCd="${orderDetailList.orderDtlCodeName}" />
									</div>
								</td>
							</tr>
						</c:forEach>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<tr>
						<td colspan="7" class="nodata">선택한 기간 내 주문내역이 없습니다.</td>
					</tr>
				</c:otherwise>
				</c:choose>
				
				<%-- datepicker 달력 --%>
	 			<div class="date_search" style="display: none;">
					<ul class="date_wrap">
						<li class="write_area1">
							<span class="datepicker_wrap">
								<input type="text" readonly="readonly" class="datepicker" id="start_dt" name="ordAcptDtmStart" value="<frame:timestamp date="${orderSO.ordAcptDtmStart}" dType="H" />" title="날짜" />
							</span>
						</li>
						<li class="write_area2">
							<span class="datepicker_wrap">
								<input type="text" readonly="readonly" class="datepicker" id="end_dt" name="ordAcptDtmEnd" value="<frame:timestamp date="${orderSO.ordAcptDtmEnd}" dType="H" />" title="날짜" />
							</span>
						</li>
					</ul>
				</div>
				<%-- //datepicker 달력 --%>
				
				</tbody>
			</table>
			
			<!-- 페이징 -->
			<input type="hidden" id="order_list_page" name="page" value="<c:out value="${orderSO.page}" />" />
			<input type="hidden" id="order_list_rows" name="rows" value="<c:out value="${orderSO.rows}" />" />
			<frame:listPage recordPerPage="${orderSO.rows}" currentPage="${orderSO.page}" totalRecord="${orderSO.totalCount}" indexPerPage="5" id="order_list_page" />
			<!-- 페이징 -->
			
			<!-- pop_btn_section -->
			<div class="pop_btn_section border_none">
				<a href="javascript:void(0)" class="btn_pop_type2" onclick="checkedOrder();return false;">확인</a>
				<a href="javascript:void(0)" class="btn_pop_type1 mgl6" onclick="goPage();return false;">최소</a>
			</div><!-- //pop_btn_section -->
		
		</div>
	
		</div><!--// popup_cont -->
	</div><!--// wrap_popup -->
</div>
</form>