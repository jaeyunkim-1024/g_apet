<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<script type="text/javascript">
$(document).ready(function(){
	
	$(".datepicker").focus(function(){
  		$("#historyListForm #checkOptDate option:eq(0)").prop("selected", true);
  	});
	
	layerHistoryList.searchDateChange();
	
	$("#historyListForm #sysRegDtmStart , #historyListForm #sysRegDtmEnd").on("change",function(e){
		e.preventDefault();
		var type = "end"
		if($(this).attr('id').indexOf('Start') > -1){
			type = "start";
		}
		compareDateForDefault("sysRegDtmStart", "sysRegDtmEnd", "${frame:toDate('yyyy-MM-dd')}", "${frame:toDate('yyyy-MM-dd')}", type);
	});
})

</script>
<form id="historyListForm" name="historyListForm" method="post" >
	<input type="hidden" id="histGb" name="histGb" value="${HistorySO.histGb }" />
	<input type="hidden" id="goodsId" name="goodsId" value="${HistorySO.goodsId }" />

				<table class="table_type1 popup">
					<caption>정보 검색</caption>
					<tbody>
						<tr>
							<th scope="row"><spring:message code="column.sys_reg_dtm" /></th> <!-- 기간 -->
							<td>
								<frame:datepicker startDate="sysRegDtmStart" endDate="sysRegDtmEnd" startValue="${frame:toDate('yyyy-MM-dd') }" endValue="${frame:toDate('yyyy-MM-dd') }" />
								&nbsp;&nbsp;
								<select id="checkOptDate" name="checkOptDate" onchange="layerHistoryList.searchDateChange();">
									<frame:select grpCd="${adminConstants.SELECT_PERIOD }" selectKey="${adminConstants.SELECT_PERIOD_40 }" defaultName="기간선택" />
								</select>
							</td>
						</tr>
						<tr>
							<th scope="row"><spring:message code="column.sys_regr_nm" /></th>	<!-- 시스템 등록자 명 -->
							<td>
								<input type="text" id="sysRegrNm" name="sysRegrNm" title="<spring:message code="column.sys_regr_nm" />" value="" />
							</td>
						</tr>
					</tbody>
				</table>
</form>
			<div class="btn_area_center mb30">
				<button type="button" onclick="layerHistoryList.searchHistoryList();" class="btn btn-ok">검색</button>
				<button type="button" onclick="layerHistoryList.searchReset('${HistorySO.histGb }', '${HistorySO.goodsId }');" class="btn btn-cancel">초기화</button>
			</div>
			
			<table id="historyList" ></table>
			<div id="historyListPage"></div>
