<%--	
   - Class Name	: /sample/sampleGoogleAnalytics.jsp
   - Description: Google Analytics 샘플 화면
   - Since		: 2021.02.24
   - Author		: KKB
   --%>
<tiles:insertDefinition name="default">
	<tiles:putAttribute name="content">
		<style type="text/css">
			table {
		  		border: 1px solid #ecedef;
		  		border-collapse: collapse;
			}
			th, td {
				  border: 1px solid #ecedef;
				  padding: 10px;
			}
		</style>
      	<script type="text/javascript">
      	
			$(document).ready(function(){
				$(".add_to_cart .tex").parents("table").find(".rowspanArea").attr("rowspan",11);
				$(".add_to_cart .tex").hide();
			});
			
			
			// 호출 방법
			function callFunc(funcNm) {
				if(funcNm == 'sign_up'){ // 회원가입
					// 데이터 입력
					sign_up_data.method = $("#sign_up input[name=method]").val();
					// 호출
					sendGtag('sign_up');
				}else if(funcNm == 'login'){ // 로그인
					// 데이터 입력
					login_data.method = $("#login input[name=method]").val();
					// 호출
					sendGtag('login');
				}else if(funcNm == 'add_to_cart'){ // 장바구니
					// 데이터 입력
					add_to_cart_data.currency = $("#add_to_cart input[name=currency]").val();
					add_to_cart_data.items = getItem(funcNm);
					add_to_cart_data.value = $("#add_to_cart input[name=value]").val();
					// 호출
					sendGtag('add_to_cart');
				}else if(funcNm == 'purchase'){ // 구매
					// 데이터 입력
					purchase_data.affiliation = $("#purchase input[name=affiliation]").val();
					purchase_data.coupon = $("#purchase input[name=coupon]").val();
					purchase_data.currency = $("#purchase input[name=currency]").val();
					purchase_data.shipping = $("#purchase input[name=shipping]").val();
					purchase_data.tax = $("#purchase input[name=tax]").val();
					purchase_data.transaction_id = $("#purchase input[name=transaction_id]").val();
					purchase_data.value = $("#purchase input[name=value]").val();
					purchase_data.items = getItem(funcNm);
					// 호출
					sendGtag('purchase');
				}else if(funcNm == 'refund'){ // 환불
					// 데이터 입력
					refund_data.affiliation = $("#add_to_cart input[name=affiliation]").val();
					refund_data.coupon = $("#add_to_cart input[name=coupon]").val();
					refund_data.currency = $("#add_to_cart input[name=currency]").val();
					refund_data.shipping = $("#add_to_cart input[name=shipping]").val();
					refund_data.tax = $("#add_to_cart input[name=tax]").val();
					refund_data.transaction_id = $("#add_to_cart input[name=transaction_id]").val();
					refund_data.value = $("#add_to_cart input[name=value]").val();
					refund_data.items = getItem(funcNm);
					// 호출
					sendGtag('refund');
				}else if(funcNm == 'search'){ // 검색
					search_data.search_term = $("#search input[name=search_term]").val();
					sendGtag('search');
				}
			}
	        
			var itemCnt = 0;
	    	function delItem(obj) {
			 	var itemTrs = $(obj).parents("table").find(".itemTr");
				if(itemTrs.length > 12){
					itemTrs.each(function() {
						if($(this).data("itemidx") == $(obj).parents("tr").data("itemidx")){
			 				$(this).remove();
						}
					})
				}				
			};
			
		 	function addItem(obj) {
		 		itemCnt++;
				$.get("/sample/sampleGaHtml?itemidx="+itemCnt,function (html) { 
					$(obj).parents(".popLayer").find(".itemTr").last().after(html);
					$(".add_to_cart .tex").parents("table").find(".rowspanArea").attr("rowspan",11);
					$(".add_to_cart .tex").hide();
				});
			};
			
			function getItem(formName) {
				let itemArray = new Array();
				let itemTrs = $("#"+formName).find(".itemTr");
				let thisItem = {
						item_id: null,
						item_name: null, 	
						quantity: null,		
						affiliation : null, 
						coupon: null, 		
						discount : null,    
						item_brand: null, 	
						item_category: null,
						item_variant: null,	
						price: null,		
						currency: null,		
					};
				var resetThisItem = JSON.parse(JSON.stringify(thisItem));
				itemTrs.each(function() {
					let thisName  = $(this).find(".inputTd :input").attr("name");
					thisItem[thisName] = $(this).find(".inputTd :input").val();
					if(thisName=="currency"){
						itemArray.push(thisItem);
						thisItem =  JSON.parse(JSON.stringify(resetThisItem));
					}
				});
				return itemArray;
			}
		</script>
	
		<main class="container page" id="container">
			<div class="inr">
				<!-- 본문 -->
				<div class="contents" id="contents">
					<div class="pageHeadMo">
						<div class="hdt" style=";">
							<h3 class="tit">[ Analytics 설명]</h3>
						</div>
						<br/>
					</div>
	            	<p>1. googleAnalytics.js의 각 업무별 데이터의 하위 항목을 입력합니다.</p>
	            	<p>업무별 데이터 변수명 : 회원가입-sign_up_data, 로그인-login_data, 장바구니-add_to_cart_data, 구매-purchase_data, 환불-refund_data, 검색-search_data</p>
	            	<p>2.sendGtag(업무명) 호출합니다.</p>
	            	<p>업무명 : 회원가입-sign_up, 로그인-login, 장바구니-add_to_cart, 구매-purchase, 환불-refund, 검색-search </p>
	            	<pre>
    예)
	sign_up_data.method = $("#sign_up input[name=method]").val();
	sendGtag('sign_up');	            	
	            	</pre>
	               	<br/>
	               	<div class="pageHeadMo">
						<div class="hdt" style=";">
							<h3 class="tit">[ Analytics TEST ]</h3>
						</div>
						<br/>
					</div>
					<form id="gaForm">
						<table style="border: #ecedef solid 1px; border-collapse: collapse;">
							<caption>Google Analytics</caption>
							<colgroup>
								<col width="10%">
								<col width="70%">
								<col width="10%">
								<col width="10%">
							</colgroup>
							<tr>
								<th>구 분</th>
								<th>요 약</th>
								<th>상 세</th>
							</tr>
							<tr>
								<th>회원가입</th>
								<td>
									This event indicates that a user has signed up for an account. Use this event to understand the different behaviors of logged in and logged out users.
								</td>
								<td>
									<button type="button" onclick="ui.popLayer.open('sign_up')" class="btn sm b">회원가입</button>
								</td>
							</tr>
							<tr>
								<th>로그인</th>
								<td>
									Send this event to signify that a user has logged in.
								</td>
								<td>
									<button type="button" onclick="ui.popLayer.open('login')" class="btn sm b">로그인</button>
								</td>
							</tr>
							<tr>
								<th>장바구니</th>
								<td>
									This event signifies that an item was added to a cart for purchase.
								</td>
								<td>
									<button type="button" onclick="ui.popLayer.open('add_to_cart')" class="btn sm b">장바구니</button>
								</td>
							</tr>
							<tr>
								<th>구매</th>
								<td>
									This event signifies when one or more items is purchased by a user.
								</td>
								<td>
									<button type="button" onclick="ui.popLayer.open('purchase')" class="btn sm b">구매</button>
								</td>
							</tr>
							<tr>
								<th>환불</th>
								<td>
									This event signifies a refund was issued.
								</td>
								<td>
									<button type="button" onclick="ui.popLayer.open('refund')" class="btn sm b">환불</button>
								</td>
							</tr>
							<tr>
								<th>검색</th>
								<td>
									Use this event to contextualize search operations. This event can help you identify the most popular content in your app.
								</td>
								<td>
									<button type="button" onclick="ui.popLayer.open('search')" class="btn sm b">검색</button>
								</td>
							</tr>
						</table>
					</form>
				</div>
			</div>
		</main>
      
		<div class="layers">
			<!-- 회원 가입 -->
			<article class="popLayer a sign_up" id="sign_up" >
				<div class="pbd">
					<div class="phd">
						<div class="in">
							<h1 class="tit">회원 가입</h1>
							<button type="button" class="btnPopClose">닫기</button>
	        			</div>
	     			</div>
	     			<div class="pct">
	        			<main class="poptents">
	           				<p>회원가입 정보 전달</p>
	           				<P>호출 함수 : sendGtag('sign_up')</P>
	           				<p>전송 데이터</p>
	           				<pre>
