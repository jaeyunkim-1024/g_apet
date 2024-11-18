<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<form name="pushMessageSendForm" id="pushMessageSendForm" method="post">
	<c:set var="sndTypeCd" value="${not empty noticeSendInfoList ? noticeSendInfoList[0].sndTypeCd : not empty noticeSendInfo ? noticeSendInfo.sndTypeCd : '' }" />
	<input type="hidden" name="noticeSendNo" id="noticeSendNo" value="${not empty noticeSendInfoList ? noticeSendInfoList[0].noticeSendNo : not empty noticeSendInfo ? noticeSendInfo.noticeSendNo : '' }" />
	<input type="hidden" name="tmplNo" id="tmplNo" value="${not empty noticeSendInfoList ? noticeSendInfoList[0].tmplNo : not empty noticeSendInfo ? noticeSendInfo.tmplNo : '' }" />
	<input type="hidden" name="sysRegrNo" id="sysRegrNo" value="${not empty noticeSendInfoList ? noticeSendInfoList[0].sysRegrNo : '' }" />
	<input type="hidden" name="pushGb" id="pushGb" value="Y" />
	<div class="mTitle">
		<h2>알림 메시지 발송</h2>
	</div>
	<table class="table_type1">
		<colgroup>
			<col width="20%"/>
			<col width="80%"/>
		</colgroup>
		<caption>공통 댓글 검색 목록</caption>
		<tbody>
			<tr>
				<th><spring:message code="column.push.gb" /><strong class="red">*</strong></th>
				<td>
					<!-- 발송 구분 -->
					<frame:radio name="noticeTypeCd" grpCd="${adminConstants.NOTICE_TYPE }" 
					selectKey="${not empty noticeSendInfoList ? noticeSendInfoList[0].noticeTypeCd : adminConstants.NOTICE_TYPE_20 }" />
					<div id="pushDateArea" style="display:inline;">
						<frame:datepicker startDate="sendReqDtm" startHour="sendReqDtmHr" startMin="sendReqDtmMn" startSec="sendReqDtmSec"
							  startValue="${empty noticeSendInfoList ? frame:addDay('yyyy-MM-dd 00:00:00', 1) : frame:getFormatTimestamp(noticeSendInfoList[0].sendReqDtm, 'yyyy-MM-dd HH:mm:ss') }"
							  required="Y" />
					</div>
				</td>
			</tr>
			<tr>
				<th><spring:message code="column.push.receiver_select" /><strong class="red">*</strong></th>
				<td>
					<!-- 수신대상자 선택 -->
					<div style="height:30px;">
						<label class="fRadio"><input type="radio" id="receiverSelect" name="receiver" title="" value="" checked="checked" /><span>직접 선택</span></label>
						<label class="fRadio"><input type="radio" id="receiverExcel" name="receiver" title="" value="" /><span>엑셀 업로드</span></label>
						<p id="excelUploadDesc" class="fontbold" style="font-size:13px; display:inline-block; color:#0066CC;"></p>
						<p>수신대상자가 100명 초과하는 경우, 엑셀 업로드 방식을 권장해 드립니다.</p>
					</div>
					<input type="text" name="receiverListTxt" id="receiverListTxt" class="w525 mt15 mb5 receiverList validate[required]"
					 readonly="readonly" placeholder="선택하세요" value="${noticeSendInfoList[0].receiverStr }"
					 style="position:relative; padding:0px 30px 0px 10px;"/>
					<div style="display:inline-block;">
					<button type="button" id="receiverSelectBtn" onclick="memberListViewPop();" class="btn mt15 mb5">선택</button>
					<button type="button" id="receiverExcelUploadBtn" onclick="fileUpload.xls(fnCallBackFileUpload);" class="btn mt15 mb5" style="display:none;">엑셀 업로드</button>
					<button type="button" id="excelTmplDownloadBtn" onclick="pushUploadTmplExcelDownload();" class="btn mt15 mb5" style="display:none;">엑셀 템플릿 다운로드</button>
					</div>
					<div id="receiverListDiv" class="receiverList" style="display:none; position:absolute; background-color:#FFFFFF; border:1px solid #999; width:545px; height:120px;
					line-height:26px; padding:0px 10px; overflow:auto; z-index:9999 !important; margin-top:-5px;">
						<p id="receiverListTxt2" class="receiverList" style="padding:0px 18px 0px 0px; word-break:break-all;"></p>
					</div>
				</td>
			</tr>
			<tr>
				<th><spring:message code="column.push.marketing_info" /><strong class="red">*</strong></th>
				<td>
					<!-- 정보 구분 -->
					<label class="fRadio"><input type="radio" id="sendInfo" name="receiverSendInfo" title="" value="${adminConstants.INFO_TP_CD_10}" checked="checked" /><span>정보성</span></label>
					<label class="fRadio"><input type="radio" id="sendMaketing" name="receiverSendInfo" title="" value="${adminConstants.INFO_TP_CD_20}" /><span>광고성</span></label>
					<p>광고성 알림은 마케팅 정보 수신 동의한 회원에게만 발송됩니다.</p>
				</td>
			</tr>
			<tr>
				<th><spring:message code="column.push.tmpl" /><strong class="red">*</strong></th>
				<td>
					<!-- 템플릿 -->
					<label class="fRadio"><input type="radio" id="tmplDirectInputBtn" name="receiverTemplate" title="" value="10" checked="checked"/><span>직접 입력</span></label>
					<label class="fRadio"><input type="radio" id="pushTemplateSelect" name="receiverTemplate" title="" value="20"/><span>템플릿 선택</span></label>
					<p id="tmpTable" style="display:none; padding:8px 0px 6px 0px;">
						<input type="text" name="tmplCd" id="tmplCd" class="w500 readonly" readonly="readonly"
						value="${not empty noticeSendInfoList ? noticeSendInfoList[0].tmplCd : not empty noticeSendInfo ? noticeSendInfo.tmplCd : '' }" placeholder="선택하세요" />
