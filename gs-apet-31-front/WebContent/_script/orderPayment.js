/* constants */
//0원 결제
const PAY_MEANS_00 = "00";
//신용카드
const PAY_MEANS_10 = "10";
//신용카드  빌링 결제
const PAY_MEANS_11 = "11";	
//실시간 계좌 이체
const PAY_MEANS_20 = "20";	
//가상계좌
const PAY_MEANS_30 = "30";
//N pay
const PAY_MEANS_70 = "70";
//카카오페이
const PAY_MEANS_71 = "71";
//PAYCO
const PAY_MEANS_72 = "72";
//포인트
const PAY_MEANS_80 = "80";

//택배
const DLVR_PRCS_TP_10 = "10";
//당일배송
const DLVR_PRCS_TP_20 = "20";
//새벽배송
const DLVR_PRCS_TP_21 = "21";

// 배송지 변경 휴대폰 번호 유효성 체크
let btnDelChk = false;

/**
 * window onload
 * @returns
 */
$(function() {
	$(document).off("click",".ordersets .sect.deli .pd_tog_box .btTog");
	$(document).on("click",".ordersets .sect.deli .pd_tog_box .btTog",function(){
		var $box = $(this).closest(".pd_tog_box");
		if( !$box.is(".open") ) {
			$box.addClass("open");
			$(this).addClass("open");
		}
	});
	
	// 최초 로딩시 
	if ($("#order_payment_post_no_new").val()) orderDlvra.fncGetDlvrArea($("#order_payment_post_no_new").val());
	mpPnt.init();
	// 배송비 가져오기
	fncCalcDelvAmt();
	fncDefaultCoupon();

});

/**
 * 배송비 계산
 * @returns
 */
function fncCalcDelvAmt() {
	let cartInfo = new Array();
	// 파라미터 생성 (상품 list)
	$("input[name='order_payment_cart_ids']").each(function(index) {
		cartInfo.push($(this).data());
	});

	// 배송비 ajax
	$.ajax({
		type: "POST",
		url: "/order/getDeliveryAmt",
		data: {cartInfo: JSON.stringify(cartInfo)}, 
		dataType:"json",
		async: false,
		success:function(data){

			let totalDlvrAmt = 0;
			let gb10TotalDlvrAmt = 0;
			let gb20TotalDlvrAmt = 0;
			let prevCompGbCd='';
			
			$.each(data.dlvrcList, function(index, value) {
				// 배송비 합계
				if(value.compGbCd == '10') {
					gb10TotalDlvrAmt += parseInt(value.totalDlvrAmt);
					$("#gb_01_total_dlvr_amt").data(value);
				} else if(value.compGbCd == '20') {
					$("#gb_02_total_dlvr_amt").data(value);
					gb20TotalDlvrAmt += parseInt(value.totalDlvrAmt);
				}
				
			});
			$("#gb_01_total_dlvr_amt").val(gb10TotalDlvrAmt);
			$("#gb_02_total_dlvr_amt").val(gb20TotalDlvrAmt);
			$("#order_payment_total_dlvr_amt").val(gb10TotalDlvrAmt+gb20TotalDlvrAmt);

			return true;
		},
		error: function(request,status,error) {
			alert("배송비를 가져오는데 실패했습니다.");
		}
	});
}

/**
 * 디폴트 쿠폰 가져오기 (최초만 실행)
 * @returns
 */
function fncDefaultCoupon() {
	
	fncGetDefaultCoupon(function(data){
		if(data.cartCoupon) {
			// 장바구니 쿠폰
			$("#tot_cart_cp_dc_amt").val(data.cartCoupon.aplDcAmt);
			// 장바구니 쿠폰 리스트 반영
			let inputCart = $('<input type="hidden" name="couponInfo"/>');
			// 장바구니 쿠폰 data 입력
			let mbrCpNo = (data.cartCoupon.mbrCpNo) ? data.cartCoupon.mbrCpNo: ' ';
			let aplDcAmt = (data.cartCoupon.aplDcAmt) ? data.cartCoupon.aplDcAmt: ' ';
			let cpNo = (data.cartCoupon.cpNo) ? data.cartCoupon.cpNo: ' ';
			
			inputCart.data("cpKindCd", "20");
			inputCart.data("cpNo", data.cartCoupon.cpNo);
			inputCart.data("totCpDcAmt", data.cartCoupon.aplDcAmt);
			inputCart.data("selMbrCpNo", data.cartCoupon.mbrCpNo);
			inputCart.data("minBuyAmt", data.cartCoupon.minBuyAmt);
			inputCart.val("20| |"+data.cartCoupon.mbrCpNo+"|"+data.cartCoupon.aplDcAmt+"|"+data.cartCoupon.aplDcAmt+"|"+data.cartCoupon.cpNo);
			
			$("#cartCouponList").append(inputCart);
		}
		
		let selDlvrcCouponStr = {
			dlvrcPlcNo: $("#gb_01_total_dlvr_amt").data("dlvrcPlcNo"),
		};
		
		
		if($("#gb_01_total_dlvr_amt").val() != 0 && data.dlvrcCoupon) {
			// 배송비 쿠폰
			$("#tot_dlvr_cp_dc_amt").val(data.dlvrcCoupon.aplDcAmt);
			
			// 배송비 쿠폰 리스트 반영
			let inputDlvr = $('<input type="hidden" name="couponInfo"/>');
			
			// 배송비 data 입력
			let dlvrcPlcNo = (selDlvrcCouponStr.dlvrcPlcNo) ? selDlvrcCouponStr.dlvrcPlcNo: ' ';
			let mbrCpNo = (data.dlvrcCoupon.mbrCpNo) ? data.dlvrcCoupon.mbrCpNo: ' ';
			let aplDcAmt = (data.dlvrcCoupon.aplDcAmt) ? data.dlvrcCoupon.aplDcAmt: ' ';
			let cpNo = (data.dlvrcCoupon.cpNo) ? data.dlvrcCoupon.cpNo: ' ';
			
			inputDlvr.data("dlvrcPlcNo", '1');
			inputDlvr.data("cpKindCd", "30");
			inputDlvr.data("cpNo", cpNo);
			inputDlvr.data("totCpDcAmt", aplDcAmt);
			inputDlvr.data("selMbrCpNo", mbrCpNo);
			inputDlvr.val("30|"+selDlvrcCouponStr.dlvrcPlcNo+"|"+data.dlvrcCoupon.mbrCpNo+"|"+data.dlvrcCoupon.aplDcAmt+"|"+data.dlvrcCoupon.aplDcAmt+"|"+data.dlvrcCoupon.cpNo);
			
			$("#dlvrCouponList").append(inputDlvr);
			
			$("#dlvrcCouponYn").val("Y");
		}
		
		
		orderPay.showHideCouponBtn();
		
		// 재계산
		orderPay.calPayAmt();
	})
}

function fncGetDefaultCoupon(callBack){
	
	let selDlvrcCouponStr = {
		dlvrcPlcNo: $("#gb_01_total_dlvr_amt").data("dlvrcPlcNo"),
		dlvrAmt: $("#gb_01_total_dlvr_amt").val()
	};

	let totGoodsAmt = 0;
	
	//자사 상품금액
	let totLocalGoodsAmt = 0;
	
	$("input[name=order_payment_cart_ids]").each(function(){
		var cartId = $(this).val();
		var saleAmt = parseInt($(this).data("salePrc")) * parseInt($(this).data("buyQty")); 
		var totCpDcAmt = 0;
		
		if($(this).data("compGbCd") == '10'){
			$("#goodsCouponList").find("input[name=couponInfo]").each(function(){
				if($(this).data("cartId") == cartId){
					totCpDcAmt = parseInt($(this).data("totCpDcAmt"));
					return false;
				}
			})
			totLocalGoodsAmt += saleAmt - totCpDcAmt;
		}else{
			$("#goodsCouponList").find("input[name=couponInfo]").each(function(){
				if($(this).data("cartId") == cartId){
					totCpDcAmt = parseInt($(this).data("totCpDcAmt"));
					return false;
				}
			})
		}
		
		totGoodsAmt += saleAmt - totCpDcAmt;
	});
	
	// 배송비 ajax
	let param = {
		selDlvrcCouponStr : JSON.stringify(selDlvrcCouponStr),
		totGoodsAmt: totGoodsAmt,
		totLocalGoodsAmt : totLocalGoodsAmt,
		cartSelMbrCpNo : $("#cartCouponList input").length > 0 ? $("#cartCouponList input").data().selMbrCpNo : ''
	}
		
	$.ajax({
		type: "POST",
		url: "/order/getDefaultCoupon",
		data: param, 
		dataType:"json",
		success:function(data){
			if(data.cartCoupon) {
				$("#cartCouponYn").val("Y");
			}else{
				$("#cartCouponYn").val("N");
			}
			
			if(callBack){
				callBack(data);
			}
		},
		error: function(request,status,error) {
			alert("배송비를 가져오는데 실패했습니다.");
			
		}
	});
}






/**
 * 배송지 선택시만 상품이 보이도록 처리
 * @returns
 */
function goodsInfoClick(){
	
	var objVal = $(this).val();
	
	var exData = $("input[name=rdb_deli_a]").filter(function(){
		return $(this).val() != objVal;
	}).closest("li");
	
	exData.find(".pd_tog_box").removeClass("open").hide();
	exData.find(".pd_tog_box .btTog").removeClass("open");
	
	$(this).parents("li").find(".pd_tog_box").show();
	
	if($(this).parents("li").find(".lst li").length == 1) {
		$(this).parents("li").find(".pd_tog_box").addClass("open");
	}
	
	//새벽/당일 가상계좌 체크
	orderPay.checkDlvrPrcsTpCdAndPay();
}

