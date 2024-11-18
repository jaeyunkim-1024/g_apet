<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">
			$(document).ready(function(){
			});
			
			//승인 요청 공급가액, VAT 계산
			$(document).on("change", "#cashReceiptForm input[name=ReceiptAmt]", function(){
				var supplyAmt = Math.round($(this).val() / 1.1);
				var vatAmt = $(this).val() - supplyAmt;
				$("#cashReceiptForm input[name=ReceiptSupplyAmt]").val(supplyAmt);
				$("#cashReceiptForm input[name=ReceiptVAT]").val(vatAmt);
			});
			
			//취소 요청 공급가액, VAT 계산
			$(document).on("change", "#cancelProcessForm input[name=CancelAmt]", function(){
				var supplyAmt = Math.round($(this).val() / 1.1);
				var vatAmt = $(this).val() - supplyAmt;
				$("#cancelProcessForm input[name=SupplyAmt]").val(supplyAmt);
				$("#cancelProcessForm input[name=GoodsVat]").val(vatAmt);
			});
			
			function fnCashReceipt(){
				if(validate.check("cashReceiptForm")) {
					var options = {
						url : "<spring:url value='/sample/reqCashReceipt.do' />"
						, data : $("#cashReceiptForm").serializeJson()
						, callBack : function(result){
							console.log('result', result)
							$("#cashReceiptRes").val(result.res.responseBody);
						}
					};
					ajax.call(options);
				}
			}
			
			function fnCancelProcess(){
				if(validate.check("cancelProcessForm")) {
					var options = {
						url : "<spring:url value='/sample/reqCancelProcess.do' />"
						, data : $("#cancelProcessForm").serializeJson()
						, callBack : function(result){
							console.log('result', result);
							$("#cancelProcessRes").val(result.res.responseBody);
						}
					};
					ajax.call(options);
				}
			}
		</script>
	</t:putAttribute>
	<t:putAttribute name="content">
		<form id="cashReceiptForm">
		<div class="easyui-accordion search-accordion" data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect" style="width:100%">
			<div title="현금영수증 승인 요청" style="padding:10px">
				<table class="table_type1">
					<colgroup>
						<col width="60%;"/>
						<col/>
					</colgroup>
					<tr>
						<td>
							<table class="table_type1">
								<colgroup>
									<col/>
									<col/>
									<col/>
									<col/>
								</colgroup>
								<tr>
									<th><strong class="red">*</strong> 상점에서 부여한 주문번호(Unique하게 구성)</th>
									<td>
										<input type="text" name="Moid" class="validate[required]" />
									</td>
									<th><strong class="red">*</strong> 상품명</th>
									<td>
										<input type="text" name="GoodsName" class="validate[required]"/>
									</td>
								</tr>
								<tr>
								</tr>
								<tr>
									<th><strong class="red">*</strong> 증빙구분(1: 소득공제, 2: 지출증빙)</th>
									<td>
										<input type="text" name="ReceiptType" class="validate[required]"/>
									</td>
									<th><strong class="red">*</strong> 증빙구분 1 인 경우 휴대폰번호, 2 인 경우 사업자번호</th>
									<td>
										<input type="text" name="ReceiptTypeNo" class="validate[required]"/>
									</td>
								</tr>
								<tr>
									<th><strong class="red">*</strong> 현금영수증 요청 금액</th>
									<td>
										<input type="text" name="ReceiptAmt" class="validate[required]"/>
									</td>
									<th><strong class="red">*</strong> 공급가액</th>
									<td>
										<input type="text" name="ReceiptSupplyAmt" class="readonly validate[required]" readonly="readonly"/>
									</td>
								</tr>
								<tr>
									<th><strong class="red">*</strong> 부가세</th>
									<td>
										<input type="text" name="ReceiptVAT" class="readonly validate[required]" readonly="readonly"/>
									</td>
									<th><strong class="red">*</strong> 봉사료</th>
									<td>
										<input type="text" name="ReceiptServiceAmt" class="readonly validate[required]" readonly="readonly" value="0"/>
									</td>
								</tr>
								<tr>
									<th><strong class="red">*</strong> 면세금액</th>
									<td>
										<input type="text" class="readonly validate[required]" name="ReceiptTaxFreeAmt" readonly="readonly" value="0"/>
									</td>
									<th>구매자 이름</th>
									<td>
										<input type="text" name="BuyerName"/>
									</td>
								</tr>
								<tr>
									<th>구매자 이메일주소</th>
									<td>
										<input type="text" name="BuyerEmail"/>
									</td>
									<th>구매자 전화번호(-' 없이 숫자만 입력)</th>
									<td>
										<input type="text" name="BuyerTel"/>
									</td>
								</tr>
								<tr>
									<th>서브몰사업자번호</th>
									<td>
										<input type="text" name="ReceiptSubNum"/>
									</td>
									<th>서브몰사업자상호</th>
									<td>
										<input type="text" name="ReceiptSubCoNm"/>
									</td>
								</tr>
								<tr>
									<th>서브몰사업자대표자 명</th>
									<td>
										<input type="text" name="ReceiptSubBossNm"/>
									</td>
									<th>서브몰사업자전화번호</th>
									<td>
										<input type="text" name="ReceiptSubTel"/>
									</td>
								</tr>
								<tr>
									<th>응답파라메터 인코딩 방식(예시) utf-8 / euc-kr(Default)</th>
									<td>
										<input type="text" name="CharSet"/>
									</td>
									<th>응답전문 유형 (default(미설정): JSON / KV(설정): Key=Value형식 응답)</th>
									<td>
										<input type="text" name="EdiType"/>
									</td>
								</tr>
							</table>
						</td>
						<td>
							<div style="vertical-align: top; height: 100%;">
								<button type="button" onclick="fnCashReceipt()" class="btn btn-ok" style="margin-bottom:1px;margin-right:10px">호출</button>
								<a href="https://npg.nicepay.co.kr/trans/cashReceiptIssueList.do" target="_blank;">호출 확인</a>
								<br>
								<textarea id="cashReceiptRes" style="width: 500px;height: 80%;"></textarea>
							</div>
						</td>
					</tr>
					
				</table>
			</div>
		</div>
		</form>
		<br/>
		<form id="cancelProcessForm">
			<input type="hidden" name="midGb" value="S">
			<input type="hidden" name="payMeans" value="04">
			<input type="hidden" name="mdaGb" value="01">
		<div class="easyui-accordion search-accordion" data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect" style="width:100%">
			<div title="현금영수증 승인 취소" style="padding:10px">
				<table class="table_type1">
					<colgroup>
						<col width="60%;"/>
						<col/>
					</colgroup>
					<tr>
						<td>
							<table class="table_type1">
								<colgroup>
									<col/>
									<col/>
									<col/>
									<col/>
								</colgroup>
								<tr>
									<th><strong class="red">*</strong> TID(현금영수증 승인 요청 Response TID)</th>
									<td>
										<input type="text" name="TID" class="validate[required]" />
									</td>
									<th><strong class="red">*</strong> 상점에서 부여한 주문번호(Unique하게 구성)</th>
									<td>
										<input type="text" name="Moid" class="validate[required]" />
									</td>
								</tr>
								<tr>
								</tr>
								<tr>
									<th><strong class="red">*</strong> 부분취소 여부(전체취소 : 0 / 부분취소 : 1)</th>
									<td colspan="3">
										<input type="text" name="PartialCancelCode" class="validate[required]"/>
									</td>
								</tr>
								<tr>
									<th><strong class="red">*</strong> 취소 금액</th>
									<td>
										<input type="text" name="CancelAmt" class="validate[required]"/>
									</td>
									<th><strong class="red">*</strong> 공급가액</th>
									<td>
										<input type="text" name="SupplyAmt" class="readonly validate[required]" readonly="readonly"/>
									</td>
								</tr>
								<tr>
									<th><strong class="red">*</strong> 부가세</th>
									<td>
										<input type="text" name="GoodsVat" class="readonly validate[required]" readonly="readonly"/>
									</td>
									<th><strong class="red">*</strong> 봉사료</th>
									<td>
										<input type="text" name="ServiceAmt" class="readonly validate[required]" readonly="readonly" value="0"/>
									</td>
								</tr>
								<tr>
									<th><strong class="red">*</strong> 면세금액</th>
									<td>
										<input type="text" class="readonly validate[required]" name="TaxFreeAmt" readonly="readonly" value="0"/>
									</td>
									<th><strong class="red">*</strong> 취소 사유</th>
									<td>
										<input type="text" class="validate[required]" name="CancelMsg"/>
									</td>
								</tr>
								<tr>
									<th>장바구니 결제 유형 (장바구니 결제: 1 / 그 외:0 )</th>
									<td colspan="3">
										<input type="text" name="CartType"/>
									</td>
								</tr>
								<tr>
									<th>응답파라메터 인코딩 방식(예시) utf-8 / euc-kr(Default)</th>
									<td>
										<input type="text" name="CharSet"/>
									</td>
									<th>응답전문 유형 (default(미설정): JSON / KV(설정): Key=Value형식 응답)</th>
									<td>
										<input type="text" name="EdiType"/>
									</td>
								</tr>
							</table>
						</td>
						<td>
							<div style="vertical-align: top; height: 100%;">
								<button type="button" onclick="fnCancelProcess()" class="btn btn-ok" style="margin-bottom:1px;margin-right:10px">호출</button>
								<a href="https://npg.nicepay.co.kr/trans/cashReceiptIssueList.do" target="_blank;">호출 확인</a>
								<br>
								<textarea id="cancelProcessRes" style="width: 500px;height: 80%;"></textarea>
							</div>
						</td>
					</tr>
					
				</table>
			</div>
		</div>
		</form>
	</t:putAttribute>
</t:insertDefinition>