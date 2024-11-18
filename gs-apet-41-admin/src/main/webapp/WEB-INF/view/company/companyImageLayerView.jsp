<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<table class="table_type1">
	<caption></caption>
	<tbody>
	<tr>
		<td>
			<c:choose>
				<c:when test="${imgPath.indexOf('temp') > -1 }">
					<img src="/common/imageView.do?filePath=${imgPath}" width="100%" alt="" />
				</c:when>
				<c:otherwise>
					<img src="${frame:imagePath(imgPath) }" width="100%" alt="" />
				</c:otherwise>
			</c:choose>
		</td>
	</tr>
	</tbody>
</table>