<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>

<div title="Tag" style="padding:10px">
<form id="tagGoodsListForm" name="tagGoodsListForm" method="post" >
				<table class="table_type1">
					<caption>Tag</caption>
					<tbody>
						<tr>
							<th><spring:message code="column.tag_no"/></th>
							<td>
								<input type="text" class="readonly" name="tagNo" id="tagNo" title="<spring:message code="column.tag_no"/>" value="${tagBase.tagNo}" />
							</td>
							<th><spring:message code="column.tag_nm" /></th>	<!-- Tag 명-->
							<!-- 상품 상태 -->
							<td>
								<input type="text" class="readonly" readonly="readonly" name="tagNm" id="tagNm" title="<spring:message code="column.tag_nm" />" value="${tagBase.tagNm}" />
							</td>
						</tr>
					</tbody>
				</table>
</form>
</div>

				<br/>
				<br/>
				
				<div title="관련 상품" style="padding:10px">
				<table id="layerTagGoodsList" ></table>
				<div id="layerTagGoodsListPage"></div>
				</div>
				