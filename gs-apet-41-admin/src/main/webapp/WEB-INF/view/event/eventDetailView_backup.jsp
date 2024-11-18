<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>

<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">

		var deleteImageYn_1 = false ;

		$(document).ready(function() {

			initEditor ();

			createEventQuestionGrid ();
			eventLetterGrid ();
		});

		function initEditor () {
			EditorCommon.setSEditor('content', '${adminConstants.EVENT_IMAGE_PATH}');
		}

		function createEventQuestionGrid () {
			var eventNo = '${eventBase.eventNo }';
			var options = {
				url : "<spring:url value='/event/eventQuestionGrid.do' />"
				, searchParam : {eventNo : eventNo }
				, paging : false
				, height : 300
				, colModels : [
					{name:"eventNo", label:'<spring:message code="column.event_no" />', width:"200", align:"center", hidden:true, sortable:false }
					, {name:"qstNo", label:'<b><u><tt><spring:message code="column.qst_no" /></tt></u></b>', width:"80", align:"center", key: true, sortable:false, classes:'pointer fontbold' }
					, {name:"qstNm", label:'<spring:message code="column.qst_nm" />', width:"400", align:"center", sortable:false }
					, {name:"qstImgPath", label:'', width:"0", align:"center", hidden:true, sortable:false }
					, {name:"qstImgPathView", label:'<spring:message code="column.dlgt_img" />', width:"100", align:"center", sortable:false, formatter: function(cellvalue, options, rowObject) {
						if(rowObject.qstImgPath != "") {
							return '<img style="width:50px; height:50px;" src="<frame:imgUrl />' + rowObject.qstImgPath + '">';
						}
					}}
				]
				, onCellSelect : function (id, cellidx, cellvalue) {
					getQuestion(id );
				}
			};
			grid.create("eventQuestionList", options);
		}

		function eventLetterGrid () {
			var eventNo = '${eventBase.eventNo }';
			var options = {
				url : "<spring:url value='/event/eventLetterGrid.do' />"
				, searchParam : {eventNo : eventNo }
				, paging : true
				, height : 300
				, colModels : [
					 {name:"eventNo", label:'<spring:message code="column.event_no" />', width:"200", align:"center", hidden:true, sortable:false }
					<c:if test="${eventBase.eventGbCd eq adminConstants.EVENT_GB_50 }" >
					 ,{name:"rowIndex", label:"순번", width:"100", align:"center",sortable:false }
					</c:if>
					<c:if test="${eventBase.eventGbCd ne adminConstants.EVENT_GB_50 }" >
					, {name:"lettNo", label:'<spring:message code="column.lett_no" />', width:"100", align:"center", key: true, sortable:false }
					</c:if>
					, {name:"loginId", label:'<spring:message code="column.login_id" />', width:"150", align:"center"}
					<c:if test="${eventBase.eventGbCd ne adminConstants.EVENT_GB_20 and eventBase.eventGbCd ne adminConstants.EVENT_GB_50 }" >
					, {name:"content", label:'<spring:message code="column.content" />', width:"500", align:"center", key: true, sortable:false }
					</c:if>
					<c:if test="${eventBase.eventGbCd eq adminConstants.EVENT_GB_50 }" >
					, {name:"mbrNo", label:'<spring:message code="column.mbr_no" />', width:"100", align:"center", key: true, sortable:false }
					</c:if>
					<c:if test="${eventBase.eventGbCd ne adminConstants.EVENT_GB_10  and eventBase.eventGbCd ne adminConstants.EVENT_GB_50 } }" >
					, {name:"qstNo", label:'<spring:message code="column.qst_no" />', width:"100", align:"center", sortable:false }
					, {name:"qstNm", label:'<spring:message code="column.qst_nm" />', width:"200", align:"center", sortable:false }
					, {name:"qstImgPath", label:'<spring:message code="column.dlgt_img" />', width:"100", align:"center", sortable:false, formatter: function(cellvalue, options, rowObject) {
						if(rowObject.qstImgPath != "") {
							return '<img style="width:30px; height:30px;" src="<frame:imgUrl />' + rowObject.qstImgPath + '">';
						}
					}}
					</c:if>
					, {name:"sysRegDtm", label:"<spring:message code='column.sys_reg_dtm' />", width:"200", align:"center", formatter:gridFormat.date, dateformat:"${adminConstants.COMMON_DATE_FORMAT }" }
					, {name:"mbrNm", label:'<spring:message code="column.mbr_nm" />', width:"150", align:"center"}
					<c:if test="${eventBase.eventGbCd ne adminConstants.EVENT_GB_50 }" >
					, {name:"prclAddr", label:'<spring:message code="column.prcl_addr" />', width:"200", align:"center"}
					, {name:"prclDtlAddr", label:'<spring:message code="column.prcl_dtl_addr" />', width:"200", align:"center"}
					, {name:"roadAddr", label:'<spring:message code="column.road_addr" />', width:"200", align:"center"}
					, {name:"roadDtlAddr", label:'<spring:message code="column.road_dtl_addr" />', width:"200", align:"center"}
					</c:if>
					, {name:"email", label:'<spring:message code="column.email" />', width:"200", align:"center"}
					, {name:"tel", label:'<spring:message code="column.tel" />', width:"150", align:"center"}
					, {name:"mobile", label:'<spring:message code="column.mobile" />', width:"150", align:"center"}
					, {name:"joinDtm", label:"<spring:message code='column.join_dtm' />", width:"200", align:"center", formatter:gridFormat.date, dateformat:"${adminConstants.COMMON_DATE_FORMAT }" }
				]
			};
			grid.create("eventLetterList", options);
		}

		function deleteGridRow (id ) {
			var grid = $("#" + id );
			var rowids = grid.jqGrid('getGridParam', 'selarrrow');
			for (var i = rowids.length - 1; i >= 0; i--) {
				grid.jqGrid('delRowData', rowids[i]);
			}
		}

		function updateEvent () {
			var sendData = null;
			// 날짜..
			$("#dispStrtDtm").val(getDateStr ("dispStrt"));
			$("#dispEndDtm").val(getDateStr ("dispEnd"));
			if(validate.check("eventUpdateForm")) {
				oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
				var eventGbCd = $("#eventGbCd").val();

				var dlgtImgPath = $("#dlgtImgPath").val();
				if(  eventGbCd != "${adminConstants.EVENT_GB_40 }" ){

					if(deleteImageYn_1 && dlgtImgPath == "" ) {
						messager.alert("<spring:message code='column.dlgt_img_regist' />","Info","info",function(){
							$("#fileUploadBtn").focus();
						});
						return;
					}
				}else{

					if( $('#content').val().replace(/<img /gi, "img ").replace(/(<([^>]+)>)/gi, "").replace(/&nbsp;/gi, "").trim() == "" ) {	// 공백일 경우
						messager.alert("<spring:message code='column.content_regist' />","Info","info");
						return false;
					}
				}

				if(eventGbCd != "${adminConstants.EVENT_GB_10 }" &&  eventGbCd != "${adminConstants.EVENT_GB_40 }" && eventGbCd != "${adminConstants.EVENT_GB_50 }" ) {
					var eventQuestionGrid = $("#eventQuestionList");
					var rowIds = eventQuestionGrid.jqGrid("getDataIDs");
					if(rowIds.length <= 0 ) {
						messager.alert("<spring:message code='column.event_question_regist' />","Info","info");
						return;
					}
					if(rowIds.length < 2 ) {
						messager.alert("<spring:message code='column.event_question_qty2_regist' />","Info","info");
						return;
					}
				}



				var formData = $("#eventUpdateForm").serializeJson();

				// Form 데이터
				//sendData = {
				//	eventBasePO : JSON.stringify(formData )
				//}
				
				messager.confirm("<spring:message code='column.common.confirm.update' />",function(r){
					if(r){
						var options = {
								url : "<spring:url value='/event/eventUpdate.do' />"
								, data : formData
								, callBack : function (data ) {
									messager.alert("<spring:message code='column.common.edit.final_msg' />","Info","info",function(){
										updateTab();
									});
								}
							};
							ajax.call(options);					
					}
				});
			}
		}

		// 이미지 업로드
		function resultImage (file, objId ) {
			$("#" + objId).val(file.filePath);
			$("#" + objId + "View").html("<img width=\"95%\" src=\"/common/imageView.do?filePath="+ file.filePath + "\">");
			$("#" + objId + "Del").val("");
		}

		function deleteImage (objId, imgGb, eventNo, qstNo ) {
			$("#" + objId).val("");
			$("#" + objId + "View").html("");
			$("#" + objId + "Del").val("${adminConstants.COMM_YN_Y }");

			if(objId == 'dlgtImgPath'){
				deleteImageYn_1 = true ;
			}

		}

		function getQuestion (qstNo ) {
			var config = {
				url : "<spring:url value='/event/eventQuestDetailView.do' />"
				, data : { qstNo : qstNo }
				, dataType : "html"
				, callBack : function (data ) {
					$("#eventQuestionView").html ('');
					$("#eventQuestionView").append (data );
				}
			};
			ajax.call(config );
		}

		// 삭제
		function deleteQuestion (qstNo ) {
			messager.confirm("<spring:message code='column.common.confirm.delete' />",function(r){
				if(r){
					var options = {
							url : "<spring:url value='/event/eventQuestionDelete.do' />"
							, data : {qstNo : qstNo }
							, callBack : function (data ) {
								messager.alert("<spring:message code='column.common.delete.final_msg' arguments='1' />","Info","info",function(){
									reloadEventQuestionList ();
									getQuestion (0 );
								});								
							}
						};
						ajax.call(options);				
				}
			});
		}

		// 수정
		function updateQuestion (qstNo ) {
			var qstImgPathDel = $("#qstImgPathDel").val();
			var qstImgPath = $("#qstImgPath").val();
			// 이미지 초기화후 등록하지 않음
			if(qstImgPathDel == "${adminConstants.COMM_YN_Y }" && qstImgPath == "" ) {
				messager.alert("<spring:message code='column.img_regist' />","Info","info");
				return;
			}

			messager.confirm("<spring:message code='column.common.confirm.update' />",function(r){
				if(r){
					var options = {
							url : "<spring:url value='/event/eventQuestionUpdate.do' />"
							, data : $("#eventQuestionForm").serializeJson()
							, callBack : function (data ) {
								messager.alert("<spring:message code='column.common.edit.final_msg' />","Info","info",function(){
									reloadEventQuestionList ();
									getQuestion (qstNo );
								});
							}
						};
						ajax.call(options);				
				}
			});
		}

		// 등록
		function insertQuestion () {
			var qstImgPath = $("#qstImgPath").val();
			// 이미지 초기화후 등록하지 않음
			if(qstImgPath == "" ) {
				messager.alert("<spring:message code='column.img_regist' />","Info","info");
				return;
			}

			messager.confirm("<spring:message code='column.common.confirm.insert' />",function(r){
				if(r){
					$("#eventQuestionForm #eventNo").val('${eventBase.eventNo }');
					var options = {
						url : "<spring:url value='/event/eventQuestionInsert.do' />"
						, data : $("#eventQuestionForm").serializeJson()
						, callBack : function (data ) {
							messager.alert("<spring:message code='column.common.regist.final_msg' />","Info","info",function(){
								reloadEventQuestionList ();
								getQuestion (data.qstNo );
							});
						}
					};
					ajax.call(options);				
				}
			});
		}

		// 초기화
		function resetQuestion () {
			getQuestion (0);
		}

		function reloadEventQuestionList () {
			var options = {
				searchParam : {eventNo : '${eventBase.eventNo }' }
			};
			grid.reload("eventQuestionList", options);
		}

		function excelDown () {
			createFormSubmit( "eventExcelDownload", "/event/eventLetterExcelDownload.do", {eventNo : '${eventBase.eventNo }' } );
		}

		</script>
	</t:putAttribute>

	<t:putAttribute name="content">

