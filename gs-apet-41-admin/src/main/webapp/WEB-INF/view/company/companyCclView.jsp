<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>

		<table class="table_type1">
			<caption>업체 정산 등록</caption>
			<tbody>
<%--
				<tr>
					<th><spring:message code="column.comp_ccl_cd"/><strong class="red">*</strong></th>
					<td>
						<!-- 업체 정산 코드-->
						<select class="wth100" name="compCclCd" id="compCclCd" title="<spring:message code="column.comp_ccl_cd"/>">
							<frame:select grpCd="${adminConstants.COMP_CCL}"/>
						</select>
					</td>
				</tr>
 --%>
				<tr>
					<th><spring:message code="column.cms_rate"/><strong class="red">*</strong></th>
					<td>
						<!-- 업체 정산 코드-->
						<input type="hidden" name="compCclCd" value="${adminConstants.COMP_CCL_10}" />
						<!-- 수수료 율-->
						<input type="text" class="rateOnly validate[required, custom[onlyDecimal]]" name="cmsRate" id="cmsRate" title="<spring:message code="column.cms_rate"/>" value="" />%
					</td>
				</tr>
			</tbody>
		</table>