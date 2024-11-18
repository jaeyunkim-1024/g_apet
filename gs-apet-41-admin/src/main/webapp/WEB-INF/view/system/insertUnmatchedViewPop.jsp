<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<script type="text/javascript">

	//금지어 등록
	function insertUnmatched(){
		if($("#unmatchedForm #tagNm").val() == '') {
			messager.alert("금지어를 입력해 주세요.", "info", "info", function(r){
				$("#unmatchedForm #tagNm").focus();
			});
			return;
		} else if($("#unmatchedForm #tagNm").val() == "#") {
			messager.alert("금지어를 입력해 주세요.", "info", "info", function(r){
				$("#unmatchedForm #tagNm").focus();
			});
			return;
		} else {
			var data = $("#forbiddenWordList").jqGrid("getRowData");
			for(var i = 0; i < data.length; i++) {
				if($("#unmatchedForm #tagNm").val().indexOf('#') > -1) {
					var unmatchedVal = $("#unmatchedForm #tagNm").val().split('#');
					$("#unmatchedForm #tagNm").val(unmatchedVal[1]);
					
					if(data[i].tagNm == $("#unmatchedForm #tagNm").val()) {
						messager.alert("중복된 금지어 입니다.", "info", "info");
							$("#unmatchedForm #tagNm").val("#");
							$("#unmatchedForm #tagNm").focus();
						return;
					}
				} else {
					if(data[i].tagNm == $("#unmatchedForm #tagNm").val()) {
						messager.alert("중복된 금지어 입니다.", "info", "info");
							$("#unmatchedForm #tagNm").val("#");
							$("#unmatchedForm #tagNm").focus();
						return;
					}
				}
			}
			
			var tagNm = $("#unmatchedForm #tagNm").val();
			var options = {
					url : "<spring:url value='/system/insertUnmatched.do' />"
					, data : {
						tagNm : tagNm
					}
					, callBack : function(result) {
						layer.close('insertUnmatchedView');
						reloadUnmatchedGrid('del');
					}
			};
			ajax.call(options);
		}
	}
</script>

<form name="unmatchedForm" id="unmatchedForm">
	<table class="table_type1">
		<caption>금지어 등록</caption>
		<tbody>
			<tr>
			<th scope="row"><spring:message code="column.tag_nm_unmatched" /><strong class="red">*</strong></th>
				<td colspan="3">
					<!-- 금지어 --> 
					<input type="text" name="tagNm" id="tagNm" value="#" />
				</td>
			</tr>
		</tbody>
	</table>
</form>
 