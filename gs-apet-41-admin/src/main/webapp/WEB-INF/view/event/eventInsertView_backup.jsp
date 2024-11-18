<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>

<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">
		$(document).ready(function() {

			initEditor ();
			createEventQuestionGrid ();
			// 적립금 부여 이벤트 관련 적립금 넣는 액수 hide
			$("#saveAmtArea").hide();
			// Grid Size 때문에 처리
			$("#eventQuest").hide();
		});

		function initEditor () {
			EditorCommon.setSEditor('content', '${adminConstants.EVENT_IMAGE_PATH}');
		}

		function createEventQuestionGrid () {
			var options = {
				url : null
				, datatype : "local"
				, paging : false
				, height : 300
				, colModels : [
					{name:"eventNo", label:'<spring:message code="column.event_no" />', width:"200", align:"center", hidden:true, sortable:false }
					, {name:"qstNo", label:'<spring:message code="column.qst_no" />', width:"80", align:"center", key: true, sortable:false }
					, {name:"qstNm", label:'<spring:message code="column.qst_nm" />', width:"400", align:"center", sortable:false }
					, {name:"qstImgPath", label:'', width:"0", align:"center", hidden:true, sortable:false }
					, {name:"qstImgPathView", label:'<spring:message code="column.dlgt_img" />', width:"100", align:"center", sortable:false, formatter: function(cellvalue, options, rowObject) {
						if(rowObject.qstImgPath != "") {
							return '<img style="width:50px; height:50px;" src="/common/imageView.do?filePath=' + rowObject.qstImgPath + '">';
						}
					}}
				]
				, multiselect : true
			};
			grid.create("eventQuestionList", options);
		}

		// 이미지 업로드
		function resultImage (file, id) {
			$("#" + id).val(file.filePath);
			$("#" + id + "View").attr('src', '/common/imageView.do?filePath=' + file.filePath );	
		}

		function deleteImage (id) {
			("#" + id).val("");
			$("#" + id + "View").attr('src', '/images/noimage_l.png' );	
		}

		function insertQuestion () {
			if(validate.check("eventQuestionForm")) {
				var qstNm = $("#eventQuestionForm #qstNm").val();
				var qstImgPath = $("#eventQuestionForm #qstImgPath").val();

				// 이미지 초기화후 등록하지 않음
				if(qstImgPath == "" ) {
					messager.alert("<spring:message code='column.img_regist' />","Info","info");
					return;
				}

				var eventQuestion = {
					qstNm : qstNm
					, qstImgPath : qstImgPath
					, qstImgPathView : qstImgPath
				}
				$("#eventQuestionList").jqGrid("addRowData", eventQuestion.qstNo, eventQuestion, "last", null );
				resetQuestion ();
			}
		}

		function resetQuestion () {
			resetForm ("eventQuestionForm" );
			$("#qstImgPathView").attr("src","/images/noimage.png");
		}

		function deleteGridRow (id ) {
			var grid = $("#" + id );
			var rowids = grid.jqGrid('getGridParam', 'selarrrow');
			for (var i = rowids.length - 1; i >= 0; i--) {
				grid.jqGrid('delRowData', rowids[i]);
			}
		}

		function insertEvent () {
			var sendData = null;
			// 날짜..
			$("#dispStrtDtm").val(getDateStr ("dispStrt"));
			$("#dispEndDtm").val(getDateStr ("dispEnd"));
			if(validate.check("eventInsertForm")) {

				oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);

				var eventGbCd = $("#eventGbCd").children("option:selected").val();

				var dlgtImgPath = $("#dlgtImgPath").val();
				if(  eventGbCd != "${adminConstants.EVENT_GB_40 }" ){
					if(dlgtImgPath == "" ) {
						messager.alert("<spring:message code='column.dlgt_img_regist' />","Info","info",function(){
							$("#fileUploadBtn").focus();
						});
						return;
					}
				}else{
					if(eventGbCd == "${adminConstants.EVENT_GB_50 }" ){
						var saveAmt = $("#saveAmt").val().trim();
						if( $("#saveAmt").val() ==''){
							messager.alert("<spring:message code='column.saveAmt_regist' />","Info","info");							
							return false;
						}
					}

					if( $('#content').val().replace(/<img /gi, "img ").replace(/(<([^>]+)>)/gi, "").replace(/&nbsp;/gi, "").trim() == "" ) {	// 공백일 경우
						messager.alert("<spring:message code='column.content_regist' />","Info","info");
						return false;
					}

				}
				if(eventGbCd != "${adminConstants.EVENT_GB_10}" &&  eventGbCd != "${adminConstants.EVENT_GB_40}" && eventGbCd != "${adminConstants.EVENT_GB_50 }" ) {
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


				var formData = $("#eventInsertForm").serializeJson();
				var questionList = grid.jsonData ("eventQuestionList" );

				// Form 데이터
				/*
				sendData = {
					eventBasePO : JSON.stringify(formData )
					, eventQuestionPO : JSON.stringify(questionList )
				}
				*/
				sendData = formData;
				$.extend(sendData, { eventQuestionPO : JSON.stringify(questionList )  } );

				messager.confirm("<spring:message code='column.common.confirm.insert' />",function(r){
					if(r){
						var options = {
								url : "<spring:url value='/event/eventInsert.do' />"
								, data : sendData
								, callBack : function (data ) {
									messager.alert("<spring:message code='column.common.regist.final_msg' />","Info","info",function(){
										eventDetailView (data.eventNo );
									});									
								}
							};
							ajax.call(options);				
					}
				});				
			}
		}

		function selectEventGb (obj ) {
			var eventGbCd = $(obj).children("option:selected").val();
			if(eventGbCd == "${adminConstants.EVENT_GB_10 }" || eventGbCd == "${adminConstants.EVENT_GB_40 }" || eventGbCd == "${adminConstants.EVENT_GB_50 }" ) {
				$("#eventQuest").hide();
				if( eventGbCd == "${adminConstants.EVENT_GB_50 }" ){
					$("#saveAmtArea").show();
				}else{
					$("#saveAmtArea").hide();
				}
			} else {
				$("#eventQuest").show();
				$("#saveAmtArea").hide();
			}

			var contentStrongSpan = '<strong class="red">*</strong>';
			if (eventGbCd == "${adminConstants.EVENT_GB_40 }"){
				$("#trNmDlgtImg").attr("style", 'display: none');
				$("#contentStrongSpan").html(contentStrongSpan);
			}else{
				$("#trNmDlgtImg").attr("style", ' ');

				$("#contentStrongSpan").html("");
			}
		}

		function eventDetailView (eventNo ) {
			addTab('이벤트 상세', '/event/eventDetailView.do?eventNo=' + eventNo);
		}


		</script>
	</t:putAttribute>

	<t:putAttribute name="content">

