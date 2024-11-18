<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
			
		<script tyle="text/javascript">			
 			var tagBase = { 
 				/* 수정 */ 
 				tagBaseSave : function(){ 
 					if(validate.check("tagBaseForm")) { 
 						var check = true; 
						var message = '<spring:message code="column.common.confirm.insert" />';

 						if(!validation.isNull($("#tagBaseForm #tagNo").val())){ 
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
						
 						messager.confirm(message, function(r){ 
 							if(r){ 
 								var options = { 
									url : "<spring:url value='/tag/tagBaseUpdate.do' />"
 									, data : $("#tagBaseForm").serializeJson() 
 									, callBack : function(result){ 
										messager.alert("<spring:message code='column.common.edit.final_msg' />","Info","info");
										layer.close("tagBaseDetail");
										searchTagBaseList('');
 									} 
 								}; 

 								ajax.call(options); 
 							} 
 						}) 
 					}
 				} 
 				,viewTagListView : function(){ 
 					var url = "/tag/matchedTagListView.do"; 
					
 					addTab(url); 
 				} 
 				// Tag 추가 팝업 : tagGb(동의어 - syn, 유의어 - rlt) 
 				, tagBaseSearchPop : function(tagGb) { 
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
 										+ '<img id="'+ tagGb + '_' + addData.tagNo + 'Delete" onclick="tagBase.deleteTag(\''+ tagGb + '_' + addData.tagNo +'\')" class="tagDeleteBtn" src="/images/icon-header-close.svg" />'; 
					
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
 				// Tag 그룹 검색 팝업(tagGb - grp) 
 				, tagGroupSearchPop : function(tagGb) { 
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
 										//if( $("#"+tagGb + "Tags") ) $("#"+tagGb + "Tags").append ("<br/>");
 										var html = '';
										if ($("span[id^='grp_']").length > 0) {
											html += '<br id="'+ tagGb + '_' + addData.tagGrpNo + 'Br"/>';
										}
 										html += '<span class="rcorners1 ' + tagGb + 'SelectedTag" tag-nm="' + addData.grpNm +'" id="'+ tagGb + '_' + addData.tagGrpNo + '">' + addData.grpNm + '</span>'  
 										+ '<img id="'+ tagGb + '_' + addData.tagGrpNo + 'Delete" onclick="tagBase.deleteTag(\''+ tagGb + '_' + addData.tagGrpNo +'\')" class="tagDeleteBtn" src="/images/icon-header-close.svg" />';
 										
 										$("#"+tagGb + "Tags").append (html); 
 									} else { 
 										message.push(result[i].grpNm + " 중복된 Tag 그룹 입니다."); 
 									} 
 								} 
 								
 								/*if(message != null && message.length > 0) { 
 									messager.alert(message.join("<br/>"), "Info", "info"); 
 								}*/
 							} 
							
 						} 
 					 } 
 					 layerTagGroupList.create(options); 
 				} 
 				, deleteTag : function(tagNo) {
					let firId = $("span[id^='grp_']")[0].id;
					$("#"+ tagNo).remove();
					if (firId == tagNo) {
						$("#"+ tagNo + "Delete").next("br").remove();
					}

					$("#"+ tagNo).remove();
					$("#"+ tagNo + "Delete").remove();
					$("#"+ tagNo + "Br").remove();
 				}	 
 				, viewTagList : function() { 
 					updateTab('/tag/matchedTagListView.do', 'Tag 사전'); 
 				} 
 				, searchReset : function() { 
 					resetForm ("tagBaseForm"); 
					var options = {
						tagNo : $("#tagBaseForm #tagNo").val()					
					}
					layerTagBaseDetail.create(options);
 				}
 			};
			
 		</script> 

			<form name="tagBaseForm" id="tagBaseForm">
			<input type="hidden" id="tagGrpNos" name="tagGrpNos" value="" />
			<input type="hidden" id="synTagNos" name="synTagNos" value="" />
			<input type="hidden" id="rltTagNos" name="rltTagNos" value="" />				
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
								<c:if test="${status.first eq false }">
								<br id="grp_${tag.tagGrpNo }Br" />
								</c:if>
								<span class="rcorners1 grpSelectedTag" tag-nm="${tag.grpNm }" id="grp_${tag.tagGrpNo }">${tag.grpNm }</span>
								<img id="grp_${tag.tagGrpNo }Delete" onclick="tagBase.deleteTag('grp_${tag.tagGrpNo}')" class="tagDeleteBtn" src="/images/icon-header-close.svg" />
							</c:forEach>
							</span>
							<button type="button" class="roundBtn" onclick="tagBase.tagGroupSearchPop('grp');" >+ 추가</button>
						</td>
					</tr>
					<tr>
						<th><spring:message code="column.syn_tag" /></th>	<!-- 유의어 -->
						<td colspan="3">
							<span id="synTags">
							<c:forEach items="${synTags}" var="tag" varStatus="status">
								<span class="rcorners1 synSelectedTag" tag-nm="${tag.tagNm }" id="syn_${tag.tagNo }">${tag.tagNm }</span>
								<img id="syn_${tag.tagNo }Delete" onclick="tagBase.deleteTag('syn_${tag.tagNo}')" class="tagDeleteBtn" src="/images/icon-header-close.svg" />
							</c:forEach>
							</span>
							<button type="button" class="roundBtn" onclick="tagBase.tagBaseSearchPop('syn');" >+ 추가</button>
						</td>
					</tr>
					<tr>
						<th><spring:message code="column.rlt_tag" /></th>	<!-- 연관어 -->
						<td colspan="3">
							<span id="rltTags">
							<c:forEach items="${rltTags}" var="tag" varStatus="status">
								<span class="rcorners1 rltSelectedTag" tag-nm="${tag.tagNm }" id="rlt_${tag.tagNo }">${tag.tagNm }</span>
								<img id="rlt_${tag.tagNo }Delete" onclick="tagBase.deleteTag('rlt_${tag.tagNo}')" class="tagDeleteBtn" src="/images/icon-header-close.svg" />
							</c:forEach>
							</span>
							<button type="button" class="roundBtn" onclick="tagBase.tagBaseSearchPop('rlt');" >+ 추가</button>							
						</td>
					</tr>
					<tr>
						<th><spring:message code="column.stat_cd" /></th>	<!-- 사용여부 -->
						<td colspan="3">
							<frame:radio name="statCd" grpCd="${adminConstants.TAG_STAT}" selectKey="${tagBase.statCd}" />
						</td>
					</tr>

				<c:if test="${not empty tagBase}">
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

			<div class="btn_area_center">
			<button type="button" class="btn btn-ok" onclick="tagBase.tagBaseSave();">저장</button>
<!-- 			<button type="button" class="btn btn-cancel" onclick="tagBase.viewTagList();">취소</button> -->
			<button type="button" class="btn btn-cancel" onclick="tagBase.searchReset();">초기화</button>			
			</div>
