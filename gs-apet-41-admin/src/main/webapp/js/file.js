var fileUpload = {
	/*
	 *  maxFileSize : MB 단위
	 */
	file : function(callback, maxFileSize) {
		fileUpload.callBack = callback;
		fileUpload.fileForm("file", '', maxFileSize);
	}
	, fileFilter : function(callback, filter, maxFileSize) {
		fileUpload.callBack = callback;
		fileUpload.fileForm("file", filter, maxFileSize);
	}
	, xls : function(callback, maxFileSize) {
		fileUpload.callBack = callback;
		fileUpload.fileForm("xls", '', maxFileSize);
	}
	, image : function(callback, maxFileSize){
		fileUpload.callBack = callback;
		fileUpload.fileForm("image", '', maxFileSize);
	}
	// limitObj { fileSize -> 용량 제한 크기, height : px, width : 가로 } , filter -> 배열
	, imageCheck : function(callback,objId,limitObj){
		fileUpload.callBack = callback;
		fileUpload.objId = objId;
		if(limitObj.fileSize){
			fileUpload.maxSize = limitObj.fileSize;			// 바이트
		}
		if(limitObj.height){
			fileUpload.maxHeight = limitObj.height;			// px
		}
		if(limitObj.width){
			fileUpload.maxWidth = limitObj.width;			// px
		}

		fileUpload.fileForm("imageFile",'');
	}
	,  cdnImage : function(callback, prePath, maxFileSize){
		fileUpload.callBack = callback;
		fileUpload.fileForm("image", '', maxFileSize, prePath);
	}
	, editorImage : function(editorId, imgPath) {
		fileUpload.callBack = function(data) {
			data.imgPath = imgPath;
			var options = {
				url : "/common/editorImageFileResult.do"
				, data : data
				, callBack : function(result){
					EditorCommon.pasteHTML(editorId, result.filePath);
				}
			};
			ajax.call(options);
		}
		fileUpload.fileForm("image", '');
	}
	, goodsImage : function (callback, objId, maxFileSize ) {
		fileUpload.callBack = callback;
		fileUpload.objId = objId;
		fileUpload.fileForm("image", '', maxFileSize);
	}
	, fileForm : function(type, filter, maxFileSize, prePath){
		maxFileSize = !maxFileSize ? '' : maxFileSize;
		prePath = !prePath ? '' : prePath;
		$("#fileUploadForm").remove();
		var html = [];
		html.push("<form name=\"fileUploadForm\" id=\"fileUploadForm\" method=\"post\" enctype=\"multipart/form-data\">");
		html.push("	<div style=\"display:none;\">");
		html.push("		<input type=\"file\" name=\"uploadFile\" id=\"uploadFile\" />");
		html.push("		<input type=\"hidden\" name=\"uploadType\" value=\"" + type + "\">");
		html.push("		<input type=\"hidden\" name=\"filter\" value=\"" + filter + "\">");
		html.push("		<input type=\"hidden\" name=\"maxFileSize\" value=\"" + maxFileSize + "\">");
		html.push("		<input type=\"hidden\" name=\"prePath\" value=\"" + prePath + "\">");
		html.push("	</div>");
		html.push("</form>");
		$("body").append(html.join(''));
		$("#uploadFile").click();
	}
	, callBack : null
	, objId : null
	, goodsImageBulk : function (callback, progressCallBack) {
		fileUpload.callBack = callback;
		fileUpload.objId = 'goodsImageBulk';
		fileUpload.progressCallBack = progressCallBack;
		fileUpload.bulkFileForm("image", progressCallBack);
	}
	, bulkFileForm : function(type){
		$("#fileUploadForm").remove();
		var html = [];
		html.push("<form name=\"bulkFileUploadForm\" id=\"bulkFileUploadForm\" method=\"post\" enctype=\"multipart/form-data\">");
		html.push("	<div style=\"display:none;\">");
		html.push("		<input multiple=\"multiple\" type=\"file\" name=\"uploadFileBulk\" id=\"uploadFileBulk\" />");
		html.push("		<input type=\"hidden\" name=\"uploadType\" value=\"" + type + "\">");
		html.push("	</div>");
		html.push("</form>");
		$("body").append(html.join(''));
		$("#uploadFileBulk").click();
	}
}
$(document).on("change", "#uploadFile", function(){
	waiting.start();
	var url = '/common/fileUploadResult.do';
	if ($("input[name=prePath]").val() != '' && $("input[name=prePath]").val() != null) {
		url = '/common/fileUploadNcpResult.do';
	}

	$('#fileUploadForm').ajaxSubmit({
		url : url
		, dataType : 'json'
		, success : function(result){
			$("#fileUploadForm").remove();
			waiting.stop();
			if(result.exCode != null && result.exCode !== ""){
				messager.alert(result.exMsg, "Info", "info");
			} else {
				if(fileUpload.maxWidth || fileUpload.maxHeight){
					var img = new Image();
					img.onload = function(){
						var r = false;
						var width = this.width;
						var height = this.height;
						var txt = "";

						//기획전인 경우에만
						if(fileUpload.objId == "bnrImgPath" || fileUpload.objId == "bnrMoImgPath"){
							r = true;
							if(fileUpload.maxWidth != width && fileUpload.maxHeight != height){
								r = false;
								txt ="가로, 세로 사이즈를 확인해주세요.";
							}
							else if(fileUpload.maxWidth != width){
								r = false;
								txt ="가로 사이즈를 확인해주세요.";
							}
							else if(fileUpload.maxHeight != height){
								r = false;
								txt ="세로 사이즈를 확인해주세요.";
							}
						//나머지 
						}else{
							if(fileUpload.maxWidth){
								r = width <= fileUpload.maxWidth;
								txt ="가로 사이즈를 확인해주세요.";
							}
							if(fileUpload.maxHeight){
								r = height <= fileUpload.maxHeight;
								txt ="세로 사이즈를 확인해주세요.";
							}
						}

						if(!r){
							messager.alert(txt,"Info");
						}else if(fileUpload.objId != null){
							// 상품 이미지 등록 부분을 위한 처리..
							fileUpload.callBack(result.file, fileUpload.objId );
						}else{
							fileUpload.callBack(result.file);
						}
					}
					img.setAttribute('src','/common/imageView.do?filePath=' + result.file.filePath);
				}else{
					if(fileUpload.objId != null ) {
						// 상품 이미지 등록 부분을 위한 처리..
						fileUpload.callBack(result.file, fileUpload.objId );
					} else {
						fileUpload.callBack(result.file);
					}
				}
			}
		}
		, error : function(xhr, status, error) {
			waiting.stop();
			if(xhr.status === 1000) {
				location.replace("/login/noSessionView.do");
			} else {
				messager.alert("오류가 발생되었습니다. 관리자에게 문의하십시요.["+xhr.status+"]["+error+"]", "Error", "error");
			}
		}
	});
});

