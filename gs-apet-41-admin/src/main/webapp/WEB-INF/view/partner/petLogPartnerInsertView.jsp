<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">
			// idCheck 여부
			var idCheck = false;

			$(document).ready(function(){
				$(".required_item").validationEngine();
				$("#loginId").validationEngine();
				
// 				$('#loginId').validationEngine('showPrompt', '<spring:message code="column.petLogPartner_view.id_valid" />', 'error', true);
			});
			
			$(document).on("change", "#loginId", function(e) {
				idCheck = false;
			})
			
			$(document).on("input paset change", "#email", function(){
			   var inputVal = $(this).val().replace(/[ㄱ-힣]/g,'');
			   $("#email").val(inputVal);
			})

			// ID 체크
			function partnerIdCheck(){
				if($("#loginId").val() != "") {
					if(!validate.check("loginId")) {
						var options = {
							url : "<spring:url value='/partner/partnerIdCheck.do' />"
							, data : $("#petLogPartnerForm").serializeJson()
							, callBack : function(result){
								if(result.checkCount > 0){
									idCheck = false;
									$('#loginId').validationEngine('showPrompt', result.message, 'error', true);
								} else {
									idCheck = true;
									$('#loginId').validationEngine('showPrompt', '<spring:message code="column.user_view.success_id_chk" />', 'pass', true);
								}
							}
						};
						ajax.call(options);
					} else {
						idCheck = false;
					}
				} else {
					$('#loginId').validationEngine('showPrompt', '<spring:message code="column.petLogPartner_view.id_valid" />', 'error', true);
				}
			}
			
			// 프로필사진 valid
			function prflImgValidEg() {
				if($("#prflImg").val() == null || $("#prflImg").val() == ""){
					$('#prflImgDiv').validationEngine('showPrompt', '<spring:message code="column.prfl_img" /> 정보를 입력해 주세요.', 'error', true);
					return true;
				} else {
					$('#prflImgDiv').validationEngine('hide');
					return false;
				}				
			}
			
			// 제휴일 valid
			function ptnDateValidEg() {
				if($("#ptnDate").val() == null || $("#ptnDate").val() == "") {
					$('#ptnDateDiv').validationEngine('showPrompt', '<spring:message code="column.ptn_date" /> 정보를 입력해 주세요.', 'error', true);
					return true;
				} else {
					$('#ptnDateDiv').validationEngine('hide');
					return false;
				}
			}
			
			// 상태 valid
			function statCdValidEg() {
				if($('input[name="statCd"]:checked').val() == null || $('input[name="statCd"]:checked').val() == "") {
					$('#statCdDiv').validationEngine('showPrompt', '<spring:message code="column.ptn_stat_cd" /> 정보를 입력해 주세요.', 'error', true);
					return true;
				} else {
					$('#statCdDiv').validationEngine('hide');
					return false;
				}
			}
			
			function customValidation() {
				var cnt = 0;
				$(".required_item").each(function(index, item){
					var val = this.value;
					if(val == null || val == "") {
						var text = $(this).parents("td").prev().text().replace("*", "");
						text += " 정보를 입력해 주세요.";
						
						$(this).validationEngine('showPrompt', text, 'error', true);
						
						cnt++;
					} else {
						$(this).validationEngine('hide');
					}
				})
				return (cnt > 0) ? false : true;
			}

			function petLogPartnerInsert(){
				prflImgValidEg();
				ptnDateValidEg();
				statCdValidEg();
				
				if(customValidation()) {
					if(validate.check("petLogPartnerForm")) {
						if(!idCheck) {
							$('#loginId').validationEngine('showPrompt', '<spring:message code="column.plz_id_chk" />', 'error', true);
							return;
						}
						
						if(prflImgValidEg()) return;
						if(ptnDateValidEg()) return;
						if(statCdValidEg()) return;
						
						var options = {
							url : "<spring:url value='/partner/partnerEmailNickNmCheck.do' />"
							, data : $("#petLogPartnerForm").serializeJson()
							, callBack : function(result) {
								if(result.emailCnt > 0) {
									$('#email').validationEngine('showPrompt', "이미 사용 중인 이메일 주소입니다.", 'error', true);
								} 
								
								if(result.nickNmCnt > 0) {
									$('#nickNm').validationEngine('showPrompt', "이미 사용 중인 닉네임입니다.", 'error', true);
								}
									
								if(result.emailCnt == 0 && result.nickNmCnt == 0) {
									petLogPartnerInsertAction();	
								}
							}
						};

						ajax.call(options);
					}
				}
			}
			
			function petLogPartnerInsertAction() {
				messager.confirm('<spring:message code="column.common.confirm.insert" />', function(r){
					if(r){
						var options = {
							url : "<spring:url value='/partner/partnerInsert.do' />"
							, data : $("#petLogPartnerForm").serializeJson()
							, callBack : function(result){
								messager.alert('<spring:message code="column.petLogPartner_view_reg_success" />', "Info", "info", function(){ 
									updateTab('/partner/petLogPartnerListView.do', '펫로그 파트너 목록'); 
								});
							}
						};

						ajax.call(options);
					}
				})
			}
			
			function partnerPost(result) {
				$("#postNoOld").val(result.zonecode);
				$("#prclAddr").val(result.jibunAddress);
				$("#postNoNew").val(result.zonecode);
				$("#roadAddr").val(result.roadAddress);
				$("#roadDtlAddr").val(result.addrDetail);
			}

			<%-- 이미지 업로드 결과 --%>
			function rsltImage (file) {
				$("#prflImg").val(file.filePath);
				$("#imgPathView").attr('src', '/common/imageView.do?filePath=' + file.filePath );
				
				$("#spanImgNm").html(file.fileName);
				$("#spanImgFlSz").html("(" + bytesToSize(file.fileSize) + ")");
			}
			
			function bytesToSize(bytes) {
			   var sizes = ['Bytes', 'KB', 'MB', 'GB', 'TB'];
			   if (bytes == 0) return '0 Byte';
			   var i = parseInt(Math.floor(Math.log(bytes) / Math.log(1024)));
			   return Math.round(bytes / Math.pow(1024, i), 2) + sizes[i];
			}
			
			function beforeImageDelete(){
				var prflImg = $("#prflImg").val();
				
				if (prflImg != '' && prflImg != null) {
					var options = {
						url : "<spring:url value='/partner/beforeImageDelete.do' />"
						, data : { prflImg : prflImg }
						, callBack : function(data) {
							$("#prflImg").val("");
							$("#imgPathView").attr('src', "/images/noimage.png");
							
							$("#spanImgNm").html("");
							$("#spanImgFlSz").html("");
						}
					}
					ajax.call(options);
				}
			}
		</script>
	</t:putAttribute>
	<t:putAttribute name="content">

		<form name="petLogPartnerForm" id="petLogPartnerForm" method="post">
			<input type="hidden" id="mbrGbCd" name="mbrGbCd" value="${adminConstants.MBR_GB_CD_30 }" />
			<table class="table_type1 mg5">
				<caption>펫로그 파트너 등록</caption>
				<tbody>
					<tr>
						<!-- 파트너 ID -->
						<th><spring:message code="column.partner_id" /><strong class="red">*</strong></th>
						<td>
							<input type="text" class="required_item validate[custom[loginidFO]]" name="loginId" id="loginId" title="<spring:message code="column.partner_id" />"/>
						 	<button type="button" class="btn" onclick="partnerIdCheck();">중복확인</button>
						</td>
						<!-- 회원 번호 -->
						<th><spring:message code="column.mbr_no" /></th>
						<td>
						</td>
					</tr>
					<tr>
						<!-- 업체명 -->
						<th id="test"><spring:message code="column.comp_nm" /><strong class="red">*</strong></th>
						<td colspan="3">
							<input type="text" class="required_item validate[maxSize[20]]" name="bizNm" id="bizNm" title="<spring:message code="column.comp_nm" />" />
						</td>
					</tr>
					<tr>
						<!-- 닉네임 -->
						<th><spring:message code="column.nickname" /><strong class="red">*</strong></th>
						<td>
							<input type="text" class="required_item validate[maxSize[50]]" name="nickNm" id="nickNm" title="<spring:message code="column.nickname" />" />
						</td>
						<!-- 프로필 사진 -->
						<th><spring:message code="column.prfl_img" /><strong class="red">*</strong></th>
						<td>
							<div id="prflImgDiv" name="prflImgDiv">
								<div class="inner">
									<input type="hidden" id="prflImg" class="" name="prflImg" value="" />
									<img id="imgPathView" name="imgPathView" src="/images/noimage.png" class="thumb" alt="" />
									<span id="spanImgNm" style="color: blue;text-decoration: underline;"></span>
									<span id="spanImgFlSz"></span>
								</div>
								<div class="inner ml10" style="vertical-align:middle;">
									<!-- 파일선택 --> 
									<button type="button" class="btn" onclick="fileUpload.image(rsltImage);" ><spring:message code="column.fl_choice" /></button>
									<button type="button" class="btn" onclick="beforeImageDelete();" >삭제</button>
								</div>
							</div>
						</td>
					</tr>
					<tr>
						<!-- 한줄소개 -->
						<th><spring:message code="column.row_itrdc" /><strong class="red">*</strong></th>
						<td>
							<input type="text" class="required_item validate[maxSize[30]] w400" name="petLogItrdc" id="petLogItrdc" title="<spring:message code="column.row_itrdc" />" />
						</td>
						<!-- 이메일 -->
						<th><spring:message code="column.email" /><strong class="red">*</strong></th>
						<td>
							<input type="text" class="required_item validate[custom[email2]] validate[maxSize[257]]" name="email" id="email" title="<spring:message code="column.email" />" />
						</td>
					</tr>
					<tr>
						<!-- 업체 주소 -->
	                    <th><spring:message code="column.comp_addr"/><strong class="red">*</strong></th>
	                    <td colspan="3">
	                        <input type="hidden" name="postNoOld" id="postNoOld" title="<spring:message code="column.post_no_old"/>" />
	                        <input type="hidden" name="prclAddr" id="prclAddr" title="<spring:message code="column.prcl_addr"/>" />
	                        <div class="mg5">
	                            <input type="text" class="required_item readonly" name="postNoNew" id="postNoNew" title="<spring:message code="column.post_no_new"/>" readonly="readonly" />
	                            <button type="button" onclick="layerMoisPost.create(partnerPost);" class="btn"><spring:message code="column.common.post.btn"/></button>
	                        </div>
	                        <div class="mg5">
	                            <input type="text" class="required_item readonly w300" name="roadAddr" id="roadAddr" title="<spring:message code="column.road_addr"/>" readonly="readonly" />
	                            <input type="text" class="required_item w200" name="roadDtlAddr" id="roadDtlAddr" title="<spring:message code="column.road_dtl_addr"/>" maxlength="100"/>
	                        </div>
	                    </td>
	               	</tr>	
					<tr>
						<!-- 제휴일 -->
						<th><spring:message code="column.ptn_date" /><strong class="red">*</strong></th>
						<td>		
							<div id="ptnDateDiv" name="ptnDateDiv">	
								<frame:datepicker required="Y" startDate="ptnDate" startValue="${frame:toDate('yyyy-MM-dd')}" />
							</div>				  
						</td>
						<!-- 상태 -->
						<th><spring:message code="column.ptn_stat_cd" /><strong class="red">*</strong></th>
						<td>
							<div id="statCdDiv" name="statCdDiv">
								<frame:radio name="statCd" grpCd="${adminConstants.STAT}" required="true" />
							</div>
						</td>
					</tr>
				</tbody>
			</table>
		</form>
		
		<div class="btn_area_center">
			<button type="button" onclick="petLogPartnerInsert();" class="btn btn-ok">등록</button>
			<button type="button" onclick="closeTab();" class="btn btn-cancel">목록</button>
		</div>
	</t:putAttribute>
</t:insertDefinition>
