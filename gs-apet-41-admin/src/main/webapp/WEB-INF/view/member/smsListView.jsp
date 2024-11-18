<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">
	        var isGridExists = false;
			$(document).ready(function(){
				// createEmSmtLogGrid();
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

			// 그룹 코드 리스트
			function createEmSmtLogGrid(){
				var options = {
					url : "<spring:url value='/emailSms/smsListGrid.do' />"
					, height : 400
					, searchParam : $("#emSmtLogSearchForm").serializeJson()
					, colModels : [
		            	{name:"mtPr", label:'<spring:message code="column.srl_no" />', width:"70", sortable:false, align:"center"}
		                , {name:"gubun", label:'<spring:message code="column.gb_cd" />', width:"70", sortable:false, align:"center"}
 						, {name:"callback", label:'<spring:message code="column.snd_no" />', width:"120", align:"center"}
 						, {name:"content", label:'<spring:message code="column.contents" />', width:"500", align:"left"}
 						, {name:"recipientNum", label:'<spring:message code="column.rcvr_no" />', width:"120", align:"center"}
 						, {name:"dateClientReq", label:'<spring:message code="column.snd_dtm" />', width:"150", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss"}
					]
					, multiselect : false
				};
				grid.create("emSmtLogList", options);
				isGridExists = true;
			}

			function reloadEmSmtLogGrid(){
			    if (! isGridExists) {
			    	createEmSmtLogGrid();
			    }

				var data = $("#emSmtLogSearchForm").serializeJson();
				var bigo = "";
				if (data.selMon > 9 ){
					bigo = 	data.selYear + data.selMon;
				}else {
					bigo = 	data.selYear +"0"+ data.selMon;
				}
				var divi = false;
				<c:forEach items="${tableNames}" var="table" >
				var table    = "${table}";
					if(table == bigo){
						divi = true;
					}
				</c:forEach>
				if(divi != true){
					messager.alert("<spring:message code='admin.web.view.msg.member.sms.month_invalid' />", "Info", "info");
					return;
				}

				data.recipientNum = removeComma (data.recipientNum);
				var options = { searchParam : data };

				grid.reload("emSmtLogList", options);
			}
		</script>
	</t:putAttribute>
	<t:putAttribute name="content">
		<div class="easyui-accordion search-accordion" data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect" style="width:100%">
			<div title="<spring:message code='admin.web.view.common.search' />" style="padding:10px">
				<form name="emSmtLogSearchForm" id="emSmtLogSearchForm">
					<table class="table_type1">
						<caption>정보 검색</caption>
						<tbody>
							<tr>
								<th><spring:message code="column.sys_reg_dtm" /></th>
								<td>
									<!-- 시스템 등록 일시 -->
						 			<jsp:useBean id="now" class="java.util.Date" />
									<fmt:formatDate value="${now}" pattern="yyyy" var="year"/>
									<fmt:formatDate value="${now}" pattern="M" var="month"/>

									<select class="w80" id="selYear" name="selYear">
										<c:forEach begin="2017" end="2025" varStatus="i" >
											<option value="${i.index }" <c:if test="${year eq i.index }"> selected='selected'</c:if> >${i.index }년</option>
										</c:forEach>
									</select>
									<select class="w50" id="selMon" name="selMon">
										<c:forEach begin="1" end="12" varStatus="i" >
											<option value="${i.index }" <c:if test="${month eq i.index }"> selected='selected'</c:if> >${i.index }월</option>
										</c:forEach>
									</select>
								</td>
								<th><spring:message code="column.mobile"/></th>
								<td>
									<!-- 휴대폰 -->
									<input type="text" class="phoneNumber validate[required, custom[mobile]]" name="recipientNum" id="recipientNum" title="<spring:message code="column.mobile"/>" value="" />
								</td>
							</tr>
						</tbody>
					</table>
				</form>
				
				<div class="btn_area_center">
					<button type="button" onclick="reloadEmSmtLogGrid();" class="btn btn-ok">검색</button>
					<button type="button" onclick="resetForm('emSmtLogSearchForm');" class="btn btn-cancel">초기화</button>
				</div>
			</div>
		</div>

		<div class="mModule">
			<table id="emSmtLogList" ></table>
			<div id="emSmtLogListPage"></div>
		</div>

	</t:putAttribute>
</t:insertDefinition>