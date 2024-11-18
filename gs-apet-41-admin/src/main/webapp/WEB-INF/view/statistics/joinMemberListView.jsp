<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
	<script type="text/javascript">
		$(document).ready(function() {
			// 연령별가입회원 리스트 생성
			createJoinMemberGrid();
		});

		// 연령별가입회원 리스트
		function createJoinMemberGrid() {
			var gridOptions = {
				url : "<spring:url value='/statistics/joinMemberListGrid.do'/>"
				, datatype : 'local'
				, height : 500
				, searchParam : $("#joinMemberForm").serializeJson()
				, colModels : [
					// 출생년도
					{name:"birth", label:"<spring:message code='column.statistics.member.birth' />", width:"100", align:"center"}
					// 퍼센트
					, {name:"rate", label:"<spring:message code='column.statistics.member.rate' />", width:"200", align:"center", sortable:false, summaryType:"sum", formatter: 'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' %', thousandsSeparator:','}}
					// 남성
					, {name:"man", label:"<spring:message code='column.statistics.memer.man' />", width:"100", align:"center", sortable:false, summaryType:"sum", formatter:'integer'}
					// 여성
					, {name:"woman", label:"<spring:message code='column.statistics.memer.woman' />", width:"200", align:"center", sortable:false, summaryType:"sum", formatter:'integer'}
					// 총합
					, {name:"totCnt", label:"<spring:message code='column.statistics.memer.totcnt' />", width:"200", align:"center", sortable:false, summaryType:"sum", formatter:'integer'}
				]
				, footerrow : true
				, userDataOnFooter : true
				, gridComplete : function () {
					var rate = $("#joinMemberList" ).jqGrid('getCol', 'rate', false, 'sum');
					var man = $("#joinMemberList" ).jqGrid('getCol', 'man', false, 'sum');
					var woman = $("#joinMemberList" ).jqGrid('getCol', 'woman', false, 'sum');
					var totCnt = $("#joinMemberList" ).jqGrid('getCol', 'totCnt', false, 'sum');

					$("#joinMemberList" ).jqGrid('footerData', 'set',
						{
							birth : '합계 : '
							, rate : rate
							, man : man
							, woman : woman
							, totCnt : totCnt
						}
					);
				}
			}

			grid.create("joinMemberList", gridOptions);
		}

		// 검색
		function searchJoinMemberList() {
			var options = {
				searchParam : $("#joinMemberForm").serializeJson()
			};

			grid.reload("joinMemberList", options);
		}
	</script>
	</t:putAttribute>

	<t:putAttribute name="content">
		<form id="joinMemberForm" name="joinMemberForm" method="post" >
			<table class="table_type1">
				<caption>정보 검색</caption>
				<tbody>
					<tr>
						<!-- 주문 접수 일시 -->
						<th scope="row"><spring:message code="column.statistics.member.join" /></th>
						<td colspan="3">
							<frame:datepicker startDate="sysRegDtmStart" endDate="sysRegDtmEnd" startValue="${adminConstants.COMMON_START_DATE }" />
						</td>
					</tr>
				</tbody>
			</table>
		</form>

		<div class="btn_area_center">
			<button type="button" onclick="searchJoinMemberList();" class="btn btn-ok">검색</button>
			<button type="button" onclick="resetForm('joinMemberForm');" class="btn btn-cancel">초기화</button>
		</div>

		<div class="mModule">
			<table id="joinMemberList"></table>
		</div>
	</t:putAttribute>
</t:insertDefinition>