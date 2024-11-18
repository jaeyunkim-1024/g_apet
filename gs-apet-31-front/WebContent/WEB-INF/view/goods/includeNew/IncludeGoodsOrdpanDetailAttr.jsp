<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ page import="framework.front.constants.FrontConstants" %>
<script type="text/javascript">
	$(document).ready(function(){
		console.log("goodsId : ${goods.goodsId}, goodsCstrtTp : ${goods.goodsCstrtTpCd}");
		
		var goodsCstrtTpCd = "${goods.goodsCstrtTpCd}";

		if(goodsCstrtTpCd == "PAK"){
			fnSelectPakGoodsList("N");
		}
		
	});

	var fnOption = {
		choose : function (attrNo, obj, attrVal, itemNo){
			var attrValNo = $(obj).val();

			$("#selected_attrValNo_"+attrNo).val(attrValNo);
			$("#selected_attrVal_"+attrNo).val(attrVal);

		},
		check : function (){
			var addFlag = true;

			// 옵션이 모두 선택되었는지 확인
			$("[id^=selected_attrValNo_]").each(function(index){
				if($(this).val() == ""){
					addFlag = false;
					ui.alert("옵션을 선택하세요.");

				}
			});

			if(addFlag){
				if ("${param.mode}" == "order") {
					fnOption.update();
				} else {
					fnOption.exChange();
				}
			}
		}
		, exPaksAdd : function (type, rownum, itemNo, saleAmt, imgPath, cstrtShowNm, subGoodsId, minOrdQty, maxOrdQty, ordmkiYn, cnt, salePsbCd, openFlag, ioAlmYn, orgSaleAmt, detailSelAttrVals){
			
			
			
			var optionSelAttrVals = $("#optionSelAttrVals").val();
			
			// 상세에서 상품선택시.
			if(openFlag == "DETAILSEL"){
				$("#uiPdOrdPan").addClass("open");
				$("#cartNavs").addClass("open");
				
				optionSelAttrVals = detailSelAttrVals;
			}

			var addType = type;
			if(type == 'btn'){
				var btnPakSelected = $("#btnPakSelected"+itemNo).hasClass("a sm");
				if(btnPakSelected === true) {
					addType = "remove"; // 버튼 2번 클릭시 삭제 처리.
				}else{
					addType = "add";
				}
			}else{
				if(salePsbCd != "00" && addType == "add"){	// 판매가능상품 일때만 장바구니 담기
					if(salePsbCd == '10'){
						ui.alert("판매중지되어 구매할 수 없는 상품이에요.");
					}else if(salePsbCd == '30'){
						ui.alert("품절되어 구매할 수 없는 상품이에요.");
					}else{
						ui.alert("판매종료되어 구매할 수 없는 상품이에요.");
					}
					return;
				}
			}
			var dataObj = {};
			dataObj.rownum 			= rownum;
			dataObj.itemNo 			= itemNo;
			dataObj.imgPath 		= imgPath;
			dataObj.cstrtShowNm 	= cstrtShowNm;
			dataObj.subGoodsId 		= subGoodsId;
			dataObj.saleAmt 		= saleAmt;
			dataObj.orgSaleAmt		= orgSaleAmt;
			dataObj.minOrdQty 		= minOrdQty ? minOrdQty : 1;
			dataObj.maxOrdQty 		= maxOrdQty ? maxOrdQty : 999;
			//dataObj.unit 			= $("#uispinerUnitLeft" + itemNo).val(); // 개수
			dataObj.unit 			= 1; // 개수
			dataObj.ordmkiYn		= ordmkiYn;
			dataObj.salePsbCd		= salePsbCd;
			dataObj.ioAlmYn			= ioAlmYn;
			dataObj.goodsCstrtTpCd	= "${goods.goodsCstrtTpCd}";
			dataObj.optionSelAttrVals = optionSelAttrVals;
			//dataObj.ordmkiContent	= $("#inputOrdmki_"+cnt).val(); 
			// console.log("itemNo : " + itemNo + ", dataObj : " + JSON.stringify(dataObj));
			fnPaksRight(dataObj, addType);
			
			// 선택옵션 text 초기화
			$("#optionSelAttrVals").val("");
			
			$(document).off("click", ".uispiner .bt");
			$(document).off("click", ".uispiner .plus");
			$(document).on("click",".uispiner .plus",function(e){
				e.preventDefault();

				var $qtyObj = $(this).siblings(".amt");
				var maxOrdQty = $qtyObj.data("maxOrdQty") ? $qtyObj.data("maxOrdQty") : 999;
				
				var ordmkiYn = $qtyObj.data("ordmkiYn") ? $qtyObj.data("ordmkiYn") : "N";

				if (!maxOrdQty || parseInt($qtyObj.val()) < maxOrdQty) {
					var cartQty = parseInt($qtyObj.val()) + 1;
					//var cartQty = parseInt($qtyObj.val());
					var itemNo = $qtyObj.data("itemNo");
		 			//$("#buyQty" + itemNo).attr("value", cartQty);
					$("#buyQty" + itemNo).val(cartQty).attr("value",cartQty); // 사용하지말것.
					var goodsCstrtTpCd = "${goods.goodsCstrtTpCd}";
					//console.log("goodsCstrtTpCd : " + goodsCstrtTpCd + ", itemNo : " + itemNo + ", cartQty : " + cartQty);
					if(ordmkiYn == "Y"){	// 각인여부
						indexOrdpan++;
						if(!document.getElementById('spanOrdmki_'+ itemNo + '_' + cartQty)){
							var spanText = "";
							var n2Class = "";
							if(9 < cartQty){
								n2Class = "n2";
							}
							spanText += "<span class='input nms"+n2Class+"' id='spanOrdmki_"+itemNo+"_"+cartQty+"'>";
							spanText += "	<i class='n'>"+cartQty+".</i><input type='text' name='inputOrdmki' id='inputOrdmki_"+itemNo+"_"+cartQty+"' placeholder='각인문구를 입력해주세요' title='각인문구' value='' maxlength='40' onkeydown='javascript:fnCheckOrdmkiTextLength(this);'>";
							spanText += "</span>";
							//$("#divOrdmki_"+cartQty-1).html($("#divOrdmki_"+cartQty).html() + spanText);
							var gudText = "<div class='gud'>상품을 담기전에 입력하신 내용을 한번 더 확인해주세요.</div>";
							$("#divOrdmki_"+itemNo + " .gud").remove();
							$("#divOrdmki_"+itemNo).append(spanText + gudText);
						}
					}
					
					if(goodsCstrtTpCd == "ITEM" || goodsCstrtTpCd == "SET"){
						fnClickItemTotalCnt(itemNo, cartQty);
					}else if(goodsCstrtTpCd == "PAK" || goodsCstrtTpCd == "ATTR"){
						var originSaleAmt = $qtyObj.data("saleAmt");
						fnClickPaksTotalCnt(itemNo, cartQty, originSaleAmt);
					}
				}else{
					fnGoodsUiToast("최대 " + maxOrdQty + "개까지 구매할 수 있어요", "maxOrdQty");
					return;
				}
			});
			
			$(document).off("click", ".uispiner .bt");
			$(document).off("click", ".uispiner .minus");
			$(document).on("click",".uispiner .minus",function(e){
				e.preventDefault();

				var $qtyObj = $(this).siblings(".amt");
				var minOrdQty = $qtyObj.data("minOrdQty") ? $qtyObj.data("minOrdQty") : 1;
				var ordmkiYn = $qtyObj.data("ordmkiYn") ? $qtyObj.data("ordmkiYn") : "N";
				if (parseInt($qtyObj.val()) > minOrdQty) {
					var cartQty = parseInt($qtyObj.val()) - 1;
					//var cartQty = parseInt($qtyObj.val());
					var itemNo = $qtyObj.data("itemNo");
		 			//$("#buyQty" + itemNo).attr("value",cartQty);
					$("#buyQty" + itemNo).val(cartQty).attr("value",cartQty); // 사용하지말것.
					if(indexOrdpan <= 0){
						indexOrdpan = 1;
					}else{
						indexOrdpan--;
					}

					var goodsCstrtTpCd = "${goods.goodsCstrtTpCd}";
					//console.log("goodsCstrtTpCd : " + goodsCstrtTpCd + ", itemNo : " + itemNo + ", cartQty : " + cartQty);

					if(ordmkiYn == "Y"){
						$("[id^=spanOrdmki_" + itemNo + "_]").each(function(index){
							var idx = index + 1;
							if(cartQty < idx){
								$(this).remove();
							}
						});
					}
					
					if(goodsCstrtTpCd == "ITEM" || goodsCstrtTpCd == "SET"){
						fnClickItemTotalCnt(itemNo, cartQty);
						
					}else if(goodsCstrtTpCd == "PAK" || goodsCstrtTpCd == "ATTR"){
						var originSaleAmt = $qtyObj.data("saleAmt");
						fnClickPaksTotalCnt(itemNo, cartQty, originSaleAmt);
					}
				}else{
					fnGoodsUiToast("최소 " + minOrdQty + "개 이상 구매할 수 있어요", "maxOrdQty");
				}
			});
			
		}
		, exChange : function (itemNo, type){

			var data = [];
			$("[id^=selected_attrValNo_]").each(function(index){

				var dataObj = {};
				console.log("index : " + index + ", listPaks obj ; " + JSON.stringify(obj));
				dataObj.attrNo 		= $("[id^=selected_attrNo_]").eq(index).val();
				dataObj.attrValNo 	= $(this).val();
				dataObj.attrVal 	= $("[id^=selected_attrVal_]").eq(index).val();
				dataObj.itemNo 		= itemNo;
				dataObj.unit 		= 1;
				dataObj.obj 		= obj;
				data.push(dataObj);
			});

		}
	};
	
	function fnCheckSoldOutYn(obj){

		var goodsCstrtTpCd = "${goods.goodsCstrtTpCd}";
		var soldOutExceptYn = "N";
		
		if(obj.checked){
			soldOutExceptYn = "Y";
		}
		
		if(goodsCstrtTpCd == "PAK"){
			fnSelectPakGoodsList(soldOutExceptYn);
		}else if(goodsCstrtTpCd == "ATTR"){
			var optionCnt = $("#optionCnt").val();
			
			$("#soldOutExceptYn").val(soldOutExceptYn);
			// 옵션목록 초기화.
			$("#attrNo").val($("#attr1No").val());
			$("#attrIdx").val("");
			
			for(var i=1; i <= optionCnt; i++){
				
				$("#attr"+i+"ValNo").val("");
				
				// 옵션상품은 '옵션을 선택해주세요'가 아닌 옵션명을 셋팅한다. 
				$("#optsetsVal"+i).text( $("#cstrTpAttrNm"+i).val());
				
				if(i == 1 ){
					$("#divOptsets"+i).addClass("open");
				}else{
					$("#divOptsets"+i).removeClass("open");
					$("#optionSetList"+i).empty();
				}
			}
			ajax.load("optionSetList1", "/goods/getOptionSetList", $("#optionGoodsForm").serializeJson());
		}
	}
	
	function fnOptionselect(attrNo, attrValNo, attrVal, subGoodsId){
		
		$("#subGoodsId").val(subGoodsId);
		
		var idx = $("#listAttrsCount"+attrNo).val();
		var soldOutExceptYn = "N";
		
		if($("#chkSoldOutExceptYn").is(":checked")){
			soldOutExceptYn = "Y";
		}
		
		$("#soldOutExceptYn").val(soldOutExceptYn);
		var optionCnt = $("#optionCnt").val();
		var nextidx = Number(idx) + 1;
		
		if(attrValNo != "" && idx != ""){
			$("#attrNo").val($("#attr"+nextidx+"No").val());
			$("#attr"+idx+"ValNo").val(attrValNo);
			$("#optsetsVal"+idx).text(attrVal);
			$("#attrIdx").val(idx);
		}

		var resultCallCheck = true;
		var optionSelAttrVals = "";
		
		var goodsCstrtTpCd = "${goods.goodsCstrtTpCd}";
		
		for(var i = 1; i <= optionCnt; i++){
			// 옵션값이 다 설정 되지 않으면 조회 하지 않음.
			if($("#attr"+i+"ValNo").val() == ""){
				resultCallCheck = false;
			}
			
			if(idx < i){
				$("#attr"+i+"ValNo").val("");
			
				if( goodsCstrtTpCd == "ATTR") {
					// 옵션상품은 '옵션을 선택해주세요'가 아닌 옵션명을 셋팅한다. 
				    $("#optsetsVal"+i).text( $("#cstrTpAttrNm"+i).val());
				} else {
					$("#optsetsVal"+i).text("옵션을 선택해 주세요");
				}
			}
			
			if(i != 1){
				optionSelAttrVals += " / "; 
			}
			optionSelAttrVals += $("#optsetsVal"+i).text();
		}

		if(idx < optionCnt){
			ajax.load("optionSetList"+nextidx, "/goods/getOptionSetList", $("#optionGoodsForm").serializeJson());	
			// next 옵션목록 자동 open
			$("#divOptsets"+nextidx).addClass("open");
		}	
		
			
		if(resultCallCheck){
			$("#optionSelAttrVals").val(optionSelAttrVals);
			fnOptionSelectResult(optionCnt);
		}
	}
	
	function fnOptionSelectResult(optionCnt){

		ajax.load("optionGoodsList", "/goods/getOptionGoodsList", $("#optionGoodsForm").serializeJson());
		
		var goodsCstrtTpCd = "${goods.goodsCstrtTpCd}";
		
		// 옵션값으로 조회후 초기화.
		for(var i = 1; i <= optionCnt; i++){
			$("#attr"+i+"ValNo").val("");
			 
			if( goodsCstrtTpCd == "ATTR") {
				// 옵션상품은 '옵션을 선택해주세요'가 아닌 옵션명을 셋팅한다. 
			    $("#optsetsVal"+i).text( $("#cstrTpAttrNm"+i).val());
			} else {
				$("#optsetsVal"+i).text("옵션을 선택해 주세요");
			}
			
			$("#divOptsets"+i).removeClass("open");
			if(i != 1){
				$("#optionSetList"+i).empty();
			}
		}
	}; 
	
	function fnSelectPakGoodsList(soldOutExceptYn){
		$("#soldOutExceptYn").val(soldOutExceptYn);
		ajax.load("cstrtPakGoodsList", "/goods/getPakGoodsList", $("#pakGoodsForm").serializeJson());
	}

