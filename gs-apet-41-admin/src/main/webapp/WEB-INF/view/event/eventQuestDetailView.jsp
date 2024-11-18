<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>

							

<form id="eventQuestionForm" name="eventQuestionForm" method="post" >
	<input type="hidden" id="eventNo" name="eventNo" value="${eventQuestion.eventNo }" />
	<input type="hidden" id="qstNo" name="qstNo" value="${eventQuestion.qstNo }" />
							<table class="table_type1">
								<caption>질문 등록</caption>
								<colgroup>
									<col style="width:100px;" />
									<col />
								</colgroup>
								<tbody>
									<tr>
										<th><spring:message code="column.qst_nm" /><strong class="red">*</strong></th>
										<td>
											<input type="text" class="w300 validate[required]" name="qstNm" id="qstNm" title="<spring:message code="column.qst_nm" />" value="${eventQuestion.qstNm }" />
										</td>
									</tr>
									<tr>
										<th><spring:message code="column.dlgt_img" /><strong class="red">*</strong></th>
										<td>
											<div class="inner">
												<input type="hidden" name="qstImgPath" id="qstImgPath" value="" />
												<input type="hidden" name="qstImgPathDel" id="qstImgPathDel" value="" />
												<c:if test="${eventQuestion.qstImgPath ne null && eventQuestion.qstImgPath ne '' }">
												<img id="qstImgPathView" name="qstImgPathView" src="<frame:imgUrl/>${eventQuestion.qstImgPath}" class="thumb" alt="" />
												</c:if>
												<c:if test="${eventQuestion.qstImgPath eq null || eventQuestion.qstImgPath eq '' }">
												<img id="qstImgPathView" name="qstImgPathView" src="/images/noimage.png" class="thumb" alt="" />
												</c:if>
											</div>
											<div id="pushImg" class="inner ml10" style="vertical-align:bottom">
												<button type="button" onclick="fileUpload.goodsImage(resultImage, 'qstImgPath');" class="btn">검색</button>
												<button type="button" onclick="deleteImage('qstImgPath');" class="btn">삭제</button>
											</div>
										</td>
									</tr>
								</tbody>
							</table>
</form>


<div class="mButton typeBorad">
								<div class="btn_area_center">
									<button type="button" onclick="resetQuestion();" class="btn btn-cancel">신규</button>
<c:if test="${eventQuestion ne null }">
									<button type="button" onclick="updateQuestion(${eventQuestion.qstNo });" class="btn btn-ok">수정</button>
									<button type="button" onclick="deleteQuestion(${eventQuestion.qstNo });" class="btn btn-add">삭제</button>
</c:if>
<c:if test="${eventQuestion eq null }">
									<button type="button" onclick="insertQuestion();" class="btn btn-ok">등록</button>
</c:if>
								</div>
							</div>