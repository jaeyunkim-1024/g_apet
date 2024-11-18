<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<script type="text/javascript">
	$(document).ready(function() {
		searchDateChange();
		createPushReserveListGrid();
		
		//달력 클릭시 '기간선택' 으로 선택되도록 수정
		$(".datepicker").focus(function(){
      		$("#pushReserveListForm #checkOptDate option:eq(0)").prop("selected", true);
      	});
		
		// 엔터키 이벤트
		$(document).on("keydown","#pushReserveListForm input[name=searchTxt]",function(e){
			if (e.keyCode == 13) {
				searchPushMessageList('pushReserveList', 'pushReserveListForm');
			}
		});
	});
	
	// 알림 메시지 발송 내역 그리드
	function createPushReserveListGrid() {
		var options = {
			url : "<spring:url value='/appweb/listPushReserveGrid.do' />"
			, height : 400
			, searchParam : $("#pushReserveListForm").serializeJson()
			, cellEdit : true
			, colModels : noticeSendGrid.colModelCommon2
			, onCellSelect : function (id, cellidx, cellvalue) {
				var rowData = $("#pushReserveList").getRowData(id);
				if (cellidx == 4) {
					pushMessageSendDetailView(rowData.noticeSendNo);
				}
			}
			, loadComplete : function(data) {
				var td = $("#pushReserveList").find("tr").find("td[aria-describedby=pushReserveList_subject]");
				$(td).css('color', '#0066CC');
				$(td).css('text-decoration', 'underline');
			}
		};
		$.extend(options.searchParam, {pushTpGb:"reserve"});
		grid.create("pushReserveList", options);
	}
	
	// 알림 메시지 예약 리스트 상세 페이지
	function pushMessageSendDetailView(seq) {
		var options = {
			url : "<spring:url value='/appweb/pushMessageSendViewPop.do' />"
			, data : {noticeSendNo : seq}
			, dataType : "html"
			, callBack : function(data) {
				var config = {
					id : "pushMessageSendViewPop"
					, title : "알림 메시지 상세"
					, width : 1000
					, body : data
					, button : "<button type=\"button\" onclick=\"sendPushMessage('20');\" class=\"btn btn-add\" style=\"background-color:#0066CC; border-color:#0066CC;\">발송 수정</button>"
								+ "<button type=\"button\" onclick=\"deleteNoticeSend();\" class=\"btn btn-ok ml10\">삭제</button>"
				}
				layer.create(config);
			}
		}
		ajax.call(options);
	}
	
	// 알림 메시지 예약 리스트 엑셀 다운로드
	function pushReserveListExcelDownload() {
		var excelData = $("#pushReserveListForm").serializeJson();
		var headerName = new Array();
		var fieldName = new Array();
		headerName.push("No");
		headerName.push("발송방식");
		headerName.push("카테고리");
		headerName.push("메시지 타이틀");
		headerName.push("발송 건수");
		headerName.push("발송일자");
		
		fieldName.push("noticeSendNo");
		fieldName.push("noticeTypeCd");
		fieldName.push("ctgCd");
		fieldName.push("subject");
		fieldName.push("noticeMsgCnt");
		fieldName.push("sendReqDtm");
		
		$.extend(excelData, {
			headerName : headerName
			, fieldName : fieldName
			, sheetName : "pushReserveListExcelDownload"
			, fileName : "pushReserveExcelDownload"
			, pushTpGb : "reserve"
		});
		createFormSubmit("pushReserveListExcelDownload", "/appweb/pushCommonExcelDownload.do", excelData);
	}
</script>
<form name="pushReserveListForm" id="pushReserveListForm" method="post">
	<table class="table_type1">
		<colgroup>
			<col width="10%"/>
			<col width="90%"/>
		</colgroup>
		<caption>알림 메시지 예약 리스트</caption>
		<tbody>
			<tr>
				<th><spring:message code="column.push.reserve_dtm" /></th>
				<td>
					<!-- 예약일자 -->
					<frame:datepicker startDate="strtDate" startValue="${frame:toDate('yyyy-MM-dd') }" endDate="endDate" endValue="${frame:toDate('yyyy-MM-dd') }" />&nbsp;&nbsp;
					<select id="checkOptDate" name="checkOptDate" onchange="searchDateChange();">
						<frame:select grpCd="${adminConstants.SELECT_PERIOD}" selectKey="${adminConstants.SELECT_PERIOD_40 }" defaultName="기간선택" />
					</select>
				</td>
			</tr>
			<tr>
				<th><spring:message code="column.push.search" /></th>
				<td>
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
		<button type="button" onclick="searchPushMessageList('pushReserveList', 'pushReserveListForm');" class="btn btn-ok">조회</button>
		<button type="button" onclick="searchReset('pushReserveList', 'pushReserveListForm');" class="btn btn-cancel">초기화</button>
	</div>
	<div class="mModule">
		<div align="right">
			<button type="button" onclick="pushTemplateInsertView();" class="btn btn-add">템플릿 생성</button>
			<button type="button" onclick="pushMessageSendView();" class="btn btn-add" style="background-color:#0066CC; border-color:#0066CC;">예약 접수</button>
			<button type="button" onclick="pushReserveListExcelDownload();" class="btn btn-add btn-excel" style="margin-right:0px;">엑셀 다운로드</button>
		</div>
		
		<table id="pushReserveList"></table>
		<div id="pushReserveListPage"></div>
	</div>
</form>
