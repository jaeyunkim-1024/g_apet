<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ page import="front.web.config.constants.FrontWebConstants" %>
<%@ page import="framework.common.enums.ImageGoodsSize" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<tiles:insertDefinition name="common">
<tiles:putAttribute name="script.include" value="script.order"/>
<tiles:putAttribute name="script.inline">
<script type="text/javascript" 	src="/_script/cart/cart.js"></script>
<script type="text/javascript">
		$(function() {
			fnOnLoadDocument();

			$(window).on("scroll", function() {
				var scrollHeight = $(document).height();
				var scrollPosition = $(window).height() + $(window).scrollTop();
				if (scrollPosition > scrollHeight - 200) {
					orderDeliveryList.scrollPaging();
				}
			});

			$(document).off("click", '[data-target="order"][data-action="goodsflow"]')
				.on("click", '[data-target="order"][data-action="goodsflow"]', function(e) {
					e.stopPropagation();

					let $this = $(this);
					let url = $this.data("url");

					if("${view.deviceGb eq frontConstants.DEVICE_GB_30}"=="true") {
						var parameters = {
							"func" : "onOrderPage",
							"url" : url,
							"title" : "배송조회"
						};
						if("${view.os eq frontConstants.DEVICE_TYPE_10}"=="true") {
							// Android
							window.AppJSInterface.onOrderPage(JSON.stringify(parameters));
						} else {
							// iOS(Dictionary)
							window.webkit.messageHandlers.AppJSInterface.postMessage(parameters);
						}
					} else {
						window.open(url,"","width=498,height=640, scrollbars=yes,resizable=no");
					}
					e.preventDefault();
				});
		});

		function fnOnLoadDocument(){
			if($(".no_data").length>0){
				waiting.start();
				$(".no_data").hide();
				setTimeout(function(){
					$(".no_data").show();
					waiting.stop();
				},1000);
			}
			if ($(".no_data.auto_h").length) {
				$(".no_data.auto_h").parent().height(($("#deliveryList").height() - $(".no_data.auto_h").offset().top));
			}
			$("#header_pc").removeClass("mode0");
			$("#header_pc").addClass("mode16");
			$("#header_pc").attr("data-header", "set22");
			$(".mo-heade-tit .tit").html("펫츠비 주문/배송");
			$(".mo-header-backNtn").removeAttr("onclick");
			$(".mo-header-backNtn").bind("click", function(){
				storageHist.goBack('/mypage/order/indexPetsbeDeliveryList');
			});

			//주문 내역 삭제 버튼, 배송 조회 버튼
			var $delBtn = $(".ord-del-btn , .detail-btn[data-action='goodsflow'] , .add-cart-btn , .cs-btn , .completeBtn , .dlvr-current-status , .btnSet , .opts");
			$delBtn.remove();

			$("#delivery_start_dt").datepicker("option", "maxDate", "0");
			$("#delivery_start_dt").datepicker("option", "dateFormat", "yy.mm.dd");
			$("#delivery_start_dt").on("propertychange change keyup paste input", function() {
				$("#delivery_end_dt").datepicker("option", "minDate", $(this).val());
			});

			$("#delivery_end_dt").datepicker("option", "dateFormat", "yy.mm.dd");
			var dateStartDt = $("#delivery_start_dt").val();
			$("#delivery_end_dt").datepicker("option", "minDate", dateStartDt);
			$("#delivery_end_dt").datepicker("option", "maxDate", "0");


			$("#delivery_start_dt").val(  format.DateType($('input[name=ordAcptDtmStart]').val(), "."));
			$("#delivery_end_dt").val(  format.DateType($('input[name=ordAcptDtmEnd]').val(), "."));

			//전체주문보기 기본 감추기
			$(".btn_fixed_wrap").css("display","none");
			//결제완료시 전체주문번호 노출

			calendar.range("delivery_start_dt", "delivery_end_dt", {yearRange : 'c-10:c'});

			if($(".step-list>ul").children("li").hasClass("on") == true){
				$("#btnAllDelivery").show();
				$("#btnAllDelivery").click(function(){
					orderDeliveryList.reload();
				});
			}else{
				$("#btnAllDelivery").hide();
			}

			$(".statusDeliveryList").find("a[class='btn sm']").remove();
		}
	
		
		/*
		 * 주문/배송 목록
		 */
		var orderDeliveryList = {
			// 재조회			
			reload : function(){			
				$("#delivery_list_form").attr("target", "_self");
				$("#delivery_list_form").attr("action", "/mypage/order/indexPetsbeDeliveryList");
				$("#delivery_list_form").submit();
			}
			// 기간버튼 클릭 시
			, setPeriod : function(period){
				$("input[name=period]").val(period);			
				if(period == 0){
					/* $('#delivery_start_dt').val("");
					$('#delivery_end_dt').val(""); */
					calendar.autoRangeOrder("delivery_start_dt", "delivery_end_dt", 3);
					$(".dummy-gray-line").addClass("open");				
				}else{				
					$(".dummy-gray-line").removeClass("open");
					calendar.autoRangeOrder("delivery_start_dt", "delivery_end_dt", period);
					this.setSearchDate();	
				}			
				
			}
			// 조회 버튼
			, search : function(){
				//$("input[name=period]").val("");
				this.setSearchDate();
			}
			//상태카운트 클릭시
			,searchStauts : function(stus, clickId){
				var statusClass = "";
				$("input[name=arrOrdDtlStatCd]").remove();
				if($("#"+clickId).hasClass("on") == false){
					var hidArrhtml = "";
					if(stus == "1230"){
						hidArrhtml += "<input type=\"hidden\" name=\"arrOrdDtlStatCd\"  value=\"120\" />";
						hidArrhtml += "<input type=\"hidden\" name=\"arrOrdDtlStatCd\"  value=\"130\" />";
						statusClass = "120";
					}else{
						hidArrhtml += "<input type=\"hidden\" name=\"arrOrdDtlStatCd\"  value="+ stus +" />";
						statusClass = stus;
					}
					
					$("#delivery_list_form").append(hidArrhtml);			
					$("#delivery_list_page").val("1");
				}else{
					$("input[name=period]").val("3");
					$('input[name=ordAcptDtmStart]').val("");
					$('input[name=ordAcptDtmEnd]').val("");
				}
				
				//this.reload();
				//20210621 페이지 새로고침에서 ajax로 변경
				var formData = $("#delivery_list_form").serialize();				
				var options = {
						url : "<spring:url value='/mypage/order/ajaxDeliveryHtmlPetsbe' />"
						,data : formData	
						, dataType: 'html'
						,done : function(data) {
							let noDataHeight = "";
							if ($(".no_data.auto_h").length) {
								noDataHeight = $(".no_data.auto_h").parent().css("height");
							}
							
							$("#deliveryList form,.statusDeliveryList,.btn_fixed_wrap").remove();
							$("#deliveryList").append(data);
							orderStatusChangeFn(statusClass);
							
							if ($(".no_data.auto_h").length) {
								if (!noDataHeight) {
									$(".no_data.auto_h").parent().height(($(window).height() - $(".no_data.auto_h").offset().top));
								} else {
									$(".no_data.auto_h").parent().height(noDataHeight);
								}
							}
						} 
				};
				ajax.call(options);
			}
			// 페이지 클릭
			, setPage : function(page){
				$("#delivery_list_page").val(page);
				this.reload();
			}
			, setSearchDate  : function(){
				
				if($.trim($('#delivery_start_dt').val()) == "" ){				
					ui.alert("조회 기간을 입력해주세요.",{					
						ybt:'확인'	
					});				
					return false;
					
				}else if ($.trim($('#delivery_end_dt').val()) == ""){				
					ui.alert("조회 기간을 입력해주세요.",{					
						ybt:'확인'	
					});				
					return false;	
				}else{
				
					var startDt = new Date($('#delivery_start_dt').val());
					var endDt = new Date($('#delivery_end_dt').val());
					
					var diff = endDt.getTime() - startDt.getTime(); 
					
					if ( startDt > endDt ) {				
						ui.alert("조회 종료일은 시작일 보다 작을수 없습니다.",{					
							ybt:'확인'	
						});
						return false;
					}	
					
					if ( 365 < Math.floor(diff/(1000*60*60*24)) ) {				
						ui.alert("조회기간은 최대 12개월까지 설정가능 합니다.",{					
							ybt:'확인'	
						});
						return false;
					}
					
					//날짜 변환
					var formStartDt = $('#delivery_start_dt').val();
					var formEndDt = $('#delivery_end_dt').val();			
					$('input[name=ordAcptDtmStart]').val(formStartDt.replaceAll(".", "-"));
					$('input[name=ordAcptDtmEnd]').val(formEndDt.replaceAll(".", "-"));
					
					// 조회시 페이징관련 변수 초기화
					$("input[name=arrOrdDtlStatCd]").remove();
					$("#delivery_list_page").val("1");			
					//this.reload();
					var formData = $("#delivery_list_form").serialize();				
					var options = {
							url : "<spring:url value='/mypage/order/ajaxDeliveryHtmlPetsbe' />"
							,data : formData	
							, dataType: 'html'
							,done : function(data) {
								let noDataHeight = "";
								if ($(".no_data.auto_h").length) {
									noDataHeight = $(".no_data.auto_h").parent().css("height");
								}
								$("#deliveryList form,.statusDeliveryList,.btn_fixed_wrap").remove();
								$("#deliveryList").append(data);
								$(".btn_fixed_wrap").remove();
								
								$("[data-target='petsbe']").removeClass("t4").addClass("t2").text("주문취소");
								if ($(".no_data.auto_h").length) {
									if (!noDataHeight) {
										$(".no_data.auto_h").parent().height(($(window).height() - $(".no_data.auto_h").offset().top));
									} else {
										$(".no_data.auto_h").parent().height(noDataHeight);
									}
								}
								
								$("#delivery_start_dt").val(  format.DateType($('input[name=ordAcptDtmStart]').val(), "."));	
								$("#delivery_end_dt").val(  format.DateType($('input[name=ordAcptDtmEnd]').val(), "."));
							} 
					};
					ajax.call(options);
				}	 
			}
			,convertDate : function(str){	
				
				var y = str.substr(0,4),
				m = str.substr(4,2) - 1,
				d = str.substr(6,2)
				
				return new Date(y,m,d);		
				
			}		
			,convertBankDate : function(str){	
				
				var y = str.substr(0,4),
				m = str.substr(4,2) - 1,
				d = str.substr(6,2)
				hh = str.substr(8,2)
				mm = str.substr(10,2);
				
				return new Date(y,m,d,hh,mm);		
				
			} 
			, scrollPaging  : function() {			
				var endPage = $("#delivery_list_totalPage").val();
				var nowPage = $("#delivery_list_page").val();	
				
				var callAjaxdeliveryHtml = $("#callAjaxdeliveryHtml").val();
				
				if (callAjaxdeliveryHtml == 'N' && Number(nowPage) < Number(endPage) ){
					$("#callAjaxdeliveryHtml").val("Y");
					$("#delivery_list_page").val( Number(nowPage) + 1);				
					var formData = $("#delivery_list_form").serialize();				
					var options = {
							url : "<spring:url value='/mypage/order/ajaxDeliveryListHtmlPetsbe' />"
							,data : formData	
							, dataType: 'html'
							,done : function(data) {
								var status = $("input[name=arrOrdDtlStatCd]").val();
								$("#deliveryList").append(data);
								$(".btn_fixed_wrap").remove();
								$("#callAjaxdeliveryHtml").val("N");
								$("[data-target='petsbe']").removeClass("t4").addClass("t2").text("주문취소");
								orderStatusChangeFn(status);
							} 
					};
					
					ajax.call(options);		
				}
			}
		}
	
		/*
		 * 주문/배송 목록 버튼
		 */
		var orderDeliveryListBtn = {
			// 상품 상세 이동
			goOrderDetail : function(ordNo){
				var inputs = "<input type=\"hidden\" name=\"ordNo\" value=\""+ordNo+"\"/><input type=\"hidden\" id=\"mngb\" name=\"mngb\" value=\"OL\" />";
				jQuery("<form action=\"/mypage/order/indexPetsbeDeliveryDetail\" method=\"get\">"+inputs+"</form>").appendTo('body').submit();
			}
			,goOrderClaimDetail : function(clmNo, clmTpCd){	
				if(clmNo == null || clmNo == undefined || clmNo == ""){			
					ui.alert("클레임번호 오류입니다.",{					
						ybt:'확인'	
					});
					return;
				}else{		
					
					var action = "/mypage/order/indexClaimDetail";				
					var inputs = "<input type=\"hidden\" name=\"clmNo\" value=\""+clmNo+"\"/>";
					jQuery("<form action=\"/mypage/order/indexClaimDetail\" method=\"post\">"+inputs+"</form>").appendTo('body').submit();
				}
			}
			// 상품평 등록 팝업
			, plgYn : "${session.petLogUrl != null && session.petLogUrl != '' ? 'Y':'N'}"
			, deviceGb : '${view.deviceGb}'
			, petRegYn : "${session.petNos != null ? 'Y' : 'N'}"
			, openGoodsComment : function(sGoodsId, sOrdNo , sOrdDtlSeq, sGoodsEstmNo, sGoodsEstmTP){
				
				if(sGoodsEstmNo == ""){
					if(orderDeliveryListBtn.deviceGb == 'APP' && orderDeliveryListBtn.plgYn == 'Y' && orderDeliveryListBtn.petRegYn == "Y") {
						$("#acSelect").remove();
						
						var layerCommentHtml = "";					
						layerCommentHtml += "<div class=\"acSelect t2 k0429\" id=\"acSelect\">";
						layerCommentHtml += "	<input type=\"text\" class=\"acSelInput\" readonly />";
						layerCommentHtml += "	<div class=\"head \">";
						layerCommentHtml += "		<div class=\"con\">";
						layerCommentHtml += "			<div class=\"tit\">후기작성</div>";
						layerCommentHtml += "			<a href=\"javascript:;\" class=\"close\" onClick=\"ui.selAc.close(this)\"></a>";
						layerCommentHtml += "		</div>";
						layerCommentHtml += "	</div>";
						layerCommentHtml += "	<div class=\"con\">";
						layerCommentHtml += "		<ul class=\"selReview\">";
						layerCommentHtml += "			<li onClick=\"orderDeliveryListBtn.openGoodsCommentNext('"+ sGoodsId +"', '"+ sOrdNo +"', '"+sOrdDtlSeq +"', '"+sGoodsEstmNo+"', 'NOR');\" name='norBtn'>";
						layerCommentHtml += "			<img src=\"../../_images/my/icon-review-normal@2x.png\">";
						layerCommentHtml += "			<span>일반 후기 작성</span>";
						layerCommentHtml += "			</li>";
						layerCommentHtml += "			<li onClick=\"orderDeliveryListBtn.openGoodsCommentNext('"+ sGoodsId +"', '"+ sOrdNo +"', '"+sOrdDtlSeq +"', '"+sGoodsEstmNo+"', 'PLG');\" name='plgBtn'>";
						layerCommentHtml += "			<img src=\"../../_images/my/icon-review-log@2x.png\">";
						layerCommentHtml += "			<span><spring:message code='front.web.view.new.menu.log'/> 후기 작성</span>";
						layerCommentHtml += "			</li>";
						/* if( orderDeliveryListBtn.deviceGb != "PC"){						
							layerCommentHtml += "			<li></li>";
						} */					
						layerCommentHtml += "		</ul>";
						layerCommentHtml += "	</div>";
						layerCommentHtml += "</div>";
						
						$("#emptyLayers").append(layerCommentHtml);
						
						ui.selAc.open('#acSelect');
						
					}else{
						var norBtn = "NOR";

						orderDeliveryListBtn.openGoodsCommentNext(sGoodsId, sOrdNo , sOrdDtlSeq, sGoodsEstmNo, norBtn);
					}
				}else{
					var norBtn = sGoodsEstmTP ==  "" ? "NOR" : sGoodsEstmTP;
					orderDeliveryListBtn.openGoodsCommentNext(sGoodsId, sOrdNo , sOrdDtlSeq, sGoodsEstmNo, norBtn);
					//orderDeliveryListBtn.openGoodsCommentNext(sGoodsId, sOrdNo , sOrdDtlSeq, sGoodsEstmNo, sGoodsEstmTP);
				}	
					
			}
			, openGoodsCommentNext : function(sGoodsId, sOrdNo , sOrdDtlSeq, sGoodsEstmNo, sGoodsEstmTp){	
				
				//수정
				if(sGoodsEstmNo != ""){					
					if( sGoodsEstmTp == "PLG" && orderDeliveryListBtn.deviceGb != "APP"){					
						ui.alert('펫로그 후기는 <br>모바일 앱에서 수정 가능합니다.');
						return false;					
					}
					
				}
												
				var url = "/mypage/commentWriteView"
				var html = '';
				html += '<input type="hidden" name="goodsId" value="'+ sGoodsId +'">';
				html += '<input type="hidden" name="goodsEstmTp" value="'+ sGoodsEstmTp +'">';
				html += '<input type="hidden" name="ordNo" value="'+ sOrdNo +'">';
				html += '<input type="hidden" name="ordDtlSeq" value="'+ sOrdDtlSeq +'">';
				html += '<input type="hidden" name="goodsEstmNo" value="'+ sGoodsEstmNo +'">';
				
				if(sGoodsEstmTp != null && sGoodsEstmTp == "PLG"){
					
					//estmData.data('petLogNo') 값을 알아야함
					//html += '<input type="hidden" name="petLogNo" value="'+estmData.data('petLogNo')+'">';
					html += '<input type="hidden" name="petLogNo" value="">';
				}
				
				var goform = $("<form>",
					{ method : "post",
					action : url,
					target : "_self",
					html : html
					}).appendTo("body");
				goform.submit();
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
			/* , purchase : function(ordNo, ordDtlSeq){
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
			} */
			, purchase : function(ordNo, ordDtlSeq, ordDtlStatCd){
				
				if(ordDtlStatCd == "${FrontWebConstants.ORD_DTL_STAT_150}" ){
					
					ui.confirm('<div class="info-txt t3"><ul><li>구매확정 이후에는 반품/교환이 불가하므로 상품을 배송 받으신 후에 구매확정을 해주세요.</li><li>상품을 배송받지 않은 상태에서 구매확정을 하신 경우 상품 미수령에 대한 책임은 구매자에게 있습니다.</li></ul></div>',{ // 컨펌 창 띄우기
						//tit:"아직 배송중인 상품이 있습니다. <br>구매확정을 하시겠습니까?",
						tit:"아직 배송중인 상품이 있어요<br>구매를 확정할까요?",								
						ycb:function(){
							orderDeliveryListBtn.purchaseNext(ordNo, ordDtlSeq);
						},					
						ybt:'예',
						nbt:'아니요'	
					});
				}else{
					orderDeliveryListBtn.purchaseNext(ordNo, ordDtlSeq);
				}				
			}
			, purchaseNext : function(ordNo, ordDtlSeq){
				var action = "/mypage/order/indexPurchaseRequest";				
				
				$("#delivery_list_ord_no").val(ordNo);
				$("#delivery_list_ord_dtl_seq").val(ordDtlSeq);
				$("#claim_request_list_form").attr("target", "_self");
				$("#claim_request_list_form").attr("method", "post");
				$("#claim_request_list_form").attr("action", action);
				$("#claim_request_list_form").submit();
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
			// 주문취소 페이지 
			, goCancelAllRequest : function(ordNo){
				
				if(ordNo == null || ordNo == undefined || ordNo == ""){			
					ui.alert("주문번호 오류입니다.",{					
						ybt:'확인'	
					});
					return;
				}else{	
				
					var url = "<spring:url value='/mypage/insertClaimCancelExchangeRefund' />";
					
					$("#delivery_list_ord_no").val(ordNo);		
					$("#clmTpCd").val("${FrontWebConstants.CLM_TP_10}");
					$("#clmRsnCd").val("${FrontWebConstants.CLM_RSN_110}");
					
					
					ui.confirm('<div class="info-txt t3"><ul><li>입금대기 취소는 <span>전체 취소만 가능</span>합니다. </li><li>일부 상품만 구매를 원하시는 경우, 취소 후 다시 주문해 주시기 바랍니다.</li></ul></div>',{ // 컨펌 창 띄우기
						tit:"주문을 취소할까요?",
						ycb:function(){
							var options = {
								url : url
								, data : $("#claim_request_list_form").serializeArray()
								, done : function(data){					
									if(data != null){
										ui.toast('주문 취소가 완료되었어요.',{
											sec:3000,
											ccb:function(){  // 토스트 닫히면 실행할 함수
												orderDeliveryList.reload();
											}
										});
									}
								}
							};		
							
							ajax.call(options);
						},					
						ybt:'예',
						nbt:'아니요'	
					});	
				
				}			
				
			}	
			// 교환 신청
			, goExchangeRequest : function(ordNo ,ordDtlSeq, clmIngYn, rtnIngYn){
				
				if(clmIngYn === "Y"){
					if(rtnIngYn == "Y"){
						ui.alert("<spring:message code ='front.web.view.claim.refund.claim.ing.refund'/>" ,{
							ybt:'확인'
						});
					}else{
						ui.alert("<spring:message code ='front.web.view.claim.refund.claim.ing.exchange'/>" ,{
							ybt:'확인'
						});
					}
					return;
				}
				
				var action = "/mypage/order/indexExchangeRequest";
				
				$("#delivery_list_ord_no").val(ordNo);
				$("#delivery_list_ord_dtl_seq").val(ordDtlSeq);
				$("#claim_request_list_form").attr("target", "_self");
				$("#claim_request_list_form").attr("method", "post");
				$("#claim_request_list_form").attr("action", action);
				$("#claim_request_list_form").submit();			
			}
			// 반품 신청
			, goReturnRequest : function(ordNo, ordDtlSeq, clmIngYn, rtnIngYn, rtnPsbYn){
				
				if(clmIngYn === "Y"){
					if(rtnIngYn == "Y"){
						ui.alert("<spring:message code ='front.web.view.claim.refund.claim.ing.refund'/>" ,{
							ybt:'확인'
						});
					}else{
						ui.alert("<spring:message code ='front.web.view.claim.refund.claim.ing.exchange'/>" ,{
							ybt:'확인'
						});
					}
					return;
				}
	
				if(rtnPsbYn != "Y"){				
					ui.alert("<spring:message code='front.web.view.claim.refund.claim_psb' />",{					
						ybt:'확인'	
					});
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
			,goOrderDelete : function(ordNo){
				
				ui.confirm("<spring:message code='front.web.view.order.claimlist.deletedorderlists.never.be.back' />" + "<spring:message code='front.web.view.order.claimlist.want.to.delete.deletedorderlists' />",{ // 컨펌 창 띄우기
					ycb:function(){
						var options = {
							   url : "<spring:url value='/mypage/order/ordDeleteProcess' />"
								, data : { ordNo : ordNo}
								, done : function(data){									
									orderDeliveryList.reload();
								}
							}; 
						ajax.call(options);
					},					
					ybt:'<spring:message code='front.web.view.common.yes' />',
					nbt:'<spring:message code='front.web.view.common.no' />'
				});	
			}
		} 
		
		//전체주문보기
		function searchAllOrder(){
			$(".step-list li").each(function(){
				if($(this).hasClass('on')){
					$(this).find('a').click();
				}
			});									
		}

		//주문상태 변경
		function orderStatusChangeFn(statusClass) {
			//var statusClass = $("input[name=arrOrdDtlStatCd]").val();
			
			$(".step-list>ul").children("li").removeClass("on");
			$(".step-list>ul").children("li").find("p:eq(0)").removeClass("color");
			
		    switch (statusClass){
				case "110" :
					$("#stepOne").addClass("on");
					$("#stepOne").find("p:eq(0)").addClass("color");
					$(".btn-fixed-round").css("display","block");
					break;
				case "120" :
					$("#stepTwo").addClass("on");
					$("#stepTwo").find("p:eq(0)").addClass("color");
					$(".btn-fixed-round").css("display","block");
					break;
				case "140" :
					$("#stepThree").addClass("on");
					$("#stepThree").find("p:eq(0)").addClass("color");
					$(".btn-fixed-round").css("display","block");
					break;	     
				case "150" :
					$("#stepFour").addClass("on");
					$("#stepFour").find("p:eq(0)").addClass("color");
					$(".btn-fixed-round").css("display","block");
					break;
				case "160" :
					$("#stepFive").addClass("on");
					$("#stepFive").find("p:eq(0)").addClass("color");
					$(".btn-fixed-round").css("display","block");
					break;
				case "170" :
					$("#stepSix").addClass("on");
					$("#stepSix").find("p:eq(0)").addClass("color");
					$(".btn-fixed-round").css("display","block");
					break;
				default :
					$(".btn-fixed-round").css("display","none");
					break;
		    }

			//주문 내역 삭제 버튼, 배송 조회 버튼
			var $delBtn = $(".ord-del-btn , .detail-btn[data-action='goodsflow'] , .add-cart-btn , .cs-btn , .completeBtn , .dlvr-current-status");
			$delBtn.remove();
		}
		
</script>
</tiles:putAttribute>
	<tiles:putAttribute name="content">
	
		<c:if test="${view.deviceGb eq frontConstants.DEVICE_GB_10 }">
			<jsp:include page="/WEB-INF/tiles/include/lnb_my.jsp" />
			<jsp:include  page="/WEB-INF/tiles/include/menubar.jsp" />
		</c:if>
		
		<main class="container lnb page my" id="container">
			<div class="inr">
				<!-- 본문 -->
				<div class="contents" id="contents">
							
					<!-- // PC 타이틀 모바일에서 제거  -->
					<div class="pc-tit">
						<h2>펫츠비 주문/배송</h2>
					</div>
					<!-- 주문 배송 -->
					<div class="delivery-oder-area" id="deliveryList">
						<div class="inr-box piner">
							<div class="pc-re-po01">
								<div class="oder-step ptb_memOrderbox">
									<div class="ptb_orderList">
										<p>2021.04.30 이전 5년간의 구매이력을 확인하실 수 있어요.</p>
									</div>

									<nav class="menushop re-po01">
										<button type="button" class="bt st"></button>
										<div class="list">
											<ul class="menu">
												<li ><a href="#" id="period_type_3" data-content="${session.migMemno }" data-url="/mypage/order/indexPetsbeDeliveryList?page=${orderSO.page}&rows=${orderSO.rows}&period=3&ordAcptDtmStart=<frame:timestamp date="${orderSO.ordAcptDtmStart}" dType="H" />&ordAcptDtmEnd=<frame:timestamp date="${orderSO.ordAcptDtmEnd}" dType="H" />&arrOrdDtlStatCd=${ orderSO.arrOrdDtlStatCd }" class="bt" onclick="orderDeliveryList.setPeriod(3);return false;">최근 3개월</a></li>
												<li><a href="#" id="period_type_6" data-content="${session.migMemno }" data-url="/mypage/order/indexPetsbeDeliveryList?page=${orderSO.page}&rows=${orderSO.rows}&period=6&ordAcptDtmStart=<frame:timestamp date="${orderSO.ordAcptDtmStart}" dType="H" />&ordAcptDtmEnd=<frame:timestamp date="${orderSO.ordAcptDtmEnd}" dType="H" />&arrOrdDtlStatCd=${ orderSO.arrOrdDtlStatCd }"	class="bt" onclick="orderDeliveryList.setPeriod(6);return false;">최근 6개월</a></li>
												<li><a href="#" id="period_type_9" data-content="${session.migMemno }" data-url="/mypage/order/indexPetsbeDeliveryList?page=${orderSO.page}&rows=${orderSO.rows}&period=9&ordAcptDtmStart=<frame:timestamp date="${orderSO.ordAcptDtmStart}" dType="H" />&ordAcptDtmEnd=<frame:timestamp date="${orderSO.ordAcptDtmEnd}" dType="H" />&arrOrdDtlStatCd=${ orderSO.arrOrdDtlStatCd }"	class="bt" onclick="orderDeliveryList.setPeriod(9);return false;">최근 9개월</a></li>
												<li class="active"><a href="#" id="period_type_12"data-content="${session.migMemno }" data-url="/mypage/order/indexPetsbeDeliveryList?page=${orderSO.page}&rows=${orderSO.rows}&period=12&ordAcptDtmStart=<frame:timestamp date="${orderSO.ordAcptDtmStart}" dType="H" />&ordAcptDtmEnd=<frame:timestamp date="${orderSO.ordAcptDtmEnd}" dType="H" />&arrOrdDtlStatCd=${ orderSO.arrOrdDtlStatCd }" class="bt" onclick="orderDeliveryList.setPeriod(12);return false;">최근 12개월</a></li>
												<li><a href="#" id="period_type_0" data-content="${session.migMemno }" data-url="/mypage/order/indexPetsbeDeliveryList?page=${orderSO.page}&rows=${orderSO.rows}&period=0&ordAcptDtmStart=<frame:timestamp date="${orderSO.ordAcptDtmStart}" dType="H" />&ordAcptDtmEnd=<frame:timestamp date="${orderSO.ordAcptDtmEnd}" dType="H" />&arrOrdDtlStatCd=${ orderSO.arrOrdDtlStatCd }" class="bt" onclick="orderDeliveryList.setPeriod(0);return false;">직접 입력</a></li>
											</ul>
										</div>
									</nav>
	
									<!-- open 클래스 추가 시 open -->
									<div class="dummy-gray-line <c:if test="${orderSO.period eq '0'}">open</c:if>" style="margin-bottom:10px;">
										<div class="dummy-gray-line open">
											<div class="layout-date-picker noIcon">
												<span class="uiDate"><input type="text" value="<frame:timestamp date="${orderSO.ordAcptDtmStart}" dType="C" />" class="datepicker" title="날짜" id="delivery_start_dt" readonly="readonly" ></span>
												<span class="gap-area">-</span>
												<span class="uiDate"><input type="text" value="<frame:timestamp date="${orderSO.ordAcptDtmEnd}" dType="C" />"  class="datepicker" title="날짜" id="delivery_end_dt" readonly="readonly"></span>
												<a href="#" data-content="${session.migMemno }" data-url="/mypage/order/indexPetsbeDeliveryList?page=${orderSO.page}&rows=${orderSO.rows}&period=${orderSO.period}&ordAcptDtmStart=<frame:timestamp date="${orderSO.ordAcptDtmStart}" dType="H" />&ordAcptDtmEnd=<frame:timestamp date="${orderSO.ordAcptDtmEnd}" dType="H" />&arrOrdDtlStatCd=${ orderSO.arrOrdDtlStatCd }" onclick="orderDeliveryList.search();return false;" class="btn lg">조회</a>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>

						<jsp:include page="/WEB-INF/view/mypage/order/include/includeDelivery.jsp"/><!-- 주문/배송 form,목록 include -->
					</div>				
				</div>
			</div>
		</main>

		
		<div class="layers" id="emptyLayers">
			<!-- 레이어팝업 넣을 자리 -->
		</div>
		
		<form id="claim_request_list_form"> 
			<input type="hidden" id="delivery_list_ord_no" name="ordNo" value="" /> 
			<input type="hidden" id="delivery_list_ord_dtl_seq" name="ordDtlSeq" value="" /> 
			<input type="hidden" id="clmTpCd" name="clmTpCd" value=""/>
			<input type="hidden" id="checkCode" name="checkCode" value="" />
			<input type="hidden" id="clmRsnCd" name="clmRsnCd" value="" />
			<input type="hidden" id="mngb" name="mngb" value="OL" />
		</form>
		
	</tiles:putAttribute>
	</tiles:insertDefinition>