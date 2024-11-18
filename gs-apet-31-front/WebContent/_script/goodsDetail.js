/* constants */
const CONSTANTS_GOODS_STAT_40 = "40";
/** 상품 상태 코드 : 판매중(승인) */

const CONSTANTS_CART_ORDER_TYPE_NORMAL = "NORMAL";
/** 장바구니 주문 유형 : 일반 주문 */
const CONSTANTS_CART_ORDER_TYPE_ONCE = "ONCE";
/** 장바구니 주문 유형 : 바로 주문 */

/** message */
const FRONT_WEB_VIEW_GOODS_DETAIL_INSERT_WISH_SUCCESS = "위시리스트에 상품이 담겼습니다.\n확인하시겠습니까?";
const FRONT_WEB_VIEW_GOODS_DETAIL_REMOVE_WISH_SUCCESS = "위시리스트에 담긴 상품을 삭제하였습니다.";
const FRONT_WEB_VIEW_GOODS_DETAIL_DUPLICATE_WISH = "이미 위시리스트에 담긴 상품입니다.";
const FRONT_WEB_VIEW_GOODS_DETAIL_DUPLICATE_OPTION = "이미 선택되어 있는 옵션입니다.";
const FRONT_WEB_VIEW_GOODS_DETAIL_ITEM_SOLDOUT = "선택하신 단품은 품절되었습니다.";
const FRONT_WEB_VIEW_GOODS_DETAIL_ITEM_STOP = "선택하신 단품은 판매중지되었습니다.";
const FRONT_WEB_VIEW_GOODS_DETAIL_SELECT_ITEM = "상품이 선택되지 않았습니다.";
const FRONT_WEB_VIEW_GOODS_DETAIL_CONFIRM_SHOPPINGCART = "장바구니에 상품이 담겼습니다. 장바구니로 이동하시겠습니까?";
const FRONT_WEB_VIEW_GOODS_DETAIL_MSG_MIN_SHOPPING = "최소  구매수량은";
const FRONT_WEB_VIEW_GOODS_DETAIL_MSG_MAX_SHOPPING = "최대  구매수량은";
const FRONT_WEB_VIEW_GOODS_DETAIL_MSG_NUMBER = "개입니다.";
var Templates = {};
var goodsData, itemData;

function goodsInit(goods, item, itemSize, hot, group) {

	// template 가져오기
	$
			.ajax({
				url : "/_template/goods/items.hbs",
				async : false,
				dataType : "html",
				success : function(result) {
					$('body').append(result);
					// var str = result;
					$('script[id$="Template"]').each(function() {
						var name = $(this).attr("id");
						var src = $(this).text();
						Templates[name] = src;
					});
					goodsData = goods;
					// itemSize = itemSize;
					itemData = item;
					// 상품문의 영역 호출
					ajax.load("goods_inquiry_area",
							"/goods/indexGoodsInquiryList", {
								goodsId : goods.goodsId
							});
					// 상품평가 영역 호출
					ajax.load("goods_comment_area",
							"/goods/indexGoodsCommentList", {
								goodsId : goods.goodsId
							});
					// 사용자 정의 상품상세 설명 영역
					ajax.load("include_user_define_area",
							"/goods/indexUserDefine", {});

					$('#time01').countdown(hot.saleEndDtm, function(event) {
						$(this).html(event.strftime('%D일 %H:%M:%S'));
					});

					$('#time02').countdown(group.saleEndDtm, function(event) {
						$(this).html(event.strftime('%D일 %H:%M:%S'));
					});
					// var optioncheck = new OptionCheck();

					optionArea(itemSize);
				}
			});
}

