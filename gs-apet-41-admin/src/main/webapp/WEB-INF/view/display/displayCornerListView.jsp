<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
	<div class="mTitle mt30">
		<h2>전시 코너</h2>
		<div class="buttonArea">
			<button type="button" onclick="displayCornerSave();" class="btn btn-add">저장</button>
			<button type="button" onclick="displayCornerViewPop();" id="dispCornAddBtn" class="btn btn-add">추가</button>
			<button type="button" onclick="displayCornerDelete();" id="dispCornDelBtn" class="btn btn-add">삭제</button>
		</div>
	</div>

	<form name="displayCornerForm" id="displayCornerForm">
		<div class="mModule no_m">
			<table id="displayCornerList"></table>
		</div>
	</form>