</script>

<c:if test="${goods.goodsCstrtTpCd eq FrontConstants.GOODS_CSTRT_TP_ITEM or goods.goodsCstrtTpCd eq FrontConstants.GOODS_CSTRT_TP_SET}">
	<!-- 단품/세트 상품 -->
	<div class="cdt cdt_l">
		<div class="optresul" style="min-width: 50%">
			<ul class="list">
				<li>
					<div class="unitRes">
						<a href="javascript:" class="box">
							<!-- <button type="button" class="bt del">삭제</button> -->
							<div class="infs">
								<span class="lk wb_bAll_k0426">${goods.goodsNm}</span>
							</div>	
						</a>
						<div class="cots">
							<div class="uispiner" >
						<%--	<input type="text" value="1" class="amt" step="1" id="inputPriceItemCnt" name="inputPriceItemCnt">--%>
								<input type="text" value="${goods.minOrdQty}" class="amt"
									   id="buyQty${listItems.itemNo}" name="buyQty" onblur="fnChangebuyQty(this)"
									   onkeyup="this.value=this.value.replace(/[^0-9]/g, '');" 
									   data-item-no="${listItems.itemNo}"
									   data-min-ord-qty="${goods.minOrdQty}"
									   data-max-ord-qty="${goods.maxOrdQty}"
									   data-ordmki-yn="${listItems.ordmkiYn}">
						<%--		   data-content="" data-url=""--%>
								<button type="button" class="bt minus" >수량빼기</button>
								<button type="button" class="bt plus" >수량더하기</button>
							</div>
							<div class="price">
								<em class="p" id="emPriceTotalAmtItem"><fmt:formatNumber type="number" value="${listItems.saleAmt * goods.minOrdQty}"/></em><i class="w">원</i>
							</div>
						</div>
						<c:if test="${goods.goodsCstrtTpCd eq FrontConstants.GOODS_CSTRT_TP_ITEM and listItems.ordmkiYn == 'Y'}">
							<div class="msgs" id="divOrdmki_${listItems.itemNo}">
								<c:forEach begin="1" end="${goods.minOrdQty}" varStatus="status">
									<span class="input nms <c:if test="${status.count > 9}">n2</c:if> " id="spanOrdmki_${listItems.itemNo}_${status.count}"><i class="n">${status.count}.</i><input type="text" name='inputOrdmki' id="inputOrdmki_${listItems.itemNo}_${status.count}" placeholder="각인문구를 입력해주세요" title="각인문구" value="" maxlength="40" onkeydown='javascript:fnCheckOrdmkiTextLength(this);'></span>
									<c:if test="${status.last}">
										<div class="gud">상품을 담기전에 입력하신 내용을 한번 더 확인해주세요.</div>
									</c:if>
								</c:forEach>
							</div>
						</c:if>
					</div>
				</li>
			</ul>
		</div>
	</div>
	
