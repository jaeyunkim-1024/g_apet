<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<jsp:include page="./include/replyCommonScript.jsp" />
		<script type="text/javascript">
			var gridRowId;
			var isInsertGb = true;
			var replyGbData;
			var setRowId;
			var addRowNo;
			var petLogAplySeq;
			
			$(document).ready(function(){
				petLogReplyListGrid('Y');
				
					//엔터키
		            $(document).on("keydown","#contsReplyListForm input",function(){
		      			if ( window.event.keyCode == 13 ) {
		      				searchReplyList();
		    		  	}
		            });					
			});
			
			// 펫로그 댓글 신고 상세
			function petLogReplyRptpDetailView(rowData) {
				petLogAplySeq = rowData.petLogAplySeq;
				var options = {
					url : "/petLogMgmt/popupPetLogDetail.do"
					, data : {
						petLogNo : rowData.petLogNo
						, contsStatCd : rowData.contsStatCd
						, snctYn : rowData.snctYn
						, loginId : rowData.loginId
						, aply : rowData.aply
						, replyRptpGb : "Y"
						, petLogAplySeq : rowData.petLogAplySeq
					}
					, dataType : "html"
					, callBack : function(data) {
						var config = {
							  id : "petLogDetail"
							, width : 980
							, height : 700
							, title : "펫로그 상세"
							, body : data
							, button : "<button type=\"button\" onclick=\"updateRptpReplyContsStat('"+rowData.contsStatCd+"');\" class=\"btn\" style=\"background-color:#0066CC; border-color:#0066CC;\">저장</button>"
						}
						layer.create(config);
					}
				}
				ajax.call(options);
			}
			
			// 신고된 댓글 노출 여부 수정
			function updateRptpReplyContsStat(contsStatCd) {
				var arrReplySeq = new Array();
				arrReplySeq.push(petLogAplySeq);
				
				if (contsStatCd == $("#goodsBatchUpdateForm input[name=detailContsStatCd]:checked").val()) {
					var options = {
							searchParam : $("#contsReplyListForm").serializeJson()
					};
					messager.alert("<spring:message code='column.display_view.message.save' />", "Info", "info", function() {
						grid.reload("contsReplyList", options);
						layer.close('petLogDetail');
					});
				} else {
					var sendData = {
						arrReplySeq : arrReplySeq
						, contsStatCd : $("#goodsBatchUpdateForm input[name=detailContsStatCd]:checked").val()
					}
					var options = {
						  url : "<spring:url value='/contents/updatePetLogReplyContsStat.do' />"
						, data : sendData
						, callBack : function(data) {
							messager.alert("<spring:message code='column.display_view.message.save' />", "Info", "info", function() {
								grid.reload("contsReplyList", options);
								layer.close('petLogDetail');
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