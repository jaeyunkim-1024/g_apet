<script>
	// callback : 파일 업로드
	function fnCallBackFileUpload( file ) {
		$("#WinnerForm #fileName").val( file.fileName );
		$("#WinnerForm #filePath").val( file.filePath );
	}
	
	$(document).ready(function(){
		//에디터 생성
		EditorCommon.setSEditor('content','${adminConstants.EVENT_IMAGE_PATH}');

		//이벤트 명 입력
		$("p[name=ttl]").html($("#mainContentWrap").data('ttl'));
		//이벤트 번호 입력
		$("input[name=eventNo]", "#WinnerForm").val($("#mainContentWrap").data('eventno'));	
	});
	
</script>
<div>
	<form id="WinnerForm">
		<table class="table_type1">
			<tr>
				<!-- 이벤트 명 -->
				<th>이벤트 명<strong class="red">*</strong></th>
				<td>
					<input type="hidden" name="eventNo" value=""/>
					<p name="ttl"></p>
				</td>
			</tr>
			<tr>
				<!-- 내용 -->
				<th>내용<strong class="red">*</strong></th>
				<td>
					<textarea	name="content" id="content" class="validate[required]"
								title="<spring:message code="column.content"/>"
								style="width: 97%; height: 320px;">
								${vo.content}
					</textarea>
				</td>
			</tr>
			<tr>
				<!-- 당첨자 명단 타이틀 -->
				<th><spring:message code="column.event.win_ttl"/><strong class="red">*</strong></th>
				<td>
					<input type="text"class="w600 validate[required ]" name="winTtl" value="${vo.winTtl}" />
				</td>
			</tr>
			<tr>
				<!-- 비공개형 발표 -->
				<th><spring:message code="column.event.not_open_yn"/></th>
				<td>
					<c:choose>
						<c:when test="${vo.notOpenYn eq adminConstants.NOT_OPEN_YN_Y}">
							<input type="checkbox" name="notOpenYn" value="Y" checked="checked"/>
						</c:when>
						<c:otherwise>
							<input type="checkbox" name="notOpenYn" value="Y" />
						</c:otherwise>
					</c:choose>
					<span>활성화</span>
				</td>
			</tr>
			<tr>
				<!-- 당첨자 명단 업로드 -->
				<th><spring:message code="column.event.win_list_upload"/><strong class="red">*</strong></th>
				<td>
					<input type="text" class="w500 validate[required ] readonly" id="fileName" name="fileName" value="" readonly="readonly"/>
					<input type="hidden" id="filePath" name="filePath" value="" />
					<a href="javascript:fileUpload.file(fnCallBackFileUpload);" class="btn">찾아보기</a>
					<p>※ CSV 파일만 등록 가능합니다.</p>
				</td>
			</tr>
		</table>
	</form>
</div>