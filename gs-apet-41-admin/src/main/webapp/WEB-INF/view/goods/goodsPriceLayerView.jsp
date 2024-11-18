<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>

<script type="text/javascript">
$(document).ready(function() {
	fnInit();
});

$(function() {
	//가격 text 변경 시 
	$(".amt").on("change",function(){
		var saleAmt_ = Number(removeComma($("#goodsPriceForm [name='saleAmt']").val()));
		var orgSaleAmt_ = Number(removeComma($("#goodsPriceForm [name='orgSaleAmt']").val()));
		if(saleAmt_ > orgSaleAmt_){
			messager.alert("판매가는 정상가와 같거나 정상가보다 작아야합니다.", "Info", "info");
			$("#goodsPriceForm [name='saleAmt']").val(Number("${goodsPrice.saleAmt }"));			
		}
		fnCalMargin();
		
		calfvrApl();
	});
	
	$(document).on("change","#priceSaleEndDt, #priceSaleEndHr, #priceSaleEndMn", function(e) {
		if($("input:checkbox[id='unlimitSaleEndDate']").is(":checked")){
			var endDt = $("#priceSaleEndDt").val();
			var endHr = $("#priceSaleEndHr option:selected").val();
			var endMn = $("#priceSaleEndMn option:selected").val();		
			if(endDt != "9999-12-31" || endHr != "23" || endMn != "59"){
				//종료일 미지정 체크 해제 unlimitSaleEndDate			
				$('input:checkbox[id="unlimitSaleEndDate"]').attr("checked", false);			
			}
		}		
		
	});
});

function fnInit(){
	
	fnControlUI("${goodsPrice.goodsAmtTpCd }");
	
	fvrAplMethChange();
	
	fnCalMargin();
	
	//$('input:checkbox[id="unlimitSaleEndDate"]').attr("checked", true);
	checkUnlimitEndDate($('input:checkbox[id="unlimitSaleEndDate"]'), 'priceSale');
	
}

function calfvrApl() {
	
	var splAmtTemp = Number(removeComma($("#goodsPriceForm [name='splAmt']").val()));
	var orgSaleAmtTemp = Number(removeComma($("#goodsPriceForm [name='orgSaleAmt']").val()));
	var saleAmtTemp = Number(removeComma($("#goodsPriceForm [name='saleAmt']").val()));
	var methCd = $("input[name=fvrAplMethCd]:checked").val();
	var resultVal;
	
// 	if(saleAmtTemp > orgSaleAmtTemp){
// 		messager.alert("<spring:message code='admin.web.view.msg.goods.saleprice.more.than.orgSalePrice' />", "Info", "info");
// 		return false;
// 	}
	
	if(methCd == "${adminConstants.FVR_APL_METH_20 }" ) {
		resultVal = Number(orgSaleAmtTemp - saleAmtTemp);
		$("#fvrVal" + methCd).val(addComma(resultVal));
	}else{
		resultVal = (orgSaleAmtTemp-saleAmtTemp)/orgSaleAmtTemp*100;
		$("#fvrVal" + methCd).val(resultVal.toFixed("2"));
	}
	
}

function calSvmnPrice (objId ) {
	var saleAmt = Number(removeComma($("#goodsPriceForm [name='orgSaleAmt']").val()));
	var objVal = Number(removeComma($("#" + objId).val()));
		
	var result = 0;

	if(saleAmt > 0 ) {
		var methCd = $("input[name=fvrAplMethCd]:checked").val();
		
		if(methCd == "${adminConstants.FVR_APL_METH_20 }" ) {
			
			result = saleAmt - objVal;
		}else{
			var minusValue = Math.ceil((saleAmt * (objVal / 100)) / 10) * 10;
			result = saleAmt - minusValue;
		}
		
		$("#goodsPriceForm [name='saleAmt']").val(addComma(result));
		
		fnCalMargin();
	}
}

function fvrAplMethChange(){
	var fvlAplMethodCd = $("input[type=radio][name='fvrAplMethCd']:checked").val();

	$("input[name=fvrAplMethCd]").each(function(){
		if($(this).val() !== fvlAplMethodCd){
			$("#fvrVal"+$(this).val()).val("");
			$("#fvrVal"+$(this).val()).prop("disabled", true);
		}else{
			$("#fvrVal"+$(this).val()).prop("disabled", false);
		}
	});
	
	calfvrApl();
}

// 이익률 계산
function fnCalMargin(){
	// 	(판매가-매입가)/판매가x100 10.25 소수점 두자리 반오림? 버림 floor? 올림 ceil? 반올림 rould  
	var saleAmtTemp = Number(removeComma($("#goodsPriceForm [name='saleAmt']").val()));
	var splAmtTemp = Number(removeComma($("#goodsPriceForm [name='splAmt']").val()));
	
	var margin = ((saleAmtTemp-splAmtTemp)/saleAmtTemp*100);
	
	$("#marginText").text(margin.toFixed("2"));
}

