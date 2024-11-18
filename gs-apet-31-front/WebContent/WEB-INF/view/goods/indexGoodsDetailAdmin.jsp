<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="/WEB-INF/tld/frame.tld" prefix="frame" %>
<%@ page import="front.web.config.constants.FrontWebConstants" %>
<%@ page import="framework.common.util.StringUtil" %>
<%@ page import="framework.common.enums.ImageGoodsSize" %>

<meta property="og:title" content="<c:out value="${metaGoodsNm }" />">
<meta id="meta_og_image" property="og:image" content=""/>
<meta property="product:price:amount" content="<c:out value="${metaGoodsSaleAmt }"/>">
<meta property="product:price:currency" content="KRW">
<meta property="product:sale_price:amount" content="<c:out value="${metaGoodsDcAmt }"/>">
<meta property="product:sale_price:currency" content="KRW">
<meta name="author" content="<c:out value="${metaAuthor }"/>">
<meta property="product:availability" content="">

<script type="text/javascript"  src="<spring:eval expression="@bizConfig['cdn.domain']" />/_script/jquery/jquery.scrollpath.js" ></script>
<script type="text/javascript"  src="/_script/owl.carousel.js" ></script>

<script type="text/javascript">
	$(document).ready(function(){
		dialog.create("pop_payment_info_layer", {width:800, height:620});
		// 상품문의 영역 호출
		ajax.load("goods_inquiry_area", "/goods/indexGoodsInquiryList", {goodsId : '<c:out value='${goods.goodsId}' />'});
		// 상품평가 영역 호출
		ajax.load("goods_comment_area", "/goods/indexGoodsCommentList", {goodsId : '<c:out value='${goods.goodsId}' />'});

		// 사용자 정의 상품상세 설명 영역
		ajax.load("include_user_define_area", "/goods/indexUserDefine", {});
		
		var optioncheck=new OptionCheck(); 

		$('#time01').countdown('<frame:timestamp date="${hot.saleEndDtm}" dType="S" tType="HS" />', function(event) {
			  $(this).html(event.strftime('%D일 %H:%M:%S'));
		});
		
		// 단품이 한개인 상품은 디폴트로 단품선택
		var itemSize = <c:out value="${itemSize}" />;
		
		// 옵션영역 출력
			// 단품이 하나인 경우 선택박스 없이 자동으로 설정
			if (itemSize == 1) {
				var sGoodsAmt = 0;
				var sSaleAmt='${goods.saleAmt}';
				var sDcAmt = '${goods.saleAmt - goods.dcAmt}';
				var sAddSaleAmt= '<c:out value="${item.addSaleAmt}" />';
				if(sDcAmt != null && sDcAmt>0)
				{
					sGoodsAmt = parseInt(sDcAmt)+parseInt(sAddSaleAmt);
				} else {
					sGoodsAmt = parseInt(sSaleAmt)+parseInt(sAddSaleAmt);
				}
				//goodsSelect.add('${goods.goodsId}','${goods.goodsNm}', '${item.itemNo}', '${item.itemNm}', '${goods.saleAmt- goods.dcAmt + item.addSaleAmt}', '1', 'N');
				goodsSelect.add('${goods.goodsId}','${goods.goodsNm}', '${item.itemNo}', '${item.itemNm}', sGoodsAmt , sAddSaleAmt, '1', 'N');
				$("div.p_option_box > #option_div").hide();
			}
			else {
				chooseGoods('${goods.goodsId}');
			}

	}); // End Ready

	function OptionCheck(){
		this.init();
	}

	OptionCheck.prototype.init=function(){
		this.eventDefine(); 
	}

	OptionCheck.prototype.eventDefine=function(){
		var scrollTop=0;
		var optionDiv=$(".product_order_box #option_div"); 
		var optionBox = $(".option_wrap"); 
		var optPosY = optionDiv.offset().top; 
		var eventPoint = optPosY + optionDiv.outerHeight() - $("header_menu").height(); 
		
		$(window).scroll(function(){
			scrollTop=$(window).scrollTop(); 
			if(scrollTop >= eventPoint){
				optionBox.show(); 
			}else{
				optionBox.hide(); 
			}
		})
		
		optionBox.find(".option_btn").on("click", function(){
			optionBox.toggleClass("show"); 
			return false; 
		})
	
		$(window).trigger("scroll"); 
	}//eventDefine
	

	// * 이벤트 탭 변경
	function tabChange(tabName){

		//$("#"+tabName+"_list_page ").val(1);
		$("a[id$='Tab']").removeClass("on");
		$("div[id$='Zone']").hide();
		$("#"+tabName+"Tab").addClass("on");
		$("#"+tabName+"Zone").show();
	}

	$(function() {

		//상품이미지 보기
		$('.image_show_box a').click(function(){
			if(!$(this).hasClass('on')){
				imgSrc=$(this).html();
				imgSrc=imgSrc.replace("148x148", "720x720");
				cloneTag='<div class="fade_box" style="display:none;">'+imgSrc+'</div>'
				$('.current_image').append(cloneTag);
				$('.fade_box').eq(1).fadeIn(300);
				$('.image_show_box a.on').removeClass('on');
				$(this).addClass('on');
				setTimeout(function(){$('.fade_box').eq(0).remove()},200)
			}
			return false;
		});

		//$('.anchor_move a').anchorTo();

	});


	var cartInsert = {
		valid : function(){
			var goods = $("#goods_select_list").find("li");

			if(goods.length == 0){
				alert("<spring:message code='front.web.view.goods.detail.select.item' />");
				return false;
			}

			return true;
		}
		// 바로 구매
		,now : function(){
			$("#goods_detail_now_buy_yn").val("Y");

			var options = {
				url : "<spring:url value='/goods/insertCart' />",
				data : $("#goods_detail_form").serialize(),
				done : function(data){
					var formHtml = "";
					formHtml += "<form action=\"/order/indexOrderPayment\" method=\"post\">";
					formHtml += "<input type=\"hidden\" name\"orderType\" value=\"<c:out value="${FrontWebConstants.CART_ORDER_TYPE_ONCE}" />\">";
					
					formHtml += "</form>";
					jQuery(formHtml).appendTo('body').submit();
				}
			};
			ajax.call(options);
		}
		// 장바구니 등록
		,normal : function(){
			$("#goods_detail_now_buy_yn").val("N");

			var options = {
				url : "<spring:url value='/goods/insertCart' />",
				data : $("#goods_detail_form").serialize(),
				done : function(data){
					if(confirm("<spring:message code='front.web.view.goods.detail.confirm.shoppingCart' />")){
						location.href="/order/indexCartList";
					}
				}
			};
			ajax.call(options);
		}

		// 버튼
		,button : function(gb){
			if(cartInsert.valid()){
				if(gb == "now")
					cartInsert.now();
				else if(gb == "normal")
					cartInsert.normal();

			}
		}
	};

	/*
	 * 선택 상품 기능 goodsSelect.add('${goods.goodsNm}', '${item.itemNo}', '${item.itemNm}', '${goods.dcAmt + item.addSaleAmt}', '1', 'N');
	 */
	var goodsSelect = {
		add : function(goodsId, goodsNm, itemNo, itemNm, saleAmt, addSaleAmt, qty, dispDelYn, assemYn, assemFee){
			var price = parseInt(saleAmt) * parseInt(qty);

			assemYn = "N";
			if(goodsNm == null || goodsNm == ""){
				goodsNm = "<c:out value='${goods.goodsNm}' />";
			}
			itemNm = "["+goodsNm + "]"+itemNm;
			var addHtml = "";
			addHtml += "<div class=\"option_list_gray\">";
			addHtml += "<ul>";
			addHtml += "<li name=\"item_into_"+itemNo+"\">";
			addHtml += "	<input type=\"hidden\" name=\"goodsIds\" value=\""+goodsId+"\" />";
			addHtml += "	<input type=\"hidden\" name=\"itemNos\" value=\""+itemNo+"\" />";
			addHtml += "	<div class=\"option_name\">"+itemNm;
			if(addSaleAmt != null && addSaleAmt != 0){
				addHtml += "	(옵션추가 : "+ (addSaleAmt>0?"+":"")+"<span name=\"addSaleAmt\">" + format.num(addSaleAmt) +"</span> 원)";
			}
			addHtml += "	</div>";
			addHtml += "	<div class=\"ui_qty_box\" name=\"select_opt_" + itemNo + "\">";
			addHtml += "		<a href=\"#\" class=\"btn_down\" onclick=\"goodsSelect.qtyDown(" + itemNo + ");return false;\"><span>감소</span></a>";
			addHtml += "		<input type=\"hidden\" class=\"amt\" value=\""+saleAmt+"\" />";
			addHtml += "		<input type=\"hidden\" id=\"buy_qty_"+itemNo+"\" name=\"buyQtys\" value=\""+qty+"\" />";
			addHtml += "		<input type=\"hidden\" class=\"addSaleAmt\" value=\""+addSaleAmt+"\" />";
			addHtml += "		<span class=\"qty\">" + qty + "</span>";
			addHtml += "		<a href=\"#\" class=\"btn_up\" onclick=\"goodsSelect.qtyUp(" + itemNo + ");return false;\"><span>증가</span></a>";
			addHtml += "	</div>";
			addHtml += "	<input type=\"hidden\" name=\"price\" value=\""+price+"\" />";
			addHtml += "	<input type=\"hidden\" name=\"asbSvcYns\" value=\""+assemYn+"\" />";
			addHtml += "	<div class=\"price\">"+ format.num(price) +" 원</div>";
			if(dispDelYn != "N"){
				addHtml += "	<a id=\"del_btn_"+itemNo+"\" href=\"#\" class=\"btn_delete\" onclick=\"goodsSelect.del(this);return false;\">삭제</a>";
			}
			addHtml += "</li>";
			addHtml += "</ul>";
			addHtml += "</div>";

			$("div[name=goods_select_list]").append(addHtml);
			
			// 선택된 옵션 selectbox 초기화
			$("[id^=selected_attrVal_"+goodsId+"]").val("");
			$("[name^=select_").val("");
			
			calTotalAmt();
		},
		// 삭제 버튼 이벤트
		del : function(obj){
			//$(obj).parent().remove();
			var parent = $(obj).parent().attr("name");
			$("li[name=" + parent + "]").remove();
			
			calTotalAmt();
		},
		// 증가 버튼 이벤트
		qtyUp : function(itemNo){
			var qtyObj = $("div[name=select_opt_" + itemNo + "]").find("input[name=buyQtys]");
			var qtySpanObj = $("div[name=select_opt_" + itemNo + "]").find("span.qty");
			
			if(goodsSelect.check(qtyObj, "U")){
				var qty = parseInt(qtyObj.val()) + 1;
				qtyObj.val(qty);
				qtySpanObj.html(qty);
				goodsSelect.calAmt(qtyObj);
			}

		},
		// 감소 버튼 이벤트
		qtyDown : function(itemNo){
			var qtyObj = $("div[name=select_opt_" + itemNo + "]").find("input[name=buyQtys]");
			var qtySpanObj = $("div[name=select_opt_" + itemNo + "]").find("span.qty");
			
			if(goodsSelect.check(qtyObj, "D")){
				var qty = parseInt(qtyObj.val()) - 1;
				qtyObj.val(qty);
				qtySpanObj.html(qty);
				goodsSelect.calAmt(qtyObj);
			}
		},
		// 최대,최소 체크 이벤트
		check :function(qtyObj, gb){
			var minQty = "<c:out value="${goods.minOrdQty}" />";
			var maxQty = "<c:out value="${goods.maxOrdQty}" />";

			if(minQty == ''){
				minQty = 1;
			}

			// 수량감소
			if(gb == "D" && (parseInt(qtyObj.val()) <= parseInt(minQty))){
				alert("<spring:message code='front.web.view.goods.detail.msg.min.shopping' /> "+minQty+"<spring:message code='front.web.view.goods.detail.msg.number' />");
				return false;
			}
			// 수량증가
			if(gb == "U" && (parseInt(qtyObj.val()) >= parseInt(maxQty))){
				alert("<spring:message code='front.web.view.goods.detail.msg.max.shopping' /> "+maxQty+"<spring:message code='front.web.view.goods.detail.msg.number' />");
				return false;
			}
			// 옵션추가 시 수량검사
			if(typeof(gb) == "undefined" || gb == null){
				if(parseInt(qtyObj.text()) < parseInt(minQty)){
					alert("<spring:message code='front.web.view.goods.detail.msg.min.shopping' /> "+minQty+"<spring:message code='front.web.view.goods.detail.msg.number' />");
					return false;
				}else if(parseInt(qtyObj.text()) > parseInt(maxQty)){
					alert("<spring:message code='front.web.view.goods.detail.msg.max.shopping' /> "+maxQty+"<spring:message code='front.web.view.goods.detail.msg.number' />");
					return false;
				}
			}
			return true;
		},
		// 금액 변경
		calAmt : function(qtyObj){
			var price = parseInt(qtyObj.parent().children("input.amt").val()) * parseInt(qtyObj.val());
			var addSaleAmt = parseInt(qtyObj.parent().children("input.addSaleAmt").val()) * parseInt(qtyObj.val());
			
			qtyObj.parent().parent().children("div.price").html(format.num(price)+" 원");
			qtyObj.parent().parent().children("div.option_name").children("span[name=addSaleAmt]").html(format.num(addSaleAmt));
			qtyObj.parent().parent().children("input[name=price]").val(price);
			
			calTotalAmt();
		},
		// 옵션 선택
		chooseOption : function(goodsId, attrNo, attrValNo){
			if(attrValNo == ""){
				return;
			}
			$("#check_item_form > #goodsId").val(goodsId);
			//$("#selected_attrVal_"+goodsId+"_"+attrNo).val(attrValNo);
			
			$(".product_order_box #selected_attrVal_"+goodsId+"_"+attrNo).val(attrValNo);
			$(".option_wrap #selected_attrVal_"+goodsId+"_"+attrNo).val(attrValNo);
			$("select[name=select_" + attrNo + "]").val(attrValNo);
			
			goodsSelect.addOption(goodsId, "O");
		},
		addOption : function(goodsId, gubun){	//gubun = O:옵션선택시
			
			var isSelectedAll = true;
			var qty = $("#qty").text();
			var arrAttrNo = [], arrAttrValNo = [];

			// 옵션이 모두 선택되었는지 확인
			$("[id^=selected_attrVal_"+goodsId+"]").each(function(index){
				console.log("@@@" + $(this).val());
				if($(this).val() == ""){
					isSelectedAll = false;
					return false;
				}else{
					console.log("###" + $("[id^=selected_attrNo_"+goodsId+"]").eq(index).val());
					arrAttrNo.push($("[id^=selected_attrNo_"+goodsId+"]").eq(index).val());
					arrAttrValNo.push($(this).val());
				}
			});

			if(isSelectedAll){
				$("#check_item_form > #attrNoList").val(arrAttrNo);
				$("#check_item_form > #attrValNoList").val(arrAttrValNo);

				// 선택된 옵션조합으로 단품정보 조회
				var options = {
					url : "<spring:url value='/goods/checkGoodsOption' />",
					data : $("#check_item_form").serialize(),
					done : function(data){
						if (data.item == null) {
							alert("<spring:message code='front.web.view.goods.detail.item.stop' />");
							return;
						}
						
						var isDuplicate = false;	//중복여부
						var isSoldOut = false;		//품절여부
						var goodsAmt = $("#saleAmt_"+goodsId).val();
						//할인가가 있으면 할인가
						if($("#dcAmt").val() != "" && $("#dcAmt").val() > 0){
							goodsAmt = goodsAmt -  $("#dcAmt").val();
						}

						$("[name=itemNos]").each(function(index){
							//이미 추가된 옵션인 경우
							if($(this).val() == data.item.itemNo){
								isDuplicate = true;
								return false;
							}
						});
						
						//품절여부
						if($("#stkMngYn").val() == "Y" && data.item.webStkQty < 1){
							isSoldOut = true;
						}

						if(isDuplicate){	//이미 같은 옵션이 추가되어 있는 경우
							alert("<spring:message code='front.web.view.goods.detail.duplicate.option' />");
							return;
						}else if(isSoldOut){
							alert("<spring:message code='front.web.view.goods.detail.item.soldout' />");
							return;
						}else{
							if(gubun == "O"){	//옵션 선택시
								goodsSelect.add(data.item.goodsId, data.item.goodsNm, data.item.itemNo, data.item.itemNm, parseInt(goodsAmt)+parseInt(data.item.addSaleAmt), parseInt(data.item.addSaleAmt), qty, 'Y');
							}
						}
					}
				};
				ajax.call(options);
			}
		}
	};

	/*
	 * 선택상품 총 금액
	 */
	function calTotalAmt(){
		var totalQty = 0;
		var totalAmt = 0;

		var qtyObjs = $("#goods_select_list").find("li").children("div.ui_qty_box").children("input[name=buyQtys]");
		var amtObjs = $("#goods_select_list").find("li").children("input[name=price]");

		if(qtyObjs.length > 0){
			for(var i=0; i<qtyObjs.length; i++){
				totalQty += parseInt($(qtyObjs[i]).val());
				totalAmt += parseInt($(amtObjs[i]).val());
			}
		}
		$("strong[name=goods_detail_total_qty]").html(" " +totalQty);
		$("strong[name=goods_detail_total_amt]").html(format.num(totalAmt));
	}

	/*
	 * 수량변경
	 */
	function changeQty(gb){
		var qty = $("#qty").text();	//
		if(gb == "D"){
			if(qty > 1){
				qty--;
			}
		}else{
			qty++;
		}
		$("#qty").text(qty);
	}

	/*
	 *	옵션영역 생성
	 */
	function chooseGoods(goodsId){
		var options = {
			url : "<spring:url value='/goods/getGoodsOption' />",
			data : {goodsId : goodsId},
			done : function(data){
				//alert(data);
				var inputHtml = "", optHtml = "", innerHtml = "", innerHtml2 = "";
				var qtyHtml = "";
				
				if(data.goodsAttrList.length > 0){
					for(var i=0; i<data.goodsAttrList.length; i++){
						var obj = data.goodsAttrList[i];
						inputHtml = "<input type=\"hidden\" id='selected_attrNo_"+goodsId+"_"+obj.attrNo+"' name='selected_attrNo' value='"+obj.attrNo+"' />";
						inputHtml += "<input type=\"hidden\" id='selected_attrVal_"+goodsId+"_"+obj.attrNo+"' name='selected_attrVal' value='' />";
						
						optHtml = "<dl class=\"option_list\">";
						optHtml += "<dt>"+obj.attrNm+"</dt>";
						optHtml += "<dd>";
						optHtml += "	<select class=\"select\" title=\"옵션선택\" name=\"select_" + obj.attrNo + "\" onchange=\"goodsSelect.chooseOption('"+goodsId+"', '"+obj.attrNo+"', this.value);\" style=\"width:590px;\">";
						optHtml += "		<option value=''>"+obj.attrNm+" 선택</option>";
						for(var j=0; j<obj.goodsAttrValueList.length; j++){
							var attrValObj = obj.goodsAttrValueList[j];
							optHtml += "					<option value='"+attrValObj.attrValNo+"'>"+attrValObj.attrVal+"</option>";
						}
						optHtml += "</select>";
						optHtml += "</dd>";
						optHtml += "</dl>";
						
						innerHtml += inputHtml + optHtml;
						innerHtml2 += optHtml;
					}
					
					qtyHtml = "<span style='display:none' class=\"qty\" id=\"qty\">1</span>";
					qtyHtml += "<input type=\"hidden\" id='saleAmt_"+data.goods.goodsId+"' value='"+data.goods.saleAmt+"' />";
				}
				$(".product_order_box #option_div").html(innerHtml + qtyHtml);
				$(".option_wrap #option_div").html(innerHtml2);
				
				if(data.goods.dlvrcPlcNo != null){
					$("#dlvrcPlcNo").val(data.goods.dlvrcPlcNo); // hjko추가
				}
			}
		};
		ajax.call(options);
	}

	function goEvent(dispClsfNo){
		location.href="/event/indexExhibitionDetail?dispClsfNo="+dispClsfNo;
	}

	/*
	 * 쿠폰 다운로드 처리
	 */
	function insertCoupon(cpNo){
// 		if ('${session.mbrNo}' == 0) {
// 			if(confirm("<spring:message code='front.web.view.common.msg.check.login' />")){
// 				pop.login({});
// 			}
// 			return;
// 		}
		var options = {
				url : "<spring:url value='/event/insertCoupon' />",
				data : {cpNo : cpNo},
				done : function(data){
					alert(data.resultMsg);
				}
		};

		ajax.call(options);
	}
	
	function openPopMemberGradeInfo() {
		var options = {
			url : "/goods/popupMemberGradeInfo",
			params : {},
			width : 550,
			height: 500,
			callBackFnc : "",
			modal : true
		};
		pop.open("popupMemberGradeInfo", options);
	}
    //결제혜택/이벤트 팝업호출
	function openPaymentInfo() {
		var options = {
			url : "/goods/popupPaymentInfo",
			params : {},
			width : 550,
			height: 600,
			callBackFnc : "",
			modal : true
		};
		pop.open("popupPaymentInfo", options);
	}
    //위시리스트
	function insertWishDetail(obj, goodsId){
		
		if($("#interestYn").val() == 'Y'){
			alert("이미 위시리스트에 등록된 상품입니다.");
			return;
		}
		
		var options = {
			url : "<spring:url value='/goods/insertWish' />",
			data : {goodsId : goodsId},
			done : function(data){
				
				if(data.actGubun =='add'){
					$("#interestYn").val("Y");						
					if (confirm("위시리스트에 담겼습니다.\n확인하시겠습니까?"))
						location.href = "/mypage/interest/indexWishList";
				}else if(data.actGubun =='remove'){
					$("#interestYn").val("N");				
					$(obj).removeClass("click");
					//alert("위시리스트에서 삭제되었습니다.");
				}else{
					alert('위시리스트 등록 또는 삭제에 실패하였습니다.');
				}
			}
		};
		ajax.call(options);
	}
