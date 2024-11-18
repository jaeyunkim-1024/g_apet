<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<form name="pushTemplateViewForm" id="pushTemplateViewForm" method="post">
	<input type="hidden" name="tmplNo" id="tmplNo" value="${noticeTemplateInfo.tmplNo }">
<c:if test="${empty noticeTemplateInfo }">
	<div class="mTitle">
		<h2>알림메시지 템플릿 생성</h2>
	</div>
</c:if>
	<table class="table_type1 popup">
		<caption>알림 메시지 템플릿</caption>
		<tbody>
			<tr>
				<th><spring:message code="column.push.tmpl_no" /><strong class="red">*</strong></th>
				<td>
					<!-- 템플릿 일련번호 -->
					${empty noticeTemplateInfo ? '자동 입력' : noticeTemplateInfo.tmplCd }
				</td>
			</tr>
			<tr>
				<th><spring:message code="column.push.send_type" /><strong class="red">*</strong></th>
				<td>
					<!-- 전송방식 -->
					<select name="sndTypeCd" id="sndTypeCd" onchange="sndTypeCdChange();">
						<frame:select grpCd="${adminConstants.SND_TYPE }" selectKey="${empty noticeTemplateInfo ? adminConstants.SND_TYPE_20 : noticeTemplateInfo.sndTypeCd }"
						 defaultName="선택" />
					</select>
				</td>
			</tr>
			<tr>
				<th><spring:message code="column.push.tmpl_category_gb" /><strong class="red">*</strong></th>
				<td>
					<!-- 카테고리 구분 -->
					<select name="ctgCd" id="ctgCd">
						<frame:select grpCd="${adminConstants.CTG }" defaultName="카테고리 선택" selectKey="${noticeTemplateInfo.ctgCd }" />
					</select>
				</td>
			</tr>
			<tr>
				<th><spring:message code="column.push.sys_use_yn" /><strong class="red">*</strong></th>
				<td>
					<!-- 시스템 사용 여부 -->
					<frame:radio name="sysUseYn" grpCd="${adminConstants.SYS_USE_YN }" selectKey="${noticeTemplateInfo.sysUseYn }" />
				</td>
			</tr>
			<tr id="tmplCdArea">
				<th><spring:message code="column.push.tmpl_cd" /><strong class="red">*</strong></th>
				<td>
					<!-- 템플릿 코드 -->
					<input type="text" class="w400 validate[required, maxSize[1000]]" id="tmplCd" name="tmplCd" value="${noticeTemplateInfo.tmplCd }" placeholder="템플릿 코드를 입력하세요" />
				</td>
			</tr>
			<tr>
				<th><spring:message code="column.push.system_cd" /></th>
				<td>
					<!-- 시스템 코드 -->
					<input type="text" class="w400 validate[maxSize[500]]" id="sysCd" name="sysCd" value="${noticeTemplateInfo.sysCd }" placeholder="시스템 코드를 입력하세요" />
				</td>
			</tr>
			<tr id="lmsFileUploadArea">
				<th>첨부파일</th>
				<td>
					<!-- 첨부파일 -->
					<input type="text" class="w300 readonly" readonly="readonly" name="lmsFileUpload" id="lmsFileUpload" value="" />
					<button type="button" class="btn btn-add" onclick="fileUpload.file(resultFile);">파일 첨부</button>
				</td>
			</tr>	
			<tr class="appPushArea">
				<th>이미지</th>
				<td>
					<input type="hidden" name="imgPath" id="imgPath" value="" />
					<select id="appIconSelect" name="appIconSelect" onchange="appIconSelectChange();">
						<option value="appIconImg">이미지 등록</option>
						<option value="appImgUrl">이미지 URL 등록</option>
						<option value="none">사용안함</option>
					</select>
					<!-- 이미지 등록 -->
					<div style="display:inline-block;" class="appIcon ml5" id="appIconImg">
						<img src="/images/noimage.png" alt="" style="width:25px; height:25px; border:1px solid #d5d5d5;" id="appIconImgTag">
						<button type="button" name="appIconInsertBtn" id="appIconInsertBtn" onclick="fileUpload.image(resultImage);" class="btn btn-add">이미지 선택</button>
						<p style="display:inline-block;">등록이미지 : 5M 이하 / gif, png, jpg(jpeg)</p>
					</div>					
					<!-- 이미지URL등록  -->
					<div style="display:inline-block;" class="appIcon" id="appImgUrlArea"> 
						<input type="text" class="w525" id="appImgUrl" name="appImgUrl" value="${noticeTemplateInfo.imgPath }" placeholder="/" />
					</div> 					
				</td>
			</tr>				
			<tr class="appPushArea">
				<th>URL</th>
				<td>
					<input type="text" class="w500" id="movPath" name="movPath" value="${noticeTemplateInfo.movPath }" placeholder="Push를 선택해서 앱 진입시 이동될 URL 주소를 입력하세요" />
				</td>
			</tr>					
			<tr id="templateArea">
				<td colspan="2">
					<div class="mt5 mb10">
						<input type="text" class="w500 validate[required, maxSize[100]]" id="subject" name="subject" value="${noticeTemplateInfo.subject }"
						 placeholder="메시지 제목을 100자 이내 입력하세요" maxlength="100" />
					</div>
					<textarea name="templateHtml" class="validate[required, maxSize[500]]" id="templateHtml" style="width:97%; height:300px;" placeholder="메시지 내용을 입력해 주세요" maxlength="500">${noticeTemplateInfo.contents }</textarea>
					<button type="button" onclick="pushVariableViewPop();" class="btn btn-add mt10 mb5" style="background-color:#0066CC; border-color:#0066CC;">변수 리스트</button>
				</td>
			</tr>
		</tbody>
	</table>
	
<c:if test="${empty noticeTemplateInfo }">
	<div class="btn_area_center">
		<button type="button" onclick="insertNoticeTemplate();" class="btn btn-add">등록</button>
		<button type="button" onclick="templateReset('pushTemplateViewForm');" class="btn btn-ok">초기화</button>
		<button type="button" onclick="closeTab();" class="btn btn-cancel">취소</button>
	</div>
</c:if>
</form>
