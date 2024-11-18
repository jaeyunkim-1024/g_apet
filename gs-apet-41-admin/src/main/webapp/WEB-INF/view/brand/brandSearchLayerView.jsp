<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
	
<script type="text/javascript">
$(document).ready(function(){
	
	//엔터키 	
	$(document).on("keydown","#brandListForm #bndNoArea, #bndNmArea",function(){
		if (event.keyCode == 13) {
			if (!event.ctrlKey ){ //|| !event.metaKey
				event.preventDefault();
				console.log('enter key')
				layerBrandList.searchBrandList();
			} else {
				console.log('ctrl + enter key')
				var start = this.selectionStart;
				var end = this.selectionEnd;
				this.value = this.value.substring(0, end) + '\r\n' + this.value.substring(end);
				this.selectionEnd = end;
				this.selectionStart = this.selectionEnd = start + 1;
			}
		}
    });
})
</script>  	

<form id="brandListForm" name="brandListForm" method="post" >
	<input type="hidden" name="useYn" value="${brandBase.useYn}"/>
				<table class="table_type1">
					<caption>정보 검색</caption>
					<tbody>
<%--
						<tr>
							<th scope="row"><spring:message code="column.goods.comp_no" /></th> <!-- 업체번호 -->
							<td>
								<input type="hidden" id="compNo" name="compNo" title="<spring:message code="column.goods.comp_no" />" value="${param.compNo}" />
								<input type="text" class="readonly" id="compNm" name="compNm" title="<spring:message code="column.goods.comp_nm" />" value="${param.compNm}"   ${not empty param.compNm ? 'disabled="disabled"' : ''}/>
								<button type="button" onclick="layerBrandList.searchCompany();" class="btn"><spring:message code="column.search" /></button>
							</td>
							<th scope="row"><spring:message code='column.bnd_gb_cd' /></th> <!-- 브랜드 구분 -->
							<td>
								<select id="bndGbCd" name="bndGbCd" ${not empty brandBase.bndGbCd ? 'disabled="disabled"' : ''}>
									<frame:select grpCd="${adminConstants.BND_GB }" selectKey="${brandBase.bndGbCd }" defaultName="선택" showValue="true" />
								</select>
							</td>
						</tr>
--%>
						<tr>
							<th scope="row"><spring:message code="column.bnd_no" /></th> <!-- 상품 ID -->
							<td>
								<textarea rows="3" cols="30" id="bndNoArea" name="bndNoArea" ></textarea>
							</td>
							<th scope="row"><spring:message code="column.bnd_nm" /></th> <!-- 상품 명 -->
							<td>
								<textarea rows="3" cols="30" id="bndNmArea" name="bndNmArea" ></textarea>
							</td>
						</tr>
					</tbody>
				</table>
</form>

				<div class="btn_area_center mb30">
					<button type="button" onclick="layerBrandList.searchBrandList();" class="btn btn-ok">검색</button>
					<button type="button" onclick="layerBrandList.searchReset();" class="btn btn-cancel">초기화</button>
				</div>
				
				<table id="layerBrandList" ></table>
				<div id="layerBrandListPage"></div>
