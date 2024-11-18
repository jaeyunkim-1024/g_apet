<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">
			$(document).ready(function(){
			});
			
			function fnReqISR3K00101(){
				if(validate.check("ISR3K00101Form")) {
					var options = {
						url : "<spring:url value='/samplesktmp/apiHubISR3K00101.do' />"
						, data : $("#ISR3K00101Form").serializeJson()
						, callBack : function(result){
							console.log('result', result);
							$("#ISR3K00101Res").val(JSON.stringify(result));
						}
					};
					ajax.call(options);
				}
			}
			
			function fnReqISR3K00102(){
				if(validate.check("ISR3K00102Form")) {
					var options = {
						url : "<spring:url value='/samplesktmp/apiHubISR3K00102.do' />"
						, data : $("#ISR3K00102Form").serializeJson()
						, callBack : function(result){
							console.log('result', result);
							$("#ISR3K00102Res").val(JSON.stringify(result));
						}
					};
					ajax.call(options);
				}
			}
			
			function fnReqISR3K00105(){
				if(validate.check("ISR3K00105Form")) {
					var options = {
						url : "<spring:url value='/samplesktmp/apiHubISR3K00105.do' />"
						, data : $("#ISR3K00105Form").serializeJson()
						, callBack : function(result){
							$("#ISR3K00105Res").val(JSON.stringify(result));
						}
					};
					ajax.call(options);
				}
			}
			
			function fnReqISR3K00106(){
				if(validate.check("ISR3K00106Form")) {
					var options = {
						url : "<spring:url value='/samplesktmp/apiHubISR3K00106.do' />"
						, data : $("#ISR3K00106Form").serializeJson()
						, callBack : function(result){
							console.log('result', result);
							$("#ISR3K00106Res").val(JSON.stringify(result));
						}
					};
					ajax.call(options);
				}
			}
			
			function fnReqISR3K00107(){
				if(validate.check("ISR3K00107Form")) {
					var options = {
						url : "<spring:url value='/samplesktmp/apiHubISR3K00107.do' />"
						, data : $("#ISR3K00107Form").serializeJson()
						, callBack : function(result){
							console.log('result', result);
							$("#ISR3K00107Res").val(JSON.stringify(result));
						}
					};
					ajax.call(options);
				}
			}
			
			function fnReqISR3K00108(){
				if(validate.check("ISR3K00108Form")) {
					var options = {
						url : "<spring:url value='/samplesktmp/apiHubISR3K00108.do' />"
						, data : $("#ISR3K00108Form").serializeJson()
						, callBack : function(result){
							console.log('result', result);
							$("#ISR3K00108Res").val(JSON.stringify(result));
						}
					};
					ajax.call(options);
				}
			}
			
			function fnReqISR3K00109(){
				if(validate.check("ISR3K00109Form")) {
					var options = {
						url : "<spring:url value='/samplesktmp/apiHubISR3K00109.do' />"
						, data : $("#ISR3K00109Form").serializeJson()
						, callBack : function(result){
							console.log('result', result);
							$("#ISR3K00109Res").val(JSON.stringify(result));
						}
					};
					ajax.call(options);
				}
			}
			
			function fnReqISR3K00110(){
				if(validate.check("ISR3K00110Form")) {
					var options = {
						url : "<spring:url value='/samplesktmp/apiHubISR3K00110.do' />"
						, data : $("#ISR3K00110Form").serializeJson()
						, callBack : function(result){
							console.log('result', result);
							$("#ISR3K00110Res").val(JSON.stringify(result));
						}
					};
					ajax.call(options);
				}
			}
			
			function fnReqISR3K00114(){
				if(validate.check("ISR3K00114Form")) {
					var options = {
						url : "<spring:url value='/samplesktmp/apiHubISR3K00114.do' />"
						, data : $("#ISR3K00114Form").serializeJson()
						, callBack : function(result){
							console.log('result', result);
							$("#ISR3K00114Res").val(JSON.stringify(result));
						}
					};
					ajax.call(options);
				}
			}
			
			function fnReqCancel(){
				if(validate.check("cancelForm")) {
					var options = {
						url : "<spring:url value='/samplesktmp/cancelMpPoint.do' />"
						, data : $("#cancelForm").serializeJson()
						, callBack : function(result){
							console.log('result', result);
							$("#cancelFormRes").val(JSON.stringify(result));
						}
					};
					ajax.call(options);
				}
			}
		</script>
	</t:putAttribute>
	<t:putAttribute name="content">
		<div class="easyui-accordion search-accordion" data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect" style="width:100%">
			<div title="공통" style="padding:10px">
				<div class="box">
					<div>
						<ul style="font-size: 13px;">
							제휴사코드 : V798 <br/>	
							가맹점코드 : 1001 <br/>	
							
							<table class="table_type1" style="width: 1000px;">
								<colgroup>
									<col style="width:25%;"/>
									<col/>
								</colgroup>
								<tbody>
									<tr>
										<th>멤카번호</th>
										<th>CI</th>
									</tr>
									<tr>
										<td>2490276205902510</td>
										<td>/G5KfgRKyGq1oS0NW8tyS2Mf22hD1BfNJc4CbkTweSnsuxhzQE6iXdyLOfpTeeSdnAttNGDreVQfZZpumm3WIw==</td>
									</tr>
									<tr>
										<td>2144217356372022</td>
										<td>AXmK/UL/BngtC1A0b/7Svm9yco6Htm/SHUpowb5GbWj8BsWRBVeXBDdXmvfScXFCmclDbygi+HLYNI8z2sNSnQ==</td>
									</tr>
									<tr>
										<td>2149889701902427</td>
										<td>tarLwskRDJdqc1GbGro2sijMb+JX/hgLiMTGdBIqusfmRa6kgCZx1Nhj8xtyrh7CsWiIXe6nyqunqLEAOhczrQ==</td>
									</tr>
									<tr>
										<td>2831651763312513</td>
										<td>VNFB8ynQf5F7SWSozE+dIdaqv2giS1WnzRnBatjZQDz/0DmavevwOQP8F3ycy4spuJIn1lRp544xa07VAQ6N+w==</td>
									</tr>
									<tr>
										<td>2165555560882518</td>
										<td>vTwNid8tu3Gi0hfGfKkoR5uB8F7wJQLJ4c21ICaGN1fh6vwyYRINaqpnv2ugAp+zFSSq6MhCwChdipH7wOcO1g==</td>
									</tr>
									<tr>
										<td style="color:red;">[사용불능]<br/>2100387321800449</td>
										<td style="color:red;">fZpb4K+cwKQZP1cmIVFuGvU78uTYg4k7UHUjNfqufEaCG0Lg0txQEOQEjbGiE5y4UhlO/pVrF35MSFZokTu4Tg==</td>
									</tr>
									<tr>
										<td>2833418737632014</td>
										<td>CEvHDQZlqhGuwlxCsvSU357D+YU9BZZc3JCFG4AO40aiKbc/Hh2XumcTu3gK4zZTbEiZ6nIxmE2OivBqB6z/cg==</td>
									</tr>
									<tr>
										<td>2462999655632775</td>
										<td>mx1j5fAGIhA+Z+wGbAtN8srs2hyKlFgPQh2tS2hOPycYtqv2LjlR7Yz+U0fG8u9uEt59flZtV5cW0c9V0zZ6yA==</td>
									</tr>
									<tr>
										<td>2163493151432012</td>
										<td>mMgVs6XockJgKwWmzEOHL1Vs4FIr6iGZ3FGXXSg0L76Tueik0F4EjXfFjmEl43LtdKUXEp0yz/v/so+wrDmFfA==</td>
									</tr>
									<tr>
										<td>2494093193114519</td>
										<td>PCp9/OrEdQ6HlqDWmVwlBgOINQTrQoTNBp54OxvKIVOuuBXhwLogmn9wxruUjsb6VrXPokY2hckQoPCeJ+Sasw==</td>
									</tr>
									<tr>
										<td>2169031079732010</td>
										<td>IHvOHoZIaYDku7z+YLZX3nlUAuqXUAbMBX/r5esHJaj3M/QJiItG02KBurihbKDFKIXtsU+argLzlY86fJThdQ==</td>
									</tr>
									<tr>
										<td>2497540163012512</td>
										<td>0PJsEj1XMJ8H45Crf/35v/xG93vQNJhoeIMt1Obiu2CpCidQmqirLh2g1X4w9PMn1r6hKfmF6nx7hHRhNlKWtw==</td>
									</tr>
									<tr>
										<td style="color : blue;">[개발자용]2161226477552018</td>
										<td style="color : blue;">tIBk3kCzW4yuWkrdweJUzn/klrssiOGlEYQjjGLXP7cb2FqvceeQdpNPj1dY92wQpAbIOAKfzCNlmsRgIHqb+w==</td>
									</tr>
									<tr>
										<td>2140426140732516</td>
										<td>7btiIXBF1jMR6ZO13W2bXH2jaZu4tS78m8JqFqkAf7KnrHeV2PJA/r/JYsu6PQrMItbLo34cKbWKXfULP7ZCQA==</td>
									</tr>
									<tr>
										<td>2140107865170818<br/>2496002899820412</td>
										<td>srZ9VEU4fin5xNNmeXViNtl2aMfQJQ6sQkIqqFF2+u/wftelTUpnxEI8mziznMRO0nZKZJeZGpxo1dORsphcuQ==</td>
									</tr>
									<tr>
										<td>2140435530720822<br/>2832431264701428</td>
										<td>3C14LRNEF4/K4AmGtR9Q9uj6GQqBdxfGOqgSkUK6hwIk4rYhVuxk8eosJBUREkxw2onHMkGuO+n4SAjvRvrVcw==</td>
									</tr>
								</tbody>
							</table>
							<table class="table_type1" style="width: 400px;">
								<colgroup>
									<col style="width:50%;"/>
									<col/>
								</colgroup>
								<tbody>
									<tr>
										<th>사용불능카드</th>
										<th>사용정지카드</th>
									</tr>
									<tr>
										<td>2161494150450028</td>
										<td>2835773262001021</td>
									</tr>
									<tr>
										<td>2162856223660024</td>
										<td>2147009413650827</td>
									</tr>
									<tr>
										<td>2464747361200827</td>
										<td>2493200899430015</td>
									</tr>
								</tbody>
							</table>
						</ul>
					</div>
				</div>
			</div>
		</div>
		<form id="cancelForm">
		<div class="easyui-accordion search-accordion" data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect" style="width:100%">
			<div title="수동 취소 요청" style="padding:10px">
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
									<th>MP 연동 이력 번호</th>
									<td colspan="3">
										<input type="text" name="mpLnkHistNo" class="validate[required]"/>
									</td>
								</tr>
							</table>
						</td>
						<td>
							<div style="vertical-align: top; height: 100%;">
								<button type="button" onclick="fnReqCancel()" class="btn btn-ok" style="margin-bottom:1px;margin-right:10px">호출</button>
								<br>
								<textarea id="cancelFormRes" style="width: 500px;"></textarea>
							</div>
						</td>
					</tr>
					
				</table>
			</div>
		</div>
		</form>
		<br/>
		<form id="ISR3K00101Form">
		<div class="easyui-accordion search-accordion" data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect" style="width:100%">
			<div title="MP 포인트 조회 (가용, 적립예정) ISR3K00101" style="padding:10px">
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
									<th><strong class="red">*</strong>멤버십카드번호(16자리) 또는 OTB</th>
									<td colspan="3">
										<input type="text" name="EBC_NUM" class="validate[required]"/>
									</td>
								</tr>
							</table>
						</td>
						<td>
							<div style="vertical-align: top; height: 100%;">
								<button type="button" onclick="fnReqISR3K00101()" class="btn btn-ok" style="margin-bottom:1px;margin-right:10px">호출</button>
								<br>
								<textarea id="ISR3K00101Res" style="width: 500px;"></textarea>
							</div>
						</td>
					</tr>
					
				</table>
			</div>
		</div>
		</form>
		<br/>
		<form id="ISR3K00102Form">
		<div class="easyui-accordion search-accordion" data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect" style="width:100%">
			<div title="PIN 번호 체크 ISR3K00102" style="padding:10px">
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
									<th><strong class="red">*</strong>멤버십카드번호(16자리)</th>
									<td>
										<input type="text" name="EBC_NUM" class="validate[required]"/>
									</td>
									<th><strong class="red">*</strong>핀번호</th>
									<td>
										<input type="text" name="PIN_NUMBER" class="validate[required]"/>
									</td>
								</tr>
							</table>
						</td>
						<td>
							<div style="vertical-align: top; height: 100%;">
								<button type="button" onclick="fnReqISR3K00102()" class="btn btn-ok" style="margin-bottom:1px;margin-right:10px">호출</button>
								<br>
								<textarea id="ISR3K00102Res" style="width: 500px;"></textarea>
							</div>
						</td>
					</tr>
					
				</table>
			</div>
		</div>
		</form>
		<br/>
		<form id="ISR3K00105Form">
		<div class="easyui-accordion search-accordion" data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect" style="width:100%">
			<div title="소멸예정 포인트 조회하기 ISR3K00105" style="padding:10px">
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
									<th><strong class="red">*</strong>멤버십카드번호(16자리)</th>
									<td colspan="3">
										<input type="text" name="EBC_NUM" class="validate[required]"/>
									</td>
								</tr>
							</table>
						</td>
						<td>
							<div style="vertical-align: top; height: 100%;">
								<button type="button" onclick="fnReqISR3K00105()" class="btn btn-ok" style="margin-bottom:1px;margin-right:10px">호출</button>
								<br>
								<textarea id="ISR3K00105Res" style="width: 500px;"></textarea>
							</div>
						</td>
					</tr>
					
				</table>
			</div>
		</div>
		</form>
		<br/>
		
		<form id="ISR3K00106Form">
		<div class="easyui-accordion search-accordion" data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect" style="width:100%">
			<div title="OTB 번호, PIN 번호로 멤버십카드번호 조회 ISR3K00106" style="padding:10px">
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
									<th><strong class="red">*</strong>OTB번호 또는 멤버십카드번호</th>
									<td>
										<input type="text" name="OTB_NUM" class="validate[required]"/>
									</td>
									<th><strong class="red">*</strong>PIN번호</th>
									<td>
										<input type="text" name="PIN_NUM" class="validate[required]"/>
									</td>
								</tr>
								
							</table>
						</td>
						<td>
							<div style="vertical-align: top; height: 100%;">
								<button type="button" onclick="fnReqISR3K00106()" class="btn btn-ok" style="margin-bottom:1px;margin-right:10px">호출</button>
								<br>
								<textarea id="ISR3K00106Res" style="width: 500px;"></textarea>
							</div>
						</td>
					</tr>
					
				</table>
			</div>
		</div>
		</form>
		<br/>
		
		<form id="ISR3K00107Form">
		<div class="easyui-accordion search-accordion" data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect" style="width:100%">
			<div title="할인금액 및 잔여횟수 조회하기 ISR3K00107" style="padding:10px">
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
									<th><strong class="red">*</strong>멤버십카드번호1</th>
									<td>
										<input type="text" name="EBC_NUM1" class="validate[required]"/>
									</td>
									<th><strong class="red">*</strong>제휴사코드(필수)</th>
									<td>
										<input type="text" name="CO_CD" class="validate[required]" value="V798"/>
									</td>
								</tr>
								<tr>
									<th>상품코드</th>
									<td>
										<input type="text" name="GOODS_CD" />
									</td>
									<th>금액</th>
									<td>
										<input type="text" name="GOODS_AMT"/>
									</td>
								</tr>
								<tr>
									<th><strong class="red">*</strong>가맹점코드</th>
									<td colspan="3">
										<input type="text" name="JOIN_CD" class="validate[required]" value="1001"/>
									</td>
								</tr>
							</table>
						</td>
						<td>
							<div style="vertical-align: top; height: 100%;">
								<button type="button" onclick="fnReqISR3K00107()" class="btn btn-ok" style="margin-bottom:1px;margin-right:10px">호출</button>
								<br>
								<textarea id="ISR3K00107Res" style="width: 500px;"></textarea>
							</div>
						</td>
					</tr>
					
				</table>
			</div>
		</div>
		</form>
		<br/>
		
		<form id="ISR3K00108Form">
		<div class="easyui-accordion search-accordion" data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect" style="width:100%">
			<div title="포인트 최대 사용 가능 금액 조회하기 ISR3K00108" style="padding:10px">
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
									<th><strong class="red">*</strong>멤버십카드번호1</th>
									<td>
										<input type="text" name="EBC_NUM1" class="validate[required]"/>
									</td>
									<th><strong class="red">*</strong>제휴사코드(필수) </th>
									<td>
										<input type="text" name="CO_CD" class="validate[required]" value="V798"/>
									</td>
								</tr>
								<tr>
									<th>상품코드</th>
									<td>
										<input type="text" name="GOODS_CD" />
									</td>
									<th>금액</th>
									<td>
										<input type="text" name="GOODS_AMT"/>
									</td>
								</tr>
								<tr>
									<th>CI값(사이트 연계정보)</th>
									<td colspan="3">
										<input type="text" name="CNNT_INFO" />
									</td>
								</tr>
							</table>
						</td>
						<td>
							<div style="vertical-align: top; height: 100%;">
								<button type="button" onclick="fnReqISR3K00108()" class="btn btn-ok" style="margin-bottom:1px;margin-right:10px">호출</button>
								<br>
								<textarea id="ISR3K00108Res" style="width: 500px;"></textarea>
							</div>
						</td>
					</tr>
					
				</table>
			</div>
		</div>
		</form>
		<br/>
		
		<form id="ISR3K00109Form">
		<div class="easyui-accordion search-accordion" data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect" style="width:100%">
			<div title="가용포인트 전환하기 ISR3K00109" style="padding:10px">
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
									<th><strong class="red">*</strong>R3K승인번호</th>
									<td>
										<input type="text" name="ACK_NUM" class="validate[required]"/>
									</td>
									<th><strong class="red">*</strong>멤버십카드번호(16자리)</th>
									<td>
										<input type="text" name="EBC_NUM" class="validate[required]"/>
									</td>
								</tr>
								<tr>
									<th><strong class="red">*</strong>제휴사코드(옵션)</th>
									<td>
										<input type="text" name="CO_CD" value="V798"/>
									</td>
									<th>승인일자</th>
									<td>
										<input type="text" name="ACK_DATE"/>
									</td>
								</tr>
							</table>
						</td>
						<td>
							<div style="vertical-align: top; height: 100%;">
								<button type="button" onclick="fnReqISR3K00109()" class="btn btn-ok" style="margin-bottom:1px;margin-right:10px">호출</button>
								<br>
								<textarea id="ISR3K00109Res" style="width: 500px;"></textarea>
							</div>
						</td>
					</tr>
					
				</table>
			</div>
		</div>
		</form>
		<br/>
		
		<form id="ISR3K00110Form">
		<div class="easyui-accordion search-accordion" data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect" style="width:100%">
			<div title="제휴사별 할인/적립/사용 횟수 제공 ISR3K00110" style="padding:10px">
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
									<th><strong class="red">*</strong>멤버십카드번호1</th>
									<td>
										<input type="text" name="EBC_NUM1" class="validate[required]"/>
									</td>
									<th>제휴사코드(옵션) </th>
									<td>
										<input type="text" name="CO_CD" value="V798"/>
									</td>
								</tr>
								<tr>
									<th>상품코드</th>
									<td colspan="3">
										<input type="text" name="GOODS_CD" />
									</td>
								</tr>
							</table>
						</td>
						<td>
							<div style="vertical-align: top; height: 100%;">
								<button type="button" onclick="fnReqISR3K00110()" class="btn btn-ok" style="margin-bottom:1px;margin-right:10px">호출</button>
								<br>
								<textarea id="ISR3K00110Res" style="width: 500px;"></textarea>
							</div>
						</td>
					</tr>
					
				</table>
			</div>
		</div>
		</form>
		<br/>
		
		<form id="ISR3K00114Form">
		<div class="easyui-accordion search-accordion" data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect" style="width:100%">
			<div title="CI, MemebershipCardNumber 일치여부 확인 ISR3K00114" style="padding:10px">
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
									<th><strong class="red">*</strong>멤버십카드번호</th>
									<td>
										<input type="text" name="EBC_NUM" class="validate[required]"/>
									</td>
									<th><strong class="red">*</strong>CI</th>
									<td>
										<input type="text" name="CNNT_INFO" class="validate[required]"/>
									</td>
								</tr>
							</table>
						</td>
						<td>
							<div style="vertical-align: top; height: 100%;">
								<button type="button" onclick="fnReqISR3K00114()" class="btn btn-ok" style="margin-bottom:1px;margin-right:10px">호출</button>
								<br>
								<textarea id="ISR3K00114Res" style="width: 500px;"></textarea>
							</div>
						</td>
					</tr>
					
				</table>
			</div>
		</div>
		</form>
		<br/>
		
		
	</t:putAttribute>
</t:insertDefinition>