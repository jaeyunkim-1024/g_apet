<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>

<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">
		$(document).ready(function() {
			selectDate ();

			createSettleGrid ();
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
            //$("#settlementForm #showAllLowCompany").val("N");
            </c:if>
		}

		function searchSettle () {
			var options = {
				searchParam : $("#settlementForm").serializeJson()
			};
			$("#settlementInfo").jqGrid('clearGridData');
			$("#selectCompNo").val('' );
			grid.reload("settlementInfo", options);
		}

		// createSettleGrid
		function createSettleGrid () {
			var gridOptions = {
				url : "<spring:url value='/settlement/settlementInfoGrid.do' />"
				, height : 300
				, searchParam : $("#settlementForm").serializeJson()
				, colModels : [
					{name:"stId", label:"<spring:message code='column.settlement.st_id' />", width:"100", align:"center", sortable:false, hidden:true }           
					, {name:"stNm", label:"<spring:message code='column.settlement.st_nm' />", width:"100", align:"center", sortable:false }
					, {name:"compNo", label:"<spring:message code='column.settlement.comp_no' />", width:"100", align:"center", sortable:false, hidden:true }
					, {name:"compNm", label:"<spring:message code='column.settlement.comp_nm' />", width:"100", align:"center", sortable:false }
					, {name:"acptDtm", label:"<spring:message code='column.settlement.acpt_dtm' />", width:"120", align:"center", sortable:false, formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss" }
					, {name:"ordNo", label:'<spring:message code="column.settlement.ord_no" />', width:"110", align:"center", sortable:false, key: true }
					, {name:"ordDtlSeq", label:'<spring:message code="column.settlement.ord_dtl_seq" />', width:"100", align:"center", sortable:false, formatter:'integer', hidden:true }
					, {name:"clmNo", label:'<spring:message code="column.settlement.clm_no" />', width:"110", align:"center", sortable:false, key: true }
					, {name:"clmDtlSeq", label:'<spring:message code="column.settlement.clm_dtl_seq" />', width:"100", align:"center", sortable:false, formatter:'integer', hidden:true }
					, {name:"stlOrdTpNm", label:'<spring:message code="column.settlement.stl_ord_tp_nm" />', width:"100", align:"center", sortable:false }
					, {name:"ordNm", label:'<spring:message code="column.settlement.ord_nm" />', width:"100", align:"center", sortable:false }
					, {name:"ordrId", label:'<spring:message code="column.settlement.ordr_id" />', width:"100", align:"center", sortable:false }
					, {name:"goodsId", label:'<spring:message code="column.settlement.goods_id" />', width:"100", align:"center", sortable:false }
					, {name:"goodsNm", label:'<spring:message code="column.settlement.goods_nm" />', width:"100", align:"center", sortable:false }
					, {name:"itemNo", label:'<spring:message code="column.settlement.item_no" />', width:"100", align:"center", sortable:false, hidden:true }
					, {name:"itemNm", label:'<spring:message code="column.settlement.item_nm" />', width:"100", align:"center", sortable:false }
					, {name:"saleAmt", label:"<spring:message code='column.settlement.sale_amt' />", width:"100", align:"center", sortable:false, formatter: 'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','} } /* 판매가 */
					, {name:"stlTgQty", label:'<spring:message code="column.settlement.stl_tg_qty" />', width:"100", align:"center", formatter:'integer', sortable:false }
					, {name:"saleTotAmt", label:'<spring:message code="column.settlement.sale_tot_amt" />', width:"100", align:"center", sortable:false, formatter: 'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','} } /* 판매가 */
			
				]
				, multiselect : false
				, paging : true
				, footerrow : true
				, userDataOnFooter : true
				, gridComplete : function () {
					// footer 처리 로직
					var saleAmt = $("#settlementInfo" ).jqGrid('getCol', 'saleAmt', false, 'sum');
					var stlTgQty = $("#settlementInfo" ).jqGrid('getCol', 'stlTgQty', false, 'sum');
					var saleTotAmt = $("#settlementInfo" ).jqGrid('getCol', 'saleTotAmt', false, 'sum');

					$("#settlementInfo" ).jqGrid('footerData', 'set',
						{itemNm : '합계 : '
							, saleAmt	: saleAmt
							, stlTgQty	: stlTgQty
							, saleTotAmt	: saleTotAmt
						}
					);
				}
			}
			grid.create("settlementInfo", gridOptions);
		}

		function settlementInfoExcelDownload () {
			createFormSubmit( "settlementInfoExcelDownload", "/settlement/settlementInfoExcelDownload.do", $("#settlementForm").serializeJson() );
		}

		function settlementInfoExcelDownload () {
			var options = {
					stlNo : $("#selectStlNo").val()
					, compNo : $("#selectCompNo").val()
					, stId : $("#selectStId").val()	
				};
			createFormSubmit( "settlementInfoExcelDownload", "/settlement/settlementInfoExcelDownload.do", options );
		}

		function selectDate () {
			var selYear = $("#selYear option:selected").val();
			var selMon = $("#selMon option:selected").val();

			var oMaxDay = new Date(new Date(selYear, selMon, 1) - 86400000).getDate();

			$("#sysRegDtmStart").val(toDateString (new Date(selYear, selMon - 1, 1), '-') );
			$("#sysRegDtmEnd").val(toDateString (new Date(selYear, selMon - 1, oMaxDay), '-') );

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

		</script>
	</t:putAttribute>

	<t:putAttribute name="content">
		<div class="easyui-accordion search-accordion" data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect" style="width:100%">
			<div title="<spring:message code='admin.web.view.common.search' />" style="padding:10px">
				<form id="settlementForm" name="settlementForm" method="post" >
					<input type="hidden" name="selectStlNo" id="selectStlNo" value="" />
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
									<th scope="row"><spring:message code="column.settlement.stl_order" /></th> <!-- 정산 주기 -->
									<td>
		                           		<frame:radio name="stlOrder" grpCd="${adminConstants.STL_ORDER }" defaultName="전체" />
									</td>
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
				<h2>매출 정보 리스트</h2>
				<div class="buttonArea">
					<button type="button" onclick="settlementInfoExcelDownload();" class="btn btn-add btn-excel">엑셀 다운로드</button>
				</div>
			</div>
			<div class="mModule no_m">
				<table id="settlementInfo"></table>
				<div id="settlementInfoPage"></div>
			</div>
			
	</t:putAttribute>

</t:insertDefinition>