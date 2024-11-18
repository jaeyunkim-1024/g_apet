<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<script type="text/javascript">
	$(document).ready(function() {
		$(document).off("click", "[data-ui-tog='btn']");
		ui.tog.init();
		var ui_tog_val;
		//쿠폰 적용 변경
		$("input[name^=rdb_cpupon]").on("change", function(){
			
			//상품 쿠폰일 경우 상품 정보 변경
			if($(this).is("input[name^=rdb_cpupon_a]")){
				var cartId = $(this).data("cartId");
				var curSelMbrCpNo = $(this).val();
				var saleAmt = Number($("#goodsCoupon"+cartId).find("input[name=saleAmt]").val());
				var totCpDcAmt = Number($(this).siblings("input[name=totCpDcAmt]").val());
				
				$("#goodsDcAmt"+cartId).text(format.num(totCpDcAmt));
				$("#goodsTotalAmt"+cartId).text(format.num(saleAmt - totCpDcAmt));
				
				if('${frontConstants.CP_POP_TP_ORD}' == "${param.cpPopTp}"){
					$(this).siblings(".txt").find(".hdd .msg").hide();
				}
				
				// 선택한 상품 쿠폰 다른 상품쿠폰에서 제외
				if('${frontConstants.CP_POP_TP_ORD}' == "${param.cpPopTp}"){
					//선택한 쿠폰 다른상품쪽에서 제외
					var curCoupon = $("input[name^=rdb_cpupon_a]:checked").filter(function(){
						return $(this).val() && $(this).val() == curSelMbrCpNo && $(this).data("cartId") != cartId;
					});
					
					if(curCoupon.length > 0){
						$("#noAplGoodsBtn"+curCoupon.data("cartId")).prop('checked', true);
						curCoupon.siblings(".txt").find(".hdd .msg").hide();
					}
					
					var chkArray = new Array();
					$.each($("input[name^=rdb_cpupon_a]"), function(){
						var selMbrCpNo = $(this).val();
						
						if($.inArray(selMbrCpNo ,chkArray) == -1){
							
							var selMbrCpList = $("input[name^=rdb_cpupon_a]").filter(function(){
								return $(this).val() && $(this).val() == selMbrCpNo;
							});
							
							var chk = selMbrCpList.filter(function(){
								return $(this).prop("checked");
							});
							
							if(chk.length > 0){
								selMbrCpList.each(function(){
									if(!$(this).prop("checked")){
										$(this).siblings(".txt").find(".hdd .msg").show();
									}
								})
							}else{
								selMbrCpList.siblings(".txt").find(".hdd .msg").hide();
							}
						}
						chkArray.push(selMbrCpNo);
					});
					
					couponPop.changeDlvrcCoupon();
				}
				
				ui_tog_val = "tog_cpn_warn"+cartId;
			}else if($(this).is("input[name^=rdb_cpupon_b]")){
				ui_tog_val = "tog_cpn_warn_cart";
			}else{
				ui_tog_val = "tog_cpn_warn_dlvrc";
			}
			
			couponPop.setTotalInfo();
			couponPop.checkAplOptimalCoupon();
			//이용안내
			var notice = $(this).siblings("input[name=notice]").val();
			$(this).closest(".sect").find(".warn").find(".cdt").html(notice);
			
			if(!notice){
				ui.tog.close(ui_tog_val);
				$("button.tog").filter(function(){
					return $(this).data("uiTogVal") == ui_tog_val;
				}).prop("disabled", true);
			}else{
				$("button.tog").filter(function(){
					return $(this).data("uiTogVal") == ui_tog_val;
				}).prop("disabled", false);
			}
		});
		
		couponPop.init();
		couponPop.changeDlvrcCoupon();
		couponPop.checkAplOptimalCoupon();
	});
	
	var couponPop = {
		target :$("#couponPop")
		, init : function(){
			$("input[name^=rdb_cpupon_a]:checked").each(function(){
				var cartId = $(this).data("cartId");
				
				var saleAmt = Number($("#goodsCoupon"+cartId).find("input[name=saleAmt]").val());
				var totCpDcAmt = Number($(this).siblings("input[name=totCpDcAmt]").val());
				
				$("#goodsDcAmt"+cartId).text(format.num(totCpDcAmt));
				$("#goodsTotalAmt"+cartId).text(format.num(saleAmt - totCpDcAmt));
			});
			
			couponPop.setTotalInfo();
		}
		//할인쿠폰 적용	
		,aplCoupon : function(){
			
			//callback DATA SET
			var data = new Array();
			$.each(couponPop.target.find(".list"), function(idx, goodsCoupon){
				var chkCoupon = $(goodsCoupon).find("input[name^=rdb_cpupon_a]:checked");
				
				var coupon = {
					cpKindCd : '${frontConstants.CP_KIND_10}'
					,selMbrCpNo : chkCoupon.val()
					,cartId : chkCoupon.data("cartId")
					,cpNo : chkCoupon.siblings("input[name=cpNo]").val()
					,cpDcAmt : chkCoupon.siblings("input[name=cpDcAmt]").val()
					,totCpDcAmt : chkCoupon.siblings("input[name=totCpDcAmt]").val()
				}
				data.push(coupon);
			});
			
			//장바구니 쿠폰 할인 총 금액
			$.each(couponPop.target.find("#cart"), function(idx, cartCoupon){
				var chkCoupon = $(cartCoupon).find("input[name=rdb_cpupon_b]:checked");
				
				var coupon = {
					cpKindCd : '${frontConstants.CP_KIND_20}'
					,selMbrCpNo : chkCoupon.val()
					,cpNo : chkCoupon.siblings("input[name=cpNo]").val()
					,totCpDcAmt : chkCoupon.siblings("input[name=aplDcAmt]").val()
					,minBuyAmt  : chkCoupon.siblings("input[name=minBuyAmt]").val()
				}
				data.push(coupon);
			});
			
			//배송비 쿠폰 할인 총 금액
			$.each(couponPop.target.find("#dlvrc"), function(idx, dlvrcCoupon){
				var chkCoupon = $(dlvrcCoupon).find("input[name=rdb_cpupon_c]:checked");
				
				var coupon = {
					cpKindCd : '${frontConstants.CP_KIND_30}'
					,selMbrCpNo : chkCoupon.val()
					,dlvrcPlcNo : couponPop.target.find("#dlvrc input[name=dlvrcPlcNo]").val()
					,cpNo : chkCoupon.siblings("input[name=cpNo]").val()
					,totCpDcAmt : chkCoupon.siblings("input[name=aplDcAmt]").val()
				}
				data.push(coupon);
			});
			
			ui.popLayer.close("popCoupon", {
				ccb : function(){
					<c:out value="${param.callBackFnc}" />(data);
				}
			});
		}
		, setTotalInfo : function(){
			
			//상품 쿠폰 할인 총금액
			var goodsTotalDcAmt = 0;
			$.each(couponPop.target.find(".list"), function(idx, goodsCoupon){
				var chkCoupon = $(goodsCoupon).find("input[name^=rdb_cpupon_a]:checked");
				
				goodsTotalDcAmt += Number(chkCoupon.siblings("input[name=totCpDcAmt]").val());
			});
			
			//장바구니 쿠폰 할인 총 금액
			var cartTotalDcAmt = 0;
			$.each(couponPop.target.find("#cart"), function(idx, cartCoupon){
				var chkCoupon = $(cartCoupon).find("input[name=rdb_cpupon_b]:checked");
				
				cartTotalDcAmt += Number(chkCoupon.siblings("input[name=aplDcAmt]").val());
			});
			
			//배송비 쿠폰 할인 총 금액
			var dlvrcTotalDcAmt = 0;
			$.each(couponPop.target.find("#dlvrc"), function(idx, dlvrcCoupon){
				var chkCoupon = $(dlvrcCoupon).find("input[name=rdb_cpupon_c]:checked");
				
				dlvrcTotalDcAmt += Number(chkCoupon.siblings("input[name=aplDcAmt]").val());
			});
			
			
			var totalDcAmt = goodsTotalDcAmt + cartTotalDcAmt + dlvrcTotalDcAmt;
			
			if(totalDcAmt == 0){
				couponPop.target.find(".btnCpAply").html("할인 쿠폰 적용");
			}else{
				couponPop.target.find(".btnCpAply").html('총 <i class="n">'+"-"+format.num(totalDcAmt)+'</i>원 할인 쿠폰 적용');
			}
		}
		
		//최대 할인 적용 체크박스
		, aplOptimalCoupon : function(obj){
			if($(obj).prop("checked")){
				//상품 쿠폰
				$.each($(".info[id^=goodsCoupon]"), function(idx, obj){
					var $cart = $(obj);
					var optimalMbrCpNo = $cart.find("input[name=optimalMbrCpNo]").val();
					var $cpList = $cart.next(".list").find(".cplist");
					
					$cpList.find("input[type=radio]").filter(function(){
						return $(this).val() == optimalMbrCpNo;
					}).prop("checked", true).trigger("change");
				});
				
				$("input[name=rdb_cpupon_b]").eq(0).prop("checked", true).trigger("change");
				
				var optimalDlvrCoupon = $("input[name=rdb_cpupon_c]").eq(0);
				if(!optimalDlvrCoupon.is(":disabled")){
					$("input[name=rdb_cpupon_c]").eq(0).prop("checked", true).trigger("change");
				}
			}
		}
		, checkAplOptimalCoupon : function(){
			var isChkAplOptimal = true;
			//상품 쿠폰 최적 체크
			$.each($(".info[id^=goodsCoupon]"), function(idx, obj){
				var $cart = $(obj);
				var optimalMbrCpNo = $cart.find("input[name=optimalMbrCpNo]").val();
				var $cpList = $cart.next(".list").find(".cplist");
				
				var chkMbrCpNo = $cpList.find("input[type=radio]:checked").val();
				
				if(chkMbrCpNo != optimalMbrCpNo){
					isChkAplOptimal = false;
					return false;
				}
			});
			
			
			//장바구니 쿠폰 최적 체크
			if(isChkAplOptimal){
				var $optimalCartCoupon;
				$.each(couponPop.target.find("#cart").find("input[name=rdb_cpupon_b]"), function(idx, cartCoupon){
					if(idx == 0){
						$optimalCartCoupon = $(cartCoupon);
					}
				});
				
				var $chkCoupon = couponPop.target.find("input[name=rdb_cpupon_b]:checked");
				
				if($optimalCartCoupon && $optimalCartCoupon.val() != $chkCoupon.val()){
					isChkAplOptimal = false;
				}
			}
			
			
			//배송비 쿠폰 최적 체크
			if(isChkAplOptimal){
				var $optimalDlvrcCoupon;
				$.each(couponPop.target.find("#dlvrc").find("input[name=rdb_cpupon_c]"), function(idx, dlvrcCoupon){
					if(!$(this).is(":disabled") && !$optimalDlvrcCoupon){
						$optimalDlvrcCoupon = $(dlvrcCoupon);
					}
				});
				
				var $chkCoupon = couponPop.target.find("input[name=rdb_cpupon_c]:checked");
				
				if($optimalDlvrcCoupon && $optimalDlvrcCoupon.val() && $optimalDlvrcCoupon.val() != $chkCoupon.val()){
					isChkAplOptimal = false;
				}
			}
			
			$("#aplOptimalChk").prop("checked", isChkAplOptimal);
		}
		, changeDlvrcCoupon : function(){
			if(couponPop.target.find("#dlvrc").length > 0){
				var stdBuyPrc = parseInt(couponPop.target.find("#dlvrc input[name=buyPrc]").val());
				
				var totalStdAmt = 0;
				
				if (couponPop.target.find(".info[id^=goodsCoupon]").length == 0) { // 상품 쿠폰이 존재하지 않을 경우, 총 기준 금액 세팅
					$.each(couponPop.target.find("input[name=cartId]"), function(idx, obj){
						var cartId = $(obj).val();
						var goodsAmt = parseInt($("#saleAmt"+cartId).val());
						
						totalStdAmt += goodsAmt;
					});
				} else { // 상품 쿠폰이 존재할 경우, 총 기준 금액 세팅
					$.each(couponPop.target.find(".info[id^=goodsCoupon]"), function(idx, obj){
						if($(obj).find("input[name=compGbCd]").val() == '${frontConstants.COMP_GB_10}'){
							var cartId = $(obj).find("input[name=cartId]").val();
							var goodsAmt = parseInt($(obj).find("input[name=saleAmt]").val());
							
							var chkCoupon = $(obj).next(".list").find(":radio").filter(function(){
								return $(this).prop("checked");
							});
							
							var totCpDcAmt = parseInt(chkCoupon.siblings("input[name=totCpDcAmt]").val());
							
							totalStdAmt += goodsAmt - totCpDcAmt;
						}
					});
				}
				
				console.log('totalStdAmt', totalStdAmt);
				var dlvrcRdo = couponPop.target.find("input[name=rdb_cpupon_c]");
				
				var isDisabledDlvrc = false;
				var orgDlvrAmt = couponPop.target.find("#dlvrc").find("input[name=orgDlvrAmt]").val();
				if(orgDlvrAmt == 0){
					dlvrcRdo.not("#noAplDlvrcBtn").prop("disabled", true);
					dlvrcRdo.not("#noAplDlvrcBtn").parent().parent("li").addClass("disabled");
				}else{
					//주문 당 부여 - 4만원 이상 무료 -배송정책 조건 체크
					if(couponPop.target.find("#dlvrc input[name=dlvrcCdtStdCd]").val() == '${frontConstants.DLVRC_CDT_20}'){
						if(totalStdAmt >= stdBuyPrc){
							//무료 배송
							dlvrcRdo.prop("checked", false);
							dlvrcRdo.prop("disabled", true);
							dlvrcRdo.parent().parent("li").addClass("disabled");
							couponPop.target.find("#noAplDlvrcBtn").prop("checked", true);
							isDisabledDlvrc = true;
						}else{
							dlvrcRdo.prop("disabled", false);
							dlvrcRdo.parent().parent("li").removeClass("disabled");
						}
					}
					
					//배송비 최소 구매금액 계산
					if(!isDisabledDlvrc){
						dlvrcRdo.not("#noAplDlvrcBtn").each(function(){
							var minBuyAmt = parseInt($(this).siblings("input[name=minBuyAmt]").val());
							if(totalStdAmt < minBuyAmt){
								$(this).prop("disabled", true);
								$(this).parent().parent("li").addClass("disabled");
								if($(this).prop("checked")){
									couponPop.target.find("#noAplDlvrcBtn").prop("checked", true);
								}
							}else{
								$(this).prop("disabled", false);
								$(this).parent().parent("li").removeClass("disabled");
							}
						});
					}
				}
				
				
			}
		}
	}
