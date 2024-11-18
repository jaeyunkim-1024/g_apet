<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>

<form id="emailLayerForm" name="emailLayerForm" method="post" >
					<table class="table_type1 popup">
						<caption>이메일 발송</caption>
						<colgroup>
							<col style="width:130px;" />
							<col />
						</colgroup>
						<tbody>
							<tr>
								<th scope="row"><spring:message code="column.rcvr_email" /><strong class="red">*</strong></th>
								<td>
									<div class="mListBox">
										<div class="listBox h100">
											<ul class="uiSelect">
											<c:forEach items="${listEmail}" var="item">
												<li>
													<span>
														<input type="hidden" name="nm" value="${item.receiverNm}">
														<input type="hidden" name="email" value="${item.receiverEmail}">
														<input type="hidden" name="mbrNo" value="${item.mbrNo}">
														<input type="hidden" name="stId" value="${item.stId}">
														<em>${item.receiverNm}</em>
														( ${item.receiverEmail} )
														<img src="/images/pop_blank_close.gif" class="emailDtlBtn" style="cursor:pointer;float:right;" alt="delete"/>
													</span>
												</li>
											</c:forEach>
											</ul>
										</div>
									</div>
								</td>
							</tr>
							<tr>
								<th scope="row"><spring:message code="column.ttl" /><strong class="red">*</strong></th>
								<td>
									<input type="text" class="validate[required]" style="width:97%" name="emailTitle" id="emailTitle" title="<spring:message code="column.ttl"/>" value="" maxlength="500"/>
								</td>
							</tr>
							<tr>
								<th scope="row"><spring:message code="column.content" /><strong class="red">*</strong></th>
								<td>
									<textarea class="validate[required]" style="width:97%" name="emailContent" id="emailContent" title="<spring:message code="column.content"/>" cols="35" rows="25"></textarea>
								</td>
							</tr>
						</tbody>
					</table>
</form>