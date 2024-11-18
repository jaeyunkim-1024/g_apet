<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<script type="text/javascript">
function searchGoodsEstm () {
	var options = {
		callBack : searchCompanyCallback
		, dispClsfNo : $("[name='goodsEstmDispClsfNo']").val()
		, firstYn : 'Y'
	}
	layerEstmList.create (options );
}

</script>
<div title="<spring:message code='column.goods.estmGrp' />" data-options="" style="padding:10px">
	<table class="table_type1">
		<caption></caption>
		<tbody>
			<tr>
				<th><spring:message code="column.goods.estmGrp" /></th>	<!-- 상품평가 항목 그룹 -->
				<td colspan="3" >
					<button type="button" class="btn" onclick="searchGoodsEstm(); return false;">
						<spring:message code="column.goods.btn.estmDispClsfNo"/>
					</button>
					<input type="hidden" class="readonly ml10 w150" readonly name="goodsEstmDispClsfNo" value="${goodsBase.goodsEstmDispClsfNo}" />
				</td>
			</tr>
		</tbody>
	</table>
</div>
<hr />