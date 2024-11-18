<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<script type="text/javascript">
	//APP PUSH 이미지 아이콘 선택
	function appPushImgIconSelect() {
		if ("${noticeTemplateInfo.imgPath ne ''}" == "true" && "${noticeTemplateInfo.imgPath ne null}" == "true") {
			$("#appIconSelect option").eq(1).prop("selected", "selected");
		} else if ("${noticeTemplateInfo.imgPath eq ''}" == "true" || "${noticeTemplateInfo.imgPath eq null}" == "true") {
			$("#appIconSelect option").eq(2).prop("selected", "selected");
		}
	}
	
	//전송방식 변경 이벤트
	function sndTypeCdChange(clearGb, tmplGb) {
		if (clearGb != "N") {
			$("#templateArea").find("input,textarea").val("");
		}
		
		var sndTypeSelect = $("#pushTemplateViewForm #sndTypeCd option:selected").val();
		
		if (sndTypeSelect == "${adminConstants.SND_TYPE_10}") {
			if ("${not empty noticeTemplateInfo}" == "true" && tmplGb == "Y") {
				appPushImgIconSelect();
			} else if (tmplGb == undefined) {
				$("#appIconSelect option[value=none]").prop("selected", "selected");
			}
			$(".appPushArea").show();
			$(".appIcon").hide();
			$("#appIconImgTag").attr("src", "/images/noimage.png");
			
			var appIconSelect = $("#appIconSelect option:selected").val();
			if (appIconSelect == "appImgUrl") {
				$("#appImgUrlArea").show();
			} else if (appIconSelect == "appIconImg") {
				$("#appIconImg").show();
			}
		} else {
			$(".appPushArea").hide();
		}
		
		if (sndTypeSelect == "${adminConstants.SND_TYPE_20}") {
			$("#lmsFileUploadArea").show();
		} else {
			$("#lmsFileUploadArea").hide();
		}
		
		if (sndTypeSelect == "${adminConstants.SND_TYPE_30}") {
			$("#tmplCdArea").show();
		} else {
			$("#tmplCdArea").hide();
		}
		
		if (sndTypeSelect) {
			if (sndTypeSelect != "${adminConstants.SND_TYPE_40}") {
				if ($("#templateHtml").siblings("iframe").length != 0) {
					$("#templateHtml").siblings("iframe").remove();
					$("#templateHtml").show();
				}
			} else {
				if ($("#templateHtml").siblings("iframe").length == 0) {
					initEditor();
				}
			}
		}
	}
	
	// 변수 리스트 팝업
	function pushVariableViewPop() {
		var options = {
			url : "<spring:url value='/appweb/pushVariableViewPop.do' />"
			, dataType : "html"
			, callBack : function(data) {
				var config = {
					id : "pushVariableViewPop"
					, title : "변수 리스트"
					, width: 700
					, body : data
				}
				layer.create(config);
			}
		}
		ajax.call(options);
	}
	
	function initEditor() {
		EditorCommon.setSEditor('templateHtml','/template');
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
	
	// 파일 업로드 콜백 함수
	function resultFile(file){
		$("#imgPath").val(file.filePath);
		$("#lmsFileUpload").val(file.fileName);
	}
	
	// 이미지 파일 업로드 콜백 함수
	function resultImage(file){
		$("#imgPath").val(file.filePath);
		$("#appIconImgTag").attr("src", '/common/imageView.do?filePath=' + file.filePath);
	}
</script>