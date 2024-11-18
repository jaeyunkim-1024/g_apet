<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>

<!-- 
//@TODO
1. CDN 확정 이후 이미지 path 변경
2. text maxlength 미확정
 -->
<script type="text/javascript">
$(document).ready(function() {
	$("#seasonInsert_dlg-buttons .btn-cancel").html("취소");
});

$(document).on("keyup input", "#sesnNm, #sesnDscrt", function(e) {
	/* if($(this).attr("id") == "sesnNm"){
		$(this).val($(this).val().replace("#",""));
	} */
	var inputLength = $(this).val().length;
	var maxLength = $(this).attr("maxlength");
	var obj = $(this).parent("td").find("span .txtCnt");
	
	var cnt = 0;
	for(var i = 0; i<inputLength; i++){
		cnt += 1;
	}
	obj.html(cnt);				
	if (cnt > maxLength) {
		$(this).val($(this).val().substring(0,maxLength));
		obj.html(maxLength);
	}	
});
</script>

<form id="seasonDetailForm" name="seasonDetailForm" method="post" >
	<input type = "hidden" name = "flNo" 	id="flNo"  		value="${SeriesVO.flNo}" />
	<div class="panel-title"><spring:message code="column.sesn_reg_mod" /></div>
	<table class="table_type1">
		<caption>시즌 등록/수정 </caption>
		<colgroup>
			<col style="width:20%;">							
			<col style="width:65%;">
			<col style="width:15%;">						
		</colgroup>
		<tbody>
			<tr>
				<th scope="row"><spring:message code="column.sesn_nm" /><strong class="red">*</strong></th> <!-- 시즌명 -->
				<td colspan="2">
					<input type = "text" class = "noHash w400" id = "sesnNm" name = "sesnNm" maxlength = "10" value="${fn:escapeXml(SeriesVO.sesnNm) }" title = "<spring:message code="column.sesn_nm" />"/>&nbsp;&nbsp;
					<span>
						<span class = "txtCnt" style ="color:#0066CC"><c:out value="${fn:length(SeriesVO.sesnNm)}" /></span> / 10자
					</span>
					<input type = "hidden" id = "sesnNo" name = "sesnNo"  value = "${SeriesVO.sesnNo }"/>
				</td>				
			</tr>
			<tr>	
				<th scope="row"><spring:message code="column.sesn_img" /><strong class="red">*</strong></th> <!-- 시즌이미지 -->		
				<c:choose>
					<c:when test="${!empty SeriesVO.sesnNo }">
						<td colspan = "2">							
							<input type = "hidden" id = "sesnImgPath" value = "${SeriesVO.sesnImgPath}"/>		
							<c:set var="sesnImgPt" value="${frame:optImagePath(SeriesVO.sesnImgPath,adminConstants.IMG_OPT_QRY_420)}" />
							<c:if test="${fn:indexOf(SeriesVO.sesnImgPath, 'cdn.ntruss.com') > -1 }" >
							<c:set var="sesnImgPt" value="${SeriesVO.sesnImgPath}" />
							</c:if>
							<img id="sesnImgPathView" name="sesnImgPathView" src="${sesnImgPt }" onError="this.src='/images/noimage.png';"  class="thumb" alt="" style = "float:left"/>							
							<div style = "float:left;padding:10px">
								<div id = "sesn_img_file_list" title = "<spring:message code="column.sesn_img" />" >
									<c:forEach items="${attachList}" var="item">										
										<c:if test = "${item.contsTpCd eq  '20'}" >
											<li id='fileArea_sesnImg'>
												<%-- <span class='file' id='file_name_sesnImg'>${item.orgFlNm }</span> --%>
												<span id='file_name_sesnImg' onclick="vodFileNcpDownload('${SeriesVO.sesnImgPath}', '${item.orgFlNm}');" style="color: #0066CC;text-decoration: underline;font-size: 12px;cursor: pointer;">${item.orgFlNm }</span>
												<%-- <span class='bytes' id='file_bytes_sesnImg'>${item.flSz/1024-(item.flSz/1024%1) }KB</span>
												<a href='#' class='btn_delete' onclick='deleteImage("sesnImg"); return false;'>삭제</a> --%>
												<input type='hidden' name='phyPaths' id='phyPath_sesnImg' title='<spring:message code='column.phy_path'/>' value='${item.phyPath }'>
												<input type='hidden' name='flSzs' id='flSz_sesnImg' title='<spring:message code='column.fl_sz'/>' value='${item.flSz }'>
												<input type='hidden' name='orgFlNms' id='orgFlNm_sesnImg' title='<spring:message code='column.org_fl_nm'/>' value='${item.orgFlNm }' />
												<input type='hidden' name='imgGbs' id='imgGbs_sesnImg' title='<spring:message code='column.org_fl_nm'/>' value='sesnImg' />
												<input type='hidden' name='flModYns' id='flModYns_sesnImg'  value='N' />
											</li>
										</c:if>
									</c:forEach>
								</div>
								<button type="button" class="btn" onclick="javascript:changeImgGb('sesnImg');imageUploadPrfl();" style = "margin-top:5px;" >
									<spring:message code="column.chg_file" />
								</button> <!-- 추가 -->
								<button type="button" class="btn" onclick="deleteImage('sesnImg'); return false;" style = "margin-top:5px;" >
									<spring:message code="column.common.delete" />
								</button>
							</div>
						</td>
					</c:when>
					<c:otherwise>
						<td colspan = "2">
							<img id="sesnImgPathView" name="sesnImgPathView" src="/images/noimage.png" class="thumb" alt="" style = "display:none;float:left"/>
							<div style = "float:left;padding:10px">
								<div id = "sesn_img_file_list" title = "<spring:message code="column.sesn_img" />"></div>									
								<button type="button" class="btn" onclick="javascript:changeImgGb('sesnImg');imageUploadPrfl();" >
									<spring:message code="column.choose_file" />
								</button> <!-- 추가 -->
							</div>
						</td>
					</c:otherwise>
				</c:choose>
			</tr>	
			<tr> 
				<th scope="row"><spring:message code="column.sesn_dscrt" /><strong class="red">*</strong></th> <!-- 시즌설명 -->
				<td colspan="2">
					<textarea class="textarea" id="sesnDscrt" name="sesnDscrt" title="<spring:message code="column.sesn_dscrt" />" style="width:400px;height:110px;" maxlength="200">${SeriesVO.sesnDscrt}</textarea>&nbsp;&nbsp;&nbsp;
					<% pageContext.setAttribute("newLineChar", "\n"); %>
					<span style = "vertical-align: bottom;">
						<span class = "txtCnt" style ="color:#0066CC"><c:out value="${fn:length(fn:replace(SeriesVO.sesnDscrt, newLineChar, ''))}" /></span> / 200자
					</span>
				</td>				
			</tr>
			</tr>	
				<th scope="row"><spring:message code="column.disp_yn" /><strong class="red">*</strong></th> <!-- 전시여부 -->							
				<td colspan="2">
					<frame:radio  name="dispYn" grpCd="${adminConstants.DISP_STAT }" selectKey="${SeriesVO.dispYn }" />
				</td>							
			</tr>
		
		</tbody>
	</table>
</form>