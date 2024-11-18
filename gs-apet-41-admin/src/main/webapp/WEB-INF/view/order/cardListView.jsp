<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ page import="biz.interfaces.inicis.util.INIPayUtil" %>

<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">

		<script type="text/javascript">
			$(document).ready(function(){
				orderList.createGrid();
			});

			$(function(){

				$("input:checkbox[name=arrOrdDtlStatCd]").click(function(){

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
			
			});
			
			var orderList = {
				/*
				 * 주문 목록 그리드 생성
				 */
				createGrid : function(){
					var options = {
						url : "<spring:url value='/order/orderListGrid.do' />"
						, colModels : [
				             // 주문번호
				             {name:"", label:'', width:"10", align:"center", sortable:false}
				             ,{name:"ordNo", label:'<spring:message code="column.ord_no" />', width:"120", align:"center", sortable:false}
                            // 주문상세일련번호
                            , {name:"ordDtlSeq", label:'<b><u><tt><spring:message code="column.ord_dtl_seq" /></tt></u></b>', width:"70", align:"center", sortable:false, classes:'pointer fontbold'}				             
				 			// 사이트 ID
				 			, {name:"stId", label:"<spring:message code='column.st_id' />", width:"70", align:"center", hidden:true}
				 			// 사이트 명
				 			, {name:"stNm", label:"<spring:message code='column.st_nm' />", width:"80", align:"center", sortable:false}
				             // 주문매체
				            , {name:"ordMdaCd", label:'<spring:message code="column.ord_mda_cd" />', width:"60", align:"center", formatter:"select", sortable:false, editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.ORD_MDA}" />"}}
				             // 주문접수일자
				            , {name:"ordAcptDtm", label:'<spring:message code="column.ord_acpt_dtm" />', width:"110", align:"center", sortable:false, formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm"}			
				             // 주문완료일자
				            , {name:"ordCpltDtm", label:'<spring:message code="column.ord_cplt_dtm" />', width:"110", align:"center", sortable:false, formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm"}			
				 			// 주문자ID
				 			, {name:"ordrId", label:'<spring:message code="column.ordUserId" />', width:"80", align:"center", sortable:false}	
				 			// 주문자명
				 			, {name:"ordNm", label:'<spring:message code="column.ord_nm" />', width:"70", align:"center", sortable:false}
				 			// 주문자 휴대폰
				 			, {name:"ordrMobile", label:'<spring:message code="column.ord.ordrMobile" />', width:"100", align:"center",  formatter:gridFormat.phonenumber, sortable:false}
				 			, {name:"bndNmKo", label:"<spring:message code='column.bnd_nm' />", width:"120", align:"center", sortable:false } /* 브랜드명 */
						 	// 상품명
						 	, {name:"goodsNm", label:'<spring:message code="column.goods_nm" />', width:"300", align:"left", sortable:false }
						 	, {name:"goodsId", label:'<spring:message code="column.goods_id" />', width:"250", align:"left", sortable:false,  hidden: true}
						 	// 단품명 	
						 	, {name:"itemNm", label:'<spring:message code="column.item_nm" />', width:"100", align:"center", sortable:false}
                            // 주문내역상태코드
                            , {name:"ordDtlStatCd", label:'<spring:message code="column.ord_dtl_stat_cd" />', width:"80", align:"center", formatter:"select", sortable:false, editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.ORD_DTL_STAT}" />"}, hidden:true}
                            // 주문내역상태코드 이름
                            , {name:"ordDtlStatCdNm", label:'<spring:message code="column.ord_stat_cd" />', width:"80", align:"center", sortable:false}
                            // 클레임상태
                            , {name:"clmIngYn", label:'<spring:message code="column.clm_stat_cd" />', width:"70", align:"center", sortable:false, hidden:true}						 	
						 	// 주문수량
						 	, {name:"ordQty", label:'<spring:message code="column.ord_qty" />', width:"60", align:"center", formatter:'integer'}
						 	// 취소수량
						 	, {name:"cncQty", label:'<spring:message code="column.cnc_qty" />', width:"60", align:"center", formatter:'integer'}
				 			// 잔여주문수량
				 			, {name:"rmnOrdQty", label:'<spring:message code="column.rmn_ord_qty" />', width:"70", align:"center", formatter:'integer', sortable:false, hidden:true}
						 	// 반품수량
						 	, {name:"rtnQty", label:'<spring:message code="column.rtn_qty" />', width:"60", align:"center",  formatter:'integer', hidden:true}
				 			// 반품완료수량
				 			, {name:"rtnCpltQty", label:'<spring:message code="column.rtn_cplt_qty" />', width:"70", align:"center", formatter:'integer', sortable:false}
				 			// 반품진행수량
				 			, {name:"rtnIngQty", label:'<spring:message code="column.rtn_ing_qty" />', width:"70", align:"center", formatter:'integer', sortable:false}
				 			// 교환진행수량
				 			, {name:"clmExcIngQty", label:'<spring:message code="column.clm_exc_ing_qty" />', width:"70", align:"center", formatter:'integer', sortable:false}
						 	// 건별결제금액
						    , {name:"paySumAmt", label:'<spring:message code="column.order_common.pay_dtl_amt" />', width:"80", align:"center", formatter:'integer', sortable:false}
				 			// 수령인 명
				 			, {name:"adrsNm", label:'<spring:message code="column.ord.adrsNm" />', width:"150", align:"center", sortable:false}
				 			// 수령인 휴대폰
				 			, {name:"mobile", label:'<spring:message code="column.ord.mobile" />', width:"100", align:"center", formatter:gridFormat.phonenumber, sortable:false}
				 			// 수령인 주소 1
				 			, {name:"roadAddr", label:'<spring:message code="column.ord.roadAddr" />', width:"300", align:"center", sortable:false}
				 			// 수령인 주소 2
				 			, {name:"roadDtlAddr", label:'<spring:message code="column.ord.roadDtlAddr" />', width:"200", align:"center", sortable:false}
				 		]			
						, height : 400
						, searchParam : $("#orderSearchForm").serializeJson()
						, onCellSelect : function (id, cellidx, cellvalue) {
							var cm = $("#orderList").jqGrid("getGridParam", "colModel");
							var rowData = $("#orderList").getRowData(id);
							fnCardDetailView(rowData.ordNo);	
							 
							
							
						}
			            , gridComplete: function() {  /** 데이터 로딩시 함수 **/

			            	var ids = $('#orderList').jqGrid('getDataIDs');
			            
			                // 그리드 데이터 가져오기
			                var gridData = $("#orderList").jqGrid('getRowData');

			            	if(gridData.length > 0){
				                // 데이터 확인후 색상 변경
				                for (var i = 0; i < gridData.length; i++) {

				                	// 데이터의 is_test 확인
				                	if (gridData[i].rmnOrdQty == '0') {
				                	   
				                		// 열의 색상을 변경하고 싶을 때(css는 미리 선언)
				                		$('#orderList tr[id=' + ids[i] + ']').css('color', 'red');
				                   }
				                }			     
			            	}
			            	
			            }							
						, grouping: true
						, groupField: ["ordNo"]
						, groupText: ["주문번호"]
						, groupOrder : ["asc"]
						, groupCollapse: false
						, groupColumnShow : [false]
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
							messager.alert("검색기간은 3개월을 초과할 수 없습니다.","info","info");
							
							return;
						}
					}

					var data = $("#orderSearchForm").serializeJson();
					if ( undefined != data.arrOrdDtlStatCd && data.arrOrdDtlStatCd != null && Array.isArray(data.arrOrdDtlStatCd) ) {
						$.extend(data, {arrOrdDtlStatCd : data.arrOrdDtlStatCd.join(",")});
					}

					var options = {
						searchParam : data
					};

					grid.reload("orderList", options);					
				}
					
			};
			
			// 카드명세 
			/* function fnCardDetailView(dos ) {
				
				console.log("ordNo>>>"+dos);
				var config = {
						  url :  '/order/cardListPopView.do'
						, width : '850'
						, height : '500'
						, target : dos
						, scrollbars : 'no'
						, resizable : 'no'
						, location : 'no'
						, menubar : 'no'
							, data : {
		 						ordNo : dos
		 					}
					};
					openWindowPop(config);
			} */
			
			
			function fnCardDetailView(dos) {
			 
				var options = {
					url : '/order/cardListPopView.do'
					, data : {
						ordNo : dos
					}
					, dataType : "html"
					, callBack : function (data ) {
						var config = {
							id : "cardDetailPopViewLayer"
							, width : 1000
							, height : 500
							, top : 200
							, title : "카드영수증 상세"
							, body : data
						}
						layer.create(config);
					}
				}
				ajax.call(options );
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
            
            $(document).on("click", "input:checkbox[name=showAllLowComp]", function(e){
                if ($(this).is(":checked")) {
                    $("#showAllLowCompany").val("Y");   
                } else {
                    $("#showAllLowCompany").val("N");
                }
            });
            
            // 초기화 버튼클릭
            function searchReset () {
                resetForm ("orderSearchForm");
                <c:if test="${adminConstants.USR_GRP_10 ne adminSession.usrGrpCd}">
                $("#orderSearchForm #compNo").val('${adminSession.compNo}');
                $("#orderSearchForm #showAllLowCompany").val("N");
                </c:if>
            }            

			// 주문생성(일괄)
			function fnOrderCreateBatchPop() {

				var width = 1100;
				var height = 750;

				var config = {
					  url : '/order/orderCreateBatchPopView.do'
					, width : width
					, height : height
					, target : 'orderCreateBatchPop'
					, scrollbars : 'no'
					, resizable : 'no'
					, location : 'no'
					, menubar : 'no'
// 					, data : {
// 						ordNo : '${orderBase.ordNo}'
// 						, arrOrdDtlSeq : arrOrdDtlSeq
// 						, clmTpCd : clmTpCd
// 					}
				};

				openWindowPop(config);

			}

			// 엑셀 다운로드
			function orderListExcelDownload(){
				createFormSubmit( "orderListExcelDownload", "/order/orderListExcelDownload.do", $("#orderSearchForm").serializeJson() );
			}

			// 등록일 변경
			function searchDateChange() {
				var term = $("#checkOptDate").children("option:selected").val();
				if(term == "") {
					$("#ordAcptDtmStart").val("");
					$("#ordAcptDtmEnd").val("");
				} else {
					setSearchDate(term, "ordAcptDtmStart", "ordAcptDtmEnd");
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
				<form name="orderSearchForm" id="orderSearchForm">
					<input type="hidden" name="payMeansCd" id="payMeansCd" value="${adminConstants.PAY_MEANS_10 }">
			 
					<table class="table_type1">
						<caption>주문 검색</caption>
						<colgroup>
							<col style="width:120px;">
							<col />
							<col style="width:120px;">
							<col style="width:20%;">
							<col style="width:120px;">
							<col style="width:20%;">
						</colgroup>
						<tbody>
		
							<tr>
								<!-- 주문 접수 일자 -->
								<th scope="row"><spring:message code="column.ord_acpt_dtm" /></th>
								<td>
									<frame:datepicker startDate="ordAcptDtmStart" endDate="ordAcptDtmEnd"  startValue="${srchStartDtm}" endValue="${srchEndDtm}"  format="yyyyMMdd" />
									&nbsp;&nbsp;
									<select id="checkOptDate" name="checkOptDate" onchange="searchDateChange();">
										<frame:select grpCd="${adminConstants.SELECT_PERIOD }"  selectKey="${adminConstants.SELECT_PERIOD_20 }" defaultName="기간선택" />
									</select>
								</td>
								<!-- 사이트 ID -->
			                    <th scope="row"><spring:message code="column.st_id" /></th> <!-- 사이트 ID -->
			                    <td>
			                        <%-- <select name="stId" title="<spring:message code="column.st_id" />">
		                       			<option value="">전체</option>
			                       		<c:forEach items="${siteList}" var="stStdInfo">
			                       			<option value="${stStdInfo.stId}">${stStdInfo.stNm}</option>
			                       		</c:forEach> 
			                        </select> --%>
			                        <select id="stIdCombo" class="wth100" name="stId">
				                    	<frame:stIdStSelect defaultName="사이트선택" />
				                    </select>
			                    </td>
		                        <!-- 주문매체 -->
		                        <th scope="row"><spring:message code="column.ord_mda_cd" /></th>
		                        <td>
		                            <frame:radio name="ordMdaCd" grpCd="${adminConstants.ORD_MDA }" defaultName="전체" />
		                        </td>
							</tr>
							<tr>
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
		                        <!-- 상품정보 -->
		                        <th scope="row"><spring:message code="column.order_common.goods_info" /></th>
		                        <td>
		                            <select name="searchKeyGoods" class="w100" title="선택상자" >
		                                <option value="type01">상품명</option>
		                                <option value="type02">상품NO</option>
		                                <option value="type03">단품명</option>
		                                <option value="type04">단품NO</option>
		                            </select>
		                            <input type="text" name="searchValueGoods" class="w120" value="" />
		                        </td>
							</tr>
							 
						 
						</tbody>
					</table>
				</form>
				
				<div class="btn_area_center">
					<button type="button" onclick="orderList.reload('');" class="btn btn-ok">검색</button>
					<button type="button" onclick="searchReset();" class="btn btn-cancel">초기화</button>
				</div>
			</div>
		</div>
        
		<div class="mModule">
			<table id="orderList" ></table>
			<div id="orderListPage"></div>
		</div>
 
	</t:putAttribute>

</t:insertDefinition>