<form id="eventUpdateForm" name="eventUpdateForm" method="post" >
	<input type="hidden" id="dispStrtDtm" name="dispStrtDtm" class="validate[required]" value="" />
	<input type="hidden" id="dispEndDtm" name="dispEndDtm" class="validate[required]" value="" />

			<table class="table_type1">
				<caption>EVENT 상세</caption>
				<tbody>
					<tr>
						<th><spring:message code="column.event_no" /><strong class="red">*</strong></th>	<!-- 이벤트 번호 -->
						<td>
							<input type="hidden" id="eventNo" name="eventNo" value="${eventBase.eventNo }" />
<c:choose>
<c:when test="${eventBase.eventNo eq null }">
							<b>자동입력</b>
</c:when>
<c:otherwise>
							<b>${eventBase.eventNo }</b>
</c:otherwise>
</c:choose>
						</td>
						<th><spring:message code="column.event_gb_cd" /><strong class="red">*</strong></th>	<!-- 이벤트 구분 -->
						<td>
							<input type="hidden" id="eventGbCd" name="eventGbCd" value="${eventBase.eventGbCd }" />
							<frame:codeName grpCd="${adminConstants.EVENT_GB }" dtlCd="${eventBase.eventGbCd }" />
						</td>
					</tr>
					<tr>
						<th><spring:message code="column.st_id"/><strong class="red">*</strong></th> <!-- 사이트 아이디 -->
						<td colspan="3">
							<frame:stIdCheckbox selectKey="${eventBase.stStdList}" compNo="${goodsBase.compNo}" required="true"/>
						</td>

					</tr>
					<tr>
						<th><spring:message code="column.ttl" /><strong class="red">*</strong></th>	<!-- 제목 -->
						<td>
							<input type="text" class="validate[required]" name="ttl" id="ttl" title="<spring:message code="column.ttl" />" value="${eventBase.ttl }" />
						</td>
						<th><spring:message code="column.disp_yn" /><strong class="red">*</strong></th>	<!-- 전시여부 -->
						<td>
							<frame:radio name="dispYn" grpCd="${adminConstants.DISP_YN }" selectKey="${eventBase.dispYn }" />
						</td>
					</tr>
					<tr>
						<th scope="row"><spring:message code="column.display_view.disp_date" /><strong class="red">*</strong></th>	<!-- 전시기간-->
						<td colspan="3">
							<frame:datepicker startDate="dispStrtDt"
											  startHour="dispStrtHr"
											  startMin="dispStrtMn"
											  startSec="dispStrtSec"
											  startValue="${eventBase.dispStrtDtm }"
											  endDate="dispEndDt"
											  endHour="dispEndHr"
											  endMin="dispEndMn"
											  endSec="dispEndSec"
											  endValue="${eventBase.dispEndDtm }"/>
						</td>
					</tr>
				<c:if test="${eventBase.eventGbCd ne adminConstants.EVENT_GB_40 }" >
					<tr>
						<th><spring:message code="column.dlgt_img" /><strong class="red">*</strong></th>	<!-- 대표 이미지 -->
						<td colspan="3">
							<div class="mg5">
								<button type="button" name="fileUploadBtn" id="fileUploadBtn" onclick="fileUpload.goodsImage(resultImage, 'dlgtImgPath');" class="btn">검색</button>
								<button type="button" onclick="deleteImage('dlgtImgPath');" class="btn">삭제</button>
								<span class="red-desc">* 대표 이미지 - 720*405</span>
							</div>
							<div class="mg5">
								<input type="hidden" name="dlgtImgPath" id="dlgtImgPath" value="${eventBase.dlgtImgPath }" />
								<input type="hidden" name="dlgtImgPathDel" id="dlgtImgPathDel" value="" />
							
							    <c:if test="${not empty eventBase.dlgtImgPath}">
									<img src="<frame:imgUrl/>${eventBase.dlgtImgPath }" class="thumb" style="width:720px;height:405px">
								</c:if>
							    <c:if test="${empty eventBase.dlgtImgPath}">
								    <img src="/images/noimage_l.png" class="thumb" style="width:720px;height:405px" alt="NoImage" />
								</c:if>
							</div>
						</td>
					</tr>
				</c:if>
					<tr>
						<th scope="row"><spring:message code="column.content" /><c:if test="${eventBase.eventGbCd eq adminConstants.EVENT_GB_40 }" ><strong class="red">*</strong></c:if>
						</th>	<!-- 내용 -->
						<td colspan="3" >
							<textarea name="content" id="content" class="validate[required]" cols="30" rows="10" style="width: 98%">${eventBase.content }</textarea>
						</td>
					</tr>
					<c:if test="${eventBase.eventGbCd eq adminConstants.EVENT_GB_50 }" >
					<tr>
					<!--  적립금 부여 -->
						<th><spring:message code="column.member_view.svmn_rmn_amt" /><strong class="red">*</strong></th>	<!-- 적립금 -->
						<td colspan="3" >
							<input type="text"  name="saveAmt" id="saveAmt" class="validate[required]" title="<spring:message code="column.member_view.svmn_rmn_amt" />" value="${eventBase.saveAmt }" /> 원
						</td>
					</tr>
					</c:if>
				</tbody>
			</table>
