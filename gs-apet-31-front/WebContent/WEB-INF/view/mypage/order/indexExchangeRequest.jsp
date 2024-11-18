	<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
	<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
	<%@ page import="front.web.config.constants.FrontWebConstants" %> 
	<%@ page import="framework.common.constants.CommonConstants" %>
	<%@ page import="framework.common.enums.ImageGoodsSize" %>
	
	<tiles:insertDefinition name="common">
	<tiles:putAttribute name="script.include" value="script.order"/>
	<tiles:putAttribute name="script.inline">	
	<script type="text/javascript">
		var claimRefundVO;
		
		$(document).ready(function(){
			$("#header_pc").removeClass("mode0");
			$("#header_pc").addClass("mode16");
			$("#header_pc").attr("data-header", "set22");
			$("#header_pc").addClass("logHeaderAc");
			$(".mo-heade-tit .tit").html("교환 신청");		 
			$(".mo-header-backNtn").removeAttr("onclick");
			$(".mo-header-backNtn").bind("click", function(){			
				
				if("${mngb}" == "OL"){
					$("#claim_request_list_form").attr("action", "/mypage/order/indexDeliveryList");
					$("#claim_request_list_form").submit();
					storageHist.goBack();
				}else if("${mngb}" == "OD"){
					$("#claim_request_list_form").attr("action", "/mypage/order/indexDeliveryDetail");
					$("#claim_request_list_form").attr("method", "get");
					var ordNo = $("#ordNo").val();			
					var hidhtml = "<input type=\"hidden\" name=\"ordNo\"  value="+ ordNo +" /><input type=\"hidden\" name=\"mngb\"  value=\"OD\" />";
					$("#claim_request_list_form").append(hidhtml);
					$("#claim_request_list_form").submit();
				}else{
					storageHist.goBack();
				}
				storageHist.goBack();
			});
			
			//클레임사유 500자 제한
			$('textarea[name=clmRsnContent]').on('propertychange keyup input change paste ', function(){
				if($(this).val().length >= 500){
					$(this).val($(this).val().substring(0,500));
					ui.toast("내용은 500자까지 입력할 수 있어요.");
				}
			});
		}); 
	
		$(document).ready(function(){
			claimRefundVO = new Object();		
		}); // End Ready
		
		$(document).off("click", ".uispiner .bt");
		$(document).off("click", ".uispiner .plus");
		$(document).off("click", ".uispiner .bt");
		$(document).off("click", ".uispiner .minus");
		$(document).on("click",".uispiner .plus",function(e){
			e.preventDefault();
			var $qtyObj = $(this).siblings(".amt");
			var cnt = $qtyObj[0].value*1;
			cnt += 1;
			var originSaleAmt = $qtyObj.data("saleamt");
			$(this).parent().parent().siblings().find('.name .price .p').text(fnComma(cnt*originSaleAmt));
		});
		
		$(document).on("click",".uispiner .minus",function(e){
			e.preventDefault();
			var $qtyObj = $(this).siblings(".amt");
			var cnt = $qtyObj[0].value*1;
			cnt -= 1;
			var originSaleAmt = $qtyObj.data("saleamt");
			$(this).parent().parent().siblings().find('.name .price .p').text(fnComma(cnt*originSaleAmt));
		});
	
		$(function() {
			// 교환안내 확인 초기화
			//$("input:checkbox[name=checkAgree]").prop("checked", false);
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
				
				if($("#listCheckExchange"+i).is(":checked") == true){					
					$("#arrClmQty"+i).prop("disabled", false);
					$("#ordDtlSeq"+i).prop("disabled", false);
					$("#goods_id"+i).prop("disabled", false);
					$("#orgItemNo"+i).prop("disabled", false);
					$("#itemNo"+i).prop("disabled", false);
					$("#dlvrcPlcNo"+i).prop("disabled", false);
					$("#addSaleAmt"+i).prop("disabled", false);
				}else{
					$("#arrClmQty"+i).prop("disabled", true);
					$("#ordDtlSeq"+i).prop("disabled", true);
					$("#goods_id"+i).prop("disabled", true);
					$("#orgItemNo"+i).prop("disabled", true);
					$("#itemNo"+i).prop("disabled", true);
					$("#dlvrcPlcNo"+i).prop("disabled", true);
					$("#addSaleAmt"+i).prop("disabled", true);				
				}
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
					, data : $("#exchange_request_list_form").serialize()
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
				
				//getClaimRefundExcpect();
			}
		}
		
	
		//주문 교환 신청하기 button   
		function insertExchangeRequestList(){
			if (!clmQtyCheck()) {		
				ui.alert("교환할 상품을 선택해주세요.",{					
					ybt:'확인'	
				});					
				return;			
			} else if (!clmRsnCdCheck()) {			
				ui.alert('교환 사유를 선택해주세요',{					
					ybt:'확인'	
				});			
				$("#clmRsnCd").focus();		
				return;
			}else if ($.trim($("#clmRsnType").val()) == "" ) {			
				
				if(!clmRsnContent()){
					ui.alert('상세 사유를 입력해주세요.',{					
						ybt:'확인'	
					});			
					$("#clmRsnContent").focus();
					return;			
				}		
				
				var content = $("#clmRsnContent").val();
				if(content.length < 10){
					ui.alert('상세사유는 10자 이상 입력해주세요.',{					
						ybt:'확인'	
					});			
					$("#clmRsnContent").focus();					
					return false;
				}
				
				if($("#rtnImageArea").children('div').length-1 == 0){
					ui.alert('사진을 첨부해주세요.',{					
						ybt:'확인'	
					});			
					$("#clmRsnContent").focus();
					return;			
				}	
				
			} 
			
			if(true){
				//교환불가능한 상품이 포함됐는지 체크 == 교환 도중 ord_dtl_stat_cd 가 변경된 경우 
	    		var arrClmQty = $("input[name=arrClmQty]");
	    		var checkedNos=[]; //0,1,2
				var checkedOrdDtlSeqs=[];//OrdDtlSeqs
				var checkedCnt = 0 ;
				var result = true;
				for(var i=0; i <arrClmQty.length; i++){
					if($("#listCheckExchange"+i).is(":checked") == true){
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
									 if(orderDetailList[i].ordDtlStatCd != "${FrontWebConstants.ORD_DTL_STAT_160}"){
										 changedSeqs[cnt] = checkedNos[j];
										 cnt++;
										 result = false;
									 }
								 }
							 }
						 }
						 if(!result){
							 ui.alert('<spring:message code="front.web.view.claim_exchange.msg.ordDtlStat" />',{
								ycb: function(){
									for(var i=0; i <changedSeqs.length; i++){
										var seq = changedSeqs[i];
										$("#listCheckExchange"+seq).prop("disabled", true);
										$("#listCheckExchange"+seq).prop("checked", false);
										$("#arrClmQty"+seq).prop("disabled", true);
										$("#ordDtlSeq"+seq).prop("disabled", true);
										$("#orgItemNo"+seq).prop("disabled", true);
										$("#orgItemNo").val("");  
										
			    						$("#goods_id"+seq).prop("disabled", false);
			    						$("#itemNo"+seq).prop("disabled", false);
			    						$("#dlvrcPlcNo"+seq).prop("disabled", false);
			    						$("#addSaleAmt"+seq).prop("disabled", false);
									}
									$("input[name='radioClmRsnCd']").prop("checked", false);
								},
			  					ybt:'확인'	
			  				});
						 }
						 
						 // 교환상품 재고 확인
						var goodsInfoObjCnt = $("#exchange_request_list_form .oder-cancel li").length;
						var stkQtyList = data.stkQtyList;
						var outOfQtyList = new Array();
						for(var i=0; i < arrClmQty.length; i++){
							if($("#listCheckExchange"+i).is(":checked") == true){
								var thisCheckedGoodsId = $("#goods_id"+i).val();
								var thisCheckedClmQty = $("#clmQty"+i).val();
								for(var j=0 ; j < stkQtyList.length ; j++){
									console.log("this",stkQtyList[j]);
									if( thisCheckedGoodsId == stkQtyList[j].goodsId && thisCheckedClmQty > stkQtyList[j].webStkQty){
										outOfQtyList.push(stkQtyList[j].goodsId + " " +$("#exchange_request_list_form ul li:eq("+i+") .name .tit").text());
									}
								}
							}
						}
						if(outOfQtyList.length > 0){
							result = false;
							ui.alert('아래 상품 재고 수량 부족으로 교환 신청이 불가합니다. 고객센터로 문의해 주세요.<br/>'+outOfQtyList.join("<br/>"),{
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
			
	
			/* var exAppChecked = $("input:checkbox[name=checkAgree]").is(":checked");
			if(exAppChecked){               //교환안내사항 확인여부 여부
				setClmQty();
	  			fnExchange.check();
			} else {
				alert('<spring:message code="front.web.view.claim.msg.exchange_info.check" />'); 
				$("input:checkbox[name=checkAgree]").focus();
				return;
			} */
			
			
			
			ui.confirm('<spring:message code="front.web.view.claim.exchange.confirm.claim_accept" />',{ // 컨펌 창 띄우기
				ycb:function(){				
					setClmQty();
					//fnExchange.check();
					insertAccess();
					
				},
				ybt:'확인',
				nbt:'취소'	
			});		
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
								ui.alert('<spring:message code="front.web.view.goods.detail.item.soldout" />',{					
				  					ybt:'확인'	
				  				});							
								return;
							}
							if(data.item.webStkQty < 1){
								ui.alert('<spring:message code="front.web.view.goods.detail.item.soldout" />',{					
				  					ybt:'확인'	
				  				});						
								return;
							}
							
							var arrClmQty = $("input[name=arrClmQty]");
							for(var i=0; i <arrClmQty.length; i++){
								if($("#listCheckExchange"+i).is(":checked") == true){					
									if(data.item.addSaleAmt == $('#addSaleAmt'+i).val()){									
										$("#itemNo"+i).val(data.item.itemNo);
									}	
								}
							}
							
							insertAccess();
							
							/* if (claimRefundVO.totAmt < 0) {
								$("#payAmt").val(Math.abs(claimRefundVO.totAmt));
							} else {
								$("#payAmt").val(0);
							} */
							
							//inipay.open();
							
							/* ui.confirm('<spring:message code="front.web.view.claim.exchange.confirm.claim_Item_check" />',{ // 컨펌 창 띄우기
								ycb:function(){
									inipay.open();					
								},
								ybt:'확인',
								nbt:'취소'	
							}); */					
							
						}
					};
					ajax.call(options);
				} else {
					if (claimRefundVO.totAmt < 0) {
						$("#payAmt").val(Math.abs(claimRefundVO.totAmt));
					} else {
						$("#payAmt").val(0);
					}
					
					//inipay.open();
					insertAccess();
				}
			}
		}
		
		function insertAccess(){
			var mbrNo = '${session.mbrNo}';
			var url = "<spring:url value='/mypage/insertClaimCancelExchangeRefund' />";
			var formUrl = "/mypage/order/indexExchangeCompletion";
			
			/* if ("${session.mbrNo}" == "${FrontWebConstants.NO_MEMBER_NO}") {
				url = "<spring:url value='/mypage/noMemberInsertClaimCancelExchangeRefund' />";
	// 			formUrl = "/mypage/order/indexNoMemberExchangeCompletion";
			} */
			
			// 2021.05.06, ssmvf01
			var formData;
			if ("${view.deviceGb}" == "${frontConstants.DEVICE_GB_30}") {
				formData = $("#exchange_request_list_form :input[name!='imgPaths']").serialize();
			} else {
				formData = $("#exchange_request_list_form").serialize();
			}
			
			var options = {
					url : url
					, data : formData	// 2021.05.06, ssmvf01
					, done : function(data){
						if(data != null){
							// 2021.05.06, ssmvf01
							if("${view.deviceGb}" == "${frontConstants.DEVICE_GB_30}" && $("div[id^=rtnImgArea_]").length > 0) {
								$("input[name=clmNo]").val(data.clmNo);
								
								onFileUpload(data.clmNo);
								return;
							}
							
							jQuery("<form action=\"" + formUrl + "\" method=\"get\"><input type=\"hidden\" name=\"clmNo\" value=\""+data.clmNo+"\" /></form>").appendTo('body').submit();	
						}
					}
			};
			
			ajax.call(options);
		}
		
		function clmQtyCheck() {
			var clmQty = document.getElementsByName('clmQty');
			var totClmQty = 0;
			for(var i=0; i <clmQty.length; i++){		
				if($("#listCheckExchange"+i).is(":checked") == true){					
					totClmQty += parseInt($("#clmQty"+i).val());
				}
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
		
		function clmRsnContent() {
			
			if($("#clmRsnContent").val() == ""){
				return false;
			}	
	  		return true;
	  	}
			
		/*
		 * 취소, 교환, 반품 조회 화면 리로딩
		 */

		function searchClaimRequestList(){
			if("${mngb}" == "OL"){
				$("#claim_request_list_form").attr("action", "/mypage/order/indexDeliveryList");
			}else if("${mngb}" == "OD"){
				$("#claim_request_list_form").attr("action", "/mypage/order/indexDeliveryDetail");
				$("#claim_request_list_form").attr("method", "get");
				var ordNo = $("#ordNo").val();	
				var mngb = "${mngb}";
				var hidhtml = "<input type=\"hidden\" name=\"ordNo\"  value="+ ordNo +" /><input type=\"hidden\" name=\"mngb\"  value="+mngb+" />";
				$("#claim_request_list_form").append(hidhtml);
			}else{
				$("#claim_request_list_form").attr("action", "/mypage/order/indexDeliveryList");	
			}
			
			$("#claim_request_list_form").attr("target", "_self");		
			$("#claim_request_list_form").submit();
		}
	
		/*******************
		 * INIpay 결제
		 *******************/
		 var inipay = {
			open : function(){
				/* if ($("#orgItemNo").val() == $("#itemNo").val()) {
					if (!confirm('<spring:message code="front.web.view.claim.exchange.confirm.claim_Item_check" />') ) {
						return;
					}
				} else if (!confirm('<spring:message code="front.web.view.claim.exchange.confirm.claim_accept" />') ) {
					return;
				} */
				
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
		
	 
		$(function(){
			
			//이미지 삭제
			/*
			$("#exchange_request_list_form").on('click', 'button[name=delImg]', function(){
				$(this).parent('p').parent('div').remove();
				rtnImgCheck();
			});
			*/
			
			$("input[name='radioClmRsnCd']:radio").change(function (){
				
				$("#clmRsnType").val("");
				
				//350,360 둘다 판매자 배송비 부담임 
				/* if($(this).val() == "360"){
					$("#clmRsnType").val("1");
				} */	
				
				$('.radio').removeClass('on');
				$("#clmRsnCd").val($(this).val());
				//if($(this).val() == "360"){				
					$(this).parent('.radio').addClass('on');
				//}	
				//getClaimRefundExcpect();			
			});
			
			$(".uispiner .bt").click(function(){			
				if($(this).parents("div.untcart").find("input[name='arrListCheckExchange']").is(":checked") == true){			
					$("input[name='radioClmRsnCd']").prop("checked", false);		
				}	
			});
			
			if($("input[name='arrListCheckExchange']").length > 0){
				$("input[name='arrListCheckExchange']").click(function(){
					$("input[name='radioClmRsnCd']").prop("checked", false);				
				});
			}	
			
			
		});
		
		
		//사진 첨부
		function imageUpload(){
			if("${view.deviceGb}" != "APP"){
				fileUpload.image(imageUploadCallBack)
			}else{
				callAppFunc("onOpenGallery");
			}
		}
		
		var maxfileSize = 0;	//업로드 가능한 파일 총 용량
		var orgFlNms = new Array();
		var phyPaths = new Array();
		var flSzs = new Array();
		
		function imageUploadCallBack(result){
			if("${view.deviceGb}" != "APP"){
				if($("div[id^=rtnImgArea_]").length > 4) {
					ui.alert('파일 첨부는 최대 5개까지 가능합니다',{					
						ybt:'확인'	
					});
					return false;
				}
				
				var area = "";
				var count = "1";
				area = $("div[id^=rtnImgArea_]").length!=0?$("div[id^=rtnImgArea_]").last()[0]:null;
				if(area != null && area != ""){
					count = parseInt(area.id.split('_')[1])+1;
				}
				
				var html = "";
				html += '<div class="picture swiper-slide" id="rtnImgArea_'+ count +'">';
				html += '<input type="hidden" name="fileName" id="fileName" value="'+result.file.fileName+'">';
				html += '<input type="hidden" name="fileSize" id="fileSize" value="'+result.file.fileSize+'">';
				html += '<input type="hidden" name="filePath" id="filePath" value="'+result.file.filePath+'">';
				html += '<input type="hidden" name="imgPaths" value="'+result.file.filePath+'" >';
				html += "<p class=\"img\">";			
				html += '<img class="img" name="\claimImg\" src="/common/imageView?filePath='+result.file.filePath+'" alt="사진">';
				html += "</p>";
				html += '<button type="button" class="remove-btn" id="del" onclick="deleteImage(this);">삭제</button>';
				html += '</div>';			
				$("#rtnImageArea").append(html);
				
				rtnImgCheck();
				
			}else{
				imageResult = JSON.parse(result);
				$("#imgPathView").attr("src" , imageResult.imageToBase64)
			}
		}
		
		function deleteImage(data){		
			$(data).parent('div').remove();
			rtnImgCheck();
		}
		
		//이미지 갯수 체크
		function rtnImgCheck(){
			if($("#rtnImageArea").children('div').length-1 >= 5){			
				$("#btnRtnImage").unbind("click"); 
			}else{
				$("#btnRtnImage").bind("click");			
			}
			
		}
		
		// 2021.05.06, ssmvf01
		function onFileUpload(clmNo) {
			callAppFunc('onFileUpload', clmNo);
		}
		
		function callAppFunc(funcNm, obj) {
			toNativeData.func = funcNm;
			if(funcNm == 'onOpenGallery'){ // 갤러리 열기
				// 데이터 세팅
				toNativeData.useCamera = "P";
				toNativeData.usePhotoEdit = "N";
				toNativeData.galleryType = "P"
				//미리보기 영역에 선택된 이미지가 있을 경우.------------//
				let fileIds = new Array();
				let fileIdDivs = $("img[name=claimImg]");
				fileIdDivs.each(function(i, v) {
					fileIds[i] = $(this).attr("id");
				})
				toNativeData.fileIds = fileIds;
				//---------------------------------------//
				toNativeData.maxCount = 5;
				/* toNativeData.previewWidth = 188;
				toNativeData.previewHeight = 250; */
				toNativeData.callback = "fileUpload.appResultImage";
				toNativeData.callbackDelete = "fileUpload.appDeleteResultImage";
			}else if(funcNm == 'onDeleteImage'){ // 미리보기 썸네일 삭제
				// 데이터 세팅
				var fileId = $(obj).parent().find("img").attr("id");
							
				$(obj).parent().remove();
				
				// 데이터 세팅
				toNativeData.func = "onDeleteImage";
				toNativeData.fileId = fileId;
				toNativeData.callback = "rtnImgCheck";
	
			}else if(funcNm == 'onFileUpload'){ // 파일 업로드
				// 데이터 세팅
				toNativeData.func = funcNm;
				toNativeData.prefixPath = "/claim/"+obj;	// 2021.05.06, ssmvf01
				toNativeData.callback = "onFileUploadCallBack";
	
			}else if(funcNm == 'onClose') { // 화면 닫기
				// 데이터 세팅
				toNativeData.func = funcNm;
	
			}
			// 호출
			toNative(toNativeData);
		}
		
		// 2021.05.06, ssmvf01
		function onFileUploadCallBack(result) {
			var file = JSON.parse(result);
			var clmNo = $("input[name=clmNo]").val();
			var imgPaths = new Array();
			/* file.images[0].filePath */
			if(file.images.length != 0){
				for(var i = 0; i < file.images.length; i++){
					imgPaths.push(file.images[i].filePath);
				}
			}
			
			var options = {
				url : "<spring:url value='/mypage/appClaimImageSave' />"
				, data : { clmNo : clmNo, imgPaths : imgPaths }
				, done : function(result) {
					var formUrl = "/mypage/order/indexExchangeCompletion";
					jQuery("<form action=\"" + formUrl + "\" method=\"post\"><input type=\"hidden\" name=\"clmNo\" value=\""+clmNo+"\" /></form>").appendTo('body').submit();
				}
			}
			ajax.call(options);
		}
			
		
		//파일 업로드
		var fileUpload = {
			image: function (callback) {
				fileUpload.callBack = callback;
				fileUpload.fileForm("inquiry");
			},
			fileForm: function (type) {
				$("#fileUploadForm").remove();
				var html = [];
				html.push("<form name=\"fileUploadForm\" id=\"fileUploadForm\" method=\"post\" enctype=\"multipart/form-data\">");
				html.push("	<div style=\"display:none;\">");
				html.push("		<input type=\"file\" name=\"uploadFile\" id=\"inquiryUploadFile\" />");
				html.push("		<input type=\"hidden\" name=\"uploadType\" value=\"" + type + "\">");
				html.push("	</div>");
				html.push("</form>");
				$("body").append(html.join(''));
				$("#inquiryUploadFile").click();
			},
			
			afterFileSelect: function (file, exCode) {			
				var html = "";
				html += "<div class=\"picture swiper-slide\">";
				html += '<input type="hidden" name="fileName" value="'+file.file.fileName+'">';
				html += '<input type="hidden" name="fileSize" value="'+file.file.fileSize+'">';
				html += '<input type="hidden" name="filePath" value="'+file.file.filePath+'">';
				html += '<input type="hidden" name="imgPaths" value="'+file.file.filePath+'">';
				html += "<p class=\"img\">";
				html += "<img class=\"img\" src=\"../../_images/_temp/goods_1.jpg\" alt=\"사진\">";
				html += "</p>";
				html += "<button type=\"button\" class=\"remove-btn\" name=\"delImg\">삭제</button>";
				html += "</div>";			
				$("#rtnImageArea").append(html);		
				
				rtnImgCheck();
				
			},
			
			appResultImage : function(result){
				imageResult = JSON.parse(result);
				var area = "";
				var count = "1";		
				area = $("div[id^=rtnImgArea_]").length!=0?$("div[id^=rtnImgArea_]").last()[0]:null;
				
				if(area != null && area != ""){
					count = parseInt(area.id.split('_')[1])+1;
				}
				
				// ssmvf01
				if (count > 5) {
					ui.alert('파일 첨부는 최대 5개까지 가능합니다',{					
						ybt:'확인'	
					});
					return false;
				}
				
				var html = "";
				html += "<div class=\"picture swiper-slide\" id=\"rtnImgArea_"+ count +"\">";
				html += "<input type=\"hidden\" name=\"imgPaths\" value=\""+imageResult.imageToBase64+"\"/>";
				html += "<p class=\"img\">";			
				html += "<img class=\"img\" name=\"claimImg\" id=\"" + imageResult.fileId + "\" src=\"" + imageResult.imageToBase64 + "\" alt=\"사진\">";
				html += "</p>";
				html += "<button type=\"button\" onclick=\"callAppFunc('onDeleteImage',this);\" class=\"remove-btn\" name=\"delImg\" >삭제</button>";
				html += "</div>";			
				$("#rtnImageArea").append(html);
				
				rtnImgCheck();
			},
			appDeleteResultImage : function(result){
				var imageResult = $.parseJSON(result);
				$("#"+imageResult.fileId).parent("p").parent('div').remove();

				rtnImgCheck();
			}
		}
		
		$(document).on("change", "#inquiryUploadFile", function () {
			waiting.start();
			$('#fileUploadForm').ajaxSubmit({
				url: '/common/fileUploadResult',
				dataType: 'json',
				success: function (result) {
					$("#fileUploadForm").remove();
					waiting.stop();
					fileUpload.callBack(result);
				},
				error: function (xhr, status, error) {
					waiting.stop();						
				}
			});
		});
		
		
		
	</script>
	</tiles:putAttribute>
	<tiles:putAttribute name="content">
		
		<c:if test="${view.deviceGb eq frontConstants.DEVICE_GB_10 }">
			<jsp:include page="/WEB-INF/tiles/include/lnb_my.jsp" />
			<jsp:include  page="/WEB-INF/tiles/include/menubar.jsp" />
		</c:if>
		
		<!-- 바디 - 여기위로 템플릿 -->
		<main class="container lnb page shop my" id="container">
	
			<div id="order_payment_pay_dialog" style="display:none;" title="결제"></div>
			
			<form id="order_payment_form">
				<input type="hidden" id="ordNo" name="ordNo" value="${orderSO.ordNo}" /> 
				<input type="hidden" id="payAmt" name="payAmt" value="" />
				<input type="hidden" id="goodsNms" name="goodsNms" value="추가배송비" /> 
				<input type="hidden" id="payMeansCd" name="payMeansCd" value="${FrontWebConstants.PAY_MEANS_10}" />
				<input type="hidden" id="ordNm" name="ordNm" value="${order.ordNm}" /> 
				<input type="hidden" id="ordrEmail" name="ordrEmail" value="${order.ordrEmail}" /> 
				<input type="hidden" id="ordrMobile" name="ordrMobile" value="${order.ordrMobile}" /> 
			</form>
			
			<form id="claim_request_list_form" name="claim_request_list_form">
				<input type="hidden" name="clmNo" value="" />  <!-- 2021.05.06, ssmvf01  -->
			</form>
			<form id="claim_account_form" name="claim_account_form" method="post"></form>		
				
			<div class="inr">			
				<!-- 본문 -->
				<div class="contents" id="contents">
					<div class="pc-tit">
						<h2>교환신청</h2>
					</div>
					
				<!-- 주문내역 -->			
				<form id="exchange_request_list_form"  name="exchange_request_list_form">
					<input type="hidden" id="ordNo" name="ordNo" value="${orderSO.ordNo}" />  
					<input type="hidden" id="clmTpCd" name="clmTpCd" value="${CommonConstants.CLM_TP_30}"/>
					<input type="hidden" id="checkCode" name="checkCode" value="${checkCode} }" />
					<input type="hidden" id="attr_no_list" name="attrNoList" value="" />
					<input type="hidden" id="attr_no_val_list" name="attrValNoList" value="" />
					<%-- INIpay 결제 인증 리턴값 --%>
					<input type="hidden" id="order_payment_inipay_result" name="inipayStdCertifyInfo" value="" />
					
			<c:choose>
				<c:when test="${order ne '[]'}">
					<div class="oder-cancel border-on"">
						<ul>				
					
					<c:forEach items="${order.orderDetailListVO}" var="orderExchange" varStatus="idx">
						<c:set value="${orderExchange.ordDtlStatCd}" var="ordDtlStatCd"/>
						<c:set value="${idx.index}" var="index"/>
						<c:set value="${orderExchange.rmnOrdQty - orderExchange.rtnQty - orderExchange.clmExcIngQty - orderExchange.clmExcQty}" var="rmnOrdQty"/>
						
						<input type="hidden" id="ordDtlSeq${index}" name="arrOrdDtlSeq" data-mki="${ orderExchange.mkiGoodsYn }"  value="${orderExchange.ordDtlSeq}" /> 
						<input type="hidden" id="goods_id${index}" name="goodsId" value="${orderExchange.goodsId}" />
<%-- 교환 다건 진행시 오류발생하여 주석처리함, 2021.05.17 by kek01
 						<input type="hidden" id="orgItemNo${index}" name="orgItemNo" value="${orderExchange.itemNo}" />
						<input type="hidden" id="itemNo${index}" name="itemNo" value="${orderExchange.itemNo}" /> --%>
						<input type="hidden" id="dlvrcPlcNo${index}" name="dlvrcPlcNo" value="${orderExchange.dlvrcPlcNo}" />
						<input type="hidden" id="addSaleAmt${index}" name="addSaleAmt" value="${orderExchange.addSaleAmt}" />
		
							<li style="display:${rmnOrdQty eq 0 or orderExchange.clmIngYn eq 'Y' ? 'none;' : 'block'}">
								<div class="untcart <c:if test="${idx1.first}">cancel</c:if>">
									<label class="checkbox">
							<c:choose>
								<c:when test="${orderSO.ordDtlSeq eq orderExchange.ordDtlSeq }">
									<input type="checkbox" id="listCheckExchange${index}" name="arrListCheckExchange" checked="true"><span class="txt"></span>								
								</c:when>
								<c:otherwise>
									<input type="checkbox" id="listCheckExchange${index}" name="arrListCheckExchange"><span class="txt"></span>
								</c:otherwise>
							</c:choose>								
									</label>
									<div class="box">
										<div class="tops">
											<div class="pic"><a href="/goods/indexGoodsDetail?goodsId=${not empty orderExchange.pakGoodsId ? orderExchange.pakGoodsId : orderExchange.goodsId }" data-url="/goods/indexGoodsDetail?goodsId=${not empty orderExchange.pakGoodsId ? orderExchange.pakGoodsId : orderExchange.goodsId }">										
											<img src="${fn:indexOf(orderExchange.imgPath, 'cdn.ntruss.com') > -1 ? orderExchange.imgPath : frame:optImagePath(orderExchange.imgPath, frontConstants.IMG_OPT_QRY_270)}" alt="${orderExchange.goodsNm }" class="img">
											</a></div>
											<div class="name">
												<div class="tit">${orderExchange.goodsNm}</div>
												<div class="stt"><frame:num data="${rmnOrdQty}" />개
												 <c:choose>
													<c:when test="${not empty orderExchange.optGoodsNm}" >
														| ${fn:replace(orderExchange.optGoodsNm, '/', ' / ')}
													</c:when>
													<c:when test="${fn:length(orderExchange.pakItemNm) > 0 }" >															
														| ${fn:replace(orderExchange.pakItemNm, '|', ' / ')}
													</c:when>
												</c:choose> 											
												</div>
												<c:if test="${orderExchange.mkiGoodsYn eq 'Y' && not empty orderExchange.mkiGoodsOptContent }">
													<c:forTokens var="optContent" items="${orderExchange.mkiGoodsOptContent }" delims="|" varStatus="conStatus">	
														<div class="stt">각인문구${conStatus.count} : ${optContent}</div>
													</c:forTokens>
												</c:if>									
												
												<c:if test="${orderExchange.itemMngYn eq FrontWebConstants.COMM_YN_Y}">												
													<c:forEach items="${orgGoodsAttrList}" var="orgGoodsAttr">
														<input type="hidden" id="exchange_attrNo_${orgGoodsAttr.attrNo }" value="${orgGoodsAttr.attrNo }" />
														<input type="hidden" id="exchange_attrVal_${orgGoodsAttr.attrNo }" value="${orgGoodsAttr.attrValNo}" />
													</c:forEach>													
												</c:if>
												<div class="price">
													<span class="prc"><em class="p"><frame:num data="${orderExchange.saleAmt*rmnOrdQty}" /></em><i class="w">원</i></span>
												</div>
											</div>
										</div>
										<div class="amount">
											<div class="uispiner" data-min="1" data-max="${rmnOrdQty}">
											<input type="hidden" id="arrClmQty${index}" name="arrClmQty" value="0" />											
												<input type="text" value="${rmnOrdQty}" class="amt" disabled="" id="clmQty${index}" name="clmQty" data-saleamt="${orderExchange.saleAmt}" readonly>
												<button type="button" class="bt minus">수량더하기</button>
												<button type="button" class="bt plus">수량빼기</button>
											</div>
										</div>
									</div>
								</div>
							</li>
						</c:forEach>
												
						</ul>
					</div>
					<div class="exchange-area pc-reposition">
						<div class="item-box pc-reposition">
							<p class="tit">교환 사유 </p>
							<div class="sub-tit">사유 선택</div>						
							<div class="flex-wrap t1">
								<input type="hidden" id="clmRsnCd" name="clmRsnCd" />
								<input type="hidden" id="clmRsnType" name="clmRsnType" />
								<div>
							<c:forEach items="${clmRsnList}" var="clmRsn" varStatus="idx1">					
									<label class="radio"><input type="radio" name="radioClmRsnCd" value="${clmRsn.dtlCd }"><span class="txt">${clmRsn.dtlNm}</span><span class="speech-ballon">배송비 판매자 부담</span></label>										
							</c:forEach>							
								</div>
								<p class="info-t2 p1">교환은 동일한 옵션만 가능합니다. 다른 옵션으로 교환을 원하시는 경우 반품 후 재구매 부탁드리겠습니다.</p>
							</div>						
							
							<p class="sub-tit pc-reposition">상세 사유 입력</p>
							<div class="textarea">						
								<textarea placeholder="내용을 입력해주세요. (최소 10자 이상)" id="clmRsnContent" name="clmRsnContent"></textarea>
							</div>
							<div class="btnSet onMo_b">
								<a href="#" onclick="imageUpload();return false;;" class="btn lg icon">
									사진 첨부하기
								</a>
							</div>
							<div class="picture-area pc-change-design swiper-container">
								<div class="scroll-box swiper-wrapper" id="rtnImageArea">
									<div class="picture onWeb_ib swiper-slide">
										<div class="btnSet">
										
										<c:if test="${view.deviceGb eq 'PC' }">
											<a href="#" onclick="imageUpload();return false;" data-content="" data-url="/common/fileUploadResult" class="btn lg icon" id="btnRtnImage">사진 첨부하기</a>
										</c:if>	
										<c:if test="${view.deviceGb eq 'APP' }">		
											<a href="#" onclick="callAppFunc('onOpenGallery', this);" data-content="" data-url="/common/fileUploadResult class="btn lg icon" id="btnRtnImage">사진 첨부하기</a>										
										</c:if>																		
										
										</div>
									</div>							
									
								</div>
							</div>
							<p class="info-t1 t1">교환 사유를 확인할 수 있는 사진을 등록하시면 보다 신속하게 교환 진행됩니다.</p>
							<p class="info-t1 t1">이미지는 20MB 이내, JPG, JPEG, PNG 파일만 등록 가능합니다. (최대 5장 첨부 가능)</p>
						</div>
						<div class="item-box  pc-reposition">
							<p class="tit">수거지</p>
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
							<div class="sub-tit c1">
								<span id="adrsNmView" name="adrsNmView"><c:out value="${deliveryInfo.gbNm}"/></span> 
					<%--			<a href="#" onclick="goAddressChange('${orderSO.ordNo}');return false;" class="btn sm">변경</a> --%>
							</div>
							<p class="txt-t1 pc-resize-tit">
							
							<c:choose>						
								<c:when test="${deliveryInfo.roadAddr ne null}">
									[<c:out value="${deliveryInfo.postNoNew}"/>] <span id="roadAddrView" name="roadAddrView"><c:out value="${deliveryInfo.roadAddr}"/></span> <span id="roadDtlAddrView" name="roadDtlAddrView"><c:out value="${deliveryInfo.roadDtlAddr}"/></span>
								</c:when>
								<c:otherwise>
									<c:choose>
										<c:when test="${deliveryInfo.prclAddr ne null &&  deliveryInfo.prclAddr ne ''}">
									 		<span id="prclAddrViewDiv" >[<c:out value="${deliveryInfo.postNoOld}"/>] <span id="prclAddrView" name="prclAddrView"><c:out value="${deliveryInfo.prclAddr}"/></span> <span id="prclDtlAddrView" name="prclDtlAddrView"><c:out value="${deliveryInfo.prclDtlAddr}"/></span></span>
										</c:when>
										<c:otherwise>
									 		<span id="prclAddrViewDiv" style="display: none;">[<c:out value="${deliveryInfo.postNoOld}"/>] <span id="prclAddrView" name="prclAddrView"></span> <span id="prclDtlAddrView" name="prclDtlAddrView"><c:out value="${deliveryInfo.prclDtlAddr}"/></span></span>
										</c:otherwise>
									</c:choose>
								</c:otherwise>
							</c:choose>
									
							</p>
							<p class="txt-t2 pc-resize-tit"><span id="adrsNmView" name="adrsNmView"><c:out value="${deliveryInfo.adrsNm}"/></span> / <span id="mobileView" name="mobileView"><frame:mobile data="${deliveryInfo.mobile}"/></span></p>
							<p class="txt-t2 pc-resize-tit"><span id="dlvrMemoView" name="dlvrMemoView"><c:out value="${deliveryInfo.dlvrMemo}"/></span></p>
						</div>			
						
						<div class="item-box  pc-reposition">
							<p class="tit">교환 배송지</p>						
							<div class="sub-tit c1">
								<span id="adrsNmView" name="adrsNmView"><c:out value="${deliveryInfo.gbNm}"/></span> 
					<%--			<a href="#" onclick="goAddressChange('${orderSO.ordNo}');return false;" class="btn sm">변경</a> --%>
							</div>
							<p class="txt-t1 pc-resize-tit">						
							<c:choose>						
								<c:when test="${deliveryInfo.roadAddr ne null}">
									[<c:out value="${deliveryInfo.postNoNew}"/>]  <span id="roadAddrView" name="roadAddrView"><c:out value="${deliveryInfo.roadAddr}"/></span> <span id="roadDtlAddrView" name="roadDtlAddrView"><c:out value="${deliveryInfo.roadDtlAddr}"/></span>
								</c:when>
								<c:otherwise>
									<c:choose>
										<c:when test="${deliveryInfo.prclAddr ne null &&  deliveryInfo.prclAddr ne ''}">
									 		<span id="prclAddrViewDiv" >[<c:out value="${deliveryInfo.postNoOld}"/>] <span id="prclAddrView" name="prclAddrView"><c:out value="${deliveryInfo.prclAddr}"/></span> <span id="prclDtlAddrView" name="prclDtlAddrView"><c:out value="${deliveryInfo.prclDtlAddr}"/></span></span>
										</c:when>
										<c:otherwise>
									 		<span id="prclAddrViewDiv" style="display: none;">[<c:out value="${deliveryInfo.postNoOld}"/>] <span id="prclAddrView" name="prclAddrView"></span> <span id="prclDtlAddrView" name="prclDtlAddrView"><c:out value="${deliveryInfo.prclDtlAddr}"/></span></span>
										</c:otherwise>
									</c:choose>
								</c:otherwise>
							</c:choose>
									
							</p>
							<p class="txt-t2 pc-resize-tit"><span id="adrsNmView" name="adrsNmView"><c:out value="${deliveryInfo.adrsNm}"/></span> / <span id="mobileView" name="mobileView"><frame:mobile data="${deliveryInfo.mobile}"/></span></p>
							<p class="txt-t2 pc-resize-tit"><span id="dlvrMemoView" name="dlvrMemoView"><c:out value="${deliveryInfo.dlvrMemo}"/></span></p>
						</div>	
							
						<div class="info-txt t2 pc-reposition">
							<ul>
								<li>교환은 상품 수거 후 상품 이상 유무를 확인한 뒤 교환 상품이 배송 됩니다.</li>
								<li>판매자 과실 사유로 인한 교환/반품은 비용 발생 없이 처리됩니다.</li>
								<li>판매자 과실 사유로 인한 교환/반품 신청 후 상품에 이상이 없을 경우 반송 처리 될 수 있으며, 배송비를 입금해주셔야 합니다.</li>
								<li>사은품이 있을 경우 같이 반송해야하며 사은품 누락 시 교환/반품이 불가할 수 있습니다.</li>
							</ul>
						</div>
						
						<div class="btnSet space pc-reposition">						
							<a href="#" data-content="" data-url="/mypage/order/indexClaimList" onclick="searchClaimRequestList();return false;" class="btn lg d">취소</a>
							<a href="#" data-content="" data-url="/mypage/insertClaimCancelExchangeRefund" onclick="insertExchangeRequestList();return false;" class="btn lg a">교환 신청</a>						
						</div>
					</div>
				</c:when>
				<c:otherwise>	
					<div>
						교환 가능한 주문내역이 없습니다.
					</div>
				</c:otherwise>
			</c:choose>	
			
					</form>	
						
					
				</div>
	
			</div>	
		
		
		</main>
		
		<div class="layers">			
		</div>
		<!-- 바디 - 여기 밑으로 템플릿 -->
	
	</tiles:putAttribute>
	</tiles:insertDefinition>
