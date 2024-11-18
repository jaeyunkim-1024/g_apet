<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
	<div class="mTitle mt30">
		<h2>전시 코너 아이템</h2>
		<div class="buttonArea">
			<button type="button" onclick="displayCornerVdAddPop();" class="btn btn-add">추가</button>
			<button type="button" onclick="displayCornerItemVdDelete();" class="btn btn-add">삭제</button>
		</div>
	</div>

	<form name="displayCornerItemVdForm" id="displayCornerItemVdForm">
		<input type="hidden" name="dispClsfNo" id="dispClsfNo" value="${displayCornerItemResult.dispClsfNo}"/>
		<input type="hidden" name="dispCornTpCd" id="dispCornTpCd" value="${displayCornerItemResult.dispCornTpCd}"/>
		<input type="hidden" name="dispClsfCornNo" id="dispClsfCornNo" value="${displayCornerItemResult.dispClsfCornNo}"/>

		<div class="mModule no_m">
			<table id="displayCornerItemVdList"></table>
		</div>
	</form>