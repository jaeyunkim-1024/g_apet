<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>

			<c:if test="${imgList ne null and fn:length(imgList) gt 0 }">
				<table class="table_type1">
					<caption>정보 검색</caption>
					<colgroup>
						<col style="width:10%;">
						<col style="width:40%;">
						<col style="width:10%;">
						<col style="width:40%;">
					</colgroup>					
					<tbody>
					<c:forEach items="${imgList }" var="img" varStatus="i" >
						<c:if test="${i.count % 2 eq 1 }"><tr></c:if>
							<td>
								${img.imgSize }
							</td>
							<td>
<%-- 								<img src="${frame:optImagePath( img.imgPath , img.imgOption )}" alt=""  width="100%" onerror="this.src='/images/noimage.png'" /> --%>
								<img src="${frame:optImagePath( img.imgPath , img.imgOption )}" alt=""  onerror="this.src='/images/noimage.png'" />
							</td>
						<c:if test="${i.count % 2 eq 0 or i.count eq fn:length(imgList) }"></tr></c:if>
					</c:forEach>
					</tbody>
				</table>
			</c:if>
