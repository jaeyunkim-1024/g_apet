/*constants*/
const GOODS_AMT_TP_30 = "30";
const BULK_ORD_END_YN_Y = "Y";
const COMP_GB_10 = "10";
const CP_POP_TP_CART = "00";
const CP_POP_TP_ORD = "10";
const CP_POP_TP_ORD_CART = "20";

/*message*/
const FRONT_WEB_VIEW_ORDER_CART_CONFIRM_DELETE = "상품을 장바구니에서 삭제할까요?";
const FRONT_WEB_VIEW_ORDER_CART_DELETE_SUCCESS = "장바구니에서 삭제되었어요";
const FRONT_WEB_VIEW_ORDER_CART_MSG_NO_SELECT = "상품을 선택해주세요";
const FRONT_WEB_VIEW_ORDER_CART_MSG_INSERT_CART_SUCCESS = "장바구니에 추가되었어요";
const FRONT_WEB_VIEW_ORDER_CART_MSG_INSERT_CART_ERROR = "이미 장바구니에 추가되었어요";

const FRONT_WEB_VIEW_ORDER_CART_MSG_SOLDOUT_NO_SELECT = "품절된 상품이 존재하지 않습니다.";
const FRONT_WEB_VIEW_ORDER_CART_QTY_UPDATE_SUCCESS = "수량이 변경되었습니다.";
const FRONT_WEB_VIEW_ORDER_CART_OPTION_UPDATE_SUCCESS = "옵션이 변경되었습니다.";
const FRONT_WEB_VIEW_ORDER_CART_MSG_WISH_NO_SELECT = "위시리스트에 담길 상품을 선택하여 주십시오.";
const FRONT_WEB_VIEW_ORDER_CART_INSERT_WISH_SUCCESS = "위시리스트에 상품이 담겼습니다.";


/********************
 * 카트 상품 컨트롤
 *******************/
