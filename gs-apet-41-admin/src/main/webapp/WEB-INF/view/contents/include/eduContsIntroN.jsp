<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<!-- 
	교육용 구성
-->
<div class="mTitle"  style="margin-top: 30px;">
	<h2>교육구성<strong class="red">*</strong></h2>
</div>
<table class="table_type1" id="step">
	<colgroup>
		<col style= "width:80px; border:1px solid #dadada;"/>
		<col style= "width:200px; border:1px solid #dadada;"/>
		<col style= "border:1px solid #dadada;"/>
	</colgroup>
	<caption>교육 구성</caption>
	<tbody>
		<tr align="center";  style="background-color: #f2f2f2">			
			<td>단계</td>
			<td>영상</td>
			<td>내용</td>
		</tr>
		<tr class="chkChgDetail chkChgContents" id="cmpltStep">			
			<td align="center">완료</td>
			<input type="hidden" name="stepNo" value="0">
			<c:choose>
				<c:when test="${!empty eduConts.detailList}">
					<td>
						<!-- toUpdate -->
						<input type="hidden" name="stepPath" value="${eduConts.detailList[0].phyPath}">
						<input type="hidden" name="stepSize" value="${eduConts.detailList[0].flSz}">
						<input type="hidden" name="stepOutsideVdId" value="${eduConts.detailList[0].outsideVdId}" data-encodedyn="<c:if test='${eduConts.detailList[0].outsideVdId ne ""}'>Y</c:if>">
						<input type="hidden" name="stepVdLnth" value="${eduConts.detailList[0].vdLnth}">
						<input type="hidden" name="stepOrgFlNm" class="readonly w155" value="${eduConts.detailList[0].orgFlNm}" />
						
						<!-- orgInfo -->
						<span class="orgFlNmArea">${eduConts.detailList[0].orgFlNm}</span>
						<button type="button" onclick="window.location.href ='${eduConts.detailList[0].phyPath}';" class="roundBtn" style="margin-bottom: 5px;">↓</button>
						<br/>
						<iframe src ="<spring:eval expression="@bizConfig['vod.player.api.url']" />/load/${eduConts.detailList[0].outsideVdId}?v=1&vtype=mp4" frameborder="0" width="180px" height="105px"
						scrolling="no" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"	allowfullscreen>
						</iframe>
						<br/>
						<button type="button" onclick="$(this).next().find('input[name=stepUploadFile]').click();" class="btn">영상변경</button>
						<div style="display:none;">
							<input type="file" name="stepUploadFile" accept="video/mp4,video/x-m4v,video/*" onchange="vodUpload(this, resultVod);" class="cmpltStep">
						</div>
						<button type="button" style="margin-left: 10px;" onclick="chkEncoding(this);" class="btn chkEncodingBtn step" disabled="disabled" >저장</button>
					</td>
				</c:when>
				<c:otherwise>
					<td>
						<input type="hidden" name="stepPath" value="">
						<input type="hidden" name="stepSize" value="">
						<input type="hidden" name="stepOutsideVdId" value="" data-encodedyn="">
						<input type="hidden" name="stepVdLnth" value="">
						<input type="text" name="stepOrgFlNm" class="readonly w155" readonly="readonly" title="<spring:message code="column.org_fl_nm"/>" value="" />
						<button type="button" onclick="$(this).next().find('input[name=stepUploadFile]').click();" class="btn">파일찾기</button>
						<div style="display:none;">
							<input type="file" name="stepUploadFile" accept="video/mp4,video/x-m4v,video/*" onchange="vodUpload(this, resultVod);"  class="cmpltStep">
						</div>
						<button type="button" style="margin-left: 20px;" onclick="chkEncoding(this);" class="btn chkEncodingBtn step" disabled="disabled" >저장</button>
					</td>
				</c:otherwise>
			</c:choose>
			
			<td>
				<input type="hidden" name="stepTtl" value="완료">
				<input type="hidden" name="stepDscrt" value="미사용">
				<textarea class="msg w800" style="float: left;" name="content" title="<spring:message code="column.contents"/>" rows="5" maxlength="500" placeholder="교육 내용을 입력해 주세요."><c:out value="${eduConts.content}" escapeXml="false" /></textarea>
				<div style="margin-top: 85px; display: inline-block; width: 80px;">&nbsp;
					<span>
						&nbsp;<span class="msgByte" style="color:#00B0F0;">&nbsp;0</span> / 500자
					 </span>
				</div>
			</td>
		</tr>
		<c:choose>
			<c:when test="${!empty eduConts.detailList}">
				<c:forEach items="${eduConts.detailList}" var="detail">
					<c:if test="${detail.stepNo ne 0}">				
						<jsp:include page="/WEB-INF/view/contents/include/eduContsIntroNStep.jsp">
							<jsp:param name="isDetail" 		value="true"/>
							<jsp:param name="stepNo" 		value="${detail.stepNo}"/>
							<jsp:param name="phyPath" 		value="${detail.phyPath}"/>
							<jsp:param name="outsideVdId" 	value="${detail.outsideVdId}"/>
							<jsp:param name="vdLnth" 		value="${detail.vdLnth}"/>
							<jsp:param name="flSz" 			value="${detail.flSz}"/>
							<jsp:param name="orgFlNm" 		value="${detail.orgFlNm}"/>
							<jsp:param name="ttl" 			value="${detail.ttl}"/>
							<jsp:param name="dscrt" 		value="${detail.dscrt}"/>
						</jsp:include>
					</c:if>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<jsp:include page="/WEB-INF/view/contents/include/eduContsIntroNStep.jsp"/>
			</c:otherwise>
		</c:choose>
	</tbody>