<!-- 						<button type="button" onclick="selectEmptyTemplate();" id="tmplDirectInputBtn" class="btn" style="display:none;">직접 입력</button> -->
						<button type="button" onclick="pushTemplateSelectViewPop();" class="btn">템플릿 선택</button>
					</p>
				</td>
			</tr>
			<tr>
				<th><spring:message code="column.push.send_type_select" /><strong class="red">*</strong></th>
				<td>
					<!-- 전송방식 선택 -->
					<select name="sndTypeCd" id="sndTypeCd" onchange="sndTypeCdChange();">
						<frame:select grpCd="${adminConstants.SND_TYPE }" defaultName="선택"
						selectKey="${not empty noticeSendInfoList ? noticeSendInfoList[0].sndTypeCd : not empty noticeSendInfo ? noticeSendInfo.sndTypeCd : adminConstants.SND_TYPE_20 }"
						excludeOption="${adminConstants.SND_TYPE_30 }" />
					</select>
				</td>
			</tr>
			<tr id="lmsFileUploadArea" style="display:none">
				<th><spring:message code="column.push.atch_fl_image" /></th>
				<td>
					<!-- 첨부 파일 -->
					<input type="text" class="w300 readonly" readonly="readonly" name="lmsFileUpload" id="lmsFileUpload" value="" />
					<button type="button" class="btn" onclick="fileUpload.image(mmsResultImage);">파일 선택</button>
				</td>
			</tr>
			<tr id="osGbArea" style="display:none;">
				<th><spring:message code="column.push.os_gb_setting" /><strong class="red">*</strong></th>
				<td>
					<!-- OS 구분 설정 -->
