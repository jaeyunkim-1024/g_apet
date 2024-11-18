<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<script>
var imgUrl = '<frame:imgUrl />';
</script>
<form id="brandCntsListForm" name="brandCntsListForm" method="post" >
				<table class="table_type1">
					<caption>정보 검색</caption>
					<tbody>
						<tr>
							<th scope="row"><spring:message code="column.bnd_cnts_no" /></th>
							<td>
								<input type="text" name="bndCntsNo" id="snsShrNo" title="<spring:message code="column.bnd_cnts_no" />" >
							</td>
							<th scope="row"><spring:message code="column.cnts_ttl" /></th>
							<td>
								<input type="text" name="cntsTtl" id="cntsTtl" title="<spring:message code="column.cnts_ttl" />" >
							</td>					
						</tr>
						<tr>
							<th scope="row"><spring:message code="column.bnd_no" /></th>
							<td>
								<input type="text" name="bndNo" id="bndNo" title="<spring:message code="column.bnd_no" />" >
							</td>
							<th scope="row"><spring:message code="column.bnd_nm" /></th>
							<td>
								<input type="text" name="bndNm" id="bndNm" title="<spring:message code="column.bnd_nm" />" >
							</td>					
						</tr>
						<tr>
							<th scope="row"><spring:message code="column.cnts_gb_cd" /></th>	<!-- 상품 상태 -->
							<td colspan="3">
								<select id="cntsGbCd" name="cntsGbCd" >
									<frame:select grpCd="${adminConstants.CNTS_GB }" defaultName="선택" showValue="true" />
								</select>
							</td>
						</tr>
					</tbody>
				</table>
</form>

				<div class="btn_area_center">
					<button type="button" onclick="layerBrandCntsList.searchBrandCntsList();" class="btn btn-ok">검색</button>
					<button type="button" onclick="layerBrandCntsList.searchReset();" class="btn btn-cancel">초기화</button>
				</div>
				<hr />

				<table id="layerBrandCntsList" ></table>
				<div id="layerBrandCntsListPage"></div>
				