var cartGoods = {
	//바로구매
	directOrder : function(cartId, goodsId, itemNo, pakGoodsId, mkiGoodsYn, mkiGoodsOptContent, isMiniCart, directGoodsNm, directGoodsOptNm ){

		var ordCartIds = new Array();
		ordCartIds.push(cartId);
		
		var selMbrCpNo = $("#untcart"+cartId).find("input[name=selMbrCpNo]").val();
		var goodsCpInfos = new Array();
		
		if(selMbrCpNo){
			goodsCpInfos.push(cartId+":"+goodsId+":"+itemNo+":"+pakGoodsId+":"+selMbrCpNo);
		}else{
			goodsCpInfos.push(cartId+":"+goodsId+":"+itemNo+":"+pakGoodsId+":"+"0");
		}
		
		if(order.valid(ordCartIds, isMiniCart, directGoodsNm, directGoodsOptNm)){
			if(order.stockValid(ordCartIds, isMiniCart)){
				
				//장바구니 - 바로구매 배송팝업 체크
				var isLocalComp = false;
				var $cart = $("#untcart"+cartId);
				if($cart.find("input[name=compGbCd]").val() == COMP_GB_10){
					isLocalComp = true;
				}
				
				var areaMsg;
				if(isLocalComp){
					areaMsg = order.validDlvrAreaInfo(null, true);
				}
				
				var buyQty = $("#buyQty"+cartId).val();
				var goodsIdStr = goodsId + ":" + itemNo + ":" + (pakGoodsId ? pakGoodsId : "") + ":"+(mkiGoodsYn ? mkiGoodsYn : "")+":"+(mkiGoodsOptContent ? mkiGoodsOptContent : "");
				
				if(areaMsg){
					ui.confirm(areaMsg, {
						ycb : function(){
							commonFunc.insertCart(goodsIdStr, buyQty, "Y", 'N', goodsCpInfos, "Y");
						},
					    ybt:"예",
					    nbt:"아니오"
					});
				}else{
					commonFunc.insertCart(goodsIdStr, buyQty, "Y", 'N', goodsCpInfos, "Y");
				}
			}
		}
	}
	//장바구니 연관상품- 장바구니 담기
	, insertCart : function(goodsId, itemNo, pakGoodsId, mkiGoodsYn, mkiGoodsOptContent, reloadYn){
		var goodsIdStr = goodsId + ":" + itemNo + ":" + (pakGoodsId ? pakGoodsId : "") + ":"+(mkiGoodsYn ? mkiGoodsYn : "")+":"+(mkiGoodsOptContent ? mkiGoodsOptContent : "");
		
		commonFunc.insertCart(goodsIdStr, 1, "N", (reloadYn == "N")?"N":"Y");
	}
	, reloadCart : function(callBack){
		var options = {
			url : "/order/incCartList"
			, dataType : "html"
			,done : function(html) {
				$("#contents").html(html);
				if(callBack){
					callBack();
				}
			}
		};
		ajax.call(options);
	}
	, openCouponPop : function(selectCartId){
		
		//상품쿠폰
		var selGoodsCouponList = new Array();
		$.each($(".untcart").not(".disabled"), function(idx, obj){
			var cartId = $(obj).find("input[name=cartIds]").val();
			var goodsCoupon = {
				cartId : cartId
				,selMbrCpNo : $(obj).find("input[name=selMbrCpNo]").val()
			}
			if(selectCartId == cartId){
				goodsCoupon.isSelected = true;
			}
			//주문서 일 경우 전체 isSelect = true
			selGoodsCouponList.push(goodsCoupon);
		});
		
		
		//장바구니 쿠폰
		var selCartCouponList = new Array();
		var coupon = {
			mbrCpNo : '1346'
		}
		
		selCartCouponList.push(coupon);
		
		//배송비 쿠폰
		var selDlvrcCoupon = {
			dlvrcPlcNo : '1'
			,mbrCpNo : '1347'
			,dlvrAmt : 2500
		}
		
		var options = {
			url : "/order/popupCouponUse"
			, dataType : "html"
			,data : {
				selGoodsCouponListStr : JSON.stringify(selGoodsCouponList)
				/*,selCartCouponListStr : JSON.stringify(selCartCouponList)
				,selDlvrcCouponStr : JSON.stringify(selDlvrcCoupon)
				,totGoodsAmt : 40000*/
				,cpPopTp : CP_POP_TP_CART
				,callBackFnc : "cartGoods.callBackCouponApply"
			}
			,done : function(html) {
				$("#popCoupon").html(html);
				ui.popLayer.open("popCoupon");
			}
		};
		ajax.call(options);
	}
	, callBackCouponApply : function(data){
		console.log('callBackData',data);
		
		ui.toast("쿠폰이 적용되었어요");
		
		var isChkTotal = false;
		var cpData = data[0];
		//상품쿠폰
		if(cpData.cpKindCd == '10'){
			var $cart = $("#untcart"+cpData.cartId);
			$cart.find("input[name=selMbrCpNo]").val(cpData.selMbrCpNo);
			$cart.find("input[name=cpDcAmt]").val(cpData.cpDcAmt);
			$cart.find("input[name=totCpDcAmt]").val(cpData.totCpDcAmt);
			
			if($cart.find("input[name=selMbrCpNo]").val()){
				$cart.find(".prcs").find("em.st").show();
			}else{
				$cart.find(".prcs").find("em.st").hide();
			}
			if($("#chkCartId"+cpData.cartId).prop('checked')){
				cartGoods.setChkTotalInfo();
			}
			var cartArr = new Array();
			var cart ={
				cartId : cpData.cartId
			}
			
			cartArr.push(cart);
			
			//중복된 상품쿠폰 제거
			$.each($(".untcart"), function(idx, cart){
				var tempCartId = $(this).find("input[name=cartIds]").val();
				if(cpData.cartId != tempCartId &&  $(this).find("input[name=selMbrCpNo]").val() == cpData.selMbrCpNo){
					$(this).find("input[name=selMbrCpNo]").val("");
					$(this).find("input[name=totCpDcAmt]").val("0");
					$(this).find("input[name=cpDcAmt]").val("0");
					$(this).find(".box .amount .prcs").find("em.st").hide();
					var temp ={
						cartId : tempCartId
					}
					cartArr.push(temp);
				}
			});
			
			$.each(cartArr, function(idx, value){
				cartGoods.changeQtyCommon(value, false);
			});
		}
		
	}
	,init : function(){
		
		var arrCart = new Array();
		
		$.each($("input[name=cartIds]:checked").not(":disabled"), function(idx, cart){
			var data = {
				cartId : $(cart).val()
				,buyQty : $("#buyQty"+$(cart).val()).val()
			}
			arrCart.push(data);
		});
		
		cartGoods.changeCheckInfo(arrCart);
		
		
		//업체 별 합계
		var compCartList = new Array();
		$.each($(".cartlist").find(".untcart").not(".disabled"), function(idx, obj){
			var temp = {
				cartId : $(obj).find("input[name=cartIds]").val()
				,buyQty : $(obj).find("input[name=buyQty]").val()
				,selMbrCpNo : $(obj).find("input[name=selMbrCpNo]").val()
			}
			
			compCartList.push(temp);
		});
		
		//업체 배송비 계산
		cartGoods.getDeliveryAmt(compCartList, function(dlvrcList){
			//각 배송비 수정
			$.each(dlvrcList, function(idx, dlvrc){
				$("#dlvrcPlcAmt"+dlvrc.dlvrcPlcNo).val(dlvrc.totalDlvrAmt);
			});
			
			cartGoods.setCompTotalInfo();
		});
		
	}	
	// 상품 삭제
	,del : function(cartId, isMiniCart){
		var arrCartIds = new Array();
		
		if(cartId){
			arrCartIds.push(cartId);
		}else{
			$.each($("input[id^=chkCartId]:checked"), function(){
				arrCartIds.push($(this).val());
			})
		}
		
		if(arrCartIds.length == 0){
			ui.toast(FRONT_WEB_VIEW_ORDER_CART_MSG_NO_SELECT);
			return;
		}
		
		ui.confirm(FRONT_WEB_VIEW_ORDER_CART_CONFIRM_DELETE, {
			ycb : function(){
				var options = {
					 url : "/order/deleteCart"
					,data : {
						cartIds : arrCartIds
					}
					,done : function(data) {
						if(isMiniCart){
							ui.toast(FRONT_WEB_VIEW_ORDER_CART_DELETE_SUCCESS, {sec:3000});
							cartGoods.reloadMiniCart();
						}else{
							ui.toast(FRONT_WEB_VIEW_ORDER_CART_DELETE_SUCCESS, {sec:3000});
							cartGoods.reloadCart();
						}
					}
				};
				ajax.call(options);
			},
			ybt:'예',
			nbt:'아니오'
		})
	}
	//Apet 배송 바 컨트롤
	, changeApetDlvrBar : function(totalGoodsAmt, $cartObj){
		
		var dlvrcBuyPrc = Number($("#apetDlvrcBuyPrc").val());
		
		//무료 배송비 40000원
		$(".abt").find(".frstat .inf .pp").hide();
		$(".abt").find(".frstat .inf .tt").hide();
		if(totalGoodsAmt == 0){
			$("#noneDlvrBar").show();
			$("#noneDlvrBar").next(".tt").show();
			$("#apetBar").css("width", "0%");
			$("#apetBar").removeClass("free");
			$(".recoms").hide();
		}else if(parseInt(totalGoodsAmt) >=  parseInt(dlvrcBuyPrc)){
			$("#fullDlvrBar").show();
			$("#apetBar").css("width", "100%");
			$("#apetBar").addClass("free");
			
			$(".recoms").hide();
		}else{
			$("#addDlvrBar").show();
			$("#addDlvrBar").next(".tt").show();
			$("#apetBar").removeClass("free");
			var diff = format.num(dlvrcBuyPrc - totalGoodsAmt);
			$("#addDlvrBar").find(".p").text(diff);
			var pnt = (totalGoodsAmt / dlvrcBuyPrc) * 100;
			$("#apetBar").css("width",  pnt +"%");
			
			//연관상품
			$(".recoms").find(".hdts .tit  em.p").text(diff);
			
			var recomes = $(".recoms").css("display");
			
			if(recomes != "block"){
				this.loadRecomeGoods($cartObj);
			}
		}
	}
	//연관상품 ajax 호출
	, loadRecomeGoods : function($cartObj){
		var cartIds = new Array();
		var exGoodsIds = new Array();
		$.each($cartObj, function(idx, cart){
			if($(cart).closest(".abt").length > 0){
				cartIds.push($(cart).find("input[name=cartIds]").val());
				exGoodsIds.push($(cart).find("input[name=goodsId]").val());
			}
		});

		var options = {
			 url : "/order/incRecomeGoods"
			 , dataType : "html"
			,data : {
				cartIds : cartIds
				, exGoodsIds : exGoodsIds
			}
			,done : function(html) {
				$(".recoms").find(".ui_cartrcm_slide").html(html);
			}
		};
		ajax.call(options);
	}
	, setTotalCnt : function(){
		var txt = "("+$("input[name=cartIds]:checked").length+"/"+$("input[name=cartIds]").not(":disabled").length+")";
		$("#chkAll").closest(".checkbox").find(".i").text(txt);
	}
	//체크 및 수량 DB 값 변경
	, updateCartBuyQtyAndCheckYn : function(arrCart, callBack){
		/*arrCart =[ {
			cartId : ''
			,buyQty : 1
			,goodsPickYn : 'Y' or 'N'
		}]
		 * */
		
		var isRemoveLoading = true;
		if(callBack){
			isRemoveLoading : false
		}
		
		var options = {
			 url : "/order/updateCartBuyQtyAndCheckYn"
			,data : {
				cartListStr : JSON.stringify(arrCart)
			}
			,isRemoveLoading : isRemoveLoading
			,done : function(data) {
				if(callBack){
					callBack(data);
				}
			}
		};
		ajax.call(options);
	}
	, setCompTotalInfo : function(pCompNo){
		var $compList;
		
		if(pCompNo){
			$compList = $("#cartList"+pCompNo);
		}else{
			$compList = $(".cartlist");   //전체 업체 합계
		}
		
		$compList.each(function(){
			var comp = $(this);
			var compNo = comp.data("compNo");
			var compTotalGoodsAmt = 0;
			var compTotalDcAmt = 0;
			var compTotalDlvrAmt = 0;
			
			comp.find(".untcart").each(function(){
				var cart = $(this);
				if(!cart.find("input[name=cartIds]").is(":disabled")){
					
					var goodsAmt = (Number(cart.find("input[name=salePrc]").val()) - Number(cart.find("input[name=prmtDcAmt]").val())) * Number(cart.find("input[name=buyQty]").val());
					var totCpDcAmt = Number(cart.find("input[name=totCpDcAmt]").val());
					
					compTotalGoodsAmt += goodsAmt;
					compTotalDcAmt += totCpDcAmt;
				}
			});
			$("input[name=dlvrcPlcAmt]").each(function(){
				var dlvrc = $(this);
				if(dlvrc.data("compNo") == compNo){
					compTotalDlvrAmt += Number($(this).val());
				}
			});
			
			var compTotalAmt = compTotalGoodsAmt - compTotalDcAmt + compTotalDlvrAmt;
			$("#compTotalGoodsAmt"+compNo).html(format.num(compTotalGoodsAmt - compTotalDcAmt));
			//$("#compTotalCpDcAmt"+compNo).html(format.num(compTotalDcAmt));
			$("#compTotalDlvrAmt"+compNo).html(format.num(compTotalDlvrAmt));
			$("#compTotalAmt"+compNo).html(format.num(compTotalAmt));
		});
		
		
	}
	//체크 상품 결제금액 계산
	, setChkTotalInfo : function(){

		var $cartIds = $("input[name=cartIds]:checked");
		//품절 제외
		var $cartObj = $cartIds.closest(".untcart").not(".disabled");	
		
		var totalGoodsAmt = 0;  //상품금액
		var totalDcAmt = 0; 	//할인금액
		var totalDlvrAmt = 0; //배송비
		var totalApetGoodsAmt = 0; //어바웃펫 상품금액
		
		var isFreeDlvr = false;
		var dlvrPlcNoSet = new Set();
		
		$cartObj.each(function(){
			var cart = $(this);
			var goodsAmt = (Number(cart.find("input[name=salePrc]").val()) - Number(cart.find("input[name=prmtDcAmt]").val())) * Number(cart.find("input[name=buyQty]").val());
			var dcAmt = Number(cart.find("input[name=totCpDcAmt]").val());
			
			totalGoodsAmt += goodsAmt;
			totalDcAmt += dcAmt;
			
			dlvrPlcNoSet.add(cart.find("input[name=dlvrcPlcNo]").val());
			
			if(cart.closest(".abt").length > 0){
				totalApetGoodsAmt += goodsAmt - dcAmt;
			}
			//무료 배송 체크
			if(cart.find("input[name=compGbCd]").val() == COMP_GB_10 && cart.find("input[name=freeDlvrYn]").val() == 'Y'){
				isFreeDlvr = true;
			}
		});
		
		dlvrPlcNoSet.forEach(function(dlvrcPlcNo){
			totalDlvrAmt += Number($("#dlvrcPlcChkAmt"+dlvrcPlcNo).val());
		});
		
		var totalChkAmt = totalGoodsAmt - totalDcAmt + totalDlvrAmt;
		$("#totalChkGoodsAmt").html(format.num(totalGoodsAmt - totalDcAmt));
		//$("#totalChkDcAmt").html("-" + format.num(totalDcAmt));
		$("#totalChkDlvrAmt").html(format.num(totalDlvrAmt));
		$("#totalChkAmt").html(format.num(totalChkAmt));


		if($("#miniCartYn").val() === "Y"){

			if($cartObj.length === 0){
				$("#totalMiniCartPayBtn").text("주문하기");
				$("#totalMiniCartPayBtn").parent("button").addClass("btn a disabled");
			}else{
				$("#totalMiniCartPayBtn").text("총 " + $cartObj.length + "개 주문하기");
				$("#totalMiniCartPayBtn").parent("button").removeClass("btn a disabled");
			}


		}else{
			if($cartObj.length == 0){
				$(".btnOrder").children().not("#orderBtnText").hide();
			}else{
				$(".btnOrder").children().not("#orderBtnText").show();
				$("#goodsOrdCntText").text($cartObj.length);
				$("#totalChkAmtText").text(format.num(totalChkAmt));
			}
		}

		
		//어바웃펫 배송바
		//무료 배송 체크
		if(isFreeDlvr){
			totalApetGoodsAmt = Number($("#apetDlvrcBuyPrc").val());
		}
		cartGoods.changeApetDlvrBar(totalApetGoodsAmt, $cartObj);
	}
	, changeCheckInfo : function(arrCart){
		/*arrCart =[ {
			cartId : '123'
			,buyQty : 1
			,goodsPickYn : 'Y' or 'N'
		}]
		 * */
		var chkDlvrcPlcNoList = new Set();
		var noChkDlvrcPlcNoList = new Array();
		$.each(arrCart, function(idx, cart){
			var dlvrcPlcNo = $("#untcart"+cart.cartId).find("input[name=dlvrcPlcNo]").val();
			chkDlvrcPlcNoList.add(dlvrcPlcNo);
		});
		
		var chkRelateCartList = new Set();
		
		chkDlvrcPlcNoList.forEach(function(dlvrcPlcNo){
			$.each($("input[name=dlvrcPlcNo]").closest(".untcart").find("input[name=cartIds]:checked").not(":disabled"), function(idx, obj){
				var $parent = $(obj).closest(".untcart");
				var cart={
					cartId : $(obj).val()
					, buyQty : $parent.find("input[name=buyQty]").val()
					, dlvrcPlcNo : $parent.find("input[name=dlvrcPlcNo]").val()
					,selMbrCpNo : $parent.find("input[name=selMbrCpNo]").val()
				}
				chkRelateCartList.add(cart);
			});
		});
		
		var relateArr = Array.from(chkRelateCartList);
		
		if(relateArr.length > 0){
			this.getDeliveryAmt(relateArr, function(dlvrcList){
				console.log('dlvrcList', dlvrcList);
				//각 체크 배송비 수정
				$.each(dlvrcList, function(idx, dlvrc){
					console.log('dlvrc', dlvrc);
					$("#dlvrcPlcChkAmt"+dlvrc.dlvrcPlcNo).val(dlvrc.totalDlvrAmt);
				});
				
				
				$.each($("input[name=dlvrcPlcChkAmt]"), function(idx, chkAmt){
					var isExist = false;
					$.each(dlvrcList, function(idx, info){
						if(info.dlvrcPlcNo == $(chkAmt).data("dlvrcPlcNo")){
							isExist = true;
						}
					})
					//선택 값에 배송비 정책번호가 없는 경우 해당 배송정책 배송비 0 처리.
					if(!isExist){
						$(chkAmt).val(0);
					}
				});
				
				//할인 금액 조회 X
				cartGoods.setChkTotalInfo();
			});
		}else{
			//없을 경우 모두 0 처리
			$.each($("input[name=dlvrcPlcChkAmt]"), function(idx, chkAmt){
				
				if($(chkAmt).data("salePsbCd") == '20' || $(chkAmt).data("salePsbCd") == '30' || $(chkAmt).data("salePsbCd") == '40') {
					$(chkAmt).val(0);
				}
				
			});
			cartGoods.setChkTotalInfo();
		}
	}
	, changeQtyCommon : function(cart, isMiniCart){
		//set 각각 cart 수량 변경 금액
		var $cart = $("#untcart"+cart.cartId);
		var goodsAmt = (Number($cart.find("input[name=salePrc]").val()) - Number($cart.find("input[name=prmtDcAmt]").val())) * Number($cart.find("input[name=buyQty]").val()) - Number($cart.find("input[name=totCpDcAmt]").val());
		
		$cart.find(".prcs").find("em.p").text(format.num(goodsAmt));
		
		//미니 장바구니가 아닌 경우 
		if(!isMiniCart){
			var compNo = $("#untcart"+cart.cartId).closest(".cartlist").data("compNo");
			
			var compCartList = new Array();
			$.each($("#untcart"+cart.cartId).closest(".cartlist").find(".untcart").not(".disabled"), function(idx, obj){
				var temp = {
					cartId : $(obj).find("input[name=cartIds]").val()
					,buyQty : $(obj).find("input[name=buyQty]").val()
					,selMbrCpNo : $(obj).find("input[name=selMbrCpNo]").val()
				}
				
				compCartList.push(temp);
			});
			
			//업체 배송비 계산
			cartGoods.getDeliveryAmt(compCartList, function(dlvrcList){
				//각 배송비 수정
				$.each(dlvrcList, function(idx, dlvrc){
					$("#dlvrcPlcAmt"+dlvrc.dlvrcPlcNo).val(dlvrc.totalDlvrAmt);
				});
				
				cartGoods.setCompTotalInfo(compNo);
			});
		}	
		
		//체크된 경우 전체 체크 배송비 계산
		var arrCart = new Array();
		arrCart.push(cart);
		if($("#chkCartId"+cart.cartId).prop('checked')){
			cartGoods.changeCheckInfo(arrCart, cartGoods.setChkTotalInfo);
		}
		
	}
	, changeQty : function(arrCart){
		
		var cart = arrCart[0];
		
		//선택한 쿠폰이 있는 경우 할인 금액 계산
		var selMbrCpNo = $("#untcart"+cart.cartId).find("input[name=selMbrCpNo]").val();
		cart.selMbrCpNo = selMbrCpNo;
		cartGoods.getCpDcAmt(arrCart, function(){
			cartGoods.changeQtyCommon(cart, false);
		});
	}
	//배송비 계산
	, getDeliveryAmt : function(cartList, callback){
		//cartInfo =[{cartId:'111', buyQty: 5, dlvrcPlcNo : '222'}, ...]
		
		if(cartList.length > 0){
			var options = {
				url : "/order/getDeliveryAmt"
				,data : {
					cartInfo : JSON.stringify(cartList)
				}
				,done : function(data) {
					console.log("getDeliveryAmt", data.dlvrcList);
					
					if(callback && data.dlvrcList.length > 0){
						callback(data.dlvrcList);
					}
				}
			};
			ajax.call(options);
		}
	}
	//쿠폰 할인 금액 계산
	, getCpDcAmt : function(arrCart, callback){
		//arrCart =[{cartId:'111', buyQty: 5, selMbrCpNo : '5'}, ...]
		var options = {
			 url : "/order/getCpDcAmt"
			,data : {
				cartInfo : JSON.stringify(arrCart)
			}
			,done : function(data) {
				console.log("getCpDcAmt", data);
				
				var cpDcList = data.cartGoodsList;
				
				//쿠폰 할인금액 받아서 set
				$.each(cpDcList, function(idx, cart){
					var cartId = cart.cartId;
					var $cart = $("#untcart"+cartId);
					
					if(cart.selMbrCpNo){
						var cpDcAmt = cart.selCpDcAmt;
						var totCpDcAmt = cart.selTotCpDcAmt;
						
						$cart.find("input[name=cpDcAmt]").val(cpDcAmt);
						$cart.find("input[name=totCpDcAmt]").val(totCpDcAmt);
						
						$cart.find(".prcs").find("em.st").show();
					}else{
						//최소 구매금액으로 쿠폰 제외됐을 경우
						var cpDcAmt = cart.selCpDcAmt;
						var totCpDcAmt = cart.selTotCpDcAmt;
						
						//0으로 고정
						$cart.find("input[name=cpDcAmt]").val(cpDcAmt);
						$cart.find("input[name=totCpDcAmt]").val(totCpDcAmt);
						$cart.find("input[name=selMbrCpNo]").val("");
						$cart.find(".prcs").find("em.st").hide();
					}
					
					//쿠폰 존재 여부 체크
					if(cart.isCpExist){
						$cart.find(".btns").find(".cpm").show();
					}else{
						$cart.find(".btns").find(".cpm").hide();
					}
				});
				
					
				if(callback){
					callback(cpDcList);
				}
			}
		};
		ajax.call(options);
	}
	//미니 장바구니 
	, setDisabledAmt : function(obj){
		var $qtyObj = $(obj).siblings(".amt");
		var maxOrdQty = $qtyObj.data("maxOrdQty") || 9999;
		var minOrdQty = $qtyObj.data("minOrdQty") || 1;
		
		var qty = $qtyObj.val();
		if(qty >= maxOrdQty){
			$qtyObj.siblings(".plus").prop("disabled", true);
		}else{
			$qtyObj.siblings(".plus").prop("disabled", false);
		}
		
		if(qty <= minOrdQty){
			$qtyObj.siblings(".minus").prop("disabled", true);
		}else{
			$qtyObj.siblings(".minus").prop("disabled", false);
		}
	}
	//미니 장바구니 
	, reloadMiniCart : function(){
		var options = {
			url : "/order/includeMiniCart"
			, dataType : "html"
			, done : function(html){
				$("#miniCart").html(html);
			}
		};

		ajax.call(options);
	}
}

