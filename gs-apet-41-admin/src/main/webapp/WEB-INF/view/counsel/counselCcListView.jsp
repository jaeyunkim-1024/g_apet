<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">
			$(document).ready(function(){

				counselList.create();
			});

			// CS 카테고리 1 선택
			$(document).on("change", "#cusCtg1Cd",function(e) {
				var selectVal = $(this).val();

				if ( selectVal == "" ) {
					$("#cusCtg2Cd").html('');
					$("#cusCtg3Cd").html('');
					return;
				}

				codeAjax.select({
					grpCd : '${adminConstants.CUS_CTG2 }'
					, usrDfn1Val : selectVal
					, defaultName : '선택'
					, showValue : false
					, callBack : function(html) {
						$("#cusCtg2Cd").html(html);
						$("#cusCtg3Cd").html('');
					}
				});

			});

			// CS 카테고리 2 선택
			$(document).on("change", "#cusCtg2Cd", function(e) {
				var selectVal = $(this).val();

				if ( selectVal == "" ) {
					$("#cusCtg3Cd").html('');
					return;
				}

				codeAjax.select({
					grpCd : '${adminConstants.CUS_CTG3 }'
						, usrDfn1Val : selectVal
						, defaultName : '선택'
						, showValue : false
						, callBack : function(html) {
							$("#cusCtg3Cd").html(html);
						}
				});

			});

			// 검색 : 상담 상태 코드 클릭
			$(document).on("click", 'input:checkbox[name="arrCusStatCd"]', function(e) {

				var all = false;

				if ( validation.isNull( $(this).val() ) ){
					all = true;
				}
				if ( $('input:checkbox[name="arrCusStatCd"]:checked').length == 0 ) {
					$('input:checkbox[name="arrCusStatCd"]').eq(0).prop( "checked", true );
				} else {
					$('input:checkbox[name="arrCusStatCd"]').each( function() {
						if ( all ) {
							if ( validation.isNull( $(this).val() ) ) {
								$(this).prop("checked", true);
							} else {
								$(this).prop("checked", false);
							}
						} else {
							if ( validation.isNull($(this).val() ) ) {
								$(this).prop("checked", false);
							}
						}
					});
				}

			});

			// 검색 : 상담 유형 코드 클릭
			$(document).on("click", 'input:checkbox[name="arrCusTpCd"]', function(e) {

				var all = false;

				if ( validation.isNull( $(this).val() ) ){
					all = true;
				}
				if ( $('input:checkbox[name="arrCusTpCd"]:checked').length == 0 ) {
					$('input:checkbox[name="arrCusTpCd"]').eq(0).prop( "checked", true );
				} else {
					$('input:checkbox[name="arrCusTpCd"]').each( function() {
						if ( all ) {
							if ( validation.isNull( $(this).val() ) ) {
								$(this).prop("checked", true);
							} else {
								$(this).prop("checked", false);
							}
						} else {
							if ( validation.isNull($(this).val() ) ) {
								$(this).prop("checked", false);
							}
						}
					});
				}

			});

			var counselList = {
				// 생성
				create : function(){
					var options = {
						url : "<spring:url value='/counsel/cc/counselCcListGrid.do' />"
						, datatype : 'local'
						, height : 400
						, searchParam : $("#counselSearchForm").serializeJson()
						, colModels : [

							//상담 번호
							{name:"cusNo", label:'<spring:message code="column.cus_no" />', width:"100", align:"center", formatter:'integer' , hidden:true}
							//  사이트 명
							, {name:"stNm", label:"<spring:message code='column.st_nm' />", width:"80", align:"center", sortable:true }
							//상담 경로 코드
							, {name:"cusPathCd", label:'<spring:message code="column.cus_path_cd" />', width:"80", align:"center", hidden:true, formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.CUS_PATH}" />"}}
							//상담 상태 코드
							, {name:"cusStatCd", label:'<b><u><tt><spring:message code="column.cus_stat_cd" /></tt></u></b>', width:"60", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.CUS_STAT}" />"}, classes:'pointer fontbold'}
							//상담 유형 코드
							, {name:"cusTpCd", label:'<spring:message code="column.cus_tp_cd" />', width:"60", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.CUS_TP}" />"}}
							// 응답 구분 코드
							, {name:"respGbCd", label:'<spring:message code="column.resp_gb_cd" />', width:"80", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.RESP_GB}" />"}}
							// 상담 카테고리1 코드
							, {name:"cusCtg1Cd", label:'<spring:message code="column.cus_ctg1_cd" />', width:"100", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.CUS_CTG1}" />"}}
							// 상담 카테고리2 코드
							, {name:"cusCtg2Cd", label:'<spring:message code="column.cus_ctg2_cd" />', width:"100", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.CUS_CTG2}" />"}}
							// 상담 카테고리3 코드
							, {name:"cusCtg3Cd", label:'<spring:message code="column.cus_ctg3_cd" />', width:"100", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.CUS_CTG3}" />"}}
							// 주문 번호
							, {name:"ordNo", label:'<spring:message code="column.ord_no" />', width:"110", align:"center" }
							//제목
							, {name:"ttl", label:'<b><u><tt><spring:message code="column.ttl" /></tt></u></b>', width:"200", align:"left", classes:'pointer fontbold'}
							//내용
							, {name:"content", label:'<spring:message code="column.content" />', hidden:true}
							//처리내용
							, {name:",prcsContent", label:'<spring:message code="column.prcs_content" />', hidden:true}
							//문의자 로그인 아이디
							, {name:"loginId", label:'<spring:message code="column.eqrr_id" />', width:"100", align:"center"}
							//문의자 명
							, {name:"eqrrNm", label:'<spring:message code="column.eqrr_nm" />', width:"70", align:"center"}
							// 통화자 구분 코드
							, {name:"callGbCd", label:'<spring:message code="column.call_gb_cd" />', width:"60", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.CALL_GB}" />"}}
							//문의자 전화
							, {name:"eqrrTel", label:'<spring:message code="column.eqrr_tel" />', width:"100", align:"center", formatter:gridFormat.phonenumber}
							//문의자 휴대폰
							, {name:"eqrrMobile", label:'<spring:message code="column.eqrr_mobile" />', width:"100", align:"center", formatter:gridFormat.phonenumber}
							//문의자 이메일
							, {name:"eqrrEmail", label:'<spring:message code="column.eqrr_email" />', width:"150", align:"center"}
							//상담 담당자 번호
							, {name:"cusChrgNo", label:'<spring:message code="column.cus_chrg_no" />', hidden:true}
							//상담 담당자명
							, {name:"cusChrgNm", label:'<spring:message code="column.cus_chrg_nm" />', width:"80", align:"center"}
							//상담 접수자
							, {name:"cusAcptrNm", label:'<spring:message code="column.cus_acptr_nm" />', width:"80", align:"center"}
							//상담 접수 일시
							, {name:"cusAcptDtm", label:'<spring:message code="column.cus_acpt_dtm" />', width:"130", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss"}
							//상담 취소자
							, {name:"cusCncrNm", label:'<spring:message code="column.cus_cncr_nm" />', width:"80", align:"center"}
							//상담 취소 일시
							, {name:"cusCncDtm", label:'<spring:message code="column.cus_cnc_dtm" />', width:"130", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss"}
							//상담 완료자
							, {name:"cusCpltrNm", label:'<spring:message code="column.cus_cpltr_nm" />', width:"80", align:"center"}
							//상담 완료 일시
							, {name:"cusCpltDtm", label:'<spring:message code="column.cus_cplt_dtm" />', width:"130", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss"}
						]
						, onSelectRow : function(ids) {
						}
						,onCellSelect: function(rowid, index, contents, e){ // cell을 클릭 시

							var cm = $("#counselList").jqGrid("getGridParam", "colModel");
							var rowData = $("#counselList").getRowData(rowid);
							if(cm[index].name != "cb"){
								counselList.detailView(rowData.cusNo);
							}
						}
						<c:if test="${adminConstants.USR_GB_1030 eq adminSession.usrGbCd or adminConstants.USR_GB_1031 eq adminSession.usrGbCd}" >
						,multiselect : true
						</c:if>
					};

					grid.create( "counselList", options) ;
				}
				// 재조회
				, reload : function(){
					var data = $("#counselSearchForm").serializeJson();

					if ( undefined != data.arrCusStatCd && data.arrCusStatCd != null && Array.isArray(data.arrCusStatCd) ) {
						$.extend( data, { arrCusStatCd : data.arrCusStatCd.join(",") } );
					}

					var options = {
						searchParam : data
					}

					grid.reload( "counselList", options );
				}
				// 검색 초기화
				, clear : function(){
					resetForm('counselSearchForm');
					$("#cusCtg2Cd").html("");
					$("#cusCtg3Cd").html("");

				}
				// 상세 화면 호출
				, detailView : function(cusNo){
					addTab('CS문의 상세', '/counsel/cc/counselCcView.do?cusNo=' + cusNo);
				}
				, searchSt : function(){
					var options = {
						multiselect : false
						, callBack : counselList.cbSt
					}
					layerStList.create (options );
				}
				, cbSt : function(stList){
					if(stList.length > 0 ) {
						$("#stId").val (stList[0].stId );
						$("#stNm").val (stList[0].stNm );
					}
				}
				// 담당자 검색
				, searchTarget : ""
				, searchUser : function(target){
					this.searchTarget = target;
					$("#searchTarget").val(target);
					var data = {
						 multiselect : false
						, callBack : counselList.cbUser
						, param : {
							usrGbCd : '${adminConstants.USR_GB_1031}'
							,usrStatCd : '${adminConstants.USR_STAT_20}'
						}
					}
					layerUserList.create(data);
				}
				// 담당자 콜백
				, cbUser : function(userList){
					var searchTarget = $("#searchTarget").val();
					if(searchTarget == "D"){
						$("#counselCusChrgNo").val(userList[0].usrNo);
						$("#counselCusChrgNm").val(userList[0].usrNm);
					}else{
						$("#counselSearchCusChrgNo").val(userList[0].usrNo);
						$("#counselSearchCusChrgNm").val(userList[0].usrNm);
					}
				}
				, setMine : function(){
					$("#counselCusChrgNo").val('${adminSession.usrNo}');
					$("#counselCusChrgNm").val('${adminSession.usrNm}');
				}
				// 담당자 변경
				, changeChrg : function(){
					var cusNos = new Array();
					var grid = $("#counselList" );
					var rowids = grid.jqGrid('getGridParam', 'selarrrow');

					if(rowids.length < 1){
						messager.alert("<spring:message code='admin.web.view.msg.counsel.list.select.counsel' />","Info","info");
						return;
					}

					for (var i = 0; i < rowids.length; i++) {
						var rowData = grid.jqGrid('getRowData', rowids[i]);
						cusNos.push(rowData.cusNo);

						if(rowData.cusStatCd == "${adminConstants.CUS_STAT_30}" || rowData.cusStatCd == "${adminConstants.CUS_STAT_40}"){
							messager.alert("<spring:message code='admin.web.view.msg.counsel.list.manager' />","Info","info");
							return;
						}
					}

					if($("#counselCusChrgNm").val() == ""){
						messager.alert("<spring:message code='admin.web.view.msg.counsel.list.select.counselmanager' />","Info","info");
						return;
					}

					messager.confirm("<spring:message code='admin.web.view.msg.counsel.list.change' />",function(r){
						if(r){
							this.updateChrg(cusNos);				
						}
					});
				}
				, updateChrg : function(cusNos){
					var options = {
						url : "<spring:url value='/counsel/cc/updateCounselChrg.do' />"
						, data : {cusNos : cusNos, cusChrgNo : $("#counselCusChrgNo").val()}
						, callBack : function(data) {
							messager.alert("<spring:message code='admin.web.view.msg.counsel.list.done' />","Info","info",function(){
								counselList.reload();
							});
						}
					};

	 				ajax.call(options);
				}

			};
			
			/**
			 * 엑셀 다운로드 
			 */
			function counselCcListExcelDownload() {
				createFormSubmit("counselCcListExcelDownload", "/counsel/cc/counselCcListExcelDownload.do", $("#counselSearchForm").serializeJson());
			}

		</script>
	</t:putAttribute>
	<t:putAttribute name="content">

		<div class="easyui-accordion search-accordion" data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect" style="width:100%">
			<div title="<spring:message code='admin.web.view.common.search' />" style="padding:10px">
				<form name="counselSearchForm" id="counselSearchForm">
					<table class="table_type1">
						<caption>정보 검색</caption>
						<colgroup>
							<col style="width:110px;">
							<col style="width:300px;">
							<col style="width:110px;">
							<col />
							<col style="width:110px;">
							<col />
						</colgroup>
						<tbody>
							<tr>
								<!-- 상담접수일자 -->
								<th scope="row"><spring:message code="column.cus_acpt_dtm" /></th>
								<td>
									<frame:datepicker startDate="cusAcptDtmStart" endDate="cusAcptDtmEnd" period="-30" />
								</td>
								<!-- 상담 상태 -->
								<th scope="row"><spring:message code="column.order_common.cus_stat" /></th>
								<td>
									<frame:checkbox name="arrCusStatCd" grpCd="${adminConstants.CUS_STAT }" defaultName="전체" />
								</td>
								<!-- 상담 유형 -->
								<th scope="row"><spring:message code="column.cus_tp_cd" /></th>
								<td>
									<frame:checkbox name="arrCusTpCd" grpCd="${adminConstants.CUS_TP }" defaultName="전체" />
								</td>
							</tr>
							<tr>
								<!-- 사이트 ID -->
								<th scope="row"><spring:message code="column.st_id" /></th>
								<td>
		                            <select id="stIdCombo" name="stId">
										<c:forEach items="${stList}" var="stInfo">
											<option value="${stInfo.stId}">${stInfo.stNm}</option>
										</c:forEach>
		                           </select>
								</td>
								<!-- 상담 카테고리 -->
								<th scope="row"><spring:message code="column.order_common.cus_ctg" /></th>
								<td>
									<select name="cusCtg1Cd" id="cusCtg1Cd" class="w120" title="선택상자" >
										<frame:select grpCd="${adminConstants.CUS_CTG1 }" defaultName="선택" />
									</select>
									<select name="cusCtg2Cd" id="cusCtg2Cd" class="w120" title="선택상자" ></select>
									<select name="cusCtg3Cd" id="cusCtg3Cd" class="w120" title="선택상자" ></select>
								</td>
								<!-- 상담 담당자 -->
								<th scope="row"><spring:message code="column.cus_chrg_nm" /></th>
								<td>
									<c:if test="${adminConstants.USR_GB_1031 ne adminSession.usrGbCd}">
									<input type="hidden" id="counselSearchCusChrgNo" name="cusChrgNo" value="" />
									<input type="text" id="counselSearchCusChrgNm" value="" class="readonly" readonly="readonly" />
									<button type="button" onclick="counselList.searchUser('M');" class="btn">검색</button>
									</c:if>
									<c:if test="${adminConstants.USR_GB_1031 eq adminSession.usrGbCd}">
									<input type="hidden" id="counselSearchCusChrgNo" name="cusChrgNo" value="${adminSession.usrNo}" />
									<input type="text" id="counselSearchCusChrgNm" value="${adminSession.usrNm}" class="readonly" readonly="readonly" />
									</c:if>
								</td>
							</tr>
							<tr>
								<!-- 문의자명 -->
								<th scope="row"><spring:message code="column.eqrr_nm" /></th>
								<td>
									<input type="text" name="eqrrNm" id="eqrrNm" value="" />
								</td>
								<!-- 문의자 전화 -->
								<th scope="row"><spring:message code="column.eqrr_tel" /></th>
								<td>
									<input type="text" name="eqrrTel" id="eqrrTel" value="" />
								</td>
								<!-- 문의자 휴대폰 -->
								<th scope="row"><spring:message code="column.eqrr_mobile" /></th>
								<td>
									<input type="text" name="eqrrMobile" id="eqrrMobile" value="" />
								</td>
							</tr>
							<tr>
								<!-- 문의자 아이디 -->
								<th scope="row"><spring:message code="column.eqrr_id" /></th>
								<td>
									<input type="text" name="loginId" id="loginId" value="" />
								</td>
								<!-- 회원 구분  -->
								<th scope="row"><spring:message code="column.order_common.cs_member_gbn"/></th>
								<td colspan="3">
									<label class="fRadio"><input type="radio" name="memberYn" value="" checked="checked"> <span>전체</span></label>
									<label class="fRadio"><input type="radio" name="memberYn" value="Y"> <span>회원</span></label>
									<label class="fRadio"><input type="radio" name="memberYn" value="N"> <span>비회원</span></label>
								</td>
							</tr>
						</tbody>
					</table>
				</form>
				
				<div class="btn_area_center">
					<button type="button" onclick="counselList.reload();" class="btn btn-ok">검색</button>
					<button type="button" onclick="counselList.clear();" class="btn btn-cancel">초기화</button>
				</div>
			</div>
		</div>

		<div class="mModule">
			<div class="mButton">
				<div class="rightInner">
					<button type="button" onclick="counselCcListExcelDownload();" class="btn btn-add btn-excel"><spring:message code='column.common.btn.excel_download' /></button>
					<c:if test="${adminConstants.USR_GB_1030 eq adminSession.usrGbCd}" >
					<div style="float:right;margin-right:-5px">
					<span>상담원</span>
					<input type="hidden" id="searchTarget" value=""/>
					<input type="hidden" id="counselCusChrgNo" value="" />
					<input type="text" id="counselCusChrgNm" value="" class="w100 readonly" readonly="readonly"/>
					<button type="button" onclick="counselList.searchUser('D');" class="btn">검색</button>
					<button type="button" onclick="counselList.setMine();" class="btn btn-add">본인</button>
					<button type="button" onclick="counselList.changeChrg();" class="btn btn-add">담당자변경</button>
					</div>
					</c:if>
				</div>
			</div>
				
			<table id="counselList" class="grid"></table>
			<div id="counselListPage"></div>
		</div>
		
	</t:putAttribute>
</t:insertDefinition>