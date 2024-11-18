<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>

					<form id="counselClaimInfoForm">
						<input type="hidden" name="mbrNo" id="counselClaimInfoMbrNo" value="" />
						<input type="hidden" name="noSearch" id="counselClaimInfoNoSearch" value="Y" />
						<input type="hidden" name="stId" id="counselClaimInfoStId" value="" />
						<input type="hidden" name="clmAcptDtmStart" id="counselClaimInfoClmAcptDtmStart" value="" />
						<input type="hidden" name="clmAcptDtmEnd" id="counselClaimInfoClmAcptDtmEnd" value="" />
						<input type="hidden" name="ordNm" id="counselClaimInfoOrdNm" value="" />
						<input type="hidden" name="ordrTel" id="counselClaimInfoOrdrTel" value="" />
						<input type="hidden" name="ordrMobile" id="counselClaimInfoOrdrMobile" value="" />
				
					<table class="table_type1 border_top_none">
						<caption>클레임 검색</caption>
						<colgroup>
							<col style="width:90px;">
							<col />
							<col style="width:90px;">
							<col />
							<col style="width:90px;">
							<col />
							<col style="width:90px;">
							<col />
							<col style="width:130px;">
						</colgroup>
						<tbody>
							<tr>
								<th><spring:message code="column.ord_no" /></th>
								<td>
									<input type="text" name="ordNo" id="counselClaimInfoOrdNo" class="counselClaimInfo w100" value="" />
								</td>
								<th><spring:message code="column.goods_nm" /></th>
								<td>
									<input type="text" name="goodsNm" id="counselClaimInfoGoodsNm" class="counselClaimInfo w100" value="" />
								</td>
								<th><spring:message code="column.clm_tp_cd" /></th>
								<td>
									<select id="counselClaimInfoClmTpCd" name="clmTpCd" class="w100 counselClaimInfo" title="<spring:message code="column.clm_tp_cd" />">
										<frame:select grpCd="${adminConstants.CLM_TP}" defaultName="전체"/>
									</select>
								</td>
								<th><spring:message code="column.clm_stat_cd" /></th>
								<td>
									<select id="counselClaimInfoClmStatCd" name="clmStatCd" class="w100 counselClaimInfo" title="<spring:message code="column.clm_stat_cd" />">
										<frame:select grpCd="${adminConstants.CLM_STAT}" defaultName="전체"/>
									</select>
								</td>
								<td style="text-align:right">
									<button type="button" onclick="counselInfoClaim.reload();" class="btn">상세조회</button>
								</td>
								
							</tr>
						</tbody>
					</table>
					</form>
						
				
					<div class="mModule mt10">
						<table id="counselClaimInfoList" ></table>
						<div id="counselClaimInfoListPage"></div>
					</div>