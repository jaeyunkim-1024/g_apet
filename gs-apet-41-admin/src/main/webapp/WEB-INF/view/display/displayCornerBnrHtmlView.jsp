<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
	<div class="mTitle mt30">
		<h2>전시 코너 아이템</h2>
		<div class="buttonArea">
			<!-- 전시 기간-->
			<frame:datepicker startDate="dispStrtdtApply"
							  startValue="${empty displayCornerBnrItem[0].dispStrtdt ? frame:toDate('yyyy-MM-dd') : displayCornerBnrItem[0].dispStrtdt}"
							  endDate="dispEnddtApply"
							  endValue="${empty displayCornerBnrItem[0].dispEnddt ? frame:addMonth('yyyy-MM-dd', 1) : displayCornerBnrItem[0].dispEnddt}"
							  />
												  
			<button type="button" onclick="displayCornerBnrHtmlDelete();" class="btn btn-add">삭제</button>
			<button type="button" onclick="displayCornerBnrHtmlSave();" class="btn btn-add">${displayCornerBnrItem[0].dispCnrItemNo == null ? "저장" : "수정"}</button>
		</div>
	</div>

	<form name="displayCornerItemForm" id="displayCornerItemForm">
		<input type="hidden" name="dispClsfNo" id="dispClsfNo" value="${displayCornerItemResult.dispClsfNo}"/>
		<input type="hidden" name="dispCornTpCd" id="dispCornTpCd" value="${displayCornerItemResult.dispCornTpCd}"/>
		<input type="hidden" name="dispClsfCornNo" id="dispClsfCornNo" value="${displayCornerItemResult.dispClsfCornNo}"/>
		<input type="hidden" name="dispBnrNo" id="dispBnrNo" value="${displayCornerBnrItem[0].dispBnrNo}"/>
		<input type="hidden" name="dispCnrItemNo" id="dispCnrItemNo" value="${displayCornerBnrItem[0].dispCnrItemNo}"/>
		
		<div class="mModule no_m">
			<textarea name="bnrHtml" id="bnrHtml" style="width: 100%; height: 300px;">${displayCornerBnrItem[0].bnrHtml}</textarea>
		</div>
	</form>