var sign_up_data = {
	method: null
}
	           				</pre>
	          	 			<br/>
	           				<div>
	              				<div>
	                 				<form name="sign_up_form" id="sign_up_form" >
	                    				<table>
											<colgroup>
											   <col width="10%">
											   <col width="20%">
											   <col width="70%">
											</colgroup>
											<tr>
												<th>항목</th>
												<th>입력값</th>
												<th>비고</th>
											</tr>
	                       					<tr>
												<th>method</th>
												<td>
													<input name="method" type="text" placeholder="method">
												</td>
												<td>string, Not required, The method used for sign up.</td>
											</tr>
										</table>
										<br>	                       
										<button type="button" class="btn" onclick="callFunc('sign_up');" >Call</button>
									</form>
								</div>
							</div>
						</main>
					</div>
				</div>
			</article>
			<!-- 로그인 -->
			<article class="popLayer a login" id="login" >
				<div class="pbd">
					<div class="phd">
						<div class="in">
							<h1 class="tit">로그인</h1>
							<button type="button" class="btnPopClose">닫기</button>
	        			</div>
	     			</div>
	     			<div class="pct">
	        			<main class="poptents">
	           				<p>로그인 정보 전달</p>
	           				<P>호출 함수 : sendGtag('login')</P>
	           				<p>전송 데이터</p>
	           				<pre>
