<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="defaultLayout">
	<t:putAttribute name="title">오픈마켓 클레임 관리</t:putAttribute>

	<t:putAttribute name="script">

		<script type="text/javascript">
			$(document).ready(function(){
				claimList.createGrid();
			});
			$(function(){
				$("input:checkbox[name=arrClmStatCd]").click(function(){
					var all = false;
					if ( validation.isNull( $(this).val() ) ){
						all = true;
					}
					if ( $('input:checkbox[name="arrClmStatCd"]:checked').length == 0 ) {
						$('input:checkbox[name="arrClmStatCd"]').eq(0).prop( "checked", true );
					} else {
						$('input:checkbox[name="arrClmStatCd"]').each( function() {
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
			
			var claimList = {
				/*
				 * 클레임 목록 그리드 생성
				 */
				createGrid : function(){
					var options = {
						url : "<spring:url value='/market/claimReturnListGrid.do' />"
						, colModels : [
                         	// 처리상태
                         	{name:"clmSeq", label:"<spring:message code='column.market_seq_no' />", width:"100", align:"center", hidden:true}						               
							// 마켓명
							, {name:"marketNm", label:'<spring:message code="column.market_nm" />', width:"100", align:"center", sortable:false, formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.OPENMARKET_GB}" />"}}
                            // 판매자아이디
                            , {name:"sellerId", label:'<spring:message code="column.seller_id" />', width:"70", align:"center", sortable:false}
                         	// 마켓주문번호
                         	, {name:"ordNo", label:'<b><u><tt><spring:message code="column.market_ord_no" /></tt></u></b>', width:"120", align:"center", sortable:false, classes:'pointer fontbold'}
                         	// VECI주문번호
                         	, {name:"shopOrdNo", label:'<spring:message code="column.shop_ord_no" />', width:"120", align:"center", sortable:false}
                         	// VECI클레임번호
                         	, {name:"clmNo", label:'<spring:message code="column.shop_clm_no" />', width:"120", align:"center", sortable:false}                         	
                         	// 클레임종류
                         	, {name:"clmCd", label:'<spring:message code="column.clm_cd" />', width:"80", align:"center", sortable:false, formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.MARKET_CLM_GB}" />"}}
                         	// 클레임상태
                         	, {name:"clmStat", label:'<spring:message code="column.clm_stat" />', width:"80", align:"center", sortable:false, formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.MARKET_CLM_STAT}" />"}}
                         	// 요청수량
                         	, {name:"clmReqQty", label:'<spring:message code="column.clm_req_qty" />', width:"50", align:"center", sortable:false}
                         	// 마켓상품코드
                         	, {name:"prdNo", label:'<spring:message code="column.prd_no" />', width:"100", align:"center", sortable:false}
                         	// VECI매칭상품코드
                         	, {name:"shopPrdNo", label:'<spring:message code="column.shop_prd_no" />', width:"100", align:"center", sortable:false}                         	
                         	// VECI상품명
                         	, {name:"shopPrdNm", label:'<spring:message code="column.shop_prd_nm" />', width:"200", align:"center", sortable:false}                         	
                         	// VECI매칭옵션명
                         	, {name:"shopPrdOptNm", label:'<spring:message code="column.shop_prd_opt_nm" />', width:"200", align:"center", sortable:false}     
                         	// 클레임요청일&클레임처리완료일
                         	, {name:"clmFullDt", label:'<spring:message code="column.clm_full_dt" />', width:"150", align:"center", sortable:false}
                         	// 처리상태
                         	, {name:"procCd", label:"<spring:message code='column.proc_cd' />", width:"100", align:"center", hidden:true}                         	
				 		]			
						, height : 400
						, searchParam : $("#orderSearchForm").serializeJson()
						, multiselect : true
				        , onSelectAll: function(aRowids,status) {
							if (status) {
								var cbs = $("tr.jqgrow > td > input.cbox:disabled", $("#claimList")[0]);
								cbs.removeAttr("checked");
							
								$("#claimList")[0].p.selarrrow = $("#claimList").find("tr.jqgrow:has(td > input.cbox:checked)").map(function() { return this.id; }).get();
							}							
				        }							
						, onCellSelect : function (rowid, cellidx, cellvalue) {
						}
						, beforeSelectRow: function (rowid, e) {
							var rowData = $("#claimList").getRowData(rowid);
							if( "11" === rowData.procCd || "13" === rowData.procCd  ) {
								return false;
							}
							return true;
						}
						, gridComplete: function() {  /** 데이터 로딩시 함수 **/
							var ids = $('#claimList').jqGrid('getDataIDs');
							
							for(var i=0 ; i < ids.length; i++){
								var ret =  $("#claimList").getRowData(ids[i]); // 해당 id의 row 데이터를 가져옴
								if( "11" === ret.procCd || "13" === ret.procCd ) {
									$("#jqg_claimList_"+ids[i]).attr("disabled", true); 		
								}
							}
						}					
					};
					grid.create( "claimList", options) ;						
				}
				/*
				 * 클레임 목록 재조회
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

					grid.reload("claimList", options);					
				}
					
			};
			
			function serializeFormData() {
	            var data = $("#orderSearchForm").serializeJson();
	            if ( undefined != data.arrClmStatCd && data.arrClmStatCd != null && Array.isArray(data.arrClmStatCd) ) {
	                $.extend(data, {arrClmStatCd : data.arrClmStatCd.join(",")});
	            } else {
	                // 전체를 선택했을 때 Array.isArray 가 false 여서 이 부분을 실행하게 됨.
	                // 전체를 선택하면 검색조건의 모든 주문상세상태를 배열로 만들어서 파라미터 전달함.
	                var allOrdStatCd = new Array();
	                if ($("#arrClmStatCd_default").is(':checked')) {
	                    $('input:checkbox[name="arrClmStatCd"]').each( function() {
	                        if (! $(this).is(':checked')) {
	                            allOrdStatCd.push($(this).val());
	                        }
	                    });

	                    $.extend(data, {arrClmStatCd : allOrdStatCd.join(",")});
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
			
			// 반품등록 처리
			function dcgClmReturnMake() {
				var grid = $("#claimList");
				var selectedIDs = grid.getGridParam("selarrrow");
				
				if(selectedIDs != null && selectedIDs.length > 0) {
					messager.confirm("<spring:message code='column.order_common.confirm.ob_claim_return_final' />", function(r){
						if(r){
							var data = new Array();
							for (var i in selectedIDs) {
								var rowdata = grid.getRowData(selectedIDs[i]);
								data.push(rowdata.clmSeq);
							}
							
							var options = {
								url : "<spring:url value='/market/marketClaimReturnConfirm.do' />"
								, data : {
									arrClmSeq : data.join(",")
								}
								, callBack : function(result){
									claimList.reload('');
								}
							};
							
							ajax.call(options);
						}
					});
				} else {
					messager.alert('<spring:message code="admin.web.view.msg.common.select.content" />', "Info", "info");
				}				
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
						<!-- 마켓클레임 수집 일자 -->
						<th scope="row"><spring:message code="column.market_clm_collect_dtm" /></th>
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
							<button type="button" onclick="#" class="btn_h25_type1">즉시수집</button>
						</td>
					</tr>				
					<tr>
						<!-- 마켓클레임 검색 일자 -->
						<th scope="row"><spring:message code="column.market_clm_search_dtm" /></th>
						<td>
                            <select name="searchDtmType" class="wth100" title="선택상자" >
                                <option value="type01" selected="selected">수집일</option>
                                <option value="type02">클레임요청일</option>
                            </select>						
							<frame:datepicker startDate="ordAcptDtmStart" endDate="ordAcptDtmEnd"  startValue="${srchStartDtm}" endValue="${srchEndDtm}"  format="yyyyMMdd" />
							<select id="checkOptDate" name="checkOptDate" onchange="searchDateChange();">
								<frame:select grpCd="${adminConstants.SELECT_PERIOD }"  selectKey="${adminConstants.SELECT_PERIOD_20 }" defaultName="기간선택" />
							</select>
						</td>
					</tr>
					<tr>
						<!-- 마켓클레임 검색 조건 -->
						<th scope="row"><spring:message code="column.market_clm_search" /></th>
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
						<!-- 마켓클레임 검색 조건(클레임상태) -->
						<th scope="row"><spring:message code="column.market_clm_search_std" /></th>
						<td>
							<frame:checkbox name="arrClmStatCd" grpCd="${adminConstants.MARKET_CLM_STAT }" defaultName="전체" defaultId="arrClmStatCd_default" excludeOption="${adminConstants.MARKET_CLM_STAT_01},${adminConstants.MARKET_CLM_STAT_02},${adminConstants.MARKET_CLM_STAT_201},${adminConstants.MARKET_CLM_STAT_212}" />
						</td>
					</tr>										
				</tbody>
			</table>
			</form>
		</div>

		<div class="btn_area_center">
			<button type="button" onclick="claimList.reload('');" class="btn_type2">검색</button>
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
				<button type="button" onClick="dcgClmReturnMake();" class=btn_h25_type1>반품등록 처리</button>
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
			<table id="claimList" ></table>
			<div id="claimListPage"></div>
		</div>
		<!-- ==================================================================== -->
		<!-- //그리드 -->
		<!-- ==================================================================== -->

	</t:putAttribute>

</t:insertDefinition>