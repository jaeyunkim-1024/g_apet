<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	
	<t:putAttribute name="script">

		<jsp:include page="/WEB-INF/view/tax/include/incCashList.jsp" />

		<script type="text/javascript">
			$(document).ready(function(){
				newSetCommonDatePickerEvent('#ordAcptDtmStart','#ordAcptDtmEnd');
				searchDateChange();
				createOrderListGrid();
				$("input[name=compNm]").prop("disabled", true);
				$("select[name=pageGbCd]").prop("disabled", true);
			});

			// 주문 상품 그리드
			function createOrderListGrid(){

				var options = $.extend( {} , orderGridListCommon, {
					url : "<spring:url value='/tax/cashListGrid.do' />"
					, height : 400
					 
					, searchParam : $("#orderSearchForm").serializeJson()
					 
					, onCellSelect : function (id, cellidx, cellvalue) {
						var cm = $("#orderList").jqGrid("getGridParam", "colModel");
						var rowData = $("#orderList").getRowData(id);
						fnCashReceiptDetailPop(rowData.cashRctNo);	
					}
					, grouping: true
					, groupField: ["ordNo"]
					, groupText: ["주문번호"]
					, groupOrder : ["asc"]
					, groupCollapse: false
					, groupColumnShow : [false]
				});

				grid.create( "orderList", options) ;

			}

			// 그리드 체크 박스 클릭 : 주문번호 단위 토글
			$(document).on("click", "#orderList input[name=arrCashRctNo]", function(e){
				var checked = $(this).is(":checked");
				$("#orderList input[name=arrCashRctNo]").prop("checked", false);
				$(this).prop("checked", checked);
			});

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
			// 조회
			function reloadOrderListGrid() {
				compareDateAlert('ordAcptDtmStart','ordAcptDtmEnd','term');

				// 판매 공간 체크
				if ( $("input:radio[name=pageCheck]:checked").val() == '01' ) {
					if ( $("select[name=pageGbCd]").val() == '' ) {
						messager.alert("외부몰을 선택하세요.","info","info");
					}
				}

				var data = $("#orderSearchForm").serializeJson();
				if ( undefined != data.arrCrTpCd && data.arrCrTpCd != null && Array.isArray(data.arrCrTpCd) ) {
					$.extend( data, { arrCrTpCd : data.arrCrTpCd.join(",") } );
				}
				if ( undefined != data.arrCashRctStatCd && data.arrCashRctStatCd != null && Array.isArray(data.arrCashRctStatCd) ) {
					$.extend( data, { arrCashRctStatCd : data.arrCashRctStatCd.join(",") } );
				}
				if ( undefined != data.arrOrdDtlStatCd && data.arrOrdDtlStatCd != null && Array.isArray(data.arrOrdDtlStatCd) ) {
					$.extend( data, { arrOrdDtlStatCd : data.arrOrdDtlStatCd.join(",") } );
				}

				var options = {
					searchParam : data
				}
				gridReload('ordAcptDtmStart','ordAcptDtmEnd','orderList','term', options);		
			}

			// callback : 업체 검색
			function fnCallBackCompanySearchPop() {
				var data = {
					multiselect : true
					, callBack : function(result) {
						$("#compNo").val( result[0].compNo );
						$("#compNm").val( result[0].compNm );
					}
				}
				layerCompanyList.create(data);
			}

			// 검색 : 주문 상세 상태코드 클릭
			$(document).on("click", 'input:checkbox[name="arrOrdDtlStatCd"]', function(e) {

				var all = false;

				if ( validation.isNull( $(this).val() ) ){
					all = true;
				}
				if ( $('input:checkbox[name="arrOrdDtlStatCd"]:checked').length == 0 ) {
					$('input:checkbox[name="arrOrdDtlStatCd"]').eq(0).prop( "checked", true );
				} else {
					$('input:checkbox[name="arrOrdDtlStatCd"]').each( function() {
						if ( all ) {
							if ( validation.isNull( $(this).val() ) ) {
								$(this).prop("checked", true);
							} else {
								$(this).prop("checked", false);
							}
						} else {
							if ( validation.isNull($(this).val() ) ) {
								$(this).prop("checked", false);
							}
						}
					});
				}

			});
			
			// 검색 : 현금 영수증 발급 유형 코드 클릭
			$(document).on("click", 'input:checkbox[name="arrCrTpCd"]', function(e) {

				var all = false;

				if ( validation.isNull( $(this).val() ) ){
					all = true;
				}
				if ( $('input:checkbox[name="arrCrTpCd"]:checked').length == 0 ) {
					$('input:checkbox[name="arrCrTpCd"]').eq(0).prop( "checked", true );
				} else {
					$('input:checkbox[name="arrCrTpCd"]').each( function() {
						if ( all ) {
							if ( validation.isNull( $(this).val() ) ) {
								$(this).prop("checked", true);
							} else {
								$(this).prop("checked", false);
							}
						} else {
							if ( validation.isNull($(this).val() ) ) {
								$(this).prop("checked", false);
							}
						}
					});
				}

			});

			// 검색 : 현금 영수증 상태코드 클릭
			$(document).on("click", 'input:checkbox[name="arrCashRctStatCd"]', function(e) {

				var all = false;

				if ( validation.isNull( $(this).val() ) ){
					all = true;
				}
				if ( $('input:checkbox[name="arrCashRctStatCd"]:checked').length == 0 ) {
					$('input:checkbox[name="arrCashRctStatCd"]').eq(0).prop( "checked", true );
				} else {
					$('input:checkbox[name="arrCashRctStatCd"]').each( function() {
						if ( all ) {
							if ( validation.isNull( $(this).val() ) ) {
								$(this).prop("checked", true);
							} else {
								$(this).prop("checked", false);
							}
						} else {
							if ( validation.isNull($(this).val() ) ) {
								$(this).prop("checked", false);
							}
						}
					});
				}

			});

			// 현금 영수증 상세 보기 팝업
			function fnCashReceiptDetailPop(cashRctNo) {
				/*var width = 750;
				var height = 650;
				var config = {
					  url : '/tax/cashReceiptDetailPopView.do'
					, width : width
					, height : height
					, target : 'cashReceiptDetailPopView'
					, scrollbars : 'no'
					, resizable : 'no'
					, location : 'no'
					, menubar : 'no'
					, data : {
						cashRctNo : cashRctNo
					}
				};
				openWindowPop(config);*/
				
				var btn = '';
				if (('${cashReceipt.crTpCd}' == '${adminConstants.CR_TP_10}') && ('${cashReceipt.cashRctStatCd}' != '${adminConstants.CASH_RCT_STAT_30}'))
					btn = "<button type=\"button\" onclick=\"fnCashReceiptRePublishExec();\" class=\"btn btn-ok\">현금영수증 재발행</button>";
				
				var options = {
					url : '/tax/cashReceiptDetailPopView.do'
					, data : {cashRctNo : cashRctNo}
					, dataType : "html"
					, callBack : function (data ) {
						var config = {
							id : "cashReceiptDetailView"
							, width : 1000
							, height : 500
							, top : 200
							, title : "현금 영수증"
							, body : data
							, button : btn
						}
						layer.create(config);
					}
				}
				ajax.call(options );
			}
 

			  

			// 판매공간 라디오 버튼 클릭
			$(document).on("click", "#orderSearchForm input[name=pageCheck]", function(e){
				if( $(this).val() == "" ) {
					$("select[name=pageGbCd]").prop("disabled", true);
				} else if ( $(this).val() == "01" ) {
					$("select[name=pageGbCd]").prop("disabled", false);
				}
			});

			// 엑셀 다운로드
			function cashListExcelDownload() {
				createFormSubmit( "cashListExcelDownload", "/tax/cashListExcelDownload.do", $("#orderSearchForm").serializeJson() );
			}
			// 등록일 변경
			function searchDateChange() {
				var term = $("#checkOptDate").children("option:selected").val();
				if(term == "") {
					$("#ordAcptDtmStart").val("");
					$("#ordAcptDtmEnd").val("");
				} else if(term == "50") {
					setSearchDateThreeMonth("ordAcptDtmStart","ordAcptDtmEnd");
				} else {
					setSearchDate(term, "ordAcptDtmStart", "ordAcptDtmEnd");
				}
			}
			
			// callback : 업체 검색
			function fnCompanySearchPop() {
				var data = {
					multiselect : true
					, callBack : function(result) {
						$("#compNo").val( result[0].compNo );
						$("#compNm").val( result[0].compNm );
					}
<c:if test="${adminConstants.USR_GB_2010 eq adminSession.usrGbCd}">
                    , showLowerCompany : 'Y'
</c:if> 
				}
				layerCompanyList.create(data);
			}
			
	          // 하위 업체 검색
            function fnCompayLowSearchPop () {
                var options = {
                    multiselect : false
                    , callBack : fnCompayLowSearchPopCallback
<c:if test="${adminConstants.USR_GB_2010 eq adminSession.usrGbCd}">
                    , showLowerCompany : 'Y'
</c:if>
                }
                layerCompanyList.create (options );
            }
            // 업체 검색 콜백
            function fnCompayLowSearchPopCallback(compList) {
                if(compList.length > 0) {
                    $("#orderSearchForm #lowCompNo").val (compList[0].compNo);
                    $("#orderSearchForm #lowCompNm").val (compList[0].compNm);
                }
            }
            
            //초기화
            function searchReset () {
            	resetForm('orderSearchForm')
                searchDateChange();                
            }
            
         	// input 엔터 이벤트
            $(document).on("keydown","input[name=searchValueOrder], input[name=searchValueGoods]",function(e){
                if ( e.keyCode == 13 ) {
                	reloadOrderListGrid('');
                }
            });
            
		</script>

	</t:putAttribute>

	<t:putAttribute name="content">

		<!-- ==================================================================== -->
		<!-- 검색 -->
		<!-- ==================================================================== -->
		<%-- <jsp:include page="/WEB-INF/view/order/include/incSearchInfo.jsp" /> --%>
		<div class="easyui-accordion search-accordion" data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect" style="width:100%">
			<div title="<spring:message code='admin.web.view.common.search' />" style="padding:10px">
				<form name="orderSearchForm" id="orderSearchForm">
					 <input type="hidden" name="mbrNo" value="${orderSO.mbrNo }">
			 
					<table class="table_type1">
						<caption>주문 검색</caption>
						<tbody>
							<tr>
								<!-- 주문 접수 일자 -->
								<th scope="row"><spring:message code="column.ord_acpt_dtm" /></th>
								<td>
									<frame:datepicker startDate="ordAcptDtmStart" endDate="ordAcptDtmEnd"  startValue="${frame:toDate('yyyy-MM-dd') }" endValue="${frame:toDate('yyyy-MM-dd') }" />
									&nbsp;&nbsp;
									<select id="checkOptDate" name="checkOptDate" onchange="searchDateChange();" style="width:120px !important;">
										<frame:select grpCd="${adminConstants.SELECT_PERIOD }" selectKey="${adminConstants.SELECT_PERIOD_40 }" defaultName="기간선택" />
									</select>
								</td>
								<!-- 주문정보 -->
		                        <th scope="row"><spring:message code="column.order_common.order_info" /></th>
		                        <td>
		                            <select name="searchKeyOrder" id="searchKeyOrder" class="w100" title="선택상자" >
		                                <option value="type01">주문번호</option>
		                                <option value="type02">주문자명</option>
		                                <option value="type03">주문자ID</option>
		                                <option value="type04">수령인명</option>
		                            </select>
		                            <input type="text" name="searchValueOrder" id="searchValueOrder" class="w120"  value="" />
		                        </td>
							</tr>
							<tr>
		                        <!-- 주문매체 -->
		                        <th scope="row"><spring:message code="column.ord_mda_cd" /></th>
		                        <td>
		                            <frame:radio name="ordMdaCd" grpCd="${adminConstants.ORD_MDA }" defaultName="전체" />
		                        </td>
		                        <!-- 사이트 ID -->
			                    <th scope="row"><spring:message code="column.st_id" /></th> <!-- 사이트 ID -->
			                    <td>
			                        <%-- <select name="stId" class="input_select" title="<spring:message code="column.st_id" />">
		                       			<option value="">전체</option>
			                       		<c:forEach items="${siteList}" var="stStdInfo">
			                       			<option value="${stStdInfo.stId}">${stStdInfo.stNm}</option>
			                       		</c:forEach> 
			                        </select> --%>
			                        <select id="stIdCombo" name="stId">
				                    	<frame:stIdStSelect defaultName="사이트선택" />
				                    </select>
			                    </td>
							</tr>
							<tr>
								<!-- 상품정보 -->
		                        <th scope="row"><spring:message code="column.order_common.goods_info" /></th>
		                        <td>
		                            <select name="searchKeyGoods" class="w100" title="선택상자" >
		                                <option value="type00">전체</option>
		                                <option value="type01">상품명</option>
		                                <option value="type02">상품NO</option>
		                            </select>
		                            <input type="text" name="searchValueGoods" class="w120" value="" />
		                        </td>
		                         <!-- 업체구분 -->
		                        <th scope="row"><spring:message code="column.goods.comp_nm" /></th>
		                        <td>
		                            <frame:compNo funcNm="fnCompanySearchPop" disableSearchYn="${adminConstants.USR_GRP_10 eq adminSession.usrGrpCd ? 'N' : 'Y'}" placeholder="${adminConstants.USR_GRP_10 eq adminSession.usrGrpCd ? '입점업체를 검색하세요' : ''}"/>
		                            <c:if test="${adminConstants.USR_GB_2010 eq adminSession.usrGbCd}">
		                            &nbsp;&nbsp;&nbsp;<frame:lowCompNo funcNm="fnCompayLowSearchPop" placeholder="하위업체를 검색하세요"/>
		                            &nbsp;&nbsp;&nbsp;<input type="checkbox" id="showAllLowComp" name="showAllLowComp"><span>하위업체 전체 선택</span>
		                            <input type="hidden" id="showAllLowCompany" name="showAllLowCompany" value="N"/>
		                            </c:if>
		                        </td>
							</tr>
						</tbody>
					</table>
				</form>
				
				<div class="btn_area_center">
					<button type="button" onclick="reloadOrderListGrid('');" class="btn btn-ok">검색</button>
					<button type="button" onclick="searchReset();" class="btn btn-cancel">초기화</button>
				</div>
			</div>
		</div>
		<!-- ==================================================================== -->
		<!-- 검색 -->
		<!-- ==================================================================== -->

		<!-- ==================================================================== -->
		<!-- 그리드 -->
		<!-- ==================================================================== -->
		<div class="mModule">
			<table id="orderList" ></table>
			<div id="orderListPage"></div>
		</div>
		<!-- ==================================================================== -->
		<!-- //그리드 -->
		<!-- ==================================================================== -->

	</t:putAttribute>

</t:insertDefinition>
