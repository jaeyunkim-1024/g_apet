<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>

<script type="text/javascript">
	var noImageUrl = "/images/noimage.png";

	$(document).ready(function() {
		$("#seoSvcGbCd option").each(function() {
            if ($(this).val() == '${seoParam.seoSvcGbCd}') {
                $(this).attr('selected', true);
                $("#seoSvcGbCd").attr('disabled', true);
            }
        });
		
		if ($("#seoTpCd option").length > 0) {
			$("#seoTpCd option[value='10']").remove();
		}
	   
		$("#seoTpCd option").each(function() {
            if ($(this).val() == '${seoParam.seoTpCd}') {
                $(this).attr('selected', true);
                $("#seoTpCd").attr('disabled', true);
            }
        });
	});

	function updateSeoInfoPopup() {
		if (validate.check("popupUpdateForm")) {

			var options = {
				url: "<spring:url value="/display/saveSeoInfo.do" />"
				, data: $("#popupUpdateForm").serializeJson()
				, callBack: function (result) {
					messager.alert("<spring:message code="column.display_view.message.save" />", "Info", "info", function () {
						callBackSaveSeoInfo(result.seoInfoNo);
						layer.close("seoInfoDetail");
					});
				}
			};
			ajax.call(options);
		}
	}

	function resultGraphImage(result) {
		var resultImg = result.filePath;
		$("#openGraphImg").val(resultImg);
		// $("#openGraphImgNm").val(result.fileName);
		var imgSrc = $("#openGraphImgView").attr('src');
		if (imgSrc != null && imgSrc != undefined && imgSrc != "") {
			$("#openGraphImgView").attr('src', '/common/imageView.do?filePath=' + result.filePath);
			$("#openGraphImgView").attr('alt', result.fileName);
			$("#openGraphImgView").closest('td').append('&nbsp;<button type="button" class="btn" onclick="deleteGraphImage();">삭제</button>');
		}
	}

	function deleteGraphImage() {
		$("#openGraphImg").val('');
		// $("#openGraphImgNm").val('');
		$("#openGraphImgView").attr('src', noImageUrl);
		$("#openGraphImgView").attr('alt', '');
	}

	function fnResetSeoForm(seoTpCd, seoSvcGbCd){
		resetForm("popupUpdateForm");
		$("#popupUpdateForm").find("input").val("");
		$("#seoInfoNo").next().text("자동입력");
		$("#popupUpdateForm").find("option").prop("selected",false);
		$("#seoInfoDetail_dlg-buttons").find(".btn-add").text("등록");
		
		if(seoTpCd != undefined && seoSvcGbCd != undefined){
			$('#seoSvcGbCd').val(seoSvcGbCd).prop("selected",true);
			$('#seoTpCd').val(seoTpCd).prop("selected",true);
		}
	}
</script>

