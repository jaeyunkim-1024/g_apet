<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
	<div class="mTitle mt30">
		<h2>전시 코너 아이템</h2>
		<div class="buttonArea">
			<!-- 전시 기간-->
			<frame:datepicker startDate="dispStrtdtApply"
							  startValue="${frame:toDate('yyyy-MM-dd')}"
							  endDate="dispEnddtApply"
							  endValue="${frame:addMonth('yyyy-MM-dd', 1)}"
							  />
			<button type="button" onclick="displayCornerItemDateApply();" class="btn btn-cancel">전시 기간 적용</button>
			<button type="button" onclick="displayCornerItemAddPop();" class="btn btn-add">추가</button>
			<button type="button" onclick="displayCornerItemDelete();" class="btn btn-add">삭제</button>
			<button type="button" onclick="displayCornerItemSave();" class="btn btn-add">저장</button>
		</div>
	</div>

	<form name="displayCornerItemForm" id="displayCornerItemForm">
		<input type="hidden" name="dispClsfNo" id="dispClsfNo" value="${displayCornerItemResult.dispClsfNo}"/>
		<input type="hidden" name="dispCornTpCd" id="dispCornTpCd" value="${displayCornerItemResult.dispCornTpCd}"/>
		<input type="hidden" name="dispClsfCornNo" id="dispClsfCornNo" value="${displayCornerItemResult.dispClsfCornNo}"/>

		<div class="mModule no_m">
			<table id="displayCornerItemList"></table>
		</div>
	</form>