var login_data = {
	method: null
}
	           				</pre>
	          	 			<br/>
	           				<div>
	              				<div>
	                 				<form name="login_form" id="login_form" >
	                    				<table>
											<colgroup>
											   <col width="10%">
											   <col width="20%">
											   <col width="70%">
											</colgroup>
											<tr>
												<th>항목</th>
												<th>입력값</th>
												<th>비고</th>
											</tr>
	                       					<tr>
												<th>method</th>
												<td>
													<input name="method" type="text" placeholder="method">
												</td>
												<td>string, Not required, The method used to login.</td>
											</tr>
										</table>
										<br>	                       
										<button type="button" class="btn" onclick="callFunc('login');" >Call</button>
									</form>
								</div>
							</div>
						</main>
					</div>
				</div>
			</article>
			<!-- 장바구니 -->
			<article class="popLayer a add_to_cart" id="add_to_cart" >
				<div class="pbd">
					<div class="phd">
						<div class="in">
							<h1 class="tit">장바구니</h1>
							<button type="button" class="btnPopClose">닫기</button>
	        			</div>
	     			</div>
	     			<div class="pct">
	        			<main class="poptents">
	           				<p>장바구니 정보 전달</p>
	           				<P>호출 함수 : sendGtag('add_to_cart')</P>
	           				<p>전송 데이터</p>
	           				<pre>
var add_to_cart_data = {
	currency: null,
	items: [
		{
			item_id: null,
			item_name: null, 	
			quantity: null,		
			affiliation : null, 
			coupon: null, 		
			discount : null,    
			item_brand: null, 	
			item_category: null,
			item_variant: null,	
			price: null,		
			currency: null,		
		}
	],
	value: null 				
}
	           				</pre>
	          	 			<br/>
	           				<div>
	              				<div>
	                 				<form name="add_to_cart_form" id="add_to_cart_form" >
	                    				<table>
											<colgroup>
											   <col width="10%">
											   <col width="10%">
											   <col width="20%">
											   <col width="60%">
											</colgroup>
											<tr>
												<th colspan="2">항목</th>
												<th>입력값</th>
												<th>비고</th>
											</tr>
	                       					<tr>
												<th colspan="2">currency</th>
												<td>
													<input name="currency" type="text" placeholder="currency">
												</td>
												<td>string, Not required, Currency of the items associated with the event, in 3-letter ISO 4217 format.</td>
											</tr>
											<jsp:include page="/WEB-INF/view/sample/sampleGaHtml.jsp">
			                                 	<jsp:param value="0" name="itemidx"/>
			                                 </jsp:include>
											<tr>
												<th colspan="2">value</th>
												<td>
													<input name="value" type="text" placeholder="value">
												</td>
												<td>number, Not required, The monetary value of the event.</td>
											</tr>
										</table>
										<br>	                       
										<button type="button" class="btn" onclick="callFunc('add_to_cart');" >Call</button>
									</form>
								</div>
							</div>
						</main>
					</div>
				</div>
			</article>
			<!-- 구매 -->
			<article class="popLayer a purchase" id="purchase" >
				<div class="pbd">
					<div class="phd">
						<div class="in">
							<h1 class="tit">구매</h1>
							<button type="button" class="btnPopClose">닫기</button>
	        			</div>
	     			</div>
	     			<div class="pct">
	        			<main class="poptents">
	           				<p>구매 정보 전달</p>
	           				<P>호출 함수 : sendGtag('purchase')</P>
	           				<p>전송 데이터</p>
	           				<pre>
