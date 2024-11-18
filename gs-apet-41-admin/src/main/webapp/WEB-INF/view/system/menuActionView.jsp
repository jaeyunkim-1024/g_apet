<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
				<div class="mTitle mt30">
					<h2>하위메뉴 기능 상세</h2>
				</div>
				
				<div class="box">
					<form name="menuActionForm" id="menuActionForm">
					<table class="table_type1">
						<caption>메뉴 등록</caption>
						<tbody>
							<tr>
								<th><spring:message code="column.menu_no"/><strong class="red">*</strong></th>
								<td>
									<!-- 메뉴 번호-->
									<input type="text" class="readonly validate[required]" readonly="readonly" name="menuNo" id="menuNo" title="<spring:message code="column.menu_no"/>" value="${empty menuAction.menuNo ? menuActionResult.menuNo : menuAction.menuNo}" />
								</td>
								<th><spring:message code="column.act_no"/><strong class="red">*</strong></th>
								<td>
									<input type="text" class="readonly" readonly="readonly" name="actNo" id="actNo" title="<spring:message code="column.act_no"/>" value="${menuAction.actNo}" />
								</td>
							</tr>
							<tr>
								<th><spring:message code="column.act_nm"/><strong class="red">*</strong></th>
								<td colspan="3">
									<!-- 기능 명-->
									<input type="text" class="validate[required, maxSize[100]]" name="actNm" id="actNm" title="<spring:message code="column.act_nm"/>" value="${menuAction.actNm}" />
								</td>
							</tr>
							<tr>
								<th><spring:message code="column.url"/><strong class="red">*</strong></th>
								<td colspan="3">
									<!-- URL-->
									<input type="text" class="w300 validate[required, maxSize[200]]" name="url" id="url" title="<spring:message code="column.url"/>" value="${menuAction.url}" />
								</td>
							</tr>
							<tr>
								<th><spring:message code="column.act_gb_cd"/><strong class="red">*</strong></th>
								<td>
									<!-- 기능 구분 코드-->
									<select class="validate[required]" name="actGbCd" id="actGbCd" title="<spring:message code="column.act_gb_cd"/>">
										<frame:select grpCd="${adminConstants.ACT_GB}" selectKey="${menuAction.actGbCd}" />
									</select>
								</td>
								<th><spring:message code="column.use_yn"/><strong class="red">*</strong></th>
								<td>
									<!-- 사용 여부-->
									<select class="validate[required]" name="useYn" id="useYn" title="<spring:message code="column.use_yn"/>" >
										<frame:select grpCd="${adminConstants.USE_YN}" selectKey="${menuAction.useYn}"/>
									</select>
								</td>
							</tr>
						<c:if test="${not empty menuAction}">
							<tr>
								<th><spring:message code="column.sys_regr_nm" /></th>
								<td>
									${menuAction.sysRegrNm}
								</td>
								<th><spring:message code="column.sys_reg_dtm" /></th>
								<td>
									<fmt:formatDate value="${menuAction.sysRegDtm}" pattern="yyyy-MM-dd HH:mm:ss"/>
								</td>
							</tr>
							<tr>
								<th><spring:message code="column.sys_updr_nm" /></th>
								<td>
									${menuAction.sysUpdrNm}
								</td>
								<th><spring:message code="column.sys_upd_dtm" /></th>
								<td>
									<fmt:formatDate value="${menuAction.sysUpdDtm}" pattern="yyyy-MM-dd HH:mm:ss"/>
								</td>
							</tr>
						</c:if>
						</tbody>
					</table>
					</form>
					
					<div class="btn_area_center">
						<c:set var="btnTxt" value="등록" />
						<c:if test="${not empty menuAction}">
							<c:set var="btnTxt" value="수정" />
						</c:if>

						<button type="button" onclick="menuActionView('',null);" class="btn btn-cancel">신규</button>
						<button type="button" onclick="menuActionSave();" class="btn btn-ok">${btnTxt}</button>

						<c:if test="${not empty menuAction}">
							<button type="button" onclick="menuActionDelete();" class="btn btn-add">삭제</button>
						</c:if>
					</div>
				</div>
	
	