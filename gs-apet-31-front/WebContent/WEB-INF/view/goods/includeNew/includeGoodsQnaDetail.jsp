<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>

<script type="text/javascript">
	//등록 수정 여부 
	var updateYn;

	$(function(){
		goodsQna.getGoodsInquiryList();
		//비밀 글 제외
		$("#hiddenCheck").on('click', function(){
			if(this.checked){
				goodsQna.hiddenYn = "N";
			}else{
				goodsQna.hiddenYn = "Y";
			}
			goodsQna.page = null;
			goodsQna.getGoodsInquiryList();
		});
		if('${goodsTotalCount.goodsQnaTotal}' != '' && '${goodsTotalCount.goodsQnaTotal}' != '0'){
			$("#qnaHidden").show();
		}else{
			$("#qnaHidden").hide();
		}
		
		//문의 더보기
		$("#qnaMore").on('click', function(){
			goodsQna.page = parseInt(goodsQna.page) + 1;
			goodsQna.getGoodsInquiryList(goodsQna.addGoodsInquiry);
		});

		$("#goodsLayers").on('click', 'button[name=delImg]', function(){
			delImage(this);
		})
		
		//작성하기 :: PC - 팝업, MO - 페이지
		$("#writeQna").on('click', function(){
			if(goodsQna.mbrNo == 0){
				ui.confirm('<spring:message code='front.web.view.common.msg.using.login.service' />',{
					ycb: function () {
						document.location.href = '/indexLogin?returnUrl=' + encodeURIComponent(document.location.href);
					},
					ncb: function () {
						return false;
					},
					ybt: "<spring:message code='front.web.view.common.msg.confirmation' />", // 기본값 "확인"
					nbt: "<spring:message code='front.web.view.common.msg.cancel' />"  // 기본값 "취소"
				});
			}else{
				/* if(goodsQna.device == "PC"){ */
					var options = {
						url : "<spring:url value='/goods/openGoodsQnaWritePop.do' />"
						, type : "POST"
						, dataType : "html"
						, done : function(result){
							//$("#popQnaMod").remove();
							//$("#goodsLayers").append(result);
							$("#goodsLayers").empty();
							$("#goodsLayers").html(result);
							updateYn = "in";
							ui.popLayer.open('popQnaMod');
						}
					};
					ajax.call(options);
				/* }else{
					location.href = "/goods/indexGoodsQna?goodsId=" + goodsQna.goodsId;
				} */
			}
			
		});
		
		//이미지 추가 버튼
		/* $("#goodsLayers").on('click', '#imgAddBtn-qna', function(){
			$("#goodsLayers").find('#imgAdd-qna').click();
		}); */
		
		//상품 문의 등록/수정
		$("#goodsLayers").on('click', '#insertQna', function(){
			if($("#qnaForm").find("input[name=goodsIqrNo]").val() != null && $("#qnaForm").find("input[name=goodsIqrNo]").val() != ''){
				goodsQna.updateGoodsQna();
			}else{
				goodsQna.insertGoodsQna();
			}
		});
		
		//이미지 삭제
		$("#goodsLayers").on('click', 'button[name=delImg]', function(){
			if($(this).parent().data('imgSeq') != null){
				var html = "<input type=\"hidden\" name=\"delImgSeqs\" value=\""+$(this).parent().data('imgSeq')+"\">";
				$("#qnaImgArea").append(html);
			}
			
			$(this).parents('li').remove();
			qnaImgCheck();
		});
		
		//작성하기 - 비밀글 여부 선택
		$("#goodsLayers").on('click', 'input[name=hiddenYnChck]', function(){
			if(this.checked){
				$("input[name=hiddenYn]").val("Y");
			}else{
				$("input[name=hiddenYn]").val("N");
			}
		});
		
		//작성하기 - 답변 알림 여부 선택
		$("#goodsLayers").on('click', 'input[name=rplAlmRcvYnChck]', function(){
			if(this.checked){
				$("input[name=rplAlmRcvYn]").val("Y");
			}else{
				$("input[name=rplAlmRcvYn]").val("N");
			}
		});
		
		//문의 글 등록버튼 제한 - 5자 이상 시 활성화
		$("#goodsLayers").on('propertychange keyup input change paste ', 'textarea[name=iqrContent]', function(){
			if($(this).val().length < 5){
				$("#insertQna").addClass('disabled');
				/* $("#insertQna").attr('disabled', 'disabled'); */
			}else{
				$("#insertQna").removeClass('disabled');
				/* $("#insertQna").removeAttr('disabled'); */
			}
			
			if($(this).val().length > 100){
				$(this).val($(this).val().substring(0,100));
				ui.toast("<spring:message code='front.web.view.goods.input.oneHundred.check.confirm' />");
			}
		});
		
		$(".layers").on('click', '#popQnaMod .btnPopClose', function(){
			popLayerClose();
// 			ui.confirm('<spring:message code='front.web.view.goods.qna.write.cancel.confirm' />',{ // 컨펌 창 옵션들
// 				ycb:function(){
// 					ui.popLayer.close('popQnaMod');
// 					$("#popQnaMod").remove();

// 					$(document).on("click", ".popLayer:not(.win, .popQnaMod) .btnPopClose:not(.none, [name=notClose])", function() {
// 						var id = $(this).closest(".popLayer").attr("id");
// 						ui.popLayer.close(id);
// 					});
// 				},
// 				ncb:function(){
// 					return false;
// 				},
// 				ybt:'<spring:message code='front.web.view.common.yes' />',
// 				nbt:'<spring:message code='front.web.view.common.no' />'
// 			});
		})
		
	});
	
	function popLayerClose(){
		var message;
		if(updateYn == "in"){
			message = "<spring:message code='front.web.view.goods.qna.write.cancel.confirm' />"
		}else{
			message = "<spring:message code='front.web.view.goods.qna.update.cancel.confirm' />"
		}
		
		ui.confirm(message,{ // 컨펌 창 옵션들
			ycb:function(){
				ui.popLayer.close('popQnaMod');
				$("#popQnaMod").remove();
				
				$(document).on("click", ".popLayer:not(.win, .popQnaMod) .btnPopClose:not(.none, [name=notClose])", function() {
					var id = $(this).closest(".popLayer").attr("id");
					ui.popLayer.close(id);
				});
			},
			ncb:function(){
				return false;
			},
			ybt:'<spring:message code='front.web.view.common.yes' />',
			nbt:'<spring:message code='front.web.view.common.no' />'
		});
	}
	
	var goodsQna = {
		goodsId : "${goods.goodsId}",
		hiddenYn : "Y",
		page : null,
		mbrNo : '${session.mbrNo}',
		totalPageCount : null,
		device : '${view.deviceGb}',
		getGoodsInquiryList : function(callback){
			var done = goodsQna.getGoodsInquiryResult;
			if(callback != undefined && callback != null){
				done = callback;
			}
			var options = {
				url : "<spring:url value='/goods/getGoodsInquiryList.do' />"
				, type : "POST"
				, dataType : "html"
				, data : {
						goodsId : goodsQna.goodsId
						, hiddenYn : goodsQna.hiddenYn
						, page : goodsQna.page==null?1:goodsQna.page
					}
				, done : done
			};
			ajax.call(options);
		},
		getGoodsInquiryResult : function(result){
			$("#qnaListScript").remove();
			$('#qnaList').html(result);
		},
		addGoodsInquiry : function(result){
			$("#qnaListScript").remove();
			$('#qnaList').append(result);
		},
		insertGoodsQna : function(){
			var imgRegYn = $("#qnaImgArea").children('li').length != 0?'Y':'N';

			if($("textarea[name=iqrContent]").val().length < 5){
				ui.toast('<spring:message code='front.web.view.goods.qna.content.check.msg' />');
				return false;
			}else if($("#insertQna").hasClass('disabled')){
				return false;
			}else{
				var addData = {
					goodsId : goodsQna.goodsId
					, iqrContent : $("textarea[name=iqrContent]").val()
				}
				var data = $.extend($("#qnaForm").serializeJson(), addData);
				
				if(goodsQna.device == 'APP'){
					data.imgPaths = null;
				}
				
				var options = {
					url : "<spring:url value='/goods/insertGoodsQna.do' />"
					, type : "POST"
					, data : data
					, done : function(result){
						if("${view.deviceGb}" == "${frontConstants.DEVICE_GB_30}" && imgRegYn == 'Y') {
							$("input[name=goodsIqrNo]").val(result.goodsIqrNo);
							onFileUpload(result.goodsIqrNo);
						}else{
							ui.popLayer.close('popQnaMod');
							goodsQna.hiddenYn = "Y";
							goodsQna.page = null;
							ui.toast('<spring:message code='front.web.view.goods.qna.write.result.msg' />');
							goodsQna.getGoodsInquiryList();
							$("#qnaHidden").show();
	
							$(document).on("click", ".popLayer:not(.win, .popQnaMod) .btnPopClose:not(.none, [name=notClose])", function() {
								var id = $(this).closest(".popLayer").attr("id");
								ui.popLayer.close(id);
							});
						}
					}
				};
				ajax.call(options);
				
			}
		},
		reWriteQna : function(goodsIqrNo){
			location.href = "/goods/indexGoodsQna?goodsId=" + goodsQna.goodsId + "&&goodsIqrNo=" + goodsIqrNo;
		},
		updateGoodsQna : function(){
			if($("textarea[name=iqrContent]").val().length == 0){
				ui.toast('<spring:message code='front.web.view.goods.write.content.msg' />');
				return false;
			}else if($("textarea[name=iqrContent]").val().length < 5){
				ui.alert('<spring:message code='front.web.view.goods.qna.content.check.msg' />');
				return false;
			}else if($("#insertQna").hasClass('disabled')){
				return false;
			}else{
			
				var imgRegYn = $("#qnaImgArea").find('img[name=goodsQnaImg]').length != 0?'Y':'N';
				
				var addData = {
					goodsId : goodsQna.goodsId
					, iqrContent : $("textarea[name=iqrContent]").val()
				}
				var data = $.extend($("#qnaForm").serializeJson(), addData);
				
				if(goodsQna.device == 'APP'){
					data.imgPaths = null;
				}
				
				var options = {
					url : "<spring:url value='/goods/updateGoodsQna.do' />"
					, type : "POST"
					, data : data
					, done : function(result){
						if("${view.deviceGb}" == "${frontConstants.DEVICE_GB_30}" && imgRegYn == 'Y') {
							$("input[name=goodsIqrNo]").val(result.goodsIqrNo);
							onFileUpload(result.goodsIqrNo);
						}else{
							ui.popLayer.close('popQnaMod');
							goodsQna.hiddenYn = "Y";
							goodsQna.page = null;
							goodsQna.getGoodsInquiryList();
						}
					}
				};
				ajax.call(options);
			}
		},
		deleteQna : function(goodsIqrNo){
			var options = {
				url : "<spring:url value='/goods/deleteGoodsInquiry.do' />"
				, type : "POST"
				, data : {goodsIqrNo : goodsIqrNo}
				, done : function(result){
					ui.toast('<spring:message code='front.web.view.goods.qna.delete.result.msg' />');
					goodsQna.hiddenYn = "Y";
					goodsQna.page = null;
					goodsQna.getGoodsInquiryList();
				}
			};
			ajax.call(options);
		},
		imageUpload : function(){
			if ($('li[id^="qnaImgArea_"]').length >= 5) {
				alert("파일 첨부는 최대 5개까지 가능합니다");
				return false;
			}
			// 파일 추가
			/* fileUpload.inquiry(goodsQna.resultImage); */
			fileUpload.callBack = goodsQna.resultImage;
			$("#fileUploadForm").remove();
			var html = [];
			html.push("<form name=\"fileUploadForm\" id=\"fileUploadForm\" method=\"post\" enctype=\"multipart/form-data\">");
			html.push("	<div style=\"display:none;\">");
			html.push("		<input type=\"file\" name=\"uploadFile\" id=\"uploadFile\"  accept=\"image/*\"/>");
			html.push("		<input type=\"hidden\" name=\"uploadType\" value=\"inquiry\">");
			html.push("	</div>");
			html.push("</form>");
			$("body").append(html.join(''));
			$("#uploadFile").click();
		},
		resultImage : function(file){
			var area = "";
			var count = "1";
			area = $("li[id^=qnaImgArea_]").length!=0?$("li[id^=qnaImgArea_]").last()[0]:null;
			if(area != null && area != ""){
				count = parseInt(area.id.split('_')[1])+1;
			}
			
			var html = "";
			html += "<li id=\"qnaImgArea_"+ count +"\">";
			html += "<input type=\"hidden\" name=\"imgPaths\" value=\""+file.filePath+"\"/>";
			html += "<span class=\"pic\" >";
			html += "<img class=\"img\" src=\"/common/imageView.do?filePath="+file.filePath+"\" alt=\"사진\">";
			html += "<button type=\"button\" class=\"bt del\" name=\"delImg\">삭제</button>";
			html += "</span>";
			html += "</li>";
			$("#qnaImgArea").append(html);
			
			qnaImgCheck();
		},
		appResultImage : function(result){
			imageResult = JSON.parse(result);
			var area = "";
			var count = "1";
			area = $("li[id^=qnaImgArea_]").length!=0?$("li[id^=qnaImgArea_]").last()[0]:null;
			if(area != null && area != ""){
				count = parseInt(area.id.split('_')[1])+1;
			}
			
			var html = "";
			html += "<li id=\"qnaImgArea_" + count + "\">";
			html += "<input type=\"hidden\" name=\"imgPaths\" value=\"" + imageResult.imageToBase64 + "\"/>";
			html += "<span class=\"pic\" >";
			html += "<img class=\"img\" name=\"goodsQnaImg\" id=\""+ imageResult.fileId + "\"src=\"" + imageResult.imageToBase64 + "\" alt=\""+imageResult.mediaType +"\">";
			html += "<button type=\"button\" class=\"bt del\" onclick=\"callAppFunc(\"onDeleteImage\",this);\" name=\"delImg\">삭제</button>";
			html += "</span>";
			html += "</li>";
			$("#qnaImgArea").append(html);
			
			qnaImgCheck();
		},
		appDeleteResultImage : function(result){
			var imageResult = $.parseJSON(result);
			$("#"+imageResult.fileId).parents("li").remove();

			qnaImgCheck();
		}
	}

	function delImage(btn){
		var html = '';
		if($(btn).parent().data('imgSeq') != null){
			html += "<input type=\"hidden\" name=\"delImgSeq\" value=\""+$(btn).parent().data('imgSeq')+"\">";
			$("#commentImgArea").append(html);
		}
		
		$(btn).parents('li').remove();
		
		qnaImgCheck();
	}
	
	function qnaMenu(btn){
		var dataLi = $(btn).parents('li[name=qnaListLi]');
		var goodsIqrNo = dataLi.data('goodsIqrNo');
		var btnGb = $(btn).attr('name');
		if(btnGb == 'reWriteBtn'){
			/* if(goodsQna.device == "PC"){ */
				var imgPaths = new Array();
				var imgSeqs = new Array();
				
				//$("#qnaForm input[name=goodsIqrNo]").val(goodsIqrNo);
				/* qnaImgArea
				 */ 
				if($(dataLi).find('ul[name=qnaPics] li').length > 0){
					for(var i = 0; i < $(dataLi).find('ul[name=qnaPics] li').length; i++){
						var qnaImg = $(dataLi).find('ul[name=qnaPics] li').find('img');
						imgPaths.push(qnaImg[i].src);
						imgSeqs.push($(qnaImg[i]).data('imgSeq'));
					}
				}

				var data = {
					goodsIqrNo : goodsIqrNo
					, imgPaths : imgPaths
					, imgSeqs : imgSeqs
					, iqrContent : $(dataLi).children('div').children('div[name=qnaTit]').text()
					, hiddenYn : dataLi.data('hiddenYn')
					, rplAlmRcvYn : dataLi.data('rplAlmRcvYn')
				}
				
				var options = {
					url : "<spring:url value='/goods/openGoodsQnaWritePop.do' />"
					, type : "POST"
					, dataType : "html"
					, data : data
					, done : function(result){
						//$("#popQnaMod").remove();
						//$("#goodsLayers").append(result);
						$("#goodsLayers").empty();
						$("#goodsLayers").html(result);
						updateYn = "up";
						ui.popLayer.open('popQnaMod');
						
						$(document).off("click" , ".popLayer:not(.win) .btnPopClose:not(.none)");
					}
				};
				ajax.call(options);
					
			/* }else{
				//모바일ver
				goodsQna.reWriteQna(goodsIqrNo);
			} */
			
		}else if(btnGb == 'deleteQnaBtn'){
			ui.confirm('<spring:message code='front.web.view.goods.qna.delete.confirm' />',{ // 컨펌 창 옵션들
			    ycb:function(){
					goodsQna.deleteQna(goodsIqrNo);
			    },
			    ncb:function(){
					
			    },
			    ybt:"<spring:message code='front.web.view.common.yes' />", // 기본값 "확인"
			    nbt:"<spring:message code='front.web.view.common.no' />"  // 기본값 "취소"
			});
			
			
		}
	}

	function onFileUpload(estmNo){
		callAppFunc('onFileUpload', estmNo);
	}

	function callAppFunc(funcNm, obj) {
		toNativeData.func = funcNm;
		if(funcNm == 'onOpenGallery'){ // 갤러리 열기
			// 데이터 세팅
			toNativeData.useCamera = "P";
			toNativeData.usePhotoEdit = "N";
			toNativeData.galleryType = "P"
			//미리보기 영역에 선택된 이미지가 있을 경우.------------//
			let fileIds = new Array();
			let fileIdDivs = $("img[name=goodsQnaImg]");
			fileIdDivs.each(function(i, v) {
				fileIds[i] = $(this).attr("id");
			})
			toNativeData.fileIds = fileIds;
			//---------------------------------------//
			orgImgCnt = $("span[name=orgImg]").length;
			toNativeData.maxCount = (5 - orgImgCnt) + "";
			toNativeData.callback = "goodsQna.appResultImage";
			toNativeData.callbackDelete = "goodsQna.appDeleteResultImage";
		}else if(funcNm == 'onDeleteImage'){ // 미리보기 썸네일 삭제
			// 데이터 세팅
			var fileId = $(obj).parent().find("img").attr("id");
			// 화면에서 이미지 삭제
			/* if($(obj).parent().data('imgSeq') != null){
				html += "<input type=\"hidden\" name=\"delImgSeq\" value=\""+$(obj).parent().data('imgSeq')+"\">";
				$("#qnaImgArea").append(html);
			} */
			
			$(obj).parents('li').remove();
			
			// 데이터 세팅
			toNativeData.func = "onDeleteImage";
			toNativeData.fileId = fileId;
			toNativeData.callback = "qnaImgCheck";

		}else if(funcNm == 'onFileUpload'){ // 파일 업로드
			// 데이터 세팅
			toNativeData.func = funcNm;
			toNativeData.prefixPath = "/goodsInquiry/"+obj;
			toNativeData.callback = "onFileUploadCallBack";

		}else if(funcNm == 'onClose'){ // 화면 닫기
			// 데이터 세팅
			toNativeData.func = funcNm;
		}
		// 호출
		toNative(toNativeData);
	}	

	function onFileUploadCallBack(result) {
		var file = JSON.parse(result);
		var goodsIqrNo = $("input[name=goodsIqrNo]").val();
		var imgPaths = new Array();
		/* file.images[0].filePath */
		if(file.images.length != 0){
			for(var i = 0; i < file.images.length; i++){
				imgPaths.push(file.images[i].filePath);
			}
		}
		
		var options = {
			url : "<spring:url value='/goods/appInquiryImageUpdate' />"
			, data : { goodsIqrNo : goodsIqrNo, imgPaths : imgPaths }
			, done : function(result) {
				ui.popLayer.close('popQnaMod');
				goodsQna.hiddenYn = "Y";
				goodsQna.page = null;
				ui.toast('문의 내용이 등록되었습니다.');
				goodsQna.getGoodsInquiryList();
			}
		}
		ajax.call(options);
	}
	
	
	//이미지 갯수 체크
	function qnaImgCheck(){
		if($("#qnaImgArea").children('li').length >= 5){
			$("#imgAddBtn-qna").attr('disabled', 'disabled');
			$("#imgAddBtn-qna").css('opacity', '0.5');
			$("#imgAddBtn-qna").addClass('disabled');
		}else{
			$("#imgAddBtn-qna").removeAttr('disabled');
			$("#imgAddBtn-qna").css('opacity', '');
			$("#imgAddBtn-qna").removeClass('disabled');
		}
	};
	
	/* function onDeletePreviewProfileImage */
</script>

<div class="hdts">
	<span class="tit"><em class="t">Q&amp;A</em> <i class="i" name="pdQnaCnt"><%-- ${goodsTotalCount.goodsQnaTotal} --%></i></span>
	<div class="bts"><a href="javascript:;" class="btn b btnQna" id="writeQna"><spring:message code='front.web.view.goods.qna.write.btn' /></a></div>
</div>
<div class="cdts">
	<div class="uiqnalist">
		<div class="secret" id="qnaHidden"><label class="checkbox"><input type="checkbox" id="hiddenCheck"><span class="txt"><em class="tt"><spring:message code='front.web.view.goods.qna.hidden.secret.title' /></em></span></label></div>
		<ul id="qnaList" class="uiAccd qalist" data-accd="tog">
		</ul>
		<div class="moreload" id="qnaMoreLoad">
			<button type="button" class="bt more" id="qnaMore"><spring:message code='front.web.view.goods.qna.more.btn' /></button>
		</div>
	</div>
</div>