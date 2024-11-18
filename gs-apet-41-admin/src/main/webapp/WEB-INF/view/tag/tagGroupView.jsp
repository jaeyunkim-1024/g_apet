<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
				<div class="mTitle">
					<h2>태그 그룹 상세</h2>
				</div>
				<div class="box">
					<form name="menuBaseForm" id="menuBaseForm">
					<table class="table_type1">
						<caption>태그 그룹 등록</caption>
						<tbody>
							<tr>
								<th><spring:message code="column.grp_no"/><strong class="red">*</strong></th>
								<td>
									<!-- Group 번호-->
									<input type="text" class="readonly" readonly="readonly" name="tagGrpNo" id="tagGrpNo" title="<spring:message code="column.grp_no"/>" value="${tagGroup.tagGrpNo}" />
								</td>
								<th><spring:message code="column.up_grp_no"/><strong class="red">*</strong></th>
								<td>
									<!-- 상위 Group 번호-->
									<c:set var="upGrpNo" value="${empty tagGroup.upGrpNo ? tagGroupResult.upGrpNo : tagGroup.upGrpNo}" />
									<input type="text" class="readonly validate[required]" readonly="readonly" name="upGrpNo" id="upGrpNo" title="<spring:message code="column.up_grp_no"/>" value="${empty upGrpNo ? adminConstants.MENU_DEFAULT_NO : upGrpNo}" />
								</td>
							</tr>
							<tr>
								<th><spring:message code="column.tag_grp_nm"/><strong class="red">*</strong></th>
								<td colspan="3">
									<!-- 그룹 명-->
									<input type="text" class="required_item validate[required, maxSize[100]]" name="grpNm" id="grpNm" title="<spring:message code="column.tag_grp_nm"/>" value="${tagGroup.grpNm}" />
								</td>
							</tr>
							<tr>
								<th><spring:message code="column.sort_seq"/><strong class="red">*</strong></th>
								<td>
									<!-- 정렬 순서-->
									<input type="text" class="required_item numeric validate[required, custom[onlyNum], min[1], max[9999]]" maxlength="4" name="sortSeq" id="sortSeq" title="<spring:message code="column.sort_seq"/>" value="${tagGroup.sortSeq}" />
									<input type="hidden" id="hiddenSortSeq" value="${tagGroup.sortSeq}">
								</td>
								<th><spring:message code="column.use_yn"/><strong class="red">*</strong></th>
								<td>
									<!-- 사용 여부-->
									<select class="wth100" name="stat" id="stat" title="<spring:message code="column.use_yn"/>" >
										<frame:select grpCd="${adminConstants.USE_YN}" selectKey="${tagGroup.stat}"/>
									</select>
								</td>
							</tr>
						<c:if test="${not empty tagGroup}">
							<tr>
								<th><spring:message code="column.sys_regr_nm" /></th>
								<td>
									${tagGroup.sysRegrNm}
								</td>
								<th><spring:message code="column.sys_reg_dtm" /></th>
								<td>
									<fmt:formatDate value="${tagGroup.sysRegDtm}" pattern="yyyy-MM-dd HH:mm:ss"/>
								</td>
							</tr>
							<tr>
								<th><spring:message code="column.sys_updr_nm" /></th>
								<td>
									${tagGroup.sysUpdrNm}
								</td>
								<th><spring:message code="column.sys_upd_dtm" /></th>
								<td>
									<fmt:formatDate value="${tagGroup.sysUpdDtm}" pattern="yyyy-MM-dd HH:mm:ss"/>
								</td>
							</tr>
						</c:if>
						</tbody>
					</table>
					</form>
					<div class="btn_area_center">					
						<button type="button" onclick="menuBaseAddView();" class="btn btn-add menuBaseAddBtn " >신규</button>					
						<button type="button" onclick="menuSave();" class="btn btn-ok">저장</button>
					<c:if test="${not empty tagGroup}">
						<button type="button" onclick="menuDelete('${tagGroup.tagGrpNo}');" class="btn btn-add">삭제</button>
					</c:if>
					</div>
				</div>
				