<%--	
 - Class Name	: /sample/cdnPlusPurgeView.jsp
 - Description	: cdnPlusPurge View
 - Since			: 2021.1.8
 - Author			: VALFAC
--%>
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8"%>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">
		$(document).ready(function() {
		});

		function headerFormReset() {
			$("#cdnPlusPurgeForm")[0].reset();
		}

		function requestCdnPlusPurge(){
			messager.confirm('진행하시겠습니까?',function(r){
        		if(r){
					var options = {
							url : "<spring:url value='/sample/requestCdnPlusPurge.do' />",
							data : $("#cdnPlusPurgeForm").serialize(),
							callBack : function(data) {
								console.log('data',JSON.parse(data.result));
								messager.alert("<spring:message code='column.common.process.final_msg' />", "Info", "info", function(){
									//updateTab();
								});
							}
					}
					ajax.call(options);
        		}
			})
			
			
		}
		</script>
	</t:putAttribute>
	<t:putAttribute name="content">
		<div class="easyui-accordion search-accordion"
			data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect"
			style="width: 100%">
			<div title="CDN+ Purge" style="padding: 10px">
				<div class="box">
					<form id="cdnPlusPurgeForm" name="cdnPlusPurgeForm" method="post">
						<table class="table_type1">
							<tbody>
				                <tr>
				                	<th>
				                		전체 퍼지 여부<br>전체 파일의 퍼지 요청일 경우 '예'<br>특정 디렉토리 또는 파일의 퍼지 요청일 경우 '아니오'
				                	</th>
				                	<td>
				                		<select name="isWholePurge" id="isWholePurge" class="required" title="<spring:message code="column.vod_tp"/>">
											<frame:select grpCd="${adminConstants.COMM_YN}" selectKey="${adminConstants.COMM_YN_N}" />
										</select>
				                	</td>
				                	<th>
				                		대상 디렉토리명<br>해당 디렉토리 하위의 모든 파일 퍼지
				                	</th>
				                	<td>
				                		<input type="text" id="targetDirectoryName" name="targetDirectoryName" class="w500" maxlength="300" placeholder="/contents/sample" />
				                	</td>
				                </tr>
				                <tr>
				                	<th>
				                		대상 파일 리스트<br>특정 파일의 퍼지 요청<br>enter로 파일명(확장자포함) 구분
				                	</th>
				                	<td colspan="3">
				                		<textarea rows="3" cols="30" id="targetFileList" name="targetFileList" class=""></textarea>
				                	</td>
				                </tr>
							</tbody>
						</table>
					</form>
				</div>
			</div>
		</div>
		<div class="btn_area_center mb30">
			<button type="button" onclick="requestCdnPlusPurge();" class="btn btn-ok">Purge</button>
			<!-- <button type="button" onclick="registUnsubscribes('delete');" class="btn" style="background-color: #0066CC;">조회</button> -->
		</div>
    </div>
    
    
	</t:putAttribute>
</t:insertDefinition>