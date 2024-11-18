<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
			<script type="text/javascript">
				$(function(){
					//$("[name='usrDfn4Val'] , [name='usrDfn5Val']").parent().parent().hide();
					$("#codeDetailForm [name='useYn'] option[value='${adminConstants.COMM_YN_N}']").text("미사용");
				})
			</script>
							<form id="codeDetailForm">
							<table class="table_type1">
								<caption>코드 등록</caption>
								<colgroup>
									<col style="width:150px;" />
									<col />
								</colgroup>
								<tbody>
									<tr>
										<th><spring:message code="column.grp_cd" /><strong class="red">*</strong></th>
										<td>
											<input type="text" class="readonly validate[required, maxSize[20]]" name="grpCd" title="<spring:message code="column.grp_cd" />" value="${codeDetailSO.grpCd}" readonly="readonly" />
										</td>
									</tr>
									<tr>
										<th><spring:message code="column.dtl_cd" /><strong class="red">*</strong></th>
										<td>
											<input type="text" class="${not empty codeDetail ? 'readonly' : ''} validate[required, maxSize[10], custom[onlyEngNum]]" name="dtlCd" title="<spring:message code="column.dtl_cd" />" value="${codeDetail.dtlCd}" ${not empty codeDetail ? 'readonly="readonly"' : ''}/>
										</td>
									</tr>
									<tr>
										<th><spring:message code="column.dtl_nm" /><strong class="red">*</strong></th>
										<td>
											<input type="text" class="validate[required, maxSize[50]]" name="dtlNm" title="<spring:message code="column.dtl_nm" />" value="${codeDetail.dtlNm}"/>
										</td>
									</tr>
									<tr>
										<th><spring:message code="column.dtl_sht_nm" /><strong class="red">*</strong></th>
										<td>
											<input type="text" class="validate[required, maxSize[30]]" name="dtlShtNm" title="<spring:message code="column.dtl_sht_nm" />" value="${codeDetail.dtlShtNm}"/>
										</td>
									</tr>
									<tr>
										<th><spring:message code="column.sort_seq" /><strong class="red">*</strong></th>
										<td>
											<input type="text" class="numeric validate[required, custom[onlyNum], min[1], max[999]]" maxlength="3" name="sortSeq" title="<spring:message code="column.sort_seq" />" value="${codeDetail.sortSeq}"/>
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
									<tr>
										<th><spring:message code="column.usr_dfn1_nm" /></th>
										<td>
											<input type="text" class="validate[maxSize[200]]" name="usrDfn1Val" title="<spring:message code="column.usr_dfn1_val" />" value="${codeDetail.usrDfn1Val}"/>
										</td>
									</tr>
									<tr>
										<th><spring:message code="column.usr_dfn2_nm" /></th>
										<td>
											<input type="text" class="validate[maxSize[200]]" name="usrDfn2Val" title="<spring:message code="column.usr_dfn2_val" />" value="${codeDetail.usrDfn2Val}"/>
										</td>
									</tr>
									<tr>
										<th><spring:message code="column.usr_dfn3_nm" /></th>
										<td>
											<input type="text" class="validate[maxSize[200]]" name="usrDfn3Val" title="<spring:message code="column.usr_dfn3_val" />" value="${codeDetail.usrDfn3Val}"/>
										</td>
									</tr>
									<tr>
										<th><spring:message code="column.usr_dfn4_nm" /></th>
										<td>
											<input type="text" class="validate[maxSize[200]]" name="usrDfn4Val" title="<spring:message code="column.usr_dfn4_val" />" value="${codeDetail.usrDfn4Val}"/>
										</td>
									</tr>
									<tr>
										<th><spring:message code="column.usr_dfn5_nm" /></th>
										<td>
											<input type="text" class="validate[maxSize[200]]" name="usrDfn5Val" title="<spring:message code="column.usr_dfn5_val" />" value="${codeDetail.usrDfn5Val}"/>
										</td>
									</tr>
								<c:if test="${not empty codeDetail}">
									<tr>
										<th><spring:message code="column.sys_regr_nm" /></th>
										<td>
											${codeDetail.sysRegrNm}
										</td>
									</tr>
									<tr>
										<th><spring:message code="column.sys_reg_dtm" /></th>
										<td>
											<fmt:formatDate value="${codeDetail.sysRegDtm}" pattern="yyyy-MM-dd HH:mm:ss"/>
										</td>
									</tr>
									<tr>
										<th><spring:message code="column.sys_updr_nm" /></th>
										<td>
											${codeDetail.sysUpdrNm}
										</td>
									</tr>
									<tr>
										<th><spring:message code="column.sys_upd_dtm" /></th>
										<td>
											<fmt:formatDate value="${codeDetail.sysUpdDtm}" pattern="yyyy-MM-dd HH:mm:ss"/>
										</td>
									</tr>
								</c:if>
								</tbody>
							</table>
							</form>
							
							<div class="btn_area_center">
								<button type="button" onclick="codeDetailView('${codeDetailSO.grpCd}', '');" class="btn btn-cancel">초기화</button>
								<c:if test="${empty codeDetail}">
								<button type="button" onclick="codeDetailInsert();" class="btn btn-ok">등록</button>
								</c:if>
								<c:if test="${not empty codeDetail}">
								<button type="button" onclick="codeDetailUpdate();" class="btn btn-ok">수정</button>
								<button type="button" onclick="codeDetailDelete();" class="btn btn-add">삭제</button>
								</c:if>
							</div>