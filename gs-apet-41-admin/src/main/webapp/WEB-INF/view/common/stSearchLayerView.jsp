<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>

<form id="layerStSearchForm" name="layerStSearchForm" method="post" >
	<table class="table_type1 popup">
		<caption>정보 검색</caption>
		<tbody>
			<tr>
				<th scope="row"><spring:message code="column.st_nm" /></th>
				<td>
					<input type="text" class="w300" name="stNm" title="<spring:message code="column.st_nm" />" >
					<input type="hidden" id="useYn" name="useYn" value="Y" >
				</td>
			</tr>
		</tbody>
	</table>
</form>

	<div class="btn_area_center mb30">
		<button type="button" onclick="layerStList.reload();" class="btn btn-ok">검색</button>
		<button type="button" onclick="layerStList.searchReset();" class="btn btn-cancel">초기화</button>
	</div>
	
	<table id="layerStList" ></table>
	<div id="layerStListPage"></div>
	