<form id="popupUpdateForm" name="popupUpdateForm" method="post" >
	<div>SEO 설정</div>
	<br>
	<table class="table_type1">
		<caption>POPUP 조회</caption>
		<tbody>
			<tr>
				<th><spring:message code="column.display.seo_info.no" /><strong class="red">*</strong></th>	<!-- 번호 -->
				<td colspan="3"><input type="hidden" class="readonly" readonly="readonly" name="seoInfoNo" id="seoInfoNo" title="<spring:message code="column.display.disp_clsf.seo_info_no" />" value="${seoInfo.seoInfoNo}" />
					<c:if test="${empty seoInfo.seoInfoNo}">
						<b>자동입력</b>
					</c:if>
					<c:if test="${not empty seoInfo.seoInfoNo}">
						<b>${seoInfo.seoInfoNo}</b>
					</c:if>
				</td>
			</tr>
			<tr>
				<th><spring:message code="column.display.seo_info.svc_gb_cd" /><strong class="red">*</strong></th>	<!-- 사이트 구분 -->
				<td>
					<select name="seoSvcGbCd" id="seoSvcGbCd" class="validate[required]">
					<c:choose>
						<c:when test="${empty seoExhibiCd}">
							<frame:select grpCd="${adminConstants.SEO_SVC_GB_CD}" selectKey="${seoInfo.seoSvcGbCd}" useYn="Y"/>
						</c:when>
						<c:otherwise>
							<frame:select grpCd="${adminConstants.SEO_SVC_GB_CD}" selectKey="${seoInfo.seoSvcGbCd}" useYn="Y" excludeOption="50"/>
						</c:otherwise>
					</c:choose>
					</select>
				</td>
				<th><spring:message code="column.display.seo_info.seo_tp_cd" /><strong class="red">*</strong></th>    <!-- SEO 유형코드 -->
				<td>
					<select name="seoTpCd" id="seoTpCd" class="validate[required]">
					<c:choose>
						<c:when test="${empty seoExhibiCd}">
							<frame:select grpCd="${adminConstants.SEO_TP}" selectKey="${seoInfo.seoTpCd}"/>
						</c:when>
						<c:otherwise>
							<frame:select grpCd="${adminConstants.SEO_TP}" selectKey="${seoInfo.seoTpCd}" excludeOption="${adminConstants.SEO_TP_99}"/>
						</c:otherwise>
					</c:choose>
					</select>
				</td>
			</tr>
			<tr>
				<th><spring:message code="column.display.seo.info_page_ttl" /><strong class="red">*</strong></th>	<!-- 페이지 제목 -->
				<td>
					<input class="w200 validate[required]" type="text" id="pageTtl" name="pageTtl" value="${seoInfo.pageTtl}" placeholder="한글기준 10자 이내로 작성 권장" />
				</td>
				<th><spring:message code="column.display.seo.info_page_author" /><strong class="red">*</strong></th>    <!--페이지 저자 -->
				<td>
					<input type="text" class="w200 validate[required]" name="pageAthr" id="pageAthr" title="<spring:message code="column.display.seo.info_page_author" />" value="${seoInfo.pageAthr}" placeholder="페이지 또는 사이트의 제작자명" /></td>
				</td>
			</tr>
			<tr>
				<th><spring:message code="column.display.seo.info_page_dscrt" /><strong class="red">*</strong></th>    <!-- 페이지 설명 -->
				<td colspan="3">
					<input class="w525 validate[required]" type="text" id="pageDscrt" name="pageDscrt" value="${seoInfo.pageDscrt}" placeholder="한글기준 공백포함 최대 80자 작성 권장" />
				</td>
			</tr>
			<tr>
				<th><spring:message code="column.display.seo.info_page_kwd" /></th>	<!-- 페이지 키워드 -->
				<td colspan="3">
					<input type="text" class="w525" id="pageKwd" name="pageKwd" value="${seoInfo.pageKwd}" placeholder="단어를 쉼표','로 분리하여 작성할 수 있으며, 10개 이내로 입력 권장" />
				</td>
			</tr>
		</tbody>
	</table>

	<br>
	<div>오픈그래프/트위터 메타태그 기본설정</div>
	<br>

	<table class="table_type1">
		<tbody>
			<tr>
				<th><spring:message code="column.display.seo.info_open_graph_img"/></th>  <!-- open_graph 이미지 -->
				<td>
					<input type="hidden" name="openGraphImg" id="openGraphImg" value="${seoInfo.openGraphImg}">
					<input type="hidden" name="openGraphImgPath" id="openGraphImgPath" >
					<c:if test="${empty seoInfo.openGraphImg}">
						<img id="openGraphImgView" name="openGraphImgView" src="/images/noimage.png" width="70" height="70"  class="thumb" alt="">
					</c:if>
					<c:if test="${not empty seoInfo.openGraphImg}">
						<img id="openGraphImgView" name="openGraphImgView" src="<frame:imgUrl/>${seoInfo.openGraphImg}" width="70" height="70"  class="thumb" alt="">
					</c:if>
					<a href="javascript:fileUpload.image(resultGraphImage);" class="btn">파일 업로드</a>
				</td>
				<th><spring:message code="column.display.seo.info_open_graph_ttl"/></th>  <!-- OPEN GRAPH 제목 -->
				<td>
					<input type="text" class="w200" id="openGraphTtl" name="openGraphTtl" value="${seoInfo.openGraphTtl}" placeholder="한글기준 10자 이내로 작성 권장" />
				</td>
			</tr>
			<tr>
				<th><spring:message code="column.display.seo.info_open_graph_dscrt"/></th>  <!-- OPEN GRAPH 설명 -->
				<td colspan="3">
					<input class="w400" type="text" id="openGraphDscrt" name="openGraphDscrt" value="${seoInfo.openGraphDscrt}" placeholder="한글기준 공백포함 최대 80자 작성 권장" />
				</td>
			</tr>
		</tbody>
	</table>

	<br>
	<div>기타 설정</div>
	<br>

	<table class="table_type1">
		<tbody>
			<tr>
				<th><spring:message code="column.display.seo_info.redirect_url"/></th>  <!-- redirect_url -->
				<td colspan="3">
					<input type="text" class="w400" id="redirectUrl" name="redirectUrl" value="${seoInfo.redirectUrl}" />
				</td>
			</tr>
			<tr>
				<th><spring:message code="column.display.seo_info.canonical_url"/></th>  <!-- canonical_url -->
				<td colspan="3">
					<input type="text" class="w400" id="canonicalUrl" name="canonicalUrl" value="${seoInfo.canonicalUrl}" />
				</td>
			</tr>
		</tbody>
	</table>

</form>