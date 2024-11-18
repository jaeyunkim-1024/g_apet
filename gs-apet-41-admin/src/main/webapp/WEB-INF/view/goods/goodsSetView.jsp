<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>

<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">

		$(document).ready(function(){
			var panels = $('#sale_pannel').accordion('panels');
			$.each(panels, function() {
				this.panel('expand');
			});
			$('#sale_pannel').accordion('resize');
			
			createGoodsSetGrid();
		});

		// 세트 상품 목록 리스트
		function createGoodsSetGrid(){
			var options = {
				  url : "<spring:url value='/goods/goodsCstrtGrid.do' />"
				, searchParam : {
					  goodsId : '${goodsBase.goodsId}'
					//, goodsCstrtGbCd  : '${adminConstants.GOODS_CSTRT_GB_01}' // 상품 구성 구분 코드 : 세트상품
				}
				, paging : false
				, multiselect : true
				, cellEdit : true
				, height : 170
				, colModels :  [
					  _GRID_COLUMNS.goodsId
					, _GRID_COLUMNS.goodsNm
					, _GRID_COLUMNS.dispPriorRank  
					, {name:"goodsTpCd", label:_GOODS_SEARCH_GRID_LABEL.goodsTpCd, width:"150", align:"center", sortable:false, formatter:"select", editoptions:{value:"<frame:gridSelect grpCd='${adminConstants.GOODS_CSTRT_GB}' showValue='false'/>"}} /* 상품 유형 */
					, _GRID_COLUMNS.goodsStatCd
					, _GRID_COLUMNS.useYn
					, _GRID_COLUMNS.showYn
					, {name:"saleAmt", label:"<spring:message code='column.sale_prc'/>", width:"100", align:"center", sortable:false, formatter: 'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','} } /* 판매가 */
					, {name:"bigo", label:_GOODS_SEARCH_GRID_LABEL.bigo, width:"200", align:"center", sortable:false} /* 비고 */
					, {name:"mdlNm", label:_GOODS_SEARCH_GRID_LABEL.mdlNm, width:"200", align:"center", sortable:false, multiselect : true} /* 모델명 */
					, {name:"saleAmt", label:_GOODS_SEARCH_GRID_LABEL.saleAmt, width:"100", align:"center", sortable:false, formatter: 'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','} } /* 판매가 */
					, _GRID_COLUMNS.compNm
					, _GRID_COLUMNS.bndNmKo
					, {name:"mmft", label:_GOODS_SEARCH_GRID_LABEL.mmft, width:"200", align:"center", sortable:false } /* 제조사 */
					, {name:"saleStrtDtm", label:_GOODS_SEARCH_GRID_LABEL.saleStrtDtm, width:"150", align:"center", sortable:false, formatter:gridFormat.date, dateformat:_COMMON_DATE_FORMAT }
					, {name:"saleEndDtm", label:_GOODS_SEARCH_GRID_LABEL.saleEndDtm, width:"150", align:"center", sortable:false, formatter:gridFormat.date, dateformat:_COMMON_DATE_FORMAT }
				]
			};
			grid.create("createGoodsSetList", options);
		}

		// 세트 구성 상품 추가 팝업
		function goodsSetTargetLayer() {
			var options = {
				  multiselect : true
				, callBack : function(result) {
					if(result != null) {
						var idx = $('#createGoodsSetList').getDataIDs();
						var message = new Array();

						for(var i in result){
							var check = true;

							for(var j in idx) {
								if(result[i].goodsId == idx[j]) {
									check = false;
									message.push(result[i].goodsNm + "<spring:message code='admin.web.view.msg.common.dupl.goods' />");
								}
							}

							if(result[i].goodsTpCd != '${adminConstants.GOODS_TP_10}'){ // 일반 상품이 아닐 경우
								check = false;
								message.push(result[i].goodsNm + "<spring:message code='admin.web.view.msg.common.no.normal.goods' />");
							}

							if(check) { // 체크 상태
								result[i].useYn = '${adminConstants.USE_YN_Y}'; // 기본값 : 사용여부 "Y"
								result[i].dispPriorRank = '999';	// 기본값 : 우선순위 999
								$("#createGoodsSetList").jqGrid('addRowData', result[i].goodsId, result[i], 'last', null);
							} else {

							}
						}

						if(message != null && message.length > 0) {
							messager.alert(message.join("<br/>"), "Info", "info");
						}
					}
				}
			}
			layerGoodsList.create(options);
		}

		// 세트상품 저장
		function insertGoodsSet(){

			if(validate.check("goodsInsertForm")) {

				var sendData = $("#goodsInsertForm").serializeJson();
				var priceData = $("#goodsPriceForm").serializeJson();
				var grid = $("#createGoodsSetList");

				var items = new Array();
				var goodsImgList = new Array();
				var rowids = grid.getDataIDs();		// 현재 선택되어있는 줄의 아이디 값을 반환

				if(rowids.length != 0){ 	// 구성 상품이 있을 경우
					messager.confirm("<spring:message code='column.common.confirm.insert' />",function(r){
						if(r){
							// 구성 상품
							for(var i = 0; i < rowids.length; i++) {
								var data = grid.getRowData(rowids[i]);
								items.push({
									  cstrtGoodsId : data.goodsId
									, useYn : data.useYn
									, dispPriorRank : data.dispPriorRank
								});
							}
	
							// 상품 이미지
							$("input[name=imgPath]").each (function (idx) {
								var goodsImgIdx = $(this).siblings("input[name=imgSeq]").val();		// 이미지 순번
								var imgPath = $("#imgPath" + goodsImgIdx).val();					// 첫번째 이미지 경로
								var rvsImgPath = $("#rvsImgPath" + goodsImgIdx).val();				// 두번째 이미지 경로
								var dlgtYn = $("#dlgtYn_" + goodsImgIdx).is(":checked") ? 'Y' : 'N'; // 첫번째 대표여부
								var regYn = $("#regYn" + goodsImgIdx).val();						 // 두번째 대표여부
	
								if(imgPath != "" || rvsImgPath != "" || regYn == "Y" ) {
									goodsImgList.push({
										  imgPath : imgPath
										, rvsImgPath : rvsImgPath
										, dlgtYn : dlgtYn
										, imgSeq : goodsImgIdx
									});
	
								}
							});
							$.extend(sendData, priceData);
							$.extend(data,{
									  goodsDealPOList : JSON.stringify(items)
									, goodsBasePO : JSON.stringify(sendData)
									, goodsPricePO : JSON.stringify(priceData)
									, goodsImgPO : JSON.stringify(goodsImgList)
							});
							var options = {
								url : "<spring:url value='/goods/goodsSetInsert.do' />"
								, data : data
								, callBack : function (result) {
									updateTab('/goods/goodsSetView.do?goodsId='+ result.goodsId, '세트 상품 상세');
								}
							};
							ajax.call(options);
						}
					});
				}else{
					messager.alert("<spring:message code='admin.web.view.msg.common.add.goods' />", "Info", "info", function(){
						goodsSetTargetLayer();
					});
					return;
				}
			}
		}

		// 세트 상품 수정
		function updateGoodsSet(){
			if(validate.check("goodsInsertForm")) {
				messager.confirm("<spring:message code='column.common.confirm.update' />",function(r){
					if(r){
						var sendData = $("#goodsInsertForm").serializeJson();
						var priceData = $("#goodsPriceForm").serializeJson();
						var grid = $("#createGoodsSetList");
						var items = new Array();
						var goodsImgList = new Array();
						var rowids = grid.getDataIDs();
	
						if(rowids.length <= 0 ) { // 구성 상품이 없을 경우
							messager.alert("<spring:message code='column.display_view.message.no_select' />", "Info", "info");
							return;
						} else {
							for(var i = 0; i < rowids.length; i++) {
								var data = grid.getRowData(rowids[i]);
								items.push({
									  cstrtGoodsId : data.goodsId
									, useYn : data.useYn
									, dispPriorRank : data.dispPriorRank
								});
							}
						}
	
						// 상품 이미지
						$("input[name=imgPath]").each (function (idx) {
							var goodsImgIdx = $(this).siblings("input[name=imgSeq]").val();
							var imgPath = $("#imgPath" + goodsImgIdx).val();
							var rvsImgPath = $("#rvsImgPath" + goodsImgIdx).val();
							var dlgtYn = $("#dlgtYn_" + goodsImgIdx).is(":checked") ? 'Y' : 'N';
							var regYn = $("#regYn" + goodsImgIdx).val();
	
							if(imgPath != "" || rvsImgPath != "" || regYn == "Y" ) {
								goodsImgList.push({
									  imgPath : imgPath
									, rvsImgPath : rvsImgPath
									, dlgtYn : dlgtYn
									, imgSeq : goodsImgIdx
								});
							}
						});
	
						$.extend(sendData, priceData)
						$.extend(data,{
							  updateGoodsDealPOList : JSON.stringify(items)
							, updateGoodsBasePO : JSON.stringify(sendData)
							, goodsPricePO : JSON.stringify(priceData)
							, updateGoodsImgPO : JSON.stringify(goodsImgList)
						});
	
						var options = {
							url : "<spring:url value='/goods/goodsSetUpdate.do' />"
							, data : data
							, callBack : function(result){
								updateTab();
							}
						};
						ajax.call(options);
					}
				});
			}
		}

		// 세트 상품 삭제
		function deleteGoodsSet(){
			messager.confirm("<spring:message code='column.common.confirm.delete' />",function(r){
				if(r){
					var data = $("#createGoodsSetList");
					var items = new Array();
	
					items.push({goodsId : "${goodsBase.goodsId}"});
	
					var options = {
							url : "<spring:url value='/goods/goodsSetDelete.do' />"
							, data : {
								deleteGoodsStr : JSON.stringify(items)
							}
							, callBack : function(result) {
								messager.alert("<spring:message code='column.display_view.message.delete'/>", "Info", "info", function(){
									closeGoTab("<spring:message code='admin.web.view.app.goods.set.list'/>", "/goods/goodsSetListView.do");
								});
								
							}
					};
					ajax.call(options);
				}
			});
		}

		// 구성 상품 삭제
		function goodsSetTargetDelete() {
			var rowids = $("#createGoodsSetList").jqGrid('getGridParam', 'selarrrow');
			var delRow = new Array();

			if(rowids != null && rowids.length > 0) {
				for(var i in rowids) {
					delRow.push(rowids[i]);
				}
			}
			if(delRow != null && delRow.length > 0) {
				for(var i in delRow) {
					var rowdata = $("#createGoodsSetList").getRowData(delRow[i]);

					if(!validation.isNull(rowdata.frbNo)) {
						arrPromotionFreebietDel.push({
							  frbNo : rowdata.frbNo
							, goodsId : '${promotion.goodsId}'
						});
					}
					$("#createGoodsSetList").delRowData(delRow[i]);
				}
			} else {
				messager.alert("<spring:message code='admin.web.view.msg.gift.select.gift'/>", "Info", "info");
			}
		}

		// 일괄 변경 레이어
		function useYnLayerView() {
			var grid = $("#createGoodsSetList");
			var selectedIDs = grid.getGridParam("selarrrow");

			if(selectedIDs != null && selectedIDs.length > 0) {
				var html = new Array();
				html.push('	<table class="table_type1">');
				html.push('		<caption>사용여부 일괄 변경</caption>');
				html.push('		<tbody>');
				html.push('			<tr>');
				html.push('				<th scope="row"><spring:message code="column.use_yn" /><strong class="red">*</strong></th>');
				html.push('				<td>');
				html.push('					<select name="gridUseYn" title="<spring:message code="column.use_yn"/>">');
				html.push('						<frame:select grpCd="${adminConstants.USE_YN}" showValue="true"/>');
				html.push('					</select>');
				html.push('				</td>');
				html.push('			</tr>');
				html.push('		</tbody>');
				html.push('	</table>');
				var config = {
					  id : "useYnLayer"
					, width : 500
					, height : 200
					, top : 200
					, title : "사용여부 일괄 변경"
					, body : html.join("")
					, button : "<button type=\"button\" onclick=\"useYnUpdateGrid();\" class=\"btn btn-ok\">확인</button>"
				}
				layer.create(config);
			} else {
				messager.alert("<spring:message code='column.common.content.no_select'/>", "Info", "info");
			}
		}

		// 사용여부 일괄 변경 버튼
		function useYnUpdateGrid(){
			var rowids = $("#createGoodsSetList").jqGrid('getGridParam', 'selarrrow');
			for(var i = 0; i < rowids.length; i++) {
				$("#createGoodsSetList").jqGrid('setCell', rowids[i],'useYn', $("select[name=gridUseYn]").val());
			}
			layer.close ("useYnLayer");
		}

		// callback : 업체 검색
		function searchCompany(){
			var options = {
				  multiselect : false
				, callBack : function(compList){
					if(compList.length > 0){
						$("#compNo").val (compList[0].compNo);
						$("#compNm").val (compList[0].compNm);
					}
				}
			}
			layerCompanyList.create (options);
		}

		// 브랜드 & 시리즈 검색
		function selectBrandSeries(guBrand){
			var options = null;

			if(guBrand == "brand"){
				options = {
					  multiselect : false
					, brandGbCd : '${adminConstants.BND_GB_20}'		// 브랜드 구분 코드
					, callBack : function(brandList){
						if(brandList != null && brandList.length > 0){
							$("#bndNo").val(brandList[0].bndNo);
							$("#bndNm").val(brandList[0].bndNmKo);
						}
					}
				}
			} else {
				options = {
						  multiselect : false
						, brandGbCd : '${adminConstants.BND_GB_10}'		// 시리즈 구분 코드
						, callBack : function(seriesList){
							if(seriesList != null && seriesList.length > 0){
								$("#seriesNo").val(seriesList[0].bndNo);
								$("#seriesNm").val(seriesList[0].bndNmKo);
							}
						}
					}
			}
			layerBrandList.create(options);
		}

		// 이미지 업로드
		function resultImage(file, objId){
			$("#" + objId).val(file.filePath);
			//$("#" + objId + "View").attr('src', '/common/imageView.do?filePath=' + file.filePath);
			$("#" + objId + "View").attr('src', '<frame:imgCdnUrl />' + file.filePath+"<c:out value="${adminConstants.IMG_OPT_QRY_200}"/>");
		}

		// 이미지 삭제
		function deleteImage (objId, imgSeq) {
			var imgPath = null;
			var rvsImgPath = null;

			if(objId.indexOf ("rvsImg") == 0 ) { // 이미지 순번이 0이면
				rvsImgPath = "D";
			} else {
				imgPath = "D";
			}

			messager.confirm("<spring:message code='column.common.confirm.delete' />",function(r){
				if(r){
					var options = {
						url : "<spring:url value='/goods/goodsImageDelete.do' />"
						, data : {
								  goodsId : '${goodsBase.goodsId}'
								, imgSeq : imgSeq
								, imgPath : imgPath
								, rvsImgPath : rvsImgPath
						}
						, callBack : function(data) {
							$("#" + objId).val('');
							$("#" + objId + "View").attr('src', '/images/noimage.png');
						}
					};
					ajax.call(options);
				}
			});
		}

		// 이미지 미리보기
		function goodsImgReview(imgSeq){
			var options = {
					url : "<spring:url value='/goods/goodsImageLayerView.do' />"
					, data : {
						  goodsId : '${goodsBase.goodsId}'
						, imgSeq : imgSeq
						}
					, dataType : "html"
					, callBack : function (data) {
						var config = {
							id : "goodsImgReview"
							, width : 1000
							, height : 600
							, top : 200
							, title : "상품 이미지 리뷰"
							, body : data
						}
						layer.create(config);
					}
				}
				ajax.call(options);
		}
		</script>
	</t:putAttribute>
<t:putAttribute name="content">

<div id="sale_pannel" class="easyui-accordion" data-options="multiple:true" style="width:100%">

	<div title="기본 정보" data-options="" style="padding:10px">
	<form id="goodsInsertForm" name="goodsInsertForm" method="post" >

	<!-- 상품 유형 코드 : 세트 상품 -->
	<input type="hidden" id="goodsTpCd" name="goodsTpCd" value="${adminConstants.GOODS_TP_02}" />
	
	<table class="table_type1">
		<caption>GOODS SET 등록</caption>
		<colgroup>
			<col width="170px">
			<col />
			<col width="170px">
			<col />
		</colgroup>
		<tbody>
			<tr>
				<th scope="row"><spring:message code="column.set_goods_no" /><strong class="red">*</strong></th>	<!-- set 상품 번호-->
				<td colspan="3">
					<!-- 상품 번호-->
					<c:if test="${empty goodsBase}">
						<b>자동입력</b>
					</c:if>
					<c:if test="${not empty goodsBase}">
						<input type="text" class="readonly" readonly="readonly" name="goodsId" id="goodsId" title="<spring:message code="column.deal_goods_id"/>" value="${goodsBase.goodsId}" />
					</c:if>
				</td>
			</tr>
			<tr>
				<th><spring:message code="column.goods_nm" /><strong class="red">*</strong></th>	<!-- 상품 명-->
				<td>
					<input type="text" class="w400 validate[required]" name="goodsNm" id="goodsNm" title="<spring:message code="column.goods_nm" />" value="${goodsBase.goodsNm}" />
				</td>
				<th><spring:message code="column.goods.comp_no" /><strong class="red">*</strong></th>	<!-- 업체 번호-->
				<td>
					<frame:compNo funcNm="searchCompany" requireYn="Y" defaultCompNo="${goodsBase.compNo}" defaultCompNm="${goodsBase.compNm}" />
				</td>
			</tr>
			<tr>
				<th><spring:message code="column.goods_stat_cd" /><strong class="red">*</strong></th>	<!-- 상품 상태 코드-->
				<td>
					<select class="validate[required]" name="goodsStatCd" id="goodsStatCd" title="<spring:message code="column.goods_stat_cd" />">
						<frame:select grpCd="${adminConstants.GOODS_STAT}" selectKey="${goodsBase.goodsStatCd}" />
					</select>
				</td>
				<th><spring:message code="column.show_yn" /></th>	<!-- 노출여부 -->
				<td>
					<frame:radio name="showYn" grpCd="${adminConstants.SHOW_YN}" selectKey="${goodsBase.showYn}" />
				</td>
			</tr>
			<tr>
				<th><spring:message code="column.goods.brnd" /></th>	<!-- 브랜드-->
				<td>
					<input type="hidden" id="bndNo" name="bndNo" title="<spring:message code="column.goods.brnd" />" value="${goodsBase.bndNo}" />
					<input type="text" class="readonly" id="bndNm" name="bndNm" title="<spring:message code="column.goods.brnd" />" value="${goodsBase.bndNmKo}" />
					<button type="button" class="btn" onclick="selectBrandSeries('brand');" >검색</button>
				</td>
				<th><spring:message code="column.goods.series" /></th>	<!-- 시리즈-->
				<td>
					<input type="hidden" id="seriesNo" name="seriesNo" title="<spring:message code="column.goods.series" />" value="${goodsBase.seriesNo}" />
					<input type="text" class="w175 readonly" id="seriesNm" name="seriesNm" title="<spring:message code="column.goods.series" />" value="${goodsBase.seriesNm}" />
					<button type="button" class="btn" onclick="selectBrandSeries('series');" >검색</button>
				</td>
			</tr>
		</tbody>
	</table>
	</form>
	</div>
	<hr/>
	
	<div title="가격 정보" data-options="" style="padding:10px">
	<form id="goodsPriceForm" name="goodsPriceForm" method="post" >
	<!-- 상품 가격 등록 -->
	<c:choose>
		<c:when test="${goodsPrice eq null}">
			<table class="table_type1">
				<caption>GOODS Price 등록</caption>
				<colgroup>
					<col width="170px">
					<col />
					<col width="170px">
					<col />
				</colgroup>
				<tbody>
					<tr>
						<th><spring:message code="column.sale_prc" /><strong class="red">*</strong></th>	<!-- 판매가 -->
						<td colspan="3">
							<input type="text" class="w175 comma validate[required]" name="saleAmt" id="saleAmt" onkeyup="inputSaleAmt();" title="<spring:message code="column.sale_prc" />" value="" />
						</td>
					</tr>
					<tr>
						<th><spring:message code="column.spl_prc" /><strong class="red">*</strong></th>	<!-- 공급가 -->
						<td>
							<input type="text" class="w175 comma validate[required]" name="splAmt" id="splAmt" title="<spring:message code="column.spl_prc" />" value="" />
						</td>
						<th><spring:message code="column.goods_cmsn_rt" /><strong class="red">*</strong></th>	<!-- 상품 수수료율 -->
						<td>
							<input type="text" class="w175 comma validate[required]" name="cmsRate" id="cmsRate" title="<spring:message code="column.goods_cmsn_rt" />" value="" /> %
						</td>
					</tr>
				</tbody>
			</table>
		</c:when>

		<c:otherwise>
			<div class="table_type1">
				<table>
					<caption>GOODS Price 수정</caption>
					<colgroup>
						<col width="170px">
						<col />
						<col width="170px">
						<col />
					</colgroup>
					<tbody>
						<tr>
							<th><spring:message code="column.sale_prc" /><strong class="red">*</strong></th>	<!-- 판매가 -->
							<td colspan="3">
								<fmt:formatNumber value="${goodsPrice.saleAmt}" type="number" pattern="#,###,###"/>&nbsp;원
								<input type="hidden" id="saleAmt" name="saleAmt" value="${goodsPrice.saleAmt}" />
							</td>
						</tr>
						<tr>
							<th><spring:message code="column.spl_prc" /><strong class="red">*</strong></th>	<!-- 공급가 -->
							<td>
								<fmt:formatNumber value="${goodsPrice.splAmt }" type="number" pattern="#,###,###"/>&nbsp;원
							</td>
							<th><spring:message code="column.goods_cmsn_rt" /><strong class="red">*</strong></th>	<!-- 상품 수수료율 -->
							<td>
								${goodsPrice.cmsRate }&nbsp;%
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</c:otherwise>
	</c:choose>
	</form>
	</div>
	<hr />
	
	<!-- 상품 이미지 -->
	<div title="상품 이미지" data-options="" style="padding:10px">
		<table class="table_type1">
			<caption>set 상품 이미지 등록</caption>
			<tbody>
				<tr>
					<th scope="row"><spring:message code="column.goods_img" /><strong class="red">*</strong></th>	<!-- 상품 이미지-->
					<td colspan="3">
						<table>
							<colgroup>
								<col style="width:20%;">
								<col style="width:20%;">
								<col style="width:20%;">
								<col style="width:20%;">
								<col style="width:20%;">
							</colgroup>
							<tbody>
								<tr>
									<c:if test="${goodsImg ne null and fn:length(goodsImg) gt 0 }">
										<c:forEach items="${goodsImg}" var="img" >
											<td>
												<!-- set 상품 이미지 -->
												<div class="center" style="padding-bottom: 5px; height: 250px;" >
													<input type="hidden" id="imgPath${img.imgSeq }" name="imgPath" value="" />
													<input type="hidden" id="regYn${img.imgSeq }" name="regYn" value="${((img.imgPath ne null and img.imgPath ne '') || (img.rvsImgPath ne null and img.rvsImgPath ne '') ) ? 'Y' : 'N' }" />
													<input type="hidden" id="imgSeq${img.imgSeq }" name="imgSeq" value="${img.imgSeq }" />
	
													<c:choose>
														<c:when test="${img.imgPath ne null and img.imgPath ne '' }" >
															<img id="imgPath${img.imgSeq}View" name="imgPath${img.imgSeq}View" src="<frame:imgUrl/>${img.imgPath}" class="thumb" style="width:90%;height:240px" alt="" />
														</c:when>
														<c:otherwise>
															<img id="imgPath${img.imgSeq}View" name="imgPath${img.imgSeq}View" src="/images/noimage.png" class="thumb" style="width:90%;height:240px" alt="" />
														</c:otherwise>
													</c:choose>
												</div>
												<div class="center" style="padding-bottom: 5px" >
													<button type="button" class="w90 btn" onclick="fileUpload.goodsImage(resultImage, 'imgPath${img.imgSeq}');" ><spring:message code="column.common.addition" /></button> <!-- 추가 -->
													<button type="button" class="w90 btn" onclick="deleteImage('imgPath${img.imgSeq}','${img.imgSeq}');" ><spring:message code="column.common.delete" /></button> <!-- 삭제 -->
												</div>
	
												<!-- 반대 row 상품 이미지 -->
												<div class="center" style="padding-bottom: 5px; height: 250px;" >
													<input type="hidden" id="rvsImgPath${img.imgSeq}" name="rvsImgPath" value="" />
	
													<c:choose>
														<c:when test="${img.rvsImgPath ne null and img.rvsImgPath ne ''}" >
															<img id="rvsImgPath${img.imgSeq}View" name="rvsImgPath${img.imgSeq}View" src="<frame:imgUrl/>${img.rvsImgPath}" class="thumb" style="width:90%;height:240px" alt="" />
														</c:when>
														<c:otherwise>
															<img id="rvsImgPath${img.imgSeq}View" name="rvsImgPath${img.imgSeq}View" src="/images/noimage.png" class="thumb" style="width:90%;height:240px" alt="" />
														</c:otherwise>
													</c:choose>
												</div>
												<div class="center" style="padding-bottom: 5px" >
													<button type="button" class="w90 btn" onclick="fileUpload.goodsImage(resultImage, 'rvsImgPath${img.imgSeq}');" ><spring:message code="column.common.addition" /></button> <!-- 추가 -->
													<button type="button" class="w90 btn" onclick="deleteImage('rvsImgPath${img.imgSeq}', ${img.imgSeq});" ><spring:message code="column.common.delete" /></button> <!-- 삭제 -->
												</div>
	
												<div class="center" style="padding-bottom: 5px" >
													<label class="fRadio"><input type="radio" name="dlgtYn" id="dlgtYn_${img.imgSeq}" value="Y" <c:if test="${img.dlgtYn eq 'Y'}"><c:out value=" checked='checked'" escapeXml="false" /></c:if> ><span><spring:message code="column.dlgt_yn" /></span></label>
												</div>
												<c:if test="${not empty goodsBase}">
													<div class="center" style="padding-bottom: 5px" >
														<button type="button" class="w200 btn" onclick="goodsImgReview(${img.imgSeq});" ><spring:message code="column.common.review" /></button> <!-- 미리보기 -->
													</div>
												</c:if>
											</td>
										</c:forEach>
									</c:if>
								</tr>
							</tbody>
						</table>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
</div>
<hr/ >

	<div class="mTitle">
		<h2>set 구분 상품</h2>
		<div class="buttonArea">
			<button type="button" onclick="useYnLayerView()" class="btn btn-add">사용여부 변경</button>
			<button type="button" onclick="goodsSetTargetLayer()" class="btn btn-add">추가</button>
			<button type="button" onclick="goodsSetTargetDelete()" class="btn btn-add">삭제</button>
		</div>
	</div>
	<div class="mModule no_m">
		<!-- set 구분 상품 그리드 -->
		<table id="createGoodsSetList" ></table>
	</div>

	<div class="btn_area_center">
		<c:if test="${empty goodsBase}">
			<button type="button" class="btn btn-ok" onclick="insertGoodsSet(); return false;" >등록</button>
			<button type="button" class="btn btn-cancel"  onclick="closeTab();" >취소</button>
		</c:if>
		<c:if test="${not empty goodsBase}">
			<button type="button" class="btn btn-okk" onclick="updateGoodsSet(); return false;" >수정</button>
			<button type="button" class="btn btn-add" onclick="deleteGoodsSet(); return false;" >삭제</button>
			<button type="button" class="btn btn-cancel"  onclick="closeTab();" >닫기</button>
		</c:if>
		
	</div>

	</t:putAttribute>
</t:insertDefinition>