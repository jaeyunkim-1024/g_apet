<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>

<form id="companyCategoryListForm" name="companyCategoryListForm" method="post" >
<input type="hidden" id="compNo" name="compNo" title="<spring:message code="column.goods.comp_no" />" value="${param.compNo}" />

</form>

		<table id="layerCompanyCategoryList" ></table>
		<div id="layerCompanyCategoryListPage"></div>
