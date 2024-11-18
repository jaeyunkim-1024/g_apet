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
			
			$(document).ready(function(){
				apetReplyListGrid();
				
				//엔터키 	
				$(document).on("keydown","#contsReplyListForm input",function(){
	    			if ( window.event.keyCode == 13 ) {
		    			searchReplyList();
	  		  		}
	            });
				
			});
			
			// 펫TV 댓글 상세
			function apetReplyDetailView(seq, loginId, rpl) {
				var options = {
					url : "/contents/popupReplyWrite.do"
					, data : {
						aplySeq : seq
						, loginId : loginId
					}
					, dataType : "html"
					, callBack : function(data) {
						var btnStr;
						var btnTxt = "등록";
						btnStr = "<button type=\"button\" onclick=\"saveApetReply();\" class=\"btn\" style=\"background-color:#0066CC; border-color:#0066CC;\">" + btnTxt + "</button>";
						isInsertGb = true;
						if (rpl) {
							btnTxt = "수정";
							btnStr = "<button type=\"button\" onclick=\"saveApetReply();\" class=\"btn\" style=\"background-color:#0066CC; border-color:#0066CC;\">" + btnTxt + "</button>"
							btnStr += "<button type=\"button\" onclick=\"deleteApetReply();\" class=\"btn btn-ok ml10\">삭제</button>";
							isInsertGb = false;
						}
						var config = {
							  id : "apetReplyViewPop"
							, width : 800
							, height : 410
							, title : "펫TV 댓글 쓰기"
							, body : data
							, button : btnStr
						}
						layer.create(config);
					}
				}
				ajax.call(options);
			}
			
			// 펫TV 댓글 등록/수정
			function saveApetReply() {
				if(validate.check("contsReplyDetailForm")) {
					var message = "<spring:message code='column.common.regist.final_msg' />";
					var formData = $("#contsReplyDetailForm").serializeJson();
					
					if (formData.rplGb) {
						message = "<spring:message code='column.common.edit.final_msg' />"
					}
					
					var options = {
						url : "<spring:url value='/contents/saveApetReply.do' />"
						, data : formData
						, callBack : function (data) {
							var selectData = {
								aply : data.contentsReplyPO.rpl
								, rpl : data.contentsReplyPO.rpl
								, aplySeq : data.contentsReplyPO.aplySeq
								, contsStatCd : data.contentsReplyPO.contsStatCd
								, loginId : data.contentsReplyPO.loginId
								, replyRegrNm : "${adminSession.usrNm}"
								, replyGb : "R"
								, sysRegDtm : data.contentsReplyPO.rplRegDtm != null ? data.contentsReplyPO.rplRegDtm : new Date().format("yyyy-MM-dd HH:mm:ss")
								, sysUpdDtm : new Date().format("yyyy-MM-dd HH:mm:ss")
							}
							
							messager.alert(message,"Info","info",function(){
								layer.close("apetReplyViewPop");
								addGridRow("#contsReplyList", selectData);
							});
						}
					};
					ajax.call(options);
				}
			}
			
			// 펫TV 운영자 댓글 삭제
			function deleteApetReply() {
				var formData = $("#contsReplyDetailForm").serializeJson();
				
				var options = {
					url : "<spring:url value='/contents/deleteApetReply.do' />"
					, data : formData
					, callBack : function (data) {
						var selectData = {
							aply : data.contentsReplyPO.rpl
							, rpl : data.contentsReplyPO.rpl
							, aplySeq : data.contentsReplyPO.aplySeq
							, contsStatCd : data.contentsReplyPO.contsStatCd
							, loginId : data.contentsReplyPO.loginId
							, replyRegrNm : "${adminSession.usrNm}"
							, replyGb : "R"
							, sysRegDtm : data.contentsReplyPO.rplRegDtm != null ? data.contentsReplyPO.rplRegDtm : new Date().format("yyyy-MM-dd HH:mm:ss")
							, sysUpdDtm : new Date().format("yyyy-MM-dd HH:mm:ss")
						}
						
						messager.alert("삭제 되었습니다.","Info","info",function(){
							layer.close("apetReplyViewPop");
							var updateRowId = $("#contsReplyList tr[id="+gridRowId+"]").next("tr").attr("id");
							setRowId = gridRowId;
							if (replyGbData == "R") {
								updateRowId = gridRowId;
								setRowId = $("#contsReplyList tr[id="+gridRowId+"]").prev("tr").attr("id");
							}
							$("#contsReplyList").jqGrid("delRowData",updateRowId);
							$("#contsReplyList").jqGrid("setCell",setRowId,"rpl","&nbsp;");
							$("#contsReplyList").jqGrid("setCell",setRowId,"rplRegDtm","&nbsp;");
							$("#contsReplyList").jqGrid("setCell",setRowId,"rplUpdDtm","&nbsp;");
						});
					}
				};
				ajax.call(options);
			}
		</script>
	</t:putAttribute>
	<t:putAttribute name="content">
		<jsp:include page="./include/replyCommonContent.jsp" />
	</t:putAttribute>
</t:insertDefinition>