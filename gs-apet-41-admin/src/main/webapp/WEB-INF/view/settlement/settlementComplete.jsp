<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>

<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">
		$(document).ready(function() {

			selectDate ();

			createSettleGrid ();
			createSettleDtlGrid ();
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
				$("#settlementForm #compNo").val (compList[0].compNo );
				$("#settlementForm #compNm").val (compList[0].compNm );
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
                $("#settlementForm #lowCompNo").val (compList[0].compNo);
                $("#settlementForm #lowCompNm").val (compList[0].compNm);
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
			resetForm ("settlementForm");
            <c:if test="${adminConstants.USR_GRP_10 ne adminSession.usrGrpCd}">
            $("#settlementForm #compNo").val('${adminSession.compNo}');
            $("#settlementForm #showAllLowCompany").val("N");
            </c:if>
		}

		function searchSettle () {
			var options = {
				searchParam : $("#settlementForm").serializeJson()
			};
			$("#settlementCompleteDtl").jqGrid('clearGridData');
			$("#selectCompNo").val('' );
			grid.reload("settlementComplete", options);
		}

		// createSettleGrid
		function createSettleGrid () {
			var gridOptions = {
				url : "<spring:url value='/settlement/settlementCompleteGrid.do' />"
				, height : 300
				, searchParam : $("#settlementForm").serializeJson()
				, colModels : [
					{name:"stlNo", label:"<spring:message code='column.settlement.stl_no' />", width:"100", align:"center", sortable:false, hidden:true }
					, {name:"stlMonth", label:"<spring:message code='column.settlement.stl_month' />", width:"100", align:"center", sortable:false }
					, {name:"stId", label:"<spring:message code='column.settlement.st_id' />", width:"100", align:"center", sortable:false, hidden:true }           
					, {name:"stNm", label:"<spring:message code='column.settlement.st_nm' />", width:"100", align:"center", sortable:false }
					, {name:"stlOrder", label:"<spring:message code='column.settlement.stl_order' />", width:"100", align:"center", sortable:false } 
					, {name:"stlTerm", label:"<spring:message code='column.settlement.stl_term' />", width:"150", align:"center", sortable:false } 
					, {name:"compNo", label:"<spring:message code='column.settlement.comp_no' />", width:"100", align:"center", sortable:false, hidden:true}
					, {name:"compNm", label:"<spring:message code='column.settlement.comp_nm' />", width:"100", align:"center", sortable:false }
					, {name:"compGbNm", label:"<spring:message code='column.settlement.comp_gb_nm' />", width:"100", align:"center", sortable:false }
					, {name:"saleAmt", label:"<spring:message code='column.settlement.sale_amt' />", width:"100", align:"center", sortable:false, formatter: 'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','} }
					, {name:"brkrCms", label:"<spring:message code='column.settlement.brkr_cms' />", width:"100", align:"center", sortable:false, formatter: 'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','} }
					, {name:"compSaleAmt", label:"<spring:message code='column.settlement.comp_sale_amt' />", width:"100", align:"center", sortable:false, formatter: 'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','} }
					, {name:"dcAmt", label:"<spring:message code='column.settlement.dc_amt' />", width:"100", align:"center", sortable:false, formatter: 'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','} }
					, {name:"brkrBdnDcAmt", label:"<spring:message code='column.settlement.brkr_bdn_dc_amt' />", width:"120", align:"center", sortable:false, formatter: 'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','} }
					, {name:"compBdnDcAmt", label:"<spring:message code='column.settlement.comp_bdn_dc_amt' />", width:"120", align:"center", sortable:false, formatter: 'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','} }
					, {name:"rfdAmt", label:"<spring:message code='column.settlement.rfd_amt' />", width:"100", align:"center", sortable:false, formatter: 'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','} }
					, {name:"brkrRfdCms", label:"<spring:message code='column.settlement.brkr_rfd_cms' />", width:"100", align:"center", sortable:false, formatter: 'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','} }
					, {name:"compRfdAmt", label:"<spring:message code='column.settlement.comp_rfd_amt' />", width:"100", align:"center", sortable:false, formatter: 'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','} }
					, {name:"ordDlvrc", label:"<spring:message code='column.settlement.ord_dlvrc' />", width:"100", align:"center", sortable:false, formatter: 'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','} }
					, {name:"clmDlvrc", label:"<spring:message code='column.settlement.clm_dlvrc' />", width:"100", align:"center", sortable:false, formatter: 'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','} }
					, {name:"mrgAmt", label:"<spring:message code='column.settlement.mrg_amt' />", width:"100", align:"center", sortable:false, formatter: 'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','} }
					, {name:"compStlAmt", label:"<spring:message code='column.settlement.comp_stl_amt' />", width:"100", align:"center", sortable:false, formatter: 'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','} }
					, {name:"rtnRsrvRate", label:"<spring:message code='column.settlement.rtn_rsrv_rate' />", width:"100", align:"center", sortable:false, formatter:'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' %', thousandsSeparator:','} }
					, {name:"rtnRsrvAmt", label:"<spring:message code='column.settlement.rtn_rsrv_amt' />", width:"100", align:"center", sortable:false, formatter: 'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','} }
					, {name:"preRtnRsrvAmt", label:"<spring:message code='column.settlement.pre_rtn_rsrv_amt' />", width:"100", align:"center", sortable:false, formatter: 'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','} }
					, {name:"realStlAmt", label:"<spring:message code='column.settlement.real_stl_amt' />", width:"100", align:"center", sortable:false, formatter: 'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','} }
					, {name:"bankNm", label:"<spring:message code='column.settlement.bank_nm' />", width:"100", align:"center", sortable:false }
					, {name:"acctNo", label:"<spring:message code='column.settlement.acct_no' />", width:"100", align:"center", sortable:false }
					, {name:"ooaNm", label:"<spring:message code='column.settlement.ooa_nm' />", width:"100", align:"center", sortable:false }
					, {name:"pvdStatNm", label:"<spring:message code='column.settlement.pvd_stat_nm' />", width:"100", align:"center", sortable:false }
					, {name:"mdUsrNm", label:"<spring:message code='column.settlement.md_usr_nm' />", width:"100", align:"center", sortable:false }
				]
				
				, multiselect : true
				, paging : true
				, onSelectRow : function(ids) {
					var rowdata = $("#settlementComplete").getRowData(ids);
					$("#selectStlNo").val(rowdata.stlNo );
					$("#selectStlMonth").val(rowdata.stlMonth );					
					$("#selectStlOrder").val(rowdata.stlOrder );
					$("#selectCompNo").val(rowdata.compNo );
					$("#selectStId").val(rowdata.stId );
					//reloadDetailGrid(rowdata.compNo, rowdata.stId, rowdata.stlNo);
					reloadDetailGrid(rowdata.stlMonth, rowdata.stlOrder, rowdata.compNo, rowdata.stId);
				}
				, footerrow : true
				, userDataOnFooter : true
				, gridComplete : function () {
					// footer 처리 로직
					var saleAmt = $("#settlementComplete" ).jqGrid('getCol', 'saleAmt', false, 'sum');
					var brkrCms = $("#settlementComplete" ).jqGrid('getCol', 'brkrCms', false, 'sum');
					var compSaleAmt = $("#settlementComplete" ).jqGrid('getCol', 'compSaleAmt', false, 'sum');
					var dcAmt = $("#settlementComplete" ).jqGrid('getCol', 'dcAmt', false, 'sum');
					var brkrBdnDcAmt = $("#settlementComplete" ).jqGrid('getCol', 'brkrBdnDcAmt', false, 'sum');
					var compBdnDcAmt = $("#settlementComplete" ).jqGrid('getCol', 'compBdnDcAmt', false, 'sum');
					var rfdAmt = $("#settlementComplete" ).jqGrid('getCol', 'rfdAmt', false, 'sum');
					var brkrRfdCms = $("#settlementComplete" ).jqGrid('getCol', 'brkrRfdCms', false, 'sum');
					var compRfdAmt = $("#settlementComplete" ).jqGrid('getCol', 'compRfdAmt', false, 'sum');
					var ordDlvrc = $("#settlementComplete" ).jqGrid('getCol', 'ordDlvrc', false, 'sum');
					var clmDlvrc = $("#settlementComplete" ).jqGrid('getCol', 'clmDlvrc', false, 'sum');
					var mrgAmt = $("#settlementComplete" ).jqGrid('getCol', 'mrgAmt', false, 'sum');
					var compStlAmt = $("#settlementComplete" ).jqGrid('getCol', 'compStlAmt', false, 'sum');
					//var rtnRsrvRate = $("#settlementComplete" ).jqGrid('getCol', 'rtnRsrvRate', false, 'sum');
					var rtnRsrvAmt = $("#settlementComplete" ).jqGrid('getCol', 'rtnRsrvAmt', false, 'sum');
					var preRtnRsrvAmt = $("#settlementComplete" ).jqGrid('getCol', 'preRtnRsrvAmt', false, 'sum');
					var realStlAmt = $("#settlementComplete" ).jqGrid('getCol', 'realStlAmt', false, 'sum');

					$("#settlementComplete" ).jqGrid('footerData', 'set',
						{	compNm : '합계 : '
							, saleAmt: saleAmt
							, brkrCms: brkrCms
							, compSaleAmt: compSaleAmt
							, dcAmt: dcAmt
							, brkrBdnDcAmt: brkrBdnDcAmt
							, compBdnDcAmt: compBdnDcAmt
							, rfdAmt: rfdAmt
							, brkrRfdCms: brkrRfdCms
							, compRfdAmt: compRfdAmt
							, ordDlvrc: ordDlvrc
							, clmDlvrc: clmDlvrc
							, mrgAmt: mrgAmt
							, compStlAmt: compStlAmt
							//, rtnRsrvRate: rtnRsrvRate
							, rtnRsrvAmt: rtnRsrvAmt
							, preRtnRsrvAmt: preRtnRsrvAmt
							, realStlAmt: realStlAmt 
						}
					);
				}
			}
			grid.create("settlementComplete", gridOptions);
		}
/*		
		function reloadDetailGrid (compNo, stId, stlNo) {
			var options = {
					searchParam : {
						compNo : compNo
						, stId : stId
						, stlNo : stlNo
					}
				};
			grid.reload("settlementCompleteDtl", options);
		}
*/		
		function reloadDetailGrid (stlMonth, stlOrder, compNo, stId) {
			var options = {
					searchParam : {
						stlMonth : stlMonth
						, stlOrder : stlOrder
						, compNo : compNo
						, stId : stId
					}
				};
			grid.reload("settlementCompleteDtl", options);
		}		

		// createSettleDtlGrid
		function createSettleDtlGrid () {
			var gridOptions = {
				url : "<spring:url value='/settlement/settlementCompleteDtlGrid.do' />"
				, height : 400
				, searchParam : { /* 초기 데이터는 읽지 않는다 */
					stlMonth : '-1'
					, stlOrder : '-1'
					, compNo : '-1'
					, stId : '-1'
					// , stlNo : '-1'
				}
				, colModels : [
					{name:"stId", label:"<spring:message code='column.settlement.st_id' />", width:"100", align:"center", sortable:false, hidden:true }           
					, {name:"stNm", label:"<spring:message code='column.settlement.st_nm' />", width:"100", align:"center", sortable:false }
					, {name:"compNo", label:"<spring:message code='column.settlement.comp_no' />", width:"100", align:"center", sortable:false, hidden:true }
					, {name:"orgCompNo", label:"<spring:message code='column.settlement.org_comp_no' />", width:"100", align:"center", sortable:false, hidden:true }
					, {name:"compNm", label:"<spring:message code='column.settlement.comp_nm' />", width:"100", align:"center", sortable:false }
					, {name:"compGbNm", label:"<spring:message code='column.settlement.comp_gb_nm' />", width:"100", align:"center", sortable:false }
					, {name:"acptDtm", label:"<spring:message code='column.settlement.acpt_dtm' />", width:"120", align:"center", sortable:false, formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss" }
					, {name:"ordNo", label:'<spring:message code="column.settlement.ord_no" />', width:"110", align:"center", sortable:false, key: true }
					, {name:"ordDtlSeq", label:'<spring:message code="column.settlement.ord_dtl_seq" />', width:"100", align:"center", sortable:false, formatter:'integer', hidden:true }
					, {name:"clmNo", label:'<spring:message code="column.settlement.clm_no" />', width:"110", align:"center", sortable:false, key: true }
					, {name:"clmDtlSeq", label:'<spring:message code="column.settlement.clm_dtl_seq" />', width:"100", align:"center", sortable:false, formatter:'integer', hidden:true }
					, {name:"stlNo", label:"<spring:message code='column.settlement.stl_no' />", width:"100", align:"center", sortable:false, hidden:true }
					, {name:"stlOrdTpNm", label:'<spring:message code="column.settlement.stl_ord_tp_nm" />', width:"100", align:"center", sortable:false }
					, {name:"ordNm", label:'<spring:message code="column.settlement.ord_nm" />', width:"100", align:"center", sortable:false }
					, {name:"ordrId", label:'<spring:message code="column.settlement.ordr_id" />', width:"100", align:"center", sortable:false }
					, {name:"goodsId", label:'<spring:message code="column.settlement.goods_id" />', width:"100", align:"center", sortable:false }
					, {name:"goodsNm", label:'<spring:message code="column.settlement.goods_nm" />', width:"100", align:"center", sortable:false }
					, {name:"itemNo", label:'<spring:message code="column.settlement.item_no" />', width:"100", align:"center", sortable:false, hidden:true }
					, {name:"itemNm", label:'<spring:message code="column.settlement.item_nm" />', width:"100", align:"center", sortable:false }
					, {name:"saleAmt", label:'<spring:message code="column.settlement.sale_amt" />', width:"100", align:"center", sortable:false, formatter: 'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','} } /* 판매가 */
					, {name:"stlTgQty", label:'<spring:message code="column.settlement.stl_tg_qty" />', width:"100", align:"center", formatter:'integer', sortable:false }
					, {name:"saleTotAmt", label:'<spring:message code="column.settlement.sale_tot_amt" />', width:"100", align:"center", sortable:false, formatter: 'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','} } /* 판매가 */
					, {name:"dcAmt", label:"<spring:message code='column.settlement.dc_amt' />", width:"100", align:"center", sortable:false, formatter: 'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','} } /* 판매가 */
					, {name:"svmnUseAmt", label:'<spring:message code="column.settlement.svmn_use_amt" />', width:"100", align:"center", formatter:'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','} }
					, {name:"dlvrc", label:"<spring:message code='column.settlement.dlvrc' />", width:"100", align:"center", sortable:false, formatter: 'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','} } /* 판매가 */
					, {name:"dlvrcDcAmt", label:"<spring:message code='column.settlement.dlvrc_dc_amt' />", width:"100", align:"center", sortable:false, formatter: 'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','} } /* 판매가 */
					, {name:"payAmt", label:'<spring:message code="column.settlement.pay_amt" />', width:"100", align:"center", sortable:false, formatter:'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','} }
					, {name:"payMeansNm", label:'<spring:message code="column.settlement.pay_means_nm" />', width:"100", align:"center", sortable:false }
					, {name:"prmtBdnDcTotAmt", label:'<spring:message code="column.settlement.prmt_bdn_dc_tot_amt" />', width:"120", align:"center", sortable:false, formatter:'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','} }
					, {name:"prmtBrkrBdnDcAmt", label:'<spring:message code="column.settlement.prmt_brkr_bdn_dc_amt" />', width:"120", align:"center", sortable:false, formatter:'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','} }
					, {name:"prmtCompBdnDcAmt", label:'<spring:message code="column.settlement.prmt_comp_bdn_dc_amt" />', width:"120", align:"center", sortable:false, formatter:'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','} }
					, {name:"gcBdnDcTotAmt", label:'<spring:message code="column.settlement.gc_bdn_dc_tot_amt" />', width:"120", align:"center", sortable:false, formatter:'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','} }
					, {name:"gcBrkrBdnDcAmt", label:'<spring:message code="column.settlement.gc_brkr_bdn_dc_amt" />', width:"150", align:"center", sortable:false, formatter:'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','} }
					, {name:"gcCompBdnDcAmt", label:'<spring:message code="column.settlement.gc_comp_bdn_dc_amt" />', width:"150", align:"center", sortable:false, formatter:'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','} }
					, {name:"ccBdnDcTotAmt", label:'<spring:message code="column.settlement.cc_bdn_dc_tot_amt" />', width:"120", align:"center", sortable:false, formatter:'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','} }
					, {name:"ccBrkrBdnDcAmt", label:'<spring:message code="column.settlement.cc_brkr_bdn_dc_amt" />', width:"150", align:"center", sortable:false, formatter:'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','} }
					, {name:"ccCompBdnDcAmt", label:'<spring:message code="column.settlement.cc_comp_bdn_dc_amt" />', width:"150", align:"center", formatter:'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','} }
					, {name:"dcBdnDcTotAmt", label:'<spring:message code="column.settlement.dc_bdn_dc_tot_amt" />', width:"120", align:"center", sortable:false, formatter:'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','} }
					, {name:"dcBrkrBdnDcAmt", label:'<spring:message code="column.settlement.dc_brkr_bdn_dc_amt" />', width:"150", align:"center", formatter:'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','} }
					, {name:"dcCompBdnDcAmt", label:'<spring:message code="column.settlement.dc_comp_bdn_dc_amt" />', width:"150", align:"center", formatter:'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','} }
					, {name:"brkrDcTotAmt", label:'<spring:message code="column.settlement.brkr_dc_tot_amt" />', width:"150", align:"center", sortable:false, formatter:'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','} }
					, {name:"compDcTotAmt", label:'<spring:message code="column.settlement.comp_dc_tot_amt" />', width:"150", align:"center", sortable:false, formatter:'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','} }
					, {name:"clmDlvrc", label:"<spring:message code='column.settlement.clm_dlvrc' />", width:"120", align:"center", sortable:false, formatter: 'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','} }
					, {name:"cmsRate", label:'<spring:message code="column.settlement.cms_rate" />', width:"120", align:"center", sortable:false, formatter:'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' %', thousandsSeparator:','} }
					, {name:"saleMrgAmt", label:"<spring:message code='column.settlement.sale_mrg_amt' />", width:"120", align:"center", formatter:'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','} }
					, {name:"realMrgAmt", label:"<spring:message code='column.settlement.real_mrg_amt' />", width:"120", align:"center", formatter:'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','} }
					, {name:"saleSetAmt", label:'<spring:message code="column.settlement.sale_set_amt" />', width:"120", align:"center", sortable:false, formatter:'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','} }
					, {name:"compSaleDcAmt", label:'<spring:message code="column.settlement.comp_sale_dc_amt" />', width:"120", align:"center", sortable:false, formatter:'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','} }
					, {name:"dlvrcTotAmt", label:'<spring:message code="column.settlement.dlvrc_tot_amt" />', width:"120", align:"center", sortable:false, formatter:'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','} }
					, {name:"compBdnDlvrcDcAmt", label:'<spring:message code="column.settlement.comp_bdn_dlvrc_dc_amt" />', width:"120", align:"center", sortable:false, formatter:'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','} }
					, {name:"setTotAmt", label:'<spring:message code="column.settlement.set_tot_amt" />', width:"150", align:"center", sortable:false, formatter:'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','} }
				
				]
				, multiselect : false
				, paging : true
				, footerrow : true
				, userDataOnFooter : true
				, gridComplete : function () {
					// footer 처리 로직
					var saleAmt = $("#settlementCompleteDtl" ).jqGrid('getCol', 'saleAmt', false, 'sum');
					var stlTgQty = $("#settlementCompleteDtl" ).jqGrid('getCol', 'stlTgQty', false, 'sum');
					var saleTotAmt = $("#settlementCompleteDtl" ).jqGrid('getCol', 'saleTotAmt', false, 'sum');
					var dcAmt = $("#settlementCompleteDtl" ).jqGrid('getCol', 'dcAmt', false, 'sum');
					var payAmt = $("#settlementCompleteDtl" ).jqGrid('getCol', 'payAmt', false, 'sum');
					var svmnUseAmt = $("#settlementCompleteDtl" ).jqGrid('getCol', 'svmnUseAmt', false, 'sum');
					var dlvrc = $("#settlementCompleteDtl" ).jqGrid('getCol', 'dlvrc', false, 'sum');
					var dlvrcDcAmt = $("#settlementCompleteDtl" ).jqGrid('getCol', 'dlvrcDcAmt', false, 'sum');
					var payAmt = $("#settlementCompleteDtl" ).jqGrid('getCol', 'payAmt', false, 'sum');
					var prmtBdnDcTotAmt = $("#settlementCompleteDtl" ).jqGrid('getCol', 'prmtBdnDcTotAmt', false, 'sum');
					var prmtBrkrBdnDcAmt = $("#settlementCompleteDtl" ).jqGrid('getCol', 'prmtBrkrBdnDcAmt', false, 'sum');
					var prmtCompBdnDcAmt = $("#settlementCompleteDtl" ).jqGrid('getCol', 'prmtCompBdnDcAmt', false, 'sum');
					var gcBdnDcTotAmt = $("#settlementCompleteDtl" ).jqGrid('getCol', 'gcBdnDcTotAmt', false, 'sum');
					var gcBrkrBdnDcAmt = $("#settlementCompleteDtl" ).jqGrid('getCol', 'gcBrkrBdnDcAmt', false, 'sum');
					var gcCompBdnDcAmt = $("#settlementCompleteDtl" ).jqGrid('getCol', 'gcCompBdnDcAmt', false, 'sum');
					var ccBdnDcTotAmt = $("#settlementCompleteDtl" ).jqGrid('getCol', 'ccBdnDcTotAmt', false, 'sum');
					var ccBrkrBdnDcAmt = $("#settlementCompleteDtl" ).jqGrid('getCol', 'ccBrkrBdnDcAmt', false, 'sum');
					var ccCompBdnDcAmt = $("#settlementCompleteDtl" ).jqGrid('getCol', 'ccCompBdnDcAmt', false, 'sum');
					var dcBdnDcTotAmt = $("#settlementCompleteDtl" ).jqGrid('getCol', 'dcBdnDcTotAmt', false, 'sum');
					var dcBrkrBdnDcAmt = $("#settlementCompleteDtl" ).jqGrid('getCol', 'dcBrkrBdnDcAmt', false, 'sum');
					var dcCompBdnDcAmt = $("#settlementCompleteDtl" ).jqGrid('getCol', 'dcCompBdnDcAmt', false, 'sum');
					var ccBrkrBdnDcTotAmt = $("#settlementCompleteDtl" ).jqGrid('getCol', 'ccBrkrBdnDcTotAmt', false, 'sum');
					var brkrDcTotAmt = $("#settlementCompleteDtl" ).jqGrid('getCol', 'brkrDcTotAmt', false, 'sum');
					var compDcTotAmt = $("#settlementCompleteDtl" ).jqGrid('getCol', 'compDcTotAmt', false, 'sum');
					var clmDlvrc = $("#settlementCompleteDtl" ).jqGrid('getCol', 'clmDlvrc', false, 'sum');
					//var cmsRate = $("#settlementCompleteDtl" ).jqGrid('getCol', 'cmsRate', false, 'sum');
					var saleMrgAmt = $("#settlementCompleteDtl" ).jqGrid('getCol', 'saleMrgAmt', false, 'sum');
					var realMrgAmt = $("#settlementCompleteDtl" ).jqGrid('getCol', 'realMrgAmt', false, 'sum');
					var saleSetAmt = $("#settlementCompleteDtl" ).jqGrid('getCol', 'saleSetAmt', false, 'sum');
					var compSaleDcAmt = $("#settlementCompleteDtl" ).jqGrid('getCol', 'compSaleDcAmt', false, 'sum');
					var dlvrcTotAmt = $("#settlementCompleteDtl" ).jqGrid('getCol', 'dlvrcTotAmt', false, 'sum');
					var compBdnDlvrcDcAmt = $("#settlementCompleteDtl" ).jqGrid('getCol', 'compBdnDlvrcDcAmt', false, 'sum');
					var setTotAmt = $("#settlementCompleteDtl" ).jqGrid('getCol', 'setTotAmt', false, 'sum');

					$("#settlementCompleteDtl" ).jqGrid('footerData', 'set',
						{itemNm : '합계 : '
							, saleAmt	: saleAmt
							, stlTgQty	: stlTgQty
							, saleTotAmt	: saleTotAmt
							, dcAmt	: dcAmt
							, payAmt	: payAmt
							, svmnUseAmt	: svmnUseAmt
							, dlvrc	: dlvrc
							, dlvrcDcAmt	: dlvrcDcAmt
							, payAmt	: payAmt
							, prmtBdnDcTotAmt	: prmtBdnDcTotAmt
							, prmtBrkrBdnDcAmt	: prmtBrkrBdnDcAmt
							, prmtCompBdnDcAmt	: prmtCompBdnDcAmt
							, gcBdnDcTotAmt	: gcBdnDcTotAmt
							, gcBrkrBdnDcAmt	: gcBrkrBdnDcAmt
							, gcCompBdnDcAmt   	: gcCompBdnDcAmt
							, ccBdnDcTotAmt	: ccBdnDcTotAmt
							, ccBrkrBdnDcAmt	: ccBrkrBdnDcAmt
							, ccCompBdnDcAmt	: ccCompBdnDcAmt
							, dcBdnDcTotAmt   	: dcBdnDcTotAmt 
							, dcBrkrBdnDcAmt   	: dcBrkrBdnDcAmt 
							, dcCompBdnDcAmt   	: dcCompBdnDcAmt
							, ccBrkrBdnDcTotAmt   	: ccBrkrBdnDcTotAmt
							, clmDlvrc   	: clmDlvrc 
							//, cmsRate   	: cmsRate
							, saleMrgAmt   	: saleMrgAmt
							, realMrgAmt   	: realMrgAmt 
							, saleSetAmt   	: saleSetAmt
							, compSaleDcAmt   	: compSaleDcAmt
							, dlvrcTotAmt   	: dlvrcTotAmt
							, compBdnDlvrcDcAmt   	: compBdnDlvrcDcAmt
							, setTotAmt   	: setTotAmt
						}
					);
				}
			}
			grid.create("settlementCompleteDtl", gridOptions);
		}

		function settlementCompleteExcelDownload () {
			createFormSubmit( "settlementCompleteExcelDownload", "/settlement/settlementCompleteExcelDownload.do", $("#settlementForm").serializeJson() );
		}
		
		function settlementCompleteTaxInvoiceExcelDownload () {
			var grid = $("#settlementComplete");
			var selectedIDs = grid.getGridParam("selarrrow");
			
			if(selectedIDs != null && selectedIDs.length > 0) {
				messager.confirm("<spring:message code='column.common.confirm.publish' />", function(r){
					if(r){
						var stlNos = new Array();
						var compNos = new Array();
						var stIds = new Array();
						var stlOrders = new Array();
		
						for (var i in selectedIDs) {	
							var rowdata = grid.getRowData(selectedIDs[i]);
							stlNos.push(rowdata.stlNo);
							compNos.push(rowdata.compNo);
							stIds.push(rowdata.stId);
							stlOrders.push(rowdata.stlOrder);					
						}
		
						var options = {
								stlNos : stlNos
								, compNos : compNos
								, stIds : stIds	
								, stlOrders : stlOrders
							};
		
						createFormSubmit( "settlementCompleteTaxInvoiceExcelDownload", "/settlement/settlementCompleteTaxInvoiceExcelDownload.do", options );
					}
				});
			} else {
				messager.alert('<spring:message code="admin.web.view.msg.common.select.content" />', "Info", "info");
			}
		}

		function settlementCompleteDtlExcelDownload () {
			var options = {
					stlNo : $("#selectStlNo").val()
					, stlMonth : $("#selectStlMonth").val()
					, stlOrder : $("#selectStlOrder").val()
					, compNo : $("#selectCompNo").val()
					, stId : $("#selectStId").val()		
				};
			createFormSubmit( "settlementCompleteDtlExcelDownload", "/settlement/settlementCompleteDtlExcelDownload.do", options );
		}

		function selectDate () {
			var selYear = $("#selYear option:selected").val();
			var selMon = $("#selMon option:selected").val();

			var oMaxDay = new Date(new Date(selYear, selMon, 1) - 86400000).getDate();

			$("#sysRegDtmStart").val(toDateString (new Date(selYear, selMon - 1, 1), '-') );
			$("#sysRegDtmEnd").val(toDateString (new Date(selYear, selMon - 1, oMaxDay), '-') );

		}

		// callback : MD 사용자 검색
		function fnCallbackMDUserPop() {
			var data = {
				 multiselect : false
				, callBack : function(result) {
					$("#mdUsrNm").val( result[0].usrNm );
					$("#mdUsrNo").val( result[0].usrNo );
					$("#userDeleteBtn").show();
				}
				,param : {
					usrGbCd : '${adminConstants.USR_GB_1020}'
					,usrStatCd : '${adminConstants.USR_STAT_20}'
				}
			}
			layerUserList.create(data);

		}
		
		function fnUserDelete() {
			$("#mdUsrNm").val("");
			$("#mdUsrNo").val("");
			$("#userDeleteBtn").hide();
		}
		
		// 사이트 검색
		function searchSt () {
			var options = {
				multiselect : false
				, callBack : searchStCallback
			}
			layerStList.create (options );
		}

		function searchStCallback (stList ) {
			if(stList.length > 0 ) {
				$("#stId").val (stList[0].stId );
				$("#stNm").val (stList[0].stNm );
			}
		}
		
		function settlementCompletePvdStatUpdateLayerView() {
			var grid = $("#settlementComplete");
			var selectedIDs = grid.getGridParam("selarrrow");

			if(selectedIDs != null && selectedIDs.length > 0) {
				var options = {
					url : "<spring:url value='/settlement/settlementCompletePvdStatUpdateLayerView.do' />"
					, dataType : "html"
					, callBack : function (data) {
						var config = {
							id : "settlementCompletePvdStatUpdateLayer"
							, width : 500
							, height : 200
							, top : 200
							, title : "지급 여부 일괄 변경"
							, body : data
							, button : "<button type=\"button\" onclick=\"settlementCompletePvdStatUpdate();\" class=\"btn btn-ok\">확인</button>"
						}
						layer.create(config);
					}
				}
				ajax.call(options );
			} else {
				messager.alert('<spring:message code="admin.web.view.msg.common.select.content" />', "Info", "info");
			} 
		}

		function settlementCompletePvdStatUpdate(){
			var grid = $("#settlementComplete");
			var selectedIDs = grid.getGridParam("selarrrow");

			if(confirm("<spring:message code='column.common.confirm.batch_update' />") ) {
				var data = new Array();
				for (var i in selectedIDs) {
					var rowdata = grid.getRowData(selectedIDs[i]);
					data.push(rowdata.stlNo);
				}

				var options = {
					url : "<spring:url value='/settlement/settlementCompletePvdStatUpdate.do' />"
					, data : {
						arrStlNo : data.join(",")
						, pvdStatCd : $("#settlementCompletePvdStatUpdateForm").find("select[name=pvdStatCd]").val()
					}
					, callBack : function(result){
						searchSettle();
						layer.close ("settlementCompletePvdStatUpdateLayer");
					}
				};

				ajax.call(options);
			}
		}		
		</script>
	</t:putAttribute>

	<t:putAttribute name="content">
		<div class="easyui-accordion search-accordion" data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect, gridResizeYn:'N'" style="width:100%">
			<div title="<spring:message code='admin.web.view.common.search' />" style="padding:10px">
				<form id="settlementForm" name="settlementForm" method="post" >
					<input type="hidden" name="selectStlNo" id="selectStlNo" value="" />
					<input type="hidden" name="selectStlMonth" id="selectStlMonth" value="" />	
					<input type="hidden" name="selectStlOrder" id="selectStlOrder" value="" />	
					<input type="hidden" name="selectCompNo" id="selectCompNo" value="" />
					<input type="hidden" name="selectStId" id="selectStId" value="" />
					<table class="table_type1">
						<caption>정보 검색</caption>
						<tbody>
							<tr>
								<th scope="row"><spring:message code="column.settlement.month" /></th> <!-- 기간 -->
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
									</select>
								</td>
								<th scope="row"><spring:message code="column.settlement.st_id" /></th> <!-- 사이트 ID -->
								<td>
									<frame:stId funcNm="searchSt()" />
								</td>
							</tr>
		
							<tr>
								<th scope="row"><spring:message code="column.settlement.comp_nm" /></th> <!-- 업체번호 -->
								<td>
									<frame:compNo funcNm="searchCompany" disableSearchYn="${adminConstants.USR_GRP_10 eq adminSession.usrGrpCd ? 'N' : 'Y'}" placeholder="${adminConstants.USR_GRP_10 eq adminSession.usrGrpCd ? '입점업체를 검색하세요' : ''}"/>
									<c:if test="${adminConstants.USR_GB_2010 eq adminSession.usrGbCd}">
		                                      &nbsp;&nbsp;&nbsp;<frame:lowCompNo funcNm="searchLowCompany" placeholder="하위업체를 검색하세요"/>
		                                      &nbsp;&nbsp;&nbsp;<input type="checkbox" id="showAllLowComp" name="showAllLowComp"><span>하위업체 전체 선택</span>
		                                      <input type="hidden" id="showAllLowCompany" name="showAllLowCompany" value="N"/>
		                            </c:if>
								</td>
								<th scope="row"><spring:message code="column.comp_gb_cd" /></th>
								<td>
									<select name="compGbCd" id="compGbCd" title="<spring:message code="column.comp_gb_cd" />">
										<frame:select grpCd="${adminConstants.COMP_GB}" defaultName="전체"/>
									</select>
								</td>								
							</tr>
							
							<tr>
								<th scope="row"><spring:message code="column.settlement.stl_order" /></th> <!-- 정산 주기 -->
								<td>
		                       		<frame:radio name="stlOrder" grpCd="${adminConstants.STL_ORDER }" defaultName="전체" />
								</td>
								<th scope="row"><spring:message code="column.settlement.md_usr_no" /></th> <!-- MD선택 -->
								<td>
							 		<input type="text" class="readonly" name="mdUsrNm" id="mdUsrNm" value="${companyBase.mdUsrNm}" readonly="readonly" >
									<input type="hidden" class="readonly" name="mdUsrNo" id="mdUsrNo" value="${companyBase.mdUsrNo}" readonly="readonly" >
									<button type="button" class="btn" ${  adminConstants.USR_GRP_10 eq adminSession.usrGrpCd  ? 'onclick="fnCallbackMDUserPop();"' : 'style="display: none;"'}>MD 사용자 검색</button>
									<button type="button" class="btn" id="userDeleteBtn" style="display: none;"  ${ adminConstants.USR_GRP_10 eq adminSession.usrGrpCd ? 'onclick="fnUserDelete();"' : 'style="display: none;"'} >삭제</button>
								</td>
							</tr>
		
							<tr>	
								<th scope="row"><spring:message code="column.settlement.stl_pvd_stat" /></th> <!-- 지급 여부 -->
								<td>
		                       		<frame:radio name="pvdStatCd" grpCd="${adminConstants.PVD_STAT }" defaultName="전체" />
								</td>
								<th scope="row"></th>
								<td></td>
							</tr>													
						</tbody>
					</table>
				</form>
				<div class="btn_area_center">
					<button type="button" onclick="searchSettle();" class="btn btn-ok">검색</button>
					<button type="button" onclick="searchReset();" class="btn btn-cancel">초기화</button>
				</div>
			</div>
		</div>

		<div class="mTitle mt30">
			<h2>정산 완료 리스트</h2>
			<div class="buttonArea">
				<button type="button" onclick="settlementCompleteExcelDownload();" class="btn btn-add btn-excel">엑셀 다운로드</button>
				<c:if test="${adminConstants.USR_GB_1010 eq adminSession.usrGbCd}">
					<button type="button" onclick="settlementCompleteTaxInvoiceExcelDownload();" class="btn btn-add">세금계산서 엑셀출력</button>					
					<button type="button" onclick="settlementCompletePvdStatUpdateLayerView();" class="btn btn-add">지급 여부 일괄 변경</button>					
				</c:if>
			</div>
		</div>
		<div class="mModule no_m">
			<table id="settlementComplete"></table>
			<div id="settlementCompletePage"></div>
		</div>
		
		<div class="mTitle mt30">
			<h2>정산 완료 상세 리스트</h2>
			<div class="buttonArea">
				<button type="button" onclick="settlementCompleteDtlExcelDownload();" class="btn btn-add btn-excel">엑셀 다운로드</button>
			</div>
		</div>
		<div class="mModule no_m">
			<table id="settlementCompleteDtl"></table>
			<div id="settlementCompleteDtlPage"></div>
		</div>
		
	</t:putAttribute>

</t:insertDefinition>