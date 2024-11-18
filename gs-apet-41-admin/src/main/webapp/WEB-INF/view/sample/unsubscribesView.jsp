<%--	
 - Class Name	: /sample/unsubscribesView.jsp
 - Description	: unsubscribes View
 - Since			: 2021.1.8
 - Author			: VALFAC
--%>
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8"%>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">
		$(document).ready(function() {
			createUnsubscribes();
		});
		
		function getUnsubscribes(syncYn) {
			var options = {
				url : "<spring:url value='/sample/getUnsubscribes.do' />",
				data : {syncYn : syncYn},
				callBack : function(data) {
					for(let index in data.result.unsubscribesList) {
						$("#unsubscribeList").jqGrid('addRowData', index, data.result.unsubscribesList[index], 'last', null);
					}
				}
			}
			ajax.call(options);
		}

		function headerFormReset() {
			$("#apiHeaderForm")[0].reset();
		}
		
		function createUnsubscribes(){
			let options = {
				datatype : 'local'
				, height : 400
				, sortname : 'sysRegDtm'
				, sortorder : 'DESC'
				, colModels : [
					  /* 회원번호 */
					{name:"mbrNo", label:'<spring:message code="column.mbr_no" />', width:"150", align:"center", classes:'cursor_default', sortable:false}
					  /* 회원 명  */
					, {name:"mbrNm", label:'<spring:message code="column.mbr_nm" />', width:"150", align:"center", classes:'cursor_default', sortable:false}
					  /* 로그인 아이디 */
					, {name:"loginId", label:'<spring:message code="column.login_id" />', width:"200", align:"center", classes:'cursor_default', sortable:false}
					  /* 휴대폰 */
					, {name:"mobile", label:'<spring:message code="column.mobile" />', width:"200", align:"center", classes:'cursor_default', sortable:false}
					, {name:"mkngRcvYn", label:"<spring:message code="column.member_view.mkng_rcv_yn" />", width:'100', align:'center', sortable:false, formatter:'select', editoptions:{value:"<frame:gridSelect grpCd='${adminConstants.COMM_YN }' showValue='false' />" } }  
				]
				
			};
			grid.create("unsubscribeList", options);
		}
		
		function registUnsubscribes(type){
			$("#unsubscribesType").val(type);
			if(validate.check("unsubscribesForm")) {
				var options = {
						url : "<spring:url value='/sample/registUnsubscribes.do' />",
						data : $("#unsubscribesForm").serialize(),
						callBack : function(data) {
							console.log('data',data);
							
						}
				}
				ajax.call(options);
			}
			
		}
		</script>
	</t:putAttribute>
	<t:putAttribute name="content">
		<div class="easyui-accordion search-accordion"
			data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect"
			style="width: 100%">
			<div title="080 수신거부 번호 조회" style="padding: 10px">
				<div class="box">
					<div>
						<ul style="font-size: 13px;">
							<li style="margin-bottom: 5px;"><b>·</b> </li>
							<li style="margin-bottom: 5px;"><b>·</b> </li>
						</ul>
					</div>
				</div>
			</div>
		</div>
		<br/>
		<div class="btn_area_center">
					<button type="button" onclick="getUnsubscribes('');" class="btn btn-ok">조회</button>
					<button type="button" onclick="getUnsubscribes('Y');" class="btn" style="background-color: #0066CC;">동기화</button>
				</div>
		<div class="mModule">
			<table id="unsubscribeList"></table>
			<div id="unsubscribeListPage"></div>
		</div>
		<br/>
		<div class="easyui-accordion search-accordion"
			data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect"
			style="width: 100%">
			<div title="080 수신거부 등록/삭제" style="padding: 10px">
				<div class="box">
					<form id="unsubscribesForm" name="unsubscribesForm" method="post">
						<input type="hidden" name="unsubscribesType" id="unsubscribesType" value="">
						<table class="table_type1">
							<tbody>
				                <tr>
				                	<th>
				                		모바일
				                	</th>
				                	<td colspan="3">
				                		<textarea rows="3" cols="30" id="mobileArea" name="mobileArea" class="validate[required]"></textarea>
				                	</td>
				                </tr>
							</tbody>
						</table>
					</form>
				</div>
			</div>
		</div>
		<div class="btn_area_center mb30">
			<button type="button" onclick="registUnsubscribes('');" class="btn btn-ok">등록</button>
			<button type="button" onclick="registUnsubscribes('delete');" class="btn" style="background-color: #0066CC;">삭제</button>
		</div>
    </div>
    
    
	</t:putAttribute>
</t:insertDefinition>