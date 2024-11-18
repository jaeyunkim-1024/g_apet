<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="defaultLayout">
	<t:putAttribute name="title">오픈마켓 주문 관리</t:putAttribute>

	<t:putAttribute name="script">

		<script type="text/javascript">
			$(document).ready(function(){
				orderList.createGrid();
			});
			$(function(){
				$("input:checkbox[name=arrOrdStatCd]").click(function(){
					var all = false;
					if ( validation.isNull( $(this).val() ) ){
						all = true;
					}
					if ( $('input:checkbox[name="arrOrdStatCd"]:checked').length == 0 ) {
						$('input:checkbox[name="arrOrdStatCd"]').eq(0).prop( "checked", true );
					} else {
						$('input:checkbox[name="arrOrdStatCd"]').each( function() {
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
			
			});
			
			var orderList = {
				/*
				 * 주문 목록 그리드 생성
				 */
				createGrid : function(){
					var options = {
						url : "<spring:url value='/market/orderListGrid.do' />"
						, colModels : [
                         	// 처리상태
                         	{name:"ordSeq", label:"<spring:message code='column.market_seq_no' />", width:"100", align:"center", hidden:true}						               
							// 마켓명
							, {name:"marketNm", label:'<spring:message code="column.market_nm" />', width:"100", align:"center", sortable:false, formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.OPENMARKET_GB}" />"}}
                            // 판매자아이디
                            , {name:"sellerId", label:'<spring:message code="column.seller_id" />', width:"70", align:"center", sortable:false}
                         	// 마켓주문번호
                         	, {name:"ordNo", label:'<b><u><tt><spring:message code="column.market_ord_no" /></tt></u></b>', width:"120", align:"center", sortable:false, classes:'pointer fontbold'}
                         	// VECI주문번호
                         	, {name:"shopOrdNo", label:'<spring:message code="column.shop_ord_no" />', width:"120", align:"center", sortable:false}
                         	// 마켓주문상태
                         	, {name:"marketOrdStd", label:'<spring:message code="column.market_ord_std" />', width:"80", align:"center", sortable:false, formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.MARKET_ORD_STAT}" />"}}
                         	// 마켓상품코드
                         	, {name:"prdNo", label:'<spring:message code="column.prd_no" />', width:"100", align:"center", sortable:false}
                         	// 마켓상품명
                         	, {name:"prdNm", label:'<spring:message code="column.prd_nm" />', width:"200", align:"center", sortable:false}
                         	// VECI매칭상품코드
                         	, {name:"shopPrdNo", label:'<spring:message code="column.shop_prd_no" />', width:"100", align:"center", sortable:false}                         	
                         	// VECI상품명
                         	, {name:"shopPrdNm", label:'<spring:message code="column.shop_prd_nm" />', width:"200", align:"center", sortable:false}                         	
                         	// 마켓주문옵션명
                         	, {name:"slctPrdOptNm", label:'<spring:message code="column.slct_prd_opt_nm" />', width:"200", align:"center", sortable:false}
                         	// VECI매칭옵션명
                         	, {name:"shopPrdOptNm", label:'<spring:message code="column.shop_prd_opt_nm" />', width:"200", align:"center", sortable:false}
                         	// 주문수량
                         	, {name:"ordQty", label:'<spring:message code="column.ord_qty" />', width:"50", align:"center", sortable:false}
                         	// 취소수량
                         	, {name:"cncQty", label:'<spring:message code="column.cnc_qty" />', width:"50", align:"center", sortable:false}
                         	// 주문금액
                         	, {name:"ordAmt", label:'<spring:message code="column.ordAmt" />', width:"80", align:"center", sortable:false}
                         	// 결제금액
                         	, {name:"ordPayAmt", label:'<spring:message code="column.pay_amt" />', width:"80", align:"center", sortable:false}
                         	// 송장번호
                         	, {name:"invcNo", label:'<spring:message code="column.statistics.inv_no" />', width:"100", align:"center", sortable:false}
                         	// 배송비
                         	, {name:"dlvCst", label:'<spring:message code="column.trans_cost" />', width:"80", align:"center", sortable:false}
                         	// 주문자연락처(전화)
                         	//, {name:"ordTlphnNo", label:'<spring:message code="column.ordr_tel" />', width:"100", align:"center", sortable:false}                         	
                         	// 주문자연락처(휴대폰)
                         	//, {name:"ordPrtblTel", label:'<spring:message code="column.ordr_mobile" />', width:"100", align:"center", sortable:false}
                         	// 주문자연락처(FULL)
                         	, {name:"ordFullTlphn", label:'<spring:message code="column.ord_full_tlphn" />', width:"120", align:"center", sortable:false}                         	
                         	// 수령인연락처(전화)
                         	//, {name:"rcvrTlphn", label:'<spring:message code="column.ordr_tel" />', width:"100", align:"center", sortable:false}
                         	// 수령인연락처(휴대폰)
                         	//, {name:"rcvrPrtblNo", label:'<spring:message code="column.ordr_tel" />', width:"100", align:"center", sortable:false}
                         	// 수령인연락처(FULL)
                         	, {name:"ordRcvrTlphn", label:'<spring:message code="column.ord_rcvr_tlphn" />', width:"120", align:"center", sortable:false}                         	
                         	// 배송주소
                         	, {name:"rcvrFullAddr", label:'<spring:message code="column.rcvr_full_addr" />', width:"250", align:"center", sortable:false}
                         	// 배송메세지
                         	, {name:"ordDlvReqCont", label:'<spring:message code="column.ord_dlv_req_cont" />', width:"250", align:"center", sortable:false}
                         	// 주문일&결제완료일
                         	, {name:"ordFullDt", label:'<spring:message code="column.ord_dt" />', width:"150", align:"center", sortable:false}
                         	// 처리상태
                         	, {name:"procCd", label:"<spring:message code='column.proc_cd' />", width:"100", align:"center", hidden:true}
				 		]			
						, height : 400
						, searchParam : $("#orderSearchForm").serializeJson()
						, multiselect : true
				        , onSelectAll: function(aRowids,status) {
							if (status) {
								var cbs = $("tr.jqgrow > td > input.cbox:disabled", $("#orderList")[0]);
								cbs.removeAttr("checked");
							
								$("#orderList")[0].p.selarrrow = $("#orderList").find("tr.jqgrow:has(td > input.cbox:checked)").map(function() { return this.id; }).get();
							}							
				        }							
						, onCellSelect : function (rowid, cellidx, cellvalue) {
						}
						, beforeSelectRow: function (rowid, e) {
							var rowData = $("#orderList").getRowData(rowid);
							if( "20" === rowData.procCd ) {
								return false;
							}
							return true;
						}
						, gridComplete: function() {  /** 데이터 로딩시 함수 **/
							var ids = $('#orderList').jqGrid('getDataIDs');
							
							for(var i=0 ; i < ids.length; i++){
								var ret =  $("#orderList").getRowData(ids[i]); // 해당 id의 row 데이터를 가져옴
								if( "20" === ret.procCd ) {
									$("#jqg_orderList_"+ids[i]).attr("disabled", true); 		
								}
							}
						}					
					};
					grid.create( "orderList", options) ;						
				}
				/*
				 * 주문 목록 재조회
				 */
				, reload : function(){
					// 주문 접수 일시 시작일
					var ordAcptDtmStart = $("#ordAcptDtmStart").val().replace( /-/gi, "" );
					// 주문 접수 일시 종료일
					var ordAcptDtmEnd = $("#ordAcptDtmEnd").val().replace( /-/gi, "" );

					// 시작일과 종료일 3개월 차이 일 경우 검색 불가
					var diffMonths = getDiffMonths( ordAcptDtmStart, ordAcptDtmEnd );					
					if ($("#searchKeyOrder").val() == "type01" && $("#searchValueOrder").val().trim() != "") {
						// 주문번호 검색이면 날짜 검색을 안함
					} else {
						if ( parseInt(diffMonths) > 3 ) {
							messager.alert('<spring:message code="admin.web.view.msg.common.valid.diffMonths" />', "Info", "info");
							return;
						}
					}

					var data = serializeFormData();

					var options = {
						searchParam : data
					};

					grid.reload("orderList", options);					
				}
					
			};
			
			function serializeFormData() {
	            var data = $("#orderSearchForm").serializeJson();
	            if ( undefined != data.arrOrdStatCd && data.arrOrdStatCd != null && Array.isArray(data.arrOrdStatCd) ) {
	                $.extend(data, {arrOrdStatCd : data.arrOrdStatCd.join(",")});
	            } else {
	                // 전체를 선택했을 때 Array.isArray 가 false 여서 이 부분을 실행하게 됨.
	                // 전체를 선택하면 검색조건의 모든 주문상세상태를 배열로 만들어서 파라미터 전달함.
	                var allOrdStatCd = new Array();
	                if ($("#arrOrdStatCd_default").is(':checked')) {
	                    $('input:checkbox[name="arrOrdStatCd"]').each( function() {
	                        if (! $(this).is(':checked')) {
	                            allOrdStatCd.push($(this).val());
	                        }
	                    });

	                    $.extend(data, {arrOrdStatCd : allOrdStatCd.join(",")});
	                }
	            }

	            return data;
			}			
            
            // 초기화 버튼클릭
            function searchReset () {
                resetForm ("orderSearchForm");
                <c:if test="${adminConstants.USR_GRP_10 ne adminSession.usrGrpCd}">
                $("#orderSearchForm #compNo").val('${adminSession.compNo}');
                </c:if>
            }            

			// 마켓주문 수집 일자 변경
			function marketSearchDateChange() {
				var term = $("#marketCheckOptDate").children("option:selected").val();
				if(term == "") {
					$("#marketOrdDtmStart").val("");
					$("#marketOrdDtmEnd").val("");
				} else {
					setSearchDate(term, "marketOrdDtmStart", "marketOrdDtmEnd");
				}
			}			
			
			// 마켓주문 검색 일자 변경
			function searchDateChange() {
				var term = $("#checkOptDate").children("option:selected").val();
				if(term == "") {
					$("#ordAcptDtmStart").val("");
					$("#ordAcptDtmEnd").val("");
				} else {
					setSearchDate(term, "ordAcptDtmStart", "ordAcptDtmEnd");
				}
			}
			
			// VECI주문등록 처리
			function dcgOrderMake() {
				var grid = $("#orderList");
				var selectedIDs = grid.getGridParam("selarrrow");
				
				if(selectedIDs != null && selectedIDs.length > 0) {
					messager.confirm("<spring:message code='column.order_common.confirm.order_batch_create' />", function(r){
						if(r){
							var data = new Array();
							for (var i in selectedIDs) {
								var rowdata = grid.getRowData(selectedIDs[i]);
								data.push(rowdata.ordSeq);
							}
							
							var options = {
								url : "<spring:url value='/market/marketOrderConfirm.do' />"
								, data : {
									arrOrdSeq : data.join(",")
								}
								, callBack : function(result){
									orderList.reload('');
								}
							};
							
							ajax.call(options);	
						}
					});				
				} else {
					messager.alert('<spring:message code="admin.web.view.msg.common.select.content" />', "Info", "info");
				}				
			}
		
			function getOrder() {
				var marketOrdDtmStart = $("#marketOrdDtmStart").val().replace( /-/gi, "" ) + "0000";
				var marketOrdDtmEnd = $("#marketOrdDtmEnd").val().replace( /-/gi, "" ) + "0000";
				
				var options = {
						url : "<spring:url value='/market/marketGetOrder.do' />"
						, data : {
							startDtm : marketOrdDtmStart,
							endDtm : marketOrdDtmEnd
						}
						, callBack : function(result){
							messager.alert('<spring:message code="admin.web.view.msg.market.success.marketGetOrder" />', "Info", "info");
							orderList.reload('');
						}
					};
					
				ajax.call(options);				
			}

		</script>

	</t:putAttribute>

	<t:putAttribute name="content">

		<!-- ==================================================================== -->
		<!-- 검색 -->
		<!-- ==================================================================== -->
		<div class="table_type1">
			<form name="orderSearchForm" id="orderSearchForm">

			<table summary="">
				<caption>주문 검색</caption>
				<colgroup>
					<col style="width:15%;">
					<col style="width:auto;">
				</colgroup>
				<tbody>
					<tr>
						<!-- 마켓주문 수집 일자 -->
						<th scope="row"><spring:message code="column.market_ord_collect_dtm" /></th>
						<td>
							<!-- 일자 선택 -->
							<frame:datepicker startDate="marketOrdDtmStart" endDate="marketOrdDtmEnd"  startValue="${marketSrchStartDtm}" endValue="${marketSrchEndDtm}"  format="yyyyMMdd" />
							<select id="marketCheckOptDate" name="checkOptDate" onchange="marketSearchDateChange();">
								<frame:select grpCd="${adminConstants.SELECT_PERIOD }"  selectKey="${adminConstants.SELECT_PERIOD_20 }" defaultName="기간선택" excludeOption="${adminConstants.SELECT_PERIOD_30},${adminConstants.SELECT_PERIOD_40},${adminConstants.SELECT_PERIOD_50}" />
							</select>
							<!-- 오픈마켓 리스트 -->
							&nbsp;&nbsp;
							<select id="marketCollectNm" name="marketCollectNm" onchange="#">
								<frame:select grpCd="${adminConstants.OPENMARKET_GB }"  selectKey="${adminConstants.OPENMARKET_GB_10 }" defaultName="오픈마켓" />
							</select>
							<!-- 오픈마켓 샐러 리스트 -->
                            <select name="marketCollectSellerId" class="wth100" title="선택상자" >
                                <option value="dcgworld" selected="selected">VECI</option>
                            </select>								
							<!-- 즉시주문수집 버튼 -->
							<button type="button" onclick="getOrder();" class="btn_h25_type1">즉시주문수집</button>
						</td>
					</tr>				
					<tr>
						<!-- 마켓주문 검색 일자 -->
						<th scope="row"><spring:message code="column.market_ord_search_dtm" /></th>
						<td>
                            <select name="searchDtmType" class="wth100" title="선택상자" >
                                <option value="type01" selected="selected">수집일</option>
                                <option value="type02">VECI주문등록일</option>
                                <option value="type03">결제일</option>
                            </select>						
							<frame:datepicker startDate="ordAcptDtmStart" endDate="ordAcptDtmEnd"  startValue="${srchStartDtm}" endValue="${srchEndDtm}"  format="yyyyMMdd" />
							<select id="checkOptDate" name="checkOptDate" onchange="searchDateChange();">
								<frame:select grpCd="${adminConstants.SELECT_PERIOD }"  selectKey="${adminConstants.SELECT_PERIOD_20 }" defaultName="기간선택" />
							</select>
						</td>
					</tr>
					<tr>
						<!-- 마켓주문 검색 조건 -->
						<th scope="row"><spring:message code="column.market_ord_search" /></th>
						<td>
							<!-- 오픈마켓 리스트 -->
							<select id="searchMarketNm" name="searchMarketNm" onchange="#">
								<frame:select grpCd="${adminConstants.OPENMARKET_GB }"  selectKey="${adminConstants.OPENMARKET_GB_10 }" defaultName="오픈마켓" />
							</select>
							<!-- 오픈마켓 샐러 리스트 -->
                            <select name="searchMarketSellerId" class="wth100" title="선택상자" >
                                <option value="dcgworld" selected="selected">VECI</option>
                            </select>						
                            <select name="searchKeyOrder" id="searchKeyOrder" class="wth100" title="선택상자" >
                                <option value="type01">마켓주문번호</option>
                                <option value="type02">VECI주문번호</option>
                            </select>
                            <input type="text" name="searchValueOrder" id="searchValueOrder" class="w120"  value="" />
						</td>
					</tr>
					<tr>
						<!-- 마켓주문 검색 조건(주문상태) -->
						<th scope="row"><spring:message code="column.market_ord_search_std" /></th>
						<td>
							<frame:checkbox name="arrOrdStatCd" grpCd="${adminConstants.MARKET_ORD_STAT }" defaultName="전체" defaultId="arrOrdStatCd_default" />
						</td>
					</tr>										
				</tbody>
			</table>
			</form>
		</div>

		<div class="btn_area_center">
			<button type="button" onclick="orderList.reload('');" class="btn_type2">검색</button>
			<button type="button" onclick="searchReset();" class="btn_type1">초기화</button>
		</div>
		<!-- ==================================================================== -->
		<!-- 검색 -->
		<!-- ==================================================================== -->

		<!-- ==================================================================== -->
		<!-- 기능 -->
		<!-- ==================================================================== -->
		<div class="mButton typeBorad">
			<div class="leftInner">
<c:if test="${adminConstants.USR_GRP_10 eq adminSession.usrGrpCd}">			
				<button type="button" onClick="dcgOrderMake();" class=btn_h25_type1>VECI 주문등록</button>
</c:if>				
			</div>
		</div>
		<!-- ==================================================================== -->
		<!-- //기능 -->
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