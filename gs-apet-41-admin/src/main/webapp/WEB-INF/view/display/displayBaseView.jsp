<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<c:set var="dispClsfCd" value="${empty displayBase.dispClsfCd ? displayResult.dispClsfCd : displayBase.dispClsfCd}" />
<c:set var="dispLvl" value="${empty displayBase.dispLvl ? (displayResult.dispLvl + 1) : displayBase.dispLvl}" />
<c:set var="dispClsfNo" value="${not empty displayBase.dispClsfNo ? displayBase.dispClsfNo : 0}" />
	<div class="mTitle">
		<h2>전시 분류 정보</h2>
		<div class="buttonArea">
			<c:choose>
<%-- 				<c:when test="${dispClsfCd eq adminConstants.DISP_CLSF_30 && dispClsfNo != adminConstants.PETSHOP_MAIN_DISP_CLSF_NO}"> --%>
				<c:when test="${dispClsfCd eq adminConstants.DISP_CLSF_30}">
					<button type="button" onclick="displayPreview('${displayBase.dispClsfNo}');" class="btn btn-add">미리보기</button>
				</c:when>
				<c:otherwise>
						<button type="button" onclick="displayBaseSave();" class="btn btn-add">${empty displayBase ? '등록' : '수정'}</button>
					<c:if test="${not empty displayBase}">
						<button type="button" onclick="displayBaseDelete();" class="btn btn-add">삭제</button>
					</c:if>
				</c:otherwise>
			</c:choose>
		</div>
	</div>

	<form name="displayBaseForm" id="displayBaseForm">
		<input type="hidden" name="dispClsfCd" id="dispClsfCd" value="${dispClsfCd}" />
		<input type="hidden" name="dispLvl" id="dispLvl" value="${dispLvl}" />
		<input type="hidden" name="dispBnrNo" id="dispBnrNo" value="${empty displayBase.dispBnrNo ? '' : displayBase.dispBnrNo}" />
		<input type="hidden" name="stId" id="stId" value="" />
		<input type="hidden" name="tmplNo" id="tmplNo" value="${empty displayBase.tmplNo ? '' : displayBase.tmplNo}"/>
		<input type="hidden" name="categoryFilters" id="categoryFilters"/>

		<table class="table_type1">
			<caption>전시 분류 정보</caption>
			<colgroup>
				<col class="th-s" />
				<col />
				<col class="th-s" />
				<col />
			</colgroup>
			<tbody>
				<c:if test="${dispClsfCd ne adminConstants.DISP_CLSF_30}">
				<tr>
					<th><spring:message code="column.disp_clsf_no"/><strong class="red">*</strong></th>
					<td>
						<!-- 전시 분류 번호-->
						<input type="text" class="readonly" readonly="readonly" name="dispClsfNo" id="dispClsfNo" title="<spring:message code="column.disp_clsf_no"/>" value="${displayBase.dispClsfNo}" />
					</td>
					<th><spring:message code="column.display_view.up_disp"/><strong class="red">*</strong></th>
					<td>
						<!-- 상위 정보-->
						<input type="text" class="readonly validate[required]" readonly="readonly" name="upDispClsfNo" id="upDispClsfNo" title="<spring:message code="column.up_disp_clsf_no"/>" value="${empty displayBase.upDispClsfNo ? displayResult.upDispClsfNo : displayBase.upDispClsfNo}" />
					</td>
				</tr>
				<tr>
					<th><spring:message code="column.disp_clsf_nm"/><strong class="red">*</strong></th>
					<c:if test="${dispClsfCd ne adminConstants.DISP_CLSF_20}">
						<td colspan="3">
							<!-- 전시 분류 명 -->
							<input type="text" class="validate[required, maxSize[50]]" name="dispClsfNm" id="dispClsfNm" title="<spring:message code="column.disp_clsf_nm"/>" value="${displayBase.dispClsfNm}" />
						</td>
					</c:if>
					<c:if test="${dispClsfCd eq adminConstants.DISP_CLSF_20}">
						<c:if test="${dispLvl eq 2}">
							<td>
								<!-- 전시 분류 명 -->
								<input type="text" class="validate[required, maxSize[50]]" name="dispClsfNm" id="dispClsfNm" title="<spring:message code="column.disp_clsf_nm"/>" value="${displayBase.dispClsfNm}" />
							</td>
							<th><spring:message code="column.prmt_show_nm"/><strong class="red">*</strong></th> <!-- 기획전 노출 명 -->
							<td>
								<input type="text" class="validate[required,maxSizeNonUtf8[5]]" name="prmtShowNm" id="prmtShowNm" title="<spring:message code="column.prmt_show_nm"/>" value="${displayBase.prmtShowNm}" />
							</td>
						</c:if>
						<c:if test="${dispLvl ne 2}">
							<td colspan="3">
								<!-- 전시 분류 명 -->
								<input type="text" class="validate[required, maxSize[50]]" name="dispClsfNm" id="dispClsfNm" title="<spring:message code="column.disp_clsf_nm"/>" value="${displayBase.dispClsfNm}" />
							</td>
						</c:if>
					</c:if>
				</tr>
				<tr style="display:none;">
					<th><spring:message code="column.leaf_yn"/><strong class="red">*</strong></th>
					<td>
						<c:if test="${dispLvl eq 3 and dispClsfCd ne adminConstants.DISP_CLSF_30}">
							<frame:radio name="leafYn" grpCd="${adminConstants.LEAF_YN}" selectKey="${adminConstants.LEAF_YN_Y}" disabled="true"/>
						</c:if>
						<c:if test="${dispLvl < 3 or dispClsfCd eq adminConstants.DISP_CLSF_30}">
							<frame:radio name="leafYn" grpCd="${adminConstants.LEAF_YN}" selectKey="${displayBase.leafYn}"/>
						</c:if>
						<input type="hidden" id="leafYn" value="${displayBase.leafYn}">
					</td>
				</tr>
