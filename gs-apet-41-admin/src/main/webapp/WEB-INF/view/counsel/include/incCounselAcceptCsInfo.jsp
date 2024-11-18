<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>

					<form id="counselCsInfoForm">
						<input type="hidden" name="mbrNo" id="counselCsInfoMbrNo" value="" />
						<input type="hidden" name="noSearch" id="counselCsInfoNoSearch" value="Y" />
						
						<input type="hidden" name="stId" id="counselCsInfoStId" value="" />
						<input type="hidden" name="cusAcptDtmStart" id="counselCsInfoCusAcptDtmStart" value="" />
						<input type="hidden" name="cusAcptDtmEnd" id="counselCsInfoCusAcptDtmEnd" value="" />
						<input type="hidden" name="eqrrNm" id="counselCsInfoEqrrNm" value="" />
						<input type="hidden" name="eqrrTel" id="counselCsInfoEqrrTel" value="" />
						<input type="hidden" name="eqrrMobile" id="counselCsInfoEqrrMobile" value="" />
					
						<table class="table_type1 border_top_none">
							<caption>주문 검색</caption>
							<colgroup>
								<col style="width:120px;">
								<col />
								<col style="width:120px;">
								<col />
								<col style="width:120px;">
								<col />
								<col style="width:130px;">
							</colgroup>
							<tbody>
								<tr>
									<th scope="row"><spring:message code="column.order_common.cus_stat" /></th>
									<td>
										<select id="counselCsInfoCusStatCd" name="cusStatCd" class="counselCsInfo" title="<spring:message code="column.order_common.cus_stat" />">
											<frame:select grpCd="${adminConstants.CUS_STAT}" defaultName="전체"/>
										</select>
									</td>
									<th><spring:message code="column.cus_ctg1_cd" /></th>
									<td>
										<select name="cusCtg1Cd" id="counselCsInfoCusCtg1Cd" class="counselCsInfo" title="<spring:message code="column.cus_ctg1_cd" />" >
											<frame:select grpCd="${adminConstants.CUS_CTG1 }" defaultName="전체" />
										</select>
									</td>
									<th><spring:message code="column.ord_no" /></th>
									<td>
										<input type="text" name="ordNo" id="counselCsInfoOrdNo" class="counselCsInfo" value="" />
									</td>
									<td>
										<button type="button" onclick="counselInfoCs.reload();" class="btn">상세조회</button>
									</td>
									
								</tr>
							</tbody>
						</table>
					</form>
					
									
					<div class="mModule mt10">
						<table id="counselCsInfoList" ></table>
						<div id="counselCsInfoListPage"></div>
					</div>
					
					<form id="counselCsDetailForm">
						<input type="hidden" name="cusNo" id="counselCsDetailCusNo" value="" />
						<input type="hidden" name="viewGb" value="${adminConstants.VIEW_GB_POP}" />
						<input type="hidden" name="popTitleYn" value="N" />
					</form>
					
					<iframe id="counselAcceptCsDetail" name="counselAcceptCsDetail" width="100%" height="100%" style="margin-top:10px; min-height:500px;">
					
					</iframe>