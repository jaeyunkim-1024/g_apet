<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">

			$(document).ready(function(){
				<c:if test="${counsel.eqrrMbrNo ne adminConstants.NO_MEMBER_NO and layout ne 'popupLayout'}">
				counselListGrid();
				</c:if>
			});

			// 머리말/맺음말 유형 변경
			$(document).on("change", "#replType", function(e) {
				// 머리말/맺음말 유형
				<c:forEach var="item" items="${frame:listCode(adminConstants.REPLY_TYPE_TP)}">
				if('${item.dtlCd}' == $("#replType").val()) {
					$("#rplHdContent").val('${item.usrDfn1Val}');
					$("#rplFtContent").val('${item.usrDfn2Val}');
				}
				</c:forEach>
				if('' == $("#replType").val()) {
					$("#rplHdContent").val('');
					$("#rplFtContent").val('');
				}

			});

			$(function() {

				// CS 카테고리 2 선택
				$("#counselCusCtg2Cd").bind ("change", function () {
					var selectVal = $(this).children("option:selected").val();

					//					alert(selectVal);
					if ( selectVal == "" ) {
						$("#counselCusCtg3Cd").html ('');
						return;
					}

					// 분류
					config = {
						grpCd : '${adminConstants.CUS_CTG3 }'
						, usrDfn1Val : selectVal
						, defaultName : '선택'
						, showValue : false
						, callBack : function(html) {
							$("#counselCusCtg3Cd").html ('');
							$("#counselCusCtg3Cd").append (html);

							if($("#counselAcceptCusCtg3Cd option").size() > 1 ) {
								objClass.add ($("#counselCusCtg3Cd"), "validate[required]" );
							} else {
								objClass.remove ($("#counselCusCtg3Cd"), "validate[required]" );
							}
						}
					};
					codeAjax.select(config);

				});
			});

			// 답변 저장
			function counselProcessSave() {
				var cttLength = $("#rplContent").val().length;

				if(cttLength <= 0) {
					messager.alert("<spring:message code='column.cus_content_regist' />", "info", "info");
					return;
				}
				messager.confirm("<spring:message code='column.common.confirm.insert' />",function(r){
					if(r){
						var options = {
							url : "<spring:url value='/counsel/web/insertCounselProcess.do' />"
							, data : $("#counselProcessForm").serializeJson()
							, callBack : function(data) {
								messager.alert("<spring:message code='admin.web.view.msg.counsel.web.regist' />","Info","info",function(){
									var url = '/counsel/web/counselWebView.do?cusNo=' + '${counsel.cusNo}' + '&viewGb=' + '${viewGb}';
									updateTab(url);
								});
							}
						};

						ajax.call(options);
					}
				});
			}

			// 파일 다운로드
			function fileDownload(filePath, fileName){
				var data = {
					filePath : filePath
					, fileName : fileName
					, imgYn : 'Y'
				}
				createFormSubmit("fileDownload", "/common/fileDownloadResult.do", data);
			}


			// 파일 다운로드
			/* function fileDownload(){
				var fileLength = $(".mg5").length;
				
				for(var i = 0; i < fileLength; i++) {
					var filePath = $(".mg5").eq(i).children('input[name=phyPath]').val();
					var fileName = $(".mg5").eq(i).children('input[name=orgFlNm]').val();
					var imgYn = "Y"
					
					var data = {
							  filePath : filePath
							, fileName : fileName
							, imgYn : imgYn
					}
					
					$("#counselForm").ajaxForm({
						url : "/common/fileDownloadResult.do",
						data : data,
						enctype : "multipart/form-data",
				        dataType : "json",
				        success : function(result) {
				        	console.log("다운로드 성공!!");
				        }, 
				        error : function(result) {
				        	console.log("파일다운로드 실패")
				        }
					});
					$("#counselForm").submit();
				}
			} */



			// 회원상세
			function fnMemberDetailView() {
				addTab('회원 상세', '/member/memberView.do?mbrNo=' + '${counsel.eqrrMbrNo}' + "&viewGb=" + '${adminConstants.VIEW_GB_POP}');
			}

			// 주문상세
			function fnOrderDetailView(ordNo) {
				addTab('주문 상세', '/cs/orderDetailView.do?ordNo=' + ordNo + "&viewGb=" + '${adminConstants.VIEW_GB_POP}');
			}

			<c:if test="${counsel.eqrrMbrNo ne adminConstants.NO_MEMBER_NO and layout ne 'popupLayout'}">
			function counselListGrid(){

				var options = {
					url : "<spring:url value='/counsel/web/counselWebListGrid.do' />"
					, height : 250
					, searchParam :  {mbrNo    : <c:out value="${counsel.eqrrMbrNo}" /> }
					, colModels : [
						//상담 번호
						{name:"cusNo", label:'<b><u><tt><spring:message code="column.cus_no" /></tt></u></b>', width:"80", align:"center", formatter:'integer', classes:'pointer fontbold'}
						//상담 상태 코드
						, {name:"cusStatCd", label:'<spring:message code="column.cus_stat_cd" />', width:"70", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.CUS_STAT}" />"}}
						//상담 접수 일시
						, {name:"cusAcptDtm", label:'<b><u><tt><spring:message code="column.cus_acpt_dtm" /></tt></u></b>', width:"130", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss", classes:'pointer fontbold'}
						// 상담 카테고리1 코드
						, {name:"cusCtg1Cd", label:'<spring:message code="column.cus_ctg1_cd" />', width:"100", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.CUS_CTG1}" />"}}
						// 상담 카테고리2 코드
						, {name:"cusCtg2Cd", label:'<spring:message code="column.cus_ctg2_cd" />', width:"100", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.CUS_CTG2}" />"}}
						// 상담 카테고리3 코드
						, {name:"cusCtg3Cd", label:'<spring:message code="column.cus_ctg3_cd" />', width:"100", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.CUS_CTG3}" />"}}
						//제목
						, {name:"ttl", label:'<b><u><tt><spring:message code="column.ttl" /></tt></u></b>', width:"400", align:"left", classes:'pointer fontbold'}
						//상담 취소자
						, {name:"cusCncrNm", label:'<spring:message code="column.cus_cncr_nm" />', width:"100", align:"center"}
						//상담 취소 일시
						, {name:"cusCncDtm", label:'<spring:message code="column.cus_cnc_dtm" />', width:"130", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss"}
						//상담 완료자
						, {name:"cusCpltrNm", label:'<spring:message code="column.cus_cpltr_nm" />', width:"100", align:"center"}
						//상담 완료 일시
						, {name:"cusCpltDtm", label:'<spring:message code="column.cus_cplt_dtm" />', width:"130", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss"}
					]

					, onSelectRow : function(ids) {
						var rowdata = $("#counselList").getRowData(ids);

						counselView(rowdata.cusNo);
					}
				};
				grid.create("counselList", options);
			}

			function counselView(cusNo){
				addTab('1:1 문의 상세 - ' + cusNo, '/counsel/web/counselWebView.do?cusNo=' + cusNo);
			}
			</c:if>

			function updateCounsel(){
				var cttLength = $("#rplContent").val().length;

				if(cttLength <= 0) {
					messager.alert("<spring:message code='column.cus_content_regist' />", "info", "info");
					return;
				}

				messager.confirm("<spring:message code='column.common.confirm.update' />",function(r){
					if(r){
						var options = {
							url : "<spring:url value='/counsel/web/updateCounsel.do' />"
							, data : $("#counselProcessForm").serializeJson()
							, callBack : function(data) {
								messager.alert("<spring:message code='admin.web.view.msg.counsel.web.changed' />","Info","info");
								var url = '/counsel/web/counselWebView.do?cusNo=' + '${counsel.cusNo}' + '&viewGb=' + '${viewGb}';
								updateTab(url);
							}
						};

						ajax.call(options);
					}
				});
			}

		</script>
	</t:putAttribute>
	<t:putAttribute name="content">
		<style>
			.file-a-ul{text-decoration: underline;cursor: pointer;text-align: center;color: #0070c0;margin-left:2%;}
		</style>

		<form id="hiddenForm" name="hiddenForm" style="display:none;">
			<c:forEach var="file" items="${counselFileList}">
				<input type="hidden" name="fileNm" title="<spring:message code="column.org_fl_nm"/>" value="${file.orgFlNm}" />
				<input type="hidden" name="filePath" title="<spring:message code="column.phy_path"/>" value="${file.phyPath}" />
			</c:forEach>
			<input type="hidden" name="${adminConstants.FILE_LIST_CNT}" value="${fn:length(counselFileList)}" />
		</form>

		<form id="counselForm" name="counselForm">
			<input type="hidden" id="cusNo" name="cusNo" value="${counsel.cusNo}" />
			<table class="table_type1">
				<caption>1:1문의 내용</caption>
				<tbody>
				<tr>
					<th scope="row"><spring:message code="column.cus_no" /></th>
					<td>
							${counsel.cusNo}
					</td>
					<th scope="row"><spring:message code="column.cus_stat_cd" /></th>
					<td>
						<frame:codeName grpCd="${adminConstants.CUS_STAT}" dtlCd="${counsel.cusStatCd}"/>
					</td>
				</tr>
				<tr>
					<th scope="row"><spring:message code="column.eqrr_nm" /></th>
					<td>
							${counsel.eqrrNm}&nbsp;${counsel.loginId}
					</td>
					<th scope="row"><spring:message code="column.cus_acpt_dtm" /></th>
					<td>
							${counsel.cusAcptDtm}
					</td>
				</tr>
				<tr>
					<th scope="row"><spring:message code="column.content" /></th>
					<td colspan="3" style="height:100px;" >
						<div style="max-height:200px;overflow:auto;margin-top:5px;margin-bottom:5px;">
								${counsel.content}
						</div>
					</td>
				</tr>
				<tr>
					<th scope="row"><spring:message code="column.fl_no" /></th>
					<td colspan="3" style="vertical-align:middle;">
						<c:if test="${not empty counselFileList}">
							<!-- 파일 번호-->
							<div>
								<c:forEach var="file" items="${counselFileList}">
									<span class="file-a-ul" onclick="fileDownload('${file.phyPath}','${file.orgFlNm}');">${file.orgFlNm}</span>
								</c:forEach>
								<button type="button" onclick="fileAllDownload('hiddenForm');" class="btn btn-add" style="float:right;"> 일괄 다운로드 </button>
							</div>
						</c:if>
						<c:if test="${empty counselFileList}">
							첨부 파일이 없습니다.
						</c:if>
					</td>
				</tr>
				</tbody>
			</table>
		</form>

		<div class="mTitle mt30">
			<h2>1:1 문의 답변</h2>
		</div>
		<form id="counselProcessForm" name="counselProcessForm" method="post">
			<input type="hidden" id="eqrrMbrNo" name="eqrrMbrNo" value="${counsel.eqrrMbrNo }" />
			<input type="hidden" id="pstAgrYn" name="pstAgrYn" value="${counsel.pstAgrYn }" />
			<input type="hidden" id="cusNo" name="cusNo" value="${counsel.cusNo}" />
			<input type="hidden" id="infoRcvYn" name="infoRcvYn" value="${counsel.infoRcvYn}" />
			<table class="table_type1">
				<caption>1:1 문의 답변</caption>
				<colgroup>
					<col style="width:170px;">
					<col />
					<col style="width:170px;">
					<col />
				</colgroup>
				<tbody>
				<c:if test="${empty counselProcessList}">
					<tr>
						<th><spring:message code='column.rpl_content' /><strong class="red">*</strong></th>
						<td colspan="3">
							<div style="max-height:120px;overflow:auto;">
								<textarea id="rplContent" name="rplContent" style="width:97%; height:97px;" ></textarea>
							</div>
						</td>
					</tr>
				</c:if>
				<c:if test="${not empty counselProcessList}">
					<c:forEach items="${counselProcessList}" var="counselProcess">
						<tr>
							<th><spring:message code='column.rpl_content' /><strong class="red">*</strong></th>
							<td colspan="3">
								<div style="max-height:120px;overflow:auto;">
									<textarea id="rplContent" name="rplContent" style="width:97%; height:97px;" >${counselProcess.rplContent }</textarea>
								</div>
							</td>
						</tr>
						<%-- <tr>
                            <th><spring:message code='column.prcs_content' /></th>
                            <td colspan="3">
                                ${counselProcess.prcsContent}
                            </td>
                        </tr> --%>
						<tr>
							<th scope="row"><spring:message code='column.cus_prcsr_nm' /></th>
							<td>
									${counselProcess.cusPrcsrNm}
							</td>
							<th scope="row"><spring:message code='column.cus_prcs_dtm' /></th>
							<td>
								<fmt:formatDate value="${counselProcess.cusPrcsDtm}" pattern="yyyy-MM-dd HH:mm:ss"/>
							</td>
						</tr>
					</c:forEach>
				</c:if>
				</tbody>
			</table>
		</form>

		<c:if test="${counsel.cusStatCd eq adminConstants.CUS_STAT_10}">
			<div class="btn_area_center">
				<button type="button" onclick="counselProcessSave();" class="btn btn-add">저장</button>
				<button type="button" onclick="closeTab()" class="btn btn-cancel">닫기</button>
			</div>
		</c:if>

		<c:if test="${counsel.cusStatCd eq adminConstants.CUS_STAT_20}">
			<div class="btn_area_center">
				<button type="button" onclick="updateCounsel();" class="btn btn-ok">수정</button>
				<button type="button" onclick="closeTab()" class="btn btn-cancel">닫기</button>
			</div>
		</c:if>
		<%-- <table class="table_type1">
			<caption>1:1 문의 답변 등록</caption>
			<tbody>
				<tr>
					<th scope="row" rowspan="4"><spring:message code='column.rpl_content' /></th>
					<td>
						<select name="replType" id="replType" title="<spring:message code="column.disp_yn"/>" >
							<frame:select grpCd="${adminConstants.REPLY_TYPE_TP}" defaultName="머리말/맺음말 유형"/>
						</select>
					</td>
				</tr>
				<tr>
					<td style="border-bottom:none;" >
						<input type="text" class="w500 readonly" name="rplHdContent" id="rplHdContent" title="<spring:message code="column.rpl_hd_content"/>" value="" />
					</td>
				</tr>
				<tr>
					<td style="border-bottom:none;" >
						<textarea rows="3" class="w500 validate[required]" id="rplContent" name="rplContent" ></textarea>
					</td>
				</tr>
				<tr>
					<td>
						<input type="text" class="w500 readonly mt5" name="rplFtContent" id="rplFtContent" title="<spring:message code="column.rpl_ft_content"/>" value="" />
					</td>						
				</tr>
				<tr>
					<th><spring:message code='column.prcs_content' /></th>
					<td>
						<textarea rows="3" class="w500" id="prcsContent" name="prcsContent" ></textarea>
					</td>
				</tr>						
			</tbody>
		</table> --%>

		<%-- <c:if test="${counsel.eqrrMbrNo ne adminConstants.NO_MEMBER_NO and layout ne 'popupLayout'}">

		<div class="mTitle mt30">
			<h2>회원의 CS 1:1 문의 목록</h2>
		</div>
		<div class="mModule no_m">
			<table id="counselList" ></table>
			<div id="counselListPage"></div>
		</div>
		</c:if> --%>

	</t:putAttribute>
</t:insertDefinition>