var goodsSelect = {
	add : function(goodsId, goodsNm, itemNo, itemNm, saleAmt, addSaleAmt, qty,
			dispDelYn, assemYn, assemFee) {
		var price = parseInt(saleAmt) * parseInt(qty);

		assemYn = "N";
		if (goodsNm == null || goodsNm === "") {
			goodsNm = goodsData.goodsNm;
		}
		itemNm = "[" + goodsNm + "]" + itemNm;

		var goodsSelectData = {
			goodsId : goodsId,
			itemNo : itemNo,
			itemNm : itemNm,
			saleAmt : saleAmt,
			addSaleAmt : addSaleAmt,
			qty : qty,
			price : price,
			formatPrice : format.num(price),
			assemYn : assemYn,
			dispDelYn : dispDelYn !== 'N' ? true : false
		}

		Handlebars.registerHelper('ifAddSaleAmtYn', function(options) {
			if (this.addSaleAmt != null && this.addSaleAmt !== 0) {
				return options.fn(this);
			} else {
				return options.inverse(this);
			}
		});
		Handlebars.registerHelper('ifAddSaleAmtPlus', function(options) {
			this.formatAddSaleAmt = format.num(addSaleAmt);
			if (this.addSaleAmt > 0) {
				return options.fn(this);
			} else {
				return options.inverse(this);
			}
		});
		// 핸들바 템플릿에 데이터를 바인딩해서 HTML을 생성한다.
		var compileTemp = Handlebars.compile(Templates.goodsSelectAddTemplate);
		var itemList = compileTemp(goodsSelectData);

		$("div[name=goods_select_list]").append(itemList);

		// 선택된 옵션 selectbox 초기화
		$("[id^=selected_attrVal_" + goodsId + "]").val("");
		$("[name^=select_").val("");

		calTotalAmt();
	},
	// 삭제 버튼 이벤트
	del : function(obj) {
		// $(obj).parent().remove();
		var parent = $(obj).parent().attr("name");
		$("li[name=" + parent + "]").remove();

		calTotalAmt();
	},
	// 증가 버튼 이벤트
	qtyUp : function(itemNo) {
		var qtyObj = $("div[name=select_opt_" + itemNo + "]").find(
				"input[name=buyQtys]");
		var qtySpanObj = $("div[name=select_opt_" + itemNo + "]").find(
				"span.qty");

		if (goodsSelect.check(qtyObj, "U")) {
			var qty = parseInt(qtyObj.val()) + 1;
			qtyObj.val(qty);
			qtySpanObj.html(qty);
			goodsSelect.calAmt(qtyObj);
		}

	},
	// 감소 버튼 이벤트
	qtyDown : function(itemNo) {
		var qtyObj = $("div[name=select_opt_" + itemNo + "]").find(
				"input[name=buyQtys]");
		var qtySpanObj = $("div[name=select_opt_" + itemNo + "]").find(
				"span.qty");

		if (goodsSelect.check(qtyObj, "D")) {
			var qty = parseInt(qtyObj.val()) - 1;
			qtyObj.val(qty);
			qtySpanObj.html(qty);
			goodsSelect.calAmt(qtyObj);
		}
	},
	// 최대,최소 체크 이벤트
	check : function(qtyObj, gb) {
		var minQty = goodsData.minOrdQty;
		var maxQty = goodsData.maxOrdQty;

		if (minQty === '' || minQty === undefined) {
			minQty = 1;
		}

		// 수량감소
		if (gb === "D" && (parseInt(qtyObj.val()) <= parseInt(minQty))) {
			alert(FRONT_WEB_VIEW_GOODS_DETAIL_MSG_MIN_SHOPPING + " " + minQty
					+ FRONT_WEB_VIEW_GOODS_DETAIL_MSG_NUMBER);
			return false;
		}
		// 수량증가
		if (gb === "U" && (parseInt(qtyObj.val()) >= parseInt(maxQty))) {
			alert(FRONT_WEB_VIEW_GOODS_DETAIL_MSG_MAX_SHOPPING + " " + maxQty
					+ FRONT_WEB_VIEW_GOODS_DETAIL_MSG_NUMBER);
			return false;
		}
		// 옵션추가 시 수량검사
		if (typeof (gb) === "undefined" || gb == null) {
			if (parseInt(qtyObj.text()) < parseInt(minQty)) {
				alert(FRONT_WEB_VIEW_GOODS_DETAIL_MSG_MIN_SHOPPING + " "
						+ minQty + FRONT_WEB_VIEW_GOODS_DETAIL_MSG_NUMBER);
				return false;
			} else if (parseInt(qtyObj.text()) > parseInt(maxQty)) {
				alert(FRONT_WEB_VIEW_GOODS_DETAIL_MSG_MAX_SHOPPING + " "
						+ maxQty + FRONT_WEB_VIEW_GOODS_DETAIL_MSG_NUMBER);
				return false;
			}
		}
		return true;
	},
	// 금액 변경
	calAmt : function(qtyObj) {
		var price = parseInt(qtyObj.parent().children("input.amt").val())
				* parseInt(qtyObj.val());
		var addSaleAmt = parseInt(qtyObj.parent().children("input.addSaleAmt")
				.val())
				* parseInt(qtyObj.val());

		qtyObj.parent().parent().children("div.price").html(
				format.num(price) + " 원");
		qtyObj.parent().parent().children("div.option_name").children(
				"span[name=addSaleAmt]").html(format.num(addSaleAmt));
		qtyObj.parent().parent().children("input[name=price]").val(price);

		calTotalAmt();
	},
	// 옵션 선택
	chooseOption : function(goodsId, attrNo, attrValNo) {
		if (attrValNo === "") {
			return;
		}
		$("#check_item_form > #goodsId").val(goodsId);
		// $("#selected_attrVal_"+goodsId+"_"+attrNo).val(attrValNo);

		$(".product_order_box #selected_attrVal_" + goodsId + "_" + attrNo)
				.val(attrValNo);
		$(".option_wrap #selected_attrVal_" + goodsId + "_" + attrNo).val(
				attrValNo);
		$("select[name=select_" + attrNo + "]").val(attrValNo);

		goodsSelect.addOption(goodsId, "O");
	},
	addOption : function(goodsId, gubun) { // gubun = O:옵션선택시

		var isSelectedAll = true;
		var qty = $("#qty").text();
		var arrAttrNo = [], arrAttrValNo = [];

		// 옵션이 모두 선택되었는지 확인
		$("[id^=selected_attrVal_" + goodsId + "]").each(
				function(index) {
					console.log("@@@" + $(this).val());
					if ($(this).val() === "") {
						isSelectedAll = false;
						return false;
					} else {
						console.log("###"
								+ $("[id^=selected_attrNo_" + goodsId + "]")
										.eq(index).val());
						arrAttrNo.push($(
								"[id^=selected_attrNo_" + goodsId + "]").eq(
								index).val());
						arrAttrValNo.push($(this).val());
					}
					return true;
				});

		if (isSelectedAll) {
			$("#check_item_form > #attrNoList").val(arrAttrNo);
			$("#check_item_form > #attrValNoList").val(arrAttrValNo);

			// 선택된 옵션조합으로 단품정보 조회
			var options = {
				url : "/goods/checkGoodsOption",
				data : $("#check_item_form").serialize(),
				done : function(data) {
					if (data.item == null) {
						alert(FRONT_WEB_VIEW_GOODS_DETAIL_ITEM_STOP);
						return;
					}

					var isDuplicate = false; // 중복여부
					var isSoldOut = false; // 품절여부
					var goodsAmt = $("#saleAmt_" + goodsId).val();
					// 할인가가 있으면 할인가
					if ($("#dcAmt").val() !== "" && $("#dcAmt").val() > 0) {
						goodsAmt = goodsAmt - $("#dcAmt").val();
					}

					$("[name=itemNos]").each(function(index) {
						// 이미 추가된 옵션인 경우
						if ($(this).val() === data.item.itemNo) {
							isDuplicate = true;
							return false;
						}
						return true;
					});

					// 품절여부
					if ($("#stkMngYn").val() === "Y" && data.item.webStkQty < 1) {
						isSoldOut = true;
					}

					if (isDuplicate) { // 이미 같은 옵션이 추가되어 있는 경우
						alert(FRONT_WEB_VIEW_GOODS_DETAIL_DUPLICATE_OPTION);
						return;
					} else if (isSoldOut) {
						alert(FRONT_WEB_VIEW_GOODS_DETAIL_ITEM_SOLDOUT);
						return;
					} else {
						if (gubun === "O") { // 옵션 선택시
							goodsSelect.add(data.item.goodsId,
									goodsData.goodsNm, data.item.itemNo,
									data.item.itemNm, parseInt(goodsAmt)
											+ parseInt(data.item.addSaleAmt),
									parseInt(data.item.addSaleAmt), qty, 'Y');
						}
					}
				}
			};
			ajax.call(options);
		}
	}
};

