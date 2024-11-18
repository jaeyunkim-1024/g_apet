<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">
			var termsCtgList = null;
			
			$(document).ready(function() {
				//약관 적용기간 종료일 수정불가 처리
				$("input[name=termsEndDt]").prop("disabled", true);
				
				//에디터 셋팅
				initEditor();
				
				//약관 카테고리 조회
				fncTermsCtg1();
				
				if("${empty termsDetailInfo}" == "false"){
					//수정시 노출 POC '전체' 체크 해제
					$("#arrPocGb_default").prop("checked", false);
					
					//최신버전이 아니면 수정불가 처리
					if("${termsDetailInfo.newYn}" == "N"){
						$("input[name=arrPocGb]").prop("disabled", true);
						$("#useYn").prop("disabled", true);
						$("#termsNm").prop("disabled", true);
						$("#termsStrtDt").prop("disabled", true);
						$("#upBtn").hide();
					}
				}
			});
			
			//에디터 셋팅
			function initEditor () {
				//최신버전이 아니면 에디어 수정불가 처리
				var disabledYn = "N";
				if("${empty termsDetailInfo}" == "false" && "${termsDetailInfo.newYn}" == "N"){
					disabledYn = "Y";
				}
				
				EditorCommon.setSEditor('smryContent', '${adminConstants.TERMS_SMRY_CONT_PATH}', disabledYn, "N");
				EditorCommon.setSEditor('content', '${adminConstants.TERMS_CONT_PATH}', disabledYn, "N");
			}
			
			$(function(){
				//POC 구분 클릭 이벤트
				$("input:checkbox[name=arrPocGb]").click(function(){
					var all = false;
					if ( validation.isNull( $(this).val() ) ){
						all = true;
					}
					if ( $('input:checkbox[name="arrPocGb"]:checked').length == 0 ) {
						//$('input:checkbox[name="arrPocGb"]').eq(0).prop( "checked", true );
					} else {
						$('input:checkbox[name="arrPocGb"]').each( function() {
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
			});
			
			//약관 카테고리 1Depth 조회
			function fncTermsCtg1(){
				var options = {
					url : "<spring:url value='/appweb/getTermsCategoryList.do' />"
					, data : {}
					, callBack : function(result) {
						if(result.length != 0){
							termsCtgList = result;
							
							if("${empty termsDetailInfo}" == "true"){
								let htmlString = "";
								for(idx in termsCtgList){
									if(termsCtgList[idx].usrDfn1Val == ''){
										//htmlString += '<option value="'+result[idx].dtlCd+'" data-usrdfn1="'+result[idx].usrdfn1+'" title="'+result[idx].dtlNm+'">'+result[idx].dtlNm+'</option>';
										htmlString += '<option value="'+termsCtgList[idx].dtlCd+'" title="'+termsCtgList[idx].dtlNm+'"';
										htmlString += '>'+termsCtgList[idx].dtlNm+'</option>';
									}
	                    		}
								
								$("#termsCd1").append(htmlString);
							}
						}
					}
				};
				
				ajax.call(options);
			}
			
			//약관 카테고리 2Depth 조회
			function fncTermsCtg2(){
				$("#termsCd2").html('<option value="">전체</option>');
				//$("#termsCd2").prop("disabled", true);
				$("#termsCd3").html('<option value="">전체</option>');
				//$("#termsCd3").prop("disabled", true);
				//$("#termsVer").val("");
				
				if($("#termsCd1").val() != ""){
					let htmlString = "";
					for(idx in termsCtgList){
						if($("#termsCd1").val() == termsCtgList[idx].usrDfn1Val && termsCtgList[idx].usrDfn2Val == ''){
							htmlString += '<option value="'+termsCtgList[idx].dtlCd+'" title="'+termsCtgList[idx].dtlNm+'"';
							htmlString += '>'+termsCtgList[idx].dtlNm+'</option>';
						}
	        		}
					$("#termsCd2").append(htmlString);
					//$("#termsCd2").prop("disabled", false);
				}
				
				/* var options = {
					url : "<spring:url value='/appweb/getTermsCategoryList.do' />"
					, data : {
						code : $("#termsCd1").val()
					}
					, callBack : function(result) {
						if(result.length != 0){
							let htmlString = "";
							
							for(idx in result){
                    			//htmlString += '<option value="'+result[idx].dtlCd+'" data-usrdfn1="'+result[idx].usrdfn1+'" title="'+result[idx].dtlNm+'">'+result[idx].dtlNm+'</option>';
								htmlString += '<option value="'+result[idx].dtlCd+'" title="'+result[idx].dtlNm+'"';
								htmlString += '>'+result[idx].dtlNm+'</option>';
                    		}
							
							$("#termsCd2").append(htmlString);
							$("#termsCd2").prop("disabled", false);
						}
					}
				};
				
				ajax.call(options); */
			}
			
			//약관 카테고리 3Depth 조회
			function fncTermsCtg3(){
				$("#termsCd3").html('<option value="">전체</option>');
				//$("#termsCd3").prop("disabled", true);
				//$("#termsVer").val("");
				
				if($("#termsCd2").val() != ""){
					let htmlString = "";
					for(idx in termsCtgList){
						<%--if(($("#termsCd1").val()+$("#termsCd2").val()) == termsCtgList[idx].usrDfn1Val){--%>
						if($("#termsCd2").val() == termsCtgList[idx].usrDfn2Val){
							htmlString += '<option value="'+termsCtgList[idx].dtlCd+'" title="'+termsCtgList[idx].dtlNm+'"';
							htmlString += '>'+termsCtgList[idx].dtlNm+'</option>';
						}
	        		}
					$("#termsCd3").append(htmlString);
					//$("#termsCd3").prop("disabled", false);
				}
				
				/* var options = {
					url : "<spring:url value='/appweb/getTermsCategoryList.do' />"
					, data : {
						code : $("#termsCd1").val()+$("#termsCd2").val()
					}
					, callBack : function(result) {
						if(result.length != 0){
							let htmlString = "";
							
							for(idx in result){
                    			//htmlString += '<option value="'+result[idx].dtlCd+'" data-usrdfn1="'+result[idx].usrdfn1+'" title="'+result[idx].dtlNm+'">'+result[idx].dtlNm+'</option>';
								htmlString += '<option value="'+result[idx].dtlCd+'" title="'+result[idx].dtlNm+'"';
								htmlString += '>'+result[idx].dtlNm+'</option>';
                    		}
							
							$("#termsCd3").append(htmlString);
							$("#termsCd3").prop("disabled", false);
						}
					}
				};
				
				ajax.call(options); */
			}
			
			//약관 버전 조회
			function fncTermsVerCheck(){
				if($("#termsCd3").val() == ""){
					$("#termsVer").val("");
				}else{
					$("#termsCd").val($("#termsCd3").val());
					
					var options = {
						url : "<spring:url value='/appweb/getTermsVerCheck.do' />"
						, data : {
							code : $("#termsCd3").val()
						}
						, callBack : function(result) {
							$("#termsVer").val(result);
						}
					};
					ajax.call(options);
				}
			}
			
			//요소 위치로 이동
			function fnMove(obj){
				var offset = $(obj).offset();
				$('html, body').animate({scrollTop : offset.top-50}, 100);
			}
			
			//유효성 체크
			function fncValidation(){
				if ( $('input:checkbox[name="arrPocGb"]:checked').length == 0 ) {
					messager.alert('<spring:message code="admin.web.view.msg.terms.rqid.poc" />', "Info", "info", function(){ <!-- 노출 POC 구분을 선택해 주세요. -->
						fnMove($("#arrPocGb_default"));
					});
					return false;
				}
				
				if( $("#termsCd3").val() == "" ){
					messager.alert('<spring:message code="admin.web.view.msg.terms.rqid.ctg" />', "Info", "info", function(){ <!-- 약관 카테고리를 선택해 주세요. -->
						$("#termsCd1").focus();
					});
					/* messager.alert("약관 카테고리는 3Depth까지 선택해 주세요.", "Info", "info", function(){
						$("#termsCd1").focus();
					}); */
					return false;
				}
				
				if( $("#termsVer").val() == "" ){
					messager.alert('<spring:message code="admin.web.view.msg.terms.rqid.ver" />', "Info", "info", function(){ <!-- 약관 버전 정보를 입력해 주세요. -->
						$("#termsVer").focus();
					});
					return false;
				}
				
				if( $("#termsNm").val() == "" ){
					messager.alert('<spring:message code="admin.web.view.msg.terms.rqid.terms_nm" />', "Info", "info", function(){ <!-- 약관명을 입력해 주세요. -->
						$("#termsNm").focus();
					});
					return false;
				}
				
				if( $("#termsNm").val().length > 100 ){
					messager.alert('<spring:message code="admin.web.view.msg.terms.rqid.terms_nm_limit" />', "Info", "info", function(){ <!-- 약관명은 100자까지 입력 가능합니다. -->
						$("#termsNm").focus();
					});
					return false;
				}
				
				if( $("#termsStrtDt").val() == "" ){
					messager.alert('<spring:message code="admin.web.view.msg.terms.rqid.period_st" />', "Info", "info", function(){ <!-- 약관 적용기간 시작일을 선택해 주세요. -->
						$("#termsStrtDt").focus();
					});
					return false;
				}
				
				<%--var strSmryContent = $("#smryContent").val().replace(/<img /gi, "img ").replace(/(<([^>]+)>)/gi, "").replace(/&nbsp;/gi, "").trim();
				if(strSmryContent.length > 2000){
					messager.alert('<spring:message code="admin.web.view.msg.terms.rqid.smry_cont_limit" />', "Info", "info"); <!-- 약관 요약정보는 2000자까지 입력 가능합니다. -->
					return false;
				}--%>
				
				var strContent = $("#content").val().replace(/<img /gi, "img ").replace(/(<([^>]+)>)/gi, "").replace(/&nbsp;/gi, "").trim();
				if(strContent === ""){
					messager.alert('<spring:message code="admin.web.view.msg.terms.rqid.content" />', "Info", "info", function(){ <!-- 약관내용을 입력해 주세요. -->
						$("#content").focus();
					});
					return false;
				}
				
				<%--if(strContent.length > 2000){
					messager.alert('<spring:message code="admin.web.view.msg.terms.rqid.cont_limit" />', "Info", "info"); <!-- 약관 내용은 2000자까지 입력 가능합니다. -->
					return false;
				}--%>
				
				return true;
			}
			
			//데이터 셋팅
			function fncSerializeFormData() {
	            var data = $("#termsForm").serializeJson();
	            if ( undefined != data.arrPocGb && data.arrPocGb != null && Array.isArray(data.arrPocGb) ) {
	                $.extend(data, {arrPocGb : data.arrPocGb.join(",")});
	            } else {
	                // 전체를 선택했을 때 Array.isArray 가 false 여서 이 부분을 실행하게 됨.
	                // 전체를 선택하면 검색조건의 모든 POC구분을 배열로 만들어서 파라미터 전달함.
	                var arrPocGb = new Array();
	                if ($("#arrPocGb_default").is(':checked')) {
	                    $('input:checkbox[name="arrPocGb"]').each( function() {
	                        if (! $(this).is(':checked')) {
	                        	arrPocGb.push($(this).val());
	                        }
	                    });

	                    $.extend(data, {arrPocGb : arrPocGb.join(",")});
	                }
	            }
	            
	            $.extend(data, {termsVer : Math.floor($("#termsVer").val())});
	            
	            return data;
			}
			
			//통합약관 등록
			function fncInsertTerms(){
				oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
				oEditors.getById["smryContent"].exec("UPDATE_CONTENTS_FIELD", []);
				
				if(fncValidation()){
					// 약관 내용 체크
					//if( !editorRequired( 'content' ) ){ return false };
					
					var options = {
						url : "<spring:url value='/appweb/insertTerms.do' />"
						, data : fncSerializeFormData()
						, callBack : function (data) {
							updateTab('/appweb/termsListView.do', "통합약관 목록");
							closeTab();
							//closeGoTab("통합약관 목록", '/appweb/termsListView.do');
						}
					};
					
					ajax.call(options);
				}
			}
			
			//통합약관 수정
			function fncUpdateTerms(){
				var url = "";
				if("${termsSO.verUpYn}" == "Y"){
					url = "<spring:url value='/appweb/insertTerms.do' />";
				}else{
					url = "<spring:url value='/appweb/updateTerms.do' />";
				}
				
				oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
				oEditors.getById["smryContent"].exec("UPDATE_CONTENTS_FIELD", []);
				
				if(fncValidation()){
					// 약관 내용 체크
					//if( !editorRequired( 'content' ) ){ return false };
					
					var options = {
						url : url
						, data : fncSerializeFormData()
						, callBack : function (data) {
							updateTab('/appweb/termsListView.do', "통합약관 목록");
							closeTab();
							//closeGoTab("통합약관 목록", '/appweb/termsListView.do');
						}
					};
					
					ajax.call(options);
				}
			}
			
			//초기화
			function fncReset(){
				resetForm ("termsForm");
				
				fncTermsCtg2();
				
				oEditors.getById["content"].exec("SET_IR", ['']);
				oEditors.getById["smryContent"].exec("SET_IR", ['']);
			}
			
		</script>
	</t:putAttribute>
	<t:putAttribute name="content">
		<form name="termsForm" id="termsForm" method="post">
			<input type="hidden" id="termsNo" name="termsNo" value="${termsDetailInfo.termsNo }"/>
			
			<table class="table_type1">
				<caption>통합약관 신규등록</caption>
				<tbody>
					<tr>
						<th scope="row"><spring:message code="column.version.out_poc" /><strong class="red">*</strong></th> <!-- 노출 POC -->
						<td colspan="3">
							<frame:checkbox name="arrPocGb" grpCd="${adminConstants.TERMS_POC_GB}" defaultName="전체" defaultId="arrPocGb_default" checkedArray="${termsDetailInfo.pocGbCd }"/>
						</td>
					</tr>
					<tr>
						<th scope="row"><spring:message code="column.terms_category" /><strong class="red">*</strong></th> <!-- 약관 카테고리 -->
						<td>
							<select name="termsCd1" id="termsCd1" onchange="fncTermsCtg2();" class="w100" <c:if test="${not empty termsDetailInfo && termsSO.verUpYn != 'Y' }">disabled</c:if> >
								<option value="">전체</option>
								<c:if test="${not empty termsDetailInfo }">
									<c:forEach items="${codeList }" var="list" varStatus="status">
										<c:if test="${list.usrDfn1Val == '' }">
											<option value="${list.dtlCd }" title="${list.dtlNm }" <c:if test="${list.dtlCd == termsDetailInfo.termsCd1 }">selected</c:if> >${list.dtlNm }</option>
										</c:if>
									</c:forEach>
								</c:if>
							</select>
							<select name="termsCd2" id="termsCd2" onchange="fncTermsCtg3();" class="w100" <c:if test="${not empty termsDetailInfo && termsSO.verUpYn != 'Y' }">disabled</c:if> >
								<option value="">전체</option>
								<c:if test="${not empty termsDetailInfo }">
									<c:forEach items="${codeList }" var="list" varStatus="status">
										<c:if test="${list.usrDfn1Val == termsDetailInfo.termsCd1 && list.usrDfn2Val == '' }">
											<option value="${list.dtlCd }" title="${list.dtlNm }" <c:if test="${list.dtlCd == termsDetailInfo.termsCd2 }">selected</c:if> >${list.dtlNm }</option>
										</c:if>
									</c:forEach>
								</c:if>
							</select>
							<select name="termsCd3" id="termsCd3" onchange="fncTermsVerCheck();" class="w100" <c:if test="${not empty termsDetailInfo && termsSO.verUpYn != 'Y' }">disabled</c:if> >
								<option value="">전체</option>
								<c:if test="${not empty termsDetailInfo }">
									<c:forEach items="${codeList }" var="list" varStatus="status">
										<c:if test="${list.usrDfn2Val == termsDetailInfo.termsCd2 }">
											<option value="${list.dtlCd }" title="${list.dtlNm }" <c:if test="${list.dtlCd == termsDetailInfo.termsCd3 }">selected</c:if> >${list.dtlNm }</option>
										</c:if>
									</c:forEach>
								</c:if>
							</select>
						</td>
						<th scope="row"><spring:message code="column.terms_ver" /><strong class="red">*</strong></th> <!-- 약관 버전 -->
						<td>
							<input type="text" id="termsVer" name="termsVer" title="<spring:message code="column.terms_ver" />" disabled="disabled" value="${termsDetailInfo.termsVer }"/>
						</td>
					</tr>
					<tr>
						<th scope="row"><spring:message code="column.terms_rqidyn" /><strong class="red">*</strong></th> <!-- 동의 필수여부 -->
						<td>
							<select name="rqidYn" id="rqidYn" <%--<c:if test="${not empty termsDetailInfo && termsSO.verUpYn != 'Y' }">disabled</c:if>--%> >
								<option value="Y" <c:if test="${termsDetailInfo.rqidYn eq 'Y' }">selected</c:if> >필수</option>
								<option value="N" <c:if test="${termsDetailInfo.rqidYn eq 'N' }">selected</c:if> >선택</option>
							</select>
						</td>
						<th><spring:message code="column.terms_useyn" /><strong class="red">*</strong></th> <!-- 약관 사용여부 -->
						<td>
							<select name="useYn" id="useYn">
								<frame:select grpCd="${adminConstants.USE_YN}" selectKey="${termsDetailInfo.useYn}"/>
							</select>
						</td>
					</tr>
					<tr>
						<th scope="row"><spring:message code="column.terms_nm" /><strong class="red">*</strong></th> <!-- 약관명 -->
						<td colspan="3">
							<input type="text" class="w500 validate[maxSize[10]]" name="termsNm" id="termsNm" title="약관명" value="${termsDetailInfo.termsNm }"/>
						</td>
					</tr>
					<tr>
						<th scope="row"><spring:message code="column.terms_appl_period" /><strong class="red">*</strong></th> <!-- 약관 적용기간 -->
						<td colspan="3">
							<frame:datepicker startDate="termsStrtDt" startValue="${empty termsDetailInfo ? frame:addDay('yyyy-MM-dd', 1) : termsDetailInfo.termsStrtDt}" endDate="termsEndDt" endValue="${empty termsDetailInfo ? '9999-12-31' : termsDetailInfo.termsEndDt}"/>
						</td>
					</tr>
					<tr>
						<th scope="row"><spring:message code="column.terms_smry_content" /></th>	<!-- 약관 요약정보 -->
						<td colspan="3">
							<textarea name="smryContent" id="smryContent" cols="30" rows="10" style="width:100%;height:200px;">${termsDetailInfo.summaryContent }</textarea>
						</td>
					</tr>
					<tr>
						<th scope="row"><spring:message code="column.terms_content" /><strong class="red">*</strong></th>	<!-- 약관 내용 -->
						<td colspan="3">
							<!-- <textarea name="content" id="content" class="validate[required]" cols="30" rows="10" style="width:100%;height:500px;"></textarea> -->
							<textarea name="content" id="content" cols="30" rows="10" style="width:100%;height:200px;">${termsDetailInfo.content }</textarea>
						</td>
					</tr>
				</tbody>
			</table>
		</form>

		<div class="btn_area_center">
			<%-- <c:if test="${empty termsDetailInfo || (not empty termsDetailInfo && termsSO.verUpYn eq 'Y') }"> --%>
			<c:if test="${empty termsDetailInfo }">
			<button type="button" id="saveBtn" onclick="fncInsertTerms();" class="btn btn-ok">등록</button>
			<button type="button" id="reBtn" onclick="fncReset();" class="btn btn-cancel">초기화</button>
			<button type="button" id="cloBtn" onclick="closeTab();" class="btn btn-cancel">취소</button>
			</c:if>
			<%-- <c:if test="${not empty termsDetailInfo && termsSO.verUpYn ne 'Y' }"> --%>
			<c:if test="${not empty termsDetailInfo }">
			<button type="button" id="upBtn" onclick="fncUpdateTerms();" class="btn btn-ok">저장</button>
			<button type="button" id="listBtn" onclick="closeTab();" class="btn btn-cancel">목록</button>
			</c:if>
		</div>
	</t:putAttribute>
</t:insertDefinition>