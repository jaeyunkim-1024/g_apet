<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
		<script type="text/javascript">
			$(document).ready(function() {
				$("input[name=dispPrdSetYn]").change(function() {
					var dispPrdSetYn = $(this).val();
					if (dispPrdSetYn == 'N') {
						$("#dispClsfCornerEnddt").datepicker('setDate',"${adminConstants.COMMON_END_DATE}");
					} else {
						var dispEnddt = new Date("${empty displayClsfCornerList[0].dispEnddt ? frame:addMonth('yyyy-MM-dd', 1) : displayClsfCornerList[0].dispPrdSetYn eq 'N' ? frame:addMonth('yyyy-MM-dd', 1) : displayClsfCornerList[0].dispEnddt}").format("yyyy-MM-dd");
						$("#dispClsfCornerEnddt").val(dispEnddt);
					}
				});
			});

			// 등록 / 수정
			function insertdisplayClsfCorner() {
				var dispStrtDtm = $("#displayClsfCornerPopForm #dispClsfCornerStrtdt").val().replace(/-/gi, "");
				var dispEndDtm = $("#displayClsfCornerPopForm #dispClsfCornerEnddt").val().replace(/-/gi, "");
				var diffMonths = getDiffMonths(dispStrtDtm, dispEndDtm);
				
				if(parseInt(dispStrtDtm) > parseInt(dispEndDtm)){
					messager.alert("등록일 검색기간 시작일은 종료일과 같거나 이전이여야 합니다.", "Info", "info");
					return;
				}
				
				if(validate.check("displayClsfCornerPopForm")) {
					if($("#displayClsfCornerPopForm #dispClsfCornNo").val() == '') {
						var rowids = $("#displayClsfCornerList").jqGrid('getDataIDs');
						for(var i = 0; i < rowids.length; i++) {
							var rowdata = $("#displayClsfCornerList").getRowData(rowids[i]);
							
							if($("#displayClsfCornerPopForm #dispClsfCornerStrtdt").val() <= rowdata.dispEnddt && $("#displayClsfCornerPopForm #dispClsfCornerEnddt").val() >= rowdata.dispStrtdt) {
								messager.alert("<spring:message code='column.display_view.disp_date_overlap' />", "Info", "info");
								return;
							}
						}
					} else {
						var rowids = $("#displayClsfCornerList").jqGrid('getDataIDs');
						for(var i = 0; i < rowids.length; i++) {
							var rowdata = $("#displayClsfCornerList").getRowData(rowids[i]);
							if("${displayClsfCorner.dispClsfCornNo}" != rowdata.dispClsfCornNo) {
								if($("#displayClsfCornerPopForm #dispClsfCornerStrtdt").val() <= rowdata.dispEnddt && $("#displayClsfCornerPopForm #dispClsfCornerEnddt").val() >= rowdata.dispStrtdt ) {
									messager.alert("<spring:message code='column.display_view.disp_date_overlap' />", "Info", "info");
									return;
								}
							}
						}
					}
					messager.confirm("<spring:message code='column.display_view.message.confirm_save' />",function(r){
						if(r){
							var options = {
									url : "<spring:url value='/display/displayClsfCornerSave.do' />"
									, data : $("#displayClsfCornerPopForm").serializeJson()
									, callBack : function(result){
										reloadDisplayClsfCornerGrid();
										layer.close('displayClsfCornerView');
									}
								};

								ajax.call(options);				
						}
					});
				}
			}

			// 이미지(PC) 파일 업로드
			function resultCornImage(result) {
				$("#cornImgPath").val(result.filePath);
				$("#cornImgNm").val(result.fileName);
			}

			// 이미지(MOBILE) 파일 업로드
			function resultCornMobileImage(result) {
				$("#cornMobileImgPath").val(result.filePath);
				$("#cornMobileImgNm").val(result.fileName);
			}
		</script>
			<form name="displayClsfCornerPopForm" id="displayClsfCornerPopForm">
				<input type="hidden" name="dispClsfCornNo" id="dispClsfCornNo" value="${displayClsfCorner.dispClsfCornNo}">
				<input type="hidden" name="dispClsfNo" id="dispClsfNo" value="${displayClsfCorner.dispClsfNo}">
				<input type="hidden" name="dispCornNo" id="dispCornNo" value="${displayClsfCorner.dispCornNo}">
				<input type="hidden" name="dispCornTpCd" id="dispCornTpCd" value="${displayClsfCorner.dispCornTpCd}">
				<input type="hidden" name="dispShowTpCd" id="dispShowTpCd" value="${adminConstants.DISP_SHOW_TP_10 }" />
				<c:if test="${displayClsfCorner.dispCornTpCd eq adminConstants.DISP_CORN_TP_60}" >
				<input type="hidden" name="goodsAutoYn" id="goodsAutoYn" value="${adminConstants.COMM_YN_Y }" />
				</c:if>

				<table class="table_type1">
					<caption>전시 분류 코너 정보</caption>
					<colgroup>
						<col class="th-s" />
						<col />
						<col class="th-s" />
						<col />
					</colgroup>
					<tbody>
						<%-- <c:if test="${frame:listCode2(adminConstants.DISP_SHOW_TP, displayClsfCorner.dispCornTpCd, null, null, null, null ).size() > 0}">
							<tr>
								<th><spring:message code="column.disp_show_tp_cd" /><strong class="red">*</strong></th>	<!-- 전시 노출 타입-->
								<td colspan="3">						
									<select class="validate[required]" name="dispShowTpCd" id="dispShowTpCd" title="<spring:message code="column.disp_show_tp_cd" />" >
										<frame:select grpCd="${adminConstants.DISP_SHOW_TP }" selectKey="${displayClsfCornerList[0].dispShowTpCd eq null ? displayClsfCorner.dispShowTpCd : displayClsfCornerList[0].dispShowTpCd }" usrDfn1Val="${displayClsfCorner.dispCornTpCd}" />
									</select>
								</td>
							</tr>
						</c:if> --%>
						<tr>
							<th scope="row"><spring:message code="column.disp_prd_set_yn" /><strong class="red">*</strong></th>	<!-- 전시 기간 설정 여부 -->
							<td colspan="3">
								<frame:radio name="dispPrdSetYn" grpCd="${adminConstants.COMM_YN }" selectKey="${displayClsfCornerList[0].dispPrdSetYn }" />
							</td>
						</tr>
						<tr>
							<th><spring:message code="column.display_view.disp_date"/><strong class="red">*</strong></th>
							<td colspan="3">
								<!-- 전시 기간-->
								<frame:datepicker startDate="dispClsfCornerStrtdt"
												  startValue="${empty displayClsfCornerList[0].dispStrtdt ? frame:toDate('yyyy-MM-dd') : displayClsfCornerList[0].dispStrtdt}"
												  endDate="dispClsfCornerEnddt"
												  endValue="${empty displayClsfCornerList[0].dispEnddt ? frame:addMonth('yyyy-MM-dd', 1) : displayClsfCornerList[0].dispEnddt}"
												  />	
							</td>
						</tr>
                        <!-- 전시 분류 코너 (상품) 인 경우 -->
                        <%-- <c:if test="${displayClsfCorner.dispCornTpCd eq adminConstants.DISP_CORN_TP_60}">						
					    <tr>
	                        <th><spring:message code="column.display_view.bg_color"/></th>
	                        <td colspan="3">
	                            <!-- BG 컬러 -->
	                            <input type="text" class="w100" name="bgColor" id="bgColor" title="<spring:message code="column.display_view.bg_color"/>" value="${displayClsfCornerList[0].bgColor}" />
	                        </td>
	                    </tr>
	                    <tr>
							<th scope="row"><spring:message code="column.goods_auto_yn" /></th>	<!-- 상품 자동 여부 -->
							<td colspan="3">
								<frame:radio name="goodsAutoYn" grpCd="${adminConstants.COMM_YN }" selectKey="${displayClsfCornerList[0].goodsAutoYn }" />
							</td>
						</tr>
                        </c:if>    --%>
						<!-- 전시 분류 코너 (테마) 인 경우 -->
						<c:if test="${displayClsfCorner.dispCornTpCd eq adminConstants.DISP_CORN_TP_81}">
							<tr>
								<th><spring:message code="column.ttl"/><strong class="red">*</strong></th> <!-- 콘텐츠 타이틀 -->
								<td colspan="3">
									<input type="text" class="w300 validate[required]" name="cntsTtl" id="cntsTtl" title="<spring:message code="column.ttl"/>" value="${displayClsfCornerList[0].cntsTtl}" />
								</td>
							</tr>
							<tr>
								<th><spring:message code="column.dscrt" /></th> <!-- 콘텐츠 설명-->
								<td colspan="3">
									<textarea name="cntsDscrt" id="cntsDscrt" title="<spring:message code="column.dscrt"/>" rows="3" cols="70">${displayClsfCornerList[0].cntsDscrt }</textarea>
								</td>
							</tr>
							<tr>
								<th><spring:message code="column.display_view.pc_img"/><strong class="red">*</strong></th>
								<td colspan="3">
									<!-- 이미지(PC) -->
									<input type="text" class="w300 readonly validate[required]" readonly="readonly" name="cornImgNm" id="cornImgNm" title="<spring:message code="column.display_view.pc_img"/>" value="${displayClsfCornerList[0].cornImgNm}" />
									<input type="hidden" name="cornImgPath" id="cornImgPath" title="<spring:message code="column.corn_img_path"/>" value="${displayClsfCornerList[0].cornImgPath}" />
									<button type="button" onclick="fileUpload.image(resultCornImage);" class="btn">파일찾기</button>
								</td>
							</tr>
							<tr>
								<th><spring:message code="column.display_view.mobile_img"/><strong class="red">*</strong></th>
								<td colspan="3">
									<!-- 이미지(MOBILE) -->
									<input type="text" class="w300 readonly validate[required]" readonly="readonly" name="cornMobileImgNm" id="cornMobileImgNm" title="<spring:message code="column.display_view.mobile_img"/>" value="${displayClsfCornerList[0].cornMobileImgNm}" />
									<input type="hidden" name="cornMobileImgPath" id="cornMobileImgPath" title="<spring:message code="column.corn_mobile_img_path"/>" value="${displayClsfCornerList[0].cornMobileImgPath}" />
									<button type="button" onclick="fileUpload.image(resultCornMobileImage);" class="btn">파일찾기</button>
								</td>
							</tr>
                            <tr>
                                <th><spring:message code="column.display_view.pc_link"/></th>
                                <td colspan="3">
                                    <!-- PC 링크 -->
                                    <input type="text" class="w300" name="linkUrl" id="linkUrl" title="<spring:message code="column.display_view.pc_link"/>" value="${displayClsfCornerList[0].linkUrl}" />
                                </td>
                            </tr>
						    <tr>
                                <th><spring:message code="column.display_view.mobile_link"/></th>
                                <td colspan="3">
                                    <!-- 모바일 링크 -->
                                    <input type="text" class="w300" name="mobileLinkUrl" id="mobileLinkUrl" title="<spring:message code="column.display_view.mobile_link"/>" value="${displayClsfCornerList[0].mobileLinkUrl}" />
                                </td>
                            </tr>
                            <tr>
                                <th><spring:message code="column.display_view.bg_color"/></th>
                                <td colspan="3">
                                    <!-- BG 컬러 -->
                                    <input type="text" class="w100" name="bgColor" id="bgColor" title="<spring:message code="column.display_view.bg_color"/>" value="${displayClsfCornerList[0].bgColor}" />
                                </td>
                            </tr>                            
						</c:if>
					</tbody>
				</table>
			</form>

