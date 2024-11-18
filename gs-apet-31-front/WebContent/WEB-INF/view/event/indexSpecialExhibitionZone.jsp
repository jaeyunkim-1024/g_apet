<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<tiles:insertDefinition name="common">
<tiles:putAttribute name="script.inline">
<script type="text/javascript" src="/_script/corner.js" ></script>
<script type="text/javascript">
<c:if test="${view.deviceGb ne frontConstants.DEVICE_GB_10 }">	
	$(document).ready(function(){
		$.each($('.swiper-wrapper.menu a'), function(){
		    if($(this).attr("onclick").indexOf('exhbtNo='+'${so.exhbtNo}') != -1){
		        $(this).parent('li').addClass('active');
		    }
		});
		
		if("${not empty view.displayShortCutList}" == 'true') {
			/* 탭이동 종료 후 이벤트 */
			var idx = $("li[name=shortCut][class~=active]").data("shortcutidx");
			if(idx != 'undefined') {
				ui.disp.subnav.elSwiper.el.slideTo(idx-1);
			};
		}
	});	
	
// 	function goPetShopMain() {
//         var form = document.createElement("form");
//         document.body.appendChild(form);
//         var url = "/shop/home/";
//         form.setAttribute("method", "POST");
//         form.setAttribute("action", url);

//         var hiddenField = document.createElement("input");
//         hiddenField.setAttribute("type", "hidden");
//         hiddenField.setAttribute("name", "lnbDispClsfNo");
//         hiddenField.setAttribute("value", '${view.dispClsfNo}');
//         form.appendChild(hiddenField);
//         document.body.appendChild(form);
//         form.submit();
//     }
	
</c:if>

var exhGoods = {
		page : "${page}",
		row : "${so.rows }",
		cnt : null,
		soPage : null,
		more : function(thmNo){
			var newPage = $("#input_"+thmNo).val();
			
			if(newPage == 0) {
				newPage = 1* exhGoods.row
			} else {
				newPage = ((newPage/exhGoods.row)+1) * exhGoods.row
			}
				
		 	var options = {
		 		url : "<spring:url value='/event/specialExhibitionZoneList' />"
		 		, type : "POST"
		 		, dataType : "html"
		 		, data : {
		 			page : newPage,
		 			thmNo : thmNo,
		 			exhbtNo : "${so.exhbtNo}"
		 		}
		 		, done :function(result){
		 			$("#theme_"+thmNo).append(result);
		 			var row = parseInt(exhGoods.row);
		 			var cnt = parseInt(exhGoods.cnt);
		 			
		 			if(row > cnt){
		 				$("#goodsMore_"+thmNo).hide();
		 			}else{
		 				$("#goodsMore_"+thmNo).show();
		 			}
		 		}	
		 	};
		 	ajax.call(options);
		}
}

$(document).on('click', ".btPlanMov", function(e){
	var index = $(this).parents('section').data("index");
	setTimeout(function(){
		$(".poptents ul li").removeClass('on');
		$(".poptents ul[class=menu] li").eq(index).addClass('on');
	}, 50);
})

