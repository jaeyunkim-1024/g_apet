<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8"%>
<%@ page import="framework.common.enums.ImageGoodsSize" %>

<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">
		var _popTitle = "";
		var _popUrl = "";
		var isGridExists = false;
		
		$(document).ready(function() {
			searchDateChange();
			createTagBaseGrid();
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
			var url = "/tag/tagBaseDetailView.do?tagNo=" + tagNo;
			
			addTab('Tag 상세 - ' + tagNo, url);
		}
		
		// Tag 등록
		function registTagBase (tagNm) {
			goUrl ("Tag 등록", "/tag/tagBaseInsertView.do?tagNm="+tagNm);
		}
		

		// Tag Grid
		function createTagBaseGrid () {
			var gridOptions = {
				  url : "<spring:url value='/tag/unmatchedTagBaseGrid.do' />"	
 				, height : 400
				, searchParam : $("#tagBaseListForm").serializeJson()
				, sortname : 'tagNm'
				, sortorder : 'DESC'
				, colModels : [
					//{ name : "rowIndex" , label : "No" , align : "center" , width : "50", hidden:true}
					  {name:"tagNo", label:'<spring:message code="column.tag_no" />', width:'200', key: true, align:'center', sortable:false, hidden:true } /* 태그번호 */
					, {name:"tagNm", label:'<spring:message code="column.tag_nmko" />', width:"300", align:"center", classes:'fontbold', sortable:false} /* 태그 명 */
					, {name:"rltCntsCnt", label:'<spring:message code="column.rlt_cnts_cnt" />', width:"150", align:"center", classes:'pointer', sortable:false } /* 관련영상수 */
					, {name:"rltLogCnt", label:'관련 로그 수', width:"150", align:"center", classes:'pointer', sortable:false } /* 관련로그수 */
					, {name:"rltGoodsCnt", label:'<spring:message code="column.rlt_goods_cnt" />', width:"150", align:"center", classes:'pointer', sortable:false } /* 관련상품수 */
					, {name:"nbrCnt", label:'등장 횟수', width:"150", align:"center", classes:'pointer', sortable:false }/* , formatter: function(cellvalue, options, rowObject) {
						var nbrCnt = rowObject.rltCntsCnt + rowObject.rltLogCnt + rowObject.rltGoodsCnt;
						return nbrCnt;
						} 
					}	 */
					, {name:"statCd", label:'<spring:message code="column.use_yn" />', width:"100", align:"center", sortable:false,  hidden:true} 
					, {name:"srcCd", label:'출처', width:"150", align:"center", sortable:false, formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.TAG_SRC}" />"}} /* 출처 */                    
                    , {name:"sysRegDtm",		label:"첫 등장일", 		width:"150", 	align:"center", sortable:false, formatter:gridFormat.date, dateformat:"yyyy.MM.dd"} /* 첫 등장일 */					
					, {name:"button", label:'등록', width:"200", align:"center", sortable:false
						, formatter: function(rowId, val, rawObject, cm) {
						var str = '<button type="button" onclick="viewTagBaseDetail(\'' + rawObject.tagNo + '\')" class="btn_h25_type1">등록</button>';
						return str;
					}}                    
	                ]
				, multiselect : false
				, onCellSelect : function (id, cellidx, cellvalue) {
					var rowData = $("#tagBaseList").getRowData(id);	
					if(cellidx == 2) {//영상
						viewNewTagRltListPop(id, rowData.tagNm, 'Conts');
					}else if(cellidx == 3) {//로그						
						viewNewTagRltListPop(id, rowData.tagNm, 'Log');
					}else if(cellidx == 4) {//상품						
						viewNewTagRltListPop(id, rowData.tagNm, 'Goods');
					}else if(cellidx == 5) {//등장횟수
						viewNewTagRltListPop(id, rowData.tagNm, 'Total');						
					}					
				}
			    , gridComplete : function() {
					$("#noData").remove();
					var grid = $("#tagBaseList").jqGrid('getRowData');
					if(grid.length <= 0) {
						var str = "";
						str += "<tr id='noData' role='row' class='jqgrow ui-row-ltr ui-widget-content'>";
						str += "	<td role='gridcell' colspan='9' style='text-align:center;'>조회결과가 없습니다.</td>";
						str += "</tr>"
							
						$("#tagBaseList.ui-jqgrid-btable").append(str);
					}
				}
			}
			grid.create("tagBaseList", gridOptions);
			isGridExists = true;
		}
		
		// Tag 검색 조회
		function searchTagBaseList (obj) {
			//검색버튼 click이후에 alert창 띄우기 
			compareDateAlert("sysRegDtmStart", "sysRegDtmEnd", "term");
			
			if (! isGridExists) {
				createTagBaseGrid();
			}
			$("#sort").val($("#tagSortOrder").children("option:selected").val());

			var options = {
				searchParam : $("#tagBaseListForm").serializeJson()
			};
			/* if (obj != '') {
				options.sortname = obj.value;
				if(obj.value == "tagNm" ) options.sortorder = 'ASC';
			} */
			gridReload('sysRegDtmStart','sysRegDtmEnd','tagBaseList','term', options);
		}

		// 초기화 버튼클릭
		function searchReset () {
			resetForm ("tagBaseListForm");
			searchDateChange();
			searchTagBaseList('');
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
		function unmatchedTagExcelDownload(){
			var d = $("#tagBaseListForm").serializeJson();						
			createFormSubmit( "unmatchedTagExcelDownload", "/tag/unmatchedTagExcelDownload.do", d );
		}
				 
		//kwj 추가개발 2021.04.19
		function viewNewTagRltListPop(tagNo, tagNm, gb) {			
			setLayerPopParam(gb);			
			var options = {
				url : _popUrl				
				, data : { tagNo : tagNo ,tagNm : tagNm }
				, dataType : "html"
				, callBack : function (data ) {
					var config = {
						id : "tagRlt"+gb+"Detail"
						, width : 830
						, height : 650
						, top : 50
						, title : _popTitle
						, body : data						
					}
					layer.create(config);					
				}
			}
			ajax.call(options );
		}
		
		function setLayerPopParam(gb){			 
			if(gb == 'Conts') {//영상
				_popTitle = '태그 관련 영상';				
				_popUrl = "<spring:url value='/tag/umTagContsLayerView.do' />";				
			}else if(gb == 'Log') {//로그						
				_popTitle = '태그 관련 로그';				
				_popUrl = "<spring:url value='/tag/umTagLogLayerView.do' />";				
			}else if(gb == 'Goods') {//상품						
				_popTitle = '태그 관련 상품';				
				_popUrl = "<spring:url value='/tag/umTagGoodsLayerView.do' />";				
			}else if(gb == 'Total') {//등장횟수
				_popTitle = "신조어 태그 등장 횟수";				
				_popUrl = "<spring:url value='/tag/umTagTotalLayerView.do' />";				
			}
		}
		

		</script>
	</t:putAttribute>

	<t:putAttribute name="content">

		<div class="easyui-accordion search-accordion" data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect" style="width:100%">
			<div title="<spring:message code='admin.web.view.common.search' />" style="padding:10px">
				<form id="tagBaseListForm" name="tagBaseListForm" method="post">
					<input type="hidden" id="sort" name="sort" value="tagNm" />	
					<table class="table_type1">
						<caption>정보 검색</caption>
						<tbody>
							<tr>
								<th scope="row">Tag</th>
								<td>
									<input type="text" name="srchWord" id="srchWord" title="Tag" >
								</td>
								<th scope="row">출처</th>
								<!-- 출처 -->
								<td>
									<select id="srcCd" name="srcCd">
									<frame:select grpCd="${adminConstants.TAG_SRC }" defaultName="전체" showValue="false" />
									</select>
								</td>
							</tr>
							<tr>
								<th scope="row">태그 등장일</th>
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
			<div class="mButton">
				<select id="tagSortOrder" onchange="searchTagBaseList(this)" title="<spring:message code="column.sort_seq" />">
					<frame:select grpCd="${adminConstants.TAG_SORT_ORDER}"/>
				</select>
				<div class="rightInner">						
					<button type="button" onclick="unmatchedTagExcelDownload();" class="btn btn-add btn-excel right">엑셀 다운로드</button>
				</div>
			</div>
			
			<table id="tagBaseList"></table>
			<div id="tagBaseListPage"></div>
		</div>
	</t:putAttribute>

</t:insertDefinition>