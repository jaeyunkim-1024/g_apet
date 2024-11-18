<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">
			$(document).ready(function(){
			});
			
			function fnCheckBankAccount(){
				if(validate.check("checkBankAccountForm")) {
					var options = {
						url : "<spring:url value='/sample/reqCheckBankAccount.do' />"
						, data : $("#checkBankAccountForm").serializeJson()
						, callBack : function(result){
							console.log('result', result);
							$("#checkBankAccountRes").val(result.res.responseBody);
						}
					};
					ajax.call(options);
				}
			}
			
			function fnGetVirtualAccount(){
				if(validate.check("virtualAccountForm")) {
					var options = {
						url : "<spring:url value='/sample/reqGetVirtualAccount.do' />"
						, data : $("#virtualAccountForm").serializeJson()
						, callBack : function(result){
							console.log('result', result);
							$("#virtualAccountRes").val(result.res.responseBody);
						}
					};
					ajax.call(options);
				}
			}
			
			
		</script>
	</t:putAttribute>
	<t:putAttribute name="content">
		<form id="checkBankAccountForm">
		<div class="easyui-accordion search-accordion" data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect" style="width:100%">
			<div title="예금주 성명 조회" style="padding:10px">
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
									<th><strong class="red">*</strong>은행 코드</th>
									<td>
										<select name="BankCode" class="validate[required]" >
											<frame:select grpCd="${adminConstants.BANK }"/>
										</select>
									</td>
									<th><strong class="red">*</strong>계좌 번호</th>
									<td>
										<input type="text" name="AccountNo" class="validate[required]"/>
									</td>
								</tr>
								<tr>
								</tr>
							</table>
						</td>
						<td>
							<div style="vertical-align: top; height: 100%;">
								<button type="button" onclick="fnCheckBankAccount()" class="btn btn-ok" style="margin-bottom:1px;margin-right:10px">호출</button>
								<br>
								<textarea id="checkBankAccountRes" style="width: 500px;"></textarea>
							</div>
						</td>
					</tr>
					
				</table>
			</div>
		</div>
		</form>
		<br/>
		<form id="virtualAccountForm">
		<div class="easyui-accordion search-accordion" data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect" style="width:100%">
			<div title="가상계좌 발급 요청" style="padding:10px">
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
									<th><strong class="red">*</strong> 결제금액</th>
									<td>
										<input type="text" name="Amt" class="validate[required]"/>
									</td>
								</tr>
								<tr>
									<th><strong class="red">*</strong> 상품 명</th>
									<td>
										<input type="text" name="GoodsName" class="validate[required]" />
									</td>
									<th><strong class="red">*</strong>증빙구분(1: 소득공제, 2: 지출증빙)</th>
									<td>
										<input type="text" name="CashReceiptType" class="validate[required]"/>
									</td>
								</tr>
								<tr>
									<th><strong class="red">*</strong> 현금영수증 발급번호 - 증빙구분 1 인 경우 휴대폰번호, 2 인 경우 사업자번호</th>
									<td>
										<input type="text" name="ReceiptTypeNo" class="validate[required]" />
									</td>
									<th><strong class="red">*</strong>은행코드</th>
									<td>
										<select name="BankCode" class="validate[required]" >
											<frame:select grpCd="${adminConstants.BANK }"/>
										</select>
									</td>
								</tr>
								<tr>
									<th><strong class="red">*</strong>가상계좌 입금 만료일 8자리 또는 12자리(YYYYMMDD 또는 YYYYMMDDHHMI)
	 									* 지정하지 않을 경우, 계약된 기본 입금 기한일로 자동 처리됨.</th>
									<td>
										<input type="text" name="VbankExpDate" class="validate[required]" />
									</td>
									<th>0: 일반거래(Default), 1: 에스크로거래</th>
									<td>
										<input type="text" name="TransType" />
									</td>
								</tr>
								<tr>
									<th>
										휴대폰번호 또는 사업자번호(‘-‘ 없이 숫자만 입력)
	 									<br/>TransType이 1(에스크로거래)인 경우 필수</th>
									<td>
										<input type="text" name="BuyerAuthNum" />
									</td>
									<th>구매자 이름</th>
									<td>
										<input type="text" name="BuyerName" />
									</td>
								</tr>
								<tr>
									<th>구매자 이메일주소</th>
									<td>
										<input type="text" name="BuyerEmail" />
									</td>
									<th>구매자 전화번호, ‘-‘ 없이 숫자만 입력</th>
									<td>
										<input type="text" name="BuyerTel" />
									</td>
								</tr>
								<tr>
									<th>별도 공급가액 설정 시 사용</th>
									<td>
										<input type="text" name="SupplyAmt"/>
									</td>
									<th>별도 부가세 설정 시 사용</th>
									<td>
										<input type="text" name="GoodsVat"/>
									</td>
								</tr>
								<tr>
									<th>봉사료</th>
									<td>
										<input type="text" name="ServiceAmt"/>
									</td>
									<th>면세금액</th>
									<td>
										<input type="text" name="TaxFreeAmt"/>
									</td>
								</tr>
							</table>
						</td>
						<td>
							<div style="vertical-align: top; height: 100%;">
								<button type="button" onclick="fnGetVirtualAccount()" class="btn btn-ok" style="margin-bottom:1px;margin-right:10px">호출</button>
								<br>
								<textarea id="virtualAccountRes" style="width: 500px;height: 300px;"></textarea>
							</div>
						</td>
					</tr>
					
				</table>
			</div>
		</div>
		</form>
	</t:putAttribute>
</t:insertDefinition>