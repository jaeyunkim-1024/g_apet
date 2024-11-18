<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8"%>
<%@ page import="framework.common.enums.ImageGoodsSize" %>

<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">
		var displayCategory1;
		var displayCategory2;
		var displayCategory3;
		var isGridExists = false;
		
		$(document).ready(function() {
			searchDateChange();
			createTagBaseGrid();
            jQuery("#tagGrpNo").val("");
            createDisplayCategory(1,"0");
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
			//var url = "/tag/tagBaseDetailLayerView.do?tagNo=" + tagNo + "&viewGb=" + '${adminConstants.VIEW_GB_POP}';
			
 			//addTab('Tag 상세 - ' + tagNo, url);
			
			var options = {
				tagNo : tagNo
			}
			
			layerTagBaseDetail.create(options);
		}

		// Tag Grid
		function createTagBaseGrid () {
			var gridOptions = {
				  url : "<spring:url value='/tag/tagBaseGrid.do' />"	
 				, height : 400
				, searchParam : $("#tagBaseListForm").serializeJson()
				, sortname : 'tagNm'
				, sortorder : 'DESC'
				, colModels : [
					/*{ name : "rowIndex" , label : "No." , align : "center" , width : "50"}
					,*/ {name:"tagNo", label:'<spring:message code="column.tag_no" />', width:'120', key: true, align:'center', sortable:false } /* 태그번호 */
					, {name:"tagNm", label:'<b><u><tt><spring:message code="column.tag_nmko" /></tt></u></b>', width:"150", align:"center", classes:'pointer fontbold', sortable:false} /* 사이트 명 */
					, {name:"grpNm", label:'<spring:message code="column.tag_grpko"/>', width:"300", align:"left", sortable:false } /* 사이트 명 */
 					, {name:"rltTagCnt", label:'<spring:message code="column.rlt_tag" />', width:"100", align:"center", sortable:false}
					//, {name:"tagGrpNo", label:'<spring:message code="column.up_grp_no" />', width:"100", align:"center", sortable:false}
					//, {name:"tagGrpCnt", label:'<spring:message code="column.up_grp_no" />', width:"100", align:"center", sortable:false}
					, {name:"rltCntsCnt", label:'<b><u><tt><spring:message code="column.rlt_cnts_cnt" /></tt></u></b>', width:"100", align:"center", classes:'pointer fontbold', sortable:false } /* 사이트 명 */
					, {name:"rltGoodsCnt", label:'<b><u><tt><spring:message code="column.rlt_goods_cnt" /></tt></u></b>', width:"100", align:"center", classes:'pointer fontbold', sortable:false } /* 사이트 명 */
					//, {name:"statCd", label:'<spring:message code="column.use_yn" />', width:"100", align:"center", sortable:false, formatter:"select", editoptions:{value:"<frame:gridSelect grpCd='${adminConstants.TAG_STAT }' showValue='false' />" } } /* 사이트 명 */
					, {name:"statCd", label:'상태', width:"100", align:"center", sortable:false, formatter:"select", editoptions:{value:"<frame:gridSelect grpCd='${adminConstants.TAG_STAT }' showValue='false' />" } } /* 사이트 명 */
                    , _GRID_COLUMNS.sysRegrNm
                    , {name:"sysRegDtm", label:"등록일", width:'150', align:'center', formatter:gridFormat.date, dateformat:"yyyy-MM-dd", sortable:false}
                    //, _GRID_COLUMNS.sysRegDtm
                    //, _GRID_COLUMNS.sysUpdrNm
                    //, _GRID_COLUMNS.sysUpdDtm
	                ]
				, multiselect : true
				, onCellSelect : function (id, cellidx, cellvalue) {
					var rowData = $("#tagBaseList").getRowData(id);	
					if(cellidx == 2) {
						viewTagBaseDetail(id);
					}else if(cellidx == 5) {
						viewTagRltListPop(id, rowData.tagNm, 'C');
					}else if(cellidx == 6) {
						viewTagRltListPop(id, rowData.tagNm, 'G');
					}
				}
				, gridComplete : function() {
					$("#noData").remove();
					var grid = $("#tagBaseList").jqGrid('getRowData');
					if(grid.length <= 0) {
						var str = "";
						str += "<tr id='noData' role='row' class='jqgrow ui-row-ltr ui-widget-content'>";
						str += "	<td role='gridcell' colspan='10' style='text-align:center;'>조회결과가 없습니다.</td>";
						str += "</tr>"
								
						$("#tagBaseList.ui-jqgrid-btable").append(str);
					}
				}
				/* , onSelectAll: function(id, status) {					
					if( status ){
						$("#batchTag").removeAttr("style")
					}else{
						$("#batchTag").css("display", "none");
					}
				}
				, onSelectRow : function(rowid, status, e) {
					var s = $("#tagBaseList").jqGrid('getGridParam', 'selarrrow');
					if(s.length > 0){
						$("#batchTag").removeAttr("style")
					}else{
						$("#batchTag").css("display", "none");
					}
				} */
				, beforeSelectRow : function(rowid, e){
					var $myGrid = $(this),
		        		i = $.jgrid.getCellIndex($(e.target).closest('td')[0]),
		        		cm = $myGrid.jqGrid('getGridParam', 'colModel');
		    		return (cm[i].name === 'cb');
				}
			}
			grid.create("tagBaseList", gridOptions);
			isGridExists = true;
		}
		
		
		// 관련 영상/상품 팝업 호출(gb:C-영상, G-상품)
		function viewTagRltListPop (tagNo, tagNm, gb) {
			var options = {
				tagNo : tagNo
				,tagNm : tagNm
			}
			
			if( gb == 'C') layerTagContentsList.create(options);
			else layerTagGoodsList.create(options);
		}

		// 조회
		function searchTagBaseList (obj) {
			//검색버튼 click이후에 alert창 띄우기 
			compareDateAlert("sysRegDtmStart", "sysRegDtmEnd", "term");
			
			if (! isGridExists) {
				createTagBaseGrid();
			}
			
			if($("#tagBaseListForm #statCd").val() == "Y") {
				$("#batchTag").show();
			}
			
			if($("#tagBaseListForm #statCd").val() == "N" || $("#tagBaseListForm #statCd").val() == "") {
				$("#batchTag").hide();
			}
			
			var options = {
				searchParam : $("#tagBaseListForm").serializeJson()
			};
			if (obj != '') {
				options.sortname = obj.value;
				if(obj.value == "tagNm" ) options.sortorder = 'DESC'; //No 역순으로 나와야되서 반대로 정렬
				else options.sortorder = 'ASC'; //No 역순으로 나와야되서 반대로 정렬
			}
			gridReload('sysRegDtmStart','sysRegDtmEnd','tagBaseList','term', options);
		}

		// 초기화 버튼클릭
		function searchReset () {
			resetForm ("tagBaseListForm");
			jQuery("#tagGrpNo").val("");
            createDisplayCategory(1,"0");
			searchDateChange();
			searchTagBaseList('');
		}


		// Tag 등록
		function registTagBase () {
			goUrl ("Tag 등록", "<spring:url value='/tag/tagBaseInsertView.do' />");
		}

		// Tag 일괄 변경
		function batchUpdateTag () {
			var grid = $("#tagBaseList");

			var rowids = grid.jqGrid('getGridParam', 'selarrrow');
			if(rowids.length <= 0 ) {
				messager.alert("<spring:message code='column.common.update.no_select' />", "Info", "info");
				return;
			}
			
			var goodsStatCd = 0;
			var passYN = true;
			if(rowids.length >= 1 ) {
				$.each(rowids, function(index){
					statCd = grid.jqGrid('getRowData', rowids[index]).statCd;
					if(statCd == "Y"){
						passYN = true;
					} else {
						passYN = false;
					}
				});
			}
			
			if(passYN){
				tagUpdateProc();
			} else {
				messager.alert("<spring:message code='column.batch.stat_cd.no_obj' />", "Info", "info");
				return;
			}
		}
		
		
		function tagUpdateProc() {
			messager.confirm("<spring:message code='column.common.confirm.batch_update' />",function(r){
				if(r){
					var tagNos = new Array();
					var grid = $("#tagBaseList");
					var selectedIDs = grid.getGridParam ("selarrrow");
					for (var i = 0; i < selectedIDs.length; i++) {
						tagNos.push (selectedIDs[i] );
					}
		
					var sendData = {
						  tagNos : tagNos
						, statCd : 'N'
					};					
		
					var options = {
						url : "<spring:url value='/tag/tagBatchUpdate.do' />"
						, data : sendData
						, callBack : function(data ) {
							messager.alert("<spring:message code='column.common.edit.final_msg' />", "Info", "info", function(){
								searchTagBaseList ('');
								
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
			} else {
				setSearchDate(term, "sysRegDtmStart", "sysRegDtmEnd");
			}
		}

		// 엑셀 다운로드
		function matchedTagExcelDownload(){
			var d = $("#tagBaseListForm").serializeJson();
			createFormSubmit( "matchedTagExcelDownload", "/tag/matchedTagExcelDownload.do", d );
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
				displayCategory3 = displayCategory;
			}

			createDisplayCategory(4, displayCategory);
		});

		// 전시카테고리 검색조건
		$(document).on("change", "#displayCategory4", function(e) {
			var displayCategory = $("#displayCategory4").val();

			if (displayCategory == "") {
				jQuery("#tagGrpNo").val(displayCategory3);
			} else {
				jQuery("#tagGrpNo").val(displayCategory);
			}
		});

		// 전시 카테고리 select 생성
		function createDisplayCategory(dispLvl, upGrpNo) {
			var selectCategory = "<option value='' selected='selected'>전체</option>";

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
					<table class="table_type1">
						<caption>정보 검색</caption>
						<tbody>
							<tr>
								<th scope="row">Tag</th>
								<td>
									<input type="text" name="srchWord" id="srchWord" title="Tag" >
								</td>
								<th scope="row">Tag Group 선택</th>
								<!-- 태그 그룹 -->
								<td>
								    <select name="displayCategory1" id="displayCategory1"></select>
								    <select name="displayCategory2" id="displayCategory2" style="display: none;"></select>
								    <select name="displayCategory3" id="displayCategory3" style="display: none;"></select>
							    	<select name="displayCategory4" id="displayCategory4" style="display: none;"></select>
								</td>
							</tr>
							<tr>
								<th scope="row">상태</th>
								<!-- Tag 상태 -->
								<td>
									<select id="statCd" name="statCd">
									<frame:select grpCd="${adminConstants.USE_YN }" defaultName="전체" showValue="false" />
									</select>
								</td>
								<th scope="row"><spring:message code="column.sys_reg_dtm" /></th>
								<!-- 기간 -->
								<td><frame:datepicker startDate="sysRegDtmStart" startValue="${frame:toDate('yyyy-MM-dd')}" endDate="sysRegDtmEnd" endValue="${frame:toDate('yyyy-MM-dd') }"/>
									&nbsp;&nbsp; 
									<select id="checkOptDate" name="checkOptDate"	onchange="searchDateChange();">
										<frame:select grpCd="${adminConstants.SELECT_PERIOD }" selectKey="${adminConstants.SELECT_PERIOD_40 }"	defaultName="기간선택" />
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
				<button type="button" onclick="registTagBase();" class="btn btn-add" style="background-color: #0066CC;">Tag 등록</button>	
				<select id="tagSortOrder" onchange="searchTagBaseList(this)" title="<spring:message code="column.sort_seq" />">
					<frame:select grpCd="${adminConstants.TAG_SORT_ORDER}"/>
				</select>
				<button type="button" id="batchTag" onclick="batchUpdateTag();" class="btn btn-add" style="display:none;">사용 중지</button>			
				<button type="button" onclick="matchedTagExcelDownload();" class="btn btn-add btn-excel right">엑셀 다운로드</button>
			</div>
			
			<table id="tagBaseList"></table>
			<div id="tagBaseListPage"></div>
		</div>
	</t:putAttribute>

</t:insertDefinition>