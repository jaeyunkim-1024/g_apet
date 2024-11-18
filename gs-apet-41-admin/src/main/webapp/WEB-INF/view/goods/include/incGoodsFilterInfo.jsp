<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>

<script type="text/javascript">
	//전시 필터 조회
	function searchDispFilterList(firstFlag){
		
		var dispCtgList = $("#dispCtgList").jqGrid('getRowData');
		var dispNos = new Array();
		var flagUpDispNo = true;
		
		if(!firstFlag){
			$.each(dispCtgList, function(index, item) {
				
				flagUpDispNo = true;
				
				dispNos.push(item.dispClsfNo);
				
				$.each(dispNos, function(index, dispNo) {
					if(dispNo === item.upDispClsfNo){
						flagUpDispNo = false;
					}
				});
				
				if(flagUpDispNo){
					dispNos.push(item.upDispClsfNo);
				}
			});
		}
		
		var resultHtml = '';
		
		if(dispNos.length > 0 || firstFlag){
			var config = {
				url : "<spring:url value='/goods/searchGoodsFiltList.do' />"
				, data : { dispClsfNos : dispNos, goodsId : firstFlag ? "${goodsBase.goodsId}" : "" }
				, dataType : "json"
				, callBack : function (data ) {
					
					if(data.length > 0){
						$.each(data, function(index, resultGrp) {
							resultHtml += '<tr>';
							resultHtml += 	'<th>'+ resultGrp.filtGrpMngNm +'</th>';
							resultHtml += 	'<td>';
							$.each(resultGrp.goodsFiltAttrList, function(index, resultAttr) {
								var checkedFlag = "";
								if(resultAttr.checkedFiltAttrSeq != null){
									checkedFlag = "checked";
								}
								resultHtml += 	'<label class="fCheck"><input type="checkbox" name="filtAttrSeq" value="'+ resultAttr.filtAttrSeq +'" '+ checkedFlag +' data-filtGrpNo="'+ resultAttr.filtGrpNo +'" />';
								resultHtml += 		'<span class="mt5 mb5">'+ resultAttr.filtAttrNm +'</span>';
								resultHtml += 	'</label>';
							})
							resultHtml += '</td>';
							resultHtml += '</tr>';
						});
					}else{
						resultHtml += '<tr>';
						resultHtml +=	'<th><spring:message code="column.goods.filt.noResult.category"/></th>';
						resultHtml += '</tr>';
					}
					$("#filtTbody").html(resultHtml);
				}
			};
			ajax.call(config );
		}else{
			resultHtml += '<tr>';
			resultHtml +=	'<th><spring:message code="column.goods.filt.unSelected.category"/></th>';
			resultHtml += '</tr>';
			$("#filtTbody").html(resultHtml);
		}
	}
</script>

<div title="<spring:message code="column.goods.filt" />" data-options="" style="padding:10px">
	<table class="table_type1">
		<caption><spring:message code="column.goods.filt" /></caption>
		<tbody id="filtTbody">
			<c:if test="${empty filterList}">
				<tr>
					<th><spring:message code="column.goods.filt.unSelected.category"/></th>
				</tr>
			</c:if>
		</tbody>
	</table>
</div>
<hr />