<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
		<script type="text/javascript">
			$(document).ready(function(){
				 
				initEditor ();
				 
 			});
			function initEditor () {
				EditorCommon.setSEditor('content', '${adminConstants.USER_MESSAGE_IMAGE_PTH}');
			}
			// 메세지보내기
			function fnMessageSend(){
				if(validate.check("userMessageViewForm")) {
					var arrUsrNo =  $("#arrUsrNo").val();
					if(arrUsrNo ==''){
						messager.alert('<spring:message code="admin.web.view.msg.common.msgSend.arrUsrNo" />', "Info", "info");
						return;
					}
					oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
					var strContent = $("#content").val().replace(/<img /gi, "img ").replace(/(<([^>]+)>)/gi, "").replace(/&nbsp;/gi, "");
					if(strContent.trim() == ""){
						messager.alert('<spring:message code="admin.web.view.msg.common.msgSend.strContent" />', "Info", "info");
						return;
					}
					
					messager.confirm('<spring:message code="column.common.confirm.send" />', function(r){
						if(r){
							var sendData = $("#userMessageViewForm").serialize();
							
						//	console.log(sendData);
						//	return;
							
							var options = {
								url : "<spring:url value='/common/userMessageSend.do' />"
								, data : sendData
								, callBack : function(result){
									messager.alert('<spring:message code="column.common.process.final_msg" />', "Info", "info", function(){
										layer.close('userMessageView');
										layerMessageList.close();
										layerMessageList.create('${mode}', '${adminSession.usrNo}');
										//createFormSubmit("userMessageListViewPop", "/common/userMessageListViewPop.do", {
										//});									
									});
								}
							};

							ajax.call(options);	
						}
					});
				}
			}

			// 메세지삭제처리
			function fnMessageDelete(){
				messager.confirm('<spring:message code="column.common.confirm.delete" />', function(r){
					if(r){
						var sendData = $("#userMessageViewForm").serialize();
					//	console.log(sendData);
					//	return;
						var options = {
							url : "<spring:url value='/common/deleteUserMessage.do' />"
							, data : sendData
							, callBack : function(result){
								messager.alert('<spring:message code="column.common.process.final_msg" />', "Info", "info", function(){
									layer.close('userMessageView');
									layerMessageList.close();
									layerMessageList.create('${mode}', '${adminSession.usrNo}');	
								});
							}
						};

						ajax.call(options);						
					}
				});		 
			} 
			
			 
			var arrUsrNm = new Array();
			var arrUsrNo = new Array();
			// callback : 회원검색
			function fnCallbackUserPop() {
				var data = {
					 multiselect : true
					, callBack : function(result) {
						$(result).each(function(i) {
							var check = false;
							if(arrUsrNo.length > 0 ){
								for(var  j  in  arrUsrNo ) {
								  if( arrUsrNo[j] == result[i].usrNo  ) {
									  check = true;
									}  
								}
								if(!check){
									arrUsrNm.push( result[i].usrNm);
									arrUsrNo.push( result[i].usrNo);	
								}							
							}else{
								arrUsrNm.push( result[i].usrNm);
								arrUsrNo.push( result[i].usrNo);
							}
						});
						$("#arrUsrNm").val( arrUsrNm );
						$("#arrUsrNo").val( arrUsrNo );
						$("#userDeleteBtn").show();
					}
				}
				layerUserList.create(data);

			}

			function fnUserDelete() {
				$("#arrUsrNm").val("");
				$("#arrUsrNo").val("");
				arrUsrNm = [];
				arrUsrNo = [];
				 
				
				$("#userDeleteBtn").hide();
			}
			
			 
			
			
		</script>
	
		<form name="userMessageViewForm" id="userMessageViewForm">
		<input type="hidden"  name="noteNo" id="noteNo"  value="${userMessage.noteNo}" />
		<input type="hidden"  name="mode" id="mode"  value="${mode}" />
		<input type="hidden"  name="usrNo" id="usrNo"  value="${userMessage.usrNo}" />
		
		<table class="table_type1 popup">
			<caption>메세지함 내용</caption>
			<tbody>
				<tr>
					<th><spring:message code="column.title"/><strong class="red">*</strong></th>
					<td>
						<!-- 제목-->
						<input type="text" class="w500 validate[required]" name="ttl" id="ttl" title="<spring:message code="column.title"/>" value="${userMessage.ttl}" />
					</td>
				</tr>
				
				<tr>
					<th><spring:message code="column.rcvr_nm"/><strong class="red">*</strong></th>
					<td>
						<input type="text" class="w300 input_text readonly" name="arrUsrNm" id="arrUsrNm" value="${userMessage.usrNm}" readonly="readonly" >
						<input type="hidden" class="readonly" name="arrUsrNo" id="arrUsrNo" value="${userMessage.usrNo}" readonly="readonly" >
						<button type="button" class="btn" onclick="fnCallbackUserPop();">사용자 검색</button>
						<button type="button" class="btn" id="userDeleteBtn" style="display: none;"  onclick="fnUserDelete();" >삭제</button>

					</td>
				</tr>
				<tr>
					<th><spring:message code="column.contents"/><strong class="red">*</strong></th>
					<td>
						<textarea name="content" id="content" title="<spring:message code="column.contents"/>" rows="5" cols="5">${userMessage.content }</textarea>
					</td>
				</tr>
				 
				 
				   
			</tbody>
		</table>
			
		</form>
		
