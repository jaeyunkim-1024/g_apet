<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ page import="framework.front.constants.FrontConstants" %>
<script type="text/javascript">
	$(document).ready(function(){
	});

	// 묶음, 옵션 처리.
	function fnPaksRight(data, type){
		console.log("fnPaksRight obj : " + JSON.stringify(data));
		var artUiPdOrdPanRight = $("#artUiPdOrdPanRight").html();
		var buyQtyRight = data.minOrdQty;
		if(type == "add"){
			if(!document.getElementById('selected_itemNo_'+data.itemNo)){
				$("#artUiPdOrdPanRight").html(artUiPdOrdPanRight + fnOrdpanRight(data));
				$("#btnPakSelected"+data.itemNo).removeClass("c sm");
				$("#btnPakSelected"+data.itemNo).addClass("a sm");
			}else{  // 동일한 상품인 경우 +1 처리.
				
				if(data.maxOrdQty == $("#buyQty" + data.itemNo).val()){
					fnGoodsUiToast("최대 " + data.maxOrdQty + "개까지 구매할 수 있어요", "maxOrdQty");
					return;
				}
				
				buyQtyRight = Number($("#buyQty" + data.itemNo).val()) + 1;
				$("#buyQty" + data.itemNo).val(buyQtyRight).attr("value",buyQtyRight);
				
				if(data.ordmkiYn == "Y"){

					var spanText = "";
					$("#divOrdmki_" + data.itemNo + " .gud").remove();
					//$("[id^=inputOrdmki_"+itemNo+"_]").remove();
					for(var i = 1; i <= buyQtyRight; i++){
						if(!document.getElementById('spanOrdmki_'+ data.itemNo + '_' + i)){
							var n2Class = "";
							if(9 < i ){
								n2Class = "n2";
							}
							spanText += "<span class='input nms "+n2Class+"' id='spanOrdmki_" + data.itemNo + "_"+i+"'>";
							spanText += "	<i class='n'>" + i + ".</i><input type='text' name='inputOrdmki' id='inputOrdmki_" + data.itemNo + "_" + i + "' placeholder='각인문구를 입력해주세요' title='각인문구' value='' maxlength='40' onchange='javascript:fnCheckOrdmkiTextLength(this);'>";
							spanText += "</span>";
						}
					}
					var gudText = "<div class='gud'>상품을 담기전에 입력하신 내용을 한번 더 확인해주세요.</div>";
					$("#divOrdmki_"+data.itemNo).append(spanText + gudText);
				}
			}

			// 전체 동기화.
			console.log("itemNo : " + data.itemNo + ", buyQtyRight : " + buyQtyRight + ", saleAmt : " + data.saleAmt);
			fnClickPaksTotalCnt(data.itemNo, buyQtyRight, data.saleAmt);
		}else{
			$("#liOrdpanRight" + data.itemNo).remove();
			$("#btnPakSelected"+data.itemNo).removeClass("a sm");
			$("#btnPakSelected"+data.itemNo).addClass("c sm");
			fnClickPaksTotalCnt(data.itemNo, 1, data.saleAmt);
		}
	}
	
	function comma(num){
	    var len, point, str; 
	       
	    num = num + ""; 
	    point = num.length % 3 ;
	    len = num.length; 
	   
	    str = num.substring(0, point); 
	    while (point < len) { 
	        if (str != "") str += ","; 
	        str += num.substring(point, point + 3); 
	        point += 3; 
	    } 
	     
	    return str;
	 
	}

	function fnOrdpanRight(data){
		
		var rn = $("#artUiPdOrdPanRight li").length + 1;
		console.log("### rn : " + rn);
		
		var dataImgPath = data.imgPath;
		// 직사각형을 정사각형으로 변경함. frontConstants.IMG_OPT_QRY_340 >>>> frontConstants.IMG_OPT_QRY_500
		var imgPath = "${frame:optImagePath( '" + dataImgPath + "' , frontConstants.IMG_OPT_QRY_500 )}";
		var noImgPath = "${view.noImgPath}";
		var imgClass = "";
		if(data.goodsCstrtTpCd == "PAK"){
			imgClass = "gpic";	
		}
		
		var diffAmt = "";
		var saleAmt = Number(data.saleAmt);
		var orgSaleAmt = Number(data.orgSaleAmt);
		if(saleAmt > orgSaleAmt){
			diffAmt = "(+" + comma(saleAmt-orgSaleAmt) + "원)";
		}else if(saleAmt < orgSaleAmt){
			diffAmt = "(-" + comma(orgSaleAmt-saleAmt) + "원)";
		}
		
		var text = "";
		text += "<li id='liOrdpanRight"+data.itemNo+"'>                                                                		";
		text += "<input type='hidden' id='selected_itemNo_"+data.itemNo+"' name='itemNos' value='"+data.itemNo+"' />  		";
		text += "<input type='hidden' id='selected_subGoodsId_"+data.itemNo+"' name='goodsIds' value='"+data.subGoodsId+"' />";
		text += "	<div class='unitRes "+imgClass+"'>                                                                       ";
		text += "		<div class='box'>                                                                                	";
		text += "			<button type='button' class='bt del' onclick='fnOption.exPaksAdd(\"remove\", \""+data.rownum+"\", \""+data.itemNo+"\",\""+data.saleAmt+"\")'>삭제</button>	";
		if(data.goodsCstrtTpCd == "PAK"){
			text += "			<div class='thum'>                                                                           	";
			text += "				<div class='pic'><img class='img' src='"+imgPath+"' onerror='this.src=\""+noImgPath+"\"' alt='상품'></div>  						";
			text += "			</div>                                                                                        	";
		}
		text += "			<div class='infs'>                                                                           	";
		text += "				<div class='cate'>상품"+data.rownum+"</div>                                                 	";
		if(data.goodsCstrtTpCd == "PAK"){
			text += "				<a href='javascript:;' class='lk'>"+data.cstrtShowNm + diffAmt+"</a> 									";
		} else {
			text += "				<a href='javascript:;' class='lk'>" + data.optionSelAttrVals + diffAmt + "</a> 									";
		}	
		text += "			</div>                                                                                       	";
		text += "		</div>                                                                                           	";
		text += "		<div class='cots'>                                                                               	";
		text += "			<div class='uispiner'>                                                                          ";
		/* text += "				<input type='text' value='1' name='buyQty' id='buyQty"+data.itemNo+"' class='amt'  disabled='disabled' onchange='javascript:fnChangebuyQty(this);'"; */
		text += "				<input type='text' value='"+data.minOrdQty+"' name='buyQty' id='buyQty"+data.itemNo+"' class='amt' onblur='fnChangebuyQty(this)'";
		text += " 					onkeyup='this.value=this.value.replace(/[^0-9]/g, \"\");'";
		text += "					   data-item-no='"+data.itemNo+"' 							";
		text += "					   data-min-ord-qty='"+data.minOrdQty+"' data-max-ord-qty='"+data.maxOrdQty+"'         	";
		text += "					   data-sale-amt='"+data.saleAmt+"' data-ordmki-yn='"+data.ordmkiYn+"'>         							";
		text += "				<button type='button' class='bt minus'>수량더하기</button>                                  	";
		text += "				<button type='button' class='bt plus'>수량빼기</button>                                     	";
		text += "			</div>                                                                                       	";
		text += "			<div class='price'>                                                                          	";

		if(data.salePsbCd == "${frontConstants.SALE_PSB_00}"){
			text += "				<em class='p' id='buyPriceRight"+data.itemNo+"'>"+data.saleAmt+"</em><i class='w'>원</i>	";	
		}
		if(data.salePsbCd == "${frontConstants.SALE_PSB_10}"){
			text += "<span class='bt sold'>판매중지</span>";
		}
		if(data.salePsbCd == "${frontConstants.SALE_PSB_20}"){
			text += "<span class='bt sold'>판매종료</span>";
		}
		if(data.salePsbCd == "${frontConstants.SALE_PSB_30}"){
			if(data.ioAlmYn == "Y"){
				text += "<button type='button' class='bt alim'>입고알림</button>";
			}else{
				text += "<span class='bt sold'><spring:message code='front.web.view.common.goods.saleSoldOut.title'/></span>";
			}
		}
		text += "				<input type='hidden' id='inputBuyPriceRight"+data.itemNo+"' name='itemNos' value='"+data.saleAmt+"' />  		";
		text += "			</div>                                                                                       	";
		text += "		</div>                                                                                           	";
		if(data.ordmkiYn == "Y"){
			text += "		<div class='msgs' id='divOrdmki_"+data.itemNo+"'>                                                                               	";
			for(var i = 1; i<= data.minOrdQty; i++){
				var n2Class = "";
				if(9 < i ){
					n2Class = "n2";
				}
				text += "			<span class='input nms "+n2Class+"' id='spanOrdmki_"+data.itemNo+"_" + i + "'><i class='n'>" + i + ".</i><input type='text' name='inputOrdmki' id='inputOrdmki_"+data.itemNo+"_" + i + "' placeholder='각인문구를 입력해주세요' title='각인문구' value='' maxlength='40' onkeydown='javascript:fnCheckOrdmkiTextLength(this);'></span>";
				if(i == data.minOrdQty){
					text += "			<div class='gud'>상품을 담기전에 입력하신 내용을 한번 더 확인해주세요.</div>                          	";	
				}
			}

			text += "		</div>                                                                                           	";
		}
		text += "	</div>                                                                                               	";
		text += "</li>";

		return text;
	}
</script>
<%--<div class="cdtwrap">--%>
<c:if test="${goods.goodsCstrtTpCd ne FrontConstants.GOODS_CSTRT_TP_ITEM and goods.goodsCstrtTpCd ne FrontConstants.GOODS_CSTRT_TP_SET}">
	<div class="cdt cdt_r">
		<div class="optresul">
			<ul class="list" id="artUiPdOrdPanRight"></ul>
		</div>
	</div>
</c:if>
<%--</div>--%>

