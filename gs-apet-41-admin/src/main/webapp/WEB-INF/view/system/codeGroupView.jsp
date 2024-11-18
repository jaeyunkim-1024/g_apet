<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
				<script>
					$(function(){
						//$("[name='usrDfn4Nm'] , [name='usrDfn5Nm']").parent().parent().hide();
						$("#codeGroupForm [name='${adminConstants.COMM_YN}'] option[value='${adminConstants.COMM_YN_N}']").text("미사용");
					})
				</script>
							<input type="hidden" id="originGrpNm" value="${codeGroup.grpNm}" />
							<form id="codeGroupForm">
							<table class="table_type1">
								<caption>공통코드 등록</caption>
								<colgroup>
									<col style="width:150px;" />
									<col />
								</colgroup>
								<tbody>
									<tr>
										<th><spring:message code="column.grp_cd" /><strong class="red">*</strong></th>
										<td>
											<input type="text" class="${not empty codeGroup ? 'readonly' : ''} validate[required, maxSize[20]]" name="grpCd" title="<spring:message code="column.grp_cd" />" value="${codeGroup.grpCd}" ${not empty codeGroup ? 'readonly="readonly"' : ''} />
										</td>
									</tr>
									<tr>
										<th><spring:message code="column.grp_nm" /><strong class="red">*</strong></th>
										<td>
											<input type="text" class="validate[required, maxSize[50]]" name="grpNm" title="<spring:message code="column.grp_nm" />" value="${codeGroup.grpNm}"/>
										</td>
									</tr>
									<tr>
										<th><spring:message code="column.usr_dfn1_nm" /></th>
										<td>
											<input type="text" class="validate[maxSize[50]]" name="usrDfn1Nm" title="<spring:message code="column.usr_dfn1_nm" />" value="${codeGroup.usrDfn1Nm}"/>
										</td>
									</tr>
									<tr>
										<th><spring:message code="column.usr_dfn2_nm" /></th>
										<td>
											<input type="text" class="validate[maxSize[50]]" name="usrDfn2Nm" title="<spring:message code="column.usr_dfn2_nm" />" value="${codeGroup.usrDfn2Nm}"/>
										</td>
									</tr>
									<tr>
										<th><spring:message code="column.usr_dfn3_nm" /></th>
										<td>
											<input type="text" class="validate[maxSize[50]]" name="usrDfn3Nm" title="<spring:message code="column.usr_dfn3_nm" />" value="${codeGroup.usrDfn3Nm}"/>
										</td>
									</tr>
									<tr>
										<th><spring:message code="column.usr_dfn4_nm" /></th>
										<td>
											<input type="text" class="validate[maxSize[50]]" name="usrDfn4Nm" title="<spring:message code="column.usr_dfn4_nm" />" value="${codeGroup.usrDfn4Nm}"/>
										</td>
									</tr>
									<tr>
										<th><spring:message code="column.usr_dfn5_nm" /></th>
										<td>
											<input type="text" class="validate[maxSize[50]]" name="usrDfn5Nm" title="<spring:message code="column.usr_dfn5_nm" />" value="${codeGroup.usrDfn5Nm}"/>
										</td>
									</tr>
								<c:if test="${not empty codeGroup}">
									<tr>
										<th><spring:message code="column.sys_regr_nm" /></th>
										<td>
											${codeGroup.sysRegrNm}
										</td>
									</tr>
									<tr>
										<th><spring:message code="column.sys_reg_dtm" /></th>
										<td>
											<fmt:formatDate value="${codeGroup.sysRegDtm}" pattern="yyyy-MM-dd HH:mm:ss"/>
										</td>
									</tr>
									<tr>
										<th><spring:message code="column.sys_updr_nm" /></th>
										<td>
											${codeGroup.sysUpdrNm}
										</td>
									</tr>
									<tr>
										<th><spring:message code="column.sys_upd_dtm" /></th>
										<td>
											<fmt:formatDate value="${codeGroup.sysUpdDtm}" pattern="yyyy-MM-dd HH:mm:ss"/>
										</td>
									</tr>
								</c:if>
								</tbody>
							</table>
							</form>
							
							<div class="btn_area_center">
								<button type="button" onclick="codeGroupView('');" class="btn btn-cancel">초기화</button>
								<c:if test="${empty codeGroup}">
								<button type="button" onclick="codeGroupInsert();" class="btn btn-ok">등록</button>
								</c:if>
								<c:if test="${not empty codeGroup}">
								<button type="button" onclick="codeGroupUpdate();" class="btn btn-ok">수정</button>
								<button type="button" onclick="codeGroupDelete();" class="btn btn-add">삭제</button>
								</c:if>
							</div>

							