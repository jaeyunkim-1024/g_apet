<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>

<table class="table_type1 mt20">
	<caption>GOODS 등록</caption>
	<colgroup>
		<col style="width:520px">
		<col />
	</colgroup>
	<tbody>
		<c:forEach items="${notifyItem }" var="notiItem" varStatus="cnt" >
			<tr>
				<th scope="row">${notiItem.itemNm }</th>
				<td>
					<input type="hidden" id="ntfItemId${notiItem.ntfItemId }" name="ntfItemId" value="${notiItem.ntfItemId }" />
					<c:choose>
						<c:when test="${notiItem.inputMtdCd eq adminConstants.INPUT_MTD_10 }">
							<input type="text" class="w500 validate[required maxSize[200]]" id="itemVal${notiItem.ntfItemId }" name="itemVal" title="${notiItem.itemNm }" value="${notiItem.itemVal }" />
						</c:when>
						<c:otherwise>
							<textarea class="w500 validate[required]" rows="3" cols="150" id="itemVal${notiItem.ntfItemId }" name="itemVal" title="${notiItem.itemNm }" onchange="javascript:fnByteChk(this);" >${notiItem.itemVal }
							<c:if test="${empty notiItem.itemVal and notiItem.ntfItemId eq '321'}">상품상세설명 참조</c:if>
							<c:if test="${empty notiItem.itemVal and notiItem.ntfItemId eq '324'}">어바웃펫 // 1644-9601</c:if>
							</textarea>
						</c:otherwise>
					</c:choose>
					<c:if test="${notiItem.ntfId eq '35' and (notiItem.ntfItemId eq '320' || notiItem.ntfItemId eq '322' || notiItem.ntfItemId eq '323')}">
						<span name="autoSpan">
							<input type="checkbox" id="autoWrite${notiItem.ntfItemId }" name="autoWrite" value="${notiItem.ntfItemId }"/><spring:message code="column.goods.auto_write"/>
						</span>
					</c:if>
				</td>
			</tr>
		</c:forEach>
	</tbody>
</table>

<script type="text/javascript">
	$(function(){
		if($("#ntfId").val() == '35'){
			var cnt = 0;
			<c:forEach items="${notifyItem }" var="notiItem" varStatus="cnt" >
				if('${notiItem.itemVal}' != ''){
					cnt++;
				}
			</c:forEach>
			if(cnt == 0){
				$('#autoWriteAll').trigger('click');
			}
		}
	})
</script>