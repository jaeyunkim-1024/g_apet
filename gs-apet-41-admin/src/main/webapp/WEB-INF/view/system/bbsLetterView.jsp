<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">
			$(document).ready(function(){
				EditorCommon.setSEditor('content', '${adminConstants.BOARD_IMAGE_PATH}');
				
				// 상품 그리드
				createBbsLetterGoodsGrid(); 
				
			});

			//게시판 글 등록
			function bbsLetterInsert(){
				if(validate.check("boardForm")) {
					oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
					
					// 내용 체크
					if( !editorRequired( 'content' ) ){ return false };
					
					messager.confirm('<spring:message code="column.common.confirm.insert" />', function(r){
						if(r){
							var data = $("#boardForm").serializeJson();
							<c:if test="${board.flUseYn eq adminConstants.USE_YN_Y}">
							var arrFile = new Array();
							$(".bbsFileView").each(function(e) {
								if(!validation.isNull($(this).find("input[name=orgFlNm]").val())){
									arrFile.push($(this).serializeJson());
								}
							});

							if(arrFile != null && arrFile.length > 0) {
								data.arrFileStr = JSON.stringify(arrFile);
							}
							</c:if>
							
							//console.log(data);
							//console.log("===");
							<c:if test="${board.goodsUseYn eq adminConstants.USE_YN_Y}">
							
								var goodsIdx = $('#bbsLetterGoodsList').getDataIDs();
								var arrGoodsId = null;
								
								if(goodsIdx != null && goodsIdx.length > 0) {
									arrGoodsId = goodsIdx.join(",");
								}
								
								$.extend(data, { goodsUseYn : '${board.goodsUseYn}' }, { arrGoodsId : arrGoodsId });
							</c:if>
							//console.log(data);
							//return;
							var options = {
								url : "<spring:url value='/${board.bbsId}/bbsLetterInsert.do' />"
								, data : data
								, callBack : function(result){
									messager.alert('<spring:message code="admin.web.view.common.normal_process.final_msg" />', "Info", "info", function(){
										var title = getSeletedTabTitle().replace('등록', '상세');
										updateTab('/${board.bbsId}/bbsLetterDetailView.do?lettNo=' + result.bbsLetter.lettNo, title);
									});
								}
							};
							ajax.call(options);
						}
					})
				}
			}

			function bbsLetterUpdate(){
				if(validate.check("boardForm")) {
					oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
					// 내용 체크
					if( !editorRequired( 'content' ) ){ return false };
					
					messager.confirm('<spring:message code="column.common.confirm.update" />', function(r){
						if(r){
							var data = $("#boardForm").serializeJson();
							<c:if test="${board.flUseYn eq adminConstants.USE_YN_Y}">
							var arrFile = new Array();
							$(".bbsFileView").each(function(e) {
								if(!validation.isNull($(this).find("input[name=orgFlNm]").val())){
									arrFile.push($(this).serializeJson());
								}
							});

							if(arrFile != null && arrFile.length > 0) {
								data.arrFileStr = JSON.stringify(arrFile);
							}
							</c:if>
							
							
							//console.log(data);
							//console.log("===");
							<c:if test="${board.goodsUseYn eq adminConstants.USE_YN_Y}">
							
								var goodsIdx = $('#bbsLetterGoodsList').getDataIDs();
								var arrGoodsId = null;
								
								if(goodsIdx != null && goodsIdx.length > 0) {
									arrGoodsId = goodsIdx.join(",");
								}
								
								$.extend(data ,  { goodsUseYn : '${board.goodsUseYn}' },  { arrGoodsId : arrGoodsId });
							</c:if>
							//console.log(data);
							 
							
							
							var options = {
								url : "<spring:url value='/${board.bbsId}/bbsLetterUpdate.do' />"
								, data : data
								, callBack : function(result){
									messager.alert('<spring:message code="admin.web.view.common.normal_process.final_msg" />', "Info", "info", function(){
										updateTab('/${board.bbsId}/bbsLetterDetailView.do?lettNo=' + result.bbsLetter.lettNo);	
									});
								}
							};
							ajax.call(options);
						}
					})
				}
			}
			
			function bbsFileUpload(id) {
				fileUpload.fileFilter(function(result) {
					var $obj = $("#bbsFileView" + id);
					$obj.find("input[name=phyPath]").val(result.filePath);
					$obj.find("input[name=flSz]").val(result.fileSize);
					$obj.find("input[name=ext]").val(result.fileExe);
					$obj.find("input[name=orgFlNm]").val(result.fileName);
					objClass.add($obj.find("input[name=orgFlNm]"), "validate[required]");
					$obj.find("input[name=orgFlNm]")
					$obj.find("button[name=bbsFileUpladBtn]").hide();
					$obj.find("button[name=bbsFileDelBtn]").show();
				}, '${board.uploadExt}');
			}

			function bbsFileDel(id) {
				var $obj = $("#bbsFileView" + id);

				if(!validation.isNull($obj.find("input[name=seq]").val())){
					messager.confirm('<spring:message code="column.common.confirm.delete" />', function(r){
						if(r){
							var options = {
									url : "<spring:url value='/${board.bbsId}/bbsFileDelete.do' />"
									, data : {
										flNo : '${bbsLetter.flNo}'
										, seq : $obj.find("input[name=seq]").val()
									}
									, callBack : function(result){
										$obj.find("input[name=seq]").val('');
										$obj.find("input[name=phyPath]").val('');
										$obj.find("input[name=flSz]").val('');
										$obj.find("input[name=orgFlNm]").val('');
										objClass.remove($obj.find("input[name=orgFlNm]"), "validate[required]");
										$obj.find("button[name=bbsFileUpladBtn]").show();
										$obj.find("button[name=bbsFileDelBtn]").hide();
									}
								};
								ajax.call(options);
						}
					})
				} else {
					$obj.find("input[name=seq]").val('');
					$obj.find("input[name=phyPath]").val('');
					$obj.find("input[name=flSz]").val('');
					$obj.find("input[name=orgFlNm]").val('');
					objClass.remove($obj.find("input[name=orgFlNm]"), "validate[required]");
					$obj.find("button[name=bbsFileUpladBtn]").show();
					$obj.find("button[name=bbsFileDelBtn]").hide();
				}
			}

			function resultBbsImage(result) {
				$("#imgPathView").attr('src', '/common/imageView.do?filePath=' + result.filePath);
				$("#imgPath").val(result.filePath);
			}
			function deleteImage() {
				$("#imgPath").val("");
				$("#imgPathView").attr('src', '/images/noimage.png' );
			}
			// 상품 리스트
			function createBbsLetterGoodsGrid(){
				var options = {
					url : "<spring:url value='/system/bbsLetterGoodsListGrid.do' />"
					, height : 200
					, multiselect : true
					, searchParam : {
						lettNo : '${bbsLetter.lettNo}'
					}
					, colModels : [
						  {name:"lettNo", hidden:true }
						, {name:"dispPriorRank", hidden:true }
						, {name:"goodsId", label:_GOODS_SEARCH_GRID_LABEL.goodsId, key:true, width:"100", align:"center", sortable:false} /* 상품 번호 */
						, {name:"goodsNm", label:_GOODS_SEARCH_GRID_LABEL.goodsNm, width:"300", align:"center", sortable:false } /* 상품명 */
						/* , {name:"stNms", label:'<spring:message code="column.st_nm" />', width:"120", align:"center"}   사이트 명   */
						, {name:"goodsStatCd", label:_GOODS_SEARCH_GRID_LABEL.goodsStatCd, width:"150", align:"center", sortable:false, formatter:"select", editoptions:{value:_GOODS_STAT_CD } } /* 상품 상태 */
						, {name:"bigo", label:_GOODS_SEARCH_GRID_LABEL.bigo, width:"200", align:"center", sortable:false } /* 비고 */
						, {name:"goodsTpCd", label:_GOODS_SEARCH_GRID_LABEL.goodsTpCd, width:"150", align:"center", sortable:false, formatter:"select", editoptions:{value:_GOODS_TP_CD } } /* 상품 유형 */
						, {name:"mdlNm", label:_GOODS_SEARCH_GRID_LABEL.mdlNm, width:"200", align:"center", sortable:false } /* 모델명 */
						, {name:"saleAmt", label:_GOODS_SEARCH_GRID_LABEL.saleAmt, width:"100", align:"center", sortable:false, formatter: 'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','} } /* 판매가 */
						, {name:"compNm", label:_GOODS_SEARCH_GRID_LABEL.compNm, width:"200", align:"center", sortable:false } /* 업체명 */
						, {name:"bndNmKo", label:_GOODS_SEARCH_GRID_LABEL.bndNmKo, width:"200", align:"center", sortable:false } /* 브랜드명 */
						, {name:"mmft", label:_GOODS_SEARCH_GRID_LABEL.mmft, width:"200", align:"center", sortable:false } /* 제조사 */
						, {name:"saleStrtDtm", label:_GOODS_SEARCH_GRID_LABEL.saleStrtDtm, width:"200", align:"center", sortable:false, formatter:gridFormat.date, dateformat:_COMMON_DATE_FORMAT }
						, {name:"saleEndDtm", label:_GOODS_SEARCH_GRID_LABEL.saleEndDtm, width:"200", align:"center", sortable:false, formatter:gridFormat.date, dateformat:_COMMON_DATE_FORMAT }
						, {name:"showYn", label:_GOODS_SEARCH_GRID_LABEL.showYn, width:"150", align:"center", sortable:false, formatter:"select", editoptions:{value:_SHOW_YN } } /* 노출여부 */
					]
					, paging : false
				};
				grid.create("bbsLetterGoodsList", options);
			}
			
			function bbsLetterGoodsLayer() {
				var options = {
					multiselect : true
					, callBack : function(result) {
						if(result != null) {
							var idx = $('#bbsLetterGoodsList').getDataIDs();
							var message = new Array();
							for(var i in result){
								var check = true;
								for(var j in idx) {
									if(result[i].goodsId == idx[j]) {
										check = false;
									}
								}

								if(check) {

									// 착불 여부 check
									var optionsNest = {
											url : "<spring:url value='/promotion/goodsDlvrcPayMth.do' />"
											, data :  {
												goodsId : result[i].goodsId
											}
											, async : false
											, callBack : function(resultNest){
												if(resultNest == '${adminConstants.DLVRC_PAY_MTD_20}'){
													message.push(result[i].goodsNm + " 배송비 결제 방법이 착불 상품입니다.");
												}else{
													$("#bbsLetterGoodsList").jqGrid('addRowData', result[i].goodsId, result[i], 'last', null);				
												}
											}
										};

									ajax.call(optionsNest);									

								} else {
									message.push(result[i].goodsNm + " 중복된 상품입니다.");
								}
							}

							if(message != null && message.length > 0) {
								messager.alert(message.join("<br>"), "Info", "info");
							}
						}
					}
				}
				layerGoodsList.create(options);
			}
			function bbsLetterGoodsDelete() {
				var rowids = $("#bbsLetterGoodsList").jqGrid('getGridParam', 'selarrrow');
				var delRow = new Array();
				if(rowids != null && rowids.length > 0) {
					for(var i in rowids) {
						delRow.push(rowids[i]);
					}
				}
				if(delRow != null && delRow.length > 0) {
					for(var i in delRow) {
						$("#bbsLetterGoodsList").delRowData(delRow[i]);
					}
				} else {
					messager.alert('<spring:message code="admin.web.view.msg.invalid.good" />', "Info", "info");
				}
			}
		</script>
	</t:putAttribute>
	<t:putAttribute name="content">
			<form name="boardForm" id="boardForm" method="post">
			<input type="hidden" name="lettNo" value="${bbsLetter.lettNo}">
			<table class="table_type1">
				<caption>게시판 글</caption>
				<tbody>
					<tr>
						<th><spring:message code="column.lett_no"/><strong class="red">*</strong></th>
						<td>
							<!-- 게시판 번호-->
							${board.bbsId}
						</td>
						<th><spring:message code="column.bbs_nm" /></th>
						<td>
							<!-- 게시판 명 -->
							${board.bbsNm}
						</td>
					</tr>
					<tr>
						<th><spring:message code="column.ttl"/><strong class="red">*</strong></th>
						<td>
							<!-- 제목-->
							<input type="text" class="w400 validate[required,maxSize[100]]" name="ttl" id="ttl" title="<spring:message code="column.ttl"/>" value="${bbsLetter.ttl}" />
						</td>
						<th>작성자<strong class="red">*</strong></th>
						<td>
							${empty bbsLetter ? adminSession.usrNm : bbsLetter.sysRegrNm}
						</td>
					</tr>
					<tr>
						<th><spring:message code="column.top_fix_yn"/><strong class="red">*</strong></th>
						<td>
							<!-- 상단 고정 여부 -->
							<frame:radio name="topFixYn" grpCd="${adminConstants.TOP_FIX_YN}" selectKey="${bbsLetter.topFixYn == null ? 'N' : bbsLetter.topFixYn}"/>
						</td>
					</tr>
					<%-- <tr>
						<!-- 사이트 구분 코드 -->
						<th><spring:message code="column.show_gb_cd"/><strong class="red">*</strong></th>
						<td colspan="3">
							<frame:radio name="showGbCd" grpCd="${adminConstants.SHOW_GB}" />
						</td>
					</tr> --%>
				<c:if test="${board.bbsTpCd eq adminConstants.BBS_TP_20}">
					<tr>
						<th><spring:message code="column.rcom_yn"/></th>
						<td colspan="3">
							<frame:radio name="rcomYn" grpCd="${adminConstants.COMM_YN}" selectKey="${bbsLetter.rcomYn == null ? 'N' : bbsLetter.rcomYn}"/>
						</td>
					</tr>
				</c:if>
				<c:if test="${board.gbUseYn eq adminConstants.USE_YN_Y}">
					<tr>
						<th><spring:message code="column.bbs_gb_no"/><strong class="red">*</strong></th>
						<td colspan="3">
							<!-- 게시판 구분 코드-->
							<c:forEach items="${listBoardGb}" var="item">
								<label class="fRadio"><input type="radio" class="validate[required]" name="bbsGbNo" value="${item.bbsGbNo}" ${item.bbsGbNo eq bbsLetter.bbsGbNo ? 'checked="checked"' : ''}> <span>${item.bbsGbNm }</span></label>
							</c:forEach>
						</td>
					</tr>
				</c:if>
				<c:if test="${(adminConstants.BBS_TP_30 eq board.bbsTpCd) or (adminConstants.BBS_TP_40 eq board.bbsTpCd) or (adminConstants.BBS_TP_41 eq board.bbsTpCd)}">
					<tr>
						<!-- 이미지 경로 -->
						<th><spring:message code="column.img_path"/><strong class="red">*</strong></th>
						<td colspan="3">
							<div class="inner">
								<c:if test="${empty bbsLetter.imgPath}">
								<img id="imgPathView" name="imgPathView" src="/images/noimage.png" class="thumb" alt="">
								</c:if>
								<c:if test="${not empty bbsLetter.imgPath}">
									<img id="imgPathView" name="imgPathView" src="<frame:imgUrl/>${bbsLetter.imgPath}" class="thumb" alt="">
								</c:if>
							</div>
							<div class="inner ml10" style="vertical-align:bottom">
								<button type="button" onclick="fileUpload.image(resultBbsImage);" class="btn"><spring:message code="column.common.addition" /></button> <!-- 추가 -->
								<button type="button" onclick="deleteImage();" class="btn"><spring:message code="column.common.delete" /></button> <!-- 삭제 -->
							</div>
							<input class="validate[required]" type="text" name="imgPath" id="imgPath" title="<spring:message code="column.img_path"/>" value="${bbsLetter.imgPath}" style="visibility: hidden" />
						</td>
					</tr>
				</c:if>
				<!-- 게시판 글 이미지-->
				<c:if test="${board.flUseYn eq adminConstants.USE_YN_Y}">
					<tr>
						<th><spring:message code="column.fl_no"/></th>
						<td colspan="3">
							<c:forEach var="item" items="${listFile }" varStatus="idx">
								<div class="mg5 bbsFileView" id="bbsFileView${idx.index}">
									<input type="hidden" name="seq" title="<spring:message code="column.seq"/>" value="${item.seq}">
									<input type="hidden" name="phyPath" title="<spring:message code="column.phy_path"/>" value="${item.phyPath}">
									<input type="hidden" name="flSz" title="<spring:message code="column.fl_sz"/>" value="${item.flSz}">
									<input type="text" class="readonly w400" readonly="readonly" name="orgFlNm" title="<spring:message code="column.org_fl_nm"/>" value="${item.orgFlNm}" />
									<button type="button" name="bbsFileUpladBtn" style="display: none;" onclick="bbsFileUpload('${idx.index}');" class="btn">파일찾기</button>
									<button type="button" name="bbsFileDelBtn" onclick="bbsFileDel('${idx.index}');" class="btn">삭제</button>
								</div>
							</c:forEach>
							<c:forEach var="item" begin="${fn:length(listFile)}" end="${board.atchFlCnt - 1}">
							<div class="mg5 bbsFileView" id="bbsFileView${item}">
								<input type="hidden" name="seq" title="<spring:message code="column.seq"/>" value="">
								<input type="hidden" name="phyPath" title="<spring:message code="column.phy_path"/>" value="">
								<input type="hidden" name="flSz" title="<spring:message code="column.fl_sz"/>" value="">
								<input type="text" class="readonly w400" readonly="readonly" name="orgFlNm" title="<spring:message code="column.org_fl_nm"/>" value="" />
								<button type="button" name="bbsFileUpladBtn" onclick="bbsFileUpload('${item}');" class="btn">파일찾기</button>
								<button type="button" name="bbsFileDelBtn" style="display: none;" onclick="bbsFileDel('${item}');" class="btn">삭제</button>
							</div>
							</c:forEach>
						</td>
					</tr>
				</c:if>
					<tr>
						<th><spring:message code="column.content"/><strong class="red">*</strong></th>
						<td colspan="3" >
						<div disabled >
							<!-- 내용-->
							<textarea style="width: 100%; height: 300px;" name="content" id="content" title="<spring:message code="column.content"/>">${bbsLetter.content}</textarea>
						</div>
						</td>
					</tr>
					<tr>
						<th><spring:message code="column.usr_dfn_1"/></th>
						<td colspan="3">
							<!-- 사용자 정의 1-->
							<input type="text" class="w400 validate[maxSize[200]]" name="usrDfn1Val" id="usrDfn1Val" title="<spring:message code="column.usr_dfn_1" />" value="${bbsLetter.usrDfn1Val }" />
						</td>
					</tr>
					<tr>
						<th><spring:message code="column.usr_dfn_2"/></th>
						<td colspan="3">
							<!-- 사용자 정의 2-->
							<input type="text" class="w400 validate[maxSize[200]]" name="usrDfn2Val" id="usrDfn2Val" title="<spring:message code="column.usr_dfn_2" />" value="${bbsLetter.usrDfn2Val }" />
						</td>
					</tr>
					<tr>
						<th><spring:message code="column.usr_dfn_3"/></th>
						<td colspan="3">
							<!-- 사용자 정의 3-->
							<input type="text" class="w400 validate[maxSize[200]]" name="usrDfn3Val" id="usrDfn3Val" title="<spring:message code="column.usr_dfn_3" />" value="${bbsLetter.usrDfn3Val }" />
						</td>
					</tr>
					<tr>
						<th><spring:message code="column.usr_dfn_4"/></th>
						<td colspan="3">
							<!-- 사용자 정의 4-->
							<input type="text" class="w400 validate[maxSize[200]]" name="usrDfn4Val" id="usrDfn4Val" title="<spring:message code="column.usr_dfn_4" />" value="${bbsLetter.usrDfn4Val }" />
						</td>
					</tr>
					<tr>
						<th><spring:message code="column.usr_dfn_5"/></th>
						<td colspan="3">
							<!-- 사용자 정의 5-->
							<input type="text" class="w400 validate[maxSize[200]]" name="usrDfn5Val" id="usrDfn5Val" title="<spring:message code="column.usr_dfn_5" />" value="${bbsLetter.usrDfn5Val }" />
						</td>
					</tr>
				</tbody>
			</table>
			<div id="goodsView" ${adminConstants.USE_YN_Y eq board.goodsUseYn ? '' : 'style="display: none;"'} class="mt30">
				<div class="mTitle">
					<h2>적용 상품</h2>
					<div class="buttonArea">
						<button type="button" onclick="bbsLetterGoodsLayer();" class="btn btn-add">추가</button>
						<button type="button" onclick="bbsLetterGoodsDelete();" class="btn btn-add">삭제</button>
					</div>
				</div>
	
				<div class="mModule" style="margin-top:0">
					<table id="bbsLetterGoodsList" class="grid"></table>
				</div>
			</div>
			</form>

			<div class="btn_area_center">
			<c:if test="${empty bbsLetter}">
				<button type="button" onclick="bbsLetterInsert();" class="btn btn-ok">등록</button>
				<button type="button" onclick="closeTab();" class="btn btn-cancel">취소</button>
			</c:if>
			<c:if test="${not empty bbsLetter}">
				<button type="button" onclick="bbsLetterUpdate();" class="btn btn-ok">수정</button>
				<button type="button" onclick="closeTab();" class="btn btn-cancel">닫기</button>
			</c:if>
				
			</div>
	</t:putAttribute>
</t:insertDefinition>