/**
 * 상품/배송비 쿠폰 팝업
 * cpPopTp: 10
 * - 쿠폰이 자사 제품만 관련있는 것?
 * 
 */
function openGoodsCouponPop () {
	// 배송비 쿠폰 변수
	let selDlvrcCouponStr;
	let dlvrData = $("#dlvrCouponList input").data();

	var localDlvrcPlcNo;
	$("input[name=order_payment_cart_ids]").each(function(){
		if($(this).data("compGbCd") == '10'){
			localDlvrcPlcNo = $(this).data("dlvrcPlcNo");
			return false;
		}
	});
	
	// 자사 배송비 정책 없을 경우 제외
	if(localDlvrcPlcNo){
		selDlvrcCouponStr = {
			dlvrcPlcNo: localDlvrcPlcNo,
			dlvrAmt: $("#gb_01_total_dlvr_amt").val(),
			mbrCpNo: dlvrData ? dlvrData.selMbrCpNo : '' 
		};
	}
		

	// 상품쿠폰변수 (20210611 상품쿠폰이 없을 경우, cartId 넘기도록 수정)
	let selGoodsCouponListStr = new Array();
	
	$("input[name=order_payment_cart_ids]").each(function(){
		var json;
		var cartId = $(this).val();
		var cartCpInfo = $("#goodsCouponList input").filter(function(){
			return $(this).data("cartId") == cartId;
		});
		if(cartCpInfo.length > 0 ){
			json = {
				cartId : cartId ,
				selMbrCpNo : cartCpInfo.data("selMbrCpNo"),
				isSelected: true	
			}
		} else {
			json = {
				cartId : cartId ,
				selMbrCpNo : '',
				isSelected: true
			}
		}
		selGoodsCouponListStr.push(json);
	});
	
	// ajax -> 쿠폰팝업 띄우기
	ajax.call({
		url : "/order/popupCouponUse",
		dataType : "html",
		data : {
			selGoodsCouponListStr: JSON.stringify(selGoodsCouponListStr),
			selDlvrcCouponStr : JSON.stringify(selDlvrcCouponStr),
			cpPopTp : '10',
			callBackFnc : "callBackGoodsCouponApply",
		},
		done : function(html) {
			$("#popCoupon").html(html);
			ui.popLayer.open("popCoupon");
		}
	});
}

/**
 * 상품쿠폰 후처리
 * @param data
 * @returns
 */
function callBackGoodsCouponApply(data) {
	// 쿠폰영역 비워두기
	$("#goodsCouponList").empty();
	$("#dlvrCouponList").empty();
	
	let dlvrSumAmt = 0;
	let goodsSumAmt = 0;

	// 리턴 결과 
	$.each(data, function(index, value) {
		if(value.cpKindCd == "10") { // 상품쿠폰일 경우
			goodsSumAmt += parseInt(value.totCpDcAmt);
			// 쿠폰 리스트 반영
			let inputGoods = $('<input type="hidden" name="couponInfo"/>');

			// 쿠폰 data 입력
			inputGoods.data(value);
			// value에 값 반영
			let cpKindCd = (value.cpKindCd) ? value.cpKindCd: ' ';
			let cartId = (value.cartId) ? value.cartId: ' ';
			let selMbrCpNo = (value.selMbrCpNo) ? value.selMbrCpNo : ' ';
			let cpDcAmt = (value.cpDcAmt) ? value.cpDcAmt : ' ';
			let totCpDcAmt = (value.totCpDcAmt) ? value.totCpDcAmt : ' ';
			let cpNo = (value.cpNo) ? value.cpNo : ' ';
			inputGoods.val(cpKindCd+"|"+cartId+"|"+selMbrCpNo+"|"+cpDcAmt+"|"+totCpDcAmt+"|"+cpNo);
			$("#goodsCouponList").append(inputGoods);
			
			//상품 선택 쿠폰 번호
			$("input[name=order_payment_cart_ids][value="+value.cartId+"]").data("selMbrCpNo", value.selMbrCpNo);

		} else { // 배송비 쿠폰일 경우
			dlvrSumAmt += parseInt(value.totCpDcAmt);
			// 쿠폰 리스트 반영
			let inputDlvr = $('<input type="hidden" name="couponInfo"/>');

			// 쿠폰 data 입력
			inputDlvr.data(value);
			let cpKindCd = (value.cpKindCd) ? value.cpKindCd: ' ';
			let dlvrcPlcNo = (value.dlvrcPlcNo) ? value.dlvrcPlcNo: ' ';
			let selMbrCpNo = (value.selMbrCpNo) ? value.selMbrCpNo : ' ';
			let cpDcAmt = (value.cpDcAmt) ? value.cpDcAmt : ' ';
			let totCpDcAmt = (value.totCpDcAmt) ? value.totCpDcAmt : ' ';
			let cpNo = (value.cpNo) ? value.cpNo : ' ';
			inputDlvr.val(cpKindCd+"|"+dlvrcPlcNo+"|"+selMbrCpNo+"|"+cpDcAmt+"|"+totCpDcAmt+"|"+cpNo);
			$("#dlvrCouponList").append(inputDlvr);
		}
	});
	
	//배송비 계산
	fncCalcDelvAmt();
	
	var cartSelMbrCpNo = $("#cartCouponList input").length > 0 ? $("#cartCouponList input").data().selMbrCpNo : '';
	//최소 구매금액에 따른 장바구니 쿠폰 변경 버튼 show hide, 장바구니 쿠폰 금액 재계산
	fncGetDefaultCoupon(function(data){
		if(data.cartCoupon) {
			
			$("#cartCouponBtn").show();
			
			if(data.cartCoupon.mbrCpNo == cartSelMbrCpNo){
				// 장바구니 쿠폰
				$("#cartCouponList").empty();
				$("#tot_cart_cp_dc_amt").val(data.cartCoupon.aplDcAmt);
				// 장바구니 쿠폰 리스트 반영
				let inputCart = $('<input type="hidden" name="couponInfo"/>');
				// 장바구니 쿠폰 data 입력
				let mbrCpNo = (data.cartCoupon.mbrCpNo) ? data.cartCoupon.mbrCpNo: ' ';
				let aplDcAmt = (data.cartCoupon.aplDcAmt) ? data.cartCoupon.aplDcAmt: ' ';
				let cpNo = (data.cartCoupon.cpNo) ? data.cartCoupon.cpNo: ' ';
				
				inputCart.data("cpKindCd", "20");
				inputCart.data("cpNo", data.cartCoupon.cpNo);
				inputCart.data("totCpDcAmt", data.cartCoupon.aplDcAmt);
				inputCart.data("selMbrCpNo", data.cartCoupon.mbrCpNo);
				inputCart.data("minBuyAmt", data.cartCoupon.minBuyAmt);
				inputCart.val("20| |"+data.cartCoupon.mbrCpNo+"|"+data.cartCoupon.aplDcAmt+"|"+data.cartCoupon.aplDcAmt+"|"+data.cartCoupon.cpNo);
				
				$("#cartCouponList").append(inputCart);
			}
		}
		
		
		if($("#gb_01_total_dlvr_amt").val() == 0) {
			$("#dlvrCouponList").empty();
			$("#dlvrcCouponYn").val("N");
		}else{
			if(data.dlvrcCoupon){
				$("#dlvrcCouponYn").val("Y");
			}else{
				$("#dlvrCouponList").empty();
				$("#dlvrcCouponYn").val("N");
			}
		}
		
		//기존 장바구니 할인 최소 구매금액으로 제외
		if($("#cartCouponList input").length > 0){
			var totGoodsAmt = 0; 
			//장바구니 쿠폰 최소 구매 금액 체크
			$("input[name=order_payment_cart_ids]").each(function(){
				var cartId = $(this).val();
				var saleAmt = parseInt($(this).data("salePrc")) * parseInt($(this).data("buyQty")); 
				var totCpDcAmt = 0;
		
				$("#goodsCouponList").find("input[name=couponInfo]").each(function(){
					if($(this).data("cartId") == cartId){
						totCpDcAmt = parseInt($(this).data("totCpDcAmt"));
						return false;
					}
				})
		
				totGoodsAmt += saleAmt - totCpDcAmt;
			});
			
			let cartData = $("#cartCouponList input").data();
			
			if(cartData && totGoodsAmt < parseInt(cartData.minBuyAmt)){
				$("#tot_cart_cp_dc_amt").val(0);
				$("#cartCouponList").empty();
			}
		}
		
		orderPay.showHideCouponBtn();
		
		// 값 반영
		$("#tot_goods_cp_dc_amt").val(goodsSumAmt);
		$("#tot_dlvr_cp_dc_amt").val(dlvrSumAmt);

		
		orderPay.calPayAmt();
		
		//포인트 입력한 경우 사용가능한 금액 달라질 수 있음.
		if($("#useGsPoint").val() && $("#useGsPoint").val() > 0){
			useAllGsPoint('N', $("#useGsPoint").val());
		}
		
		if($("#useMpPoint").val() && $("#useMpPoint").val() > 0){
			mpPnt.changeMpPoint('N', $("#useMpPoint").val());
		}
		
	});
}

/**
 * 장바구니 쿠폰 팝업
 * cpPopTp: 20
 */
