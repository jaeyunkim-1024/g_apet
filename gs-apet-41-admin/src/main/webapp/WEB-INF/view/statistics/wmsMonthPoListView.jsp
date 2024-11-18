<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
	<script type="text/javascript">
		$(document).ready(function() {
			// 발주현황 월별 집계 리스트 생성
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
			 
			    var datepicker_default = {
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
			 
			    datepicker_default.closeText = "선택";
			    datepicker_default.dateFormat = "yy-mm";
			    datepicker_default.onClose = function (dateText, inst) {
			        var month = $("#ui-datepicker-div .ui-datepicker-month :selected").val();
			        var year = $("#ui-datepicker-div .ui-datepicker-year :selected").val();
			        $(this).datepicker( "option", "defaultDate", new Date(year, month, 1) );
			        $(this).datepicker('setDate', new Date(year, month, 1));
			    }
			 
			    datepicker_default.beforeShow = function () {
			        var selectDate = $("#baseYm").val().split("-");
			        var year = Number(selectDate[0]);
			        var month = Number(selectDate[1]) - 1;
			        $(this).datepicker( "option", "defaultDate", new Date(year, month, 1) );
			    }
			 
			    $("#baseYm").datepicker(datepicker_default);
			
			
			
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
		
		function fnResetSumGbCd(){
			
			var sumGbCd = $(':radio[name="sumGbCd"]:checked').val();
				
			console.log(sumGbCd);

			if(sumGbCd == '10'){
				$("#seriesNo").val("");
				$("#seriesNm").val("");
				$("#compTpCd").attr("disabled",false);
				$("#compNo").attr("disabled",false);
				$("#btnSeriesNm").attr("disabled",true);
			}else{
				$("#compTpCd").val("");
				$("#compNo").val("");
				$("#compTpCd").attr("disabled",true);
				$("#compNo").attr("disabled",true);
				$("#btnSeriesNm").attr("disabled",false);
				var comboObj=$("#wmsMonthPoForm").find("select[name=compNo]");
				comboObj.find("option").remove();				
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
		
		// 발주현황 월별 집계 리스트
		function createWmsPoGrid() {
			var gridOptions = {
				url : "<spring:url value='/statistics/wmsMonthPoListGrid.do'/>"
				, datatype : 'local'
				, height : 500
				, searchParam : $("#wmsMonthPoForm").serializeJson()
				, colModels : [
					{name:"sumTgNm", label:"<spring:message code='column.goods.comp_nm' />", width:"150", align:"center"}
					, {name:"firstPoAmt", label:"<spring:message code='column.poAmt01' />", width:"100", align:"center", sortable:false, summaryType:"sum", formatter:'integer'}
					, {name:"secondPoAmt", label:"<spring:message code='column.poAmt02' />", width:"100", align:"center", sortable:false, summaryType:"sum", formatter:'integer'}
					, {name:"thirdPoAmt", label:"<spring:message code='column.poAmt03' />", width:"100", align:"center", sortable:false, summaryType:"sum", formatter:'integer'}
					, {name:"addPoAmt", label:"<spring:message code='column.poAmt99' />", width:"100", align:"center", sortable:false, summaryType:"sum", formatter:'integer'}
					, {name:"sumAmt", label:"<spring:message code='column.compSumAmt' />", width:"150", align:"center", sortable:false, summaryType:"sum", formatter:'integer'}
					, {name:"rate", label:"<spring:message code='column.totRate' />", width:"100", align:"center", sortable:false, summaryType:"sum", formatter: 'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:1, suffix: ' %', thousandsSeparator:','}}
					, {name:"incRatio", label:"<spring:message code='column.incRatio' />", width:"100", align:"center", sortable:false, summaryType:"sum", formatter: 'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:1, suffix: ' %', thousandsSeparator:','}}
				]
				, footerrow : true
				, userDataOnFooter : true
				, gridComplete : function () {
					
					var gridTitle = "합계";
					var firstPoAmt = $("#wmsMonthPoList" ).jqGrid('getCol', 'firstPoAmt', false, 'sum');
					var secondPoAmt = $("#wmsMonthPoList" ).jqGrid('getCol', 'secondPoAmt', false, 'sum');
					var thirdPoAmt = $("#wmsMonthPoList" ).jqGrid('getCol', 'thirdPoAmt', false, 'sum');
					var addPoAmt = $("#wmsMonthPoList" ).jqGrid('getCol', 'addPoAmt', false, 'sum');
					var sumAmt = $("#wmsMonthPoList" ).jqGrid('getCol', 'sumAmt', false, 'sum');
					var rate = $("#wmsMonthPoList" ).jqGrid('getCol', 'rate', false, 'sum');
					var incRatio = $("#wmsMonthPoList" ).jqGrid('getCol', 'incRatio', false, 'sum');
					
					if(rate > 100){
						rate = 100;
					}
					
					$("#wmsMonthPoList" ).jqGrid('footerData', 'set',
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

			grid.create("wmsMonthPoList", gridOptions);
		}

		// 검색
		function searchWmsMonthPoList() {
			
			if($('#baseYm').val() == ''){
				messager.alert('<spring:message code="admin.web.view.msg.statistics.valid.baseYm" />', "Info", "info");
				return;
			}
			
			var options = {
				searchParam : $("#wmsMonthPoForm").serializeJson()
			};

			grid.reload("wmsMonthPoList", options);
			
			var sumGbCd = $(':radio[name="sumGbCd"]:checked').val();
			
			if(sumGbCd == '10'){
				jQuery("#wmsMonthPoList").jqGrid("setLabel", "sumTgNm", "<spring:message code='column.goods.comp_nm' />");
			}else{
				jQuery("#wmsMonthPoList").jqGrid("setLabel", "sumTgNm", "<spring:message code='column.series' />");
			}			
		}
		
		// 엑셀 다운로드
		function wmsMonthPoListExcelDownload() {
			createFormSubmit("wmsMonthPoListExcelDownload", "/statistics/wmsMonthPoListExcelDownload.do", $("#wmsMonthPoForm").serializeJson());
		}

	</script>
	</t:putAttribute>

	<t:putAttribute name="content">
		<form id="wmsMonthPoForm" name="wmsMonthPoForm" method="post" >
			<table class="table_type1">
				<caption>정보 검색</caption>
				<tbody>
					<tr>
						<!-- 검색조건 -->
						<th scope="row">년월선택</th>
						<td>
							<frame:datepicker startDate="baseYm" />
						</td>
						<th scope="row">구분</th>
						<td>
							<label class="fRadio"><input type="radio" name="sumGbCd" id="sumGbCd10" value="10" checked="checked" onclick="javascript:fnResetSumGbCd();"> <span>업체별보기</span></label>
								<select class="w80" name="compTpCd" id="compTpCd" OnChange="javascript:fnCompTpCdChange(this.value);">
									<option value="" >전체</option>
									<option value="30" >국내OEM</option>
									<option value="40" >해외OEM</option>
								</select>
								<select name="compNo" id="compNo">
								</select>									
							<label class="fRadio"><input type="radio" name="sumGbCd" id="sumGbCd20" value="20" onclick="javascript:fnResetSumGbCd();"> <span>시리즈별보기</span></label>
							<input type="hidden" id="seriesNo" name="seriesNo" title="<spring:message code="column.goods.series" />" value="" />
							<input type="text" class="w180 readonly" id="seriesNm" name="seriesNm" title="<spring:message code="column.goods.series" />" value="" readonly/>
							<button type="button" class="btn" id="btnSeriesNm" onclick="selectBrandSeries('series'); return false;" disabled>검색</button>						
						</td>
					</tr>
				</tbody>
			</table>
		</form>

		<div class="btn_area_center">
			<button type="button" onclick="searchWmsMonthPoList();" class="btn btn-ok">검색</button>
			<button type="button" onclick="resetForm('wmsMonthPoForm');" class="btn btn-cancel">초기화</button>
		</div>
		
		<div class="mModule">
			<table id="wmsMonthPoList"></table>
		</div>
		<style>
		.ui-datepicker-calendar {
		    display: none;
		    }
		</style>		
	</t:putAttribute>
</t:insertDefinition>