var purchase_data = {
	affiliation: null,			
	coupon: null,  				
	currency: null,				
	shipping: null,				
	tax: null,					
	transaction_id: null,		
	value: null,				
	items: [
		{
			item_id: null, 		
			item_name: null, 	
			quantity: null,		
			affiliation : null, 
			coupon: null, 		
			discount : null,    
			item_brand: null, 	
			item_category: null,
			item_variant: null,	
			tax	: null,			
			price: null,		
			currency: null,		
		}
	]
}
	           				</pre>
	          	 			<br/>
	           				<div>
	              				<div>
	                 				<form name="purchase_form" id="purchase_form" >
	                    				<table>
											<colgroup>
											   <col width="10%">
											   <col width="10%">
											   <col width="20%">
											   <col width="60%">
											</colgroup>
											<tr>
												<th colspan="2">항목</th>
												<th>입력값</th>
												<th>비고</th>
											</tr>
	                       					<tr>
												<th colspan="2">affiliation</th>
												<td>
													<input name="affiliation" type="text" placeholder="affiliation">
												</td>
												<td>string, Not required, A product affiliation to designate a supplying company or brick and mortar store location.</td>
											</tr>
											<tr>
												<th colspan="2">coupon</th>
												<td>
													<input name="coupon" type="text" placeholder="coupon">
												</td>
												<td>string, Not required, Coupon code used for a purchase.</td>
											</tr>
											<tr>
												<th colspan="2">currency</th>
												<td>
													<input name="currency" type="text" placeholder="currency">
												</td>
												<td>string, Not required, Currency of the purchase or items associated with the event, in 3-letter ISO 4217 format.</td>
											</tr>
											<tr>
												<th colspan="2">shipping</th>
												<td>
													<input name="shipping" type="text" placeholder="shipping">
												</td>
												<td>number, Not required, Shipping cost associated with a transaction.</td>
											</tr>
											<tr>
												<th colspan="2">tax</th>
												<td>
													<input name="tax" type="text" placeholder="tax">
												</td>
												<td>number, Not required, Tax cost associated with a transaction.</td>
											</tr>
											<tr>
												<th colspan="2">transaction_id</th>
												<td>
													<input name="transaction_id" type="text" placeholder="transaction_id">
												</td>
												<td>string, Not required, The unique identifier of a transaction.</td>
											</tr>
											<tr>
												<th colspan="2">value</th>
												<td>
													<input name="value" type="text" placeholder="value">
												</td>
												<td>number, Not required, The monetary value of the event, in units of the specified currency parameter.</td>
											</tr>
											<jsp:include page="/WEB-INF/view/sample/sampleGaHtml.jsp">
			                                 	<jsp:param value="0" name="itemidx"/>
			                                 </jsp:include>
										</table>
										<br>	                       
										<button type="button" class="btn" onclick="callFunc('purchase');" >Call</button>
									</form>
								</div>
							</div>
						</main>
					</div>
				</div>
			</article>
			<!-- 환불 -->
			<article class="popLayer a refund" id="refund" >
				<div class="pbd">
					<div class="phd">
						<div class="in">
							<h1 class="tit">환불</h1>
							<button type="button" class="btnPopClose">닫기</button>
	        			</div>
	     			</div>
	     			<div class="pct">
	        			<main class="poptents">
	           				<p>환불 정보 전달</p>
	           				<P>호출 함수 : sendGtag('refund')</P>
	           				<p>전송 데이터</p>
	           				<pre>
