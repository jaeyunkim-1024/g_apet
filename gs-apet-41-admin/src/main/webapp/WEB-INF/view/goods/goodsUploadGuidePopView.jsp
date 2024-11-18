<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>

<c:if test="${imgList ne null and fn:length(imgList) gt 0 }">
				<table class="table_type1">
					<caption>정보 검색</caption>
					<colgroup>
						<col style="width:20%;">
						<col style="width:20%;">
						<col style="width:20%;">
						<col style="width:20%;">
						<col style="width:20%;">
					</colgroup>
					<tbody>
<c:forEach items="${imgList }" var="img" varStatus="i" >
	<c:if test="${i.count % 5 eq 1 }"><tr></c:if>
						<td>
							${img.imgSize }<br/>
							<img src="<frame:imgUrl/>${img.imgPath }" width="90%" alt="" />
						</td>
	<c:if test="${i.count % 5 eq 0 or i.count eq fn:length(imgList) }"></tr></c:if>
</c:forEach>
					</tbody>
				</table>
</c:if>

<c:if test="${rvsImgList ne null and fn:length(rvsImgList) gt 0 }">
				<table class="table_type1">
					<caption>정보 검색</caption>
					<colgroup>
						<col style="width:20%;">
						<col style="width:20%;">
						<col style="width:20%;">
						<col style="width:20%;">
						<col style="width:20%;">
					</colgroup>
					<tbody>
<c:forEach items="${rvsImgList }" var="img" varStatus="i" >
	<c:if test="${i.count % 5 eq 1 }"><tr></c:if>
						<td>
							${img.imgSize }<br/>
							<img src="<frame:imgUrl/>${img.rvsImgPath }" width="90%" alt="" />
						</td>
	<c:if test="${i.count % 5 eq 0 or i.count eq fn:length(rvsImgList) }"></tr></c:if>
</c:forEach>
					</tbody>
				</table>
</c:if>