// 가격변경 구분에 따른.. 하단 처리..
function changeGoodsPrcTpCd (obj ) {
	fnControlUI($(obj).children("option:selected").val());
}

// UI 제어
function fnControlUI(goodsPrcTpCd){
	 
	// 일반일 경우 UI 제어
	if(goodsPrcTpCd == "${adminConstants.GOODS_AMT_TP_10 }" ) {
		$("#priceFvr input").prop('disabled', true);
		$("#priceFvr input[type='radio']").prop('checked', false);
		$("[id^='fvrVal']").val("");
	}else{
		$("#priceFvr input").prop('disabled', false);
		$("#priceFvr input[type='radio']").eq(0).prop('checked', true);
		
		fvrAplMethChange();
	}
	
	//GOODS_AMT_TP_40 유통기한할인
	if(goodsPrcTpCd == "${adminConstants.GOODS_AMT_TP_40 }" ) {
		$("#expDtTr").show();
	}else{
		$("#expDtTr").hide();
	}
 	//GOODS_AMT_TP_60 사전예약
	if(goodsPrcTpCd == "${adminConstants.GOODS_AMT_TP_60 }" ) {
		$("#rsvBuyQtyTr").show();
	}else{
		$("#rsvBuyQtyTr").hide();
		$("[name='rsvBuyQty']").val("");
	}
}
function checkNumber(event) {
	  if(event.key === '.' || event.key >= 0 && event.key <= 9) {
	    return true;
	  }	  
	  return false;
	}

function updateGoodsPrice() {
	//20210623추가 v0.978 정상가, 매입가, 판매가 0 이하 체크
	if($("#goodsPriceForm [name='orgSaleAmt']").val() == 0 || $("#goodsPriceForm [name='orgSaleAmt']").val().indexOf('-') > -1
			|| $("#goodsPriceForm [name='saleAmt']").val() == 0 || $("#goodsPriceForm [name='saleAmt']").val().indexOf('-') > -1
			|| $("#goodsPriceForm [name='splAmt']").val() == 0 || $("#goodsPriceForm [name='splAmt']").val().indexOf('-') > -1){
		 messager.alert("0원 이하는 입력할 수 없습니다.", "Info", "info");	        
	     return false;		
	}
	
	var futurePriceNo = $("#goodsPrcNo").val();
	if(futurePriceNo != '' && parseInt(futurePriceNo)>0){
		messager.alert("<spring:message code='admin.web.view.msg.goods.futurePriceNo.delete.first' />", "Info", "info");
		return false;
	}
	
	$("#goodsPriceForm [name='saleStrtDtm']").val(getDateStr('priceSaleStrt'));
	$("#goodsPriceForm [name='saleEndDtm']").val(getDateStr('priceSaleEnd'));
	
	var startDate = new Date($("#goodsPriceForm [name='saleStrtDtm']").val());
    var endDate = new Date($("#goodsPriceForm [name='saleEndDtm']").val());
    var nowDate = new Date();

    if(startDate.getTime() > endDate.getTime()) {
        messager.alert("신규가격 일시분이 신규가격일시분보다 크거나 같을 수 없습니다.", "Info", "info");
        // $("#goodsPriceForm [name='saleEndDtm']").val("${adminConstants.COMMON_END_DATE}");
        return false;
    }

	if($("#goodsPriceForm [name='orgSaleAmt']").val() == 0){
		messager.alert("CIS 등록 시 소비자 가격이 유효하지 않습니다.", "Info", "info");
		return false;
	}
	if($("#goodsPriceForm [name='saleAmt']").val() == 0){
		messager.alert("CIS 등록 시 공급가격이 유효하지 않습니다.", "Info", "info");
		return false;
	}
	
	if(validate.check("goodsPriceForm")) {
	    var lastprice = Number(removeComma($("#goodsPriceForm [name='saleAmt']").val()));
    	
	 	// 정상가, 매입가, 판매가가 이전과 모두 동일한 경우 alert[가격 변경된 내용이 없습니다.]-[Ok]
    	if(parseInt(removeComma($("#goodsPriceForm [name='orgSaleAmt']").val())) === $("#goodsPriceForm [name='orgSaleAmt']").data('current')
    		&& parseInt(removeComma($("#goodsPriceForm [name='saleAmt']").val())) === $("#goodsPriceForm [name='saleAmt']").data('current')
    		&& parseInt(removeComma($("#goodsPriceForm [name='splAmt']").val())) === $("#goodsPriceForm [name='splAmt']").data('current')){
    		
	    	messager.alert("<spring:message code='column.goods.price.update.none.change' />", "Info", "info");
	    	return;
    	}
	 	
	 	
	    if(checkpr(lastprice, "goodsPriceForm")) {
	    	
			$("input[name=fvrAplMethCd]:checked").each(function(){
				$("#goodsPriceForm [name='fvrVal']").val($("#fvrVal"+$(this).val()).val());
			})
			
			var formData = $("#goodsPriceForm").serializeJson();
			var stId = $("input[name='stId']:checked").val();
			if(stId == '') {
				alert('사이트 아이디가 선택되지 않았습니다. ');
				return;
			}
			$.extend(formData, { stId : stId } );
			
			messager.confirm("<spring:message code='column.goods.price.update' />",function(r){
				if(r){
					var options = {
						url : "<spring:url value='/goods/goodsPriceUpdate.do' />"
						, data : formData
						, callBack : function (data ) {
							messager.alert("<spring:message code='column.goods.price.update.final_msg' />", "Info", "info", function(){
								layer.close("goodsPrice" );
							});
						}
					};
					ajax.call(options);
				}
			});
		}
	}
}
</script>
<form id="goodsPriceForm" name="goodsPriceForm" method="post" >
	<input type="hidden" name="goodsId" value="${goodsPrice.goodsId }" id="goodsId" />
	<input type="hidden" name="goodsCstrtTpCd" value="${goodsPrice.goodsCstrtTpCd }"/>
	<input type="hidden" name="saleStrtDtm" class="validate[required]" value="" />
	<input type="hidden" name="saleEndDtm" class="validate[required]" value="" />
