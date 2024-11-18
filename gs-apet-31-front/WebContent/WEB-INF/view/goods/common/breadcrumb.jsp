<script type="text/javascript">
//메인으로 가기
function goPetShopMain(dispClsfNo) {
	
	if('${frontConstants.PETSHOP_DOG_DISP_CLSF_NO}' == dispClsfNo ) {			// 강아지
		dispClsfNo = '${frontConstants.PETSHOP_MAIN_DOG_DISP_CLSF_NO}'
	} else if('${frontConstants.PETSHOP_CAT_DISP_CLSF_NO}' == dispClsfNo ) {	// 고양이
		dispClsfNo = '${frontConstants.PETSHOP_MAIN_CAT_DISP_CLSF_NO}'
	} else if('${frontConstants.PETSHOP_FISH_DISP_CLSF_NO}' == dispClsfNo ) {	// 관상어
		dispClsfNo = '${frontConstants.PETSHOP_MAIN_FISH_DISP_CLSF_NO}'
	} else if('${frontConstants.PETSHOP_ANIMAL_DISP_CLSF_NO}' == dispClsfNo ) {	// 소동물
		dispClsfNo = '${frontConstants.PETSHOP_MAIN_ANIMAL_DISP_CLSF_NO}'
	}
	
	var form = document.createElement("form");
	document.body.appendChild(form);
	var url = "/shop/home/";
	form.setAttribute("method", "POST");
	form.setAttribute("action", url);

	var hiddenField = document.createElement("input");
	hiddenField.setAttribute("type", "hidden");
	hiddenField.setAttribute("name", "lnbDispClsfNo");
	hiddenField.setAttribute("value", dispClsfNo);
	form.appendChild(hiddenField);
	document.body.appendChild(form);
	form.submit();
}
</script>

<nav class="location">
	<ul class="loc">
		<li>
			<a href="javascript:;" class="bt st"><c:out value="${goods.cateNmL}"/></a>
			<ul class="menu">
				<c:forEach items="${displayCategory1}" var="displayCategory" varStatus="catIdx">
					<li <c:if test="${goods.cateCdL eq displayCategory.dispClsfNo}">class="active"</c:if>>
						<a class="bt" href="javascript:goPetShopMain('<c:out value="${displayCategory.dispClsfNo}"/>');"><c:out value="${displayCategory.dispClsfNm}"/></a>
					</li>
				</c:forEach>
			</ul>
		</li>
		<li>
			<a href="javascript:;" class="bt st"><c:out value="${goods.cateNmM}"/></a>
			<ul class="menu">
				<c:forEach items="${displayCategory2}" var="displayCategory" varStatus="catIdx">
					<c:if test="${goods.cateCdL eq displayCategory.dispClsfNo1}">
						<li <c:if test="${goods.cateCdM eq displayCategory.dispClsfNo}">class="active"</c:if>>
							<a class="bt" href="<c:url value="/shop/indexCategory?dispClsfNo=${displayCategory.dispClsfNo}&cateCdL=${displayCategory.dispClsfNo1}&cateCdM=${displayCategory.dispClsfNo}"/>"><c:out value="${displayCategory.dispClsfNm}"/></a>
						</li>
					</c:if>

				</c:forEach>
			</ul>
		</li>
		<li>
			<a href="javascript:;" class="bt st"><c:out value="${goods.cateNmS}"/></a>
			<ul class="menu">
				<c:forEach items="${displayCategories}" var="displayCategory" varStatus="catIdx">
					<c:if test="${goods.cateCdM eq displayCategory.dispClsfNo2}">
						<li <c:if test="${goods.cateCdS eq displayCategory.dispClsfNo}">class="active"</c:if>>
							<a class="bt" href="<c:url value="/shop/indexCategory?dispClsfNo=${displayCategory.dispClsfNo}&cateCdL=${displayCategory.dispClsfNo1}&cateCdM=${displayCategory.dispClsfNo2}"/>"><c:out value="${displayCategory.dispClsfNm}"/></a>
						</li>
					</c:if>
				</c:forEach>
			</ul>
		</li>
	</ul>
</nav>