<!-- 					<label class="fCheck"><input type="checkbox" id="appAllGb" name="appAllGb" -->
<%-- 					 ${not empty noticeSendInfoList ? (noticeSendInfoList[0].deviceTypeCd eq adminConstants.DEVICE_TYPE_30 || empty noticeSendInfoList[0].deviceTypeCd ? 'checked="checked"' : '') : 'checked="checked"' } /><span>APP 전체</span></label> --%>
<!-- 					(&nbsp;&nbsp;&nbsp; -->
					<frame:checkbox name="deviceTypeCd" grpCd="${adminConstants.DEVICE_TYPE}" usrDfn1Val="Y" 
					checkedArray="${not empty noticeSendInfoList[0].deviceTypeCd ? noticeSendInfo.deviceTypeCd : '10,20'}"/>
				</td>
			</tr>
			<tr class="mt5 mb10" id="appPushArea" style="display:none;">
				<th>이미지</th>
				<td>
					<!-- 템플릿 영역 -->
					<input type="hidden" name="imgPath" id="imgPath" value="${not empty noticeSendInfoList ? noticeSendInfoList[0].imgPath : not empty noticeSendInfo ? noticeSendInfo.imgPath : '' }" />
					<select id="appIconSelect" name="appIconSelect" onchange="appIconSelectChange();">
						<option value="appIconImg">이미지 등록</option>
						<option value="appImgUrl">이미지 URL 등록</option>
						<option value="none">사용안함</option>
					</select>
					<span style="display:inline-block;" class="appIcon ml5" id="appIconImg">
						<img src="/images/noimage.png" alt="" style="width:40px; height:30px; border:1px solid #d5d5d5;" id="appIconImgTag">
						<button type="button" name="appIconInsertBtn" id="appIconInsertBtn" onclick="fileUpload.image(appPushResultImage);" class="btn">이미지  선택</button>
						&nbsp&nbsp<p style="display:inline-block;">등록이미지 : 5M 이하 / gif, png, jpg(jpeg)</p>
					</span>
					<span style="display:none;" class="appIcon" id="appImgUrlArea">
						<input type="text" class="w525" id="appImgUrl" name="appImgUrl"
						 value="${not empty noticeSendInfoList ? noticeSendInfoList[0].imgPath : not empty noticeSendInfo ? noticeSendInfo.imgPath : '' }" />
					</span>
				</td>
			</tr>
			<tr class="mt5 mb10" id="appPushArea2" style="display:none;">
				<th>URL</th>
				<td>
					<input type="text" class="w800" id="movPath" name="movPath"
					value="${not empty noticeSendInfoList ? noticeSendInfoList[0].movPath : not empty noticeSendInfo ? noticeSendInfo.movPath : '' }" 
					placeholder="Push를 선택해서 앱 진입시 이동될 URL 주소를 입력하세요" />
				</td>
			</tr>
			<tr id="templateArea">
				<td colspan="2">
					<div class="mt5 mb10">
						<input type="text" class="w800 validate[required, maxSize[100]] ${empty noticeSendInfoList ? 'readonly' : '' }" id="subject" name="subject" ${empty noticeSendInfoList ? 'readonly="readonly"' : '' }
						value="${not empty noticeSendInfoList ? noticeSendInfoList[0].subject : (not empty noticeSendInfo ? noticeSendInfo.subject : '' )}" 
						placeholder="메시지 제목을 100자 이내 입력하세요" maxlength="100" />
					</div>
					<textarea name="templateHtml" id="templateHtml" class="mb5 validate[required, maxSize[500]] ${empty noticeSendInfoList ? 'readonly' : '' }" ${empty noticeSendInfoList ? 'readonly="readonly"' : '' }
					 style="width:98%; height:300px;" placeholder="메시지 내용을 입력해 주세요" maxlength="500">${not empty noticeSendInfoList ? noticeSendInfoList[0].contents : not empty noticeSendInfo ? noticeSendInfo.contents : '' }</textarea>
				</td>
			</tr>
		</tbody>
	</table>
</form>
