<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	
	<t:putAttribute name="script">

		<%-- <jsp:include page="/WEB-INF/view/claim/include/incClaimCancelList.jsp" /> --%>

		<script type="text/javascript">

			$(document).ready(function(){
				newSetCommonDatePickerEvent('#clmAcptDtmStart','#clmAcptDtmEnd');
				
				searchDateChange();
				createOrderListGrid();
				$("input[name=compNm]").prop("disabled", true);
				$("select[name=pageGbCd]").prop("disabled", true);

				// 클레임상세상태 1 선택
				$("#clmDtlTpCd").bind ("change", function () {
					var selectVal = $(this).children("option:selected").val();
					if ( selectVal == "" ) {
						$("#clmDtlStatCd").html ('');
						return;
					}
					// 분류
					config = {
						grpCd : '${adminConstants.CLM_DTL_STAT }'
						, usrDfn1Val : selectVal
						, defaultName : '전체'
						, showValue : false
						, callBack : function(html) {
							$("#clmDtlStatCd").html ('');
							$("#clmDtlStatCd").append (html);
						}
					};
					codeAjax.select(config);
				});
				
				// input 엔터 이벤트
				$(document).on("keydown","#claimSearchForm input[name='searchValueOrder'], #claimSearchForm input[name='searchValueGoods'], #claimSearchForm input[name='clmNo']",function(e){
					if ( e.keyCode == 13 ) {
						reloadOrderListGrid('');
					}
				});

			});

			// 주문 상품 그리드
			function createOrderListGrid(){

				var options = $.extend( {} ,  {
					url : "<spring:url value='/claim/claimCancelListGrid.do' />"
					, height : 400
					,colModels : [
					 			// 클레임 번호
					 			  {name:"clmNo", label:'<spring:message code="column.clm_no" />', width:"120", align:"center"}
					 			/* 사이트명 */
					 			, {name:"stNm", label:'<spring:message code='column.st_nm' />', width:"80", align:"center" }
					 			/* 사이트 ID */
					 			, {name:"stId", label:'<spring:message code='column.st_id' />', width:"100", align:"center", hidden: true}
					 			// 주문 번호
					 			, {name:"ordNo", label:'<b><u><tt><spring:message code="column.ord_no" /></tt></u></b>', width:"115", align:"center", classes:'pointer underline'}
					 			// 클레임 유형 코드
					 			, {name:"clmTpCd", label:'<spring:message code="column.clm_tp_cd" />', width:"70", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.CLM_TP}" />"}}
					 			// 클레임 상태 코드
					 			, {name:"clmStatCd", label:'<spring:message code="column.clm_stat_cd" />', width:"70", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.CLM_STAT}" />"}}
					 			// 클레임 접수 일시
					 			, {name:"acptDtm", label:'<spring:message code="column.clm_acpt_dtm" />', width:"120", align:"center", formatter:gridFormat.date, datefomat:"yyyy-MM-dd HH:mm:ss"}
					 			// 클레임 완료 일시
					 			, {name:"cpltDtm", label:'<spring:message code="column.clm_cplt_dtm" />', width:"120", align:"center", formatter:gridFormat.date, datefomat:"yyyy-MM-dd HH:mm:ss"}
					 			// 클레임 취소 일시
					 			, {name:"cncDtm", label:'<spring:message code="column.clm_cnc_dtm" />', width:"120", align:"center", formatter:gridFormat.date, datefomat:"yyyy-MM-dd HH:mm:ss"}
					 			// 클레임 상세 순번
					 			, {name:"clmDtlSeq", label:'<b><u><tt><spring:message code="column.clm_dtl_seq" /></tt></u></b>', width:"80", align:"center", formatter:'integer', classes:'pointer fontbold'}
					 			// 클레임 유형 코드
					 			, {name:"clmDtlTpCd", label:'<spring:message code="column.clm_dtl_tp_cd" />', width:"70", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.CLM_DTL_TP}" />"}}
					 			// 클레임 상세 상태 코드
					 			, {name:"clmDtlStatCd", label:'<spring:message code="column.clm_dtl_stat_cd" />', width:"70", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.CLM_DTL_STAT}" />"}}
					 			// 클레임 사유 코드
					 			, {name:"clmRsnCd", label:'<spring:message code="column.clm_rsn_cd" />', width:"150", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.CLM_RSN}" />"}}
					 			// 상품아이디
					 			, {name:"goodsId", label:'<spring:message code='column.goods_id' />', width:"100", align:"center", hidden: true}
					 			// 상품명
					 			, {name:"goodsNm", label:'<spring:message code='column.goods_nm' />', width:"200", align:"center" }
					 			/* 기능없어 삭제(v0.6).
					 			// 단품번호
					 			, {name:"itemNo", label:'<spring:message code='column.item_no' />', width:"100", align:"center", hidden: true}
					 			// 단품명
					 			, {name:"itemNm", label:'<spring:message code='column.item_nm' />', width:"100", align:"center" }
					 			*/
					 			// 클레임 수량
					 			, {name:"clmQty", label:'<spring:message code="column.clm_qty" />', width:"80", align:"center", formatter:'integer'}
					 		]
					, searchParam : $("#claimSearchForm").serializeJson()
					,multiselect : true

					, gridComplete: function() {  /** 데이터 로딩시 함수 **/

						var ids = $('#clmCancelList').jqGrid('getDataIDs');

						// 그리드 데이터 가져오기
						var gridData = $("#clmCancelList").jqGrid('getRowData');

						if(gridData.length > 0){
							// 데이터 확인후 색상 변경
							for (var i = 0; i < gridData.length; i++) {

								// 데이터의 is_test 확인
								if (gridData[i].clmStatCd == '40') {

									// 열의 색상을 변경하고 싶을 때(css는 미리 선언)
									$('#clmCancelList tr[id=' + ids[i] + ']').css('color', 'red');
							   }
							}
						}

					}
					,onCellSelect: function(rowid, index, contents, e){ // cell을 클릭 시

						var cm = $("#clmCancelList").jqGrid("getGridParam", "colModel");
						var rowData = $("#clmCancelList").getRowData(rowid);
						if(cm[index].name != "cb" && cm[index].name != "ordNo"){
							fnClaimDetailView(rowData.clmNo);
						}

						if(cm[index].name == "ordNo"){
							fnOrderDetailView(rowData.ordNo);
						}
					}
					, grouping: true
					, groupField: ["clmNo"]
					, groupText: ["클레임번호"]
					, groupOrder : ["desc"]
					, groupCollapse: false
					, groupColumnShow : [false]

				});

				grid.create( "clmCancelList", options) ;

			}

			// 클레임상세
			function fnClaimDetailView(clmNo) {
				addTab('클레임 상세', '/cancel/claimDetailView.do?clmNo=' + clmNo);
			}


			// 그리드 체크 박스 클릭 : 클레임 단위 토글
			$(document).on("click", "#clmCancelList input[name=arrClmNo]", function(e){
// 				alert( $(this).val() );
				var checked = $(this).is(":checked");
				$("#clmCancelList input[name=arrClmNo]").prop("checked", false);
				$(this).prop("checked", checked);
			});

			// 주문상세
			function fnOrderDetailView(ordNo) {
				addTab('주문 상세', '/cancel/orderDetailView.do?ordNo=' + ordNo + "&viewGb=" + '${adminConstants.VIEW_GB_POP}');
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

			// 조회
			function reloadOrderListGrid() {
				compareDateAlert('clmAcptDtmStart','clmAcptDtmEnd','term');
				
				// 판매 공간 체크
				if ( $("input:radio[name=pageCheck]:checked").val() == '01' ) {
					if ( $("select[name=pageGbCd]").val() == '' ) {
						messager.alert("외부몰을 선택하세요.","info","info");
					}
				}

				var data = $("#claimSearchForm").serializeJson();

				var options = {
					searchParam : data
				}
				gridReload('clmAcptDtmStart','clmAcptDtmEnd','clmCancelList','term', options);		
			}

			// callback : 업체 검색
			function fnCallBackCompanySearchPop() {
				var data = {
					multiselect : false
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
                    $("#claimSearchForm #lowCompNo").val (compList[0].compNo);
                    $("#claimSearchForm #lowCompNm").val (compList[0].compNm);
                }
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

			// 판매공간 라디오 버튼 클릭
			$(document).on("click", "#claimSearchForm input[name=pageCheck]", function(e){
				if( $(this).val() == "" ) {
					$("select[name=pageGbCd]").prop("disabled", true);
				} else if ( $(this).val() == "01" ) {
					$("select[name=pageGbCd]").prop("disabled", false);
				}
			});

            // 초기화 버튼클릭
            function searchReset() {
                resetForm ("claimSearchForm");
				searchDateChange();
                <c:if test="${adminConstants.USR_GRP_10 ne adminSession.usrGrpCd}">
                	$("#claimSearchForm #compNo").val('${adminSession.compNo}');
                </c:if>
            }

			// 엑셀 다운로드
			function claimCancelListExcelDownload() {
            	var data = $("#claimSearchForm").serializeJson();
				var rowIds = $("#clmCancelList").getGridParam("selarrrow");
				if(rowIds.length > 0){
					var clmNos = [];
					for(var i in rowIds){
						var rowData =  $("#clmCancelList").getRowData(rowIds[i]);
						var clmNo = rowData.clmNo;
						var clmDtlSeq = rowData.clmDtlSeq;
						clmNos.push(clmNo+clmDtlSeq);
					}
					data.clmNos = clmNos.join();
				}
				createFormSubmit( "claimCancelListExcelDownload", "/claim/claimCancelListExcelDownload.do", data );
			}
			
			function searchDateChange() {
				var term = $("#checkOptDate").children("option:selected").val();
				if(term == "") {
					$("#clmAcptDtmStart").val("");
					$("#clmAcptDtmEnd").val("");
				} else if(term == "50") {
					setSearchDateThreeMonth("clmAcptDtmStart","clmAcptDtmEnd");
				} else {
					setSearchDate(term, "clmAcptDtmStart", "clmAcptDtmEnd");
				}
			}

		</script>

	</t:putAttribute>

	<t:putAttribute name="content">

		<!-- ==================================================================== -->
		<!-- 검색 -->
		<!-- ==================================================================== -->
		<div class="easyui-accordion search-accordion" data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect" style="width:100%">
			<div title="<spring:message code='admin.web.view.common.search' />" style="padding:10px">
				<form name="claimSearchForm" id="claimSearchForm">
		
					<input type="hidden" name="mbrNo" value="${orderSO.mbrNo }">
		
					<table class="table_type1">
						<caption>정보 검색</caption>
						<tbody>
		
							<tr>
								<!-- 클레임접수일자 -->
								<th scope="row"><spring:message code="column.clm_acpt_dtm" /></th>
								<td>
									<frame:datepicker startDate="clmAcptDtmStart" endDate="clmAcptDtmEnd" startValue="${frame:toDate('yyyy-MM-dd') }"  endValue="${frame:toDate('yyyy-MM-dd') }"/>
									&nbsp;&nbsp;
									<select id="checkOptDate" name="checkOptDate" onchange="searchDateChange();" style="width:120px !important;">
										<frame:select grpCd="${adminConstants.SELECT_PERIOD }" selectKey="${adminConstants.SELECT_PERIOD_40 }" defaultName="기간선택" />
									</select>
								</td>
		
		                         
		                        <!-- 사이트 ID -->
			                    <th scope="row"><spring:message code="column.st_id" /></th> <!-- 사이트 ID -->
			                    <td>
		                            <select id="stIdCombo" class="wth100" name="stId">
		                                <frame:stIdStSelect defaultName="사이트선택" />
		                            </select>
			                    </td>
							</tr>
							<tr>
		                        <!-- 주문매체 -->
		                        <%-- <th scope="row"><spring:message code="column.clm_dtl_stat_cd" /></th>
		                        <td>
		                        	<select name="clmDtlTpCd" id="clmDtlTpCd" class="wth100" title="선택상자" >
										<frame:select grpCd="${adminConstants.CLM_DTL_TP }" selectKey="${adminConstants.CLM_DTL_TP_10}" readOnly="true"  />
									</select>
		
									<select name="clmDtlStatCd" id="clmDtlStatCd" class="wth100" title="선택상자" >
										<frame:select grpCd="${adminConstants.CLM_DTL_STAT }" selectKey="${adminConstants.CLM_DTL_STAT_120 }" usrDfn1Val="${adminConstants.CLM_TP_10}" />
									</select>
		                        </td> --%>
								<!-- 주문정보 -->
								<th scope="row"><spring:message code="column.order_common.order_info" /></th>
		                        <td>
		                        	<select name="searchKeyOrder" id="searchKeyOrder" class="w100" title="선택상자" >
		                                <option value="type01">주문번호</option>
		                                <option value="type02">주문자명</option>
		                                <option value="type03">주문자ID</option>
		                            </select>
		                            <input type="text" name="searchValueOrder" class="w120"  value="" />
		                        </td>
		                        <!-- 상품정보 -->
		                        <th scope="row"><spring:message code="column.order_common.goods_info" /></th>
		                        <td>
		                            <select name="searchKeyGoods" class="wth100" title="선택상자" >
		                                <option value="type00" selected="selected">전체</option>
		                                <option value="type01">상품명</option>
		                                <option value="type02">상품NO</option>
		                                <!-- 단품 기능 없어 삭제(v0.6) 
		                                <option value="type03">단품명</option>
		                                <option value="type04">단품NO</option>
		                                 -->
		                            </select>
		                            <input type="text" name="searchValueGoods" class="w120" value="" />
		                        </td>
		                    </tr>
							<tr>
								<!-- 클레임 번호 -->
		                        <th scope="row"><spring:message code="column.clm_no" /></th>
		                        <td>
		                            <input type="text" name="clmNo" id="clmNo" class="w150" value="" />
		                        </td>
		                        <!-- 업체구분 -->
		                        <th scope="row"><spring:message code="column.goods.comp_nm" /></th>
		                        <td>
		                            <frame:compNo funcNm="fnCallBackCompanySearchPop" disableSearchYn="${adminConstants.USR_GRP_10 eq adminSession.usrGrpCd ? 'N' : 'Y'}" placeholder="${adminConstants.USR_GRP_10 eq adminSession.usrGrpCd ? '입점업체를 검색하세요' : ''}"/>
		                            <c:if test="${adminConstants.USR_GB_2010 eq adminSession.usrGbCd}">
		                            &nbsp;&nbsp;&nbsp;<frame:lowCompNo funcNm="searchLowCompany" placeholder="하위업체를 검색하세요"/>
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
			<div class="mButton">
				<div class="leftInner">			
			
			<%-- 		<button type="button" onclick="fnClaimCancelCancel();" class="btn_h25_type1">
						<spring:message code='column.order_common.btn.claim_return_cancel' />
					</button>
	
					<button type="button" onclick="fnClaimProductRecoveryFinal();" class="btn_h25_type1">
						<spring:message code='column.order_common.btn.claim_return_product_recovery_final' />
					</button>
					<button type="button" onclick="fnClaimProductRejectionFinal();" class="btn_h25_type1">
						<spring:message code='column.order_common.btn.claim_return_product_rejection_final' />
					</button>
					<button type="button" onclick="fnClaimProductApprove();" class="btn_h25_type1">
						<spring:message code='column.order_common.btn.claim_return_product_approve_final' />
					</button> --%>
				</div>
				<div class="rightInner">
					<button type="button" onclick="claimCancelListExcelDownload();" class="btn btn-add btn-excel right"><spring:message code='column.common.btn.excel_download' /></button>
				</div>
			</div>		
			
			<table id="clmCancelList" ></table>
			<div id="clmCancelListPage"></div>
		</div>
		<!-- ==================================================================== -->
		<!-- //그리드 -->
		<!-- ==================================================================== -->

	</t:putAttribute>

</t:insertDefinition>
