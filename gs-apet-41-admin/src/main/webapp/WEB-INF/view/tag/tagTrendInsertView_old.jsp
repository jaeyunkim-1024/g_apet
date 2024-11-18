<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>

<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">
		$(document).ready(function(){
			
		});
		
		// Tag 등록
		function insertTagTrend () {
			var sendData = null;
			
			// 사용 기간 셋팅
			$("#useStrtDtm").val(getDateStr ("useStrt"));
			$("#useEndDtm").val(getDateStr ("useEnd"));

			if(validate.check("tagTrendForm")) {
				var formData = $("#tagTrendForm").serializeJson();
				
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
		
		// Tag 추가 팝업
		function tagBaseSearchPop() {
			var options = {
				multiselect : true
				//, upDispYn : "Y"
				, callBack : function(result) {
					var tagNm = $('#tagNm').val();
					var tagArea =  $('#tagArea').val();
					var tagAreaArray = new Array();
					//if(tagArea) tagAreaArray = tagArea.split(",");
					if(tagNm) tagAreaArray = tagNm.split("\n");
					
					if(result != null && result.length > 0) {
						//console.log(result);
						var message = new Array();
						for(var i in result){							
							tagNm = $('#tagNm').val();
							tagArea =  $('#tagArea').val();
							
							var addData = {
								tagNo : result[i].tagNo
								, tagNm : result[i].tagNm
								//, grpNm : result[i].grpNm
							}
							

							var check = true;
							for (var si in tagAreaArray) {								
								//if (tagAreaArray[si] == addData.tagNo) {
								if (tagAreaArray[si] == addData.tagNm) {
									check = false;
									break;
								} else {						
									check = true;									
								}
							}
							if(check) {
								//alert(tagGrpAreaArray[si] +"!=" +addData.tagGrpNo);
								if(tagArea){
									tagArea = tagArea + ","; 
								}
								if(tagNm){
									tagNm = tagNm + "\r\n"; 
								}
								//alert(addData.tagNo);
								$('#tagArea').val(tagArea + addData.tagNo);
								//var grpNm = addData.grpNm;
								// $("<a href=\"javascript:void(0)\" class=\"tabs-close\"></a>").appendTo(grpNm);

								$('#tagNm').val(tagNm + addData.tagNm);
								
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

		</script>
	</t:putAttribute>

	<t:putAttribute name="content">
<form id="tagTrendForm" name="tagTrendForm" method="post" >
	<input type="hidden" id="useStrtDtm" name="useStrtDtm" class="validate[required]" value="" />
	<input type="hidden" id="useEndDtm" name="useEndDtm" class="validate[required]" value="" />
	<input type="hidden" id="tagArea" name="tagArea" " value=""/>
	<table class="table_type1">
		<caption>Trend 태그 등록</caption>
		<tbody>
			<tr>
				<th scope="row">Trend Tag ID<strong class="red">*</strong></th> <!-- T Tag ID-->
				<td>
					<c:if test="${empty tagTrend}"> <!-- Tag ID-->
						<b>자동입력</b>
					</c:if>
					<c:if test="${not empty tagTrend}"> <!-- Tag ID-->
						<input type="text" name="trdNo" id="trdNo" title="T Tag ID" value="${tagTrend.trdNo}" />
					</c:if>
				</td>				
			</tr>
			<tr>
				<th>Trend Tag 명<strong class="red">*</strong></th>	<!-- T Tag 명 -->
				<td>
					<input type="text" name="trdTagNm" id="trdTagNm" title="Trend Tag 명" class="validate[required]" value="${tagTrend.trdTagNm}" />
				</td>
				
				
				
				<td colspan="3">
						<span id="tags">
							<c:forEach items="${tags}" var="tag" varStatus="status">
								<span class="rcorners1 selectedTag" tag-no="${tag.tagNo }" id="${tag.tagNo }">${tag.tagNm }</span>
								<img id="${tag.tagNo }Delete" onclick="deleteTag('${tag.tagNo}')" class="tagDeleteBtn" src="/images/icon-header-close.svg" />
							</c:forEach>
						</span>
						<button type="button" class="roundBtn" onclick="addTag();" >+ 추가</button>
						
					</td>
				
				
			</tr>
<%-- 			<tr>
				<th><spring:message code="column.tag_no" /></th>	<!-- 태그 번호 -->
				<td>
					<input type="text" id="tagArea" name="tagArea" title="<spring:message code="column.tag_no" />" value="" readonly class="readonly"/>
				</td>
			</tr> --%>			
			<tr>
				<th><spring:message code="column.tag_nm" /><strong class="red">*</strong></th>	<!-- 태그 명 -->
				<td>
					<textarea rows="10" cols="150" id="tagNm" name="tagNm" readonly class="readonly"></textarea>
					<button type="button" class="btn" onclick="tagBaseSearchPop(); return false;">검색</button>
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
			<button type="button" class="btn btn-cancel" onclick="closeTab();">취소</button>
		</div>
		
		
<!-- 		<div class="tree-menu" style="border-top:none;"> -->
<!-- 				<div class="gridTree" id="menuTree" style="height:700px;"></div> -->
<!-- 			</div> -->

</form>
	</t:putAttribute>

</t:insertDefinition>