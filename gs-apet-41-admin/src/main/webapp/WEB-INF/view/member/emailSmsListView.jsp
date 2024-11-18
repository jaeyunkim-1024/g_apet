<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		
		
		<script type="text/javascript">
		
			var bigo = 1;
		
			$(document).ready(function(){
				createMemberGrid();
			});
			
			// 사이트 검색
			function searchSt () {
				var options = {
					multiselect : false
					, callBack : searchStCallback
				}
				layerStList.create (options );
			}
			function searchStCallback (stList ) {
				if(stList.length > 0 ) {
					$("#stId").val (stList[0].stId );
					$("#stNm").val (stList[0].stNm );
				}
			}			

			// 그룹 코드 리스트
			function createMemberGrid(){
				var options = {
					url : "<spring:url value='/member/memberListGrid.do' />"
					, height : 400
					, searchParam : $("#memberSearchForm").serializeJson()
					, colModels : [
						{name:"mbrNo", label:'<b><u><tt><spring:message code="column.mbr_no" /></tt></u></b>', width:"80", align:"center", sortable:false, classes:'pointer fontbold'}
						// 사이트 아이디
						, {name:"stId", label:"<spring:message code='column.st_id' />", width:"100", align:"center", hidden:true}
						// 사이트 명
						, _GRID_COLUMNS.stNm
						, {name:"mbrNm", label:'<spring:message code="column.mbr_nm" />', width:"100", align:"center"}
						, {name:"mbrStatCd", label:'<spring:message code="column.mbr_stat_cd" />', width:"80", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.MBR_STAT}" />"}}
						, {name:"mbrGrdCd", label:'<spring:message code="column.mbr_grd_cd" />', width:"80", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.MBR_GRD}" />"}}
						, {name:"loginId", label:'<spring:message code="column.login_id" />', width:"100", align:"center"}
						, _GRID_COLUMNS.tel
						, _GRID_COLUMNS.mobile
						, _GRID_COLUMNS.email
						, {name:"birth", label:'<spring:message code="column.birth" />', width:"100", align:"center"}
						, {name:"emailRcvYn", label:'<spring:message code="column.email_rcv_yn" />', width:"80", align:"center"}
						, {name:"smsRcvYn", label:'<spring:message code="column.sms_rcv_yn" />', width:"80", align:"center"}
						, {name:"svmnRmnAmt", label:'<spring:message code="column.svmn_rmn_amt" />', width:"100", align:"center", formatter:'integer'}
						, {name:"blcRmnAmt", label:'<spring:message code="column.blc_rmn_amt" />', width:"100", align:"center", formatter:'integer'}
						, {name:"gdGbCd", label:'<spring:message code="column.gd_gb_cd" />', width:"80", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.GD_GB}" />"}}
						, {name:"ntnGbCd", label:'<spring:message code="column.ntn_gb_cd" />', width:"80", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.NTN_GB}" />"}}
						, {name:"joinPathCd", label:'<spring:message code="column.join_path_cd" />', width:"100", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.JOIN_PATH}" />"}}
						, {name:"joinDtm", label:'<spring:message code="column.join_dtm" />', width:"150", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss"}
						, _GRID_COLUMNS.sysRegrNm
						, _GRID_COLUMNS.sysRegDtm
						, _GRID_COLUMNS.sysUpdrNm
						, _GRID_COLUMNS.sysUpdDtm
					]
					, multiselect : true
				};
				grid.create("memberList", options);
			}

			function reloadMemberGrid(){
				var options = {
					searchParam : $("#memberSearchForm").serializeJson()
				};

				grid.reload("memberList", options);
			}

			function smsLayerView() {
				
				var selectedIDs = $("#memberList").getGridParam("selarrrow");

				if(selectedIDs != null && selectedIDs.length > 0) {

					var data = new Array();
					for (var i in selectedIDs) {
						var rowdata = $("#memberList").getRowData(selectedIDs[i]);
						data.push({
							receiveName : rowdata.mbrNm
							, receivePhone : rowdata.mobile
						});
					}

					var options = {
						url : "<spring:url value='/member/smsLayerView.do' />"
						, data : {
							arrSmsStr : JSON.stringify(data)
						}
						, dataType : "html"
						, callBack : function (data ) {
							var config = {
								id : "smsLayer"
								, width : 500
								, height : 450
								, top : 200
								, title : "SMS 발송"
								, body : data
								, button : "<button type=\"button\" onclick=\"smsSend();\" class=\"btn btn-ok\">발송</button>"
							}
							layer.create(config);
						}
					}
					ajax.call(options );
				} else {
					messager.alert("<spring:message code='admin.web.view.msg.member.select_invalid' />", "Info", "info");
				}
			}
			
			$(document).on("keyup", "#msg", function(e) {
				
				//byteCheck("msg", "msgByte");
				var conts = document.getElementById("msg");
				var bytes = document.getElementById("msgByte");
				var i = 0;
				var cnt = 0;
				var exceed = 0;
				var ch = '';
				for (i=0; i<conts.value.length; i++) {
					ch = conts.value.charAt(i);
					if (escape(ch).length > 4) {
						cnt += 2;
					} else {
						cnt += 1;
					}
				}
				bytes.innerHTML = cnt;
				
				if (cnt > 80 && bigo  == 1 ) {
					$("#msgByteHtml").hide();
					$("#mmsHtml").show();
					bigo = bigo+1;
					messager.alert("<spring:message code='admin.web.view.msg.member.emailsms.size_valid' arguments='80'/>", "Info", "info");
				}
				
				if(cnt > 80  &&  bigo > 1){
					$("#msgByteHtml").hide();
					$("#mmsHtml").show();
				}else if(cnt <= 80  &&  bigo > 1){
					$("#msgByteHtml").show();
					$("#mmsHtml").hide();
				}
			});

			$(document).on("click", ".smsDtlBtn", function(e) {
				if($("#smsLayerForm .mListBox li").length > 1) {
					$(this).parents("li").remove();
				} else {
					messager.alert("<spring:message code='admin.web.view.msg.member.emailsms.sms_delete_fail' />", "Info", "info");
				}
			});

			function smsSend() {
				if($("#smsLayerForm .mListBox li").length > 0) {
					if(validate.check("smsLayerForm")) {
						messager.confirm('<spring:message code="column.common.confirm.send" />', function(r){
			                if (r){
								var receiveName = new Array();
								var receivePhone = new Array();

								$("#smsLayerForm .mListBox li").each(function(e) {
									receiveName.push($(this).find("input[name=receiveName]").val());
									receivePhone.push($(this).find("input[name=receivePhone]").val());
								});

								 var options = {
									url : "<spring:url value='/member/smsListSend.do' />"
									, data : {
										sendPhone : $("#smsLayerForm #sndNo").val()
										, msg : $("#smsLayerForm #msg").val()
										, receiveName : receiveName.join(",")
										, receivePhone : receivePhone.join(",")
									}
									, callBack : function(result){
										messager.alert(result.resultMessage, "Info", "info", function(){
											if(result.resultCode == 0) {
												layer.close("smsLayer");
											}
										});
									}
								};
								ajax.call(options);
			                }
		            	});
					}
				} else {
					messager.alert("<spring:message code='admin.web.view.msg.member.emailsms.sms_send_fail' />", "Info", "info");
				}
			}

			function emailLayerView() {
				
				var selectedIDs = $("#memberList").getGridParam("selarrrow");

				if(selectedIDs != null && selectedIDs.length > 0) {

					var data = new Array();
					for (var i in selectedIDs) {
						var rowdata = $("#memberList").getRowData(selectedIDs[i]);
						
						data.push({
							  receiverNm : rowdata.mbrNm
							, receiverEmail : rowdata.email
							, mbrNo : rowdata.mbrNo
							, stId : rowdata.stId
						});
					}
					
					var options = {
						url : "<spring:url value='/member/emailLayerView.do' />"
						, data : {
							arrEmailStr : JSON.stringify(data)
						}
						, dataType : "html"
						, callBack : function (data ) {
							var config = {
								id : "emailLayer"
								, width : 900
								, height : 800
								, top : 100
								, title : "Email 발송"
								, body : data
								, button : "<button type=\"button\" onclick=\"emailSend();\" class=\"btn btn-ok\">발송</button>"
							}
							layer.create(config);

							EditorCommon.setSEditor('emailContent', '${adminConstants.EMAIL_PATH}');
						}
					}
					ajax.call(options );
				} else {
					messager.alert("<spring:message code='admin.web.view.msg.member.select_invalid' />", "Info", "info");
				}
			}

			$(document).on("click", ".emailDtlBtn", function(e) {
				if($("#emailLayerForm .mListBox li").length > 1) {
					$(this).parents("li").remove();
				} else {
					messager.alert("<spring:message code='admin.web.view.msg.member.emailsms.email_delete_fail' />", "Info", "info");
				}
			});

			function emailSend() {
				if($("#emailLayerForm .mListBox li").length > 0) {
					
					if(validate.check("emailLayerForm")) {
						oEditors.getById["emailContent"].exec("UPDATE_CONTENTS_FIELD", []);
						if( !editorRequired( 'emailContent' ) ){ return false };
						
						messager.confirm('<spring:message code="column.common.confirm.send" />', function(r){
			                if (r){
			                	var arrEmailStr = new Array();

								$("#emailLayerForm .mListBox li").each(function(e) {
									arrEmailStr.push({
									  receiverNm : $(this).find("input[name=nm]").val()
							        , receiverEmail : $(this).find("input[name=email]").val()
									, mobile : $(this).find("input[name=mobile]").val()
									, mbrNo  : $(this).find("input[name=mbrNo]").val()
									, stId   : $(this).find("input[name=stId]").val()
									})
								});
								
								 var options = {
									url : "<spring:url value='/member/emailListSend.do' />"
									, data : {
										emailTitle : $("#emailLayerForm #emailTitle").val()
										, emailContent : $("#emailLayerForm #emailContent").val()
										, arrEmailStr : JSON.stringify(arrEmailStr)
									}
									, callBack : function(result){
										messager.alert(result.resultMessage, "Info", "info", function(){
											layer.close("emailLayer");
										});
									}
								};
								ajax.call(options);
			                }
		            	});
					}
				} else {
					messager.alert("<spring:message code='admin.web.view.msg.member.emailsms.email_send_fail' />", "Info", "info");
				}
			}

		</script>
	</t:putAttribute>
	<t:putAttribute name="content">
		<div class="easyui-accordion search-accordion" data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect" style="width:100%">
			<div title="<spring:message code='admin.web.view.common.search' />" style="padding:10px">
				<form name="memberSearchForm" id="memberSearchForm">
					<table class="table_type1">
						<caption>정보 검색</caption>
						<tbody>
							<tr>
								<th><spring:message code="column.login_id"/></th>
								<td>
									<!-- 로그인 아이디-->
									<input type="text" class="" name="loginId" id="loginId" title="<spring:message code="column.login_id"/>" value="" />
								</td>
								<th><spring:message code="column.mbr_nm"/></th>
								<td>
									<!-- 회원 명-->
									<input type="text" class="" name="mbrNm" id="mbrNm" title="<spring:message code="column.mbr_nm"/>" value="" />
								</td>
							</tr>
							<tr>
								<th><spring:message code="column.mbr_stat_cd"/></th>
								<td>
									<!-- 회원 상태 코드-->
									<select class="wth100" name="mbrStatCd" id="mbrStatCd" title="<spring:message code="column.mbr_stat_cd"/>">
										<frame:select grpCd="${adminConstants.MBR_STAT}" defaultName="전체" />
									</select>
								</td>
								<th><spring:message code="column.mbr_grd_cd"/></th>
								<td>
									<!-- 회원 등급 코드-->
									<select class="wth100" name="mbrGrdCd" id="mbrGrdCd" title="<spring:message code="column.mbr_grd_cd"/>">
										<frame:select grpCd="${adminConstants.MBR_GRD}" defaultName="전체" />
									</select>
								</td>
							</tr>
							<tr>
		                        <th scope="row"><spring:message code="column.mbr_no" /></th> <!-- 회원번호 -->
		                        <td>
		                             <textarea rows="3" cols="30" id="mbrNoArea" name="mbrNoArea" ></textarea>
		                        </td>
								<th><spring:message code="column.mobile"/></th>
								<td>
									<!-- 휴대폰-->
									<input type="text" class="phoneNumber" name="mobile" id="mobile" title="<spring:message code="column.mobile"/>" value="" />
								</td>
							</tr>
							<tr>
								<th><spring:message code="column.email"/></th>
								<td>
									<!-- 이메일-->
									<input type="text" class="w300" name="email" id="email" title="<spring:message code="column.email"/>" value="" />
								</td>
								<th><spring:message code="column.st_id" /></th> 
								<td>
									<!-- 사이트 ID -->
		                            <select id="stIdCombo" name="stId">
		                                <frame:stIdStSelect defaultName="사이트선택" />
		                            </select>
								</td>
							</tr>
						</tbody>
					</table>
				</form>

				<div class="btn_area_center">
					<button type="button" onclick="reloadMemberGrid();" class="btn btn-ok">검색</button>
					<button type="button" onclick="resetForm('memberSearchForm');" class="btn btn-cancel">초기화</button>
				</div>
			</div>
		</div>

		<div class="mModule">
			<button type="button" onclick="emailLayerView();" class="btn btn-add">Email 발송</button>
			<button type="button" onclick="smsLayerView();" class="btn btn-add">SMS 발송</button>
			
			<table id="memberList" ></table>
			<div id="memberListPage"></div>
		</div>

	</t:putAttribute>
</t:insertDefinition>