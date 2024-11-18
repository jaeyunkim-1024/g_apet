<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">
			$(document).ready(function(){
				createMemberGrid();
				fnAddDate(12);
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

			// 회원 목록
			function createMemberGrid(){
				var options = {
					url : "<spring:url value='/member/memberListGrid.do' />"
					, height : 400
					, searchParam : $("#memberSearchForm").serializeJson()
					, colModels : [
						{name:"mbrNo", label:'<b><u><tt><spring:message code="column.mbr_no" /></tt></u></b>', width:"80", align:"center", sortable:false, classes:'pointer fontbold'}
						// 사이트 아이디
						, {name:"stId", label:"<spring:message code='column.st_id' />", width:"100", align:"center", hidden:true}
						, _GRID_COLUMNS.stNm
						, {name:"mbrNm", label:'<b><u><tt><spring:message code="column.mbr_nm" /></tt></u></b>', width:"100", align:"center", classes:'pointer fontbold'}
	                    , {name:"loginId", label:'<spring:message code="column.login_id" />', width:"100", align:"center"}
						, {name:"mbrStatCd", label:'<spring:message code="column.mbr_stat_cd" />', width:"100", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.MBR_STAT}" />"}}
						, {name:"mbrGrdCd", label:'<spring:message code="column.mbr_grd_cd" />', width:"100", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.MBR_GRD}" />"}}
						, _GRID_COLUMNS.tel
						, _GRID_COLUMNS.mobile
						, _GRID_COLUMNS.email
						, {name:"birth", label:'<spring:message code="column.birth" />', width:"100", align:"center"}
						, {name:"emailRcvYn", label:'<spring:message code="column.email_rcv_yn" />', width:"100", align:"center"}
						, {name:"smsRcvYn", label:'<spring:message code="column.sms_rcv_yn" />', width:"100", align:"center"}
						, {name:"svmnRmnAmt", label:'<spring:message code="column.svmn_rmn_amt" />', width:"100", align:"center", formatter:'integer'}
						, {name:"blcRmnAmt", label:'<spring:message code="column.blc_rmn_amt" />', width:"100", align:"center", formatter:'integer'}
						, {name:"gdGbCd", label:'<spring:message code="column.gd_gb_cd" />', width:"100", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.GD_GB}" />"}}
						, {name:"ntnGbCd", label:'<spring:message code="column.ntn_gb_cd" />', width:"100", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.NTN_GB}" />"}}
						, {name:"joinPathCd", label:'<spring:message code="column.join_path_cd" />', width:"150", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.JOIN_PATH}" />"}}
						, {name:"joinDtm", label:'<spring:message code="column.join_dtm" />', width:"130", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss"}
						, {name:"updrIp", label:'<spring:message code="column.updr_ip" />', width:"120", align:"center"}
						, _GRID_COLUMNS.sysRegrNm
						, _GRID_COLUMNS.sysRegDtm
						, _GRID_COLUMNS.sysUpdrNm
						, _GRID_COLUMNS.sysUpdDtm
					]
					, multiselect : true
	                , onCellSelect : function (ids, cellidx, cellvalue) {
	                    if(cellidx == 4) { // CODE 선택
	                        var rowdata = $("#memberList").getRowData(ids);
	                        memberView(rowdata.mbrNo);
	                    }
	                }
				};
				grid.create("memberList", options);
			}

			function reloadMemberGrid(){
				var options = {
					searchParam : $("#memberSearchForm").serializeJson()
				};

				grid.reload("memberList", options);
			}
			
	        function memberView(mbrNo) {
	        	addTab('회원 상세', '/member/memberView.do?mbrNo=' + mbrNo);
	        }

			function memberSavedMoneyInsert(){
				var grid = $("#memberList");
				var selectedIDs = grid.getGridParam("selarrrow");
				if(selectedIDs != null && selectedIDs.length > 0) {

					// 정상회원만 적립금을 지급할 수 있음(휴면/탈퇴 회원은 제외)
					for (var i = 0, length = selectedIDs.length; i < length; i++) {
						var rowdata = grid.getRowData(selectedIDs[i]);
						if (rowdata.mbrStatCd != '${adminConstants.MBR_STAT_10}') {
							var msg = '<spring:message code="admin.web.view.msg.member.point.status" />';
							msg = msg.replace(/\{mbrNo\}/g, rowdata.mbrNo).replace(/\{mbrNm\}/g, rowdata.mbrNm);
							messager.alert(msg, "Info", "info");
							return;
						}
					}
					
					if(validate.check("memberSavedMoneyForm")) {
						//유효 일시 
						var vldDtm = $("#vldDtm").val().replace(/-/gi, "");
						if (vldDtm ==''){
							messager.alert("<spring:message code='admin.web.view.msg.member.savedmoney.date_required' />", "Info", "info", function(){
								$("#vldDtm").focus();
							});
							return;
						} 
						var currentTime =shiftDate(getCurrentTime(), 0,0,0,"");
						if(vldDtm < currentTime){
							messager.alert("<spring:message code='admin.web.view.msg.member.savedmoney.date_invalid' />", "Info", "info");
							return;
						}
 						
						messager.confirm('<spring:message code="column.common.confirm.insert" />', function(r){
			                if (r){
			                	var data = $("#memberSavedMoneyForm").serializeObject();
								var arrMbrNo = new Array();
								for (var i in selectedIDs) {
									var rowdata = grid.getRowData(selectedIDs[i]);
									arrMbrNo.push(rowdata.mbrNo);
								}
								data.arrMbrNo = arrMbrNo.join(",")

								var options = {
									url : "<spring:url value='/member/memberSavedMoneyListInsert.do' />"
									, data : data
									, callBack : function(result){
										resetForm('memberSavedMoneyForm');
										fnAddDate(12);
										reloadMemberGrid();
									}
								};

								ajax.call(options);
			                }
		            	});
					}
				} else {
					messager.alert("<spring:message code='admin.web.view.msg.member.select_invalid' />", "Info", "info");
				}
			}
			//날짜 더하기 
			function fnAddDate(dos){
			    var date = toDateObject(getCurrentTime());
				date.setMonth(date.getMonth() + dos);			 
				date.setDate(date.getDate() -1);			 
				$("#vldDtm").val( toDateString(date, "-")   );
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
									<input type="text" name="loginId" id="loginId" title="<spring:message code="column.login_id"/>" value="" />
								</td>
								<th><spring:message code="column.mbr_nm"/></th>
								<td>
									<!-- 회원 명-->
									<input type="text" name="mbrNm" id="mbrNm" title="<spring:message code="column.mbr_nm"/>" value="" />
								</td>
							</tr>
							<tr>
								<th><spring:message code="column.mbr_stat_cd"/></th>
								<td>
									<!-- 회원 상태 코드-->
									<select name="mbrStatCd" id="mbrStatCd" title="<spring:message code="column.mbr_stat_cd"/>">
										<frame:select grpCd="${adminConstants.MBR_STAT}" defaultName="전체" />
									</select>
								</td>
								<th><spring:message code="column.mbr_grd_cd"/></th>
								<td>
									<!-- 회원 등급 코드-->
									<select name="mbrGrdCd" id="mbrGrdCd" title="<spring:message code="column.mbr_grd_cd"/>">
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
					<button type="button" onclick="resetForm('memberSearchForm');fnAddDate(12);" class="btn btn-cancel">초기화</button>
				</div>
			</div>
		</div>

		<div class="mModule">
			<table id="memberList" ></table>
			<div id="memberListPage"></div>
		</div>

		<form name="memberSavedMoneyForm" id="memberSavedMoneyForm" method="post">
		<table class="table_type1 mt30">
            <caption>적립금 지급</caption>
            <colgroup>
                <col style="width:100px;" />
                <col style="width:150px;" />
                <col style="width:100px;" />
                <col style="width:150px;" />
                <col style="width:100px;" />
                <col style="width:300px;" />
                <col style="width:100px;" />
				<col />
			</colgroup>
			<tbody>
                <tr>
                    <th><spring:message code="column.save_amt"/><strong class="red">*</strong></th>
                    <td>
                        <input type="text" class="w100 comma validate[required, custom[number]]" name="saveAmt" id="saveAmt" title="<spring:message code="column.save_amt"/>" value="" />
                    </td>               
                    <th><spring:message code="column.svmn_rsn_cd"/><strong class="red">*</strong></th>
                    <td>
                        <!-- 적립금 사유 -->
                        <select class="w100 validate[required]" name="svmnRsnCd" id="svmnRsnCd" title="<spring:message code="column.svmn_rsn_cd"/>">
                            <frame:select grpCd="${adminConstants.SVMN_RSN}" defaultName="선택하세요" excludeOption="${adminConstants.SVMN_RSN_210}"/>
                        </select>
                    </td>
                    <th><spring:message code="column.etc_rsn"/></th>
                    <td>
                        <input type="text" class="w250" name="etcRsn" id="etcRsn" title="<spring:message code="column.etc_rsn"/>" value="" />
                    </td>
                    <th><spring:message code="column.vld_dtm"/></th>
                    <td>
                        <frame:datepicker startDate="vldDtm" /><!-- class="validate[required]" -->
                        <label class="fRadio ml20"><input type="radio" id="addDate" name="addDate" title="기간" value="3"  onclick="fnAddDate(3);"><span>3개월</span></label>
                        <label class="fRadio"><input type="radio" id="addDate" name="addDate" title="기간" value="6"  onclick="fnAddDate(6);"><span>6개월</span></label>
                        <label class="fRadio"><input type="radio" id="addDate" name="addDate" title="기간" value="12" checked="checked" onclick="fnAddDate(12);"><span>1년</span></label>
                    </td>   
                </tr>
			</tbody>
		</table>
		</form>
		<div class="btn_area_center">
			<button type="button" onclick="memberSavedMoneyInsert();" class="btn btn-ok">적립금 부여</button>
			<button type="button" onclick="resetForm('memberSavedMoneyForm');fnAddDate(12);" class="btn btn-cancel">초기화</button>
		</div>

	</t:putAttribute>
</t:insertDefinition>