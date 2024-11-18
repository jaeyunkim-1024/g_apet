<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">
			$(document).ready(function(){
				searchDateChange();
				counselList.create();
				newSetCommonDatePickerEvent('#cusAcptDtmStart','#cusAcptDtmEnd');
				
				$(document).on("keydown","#counselSearchForm input",function(){
	      			if ( window.event.keyCode == 13 ) {
	      				counselList.reload();
	    		  	}
	            });					
			});


			// CS 카테고리 1 선택
			/* $(document).on("change", "#cusCtg1Cd",function(e) {
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

			}); */

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

			var counselList = {
					
				// 생성
				create : function(){
					var options = {
						url : "<spring:url value='/counsel/web/counselWebListGrid.do' />"
						, datatype : 'local'
						, height : 400
						, searchParam : $("#counselSearchForm").serializeJson()
						, colModels : [
							//상담 번호
							{name:"cusNo", label:'<spring:message code="column.cus_no" />', width:"80", align:"center"}
							//상담 경로 코드
							, {name:"cusPathCd", label:'<spring:message code="column.cus_path_cd" />', width:"80", align:"center", hidden:true, formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.CUS_PATH}" />"}}
							//상담 접수 일시
							, {name:"cusAcptDtm", label:'<b><u><tt><spring:message code="column.cus_acpt_dtm" /></tt></u></b>', width:"200", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss", classes:'pointer fontbold'}
							//상담 상태 코드
							, {name:"cusStatCd", label:'<spring:message code="column.cus_stat_cd" />', width:"80", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.CUS_STAT}" />"}}
							//문의자 명
							, {name:"eqrrNm", label:'<spring:message code="column.eqrr_info" />', width:"150", align:"center", formatter:function(cellvalue, options, rowObject) {
								return rowObject.eqrrNm + " (" + rowObject.loginId + ")";
							}}
							// 상담 카테고리1 코드
							, {name:"cusCtg1Cd", label:'<spring:message code="column.cus_ctg" />', width:"150", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.CUS_CTG1}" />"}}
							// 문의 내용
							, {name:"content", label:'<spring:message code="column.iqr_content" />', width:"300", align:"center", classes:'pointer fontbold'}
							//처리자
							, {name:"cusCpltrNm", label:'<spring:message code="column.prcsr_nm" />', width:"100", align:"center"}
							//상담 완료 일시
							, {name:"cusCpltDtm", label:'<spring:message code="column.cus_cplt_dtm" />', width:"180", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss"}
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
					compareDateAlert('cusAcptDtmStart','cusAcptDtmEnd','term');
					
					var data = $("#counselSearchForm").serializeJson();

					if ( undefined != data.arrCusStatCd && data.arrCusStatCd != null && Array.isArray(data.arrCusStatCd) ) {
						$.extend( data, { arrCusStatCd : data.arrCusStatCd.join(",") } );
					}

					var options = {
						searchParam : data
					}
					
					gridReload('cusAcptDtmStart','cusAcptDtmEnd','counselList','term', options);
				}
				// 검색 초기화
				, clear : function(){
					resetForm('counselSearchForm');
					searchDateChange();
					$("#cusCtg2Cd").html("");
					$("#cusCtg3Cd").html("");

				}
				// 상세 화면 호출
				, detailView : function(cusNo){
					addTab('1:1 문의 상세 - ' + cusNo, '/counsel/web/counselWebView.do?cusNo=' + cusNo);
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
				<c:if test="${adminConstants.USR_GB_1030 eq adminSession.usrGbCd || adminConstants.USR_GB_1031 eq adminSession.usrGbCd}" >
				<c:if test="${adminConstants.USR_GB_1030 eq adminSession.usrGbCd}" >
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
				</c:if>
				// 담당자 지정
				, insertChrg : function(){
					var cusNos = new Array();
					var grid = $("#counselList" );
					var rowids = grid.jqGrid('getGridParam', 'selarrrow');

					if(rowids.length < 1){
						messager.alert("<spring:message code='admin.web.view.msg.counsel.web.select.counsel' />","Info","info");
						return;
					}

					for (var i = 0; i < rowids.length; i++) {
						var rowData = grid.jqGrid('getRowData', rowids[i]);
						cusNos.push(rowData.cusNo);

						if(rowData.cusChrgNo != ""){
							messager.alert("<spring:message code='admin.web.view.msg.counsel.web.changemanager' />","Info","info");
							return;
						}

						if(rowData.cusStatCd != "${adminConstants.CUS_STAT_10}"){
							messager.alert("<spring:message code='admin.web.view.msg.counsel.web.status' />","Info","info");
							return;
						}
					}

					if($("#counselCusChrgNm").val() == ""){
						messager.alert("<spring:message code='admin.web.view.msg.counsel.web.select.manager' />","Info","info");
						return;
					}
					
					messager.confirm("<spring:message code='admin.web.view.msg.counsel.web.assign' />",function(r){
						if(r){
							this.updateChrg(cusNos);				
						}
					});
				}
				<c:if test="${adminConstants.USR_GB_1030 eq adminSession.usrGbCd}" >
				// 담당자 변경
				, changeChrg : function(){
					var cusNos = new Array();
					var grid = $("#counselList" );
					var rowids = grid.jqGrid('getGridParam', 'selarrrow');

					if(rowids.length < 1){
						messager.alert("<spring:message code='admin.web.view.msg.counsel.web.select.counsel' />","Info","info");
						return;
					}

					for (var i = 0; i < rowids.length; i++) {
						var rowData = grid.jqGrid('getRowData', rowids[i]);
						cusNos.push(rowData.cusNo);

						if(rowData.cusChrgNo == ""){
							messager.alert("<spring:message code='admin.web.view.msg.counsel.web.nomanager' />","Info","info");
							return;
						}

						if(rowData.cusStatCd == "${adminConstants.CUS_STAT_30}" || rowData.cusStatCd == "${adminConstants.CUS_STAT_40}"){
							messager.alert("<spring:message code='admin.web.view.msg.counsel.web.change.manager' />","Info","info");
							return;
						}

					}

					if($("#counselCusChrgNm").val() == ""){
						messager.alert("<spring:message code='admin.web.view.msg.counsel.web.select.manager' />","Info","info");
						return;
					}

					messager.confirm("<spring:message code='admin.web.view.msg.counsel.web.change' />",function(r){
						if(r){
							this.updateChrg(cusNos);					
						}
					});
				}
				</c:if>
				, updateChrg : function(cusNos){
					var options = {
						url : "<spring:url value='/counsel/web/updateCounselChrg.do' />"
						, data : {cusNos : cusNos, cusChrgNo : $("#counselCusChrgNo").val()}
						, callBack : function(data) {
							messager.alert("<spring:message code='admin.web.view.msg.counsel.web.done' />","Info","info",function(){

								counselList.reload();
							});							
						}
					};

	 				ajax.call(options);
				}
				</c:if>
			};
			
			// 등록기간 
			function searchDateChange() {
				var term = $("#checkOptDate").children("option:selected").val();
				if(term == "") {
					$("#cusAcptDtmStart").val("");
					$("#cusAcptDtmEnd").val("");
				}else if(term =="50"){ 
					setSearchDateThreeMonth("cusAcptDtmStart","cusAcptDtmEnd"); //3개월 기간조회시에만 호출하는 메소드
				}else{
					  setSearchDate(term, "cusAcptDtmStart", "cusAcptDtmEnd");
				}
			}

		</script>
	</t:putAttribute>
	<t:putAttribute name="content">

		<div class="easyui-accordion search-accordion" data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect" style="width:100%">
			<div title="<spring:message code='admin.web.view.common.search' />" style="padding:10px">
				<form name="counselSearchForm" id="counselSearchForm">
					<input type="hidden" name="stId" id="stId" value="1" />
					<table class="table_type1">
						<caption>정보 검색</caption>
						<tbody>
							<tr>
								<th><spring:message code='column.cus_status_cd' /></th>
								<td>
									<select name="cusStatCd" id="cusStatCd" title="<spring:message code='column.use_yn' />">
										<frame:select grpCd="${adminConstants.CUS_STAT}" selectKey="${adminConstants.CUS_STAT_10}" defaultName="전체" />
									</select>
								</td>
								<th scope="row"><spring:message code="column.cus_ctg_cd" /></th>
								<td>
									<select name="cusCtg1Cd" id="cusCtg1Cd" class="w120" title="선택상자" >
										<frame:select grpCd="${adminConstants.CUS_CTG1 }" defaultName="전체" useYn="Y" />
									</select>
								<!-- 상담 담당자 -->
								<th scope="row"><spring:message code="column.cus_search" /></th>
								<td>
									<input type="text" name="content" id="content" />
								</td>
							</tr>
							<tr>
								<!-- 사이트 ID -->
								<th scope="row"><spring:message code="column.cus_id" /></th>
								<td>
		                           <input type="text" id="loginId" name="loginId" value="" />
								</td>
								<!-- 문의자 휴대폰 -->
								<th scope="row"><spring:message code="column.cus_mobile_no" /></th>
								<td>
									<input type="text" name="eqrrMobile" id="eqrrMobile" value="" />
								</td>
								<!-- 문의자 휴대폰 -->
								<th scope="row"><spring:message code="column.cus_prcsr" /></th>
								<td>
									<input type="text" name="cusCpltrNm" id="cusCpltrNm" value="" />
								</td>
							</tr>
							<tr>
								<!-- 상담접수일자 -->
								<th scope="row"><spring:message code="column.cus_acpt_dtm" /></th>
								<td colspan="5">
									<frame:datepicker startDate="cusAcptDtmStart" endDate="cusAcptDtmEnd" period="-30" startValue="${frame:toDate('yyyy-MM-dd')}" endValue="${frame:toDate('yyyy-MM-dd')}"/>
									&nbsp;&nbsp;
									<select id="checkOptDate" name="checkOptDate" onchange="searchDateChange();">
										<frame:select grpCd="${adminConstants.SELECT_PERIOD }" selectKey="${adminConstants.SELECT_PERIOD_40 }" defaultName="기간선택" />
									</select>
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

		<!-- ==================================================================== -->
		<!-- 그리드 -->
		<!-- ==================================================================== -->
		<div class="mModule">
			<c:if test="${adminConstants.USR_GB_1030 eq adminSession.usrGbCd || adminConstants.USR_GB_1031 eq adminSession.usrGbCd}" >
			<div class="mButton">
				<div class="rightInner">
					<div style="float:right;margin-right:-5px">
					<c:if test="${adminConstants.USR_GB_1030 eq adminSession.usrGbCd}">
					
					<span>상담원</span>
					<input type="hidden" id="searchTarget" value=""/>
					<input type="hidden" id="counselCusChrgNo" value="" />
					<input type="text" id="counselCusChrgNm" value="" class="w100 readonly" readonly="readonly" />
					<button type="button" onclick="counselList.searchUser('D');" class="btn">검색</button>
					<button type="button" onclick="counselList.setMine();" class="btn btn-add">본인</button>
					<button type="button" onclick="counselList.insertChrg();" class="btn btn-add">담당자지정</button>
					<button type="button" onclick="counselList.changeChrg();" class="btn btn-add">담당자변경</button>
					</c:if>
					<c:if test="${adminConstants.USR_GB_1031 eq adminSession.usrGbCd}">
					<input type="hidden" id="counselCusChrgNo" value="${adminSession.usrNo}" />
					<input type="hidden" id="counselCusChrgNm" value="${adminSession.usrNm}" />
					<button type="button" onclick="counselList.insertChrg();" class="btn btn-add">담당자지정</button>
					</c:if>
					</div>
				</div>
			</div>
			</c:if>
						
			<table id="counselList" ></table>
			<div id="counselListPage"></div>
		</div>
		<!-- ==================================================================== -->
		<!-- //그리드 -->
		<!-- ==================================================================== -->

	</t:putAttribute>
</t:insertDefinition>