<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8"%>
<%@ page import="framework.common.enums.ImageGoodsSize" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<!-- 
//@TODO
1. CDN 확정 이후 이미지 path 변경
2. text maxlength 미확정
 -->	
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<style>
			th.ui-th-column div { white-space:normal !important; height:auto !important; }
		</style>
		<script type="text/javascript">		
		var isGridExists = false;		
		$(document).ready(function() {
			<c:if test ="${!empty seriesVO.srisNo }">				
				createSeasonGrid();         				
			</c:if>
		});
		$(document).on("keyup input", "#srisNm, #srisDscrt", function(e) {
			/* if($(this).attr("id") == "srisNm"){
				$(this).val($(this).val().replace("#",""));
			} */
			var inputLength = $(this).val().length;
			var maxLength = $(this).attr("maxlength");
			var obj = $(this).parent("td").find("span .txtCnt");
			
			var cnt = 0;
			for(var i = 0; i<inputLength; i++){
				cnt += 1;
			}
			obj.html(cnt);				
			if (cnt > maxLength) {
				$(this).val($(this).val().substring(0,maxLength));
				obj.html(maxLength);
			}	
		});
		
		// 시리즈관리 Grid
		function createSeasonGrid () {
			var _lebel = "<spring:message code='column.sys_reg_dt' /><br/>(<spring:message code='column.sys_upd_dt' />)";
			var gridOptions = {
				  url : "<spring:url value='/series/listSeason.do' />"	
 				, height : 400 				
				, searchParam : $("#seasonListForm").serializeJson()
				, colModels : [
					  {name:"sesnNo", 			label:'<spring:message code="column.sesn" />', 			width:"60", 	align:"center", sortable:false}/* 번호 */					
					, {name:"sesnImgPath",		label:'<spring:message code="column.img_path" />',		width:"150",	align:"center", sortable:false, classes:'pointer fontbold', formatter: function(cellvalue, options, rowObject) {
						if(rowObject.sesnImgPath != "" && rowObject.sesnImgPath != null) {
							//var imgPath = rowObject.sesnImgPath.indexOf('cdn.ntruss.com') > -1 ? rowObject.sesnImgPath : '/common/imageView.do?filePath=' + rowObject.sesnImgPath;
							var imgPath = rowObject.sesnImgPath.indexOf('cdn.ntruss.com') > -1 ? rowObject.sesnImgPath :  '${frame:optImagePath("' + rowObject.sesnImgPath + '",adminConstants.IMG_OPT_QRY_400)}';
							return '<img src='+imgPath+' style="width:100px; height:100px;" onError="this.src=\'/images/noimage.png\'" />';[]
						} else {
							return '<img src="/images/noimage.png" style="width:100px; height:100px;" alt="NoImage" />';
						}
						} /* 시즌이미지 */
					}
					, {name:"sesnNm", 			label:"<spring:message code='column.sesn_nm' />", 		width:"500", 	align:"left", sortable:false, classes:'pointer fontbold'} /* 시즌명 */
					, {name:"vdCnt", 			label:"<spring:message code='column.vod_cnt' />", 		width:"100", 	align:"center", sortable:false} /* 영상건수 */
					, {name:"dispYn", 			label:"<spring:message code='column.contsStat' />",  	align:"center", sortable:false
						, editable:true, edittype:'select', formatter:'select', editoptions : {value:"<frame:gridSelect grpCd='${adminConstants.DISP_STAT}' showValue='false' />"}} /* 전시 */					
					, _GRID_COLUMNS.sysRegrNm
					, {name:"sysRegDtm",		label:"<spring:message code='column.sys_reg_dt' />", 		width:"250", 	align:"center", sortable:false, formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm"} /* 등록일 */	                
	                , _GRID_COLUMNS.sysUpdrNm
	                , {name:"sysUpdDtm",		label:"<spring:message code='column.sys_upd_dt' />", 		width:"250", 	align:"center", sortable:false, formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm"} /* 수정일 */
	                , {name:"flNo", 			label:"", 							hidden:true,			width:"100", 	align:"center", sortable:false} /* 파일번호 */
	                					
	                ]

				, multiselect : true
				, rowNum : 20				
				, onCellSelect : function (id, cellidx, cellvalue) {
					if(cellidx == 2 || cellidx == 3) {						
						var rowData = $("#seasonList").getRowData(id);
						var sesnNo = rowData.sesnNo;						
						registSeason(sesnNo);
					} 
				}//sesn_info
				, gridComplete : function (){
					var totalCnt = $("#seasonList").getGridParam("records");
					if(totalCnt > 0){						
						$("#sesn_info").hide();
						$(".mModule").show();
						jQuery("#seasonList").jqGrid( 'setGridWidth', $(".box").width() );
					}else{
						$(".mModule").hide();
						$("#sesn_info").show();						
					}
					$("#seasonListPage .ui-pg-selbox").hide();
				} 
			}
			grid.create("seasonList", gridOptions);
			isGridExists = true;
		}
	
		// 시리즈 등록
		function goBack() {
			updateTab('/series/seriesListView.do','시리즈 관리');
		}
		
		// 파일 찾기
		function imageUploadPrfl () {			
			// 파일 추가
			fileUpload.image(resultImage);
		}
		
		// 이미지 업로드 결과
		function resultImage(file) {
			var gb = $("#imgGb").val();
			var addHtml = "";
			addHtml += "<li id='fileArea_"+gb+"'>\n";
			addHtml += "<span class='file' id='file_name_"+gb+"' ></span>\n";
			addHtml += "<span class='bytes' id='file_bytes_"+gb+"' style='display:none'></span>\n";
			//addHtml += "<a href='#' class='btn_delete' onclick='deleteImage(\""+gb+"\"); return false;'>삭제</a>";
			addHtml += "<input type='hidden' name='phyPaths' id='phyPath_"+gb+"' title='<spring:message code='column.phy_path'/>' value=''>\n";
			addHtml += "<input type='hidden' name='flSzs' id='flSz_"+gb+"' title='<spring:message code='column.fl_sz'/>' value=''>\n";
			addHtml += "<input type='hidden' name='orgFlNms' id='orgFlNm_"+gb+"' title='<spring:message code='column.org_fl_nm'/>' value='' />\n";
			addHtml += "<input type='hidden' name='imgGbs' id='imgGbs_"+gb+"' title='<spring:message code='column.org_fl_nm'/>' value='' />\n";
			addHtml += "<input type='hidden' name='flModYns' id='flModYns_"+gb+"'  value='' />\n";
			addHtml += "</li>";
			//flModYns
			if($("#imgGb").val() == "srisProfile"){
				$("#profile_file_list").find("li").remove();
				$("#profile_file_list").append(addHtml);
				$("#profileImgPathView").show();
				$("#profileImgPathView").attr('src', '/common/imageView.do?filePath=' + file.filePath );
			}else if($("#imgGb").val() == "srisImg"){
				$("#img_file_list").find("li").remove();
				$("#img_file_list").append(addHtml);
				$("#srisImgPathView").show();
				$("#srisImgPathView").attr('src', '/common/imageView.do?filePath=' + file.filePath );
			}else{
				$("#sesn_img_file_list").find("li").remove();
				$("#sesn_img_file_list").append(addHtml);
				$("#sesnImgPathView").show();
				$("#sesnImgPathView").attr('src', '/common/imageView.do?filePath=' + file.filePath );
			}	
			
			$("#file_name_"+gb).text(file.fileName);
			$("#file_bytes_"+gb).text(Math.floor(file.fileSize / 1024) + " KB");
			
			$("#orgFlNm_"+gb).val(file.fileName);// 원 파일 명
			$("#phyPath_"+gb).val(file.filePath);// 물리 경로
			$("#flSz_"+gb).val(file.fileSize);	// 파일 크기
			$("#imgGbs_"+gb).val($("#imgGb").val());	// 이미지구분
			$("#flModYns_"+gb).val("Y");	// 파일 수정여부
			$("#flModYn").val("Y");
			
		}
		
		// 첨부 파일 삭제
		function deleteImage (gb) {
			
			$("#file_name_"+gb).text("");
			$("#file_bytes_"+gb).text("");
			
			$("#orgFlNm_"+gb).val("");
			$("#phyPath_"+gb).val("");
			$("#flSz_"+gb).val("");
			$("#file_name_"+gb).closest("td").find("img").attr('src', '/images/noimage.png' );
			
			$("#fileArea_"+gb).remove();
		}
		
		function changeImgGb(imgGb){
			$("#imgGb").val(imgGb);
		}
		//시리즈 등록/수정
		function updateSeriesList(){
			if(inquiryValidate.sries()){
				var sTags = new Array();
				$(".synSelectedTag").each(function(i, v){
					sTags.push(v.id.split("_")[1]);
				})
				$("#tagNos").val(sTags);
				var options = {
						url : "<spring:url value='/series/updateSeries.do' />",
						data : $("#seriesListForm").serialize(),
						callBack : function(data ) {							
							var msg = "<spring:message code='column.display_view.message.save' />";
							if($("#srisNo").val() != "") msg = "<spring:message code='column.common.edit.final_msg' />";
							messager.alert(msg, "Info", "info", function(){
								updateTab('/series/seriesListView.do','시리즈 관리');
							});
						}
				};
		
				ajax.call(options);
			}
			
		}
		//시즌 등록/수정
		function updateSeason(){
			if(inquiryValidate.sesn()){
				var options = {
						url : "<spring:url value='/series/updateSeason.do' />",
						data : $("#seasonDetailForm").serialize()+"&srisNo="+$("#srisNo").val()+"&flModYn="+$("#flModYn").val(),
						callBack : function(data ) {
							var msg = "<spring:message code='column.display_view.message.save' />";							
							if($("#sesnNo").val() != "") msg = "<spring:message code='column.common.edit.final_msg' />";
							
							messager.alert(msg, "Info", "info", function(){
								layer.close('seasonInsert');
								searchSeriesList();
							});
						}
				};
		
				ajax.call(options);
			}
			
		}
		
		var inquiryValidate = {
				sries : function(){
					var msg = "";
					if ($('#profile_file_list li[id^="fileArea_"]').length < 1) {
						msg = $('#profile_file_list').attr('title')+"을";						
						messager.alert( "<spring:message code='column.valid.reg.msg' arguments='" + msg + "' />" ,"Info","info");						
						return false;
					}
					if ($('#img_file_list li[id^="fileArea_"]').length < 1) {
						msg = $('#img_file_list').attr('title')+"를";
						messager.alert( "<spring:message code='column.valid.reg.msg' arguments='" + msg + "' />" ,"Info","info");					
						return false;
					}
					if($("#srisNm").val() == ""){		
						msg = $('#srisNm').attr('title')+"을";
						messager.alert( "<spring:message code='column.valid.input.msg' arguments='" + msg + "' />" ,"Info","info");	
						$("#srisNm").focus();
						return false;
					}
					if($("#srisDscrt").val() == ""){						
						msg = $('#srisDscrt').attr('title')+"을";
						messager.alert( "<spring:message code='column.valid.input.msg' arguments='" + msg + "' />" ,"Info","info");
						$("#srisDscrt").focus();
						return false;
					}
										
					return true;
				}
				, sesn : function(){
					if($("#sesnNm").val() == ""){	
						msg = $('#sesnNm').attr('title')+"을";						
						messager.alert( "<spring:message code='column.valid.reg.msg' arguments='" + msg + "' />" ,"Info","info");							
						$("#sesnNm").focus();
						return false;
					}
					if ($('#sesn_img_file_list li[id^="fileArea_"]').length < 1) {		
						msg = $('#sesn_img_file_list').attr('title')+"를";
						messager.alert( "<spring:message code='column.valid.reg.msg' arguments='" + msg + "' />" ,"Info","info");						
						return false;
					}
					if($("#sesnDscrt").val() == ""){	
						msg = $('#sesnDscrt').attr('title')+"을";						
						messager.alert( "<spring:message code='column.valid.input.msg' arguments='" + msg + "' />" ,"Info","info");
						$("#sesnDscrt").focus();
						return false;
					}
					return true;
				}
			};
		//시즌추가		
		function registSeason(sesnNo) {

			var titles = "시즌 관리";
			var options = {
				url : "<spring:url value='/series/popupSeasonInsert.do' />"
				, data :  {  sesnNo : sesnNo, srisNo : $("#srisNo").val() }
				, dataType : "html"
				, callBack : function (data ) {
					var config = {
						id : "seasonInsert"
						, width : 700
						, height : 520
						, top : 200
						, title : titles
						, body : data
						, button : "<button type=\"button\" onclick=\"updateSeason();\" class=\"btn btn-ok\">저장</button>"
					}
					layer.create(config);
				}
			}
			ajax.call(options );
		}
		// 시즌 전시상태 일괄 변경 step1
		function batchUpdateSeasonStat () {
			if($("#seasonStatUpdateGb option:selected").val() == "" || $("#seasonStatUpdateGb option:selected").val() == null){
				messager.alert("<spring:message code='column.common.petlog.update.gb' />", "Info", "info");
				$("#seasonStatUpdateGb").focus();
				return;
			}
			var grid = $("#seasonList");
			var rowids = grid.jqGrid('getGridParam', 'selarrrow');
			if(rowids.length <= 0 ) {
				messager.alert("<spring:message code='column.common.petlog.update.no_select' />", "Info", "info");
				return;
			}
			
			var seasonStatUpdateGb = $("#seasonStatUpdateGb").children("option:selected").val();
			seasonUpdateProc ();
			
		}
		//시즌 전시상태 일괄 수정 step2
		function seasonUpdateProc () {
			messager.confirm("<spring:message code='column.sesn.confirm.batch_update' />",function(r){
				if(r){
					var seasonStatUpdateGb = $("#seasonStatUpdateGb").children("option:selected").val();
					var sesnNos = new Array();	
					var flNos = new Array();
					var grid = $("#seasonList");
					var selectedIDs = grid.getGridParam ("selarrrow");
					
					for (var i = 0; i < selectedIDs.length; i++) {
						var sesnNo = grid.getCell(selectedIDs[i], 'sesnNo');
						var flNo =  grid.getCell(selectedIDs[i], 'flNo');
						sesnNos.push (sesnNo );		
						flNos.push (flNo );	
					}
					
					var sendData = {
						sesnNos : sesnNos
						, srisNo : $("#srisNo").val()
						, seasonStatUpdateGb:seasonStatUpdateGb
						, flNos : flNos
					};
							
					var options = {
						url : "<spring:url value='/series/updateSeasonStat.do' />"
						, data : sendData
						, callBack : function(data ) {
							messager.alert("<spring:message code='column.common.edit.final_msg' />", "Info", "info", function(){								
								$("#seasonStatUpdateGb").val("");
								searchSeriesList();
							});
						}
					};
					ajax.call(options);
				}
			});
		}
		
		// 검색 조회
		function searchSeriesList () {
			if (! isGridExists) {
				createSeasonGrid();
			}
			if(validate.check("seasonListForm")) {
				var options = {
					searchParam : $("#seasonListForm").serializeJson()
				};
				grid.reload("seasonList", options);
			}			
		}
		//태그추가
		
		// Tag 추가 팝업 : tagGb(동의어 - syn, 유의어 - rlt)
		function addTag(tagGb) {
			let selectedTags = $("."+tagGb+"SelectedTag");			
			if (selectedTags.length >= 10) {
				messager.alert("<spring:message code='admin.web.view.msg.vod.limit.tag' />", "Info", "info");
			} else {
				var options = {
						multiselect : true
						, callBack : function(result) {
							var check = true;
							var _msg = "";
							var _cnt = -1;
							var html = "";
							if(result != null && result.length > 0) {
								var message = new Array();
								var sTag = $("."+ tagGb + "SelectedTag");
								var selectedTagsPlus = selectedTags.length;
														
								for(var i in result){						
						
									var addData = {
										tagNo : result[i].tagNo
										, tagNm : result[i].tagNm
									}
																
									// 동의어 - syn, 유의어 - rlt
									sTag.each(function(i, v){
										var tagName = $("#"+v.id).attr('tag-nm');								
										if (tagName == addData.tagNm) {
											check = false;				
											_msg = "'"+addData.tagNm+"'";
											
											return false;
										} else {			
											check = true;									
										}
									})
									
									if(check) {	
										selectedTagsPlus++;
										if(selectedTagsPlus<11){
											html += '<span class="rcorners1 ' + tagGb + 'SelectedTag" tag-nm="' + addData.tagNm +'" id="'+ tagGb + '_' + addData.tagNo + '">' + addData.tagNm + '</span>' 
											+ '<img id="'+ tagGb + '_' + addData.tagNo + 'Delete" onclick="layerTagBaseList.deleteTag(\''+ tagGb + '_' + addData.tagNo + '\',\''+ addData.tagNm +'\')" class="tagDeleteBtn" src="/images/icon-header-close.svg" />';
										}										
										//$("#"+tagGb + "Tags").append (html);										
									} else {
										_cnt++;
										//message.push(result[i].tagNm + " 중복된 Tag 입니다.");								
									}
									
								}
								if(_cnt > -1){
									if(_cnt == 0){
										_msg += "<spring:message code='admin.web.view.msg.vod.dupl.tag' />";
									}else{
										_msg += " 외 " + _cnt + "건 " + "<spring:message code='admin.web.view.msg.vod.dupl.tag' />";
									}
									if (selectedTagsPlus < 11) {
										messager.alert(_msg, "Info", "info");										
									}
								}
								if (selectedTagsPlus < 11) {
									$("#"+tagGb + "Tags").append (html);	
								}else{
									messager.alert("<spring:message code='admin.web.view.msg.vod.limit.tag' />", "Info", "info");
								}
								/* if(message != null && message.length > 0) {
									messager.alert(message.join("<br/>"), "Info", "info");
								} */
							}
						}
					 }
					layerTagBaseList.create(options);
			}
			
		}
			
		function deleteTag(tagNo) {
			$("#"+ tagNo).remove();
			$("#"+ tagNo + "Delete").remove();
		}
		
		function vodFileNcpDownload(filePath, fileName){
			var data = {
				  filePath : filePath
				, fileName : fileName
				, imgYn	: 'Y'
			}
			createFormSubmit("fileDownload", "/common/fileDownloadResult.do", data);
		}
		
		function deleteSeason() {			
			var grid = $("#seasonList");
			var rowids = grid.jqGrid('getGridParam', 'selarrrow');
			if(rowids.length <= 0 ) {
				messager.alert("<spring:message code='column.sesn.no_select' />", "Info", "info");
				return;
			}
			
			messager.confirm("<spring:message code='column.sesn.confirm.delete' />",function(r){
				if(r){					
					var sesnNos = new Array();
					var grid = $("#seasonList");
					var selectedIDs = grid.getGridParam ("selarrrow");
					
					for (var i = 0; i < selectedIDs.length; i++) {
						var sesnNo = grid.getCell(selectedIDs[i], 'sesnNo');
						var vdCnt =  grid.getCell(selectedIDs[i], 'vdCnt');
						if(Number(vdCnt) > 0){
							messager.alert("<spring:message code='column.sris.check_vd' />", "Info", "info");
							return;
						}
						sesnNos.push (sesnNo );
					}
					
					var sendData = {
						sesnNos : sesnNos
						, srisNo : $("#srisNo").val()
					};
							
					var options = {
						url : "<spring:url value='/series/deleteSeason.do' />"
						, data : sendData
						, callBack : function(data ) {
							var result = data.deleteCnt;
							if(Number(result) > 0){
								messager.alert("삭제 되었습니다.", "Info", "info", function(){
									searchSeriesList();
								});
							}else{
								messager.alert("삭제 실패하였습니다.", "Info", "info");
							}	
						}
					};
					ajax.call(options);
				}
			});
			
		}

		</script>
	</t:putAttribute>

	<t:putAttribute name="content">
		<div class="mTitle">
			<h2>
			<c:if test ="${!empty seriesVO.srisNo }">
				<spring:message code='column.sris_info' />
			</c:if>
			<c:if test ="${empty seriesVO.srisNo }">
				<spring:message code='column.sris_reg' />
			</c:if>
			</h2>
		</div>
		<form id="seriesListForm" name="seriesListForm" method="post">	
			<input type = "hidden" name = "imgGb"   id = "imgGb"/>		
			<input type = "hidden" name = "flModYn" id = "flModYn" 	value = "N"/>	
			<input type = "hidden" name = "srisNo" 	id="srisNo"  	value="${seriesVO.srisNo}" />
			<input type = "hidden" name = "srisId"	id="srisId"  	value="${seriesVO.srisId}" />
			<input type = "hidden" name = "flNo" 	id="flNo"  		value="${seriesVO.flNo}" />					
			<input type = "hidden" name = "tagNos" 	id="tagNos"  	 />		
			<table class="table_type1">
				<caption>정보 검색</caption>
				<colgroup>
					<col style="width:20%;">							
					<col style="width:30%;">
					<col style="width:20%;">
					<col style="width:23%;">
					<col style="width:7%;">
				</colgroup>
				<tbody>
					<c:if test ="${!empty seriesVO.srisNo }">
					<tr>
						<th scope="row"><spring:message code="column.sris_id" /><strong class="red">*</strong></th>
						<!-- 시리즈id -->
						<td colspan = "4">
							<c:out value="${seriesVO.srisId}" />
							
						</td>								
					</tr>	
					</c:if>
					<tr>
						<th scope="row"><spring:message code="column.type" /><strong class="red">*</strong></th>
						<!-- 타입 -->
						<td colspan = "4">
							<frame:radio name="tpCd" grpCd="${adminConstants.APET_TP }" selectKey="${seriesVO.tpCd == null ? adminConstants.APET_TP_10 : seriesVO.tpCd}"  />						
						</td>								
					</tr>
					
					<tr>
						<th scope="row"><spring:message code="column.contsStat" /><strong class="red">*</strong></th>
						<!-- 전시여부 -->
						<td>
							<frame:radio name="dispYn" grpCd="${adminConstants.DISP_STAT }" selectKey="${seriesVO.dispYn == null ? adminConstants.DISP_YN_Y : seriesVO.dispYn}"  />								
						</td>		
						<th scope="row"><spring:message code="column.sris_ad_yn" /><strong class="red">*</strong></th>
						<!-- 광고노출여부-->
						<td colspan = "2">
							<frame:radio name="adYn" grpCd="${adminConstants.AD_YN }" selectKey="${seriesVO.adYn == null ? adminConstants.AD_YN_Y : seriesVO.adYn}"  />								
						</td>						
					</tr>
					<tr style ="height:100px">
						<th scope="row"><spring:message code="column.sris_profile" /><strong class="red">*</strong></th>	
						<!-- 시리즈 프로필 -->			
						<c:choose>
							<c:when test="${!empty seriesVO.srisNo }">
								<td>							
									<input type = "hidden" id = "srisPrflImgPath" value = "${seriesVO.srisPrflImgPath}"/>					
									<c:set var="srisPt" value="${frame:optImagePath(seriesVO.srisPrflImgPath,adminConstants.IMG_OPT_QRY_400)}" />
									<c:if test="${fn:indexOf(seriesVO.srisPrflImgPath, 'cdn.ntruss.com') > -1 }" >
									<c:set var="srisPt" value="${seriesVO.srisPrflImgPath}" />
									</c:if>												
									<img id="profileImgPathView" name="profileImgPathView" src="${srisPt}" onError="this.src='/images/noimage.png';"  class="thumb" alt="" style = "float:left"/>
									<div style = "float:left;padding:10px">
										<div id = "profile_file_list" title ="<spring:message code="column.sris_profile" />">
											<c:forEach items="${attachList}" var="item">										
												<c:if test = "${item.contsTpCd eq  '10'}" >
													<li id='fileArea_srisProfile'>
														<%-- <span class='file' id='file_name_srisProfile'>${item.orgFlNm }</span> --%>
														<span id='file_name_srisProfile' onclick="vodFileNcpDownload('${seriesVO.srisPrflImgPath}', '${item.orgFlNm}');" style="color: #0066CC;text-decoration: underline;font-size: 12px;cursor: pointer;">${item.orgFlNm }</span>
														<%-- <span class='bytes' id='file_bytes_srisProfile'>${item.flSz/1024-(item.flSz/1024%1) }KB</span>
														<a href='#' class='btn_delete' onclick='deleteImage("srisProfile"); return false;'>삭제</a> --%>
														<input type='hidden' name='phyPaths' id='phyPath_srisProfile' title='<spring:message code='column.phy_path'/>' value='${item.phyPath }'>
														<input type='hidden' name='flSzs' id='flSz_srisProfile' title='<spring:message code='column.fl_sz'/>' value='${item.flSz }'>
														<input type='hidden' name='orgFlNms' id='orgFlNm_srisProfile' title='<spring:message code='column.org_fl_nm'/>' value='${item.orgFlNm }' />
														<input type='hidden' name='imgGbs' id='imgGbs_srisProfile' title='<spring:message code='column.org_fl_nm'/>' value='srisProfile' />
														<input type='hidden' name='flModYns' id='flModYns_srisProfile'  value='N' />
													</li>
												</c:if>
											</c:forEach>
										</div>
										<button type="button" class="btn" onclick="javascript:changeImgGb('srisProfile');imageUploadPrfl();" style = "margin-top:5px;">
											<spring:message code="column.chg_file" />
										</button> <!-- 추가 -->
										<button type="button" class="btn" onclick="deleteImage('srisProfile'); return false;" style = "margin-top:5px;" >
											<spring:message code="column.common.delete" />
										</button>
									</div>
								</td>
							</c:when>
							<c:otherwise>
								<td>									
									<img id="profileImgPathView" name="profileImgPathView" src="/images/noimage.png" class="thumb" alt="" style = "display:none;float:left"/>									
									<div style = "float:left;padding:10px">
										<div id = "profile_file_list" title ="<spring:message code="column.sris_profile" />"></div>
										<button type="button" class="btn" onclick="javascript:changeImgGb('srisProfile');imageUploadPrfl();" style = "margin-top:5px;" >
											<spring:message code="column.choose_file" />
										</button> <!-- 추가 -->
									</div>									
								</td>
							</c:otherwise>
						</c:choose>		
						<th scope="row"><spring:message code="column.sris_img" /><strong class="red">*</strong></th>
						<!-- 시리즈 이미지 -->								
						<c:choose>
							<c:when test="${!empty seriesVO.srisNo }">
								<td colspan = "2">							
									<input type = "hidden" id = "srisImgPath" value = "${seriesVO.srisImgPath}"/>	
									<c:set var="srisImgPt" value="${frame:optImagePath(seriesVO.srisImgPath,adminConstants.IMG_OPT_QRY_420)}" />
									<c:if test="${fn:indexOf(seriesVO.srisImgPath, 'cdn.ntruss.com') > -1 }" >
									<c:set var="srisImgPt" value="${seriesVO.srisImgPath}" />
									</c:if>
									<img id="srisImgPathView" name="srisImgPathView" src="${srisImgPt}" onError="this.src='/images/noimage.png';"  class="thumb" alt="" style = "float:left"/>
									<div style = "float:left;padding:10px">
										<div id = "img_file_list" title = "<spring:message code="column.sris_img" />">
											<c:forEach items="${attachList}" var="item">										
												<c:if test = "${item.contsTpCd eq  '20'}" >
													<li id='fileArea_srisImg'>
														<%-- <span class='file' id='file_name_srisImg'>${item.orgFlNm }</span> --%>
														<span id='file_name_srisImg' onclick="vodFileNcpDownload('${seriesVO.srisImgPath}', '${item.orgFlNm}');" style="color: #0066CC;text-decoration: underline;font-size: 12px;cursor: pointer;">${item.orgFlNm }</span>
														<%-- <span class='bytes' id='file_bytes_srisImg'>${item.flSz/1024-(item.flSz/1024%1) }KB</span>
														<a href='#' class='btn_delete' onclick='deleteImage("srisImg"); return false;'>삭제</a> --%>
														<input type='hidden' name='phyPaths' id='phyPath_srisImg' title='<spring:message code='column.phy_path'/>' value='${item.phyPath }'>
														<input type='hidden' name='flSzs' id='flSz_srisImg' title='<spring:message code='column.fl_sz'/>' value='${item.flSz }'>
														<input type='hidden' name='orgFlNms' id='orgFlNm_srisImg' title='<spring:message code='column.org_fl_nm'/>' value='${item.orgFlNm }' />
														<input type='hidden' name='imgGbs' id='imgGbs_srisImg' title='<spring:message code='column.org_fl_nm'/>' value='srisImg' />
														<input type='hidden' name='flModYns' id='flModYns_srisImg'  value='N' />
													</li>
												</c:if>
											</c:forEach>
										</div>
										<button type="button" class="btn" onclick="javascript:changeImgGb('srisImg');imageUploadPrfl();" style = "margin-top:5px;" >
											<spring:message code="column.chg_file" />
										</button> <!-- 추가 -->
										<button type="button" class="btn" onclick="deleteImage('srisImg'); return false;" style = "margin-top:5px;" >
											<spring:message code="column.common.delete" />
										</button>
									</div>
								</td>
							</c:when>
							<c:otherwise>
								<td colspan = "2">
									<img id="srisImgPathView" name="srisImgPathView" src="/images/noimage.png" class="thumb" alt="" style = "display:none;float:left"/>
									<div style = "float:left;padding:10px">
										<div id = "img_file_list" title = "<spring:message code="column.sris_img" />"></div>									
										<button type="button" class="btn" onclick="javascript:changeImgGb('srisImg');imageUploadPrfl();" style = "margin-top:5px;" >
											<spring:message code="column.choose_file" />
										</button> <!-- 추가 -->
									</div>
								</td>
							</c:otherwise>
						</c:choose>	
					</tr>
					<tr>
						<th scope="row"><spring:message code="column.sris_nm" /><strong class="red">*</strong></th>
						<!-- 시리즈명 -->
						<td colspan = "4">									
							<input type="text" class = "noHash w500" name="srisNm" id="srisNm" title="<spring:message code="column.sris_nm" />" value="${fn:escapeXml(seriesVO.srisNm) }" maxlength="20" />&nbsp;&nbsp;&nbsp;
							<span>
								<span class = "txtCnt" style ="color:#0066CC"><c:out value="${fn:length(seriesVO.srisNm)}" /> </span> / 20자
							</span>
						</td>												
					</tr>
					<tr>
						<th scope="row"><spring:message code="column.sris_dscrt" /><strong class="red">*</strong></th>
						<!-- 시리즈설명 -->
						<td colspan = "4">							
							<textarea class="textarea" id="srisDscrt" name="srisDscrt" title="<spring:message code="column.sris_dscrt" />" style="width:590px;height:110px;" maxlength="200">${seriesVO.srisDscrt}</textarea>&nbsp;&nbsp;&nbsp;							
							<span style = "vertical-align: bottom;">
								<span class = "txtCnt" style ="color:#0066CC"><c:out value="${fn:length(fn:replace(seriesVO.srisDscrt, newLine, ''))}" /> </span> / 200자
							</span>
						</td>												
					</tr>
					<tr>
						<th scope="row"><spring:message code="column.tag" /></th>
						<!-- 태그 -->
						<td colspan = "4">	
							<span id="synTags">								
								<c:forEach items="${tagList}" var="item">	
									<span class="rcorners1 synSelectedTag" tag-nm="${item.tagNm }" id="syn_${item.tagNo }">${item.tagNm }</span>
									<img id="syn_${item.tagNo }Delete" onclick="layerTagBaseList.deleteTag('syn_${item.tagNo }','${item.tagNm }')" class="tagDeleteBtn" src="/images/icon-header-close.svg" />
								</c:forEach>
							</span>					
							<button type="button" class="roundBtn" onclick="javascript:addTag('syn');" style = "border-radius:10px;">
								+<spring:message code="column.common.addition" />
							</button>
						</td>								
					</tr>
										
				</tbody>
			</table>					
		</form>
		
		<div class="btn_area_center">
			<button type="button" onclick="updateSeriesList();" class="btn" style = "background-color: #0066CC;"><c:out value="${empty seriesVO.srisNo?'등록':'수정'}" /></button>
			<button type="button" onclick="goBack();" class="btn"><c:out value="${empty seriesVO.srisNo?'취소':'목록'}" /></button>
		</div>
		
		
		<div id = "sesn_info" style = 'display:none'>
			<div class="panel-title"><spring:message code='column.sesn_info' /></div>		
			
			<div style = "border:1px solid #dadada; background:#f2f2f2; height:75px;border-radius:10px;text-align:center;">
				<div style = "margin-top:15px;"><b>아직 등록된 시즌 정보가 없습니다.</b></div>
				<div style = "margin-top:3px;">					
					<button type="button" onclick="registSeason();" class="btn btn-add" style = "background-color: #0066CC;">+ 시즌 추가</button>
					<span>버튼을 클릭하여 시즌을 등록해 주세요.</span>
				</div>
			</div>
		</div>
		<div class="mModule" style = 'display:none;margin-top:0px;'>			
			<div class="mTitle mt30" style = "margin-bottom:0px;">
				<h2><spring:message code='column.sesn_info' /></h2>
				<div class="buttonArea">
					<button type="button" onclick="deleteSeason();" class="btn btn-ok">시즌 삭제</button>
					<button type="button" onclick="registSeason();" class="btn btn-add" style = "background-color: #0066CC;">+ 시즌 추가</button>
				</div>
			</div>
			<div class="box">
				<table id="seasonList"></table>
				<div id="seasonListPage"></div>
			</div>
			<form id="seasonListForm" name="seasonListForm" method="post">
				<input type="hidden" name="srisNo" title="시리즈ID" value="${seriesVO.srisNo}" /> 
				<div style = "border:1px solid #dadada; background:#f2f2f2; height:40px;text-align:center; padding-top:8px">				
					<div style = "margin-top:3px;">
						<span>선택항목 전시 변경</span>					
						<select id="seasonStatUpdateGb" name="seasonStatUpdateGb" >							
							<frame:select grpCd="${adminConstants.DISP_STAT }" defaultName="선택" />
						</select>
						<button type="button" onclick="batchUpdateSeasonStat();" class="btn btn-add" >적용</button>
					</div>
				</div>
			</form>
		</div>
				
	</t:putAttribute>

</t:insertDefinition>