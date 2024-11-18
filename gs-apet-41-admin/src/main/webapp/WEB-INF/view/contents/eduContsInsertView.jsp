<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<jsp:include page="/WEB-INF/view/contents/include/eduContsTipQnAPreview.jsp"></jsp:include>
		<script type="text/javascript">
			$(document).ready(function(){
				// 빈 상품 그리드 그리기
				createEduContsGoodsGrid();
 			});
			
			/*
			*	내용 변경 여부 
			*/			
			var isWritten = false; // true : 변경됨, false : 변경없음
			var isIntro = false; // true : 교육Intro, false : 교육
			$(document).on("change", "#eduContsInsertForm tr:not(#cateArea) :input",function() { 
				isWritten = true;
			});
			
			
			/*
			*	카테고리 컨트롤 
			*/ 
			function eduCateInsert(obj){
				if($(obj).val() != ""){
					$(obj).next().attr("disabled", false);
					$(obj).next().removeClass('readonly');
					if($("#eudContsCtgLCd").val() == "${adminConstants.EUD_CONTS_CTG_L_20}"){
						$("#eudContsCtgLCd").nextAll().val("");
						$("#eudContsCtgLCd").nextAll().attr("disabled", true);	
						$("#eudContsCtgLCd").nextAll().addClass('readonly');
					}
				} else {
					$(obj).nextAll().val("");
					$(obj).nextAll().attr("disabled", true);	
					$(obj).nextAll().addClass('readonly');
				}
				if(obj.id == "eudContsCtgLCd" && !isIntro && $("#eudContsCtgLCd").val() == "${adminConstants.EUD_CONTS_CTG_L_20}"){ // eudContsCtgLCd가 교육에서 교육intro로 변경될 경우
					if(isWritten){	// 작성중 내용 여부 확인
						messager.confirm('작성중인 내용이 있습니다. 변경하시겠습니까?"',function(r){ 
							if(r){	 // 작성중 내용 초기화 및 교육Itro 화면							
								$(".introY").show();
								$(".introN").hide();
								$("#introNArea").empty();
								setDefault();
								isIntro = true;
							}else{	// select 교육으로 복원						
								$("#eudContsCtgLCd").val("${adminConstants.EUD_CONTS_CTG_L_10}");							
							}
						});
					}else{ // 교육Itro 화면	
						$(".introY").show();
						$(".introN").hide();
						$("#introNArea").empty();
						isIntro = true;
					}
				}else if(obj.id == "eudContsCtgLCd" && isIntro && $("#eudContsCtgLCd").val() != "${adminConstants.EUD_CONTS_CTG_L_20}"){ // eudContsCtgLCd가 교육intro에서 교육으로 변경될 경우
					if(isWritten){	// 작성중 내용 여부 확인
						messager.confirm('작성중인 내용이 있습니다. 변경하시겠습니까?"',function(r){ 
							if(r){	 // 작성중 내용 초기화 및 교육 화면	
								$(".introN").show();
								$(".introY").hide();
								ajax.load("introNArea","/contents/eduContsIntroN.do",null);
								setDefault();
								isIntro = false;
							}else{	// selet 교육 Intro 복원					
								$("#eudContsCtgLCd").val("${adminConstants.EUD_CONTS_CTG_L_20}");				
							}
						});
					}else{	 // 교육 화면
						$(".introN").show();
						$(".introY").hide();
						ajax.load("introNArea","/contents/eduContsIntroN.do",null);
						isIntro = false;
					}
				}
			}
			function setDefault() {	// 카테고리 변경에따른 데이터 초기화
				let petGbCd = $("#petGbCd").val();
				let eudContsCtgLCd = $("#eudContsCtgLCd").val();
				$("#eduContsInsertForm")[0].reset();
				$("#eduContsInsertForm input:hidden").val('');
				$("#bnrPcPathView, #bnrLPathView, #bnrSPathView, #webToonPathView, #thumbImgPathView").attr("src", '/images/noimage.png' );
				$("#petGbCd").val(petGbCd);
				$("#eudContsCtgLCd").val(eudContsCtgLCd);
				$(".msgByte").html("0");
				isWritten = false;
			}
			
			/*
			*  썸네일 자동, 수동 이벤트
			*/
			$(document).on("change", "input[name=thumAutoYn]", function(e) {
				$("input[name=thumbImgPath]").val('');
				$("input[name=thumbImgSize]").val('');
				$("input[name=thumbImgOrgFlNm]").val('');
				$("#thumbImgPathView").attr("src", '/images/noimage.png' );
				if ($(this).val() == '${adminConstants.THUM_AUTO_YN_Y}') {
					$("#thmBtn").attr('disabled', 'true');
					if($("input[name=thumbImgPathDone]").val() != ''){
						$("input[name=thumbImgPath]").val($("input[name=thumbImgPathDone]").val());
						$("input[name=thumbImgSize]").val('');
						$("input[name=thumbImgOrgFlNm]").val($("input[name=thumbImgOrgFlNmDone]").val());
						$("#thumbImgPathView").attr("src", $("input[name=thumbImgPathDone]").val());
					}
				} else {					
					$("#thmBtn").removeAttr('disabled');
				}
			});
			
			/*
			*	이미지 업로드 결과 
			*/
			function resultImage(type) {
				if(type == "bannerPc"){
					fileUpload.image(function(file) {
						$("input[name=bnrPcPath]").val(file.filePath);
						$("input[name=bnrPcSize]").val(file.fileSize);
						$("input[name=bnrPcOrgFlNm]").val(file.fileName);
						$("#bnrPcPathView").attr("src", '/common/imageView.do?filePath=' + file.filePath );
						isWritten = true;
					});
				}else if(type == "bannerL"){
					fileUpload.image(function(file) {
						$("input[name=bnrLPath]").val(file.filePath);
						$("input[name=bnrLSize]").val(file.fileSize);
						$("input[name=bnrLOrgFlNm]").val(file.fileName);
						$("#bnrLPathView").attr("src", '/common/imageView.do?filePath=' + file.filePath );
						isWritten = true;
					});
				}else if(type == "bannerS"){
					fileUpload.image(function(file) {
						$("input[name=bnrSPath]").val(file.filePath);
						$("input[name=bnrSSize]").val(file.fileSize);
						$("input[name=bnrSOrgFlNm]").val(file.fileName);
						$("#bnrSPathView").attr("src", '/common/imageView.do?filePath=' + file.filePath );
						isWritten = true;
					});
				}else if(type == "webToon"){
					fileUpload.image(function(file) {
						$("input[name=webToonPath]").val(file.filePath);
						$("input[name=webToonSize]").val(file.fileSize);
						$("input[name=webToonOrgFlNm]").val(file.fileName);
						$("#webToonFlBtn").text("변경");
						$("#webToonFlNmArea").text(file.fileName);
						$("#showWebtoonBtn").show();
						isWritten = true;
					});
				}else if(type == "thumb"){
					fileUpload.image(function(file) {
						$("input[name=thumbImgPath]").val(file.filePath);
						$("input[name=thumbImgSize]").val(file.fileSize);
						$("input[name=thumbImgOrgFlNm]").val(file.fileName);
						$("#thumbImgPathView").attr("src", '/common/imageView.do?filePath=' + file.filePath );
						isWritten = true;
					});
				}				
			}
			
			/*
			*	웹툰 새창 열기			
			*/
			function showWebtoon(){
    			window.open(location.protocol + '//<spring:eval expression="@webConfig['site.domain']" />/common/imageView.do?filePath='+$("input[name=webToonPath]").val()); 
			}
			
			/*
			*	영상 업로드 결과
			*/		
			function resultVod (result, obj) {
				let thisObjName = $(obj).attr("name");
				var gb;
				if(thisObjName == "vodUploadFile"){
					gb = "vod";
				}else{
					gb = "step";
				}
				$(obj).parents("td").find("input[name="+gb+"Size]").val("");
				$(obj).parents("td").find("input[name="+gb+"VdLnth]").val("");
				$(obj).parents("td").find("input[name="+gb+"Path]").val(result.content[0].download_url);
				$(obj).parents("td").find("input[name="+gb+"OutsideVdId]").val(result.content[0].video_id);
				$(obj).parents("td").find("input[name="+gb+"OutsideVdId]").data("encodedyn","");
				$(obj).parents("td").find("input[name="+gb+"OrgFlNm]").val(obj.files[0].name);
				$(obj).parents("td").find(".chkEncodingBtn").attr('disabled', false);
				
				// 썸네일 결과 적용
				console.log("확인",$(obj).hasClass('cmpltStep') );
				if($(obj).hasClass('cmpltStep')){
					$("input[name=thumbImgPathDone]").val(result.content[0].thumb_url);
					$("input[name=thumbImgSizeDone]").val('');
					$("input[name=thumbImgOrgFlNmDone]").val(result.content[0].video_id + '.png');
					$("input[name=thumbDownloadUrl]").val(result.content[0].thumb_download_url);
					if ( $("input:radio[name=thumAutoYn]:checked").val() == '${adminConstants.THUM_AUTO_YN_Y}' ) {
						$("input[name=thumbImgPath]").val(result.content[0].thumb_url);
						$("input[name=thumbImgSize]").val('');
						$("input[name=thumbImgOrgFlNm]").val(result.content[0].video_id + '.png');
						$("#thumbImgPathView").attr('src', result.content[0].thumb_url);
					}
				}
				isWritten = true;
			}
			
			/*
			*	영상 업로드후 인코딩 결과 확인			
			*/
			function chkEncoding(obj) {
				let sgrAk = sgrGenerate();
				let videoId;
				if($(obj).hasClass("step")){
					videoId = $(obj).parent().find("input[name=stepOutsideVdId]").val();
				}else{
					videoId = $(obj).parent().find("input[name=vodOutsideVdId]").val();
				}
				var option = {
						authKey : sgrAk
						, video_id : videoId
				}
				vodInfo(option, function(result){
					var gb;
					if($(obj).hasClass("step")){
						gb = "step";
					}else{
						gb = "vod";
					}
					if (result.contents[0].encoding_state == '${adminConstants.SGR_RESULT_ENCODING_STATE_SUCCESS}'){
						$(obj).parent().find("input[name="+gb+"Size]").val(parseInt(result.contents[0].filesize));
						$(obj).parent().find("input[name="+gb+"VdLnth]").val(result.contents[0].duration);
						$(obj).parent().find("input[name="+gb+"OutsideVdId]").data("encodedyn","Y");
						// 인트로 썸네일 자동 저장
						if(gb == "vod"){
							$("input[name=thumbImgPath]").val(result.contents[0].thumb_url);
							$("input[name=thumbImgSize]").val('');
							$("input[name=thumbImgOrgFlNm]").val(result.contents[0].video_id + '.png');
						}
						messager.alert("<spring:message code='admin.web.view.common.normal_process.final_msg' />", "Info", "info");
					} else if (result.contents[0].encoding_state == '${adminConstants.SGR_RESULT_ENCODING_STATE_FAILED}') {
						$(obj).parent().find("input[name="+gb+"Path]").val("");
						$(obj).parent().find("input[name="+gb+"Size]").val("");
						$(obj).parent().find("input[name="+gb+"OutsideVdId]").val("");
						$(obj).parent().find("input[name="+gb+"VdLnth]").val("");
						$(obj).parent().find("input[name="+gb+"OrgFlNm]").val("");
						$(obj).attr('disabled', true);
						// 인트로 썸네일 자동 저장
						if(gb == "vod"){
							$("input[name=thumbImgPath]").val('');
							$("input[name=thumbImgSize]").val('');
							$("input[name=thumbImgOrgFlNm]").val('');
						}
						messager.alert("<spring:message code='admin.web.view.msg.vod.upload.encoding_failed' />", "Error", "error");
					} else {
						messager.alert("<spring:message code='admin.web.view.msg.vod.upload.encoding_processing' />", "Info", "info");
					}
				});
			}
			
			
			/* 
			*	태그 
			*/
			// 태그 삭제
			function deleteTag(tagNo) {
				$("#"+ tagNo).remove();
				$("#"+ tagNo + "Delete").remove();
				$("#"+ tagNo + "Input").remove();
			}
			// 태그 추가
			function addTag() {
				let options = {
					multiselect : true
					, callBack : function(tags) {
						if(tags != null) {
							let sTag = $(".selectTag");
							let sTags = new Array();
							sTag.each(function(i, v){
								if (sTags.indexOf(v.id) === -1) {
									sTags.push(v.id);
								}
							})
							//let message = new Array();
							let message = '';
							let msgCheck = true;
							let cnt = -1;
							for(let tg in tags){
								let check = true;

								// 새로 추가할 태그가 현재 태그와 겹치는지 확인
								for(let cg in sTags) {
									if(tags[tg].tagNo == sTags[cg]) {
										if (msgCheck) {
											//message.push("'" + tags[tg].tagNm + "'" + "<spring:message code='admin.web.view.msg.vod.dupl.tag' />");
											message += "'" + tags[tg].tagNm + "'";
										}
										msgCheck = false;
										check = false;
										cnt ++;
									}
								}
								if(check) {
									let html = '<span class="rcorners1 selectTag" tag-nm="' + tags[tg].tagNm +'" id="' + tags[tg].tagNo + '">' + tags[tg].tagNm + '</span>' 
									+ '<img id="' + tags[tg].tagNo + 'Delete" onclick="deleteTag(\'' + tags[tg].tagNo + '\')" class="tagDeleteBtn" src="/images/icon-header-close.svg" />';
									html +='<input type="hidden" id="' + tags[tg].tagNo + 'Input" name="tagNo" value="'+tags[tg].tagNo+'">';
									$("#vTags").append (html);
								}
							}
							if(message != null && message.length > 0) {
								if (cnt == 0) {
									message += "<spring:message code='admin.web.view.msg.vod.dupl.tag' />";
								} else {
									message += " 외 " + cnt + "건 " + "<spring:message code='admin.web.view.msg.vod.dupl.tag' />";
								}
								messager.alert(message, "Info", "info");
							}
						}
					}
				}
				layerTagBaseList.create(options);
			}
			
			/* 
			*	상품 연동
			*/
			// 상품 연동 grid
			function createEduContsGoodsGrid(){
				let options = {
					height : 400
					, datatype : 'local'
					, colModels : [
						/* 상품 번호 hidden */
						{name:"goodsId", hidden:true}
						/* 썸네일 이미지 */
						, {name:"imgPath", label:'<spring:message code="column.thum" />', width:"220", align:"center", sortable:false, formatter: function(cellvalue, options, rowObject) {
								var imgPath = rowObject.imgPath.indexOf('cdn.ntruss.com') > -1 ? rowObject.imgPath : '${frame:optImagePath("' + rowObject.imgPath + '", adminConstants.IMG_OPT_QRY_400)}';
								return '<img src='+imgPath+' style="width:100px; height:100px;" onError="this.src=\'/images/noimage.png\'"  />';
							}
						}
						/* 상품 명 */
						, {name:'goodsNm', label:'<spring:message code="column.display_view.goods_nm" />', width:'500', align:'center', classes:'pointer', sortable:false }
						/* 상품 ID */
						, {name:"goodsId", label:_GOODS_SEARCH_GRID_LABEL.goodsId, width:"250", align:"center", classes:'cursor_default', sortable:false}
						/* 상품 상태 */
						, {name:'goodsStatCd', label:'<spring:message code="column.goods_stat_cd" />', width:'200', align:'center', classes:'cursor_default', sortable:false, formatter:'select', editoptions:{value:"<frame:gridSelect grpCd='${adminConstants.GOODS_STAT }' showValue='false' />" } }
						/* 삭제 버튼 */
						, {name:"button", label:'<spring:message code="column.common.delete"/>', width:"200", align:"center", sortable:false, formatter: function(rowId, val, rawObject, cm) {
							let str = '<button type="button" onclick="fnGoodsDelete(\'' + rawObject.goodsId + '\')" class="roundBtn">- 삭제</button>';
							return str;
						}}
						]
					, paging : false
					, onCellSelect : function (id, cellidx, cellvalue) {
						if(cellidx == 2) {
							let goodsId = $('#eduContsGoodsList').jqGrid ('getCell', id, 'goodsId');
							addTab('상품 상세 - ' + goodsId, "/goods/goodsDetailView.do?goodsId=" + goodsId);
						}
					}
				};
				grid.create("eduContsGoodsList", options);
			}
			
			// 연동상품 삭제
			function fnGoodsDelete(goodsId) { 
				$("#eduContsGoodsList").delRowData(goodsId);
			}
			
			// 상품 추가
			function addGoods() {
				let sTag = $(".selectTag");
				if (sTag.length > 0) {
					let sTags = new Array();
					sTag.each(function(i, v){
						if (sTags.indexOf(v.id) === -1) {
							sTags.push(v.id);
						}
					})
					let options = {
						multiselect : true
						, stId : 1
						, goodsStatCd : '${adminConstants.GOODS_STAT_40 }'
						, tags : sTags
						, callBack : function(goods) {
							if(goods != null) {
								let vodGoods = $('#eduContsGoodsList').getDataIDs();
								//let message = new Array();
								let message = '';
								let msgCheck = true;
								let cnt = -1;
								for(let vg in goods){
									let check = true;

									// 새로 추가할 상품이 현재 연동 상품과 겹치는지 확인
									for(let cg in vodGoods) {
										if(goods[vg].goodsId == vodGoods[cg]) {
											if (msgCheck) {
												//message.push(goods[vg].goodsNm + "<spring:message code='admin.web.view.msg.common.dupl.goods' />");
												message += "'" + goods[vg].goodsNm + "'";
											}
											msgCheck = false;
											check = false;
											cnt ++;
										}
									}

									if(check) {
										$("#eduContsGoodsList").jqGrid('addRowData', goods[vg].goodsId, goods[vg], 'last', null);
									} 
								}

								if(message != null && message.length > 0) {
									if (cnt == 0) {
										message += "<spring:message code='admin.web.view.msg.vod.dupl.goods' />";
									} else {
										message += " 외 " + cnt + "건 " + "<spring:message code='admin.web.view.msg.vod.dupl.goods' />";
									}
									messager.alert(message, "Info", "info");
								}
							}
						}
					}
					layerGoodsList.create(options);
					
				} else {
					messager.alert('<spring:message code="admin.web.view.msg.vod.valid.nonTag" />', "Info", "info");
					return;
				}
			}
			
			/* 
			*	글자수 확인 
			*/
			$(document).on("keyup input", ".msg", function(e) {
				let conts = $(this);
				let bytes = $(this).parent().find(".msgByte");
				let i = 0;
				let cnt = 0;
				let exceed = 0;
				let maxlength = conts.attr('maxlength');
				let ch = '';
				for (i=0; i<conts.val().length; i++) {
					ch = conts.val().charAt(i);					
					cnt += 1;					
				}
				if (cnt > maxlength) {
					conts.val(conts.val().substring(0,maxlength));
					bytes.html(maxlength);
				}else{
					bytes.html(cnt);
				}
			});
			
			/* 
			*	구성 및 QnA 추가 및 삭제
			*/
			// 값 변경시 data값 입력 
			$(document).on("change", ".checkChange :input:not('.idxChk')", function(e) {
				$(this).parents(".checkChange").addClass("eduChg");
			});
			
			// 교육구성 단계 추가 및 삭제
			function changeStep(bool) { // true : 추가, false : 삭제
				if(bool){
					let chkIdx= $("#step .checkChange").length+1;
					$.get("/contents/eduContsIntroNStep.do?idx="+chkIdx,function (html) { $("#step tbody").append(html);});
				}else{
					let chkedTrs = $("#step .idxChk:checked").parents("tr");
					if(chkedTrs.length == 0){
						messager.alert("삭제할 목록을 선택해 주세요.", "Info", "info");
						return;
					}
					let chkedChangedTrs = $("#step .idxChk:checked").parents(".eduChg");
					messager.confirm('삭제하시겠습니까?',function(r){ 
						if(r){	 				
							chkedTrs.remove();
		 					let idxs = $("#step .idxArea");
		 					idxs.each(function(idx) {
		 						$(idxs[idx]).text(idx+1);
		 						$(idxs[idx]).parents("td").find("input[name=stepNo]").val(idx+1);
		 					});
						}
					});
				}
			}
			
			// QnA 추가 및 삭제
			function changeQna(bool) { // true : 추가, false : 삭제
				if(bool){
					let chkIdx= $("#qna .checkChange").length+1;
					$.get("/contents/eduContsIntroNQna.do?idx="+chkIdx,function (html) { $("#qna tbody").append(html);});
				}else{
					let chkedTrs = $("#qna .idxChk:checked").parents("tr");
					if(chkedTrs.length == 0){
						messager.alert("삭제할 목록을 선택해 주세요.", "Info", "info");
						return;
					}
					let chkedChangedTrs = $("#qna .idxChk:checked").parents(".eduChg");
					messager.confirm('삭제하시겠습니까?',function(r){ 
						if(r){	 				
							chkedTrs.remove();
		 					let idxs = $("#qna .idxArea");
		 					idxs.each(function(idx) {
		 						$(idxs[idx]).text(idx+1);
		 					});
						}
					});
				}
			}
			
			/*
			* 미리보기
			*/
			var preview = {				
				tip : function() {
					let jsonData = $("#eduContsInsertForm").serializeJson();
					if (!jsonData.tipContent) {
						messager.alert("Tip 내용을 입력해 주세요.", "Info", "info");
						return;
					} else {
						let data = '<div class="schoolDetail"><article class="popup-layer typeB" id="popLayer02" style="height:50%;">';
						data += '<div class="popup-wrap">';
						data += '<div class="top">';
						data += '<h2 class="tit">교육 Tip!</h2></div>';
						data += '<div class="content">';
						data += '<main><ul class="tip-list">';
						data += '<li>' + jsonData.tipContent + '</li>';
						data += '</ul></main></div></div></article></div>';
	                            
						let config = {
							id : "tagContentsList"
							, width : 485
							, height : 575
							, top : 50
							, title : "Tip 미리보기"
							, body : data
						};
						layer.create(config);
						accd.set();
					}
				},
				qna : function() {
					let jsonData = $("#eduContsInsertForm").serializeJson();
					let data = "";
					if (jsonData.qnaTtl == "" || jsonData.qnaContent == "") {
						messager.alert("질문과 답변을 모두 입력해 주세요.", "Info", "info");
						return;
					} else {
						if (typeof jsonData.qnaTtl == "string") {
							if (jsonData.qnaTtl == "" || jsonData.qnaContent == "") {
								messager.alert("질문과 답변을 모두 입력해 주세요.", "Info", "info");
								return;
							}
							data += '<div class="schoolDetail"><article class="popup-layer typeB" id="popLayer03" style="height:50%;">';
							data += '<div class="popup-wrap">';
							data += '<div class="top">';
							data += '<h2 class="tit">교육 Q&A</h2></div>';
							data += '<div class="content"><main><ul class="uiAccd qna-list" data-accd="accd">';
							data += '<li class="open">';
							data += '<div class="hBox"><span class="tit">' + jsonData.qnaTtl + '</span>';
							data += '<button type="button" class="btnTog"></button></div>';
							data += '<div class="cBox"><p>' + jsonData.qnaContent + '</p></div></li>';
							data += '</ul></main></div></div></article></div>';
						} else {
							for(let i=0; i<jsonData.qnaTtl.length; i++) {
								if (jsonData.qnaTtl[i] == "" || jsonData.qnaContent[i] == "") {
									messager.alert("질문과 답변을 모두 입력해 주세요.", "Info", "info");
									return;
								}
								if (i == 0) {
									data += '<div class="schoolDetail"><article class="popup-layer typeB" id="popLayer03" style="height:50%;">';
									data += '<div class="popup-wrap">';
									data += '<div class="top">';
									data += '<h2 class="tit">교육 Q&A</h2></div>';
									data += '<div class="content"><main><ul class="uiAccd qna-list" data-accd="accd">';
									data += '<li class="open">';
								} else {
									data += '<li>';
								}
								data += '<div class="hBox"><span class="tit">' + jsonData.qnaTtl[i] + '</span>';
								data += '<button type="button" class="btnTog"></button></div>';
								data += '<div class="cBox"><p>' + jsonData.qnaContent[i] + '</p></div></li>';
							}
							data += '</ul></main></div></div></article></div>';
						}
						
						let config = {
							id : "tagContentsList"
							, width : 485
							, height : 575
							, top : 50
							, title : "Tip 미리보기"
							, body : data
						};
						layer.create(config);
						accd.set();
					}
				}
			}			
			
			/* 
			*	등록 
			*/
			var eduRegist = {
				validateFocus : null, // 유효성 확인 결과 및 포커스
				validateMsg : null,
				validateTargetTop : null,
				setError : function (obj, msg, targetTop) {
					if (eduRegist.validateFocus == null) {
						eduRegist.validateFocus = obj;
						eduRegist.validateMsg = msg;
						eduRegist.validateTargetTop = targetTop;
					}
				},
				validate : function() {
					eduRegist.validateFocus = null;
					eduRegist.validateMsg = null;
					eduRegist.validateTargetTop = null;
					
					// 유효성 확인
					eduRegist.validateCategory();
					if(!isIntro) eduRegist.validateThumbPath();
					if(isIntro) eduRegist.validateBnrPcPath();
					if(isIntro) eduRegist.validateBnrLPath();
					if(isIntro) eduRegist.validateBnrSPath();
					eduRegist.validateTtl();
					if(!isIntro) eduRegist.validatePrpmCd();
					if(isIntro) eduRegist.validateVodPath();
					if(isIntro) eduRegist.validateVodEncode();
					if(!isIntro) eduRegist.validateWebToonPath();
					eduRegist.validateTagNo();
					eduRegist.validateGoodsId();
					if(!isIntro) eduRegist.validateSpet();
					
					if(eduRegist.validateFocus == null){
						// 등록
						eduRegist.regist();
					}else{						
						messager.alert( eduRegist.validateMsg, "Info", "info", function() {
							if(eduRegist.validateTargetTop){
								let goToY = eduRegist.validateTargetTop - (window.innerHeight/2);
								window.scrollTo(0,goToY);
							}else{
								eduRegist.validateFocus.focus();
							}							
						});						
					}
				},
				regist : function() {
					messager.confirm('<spring:message code="column.common.confirm.insert" />', function(r){
						if (r){
							let sendData = $("#eduContsInsertForm").serializeJson();
							let eduContsGoodsList = $("#eduContsGoodsList").getDataIDs();
							$.extend(sendData, {
								goodsId : eduContsGoodsList
							});
														
							let options = {
								url : "<spring:url value='/contents/insertEduContents.do' />"
								, data : sendData
								, callBack : function(result){
									if(result != "F"){
										messager.alert("<spring:message code='column.display_view.message.save' />", "Info", "info", function () {
											addTab('교육용 컨텐츠 상세', '/contents/eduContsDetailView.do?vdId=' + result);
										});
									}else{
										messager.alert("실패 하였습니다.", "Info", "info");
									}
								}
							};
							ajax.call(options);
						}					
					});				
				},
				validateCategory : function() {
					if($("#petGbCd").val() == "" ){
						eduRegist.setError($("#petGbCd"), "펫 구분코드를 입력해 주세요.");
					}else if($("#eudContsCtgLCd").val() == "" ){
						eduRegist.setError($("#eudContsCtgLCd"), "컨텐츠 카테고리 L을 입력해 주세요.");
					}else if($("#eudContsCtgLCd").val() == "${adminConstants.EUD_CONTS_CTG_L_10}" && $("#eudContsCtgMCd").val() == ""){
						eduRegist.setError($("#eudContsCtgMCd"), "컨텐츠 카테고리 M을 입력해 주세요.");
					}else if($("#eudContsCtgLCd").val() == "${adminConstants.EUD_CONTS_CTG_L_10}" && $("#eudContsCtgSCd").val() == ""){
						eduRegist.setError($("#eudContsCtgSCd"), "컨텐츠 카테고리 S를 입력해 주세요.");
					}
				},
				validateThumbPath : function () {
					let thumbImgPath = $("#thumbImgPath");
					let vodPath = $("input[name=vodPath]");
					if(thumbImgPath.val() == ""){
						if ( $("input:radio[name=thumAutoYn]:checked").val() == '${adminConstants.THUM_AUTO_YN_Y}' ) {
							eduRegist.setError(vodPath, "영상을 입력해 주세요.");
						}else{
							eduRegist.setError(thumbImgPath, "썸네일을 입력해 주세요.");
						}
					}							
				},
				validateBnrPcPath : function () {
					let bnrPcPath = $("#bnrPcPath");
					if(bnrPcPath.val() == ""){
						eduRegist.setError(bnrPcPath, "PC배너를 입력해 주세요.");
					}							
				},
				validateBnrLPath : function () {
					let bnrLPath = $("#bnrLPath");
					if(bnrLPath.val() == ""){
						eduRegist.setError(bnrLPath, "큰배너를 입력해 주세요.");
					}							
				},
				validateBnrSPath : function () {
					let bnrSPath = $("#bnrSPath");
					if(bnrSPath.val() == ""){
						eduRegist.setError(bnrSPath, "작은배너를 입력해 주세요.");
					}							
				},
				validateTtl : function () {
					let ttl = $("#ttl");
					if(ttl.val() == ""){
						eduRegist.setError(ttl, "제목을 입력해 주세요.");
					}							
				},
				validatePrpmCd : function () {
					let prpmCd = $("input:checkbox[name='prpmCd']:checked");
					let prpmCdTg = $("input:checkbox[name='prpmCd']");
					if(prpmCd.length == 0){
						eduRegist.setError(prpmCdTg, "준비물을 입력해 주세요.", prpmCdTg.offset().top);
					}							
				},
				validateVodPath : function () {
					let vodPath = $("input[name=vodPath]");
					if(vodPath.val() == ""){
						eduRegist.setError(vodPath, "영상을 입력해 주세요.");
					}							
				},
				validateVodEncode : function () {
					let vodOutsideVdId = $("input[name=vodOutsideVdId]");
					if(vodOutsideVdId.data("encodedyn") !="Y"){
						eduRegist.setError(vodOutsideVdId.parents("td").find(".chkEncodingBtn"), "영상을 저장해 주세요.");
					}				
				},
				validateWebToonPath : function () {
					let webToonPath = $("input[name=webToonPath]");
					if(webToonPath.val() == ""){
						eduRegist.setError(webToonPath.parents("td").find("button"), "웹툰을 입력해 주세요.");
					}							
				},
				validateTagNo : function () {
					let tagNo = $("input[name=tagNo]");
					if(tagNo.length == 0){
						eduRegist.setError($('#addTagBtn'), "태그를 입력해 주세요.");
					}							
				},
				validateGoodsId : function () {
					let goodsId = $("#eduContsGoodsList").getDataIDs();
					if(goodsId.length == 0){
						eduRegist.setError($('#addGoodsBtn'), "상품을 입력해 주세요.");
					}								
				},
				validateSpet : function () {
					let path = $("input[name=stepPath]");
					let stepOutsideVdId = $("input[name=stepOutsideVdId]");
					let stepTtl = $("input[name=stepTtl]");
					let stepDscrt = $("textarea[name=stepDscrt]");
					path.each(function(e) {
						if(path[e].value ==""){
							eduRegist.setError($(path[e]).parents("td").find("button"), ((e == 0)?"완료":e)+"단계 파일을 입력해 주세요.");
						}
					});
					stepOutsideVdId.each(function(e) {
						if($(stepOutsideVdId[e]).data("encodedyn") !="Y"){
							eduRegist.setError($(stepOutsideVdId[e]).parents("td").find(".chkEncodingBtn"), ((e == 0)?"완료":e)+"단계 영상을 저장해 주세요.");
						}
					});
					stepTtl.each(function(e) {
						if(stepTtl[e].value ==""){
							eduRegist.setError($(stepTtl[e]), "교육구성의 제목을 입력해 주세요.");
						}
					});
					stepDscrt.each(function(e) {
						if(stepDscrt[e].value ==""){
							eduRegist.setError($(stepDscrt[e]), "교육구성의 설명을 입력해 주세요.");
						}
					});
				}
			}
		</script>
	</t:putAttribute>
	<t:putAttribute name="content">

	<form name="eduContsInsertForm" id="eduContsInsertForm" style="height: 100% !important">
		<!-- 
			교육용 콘텐츠 등록
		-->
		<div class="mTitle">
			<h2>교육용 콘텐츠 등록</h2>
		</div>

		<table class="table_type1">
			<colgroup>
				<col width="150px"/>
				<col />
				<col width="150px"/>
				<col />
			</colgroup>
			<caption>교육용 콘텐츠 등록</caption>
			<tbody>
				<tr>
					<!-- 교육 ID -->
					<th><spring:message code="column.educonts_vdId"/><strong class="red">*</strong></th>
					<td colspan="3">자동입력</td>
				</tr>
				<tr id="cateArea">
					<!-- 카테고리 -->
					<th scope="row"><spring:message code="column.educonts_category" /><strong class="red">*</strong></th>
					<td  colspan="3">
						<select id="petGbCd" name="petGbCd" onfocus=""	onchange="eduCateInsert(this);">
							<frame:select grpCd="${adminConstants.PET_GB }" useYn="Y" defaultName="선택"/>
						</select>
						<select id="eudContsCtgLCd" name="eudContsCtgLCd" class="readonly" onchange="eduCateInsert(this);" disabled="disabled">
							<frame:select grpCd="${adminConstants.EUD_CONTS_CTG_L }" useYn="Y" defaultName="선택"/>
						</select>
						<select id="eudContsCtgMCd" name="eudContsCtgMCd" class="readonly"	onchange="eduCateInsert(this);" disabled="disabled">
							<frame:select grpCd="${adminConstants.EUD_CONTS_CTG_M }" useYn="Y" defaultName="선택"/>
						</select>
						<select id="eudContsCtgSCd" name="eudContsCtgSCd" class="readonly"	onchange="eduCateInsert(this);" disabled="disabled">
							<frame:select grpCd="${adminConstants.EUD_CONTS_CTG_S }" useYn="Y" defaultName="선택"/>
						</select>
					</td>
				</tr>
				<tr>
					<!-- 전시여부 -->
					<th><spring:message code="column.contsStat"/><strong class="red">*</strong></th>
					<td id="bnrPcPreTd">
						<frame:radio name="dispYn" grpCd="${adminConstants.DISP_STAT }" />
					</td>
					<!-- PC 배너 -->
					<th class="introY" style="display: none;" scope="row"><spring:message code="column.educonts_pc_banner" /><strong class="red">*</strong></th>
					<td class="introY" style="display: none;">
						<div class="inner">
							<input type="hidden" id="bnrPcPath" name="bnrPcPath" title="<spring:message code='column.educonts_pc_banner'/>" value="" />
							<input type="hidden" name="bnrPcSize" title="<spring:message code="column.fl_sz"/>" value="">
							<input type="hidden" name="bnrPcOrgFlNm" title="<spring:message code="column.org_fl_nm"/>" value="" />
							<img id="bnrPcPathView" name="bnrPcPathView" src="/images/noimage.png" class="thumb" alt="" />
						</div>
						<div class="inner ml10" style="vertical-align:middle;">
							<!-- 파일선택 --> 
							<button type="button" class="btn" onclick="resultImage('bannerPc');" ><spring:message code="column.fl_choice" /></button>
						</div>
					</td>
					<!-- 썸네일 -->
					<th class="introN"><spring:message code="column.thum"/><strong class="red">*</strong></th>
					<td class="introN">
						<div class="inner">
							<!-- 영상 업로드시 추출된 데이터  -->
							<input type="hidden" id="thumbImgPathDone" name="thumbImgPathDone" value="" />
							<input type="hidden" name="thumbImgSizeDone" value="">
							<input type="hidden" name="thumbImgOrgFlNmDone" value="" />
							<!-- 전송 데이터 -->
							<input type="hidden" id="thumbImgPath" name="thumbImgPath" title="<spring:message code="column.thum"/>" value="" />
							<input type="hidden" name="thumbImgSize" title="<spring:message code="column.fl_sz"/>" value="">
							<input type="hidden" name="thumbImgOrgFlNm" title="<spring:message code="column.org_fl_nm"/>" value="" />
							<img id="thumbImgPathView" name="thumbImgPathView" src="/images/noimage.png" class="thumb" alt="" />
						</div>
						<div class="inner ml10" style="vertical-align:middle;">
							<input type="hidden" name="thumbDownloadUrl" value="" />
							<frame:radio name="thumAutoYn" grpCd="${adminConstants.THUM_AUTO_YN }" selectKey="${adminConstants.THUM_AUTO_YN_Y }" />
							<!-- 파일선택 --> 
							<button type="button" id="thmBtn" class="btn" onclick="resultImage('thumb');" disabled="disabled" ><spring:message code="column.fl_choice" /></button>
						</div>
					</td>
				</tr>
				<tr class="introY" style="display: none;">
					<!-- 큰배너 -->
					<th scope="row"><spring:message code="column.educonts_l_banner" /><strong class="red">*</strong></th>
					<td>
						<div class="inner">
							<input type="hidden" id="bnrLPath" name="bnrLPath" title="<spring:message code='column.educonts_l_banner'/>" value="" />
							<input type="hidden" name="bnrLSize" title="<spring:message code="column.fl_sz"/>" value="">
							<input type="hidden" name="bnrLOrgFlNm" title="<spring:message code="column.org_fl_nm"/>" value="" />
							<img id="bnrLPathView" name="bnrLPathView" src="/images/noimage.png" class="thumb" alt="" />
						</div>
						<div class="inner ml10" style="vertical-align:middle;">
							<!-- 파일선택 --> 
							<button type="button" class="btn" onclick="resultImage('bannerL');" ><spring:message code="column.fl_choice" /></button>
						</div>
					</td>
					<!-- 작은 배너 -->
					<th scope="row"><spring:message code="column.educonts_s_banner" /><strong class="red">*</strong></th>
					<td>
						<div class="inner">
							<input type="hidden" id="bnrSPath" name="bnrSPath" title="<spring:message code='column.educonts_s_banner'/>" value="" />
							<input type="hidden" name="bnrSSize" title="<spring:message code="column.fl_sz"/>" value="">
							<input type="hidden" name="bnrSOrgFlNm" title="<spring:message code="column.org_fl_nm"/>" value="" />
							<img id="bnrSPathView" name="bnrSPathView" src="/images/noimage.png" class="thumb" alt="" />
						</div>
						<div class="inner ml10" style="vertical-align:middle;">
							<!-- 파일선택 --> 
							<button type="button" class="btn" onclick="resultImage('bannerS');" ><spring:message code="column.fl_choice" /></button>
						</div>
					</td>	
				</tr>
				<tr>
					<!-- 제목 -->
					<th><spring:message code="column.ttl"/><strong class="red">*</strong></th>
					<td colspan="3">
						<input type="text" name="ttl" id="ttl" class="w450 msg noHash" value="" maxlength="20" title="<spring:message code="column.ttl"/>" />
						<span>
							&nbsp;<span id="ttlMsgByte" class="msgByte" style="color:#00B0F0;">0</span> / 20자
						 </span>
					</td>
				</tr>
				<tr class="introN">
					<!-- 난이도 -->
					<th scope="row"><spring:message code="column.educonts_apet_lod" /><strong class="red">*</strong></th>
					<td colspan="3">
						<frame:radio name="lodCd" grpCd="${adminConstants.APET_LOD }" useYn="Y" />
					</td>
				</tr>
				<tr class="introN" id="prpmCdTr">
					<!-- 준비물 -->
					<th scope="row"><spring:message code="column.educonts_prpm" /><strong class="red">*</strong></th>
					<td colspan="3">
						<frame:checkbox name="prpmCd" grpCd="${adminConstants.PRPM }"/>
					</td>
				</tr>
				<tr class="introY" style="display: none;">
					<!-- 영상 -->
					<th><spring:message code="column.vod"/><strong class="red">*</strong></th>
					<td colspan="3">
						<div class="mg5" id="vodFileView">
							<input type="hidden" name="vodPath" value="">
							<input type="hidden" name="vodSize" value="">
							<input type="hidden" name="vodOutsideVdId" value="" data-encodedyn="">
							<input type="hidden" name="vodVdLnth"  value="">
							<input type="text" name="vodOrgFlNm" class="readonly w400" title="<spring:message code="column.org_fl_nm"/>" value="" />
							<button type="button" name="vodFileUpladBtn" style="" onclick="$('#vodUploadFile').click();" class="btn">파일선택</button>
							<div style="display:none;">
								<input type="file" id="vodUploadFile" name="vodUploadFile" accept="video/mp4,video/x-m4v,video/*" onchange="vodUpload(this, resultVod);">
							</div>
							<button type="button" style="margin-left: 20px;" onclick="chkEncoding(this);" class="btn chkEncodingBtn" disabled="disabled" >저장</button>
						</div>
					</td>
				</tr>
				<tr class="introN">
					<!-- 웹툰 -->
					<th scope="row"><spring:message code="column.educonts_webtoon" /><strong class="red">*</strong></th>
					<td colspan="3">
						<div class="inner">
							<input type="hidden" name="webToonPath" title="<spring:message code="column.educonts_webtoon"/>" value="">
							<input type="hidden" name="webToonSize" title="<spring:message code="column.fl_sz"/>" value="">
							<input type="hidden" name="webToonOrgFlNm" title="<spring:message code="column.org_fl_nm"/>" value="" />
						</div>
						<div class="inner" style="vertical-align:middle;">
							<!-- 파일선택 --> 
							<button type="button" class="btn" id="webToonFlBtn" onclick="resultImage('webToon');" ><spring:message code="column.fl_choice" /></button>
						</div>
						<div class="inner ml10" id="webToonFlNmArea"></div>
						<button id="showWebtoonBtn" style="display: none;" type="button" class="roundBtn ml10" onclick="showWebtoon();" >보기</button>
					</td>	
				</tr>
				<tr>
					<!-- 태그 -->
					<input type="hidden" name="tags" id="sTags" title="<spring:message code="column.vod.tag"/>" value="">
					<th><spring:message code="column.vod.tag"/><strong class="red">*</strong></th>
					<td colspan="3">
						<span id="vTags">
						</span>
						<button type="button" class="roundBtn" id="addTagBtn" onclick="addTag();" >+ 추가</button>
					</td>
				</tr>
				<tr id="goodsMapTr" >
					<!-- 상품 연동 -->
					<th><spring:message code="column.vod.good.map"/><strong class="red">*</strong></th>
					<td colspan="3">
						<button type="button" class="roundBtn" id="addGoodsBtn" style="margin:5px 0px 7px 0px;" onclick="addGoods();" >+ 관련 상품 불러오기</button>
						<div class="mModule no_m" style="width: 98%">
							<table id="eduContsGoodsList" ></table>
						</div>
					</td>
				</tr>
			</tbody>
		</table>
		
		<div id="introNArea">
			<jsp:include page="/WEB-INF/view/contents/include/eduContsIntroN.jsp"></jsp:include>
		</div>
	</form>
		<div class="btn_area_center">
			<button type="button" onclick="eduRegist.validate();" class="btn" style="background-color: #0066CC;">등록</button>
			<button type="button" onclick="closeTab();" class="btn btn-cancel">취소</button>
		</div>

	</t:putAttribute>
</t:insertDefinition>
