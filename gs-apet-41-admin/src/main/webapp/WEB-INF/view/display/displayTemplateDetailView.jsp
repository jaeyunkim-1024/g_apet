<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
	<form id="templateViewForm">
		<table class="table_type1">
			<caption>템플릿 상세</caption>
			<colgroup>
				<col class="th-s" />
				<col />
			</colgroup>
			<tbody>
				<c:if test="${not empty displayTemplate}">
					<tr>
						<th><spring:message code="column.tmpl_no" /><strong class="red">*</strong></th>
						<td>
							<input type="text" class="readonly" name="tmplNo" id="tmplNo" title="<spring:message code="column.tmpl_no"/>" value="${displayTemplate.tmplNo}" readonly="readonly" />
						</td>
					</tr>
				</c:if>
				<tr>
					<th><spring:message code="column.tmpl_nm" /><strong class="red">*</strong></th>
					<td>
						<!-- 템플릿 명-->
						<input type="text" class="input_text validate[required, maxSize[30]]" name="tmplNm" id="tmplNm" title="<spring:message code="column.tmpl_nm"/>" value="${displayTemplate.tmplNm}" />
					</td>
				</tr>
				<tr>
					<th><spring:message code="column.st_id" /><strong class="red">*</strong></th>
					<td>
						<!-- 사이트 아이디-->
						<frame:stId funcNm="searchSt(1)" requireYn="Y" defaultStNm="${displayTemplate.stNm }" defaultStId="${displayTemplate.stId }" />
					</td>
				</tr>
				<tr>
					<th><spring:message code="column.pcweb_url"/></th>
					<td>
						<!-- PC웹 URL-->
						<input type="text" class="" name="pcwebUrl" id="pcwebUrl" title="<spring:message code="column.pcweb_url"/>" value="${displayTemplate.pcwebUrl}" />
					</td>
				</tr>
				<tr>
					<th><spring:message code="column.mobile_url"/></th>
					<td>
						<!-- 모바일 URL-->
						<input type="text" class="" name="mobileUrl" id="mobileUrl" title="<spring:message code="column.mobile_url"/>" value="${displayTemplate.mobileUrl}" />
					</td>
				</tr>
				<tr>
					<th><spring:message code="column.tmpl_dscrt"/></th>
					<td>
						<!-- 템플릿 설명-->
						<input type="text" class="" name="tmplDscrt" id="tmplDscrt" title="<spring:message code="column.tmpl_dscrt"/>" value="${displayTemplate.tmplDscrt}" />
					</td>
				</tr>
				<c:if test="${not empty displayTemplate}">
					<tr>
						<th><spring:message code="column.sys_regr_nm" /></th>
						<td>
							${displayTemplate.sysRegrNm}
						</td>
					</tr>
					<tr>
						<th><spring:message code="column.sys_reg_dtm" /></th>
						<td>
							<fmt:formatDate value="${displayTemplate.sysRegDtm}" pattern="yyyy-MM-dd HH:mm:ss"/>
						</td>
					</tr>
					<tr>
						<th><spring:message code="column.sys_updr_nm" /></th>
						<td>
							${displayTemplate.sysUpdrNm}
						</td>
					</tr>
					<tr>
						<th><spring:message code="column.sys_upd_dtm" /></th>
						<td>
							<fmt:formatDate value="${displayTemplate.sysUpdDtm}" pattern="yyyy-MM-dd HH:mm:ss"/>
						</td>
					</tr>
				</c:if>
			</tbody>
		</table>
		
		<div class="btn_area_center">
			<button type="button" onclick="javascript:templateView('');" class="btn btn-cancel">신규</button>
			<c:if test="${empty displayTemplate}">
				<button type="button" onclick="javascript:templateInsert();" class="btn btn-ok">등록</button>
			</c:if>
			<c:if test="${not empty displayTemplate}">
				<button type="button" onclick="javascript:templateUpdate();" class="btn btn-ok">수정</button>
			</c:if>
			<c:if test="${not empty displayTemplate}">
				<button type="button" onclick="javascript:templateDelete();" class="btn btn-add">삭제</button>
			</c:if>
		</div>
	
	</form>