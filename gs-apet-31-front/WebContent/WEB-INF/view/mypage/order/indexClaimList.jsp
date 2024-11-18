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
		$(".mo-heade-tit .tit").html("<spring:message code='front.web.view.include.title.cancel.return.exchange' />");
		$(".mo-header-backNtn").removeAttr("onclick");
		$(".mo-header-backNtn").bind("click", function(){
			storageHist.goBack('/mypage/indexMyPage/');
		});
	}); // End Ready
	
		$(document).ready(function(){
			$(document.body).on('touchmove', onScroll); // for mobile
			$(window).on('scroll', onScroll); 
		});
	
		// 장바구니 담기
		function insertCart(goodsId, itemNo, pakGoodsId, ordmkiYn) {
			if(ordmkiYn != 'Y') {
				var goodsInfo = goodsId+":"+itemNo+":" + (pakGoodsId ? pakGoodsId : "");
				commonFunc.insertCart(goodsInfo, '1', 'N');
			}else {
				ui.confirm("<spring:message code='front.web.view.order.cart.custom.product.go.detail' />",{ // 컨펌 창 옵션들
				    ycb:function(){
				    	location.href="/goods/indexGoodsDetail?goodsId="+goodsId;
				    },
				    ncb:function(){
				    },
				    ybt:"예", // 기본값 "확인"
				    nbt:"아니오"  // 기본값 "취소"
				});
			}
		}
		

		function onScroll(){
			var scrollHeight = $(document).height();
			var scrollPosition = $(window).height() + $(window).scrollTop();		
			if (scrollPosition > scrollHeight - 200) {			
				orderClaimList.scrollPaging();
			}
			
		/* 	if($(window).scrollTop() < 120){
				$(".noneBoxPoint").remove();    APETQA-5279 [F_마이페이지][MO] 취소/반품/교환 빈화면에서 스크롤 시 빈화면 디자인 사라짐	 
			} */
		}
	
		/**********************************************************************
		 * 기간별 검색조건 관련 함수 Start
		 ***********************************************************************/
		// Calendar 생성
		$(function() {
			
			$("#start_dt").datepicker("option", "maxDate", "0");	
			$("#start_dt").datepicker("option", "dateFormat", "yy.mm.dd");
			$("#start_dt").on("propertychange change keyup paste input", function() {			    
				$("#end_dt").datepicker("option", "minDate", $(this).val());			 
			});
			$("#end_dt").datepicker("option", "dateFormat", "yy.mm.dd");
			var dateStartDt = $("#start_dt").val();
			$("#end_dt").datepicker("option", "minDate", dateStartDt);			
			$("#end_dt").datepicker("option", "maxDate", "0");
			
			$("#start_dt").val(  format.DateType($('input[name=clmAcptDtmStart]').val(), "."));	
			$("#end_dt").val(  format.DateType($('input[name=clmAcptDtmEnd]').val(), "."));
	
			calendar.range("start_dt", "end_dt", {yearRange : 'c-10:c'});
		});
	
		
		// 조회
		function searchClaimList() {
			var startDt = new Date($("#start_dt").val());
			var endDt = new Date($("#end_dt").val());
	
			var diff = endDt.getTime() - startDt.getTime();
	
			if ( 365 < Math.floor(diff/(1000*60*60*24)) ) {
				ui.alert("<spring:message code='front.web.view.order.claimlist.content.searchingperiod.maximun.twelvemonts' />",{					
					ybt:'<spring:message code='front.web.view.common.msg.confirmation' />'	
				});
				return;
			}
			
			var action = "/mypage/order/indexClaimList";
			
			//날짜 변환
			var formStartDt = $('#start_dt').val();
			var formEndDt = $('#end_dt').val();		
			$('input[name=clmAcptDtmStart]').val(formStartDt.replaceAll(".", "-"));
			$('input[name=clmAcptDtmEnd]').val(formEndDt.replaceAll(".", "-"));		
		
			$("#claim_cr_list_page").val("1");	// 페이지 번호 초기화
			$("#claim_list_form").attr("target", "_self");
			$("#claim_list_form").attr("action", action);
			$("#claim_list_form").submit();
		}
	
		/*
		 * 클레임 상세정보
		 */
		function goClaimDetail(clmNo, clmTpCd){
			if(clmNo == null || clmNo == undefined || clmNo == ""){			
				ui.alert("<spring:message code='front.web.view.order.claimlist.content.claim.number.error' />",{					
					ybt:'<spring:message code='front.web.view.common.msg.confirmation' />'	
				});
				return;
			}else{		
				
				var action = "/mypage/order/indexClaimDetail";
				var mngb = "CL";
				
				var inputs = "<input type=\"hidden\" name=\"clmNo\" value=\""+clmNo+"\"/><input type=\"hidden\" name=\"mngb\" value=\""+mngb+"\"/>";
				if(clmTpCd != "${FrontWebConstants.CLM_TP_10}" ){
					inputs += "<input type=\"hidden\" name=\"clmTpCd\" value=\""+clmTpCd+"\"/>";
				}
				
				jQuery("<form action=\"" + action + "\" method=\"get\">"+inputs+"</form>").appendTo('body').submit();
			}
		}
		
		/*
		 * 주문상세 페이지 이동
		 */
		function goclaimDetail(ordNo){
			var action = "/mypage/order/indexDeliveryDetail";
			var mngb = "CL";
			
			var inputs = "<input type=\"hidden\" name=\"ordNo\" value=\""+ordNo+"\"/><input type=\"hidden\" name=\"mngb\" value=\""+mngb+"\"/>";
			jQuery("<form action=\"" + action + "\" method=\"get\">"+inputs+"</form>").appendTo('body').submit();
		}
		
		var orderClaimList = {
				// 재조회			
				reload : function(){
					$("#claim_list_form").attr("target", "_self");
					$("#claim_list_form").attr("action", "/mypage/order/indexClaimList");
					$("#claim_list_form").submit();
				}
				// 기간버튼 클릭 시
				, setPeriod : function(period){
					$("input[name=period]").val(period);			
					if(period == 0){
						/* $('#start_dt').val("");
						$('#end_dt').val(""); */
						calendar.autoRangeOrder("start_dt", "end_dt", 3);
						$(".dummy-gray-line").addClass("open");
					}else{				
						$(".dummy-gray-line").removeClass("open");
						calendar.autoRangeOrder("start_dt", "end_dt", period);
						this.setSearchDate();	
					}			
					
				}
				// 조회 버튼
				, search : function(){				
					this.setSearchDate();
				}			
				// 페이지 클릭
				, setPage : function(page){
					$("#claim_list_page").val(page);
					this.reload();
				}
				, setSearchDate  : function(){
					
					if($.trim($('#start_dt').val()) == "" ){				
						ui.alert("<spring:message code='front.web.view.order.claimlist.chose.searching.period' />",{					
							ybt:'<spring:message code='front.web.view.common.msg.confirmation' />'	
						});				
						return false;
						
					}else if ($.trim($('#end_dt').val()) == ""){				
						ui.alert("<spring:message code='front.web.view.order.claimlist.chose.searching.period' />",{					
							ybt:'<spring:message code='front.web.view.common.msg.confirmation' />'	
						});				
						return false;	
					}else{
					
						var startDt = new Date($('#start_dt').val());
						var endDt = new Date($('#end_dt').val());
						
						var diff = endDt.getTime() - startDt.getTime(); 
						
	
						if ( startDt > endDt ) {				
							ui.alert("<spring:message code='front.web.view.order.claimlist.endsearchingdate.have.to.be.longer.than.startdate' />",{					
								ybt:'<spring:message code='front.web.view.common.msg.confirmation' />'	
							});
							return false;
						}	
						
						if ( 365 < Math.floor(diff/(1000*60*60*24)) ) {				
							ui.alert("<spring:message code='front.web.view.order.claimlist.content.searchingperiod.maximun.twelvemonts' />",{					
								ybt:'<spring:message code='front.web.view.common.msg.confirmation' />'	
							});
							return false;
						}			
						
						
						//날짜 변환
						var formStartDt = $('#start_dt').val();
						var formEndDt = $('#end_dt').val();		
						$('input[name=clmAcptDtmStart]').val(formStartDt.replaceAll(".", "-"));
						$('input[name=clmAcptDtmEnd]').val(formEndDt.replaceAll(".", "-"));		
					
						$("#claim_list_page").val("1");			
						this.reload();
					}	
				}
				, scrollPaging  : function(){			
				
					var endPage = $("#claim_list_totalPage").val();
					var nowPage = $("#claim_list_page").val();
					
					var callAjaxdeliveryHtml = $("#callAjaxClaimHtml").val();
					
					
					if (callAjaxdeliveryHtml == 'N' && Number(nowPage) < Number(endPage) ) {
						$("#callAjaxClaimHtml").val("Y");
						$("#claim_list_page").val( Number(nowPage) + 1);				
						var formData = $("#claim_list_form").serialize() ;				
						var options = {
								url : "<spring:url value='/mypage/order/ajaxClaimHtml' />"
								, data : formData			
								, dataType: 'html'
								, done : function(data){
									$("#claimList").append(data);
									$("#callAjaxClaimHtml").val("N");
								}
							};
							ajax.call(options);
						
					}		 
					
				},
				// 상품 상세 이동
				goOrderDetail : function(ordNo){
					var inputs = "<input type=\"hidden\" name=\"ordNo\" value=\""+ordNo+"\"/>";
					jQuery("<form action=\"/mypage/order/indexDeliveryDetail\" method=\"get\">"+inputs+"</form>").appendTo('body').submit();
				}
	
			}
		
		//주문삭제
		function goOrderDelete(ordNo){
			
			ui.confirm("<spring:message code='front.web.view.order.claimlist.deletedorderlists.never.be.back' />" + "<spring:message code='front.web.view.order.claimlist.want.to.delete.deletedorderlists' />",{ // 컨펌 창 띄우기
				ycb:function(){
					var options = {
						   url : "<spring:url value='/mypage/order/ordDeleteProcess' />"
							, data : { ordNo : ordNo}
							, done : function(data){									
								$("#claim_list_page").val("1");			
								orderClaimList.reload();								
							}
						}; 
					ajax.call(options);									
				},					
				ybt:'<spring:message code='front.web.view.common.yes' />',
				nbt:'<spring:message code='front.web.view.common.no' />'	
			});	
		}		
