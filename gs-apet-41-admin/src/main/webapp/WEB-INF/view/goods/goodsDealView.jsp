<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>

<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">

		$(document).ready(function(){
			createGoodsDealGrid();
		});

		// 딜 상품 목록 리스트
		function createGoodsDealGrid(){
			var options = {
				  url : "<spring:url value='/goods/goodsCstrtGrid.do' />"
				, searchParam : {
					  goodsId : '${goodsBase.goodsId}'
					, goodsCstrtGbCd  : '${adminConstants.GOODS_CSTRT_GB_10}' // 상품 구성 구분 코드
				}
				, paging : false
				, multiselect : true
				, cellEdit : true
				, height : 170
				, colModels :  [
					  _GRID_COLUMNS.goodsId
					, _GRID_COLUMNS.goodsNm
					, {name:"stNms", label:'<spring:message code="column.st_nm" />', width:"200", align:"center", sortable:false } /* 사이트 명 */
					, {name:"dispPriorRank", label:"<spring:message code='column.display_view.disp_prior_rank' />", width:"60", align:"center", formatter:'integer', editable:true} /* 전시 우선 순위 */
					, {name:"goodsTpCd", label:"<spring:message code='column.goods_tp_cd' />", width:"150", align:"center", sortable:false, formatter:"select", editoptions:{value:"<frame:gridSelect grpCd='${adminConstants.GOODS_TP}' showValue='false'/>"}} /* 상품 구성 유형 */
					, _GRID_COLUMNS.goodsStatCd
					, _GRID_COLUMNS.goodsStatCd
					, _GRID_COLUMNS.useYn
					, _GRID_COLUMNS.showYn
					, {name:"bigo", label:"<spring:message code='column.bigo' />", width:"200", align:"center", sortable:false} /* 비고 */
					, {name:"mdlNm", label:"<spring:message code='column.mdl_nm' />", width:"200", align:"center", sortable:false} /* 모델명 */
					, {name:"saleAmt", label:"<spring:message code='column.sale_prc' />", width:"100", align:"center", sortable:false, formatter: 'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','} } /* 판매가 */
					, {name:"mmft", label:"<spring:message code='column.mmft' />", width:"200", align:"center", sortable:false } /* 제조사 */
					, {name:"saleStrtDtm", label:"<spring:message code='column.sys_regr_nm' />", width:"150", align:"center", sortable:false, formatter:gridFormat.date, dateformat:_COMMON_DATE_FORMAT }
					, {name:"saleEndDtm", label:"<spring:message code='column.sys_reg_dtm' />", width:"150", align:"center", sortable:false, formatter:gridFormat.date, dateformat:_COMMON_DATE_FORMAT }
				]
			};
			grid.create("createGoodsDealList", options);
		}

		// 딜 상품 추가 팝업
		function goodsDealTargetLayer() {
			var options = {
				  multiselect : true
				, callBack : function(newGoods) {
					if(newGoods != null) {
						var dealGoods = $('#createGoodsDealList').getDataIDs();
						var message = new Array();
						
						// 현재 딜 상품의 적용사이트 추출
						var dealGoodsStIdArray = [];
						$("input:checkbox[name='stId']:checked").each(function () {
							dealGoodsStIdArray.push($(this).val());
						});

						for(var ng in newGoods){
							var check = true;
							
							// 새로 추가할 딜 상품의 사이트 아이디 추출
							var newDealGoodsStIdArray = newGoods[ng].stIds.split("|");
							
							// 새로 추가할 상품의 사이트 아이디가 현재 쿠폰의 적용사이트에 속하는지 확인
							for (var si in newDealGoodsStIdArray) {
								if (jQuery.inArray(newDealGoodsStIdArray[si], dealGoodsStIdArray) < 0) {
									check = false;
								} else {
									// 일치하는 사이트아이디가 있으면 바로 통과
									check = true;
									break;
								}
							}
							
							// 적용사이트에 속하지 않아서 적용불가 메시지 추가
							if (check == false) {
								message.push(newGoods[ng].goodsNm + "<spring:message code='admin.web.view.msg.common.miss.site' />");
							}

							for(var j in dealGoods) {
								if(newGoods[ng].goodsId == dealGoods[j]) {
									check = false;
									message.push(newGoods[ng].goodsNm + "<spring:message code='admin.web.view.msg.common.dupl.goods' />");
								}
							}

							if(newGoods[ng].goodsTpCd != '${adminConstants.GOODS_TP_10}'){ // 일반 상품이 아닐 경우
								check = false;
								message.push(newGoods[ng].goodsNm + "<spring:message code='admin.web.view.msg.common.no.normal.goods' />");
							}

							if(check) { // 체크 상태
								newGoods[ng].useYn = '${adminConstants.USE_YN_Y}';
								newGoods[ng].dispPriorRank = '999';
								$("#createGoodsDealList").jqGrid('addRowData', newGoods[ng].goodsId, newGoods[ng], 'last', null);
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

		//딜상품 등록
		function insertGoodsDeal(){
			if(validate.check("goodsInsertForm")) {
				
				// 사이트 선택 체크. hjko 2017.01.10
				var stGoodsMapPO = new Array();	
				var chkStCnt = $("input[name='stId']:checked").length;
				if (chkStCnt == 0) {
					messager.alert("<spring:message code='column.site_msg' />", "Info", "info");
					return false;
				} else {
					$("input[name='stId']:checked").each(function(index, ob){
						stGoodsMapPO.push( {stId : $(this).val() , goodsId : $("#goodsId").val() } );
					});
				}

				// 마스터 데이터
				var sendData = $("#goodsInsertForm").serializeJson();
				var grid = $("#createGoodsDealList");
				var items = new Array();
				var rowids = grid.getDataIDs();// 현재 선택되어있는 줄의 아이디 값을 반환

				if(rowids.length != 0){ 	// 구성 상품이 있을 경우
					messager.confirm("<spring:message code='column.common.confirm.insert' />",function(r){
						if(r){
							// 딜 상품 리스트 데이터
							for(var i = 0; i < rowids.length; i++) {
								var data = grid.getRowData(rowids[i]);
								items.push({
									  cstrtGoodsId : data.goodsId
									, useYn : data.useYn
									, dispPriorRank : data.dispPriorRank
									, saleAmt : data.saleAmt
								});
							}
							$.extend(sendData, {  //마스터 데이터와 딜 상품 리스트 담김
								goodsDealPOList : JSON.stringify(items),
								goodsBasePO : JSON.stringify(sendData),
								stGoodsMapPO : JSON.stringify(stGoodsMapPO)
							});
							var options = {
								url : "<spring:url value='/goods/goodsSetInsert.do' />"
								, data : sendData
								, callBack : function (result) {
									updateTab('/goods/goodsDealView.do?goodsId=' + result.goodsId, 'Deal 상품 상세');
								}
							};
							ajax.call(options);
						}
					});
				}else{
					messager.alert("<spring:message code='admin.web.view.msg.common.add.goods' />", "Info", "info", function(){
						goodsDealTargetLayer();
					});
					return;
				}
			}
		}
		
		// 딜 상품 상태 변경
		$(document).on("change", "#goodsStatCd", function() {	
			
			var goodsStatCd = "${goodsBase.goodsStatCd}";
			var newGoodsState = $(this).val();
			
			if (newGoodsState < goodsStatCd) {
				if (newGoodsState == '${adminConstants.GOODS_STAT_10}' && goodsStatCd == '${adminConstants.GOODS_STAT_20}') {
					// 승인요청 --> 대기(중)으로 변경은 허용함.
					messager.alert("<spring:message code="admin.web.view.app.goods.manage.detail.alert.goods_state_wait" />", "Info", "");
				} else if (newGoodsState == '${adminConstants.GOODS_STAT_40}' && goodsStatCd == '${adminConstants.GOODS_STAT_50}') {
					// 판매중지 --> 판매중으로 변경은 허용함.
					messager.alert("<spring:message code="admin.web.view.app.goods.manage.detail.alert.goods_state_restart" />", "Info", "info");
				} else {
					// 이전 단계로 변경은 허용하지 않음.
					messager.alert("<spring:message code='admin.web.view.app.goods.manage.detail.alert.goods_state_invalid' />", "Info", "info", function(){
						$("#goodsStatCd").val(goodsStatCd);
					});	
				}
			}
		});

		//딜 상품 수정
		function updateGoodsDeal(){
			if(validate.check("goodsInsertForm")) {
				
				// 사이트 선택 체크. hjko 2017.01.10
				var stGoodsMapPO = new Array();	
				var chkStCnt = $("input[name='stId']:checked").length;
				if (chkStCnt == 0) {
					messager.alert("<spring:message code='column.site_msg' />", "Info", "info");
					return false;
				} else {
					$("input[name='stId']:checked").each(function(index, ob){
						stGoodsMapPO.push( {stId : $(this).val() , goodsId : $("#goodsId").val() } );
					});
				}
				
				messager.confirm("<spring:message code='column.common.confirm.update' />",function(r){
					if(r){
						var sendData = $("#goodsInsertForm").serializeJson();
						var grid = $("#createGoodsDealList");
						var items = new Array();
						var rowids = grid.getDataIDs();

						if(rowids.length <= 0 ) {
							messager.alert("<spring:message code='column.display_view.message.no_select' />", "Info", "info");
							return;
						} else {
							for(var i = 0; i < rowids.length; i++) {
								var data = grid.getRowData(rowids[i]);
								items.push({
									  cstrtGoodsId : data.goodsId
									, useYn : data.useYn
									, dispPriorRank : data.dispPriorRank
									, saleAmt : data.saleAmt
								});

								$.extend(sendData, {  //마스터 데이터와 딜 상품 리스트 담김
									  updateGoodsDealPOList : JSON.stringify(items)
									, updateGoodsBasePO : JSON.stringify(sendData)
									, stGoodsMapPO : JSON.stringify(stGoodsMapPO)
								});
							}
						}
						var options = {
							url : "<spring:url value='/goods/goodsSetUpdate.do' />"
							, data : sendData
							, callBack : function(result){
								messager.alert("<spring:message code='column.common.edit.final_msg' />", "Info", "info", function(){
									updateTab();
								});
							}
						};
						ajax.call(options);
					}
				});
				
			}
		}

		// Deal 상품 삭제
		function deleteGoodsDeal(){
			messager.confirm("<spring:message code='column.common.confirm.delete' />",function(r){
				if(r){
					var data = $("#createGoodsDealList");
					var items = new Array();
	
					items.push({goodsId : "${goodsBase.goodsId}"});
	
					console.debug (items.goodsId);
	
					var options = {
							url : "<spring:url value='/goods/goodsSetDelete.do' />"
							, data : {
								deleteGoodsStr : JSON.stringify(items)
							}
							, callBack : function(result) {
								messager.alert("<spring:message code='column.display_view.message.delete'/>", "Info", "info", function(){
									closeGoTab('Deal 상품 목록', '/goods/goodsDealListView.do');
								});
							}
					};
					ajax.call(options);
				}
			});
		}

		// 구성 상품 삭제
		function goodsDealTargetDelete() {
			var rowids = $("#createGoodsDealList").jqGrid('getGridParam', 'selarrrow');
			var delRow = new Array();

			if(rowids != null && rowids.length > 0) {
				for(var i in rowids) {
					delRow.push(rowids[i]);

				}
			}
			if(delRow != null && delRow.length > 0) {
				for(var i in delRow) {
					var rowdata = $("#createGoodsDealList").getRowData(delRow[i]);
					if(!validation.isNull(rowdata.frbNo)) {
						arrPromotionFreebietDel.push({
							  frbNo : rowdata.frbNo
							, goodsId : '${promotion.goodsId}'
						});
					}
					$("#createGoodsDealList").delRowData(delRow[i]);
				}
			} else {
				messager.alert("<spring:message code='admin.web.view.msg.deal.select.good' />", "Info", "");
			}
		}

		function useYnLayerView() {
			var grid = $("#createGoodsDealList");
			var selectedIDs = grid.getGridParam("selarrrow");

			if(selectedIDs.length <= 0 ) {
				messager.alert("<spring:message code='column.common.update.no_select' />", "Info", "info");
				return;
			}

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
		}

		function useYnUpdateGrid(){
			var rowids = $("#createGoodsDealList").jqGrid('getGridParam', 'selarrrow');
			for(var i = 0; i < rowids.length; i++) {
				$("#createGoodsDealList").jqGrid('setCell', rowids[i],'useYn', $("select[name=gridUseYn]").val());
			}
			layer.close ("useYnLayer");
		}

		</script>
	</t:putAttribute>
<t:putAttribute name="content">
	<div class="mTitle">
		<h2>기본 정보</h2>
	</div>

	<form id="goodsInsertForm" name="goodsInsertForm" method="post" >
		<!-- 상품 유형 코드 : 딜 상품 -->
		<input type="hidden" id="goodsTpCd" name="goodsTpCd" value="${adminConstants.GOODS_TP_20}" />
		<table class="table_type1">
			<caption>GOODS Deal 등록</caption>
			<tbody>
				<tr>
					<th scope="row"><spring:message code="column.deal_goods_id" /><strong class="red">*</strong></th>	<!-- Deal 상품 아이디-->
					<td>
						<!-- 상품 번호-->
						<c:if test="${empty goodsBase}">
							<b>자동입력</b>
						</c:if>
						<c:if test="${not empty goodsBase}">
							<input type="text" class="readonly" readonly="readonly" name="goodsId" id="goodsId" title="<spring:message code="column.deal_goods_id"/>" value="${goodsBase.goodsId}" />
						</c:if>
					</td>
					<th><spring:message code="column.st_id"/><strong class="red">*</strong></th> <!-- 사이트 아이디 -->
					<td>
						<frame:stIdCheckbox selectKey="${goodsBase.stStdList}" compNo="${goodsBase.compNo}" disabled="${empty goodsBase or goodsBase.editable ? false : true}"/>
					</td>
				</tr>
				<tr>
					<th><spring:message code="column.goods_nm" /><strong class="red">*</strong></th>	<!-- 상품 명-->
					<td>
						<input type="text" class="w400 validate[required]" name="goodsNm" id="goodsNm" title="<spring:message code="column.goods_nm" />" value="${goodsBase.goodsNm}" ${empty goodsBase or goodsBase.editable ? '' : 'readonly="readonly"'}/>
					</td>
					<th><spring:message code="column.goods_stat_cd" /><strong class="red">*</strong></th>	<!-- 상품 상태 코드-->
					<td>
						<select class="validate[required]" name="goodsStatCd" id="goodsStatCd" title="<spring:message code="column.goods_stat_cd" />">
							<frame:select grpCd="${adminConstants.GOODS_STAT }" selectKey="${goodsBase.goodsStatCd}" />
						</select>
					</td>						
				</tr>
				<tr>
					<th><spring:message code="column.web_mobile_gb_cd" /></th>	<!-- 웹/모바일 구분 -->
					<td>
						<frame:radio name="webMobileGbCd" grpCd="${adminConstants.WEB_MOBILE_GB }" selectKey="${goodsBase.webMobileGbCd }" disabled="${empty goodsBase or goodsBase.editable ? false : true}"/>
					</td>
					<th><spring:message code="column.show_yn" /></th>	<!-- 노출여부 -->
					<td>
						<frame:radio name="showYn" grpCd="${adminConstants.SHOW_YN}" selectKey="${goodsBase.showYn}" disabled="${empty goodsBase or goodsBase.editable ? false : true}"/>
					</td>
				</tr>
			</tbody>
		</table>
	</form>
	
	<div class="mTitle mt30">
		<h2>Deal 구분 상품</h2>
		<div class="buttonArea">
			<button type="button" onclick="${empty goodsBase or goodsBase.editable ? 'useYnLayerView()' : ''}" class="btn btn-add">사용여부 변경</button>
			<button type="button" onclick="${empty goodsBase or goodsBase.editable ? 'goodsDealTargetLayer()' : ''}" class="btn btn-add">추가</button>
			<button type="button" onclick="${empty goodsBase or goodsBase.editable ? 'goodsDealTargetDelete()' : ''}" class="btn btn-add">삭제</button>
		</div>
	</div>
	<div class="mModule no_m">
		<!-- Deal 상품 목록 그리드 -->
		<table id="createGoodsDealList" ></table>
	</div>

	<div class="btn_area_center">
		<c:if test="${empty goodsBase}">
			<button type="button" class="btn btn-ok" onclick="insertGoodsDeal(); return false;" >등록</button>
			<button type="button" class="btn btn-cancel"  onclick="closeTab();" >취소</button>
		</c:if>
		<c:if test="${not empty goodsBase}">
			<button type="button" class="btn btn-ok" onclick="updateGoodsDeal(); return false;" >수정</button>
			<button type="button" class="btn btn-add" onclick="deleteGoodsDeal(); return false;" >삭제</button>
			<button type="button" class="btn btn-cancel"  onclick="closeTab();" >닫기</button>
		</c:if>
	</div>

	</t:putAttribute>
</t:insertDefinition>