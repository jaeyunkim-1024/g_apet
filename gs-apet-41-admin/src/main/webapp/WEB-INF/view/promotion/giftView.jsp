<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">
			var arrPromotionTargetDel = new Array();
			var arrPromotionFreebietDel = new Array();

			$(document).ready(function(){
				createPromotionTargetGrid();
				createPromotionFreebieGrid();
				
				grid.resize();				
				//searchDateChange();
				
				//사은품 기간 
				$("#aplStrtDtm").change(function(){
					compareDate("aplStrtDtm", "aplEndDtm");
				});
				
				$("#aplEndDtm").change(function(){
					compareDate2("aplStrtDtm", "aplEndDtm");
				});
			});

			// 쿠폰 상태 변경
			$(document).on("change", "#prmtStatCd", function() {	
				
				var currentPrmtState = "${promotion.prmtStatCd}";
				var newPrmtState = $(this).val();
				
				if (newPrmtState < currentPrmtState) {
					if (newPrmtState == '${adminConstants.PRMT_STAT_20}' && currentPrmtState == '${adminConstants.PRMT_STAT_30}') {
						// 중단 --> 진행 으로 변경은 허용함.
						messager.alert("<spring:message code="admin.web.view.app.promotion.manage.detail.alert.prmt_state_restart" />","Info","info");
					} else {
						// 이전 단계로 변경은 허용하지 않음.
						messager.alert("<spring:message code="admin.web.view.app.promotion.manage.detail.alert.prmt_state_invalid" />","Info","info",function(){
							$("#prmtStatCd").val(currentPrmtState);
						});						
					}
				}
			});

			function createPromotionTargetGrid(){
				var options = {
					url : "/promotion/promotionTargetListGrid.do"
					, height : 170
					, multiselect : true
					, searchParam : {
						prmtNo : '${promotion.prmtNo}'
					}
					, colModels : [
						{name:"aplSeq", hidden:true , formatter: checkPromotionTargetList()}
						, {name:"goodsId", label:"<spring:message code='column.goods_id' />", key:true, width:"100", align:"center", sortable:false} /* 상품 번호 */
						, _GRID_COLUMNS.goodsNm
						, {name:"stNms", label:_GOODS_SEARCH_GRID_LABEL.stNms, width:"200", align:"center"} /* 사이트 명 */
						, _GRID_COLUMNS.goodsStatCd
						, _GRID_COLUMNS.goodsTpCd
						, {name:"mdlNm", label:_GOODS_SEARCH_GRID_LABEL.mdlNm, width:"200", align:"center", sortable:false } /* 모델명 */
						, {name:"saleAmt", label:_GOODS_SEARCH_GRID_LABEL.saleAmt, width:"100", align:"center", sortable:false, formatter: 'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','} } /* 판매가 */
						, _GRID_COLUMNS.compNm
						, _GRID_COLUMNS.bndNmKo
						, _GRID_COLUMNS.showYn
						, {name:"mmft", label:_GOODS_SEARCH_GRID_LABEL.mmft, width:"200", align:"center", sortable:false } /* 제조사 */
						, {name:"saleStrtDtm", label:_GOODS_SEARCH_GRID_LABEL.saleStrtDtm, width:"150", align:"center", sortable:false, formatter:gridFormat.date, dateformat:_COMMON_DATE_FORMAT }
						, {name:"saleEndDtm", label:_GOODS_SEARCH_GRID_LABEL.saleEndDtm, width:"150", align:"center", sortable:false, formatter:gridFormat.date, dateformat:_COMMON_DATE_FORMAT }
						, {name:"bigo", label:_GOODS_SEARCH_GRID_LABEL.bigo, width:"200", align:"center", sortable:false } /* 비고 */
					]
				};
				grid.create("promotionTargetList", options);
			}

			function promotionTargetLayer() {
				var stIds = [];
				$.each($('input:checkbox[name=stId]:checked'), function(i){
					stIds.push($(this).val());
				});

				var options = {
					multiselect : true
					, callBack : function(newGoods) {
						
						if(newGoods != null) {
							var prmtGoods = $('#promotionTargetList').getDataIDs();
							var message = new Array();

							// 현재 프로모션(사은품)의 적용사이트 추출
							var prmtStIdArray = [];
							$("input:checkbox[name='stId']:checked").each(function () {
								prmtStIdArray.push($(this).val());
							});

							for(var ng in newGoods){
								var check = true;

								// 새로 추가할 상품의 사이트 아이디 추출
								var newGoodsStIdArray = newGoods[ng].stIds.split("|");

								// 새로 추가할 상품의 사이트 아이디가 현재 프로모션의 적용사이트에 속하는지 확인
								for (var si in newGoodsStIdArray) {
									if (jQuery.inArray(newGoodsStIdArray[si], prmtStIdArray) < 0) {
										check = false;
									} else {
										// 일치하는 사이트아이디가 있으면 바로 통과
										check = true;
										break;
									}
								}
								
								// 적용사이트에 속하지 않아서 적용불가 메시지 추가
								if (check == false) {
									message.push(newGoods[ng].goodsNm + " 적용 사이트가 일치하지 않습니다.^^");
								}

								// 새로 추가할 상품이 현재 쿠폰적용상품과 겹치는지 확인
								for(var pg in prmtGoods) {
									if(newGoods[ng].goodsId == prmtGoods[pg]) {
										check = false;
										message.push(newGoods[ng].goodsNm + " 중복된 상품입니다.^^");
									}
								}

								if(check) {
									
									$("#promotionTargetList").jqGrid('addRowData', newGoods[ng].goodsId, newGoods[ng], 'last', null);
								}
							}

							if(message != null && message.length > 0) {
								messager.alert(message.join("<br/>"),"Info","info");
							}
						}
					}
					, stIds : stIds
					, goodsCstrtTpCds : ['ITEM', 'SET']
					, goodsStatCd : '${adminConstants.GOODS_STAT_40}'
					, disableAttrGoodsTpCd : true
					//, stId : stId
				}
				//debugger
				layerGoodsList.create(options);
			}

			function promotionTargetDelete() {
				var rowids = $("#promotionTargetList").jqGrid('getGridParam', 'selarrrow');
				var delRow = new Array();

				if(rowids != null && rowids.length > 0) {
					for(var i in rowids) {
						delRow.push(rowids[i]);
					}
				}
				if(delRow != null && delRow.length > 0) {
					for(var i in delRow) {
						var rowdata = $("#promotionTargetList").getRowData(delRow[i]);
						if(!validation.isNull(rowdata.aplSeq)) {
							arrPromotionTargetDel.push({
								aplSeq : rowdata.aplSeq
								, prmtNo : '${promotion.prmtNo}'
							});
						}
						$("#promotionTargetList").delRowData(delRow[i]);
					}
				} else {
					messager.alert("<spring:message code='admin.web.view.msg.gift.select.good' />","Info","info");
				}
			}

			function createPromotionFreebieGrid(){
				var options = {
					url : "/promotion/promotionFreebieListGrid.do"
					, height : 170
					, paging : false
					, multiselect : true
					, cellEdit : true
					, searchParam : {
						prmtNo : '${promotion.prmtNo}'
					}
					, colModels : [
						{name:"goodsId", label:"<spring:message code='column.goods_id' />", key:true, width:"100", align:"center"} /* 상품 번호 */
						, _GRID_COLUMNS.goodsNm
						, {name:"stNms", label:_GOODS_SEARCH_GRID_LABEL.stNms, width:"200", align:"center"} /* 사이트 명 */
						, _GRID_COLUMNS.goodsStatCd
						, _GRID_COLUMNS.goodsTpCd
						, {name:"frbQty", label:'<spring:message code="column.frb_qty" />', width:"100", align:"center", editable:true, sortable:false, hidden:true }
						, {name:"mdlNm", label:_GOODS_SEARCH_GRID_LABEL.mdlNm, width:"200", align:"center", sortable:false } /* 모델명 */
						, {name:"saleAmt", label:_GOODS_SEARCH_GRID_LABEL.saleAmt, width:"100", align:"center", sortable:false, formatter: 'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','} } /* 판매가 */
						, _GRID_COLUMNS.compNm
						, _GRID_COLUMNS.bndNmKo
						, _GRID_COLUMNS.showYn
						, {name:"mmft", label:_GOODS_SEARCH_GRID_LABEL.mmft, width:"200", align:"center", sortable:false } /* 제조사 */
						, {name:"saleStrtDtm", label:_GOODS_SEARCH_GRID_LABEL.saleStrtDtm, width:"150", align:"center", sortable:false, formatter:gridFormat.date, dateformat:_COMMON_DATE_FORMAT }
						, {name:"saleEndDtm", label:_GOODS_SEARCH_GRID_LABEL.saleEndDtm, width:"150", align:"center", sortable:false, formatter:gridFormat.date, dateformat:_COMMON_DATE_FORMAT }
						, {name:"bigo", label:_GOODS_SEARCH_GRID_LABEL.bigo, width:"200", align:"center", sortable:false } /* 비고 */
					]
				};
				grid.create("promotionFreebieList", options);
			}

			function promotionFreebieLayer() {
				var options = {
					multiselect : true
					, callBack : function(newGoods) {

						//console.log("===newGoods===");
						//console.log( newGoods );
						if(newGoods != null) {
							
							var prmtFrbe = $('#promotionFreebieList').getDataIDs();
							var message = new Array();

							// 현재 프로모션(사은품)의 적용사이트 추출
							var prmtStIdArray = [];
							$("input:checkbox[name='stId']:checked").each(function () {
								prmtStIdArray.push($(this).val());
							});
							
							for(var ng in newGoods){
								var check = true;

								// 새로 추가할 상품의 사이트 아이디 추출
								var newGoodsStIdArray = newGoods[ng].stIds.split("|");

								// 새로 추가할 상품의 사이트 아이디가 현재 프로모션(사은품)의 적용사이트에 속하는지 확인
								for(var si in newGoodsStIdArray) {
									if (jQuery.inArray(newGoodsStIdArray[si], prmtStIdArray) < 0) {
										check = false;
									} else {
										// 일치하는 사이트아이디가 있으면 바로 통과
										check = true;
										break;
									}
								}

								// 적용사이트에 속하지 않아서 적용불가 메시지 추가
								if (check == false) {
									message.push(newGoods[ng].goodsNm + " 적용 사이트가 일치하지 않습니다.^^");
								}
								
								// 새로 추가할 상품이 현재 프로모션(사은품) 적용상품과 겹치는지 확인
								for(var pg in prmtFrbe) {
									if(newGoods[ng].goodsId == prmtFrbe[pg]) {
										check = false;
										message.push(newGoods[ng].goodsNm + " 중복된 상품입니다.^^");
									}
								}

								if(check) {
									
									//console.log("===newGoods[ng]===");
									//console.log(newGoods[ng]);
									newGoods[ng].frbQty = 1;
									$("#promotionFreebieList").jqGrid('addRowData', newGoods[ng].goodsId, newGoods[ng], 'last', null);
								}
							}

							if(message != null && message.length > 0) {
								messager.alert(message.join("<br/>"),"Info","info");
							}
						}
					}
					//, goodsTpCd : '${adminConstants.GOODS_TP_30}'
					, frbPsbYn : '${adminConstants.COMM_YN_Y}'
					, goodsCstrtTpCds : ['ITEM']
					, goodsStatCd : '${adminConstants.GOODS_STAT_40}'
					, disableAttrGoodsTpCd : true
				}

				//검색 날리기 전에 데이터 초기화
				jQuery('#goodsSearch').setGridParam({postData: null});

				layerGoodsList.create(options);
			}

			function promotionFreebieDelete() {
				var rowids = $("#promotionFreebieList").jqGrid('getGridParam', 'selarrrow');
				var delRow = new Array();
				if(rowids != null && rowids.length > 0) {
					for(var i in rowids) {
						delRow.push(rowids[i]);
					}
				}
				
				if(delRow != null && delRow.length > 0) {
					for(var i in delRow) {
						var rowdata = $("#promotionFreebieList").getRowData(delRow[i]);
						var isValidPrmtNo =  ${promotion.prmtNo != null ? true : false};
						
						if(isValidPrmtNo && !validation.isNull(rowdata.goodsId)) {
							arrPromotionFreebietDel.push({
								prmtNo : '${promotion.prmtNo}',
								goodsId : rowdata.goodsId
							});
						}
						
						$("#promotionFreebieList").delRowData(delRow[i]);
					}
				} else {
					messager.alert("<spring:message code='admin.web.view.msg.gift.select.gift' />","Info","info");
				}
			}

			function giftInsert(){
				if(validate.check("giftForm")) {
					var promotionTargetIdx = $('#promotionTargetList').getDataIDs();
					if(promotionTargetIdx == null || promotionTargetIdx.length == 0) {						
						messager.alert("<spring:message code='admin.web.view.msg.gift.regist.good' />","Info","info",function(){
							promotionTargetLayer();
						});						
						return;
					}

					var promotionFreebieIdx = $('#promotionFreebieList').getDataIDs();
					if(promotionFreebieIdx == null || promotionFreebieIdx.length == 0) {
						messager.alert("<spring:message code='admin.web.view.msg.gift.regist.gift' />","Info","info",function(){
							promotionFreebieLayer();
						});
						return;
					}
					
					messager.confirm('<spring:message code="column.common.confirm.insert" />',function(r){
						if(r){
							var data = $("#giftForm").serializeJson();

							var arrPromotionTarget = new Array();
							for(var i in promotionTargetIdx) {
								var rowdata = $("#promotionTargetList").getRowData(promotionTargetIdx[i]);
								arrPromotionTarget.push({
									goodsId : rowdata.goodsId
								});
							}

							var arrPromotionFreebiet = new Array();
							for(var i in promotionFreebieIdx) {
								var rowdata = $("#promotionFreebieList").getRowData(promotionFreebieIdx[i]);
								arrPromotionFreebiet.push({
									 goodsId : rowdata.goodsId
									,frbQty  : rowdata.frbQty 
								});
							}
							data.promotionTargetStr = JSON.stringify(arrPromotionTarget);
							data.promotionFreebieStr = JSON.stringify(arrPromotionFreebiet);
							
							console.log("=== data ===");
							console.log(data);
							//return;
							
							var options = {
								url : "<spring:url value='/promotion/giftInsert.do' />"
								, data : data
								, callBack : function(result){
									//updateTab('/promotion/giftView.do?prmtNo=' + result.promotion.prmtNo, '사은품 프로모션 상세');
									//addTab('사은품 목록', '/promotion/giftListView.do');
									closeGoTab('사은품 목록', '/promotion/giftListView.do');
								}
							};

							ajax.call(options);					
						}
					});
				}
			}

			function giftUpdate(){
				if(validate.check("giftForm")) {
					var promotionTargetIdx = $('#promotionTargetList').getDataIDs();
					if(promotionTargetIdx == null || promotionTargetIdx.length == 0) {
						messager.alert("<spring:message code='admin.web.view.msg.gift.regist.good' />","Info","info",function(){
							promotionTargetLayer();
						});						
						return;
					}

					var promotionFreebieIdx = $('#promotionFreebieList').getDataIDs();
					if(promotionFreebieIdx == null || promotionFreebieIdx.length == 0) {
						messager.alert("<spring:message code='admin.web.view.msg.gift.regist.gift' />","Info","info",function(){
							promotionFreebieLayer();
						});
						return;
					}

					messager.confirm('<spring:message code="column.common.confirm.update" />',function(r){
						if(r){
							var data = $("#giftForm").serializeJson();

							var arrPromotionTarget = new Array();
							for(var i in promotionTargetIdx) {
								var rowdata = $("#promotionTargetList").getRowData(promotionTargetIdx[i]);
								if(validation.isNull(rowdata.aplSeq)) {
									arrPromotionTarget.push({
										goodsId : rowdata.goodsId
									});
								}
							}

							var arrPromotionFreebiet = new Array();
							for(var i in promotionFreebieIdx) {
								var rowdata = $("#promotionFreebieList").getRowData(promotionFreebieIdx[i]);
								var isValidPrmtNo =  ${promotion.prmtNo != null ? true : false};
								
								if(isValidPrmtNo && !validation.isNull(rowdata.goodsId)) {
									arrPromotionFreebiet.push({
										prmtNo : '${promotion.prmtNo}',
										goodsId : rowdata.goodsId     ,
										frbQty  : rowdata.frbQty 
									});
								}
							}

							if(arrPromotionTarget != null && arrPromotionTarget.length > 0) {
								data.promotionTargetStr = JSON.stringify(arrPromotionTarget);
							}

							if(arrPromotionTargetDel != null && arrPromotionTargetDel.length > 0) {
								data.promotionTargetDelStr = JSON.stringify(arrPromotionTargetDel);
							}

							if(arrPromotionFreebiet != null && arrPromotionFreebiet.length > 0) {
								data.promotionFreebieStr = JSON.stringify(arrPromotionFreebiet);
							}

							if(arrPromotionFreebietDel != null && arrPromotionFreebietDel.length > 0) {
								data.promotionFreebieDelStr = JSON.stringify(arrPromotionFreebietDel);
							}

							var options = {
								url : "<spring:url value='/promotion/giftUpdate.do' />"
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

			$(document).on("keyup", "input[name^=splCompDvdRate]", function() {
				var val= $(this).val();
				
				
				//실수만 입력 가능하도록
				if(val.indexOf("0") == 0 && val.length > 1){					
					if(val.indexOf(".") !=1){
						$(this).val(parseFloat(val));	
					}				
				}
				
				if(val < 0) {
					$(this).val('');
				}else if(val > 100){
					$(this).val('100');
				}
			});
			//프로모션대상상품 체크박스확인
			function checkPromotionTargetList(){
				var checkCnt = $("#promotionTargetList tbody input:checkbox:checked").length;
				console.log("checkCnt " +checkCnt);
			}
			
			//프로모션사은품선택 체크박스확인 
			function checkPromotionFreebieList(){
				//var checkCnt = $("#promotionFreebieList tbody input:checkbox:checked").length;				
				//console.log("checkCnt " +checkCnt);
			}
		</script>
	</t:putAttribute>
	<t:putAttribute name="content">

		<div class="mTitle">
			<h2>사은품 프로모션</h2>
		</div>

		<form name="giftForm" id="giftForm" method="post">
		<table class="table_type1">
			<caption>사은품 프로모션 등록</caption>
			<tbody>
				<tr>
					<th><spring:message code="column.prmt_no"/><strong class="red">*</strong></th>
					<td>
						<!-- 프로모션 번호-->
						<c:if test="${empty promotion}">
						<b>자동입력</b>
						</c:if>
						<c:if test="${not empty promotion}">
						<input type="text" class="readonly" readonly="readonly" name="prmtNo" id="prmtNo" title="<spring:message code="column.prmt_no"/>" value="${promotion.prmtNo}" />
						</c:if>
					</td>
					<th><spring:message code="column.prmt_stat_cd"/><strong class="red">*</strong></th>
					<td>
						<!-- 프로모션 상태 코드-->
						<select class="validate[required]" name="prmtStatCd" id="prmtStatCd" title="<spring:message code="column.prmt_stat_cd"/>" ${empty promotion.prmtStatCd ? 'disabled="disabled"' : ''}>
							<frame:select grpCd="${adminConstants.PRMT_STAT}" selectKey="${empty promotion.prmtStatCd ? adminConstants.PRMT_STAT_10 : promotion.prmtStatCd}"/>
						</select>
					</td>
				</tr>
				<tr>
					<th><spring:message code="column.gift_view.date"/><strong class="red">*</strong></th>
					<td>
						<div class="mCalendar typeLayer">
							<span class="date_picker_box">
								<input type="text" name="aplStrtDtm" id="aplStrtDtm" ${empty promotion or promotion.editable ? 'class="datepicker validate[required,custom[date]]"' : ''} title="날짜선택" value="${empty promotion.aplStrtDtm ? frame:toDate('yyyy-MM-dd') : frame:getFormatDate(promotion.aplStrtDtm, 'yyyy-MM-dd')}" ${empty promotion or promotion.editable ? '' : 'readonly="readonly"'}/><img src="/images/calendar_icon.png" class="datepickerBtn" alt="날짜선택">
							</span>
						</div>
						&nbsp;~&nbsp;
						<div class="mCalendar typeLayer">
							<span class="date_picker_box">
								<input type="text" name="aplEndDtm" id="aplEndDtm" ${empty promotion or promotion.editable ? 'class="datepicker validate[required,custom[date],future[#aplStrtDtm]]"' : ''} title="날짜선택" value="${empty promotion.aplEndDtm ? frame:addMonth('yyyy-MM-dd', 1) : frame:getFormatDate(promotion.aplEndDtm, 'yyyy-MM-dd')}" ${empty promotion or promotion.editable ? '' : 'readonly="readonly"'}/><img src="/images/calendar_icon.png" class="datepickerBtn" alt="날짜선택" />
							</span>
						</div>
						
			<%-- 					<frame:datepicker startDate="aplStrtDtm" endDate="aplEndDtm" startValue="${adminConstants.COMMON_START_DATE }" />
									&nbsp;&nbsp; 
									<select id="checkOptDate" name="checkOptDate" onchange="searchDateChange();">
										<frame:select grpCd="${adminConstants.SELECT_PERIOD }" selectKey="${adminConstants.SELECT_PERIOD_20 }" defaultName="기간선택" />
									</select> --%>
							
						
					</td>
					
					<th><spring:message code="column.prmt_nm"/><strong class="red">*</strong></th>
					<td>
						<!-- 프로모션 명-->
						<input type="text" class="validate[required, maxSize[200]]" name="prmtNm" id="prmtNm" title="<spring:message code="column.prmt_nm"/>" value="${promotion.prmtNm}" ${empty promotion or promotion.editable ? '' : 'readonly="readonly"'}/>
					</td>
				</tr>
				<tr>
					<th><spring:message code="column.st_id"/><strong class="red">*</strong></th>
					<td>
						<frame:stIdCheckbox selectKey="${promotion.stStdList}" compNo="${goodsBase.compNo}" disabled="${empty promotion or promotion.editable ? false : true}" required="true"/>
					</td>
					<th><spring:message code="column.spl_comp_dvd_rate"/><strong class="red">*</strong></th>
					<td>
						<!-- 공급 업체 분담 율-->
						<input type="text" class="validate[required]" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" name="splCompDvdRate" id="splCompDvdRate" title="<spring:message code="column.spl_comp_dvd_rate"/>" value="${promotion.splCompDvdRate}" ${empty promotion or promotion.editable ? '' : 'readonly="readonly"'}/>%
					</td>
				</tr>
			</tbody>
		</table>
		</form>

		<div class="mTitle mt30">
			<h2>프로모션 대상 상품</h2>
			<div class="buttonArea">
				<button type="button" onclick="${empty promotion or promotion.editable ? 'promotionTargetLayer()' : ''}" class="btn btn-add">추가</button>
				<button type="button" onclick="${empty promotion or promotion.editable ? 'promotionTargetDelete()' : ''}" class="btn btn-add">삭제</button>
			</div>
		</div>

		<div class="mModule no_m">
			<table id="promotionTargetList" ></table>
		</div>

		<div class="mTitle mt30">
			<h2>프로모션 사은품 선택</h2>
			<div class="buttonArea">
				<button type="button" onclick="${empty promotion or promotion.editable ? 'promotionFreebieLayer()' : ''}" class="btn btn-add">추가</button>
				<button type="button" onclick="${empty promotion or promotion.editable ? 'promotionFreebieDelete()' : ''}" class="btn btn-add">삭제</button>
			</div>
		</div>

		<div class="mModule no_m">
			<table id="promotionFreebieList" ></table>
		</div>


		<div class="btn_area_center">
		<c:if test="${empty promotion}">
			<button type="button" onclick="giftInsert();" class="btn btn-ok">등록</button>
			<button type="button" onclick="addTab('사은품 목록', '/promotion/giftListView.do');" class="btn btn-cancel">목록</button>
			
		</c:if>
		<c:if test="${not empty promotion}">
			<button type="button" onclick="giftUpdate();" class="btn btn-ok">수정</button>
			<button type="button" onclick="addTab('사은품 목록', '/promotion/giftListView.do');" class="btn btn-cancel">목록</button>
		</c:if>
			
		</div>
	</t:putAttribute>
</t:insertDefinition>
