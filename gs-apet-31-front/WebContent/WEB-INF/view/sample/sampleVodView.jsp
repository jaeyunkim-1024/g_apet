<%--	
 - Class Name	: /sample/sampleVodView.jsp
 - Description	: 영상 예시
 - Since		: 2021.1.25
 - Author		: VLF
--%>

<tiles:insertDefinition name="common">
	<tiles:putAttribute name="content">	
	<div class="content" style="padding-left: 20%;">
		<h2>■ 영상 파일 업로드 </h2>
		<span>1. 영상 경로 : </span><input type="text" id="vodOrgPath" name="vodPath" style="width: 500px;" class="required req_input2" title="영상" value="" readonly="readonly"><span> ※ 다운로드 경로입니다.</span>
		<br/>
		<span>2. 영상 크기 : </span><input type="text" id="vodFlSz" name="vodFlSz" title="<spring:message code="column.fl_sz"/>" value="" readonly="readonly">
		<br/>
		<span>3. 영상 길이 : </span><input type="text" id="vdLnth" name="vdLnth" class="required req_save" value="" readonly="readonly">
		<br/>
		<span>4. 영상 ID : </span><input type="text" id="outsideVdId" name="outsideVdId" value="" readonly="readonly">
		<br/>
		<span>5. 썸네일 : </span><input type="text" id="thumb_url" name="thumb_url" value="" readonly="readonly">
		<br/>
		<span>6. 영상 이름 : </span><input type="text" class="readonly w400" readonly="readonly" id="vodOrgNm" name="vodNm" title="<spring:message code="column.org_fl_nm"/>" value=""  readonly="readonly"/>
		<br/>
		<button type="button" name="vodFileUpladBtn" style="" onclick="$('#vodUploadFile').click();" class="btn">파일선택</button>
		<div style="display:none;">
			<input type="file" id="vodUploadFile" name="vodUploadFile" accept="video/mp4,video/x-m4v,video/*" onchange="vodUpload(this, vodCallback);">
		</div>
	</div>
	<br/>
	<script>
		var option = {
				authKey : sgrGenerate()
				, channel_id : 'aboutpet_log'
				, video_id : 'fFl6363779'
		}
		vodGroupList(option, ccb);
		function ccb(result) {
			console.log('ccb', result);
		};
		
		<%-- 영상 업로드 Callback --%>
		function vodCallback(result) {
			$("#vodFlSz").val("");
			$("#vdLnth").val("");
			$("#vodOrgPath").val(result.content[0].download_url);
			$("#outsideVdId").val(result.content[0].video_id);
			$("#thumb_url").val(result.content[0].thumb_url);
			$("#vodOrgNm").val(document.getElementById('vodUploadFile').files[0].name);
			console.log('sgrKey', sgrKey);
			vodSave();
		}
		
		let waitChk = false;
		function vodSave() {
			var option = {
					authKey : sgrKey
					, video_id : $("#outsideVdId").val()
			}
			vodInfo(option, function(result){
				if (result.contents[0].encoding_state == '${frontConstants.SGR_RESULT_ENCODING_STATE_SUCCESS}'){
					waiting.stop();
					waitChk = false;
					$("#vodFlSz").val(parseInt(result.contents[0].filesize));
					$("#vdLnth").val(result.contents[0].duration);
					sgrKey = '';
					alert("정상 처리되었습니다.");
				} else if (result.contents[0].encoding_state == '${frontConstants.SGR_RESULT_ENCODING_STATE_FAILED}') {
					waiting.stop();
					waitChk = false;
					sgrKey = '';
					$("vodOrgPath").val("");
					$("#vodFlSz").val("");
					$("#vdLnth").val("");
					$("#outsideVdId").val("");
					$("#thumb_url").val("");
					$("#vodOrgNm").val("");
					alert("인코딩에 실패했습니다. 영상을 다시 등록해 주세요.");
				} else {
					setTimeout(vodSave, 2000);
				}
			});
		}
	</script>
	</tiles:putAttribute>
</tiles:insertDefinition>