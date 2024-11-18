<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
	<script type="text/javascript">
		$(document).ready(function() {
			// 지역별 / 상픔주문 통계 리스트 생성
			createPlanningTeamByGoodsGrid();
		});

		// 지역별 / 상픔주문 통계 리스트
		function createPlanningTeamByGoodsGrid() {
			var gridOptions = {
				url : "<spring:url value='/statistics/planningTeamByGoodsListGrid.do'/>"
				, datatype : 'local'
				, height : 500
				, searchParam : $("#planningTeamByGoodsForm").serializeJson()
				, colModels : [
					// 상품명
					{name:"goodsNm", label:"<spring:message code='column.statistics.goods_nm' />", width:"200", align:"center", sortable:false}
					// 판매수량
					, {name:"ordQty", label:"<spring:message code='column.statistics.sales.cnt' />", width:"150", align:"center", sortable:false, summaryType:"sum", formatter:'integer'}
					// 매출액
					, {name:"saleAmt", label:"<spring:message code='column.statistics.sales.amount' />", width:"150", align:"center", sortable:false, summaryType:"sum", formatter:'integer'}
					// 카테고리
					, {name:"dispClsfNm", label:"<spring:message code='column.statistics.category_nm' />", width:"300", align:"center", sortable:false}
					// 브랜드
					, {name:"bndNm", label:"<spring:message code='column.statistics.brand' />", width:"120", align:"center", sortable:false}
					// 시리즈
					, {name:"seriesNm", label:"<spring:message code='column.statistics.series' />", width:"120", align:"center", sortable:false}
					// 주문 매체
					, {name:"ordMdaCd", label:"<spring:message code='column.order_common.ord_mda_cd' />", width:"120", align:"center", sortable:false, formatter:"select", editoptions:{value:"<frame:gridSelect grpCd='${adminConstants.ORD_MDA }' showValue='false' />" } }
					// 판매 공간
					, {name:"pageGbCd", label:"<spring:message code='column.order_common.page_gb_cd' />", width:"120", align:"center", sortable:false, formatter:"select", editoptions:{value:"<frame:gridSelect grpCd='${adminConstants.PAGE_GB }' showValue='false' />" } }
					// 회원 여부
					, {name:"memberYn", label:"<spring:message code='column.statistics.member.yn' />", width:"120", align:"center", sortable:false, formatter:"select", editoptions:{value:"<frame:gridSelect grpCd='${adminConstants.COMM_YN }' showValue='false' />" } }
					// 판매 지역
					, {name:"orderArea", label:"<spring:message code='column.statistics.sales.area' />", width:"120", align:"center", sortable:false}
				]
					, footerrow : true
					, userDataOnFooter : true
					, gridComplete : function () {
						var ordQty = $("#planningTeamByGoodsList" ).jqGrid('getCol', 'ordQty', false, 'sum');
						var saleAmt = $("#planningTeamByGoodsList" ).jqGrid('getCol', 'saleAmt', false, 'sum');

						$("#planningTeamByGoodsList" ).jqGrid('footerData', 'set',
							{
								goodsNm : '합계 : '
								, ordQty : ordQty
								, saleAmt : saleAmt
							}
						);
					}
			}

			grid.create("planningTeamByGoodsList", gridOptions);
		}

		// 검색
		function searchPlanningTeamByGoodsList() {
			var dateCheck = $(":radio[name=dateCheck]:checked").val();
			if(dateCheck == '01') {
				$("#startDtm").val($("#startDtm01").val().replace(/\-/g,'') );
				$("#endDtm").val($("#endDtm01").val().replace(/\-/g,'') );
			} else if (dateCheck == '02') {
				$("#startDtm").val($("#startDtm02 option:selected").val() + $("#startDtm02Month option:selected").val() );
				$("#endDtm").val($("#endDtm02 option:selected").val() + $("#endDtm02Month option:selected").val() );
			} else if (dateCheck == '03') {
				$("#startDtm").val($("#startDtm03 option:selected").val() );
				$("#endDtm").val($("#endDtm03 option:selected").val() );
			}

			var orderArea = new Array();
			$("input[name=orderArea1]:checked").each(function() {
				orderArea.push($(this).val() );
			});
			$("#orderArea").val(orderArea);

			var options = {
				searchParam : $("#planningTeamByGoodsForm").serializeJson()
			};

			grid.reload("planningTeamByGoodsList", options);
		}
	</script>
	</t:putAttribute>

	<t:putAttribute name="content">
		<form id="planningTeamByGoodsForm" name="planningTeamByGoodsForm" method="post" >
			<input type="hidden" name="startDtm" id="startDtm" value="" />
			<input type="hidden" name="endDtm" id="endDtm" value="" />
			<input type="hidden" name="orderArea" id="orderArea" value="" />
			<table class="table_type1">
				<caption>정보 검색</caption>
				<tbody>
					<tr>
						<!-- 기간별 (일별) -->
						<th scope="row" rowspan="3"><spring:message code="column.statistics.outer.period" /></th>
						<td>
							<label class="fRadio"><input type="radio" name="dateCheck" value="01" checked="checked" /><span>일별</span></label>
							<frame:datepicker startDate="startDtm01" endDate="endDtm01" startValue="${adminConstants.COMMON_START_DATE }" />
						</td>
						<!-- 판매 공간 -->
						<th scope="row"><spring:message code="column.order_common.page_gb_cd" /></th>
						<td>
							<label class="fRadio"><input type="radio" name="pageCheck" value="" checked="checked"> <span>전체</span></label>
							<label class="fRadio"><input type="radio" name="pageCheck" value="01"> <span>쇼룸</span></label>
							<label class="fRadio"><input type="radio" name="pageCheck" value="02"> <span><spring:message code="column.order_common.search_foreign_mall" /></span></label>

							<select name="pageGbCd" id="pageGbCd" title="선택상자" >
								<frame:select grpCd="${adminConstants.PAGE_GB}" defaultName="선택하세요"/>
							</select>
						</td>
					</tr>
					<tr>
						<!-- 기간별 (월별) -->
						<td>
							<label class="fRadio"><input type="radio" name="dateCheck" value="02" /><span>월별</span></label>
							<select class="w80" name="startDtm02" id="startDtm02">
								<frame:select grpCd="${adminConstants.YYYY}"/>
							</select>
							<select class="w50" name="startDtm02Month" id="startDtm02Month">
								<frame:select grpCd="${adminConstants.MM}"/>
							</select> ~
							<select class="w80" name="endDtm02" id="endDtm02">
								<frame:select grpCd="${adminConstants.YYYY}"/>
							</select>
							<select class="w50" name="endDtm02Month" id="endDtm02Month">
								<frame:select grpCd="${adminConstants.MM}"/>
							</select>
						</td>
						<!-- 주문 매체 -->
						<th scope="row"><spring:message code="column.order_common.ord_mda_cd" /></th>
						<td>
							<frame:radio name="ordMdaCd" grpCd="${adminConstants.ORD_MDA }" defaultName="전체" />
						</td>
					</tr>
					<tr>
						<!-- 기간별 (연도별) -->
						<td>
							<label class="fRadio"><input type="radio" name="dateCheck" value="03" /><span>연도별</span></label>
							<select class="w80" name="startDtm03" id="startDtm03">
								<frame:select grpCd="${adminConstants.YYYY}"/>
							</select> ~
							<select class="w80" name="endDtm03" id="endDtm03">
								<frame:select grpCd="${adminConstants.YYYY}"/>
							</select>
						</td>
						<!-- 상품검색 -->
						<th scope="row"><spring:message code="column.statistics.goods" /></th>
						<td>
							<select name="goodsCheck">
								<option value="goodsNm" selected="selected">상품명</option>
							</select>
							<input type="text" name="searchGoodsValue" class="w250" value="" />
						</td>
					</tr>
					<tr>
						<!-- 회원 -->
						<th scope="row"><spring:message code="column.statistics.member" /></th>
						<td>
							<label class="fRadio"><input type="radio" name="memberYn" value="" checked="checked"> <span>전체</span></label>
							<label class="fRadio"><input type="radio" name="memberYn" value="Y"> <span>회원</span></label>
							<label class="fRadio"><input type="radio" name="memberYn" value="N"> <span>비회원</span></label>
						</td>
						<!-- 지역 -->
						<th scope="row"><spring:message code="column.statistics.area" /></th>
						<td>
							<label class="fCheck"><input type="checkbox" name="orderArea1" value="서울"> <span>서울</span></label>
							<label class="fCheck"><input type="checkbox" name="orderArea1" value="부산"> <span>부산</span></label>
							<label class="fCheck"><input type="checkbox" name="orderArea1" value="대구"> <span>대구</span></label>
							<label class="fCheck"><input type="checkbox" name="orderArea1" value="인천"> <span>인천</span></label>
							<label class="fCheck"><input type="checkbox" name="orderArea1" value="광주"> <span>광주</span></label>
							<label class="fCheck"><input type="checkbox" name="orderArea1" value="대전"> <span>대전</span></label><br/>
							<label class="fCheck"><input type="checkbox" name="orderArea1" value="울산"> <span>울산</span></label>
							<label class="fCheck"><input type="checkbox" name="orderArea1" value="세종"> <span>세종</span></label>
							<label class="fCheck"><input type="checkbox" name="orderArea1" value="경기"> <span>경기</span></label>
							<label class="fCheck"><input type="checkbox" name="orderArea1" value="강원"> <span>강원</span></label>
							<label class="fCheck"><input type="checkbox" name="orderArea1" value="충북"> <span>충북</span></label>
							<label class="fCheck"><input type="checkbox" name="orderArea1" value="충남"> <span>충남</span></label><br/>
							<label class="fCheck"><input type="checkbox" name="orderArea1" value="전북"> <span>전북</span></label>
							<label class="fCheck"><input type="checkbox" name="orderArea1" value="전남"> <span>전남</span></label>
							<label class="fCheck"><input type="checkbox" name="orderArea1" value="경북"> <span>경북</span></label>
							<label class="fCheck"><input type="checkbox" name="orderArea1" value="경남"> <span>경남</span></label>
							<label class="fCheck"><input type="checkbox" name="orderArea1" value="제주"> <span>제주</span></label>
							<label class="fCheck"><input type="checkbox" name="orderArea1" value="기타"> <span>기타</span></label>
						</td>
					</tr>
				</tbody>
			</table>
		</form>

		<div class="btn_area_center">
			<button type="button" onclick="searchPlanningTeamByGoodsList();" class="btn btn-ok">검색</button>
			<button type="button" onclick="resetForm('planningTeamByGoodsForm');" class="btn btn-cancel">초기화</button>
		</div>

		<div class="mModule">
			<table id="planningTeamByGoodsList"></table>
		</div>
	</t:putAttribute>
</t:insertDefinition>