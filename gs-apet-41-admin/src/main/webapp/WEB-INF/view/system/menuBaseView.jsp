<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
				<div class="mTitle">
					<h2>메뉴 상세</h2>
				</div>
				<div class="box">
					<form name="menuBaseForm" id="menuBaseForm">
					<table class="table_type1">
						<caption>메뉴 등록</caption>
						<tbody>
							<tr>
								<th><spring:message code="column.menu_no"/><strong class="red">*</strong></th>
								<td>
									<!-- 메뉴 번호-->
									<input type="text" class="readonly" readonly="readonly" name="menuNo" id="menuNo" title="<spring:message code="column.menu_no"/>" value="${menuBase.menuNo}" />
								</td>
								<th><spring:message code="column.up_menu_no"/><strong class="red">*</strong></th>
								<td>
									<!-- 상위 메뉴 번호-->
									<c:set var="upMenuNo" value="${empty menuBase.upMenuNo ? menuResult.upMenuNo : menuBase.upMenuNo}" />
									<input type="text" class="readonly validate[required]" readonly="readonly" name="upMenuNo" id="upMenuNo" title="<spring:message code="column.up_menu_no"/>" value="${empty upMenuNo ? adminConstants.MENU_DEFAULT_NO : upMenuNo}" />
								</td>
							</tr>
							<tr>
								<th><spring:message code="column.menu_nm"/><strong class="red">*</strong></th>
								<td colspan="3">
									<!-- 메뉴 명-->
									<input type="text" class="validate[required, maxSize[100]]" name="menuNm" id="menuNm" title="<spring:message code="column.menu_nm"/>" value="${menuBase.menuNm}" />
								</td>
							</tr>
							<tr>
								<th><spring:message code="column.sort_seq"/><strong class="red">*</strong></th>
								<td>
									<!-- 정렬 순서-->
									<input type="text" class="numeric validate[required, custom[onlyNum], min[1], max[999]]" name="sortSeq" id="sortSeq" title="<spring:message code="column.sort_seq"/>" value="${menuBase.sortSeq}" />
								</td>
								<th><spring:message code="column.use_yn"/><strong class="red">*</strong></th>
								<td>
									<!-- 사용 여부-->
									<select class="wth100" name="useYn" id="useYn" title="<spring:message code="column.use_yn"/>" >
										<frame:select grpCd="${adminConstants.USE_YN}" selectKey="${menuBase.useYn}"/>
									</select>
								</td>
							</tr>
						<c:if test="${not empty menuBase.menuNo}">
							<tr>
								<th><spring:message code="column.sys_regr_nm" /></th>
								<td>
									${menuBase.sysRegrNm}
								</td>
								<th><spring:message code="column.sys_reg_dtm" /></th>
								<td>
									<fmt:formatDate value="${menuBase.sysRegDtm}" pattern="yyyy-MM-dd HH:mm:ss"/>
								</td>
							</tr>
							<tr>
								<th><spring:message code="column.sys_updr_nm" /></th>
								<td>
									${menuBase.sysUpdrNm}
								</td>
								<th><spring:message code="column.sys_upd_dtm" /></th>
								<td>
									<fmt:formatDate value="${menuBase.sysUpdDtm}" pattern="yyyy-MM-dd HH:mm:ss"/>
								</td>
							</tr>
						</c:if>
						</tbody>
					</table>
					</form>
					
					<div class="btn_area_center">
						<c:if test="${not empty menuBase.menuNo}">
							<button type="button" onclick="menuBaseAddView();" class="btn btn-add">신규</button>
						</c:if>
						<button type="button" onclick="menuSave();" class="btn btn-ok">${empty menuBase.menuNo ? '등록' : '수정'}</button>
					<c:if test="${not empty menuBase.menuNo}">
						<button type="button" onclick="menuDelete('${menuBase.menuNo}');" class="btn">삭제</button>
					</c:if>
					</div>
				</div>
				