</script>

<!-- content -->	
<div id="content">	
			
			
<!-- 상품선택 -->
<div class="p_product_info">
	<!-- 상품 정보:브랜드:상품명 -->
	<div class="product_name_box">
		<ul class="brand">
			<li><a class="move_link" href="/brand/indexBrandDetail?bndNo=${goods.bndNo}" target="_blank"><c:out value="${goods.bndNmKo }" /></a></li>
			<li class="seller">
				<a class="move_link" href="/seller/indexCompDetail?compNo=${goods.compNo}" target="_blank"><c:out value="${goods.compNm }" /></a>
			</li>
		</ul>
		<c:if test="${goods.prWdsShowYn eq FrontWebConstants.COMM_YN_Y }">
		<div class="promotion_msg"><c:out value="${goods.prWds }" /></div>
		</c:if>
		<div class="prod_name"><c:out value="${goods.goodsNm }" /></div>
	</div>
	<!-- // 상품 정보:브랜드:상품명 -->
	<!-- 상품 이미지 -->
	<div class="image_show_box">
		<div class="current_image">
			<div class="fade_box">
		<c:choose>
			<c:when test="${compositionImgList eq null}">
			<frame:goodsImage imgPath="${dlgtImgPath}" goodsId="${goods.goodsId}" seq="${dlgtImgSeq }" size="${ImageGoodsSize.SIZE_10.size}" />
			<script type="text/javascript">
				//metadata에 넣을 이미지 src 생성
				var imgPath = "${dlgtImgPath}";
				var ext  = imgPath.substr(imgPath.lastIndexOf(".") , imgPath.length);
				var	 ImgSrc = "${view.imgDomain}" + "/goods/" + "${goods.goodsId}" + "/" + "${goods.goodsId}_" + "${dlgtImgSeq }" + "_600x600" + ext;
				$('#meta_og_image').attr('content', ImgSrc);
			</script>
			</c:when>
			<c:otherwise>
			<c:forEach items="${compositionImgList }" var="compImg" varStatus="status">
				<c:if test="${status.first }">
				<frame:goodsImage imgPath="${compImg.imgPath}" goodsId="${compImg.goodsId}" seq="${compImg.imgSeq }" size="${ImageGoodsSize.SIZE_10.size}" />
				<script type="text/javascript">
				//metadata에 넣을 이미지 src 생성
				var imgPath = "${compImg.imgPath}";
				var ext  = imgPath.substr(imgPath.lastIndexOf(".") , imgPath.length);
				var	 ImgSrc = "${view.imgDomain}" + "/goods/" + "${compImg.goodsId}" + "/" + "${compImg.goodsId}_" + "${compImg.imgSeq }" + "_600x600" + ext;
				$('#meta_og_image').attr('content', ImgSrc);
				</script>
				</c:if>
			</c:forEach>
			</c:otherwise>
		</c:choose>
			</div>
		</div>
		<div class="image_list">
			<ul>
			<c:choose>
			<c:when test="${compositionImgList eq null}">
				<c:forEach items="${goodsImgList }" var="img" varStatus="status">
					<li><a href="#"><frame:goodsImage  imgPath="${img.imgPath}" goodsId="${img.goodsId}" seq="${img.imgSeq }" size="${ImageGoodsSize.SIZE_10.size}" /></a></li>
				</c:forEach>
			</c:when>
			<c:otherwise>
			<c:forEach items="${compositionImgList }" var="compImg" varStatus="status">
					<li><a href="#"><frame:goodsImage imgPath="${compImg.imgPath}" goodsId="${compImg.goodsId}" seq="${compImg.imgSeq }" size="${ImageGoodsSize.SIZE_10.size}" /></a></li>
			</c:forEach>
			</c:otherwise>
			</c:choose>
			</ul>
		</div>
	</div>
	<!-- //상품 이미지 -->

	<!-- 상품 정보 -->
	<div class="product_order_box">
		<input type="hidden" id="stkMngYn" value="${goods.stkMngYn }" />
		<input type="hidden" id="saleAmt" value="${goods.saleAmt }" />
		<input type="hidden" id="dcAmt" value="${goods.dcAmt }" />
		<input type="hidden" id="cpNo" value="${goods.cpNo }" />
		<input type="hidden" id="cpAmt" value="${goods.cpAmt }" />
		<input type="hidden" id="soldOutYn" value="${goods.soldOutYn }" />
		<input type="hidden" id="goodsTpCd" value="${goods.goodsTpCd }" />
		<input type="hidden" id="goodsStatCd" value="${goods.goodsStatCd }" />
		<input type="hidden" id="lgePrctYn" value="N" />

	<c:if test="${not empty hot}">
		<div class="detail_deal_wrap">
			<div class="buy_time"><em id="time01"></em></div>
			<div class="buy_num"><em>${hot.salesQty}</em>개 구매중</div>
		</div>
	</c:if>
		<div class="base_infomation_box">   	
			<div class="tag_wrap mgb20">
				<c:if test="${goods.newYn eq FrontWebConstants.COMM_YN_Y }">
					<span class="tag">NEW</span>
				</c:if>
				<c:if test="${goods.freeDlvrYn eq FrontWebConstants.COMM_YN_Y}">
					<span class="tag">무료배송</span>
				</c:if>
				<c:if test="${goods.couponYn eq FrontWebConstants.COMM_YN_Y }">
					<span class="tag">쿠폰</span>
				</c:if>
				<c:if test="${goods.bestYn eq FrontWebConstants.COMM_YN_Y }">
					<span class="tag">BEST</span>
				</c:if>
			</div>
			<div class="price_list">
				<dl>
					<dt>판매가</dt>
					<dd>
						<span class='${(empty goods.dcAmt or goods.dcAmt == 0) and empty hot?"point1":""}'>
						<frame:num data="${not empty hot?goods.orgAmt:goods.saleAmt }" /> 원</span><c:set var="metaGoodsSaleAmt" value="${goods.saleAmt }"/>
						<a href="#" onclick="openPaymentInfo();return false;" class="btn_h21_type5">결제혜택/이벤트</a>
					</dd>
				</dl>
				<c:if test="${(not empty goods.dcAmt and goods.dcAmt > 0) or not empty hot}">
				<dl class="mgt15">
					<dt>할인가</dt>
					<dd><span class="point1">
						<frame:num data="${goods.saleAmt - goods.dcAmt}" /> 원
						<c:if test="${empty hot}">
							<span class="priceSale">[<c:out value='${Math.round(100 - (((goods.saleAmt - goods.dcAmt) / goods.saleAmt) * 100))}' /> % <frame:num data="${goods.dcAmt}" /> 원]</span></span>
							<c:set var="metaGoodsDcAmt" value="${goods.dcAmt }"/>
						</c:if>
						<c:if test="${not empty hot}">
							<span class="priceSale">[<c:out value='${Math.round(100 - (((goods.saleAmt - goods.dcAmt) / goods.orgAmt) * 100))}' /> % <frame:num data="${goods.orgAmt-goods.saleAmt+goods.dcAmt}" /> 원]</span></span>
							<c:set var="metaGoodsDcAmt" value="${goods.dcAmt }"/>
						</c:if>
					</dd>
				</dl>
				</c:if>
				<c:if test="${not empty goods.cpAmt and goods.cpAmt > 0}">
				<dl class="mgt15">
					<dt>쿠폰 적용가</dt>
					<dd>
						<span class="point1">
							<frame:num data="${goods.saleAmt - goods.dcAmt - goods.cpAmt}" /> 원
							<span class="priceSale">[<c:out value='${Math.round(goods.cpAmt / (goods.saleAmt - goods.dcAmt) * 100)}' /> % <frame:num data="${goods.cpAmt}" /> 원]</span>
							<span class="period">(<frame:timestamp date="${goods.aplStrtDtm }" dType="C" />~<frame:timestamp date="${goods.aplEndDtm }" dType="C" />)</span><a href="#" class="btn_h21_type2 mgl10" onclick="insertCoupon('<c:out value="${goods.cpNo }" />');return false;">다운로드</a>
						</span>
					</dd>
				</dl>
				</c:if>
			</div>
			<div class="etc_list">
				<dl>
					<dt>예상 적립금</dt>
					<dd><span><c:if test="${goods.dcAmt ne null and goods.dcAmt ne 0}"><c:out value="${Math.round((goods.saleAmt-goods.dcAmt) * saveMoneyRate /100)}" /></c:if><c:if test="${goods.dcAmt eq null or goods.dcAmt eq 0}"><frame:num data="${Math.round(goods.saleAmt * saveMoneyRate /100)}" /></c:if> 원 [<fmt:formatNumber value="${saveMoneyRate }" />%]</span>
					<a href="#" class="btn_h21_type4" onclick="openPopMemberGradeInfo();return false;">적립금안내</a>
					</dd>
				</dl>
				<dl class="mgt20">
                	<dt>배송비</dt>
                    <dd>
                    	<c:if test="${goods.freeDlvrYn eq FrontWebConstants.COMM_YN_Y }">무료배송</c:if>
				   		<c:if test="${goods.freeDlvrYn ne FrontWebConstants.COMM_YN_Y and not empty deliveryChargePolicy }">
							<span><frame:num data="${deliveryChargePolicy.dlvrAmt}" /> 원
							<span class="etc">
								<c:if test="${deliveryChargePolicy.dlvrcCdtStdCd eq FrontWebConstants.DLVRC_CDT_STD_20}">[<frame:num data="${deliveryChargePolicy.buyPrc}" /> 원 이상 무료배송]</c:if>
								<c:if test="${deliveryChargePolicy.dlvrcCdtStdCd eq FrontWebConstants.DLVRC_CDT_STD_30}">[<frame:num data="${deliveryChargePolicy.buyQty}" /> 개 이상 무료배송]</c:if>
							</span></span>                                    
				   		</c:if>
                    </dd>
                </dl>
                <dl class="mgt25">
                	<dt>상품코드</dt>
                	<dd>
                    	<span>${goods.goodsId}</span>
                    </dd>
                </dl>
			</div>
		</div>
		<div class="option_container">
			<div class="p_option_box">
				<div id="option_div"></div>
				
				<!--  선택된 상품 영역 -->
				<div class="p_select_box">
					<form id="goods_detail_form">
						<input type="hidden" id="goods_detail_now_buy_yn" name="nowBuyYn" value="">
						<div id="goods_select_list" name="goods_select_list"></div>
					</form>
				</div>
			</div>
		</div>
	<c:choose>
		<c:when test="${goods.goodsStatCd eq FrontWebConstants.GOODS_STAT_10 }">
			<div class="product_soldout">
				대기 상품입니다.
			</div>
		</c:when>
		<c:when test="${goods.goodsStatCd eq FrontWebConstants.GOODS_STAT_20 }">
			<div class="product_soldout">
				승인요청된 상품입니다.
			</div>
		</c:when>
		<c:when test="${goods.goodsStatCd eq FrontWebConstants.GOODS_STAT_30 }">
			<div class="product_soldout">
				승인거절된 상품입니다.
			</div>
		</c:when>
		<c:when test="${goods.goodsStatCd eq FrontWebConstants.GOODS_STAT_40 }">
			<div class="product_soldout">
				판매중 상품입니다.
			</div>
		</c:when>
		<c:when test="${goods.goodsStatCd eq FrontWebConstants.GOODS_STAT_50 }">
			<div class="product_soldout">
				판매중지된 상품입니다.
			</div>
		</c:when>
		<c:when test="${goods.goodsStatCd eq FrontWebConstants.GOODS_STAT_60 }">
			<div class="product_soldout">
				판매종료된 상품입니다.
			</div>
		</c:when>
		<c:when test="${goods.soldOutYn eq FrontWebConstants.COMM_YN_Y }">
			<div class="product_soldout">
				품절된 상품입니다.
			</div>
		</c:when>
		<c:otherwise>
		</c:otherwise>
	</c:choose>
	</div>
	<!-- 상품 정보 -->
