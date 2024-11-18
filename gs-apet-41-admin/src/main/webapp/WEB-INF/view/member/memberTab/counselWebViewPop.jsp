<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
	<script type="text/javascript">
		// 파일 다운로드
		function fileDownload(filePath, fileName){
			var data = {
				  filePath : filePath
				, fileName : fileName
				, imgYn : 'Y'
			}
			createFormSubmit("fileDownload", "/common/fileDownloadResult.do", data);
		}
		
	</script>
		
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
						<td colspan="3">
						<c:if test="${not empty counselFileList}">
						<!-- 파일 번호-->
							<c:forEach var="file" items="${counselFileList}">
								<div class="mg5" style="float:left; padding:5px;">
									${file.orgFlNm}
									<input type="hidden" class="readonly" readonly="readonly" name="orgFlNm" title="<spring:message code="column.org_fl_nm"/>" value="${file.orgFlNm}" />
									<input type="hidden" class="readonly" readonly="readonly" name="phyPath" title="<spring:message code="column.phy_path"/>" value="${file.phyPath}" />
									<button type="button" onclick="fileDownload('${file.phyPath}', '${file.orgFlNm}');" class="btn">다운로드</button>
								</div>
							</c:forEach>
							<!-- <div class="mButton">
								<div class="rightInner">
									<button type="button" onclick="fileDownload();" class="btn btn-add"> 일괄 다운로드 </button>
								</div>
							</div> -->
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
							<textarea id="rplContent" name="rplContent" style="width:97%; height:97px;" disabled="disabled" ></textarea>
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
							<textarea id="rplContent" name="rplContent" style="width:97%; height:97px;" disabled="disabled">${counselProcess.rplContent }</textarea>
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
