<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<jsp:include page="/WEB-INF/view/contents/include/eduContsTipQnAPreview.jsp"></jsp:include>
		<script type="text/javascript">
			$(document).ready(function(){
				// 상품 그리드 그리기
				createEduContsGoodsGrid();
				
				// 글자수 카운트
				$(".msg").each(function(i, v){
					chkMsgByte(v);
				});
 			});
			
			/*
			*	교육 / 교육 Intro 구분
			*/
			var isIntro = false; // true : 교육Intro, false : 교육
			if('${eduConts.eudContsCtgLCd}' == '${adminConstants.EUD_CONTS_CTG_L_20}'){
				isIntro = true;
			}
			
			/*
			*	update 여부
			*/
			var chkChgContents 	= false;	// APET_CONTENTS		
			var chkChgFile 		= false;	// APET_ATTACH_FILE			
			var chkChgTag 		= false;	// APET_CONTENTS_TAG_MAP
			var chkChgGoods 	= false;	// APET_CONTENTS_GOODS_MAP
			var chkChgDetail 	= false;	// APET_CONTENTS_DETAIL
			var chkChgConstruct = false;	// APET_CONTENTS_CONSTRUCT
			$(document).on("change", ".chkChgContents :input",function() { 
				chkChgContents = true;
			});
			$(document).on("change", ".chkChgDetail :input",function() { 
				chkChgDetail = true;
			});
			$(document).on("change", ".chkChgConstruct :input",function() { 
				chkChgConstruct = true;
			});
			
			/*
			*  썸네일 자동, 수동 이벤트
			*/
			$(document).on("change", "input[name=thumAutoYn]", function(e) {
				if ($(this).val() == '${adminConstants.THUM_AUTO_YN_Y}') {
					$("#thmBtn").attr('disabled', 'true');
					let sgrAk = sgrGenerate();
					let videoId = $("#cmpltStep input[name=stepOutsideVdId]").val();
					let option = {
							authKey : sgrAk
							, video_id : videoId
					}
					vodInfo(option, function(result){
						$("input[name=thumbImgPath]").val(result.contents[0].thumb_url);
						$("input[name=thumbImgSize]").val('');
						$("input[name=thumbImgOrgFlNm]").val(result.contents[0].video_id + '.png');
						$("input[name=thumbDownloadUrl]").val(result.contents[0].thumb_download_url);	
					});
				} else {
					$("input[name=thumbImgPath]").val('');
					$("input[name=thumbImgSize]").val('');
					$("input[name=thumbImgOrgFlNm]").val('');
					$("input[name=thumbDownloadUrl]").val('');	
					$("#thmBtn").removeAttr('disabled');
				}
				chkChgFile = true;
			});
			
			/*
			*	이미지 업로드 결과 
			*/
			var isWebToonChg =  false;
			function resultImage(type) {
				if(type == "bannerPc"){
					fileUpload.image(function(file) {
						$("input[name=bnrPcPath]").val(file.filePath);
						$("input[name=bnrPcSize]").val(file.fileSize);
						$("input[name=bnrPcOrgFlNm]").val(file.fileName);
						chkChgFile = true;
					});
				}else if(type == "bannerL"){
					fileUpload.image(function(file) {
						$("input[name=bnrLPath]").val(file.filePath);
						$("input[name=bnrLSize]").val(file.fileSize);
						$("input[name=bnrLOrgFlNm]").val(file.fileName);
						chkChgFile = true;
					});
				}else if(type == "bannerS"){
					fileUpload.image(function(file) {
						$("input[name=bnrSPath]").val(file.filePath);
						$("input[name=bnrSSize]").val(file.fileSize);
						$("input[name=bnrSOrgFlNm]").val(file.fileName);
						chkChgFile = true;
					});
				}else if(type == "webToon"){
					fileUpload.image(function(file) {
						$("input[name=webToonPath]").val(file.filePath);
						$("input[name=webToonSize]").val(file.fileSize);
						$("input[name=webToonOrgFlNm]").val(file.fileName);
						$("#webToonFlNmArea").text(file.fileName);
						chkChgFile = true;
						isWebToonChg =  true;
					});
				}else if(type == "thumb"){
					fileUpload.image(function(file) {
						$("input[name=thumbImgPath]").val(file.filePath);
						$("input[name=thumbImgSize]").val(file.fileSize);
						$("input[name=thumbImgOrgFlNm]").val(file.fileName);
						chkChgFile = true;
					});
				}					
			}
			
			/*
			* 이미지 다운로드
			*/
			function vodFileNcpDownload(filePath, fileName, thumImgDownloadUrl){
				if (thumImgDownloadUrl != '') {
					window.location.href = thumImgDownloadUrl;
				} else {
					var data = {
						  filePath : filePath
						, fileName : fileName
						, imgYn	: 'Y'
					}
					createFormSubmit("fileDownload", "/common/fileDownloadResult.do", data);
				}
			}
			
			/*
			*	웹툰 새창 열기			
			*/
			function showWebtoon(){
				if(isWebToonChg){
					window.open(location.protocol + '//<spring:eval expression="@webConfig['site.domain']" />/common/imageView.do?filePath='+$("input[name=webToonPath]").val());
				}else{
					window.open('${frame:imagePath("' + $('input[name=webToonPath]').val() + '")}');
				} 
			}
			
			/*
			*	영상 변경 결과
			*/
			function resultVod (result, obj) {
				let thisObjName = $(obj).attr("name");
				var gb;
				if(thisObjName == "vodUploadFile"){
					gb = "vod";
					chkChgFile = true;
				}else{
					gb = "step";
					chkChgDetail = true;
				}
				$(obj).parents("td").find("input[name="+gb+"Size]").val("");
				$(obj).parents("td").find("input[name="+gb+"VdLnth]").val("");
				$(obj).parents("td").find("input[name="+gb+"Path]").val(result.content[0].download_url);
				$(obj).parents("td").find("input[name="+gb+"OutsideVdId]").val(result.content[0].video_id);
				$(obj).parents("td").find("input[name="+gb+"OutsideVdId]").data("encodedyn","");
				$(obj).parents("td").find("input[name="+gb+"OrgFlNm]").val(obj.files[0].name);
				$(obj).parents("td").find(".chkEncodingBtn").attr('disabled', false);
				
				// 썸네일 결과 적용
				if($(obj).hasClass('cmpltStep')){
					$("input[name=thumbImgPathDone]").val(result.content[0].thumb_url);
					$("input[name=thumbImgSizeDone]").val('');
					$("input[name=thumbImgOrgFlNmDone]").val(result.content[0].video_id + '.png');
					$("input[name=thumbDownloadUrl]").val(result.content[0].thumb_download_url);
					if ( $("input:radio[name=thumAutoYn]:checked").val() == '${adminConstants.THUM_AUTO_YN_Y}' ) {
						$("input[name=thumbImgPath]").val(result.content[0].thumb_url);
						$("input[name=thumbImgSize]").val('');
						$("input[name=thumbImgOrgFlNm]").val(result.content[0].video_id + '.png');
					}
					chkChgFile = true;
				}
			}
			
			/*
			*	영상 변경 업로드후 인코딩 결과 확인			
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
							if($("input[name=thumbImgPath]").length == 0){
								var vodFileViewHtml = '<input type="hidden" id="thumbImgPath" name="thumbImgPath" title="<spring:message code="column.thum"/>"  value="'+result.contents[0].thumb_url+'" />';
								vodFileViewHtml += '<input type="hidden" name="thumbImgSize" title="<spring:message code="column.fl_sz"/>" value="">';
								vodFileViewHtml +=	'<input type="hidden" name="thumbImgOrgFlNm" title="<spring:message code="column.org_fl_nm"/>" value="'+result.contents[0].video_id + '.png" />';
								$("#vodFileView").append(vodFileViewHtml);	
							}else{
								$("input[name=thumbImgPath]").val(result.contents[0].thumb_url);
								$("input[name=thumbImgSize]").val('');
								$("input[name=thumbImgOrgFlNm]").val(result.contents[0].video_id + '.png');
							}
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
				chkChgTag = true;
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
									chkChgTag = true;
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
					url : "<spring:url value='/contents/vodGoodsListGrid.do' />"
					, height : 400
					, searchParam : {
						vdId : '${eduConts.vdId}'
					}
					, colModels : [
						/* 상품 번호 hidden */
						{name:"goodsId", key:true, hidden:true}
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
						, {name:'goodsStatCd', label:'<spring:message code="column.goods_stat_cd" />', width:'200', align:'center', sortable:false, classes:'cursor_default', formatter:'select', editoptions:{value:"<frame:gridSelect grpCd='${adminConstants.GOODS_STAT }' showValue='false' />" } }
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
				chkChgGoods = true;
			}
			
			// 상품 추가
			function addGoods() {
				chkChgGoods = true;
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
				chkMsgByte(this);
			});
			function chkMsgByte(obj) {
				let conts = $(obj);
				let bytes = $(obj).parent().find(".msgByte");
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
			}
						
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
					chkChgDetail = true;
				}else{
					let chkedTrs = $("#step .idxChk:checked").parents("tr");
					if(chkedTrs.length == 0){
						messager.alert("삭제할 목록을 선택해 주세요.", "Info", "info");
						return;
					}
					let chkedChangedTrs = $("#step .idxChk:checked").parents(".eduChg");
					messager.confirm('삭제하시겠습니까?',function(r){ 
						if(r){
							chkChgDetail = true;
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
					chkChgConstruct = true;
				}else{
					let chkedTrs = $("#qna .idxChk:checked").parents("tr");
					if(chkedTrs.length == 0){
						messager.alert("삭제할 목록을 선택해 주세요.", "Info", "info");
						return;
					}
					let chkedChangedTrs = $("#qna .idxChk:checked").parents(".eduChg");
					messager.confirm('삭제하시겠습니까?',function(r){ 
						if(r){
							chkChgConstruct = true;
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
					let jsonData = $("#eduContsDetailForm").serializeJson();
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
					let jsonData = $("#eduContsDetailForm").serializeJson();
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
			*	수정
			*/
			var eduUpdate = {
				validateFocus : null, // 유효성 확인 결과 및 포커스
				validateMsg : null,
				validateTargetTop : null,
				setError : function (obj, msg, targetTop) {
					if (eduUpdate.validateFocus == null) {
						eduUpdate.validateFocus = obj;
						eduUpdate.validateMsg = msg;
						eduUpdate.validateTargetTop = targetTop;
					}
				},
				validate : function() {
					eduUpdate.validateFocus = null;
					eduUpdate.validateMsg = null;
					eduUpdate.validateTargetTop = null;
					
					// 유효성 확인
					if(!isIntro) eduUpdate.validateThumbPath();
					if(isIntro) eduUpdate.validateBnrPcPath();
					if(isIntro) eduUpdate.validateBnrLPath();
					if(isIntro) eduUpdate.validateBnrSPath();
					eduUpdate.validateTtl();
					if(!isIntro) eduUpdate.validatePrpmCd();					
					if(isIntro) eduUpdate.validateVodPath();
					if(isIntro) eduUpdate.validateVodEncode();
					if(!isIntro) eduUpdate.validateWebToonPath();
					eduUpdate.validateTagNo();
					eduUpdate.validateGoodsId();
					if(!isIntro) eduUpdate.validateSpet();
					
					if(eduUpdate.validateFocus == null){
						if(chkChgContents||chkChgFile||chkChgTag||chkChgGoods||chkChgDetail||chkChgConstruct){
							eduUpdate.update();
						}else{
							alert("변경사항이 없습니다.");
						}						
					}else{						
						messager.alert( eduUpdate.validateMsg, "Info", "info", function() {
							if(eduUpdate.validateTargetTop){
								let goToY = eduUpdate.validateTargetTop - (window.innerHeight/2);
								window.scrollTo(0,goToY);
							}else{
								eduUpdate.validateFocus.focus();
							}							
						});						
					}
				},
				update : function() {
					messager.confirm('<spring:message code="column.common.confirm.update" />', function(r){
						if (r){
							let sendData = $("#eduContsDetailForm").serializeJson();
							let eduContsGoodsList = $("#eduContsGoodsList").getDataIDs();
							$.extend(sendData, {
								goodsId : eduContsGoodsList
								, chkChgContents : chkChgContents
								, chkChgFile : chkChgFile
								, chkChgTag : chkChgTag
								, chkChgGoods : chkChgGoods
								, chkChgDetail : chkChgDetail
								, chkChgConstruct : chkChgConstruct
								
							});
														
							let options = {
								url : "<spring:url value='/contents/updateEduContents.do' />"
								, data : sendData
								, callBack : function(result){
									if(result != "F"){
										messager.alert("<spring:message code='column.display_view.message.save' />", "Info", "info", function() {
											updateTab();	
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
				validateThumbPath : function () {
					let thumbImgPath = $("#thumbImgPath");
					let vodPath = $("input[name=vodPath]");
					if(thumbImgPath.val() == ""){
						if ( $("input:radio[name=thumAutoYn]:checked").val() == '${adminConstants.THUM_AUTO_YN_Y}' ) {
							eduUpdate.setError(vodPath, "영상을 입력해 주세요.");
						}else{
							eduUpdate.setError(thumbImgPath, "썸네일을 입력해 주세요.");
						}
					}							
				},
				validateBnrPcPath : function () {
					let bnrPcPath = $("#bnrPcPath");
					if(bnrPcPath.val() == ""){
						eduUpdate.setError(bnrPcPath, "PC배너를 입력해 주세요.");
					}							
				},
				validateBnrLPath : function () {
					let bnrLPath = $("#bnrLPath");
					if(bnrLPath.val() == ""){
						eduUpdate.setError(bnrLPath, "큰배너를 입력해 주세요.");
					}							
				},
				validateBnrSPath : function () {
					let bnrSPath = $("#bnrSPath");
					if(bnrSPath.val() == ""){
						eduUpdate.setError(bnrSPath, "작은배너를 입력해 주세요.");
					}							
				},
				validateTtl : function () {
					let ttl = $("#ttl");
					if(ttl.val() == ""){
						eduUpdate.setError(ttl, "제목을 입력해 주세요.");
					}							
				},
				validatePrpmCd : function () {
					let prpmCd = $("input:checkbox[name='prpmCd']:checked");
					let prpmCdTg = $("input:checkbox[name='prpmCd']");
					if(prpmCd.length == 0){
						eduUpdate.setError(prpmCdTg, "준비물을 입력해 주세요.", prpmCdTg.offset().top);
					}							
				},
				validateVodPath : function () {
					let vodPath = $("input[name=vodPath]");
					if(vodPath.val() == ""){
						eduUpdate.setError(vodPath, "영상을 입력해 주세요.");
					}							
				},
				validateVodEncode : function () {
					let vodOutsideVdId = $("input[name=vodOutsideVdId]");
					if(vodOutsideVdId.data("encodedyn") !="Y"){
						eduUpdate.setError(vodOutsideVdId.parents("td").find(".chkEncodingBtn"), "영상을 저장해 주세요.");
					}				
				},
				validateWebToonPath : function () {
					let webToonPath = $("input[name=webToonPath]");
					if(webToonPath.val() == ""){
						eduUpdate.setError(webToonPath.parents("td").find("button"), "웹툰을 입력해 주세요.");
					}							
				},
				validateTagNo : function () {
					let tagNo = $("input[name=tagNo]");
					if(tagNo.length == 0){
						eduUpdate.setError($('#addTagBtn'), "태그를 입력해 주세요.");
					}							
				},
				validateGoodsId : function () {
					let goodsId = $("#eduContsGoodsList").getDataIDs();
					if(goodsId.length == 0){
						eduUpdate.setError($('#addGoodsBtn'), "상품을 입력해 주세요.");
					}								
				},
				validateSpet : function () {
					let path = $("input[name=stepPath]");
					let stepOutsideVdId = $("input[name=stepOutsideVdId]");
					let stepTtl = $("input[name=stepTtl]");
					let stepDscrt = $("textarea[name=stepDscrt]");
					path.each(function(e) {
						if(path[e].value ==""){
							eduUpdate.setError($(path[e]).parents("td").find("button"), ((e == 0)?"완료":e)+"단계 파일을 입력해 주세요.");
						}
					});
					stepOutsideVdId.each(function(e) {
						if($(stepOutsideVdId[e]).data("encodedyn") !="Y"){
							eduUpdate.setError($(stepOutsideVdId[e]).parents("td").find(".chkEncodingBtn"), ((e == 0)?"완료":e)+"단계 영상을 저장해 주세요.");
						}
					});
					stepTtl.each(function(e) {
						if(stepTtl[e].value ==""){
							eduUpdate.setError($(stepTtl[e]), "교육구성의 제목을 입력해 주세요.");
						}
					});
					stepDscrt.each(function(e) {
						if(stepDscrt[e].value ==""){
							eduUpdate.setError($(stepDscrt[e]), "교육구성의 설명을 입력해 주세요.");
						}
					});
				}				
			}
			
		</script>
	</t:putAttribute>
	<t:putAttribute name="content">

	<form name="eduContsDetailForm" id="eduContsDetailForm" style="height: 100% !important">
		<!-- 
			교육용 콘텐츠 상세
		-->
		<div class="mTitle">
			<h2>교육용 콘텐츠 상세</h2>
		</div>

		<table class="table_type1">
			<colgroup>
				<col width="150px"/>
				<col />
				<col width="150px"/>
				<col />
			</colgroup>
			<caption>교육용 콘텐츠 상세</caption>
			<tbody>
				<tr>
					<!-- 교육 ID -->
					<th><spring:message code="column.educonts_vdId"/><strong class="red">*</strong></th>
					<td colspan="3">${eduConts.vdId}</td>
					<input type="hidden" name="vdId" value="${eduConts.vdId}" />
				</tr>
				<tr id="cateArea">
					<!-- 카테고리 -->
					<th scope="row"><spring:message code="column.educonts_category" /><strong class="red">*</strong></th>
					<td  colspan="3">
						<select id="petGbCd" name="petGbCd" disabled="disabled">
							<frame:select grpCd="${adminConstants.PET_GB }" useYn="Y" defaultName="선택" selectKey="${eduConts.petGbCd}" readOnly="true"/>
						</select>
						<select id="eudContsCtgLCd" name="eudContsCtgLCd" disabled="disabled">
							<frame:select grpCd="${adminConstants.EUD_CONTS_CTG_L }" useYn="Y" defaultName="선택" selectKey="${eduConts.eudContsCtgLCd}" readOnly="true"/>
						</select>
						<select id="eudContsCtgMCd" name="eudContsCtgMCd" disabled="disabled">
							<frame:select grpCd="${adminConstants.EUD_CONTS_CTG_M }" useYn="Y" defaultName="선택" selectKey="${eduConts.eudContsCtgMCd}" readOnly="true"/>
						</select>
						<select id="eudContsCtgSCd" name="eudContsCtgSCd" disabled="disabled">
							<frame:select grpCd="${adminConstants.EUD_CONTS_CTG_S }" useYn="Y" defaultName="선택" selectKey="${eduConts.eudContsCtgSCd}" readOnly="true"/>
						</select>
					</td>
				</tr>
				<tr>
					<!-- 전시여부 -->
					<th><spring:message code="column.contsStat"/><strong class="red">*</strong></th>
					<td class="chkChgContents">
						<frame:radio name="dispYn" grpCd="${adminConstants.DISP_STAT }" selectKey="${eduConts.dispYn}" />
					</td>
					<!-- PC 배너 -->
					<th <c:if test="${eduConts.eudContsCtgLCd ne adminConstants.EUD_CONTS_CTG_L_20}"> style="display: none;"</c:if> scope="row"><spring:message code="column.educonts_pc_banner" /><strong class="red">*</strong></th>
					<td class="chkChgFile"  <c:if test="${eduConts.eudContsCtgLCd ne adminConstants.EUD_CONTS_CTG_L_20}"> style="display: none;"</c:if>>
						<c:forEach items="${eduConts.fileList}" var="bnrPc" varStatus="idx" >
							<c:if test="${bnrPc.contsTpCd eq adminConstants.CONTS_TP_80}">
								<div class="inner">
									<input type="hidden" id="bnrPcPath" name="bnrPcPath" title="<spring:message code='column.educonts_pc_banner'/>" value="${bnrPc.phyPath}" />
									<input type="hidden" name="bnrPcSize" title="<spring:message code="column.fl_sz"/>" value="${bnrPc.flSz}">
									<input type="hidden" name="bnrPcOrgFlNm" title="<spring:message code="column.org_fl_nm"/>" value="${bnrPc.orgFlNm}" />
									<img id="bnrPcPathView" name="bnrPcPathView" src="${frame:optImagePath(bnrPc.phyPath, adminConstants.IMG_OPT_QRY_400)}" class="thumb" alt="" />
								</div>
								<div class="inner ml10" style="vertical-align:middle;">
									<span onclick="vodFileNcpDownload('${bnrPc.phyPath}', '${bnrPc.orgFlNm}', '');" style="color: #0066CC;text-decoration: underline;font-size: 12px;cursor: pointer;">${bnrPc.orgFlNm }</span>
									<br/>
									<!-- 파일선택 --> 
									<button type="button" class="btn" onclick="resultImage('bannerPc');" ><spring:message code="column.chg_file" /></button>
								</div>
							</c:if>
						</c:forEach>
					</td>
					<!-- 썸네일 -->
					<th <c:if test="${eduConts.eudContsCtgLCd eq adminConstants.EUD_CONTS_CTG_L_20}"> style="display: none;"</c:if>><spring:message code="column.thum"/><strong class="red">*</strong></th>
					<td class="chkChgContents chkChgFile" <c:if test="${eduConts.eudContsCtgLCd eq adminConstants.EUD_CONTS_CTG_L_20}"> style="display: none;"</c:if>>
						<c:forEach items="${eduConts.fileList}" var="thumb" varStatus="idx" >
							<c:if test="${thumb.contsTpCd eq adminConstants.CONTS_TP_10}">
								<div class="inner">
									<!-- 영상 업로드시 추출된 데이터  -->
									<c:set var="thumbImgPathDone" value=""/>
									<c:set var="thumbImgSizeDone" value=""/>
									<c:set var="thumbImgOrgFlNmDone" value=""/>
									<c:set var="thumbDownloadUrlDone" value=""/>
									<c:forEach items="${eduConts.fileList}" var="thumbDnUrl" varStatus="idx" >
										<c:if test="${eduConts.thumAutoYn eq adminConstants.COMM_YN_Y and thumbDnUrl.contsTpCd eq adminConstants.CONTS_TP_90}">
											<c:set var="thumbDownloadUrlDone" value="${thumbDnUrl.phyPath}" />
										</c:if>
										<c:if test="${thumbDnUrl.contsTpCd eq adminConstants.CONTS_TP_10}">
											<c:set var="thumbImgPathDone" value="${thumbDnUrl.phyPath}"/>
											<c:set var="thumbImgSizeDone" value="${thumbDnUrl.flSz}"/>
											<c:set var="thumbImgOrgFlNmDone" value="${thumbDnUrl.orgFlNm}"/>
										</c:if>
									</c:forEach>
									<!-- 전송 데이터 -->
									<input type="hidden" id="thumbImgPath" name="thumbImgPath" title="<spring:message code="column.thum"/>"  value="${thumbImgPathDone}" />
									<input type="hidden" name="thumbImgSize" title="<spring:message code="column.fl_sz"/>" value="${thumbImgSizeDone}">
									<input type="hidden" name="thumbImgOrgFlNm" title="<spring:message code="column.org_fl_nm"/>" value="${thumbImgOrgFlNmDone}" />
									<input type="hidden" name="thumbDownloadUrl" title="<spring:message code="column.org_fl_nm"/>" value="${thumbDownloadUrlDone}" />
									<img id="thumbImgPathView" name="thumbImgPathView" src="${fn:indexOf(thumbImgPathDone, 'cdn.ntruss.com') > -1 ? thumbImgPathDone : frame:optImagePath(thumbImgPathDone, adminConstants.IMG_OPT_QRY_400)}" class="thumb" alt="" />
								</div>
								<div class="inner ml10" style="vertical-align:middle;">
									<c:forEach items="${eduConts.fileList}" var="thumbDnUrl" varStatus="idx" >
										<c:if test="${eduConts.thumAutoYn eq adminConstants.COMM_YN_Y and thumbDnUrl.contsTpCd eq adminConstants.CONTS_TP_90}">
											<span onclick="vodFileNcpDownload('', '', '${thumbDnUrl.phyPath}');" style="color: #0066CC;text-decoration: underline;font-size: 12px;cursor: pointer;">${thumb.orgFlNm }</span>
											<br/>
										</c:if>
										<c:if test="${eduConts.thumAutoYn eq adminConstants.COMM_YN_N and thumbDnUrl.contsTpCd eq adminConstants.CONTS_TP_10}">
											<span onclick="vodFileNcpDownload('${thumbDnUrl.phyPath}', '${thumbDnUrl.orgFlNm}', '');" style="color: #0066CC;text-decoration: underline;font-size: 12px;cursor: pointer;">${thumbDnUrl.orgFlNm }</span>
											<br/>
										</c:if>
									</c:forEach>
									<frame:radio name="thumAutoYn" grpCd="${adminConstants.THUM_AUTO_YN }" selectKey="${eduConts.thumAutoYn }" />
									<!-- 파일선택 --> 
									<button type="button" id="thmBtn" class="btn" onclick="resultImage('thumb');" <c:if test="${eduConts.thumAutoYn eq adminConstants.COMM_YN_Y }" >disabled="disabled"</c:if>><spring:message code="column.chg_file" /></button>
								</div>
							</c:if>
						</c:forEach>
					</td>
				</tr>
				<tr class="chkChgFile" <c:if test="${eduConts.eudContsCtgLCd ne adminConstants.EUD_CONTS_CTG_L_20}"> style="display: none;"</c:if> >
					<!-- 큰배너 -->
					<th scope="row"><spring:message code="column.educonts_l_banner" /><strong class="red">*</strong></th>
					<td>
						<c:forEach items="${eduConts.fileList}" var="bnrL" varStatus="idx" >
							<c:if test="${bnrL.contsTpCd eq adminConstants.CONTS_TP_40}">
								<div class="inner">
									<input type="hidden" id="bnrLPath" class="required req_input2" name="bnrLPath" title="<spring:message code='column.educonts_l_banner'/>" value="${bnrL.phyPath}" />
									<input type="hidden" name="bnrLSize" title="<spring:message code="column.fl_sz"/>" value="${bnrL.flSz}">
									<input type="hidden" name="bnrLOrgFlNm" title="<spring:message code="column.org_fl_nm"/>" value="${bnrL.orgFlNm}" />
									<img id="bnrLPathView" name="bnrLPathView" src="${frame:optImagePath(bnrL.phyPath, adminConstants.IMG_OPT_QRY_400)}" class="thumb" alt="" />
								</div>
								<div class="inner ml10" style="vertical-align:middle;">
									<span onclick="vodFileNcpDownload('${bnrL.phyPath}', '${bnrL.orgFlNm}', '');" style="color: #0066CC;text-decoration: underline;font-size: 12px;cursor: pointer;">${bnrL.orgFlNm }</span>
									<br/>
									<!-- 파일선택 --> 
									<button type="button" class="btn" onclick="resultImage('bannerL');" ><spring:message code="column.chg_file" /></button>
								</div>
							</c:if>
						</c:forEach>						
					</td>
					<!-- 작은 배너 -->
					<th scope="row"><spring:message code="column.educonts_s_banner" /><strong class="red">*</strong></th>
					<td>
						<c:forEach items="${eduConts.fileList}" var="bnrS" varStatus="idx" >
							<c:if test="${bnrS.contsTpCd eq adminConstants.CONTS_TP_50}">
								<div class="inner">
									<input type="hidden" id="bnrSPath" class="required req_input2" name="bnrSPath" title="<spring:message code='column.educonts_s_banner'/>" value="${bnrS.phyPath}" />
									<input type="hidden" name="bnrSSize" title="<spring:message code="column.fl_sz"/>" value="${bnrS.flSz}">
									<input type="hidden" name="bnrSOrgFlNm" title="<spring:message code="column.org_fl_nm"/>" value="${bnrS.orgFlNm}" />
									<img id="bnrSPathView" name="bnrSPathView" src="${frame:optImagePath(bnrS.phyPath, adminConstants.IMG_OPT_QRY_400)}" class="thumb" alt="" />
								</div>
								<div class="inner ml10" style="vertical-align:middle;">
									<span onclick="vodFileNcpDownload('${bnrS.phyPath}', '${bnrS.orgFlNm}', '');" style="color: #0066CC;text-decoration: underline;font-size: 12px;cursor: pointer;">${bnrS.orgFlNm }</span>
									<br/>
									<!-- 파일선택 --> 
									<button type="button" class="btn" onclick="resultImage('bannerS');" ><spring:message code="column.chg_file" /></button>
								</div>
								</c:if>
						</c:forEach>
					</td>	
				</tr>
				<tr class="chkChgContents">
					<!-- 제목 -->
					<th><spring:message code="column.ttl"/><strong class="red">*</strong></th>
					<td colspan="3">
						<input type="text" name="ttl" id="ttl" class="w450 msg noHash" value="${eduConts.ttl}" maxlength="20" title="<spring:message code="column.ttl"/>" />
						<span>
							&nbsp;<span id="ttlMsgByte" class="msgByte" style="color:#00B0F0;">0</span> / 20자
						 </span>
					</td>
				</tr>
				<tr class="chkChgContents" <c:if test="${eduConts.eudContsCtgLCd eq adminConstants.EUD_CONTS_CTG_L_20}">style="display: none;"</c:if> >
					<!-- 난이도 -->
					<th scope="row"><spring:message code="column.educonts_apet_lod" /><strong class="red">*</strong></th>
					<td colspan="3">
						<frame:radio name="lodCd" grpCd="${adminConstants.APET_LOD }" selectKey="${eduConts.lodCd}" useYn="Y"/>
					</td>
				</tr>
				<tr class="chkChgContents" id="prpmCdTr" <c:if test="${eduConts.eudContsCtgLCd eq adminConstants.EUD_CONTS_CTG_L_20}">style="display: none;"</c:if> >
					<!-- 준비물 -->
					<th scope="row"><spring:message code="column.educonts_prpm" /><strong class="red">*</strong></th>
					<td colspan="3">
						<frame:checkbox name="prpmCd" grpCd="${adminConstants.PRPM }" checkedArray="${eduConts.prpmCd}" />
					</td>
				</tr>
				<tr class="chkChgFile" <c:if test="${eduConts.eudContsCtgLCd ne adminConstants.EUD_CONTS_CTG_L_20}"> style="display: none;"</c:if> >
					<!-- 영상 -->
					<th><spring:message code="column.vod"/><strong class="red">*</strong></th>
					<td colspan="3">
						<c:forEach items="${eduConts.fileList}" var="vod" varStatus="idx" >
							<c:if test="${vod.contsTpCd eq adminConstants.CONTS_TP_60}">
								<div class="mg5" id="vodFileView">
									<!-- toUpdate -->								
									<input type="hidden" name="vodPath" value="${vod.phyPath}">
									<input type="hidden" name="vodSize" value="${vod.flSz}">
									<input type="hidden" name="vodOrgFlNm" value="${vod.orgFlNm}" />
									<input type="hidden" name="vodOutsideVdId" value="" data-encodedyn="Y">
									<input type="hidden" name="vodVdLnth"  value="">
									<!-- orgInfo -->
									<span id="vodOrgFlNmArea">${vod.orgFlNm}</span>
									<button type="button" onclick="window.location.href ='${vod.phyPath}';" class="roundBtn" style="margin-bottom: 5px;">↓ 영상다운로드</button>
									<br/>
									<iframe src ="<spring:eval expression="@bizConfig['vod.player.api.url']" />/load/${vod.outsideVdId}?v=1&vtype=mp4" frameborder="0" width="600px" height="350px"
									scrolling="no" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"	allowfullscreen>
									</iframe>
									<br/>
									<button type="button" name="vodFileUpladBtn" style="" onclick="$('#vodUploadFile').click();" class="btn">영상변경</button>
									<div style="display:none;">
										<input type="file" id="vodUploadFile" name="vodUploadFile" accept="video/mp4,video/x-m4v,video/*" onchange="vodUpload(this, resultVod);">
									</div>
									<button type="button" style="margin-left: 20px;" onclick="chkEncoding(this);" class="btn chkEncodingBtn" disabled="disabled" >저장</button>
								</div>
							</c:if>
						</c:forEach>
					</td>
				</tr>
				<tr class="chkChgFile" <c:if test="${eduConts.eudContsCtgLCd eq adminConstants.EUD_CONTS_CTG_L_20}">style="display: none;"</c:if> >
					<!-- 웹툰 -->
					<th scope="row"><spring:message code="column.educonts_webtoon" /><strong class="red">*</strong></th>
					<td colspan="3">
						<c:forEach items="${eduConts.fileList}" var="webToon" varStatus="idx" >
							<c:if test="${webToon.contsTpCd eq adminConstants.CONTS_TP_30}">
								<div class="inner">
									<input type="hidden" name="webToonPath" class="required req_input2" title="<spring:message code="column.educonts_webtoon"/>" value="${webToon.phyPath}">
									<input type="hidden" name="webToonSize" title="<spring:message code="column.fl_sz"/>" value="${webToon.flSz}">
									<input type="hidden" name="webToonOrgFlNm" title="<spring:message code="column.org_fl_nm"/>" value="${webToon.orgFlNm}" />
								</div>
								<div class="inner" style="vertical-align:middle;">
									<!-- 파일선택 --> 
									<button type="button" class="btn" onclick="resultImage('webToon');" >변경</button>
								</div>
								<div class="inner ml10" id="webToonFlNmArea">${webToon.orgFlNm}</div>
								<button type="button" class="roundBtn ml10" onclick="showWebtoon();" >보기</button>
							</c:if>
						</c:forEach>
					</td>	
				</tr>
				<tr class="chkChgTag">
					<!-- 태그 -->
					<input type="hidden" name="tags" id="sTags" class="required req2_input2" title="<spring:message code="column.vod.tag"/>" value="">
					<th><spring:message code="column.vod.tag"/><strong class="red">*</strong></th>
					<td colspan="3">
						<span id="vTags">
							<c:forEach items="${eduConts.tagList}" var="tag" varStatus="status">
								<span class="rcorners1 selectTag" tag-nm="tag.tagNm" id="${tag.tagNo }">${tag.tagNm }</span>
								<img id="${tag.tagNo }Delete" onclick="deleteTag('${tag.tagNo}')" class="tagDeleteBtn" src="/images/icon-header-close.svg" />
								<input type="hidden" id="${tag.tagNo}Input" name="tagNo" value="${tag.tagNo}">
							</c:forEach>
						</span>
						<button type="button" class="roundBtn" id="addTagBtn" onclick="addTag();" >+ 추가</button>
					</td>
				</tr>
				<tr class="chkChgGoods" id="goodsMapTr" >
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
		<c:if test="${eduConts.eudContsCtgLCd ne adminConstants.EUD_CONTS_CTG_L_20}">
			<div>
				<jsp:include page="/WEB-INF/view/contents/include/eduContsIntroN.jsp"/>
			</div>
		</c:if>
	</form>
	<br/>
	<br/>
	<table class="table_type1">
		<caption>교육 상세</caption>
		<tbody>
			<tr>
				<!-- 등록자 -->
				<th><spring:message code="column.sys_regr_nm"/></th>
				<td>
					${eduConts.sysRegrNm}
				</td>
				<!-- 등록일시 -->
				<th><spring:message code="column.regdate"/></th>
				<td>
					<fmt:formatDate value="${eduConts.sysRegDtm}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
			</tr>
			<tr>
				<!-- 수정자 -->
				<th><spring:message code="column.sys_updr_nm"/></th>
				<td>
					${eduConts.sysUpdrNm}
				</td>
				<!-- 수정일시 -->
				<th><spring:message code="column.upddate"/></th>
				<td>
					<fmt:formatDate value="${eduConts.sysUpdDtm}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
			</tr>
			<tr>
				<!-- 조회수 -->
				<th><spring:message code="column.vod.play"/></th>
				<td>
					<fmt:formatNumber type="number" maxFractionDigits="3" value="${eduConts.hits}" /> 회
				</td>
				<!-- 좋아요 -->
				<th><spring:message code="column.vod.like"/></th>
				<td>
					♥ <fmt:formatNumber type="number" maxFractionDigits="3" value="${eduConts.likeCnt}" />
				</td>
			</tr>
			<tr>
				<!-- 공유수 -->
				<th><spring:message code="column.vod.share_cnt"/></th>
				<td colspan="3">
					<fmt:formatNumber type="number" maxFractionDigits="3" value="${eduConts.shareCnt}" />
				</td>
				<!-- 댓글수 -->
<%-- 				<th><spring:message code="column.vod.reply_cnt"/></th> --%>
<!-- 				<td> -->
<%-- 					<p style="text-decoration: underline;"><fmt:formatNumber type="number" maxFractionDigits="3" value="${eduConts.replyCnt }" /> 개</p> --%>
<!-- 				</td> -->
			</tr>
		</tbody>
	</table>
	<div class="btn_area_center">
		<button type="button" onclick="eduUpdate.validate();" class="btn" style="background-color: #0066CC;">수정</button>
		<button type="button" onclick="closeTab();" class="btn btn-cancel">취소</button>
	</div>

	</t:putAttribute>
</t:insertDefinition>