</script>


<div class="pbd" id="couponPop">
	<div class="phd">
		<div class="in">
			<h1 class="tit">쿠폰적용</h1>
			<button type="button" class="btnPopClose" data-content="" data-url="">닫기</button>
		</div>
	</div>
	<div class="pct">
		<main class="poptents">
			<div class="aplycpn">
				<label class="checkbox"><input type="checkbox" id="aplOptimalChk" onclick="couponPop.aplOptimalCoupon(this);"><span class="txt">최대 할인 쿠폰 적용</span></label>
			</div>
			<c:forEach var="cart" items="${localGoodsCouponList}" >
				<c:choose>
					<c:when test="${fn:length(cart.couponList) > 0 }">
						<c:set var="cart" value="${cart}" scope="request"/>
						<jsp:include page="/WEB-INF/view/order/include/incPopupGoodsCoupon.jsp"/>	
					</c:when>
					<c:otherwise>
						<input type="hidden" name="cartId" value="${cart.cartId}"/>
						<input type="hidden" id="saleAmt${cart.cartId}" name="saleAmt" value="${(cart.salePrc - cart.prmtDcAmt) * cart.buyQty }"/>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			
			<c:if test="${not empty dlvrcCoupon && fn:length(dlvrcCoupon.couponList) > 0}" >
				<section class="sect cart" id="dlvrc">
					<div class="htt"><span class="tit">배송비 할인 쿠폰</span></div>
					<ui class="cplist">
						<c:set var="isSelectDlvrc" value="false"/>
						<c:set var="selNotice" value=""/>
						<input type="hidden" name="dlvrcPlcNo" value="${dlvrcCoupon.dlvrcPlcNo}">
						<input type="hidden" name="dlvrcCdtStdCd" value="${localDlvrcPlc.dlvrcCdtStdCd}">
						<input type="hidden" name="buyPrc" value="${localDlvrcPlc.buyPrc}">
						<input type="hidden" name="dlvrAmt" value="${localDlvrcPlc.dlvrAmt}">
						<input type="hidden" name="orgDlvrAmt"  value="${dlvrcSO.dlvrAmt}">
						<c:forEach var="coupon" items="${dlvrcCoupon.couponList}" >
							<c:if test="${coupon.isSelected() }">
								<c:set var="isSelectDlvrc" value="true"/>
								<c:set var="selNotice" value="${coupon.notice}"/>
							</c:if>
							<li>
								<label class="radio">
									<input type="hidden" name="cpNo" value="${coupon.cpNo}">
									<input type="hidden" name="aplDcAmt" value="${coupon.aplDcAmt}">
									<input type="hidden" name="notice"  value='<c:out value="${coupon.notice}"/>'>
									<input type="hidden" name="minBuyAmt" value="${coupon.minBuyAmt}" >
									<input type="hidden" name="aplVal"  value="${coupon.aplVal}">
									<input type="radio" name="rdb_cpupon_c" value="${coupon.mbrCpNo}" ${coupon.isSelected() ? ' checked' : ''}>
									
									<div class="txt">
										<div class="hdd">
											<em class="amt"><em class="p">${coupon.aplVal }</em><i class="w">%</i></em>
											<em class="prc"><em class="p"><frame:num data="${localDlvrcPlc.dlvrAmt }"/></em><i class="w">원</i></em>
										</div>
										<div class="cdd">
											<div class="dt">${coupon.cpNm }</div>
											<c:if test="${(not empty coupon.minBuyAmt && coupon.minBuyAmt > 0 ) or (coupon.cpAplCd eq frontConstants.CP_APL_10 && coupon.maxDcAmt > 0)}">
												<div class="dd">
													<c:if test="${not empty coupon.minBuyAmt && coupon.minBuyAmt > 0}">
														최소 <frame:num data="${coupon.minBuyAmt}"/>원 이상 구매시
													</c:if>
													<c:if test="${coupon.cpAplCd eq frontConstants.CP_APL_10 && coupon.maxDcAmt > 0}">
														최대 <frame:num data="${coupon.maxDcAmt}"/>원 할인
													</c:if>
												</div>
											</c:if>
										</div>
									</div>
								</label>
							</li>
						</c:forEach>
						<li>
							<label class="radio">
								<input type="hidden" name="aplDcAmt" value="0">
								<input type="radio" name="rdb_cpupon_c" id="noAplDlvrcBtn" ${!isSelectDlvrc ? 'checked' : ''} value ="">
								<div class="txt">
									<div class="hdd">
										<em class="amt"><em class="t">적용안함</em></em>
									</div>
								</div>
							</label>
						</li>
					</ui>
					<c:if test="${frontConstants.CP_POP_TP_CART eq param.cpPopTp}">
					<section class="sect warn">
						<div class="hdt">
							<span class="tit">이용안내</span>
							<button type="button" data-ui-tog="btn" data-ui-tog-val="tog_cpn_warn_dlvrc" class="bt tog" data-content="" data-url="" ${empty selNotice ? 'disabled' : '' }>더보기</button>
						</div>
						<div class="cdt" data-ui-tog="ctn" data-ui-tog-val="tog_cpn_warn_dlvrc">
							<c:out value="${selNotice }" escapeXml="false"/>
						</div>
					</section>
					</c:if>
				</section>
			</c:if>
			
			<c:forEach var="cart" items="${compGoodsCouponList}" >
				<c:if test="${fn:length(cart.couponList) > 0 }">
					<c:set var="cart" value="${cart}" scope="request"/>
					<jsp:include page="/WEB-INF/view/order/include/incPopupGoodsCoupon.jsp"/>	
				</c:if>
			</c:forEach>
			
			<c:if test="${fn:length(cartCouponList) > 0 }" >
				<section class="sect cart" id="cart">
					<div class="htt"><span class="tit">장바구니 할인 쿠폰</span></div>
					<ui class="cplist">
						<c:set var="isSelectCart" value="false"/>
						<c:set var="selNotice" value=""/>
						<c:forEach var="coupon" items="${cartCouponList}" >
							<c:if test="${coupon.isSelected() }">
								<c:set var="isSelectCart" value="true"/>
								<c:set var="selNotice" value="${coupon.notice}"/>
							</c:if>
							<li>
								<label class="radio">
									<input type="hidden" name="cpNo" value="${coupon.cpNo}">
									<input type="hidden" name="aplDcAmt" value="${coupon.aplDcAmt}">
									<input type="hidden" name="notice"  value='<c:out value="${coupon.notice}"/>'>
									<input type="hidden" name="minBuyAmt" value="${coupon.minBuyAmt}" >
									<input type="radio" name="rdb_cpupon_b" value="${coupon.mbrCpNo}" ${coupon.isSelected() ? 'checked' : ''}>
									
									<div class="txt">
										<div class="hdd">
											<c:choose>
												<c:when test="${coupon.cpAplCd eq frontConstants.CP_APL_10 }">
													<em class="amt"><em class="p">${coupon.aplVal }</em><i class="w">%</i></em>
													<em class="prc"><em class="p"><frame:num data="${coupon.aplDcAmt }"/></em><i class="w">원</i></em>
												</c:when>
												<c:otherwise>
													<em class="prc"><em class="p"><frame:num data="${coupon.aplDcAmt }"/></em><i class="w">원</i></em>
												</c:otherwise>
											</c:choose>
										</div>
										<div class="cdd">
											<div class="dt">${coupon.cpNm }</div>
											<c:if test="${(not empty coupon.minBuyAmt && coupon.minBuyAmt > 0 ) or (coupon.cpAplCd eq frontConstants.CP_APL_10 && coupon.maxDcAmt > 0)}">
												<div class="dd">
													<c:if test="${not empty coupon.minBuyAmt && coupon.minBuyAmt > 0}">
														최소 <frame:num data="${coupon.minBuyAmt}"/>원 이상 구매시
													</c:if>
													<c:if test="${coupon.cpAplCd eq frontConstants.CP_APL_10 && coupon.maxDcAmt > 0}">
														최대 <frame:num data="${coupon.maxDcAmt}"/>원 할인
													</c:if>
												</div>
											</c:if>
										</div>
									</div>
								</label>
							</li>
						</c:forEach>
						<li>
							<label class="radio">
								<input type="hidden" name="aplDcAmt" value="0">
								<input type="radio" name="rdb_cpupon_b" id="noAplCartBtn" ${!isSelectCart ? 'checked' : ''} value ="">
								<div class="txt">
									<div class="hdd">
										<em class="amt"><em class="t">적용안함</em></em>
									</div>
								</div>
							</label>
						</li>
					</ui>
					<c:if test="${frontConstants.CP_POP_TP_CART eq param.cpPopTp}">
					<section class="sect warn">
						<div class="hdt">
							<span class="tit">이용안내</span>
							<button type="button" data-ui-tog="btn" data-ui-tog-val="tog_cpn_warn_cart" class="bt tog" data-content="" data-url="" ${empty selNotice ? 'disabled' : '' }>더보기</button>
						</div>
						<div class="cdt" data-ui-tog="ctn" data-ui-tog-val="tog_cpn_warn_cart">
							<c:out value="${selNotice }" escapeXml="false"/>
						</div>
					</section>
					</c:if>
				</section>
			</c:if>
		</main>
	</div>
	<div class="pbt">
		<div class="bts">
			<button type="button" class="btn xl a btnCpAply" onclick="couponPop.aplCoupon();" data-content="" data-url="${view.stDomain}/order/indexCartList">총 <i class="n" id="coponDcTotalInfo"></i>원 할인 쿠폰 적용</button>
		</div>
	</div>
</div>
