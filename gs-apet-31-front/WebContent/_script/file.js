var fileUpload = {
	file : function(callback) {
		fileUpload.callBack = callback;
		fileUpload.fileForm("file");
	},
	xls : function(callback) {
		fileUpload.callBack = callback;
		fileUpload.fileForm("xls");
	},
	image : function(callback) {
		fileUpload.callBack = callback;
		fileUpload.objId = "profileimage";
		fileUpload.fileForm("image");
	},
	profileimage : function(callback) {
		fileUpload.callBack = callback;
		fileUpload.objId = "profileimage";
		fileUpload.fileForm("profileimage"); 
	},
	profileMwebimage : function(callback) {
		fileUpload.callBack = callback;
		fileUpload.objId = "profileimage";
		fileUpload.fileForm("mwebProfileimage");
	},
	cdnImage : function(callback, prePath) {
		fileUpload.callBack = callback;
		fileUpload.fileForm("image", prePath);
	},
	jpg : function(callback) {
		fileUpload.callBack = callback;
		fileUpload.fileForm("jpg");
	},	
	goodsImage : function(callback, objId) {
		fileUpload.callBack = callback;
		fileUpload.objId = objId;
		fileUpload.fileForm("image");
	},
	inquiry : function(callback) {
		fileUpload.callBack = callback;
		fileUpload.fileForm("inquiry");
	},
	fileForm : function(type, prePath) {
		$("#fileUploadForm").remove();
		var html = [];
		html
				.push("<form name=\"fileUploadForm\" id=\"fileUploadForm\" method=\"post\" enctype=\"multipart/form-data\">");
		html.push("	<div style=\"display:none;\">");
		html
				.push("		<input type=\"file\" name=\"uploadFile\" id=\"uploadFile\" />");
		html.push("		<input type=\"hidden\" name=\"uploadType\" value=\""
				+ type + "\">");
		if (prePath != undefined) {
			html.push("		<input type=\"hidden\" name=\"prePath\" value=\""
					+ prePath + "\">");
		}
		html.push("	</div>");
		html.push("</form>");
		$("body").append(html.join(''));
		$("#uploadFile").click();
	},
	callBack : null,
	objId : null
}
$(document).on(
		"change",
		"#uploadFile",
		function() {
		
			if(fileUpload.objId == "profileimage"){
				   var fileValue = $("#uploadFile").val().split("\\");
				   var fileName = fileValue[fileValue.length-1];
				   if(!/\.(jpg|jpeg|png)$/i.test(fileName)){
					   ui.toast("png, jpg 파일만 등록할 수 있어요.",{
							bot : 74
						}); return
					    }
				}
			
			waiting.start();
			
			var url = '/common/fileUploadResult';
			if ($("input[name=prePath]").val() != undefined) {
				url = '/common/fileUploadNcpResult';
			}
			$('#fileUploadForm').ajaxSubmit(
					{
						url : url,
						dataType : 'json',
						success : function(result) {
							$("#fileUploadForm").remove();
							waiting.stop();
							if (result.exCode != null
									&& result.exCode !== undefined
									&& result.exCode !== "") {
								if(fileUpload.objId == "profileimage"){
											//ui.toast(result.exMsg,{
											//	bot : 74
											//});
									}else{
											ui.alert("<div>"+result.exMsg+"</div>",{
												ycb:function(){
													$(".popAlert").remove();
												}
												,  ybt:"확인"
											});
									}
							} else {
								if (fileUpload.objId != null) {
									// 상품 이미지 등록 부분을 위한 처리..
									fileUpload.callBack(result.file,
											fileUpload.objId);
								} else {
									fileUpload.callBack(result.file);
								}
							}
						},
						error : function(xhr, status, error) {
							waiting.stop();
							if (xhr.status === 1000) {
								location.replace("/indexLogin");
							} else {
								ui.alert("<div>오류가 발생되었습니다. 관리자에게 문의하십시요.[" + xhr.status + "][" + error + "]</div>",{
									ycb:function(){
										$(".popAlert").remove();
									}
									,  ybt:"확인"
								});
							}
						}
					});

		});

