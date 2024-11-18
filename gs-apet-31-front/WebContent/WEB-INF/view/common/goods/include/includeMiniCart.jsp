<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page import="front.web.config.constants.FrontWebConstants" %>

<script type="text/javascript">
	$(document).ready(function(){
		if ("${view.deviceGb ne frontConstants.DEVICE_GB_10}" == "true") {
			ui.lock.using(true);
		}

		$(".cart-area .uispiner").find(".amt").prop("disabled", true);

		var arrCart = new Array();

		$.each($("input[name=cartIds]:checked").not(":disabled"), function(idx, cart){
			var data = {
				cartId : $(cart).val()
				,buyQty : $("#buyQty"+$(cart).val()).val()
			}
			arrCart.push(data);
		});

		cartGoods.changeCheckInfo(arrCart);

		$("#miniChkAll").click(function() {
			var chk = $(this).prop("checked");
			var arrCart = new Array();

			$.each($("input[id^=chkCartId]").not(":disabled"), function(){
				if($(this).prop("checked") != chk){
					var data = {
						cartId : $(this).val()
						,buyQty : $("#buyQty"+$(this).val()).val()
						,goodsPickYn : chk ? "Y" : "N"
					}
					arrCart.push(data);
				}
			});

			$(".cart-area input[id^=chkCartId]").not(":disabled").prop("checked", chk);

			cartGoods.updateCartBuyQtyAndCheckYn(arrCart, function(){
				cartGoods.changeCheckInfo(arrCart);
			});
		});

		//상품 선택
		$(".cart-area input[id^=chkCartId]").not(":disabled").change(function() {
			var obj = $(this);
			var $list = $(this).closest(".list");

			var chkLen = $list.find("input[id^=chkCartId]").not(":disabled").filter(function(){
				return $(this).prop('checked');
			}).length;

			if(chkLen == $list.find("input[id^=chkCartId]").not(":disabled").length){
				$("#miniChkAll").prop("checked", true);
			}else{
				$("#miniChkAll").prop("checked", false);
			}

			var arrCart = new Array();
			var data = {
				cartId : $(this).val()
				,buyQty : $("#buyQty"+$(this).val()).val()
				,goodsPickYn : $(this).prop('checked') ? "Y" : "N"
			}
			arrCart.push(data);

			cartGoods.updateCartBuyQtyAndCheckYn(arrCart, function(){
				cartGoods.changeCheckInfo(arrCart);
			});
		});

		$(document).off("click", ".uispiner .bt");
		//수량 컨트롤
		$(".uispiner .plus").off("click").on("click",function(e){
			e.preventDefault();
			var $qtyObj = $(this).siblings(".amt");
			console.log("plus", $(this));
			var maxOrdQty = $qtyObj.data("maxOrdQty");
			if (!maxOrdQty || parseInt($qtyObj.val()) < maxOrdQty) {
				var cartQty = parseInt($qtyObj.val()) + 1;
				$qtyObj.val(cartQty);

				var arrCart = new Array();
				var cartId = $qtyObj.data("cartId");
				var data = {
					cartId : cartId
					,buyQty : cartQty
					,goodsPickYn : $("#chkCartId"+cartId).prop('checked') ? "Y" : "N"
				}
				arrCart.push(data);

				//cartGoods.setDisabledAmt($(this));

				cartGoods.updateCartBuyQtyAndCheckYn(arrCart, function(){
					cartGoods.changeQty(arrCart);
				});
			} else {
				ui.toast("최대 " + maxOrdQty + "개까지 구매할 수 있어요", "maxOrdQty");
			}
			return false;
		});

		$(".uispiner .minus").off("click").on("click",function(e){
			e.preventDefault();

			var $qtyObj = $(this).siblings(".amt");

			var minOrdQty = $qtyObj.data("minOrdQty") ? $qtyObj.data("minOrdQty") : 1;
			if (parseInt($qtyObj.val()) > minOrdQty) {
				var cartQty = parseInt($qtyObj.val()) - 1
				$qtyObj.val(cartQty);

				var arrCart = new Array();
				var cartId = $qtyObj.data("cartId");
				var data = {
					cartId : cartId
					,buyQty : cartQty
					,goodsPickYn : $("#chkCartId"+cartId).prop('checked') ? "Y" : "N"
				}

				arrCart.push(data);

				//cartGoods.setDisabledAmt($(this));

				cartGoods.updateCartBuyQtyAndCheckYn(arrCart, function(){
					cartGoods.changeQty(arrCart);
				});
			} else {
				ui.toast("최소 " + minOrdQty + "개 이상 구매할 수 있어요", "maxOrdQty");
			}
			return false;
		});
	});

	//펫샵 메인 이동
	function fnGoShopMain(){
		//App일때 영상상세에서 다른화면으로 이동시 화면 닫고 이동해야함
		if("${view.deviceGb eq frontConstants.DEVICE_GB_30}" == "true" && document.location.href.indexOf("/tv/series/indexTvDetail") > -1){
			// 데이터 세팅
			toNativeData.func = "onCloseMovePage";
			toNativeData.moveUrl = "${view.stDomain}/shop/home/";
			// APP 호출
			toNative(toNativeData);
		}else{
			location.href = "/shop/home/";
		}
	}
	
	//미니카트 주문하기 
	function orderSelectfunc(isLogin){
		if(isLogin == 'false'){
			ui.confirm('로그인 후 서비스를 이용할 수 있어요.<br>로그인 할까요?', { // 컨펌 창 옵션들
				ycb: function () {
					var url = encodeURIComponent(document.location.href);
					console.log("url :"+url);
					if("${view.deviceGb eq frontConstants.DEVICE_GB_30}" == "true" && document.location.href.indexOf("/tv/series/indexTvDetail") > -1){
						fncAppCloseMoveLogin(url);
					}else{
						document.location.href = '/indexLogin?returnUrl=' + url;
					}
				},
				ncb: function () {
					return false;
				},
				ybt: '확인', // 기본값 "확인"
				nbt: '취소'  // 기본값 "취소"
			});
		}else{
			order.select();
		}
	}