<!-- 	<input type="hidden" name="expDt" id="expDt" class="" value="" /> -->
		
	<table class="table_type1 popup">
		<caption><spring:message code='column.goods.update.price' /></caption>
		<colgroup>
			<col class="th-s" style="width:15%;" />
			<col style="width:50%;" />
			<col class="th-s" style="width:15%;" />
			<col style="width:25%;" />
		</colgroup>
		<tbody>
			<tr>
				<th scope="row"><spring:message code="column.goods.sale.period.current" /></th> <!-- 기간 -->
				<td colspan="3">
					<fmt:formatDate value="${goodsPrice.saleStrtDtm }" pattern="yyyy-MM-dd HH:mm"/>
					~ <fmt:formatDate value="${goodsPrice.saleEndDtm }" pattern="yyyy-MM-dd HH:mm"/>
				</td>
			</tr>
			<tr>
				<th scope="row"><spring:message code="column.goods_prc_tp_cd" /><strong class="red">*</strong></th>
				<td colspan="3">
					<select class="validate[required]" name="goodsAmtTpCd" id="goodsAmtTpCd" title="<spring:message code="column.goods_prc_tp_cd" />" onchange="changeGoodsPrcTpCd(this);" >
						<frame:select grpCd="${adminConstants.GOODS_AMT_TP}" defaultName="선택하세요" useYn="Y"
						              selectKey="${goodsPrice.goodsAmtTpCd}"
						              excludeOption="${adminConstants.GOODS_AMT_TP_30}, ${adminConstants.USR_GRP_20 eq adminSession.usrGrpCd ? adminConstants.GOODS_AMT_TP_20 : ''}"/>
					</select>
				</td>
			</tr>
			<tr>
				<th scope="row"><spring:message code="column.goods.sale.period.new" /><strong class="red">*</strong></th> <!-- 기간 -->
				<td colspan="3" id="priceDate" >
					<frame:datepicker startDate="priceSaleStrtDt"
									  startHour="priceSaleStrtHr"
									  startMin = "priceSaleStrtMn"
									  startSec="priceSaleStrtSec"
									  startValue=""
									  endDate="priceSaleEndDt"
									  endHour="priceSaleEndHr"
									  endMin ="priceSaleEndMn"
									  endSec="priceSaleEndSec"
									  endValue="${frame:addMin('yyyy-MM-dd HH:mm:ss', 30)}"
									  />
					<label class="fCheck ml10"><input name="unlimitSaleEndDate" id="unlimitSaleEndDate" type="checkbox"  onclick="checkUnlimitEndDate(this, 'priceSale' );" ><span>종료일 미지정</span></label>
				</td>
			</tr>
			<tr id="priceFvr">
				<th scope="row"><spring:message code="column.fvr_apl_meth_cd" /><strong class="red">*</strong></th> <!-- 혜택적용 방식 -->
				<td colspan="3">
					<c:forEach items="${frame:listCode(adminConstants.FVR_APL_METH)}" var="item" varStatus="status">
						<label class="fRadio ${status.index ne 0 ? 'ml20' : ''}">
							<c:set var="isChecked" value="${goodsPrice.fvrAplMethCd eq item.dtlCd ? 'Y' : 'N'}" />
							<input type="radio" name="fvrAplMethCd" id="fvrAplMethCd${item.dtlCd}" value="${item.dtlCd}" ${isChecked eq 'Y' ? "checked" : ""} onclick="fvrAplMethChange();">
							<span id="span_fvrAplMethCd${item.dtlCd}">${item.dtlNm}</span>
						</label>
							<c:if test="${adminConstants.FVR_APL_METH_20 eq item.dtlCd}" >
								<input type="text" class="w100 comma validate[required]" name="fvrVal${item.dtlCd}" id="fvrVal${item.dtlCd}" onkeyup="calSvmnPrice('fvrVal${item.dtlCd}');"
									title="<spring:message code="column.fvr_val" />" value="${isChecked eq 'Y' ? goodsPrice.fvrVal : ''}"  />
								<span class="ml5"><spring:message code="column.goods.price.unit.won" /></span>
								<span class="ml5"><spring:message code="column.goods.discount" /></span>
							</c:if>
							<c:if test="${adminConstants.FVR_APL_METH_10 eq item.dtlCd}" >
								<input type="text" class="w100 validate[required, custom[onlyDecimal]]" name="fvrVal${item.dtlCd}" id="fvrVal${item.dtlCd}" onkeypress="return checkNumber(event)" onkeyup="calSvmnPrice('fvrVal${item.dtlCd}');"
									title="<spring:message code="column.fvr_val" />" value="${isChecked eq 'Y' ? goodsPrice.fvrVal : ''}"  />
								<span class="ml5">%</span>
								<span><spring:message code="column.goods.discount" /></span>
							</c:if>
					</c:forEach>
					<input type="hidden" name="fvrVal" id="fvrVal" value="" />
				</td>
			</tr>
			<tr>
				<th scope="row"><spring:message code="column.goods.org_sale_prc" /></th> <!-- 원판매가 -->
				<td colspan="3">
					<input type="text" class="w200 comma validate[required, maxSize[10]] amt" name="orgSaleAmt" value="<fmt:formatNumber value="${goodsPrice.orgSaleAmt }" type="number" pattern="#,###,###"/>" data-current="${goodsPrice.orgSaleAmt }" title="<spring:message code="column.goods.org_sale_prc" />" />
					<span class="ml5"><spring:message code="column.goods.price.unit.won" /></span>
					<span class="ml30"><fmt:formatNumber value="${goodsPrice.orgSaleAmt }" type="number" pattern="#,###,###"/><span class="ml5"><spring:message code="column.goods.price.unit.won" /></span></span>
				</td>
			</tr>
			<tr>
				<th scope="row"><spring:message code="column.spl_prc" /></th> <!-- 매입가 -->
				<td colspan="3">
					<input type="text" class="w200 comma validate[required, maxSize[10]] amt" name="splAmt" value="<fmt:formatNumber value="${goodsPrice.splAmt }" type="number" pattern="#,###,###"/>" data-current="${goodsPrice.splAmt }" title="<spring:message code="column.spl_prc" />" />
					<span class="ml5"><spring:message code="column.goods.price.unit.won" /></span>
					<span class="ml30"><fmt:formatNumber value="${goodsPrice.splAmt }" type="number" pattern="#,###,###"/><span class="ml5"><spring:message code="column.goods.price.unit.won" /></span></span>
				</td>
			</tr>
			<tr>
				<th scope="row"><spring:message code="column.sale_prc" /></th> <!-- 판매가 -->
				<td>
					<input type="text" class="w200 comma validate[required, maxSize[10]] amt" name="saleAmt" value="<fmt:formatNumber value="${goodsPrice.saleAmt }" type="number" pattern="#,###,###"/>" data-current="${goodsPrice.saleAmt }" title="<spring:message code="column.sale_prc" />"  />
					<span class="ml5"><spring:message code="column.goods.price.unit.won" /></span>
					<span class="ml30"><fmt:formatNumber value="${goodsPrice.saleAmt }" type="number" pattern="#,###,###"/><span class="ml5"><spring:message code="column.goods.price.unit.won" /></span></span>
				</td>
				<th scope="row"><spring:message code="column.goods.margin" /></th> <!-- 판매가 -->
				<td>
					<span id="marginText"></span><span>%</span>
				</td>
			</tr>
			<tr id="rsvBuyQtyTr" style="display:none;" >
				<th scope="row"><spring:message code="column.goods.rsvBuyQty" /></th> <!-- 판매수량 -->
				<td colspan="3">
					<input type="text" class="w200 comma validate[maxSize[5]]" name="rsvBuyQty" value="" title="<spring:message code="column.goods.rsvBuyQty" />"  />
				</td>	
			</tr>
			<tr id="expDtTr" style="display:none;">
				<th scope="row"><spring:message code="column.goods.expDt" /></th> <!-- 표시유통기한 -->
				<td colspan="3">
					<frame:datepicker startDate="expDt" />
				</td>	
			</tr>
		</tbody>
	</table>
</form>