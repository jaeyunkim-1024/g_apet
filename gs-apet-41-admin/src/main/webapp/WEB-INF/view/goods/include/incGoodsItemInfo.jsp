<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<!--
fstGoodsYn: ${fstGoodsYn} in goodsItemInfo
-->
<script type="text/javascript">

	function listAttribute(){
		var attrObj = new Object();
		var attrArrays = new Array();
		var aObj = new Object();
		var aArrays = new Array();
		var attrObj2 = "";
		var options = {
				url : "<spring:url value='/goods/listAttribute.do' />"
				,data : ''
				,dataType : "json"
				,async : false
				,callBack : function(data){
					$.each(data.result, function(index, result) {
						aObj = result.attrNo+":"+ result.attrNm;
						aArrays.push(aObj);
					});
					attrArrays = aArrays.join(";");
				}
		};
		ajax.call(options);
		return attrArrays;
	}
	
	// 세트, 묶음, 옵션 상품 조회(단품추가) 팝업
	function searchSetPakGoods () {
		var curCstrtTp = "${goodsCstrtTpCd}";
		var attrYn = "";
		
		// 사이트 아이디 체크
		if($("[name='stId']:checked").length < 1){
			messager.alert("<spring:message code='admin.web.view.msg.invalid.site' />", "Info", "info");
			$("[name='stId']").focus();
			return;
		}
		// 업체 선택 여부 체크
		if($("#compNo").val() === ""){
			messager.alert("<spring:message code='admin.web.view.app.goods.company.no_select' />", "Info", "info");
			$("#compNo").focus();
			return;
		}
		
		var setGoodsCstrtTp = new Array();
		
		// 세트, 옵션 상품일 경우 (단품)
		if(curCstrtTp === "${adminConstants.GOODS_CSTRT_TP_SET}"){
			setGoodsCstrtTp.push("${adminConstants.GOODS_CSTRT_TP_ITEM}");
		}
		if(curCstrtTp === "${adminConstants.GOODS_CSTRT_TP_ATTR}"){
			setGoodsCstrtTp.push("${adminConstants.GOODS_CSTRT_TP_ITEM}");
			attrYn = "${adminConstants.COMM_YN_Y}";
		}
		// 묶음 상품일 경우 (단품+세트)
		if(curCstrtTp === "${adminConstants.GOODS_CSTRT_TP_PAK}"){
			setGoodsCstrtTp.push("${adminConstants.GOODS_CSTRT_TP_ITEM}");
			setGoodsCstrtTp.push("${adminConstants.GOODS_CSTRT_TP_SET}");
		}
		
		layerGoodsList.create(setOptionGoodsListPop(true, true, setGoodsCstrtTp, false, false, "", "", attrYn, searchSetPakGoodsCallback));
	}
	
	// 세트, 묶음, 옵션 상품 콜백
	function searchSetPakGoodsCallback (goodsList ) {
		var searchGoodsCstrtTpCd = "${goodsCstrtTpCd}";
		var rowIds = null;
		var check = false;
		var alertMsg = '';
		var stdAttrNos = new Array();
		var stdAttrNms = new Array();
		var optGrpGridList = grid.jsonData ("optGrpList");
		
		if(typeof goodsList !== "undefined" && goodsList.length > 0 ) {
			for(var i = 0; i < goodsList.length; i++ ) {
				// 단품 상품, 사이트 아이디가 같은 것만 체크
				check = false;
				var flagChkStId = false;
				var setGoods = '';
				var setAttrs = '';
				
				// 사이트 아이디가 같은가?
				$("[name='stId']:checked").each(function(){
					if($(this).val() === goodsList[i].stIds) { 
						flagChkStId = true;
					}
				});
				
				if(!flagChkStId){
					check = true;
					alertMsg += "<br>"+ goodsList[i].goodsId + ' : ' + "<spring:message code='admin.web.view.msg.goods.invalidate.notEqual.stId' />";
				}
				
				// 같은 업체의 상품인가?
				if($("#compNo").val() !== goodsList[i].compNo ) {
					check = true;
					alertMsg += "<br>"+ goodsList[i].goodsId + ' : ' +  "<spring:message code='admin.web.view.msg.goods.invalidate.notEqual.compNo' />";
				}
				
				// 중복 체크
				rowIds = $("#attrList").jqGrid("getDataIDs");
				for(var idx = 0; idx < rowIds.length; idx++) {
					if(rowIds[idx] == goodsList[i].goodsId ) {
						check = true;
						alertMsg += "<br>"+ goodsList[i].goodsId + ' : ' +  "<spring:message code='admin.web.view.msg.common.dupl.goods' />";
					}
				}
				
				// 세트 상품일 경우
				if("${adminConstants.GOODS_CSTRT_TP_SET}" === searchGoodsCstrtTpCd){
					if("${adminConstants.GOODS_CSTRT_TP_ITEM}" !== goodsList[i].goodsCstrtTpCd ) {
						check = true;
						alertMsg += "<br>"+ goodsList[i].goodsId + ' : ' +  "<spring:message code='admin.web.view.msg.goods.invalidate.add.goodsCstrtTpCd.set' />";
					}
					
					setGoods = {
							subGoodsId : goodsList[i].goodsId
							, goodsNm : goodsList[i].goodsNm
							, webStkQty : goodsList[i].webStkQty
							, cstrtQty : 1
							, isChanged : true
						}
					
// 					$("#attrList").setColProp("cstrtQty",{editable:true});
				}
				
				// 묶음 상품일 경우
				if("${adminConstants.GOODS_CSTRT_TP_PAK}" === searchGoodsCstrtTpCd){
					if("${adminConstants.GOODS_CSTRT_TP_ITEM}" !== goodsList[i].goodsCstrtTpCd && "${adminConstants.GOODS_CSTRT_TP_SET}" !== goodsList[i].goodsCstrtTpCd) {
						check = true;
						alertMsg += "<br>"+ goodsList[i].goodsId + ' :  ' + "<spring:message code='admin.web.view.msg.goods.invalidate.add.goodsCstrtTpCd.pak' />";
					}
					
					setGoods = {
						subGoodsId : goodsList[i].goodsId
						, goodsNm : goodsList[i].goodsNm
						, webStkQty : goodsList[i].webStkQty
						, saleAmt : goodsList[i].saleAmt
						, showYn : goodsList[i].showYn
						, radioShowYn : goodsList[i].showYn
						, cstrtShowNm : goodsList[i].goodsNm
						, isChanged : true
					}
				}
				
				// 묶음옵션 상품일 경우
				if("${adminConstants.GOODS_CSTRT_TP_ATTR}" === searchGoodsCstrtTpCd){
					var checkReturnVal;
					
					if("${adminConstants.GOODS_CSTRT_TP_ITEM}" !== goodsList[i].goodsCstrtTpCd) {
						check = true;
						alertMsg += "<br>"+ goodsList[i].goodsId + ' :  ' + "<spring:message code='admin.web.view.msg.goods.invalidate.add.goodsCstrtTpCd.set' />";
					}
					
					// check 필요 attrNo
					if(optGrpGridList.length !== 0 || i!==0){
						checkReturnVal = checkAttrValid(goodsList[i]);
						
						if(checkReturnVal.returnFlag){
							check = true;
							alertMsg += "<br>"+ goodsList[i].goodsId + ' :  ' + "<spring:message code='admin.web.view.msg.goods.invalidate.equal.attr' />";
						}else{
							
							setGoods = {
								subGoodsId : goodsList[i].goodsId
								, compGoodsId : goodsList[i].compGoodsId
								, goodsNm : goodsList[i].goodsNm
								, webStkQty : goodsList[i].webStkQty
								, cstrtShowNm : goodsList[i].goodsNm
								, saleAmt : goodsList[i].saleAmt
								, showYn : "${adminConstants.COMM_YN_Y}"
								, attr1No : checkReturnVal.attrNos[0]
								, attr1Val : checkReturnVal.attrVals[0]
								, attr2No : checkReturnVal.attrNos[1]
								, attr2Val : checkReturnVal.attrVals[1]
								, attr3No : checkReturnVal.attrNos[2]
								, attr3Val : checkReturnVal.attrVals[2]
								, attr4No : checkReturnVal.attrNos[3]
								, attr4Val : checkReturnVal.attrVals[3]
								, attr5No :checkReturnVal.attrNos[4]
								, attr5Val : checkReturnVal.attrVals[4]
								, isChanged : true
							}
						}
					}else{
						if(optGrpGridList.length === 0){
							stdAttrNos.push(goodsList[i].attr1No);
							stdAttrNos.push(goodsList[i].attr2No);
							stdAttrNos.push(goodsList[i].attr3No);
							stdAttrNos.push(goodsList[i].attr4No);
							stdAttrNos.push(goodsList[i].attr5No);
							
							stdAttrNms.push(goodsList[i].attr1Nm);
							stdAttrNms.push(goodsList[i].attr2Nm);
							stdAttrNms.push(goodsList[i].attr3Nm);
							stdAttrNms.push(goodsList[i].attr4Nm);
							stdAttrNms.push(goodsList[i].attr5Nm);
							
							// 라벨 변경
							jQuery("#attrList").jqGrid("setLabel", "attr1Val", goodsList[i].attr1Nm);
							jQuery("#attrList").jqGrid("setLabel", "attr2Val", goodsList[i].attr2Nm);
							jQuery("#attrList").jqGrid("setLabel", "attr3Val", goodsList[i].attr3Nm);
							jQuery("#attrList").jqGrid("setLabel", "attr4Val", goodsList[i].attr4Nm);
							jQuery("#attrList").jqGrid("setLabel", "attr5Val", goodsList[i].attr5Nm);
							
							for(var std = 0; std < stdAttrNos.length; std++ ) {
								// 속성 add
								if(stdAttrNos[std] != null && stdAttrNos[std] !== '' ){
									setAttrs = {
											attrNm : stdAttrNms[std]
											, showNm : stdAttrNms[std]
											, dispPriorRank : 0
											, attrNo : stdAttrNos[std]
									}
								
									$("#optGrpList").jqGrid("addRowData", stdAttrNos[std], setAttrs, "last", null );
								}
							}
						}
						
						setGoods = {
								subGoodsId : goodsList[i].goodsId
								, compGoodsId : goodsList[i].compGoodsId
								, goodsNm : goodsList[i].goodsNm
								, webStkQty : goodsList[i].webStkQty
								, cstrtShowNm : goodsList[i].goodsNm
								, saleAmt : goodsList[i].saleAmt
								, attr1No : goodsList[i].attr1No
								, attr1Val : goodsList[i].attr1Val
								, attr2No : goodsList[i].attr2No
								, attr2Val : goodsList[i].attr2Val
								, attr3No : goodsList[i].attr3No
								, attr3Val : goodsList[i].attr3Val
								, attr4No : goodsList[i].attr4No
								, attr4Val : goodsList[i].attr4Val
								, attr5No : goodsList[i].attr5No
								, attr5Val : goodsList[i].attr5Val
								, showYn : "${adminConstants.COMM_YN_Y}"
								, isChanged : true
							}
					}
					
				}
				
				if(!check) {
					$("#attrList").jqGrid("addRowData", goodsList[i].goodsId, setGoods, "last", null );
				}else{
					if("${adminConstants.GOODS_CSTRT_TP_ATTR}" === searchGoodsCstrtTpCd){
						//묶음 옵션 삭제
						deleteAttrGridRow();
					}
				}
			}
			
			if(alertMsg !== '' ){
				messager.alert("<spring:message code='admin.web.view.msg.goods.invalidate.noAdd.reason' />" + alertMsg, "Info", "info");
			}
		}
		//세트상품일 경우 세트재고수량 조정
		if("${adminConstants.GOODS_CSTRT_TP_SET}" === searchGoodsCstrtTpCd){
			calcStkQty();
		}
		//단품제외 대표상품여부 세팅
		if("${adminConstants.GOODS_CSTRT_TP_ITEM}" != searchGoodsCstrtTpCd){
			<c:if test="${!empty goodsBase.goodsId}" >
			setdlgtGoodsYn();
			</c:if>	
		}		
	}

	/**
	 * 묶음 옵션 삭제
	 */
	function deleteAttrGridRow () {

		var attrGrid = $("#attrList");
		var attrRowids = attrGrid.jqGrid('getGridParam', 'selarrrow');

		for (var i = attrRowids.length - 1; i >= 0; i--) {
			attrGrid.jqGrid('delRowData', attrRowids[i]);
		}

		var attrData = grid.jsonData("attrList");

		if(attrData.length === 0){
			deleteAllGridRow('optGrpList');
		}
	}

	// 상품 추가 가능 여부(속성) 
	function checkAttrValid(list){
		
		var optGrpGridList = grid.jsonData ("optGrpList");
		var attrNos = []; 
		var attrVals = [];
		var returnFlag = true;
		
		// 같은 속성이 아니면 추가 되지 않는다, 속성 개수가 같아야함
		if(optGrpGridList.length !== parseInt(list.attrCnt)){
			returnFlag = true;	
		}else{
			
			for(var i = 0; i < optGrpGridList.length; i++ ) {
				
				returnFlag = true;
				
				// 속성 순서가 다를수 있기 때문에..
				if(optGrpGridList[i].attrNo === list.attr1No) {
					returnFlag = false;
					attrNos[i] = list.attr1No;
					attrVals[i] = list.attr1Val;
				}
				if(optGrpGridList[i].attrNo === list.attr2No) {
					returnFlag = false;
					attrNos[i] = list.attr2No;
					attrVals[i] = list.attr2Val;
				}
				if(optGrpGridList[i].attrNo === list.attr3No) {
					returnFlag = false;
					attrNos[i] = list.attr3No;
					attrVals[i] = list.attr3Val;
				}
				if(optGrpGridList[i].attrNo === list.attr4No) {
					returnFlag = false;
					attrNos[i] = list.attr4No;
					attrVals[i] = list.attr4Val;
				}
				if(optGrpGridList[i].attrNo === list.attr5No) {
					returnFlag = false;
					attrNos[i] = list.attr5No;
					attrVals[i] = list.attr5Val;
				}
				
				if(returnFlag){
					break;
				}
			}
		}
		
		var returnVal = {
			returnFlag : returnFlag
			, attrNos : attrNos
			, attrVals : attrVals
		}
			
		return returnVal;	
		
	}
	
	// 매입업체 조회
	function searchPhsCompany () {
		var options = {
			multiselect : false
			, callBack : searchPhsCompanyCallback
            , compStatCd : '${adminConstants.COMP_STAT_20}'
            , excludeCompTpCd : '${adminConstants.COMP_TP_20}' +","+ '${adminConstants.COMP_TP_10}'
            , readOnlyCompStatCd : 'Y'
		}
		layerCompanyList.create (options );
	}
	
	// 매입 업체 콜백
	function searchPhsCompanyCallback (compList ) {
		if(compList.length > 0 ) {
			$("#phsCompNo").val (compList[0].compNo );
			$("#phsCompNm").val (compList[0].compNm );
		}
	}
	
	
	$(function(){
		if("${adminConstants.GOODS_CSTRT_TP_ITEM}" === "${goodsCstrtTpCd}") {	
			
			$("[name='expMngYn']").change(function(){
				// 유통기한 관리 여부가 Y 이면
				fnControlUI();
			});
			
			// 유통기한 월 직접 입력 컨트롤
			$("#expMngArea").change(function(e) {
	           if($("#expMngArea option:selected").text() == '직접입력'){
	        	   $("#expMngNum").show();
	        	   $("#expMngTxt").show();
	           }else{
	        	   $("#expMngNum").val('');
	        	   $("#expMngNum").hide();
	        	   $("#expMngTxt").hide();
	           }
	        });
			
			// 키 입력시 select 값 변경
			$("#expMngNum").on("change keyup paste", function() {
			    var currentVal = $(this).val();
			    $("#expMngLastObj").val(currentVal);
			});
		}
	})
	
	function fnControlUI(){
		
		if($("[name='expMngYn']:checked").val() === "${adminConstants.COMM_YN_N}"){
			$("[name='expMonth']").prop('disabled', true);
			$("[name='expMonth']").addClass('readonly');
			$("#expMngNum").prop('disabled', true);
			$("#expMngNum").addClass('readonly');
		}else{
			$("[name='expMonth']").prop('disabled', false);
			$("[name='expMonth']").removeClass('readonly');
			$("#expMngNum").prop('disabled', false);
			$("#expMngNum").removeClass('readonly');
		}
	}	
	
	
	