</script>
</tiles:putAttribute>
<tiles:putAttribute name="content">
<main class="container lnb page shop dm plan" id="container">
	<c:if test="${view.deviceGb != 'PC' && not empty view.displayShortCutList}">
		<nav class="subtopnav">
			<div class="inr">
				<div class="swiper-container box">
					<ul class="swiper-wrapper menu">
						<c:forEach var="icon" items="${view.displayShortCutList}"  varStatus="status" >
						<li class="swiper-slide" name="shortCut" data-shortcutidx="${status.count }">
							<a class="bt" href="javascript:void(0);" onclick="goLink('${icon.bnrMobileLinkUrl}', true)">${icon.bnrText}</a>
						</li>
						</c:forEach>
					</ul>
				</div>
			</div>
		</nav>
	</c:if>
	
	<div class="pageHeadPc lnb"> <!-- @@ 2021.03.22 추가-->
		<div class="inr">
			<div class="hdt">
				<c:forEach var="ehb" items="${exhibitionList}">
				<h3 class="tit">${ehb.exhbtNm}</h3>
				</c:forEach>
			</div>
		</div>
	</div>
			
	<div class="inr">
		<!-- 본문 -->
		<input type="hidden" id="exhbtNo" value="${so.exhbtNo}"/>
		<div class="contents" id="contents">
			<c:forEach var="ehb" items="${exhibitionList}">
				<section class="sect dm plan visms">
					<div class="thum">
						<div class="pic">
							<div class="img pc"><c:out value="${ehb.ttlHtml}" escapeXml="false"/></div>
							<div class="img mo"><c:out value="${ehb.ttlMoHtml}" escapeXml="false"/></div>
						</div>
					</div>
				</section> 
				<c:forEach var="theme" items="${ehb.exhibitionThemeList}">
					<c:if test="${not empty theme.exhibitionGoods}">
					<!-- 04.19 : 수정 Sticky_bar wrap 적용 -->
					<div class="sticky_bar">
						<section class="sect dm plan set">
							<div class="hdts">
								<div class="tits"><button type="button" class="bt btPlanMov">${theme.thmNm}</button></div>						
							</div>
							<div class="gdlist">
								<ul class="list" id="theme_${theme.thmNo}">
									<input type="hidden" id="input_${theme.thmNo}" value="${page}"/>
									<c:forEach items="${theme.exhibitionGoods}" var="goods">
										<li class="on">
											<div class="gdset defgd">
												<div class="thum">
													<a href="/goods/indexGoodsDetail?goodsId=${goods.goodsId}" class="pic">
													<img class="img" src="${frame:optImagePath(goods.imgPath, frontConstants.IMG_OPT_QRY_510)}" alt="이미지" onerror="this.src='../../_images/common/img_default_thumbnail_2@2x.png'">
														<c:if test="${goods.salePsbCd == frontConstants.SALE_PSB_10}">
															<div class="soldouts"><em class="ts"><spring:message code='front.web.view.common.goods.saleStop.title' /></em></div>
														</c:if>
														<c:if test="${goods.salePsbCd == frontConstants.SALE_PSB_20}">
															<div class="soldouts"><em class="ts"><spring:message code='front.web.view.common.goods.saleEnd.title' /></em></div>
														</c:if>
														<c:if test="${goods.salePsbCd == frontConstants.SALE_PSB_30}">
															<div class="soldouts"><em class="ts"><spring:message code='front.web.view.common.goods.saleSoldOut.title' /></em></div>
														</c:if>
													</a>
													<button type="button" class="bt zzim ${goods.webStkQty ne 0 && goods.interestYn == 'Y' ? 'on' : ''}" data-target="goods" data-action="interest" data-yn="N" data-goods-id="${goods.goodsId}">찜하기</button>
												</div>
												<div class="boxs">
													<div class="tit"><a href="/goods/indexGoodsDetail?goodsId=${goods.goodsId}" class="lk">${goods.goodsNm}</a></div>
													<a href="javascript:;" class="inf">
														<span class="prc"><em class="p"><frame:num data="${goods.saleAmt}"/></em><i class="w"><spring:message code='front.web.view.common.moneyUnit.title' /></i></span>
														<c:if test="${goods.orgSaleAmt > goods.saleAmt and ((goods.orgSaleAmt - goods.saleAmt)/goods.orgSaleAmt * 100) >= 1 }">
		<%-- 												<c:if test="${(100-((goods.foSaleAmt * 100) / goods.orgSaleAmt)) > 0}"> --%>
															<span class="pct"><em class="n">
															<fmt:parseNumber value="${100-((goods.foSaleAmt * 100) / goods.orgSaleAmt)}" integerOnly="true"/>
															</em><i class="w">%</i></span>
														</c:if>
													</a>
												</div>
											</div>
										</li>
									</c:forEach>
								</ul>
								<div class="moreload">
									<c:if test="${theme.ehbCnt > so.rows}">
										<button type="button" class="bt more" onclick="exhGoods.more(${theme.thmNo}, ${so.page});" id="goodsMore_${theme.thmNo}">
											<spring:message code='front.web.view.common.button.goods.more' />
										</button>
									</c:if>
								</div>
							</div>
						</section>
					</div>
					</c:if>
				</c:forEach>
			</c:forEach>
		</div>
	</div>
</main>

<jsp:include page="/WEB-INF/tiles/include/floating.jsp">
	<jsp:param name="floating" value=""  />
</jsp:include>
		
</tiles:putAttribute>
</tiles:insertDefinition>