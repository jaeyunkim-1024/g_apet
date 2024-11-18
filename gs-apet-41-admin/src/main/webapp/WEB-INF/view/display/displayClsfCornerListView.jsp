<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
	<div class="mTitle mt30">
		<h2>전시 분류 코너</h2>
		<div class="buttonArea">
			<c:if test="${displayClsfCornerResult.dispCornTpCd != adminConstants.DISP_CORN_TP_130 && displayClsfCornerResult.dispCornTpCd != adminConstants.DISP_CORN_TP_131
					   && displayClsfCornerResult.dispCornTpCd != adminConstants.DISP_CORN_TP_132 && displayClsfCornerResult.dispCornTpCd != adminConstants.DISP_CORN_TP_133}">
			<button type="button" onclick="displayClsfCornerAddPop();" class="btn btn-add" id="displayClsfCornerAddBtn">추가</button>
			<button type="button" onclick="displayClsfCornerDelete();" class="btn btn-add">삭제</button>
			</c:if>
		</div>
	</div>

	<form name="displayClsfCornerForm" id="displayClsfCornerForm">
		<input type="hidden" name="dispClsfNo" id="dispClsfNo" value="${displayClsfCornerResult.dispClsfNo}"/>
		<input type="hidden" name="dispCornNo" id="dispCornNo" value="${displayClsfCornerResult.dispCornNo}"/>
		<input type="hidden" name="dispCornTpCd" id="dispCornTpCd" value="${displayClsfCornerResult.dispCornTpCd}"/>

		<div class="mModule no_m">
			<table id="displayClsfCornerList"></table>
		</div>
	</form>