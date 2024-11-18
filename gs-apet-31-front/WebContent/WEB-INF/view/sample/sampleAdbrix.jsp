<%--	
   - Class Name	: /sample/sampleAdbrix.jsp
   - Description: adbrix 샘플 화면
   - Since		: 2021.02.18
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
      	
			// 호출 방법
			function callFunc(funcNm) {
				if(funcNm == 'onUserRegister'){ // 회원가입
					let eventAttrsMap = new Map();
					let eventAttrDivs = $("#onUserRegisterForm").find(".mapDiv");
					eventAttrDivs.each(function(i, v){
						var thisKey = $(this).find(".mapKey").val();
						var thisVal = $(this).find(".mapVal").val();
						if(thisKey != null){
							eventAttrsMap.set(thisKey, thisVal);
						}
					});
					let eventAttrs = Object.fromEntries(eventAttrsMap);
					
					// 데이터 세팅
					onUserRegisterData.func = 'onUserRegister';
					onUserRegisterData.SignUpChnnel = $("#SignUpChnnel").val();
					onUserRegisterData.eventAttrs = eventAttrs;
				
					// 호출 
					toNativeAdbrix(onUserRegisterData);
					
					// 회원 가입 데이터 예시
					/*
					onUserRegisterData = {
						func : 'onUserRegister',
						SignUpChnnel : 1,
						eventAttrs : {
							gender : "male",
							height : 36,
							married : true,
							key : 'value'
					}
					*/
				}else if(funcNm == 'onProductView'){ // 상품보기
					let categoryArray = new Array();
					let categoryDivs = $("#onProductViewForm .arrayArea input ");
					categoryDivs.each(function(i, v) {
						categoryArray.push($(v).val());
					})
					let productDetailAttrsMap = new Map();
					let productDetailAttrsDivs = $("#onProductViewForm .prod").find(".mapDiv");
					productDetailAttrsDivs.each(function(i, v){
						var thisKey = $(this).find(".mapKey").val();
						var thisVal = $(this).find(".mapVal").val();
						if(thisKey != null){
							productDetailAttrsMap.set(thisKey, thisVal);
						}
					});
					let productDetailAttrs = Object.fromEntries(productDetailAttrsMap);
					let eventAttrsMap = new Map();
					let eventAttrDivs = $("#onProductViewForm .event").find(".mapDiv");
					eventAttrDivs.each(function(i, v){
						var thisKey = $(this).find(".mapKey").val();
						var thisVal = $(this).find(".mapVal").val();
						if(thisKey != null){
							eventAttrsMap.set(thisKey, thisVal);
						}
					});
					let eventAttrs = Object.fromEntries(eventAttrsMap);
					
					// 데이터 세팅
					onProductViewData.func = 'onProductView';
					onProductViewData.productModels.productId = $("#onProductViewForm input[name=productId]").val();
					onProductViewData.productModels.productName = $("#onProductViewForm input[name=productName]").val();
					onProductViewData.productModels.price = $("#onProductViewForm input[name=price]").val();
					onProductViewData.productModels.quantity = $("#onProductViewForm input[name=quantity]").val();
					onProductViewData.productModels.discount = $("#onProductViewForm input[name=discount]").val();
					onProductViewData.productModels.categorys = categoryArray;
					onProductViewData.productModels.productDetailAttrs = productDetailAttrs;
					onProductViewData.eventAttrs= eventAttrs;
					
					// 호출
					toNativeAdbrix(onProductViewData);
					
					// 상품보기 데이터 예시
					/*
					onProductViewData = {
			    		func : 'onProductView',
			    		productModels : {
			    			productId : '5385487400',
			    			productName : '슬랙스 10종 특가',
			    			price : 10000.0,
			    			quantity : 1,
			    			discount : 1000.0,
			    			currency : 1,		// 상단 주석 또는 문서 참고
			    			categorys : [
			    				'카테고리 1', '카테고리 2', '카테고리 3'
			    			],
			    			productDetailAttrs : {
			    				size : 25,
			    				color : 'blue',
			    				vip : false
			    			}
			    		},
			    		eventAttrs : {
			    			gender : "male",
			    			height : 36,
			    			married : true
			    		}
			    	};
					*/
				}else if(funcNm == 'onSearch'){ // 상품검색
					let eventAttrsMap = new Map();
					let eventAttrDivs = $("#"+funcNm+"Form .event").find(".mapDiv");
					eventAttrDivs.each(function(i, v){
						var thisKey = $(this).find(".mapKey").val();
						var thisVal = $(this).find(".mapVal").val();
						if(thisKey != null){
							eventAttrsMap.set(thisKey, thisVal);
						}
					});
					let eventAttrs = Object.fromEntries(eventAttrsMap);
					
					// 데이터 입력
					onSearchData.func = 'onSearch';
					onSearchData.keyword = $("#"+funcNm+"Form").find("input[name=keyword]").val();
					onSearchData.productModels = getProductModels(funcNm);
					onSearchData.eventAttrs = eventAttrs;
					
					// 호출
					toNativeAdbrix(onSearchData);
					
					// 상품검색 데이터 예시
					/*
					onSearchData = {
			    		'func' : 'onSearch',
			    		'keyword' : '캐주얼 바지',
			    		'productModels' : [
			    		{
			    			'productId' : '5385487400',
			    			'productName' : '슬랙스 10종 특가',
			    			'price' : 10000.0,
			    			'quantity' : 1,
			    			'discount' : 1000.0,
			    			'currency' : 1,		// 상단 주석 또는 문서 참고
			    			'categorys' : [
			    				'카테고리 1', '카테고리 2', '카테고리 3'
			    			],
			    			'productDetailAttrs' : {
			    				'size' : 25,
			    				'color' : 'blue',
			    				'vip' : false
			    			}
			    		},
			    		{
			    			'productId' : '145099811',
			    			'productName' : '[이월특가] 나염 맨투맨',
			    			'price' : 15500.0,
			    			'quantity' : 1,
			    			'discount' : 1200.0,
			    			'currency' : 1,		// 상단 주석 또는 문서 참고
			    			'categorys' : [
			    				'카테고리 12', '카테고리 22', '카테고리 32'
			    			],
			    			'productDetailAttrs' : {
			    				'grade' : 'vip',
			    				'howmany_buy' : 36,
			    				'discount' : true
			    			}
			    		},
			    		],
			    		'eventAttrs' : {
			    			'gender' : "male",
			    			'height' : 36,
			    			'married' : true
			    		}
			    	};
					*/
				}else if(funcNm == 'onAddToCart'){ // 장바구니 담기
					let eventAttrsMap = new Map();
					let eventAttrDivs = $("#"+funcNm+"Form .event").find(".mapDiv");
					eventAttrDivs.each(function(i, v){
						var thisKey = $(this).find(".mapKey").val();
						var thisVal = $(this).find(".mapVal").val();
						if(thisKey != null){
							eventAttrsMap.set(thisKey, thisVal);
						}
					});
					let eventAttrs = Object.fromEntries(eventAttrsMap);
					
					// 데이터 입력
					onAddToCartData.func = 'onAddToCart';
					onAddToCartData.productModels = getProductModels(funcNm);
					onAddToCartData.eventAttrs = eventAttrs;
					
					// 호출
					toNativeAdbrix(onAddToCartData);
					
					// 장바구니 담기
					/*
					onAddToCartData = {
			    		'func' : 'onAddToCart',
			    		'productModels' : [
			    		{
			    			'productId' : '5385487400',
			    			'productName' : '슬랙스 10종 특가',
			    			'price' : 10000.0,
			    			'quantity' : 1,
			    			'discount' : 1000.0,
			    			'currency' : 1,		// 상단 주석 또는 문서 참고
			    			'categorys' : [
			    				'카테고리 1', '카테고리 2', '카테고리 3'
			    			],
			    			'productDetailAttrs' : {
			    				'size' : 25,
			    				'color' : 'blue',
			    				'vip' : false
			    			}
			    		},
			    		{
			    			'productId' : '145099811',
			    			'productName' : '[이월특가] 나염 맨투맨',
			    			'price' : 15500.0,
			    			'quantity' : 1,
			    			'discount' : 1200.0,
			    			'currency' : 1,		// 상단 주석 또는 문서 참고
			    			'categorys' : [
			    				'카테고리 12', '카테고리 22', '카테고리 32'
			    			],
			    			'productDetailAttrs' : {
			    				'grade' : 'vip',
			    				'howmany_buy' : 36,
			    				'discount' : true
			    			}
			    		}
			    		],
			    		'eventAttrs' : {
			    			'gender' : "male",
			    			'height' : 36,
			    			'married' : true
			    		}
			    	};
					*/
				}else if(funcNm == 'onFirstPurchase'){ // 최초결제 완료
					let eventAttrsMap = new Map();
					let eventAttrDivs = $("#"+funcNm+"Form .event").find(".mapDiv");
					eventAttrDivs.each(function(i, v){
						var thisKey = $(this).find(".mapKey").val();
						var thisVal = $(this).find(".mapVal").val();
						if(thisKey != null){
							eventAttrsMap.set(thisKey, thisVal);
						}
					});
					let eventAttrs = Object.fromEntries(eventAttrsMap);
					
					// 데이터 입력
					onFirstPurchaseData.func = 'onFirstPurchase';
					onFirstPurchaseData.eventAttrs = eventAttrs;
					
					// 호출
					toNativeAdbrix(onFirstPurchaseData);
					
					// 장바구니 담기
					/*
					onFirstPurchaseData = {
		    			'func' : 'onFirstPurchase',
			    		'eventAttrs' : {
			    			'attr1' : "최초 결제"
			    		}
			    	};
					*/
				}else if(funcNm == 'onPurchase'){ //  결제완료
					let eventAttrsMap = new Map();
					let eventAttrDivs = $("#"+funcNm+"Form .event").find(".mapDiv");
					eventAttrDivs.each(function(i, v){
						var thisKey = $(this).find(".mapKey").val();
						var thisVal = $(this).find(".mapVal").val();
						if(thisKey != null){
							eventAttrsMap.set(thisKey, thisVal);
						}
					});
					let eventAttrs = Object.fromEntries(eventAttrsMap);
					
					// 데이터 입력
					onPurchaseData.func = 'onPurchase';
					onPurchaseData.orderAttrs.orderId = $("#"+funcNm+"Form").find("input[name=orderId]").val();
					onPurchaseData.orderAttrs.orderSales = $("#"+funcNm+"Form").find("input[name=orderSales]").val();
					onPurchaseData.orderAttrs.discount = $("#"+funcNm+"Form").find("input[name=discount]").val();
					onPurchaseData.orderAttrs.deliveryCharge = $("#"+funcNm+"Form").find("input[name=deliveryCharge]").val();
					onPurchaseData.orderAttrs.paymentMethod = $("#paymentMethod").val();
					onPurchaseData.productModels = getProductModels(funcNm);
					onPurchaseData.eventAttrs = eventAttrs;
					
					// 호출
					toNativeAdbrix(onPurchaseData);
					
					// 결제완료
					/*
					onPurchaseData = {
		    			'func' : 'onPurchase',
			    		'orderId' : '290192012',
			    		'orderSales' : 70000.0,
			    		'discount' : 22500.0,
			    		'deliveryCharge' : 1000.0,
			    		'paymentMethod' : 1,
			    		'productModels' : [
			    		{
			    			'productId' : '5385487400',
			    			'productName' : '슬랙스 10종 특가',
			    			'price' : 10000.0,
			    			'quantity' : 1,
			    			'discount' : 1000.0,
			    			'currency' : 1,		// 상단 주석 또는 문서 참고
			    			'categorys' : [
			    				'카테고리 1', '카테고리 2', '카테고리 3'
			    			],
			    			'productDetailAttrs' : {
			    				'size' : 25,
			    				'color' : 'blue',
			    				'vip' : false
			    			}
			    		},
			    		{
			    			'productId' : '145099811',
			    			'productName' : '[이월특가] 나염 맨투맨',
			    			'price' : 15500.0,
			    			'quantity' : 1,
			    			'discount' : 1200.0,
			    			'currency' : 1,		// 상단 주석 또는 문서 참고
			    			'categorys' : [
			    				'카테고리 12', '카테고리 22', '카테고리 32'
			    			],
			    			'productDetailAttrs' : {
			    				'grade' : 'vip',
			    				'howmany_buy' : 36,
			    				'discount' : true
			    			}
			    		},
			    		],
			    		'eventAttrs' : {
			    			'gender' : "male",
			    			'height' : 36,
			    			'married' : true
			    		}
			    	};
					*/
				}
			}
			
			
			$(document).ready(function(){
				$(".mapArea").each(function(i, v) {
					addMap(this);
					if($(this).hasClass("needFirstYn")){
						$(this).find(".mapKey").val("firstYn");
					}
				})
				$(".arrayArea").each(function() {
					addArray(this);
				});
			});
	        
			function addMapHtml(){
				let addhtml = '<div class="mapDiv" style="display: block;" >';
				addhtml += '<input class="mapKey" type="text" placeholder="key">';
				addhtml += '<input class="mapVal" type="text" placeholder="value">';
				addhtml += '<button type="button" onclick="delMap(this);" class="btn">-</button>';
				addhtml += '<button type="button" onclick="addMap(this);" class="btn">+</button>';
				addhtml += '</div>';
				return addhtml;
	 		}
	    
	    	function delMap(obj) {    		
				if($(obj).parents("tr").find(".mapDiv").length > 1){
					$(obj).parent("div").remove();
				}				
			};
			
		 	function addMap(obj) { 
		 		if($(obj).parents("tr").find(".mapDiv").length == 0 ){ 
		 			$(obj).parents("tr").find(".mapArea").html(addMapHtml());
		 		}else{
					$(obj).parents("tr").find(".mapDiv").last().after(addMapHtml());				
		 		}
			};
			
			function addArrayHtml(){
				let addhtml = '<div class="arrayDiv" style="display: block;" >';
				addhtml += '<input name="arryVal" type="text" placeholder="value">';
				addhtml += '<button type="button" onclick="delArray(this);" class="btn">-</button>';
				addhtml += '<button type="button" onclick="addArray(this);" class="btn">+</button>';
				addhtml += '</div>';
				return addhtml;
	 		}
	    
	    	function delArray(obj) {    		
				if($(obj).parents("tr").find(".arrayDiv").length > 1){
					$(obj).parent("div").remove();
				}				
			};
			
		 	function addArray(obj) {
		 		if($(obj).parents("tr").find(".arrayDiv").length == 0 ){
		 			$(obj).parents("tr").find(".arrayArea").html(addArrayHtml());
		 		}else{
					$(obj).parents("tr").find(".arrayDiv").last().after(addArrayHtml());				
		 		}
			};
			
			var prodCnt = 0;
	    	function delProd(obj) {
			 	var prdTrs = $(obj).parents("table").find(".prodTr");
				if(prdTrs.length > 8){
			 		prdTrs.each(function() {
						if($(this).data("prdidx") == $(obj).parents("tr").data("prdidx")){
			 				$(this).remove();
						}
					})
				}				
			};
			
		 	function addProd(obj) {
				prodCnt++;
				$.get("/sample/sampleAdbrixProdHtml?prdIdx="+prodCnt,function (html) { 
					$(obj).parents("table").find(".prodTr").last().after(html);
					$(obj).parents("table").find(".prodTr .arrayArea").each(function() {
						if($(this).find("input").length == 0){
							addArray(this);
						}
					});
					$(obj).parents("table").find(".prodTr .mapArea").each(function() {
						if($(this).find("input").length == 0){
							addMap(this);
						}
					});
				});
				
			};
			
			function getProductModels(formName) {
				let productModelsArray = new Array();
				let prodTrs = $("#"+formName+"Form").find(".prodTr");
				let thisProductModel = {
						productId : null,	
						productName : null,  
						price : null,		
						quantity : null,
						discount : null,
						currency : null,
						categorys : [],
						productDetailAttrs : {}
					};
				var resetProductModel = Object.assign({}, thisProductModel);
				prodTrs.each(function() {
					let thisPrdIdx = $(this).data("prdidx");
					if($(this).find(".inputTd").length == 1){
						let thisName  = $(this).find(".inputTd :input").attr("name");
						thisProductModel[thisName] = $(this).find(".inputTd :input").val();
					}else if($(this).find(".inputTdA").length == 1){
						let thisInputArr = new Array();
						$(this).find("input").each(function(i,v) {
							thisInputArr.push($(v).val());
						});
						thisProductModel['categorys'] = thisInputArr;
					}else{
						let thisInputMap = new Map();
						let thisKey = null;
						let thisVal = null;
						$(this).find("input").each(function(i,v) {
							if($(v).hasClass("mapKey")){
								thisKey = $(v).val();
							}else{
								thisVal = $(v).val();
								thisInputMap.set(thisKey,thisVal);
							}
						});
						thisProductModel['productDetailAttrs'] = Object.fromEntries(thisInputMap);
						productModelsArray.push(thisProductModel);
						thisProductModel = Object.assign({}, resetProductModel);
					}
				});
				return productModelsArray;
			}
		</script>
	
      <main class="container page" id="container">
         <div class="inr">
            <!-- 본문 -->
            <div class="contents" id="contents">
           	 	<div class="pageHeadMo">
					<div class="hdt" style=";">
						<h3 class="tit">[ Adbrix 설명]</h3>
					</div>
					<br/>
				</div>
            	<p>1. adbrix.js의 각 업무별 데이터의 하위 항목을 입력합니다.</p>
            	<p>- 업무별 데이터명 >> 회원가입:onUserRegisterData, 상품 보기:onProductViewData, 상품검색:onSearchData,  장바구니 담기:onAddToCartData, 최초결제 완료:onFirstPurchaseData, 결제완료:onPurchaseData</p>
            	<p>2. toNativeAdbrix(업무별 데이터) 호출합니다.</p>
            
               	<br/>
               	<div class="pageHeadMo">
					<div class="hdt" style=";">
						<h3 class="tit">[ Adbrix TEST ]</h3>
					</div>
					<br/>
				</div>
				<form id="appDataForm">
					<table style="border: #ecedef solid 1px; border-collapse: collapse;">
						<caption>애드브릭스</caption>
						<colgroup>
							<col>
							<col>
							<col style="text-align: center;">
						</colgroup>
						<tr>
							<th>구 분</th>
							<th>요 약</th>
							<th>상 세</th>
						</tr>
						<tr>
							<th>회원가입</th>
							<td>
								<p>회원가입이 최종 완료된 시점에 정보 전달</p>
							</td>
							<td>
								<button type="button" onclick="ui.popLayer.open('onUserRegister')" class="btn sm b">회원가입 확인</button>
							</td>
						</tr>
						<tr>
							<th>상품보기</th>
							<td>
								<p>상품 상세보기한 시점에 정보 전달</p>
							</td>
							<td>
								<button type="button" onclick="ui.popLayer.open('onProductView')" class="btn sm b">상품보기 확인</button>
							</td>
						</tr>
						<tr>
							<th>상품검색</th>
							<td>
								<p>상품명을 검색한 시점에 정보 전달</p>
							</td>
							<td>
								<button type="button" onclick="ui.popLayer.open('onSearch')" class="btn sm b">상품검색 확인</button>
							</td>
						</tr>
						<tr>
							<th>장바구니 담기</th>
							<td>
								<p>장바구니 담기가 완료된 시점에 정보 전달</p>
							</td>
							<td>
								<button type="button" onclick="ui.popLayer.open('adbrixCartPop')" class="btn sm b">장바구니 담기 확인</button>
							</td>
						</tr>
						<tr>
							<th>최초결제 완료</th>
							<td>
								<p>최초 결제가 완료된 시점에 정보 전달</p>
							</td>
							<td>
								<button type="button" onclick="ui.popLayer.open('adbrixFirstBuyPop')" class="btn sm b">최초결제 완료 확인</button>
							</td>
						</tr>
						<tr>
							<th>결제 완료</th>
							<td>
								<p>결제 완료된 시점에 정보 전달</p>
							</td>
							<td>
								<button type="button" onclick="ui.popLayer.open('adbrixBuyPop')" class="btn sm b">결제 완료 확인</button>
							</td>
						</tr>
					</table>
				</form>
            </div>
         </div>
      </main>
       <div class="layers">
         <!-- S: 애드브릭스 설명-->
         <!-- 회원 가입 -->
         <article class="popLayer a onUserRegister" id="onUserRegister" >
            <div class="pbd">
               <div class="phd">
                  <div class="in">
                     <h1 class="tit">회원 가입</h1>
                     <button type="button" class="btnPopClose">닫기</button>
                  </div>
               </div>
               <div class="pct">
                  <main class="poptents">
                     <p>회원가입이 최종 완료된 시점에 정보 전달</p>
                     <P>호출 함수 : toNativeAdbrix(onUserRegisterData)</P>
                     <p>필수 : func</p>
                     <P>옵션 : SignUpChnnel, eventAttrs</P>
                     <br/>
                     <div>
                        <div>
                           <form name="onUserRegisterForm" id="onUserRegisterForm" >
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
                                    <th>SignUpChnnel</th>
                                    <td>
                                       <select id="SignUpChnnel">
											<option value="">SignUpChnnel 선택</option>
											<option value="1">Kakao</option>
											<option value="2">Naver</option>
											<option value="3">Line</option>
											<option value="4">Google</option>
											<option value="5">Facebook</option>
											<option value="6">Twitter</option>
											<option value="7">WhatsApp</option>
											<option value="8">QQChnnel</option>
											<option value="9">WeChat</option>
											<option value="10">UserId</option>
											<option value="11">ETC</option>
											<option value="12">SKT</option>
											<option value="13">AppleId</option>
											
										</select>
                                    </td>
                                    <td>
                                    	Kakao:1, Naver:2, Line:3, Google:4, Facebook:5, Twitter:6, WhatsApp:7, QQChnnel:8, WeChat:9, UserId:10, ETC:11, SKT:12, AppleId:13
                                    </td>
                                 </tr>
                                 <tr>
                                    <th>eventAttrs</th>
                                    <td class="mapArea">
                                    </td>
                                    <td>
                                    	필요 key, value 입력
                                    </td>
                                 </tr>
                              </table>
                              <br>	                       
                              <button type="button" class="btn" onclick="callFunc('onUserRegister');" >Call</button>
                           </form>
                        </div>
                     </div>
                  </main>
               </div>
            </div>
         </article>
         <!-- 상품 보기 -->
         <article class="popLayer a onProductView" id="onProductView" >
            <div class="pbd">
               <div class="phd">
                  <div class="in">
                     <h1 class="tit">상품 보기</h1>
                     <button type="button" class="btnPopClose">닫기</button>
                  </div>
               </div>
               <div class="pct">
                  <main class="poptents">
                     <p>상품 상세보기한 시점에 정보 전달</p>
                     <P>호출 함수 : toNativeAdbrix(onProductViewData)</P>
                     <p>필수 : func, productId, productName, price, quantity, discount, currency</p>
                     <P>옵션 : category (구매상품 카테고리 정보), productDetailAttrs, eventAttrs</P>
                     <br/>
                     <div>
                        <div>
                           <form name="onProductViewForm" id="onProductViewForm" >
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
                                    <th>*상품아이디</th>
                                    <td>
                                       <input name="productId" type="text" placeholder="*상품아이디">
                                    </td>
                                    <td></td>
                                 </tr>
                                 <tr>
                                    <th>*상품명</th>
                                    <td>
                                       <input name="productName" type="text" placeholder="*상품명">
                                    </td>
                                    <td></td>
                                 </tr>
                                 <tr>
                                    <th>*상품단가</th>
                                    <td>
                                       <input name="price" type="text" placeholder="*상품단가">
                                    </td>
                                    <td></td>
                                 </tr>
                                 <tr>
                                    <th>*구매수량</th>
                                    <td>
                                       <input name="quantity" type="text" placeholder="*구매수량">
                                    </td>
                                    <td></td>
                                 </tr>
                                 <tr>
                                    <th>*할인</th>
                                    <td>
                                       <input name="discount" type="text" placeholder="*할인">
                                    </td>
                                    <td>long</td>
                                 </tr>
                                 <tr>
                                    <th>*currency</th>
                                    <td>
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
                                 <tr>
                                    <th>상품 카테고리(A.B.C.D.E)</th>
                                    <td class="arrayArea">
                                    </td>
                                    <td></td>
                                 </tr>
                                 <tr class="prod">
                                    <th>productDetailAttrs</th>
                                    <td class="mapArea">
                                    </td>
                                    <td>이벤트 정보를 추가로 보내는 경우 사용</td>
                                 </tr>
                                 <tr class="event">
                                    <th>eventAttrs</th>
                                    <td class="mapArea">
                                    </td>
                                    <td>
                                    	필요 key, value 입력
                                    </td>
                                 </tr>
                              </table>
                              <br>	                       
                              <button type="button" class="btn sm b" onclick="callFunc('onProductView');">Call</button>
                           </form>
                        </div>
                     </div>
                  </main>
               </div>
            </div>
         </article>
         <!-- 상품검색 -->
         <article class="popLayer a onSearch" id="onSearch" >
            <div class="pbd">
               <div class="phd">
                  <div class="in">
                     <h1 class="tit">상품 검색</h1>
                     <button type="button" class="btnPopClose">닫기</button>
                  </div>
               </div>
               <div class="pct">
                  <main class="poptents">
                     <p>상품명을 검색한 시점에 정보 전달</p>
                     <P>호출 함수 : toNativeAdbrix(onSearchData)</P>
                     <p>필수 : func, keyword, productId, productName, price, quantity, discount, currency</p>
                     <P>옵션 : category (구매상품 카테고리 정보), productDetailAttrs, eventAttrs</P>
                     <P>비고 : 검색 결과 상위 5건 까지</P>
                     <br/>
                     <div>
                        <div>
                           <form name="onSearchForm" id="onSearchForm" >
                              <table>
                                 <colgroup>
                                    <col width="10%">
                                    <col width="10%">
                                    <col width="40%">
                                    <col width="40%">
                                 </colgroup>
                                 <tr>
                                 	<th colspan="2">항목</th>
                                 	<th>입력값</th>
                                 	<th>비고</th>
                                 </tr>
                                 <tr>
                                    <th colspan="2">*키워드</th>
                                    <td>
                                       <input name="keyword" type="text" placeholder="키워드">
                                    </td>
                                    <td></td>
                                 </tr>
                                 <jsp:include page="/WEB-INF/view/sample/sampleAdbrixProdHtml.jsp">
                                 	<jsp:param value="0" name="prdIdx"/>
                                 </jsp:include>
                                 <tr class="event">
                                    <th colspan="2">eventAttrs</th>
                                    <td class="mapArea">
                                    </td>
                                    <td>
                                    	필요 key, value 입력
                                    </td>
                                 </tr>
                              </table>
                              <br>	                       
                              <button type="button" class="btn sm b" onclick="callFunc('onSearch');">Call</button>
                           </form>
                        </div>
                     </div>
                  </main>
               </div>
            </div>
         </article>
         <!-- 장바구니 담기 -->
         <article class="popLayer a adbrixCartPop" id="adbrixCartPop" >
            <div class="pbd">
               <div class="phd">
                  <div class="in">
                     <h1 class="tit">장바구니 담기</h1>
                     <button type="button" class="btnPopClose">닫기</button>
                  </div>
               </div>
               <div class="pct">
                  <main class="poptents">
                     <p>장바구니 담기가 완료된 시점에 정보 전달</p>
                     <P>호출 함수 : toNativeAdbrix(onAddToCartData)</P>
                     <p>필수 : func, productId, productName, price, quantity, currency</p>
                     <P>옵션 : category (구매상품 카테고리 정보), productDetailAttrs, eventAttrs</P>
                     <br/>
                     <div>
                        <div>
                           <form name="onAddToCartForm" id="onAddToCartForm" >
                              <table>
                                 <colgroup>
                                    <col width="10%">
                                    <col width="10%">
                                    <col width="40%">
                                    <col width="40%">
                                 </colgroup>
                                  <tr>
                                 	<th colspan="2">항목</th>
                                 	<th>입력값</th>
                                 	<th>비고</th>
                                 </tr>
                                 <jsp:include page="/WEB-INF/view/sample/sampleAdbrixProdHtml.jsp">
                                 	<jsp:param value="0" name="prdIdx"/>
                                 </jsp:include>
                                 <tr class="event">
                                    <th>eventAttrs</th>
                                    <td class="mapArea">
                                    </td>
                                    <td>
                                    	필요 key, value 입력
                                    </td>
                                 </tr>
                              </table>
                              <br>	                       
                              <button type="button" class="btn sm b" onclick="callFunc('onAddToCart');">Call</button>
                           </form>
                        </div>
                     </div>
                  </main>
               </div>
            </div>
         </article>
         <!-- 최초결제 완료 -->
         <article class="popLayer a adbrixFirstBuyPop" id="adbrixFirstBuyPop" >
            <div class="pbd">
               <div class="phd">
                  <div class="in">
                     <h1 class="tit">최초결제 완료</h1>
                     <button type="button" class="btnPopClose">닫기</button>
                  </div>
               </div>
               <div class="pct">
                  <main class="poptents">
                     <p>최초 결제가 완료된 시점에 정보 전달</p>
                     <P>호출 함수 : toNativeAdbrix(onFirstPurchaseData)</P>
                     <p>필수 : func</p>
                     <P>옵션 : eventAttrs</P>
                     <br/>
                     <div>
                        <div>
                           <form name="onFirstPurchaseForm" id="onFirstPurchaseForm" >
                              <table>
                                 <colgroup>
                                   	<col width="10%">
                                    <col width="10%">
                                    <col width="40%">
                                    <col width="40%">
                                 </colgroup>
                                  <tr>
                                 	<th>항목</th>
                                 	<th>입력값</th>
                                 	<th>비고</th>
                                 </tr>
                                 <tr class="event">
                                    <th>eventAttrs</th>
                                    <td class="mapArea">
                                    </td>
                                    <td>
                                    	필요 key, value 입력
                                    </td>
                                 </tr>
                              </table>
                              <br>	                       
                              <button type="button" class="btn sm b" onclick="callFunc('onFirstPurchase');" >Call</button>
                           </form>
                        </div>
                     </div>
                  </main>
               </div>
            </div>
         </article>
         <!-- 결제 완료 -->
         <article class="popLayer a adbrixBuyPop" id="adbrixBuyPop" >
            <div class="pbd">
               <div class="phd">
                  <div class="in">
                     <h1 class="tit">결제 완료</h1>
                     <button type="button" class="btnPopClose">닫기</button>
                  </div>
               </div>
               <div class="pct">
                  <main class="poptents">
                     <p>결제가 완료된 시점에 정보 전달</p>
                     <P>호출 함수 : toNativeAdbrix(onPurchaseData)</P>
                     <p>필수 : orderId, orderSales, discount, deliveryCharge, paymentMethod, productId, productName, price, quantity, discount, currency, firstYn(eventAttrs에 추가)</p>
                     <P>옵션 : categorys, productDetailAttrs</P>
                     <br/>
                     <div>
                        <div>
                           <form name="onPurchaseForm" id="onPurchaseForm" >
                              <table>
                                 <colgroup>
                                    <col style="width: 200px;">
                                    <col>
                                 </colgroup>
                                  <tr>
                                 	<th colspan="2">항목</th>
                                 	<th>입력값</th>
                                 	<th>비고</th>
                                 </tr>
                                 <tr>
                                    <th colspan="2">*주문번호</th>
                                    <td>
                                       <input name="orderId" type="text" placeholder="*주문번호">
                                    </td>
                                    <td></td>
                                 </tr>                                 
                                 <tr>
                                    <th colspan="2">*주문가격</th>
                                    <td>
                                       <input name="orderSales" type="text" placeholder="*주문가격">
                                    </td>
                                    <td></td>
                                 </tr>                                
                                 <tr>
                                    <th colspan="2">*할인</th>
                                    <td>
                                       <input name="discount" type="text" placeholder="*할인">
                                    </td>
                                    <td></td>
                                 </tr>                                 
                                 <tr>
                                    <th colspan="2">*deliveryCharge</th>
                                    <td>
                                       <input name="deliveryCharge" type="text" placeholder="*deliveryCharge">
                                    </td>
                                    <td></td>
                                 </tr>
                                 <tr>
                                    <th colspan="2">*paymentMethod</th>
                                    <td>
                                        <select id="paymentMethod">
											<option value="">paymentMethod 선택</option>
											<option value="1">CreditCard</option>
											<option value="2">BankTransfer</option>
											<option value="3">MobilePayment</option>
											<option value="4">ETC</option>
										</select>
                                    </td>
                                    <td></td>
                                 </tr>
                                 <jsp:include page="/WEB-INF/view/sample/sampleAdbrixProdHtml.jsp">
                                 	<jsp:param value="0" name="prdIdx"/>
                                 </jsp:include>
                                 <tr class="event">
                                    <th colspan="2">eventAttrs</th>
                                    <td class="mapArea needFirstYn">
                                    </td>
                                    <td>
                                    	필요 key, value 입력
                                    </td>
                                 </tr>                                 
                              </table>
                              <br>	                       
                              <button type="button" class="btn sm b" onclick="callFunc('onPurchase');" >Call</button>
                           </form>
                        </div>
                     </div>
                  </main>
               </div>
            </div>
         </article>
         <!-- E: 애드브릭스 설명 -->
      </div>
   </tiles:putAttribute>
</tiles:insertDefinition>