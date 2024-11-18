<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
		<script type="text/javascript">
		$(document).ready(function() {
			initEditor();
		});

		$(document).on('stPolicyViewInit', function(e, param1) {
			
		});
		
		function stPolicySave() {
			if(validate.check("stPolicyForm")) {
				var message = '<spring:message code="column.common.confirm.update" />';

				if(validation.isNull($("#stPlcNo").val())){
					message = '<spring:message code="column.common.confirm.insert" />';
				}
				
				oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
				// 내용 체크
				if( !editorRequired( 'content' ) ){ return false };
				
				messager.confirm(message, function(r){
					if(r){
						var options = {
							url : "<spring:url value='/st/stPolicySave.do' />"
							, data : $("#stPolicyForm").serialize()
							, callBack : function(result){
								reloadStPolicyListGrid();
								layer.close('stPolicyViewPop');
							}
						};

						ajax.call(options);
					}
				})
			}
		}
		function initEditor () {
			EditorCommon.setSEditor('content', '${adminConstants.ST_POLICY_IMAGE_PTH}');
		}
	 
		</script>

		<form name="stPolicyForm" id="stPolicyForm" method="post">
		<table class="table_type1">
			<caption>사이트 정책 정보</caption>
			<colgroup>
				<col class="th-s" />
				<col />
				<col class="th-s" />
				<col />
			</colgroup>
			<tbody>
				<tr>
					<th><spring:message code="column.st_plc_gb_cd"/><strong class="red">*</strong></th>
					<td colspan='3'>
						<!-- 사이트 번호-->
						<input type="hidden" name="stId" id="stId" title="<spring:message code="column.st_id"/>" value="${empty stPolicy.stId ? stPolicyResult.stId : stPolicy.stId}" />
						<!-- 사이트 정책 번호-->
						<input type="hidden" name="stPlcNo" id="stPlcNo" title="<spring:message code="column.st_plc_no"/>" value="${stPolicy.stPlcNo }" />
						
						<select id="stPlcGbCd" name="stPlcGbCd">
							<frame:select grpCd="${adminConstants.COMP_PLC_GB}"  selectKey="${stPolicy.stPlcGbCd }"/>
						</select>
					</td>
				</tr>
				<tr>
					<th><spring:message code="column.sort_seq" /><strong class="red">*</strong></th>
					<td><!-- 정렬 순서-->
						<input type="text" class="numeric validate[required,custom[number],max[100]]" name="sortSeq" id="sortSeq" title="<spring:message code="column.sort_seq" />" value="${stPolicy.sortSeq }" />
					</td>
					<th><spring:message code="column.disp_yn" /></th>	 
					<td><!-- 전시 여부-->
						<frame:radio name="dispYn" grpCd="${adminConstants.COMM_YN }" selectKey="${stPolicy.dispYn }"/>
					</td>
				</tr>
				<tr>
					<th><spring:message code="column.contents" /><strong class="red">*</strong></th>
					<td colspan='3'><!-- 내용-->
						<textarea name="content" id="content" style="width:100%; height:280px;">${stPolicy.content }</textarea>
					</td>
					 
				</tr>
				 
				 
			</tbody>
		</table>
		</form>

