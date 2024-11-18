<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="front.web.config.constants.FrontWebConstants"%>
<%@ page import="framework.common.enums.ImageGoodsSize" %>

<tiles:insertDefinition name="common_my_mo">
<tiles:putAttribute name="script.include" value="script.order"/>
<tiles:putAttribute name="script.inline">
	<script type="text/javascript" 	src="/_script/cart/cart.js"></script>
	<script>
		(function(j,en,ni,fer) {
			j['dmndata']=[];j['jenniferFront']=function(args){window.dmndata.push(args)};
			j['dmnaid']=fer;j['dmnatime']=new Date();j['dmnanocookie']=false;j['dmnajennifer']='JENNIFER_FRONT@INTG';
			var b=Math.floor(new Date().getTime() / 60000) * 60000;var a=en.createElement(ni);
			a.src='https://d-collect.jennifersoft.com/'+fer+'/demian.js?'+b;a.async=true;
			en.getElementsByTagName(ni)[0].parentNode.appendChild(a);
			}(window,document,'script','73848c73'));
	</script>
	
	<script type="text/javascript">
	<c:if test="${view.deviceGb ne 'PC'}">
		$(function(){
			$($("#header_pc").find('.tit')).text('장바구니');
			$('.mo-header-backNtn').attr('onclick', 'goBack();');
		});
	</c:if>

		$(function(){
			cartGoods.reloadCart(function(){
				ui.init();
			});
		});
		
		function goBack() {
			if("${callParam}" != ""){
				//App & 펫TV 영상상세 화면에서 호출일때만 callParam값이 있다.
				var callParam = "${callParam}";
				var params = callParam.split(".");
				var url = "";
				if(params.length == 3){
					url = "${view.stDomain}/tv/series/indexTvDetail?vdId="+params[0]+"&sortCd=&listGb="+params[1]+"-"+params[2];
				}else{
					url = "${view.stDomain}/tv/series/indexTvDetail?vdId="+params[0]+"&sortCd="+params[1]+"&listGb="+params[2]+"-"+params[3];
				}
				
				// 데이터 세팅
				toNativeData.func = "onNewPage";
				toNativeData.type = "TV";
				toNativeData.url = url;
				// 호출
				toNative(toNativeData);
			}
			
			storageHist.goBack();
		}
		
		// GTM
		var digitalData = digitalData || {};
		var cartInfo = new Array();
		<c:forEach items="${cartList}" var="item">
			var thisProduct = {};
			var thisOpt = new Array();
			thisProduct.name = "${item.goodsNm}";
			thisProduct.id = "${item.goodsId}";
			thisProduct.category = "${item.dispCtgPath}";
			thisProduct.brand = "${item.bndNmKo}";
			thisProduct.quantity = "${item.buyQty}";
			thisProduct.price = "${item.buyAmt}";
			
			//묶음 상품일때 variant 옵션명으로 표시
			if("${item.goodsCstrtTpCd}" == 'PAK'){
				thisProduct.variant = "${item.optGoodsNm}";
			//묶음 상품이 아닐 때  variant 옵션명으로 표시
			}else if("${item.goodsCstrtTpCd}" != 'PAK'){
				<c:forEach items="${item.goodsOptList}" var="opt">
					thisOpt.push("${opt.showNm}:${opt.attrVal}");
				</c:forEach>
				thisProduct.variant = thisOpt.join("/");
				//variant 가 "" 인 경우 상품 아이디로 표시
				if(thisProduct.variant == ''){
					thisProduct.variant = "${item.goodsId}";
				}
			}
			cartInfo.push(thisProduct);		
		</c:forEach>
		digitalData.checkoutInfo = cartInfo;

	</script>
</tiles:putAttribute>
<tiles:putAttribute name="content">
	<main class="container page shop od cart" id="container">
		<div class="pageHeadPc">
			<div class="inr">
				<div class="hdt">
					<h3 class="tit">장바구니</h3>
				</div>
			</div>
		</div>
		<div class="inr">
			<!-- 본문 -->
			<div class="contents" id="contents">
			</div>
		</div>
	</main>
</tiles:putAttribute>
<tiles:putAttribute name="layerPop">
	<article class="popLayer a popCoupon" id="popCoupon">
	</article>
</tiles:putAttribute>
</tiles:insertDefinition>