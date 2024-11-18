<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
	<script type="text/javascript">
	    var cellRowspan; //cell rowspan 중복 체크
    	var cellRowspan1; //cell rowspan 중복 체크
    	
		$(document).ready(function() {
			cellRowspan={cellId:undefined, chkval:undefined}; //cell rowspan 중복 체크
    		cellRowspan1={cellId:undefined, chkval:undefined}; //cell rowspan 중복 체크
			var displayCategory1;
			var displayCategory2;
			jQuery("#popupDispClsfNo").val("");
			$('#categorySalesForm').on('reset', function(){
				setTimeout("createDisplayCategory(1, '${adminConstants.DISP_CLSF_10}')", 100);
			});
			
			createDisplayCategory(1, "${adminConstants.DISP_CLSF_10}");
			// 기간별 리스트 생성
			createCategorySalesSalesGrid();
		});

		// 전시카테고리 검색조건
		$(document).on("change", "#stIdCombo", function(e) {
			jQuery("#popupDispClsfNo").val("");
			createDisplayCategory(1, "${adminConstants.DISP_CLSF_10}");
		});

		// 전시카테고리 검색조건
		$(document).on("change", "#displayCategory1", function(e) {
			var displayCategory = $("#displayCategory1").val();
			jQuery("#popupDispClsfNo").val(displayCategory);
			displayCategory1 = displayCategory;
			createDisplayCategory(2, displayCategory);
		});

		// 전시카테고리 검색조건
		$(document).on("change", "#displayCategory2", function(e) {
			var displayCategory = $("#displayCategory2").val();
			
			if (displayCategory == "") {
				jQuery("#popupDispClsfNo").val(displayCategory1);
			} else {
				jQuery("#popupDispClsfNo").val(displayCategory);
				displayCategory2 = displayCategory;
			}
			
			createDisplayCategory(3, displayCategory);
		});

		// 전시카테고리 검색조건
		$(document).on("change", "#displayCategory3", function(e) {
			var displayCategory = $("#displayCategory3").val();
			
			if (displayCategory == "") {
				jQuery("#popupDispClsfNo").val(displayCategory2);
			} else {
				jQuery("#popupDispClsfNo").val(displayCategory);
			}
		});
		
		// 전시 카테고리 select 생성
		function createDisplayCategory(dispLvl, upDispClsfNo) {
			var selectCategory = "";
			var idIndex = 3 - dispLvl;
			for (i = 0; i <= idIndex; i++) {
				var category = document.getElementById("displayCategory" + (dispLvl+i));
				var categoryIdx = category.options.length;
				if (categoryIdx > 1) {
					for (j = categoryIdx-1; j > 0; j--) {
						category.remove(j);
					}
				}
			}
			
			if (upDispClsfNo != "" || dispLvl == 1) {
				var stId = $("#stIdCombo").val();
				
				var options = {
					url : "<spring:url value='/display/listDisplayCategory.do' />"
					, data : {
						stId : stId
						, dispLvl : dispLvl
						, upDispClsfNo : upDispClsfNo
						, dispClsfCd : "${adminConstants.DISP_CLSF_10 }"
						, dispYn : "${adminConstants.DISP_YN_Y }"
					}
					, callBack : function(result) {
						if (result.length > 0) {							
		 					jQuery(result).each(function(i){
		 						selectCategory += "<option value='" + result[i].dispClsfNo + "'>" + result[i].dispClsfNm + "</option>";
							});
						}
						jQuery("#displayCategory" + (dispLvl)).append(selectCategory);
					}
				};

				ajax.call(options);
			}
		}

		// 기간별 리스트
		function createCategorySalesSalesGrid() {
			var gridOptions = {
				url : "<spring:url value='/statistics/orderCategoryReportListGrid.do'/>"
				, datatype : 'local'
				, height : 500
				, searchParam : $("#categorySalesForm").serializeJson()
				, colModels : [
					// 대카테고리
					{name:"dispClsfNm1st", label:"<spring:message code='column.statistics.order_daily_report.1st_disp_clsf_nm' />", width:"200", align:"center", sortable:false, cellattr:dispClsfNm1st}
					// 중카테고리
					, {name:"dispClsfNm2nd", label:"<spring:message code='column.statistics.order_daily_report.2nd_disp_clsf_nm' />", width:"200", align:"center", sortable:false, cellattr:dispClsfNm2nd}
					// 소카테고리
					, {name:"dispClsfNm", label:"<spring:message code='column.statistics.order_daily_report.disp_clsf_nm' />", width:"200", align:"center", sortable:false, summaryType:'count', summaryTpl : '소계'}
					, {name:"ordQty", label:"<spring:message code='column.statistics.order_category_report.ord_qty' />", width:"120", align:"right", sortable:false, summaryType:"sum", formatter:'integer'}
					, {name:"ordAmt", label:"<spring:message code='column.statistics.order_category_report.ord_amt' />", width:"120", align:"right", sortable:false, summaryType:"sum", formatter:'integer'}
					, {name:"cncQty", label:"<spring:message code='column.statistics.order_category_report.cnc_qty' />", width:"120", align:"right", sortable:false, summaryType:"sum", formatter:'integer'}
					, {name:"cncAmt", label:"<spring:message code='column.statistics.order_category_report.cnc_amt' />", width:"120", align:"right", sortable:false, summaryType:"sum", formatter:'integer'}
					, {name:"rtnQty", label:"<spring:message code='column.statistics.order_category_report.rtn_qty' />", width:"120", align:"right", sortable:false, summaryType:"sum", formatter:'integer'}
					, {name:"rtnAmt", label:"<spring:message code='column.statistics.order_category_report.rtn_amt' />", width:"120", align:"right", sortable:false, summaryType:"sum", formatter:'integer'}
					, {name:"totAmt", label:"계", width:"100", align:"right", sortable:false, summaryType:"sum", formatter:'integer'}
				]
				, paging: false
	           	, grouping: true
	           	, groupField : ['dispClsfNm1st']
// 	       		, groupColumnShow : [true]
// 	       		, groupText : ['{0}']
	       		, groupCollapse : false
	    		, groupSummary : [true]
	    		, showSummaryOnHide: true
	    		, groupDataSorted : true
				, footerrow : true
				, userDataOnFooter : true
	            , gridComplete: function() {  /** 데이터 로딩시 함수 **/	                
	                var ordQty 	= $("#categorySalesList").jqGrid('getCol', 'ordQty', false, 'sum');
	                var ordAmt 	= $("#categorySalesList").jqGrid('getCol', 'ordAmt', false, 'sum');
	                var cncQty 	= $("#categorySalesList").jqGrid('getCol', 'cncQty', false, 'sum');
	                var cncAmt 	= $("#categorySalesList").jqGrid('getCol', 'cncAmt', false, 'sum');
	                var rtnQty 	= $("#categorySalesList").jqGrid('getCol', 'rtnQty', false, 'sum');
	                var rtnAmt 	= $("#categorySalesList").jqGrid('getCol', 'rtnAmt', false, 'sum');
	                var totAmt 	= $("#categorySalesList").jqGrid('getCol', 'totAmt', false, 'sum');
	                
	                $("#categorySalesList").jqGrid('footerData', 'set',
						{
	                		dispClsfNm : '총계 : '
							, ordQty  : ordQty
							, ordAmt : ordAmt
							, cncQty : cncQty
							, cncAmt : cncAmt
							, rtnQty : rtnQty
							, rtnAmt : rtnAmt
							, totAmt : totAmt
						}
					);
	                
	            	/** rowspan START **/
	            	var grid = this;      
	                $('td[name="cellRowspan"]', grid).each(function() {
	                    var spans = $('td[rowspanid="'+this.id+'"]',grid).length+1;
	                    if(spans>1){
	                     $(this).attr('rowspan',spans);
	                    }
	                });
	    			cellRowspan={cellId:undefined, chkval:undefined}; //cell rowspan 중복 체크
	    			cellRowspan1={cellId:undefined, chkval:undefined}; //cell rowspan 중복 체크
	            	/** rowspan END **/	                
	            }
			}

			grid.create("categorySalesList", gridOptions);

			$("#categorySalesList").jqGrid('setGroupHeaders', {
				useColSpanStyle: true,
				groupHeaders : [
					{ "startColumnName":'saleAmt02', "numberOfColumns":12, "titleText":'시간대' }
				]
			});
		}


	    function dispClsfNm1st(rowid, val, rowObject, cm, rdata){
	        var result = "";
	        if(cellRowspan.chkval != val || val == ""){ //check 값이랑 비교값이 다른 경우
	            var cellId = this.id + '_row_'+rowid+'-'+cm.name;
	            result = ' rowspan="1" id ="'+cellId+'" + name="cellRowspan"';
// 	            alert(result);
	            cellRowspan = {cellId:cellId, chkval:val};
	        }else{
	            result = 'style="display:none"  rowspanid="'+cellRowspan.cellId+'"'; //같을 경우 display none 처리
// 	            alert(result);
	        }

	        return result; 
	    }
	    
	    function dispClsfNm2nd(rowid, val, rowObject, cm, rdata){
	        var result = "";
	        if(cellRowspan1.chkval != val || val == ""){ //check 값이랑 비교값이 다른 경우
	            var cellId = this.id + '_row_'+rowid+'-'+cm.name;
	            result = ' rowspan="1" id ="'+cellId+'" + name="cellRowspan"';
// 	            alert(result);
	           cellRowspan1 = {cellId:cellId, chkval:val};
	        }else{
	            result = 'style="display:none"  rowspanid="'+cellRowspan1.cellId+'"'; //같을 경우 display none 처리
// 	            alert(result);
	        }

	        return result; 
	    }

		// 검색
		function searchCategorySalesList() {
			var options = {
				searchParam : $("#categorySalesForm").serializeJson()
			};

			grid.reload("categorySalesList", options);
		}
	</script>
	</t:putAttribute>

	<t:putAttribute name="content">
		<div class="easyui-accordion search-accordion" data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect" style="width:100%">
			<div title="<spring:message code='admin.web.view.common.search' />" style="padding:10px">
				<form id="categorySalesForm" name="categorySalesForm" method="post" >
					<input type="hidden" id="popupDispClsfNo" name="dispClsfNo" value="" />  
						<table class="table_type1">
							<caption>정보 검색</caption>
							<colgroup>
								<col width="170px" />
								<col width="400px" />
								<col width="170px" />
								<col />
							</colgroup>
							<tbody>
								<tr>
									<th scope="row" ><spring:message code="column.date" /></th>
									<td>
										<frame:datepicker startDate="totalDtStart" endDate="totalDtEnd" period="-7" />
									</td>
									<th><spring:message code="column.ord_mda_cd"/></th>
									<td>
										<select name="ordMdaCd" id="ordMdaCd" title="<spring:message code="column.ord_mda_cd"/>">
											<frame:select grpCd="${adminConstants.ORD_MDA}" defaultName="전체"/>
										</select>
									</td>
								</tr>
								<tr>
									<th scope="row"><spring:message code="column.st_id" /></th> <!-- 사이트 ID -->
									<td>
			                            <select id="stIdCombo" name="stId">
			                                <frame:stIdStSelect defaultName="사이트선택" />
			                            </select>
									</td>
									<th scope="row"><spring:message code="column.statistics.category_nm" /></th>
									<td>
										<select name="displayCategory1" id="displayCategory1">
											<option value='' selected='selected'>대카 선택</option>
										</select>
										<select name="displayCategory2" id="displayCategory2">
											<option value='' selected='selected'>중카 선택</option>
										</select>
										<select name="displayCategory3" id="displayCategory3">
											<option value='' selected='selected'>소카 선택</option>
										</select>
									</td>
								</tr>
							</tbody>
						</table>
				</form>
		
				<div class="btn_area_center">
					<button type="button" onclick="searchCategorySalesList();" class="btn btn-ok">검색</button>
					<button type="button" onclick="resetForm('categorySalesForm');" class="btn btn-cancel">초기화</button>
				</div>
			</div>
		</div>
		<div class="mModule">
			<table id="categorySalesList"></table>
		</div>
	</t:putAttribute>
</t:insertDefinition>