<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>

<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="title">업체정산</t:putAttribute>
	<t:putAttribute name="script">
		<script type="text/javascript">
		$(document).ready(function() {

			selectDate ();

			createAdjustGrid ();
			createAdjustDtlGrid ();
			
			grid.resize();
		});

		// 업체 검색
		function searchCompany () {
			var options = {
				multiselect : false
				, callBack : searchCompanyCallback
			}
			layerCompanyList.create (options );
		}
		function searchCompanyCallback (compList ) {
			if(compList.length > 0 ) {
				$("#adjustmentForm #compNo").val (compList[0].compNo );
				$("#adjustmentForm #compNm").val (compList[0].compNm );
			}
		}
		
        // 하위 업체 검색
        function searchLowCompany () {
            var options = {
                multiselect : false
                , callBack : searchLowCompanyCallback
<c:if test="${adminConstants.USR_GB_2010 eq adminSession.usrGbCd}">
                , showLowerCompany : 'Y'
</c:if>
            }
            layerCompanyList.create (options );
        }
        // 업체 검색 콜백
        function searchLowCompanyCallback(compList) {
            if(compList.length > 0) {
                $("#adjustmentForm #lowCompNo").val (compList[0].compNo);
                $("#adjustmentForm #lowCompNm").val (compList[0].compNm);
            }
        }
        
        $(document).on("click", "input:checkbox[name=showAllLowComp]", function(e){
            if ($(this).is(":checked") == true) {
                $("#showAllLowCompany").val("Y");   
            } else {
                $("#showAllLowCompany").val("N");
            }
        });

		// 초기화 버튼클릭
		function searchReset () {
			resetForm ("adjustmentForm");
            <c:if test="${adminConstants.USR_GRP_10 ne adminSession.usrGrpCd}">
            $("#adjustmentForm #compNo").val('${adminSession.compNo}');
            $("#adjustmentForm #showAllLowCompany").val("N");
            </c:if>
		}

		function searchAdjust () {
			var options = {
				searchParam : $("#adjustmentForm").serializeJson()
			};
			$("#adjustmentDtlList").jqGrid('clearGridData');
			$("#selectCompNo").val('' );
			grid.reload("adjustmentList", options);
		}

		// 상품 Grid
		function createAdjustGrid () {
			var gridOptions = {
				url : "<spring:url value='/adjustment/compAdjustmentGrid.do' />"
				, height : 300
				, searchParam : $("#adjustmentForm").serializeJson()
				, colModels : [
					{name:"compNo", label:'', width:"100", align:"center", sortable:false, key: true, hidden:true } /* 업체번호 */
					, {name:"compNm", label:"<spring:message code='column.goods.comp_nm' />", width:"200", align:"center", sortable:false } /* 업체명 */
					, {name:"saleAmt", label:"<spring:message code='column.sale_prc' />", width:"100", align:"center", sortable:false, formatter: 'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','} } /* 판매가 */
					, {name:"payAmt", label:'<spring:message code="column.order_common.pay_dtl_amt" />', width:"100", align:"center", sortable:false, formatter:'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','} }
					, {name:"pay10Amt", label:'무통장', width:"100", align:"center", sortable:false, formatter:'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','} }
					, {name:"pay20Amt", label:'가상계좌', width:"100", align:"center", sortable:false, formatter:'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','} }
					, {name:"pay30Amt", label:'실시간', width:"100", align:"center", sortable:false, formatter:'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','} }
					, {name:"pay40Amt", label:'신용카드', width:"100", align:"center", sortable:false, formatter:'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','} }
					, {name:"pay50Amt", label:'페이코', width:"100", align:"center", sortable:false, formatter:'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','} }
					//, {name:"pay06Amt", label:'휴대폰', width:"100", align:"center", sortable:false, formatter:'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','} }
					//, {name:"pay07Amt", label:'쇼룸', width:"100", align:"center", sortable:false, formatter:'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','} }
					, {name:"pay90Amt", label:'외부몰', width:"100", align:"center", sortable:false, formatter:'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','} }
					, {name:"goodsCpDcAmt", label:'<spring:message code="column.goods_cp_dc_amt" />', width:"100", align:"center", sortable:false, formatter:'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','} }
					, {name:"dlvrcCpDcAmt", label:'<spring:message code="column.dlvrc_cp_dc_amt" />', width:"100", align:"center", sortable:false, formatter:'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','} }
					, {name:"asbcCpDcAmt", label:'<spring:message code="column.asbc_cp_dc_amt" />', width:"100", align:"center", sortable:false, formatter:'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','} }
					, {name:"cartCpDcAmt", label:'<spring:message code="column.cart_cp_dc_amt" />', width:"100", align:"center", sortable:false, formatter:'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','} }
					, {name:"svmnDcAmt", label:'<spring:message code="column.svmn_dc_amt" />', width:"100", align:"center", formatter:'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','} }
					, {name:"realAsbAmt", label:'<spring:message code="column.real_asb_amt" />', width:"100", align:"center", formatter:'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','} }
					, {name:"realDlvrAmt", label:'<spring:message code="column.real_dlvr_amt" />', width:"100", align:"center", formatter:'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','} }
					, {name:"cmsAmt", label:'수수료', width:"100", align:"center", formatter:'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','} }
					, {name:"adjtAmt", label:'정산금액', width:"100", align:"center", formatter:'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','} }
					, {name:"adjtTax", label:'세액', width:"100", align:"center", formatter:'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','} }
				]
				, multiselect : false
				, paging : false
				, onSelectRow : function(ids) {
					var rowdata = $("#adjustmentList").getRowData(ids);
					$("#selectCompNo").val(rowdata.compNo );
					reloadDetailGrid(rowdata.compNo );
				}
				, footerrow : true
				, userDataOnFooter : true
				, gridComplete : function () {
					// footer 처리 로직
					var saleAmt = $("#adjustmentList" ).jqGrid('getCol', 'saleAmt', false, 'sum');
					var payAmt = $("#adjustmentList" ).jqGrid('getCol', 'payAmt', false, 'sum');
					var pay10Amt = $("#adjustmentList" ).jqGrid('getCol', 'pay10Amt', false, 'sum');
					var pay20Amt = $("#adjustmentList" ).jqGrid('getCol', 'pay20Amt', false, 'sum');
					var pay30Amt = $("#adjustmentList" ).jqGrid('getCol', 'pay30Amt', false, 'sum');
					var pay40Amt = $("#adjustmentList" ).jqGrid('getCol', 'pay40Amt', false, 'sum');
					var pay50Amt = $("#adjustmentList" ).jqGrid('getCol', 'pay50Amt', false, 'sum');
					//var pay06Amt = $("#adjustmentList" ).jqGrid('getCol', 'pay06Amt', false, 'sum');
					//var pay07Amt = $("#adjustmentList" ).jqGrid('getCol', 'pay07Amt', false, 'sum');
					var pay90Amt = $("#adjustmentList" ).jqGrid('getCol', 'pay90Amt', false, 'sum');
					var goodsCpDcAmt = $("#adjustmentList" ).jqGrid('getCol', 'goodsCpDcAmt', false, 'sum');
					var dlvrcCpDcAmt = $("#adjustmentList" ).jqGrid('getCol', 'dlvrcCpDcAmt', false, 'sum');
					var asbcCpDcAmt = $("#adjustmentList" ).jqGrid('getCol', 'asbcCpDcAmt', false, 'sum');
					var cartCpDcAmt = $("#adjustmentList" ).jqGrid('getCol', 'cartCpDcAmt', false, 'sum');
					var svmnDcAmt = $("#adjustmentList" ).jqGrid('getCol', 'svmnDcAmt', false, 'sum');
					var realAsbAmt = $("#adjustmentList" ).jqGrid('getCol', 'realAsbAmt', false, 'sum');
					var realDlvrAmt = $("#adjustmentList" ).jqGrid('getCol', 'realDlvrAmt', false, 'sum');
					var cmsAmt = $("#adjustmentList" ).jqGrid('getCol', 'cmsAmt', false, 'sum');
					var adjtAmt = $("#adjustmentList" ).jqGrid('getCol', 'adjtAmt', false, 'sum');
					var adjtTax = $("#adjustmentList" ).jqGrid('getCol', 'adjtTax', false, 'sum');

					$("#adjustmentList" ).jqGrid('footerData', 'set',
							{compNm : '합계 : '
								, saleAmt: saleAmt
								, payAmt: payAmt
								, pay10Amt: pay10Amt
								, pay20Amt: pay20Amt
								, pay30Amt: pay30Amt
								, pay40Amt: pay40Amt
								, pay50Amt: pay50Amt
								, pay90Amt: pay90Amt
								, goodsCpDcAmt: goodsCpDcAmt
								, dlvrcCpDcAmt: dlvrcCpDcAmt
								, asbcCpDcAmt: asbcCpDcAmt
								, cartCpDcAmt: cartCpDcAmt
								, svmnDcAmt: svmnDcAmt
								, realAsbAmt: realAsbAmt
								, realDlvrAmt: realDlvrAmt
								, cmsAmt: cmsAmt
								, adjtAmt: adjtAmt
								, adjtTax : adjtTax }
					);
				}
			}
			grid.create("adjustmentList", gridOptions);
		}

		function reloadDetailGrid (compNo ) {
			var options = {
					searchParam : {
						sysRegDtmStart : $("#sysRegDtmStart").val()
						, sysRegDtmEnd : $("#sysRegDtmEnd").val()
						, compNo : compNo
					}
				};
				grid.reload("adjustmentDtlList", options);
		}

		// 상품 Grid
		function createAdjustDtlGrid () {
			var gridOptions = {
				url : "<spring:url value='/adjustment/compAdjustmentDtlGrid.do' />"
				, height : 400
				, searchParam : { /* 초기 데이터는 읽지 않는다 */
					sysRegDtmStart : $("#sysRegDtmStart").val()
					, sysRegDtmEnd : $("#sysRegDtmEnd").val()
					, compNo : '-1'
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
								, adjtTax   : adjtTax }
					);
				}
			}
			grid.create("adjustmentDtlList", gridOptions);
		}

		function adjustmentListExcelDownload () {
			createFormSubmit( "adjustmentListExcelDownload", "/adjustment/compAdjustmentExcelDownload.do", $("#adjustmentForm").serializeJson() );
		}

		function adjustmentDtlListExcelDownload () {
			var options = {
					sysRegDtmStart : $("#sysRegDtmStart").val()
					, sysRegDtmEnd : $("#sysRegDtmEnd").val()
					, compNo : $("#selectCompNo").val()
				};
			createFormSubmit( "adjustmentDtlListExcelDownload", "/adjustment/compAdjustmentDtlExcelDownload.do", options );
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
								<th scope="row"><spring:message code="column.goods.comp_no" /></th> <!-- 업체번호 -->
								<td>
									<frame:compNo funcNm="searchCompany" disableSearchYn="${adminConstants.USR_GRP_10 eq adminSession.usrGrpCd ? 'N' : 'Y'}" placeholder="${adminConstants.USR_GRP_10 eq adminSession.usrGrpCd ? '입점업체를 검색하세요' : ''}"/>
									<c:if test="${adminConstants.USR_GB_2010 eq adminSession.usrGbCd}">
	                                       &nbsp;&nbsp;&nbsp;<frame:lowCompNo funcNm="searchLowCompany" placeholder="하위업체를 검색하세요"/>
	                                       &nbsp;&nbsp;&nbsp;<input type="checkbox" id="showAllLowComp" name="showAllLowComp"><span>하위업체 전체 선택</span>
	                                       <input type="hidden" id="showAllLowCompany" name="showAllLowCompany" value="N"/>
	                                   </c:if>
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
			<table id="adjustmentList" ></table>
			<div id="adjustmentListPage"></div>
		</div>

		<div class="mTitle mt30">
			<h2> 업체정산 상세리스트</h2>
			<div class="buttonArea">
				<button type="button" onclick="adjustmentDtlListExcelDownload();" class="btn btn-add btn-excel">엑셀 다운로드</button>
			</div>
		</div>
		<div class="mModule no_m">
			<table id="adjustmentDtlList" ></table>
			<div id="adjustmentDtlListPage"></div>
		</div>

	</t:putAttribute>

</t:insertDefinition>