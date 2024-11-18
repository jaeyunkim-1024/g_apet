<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">
			$(document).ready(function(){
				initEditor();
				$(".special").show();
				$(".nomal").hide();
				
				if("${exhibitionBase.exhbtGbCd}" == 10){
					$(".special").show();
					$(".nomal").hide();
				}
				else if("${exhibitionBase.exhbtGbCd}" == 20){
					$(".special").hide();
					$(".nomal").show();
				}

				//기획전 상태 '종료'인경우
				if("${exhibitionBase.exhbtStatCd}" == 40){
					$("#contents").find("input, select, button, textarea").prop("disalbed", true);
					$("select[name=exhbtGbCd]").prop("disabled", true);
					$("input[name=exhbtNm]").prop("disabled", true);
					$("input[name=exhbtNm]").attr("class", "readonly");
					$("select[name=exhbtStatCd]").prop("disabled", true);
					$("input[name=webMobileGbCd]").prop("disabled", true);
					$("input[name=mdUsrNm]").prop("disabled", true);
					$("input[name=mdUsrNm]").attr("class", "readonly");
					$("input[name=dispStrtDt]").prop("disabled", true);
					$("select[name=dispStrtHr]").prop("disabled", true);
					$("select[name=dispStrtMn]").prop("disabled", true);
					$("input[name=dispEndDt]").prop("disabled", true);
					$("select[name=dispEndHr]").prop("disabled", true);
					$("select[name=dispEndMn]").prop("disabled", true);
					$("input[name=dispYn]").prop("disabled", true);
					$("button[name=readonlyBtn]").prop("disabled", true);
					$(".roundBtn").prop("disabled", true);
				}
				
				
				//기획전 구분 체인지
				$("#exhbtGbCd").change(function(){
					if($(this).val() == 10){
						$(".nomal").hide();
						$(".special").show();
						
						if("${exhibitionBase.exhbtGbCd}" == 20){
							initEditor();
						}
					}else {
						$(".special").hide();
						$(".nomal").show();
					}
				});
				
			});
			
			function initEditor() {
				if("${exhibitionBase.exhbtStatCd}" == 40){
					EditorCommon.setSEditor('ttlHtml', '${adminConstants.EXHIBITION_IMAGE_PATH}', 'Y');
					EditorCommon.setSEditor('ttlMoHtml', '${adminConstants.EXHIBITION_IMAGE_PATH}', 'Y');
				}else{
					EditorCommon.setSEditor('ttlHtml', '${adminConstants.EXHIBITION_IMAGE_PATH}');
					EditorCommon.setSEditor('ttlMoHtml', '${adminConstants.EXHIBITION_IMAGE_PATH}');
				}
			}
			
			function initStId() {
				/* <c:if test="${empty exhibitionBase}">
					document.getElementById("st_1").checked = true;
				</c:if> */
			}

			function fnChangeView( viewType, stat ) {
				stat = $("#exhbtStatCd").val();
				var url;
				if ( viewType == 10 ) {
					url = "/promotion/exhibitionBaseView.do";
				} else if ( viewType == 20 ) {
					url = "/promotion/exhibitionThemeView.do";
				} else if ( viewType == 30 ) {
					url = "/promotion/exhibitionThemeGoodsView.do";
				}
				url += '?exhbtNo=' + '${exhibitionBase.exhbtNo}&exhbtStatCd='+stat;
				updateTab(url, "기획전 상세");
			}
			
			$(document).on("click", "#bnrImgPath, #bnrMoImgPath", function(){
				var id = $(this).attr('id')
				var width;
				var height;
				
				if(id == 'bnrImgPath'){
					width = 1200;
					height = 250;
				}else if(id == 'bnrMoImgPath') {
					width = 750;
					height = 362;
				}
				
				var limitObj = {
					width : width,
					height : height
				}
				
				fileUpload.imageCheck(resultImage,  id ,limitObj);
			})
			
			// 이미지 업로드 결과
			function resultImage (file, id) {
				$("#" + id).val(file.filePath);
				$("#" + id + "View").attr('src', '/common/imageView.do?filePath=' + file.filePath );	
				$("#" + id + "View").height("100px");
			}

			function deleteImage () {
				$("#" + imageId).val("");
				$("#" + imageId + "View").attr('src', '/images/noimage.png' );
				$("#" + imageId + "View").height("");
			}

			function updateExhibitionBase() {
				
				oEditors.getById["ttlHtml"].exec("UPDATE_CONTENTS_FIELD", []);
				oEditors.getById["ttlMoHtml"].exec("UPDATE_CONTENTS_FIELD", []);
				
				if(validate.check("exhibitionBaseForm")) {
					
					if ($("#dispStrtDt").val() == "") {
						messager.alert("<spring:message code='admin.web.view.msg.exhibition.term' />","Info","info",function(){
							$("#dispStrtDt").focus();
						});
		                return false;
					} else if ($("#dispEndDt").val() == "") {
						messager.alert("<spring:message code='admin.web.view.msg.exhibition.term' />","Info","info",function(){
							$("#dispEndDt").focus();
						});
		                return false;
					} else if ($("#dispStrtDt").val() > $("#dispEndDt").val()){
						messager.alert("기간 시작일은 종료일과 같거나 이전이여야 합니다","Info","info",function(){
							$("#dispStrtDt").focus();
						});
						 return false;
					}
					
					$("#dispStrtDtm").val(getDateStr ("dispStrt"));
					$("#dispEndDtm").val(getDateStr ("dispEnd"));
					
					messager.confirm('<spring:message code="column.common.confirm.save" />',function(r){
						if(r){
							var data = $("#exhibitionBaseForm").serializeJson();

							var options = {
								url : "<spring:url value='/promotion/exhibitionBaseSave.do' />"
								, data : data
								, callBack : function(result){
									messager.alert("<spring:message code='column.display_view.message.save.theme_insert'/>","Info","info",function(){
										//updateTab('/promotion/exhibitionBaseView.do?exhbtNo=' + result.exhbtNo, '기획전 상세');
										closeGoTab('기획전 목록', '/promotion/exhibitionListView.do');
									});								
								}
							};

							ajax.call(options);					
						}
					});
				}
			}
			
			//미리보기
			function viewExhibitionDetail (exhbtNo) {
				var upDispClsfNo = $("#upDispClsfNo").val();
				
				if('${adminConstants.PETSHOP_DOG_DISP_CLSF_NO}' == upDispClsfNo ) {			// 강아지
					upDispClsfNo = '${adminConstants.PETSHOP_MAIN_DOG_DISP_CLSF_NO}'
				} else if('${adminConstants.PETSHOP_CAT_DISP_CLSF_NO}' == upDispClsfNo ) {	// 고양이
					upDispClsfNo = '${adminConstants.PETSHOP_MAIN_CAT_DISP_CLSF_NO}'
				} else if('${adminConstants.PETSHOP_FISH_DISP_CLSF_NO}' == upDispClsfNo ) {	// 관상어
					upDispClsfNo = '${adminConstants.PETSHOP_MAIN_FISH_DISP_CLSF_NO}'
				} else if('${adminConstants.PETSHOP_ANIMAL_DISP_CLSF_NO}' == upDispClsfNo ) {	// 소동물
					upDispClsfNo = '${adminConstants.PETSHOP_MAIN_ANIMAL_DISP_CLSF_NO}'
				}
					
				var exhbtGbCd = $("#exhbtGbCd option:selected").val();
				var url;
								
				// 210621 [CSR-1169] BO >> 기획전목록 >> 미리보기 기존 개발건 추가
				var domain;
				
				if ("${env}" == "${adminConstants.ENVIRONMENT_GB_LOCAL}") {
					domain = "localhost:8180";
				} else if ("${env}" == "${adminConstants.ENVIRONMENT_GB_DEV}") {
					domain = "dev.";
				} else if ("${env}" == "${adminConstants.ENVIRONMENT_GB_STG}") {
					domain = "stg.";
				} else {
					domain = "";
				}
				
				if ("${env}" == "${adminConstants.ENVIRONMENT_GB_LOCAL}") {
					if(exhbtGbCd == "${adminConstants.EXHBT_GB_10}") { //특별
						url = "<spring:url value='http://"+domain+"/event/indexSpecialExhibitionZone?exhbtNo="+exhbtNo+"&dispClsfNo="+upDispClsfNo+"' />";
					}else{//일반
						url = "<spring:url value='http://"+domain+"/event/indexExhibitionDetail?exhbtNo="+exhbtNo+"&dispClsfNo="+upDispClsfNo+"' />";
					} 
				}  else {
					
					if(exhbtGbCd == "${adminConstants.EXHBT_GB_10}") { //특별
						url = "<spring:url value='https://"+domain+"aboutpet.co.kr/event/indexSpecialExhibitionZone?exhbtNo="+exhbtNo+"&dispClsfNo="+upDispClsfNo+"' />";
					}else{//일반
						url = "<spring:url value='https://"+domain+"aboutpet.co.kr/event/indexExhibitionDetail?exhbtNo="+exhbtNo+"&dispClsfNo="+upDispClsfNo+"' />";
					} 
				}

				var data = {
// 					page : 1
// 					, rows : 40
// 					, exhbtNo : exhbtNo
// 					, sortType : 'NW'
				}
				
				createTargetFormSubmit({
					  id : "viewExhibitionDetailForm"
					, url : url
					, target : '_blank'
					, data : data
				});
			}
			
			/**
			 * 태그 검색 팝업 호출
			 */
			function tagBaseSearchPop() {
				let sTag = $(".SelectedTag");
				
				if (sTag.length >= 10) {
					messager.alert("<spring:message code='admin.web.view.msg.vod.limit.tag' />", "Info", "info");
				} 
				else {
					var options = {
						multiselect : true
						, callBack : function(result) {
							var message = new Array();
							
							if(result != null && result.length > 0) {
								var tagHtml = '';
								var flagTagAdd = true;
								var sTag = $(".SelectedTag");
								var tagLength = sTag.length;
								var msg = "";
								var cnt = -1;
								
								for(var i in result) { 
									flagTagAdd = true;
									
									$.each(sTag, function(index, tagNo) {
										if($(this).data('tag') === result[i].tagNo ){
											flagTagAdd = false;
											msg = "'"+result[i].tagNm+"'";
// 											message.push(result[i].tagNm + " 중복된 Tag 입니다.");
											return false;
										}else{
											flagTagAdd = true;
										}
									});
									
									if(flagTagAdd) {
										tagLength++;
										if(tagLength < 11){
											tagHtml += '<span class="rcorners1 SelectedTag" id="tag_'+result[i].tagNo+'" data-tag="'+result[i].tagNo+'">';
											tagHtml += '<input type="hidden" name="tagNos" value="'+result[i].tagNo+'"/>#'+ result[i].tagNm;
											tagHtml += '</span>';
											tagHtml += '<img id="tag_'+result[i].tagNo+'Delete" onclick="removeTag(\'tag_'+result[i].tagNo+'\',\''+result[i].tagNm+'\')" class="tagDeleteBtn" src="/images/icon-header-close.svg" />';
										}
									}else{
										cnt++;
									}
								}
								if(cnt > -1){
									if(cnt == 0){
										msg += "<spring:message code='admin.web.view.msg.vod.dupl.tag' />";
									}else{
										msg += " 외 " + cnt + "건 " + "<spring:message code='admin.web.view.msg.vod.dupl.tag' />";
									}
									if (tagLength < 11) {
										messager.alert(msg, "Info", "info");										
									}
								}
								
								
							}
							if (tagLength < 11) {
								$("#searchTags").append (tagHtml);
							}else{
								messager.alert("<spring:message code='admin.web.view.msg.vod.limit.tag' />", "Info", "info");
							}
							
// 							if(sTag.length > 10){
// 								message.push("10개까지만 등록할 수 있습니다.");
// 							}else{
// 								$("#searchTags").append (tagHtml);
// 							}
							
// 							if(message != null && message.length > 0) {
// 								messager.alert(message.join("<br/>"), "Info", "info");
// 							}
						}
					};
					layerTagBaseList.create(options);
				}
			}
			
			/**
			 * 태그 삭제
			 * 검색용 tags input box도 같이 삭제
			 * @param no
			 * @param nm
			 */
			function removeTag(no,nm) {
				$('#'+no).empty();
				layerTagBaseList.deleteTag(no, nm);
				//console.log($('#'+no+'Hidden').length);
			}
			
			/* 전시 카테고리 팝업 */
			function getCategoryInfoPop(){
				var resultDispClsfNo;
				var resultDispClsfNm;
				var resultCtgPath;
				
				var options = {
						multiselect : true
						, stId : 1
						, dispClsfCd : "${adminConstants.DISP_CLSF_10}"
						, exhibitionYn : "Y"
						, plugins : [ "themes" ]
						, callBack : function(result) {

							if(result != null && result.length > 0) {
								data = result[0];
								resultDispClsfNo = data.dispNo;
								resultDispClsfNm = data.dispNm;
								resultCtgPath = data.dispPath;
								resultDispLvl = data.dispLvl;
								reulstUpDispClsfNo = data.upDispNo;
							}
								
							if(resultDispLvl == 2){
								$("#dispClsfNo").val(resultDispClsfNo);
								$("#upDispClsfNo").val(reulstUpDispClsfNo);
								$("#dispClsfNm").val(resultDispClsfNm);
							}else {
								messager.alert("2dept를 선택해 주세요.","Info","info");
								return;
							}
							
						}
							
					}
					layerCategoryList.create(options);
			}
			
			/* 기획전 삭제 */
			function deleteExhibitionBase(){
				messager.confirm('<spring:message code="column.common.confirm.delete" />',function(r){
					if(r){
						var data = {
			 					exhbtNo : $("#exhbtNo").val()
								,delYn : "Y"
							}
						
						var options = {
							url : "<spring:url value='/promotion/exhibitionBaseSave.do' />"
							, data : data
							, callBack : function(result){
								messager.alert("<spring:message code='column.display_view.message.delete'/>","Info","info",function(){
									updateTab('/promotion/exhibitionListView.do', '기획전 목록');
								});								
							}
						};

						ajax.call(options);					
					}
				});
			}
			
			//상세에서 기획전 복사
			function copyExhibitionBase(exhbtNo){
				addTab('기획전 복사', '/promotion/exhibitionBaseView.do?exhbtNo=' + exhbtNo+ '&copyYn=Y');
			}
			
			//SEO 정보 설정
			function fnSeoInfoDetailView(){
				var seoInfoNo = $("[name='seoInfoNo']").val();
				var options = {
 					url : '/display/seoInfoPop.do'
					, data : {
						seoInfoNo : seoInfoNo
					  	, seoExhibiCd : "seoExhibiCd"
						}
					, dataType : "html"
					, callBack : function (result) {
						var buttonText = seoInfoNo != "" ? "수정" : "등록" ;
 						var config = {
 							id : "seoInfoDetail"
							, width : 960
							, height : 700
							, top : 70
							, title : "SEO 상세정보"
							, button : "<button type=\"button\" onclick=\"updateSeoInfoPopup();\" class=\"btn btn-add\">"+buttonText+"</button>" + "<button type=\"button\" onclick=\"fnResetSeoForm(50, 10);\" class=\"btn btn-ok ml10\">초기화</button>"
							, body : result
						};
						layer.create(config);
						$("#seoInfoDetail_dlg-buttons").find(".btn-cancel").hide();
					}
				};
				ajax.call(options);
			}
			
			// SEO 정보 등록/수정 후 callBack
			function callBackSaveSeoInfo(seoInfoNo) {
 				$("#seoInfoNo").val(seoInfoNo);
			}
			
		</script>
	</t:putAttribute>
	<t:putAttribute name="content">
	
		<div class="mTab">
			<ul class="tabMenu">
				<li class="active"><a href="javascript:fnChangeView(10)">기본정보</a></li>
				<li><a ${not empty exhibitionBase and copyYn != "Y" ? 'href="javascript:fnChangeView(20)"' : '' } style="padding-bottom: 9px;">테마정보</a></li>
				<li><a ${not empty exhibitionBase and exhibitionBase.exhbtThmCnt > 0 and copyYn != "Y" ? 'href="javascript:fnChangeView(30)"' : '' } style="padding-bottom: 9px;">상품정보</a></li>
			</ul>
		</div>
		
		<div class="mTitle">
			<h2>기획전 기본정보</h2>
			<div class="buttonArea">
				<c:if test="${copyYn !=  'Y'}">
					<button type="button" onclick="copyExhibitionBase('${exhibitionBase.exhbtNo}');"class="btn btn-add" style="display:none">기획전 복사</button>
				</c:if>
				<c:if test="${not empty exhibitionBase and adminConstants.WEB_MOBILE_GB_20 ne exhibitionBase.webMobileGbCd}">
					<button type="button" onclick="viewExhibitionDetail('${exhibitionBase.exhbtNo }');" class="btn btn-add"  ${exhibitionBase.exhbtStatCd eq adminConstants.EXHBT_STAT_40 ? 'style="display:none"' : ''}>미리보기</button>
				</c:if>
			</div>
		</div>
	
		<form id="exhibitionBaseForm" name="exhibitionBaseForm" method="post" >
			<input type="hidden" id="dispStrtDtm" name="dispStrtDtm" class="validate[required]" value="" />
			<input type="hidden" id="dispEndDtm" name="dispEndDtm" class="validate[required]" value="" />
				<div>
					<table class="table_type1">
						<c:if test="${empty exhibitionBase}">
							<caption>기획전 등록</caption>
						</c:if>
						<c:if test="${not empty exhibitionBase}">
							<caption>기획전 상세</caption>
						</c:if>
						<tbody>
							<c:choose>
								<c:when test="${adminConstants.USR_GRP_10 eq adminSession.usrGrpCd}">
									<c:set value="Y" var="isUser"/> 
								</c:when>
								<c:otherwise>
									<c:set value="N" var="isUser"/> 
								</c:otherwise>
							</c:choose>
							<tr>
								<!-- 기획전 번호 -->
								<th><spring:message code="column.exhbt_number" /><strong class="red">*</strong></th>	
								<td>
									<input type="hidden" id="exhbtNo" name="exhbtNo" value="${exhibitionBase.exhbtNo}" />
									<c:if test="${empty exhibitionBase || copyYn == 'Y'}">
										<b>자동입력</b>
									</c:if>
									<c:if test="${not empty exhibitionBase && copyYn != 'Y'}">
										<b>${exhibitionBase.exhbtNo }</b>
									</c:if>
								</td>
								<!-- 기획전 구분 코드-->
								<th><spring:message code="column.exhbt_gb_cd"/></th>
								<td>
									<select name="exhbtGbCd" id="exhbtGbCd" ${exhibitionBase.exhbtStatCd eq adminConstants.EXHBT_STAT_20 || exhibitionBase.exhbtStatCd eq adminConstants.EXHBT_STAT_30? 'disabled' : ''}>
										<frame:select grpCd="${adminConstants.EXHBT_GB}" selectKey="${exhibitionBase.exhbtGbCd}"/>
									</select>
								</td>
							</tr>
							<tr>
								<!-- 기획전 명 -->
								<th><spring:message code="column.exhbt_nm" /><strong class="red">*</strong></th>
								<td>
									<input type="text" class="w300 validate[required] " name="exhbtNm" id="exhbtNm" title="<spring:message code="column.exhbt_nm"/>"  value="${exhibitionBase.exhbtNm}" maxlength="100"/>
								</td>
								<!-- 기획전 승인 상태 코드 -->
								<th><spring:message code="column.exhbt_stat_cd" /></th>
		                        <td>
									<select name="exhbtStatCd" id="exhbtStatCd" title="<spring:message code="column.exhbt_stat_cd"/>">
										<frame:select grpCd="${adminConstants.EXHBT_STAT}" selectKey="${empty exhibitionBase.exhbtGbCd ? adminConstants.EXHBT_STAT_10 : exhibitionBase.exhbtStatCd}" 
											excludeOption="${empty exhibitionBase.exhbtStatCd ? adminConstants.EXHBT_STAT_30 : '' 
															|| exhibitionBase.exhbtStatCd eq adminConstants.EXHBT_STAT_20 ? adminConstants.EXHBT_STAT_10 : ''
															|| exhibitionBase.exhbtStatCd eq adminConstants.EXHBT_STAT_30 ? adminConstants.EXHBT_STAT_10 : ''
															}"/>
									</select>
		                        </td>
							</tr>
							<tr>
								<!-- 웹/모바일 구분 -->
								<th><spring:message code="column.web_mobile_gb_cd" /></th>	
								<td>
									<frame:radio name="webMobileGbCd" grpCd="${adminConstants.WEB_MOBILE_GB }" selectKey="${exhibitionBase.webMobileGbCd }" excludeOption="${adminConstants.WEB_MOBILE_GB_30}"/>
								</td>
								<!-- 전시 카테고리  -->
								<th><spring:message code="column.disp_ctg" /><strong class="red">*</strong></th>
								<td>
									<input type="hidden" name="dispClsfNo" id="dispClsfNo" value="${exhibitionBase.dispClsfNo }" />
									<input type="hidden" name="upDispClsfNo" id="upDispClsfNo" value="${exhibitionBase.upDispClsfNo }" />
									<input type="text" readonly class="w150 readonly validate[required]" name="dispClsfNm" id="dispClsfNm" title="<spring:message code="column.disp_ctg" />"  value="${exhibitionBase.dispClsfNm }" />
									<button type="button" name="readonlyBtn" class="btn" onclick="getCategoryInfoPop()" >카테고리 선택</button>
								</td>
								<!-- 사이트 ID -->
								<th style="display:none"><spring:message code="column.st_id"/><strong class="red">*</strong></th>
								<td style="display:none">
                                    <select id="stIdCombo" class="validate[required]" name="stId">
										<frame:stIdStSelect defaultName="사이트선택" />
									</select>
								</td>
							</tr>							
							<tr>
								<!-- 담당 MD -->
								<th><spring:message code="column.exhbt_md_usr_nm" /><strong class="red">*</strong></th>
								<td>
									<input type="text" class="w200 validate[required]" name="mdUsrNm" id="mdUsrNm" title="<spring:message code="column.exhbt_md_usr_nm" />"  value="${exhibitionBase.mdUsrNm}" />
								</td>
								<!-- 전시여부 -->
								<th><spring:message code="column.disp_yn"/></th>
								<td>
									<frame:radio name="dispYn" grpCd="${adminConstants.DISP_YN }" selectKey="${exhibitionBase.dispYn }" />
								</td>
							</tr>
							<tr>
								<!-- 전시기간 -->
								<th><spring:message code="column.display_view.disp_date"/><strong class="red">*</strong></th>
								<td colspan="3">
									<c:choose>
										<c:when test="${empty exhibitionBase}">
											<frame:datepicker startDate="dispStrtDt"
													  startHour="dispStrtHr"
													  startMin="dispStrtMn"
													  startSec="dispStrtSec"
													  startValue="${frame:toDate('yyyy-MM-dd')}"
													  endDate="dispEndDt"
													  endHour="dispEndHr"
													  endMin="dispEndMn"
													  endSec="dispEndSec"
													  endValue="${frame:toDate('yyyy-MM-dd')}" 
													  />
										</c:when>
										<c:otherwise>
											<frame:datepicker startDate="dispStrtDt"
													  startHour="dispStrtHr"
													  startMin="dispStrtMn"
													  startSec="dispStrtSec"
													  startValue="${exhibitionBase.dispStrtDtm }"
													  endDate="dispEndDt"
													  endHour="dispEndHr"
													  endMin="dispEndMn"
													  endSec="dispEndSec"
													  endValue="${exhibitionBase.dispEndDtm }"
													  />
										</c:otherwise>
									</c:choose>
								</td>
							</tr>
							<!-- SEO 정보설정  -->
							<tr>
								<th><spring:message code="column.display.disp_clsf.seo_info_no"/></th>
								<td colspan="3">
									<input type="text" class="readonly w100" name="seoInfoNo" id="seoInfoNo" value="${exhibitionBase.seoInfoNo}" readonly/>
									<button type="button" name="readonlyBtn" class="btn" onclick="fnSeoInfoDetailView();" ><spring:message code="column.display.disp_clsf.seo_info_set" /></button>
								</td>
							</tr>
							<tr>
								<!-- 태그 -->
								<th><spring:message code="column.goods.tag"/></th>
								<td colspan="3">
									<span id="searchTags">
										<c:forEach items="${exhibitionTag}" var="item">
											<span class="rcorners1 SelectedTag" id="tag_${item.tagNo}" data-tag="${item.tagNo}">
											<input type="hidden" name="tagNos" value="${item.tagNo}"/>#${item.tagNm}</span> 
											<img id="tag_${item.tagNo}Delete" onclick="removeTag('tag_${item.tagNo}','${item.tagNm}')" class="tagDeleteBtn" src="/images/icon-header-close.svg" />
										</c:forEach>
									</span>
									<button type="button" class="roundBtn" onclick="tagBaseSearchPop();" >+ 추가</button>
								</td>
							</tr>
							<tr class="nomal">
								<th><spring:message code="column.exhibition_view.bnr_img_path"/></th>
								<td colspan="3">
									<!-- 목록 이미지(PC)-->
									<div class="inner">
										<input type="hidden" id="bnrImgPath" name="bnrImgPath" value="${exhibitionBase.bnrImgPath}" />
										<c:if test="${not empty exhibitionBase.bnrImgPath}">
											<img id="bnrImgPathView" name="bnrImgPathView" src="<frame:imgUrl/>${exhibitionBase.bnrImgPath }" class="thumb" alt="" />
										</c:if>
										<c:if test="${empty exhibitionBase.bnrImgPath}">
											<img id="bnrImgPathView" name="bnrImgPathView" src="/images/noimage.png" class="thumb" alt="" />
										</c:if>
									</div>
									<div id="pushImg" class="inner ml10" style="vertical-align:bottom">
										<button type="button" name="readonlyBtn" class="btn" id="bnrImgPath""><spring:message code="column.common.addition" /></button> <!-- 추가 -->
										<button type="button" name="readonlyBtn" class="btn" onclick="imageId='bnrImgPath';deleteImage();" ><spring:message code="column.common.delete" /></button> <!-- 삭제 -->
                                        <span class="red-desc">(PC 이미지 사이즈: 1200x250)</span>
                                    </div>
								</td>
							</tr>
							<tr class="nomal">
								<th><spring:message code="column.exhibition_view.bnr_mo_img_path"/></th>
								<td colspan="3">
									<!-- 목록 이미지(MOBILE) -->
									<div class="inner">
										<input type="hidden" id="bnrMoImgPath" name="bnrMoImgPath" value="${exhibitionBase.bnrMoImgPath}" />
										<c:if test="${not empty exhibitionBase.bnrMoImgPath}">
											<img id="bnrMoImgPathView" name="bnrMoImgPathView" src="<frame:imgUrl/>${exhibitionBase.bnrMoImgPath }" class="thumb" alt="" />
										</c:if>
										<c:if test="${empty exhibitionBase.bnrMoImgPath}">
											<img id="bnrMoImgPathView" name="bnrMoImgPathView" src="/images/noimage.png" class="thumb" alt="" />
										</c:if>
									</div>
									<div id="pushImg" class="inner ml10" style="vertical-align:bottom">
										<button type="button" name="readonlyBtn" class="btn" id="bnrMoImgPath"><spring:message code="column.common.addition" /></button> <!-- 추가 -->
										<button type="button" name="readonlyBtn" class="btn" onclick="imageId='bnrMoImgPath';deleteImage();" ><spring:message code="column.common.delete" /></button> <!-- 삭제 -->
										<span class="red-desc">(MO 이미지 사이즈: 750x362)</span>
									</div>
								</td>
							</tr>
							<tr class="special">
								<th><spring:message code="column.exhibition_view.disp_clsf_title_html"/></th>
								<td colspan="3">
									<!-- 타이틀 HTML(PC)-->
									<textarea name="ttlHtml" id="ttlHtml" class="validate[required]" cols="30" rows="10" style="width: 98%" ${exhibitionBase.exhbtStatCd eq 'adminConstants.EXHBT_STAT_40' ? '' : 'readonly="readonly"' }>${exhibitionBase.ttlHtml}</textarea>
								</td>
							</tr>
							<tr class="special">
								<th><spring:message code="column.exhibition_view.disp_clsf_mtitle_html"/></th>
								<td colspan="3">
									<!-- 타이틀 HTML(MO)-->
									<textarea name="ttlMoHtml" id="ttlMoHtml" class="validate[required]" cols="30" rows="10" style="width: 98%" ${exhibitionBase.exhbtStatCd eq 'adminConstants.EXHBT_STAT_40' ? '' : 'readonly="readonly"' }>${exhibitionBase.ttlMoHtml}</textarea>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
		</form>

		<div class="btn_area_center"> 
			<c:if test="${empty exhibitionBase || copyYn == 'Y' }">
				<button type="button" onclick="updateExhibitionBase();" class="btn btn-ok">등록</button>
				<button type="button" onclick="closeTab();" class="btn btn-cancel">취소</button>
			</c:if>
			<c:if test="${not empty exhibitionBase && copyYn != 'Y' }">
				<button type="button" onclick="${exhibitionBase.exhbtStatCd ne adminConstants.EXHBT_STAT_40 ? 'updateExhibitionBase();' : '' }" ${exhibitionBase.exhbtStatCd eq adminConstants.EXHBT_STAT_40 ? 'style="display:none"' : ''} class="btn btn-ok">수정</button>
				<button type="button" onclick="deleteExhibitionBase();" class="btn btn-add">삭제</button>
				<button type="button" onclick="closeTab();" class="btn btn-cancel">닫기</button>
			</c:if>
		</div>
	</t:putAttribute>
</t:insertDefinition>
