<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="/WEB-INF/tld/frame.tld" prefix="frame" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page import="front.web.config.constants.FrontWebConstants" %>

<!-- inputHtml start -->
<input type="hidden" id="selected_attrNo_$goodsId_$attrNo" name="selected_attrNo" value="$attrNo">
<input type="hidden" id="selected_attrVal_$goodsId_$attrNo" name="selected_attrVal" value="">
<!-- inputHtml end-->
#devide    
<!-- optHtml start -->
<dl class="option_list">
    <dt>$attrNm</dt>
    <dd>
        <select class="select" title="옵션선택" name="select_$attrNo" onchange="goodsSelect.chooseOption('$goodsId', '$attrNo', this.value);" style="width:590px;">
            <option value="">$attrNm 선택</option>
            $options
        </select>
    </dd>
</dl>
<!-- optHtml end -->
#devide
<!-- qtyHtml start -->
<span style="display:none" class="qty" id="qty">1</span>
<input type="hidden" id="saleAmt_$goodsId" value="$saleAmt">
<!-- qtyHtml end -->

#devide
<!-- goodsSelect html start -->
<div class="option_list_gray">
    <ul>
        <li name="item_into_$itemNo">
            <input type="hidden" name="goodsIds" value="$goodsId">
            <input type="hidden" name="itemNos" value="$itemNo">
            <div class="option_name">$itemNm
            $addOption
            </div>
            <div class="ui_qty_box" name="select_opt_$itemNo">
                <a href="#" class="btn_down" onclick="goodsSelect.qtyDown($itemNo);return false;">
                    <span>감소</span>
                </a>
                <input type="hidden" class="amt" value="$saleAmt">
                <input type="hidden" id="buy_qty_$itemNo" name="buyQtys" value="$qty">
                <input type="hidden" class="addSaleAmt" value="0">
                <span class="qty">$qty</span>
                <a href="#" class="btn_up" onclick="goodsSelect.qtyUp($itemNo);return false;">
                    <span>증가</span>
                </a>
            </div>
            <input type="hidden" name="price" value="$price">
            <input type="hidden" name="asbSvcYns" value="$assemYn">
            <div class="price">$formatPrice 원</div>
            $deleteOption
        </li>
    </ul>
</div>
<!-- goodsSelect html end -->