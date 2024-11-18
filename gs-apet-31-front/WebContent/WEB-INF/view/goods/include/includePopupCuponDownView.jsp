<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>

<script type="text/javascript">
	var pageLoaded = 1; //현재 페이지
	$(document).ready(function(){
		$("body").off("click", ".cupon-list .btn-down").on("click", ".cupon-list .btn-down", function(e) {
			let $this = $(this);
			if(!$this.closest("li").hasClass("disabled")) {
				var cpNo = $this.data("cpn-no");
				console.log("cpNo : "+cpNo);
				fnCouponDownload(cpNo);
			}else{
				console.log("다운 불가!");
			}
		});

		var selectPop = $("#popCpnGetContents").find("select[name='select_pop_123']");
		// 전시카테고리 검색조건
		$(document).on("change", "select[name='select_pop_123']", function(e) {
			console.log("select_pop_123 click id : " + this.id + ", value : " + this.value);
			fnCouponInfo(this.value, 0);
		});

	}); // End Ready

	// 이용안내 문구 함수
	function fnCouponNotice(notice){
		ui.popBot.open('popCpnGud');
		$("#popCouponGuide").html("");
		$("#popCouponGuide").html(notice);
	}

	// 쿠폰 리스트 호출
	function fnCouponInfo(searchGoodsId, page){
		pageLoaded = page;
		$("#couponTargetGoodsId").val(searchGoodsId);
		var goodsId = $("#couponGoodsId").val();
		console.log("goodsId : " + goodsId + ", searchGoodsId : " + searchGoodsId);
		$("#divCouponMoreload").remove();
		var popCpnGetContents = "";
		if(page > 0){
			popCpnGetContents = $("#popCpnGetContents").html();
		}
		var options = {
			url : "/goods/indexPopupCuponDownView.do"
			,data : {goodsId : goodsId, searchGoodsId : searchGoodsId, page : (Number(page) + 1)}
			,dataType : "html"
			,async : true
			, done: function(result) {
				console.log("result : " + result.length);
				$("#popCpnGetContents").html(popCpnGetContents + result);
			}
		};
		ajax.call(options);
		ui.popLayer.open("popCpnGet");
	}

	// 단일 쿠폰 다운로드
	function fnCouponDownload(cpNo){
		var searchGoodsId = $("#couponTargetGoodsId").val();
		var goodsId = $("#couponGoodsId").val();
		console.log("goodsId : " + goodsId + ", searchGoodsId : " + searchGoodsId);
		if(goodsId != ""){
			var options = {
				url : "/goods/indexPopupCuponDown.do"
				,data : {goodsId : goodsId, searchGoodsId : searchGoodsId, cpNo : cpNo}
				,dataType : "html"
				,async : true
				, done: function(result) {
					$("#popCpnGetContents").html("");
					$("#popCpnGetContents").html(result);
				}
			};
			ajax.call(options);
		}else{
			console.log("goodsId가 존재하지 않습니다. ")
		}
	}

	// 전체 쿠폰 다운로드
	function fnCouponTotalDownload(){
		var isCouponMember = $("#popCpnGetContents").find("input[name='isCouponMember']").val();
		// var selectPop = $("#popCpnGetContents").find("select[name='select_pop_123']").val();
		console.log("isCouponMember : " + isCouponMember);
		// console.log("selectPop : " + selectPop);
		if(isCouponMember <= 0){
			alert("다운받을 쿠폰이 존재하지 않습니다.");
			return ;
		}
		var searchGoodsId = $("#couponTargetGoodsId").val();
		var goodsId = $("#couponGoodsId").val();
		console.log("goodsId : " + goodsId + ", searchGoodsId : " + searchGoodsId);
		if(goodsId != ""){
			var options = {
				url : "/goods/indexPopupCuponDownTotal.do"
				,data : {goodsId : goodsId, searchGoodsId : searchGoodsId}
				,dataType : "html"
				,async : true
				, done: function(result) {
					$("#popCpnGetContents").html("");
					$("#popCpnGetContents").html(result);
				}
			};
			ajax.call(options);
		}else{
			console.log("goodsId가 존재하지 않습니다. ")
		}
	}

</script>
<style>

	.popLayer.popLayer.popCpnGet .pbd .moreload{text-align: center;position: relative;margin-top: 21px;}
	.popLayer.popLayer.popCpnGet .pbd .moreload::after{content:"";display:block;background:#ecedef;height:1px;position:absolute;left:0;top:50%;right: 0;z-index: 0;}
	.popLayer.popLayer.popCpnGet .pbd .moreload .bt.more{height:32px;border:1px solid #ecedef;border-radius: 40px;box-shadow: rgba(0,0,0,0.05) 1px 1px 2px;font-size: 13rem;color: #666666;text-align: center;padding: 0px 15px 2px;position: relative;z-index: 10;background: #ffffff;line-height: 1;}
	.popLayer.popLayer.popCpnGet .pbd .moreload .bt.more::after{width:13px;height:12px;background:url(../../_images/shop/icon_list_more@2x.png) no-repeat center;margin-left: 2px;content:"";display:inline-block;vertical-align:middle;background-size: 13px;margin-top: -2px;margin-right: -5px;}

</style>
<input type="hidden" name="couponTargetGoodsId" id="couponTargetGoodsId" value="" />
<input type="hidden" name="couponGoodsId" id="couponGoodsId" value="${goods.goodsId}" />
<!-- 쿠폰적용 전체 덮는크기 -->
<article class="popLayer a popCpnGet" id="popCpnGet">
	<div class="pbd">
		<div class="phd">
			<div class="in">
				<h1 class="tit">쿠폰받기</h1>
				<button type="button" class="btnPopClose">닫기</button>
			</div>
		</div>
		<div class="pct" id="popCpnGetContents">

<%--			<div class="moreload">--%>
<%--				<button type="button" class="bt more" id="goodsMore">상품 더보기</button>--%>
<%--			</div>--%>

		</div>

		<div class="pbt">
			<div class="bts">
				<button type="button" class="btn xl a btnGet" onclick="fnCouponTotalDownload()" id="btnGoodsCouponTotalDown">쿠폰 모두 받기</button>
			</div>
		</div>
	</div>
</article>
<!-- 쿠폰이용안내 -->
<article class="popBot popCpnGud" id="popCpnGud">
	<div class="pbd">
		<div class="phd">
			<div class="in">
				<h1 class="tit">이용안내</h1>
				<button type="button" class="btnPopClose">닫기</button>
			</div>
		</div>
		<div class="pct">
			<main class="poptents" id="popCouponGuide">

			</main>
		</div>
	</div>
</article>

