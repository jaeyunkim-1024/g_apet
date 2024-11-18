<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
	<script type="text/javascript">
		$(document).ready(function() {
			// 업체 및 브랜드 리스트 생성
			createCompBrandListGrid();
		});
		// 업체 검색
		function searchCompany () {
			var options = {
				multiselect : false
				, callBack : searchCompanyCallback
	<c:if test="${adminConstants.USR_GB_2010 eq adminSession.usrGbCd}">
	                , showLowerCompany : 'Y'
	</c:if>
			}
			layerCompanyList.create (options );
		}
		function searchCompanyCallback (compList ) {
			if(compList.length > 0 ) {
				$("#compBrandStatsForm #compNo").val (compList[0].compNo );
				$("#compBrandStatsForm #compNm").val (compList[0].compNm );
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
                $("#compBrandStatsForm #lowCompNo").val (compList[0].compNo);
                $("#compBrandStatsForm #lowCompNm").val (compList[0].compNm);
            }
        }
		function selectBrandSeries (gubun ) {
			var options = null;
			if(gubun == "brand") {
				options = {
					multiselect : false
					, bndGbCd : '${adminConstants.BND_GB_20 }'
					<c:if test="${adminConstants.USR_GRP_10 ne adminSession.usrGrpCd}">
					, compNo : '${adminSession.compNo}'
					, compNm : '${adminSession.compNm}'
					</c:if>
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
		function searchBrandCallback (brandList ) {
			if(brandList != null && brandList.length > 0 ) {
				$("#bndNo").val (brandList[0].bndNo );
				$("#bndNm").val (brandList[0].bndNmKo );
			}
		}

		function createCompBrandListGrid() {
			var gridOptions = {
				url : "<spring:url value='/statistics/compBrandSalesListGrid.do'/>"
				, datatype : 'local'
				, height : 500
				, searchParam : $("#compBrandStatsForm").serializeJson()
				, colModels : [
					{name:"compNo", label:"<spring:message code='column.settlement.comp_no' />", width:"100", align:"center", sortable:false, hidden:true }
					//  업체명
					, {name:"compNm", label:"<spring:message code='column.settlement.comp_nm' />", width:"120", align:"center", sortable:false}
					//  브랜드번호
					, {name:"bndNo", label:"<spring:message code='column.bnd_no' />", width:"100", align:"center", sortable:false, hidden:true}
					//  브랜드명
					, {name:"bndNm", label:"<spring:message code='column.bnd' />", width:"150", align:"center", sortable:false , summaryType:"count", summaryTpl : '소계'}
					// 주문수량
					, {name:"ordQty", label:"<spring:message code='column.orderQty' />", width:"170", align:"center", sortable:false, summaryType:"sum", formatter:'integer'}
					// 주문금액
					, {name:"ordAmt", label:"<spring:message code='column.ordAmt' />", width:"170", align:"center", sortable:false, summaryType:"sum", formatter:'integer'}
					// 취소수량
					, {name:"cncQty", label:"<spring:message code='column.cncQty' />", width:"170", align:"center", sortable:false, summaryType:"sum", formatter:'integer'}
					// 취소금액
					, {name:"cncAmt", label:"<spring:message code='column.cncAmt' />", width:"170", align:"center", sortable:false, summaryType:"sum", formatter:'integer'}
					// 반품수량
					, {name:"rtnQty", label:"<spring:message code='column.rtnQty' />", width:"170", align:"center", sortable:false, summaryType:"sum", formatter:'integer'}
					// 반품금액
					, {name:"rtnAmt", label:"<spring:message code='column.rtnAmt' />", width:"170", align:"center",sortable:false, summaryType:"sum", formatter:'integer' }
					// 주문 금액 - 취소 금액 - 반품 금액
					, {name:"totAmt", label:"계", width:"170", align:"center",sortable:false, summaryType:"sum", formatter:'integer' }
				]
					, paging : false
 					, grouping: true
 					//, groupField : ["compNm","bndNm"]
 					, groupField : ["compNm"]
 					, groupColumnShow : [true]
 					, groupOrder : ["asc"]
					, groupCollapse : false
					, groupSummary : [true]
					, showSummaryOnHide: true
	    			, groupDataSorted : true
	    			, footerrow : true
 					, userDataOnFooter:true
					, gridComplete : function () {
						var ordQty 	= $("#compBrandSalesList" ).jqGrid('getCol', 'ordQty', false, 'sum');
						var ordAmt 	= $("#compBrandSalesList" ).jqGrid('getCol', 'ordAmt',	false, 'sum');
						var cncQty 	= $("#compBrandSalesList" ).jqGrid('getCol', 'cncQty', 	false, 'sum');
						var cncAmt	= $("#compBrandSalesList" ).jqGrid('getCol', 'cncAmt',	false, 'sum');
						var rtnQty 	= $("#compBrandSalesList" ).jqGrid('getCol', 'rtnQty', 	false, 'sum');
						var rtnAmt 	 = $("#compBrandSalesList" ).jqGrid('getCol','rtnAmt', false, 'sum');
						var totAmt 	 = $("#compBrandSalesList" ).jqGrid('getCol','totAmt', false, 'sum');

						$("#compBrandSalesList" ).jqGrid('footerData', 'set',
							{
								bndNm : '합계 : '
								, ordQty : ordQty
								, ordAmt  : ordAmt
								, cncQty 	: cncQty
								, cncAmt : cncAmt
								, rtnQty  : rtnQty
								, rtnAmt 	: rtnAmt
								, totAmt 	: totAmt
							}
						);
  					}

			}

			grid.create("compBrandSalesList", gridOptions);
		}

		// 검색
		function searchCompBrandSalesList() {
// 			$("#startDtm").val($("#startDtm").val().replace(/\-/g,'') );
// 			$("#endDtm").val($("#endDtm").val().replace(/\-/g,'') );
			var options = {
				searchParam : $("#compBrandStatsForm").serializeJson()
			};

			grid.reload("compBrandSalesList", options);
		}
	</script>
	</t:putAttribute>

	<t:putAttribute name="content">
		<div class="easyui-accordion search-accordion" data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect" style="width:100%">
			<div title="<spring:message code='admin.web.view.common.search' />" style="padding:10px">
				<form id="compBrandStatsForm" name="compBrandStatsForm" method="post" >
						<table class="table_type1">
							<caption>정보 검색</caption>
							<tbody>
								<tr>
									<!--일자 -->
									<th scope="row"><spring:message code="column.statistics.ebiz.date" /></th>
									<td>
										<frame:datepicker startDate="startDtm" endDate="endDtm" period="-7" />
									</td>
									<!-- 주문매체 -->
									<th scope="row"><spring:message code="column.ord_mda_cd" /></th>
									<td>
										<select name="ordMdaCd" id="ordMdaGb" title="선택상자" >
											<frame:select grpCd="${adminConstants.ORD_MDA}" defaultName="선택하세요"/>
										</select>
									</td>
								</tr>
								<tr>
									<!-- 사이트ID-->
									<th scope="row"><spring:message code="column.settlement.st_id" /></th>
									<td colspan="3">
										<select id="stIdCombo" name="stId">
											<frame:stIdStSelect defaultName="사이트선택" />
										</select>
									</td>
								</tr>
								<tr>
									<!-- 업체 -->
		                       		<th scope="row"><spring:message code="column.goods.comp_nm" /></th>
									<td>
										<frame:compNo funcNm="searchCompany"
										disableSearchYn="${adminConstants.USR_GRP_10 eq adminSession.usrGrpCd ? 'N' : 'Y'}"
										placeholder="${adminConstants.USR_GRP_10 eq adminSession.usrGrpCd ? '입점업체를 검색하세요' : ''}" />
									<c:if
										test="${adminConstants.USR_GB_2010 eq adminSession.usrGbCd}">
		                                        &nbsp;&nbsp;&nbsp;<frame:lowCompNo
											funcNm="searchLowCompany" placeholder="하위업체를 검색하세요" />
		                                        &nbsp;&nbsp;&nbsp;<input
											type="checkbox" id="showAllLowComp" name="showAllLowComp">
										<span>하위업체 전체 선택</span>
										<input type="hidden" id="showAllLowCompany"
											name="showAllLowCompany" value="N" />
									</c:if>
									</td>
									<!-- 브랜드 -->
		                       		<th scope="row"><spring:message code="column.goods.brnd" /></th>
		                       		<td><input type="hidden" id="bndNo" name="bndNo"  title="<spring:message code="column.goods.brnd" />" value="" />
									<input type="text" readonly class="readonly" id="bndNm" name="bndNm" title="<spring:message code="column.goods.brnd" />" value="" placeholder="브랜드를 검색하세요"/>
									<button type="button" class="btn" onclick="selectBrandSeries('brand'); return false;">검색</button>
									</td>
							</tbody>
						</table>
				</form>
			
				<div class="btn_area_center">
					<button type="button" onclick="searchCompBrandSalesList();" class="btn btn-ok">검색</button>
					<button type="button" onclick="resetForm('compBrandStatsForm');" class="btn btn-cancel">초기화</button>
				</div>
			</div>
		</div>
		
		<div class="mModule">
			<table id="compBrandSalesList" class="grid"></table>
		</div>
	</t:putAttribute>
</t:insertDefinition>