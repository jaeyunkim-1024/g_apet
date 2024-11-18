<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">
			$(document).ready(function(){
				newSetCommonDatePickerEvent('#sysRegDtmStart','#sysRegDtmEnd');
				searchDateChange();
				createVodGrid();
				
				//엔터키	
				$(document).on("keydown","#eduContsSearchForm input",function(){
	    			if ( window.event.keyCode == 13 ) {
	    				reloadEduContsGrid('');
	  		  		}
	            });
			});

			// 교육 영상 목록 리스트
			var rIndex = 0;
			function createVodGrid(){
				var options = {
					url : "<spring:url value='/contents/eduContsListGrid.do' />"
					, height : 400
					, searchParam : $("#eduContsSearchForm").serializeJson()
					, sortname : 'sysRegDtm'
					, sortorder : 'DESC'
					, multiselect : true
					, colModels : [
						  {name:"rowIndex", label:'<spring:message code="column.no" />', width:"80", align:"center", sortable:false, formatter: function(cellvalue, options, rowObject){
								let nTotalCnt = $("#eduContsList").getGridParam("records");
								let nPage = $('#eduContsList').jqGrid('getGridParam', 'page');
								let nRows = $('#eduContsList').jqGrid('getGridParam', 'rowNum');
								let No = nTotalCnt - ( nPage-1 )*nRows - (rIndex++);
								return No;
						  	}
						  }
						  /* 교육 Id */
						, {name:"vdId", label:'<spring:message code="column.educonts_vdId" />', width:"150", align:"center", sortable:false}
						  /* 썸네일 이미지 */
						, {name:"thumPath", label:'<spring:message code="column.thum_img_path" />', width:"120", align:"center", sortable:false, formatter: function(cellvalue, options, rowObject) {
								if(rowObject.thumPath != "" && rowObject.thumPath != null) {
									var imgPath = rowObject.thumPath.indexOf('cdn.ntruss.com') > -1 ? rowObject.thumPath : '${frame:optImagePath("' + rowObject.thumPath + '", adminConstants.IMG_OPT_QRY_400)}';
									return '<img src='+imgPath+' style="width:100px; height:100px;" onError="this.src=\'/images/noimage.png\'"  />';
								} else {
									return '<img src="/images/noimage.png" style="width:100px; height:100px;" alt="NoImage" />';
								}
							}
						}
						  /* 제목  */
						, {name:"ttl", label:'<spring:message code="column.ttl" />', width:"300", align:"left", classes:'pointer vodTtlColor', sortable:false}						 
						  /* 스텝수 */
						, {name:"step", label:'<spring:message code="column.educonts_step" />', width:"80", align:"center", sortable:false, formatter: function(rowId, val, rawObject, cm) {
							return (rawObject.step == 0 )? "-":rawObject.step;
							}	
						}
						  /* 카테고리 */
						, {name:"category", label:'<spring:message code="column.educonts_category" />', width:"300", align:"center", sortable:false}
						  /* 난이도 */
						, {name:"lodCd", label:'<spring:message code="column.educonts_apet_lod" />', width:"80", align:"center", sortable:false, formatter:"select", editoptions:{value:"<frame:gridSelect grpCd='${adminConstants.APET_LOD }' showValue='false' />"}}
						  /* 공유수 */
						, {name:"shareCnt", label:'<spring:message code="column.vod.share_cnt" />', width:"80", align:"center", sortable:false} 
						  /* 조회수 */
						, {name:"hits", label:'<spring:message code="column.vod.hits" />', width:"110", align:"center", sortable:false}
						  /* 좋아요 */
						, {name:"likeCnt", label:'<spring:message code="column.vod.like" />', width:"80", align:"center", sortable:false}
						  /* 댓글수 */
// 						, {name:"replyCnt", label:'<spring:message code="column.vod.reply_cnt" />', width:"110", classes:'cursor_default', align:"center", sortable:false, formatter:'integer'}
						  /* 전시 */
						, {name:"dispYn", label:"<spring:message code='column.vod.disp' />", width:"60", align:"center", sortable:false, formatter:"select", editoptions:{value:"<frame:gridSelect grpCd='${adminConstants.DISP_STAT }' showValue='false' />" } }
						  /* 등록일(수정일) */
						, {name:"sysRegDtm", label:'<spring:message code="column.sys_reg_upd_dt" />', width:"145", align:"center", sortable:false, formatter: function(rowId, val, rawObject, cm) {
							return new Date(rawObject.sysRegDtm).format("yyyy-MM-dd HH:mm:ss") + '\r\n<p style="font-size:11px;">(' + new Date(rawObject.sysRegDtm).format("yyyy-MM-dd HH:mm:ss")+ ')</p>';
							}
						}
					]
					, onCellSelect : function (id, cellidx, cellvalue) {
						if(cellidx == 4) {
							//상세
							var vdId = $("#eduContsList").jqGrid ('getCell', id, 'vdId');
							eduContsDetsailView(vdId);							
						}
					}
					, loadComplete : function(data) {
						rIndex = 0;
					}
				};
				grid.create("eduContsList", options);
			}

			/* 날짜 변경 적용 */
			function searchDateChange() {
				var term = $("#checkOptDate").children("option:selected").val();
				if(term == "") {
					$("#sysRegDtmStart").val("");
					$("#sysRegDtmEnd").val("");
				} else if(term == "50") {
					setSearchDateThreeMonth("sysRegDtmStart","sysRegDtmEnd");
				} else {
					setSearchDate(term, "sysRegDtmStart", "sysRegDtmEnd");
				}
			}			
			
			/* 카테고리 컨트롤 */ 
			var eduCate = {
				petGbCd : function(obj){
					$(obj).nextAll().val("");
					$(obj).nextAll().attr("disabled", true);		
					$(obj).nextAll().addClass('readonly');
					if($(obj).val() != ""){
// 						let data = {
// 		                    	petGbCd : $("#petGbCd").val()
//                     	};
// 						eduCate.thisAjaxCall(data, $("#eudContsCtgLCd"));
						$("#eudContsCtgLCd").attr("disabled", false);
						$("#eudContsCtgLCd").removeClass('readonly');
					}
				},
				eudContsCtgLCd : function (obj) {
					$(obj).nextAll().val("");
					$(obj).nextAll().attr("disabled", true);
					$(obj).nextAll().addClass('readonly');
					if($(obj).val() != "" && $("#eudContsCtgLCd").val() != '${adminConstants.EUD_CONTS_CTG_L_20}'){
// 						let data = {
// 		                    	petGbCd : $("#petGbCd").val(),
// 		                    	eudContsCtgLCd : $("#eudContsCtgLCd").val()
// 		                    	};
// 						eduCate.thisAjaxCall(data, $("#eudContsCtgMCd"));	
						$("#eudContsCtgMCd").attr("disabled", false);
						$("#eudContsCtgMCd").removeClass('readonly');
					}
				},
				eudContsCtgMCd : function (obj) {
					$(obj).nextAll().val("");
					$(obj).nextAll().attr("disabled", true);		
					$(obj).nextAll().addClass('readonly');
					if($(obj).val() != ""){
// 						let data = {
// 								petGbCd : $("#petGbCd").val(),
// 		                    	eudContsCtgLCd : $("#eudContsCtgLCd").val(),
// 		                    	eudContsCtgMCd : $("#eudContsCtgMCd").val()
// 		                    	};
// 						eduCate.thisAjaxCall(data, $("#eudContsCtgSCd"));
						$("#eudContsCtgSCd").attr("disabled", false);
						$("#eudContsCtgSCd").removeClass('readonly');
					}
				},
				thisAjaxCall : function(data , nextObj) {
					var options = {
		                	url : "<spring:url value='/contents/getEduCategoryList.do' />"
		                    , data : data
		                    , callBack : function(result){
		                    	nextObj.html('<option value="" data-usrdfn1="">전체</option>');
		                    	if(result.length != 0){			            
		                    		let htmlString = "";
		                    		for(idx in result){
		                    			htmlString += '<option value="'+result[idx].dtlCd+'" data-usrdfn1="'+result[idx].usrdfn1+'" title="'+result[idx].dtlNm+'">'+result[idx].dtlNm+'</option>';
		                    		}
		                    		nextObj.append(htmlString);
		                    		nextObj.attr("disabled", false);
		                    		nextObj.removeClass('readonly');
		                    	}
		                    }
		                };
		            ajax.call(options);
				}				
			}
			
			/* 검색 */
			function reloadEduContsGrid(obj){
				compareDateAlert('sysRegDtmStart','sysRegDtmEnd','term');
				var sysRegDtmStartVal = $("#sysRegDtmStart").val();
				var sysRegDtmEndVal = $("#sysRegDtmEnd").val();
				
	    		var dispStrtDtm = $("#sysRegDtmStart").val().replace(/-/gi, "");
				var dispEndDtm = $("#sysRegDtmEnd").val().replace(/-/gi, "");
				var diffMonths = getDiffMonths(dispStrtDtm, dispEndDtm);
				var term = $("#checkOptDate").children("option:selected").val();								
				
				let options = {
					searchParam : $("#eduContsSearchForm").serializeJson()
				};
				if (obj != '') {
					options.sortname = obj.value;
				}
				if((sysRegDtmStartVal != "" && sysRegDtmEndVal != "") || (sysRegDtmStartVal == "" && sysRegDtmEndVal == "")){ // 시작날짜 종료날짜 둘다 있을 때 시작날짜 종료날짜 둘다 없을 때만 조회
					if(term == "50" || diffMonths <= 3){ 				//날짜 3개월 이상 차이 날때 조회 X term이 3개월일 때는 예외적 허용 예를들어 2월 28일과 5월 31일은 90일이 넘기때문
						grid.reload("eduContsList", options);
					}
				}
			}
			
			/* 초기화 버튼클릭 */
			function searchReset () {
				resetForm ("eduContsSearchForm");
				searchDateChange();
				$(".eudContsCategory").attr("disabled", true);
				$(".eudContsCategory").addClass('readonly');
				$("#eduContsSortOrder").val("${adminConstants.VOD_SORT_ORDER_10}");
			}
			
			/* 전시 상태 일괄 변경 */
			function batchUpdateDisp() {
				var dispGbCd = $("#dispGbCd").children("option:selected").val();
				if(dispGbCd == "" || dispGbCd == null){
					messager.alert("<spring:message code='column.vod.update.gb' />", "Info", "info");
					$("#dispGbCd").focus();
					return;
				}
				var grid = $("#eduContsList");
				var rowids = grid.jqGrid('getGridParam', 'selarrrow');
				if(rowids.length <= 0 ) {
					messager.alert("<spring:message code='column.vod.update.no_select' />", "Info", "info");
					return;
				}

				messager.confirm("<spring:message code='column.vod.confirm.batch_update' />",function(r){
					if(r){
						var vdIds = new Array();
						var grid = $("#eduContsList");
						var selectedIDs = grid.getGridParam ("selarrrow");

						for (var i = 0; i < selectedIDs.length; i++) {
							var vdId = grid.getCell(selectedIDs[i], 'vdId');
							vdIds.push (vdId );
						}

						var sendData = {
							  vdIds : vdIds
							, dispYn : dispGbCd
						};

						var options = {
							url : "<spring:url value='/contents/batchUpdateDisp.do' />"
							, data : sendData
							, callBack : function(data) {
								messager.alert("<spring:message code='column.common.edit.cnt.final_msg' arguments='" + data.updateCnt + "' />", "Info", "info", function(){
									reloadEduContsGrid('');
									$("#dispGbCd").val("");
								});
							}
						};
						ajax.call(options);
					}
				});				
			}			

			/* 교육용 컨텐츠 */
			function eduContsDetsailView(vdId) {
				addTab('교육용 컨텐츠 상세', '/contents/eduContsDetailView.do?vdId=' + vdId);
			}

			/* 교육용 컨텐츠 등록 */
			function insertEduConts() {
				addTab('교육용 컨텐츠 등록', '/contents/eduContsInsertView.do');
			}
		</script>
	</t:putAttribute>
	<t:putAttribute name="content">
		<div class="easyui-accordion search-accordion" data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect" style="width:100%">
			<div title="<spring:message code='admin.web.view.common.search' />" style="padding:10px">
				<form name="eduContsSearchForm" id="eduContsSearchForm" method="post">
					<table class="table_type1">
						<colgroup>
							<col width="150px"/>
							<col />
							<col width="150px"/>
							<col />
						</colgroup>
						<caption>정보 검색</caption>
						<tbody>
							<tr>
								<th scope="row" colspan="1"><spring:message code="column.sys_reg_dt" /></th>
								<!-- 기간(등록일) -->
								<td colspan="3">
									<frame:datepicker startDate="sysRegDtmStart" startValue="${frame:toDate('yyyy-MM-dd') }" endDate="sysRegDtmEnd" endValue="${frame:toDate('yyyy-MM-dd') }" /> 
									&nbsp;&nbsp; 
									<select id="checkOptDate" name="checkOptDate"	onchange="searchDateChange();">
										<frame:select grpCd="${adminConstants.SELECT_PERIOD }" selectKey="${adminConstants.SELECT_PERIOD_40 }"	defaultName="기간선택" />
									</select>
								</td>
							</tr>
							<tr>
								<!-- 카테고리 -->
								<th scope="row"><spring:message code="column.educonts_category" /></th>
								<td  colspan="3">
									<select id="petGbCd" name="petGbCd"	onchange="eduCate.petGbCd(this);" data-lvl="0">
										<frame:select grpCd="${adminConstants.PET_GB }" useYn="Y" defaultName="전체"/>
									</select>
									<select id="eudContsCtgLCd" name="eudContsCtgLCd" class="readonly eudContsCategory"	onchange="eduCate.eudContsCtgLCd(this);" disabled="disabled">
										<frame:select grpCd="${adminConstants.EUD_CONTS_CTG_L }" useYn="Y" defaultName="전체"/>
									</select>
									<select id="eudContsCtgMCd" name="eudContsCtgMCd" class="readonly eudContsCategory"	onchange="eduCate.eudContsCtgMCd(this);" disabled="disabled">
										<frame:select grpCd="${adminConstants.EUD_CONTS_CTG_M }" useYn="Y" defaultName="전체"/>
									</select>
									<select id="eudContsCtgSCd" name="eudContsCtgSCd" class="readonly eudContsCategory"	onchange="eduCate.eudContsCtgSCd(this);" disabled="disabled">
										<frame:select grpCd="${adminConstants.EUD_CONTS_CTG_S }" useYn="Y" defaultName="전체"/>
									</select>
