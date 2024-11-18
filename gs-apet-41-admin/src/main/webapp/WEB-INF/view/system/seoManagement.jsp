<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>

<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">
			$(document).ready(function() {
				$("#seoTpCd").append('<frame:select grpCd="${adminConstants.SEO_TP}" useYn="Y" usrDfn1Val="Y" />');
				getSeoInfo();
			});
			
			var seoInfoNo;
			
			//초기화
			function reset() {
				$("#pageTtl").val("");
				$("#pageDscrt").val("");
				$("#pageKwd").val("");
				$("#pageAthr").val("");
				$("#canonicalUrl").val("");
				$("#redirectUrl").val("");
				$("#openGraphDscrt").val("");
				$("#openGraphImg").val("");
				$("#openGraphTtl").val("");
			}
			
			//사이트 변경
			$(document).on("change", "input[name=seoSvcGbCd]", function(e) {
				var selectVal = $(this).val();
				
				if(selectVal == "${adminConstants.SEO_SVC_GB_CD_10}") {	//펫샵
					$("#seoTpCd option").remove();
					$("#seoTpCd").append('<frame:select grpCd="${adminConstants.SEO_TP}" selectKey="${adminConstants.SEO_TP }" useYn="Y" usrDfn1Val="Y" />');
					getSeoInfo();
				} else if(selectVal == "${adminConstants.SEO_SVC_GB_CD_20}") {	//펫 TV
					$("#seoTpCd option").remove();
					$("#seoTpCd").append('<frame:select grpCd="${adminConstants.SEO_TP}" selectKey="${adminConstants.SEO_TP }" useYn="Y" usrDfn2Val="Y" />');
					getSeoInfo();
				} else {	//펫로그
					$("#seoTpCd option").remove();
					$("#seoTpCd").append('<frame:select grpCd="${adminConstants.SEO_TP}" selectKey="${adminConstants.SEO_TP }" useYn="Y" usrDfn3Val="Y" />');
					getSeoInfo();
				}
			});
			
			function getSeoInfo() {
				var seoTpCd = $("#seoTpCd option:selected").val();
				var seoSvcGbCd = $("input[name='seoSvcGbCd']:checked").val();
				
				var options = {
						url : "<spring:url value = '/system/getSeoInfo.do' />"
						, data : {
							seoTpCd : seoTpCd
							, seoSvcGbCd : seoSvcGbCd
						}
						, callBack : function(result) {
							if(result.getSeoInfo != null && result.seoInfoNo != '') {
								$(".btn-add").hide();
								$(".btn-ok").show();
								$("#seoInfoNo").val(result.getSeoInfo.seoInfoNo);
								seoInfoNo = result.getSeoInfo.seoInfoNo;
								$("#pageTtl").val(result.getSeoInfo.pageTtl);
								$("#canonicalUrl").val(result.getSeoInfo.canonicalUrl);
								$("#redirectUrl").val(result.getSeoInfo.redirectUrl);
								$("#openGraphImg").val(result.getSeoInfo.openGraphImg);
								$("#pageDscrt").val(result.getSeoInfo.pageDscrt);
								$("#pageKwd").val(result.getSeoInfo.pageKwd);
								$("#pageAthr").val(result.getSeoInfo.pageAthr);
								$("#openGraphTtl").val(result.getSeoInfo.openGraphTtl);
								$("#openGraphDscrt").val(result.getSeoInfo.openGraphDscrt);
							} else {
								$(".btn-add").show();
								$(".btn-ok").hide();
								$("#seoInfoNo").val("");
								$("#pageTtl").val("");
								$("#canonicalUrl").val("");
								$("#redirectUrl").val("");
								$("#openGraphImg").val("");
								$("#pageDscrt").val("");
								$("#pageKwd").val("");
								$("#pageAthr").val("");
								$("#openGraphTtl").val("");
								$("#openGraphDscrt").val("");
							}
						}
				};
				ajax.call(options);
			}

			//대표 이미지
			function resultSeoImage(result) {
				$("#openGraphImg").val(result.filePath);
			}
			
			//등록
			function saveSeoInfo() {
				if(validate.check("seoForm")) {
					messager.confirm('<spring:message code="column.display.seo_info.open_confirm_save" />', function(r) {
						if(r) {
							var options = {
								url : "<spring:url value='/system/saveSeoInfo.do' />"
								, data : $("#seoForm").serializeJson()
								, callBack : function(result) {
									console.log(result);
									messager.alert('<spring:message code="column.display.seo.info.open_success" />', "info", "info", function() {
										updateTab('/system/seoManagement.do', "SEO 기본 관리");
									});
								}
							};
							ajax.call(options);
						}
					});
				}
			}
		</script>
	</t:putAttribute>
	<t:putAttribute name="content">
	<form name="seoForm" id="seoForm" method="post">
			<input type="hidden" id="dftSetYn" name="dftSetYn" value="Y" />
			<input type="hidden" id="seoInfoNo" name="seoInfoNo" />
			<div class="mTitle">
				<h2>주요 페이지 SEO 설정</h2>
			</div>
			<table class="table_type1">
				<caption>주요 페이지 SEO 설정</caption>
				<tbody>
					<tr>
						<th><spring:message code="column.svc_gb_cd" /></th>
						<td colspan="2">
							<!-- 서비스 구분--> 
							<frame:radio name="seoSvcGbCd" grpCd="${adminConstants.SEO_SVC_GB_CD }" selectKey="${adminConstants.SEO_SVC_GB_CD_10 }" useYn="Y" />
						</td>
						<th><spring:message code="column.display.seo.info_seo_tp" /><strong class="red">*</strong></th>
						<td colspan="2">
							<!-- SEO 유형-->
							<select class="wth100" name="seoTpCd" id="seoTpCd" onchange="getSeoInfo()"; title="<spring:message code="column.display.seo.info_seo_tp"/>">
								
							</select>
						</td>
					</tr>
					<tr>
						<th><spring:message code="column.display.seo.info_page_ttl" /><strong class="red">*</strong></th>
						<td colspan="2">
							<!-- 서비스 구분--> 
							<input type="text" class="w200 validate[required]" name="pageTtl" id="pageTtl" placeholder="한글기준  10자 이내로 작성 권장" />
						</td>
						<th><spring:message code="column.display.seo.info_page_author" /><strong class="red">*</strong></th>
						<td colspan="2">
							<!-- SEO 유형-->
							<input type="text" class="w200 validate[required]" name="pageAthr" id="pageAthr" placeholder="페이지 또는 사이트의 제작자명" />
						</td>
					</tr>
					<tr>
						<th><spring:message code="column.display.seo.info_page_dscrt" /><strong class="red">*</strong></th>
						<td colspan="5">
							<!-- 서비스 구분-->
							<input type="text" class="w800 validate[required]" name="pageDscrt" id="pageDscrt" placeholder="한글기준 공백포함 최대 80자 작성 권장" /> 
						</td>
					</tr>
					<tr>
						<th><spring:message code="column.display.seo.info_page_kwd" /><strong class="red">*</strong></th>
						<td colspan="5">
							<!-- 서비스 구분-->
							<input type="text" class="w800 validate[required]" name="pageKwd" id="pageKwd" placeholder="단어를 쉼표 ',' 로 분리하여 작성할 수 있으며, 10개 이내로 입력 권장" /> 
						</td>
					</tr>
				</tbody>
			</table>
			
			<div class="mTitle mt30">
				<h2>오픈그래프/트위터 메타태그 기본 설정</h2>
			</div>
			<table class="table_type1">
				<caption>오픈그래프/트위터 메타태그 기본 설정</caption>
				<tbody>
					<tr>
						<th><spring:message code="column.display.seo.info_open_graph_img" /><strong class="red">*</strong></th>
						<td>
							<!-- 서비스 구분-->
							<input type="text" name="openGraphImg" id="openGraphImg" class="readonly validate[required]" readonly="readonly"/>
							<button type="button" onclick="fileUpload.image(resultSeoImage);" class="btn">찾아보기</button>
						</td>
						<th><spring:message code="column.display.seo.info_open_graph_ttl" /><strong class="red">*</strong></th>
						<td>
							<!-- SEO 유형-->
							<input type="text" name="openGraphTtl" id="openGraphTtl" class="w200 validate[required]" placeholder="한글기준 10자 이내로 작성 권장" />
						</td>
					</tr>
					<tr>
						<th><spring:message code="column.display.seo.info_open_graph_dscrt" /><strong class="red">*</strong></th>
						<td colspan="3">
							<!-- 서비스 구분-->
							<input type="text" name="openGraphDscrt" class="w800 validate[required]" id="openGraphDscrt" placeholder="한글기준 공백포함 최대 80자 작성 권장" />
						</td>
					</tr>
				</tbody>
			</table>
			
			<div class="mTitle mt30">
				<h2>기타 설정</h2>
			</div>
			<table class="table_type1">
				<caption>기타 설정</caption>
				<tbody>
					<tr>
					<th><spring:message code="column.display.seo_info.redirect_url" /></th>
						<td>
							<!-- 서비스 구분-->
							<input type="text" class="w800" name="redirectUrl" id="redirectUrl"  /> 
						</td>
					</tr>
					<tr>
					<th><spring:message code="column.display.seo_info.canonical_url" /></th>
						<td>
							<!-- 서비스 구분-->
							<input type="text" class="w800" name="canonicalUrl" id="canonicalUrl"  /> 
						</td>
					</tr>
				</tbody>
			</table>
		</form>
		
		<div class="btn_area_center">
				<button type="button" onclick="saveSeoInfo();" class="btn btn-add" style="display:none;">등록</button>
				<button type="button" onclick="saveSeoInfo();" class="btn btn-ok" style="display:none;">수정</button>
				<button type="button" onclick="reset();" class="btn btn-cancel">초기화</button>
		</div>
	</t:putAttribute>

</t:insertDefinition>