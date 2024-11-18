<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ page import="framework.common.util.DateUtil" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
	<script type="text/javascript">
		$(document).ready(function() {
			// 상품별 판매 리스트 생성
			createGoodsSalesGrid();
		});

		// 상품별 판매 리스트
		function createGoodsSalesGrid() {
			
			var searchParam = $("#goodsSalesForm").serializeJson();
			// 집계 일자 시작일
			var dtmStart = $("#totalDtStart").val().replace(/-/gi, "");
			// 집계 일자 종료일
			var dtmEnd = $("#totalDtEnd").val().replace(/-/gi, "");
			// 시작일과 종료일 3개월 차이 계산
			var diffMonths = getDiffMonths(dtmStart, dtmEnd );
			if ( eval(diffMonths) > 3 ) {
				messager.alert('<spring:message code="admin.web.view.msg.common.valid.diffMonths" />', "Info", "info");
				return;
			}
			searchParam.totalDtStart = dtmStart; 
			searchParam.totalDtEnd   = dtmEnd;
			var gridOptions = {
     			url : "<spring:url value='/statistics/goodsSalesListGrid.do'/>"
				, datatype : 'local'
				, height : 500
				, searchParam : searchParam
				, paging :  false 
				, colModels : [
                      {name:"rank", label:"<spring:message code='column.statistics.goods.sales.rank' />", width:"90",align:"center", hidden:false}  
					//상품아이디
					, {name:"goodsId", label:"<spring:message code='column.statistics.goods_id' />",  width:"120", align:"center" , hidden:false}
					// 상품명
					, {name:"goodsNm", label:'<spring:message code="column.goods_nm" />', width:"300", align:"left", sortable:false}
					// 업체명
					, {name:"compNm", label:'<spring:message code="column.comp_nm" />', width:"120", align:"center", sortable:false}
					// 브랜드 명
		 			, {name:"bndNmKo", label:"<spring:message code='column.bnd_nm' />", width:"150", align:"center", sortable:false } /* 브랜드명 */
		 		    // 주문 수량
					, {name:"ordQty", label:"<spring:message code='column.order_qty' />", width:"100", align:"center", sortable:true, formatter:'integer', summaryType:"sum"}
					// 주문 금액
					, {name:"ordAmt", label:"<spring:message code='column.order_amt' />", width:"100", align:"center", sortable:false, formatter:'integer', summaryType:"sum"}
					// 취소 수량  
					, {name:"cncQty", label:"<spring:message code='column.cnc_qty' />", width:"100", align:"center", sortable:true, formatter:'integer', summaryType:"sum"}
					// 취소 금액
					, {name:"cncAmt", label:"<spring:message code='column.cnc_amt' />", width:"100", align:"center", sortable:false, formatter:'integer', summaryType:"sum"}
					// 반품 수량
					, {name:"rtnQty", label:"<spring:message code='column.rtn_qty' />", width:"100", align:"center", sortable:true, formatter:'integer', summaryType:"sum"}
					// 반품 금액
					, {name:"rtnAmt", label:"<spring:message code='column.rtn_amt' />", width:"100", align:"center", sortable:false, formatter:'integer', summaryType:"sum"}
					// 집계 점수
					, {name:"totalScr", label:"<spring:message code='column.estm_score' />", width:"100", align:"center", sortable:false, formatter:'integer', hidden:true}
					// 주문 금액 - 취소 금액 - 반품 금액
					, {name:"totAmt", label:"계", width:"100", align:"right", sortable:false, summaryType:"sum", formatter:'integer'}
				]
				, footerrow : true
				, userDataOnFooter : true
	            , gridComplete: function() {  /** 데이터 로딩시 함수 **/	                
	                var ordQty 	= $("#goodsSalesList").jqGrid('getCol', 'ordQty', false, 'sum');
	                var ordAmt 	= $("#goodsSalesList").jqGrid('getCol', 'ordAmt', false, 'sum');
	                var cncQty 	= $("#goodsSalesList").jqGrid('getCol', 'cncQty', false, 'sum');
	                var cncAmt 	= $("#goodsSalesList").jqGrid('getCol', 'cncAmt', false, 'sum');
	                var rtnQty 	= $("#goodsSalesList").jqGrid('getCol', 'rtnQty', false, 'sum');
	                var rtnAmt 	= $("#goodsSalesList").jqGrid('getCol', 'rtnAmt', false, 'sum');
	                var totAmt 	= $("#goodsSalesList").jqGrid('getCol', 'totAmt', false, 'sum');
	                
	                $("#goodsSalesList").jqGrid('footerData', 'set',
						{
	                		bndNmKo : '총계 : '
							, ordQty  : ordQty
							, ordAmt : ordAmt
							, cncQty : cncQty
							, cncAmt : cncAmt
							, rtnQty : rtnQty
							, rtnAmt : rtnAmt
							, totAmt : totAmt
						}
					);
	            }
			}

			grid.create("goodsSalesList", gridOptions);
		}

		// 검색
		function searchGoodsSalesList() {
			var searchParam = $("#goodsSalesForm").serializeJson();
			// 집계 일자 시작일
			var dtmStart = $("#totalDtStart").val().replace(/-/gi, "");
			// 집계 일자 종료일
			var dtmEnd = $("#totalDtEnd").val().replace(/-/gi, "");
			// 시작일과 종료일 3개월 차이 계산
			var diffMonths = getDiffMonths(dtmStart, dtmEnd );
			if ( eval(diffMonths) > 3 ) {
				messager.alert('<spring:message code="admin.web.view.msg.common.valid.diffMonths" />', "Info", "info");
				return;
			}
			searchParam.totalDtStart = dtmStart; 
			searchParam.totalDtEnd   = dtmEnd; 
			var options = {
				searchParam : searchParam
			};
			grid.reload("goodsSalesList", options);
		}
 
	</script>
	</t:putAttribute>
	<t:putAttribute name="content">		
		<div class="easyui-accordion search-accordion" data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect" style="width:100%">
			<div title="<spring:message code='admin.web.view.common.search' />" style="padding:10px">
				<form id="goodsSalesForm" name="goodsSalesForm" method="post" >
					<table class="table_type1">
						<caption>정보 검색</caption>
						<tbody>
							<tr>
								<th scope="row">
									<spring:message code="column.settlement.total_dt" /><!-- 집계일자 -->
								</th>
								<td>
									<frame:datepicker startDate="totalDtStart" endDate="totalDtEnd" startValue="${ DateUtil.addDay(adminConstants.COMMON_DATE_FORMAT ,-7) }"  />
								</td>
								<th scope="row"><spring:message code="column.ord_mda_cd" /></th> <!-- 주문 매체 -->
								<td>
			                        <select name="ordMdaCd" id="ordMdaGb" title="선택상자" >
										<frame:select grpCd="${adminConstants.ORD_MDA}" defaultName="선택하세요"/>
									</select>
								</td>
							</tr>
							<tr>
								<th scope="row"><spring:message code="column.st_id" /></th> <!-- 사이트 ID -->
								<td colspan="3">
			                        <select id="stIdCombo" name="stId">
				                    	<frame:stIdStSelect defaultName="사이트선택" />
				                    </select>
								</td>
							</tr>
							
							
						</tbody>
					</table>
					
					<div class="btn_area_center">
						<button type="button" onclick="searchGoodsSalesList();" class="btn btn-ok">검색</button>
						<button type="button" onclick="resetForm('goodsSalesForm');" class="btn btn-cancel">초기화</button>
					</div>
				</form>	
			</div>
		</div>
		<div class="mModule">
			<table id="goodsSalesList"></table>
		</div>		
	</t:putAttribute>
</t:insertDefinition>