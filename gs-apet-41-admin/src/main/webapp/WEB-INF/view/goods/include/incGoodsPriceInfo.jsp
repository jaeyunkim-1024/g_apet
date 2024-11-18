<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<script type="text/javascript">
// 가격 변경.
function goodsPriceLayer () {
	var goodsId = $("#goodsId").val();
	var options = {
		url : "<spring:url value='/goods/goodsPriceLayerView.do' />"
		, data : {goodsId : goodsId }
		, dataType : "html"
		, callBack : function (html ) {
			var config = {
				id : "goodsPrice"
				, width : 900
				, height : 600
				, top : 200
				, title : "<spring:message code='column.goods.update.price' />" 
				, body : html
				, button : "<button type=\"button\" onclick=\"updateGoodsPrice();\" class=\"btn btn-ok\">저장</button>"
			}
			layer.create(config);
		}
	};
	ajax.call(options );
	/*   var obj  = $("#goodsAmtTpCd");
	changeGoodsPrcTpCd(obj);   */
}

function goodsPriceHistory () {
	var goodsId = $("#goodsId").val();
	var options = {
		url : "<spring:url value='/goods/goodsPriceHistoryLayerView.do' />"
		, data : {goodsId : goodsId }
		, dataType : "html"
		, callBack : function (html ) {
			var config = {
				id : "goodsPriceHistory"
				, width : 800
				, height : 500
				, top : 200
				, title : "상품 가격 이력"
				, body : html
			}
			layer.create(config);
			createGoodsPriceHistoryList ();
		}
	};
	ajax.call(options );
}

