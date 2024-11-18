<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript">
	$(document).ready(function(){
			
		cartGoods.init();
		
		console.log("로그인 여부", "${session.isLogin()}");
		console.log("Session ID", "${session.sessionId}");
		console.log("COOKIE", document.cookie);
		ui.spined.init();
		//전체 선택
		$("#chkAll").click(function() {
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
			
			$("input[id^=chkCompNo], input[id^=chkCartId]").not(":disabled").prop("checked", chk);
			
			cartGoods.setTotalCnt();
			
			cartGoods.updateCartBuyQtyAndCheckYn(arrCart, function(){
				cartGoods.changeCheckInfo(arrCart);
			});
		});
		
		//그룹핑 업체 선택
		$("input[id^=chkCompNo]").click(function() {
			var chk = $(this).prop("checked");
			
			var arrCart = new Array();
			var compNo = $(this).val();
			var $ul = $("#cartList"+compNo);
			
			$.each($ul.find("input[name=cartIds]").not(":disabled"), function(){
				if($(this).prop("checked") != chk){
					var data = {
						cartId : $(this).val()
						,buyQty : $("#buyQty"+$(this).val()).val()
						,goodsPickYn : chk ? "Y" : "N"
					}
					arrCart.push(data);
				}
			});
			
			
			$ul.find("input[name=cartIds]").not(":disabled").prop("checked", chk);
			
			var chkLen = $("input[id^=chkCompNo]").filter(function(){
				var compNo = $(this).val();
				if($("#cartList"+compNo).find("input[name=cartIds]").not(":disabled").length == 0){
					return false;
				}else{
					return $(this).prop('checked');
				}
			}).length;
			
			var compLen = $("input[id^=chkCompNo]").filter(function(){
				var compNo = $(this).val();
				if($("#cartList"+compNo).find("input[name=cartIds]").not(":disabled").length == 0){
					return false;
				}else{
					return true;
				}
			}).length;
			
			
			if(chkLen == compLen){
				$("#chkAll").prop("checked", true);
			}else{
				$("#chkAll").prop("checked", false);
			}
			
			cartGoods.setTotalCnt();
			
			cartGoods.updateCartBuyQtyAndCheckYn(arrCart, function(){
				cartGoods.changeCheckInfo(arrCart);
			});
		});
		
		//상품 선택			
		$("input[id^=chkCartId]").not(":disabled").change(function() {
			var obj = $(this);
			var compNo = $(this).closest(".cartlist").data("compNo");
			
			var $compUl = $(".cartlist").filter(function(){
				return $(this).data("compNo") == compNo;
			});
			
			var chkLen = $compUl.find("input[id^=chkCartId]").not(":disabled").filter(function(){
				return $(this).prop('checked');
			}).length;
			
			if(chkLen == $compUl.find("input[id^=chkCartId]").not(":disabled").length){
				$("#chkCompNo"+compNo).prop("checked", true);
				var chkCompNoLen = $("input[id^=chkCompNo]").filter(function(){
					var compNo = $(this).val();
					if($("#cartList"+compNo).find("input[name=cartIds]").not(":disabled").length == 0){
						return false;
					}
					return $(this).prop('checked');
				}).length;
				
				var compLen = $("input[id^=chkCompNo]").filter(function(){
					var compNo = $(this).val();
					if($("#cartList"+compNo).find("input[name=cartIds]").not(":disabled").length == 0){
						return false;
					}else{
						return true;
					}
				}).length;
				
				if(chkCompNoLen == compLen){
					$("#chkAll").prop("checked", true);
				}else{
					$("#chkAll").prop("checked", false);
				}
			}else{
				$("#chkCompNo"+compNo).prop("checked", false);
				$("#chkAll").prop("checked", false);
			}
			
			cartGoods.setTotalCnt();
			
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
		
		
		var preValue;
		var preCartId;
		
		$(document).off("click",".uispined .bt.mod");
		$(document).off("change",".uispined select.slt");
		$(document).off("input",".uispined .amt");
		$(document).off("focus",".uispined .amt");
		$(document).off("blur",".uispined .amt");
		
		
		$(document).on("click",".uispined .bt.mod",function(e){
			e.preventDefault();				
			ui.spined.using(this,"inp");
		});
		
		$(document).on("change",".uispined select.slt",function(e){
			e.preventDefault();
			ui.spined.using(this,"slt");
			if(preValue != $(this).val() || preCartId != $(this).closest(".uispined").find(".amt").data("cartId")){
				changeQty($(this).parent(".sel").siblings(".amt"));
			}
			preValue = $(this).val();
			preCartId = $(this).closest(".uispined").find(".amt").data("cartId");
		});
		
		$(document).on("input keyup",".uispined .amt",function(e){
			e.preventDefault();
			$(this).val( $(this).val().replace(/[^0-9-]/gi,"") );
			// _this.using(this,"inp");
		});
		
		$(document).on("focus",".uispined .amt",function(e){
			e.preventDefault();
			$(this).closest(".uispined").addClass("bt");
			console.log(e);
			preValue = $(this).val();
			preCartId = $(this).closest(".uispined").find(".amt").data("cartId");
		});
		
		
		$(document).on("blur",".uispined .amt",function(e){
			e.preventDefault();
			var obj = $(this);
			var chgVal = $(this).val();
			$(this).closest(".uispined").removeClass("bt");
			ui.spined.using(this,"inp");
			if(preValue != chgVal){
				if(chgVal > $(this).data("maxOrdQty")){
					ui.toast("최대 "+$(this).data("maxOrdQty")+"개까지 구매할 수 있어요");
				}
				var minOrdQty = $(this).data("minOrdQty") ? $(this).data("minOrdQty") : 1;
				if(chgVal < minOrdQty){
					ui.toast("최소 "+minOrdQty+"개 이상 구매할 수 있어요");
					$(this).val(minOrdQty);
				}
				
				changeQty(obj);
			}
			preValue = $(this).val();
			preCartId = $(this).closest(".uispined").find(".amt").data("cartId");
		});
		
		function changeQty(obj){
			var $qtyObj = obj;
			
			console.log("plus", $(this));
			var cartQty =$qtyObj.val()
			
			var arrCart = new Array();
			var cartId = $qtyObj.data("cartId");
			var data = {
				cartId : cartId
				,buyQty : cartQty
				,goodsPickYn : $("#chkCartId"+cartId).prop('checked') ? "Y" : "N"
			}
			arrCart.push(data);
			
			cartGoods.updateCartBuyQtyAndCheckYn(arrCart, function(){
				cartGoods.changeQty(arrCart);
			});
		}
	});
	
	//주문하기
	 function directOrderSelectFunc(isLogin){
			if(isLogin == false){
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

<form id="cartForm">
	<c:choose>
	<c:when test="${not empty cartList}">
		<c:set var="allCnt" value="0" />
		<c:set var="allChkCnt" value="0" />
		
		<c:forEach var="cart1" items="${cartList}">
			<c:if test="${cart1.salePsbCd eq frontConstants.SALE_PSB_00}">
				<c:set var="allCnt" value="${allCnt + 1 }" />
				<c:if test="${cart1.goodsPickYn eq 'Y' }">
					<c:set var="allChkCnt" value="${allChkCnt + 1 }" />
				</c:if>
			</c:if>
		</c:forEach>
		
		<div class="allcheck scroll_fixed">
			<div class="inr">
				<div class="box">
					<label class="checkbox"><input type="checkbox" id="chkAll" ${allCnt ne 0 and allCnt eq allChkCnt ? 'checked="checked"' :''}><span class="txt">전체 선택 <i class="i">(${allChkCnt }/${allCnt })</i></span></label>
					<a href="javascript:void(0);" class="lk" onclick="cartGoods.del()" data-content="" data-url="${view.stDomain}/order/deleteCart">선택 삭제</a>
				</div>
			</div>
		</div>
		<div class="cartWrap">
			<div class="cartPrds">
				<c:set var="chkCompGbCd" value="0" />
				<c:set var="chkCompNo" value="0" />
				<c:set var="onceCompGb10" value="N" />
				<c:set var="onceCompGb20" value="N" />
				
				<c:forEach var="cart" items="${cartList}" varStatus="idx">
					<c:if test="${chkCompNo ne cart.compNo }">
						<c:set var="compChkCnt" value="0" />
						<c:set var="compCnt" value="0" />
						<c:forEach var="cart1" items="${cartList}">
							<c:if test="${cart.compNo eq cart1.compNo and cart1.salePsbCd eq frontConstants.SALE_PSB_00}">
								<c:set var="compCnt" value="${compCnt + 1 }" />
								<c:if test="${cart1.goodsPickYn eq 'Y' }">
									<c:set var="compChkCnt" value="${compChkCnt + 1 }" />
								</c:if>
							</c:if>
						</c:forEach>
					</c:if>
					
					
					<c:if test="${cart.compNo ne chkCompNo}">
					<!-- 자사 -->
					<c:if test="${cart.compGbCd eq frontConstants.COMP_GB_10 and onceCompGb10 eq 'N' }">
						<c:set var="onceCompGb10" value="Y" />
						<section class="sect abt">
							<div class="frstat">
								<label class="checkbox"><input type="checkbox" id="chkCompNo${cart.compNo}" value="${cart.compNo}" ${compCnt ne 0 and compCnt eq compChkCnt ? 'checked="checked"' :''}><span class="txt"><span class="dt"><span class="t">어바웃펫 배송 상품</span></span></span></label>
								<div class="box">
									<div class="gage">
										<div class="inf">
											<input type="hidden" id="apetDlvrcBuyPrc" value="${cart.dlvrcBuyPrc}" />
											<em class="pp" id="noneDlvrBar">👀 <b class="p"><frame:num data="${cart.dlvrcBuyPrc}"/></b><i class="w">원</i></em> <span class="tt">이상 무료배송</span>
											<em class="pp" id="fullDlvrBar" style="display:none;">🚚 <b class="p">무료배송</b></em>
											<em class="pp" id="addDlvrBar" style="display:none;">💸 <b class="p"></b><i class="w">원 이상</i></em> <span class="tt" style="display:none;">추가하면 무료배송!</span>
											<span class="prc"><em class="p"><frame:num data="${cart.dlvrcBuyPrc}" /></em><i class="w">원</i></span>
										</div>
										<div class="bar">
											<em class="b" id="apetBar" style="width: 0%;"></em>
										</div>
									</div>
								</div>
							</div>
					</c:if>
					
					<!-- 업체 -->
					<c:if test="${cart.compGbCd eq frontConstants.COMP_GB_20}">
						<c:if test="${onceCompGb20 eq 'N' }">
						<c:set var="onceCompGb20" value="Y" />
						<section class="sect etc">
							<div class="hdd">
								<div class="dt t02"><span class="t">업체 배송 상품</span></div>
							</div>
						</c:if>
						
						<div class="store">
							<label class="checkbox"><input type="checkbox" id="chkCompNo${cart.compNo}" value="${cart.compNo }" data-comp-no="${cart.compNo }" ${compCnt ne 0 and compCnt eq compChkCnt ? 'checked="checked"' :''}><span class="txt"><span class="t">${cart.compNm }</span></span></label>
						</div>
					</c:if>
						<ui class="cartlist" id="cartList${cart.compNo}"
								data-comp-no="${cart.compNo}">
					</c:if>
					
						<c:set var="cart" value="${cart}" scope="request"/>
						<jsp:include page="/WEB-INF/view/order/include/incOrderGoods.jsp"/>	
					<c:if test="${idx.last or (cartList[idx.index+1].compNo ne cart.compNo)}">
						</ui>
						
						<div class="totset" >
							<div class="ptt">
								<em class="p" id="compTotalGoodsAmt${cart.compNo}">0</em><i class="w">원</i>
								<i class="e">+</i>
								<b class="t">배송비</b><em class="p" id="compTotalDlvrAmt${cart.compNo}">0</em><i class="w">원</i>
								<i class="e q">=</i>
								<em class="prc"><em class="p" id="compTotalAmt${cart.compNo}">0</em><i class="w">원</i></em>
							</div>
							<div class="gud">장바구니에 담은 상품의 합계금액 입니다.</div>
						</div>
						<c:if test="${cart.compGbCd eq frontConstants.COMP_GB_10}">
							<div class="recoms" style="display: none;">
								<div class="hdts">
									<span class="tit">🚚<em class="p"></em><i class="w">원 이상</i>추가하면 무료배송!</span>
									<span class="txt">지금 함께 구매하면 무료로 배송해드려요.</span>
								</div>
								<div class="cdts">
									<div class="ui_cartrcm_slide">
									</div>
								</div>
							</div>
						
						</c:if>
					<c:if test="${idx.last or (cartList[idx.index+1].compGbCd ne cart.compGbCd)}">
					</section>
					</c:if>
					</c:if>
					
					<c:set var="chkCompGbCd" value="${cart.compGbCd }" />
					<c:set var="chkCompNo" value="${cart.compNo }" />
				</c:forEach>
				
				<c:forEach var="dlvrc" items="${dlvrcList}"> 
				<input type="hidden" name="dlvrcPlcAmt" data-dlvrc-plc-no="${dlvrc.dlvrcPlcNo}" data-comp-no="${dlvrc.compNo}" data-sale-psb-cd="${dlvrc.salePsbCd}" id="dlvrcPlcAmt${dlvrc.dlvrcPlcNo}" value="0"/>
				<input type="hidden" name="dlvrcPlcChkAmt" data-dlvrc-plc-no="${dlvrc.dlvrcPlcNo}" data-comp-no="${dlvrc.compNo}" data-sale-psb-cd="${dlvrc.salePsbCd}" id="dlvrcPlcChkAmt${dlvrc.dlvrcPlcNo}" value="0"/>
				</c:forEach>
				
				<div class="cartOrdr">
					<div class="ctinr">
						<div class="odbox">
							<div class="hdt"><span class="tit">결제 금액</span></div>
							<ul class="prcset">
								<li>
									<div class="dt">상품금액</div>
									<div class="dd">
										<span class="prc"><em class="p" id="totalChkGoodsAmt">0</em><i class="w">원</i></span>
									</div>
								</li>
								<!-- <li>
									<div class="dt">할인금액</div>
									<div class="dd">
										<span class="prc dis"><em class="p" id="totalChkDcAmt">-0</em><i class="w">원</i></span>
									</div>
								</li> -->
								<li>
									<div class="dt">배송비</div>
									<div class="dd">
										<span class="prc"><em class="p" id="totalChkDlvrAmt">0</em><i class="w">원</i></span>
									</div>
								</li>
							</ul>
							<div class="tot">
								<div class="dt">최종 결제금액</div>
								<div class="dd">
									<span class="prc"><em class="p" id="totalChkAmt">0</em><i class="w">원</i></span>
								</div>
							</div>
						</div>
						<div class="btntot">
							<div class="inr">
								<a href="javascript:void(0);" class="btn lg a btnOrder" data-content="" onclick="directOrderSelectFunc(${session.isLogin()});" data-url="${view.stDomain}/order/indexOrderPayment">
									<em class="p">총</em> <i class="i" id="goodsOrdCntText">0</i><em class="s">개</em>
									<em class="prc"><i class="i" id="totalChkAmtText">0</i><i class="s">원</i></em>
									<em class="p" id="orderBtnText">주문하기</em>
								</a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		</c:when>
		<c:otherwise>
		<section class="nodata">
			<div class="inr">
				<div class="msg">장바구니에 담긴 상품이 <br> 없습니다.</div>
				<div class="bts">
					<a href="/shop/home/" class="btnGoShop" data-content="" data-url="/shop/home/" ><spring:message code='front.web.view.new.menu.store'/> 쇼핑하러 가기</a>
				</div>
			</div>
		</section>
	</c:otherwise>
	</c:choose>
	</form>