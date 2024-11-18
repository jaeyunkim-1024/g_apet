<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">
			let rIndex = 0;
			$(document).ready(function(){
				newSetCommonDatePickerEvent('#sysRegDtmStart','#sysRegDtmEnd');
				searchDateChange();
				createVodGrid();
				
				//엔터키 
				$(document).on("keydown","#vodSearchForm input",function(){
	    			if ( window.event.keyCode == 13 ) {
	    				reloadVodGrid('');
	  		  		}
	            });
			});

			// 영상 목록 리스트
			function createVodGrid(){
				let options = {
					url : "<spring:url value='/contents/vodListGrid.do' />"
					, height : 400
					, searchParam : $("#vodSearchForm").serializeJson()
					, sortname : 'sysRegDtm'
					, sortorder : 'DESC'
					, multiselect : true
					, colModels : [
						  /* {name:"rowIndex", label:'<spring:message code="column.no" />', width:"80", align:"center", classes:'cursor_default', sortable:false} */
						  {name:"rowIndex", label:'<spring:message code="column.no" />', width:"80", align:"center", classes:'cursor_default', sortable:false, formatter: function(cellvalue, options, rowObject){
								let nTotalCnt = $("#vodList").getGridParam("records");
								let nPage = $('#vodList').jqGrid('getGridParam', 'page');
								let nRows = $('#vodList').jqGrid('getGridParam', 'rowNum');
								let No = nTotalCnt - ( nPage-1 )*nRows - (rIndex);
								rIndex++;
								return No;
						  	}
						  }
						  /* 영상 Id */
						, {name:"vdId", label:'<spring:message code="column.vd_id" />', width:"150", align:"center", classes:'cursor_default', sortable:false}
						  /* 썸네일 이미지 */
						, {name:"thumPath", label:'<spring:message code="column.thum_img_path" />', width:"120", align:"center", sortable:false, formatter: function(cellvalue, options, rowObject) {
								if(rowObject.thumPath != "" && rowObject.thumPath != null) {
									//return '<img src="<frame:imgUrl />' + rowObject.thumPath + '" style="width:100px; height:100px;" alt="' + rowObject.thumPath + '" />';[]
									var imgPath = rowObject.thumPath.indexOf('cdn.ntruss.com') > -1 ? rowObject.thumPath : '${frame:optImagePath("' + rowObject.thumPath + '", adminConstants.IMG_OPT_QRY_400)}';
									return '<img src='+imgPath+' style="width:100px; height:100px;" onError="this.src=\'/images/noimage.png\'"  />';
								} else {
									return '<img src="/images/noimage.png" style="width:100px; height:100px;" alt="NoImage" />';
								}
							}
						}
						  /* 제목  */
						, {name:"ttl", label:'<spring:message code="column.ttl" />', width:"300", align:"left", classes:'pointer vodTtlColor', sortable:false}
						  /* 시리즈 */
						, {name:"srisNm", label:'<spring:message code="column.vod.series" />', width:"171", align:"left", classes:'cursor_default', sortable:false}
						  /* 시즌 */
						, {name:"sesnNm", label:'<spring:message code="column.vod.season" />', width:"100", align:"center", classes:'cursor_default', sortable:false}
						  /* 공유수 */
						, {name:"shareCnt", label:'<spring:message code="column.vod.share_cnt" />', width:"110", align:"center", classes:'cursor_default', sortable:false}
						  /* 조회수 */
						, {name:"hits", label:'<spring:message code="column.vod.hits" />', width:"110", align:"center", classes:'cursor_default', sortable:false, formatter:'integer'}
						  /* 좋아요 */
						, {name:"likeCnt", label:'<spring:message code="column.vod.like" />', width:"110", align:"center", classes:'cursor_default', sortable:false, formatter:'integer'}
						  /* 댓글수 */
						, {name:"replyCnt", label:'<spring:message code="column.vod.reply_cnt" />', width:"110", classes:'cursor_default', align:"center", sortable:false, formatter:'integer'}
						  /* 전시 */
						, {name:"dispYn", label:"<spring:message code='column.vod.disp' />", width:"60", align:"center", classes:'cursor_default', sortable:false, formatter:"select", editoptions:{value:"<frame:gridSelect grpCd='${adminConstants.DISP_STAT }' showValue='false' />" } }
						  /* 등록일(수정일) */
						, {name:"sysRegDtm", label:'<spring:message code="column.sys_reg_upd_dt" />', width:"145", align:"center", classes:'cursor_default', sortable:false, formatter: function(rowId, val, rawObject, cm) {
							return new Date(rawObject.sysRegDtm).format("yyyy-MM-dd HH:mm:ss") + '\r\n<p style="font-size:11px;">(' + new Date(rawObject.sysUpdDtm).format("yyyy-MM-dd HH:mm:ss")+ ')</p>';
							}
						}
					]
					, onCellSelect : function (id, cellidx, cellvalue) {
						if(cellidx == 4) {
							let vdId = $("#vodList").jqGrid ('getCell', id, 'vdId');
							vodView(vdId );
						}
					}
					, loadComplete : function(data) {
						rIndex = 0;
					}
				};
				grid.create("vodList", options);
			}

			/* 검색 */
			function reloadVodGrid(obj){
				
				compareDateAlert('sysRegDtmStart','sysRegDtmEnd','term');
				
				var sysRegDtmStartVal = $("#sysRegDtmStart").val();
				var sysRegDtmEndVal = $("#sysRegDtmEnd").val();
				
		    	var dispStrtDtm = $("#sysRegDtmStart").val().replace(/-/gi, "");
				var dispEndDtm = $("#sysRegDtmEnd").val().replace(/-/gi, "");
				var diffMonths = getDiffMonths(dispStrtDtm, dispEndDtm);
				var term = $("#checkOptDate").children("option:selected").val();
				
				if(validate.check("vodSearchForm")) {
					let options = {
						searchParam : $("#vodSearchForm").serializeJson()
					};
					if (obj != '') {
						options.sortname = obj.value;
					}

					console.log($("#vodSearchForm").serializeJson());
					
					if((sysRegDtmStartVal != "" && sysRegDtmEndVal != "") || (sysRegDtmStartVal == "" && sysRegDtmEndVal == "")){ // 시작날짜 종료날짜 둘다 있을 때 시작날짜 종료날짜 둘다 없을 때만 조회
						if(term == "50" || diffMonths <= 3){ 				//날짜 3개월 이상 차이 날때 조회 X term이 3개월일 때는 예외적 허용 예를들어 2월 28일과 5월 31일은 90일이 넘기때문
					grid.reload("vodList", options);
						}
					}
				}
			}

			/* 영상 상세 */
			function vodView(vdId) {
				addTab('영상 상세', '/contents/vodDetailView.do?vdId=' + vdId);
			}

			/* 영상 등록 */
			function registVod() {
				addTab('영상 등록', '/contents/vodInsertView.do');
			}

			// 초기화 버튼클릭
			function searchReset () {
				resetForm ("vodSearchForm");
				searchDateChange();
				$("#srisNo, #sesnNo").attr('disabled', 'true');
				$("#srisNo, #sesnNo").addClass('readonly');
				$("#vodSortOrder").val("${adminConstants.VOD_SORT_ORDER_10}");
			}

			// 전시상태 일괄 변경
			function batchUpdateDisp() {
				let dispGbCd = $("#dispGbCd").children("option:selected").val();
				if(dispGbCd == "" || dispGbCd == null){
					messager.alert("<spring:message code='column.vod.update.gb' />", "Info", "info");
					$("#dispGbCd").focus();
					return;
				}
				let grid = $("#vodList");
				let rowids = grid.jqGrid('getGridParam', 'selarrrow');
				if(rowids.length <= 0 ) {
					messager.alert("<spring:message code='column.vod.update.no_select' />", "Info", "info");
					return;
				}

				messager.confirm("<spring:message code='column.vod.confirm.batch_update' />",function(r){
					if(r){
						let vdIds = new Array();
						let grid = $("#vodList");
						let selectedIDs = grid.getGridParam ("selarrrow");

						for (let i = 0; i < selectedIDs.length; i++) {
							let vdId = grid.getCell(selectedIDs[i], 'vdId');
							vdIds.push (vdId );
						}

						let sendData = {
							  vdIds : vdIds
							, dispYn : dispGbCd
						};

						let options = {
							url : "<spring:url value='/contents/batchUpdateDisp.do' />"
							, data : sendData
							, callBack : function(data) {
								messager.alert("<spring:message code='column.common.edit.cnt.final_msg' arguments='" + data.updateCnt + "' />", "Info", "info", function(){
									reloadVodGrid('');
									$("#dispGbCd").val("");
								});
							}
						};
						ajax.call(options);
					}
				});
				
			}

			function searchDateChange() {
				let term = $("#checkOptDate").children("option:selected").val();
				if(term == "") {
					$("#sysRegDtmStart").val("");
					$("#sysRegDtmEnd").val("");
				} else if(term == "50") {
					setSearchDateThreeMonth("sysRegDtmStart","sysRegDtmEnd");
				} else {
					setSearchDate(term, "sysRegDtmStart", "sysRegDtmEnd");
				}
			}
			
			<%-- 시리즈 여부 변경 --%>
			$(document).on("change", "input[name=srisYn]", function(e) {
				if ($(this).val() == '${adminConstants.COMM_YN_Y}') {
					let optionSeries = "<option value='' selected='selected'>시리즈 전체</option>";
					let options = {
							url : "<spring:url value='/contents/listSeries.do' />"
							, callBack : function(result) {
								if (result.length > 0) {
									jQuery(result).each(function(i){
										optionSeries += "<option value='" + result[i].srisNo + "'>" + result[i].srisNm + "</option>";
									});
									$("#srisNo").html('');
									$("#srisNo").append(optionSeries);
									$("#srisNo").removeAttr('disabled');
									$("#srisNo").removeClass('readonly');
									$("#srisNo").addClass('required');
								} else {
									$("#srisNo, #sesnNo").attr('disabled', 'true');
									$("#srisNo, #sesnNo").addClass('readonly');
									$("#srisNo, #sesnNo").removeClass('required');
									$("#srisNo").html('');
									$("#srisNo").append(optionSeries);
								}
							}
						};
					ajax.call(options);
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
					let optionSeason = "<option value='' selected='selected'>시즌 전체</option>";
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

			// 엑셀 다운로드
			function fnVodListExcelDownload(){
				if(validate.check("vodSearchForm")) {
					createFormSubmit("vodListExcelDownload", "/contents/vodListExcelDownload.do", $("#vodSearchForm").serializeJson());
				}


			}
		</script>
	</t:putAttribute>
	<t:putAttribute name="content">
		<div class="easyui-accordion search-accordion" data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect" style="width:100%">
			<div title="<spring:message code='admin.web.view.common.search' />" style="padding:10px">
				<form name="vodSearchForm" id="vodSearchForm" method="post">
					<table class="table_type1">
						<caption>정보 검색</caption>
						<colgroup>
							<col width="150px"/>
							<col />
							<col width="150px"/>
							<col />
						</colgroup>
						<tbody>
							<tr>
								<th scope="row"><spring:message code="column.sys_reg_dt" /><strong class="red">*</strong></th>
								<!-- 기간(등록일) -->
								<td colspan="3">
									<frame:datepicker startDate="sysRegDtmStart" startValue="${frame:toDate('yyyy-MM-dd') }" endDate="sysRegDtmEnd" endValue="${frame:toDate('yyyy-MM-dd') }"/>
									&nbsp;&nbsp;
									<select id="checkOptDate" name="checkOptDate" onchange="searchDateChange();">
										<frame:select grpCd="${adminConstants.SELECT_PERIOD }" selectKey="${adminConstants.SELECT_PERIOD_40 }" defaultName="기간선택" />
									</select>
								</td>
								<%-- <!-- 컨텐츠 타입 -->
								<th scope="row"><spring:message code="column.vd_tp" /></th>
								<td>
									<frame:radio name="vdTpCd" grpCd="${adminConstants.VD_TP }" defaultName="전체" />
								</td> --%>
							</tr>
							<tr>
								<!-- 시리즈 여부 -->
								<th scope="row"><spring:message code="column.seriesYn" /></th>
								<td>
									<frame:radio name="srisYn" grpCd="${adminConstants.SERIES_YN }" defaultName="전체" excludeOption="${adminConstants.SERIES_YN_N }" />
									<select id="srisNo" name="srisNo" class="w300 readonly" title=<spring:message code="column.vod.series"/> disabled="disabled">
										<option value="">시리즈 전체</option>
									</select>
									<select id="sesnNo" name="sesnNo" class="readonly" title=<spring:message code="column.vod.season"/> disabled="disabled">
										<option value="">시즌 전체</option>
									</select>
								</td>
								<!-- 컨텐츠 타입 -->
								<th scope="row"><spring:message code="column.vd_tp" /></th>
								<td>
									<frame:radio name="vdTpCd" grpCd="${adminConstants.VD_TP }" defaultName="전체" />
								</td>
							</tr>
							<tr>
								<!-- 영상 ID -->
								<th scope="row"><spring:message code="column.vd_id" /></th>
								<td>
									<input type="text" name="vdId" id="vdId" class="w200" value="" maxlength="20" />
								</td>
								<!-- 전시 상태 -->
								<th scope="row"><spring:message code="column.disp_stat" /></th> 
								<td>
									<frame:radio name="dispYn" grpCd="${adminConstants.DISP_STAT }" defaultName="전체" />
								</td>
							</tr>
							<tr>
								<!-- 공유 건수 -->
								<th scope="row"><spring:message code="column.educonts_share_cnt" /></th>
								<td>
									<input type="text" class="inputTypeNum" name="shareFrom"> ~ <input type="text" class="inputTypeNum" name="shareTo"> 
								</td>
								<!-- 좋아요 건수 -->
								<th scope="row"><spring:message code="column.educonts_like_cnt" /></th> 
								<td>
									<input type="text" class="inputTypeNum" name="likeFrom"> ~ <input type="text" class="inputTypeNum" name="likeTo">
								</td>							
							</tr>
							<tr>
								<!-- 제목 -->
								<th scope="row"><spring:message code="column.ttl" /></th>
								<td colspan="3">
									<input type="text" name="ttl" id="ttl" class="w450" value="" maxlength="30" />
								</td>
							</tr>
						</tbody>
					</table>
				</form>
		
				<div class="btn_area_center">
					<button type="button" onclick="reloadVodGrid('');" class="btn btn-ok">검색</button>
					<button type="button" onclick="searchReset();" class="btn btn-cancel">초기화</button>
				</div>
			</div>
		</div>

		<div class="mModule">

			<div id="resultArea" style="text-align: right;">

				<div style="float: left; width: 20%; text-align: left">
					<button type="button" onclick="fnVodListExcelDownload();" class="btn btn-add btn-excel" id="excelDownBtn">
						<spring:message code="admin.web.view.common.button.download.excel"/>
					</button>
				</div>
					<select name="vodUpdateGb" id="dispGbCd" title="<spring:message code="column.comp_gb_cd" />">
						<frame:select grpCd="${adminConstants.DISP_STAT}" defaultName="선택"/>
					</select>
					<button type="button" onclick="batchUpdateDisp();" class="btn btn-add">일괄 변경</button>
					<button type="button" onclick="registVod();" class="btn btn-add" style="background-color: #0066CC;">영상 등록</button>
					<select id="vodSortOrder" onchange="reloadVodGrid(this)" title="<spring:message code="column.sort_seq" />">
						<frame:select grpCd="${adminConstants.VOD_SORT_ORDER}"/>
					</select>




			</div>
			<table id="vodList"></table>
			<div id="vodListPage"></div>
		</div>

	</t:putAttribute>
</t:insertDefinition>