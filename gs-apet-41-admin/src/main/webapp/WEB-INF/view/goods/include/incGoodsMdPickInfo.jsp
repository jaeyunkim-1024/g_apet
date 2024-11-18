<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>

<script type="text/javascript">

$(function(){
	$(":radio[name='mdRcomYn']").change(function () {
		if($(":radio[name='mdRcomYn']:checked").val() === '${adminConstants.COMM_YN_Y}'){
			$("#mdPickTbody [type='text']").prop('readonly', false);
			$("#mdPickTbody [type='text']").removeClass('readonly');
			$("#mdPickTbody [name='mdRcomWds']").addClass('validate[required]');
		}else{
			$("#mdPickTbody [type='text']").prop('readonly', true);
			$("#mdPickTbody [type='text']").addClass('readonly');
			$("#mdPickTbody [name='mdRcomWds']").removeClass('validate[required]');
			$("#mdPickTbody [type='text']").val('');
		}
	});
})
</script>

<div title="<spring:message code='column.goods.mdPick' />" data-options="" style="padding:10px" >
	<table class="table_type1">
		<caption></caption>
		<tbody id="mdPickTbody">
			<tr>
				<th><spring:message code="column.goods.mdRcomYn" /><strong class="red">*</strong></th>	<!-- MD 추천 여부 -->
				<td>
					<frame:radio name="mdRcomYn" grpCd="${adminConstants.COMM_YN }" selectKey="${goodsBase.mdRcomYn eq null ? adminConstants.COMM_YN_N : goodsBase.mdRcomYn }" />
				</td>
			</tr>
			<tr>
				<th><spring:message code="column.goods.checkPoint" /></th>	<!-- 체크 포인트 -->
				<td>
					<input type="text" class="${goodsBase.mdRcomYn eq adminConstants.COMM_YN_N || empty goodsBase ? 'readonly' : ''} w800 validate[maxSize[200]]" name="checkPoint" ${goodsBase.mdRcomYn eq adminConstants.COMM_YN_N || empty goodsBase ? 'readonly' : ''} value="${goodsBase.checkPoint}" title="<spring:message code='column.goods.checkPoint' />" />
				</td>
			</tr>
			<tr>
				<th><spring:message code="column.goods.mdRcomWds" /></th>	<!-- MD 추천 메세지 -->
				<td>
					<input type="text" class="${goodsBase.mdRcomYn eq adminConstants.COMM_YN_N || empty goodsBase ? 'readonly' : ''} w800 validate[maxSize[300]]" name="mdRcomWds" ${goodsBase.mdRcomYn eq adminConstants.COMM_YN_N || empty goodsBase ? 'readonly' : ''} value="${goodsBase.mdRcomWds}" title="<spring:message code='column.goods.mdRcomWds' />" />
				</td>
			</tr>
		</tbody>
	</table>
</div>
