<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
	<div class="mTitle mt30">
		<h2>관련 브랜드</h2>
		<div class="buttonArea">
			<button type="button" onclick="displayBrandViewPop();" class="btn btn-add">추가</button>
			<button type="button" onclick="displayBrandDelete();" class="btn btn-add">삭제</button>
			<button type="button" onclick="displayBrandSave();" class="btn btn-add">저장</button>
		</div>
	</div>

	<form name="displayBrandForm" id="displayBrandForm">
		<input type="hidden" name="dispClsfNo" id="dispClsfNo" value="${displayBrandResult.dispClsfNo}"/>
		<input type="hidden" name="bndGbCd" id="bndGbCd" value="${displayBrandResult.bndGbCd}"/>
		<div class="mModule no_m">
			<table id="displayBrandList"></table>
		</div>
	</form>