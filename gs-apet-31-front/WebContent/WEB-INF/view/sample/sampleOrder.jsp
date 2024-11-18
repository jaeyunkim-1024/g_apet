<%--	
 - Class Name	: /sample/sampleCheckView.jsp
 - Description	: 디바이스 / OS / 넓이로 MO및PC 구분 예시
 - Since		: 2020.12.17
 - Author		: KKB
--%>

<tiles:insertDefinition name="common">
	<tiles:putAttribute name="script.inline">
	<script type="text/javascript" 	src="/_script/cart/cart.js"></script>
		<script>
		function openMiniCart() {
			ui.commentBox.open('.type01');
		}	
		
		function chgDeviceGb(deviceGb) {
			let returnUrl =  window.location.href
			location.href = "/common/chgDeviceGb?returnUrl="+returnUrl+"&deviceGb="+deviceGb;
		}
		
		function insertCart(){
			var goodsId = $("#strGoodsId").val();
			var itemNo = $("#strItemNo").val();
			var pakGoodsId = $("#strPakGoodsId").val();
			var buyQty = $("#qty").val();
			var nowBuyYn = "N";
			var goodsIdStr = goodsId + ":" + itemNo + ":" + (pakGoodsId ? pakGoodsId : "");
			
			commonFunc.insertCart(goodsIdStr, 1, "N", function(data){
				if(data.rtnCode == 'S'){
					ui.alert(FRONT_WEB_VIEW_ORDER_CART_MSG_INSERT_CART_SUCCESS);
				}else{
					ui.alert(data.rtnMsg);
				}
				
			});
			
		}
		
		function insertCoupon(){
			var cpNo = $("#cpNo").val();
			var options = {
				url : "/event/insertCoupon"
				, data : {
					cpNo : cpNo
				}
				, done : function(data){
					if(data.resultCode == "S"){
						alert("성공!!");
					}else{
						alert(data.resultMsg);
					}
				}
			};

			ajax.call(options);
			
		}
		
		function getDlvrInfo(){
			
			var options = {
				url : "/sample/sampleDlvrInfo"
				, data : {
					postNo : $("#postNo").val()
				}
				, done : function(data){
					console.log(data);
				}
			};

			ajax.call(options);
			
		}
	</script>
	
	</tiles:putAttribute>
	<tiles:putAttribute name="content">	
	<div class="content">
		<c:if test="${ view.deviceGb eq 'PC'}">
		&emsp;<button type="button" onclick="chgDeviceGb('MO')" class="btn" style="display: inline;">모바일 버젼 보기</button>
		</c:if>
		<c:if test="${ view.deviceGb eq 'MO'}">
		&emsp;<button type="button" onclick="chgDeviceGb('PC')" class="btn" style="display: inline;">PC 버젼 보기</button>	
		</c:if>
		<br/>
		<button type="button" onclick="openMiniCart();" class="btn" style="display: inline;">미니 장바구니</button>
		<br/>
		
		<div style="text-align: center;">
			<!-- 임시 장바구니 담기 -->
			GOODS_ID : <input type="text" id="strGoodsId" value=""/><br/>
			ITEM_NO : <input type="text" id="strItemNo" value=""/><br/>
			PAK_GOODS_ID : <input type="text" id="strPakGoodsId" value=""/><br/>
			수량 : <input type="text" id="qty"/><br/>
			<button type="button" class="bt del" onclick="insertCart()">장바구니 담기</button>
			<br/>
			쿠폰번호 : <input type="text" id="cpNo" value=""/><br/>
			<button type="button" class="bt del" onclick="insertCoupon()">쿠폰 발급</button>
			<br/>
			<br/>
			우편번호 : <input type="text" id="postNo" value=""/><br/>
			<button type="button" class="bt del" onclick="getDlvrInfo()">배송 처리 유형 조회</button>
		</div>
			
	</div>
	</tiles:putAttribute>
<tiles:putAttribute name="layerPop">
	<jsp:include page="/WEB-INF/view/common/goods/popupRelateGoodsAndMiniCart.jsp"/>
</tiles:putAttribute>

	
</tiles:insertDefinition>