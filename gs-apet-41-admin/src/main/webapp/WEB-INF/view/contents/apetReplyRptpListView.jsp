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
				apetReplyListGrid('Y');
				
				//엔터키 	
				$(document).on("keydown","#contsReplyListForm input",function(){
	    			if ( window.event.keyCode == 13 ) {
		    			searchReplyList();
	  		  		}
	            });
			});
			
			// 펫TV 댓글 신고 상세
			function apetReplyRptpDetailView(seq, loginId, rpl) {
				var options = {
					url : "/contents/apetReplyRptpDetailView.do"
					, data : {
						aplySeq : seq
						, loginId : loginId
					}
					, dataType : "html"
					, callBack : function(data) {
						var config = {
							  id : "apetReplyRptpDetailViewPop"
							, width : 800
							, height : 650
							, title : "펫TV 댓글 신고 상세"
							, body : data
							, button : "<button type=\"button\" onclick=\"updateRptpReplyContsStat();\" class=\"btn\" style=\"background-color:#0066CC; border-color:#0066CC;\">저장</button>"
						}
						layer.create(config);
					}
				}
				ajax.call(options);
			}
		</script>
	</t:putAttribute>
	<t:putAttribute name="content">
		<jsp:include page="./include/replyCommonContent.jsp" />
	</t:putAttribute>
</t:insertDefinition>