function createGoodsPriceHistoryList () {
	var gridOptions = {
		url : "<spring:url value='/goods/goodsPriceHistoryGrid.do' />"
		, height : 320
		, searchParam : {goodsId : '${goodsBase.goodsId }' }
		, paging : false
		, colModels : [
			  _GRID_COLUMNS.goodsId
			, {name:"saleStrtDtm", label:'<spring:message code="column.sale_strt_dtm" />', width:"150", align:"center", key: true, sortable:false, formatter:gridFormat.date, dateformat:"${adminConstants.COMMON_DATE_FORMAT }" }
			, {name:"saleEndDtm", label:'<spring:message code="column.sale_end_dtm" />', width:"150", align:"center", key: true, sortable:false, formatter:gridFormat.date, dateformat:"${adminConstants.COMMON_DATE_FORMAT }" }
			/* , {name:"splAmt", label:'<spring:message code="column.spl_prc" />', width:"100", align:"center", sortable:false, formatter: 'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','} } */
			, {name:"saleAmt", label:'<spring:message code="column.sale_prc" />', width:"80", align:"center", sortable:false, formatter: 'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','} }
			, {name:"goodsAmtTpCd", label:"<spring:message code='column.goods_amt_tp_cd' />", width:"90", align:"center", sortable:false, formatter:"select", editoptions:{value:"<frame:gridSelect grpCd='${adminConstants.GOODS_AMT_TP }' showValue='false' />" } }
			,{name:"rsvBuyQty", label:"<spring:message code='column.goods.rsvBuyQty' />", width:"90",align:"center",sortable:false}
			,{name:"expDt", label:"<spring:message code='column.goods.expDt' />", width:"90",align:"center",sortable:false, formatter:gridFormat.date, dateformat:"yyyy-MM-dd"} 
			//, {name:"cmsRate", label:'<spring:message code="column.cms_rate" />', width:"100", align:"center", sortable:false, formatter: 'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' %', thousandsSeparator:','} }
			, {name:"fvrAplMethCd", label:"<spring:message code='column.fvr_apl_meth_cd' />", width:"100", align:"center", sortable:false, formatter:"select", editoptions:{value:"<frame:gridSelect grpCd='${adminConstants.FVR_APL_METH }' showValue='false' />" } }
			, {name:"fvrVal", label:'<spring:message code="column.fvr_val" />', width:"60", align:"center", sortable:false }
            , {name:"delYn", label:'<spring:message code="column.del_yn" />',width:"70",align:"center",sortable:false, formatter:"select", editoptions:{value:"<frame:gridSelect grpCd='${adminConstants.DEL_YN }' showValue='false' />" }}
            , _GRID_COLUMNS.goodsId.sysRegrNm
            , _GRID_COLUMNS.goodsId.sysRegDtm
		]
	}
	grid.create("goodsPricehistoryList", gridOptions);
}

//수수료율보기
function fnGoodsCmsRateView(goodsId, saleAmt) {
	 var options = {
			  url : '/goods/goodsCmsRatePopView.do'
			, data : {
				goodsId : goodsId,
            saleAmt : saleAmt
			}
			, dataType : "html"
			, callBack : function (html ) {
				var config = {
					id : "goodsCmsRateView"
					, width : 600
					, height : 350
					, top : 200
					, title : "사이트별 상품 수수료율"
					, body : html
				}
				
				<c:if test="${adminConstants.USR_GRP_10 eq adminSession.usrGrpCd}" >
				$.extend(config, {button : '<button type="button" onclick="updateCmsRate();" class="btn btn-ok">수정</button>'});
				</c:if>
				
				layer.create(config);
			}
           
       };
		ajax.call(options);
}

// 할인가격 보기
function fnGoodsPrmtPriceView(goodsId) {
	var options = {
		  url : '/goods/goodsPrmtPricePopView.do'
		, data : {
			goodsId : goodsId
		}
		, dataType : "html"
		, callBack : function (html ) {
			var config = {
				id : "goodsPrmtPriceView"
				, width : 900
				, height : 350
				, top : 200
				, title : "상품 프로모션 적용 가격"
				, body : html
			}
			layer.create(config);
		}
    };
	ajax.call(options);
}

// 등록만 - TOBE 사용안함
function fnCompCmsRateView(){
	var compNo  = $("#compNo").val();
	var saleAmt = $("#saleAmt").val();
	
    var options = {
			url : "<spring:url value='/goods/compCmsRatePopView.do' />"
			, data : {compNo : compNo, saleAmt : saleAmt}
			, dataType : "html"
			, callBack : function (data ) {
				var config = {
					id : "compCmsRateView"
					, width : 550
					, height : 300
					, top : 200
					, title : "사이트별 상품 수수료율"
					, body : data
				}
				layer.create(config);
			}
		}
		ajax.call(options );

}


// 가격 valid
function checkpr(saleprice, formName){
	//판매가가 공급가 및 원가 보다 커야 함
	if(saleprice == 0){ // 일반가 변경일 경우
		saleprice = Number(removeComma($("#" + formName + " input[name='saleAmt']").val()));
	}
	var splprice = Number(removeComma($("#" + formName + " input[name='splAmt']").val()));

	if(splprice >= saleprice){
		messager.alert("<spring:message code='admin.web.view.msg.goods.saleprice.more.than.splprice' />", "Info", "info");
		return false;
	}
	/*
	원가(costprice)는 사용하지 않음.
	else if(costprice > saleprice){
		messager.alert("<spring:message code='admin.web.view.msg.goods.saleprice.more.than.costprice' />", "Info", "info");
		return false;
	}
	*/
	else{
		return true;
	}
}
</script>
			<div title="가격 정보" data-options="" style="padding:10px">
		<c:choose>
			<c:when test="${goodsPrice eq null }">
				<c:if test="${adminConstants.USR_GRP_10 eq adminSession.usrGrpCd}" >
					<table class="table_type1">
						<caption>GOODS 등록</caption>
						<tbody>
							<tr>
								<th><spring:message code="column.sale_prc" /><strong class="red">*</strong></th>	<!-- 판매가 -->
								<td colspan="3" >
									<input type="text" class="w200 comma validate[required, maxSize[10]]" name="saleAmt" id="saleAmt" title="<spring:message code="column.sale_prc" />" value="" placeholder="먼저 업체를 선택하고 입력하세요." readonly/> 원
<!-- 									&nbsp;&nbsp; -->
<!-- 									<span id="compCmsRateSpan" style='display: none;'  > -->
<!-- 										<button type="button" onclick="fnCompCmsRateView()" class="btn">수수료율</button> -->
<!-- 									</span>		 -->
								</td>
								<%-- <th><spring:message code="column.spl_prc" /></th> <!-- 공급가 -->
                                <td>
                                    <input type="text" class="w175 comma custom[onlyNum] readonly" name="splAmt" id="splAmt" title="<spring:message code="column.spl_prc" />" value="" placeholder="판매가 입력 시 자동 계산됩니다" readonly/> 원
                                </td>
							</tr>
							<tr> 
								<th><spring:message code="column.goods_cmsn_rt" /><strong class="red">*</strong></th>	<!-- 상품 수수료율 -->
								<td>
									<input type="text" class="w175 comma custom[onlyNum], maxSize[100] readonly" name="cmsRate" id="cmsRate" title="<spring:message code="column.goods_cmsn_rt" />" value=""  placeholder="업체를 선택하면 자동 입력됩니다" readonly/> %
									<span id="compCmsRateSpan" style='display: none;'  >
										<button type="button" onclick="fnCompCmsRateView()" class="btn">공급가</button>
									</span>									
								</td>
									--%>	
							</tr>
							<tr>
								<th><spring:message code="column.goods.org_sale_prc" /><strong class="red">*</strong></th>	<!-- 정상가 -->
								<td colspan="3" >
									<input type="text" class="w200 comma validate[required, maxSize[10]]" name="orgSaleAmt" title="<spring:message code="column.org_sale_prc" />" value="" placeholder="먼저 업체를 선택하고 입력하세요." readonly/> 원
								</td>
							</tr>
							<tr>
								<th><spring:message code="column.spl_prc" /><strong class="red">*</strong></th>	<!-- 공급가 -->
								<td colspan="3" >
									<input type="text" class="w200 comma validate[required, maxSize[10]]" name="splAmt" title="<spring:message code="column.spl_prc" />" value="" placeholder="먼저 업체를 선택하고 입력하세요." readonly/> 원
								</td>
							</tr>
						</tbody>
					</table>
				</c:if>
				<c:if test="${adminConstants.USR_GRP_10 ne adminSession.usrGrpCd}" >
					<table class="table_type1">
						<caption>GOODS 등록</caption>
						<tbody>
							<tr>
								<th><spring:message code="column.sale_prc" /><strong class="red">*</strong></th>	<!-- 판매가 -->
								<td colspan="3">
									<input type="text" class="w200 comma validate[required, maxSize[10]]" name="saleAmt" id="saleAmt" title="<spring:message code="column.sale_prc" />" value="" placeholder="먼저 업체를 선택하고 입력하세요." readonly/> 원
									
<!-- 									&nbsp;&nbsp; -->
<!-- 									<span id="compCmsRateSpan" style='display: none;'  > -->
<!-- 										<button type="button" onclick="fnCompCmsRateView()" class="btn">수수료율</button> -->
<!-- 									</span> -->
									
								</td>
								<%-- <th><spring:message code="column.spl_prc" /></th> <!-- 공급가 -->
                                <td>
                                    <input type="text" class="w175 comma custom[onlyNum] readonly" name="splAmt" id="splAmt" title="<spring:message code="column.spl_prc" />" value="" placeholder="판매가 입력 시 자동 계산됩니다"  readonly/> 원
                                </td>
							</tr>
							<tr>
								<th><spring:message code="column.goods_cmsn_rt" /><strong class="red">*</strong></th>	<!-- 상품 수수료율 -->
								<td>
									<input type="text" class="w175 comma custom[onlyNum], max[100] readonly" readonly="readonly" maxlength="3" name="cmsRate" id="cmsRate" title="<spring:message code="column.goods_cmsn_rt" />" placeholder="업체를 선택하면 자동 입력됩니다" value="${cclPlc.cmsRate}" readonly/> %
								</td>
								 --%>
							</tr>
							<tr>
								<th><spring:message code="column.goods.org_sale_prc" /><strong class="red">*</strong></th>	<!-- 정상가 -->
								<td colspan="3" >
									<input type="text" class="w200 comma validate[required, maxSize[10]]" name="orgSaleAmt" title="<spring:message code="column.org_sale_prc" />" value="" placeholder="먼저 업체를 선택하고 입력하세요." readonly/> 원
								</td>
							</tr>
							<tr>
								<th><spring:message code="column.spl_prc" /><strong class="red">*</strong></th>	<!-- 공급가 -->
								<td colspan="3" >
									<input type="text" class="w200 comma validate[required, maxSize[10]]" name="splAmt" title="<spring:message code="column.spl_prc" />" value="" placeholder="먼저 업체를 선택하고 입력하세요." readonly/> 원
								</td>
							</tr>
						</tbody>
					</table>

				</c:if>
			</c:when>
			<c:otherwise>
				<c:if test="${adminConstants.USR_GRP_10 eq adminSession.usrGrpCd}" >
				<div class="mButton">
					<div class="leftInner">
						<button type="button" onclick="goodsPriceLayer();" class="btn btn-add">가격변경</button>
						<button type="button" onclick="goodsPriceHistory();" class="btn btn-add">가격변경이력</button>
					</div>
				</div>
				<table class="table_type1">
					<caption>GOODS 등록</caption>
					<tbody>
						<tr>
							<th><spring:message code="column.sale_prc" /><strong class="red">*</strong></th>	<!-- 판매가 -->
							<td>
								<fmt:formatNumber value="${goodsPrice.saleAmt }" type="number" pattern="#,###,###"/>&nbsp;원
								<input type="hidden" id="saleAmt" name="saleAmt" value="${goodsPrice.saleAmt }" />
								&nbsp;&nbsp;
<%-- 								<button type="button" onclick="fnGoodsPrmtPriceView('${goodsBase.goodsId }')" class="btn">프로모션 가격</button> --%>
<!-- 								&nbsp;&nbsp; -->
<%-- 								<button type="button" onclick="fnGoodsCmsRateView('${goodsBase.goodsId }', ${goodsPrice.saleAmt })" class="btn">수수료율</button> --%>
							</td>
                               <%-- <th><spring:message code="column.spl_prc" /></th> <!-- 공급가 -->
                               <td>
                                   <fmt:formatNumber value="${goodsPrice.splAmt }" type="number" pattern="#,###,###"/>${goodsPrice.splAmt eq null ? '미입력' : '&nbsp;원'}
                               </td>
						</tr>
						<tr>
							<th><spring:message code="column.goods_cmsn_rt" /><strong class="red">*</strong></th>	<!-- 상품 수수료율 -->
							<td ><button type="button" onclick="fnGoodsCmsRateView('${goodsBase.goodsId }', ${goodsPrice.saleAmt })" class="btn_h25_type1">수수료율</button>
								<%-- ${goodsPrice.cmsRate }&nbsp;%  
							</td>
						 	--%>	
						</tr>
						<tr>
							<th><spring:message code="column.goods.org_sale_prc" /><strong class="red">*</strong></th>	<!-- 정상가 -->
							<td>
								<fmt:formatNumber value="${goodsPrice.orgSaleAmt }" type="number" pattern="#,###,###"/>&nbsp;원
								<input type="hidden" name="orgSaleAmt" value="${goodsPrice.orgSaleAmt }" />
							</td>
						</tr>
						<tr>
							<th><spring:message code="column.spl_prc" /><strong class="red">*</strong></th>	<!-- 공급가 -->
							<td>
								<fmt:formatNumber value="${goodsPrice.splAmt }" type="number" pattern="#,###,###"/>&nbsp;원
								<input type="hidden" name="splAmt" value="${goodsPrice.splAmt }" />
							</td>
						</tr>
					</tbody>
				</table>
				</c:if>
				<c:if test="${adminConstants.USR_GRP_20 eq adminSession.usrGrpCd}" >
                <div class="mButton">
                    <div class="leftInner">
                        <button type="button" onclick="goodsPriceLayer();" class="btn">가격변경</button>
                        <button type="button" onclick="goodsPriceHistory();" class="btn">가격변경이력</button>
                    </div>
                </div>
				<table class="table_type1">
					<caption>GOODS 등록</caption>
					<tbody>
						<tr>
							<th><spring:message code="column.sale_prc" /><strong class="red">*</strong></th>	<!-- 판매가 -->
							<td colspan="3">
								<fmt:formatNumber value="${goodsPrice.saleAmt }" type="number" pattern="#,###,###"/>&nbsp;원
								<input type="hidden" id="saleAmt" name="saleAmt" value="${goodsPrice.saleAmt }" />
                                   &nbsp;&nbsp;
<%--                                    <button type="button" onclick="fnGoodsPrmtPriceView('${goodsBase.goodsId }')" class="btn">프로모션 가격</button> --%>
<!--                                    &nbsp;&nbsp;	 -->
<%--                                    <button type="button" onclick="fnGoodsCmsRateView('${goodsBase.goodsId }', ${goodsPrice.saleAmt })" class="btn">수수료율</button>								 --%>
							</td>
                               <%-- <th><spring:message code="column.spl_prc" /></th> <!-- 공급가 -->
                               <td>
                                   <fmt:formatNumber value="${goodsPrice.splAmt }" type="number" pattern="#,###,###"/>${goodsPrice.splAmt eq null ? '미입력' : '&nbsp;원'}
                               </td>								
						</tr>
						<tr> 
							<th><spring:message code="column.goods_cmsn_rt" /><strong class="red">*</strong></th>	<!-- 상품 수수료율 -->
							<td><button type="button" onclick="fnGoodsCmsRateView('${goodsBase.goodsId }', ${goodsPrice.saleAmt })" class="btn_h25_type1">수수료율</button>
								  ${goodsPrice.cmsRate }&nbsp;%  
							</td>
						--%>	
						</tr>
						<tr>
							<th><spring:message code="column.goods.org_sale_prc" /><strong class="red">*</strong></th>	<!-- 정상가 -->
							<td>
								<fmt:formatNumber value="${goodsPrice.orgSaleAmt }" type="number" pattern="#,###,###"/>&nbsp;원
								<input type="hidden" name="orgSaleAmt" value="${goodsPrice.orgSaleAmt }" />
							</td>
						</tr>
						<tr>
							<th><spring:message code="column.spl_prc" /><strong class="red">*</strong></th>	<!-- 공급가 -->
							<td>
								<fmt:formatNumber value="${goodsPrice.splAmt }" type="number" pattern="#,###,###"/>&nbsp;원
								<input type="hidden" name="splAmt" value="${goodsPrice.splAmt }" />
							</td>
						</tr>
					</tbody>
				</table>
				
				</c:if>
			</c:otherwise>
		</c:choose>

			</div>
			<hr />