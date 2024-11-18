<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>

<form id="smsLayerForm" name="smsLayerForm" method="post" >
					<table class="table_type1 popup">
						<caption>SMS 발송</caption>
						<tbody>
							<tr>
								<th scope="row"><spring:message code="column.rcvr_no" /><strong class="red">*</strong></th>
								<td>
									<div class="mListBox">
										<div class="listBox w250 h100">
											<ul class="uiSelect">
											<c:forEach items="${listSms}" var="item">
												<li>
													<span>
														<input type="hidden" name="receiveName" value="${item.receiveName}">
														<input type="hidden" name="receivePhone" value="${item.receivePhone}">
														<em>${item.receiveName}</em>
														( ${item.receivePhone} )
														<img src="/images/pop_blank_close.gif" class="smsDtlBtn" style="cursor:pointer;float:right;" alt="delete"/>
													</span>
												</li>
											</c:forEach>
											</ul>
										</div>
									</div>
								</td>
							</tr>
							<tr>
								<th scope="row"><spring:message code="column.content" /><strong class="red">*</strong></th>
								<td>
									<textarea class="validate[required]" name="msg" id="msg" title="<spring:message code="column.cp_dscrt"/>" cols="35" rows="5" style="width:230px;"></textarea>
									<div><span id="msgByteHtml">
											<span id="msgByte">0</span> / 80 Byte
										 </span>
										 <span id="mmsHtml" style='display: none;'>mms</span>
									</div>
								</td>
							</tr>
							<tr>
								<th scope="row"><spring:message code="column.snd_no" /></th>
								<td> <!-- class="phoneNumber validate[custom[tel]]" -->
									<%-- <input type="text" name="sndNo" id="sndNo" title="<spring:message code="column.snd_no"/>" value="02-512-5293" readonly="readonly"/> --%>
									<select id="sndNo" name="sndNo">
										<c:forEach items="${StStdInfoVOList}" var="StStdInfoVO" >
											<option value="${StStdInfoVO.csTelNo}"  title="${StStdInfoVO.stNm}">${StStdInfoVO.csTelNo}</option> 
										</c:forEach>
									</select>
					
									
								</td>
							</tr>
						</tbody>
					</table>
</form>