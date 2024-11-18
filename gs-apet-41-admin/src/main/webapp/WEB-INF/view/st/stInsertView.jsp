<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>

<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">
		$(document).ready(function() {
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

			$("#logoDelBtn").show();
		}

		function deleteLogoImage() {
			var options = {
					url : "/st/deleteLogoImage.do"
				,	data : {filePath : $("#logoImgPath").val()}
				,	callBack : function(result){
						console.dir(result);
						$("#orgLogoImgPath").val("");
						$("#logoImgPath").val("");
						$("#logoImgPathView").attr('src', '/images/noimage.png' );
						$("#logoDelBtn").hide();
				}
			};
			ajax.call(options);
		}
		
		// 업체 검색
		function searchCompany () {
			var options = {
				multiselect : false
				, callBack : searchCompanyCallback
			}
			layerCompanyList.create (options );
		}
		function searchCompanyCallback (compList ) {
			if(compList.length > 0 ) {
				$("#compNo").val (compList[0].compNo );
				$("#compNm").val (compList[0].compNm );
			}
		}

		// 사이트 등록
		function insertSt () {
			if(fnFormValidate()) {
				var formData = $("#stInsertForm").serializeJson();

				// Form 데이터
				var sendData = {
					stStdInfoPO : JSON.stringify(formData )
				}

				messager.confirm("<spring:message code='column.common.confirm.insert' />", function(r){
					if(r){
						var options = {
							url : "<spring:url value='/st/stInsert.do' />"
							, data : sendData
							, callBack : function (data ) {
								messager.alert("<spring:message code='column.common.regist.final_msg' />", "Info", "info", function(){
									updateTab('/st/stDetailView.do?stId=' + data.stId, '사이트 상세');
								});
							}
						};
						ajax.call(options);
					}
				})
			}
		}

		function fnFormValidate(){
			var result = validate.check("stInsertForm");

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
<form id="stInsertForm" name="stInsertForm" method="post" >
				
				<table class="table_type1 mg5">
					<caption>사이트 등록</caption>
					<tbody>
						<tr>
							<th scope="row"><spring:message code="column.st_id" /><strong class="red">*</strong></th>	<!-- 사이트 ID-->
							<td>
								<input type="hidden" id="stId" name="stId" title="<spring:message code="column.st_id" />" value="" />
								<b>자동입력</b>
							</td>
							<th scope="row"><spring:message code="column.st_nm" /><strong class="red">*</strong></th>	<!-- 사이트 명-->
							<td>
								<input type="text" class="w300 validate[required, maxSize[50]]" maxlength="50" id="stNm" name="stNm" title="<spring:message code="column.st_nm" />" value="" />
							</td>
						</tr>
						<tr>
							<th scope="row"><spring:message code="column.st_sht" /><strong class="red">*</strong></th>	<!-- 사이트 약어 -->
							<td>
								<input type="text" class="w300 validate[required, maxSize[50]]" maxlength="50" id="stSht" name="stSht" title="<spring:message code="column.st_sht" />" value="" />
							</td>
							<th scope="row"><spring:message code="column.use_yn" /></th>	<!-- 사용 여부 -->
							<td>
								<frame:radio name="useYn" grpCd="${adminConstants.USE_YN }" />
							</td>
						</tr>
						<tr>
							<th>관리 <spring:message code="column.goods.comp_nm" /><strong class="red">*</strong></th>	<!-- 업체 번호-->
							<td >
								<frame:compNo funcNm="searchCompany" defaultCompNo="${adminSession.compNo}" defaultCompNm="${adminSession.compNm}" disableSearchYn="Y" requireYn="Y" />
							</td>
							<th><spring:message code="column.cs_tel_no" /><strong class="red">*</strong></th>
							<td>
								<input type="text" class="validate[required,maxSize[20]]" maxlength="20" name="csTelNo" id="csTelNo" title="<spring:message code="column.cs_tel_no" />" value="${stStdInfo.csTelNo}"/>
							</td>								
						</tr>
                           <tr>
                               <th scope="row"><spring:message code="column.st_url" /><strong class="red">*</strong></th> <!-- 사이트 URL -->
                               <td>
                                   <input type="text" class="w300 validate[required,custom[url], maxSize[100]]" maxlength="100"id="stUrl" name="stUrl" title="<spring:message code="column.st_url" />" value="" placeholder="사이트의 URL 을 입력하세요"/>
                               </td>
                               <th scope="row"><spring:message code="column.st_mo_url" /></th> <!-- 사이트 MO URL -->
                               <td>
                                   <input type="text" class="w300 validate[maxSize[100]]" maxlength="100" id="stMoUrl" name="stMoUrl" title="<spring:message code="column.st_mo_url" />" value="" placeholder="사이트의 URL 을 입력하세요"/>
                               </td>
                           </tr>
                           <tr>
                               <th scope="row"><spring:message code="column.dlgt_email" /><strong class="red">*</strong></th> <!-- 사이트 URL -->
                               <td>
                                   <input type="text" class="w300 validate[required, maxSize[100]]" maxlength="100" id="dlgtEmail" name="dlgtEmail" title="<spring:message code="column.dlgt_email" />" value="" placeholder="대표 이메일을 입력하세요"/>
                               </td>
                          
							<th scope="row"><spring:message code="column.logo_img_path" /></th>	<!-- 로고 이미지 -->
							<td>
								<div class="inner">
									<input type="hidden" id="logoImgPath" name="logoImgPath" value="" />
									<img id="logoImgPathView" name="logoImgPathView" src="/images/noimage.png" class="thumb" alt="" />
								</div>
								<div class="inner ml10" style="vertical-align:bottom">
									<button type="button" class="btn" onclick="fileUpload.image(resultImage);"><spring:message code="column.common.addition" /></button> <!-- 추가 -->
									<button type="button" class="btn" onclick="deleteLogoImage();" id="logoDelBtn"  style="display: none;"><spring:message code="column.common.delete" /></button> <!-- 삭제 -->
								</div>
							</td>
						</tr>
					</tbody>
				</table>
				
</form>

				<div class="btn_area_center">
					<button type="button" class="btn btn-ok" onclick="insertSt();" >등록</button>
					<button type="button" class="btn btn-cancel" onclick="closeTab();">취소</button>
				</div>

	</t:putAttribute>

</t:insertDefinition>