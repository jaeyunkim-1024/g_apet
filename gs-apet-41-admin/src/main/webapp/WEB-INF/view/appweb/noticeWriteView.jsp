<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">
			$(document).ready(function(){
				EditorCommon.setSEditor('content', '${adminConstants.BOARD_IMAGE_PATH}');
				
				//update화면 시 초기 설정 -공지기간
				if($("input[name=selectDateTerm]:checked").val() == 1){
					$("#dateDiv").css("display","contents");
					$("#bbsStrtDtm").datepicker('setDate',"${bbsLetter.bbsStrtDtm}");
					$("#bbsEndDtm").datepicker('setDate',"${bbsLetter.bbsEndDtm}");
				}else {
					$("#bbsStrtDtm").datepicker('setDate',"1999-01-01");
					$("#bbsEndDtm").datepicker('setDate',"9999-12-31");
				}
				
				//fncInactiveWill();
				
				//시작날짜 과거날짜면 게시예정 상태 비활성화 - 그냥 활성화 시키고 알아서 게시중으로 바꾸고 싶을때 바꾸도록
				/* $("#bbsStrtDtm").datepicker().on('change',function(){
					fncInactiveWill();
				}); */
				
				
				if("${bbsLetter.bbsId}" == ''){
					$("input:radio[name=bbsGbNo]").eq(0).attr("checked",true);
				}
				
				
				//'기간 설정' 선택 시 날짜 div 보이게 설정
				$("input[name=selectDateTerm]").change(function(){
					if($("input[name=selectDateTerm]:checked").val() == 0){
						$("#bbsStrtDtm").datepicker('setDate',"1999-01-01");
						$("#bbsEndDtm").datepicker('setDate',"9999-12-31");
						$("#dateDiv").css("display","none");
					}else{
						$("#dateDiv").css("display","contents");
						setSearchDateAdd("40");
					}
				}); 
				
				//update 시 poc 설정
				var pocGb = "${bbsLetter.pocGbCd}";
				if(pocGb != ""){
					var arrpocGb = pocGb.split(",");
					for(var i = 0 ; i < arrpocGb.length ; i++ ){
						var id = "arrPocGb" +  arrpocGb[i];
						$("#"+id).attr("checked", true);
					}
					if ( arrpocGb.length  == 3 ) {
						$("input:checkbox[id=arrPocGb_default]").prop("checked",true);
					}
					
				}else{
					$("input:checkbox[name=arrPocGb]").prop("checked",true);
				}
				
				
				
				//알림 발송 선택 시 날짜 div 보이게 설정
				/* $("input[name=almSndYn]").change(function(){
					if($("input[name=almSndYn]:checked").val() == "N"){
							$("#sendDiv").css("display","none");
					}else{
							$("#sendDiv").css("display","block");
					}
				});  */
			});
			
			$(function(){
				
				//POC 구분 클릭 이벤트
				$("input:checkbox[name=arrPocGb]").click(function(){
					var count = 0;
					$('input:checkbox[name="arrPocGb"]').each( function() {
						if($(this).is(":checked")) count++;
					});
					if ( count  < 3 ) {
						$("input:checkbox[id=arrPocGb_default]").prop("checked",false);
					} else {
						$("input:checkbox[id=arrPocGb_default]").prop("checked",true);
					}
				});
			});

			//게시판 글 등록
			function bbsLetterInsert(){
				oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
				if(!fncValidCheck() ) return false;
				if(validate.check("boardForm")) {
					
					// 내용 체크
					if( !editorRequired( 'content' ) ){ return false };
					
					messager.confirm('<spring:message code="column.common.confirm.insert" />', function(r){
						if(r){
							var options = {
								url : "<spring:url value='/appweb/noticeLetterInsert.do' />"
								, data : $("#boardForm").serializeJson()
								, callBack : function(result){
									messager.alert('<spring:message code="admin.web.view.common.normal_process.final_msg" />', "Info", "info", function(){
										var title = getSeletedTabTitle().replace(' 등록', '');
										updateTab('/appweb/NoticeListView.do', title);	
									});
								}
							};
							ajax.call(options);
						}
					})
				}
			}

			//게시판 글 업데이트
			function bbsLetterUpdate(){
				oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
				if(!fncValidCheck() ) return false;
				
				if( validate.check("boardForm")) {
					// 내용 체크
					if( !editorRequired( 'content' ) ){ return false };
					
					messager.confirm('<spring:message code="column.common.confirm.update" />', function(r){
						if(r){
							var options = {
								url : "<spring:url value='/appweb/noticeLetterInsert.do' />"
								, data : $("#boardForm").serializeJson()
								, callBack : function(result){
									messager.alert('<spring:message code="admin.web.view.common.normal_process.final_msg" />', "Info", "info", function(){
										var title = getSeletedTabTitle().replace(' 상세', '');
										updateTab('/appweb/NoticeListView.do', title);	
									});
								}
							};
							ajax.call(options);
						}
					})
				}
			}
			
			//게시판 글 삭제
			function bbsLetterDelete(){
				var lettNos = new Array();
				
				messager.confirm("<spring:message code='column.common.confirm.delete' />", function(r){
					if(r){
						lettNos.push({lettNo : '${bbsLetter.lettNo}'});
						var options = {
								url : "<spring:url value='/${board.bbsId}/bbsLetterArrDelete.do' />"
								, data : {
									deleteLettNoStr : JSON.stringify(lettNos)
								}
								, callBack : function(result) {
									messager.alert("<spring:message code='column.display_view.message.delete' />", "Info", "info", function(){
										var title = getSeletedTabTitle().replace(' 상세', '');
										updateTab('/appweb/NoticeListView.do', title);
									});
								}
						};
						ajax.call(options);
					}
				})
			}

			//초기화
			function initialization(){
				resetForm("boardForm");
				oEditors.getById["content"].exec("SET_IR", [""]); 
				$("#arrPocGb_default").prop("checked",true);
				$("#bbsStrtDtm").datepicker('setDate',"1999-01-01");
				$("#bbsEndDtm").datepicker('setDate',"9999-12-31");
				$("#dateDiv").css("display","none");
				fncSelectAllPoc();
			}
			
			
			// 공지기간 selectbox로 변경 시 
			function fncSrchDateChange() {
				var term = $("#checkOptDate").children("option:selected").val();
				if(term == "") {
					$("#bbsStrtDtm").val("");
					$("#bbsEndDtm").val("");
				} else {
					setSearchDateAdd(term);
				}
			}
			
			//poc 전체 클릭 시 처리
			function fncSelectAllPoc(){
				var allFlag =$("#arrPocGb_default").is(":checked");
				
				if(allFlag){
					$("input:checkbox[name=arrPocGb]").prop("checked",true);
				}
				else{
					$("input:checkbox[name=arrPocGb]").prop("checked",false);
				}
			}
			
			
			//poc 체크박스/ 종료날짜 과거인지 validate
			function fncValidCheck(){
				var pocVal = $("input[name='arrPocGb']:checked").val();
				if(pocVal == null || pocVal == ""){
					messager.alert('노출 POC를 선택해 주세요. ', "Info", "info");
					return false;
				}
				
				
				if(!fncDateValidate($("#bbsEndDtm").datepicker('getDate'))){
					messager.alert('공지 종료 날짜는 현재날짜보다 과거일 수 없습니다. ', "Info", "info");
					return false;
				}
				
				if($("#ttl").val() == ""){
					messager.alert('제목을 입력해 주세요. ', "Info", "info");
					return false;
				}
				
				if($("#content").val() == "" || $("#content").val() == "<p>&nbsp;</p>"){
					messager.alert('내용을 입력해 주세요. ', "Info", "info");
					return false;
				}
				
				var strContent = $("#content").val().replace(/<img /gi, "img ").replace(/(<([^>]+)>)/gi, "").replace(/&nbsp;/gi, "").replaceAll(" ","").trim();
				if(strContent.length > 2000){
					messager.alert("최대 2000이하로 작성해 주세요.","Info","info");
					return false;
				}
				return true;
			}
			
			//현재날짜보다 과거인지 체크
			function fncDateValidate( selectDate ){
				var today = new Date();
				var year = today.getFullYear(); // 년도
				var month = ("0" + (today.getMonth() +1 )).slice(-2) ;  // 월
				var date = ("0" + (today.getDate())).slice(-2);  // 날짜
				var currentDate = year + '-' + month + '-' + date;

				var selDate =selectDate;
				var year = selDate.getFullYear(); // 년도
				var month = ("0" + (selDate.getMonth() +1 )).slice(-2) ; // 월
				var date = ("0" + (selDate.getDate())).slice(-2);// 날짜
				var selDate = year + '-' + month + '-' + date;
				
				if(selDate < currentDate){
					return false;
				}
				return true;
			}
			
			//datepicker set
			function setSearchDateAdd(term){
				var startDate;
				
				var dateNew = new Date();
				var endDate;
				if(term === "10") {
					endDate = shiftDate(getCurrentTime(), 0, 0, 0, "-");
				} else if(term === "40") {
					endDate = shiftDate(getCurrentTime(), 0, 1, 0, "-");
				} else {
					endDate = shiftDate(getCurrentTime(), 0, 3, 0, "-");
				}
				startDate = toFormatString(getCurrentTime(), "-");
				$("#bbsStrtDtm").datepicker('setDate',startDate);
				$("#bbsEndDtm").datepicker('setDate',endDate);
			}
			
			//시작날짜가 과거날짜면 게시예정 비활성화
			/* function fncInactiveWill(){
				if(!fncDateValidate( $("#bbsStrtDtm").datepicker('getDate'))){
					$("input:radio[name ='bbsStatCd']:input[value='20']").attr("checked", true);
					$("input[name='bbsStatCd']:input[value='10']").attr("disabled",true);
				} else{
					$("input[name='bbsStatCd']:input[value='10']").attr("disabled",false);
				}
			} */	
			
			function fnCallBackFileUpload( file ) {
// 				alert( JSON.stringify( file ) );
				$("#fileName").val( file.fileName );
				$("#filePath").val( file.filePath );
			}
			
		</script>
	</t:putAttribute>
	<t:putAttribute name="content">
			<form name="boardForm" id="boardForm" method="post">
			<input type="hidden" name="lettNo" value="${bbsLetter.lettNo}">
			<table class="table_type1">
				<caption>게시판 글</caption>
				<tbody>
					<tr>
						<th>노출 POC<strong class="red">*</strong></th>
						<td colspan="3" >
							<!-- 노출 POC-->
							<label class="fCheck">
								<input type="checkbox"  id="arrPocGb_default" value="0" onClick="fncSelectAllPoc()" ${ bbsLetter.pocGbCd == null ? 'checked="checked"' :''} > 
								<span >전체</span>
							</label>
							(<frame:checkbox  name="arrPocGb" grpCd="${adminConstants.POC_GB}" />)
						</td>
					</tr>
					<tr>
						<th>분류<strong class="red">*</strong></th>
						<td>
							<!-- 분류-->
							<c:forEach items="${listBoardGb}" var="item">
								<label class="fRadio">
									<input type="radio" class="validate[required]" name="bbsGbNo" value="${item.bbsGbNo}" ${item.bbsGbNo eq bbsLetter.bbsGbNo ? 'checked="checked"':'' }> 
									<span>${item.bbsGbNm }</span>
								</label>
							</c:forEach>
						</td>
						<th>게시상태<strong class="red">*</strong></th>
						<td>
							<!-- 게시상태 -->
							<c:forEach items="${bbsStat}" var="item">
								<label class="fRadio">
									<input type="radio" class="validate[required]" name="bbsStatCd" value="${item.dtlCd }" ${bbsLetter.bbsStatCd != null ? item.dtlCd eq bbsLetter.bbsStatCd ? 'checked="checked"':'' : item.dtlCd eq 10 ? 'checked="checked"' : ''}> 
									<span>${item.dtlNm }</span>
								</label>
							</c:forEach>
						</td>
					</tr>
					<tr>
						<th>상단 고정</th>
						<td colspan="3"> 
							<!-- 상단 고정 -->
								<label class="fRadio">
									<input type="radio"  name="topFixYn" value="Y" ${ bbsLetter.topFixYn == null ?'' : bbsLetter.topFixYn eq 'Y' ? 'checked="checked"':''} > 
									<span>예</span> 
								</label>
								<label class="fRadio">
									<input type="radio"  name="topFixYn" value="N"  ${ bbsLetter.topFixYn == null ? 'checked="checked"' :bbsLetter.topFixYn eq 'N' ? 'checked="checked"':''} > 
									<span>아니오</span>
								</label>
						</td>
					</tr>
					<tr>
						<th>공지기간<strong class="red">*</strong></th>
						<td colspan="3"> 
							<!-- 공지기간-->
								<label class="fRadio">
									<input type="radio" name="selectDateTerm"  value="0" ${ bbsLetter.bbsStrtDtm == null ? 'checked="checked"': bbsLetter.bbsStrtDtm eq '1999-01-01 00:00:00.0'?  'checked="checked"' :''}>  
									<span>무기한</span> 
								</label>
								<label class="fRadio">
									<input type="radio" name="selectDateTerm"  value="1"  ${ bbsLetter.bbsStrtDtm == null ?'' : bbsLetter.bbsStrtDtm eq '1999-01-01 00:00:00.0'? '': 'checked="checked"'} > 
									<span>기간설정</span> 
								</label>
								<div id="dateDiv" style="display:none;" >
									<frame:datepicker startDate="bbsStrtDtm" startValue="${frame:toDate('yyyy-MM-dd')}" endDate="bbsEndDtm" endValue="${frame:addDay('yyyy-MM-dd',90)}" />
									&nbsp;
									<select id="checkOptDate" name="checkOptDate" onchange="fncSrchDateChange();">
										<frame:select grpCd="${adminConstants.SELECT_PERIOD }"  defaultName="기간선택" excludeOption="${adminConstants.SELECT_PERIOD_30 },${adminConstants.SELECT_PERIOD_60 },${adminConstants.SELECT_PERIOD_20 }"/>
									</select>
								</div>
						</td>
					</tr>
					<!-- <tr>
						<th>SEO정보번호</th>
						<td colspan="3"> 
							SEO정보번호
								<label class="fRadio">
									<input type="radio"  name="topFixYn" value="Y"> 
									<span>사용</span>
									<input type="radio"  name="topFixYn" value="N" > 
									<span>미사용</span>
								</label>
						</td>
					</tr> -->
					<tr>
						<th>알림발송 여부<strong class="red">*</strong></th>
						<td colspan="3" style="    padding: 10px;"> 
							<!-- 알림발송 여부 -->
								<label class="fRadio">
									<input type="radio"  name="almSndYn"  value="Y"  ${ bbsLetter.almSndYn == null ? 'checked="checked"' :bbsLetter.almSndYn eq 'Y' ? 'checked="checked"':''}> 
									<span>발송</span>
								</label> 
								<label class="fRadio">
									<input type="radio"  name="almSndYn" value="N" ${ bbsLetter.almSndYn == null ? '' :bbsLetter.almSndYn eq 'N' ? 'checked="checked"':''}> 
									<span>미발송</span>
								</label> 
								<%-- <div id="sendDiv" style="margin: 15px 0px 10px 0px;">
								<frame:checkbox  name="arrSndType" grpCd="${adminConstants.SND_TYPE}" />
								</div> --%>
						</td>
					</tr>
					<tr>
						<th>링크 설정</th>
						<td colspan="3" style="padding: 10px;" >
							<!-- 링크 설정-->
							<div style="display:flex;margin-bottom: 10px;">
								<p style="font-weight:bold;">Web link</p>
								<input type="text"  placeholder="URL입력" name="webLnk" id="linkInput"  value="${bbsLetter.webLnk}" />
							</div>
							<div style="display:flex;">
								<p style="font-weight:bold;">App link</p>
								<input type="text"  placeholder="URL입력" name="appLnk" id="linkInput" value="${bbsLetter.appLnk}" />
							</div>
						</td>
					</tr>
					<tr> 
						<th><spring:message code="column.ttl"/><strong class="red">*</strong></th>
						<td colspan="3" >
							<!-- 제목-->
							<input type="text" class="w400 validate[maxSize[100]]" placeholder="100자 이내 입력" name="ttl" id="ttl" title="<spring:message code="column.ttl"/>" value="${bbsLetter.ttl}" style="width: 70% !important;"/>
						</td>
					</tr>
					<tr>
						<th><spring:message code="column.fl_no"/></th>
						<td colspan="3">
								<div class="buttonArea">
								<input type="hidden" id="fileName" name="fileName" value="" />
				 				<input type="hidden" id="filePath" name="filePath" value="" />
								<button type="button" onclick="fileUpload.file(fnCallBackFileUpload);" class="btn btn-add">양식</a>
							</div>
						</td>
					</tr>
					<tr>
						<th><spring:message code="column.content"/><strong class="red">*</strong></th>
						<td colspan="3" >
						<div disabled >
							<!-- 내용-->
							<textarea style="width: 100%; height: 300px;"  name="content" id="content" placeholder="2000자 이내로 입력하세요." title="<spring:message code="column.content"/>">${bbsLetter.content}</textarea>
						</div>
						<c:if test="${bbsLetter.bbsId != null}">
							<input type="text" style="display:none;" value="upd" name="usrDfn5Val"/>  <!-- update인거 표시 --> 
							<input type="text" style="display:none;" value="${bbsLetter.pocGbCd}" name="usrDfn4Val"/>  <!-- 원래 poc  -->
						</c:if>
						</td>
					</tr>
				</tbody>
			</table>
			</form>

			<div class="btn_area_center">
			<c:if test="${bbsLetter.bbsId == null}">
				<button type="button" onclick="bbsLetterInsert();" class="btn btn-ok">등록</button>
				<button type="button" onclick="initialization();" class="btn btn-cancel">초기화</button>
				<button type="button" onclick="closeTab();" class="btn btn-cancel">취소</button>
			</c:if>
			<c:if test="${bbsLetter.bbsId != null}">
				<button type="button" onclick="bbsLetterUpdate();" class="btn btn-ok">저장</button>
				<button type="button" onclick="bbsLetterDelete();" class="btn btn-cancel">삭제</button>
				<button type="button" onclick="closeTab();" class="btn btn-cancel">닫기</button>
			</c:if>
				
			</div>
	</t:putAttribute>
</t:insertDefinition>
<style>
#linkInput{
	width : 70%;
	margin-left : 10px
}
</style>