<!-- 									<select id="eudContsCtgLCd" name="eudContsCtgLCd" onchange="eduCate.eudContsCtgLCd(this);" disabled="disabled"> -->
<!-- 										<option value="" data-usrdfn1="">전체</option> -->
<!-- 									</select> -->
<!-- 									<select id="eudContsCtgMCd" name="eudContsCtgMCd"	onchange="eduCate.eudContsCtgMCd(this);" disabled="disabled"> -->
<!-- 										<option value="" data-usrdfn1="">전체</option> -->
<!-- 									</select> -->
<!-- 									<select id="eudContsCtgSCd" name="eudContsCtgSCd"	onchange="eduCate.eudContsCtgSCd(this);" disabled="disabled"> -->
<!-- 										<option value="" data-usrdfn1="">전체</option> -->
<!-- 									</select> -->
								</td>								
							</tr>
							<tr>
								<!-- 난이도 -->
								<th scope="row"><spring:message code="column.educonts_apet_lod" /></th>
								<td>
									<frame:radio name="lodCd" grpCd="${adminConstants.APET_LOD }"  defaultName="전체"/>
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
					<button type="button" onclick="reloadEduContsGrid('');" class="btn btn-ok">검색</button>
					<button type="button" onclick="searchReset();" class="btn btn-cancel">초기화</button>
				</div>
			</div>
		</div>

		<div class="mModule">
			<div id="resultArea" style="text-align: right;">
				<select name="vodUpdateGb" id="dispGbCd" title="<spring:message code="column.comp_gb_cd" />">
					<frame:select grpCd="${adminConstants.DISP_STAT}" defaultName="선택"/>
				</select>
				<button type="button" onclick="batchUpdateDisp();" class="btn btn-add">일괄 변경</button>
				<button type="button" onclick="insertEduConts();" class="btn btn-add" style="background-color: #0066CC;">교육용 컨텐츠 등록</button>
				<select id="eduContsSortOrder" onchange="reloadEduContsGrid(this)" title="<spring:message code="column.sort_seq" />">
					<frame:select grpCd="${adminConstants.VOD_SORT_ORDER}"/>
				</select>
			</div>
			<table id="eduContsList"></table>
			<div id="eduContsListPage"></div>
		</div>
	</t:putAttribute>
</t:insertDefinition>