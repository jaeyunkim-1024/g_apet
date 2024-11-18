<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<input type="hidden" id="originfiltGrpMngNm" value="${codeGroup.filtGrpMngNm}"/>
<input type="hidden" id="originfiltGrpShowNm" value="${codeGroup.filtGrpShowNm}"/>
<form id="codeGroupForm">
	<table class="table_type1">
		<caption>필터 그룹 등록</caption>
		<colgroup>
			<col style="width:150px;"/>
			<col/>
		</colgroup>
		<tbody>
		<tr>
			<th><spring:message code="column.filtGrpNo"/><strong class="red">*</strong></th>
			<td>${codeGroup.filtGrpNo}
				<input type="hidden" name="filtGrpNo"  value="${codeGroup.filtGrpNo}" ${not empty codeGroup ? 'readonly="readonly"' : ''} />
			</td>
		</tr>
		<tr>
			<th><spring:message code="column.filtGrpMngNm"/><strong class="red">*</strong></th>
			<td>
				<input type="text" class="validate[required, maxSize[50]]" name="filtGrpMngNm"
					   title="<spring:message code="column.filtGrpMngNm" />" value="${codeGroup.filtGrpMngNm}"/>
			</td>
		</tr>
		<tr>
			<th><spring:message code="column.filtGrpShowNm"/><strong class="red">*</strong></th>
			<td>
				<input type="text" class="validate[required, maxSize[50]]" name="filtGrpShowNm"
					   title="<spring:message code="column.filtGrpShowNm" />" value="${codeGroup.filtGrpShowNm}"/>
			</td>
		</tr>
		<c:if test="${not empty codeGroup}">
			<tr>
				<th><spring:message code="column.sys_regr_nm"/></th>
				<td>
						${codeGroup.sysRegrNm}
				</td>
			</tr>
			<tr>
				<th><spring:message code="column.sys_reg_dtm"/></th>
				<td>
					<fmt:formatDate value="${codeGroup.sysRegDtm}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
			</tr>
			<tr>
				<th><spring:message code="column.sys_updr_nm"/></th>
				<td>
						${codeGroup.sysUpdrNm}
				</td>
			</tr>
			<tr>
				<th><spring:message code="column.sys_upd_dtm"/></th>
				<td>
					<fmt:formatDate value="${codeGroup.sysUpdDtm}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
			</tr>
		</c:if>
		</tbody>
	</table>
</form>

<div class="btn_area_center">
	<button type="button" onclick="fnFiltGrpView('');" class="btn btn-cancel">신규</button>
	<c:if test="${empty codeGroup}">
		<button type="button" onclick="fnFiltGrpInsert();" class="btn btn-ok">등록</button>
	</c:if>
	<c:if test="${not empty codeGroup}">
		<button type="button" onclick="fnFiltGrpUpdate();" class="btn btn-ok">수정</button>
		<button type="button" onclick="fnFiltGrpDelete();" class="btn btn-add">삭제</button>
	</c:if>
</div>

							