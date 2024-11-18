<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
	<div class="mTitle mt30">
		<h2>전시 상품</h2>
		<div class="buttonArea">
			<button type="button" onclick="displayGoodsViewPop();" class="btn btn-add">추가</button>
			<!-- <button type="button" onclick="displayGoodsDelete();" class="btn btn-add">삭제</button> -->
			<button type="button" onclick="displayGoodsSave();" class="btn btn-add">저장</button>
			<c:if test="${adminConstants.DISP_CLSF_20 eq displayGoodsResult.dispClsfCd}">
				<button type="button" onclick="displayGoodsTemplateDownload();" class="ml20 btn btn-add">템플릿</button>
				<button type="button" onclick="displayGoodsUploadPop();" class="btn btn-add">업로드</button>
			</c:if>
		</div>
	</div>

	<form name="displayGoodsForm" id="displayGoodsForm">
		<input type="hidden" name="dispClsfNo" id="dispClsfNo" value="${displayGoodsResult.dispClsfNo}"/>
		<div class="mModule no_m">
			<table id="displayGoodsList"></table>
		</div>
	</form>