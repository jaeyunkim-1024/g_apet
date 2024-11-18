<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">
		$(document).ready(function() {
			stPolicyListGrid();
			//문자 입력 방지
			$(document).on("input paste change","[name='csTelNo']",function(){
				var inputVal = $("[name='csTelNo']").val();
				$("[name='csTelNo']").val(inputVal.replace(/[ㄱ-ㅎ|ㅏ-ㅣ|가-힣a-zA-Z]/gi,''));
			})
		});

		// 이미지 업로드 결과
		function resultImage (file ) {
			$("#logoImgPath").val(file.filePath);
			$("#logoImgPathView").attr('src', '/common/imageView.do?filePath=' + file.filePath );
		}

		function deleteLogoImage () {
			$("#orgLogoImgPath").val("");
			$("#logoImgPath").val("");
			$("#logoImgPathView").attr('src', '/images/noimage.png' );
		}

		// St 수정
		function updateSt () {
			if(fnFormValidate()) {
				var formData = $("#stUpdateForm").serializeJson();
				var orgLogoImgPath = $('#orgLogoImgPath').val();

				// Form 데이터
				var sendData = {
					stStdInfoPO : JSON.stringify(formData )
					, orgLogoImgPath : orgLogoImgPath
				}

				messager.confirm("<spring:message code='column.common.confirm.update' />", function(r){
					if(r){
						var options = {
							url : "<spring:url value='/st/stUpdate.do' />"
							, data : sendData
							, callBack : function (data ) {
								messager.alert("<spring:message code='column.common.edit.final_msg' />", "Info", "info", function(){
									updateTab();
								});
							}
						};
						ajax.call(options);
					}
				})
			}
		}
		
		// 사이트 정책 
		function stPolicyListGrid () {
			var options = {
				url : "<spring:url value='/st/stPolicyListGrid.do' />"
				, searchParam : { stId : '${stStdInfo.stId}' }
				, paging : false
				, height : 200
				, colModels : [
							  {name:"stPlcNo", label:'<spring:message code="column.st_plc_no" />', width:"130", align:"center"}//사이트 정책 번호
							, {name:"stId", label:'<spring:message code="column.st_id" />', width:"110", align:"center"}//사이트 번호
							, {name:"stNm", label:'<spring:message code="column.st_nm" />', width:"150", align:"center", sortable:false}//사이트 명
							, {name:"stUrl", label:'<spring:message code="column.st_url" />', width:"250", align:"center"}//사이트 URL
							, {name:"stSht", label:'<spring:message code="column.st_sht" />', width:"120", align:"center"}//사이트 약어
							, {name:"stPlcGbCd", label:'<spring:message code="column.st_plc_gb_cd" />', width:"200", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.COMP_PLC_GB}" />"}}//업체 정책 구분 코드
							, {name:"sortSeq", label:'<spring:message code="column.sort_seq" />', width:"90", align:"center"}//정렬순서
							, {name:"content", label:'<spring:message code="column.contents" />', width:"120", align:"center", hidden:true}//내용
							, {name:"dispYn", label:'<spring:message code="column.disp_yn" />', width:"100", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.COMM_YN}" />"}}//전시여부
							, {name:"sysRegrNm", label:'<spring:message code="column.sys_regr_nm" />', width:"100", align:"center"}//시스템 등록자
							, {name:"sysRegDtm", label:'<spring:message code="column.sys_reg_dtm" />', width:"150", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss"}//시스템 등록 일시
							, {name:"sysUpdrNm", label:'<spring:message code="column.sys_updr_nm" />', width:"100", align:"center"}//시스템 수정자
							, {name:"sysUpdDtm", label:'<spring:message code="column.sys_upd_dtm" />', width:"150", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss"}//시스템 수정 일시
				]
				, multiselect : true 
				
				, onCellSelect : function (ids, cellidx, cellvalue) {
					if(cellidx == 1) { 
						var rowdata = $("#stPolicyList").getRowData(ids);
						fnStPolicyViewPop(rowdata.stPlcNo);
					}
				}
				
				 
			};
			grid.create("stPolicyList", options);
		}         
		function fnStPolicyViewPop(stPlcNo){
			var options = {
				  url : '/st/stPolicyViewPop.do'
				, dataType : "html"
				, data : {
					  stId : '${stStdInfo.stId}'
					, stPlcNo : stPlcNo
				  }
				, callBack : function(result) {
					var config = {
						 id : 'stPolicyViewPop'
						,width : 900
						,height : 600
						,top : 100
						,title : '사이트 정책'
						,body : result
						,button : '<button type="button" class="btn btn-ok" onclick="stPolicySave();">저장</button>'
					}
					layer.create(config);
				}
			}
			ajax.call(options);
		}
		
		function reloadStPolicyListGrid(){
			var options = {
				searchParam : { stId : '${stStdInfo.stId}' }
			};
			grid.reload("stPolicyList", options);
		}
		// 업체정책 삭제 
		function fnStPolicyDel() {
			var rowids = $("#stPolicyList").jqGrid('getGridParam', 'selarrrow');
			var delRow = new Array();
			var arrStPlcNo = new Array();
			if(rowids != null && rowids.length > 0) {
				for(var i in rowids) {
					delRow.push(rowids[i]);
					var rowData = $("#stPolicyList").getRowData( rowids[i] );
 					arrStPlcNo.push(rowData.stPlcNo);
				}
			}
			
			if(delRow != null && delRow.length > 0) {
				messager.confirm('<spring:message code="column.common.confirm.delete" />', function(r){
					if(r){
						var data = $("#stUpdateForm").serializeJson();
						$.extend(data, { arrStPlcNo : arrStPlcNo }  );
						var options = {
							url : "<spring:url value='/st/stPolicyDelete.do' />"
							, data :  data
							, callBack : function(result){
								messager.alert("<spring:message code='column.common.delete.final_msg' arguments='" + delRow.length + "' />", "Info", "info", function(){
									reloadStPolicyListGrid();
								});
							}
						};
						
						ajax.call(options);	
					}
				})
			} else {
				messager.alert('<spring:message code="admin.web.view.msg.common.noSelect"  />', "Info", "info");
			}
		}

		function fnFormValidate(){
			var result = validate.check("stUpdateForm");

			var csTelNo = $("#csTelNo").val();
			var dlgtEmail = $("#dlgtEmail").val();

			if($(".stNmformError").length>0){
				$(".stNmformError div").text("* 사이트 명을 입력해 주세요.");
			}
			if($(".stShtformError").length>0){
				$(".stShtformError div").text("* 사이트 약어를 입력해 주세요.");
			}
			if($(".csTelNoformError").length>0){
				$(".csTelNoformError div").text("* 고객센터 번호를 입력해 주세요.");
			}
			if($(".stUrlformError").length>0){
				$(".stUrlformError div").text("* 사이트 URL를 입력해 주세요.");
			}
			if($(".dlgtEmailformError").length>0){
				$(".dlgtEmailformError div").text("* 대표 이메일을 입력해 주세요.");
			}

			//지역번호 유효성 (숫자 및 특수문자는 하이픈 만 허용)
			var regExpTelNo = /[!@#$%^~*+=]/;
			var regResult = !regExpTelNo.test(csTelNo) && /[\d]/.test(csTelNo);
			if(csTelNo != "" && !regResult){
				var html = '';
				html += '<div class="csTelNoformError parentFormstInsertForm formError" style="opacity: 0.87; position: absolute; top: 188.2px; left: 1033.8px; margin-top: 0px;">';
				html += '<div class="formErrorContent">* 고객센터 번호를 정확하게 입력해주세요.</div>';
				html += '</div>';
				$("#csTelNo").parent().append(html);
				result = false;
			}
			if(dlgtEmail != "" && !regExp.email.test(dlgtEmail)){
				var html = '';
				html += '<div class="dlgtEmailformError parentFormstInsertForm formError" style="opacity: 0.87; position: absolute; top: 188.2px; left: 1033.8px; margin-top: 0px;">';
				html += '<div class="formErrorContent">* 이메일을 정확하게 입력해주세요.</div>';
				html += '</div>';
				$("#dlgtEmail").parent().append(html);
				result = false;
			}

			return result;
		}
		</script>
	</t:putAttribute>
	<t:putAttribute name="content">
<form id="stUpdateForm" name="stUpdateForm" method="post" >
<c:if test="${adminConstants.USR_GRP_10 eq adminSession.usrGrpCd}" >
			<table class="table_type1">
				<caption>St 등록</caption>
				<tbody>
					<tr>
						<th scope="row"><spring:message code="column.st_id" /><strong class="red">*</strong></th>	<!-- 사이트 번호-->
						<td>
							<input type="hidden" id="stId" name="stId" title="<spring:message code="column.st_id" />" value="${stStdInfo.stId }" />
							<b>${stStdInfo.stId }</b>
						</td>
						<th scope="row"><spring:message code="column.st_nm" /><strong class="red">*</strong></th>	<!-- 사이트 명-->
						<td>
							<input type="text" class="w300 validate[required, maxSize[50]]" id="stNm" name="stNm" title="<spring:message code="column.st_nm" />" value="${stStdInfo.stNm }" />
						</td>
					</tr>
					<tr>
						<th scope="row"><spring:message code="column.st_sht" /><strong class="red">*</strong></th>	<!-- 사이트 약어-->
						<td>
							<input type="text" class="w300 validate[required, maxSize[50]]" id="stSht" name="stSht" title="<spring:message code="column.st_sht" />" value="${stStdInfo.stSht }" />
						</td>
						<th scope="row"><spring:message code="column.use_yn" /></th>	<!-- 사용 여부 -->
						<td>
							<frame:radio name="useYn" grpCd="${adminConstants.USE_YN }" selectKey="${stStdInfo.useYn }"/>
						</td>
					</tr>
					<tr>
						<th><spring:message code="column.goods.comp_no" /><strong class="red">*</strong></th>	<!-- 업체 번호-->
						<td>
							<input type="hidden" class="validate[required, custom[onlyNum]]" name="compNo" id="compNo" title="업체번호" value="${stStdInfo.compNo}">
							<input type="text" readonly="" class="readonly validate[required]" id="compNm" name="compNm" title="업체명" value="${stStdInfo.compNm}" placeholder="">
						</td>
						<th><spring:message code="column.cs_tel_no" /><strong class="red">*</strong></th>
						<td>
							<input type="text" class="validate[required, custom[onlyNum], maxSize[20]]" name="csTelNo" id="csTelNo" title="<spring:message code="column.cs_tel_no" />" value="${stStdInfo.csTelNo}"/>
						</td>								
					</tr>
                          <tr>
                              <th scope="row"><spring:message code="column.st_url" /><strong class="red">*</strong></th> <!-- 사이트 URL -->
                              <td>
                                  <input type="text" class="w300 validate[required, custom[url], maxSize[100]]" id="stUrl" name="stUrl" title="<spring:message code="column.st_url" />" value="${stStdInfo.stUrl}" />
                              </td>
                              <th scope="row"><spring:message code="column.st_mo_url" /></th> <!-- 사이트 URL -->
                              <td>
                                  <input type="text" class="w300 validate[maxSize[100]]" id="stMoUrl" name="stMoUrl" title="<spring:message code="column.st_mo_url" />" value="${stStdInfo.stMoUrl}" />
                              </td>
                          </tr>
                          <tr>
                              <th scope="row"><spring:message code="column.dlgt_email" /><strong class="red">*</strong></th> <!-- 대표 이메일 -->
                              <td>
                                  <input type="text" class="w300 validate[required, custom[email] , maxSize[100]]" id="dlgtEmail" name="dlgtEmail" title="<spring:message code="column.dlgt_email" />" value="${stStdInfo.dlgtEmail}" />
                              </td>
                          
						<th scope="row"><spring:message code="column.logo_img_path" /></th>	<!-- 로고 이미지 -->
						<td>
							<div class="inner">
								<input type="hidden" id="orgLogoImgPath" name="orgLogoImgPath" value="${stStdInfo.logoImgPath }" />
								<input type="hidden" id="logoImgPath" name="logoImgPath" value="" />
								<c:if test="${not empty stStdInfo.logoImgPath}">
								<img id="logoImgPathView" name="logoImgPathView" src="<frame:imgUrl/>${stStdInfo.logoImgPath }" class="thumb" alt="" />
								</c:if>
								<c:if test="${empty stStdInfo.logoImgPath}">
								<img id="logoImgPathView" name="logoImgPathView" src="/images/noimage.png" class="thumb" alt="" />
								</c:if>
							</div>
							<div class="inner ml10" style="vertical-align:bottom">
								<button type="button" class="btn" onclick="fileUpload.image(resultImage);" ><spring:message code="column.common.addition" /></button> <!-- 추가 -->
								<button type="button" class="btn" onclick="deleteLogoImage();" ><spring:message code="column.common.delete" /></button> <!-- 삭제 -->
							</div>
						</td>
					</tr>
				</tbody>
			</table>
</c:if>
<c:if test="${adminConstants.USR_GRP_10 ne adminSession.usrGrpCd}" >
			<table class="table_type1">
				<caption>St 등록</caption>
				<tbody>
					<tr>
						<th scope="row"><spring:message code="column.st_id" /><strong class="red">*</strong></th>	<!-- 사이트 ID-->
						<td>
							<input type="hidden" id="stId" name="stId" title="<spring:message code="column.st_id" />" value="${stStdInfo.stId }" />
							<b>${stStdInfo.stId }</b>
						</td>
						<th scope="row"><spring:message code="column.st_nm" /><strong class="red">*</strong></th>	<!-- 사이트 명-->
						<td>
							<input type="text" class="w300 validate[required] readonly" readonly="readonly" id="stNm" name="stNm" title="<spring:message code="column.st_nm" />" value="${stStdInfo.stNm }" />
						</td>
					</tr>
					<tr>
						<th scope="row"><spring:message code="column.st_sht" /><strong class="red">*</strong></th>	<!-- 사이트 약어-->
						<td>
							<input type="text" class="w300 validate[required] readonly" readonly="readonly" id="stSht" name="stSht" title="<spring:message code="column.st_sht" />" value="${stStdInfo.stSht }" />
						</td>
						<th scope="row"><spring:message code="column.use_yn" /></th>	<!-- 사용 여부 -->
						<td>
							<frame:radio name="useYn" grpCd="${adminConstants.USE_YN }" selectKey="${stStdInfo.useYn }" />
						</td>
					</tr>
					<tr>
						<th><spring:message code="column.goods.comp_no" /><strong class="red">*</strong></th>	<!-- 업체 번호-->
						<td>
							<frame:compNo funcNm="searchCompany" requireYn="Y" defaultCompNm="${stStdInfo.compNm }" defaultCompNo="${stStdInfo.compNo }" />
						</td>
						<th><spring:message code="column.cs_tel_no" /><strong class="red">*</strong></th>
						<td>
							<input type="text" class="validate[required, custom[onlyNum]]" name="csTelNo" id="csTelNo" title="<spring:message code="column.cs_tel_no" />" value="${stStdInfo.csTelNo}"/>
						</td>								
					</tr>
                          <tr>
                              <th scope="row"><spring:message code="column.st_url" /></th> <!-- 사이트 URL -->
                              <td colspan="3">
                                  <input type="text" class="w300 validate[required]" id="stUrl" name="stUrl" title="<spring:message code="column.st_url" />" value="${stStdInfo.stUrl }"/>
                              </td>
                          </tr>   							
					<tr>
						<th scope="row"><spring:message code="column.logo_img_path" /></th>	<!-- 로고 이미지 -->
						<td colspan="3">
							<div class="inner">
								<input type="hidden" id="orgLogoImgPath" name="orgLogoImgPath" value="${stStdInfo.logoImgPath }" />
								<input type="hidden" id="logoImgPath" name="logoImgPath" value="" />
								<c:if test="${not empty stStdInfo.logoImgPath}">
								<img id="logoImgPathView" name="logoImgPathView" src="<frame:imgUrl/>${stStdInfo.logoImgPath }" class="thumb" alt="" />
								</c:if>
								<c:if test="${empty stStdInfo.logoImgPath}">
								<img id="logoImgPathView" name="logoImgPathView" src="/images/noimage.png" class="thumb" alt="" />
								</c:if>
							</div>
							<div class="inner ml10" style="vertical-align:bottom">
								<button type="button" class="btn" onclick="fileUpload.image(resultImage);" ><spring:message code="column.common.addition" /></button> <!-- 추가 -->
								<button type="button" class="btn" onclick="deleteLogoImage();" ><spring:message code="column.common.delete" /></button> <!-- 삭제 -->
							</div>
							<div>
								
							</div>
						</td>
					</tr>
				</tbody>
			</table>
</c:if>


			<div class="mTitle mt15">
				<h2>사이트 정책 목록</h2>
				<div class="buttonArea">
				 	<button type="button" class="btn btn-add" onclick="fnStPolicyViewPop('');" >추가</button>
					<button type="button" class="btn btn-add" onclick='fnStPolicyDel();' >삭제</button> 
				</div>
			</div>

			<table id="stPolicyList" class="grid"></table>
			

</form>
				<div class="btn_area_center">
					<button type="button" class="btn btn-ok" onclick="updateSt();" >수정</button>
					<button type="button" class="btn btn-cancel" onclick="closeTab();">닫기</button>
				</div>
	</t:putAttribute>

</t:insertDefinition>