function openCartCouponPop () {
	let cartData = $("#cartCouponList input").data();
	
	let selCartCouponListStr = [{
		mbrCpNo: cartData ? cartData.selMbrCpNo : '',
		isSelected: true
		}
	]; // 선택된 쿠폰으로 교체
	
	let totGoodsAmt = 0;
	
	//상품금액
	$("input[name=order_payment_cart_ids]").each(function(){
		var cartId = $(this).val();
		var saleAmt = parseInt($(this).data("salePrc")) * parseInt($(this).data("buyQty")); 
		var totCpDcAmt = 0;
		$("#goodsCouponList").find("input[name=couponInfo]").each(function(){
			if($(this).data("cartId") == cartId){
				totCpDcAmt = parseInt($(this).data("totCpDcAmt"));
				return false;
			}
		})
		
		totGoodsAmt += saleAmt - totCpDcAmt;
	});
	
	ajax.call({
		url : "/order/popupCouponUse",
		dataType : "html",
		data : {
			selCartCouponListStr : JSON.stringify(selCartCouponListStr),
			cpPopTp : '20',
			totGoodsAmt: totGoodsAmt,
			callBackFnc : "callBackCartCouponApply",
		},
		done : function(html) {
			$("#popCoupon").html(html);
			ui.popLayer.open("popCoupon");
		}
	});

}

/**
 * 장바구니 쿠폰 후처리
 * @param data
 * @returns
 */
function callBackCartCouponApply(data) {
	let cartSumAmt = 0;

	// 장바구니 쿠폰영역 비워두기
	$("#cartCouponList").empty();
	// 리턴 결과 
	$.each(data, function(index, value) {
		// 쿠폰 할인가 계산
		cartSumAmt += parseInt(value.totCpDcAmt);

		// 쿠폰 리스트 반영
		let input = $('<input type="hidden" name="couponInfo"/>');

		// 쿠폰 data 입력
		input.data(value);
		let cpKindCd = (value.cpKindCd) ? value.cpKindCd: ' ';
		let cartId = (value.cartId) ? value.cartId: ' ';
		let selMbrCpNo = (value.selMbrCpNo) ? value.selMbrCpNo : ' ';
		let cpDcAmt = (value.cpDcAmt) ? value.cpDcAmt : ' ';
		let totCpDcAmt = (value.totCpDcAmt) ? value.totCpDcAmt : ' ';
		let cpNo = (value.cpNo) ? value.cpNo : ' ';
		input.val(cpKindCd+"| |"+selMbrCpNo+"|"+cpDcAmt+"|"+totCpDcAmt+"|"+cpNo);

		$("#cartCouponList").append(input);

	})
	
	// 값 반영
	$("#tot_cart_cp_dc_amt").val(cartSumAmt);

	// 재계산
	orderPay.calPayAmt();
	
	//포인트 입력한 경우 사용가능한 금액 달라질 수 있음.
	if($("#useGsPoint").val() && $("#useGsPoint").val() > 0){
		useAllGsPoint('N', $("#useGsPoint").val());
	}
	
	if($("#useMpPoint").val() && $("#useMpPoint").val() > 0){
		mpPnt.changeMpPoint('N', $("#useMpPoint").val());
	}
}

//적립 대상금액 조회
function calSaveTgAmt(){
	let arrCart = $("input[name=order_payment_cart_ids]");
	
	let goodsCpArr = $("input[name=couponInfo]");
	
	let useGsPoint = parseInt($("#useGsPoint").val());	
	let useMpPoint = $("#useMpPoint").val() ? parseInt($("#useMpPoint").val()) : 0;
	let addUseMpPoint = $("#addUseMpPoint").val() ? parseInt($("#addUseMpPoint").val()) : 0;
	var totalGoodsPayAmt = 0;
	var chkTotalAmt;
	
	var cartArr = new Array();
	$.each(arrCart, function(idx, obj){
		var cartData = $(obj).data();
		var cpDcAmt = 0;
		var cpDc;
		if(goodsCpArr.length > 0){
			cpDc = goodsCpArr.filter(function(){
				return $(this).data().cartId == cartData.cartId;
			});
		}
		if(cpDc && cpDc.length > 0){
			cpDcAmt = parseInt(cpDc.data().cpDcAmt);
		}
		
		var cart = {
			payAmt : cartData.salePrc - cpDcAmt
			, ordQty : cartData.buyQty
			, salePrc : cartData.salePrc
			, cpDcAmt : cpDcAmt
		}
		cartArr.push(cart);
		
		totalGoodsPayAmt += (cartData.salePrc - cpDcAmt) * cartData.buyQty;
	});
	
	var cartTotalDcAmt = parseInt($("#tot_cart_cp_dc_amt").val());
	var rmnTotalDcAmt = cartTotalDcAmt;
	
	//포인트 적용 기준 금액 : 전체 상품금액 - 상품, 장바구니 쿠폰 할인금액 - 사용 GS포인트, 사용 MP 포인트;
	chkTotalAmt = totalGoodsPayAmt - cartTotalDcAmt - useGsPoint - useMpPoint - addUseMpPoint;
	
	if(chkTotalAmt <= 0){
		return 0;
	}else{
		return chkTotalAmt;
	}
}


/**
 * GS 적립 예정 금액 계산 
 * @returns savePoint
 */
function calSaveGsPoint(){
	let arrCart = $("input[name=order_payment_cart_ids]");
	let goodsCpArr = $("input[name=couponInfo]");

	var savePoint = 0;
	
	var chkTotalAmt = calSaveTgAmt();
	var cpDcAmt;
	var cpUnitAmt;
	var totalGoodsPayAmt = 0;
	var cartArr = new Array();
	$.each(arrCart, function(idx, obj){
		var cartData = $(obj).data();
		var cpDcAmt = 0;
		var cpDc;
		if(goodsCpArr.length > 0){
			cpDc = goodsCpArr.filter(function(){
				return $(this).data().cartId == cartData.cartId;
			});
		}
		if(cpDc && cpDc.length > 0){
			cpDcAmt = parseInt(cpDc.data().cpDcAmt);
		}
		
		var cart = {
			payAmt : cartData.salePrc - cpDcAmt
			, ordQty : cartData.buyQty
			, salePrc : cartData.salePrc
			, cpDcAmt : cpDcAmt
		}
		cartArr.push(cart);
		
		totalGoodsPayAmt += (cartData.salePrc - cpDcAmt) * cartData.buyQty;
	});
	
	var cartTotalDcAmt = parseInt($("#tot_cart_cp_dc_amt").val());
	var rmnTotalDcAmt = cartTotalDcAmt;
	
	var totalPayGoodsAmt2 = 0;
	$.each(cartArr, function(idx, cart){
		var orderDetailPayAmt = cart.payAmt * cart.ordQty;
		
		if(idx == cartArr.length -1){
			cpDcAmt = rmnTotalDcAmt;
		}else{
			cpDcAmt = parseInt(cartTotalDcAmt * Math.round((orderDetailPayAmt / totalGoodsPayAmt) * 1000) / 1000);
		}
		cpUnitAmt = cpDcAmt / cart.ordQty;
		cpUnitAmt = Math.floor(cpUnitAmt / 10) * 10;
		
		cpDcAmt = cpUnitAmt * cart.ordQty;
		
		rmnTotalDcAmt = rmnTotalDcAmt - cpDcAmt;
		
		cart.payAmt = cart.payAmt - cpUnitAmt;
		cart.cartCpDcAmt = cpUnitAmt;
		
		totalPayGoodsAmt2 += cart.payAmt * cart.ordQty;
	});
	
	$.each(cartArr, function(idx, cart){
		var cartTotal = cart.payAmt * cart.ordQty;
		//포인트 기준금액 * (비율(총금액 대비 각 상품금액)) * 0.1%
		var gsPntRate = $("#gsPntRate").val() ? parseFloat($("#gsPntRate").val()) : 0;
		if(totalPayGoodsAmt2 == 0){
			savePoint = 0;
		}else{
			savePoint += Math.ceil(chkTotalAmt * cartTotal / totalPayGoodsAmt2 * gsPntRate);
		}
	});
	
	
	return savePoint;
}

//View Controll
var orderView = {
	//포인트 노출 변경
	changePntView : function(){
		//본인인증 여부
		var memberYn = $("#memberYn").val();
		
		//MP 카드 번호
		var mpCardNo = $("#mpCardNo").val();
		
		if(memberYn == 'N'){
			$("#useGsPointDiv").hide();
			$("#getGsPointDiv").show();
			
			$(".gdpnt").not(".onlywooju").hide();
			$(".gdpnt.onlywooju").show();
		}else{
			$("#getGsPointDiv").find('.ptt').hide();
			
			if(mpCardNo){
				$(".gdpnt").not(".member").hide();
				$(".gdpnt.member").show();
			}else{
				$(".gdpnt").not(".onlygs").hide();
				$(".gdpnt.onlygs").show();
			}
		}
	}
	, showSavePnt : function(){
		// 적립 예정 포인트
		let gsSavePnt = calSaveGsPoint();    
		let mpRtn = mpPnt.calSavePnt();
		
		
		$(".saveGsPnt").html(format.num(gsSavePnt) + "P");
		
		if($(".cpset.wooju").length > 0){
			if(mpPnt.data.mpMaxSavePnt && (mpRtn.addSavePnt + mpRtn.dtfSavePnt) >= mpPnt.data.mpMaxSavePnt * 1){
				$(".gdpnt").find(".max").show();
			}else{
				$(".gdpnt").find(".max").hide();
			}
			
			$(".saveMpPnt").html(format.num(mpRtn.dtfSavePnt) + "C");
			
			if(mpRtn.addSavePnt != 0){
				$(".saveMpPntLi").addClass("wj_addp");
				$(".saveMpDiv").hide();
				$(".addSaveMpDiv").show();
				$(".addSaveMpDiv").find(".addSaveMpPnt").html(format.num(mpRtn.addSavePnt) + "C" );
			}else{
				$(".saveMpPntLi").removeClass("wj_addp");
				$(".saveMpDiv").show();
				$(".addSaveMpDiv").hide();
			}
		}
	}
}

/*
 * 주문 결제
 */
