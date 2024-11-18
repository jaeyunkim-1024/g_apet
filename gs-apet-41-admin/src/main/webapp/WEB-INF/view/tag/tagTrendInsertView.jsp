<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>

<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">
		$(document).ready(function(){
			
			$("#trdTagNm").keyup(function(e) {
				if (this.value.length == this.maxLength){
					return;
				}
			});
		});
		
		// Tag 등록
		function insertTagTrend () {
			var sendData = null;
			
			// 사용 기간 셋팅
			$("#useStrtDtm").val(getDateStr ("useStrt"));
			$("#useEndDtm").val(getDateStr ("useEnd"));
			
			var sTags = new Array();
			$(".trdSelectedTag").each(function(i, v){
				sTags.push(v.id.split("_")[1]);
			})
			$("#tagNos").val(sTags);
			
			if ($("#useStrtDt").val() > $("#useEndDt").val()){
				messager.alert("기간 시작일은 종료일과 같거나 이전이여야 합니다","Info","info",function(){
				$("#useStrtDt").focus();
				});
				return false;
			};

			if(validate.check("tagTrendForm")) {
				var formData = $("#tagTrendForm").serializeJson();
				
				if(!$("#tagNos").val() || $("#tagNos").val()==""){
					//$("#trdTags").append ("필수입력~");
					alert("추가된 Tag 가 없습니다.");
					return false;
				}
				
				// Form 데이터
				sendData = {
					tagTrendPO : JSON.stringify(formData )
				}

				messager.confirm("<spring:message code='column.common.confirm.insert' />",function(r){
					if(r){
						var options = {
								url : "<spring:url value='/tag/tagTrendInsert.do' />"
								, data : formData
								, callBack : function (data ) {
									messager.alert("<spring:message code='column.common.regist.final_msg' />","Info","info",function(){
										viewTagTrendList();
									});									
								}
							};
							ajax.call(options);				
					}
				});
			}
		}

		function viewTagTrendDetail (trdNo ) {
			updateTab('/tag/tagBaseDetailView.do?trdNo=' + trdNo, 'Trend Tag 상세');
		}
		
		
		function viewTagTrendList ( ) {
			updateTab('/tag/trendTagListView.do', 'Trend Tag List');
		}
		
		
		function updateTag(){
			var sTag = $(".selectedTag");
			var sTags = new Array();
			sTag.each(function(i, v){
				sTags.push(v.id);
			})
			$("#sTags").val(sTags);
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
							
							//alert(addData.tagNm);
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
							messager.alert(message.join("<br/>"), "Info", "info");
						}
					}
				}
			 }
			layerTagBaseList.create(options);
		}
		
		
		function searchBrandCallback (brandList ) {
			if(brandList != null && brandList.length > 0 ) {
				$("#bndNo").val (brandList[0].bndNo );
				$("#bndNm").val (brandList[0].bndNmKo );
			}
		}
		
		
		function deleteTag(tagNo) {
			$("#"+ tagNo).remove();
			$("#"+ tagNo + "Delete").remove();
		}	
		
		// 초기화 버튼클릭
		function searchReset () {
			resetForm ("tagTrendForm");
			$("#trdTags").html("");
		}

		</script>
	</t:putAttribute>

	<t:putAttribute name="content">
<form id="tagTrendForm" name="tagTrendForm" method="post" >
	<input type="hidden" id="useStrtDtm" name="useStrtDtm" class="validate[required]" value="" />
	<input type="hidden" id="useEndDtm" name="useEndDtm" class="validate[required]" value="" />
	<input type="hidden" id="tagNos" name="tagNos" class="validate[required]" value="" />
	<table class="table_type1">
		<caption>Trend 태그 등록</caption>
		<tbody>
			<tr>
				<th scope="row">Trend Tag ID<strong class="red">*</strong></th> <!-- T Tag ID-->
				<td>
					<b>자동입력</b>					
				</td>				
			</tr>
			<tr>
				<th>Trend Tag 명<strong class="red">*</strong></th>	<!-- T Tag 명 -->
				<td>
					<input type="text" name="trdTagNm" id="trdTagNm" maxlength="20" title="Trend Tag 명" class="validate[required]" value="" />
				</td>
			</tr>
			<tr>
				<th><spring:message code="column.tag_nm" /><strong class="red">*</strong></th>	<!-- 태그 명 -->
				<td>
					<span id="trdTags">							
					</span>
					<button type="button" class="btn" onclick="tagBaseSearchPop('trd');" >+ 추가</button>
				</td>
			</tr>
			<tr>
				<th><spring:message code="column.stat_cd" /></th>	<!-- 상태 -->
				<td>
					<frame:radio name="useYn" grpCd="${adminConstants.USE_YN}" selectKey="${tagTrend.useYn}" />
				</td>
			</tr>
			<tr>
				<th>사용 기간</th>	<!-- 사용 기간 -->
				<td>
					<frame:datepicker startDate="useStrtDt"
									  startHour="useStrtHr"
									  startMin="useStrtMn"
									  startSec="useStrtSec"
									  startValue="${tagTrend.useStrtDtm }"
									  endDate="useEndDt"
									  endHour="useEndHr"
									  endMin="useEndMn"
									  endSec="useEndSec"
									  endValue="${tagTrend.useEndDtm }"
									  />
				</td>
			</tr>
		</tbody>
	</table>
	<hr />	
	
	</div>
	
		<div class="btn_area_center">
			<button type="button" class="btn btn-ok" onclick="insertTagTrend(); return false;" >등록</button>
			<button type="button" class="btn btn-cancel" onclick="searchReset();">초기화</button>
			<button type="button" class="btn btn-cancel" onclick="viewTagTrendList();">취소</button>			
		</div>

</form>
	</t:putAttribute>

</t:insertDefinition>