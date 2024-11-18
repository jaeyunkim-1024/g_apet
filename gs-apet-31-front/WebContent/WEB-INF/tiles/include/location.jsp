<script type="text/javascript">

	$(document).ready(function(){

	});

	$(function() {


	});

</script>

<c:set var="locationNm" value="" />
<c:set var="bigCateNm" value=""/>
<c:set var="addedCateNm" value=""/>

<!-- 현위치 -->
<div class="location_path">
	<ul>
		<li class="home"><a href="/main">Home</a></li>
<c:choose>
<c:when test="${fn:length(view.cateNavigation) >0 }">
<c:set var="navLength" value="${fn:length(view.cateNavigation) }" />
	<c:forEach var="navi1" items="${view.cateNavigation}" end="${navLength }" varStatus="idx1">
	<c:set var="bigCateNm" value="${navi1.value }"/>
	<c:set var ="addedCateNm" value="${addedCateNm }|${bigCateNm }"/>
	<c:set var="len" value="${fn:length(addedCateNm) }"/>
		<c:if test="${idx1.last}">
			<li class="current"><c:out value="${navi1.value}" /></li>
			<c:if test="${idx1.index > 0 }">
				<c:set var="addedCateNm" value="${fn:substring(addedCateNm,1,len) }"/>
			</c:if>
		</c:if>
		<c:if test="${!idx1.last}">
			<li><a href="/category/indexCategory?dispClsfNo=${navi1.key }"><c:out value="${navi1.value}" /></a></li>
		</c:if>
	</c:forEach>
</c:when>
<c:otherwise>
	<c:forEach items="${view.navigation}" var="navi" varStatus="idx">
	<c:set var ="addedCateNm" value="${navi }"/>
		<c:if test="${idx.last}">
			<li class="current"><c:out value="${navi}" /></li>
		</c:if>
		<c:if test="${!idx.last}">
			<li><c:out value="${navi}" /></li>
		</c:if>
	</c:forEach>
</c:otherwise>
</c:choose>
	</ul>
</div>

<script>
var locationNm = "${addedCateNm }";
</script>
<!-- //현위치 -->