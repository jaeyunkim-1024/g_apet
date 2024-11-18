<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">
			$(function() {
				$("#execute").on("click", function() {
					if(!$("#tableName").val()) {
						alert("테이블명을 입력해주세요.");
						return;
					}
					if(!$("#fieldName").val()) {
						alert("필드명을 입력해주세요.");
						return;
					}
						
					var url = ($("#cryptoType:checked").val()=="encrypt") ? "${pageContext.request.contextPath}/interface/encryptForTable.do":"${pageContext.request.contextPath}/interface/decryptForTable.do";
					
					$.ajax({
						type:"POST",
						url: url,
						data : $("#frm").serialize(),
						dataType : "json",
						success: function(data){
							console.log(data);
							alert(data.result+"번의 쿼리가 실행되었습니다.");
						},
						error: function(xhr, status, error) {
							alert(error);
						}
					});
				});
			})
		</script>
	</t:putAttribute>
	<t:putAttribute name="content">
		<form id="frm" name="frm" method="post" >
			<table class="table_type1">
				<caption>개인정보처리방침 등록</caption>
				<tbody>
					<tr>
						<th scope="row">테이블명<strong class="red">*</strong></th>	<!-- 처리 방침 번호 -->
						<td>
							<input type="text" class="w300" id="tableName" name="tableName" title="" value="" />
						</td>
						<th scope="row">필드명<strong class="red">*</strong></th>	<!-- 버전 정보 -->
						<td>
							<input type="text" class="w300" id="fieldName" name="fieldName" title="" value="" />
						</td>
					</tr>
					<tr>
						<th scope="row">기능</th>	<!-- 사용 여부 -->
						<td colspan="3">
							<label class="fRadio"><input type="radio" name="cryptoType" id="cryptoType" value="encrypt" checked="checked"> <span id="span_cryptoTypeY">암호화</span></label> 
							<label class="fRadio"><input type="radio" name="cryptoType" id="cryptoType" value="decrypt"> <span id="span_cryptoTypeN">복호화</span></label>
						</td>
					</tr>
				</tbody>
			</table>
		</form>
		
		<div class="btn_area_center">
			<button type="button" class="btn btn-ok" id="execute" >실행</button>
		</div>

	</t:putAttribute>

</t:insertDefinition>