</script>
	<c:set var="isCheckCstrtUpd" value="${checkPossibleCnt.checkCstrtUpdCnt eq '0' ? true : false}" />
	<c:choose>
		<c:when test="${adminConstants.GOODS_CSTRT_TP_SET eq goodsCstrtTpCd}" >
			<c:set var="itemTitle" ><spring:message code='column.goods.cstrtTpCd.set' /></c:set>
		</c:when>
		<c:when test="${adminConstants.GOODS_CSTRT_TP_ATTR eq goodsCstrtTpCd}" >
			<c:set var="itemTitle" ><spring:message code='column.goods.cstrtTpCd.attr' /></c:set>
		</c:when>
		<c:when test="${adminConstants.GOODS_CSTRT_TP_PAK eq goodsCstrtTpCd}" >
			<c:set var="itemTitle" ><spring:message code='column.goods.cstrtTpCd.pak' /></c:set>
		</c:when>
		<c:otherwise>
			<c:set var="itemTitle" ><spring:message code='column.goods.cstrtTpCd.item' /></c:set>
		</c:otherwise>
	</c:choose>
	<input type="hidden" name="goodsCstrtTpCd" value="${empty goodsBase ? goodsCstrtTpCd : goodsBase.goodsCstrtTpCd}" />
	<input type="hidden" id="itemNo" name="itemNo" value="${goodsBase.itemNo}" />
	<input type="hidden" id="attrShowTpCd" name="attrShowTpCd" value="${goodsBase.attrShowTpCd}" />
	<div title="${itemTitle} 정보" data-options="" style="padding:10px">
