<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>

<c:set var="qnaCnt" value="0"/>
<c:forEach items="${eduConts.cnstrList}" var="qna" varStatus="idx">
	<c:if test="${qna.cstrtGbCd eq adminConstants.CSTRT_GB_20}">
		<tr class="checkChange chkChgConstruct eduChg">
			<td align="center">
				<c:set var="qnaCnt" value="${qnaCnt+1}"/>
				<input type="checkbox" class="idxChk"/><span class="idxArea"><c:out value="${qnaCnt}" /></span>						
			</td>
			<td>
				<div style="display: block;">
					<div style="width: 20px; display: inline-block;">
						<h3>Q</h3>
					</div>
					<div  style="display: inline-block;">
						<input type="text" name="qnaTtl" class="w450 msg" value="<c:out value="${qna.ttl}" />" maxlength="50" title="<spring:message code="column.ttl"/>" placeholder="Question 입력해 주세요."/>
						<div style="display: inline-block; width: 80px;">							
							<span>
								&nbsp;<span class="msgByte" style="color:#00B0F0;">0</span> / 50자
							 </span><br/>
						 </div>
					 </div>
				</div>
				<div style="display: block; padding-top: 3px;">				
					<div style="width: 20px; display: inline-block; vertical-align: top;">
						<h3>A</h3>
					</div>
					<div style="display: inline-block; width: 95%;">				
						<textarea class="msg w800" style="float: left;" name="qnaContent" title="<spring:message code="column.contents"/>" rows="5" maxlength="500" placeholder="Answer 입력해 주세요."><c:out value="${qna.content}"/></textarea>
						<div style="margin-top: 85px; display: inline-block; width: 80px; vertical-align: bottom;">&nbsp;
							<span>
								&nbsp;<span class="msgByte" style="color:#00B0F0;">0</span> / 500자
							 </span>
						</div>
					</div>
				</div>						
			</td>
		</tr>
	</c:if>
</c:forEach>
<c:if test="${qnaCnt == 0}">
	<tr class="checkChange chkChgConstruct">
		<td align="center">
			<input type="checkbox" class="idxChk"/><span class="idxArea"><c:out value='${idx}' default='1'/></span>
		</td>
		<td>
			<div style="display: block;">
				<div style="width: 20px; display: inline-block;">
					<h3>Q</h3>
				</div>
				<div  style="display: inline-block;">
					<input type="text" name="qnaTtl" class="w450 msg" value="" maxlength="50" title="<spring:message code="column.ttl"/>" placeholder="Question 입력해 주세요."/>
					<div style="display: inline-block; width: 80px;">							
						<span>
							&nbsp;<span class="msgByte" style="color:#00B0F0;">0</span> / 50자
						 </span><br/>
					 </div>
				 </div>
			</div>
			<div style="display: block; padding-top: 3px;">				
				<div style="width: 20px; display: inline-block; vertical-align: top;">
					<h3>A</h3>
				</div>
				<div style="display: inline-block; width: 95%;">				
					<textarea class="msg w800" style="float: left;" name="qnaContent" title="<spring:message code="column.contents"/>" rows="5" maxlength="500" placeholder="Answer 입력해 주세요."></textarea>
					<div style="margin-top: 85px; display: inline-block; width: 80px; vertical-align: bottom;">&nbsp;
						<span>
							&nbsp;<span class="msgByte" style="color:#00B0F0;">0</span> / 500자
						 </span>
					</div>
				</div>
			</div>						
		</td>
	</tr>
</c:if>
	