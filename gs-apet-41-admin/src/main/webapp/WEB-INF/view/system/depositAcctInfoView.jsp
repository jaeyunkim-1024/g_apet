<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">
			$(document).ready(function(){
				 
				 
			});

			    
			function insertDepositAcctInfo() {
				if(validate.check("depositAcctInfoForm")) {
					messager.confirm('<spring:message code="column.common.confirm.insert" />', function(r){
						if(r){
							var data = $("#depositAcctInfoForm").serializeJson();
							 
							 
							console.log("========");
							console.log(data);
							console.log("========");
							//return;
							var options = {
								url : "<spring:url value='/system/depositAcctInfoInsert.do' />"
								, data :  data
								, callBack : function(result){
									messager.alert("<spring:message code='column.common.regist.final_msg' />", "Info", "info", function(){
										updateTab('/system/depositAcctInfoView.do?acctInfoNo=' + result.depositAcctInfo.acctInfoNo, '무통장 계좌 상세');	
									});
								}
							};

							ajax.call(options);
						}
					})
				}
			}

			function updateDepositAcctInfo() {
				if(validate.check("depositAcctInfoForm")) {
					messager.confirm('<spring:message code="column.common.confirm.update" />', function(r){
						if(r){
							var data = $("#depositAcctInfoForm").serializeJson();
							 
							var options = {
								url : "<spring:url value='/system/depositAcctInfoUpdate.do' />"
								, data : data
								, callBack : function(result){
									messager.alert("<spring:message code='column.common.edit.final_msg' />", "Info", "info", function(){
										updateTab();	
									});
								}
							};

							ajax.call(options);
						}
					})
				}
			}

			function deleteDepositAcctInfo() {
				messager.confirm('<spring:message code="column.common.confirm.delete" />', function(r){
					if(r){
						var options = {
							url : "<spring:url value='/system/depositAcctInfoDelete.do' />"
							, data :  {
								acctInfoNo : '${depositAcctInfo.acctInfoNo}'
							}
							, callBack : function(result){
								closeGoTab('무통장 계좌 목록', '/system/depositAcctInfoListView.do');
							}
						};

						ajax.call(options);
					}
				})
			}
 
  
 
			
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
		</script>
	</t:putAttribute>
	<t:putAttribute name="content">
<form name="depositAcctInfoForm" id="depositAcctInfoForm" method="post">

			<table class="table_type1">
				<caption>무통장 계좌 등록</caption>
				<tbody>
					<tr>
						<th><spring:message code="column.acctInfoNo"/><strong class="red">*</strong></th>
						<td>
							<!-- 프로모션 번호-->
							<c:if test="${empty depositAcctInfo}">
							<b>자동입력</b>
							</c:if>
							<c:if test="${not empty depositAcctInfo}">
							<input type="text" class="numeric readonly" readonly="readonly" name="acctInfoNo" id="acctInfoNo" title="<spring:message code="column.prmt_no"/>" value="${depositAcctInfo.acctInfoNo}" />
							</c:if>
						</td>
						<th><spring:message code="column.st_id"/><strong class="red">*</strong></th>
						<td>
							<frame:stId funcNm="searchSt()" requireYn="Y" defaultStNm="${depositAcctInfo.stNm }" defaultStId="${depositAcctInfo.stId }"/>
						</td>
					</tr>
					<tr>
					    <th><spring:message code="column.bank_cd"/><strong class="red">*</strong></th>
						<td>
							<select name="bankCd" id="bankCd" title="<spring:message code="column.bank_cd"/>" >
								<frame:select grpCd="${adminConstants.BANK}" selectKey="${empty depositAcctInfo.bankCd ? '' :  depositAcctInfo.bankCd }" />
							</select>
						</td>
						<th><spring:message code="column.acct_no"/><strong class="red">*</strong></th>
						<td>
							<input type="text" class="w300 validate[required, maxSize[50]]"   name="acctNo" id="acctNo" title="<spring:message code="column.acct_no"/>" value="${depositAcctInfo.acctNo}" />
						</td>
					</tr>
					<tr>
						<th><spring:message code="column.ooa_nm"/><strong class="red">*</strong></th>
						<td>
							<input type="text" class="w300 validate[required, maxSize[100]]"   name="ooaNm" id="ooaNm" title="<spring:message code="column.ooa_nm"/>" value="${depositAcctInfo.ooaNm}" />
						</td>
						<th><spring:message code="column.disp_prior_rank"/><strong class="red">*</strong></th>
						<td>
							<input type="text" class="w300 validate[required, custom[onlyNum], maxSize[11]]"   name="dispPriorRank" id="dispPriorRank" title="<spring:message code="column.disp_prior_rank"/>" value="${depositAcctInfo.dispPriorRank}" />
						</td>
					</tr>
				</tbody>
			</table>

        </form>
		<div class="btn_area_center">
		<c:if test="${empty depositAcctInfo}">
			<button type="button" onclick="insertDepositAcctInfo();" class="btn btn-ok">등록</button>
			<button type="button" onclick="closeTab();" class="btn btn-cancel">취소</button>
		</c:if>
		<c:if test="${not empty depositAcctInfo}">
			<button type="button" onclick="updateDepositAcctInfo();" class="btn btn-ok">수정</button>
			<button type="button" onclick="deleteDepositAcctInfo();" class="btn btn-add">삭제</button>
			<button type="button" onclick="closeTab();" class="btn btn-cancel">닫기</button>
		</c:if>
			
		</div>
	</t:putAttribute>
</t:insertDefinition>