var orderPay = {
	//결제 하기 버튼 클릭
	excute : function(){
		if(!orderPay.valid()){
			simpChk = false;
			return false;
		}
		
		// 금액 최종 계산
		orderPay.calPayAmt(true);
		
		//최소 구매금액 체크
		if(!orderPay.minPayAmtValid()){
			simpChk = false;
			return false;
		}
		
		//이미 주문했는지 체크
		if(!orderPay.validLiveCart()){
			simpChk = false;
			return false;
		}
		
		
		//재고 체크
		if(!orderPay.stockValid()){
			simpChk = false;
			return false;
		}
		
		//새벽/당일 배송 valid
		let dlvrPrcsTpCd = $("#dlvrArea input[name='rdb_deli_a']:checked");
		if(dlvrPrcsTpCd.val() == DLVR_PRCS_TP_20 || dlvrPrcsTpCd.val() == DLVR_PRCS_TP_21){
			if(!orderPay.validDlvr()){
				simpChk = false;
				return false;
			}
		}
		
		//사은품 체크
		var goodsIdArr = new Array();
		var buyQtyArr = new Array();
		var freebieMsg = false;
		
		if($("[data-isfreebie]").length > 0){
			
			$("[data-isfreebie]").each(function(index, cart){
				var data = $(cart).data();
				goodsIdArr.push(data.goodsId);
				buyQtyArr.push(data.buyQty);
			});
			
			freebieMsg = commonFunc.validFreebie(goodsIdArr, buyQtyArr, "Y");
		}
		
		if(freebieMsg){
			ui.confirm(freebieMsg, {
				ycb : function(){
					orderPay.excuteAfter();
				}
			});
		}else{
			orderPay.excuteAfter();
		}
	}
	, excuteAfter : function(){
		let orderPayMethod = $("#payMeansCd").val();
		if(orderPayMethod === PAY_MEANS_11){
			confirmBillPassword();
		} else {
			// 주문번호 채번
			orderPay.insertOrder();
		}
	}
	, insertOrder : function(){
		var options = {
			url : "/order/insertOrderTemp",
			data : $("#order_payment_form").serialize(),
			done : function(data){
				$("#order_payment_ord_no").val(data.ordNo);
				$("#moid").val(data.ordNo);
				simpChk = false;
				nicePay.ready();
			}
		};
		ajax.call(options);
	}
	//View Valid
	, valid : function(){
		/**
		 * 성능테스트 후 삭제
		 */
		if($("input[name='rd_bill_set']:checked").val()=="PPP") {
			// 값 강제로 만들기
			$("#paycoLi button").trigger("click");
			if($("#chkAllTerms").is(":checked") === false){
				//$("#paycoLi button").trigger("click"); 인한 약관체크해제 및 나이스 약관으로 변경됨
				
				useBaseTerm();
				////강제 선택
				$("#chkAllTerms").trigger("click");
			}
		}
		
		//배송지 valid
		if(!orderDlvra.valid()){
			return false;
		}
		
		//0원 결제시 체크 제외
		if($(".sect.binf").css("display") != "none"){
			// 결제수단 선택 여부
			var chkRdo = $("input[name=rd_bill_set]:checked");
			if(chkRdo.length == 0){

				ui.alert('결제수단을 선택해 주세요.',{
					ybt:'확인'
				});
				return false;
			}
			
			var selPayMeans = $(".biltab").find("li.active").find("button");
			//일반결제
			if(chkRdo.is("#commonPay")){
				if(selPayMeans.length == 0){
					ui.alert('결제수단을 선택해 주세요.',{
						ybt:'확인'
					});
					return false;
				}
				
				var selPayMeansCd = selPayMeans.val();
				if(selPayMeansCd == PAY_MEANS_10){
					if(!$("#order_payment_cardc").val()){
						ui.alert('카드사를 선택해 주세요.',{
							ybt:'확인'
						});
						return false;
					}
				}
				
				if(selPayMeansCd === PAY_MEANS_30){
					//가상계좌 만료일시 설정
					// 가상계좌 결제수단 바꿀시에 만료날짜를 넣어주면 안됨 결제수단이 기본선택되어있을 경우 문제발생함
					var expDate = new Date();
					expDate.setHours(expDate.getHours()+3);
				
					$("#vBankExpDate").val(expDate.dateFormat("yyyyMMddHHmm"));
					
					// 현금영수증 관련 항목 확인 후 가상계좌 validation 체크
				}
			}
			
			if(chkRdo.is("#easyCardPay")){
				let billNo = $("#prsnCardBillNo").val();
				if(!billNo){
					ui.alert('결제카드를 선택해 주세요.',{
						ybt:'확인'
					});
					return false;
				}
			}
		}
		
		
		// 약관 동의 여부
		if($('input[name="chkAllTerms"]').is(":checked") === false) {
			ui.alert('이용약관에 동의해주세요',{
				ycb:function(){
					$("#goodsRcvPstEtc").focus();
				},
				ybt:'확인'
			});
			return false;
		}
		
		return true;
	}
	//배송예정일 체크
	, validDlvr : function(){
		let dlvrPrcsTpCd = $("#dlvrArea input[name='rdb_deli_a']:checked");
		var isValid = true;
		var options = {
			url : "/order/validOrderDlvr"
			, async : false
			, data : {
				ordDt : dlvrPrcsTpCd.data("ordDt")
				, dlvrPrcsTpCd : dlvrPrcsTpCd.val()
				, postNo : $("#order_payment_post_no_new").val()
			}
			, done : function(data){
				if(data.valid.exCode){
					ui.alert(data.valid.exMsg, {
						ycb:function(){
						if(data.valid.exCode == 'ORD0100'){
								orderDlvra.fncGetDlvrArea($("#order_payment_post_no_new").val())
								$(".deli")[0].scrollIntoView();
							}
						},
					});
					
					isValid = false;
				}
			}
		};
		ajax.call(options);
		
		return isValid;
	}
	, validLiveCart : function(){
		var isLiveValid = true;
		var ordCartIds = new Array();
		$("input[name=order_payment_cart_ids]").each(function(index, cart){
			ordCartIds.push($(cart).val());
		});
		
		var options = {
			url : "/order/validLiveCart"
			,data : {
				cartIds : ordCartIds
			}
			, async : false
			, done : function(data){
				if(!data.isLive){
					ui.alert("이미 주문완료 되었습니다. 다시 확인해주시기 바랍니다.");
					isLiveValid = false;
				}
			}
		}
		ajax.call(options);
		
		return isLiveValid;
	}
	//재고 체크
	,stockValid : function(){
		var ordCartIds = new Array();
		$("input[name=order_payment_cart_ids]").each(function(index, cart){
			ordCartIds.push($(cart).val());
		});
		
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
						msg = "구매 가능 수량을 초과한 상품으로 구매가 불가능한 상품이 있습니다.";
					}else if(cart.salePsbCd == "20"){
						msg = "판매종료된 상품으로 구매가 불가능한 상품이 있습니다.";
					}else if(cart.salePsbCd == "10"){
						msg = "판매중지된 상품으로 구매가 불가능한 상품이 있습니다.";
					}else{
						msg = "품절된 상품으로 구매가 불가능한 상품이 있습니다.";
					}
					if(msg){
						return false;
					}
				});
				
				if(msg){
					ui.alert(msg, {
						ycb : function(){
							location.reload();
							return false;
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
	,minPayAmtValid : function(){
		var minPayAmtValid = true;
		
		//결제 수단
		let payMeansCd = $("#payMeansCd").val();
		//결제 금액
		let payTotalAmt = parseInt($("#order_payment_total_pay_amt").val());
		var minBuyAmt;
		var msg;
		
		//신용카드 - 100원
		if(payMeansCd == PAY_MEANS_10
			|| payMeansCd == PAY_MEANS_11
			|| payMeansCd == PAY_MEANS_70
			|| payMeansCd == PAY_MEANS_71
			|| payMeansCd == PAY_MEANS_72){
			minBuyAmt = 100;
			msg = "신용카드 최소 결제금액은 100원입니다.";
		}else if(payMeansCd == PAY_MEANS_20){
			//계좌이체 - 200원
			minBuyAmt = 200;
			msg = "계좌이체 최소 결제금액은 200원입니다. ";
		}
		//가상계좌는 최소 1원이기 때문에 체크 제외
		
		if(minBuyAmt && payTotalAmt > 0){
			if(payTotalAmt < minBuyAmt){
				ui.alert(msg);
				minPayAmtValid = false;
			}
		}
		
		return minPayAmtValid;
	}
	//결제 금액 계산
	, calPayAmt : function(isPayBtn){
		//최종결제금액 계산
		let goodsTotalAmt = parseInt($("#order_payment_total_goods_amt").val());	//상품금액
		let dlvrTotalAmt = parseInt($("#order_payment_total_dlvr_amt").val());		//배송비
		let useGsPoint = parseInt($("#useGsPoint").val());		//GS포인트 사용금액
		let useMpPoint = $("#useMpPoint").val() ? parseInt($("#useMpPoint").val()) : 0;
		let addUseMpPoint = $("#addUseMpPoint").val() ? parseInt($("#addUseMpPoint").val()) : 0;
		let dcTotalAmt = 0;    //할인금액(쿠폰)
		let goodsDcAmt = 0;    //상품할인금액(?)

		// 상품/배송비 쿠폰
		let totGoodsdlvrCpDcAmt = parseInt($("#tot_goods_cp_dc_amt").val()) + parseInt($("#tot_dlvr_cp_dc_amt").val());

		// 장바구니 쿠폰
		let totCartCpDcAmt = parseInt($("#tot_cart_cp_dc_amt").val());

		// 총 할인금액
		dcTotalAmt = totGoodsdlvrCpDcAmt + totCartCpDcAmt;
		//goodsDcAmt = parseInt($("#order_payment_dc_goods_amt").val());

		let payTotalAmt = goodsTotalAmt + dlvrTotalAmt - dcTotalAmt - useGsPoint - useMpPoint - addUseMpPoint;
		

		$("#tot_goodsdlvr_cp_dc_amt_view").text(format.num(totGoodsdlvrCpDcAmt > 0 ? -1*totGoodsdlvrCpDcAmt: 0)); // 상품/배송비 쿠폰
		$("#tot_cart_cp_dc_amt_view").text(format.num(totCartCpDcAmt > 0 ? -1*totCartCpDcAmt:0)); // 장바구니 쿠폰

		$("#order_payment_total_dlvr_amt_view").text(format.num(dlvrTotalAmt)); // 배송비

		$("#order_payment_total_dc_amt").val(totGoodsdlvrCpDcAmt+totCartCpDcAmt);// 총 쿠폰할인
		$("#order_payment_total_dc_amt_view").text(format.num((totGoodsdlvrCpDcAmt+totCartCpDcAmt) > 0 ? -1*(totGoodsdlvrCpDcAmt+totCartCpDcAmt):0)); // 총 쿠폰할인

		//결제가능 포인트 금액
		$("#order_payment_total_pay_amt_ex_gs_point").val(goodsTotalAmt + dlvrTotalAmt - dcTotalAmt - useMpPoint - addUseMpPoint);
		$("#order_payment_total_pay_amt_ex_mp_point").val(goodsTotalAmt + dlvrTotalAmt - dcTotalAmt - useGsPoint);
		
		$("#order_payment_total_pay_amt_view").html(format.num(payTotalAmt));
		$("#order_payment_total_pay_amt").val(payTotalAmt);
		$("#order_payment_end_pay_amt_view").html(format.num(payTotalAmt));
		$("#order_payment_gs_point_view").html(format.num(useGsPoint > 0 ? -1*useGsPoint: 0));
		$("#order_payment_mp_point_view").html(format.num(useMpPoint > 0 ? -1*useMpPoint: 0));
		$("#order_payment_mp_add_point_view").html(format.num(addUseMpPoint > 0 ? -1*addUseMpPoint: 0));
		
		
		//포인트 사용 영역
		
		// 포인트 할인 영역 숨기기
		if(useGsPoint === 0){
			$("#gsDcLi").hide();
		}else if(useGsPoint > 0){
			$("#gsDcLi").show();
		}
		
		if(useMpPoint === 0){
			$("#mpDcLi").hide();
		}else if(useMpPoint > 0){
			$("#mpDcLi").show();
		}
		
		if(addUseMpPoint === 0){
			$("#mpAddDcLi").hide();
		}else if(addUseMpPoint > 0){
			$("#mpAddDcLi").show();
		}
		
		//적립포인트 노출
		orderView.showSavePnt();
		
		let couponDcLiAmt = parseInt($("#order_payment_total_dc_amt").val());

		// 쿠폰 할인 영역 숨기기
		if(couponDcLiAmt === 0){
			$("#couponDcLi").hide();
		}else if(couponDcLiAmt > 0){
			$("#couponDcLi").show();
		}

		//결제수단 set
		orderPay.setPayMeans(payTotalAmt, isPayBtn);

		orderPay.setParam();
	}
	, setPayMeans : function(payTotalAmt, isPayBtn){
		/*let payMeansCdCard = $("#payMeansCd").val();

		if(payMeansCdCard === PAY_MEANS_10){
			let cardc = $("#cardcCd").val();
			selCard(cardc);
		}else if(payMeansCdCard === PAY_MEANS_11){
			selectDefBillCard();
		}*/
		
		//0원결제일 경우 결제 수단 영역 숨김처리
		var payMeansCd = "";
		if(payTotalAmt == 0){
			$(".sect.binf").hide();
			payMeansCd = PAY_MEANS_00;
			selectPayMethod(payMeansCd);
		}else{
			$(".sect.binf").show();
			var chkRdo = $("input[name=rd_bill_set]:checked");
			if(chkRdo.is("#easyCardPay")){
				if(!isPayBtn){
					//setBillHalbu();
					selectDefBillCard();
				}
				payMeansCd = PAY_MEANS_11;
			}else if(chkRdo.is("#commonPay")){
				var actCommonPay = $(".ddt .biltab").find("li.active");
				if(actCommonPay.length > 0){
					if(actCommonPay.is("#cardLi")){
						let cardc = $("#cardcCd").val();
						if(cardc && !isPayBtn){
							selCard(cardc);
						}
						payMeansCd = PAY_MEANS_10;
					}else if(actCommonPay.is("#vertLi")){
						payMeansCd = PAY_MEANS_30;
					}else if(actCommonPay.is("#realtimeLi")){
						payMeansCd = PAY_MEANS_20;
					}else if(actCommonPay.is("#paycoLi")){
						payMeansCd = PAY_MEANS_72;
					}else if(actCommonPay.is("#naverPayLi")){
						payMeansCd = PAY_MEANS_70;
					}else if(actCommonPay.is("#kakaoPayLi")){
						payMeansCd = PAY_MEANS_71;
					}
				}
				$("#payMeansCd").val(payMeansCd);
				selectPayMethod(payMeansCd);
			}
		}

	}
	//주문 param set
	, setParam : function(){
		let cartList = [];

		$("input[name=order_payment_cart_ids]").each(function(index, item){

			cartList.push($(item).val());
		});

		$("#cartIds").val(cartList);

		let cpInfos = []

		$("input[name=couponInfo]").each(function(index, item){

			cpInfos.push($(item).val());
		});

		$("#cpInfos").val(cpInfos);

		// 고객 parameter
		$("#mbrDlvraNo").val($("#order_payment_mbr_dlvra_no").val());
		$("#gbNm").val($("#order_payment_gb_nm").val());
		$("#postNoNew").val($("#order_payment_post_no_new").val());
		$("#roadAddr").val($("#order_payment_road_addr").val());
		$("#roadDtlAddr").val($("#order_payment_road_dtl_addr").val());
		$("#adrsNm").val($("#order_payment_adrs_nm").val());
		$("#adrsTel").val($("#order_payment_adrs_mobile").val());
		$("#adrsMobile").val($("#order_payment_adrs_mobile").val());
		$("#goodsRcvPstCd").val($("#order_payment_demand_goods_rcv_pst_cd").val());
		$("#goodsRcvPstEtc").val($("#order_payment_demand_goods_rcv_pst_etc").val());
		$("#pblGateEntMtdCd").val($("#order_payment_demand_pbl_gate_ent_mtd_cd").val());
		$("#pblGatePswd").val($("#order_payment_demand_pbl_gate_pswd").val());
		$("#dlvrDemand").val($("#order_payment_dlvr_demand").val());
		$("#dlvrDemandYn").val($("#order_payment_dlvr_demand_yn").val());
		
		let dlvrPrcsTpCd = $("#dlvrArea input[name='rdb_deli_a']:checked");
		if(!dlvrPrcsTpCd.val()){
			$("#dlvrPrcsTpCd").val(DLVR_PRCS_TP_10);
		}else{
			$("#dlvrPrcsTpCd").val(dlvrPrcsTpCd.val());
		}
		$("#ordDt").val(dlvrPrcsTpCd.data("ordDt"));
		$("#dlvrAreaNo").val(dlvrPrcsTpCd.data("dlvrAreaNo"));
		
		
		$("#mbrAddrInsertYn").val($("#order_payment_adrs_insert_yn:checked").val());

		let useMpPoint = $("#useMpPoint").val() ? parseInt($("#useMpPoint").val()) : 0;
		let addUseMpPoint = $("#addUseMpPoint").val() ? parseInt($("#addUseMpPoint").val()) : 0;
		
		// 상품 parameter
		$("#pkgDlvrNos").val($("#order_payment_pkg_dlvr_nos").val());
		$("#pkgDlvrAmts").val($("#order_payment_pkg_dlvr_amts").val());
		$("#goodsNms").val($("#order_payment_goods_nms").val());
		$("#goodsIds").val($("#order_payment_goods_ids").val());
		
		$("#ordUseGsPoint").val($("#useGsPoint").val());
		$("#ordUseMpPoint").val(useMpPoint + addUseMpPoint);
		$("#ordRealUseMpPoint").val(useMpPoint);
		$("#ordMpCardNo").val($("#mpCardNo").val());
		$("#ordPinNo").val($("#pinNo").val());

		let payGoodsAmt = parseInt($("#order_payment_total_goods_amt").val());
		let payDlvrAmt = parseInt($("#order_payment_total_dlvr_amt").val());
		let payTotDcAmt = parseInt($("#order_payment_total_dc_amt").val());
		
		let payTotPoint = parseInt($("#useGsPoint").val()) + useMpPoint + addUseMpPoint;
		// 임시 (payAmt = 금액이 이상해서 일단 하드코딩)
		$("#payAmt").val(payGoodsAmt + payDlvrAmt - payTotDcAmt - payTotPoint);
		$("#amt").val($("#order_payment_total_pay_amt").val());
	}
	, showHideCouponBtn : function(){
		var isGoodsCoupon = false;
		var isCartCoupon = false;
		var isDlvrcCoupon = false;
		
		if($("#goodsCouponList input").length > 0){
			isGoodsCoupon = true
		}
		if($("#cartCouponYn").val() == 'Y'){
			isCartCoupon = true;
		}
		if($("#dlvrcCouponYn").val() == 'Y'){
			isDlvrcCoupon = true;
		}
		
		//상품/배송비 쿠폰 버튼
		if(isGoodsCoupon || isDlvrcCoupon){
			$("#goodsCouponBtn").show();
		}else{
			$("#goodsCouponBtn").hide();
		}
		
		//장바구니 쿠폰 버튼
		if(isCartCoupon){
			$("#cartCouponBtn").show();
		}else{
			$("#cartCouponBtn").hide();
		}
		
		//쿠폰 사용 영역
		if(isGoodsCoupon || isCartCoupon || isDlvrcCoupon){
			$("#notExistCoupon").hide();
			$("#existCoupon").show();
		}else{
			$("#notExistCoupon").show();
			$("#existCoupon").hide();
		}
	}
	// 당일/새벽 배송일 경우 가상계좌 결제수단 제외
	, checkDlvrPrcsTpCdAndPay : function(){
		//일반결제
		let dlvrPrcsTpCd = $("#dlvrArea input[name='rdb_deli_a']:checked");
		if(dlvrPrcsTpCd.val() == DLVR_PRCS_TP_20 || dlvrPrcsTpCd.val() == DLVR_PRCS_TP_21){
			if($("input[name='rd_bill_set']:checked").val()=="common") {
				var selPayMeans = $(".biltab").find("li.active").find("button");
				if(selPayMeans.val() === PAY_MEANS_30){
					//$(".biltab").find("li").eq(0).find("button").trigger("click");
					$(".biltab > li").removeClass("active");
				}
			}
			$(".biltab").find("button[value="+PAY_MEANS_30+"]").closest("li").hide();
		}else{
			$(".biltab").find("button[value="+PAY_MEANS_30+"]").closest("li").show();
		}
	}
}

/*
 * Nice Pay
*/
var nicePay = {
	ready : function(){
		let payMeansCd = $("#payMeansCd").val();
		if(payMeansCd === PAY_MEANS_00){
			//0원 결제
			ajax.call({
				url : "/order/insertOrderFreePayAmt"
				, data : $("#order_payment_form").serialize()
				, done : function(data){
					orderActionLog();
					orderAdbrix();
					
					//앱 마케팅 처리 딜레이
					setTimeout(function() {
						$("#order_payment_form").attr("action", "/order/indexOrderCompletion");
						$("#order_payment_form").attr("target", "_self");
						$("#order_payment_form").attr("method", "post");
						$("#order_payment_form").submit();
					}, 300);
				}
			});
		}else if (payMeansCd === PAY_MEANS_11) {
			nicepayBilling();	// 빌링 결제 시작
		}else{
			nicePay.getSignData();
		}
	}
	//PG 검증값
	, getSignData : function(){
		let payAmt = $("#order_payment_total_pay_amt").val();
		let payMethod = $("#payMethod").val();
		let moid = $("#moid").val();
		let payMeansCd = $("#payMeansCd").val(); // mid 구분을 위해서 필요

		let options = {
			url : "/pay/nicepay/getSignData"
			, data : {
				payAmt : payAmt,
				payMethod : payMethod,
				moid: moid,
				payMeansCd: payMeansCd
			}
			, done : function(data){
				$("#ediDate").val(data.ediDate);
				$("#signData").val(data.signData);
				$("#mid").val(data.mid);

				nicepayStart();
			}

		}
		ajax.call(options);
	}
}

/*
 * 주문 배송지
*/
var orderDlvra = {
	//배송지 관리 팝업
	addressListPop : function(){
		var mbrDlvraNo = $("#order_payment_mbr_dlvra_no").val();
		
		var options = {
			url : "/order/popupAddressList"
			, data : {
				callBackFnc : "orderDlvra.callBackSelectAddress"
				, mbrDlvraNo : mbrDlvraNo
				, popId : "popupAddressList1"
			}
			, dataType : "html"
			, done : function(html){
				$("#popupAddressList1").html(html);
				ui.popLayer.open("popupAddressList1");
			}
		}
		ajax.call(options);
	}
	//배송지 팝업 선택 callBack
	, callBackSelectAddress : function(data){
		console.log('callBackSelectAddress', data);
		
		if(data.dftYn == 'Y'){
			$("#dftDelivery").show();
		}else{
			$("#dftDelivery").hide();
		}
		//배송 요청사항 여부
		if(data.dlvrDemandYn == 'Y'){
			$(".addr").find("#existDemand").show();
			$(".addr").find("#noExistDemand").hide();
		}else{
			$(".addr").find("#existDemand").hide();
			$(".addr").find("#noExistDemand").show();
		}
		
		$(".addr").find("#order_payment_gb_nm").val(data.gbNm);
		$(".addr").find("#order_payment_mbr_dlvra_no").val(data.mbrDlvraNo);
		$(".addr").find("#order_payment_post_no_new").val(data.postNoNew);
		$(".addr").find("#order_payment_road_addr").val(data.roadAddr);
		$(".addr").find("#order_payment_road_dtl_addr").val(data.roadDtlAddr);
		$(".addr").find("#order_payment_adrs_nm").val(data.adrsNm);
		$(".addr").find("#order_payment_adrs_mobile").val(data.mobile);
		$(".addr").find("#order_payment_demand_goods_rcv_pst_cd").val(data.goodsRcvPstCd);
		$(".addr").find("#order_payment_demand_goods_rcv_pst_etc").val(data.goodsRcvPstEtc);
		$(".addr").find("#order_payment_demand_pbl_gate_ent_mtd_cd").val(data.pblGateEntMtdCd);
		$(".addr").find("#order_payment_demand_pbl_gate_pswd").val(data.pblGatePswd);
		$(".addr").find("#order_payment_dlvr_demand").val(data.dlvrDemand);
		$(".addr").find("#order_payment_dlvr_demand_yn").val(data.dlvrDemandYn);
		
		//Text
		$(".addr").find("#dlvraGbNmEm").text(data.gbNm);
		$(".addr").find("#dlvraAdrsDiv").text("["+data.postNoNew+"] "+data.roadAddr +", "+data.roadDtlAddr);
		$(".addr").find("#dlvraTelsDiv").text(data.adrsNm + "/" + format.mobile(data.mobile) );
		
		//Text
		$(".addr").find("#demandGoodsRcvPstCd").text(data.goodsRcvPstCd == '40' ? data.goodsRcvPstEtc : data.goodsRcvPstNm);
		var PblGateEntMtdText = data.pblGateEntMtdNm;
		if(data.pblGateEntMtdCd == '10'){
			PblGateEntMtdText = PblGateEntMtdText +" "+ data.pblGatePswd;
		}
		$(".addr").find("#demandPblGateEntMtdCd").text(PblGateEntMtdText);
		$(".addr").find("#demandDlvrDemand").text(data.dlvrDemand);
		
		let dlvrPrcsTpList = orderDlvra.fncGetDlvrArea(data.postNoNew);
		
		// 자사 제품이 있을 경우만 실행
		let gb10Cnt = $("#gb10Cnt").val();
		if (gb10Cnt > 0) {
			orderDlvra.checkDlvrPrcsTpCd(dlvrPrcsTpList);
		}
	}
	//배송지 요청사항 팝업
	, changeDlvrDemandPop : function(){
		let mbrDlvraNo = $(".addr").find("#order_payment_mbr_dlvra_no").val();
		var data = {
			callBackFnc : "orderDlvra.callBackChangeDlvrDemand"
			, mbrDlvraNo : mbrDlvraNo
			, popId : "popDeliReq1"
		}
		$.extend(data, {
			goodsRcvPstCd : $("#order_payment_demand_goods_rcv_pst_cd").val()
			,goodsRcvPstEtc : $("#order_payment_demand_goods_rcv_pst_etc").val()
			,pblGateEntMtdCd :  $("#order_payment_demand_pbl_gate_ent_mtd_cd").val()
			,pblGatePswd :  $("#order_payment_demand_pbl_gate_pswd").val()
			,dlvrDemand :  $("#order_payment_dlvr_demand").val()
		});
		var options = {
			url : "/mypage/service/includeDlvrDemand"
			, data : data
			, dataType : "html"
			, done : function(html){
				$("#popDeliReq1").html(html);
				ui.popLayer.open("popDeliReq1");
			}
		}
		ajax.call(options);
	}
	//배송지 요청사항 팝업 callBack
	, callBackChangeDlvrDemand : function(data){
		console.log('callBackChangeDlvrDemand', data);
		
		$(".addr #order_payment_demand_goods_rcv_pst_cd").val(data.goodsRcvPstCd);
		$(".addr #order_payment_demand_goods_rcv_pst_etc").val(data.goodsRcvPstEtc);
		$(".addr #order_payment_demand_pbl_gate_ent_mtd_cd").val(data.pblGateEntMtdCd);
		$(".addr #order_payment_demand_pbl_gate_pswd").val(data.pblGatePswd);
		$(".addr #order_payment_dlvr_demand").val(data.dlvrDemand);
		$(".addr #order_payment_dlvr_demand_yn").val("Y");
		
		$(".addr").find("#existDemand").show();
		$(".addr").find("#noExistDemand").hide();
		
		//Text
		$(".addr").find("#demandGoodsRcvPstCd").text(data.goodsRcvPstCd == '40' ? data.goodsRcvPstEtc : data.goodsRcvPstNm);
		var PblGateEntMtdText = data.pblGateEntMtdNm;
		if(data.pblGateEntMtdCd == '10'){
			PblGateEntMtdText = PblGateEntMtdText +" "+ data.pblGatePswd;
		}
		$(".addr").find("#demandPblGateEntMtdCd").text(PblGateEntMtdText);
		$(".addr").find("#demandDlvrDemand").text(data.dlvrDemand);
		
	}
	//배송지 변경 체크
	,checkDlvrPrcsTpCd : function(dlvrPrcsTpList){
		var isDawn = false;
		var isOneDay = false;
		if(dlvrPrcsTpList && dlvrPrcsTpList.length > 0){
			$.each(dlvrPrcsTpList, function(index, value) {
				if(value.dlvrPrcsTpCd == "20" && value.isPostArea){
					isOneDay = true;
				}
				
				if(value.dlvrPrcsTpCd == "21" && value.isPostArea){
					isDawn = true;
				}
			});
		}
			
		if(isDawn && isOneDay){
			ui.alert('새벽/당일배송이 가능한 지역이에요');
		}else if(!isDawn && isOneDay){
			ui.alert('당일배송이 가능한 지역이에요');
		}else if(isDawn && !isOneDay){
			ui.alert('새벽배송이 가능한 지역이에요');
		}
	}
	// 주소 검색 팝업
	, openPostPop : function(){
		//window.open("/post/popupMoisPost?callBackFnc=orderDlvra.callBackOpenPostPop", "postPopup", "width=500, heigth=500");
		
		//20210628 주소 검색 팝업 : 레이어 팝업으로 수정
		var options = {
			url : "/post/popupMoisPost?callBackFnc=orderDlvra.callBackOpenPostPop"
			, data : ''
			, dataType : "html"
			, done : function(html){
				$("#orderAddLayers").html(html);
				$('#postPopLayer').removeClass('win');
				ui.popLayer.open("postPopLayer");
			} 
		}
		ajax.call(options);
	}
	// 주소 검색 팝업 콜백
	, callBackOpenPostPop : function(result){
		let postNo = result.zonecode;
		let roadAddr = result.roadAddress;
		let prclAddr = result.jibunAddress;
		let dtlAddr = result.addrDetail;
		//상세주소
		$(".adrlist .arr .a2").show();

		//상품 수령 장소 정보
		$(".addr .adrreq").show();
		
		$(".addr #order_payment_post_no_new").val(postNo);
		$(".addr #order_payment_road_addr").val(roadAddr);
		$(".addr #order_payment_road_dtl_addr").val(dtlAddr);
		
		$("#addressInfo").text("["+postNo+"] "+roadAddr);
		$("#addressDtlInfo").val(dtlAddr);
		
		let dlvrPrcsTpList = orderDlvra.fncGetDlvrArea(postNo);
		
		// 자사 제품이 있을 경우만 실행
		let gb10Cnt = $("#gb10Cnt").val();
		if (gb10Cnt > 0) {
			orderDlvra.checkDlvrPrcsTpCd(dlvrPrcsTpList);
		}
	}
	// 배송 처리 유형 set
	, fncGetDlvrArea : function(postNo) {
		var dlvrPrcsTpList;
		
		// 자사 제품이 있을 경우만 실행
		let gb10Cnt = $("#gb10Cnt").val();
		if (gb10Cnt > 0) {
			// 1. 배송방식 데이터 가져오기
			$.ajax({
				type: "POST",
				url: "/order/getDlvrAreaInfo",
				data: {postNo: postNo}, 
				async: false,
				dataType:"json",
				success:function(data){
					dlvrPrcsTpList = data.list;
					$("#dlvrArea").empty();
					// 2. 본사
					let fastestId = null;
					let fastestTime = null;
					$.each(data.list, function(index, value) {
						let dlvrAreaTmpl01; // 템플릿
						let ordDateTime = new Date(value.ordDateTime); // 배송완료 예상시간
						
						if (value.dlvrPrcsTpCd == "20" || value.dlvrPrcsTpCd == "21") {  // 새벽배송/당일배송
							//사전예약상품 - 택배 고정
							if($("#preBookYn").val() == 'N'){
								let tts = value.dlvrPrcsTpCd == "20" ? "당일배송": "새벽배송";
								
								// 1. 마감시간 체크
								// 마감시간 가져오기
								let closeDate = new Date(value.targetCloseDtm);
								let nowDate = new Date();
								
								// 2. 템플릿
								if(!value.isPostArea || value.isHoliday || value.isCisSlotClose || closeDate < nowDate) {
									// 2.1. 배송 불가
									dlvrAreaTmpl01 = $("#dlvrAreaClosed01").children().clone();
								} else {
									// 2.2. 배송 가능
									dlvrAreaTmpl01 = $("#dlvrAreaTmpl01").children().clone();
									dlvrAreaTmpl01.find("input[name=rdb_deli_a]").data(value);
									
									if(fastestId == null || (value.ordDateTime != null && (fastestTime > ordDateTime))) {
										fastestId = value.dlvrPrcsTpCd;
										fastestTime = ordDateTime;
									}
									
								}
								
								// 3. 메시지 처리
								// 3.1. 타이틀
								dlvrAreaTmpl01.find(".tts").text(tts);
								
								// 3.2. 메시지
								if (!value.isPostArea) {
									dlvrAreaTmpl01.find(".msg").text("가능지역이 아닙니다.");
								} else if(value.isHoliday) { // 휴무일
									dlvrAreaTmpl01.find(".msg").text("휴무일은 "+tts+"이 불가합니다.");
								}else if (value.isCisSlotClose) { // CIS 슬롯 마감
									dlvrAreaTmpl01.find(".msg").text(""+tts+"이 마감되었습니다.");
								} else if (closeDate < nowDate) { // 시간마감
									dlvrAreaTmpl01.find(".msg").text(""+tts+"이 마감되었습니다.");
								} else { // 정상상황
									dlvrAreaTmpl01.find(".msg").text(value.ordDlvrTimeShowText);
								}
								
							}

						} else { // 일반배송
							
							if(fastestId == null || (value.ordDateTime != null && (fastestTime > ordDateTime))) {
								fastestId = value.dlvrPrcsTpCd;
								fastestTime = ordDateTime;
							}
							
							dlvrAreaTmpl01 = $("#dlvrAreaTmpl01").children().clone();
							dlvrAreaTmpl01.find(".tts").text("택배배송");
							var nomalMsg = '<span>1~2일 소요 예정</span><span>16시 이전 주문 : 다음날 도착 (98%)<br>16시 이후 주문 : 2일 이내 도착</span>';
							dlvrAreaTmpl01.find(".msg").html(nomalMsg);
						}
						
						if(dlvrAreaTmpl01){
							dlvrAreaTmpl01.find("input[name=rdb_deli_a]").val(value.dlvrPrcsTpCd);
							
							// 클릭이벤트시 goodsInfoClick 함수 실행
							dlvrAreaTmpl01.find("input[name=rdb_deli_a]").on("click", goodsInfoClick);
							
							// 4. 현재 이배송이 제일 빨라요.
							// 아이콘 영역표시
							dlvrAreaTmpl01.find(".iconArea").addClass("icon_"+value.dlvrPrcsTpCd);
							
							$("#dlvrArea").append($(dlvrAreaTmpl01));
						}
						
					});
					
					// 제일빠른 아이콘 추가
					//택배인 경우 노출 X
					if(fastestId != 10){
						$("#dlvrArea .icon_"+fastestId).prepend($('<em class="itsfast">현재 이 배송이 가장 빨라요!</em>'));
					}
					// 제일빠른  배송 선택 처리 (클릭이벤트만 주도록 처리)
					$("#dlvrArea .icon_"+fastestId).parents("li").find("input[name='rdb_deli_a']").click();
					
					//새벽/당일 가상계좌 체크
					orderPay.checkDlvrPrcsTpCdAndPay();
				},
				error: function(request,status,error) {
					alert("배송방식을 가져오는데 실패했습니다.");
				}
			});
		}
		
		// 3. 업체배송 추가
		if($("#dlvrArea").find("#dlvrPrcsTp10").length == 0){
			let dlvrAreaTmpl02 = $("#dlvrAreaTmpl02").children().clone();
			$("#dlvrArea").append($(dlvrAreaTmpl02));
		}
		
		return dlvrPrcsTpList;
	}
	, valid : function(){
		// 배송지 valid
		let mbrDlvraNo = $(".addr").find("#order_payment_mbr_dlvra_no").val();
		//기본 배송지 없는경우
		if(!mbrDlvraNo){
			var focusObj;
			var focusMsg;
			
			if(!$("#order_payment_road_dtl_addr").val().trim()){
				focusObj = $("#order_payment_road_dtl_addr");
			}
			
			if(!$("#order_payment_post_no_new").val().trim()){
				focusObj = $(".addr .btAdr");
			}
			
			var mobilePattern = /^01([0|1|6|7|8|9])([0-9]{7,8})$/
				
			if(!$("#order_payment_adrs_mobile").val().trim()){
				focusObj = $("#order_payment_adrs_mobile");
				focusMsg = "휴대폰번호를 입력해주세요.";
			}else{
				if(!mobilePattern.test($("#order_payment_adrs_mobile").val().trim())){
					focusObj = $("#order_payment_adrs_mobile");
					focusMsg = "휴대폰번호를 정확히 입력해주세요.";
				}
			}
			
			if(!$("#order_payment_adrs_nm").val().trim()){
				focusObj = $("#order_payment_adrs_nm");
				focusMsg = "이름을 입력해주세요.";
			}
			
			if(!$("#order_payment_gb_nm").val().trim()){
				focusObj = $("#order_payment_gb_nm");
				focusMsg = "배송지 명칭을 입력해주세요.";
			}
			
			if(focusObj){
				ui.alert((focusMsg == null)? '정확한 배송지를 입력해주세요.' : focusMsg, {
					 ycb:function(){
				        focusObj.focus();
				    },
					ybt:'확인'
				});
				return false;
			}
		}else{
			//배송지 관련 필수 체크
			var reqMsg;
			
			if(!$("#order_payment_adrs_nm").val().trim()){
				reqMsg = "배송지 정보에 받는사람 이름이 없습니다. 배송지 정보를 입력해주세요.";
			}
			
			if(!$("#order_payment_adrs_mobile").val().trim()){
				reqMsg = "배송지 정보에 휴대폰번호가 없습니다. 배송지 정보를 입력해주세요.";
			}
			
			if(!$("#order_payment_post_no_new").val().trim()){
				reqMsg = "배송지 정보에 주소가 없습니다. 배송지 정보를 입력해주세요.";
			}
			
			if(!$("#order_payment_road_addr").val().trim()){
				reqMsg = "배송지 정보에 주소가 없습니다. 배송지 정보를 입력해주세요.";
			}
			
			if(!$("#order_payment_road_dtl_addr").val().trim()){
				reqMsg = "배송지 정보에 상세주소가 없습니다. 배송지 정보를 입력해주세요.";
			}
			
			if(reqMsg){
				ui.alert(reqMsg,{
					ycb:function(){
						$(".addr .btnDeMod").focus();
					},
					ybt:'확인'
				});
				return false;
			}
		}
		
		//배송 요청 사항
		if($("#order_payment_dlvr_demand_yn").val() != 'Y'){
			ui.alert('배송요청사항을 입력해주세요.',{
				ycb:function(){
					$(".addr .btPdPl").focus();
				},
				ybt:'확인'
			});
			return false;
		}
		
		return true;
	}
}

/*
 * MP 포인트
*/
//멤버십 등록 필요 - 카드번호 내역이 없이 들어온경우
const MP_TYPE_10 = "10";	
//포인트 조회 필요 - 카드번호 내역이 있는 경우  최초 주문서 진입 시
const MP_TYPE_20 = "20";	
//모두사용  - 카드번호 등록 후 사용가능한 상태
const MP_TYPE_30 = "30";	

var mpPnt = {
	data : {
		mpSaveRate : 0,
		mpAddSaveRate : 0,
		mpAddUseRate : 0,
		mpMaxSavePnt : 0,
		//부스트업 구분 코드
		mpPntPrmtGbCd : null
	},
	init : function(){
		//data set
		mpPnt.data.mpSaveRate = $("#mpSaveRate").val() ? $("#mpSaveRate").val() * 0.01 : 0;
		mpPnt.data.mpAddSaveRate = $("#mpAddSaveRate").val() ? $("#mpAddSaveRate").val() * 0.01 : 0;
		mpPnt.data.mpAddUseRate = $("#mpUseRate").val() ? $("#mpUseRate").val() * 0.01 : 0;
		mpPnt.data.mpMaxSavePnt = $("#mpMaxSavePnt").val();
		mpPnt.data.mpPntPrmtGbCd = $("#mpPntPrmtGbCd").val();
		
		
		$(document).on("change focusout", "#view_use_mp_point" ,function(e){
			var pnt = $(this).val().replace(/[\D]/g,'');
			mpPnt.changeMpPoint('N', pnt);
		})
		.on("click",".wooju .btnDel",function(){
			mpPnt.changeMpPoint('N', '');
		});
		
		mpPnt.getMpSaveRmnCount();
	},
	changeMpPoint : function(allYn, usePoint){
		var usableMpPnt = parseInt($("#usableMpPnt").val());
		if(allYn == 'N'){
			if(usePoint){
				usePoint = parseInt(usePoint.replace(/,/g,""));
				if(usePoint < usableMpPnt){
					usableMpPnt = parseInt(usePoint);
				}
			}else{
				usableMpPnt = 0;
			}
		}
		//추가 사용율 적용
		var addUseRate = mpPnt.data.mpAddUseRate;
		
		//결제가능 포인트 금액
		var stdAmt = parseInt($("#order_payment_total_pay_amt_ex_mp_point").val());
		var realStdAmt = 0;
		
		//추가 사용율이 있는 경우
		if(addUseRate != 0){
			realStdAmt = Math.floor(stdAmt / (1 + addUseRate));
		}else{
			realStdAmt = stdAmt;
		}
		
		var addUsePnt = 0;
		var dftUsePnt = 0;
		
		if(usableMpPnt <= 0){
			dftUsePnt = 0;
		}else if(usableMpPnt > realStdAmt){
			dftUsePnt = realStdAmt;
		}else if(usableMpPnt <= realStdAmt){
			dftUsePnt = usableMpPnt;
		}
		
		if(addUseRate != 0){
			addUsePnt = Math.floor(dftUsePnt * addUseRate);
			$("#boostAddUsePnt").html(format.num(addUsePnt) +"원");
		}else{
			$("#boostAddUsePnt").html("");
		}
		
		if (dftUsePnt == 0) {
			$("#view_use_mp_point").val('');
		} else {
			$("#view_use_mp_point").val(format.num(dftUsePnt));
		}
		$("#useMpPoint").val(dftUsePnt);
		$("#addUseMpPoint").val(addUsePnt);
		
		orderPay.calPayAmt();
	},
	//멤버십 등록
	insertCard : function(){
		// 팝업 호출
		popupSktmpRegist();
	},
	insertCallBack : function(cbData){
		
		var pastUseMpPoint = $("#useMpPoint").val();
		$("#view_use_mp_point").val('');
		$("#view_use_mp_point").attr("placeholder","1C 단위로 입력해주세요.");
		$("#view_use_mp_point").prop("disabled", false);
		$("#useMpPoint").val(0);
		$("#addUseMpPoint").val(0);
		
		//사용포인트가 있었다가 사라진 경우
		if(pastUseMpPoint && pastUseMpPoint != 0){
			orderPay.calPayAmt();
		}
		
		$(".wjmemNo").show();
		$(".wjmemNo").removeAttr('style');
		$("#mpCardNo").val(cbData.cardNo);
		$("#pinNo").val(cbData.pinNo);
		
		$(".wjmemNo").find(".t").html("<em>우주멤버십</em> "+cbData.viewCardNo);
		mpPnt.searchUsablePnt();
		orderView.changePntView();
		
		mpPnt.changeMpBtn(MP_TYPE_30);
		
		mpPnt.getMpSaveRmnCount();
	},
	//버튼 명 변경
	changeMpBtn : function(mpType){
		if(mpType == MP_TYPE_10){
			$(".wooju").find("#mpPntBtn").data("type", MP_TYPE_10);
			$(".wooju").find("#mpPntBtn").text("멤버십 등록");
			$(".wooju").addClass("disabled");
		}else if(mpType == MP_TYPE_20){
			$(".wooju").find("#mpPntBtn").data("type", MP_TYPE_20);
			$(".wooju").find("#mpPntBtn").text("포인트 조회");
			$(".wooju").removeClass("disabled");
		}else if(mpType == MP_TYPE_30){
			$(".wooju").find("#mpPntBtn").data("type", MP_TYPE_30);
			$(".wooju").find("#mpPntBtn").text("모두 사용");
			$(".wooju").removeClass("disabled");
		}
		
	},
	//멤버십 버튼 클릭
	aplMpPnt : function(obj){
		var mpType = $(obj).data("type");
		if(mpType == MP_TYPE_10){
			selectCertType('registSktmp');
		}else if(mpType == MP_TYPE_20){
			//비밀번호 입력 팝업
			popupSktmpPwdChk();
		}else if(mpType == MP_TYPE_30){
			mpPnt.changeMpPoint('Y', '');
		}
	},
	//사용가능 포인트 조회
	searchUsablePnt : function(){
		var options = {
			url : "/order/getUsableMpPnt",
			data : {
				EBC_NUM1 : $("#mpCardNo").val(),
				GOODS_AMT : parseInt($("#order_payment_total_pay_amt_ex_mp_point").val())
			},
			done : function(data){
				if(data.res != null){
					
					if(data.res.mp_AMT){
						$("#usableMpPnt").val(data.res.mp_AMT);
						$("#usableMpPntTxt").text(format.num(data.res.mp_AMT)+"C");
					}
					
					$(".wooju .input").removeClass("disabled");
					$(".wooju input").prop("disabled", false);
				}
			}
		};
		ajax.call(options);
	},
	//적립예정 포인트 계산
	calSavePnt : function(){
		var rtn = {
			dtfSavePnt : 0,
			addSavePnt : 0
		};
		
		var chkTotalAmt = calSaveTgAmt(); 
		var allSavePnt = Math.floor(chkTotalAmt * (mpPnt.data.mpSaveRate + mpPnt.data.mpAddSaveRate));
		
		var maxSavePnt = mpPnt.data.mpMaxSavePnt;
		var addSavePnt = 0;
		var dtfSavePnt = 0;
		if(maxSavePnt != 0){
			if(allSavePnt > parseInt(maxSavePnt)){
				allSavePnt = parseInt(maxSavePnt);
			}
		}
		
		if(mpPnt.data.mpAddSaveRate != 0){
			dtfSavePnt = Math.floor(chkTotalAmt * mpPnt.data.mpSaveRate);
			addSavePnt = allSavePnt - dtfSavePnt;
		}else{
			dtfSavePnt = allSavePnt;
			addSavePnt = 0;
		}
		rtn.dtfSavePnt = dtfSavePnt;
		rtn.addSavePnt = addSavePnt;
		
		return rtn;
	},
	//잔여 적립 횟수 조회
	getMpSaveRmnCount : function(){
		if($("#mpCardNo").val()){
			var options = {
				url : "/order/getMpSaveRmnCount",
				data : {
					EBC_NUM1 : $("#mpCardNo").val()
				},
				done : function(data){
					if(data.res != null && data.res.accum_CNT){
						if(data.res.accum_CNT > 0){
							//$(".saveMpPntLi").show();
							$(".gdpnt").not(".member").hide();
							$(".gdpnt.member").show();
						}else{
							//$(".saveMpPntLi").hide();
							$(".gdpnt").not(".onlygs").hide();
							$(".gdpnt.onlygs").show();
						}
					}
				}
			};
			ajax.call(options);
		}
	}
}
