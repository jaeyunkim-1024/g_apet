<%--	
   - Class Name	: /sample/sampleAdbrixProdHtml.jsp
   - Description: adbrix 샘플 include 화면
   - Since		: 2021.02.18
   - Author		: KKB
   --%>

<tr class="prodTr" data-prdidx="${param.prdIdx}">
	<th rowspan="8" class="productTh">상품 정보
		<button type="button" onclick="delProd(this);" class="btn">-</button>
		<button type="button" onclick="addProd(this);" class="btn">+</button>
	</th>
	<th>*상품아이디</th>
	<td class="inputTd">
		<input name="productId" type="text" placeholder="*상품아이디">
	</td>
	<td></td>
</tr>
<tr class="prodTr" data-prdidx="${param.prdIdx}">
	<th>*상품명</th>
	<td class="inputTd">
		<input name="productName" type="text" placeholder="*상품명">
	</td>
	<td></td>
</tr>
<tr class="prodTr" data-prdidx="${param.prdIdx}">
	<th>*상품단가</th>
	<td class="inputTd">
		<input name="price" type="text" placeholder="*상품단가">
	</td>
	<td></td>
</tr>
<tr class="prodTr" data-prdidx="${param.prdIdx}">
	<th>*구매수량</th>
	<td class="inputTd">
		<input name="quantity" type="text" placeholder="*구매수량">
	</td>
	<td></td>
</tr>
<tr class="prodTr" data-prdidx="${param.prdIdx}">
	<th>*할인</th>
	<td class="inputTd">
		<input name="discount" type="text" placeholder="*할인">
	</td>
	<td></td>
</tr>
<tr class="prodTr" data-prdidx="${param.prdIdx}">
     <th>*currency</th>
     <td class="inputTd">
        <select name="currency">
			<option value="1">KRW</option>
			<option value="2">USD</option>
			<option value="3">JPY</option>
			<option value="4">EUR</option>
			<option value="5">GBP</option>
			<option value="6">CNY</option>
			<option value="7">TWD</option>
			<option value="8">HKD</option>
			<option value="9">IDR</option>
			<option value="10">INR</option>
			<option value="11">RUB</option>
			<option value="12">THB</option>
			<option value="13">VND</option>
			<option value="14">MYR</option>
		</select>
	</td>
	<td></td>
</tr>
<tr class="prodTr" data-prdidx="${param.prdIdx}">
	<th>상품 카테고리(A.B.C.D.E)</th>
	<td class="arrayArea inputTdA" >
	</td>
	<td></td>
</tr>
<tr class="prodTr" data-prdidx="${param.prdIdx}">
	<th>productDetailAttrs</th>
	<td class="mapArea inputTdB">
	</td>
	<td>이벤트 정보를 추가로 보내는 경우 사용</td>
</tr>
         