<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>

<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script tyle="text/javascript">
			//보안성검사결과처리. 불필요한 코드 (비어있는 함수) 제거		
			/* $(document).ready(function(){

			}); */
			
			function tagBaseSave() {
				if(validate.check("tagBaseForm")) {
					var check = true;
					var message = '<spring:message code="column.common.confirm.insert" />';
					
					/*신조어에서 사전으로 등록이 아닐때만 수정 메시지 노출*/
					if(!validation.isNull($("#tagBaseForm #tagNo").val()) && "${tagBase.statCd}" != "U"){
						check = false;
						message = '<spring:message code="column.common.confirm.update" />';
					}
					
					var sTags = new Array();
					$(".rltSelectedTag").each(function(i, v){
						sTags.push(v.id.split("_")[1]);
					})
					$("#rltTagNos").val(sTags);
					
					sTags = new Array();
					$(".synSelectedTag").each(function(i, v){
						sTags.push(v.id.split("_")[1]);
					})
					$("#synTagNos").val(sTags);
					
					sTags = new Array();
					$(".grpSelectedTag").each(function(i, v){
						sTags.push(v.id.split("_")[1]);
					})
					$("#tagGrpNos").val(sTags);
					
					//신조어=U, 사전=Y,N
					if("${tagBase.statCd}" == "U"){
						$("#reSaveYn").val("Y");
					}else{
						$("#reSaveYn").val("N");
					}
					
					messager.confirm(message, function(r){
						if(r){
							var options = {
								url : "<spring:url value='/tag/tagBaseUpdate.do' />"
								, data : $("#tagBaseForm").serializeJson()
								, callBack : function(result){
									var finalMsg = "";
									
									//신조어=U, 사전=Y,N
									if("${tagBase.statCd}" != "U"){
										finalMsg = "<spring:message code='column.common.edit.final_msg' />";
									}else{
										finalMsg = "<spring:message code='column.common.regist.final_msg' />";
									}
									
									messager.alert("<spring:message code='column.common.regist.final_msg' />", "Info", "info", function(){
										//viewTagBaseDetail (data.tagNo );
										viewTagList();
									});
								}
							};

							ajax.call(options);
						}
					})
				}
			}

			function tagBaseDelete(tagNo) {
				messager.confirm('<spring:message code="column.common.confirm.delete" />', function(r){
					if(r){
						var options = {
							url : "<spring:url value='/tag/tagBaseDelete.do' />"
							, data : {
								tagNo : tagNo
							}
							, callBack : function(result){
								//$("#menuTree").jstree().refresh();
								viewTagListView();
							}
						};
						ajax.call(options);
					}
				})
			}
			
			// 목록 조회.
			function viewTagListView () {
				var url = "/tag/matchedTagListView.do";
				
				addTab(url);
			}
			
			// Tag 그룹 검색 팝업(tagGb - grp)
			function tagGroupSearchPop (tagGb) {
				 var options = {
					multiselect : true
					, plugins : [ "themes" , "checkbox" ]
					, upDispYn : "Y"
					, callBack : function(result) {
						var check = true;
						if(result != null && result.length > 0) {
							//console.log(result);
							var message = new Array();
							var sTag = $("."+ tagGb + "SelectedTag");
							
							for(var i in result){							

								var addData = {
									tagGrpNo : result[i].tagGrpNo
									, grpNm : result[i].grpNm
									, upGrpNo : result[i].upGrpNo
								}
								
								sTag.each(function(i, v){
									var tagName = $("#"+v.id).attr('tag-nm');
									
									if (tagName == addData.grpNm) {
										check = false;
										return false;
									} else {			
										check = true;									
									}
								})
								
								if(check) {
									if( $("#"+tagGb + "Tags") ) $("#"+tagGb + "Tags").append ("<br/>");
									var html = '<span class="rcorners1 ' + tagGb + 'SelectedTag" tag-nm="' + addData.grpNm +'" id="'+ tagGb + '_' + addData.tagGrpNo + '">' + addData.grpNm + '</span>' 
									+ '<img id="'+ tagGb + '_' + addData.tagGrpNo + 'Delete" onclick="deleteTag(\''+ tagGb + '_' + addData.tagGrpNo +'\')" class="tagDeleteBtn" src="/images/icon-header-close.svg" />';
									$("#"+tagGb + "Tags").append (html);
								} else {
									message.push(result[i].grpNm + " 중복된 Tag 그룹 입니다.");
								}
								
							}
							
							/* if(message != null && message.length > 0) {
								messager.alert(message.join("<br/>"), "Info", "info");
							} */
						}
						
					}
				 }
				 layerTagGroupList.create(options);
			}
			
			// Tag 추가 팝업 : tagGb(동의어 - syn, 유의어 - rlt)
			function tagBaseSearchPop(tagGb) {
				var options = {
					multiselect : true
					, callBack : function(result) {
						var check = true;
						if(result != null && result.length > 0) {

							var message = new Array();
							var sTag = $("."+ tagGb + "SelectedTag");
							
							for(var i in result){							
					
								var addData = {
									tagNo : result[i].tagNo
									, tagNm : result[i].tagNm
								}
								
								// 동의어 - syn, 유의어 - rlt
								sTag.each(function(i, v){
									var tagName = $("#"+v.id).attr('tag-nm');
									
									if (tagName == addData.tagNm) {
										check = false;
										return false;
									} else {			
										check = true;									
									}
								})

								if(check) {
									var html = '<span class="rcorners1 ' + tagGb + 'SelectedTag" tag-nm="' + addData.tagNm +'" id="'+ tagGb + '_' + addData.tagNo + '">' + addData.tagNm + '</span>' 
									+ '<img id="'+ tagGb + '_' + addData.tagNo + 'Delete" onclick="deleteTag(\''+ tagGb + '_' + addData.tagNo +'\')" class="tagDeleteBtn" src="/images/icon-header-close.svg" />';
				
									$("#"+tagGb + "Tags").append (html);
									
								} else {
									message.push(result[i].tagNm + " 중복된 Tag 입니다.");
								}
								
							}
							
							if(message != null && message.length > 0) {
								//messager.alert(message.join("<br/>"), "Info", "info");
								messager.alert("중복선택 된 태그가 있습니다<br/>중복된 태그는 덮어쓰기 합니다.", "Info", "info");
							}
						}
					}
				 }
				layerTagBaseList.create(options);
			}
				
				
			function deleteTag(tagNo) {
				$("#"+ tagNo).remove();
				$("#"+ tagNo + "Delete").remove();
			}	
			
			
			function viewTagList() {
				updateTab('/tag/matchedTagListView.do', 'Tag 사전');
			}
			
			
			// 초기화 버튼클릭
			function searchReset() {
				resetForm ("tagBaseForm");
				location.reload();
			}
			
			// Tag 상세
			function viewTagBaseDetail(tagNo) {
 				var url = "/tag/tagBaseDetailView.do?tagNo=" + tagNo;
				
 				updateTab(url, 'Tag 상세 - ' + tagNo);
			}
		</script>
			
	</t:putAttribute>

	<t:putAttribute name="content">	
		<div id="goods_pannel" class="easyui-accordion" data-options="multiple:true" style="width:100%">			
		<div title="기본 정보" data-options="" style="padding:10px">
			<form name="tagBaseForm" id="tagBaseForm">
			<input type="hidden" id="tagGrpNos" name="tagGrpNos" value="" />
			<input type="hidden" id="synTagNos" name="synTagNos" value="" />
			<input type="hidden" id="rltTagNos" name="rltTagNos" value="" />
			<input type="hidden" id="reSaveYn" name="reSaveYn" value="" />
			<table class="table_type1">
				<caption>태그  상세</caption>
				<tbody>
					<tr>
						<th><spring:message code="column.tag_no"/><strong class="red">*</strong></th>
						<td colspan="3">
							<!-- Tag ID -->
							<input type="text" class="readonly" readonly="readonly" name="tagNo" id="tagNo" title="<spring:message code="column.tag_no"/>" value="${tagBase.tagNo}" />
						</td>
					</tr>
					<tr>
						<th><spring:message code="column.tag_nm" /><strong class="red">*</strong></th>	<!-- Tag 명-->
						<td colspan="3">
							<input type="text" class="readonly" readonly="readonly" name="tagNm" id="tagNm" title="<spring:message code="column.tag_nm" />" value="${tagBase.tagNm}" />
						</td>
					</tr>

					<tr>
						<th><spring:message code="column.tag_grp" /></th>	<!-- 태그 그룹 -->
						<td colspan="3">
							<span id="grpTags">
							<c:forEach items="${tagGroups}" var="tag" varStatus="status">
								<span class="rcorners1 grpSelectedTag" tag-nm="${tag.grpNm }" id="grp_${tag.tagGrpNo }">${tag.grpNm }</span>
								<img id="grp_${tag.tagGrpNo }Delete" onclick="deleteTag('grp_${tag.tagGrpNo}')" class="tagDeleteBtn" src="/images/icon-header-close.svg" />
								<br/>
							</c:forEach>
							</span>
							<button type="button" class="roundBtn" onclick="tagGroupSearchPop('grp');" >+ 추가</button>
						</td>
					</tr>
					<tr>
						<th><spring:message code="column.rlt_tag" /></th>	<!-- 연관어 -->
						<td colspan="3">
							<span id="rltTags">
							<c:forEach items="${rltTags}" var="tag" varStatus="status">
								<span class="rcorners1 rltSelectedTag" tag-nm="${tag.tagNm }" id="rlt_${tag.tagNo }">${tag.tagNm }</span>
								<img id="rlt_${tag.tagNo }Delete" onclick="deleteTag('rlt_${tag.tagNo}')" class="tagDeleteBtn" src="/images/icon-header-close.svg" />
							</c:forEach>
							</span>
							<button type="button" class="roundBtn" onclick="tagBaseSearchPop('rlt');" >+ 추가</button>							
						</td>
					</tr>
					<tr>
						<th><spring:message code="column.syn_tag" /></th>	<!-- 유의어 -->
						<td colspan="3">
							<span id="synTags">
							<c:forEach items="${synTags}" var="tag" varStatus="status">
								<span class="rcorners1 synSelectedTag" tag-nm="${tag.tagNm }" id="syn_${tag.tagNo }">${tag.tagNm }</span>
								<img id="syn_${tag.tagNo }Delete" onclick="deleteTag('syn_${tag.tagNo}')" class="tagDeleteBtn" src="/images/icon-header-close.svg" />
							</c:forEach>
							</span>
							<button type="button" class="roundBtn" onclick="tagBaseSearchPop('syn');" >+ 추가</button>
						</td>
					</tr>
					<tr>
						<th><spring:message code="column.stat_cd" /></th>	<!-- 사용여부 -->
						<td colspan="3">
							<frame:radio name="statCd" grpCd="${adminConstants.TAG_STAT}" selectKey="${tagBase.statCd}" />
						</td>
					</tr>

				<c:if test="${not empty tagBase and tagBase.statCd ne 'U'}"> <%-- statCd=U 이면 신조어다. --%>
					<tr>
						<th><spring:message code="column.sys_regr_nm" /></th>
						<td>
							${tagBase.sysRegrNm}
						</td>
						<th><spring:message code="column.sys_reg_dtm" /></th>
						<td>
							<fmt:formatDate value="${tagBase.sysRegDtm}" pattern="yyyy-MM-dd HH:mm:ss"/>
						</td>
					</tr>
					<tr>
						<th><spring:message code="column.sys_updr_nm" /></th>
						<td>
							${tagBase.sysUpdrNm}
						</td>
						<th><spring:message code="column.sys_upd_dtm" /></th>
						<td>
							<fmt:formatDate value="${tagBase.sysUpdDtm}" pattern="yyyy-MM-dd HH:mm:ss"/>
						</td>
					</tr>
				</c:if>
				</tbody>
			</table>
			</form>
		</div>	
	</div>
			<div class="btn_area_center">
			<c:if test="${tagBase.statCd ne 'U' }">
			<button type="button" class="btn btn-ok" onclick="tagBaseSave();">저장</button>
			</c:if>
			<c:if test="${tagBase.statCd eq 'U' }">
			<button type="button" class="btn btn-ok" onclick="tagBaseSave();">등록</button>
			</c:if>
			<button type="button" class="btn btn-cancel" onclick="searchReset();">초기화</button>		
			<button type="button" class="btn btn-cancel" onclick="viewTagList();">취소</button>
			</div>

	</t:putAttribute>
</t:insertDefinition>				