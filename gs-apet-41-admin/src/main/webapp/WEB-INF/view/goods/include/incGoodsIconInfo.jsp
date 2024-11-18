<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<script type="text/javascript">
$(document).on("change","#iconStrtDtmNEW , #iconEndDtmNEW",function(){
	var type = "end"
	if($(this).attr('id').indexOf('Strt') > -1){
		type = "start";
	}
	compareDateForDefault("iconStrtDtmNEW", "iconEndDtmNEW", "${frame:toDate('yyyy-MM-dd')}", "${frame:addDay('yyyy-MM-dd', 7)}", type);
});
</script>
<div title="<spring:message code="column.goods.icon" />" data-options="" style="padding:10px">
	<table class="table_type1">
		<caption><spring:message code="column.goods.filt" /></caption>
		<tbody>
			<c:forEach items="${limitedIconCodeList}" var="item" varStatus="idx" >
				<tr>
					<c:if test="${idx.index eq 0}" >
						<th rowspan="${fn:length(limitedIconCodeList)}"><spring:message code="column.goods.iconCode.limited"/></th>
					</c:if>
					<td>
						<label class="fCheck"><input type="checkbox" name="iconCode" id="iconCode${item.dtlCd}" value="${item.dtlCd}" />
							<span class="mt5 mb5">${item.dtlShtNm}</span>
						</label>
						<span><spring:message code="column.goods.iconCode.dtm"/></span>
						<span class="ml5">
							<frame:datepicker startDate="iconStrtDtm${item.dtlCd}" endDate="iconEndDtm${item.dtlCd}" startValue="${frame:toDate('yyyy-MM-dd') }" endValue="${frame:addDay('yyyy-MM-dd', 7)}" />
						</span>
					</td>
				</tr>	
			</c:forEach>
			<tr>
				<th><spring:message code="column.goods.iconCode.unlimited" /></th>
				<td>
					<c:forEach items="${unlimitedIconCodeList}" var="item" varStatus="idx" >
						<label class="fCheck"><input type="checkbox" name="iconCode" id="code${item.dtlCd}" value="${item.dtlCd}" />
							<span class="mt5 mb5">${item.dtlShtNm}</span>
						</label>
					</c:forEach>
				</td>
			</tr>
		</tbody>
	</table>
</div>
<hr />