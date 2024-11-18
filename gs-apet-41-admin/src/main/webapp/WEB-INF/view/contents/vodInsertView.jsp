<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">
			$(document).ready(function(){
				$("input[name=srisYn]").trigger("change");
				$('input[name=srisYn]:not(:checked)').attr('disabled', true);
				let option = {
						authKey : '${frame:getAuthKey()}'
						, channel_id : 'aboutpet_tv'
						//, video_id : '5FFA6734C9D9E'
				}
 			});

			<%-- 영상 업로드 Callback --%>
			function vodCallback(result) {
				$("#vodFlSz").val("");
				$("#vdLnth").val("");
				$("#vodFileSaveBtn").removeAttr('disabled');
				let $obj = $("#vodFileView");
				$obj.find("input[name=vodPath]").val(result.content[0].download_url);
				$obj.find("input[name=outsideVdId]").val(result.content[0].video_id);
				$obj.find("input[name=thumb_url]").val(result.content[0].thumb_url);
				$obj.find("input[name=vodNm]").val(document.getElementById('vodUploadFile').files[0].name);
				$("#thumVodOrgPath").val(result.content[0].thumb_video_url);
				$("#thumVodOrgNm").val('thumb_' + result.content[0].video_id + '.mp4');
				$("#thumVodFlSz").val('');
				$("#thumImgDownloadUrl").val(result.content[0].thumb_download_url);
				if ( $("input:radio[name=thumAutoYn]:checked").val() == '${adminConstants.THUM_AUTO_YN_Y}' ) {
					$("#thumImgOrgPath").val(result.content[0].thumb_url);
					$("#thumImgOrgNm").val(result.content[0].video_id + '.png');
					$("#thumImgFlSz").val('');
					$("#thumImgPathView").attr('src', result.content[0].thumb_url);
				}
			}

			<%-- 태그 삭제 --%>
			function deleteTag(tagNo) {
				$("#"+ tagNo).remove();
				$("#"+ tagNo + "Delete").remove();
			}

			<%-- 시리즈 여부 변경 --%>
			$(document).on("change", "input[name=srisYn]", function(e) {
				if ($(this).val() == '${adminConstants.COMM_YN_Y}') {
					$("#srisNo").removeAttr('disabled');
					$("#srisNo").removeClass('readonly');
					$("#srisNo").addClass('required');
					$("#srisNo").val('');
				} else {
					$("#srisNo, #sesnNo").attr('disabled', 'true');
					$("#srisNo, #sesnNo").addClass('readonly');
					$("#srisNo, #sesnNo").removeClass('required');
					$("#srisNo, #sesnNo").val('');
				}
			});
			
			<%-- 시리즈 선택 --%>
			$(document).on("change", "#srisNo", function(e) {
				if ($(this).val() == '') {
					$("#sesnNo").attr('disabled', 'true');
					$("#sesnNo").addClass('readonly');
					$("#sesnNo").removeClass('required');
					$("#sesnNo").val('');
				} else {
					let optionSeason = "<option value='' selected='selected'>시즌 선택</option>";
					let options = {
							url : "<spring:url value='/contents/listSeason.do' />"
							, data : {
								srisNo : $(this).val()
							}
							, callBack : function(result) {
								if (result.length > 0) {
									jQuery(result).each(function(i){
										optionSeason += "<option value='" + result[i].sesnNo + "'>" + result[i].sesnNm + "</option>";
									});
									$("#sesnNo").html('');
									$("#sesnNo").append(optionSeason);
									$("#sesnNo").removeAttr('disabled');
									$("#sesnNo").removeClass('readonly');
									$("#sesnNo").addClass('required');
								} else {
									$("#sesnNo").attr('disabled', 'true');
									$("#sesnNo").addClass('readonly');
									$("#sesnNo").removeClass('required');
									$("#sesnNo").html('');
									$("#sesnNo").append(optionSeason);
								}
							}
						};

						ajax.call(options);
				}
			});
			
			<%-- 상품 연동 display --%>
			$(document).on("change", "input[name=vdTpCd]", function(e) {
				if ($(this).val() == '${adminConstants.VD_TP_20}') {
					$("#goodsMapTr").css('display', '');
					createVodGoodsGrid();
				} else {
					$("#goodsMapTr").css('display', 'none');
				}
			});

			<%-- 상품 연동 grid --%>
			function createVodGoodsGrid(){
				let options = {
					url : "<spring:url value='/contents/vodGoodsListGrid.do' />"
					, height : 400
					, searchParam : {
						vdId : '${vod.vdId}'
					}
					, colModels : [
						<%-- 상품 번호 hidden--%>
						{name:"goodsId", hidden:true}
						<%-- 썸네일 이미지 --%>
						, {name:"imgPath", label:'<spring:message code="column.thum" />', width:"220", align:"center", sortable:false, formatter: function(cellvalue, options, rowObject) {
								var imgPath = rowObject.imgPath.indexOf('cdn.ntruss.com') > -1 ? rowObject.imgPath : '${frame:optImagePath("' + rowObject.imgPath + '", adminConstants.IMG_OPT_QRY_400)}';
								return '<img src='+imgPath+' style="width:100px; height:100px;" onError="this.src=\'/images/noimage.png\'"  />';
							}
						}
						<%-- 상품 명 --%>
						, {name:'goodsNm', label:'<spring:message code="column.display_view.goods_nm" />', width:'500', align:'center', classes:'pointer', sortable:false }
						<%-- 상품 ID --%>
						, {name:"goodsId", label:_GOODS_SEARCH_GRID_LABEL.goodsId, width:"250", align:"center", classes:'cursor_default', sortable:false}
						<%-- 상품 상태 --%>
						, {name:'goodsStatCd', label:'<spring:message code="column.goods_stat_cd" />', width:'200', align:'center', classes:'cursor_default', sortable:false, formatter:'select', editoptions:{value:"<frame:gridSelect grpCd='${adminConstants.GOODS_STAT }' showValue='false' />" } }
						<%-- 삭제 버튼 --%>
						, {name:"button", label:'<spring:message code="column.common.delete"/>', width:"200", align:"center", sortable:false, formatter: function(rowId, val, rawObject, cm) {
							let str = '<button type="button" onclick="fnGoodsDelete(\'' + rawObject.goodsId + '\')" class="roundBtn">- 삭제</button>';
							return str;
						}}
						]
					, paging : false
					, onCellSelect : function (id, cellidx, cellvalue) {
						if(cellidx == 2) {
							let goodsId = $('#vodGoodsList').jqGrid ('getCell', id, 'goodsId');
							addTab('상품 상세 - ' + goodsId, "/goods/goodsDetailView.do?goodsId=" + goodsId);
						}
					}
				};
				grid.create("vodGoodsList", options);
			}

			<%-- 연동상품 삭제 --%>
			function fnGoodsDelete(goodsId) {
				$("#vodGoodsList").delRowData(goodsId);
			}

			<%-- text length check --%>
			$(document).on("keyup input", ".msg", function(e) {
				let conts = document.getElementById($(this).attr('id'));
				let bytes = document.getElementById($(this).attr('id') + "MsgByte");
				let i = 0;
				let cnt = 0;
				let exceed = 0;
				let maxlength = $(this).attr('maxlength');
				let ch = '';
				for (i=0; i<conts.value.length; i++) {
					ch = conts.value.charAt(i);
					
						cnt += 1;
					
				}
				bytes.innerHTML = cnt;
				if (cnt > maxlength) {
					$(this).val($(this).val().substring(0,maxlength));
					bytes.innerHTML = maxlength;
				}
			});

			<%-- 상품 추가 --%>
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
								let vodGoods = $('#vodGoodsList').getDataIDs();
								//let message = new Array();
								let message = '';
								let msgCheck = true;
								let cnt = -1;
								for(let vg in goods){
									let check = true;

									<%-- 새로 추가할 상품이 현재 연동 상품과 겹치는지 확인 --%>
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
										$("#vodGoodsList").jqGrid('addRowData', goods[vg].goodsId, goods[vg], 'last', null);
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

			<%-- 태그 추가 --%>
			function addTag() {
				let sTag = $(".selectTag");
				if (sTag.length >= 10) {
					messager.alert("<spring:message code='admin.web.view.msg.vod.limit.tag' />", "Info", "info");
				} else {
					let options = {
							multiselect : true
							, callBack : function(tags) {
								if(tags != null) {
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
									let html = "";
									sTagsLen = sTags.length;
									for(let tg in tags){
										let check = true;
										<%-- 새로 추가할 태그가 현재 태그와 겹치는지 확인 --%>
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
											sTagsLen ++;
											if (sTagsLen < 11) {
												html += '<span class="rcorners1 selectTag" tag-nm="' + tags[tg].tagNm +'" id="' + tags[tg].tagNo + '">' + tags[tg].tagNm + '</span>' 
												+ '<img id="' + tags[tg].tagNo + 'Delete" onclick="deleteTag(\'' + tags[tg].tagNo + '\')" class="tagDeleteBtn" src="/images/icon-header-close.svg" />';
											}
										}
									}
									if(message != null && message.length > 0) {
										if (cnt == 0) {
											message += "<spring:message code='admin.web.view.msg.vod.dupl.tag' />";
										} else {
											message += " 외 " + cnt + "건 " + "<spring:message code='admin.web.view.msg.vod.dupl.tag' />";
										}
										if (sTagsLen < 11) {
											messager.alert(message, "Info", "info");
										}
									}
									if (sTagsLen < 11) {
										$("#vTags").append (html);
									} else {
										messager.alert("<spring:message code='admin.web.view.msg.vod.limit.tag' />", "Info", "info");
									}
								}
							}
						}
					layerTagBaseList.create(options);
				}
			}
			
			<%-- 영상 등록 --%>
			function vodInsert(){
				let sTag = $(".selectTag");
				let sTags = new Array();
				sTag.each(function(i, v){
					if (sTags.indexOf(v.id) === -1) {
						sTags.push(v.id);
					}
				})
				
				$("#sTags").val(sTags);
				if (validation.check() != '') {
					messager.alert(validation.check(), "Info", "info");
					return;
				}

				let gridData = $("#vodGoodsList").getRowData();
				let vdTpCd = $(":radio[name=vdTpCd]:checked").val();
				if(gridData.length <= 0 && vdTpCd == '${adminConstants.VD_TP_20}') {
					// 필수 제거
					//messager.alert("<spring:message code='column.vod.goods.map.no_data' />", "Info", "info");
					//return;
				}
				messager.confirm('<spring:message code="column.common.confirm.insert" />', function(r){
					if (r){
						<%-- 업로드 영상 playList id 변경 --%>
						if ( $("input:radio[name=srisYn]:checked").val() == '${adminConstants.COMM_YN_Y}' ) {
							let grpOption = {
									authKey : sgrGenerate()
									, channel_id : _VOD_CHNL_ID_TV
							}
							vodGroupList(grpOption, function(data){
								var grpChk = false;
								var pId;
								var playlists = data.result.playlists;
								$.each(playlists,function(key,value) {
									if ($("#srisNo option:checked").text()== value.name) {
										grpChk = true;
										pId = value.id;
									}
								});
								if (!grpChk) {
									grpOption.playlist_name = $("#srisNo option:checked").text();
									vodGroupAdd(grpOption, function(data){
										pId = data.contents.playlist_id;
									});
								}
								
								grpOption.playlist_id = pId;
								grpOption.video_id = $("#outsideVdId").val();
								vodMove(grpOption, function(data){
									if(data.code!=200) {
										messager.alert("오류가 발생되었습니다. 다시 시도하여 주십시오.["+data.code+"]["+data.message+"]", "Error", "error");
										return;
									}
								});
								
							});
							
						}
						<%-- playList id End --%>
						let path = $("[id$='OrgPath']");
						let flSz = $("[id$='FlSz']");
						let nm = $("[id$='OrgNm']");
						//let vdLnth = $("[id$='vdLnth']");
						
						let paths = new Array();
						let flSzs = new Array();
						let nms = new Array();
						//let vdLnthArr = new Array();
						
						path.each(function(i, v){
							paths.push(v.value);
						})
						flSz.each(function(i, v){
							flSzs.push(v.value);
						})
						nm.each(function(i, v){
							nms.push(v.value);
						})
						/* vdLnth.each(function(i, v){
							vdLnthArr.push(v.value);
						}) */

						$("#paths").val(paths);
						$("#names").val(nms);
						$("#flSzs").val(flSzs);
						/* $("#vdLnthArr").val(vdLnthArr); */
						
						let sendData = $("#vodInsertForm").serializeJson();
						let vodGoodsList = grid.jsonData('vodGoodsList');
						$.extend(sendData, {
							goodsMapPo : JSON.stringify(vodGoodsList)
						});
						
						let options = {
							url : "<spring:url value='/contents/vodInsert.do' />"
							, data : sendData
							, callBack : function(result){
								messager.alert("<spring:message code='column.display_view.message.save' />", "Info", "info", function(){
									updateTab('/contents/vodListView.do', '영상 관리');
								});
							}
						};

						ajax.call(options);
					}
				});
			}
			
			var validation = {
				check: function() {
					let requiredTag = $(".required");
					let requiredTags = new Array();
					let chk = true;
					let msg = '';
					requiredTag.each(function(i, v){
						if ($.trim($(this).val()) == '' || $(this).val() == null) {
							$(this).val('');
							$(this).trigger('input');
							if (chk) {
								if ($(this).attr('class').indexOf('req_input2') != -1) {
									msg = v.title  + "<spring:message code='admin.web.view.msg.vod.req_input2' />"; 
								} else if ($(this).attr('class').indexOf('req2_input2') != -1) {
									msg = v.title  + "<spring:message code='admin.web.view.msg.vod.req2_input2' />";
								} else if ($(this).attr('class').indexOf('req_save') != -1) {
									if ($("#vodSaveChk").val() == '${adminConstants.SGR_RESULT_ENCODING_STATE_SUCCESS}'){
										msg = "영상정보가 올바르지 않습니다.<br/>솔루션업체에 문의바랍니다."
									} else {
										msg = "<spring:message code='admin.web.view.msg.vod.req_save' />";
									}
								}else {
									msg = v.title  + "<spring:message code='admin.web.view.msg.vod.req_input' />";
								}
							}
							chk = false;
						}
					})
					return msg;
				}
			};

			<%-- 이미지 업로드 결과 --%>
			function resultImage (file ) {
				// 썸네일
				if (imageType =='1'){
					$("#thumImgOrgPath").val(file.filePath);
					$("#thumImgOrgNm").val(file.fileName);
					$("#thumImgFlSz").val(file.fileSize);
					$("#thumImgPathView").attr('src', '/common/imageView.do?filePath=' + file.filePath );	
				}
				// 상단 노출 이미지
				else if (imageType =='2'){
					$("#topImgOrgPath").val(file.filePath);
					$("#topImgOrgNm").val(file.fileName);
					$("#topImgFlSz").val(file.fileSize);
					$("#topImgPathView").attr('src', '/common/imageView.do?filePath=' + file.filePath );
				}
			}

			<%-- 상단 노출 임시 이미지 삭제 --%>
			function deleteTopImage() {
				$("#topImgOrgPath").val("");
				$("#topImgNm").val("");
				$("#topImgFlSz").val("");
				$("#topImgPathView").attr('src', '/images/noimage.png' );
			}
			
			$(document).on("change", "input[name=thumAutoYn]", function(e) {
				if ($(this).val() == '${adminConstants.THUM_AUTO_YN_Y}') {
					$("#thmBtn").attr('disabled', 'true');
					if ($("#vodOrgPath").val() == ''){
						$("#thumImgOrgPath").val("");
						$("#thumImgOrgNm").val("");
						$("#thumImgFlSz").val("");
						$("#thumImgPathView").attr('src', '/images/noimage.png' );
					} else {
						$("#thumImgOrgPath").val($("#thumb_url").val());
						$("#thumImgOrgNm").val($("#outsideVdId").val() + '.png');
						$("#thumImgFlSz").val('');
						$("#thumImgPathView").attr('src', $("#thumb_url").val());
					}
				} else {
					$("#thumImgOrgPath").val("");
					$("#thumImgOrgNm").val("");
					$("#thumImgFlSz").val("");
					$("#thumImgPathView").attr('src', '/images/noimage.png' );
					$("#thmBtn").removeAttr('disabled');
					
				}
			});

			<%-- 영상 저장 --%>
			let waitChk = false;
			let sgrAk;
			function vodSave() {
				sgrAk = sgrGenerate();
				/* if (!waitChk) {
					waitChk = true;
					waiting.start();
				} */
				var option = {
						authKey : sgrAk
						, video_id : $("#outsideVdId").val()
				}
				vodInfo(option, function(result){
					if (result.contents[0].encoding_state == '${adminConstants.SGR_RESULT_ENCODING_STATE_SUCCESS}'){
						/* waiting.stop();
						waitChk = false; */
						
						if (result.contents[0].filesize != null && result.contents[0].filesize != '') {
							$("#vodFlSz").val(parseInt(result.contents[0].filesize));
						}
						$("#vdLnth").val(result.contents[0].duration);
						$("#vodSaveChk").val(result.contents[0].encoding_state);
						messager.alert("<spring:message code='admin.web.view.common.normal_process.final_msg' />", "Info", "info");
					} else if (result.contents[0].encoding_state == '${adminConstants.SGR_RESULT_ENCODING_STATE_FAILED}') {
						/* waiting.stop();
						waitChk = false; */
						$("#vodSaveChk").val(result.contents[0].encoding_state);
						$("vodOrgPath").val("");
						$("#vodFlSz").val("");
						$("#vdLnth").val("");
						$("#outsideVdId").val("");
						$("#thumb_url").val("");
						$("#vodOrgNm").val("");
						$("#thumVodOrgPath").val("");
						$("#thumVodOrgNm").val("");
						$("#thumVodFlSz").val("");
						if ( $("input:radio[name=thumAutoYn]:checked").val() == '${adminConstants.THUM_AUTO_YN_Y}' ) {
							$("#thumImgOrgPath").val("");
							$("#thumImgOrgNm").val("");
							$("#thumImgFlSz").val("");
							$("#thumImgPathView").attr('src', '/images/noimage.png');
						}
						$("#vodFileSaveBtn").attr('disabled', 'true');
						messager.alert("<spring:message code='admin.web.view.msg.vod.upload.encoding_failed' />", "Error", "error");
					} else {
						/* setTimeout(vodSave, 2000); */
						$("#vodSaveChk").val(result.contents[0].encoding_state);
						messager.alert("<spring:message code='admin.web.view.msg.vod.upload.encoding_processing' />", "Info", "info");
					}
				});
			}
		</script>
	</t:putAttribute>
	<t:putAttribute name="content">

	<form name="vodInsertForm" id="vodInsertForm">
		<div class="mTitle">
			<h2>영상 등록</h2>
		</div>

		<table class="table_type1">
			<caption>영상 등록</caption>
			<colgroup>
				<col width="150px"/>
				<col />
				<col width="150px"/>
				<col />
			</colgroup>
			<tbody>
				<tr>
					<!-- 영상 ID -->
					<th><spring:message code="column.vd_id"/></th>
					<td colspan="3">
						자동입력
						
					</td>
				</tr>
				<tr>
					<!-- 시리즈 여부 -->
					<th><spring:message code="column.seriesYn"/><strong class="red">*</strong></th>
					<td colspan="3">
						<frame:radio name="srisYn" grpCd="${adminConstants.SERIES_YN }" selectKey="${adminConstants.SERIES_YN_Y }" useYn="Y" required="true" disabled="true" />
						<select id="srisNo" name="srisNo" class="w300 readonly" title=<spring:message code="column.vod.series"/> disabled="disabled">
							<option value="">시리즈 선택</option>
							<c:forEach items="${allSeries}" var="series" varStatus="status">
								<option value="${series.srisNo}">${series.srisNm}</option>
							</c:forEach>
						</select>
						<select id="sesnNo" name="sesnNo" class="readonly" title=<spring:message code="column.vod.season"/> disabled="disabled">
							<option value="">시즌 선택</option>
						</select>
					</td>
				</tr>
				<tr>
					<!-- 타입 -->
					<th><spring:message code="column.vod_tp"/><strong class="red">*</strong></th>
					<td colspan="3">
						<select name="tpCd" id="tpCd" class="required" title="<spring:message code="column.vod_tp"/>">
							<frame:select grpCd="${adminConstants.APET_TP}" defaultName="선택" />
						</select>
					</td>
				</tr>
				<tr>
					<!-- 영상 -->
					<th><spring:message code="column.vod"/><strong class="red">*</strong></th>
					<td colspan="3">
						<div class="mg5" id="vodFileView">
							<input type="hidden" id="vodOrgPath" name="vodPath" class="required req_input2" title="<spring:message code="column.vod"/>" value="">
							<input type="hidden" id="vodFlSz" name="vodFlSz" title="<spring:message code="column.fl_sz"/>" value="">
							<input type="hidden" id="vdLnth" name="vdLnth" class="required req_save" value="">
							<input type="hidden" id="outsideVdId" name="outsideVdId" value="">
							<input type="hidden" id="thumb_url" name="thumb_url" value="">
							<input type="text" class="readonly w400" readonly="readonly" id="vodOrgNm" name="vodNm" title="<spring:message code="column.org_fl_nm"/>" value="" />
							<button type="button" name="vodFileUpladBtn" style="" onclick="$('#vodUploadFile').click();" class="btn">파일선택</button>
							<button type="button" id="vodFileSaveBtn" name="vodFileSaveBtn" style="margin-left: 20px;" onclick="vodSave();" class="btn" disabled="disabled" >저장</button>
							<div style="display:none;">
								<%-- <input type="file" style="position:absolute; top:-100px;" id="avatar" name="avatar" accept="video/mp4,video/x-m4v,video/*" onchange="vodUpload('avatar', '${frame:getAuthKey()}', ccb);"> --%>
								<input type="file" id="vodUploadFile" name="vodUploadFile" accept="video/mp4,video/x-m4v,video/*" onchange="vodUpload(this, vodCallback);">
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<!-- 전시여부 -->
					<th><spring:message code="column.contsStat"/><strong class="red">*</strong></th>
					<td colspan="3">
						<frame:radio name="dispYn" grpCd="${adminConstants.DISP_STAT }" disabled="true" selectKey="${adminConstants.DISP_STAT_N }" />
						<span style="color: #bf4346;vertical-align: bottom;">※ 등록 완료 후 영상 상세에서 전시로 변경 가능</span>
					</td>
				</tr>
				<tr>
					<!-- 썸네일 -->
					<th><spring:message code="column.thum"/><strong class="red">*</strong></th>
					<td>
						<div class="inner">
							<input type="hidden" id="thumImgOrgPath" class="required req_input2" name="thumImgPath" title="<spring:message code='column.thum'/>" value="" />
							<input type="hidden" id="thumImgOrgNm" name="thumImgNm" value="" />
							<input type="hidden" id="thumImgFlSz" name="thumImgFlSz" value="" />
							<input type="hidden" id="thumImgDownloadUrl" name="thumImgDownloadUrl" value="" />
							<img id="thumImgPathView" name="thumImgPathView" src="/images/noimage.png" class="thumb" alt="" />
						</div>
						<div class="inner ml10" style="vertical-align:middle;">
							<frame:radio name="thumAutoYn" grpCd="${adminConstants.THUM_AUTO_YN }" selectKey="${adminConstants.THUM_AUTO_YN_Y }" />
							<!-- 파일선택 --> 
							<button type="button" id="thmBtn" class="btn" onclick="imageType=1;fileUpload.image(resultImage);" disabled="disabled" ><spring:message code="column.fl_choice" /></button>
						</div>
					</td>
					<!-- 상단 노출 이미지 -->
					<th><spring:message code="column.vod.top.disp.img"/></th>
					<td>
						<div class="inner">
							<input type="hidden" id="topImgOrgPath" class="" name="topImgPath" value="" />
							<input type="hidden" id="topImgOrgNm" class="" name="topImgNm" value="" />
							<input type="hidden" id="topImgFlSz" class="" name="topImgFlSz" value="" />
							<img id="topImgPathView" name="topImgPathView" src="/images/noimage.png" class="thumb" alt="" />
						</div>
						<div class="inner ml10" style="vertical-align:middle">
							<!-- 파일선택 -->
							<button type="button" class="btn" onclick="imageType=2;fileUpload.image(resultImage);" ><spring:message code="column.fl_choice" /></button>
							<!-- 삭제 -->
							<button type="button" class="btn" onclick="deleteTopImage();" ><spring:message code="column.common.delete" /></button>
						</div>
					</td>
				</tr>
				<tr>
					<!-- 제목 -->
					<th><spring:message code="column.ttl"/><strong class="red">*</strong></th>
					<td colspan="3">
						<input type="text" name="ttl" id="ttl" class="w600 msg required noHash" value="" maxlength="50" title="<spring:message code="column.ttl"/>" />
						<span id="ttlMsgByteHtml">
							<span id="ttlMsgByte" style="color:#00B0F0;">&nbsp;0</span> / 50자
						 </span>
					</td>
				</tr>
				<tr>
					<!-- 내용 -->
					<th><spring:message code="column.contents"/><strong class="red">*</strong></th>
					<td colspan="3">
						<textarea class="w800 validate[required, maxSize[200]] msg required" style="float: left;" name="content" id="content" title="<spring:message code="column.contents"/>" rows="5" cols="70" maxlength="200" ></textarea>
						<div style="margin-top: 85px;">&nbsp;
							<span id="contentMsgByteHtml">
								<span id="contentMsgByte" style="color:#00B0F0;">&nbsp;0</span> / 200자
							 </span>
						</div>
					</td>
				</tr>
				<tr>
					<!-- 음악 저작권 -->
					<th><spring:message code="column.vod.music.copyright"/></strong></th>
					<td colspan="3">
						<%-- <textarea class="w800 validate[required, maxSize[500]] msg required" style="float: left;" name="crit" id="crit" title="<spring:message code="column.vod.music.copyright"/>" rows="5" cols="70" maxlength="500" ></textarea> --%>
						<textarea class="w800 validate[required, maxSize[1000]] msg" style="float: left;" name="crit" id="crit" title="<spring:message code="column.vod.music.copyright"/>" rows="5" cols="70" maxlength="1000" ></textarea>
						<div style="margin-top: 85px;">&nbsp;
							<span id="critMsgByteHtml">
								<span id="critMsgByte" style="color:#00B0F0;">&nbsp;0</span> / 1000자
							 </span>
						</div>
					</td>
				</tr>
				<tr>
					<!-- 태그 -->
					<input type="hidden" name="tags" id="sTags" class="required req2_input2" title="<spring:message code="column.vod.tag"/>" value="">
					<th><spring:message code="column.vod.tag"/><strong class="red">*</strong></th>
					<td colspan="3">
						<span id="vTags">
						</span>
						<button type="button" class="roundBtn" onclick="addTag();" >+ 추가</button>
					</td>
				</tr>
				<tr>
					<!-- 컨텐츠 타입 -->
					<th><spring:message code="column.vd_tp"/><strong class="red">*</strong></th>
					<td colspan="3">
						<frame:radio name="vdTpCd" grpCd="${adminConstants.VD_TP }" />
					</td>
				</tr>
				<tr id="goodsMapTr" style="display: none">
					<!-- 상품 연동 -->
					<th><spring:message code="column.vod.good.map"/></th>
					<td colspan="3">
						<button type="button" class="roundBtn" style="margin:5px 0px 7px 0px;" onclick="addGoods();" >+ 관련 상품 불러오기</button>
						<div class="mModule no_m" style="width: 98%">
							<table id="vodGoodsList" ></table>
						</div>
					</td>
				</tr>
			</tbody>
		</table>
		<input type="hidden" id="thumVodOrgPath" name="thumVodPath" value="" />
		<input type="hidden" id="thumVodOrgNm" name="thumVodNm" value="" />
		<input type="hidden" id="thumVodFlSz" name="thumVodFlSz" value="" />
		<input type="hidden" id="paths" name="paths" value="" />
		<input type="hidden" id="names" name="names" value="" />
		<input type="hidden" id="flSzs" name="flSzs" value="" />
		<input type="hidden" id="vdLnthArr" name="vdLnthArr" value="" />
		<input type="hidden" id="vodSaveChk" value="" />
		<br/>
		<br/>
	</form>
		<div class="btn_area_center">
			<button type="button" onclick="vodInsert();" class="btn" style="background-color: #0066CC;">등록</button>
			<button type="button" onclick="closeTab();" class="btn btn-cancel">취소</button>
		</div>

	</t:putAttribute>
</t:insertDefinition>
