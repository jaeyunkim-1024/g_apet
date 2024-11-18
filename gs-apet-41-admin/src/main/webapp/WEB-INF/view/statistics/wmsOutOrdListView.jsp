<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
	<script type="text/javascript">
		$(document).ready(function() {
			// 출고현황 월별 집계 리스트 생성
			createWmsPoGrid();
			
			clearSearchForm();

			$.datepicker.regional['ko'] = {
			        closeText: '닫기',
			        prevText: '이전달',
			        nextText: '다음달',
			        currentText: '오늘',
			        monthNames: ['1월(JAN)','2월(FEB)','3월(MAR)','4월(APR)','5월(MAY)','6월(JUN)',
			        '7월(JUL)','8월(AUG)','9월(SEP)','10월(OCT)','11월(NOV)','12월(DEC)'],
			        monthNamesShort: ['1월','2월','3월','4월','5월','6월',
			        '7월','8월','9월','10월','11월','12월'],
			        dayNames: ['일','월','화','수','목','금','토'],
			        dayNamesShort: ['일','월','화','수','목','금','토'],
			        dayNamesMin: ['일','월','화','수','목','금','토'],
			        weekHeader: 'Wk',
			        dateFormat: 'yy-mm-dd',
			        firstDay: 0,
			        isRTL: false,
			        showMonthAfterYear: true,
			        yearSuffix: '',
			        showOn: 'both',
			        //buttonText: "달력",
			        changeMonth: true,
			        changeYear: true,
			        showButtonPanel: true,
			        yearRange: 'c-99:c+99'
			    };
			    $.datepicker.setDefaults($.datepicker.regional['ko']);
			 
			    var datepicker_month = {
			        showOn: 'both',
			        //buttonText: "달력",
			        currentText: "이번달",
			        changeMonth: true,
			        changeYear: true,
			        showButtonPanel: true,
			        yearRange: 'c-99:c+99',
			        showOtherMonths: true,
			        selectOtherMonths: true,
			        buttonImage: "/images/calendar_icon.png"
			    }
			 
			    datepicker_month.closeText = "선택";
			    datepicker_month.dateFormat = "yy-mm";
			    datepicker_month.onClose = function (dateText, inst) {
			        var month = $("#ui-datepicker-div .ui-datepicker-month :selected").val();
			        var year = $("#ui-datepicker-div .ui-datepicker-year :selected").val();
			        $(this).datepicker( "option", "defaultDate", new Date(year, month, 1) );
			        $(this).datepicker('setDate', new Date(year, month, 1));
			    }
			 
			    /*
			    datepicker_month.beforeShow = function () {
			        var selectDate = $("#baseYm").val().split("-");
			        var year = Number(selectDate[0]);
			        var month = Number(selectDate[1]) - 1;
			        $(this).datepicker( "option", "defaultDate", new Date(year, month, 1) );
			    }
			    */
			 
			    $("#fromBaseYm").datepicker(datepicker_month);
			    $("#toBaseYm").datepicker(datepicker_month);
			    
			    var datepicker_year = {
				        showOn: 'both',
				        //buttonText: "달력",
				        currentText: "이번달",
				        changeMonth: true,
				        changeYear: true,
				        showButtonPanel: true,
				        yearRange: 'c-99:c+99',
				        showOtherMonths: true,
				        selectOtherMonths: true,
				        buttonImage: "/images/calendar_icon.png"
				    }
				 
				    datepicker_year.closeText = "선택";
				    datepicker_year.dateFormat = "yy";
				    datepicker_year.onClose = function (dateText, inst) {
				        var year = $("#ui-datepicker-div .ui-datepicker-year :selected").val();
				        $(this).datepicker( "option", "defaultDate", new Date(year, 1, 1) );
				        $(this).datepicker('setDate', new Date(year, 1, 1));
				    }
				 
				    /*
				    datepicker_year.beforeShow = function () {
				        var selectDate = $("#baseYm").val().split("-");
				        var year = Number(selectDate[0]);
				        var month = Number(selectDate[1]) - 1;
				        $(this).datepicker( "option", "defaultDate", new Date(year, month, 1) );
				    }
				    */
				 
				    $("#fromBaseYy").datepicker(datepicker_year);
				    $("#toBaseYy").datepicker(datepicker_year);
				    
				    $("#rangeMonth").hide();
				    $("#rangeYear").hide();
				    
		});

		// 조회폼 초기화
		function clearSearchForm() {
			
			//fnCompTpCdChange('30');
		}

		// 업체유형 변경시
		function fnCompTpCdChange(compTpCd){
			
			var options = {
				url : "<spring:url value='/wmsin/companyListByCompTpCd.do' />"
				, data : { compTpCd : compTpCd }
				, callBack : function(data){
					fnSetCompanyListByCompTpCd(data.companyList, '');
				}
			};

			ajax.call(options);
		}

		// 업체 콤보 세팅
		function fnSetCompanyListByCompTpCd(companyList, selectCompNo) {
			
			var comboObj=$("#wmsMonthPoForm").find("select[name=compNo]");
			comboObj.find("option").remove();
			
			comboObj.append("<option value='' >전체</option>");
			
			$.each(companyList, function() {
				var value = this.compNo;
				var name = this.compNm2;
				
				console.log(value + "/" + name);
				if (selectCompNo != "") {
					comboObj.append("<option value='"+value+"' " + (value==selectCompNo)?"selected":"" + ">"+name+"</option>");
				} else {
					comboObj.append("<option value='"+value+"' >"+name+"</option>");
				}
			});
		}
		
		function fnResetRange(){
			
			var searchType = $(':radio[name="searchType"]:checked').val();
				
			console.log(searchType);

			if(searchType == '10'){
				$("#rangeDay").hide();
				$("#rangeMonth").hide();
			    $("#rangeYear").show();
			}else if(searchType == '20'){
				$("#rangeDay").hide();
				$("#rangeMonth").show();
			    $("#rangeYear").hide();
			}else{
				$("#rangeDay").show();
				$("#rangeMonth").hide();
			    $("#rangeYear").hide();				
			}
		}

		function selectBrandSeries (gubun ) {
			var options = null;
			if(gubun == "brand") {
				options = {
					multiselect : false
					, bndGbCd : '${adminConstants.BND_GB_20 }'
					, callBack : searchBrandCallback
				}
			} else {
				options = {
					multiselect : false
					, bndGbCd : '${adminConstants.BND_GB_10 }'
					, callBack : searchSeriesCallback
				}
			}
			layerBrandList.create (options );
		}

		function searchSeriesCallback (brandList ) {
			if(brandList != null && brandList.length > 0 ) {
				$("#seriesNo").val (brandList[0].bndNo );
				$("#seriesNm").val (brandList[0].bndNmKo );
			}
		}
		
		// 출고현황 월별 집계 리스트
		function createWmsPoGrid() {
			var gridOptions = {
				url : "<spring:url value='/statistics/wmsOutOrdListGrid.do'/>"
				, datatype : 'local'
				, height : 500
				, searchParam : $("#wmsMonthPoForm").serializeJson()
				, colModels : [
					{name:" baseDt", label:"<spring:message code='column.statistics.wms.baseDt' />", width:"100", align:"center"}
					, {name:"A10", label:"<spring:message code='column.statistics.wms.area.10' />", width:"100", align:"center", sortable:false, summaryType:"sum", formatter:'integer'}
					, {name:"A20", label:"<spring:message code='column.statistics.wms.area.20' />", width:"100", align:"center", sortable:false, summaryType:"sum", formatter:'integer'}
					, {name:"A30", label:"<spring:message code='column.statistics.wms.area.30' />", width:"100", align:"center", sortable:false, summaryType:"sum", formatter:'integer'}
					, {name:"A40", label:"<spring:message code='column.statistics.wms.area.40' />", width:"100", align:"center", sortable:false, summaryType:"sum", formatter:'integer'}
					, {name:"A50", label:"<spring:message code='column.statistics.wms.area.50' />", width:"100", align:"center", sortable:false, summaryType:"sum", formatter:'integer'}
					, {name:"A60", label:"<spring:message code='column.statistics.wms.area.60' />", width:"100", align:"center", sortable:false, summaryType:"sum", formatter:'integer'}
					, {name:"A70", label:"<spring:message code='column.statistics.wms.area.70' />", width:"100", align:"center", sortable:false, summaryType:"sum", formatter:'integer'}
					, {name:"A80", label:"<spring:message code='column.statistics.wms.area.80' />", width:"100", align:"center", sortable:false, summaryType:"sum", formatter:'integer'}
					, {name:"ordCnt", label:"<spring:message code='column.statistics.wms.ordCnt' />", width:"100", align:"center", sortable:false, summaryType:"sum", formatter:'integer'}
					, {name:"ordQty", label:"<spring:message code='column.statistics.wms.ordQty' />", width:"100", align:"center", sortable:false, summaryType:"sum", formatter:'integer'}
					, {name:"saleAmt", label:"<spring:message code='column.statistics.wms.saleAmt' />", width:"150", align:"center", sortable:false, summaryType:"sum", formatter:'integer'}
				]
				, footerrow : true
				, userDataOnFooter : true
				, gridComplete : function () {
					
					var gridTitle = "합계";
					var firstPoAmt = $("#wmsOutOrdList" ).jqGrid('getCol', 'firstPoAmt', false, 'sum');
					var secondPoAmt = $("#wmsOutOrdList" ).jqGrid('getCol', 'secondPoAmt', false, 'sum');
					var thirdPoAmt = $("#wmsOutOrdList" ).jqGrid('getCol', 'thirdPoAmt', false, 'sum');
					var addPoAmt = $("#wmsOutOrdList" ).jqGrid('getCol', 'addPoAmt', false, 'sum');
					var sumAmt = $("#wmsOutOrdList" ).jqGrid('getCol', 'sumAmt', false, 'sum');
					var rate = $("#wmsOutOrdList" ).jqGrid('getCol', 'rate', false, 'sum');
					var incRatio = $("#wmsOutOrdList" ).jqGrid('getCol', 'incRatio', false, 'sum');
					
					if(rate > 100){
						rate = 100;
					}
					
					$("#wmsOutOrdList" ).jqGrid('footerData', 'set',
						{
						sumTgNm : gridTitle
							, firstPoAmt : firstPoAmt
							, secondPoAmt : secondPoAmt
							, thirdPoAmt : thirdPoAmt
							, addPoAmt : addPoAmt
							, sumAmt : sumAmt
							, rate : rate
							, incRatio : incRatio
						}
					);
				}
			}

			grid.create("wmsOutOrdList", gridOptions);
		}

		// 검색
		function searchwmsOutOrdList() {
			
			if($('#baseYm').val() == ''){
				messager.alert('<spring:message code="admin.web.view.msg.statistics.valid.baseYm" />', "Info", "info");
				return;
			}
			
			var options = {
				searchParam : $("#wmsMonthPoForm").serializeJson()
			};

			grid.reload("wmsOutOrdList", options);
			
			var sumGbCd = $(':radio[name="sumGbCd"]:checked').val();
			
			if(sumGbCd == '10'){
				jQuery("#wmsOutOrdList").jqGrid("setLabel", "sumTgNm", "<spring:message code='column.goods.comp_nm' />");
			}else{
				jQuery("#wmsOutOrdList").jqGrid("setLabel", "sumTgNm", "<spring:message code='column.series' />");
			}			
		}
		
		// 엑셀 다운로드
		function wmsOutOrdListExcelDownload() {
			createFormSubmit("wmsOutOrdListExcelDownload", "/statistics/wmsOutOrdListExcelDownload.do", $("#wmsMonthPoForm").serializeJson());
		}

	</script>
	</t:putAttribute>

	<t:putAttribute name="content">
		<form id="orderGoodsForm" name="orderGoodsForm" method="post" >
			<table class="table_type1">
				<caption>정보 검색</caption>
				<tbody>
					<tr>
						<!-- 기간 -->
						<th scope="row"><spring:message code="column.common.date" /></th>
						<td>
							<div id="rangeDay">
								<frame:datepicker startDate="fromBaseDt" endDate="toBaseDt" startValue="${adminConstants.COMMON_START_DATE }"/>
							</div>
							<div id="rangeMonth">
								<frame:datepicker startDate="fromBaseYm" endDate="toBaseYm"/>
							</div>
							<div id="rangeYear">
								<frame:datepicker startDate="fromBaseYy" endDate="toBaseYy"/>
							</div>					
						</td>
						<!-- 구분 -->
						<th scope="row"><spring:message code="column.gb_cd" /></th>
						<td>
							<label class="fRadio"><input type="radio" name="searchType" id="searchType10" value="10" onclick="javascript:fnResetRange();"> <span>년도별</span></label>
							<label class="fRadio"><input type="radio" name="searchType" id="searchType10" value="20" onclick="javascript:fnResetRange();"> <span>월별</span></label>
							<label class="fRadio"><input type="radio" name="searchType" id="searchType10" value="30" checked="checked"" onclick="javascript:fnResetRange();"><span>일별</span></label>
						</td>
					</tr>
					<tr>
						<!-- 구성품 -->
						<th scope="row">
							<select name="searchTextType" id="searchTextType">
							</select>
						</th>
						<td>
							<input type="text" style="width:80%;" name="searchText"  id="searchText" value=""/>
						</td>
						<!-- 매체구분 -->
						<th scope="row"><spring:message code="column.statistics.wms.compGb" /></th>
						<td>
							<label class="fRadio"><input type="radio" name="bomCompGbCd" id="bomCompGbCdA" value="A" checked="checked" > <span>전체</span></label>
							<label class="fRadio"><input type="radio" name="bomCompGbCd" id="bomCompGbCdD" value="D"> <span>DODOT</span></label>
							<label class="fRadio"><input type="radio" name="bomCompGbCd" id="bomCompGbCdB" value="B"> <span>BLASKOV</span></label>
						</td>
					</tr>
				</tbody>
			</table>
		</form>

		<div class="btn_area_center">
			<button type="button" onclick="searchwmsOutOrdList();" class="btn btn-ok">검색</button>
			<button type="button" onclick="resetForm('wmsMonthPoForm');" class="btn btn-cancel">초기화</button>
		</div>
		
		<div class="mModule">
			<button type="button" onclick="wmsOutOrdListExcelDownload();" class="btn btn-add btn-excel">엑셀 다운로드</button>
			
			<table id="wmsOutOrdList"></table>
		</div>
	</t:putAttribute>
</t:insertDefinition>