<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<jsp:include page="./include/replyCommonScript.jsp" />
		<script type="text/javascript">
			$(document).ready(function(){
				petLogReplyListGrid();
			});
		
			// 펫로그 댓글 상세 (운영자 답글 미지원 - 보류)
			/* function petLogReplyDetailView(mbrNo) {
				var options = {
					url : "/contents/popupReplyWrite.do"
					, dataType : "html"
					, callBack : function(data) {
						var btnTxt = "등록";
						if (data.contsReplyInfo != undefined) {
							btnTxt = "수정";
						}
						
						var config = {
							  id : "petLogReplyView"
							, width : 800
							, height : 300
							, title : "펫로그 댓글 쓰기"
							, body : data
							, button : "<button type=\"button\" onclick=\"savePetLogReply();\" class=\"btn btn-ok\">" + btnTxt + "</button>"
						}
						layer.create(config);
					}
				}
				ajax.call(options);
			} */
			
			// 펫로그 댓글 등록/수정
			function savePetLogReply() {
				if(validate.check("contsReplyDetailForm")) {
					var message = "<spring:message code='column.common.confirm.insert' />";
					var formData = $("#contsReplyDetailForm").serializeJson();

					var options = {
						url : "<spring:url value='/contents/savePetLogReply.do' />"
						, data : formData
						, callBack : function (data ) {
							messager.alert("<spring:message code='column.common.regist.final_msg' />","Info","info",function(){
								grid.reload("contsReplyList", options);
							});
						}
					};
					ajax.call(options);
				}
			}
		</script>
	</t:putAttribute>
	<t:putAttribute name="content">
		<jsp:include page="./include/replyCommonContent.jsp" />
	</t:putAttribute>
</t:insertDefinition>