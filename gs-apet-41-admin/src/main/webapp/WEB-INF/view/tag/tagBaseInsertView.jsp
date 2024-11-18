<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>

<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">
		$(document).ready(function(){
			
			$("#tagNm").keydown(function(event) {
				if(event.keyCode == 13 || event.keyCode == 32) {
					$('#regist').click();
					return false;
				}
			});
			
			$("#tagNm").keyup(function(e) {
				//10자 글자수 체크
				if (this.value.length === this.maxLength){
					return;
				}
				tagDupCheck = false;
			});
		});
		
		// Tag 등록
		function insertTagBase () {
			var sendData = null;
			
			// Unmatched 인 경우, 출처코드는 수동(M)으로 등록.		
			var statCd = $("input[name='statCd']:checked").val();
			if( statCd == "U" ) $("#srcCd").val("M");
			
			if(validate.check("tagBaseForm")) {				
				
				if(!tagDupCheck){
					$("#tagNm").validationEngine('showPrompt', 'Tag Name 중복체크 해주세요.', 'error', true);
					
					messager.alert("Tag Name 중복체크 해주세요.", "info", "info", function(r){
						$("#tagNmChk").focus();
					});
					return;
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
				
				
				
				
				var formData = $("#tagBaseForm").serializeJson();
				
				// Form 데이터
				sendData = {
					tagBasePO : JSON.stringify(formData )
				}

				messager.confirm("<spring:message code='column.common.confirm.insert' />",function(r){
					if(r){
						var options = {
							url : "<spring:url value='/tag/tagBaseInsert.do' />"
							, data : formData
							, callBack : function (data ) {
								messager.alert("<spring:message code='column.common.regist.final_msg' />","Info","info",function(){
									//viewTagBaseDetail (data.tagNo );
									viewTagList(statCd);
								});									
							}
						};
						ajax.call(options);				
					}
				});
			}
		}

		// Tag 상세
		function viewTagBaseDetail (tagNo ) {
			updateTab('/tag/tagBaseDetailView.do?tagNo=' + tagNo, 'Tag 상세');
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
							});
							
							if(check) {
								var html = '';
								if ($("span[id^='grp_']").length > 0) {
									html += '<br id="'+ tagGb + '_' + addData.tagGrpNo + 'Br"/>';
								}
								
								html += '<span class="rcorners1 ' + tagGb + 'SelectedTag" tag-nm="' + addData.grpNm +'" id="'+ tagGb + '_' + addData.tagGrpNo + '">' + addData.grpNm + '</span>' 
								+ '<img id="'+ tagGb + '_' + addData.tagGrpNo + 'Delete" onclick="layerTagBaseList.deleteTag(\''+ tagGb + '_' + addData.tagGrpNo +'\')" class="tagDeleteBtn" src="/images/icon-header-close.svg" />';
								
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
							});

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
		
		function viewTagList (statCd) {
			if( statCd == "U" ) updateTab('/tag/unmatchedTagListView.do', 'Tag 신조어');
			else updateTab('/tag/matchedTagListView.do', 'Tag 사전');
		}
		
		
		// 초기화 버튼클릭
		function searchReset () {
			resetForm ("tagBaseForm");
			$("#tagNm").validationEngine("hide");
			$("#grpTags").html("");		
			$("#rltTags").html("");			
			$("#synTags").html("");
		}

		var tagDupCheck = false;
		
		//Tag 명 중복체크
		function tagNmCheck() {
						
 			if($("#tagNm").val() != null || $("#tagNm").val() != '') {
				
				// 특수문자 체크  태그 입력 제한 : @, &, <, >, ‘,',"
				var ptnSpclChar = /[@&<>‘'"]/; // 특수문자
				if ( ptnSpclChar.test( $("#tagNm").val() ) ) {
					messager.alert("특수문자(@, &, <, >, ‘, ', \")는 입력이  불가합니다.", "info", "info", function(r){
						$("#tagNm").focus();
					});
					
					return;
				}
			}
			
			if($("#tagNm").val() === null || $("#tagNm").val() === '') {
				messager.alert("Tag Name을 입력해주세요...", "info", "info", function(r){
					$("#tagNm").focus();
				});
				return;
			}
			var options = {
					url : "<spring:url value='/tag/tagNmCheck.do' />"
					, data : {
						tagNm : $("#tagNm").val()
					}
					, callBack : function(result) {
						if(result) {
							tagDupCheck = false;
							$('#tagNm').validationEngine('showPrompt', '중복된  Tag 이므로 사용불가합니다.', 'error', true);
						} else {
							tagDupCheck = true;
							$('#tagNm').validationEngine('showPrompt', '사용가능한 Tag 입니다.', 'pass', true);
						}
					}
			};
			ajax.call(options);
		}
		
		
		</script>
	</t:putAttribute>

	<t:putAttribute name="content">
<form id="tagBaseForm" name="tagBaseForm" method="post" >
	<input type="hidden" id="srcCd" name="srcCd" value="" />
	<input type="hidden" id="tagGrpNos" name="tagGrpNos" value="" />
	<input type="hidden" id="synTagNos" name="synTagNos" value="" />
	<input type="hidden" id="rltTagNos" name="rltTagNos" value="" />
	<input type="hidden" id="statCd" name="statCd" value="${adminConstants.TAG_STAT_Y}" />		
	<table class="table_type1">
		<caption>태그 등록</caption>
		<tbody>
			<tr>
				<th scope="row"><spring:message code="column.tag_no" /><strong class="red">*</strong></th> <!-- Tag ID-->
				<td>
					<c:if test="${empty tagBase}"> <!-- Tag ID-->
						<b>자동입력</b>
					</c:if>
					<c:if test="${not empty tagBase}"> <!-- Tag ID-->
						<input type="text" class="readonly" readonly="readonly" name="tagNo" id="tagNo" title="<spring:message code="column.tag_no"/>" value="${tagBase.tagNo}" />
					</c:if>
				</td>				
			</tr>
			<tr>
				<th><spring:message code="column.tag_nm" /><strong class="red">*</strong></th>	<!-- Tag 명-->
				<td>
					<input type="text" class="w300 validate[required, maxSizeNonUtf8[20]]" name="tagNm" id="tagNm"  maxlength="20" title="<spring:message code="column.tag_nm"/>" value="${tagBase.tagNm}" />
					<button type="button" onclick="tagNmCheck();" class="btn btn-add">중복체크</button>			
				</td>
			</tr>
			<tr>
				<th><spring:message code="column.tag_grp" /></th>	<!-- 태그 그룹 -->
				<td>
					<span id="grpTags">							
					</span>
					<button type="button" class="btn" onclick="tagGroupSearchPop('grp');">+추가</button>
				</td>
			</tr>
			<tr>
				<th><spring:message code="column.syn_tag" /></th>	<!-- 유의어 -->
				<td>
					<span id="synTags">							
					</span>
					<button type="button" class="btn" onclick="tagBaseSearchPop('syn');">+추가</button>
				</td>
			</tr>
			<tr>
				<th><spring:message code="column.rlt_tag" /></th>	<!-- 연관어 -->
				<td>
					<span id="rltTags">							
					</span>
					<button type="button" class="btn" onclick="tagBaseSearchPop('rlt');">+추가</button>
				</td>
			</tr>
<%--			<tr>
				<th><spring:message code="column.stat_cd" /></th>	<!-- 상태 -->
				<td>
 					<frame:radio name="statCd" grpCd="${adminConstants.TAG_STAT}" selectKey="${tagBase.statCd}" />
				</td>
			</tr>
 --%>			
		</tbody>
	</table>
	<hr />	
	
	</div>
	
		<div class="btn_area_center">
			<button type="button" class="btn btn-ok" onclick="insertTagBase();" id="regist" >등록</button>
			<button type="button" class="btn btn-cancel" onclick="searchReset();">초기화</button>
			<button type="button" class="btn btn-cancel" onclick="viewTagList();">취소</button>
		</div>

</form>
	</t:putAttribute>

</t:insertDefinition>