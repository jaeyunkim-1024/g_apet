<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<script type="text/javascript">
	//미리보기
	function previewDate(dispClsfNo){
		let data = {
				dispClsfNo : dispClsfNo
				, previewDt : $("#previewDt").val()
		};

		let options = {
				url : "/display/homePreView.do"
			,	data : data
			,	type : "GET"
			,	callBack : function(result){
				
				let target = "homePreView";
				window.open("",target);
				let form = document.createElement("form");

				form.target = target;
				form.setAttribute("charset", "UTF-8")
				form.setAttribute("method", "GET")
				form.setAttribute("action", result.domain);
				document.body.appendChild(form);
				
				let input = document.createElement("input");
				
				if(result.lnbDispClsfNo != undefined) {
					input.setAttribute("type", "hidden");
					input.setAttribute("name", "lnbDispClsfNo");
					input.setAttribute("value", result.lnbDispClsfNo);	// 12564
					form.appendChild(input);
				}
				
				input = document.createElement("input");
				input.setAttribute("type", "hidden");
				input.setAttribute("name", "previewDt");
				input.setAttribute("value", result.previewDt);
				form.appendChild(input);
				
				document.body.appendChild(form);
				form.submit();
			}
		};
		ajax.call(options);
	}
</script>

<form name="previewForm" id="previewForm">
	<table class="table_type1">
		<caption>미리보기</caption>
		<tbody>
			<tr>
			<th scope="row"><spring:message code="column.common.review" /><strong class="red">*</strong></th>
				<td colspan="3">
					<!-- 미리보기 날짜--> 
					<frame:datepicker startDate="previewDt"
										  startValue="${frame:toDate('yyyy-MM-dd')}"
					/>
				</td>
			</tr>
		</tbody>
	</table>
</form>
 