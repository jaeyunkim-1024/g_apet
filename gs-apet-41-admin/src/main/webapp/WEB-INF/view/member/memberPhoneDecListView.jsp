<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
    <t:putAttribute name="script">
        <script type="text/javascript">

        $(document).ready(function() {
            $("#excelDownBtn").attr("disabled", "disabled");
            $("#changeDecBtn").attr("disabled", "disabled");
            $("#initBtn").attr("disabled", "disabled");
		});

        // [callback] 엑셀업로드 콜백
		function fnCallBackExcelUpload(file) {
			if(file.fileName != ""){

			    var fileExe = file.fileExe;

			    if(fileExe != "xlsx"){
                    messager.alert("양식에 맞는 엑셀파일을 업로드해 주세요.", "Info", "info");
                    return;
                }

                $("#receiverListTxt").val(file.fileName);
                $("#fileName").val(file.fileName);
                $("#filePath").val(file.filePath);

                var data = {
                    filePath: $("#filePath").val(),
                    fileName: $("#fileName").val()
                }

                // 업로드 시 실패의 경우 customException 으로 인해
                $("#excelDownBtn").attr("disabled", "disabled");
                $("#changeDecBtn").attr("disabled", "disabled");
                $("#initBtn").attr("disabled", "disabled");

                var options = {
                    url: "<spring:url value='/member/memberPhoneExcelCheck.do' />",
                    data: data
                    , done: function(data) {
                        console.log(">>> done : " + data);
                    }
                    , callBack : function(data){
                        if (data.result == "SUCCESS") {
                            $("#changeDecBtn").removeAttr("disabled");
                            $("#initBtn").removeAttr("disabled");

                            if(data.diffCnt == 0){
                                messager.alert("업로드가 완료되었습니다.", "Info", "info");
                            }else{
                                messager.alert(data.diffCnt+"건의 일치하지 않는 회원번호를 제외하고\n업로드가 완료되었습니다.", "Info", "ino");
                            }
                        } else {
                            messager.alert("업로드가 실패되었습니다.\n재시도 해주시기 바랍니다.", "Info", "info");
                        }
                    }
                }
                ajax.call(options);
			}else{
				messager.alert("업로드가 실패되었습니다.\n재시도 해주시기 바랍니다.", "Info", "info");
			}
    	}

		// 전환
		function fnMemberListGridReload(){
			if(fnCheckFile()) return;

            $("#excelDownBtn").removeAttr("disabled");
		}
		
		// 엑셀 다운로드
        function fnMemberNoExcelDownload(){
			if(fnCheckFile()) return;
			// 버튼 비활성화
            $("#excelDownBtn").attr("disabled", "disabled");
            $("#changeDecBtn").attr("disabled", "disabled");
            $("#initBtn").attr("disabled", "disabled");

        	var data = {
  				  filePath : $("#filePath").val()
  				, fileName : $("#fileName").val()
  			}

            $("#receiverListTxt").val("");
            $("#filePath").val("");
            $("#fileName").val("");

            createFormSubmit("mbrNoExcelDownload", "/member/memberPhoneExcelDownload.do", data);
        }

        // 파일 존재 여부 체크
		function fnCheckFile(){
			if($("#fileName").val() == ""){
				messager.alert("업로드 파일을 선택해주세요.", "Info", "info");
				return true;
			}
		}

        // 초기화
		function fnInitBtnOnClick() {
			// init
		    $("#receiverListTxt").val("");
			$("#filePath").val("");
			$("#fileName").val("");
            $("#excelDownBtn").attr("disabled", "disabled");
            $("#changeDecBtn").attr("disabled", "disabled");
		}

        // [버튼]템플릿 다운로드
        function sampleDown () {
            location.href = "<spring:url value='/template/excel/memberPhoneDecExcel.xlsx' />";
        }

        </script>
    </t:putAttribute>
    <t:putAttribute name="content">
        <div class="easyui-accordion search-accordion" data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect" style="width:100%">
            <div title="<spring:message code='admin.web.view.title.memberPhoneDec' />" style="padding:10px">
                <form id="memberSearchForm">
                	<input type="hidden" id="fileName" name="fileName">
                	<input type="hidden" id="filePath" name="filePath">
                    <table class="table_type1">
                        <caption>회원번호 엑셀업로드</caption>
                        <colgroup>
                            <col width="10%"/>
                            <col width="40%"/>
                            <col width="10%"/>
                        </colgroup>
                        <tbody>
                            <tr>
                                <th><spring:message code="admin.web.view.grid.col.excelUpload" /></th>
                                <td>
									<input type="text" name="receiverListTxt" id="receiverListTxt" class="w250 mt15 mb5 receiverList"
									 readonly="readonly" placeholder="선택하세요" 
									 style="position:relative; padding:0px 30px 0px 10px;"/>
                                    <button type="button" id="receiverExcelUploadBtn" onclick="fileUpload.xls(fnCallBackExcelUpload);" class="btn mt15 mb5" >엑셀 업로드</button>
                                </td>
                                <th scope="row">Template</th>
                                <td>
                                    <button type="button" class="btn" onclick="sampleDown();">엑셀양식다운로드</button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </form>

                <div class="btn_area_center">
                    <button type="button" onclick="fnMemberListGridReload();" class="btn btn-ok" id="changeDecBtn">전환</button>
                    <button type="button" onclick="fnInitBtnOnClick();" class="btn btn-cancel" id="initBtn">초기화</button>
                </div>
            </div>
        </div>

        <div class="buttonArea mt30" style="text-align:left;">
            <button type="button" onclick="fnMemberNoExcelDownload();" class="btn btn-add btn-excel" id="excelDownBtn">
                <spring:message code="admin.web.view.common.button.download.excel"/>
            </button>
        </div>

        <div class="mModule" style="margin-top:10px;">
            <table id="memberPhoneDecList"></table>
            <div id="memberPhoneDecListPage"></div>
        </div>

    </t:putAttribute>
</t:insertDefinition>