<!-- 				<tr> -->
<%-- 					<th><spring:message code="column.display_view.date"/><strong class="red">*</strong></th> --%>
<%-- 					<td ${dispClsfCd ne adminConstants.DISP_CLSF_10 ? 'colspan="3"' : ''} > --%>
<!-- 						전시 기간 -->
<%-- 						<frame:datepicker startDate="dispStrtdt" --%>
<%-- 										  startValue="${empty displayBase.dispStrtdt ? frame:toDate('yyyy-MM-dd') : displayBase.dispStrtdt}" --%>
<%-- 										  endDate="dispEnddt" --%>
<%-- 										  endValue="${empty displayBase.dispEnddt ? frame:addMonth('yyyy-MM-dd', 1) : displayBase.dispEnddt}" --%>
<%-- 										  />	 --%>
<!-- 					</td> -->
<%-- 					<c:if test="${dispClsfCd eq adminConstants.DISP_CLSF_10}"> --%>
<%-- 						<th><spring:message code="column.leaf_yn"/><strong class="red">*</strong></th> --%>
<!-- 						<td> -->
<%-- 							<c:if test="${dispLvl eq 3}"> --%>
<%-- 								<frame:radio name="leafYn" grpCd="${adminConstants.LEAF_YN}" selectKey="${adminConstants.LEAF_YN_Y}" disabled="true"/> --%>
<%-- 							</c:if> --%>
<%-- 							<c:if test="${dispLvl < 3}"> --%>
<%-- 								<frame:radio name="leafYn" grpCd="${adminConstants.LEAF_YN}" selectKey="${displayBase.leafYn}"/> --%>
<%-- 							</c:if> --%>
<%-- 							<input type="hidden" id="leafYn" value="${displayBase.leafYn}"> --%>
<!-- 						</td> -->
<%-- 					</c:if> --%>
<!-- 				</tr> -->
				<tr class="planBnr">
					<th><spring:message code="column.bnd_no"/><strong class="red">*</strong></th>
					<td colspan="3">
						<frame:bndNo funcNm="searchBrand()" requireYn="Y" defaultBndNmKo="${displayBase.bndNmKo }" defaultBndNmEn="${displayBase.bndNmEn }" defaultBndNo="${displayBase.bndNo }" />
					</td>
				</tr>
				<tr>
					<th><spring:message code="column.display_view.disp_rank"/><strong class="red">*</strong></th>
					<td>
						<!-- 전시 순서-->
						<input type="text" class="numeric validate[required]" name="dispPriorRank" id="dispPriorRank" title="<spring:message code="column.disp_prior_rank"/>" value="${displayBase.dispPriorRank}" />
					</td>
					<th><spring:message code="column.disp_yn"/></th>
					<td>
						<!-- 전시 여부-->
						<select name="dispYn" id="dispYn" title="<spring:message code="column.disp_yn"/>" >
							<frame:select grpCd="${adminConstants.DISP_YN}" selectKey="${displayBase.dispYn}"/>
						</select>
					</td>
				</tr>
				<%-- 최상위 카테고리인지 확인함(전시분류코드 10) --%>
				<c:if test="${dispLvl < 2}">
                <tr>
                   <!--대  카테고리 이미지-->
                   <th><spring:message code="column.display.disp_clsf.depth1.img_nm"/></th>
                   <td colspan="3">
                       <input type="text" class="w250" name="tnImgNm" id="tnImgNm" title="<spring:message code="column.display.disp_clsf.depth1.img_nm"/>" value="${displayBase.tnImgNm}" />
                       <input type="hidden" name="tnImgPath" id="tnImgPath" title="<spring:message code="column.display.disp_clsf.depth1.img_path"/>" value="${displayBase.tnImgPath}" />
                       <a href="javascript:fileUpload.image(resultDispClsfImage);" class="btn">파일 업로드</a>
						<c:choose>
							<c:when test="${displayBase.tnImgPath != null and fn:length(fn:trim(displayBase.tnImgPath)) > 0}">
								&nbsp;<img id="tnImgPathView" name="tnImgPathView" src="${frame:optImagePath(displayBase.tnImgPath, adminConstants.IMG_OPT_QRY_60)}" width="70" height="70" alt="" >
								&nbsp;<button type="button" class="btn" onclick="deleteDispClsfImage();">삭제</button>
							</c:when>
							<c:otherwise>
								&nbsp;<img id="tnImgPathView" name="tnImgPathView" width="70" height="70" alt="" >
							</c:otherwise>
						</c:choose>
                   </td>
                </tr>
                </c:if>

					<%--	템플릿 사용 안함
					<tr class="planTmpl">
						<th><spring:message code="column.display_view.tmpl_nm"/></th>
						<td colspan="3">
							<!-- 화면 템플릿-->

							<select name="tmplNo" id="tmplNo">
								<c:forEach items="${dispTemplateList}" var="dispTemplateList" varStatus="idx">
									<option value="${dispTemplateList.tmplNo}" ${dispTemplateList.tmplNo == displayBase.tmplNo ? "selected='selected'" : ''}>${dispTemplateList.tmplNm}</option>
								</c:forEach>
							</select>
							<span id="templateWords"></span>
						</td>
					</tr>
					--%>

					<!-- 기획전인 경우만 노출 -->
					<tr class="planBnr">
						<th><spring:message code="column.display_view.bnr_img_path"/><strong class="red">*</strong></th>
						<td colspan="3">
							<!-- 배너 이미지(PC)-->
							<input type="text" class="w250 validate[required]" name="bnrImgNm" id="bnrImgNm" title="<spring:message code="column.bnr_img_nm"/>" value="${displayBase.bnrImgNm}" />
							<input type="hidden" name="bnrImgPath" id="bnrImgPath" title="<spring:message code="column.bnr_img_path"/>" value="${displayBase.bnrImgPath}" />
							<a href="javascript:fileUpload.image(resultBnrPcImage);" class="btn">파일 업로드</a>
						</td>
					</tr>
					<tr class="planBnr">
						<th><spring:message code="column.display_view.bnr_mobile_img_path"/></th>
						<td colspan="3">
							<!-- 배너 이미지(MOBILE)-->
							<input type="text" class="w250" name="bnrMobileImgNm" id="bnrMobileImgNm" title="<spring:message code="column.bnr_mobile_img_nm"/>" value="${displayBase.bnrMobileImgNm}" />
							<input type="hidden" name="bnrMobileImgPath" id="bnrMobileImgPath" title="<spring:message code="column.bnr_mobile_img_path"/>" value="${displayBase.bnrMobileImgPath}" />
							<a href="javascript:fileUpload.image(resultBnrMobileImage);" class="btn">파일 업로드</a>
						</td>
					</tr>
					<tr class="planBnr">
						<th><spring:message code="column.display_view.disp_clsf_title_html"/></th>
						<td colspan="3">
							<!-- 타이틀 HTML(PC)-->
							<textarea name="dispClsfTitleHtml" id="dispClsfTitleHtml" cols="30" rows="10" style="width: 1170px; height: 300px;">${displayBase.dispClsfTitleHtml}</textarea>
						</td>
					</tr>
					<tr class="planBnr">
						<th><spring:message code="column.display_view.disp_clsf_mtitle_html"/></th>
						<td colspan="3">
							<!-- 타이틀 HTML(MOBILE)-->
							<textarea name="dispClsfTitleHtmlMo" id="dispClsfTitleHtmlMo" cols="30" rows="10" style="width: 1170px; height: 300px;">${displayBase.dispClsfTitleHtmlMo}</textarea>
						</td>
					</tr>					
					<!--  기획전 하위 분류인 경우만 노출 -->
					<tr class="planGdsCnt">
						<th><spring:message code="column.list_tp_cd"/><strong class="red">*</strong></th>
						<td colspan="3">
							<!-- 리스트 타입 -->
							<select name="listTpCd" id="listTpCd" title="<spring:message code="column.list_tp_cd"/>" >
								<frame:select grpCd="${adminConstants.LIST_TP}" selectKey="${displayBase.listTpCd}"/>
							</select>
						</td>
					</tr>
				</c:if>
				<c:if test="${dispLvl>=1}">
					<th><spring:message code="column.display.disp_clsf.seo_info_no"/></th>
					<td colspan="3">
						<c:set var="seoInfoNo" value="${displayBase.seoInfoNo > 0 ? displayBase.seoInfoNo : ''}"/>
						<c:set var="upDispClsfNo" value="${displayBase.upDispClsfNo != adminConstants.DISP_CLSF_NO_PETSHOP ? displayBase.dispClsfNo : displayBase.upDispClsfNo}"/>
						<input type="hidden" class="readonly" readonly="readonly"  name="seoInfoNo" id="seoInfoNo" title="<spring:message code="column.display.disp_clsf.seo_info_no" />" value="${seoInfoNo}" />
						<a href="javascript:fnSeoInfoDetailView('${upDispClsfNo}');" class="btn">
							<spring:message code="column.display.disp_clsf.seo_info_set"/>
						</a>
<!-- 						<button type="button" class="btn" onclick="getCategoryInfoPop()" >카테고리 선택</button> -->
					</td>
				</c:if>
				<c:if test="${dispClsfCd ne adminConstants.DISP_CLSF_30 && displayBase.dispLvl > 1 && not empty categoryFilters}">
					<tr>
					<tr>
						<th><spring:message code="column.display.disp_clsf.category_filter"/></th>
						<td colspan="3">
							<c:forEach var="categoryFilter" items="${categoryFilters}" varStatus="status">
								<input type="checkbox" <c:if test="${categoryFilter.dispClsfNo eq displayBase.dispClsfNo}">checked</c:if>  value="${categoryFilter.filtGrpNo}" name="filters[]" id="filters[]">${categoryFilter.filtGrpNo} , ${categoryFilter.filtGrpShowNm}<br>
							</c:forEach>
						</td>
					</tr>
				</c:if>
			</tbody>
		</table>
	</form>