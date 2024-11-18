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
			$('#dailySalesForm').on('reset', function(){
				setTimeout("createDisplayCategory(1, '${adminConstants.DISP_CLSF_10}')", 100);
			});
			
			createDisplayCategory(1, "${adminConstants.DISP_CLSF_10}");
			// 기간별 리스트 생성
			createDailySalesSalesGrid();
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
		function createDailySalesSalesGrid() {
			var gridOptions = {
				url : "<spring:url value='/statistics/orderDailyReportListGrid.do'/>"
				, datatype : 'local'
				, height : 500
				, searchParam : $("#dailySalesForm").serializeJson()
				, colModels : [
					// 대카테고리
					{name:"dispClsfNm1st", label:"<spring:message code='column.statistics.order_daily_report.1st_disp_clsf_nm' />", width:"150", align:"center", sortable:false, cellattr:dispClsfNm1st}
					// 중카테고리
					, {name:"dispClsfNm2nd", label:"<spring:message code='column.statistics.order_daily_report.2nd_disp_clsf_nm' />", width:"150", align:"center", sortable:false, cellattr:dispClsfNm2nd}
					// 소카테고리
					, {name:"dispClsfNm", label:"<spring:message code='column.statistics.order_daily_report.disp_clsf_nm' />", width:"150", align:"center", sortable:false, summaryType:'count', summaryTpl : '소계'}
					// 매출실적
					, {name:"saleAmtTot", label:"<spring:message code='column.statistics.order_daily_report.tot_sale_amt' />", width:"100", align:"right", sortable:false, summaryType:"sum", formatter:'integer'}
					// 2
					, {name:"saleAmt02", label:"<spring:message code='column.statistics.order_daily_report.02_sale_amt' />", width:"100", align:"right", sortable:false, summaryType:"sum", formatter:'integer'}
					// 4
					, {name:"saleAmt04", label:"<spring:message code='column.statistics.order_daily_report.04_sale_amt' />", width:"100", align:"right", sortable:false, summaryType:"sum", formatter:'integer'}
					// 6
					, {name:"saleAmt06", label:"<spring:message code='column.statistics.order_daily_report.06_sale_amt' />", width:"100", align:"right", sortable:false, summaryType:"sum", formatter:'integer'}
					// 8
					, {name:"saleAmt08", label:"<spring:message code='column.statistics.order_daily_report.08_sale_amt' />", width:"100", align:"right", sortable:false, summaryType:"sum", formatter:'integer'}
					// 10
					, {name:"saleAmt10", label:"<spring:message code='column.statistics.order_daily_report.10_sale_amt' />", width:"100", align:"right", sortable:false, summaryType:"sum", formatter:'integer'}
					// 12
					, {name:"saleAmt12", label:"<spring:message code='column.statistics.order_daily_report.12_sale_amt' />", width:"100", align:"right", sortable:false, summaryType:"sum", formatter:'integer'}
					// 14
					, {name:"saleAmt14", label:"<spring:message code='column.statistics.order_daily_report.14_sale_amt' />", width:"100", align:"right", sortable:false, summaryType:"sum", formatter:'integer'}
					// 16
					, {name:"saleAmt16", label:"<spring:message code='column.statistics.order_daily_report.16_sale_amt' />", width:"100", align:"right", sortable:false, summaryType:"sum", formatter:'integer'}
					// 18
					, {name:"saleAmt18", label:"<spring:message code='column.statistics.order_daily_report.18_sale_amt' />", width:"100", align:"right", sortable:false, summaryType:"sum", formatter:'integer'}
					// 20
					, {name:"saleAmt20", label:"<spring:message code='column.statistics.order_daily_report.20_sale_amt' />", width:"100", align:"right", sortable:false, summaryType:"sum", formatter:'integer'}
					// 22
					, {name:"saleAmt22", label:"<spring:message code='column.statistics.order_daily_report.22_sale_amt' />", width:"100", align:"right", sortable:false, summaryType:"sum", formatter:'integer'}
					// 24
					, {name:"saleAmt24", label:"<spring:message code='column.statistics.order_daily_report.24_sale_amt' />", width:"100", align:"right", sortable:false, summaryType:"sum", formatter:'integer'}
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
	                var saleAmtTot 	= $("#dailySalesList").jqGrid('getCol', 'saleAmtTot', false, 'sum');
	                var saleAmt02 	= $("#dailySalesList").jqGrid('getCol', 'saleAmt02', false, 'sum');
	                var saleAmt04 	= $("#dailySalesList").jqGrid('getCol', 'saleAmt04', false, 'sum');
	                var saleAmt06 	= $("#dailySalesList").jqGrid('getCol', 'saleAmt06', false, 'sum');
	                var saleAmt08 	= $("#dailySalesList").jqGrid('getCol', 'saleAmt08', false, 'sum');
	                var saleAmt10 	= $("#dailySalesList").jqGrid('getCol', 'saleAmt10', false, 'sum');
	                var saleAmt12 	= $("#dailySalesList").jqGrid('getCol', 'saleAmt12', false, 'sum');
	                var saleAmt14 	= $("#dailySalesList").jqGrid('getCol', 'saleAmt14', false, 'sum');
	                var saleAmt16 	= $("#dailySalesList").jqGrid('getCol', 'saleAmt16', false, 'sum');
	                var saleAmt18 	= $("#dailySalesList").jqGrid('getCol', 'saleAmt18', false, 'sum');
	                var saleAmt20 	= $("#dailySalesList").jqGrid('getCol', 'saleAmt20', false, 'sum');
	                var saleAmt22 	= $("#dailySalesList").jqGrid('getCol', 'saleAmt22', false, 'sum');
	                var saleAmt24 	= $("#dailySalesList").jqGrid('getCol', 'saleAmt24', false, 'sum');
	                
	                $("#dailySalesList").jqGrid('footerData', 'set',
						{
	                		dispClsfNm : '총계 : '
							, saleAmtTot  : saleAmtTot
							, saleAmt02 : saleAmt02
							, saleAmt04 : saleAmt04
							, saleAmt06 : saleAmt06
							, saleAmt08 : saleAmt08
							, saleAmt10 : saleAmt10
							, saleAmt12 : saleAmt12
							, saleAmt14 : saleAmt14
							, saleAmt16 : saleAmt16
							, saleAmt18 : saleAmt18
							, saleAmt20 : saleAmt20
							, saleAmt22 : saleAmt22
							, saleAmt24 : saleAmt24
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

			grid.create("dailySalesList", gridOptions);

			$("#dailySalesList").jqGrid('setGroupHeaders', {
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
		function searchDailySalesList() {
			var options = {
				searchParam : $("#dailySalesForm").serializeJson()
			};

			grid.reload("dailySalesList", options);
		}
	</script>
	</t:putAttribute>

	<t:putAttribute name="content">
		<div class="easyui-accordion search-accordion" data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect" style="width:100%">
			<div title="<spring:message code='admin.web.view.common.search' />" style="padding:10px">
				<form id="dailySalesForm" name="dailySalesForm" method="post" >
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
										<frame:datepicker startDate="totalDt" period="-1" />
									</td>
									<th><spring:message code="column.ord_mda_cd"/></th>
									<td>
										<select class="w175 input_select" name="ordMdaCd" id="ordMdaCd" title="<spring:message code="column.ord_mda_cd"/>">
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
					<button type="button" onclick="searchDailySalesList();" class="btn btn-ok">검색</button>
					<button type="button" onclick="resetForm('dailySalesForm');" class="btn btn-cancel">초기화</button>
				</div>
			</div>
		</div>
		<div class="mModule">
			<table id="dailySalesList"></table>
		</div>
	</t:putAttribute>
</t:insertDefinition>