</form>

<c:if test="${eventBase.eventGbCd ne adminConstants.EVENT_GB_10  and  eventBase.eventGbCd ne adminConstants.EVENT_GB_40 and eventBase.eventGbCd ne adminConstants.EVENT_GB_50 }" >
			<div class="row mt30">
				<div class="col-md-8 bar-right">
					<div class="mTitle">
						<h2>선택문항 목록</h2>
					</div>

					<div class="mModule no_m">
						<table id="eventQuestionList" ></table>
						<div id="eventQuestionListPage"></div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="mTitle">
						<h2>선택문항 상세</h2>
					</div>
					<div id="eventQuestionView" >
						<jsp:include page="/WEB-INF/view/event/eventQuestDetailView.jsp" />
					</div>
				</div>
			</div>
</c:if>

<c:if test="${eventBase.eventGbCd eq adminConstants.EVENT_GB_10  or  eventBase.eventGbCd eq adminConstants.EVENT_GB_20 or eventBase.eventGbCd eq adminConstants.EVENT_GB_30 or eventBase.eventGbCd eq adminConstants.EVENT_GB_50 }" >
			<div class="mTitle mt30">
				<h2>참여자정보 목록</h2>
			</div>
			<div class="mModule no_m">
				<table id="eventLetterList" ></table>
				<div id="eventLetterListPage"></div>
			</div>
</c:if>

			<div class="btn_area_center">
				<button type="button" class="btn btn-ok" onclick="updateEvent(); return false;" >수정</button>
				<button type="button" class="btn btn-cancel" onclick="closeTab();" >닫기</button>

				<c:if test="${eventBase.eventGbCd eq adminConstants.EVENT_GB_10  or  eventBase.eventGbCd eq adminConstants.EVENT_GB_20 or eventBase.eventGbCd eq adminConstants.EVENT_GB_30 }" >
				<button type="button" onclick="excelDown();" class="btn btn-add">참여자정보 다운로드</button>
				</c:if>


			</div>

	</t:putAttribute>

</t:insertDefinition>