<form id="eventInsertForm" name="eventInsertForm" method="post" >
	<input type="hidden" id="dispStrtDtm" name="dispStrtDtm" class="validate[required]" value="" />
	<input type="hidden" id="dispEndDtm" name="dispEndDtm" class="validate[required]" value="" />

			<table class="table_type1">
				<caption>EVENT 등록</caption>
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
							<select class="validate[required]" name="eventGbCd" id="eventGbCd" onchange="selectEventGb(this);" title="<spring:message code="column.event_gb_cd" />">
								<frame:select grpCd="${adminConstants.EVENT_GB }" selectKey="${eventBase.eventGbCd eq null ? adminConstants.EVENT_GB_10 : eventBase.eventGbCd }" />
							</select>
						</td>
					</tr>
					<tr>
						<th><spring:message code="column.st_id"/><strong class="red">*</strong></th>
						<td colspan="3">
							<frame:stIdCheckbox required="true"/>
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
											  endValue="${eventBase.dispEndDtm }"
											  period="30" />
						</td>
					</tr>

					<tr id='trNmDlgtImg' >
						<th><spring:message code="column.dlgt_img" /><strong class="red">*</strong></th>	<!-- 대표 이미지 -->
						<td colspan="3">
							<div class="mg5">
								<button type="button" name="fileUploadBtn" id="fileUploadBtn" onclick="fileUpload.goodsImage(resultImage, 'dlgtImgPath');" class="btn">검색</button>
								<button type="button" onclick="deleteImage('dlgtImgPath');" class="btn">삭제</button>
								<span class="red-desc">* 대표 이미지 - 720*405</span>
							</div>
							<div class="mg5">
								<input type="hidden" name="dlgtImgPath" id="dlgtImgPath" value="" />
								<img id="dlgtImgPathView" name="dlgtImgPathView" src="/images/noimage_l.png" class="thumb" style="width:720px;height:405px" alt="" />
							</div>
						</td>
					</tr>

					<tr>
						<th scope="row"><spring:message code="column.content" /><span id="contentStrongSpan"></span></th>	<!-- 내용 -->
						<td colspan="3" >
							<textarea name="content" id="content" class="validate[required]" cols="30" rows="10" style="width: 98%">${eventBase.content }</textarea>
						</td>
					</tr>
					<tr id="saveAmtArea">
					<!--  적립금 부여 -->
						<th><spring:message code="column.member_view.svmn_rmn_amt" /><strong class="red">*</strong></th>	<!-- 적립금 -->
						<td colspan="3" >
							<input type="text"  name="saveAmt" id="saveAmt" class="validate[required]" title="<spring:message code="column.member_view.svmn_rmn_amt" />" value="" /> 원
						</td>
					</tr>

				</tbody>
			</table>
</form>

			<div id="eventQuest" class="row mt30">
				<div class="col-md-8 bar-right">
					<div class="mTitle">
						<h2>선택문항 리스트</h2>
						<div class="buttonArea">
							<button type="button" onclick="deleteGridRow('eventQuestionList' );" class="btn btn-add">삭제</button>
						</div>
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

			<div class="btn_area_center">
				<button type="button" class="btn btn-ok" onclick="insertEvent(); return false;" >등록</button>
				<button type="button" class="btn btn-cancel" onclick="closeTab();" >취소</button>
			</div>

	</t:putAttribute>

</t:insertDefinition>