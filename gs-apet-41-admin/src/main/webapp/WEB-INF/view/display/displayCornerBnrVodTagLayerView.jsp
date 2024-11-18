<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
		<script type="text/javascript">
			$(document).ready(function() {
				// 제한 없음 날짜 셋팅
				var dispEnddt =  $("#dispEnddt").val();
				if(dispEnddt == '9999-12-31') {
					$("input:checkbox[id=noLimit]").prop("checked", true);
				}else {
					$("input:checkbox[id=noLimit]").prop("checked", false);
				}
				
	  			if(${fn:length(tagList)} > 0) {
	  				var html = '';
	  				<c:forEach items="${tagList}" var = "tagList">
	  					html += '<span class="rcorners1 SelectedTag" tag-nm="'+'${tagList.tagNm}'+'" id="'+'${tagList.tagNo}'+'">'+'${tagList.tagNm}'+'</span>' 
	  					html += '<img id="'+'${tagList.tagNo}'+'Delete" onclick="deleteTag(\''+'${tagList.tagNo}'+'\');" class="tagDeleteBtn" src="/images/icon-header-close.svg" />'
	  				</c:forEach>
				}
	  			$("#tagList").append (html);
	  			
	  			if("${so.dispCornTpCd}" == "${adminConstants.DISP_CORN_TP_72}") {
	  				$("#pcImg").hide();
	  				$("#moImg").hide();
	  			}
	  			
	  			if("${so.dispCornTpCd}" == "${adminConstants.DISP_CORN_TP_72}" && "${so.dispCnrItemNo}" != "") {
	  				$("#pcImg").show();
	  				$("#moImg").show();
	  			}
	  			
	  			$("input[id=noLimit]").change(function() {
					var check = $(this).prop("checked");
					if (check) {
						$("#dispEnddt").datepicker('setDate',"${adminConstants.COMMON_END_DATE}");
					} else {
						$("#dispEnddt").val(dispEnddt == '9999-12-31' ? "${frame:addMonth('yyyy-MM-dd', 1)}" : dispEnddt);
					}
				});
			});
			
			//태그 삭제
			function deleteTag(tagNo) {
				$("#"+ tagNo).remove();
				$("#"+ tagNo + "Delete").remove();
			}	
			
			//영상 검색 팝업
			function videoSearchLayerViewPop() {
					var options = {
							multiselect : false
							, callBack : searchVideoPcCallBack
					};
					layerVodList.create(options);
			}
			
			//영상 검색 콜백함수
			function searchVideoPcCallBack(data){
				$("#pcImg").show();
				$("#moImg").show();
				
				$("#bnrImgPath").val(data[0].thumPathValue);
				$("#bnrMobileImgPath").val(data[0].thumPathValue);
				$("#displayCornerItemPopForm #contentId").val(data[0].vdId);
				$("#displayCornerItemPopForm #contentTtl").val(data[0].ttl);
				$("#displayCornerItemPopForm #vdId").val(data[0].vdId);
				$("#displayCornerItemPopForm #bnrNo").val("");
				$("#imgPathView1").attr('src', '/common/imageView.do?filePath=' + data[0].thumPathValue);
				$("#imgPathView2").attr('src', '/common/imageView.do?filePath=' + data[0].thumPathValue);
				$("#bnrVodGb").val("vod");
				$("#pcBannerBtn").hide();
			}
			
			//배너 검색 팝업
			function bannerSearchLayerViewPop() {
					var options = {
							multiselect : false
							, callBack : searchPcBannerCallBack
					};
					layerBannerList.create(options);
			}
			
			//배너 검색 콜백함수
			function searchPcBannerCallBack(data){
				$("#pcImg").show();
				$("#moImg").show();
				
				$("#displayCornerItemPopForm #bnrImgPath").val(data[0].bnrPcImgPath);
				$("#displayCornerItemPopForm #bnrMobileImgPath").val(data[0].bnrMoImgPath);
				$("#displayCornerItemPopForm #bnrLinkUrl").val(data[0].bnrLinkUrl);
				$("#displayCornerItemPopForm #bnrMobileLinkUrl").val(data[0].bnrMobileLinkUrl);
				$("#displayCornerItemPopForm #bnrMobileImgPath").val(data[0].bnrMoImgPath);
				//$("#displayCornerItemPopForm #contentId").val(data[0].bnrId);
				$("#displayCornerItemPopForm #contentTtl").val(data[0].bnrTtl);
				$("#displayCornerItemPopForm #bnrNo").val(data[0].bnrNo);
				$("#displayCornerItemPopForm #vdId").val("");
				$("#imgPathView1").attr('src', '/common/imageView.do?filePath=' + data[0].bnrPcImgPath);
				$("#imgPathView2").attr('src', '/common/imageView.do?filePath=' + data[0].bnrMoImgPath);
				$("#bnrVodGb").val("bnr");
				$("#pcVideoBtn").hide();
			}
			
			//태그 불러오기 팝업
			function tagBaseSearchPop() {
				var gridLength = ${so.itemLength};
				var thisLength = $("div[id=tagList] span").length;
				var tagMaxCheck = gridLength + thisLength;
				
				if(tagMaxCheck < 4) {
					var options = {
						multiselect : true
						, callBack : function(result) {
							var check = true;
							if(result != null && result.length > 0) {
	
								var message = new Array();
								var sTag = $(".SelectedTag");
								
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
										var html = '<span class="rcorners1 ' + 'SelectedTag" tag-nm="' + addData.tagNm +'" id="' + addData.tagNo + '">' + addData.tagNm + '</span>' 
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
				}else {
					messager.alert("<spring:message code='admin.web.view.msg.display.limit.tag.error' />","Info","info");
				}
			}
		
			function deleteTag(tagNo) {
				$("#"+ tagNo).remove();
				$("#"+ tagNo + "Delete").remove();
			}	
			
			// PC 이미지 파일 업로드
			function resultBnrImg(file) {
				$("#bnrImgPath").val(file.filePath);
				
				$("#imgPathView1").attr('src', '/common/imageView.do?filePath=' + file.filePath);
			}
			
			// MO 이미지 파일 업로드
			function resultBnrMobileImg(file) {
				$("#bnrMobileImgPath").val(file.filePath);
				
				$("#imgPathView2").attr('src', '/common/imageView.do?filePath=' + file.filePath);
			}
			
			function getImage(imgPath, bnrTtl) {
				return "<img src='${frame:optImagePath('"+imgPath+"', adminConstants.IMG_OPT_QRY_410)}' alt='"+bnrTtl+"'>"
			}
			
		</script>
		
		<form name="displayCornerItemPopForm" id="displayCornerItemPopForm">
			<input type="hidden" name="dispCnrItemNo" id="dispCnrItemNo" value="${so.dispCnrItemNo}" />
			<input type="hidden" name="dispClsfNo" id="dispClsfNo" value="${so.dispClsfNo}" />
			<input type="hidden" name="itemLength" id="itemLength" value="${so.itemLength}" />
			<input type="hidden" name="bnrNo" id="bnrNo" value="${listDisplayCornerBannerGrid[0].bnrNo }" />
			<input type="hidden" name="vdId" id="vdId" value="${listDisplayCornerVdGrid[0].vdId}" />
			<input type="hidden" name="contentId" id="contentId" />
			<input type="hidden" name="contentTtl" id="contentTtl" />
			<input type="hidden" name="dispBnrNo" id="dispBnrNo" value="${listDisplayCornerBnrVodTagGrid[0].dispBnrNo }"/>
			<input type="hidden" name="bnrVodGb" id="bnrVodGb" />
			<table class="table_type1">
				<caption>전시 코너 아이템</caption>
				<colgroup>
				</colgroup>
				<tbody>
					<tr>
						<th><spring:message code="column.disp_corn_tp_cd" /><strong class="red">*</strong></th>
						<td colspan="3">
							<select name="dispCornTpCd" id="dispCornTpCd" class="validate[required]" title="<spring:message code="column.disp_corn_tp_cd" />" disabled="disabled">
								<frame:select grpCd="${adminConstants.DISP_CORN_TP}" selectKey="${so.dispCornTpCd}" />
							</select>
						</td>
					</tr>
					<c:if test="${so.dispCornTpCd eq adminConstants.DISP_CORN_TP_71 || so.dispCornTpCd eq adminConstants.DISP_CORN_TP_133}">
					<tr>
						<th><spring:message code="column.display_view.vod" /><strong class="red">*</strong></th>
						<td colspan="3">
							<input type="text" name="vdId" id="vdId" readonly="readonly" value="${listDisplayCornerVdGrid[0].vdId}" />
							<button type="button" class="btn" id="pcVideoBtn" onclick="videoSearchLayerViewPop();"><spring:message code="column.video_search_btn" /></button>
							<input type="hidden" name="bnrImgPath" id="bnrImgPath" value="${listDisplayCornerVdGrid[0].thumPath}"/>
							<input type="hidden" name="bnrImgPath" id="bnrMobileImgPath" value="${listDisplayCornerVdGrid[0].thumPath}"/>
						</td>
					</tr>
					</c:if>
					<c:if test="${so.dispCornTpCd eq adminConstants.DISP_CORN_TP_75}">
					<tr>
						<th><spring:message code="column.disp_banner" /><strong class="red">*</strong></th>
						<td colspan="3">
							<input type="text" name="bnrNo" id="bnrNo" readonly="readonly" value="${listDisplayCornerBannerGrid[0].bnrNo }" />
							<button type="button" class="btn" id="pcBannerBtn" onclick="bannerSearchLayerViewPop();"><spring:message code="column.banner_search_btn" /></button>
							<input type="hidden" name="bnrImgPath" id="bnrImgPath" value="${listDisplayCornerBannerGrid[0].bnrImgPath}"/>
							<input type="hidden" name="bnrMobileImgPath" id="bnrMobileImgPath" value="${listDisplayCornerBannerGrid[0].bnrMobileImgPath}"/>
							<input type="hidden" name="bnrLinkUrl" id="bnrLinkUrl" />
							<input type="hidden" name="bnrMobileLinkUrl" id="bnrMobileLinkUrl"/>
						</td>
					</tr>
					</c:if>
					<c:if test="${so.dispCornTpCd eq adminConstants.DISP_CORN_TP_72}">
					<tr>
						<th><spring:message code="column.disp_corn_img_vod_pc" /><strong class="red">*</strong></th>
						<td colspan="3">
							<button type="button" class="btn" id="pcVideoBtn" onclick="videoSearchLayerViewPop();"><spring:message code="column.video_search_btn" /></button>
							<button type="button" class="btn" id="pcBannerBtn" onclick="bannerSearchLayerViewPop();"><spring:message code="column.banner_search_btn" /></button>
						</td>
					</tr>
					<tr id="pcImg">
						<th><spring:message code="column.disp_corn_tn_vod_pc" /><strong class="red">*</strong></th>
						<td colspan="3">
							<div id="bnrImgArea" style="float:left;">
								<c:if test="${empty listDisplayCornerBnrVodTagGrid[0].bnrImgPath}">
								<img id="imgPathView1" name="imgPathView1" src="/images/noimage.png" class="thumb" alt="">
								</c:if>
								<c:if test="${not empty listDisplayCornerBnrVodTagGrid[0].bnrImgPath}">
								<img id="imgPathView1" name="imgPathView1" src="<frame:imgUrl/>${listDisplayCornerBnrVodTagGrid[0].bnrImgPath}" class="thumb" alt="">
								</c:if>
							</div>
							<div class="mButton">
								<div class="rightInner">
									<button type="button" onclick="fileUpload.image(resultBnrImg);" class="btn"><spring:message code="column.img_reg_yn" /></button> <!-- 찾기-->
								</div>
							</div>
						</td>
						<input type="hidden" id="bnrImgPath" name="bnrImgPath" /> 
					</tr>
					<tr id="moImg">
						<th><spring:message code="column.disp_corn_tn_vod_mo" /><strong class="red">*</strong></th>
						<td colspan="3">
						<div id="bnrImgArea" style="float:left;">
								<c:if test="${empty listDisplayCornerBnrVodTagGrid[0].bnrMobileImgPath}">
								<img id="imgPathView2" name="imgPathView2" src="/images/noimage.png" class="thumb" alt="">
								</c:if>
								<c:if test="${not empty listDisplayCornerBnrVodTagGrid[0].bnrMobileImgPath}">
								<img id="imgPathView2" name="imgPathView2" src="<frame:imgUrl/>${listDisplayCornerBnrVodTagGrid[0].bnrMobileImgPath}" class="thumb" alt="">
								</c:if>
							</div>
							<div class="mButton">
								<div class="rightInner">
									<button type="button" onclick="fileUpload.image(resultBnrMobileImg);" class="btn"><spring:message code="column.img_reg_yn" /></button> <!-- 찾기-->
								</div>
							</div>
						</td>
						<input type="hidden" id="bnrMobileImgPath" name="bnrMobileImgPath" />
					</tr>
					</c:if>
					
					<c:if test="${so.dispCornTpCd eq adminConstants.DISP_CORN_TP_130 or so.dispCornTpCd eq adminConstants.DISP_CORN_TP_131}">
					<tr>
						<th><spring:message code="column.tag" /><strong class="red">*</strong></th>
						<td colspan="3">
							<!-- 태그-->
							<div id="tagList">
							</div>
							<div class="mButton">
								<div class="rightInner">
									<button type="button" onclick="tagBaseSearchPop();" class="btn btn-add"> <spring:message code='column.common.addition' /> </button>
								</div>
							</div>
						</td>
					</tr>
					</c:if>
					
					<tr>
					<th scope="row"><spring:message code="column.disp_data" /><strong class="red">*</strong></th>
					<td colspan="3">
						<c:choose>
							<c:when test="${so.dispCornTpCd eq adminConstants.DISP_CORN_TP_71 || so.dispCornTpCd eq adminConstants.DISP_CORN_TP_133}">
								<c:set var="dispStrtdtSet" value="${empty listDisplayCornerVdGrid[0].dispStrtdt ? frame:toDate('yyyy-MM-dd') : listDisplayCornerVdGrid[0].dispStrtdt}"/>
								<c:set var="dispEnddtSet" value="${empty listDisplayCornerVdGrid[0].dispEnddt ? frame:addMonth('yyyy-MM-dd', 1) : listDisplayCornerVdGrid[0].dispEnddt}"/>
							</c:when>
							<c:when test="${so.dispCornTpCd eq adminConstants.DISP_CORN_TP_72}">
								<c:set var="dispStrtdtSet" value="${empty listDisplayCornerBnrVodTagGrid[0].dispStrtdt ? frame:toDate('yyyy-MM-dd') : listDisplayCornerBnrVodTagGrid[0].dispStrtdt}"/>
								<c:set var="dispEnddtSet" value="${empty listDisplayCornerBnrVodTagGrid[0].dispEnddt ? frame:addMonth('yyyy-MM-dd', 1) : listDisplayCornerBnrVodTagGrid[0].dispEnddt}"/>
							</c:when>
							<c:when test="${so.dispCornTpCd eq adminConstants.DISP_CORN_TP_75}">
								<c:set var="dispStrtdtSet" value="${empty listDisplayCornerBannerGrid[0].dispStrtdt ? frame:toDate('yyyy-MM-dd') : listDisplayCornerBannerGrid[0].dispStrtdt}"/>
								<c:set var="dispEnddtSet" value="${empty listDisplayCornerBannerGrid[0].dispEnddt ? frame:addMonth('yyyy-MM-dd', 1) : listDisplayCornerBannerGrid[0].dispEnddt}"/>
							</c:when>
							<c:otherwise>
								<c:set var="dispStrtdtSet" value="${frame:toDate('yyyy-MM-dd')}"/>
								<c:set var="dispEnddtSet" value="${frame:addMonth('yyyy-MM-dd', 1)}"/>
							</c:otherwise>
						</c:choose>
						<!-- 전시 일시--> 
						<frame:datepicker startDate="dispStrtdt" startValue="${dispStrtdtSet}" endDate="dispEnddt" endValue="${dispEnddtSet}" required="Y"/>
							<label class="fCheck" ><input type="checkbox" id="noLimit">
								<span><spring:message code="column.disp_date_no_imit"/></span>
							</label>
					</td>
					</tr>
					<c:if test="${so.dispCornTpCd eq adminConstants.DISP_CORN_TP_75}">
					<tr>
					<th><spring:message code="column.bnr_dscrt" /></th>
						<td colspan="3">
							<textarea class="textarea" name="bnrDscrt" id="bnrDscrt" style="width:350px;height:80px;">${listDisplayCornerBannerGrid[0].bnrTtl }</textarea>
						</td>
					</tr>
					</c:if>
					<c:if test="${so.dispCornTpCd eq adminConstants.DISP_CORN_TP_72}">
					<th><spring:message code="column.ttl" /><strong class="red">*</strong></th>
						<td colspan="3">
							<textarea class="w400 validate[required, maxSize[50]]" name="bnrText" id="bnrText" style="width:350px;height:80px;">${listDisplayCornerBnrVodTagGrid[0].bnrText}</textarea>
						</td>
					</tr>
					<tr>
					<th><spring:message code="column.content" /><strong class="red">*</strong></th>
						<td colspan="3">
							<textarea class="w400 validate[required, maxSize[50]]" name="bnrDscrt" id="bnrDscrt" style="width:350px;height:80px;">${listDisplayCornerBnrVodTagGrid[0].bnrDscrt}</textarea>
						</td>
					</tr>
					<tr>
						<th><spring:message code="column.display_view.bnr_link_url" /><strong class="red">*</strong></th>
						<td colspan="3">
							<input type="text" name="bnrLinkUrl" id="bnrLinkUrl" class="w300 validate[required]" value="${listDisplayCornerBnrVodTagGrid[0].bnrLinkUrl }" />
						</td>
					</tr>
					<tr>
						<th><spring:message code="column.display_view.bnr_mobile_link_url" /><strong class="red">*</strong></th>
						<td colspan="3">
							<input type="text" name="bnrMobileLinkUrl" id="bnrMobileLinkUrl" class="w300 validate[required]" value="${listDisplayCornerBnrVodTagGrid[0].bnrMobileLinkUrl }" />
						</td>
					</tr>
					<tr>
						<th><spring:message code="column.tag" /><strong class="red">*</strong></th>
						<td colspan="3">
							<!-- 태그-->
							<div id="tagList">
							</div>
							<div class="mButton">
								<div class="rightInner">
									<button type="button" onclick="tagBaseSearchPop();" class="btn btn-add"> <spring:message code='column.common.addition' /> </button>
								</div>
							</div>
						</td>
					</tr>
					</c:if>
				</tbody>
			</table>
		</form>