<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
		<script type="text/javascript">
			$(document).ready(function(){
// 				var selOption = $("#dispCornTpCd option:selected").val();

// 				<c:if test="${not empty displayCorner}">
// 					$("#dispCornTpCd").attr("disabled", true);
// 				</c:if>

				// 배너 HTML
				/* if("${adminConstants.DISP_CORN_TP_10}" == selOption) {
					$("#showCnt").val("1");
					$("#showCnt").attr("readonly", true);
				} */
			});

			// 전시 코너 타입 코드 변경
			/* $(document).on("change", "#dispCornTpCd", function(e) {
				var selOption = $("#dispCornTpCd option:selected").val();

				// 배너 HTML
				if("${adminConstants.DISP_CORN_TP_10}" == selOption) {
					$("#showCnt").val("1");
					$("#showCnt").attr("readonly", true);
				} else {
					$("#showCnt").val("");
					$("#showCnt").attr("readonly", false);
				}

			}); */
			
// 			$(document).on("change paste input","#dispCornNm",function(){
//                 var maxLength = 50;
//                 var txt = $(this).val();
//                 $(this).val(txt.substring(0,maxLength));
//             });
			
			// 등록 / 수정
			function displayCornerSave() {
				if(validate.check("displayCornerPopForm")) {
					messager.confirm('<spring:message code="column.display_view.message.confirm_save" />',function(r){
						if(r){
							var url = "<spring:url value='/display/displayCornerSave.do' />";
							var dispCornTpCd = $("#displayCornerPopForm #dispCornTpCd").val();
							if("${adminConstants.DISP_CORN_TP_130}" == dispCornTpCd ||
							   "${adminConstants.DISP_CORN_TP_131}" == dispCornTpCd ||
							   "${adminConstants.DISP_CORN_TP_132}" == dispCornTpCd ||
							   "${adminConstants.DISP_CORN_TP_133}" == dispCornTpCd){	
								url = "<spring:url value='/display/displayCornerAndDisplayClsfCornSave.do' />";
							}
							
							var options = {
								url : url
								, data : $("#displayCornerPopForm").serializeJson()
								, callBack : function(result){
									reloadDisplayCornerGrid();
									if("${adminConstants.DISP_CORN_TP_130}" == dispCornTpCd ||
									   "${adminConstants.DISP_CORN_TP_131}" == dispCornTpCd ||
									   "${adminConstants.DISP_CORN_TP_132}" == dispCornTpCd ||
									   "${adminConstants.DISP_CORN_TP_133}" == dispCornTpCd){	
										reloadDisplayClsfCornerGrid(dispCornTpCd);
									}
									layer.close('displayCornerView');
								}
							};
							ajax.call(options);
						}
					});
				}
			}
			
			function setDispDtm(dispYn) {
				if (dispYn == "Y") {
					$("#dispStrtdt").datepicker('setDate',"${frame:toDate('yyyy-MM-dd')}");
					$("#dispEnddt").datepicker('setDate',"${adminConstants.COMMON_END_DATE}");
				} else {
					$("#dispStrtdt").datepicker('setDate',"${frame:addDay('yyyy-MM-dd',-1)}");
					$("#dispEnddt").datepicker('setDate',"${frame:addDay('yyyy-MM-dd',-1)}");
				}
			}
		
		</script>
			<form name="displayCornerPopForm" id="displayCornerPopForm">
				<input type="hidden" name="dispClsfNo" id="dispClsfNo" value="${displayCornerResult.dispClsfNo}">
				<input type="hidden" name="dispCornNo" id="dispCornNo" value="${displayCornerResult.dispCornNo}">
				<input type="hidden" name="tmplNo" id="tmplNo" value="${displayCornerResult.tmplNo}">
				<input type="hidden" name="dispClsfCornNo" id="dispClsfCornNo" value="${not empty displayClsfCorner ? displayClsfCorner[0].dispClsfCornNo : ''}">
				<input type="hidden" name="orgValue" id="orgValue" value="${displayCornerResult.dispCornTpCd}">
				<!-- <input type="hidden" name="showCnt" id="showCnt" value="1"> -->
				<table class="table_type1 popup">
					<caption>코너 정보</caption>
					<tbody>
						<tr>
							<th><spring:message code="column.display.area.nm"/><strong class="red">*</strong></th>
							<td>
								<!-- 전시 코너명-->
								<input type="text" class="w400 validate[required, maxSize[50]]" name="dispCornNm" id="dispCornNm" title="<spring:message code="column.disp_corn_nm"/>" value="${displayCorner[0].dispCornNm}" />
							</td>
						</tr>
						<tr>
							<th><spring:message code="column.gb_cd"/><strong class="red">*</strong></th>
							<td>
								<!-- 전시 코너 타입 코드-->
								<select name="dispCornTpCd" id="dispCornTpCd" title="<spring:message code="column.disp_corn_tp_cd"/>">
									<frame:select grpCd="${adminConstants.DISP_CORN_TP}" usrDfn1Val="${empty displayClsfCorner ? '' : 'TV'}" selectKey="${displayCorner[0].dispCornTpCd}"/>
								</select>
							</td>
						</tr>
						<c:if test="${not empty displayCorner}">
						<tr>
 							<th><spring:message code="column.disp_yn"/></th>
 							<td>
								<!-- 전시 여부-->
								<frame:radio name="dispYn" grpCd="${adminConstants.COMM_YN}" selectKey="${displayClsfCorner[0].dispEnddt == frame:addDay('yyyy-MM-dd 00:00:00.0',-1) ? adminConstants.DISP_YN_N : adminConstants.DISP_YN_Y }" disabled="${not empty displayClsfCorner ? false : true}" onClickYn="Y" funcNm="setDispDtm(this.value);"/>
							</td>
 						</tr>
 						<tr style="display: none;">
							<th><spring:message code="column.disp_data"/><strong class="red">*</strong></th>
							<td>
								<!-- 전시 기간-->
								<frame:datepicker startDate="dispStrtdt"
												  startValue="${empty displayClsfCorner ? frame:addDay('yyyy-MM-dd',-1) : displayClsfCorner[0].dispStrtdt}"
												  endDate="dispEnddt"
												  endValue="${empty displayClsfCorner ? frame:addDay('yyyy-MM-dd',-1) : displayClsfCorner[0].dispEnddt}"
													/>
							</td>
						</tr>
 						</c:if>
<!--  						<tr> -->
<%--  							<th><spring:message code="column.show_cnt"/><strong class="red">*</strong></th>  --%>
<!--  							<td> -->
<!-- 								노출 개수 -->
<%--  								<input type="text" class="w40 numeric validate[required]" name="showCnt" id="showCnt" title="<spring:message code="column.show_cnt"/>" value="${displayCorner[0].showCnt}" />  --%>
<!--  							</td> -->
<!--  						</tr> -->
						<tr>
							<th><spring:message code="column.display.area.dscrt"/></th>
							<td>
								<!-- 전시 코너 설명-->
								<input type="text" class="w500" name="dispCornDscrt" id="dispCornDscrt" title="<spring:message code="column.disp_corn_dscrt"/>" value="${displayCorner[0].dispCornDscrt}" />
							</td>
						</tr>
					</tbody>
				</table>
			</form>

