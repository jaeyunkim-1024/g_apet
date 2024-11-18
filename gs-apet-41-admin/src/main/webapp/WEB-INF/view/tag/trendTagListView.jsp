<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8"%>
<%@ page import="framework.common.enums.ImageGoodsSize" %>

<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">
		var displayCategory1;
		var displayCategory2;
		var isGridExists = false;
		$(document).ready(function() {
			searchDateChange();
			createTagBaseGrid();
            jQuery("#tagGrpNo").val("");
            createDisplayCategory(1,"0");
            $("[id^='dynamic']").hide();
        	//날짜선택시 selectbox 기간선택문구로 변경 
			newSetCommonDatePickerEvent("#sysRegDtmStart", "#sysRegDtmEnd"); 
            //엔터키 
            $(document).on("keydown","#tagBaseListForm input",function(){
    			if ( window.event.keyCode == 13 ) {
	    			searchTagBaseList('');
  		  		}
            });
		});
		// Tag 상세
		function viewTagBaseDetail (tagNo) {
			var options = {
					tagNo : tagNo
					
			}
			layerTagBaseDetail.create(options);
			
			/* var url = "/tag/tagBaseDetailView.do?tagNo=" + tagNo;
			
			addTab('Tag 상세 - ' + tagNo, url); */
		}

		// Tag Grid
		function createTagBaseGrid () {
			var gridOptions = {
				  url : "<spring:url value='/tag/tagTrendGrid.do' />"	
 				, height : 400
 				, sortname : 'trdTagNm'
				, sortorder : 'ASC'
				, searchParam : $("#tagBaseListForm").serializeJson()
				, colModels : [
					{ name : "rowIndex" , label : "No" , align : "center" , width : "50", sortable:false, hidden:true}
					, {name:"trdNo", label:'Trend Tag ID', width:'120', key: true, align:'center', sortable:false } 
					, {name:"trdTagNm", label:'Trend Tag 명', width:"180", align:"center", sortable:false} /* 사이트 명 */
					, {name:"tagNo", label:'<b><u><tt><spring:message code="column.tag_no" /></tt></u></b>', width:"150", align:"center", hidden:true} /* 사이트 명 */
					//, {name:"tagNm", label:'<b><u><tt><spring:message code="column.tag_nm" /></tt></u></b>', width:"300", align:"center", classes:'pointer fontbold'} /* 사이트 명 */
					// Tag 상세 보기
					, {name:"tagNm", label:'Tag', width:"300", align:"center", sortable:false, formatter: function(cellvalue, options, rowObject) {
						var tagListArr = rowObject.tagNm.split("|");
						var str ="";
						for(var i in tagListArr){
							var tagArr = tagListArr[i].split(",");
							if( str != "") str += ', ';
							str += '<a href="javascript:viewTagBaseDetail(\'' + tagArr[0] + '\')">'+ tagArr[1] + '</a>';
						}
						return str;
					}}
					, {name:"useDtm", label:'사용기간', width:"310", align:"center", sortable:false}
					//, {name:"useStrtDtm", label:'사용기간(from)', width:"150", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss", sortable:false}
					//, {name:"useEndDtm", label:'사용기간(to)', width:"150", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss", sortable:false}
					, {name:"useYn", label:'<spring:message code="column.stat" />', width:"60", align:"center", sortable:false}
                    , _GRID_COLUMNS.sysRegrNm
                    , _GRID_COLUMNS.sysRegDtm
                    //, _GRID_COLUMNS.sysUpdrNm
                    //, _GRID_COLUMNS.sysUpdDtm
	                ]
				, multiselect : true
				, onCellSelect : function (id, cellidx, cellvalue) {
					if(cellidx == 2) {
						var rowData = $("#tagBaseList").getRowData(id);
						viewTagBaseDetail(rowData.tagNo);
					}
				}
			}
			grid.create("tagBaseList", gridOptions);
			isGridExists = true;
		}

		// Tag 검색 조회
		function searchTagBaseList(obj) {
			//검색버튼 click이후에 alert창 띄우기 
			compareDateAlert("sysRegDtmStart", "sysRegDtmEnd", "term");
			
			if (! isGridExists) {
				createTagBaseGrid();
			}	
			
			$("#sort").val($("#tagSortOrder").children("option:selected").val());
						
			var options = {
				searchParam : $("#tagBaseListForm").serializeJson()
			};
								
			gridReload('sysRegDtmStart','sysRegDtmEnd','tagBaseList','term', options);
			
			//$('#tagUpdateGb').prop('selectedIndex',0);			
			var _tagUpdateGb = "N";
			if($("#useYn").children("option:selected").val() != "" && $("#useYn").children("option:selected").val() != null){
				_tagUpdateGb = $("#useYn").children("option:selected").val() == "Y"?"N":"Y";
				$('#tagUpdateGb').val(_tagUpdateGb);				
				$("[id^='dynamic']").hide();
				$("#dynamic"+$('#tagUpdateGb').val()).show();
				$("#dynamicExec").show();
			}else{
				$("[id^='dynamic']").hide();
			}
			
		}

		// 초기화 버튼클릭
		function searchReset () {
			resetForm ("tagBaseListForm");
			searchDateChange();
			searchTagBaseList('');
		}


		// Tag 등록
		function registTagTrend () {
			goUrl ("Trend Tag 등록", "<spring:url value='/tag/tagTrendInsertView.do' />");
		}

		// Tag 일괄 변경
		function batchUpdateTag() {
			var grid = $("#tagBaseList");
			var trdNos = new Array();			
			var passYN = true;
			
			var rowids  = grid.jqGrid('getGridParam', 'selarrrow');
			if(rowids.length <= 0 ) {
				messager.alert("<spring:message code='column.common.update.no_select' />", "Info", "info");
				return;
			}else{
				for (var i = 0; i < rowids.length; i++) {
					trdNos.push (rowids[i] );
				}
				var tagUpdateGb = $("#tagUpdateGb").val();//$("#tagUpdateGb").children("option:selected").val();
				var useYn;
				$.each(rowids, function(index){
					var useYn = grid.jqGrid('getRowData', rowids[index]).useYn;
					//alert("tagUpdateGb:"+tagUpdateGb+", useYn:"+useYn);
					if(useYn == tagUpdateGb){
						passYN = false;
					} else {
						passYN = true;
					}
				});
			}
			
			// 1개 라도 사용여부 변경할 것이 있는 경우만 처리.
			if(passYN){
				var sendData = {
						trdNos : trdNos
						, useYn : tagUpdateGb
					};	
				var url = "<spring:url value='/tag/tagTrendBatchUpdate.do' />";
				tagUpdateProc(sendData, url, "U");

			} else {
				messager.alert("<spring:message code='column.batch.stat_cd.no_obj' />", "Info", "info");
				return;
			}
		}
		
		
		// Tag 일괄 삭제
		function batchDeleteTag() {
			var grid = $("#tagBaseList");
			var trdNos = new Array();
			
			var rowids  = grid.jqGrid('getGridParam', 'selarrrow');
			if(rowids .length <= 0 ) {
				messager.alert("<spring:message code='column.common.delete.no_select' />", "Info", "info");
				return;
			}else{
				for (var i = 0; i < rowids.length; i++) {
					trdNos.push (rowids[i] );
				}
			}
			var sendData = {
					trdNos : trdNos
				};
			var url = "<spring:url value='/tag/tagTrendBatchDelete.do' />";
			tagUpdateProc(sendData, url, "D");
		}
		
		
		function tagUpdateProc(sendData, url, gb) {
			var msg = "<spring:message code='column.common.confirm.batch_update' />";
			if(gb == "D" ) msg = "<spring:message code='column.common.confirm.delete' />";
			
			messager.confirm(msg,function(r){
				if(r){
					var options = {
						url : url
						, data : sendData
						, callBack : function(data ) {
							var msg = "<spring:message code='column.common.edit.final_msg' arguments='" + data.updateCnt + "' />";
							if( gb == "D") msg = "<spring:message code='column.common.delete.final_msg' arguments='" + data.deleteCnt + "' />";
							messager.alert(msg, "Info", "info", function(){
								searchTagBaseList('');								
							});
						}
					};
					ajax.call(options);
				}
			});
		}

		// 등록일 변경
		function searchDateChange() {
			var term = $("#checkOptDate").children("option:selected").val();
			if(term == "") {
				$("#sysRegDtmStart").val("");
				$("#sysRegDtmEnd").val("");
			}else if(term == "50"){
				//3개월 기간조회시에만 호출하는 메소드
				setSearchDateThreeMonth("sysRegDtmStart", "sysRegDtmEnd");
			}else {
				setSearchDate(term, "sysRegDtmStart", "sysRegDtmEnd");
			}
		}

		// 엑셀 다운로드
		function trendTagExcelDownload(){
			var d = $("#tagBaseListForm").serializeJson();
			createFormSubmit( "trendTagExcelDownload", "/tag/trendTagExcelDownload.do", d );
		}


		// 전시카테고리 검색조건
		$(document).on("change", "#displayCategory1", function(e) {
			var displayCategory = $("#displayCategory1").val();
			jQuery("#tagGrpNo").val(displayCategory);
			displayCategory1 = displayCategory;
			createDisplayCategory(2, displayCategory);
		});

		// 전시카테고리 검색조건
		$(document).on("change", "#displayCategory2", function(e) {
			var displayCategory = $("#displayCategory2").val();

			if (displayCategory == "") {
				jQuery("#tagGrpNo").val(displayCategory1);
			} else {
				jQuery("#tagGrpNo").val(displayCategory);
				displayCategory2 = displayCategory;
			}

			createDisplayCategory(3, displayCategory);
		});

		// 전시카테고리 검색조건
		$(document).on("change", "#displayCategory3", function(e) {
			var displayCategory = $("#displayCategory3").val();

			if (displayCategory == "") {
				jQuery("#tagGrpNo").val(displayCategory2);
			} else {
				jQuery("#tagGrpNo").val(displayCategory);
			}
		});

		// 전시 카테고리 select 생성
		function createDisplayCategory(dispLvl, upGrpNo) {
			var selectCategory = "<option value='' selected='selected'>선택</option>";

			if (dispLvl == 0) {
				jQuery("#displayCategory" + (dispLvl+1)).html("");
				jQuery("#displayCategory" + (dispLvl+1)).append(selectCategory);
				jQuery("#displayCategory" + (dispLvl+2)).hide();
				jQuery("#displayCategory" + (dispLvl+3)).hide();
				jQuery("#tagGrpNo").val("");
			} else {
				jQuery("#displayCategory" + (dispLvl)).html("");
				jQuery("#displayCategory" + (dispLvl)).hide();
				jQuery("#displayCategory" + (dispLvl+1)).hide();
				jQuery("#displayCategory" + (dispLvl+2)).hide();

				if (dispLvl == 1) {
					jQuery("#displayCategory" + (dispLvl)).show();
				}

				if (upGrpNo != "") {

					var options = {
						url : "<spring:url value='/tag/listDisplayTagGroup.do' />"
						, data : {
							upGrpNo : upGrpNo
							, stat : "Y"
						}
						, callBack : function(result) {
							if (result.length > 0) {
			 					jQuery(result).each(function(i){
			 						selectCategory += "<option value='" + result[i].tagGrpNo + "'>" + result[i].grpNm + "</option>";
								});

								jQuery("#displayCategory" + (dispLvl)).show();
							}
							jQuery("#displayCategory" + (dispLvl)).append(selectCategory);
						}
					};

					ajax.call(options);
				}
			}
		}
		</script>
	</t:putAttribute>

	<t:putAttribute name="content">

		<div class="easyui-accordion search-accordion" data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect" style="width:100%">
			<div title="<spring:message code='admin.web.view.common.search' />" style="padding:10px">
				<form id="tagBaseListForm" name="tagBaseListForm" method="post">
					<input type="hidden" id="tagGrpNo" name="tagGrpNo" value="" />		
					<input type="hidden" id="sort" name="sort" value="trdTagNm" />				
					<table class="table_type1">
						<caption>정보 검색</caption>
						<tbody>
							<tr>
								<th scope="row">Trend Tag</th>
								<td>
									<input type="text" name="srchWord" id="srchWord" title="Tag" >
								</td>
								<th scope="row"><spring:message code="column.stat" /></th>
								<!-- T Tag 상태 -->
								<td>
									<select id="useYn" name="useYn">
									<frame:select grpCd="${adminConstants.USE_YN }" defaultName="전체" showValue="false" />
									</select>
								</td>
							</tr>
							<tr>
								<%-- <th scope="row"><spring:message code="column.sys_reg_dtm" /></th> --%>
								<th scope="row">태그 등록일</th>
								<!-- 기간 -->
								<td colspan="3"><frame:datepicker startDate="sysRegDtmStart" startValue="${frame:toDate('yyyy-MM-dd')}" endDate="sysRegDtmEnd" endValue="${frame:toDate('yyyy-MM-dd') }"/>
									&nbsp;&nbsp;
									<select id="checkOptDate" name="checkOptDate" onchange="searchDateChange();">
										<frame:select grpCd="${adminConstants.SELECT_PERIOD }" selectKey="${adminConstants.SELECT_PERIOD_40 }" defaultName="기간선택" />
									</select>
								</td>
							</tr>
						</tbody>
					</table>
				</form>
				
				<div class="btn_area_center">
					<button type="button" onclick="searchTagBaseList('');" class="btn btn-ok">조회</button>
					<button type="button" onclick="searchReset();" class="btn btn-cancel">초기화</button>
				</div>
			</div>
		</div>

		
		<div class="mModule">
			<div id="resultArea">				
				<button type="button" onclick="batchDeleteTag();" class="btn btn-cancel">Trend Tag 삭제</button>	
				<button type="button" onclick="registTagTrend();" class="btn btn-add" style="background-color: #0066CC;">+ Trend Tag 등록</button>	
				<select id="tagSortOrder" onchange="searchTagBaseList(this)" title="<spring:message code="column.sort_seq" />"    style="margin-right: 50px;">
					<frame:select grpCd="${adminConstants.TRD_TAG_SORT_ORDER}" selectKey="trdTagNm"/>
				</select>		
				<%-- <select id="tagUpdateGb" name="tagUpdateGb" >							
					<frame:select grpCd="${adminConstants.USE_YN }"/>
				</select> --%>
				<input type="hidden" id="tagUpdateGb" name="tagUpdateGb" />
				<button type="button" class="btn btn-cancel" id="dynamicY" disabled="disabled" style="cursor: default;"><frame:codeName grpCd="${adminConstants.USE_YN }" dtlCd="${adminConstants.USE_YN_Y }" /></button>
				<button type="button" class="btn btn-cancel" id="dynamicN" disabled="disabled" style="cursor: default;"><frame:codeName grpCd="${adminConstants.USE_YN }" dtlCd="${adminConstants.USE_YN_N }" /></button>
				<button type="button" onclick="batchUpdateTag();" id="dynamicExec" class="btn btn-add" style="background-color: #0066CC;">상태변경</button>				
				<button type="button" onclick="trendTagExcelDownload();" class="btn btn-add btn-excel right">엑셀 다운로드</button>
			</div>
			
			<table id="tagBaseList"></table>
			<div id="tagBaseListPage"></div>
		</div>
	</t:putAttribute>

</t:insertDefinition>