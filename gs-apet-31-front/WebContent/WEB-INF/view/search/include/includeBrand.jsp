<c:forEach items="${result.brandList}" var="brand" varStatus="idx" >
	<a class="btn scrhItem sb${brand.bnd_no}" href="javascript:searchResult.goBrand('${brand.bnd_no}');">
		${brand.bnd_nm_ko}
	</a>
</c:forEach>
<input type="hidden" id="ajaxBrandListSize" value = '${result.brandCount}'/>
		