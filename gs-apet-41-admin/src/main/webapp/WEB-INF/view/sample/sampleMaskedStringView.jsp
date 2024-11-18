<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script>
			function mask(obj) {
				var thisType = $(obj).prev().prop("name");
				var thisStr = $(obj).prev().val();
				var thisIdx = $(obj).siblings("select[name=idx]").val();
				let options = {
						url : "<spring:url value='/sample/getMaskedString.do' />"
						, data : {
							type : thisType,
							str : thisStr,
							idx : thisIdx
							}
						, callBack : function(result){
							$(obj).parents("tr").find("td:last").text(result);
						}
					};
					ajax.call(options);				
			};
		</script>
	</t:putAttribute>
	<t:putAttribute name="content">
		<table class="table_type1">
			<colgroup>
				<col width="100px"/>
				<col />
				<col />
			</colgroup>
			<tbody>
				<tr>
					<th>구분</th>
					<th>입력</th>
					<th>결과</th> 
				</tr>
				<tr>
					<th>이름</th>
					<td><input type="text" name="name" class="w450" value="" title="이름" /><button type="button" class="btn" onclick="mask(this);" >마스킹</button></td>
					<td></td> 
				</tr>
				<tr>
					<th>전화번호</th>
					<td><input type="text" name="tel" class="w450" value="" title="전화번호" /><button type="button" class="btn" onclick="mask(this);" >마스킹</button></td>
					<td></td> 
				</tr>
				<tr>
					<th>주소</th>
					<td><input type="text" name="address" class="w450" value="" title="주소" /><button type="button" class="btn" onclick="mask(this);" >마스킹</button></td>
					<td></td> 
				</tr>
				<tr>
					<th>이메일</th>
					<td><input type="text" name="email" class="w450" value="" title="이메일" /><button type="button" class="btn" onclick="mask(this);" >마스킹</button></td>
					<td></td> 
				</tr>
				<tr>
					<th>주민번호</th>
					<td><select name="idx">
							<option value="0" >노출 자리</option>
							<option value="2" >2</option>
							<option value="4" >4</option>
							<option value="6" >6</option>
							<option value="7" >7</option>
						</select>
						<input type="text" name="resNo" class="w450" value="" title="주민번호" />
						<button type="button" class="btn" onclick="mask(this);" >마스킹</button></td>
					<td></td> 
				</tr>
				<tr>
					<th>생년월일</th>
					<td><input type="text" name="birth" class="w450" value="" title="생년월일" /><button type="button" class="btn" onclick="mask(this);" >마스킹</button></td>
					<td></td> 
				</tr>
				<tr>
					<th>운전면허번호</th>
					<td><input type="text" name="drsLcnsNo" class="w450" value="" title="운전면허번호" /><button type="button" class="btn" onclick="mask(this);" >마스킹</button></td>
					<td></td> 
				</tr>
				<tr>
					<th>여권번호</th>
					<td><input type="text" name="psprtNo" class="w450" value="" title="여권번호" /><button type="button" class="btn" onclick="mask(this);" >마스킹</button></td>
					<td></td> 
				</tr>
				<tr>
					<th>카드(현금영수증, 신용,기타)</th>
					<td><input type="text" name="card" class="w450" value="" title="신용카드" /><button type="button" class="btn" onclick="mask(this);" >마스킹</button></td>
					<td></td> 
				</tr>
				<tr>
					<th>사업자 등록번호</th>
					<td><input type="text" name="bizNo" class="w450" value="" title="사업자 등록번호" /><button type="button" class="btn" onclick="mask(this);" >마스킹</button></td>
					<td></td> 
				</tr>
				<tr>
					<th>계좌번호</th>
					<td><input type="text" name="bankNo" class="w450" value="" title="계좌번호" /><button type="button" class="btn" onclick="mask(this);" >마스킹</button></td>
					<td></td> 
				</tr>
				<tr>
					<th>QR코드</th>
					<td><input type="text" name="qrCode" class="w450" value="" title="QR코드" /><button type="button" class="btn" onclick="mask(this);" >마스킹</button></td>
					<td></td> 
				</tr>
				<tr>
					<th>IP</th>
					<td><input type="text" name="ip" class="w450" value="" title="IP" /><button type="button" class="btn" onclick="mask(this);" >마스킹</button></td>
					<td></td> 
				</tr>
				<tr>
					<th>ID</th>
					<td><input type="text" name="id" class="w450" value="" title="ID" /><button type="button" class="btn" onclick="mask(this);" >마스킹</button></td>
					<td></td> 
				</tr>
			</tbody>
		</table>
	</t:putAttribute>
</t:insertDefinition>