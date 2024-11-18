<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>

<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">
			$(document).ready(function(){
				initEditor();
				$("#stId").val("${goodsDescComm.stId}");
			});
			
			// editor 초기화
			function initEditor(){
				EditorCommon.setSEditor('contentPc', '${adminConstants.GOODS_DESC_COMM_IMAGE_PTH}');
				EditorCommon.setSEditor('contentMo', '${adminConstants.GOODS_DESC_COMM_IMAGE_PTH}');
			}	
			
			// 등록
			function validGoodsDescComm() {
				
				if(validate.check("goodsDescCommInsertForm")) {
					
					$("#strtDt").val(getDateStr ("descCommStrt"));
					$("#endDt").val(getDateStr ("descCommEnd"));
					
					// 에디터
					oEditors.getById["contentMo"].exec("UPDATE_CONTENTS_FIELD", []);
					oEditors.getById["contentPc"].exec("UPDATE_CONTENTS_FIELD", []);
					
					var contentPcNull = $('#contentPc').val().replace(/<img /gi, "img ").replace(/(<([^>]+)>)/gi, "").replace(/&nbsp;/gi, "").trim() == "";
					var contentMoNull = $('#contentMo').val().replace(/<img /gi, "img ").replace(/(<([^>]+)>)/gi, "").replace(/&nbsp;/gi, "").trim() == "";
					
					if( contentPcNull && contentMoNull ) {	// pc, 모바일 둘다 공백일 경우
						messager.alert("<spring:message code='admin.web.view.msg.goods.invalidate.goodsDescComm.content' />", "Info", "info");
						return;
					}else{
						if(contentPcNull){
							$("#contentPc").val('');
						}
						if(contentMoNull){
							$("#contentMo").val('');
						}
					}
					
					// 중복 조회
					checkDescCommReduplication(); 
				}
			}
			
			function insertgoodsDescComm(){
				
				var confirmMsg = $("[name='commGoodsDscrtNo']").val() == null ? "<spring:message code='column.common.confirm.insert' />" : "<spring:message code='column.common.confirm.update' />";
				var resultMsg = $("[name='commGoodsDscrtNo']").val() == null ? "<spring:message code='column.common.regist.final_msg' />" : "<spring:message code='column.common.edit.final_msg' />";
				var url = $("[name='commGoodsDscrtNo']").val() == null ? "<spring:url value='/goods/goodsDescCommInsert.do' />" : "<spring:url value='/goods/goodsDescCommUpdate.do' />";
				
				messager.confirm(confirmMsg, function(r){
					if(r){
						var options = {
							url : url
							, data : $("#goodsDescCommInsertForm").serialize()
							, callBack : function (data ) {
								messager.alert(resultMsg, "Info", "info", function(){
									updateTab("/goods/goodsDescCommDeatilView.do?commGoodsDscrtNo=" + data.goodsDescCommPO.commGoodsDscrtNo, "<spring:message code='column.goods.goodsDescComm.detail' />");
								});
							}
						};
						ajax.call(options);
						
					}
				});
			
			}
			
			// 중복 확인
			function checkDescCommReduplication(){
				var options = {
						url : "<spring:url value='/goods/goodsDescCommCheck.do' />"
						, data : $("#goodsDescCommInsertForm").serialize()
						, callBack : function (data ) {
							if( data.result > 0 ){
								messager.alert("<spring:message code='admin.web.view.msg.goods.invalidate.goodsDescComm.checkReplication' />", "Info", "info");
							}else{
								insertgoodsDescComm();
							}
						}
					};
					ajax.call(options);
			}
		</script>
	</t:putAttribute>
	<t:putAttribute name="content">
		<form id="goodsDescCommInsertForm" name="goodsDescCommInsertForm" method="post" >
			<c:if test="${not empty goodsDescComm}" >
				<input type="hidden" name="commGoodsDscrtNo" value="${goodsDescComm.commGoodsDscrtNo }" />
			</c:if>
			<input type="hidden" id="strtDt" name="strtDt" class="validate[required]" value="${goodsDescComm.strtDt }" />
			<input type="hidden" id="endDt" name="endDt" class="validate[required]" value="${goodsDescComm.endDt }" />
			<div class="mTitle">
				<h2>
					<c:if test="${empty goodsDescComm}" >
						<spring:message code="column.goods.goodsDescComm.insert"/>
					</c:if>
					<c:if test="${not empty goodsDescComm}" >
						<spring:message code="column.goods.goodsDescComm.detail"/>
					</c:if>
				</h2>
			</div>
			<table class="table_type1">
				<caption></caption>
				<colgroup>
					<col width="10%" />
					<col width="40%" />
					<col width="10%" />
					<col width="40%" />
				</colgroup>
				<tbody>
					<tr>
		                <th><spring:message code="column.st_id"/><strong class="red">*</strong></th>
						<td colspan="3">
							<spring:message code="column.site.select.placeholder" var="selectSitePh"/>
							<select id="stId" name="stId" class="validate[required]">
								<frame:stIdStSelect defaultName="${selectSitePh}"   />
							</select>
						</td>
					</tr>
					<tr>
		                <th><spring:message code="column.goods.showAreaGbCd"/><strong class="red">*</strong></th>
						<td>
							<frame:radio name="showAreaGbCd" grpCd="${adminConstants.SHOW_AREA_GB }" selectKey="${goodsDescComm.showAreaGbCd }" useYn="Y" required="true" />
						</td>
		                <th><spring:message code="column.use_yn"/><strong class="red">*</strong></th>
						<td>
							<frame:radio name="useYn" grpCd="${adminConstants.USE_YN }" selectKey="${goodsDescComm.useYn }" useYn="Y" required="true" />
						</td>
					</tr>
					<tr>
		                <th><spring:message code="column.goods.limitedDate"/><strong class="red">*</strong></th>
						<td colspan="3">
							<frame:datepicker startDate="descCommStrtDt"
 											  startHour="descCommStrtHr" 
 											  startMin="descCommStrtMn" 
 											  startSec="descCommStrtSec"
 											  startValue="${goodsDescComm.strtDt }" 
 											  endDate="descCommEndDt" 
 											  endHour="descCommEndHr" 
 											  endMin="descCommEndMn" 
 											  endSec="descCommEndSec" 
 											  endValue="${goodsDescComm.endDt }" /> 
						</td>
					</tr>
					<tr>
						<th><spring:message code="column.goods.goodsDescComm.contentPc" /></th>
						<td colspan="3">
							<textarea name="contentPc" id="contentPc" class="validate[required]" cols="30" rows="10" style="width: 100%">${goodsDescComm.contentPc}</textarea>
						</td>
					</tr>					
					<tr>
						<th><spring:message code="column.goods.goodsDescComm.contentMo" /></th>
						<td colspan="3">
							<textarea name="contentMo" id="contentMo" class="validate[required]" cols="30" rows="10" style="width: 100%">${goodsDescComm.contentMo}</textarea>
						</td>
					</tr>					
				</tbody>
			</table>
		</form>
		
		<div class="btn_area_center">
			<c:if test="${empty goodsDescComm}" >
				<button type="button" class="btn btn-ok" onclick="validGoodsDescComm();" ><spring:message code="admin.web.view.common.button.insert"/></button>
			</c:if>
			<c:if test="${not empty goodsDescComm}" >
				<button type="button" class="btn btn-ok" onclick="validGoodsDescComm();" ><spring:message code="admin.web.view.common.button.update"/></button>
			</c:if>
			<button type="button" class="btn btn-cancel" onclick="closeTab();"><spring:message code="admin.web.view.common.button.cancel"/></button>
		</div>

	</t:putAttribute>

</t:insertDefinition>