<!-- 					TODO 임시 주석 처리 수정 가능 여부 확인 후 처리 필요 -->
		<c:if test="${not empty goodsBase and adminConstants.GOODS_CSTRT_TP_ITEM eq goodsCstrtTpCd }">
			<div class="mButton">
				<div class="leftInner">
					<button type="button" onclick="itemHistory();" class="btn btn-add">${itemTitle} 변경이력</button>
				</div>
			</div>
		</c:if>
		<table class="table_type1" >
			<caption>GOODS 등록</caption>
			<tbody>
				<tr id="stockTr">
					<th><spring:message code="column.stk_mng_yn" /></th>	<!-- 재고 관리 여부 -->
					<td>
						<frame:radio name="stkMngYn" grpCd="${adminConstants.COMM_YN }" selectKey="${goodsBase.stkMngYn eq null ? adminConstants.COMM_YN_Y : goodsBase.stkMngYn }" />
					</td>
					<th><spring:message code="column.min_max_ord_qty" /></th>	<!-- 최소/최대 주문 수량 -->
					<td>
						최소 : <input type="text" class="w50 numeric" name="minOrdQty" id="minOrdQty" title="<spring:message code="column.min_ord_qty" />" value="${goodsBase.minOrdQty }" />
						&nbsp;&nbsp;최대 : <input type="text" class="w50 numeric" name="maxOrdQty" id="maxOrdQty" title="<spring:message code="column.max_ord_qty" />" value="${goodsBase.maxOrdQty }" />
					</td>
				</tr>
			</tbody>
		</table>
		<hr />	
		<table class="table_type1">
			<caption>GOODS 등록</caption>
			<tbody>
			<c:choose>
				<c:when test="${adminConstants.GOODS_CSTRT_TP_PAK eq goodsCstrtTpCd || adminConstants.GOODS_CSTRT_TP_ATTR eq goodsCstrtTpCd}" >
				<tr>
					<th><spring:message code="column.goods.detail.attrShowTpCd" /></th>
					<td colspan="3">
						<label class="fCheck" >
							<c:set var="attrShowYn" value="${goodsBase.attrShowTpCd eq adminConstants.ATTR_SHOW_TP_20 ? adminConstants.SHOW_YN_Y : adminConstants.SHOW_YN_N}" />
							<frame:checkbox name="attrShowYn" grpCd="${adminConstants.SHOW_YN}" checkedArray="${attrShowYn}" excludeOption="${adminConstants.SHOW_YN_Y}" />
						</label>
					</td>
				</tr>
				</c:when>
				<c:otherwise>
					<input type="hidden" name="attrShowYn" value="${adminConstants.SHOW_YN_Y}" />
				</c:otherwise>
			</c:choose>
				<tr>
					<th scope="row">
						<c:choose>
							<c:when test="${adminConstants.GOODS_CSTRT_TP_ITEM eq goodsCstrtTpCd}" >
								<spring:message code="column.goods.option" />
							</c:when>
							<c:otherwise>
								<spring:message code="column.goods.option.cstrtTp" arguments='${itemTitle}' />
							</c:otherwise>
						</c:choose>
						<%-- FIXME 체크용<strong class="red">${empty goodsBase or isCheckCstrtUpd ? '수정가능' : '수정불가'}</strong> --%>
						<strong class="red">*</strong>
					</th>	<!-- 단품속성-->
					<td colspan="3">
					<table id="attrTable">
						<colgroup>
                               <col style="width:130px;">
                               <col style="width:100px;">
                               <col style="width:auto;">
                               <col style="width:auto;">
						</colgroup>
						<c:if test="${adminConstants.GOODS_CSTRT_TP_ITEM eq goodsCstrtTpCd}" >
