<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
	<div class="mTitle mt30">
		<h2>쇼룸 전시 상품</h2>
		<div class="buttonArea">
			<button type="button" onclick="displayShowRoomGoodsViewPop();" class="btn btn-add">추가</button>
			<button type="button" onclick="displayShowRoomGoodsDelete();" class="btn btn-add">삭제</button>
		</div>
	</div>

	<form name="displayShowRoomGoodsForm" id="displayShowRoomGoodsForm">
		<input type="hidden" name="dispClsfNo" id="dispClsfNo" value="${displayGoodsResult.dispClsfNo}"/>
		<div class="mModule no_m">
			<table id="displayShowRoomGoodsList"></table>
		</div>
	</form>