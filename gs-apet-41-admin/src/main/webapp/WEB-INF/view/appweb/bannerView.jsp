<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<style>
.bannerType {
background-color:#fff;
border:1px solid;
width:15px; height:15px;
border-radius:75px;
text-align:center;
margin:0 auto;
font-size:9px; color:#0009;
vertical-align:middle;
margin-left:6px;
margin-bottom:3px;
}
</style>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">
			$(document).ready(function(){
				var bnrTpCdVal = $("#bnrTpCd option:selected").val();
				if(bnrTpCdVal == "${adminConstants.BNR_TP_CD_10}") {
					$("#moSize").text("(사이즈 375x88)");
					$("#pcSize").text("(사이즈 1200x94)");
				} else if(bnrTpCdVal == "${adminConstants.BNR_TP_CD_20}"){
					$("#moSize").text("(사이즈 375x340)");
					$("#pcSize").text("(사이즈 1010x360)");
				} else if(bnrTpCdVal == "${adminConstants.BNR_TP_CD_30}"){
					$("#moSize").text("(사이즈 335x162 375x181)");
					$("#pcSize").text("(사이즈 1010x210 1200x250)");
				} else if(bnrTpCdVal == "${adminConstants.BNR_TP_CD_40}"){
					$("#moSize").text("(사이즈 335x162)");
					$("#pcSize").text("(사이즈 1010x360)");
				} else if(bnrTpCdVal == "${adminConstants.BNR_TP_CD_50}"){
					$("#moSize").text("(사이즈 375x211)");
					$("#pcSize").text("(사이즈 1010x360)");
				} else if(bnrTpCdVal == "${adminConstants.BNR_TP_CD_60}"){
					$("#moSize").text("(사이즈 325x236 (가변))");
					$("#pcSize").text("(사이즈 325x236 (가변))");
				} else if(bnrTpCdVal == "${adminConstants.BNR_TP_CD_70}"){
					$("#moSize").text("(사이즈 기본 : 375x211 작은 배너 : 375x88)");
					$("#pcSize").text("(사이즈 1200x226)");
				}
				
				
				if("${banner.bnrMobileImgCd}" == '${adminConstants.BNR_MO_IMG_GB_10}') {
					$("#bnrMobileImgArea").css("display", "block");
					$("#bnrMobileImgInfo").css("display", "block");
					$("#bnrMobileImgUrl").css("display", "none");
					$(".bnrMobileImgBtn").css("display", "block");
				} else {
					$("#bnrMobileImgUrl").css("display", "block");
					$("#bnrMobileImgArea").css("display", "none");
					$("#bnrMobileImgInfo").css("display", "none");
					$(".bnrMobileImgBtn").css("display", "none");
				}
				
				if("${banner.bnrImgCd}" == '${adminConstants.BNR_IMG_GB_10}') {
					$("#bnrImgArea").css("display", "block");
					$("#bnrImgInfo").css("display", "block");
					$("#bnrImgUrl").css("display", "none");
					$(".bnrImgBtn").css("display", "block");
				} else {
					$("#bnrImgUrl").css("display", "block");
					$("#bnrImgArea").css("display", "none");
					$("#bnrImgInfo").css("display", "none");
					$(".bnrImgBtn").css("display", "none");
				}
				
				$("#bnrId").keyup(function(e) {
					bnrIdCheck = false;
				});
				
				$("#bnrTpCd").change(function(){
					if($(this).val() == "${adminConstants.BNR_TP_CD_10}") {
						$("#moSize").text("(사이즈 375x88)");
						$("#pcSize").text("(사이즈 1200x94)");
					} else if($(this).val() == "${adminConstants.BNR_TP_CD_20}"){
						$("#moSize").text("(사이즈 375x340)");
						$("#pcSize").text("(사이즈 1010x360)");
					} else if($(this).val() == "${adminConstants.BNR_TP_CD_30}"){
						$("#moSize").text("(사이즈 335x162 375x181)");
						$("#pcSize").text("(사이즈 1010x210 1200x250)");
					} else if($(this).val() == "${adminConstants.BNR_TP_CD_40}"){
						$("#moSize").text("(사이즈 335x162)");
						$("#pcSize").text("(사이즈 1010x360)");
					} else if($(this).val() == "${adminConstants.BNR_TP_CD_50}"){
						$("#moSize").text("(사이즈 375x211)");
						$("#pcSize").text("(사이즈 1010x360)");
					} else if($(this).val() == "${adminConstants.BNR_TP_CD_60}"){
						$("#moSize").text("(사이즈 325x236 (가변))");
						$("#pcSize").text("(사이즈 325x236 (가변))");
					} else if($(this).val() == "${adminConstants.BNR_TP_CD_70}"){
						$("#moSize").text("(사이즈 기본 : 375x211 작은 배너 : 375x88)");
						$("#pcSize").text("(사이즈 1200x226)");
					}
				});
				
				if("${banner.bnrNo}" == '') {
					$("input:radio[name='bnrMobileImgCd']").eq(0).click();
					$("input:radio[name='bnrImgCd']").eq(0).click();
				}
			});
			
			//MO 이미지 라디오 버튼 이벤트
			$(document).on("change", "input[name='bnrMobileImgCd']", function(){
				if($(this).val() == '${adminConstants.BNR_MO_IMG_GB_10}') {
					$("#bnrMobileImgArea").css("display", "block");
					$("#bnrMobileImgInfo").css("display", "block");
					$("#bnrMobileImgUrl").css("display", "none");
					$(".bnrMobileImgBtn").css("display", "block");
				} else {
					$("#bnrMobileImgUrl").css("display", "block");
					$("#bnrMobileImgArea").css("display", "none");
					$("#bnrMobileImgInfo").css("display", "none");
					$(".bnrMobileImgBtn").css("display", "none");
				}
			});
			
			//PC 이미지 라디오 버튼 이벤트
			$(document).on("change", "input[name='bnrImgCd']", function(){
				if($(this).val() == '${adminConstants.BNR_IMG_GB_10}') {
					$("#bnrImgArea").css("display", "block");
					$("#bnrImgInfo").css("display", "block");
					$("#bnrImgUrl").css("display", "none");
					$(".bnrImgBtn").css("display", "block");
				} else {
					$("#bnrImgUrl").css("display", "block");
					$("#bnrImgArea").css("display", "none");
					$("#bnrImgInfo").css("display", "none");
					$(".bnrImgBtn").css("display", "none");
				}
			});
			
			var bnrIdCheck = false;		//등록 시 배너 ID 중복체크 값
			
			//배너 ID 중복체크
			function bannerIdCheck() {
				if($("#bnrId").val() === null || $("#bnrId").val() === '') {
					messager.alert("배너 ID를 입력해주세요.", "info", "info", function(r){
						$("#bnrId").focus();
					});
					return;
				}
				
				var bnrIdDplctCheck;
				var options = {
						url : "<spring:url value='/appweb/bnrIdDplctCheck.do' />"
						, data : {
							bnrId : $("#bnrId").val()
						}
						, callBack : function(result) {
							bnrIdDplctCheck = result
							
							if(bnrIdDplctCheck) {
								bnrIdCheck = false;
								$('#bnrId').validationEngine('showPrompt', '중복된  ID이므로 사용불가합니다.', 'error', true);
							} else {
								bnrIdCheck = true;
								$('#bnrId').validationEngine('showPrompt', '사용가능한 ID 입니다.', 'pass', true);
							}
						}
				};
				ajax.call(options);
			}
			
			//배너 등록
			function insertBanner() {
				/* if($("#bnrId").val() == null || $("#bnrId").val() == '') {
					messager.alert("배너ID를 입력해 주세요.", "info", "info", function(r){
						$("#bnrId").focus();
					});
					return;
				} */
				
				/* if(!bnrIdCheck) {
					messager.alert("배너ID 중복확인을 해 주세요.", "info", "info", function(r){
						$("#bnrId").focus();
					});
					return;
				} */
				
				if($("#bnrTtl").val() == null || $("#bnrTtl").val() == '') {
					messager.alert("배너제목을 입력해 주세요.", "info", "info", function(r){
						$("#bnrTtl").focus();
					});
					return;
				}
				
				if($("input[name='bnrMobileImgCd']:checked").val() == "${adminConstants.BNR_MO_IMG_GB_10}") {
					$("#bnrMobileImgUrl").val('');
				} else {
					$("#bnrMobileImgPath").val('');
					$("#bnrMobileImgNm").val('');
					$("#imgPathView1").attr('src', '/images/noimage.png' );
				}
				
				if($("input[name='bnrImgCd']:checked").val() == "${adminConstants.BNR_IMG_GB_10}") {
					$("#bnrImgUrl").val('');
				} else {
					$("#bnrImgPath").val('');
					$("#bnrImgNm").val('');
					$("#imgPathView2").attr('src', '/images/noimage.png' );
				}
				
				if(validate.check("bannerForm")) {
					messager.confirm('<spring:message code="column.bnr_confirm_insert" />', function(r) {
						if(r) {
							var formData = $("#bannerForm").serializeJson();
							var tagListLength = $("#tagList span").length;
							var tagList = $("#tagList span");
							
							var tagNo = new Array();
							
							if(tagListLength > 0) {
								for(var i = 0; i < tagListLength; i++) {
									tagNo[i] = tagList.eq(i).attr('id');
								}
							}
							
							$.extend(formData, {
								tagNo : tagNo
							});
							
							var options = {
									url : "<spring:url value='/appweb/insertBanner.do' />"
									, data : formData
									, callBack : function(result) {
										var title = getSeletedTabTitle('상세', '목록');
										//updateTab('/appweb/bannerListView.do', title);
										//closeTab();
										closeGoTab("배너 조회", "/appweb/bannerListView.do");
									}
							};
							ajax.call(options);
						}
					})
				}
				
			}
			
			//배너 저장
			function updateBanner() {
				if($("input[name='bnrMobileImgCd']:checked").val() == "${adminConstants.BNR_MO_IMG_GB_10}") {
					$("#bnrMobileImgUrl").val('');
				} else {
					$("#bnrMobileImgPath").val('');
					$("#bnrMobileImgNm").val('');
					$("#imgPathView1").attr('src', '/images/noimage.png' );
				}
				
				if($("input[name='bnrImgCd']:checked").val() == "${adminConstants.BNR_IMG_GB_10}") {
					$("#bnrImgUrl").val('');
				} else {
					$("#bnrImgPath").val('');
					$("#bnrImgNm").val('');
					$("#imgPathView2").attr('src', '/images/noimage.png' );
				}
				
				if($("#bnrTtl").val() == null || $("#bnrTtl").val() == '') {
					messager.alert("배너제목을 입력해 주세요.", "info", "info", function(r){
						$("#bnrTtl").focus();
					});
					return;
				}
				
				if(validate.check("bannerForm")) {
					messager.confirm('<spring:message code="column.bnr_confirm_save" />', function(r) {
						if(r){
							var formData = $("#bannerForm").serializeJson();
							var tagListLength = $("#tagList span").length;
							var tagList = $("#tagList span");
							
							var tagNo = new Array();
							
							if(tagListLength > 0) {
								for(var i = 0; i < tagListLength; i++) {
									tagNo[i] = tagList.eq(i).attr('id');
								}
							}
							
							$.extend(formData, {
								tagNo : tagNo
							});
							
							var options = {
									url : "<spring:url value='/appweb/updateBanner.do' />"
									, data : formData
									, callBack : function(result) {
										//var title = getSeletedTabTitle('상세', '목록');
										//updateTab('/appweb/bannerListView.do', title);
										//closeTab();
										closeGoTab("배너 조회", "/appweb/bannerListView.do");
									}
							};
							ajax.call(options);
						}
					})
				}
			}
			
			//배너 삭제
			function deleteBanner() {
				messager.confirm('<spring:message code="column.bnr_confirm_delete" />', function(r) {
					if(r) {
						var bnrNo = $("#bnrNo").val();
						var options = {
								url : "<spring:url value='/appweb/deleteBanner.do' />"
								, data : {
									bnrNo : bnrNo
								}
								, callBack : function(result) {
									var title = getSeletedTabTitle('상세', '목록');
									updateTab('/appweb/bannerListView.do', title);
									closeTab();
								}
						};
						
						ajax.call(options);
					}
				})
			}
			
			//태그 불러오기 팝업
				function tagBaseSearchPop() {
					var options = {
						multiselect : true
						, callBack : function(result) {
							var check = true;
							if(result != null && result.length > 0) {

								var message = new Array();
								var sTag = $(".SelectedTags");
								
								for(var i in result){							
						
									var addData = {
										tagNo : result[i].tagNo
										, tagNm : result[i].tagNm
									}
									
									sTag.each(function(i, v){
										var tagName = $("#"+v.id).attr('tag-nm');
										
										if (tagName == addData.tagNm) {
											check = false;
											return false;
										} else {	
											check = true;									
										}
									});

									if(check) {
										var html = '<span class="rcorners1 ' + 'SelectedTags" tag-nm="' + addData.tagNm +'" id="' + addData.tagNo + '">' + addData.tagNm + '</span>' 
										+ '<img id="' + addData.tagNo + 'Delete" onclick="deleteTag(\'' + addData.tagNo +'\')" class="tagDeleteBtn" src="/images/icon-header-close.svg" />';
					
										$("#tagList").append (html);
										
									} else {
										message.push(result[i].tagNm + " 중복된 Tag 입니다.");
									}
									
								}
								if(message != null && message.length > 0) {
									messager.alert(message.join("<br/>"), "Info", "info");
								}
							}
						}
					 }
					layerTagBaseList.create(options);
				}
			
				function deleteTag(tagNo) {
					$("#"+ tagNo).remove();
					$("#"+ tagNo + "Delete").remove();
				}	
			
			// MO 이미지 파일 업로드
			function resultBnrMobileImg(file) {
				$("#bnrMobileImgPath").val(file.filePath);
				$("#bnrMobileImgNm").val(file.fileName);
				
				var maxfileSize = 5;
				if(file.fileSize > (maxfileSize*1024*1024)) {
					messager.alert("업로드 하신 파일의 용량은 "+(Math.round(file.fileSize/1024/1024*10)/10)+"MB 입니다. 업로드 가능 용량은 최대 "+maxfileSize+"MB 입니다.","Info","info", deleteMobileImage)
					return;
				}
				
				$("#imgPathView1").attr('src', '/common/imageView.do?filePath=' + file.filePath);
			}
			
			// PC 이미지 파일 업로드
			function resultBnrImg(file) {
				$("#bnrImgPath").val(file.filePath);
				$("#bnrImgNm").val(file.fileName);
				
				var maxfileSize = 5;
				if(file.fileSize > (maxfileSize*1024*1024)) {
					messager.alert("업로드 하신 파일의 용량은 "+(Math.round(file.fileSize/1024/1024*10)/10)+"MB 입니다. 업로드 가능 용량은 최대 "+maxfileSize+"MB 입니다.","Info","info", deleteImage)
					return;
				}
				
				$("#imgPathView2").attr('src', '/common/imageView.do?filePath=' + file.filePath);
			}
			
			// MO 이미지 삭제
			function deleteMobileImage() {
				$("#bnrMobileImgPath").val("");
				$("#bnrMobileImgNm").val("");
				$("#imgPathView1").attr('src', '/images/noimage.png' );
			}
			
			// PC 이미지 삭제
			function deleteImage() {
				$("#bnrImgPath").val("");
				$("#bnrImgNm").val("");
				$("#imgPathView2").attr('src', '/images/noimage.png' );
			}
			
			//초기화 버튼
			function reset() {
				resetForm("bannerForm");
				$("#bnrMobileImgArea").css("display", "none");
				$("#bnrMobileImgInfo").css("display", "none");
				$(".bnrMobileImgBtn").css("display", "none");
				$("#bnrMobileImgUrl").css("display", "block");
				
				$("#bnrImgArea").css("display", "none");
				$("#bnrImgInfo").css("display", "none");
				$(".bnrImgBtn").css("display", "none");
				$("#bnrImgUrl").css("display", "block");
				
				$("#bnrMobileImgPath").val("");
				$("#bnrMobileImgNm").val("");
				$("#imgPathView1").attr('src', '/images/noimage.png' );
				
				$("#bnrImgPath").val("");
				$("#bnrImgNm").val("");
				$("#imgPathView2").attr('src', '/images/noimage.png' );
			}
			
			//배너 타입별 안내 팝업
			function bannerTypePop() {
	 			var options = {
						url : '/banner/bannerTypePopView.do'
						, dataType : 'html'
						, callBack : function (data ) {
							var config = {
								id : "bannerTypeView"
								, width : 900
								, height : 750
								, top : 200
								, title : "배너 타입별 상세"
								, body : data
							}
							layer.create(config);
						}
					}
					ajax.call(options );
	 		}
		</script>
 	</t:putAttribute>
	<t:putAttribute name="content">
		<form name="bannerForm" id="bannerForm" method="post">
			<input type="hidden" id="bnrNo" name="bnrNo" value="${banner.bnrNo }" />
			<input type="hidden" id="stId" name="stId" value="1" />
			<table class="table_type1">
				<caption>배너 등록</caption>
				<tbody>
					<tr>
						<th><spring:message code="column.bnr_no" /></th>
						<td colspan="3">
							<!-- 배너 No--> 
							<b>${banner.bnrNo == null ? '자동입력' : banner.bnrNo }</b>
						</td>
						<th><spring:message code="column.use_yn" /><strong class="red">*</strong></th>
						<td colspan="3">
							<!-- 사용 여부-->
							<select class="wth100" name="useYn" id="useYn" title="<spring:message code="column.use_yn"/>">
								<frame:select grpCd="${adminConstants.USE_YN}" selectKey="${not empty banner.useYn ? banner.useYn : 'Y'}" />
							</select>
						</td>
					</tr>
					<tr>
						<%-- <th><spring:message code="column.bnr_id" /><strong class="red">*</strong></th>
						 <td>
							<!-- 배너 ID--> 
							<input type="text" name="bnrId" id="bnrId" value="${banner.bnrId }" ${empty banner.bnrNo ? '' : 'readonly="readonly"' } class="${empty banner.bnrId ? '' : 'readonly'}" />
							
							<c:if test="${empty banner.bnrId }">
								<button type="button" onclick="bannerIdCheck();" class="btn btn-add">중복확인</button>
							</c:if>
						</td> --%>
						<th><spring:message code="column.bnr_ttl" /><strong class="red">*</strong></th>
						<td colspan="3">
							<!-- 배너 제목--> 
							<input type="text" class="w400" name="bnrTtl" id="bnrTtl" value="${banner.bnrTtl }" maxlength="100"/>
						</td>
						<th scope="row"><spring:message code="column.bnr_tp_cd_nm" /><strong class="red">*</strong><button type="button" id="bnrTpBtn" class="bannerType" onclick="bannerTypePop();">?</button></th>
						<td colspan="3">
							<!-- 배너 타입명-->
							<select class="wth100" name="bnrTpCd" id="bnrTpCd" title="<spring:message code="column.bnr_tp_cd_nm"/>">
								<frame:select grpCd="${adminConstants.BNR_TP_CD}" selectKey="${not empty banner.bnrTpCd ? banner.bnrTpCd : adminConstants.BNR_TP_CD_10}" />
							</select>
						</td>
					</tr>
					<tr>
						<th><spring:message code="column.bnr_mo_img"/><strong class="red">*</strong><br><span id="moSize"></span></th>
						<td colspan="7">
							<!-- MO 이미지-->
							<frame:radio name="bnrMobileImgCd" grpCd="${adminConstants.BNR_MO_IMG_GB}" selectKey="${not empty banner.bnrMobileImgCd ? banner.bnrMobileImgCd : adminConstants.BNR_MO_IMG_GB_20 }" required="true" /><br><br>
							<div id="bnrMobileImgArea" style="float:left;">
								<c:if test="${empty banner.bnrMobileImgPath}">
								<img id="imgPathView1" name="imgPathView1" src="/images/noimage.png" class="thumb" alt="">
								</c:if>
								<c:if test="${not empty banner.bnrMobileImgPath}">
								<img id="imgPathView1" name="imgPathView1" src="${frame:imagePath( banner.bnrMobileImgPath )}" class="thumb" alt="">
								</c:if>
							</div>
							<div id="bnrMobileImgInfo" style="padding-top:40px;">등록이미지 : 5M 이하/gif,png.jpg(jpeg)</div>
							<div class="inner ml10 bnrMobileImgBtn" style="vertical-align:bottom">
								<button type="button" onclick="fileUpload.image(resultBnrMobileImg);" class="btn"><spring:message code="column.img_reg_yn" /></button> <!-- 찾기-->
								<button type="button" onclick="deleteMobileImage();" class="btn"><spring:message code="column.common.delete" /></button> <!-- 삭제 -->
								<input type="hidden" name="bnrMobileImgPath" id="bnrMobileImgPath" value="${banner.bnrMobileImgPath }" />
								<input type="hidden" name="bnrMobileImgNm" id="bnrMobileImgNm" value="${banner.bnrMobileImgNm }" />
							</div>
							<input type="text" class="w400 validate[required, custom[url]]" id="bnrMobileImgUrl" name="bnrMobileImgUrl" value="${banner.bnrMobileImgUrl }" />
						</td>
					</tr>
					<tr>
						<th><spring:message code="column.bnr_pc_img" /><strong class="red">*</strong><br><span id="pcSize"></span></th>
						<td colspan="7">
							<!-- PC 이미지-->
 							<frame:radio name="bnrImgCd" grpCd="${adminConstants.BNR_IMG_GB}" selectKey="${not empty banner.bnrImgCd ? banner.bnrImgCd : adminConstants.BNR_IMG_GB_20 }" required="true"/><br><br>
							<div id="bnrImgArea" style="float:left;">
								<c:if test="${empty banner.bnrImgPath}">
								<img id="imgPathView2" name="imgPathView2" src="/images/noimage.png" class="thumb" alt="">
								</c:if>
								<c:if test="${not empty banner.bnrImgPath}">
								<img id="imgPathView2" name="imgPathView2" src="${frame:imagePath( banner.bnrImgPath )}" class="thumb" alt="">
								</c:if>
							</div> 
							<div id="bnrImgInfo" style="padding-top:40px;">등록이미지 : 5M 이하/gif,png.jpg(jpeg)</div>
							<div class="inner ml10 bnrImgBtn" style="vertical-align:bottom">
								<button type="button" onclick="fileUpload.image(resultBnrImg);" class="btn"><spring:message code="column.img_reg_yn" /></button> <!-- 찾기-->
								<button type="button" onclick="deleteImage();" class="btn"><spring:message code="column.common.delete" /></button> <!-- 삭제 -->
								<input type="hidden" name="bnrImgPath" id="bnrImgPath" value="${banner.bnrImgPath }" />
								<input type="hidden" name="bnrImgNm" id="bnrImgNm" value="${banner.bnrImgNm }" />
							</div>
							<input type="text" class="w400 validate[required, custom[url]]" id="bnrImgUrl" name="bnrImgUrl" value="${banner.bnrImgUrl }" />
						</td>
					</tr>
					<tr>
						<th><spring:message code="column.tag" /></th>
						<td colspan="7">
							<!-- 태그-->
							<div id="tagList">
							<c:forEach var="bnrTagList" items="${bannerTagList}">
								<span class="rcorners1 SelectedTags" tag-nm="${bnrTagList.tagNm}" id="${bnrTagList.tagNo}">${bnrTagList.tagNm}</span> 
								<img id="${bnrTagList.tagNo}Delete" onclick="deleteTag('${bnrTagList.tagNo}');" class="tagDeleteBtn" src="/images/icon-header-close.svg" />
							</c:forEach>
							</div>
							<div class="mButton">
								<div class="rightInner">
									<button type="button" onclick="tagBaseSearchPop();" class="btn btn-add"> <spring:message code='column.tag_import' /> </button>
								</div>
							</div>
						</td>
					</tr>
					<tr>
						<th><spring:message code="column.connect_screen_url" /><strong class="red">*</strong></th>
						<td colspan="7">
							<!-- 연결화면 URL-->
							<input type="text" class="w400 validate[required, custom[url]]" name="bnrLinkUrl" id="bnrLinkUrl" value="${banner.bnrLinkUrl }"/>
						</td>
					</tr>
				</tbody>
			</table>
		</form>
		별도(*)가 있는 항목은 필수항목입니다.
	
		<div class="btn_area_center">
			<c:if test="${not empty banner.bnrNo }">
				<button type="button" onclick="updateBanner();" class="btn btn-ok">저장</button>
				<button type="button" onclick="deleteBanner();" class="btn btn-cancel">삭제</button>
				<button type="button" onclick="closeTab();" class="btn btn-cancel">목록</button>
			</c:if>
			<c:if test="${empty banner.bnrNo }">
				<button type="button" onclick="insertBanner();" class="btn btn-add">등록</button>
				<button type="button" onclick="reset();" class="btn btn-ok">초기화</button>
				<button type="button" onclick="closeTab();" class="btn btn-cancel">취소</button>
			</c:if>
		</div>
	</t:putAttribute>
</t:insertDefinition>