<!-- 											TODO 단품일 경우 임시 처리 or 옵션 여부 기획 확인 후 hidden 변경 처리	 필요 -->
						<tr class="mb30">
							<td style="display:none;">${itemTitle} 관리<strong class="red">*</strong></td>
							<td style="display:none;">
								<c:choose>
									<c:when test="${empty goodsBase}">
										<frame:radio name="itemMngYn" grpCd="${adminConstants.MNG_YN }" selectKey="${goodsBase.itemMngYn eq null ? adminConstants.MNG_YN_Y : goodsBase.itemMngYn }" />
									</c:when>
									<c:otherwise>
										<input type="hidden" id="itemMngYn" name="itemMngYn" value="${goodsBase.itemMngYn }" />
										<frame:codeName grpCd="${adminConstants.MNG_YN }" dtlCd="${goodsBase.itemMngYn }" />
									</c:otherwise>
								</c:choose>
							</td>
							<th>기본 재고 수량</th>
							<td>
								<input type="text" class="comma custom[onlyNum], max[5000]" ${goodsBase.compGbCd eq adminConstants.COMP_GB_10 || ( empty goodsBase && adminConstants.USR_GRP_10 eq adminSession.usrGrpCd ) ? 'readonly' : '' } name="defatultItemStockCount" id="defaultItemStockCnt" value="${empty goodsBase.webStkQty ? 0 : goodsBase.webStkQty}" />
							</td>
						</tr>
						</c:if>
						<c:if test="${adminConstants.GOODS_CSTRT_TP_SET eq goodsCstrtTpCd}" >
						<tr class="mb30">							
							<th>세트 재고 수량</th>
							<td>
								<input type="text" class="comma custom[onlyNum], max[5000]" ${goodsBase.compGbCd eq adminConstants.COMP_GB_10 || ( empty goodsBase && adminConstants.USR_GRP_10 eq adminSession.usrGrpCd ) ? 'readonly' : '' } name="webSetStkQty" id="webSetStkQty" value="<fmt:formatNumber type="number" maxFractionDigits="3" value="${empty goodsBase.webStkQty ? 0 : goodsBase.webStkQty}" />" />
							</td>							
						</tr>						
						</c:if>
						<tr class="mt30" >
							<td style="vertical-align:top;">
									<div style="padding-bottom: 10px;">
										<c:choose>
											<c:when test="${adminConstants.GOODS_CSTRT_TP_SET eq goodsCstrtTpCd and ( isCheckCstrtUpd or empty goodsBase )}" >
												<button type="button" class="w90 btn" onclick="searchSetPakGoods();" ><spring:message code="column.goods.btn.add.item" /><!-- 단품추가버튼 --></button>
											</c:when>
											<c:when test="${adminConstants.GOODS_CSTRT_TP_PAK eq goodsCstrtTpCd}" >
												<button type="button" class="w90 btn" onclick="searchSetPakGoods();" ><spring:message code="column.goods.btn.add.goods" /><!-- 상품추가버튼 --></button>
											</c:when>
											<c:when test="${adminConstants.GOODS_CSTRT_TP_ATTR eq goodsCstrtTpCd}" >
												<button type="button" class="w90 btn" onclick="searchSetPakGoods();" ><spring:message code="column.goods.btn.add.item" /><!-- 상품추가버튼 --></button>
											</c:when>
											<c:when test="${adminConstants.GOODS_CSTRT_TP_ITEM eq goodsCstrtTpCd}" >
												<button type="button" class="w90 btn" onclick="addAttrList();" ><spring:message code="column.common.addition" /><!-- 추가버튼 --></button>
											</c:when>
										</c:choose>
									</div>
									<div style="padding-bottom: 10px;">
										<c:if test="${empty goodsBase or isCheckCstrtUpd}" >
											<c:choose>
												<c:when test="${adminConstants.GOODS_CSTRT_TP_ATTR eq goodsCstrtTpCd}" >
													<button type="button" class="w90 btn" onclick="deleteGridRow('attrList');" ><spring:message code="column.common.delete" /></button>
													<%--<button type="button" class="w90 btn" onclick="deleteAttrGridRow();" ><spring:message code="column.common.delete" /></button>--%>
												</c:when>
												<c:when test="${adminConstants.GOODS_CSTRT_TP_PAK eq goodsCstrtTpCd}" >
													<button type="button" class="w90 btn" onclick="deleteGridRow('attrList');" ><spring:message code="column.common.delete" /></button>
												</c:when>
												<c:when test="${adminConstants.GOODS_CSTRT_TP_SET eq goodsCstrtTpCd}" >
													<button type="button" class="w90 btn" onclick="deleteGridRow('attrList');" ><spring:message code="column.common.delete" /></button>
												</c:when>
											</c:choose>
										</c:if>
										<c:if test="${adminConstants.GOODS_CSTRT_TP_ITEM eq goodsCstrtTpCd}" >
											<button type="button" class="w90 btn" onclick="deleteGridRow('attrList');" ><spring:message code="column.common.delete" /><!-- 추가버튼 --></button>
										</c:if>
									</div>
