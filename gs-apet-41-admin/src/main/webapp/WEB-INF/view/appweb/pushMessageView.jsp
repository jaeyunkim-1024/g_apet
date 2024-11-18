<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">
			$(document).ready(function() {
				//날짜선택시 selectbox 기간선택문구로 변경 
				newSetCommonDatePickerEvent("#strtDate", "#endDate"); 
				searchDateChange();
				if ("${noticeTypeCd}") {
					if ("${noticeTypeCd}" == "${adminConstants.NOTICE_TYPE_10}") {
						fnChangeView('pushStatus');
					} else {
						fnChangeView('pushReserve');
					}
				} else {
					$("#pushReserveListView").empty();
					createPushStatusGrid();
				}
				
			
			});
			
			var noticeSendGrid = {
				colModelCommon : [
					// 외부 API 요청 아이디
					{name:"outsideReqId", label:'outsideReqId', width:"80", align:"center", sortable:false, hidden:true}
					// 템플릿 번호
					, {name:"noticeSendNo", label:'No', width:"120", align:"center", sortable:false}
					// 메시지 유형
					, {name:"sndTypeCd", label:'<spring:message code="column.push.message_type" />', width:"150", align:"center", sortable:false, formatter:"select", editoptions:{value:"<frame:gridSelect grpCd='${adminConstants.SND_TYPE }' />"}}
					// 발송방식
					, {name:"noticeTypeCd", label:'<spring:message code="column.push.type" />', width:"125", align:"center", sortable:false, formatter:"select", editoptions:{value:"<frame:gridSelect grpCd='${adminConstants.NOTICE_TYPE }' />"}}
					// 메시지 타이틀
					, {name:"subject", label:'<spring:message code="column.push.message_ttl" />', width:"480", align:"center", sortable:false, classes:'pointer', formatter: function(cellvalue, options, rowObject) {
						var cellLength = cellvalue.length;
						var cellStr = rowObject.subject;
						if (cellLength > 25) {
							cellStr = rowObject.subject.substring(0,25) + "...";
						}
						return cellStr;
					}}
					// 발송대상 수
					, {name:"noticeMsgCnt", label:'<spring:message code="column.push.tg_count" />', width:"120", align:"center", sortable:false, classes:'pointer'}
					// 발송실패
					, {name:"failCnt", label:'<spring:message code="column.push.fail" />', width:"120", align:"center", sortable:false}
					// 등록일
					, {name:'sysRegDtm', label:'<spring:message code="column.regdate" />', width:'190', align:'center', sortable:false, formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss"}
					// 발송(예약)일자
					, {name:'sendReqDtm', label:'<spring:message code="column.push.send_reserve_dtm" />', width:'190', align:'center', sortable:false, formatter: function(cellvalue, options, rowObject) {
							let str = new Date(rowObject.sendReqDtm).format("yyyy-MM-dd HH:mm:ss");
							if(rowObject.noticeTypeCd == "${adminConstants.NOTICE_TYPE_10}") {
								str = new Date(rowObject.sysRegDtm).format("yyyy-MM-dd HH:mm:ss");
							}
							return str;
						}
					}
					// 등록자
					, {name:'sysRegrNm', label:'<spring:message code="column.sys_regr_nm" />', width:'130', align:'center', sortable:false}
				]
				, colModelCommon2 : [
					// 외부 API 요청 아이디
					{name:"outsideReqId", label:'outsideReqId', width:"80", align:"center", sortable:false, hidden:true}
					// 템플릿 번호
					, {name:"noticeSendNo", label:'No', width:"120", align:"center", sortable:false}
					// 발송방식
					, {name:"noticeTypeCd", label:'<spring:message code="column.push.type" />', width:"180", align:"center", sortable:false, formatter:"select", editoptions:{value:"<frame:gridSelect grpCd='${adminConstants.NOTICE_TYPE }' />"}}
					// 카테고리
					, {name:"ctgCd", label:'<spring:message code="column.push.category" />', width:"180", align:"center", sortable:false, formatter:"select", editoptions:{value:"<frame:gridSelect grpCd='${adminConstants.CTG }' />"}}
					// 메시지 타이틀
					, {name:"subject", label:'<spring:message code="column.push.message_ttl" />', width:"790", align:"center", sortable:false, classes:'pointer', formatter: function(cellvalue, options, rowObject) {
						var cellLength = cellvalue.length;
						var cellStr = rowObject.subject;
						if (cellLength > 25) {
							cellStr = rowObject.subject.substring(0,25) + "...";
						}
						return cellStr;
					}}
					// 발송대상 수
					, {name:"noticeMsgCnt", label:'건수', width:"170", align:"center", sortable:false}
					// 예약일자
					, {name:'sendReqDtm', label:'<spring:message code="column.push.reserve_dtm" />', width:'220', align:'center', sortable:false, formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss"}
				]
			}
			// 탭 변경
			function fnChangeView(view) {
				if (view == "pushStatus") {
					$("#pushReserveListView").empty();
					pushViewBase(view);
				} else {
					$("#pushStatusListView").empty();
					pushViewBase(view);
				}
			}
			
			// 탭 변경 후 화면 수정
			function pushViewBase(view) {
				var url;
				if (view == "pushStatus"){
					$("#pushStatusLi").parent(".tabMenu").find('li').removeClass('active');
					$("#pushStatusLi").addClass('active');
					url = "<spring:url value='/appweb/pushStatusListView.do' />";
				} else {
					$("#pushReserveLi").parent(".tabMenu").find('li').removeClass('active');
					$("#pushReserveLi").addClass('active');
					url = "<spring:url value='/appweb/pushReserveListView.do' />";
				}
				
				var options = {
					url : url
					, dataType : "html"
					, callBack : function(result) {
						if (view == "pushStatus"){
							$("#pushStatusListView").html(result);
						} else {
							$("#pushReserveListView").html(result);
						}
					}
				}
				ajax.call(options);
			}
			
			// 알림메시지 발송건수 상세내역 팝업
			function pushCountDetailView(seq) {
				var options = {
					url : "<spring:url value='/appweb/pushCountDetailView.do' />"
					, data : {noticeSendNo : seq}
					, dataType : "html"
					, callBack : function(data) {
						var config = {
							id : "pushCountDetailView"
							, title : "알림메시지 발송건수 상세내역"
							, body : data
						}
						layer.create(config);
					}
				}
				ajax.call(options);
			}
			
			// 알림 메시지 발송 내역 검색
			function searchPushMessageList(gridId, formId){
				//검색버튼 click이후에 alert창 띄우기 
				compareDateAlert("strtDate", "endDate", "term");
				
				var options = {
						searchParam : $("#" + formId).serializeJson()
				};
				gridReload('strtDate','endDate','pushStatusList','term', options);
			}
			
			// 목록 초기화
			function searchReset(gridId, formId){
				resetForm(formId);
				searchDateChange();
				searchPushMessageList(gridId, formId);
			}
			
			// 기간 검색
			function searchDateChange() {
				var dateChange = $("#checkOptDate").children("option:selected").val();
				if(dateChange == "" ) {
					$("#strtDate").val("");
					$("#endDate").val("");
				}else if(dateChange == "50"){
    				//3개월 기간조회시에만 호출하는 메소드
    				setSearchDateThreeMonth("strtDate", "endDate");
    			}else {
					setSearchDate(dateChange, "strtDate", "endDate");
				}
			}
			
			// 알림 메시지 템플릿 생성
			function pushTemplateInsertView() {
				addTab("알림 메시지 템플릿 생성", "/appweb/pushTemplateInsertView.do");
			}
			
			// 알림 메시지 발송 화면 이동
			function pushMessageSendView() {
				addTab("알림 메시지 발송", "/appweb/pushMessageSendView.do");
			}
		</script>
	</t:putAttribute>
	<t:putAttribute name="content">
		<div class="mTab">
			<ul class="tabMenu">
				<li class="active" id="pushStatusLi"><a href="javascript:fnChangeView('pushStatus');">발송 현황</a></li>
				<li id="pushReserveLi"><a href="javascript:fnChangeView('pushReserve');">예약 리스트</a></li>
			</ul>
		</div>
		<div id="pushStatusListView">
			<jsp:include page="./pushStatusListView.jsp" />
		</div>
		
		<div id="pushReserveListView">
		</div>
	</t:putAttribute>
</t:insertDefinition>