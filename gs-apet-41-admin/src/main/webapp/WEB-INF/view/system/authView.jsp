<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
							<form name="authForm" id="authForm" method="post">
							<table class="table_type1">
								<caption>권한 등록</caption>
								<colgroup>
									<col style="width:140px;" />
									<col />
								</colgroup>
								<tbody>
									<tr>
										<th><spring:message code="column.auth_no"/><strong class="red">*</strong></th>
										<td>
											<!-- 권한 번호-->
											<input type="text" class="readonly" readonly="readonly" name="authNo" id="authNo" title="<spring:message code="column.auth_no"/>" value="${auth.authNo }" />
										</td>
									</tr>
									<tr>
										<th><spring:message code="column.auth_nm"/><strong class="red">*</strong></th>
										<td>
											<!-- 권한 명-->
											<input type="text" class="validate[required, maxSize[50]]" name="authNm" id="authNm" title="<spring:message code="column.auth_nm"/>" value="${auth.authNm }" />
										</td>
									</tr>
									<tr>
										<th><spring:message code="column.mn_url"/></th>
										<td>
											<!-- 메인 URL -->
											<input type="text" class="validate[maxSize[200]]" name="mnUrl" id="mnUrl" title="<spring:message code="column.mn_url"/>" value="${auth.mnUrl }" />
										</td>
									</tr>
									<tr>
										<th><spring:message code="column.use_yn"/><strong class="red">*</strong></th>
										<td>
											<!-- 사용 여부-->
											<select class="wth100" name="useYn" id="useYn" title="<spring:message code="column.use_yn"/>" >
												<frame:select grpCd="${adminConstants.USE_YN}" selectKey="${auth.useYn }"/>
											</select>
										</td>
									</tr>
								<c:if test="${not empty auth}">
									<tr>
										<th><spring:message code="column.sys_regr_nm" /></th>
										<td>
											${auth.sysRegrNm}
										</td>
									</tr>
									<tr>
										<th><spring:message code="column.sys_reg_dtm" /></th>
										<td>
											<fmt:formatDate value="${auth.sysRegDtm}" pattern="yyyy-MM-dd HH:mm:ss"/>
										</td>
									</tr>
									<tr>
										<th><spring:message code="column.sys_updr_nm" /></th>
										<td>
											${auth.sysUpdrNm}
										</td>
									</tr>
									<tr>
										<th><spring:message code="column.sys_upd_dtm" /></th>
										<td>
											<fmt:formatDate value="${auth.sysUpdDtm}" pattern="yyyy-MM-dd HH:mm:ss"/>
										</td>
									</tr>
								</c:if>
								</tbody>
							</table>
							</form>
							
							<div class="btn_area_center">
								<button type="button" onclick="authView();" class="btn btn-cancel">초기화</button>
								<button type="button" onclick="authSave();" class="btn btn-ok">${empty auth ? '등록' : '수정' }</button>
								<c:if test="${not empty auth}">
								<button type="button" onclick="authDelete('${auth.authNo }');" class="btn btn-add">삭제</button>
								</c:if>
							</div>