<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<style>
	         .custom-tabs-header{
	             border-top-style: none;
	             border-left-style: none;
	             border-right-style: none;
	             background: white;
	         }
	    </style>
		<script type="text/javascript">
			$(document).ready(function() {
				// 그리드 width 고정
                //$(".panel").css("width", $("#tabs").width());
	            
	            $("#iframe").load(function(){
	            	$(this).contents().find(".page-title-breadcrumb").hide();
	            });
			});
			
			$(document).on("input paset change", "#email", function(){
			   var inputVal = $(this).val().replace(/[ㄱ-힣]/g,'');
			   $("#email").val(inputVal);
			})
			
	        $(document).on("click",".tabs li",function(){
	            $(".tabs li").removeClass("tabs-selected");
	            $(this).addClass("tabs-selected");
	            
	            $(".panel").hide();
	            var obj = $(this).children("a").attr("href");
	            $(obj).show();
	            
	            if(obj == "#tab2") {
	            	window.setTimeout(function(){ $(window).scrollTop(0); }, 10);
	            }
	        });
			
			// 프로필사진 valid
			function prflImgValidEg() {
				var prflImg = $("#prflImg").val();
				var prflImgTemp = $("#imgPathTemp").val();
				
				if((prflImg == null || prflImg == "") && (prflImgTemp == null || prflImgTemp == "")){
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
        
			function petLogPartnerUpdate(){
				prflImgValidEg();
				ptnDateValidEg();
				statCdValidEg();
				
				if(customValidation()) {
					if(validate.check("petLogPartnerForm")) {
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
									petLogPartnerUpdateAction();	
								}
							}
						};

						ajax.call(options);
					}
				}
			}
			
			function petLogPartnerUpdateAction() {
				messager.confirm('<spring:message code="column.common.confirm.update" />', function(r){
					if(r){
						var options = {
							url : "<spring:url value='/partner/partnerUpdate.do' />"
							, data : $("#petLogPartnerForm").serializeJson()
							, callBack : function(result){
								messager.alert('<spring:message code="column.petLogPartner_view_update_success" />', "Info", "info", function(){ 
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
				$("#imgPathTemp").val(file.filePath);
// 				$("#prflImg").val(file.filePath);
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
			
			// 개인정보 해제
			function unMasking() {
				messager.confirm("<spring:message code='column.petLogPartner_view.maksing_unlock_msg' />", function(r){
					if(r) {
						var data = {
							cnctHistNo	: $("#cnctHistNo").val()
							, mbrNo		: $("#mbrNo").val()
						};
						
						var options = {
							url : "<spring:url value='/member/unlockPrivacyMasking.do' />"
							, data : data
							, callBack : function(result){
								getPartner("N");
							}
						};
						ajax.call(options);		
					}						
				})
			}
			
			function masking() {
				getPartner("Y");
			}
			
			// 개인정보 데이터 조회
			function getPartner(maskingYn) {
				var data = { 
						mbrNo : $("#mbrNo").val()
						, maskingYn : maskingYn
				};
					
				var options = {
					url : "<spring:url value='/partner/getPartner.do' />"
					, data : data
					, callBack : function(result){
						console.log(result)
						if(maskingYn == "N") {
							$("#maskingBtn").show();
							$("#unMaskingBtn").hide();
							
							$("#petLogPartnerForm [name='unMasking']").show();
							$("#petLogPartnerForm [name='masking']").hide();
							
							$("#loginIdTd").html(result.partner.loginId);
							$("#bizNm").val(result.partner.bizNm);
							$("#email").val(result.partner.email);
							
							$("#updateBtn").attr("disabled", false);
						} else {
							$("#maskingBtn").hide();
							$("#unMaskingBtn").show();

							$("#petLogPartnerForm [name='unMasking']").hide();
							$("#petLogPartnerForm [name='masking']").show();
							
							$("#updateBtn").attr("disabled", true);
						}
					}
				};
				ajax.call(options);								
			}
			
			function imageDelete(){
				var prflImg = $("#prflImg").val();
				var prflImgTemp = $("#imgPathTemp").val();
				var updateFlag = false;
				
				if(prflImg != "" && prflImgTemp != "") {
					updateFlag = false;
					afterImageDelete(updateFlag);
					beforeImageDelete();
				} else if(prflImg != "") {
					updateFlag = true;
					afterImageDelete(updateFlag);
				} else if(prflImgTemp != "") {
					beforeImageDelete();
				}
			}
			
			function beforeImageDelete(){
				var prflImg = $("#imgPathTemp").val();
				
				if (prflImg != '' && prflImg != null) {
					var options = {
						url : "<spring:url value='/partner/beforeImageDelete.do' />"
						, data : { prflImg : prflImg }
						, callBack : function(data) {
							$("#imgPathTemp").val("");
							$("#prflImg").val("");
							$("#imgPathView").attr('src', "/images/noimage.png");
							
							$("#spanImgNm").html("");
							$("#spanImgFlSz").html("");
						}
					}
					ajax.call(options);
				}
			}
			
			function afterImageDelete(updateFlag) {
				var prflImg = $("#prflImg").val();
				
				if (prflImg != '' && prflImg != null) {
					var options = {
						url : "<spring:url value='/partner/afterImageDelete.do' />"
						, data : { mbrNo : "${partner.mbrNo}", prflImg : prflImg }
						, callBack : function(data) {
							if(data == "${adminConstants.CONTROLLER_RESULT_CODE_SUCCESS}") {
								if(updateFlag)	updateTab(); 
							}
						}
					}
					ajax.call(options);
				}
			}
		</script>
	</t:putAttribute>
	<t:putAttribute name="content">
	
		<form name="petLogPartnerForm" id="petLogPartnerForm" method="post">
			<input type="hidden" id="cnctHistNo" name="cnctHistNo" value="${cnctHistNo }" />
			
			<div id="tabs" style="height:100%">
	            <div class="tabs-header custom-tabs-header">
	                <div class="tabs-wrap">
	                    <div style="background:white">
	                        <ul class="tabs" style="height: 26px;">
	                            <li class="tabs-first tabs-selected">
	                                <a href="#tab1" class="tabs-inner" style="height: 25px; line-height: 25px;">
	                                    <span class="tabs-title">상세정보</span>
	                                    <span class="tabs-icon"></span>
	                                </a>
	                            </li>
	                            <li class="tabs-last">
	                                <a href="#tab2" class="tabs-inner" style="height: 25px; line-height: 25px;">
	                                    <span class="tabs-title">펫로그 목록</span>
	                                    <span class="tabs-icon"></span>
	                                </a>
	                            </li>
	                        </ul>
	                    </div>
	                </div>
	            </div>
	            <div class="mt10">											  
	                <div id="tab1" class="panel panel-htop" style="display:block">
	                
 						<button type="button" onclick="unMasking();" class="btn btn-add" style="float: right;margin-bottom: 10px;" id="unMaskingBtn">개인정보 해제</button>
 						<button type="button" onclick="masking();" class="btn btn-add" style="float: right;margin-bottom: 10px;display: none;" id="maskingBtn">개인정보 숨김</button>
 		
		                <input type="hidden" id="mbrGbCd" name="mbrGbCd" value="${partner.mbrGbCd }" />
						<input type="hidden" id="mbrNo" name="mbrNo" value="${partner.mbrNo }" />
						<input type="hidden" id="bizNo" name="bizNo" value="${partner.bizNo }" />
						<table class="table_type1">
							<caption>펫로그 파트너 상세</caption>
							<tbody>
								<tr>
									<!-- 파트너 ID -->
									<th><spring:message code="column.partner_id" /></th>
									<td id="loginIdTd" name="unMasking" style="display: none;">
									</td>
									<td name="masking">
										${partner.loginId }
									</td>
									<!-- 회원 번호 -->
									<th><spring:message code="column.mbr_no" /></th>
									<td>
										${partner.mbrNo }
									</td>
								</tr>
								<tr name="unMasking" style="display: none;">
									<!-- 업체명 -->
									<th><spring:message code="column.comp_nm" /><strong class="red">*</strong></th>
									<td colspan="3">
										<input type="text" class="required_item validate[maxSize[50]]" name="bizNm" id="bizNm" value="${partner.bizNm }" title="<spring:message code="column.comp_nm" />" />
									</td>
								</tr>
								<tr name="masking">
									<!-- 업체명 -->
									<th><spring:message code="column.comp_nm" /><strong class="red">*</strong></th>
									<td colspan="3">
										${partner.bizNm }
									</td>
								</tr>
								<tr>
									<!-- 닉네임 -->
									<th name="unMasking" style="display: none;"><spring:message code="column.nickname" /><strong class="red">*</strong></th>
									<td name="unMasking" style="display: none;">
										<input type="text" class="required_item validate[maxSize[50]]" name="nickNm" id="nickNm" value="${partner.nickNm }" title="<spring:message code="column.nickname" />" />
									</td>
									<!-- 닉네임 -->
									<th name="masking"><spring:message code="column.nickname" /><strong class="red">*</strong></th>
									<td name="masking">
										${partner.nickNm }
									</td>
									<!-- 프로필 사진 -->
									<th><spring:message code="column.prfl_img" /><strong class="red">*</strong></th>
									<td>
										<div id="prflImgDiv" name="prflImgDiv">
											<div class="inner">
												<input type="hidden" id="imgPathTemp" name="imgPathTemp" />
												<input type="hidden" id="prflImg" class="required_item req_input2" name="prflImg" value="${partner.prflImg }" />
												<c:choose>
													<c:when test="${not empty partner.prflImg }">
														<img id="imgPathView" name="imgPathView" src="${frame:imagePath(partner.prflImg) }" onerror="/images/noimage.png" class="thumb" alt="" />
													</c:when>
													<c:otherwise>
														<img id="imgPathView" name="imgPathView" src="/images/noimage.png" class="thumb" alt="" />
													</c:otherwise>
												</c:choose>
												<span id="spanImgNm" style="color: blue;text-decoration: underline;"></span>
												<span id="spanImgFlSz"></span>
											</div>
											<div name="unMasking" class="inner ml10" style="vertical-align:middle;display: none;">
												<!-- 파일선택 --> 
												<button type="button" class="btn" onclick="fileUpload.image(rsltImage);" ><spring:message code="column.fl_choice" /></button>
												<button type="button" class="btn" onclick="imageDelete();" >삭제</button>
											</div>
										</div>
									</td>
								</tr>
								<tr name="unMasking" style="display: none;">
									<!-- 업체 주소 -->
				                    <th><spring:message code="column.comp_addr"/><strong class="red">*</strong></th>
				                    <td colspan="3">
				                        <input type="hidden" name="postNoOld" id="postNoOld" title="<spring:message code="column.post_no_old"/>" />
				                        <input type="hidden" name="prclAddr" id="prclAddr" title="<spring:message code="column.prcl_addr"/>" />
				                        <div class="mg5">
				                            <input type="text" class="required_item readonly" name="postNoNew" id="postNoNew" value="${partner.postNoNew }" title="<spring:message code="column.post_no_new"/>" readonly="readonly" />
				                            <button type="button" onclick="layerMoisPost.create(partnerPost);" class="btn"><spring:message code="column.common.post.btn"/></button>
				                        </div>
				                        <div class="mg5">
				                            <input type="text" class="required_item readonly w300" name="roadAddr" id="roadAddr" value="${partner.roadAddr }" title="<spring:message code="column.road_addr"/>" readonly="readonly" />
				                            <input type="text" class="required_item w200" name="roadDtlAddr" id="roadDtlAddr" value="${partner.roadDtlAddr }" title="<spring:message code="column.road_dtl_addr"/>" maxlength="100"/>
				                        </div>
				                    </td>
				               	</tr>	
				               	<tr name="masking">
				               		<!-- 업체 주소 -->
				                    <th><spring:message code="column.comp_addr"/><strong class="red">*</strong></th>
				                    <td colspan="3">
				                    	(${partner.postNoNew }) ${partner.roadAddrFull }
				                    </td>
				               	</tr>
								<tr name="unMasking" style="display: none;">
									<!-- 한줄소개 -->
									<th><spring:message code="column.row_itrdc" /><strong class="red">*</strong></th>
									<td>
										<input type="text" class="required_item validate[custom[rowItrdc]] w400" name="petLogItrdc" id="petLogItrdc" value="${partner.petLogItrdc }" title="<spring:message code="column.row_itrdc" />" />
									</td>
									<!-- 이메일 -->
									<th><spring:message code="column.email" /><strong class="red">*</strong></th>
									<td>
										<input type="text" class="required_item validate[custom[email2]]" name="email" id="email" value="${partner.email }" title="<spring:message code="column.email" />" />
									</td>
								</tr>
								<tr name="masking">
									<!-- 한줄소개 -->
									<th><spring:message code="column.row_itrdc" /><strong class="red">*</strong></th>
									<td>
										${partner.petLogItrdc }
									</td>
									<!-- 이메일 -->
									<th><spring:message code="column.email" /><strong class="red">*</strong></th>
									<td>
										${partner.email }
									</td>
								</tr>
								<tr name="unMasking" style="display: none;">
									<!-- 제휴일 -->
									<th><spring:message code="column.ptn_date" /><strong class="red">*</strong></th>
									<td>			
										<div id="ptnDateDiv" name="ptnDateDiv">	
											<frame:datepicker required="Y" startDate="ptnDate" startValue="${partner.ptnDate}" />
										</div>				  
									</td>
									<!-- 상태 -->
									<th><spring:message code="column.ptn_stat_cd" /><strong class="red">*</strong></th>
									<td>
										<div id="statCdDiv" name="statCdDiv">
											<frame:radio name="statCd" grpCd="${adminConstants.STAT}" selectKey="${partner.statCd }" required="true" />
										</div>
									</td>
								</tr>
								<tr name="masking">
									<!-- 제휴일 -->
									<th><spring:message code="column.ptn_date" /><strong class="red">*</strong></th>
									<td>
										${partner.ptnDate }			
									</td>
									<!-- 상태 -->
									<th><spring:message code="column.ptn_stat_cd" /><strong class="red">*</strong></th>
									<td>
										<frame:codeName grpCd="${adminConstants.STAT }" dtlCd="${partner.statCd }" />
									</td>
								</tr>
								<tr>
									<!-- 최종 로그인 일시 -->
									<th><spring:message code="column.last_login_dtm" /></th>
									<td colspan="3">
										${partner.lastLoginDtm }
									</td>
								</tr>
								<tr>
									<th><spring:message code="column.sys_regr_nm" /></th>
									<td>
										${partner.sysRegrNm }
									</td>
									<th><spring:message code="column.sys_reg_dtm" /></th>
									<td>
										${partner.sysRegDtm }
									</td>
								</tr>
								<tr>
									<th><spring:message code="column.sys_updr_nm" /></th>
									<td>
										${partner.sysUpdrNm }
									</td>
									<th><spring:message code="column.sys_upd_dtm" /></th>
									<td>
										${partner.sysUpdDtm }
									</td>
								</tr>
							</tbody>
						</table>
						<div class="btn_area_center">
							<button id="updateBtn" type="button" onclick="petLogPartnerUpdate();" class="btn btn-ok" disabled="disabled">수정</button>
							<button type="button" onclick="closeTab();" class="btn btn-cancel">목록</button>
						</div>
	                </div>
	                <div id="tab2" class="panel panel-htop" style="display:none;">
	                	<iframe id="iframe" scrolling="no" frameborder="0" src="/petLogMgmt/petlogListView.do?mbrNo=${partner.mbrNo }" style="width:100%;height: 120vh;">
	                	</iframe>
	                </div>
	            </div>
	        </div>
			
		</form>
		
	</t:putAttribute>
</t:insertDefinition>
