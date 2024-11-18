<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<jsp:include page="./include/pushTemplateCommonScript.jsp" />
<script type="text/javascript">
	$(document).ready(function(){
		sndTypeCdChange("N", "Y");
		$("#pushTemplateDetailViewPop_dlg-buttons").children().eq(3).remove();
	});
	
	// 템플릿 수정
	function updateNoticeTemplate() {
		if ($("#templateHtml").siblings("iframe").length != 0) {
			oEditors.getById["templateHtml"].exec("UPDATE_CONTENTS_FIELD", []);
		}
		
		if(validate.check("pushTemplateViewForm")) {
			var sendData = $("#pushTemplateViewForm").serializeJson();
			$.extend(sendData, {
				contents : sendData.templateHtml
			});
			
			if (!sendData.sndTypeCd) {
				messager.alert("전송방식을 선택해 주세요.", "Info", "info");
				return;
			}
			if (!sendData.ctgCd) {
				messager.alert("카테고리를 선택해 주세요.", "Info", "info");
				return;
			}
			if (sendData.sndTypeCd == "${adminConstants.SND_TYPE_30}") {
				if (!sendData.tmplCd) {
					messager.alert("템플릿 코드를 입력해 주세요.", "Info", "info");
					return;
				}
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
				// HTML 내용 필수값 체크
				if($("#templateHtml").val().replace(/<img /gi, "img ").replace(/(<([^>]+)>)/gi, "").replace(/&nbsp;/gi, "").trim() === "" ) {	// 공백일 경우
					messager.alert("내용을 입력해 주세요.", "Info", "info");
					return;
				}
			} else {
				if (!sendData.contents) {
					messager.alert("내용을 입력해 주세요.", "Info", "info");
					return;
				}
			}
			
			var options = {
				url : "<spring:url value='/appweb/saveNoticeTemplate.do' />"
				, data : sendData
				, callBack : function (data) {
					messager.alert("<spring:message code='column.common.edit.final_msg' />","Info","info",function(){
						layer.close("pushTemplateDetailViewPop");
						grid.reload("pushTemplateList", options);
					});
				}
			};
			ajax.call(options);
		}
	}
	
	// 템플릿 삭제
	function deleteNoticeTemplate() {
		var options = {
			url : "<spring:url value='/appweb/deleteNoticeTemplate.do' />"
			, data : $("#pushTemplateViewForm").serializeJson()
			, callBack : function(result) {
				messager.alert("삭제 되었습니다.","Info","info",function(){
					layer.close("pushTemplateDetailViewPop");
					grid.reload("pushTemplateList", options);
				});
			}
		}
		ajax.call(options);
	}
</script>
<jsp:include page="./include/pushTemplateCommonContent.jsp" />
