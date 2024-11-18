<%--	
 - Class Name	: eventParticipantManageView.jsp
 - Description	: 이벤트 참여자 관리
 - Since		: 2021.02.24
 - Author		: 김재윤
--%>
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
<t:putAttribute name="script">
	<script type="text/javascript">
		$(function(){
			//탭 선택
			$(document).on("click",".tabMenu li",function(){
				$(".tabMenu li").removeClass("active");
				$(this).addClass("active");
				var url = $(this).data("url");

				var options = {
						url : url
					, 	data : { eventNo : $("input[name=eventNo]").val() }
					, 	dataType : "HTML"
					, 	callBack : function(data){
							$("#event_pannel").html(data);
					}
				};

				ajax.call(options);
			});

			//이벤트 당첨자 비공개여부 변경
			$(document).on('click', '#notOpenYnBtn', function(){
				var msg = "";
				var notOpenYn = $("#notOpenYn").val();
				if(notOpenYn === "${adminConstants.COMM_YN_Y}"){
					msg = "<spring:message code='column.event_view.message.not_open_yn_y' />"
				}else{
					msg = "<spring:message code='column.event_view.message.not_open_yn_n' />"
				}

				messager.confirm(msg, function(r){
					if(r){
						data = {
							eventNo : $("input[name=eventNo]").val()
							, notOpenYn : $("#notOpenYn").val()
						}
						var options = {
							url : "/event/updateNotOpenYn.do"
							, data : data
							, callBack : function(data) {
								$("#winnerLi a").trigger('click');
							}
						}
						ajax.call(options);
					}
				});
			});

			//이벤트 당첨자 등록/수정 팝업
			$(document).on('click', '#eventWinnerUploadBtn', function(){
				var title = "";
				var button = "";
				var eventNo = $("input[name=eventNo]").val();

				if($(this).val() === "insert"){
					title = "이벤트 당첨자 등록";
					button = "<button type=\"button\" onclick=\"layerEventWinner.confirm();\" class=\"btn btn-ok\">확인</button>";
				}else{
					var eventNo = $("input[name=eventNo]").val();
					title = "이벤트 당첨자 수정";

					//현재시간
					var nowTime = new Date().getTime();
					//IE, 사파리에서도 인식 가능하도록 format 변경 :: " " -> "T"
					var winAnnDtm = $("input[name=winAnnDtm]").val().replace(" ", "T");
					var winAnnDtmTime = new Date(winAnnDtm).getTime();

					if(winAnnDtmTime - nowTime > 0){
						button = "<button type=\"button\" onclick=\"layerEventWinner.confirm();\" class=\"btn btn-ok\">수정</button>";
						button += "<button type=\"button\" onclick=\"layerEventWinner.fnDeleteWinInfo("+eventNo+");\" class=\"ml10 btn btn-ok\">삭제</button>";
					}
				}
				var data = {
					eventNo : eventNo
				}
				var option = {
					title : title
					, data : data
					, button : button
				}
				layerEventWinner.create(option);
			});

			//검색 버튼
			$(document).on('click', 'button[name=searchBtn]', function(){
				var formData = $("#searchForm").serializeJson();
				var options = {
					searchParam : formData
				};
				grid.reload("eventParticipantList", options);
			});

			$(".active").trigger("click");
		})
	</script>
</t:putAttribute>
<t:putAttribute name="content">
		<div class="mt30" id="mainContentWrap" data-ttl="${vo.ttl }" data-eventno="${vo.eventNo }" >
			<div class="mTitle">
				<!-- 이벤트 정보 -->
				<h2>이벤트 정보</h2>
				<input type="hidden" name="eventNo" value="${vo.eventNo }"/>
				<input type="hidden" name="eventGbCd" id="eventGbCd" value="${vo.eventGbCd}" />
			</div>
			<table class="table_type1" id="eventInfo">
				<tr>
					<!-- 이벤트 명 -->
					<th>이벤트 명 </th>
					<td>
						${vo.ttl}
					</td>
					<!-- 구분 -->
					<th>이벤트 상태</th>
					<td>
						<frame:codeName grpCd="${adminConstants.EVENT_STAT}" dtlCd="${vo.eventStatCd}"/>
					</td>
				</tr>
				<tr>
					<!-- 모집 기간 -->
					<th><spring:message code="column.event.participant.apl_dtm" /></th>
					<td>
						<fmt:formatDate value="${vo.aplStrtDtm}" pattern="yyyy-MM-dd"/>
						~
						<fmt:formatDate value="${vo.aplEndDtm}" pattern="yyyy-MM-dd"/>
					</td>
					<!-- 당첨자 발표일 -->
					<th><spring:message code="column.event.result_dtm" /></th>
					<td>
						<input type="hidden" name="winDt" value="${vo.winDt}"/>
						<c:choose>
							<c:when test="${not empty vo.winDt}">
								${vo.winDt}
							</c:when>
							<c:otherwise>-</c:otherwise>
						</c:choose>

					</td>
				</tr>
			</table>
		</div>
			
		<div class="mTab mt30">
			<ul class="tabMenu">
				<li class="active" data-url="/event/eventParticipantView.do"><a href="javascript:void(0);"><spring:message code="column.event.participant"/></a></li>
				<li data-url="/event/eventWinnerView.do" ><a href="javascript:void(0);"><spring:message code="column.event.winner"/></a></li>
			</ul>
		</div>
		<div id="event_pannel">
		</div>
</t:putAttribute>
</t:insertDefinition>