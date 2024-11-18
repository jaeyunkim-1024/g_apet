<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<tr class="checkChange chkChgDetail <c:if test="${param.isDetail eq true}"> eduChg</c:if>">
	<td align="center">
		<c:choose>
			<c:when test="${param.isDetail eq true}">
				<input type="checkbox" class="idxChk"/><span class="idxArea">${param.stepNo}</span>
				<input type="hidden" name="stepNo" value="${param.stepNo}">
			</c:when>
			<c:otherwise>
				<input type="checkbox" class="idxChk"/><span class="idxArea"><c:out value='${idx}' default='1'/></span>
				<input type="hidden" name="stepNo" value="<c:out value='${idx}' default='1'/>">
			</c:otherwise>
		</c:choose>
	</td>
	<td>
		<c:choose>
			<c:when test="${param.isDetail eq true}">
				<!-- toUpdate -->
				<input type="hidden" name="stepPath" value="${param.phyPath}">
				<input type="hidden" name="stepSize" value="${param.flSz}">
				<input type="hidden" name="stepOutsideVdId" value="${param.outsideVdId}" data-encodedyn="<c:if test='${eduConts.detailList[0].outsideVdId ne ""}'>Y</c:if>">
				<input type="hidden" name="stepVdLnth" value="${param.vdLnth}">
				<input type="hidden" name="stepOrgFlNm" value="${param.orgFlNm}" />
				
				<!-- orgInfo -->
				<span class="orgFlNmArea">${param.orgFlNm}</span>
				<button type="button" onclick="window.location.href ='${param.phyPath}';" class="roundBtn" style="margin-bottom: 5px;">↓</button>
				<br/>
				<iframe src ="<spring:eval expression="@bizConfig['vod.player.api.url']" />/load/${param.outsideVdId}?v=1&vtype=mp4" frameborder="0" width="180px" height="105px"
				scrolling="no" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"	allowfullscreen>
				</iframe>
				<br/>
				<button type="button" onclick="$(this).next().find('input[name=stepUploadFile]').click();" class="btn">영상변경</button>
				<div style="display:none;">
					<input type="file" name="stepUploadFile" accept="video/mp4,video/x-m4v,video/*" onchange="vodUpload(this, resultVod);">
				</div>
				<button type="button" style="margin-left: 10px;" onclick="chkEncoding(this);" class="btn chkEncodingBtn step" disabled="disabled" >저장</button>
			</c:when>
			<c:otherwise>
				<input type="hidden" name="stepPath" value="">
				<input type="hidden" name="stepSize" value="">
				<input type="hidden" name="stepOutsideVdId" value="" data-encodedyn="">
				<input type="hidden" name="stepVdLnth" value="">
				<input type="text" name="stepOrgFlNm" class="readonly w155" readonly="readonly" title="<spring:message code="column.org_fl_nm"/>" value="" />
				<button type="button" onclick="$(this).next().find('input[name=stepUploadFile]').click();" class="btn">파일찾기</button>
				<div style="display:none;">
					<input type="file" name="stepUploadFile" accept="video/mp4,video/x-m4v,video/*" onchange="vodUpload(this, resultVod);">
				</div>
				<button type="button" style="margin-left: 20px;" onclick="chkEncoding(this);" class="btn chkEncodingBtn step" disabled="disabled" >저장</button>
			</c:otherwise>
		</c:choose>
	</td>
	<td>
		<div style="display: block;">
			<div style="width: 40px; display: inline-block;">
				<h3>타이틀</h3>
			</div>
			<div  style="display: inline-block;">
				<input type="text" name="stepTtl" class="w450 msg noHash" value="<c:out value="${param.ttl}" escapeXml="false" />" maxlength="30" title="<spring:message code="column.ttl"/>" placeholder="타이틀을 입력해 주세요."/>
				<div style="display: inline-block; width: 80px;">							
					<span>
						&nbsp;<span class="msgByte" style="color:#00B0F0;">0</span> / 30자
					 </span><br/>
				 </div>
			 </div>
		</div>
		<div style="display: block; padding-top: 3px;">				
			<div style="width: 40px; display: inline-block; vertical-align: top;">
				<h3>설&nbsp;&nbsp;명</h3>
			</div>
			<div style="display: inline-block; width: 95%;">
				<textarea  class="msg w800" style="float: left;" name="stepDscrt" title="<spring:message code="column.contents"/>" rows="5" maxlength="500" placeholder="상세 설명을 입력해 주세요."><c:out value="${param.dscrt}" escapeXml="false" /></textarea>
				<div style="margin-top: 85px; display: inline-block; width: 80px; vertical-align: bottom;">&nbsp;
					<span>
						&nbsp;<span class="msgByte" style="color:#00B0F0;">0</span> / 500자
					 </span>
				</div>
			</div>
		</div>						
	</td>
</tr>