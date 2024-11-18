<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<script type="text/javascript">
	$(document).ready(function() {
		searchDateChange();
		createPushStatusGrid();
		
		//달력 클릭시 '기간선택' 으로 선택되도록 수정
		/* $(".datepicker").focus(function(){
      		$("#pushStatusListForm #checkOptDate option:eq(0)").prop("selected", true);
      	}); */
		
		// 엔터키 이벤트
		$(document).on("keydown","#pushStatusListForm input[name=searchTxt]",function(e){
			if (e.keyCode == 13) {
				searchPushMessageList('pushStatusList', 'pushStatusListForm');
			}
		});
	});
	
	// 알림 메시지 발송 내역 그리드
	function createPushStatusGrid() {
		var options = {
			url : "<spring:url value='/appweb/listPushStatusGrid.do' />"
			, height : 400
			, searchParam : $("#pushStatusListForm").serializeJson()
			, cellEdit : true
			, colModels : noticeSendGrid.colModelCommon
			, onCellSelect : function (id, cellidx, cellvalue) {
				var rowData = $("#pushStatusList").getRowData(id);
				if (cellidx == 4) {
					pushMessageDetailView(rowData.noticeSendNo);
				} else if (cellidx == 5) {
					pushCountDetailView(rowData.noticeSendNo);
				}
			}
			, loadComplete : function(data) {
				var td = $("#pushStatusList").find("tr").find("td[aria-describedby=pushStatusList_noticeMsgCnt],td[aria-describedby=pushStatusList_subject]");
				$(td).css('color', '#0066CC');
				$(td).css('text-decoration', 'underline');
			}
		};
		$.extend(options.searchParam, {pushTpGb:"status"});
		grid.create("pushStatusList", options);
	}
	
	// 알림메시지 상세 팝업
	function pushMessageDetailView(seq) {
		var options = {
			url : "<spring:url value='/appweb/pushMessageDetailView.do' />"
			, data : {
				noticeSendNo : seq
			}
			, dataType : "html"
			, callBack : function(data) {
				var config = {
					id : "pushMessageDetailViewPop"
					, title : "알림메시지 상세"
					, body : data
				}
				layer.create(config);
			}
		}
		ajax.call(options);
	}
	
	// 알림 메시지 발송 현황 목록 엑셀 다운로드
	function pushStatusListExcelDownload() {
		var excelData = $("#pushStatusListForm").serializeJson();
		var headerName = new Array();
		var fieldName = new Array();
		headerName.push("No");
		headerName.push("메시지 유형");
		headerName.push("발송방식");
		headerName.push("메시지 타이틀");
		headerName.push("발송대상 수");
		headerName.push("발송실패");
		headerName.push("등록일시");
		headerName.push("발송(예약)일자");
		headerName.push("등록자");
		
		fieldName.push("noticeSendNo");
		fieldName.push("sndTypeCd");
		fieldName.push("noticeTypeCd");
		fieldName.push("subject");
		fieldName.push("noticeMsgCnt");
		fieldName.push("failCnt");
		fieldName.push("sysRegDtm");
		fieldName.push("sendReqDtm");
		fieldName.push("sysRegrNm");
		
		$.extend(excelData, {
			headerName : headerName
			, fieldName : fieldName
			, sheetName : "pushStatusListExcelDownload"
			, fileName : "pushStatusExcelDownload"
			, pushTpGb : "status"
		});
		createFormSubmit("pushStatusListExcelDownload", "/appweb/pushCommonExcelDownload.do", excelData);
	}
</script>
<form name="pushStatusListForm" id="pushStatusListForm" method="post">
	<table class="table_type1">
		<colgroup>
			<col width="20%"/>
			<col width="80%"/>
			<col width="20%"/>
			<col width="80%"/>
		</colgroup>
		<caption>공통 댓글 검색 목록</caption>
		<tbody>
			<tr>
				<th><spring:message code="column.common.date" /></th>
				<td colspan="3">
					<!-- 기간 -->
					<select name="dateSearchGb" id="dateSearchGb">
						<option value="10" selected="selected">발송일</option>
						<option value="20">등록일</option>
					</select>
					<frame:datepicker startDate="strtDate" startValue="${frame:toDate('yyyy-MM-dd') }" endDate="endDate" endValue="${frame:toDate('yyyy-MM-dd') }" />&nbsp;&nbsp;
					<select id="checkOptDate" name="checkOptDate" onchange="searchDateChange();">
						<frame:select grpCd="${adminConstants.SELECT_PERIOD}" selectKey="${adminConstants.SELECT_PERIOD_40 }" defaultName="기간선택" />
					</select>
				</td>
			</tr>
			<tr>
				<th><spring:message code="column.push.message_type" /></th>
				<td>
					<!-- 메시지 유형 -->
					<select name="sndTypeCd" id="sndTypeCd">
						<frame:select grpCd="${adminConstants.SND_TYPE }" defaultName="전체" />
					</select>
				</td>
				<th><spring:message code="column.push.type" /></th>
				<td>
					<!-- 발송방식 -->
					<select name="noticeTypeCd" id="noticeTypeCd">
						<frame:select grpCd="${adminConstants.NOTICE_TYPE }" defaultName="전체" />
					</select>
				</td>
			</tr>
			<tr>
				<th><spring:message code="column.push.search" /></th>
				<td colspan="3">
					<!-- 검색어 -->
					<select id="searchGb" name="searchGb">
						<option selected="selected" value="30">전체</option>
						<option value="10">메시지 타이틀</option>
						<option value="20">메시지 내용</option>
					</select>
					<input type="text" name="searchTxt" id="searchTxt" class="w800" placeholder="타이틀, 내용 입력" />
				</td>
			</tr>
		</tbody>
	</table>

	<div class="btn_area_center">
		<button type="button" onclick="searchPushMessageList('pushStatusList', 'pushStatusListForm');" class="btn btn-ok">조회</button>
		<button type="button" onclick="searchReset('pushStatusList', 'pushStatusListForm');" class="btn btn-cancel">초기화</button>
	</div>
	<div class="mModule">
		<div align="right">
			<button type="button" onclick="pushTemplateInsertView();" class="btn btn-add">템플릿 생성</button>
			<button type="button" onclick="pushMessageSendView();" class="btn btn-add" style="background-color:#0066CC; border-color:#0066CC;">발송 접수</button>
			<button type="button" onclick="pushStatusListExcelDownload();" class="btn btn-add btn-excel" style="margin-right:0px;">엑셀 다운로드</button>
		</div>
		
		<table id="pushStatusList"></table>
		<div id="pushStatusListPage"></div>
	</div>
</form>
