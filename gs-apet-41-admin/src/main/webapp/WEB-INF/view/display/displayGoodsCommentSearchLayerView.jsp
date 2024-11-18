<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>

<form id="displayGoodsCommentListForm" name="displayGoodsCommentListForm" method="post" >
	<table class="table_type1">
		<caption>정보 검색</caption>
		<colgroup>
			<col width="170px"/>
			<col />
			<col width="170px"/>
			<col />
		</colgroup>
		<tbody>
			<tr>
				<th scope="row"><spring:message code="column.common.date" /></th> <!-- 기간 -->
				<td colspan="3">
					<frame:datepicker startDate="sysRegDtmStart" endDate="sysRegDtmEnd" startValue="${adminConstants.COMMON_START_DATE }" />
					&nbsp;&nbsp;
					<select id="checkOptDate" name="checkOptDate" onchange="searchDateChange();">
						<frame:select grpCd="${adminConstants.SELECT_PERIOD }" defaultName="기간선택" />
					</select>
				</td>
			</tr>
			<tr>
				<th scope="row"><spring:message code="column.goods_id" /></th> <!-- 상품 ID -->
				<td>
					<textarea rows="3" cols="30" id="goodsIdArea" name="goodsIdArea" ></textarea>
				</td>
				<th scope="row"><spring:message code="column.login_id" /></th> <!-- LOGIN ID -->
				<td>
					<input type="text" id="estmId" name="estmId" title="<spring:message code="column.login_id" />" value="" />
				</td>
			</tr>
			<tr>
				<th scope="row"><spring:message code="column.goods.comp_no" /></th> <!-- 업체번호 -->
				<td>
					<frame:compNo funcNm="searchCompany" requireYn="Y" />
				</td>
				<th scope="row"><spring:message code="column.sys_del_yn" /></th> <!-- 삭제 여부 -->
				<td>
					<select id="sysDelYn" name="sysDelYn" >
						<frame:select grpCd="${adminConstants.SHOW_YN }" defaultName="선택" />
					</select>
				</td>
			</tr>
		</tbody>
	</table>
</form>

<div class="btn_area_center">
	<button type="button" onclick="layerGoodsCommentList.searchGoodsCommentList();" class="btn btn-ok">검색</button>
	<button type="button" onclick="layerGoodsCommentList.searchReset();" class="btn btn-cancel">초기화</button>
</div>
<hr />

<div class="mModule">
	<table id="layerGoodsCommentList" ></table>
	<div id="layerGoodsCommentListPage"></div>
</div>