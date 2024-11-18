<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ page import="framework.front.constants.FrontConstants" %>
<script type="text/javascript">
	var indexOrdpan = 1;
	var stkQty = 0;
	$(document).ready(function(){
		getStkQty();
		console.log("${goods.webStkQty}")
	var goodsCstrtTpCd = "${goods.goodsCstrtTpCd}";
		console.log("stkQty: "+ stkQty)
		// 수량 직접 변경시 가격 및 총수량 계산
		if(goodsCstrtTpCd == "ITEM" || goodsCstrtTpCd == "SET") {

			$(document).off("click", ".uispiner .bt");
			$(document).off("click", ".uispiner .plus");
			$(document).on("click",".uispiner .plus",function(e) {
				e.preventDefault();
				var $qtyObj = $(this).siblings(".amt");
				console.log('includeGoodsOrdpanDetail click plus ' + parseInt($qtyObj.val()))
				var maxOrdQty = $qtyObj.data("maxOrdQty") ? $qtyObj.data("maxOrdQty") : 999; //최대주문수량 data가 있으면 maxOrdQty
				var ordmkiYn = $qtyObj.data("ordmkiYn") ? $qtyObj.data("ordmkiYn") : "N";

				if (!maxOrdQty || parseInt($qtyObj.val()) < maxOrdQty) {
					var cartQty = parseInt($qtyObj.val()) + 1;
					//var cartQty = parseInt($qtyObj.val());
					var itemNo = $qtyObj.data("itemNo");
					//$("#buyQty" + itemNo).attr("value", cartQty);
					$("#buyQty" + itemNo).val(cartQty).attr("value",cartQty);
					var goodsCstrtTpCd = "${goods.goodsCstrtTpCd}";
					//console.log("goodsCstrtTpCd : " + goodsCstrtTpCd + ", itemNo : " + itemNo + ", cartQty : " + cartQty);
					if(ordmkiYn == "Y"){	// 각인여부
						indexOrdpan++;
						if(!document.getElementById('spanOrdmki_'+ itemNo + '_' + cartQty)){
							var spanText = "";
							var n2Class = "";
							if(9 < cartQty){
								n2Class = "n2";
							}
							spanText += "<span class='input nms "+n2Class+"' id='spanOrdmki_"+itemNo+"_"+cartQty+"'>";
							spanText += "	<i class='n'>"+cartQty+".</i><input type='text' name='inputOrdmki' id='inputOrdmki_"+itemNo+"_"+cartQty+"' placeholder='각인문구를 입력해주세요' title='각인문구' value='' maxlength='40' onkeydown='javascript:fnCheckOrdmkiTextLength(this);' >";
							spanText += "</span>";
							//$("#divOrdmki_"+cartQty-1).html($("#divOrdmki_"+cartQty).html() + spanText);
							var gudText = "<div class='gud'><spring:message code='front.web.view.goods.order.carving.purchase.text' /></div>";
							$("#divOrdmki_"+itemNo + " .gud").remove();
							$("#divOrdmki_"+itemNo).append(spanText + gudText);
						}
					}

					if(goodsCstrtTpCd == "ITEM" || goodsCstrtTpCd == "SET"){
						fnClickItemTotalCnt(itemNo, cartQty);
					}else if(goodsCstrtTpCd == "PAK" || goodsCstrtTpCd == "ATTR"){
						var originSaleAmt = $qtyObj.data("saleAmt");
						fnClickPaksTotalCnt(itemNo, cartQty, originSaleAmt);
					}
				}else{
					var cartQty = parseInt($qtyObj.val());
					if(cartQty == maxOrdQty) {
					} else {
						cartQty = parseInt($qtyObj.val()) -1;
					}
					var itemNo = $qtyObj.data("itemNo");
					$("#buyQty" + itemNo).val(cartQty).attr("value",cartQty);
					fnGoodsUiToast("<spring:message code='front.web.view.goods.order.option.select.max' /> " + maxOrdQty + "<spring:message code='front.web.view.goods.order.option.limit.purchase1' />", "maxOrdQty");
				}
			});

			$(document).off("click", ".uispiner .bt");
			$(document).off("click", ".uispiner .minus");
			$(".uispiner .minus").prop("disabled", "");
			$(document).on("click",".uispiner .minus",function(e){
				e.preventDefault();
				var $qtyObj = $(this).siblings(".amt");
				console.log('includeGoodsOrdpanDetail click minus ' + parseInt($qtyObj.val()))
				var minOrdQty = $qtyObj.data("minOrdQty") ? $qtyObj.data("minOrdQty") : 1;
				var ordmkiYn = $qtyObj.data("ordmkiYn") ? $qtyObj.data("ordmkiYn") : "N";
				if (parseInt($qtyObj.val()) > minOrdQty) {
					var cartQty = parseInt($qtyObj.val()) - 1;
					//var cartQty = parseInt($qtyObj.val())
					var itemNo = $qtyObj.data("itemNo");
					//$("#buyQty" + itemNo).attr("value",cartQty);
					$("#buyQty" + itemNo).val(cartQty).attr("value",cartQty);
					if(indexOrdpan <= 0){
						indexOrdpan = 1;
					}else{
						indexOrdpan--;
					}

					var goodsCstrtTpCd = "${goods.goodsCstrtTpCd}";
					console.log("goodsCstrtTpCd : " + goodsCstrtTpCd + ", itemNo : " + itemNo + ", cartQty : " + cartQty);

					if(ordmkiYn == "Y"){
						$("[id^=spanOrdmki_" + itemNo + "_]").each(function(index){
							var idx = index + 1;
							if(cartQty < idx){
								$(this).remove();
							}
						});
					}

					if(goodsCstrtTpCd == "ITEM" || goodsCstrtTpCd == "SET"){
						fnClickItemTotalCnt(itemNo, cartQty);

					}else if(goodsCstrtTpCd == "PAK" || goodsCstrtTpCd == "ATTR"){
						var originSaleAmt = $qtyObj.data("saleAmt");
						console.log("originSaleAmt : " + originSaleAmt);
						fnClickPaksTotalCnt(itemNo, cartQty, originSaleAmt);
					}
				}else{
					var cartQty = parseInt($qtyObj.val());
					if(cartQty == minOrdQty){
						cartQty = parseInt($qtyObj.val());
					} else if(parseInt($qtyObj.val()) - 1 == 0) {
						cartQty = parseInt($qtyObj.val());
					} else {
						cartQty = parseInt($qtyObj.val()) - 1;
					}
					var itemNo = $qtyObj.data("itemNo");
					$("#buyQty" + itemNo).val(cartQty).attr("value",cartQty);
					fnGoodsUiToast("<spring:message code='front.web.view.goods.order.option.select.min' />" + minOrdQty + "<spring:message code='front.web.view.goods.order.option.limit.purchase2' />", "maxOrdQty");
				}
			});
		}
	});


	// ITEM, SET
	function fnClickItemTotalCnt(itemNo, cartQty){
		var priceCnt = Number(cartQty);
		var originPrice = Number("${listItems.saleAmt}");
		var priceAmt = valid.numberWithCommas(originPrice * priceCnt);
		//console.log("priceCnt : " + priceCnt + ", originPrice : " + originPrice + ", priceAmt : " + priceAmt);
		$("#emPriceTotalCnt").html(priceCnt);
		$("#emPriceTotalAmtItem").html(priceAmt);
		$("#emPriceTotalAmt").html(priceAmt);
	}

	// PAK, ATTR
	function fnClickPaksTotalCnt(itemNo, cartQty, originSaleAmt){

		var totalPriceAmt = 0;
		var toalCartQtyCnt = 0;
		$("[id^=selected_itemNo_]").each(function(index){
			var itemNoSelected = $("[id^=selected_itemNo_]").eq(index).val();
			var cartQtyNumber = Number($("#buyQty"+itemNoSelected).val());
			//console.log("cartPriceNumber : " + Number(originSaleAmt) + ", cartQtyNumber : " + cartQtyNumber);
			if(itemNoSelected == itemNo){
				cartQtyNumber = Number(cartQty);
				var priceAmt = valid.numberWithCommas(Number(originSaleAmt * Number(cartQty)));
				$("#buyPriceRight"+itemNoSelected).html(priceAmt);
				$("#inputBuyPriceRight"+itemNoSelected).val(priceAmt);
			}
			//totalPriceAmt = (totalPriceAmt + (Number(originSaleAmt * cartQtyNumber)));
			totalPriceAmt += Number(removeComma($("#inputBuyPriceRight"+itemNoSelected).val()));
			toalCartQtyCnt = (toalCartQtyCnt + cartQtyNumber);
			//console.log("cartPriceNumber : " + Number(originSaleAmt) + ", cartQtyNumber : " + cartQtyNumber);
		});

		//console.log("totalPriceAmt : " + totalPriceAmt + ", toalCartQtyCnt : " + toalCartQtyCnt);
		$("#emPriceTotalCnt").html(toalCartQtyCnt);
		//$("#emPriceTotalAmtItem").html(valid.numberWithCommas(totalPriceAmt * toalCartQtyCnt));
		//console.log("buyQty itemNo : " + $("#buyQty"+itemNo).val());
		$("#emPriceTotalAmt").html(valid.numberWithCommas(totalPriceAmt));

	}

	function fnChangebuyQty(obj){
		var $qtyObj = $("#"+obj.id);
		var itemNo = $qtyObj.data("itemNo");
		var minOrdQty = $qtyObj.data("minOrdQty") ? $qtyObj.data("minOrdQty") : 1;
		var maxOrdQty = $qtyObj.data("maxOrdQty") ? $qtyObj.data("maxOrdQty") : 999;
		var ordmkiYn = $qtyObj.data("ordmkiYn") ? $qtyObj.data("ordmkiYn") : "N";

		console.log("$qtyObj : "+ $qtyObj + " minOrdQty : "+minOrdQty + " maxOrdQty : "+maxOrdQty + " ordmkiYn: "+ ordmkiYn );

		var cartQty = $qtyObj.val();
		cartQty = cartQty.replace(/[^0-9]/g, '');

		// MIN 구매수량 제한
		if(cartQty < minOrdQty){
			fnGoodsUiToast("<spring:message code='front.web.view.goods.order.option.select.min' /> " + minOrdQty + "<spring:message code='front.web.view.goods.order.option.limit.purchase2' />", "minOrdQty");
			//$qtyObj.val(minOrdQty);
			cartQty = minOrdQty;
		}

		// MAX 구매수량 제한
		if(cartQty > maxOrdQty){
			fnGoodsUiToast("<spring:message code='front.web.view.goods.order.option.select.max' /> " + maxOrdQty + "<spring:message code='front.web.view.goods.order.option.limit.purchase1' />", "maxOrdQty");
			//$qtyObj.val(maxOrdQty);
			cartQty = maxOrdQty;
		}

		$qtyObj.val(cartQty).attr("value",cartQty);


		var goodsCstrtTpCd = "${goods.goodsCstrtTpCd}";

		// 수량 직접 변경시 가격 및 총수량 계산
		if(goodsCstrtTpCd == "ITEM" || goodsCstrtTpCd == "SET"){
			fnClickItemTotalCnt(itemNo, cartQty);

		}else if(goodsCstrtTpCd == "PAK" || goodsCstrtTpCd == "ATTR"){
			var originSaleAmt = $qtyObj.data("saleAmt");
			fnClickPaksTotalCnt(itemNo, cartQty, originSaleAmt);
		}

		// 제작상품 시 입력폼 수정
		if(ordmkiYn == "Y"){
			var inputOrmkiLen = $("[id^=inputOrdmki_"+itemNo+"_]").length;

			if(inputOrmkiLen < cartQty){	// 변경된 값이 기존값 보다 클때 ( + 기능 )


				var spanText = "";
				$("#divOrdmki_"+itemNo + " .gud").remove();
				//$("[id^=inputOrdmki_"+itemNo+"_]").remove();
				for(var i = 1; i <= cartQty; i++){
					if(!document.getElementById('spanOrdmki_'+ itemNo + '_' + i)){
						spanText += "<span class='input nms' id='spanOrdmki_"+itemNo+"_"+i+"'>";
						spanText += "	<i class='n'>"+i+".</i><input type='text' name='inputOrdmki' id='inputOrdmki_"+itemNo+"_"+i+"' placeholder='각인문구를 입력해주세요' title='각인문구' value='' maxlength='40' onkeydown='javascript:fnCheckOrdmkiTextLength(this);'>";
						spanText += "</span>";
					}
				}
				var gudText = "<div class='gud'><spring:message code='front.web.view.goods.order.carving.purchase.text' /></div>";
				$("#divOrdmki_"+itemNo).append(spanText + gudText);

			}else {	// 변경된 값이 기존값 작을 때 ( - 기능 )
				for(var i = 1; i <= inputOrmkiLen; i++){
					if(cartQty < i){
						$("#divOrdmki_"+itemNo + " #spanOrdmki_" + itemNo + "_" + i).remove();	// 항목 삭제
					}
				}
			}
		}
	}

	function fnCartItems(nowBuyYn){
		var isLogin = "${session.isLogin()}";
		// 요약정보에서 호출시 check 		
		var uiPdOrdPanClass = $("#uiPdOrdPan").attr("class");
		var productOptionClass = $("#productOption").attr("class");

		var setCartItemsCheck = false;
		// 비로그인 상태에서 장바구니기능이 가능하도록 처리.21.03.05
		console.log("uiPdOrdPanClass : " + uiPdOrdPanClass + ", isLogin : " + isLogin);

		if(uiPdOrdPanClass == undefined){
			// 상품 요약일때
			if(productOptionClass.indexOf("none") > -1){
				setCartItemsCheck = true;
			}
		}else{
			// 상품 상세일때				
			if(uiPdOrdPanClass.indexOf("open") > -1){
				setCartItemsCheck = true;
			}
		}

		if(setCartItemsCheck){
		var options = {
			url : "/goods/mbrStatCheck",
			data : {},
			done : function(result) {
				if(result == "false" && nowBuyYn != 'N' ){
					ui.confirm('로그인 후 서비스를 이용할 수 있어요.<br>로그인 할까요?',{ // 알럿 옵션들
						ycb:function(){
							var url = encodeURIComponent(document.location.href);
							//window.location.href = '/indexLogin?returnUrl=' + url;
							window.location.href = '/logout?returnUrl=/indexLogin';
						},
						ncb:function(){
							return false;
						},
						ybt:"로그인", // 기본값 "확인"
						nbt:"취소"  // 기본값 "취소"
					});
				}else{
			
					//if(uiPdOrdPanClass.indexOf("open") > -1){	
						var goodsCstrtTpCd = '${goods.goodsCstrtTpCd}';
						var goodsId = '${goods.goodsId}';
						var itemNo = '${listItems.itemNo == '0' ? '' : listItems.itemNo}';
						var totalCnt = $("#emPriceTotalCnt").html().trim();
						//console.log("goodsCstrtTpCd : " + goodsCstrtTpCd + ", itemNo : " + itemNo + ", goodsId : " + goodsId + ", totalCnt : " + totalCnt);
			
						if(goodsCstrtTpCd == "ITEM" || goodsCstrtTpCd == "SET"){
			
							if(totalCnt < 1){
								ui.alert("상품 수량을 선택해주세요.");
								return;
							}
			
							if("${goods.reservationType}" === "SOON"){
			
								var reservationStrtDtm = "${goods.reservationStrtDtm}";
								var reservationDate = new Date(reservationStrtDtm).dateFormat('MM월dd일');
								/* var reservationDay = reservationDate.getDate() < 10 ? "0" + reservationDate.getDate() : reservationDate.getDate(); */
								fnGoodsUiToast("사전예약 상품은 "+ reservationDate +"부터 구매할 수 있어요", "reservation");
								return;
							}
			
							var ordmkiYn = "${listItems.ordmkiYn}";
							var inputOrdmki = "";
							if(ordmkiYn == "Y" && goodsCstrtTpCd == "ITEM"){
			
								var inputOrmkiLen = $("[id^=inputOrdmki_"+itemNo+"_]").length;
			
								for(var i=1; i <= inputOrmkiLen; i++){
									var tempText = $("#inputOrdmki_"+itemNo+"_"+i).val().trim();
									if(tempText == ""){
										ui.alert("각인문구를 입력해주세요");
										$("#inputOrdmki_"+itemNo+"_"+i).val("");
										$("#inputOrdmki_"+itemNo+"_"+i).focus();
										return;
									}else{
										//console.log("inputOrdmki : " + tempText);
										if(i == 1){
											//inputOrdmki = btoa(unescape(encodeURIComponent(tempText)));
											inputOrdmki = tempText;
										}else{
											inputOrdmki = inputOrdmki + "|" + tempText;
										}
									}
								}
							}
			
							console.log("goodsCstrtTpCd : " + goodsCstrtTpCd + ", nowBuyYn : " + nowBuyYn + ", inputOrdmki : " + inputOrdmki);
							// new TextEncoder('base64').encode('A')
							// 장바구니 이동
							if(nowBuyYn == "N" || isLogin == "true"){
								//console.log("로그인 화면이동.");
								fnAddCart(goodsId, itemNo, totalCnt, nowBuyYn, '', inputOrdmki);
							}else{
								ui.confirm('<spring:message code='front.web.view.common.msg.using.login.service' />', { // 컨펌 창 옵션들
									ycb: function () {
										var url = encodeURIComponent(document.location.href);
										if("${view.deviceGb eq frontConstants.DEVICE_GB_30}" == "true" && document.location.href.indexOf("/tv/series/indexTvDetail") > -1){
											fncAppCloseMoveLogin(url);
										}else{
											document.location.href = '/indexLogin?returnUrl=' + url;
										}
									},
									ncb: function () {
										return false;
									},
									ybt: "<spring:message code='front.web.view.login.popup.title' />", // 기본값 "확인"
									nbt: "<spring:message code='front.web.view.common.msg.cancel' />"  // 기본값 "취소"
								});
							}
						}else if(goodsCstrtTpCd == "PAK" || goodsCstrtTpCd == "ATTR"){
							if(nowBuyYn == "N" || isLogin == "true"){
								//console.log("로그인 화면이동.");
								fnAddPaksCart(nowBuyYn);
							}else{
								ui.confirm('<spring:message code='front.web.view.common.msg.using.login.service' />', { // 컨펌 창 옵션들
									ycb: function () {
										var url = encodeURIComponent(document.location.href);
										if("${view.deviceGb eq frontConstants.DEVICE_GB_30}" == "true" && document.location.href.indexOf("/tv/series/indexTvDetail") > -1){
											fncAppCloseMoveLogin(url);
										}else{
											document.location.href = '/indexLogin?returnUrl=' + url;
										}
									},
									ncb: function () {
										return false;
									},
									ybt: "<spring:message code='front.web.view.login.popup.title' />", // 기본값 "확인"
									nbt: "<spring:message code='front.web.view.common.msg.cancel' />"  // 기본값 "취소"
								});
							}
						}
				}
			}
		};
		ajax.call(options);
		}
	}

	//App일때 영상상세에서 로그인 화면으로 화면 닫고 이동해야해서 추가된 함수
	function fncAppCloseMoveLogin(url){
		//데이터 세팅
		toNativeData.func = "onCloseMovePage";
		toNativeData.moveUrl = "${view.stDomain}/indexLogin?returnUrl="+url;
		//APP 호출
		toNative(toNativeData);

		//toNativeData.func = "onClosePassingData";
		//var data = "${view.stDomain}/indexLogin?returnUrl="+url;
		//toNativeData.parameters = JSON.stringify(data);
		//toNativeData.callback = "fnOnClosePassingData";
		//toNative(toNativeData);
	}

	// 텍스트 인코딩
	function fnTextEncode(str){
		if (window.TextEncoder) {
			return new TextEncoder('utf-8').encode(str);
		}
		var utf8 = unescape(encodeURIComponent(str));
		var result = new Uint8Array(utf8.length);
		for (var i = 0; i < utf8.length; i++) {
			result[i] = utf8.charCodeAt(i);
		}
		return result;
	}

	// 비로그인 함수처리.
	function fnIsLogin(){
		ui.confirm("로그인 후 서비스를 이용할 수 있어요.<br>로그인 할까요?",{
			ycb : function(){
				console.log("로그인 화면이동.");
				location.href = "/indexLogin";
			}
		});
	}
	/*
	 * 단품, 세트 - commonFunc.insertCart(‘GI000054458:302610:’, 1, ‘N’); or commonFunc.insertCart(‘GI000054458:302610:::’, ‘N’);
	 * 옵션 - commonFunc.insertCart(‘GI000054458:302610:GS000012345’, 1, ‘N’); or commonFunc.insertCart(‘GI000054458:302610:GS000012345::’, ‘N’);
	 * 묶음상품 - commonFunc.insertCart([‘GI000054458:302610:GP000012345’,'GI000054458:302610:GP000012345’], [1,2], ‘N’);
	 * commonFunc.insertCart
	* */
	function fnAddAttrsCart(){
		var listPaks = [];
		var listQtys = [];
		var goodsId = "${goods.goodsId}";
		$("[id^=selected_attrNo_]").each(function(index){
			var attrNo = $("[id^=selected_attrNo_]").eq(index).val();
			var subGoodsId = $("#selected_subGoodsId_"+attrNo).val();
			var cartQtyNumber = Number($("#buyQty"+attrNo).val());
			var goodsIdStr = subGoodsId + ":" + attrNo + ":" + (goodsId ? goodsId : "");
			console.log("goodsIdStr : " + goodsIdStr);
			// listPaks.push(goodsIdStr);
			// listQtys.push(cartQtyNumber);
		});
		// console.log("listPaks : " + JSON.stringify(listPaks) + ", listQtys : " + JSON.stringify(listQtys));
		// fnGoodsInsertCart(listPaks, listQtys, 'N');
	}

	function fnAddPaksCart(nowBuyYn){
		console.log("fnAddPaksCart");
		var listPaks = [];
		var listQtys = [];
		var pakGoodsId = "${goods.goodsId}";

		var mkiGoodsContChk = false;

		$("[id^=selected_itemNo_]").each(function(index){

			var itemNo = $("[id^=selected_itemNo_]").eq(index).val();
			var $qtyObj = $("#buyQty"+itemNo);
			var mkiGoodsYn = $qtyObj.data("ordmkiYn") ? $qtyObj.data("ordmkiYn") : "N";	//  주문제작 여부
			var inputOrdmki = "";

			if(mkiGoodsYn == "Y"){
				$("[id^=inputOrdmki_"+itemNo+"_]").each(function(ordmkiIdx){

					var idx = Number(ordmkiIdx)+1;
					var tempText = $("#inputOrdmki_"+itemNo+"_"+idx).val().trim();

					if(tempText == ""){
						ui.alert("각인문구를 입력해주세요");
						$("#inputOrdmki_"+itemNo+"_"+idx).val("");
						$("#inputOrdmki_"+itemNo+"_"+idx).focus();
						mkiGoodsContChk = true;
					}else{
						console.log("inputOrdmki : " + tempText);
						if(idx == 1){
							//inputOrdmki = btoa(unescape(encodeURIComponent(tempText)));
							inputOrdmki = tempText;
						}else{
							//inputOrdmki = inputOrdmki + "|" + btoa(unescape(encodeURIComponent(tempText)));
							inputOrdmki = inputOrdmki + "|" + tempText;
						}
					}
				});
			}

			var subGoodsId = $("#selected_subGoodsId_"+itemNo).val();
			var cartQtyNumber = Number($("#buyQty"+itemNo).val());
			var goodsIdStr = subGoodsId + ":" + itemNo + ":" + (pakGoodsId ? pakGoodsId : "") + ":" + (mkiGoodsYn ? mkiGoodsYn : "") + ":" + (inputOrdmki ? inputOrdmki : "");

			listPaks.push(goodsIdStr);
			listQtys.push(cartQtyNumber);
		});

		// 제작 내용 체크.
		if(mkiGoodsContChk){
			return;
		}


		// 상품 미선택시
		if(listPaks.length < 1){ // 상품 미선택시
			ui.toast("<spring:message code='front.web.view.goods.order.pak.option.select.msg' />");
			return;
		}else{
			for(var i = 0; i < listQtys.length; i++){
				if(Number(listQtys[i]) < 1){
					ui.alert("상품 수량을 선택해주세요.");
					return;
				}
			}
		}

		var salePsbCdLen = $("[id^=selected_salePsbCd_]").length;

		if(nowBuyYn == "Y"){
			for(var i = 0; i < salePsbCdLen; i++){
				var salePsbCd = $("[id^=selected_salePsbCd_]").eq(i).val();
				if(salePsbCd == "10"){ // 판매중지
					ui.alert("판매 중지되어 구매하실 수 없는 상품이에요");
					return;
				}else if(salePsbCd == "20"){ // 판매종료
					ui.alert("판매 종료되어 구매할 수 없는 상품이에요");
					return;
				}else if(salePsbCd == "30"){ // 품절
					ui.alert("품절되어 구매하실 수 없는 상품이에요");
					return;
				}
			}
		}

		console.log("listPaks : " + JSON.stringify(listPaks) + ", listQtys : " + JSON.stringify(listQtys));
		fnGoodsInsertCart(listPaks, listQtys, nowBuyYn);
	}

	function fnAddAttrCart(nowBuyYn){
		console.log("fnAddAttrCart");
		// var listPaks = [];
		// var listQtys = [];
		var goodsId = "${goods.goodsId}";
		$("[id^=selected_attrNo_]").each(function(index){
			var attrNo = $("[id^=selected_attrNo_]").eq(index).val();
			var attrGoodsId = $("#selected_subGoodsId_"+attrNo).val();
			var cartQtyNumber = Number($("#buyQty"+attrNo).val());
			var goodsIdStr = attrGoodsId + ":" + attrNo + ":" + (goodsId ? goodsId : "");
			console.log("goodsIdStr : " + goodsIdStr);
			// listPaks.push(goodsIdStr);
			// listQtys.push(cartQtyNumber);
		});
		// console.log("listPaks : " + JSON.stringify(listPaks) + ", listQtys : " + JSON.stringify(listQtys));
		// fnGoodsInsertCart(listPaks, listQtys, nowBuyYn);
	}


	function fnAddCart(goodsId, itemNo, cartQty, nowBuyYn, pakGoodsId, mkiGoodsOptContent){

		var mkiGoodsYn = "${listItems.ordmkiYn}";	// 제작 여부
		var goodsIdStr = goodsId + ":" + itemNo + ":" + (pakGoodsId ? pakGoodsId : "") + ":"+(mkiGoodsYn ? mkiGoodsYn : "")+":"+(mkiGoodsOptContent ? mkiGoodsOptContent : "");

		console.log("fnAddCart = goodsIdStr : " + goodsIdStr + ", cartQty : " + cartQty + ", nowBuyYn : " + nowBuyYn);

		fnGoodsInsertCart(goodsIdStr, cartQty, nowBuyYn);
	}

	function fnGoodsInsertCart(goodsIdStr, cartQty, nowBuyYn){
		commonFunc.insertCart(goodsIdStr, cartQty, nowBuyYn, function(data){
			// FRONT_WEB_VIEW_ORDER_CART_MSG_INSERT_CART_SUCCESS
			if(nowBuyYn == 'N'){
				fnGoodsUiToast("장바구니에 상품이 담겼습니다.", "nowbuy");
				// ui.confirm("장바구니에 담았습니다. 이동하시겠습니까?",{
				// 	ycb : function(){
				// 		console.log("insertCart response");
				// 		location.href = "/order/indexCartList";
				// 	}
				// });
			}else{
				console.log("insertCart response");
				//location.reload();
			}
		});
	}

	function fnAddGoodsWish(obj, goodsId){
		var isLogin = "${session.isLogin()}";
		console.log("fnAddGoodsWish isLogin : " + isLogin);
		if(isLogin == "true"){
			var options = {
				url : "/goods/insertWish",
				data : {goodsId : goodsId, search : "", returnUrl : document.URL+"?searchQuery=" },
				done : function(data) {
					console.log("data : " + JSON.stringify(data));
					var action = '';
					if(data != null) {
						if(data.actGubun == 'add'){
							$(obj).addClass("on");
							fnGoodsUiToast("찜리스트에 추가되었어요", "wish");
							action = 'interest';
						}else if(data.actGubun == 'remove'){
							$(obj).removeClass("on");
							fnGoodsUiToast("찜리스트에서 삭제되었어요", "wished");
							action = 'interest_d';
						}
						userActionLog(goodsId, action);
					}
				}
			};
			ajax.call(options);
		}else{
			fnGoodsUiToast("로그인이 필요합니다.", "login");
		}

		// insertWishS(obj, goodsId, searchGoodsId);
	}

	// 입고 알림
	function fnAlimItems(obj){
		var isLogin = "${session.isLogin()}";
		if(isLogin == "true"){
			var options = {
				url : "/goods/addIoAlarm",
				data : {goodsId : "${goods.goodsId}", almYn : "N"},
				done : function(data) {
					// console.log("data : " + JSON.stringify(data));
					// 알림신청시 기존에 등록에 대한 처리는 없음.
					if(data.message == "add"){
						fnGoodsUiToast("재입고 알림이 신청되었어요", "add");
					}else if(data.message == "added"){
						fnGoodsUiToast("이미 재입고 알림을 신청했어요", "added");
					}
				}
			};
			ajax.call(options);
		}else{
			fnIsLogin();
		}
		// insertWishS(obj, goodsId, searchGoodsId);
	}
	function fnRegAlim(e, obj){
		e.stopPropagation();//입고알람 상위 a태그의 이벤트가 실행되어 e.stopPropagation() 실행
		var $btn = $(obj);
		var goodsId = $btn.data("goods-id") || $btn.data("content");
		var options = {
			url : "/goods/addIoAlarm",
			data : {goodsId : goodsId, almYn : "N"},
			done : function(data) {
				if(data.message == "login") {
					ui.confirm('로그인 후 서비스를 이용할 수 있어요.<br>로그인 할까요?', { // 컨펌 창 옵션들
						ycb: function () {
							document.location.href = '/indexLogin?returnUrl=' + encodeURIComponent(document.location.href);
						},
						ncb: function () {
							return false;
						},
						ybt: "로그인", // 기본값 "확인"
						nbt: "취소"  // 기본값 "취소"
					});
				}else if(data.message == "changed") {
					ui.toast("상품정보가 변경되어 입고알림을 신청할 수 없어요",{
						bot: 74, //바닥에서 띄울 간격
						sec:  3000 //사라지는 시간
					});
				}else if(data.message == "add"){
					ui.toast("재입고 알림이 신청되었어요");
				}else if(data.message == "added"){
					ui.toast("이미 재입고 알림을 신청했어요",{
						cls : "added" ,
						bot: 74, //바닥에서 띄울 간격
						sec:  3000 //사라지는 시간
					});
				}
			}
		};
		ajax.call(options);


	}

	//$(document).bind("keydown change","[id^=inputOrdmki_]",function(e){

	function fnCheckOrdmkiTextLength(obj){
		var curValue = obj.value;

		if(curValue.indexOf("|") > -1){
			curValue = curValue.substr(0, curValue.indexOf("|"));
		}

		if( 40 < curValue.length ){
			curValue = curValue.substr(0, 40);
		}

		$("#"+obj.id).val(curValue) ;
	}
	//})
	function getStkQty(){
		var start = new Date();
		$.ajax({
			type:"POST",
			url:"/goods/getStkQty",
			data: {goodsId:'${goods.goodsId}',
					   itemNo:  '${listItems.itemNo}'},
			success : function(data){
				stkQty = data.stkQty
				console.log("stkQty: " +stkQty)
				var end = new Date();
				console.log(end-start)
			}	
			})
		}
