<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>

	
<script type="text/javascript">
$(document).ready(function(){
	var stIds = new Array();
	<c:forEach items="${stIds}" var="item">
		stIds.push("${item}");
	</c:forEach>
	$("#stIds").val(stIds);
	
	$("#layerCompanySearchForm #compTpCd").bind('change', function(){
		if(this.value == "${adminConstants.COMP_TP_30}") {
			$("#layerCompanySearchForm #bndNm").attr("disabled", true);
		} else {
			$("#layerCompanySearchForm #bndNm").attr("disabled", false);
		} 
	})
	
	//엔터키 	
	$(document).on("keydown","#layerCompanySearchForm input",function(){
		if ( window.event.keyCode == 13 ) {
			layerCompanyList.reload();
	  		}
    });
	
})
</script>  	

<form id="layerCompanySearchForm" name="layerCompanySearchForm" method="post" >
	<table class="table_type1 popup">
		<caption>정보 검색</caption>
		<tbody>
			<input id="stId" name="stId" type="hidden" value="${stId}" />
 			<input id="stIds" name="stIds" type="hidden" />
 			<input id="excludeCompStatCd" name="excludeCompStatCd" type="hidden" value="${excludeCompStatCd }" />
 			<input id="excludeCompTpCd" name="excludeCompTpCd" type="hidden" value="${excludeCompTpCd }" />
			<tr>
				<th scope="row"><spring:message code="column.comp_stat_cd" /></th>
				<td>
					<select name="compStatCd" id="compStatCd" title="<spring:message code="column.comp_stat_cd" />" <c:if test="${selectKeyOnlyCompStatCd}">disabled</c:if>>
						<frame:select grpCd="${adminConstants.COMP_STAT}" selectKey="${compStatCd}" readOnly="${readOnlyCompStatCd }" defaultName="${readOnlyCompStatCd ? '' : '전체' }" excludeOption="${excludeCompStatCd }" />
					</select>
				</td>
                <th scope="row"><spring:message code="column.comp_nm" /></th>
                <td>
                    <input type="text" name="compNm" title="<spring:message code="column.comp_nm" />" >
                </td>
			</tr>
			<tr>
                <%-- <th scope="row"><spring:message code="column.bnd_nm" /></th>
                <td>
                     <input type="text" id="bndNm" name="bndNm" title="<spring:message code="column.bnd_nm" />">
                     <p class="mg5 blue-desc">* 브랜드명으로 검색할 때만 목록에 브랜드명이 표시됩니다.</p>
                </td>		 --%>
				<th scope="row"><spring:message code="column.comp_tp_cd" /></th>
				<td colspan="3">
					<select name="compTpCd" id="compTpCd" title="<spring:message code="column.comp_tp_cd" />" <c:if test="${selectKeyOnlyCompTpCd}">disabled</c:if>>
						<frame:select grpCd="${adminConstants.COMP_TP}" selectKey="${compTpCd}" readOnly="${readOnlyCompTpCd }" defaultName="${readOnlyCompTpCd ? '' : '전체' }" excludeOption="${excludeCompTpCd }" />
					</select>
				</td>	
			</tr>
		</tbody>
	</table>
</form>

	<div class="btn_area_center mb30">
		<button type="button" onclick="layerCompanyList.reload();" class="btn btn-ok">검색</button>
		<button type="button" onclick="layerCompanyList.searchReset();" class="btn btn-cancel">초기화</button>
	</div>
	
	<table id="layerCompanyList" ></table>
	<div id="layerCompanyListPage"></div>