<!-- 													<div> -->
<%-- 														<button type="button" class="w90 btn" onclick="genAttrItemList( );" ><spring:message code="column.goods.item.gen" /></button> <!-- 단품생성 --> --%>
<!-- 													</div> -->
<%-- 												</c:if> --%>
								<!-- 관리 여부가  Y이고 상품 상태가 대기, 승인거절일 경우 수정 가능 -->
								<c:if test="${not empty goodsBase }">
									<c:if test="${adminConstants.MNG_YN_Y eq goodsBase.itemMngYn }">
<!-- 														상품상태가 대기, 승인 거절일때  -->
<%-- 														<c:if test="${goodsBase.goodsStatCd eq adminConstants.GOODS_STAT_10 || goodsBase.goodsStatCd eq adminConstants.GOODS_STAT_30}"> --%>
<!-- 															<div style="padding-bottom: 10px;"> -->
<%-- 																<button type="button" class="w90 btn" onclick="resetAttrList( );" ><spring:message code="column.common.reset" /><!-- 초기화버튼 --></button> --%>
<!-- 															</div> -->
<!-- 															<div style="padding-bottom: 10px;"> -->
<%-- 																<button type="button" class="w90 btn" onclick="addAttrList( );" ><spring:message code="column.common.addition" /><!-- 추가버튼 --></button> --%>
<!-- 															</div> -->
<!-- 															<div style="padding-bottom: 10px;"> -->
<%-- 																<button type="button" class="w90 btn" onclick="deleteGridRow('attrList' );" ><spring:message code="column.common.delete" /></button> --%>
<!-- 															</div> -->
<%-- 														</c:if> --%>
<!-- 														상품상태가 대기, 승인 거절일때 		 -->
<!-- 			                                               <div> -->
<%-- 			                                                   <button type="button" class="w90 btn" onclick="genAttrItemList( );" ><spring:message code="column.goods.item.gen" /></button> <!-- 단품생성 --> --%>
<!-- 			                                               </div> -->
									</c:if>
								</c:if>
							</td>
							<td colspan="3">
								<div class="mModule no_m">
									<table id="attrList" class="grid"></table>
									<div id="attrListPage"></div>
								</div>
							</td>
						</tr>
						<c:if test="${adminConstants.GOODS_CSTRT_TP_ATTR eq goodsCstrtTpCd}" >
							<tr class="mt30" style="display:none;" > <!-- 변경되어 임시로 안보이게 처리함  -->
								<td></td>
								<td colspan="3">
									<div class="mModule no_m">
										<table id="optGrpList" class="grid"></table>
										<div id="optGrpListPage"></div>
									</div>
								</td>
							</tr>
						</c:if>
						<tr style="display:none;">
							<td style="vertical-align: text-top;">
								<div style="padding-bottom: 10px;">
									<button type="button" class="w90 btn" onclick="deleteGridRow('attrItemList' );" ><spring:message code="column.common.delete" /></button>
								</div>
							</td>
							<td colspan="3">
								<div class="mModule no_m">
									<table id="attrItemList" class="grid"></table>
									<div id="attrItemListPage"></div>
								</div>
							</td>
						</tr>
						<tr style="display:none;">
							<td colspan="3">
								<div class="mModule" >
									<table id="attrItemListCopy" ></table>
									<div id="attrItemListCopyPage"></div>
								</div>
							</td>
						</tr>
					</table>
					</td>
				</tr>
				<c:if test="${adminConstants.GOODS_CSTRT_TP_ITEM eq goodsCstrtTpCd}" >
					<tr>
						<th><spring:message code="column.goods.frbPsbYn" /></th>
						<td>
							<!-- TODO 사은품 가능여부 수정 가능 -->
							<frame:radio name="frbPsbYn" grpCd="${adminConstants.FRB_PSB_YN }" selectKey="${goodsBase.frbPsbYn eq null ? adminConstants.FRB_PSB_YN_Y : goodsBase.frbPsbYn }" />
						</td>
						<th><spring:message code="column.goods.phsCompNo" /></th>	<!-- 매입 업체 명-->
						<td>
							<c:set var="compNmPlaceholder" ><spring:message code='column.goods.search.compNm' /></c:set>
							<c:choose>
								<c:when test="${empty goodsBase && adminConstants.USR_GRP_20 eq adminSession.usrGrpCd}">
									<input type="hidden" class="validate[custom[onlyNum]]" name="phsCompNo" id="phsCompNo" title="매입업체번호" value="${adminSession.compNo }">
									<input type="text" readonly="" class="readonly" id="phsCompNm" name="phsCompNm" value="${adminSession.compNm }"  title="매입업체명" value="" placeholder="${compNmPlaceholder}">
									(${adminSession.compNo})
								</c:when>
								<c:otherwise>
									<input type="hidden" class="validate[custom[onlyNum]]" name="phsCompNo" id="phsCompNo" title="매입업체번호" value="${goodsBase.phsCompNo }">
									<input type="text" readonly="" class="readonly" id="phsCompNm" name="phsCompNm" value="${goodsBase.phsCompNm }"  title="매입업체명" value="" placeholder="${compNmPlaceholder}">
									<c:if test="${goodsBase.compGbCd eq adminConstants.COMP_GB_10 || empty goodsBase}" >
										<button type="button" class="btn" id="phsCompNoBtn" onclick="searchPhsCompany();">검색</button>
									</c:if>
									<%--<c:if test="${empty goodsBase || fstGoodsYn eq 'false'}" >
										<button type="button" class="btn" id="phsCompNoBtn" onclick="searchPhsCompany();">검색</button>
									</c:if>
									<c:if test="${not empty goodsBase.phsCompNo && fstGoodsYn ne 'false'}" >
										(${goodsBase.phsCompNo })
									</c:if>
									--%>
								</c:otherwise>
							</c:choose>
						</td>
					</tr>
					<tr>
						<th><spring:message code="column.goods.expMngYn" /></th>	<!-- 유통기한 관리 여부 -->
						<td colspan="3">
							<frame:radio name="expMngYn" grpCd="${adminConstants.MNG_YN }" selectKey="${goodsBase.expMngYn eq null ? adminConstants.MNG_YN_N : goodsBase.expMngYn }" />
						</td>
					</tr>
					<tr>
						<th><spring:message code="column.goods.expMonth" /></th>	<!-- 유통기한 월 -->
						<td colspan="3">
							<select class="" id="expMngArea" name="expMonth" ${goodsBase.expMngYn eq adminConstants.MNG_YN_N ? 'disabled="disabled"' : ''} title="<spring:message code="column.goods.expMonth" />">
								<c:forEach var="i" begin="1" end="36">
									<option value="${i}" ${goodsBase.expMonth eq i ? 'selected="selected"' : '' }>${i}</option>
								</c:forEach>
								<option id="expMngLastObj" value="${goodsBase.expMonth}" ${goodsBase.expMonth > 36 ? 'selected="selected"' : '' }>직접입력</option>
							</select>
							&nbsp;&nbsp;
							<c:choose>
								<c:when test="${ !empty goodsBase.expMonth && goodsBase.expMonth > 36}">
									<input type="text" class="numeric" maxlength="3" id="expMngNum" title="<spring:message code="column.goods.expMonth" />" value="${goodsBase.expMonth}" /><span id="expMngTxt">  *유통기한은 개월 수로 환산하여 숫자만 입력해주세요.</span>
								</c:when>
								<c:otherwise>
									<input type="text" class="numeric" maxlength="3" id="expMngNum" style="display:none;" title="<spring:message code="column.goods.expMonth" />" value="" /><span id="expMngTxt" style="display:none;">  *유통기한은 개월 수로 환산하여 숫자만 입력해주세요.</span>
								</c:otherwise>
							</c:choose>
						</td>
					</tr>
				</c:if>
			</tbody>
		</table>
	</div>
	<hr />