var refund_data = {
	affiliation : null,			
	coupon: null,  				
	currency: null,				
	shipping: null,				
	tax: null,					
	transaction_id: null,		
	value: null,				
	items: [
		{
			item_id: null, 		
			item_name: null, 	
			quantity: null,		
			affiliation : null, 
			coupon: null, 		
			discount : null,    
			item_brand: null, 	
			item_category: null,
			item_variant: null,	
			tax	: null,			
			price: null,		
			currency: null,		
		}
	]
}
	           				</pre>
	          	 			<br/>
	           				<div>
	              				<div>
	                 				<form name="refund_form" id="refund_form" >
	                    				<table>
											<colgroup>
											   <col width="10%">
											   <col width="10%">
											   <col width="20%">
											   <col width="60%">
											</colgroup>
											<tr>
												<th colspan="2">항목</th>
												<th>입력값</th>
												<th>비고</th>
											</tr>
	                       					<tr>
												<th colspan="2">affiliation</th>
												<td>
													<input name="affiliation" type="text" placeholder="affiliation">
												</td>
												<td>string, Not required, A product affiliation to designate a supplying company or brick and mortar store location.</td>
											</tr>
											<tr>
												<th colspan="2">coupon</th>
												<td>
													<input name="coupon" type="text" placeholder="coupon">
												</td>
												<td>string, Not required, Coupon code used for a purchase.</td>
											</tr>
											<tr>
												<th colspan="2">currency</th>
												<td>
													<input name="currency" type="text" placeholder="currency">
												</td>
												<td>string, Not required, Currency of the purchase or items associated with the event, in 3-letter ISO 4217 format.</td>
											</tr>
											<tr>
												<th colspan="2">shipping</th>
												<td>
													<input name="shipping" type="text" placeholder="shipping">
												</td>
												<td>number, Not required, Shipping cost associated with a transaction.</td>
											</tr>
											<tr>
												<th colspan="2">tax</th>
												<td>
													<input name="tax" type="text" placeholder="tax">
												</td>
												<td>number, Not required, Tax cost associated with a transaction.</td>
											</tr>
											<tr>
												<th colspan="2">transaction_id</th>
												<td>
													<input name="transaction_id" type="text" placeholder="transaction_id">
												</td>
												<td>string, Not required, The unique identifier of a transaction.</td>
											</tr>
											<tr>
												<th colspan="2">value</th>
												<td>
													<input name="value" type="text" placeholder="value">
												</td>
												<td>number, Not required, The monetary value of the event, in units of the specified currency parameter.</td>
											</tr>
											<jsp:include page="/WEB-INF/view/sample/sampleGaHtml.jsp">
			                                 	<jsp:param value="0" name="itemidx"/>
			                                 </jsp:include>
										</table>
										<br>	                       
										<button type="button" class="btn" onclick="callFunc('refund');" >Call</button>
									</form>
								</div>
							</div>
						</main>
					</div>
				</div>
			</article>			
			<!-- 검색 -->
			<article class="popLayer a search" id="search" >
				<div class="pbd">
					<div class="phd">
						<div class="in">
							<h1 class="tit">로그인</h1>
							<button type="button" class="btnPopClose">닫기</button>
	        			</div>
	     			</div>
     			<div class="pct">
        			<main class="poptents">
           				<p>검색 정보 전달</p>
           				<P>호출 함수 : sendGtag('search')</P>
           				<p>전송 데이터</p>
           				<pre>
var search_data = {
	search_term: null 			// string, Required, The term that was searched for.
}
           				</pre>
          	 			<br/>
           				<div>
              				<div>
                 				<form name="search_form" id="search_form" >
                    				<table>
										<colgroup>
										   <col width="10%">
										   <col width="40%">
										   <col width="50%">
										</colgroup>
										<tr>
											<th>항목</th>
											<th>입력값</th>
											<th>비고</th>
										</tr>
                       					<tr>
											<th>search_term</th>
											<td>
												<input name="search_term" type="text" placeholder="search_term">
											</td>
											<td>The term that was searched for.</td>
										</tr>
									</table>
									<br>	                       
									<button type="button" class="btn" onclick="callFunc('search');" >Call</button>
								</form>
							</div>
						</div>
					</main>
				</div>
			</div>
		</article>
      </div>
   </tiles:putAttribute>
</tiles:insertDefinition>