</script>

<c:choose>
	<c:when test="${not empty cartList}">
		<!-- 장바구니 -->
		<div class="cart-area cmb_inr_scroll">

			<c:set var="goodsCnt" value="0" />
			<c:set var="goodsChkCnt" value="0" />
			<c:forEach var="cart" items="${cartList}" varStatus="idx" begin="0" end="4">
				<c:if test="${cart.salePsbCd eq frontConstants.SALE_PSB_00}">
					<c:set var="goodsCnt" value="${goodsCnt + 1 }" />
					<c:if test="${cart.goodsPickYn eq 'Y' }">
						<c:set var="goodsChkCnt" value="${goodsChkCnt + 1 }" />
					</c:if>
				</c:if>
			</c:forEach>
			<div class="all-check">
				<label class="checkbox t01">
					<input type="checkbox" id="miniChkAll" ${goodsCnt eq goodsChkCnt ? 'checked="checked"' :''}><span class="txt">전체 선택</span>
				</label>
			</div>
			<div class="check-list">
				<ul class="list">
					<form id="cartForm">
						<input type="hidden" id="miniCartYn" value="Y">
						<c:forEach var="cart" items="${cartList}" varStatus="idx" begin="0" end="4">
							<c:set var="isMiniCart" value="${true }" scope="request"/>
							<c:set var="cart" value="${cart}" scope="request"/>
							
							<jsp:include page="/WEB-INF/view/order/include/incOrderGoods.jsp"/>
						</c:forEach>
					</form>
				</ul>
				<p class="info-t1"><spring:message code='front.web.view.goods.shoppingCartinfo.popup.msg'/></p>
				<c:if test="${fn:length(cartList) > 5}">
					<div class="btn-area">
						<a href="#" class="btn round" onclick="fncGoodsAppCloseMove('/order/indexCartList'); return false;" data-url="${view.stDomain}/order/indexCartList"><spring:message code='front.web.view.common.shoppingCart.totalView.title'/><span class="arrow"></span></a>
					</div>
				</c:if>
				<c:forEach var="dlvrc" items="${dlvrcList}">
					<input type="hidden" name="dlvrcPlcChkAmt" data-dlvrc-plc-no="${dlvrc.dlvrcPlcNo}" data-comp-no="${dlvrc.compNo}" id="dlvrcPlcChkAmt${dlvrc.dlvrcPlcNo}" value="0"/>
				</c:forEach>
			</div>
		</div>
		<!-- // 장바구니 -->
		<nav class="cartNavs t2"><!-- t2클래스 삭제 -->
			<div class="inr">
				<div class="btns">
					<div class="obts">
						<button type="button" class="bt btOrde" onclick="orderSelectfunc('${session.isLogin()}');" data-content="${cart.cartId}" data-url="${view.stDomain}/order/indexOrderPayment"><span class="t" id="totalMiniCartPayBtn"><spring:message code='front.web.view.common.msg.miniCart.order'/></span></button>
						<!-- <button type="button" class="bt btAlim"><span class="t">입고알림</span></button> -->
					</div>
				</div>
			</div>
		</nav>
	</c:when>
	<c:otherwise>
		<!-- no 이미지 -->
		<div class="commentBox-noneBox">
			<!-- no data -->
			<section class="no_data i2">
				<div class="inr">
					<div class="msg">
						<spring:message code='front.web.view.common.msg.miniCart.empty'/>
					</div>
					<div class="uimoreview">
						<a href="#" class="bt more" onclick="fnGoShopMain(); return false;" data-content="" data-url="/shop/home/" ><spring:message code='front.web.view.common.msg.miniCart.goPetshop'/></a>
					</div>
				</div>
			</section>
			<!-- // no data -->
		</div>
		<!-- // no 이미지 -->
	</c:otherwise>

</c:choose>