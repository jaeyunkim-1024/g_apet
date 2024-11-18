<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
	<script type="text/javascript">

		$(document).ready(function(){
			searchDateChange();
			createDepositListGrid();
			
			$("#depositSearchForm #depositStartDtm").change(function(){
				compareDate("depositStartDtm", "depositEndDtm");
			});

			$("#depositSearchForm #depositEndDtm").change(function(){
				compareDate2("depositStartDtm", "depositEndDtm");
			});
		});
		
		function searchDateChange() {
			var term = $("#depositSearchForm #checkOptDate").children("option:selected").val();
			if(term == "") {
				$("#depositSearchForm #depositStartDtm").val("");
				$("#depositSearchForm #depositEndDtm").val("");
			} else {
				setSearchDate(term, "depositStartDtm", "depositEndDtm");
			}
		}
		
		// 초기화 버튼클릭
        function searchDepositReset() {
            resetForm ("depositSearchForm");
			searchDateChange();
        }
		
		function createDepositListGrid(){
			// 입금 조회그리드
			var options = {
				url : "<spring:url value='/claim/depositListGrid.do' />"
				, height : 200
				, searchParam : $("#depositSearchForm").serializeJson()
				,colModels : [
					{name:"payNo", label:'번호', width:"100", align:"center", sortable:false}
		 			// 클레임 번호
		 			, {name:"clmNo", label:'<spring:message code="column.clm_no" />', width:"120", align:"center", sortable:false}
		 			/* 계좌번호 */
		 			, {name:"acctNo", label:'<spring:message code='column.acctNo' />', width:"100", align:"center", sortable:false}
		 			/* 은행명 */
		 			, {name:"bankCd", label:'은행명', width:"100", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.BANK}" />"}, sortable:false}
		 			// 입금금액
		 			, {name:"payAmt", label:'<spring:message code="column.claim_common.deposit_amt" />', width:"115", align:"center", formatter:'integer', sortable:false}
		 			// 입금자명
		 			, {name:"ooaNm", label:'<spring:message code="column.claim_common.deposit_nm" />', width:"70", align:"center", sortable:false}
		 			// 입금 상태
		 			, {name:"depositStat", label:'<spring:message code="column.claim_common.deposit_stat" />', width:"80", align:"center", sortable:false, formatter:function(rowId, val, rowObject, cm) {
	                    	if(rowObject.payStatCd == '${adminConstants.PAY_STAT_00}'){
	                    		return '입금확인중';
	                    	}else{
	                    		return '입금완료';
	                    	}
                    	} 
		 			}
		 			// 입금일
		 			, {name:"payCpltDtm", label:'입금일', width:"120", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd", sortable:false}
		 			// 등록일
		 			, {name:"sysRegDtm", label:'<spring:message code="column.sys_reg_dt" />', width:"120", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd", sortable:false}
		 			, {name:"payStatCd", hidden:true}
		 		]
			}

			grid.create( "layerDepositList", options) ;
		}
		
		function searchDepositList () {
			var options = {
				searchParam : $('#depositSearchForm').serializeJson()
			};
			grid.reload("layerDepositList", options);
		}
		
		
	</script>

	<form id="depositSearchForm" name="depositSearchForm" method="post" >
		<input type="hidden" name="acctNo" value="${payBaseSO.acctNo }" />
		<table class="table_type1 popup">
			<caption>정보 검색</caption>
			<colgroup>
				<col style="width: 100px;"/>
				<col style="width: 425px;"/>
				<col style="width: 100px;"/>
				<col/>
			</colgroup>
			<tbody>
				<tr>
					<th scope="row">입금일</th>
					<td>
						<frame:datepicker startDate="depositStartDtm" endDate="depositEndDtm" startValue="${adminConstants.COMMON_START_DATE }" />
						&nbsp;&nbsp;
						<select id="checkOptDate" name="checkOptDate" onchange="searchDateChange();" style="width:120px !important;">
							<frame:select grpCd="${adminConstants.SELECT_PERIOD }" selectKey="${adminConstants.SELECT_PERIOD_20 }" defaultName="기간선택" />
						</select>
					</td>					
					<th scope="row">조회 구분</th>
					<td>
                    	<select name="searchKey" class="w100" title="선택상자" >
                            <option value="type00" selected="selected">클레임번호</option>
                            <option value="type01">입금자명</option>
                        </select>
                        <input type="text" name="searchValue" class="w150" value="${payBaseSO.clmNo }" />
					</td>
				</tr>
			</tbody>
		</table>
	</form>
	<div class="btn_area_center">
		<button type="button" onclick="searchDepositList();" class="btn btn-ok">검색</button>
		<button type="button" onclick="searchDepositReset();" class="btn btn-cancel">초기화</button>
	</div>
	<hr />
	
	<div class="mModule">
		<table id="layerDepositList" ></table>
		<div id="layerDepositListPage"></div>
	</div>