/*
 * 욥션영역 출력
 */
function optionArea(itemSize) {
	if ($("#goodsStatCd").val() === CONSTANTS_GOODS_STAT_40
			&& $("#soldOutYn").val() !== "Y") {
		// 단품이 하나인 경우 선택박스 없이 자동으로 설정
		if (itemSize === 1) {
			var sGoodsAmt = 0;
			var sSaleAmt = goodsData.saleAmt;
			var sDcAmt = goodsData.saleAmt - goodsData.dcAmt;
			var sAddSaleAmt = itemData.addSaleAmt;
			if (sDcAmt > 0) {
				sGoodsAmt = parseInt(sDcAmt) + parseInt(sAddSaleAmt);
			} else {
				sGoodsAmt = parseInt(sSaleAmt) + parseInt(sAddSaleAmt);
			}
			goodsSelect.add(goodsData.goodsId, goodsData.goodsNm,
					itemData.itemNo, itemData.itemNm, sGoodsAmt, sAddSaleAmt,
					'1', 'N');
			$("div.p_option_box > #option_div").hide();
		} else {
			chooseGoods(goodsData.goodsId);
		}
	}

}

/*
 * 옵션영역 생성
 */
function chooseGoods(goodsId) {
	var options = {
		url : "/goods/getGoodsOption",
		data : {
			goodsId : goodsId
		},
		done : function(data) {
			var tempData = {
				items : JSON.parse(data.goodsAttrListData),
				goods : JSON.parse(data.goodsData)
			}
			// 핸들바 템플릿에 데이터를 바인딩해서 HTML을 생성한다.
			var compileTemp = Handlebars
					.compile(Templates.chooseGoodsOrderBoxTemplate);
			var itemList = compileTemp(tempData);
			var compileTemp2 = Handlebars
					.compile(Templates.chooseGoodsOptionWrapTemplate);
			var itemList2 = compileTemp2(tempData);

			$(".product_order_box #option_div").html(itemList);
			$(".option_wrap #option_div").html(itemList2);

			if (tempData.goods.dlvrcPlcNo != null) {
				$("#dlvrcPlcNo").val(tempData.goods.dlvrcPlcNo); // hjko추가
			}
		}
	};
	ajax.call(options);
}

