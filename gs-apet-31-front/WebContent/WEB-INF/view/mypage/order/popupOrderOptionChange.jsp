<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<script type="text/javascript">

	$(document).ready(function(){

	}); // End Ready

	$(function() {

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
					alert("옵션을 선택하세요.");
					return;
				}
			});

			if(addFlag){
				if ("${param.mode}" == "order") {
					fnOption.update();
				} else {
					fnOption.exChange();
				}
			}
		},
		update : function (){

	 		var options = {
				url : "<spring:url value='/mypage/order/changeOrderOption' />",
				data : $("#order_option_change").serialize(),
				done : function(data){
					alert("<spring:message code='front.web.view.order.cart.option.update.success' />");
					returnOption();
				}
			};
			ajax.call(options);
		}
		, exChange : function (){
			
			var options = {
				url : "<spring:url value='/mypage/order/changeOrderExchangeOption' />",
				data : $("#order_option_change").serialize(),
				done : function(data){
					
					var itemNo = data.itemNo;
					
					var data = new Array();
					$("[id^=selected_attrValNo_]").each(function(index){
						
						var dataObj = new Object();
						
						dataObj.attrNo = $("[id^=selected_attrNo_]").eq(index).val();
						dataObj.attrValNo = $(this).val();
						dataObj.attrVal = $("[id^=selected_attrVal_]").eq(index).val();
						dataObj.itemNo = itemNo;
						data.push(dataObj);
					});
					
					returnOption(data);
				}
			};
			ajax.call(options);
			
		}
	}

	/*
	 * 옵션 변경 후 CallBack 처리
	 * data : S or F
	 */
	function returnOption(data){
		<c:out value="${param.callBackFnc}" />(data);
		pop.close("<c:out value="${param.popId}" />");

	}

</script>

<form id="order_option_change">
<input type="hidden" id="v_ord_no" name="ordNo" value="<c:out value='${orderDetail.ordNo}' />" />
<input type="hidden" id="ordDtlSeq" name="ordDtlSeq" value="<c:out value='${orderDetail.ordDtlSeq}' />" />


<div id="pop_contents">
	<p class="point3">변경하실 옵션을 선택하신 후 확인버튼을 눌러주세요.</p>
	<div class="pop_option_change">
		<ul>
			<c:forEach items="${goodsAttrList}" var="obj" varStatus="status">
			<input type="hidden" id="selected_attrNo_${obj.attrNo }" name="attrNos" value="${obj.attrNo }" />
			<input type="hidden" id="selected_attrValNo_${obj.attrNo }" name="attrValNos" value="" />
			<input type="hidden" id="selected_attrVal_${obj.attrNo }" name="attrVals" value="" />
			<input type="hidden" id="selected_itemNo_${obj.attrNo }" name="itemNos" value="" />
			<li>
				<span class="label_tit">ㆍ<c:out value="${obj.attrNm}" /></span>
				
				<select class="select1" title="<c:out value="${obj.attrNm}" />선택" onchange="fnOption.choose('${obj.attrNo}', this, $('option:selected', this).attr('attrVal'), $('option:selected', this).attr('itemNo'));">
					<option>옵션을 선택하세요</option>
					<c:forEach items="${obj.goodsAttrValueList}" var="attrValObj">
					<option value="${attrValObj.attrValNo}" attrVal="${attrValObj.attrVal}" itemNo="${attrValObj.itemNo }"><c:out value="${attrValObj.attrVal}" /></option>
					
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
	<a href="#" class="btn_pop_type1" onclick="fnOption.check();return false;">확인</a>
	<a href="#" class="btn_pop_type2 mgl6" onclick="pop.close('<c:out value="${param.popId}" />');return false;">취소</a>
</div>
<!-- //버튼 공간 -->