<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
	<script type="text/javascript">
		$(document).ready(function() {
			// 판매공간별재고통계 리스트 생성
			createWmsCompGbGrid();
		});

		var chkCell01 = {cellId:'', chkval:''};
		var chkCell02 = {cellId:'', chkval:''};
		var chkCell03 = {cellId:'', chkval:''};
		var mergeIdx = [];
		
		// 판매공간별재고통계 리스트
		function createWmsCompGbGrid() {
			var gridOptions = {
				url : "<spring:url value='/statistics/wmsCompGbListGrid.do'/>"
				, datatype : 'local'
				, height : 500
				, searchParam : $("#wmsCompGbForm").serializeJson()
				, colModels : [
					// 판매공간
					{name:"bomCompGbNm", label:"<spring:message code='column.ordMda' />", width:"100", align:"center", cellattr:mergeCell01}
					// 재고금액
					, {name:"stkAmt", label:"<spring:message code='column.stockAmount' />", width:"100", align:"center", sortable:false, summaryType:"sum", formatter:'integer', cellattr:mergeCell02}
					// 구성비
					, {name:"rate", label:"<spring:message code='column.componentRate' />", width:"100", align:"center", sortable:false, summaryType:"sum", formatter: 'currency', cellattr:mergeCell03, formatoptions:{decimalSeparator:'.', decimalPlaces:1, suffix: ' %', thousandsSeparator:','}}
					// 구분
					,{name:"bomCtrOrgNm", label:"<spring:message code='column.ctr_org' />", width:"100", align:"center"}
					// 재고금액
					, {name:"subStkAmt", label:"<spring:message code='column.stockAmount' />", width:"100", align:"center", sortable:false, formatter:'integer'}
					// 구성비
					, {name:"subRate", label:"<spring:message code='column.componentRate' />", width:"100", align:"center", sortable:false, formatter: 'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:1, suffix: ' %', thousandsSeparator:','}}
				]
				, footerrow : true
				, userDataOnFooter : true
				, gridComplete : function () {

					// merge cell
					var grid = this;
					
					$('td[name="cellRowsapn"]', grid).each(function(){
						var spans = $('td[rowspanid="'+this.id+'"]', grid).length + 1;
						if(spans > 1){
							$(this).attr('rowspan', spans);
						}
					});
					for(var idx=0; idx < mergeIdx.length; idx++){
						$(grid).jqGrid('setCell', mergeIdx[idx], 'stkAmt', 0);
						$(grid).jqGrid('setCell', mergeIdx[idx], 'rate', 0);
					}
					
					var gridTitle = "합계";
					var stockAmt = $("#wmsCompGbList" ).jqGrid('getCol', 'stkAmt', false, 'sum');
					var rate = $("#wmsCompGbList" ).jqGrid('getCol', 'rate', false, 'sum');
					
					if(rate > 100){
						rate = 100;
					}
					
					$("#wmsCompGbList" ).jqGrid('footerData', 'set',
						{
						bomCompGbNm : gridTitle
							, stkAmt : stockAmt
							, rate : rate
							
						}
					);
					chkCell01 = {cellId:'', chkval:''};
					chkCell02 = {cellId:'', chkval:''};
					chkCell03 = {cellId:'', chkval:''};
					mergeIdx = [];
				}
			}

			grid.create("wmsCompGbList", gridOptions);
		}

		function mergeCell01(rowid, val, rowObject, cm, rdata){
			
			var result = "";
			
			if(chkCell01.chkval != val){
				var cellId = this.id + '_row_' + rowid + '-' + cm.name;
				result = 'rowspan="1" id="' + cellId + '" name="cellRowsapn"';
				chkCell01 = {cellId:cellId, chkval:val};
			}else{
				result = 'style="display:none" rowspanid="' + chkCell01.cellId + '"';
				mergeIdx[mergeIdx.length] = rowid;
			}
			return result;
		}

		function mergeCell02(rowid, val, rowObject, cm, rdata){
			
			var result = "";
			
			if(chkCell02.chkval != val){
				var cellId = this.id + '_row_' + rowid + '-' + cm.name;
				result = 'rowspan="1" id="' + cellId + '" name="cellRowsapn"';
				chkCell02 = {cellId:cellId, chkval:val};
			}else{
				result = 'style="display:none" rowspanid="' + chkCell02.cellId + '"';
			}
			return result;
		}

		function mergeCell03(rowid, val, rowObject, cm, rdata){
			
			var result = "";
			
			if(chkCell03.chkval != val){
				var cellId = this.id + '_row_' + rowid + '-' + cm.name;
				result = 'rowspan="1" id="' + cellId + '" name="cellRowsapn"';
				chkCell03 = {cellId:cellId, chkval:val};
			}else{
				result = 'style="display:none" rowspanid="' + chkCell03.cellId + '"';
			}
			return result;
		}
		// 검색
		function searchWmsCompGbList() {
			var options = {
				searchParam : $("#wmsCompGbForm").serializeJson()
			};
			grid.reload("wmsCompGbList", options);
		}
		
		// 엑셀 다운로드
		function wmsCompGbListExcelDownload() {
			createFormSubmit("wmsCompGbListExcelDownload", "/statistics/wmsCompGbListExcelDownload.do", $("#wmsCompGbForm").serializeJson());
		}
	</script>
	</t:putAttribute>

	<t:putAttribute name="content">
		<form id="wmsCompGbForm" name="wmsCompGbForm" method="post" >
			<table class="table_type1">
				<caption>정보 검색</caption>
				<tbody>
					<tr>
						<!-- 검색조건 -->
						<th scope="row">조회일자</th>
						<td colspan="3">
							<frame:datepicker startDate="baseDt" format="yyyyMMdd" />
						</td>
					</tr>
				</tbody>
			</table>
		</form>

		<div class="btn_area_center">
			<button type="button" onclick="searchWmsCompGbList();" class="btn btn-ok">검색</button>
			<button type="button" onclick="resetForm('wmsCompGbForm');" class="btn btn-cancel">초기화</button>
		</div>
		
		<div class="mModule">
			<button type="button" onclick="wmsCompGbListExcelDownload();" class="btn btn-add btn-excel">엑셀 다운로드</button>
			
			<table id="wmsCompGbList"></table>
		</div>
	</t:putAttribute>
</t:insertDefinition>