</script>

<div class="optpan" >
	<div class="inr" id="artUiPdOrdPan">

		<div class="cdtwrap">
			<!-- 묶음/옵션 상품 -->
			<jsp:include page="/WEB-INF/view/goods/includeNew/IncludeGoodsOrdpanDetailAttr.jsp" />

			<!-- 묶음/옵션 상품 Right -->
			<jsp:include page="/WEB-INF/view/goods/includeNew/IncludeGoodsOrdpanDetailAttrRight.jsp" />
		</div>

		<div class="tots">
			<div class="inr">
				<div class="amts">
					<i class="t"><spring:message code='front.web.view.goods.total.amt' /></i>
					<em class="amt"><i class="i" id="emPriceTotalCnt">
						<c:choose>
							<c:when test="${goods.goodsCstrtTpCd eq FrontConstants.GOODS_CSTRT_TP_ITEM or goods.goodsCstrtTpCd eq FrontConstants.GOODS_CSTRT_TP_SET}">
								${goods.minOrdQty}
							</c:when>
							<c:otherwise>
								0
							</c:otherwise>
						</c:choose>
					</i><i class="s"><spring:message code='front.web.view.common.goods.count.number' /></i>
					</em>
				</div>
				<div class="price">
					<i class="t"><spring:message code='front.web.view.goods.total.title' /></i>
					<em class="prc"><i class="i" id="emPriceTotalAmt"><fmt:formatNumber type="number" value="${not empty listItems ? (listItems.saleAmt * goods.minOrdQty) : 0}"/></i><i class="s"><spring:message code='front.web.view.common.moneyUnit.title' /></i></em>
				</div>
			</div>
		</div>
	</div>
</div>
