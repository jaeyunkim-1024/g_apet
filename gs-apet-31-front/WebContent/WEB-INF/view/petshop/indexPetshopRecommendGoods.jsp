<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ page import="front.web.config.constants.FrontWebConstants" %>

<tiles:insertDefinition name="common">
	<tiles:putAttribute name="script.include" value="script.petshop"/>
		<tiles:putAttribute name="script.inline">
		<script type="text/javascript">
			$(document).ready(function(){
				<c:if test="${view.deviceGb ne frontConstants.DEVICE_GB_10 }">	
				$(".mo-heade-tit .tit").html("${cornerList.petNm} 맞춤추천 상품");	
				$(".mo-header-backNtn").attr("onClick", "goPetShopMain();");
				</c:if>
			});	
			
			function pushUrl(otherPetNo) {
				var params = new URLSearchParams(location.search);
				params.set('petNo', otherPetNo);
				var searchParams = params.toString();
				var goUrl = window.location.pathname + "?"+searchParams;
				window.history.replaceState( {data : $("#otherPetGoodsList").html()}, null, goUrl);
			}
			
			function getRecOtherPetGoodsList() {
				page = 1;
				result = true;
				scrollPrevent = true;
				
				var petNos = $("#petNos_rec").val();
				petNos = petNos.replace(petNo,'').replace(',,',',');
				if(petNos.startsWith(',')) {
					petNos = petNos.substr(1);
				}
				var options = {
						url : "<spring:url value='/shop/getRecOtherPetGoodsList' />"
						, type : "GET"
						, dataType : "html"
						, data : {
							dispClsfNo : '${view.dispClsfNo}'
							,dispCornNo : $("#dispCornNo_rec").val()
							,dispClsfCornNo : $("#dispClsfCornNo_rec").val()
							,petNos: petNos
							,mbrNo: '${session.mbrNo}'
							,callGb : 'corner'
							,page : page
							,rows : rows
						}
						, done :function(result){
							$("#otherPetGoodsList").empty();
							$("#otherPetGoodsList").append(result);
							$("#petNo_rec").val($("#otherPetNo").val());
							$("#myPet").text($("#otherPetNm").val());
							$(".mo-heade-tit .tit").html($("#otherPetNm").val()+" 맞춤추천 상품");
							window.scrollTo({top:0, left:0, behavior:'smooth'});
							pushUrl($("#otherPetNo").val());
						}
					};
					ajax.call(options);
			}
		</script>
	</tiles:putAttribute>
	<tiles:putAttribute name="content">
	<!-- 맞춤추천 -->
	<input type="hidden" name="dispCornType" id="dispCornType_rec" value="${frontConstants.GOODS_MAIN_DISP_TYPE_RCOM}"/>
	<input type="hidden" name="dispCornNo" id="dispCornNo_rec" value="${so.dispCornNo}"/>
	<input type="hidden" name="dispClsfCornNo" id="dispClsfCornNo_rec" value="${so.dispClsfCornNo}"/>
	<input type="hidden" name="petNo" id="petNo_rec" value="${so.petNo}"/>
	<input type="hidden" name="petNos" id="petNos_rec" value="${cornerList.petNos}"/>
	<main class="container lnb page shop hm recom" id="container">
		<div class="pageHeadPc lnb">
			<div class="inr">
				<div class="hdt">
					<h3 class="tit"><b class="b" id="myPet">${cornerList.petNm}</b> 맞춤 추천상품</h3>
				</div>
			</div>
		</div>
		<div class="inr">
			<!-- 본문 -->
			<div class="contents" id="contents">
				<section class="sect ct recom">
					<ul class="list k0425" id="otherPetGoodsList">
						<c:forEach var="goods" items="${cornerList.recommendGoodsList}"  varStatus="status" >
						<li>
							<div class="gdset recom" id="recom_${goods.goodsId}">
