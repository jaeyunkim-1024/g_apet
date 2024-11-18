<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<form id="codeDetailForm">
	<table class="table_type1">
		<caption>필터 속성 등록</caption>
		<colgroup>
			<col style="width:150px;"/>
			<col/>
		</colgroup>
		<tbody>
		<tr>
			<th><spring:message code="column.filtGrpNo"/><strong class="red">*</strong></th>
			<td> ${codeDetailSo.filtGrpNo}
				<input type="hidden" name="filtGrpNo"  value="${codeDetailSo.filtGrpNo}" ${not empty codeDetailSo ? 'readonly="readonly"' : ''} />
			</td>
		</tr>
		<tr>
			<th><spring:message code="column.filtAttrSeq"/><strong class="red">*</strong></th>
			<td> ${codeDetail.filtAttrSeq}
				<input type="hidden" name="filtAttrSeq"  value="${codeDetail.filtAttrSeq}" ${not empty codeDetail ? 'readonly="readonly"' : ''} />
			</td>
		</tr>
		<tr>
			<th><spring:message code="column.filtAttrNm"/><strong class="red">*</strong></th>
			<td>
				<input type="text" class="validate[required, maxSize[50]]" name="filtAttrNm"
					   title="<spring:message code="column.filtAttrNm" />" value="${codeDetail.filtAttrNm}"/>
			</td>
		</tr>
		<tr>
			<th><spring:message code="column.use_yn" /><strong class="red">*</strong></th>
			<td>
				<select class="wth100" name="useYn">
					<frame:select grpCd="${adminConstants.USE_YN}" selectKey="${codeDetail.useYn}"/>
				</select>
			</td>
		</tr>

		<c:if test="${not empty codeDetail}">
			<tr>
				<th><spring:message code="column.sys_regr_nm"/></th>
				<td>
						${codeDetail.sysRegrNm}
				</td>
			</tr>
			<tr>
				<th><spring:message code="column.sys_reg_dtm"/></th>
				<td>
					<fmt:formatDate value="${codeDetail.sysRegDtm}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
			</tr>
			<tr>
				<th><spring:message code="column.sys_updr_nm"/></th>
				<td>
						${codeDetail.sysUpdrNm}
				</td>
			</tr>
			<tr>
				<th><spring:message code="column.sys_upd_dtm"/></th>
				<td>
					<fmt:formatDate value="${codeDetail.sysUpdDtm}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
			</tr>
		</c:if>
		</tbody>
	</table>
</form>

<div class="btn_area_center">
	<button type="button" onclick="fnFiltAttrView('${codeDetailSo.filtGrpNo}', '');" class="btn btn-cancel">신규</button>
	<c:if test="${empty codeDetail}">
		<button type="button" onclick="fnFiltAttrInsert();" class="btn btn-ok">등록</button>
	</c:if>
	<c:if test="${not empty codeDetail}">
		<button type="button" onclick="fnFiltAttrUpdate();" class="btn btn-ok">수정</button>
		<button type="button" onclick="fnFiltAttrDelete();" class="btn btn-add">삭제</button>
	</c:if>
</div>