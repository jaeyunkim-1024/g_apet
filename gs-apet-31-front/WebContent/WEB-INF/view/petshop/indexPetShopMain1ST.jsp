<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ page import="front.web.config.constants.FrontWebConstants" %>
<tiles:insertDefinition name="common">
	<tiles:putAttribute name="script.include" value="script.petshop"/>
	<tiles:putAttribute name="script.inline">
		<script type="text/javascript">
			var scndHtml = null;
			var scndItvl = null;
			$.post("/shop/indexPetShopMain2ND?dfLnbDispClsfNo=${so.lnbDispClsfNo}&cateCdL=${so.cateCdL}", function (html) { 
				scndHtml = html;
			});
			$(document).ready(function(){
				// 남은 화면 출력
				if(scndHtml != null && scndHtml != ""){ // 바로 출력
					$("#contents").append(scndHtml);
					ui.init();
				}else if(scndHtml == null){	// 들러올때까지 기다렸다가 출력
					scndItvl = setInterval(function(){
						if(scndHtml != null){
							$("#contents").append(scndHtml);
							ui.init();
							clearInterval(scndItvl);
						}
					},50);
				}
			});
			
			function loadCornerGoodsList(dispClsfNo, dispCornNo, dispClsfCornNo, dispType, timeDeal) {
				var form = document.createElement("form");
				document.body.appendChild(form);
				var url = "/shop/indexGoodsList";
				form.setAttribute("method", "GET");
				form.setAttribute("action", url);
		
				var hiddenField = document.createElement("input");
				hiddenField.setAttribute("type", "hidden");
				hiddenField.setAttribute("name", "dispClsfNo");
				hiddenField.setAttribute("value", dispClsfNo);
				form.appendChild(hiddenField);
				document.body.appendChild(form);
				hiddenField = document.createElement("input");
				hiddenField.setAttribute("type", "hidden");
				hiddenField.setAttribute("name", "dispCornNo");
				hiddenField.setAttribute("value", dispCornNo);
				form.appendChild(hiddenField);
				document.body.appendChild(form);
				hiddenField = document.createElement("input");
				hiddenField.setAttribute("type", "hidden");
				hiddenField.setAttribute("name", "dispClsfCornNo");
				hiddenField.setAttribute("value", dispClsfCornNo);
				form.appendChild(hiddenField);
				document.body.appendChild(form);
				if(dispType != undefined) {
					hiddenField = document.createElement("input");
					hiddenField.setAttribute("type", "hidden");
					hiddenField.setAttribute("name", "dispType");
					hiddenField.setAttribute("value", dispType);
					form.appendChild(hiddenField);
					document.body.appendChild(form);
				}
				if(timeDeal != undefined) {
					hiddenField = document.createElement("input");
					hiddenField.setAttribute("type", "hidden");
					hiddenField.setAttribute("name", "timeDeal");
					hiddenField.setAttribute("value", timeDeal);
					form.appendChild(hiddenField);
					document.body.appendChild(form);
				}
				form.submit();
			}

			/**
			 * 금액 콤마 처리
			 * @param x
			 * @returns {string}
			 */
			function numberWithCommas(x) {
				x = String(x);
				var pattern = /(-?\d+)(\d{3})/;
				while (pattern.test(x))
					x = x.replace(pattern, "$1,$2");
				return x;
			}
		</script>
	</tiles:putAttribute>
	<tiles:putAttribute name="content">
		<main class="container lnb page shop hm main" id="container">
			<div class="mnschbox">
				<div class="inr">
					<div class="shop-search input">
						<input id="srchShopWord" name="srchWord" readonly="readonly" type="search" value="<c:out value="${srchWord}" escapeXml="false" />" autocomplete="off" >
						<button type="button" class="btnSch" data-content="" data-url="/commonSearch">검색</button>
					</div>
				</div>
			</div>
			<div class="inr">
				<!-- 본문 -->
				<div class="contents" id="contents">
					<input type="hidden" id="dispClsfNo_" value="${view.dispClsfNo}"/>
					<c:forEach var="cornerList" items="${totalCornerList}"  varStatus="status" >
						<jsp:include page="/WEB-INF/view/petshop/include/${cornerList.dispCornPage}">
							<jsp:param value="${cornerList.dispCornNo}" name="dispCornNo"/>
						</jsp:include>
					</c:forEach>
				</div>
			</div>
		</main>
		<jsp:include page="/WEB-INF/tiles/include/floating.jsp">
			<jsp:param name="floating" value="" />
		</jsp:include>
	</tiles:putAttribute>	
</tiles:insertDefinition>