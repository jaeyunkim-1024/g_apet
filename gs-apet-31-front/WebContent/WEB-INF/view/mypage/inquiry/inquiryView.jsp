<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ page import="front.web.config.constants.FrontWebConstants" %>

<tiles:insertDefinition name="mypage">
	<tiles:putAttribute name="script.inline">
	<script type="text/javascript" 	src="/_script/file.js"></script>
		<script type="text/javascript">
		$(window).bind("pageshow", function(event){
			if(event.originalEvent.persisted || window.performance && window.performance.navigation.type == 2){
				if(viewGb == 'qna') {
					goodsQna.getMyQnaList();
				}else {
					inquiry.myList();
				}
				window.history.replaceState(null, null, null);
			}else{
				window.history.replaceState(null, null, null);
			}
		});
		
		var toastH = 74;
		var customSwiper;
		var viewGb = '${viewGb}';
		var focusNo = '${focusNo}';
		var updateYn;
		
		/**
		 * 모바일 타이틀 수정 
		 */
		$(document).ready(function(){
			
			if("${fn:length(counselList)>0}" !=  'false'){
				$("#iqr_myAccd").css('display', "block");
			}else{
				$("#iqr_noData").css('display', "block");
			}
			
			
			focusView();
			//IOS 경우 토스트 얼럿 높이 값
			if( isIOS() ) toastH = 330;

			$(".menubar").remove();
			$(".mo-heade-tit .tit").html("고객 문의");
			$(".mo-header-backNtn").attr("onclick", 'goBack();')

			if("${view.deviceGb}" != "${frontConstants.DEVICE_GB_10}"){
				$("footer").remove()
			}
			
			setBtnTog();
			// 팝업 닫기
			$("#popLayers").on('click', '.popQnaMod .btnPopClose', function(){
				popLayerClose();
			});
			
			//이미지 삭제
			$("#popLayers").on('click', 'button[name=delImg]', function(){
				if($(this).parent().data('imgSeq') != null){
					var html = "<input type=\"hidden\" name=\"delImgSeqs\" value=\""+$(this).parent().data('imgSeq')+"\">";
					$("#qnaImgArea").append(html);
				}
				
				$(this).parents('li').remove();
				qnaImgCheck();
			});
			
			//작성하기 - 비밀글 여부 선택
			$("#popLayers").on('click', 'input[name=hiddenYnChck]', function(){
				if(this.checked){
					$("input[name=hiddenYn]").val("Y");
				}else{
					$("input[name=hiddenYn]").val("N");
				}
			});
			
			//상품 문의하기 - 답변 알림 여부 선택
			$("#popLayers").on('click', 'input[name=rplAlmRcvYnChck]', function(){
				if(this.checked){
					$("input[name=rplAlmRcvYn]").val("Y");
				}else{
					$("input[name=rplAlmRcvYn]").val("N");
				}
			});
			
			//문의 글 등록버튼 제한
			$("#popLayers").on('propertychange keyup input change paste ', 'textarea[name=iqrContent], textarea[name=content]', function(){
				var minLength = $(this).attr("name") == 'content' ? 10 : 5;
				var maxLength = $(this).attr("name") == 'content' ? 1000 : 100;
				var message = $(this).attr("name") == 'content' ? "내용은 1000자까지 입력할 수 있어요." : "<spring:message code='front.web.view.goods.input.oneHundred.check.confirm' />";
				
				if($(this).val().length < minLength){
					$("button[id=insertQna]").addClass('disabled');
				}else{
					if(maxLength == 1000 && $("#cusCtg1Cd").val() != null) {
						$("button[id=insertQna]").removeClass('disabled');
					}else if($(this).attr("name") != 'content'){
						$("button[id=insertQna]").removeClass('disabled');
					}
				}
				
				if($(this).val().length > maxLength){
					$(this).val($(this).val().substring(0, maxLength));
					ui.toast(message,{   // 토스트 창띄우기
						bot:toastH
					});
					return;
				}
			});
			
			// 1:1 문의 유형 변경
			$("#popLayers").on('change', '#cusCtg1Cd', function(){
				if($("#content").val().length > 9) {
					$("button[id=insertQna]").removeClass('disabled');
				}
			});
			
			// 문의하기 등록 및 수정
			$("#popLayers").on('click', '#insertQna', function(){
				var popId = $(this).parents("article.popQnaMod").attr("id");
				if(popId === "popQnaMod") {
					goodsQna.updateGoodsQna();
				}else {
					var cusNo = $("#inquiryForm").find("input[name=cusNo]").val();
					if(cusNo != null && cusNo != ''){
						// 문의하기 수정 TODO
						inquiry.insertInquiry(cusNo);
					}else {
						inquiry.insertInquiry();
					}
				}
			});
			
			// 뒤로가기 setView
			$("#viewGbDiv").on('click', function(){
				viewGb = $(this).children('li[class~=swiper-pagination-bullet-active]').index() == 1 ? 'inquiry' : 'qna';
				history.replaceState(null,null,'/customer/inquiry/inquiryView?viewGb='+viewGb)
			});
			
			if("${popupChk}" == "popOpen") {
				inquiryViewPop('insert');
			};
			
		}); // End Ready
		
		function goBack(){
			if("${requestScope['javax.servlet.forward.query_string']}".indexOf('home=my') > -1){
				storageHist.goBack("/mypage/indexMyPage/")
			}else{
				storageHist.getOut("${requestScope['javax.servlet.forward.servlet_path']}");
			}
		}
		
		//팝업창 닫기
		function popLayerClose(){
			var popId = $(".btnPopClose").parents("article.popQnaMod").attr("id");
			var message;
			var updateMsg;
			
			if(updateYn == "up"){
				updateMsg = "수정"
			}else if(updateYn == "in"){
				updateMsg = "작성"
			}
			
			if(popId === "popQnaMod") {
				message = '<spring:message code='front.web.view.goods.qna.update.cancel.confirm' />'
			}else{
				message = '1:1 문의 '+updateMsg+'을 취소할까요?';
			}
			
			$("body").removeClass("dim")
			ui.confirm(message,{ // 컨펌 창 옵션들
				ycb:function(){
					ui.popLayer.close(popId);
					$("#"+popId).remove();
				},
				ncb:function(){
					return false;
				},
				ybt:'<spring:message code='front.web.view.common.yes' />',
				nbt:'<spring:message code='front.web.view.common.no' />'
			});
		}
		
		
		// 랜딩 url 에 따른 focusView
		function focusView(){
			var selector = "";
			if(viewGb == 'qna') {
				selector = (focusNo != null && focusNo != '') ? "[data-goods-iqr-no='"+focusNo+"']" : null;
				$("div[class~=tabSwiper]").data('el', "1");
			}else if (viewGb == 'inquiry'){
				selector = (focusNo != null && focusNo != '') ? "[data-cus-no='"+focusNo+"']" : null;
			}
			
			if(selector != null && selector != '') {
				$(selector).children(".hBox").click();
				var offset = $(selector).children(".hBox").offset();
				$("html body div").animate({scrollTop:offset.top},300);
				return false;
			}
		}
		
		function onloadToast(callGb){
			if(callGb == 'I'){
				ui.toast("문의 내용이 등록되었어요.")
			}else if(callGb == 'U'){
				ui.toast("문의 내용이 수정되었어요.")
			}else if(callGb == 'D'){
				ui.toast('<spring:message code='front.web.view.goods.qna.delete.result.msg' />');
			}
		}
		
		// 내용이 한 줄이며 이미지 , 답변이 등록되지 않았을 시 더보기 버튼 비노출
		function setBtnTog(){
			for(var i =0 ; i< $(".hBox > .tit").length; i++){
				var content = $(".hBox > .tit").eq(i);
				var res;
				var cont = $('<div>'+content.text()+'</div>').css("display", "table")
				.css("z-index", "-1").css("position", "absolute")
				.css("font-family", content.css("font-family"))
				.css("font-size", content.css("font-size"))
				.css("font-weight", content.css("font-weight")).appendTo('body');
				res = (cont.width()>content.width());
				cont.remove();
				
				if(!res && $(".cBox").eq(i).find("img").length < 1 
						&& $(".cBox").eq(i).find(".reply").length < 1){
					$(".btnTog").eq(i).hide();
					$(".hBox:eq("+i+")" ).parent("li[name=inquiryNm]").removeClass("open");
				}
			}
		}
		function isIOS(){	
			var mobileKeyWords = new Array('iPhone', 'iPod');
			for (var word in mobileKeyWords) {
				if (navigator.userAgent.match(mobileKeyWords[word]) != null) {
					return true;
				}
			}
			return false;
		}
		
		function pushUrl(){
			var params = new URLSearchParams(location.search);
			var searchParams = params.toString();
			var goUrl = window.location.pathname + "?"+searchParams;
			window.history.replaceState( null , null, goUrl);
		}
		
		// 1:1 문의하기 팝업
		function inquiryViewPop(btnGb, btn) {
			var data = {};
			if(btnGb == 'update') {
				var dataLi = $(btn).parents('li[name=inquiryNm]');
				var phyPaths = new Array();
				var seqs = new Array();
					
				if($(dataLi).find('ul[name=inquiryPics] li').length > 0){
					for(var i = 0; i < $(dataLi).find('ul[name=inquiryPics] li').length; i++){
						var qnaImg = $(dataLi).find('ul[name=inquiryPics] li').find('img');
						phyPaths.push(qnaImg[i].src);
						seqs.push($(qnaImg[i]).data('imgSeq'));
					}
				}
				
				$.extend(data, {
					cusNo : dataLi.data('cusNo')
					, cusCtg1Cd : dataLi.data('cusCtg1Cd')
					, phyPaths : phyPaths
					, seqs : seqs
					, content : $(dataLi).children('div').children('div[name=inquiryTit]').data('content')
					, pstAgrYn : dataLi.data('pstAgrYn')
					, flNo : dataLi.data('cusDelflno')
				});
			}
			var options = {
				url : "<spring:url value='/customer/inquiry/inquiryViewPop.do' />"
				, type : "POST"
				, dataType : "html"
				, data : data
				, done : function(result){
					$("#popLayers").empty();
					$("#popLayers").html(result);
					ui.popLayer.open('popInquiryMod',{ // 콜백사용법
						ocb:function(){
							ui.popSelect.set();
							if(btnGb === 'insert') {
								updateYn = "in";
								$(".btSel").text("유형을 선택해주세요.");
								$(".btSel ").removeClass('open');
								$("#cusCtg1Cd").val("");
								$("#content").val("");
								$(".addfile-list").empty();
							}
							else if (btnGb ==='update'){
								updateYn = "up";
								$("button[id=insertQna]").text("수정");
							}
						},
						ccb:function(){
							
						}
					});
				}
			};
			ajax.call(options);
		}
		
		$(function(){
			/* 버튼 클릭 시  */
			$(".btn").click(function(){
				ui.selAc.open('.acSelect');
			});
		});
		
		// 상품 문의하기 
		var goodsQna = {
			mbrNo : '${session.mbrNo}',
 			totalCount : null,
			device : '${view.deviceGb}',
			getMyQnaList : function(callGb){
				var options = {
					url : "<spring:url value='/customer/inquiry/getMyQnaList.do' />"
					, type : "POST"
					, data : {
						eqrrMbrNo : goodsQna.mbrNo
					}
					, dataType : "html"
					, done : function(result){
						$('#divQna').empty();
						$('#divQna').html(result);
						if(goodsQna.totalCount == 0) {
							$("#divQna").attr('class','no_data i1');
						}
						setBtnTog();
						$("#qnaCount").text(goodsQna.totalCount+"건");
						if(callGb != undefined && callGb != null) {
							onloadToast(callGb);
						}
						pushUrl();
					}
				};
				ajax.call(options);
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
						iqrContent : $("textarea[name=iqrContent]").val()
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
								callAppFunc('onFileUpload', result.goodsIqrNo);
							}else{
								ui.popLayer.close('popQnaMod');
								goodsQna.getMyQnaList('U');
							}
						}
					};
					ajax.call(options);
				}
			},
			deleteQna : function(goodsIqrNo, btn){
				var options = {
					url : "<spring:url value='/goods/deleteGoodsInquiry.do' />"
					, type : "POST"
					, data : {goodsIqrNo : goodsIqrNo}
					, done : function(result){
						// 토스트 창띄우기
						ui.toast('<spring:message code='front.web.view.goods.qna.delete.result.msg' />',{
							cls:'abcd', // null , string
							bot:74,  // 바닥에서 띄울 간격
							sec:2000 // 사라질 시간 number
						});
						goodsQna.getMyQnaList('D');
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
				html.push("	<input type=\"file\" name=\"uploadFile\" id=\"uploadFile\"  accept=\"image/*\"/>");
				html.push("	<input type=\"hidden\" name=\"uploadType\" value=\"inquiry\">");
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
				html += "<input type=\"hidden\" name=\"fileName\" value=\""+file.fileName+"\"/>";
				html += "<input type=\"hidden\" name=\"fileSize\" value=\""+file.fileSize+"\"/>";
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
		
		var inquiry = {
			cusNo : null,
			flNo : null,
			totalCount : null,
			myList : function(callGb){
				var options = {
					url : "<spring:url value='/customer/inquiry/getMyIqrList.do' />"
					, type : "POST"
					, data : {
						eqrrMbrNo : '${session.mbrNo}',
					}
					, dataType : "html"
					, done : function(result){
						$("body").removeClass("dim")
						
						$('#uiIqr').empty();
						$('#uiIqr').html(result);
						
						if(inquiry.totalCount > 0){
							$("#iqr_noData").css('display', "none");
							$("#iqr_myAccd").css('display', "block");
						}else{
							$("#iqr_noData").css('display', "block");
							$("#iqr_myAccd").css('display', "none");
						}
						
						setBtnTog();
						$("#iqrCount").text(inquiry.totalCount+"건");
						if(callGb != undefined && callGb != null) {
							onloadToast(callGb);
						}
						pushUrl();
					}
				};
				ajax.call(options);
			},
			insertInquiry : function(cusNo) {
				var imgLength = $(".addfile-list li input[name=imgPaths]").length;
				var imgDatas = $(".addfile-list li");
				var content = $("#content").val();
				var cusCtg1Cd = $("#cusCtg1Cd").val();
				
				var delImgSeqs = $("[name=delImgSeqs]").length;
				var delLen = new Array();
				
				if(delImgSeqs > 0) {
					for(var i = 0; i < delImgSeqs; i++) {
						delLen.push($("[name=delImgSeqs]").eq(i).val())
					}
				}
				
				var pstAgrYn 
				var orgFlNms = new Array();
				var phyPaths = new Array();
				var flSzs = new Array();
				
				if(!cusCtg1Cd){
					ui.alert("문의 유형을 선택해주세요.")
					return false;
				}
				
				if(!content){
					ui.alert("문의 내용을 작성해주세요.")
					return false;
				}
				
				if(content.length < 10){
					ui.alert("내용을 10자 이상 입력해주세요.");
					return false;
				}
				
				if("${view.deviceGb}" != "APP") {
					if(imgLength > 0) {
						for(var i = 0; i < imgLength; i++) {
							orgFlNms[i] = imgDatas.find('input[name=fileName]').eq(i).val();
							phyPaths[i] = imgDatas.find('input[name=imgPaths]').eq(i).val();
							flSzs[i] = imgDatas.find('input[name=fileSize]').eq(i).val();
						}
						
					}
				}
				
				if($("input[name=pstAgrYn]").prop("checked")) {
					pstAgrYn = "Y"
				} else {
					pstAgrYn = "N"
				}
				
				inquiry.flNo = $("input[name=delFlNo]").val();
				
				var options = {
						url : "/customer/inquiry/inquiryInsert" ,
						data : {
							cusNo : cusNo,
							cusCtg1Cd : $("#cusCtg1Cd option:selected").val(),
							content : $("#content").val(),
							pstAgrYn : pstAgrYn,
							orgFlNms : orgFlNms,
							phyPaths : phyPaths, 
							flSzs : flSzs
							,flNo : inquiry.flNo
							,delLen : delLen
						}, 
						done : function(result) {
							inquiry.cusNo = result.cusNo;
							
							if(result.flNo != null && result.flNo != undefined) {
								inquiry.flNo = result.flNo;
							}
							
							if("${view.deviceGb}" != "APP" || imgLength == 0){
								ui.popLayer.close('popInquiryMod');
								if(cusNo != undefined){
									inquiry.myList("U")
								}else{
									inquiry.myList("I")
								}
							} else {
								callAppFuncInquiry('onFileUpload', inquiry.cusNo);
							}
						}
				};
				ajax.call(options);
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
				html += "<li id=\"qnaImgArea_"+ count +"\">";
				html += "	<input type=\"hidden\" name=\"imgPaths\" value=\""+imageResult.imageToBase64+"\"/>";
				html += "	<span class=\"pic\">";
				html += "		<img class=\"img\" name=\"inquiryImg\" id=\"" + imageResult.fileId + "\" src=\"" + imageResult.imageToBase64 + "\" alt=\"사진\">";
				html += "		<button type=\"button\" onclick=\"callAppFuncInquiry(\"onDeleteImage\",this);\" class=\"bt del\" name=\"delImg\" >삭제</button>";
				html += "	</span>";
				html += "</li>";
				$(".addfile-list").append(html);
			},
			appDeleteResultImage : function(resultJson){
				var imageResult = $.parseJSON(resultJson);
				$("#"+imageResult.fileId).parents("li").remove();
				qnaImgCheck();
			}
		}
		
		//1:1 상담 문의 취소
		function deleteInquiry(cusNo, obj) {
			 var options = {
				url : "/customer/inquiry/inquiryCancel" ,
				data : {
					cusNo : cusNo
				}, 
				done : function(result) {
					inquiry.myList("D")
				}
			};
			ui.confirm("문의글을 삭제할까요?" , {
				ycb : function(){
					ajax.call(options);
				}
				, ybt : "예"
				, nbt : "아니요"
			})
		}

		function qnaMenu(btn){
			var dataLi = $(btn).parents('li[name=qnaListLi]');
			var goodsIqrNo = dataLi.data('goodsIqrNo');
			var btnGb = $(btn).attr('name');
			if(btnGb == 'reWriteBtn'){
				var imgPaths = new Array();
				var imgSeqs = new Array();
				
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
						$("#popLayers").empty();
						$("#popLayers").html(result);
						$("#insertQna").text("수정")
						$(".btnSet").children(".d").attr('onclick', 'popLayerClose();');
						ui.popLayer.open('popQnaMod');
					}
				};
				ajax.call(options);
			}else if(btnGb == 'deleteQnaBtn'){
				ui.confirm('게시물을 삭제하시겠습니까? 삭제된 게시물은 복구되지 않습니다.',{ // 컨펌 창 옵션들
					ycb:function(){
						goodsQna.deleteQna(goodsIqrNo, btn);
					},
					ncb:function(){
						
					},
					ybt:"확인", // 기본값 "확인"
					nbt:"취소"  // 기본값 "취소"
				});
				
				
			}
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
		
		// 1::1 문의 하기 앱
		function callAppFuncInquiry(funcNm, obj) {
			toNativeData.func = funcNm;
			if(funcNm == 'onOpenGallery'){ // 갤러리 열기
				// 데이터 세팅
				toNativeData.useCamera = "P";
				toNativeData.galleryType = "P"
				toNativeData.usePhotoEdit = "N";
				//미리보기 영역에 선택된 이미지가 있을 경우.------------//
				let fileIds = new Array();
				let fileIdDivs = $("img[name=inquiryImg]");
				fileIdDivs.each(function(i, v) {
					fileIds[i] = $(this).attr("id");
				})
				toNativeData.fileIds = fileIds;
				//---------------------------------------//
				toNativeData.maxCount = "5";
				/* toNativeData.previewWidth = 188;
				toNativeData.previewHeight = 250; */
				toNativeData.callback = "inquiry.appResultImage";
				toNativeData.callbackDelete = "inquiry.appDeleteResultImage";
			}else if(funcNm == 'onDeleteImage'){ // 미리보기 썸네일 삭제
				// 데이터 세팅
				var fileId = $(obj).parent().find("img").attr("id");
				// 화면에서 이미지 삭제
				/* if($(obj).parent().data('imgSeq') != null){
					html += "<input type=\"hidden\" name=\"delImgSeq\" value=\""+$(obj).parent().data('imgSeq')+"\">";
					$(".addfile-list").append(html);
				} */
				
				$(obj).parents('li').remove();
				
				// 데이터 세팅
				toNativeData.func = "onDeleteImage";
				toNativeData.fileId = fileId;
				toNativeData.callback = "qnaImgCheck";

			}else if(funcNm == 'onFileUpload'){ // 파일 업로드
				// 데이터 세팅
				toNativeData.func = funcNm;
				toNativeData.prefixPath = "/counsel/"+obj;
				toNativeData.callback = "onFileUploadCallBackInquiry";

			}else if(funcNm == 'onClose'){ // 화면 닫기
				// 데이터 세팅
				toNativeData.func = funcNm;

			}
			// 호출
			toNative(toNativeData);
		}
		// 
		function onFileUploadCallBackInquiry(result) {
			var file = JSON.parse(result);
			var cusNo = inquiry.cusNo;
			var flNo = inquiry.flNo;
			var phyPaths = new Array();
			var orgFlNms = new Array();
			/* file.images[0].filePath */
			if(file.images.length != 0){
				for(var i = 0; i < file.images.length; i++){
					phyPaths.push(file.images[i].filePath);
					orgFlNms.push(file.images[i].fileName);
				}
			}
			
			var options = {
				url : "<spring:url value='/customer/inquiry/appInquiryImageUpdate' />"
				, data : { cusNo : cusNo,  flNo : flNo, phyPaths : phyPaths, orgFlNms : orgFlNms }
				, done : function(result) {
					ui.popLayer.close('popInquiryMod');
					inquiry.myList("U")
// 					location.href = "/customer/inquiry/inquiryView?insertYn=I";
				}
			}
			ajax.call(options);
		}
		
		// 상품문의 APP
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
					goodsQna.getMyQnaList('U');
				}
			}
			ajax.call(options);
		}
		
		//이미지 팝업창
		function detailInquiryImgPop(clickImg) {
			 var clickImgPath = clickImg.src;
				var imgs = $(clickImg).parents('.pics').find('img');
				var selectIndex = imgs.index(clickImg);
				var index = selectIndex + 1;
				
				var bigHtml = '';
				var thumbHtml = '';
				for(var i = 0; i < imgs.length; i++){
					var imgPath = imgs[i].src;
					bigHtml += "<li class=\"swiper-slide\">"
					bigHtml += "<div class=\"box swiper-zoom-container\">"
					bigHtml += "<span class=\"pic\">"
					bigHtml += "<img class=\"img\" src=\""+imgPath+"\" alt=\"\">"
					bigHtml += "</span></div></li>"
					
					thumbHtml += "<li class=\"swiper-slide\">"
					thumbHtml += "<a href=\"javascript:;\" class=\"box\">"
					thumbHtml += "<span class=\"pic\">"
					thumbHtml += "<img class=\"img\" src=\""+imgPath+"\" alt=\"\">"
					thumbHtml += "</span></a></li>"
				}
				$("#bigImgArea").html(bigHtml);
				$("#thumbImgArea").html(thumbHtml);
				
				ui.popLayer.open('popPdImgView');
				$(".pdDtThmSld2 .slide>li:nth-child("+ index +")").addClass("active");
				
				//작은사이즈
				var galleryThumbs = new Swiper(".pdDtThmSld2 .swiper-container", {
					observer: true,
					observeParents: true,
					watchOverflow:true,
					spaceBetween: 10,
					slidesPerView: "auto",
					freeMode: true,
					navigation: {
						nextEl: '.pdDtThmSld2 .sld-nav .bt.next',
						prevEl: '.pdDtThmSld2 .sld-nav .bt.prev',
					},
				});
				//큰사이즈
				var galleryTop = new Swiper('.pdDtPicSld2 .swiper-container', {
					observer: true,
					observeParents: true,
					spaceBetween:20,
					thumbs: {
						swiper: galleryThumbs
					},
					initialSlide :selectIndex
					,	on : {
						slideChangeTransitionEnd : function(swiper){
							index = this.realIndex + 1;
							$(".pdDtThmSld2 .slide>li:nth-child("+ index +")").addClass("active").siblings("li").removeClass("active");;
						},
					},
				});
				
		 }
		 
		</script>
	</tiles:putAttribute>
	<tiles:putAttribute name="content">
		<!-- 바디 - 여기위로 템플릿 -->
		<main class="container lnb page my" id="container">
			<!-- 페이지 헤더 -->
			
			<!-- // 페이지 헤더 -->
			<div class="inr">
				<!-- 본문 -->
				<div class="contents" id="contents">
					<!-- 1:1 문의하기  -->
					<!-- PC 타이틀 모바일에서 제거 -->
					<div class="pc-tit">
						<h2>고객 문의</h2>
					</div>
					<script>
						var tabName = ['1:1 문의', '상품 Q&A'];	//tab 이름
					</script>
					<div class="swiper-container tabSwiper custmHelp">
						<!-- Add Pagination -->
						<div class="swiper-pagination" id="viewGbDiv">
						</div>
						
						<div class="swiper-wrapper">
							<!-- 탭컨텐츠1 -->
							<div class="swiper-slide">
								<div class="infoBox flex">
									<span class="listCount">총 <strong class="b" id="iqrCount">${fn:length(counselList)}건</strong></span>
									<button type="button" class="btn b mlA btn_inquiry" onclick="inquiryViewPop('insert');">문의하기</button>
								</div>
								<div class="my-accd s0420" id="iqr_myAccd" style="display:none;">	<!-- 보여야 하는 객체에 display:block; 지정해 주세요. -->
									<div class="uiqnalist">
										<ul class="uiAccd qalist" data-accd="accd" id="uiIqr">
											<jsp:include page="/WEB-INF/view/mypage/inquiry/include/includeMyInquriyList.jsp" />
										</ul>
									</div>
								</div>
								<div class="no_data i1" id="iqr_noData" style="display:none;">
									<div class="inr">
										<div class="msg">등록된 문의글이 없습니다.</div>
									</div>
								</div>
							</div>
							
							<!-- 탭컨텐츠2 -->
							<div class="swiper-slide">
								<div class="infoBox flex">
									<span class="listCount">총 <strong class="b" id="qnaCount">${fn:length(myQnaList)}건</strong></span>
								</div>
								<div class="${myQnaList != null and fn:length(myQnaList)>0 ? 'my-accd s0420' : 'no_data i1'}"  style="display:block;" id="divQna">
									<jsp:include page="/WEB-INF/view/mypage/inquiry/include/includeMyQnaList.jsp" />
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</main>
		
		<c:if test="${view.deviceGb eq frontConstants.DEVICE_GB_10}">
			<jsp:include page="/WEB-INF/tiles/include/floating.jsp">
				<jsp:param name="floating" value="talk" />
			</jsp:include>
		 </c:if>
	</tiles:putAttribute>
</tiles:insertDefinition>

<!-- 팝업레이어 A 전체 덮는크기 -->
<div id="popLayers">
</div>

<jsp:include page="/WEB-INF/view/mypage/inquiry/inquiryImgPop.jsp" />