<%-- 								<c:if test="${goods.intRate > 50}"> --%>
<%-- 								<div class="bdg"><b class="n">${goods.intRate}</b><i class="w">%</i> <b class="t">일치</b></div> --%>
<%-- 								</c:if> --%>
								<div class="thum">
									<a href="/goods/indexGoodsDetail?goodsId=${goods.goodsId}" class="pic" data-content='${goods.goodsId}' data-url="/goods/indexGoodsDetail?goodsId=${goods.goodsId}">
										<img class="img" src="${frame:optImagePath(goods.imgPath, frontConstants.IMG_OPT_QRY_510)}" alt="${goods.goodsNm}" onerror="this.src='../../_images/common/img_default_thumbnail_2@2x.png'">
									</a>
									<button type="button" class="bt zzim ${goods.interestYn eq 'Y' ? 'on' : ''}" data-content='${goods.goodsId}' data-url="/goods/insertWish?goodsId=${goods.goodsId}" data-action="interest" data-yn="N" data-goods-id="${goods.goodsId}" data-target="goods">찜하기</button>
								</div>
								<div class="boxs">
									<div class="tit">
										<a href="/goods/indexGoodsDetail?goodsId=${goods.goodsId}" class="lk" data-content='${goods.goodsId}' data-url="/goods/indexGoodsDetail?goodsId=${goods.goodsId}">${goods.goodsNm}</a>
									</div>
									<a href="/goods/indexGoodsDetail?goodsId=${goods.goodsId}" class="inf" data-content='${goods.goodsId}' data-url="/goods/indexGoodsDetail?goodsId=${goods.goodsId}">
										<span class="prc"><em class="p"><fmt:formatNumber value="${goods.saleAmt}" type="number" pattern="#,###,###"/></em><i class="w">원</i></span>
									</a>
									<c:if test="${not empty goods.goodsTagList}" >
									<div class="tag">
										<c:forEach var="goodsTag" items="${goods.goodsTagList}" begin="0" end="2">
											<a href="/shop/indexPetShopTagGoods?tags=${goodsTag.tagNo}&tagNm=${goodsTag.tagNm}" class="tg">#${goodsTag.tagNm }</a>
										</c:forEach>
									</div>
									</c:if>
								</div>
							</div>
						</li>
						</c:forEach>
					</ul>
					<c:if test="${fn:contains(session.petNos, ',')}">
					<div class="bts bot" style="margin-bottom: 65px;">
						<button type="button" class="bt refresh" onclick="getRecOtherPetGoodsList();">다른 반려동물 추천상품</button>
					</div>
					</c:if>
				</section>
			</div>
		</div>
	</main>
	<jsp:include page="/WEB-INF/tiles/include/floating.jsp">
		<jsp:param name="floating" value="" />
	</jsp:include>
	
	<script>
		var page = 1
		var rows = '${so.rows}';
		var result = true;
		var scrollPrevent = true;
		var deviceGb = "${view.deviceGb}"
		var goodsCount ='${not empty cornerList.goodsCount ? cornerList.goodsCount : 0}'*1;
		var dispClsfNo = '${view.dispClsfNo}'
		var cateCdL = '${so.cateCdL}'
		var petNo = $("#petNo_rec").val();
		
		$(function(){
			$(window).scroll(function(){
				var scrollTop = $(this).scrollTop();
				var both = $(document).innerHeight() - window.innerHeight - ($("#footer").innerHeight() || 0);
				if (both <= (scrollTop +3)) {
					if(result && scrollPrevent){
						var liLength = $("#otherPetGoodsList").children("li").length;
						if((liLength != goodsCount) && (liLength >= rows)){
							page++
							scrollPrevent = false;
							pagingCategoryList(page);
						}
					}
				};
			});
		});

		function pagingCategoryList(page){
		 	var options = {
				url : "<spring:url value='/shop/getShopCornerPagingList' />"
				, type : "POST"
				, dataType : "html"
				, data : {
					cateCdL : cateCdL
					,dispCornNo : '${so.dispCornNo}'
					,dispClsfCornNo : '${so.dispClsfCornNo}'
					,dispType : '${so.dispType}'
					,petNo : petNo
					,page : page
					,rows : rows
				}
				, done :	function(html){
					$("#otherPetGoodsList").append(html);
					if($("#otherPetGoodsList li").length % rows != 0 || $("#otherPetGoodsList li").length == goodsCount){
						result = false;					
					}else {
						scrollPrevent = true;
					}
					pushUrl(petNo);
				}
			};
			ajax.call(options);
		}
	</script>
	</tiles:putAttribute>	
</tiles:insertDefinition>