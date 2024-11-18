<%--	
   - Class Name	: /sample/sampleAdbrixProdHtml.jsp
   - Description: Analytics 샘플 include 화면
   - Since		: 2021.02.25
   - Author		: KKB
   --%>

<tr class="itemTr" data-itemidx="${param.itemidx}">
	<th rowspan="12" class="rowspanArea">ITEM
		<button type="button" onclick="delItem(this);" class="btn">-</button>
		<button type="button" onclick="addItem(this);" class="btn">+</button>
	</th>
	
	<th>item_id</th>
	<td class="inputTd">
		<input name="item_id" type="text" placeholder="item_id">
	</td>
	<td>string, Required, Item ID (context-specific). *One of item_id or item_name is required for product or impression data.</td>
</tr>
<tr class="itemTr" data-itemidx="${param.itemidx}">
	<th>item_name</th>
	<td class="inputTd">
		<input name="item_name" type="text" placeholder="item_name">
	</td>
	<td>string, Required, Item Name (context-specific). *One of item_id or item_name is required for product or impression data.</td>
</tr>
<tr class="itemTr" data-itemidx="${param.itemidx}">
	<th>quantity</th>
	<td class="inputTd">
		<input name="quantity" type="text" placeholder="quantity">
	</td>
	<td>number, Not required, Item quantity.</td>
</tr>
<tr class="itemTr" data-itemidx="${param.itemidx}">
	<th>affiliation</th>
	<td class="inputTd">
		<input name="affiliation" type="text" placeholder="affiliation">
	</td>
	<td>string, Not required, A product affiliation to designate a supplying company or brick and mortar store location.</td>
</tr>
<tr class="itemTr" data-itemidx="${param.itemidx}">
	<th>coupon</th>
	<td class="inputTd">
		<input name="coupon" type="text" placeholder="coupon">
	</td>
	<td>string, Not required, The coupon code associated with an item.</td>
</tr>
<tr class="itemTr" data-itemidx="${param.itemidx}">
	<th>discount</th>
	<td class="inputTd">
		<input name="discount" type="text" placeholder="discount">
	</td>
	<td>number, Not required, Monetary value of discount associated with a item.</td>
</tr> 
<tr class="itemTr" data-itemidx="${param.itemidx}">
	<th>item_brand</th>
	<td class="inputTd">
		<input name="item_brand" type="text" placeholder="item_brand">
	</td>
	<td>string, Not required, Item brand.</td>
</tr>
<tr class="itemTr" data-itemidx="${param.itemidx}">
	<th>item_category</th>
	<td class="inputTd">
		<input name="item_category" type="text" placeholder="item_category">
	</td>
	<td>string, Not required, Item Category (context-specific). item_category2 through item_category5 can also be used if the item has many categories.</td>
</tr>
<tr class="itemTr" data-itemidx="${param.itemidx}">
	<th>item_variant</th>
	<td class="inputTd">
		<input name="item_variant" type="text" placeholder="item_variant">
	</td>
	<td>string, Not required, The variant of the item.</td>
</tr>
<tr class="itemTr tex" data-itemidx="${param.itemidx}">
	<th>tax</th>
	<td class="inputTd">
		<input name="tax" type="text" placeholder="tax">
	</td>
	<td>number, Not required, Tax cost associated with a transaction.</td>
</tr>
<tr class="itemTr" data-itemidx="${param.itemidx}">
	<th>price</th>
	<td class="inputTd">
		<input name="price" type="text" placeholder="price">
	</td>
	<td>number, Not required, The monetary price of the item, in units of the specified currency parameter.</td>
</tr>
<tr class="itemTr" data-itemidx="${param.itemidx}">
	<th>currency</th>
	<td class="inputTd">
		<input name="currency" type="text" placeholder="currency">
	</td>
	<td>string, Not required, The currency, in 3-letter ISO 4217 format.</td>
</tr> 