</script>
</tiles:putAttribute>
	
	<tiles:putAttribute name="content">
	
		<c:if test="${view.deviceGb eq frontConstants.DEVICE_GB_10 }">
			<jsp:include page="/WEB-INF/tiles/include/lnb_my.jsp" />
			<jsp:include  page="/WEB-INF/tiles/include/menubar.jsp" />
		</c:if>
		
		<main class="container lnb page 1dep 2dep" id="container">
			<div class="inr">
				<!-- 본문 -->
				<div class="contents" id="contents">
					<!-- PC 타이틀 모바일에서 제거  -->
					<div class="pc-tit">
						<h2><spring:message code='front.web.view.include.title.cancel.return.exchange' /></h2>
					</div>
					
					<form id="claim_list_form">				
									
					<input type="hidden" id="claim_list_page" name="page" value="<c:out value="${so.page}" />" />
					<input type="hidden" id="claim_list_rows" name="rows" value="<c:out value="${so.rows}" />" />				
					<input type="hidden" id="claim_list_totalPage"  value="<c:out value="${so.totalPageCount}" />" />
					<input type="hidden" name="clmAcptDtmStart" value="<frame:timestamp date="${so.clmAcptDtmStart}" dType="H" />" />
					<input type="hidden" name="clmAcptDtmEnd" value="<frame:timestamp date="${so.clmAcptDtmEnd}" dType="H" />" />
					<input type="hidden" id="callAjaxClaimHtml" name="callAjaxClaimHtml" value="N" />
					
					<div class="delivery-oder-area h100" id="claimList">
						<div class="inr-box pc-re-po01">
							<div class="oder-step">
								<nav class="menushop re-po01">
									<button type="button" class="bt st"></button>
									<div class="list">
										<ul class="menu">										
											<li <c:if test="${so.period eq '3'}">class="active"</c:if> ><a href="#" id="period_type_3" data-content="${session.mbrNo }" data-url="/mypage/order/indexClaimList?page=${so.page}&rows=${so.rows}&period=3&clmAcptDtmStart=<frame:timestamp date="${so.clmAcptDtmStart}" dType="H" />&clmAcptDtmEnd=<frame:timestamp date="${so.clmAcptDtmEnd}" dType="H" />" class="bt" onclick="orderClaimList.setPeriod(3);return false;"><spring:message code='front.web.view.order.claimlist.list.recently.threemonths' /></a></li>
											<li <c:if test="${so.period eq '6'}">class="active"</c:if>><a href="#" id="period_type_6" data-content="${session.mbrNo }" data-url="/mypage/order/indexClaimList?page=${so.page}&rows=${so.rows}&period=6&clmAcptDtmStart=<frame:timestamp date="${so.clmAcptDtmStart}" dType="H" />&clmAcptDtmEnd=<frame:timestamp date="${so.clmAcptDtmEnd}" dType="H" />" class="bt" onclick="orderClaimList.setPeriod(6);return false;"><spring:message code='front.web.view.order.claimlist.list.recently.sixmonths' /></a></li>
											<li <c:if test="${so.period eq '9'}">class="active"</c:if>><a href="#" id="period_type_9" data-content="${session.mbrNo }" data-url="/mypage/order/indexClaimList?page=${so.page}&rows=${so.rows}&period=9&clmAcptDtmStart=<frame:timestamp date="${so.clmAcptDtmStart}" dType="H" />&clmAcptDtmEnd=<frame:timestamp date="${so.clmAcptDtmEnd}" dType="H" />" class="bt" onclick="orderClaimList.setPeriod(9);return false;"><spring:message code='front.web.view.order.claimlist.list.recently.ninemonths' /></a></li>
											<li <c:if test="${so.period eq '12'}">class="active"</c:if>><a href="#" id="period_type_12"data-content="${session.mbrNo }" data-url="/mypage/order/indexClaimList?page=${so.page}&rows=${so.rows}&period=12&clmAcptDtmStart=<frame:timestamp date="${so.clmAcptDtmStart}" dType="H" />&clmAcptDtmEnd=<frame:timestamp date="${so.clmAcptDtmEnd}" dType="H" />" class="bt" onclick="orderClaimList.setPeriod(12);return false;"><spring:message code='front.web.view.order.claimlist.list.recently.twelvemonths' /></a></li>
											<li <c:if test="${so.period eq '0'}">class="active"</c:if>><a href="#" id="period_type_0" data-content="${session.mbrNo }" data-url="/mypage/order/indexClaimList?page=${so.page}&rows=${so.rows}&period=0&clmAcptDtmStart=<frame:timestamp date="${so.clmAcptDtmStart}" dType="H" />&clmAcptDtmEnd=<frame:timestamp date="${so.clmAcptDtmEnd}" dType="H" />" class="bt" onclick="orderClaimList.setPeriod(0);return false;"><spring:message code='front.web.view.order.claimlist.list.recently.write.directly' /></a></li>										
											<input type="hidden" name="period" value="${so.period}" />
										</ul>
									</div>
								</nav>
								<div class="dummy-gray-line <c:if test="${so.period eq '0'}">open</c:if>"><!-- open 클래스 추가 시 open -->
									<div class="layout-date-picker noIcon">
										<span class="uiDate"><input type="text"  value="<frame:timestamp date="${so.clmAcptDtmStart}" dType="C" />" placeholder="YYYY.MM.DD" class="datepicker" title="날짜" id="start_dt"  readonly="readonly" ></span>
										<span class="gap-area">-</span>
										<span class="uiDate"><input type="text" value="<frame:timestamp date="${so.clmAcptDtmEnd}" dType="C" />" placeholder="YYYY.MM.DD" class="datepicker" title="날짜" id="end_dt" eadonly="readonly"></span>
										<a href="#" data-content="${session.mbrNo }" data-url="/mypage/order/indexClaimList?page=${so.page}&rows=${so.rows}&period=${so.period}&clmAcptDtmStart=<frame:timestamp date="${so.clmAcptDtmStart}" dType="H" />&clmAcptDtmEnd=<frame:timestamp date="${so.clmAcptDtmEnd}" dType="H" />" onclick="orderClaimList.search();return false;" class="btn lg"><spring:message code='front.web.view.order.claimlist.content.search' /></a>
									</div>
								</div>							
							</div>
						</div>
						<jsp:include page="/WEB-INF/view/mypage/order/include/includeClaim.jsp"/><!-- 취소/반품/교환 include -->
					</div>
					</form>
	
				</div>
			</div>
		
		</main>
		
		<div class="layers">
			<!-- 레이어팝업 넣을 자리 -->
		</div>
			
	</tiles:putAttribute>
	</tiles:insertDefinition>