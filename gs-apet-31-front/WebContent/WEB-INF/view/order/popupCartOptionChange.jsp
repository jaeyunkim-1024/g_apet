<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 

<script type="text/javascript">

	$(document).ready(function(){
	}); // End Ready

	$(function() {

	});
	
	/*
	 * 옵션 변경 버튼
	 */
	var opionChangeBtn = {
		valid : function (){
			
			var attrList = $("select.attrValNo");
			var attrTitle = "";
			
			if(attrList.length > 0){
				for(var i=0; i<attrList.length; i++){
					if($(attrList[i]).val() == ""){
						attrTitle = $(attrList[i]).prev().prev("span").html();
						alert(attrTitle + "을(를) 선택해 주세요.");
						return false;
					}
				}
				
			}
			
			return true;
		},
		update : function (itemNo){
			if(this.valid()){
		 		var options = {
					url : "<spring:url value='/order/changeOption' />",
					data : $("#pop_cart_option_change_form").serialize(),
					done : function(data){
						alert("<spring:message code='front.web.view.order.cart.option.update.success' />");
						<c:out value="${param.callBackFnc}" />();
						pop.close("<c:out value="${param.popId}" />");		
					}
				};
				ajax.call(options);
			}
		}
	}

</script>

<form id="pop_cart_option_change_form">
<input type="hidden"  id="pop_cart_option_change_cart_id" name="cartId" value="${cart.cartId}" />
<input type="hidden"  id="pop_cart_option_change_goods_id" name="goodsId" value="${cart.goodsId}" />
<input type="hidden" name="buyQty" value="<c:out value="${cart.buyQty}" />" />

<div id="pop_contents">
	<p class="point3">변경하실 옵션을 선택하신 후 확인버튼을 눌러주세요.</p>
	<div class="pop_option_change">
		<ul>
			<c:forEach items="${goodsAttrList}" var="goodsAttr">
			<li>
				<span class="label_tit"><c:out value="${goodsAttr.attrNm}" /></span>
				<input type="hidden" name="attrNos" value="<c:out value="${goodsAttr.attrNo}" />" />
				<select class="select1 attrValNo" title="<c:out value="${obj.attrNm}" />선택" name="attrValNos">
					<option>옵션을 선택하세요</option>
					<c:forEach items="${goodsAttr.goodsAttrValueList}" var="goodsAttrVal">
						<c:forEach items="${itemAttrValList}" var="itemAttrVal">
						<c:if test="${goodsAttr.attrNo eq itemAttrVal.attrNo}">
						<option value="${goodsAttrVal.attrValNo}" <c:if test="${goodsAttrVal.attrValNo eq itemAttrVal.attrValNo}">selected="selected"</c:if>><c:out value="${goodsAttrVal.attrVal}" /></option>
						</c:if>
						</c:forEach>
					</c:forEach>
				</select>
			</li>
			</c:forEach>
		</ul>
	</div>
</div>
<!-- //팝업 내용 -->
</form>
<!-- 버튼 공간 -->
<div class="pop_btn_section">
	<a href="#" class="btn_pop_type1" onclick="opionChangeBtn.update();return false;">확인</a>
	<a href="#" class="btn_pop_type2 mgl6" onclick="pop.close('<c:out value="${param.popId}" />');return false;">취소</a>
</div>
<!-- //버튼 공간 -->