/*
 * 장바구니 담기
 */
var cartInsert = {
	valid : function() {
		var goods = $("#goods_select_list").find("li");

		if (goods.length === 0) {
			alert(FRONT_WEB_VIEW_GOODS_DETAIL_SELECT_ITEM);
			return false;
		}

		return true;
	}
	// 바로 구매
	,
	now : function() {
		$("#goods_detail_now_buy_yn").val("Y");

		var options = {
			url : "/goods/insertCart",
			data : $("#goods_detail_form").serialize(),
			done : function(data) {
				var constData = {
					CONSTANTS_CART_ORDER_TYPE_ONCE : CONSTANTS_CART_ORDER_TYPE_ONCE
				}
				// 핸들바 템플릿에 데이터를 바인딩해서 HTML을 생성한다.
				var compileTemp = Handlebars
						.compile(Templates.formHtmlTemplate);
				var formHtml = compileTemp(constData);

				jQuery(formHtml).appendTo('body').submit();
			}
		};
		ajax.call(options);
	}
	// 장바구니 등록
	,
	normal : function() {
		$("#goods_detail_now_buy_yn").val("N");

		var options = {
			url : "/goods/insertCart",
			data : $("#goods_detail_form").serialize(),
			done : function(data) {
				if (confirm(FRONT_WEB_VIEW_GOODS_DETAIL_CONFIRM_SHOPPINGCART)) {
					location.href = "/order/indexCartList";
				}
			}
		};
		ajax.call(options);
	}

	// 버튼
	,
	button : function(gb) {
		if (cartInsert.valid()) {
			if (gb === "now")
				cartInsert.now();
			else if (gb === "normal")
				cartInsert.normal();

		}
	}
};

