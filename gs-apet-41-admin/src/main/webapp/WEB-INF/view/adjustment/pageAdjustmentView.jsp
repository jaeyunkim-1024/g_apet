<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>

<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">
		$(document).ready(function() {

			selectDate ();

			createAdjustGrid ();
			createAdjustDtlGrid ();
			
			grid.resize();
		});

		// 초기화 버튼클릭
		function searchReset () {
			resetForm ("adjustmentForm");
		}

		function searchAdjust () {
			var options = {
				searchParam : $("#adjustmentForm").serializeJson()
			};
			$("#adjustmentDtlList").jqGrid('clearGridData');
			$("#selectPageGbCd").val('' );
			grid.reload("adjustmentList", options);
		}

		// 상품 Grid
		function createAdjustGrid () {
			var gridOptions = {
				url : "<spring:url value='/adjustment/pageAdjustmentGrid.do' />"
				, height : 300
				, searchParam : $("#adjustmentForm").serializeJson()
				, colModels : [
					{name:"pageGbCd", label:"<spring:message code='column.page_gb_cd' />", width:"100", align:"center", sortable:false, key: true, formatter:"select", editoptions:{value:"<frame:gridSelect grpCd='${adminConstants.PAGE_GB}' showValue='false' />"} } 
					, {name:"saleAmt", label:"<spring:message code='column.sale_prc' />", width:"100", align:"center", sortable:false, formatter: 'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','} } 
					, {name:"payAmt", label:'<spring:message code="column.order_common.pay_dtl_amt" />', width:"100", align:"center", sortable:false, formatter:'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','} }
					, {name:"cmsAmt", label:'수수료', width:"100", align:"center", formatter:'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','} }
					, {name:"adjtAmt", label:'정산금액', width:"100", align:"center", formatter:'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','} }
					, {name:"adjtTax", label:'세액', width:"100", align:"center", formatter:'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','} }
					]
				, multiselect : false
				, paging : false
				, onSelectRow : function(ids) {
					var rowdata = $("#adjustmentList").getRowData(ids);
					$("#selectPageGbCd").val(rowdata.pageGbCd );
					reloadDetailGrid(rowdata.pageGbCd );
				}
				, footerrow : true
				, userDataOnFooter : true
				, gridComplete : function () {
					// footer 처리 로직
					var saleAmt = $("#adjustmentList" ).jqGrid('getCol', 'saleAmt', false, 'sum');
					var payAmt = $("#adjustmentList" ).jqGrid('getCol', 'payAmt', false, 'sum');
					var cmsAmt = $("#adjustmentList" ).jqGrid('getCol', 'cmsAmt', false, 'sum');
					var adjtAmt = $("#adjustmentList" ).jqGrid('getCol', 'adjtAmt', false, 'sum');
					var adjtTax = $("#adjustmentList" ).jqGrid('getCol', 'adjtTax', false, 'sum');

					$("#adjustmentList" ).jqGrid('footerData', 'set',
							{pageGbCd : '합계 : '
								, saleAmt: saleAmt
								, payAmt: payAmt
								, cmsAmt: cmsAmt
								, adjtAmt: adjtAmt
								, adjtTax : adjtTax }
					);
				}
			}
			grid.create("adjustmentList", gridOptions);
		}

		function reloadDetailGrid (pageGbCd ) {
			var options = {
					searchParam : {
						sysRegDtmStart : $("#sysRegDtmStart").val()
						, sysRegDtmEnd : $("#sysRegDtmEnd").val()
						, pageGbCd : pageGbCd
					}
				};
				grid.reload("adjustmentDtlList", options);
		}

		// 상품 Grid
		function createAdjustDtlGrid () {
			var gridOptions = {
				url : "<spring:url value='/adjustment/pageAdjustmentDtlGrid.do' />"
				, height : 400
				, searchParam : { /* 초기 데이터는 읽지 않는다 */
					sysRegDtmStart : $("#sysRegDtmStart").val()
					, sysRegDtmEnd : $("#sysRegDtmEnd").val()
					, pageGbCd : ''
				}
				, colModels : [
					{name:"ordNo", label:'<spring:message code="column.ord_no" />', width:"110", align:"center", sortable:false, key: true }
					, {name:"ordDtlSeq", label:'<spring:message code="column.ord_dtl_seq" />', width:"100", align:"center", sortable:false, formatter:'integer' }
					, {name:"compNo", label:'', width:"100", align:"center", sortable:false, hidden:true } /* 업체번호 */
					, {name:"compNm", label:"<spring:message code='column.goods.comp_nm' />", width:"200", align:"center", sortable:false } /* 업체명 */
					, {name:"goodsId", label:'<spring:message code="column.goods_id" />', width:"100", align:"center", sortable:false }
					, {name:"goodsNm", label:'<spring:message code="column.goods_nm" />', width:"100", align:"center", sortable:false }
					, {name:"itemNo", label:'<spring:message code="column.item_no" />', width:"100", align:"center", sortable:false }
					, {name:"itemNm", label:'<spring:message code="column.item_nm" />', width:"100", align:"center", sortable:false }
					, {name:"payMeansCd", label:'<spring:message code="column.pay_means_cd" />', width:"100", align:"center", sortable:false, formatter:"select", editoptions:{value:"<frame:gridSelect grpCd='${adminConstants.PAY_MEANS}' showValue='false' />"} }
					, {name:"saleAmt", label:"<spring:message code='column.sale_prc' />", width:"100", align:"center", sortable:false, formatter: 'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','} } /* 판매가 */
					, {name:"ordQty", label:'<spring:message code="column.ord_qty" />', width:"100", align:"center", formatter:'integer', sortable:false }
					, {name:"payAmt", label:'<spring:message code="column.order_common.pay_dtl_amt" />', width:"100", align:"center", sortable:false, formatter:'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','} }
					, {name:"goodsCpDcAmt", label:'<spring:message code="column.goods_cp_dc_amt" />', width:"100", align:"center", sortable:false, formatter:'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','} }
					, {name:"dlvrcCpDcAmt", label:'<spring:message code="column.dlvrc_cp_dc_amt" />', width:"100", align:"center", sortable:false, formatter:'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','} }
					, {name:"asbcCpDcAmt", label:'<spring:message code="column.asbc_cp_dc_amt" />', width:"100", align:"center", sortable:false, formatter:'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','} }
					, {name:"cartCpDcAmt", label:'<spring:message code="column.cart_cp_dc_amt" />', width:"100", align:"center", sortable:false, formatter:'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','} }
					, {name:"svmnDcAmt", label:'<spring:message code="column.svmn_dc_amt" />', width:"100", align:"center", formatter:'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','} }
					, {name:"realAsbAmt", label:'<spring:message code="column.real_asb_amt" />', width:"100", align:"center", formatter:'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','} }
					, {name:"realDlvrAmt", label:'<spring:message code="column.real_dlvr_amt" />', width:"100", align:"center", formatter:'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','} }
					, {name:"cmsRate", label:'<spring:message code="column.cms_rate" />', width:"100", align:"center", sortable:false, formatter:'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' %', thousandsSeparator:','} }
					, {name:"cmsAmt", label:'수수료', width:"100", align:"center", formatter:'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','} }
					, {name:"adjtAmt", label:'정산금액', width:"100", align:"center", formatter:'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','} }
					, {name:"adjtTax", label:'세액', width:"100", align:"center", formatter:'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','} }
				]
				, multiselect : false
				, paging : false
				, footerrow : true
				, userDataOnFooter : true
				, gridComplete : function () {
					// footer 처리 로직
					var saleAmt = $("#adjustmentDtlList" ).jqGrid('getCol', 'saleAmt', false, 'sum');
					var ordQty = $("#adjustmentDtlList" ).jqGrid('getCol', 'ordQty', false, 'sum');
					var payAmt = $("#adjustmentDtlList" ).jqGrid('getCol', 'payAmt', false, 'sum');
					var goodsCpDcAmt = $("#adjustmentDtlList" ).jqGrid('getCol', 'goodsCpDcAmt', false, 'sum');
					var dlvrcCpDcAmt = $("#adjustmentDtlList" ).jqGrid('getCol', 'dlvrcCpDcAmt', false, 'sum');
					var asbcCpDcAmt = $("#adjustmentDtlList" ).jqGrid('getCol', 'asbcCpDcAmt', false, 'sum');
					var cartCpDcAmt = $("#adjustmentDtlList" ).jqGrid('getCol', 'cartCpDcAmt', false, 'sum');
					var svmnDcAmt = $("#adjustmentDtlList" ).jqGrid('getCol', 'svmnDcAmt', false, 'sum');
					var realAsbAmt = $("#adjustmentDtlList" ).jqGrid('getCol', 'realAsbAmt', false, 'sum');
					var realDlvrAmt = $("#adjustmentDtlList" ).jqGrid('getCol', 'realDlvrAmt', false, 'sum');
					var cmsAmt = $("#adjustmentDtlList" ).jqGrid('getCol', 'cmsAmt', false, 'sum');
					var adjtAmt = $("#adjustmentDtlList" ).jqGrid('getCol', 'adjtAmt', false, 'sum');
					var adjtTax = $("#adjustmentDtlList" ).jqGrid('getCol', 'adjtTax', false, 'sum');

					$("#adjustmentDtlList" ).jqGrid('footerData', 'set',
							{ordNo : '합계 : '
								, saleAmt	: saleAmt
								, ordQty	: ordQty
								, payAmt	: payAmt
								, goodsCpDcAmt	: goodsCpDcAmt
								, dlvrcCpDcAmt	: dlvrcCpDcAmt
								, asbcCpDcAmt	: asbcCpDcAmt
								, cartCpDcAmt	: cartCpDcAmt
								, svmnDcAmt	: svmnDcAmt
								, realAsbAmt	: realAsbAmt
								, realDlvrAmt   : realDlvrAmt
								, cmsAmt	: cmsAmt
								, adjtAmt	: adjtAmt
								, adjtTax	: adjtTax }
					);
				}
			}
			grid.create("adjustmentDtlList", gridOptions);
		}

		function adjustmentListExcelDownload () {
			createFormSubmit( "adjustmentListExcelDownload", "/adjustment/pageAdjustmentExcelDownload.do", $("#adjustmentForm").serializeJson() );
		}

		function adjustmentDtlListExcelDownload () {
			var options = {
					sysRegDtmStart : $("#sysRegDtmStart").val()
					, sysRegDtmEnd : $("#sysRegDtmEnd").val()
					, pageGbCd : $("#selectPageGbCd").val()
				};
			createFormSubmit( "adjustmentDtlListExcelDownload", "/adjustment/pageAdjustmentDtlExcelDownload.do", options );
		}

		function selectDate () {
			var selYear = $("#selYear option:selected").val();
			var selMon = $("#selMon option:selected").val();

			var oMaxDay = new Date(new Date(selYear, selMon, 1) - 86400000).getDate();

			$("#sysRegDtmStart").val(toDateString (new Date(selYear, selMon - 1, 1), '-') );
			$("#sysRegDtmEnd").val(toDateString (new Date(selYear, selMon - 1, oMaxDay), '-') );

		}

		</script>
	</t:putAttribute>

	<t:putAttribute name="content">
		<div class="easyui-accordion search-accordion" data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect, gridResizeYn:'N'" style="width:100%">
			<div title="<spring:message code='admin.web.view.common.search' />" style="padding:10px">
				
				<form id="adjustmentForm" name="adjustmentForm" method="post" >
					<input type="hidden" name="selectCompNo" id="selectCompNo" value="" />
						<table class="table_type1">
							<caption>정보 검색</caption>
							<tbody>
								<tr>
									<th scope="row"><spring:message code="column.sys_reg_dtm" /></th> <!-- 기간 -->
									<td>
										<jsp:useBean id="now" class="java.util.Date" />
										<fmt:formatDate value="${now}" pattern="yyyy" var="year"/>
										<fmt:formatDate value="${now}" pattern="M" var="month"/>
				
										<select class="w90" id="selYear" name="selYear"  onchange="javascript:selectDate();" >
											<c:forEach begin="2010" end="2025" varStatus="i" >
												<option value="${i.index }" <c:if test="${year eq i.index }"> selected='selected'</c:if> >${i.index }년</option>
											</c:forEach>
										</select>
										<select class="w50" id="selMon" name="selMon"  onchange="javascript:selectDate();" >
											<c:forEach begin="1" end="12" varStatus="i" >
												<option value="${i.index }" <c:if test="${month eq i.index }"> selected='selected'</c:if> >${i.index }월</option>
											</c:forEach>
										</select> -
				
										<frame:datepicker startDate="sysRegDtmStart" endDate="sysRegDtmEnd" />
									</td>
									<th scope="row"><spring:message code="column.page_gb_cd" /></th> <!-- 업체번호 -->
									<td>
										<!-- 
										<select class="w175" name="pageGbCd" id="pageGbCd" title="<spring:message code="column.page_gb_cd" />" >
											<frame:select grpCd="${adminConstants.PAGE_GB }" defaultName="외부몰" usrDfn5Val="ADJT" />
										</select>-->
										<select name="pageGbCd" id='pageGbCd' class="wth100" title="선택상자" >
											<frame:select grpCd="${adminConstants.PAGE_GB }" defaultName="선택하세요"  />
										</select>
									</td>
								</tr>
							</tbody>
						</table>
				</form>
				<div class="btn_area_center">
					<button type="button" onclick="searchAdjust();" class="btn btn-ok">검색</button>
					<button type="button" onclick="searchReset();" class="btn btn-cancel">초기화</button>
				</div>
			</div>
		</div>
		<div class="mTitle mt30">
			<h2> 업체정산 리스트</h2>
			<div class="buttonArea">
				<button type="button" onclick="adjustmentListExcelDownload();" class="btn btn-add btn-excel">엑셀 다운로드</button>
			</div>
		</div>
		<div class="mModule no_m">
			<table id="adjustmentList"></table>
		</div>
		
		<div class="mTitle mt30">
			<h2> 업체정산 상세리스트</h2>
			<div class="buttonArea">
				<button type="button" onclick="adjustmentDtlListExcelDownload();" class="btn btn-add btn-excel">엑셀 다운로드</button>
			</div>
		</div>
		<div class="mModule no_m">
			<table id="adjustmentDtlList"></table>
		</div>
	</t:putAttribute>

</t:insertDefinition>