/*******************
 * 카트 주문 컨트롤
 *******************/
var order = {
	valid : function(ordCartIds, isMiniCart, directGoodsNm, directGoodsOptNm){

		var isValid = true;
		
		$.each(ordCartIds, function(idx, cartId){
				//최소, 최대 구매 수량 체크
				var $obj = $("#buyQty"+cartId);
				var buyQty = $obj.val();
				var minOrdCnt = $obj.data("minOrdQty") ? $obj.data("minOrdQty") : 1;
				var maxOrdCnt = $obj.data("maxOrdQty");

				if(isMiniCart){
					var goodsNm = "'" + $obj.closest(".amount").siblings(".tops").find(".name .tit").text() + "'" +"상품<br/>";

					if(Number(buyQty) < Number(minOrdCnt)){
						ui.toast(goodsNm +" 최소 "+minOrdCnt+"개 이상 구매할 수 있어요",{ bot:80, sec:1000 });
						//$obj.closest(".amout").focus();
						isValid = false;
						return false;
					}

					if(maxOrdCnt && Number(buyQty) > Number(maxOrdCnt)){
						ui.toast(goodsNm +"최대 "+maxOrdCnt+"개까지 구매할 수 있어요",{ bot:80, sec:1000 });
						//$obj.closest(".amout").focus();
						isValid = false;
						return false;
					}
				}else{
					var goodsNm = "'" + $obj.closest(".amount").siblings(".tops").find(".name .tit").text() + "'" +"상품<br/>";

					if(Number(buyQty) < Number(minOrdCnt)){
						ui.toast(goodsNm +" 최소 "+minOrdCnt+"개 이상 구매할 수 있어요");
						$obj.closest(".amout").focus();
						isValid = false;
						return false;
					}

					if(maxOrdCnt && Number(buyQty) > Number(maxOrdCnt)){
						ui.toast(goodsNm +"최대 "+maxOrdCnt+"개까지 구매할 수 있어요");
						$obj.closest(".amout").focus();
						isValid = false;
						return false;
					}

				}


		});
		
		return isValid;
	}
	, validDlvrAreaInfo : function(postNo, isCart){
		var msg;
		var options = {
			url: "/order/getDlvrAreaInfo"
			,async : false
			,data : {
				isCart : isCart ? isCart : false,
				postNo : postNo		
			}
			,done : function(data){
				//기본 배송지 있는 경우만 체크
				//장바구니-> 주문서로 택배 param 넘기지 않음. 동일한 체크를 주문서에도 해서 새벽 및 당일 선택 못하게 함.
				
				if(data.mbrPostNo){
					var oneDayPostArea;
					var dawnPostArea;
					$.each(data.list, function(index, value) {
						
						if (value.dlvrPrcsTpCd == "20") {  // 새벽배송/당일배송
							oneDayPostArea = value;
						}else if(value.dlvrPrcsTpCd == "21"){
							dawnPostArea = value;
						}
					});
					
					if(oneDayPostArea && dawnPostArea){
						if(!oneDayPostArea.isPostArea && !dawnPostArea.isPostArea){
							msg = "새벽/당일배송이 불가능한 배송지입니다.<br/>일반택배로 배송해드릴까요?";
						}else if(!oneDayPostArea.isPostArea && dawnPostArea.isPostArea){
							//새벽배송만 가능 - 새벽배송 - 휴무일, 슬롯 체크
							if(dawnPostArea.isHoliday || dawnPostArea.isCisSlotClose){
								msg = "당일배송이 불가능한 배송지입니다.<br/>일반택배로 배송해드릴까요?";
							}
						}else if(oneDayPostArea.isPostArea && !dawnPostArea.isPostArea){
							//당일배송만 가능 - 당일배송 - 휴무일, 슬롯 체크
							if(oneDayPostArea.isHoliday || oneDayPostArea.isCisSlotClose){
								msg = "새벽배송이 불가능한 배송지입니다.<br/>일반택배로 배송해드릴까요?";
							}
						}
					}
				}
			}
		};
		ajax.call(options);
		
		return msg;
	}
	//Confirm Msg 체크
	, validConfirm : function(postNo, isCart, callback){
		
		var ordCnt = order.getOrdCnt();
		var msg = "선택하신 "+ordCnt+"개의 상품을 주문하시겠습니까?";
		var checkCart = $("input:checkbox[name=cartIds]:checked");
		
		var isLocalComp = false;
		$.each(checkCart, function(idx, cart){
			var cartId = $(this).val();
			var $cart = $("#untcart"+cartId);
			if($cart.find("input[name=compGbCd]").val() == '10'){
				isLocalComp = true;
			} 
		});
		var areaMsg;
		if(isLocalComp){
			areaMsg = order.validDlvrAreaInfo(postNo, isCart);
		}
		
		//사은품 체크 
		var goodsIdStr = new Array();
		var buyQtyStr = new Array();
		$.each(checkCart, function(idx, cart){
			var cartId = $(this).val();
			var $cart = $("#untcart"+cartId);
			goodsIdStr.push($cart.find("input[name=goodsId]").val());
			buyQtyStr.push($cart.find("input[name=buyQty]").val());
		});
		var freebieMsg = commonFunc.validFreebie(goodsIdStr, buyQtyStr, "Y");
		
		var msg1;
		var msg2;
		if((areaMsg && !freebieMsg) || (!areaMsg && freebieMsg)){
			msg1 = areaMsg || freebieMsg;
		}else if(areaMsg && freebieMsg){
			msg1 = freebieMsg;
			msg2 = areaMsg;
		}else{
			/*msg1 = msg;*/
			callback();
			return;
		}
		
		if(msg1){
			ui.confirm(msg1, {
				ycb : function(){
					if(msg2){
						ui.confirm(msg2, {
							ycb : function(){
								callback();
							},
						    ybt:"예",
						    nbt:"아니오"
						});
					}else{
						callback();
					}
				},
			    ybt:"예",
			    nbt:"아니오"
			});
		}else{
			console.log("로직 오류");
		}
	}
	, getOrdCnt :  function(){
		var checkCart = $("input:checkbox[name=cartIds]:checked");

		if (checkCart.length === 0) {
			ui.toast(FRONT_WEB_VIEW_ORDER_CART_MSG_NO_SELECT);
			return;
		}
		
		var soldOutCnt = 0;
		var ordCartIds = new Array();
		$.each(checkCart, function(idx, cart){
			if($(this).closest(".untcart").hasClass("disabled")){
				soldOutCnt++;
			}else{
				ordCartIds.push($(this).val());
			}
		});
		return  checkCart.length - soldOutCnt;
	}
	// 선택 상품 주문하기
	,select : function(isMiniCart) {
		var checkCart = $("input:checkbox[name=cartIds]:checked");

		if (checkCart.length === 0) {
			ui.toast(FRONT_WEB_VIEW_ORDER_CART_MSG_NO_SELECT);
			return;
		}
		
		var ordCartIds = new Array();
		$.each(checkCart, function(idx, cart){
			ordCartIds.push($(this).val());
		});
		
		if(this.valid(ordCartIds)){
			
			var msg = "";
			/*if(soldOutCnt > 0){
				if(ordCnt == 0){
					ui.alert("선택하신 상품중에 주문이 불가한 품절 상품이 포함되어 있습니다.");
					return;
				}else{
					msg = "선택하신 상품중에 주문이 불가한 품절 상품이 포함되어 있습니다.품절 상품을 제외한 "+ordCnt+"개의 상품을 주문하시겠습니까?";
				}
			}else{
				msg = "선택하신 "+ordCnt+"개의 상품을 주문하시겠습니까?";
			}*/
			if(order.stockValid(ordCartIds, isMiniCart)){
				order.validConfirm(null, true, function(){
					order.goOrderPayment(ordCartIds);
				});
			}
		}
			
	}
	// 주문 화면 이동
	,goOrderPayment : function(ordCartIds) {
		var goodsCpInfos = new Array();
		
		ordCartIds.forEach(function(cartId){
			var $cart = $("#untcart"+cartId);
			var selMbrCpNo = $cart.find("input[name=selMbrCpNo]").val();
			var goodsId = $cart.find("input[name=goodsId]").val();
			var itemNo = $cart.find("input[name=itemNo]").val();
			var pakGoodsId = $cart.find("input[name=pakGoodsId]").val();
			
			if(selMbrCpNo){
				goodsCpInfos.push(cartId+":"+goodsId+":"+itemNo+":"+pakGoodsId+":"+selMbrCpNo);
			}else{
				goodsCpInfos.push(cartId+":"+goodsId+":"+itemNo+":"+pakGoodsId+":"+"0");
			}
		})
		
		var options = {
			 url : "/order/setOrderInfo"
			,data : {
				cartIds : ordCartIds,
				goodsCpInfos : goodsCpInfos
			}
			,done : function(data){
			 	//바텀 시트 - 연관 상품 - 상품 상세
				var isApp = data.deviceGb == "APP" ;
				var isMo = data.deviceGb == "MO";
				var isPc = data.deviceGb == "PC";
				var $btn = $(".petTabHeader .uiTab li[class*='active']").find("button");
				
				if(document.location.href.indexOf("/tv/series/indexTvDetail") > -1){
					//App일때 영상상세에서 화면 닫고 이동해야함
					if(isApp){
						var postData = $("#cartForm").serializeJson();

						var callParam = "";
						if(sortCd != ""){
							callParam = nowVdId+"."+sortCd+"."+listGb+"."+$btn.data("id");
						}else{
							callParam = nowVdId+"."+listGb+"."+$btn.data("id");
						}
						postData.callParam = callParam;
	
						// 데이터 세팅
						toNativeData.func = "onClosePassingData";
						toNativeData.parameters = JSON.stringify(postData);
						toNativeData.callback = "fnGoIndexOrderPayment";
						// 호출
						toNative(toNativeData);
					}else{
						if(isMo){
							var replaceUrl = document.location.href+"-"+$btn.data("id");
							history.replaceState("", "", replaceUrl);
							storageHist.replaceHist(replaceUrl);
						}
							
						$("#cartForm").attr("action", "/order/indexOrderPayment");
						$("#cartForm").attr("target", "_self");
						$("#cartForm").attr("method", "post");
						$("#cartForm").submit();
					}
				}else if(document.location.href.indexOf("/tv/school/indexTvDetail") > -1){
					if(isApp || isMo){
						var replaceUrl = document.location.href+"&goodsVal="+$btn.data("id");
						history.replaceState("", "", replaceUrl);
						storageHist.replaceHist(replaceUrl);
					}
						
					$("#cartForm").attr("action", "/order/indexOrderPayment");
					$("#cartForm").attr("target", "_self");
					$("#cartForm").attr("method", "post");
					$("#cartForm").submit();
				}else if(document.location.href.indexOf("/log/indexPetLogList") > -1){
					if(isApp || isMo){
						var replaceUrl = document.location.href.split('&selIdx=')[0];
						replaceUrl = replaceUrl + "&selIdx="+$("#popconTing").data("idx")+"&page="+petLogPage+"&goodsVal=cart"
						history.replaceState("", "", replaceUrl);
						storageHist.replaceHist(replaceUrl);
					}
					
					$("#cartForm").attr("action", "/order/indexOrderPayment");
					$("#cartForm").attr("target", "_self");
					$("#cartForm").attr("method", "post");
					$("#cartForm").submit();
				}else{
					$("#cartForm").attr("action", "/order/indexOrderPayment");
					$("#cartForm").attr("target", "_self");
					$("#cartForm").attr("method", "post");
					$("#cartForm").submit();
				}
			}
		};
		ajax.call(options);
	}
	,stockValid : function(ordCartIds, isMiniCart){
		if(isMiniCart){
			isMiniCart = false;
		}
		var isStockValid = true;
		var options = {
			url : "/order/getValidGoods",
			async : false,
			data : {
				cartIds : ordCartIds
			},
			done : function(data){
				var msg = "";
				$.each(data.stockList, function(idx, cart){
					if(cart.salePsbCd == "40" ){
						msg = "구매 가능 수량을 초과한 상품으로 구매가 불가능해요";
						//새로고침 안함.
						isMiniCart = true;
					}else if(cart.salePsbCd == "20"){
						msg = "판매종료 상품은 장바구니에 추가할 수 없어요 ";
					}else if(cart.salePsbCd == "10"){
						msg = "판매중지 상품은 장바구니에 추가할 수 없어요";
					}else{
						msg = "품절 상품은 장바구니에 추가할 수 없어요";
					}
					if(msg){
						return false;
					}
				});
				
				if(msg){
					ui.toast(msg, {
						//미니 장바구니 reload X
						ccb : function(){
							if(!isMiniCart){
								location.reload();
								return;
							}
						}
					});
					isStockValid = false;
				}
			},
			fail : function(){
				isStockValid = false;
			}
			
		};
		ajax.call(options);
		
		return isStockValid;
	}
}