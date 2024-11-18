<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<script type="text/javascript">
	$(document).ready(function() {
		$("#lmsFileUploadArea").show();
		$("#subject").removeClass("readonly");
		$("#subject").attr("readonly", false);
		$("#templateHtml").removeClass("readonly");
		$("#templateHtml").attr("readonly", false);
		
		$("#span_noticeTypeCd10").html($("#span_noticeTypeCd10").html() + " 발송");
		$("#span_noticeTypeCd20").html($("#span_noticeTypeCd20").html() + " 발송");
		if ("${not empty noticeSendInfoList}" == "true") {
			let receiverStr = "${noticeSendInfoList[0].receiverStr}";
			let byteVal = receiverByteCheck(receiverStr);
			if (byteVal > 90) {
				$("#receiverListTxt2").html(receiverStr);
				$("#receiverListTxt").css("background", "url(../images/lnb_tree_arr2.gif) 545px no-repeat");
				$("#receiverListTxt").addClass("pointer");
			} else {
				$("#receiverListTxt").css("background", "");
				$("#receiverListTxt2").html("");
				$("#receiverListTxt").removeClass("pointer");
			}
		}
		if ("${not empty noticeSendInfoList}" == "true" || "${not empty noticeSendInfo}" == "true") {
			$("#templateArea").show();
			if ("${noticeSendInfoList[0].sndTypeCd}" == "${adminConstants.SND_TYPE_40}" || "${noticeSendInfo.sndTypeCd}" == "${adminConstants.SND_TYPE_40}") {
				initEditor();
			}

			if ("${noticeSendInfoList[0].sndTypeCd}" == "${adminConstants.SND_TYPE_10}" || "${noticeSendInfo.sndTypeCd}" == "${adminConstants.SND_TYPE_10}") {
				$("#osGbArea").show();
				$("#appPushArea").show();
				$("#appPushArea2").show();
				$(".appIcon").hide();
				$("#movPath").show();
				$("#tmpTable").show();
				$("#pushTemplateSelect").prop("checked", true);
				
				appPushImgIconSelect();
				var appIconSelect = $("#appIconSelect option:selected").val();
				if (appIconSelect == "appImgUrl") {
					$("#appImgUrlArea").show();
				}
				
			}
			
			if ("${noticeSendInfoList[0].sndTypeCd}" == "${adminConstants.SND_TYPE_20}" || "${noticeSendInfo.sndTypeCd}" == "${adminConstants.SND_TYPE_20}") {
				$("#lmsFileUploadArea").show();
			} else {
				$("#lmsFileUploadArea").hide();
			}
		}
		$(document).on("click", "html", function(e) {
			if (!$(e.target).hasClass("receiverList") && $("#receiverListTxt2").html()) {
				$("#receiverListDiv").hide();
				$("#receiverListTxt").css("background", "url(../images/lnb_tree_arr2.gif) 545px no-repeat");
			}	
		});
		
		$(document).on("click change", "input[name=receiver]", function() {
			if ($(this).attr("id") == "receiverSelect") {
				$("#receiverSelectBtn").show();
				$("#receiverExcelUploadBtn").hide();
				$("#excelTmplDownloadBtn").hide();
				$("#excelUploadDesc").show();
			} else {
				$("#receiverSelectBtn").hide();
				$("#receiverExcelUploadBtn").show();
				$("#excelTmplDownloadBtn").show();
				$("#excelUploadDesc").hide();
			}
		});
		
		$(document).on("click change", "input[name=noticeTypeCd]", function() {
			if ($(this).val() == "${adminConstants.NOTICE_TYPE_20}") {
				$("#pushDateArea").show();
			} else {
				$("#pushDateArea").hide();
			}
		});
		
		$(document).on("click", "#receiverListTxt", function() {
			let byteVal = receiverByteCheck($("#receiverListTxt").val());
			if ($("#receiverListDiv").css("display") == "block") {
				$("#receiverListDiv").hide();
				$("#receiverListTxt").css("background", "url(../images/lnb_tree_arr2.gif) 545px no-repeat");
			} else if ($("#receiverListDiv").css("display") == "none" && byteVal > 90) {
				$("#receiverListDiv").show();
				$("#receiverListTxt").css("background", "url(../images/lnb_tree_arr1.gif) 545px no-repeat");
			}
		});
		
		$(document).on("change", "#receiverListDiv", function() {
			if ($("#receiverListDiv").css("display") == "none") {
				$("#receiverListTxt").css("background", "url(../images/lnb_tree_arr2.gif) 545px no-repeat");
			}
		});
		
		$(document).on("click change", "input[name=noticeTypeCd]", function() {
			if ($(this).val() == "${adminConstants.NOTICE_TYPE_20}") {
				$("#pushDateArea").show();
			} else {
				$("#pushDateArea").hide();
			}
		});
		
		//템플릿
		$("input[name='receiverTemplate']").on("click change", function(e){
			selectEmptyTemplate();
		});
		

		$("input[name='receiverSendInfo']").on("click change", function () {
			var sndTypeSelect = $("#sndTypeCd option:selected").val();
			var radioType = this.value;
			var maketingStr = "(광고)";
			var maketingApet = "(광고) 어바웃펫";
			if(radioType == '20') {
				if(sndTypeSelect == "${adminConstants.SND_TYPE_10}") {
					var appHtml = "\n\n수신거부: MY>설정>앱푸시 설정 OFF";
					$("#subject").val(maketingStr);
					$("#templateHtml").val(appHtml);
				}else if(sndTypeSelect == "${adminConstants.SND_TYPE_20}") {
					var smsHtml = "\n\n고객센터: 1644-9610\n무료수신거부: 0808700224";
					$("#subject").val(maketingApet);
					$("#templateHtml").val(smsHtml);
				}else if(sndTypeSelect == "${adminConstants.SND_TYPE_40}"){
					var emailHtml = "\n고객센터: 1644-9610\n수신거부: 어바웃펫\n로그인>서비스이용약관>마케팅정보\n수신동의 >동의철회";
					var newStr = emailHtml.replace(/\n/gi,'<br>');
					$("#subject").val(maketingApet);
					$("#templateHtml").val(newStr);
					oEditors.getById["templateHtml"].exec("SET_IR", [newStr]);
				}else {
					$("#subject").val(maketingStr);
				}
			}else {
				$("#subject").val("");
				if (sndTypeSelect == "${adminConstants.SND_TYPE_40}") {
					oEditors.getById["templateHtml"].exec("SET_IR", [""]);
				}else {
					$("#templateHtml").val("");
				}
			}
			
		});

		// 알림 메시지 발송 시간 초 select태그 추가
		var pushDateArea = $("#pushDateArea");
		var tmpStr;
		var dateStr = '<fmt:formatDate value="${noticeSendInfoList[0].sendReqDtm}" pattern="ss" />';
		var secStr = "<select class=\"ml5 w60\" id=\"sendReqDtmSecSelect\" name=\"sendReqDtmSecSelect\" onchange=\"sendReqDtmSecChange(this);\">";
		for (var i = 0; i < 60; i++) {
			tmpStr = i;
			if (i.toString().length == 1) {
				tmpStr = "0" + i;
			}
			
			if (tmpStr == dateStr) {
				secStr += "<option value=\"" + tmpStr + "\" selected=\"selected\">" + tmpStr + "초" + "</option>";
				$("#sendReqDtmSec").val(dateStr);
			} else {
				secStr += "<option value=\"" + tmpStr + "\">" + tmpStr + "초" + "</option>";
			}
		}
		secStr += "</select>";
		pushDateArea.append(secStr);
	});
	
	// 수신대상자 (배열)
	let mbrNos = [];
	// 수신대상자 검색 파라미터 (배열)
	let memberSearchParam = {};
	
	function initEditor() {
		if ($("#templateHtml").siblings("iframe").length == 0) {
			EditorCommon.setSEditor('templateHtml','/template');
		} else {
			oEditors.getById["templateHtml"].exec("SET_IR", [""]);
		}
	}
	
	//APP PUSH 이미지 아이콘 선택
	function appPushImgIconSelect() {
		if ("${not empty noticeSendInfoList}" == "true") {
			if ("${noticeSendInfoList[0].imgPath ne ''}" == "true" && "${noticeSendInfoList[0].imgPath ne null}" == "true") {
				$("#appIconSelect option").eq(1).prop("selected", "selected");
			} else if ("${noticeSendInfoList[0].imgPath eq ''}" == "true" || "${noticeSendInfoList[0].imgPath eq null}" == "true") {
				$("#appIconSelect option").eq(2).prop("selected", "selected");	
			}
		} else if ("${not empty noticeSendInfo}" == "true") {
			if ("${noticeSendInfo.imgPath ne ''}" == "true" && "${noticeSendInfo.imgPath ne null}" == "true") {
				$("#appIconSelect option").eq(1).prop("selected", "selected");
			} else if ("${noticeSendInfo.imgPath eq ''}" == "true" || "${noticeSendInfo.imgPath eq null}" == "true") {
				$("#appIconSelect option").eq(2).prop("selected", "selected");	
			}
		}
	}
	
	// callBack : 엑셀 파일 업로드
	function fnCallBackFileUpload(file) {
		var sendData = {
			fileName : file.fileName
			, filePath : file.filePath
		}
		var options = {
			url : "<spring:url value='/appweb/pushMsgSendExcelUpload.do' />"
			, data : sendData
			, callBack : function(data) {
				if (data.resultList.length == 0) {
					messager.alert("엑셀 파일의 회원 번호와 일치하는 회원이 없습니다.", "Info", "info");
					return;
				}
				var receiverTxt = "";
				mbrNos = [];
				for(var i=0; i<data.resultList.length; i++) {
					mbrNos.push(data.resultList[i].mbrNo.toString());
					receiverTxt += data.resultList[i].mbrNm + "(" + data.resultList[i].loginId + ")";
					if (i == data.resultList.length-1) {
						break;
					}
					receiverTxt += ", ";
				}
				
				let byteVal = receiverByteCheck(receiverTxt);
				$("#receiverListTxt").val(receiverTxt);
				
				if (byteVal > 90) {
					$("#receiverListTxt2").html(receiverTxt);
					$("#receiverListTxt").css("background", "url(../images/lnb_tree_arr2.gif) 545px no-repeat");
					$("#receiverListTxt").addClass("pointer");
				} else {
					$("#receiverListTxt").css("background", "");
					$("#receiverListTxt2").html("");
					$("#receiverListTxt").removeClass("pointer");
				}
			}
		}
		ajax.call(options);
	}
	
	// 발송일 초단위 변경
	function sendReqDtmSecChange(obj) {
		$("#sendReqDtmSec").val(obj.value);
	}
	
	// 템플릿 선택 팝업
	function pushTemplateSelectViewPop() {
		var options = {
			url : "<spring:url value='/appweb/pushTemplateSelectView.do' />"
			, dataType : "html"
			, callBack : function(data) {
				var config = {
					id : "pushTemplateSelectView"
					, title : "알림 메시지 템플릿 선택"
					, height : 620
					, body : data
				}
				layer.create(config);
			}
		}
		ajax.call(options);
	}
	
	// App 아이콘 선택
	function appIconSelectChange() {
		$("#imgPath").val("");
		$("#appImgUrl").val("");
		$("#appIconImgTag").attr("src", "/images/noimage.png");
		if ($("#appIconSelect option:selected").val() == "appIconImg") {
			$(".appIcon").hide();
			$("#appIconImg").show();
		} else if ($("#appIconSelect option:selected").val() == "appImgUrl") {
			$(".appIcon").hide();
			$("#appImgUrlArea").show();
		} else {
			$(".appIcon").hide();
		}
	}
	
	// 수신 대상자 선택 팝업
	function memberListViewPop() {
		var options = {
			multiselect : true
			, param : memberSearchParam
			, callBack : function (data) {
				memberSearchParam = $("#layerMemberSearchForm").serializeJson();
				var receiverTxt = "";
				mbrNos = [];
				for(var i=0; i<data.length; i++) {
					mbrNos.push(data[i].mbrNo);
					receiverTxt += data[i].mbrNm
					if (i == data.length-1) {
						break;
					}
					receiverTxt += ", ";
				}
				
				let byteVal = receiverByteCheck(receiverTxt);
				$("#receiverListTxt").val(receiverTxt);
				
				if (byteVal > 90) {
					$("#receiverListTxt2").html(receiverTxt);
					$("#receiverListTxt").css("background", "url(../images/lnb_tree_arr2.gif) 545px no-repeat");
					$("#receiverListTxt").addClass("pointer");
				} else {
					$("#receiverListTxt").css("background", "");
					$("#receiverListTxt2").html("");
					$("#receiverListTxt").removeClass("pointer");
				}
			}
		}
		layerMemberList.create(options);
	}
	
	// 수신대상자 문자열 바이트 체크
	function receiverByteCheck(receiverTxt) {
		let cnt = 0;
		let ch = "";

		for (let j=0; j<receiverTxt.length; j++) {
			ch = receiverTxt.charAt(j);
			if (escape(ch).length > 4) {
				cnt += 2;
			} else {
				cnt += 1;
			}
		}
		return cnt;
	}
	
	// 템플릿 초기화
	function noticeSendViewReset(form) {
		resetForm(form);
		if ($("#templateHtml").siblings("iframe").length != 0) {
			oEditors.getById["templateHtml"].exec("SET_IR", [""]);
			$("#templateHtml").siblings("iframe").remove();
			$("#templateHtml").show();
		}
		$("#templateArea").find("input,textarea").val("");
		$("#tmplCd").val("");
		$("#appPushArea").hide();
		$("#appPushArea2").hide();
		$("#pushDateArea").show();
		$("#receiverListTxt").css("background", "");
		$("#receiverListTxt").removeClass("pointer");
		$("#receiverListTxt2").html("");
		
		if ($("#receiverListDiv").css("display") == "block") {
			$("#receiverListDiv").hide();
		}
		
		$("#receiverSelectBtn").show();
		$("#receiverExcelUploadBtn").hide();
		$("#excelTmplDownloadBtn").hide();
		$("#excelUploadDesc").show();
		$("#sendReqDtmSec").val("00");
		$("#osGbArea").hide();
		$("#lmsFileUploadArea").show();
		$("#sndTypeCd option[value=${adminConstants.SND_TYPE_20}]").prop("selected", "selected");
		
		$("#tmplDirectInputBtn").attr("disabled", false);
		$("#sendMaketing").attr("disabled", false);
		selectEmptyTemplate();
	}
	
	// 알림 발송 (신규 발송, 예약 발송 수정)
	function sendPushMessage(sendGb) {
		if ($("#templateHtml").siblings("iframe").length != 0) {
			oEditors.getById["templateHtml"].exec("UPDATE_CONTENTS_FIELD", []);
		}
		
		if(validate.check("pushMessageSendForm")) {
			var sendData = $("#pushMessageSendForm").serializeJson();
			sendData = sendDataUpdate(sendData);
			if (sendData.noticeTypeCd == "${adminConstants.NOTICE_TYPE_20}") {
				var dateStr = sendData.sendReqDtm.replaceAll("-", "");
				dateStr += $("#sendReqDtmHr option:selected").val();
				dateStr += $("#sendReqDtmMn option:selected").val();
				dateStr += $("#sendReqDtmSec").val();
				var year  = dateStr.substr(0,4);
				var month = dateStr.substr(4,2) - 1;
				var day   = dateStr.substr(6,2);
				var hour = dateStr.substr(8,2);
				var min = dateStr.substr(10,2);
				var sec = dateStr.substr(12,2);
				var currentDtm = new Date().getTime();
				var sendReqDtm = new Date(year,month,day,hour,min,sec).getTime();
				if (currentDtm > sendReqDtm) {
					messager.alert("예약발송 일시를 미래의 일시로 설정해 주세요.", "Info", "info");
					return;
				}
			}
			
			if (sendData.mbrNos.length == 0 && sendGb != "20") {
				messager.alert("수신대상자를 선택해 주세요.", "Info", "info");
				return;
			}
			if (sendData.sndTypeCd == "${adminConstants.SND_TYPE_10}") {
				if (sendData.appIconSelect == "appImgUrl") {
					sendData.imgPath = $("#appImgUrl").val();
				}
				if (sendData.appIconSelect == "none") {
					sendData.imgPath = "";
				}
				if (!sendData.imgPath && sendData.appIconSelect != "none") {
					messager.alert("APP 아이콘을 선택해 주세요.", "Info", "info");
					return;
				}
			}
			if (!sendData.subject) {
				messager.alert("제목을 입력해 주세요.", "Info", "info");
				return;
			}
			if ($("#templateHtml").siblings("iframe").length != 0) {
				oEditors.getById["templateHtml"].exec("UPDATE_CONTENTS_FIELD", []);
				// HTML 내용 필수값 체크
				if( $("#templateHtml").val().replace(/<img /gi, "img ").replace(/(<([^>]+)>)/gi, "").replace(/&nbsp;/gi, "").trim() === "" ) {	// 공백일 경우
					messager.alert("내용을 입력해 주세요.", "Info", "info");
					return;
				}
			} else {
				if (!sendData.contents) {
					messager.alert("내용을 입력해 주세요.", "Info", "info");
					return;
				}
			}
			if (!sendData.sndTypeCd) {
				messager.alert("전송방식을 선택해 주세요.", "Info", "info");
				return;
			}
			
			if (sendData.sndTypeCd == "${adminConstants.SND_TYPE_10}") {
				if (!sendData.deviceTypeCd) {
					messager.alert("OS 구분을 선택해 주세요.", "Info", "info");
					return;
				}
			}
			
			var options = {};
			if (sendGb == "10") { // 신규 발송
				options = {
					url : "<spring:url value='/appweb/sendPushMessage.do' />"
					, data : sendData
					, callBack : function (data) {
						messager.alert("<spring:message code='column.common.send.final_msg' />","Info","info",function(){
							updateTab('/appweb/pushMessageView.do?noticeTypeCd=' + sendData.noticeTypeCd, '알림 메시지 발송내역 관리');
						});
					}
				};
			} else if (sendGb == "20") { // 예약 발송 수정
				options = {
					url : "<spring:url value='/appweb/updateNoticeSendList.do' />"
					, data : sendData
					, callBack : function (data) {
						messager.alert("<spring:message code='column.common.edit.final_msg' />","Info","info",function(){
							grid.reload("pushReserveList", options);
							layer.close('pushMessageSendViewPop');
						});
					}
				};
			}
			ajax.call(options);
		}
	}
	
	// 예약 알림 발송 삭제
	function deleteNoticeSend() {
		var sendData = $("#pushMessageSendForm").serializeJson();
		
		var options = {
			url : "<spring:url value='/appweb/deleteNoticeSendList.do' />"
			, data : sendData
			, callBack : function (data) {
				messager.alert("삭제 되었습니다.","Info","info",function(){
					grid.reload("pushReserveList", options);
					layer.close('pushMessageSendViewPop');
				});
			}
		};
		ajax.call(options);
	}
	
	// 수신 대상자 엑셀 업로드 양식 다운로드
	function pushUploadTmplExcelDownload() {
		var headerName = new Array();
		var fieldName = new Array();
		
		headerName.push("회원 번호");
		fieldName.push("mbrNo");
		
		var excelData = {
			headerName : headerName
			, fieldName : fieldName
			, sheetName : "pushUploadTmplExcelDownload"
			, fileName : "pushUploadTmplExcelDownload"
			, pushTpGb : "receiverUpload"
		};
		
		createFormSubmit("pushUploadTmplExcelDownload", "/appweb/pushCommonExcelDownload.do", excelData);
	}
	
	// 전송방식 변경 이벤트
	function sndTypeCdChange(clearGb, tmplGb, callGb) {
		if (clearGb != "N") {
			$("#tmplCd").val("");
			$("#tmplNo").val("");
			$("#templateArea").find("input,textarea").val("");
			
			if ($("#templateHtml").siblings("iframe").length != 0) {
				oEditors.getById["templateHtml"].exec("SET_IR", [""]);
			}
		}
		
		var sndTypeSelect = $("#sndTypeCd option:selected").val();
 		$("#templateHtml").attr('maxlength', '500');
 		$("#templateHtml").removeClass( 'validate[required]');
 		$("#templateHtml").removeClass( 'validate[required, maxSize[500]]').addClass('validate[required, maxSize[500]]');
		
 		if (sndTypeSelect == "${adminConstants.SND_TYPE_10}") {
			if ("${not empty noticeSendInfoList}" == "true" || "${not empty noticeSendInfo}" == "true") {
				appPushImgIconSelect();
			} else if (tmplGb == undefined) {
				$("#appIconSelect option[value=appIconImg]").prop("selected", "selected");
			}
			$("#appIconSelect").val("none");
			$("#appIconImg").hide();
			$("#osGbArea").show();
			$("#appPushArea").show();
			$("#appPushArea2").show();
			$(".appIcon").hide();
			$("#movPath").val("");
			$("#appIconImgTag").attr("src", "/images/noimage.png");
			var appIconSelect = $("#appIconSelect option:selected").val();
			if (appIconSelect == "appImgUrl") {
				$("#appImgUrlArea").show();
			} else if (appIconSelect == "appIconImg") {
				$("#appIconImg").show();
			}
		} else {
			$("#osGbArea").hide();
			$("#appPushArea").hide();
			$("#appPushArea2").hide();
		}
		
		if (sndTypeSelect == "${adminConstants.SND_TYPE_20}") {			
			$("#lmsFileUploadArea").show();
			$("#subject").removeClass("readonly");
			$("#templateHtml").removeClass("readonly");
			
		} else {
			$("#lmsFileUploadArea").hide();
		}
		
		if (sndTypeSelect == "${adminConstants.SND_TYPE_30}") {
			$("#tmplDirectInputBtn").attr("disabled", true);
			$("#pushTemplateSelect").prop("checked", true);
			$("#sendMaketing").attr("disabled", true);
			$("#sendInfo").prop("checked", true);
			$("#tmpTable").show();
			$("#subject").prop("readonly", true);
			$("#subject").addClass("readonly");
			$("#templateHtml").prop("readonly", true);
			$("#templateHtml").addClass("readonly");
		} else {
			$("#tmplDirectInputBtn").attr("disabled", false);
			$("#sendMaketing").attr("disabled", false);
			$("#subject").prop("readonly", false);
			$("#subject").removeClass("readonly");
			$("#templateHtml").prop("readonly", false);
			$("#templateHtml").removeClass("readonly");
			
		}
		
		if (sndTypeSelect == "${adminConstants.SND_TYPE_40}") {
			$("#templateHtml").removeAttr( 'maxlength' );
			$("#templateHtml").removeClass('validate[required, maxSize[500]]').addClass( 'validate[required]');
			
			var inputVal = $("input[name=receiverSendInfo]:checked").val();
			var maketingApet = "(광고) 어바웃펫";
			var emailHtml = "\n고객센터: 1644-9610\n수신거부: 어바웃펫\n로그인>서비스이용약관>마케팅정보\n수신동의 >동의철회";
			var newStr = emailHtml.replace(/\n/gi,'<br>');
			var tmplVal = $("input[name=receiverTemplate]:checked").val();
			
			if ($("#templateHtml").siblings("iframe").length == 0) {
				EditorCommon.setSEditor('templateHtml','/template');
			}
			
			if(callGb == undefined){
				if(inputVal == '20') {
					$("#subject").val(maketingApet);
					 setTimeout(function() {
		                 oEditors.getById["templateHtml"].exec("SET_IR", [newStr]);
		            }, 400);
					 
				}else {
					setTimeout(function() {
		            	oEditors.getById["templateHtml"].exec("SET_IR", [""]);
		            }, 400);
					$("#subject").val("");
					$("#templateHtml").val("");
				}
			}

		} else {
			if ($("#templateHtml").siblings("iframe").length != 0) {
				$("#templateHtml").siblings("iframe").remove();
				$("#templateHtml").show();
			}
			
			if(callGb == undefined){
				$("input[name=receiverSendInfo]:checked").click();
			}
		}
		
		}
	
	// 템플릿 직접 입력 함수
	function selectEmptyTemplate() {
		var tmplVal = $("input[name='receiverTemplate']:checked").val();
		if(tmplVal == '20'){
			$("#tmpTable").show();
		}else {
			$("#tmpTable").hide();
		}
		
		var tmplVal = $("input[name='receiverTemplate']:checked").val();
		var sndTypeSelect = $("#sndTypeCd option:selected").val();
		if(tmplVal == '10'){
			$("#subject").prop("readonly", false);
			$("#subject").removeClass("readonly");
			$("#templateHtml").prop("readonly", false);
			$("#templateHtml").removeClass("readonly");
			$("#subject").attr("placeholder", "메시지 제목을 100자 이내 입력하세요");
			$("#templateHtml").attr("placeholder", "메시지 내용을 입력해 주세요");
		}else {
			if(sndTypeSelect == "${adminConstants.SND_TYPE_40}"){
				oEditors.getById["templateHtml"].exec("SET_IR", [""]);
			}
			$("#subject").prop("readonly", true);
			$("#subject").addClass("readonly");
			$("#templateHtml").prop("readonly", true);
			$("#templateHtml").addClass("readonly");
			$("#subject").val("");
			$("#templateHtml").val("");
			$("#subject").removeAttr("placeholder");
			$("#templateHtml").removeAttr("placeholder");
		}
		
	}
	
	// 문자 이미지 파일 업로드 콜백 함수
	function mmsResultImage(file){
		$("#imgPath").val(file.filePath);
		$("#lmsFileUpload").val(file.fileName);
	}
	
	// app push 이미지 파일 업로드 콜백 함수
	function appPushResultImage(file){
		$("#imgPath").val(file.filePath);
		$("#appIconImgTag").attr("src", '/common/imageView.do?filePath=' + file.filePath);
	}
	
	// 데이터 변경 함수
	function sendDataUpdate(sendData) {
		if (sendData.appAllGb == "on") {
			sendData.deviceTypeCd = "${adminConstants.DEVICE_TYPE_30}";
		}
		
		if (sendData.noticeTypeCd == "${adminConstants.NOTICE_TYPE_10}") {
			sendData.sendReqDtm = "";
			sendData.sendReqDtmHr = "";
			sendData.sendReqDtmMn = "";
			sendData.sendReqDtmSec = "";
		}
		
		if (sendData.appIconSelect == "appImgUrl") {
			sendData.imgPath = $("#appImgUrl").val();
		}
		
		$.extend(sendData, {
			contents : sendData.templateHtml
			, mbrNos : mbrNos
		});
		
		return sendData;
	}

</script>