</div>
<!-- //상품선택 -->

<!-- 배너영역 -->
<c:if test="${not empty commonBanner }">
	<c:forEach items="${commonBanner}" var="banner" varStatus="status">
	<div class="p_banner_section">
		<a href="${banner.bnrLinkUrl}"><img src="${view.imgDomain}${banner.bnrImgPath}" alt="${banner.bnrDscrt}"></a>
	</div>
	</c:forEach>
</c:if>
<!-- //배너영역 -->

<!-- 상품 상세정보 -->
<div id="productDetailCont1">
	<!-- 상품설명 -->
	<div class="p_product_details p_cont_border">
		<h2 class="hidden_obj">상품설명</h2>
		<div class="tab_style2 anchor_move">
			<ul>
				<li><a class="on" href="#productDetailCont1">상품설명</a></li>
				<li><a href="#productDetailCont2">리뷰</a></li>
				<li><a href="#productDetailCont3">상품문의</a></li>
				<li><a href="#productDetailCont4">배송/교환/환불</a></li>
			</ul>
		</div>
		<div class="product_data_add">
			<c:out value="${goodsDesc.content}" escapeXml="false"/>
			<div id="include_user_define_area"></div>
		</div>

		<div class="product_notice">
			<div class="inner">
				<div class="notice_section">
					<h3 class="sub_title1">제품 주의사항</h3>
					<ul class="ul_list_type0">
						<c:forEach items="${goodsCautionList}" var="goodsCaution" varStatus="idx">
						<li><c:out value="${goodsCaution.content}"  escapeXml="false"/></li>
						</c:forEach>
					</ul>
				</div>
				<div class="detail_section mgt60">
					<h3 class="sub_title1">상품 세부정보</h3>
					<table class="table_product">
						<caption>상품 세부정보</caption>
						<colgroup>
							<col style="width:150px;" />
							<col />
						</colgroup>
						<tbody>
							<c:choose>
							<c:when test="${compositionNotiList eq null}">
							<c:if test="${goodsNotifyList ne '[]'}">
							<c:forEach items="${goodsNotifyList}" var="goodsNotify">
							<tr>
								<th><c:out value="${goodsNotify.itemNm}" /></th>
								<td><c:out value="${goodsNotify.itemVal}" /></td>
							</tr>
							</c:forEach>
							</c:if>
							</c:when>
							<c:otherwise>
								<c:forEach items="${compositionNotiList}" var="compNotifyList">
									<c:forEach items="${compNotifyList }" var="compNotify" varStatus="status">
										<c:if test="${status.first }">
							<tr><th colspan="2"><center><b><c:out value="${compNotify.goodsNm }"/></b></center></th></tr>
										</c:if>
							<tr>
								<th><c:out value="${compNotify.itemNm}" /></th>
								<td><c:out value="${compNotify.itemVal}" /></td>
							</tr>
									</c:forEach>
								</c:forEach>
							</c:otherwise>
							</c:choose>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
	<!-- //상품설명 -->
	<!-- 기획전 배너영역 -->
	<c:if test="${exhibition ne '[]' }">
		<c:forEach items="${exhibition}" var="exh" varStatus="status">
		<div class="p_banner_section" style="display:;">
              <a href="/event/indexExhibitionDetail?page=1&rows=40&exhbtNo=${exh.exhbtNo}&sortType=NW"><img src="${view.imgDomain}${exh.gdBnrImgPath}" alt="${exh.exhbtNm}"></a>
        </div>
        </c:forEach>
	</c:if>
	<!-- 기획전 배너영역 -->
	<!-- ABOUT BRAND -->
    <div class="p_aboutBrand_section">		
		<div class="title">
			<img src="${view.imgDomain}${brand.tnImgPath}" alt="about Brand">
			<ul class="title_info">
				<li class="head"><strong>ABLOUT</strong> BRAND</li>
				<li class="brand">${brand.bndNm}</li>
				<li class="msg">${StringUtil.removeHTMLAttr(brand.bndItrdc,"style")}</li>
			</ul>
		</div>
		<div class="p_aboutBrand_inner">		
			<!-- Swiper -->
			<div class="aboutBrand swiper-container">					
				<ul class="swiper-wrapper">
				<c:forEach items="${brandGoods}" var="good" varStatus="status">
				<c:if test="${status.index%3 == 0}">
					<li class="swiper-slide">
						<div class="list_col5">
							<ul>
				</c:if>
								<li class="item">
									<div class="img_sec over_link">
										<a href="/goods/indexGoodsDetail?goodsId=${good.goodsId}">
											<frame:goodsImage imgPath="${view.imgDomain}${good.imgPath}" goodsId="${good.goodsId}" seq="${good.imgSeq}" size="${ImageGoodsSize.SIZE_50.size}" />
										</a>
										<div class="link_group">
											<div class="btn_area">
												<a href="/goods/indexGoodsDetail?goodsId=${good.goodsId}" class="btn_cover_move" title="상품 새창보기" target="_blank"><span>상품 새창보기</span></a>
												<a href="#" class="btn_cover_fav <c:if test='${goods.getInterestYn() eq "Y"}' >click</c:if>" title="위시리스트 추가" onclick="insertWish(this,'${good.goodsId}');return false;"><span>위시리스트 추가</span></a>
											</div>
										</div>
									</div>
										
									<ul class="text_sec">												
										<li class="u_name"><a href="/goods/indexGoodsDetail?goodsId=${good.goodsId}">${good.goodsNm}</a> </li>
										<li class="u_cost"><frame:num data="${good.saleAmt}" />원</li>										
									</ul>
								</li>
				<c:if test="${status.index%3 == 2 || status.last}">
							</ul>
						</div>
					</li>
				</c:if>
				</c:forEach>
				</ul>
				<!-- Add Pagination -->
				<div class="swiper-pagination"></div>						
			</div>
			<!-- next_back -->
			<div class="swiper-button-next"></div>
			<div class="swiper-button-prev"></div>
		</div>
          </div>
	<!-- //ABOUT BRAND -->	
	<!-- review -->
	<div id="productDetailCont2"  class="p_review p_cont_border">
		<h2 class="hidden_obj">리뷰</h2>
		<div class="tab_style2 anchor_move">
			<ul>
				<li><a href="#productDetailCont1">상품설명</a></li>
				<li><a class="on" href="#productDetailCont2">리뷰</a></li>
				<li><a href="#productDetailCont3">상품문의</a></li>
				<li><a href="#productDetailCont4">배송/교환/환불</a></li>
			</ul>
		</div>
		<!-- 리뷰 댓글 영역 -->
		<div class="review_section" id="goods_comment_area">
		</div>
		<!-- //리뷰 댓글 영역 -->
	</div>
	<!-- //review -->
	<!-- 상품문의 -->
	<div id="productDetailCont3"  class="p_question p_cont_border">
		<h2 class="hidden_obj">상품문의</h2>
		<div class="tab_style2 anchor_move">
			<ul>
				<li><a href="#productDetailCont1">상품설명</a></li>
				<li><a href="#productDetailCont2">리뷰</a></li>
				<li><a class="on" href="#productDetailCont3">상품문의</a></li>
				<li><a href="#productDetailCont4">배송/교환/환불</a></li>
			</ul>
		</div>

		<div class="review_section" id="goods_inquiry_area">
		</div>

	</div>
	<!-- //상품문의 -->
	<!-- 배송/교환/환불 -->
	<div id="productDetailCont4"  class="p_etc p_cont_border">
		<h2 class="hidden_obj">배송/교환/환불</h2>
		<div class="tab_style2 anchor_move">
			<ul>
				<li><a href="#productDetailCont1">상품설명</a></li>
				<li><a href="#productDetailCont2">리뷰</a></li>
				<li><a href="#productDetailCont3">상품문의</a></li>
				<li><a class="on" href="#productDetailCont4">배송/교환/환불</a></li>
			</ul>
		</div>
		<div class="p_etc_inner">
			<div>
			<c:if test="${not empty compPolicyList}">
			<!-- <h3 class="sub_title1"><frame:codeValue items="${compPolicyCdList}" dtlCd="${FrontWebConstants.COMP_PLC_GB_10}"/></h3>-->
				<ul class="ul_list_type0">
						<c:forEach items="${compPolicyList}" var="compPolicy" varStatus="idx2">
							<li>${compPolicy.content}</li>
						</c:forEach>
				</ul>
			</c:if>
			</div>
			<div class="mgt50">
			<h3 class="sub_title1">배송정보</h3>
				<ul class="ul_list_type0">
					<li>- 연락처 : <c:out value="${deliveryChargePolicy.rtnExcTel }" /></li>
					<li>- 출고지주소 : 우)<c:out value="${deliveryChargePolicy.rtnaPostNoNew }" /> <c:out value="${deliveryChargePolicy.rtnaRoadAddr }" />  <c:out value="${deliveryChargePolicy.rtnaRoadDtlAddr }" /></li>
					<li>- 배송방법 : <c:out value="${deliveryChargePolicy.compDlvrMtdNm }" /></li>
					<li>- 배송비 : <c:out value="${deliveryChargePolicy.dlvrAmtNm }" /></li>
					<li>- 배송기간 : <c:out value="${deliveryChargePolicy.dlvrMinSmldd }" />~<c:out value="${deliveryChargePolicy.dlvrMaxSmldd }" />일</li>
				</ul>
			</div>
		</div>
	</div>
	<!-- //배송/교환/환불 -->
</div>

</div><!-- //content -->

<!-- option_wrap -->	
<div class="option_wrap" style="display:none">
	<button type="button" class="go_top">TOP ↑</button>
</div>
<!-- //option_wrap -->
	
<!--  선택된 상품 영역 -->
<form id="check_item_form">
	<input type="hidden" id="goodsId" name="goodsId" value="<c:out value='${goods.goodsId}' />" />
	<input type="hidden" id="dlvrcPlcNo" name="dlvrcPlcNo" value='<c:out value="${goods.dlvrcPlcNo }" />' />
	<input type="hidden" id="attrNoList" name="attrNoList" value="" />
	<input type="hidden" id="attrValNoList" name="attrValNoList" value="" />
	<input type="hidden" id="interestYn" value="<c:out value="${goods.interestYn}"/>" />
</form>
<script>
	var aboutBrandSwiper = new Swiper('.swiper-container.aboutBrand', {		
		slidesPerView: 1,
		autoplay: 2000,
		pagination: '.swiper-pagination',
		nextButton: '.p_aboutBrand_inner .swiper-button-next',
	    prevButton: '.p_aboutBrand_inner .swiper-button-prev',
		paginationClickable: true,
		spaceBetween: 0,
		simulateTouch : false
	});

</script>