</c:if>
				
<c:if test="${goods.goodsCstrtTpCd ne FrontConstants.GOODS_CSTRT_TP_ITEM and goods.goodsCstrtTpCd ne FrontConstants.GOODS_CSTRT_TP_SET}">
	<!-- 단품&세트인경우 품절 제외 버튼 무시. -->
	<div class="outof"><label class="checkbox"><input type="checkbox" name="chkSoldOutExceptYn" id="chkSoldOutExceptYn" value="Y" onchange="javascript:fnCheckSoldOutYn(this);" ><span class="txt">품절제외</span></label></div>
	<div class="cdt cdt_l">

	<c:if test="${goods.goodsCstrtTpCd eq FrontConstants.GOODS_CSTRT_TP_PAK}">
		<!-- 묶음 START -->
		<form id="pakGoodsForm" method="post">
			<input type="hidden" id="goodsId" name="goodsId" value="${goods.goodsId}" />
			<input type="hidden" id="saleAmt" name="saleAmt" value="${goods.saleAmt}" />
			<input type="hidden" id="soldOutExceptYn" name="soldOutExceptYn" value="N" />
		</form>
		<div class="optsets open">
			<button type="button" class="btnsel">옵션을 선택해 주세요</button>
			<ul class="list" id="cstrtPakGoodsList">
			</ul>
		</div>
	</c:if>

	<c:if test="${goods.goodsCstrtTpCd eq FrontConstants.GOODS_CSTRT_TP_ATTR}">
		<form id="optionGoodsForm" method="post">
			<input type="hidden" id="goodsId" name="goodsId" value="${goods.goodsId}" />
			<input type="hidden" id="saleAmt" name="saleAmt" value="${goods.saleAmt}" />
			<input type="hidden" id="soldOutExceptYn" name="soldOutExceptYn" value="" />
			<input type="hidden" id="optionCnt" name="optionCnt" value="${fn:length(listAttrs)}" />
			<input type="hidden" id="attrNo" name="attrNo" value="" />
			<input type="hidden" id="optionSelAttrVals" name="optionSelAttrVals" value="" />
			<input type="hidden" id="attrIdx" name="attrIdx" value="" />
			<input type="hidden" id="subGoodsId" name="subGoodsId" value="" />
			
			
			<!-- 옵션 START -->
			<c:forEach items="${listAttrs}" var="listAttrs" varStatus="status">
	<%--			<input type="hidden" id="selected_attrValNo_${obj.attrNo }" name="attrValNos" value="" />--%>
	<%--			<input type="hidden" id="selected_attrVal_${obj.attrNo }" name="attrVals" value="" />--%>
	<%--			<input type="hidden" id="selected_itemNo_${obj.attrNo }" name="itemNos" value="" />--%>
				<div class="optsets <c:if test="${status.first}">open</c:if>" id="divOptsets${status.count}">
					<input type="hidden" id="attr${status.count}No" name="attr${status.count}No" value="${listAttrs.attrNo }" />
					<input type="hidden" id="attr${status.count}ValNo" name="attr${status.count}ValNo" value="" />
					<input type="hidden" id="listAttrsCount${listAttrs.attrNo}" name="listAttrsCount${listAttrs.attrNo}" value="${status.count}"/>

					<c:choose>
					 	<c:when test="${goods.goodsCstrtTpCd eq FrontConstants.GOODS_CSTRT_TP_ATTR}">
					 		<button type="button" class="btnsel" id="optsetsVal${status.count}">${listAttrs.attrNm}</button>
					 		<input type="hidden" id="cstrTpAttrNm${status.count}" value="${listAttrs.attrNm}" disabled>
					 	</c:when>
					 	<c:otherwise>
					 		<button type="button" class="btnsel" id="optsetsVal${status.count}">옵션을 선택해 주세요</button>
					 	</c:otherwise>
					 </c:choose>
					
					 <ul class="list" id="optionSetList${status.count}">
						<c:if test="${status.first}">
							<c:forEach items="${listAttrs.attributeValueList}" var="obj" varStatus="objStatus">
								<c:if test="${listAttrs.attrNo eq obj.attrNo }">
									<li>
										<div class="unitSel" >
											<a class="box" href="javascript:" onclick="javascript:fnOptionselect('${obj.attrNo}', '${obj.attrValNo}', '${obj.attrVal}', '${obj.goodsId}')">
												<div class="infs">
													<span class="lk" style="word-break:break-all;" >${obj.attrVal}
														<c:if test="${obj.saleAmt ne ''}">
															<c:choose>
																<%-- ${goods.orgSaleAmt} --%>
																<c:when test="${obj.saleAmt > goods.saleAmt}">
																	(+<fmt:formatNumber value="${(obj.saleAmt - goods.saleAmt)}" type="percent" pattern="#,###,###"/>원)
																</c:when>
																<c:when test="${obj.saleAmt < goods.saleAmt}">
																	(-<fmt:formatNumber value="${(goods.saleAmt - obj.saleAmt)}" type="percent" pattern="#,###,###"/>원)
																</c:when>
															</c:choose>
														</c:if>
													</span>
												</div>
												<c:if test="${obj.saleAmt ne ''}">
													<div class="price">
														<c:if test="${obj.salePsbCd eq frontConstants.SALE_PSB_00}">
															<em class="p"><fmt:formatNumber type="number" value="${obj.saleAmt}" pattern="#,###,###"/></em><i class="w">원</i>
														</c:if>
														<c:if test="${obj.salePsbCd eq frontConstants.SALE_PSB_10}">
															<span class="bt sold">판매중지</span>
														</c:if>
														<c:if test="${obj.salePsbCd eq frontConstants.SALE_PSB_20}">
															<span class="bt sold">판매종료</span>
														</c:if>
														<c:if test="${obj.salePsbCd eq frontConstants.SALE_PSB_30}">
															<c:choose>
																<c:when test="${obj.ioAlmYn eq 'Y'}">
																	<button type="button" class="bt alim">입고알림</button>
																</c:when>
																<c:otherwise>
																	<span class="bt sold"><spring:message code='front.web.view.common.goods.saleSoldOut.title'/></span>
																</c:otherwise>
															</c:choose>
														</c:if>
													</div>
												</c:if>
											</a>
										</div>
									</li>
								</c:if>
							</c:forEach>
						</c:if>
					</ul>
				</div> 
			</c:forEach>
			<!-- 옵션 END -->
			<div class="optresul" style="display:none;">
				<ul class="list" id="optionGoodsList">
				</ul>
			</div>
		</form>	
	</c:if>
	</div>
</c:if>


