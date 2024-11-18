<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">
			$(document).ready(function(){
				// 브랜드 콘텐츠 아이템
				createBrandCntsItemList();
			});
			
			// 브랜드 검색
			function searchBrand () {
				var options = {
					bndGbCd : "${adminConstants.BND_GB_30}"
					, multiselect : false
					, callBack : function(result) {
						if(result.length > 0 ) {
							$("#bndNo").val(result[0].bndNo );
							$("#bndNmKo").val(result[0].bndNmKo);
							$("#bndNmEn").val(result[0].bndNmEn);
						}
					}
				}
				layerBrandList.create(options);
			}
			
			// 브랜드 콘텐츠 아이템
			function createBrandCntsItemList () {
				 var bndCntsNo = '${brandCnts.bndCntsNo}'
				
				if (bndCntsNo == "") {
					bndCntsNo = 0;
				}
				
				var options = {
					url : "<spring:url value='/brandCnts/brandCntsItemListGrid.do' />"
					, searchParam : { bndCntsNo : bndCntsNo }
					, paging : false
					, height : 150
					, colModels : [
						// 아이템 번호
						{name:"itemNo", label:'<spring:message code="column.item_no" />', width:"100", key: true, align:"center"}
						, _GRID_COLUMNS.goodsId
						, _GRID_COLUMNS.goodsNm
			            // 아이템 이미지 경로
	 					, {name:"itemImgPath", label:'<spring:message code="column.display_view.pc_img" />', width:"300", align:"center", formatter: function(cellvalue, options, rowObject) {
	 							if(rowObject.itemImgPath != "") {
	 								return '<img src="<frame:imgUrl />' + rowObject.itemImgPath + '" style="width:100px; height:100px;" alt="' + rowObject.itemImgPath + '" />';
	 							} else {
	 								return '<img src="/images/noimage.png" style="width:100px; height:100px;" alt="NoImage" />';
	 							}
	 						}
	 					}
	 					// 아이템 모바일 이미지 경로
	 					, {name:"itemMoImgPath", label:'<spring:message code="column.display_view.mobile_img" />', width:"300", align:"center", formatter: function(cellvalue, options, rowObject) {
	 							if(rowObject.itemMoImgPath != "") {
	 								return '<img src="<frame:imgUrl />' + rowObject.itemMoImgPath + '" style="width:100px; height:100px;" alt="' + rowObject.itemMoImgPath + '" />';
	 							} else {
	 								return '<img src="/images/noimage.png" style="width:100px; height:100px;" alt="NoImage" />';
	 							}
	 						}
	 					}
					]
					, multiselect : true
					/* , onSelectRow : function(ids) {
						var rowdata = $("#brandCntsItemList").getRowData(ids);
						brandCntsItemAddPop(rowdata.itemNo);
					} */
					,beforeSelectRow: function (rowid, e) {
					    var $myGrid = $(this),
					        i = $.jgrid.getCellIndex($(e.target).closest('td')[0]),
					        cm = $myGrid.jqGrid('getGridParam', 'colModel');
					    return (cm[i].name === 'cb');
					}
					, onCellSelect : function (id, cellidx, cellvalue) {											
						var rowdata = $("#brandCntsItemList").getRowData(id);
						console.log(rowdata);
						if(cellidx != 0) {
							brandCntsItemAddPop(rowdata.itemNo);
						}
					}
				};
				grid.create("brandCntsItemList", options);
			}

			// 브랜드 콘텐츠 아이템 추가
			function brandCntsItemAddPop(itemNo) {
				<c:if test="${empty brandCnts}">
					messager.alert("<spring:message code='admin.web.view.msg.brandCnts.after.save.add' />","Info","info");
					return;
				</c:if>
				
				var options = {
					url : "/brandCnts/brandCntsItemViewPop.do"
					, data : {
						bndCntsNo : '${brandCnts.bndCntsNo}',
						itemNo : itemNo
					 }
					, dataType : "html"
					, callBack : function (data ) {
						var config = {
							id : "brandCntsItemView"
							, width : 700
							, height : 300
							, top : 200
							, title : "브랜드 콘텐츠 아이템 등록"
							, body : data
							, button : "<button type=\"button\" onclick=\"insertBrandCntsItem();\" class=\"btn btn-ok\">저장</button>"
						}
						layer.create(config);
					}
				}
				ajax.call(options );
			}

			// 브랜드 콘텐츠 아이템 삭제
			function brandCntsItemDelDisp() {
				var grid = $("#brandCntsItemList");

				var rowids = grid.jqGrid('getGridParam', 'selarrrow');
				if(rowids.length <= 0 ) {
					messager.alert("<spring:message code='column.common.delete.no_select' />", "Info", "info");
					return;
				}
				
				messager.confirm("<spring:message code='column.common.confirm.delete' />",function(r){
					if(r){
						var itemNos = new Array();
						for (var i = rowids.length - 1; i >= 0; i--) {
							itemNos.push (rowids[i] );
						}
						
						var options = {
							url : "<spring:url value='/brandCnts/brandCntsItemDelete.do' />"
							, data : {itemNos : itemNos }
							, callBack : function(data ) {
								messager.alert("<spring:message code='column.common.delete.final_msg' arguments='" + data.delCnt + "' />", "Info", "info", function(){
									reloadBrandCntsItemGrid();
								});
							}
						};
						ajax.call(options);
					}
				});
			}
			
			function reloadBrandCntsItemGrid() {
				var options = {
					searchParam : {
						bndCntsNo : '${brandCnts.bndCntsNo}'
					}
				};

				grid.reload("brandCntsItemList", options);
			}

			function insertBrandCnts() {
				if(validate.check("brandCntsForm")) {
					messager.confirm("<spring:message code='column.common.confirm.insert' />",function(r){
						if(r){
							var data = $("#brandCntsForm").serializeJson();
	
							var options = {
								url : "<spring:url value='/brandCnts/brandCntsInsert.do' />"
								, data :  data
								, callBack : function(result){
									updateTab("/brandCnts/brandCntsView.do?bndCntsNo=" + result.brandCnts.bndCntsNo, "<spring:message code='admin.web.view.app.brand.contents_detail' />");
								}
							};
	
							ajax.call(options);
						}
					});
				}
			}

			function updateBrandCnts() {
				if(validate.check("brandCntsForm")) {					
					messager.confirm("<spring:message code='column.common.confirm.update' />",function(r){
						if(r){
							var data = $("#brandCntsForm").serializeJson();
	
							var options = {
								url : "<spring:url value='/brandCnts/brandCntsUpdate.do' />"
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

			function deleteBrandCnts() {
				messager.confirm("<spring:message code='column.common.confirm.delete' />",function(r){
					if(r){
						var options = {
							url : "<spring:url value='/brandCnts/brandCntsDelete.do' />"
							, data :  {
								bndCntsNo : '${brandCnts.bndCntsNo}'
							}
							, callBack : function(result){
								closeGoTab("<spring:message code='admin.web.view.app.brand.contents_list' />", "/brandCnts/brandCntsListView.do");
							}
						};
	
						ajax.call(options);
					}
				});
			}

			// 이미지(PC) 파일 업로드
			function resultCntsImage(result) {
				$("#cntsImgPath").val(result.filePath);
			}

			// 이미지(MOBILE) 파일 업로드
			function resultCntsMoImage(result) {
				$("#cntsMoImgPath").val(result.filePath);
			}

			// 이미지(PC) 파일 업로드
			function resultTnImage(result) {
				$("#tnImgPath").val(result.filePath);
			}

			// 이미지(MOBILE) 파일 업로드
			function resultTnMoImage(result) {
				$("#tnMoImgPath").val(result.filePath);
			}
		</script>
	</t:putAttribute>
	<t:putAttribute name="content">
	
		<form id="brandCntsForm" name="brandCntsForm" method="post" >
			<table class="table_type1">
				<c:if test="${empty brandCnts}">
					<caption>브랜드 콘텐츠 등록</caption>
				</c:if>
				<c:if test="${not empty brandCnts}">
					<caption>브랜드 콘텐츠 상세</caption>
				</c:if>
				<tbody>
					<tr>
						<th><spring:message code="column.bnd_cnts_no" /><strong class="red">*</strong></th>	<!-- 브랜드 콘텐츠 번호 -->
						<td>
							<input type="hidden" id="bndCntsNo" name="bndCntsNo" value="${brandCnts.bndCntsNo }" />
							<c:if test="${empty brandCnts}">
								<b>자동입력</b>
							</c:if>
							<c:if test="${not empty brandCnts}">
								<b>${brandCnts.bndCntsNo }</b>
							</c:if>
						</td>
						<th><spring:message code="column.cnts_gb_cd" /><strong class="red">*</strong></th>	<!-- 콘텐트 구분 코드-->
						<td>						
							<select class="validate[required]" name="cntsGbCd" id="cntsGbCd" title="<spring:message code="column.cnts_gb_cd" />" >
								<frame:select grpCd="${adminConstants.CNTS_GB }" selectKey="${brandCnts.cntsGbCd}" />
							</select>
						</td>
					</tr>
					<tr>
						<th><spring:message code="column.bnd_no" /><strong class="red">*</strong></th> <!-- 브랜드 번호 -->
						<td colspan="3">
							<frame:bndNo funcNm="searchBrand()" requireYn="Y" defaultBndNmKo="${brandCnts.bndNmKo }" defaultBndNmEn="${brandCnts.bndNmEn }" defaultBndNo="${brandCnts.bndNo }" />
						</td>
					</tr>
					<tr>
						<th><spring:message code="column.ttl"/><strong class="red">*</strong></th> <!-- 콘텐츠 타이틀 -->
						<td colspan="3">
							<input type="text" class="w300 validate[required]" name="cntsTtl" id="cntsTtl" title="<spring:message code="column.ttl"/>" value="${brandCnts.cntsTtl}" />
						</td>
					</tr>
					<tr>
						<th><spring:message code="column.dscrt" /></th> <!-- 콘텐츠 설명-->
						<td colspan="3">
							<textarea name="cntsDscrt" id="cntsDscrt" title="<spring:message code="column.dscrt"/>" rows="3" cols="70">${brandCnts.cntsDscrt }</textarea>
						</td>
					</tr>
					<tr>
						<th><spring:message code="column.cnts_img_path"/><strong class="red">*</strong></th>
						<td colspan="3">
							<!-- 이미지(PC) -->
							<input type="text" class="w300 readonly validate[required]" readonly="readonly" name="cntsImgPath" id="cntsImgPath" title="<spring:message code="column.cnts_img_path"/>" value="${brandCnts.cntsImgPath}" />
							<button type="button" onclick="fileUpload.image(resultCntsImage);" class="btn">파일찾기</button>
						</td>
					</tr>
					<tr>
						<th><spring:message code="column.cnts_mo_img_path"/><strong class="red">*</strong></th>
						<td colspan="3">
							<!-- 이미지(PC) -->
							<input type="text" class="w300 readonly validate[required]" readonly="readonly" name="cntsMoImgPath" id="cntsMoImgPath" title="<spring:message code="column.cnts_mo_img_path"/>" value="${brandCnts.cntsMoImgPath}" />
							<button type="button" onclick="fileUpload.image(resultCntsMoImage);" class="btn">파일찾기</button>
						</td>
					</tr>
					<tr>
						<th><spring:message code="column.tn_img_path"/><strong class="red">*</strong></th>
						<td colspan="3">
							<!-- 이미지(PC) -->
							<input type="text" class="w300 readonly validate[required]" readonly="readonly" name="tnImgPath" id="tnImgPath" title="<spring:message code="column.tn_img_path"/>" value="${brandCnts.tnImgPath}" />
							<button type="button" onclick="fileUpload.image(resultTnImage);" class="btn">파일찾기</button>
						</td>
					</tr>
					<tr>
						<th><spring:message code="column.tn_mo_img_path"/><strong class="red">*</strong></th>
						<td colspan="3">
							<!-- 이미지(PC) -->
							<input type="text" class="w300 readonly validate[required]" readonly="readonly" name="tnMoImgPath" id="tnMoImgPath" title="<spring:message code="column.tn_mo_img_path"/>" value="${brandCnts.tnMoImgPath}" />
							<button type="button" onclick="fileUpload.image(resultTnMoImage);" class="btn">파일찾기</button>
						</td>
					</tr>
				</tbody>
			</table>
		</form>
		<hr />
		
		<div class="mTitle">
			<h2>브랜드 콘텐츠 아이템</h2>
			<div class="buttonArea">
				<button type="button" onclick="brandCntsItemAddPop('');" class="btn btn-add"><spring:message code="column.common.addition" /></button>
				<button type="button" onclick="brandCntsItemDelDisp();" class="btn btn-add"><spring:message code="column.common.delete" /></button>
			</div>
		</div>
		<table id="brandCntsItemList" ></table>
		<div id="brandCntsItemPage"></div>
		
		<div class="btn_area_center">
		<c:if test="${empty brandCnts}">
			<button type="button" onclick="insertBrandCnts();" class="btn btn-ok">등록</button>
			<button type="button" onclick="closeTab();" class="btn btn-cancel">취소</button>
		</c:if>
		<c:if test="${not empty brandCnts}">
			<button type="button" onclick="updateBrandCnts();" class="btn btn-ok">수정</button>
			<button type="button" onclick="deleteBrandCnts();" class="btn btn-add">삭제</button>
			<button type="button" onclick="closeTab();" class="btn btn-cancel">닫기</button>
		</c:if>
			
		</div>
	</t:putAttribute>
</t:insertDefinition>