var $progressBar = $("#progressBar");
function setProgress(per) {
$progressBar.val(per);
}

// 일괄 업로드
$(document).on("change", "#uploadFileBulk", function(){
	waiting.start();
	var url = '/common/bulkFileUploadResult.do';
	$('#bulkFileUploadForm').ajaxSubmit({
		url : url
		, dataType : 'json'
		, success : function(result){
			$("#bulkFileUploadForm").remove();
			waiting.stop();
			if(result.exCode != null && result.exCode !== ""){
				if(fileUpload.objId == 'goodsImageBulk'){
					$("#bulkImgResult").text("이미지 업로드 실패");
					$("#bulkImgResult").css("color","red");
					$("#bulkImgResult").show();
				}else{
					messager.alert("오류가 발생되었습니다. 관리자에게 문의하십시요.["+xhr.status+"]["+error+"]", "Error", "error");
				}
			} else {
				fileUpload.callBack(result);
			}
		}
		, xhr: function() { //XMLHttpRequest 재정의 가능
			var xhr = $.ajaxSettings.xhr();
			xhr.upload.onprogress = function(e) { //progress 이벤트 리스너 추가
				if(fileUpload.progressCallBack != undefined){
					fileUpload.progressCallBack(Math.floor(e.loaded / e.total * 100));
				}
			};
			return xhr;
		}
		, error : function(xhr, status, error) {
			waiting.stop();
			if(xhr.status === 1000) {
				location.replace("/login/noSessionView.do");
			} else {
				if(fileUpload.objId == 'goodsImageBulk'){
					$("#bulkImgResult").text("이미지 업로드 실패");
					$("#bulkImgResult").css("color","red");
					$("#bulkImgResult").show();
				}else{
					messager.alert("오류가 발생되었습니다. 관리자에게 문의하십시요.["+xhr.status+"]["+error+"]", "Error", "error");
				}
			}
		}
	});
});
