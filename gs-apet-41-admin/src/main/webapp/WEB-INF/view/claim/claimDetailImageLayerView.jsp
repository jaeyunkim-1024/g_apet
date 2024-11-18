<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<table class="table_type1">
	<caption>첨부 사진</caption>
	<tbody>
	<tr>
		<td>
			<%-- <img src="${frame:imagePath(imgPath) }" width="100%" alt="" onerror="this.src='/images/noimage.png'" /> --%>
			<img src="<frame:imgUrl/>${imgPath}" width="100%" alt="" onerror="this.src='/images/noimage.png'" />
			
		</td>
	</tr>
	</tbody>
</table>