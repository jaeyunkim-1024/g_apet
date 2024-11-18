<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>

<script type="text/javascript">
	$(document).ready(function(){
		fnMembrerExcelListGrid();
	});
	
	function fnMembrerExcelListGrid() {
		
		var colModelsObj =  [
			{name:"mbrNo", label:"회원 번호", width:"100", align:"center", sortable:false , key:true}
			, {name:"loginId", label:_MEMBER_SEARCH_GRID_LABEL.loginId, width:"150", align:"center", sortable:false}
			, {name:"mobile", label:_MEMBER_SEARCH_GRID_LABEL.mobile, width:"150", align:"center", sortable:false}
			, {name:"mbrLevRsnCd", label:"결과", width:"80", align:"center", sortable:false, formatter:"select" ,editoptions:{value:"<frame:gridSelect grpCd='${adminConstants.REQ_RST }' />"} }  
			, {name:"mbrLevContent", label:"메세지", width:"200", align:"left", sortable:false}
		];
		
		var options = {
			height : 300
			, datatype : 'local'
			, colModels : colModelsObj
			
		};
		grid.create("layerMemberExcelList", options);
		
	}
	
	function saveCouponIssueExcel(){
		var gridMember = $("#layerMemberExcelList");

		var rowids = gridMember.jqGrid('getRowData');
		
		if(rowids.length <= 0 ) {
			messager.alert("<spring:message code='admin.web.view.msg.common.noSelect' />", "Info", "info");
			return;
		}
		
		var mbrNos = new Array();
		for (var i = 0; i < rowids.length; i++) {
			var rowData = rowids[i];
			
			if(rowData.mbrLevRsnCd == 'S') mbrNos.push(rowData.mbrNo);
					
		}
		
		if(mbrNos.length <= 0){
			messager.alert("<spring:message code='admin.web.view.msg.common.noSelect' />", "Info", "info");
			return;
		}

		var couponIssuConfMsg = "쿠폰을 발급하시겠습니까?";
		
		if($("#uploadFailCnt").text() != '0' ){
			couponIssuConfMsg = "쿠폰 발급이 불가능한 목록이 있습니다. 쿠폰을 발급하시겠습니까?";
		}
		
		messager.confirm(couponIssuConfMsg,function(r){
			if(r){

				var cpNo = Number("<c:out value='${coupon.cpNo }'/>");
				var options = {
					url : "<spring:url value='/promotion/couponIssueMemberList.do' />"
					, data : {cpNo : cpNo, mbrNos : mbrNos}
					, callBack : function(data ) {
						grid.reload("couponIssueList", options);
						messager.alert("발급이 완료되었습니다.", "Info", "info", function(){
							layer.close('layerCouponIssueExcelView');
						});
					}
				};
				ajax.call(options);
			}
		});
	}
	
	// 엑셀 업로드 양식 다운로드
	function couponTmplExcelDownload() {
		createFormSubmit("couponTmplExcelDownload", "/promotion/couponTmplExcelDownload.do", {});
	}
	
	// 엑셀 업로드 결과 다운로드
	function couponIssueUploadExcelDownload(){
		var rowids = $("#layerMemberExcelList").jqGrid('getRowData');
		
		if(rowids.length <= 0) return;
		
		var uploadResults = new Array();
		for (var i = 0; i < rowids.length; i++) {
			
			var option = {
					cpNo : Number("<c:out value='${coupon.cpNo }'/>")
					,mbrNo :  rowids[i].mbrNo
					,loginId :  rowids[i].loginId
					,mobile :  rowids[i].mobile
					,mbrLevRsnCd :  rowids[i].mbrLevRsnCd
					,mbrLevContent :  rowids[i].mbrLevContent
			};
			
			uploadResults.push(option);
		}

		createFormSubmit("couponIssueUploadExcelDownload", "/promotion/couponIssueUploadExcelDownload.do", uploadResults);
	}
	
	function fnCallBackFileUpload(file) {
		var grid = $("#layerMemberExcelList");

		$("#layerCouponIssueExcelForm #fileName").val( file.fileName );
		$("#layerCouponIssueExcelForm #filePath").val( file.filePath );
		

		grid.jqGrid("clearGridData");
		$("#uploadCnt").text(0);
		$("#uploadSussCnt").text(0);
		$("#uploadFailCnt").text(0);
		
		var sendData = {
			fileName : file.fileName
			, filePath : file.filePath
			, cpNo : Number("<c:out value='${coupon.cpNo }'/>")
			, isuTgCd : "<c:out value='${coupon.isuTgCd}'/>"
		}
		var options = {
			url : "<spring:url value='/promotion/couponIssueExcelUpload.do' />"
			, data : sendData
			, callBack : function(data) {
				if (data.resultList.length == 0) {
					messager.alert("엑셀 파일의 회원 정보와 일치하는 회원이 없습니다.", "Info", "info");
					return;
				}
				
				for(var i=0;i<=data.resultList.length;i++){
					grid.jqGrid('addRowData',i+1,data.resultList[i]);
				}
				
				$("#uploadCnt").text(data.resultList.length);
				$("#uploadSussCnt").text(data.sussCnt);
				$("#uploadFailCnt").text(data.failCnt);
				
				couponIssueUploadExcelDownload();
				
			}
		}
		ajax.call(options);
	}
</script>
			
<form id="layerCouponIssueExcelForm" name="layerCouponIssueExcelForm" method="post" >
	<table class="table_type1 popup">
		<caption>정보 검색</caption>
		<tbody>
			<tr>
				<th>엑셀 템플릿 다운로드</th>
				<td colspan="3">
					<p>1) 엑셀 템플릿 다운로드</p>
					<p>2) 다운받은 파일의 포맷에 맞춰 수정</p>
					<p>3) 다른 필드는 수정 금지</p>
					<p>4) 수정한 파일 선택</p>
					<p>5) “발급 대상 일괄 등록" 버튼 클릭</p>
					<p style="color: red;" >* 주의 : 정해진 포맷 외 필드 추가나 삭제 하지 마세요. </p>
					<p>
						<button type="button" id="excelTmplDownloadBtn" onclick="couponTmplExcelDownload();" class="btn btn-add" >엑셀양식 다운로드</button>
					</p>
				</td>
			</tr>
			<tr>
				<th><spring:message code="column.common.btn.excel_upload"/><strong class="red">*</strong></th>
				<td colspan="3">
					<input type="text" class="w400 validate[required ] readonly" id="fileName" name="fileName" value="" readonly="readonly"/>
					<input type="hidden" id="filePath" name="filePath" value="" />
				</td>
			</tr>
		</tbody>
	</table>

	<div class="btn_area_center">
		<button type="button" onclick="fileUpload.xls(fnCallBackFileUpload);" class="btn btn-ok">발급 대상 일괄 등록</button>
	</div>
</form>

<div class="mModule">		

	<div class="buttonArea" align="right" >
		<div align="left" style="position:  absolute; top: 10px;" >
			전체데이터 : <span id="uploadCnt">0</span>건, 성공건수 : <span id="uploadSussCnt">0</span>건, 실패건수 : <span id="uploadFailCnt">0</span>건
		</div>
		<button type="button" onclick="couponIssueUploadExcelDownload();" class="btn btn-add btn-excel">엑셀 다운로드</button>
	</div>
	<table id="layerMemberExcelList" ></table>
</div>