function OptionCheck() {
	this.init();
}

OptionCheck.prototype.init = function() {
	this.eventDefine();
}

OptionCheck.prototype.eventDefine = function() {
	var scrollTop = 0;
	var optionDiv = $(".product_order_box #option_div");
	var optionBox = $(".option_wrap");
	var optPosY = optionDiv.offset().top;
	var eventPoint = optPosY + optionDiv.outerHeight()
			- $("header_menu").height();

	$(window).scroll(function() {
		scrollTop = $(window).scrollTop();
		if (scrollTop >= eventPoint) {
			optionBox.show();
		} else {
			optionBox.hide();
		}
	})

	optionBox.find(".option_btn").on("click", function() {
		optionBox.toggleClass("show");
		return false;
	})

	$(window).trigger("scroll");
}// eventDefine

/*
 * 수량변경
 */
function changeQty(gb) {
	var qty = $("#qty").text(); //
	if (gb === "D") {
		if (qty > 1) {
			qty--;
		}
	} else {
		qty++;
	}
	$("#qty").text(qty);
}

// 위시리스트
function insertWishDetail(obj, goodsId) {

	if ($("#interestYn").val() === 'Y') {
		alert(FRONT_WEB_VIEW_GOODS_DETAIL_DUPLICATE_WISH);
		return;
	}

	var options = {
		url : "/goods/insertWish",
		data : {
			goodsId : goodsId
		},
		done : function(data) {

			if (data.actGubun === 'add') {
				$("#interestYn").val("Y");
				if (confirm(FRONT_WEB_VIEW_GOODS_DETAIL_INSERT_WISH_SUCCESS))
					location.href = "/mypage/interest/indexWishList";
			} else if (data.actGubun === 'remove') {
				$("#interestYn").val("N");
				$(obj).removeClass("click");
				// alert("위시리스트에서 삭제되었습니다.");
			} else {
				alert('위시리스트 등록 또는 삭제에 실패하였습니다.');
			}
		}
	};
	ajax.call(options);
}

/*
 * 쿠폰 다운로드 처리
 */
function insertCoupon(cpNo) {
	// if ('${session.mbrNo}' == 0) {
	// if(confirm("<spring:message code='front.web.view.common.msg.check.login'
	// />")){
	// pop.login({});
	// }
	// return;
	// }
	var options = {
		url : '/event/insertCoupon',
		data : {
			cpNo : cpNo
		},
		done : function(data) {
			alert(data.resultMsg);
		}
	};

	ajax.call(options);
}

/*
 * 선택상품 총 금액
 */
function calTotalAmt() {
	var totalQty = 0;
	var totalAmt = 0;

	var qtyObjs = $("#goods_select_list").find("li").children("div.ui_qty_box")
			.children("input[name=buyQtys]");
	var amtObjs = $("#goods_select_list").find("li").children(
			"input[name=price]");

	if (qtyObjs.length > 0) {
		for (var i = 0; i < qtyObjs.length; i++) {
			totalQty += parseInt($(qtyObjs[i]).val());
			totalAmt += parseInt($(amtObjs[i]).val());
		}
	}
	$("strong[name=goods_detail_total_qty]").html(" " + totalQty);
	$("strong[name=goods_detail_total_amt]").html(format.num(totalAmt));
}