</table>
<div class="" style="margin-top: 3px;">
	<button type="button" onclick="changeStep(false);" class="btn" >- 선택한 단계 삭제</button>
	<button type="button" onclick="changeStep(true);" class="btn" style="position:absolute; right:0; margin-right:20px;">+ 입력란 추가</button>
</div>

<!-- 
	Tip
-->
<div class="mTitle" style="margin-top: 30px;">
	<h2>Tip</h2>
	<div class="buttonArea">
		<button type="button" onclick="preview.tip();" class="btn">Tip 미리보기</button>
	</div>
</div>
<table class="table_type1">
	<caption>Tip</caption>
	<tbody>
		<tr class="chkChgConstruct">
			<td>
				<c:set var="tipCnt" value="0"/>
				<c:forEach items="${eduConts.cnstrList}" var="tip" varStatus="idx" >
					<c:if test="${tip.cstrtGbCd eq adminConstants.CSTRT_GB_10}">
						<textarea class="msg"  name="tipContent" style="float: left; width: 98.5%" title="<spring:message code="column.contents"/>" rows="5" maxlength="500" placeholder="Tip을 입력해 주세요."><c:out value="${tip.content}"/></textarea>
						<c:set var="tipCnt" value="${tipCnt+1}"/>
					</c:if>
				</c:forEach>
				<c:if test="${tipCnt == 0}">
					<textarea class="msg"  name="tipContent" style="float: left; width: 98.5%" title="<spring:message code="column.contents"/>" rows="5" maxlength="500" placeholder="Tip을 입력해 주세요."></textarea>
				</c:if>
			</td>
		</tr>				
	</tbody>
</table>

<!-- 
	QnA
-->
<div class="mTitle" style="margin-top: 30px;" >
	<h2>QnA</h2>
	<div class="buttonArea">
		<button type="button" onclick="preview.qna();" class="btn">QnA 미리보기</button>
	</div>
</div>
<table class="table_type1" id="qna">
	<colgroup>
		<col style= "width:80px; border:1px solid #dadada;"/>
		<col style= "border:1px solid #dadada;"/>
	</colgroup>
	<caption>QnA</caption>
	<tbody>
		<jsp:include page="/WEB-INF/view/contents/include/eduContsIntroNQna.jsp"/>
	</tbody>
</table>
<div class="" style="margin-top: 3px;">
	<button type="button" onclick="changeQna(false);" class="btn" >- 선택한 QnA 삭제</button>
	<button type="button" onclick="changeQna(true);" class="btn" style="position:absolute; right:0; margin-right:20px;">+ QnA 추가</button>
</div>