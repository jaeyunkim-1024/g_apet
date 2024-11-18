<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ page import="framework.common.enums.ImageGoodsSize" %>

<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">			
			var isUser;
		
			$(document).ready(function(){	
				$("#exhibitionThemeGoodsForm #thmNo").val("");

				isUser = "N";
				if ("${adminConstants.USR_GRP_10}" == "${adminSession.usrGrpCd}") {
					isUser = "Y";
				}
				
				createExhibitionThemeGrid();
				
				//기획전 상태 '종료'인경우
				if("${exhibitionBase.exhbtStatCd}" == "40" ){
					$("button[name=readonlyBtn]").css("display", "none");
				}
				
			});

			function fnChangeView( viewType ) {
				var url;
				if ( viewType == 10 ) {
					url = "/promotion/exhibitionBaseView.do";
				} else if ( viewType == 20 ) {
					url = "/promotion/exhibitionThemeView.do";
				} else if ( viewType == 30 ) {
					url = "/promotion/exhibitionThemeGoodsView.do";
				}
				url += '?exhbtNo=' + '${so.exhbtNo}';
				updateTab(url, "기획전 상세");
			}
			
			function createExhibitionThemeGrid() {
				var sendData = {
					exhbtNo : '${so.exhbtNo }'
				};
				
				if ("${adminConstants.USR_GRP_10}" != "${adminSession.usrGrpCd}") {
					$.extend(sendData, {
						compNo : "${adminSession.compNo }"
					});
				}
				
				var options = {
					url : "<spring:url value='/promotion/exhibitionThemeGrid.do' />"
					, height : 200
					, cellEdit : true
					, multiselect : true
// 					, paging : false
					, searchParam : sendData
					, loadonce : true
					, colModels : [
						// 전시 우선 순위
						{name:"dispPriorRank", label:'<spring:message code="column.display_view.disp_prior_rank" />', width:"80", align:"center", formatter:'integer', sortable:false, editable:true}
						// 테마 번호
						, {name:"thmNo", label:'<b><u><tt><spring:message code="column.thm_no" /></tt></u></b>', key:true , width:"80", align:"center", sortable:false, classes:'pointer fontbold'}
						// 테마 명
						, {name:"thmNm", label:'<spring:message code="column.thm_nm" />', width:"300", align:"center", sortable:false}
						// 리스트 타입 코드
						, {name:"listTpCd", label:'<spring:message code="column.list_tp_cd" />', width:"100", align:"center", sortable:false, formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.LIST_TP}"/>"}, hidden:true}
// 						, _GRID_COLUMNS.compNm
						, _GRID_COLUMNS.dispYn
						// 기획전 번호
						, {name:"exhbtNo", label:'<spring:message code="column.exhbt_no" />', width:"100", align:"center", hidden:true}
	                    // 업체 번호
                        , {name:"compNo", label:'<spring:message code="column.comp_no" />', width:"80", align:"center", hidden:true}

					]
					, onCellSelect : function (ids, cellidx, cellvalue) {
						if (cellidx > 1) {
							 var rowdata = $("#exhibitionThemeList").getRowData(ids);
							$("#exhibitionThemeGoodsForm #thmNo").val(rowdata.thmNo);
							$("#exhibitionThemeGoodsForm #compNo").val(rowdata.compNo);
							$("#exhibitionThemeGoodsForm #compNm").val(rowdata.compNm);
							searchExhibitionThemeGoods();
						}
					}, gridComplete : function () {
						var rowIds = $("#exhibitionThemeList").getDataIDs();
						var thmNo = $("#exhibitionThemeGoodsForm #thmNo").val();
							
						if(rowIds != null){
							var rowdata = jQuery("#exhibitionThemeList").getRowData(rowIds[0]);
							$("#exhibitionThemeGoodsForm #thmNo").val(rowdata.thmNo);
							$("#exhibitionThemeGoodsForm #compNo").val(rowdata.compNo);
							$("#exhibitionThemeGoodsForm #compNm").val(rowdata.compNm);
						}
						
						if (thmNo == "") {
							createExhibitionThemeGoodsGrid();
						} else {
							searchExhibitionThemeGoods();
						}
					}
				};

				grid.create("exhibitionThemeList", options);
			}
			
			function searchExhibitionThemeGoods() {
				$("#fileName").val("");
				$("#filePath").val("");
				
				var options = {
					searchParam : {
						thmNo : $("#exhibitionThemeGoodsForm #thmNo").val()
						, compNo : $("#exhibitionThemeGoodsForm #compNo").val()
						, compNm : $("#exhibitionThemeGoodsForm #compNm").val()
					}
				};
				grid.reload("exhibitionThemeGoodsList", options);
			}

			// 테마 정보 저장
			function exhibitionThemeSave() {
				var url = "";
				var grid = $("#exhibitionThemeList");
				var themeItems = new Array();

				var rowIds = grid.jqGrid('getGridParam', 'selarrrow');
				if(rowIds.length <= 0 ) {
					messager.alert("<spring:message code='column.display_view.message.no_select' />","Info","info");
					return;
				} else {
					for(var i = 0; i < rowIds.length; i++) {
						var data = $("#exhibitionThemeList").getRowData(rowIds[i]);
						themeItems.push(data);
					}

					sendData = {
						themeItemPOList : JSON.stringify(themeItems)
						, exhbtNo : "${so.exhbtNo }"
	 				};
				}
				messager.confirm("<spring:message code='column.common.confirm.save' />",function(r){
					if(r){
						var options = {
								url : "<spring:url value='/promotion/exhibitionThemeSave.do' />"
								, data : sendData
								, callBack : function(data) {
									messager.alert("<spring:message code='column.display_view.message.save'/>","Info","info",function(){
										$("#exhibitionThemeList").trigger("reloadGrid");
										changeExhbtStatCd();
									});									
								}
							};

							ajax.call(options);					
					}
				});
			}
			
			function createExhibitionThemeGoodsGrid() {	
				$("#fileName").val("");
				$("#filePath").val("");
				
				var options = {
					url : "<spring:url value='/promotion/exhibitionThemeGoodsGrid.do' />"
					, height : 200
					, cellEdit : true
					, multiselect : true
// 					, paging : false
//                     , loadonce : true
					, searchParam : {
						thmNo : $("#exhibitionThemeGoodsForm #thmNo").val()
						, compNo : $("#exhibitionThemeGoodsForm #compNo").val()
						, compNm : $("#exhibitionThemeGoodsForm #compNm").val()
					}
					, colModels : [
						// 전시 우선 순위
						 _GRID_COLUMNS.dispPriorRank
						// 상품 번호
						, {name:"compGoodsId", label:'<spring:message code="column.comp_goods_id" />', width:"120", align:"center", sortable:false}
						, _GRID_COLUMNS.goodsId
						, {name:"imgPath", label:_GOODS_SEARCH_GRID_LABEL.imgPaths, width:"80", align:"center", sortable:false, formatter: function(cellvalue, options, rowObject) {
								if(rowObject.imgPath != "" &&   rowObject.imgPath != undefined ) {
									return "<img src='${frame:optImagePath('"+rowObject.imgPath+"', adminConstants.IMG_OPT_QRY_30)}' style='width:60px; height:60px;' alt='' />";
									//return tag.goodsImage(_IMG_URL, rowObject.goodsId, rowObject.imgPath , rowObject.imgSeq, "", "${ImageGoodsSize.SIZE_70.size[0]}", "${ImageGoodsSize.SIZE_70.size[1]}", "h60 w60");
								}else {
									return '<img src="/images/noimage.png" style="width:60px; height:60px;" alt="" />';
								}
							}
						 } 
						, _GRID_COLUMNS.bndNmKo
						, _GRID_COLUMNS.goodsNm
						, _GRID_COLUMNS.goodsStatCd
						, _GRID_COLUMNS.showYn
                        , {name:"saleAmt", label:'<spring:message code="column.sale_amt" />', width:"100", align:"center", sortable:false, formatter: 'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','} } /* 판매가 */
                        , _GRID_COLUMNS.compNm
                        , {name:"mmft", label:'<spring:message code="column.mmft" />', width:"120", align:"center", sortable:false } /* 제조사 */
						, {name:"saleStrtDtm", label:'<spring:message code="column.sale_strt_dtm" />', width:"150", align:"center", sortable:false, formatter:gridFormat.date, dateformat:_COMMON_DATE_FORMAT }
						, {name:"saleEndDtm", label:'<spring:message code="column.sale_end_dtm" />', width:"150", align:"center", sortable:false, formatter:gridFormat.date, dateformat:_COMMON_DATE_FORMAT }
						, {name:"bigo", label:'<spring:message code="column.bigo" />', width:"200", align:"center", sortable:false } /* 비고 */
						, {name:"thmNo", label:'<spring:message code="column.thm_no" />', width:"100", align:"center", hidden:true}
						, {name:"imgSeq", label:'<spring:message code="column.img_seq" />', width:"80", align:"center", hidden:true}
					]
				};

				grid.create("exhibitionThemeGoodsList", options);
			}
			
			var goodsCnt = ${goodsCnt};
			var statCd = ${exhibitionBase.exhbtGbCd}
			
			function exhibitionThemeGoodsAdd() {
				var duplCnt = 0; // 중복 건수

				var rowIds = $("#exhibitionThemeGoodsList").getDataIDs();
// 				console.log("statCd",statCd)
				
				//일반기획전 일떄
				if(goodsCnt >= 50 && statCd == 20){
					messager.alert("일반기획전 상품추가는 50개까지 가능합니다.", "Info", "info");
				}
				else if(rowIds.length >= 20 && statCd == 10){
					messager.alert("특별기획전 상품추가는 20개까지 가능합니다.", "Info", "info");
				}
				else{
					var options = {
						multiselect : true
						, compNo : $("#exhibitionThemeGoodsForm #compNo").val()
						, compNm : $("#exhibitionThemeGoodsForm #compNm").val()
						, stId : $("#exhibitionThemeGoodsForm #stId").val()
						, stNm : $("#exhibitionThemeGoodsForm #stNm").val()
						, goodsStatCd : "${adminConstants.GOODS_STAT_40}"
					 	, disableAttrGoodsStatCd : true
						, callBack : function(result) {

							if(result != null && result.length > 0) {
								var themeGoodsItems = new Array();
								var goodsId = new Array();
								//var goodsCheck = false;
								var message = new Array();
								var rowLen = rowIds.length;
								
								for(var i in result) {
									var goodsCheck = false;
									for(var j = 0; j < rowIds.length; j++) {
										var rowdata = $("#exhibitionThemeGoodsList").getRowData(rowIds[j]);
										if(result[i].goodsId == rowdata.goodsId) {
											goodsCheck = true;
											message.push("[ " + result[i].goodsNm + " ] 중복된 상품입니다.");
											duplCnt++;
											break;
										}
									}

									if(!goodsCheck){
										themeGoodsItems.push({
											thmNo : $("#exhibitionThemeGoodsForm #thmNo").val()
											, goodsId : result[i].goodsId
										});
										rowLen++;
									}
								}

								var sendData = {
									themeGoodsItemPOList : JSON.stringify(themeGoodsItems)
									, exhbtNo : "${so.exhbtNo }"
								};
								
								goodsCnt = goodsCnt+themeGoodsItems.length;
								
								if(goodsCnt > 50  && statCd == "20"){
									goodsCnt = goodsCnt-themeGoodsItems.length;//추가에 실패 했으면 상품갯수 더한거 다시 원복. 20210707
									messager.alert("일반기획전 상품추가는 50개까지 가능합니다.", "Info", "info");
								}
								else if(rowLen > 20 && statCd == "10"){
									messager.alert("특별기획전 상품추가는 20개까지 가능합니다.", "Info", "info");
								}
								else {

									if(duplCnt > 0) {
										if(message != null && message.length > 0) {
											if(result.length > duplCnt){
												message.push("중복상품은 제외하고 등록됩니다.");
											}else{
												message.push("중복상품 외 등록할 상품이 없습니다.");
												messager.alert(message.join("<br/>"),"Info","info"); return;
											}

											messager.confirm(message.join("<br/>"), function(r){
												if(r){
													if(result.length > duplCnt){
														saveExhibitionThemeGoods(sendData);
													}
												}
											})
										}
									}else{
										saveExhibitionThemeGoods(sendData);
									}
								}
								
							}
						}
					}
	
					layerGoodsList.create(options);
				}
				
			}

			// 테마 상품 정보 저장
			function exhibitionThemeGoodsSave() {
				var url = "";
				var grid = $("#exhibitionThemeGoodsList");
				var themeGoodsItems = new Array();

				var rowIds = grid.jqGrid('getGridParam', 'selarrrow');
				if(rowIds.length <= 0 ) {
					messager.alert("<spring:message code='column.display_view.message.no_select' />","Info","info");
					return;
				} else {
					for(var i = 0; i < rowIds.length; i++) {
						var data = $("#exhibitionThemeGoodsList").getRowData(rowIds[i]);
// 						$.extend(data, {
// 							isUpdate : 1
// 						});
						themeGoodsItems.push(data);
					}

					sendData = {
						themeGoodsItemPOList : JSON.stringify(themeGoodsItems)
						, exhbtNo : "${so.exhbtNo }"
	 				};
				}
				messager.confirm("<spring:message code='column.common.confirm.save' />",function(r){
					if(r){
						saveExhibitionThemeGoods(sendData);				
					}
				});
			}
			
			function saveExhibitionThemeGoods(sendData) {
				var options = {
					url : "<spring:url value='/promotion/exhibitionThemeGoodsSave.do' />"
					, data : sendData
					, callBack : function(data) {
						messager.alert("<spring:message code='column.display_view.message.save'/>","Info","info",function(){
							searchExhibitionThemeGoods();
							changeExhbtStatCd();
						});
					}
				};

				ajax.call(options);
			}

			// 테마 상품 정보 삭제
			function exhibitionThemeGoodsDelete() {
				var url = "";
				var grid = $("#exhibitionThemeGoodsList");
				var themeGoodsItems = new Array();

				var rowIds = grid.jqGrid('getGridParam', 'selarrrow');
				if(rowIds.length <= 0 ) {
					messager.alert("<spring:message code='column.display_view.message.no_select' />","Info","info");
					return;
				} else {
					for(var i = 0; i < rowIds.length; i++) {
						var data = $("#exhibitionThemeGoodsList").getRowData(rowIds[i]);
						themeGoodsItems.push(data);
					}

					sendData = {
						themeGoodsItemPOList : JSON.stringify(themeGoodsItems)
						, exhbtNo : "${so.exhbtNo }"
	 				};
					
					goodsCnt = goodsCnt-themeGoodsItems.length;
				
				}
				
				messager.confirm("<spring:message code='column.common.confirm.delete' />",function(r){
					if(r){
						var options = {
								url : "<spring:url value='/promotion/exhibitionThemeGoodsDelete.do' />"
								, data : sendData
								, callBack : function(data) {
									messager.alert("<spring:message code='column.display_view.message.delete'/>","Info","info",function(){
										searchExhibitionThemeGoods();
										changeExhbtStatCd();
									});
								}
							};

							ajax.call(options);					
					}
				});
			}
			
			/** 업체일때 업체기획전 수정이 되었을때 반려상태일 경우 
			SQL 로직으로 대기가 되지만 화면이 변경이 안되어 강제로 화면을 변경 */
			function changeExhbtStatCd() {
				if (isUser == "N" && "${adminConstants.EXHBT_GB_20}" == "${exhibitionBase.exhbtGbCd}"
					&& "${adminConstants.EXHBT_STAT_30}" == "${exhibitionBase.exhbtStatCd}") {
					$("#exhbtStatCd").html('<frame:codeName grpCd="${adminConstants.EXHBT_STAT}" dtlCd="${adminConstants.EXHBT_STAT_10}" />');
				}
			}
			
			function updateExhibitionBase(exhbtStatCd) {
				var message = "<spring:message code='column.exhibition_view.confirm.approve' />";
				if (exhbtStatCd == "${adminConstants.EXHBT_STAT_30}") {
					message = "<spring:message code='column.exhibition_view.confirm.return' />";
				}
				
				messager.confirm(message,function(r){
					if(r){
						var data = $("#exhibitionBaseForm").serializeJson();

						var options = {
							url : "<spring:url value='/promotion/exhibitionBaseSave.do' />"
							, data : {
								exhbtNo : '${so.exhbtNo }'
								, exhbtStatCd : exhbtStatCd
								, bigo : $("#bigo").val()
								, stId :'${exhibitionBase.stId }' 
								, viewType : 30
							}
							, callBack : function(result){
								messager.alert("<spring:message code='column.exhibition_view.confirm.result' />","Info","info",function(){
									fnChangeView(30);
								});							
							}
						};

						ajax.call(options);					
					}
				});
			}
			
			// Template Download
			function downloadTemplate () {
				createFormSubmit( "templateDown", "/promotion/exhbtThmGoodsExcelDownload.do", null );
			}
			
			// callback : 파일 업로드
			function fnCallBackFileUpload( file ) {
// 				alert( JSON.stringify( file ) );
				$("#fileName").val( file.fileName );
				$("#filePath").val( file.filePath );
				
				if ( $("#filePath").val() == null || $("#filePath").val() == "" ) {
					messager.alert("<spring:message code='admin.web.view.msg.exhibition.select.upload' />","Info","info");
					return;
				}

				messager.confirm("<spring:message code='column.exhibition_view.confirm.goods_batch_create' />",function(r){
					if(r){
						var fileName = $("#fileName").val();
						var filePath = $("#filePath").val();

						var sendData = {
							thmNo : $("#exhibitionThemeGoodsForm #thmNo").val()
							, exhbtNo : "${so.exhbtNo }"
							, fileName : fileName
							, filePath : filePath
						}

						var options = {
							url : "<spring:url value='/promotion/exhbtThmGoodsBatchCreateExec.do' />"
							, data : sendData
							, callBack : function(data) {
								
								var returnCode = data.returnCode;
								var message = "<spring:message code='column.display_view.message.save'/>";
								if(returnCode == 'noData') {
									messager.alert("<spring:message code='admin.web.view.msg.exhibition.result.insert.nodata'/>","Info","info");
								}else {
									if(returnCode == 'duplicateGoods') {
										message = "<spring:message code='admin.web.view.msg.exhibition.result.insert.duplicate.except'/>";
									}
									
									messager.alert(message,"Info","info",function(){
										searchExhibitionThemeGoods();
									});
								}
							}
						};
						ajax.call(options);					
					}
				});
			}
		</script>
	</t:putAttribute>
	<t:putAttribute name="content">
		<c:choose>
			<c:when test="${adminConstants.USR_GRP_10 eq adminSession.usrGrpCd}">
				<c:set value="Y" var="isUser"/>
			</c:when>
			<c:otherwise>
				<c:set value="N" var="isUser"/>
			</c:otherwise>
		</c:choose>
		
		<!-- 연합기획전에 등록된 업체가 상품 정보 진입을 할 경우 -->
		<c:if test="${isUser eq 'N' and adminConstants.EXHBT_GB_10 eq exhibitionBase.exhbtGbCd}">
			<c:set value="Y" var="isCompGoods"/>
		</c:if>
		
		<div class="mTab">
			<ul class="tabMenu">
				<li><a ${isCompGoods ne 'Y' ? 'href="javascript:fnChangeView(10)"' : '' }>기본정보</a></li>
				<li><a ${isCompGoods ne 'Y' ? 'href="javascript:fnChangeView(20)"' : '' }>테마정보</a></li>
				<li class="active"><a href="javascript:fnChangeView(30)"'>상품정보</a></li>
			</ul>
		</div>
		
		<div class="mTitle">
			<h2>기본정보</h2>
		</div>
		<div>
			<table class="table_type1">
				<tbody>
					<tr>
						<!-- 기획전 번호 -->
						<th scope="row"><spring:message code="column.exhbt_number" /></th>
						<td>
							<input type="hidden" id="exhbtNo" name="exhbtNo" value="${exhibitionBase.exhbtNo }" />
							<b>${so.exhbtNo }</b>
						</td>
						<!-- 기획전 구분 코드-->
						<th><spring:message code="column.exhbt_gb_cd"/></th>
						<td>
							<frame:codeName grpCd="${adminConstants.EXHBT_GB}" dtlCd="${exhibitionBase.exhbtGbCd}" />
						</td>
					</tr>
					<tr>
						<!-- 기획전 명 -->
						<th scope="row"><spring:message code="column.exhbt_nm" /></th>
						<td>
							${exhibitionBase.exhbtNm}
						</td>
						<!-- 기획전 승인 상태 코드 -->
						<th scope="row"><spring:message code="column.exhbt_stat_cd" /></th>
                        <td id ="exhbtStatCd">
							<frame:codeName grpCd="${adminConstants.EXHBT_STAT}" dtlCd="${exhibitionBase.exhbtStatCd}" />
                        </td>
					</tr>
					<tr>
						<!-- 웹/모바일 구분 -->
						<th><spring:message code="column.web_mobile_gb_cd" /></th>	
						<td>
							<frame:codeName grpCd="${adminConstants.WEB_MOBILE_GB}" dtlCd="${exhibitionBase.webMobileGbCd}" />
						</td>
						<!-- 담당 MD -->
						<th><spring:message code="column.exhbt_md_usr_nm"/><strong class="red">*</strong></th>
						<td>
							${exhibitionBase.mdUsrNm}
						</td>
					</tr>
						<tr>
							<th><spring:message code="column.display_view.disp_date"/></th>
							<td>
								${frame:getFormatTimestamp(exhibitionBase.dispStrtDtm, 'yyyy-MM-dd HH:mm:ss')} ~ ${frame:getFormatTimestamp(exhibitionBase.dispEndDtm, 'yyyy-MM-dd HH:mm:ss')}
							</td>
							<!-- 사이트 ID -->
							<th><spring:message code="column.st_id"/></th>
							<td>
							    ${exhibitionBase.stNm }
							</td>
						</tr>
				</tbody>
			</table>
		</div>
		
		<div class="mTitle mt30">
			<h2>테마 정보</h2>
			<div class="buttonArea">
				<c:if test="${isCompGoods ne 'Y'}">
					<button type="button" name="readonlyBtn" onclick="exhibitionThemeSave();" class="btn btn-add">저장</button>
				</c:if> 
			</div>
		</div>
		<form name="exhibitionThemeForm" id="exhibitionThemeForm">	
			<div class="mModule no_m">
				<table id="exhibitionThemeList"></table>
			</div>
		</form>
		
		<div class="mTitle mt30">
			<h2>상품 정보</h2>
			<div class="buttonArea">
				<input type="hidden" id="fileName" name="fileName" value="" />
 				<input type="hidden" id="filePath" name="filePath" value="" />
 				<input type="hidden" id="goodsCnt" name="goodsCnt" value="${goodsCnt}" />
				<button type="button" name="readonlyBtn" onclick="exhibitionThemeGoodsSave();" class="btn btn-add">저장</button>
				<button type="button" name="readonlyBtn" onclick="exhibitionThemeGoodsAdd();" class="btn btn-add">추가</button>
				<button type="button" name="readonlyBtn" onclick="exhibitionThemeGoodsDelete();" class="btn btn-add">삭제</button>
				<button type="button" name="readonlyBtn" onclick="downloadTemplate();" class="btn btn-add">업로드 샘플</button>
				<button type="button" name="readonlyBtn" onclick="fileUpload.file(fnCallBackFileUpload);" class="btn btn-add">대량업로드</a>
			</div>
		</div>
	
		<form name="exhibitionThemeGoodsForm" id="exhibitionThemeGoodsForm">
			<input type="hidden" name="thmNo" id="thmNo" value=""/>
			<input type="hidden" name="compNo" id="compNo" value=""/>
			<input type="hidden" name="compNm" id="compNm" value=""/>
			<input type="hidden" id="stId" name="stId" value="${exhibitionBase.stId }" />
			<input type="hidden" id="stNm" name="stNm" value="${exhibitionBase.stNm }" />
			<input type="hidden" id="dispClsfNo" name="dispClsfNo" value="${exhibitionBase.dispClsfNo}" />
		
			<div class="mModule no_m">
				<table id="exhibitionThemeGoodsList"></table>
				<div id="exhibitionThemeGoodsListPage"></div>
			</div>
		</form>
		
		<table class="table_type1 mt30">
			<tbody>
				<tr>
					<th scope="row"><spring:message code="column.bigo"/></th>
					<td>
						<textarea rows="3" cols="150" id="bigo" class="w500" name="bigo" title="<spring:message code="column.bigo"/>" >${exhibitionBase.bigo }</textarea>
						
					</td>
				</tr>
			</tbody>
		</table>
		
<%-- 		<c:if test="${adminConstants.EXHBT_STAT_20 ne exhibitionBase.exhbtStatCd and adminConstants.EXHBT_STAT_40 ne exhibitionBase.exhbtStatCd and adminSession.usrNo eq exhibitionBase.mdUsrNo}" > --%>
<!-- 			<div id="btnDiv" class="btn_area_center"> -->
<%-- 				<button type="button" onclick="updateExhibitionBase('${adminConstants.EXHBT_STAT_20}');" class="btn btn-ok">승인</button> --%>
<%-- 				<button type="button" onclick="updateExhibitionBase('${adminConstants.EXHBT_STAT_30}');" class="btn btn-cancel">반려</button> --%>
<!-- 			</div> -->
<%-- 		</c:if> --%>
	</t:putAttribute>
</t:insertDefinition>
