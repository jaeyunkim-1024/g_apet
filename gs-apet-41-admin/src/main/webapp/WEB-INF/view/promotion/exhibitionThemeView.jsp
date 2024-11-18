<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">
			var compId;
			var idIndex = 0;
			var isUser;
			
			$(document).ready(function(){	
				initView();
				
				var exhbtStatCd = "${exhibitionThemeList[0].exhbtStatCd}";
				if(exhbtStatCd == "40" ){
// 				if("${so.exhbtStatCd}" == "40" ){
					$("button[name=readonlyBtn]").css("display", "none");
					$("input[name^=dispYn]").prop("disabled", true);
					$("input[name^=thmNmShowYn]").prop("disabled", true);
					$("select[name=thmCnt]").prop("disabled", true);
					$("input[name^=thmNm]").prop("disabled", true);
					$("input[name^=thmNm]").attr("class", "readonly");
				}
			});
			

			function initView(){
				isUser = "N";
				if ("${adminConstants.USR_GRP_10}" == "${adminSession.usrGrpCd}") {
					isUser = "Y";
				}
				
				<c:if test="${exhibitionThemeList ne '[]'}">
					<c:forEach items="${exhibitionThemeList}" var="exhibitionTheme">						
						var exhibitionTheme = {
								thmNo : "${exhibitionTheme.thmNo}"
								, thmNm : "${exhibitionTheme.thmNm}"
								, listTpCd : "${exhibitionTheme.listTpCd}"
								, compNo : "${exhibitionTheme.compNo}"
								, compNm : "${exhibitionTheme.compNm}"
								, dispYn : "${exhibitionTheme.dispYn}"
								, thmNmShowYn : "${exhibitionTheme.thmNmShowYn}"
		 				};
						
						exhibitionThemeAdd(exhibitionTheme);
					</c:forEach>
				</c:if>
			}

			// 업체 검색
			function searchCompany (idx) {
				compId = idx;
				var options = {
					multiselect : false
					, callBack : searchCompanyCallback
					<c:if test="${adminConstants.USR_GB_2010 eq adminSession.usrGbCd}">
	                	, showLowerCompany : 'Y'
					</c:if>
				}
				layerCompanyList.create (options );
			}
			function searchCompanyCallback (compList ) {
				if(compList.length > 0 ) {
					$("#exhibitionThemeForm #compNo" + compId).val (compList[0].compNo );
					$("#exhibitionThemeForm #compNm" + compId).val (compList[0].compNm );
				}
			}

			function fnChangeView( viewType ) {
				var url;
				if ( viewType == 10 ) {
					url = "/promotion/exhibitionBaseView.do";
				} else if ( viewType == 20 ) {
					url = "/promotion/exhibitionThemeView.do";
				} else if ( viewType == 30 ) {
					url = "/promotion/exhibitionThemeGoodsView.do";
				}
				url += '?exhbtNo=' + '${so.exhbtNo }';
				updateTab(url, "기획전 상세");
			}
			
			function exhibitionThemeAdd(exhibitionTheme) {
				var defaultCompNo = "";
				var defaultCompNm = "";
				if ("${adminConstants.USR_GRP_10}" != "${adminSession.usrGrpCd}") {
					defaultCompNo = "${adminSession.compNo }";
					defaultCompNm = "${adminSession.compNm }";
				}
				
				if (exhibitionTheme != "") {
					defaultCompNo = exhibitionTheme.compNo;
					defaultCompNm = exhibitionTheme.compNm;
				}
				
				var loop = 1;
				if (exhibitionTheme == "") { 
					if ($("#thmCnt").val() == "") {
						messager.alert("<spring:message code='admin.web.view.msg.exhibition.theme.count' />","Info","info");
						return;
					} else {
						loop = Number($("#thmCnt").val());
					}
				}
				
				for (i=0; i<loop; i++) {
					idIndex += 1;					
					var html = '<table class="table_type1 mt10" id="thmTable'  + idIndex +  '">';
					html += '	<colgroup>';
					html += '		<col style="width:40px;">';
					html += '		<col style="width:170px">';
					html += '		<col style="width:auto;">';
					html += '		<col style="width:170px">';
					html += '		<col style="width:auto;">';
					html += '	</colgroup>';
					html += '	<tbody>';
					html += '		<tr>';
					html += '			<th rowspan="3" style="border-right:1px solid #dadada"><label class="fCheck"><input type="checkbox" name="thmChk" id="thmChk' + idIndex + '" data-idx="'+idIndex+'"/><span></span></label></th>';
					html += '			<!-- 테마 번호 -->';
					html += '			<th><spring:message code="column.thm_no" /><strong class="red">*</strong></th>';
					html += '			<td>';
					if (exhibitionTheme == "") {  //APETQA-6292 2021.08.06 수정 kjh02
						html += '				<input type="hidden" class="thmNo" id="thmNo' + idIndex + '" name="thmNo' + idIndex + '" value="" />';
						html += '				<b>자동입력</b>';
					} else {
						html += '				<input type="hidden"  class="thmNo" id="thmNo' + idIndex + '" name="thmNo' + idIndex + '" value="' + exhibitionTheme.thmNo + '" />';
						html += '				<b>' + exhibitionTheme.thmNo + '</b>';
					}
					
					html += '			<!-- 전시여부 -->';
					html += '			<th><spring:message code="column.disp_yn"/></th>';
					html += '			<td>';
					<c:forEach items="${dispYnList}" var="dispYn" varStatus="idx">
						html += '				<label class="fRadio"><input name="dispYn' + idIndex + '" id="dispYn${dispYn.dtlCd}' + idIndex + '" value="${dispYn.dtlCd}"';
						if ("${idx.index}" == "0" && exhibitionTheme == "") {
							html += ' checked="checked"';
						} else if ("${dispYn.dtlCd}" == exhibitionTheme.dispYn) {
							html += ' checked="checked"';
						}
						html += ' type="radio"> <span>${dispYn.dtlNm}</span></label>';
					</c:forEach>
// 					if (exhibitionTheme == "") {
// 						html += '				<frame:radio name="dispYn" grpCd="${adminConstants.DISP_YN }" selectKey="${adminConstants.DISP_YN_Y }" idIndex= "' + idIndex + '"/>';
// 					} else {
// 						html += '				<frame:radio name="dispYn" grpCd="${adminConstants.DISP_YN }" selectKey="' +  exhibitionTheme.dispYn + '" idIndex= "' + idIndex + '"/>';
// 					}
					html += '			</td>';
					html += '		</tr>';
					
					html += '		<tr>';
					html += '			<!-- 테마 명 -->'; 	
					html += '			<th scope="row"><spring:message code="column.thm_nm" /><strong class="red">*</strong></th>';
					html += '			<td>';
					if (exhibitionTheme == "") {  
						html += '				<input type="text" class="validate[required]" name="thmNm' + idIndex + '" id="thmNm' + idIndex + '" title="<spring:message code="column.thm_nm" />"  value="" />';
					} else {
						html += '				<input type="text" class="validate[required]" name="thmNm' + idIndex + '" id="thmNm' + idIndex + '" title="<spring:message code="column.thm_nm" />"  value="' + exhibitionTheme.thmNm + '" />';
					}
					html += '			</td>';
					html += '			<!-- 테마명 노출여부 -->';
					html += '			<th><spring:message code="column.thm_nm_show_yn" /></th>';
					html += '			<td>';
					<c:forEach items="${showYnList}" var="showYn" varStatus="idx">
						html += '				<label class="fRadio"><input name="thmNmShowYn' + idIndex + '" id="thmNmShowYn${showYn.dtlCd}' + idIndex + '" value="${showYn.dtlCd}"';
						if ("${idx.index}" == "0" && exhibitionTheme == "") {
							html += ' checked="checked"';
						} else if ("${showYn.dtlCd}" == exhibitionTheme.thmNmShowYn) {
							html += ' checked="checked"';
						}
						html += ' type="radio"> <span>${showYn.dtlNm}</span></label>';
					</c:forEach>
// 					if (exhibitionTheme == "") {
// 						html += '				<frame:radio name="thmNmShowYn" grpCd="${adminConstants.SHOW_YN }" selectKey="${adminConstants.SHOW_YN_Y }" idIndex= "' + idIndex + '"/>';
// 					} else {
// 						html += '				<frame:radio name="thmNmShowYn" grpCd="${adminConstants.SHOW_YN }" selectKey="' +  exhibitionTheme.thmNmShowYn + '" idIndex= "' + idIndex + '"/>';
// 					}
					html += '			</td>';
					html += '		</tr>';
					
// 					html += '		<tr>';
// 					html += '			<!-- 리스트타입 -->';
// 					html += '			<th scope="row"><spring:message code="column.list_tp_cd" /></th>';
// 					html += '	        <td>';
					
					
					
					if(exhibitionTheme.exhbtGb == "${adminConstants.EXHBT_GB_10}"){
						html += '	        	<input name="listTpCd' + idIndex + '" id="listTpCd' + idIndex + '" title="<spring:message code="column.list_tp_cd"/>" value="${adminConstants.LIST_TP_44}" type="hidden">';
					}else{
						html += '	        	<input name="listTpCd' + idIndex + '" id="listTpCd' + idIndex + '" title="<spring:message code="column.list_tp_cd"/>" value="${adminConstants.LIST_TP_55}" type="hidden">';
					}

					// 					html += '				<select class="validate[required]" name="listTpCd' + idIndex + '" id="listTpCd' + idIndex + '" title="<spring:message code="column.list_tp_cd"/>" >';
// 					html += '					<option value="">선택</option>';
					
// 					<c:forEach items="${listTpCdList}" var="listTpCd">
// 						html += '<option value="${listTpCd.dtlCd}"';
// 						if ("${listTpCd.dtlCd}" == exhibitionTheme.listTpCd) {
// 							html += ' selected="selected"';
// 						}
// 						html += ' >${listTpCd.dtlNm}</option>';
// 					</c:forEach>
					
					
// 					if (exhibitionTheme == "") {
// 		 				html += '					<frame:select grpCd="${adminConstants.LIST_TP}" defaultName="선택"/>';
// 					} else {
// 		 				html += '					<frame:select grpCd="${adminConstants.LIST_TP}" defaultName="선택" selectKey="' + exhibitionTheme.listTpCd + '"/>';
// 					}
// 					html += '				</select>';
// 					html += '	        </td>';
// 					html += '			<!-- 업체번호-->';
// 					html += '			<th scope="row"><spring:message code="column.comp_no" /></th>';
// 					html += '	        <td>';
// 					html += '	        	<input name="compNo' + idIndex + '" id="compNo' + idIndex + '" title="업체번호" value="' + defaultCompNo + '" type="hidden">';
// 					html += '	        	<input class="readonly" id="compNm' + idIndex + '" name="compNm' + idIndex + '" title="업체명" value="' + defaultCompNm + '" placeholder="" type="text">&nbsp;';
// 					if (isUser == "Y") {
// 						html += '	        	<button type="button" class="btn" onclick="searchCompany(' + idIndex + ');">검색</button>';
// 					}		
// // 					if (exhibitionTheme == "") {
// // 		 				html += '				<frame:compNo funcNm="searchCompany" idIndex= "' + idIndex + '" disableSearchYn="${isUser eq \'Y\' ? \'N\' : \'Y\'}" defaultCompNo="' + defaultCompNo + '" defaultCompNm="' + defaultCompNm + '"/>';
// // 					} else {
// // 		 				html += '				<frame:compNo funcNm="searchCompany" idIndex= "' + idIndex + '" disableSearchYn="${isUser eq \'Y\' ? \'N\' : \'Y\'}" defaultCompNo="' + exhibitionTheme.compNo + '" defaultCompNm="' + exhibitionTheme.compNm + '"/>';
// // 					}
// 					html += '	        </td>';
// 					html += '		</tr>';
					html += '	</tbody>';
					html += '</table>';
					
					jQuery("#themeDiv").append(html);
				}
				
				jQuery("#btnDiv").show();
			}
			
			function exhibitionThemeSave() {
				if(validate.check("exhibitionThemeForm")) {
					var themeItems = new Array();
					var thmChk = $("input:checkbox[name='thmChk']");
					
					jQuery(thmChk).each(function(i) {
						var index = thmChk[i].id.substring(thmChk[i].id.length-1, thmChk[i].id.length);
		        		var dataObj = new Object();
		        		
		        		var table =  $(this).parents("table")
						var delFlag = table[0].classList.contains("delY")
						if(delFlag){
							dataObj.delYn = "${adminConstants.DEL_YN_Y}"
						}
			
		        		dataObj.exhbtNo = "${so.exhbtNo}";
		        		dataObj.thmNo = $("#thmNo" + index).val();
		        		dataObj.thmNm = $("#thmNm" + index).val();
		        		dataObj.listTpCd = $("#listTpCd" + index).val();
		        		dataObj.compNo = $("#compNo" + index).val();
		        		
		        		var dispYn = document.getElementsByName("dispYn" + index);
		        		jQuery(dispYn).each(function(j) {
		        			if (dispYn[j].checked) {
			        			dataObj.dispYn = dispYn[j].value;
		        			}
		        		});
		        		
		        		var thmNmShowYn = document.getElementsByName("thmNmShowYn" + index);
		        		jQuery(thmNmShowYn).each(function(k) {
		        			if (thmNmShowYn[k].checked) {
			        			dataObj.thmNmShowYn = thmNmShowYn[k].value;
		        			}
		        		});
		        		
		        		themeItems.push(dataObj);
		        		
						
					});
					
					var sendData = {
							themeItemPOList : JSON.stringify(themeItems)
							, exhbtNo : "${so.exhbtNo }"
	 				};
					
					messager.confirm('<spring:message code="column.common.confirm.save" />',function(r){
						if(r){
							saveExhibitionTheme(sendData, "<spring:message code='column.display_view.message.save'/>");					
						}
					});
				}
			}

			function exhibitionThemeDelete() {
				var themeItems = new Array();
				var thmChk = $("input:checkbox[name='thmChk']:checked");
				if(thmChk.length == 0){
					messager.alert("<spring:message code='column.common.delete.no_select' />","Info","info");
					return;
				}
				messager.confirm('<spring:message code="column.common.confirm.delete" />',function(r){
					if(r){
						//APETQA-6292 2021.08.06 수정 kjh02
							$(thmChk).each(function(index,item) {
								var thmInput= $(this).parents("tbody").find(".thmNo");
								var thmNo = thmInput.val();
								
								if( thmNo!=""){ 
									$(this).parents("table")[0].classList.add("delY")
									$(this).parents("table").hide();
							 		}else{
							 			$(this).parents("table").remove();	
							 		} 
						 		})
							};
						}
					)
				}
			
			
			function saveExhibitionTheme(sendData, message) {
				var options = {
					url : "<spring:url value='/promotion/exhibitionThemeSave.do' />"
					, data : sendData
					, callBack : function(result){
						messager.alert(message,"Info","info",function(){
							fnChangeView(20);
// 							closeGoTab("기획전 목록", "/promotion/exhibitionListView.do");
						});
					}
				};

				ajax.call(options);
			}
			
			//기획전 목록으로 이동
			function exhibitionList(){
				closeGoTab("기획전 목록", "/promotion/exhibitionListView.do");
			}
			
		</script>
	</t:putAttribute>
	<t:putAttribute name="content">
		<div class="mTab">
			<ul class="tabMenu">
				<li><a href="javascript:fnChangeView(10)">기본정보</a></li>
				<li class="active"><a href="javascript:fnChangeView(20)">테마정보</a></li>
				<li><a ${not empty exhibitionThemeList ? 'href="javascript:fnChangeView(30)"' : '' }>상품정보</a></li>
			</ul>
		</div>
		
		<div class="mTitle">
			<h2>테마정보</h2>
			<div class="buttonArea">
				<button type="button" name="readonlyBtn" onclick="exhibitionThemeAdd('')" class="btn btn-add">테마추가</button>
				<button type="button" name="readonlyBtn" onclick="exhibitionThemeDelete();" class="btn btn-add">테마삭제</button>
			</div>
		</div>
		
		<div>
			<table class="table_type1">
				<tbody>
					<tr>
						<!-- 테마영역 개수 -->
						<th scope="row"><spring:message code="column.thmCnt" /></th>
						<td colspan="3">
							<spring:message code="column.thmCnt.max" var="thmCntMax"/>
	                        <select name="thmCnt" id="thmCnt" title="<spring:message code="column.thmCnt" />">
                       			<option value="">선택</option>
	                       		<c:forEach begin="1" end="${thmCntMax}" varStatus="status" >
									<option value="${status.count}">${status.count}</option>
	                       		</c:forEach> 
	                        </select>
<%-- 	                         (최대 <spring:message code="column.thmCnt.max" />까지 추가 가능) --%>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
	
		<form id="exhibitionThemeForm" name="exhibitionThemeForm" method="post" >
			<div id="themeDiv" style="margin-top: 20px">
			</div>
		</form>

		<div id="btnDiv" class="btn_area_center" style="display: none;">
			<button type="button" name="readonlyBtn" onclick="exhibitionThemeSave();" class="btn btn-ok">저장</button>
		<c:if test="${not empty exhibitionThemeList}">
			<button type="button" onclick="exhibitionList();" class="btn btn-add"">목록</button>
		</c:if>
		</div>
	</t:putAttribute>
</t:insertDefinition>
