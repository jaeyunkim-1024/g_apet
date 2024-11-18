<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<script type="text/javascript">
$(function(){
	console.log('${viewDlvrPlcyDetail}');
});
</script>
		<table class="table_type1">
			<caption>업체 배송정책</caption>
			<tbody>
				<tr>
					<th><spring:message code="column.plc_nm"/><strong class="red">*</strong></th>
					<td colspan="3">
						<input type="text" class="w300 validate[required] ${viewDlvrPlcyDetail eq 'Y' ? 'readonly' :''}" ${viewDlvrPlcyDetail eq 'Y' ? 'readonly="readonly"' :''} name="plcNm" id="plcNm" title="<spring:message code="column.plc_nm"/>" value="${companyDelivery.plcNm}" maxlength="50"/>
					</td>
				</tr>
				<tr>
					<th><spring:message code="column.comp_dlvr_psb_area_cd"/><strong class="red">*</strong></th>
					<td colspan="3">
						<!-- 배송가능 지역 코드-->
						<select class="w180 ${viewDlvrPlcyDetail eq 'Y' ? 'readonly' :''}" ${viewDlvrPlcyDetail eq 'Y' ? 'disabled="disabled"' :''} name="compDlvrPsbAreaCd" id="compDlvrPsbAreaCd" title="<spring:message code="column.comp_dlvr_psb_area_cd"/>">
							<frame:select grpCd="${adminConstants.COMP_DLVR_PSB_AREA}" selectKey="${companyDelivery.compDlvrPsbAreaCd}" />
						</select>
						<label class="addDlvrAmtView ${viewDlvrPlcyDetail eq 'Y' ? 'readonly' :''}" ${viewDlvrPlcyDetail eq 'Y' ? 'readonly="readonly"' :''} style="${adminConstants.COMP_DLVR_PSB_AREA_30 eq companyDelivery.compDlvrPsbAreaCd ? '' : 'display: none;' }">
                            <input type="text" class="comma validate[required]" name="addDlvrAmt" id="addDlvrAmt" title="<spring:message code="column.dlvr_amt"/>" value="${adminConstants.COMP_DLVR_PSB_AREA_30 eq companyDelivery.compDlvrPsbAreaCd ? companyDelivery.addDlvrAmt : ''}" maxlength="10"/>
                            &nbsp;<spring:message code="column.common.won"/>
                        </label>
					</td>
				</tr>
				<!--  
<c:if test="${adminConstants.USR_GRP_10 ne adminSession.usrGrpCd}" >
				<tr>
					<th><spring:message code="column.comp_dlvr_mtd_cd"/><strong class="red">*</strong></th>
					<td>
						<span class="mg5">
							<select class="w180 ${viewDlvrPlcyDetail eq 'Y' ? 'readonly' :''}" ${viewDlvrPlcyDetail eq 'Y' ? 'disabled="disabled"' :''} name="compDlvrMtdCd" id="compDlvrMtdCd" title="<spring:message code="column.comp_dlvr_mtd_cd"/>">
								<frame:select grpCd="${adminConstants.COMP_DLVR_MTD}" selectKey="${adminConstants.COMP_DLVR_MTD_10}" readOnly="true"/>
							</select>
							<select id="hdcCdSelect" class="${viewDlvrPlcyDetail eq 'Y' ? 'readonly' :''}" ${viewDlvrPlcyDetail eq 'Y' ? 'disabled="disabled"' :''} name="dftHdcCd" title="<spring:message code="column.hdcCd"/>" ${not empty companyDelivery and adminConstants.COMP_DLVR_MTD_10 ne companyDelivery.compDlvrMtdCd ? 'style="display: none;"' : ''}">
                                <frame:select grpCd="${adminConstants.HDC}" selectKey="${companyDelivery.dftHdcCd}"/>
                            </select>
						</span>
					</td>
				</tr>
</c:if>				
-->
				<tr>
					<th>배송비 정책 <strong class="red">*</strong></th>
					<td colspan="3">
						<table class="table_sub">
							<caption>배송비 설정</caption>
							<colgroup>
								<col width="15%"/>
								<col width="10%"/>
								<col width="20%"/>
								<col width="25%"/>
								<col width="15%"/>
								<col width="15%"/>
							</colgroup>
							<tbody>
								<tr>
									<td>
										<!-- 무료 배송 -->
										<label class="fRadio"><input type="radio" ${viewDlvrPlcyDetail eq 'Y' ? 'disabled="disabled"' :''} class="validate[required]" ${companyDelivery.dlvrcStdCd eq adminConstants.DLVRC_STD_10 ? 'checked="checked"' : ''} name="dlvrcStdCd" id="dlvrcStdCd${adminConstants.DLVRC_STD_10}" value="${adminConstants.DLVRC_STD_10}"> <span><frame:codeName grpCd="${adminConstants.DLVRC_STD}" dtlCd="${adminConstants.DLVRC_STD_10}"/></span></label>
									</td>
									<td></td>
									<td></td>
									<td><spring:message code="column.company_view.message.type1"/><!-- 수량/금액 상관없이 무조건 무료 --></td>
									<td><frame:codeName grpCd="${adminConstants.DLVRC_STD}" dtlCd="${adminConstants.DLVRC_STD_10}"/></td>
									<td class="right">0 <spring:message code="column.common.won"/></td>
								</tr>
								<tr>
									<td rowspan="3"><!--  배송비 추가 -->
										<label class="fRadio"><input type="radio" ${viewDlvrPlcyDetail eq 'Y' ? 'disabled="disabled"' :''} class="validate[required]" ${companyDelivery.dlvrcStdCd eq adminConstants.DLVRC_STD_20 ? 'checked="checked"' : ''} name="dlvrcStdCd" id="dlvrcStdCd${adminConstants.DLVRC_STD_20}" value="${adminConstants.DLVRC_STD_20}"> <span><frame:codeName grpCd="${adminConstants.DLVRC_STD}" dtlCd="${adminConstants.DLVRC_STD_20}"/></span></label>
									</td>
									<td rowspan="3">
										<div class="mg5"><!--  선불 -->
											<label class="fRadio"><input type="radio" ${viewDlvrPlcyDetail eq 'Y' ? 'disabled="disabled"' :''} ${empty companyDelivery.dlvrcPayMtdCd ? 'disabled="disabled"' : ''} ${companyDelivery.dlvrcPayMtdCd eq adminConstants.DLVRC_PAY_MTD_10 ? 'checked="checked"' : ''} name="dlvrcPayMtdCd" id="dlvrcPayMtdCd${adminConstants.DLVRC_PAY_MTD_10}" value="${adminConstants.DLVRC_PAY_MTD_10}"> <span><frame:codeName grpCd="${adminConstants.DLVRC_PAY_MTD}" dtlCd="${adminConstants.DLVRC_PAY_MTD_10}" /></span></label>
										</div>
									</td>
									<td><!-- 선불 -->
										<label class="fRadio"><input type="radio" ${viewDlvrPlcyDetail eq 'Y' ? 'disabled="disabled"' :''} ${empty companyDelivery.dlvrcCdtStdCd || companyDelivery.dlvrcPayMtdCd ne adminConstants.DLVRC_PAY_MTD_10 ? 'disabled="disabled"' : ''} ${companyDelivery.dlvrcCdtStdCd eq adminConstants.DLVRC_CDT_STD_10 ? 'checked="checked"' : ''} name="dlvrcCdtStdCd" id="dlvrcCdtStdCd${adminConstants.DLVRC_CDT_STD_10}" value="${adminConstants.DLVRC_CDT_STD_10}"> <span><frame:codeName grpCd="${adminConstants.DLVRC_CDT_STD}" dtlCd="${adminConstants.DLVRC_CDT_STD_10}"/></span></label>
									</td>
									<td>
										<spring:message code="column.company_view.message.type2"/><!-- 개당/주문당에 따라 유료 배송 -->
									</td>
									<td rowspan="3">
										<div class="mg5">
											<label class="fRadio"><input type="radio" ${viewDlvrPlcyDetail eq 'Y' ? 'disabled="disabled"' :''} ${empty companyDelivery.dlvrcCdtCd ? 'disabled="disabled"' : ''} ${companyDelivery.dlvrcCdtCd eq adminConstants.DLVRC_CDT_10 ? 'checked="checked"' : ''} name="dlvrcCdtCd" id="dlvrcCdtCd${adminConstants.DLVRC_CDT_10}" value="${adminConstants.DLVRC_CDT_10}"> <span><frame:codeName grpCd="${adminConstants.DLVRC_CDT}" dtlCd="${adminConstants.DLVRC_CDT_10}"/></span></label>
										</div>
										<div class="mg5 mt20"><!--  주문당 부여  -->
											<label class="fRadio"><input type="radio" ${viewDlvrPlcyDetail eq 'Y' ? 'disabled="disabled"' :''} ${empty companyDelivery.dlvrcCdtCd ? 'disabled="disabled"' : ''} ${companyDelivery.dlvrcCdtCd eq adminConstants.DLVRC_CDT_20 ? 'checked="checked"' : ''} name="dlvrcCdtCd" id="dlvrcCdtCd${adminConstants.DLVRC_CDT_20}" value="${adminConstants.DLVRC_CDT_20}"> <span><frame:codeName grpCd="${adminConstants.DLVRC_CDT}" dtlCd="${adminConstants.DLVRC_CDT_20}"/></span></label>
										</div>
									</td>
									<td rowspan="3" class="right">
										<label>
											<input type="text" class="w100 comma ${empty companyDelivery.dlvrcCdtStdCd or companyDelivery.dlvrcCdtStdCd eq adminConstants.DLVRC_CDT_STD_50 or viewDlvrPlcyDetail eq 'Y' ? 'readonly' : 'validate[required]'}" ${empty companyDelivery.dlvrcCdtStdCd or companyDelivery.dlvrcCdtStdCd eq adminConstants.DLVRC_CDT_STD_50 or viewDlvrPlcyDetail eq 'Y' ? 'readonly="readonly"' : ''} name="dlvrAmt" id="dlvrAmt" title="<spring:message code="column.dlvr_amt"/>" value="${companyDelivery.dlvrcCdtStdCd ne adminConstants.DLVRC_CDT_STD_50 ? companyDelivery.dlvrAmt : ''}" maxlength="10"/>
											&nbsp;<spring:message code="column.common.won"/>
										</label>
									</td>
								</tr>
								<tr>
									<td>
										<label class="fRadio"><input type="radio" ${empty companyDelivery.dlvrcCdtStdCd || companyDelivery.dlvrcPayMtdCd ne adminConstants.DLVRC_PAY_MTD_10 || viewDlvrPlcyDetail eq 'Y' ? 'disabled="disabled"' : ''} ${companyDelivery.dlvrcCdtStdCd eq adminConstants.DLVRC_CDT_STD_20 ? 'checked="checked"' : ''} name="dlvrcCdtStdCd" id="dlvrcCdtStdCd${adminConstants.DLVRC_CDT_STD_20}" value="${adminConstants.DLVRC_CDT_STD_20}">
										 <span><frame:codeName grpCd="${adminConstants.DLVRC_CDT_STD}" dtlCd="${adminConstants.DLVRC_CDT_STD_20}"/></span>
										 </label>
									</td>
									<td>
										<label>
											<spring:message code="column.company_view.message.type3"/>&nbsp;<!-- 조건부 무료배송(구매가격) -->
											<input type="text" class="w100 comma ${companyDelivery.dlvrcCdtStdCd ne adminConstants.DLVRC_CDT_STD_20 or viewDlvrPlcyDetail eq 'Y' ? 'readonly' : 'validate[required]'}" ${companyDelivery.dlvrcCdtStdCd ne adminConstants.DLVRC_CDT_STD_20 or viewDlvrPlcyDetail eq 'Y' ? 'readonly="readonly"' : ''} name="buyPrc" id="buyPrc" title="<spring:message code="column.buy_prc"/>" value="${companyDelivery.dlvrcCdtStdCd eq adminConstants.DLVRC_CDT_STD_20 ? companyDelivery.buyPrc :''}" maxlength="20"/>
											&nbsp;<spring:message code="column.company_view.message.type4"/>
										</label>
									</td>
								</tr>
								<tr>
									<td>
										<label class="fRadio"><input type="radio" ${empty companyDelivery.dlvrcCdtStdCd || companyDelivery.dlvrcPayMtdCd ne adminConstants.DLVRC_PAY_MTD_10 || viewDlvrPlcyDetail eq 'Y' ? 'disabled="disabled"' : ''} ${companyDelivery.dlvrcCdtStdCd eq adminConstants.DLVRC_CDT_STD_30 ? 'checked="checked"' : ''} name="dlvrcCdtStdCd" id="dlvrcCdtStdCd${adminConstants.DLVRC_CDT_STD_30}" value="${adminConstants.DLVRC_CDT_STD_30}"> <span><frame:codeName grpCd="${adminConstants.DLVRC_CDT_STD}" dtlCd="${adminConstants.DLVRC_CDT_STD_30}"/></span></label>
									</td>
									<td>
										<label>
											<spring:message code="column.company_view.message.type3"/>&nbsp; <!-- 조건부 무료배송(구매수량) -->
											<input type="text" class="w100 comma ${companyDelivery.dlvrcCdtStdCd ne adminConstants.DLVRC_CDT_STD_30 or viewDlvrPlcyDetail eq 'Y' ? 'readonly' : 'validate[required]'}" ${companyDelivery.dlvrcCdtStdCd ne adminConstants.DLVRC_CDT_STD_30 or viewDlvrPlcyDetail eq 'Y' ? 'readonly="readonly"' : ''} name="buyQty" id="buyQty" title="<spring:message code="column.buy_qty"/>" value="${companyDelivery.dlvrcCdtStdCd eq adminConstants.DLVRC_CDT_STD_30 ? companyDelivery.buyQty :''}" maxlength="10"/>
											&nbsp;<spring:message code="column.company_view.message.type5"/>
										</label>
									</td>
								</tr>
								
							</tbody>
						</table>
					</td>
				</tr>
				<tr>
					<th><spring:message code="column.company_view.message.type10"/><strong class="red">*</strong></th>
					<td colspan="3">
						<label>
							<spring:message code="column.common.min"/>&nbsp;
							<input type="text" class="numeric validate[required, custom[onlyNum]] ${viewDlvrPlcyDetail eq 'Y' ? 'readonly' :''}" ${viewDlvrPlcyDetail eq 'Y' ? 'readonly="readonly"' :''} maxlength="3" name="dlvrMinSmldd" id="dlvrMinSmldd" title="<spring:message code="column.dlvr_min_smldd"/>" value="${companyDelivery.dlvrMinSmldd}"/>
							<spring:message code="column.common.day"/>
						</label>
						&nbsp;~&nbsp;
						<label>
							<spring:message code="column.common.max"/>&nbsp;
							<input type="text" class="numeric validate[required, custom[onlyNum]]] ${viewDlvrPlcyDetail eq 'Y' ? 'readonly' :''}" ${viewDlvrPlcyDetail eq 'Y' ? 'readonly="readonly"' :''} maxlength="3" name="dlvrMaxSmldd" id="dlvrMaxSmldd" title="<spring:message code="column.dlvr_max_smldd"/>" value="${companyDelivery.dlvrMaxSmldd}" />
							<spring:message code="column.common.day"/>
						</label>
					</td>
				</tr>
				<tr>
					<th><spring:message code="column.rtn_exc_man"/><strong class="red">*</strong></th>
					<td>
						<!-- 반품/교환 담당자-->
						<input type="text" class="w200 validate[required] ${viewDlvrPlcyDetail eq 'Y' ? 'readonly' :''}" ${viewDlvrPlcyDetail eq 'Y' ? 'readonly="readonly"' :''} name="rtnExcMan" id="rtnExcMan" title="<spring:message code="column.rtn_exc_man"/>" value="${companyDelivery.rtnExcMan}" maxlength="50"/>
					</td>
					<th><spring:message code="column.rtn_exc_tel"/><strong class="red">*</strong></th>
					<td>
						<!-- 반품/교환 연락처-->
						<input type="text" class="w200 phoneNumber validate[required, custom[tel]] ${viewDlvrPlcyDetail eq 'Y' ? 'readonly' :''}" ${viewDlvrPlcyDetail eq 'Y' ? 'readonly="readonly"' :''} name="rtnExcTel" id="rtnExcTel" title="<spring:message code="column.rtn_exc_tel"/>" value="${frame:phoneNumber(companyDelivery.rtnExcTel)}" maxlength="20"/>
					</td>
				</tr>
				<tr>
					<th>교환 배송비(왕복) <strong class="red">*</strong></th>
					<td>
						<label>
							<input type="text" class="comma validate[required] ${viewDlvrPlcyDetail eq 'Y' ? 'readonly' :''}" ${viewDlvrPlcyDetail eq 'Y' ? 'readonly="readonly"' :''} name="excDlvrc" id="excDlvrc" title="<spring:message code="column.exc_dlvrc"/>" value="${companyDelivery.excDlvrc}" maxlength="10"/>
							&nbsp;<spring:message code="column.common.won"/>
						</label>
						<br/>
						<label class="red-desc">
							<spring:message code="column.company_view.message.type8"/>
						</label>
					</td>
					<th>반품 배송비 <strong class="red">*</strong></th>
					<td>
						<label>
							<input type="text" class="comma validate[required] ${viewDlvrPlcyDetail eq 'Y' ? 'readonly' :''}" ${viewDlvrPlcyDetail eq 'Y' ? 'readonly="readonly"' :''} name="rtnDlvrc" id="rtnDlvrc" title="<spring:message code="column.rtn_dlvrc"/>" value="${companyDelivery.rtnDlvrc}" maxlength="10"/>
							&nbsp;<spring:message code="column.common.won"/>
						</label>
						<br/>
						<label class="red-desc">
							<spring:message code="column.company_view.message.type9"/>
						</label>
					</td>
				</tr>
				<tr>
					<th><spring:message code="column.company_view.message.type11"/><strong class="red">*</strong></th>
					<td colspan="3">
						<!-- 출고지 우편 번호 구-->
						<input type="hidden" name="rlsaPostNoOld" id="rlsaPostNoOld" title="<spring:message code="column.rlsa_post_no_old"/>" value="${companyDelivery.rlsaPostNoOld}" />
						<!-- 출고지 지번 주소-->
						<input type="hidden" name="rlsaPrclAddr" id="rlsaPrclAddr" title="<spring:message code="column.rlsa_prcl_addr"/>" value="${companyDelivery.rlsaPrclAddr}" />
						<div class="mg5">
							<!-- 출고지 우편 번호 신-->
							<input type="text" class="readonly validate[required]" name="rlsaPostNoNew" id="rlsaPostNoNew" title="<spring:message code="column.rlsa_post_no_new"/>" value="${companyDelivery.rlsaPostNoNew}" readonly="readonly" />
							<button type="button" onclick="layerMoisPost.create(rlsaPost);" ${viewDlvrPlcyDetail eq 'Y' ? 'disabled="disabled"' :''} class="btn"><spring:message code="column.common.post.btn"/></button>
							<label class="red-desc">
								* 신 우편번호 도로명으로 입력됩니다.
							</label>
						</div>
						<div class="mg5">
							<!-- 출고지 도로 주소-->
							<input type="text" class="readonly w300" name="rlsaRoadAddr" id="rlsaRoadAddr" title="<spring:message code="column.rlsa_road_addr"/>" value="${companyDelivery.rlsaRoadAddr}" readonly="readonly" />
							<!-- 출고지 도로 상세 주소-->
							<input type="text" class="w200 validate[required] ${viewDlvrPlcyDetail eq 'Y' ? 'readonly' :''}" ${viewDlvrPlcyDetail eq 'Y' ? 'readonly="readonly"' :''} name="rlsaRoadDtlAddr" id="rlsaRoadDtlAddr" title="<spring:message code="column.rlsa_road_dtl_addr"/>" value="${companyDelivery.rlsaRoadDtlAddr}" maxlength="100"/>
						</div>
					</td>
				</tr>
				<tr>
					<th><spring:message code="column.company_view.message.type12"/><strong class="red">*</strong></th>
					<td colspan="3">
						<!-- 반품/교환 우편 번호 구-->
						<input type="hidden" name="rtnaPostNoOld" id="rtnaPostNoOld" title="<spring:message code="column.rtna_post_no_old"/>" value="${companyDelivery.rtnaPostNoOld}" />
						<!-- 반품/교환 지번 주소-->
						<input type="hidden" name="rtnaPrclAddr" id="rtnaPrclAddr" title="<spring:message code="column.rtna_prcl_addr"/>" value="${companyDelivery.rtnaPrclAddr}" />
						<div class="mg5">
							<!-- 반품/교환 우편 번호 신-->
							<input type="text" class="readonly validate[required]" name="rtnaPostNoNew" id="rtnaPostNoNew" title="<spring:message code="column.rtna_post_no_new"/>" value="${companyDelivery.rtnaPostNoNew}" readonly="readonly" />
							<button type="button" onclick="layerMoisPost.create(rtnaPost);" ${viewDlvrPlcyDetail eq 'Y' ? 'disabled="disabled"' :''} class="btn"><spring:message code="column.common.post.btn"/></button>
							<label class="red-desc">
								* 신 우편번호 도로명으로 입력됩니다.
							</label>
						</div>
						<div class="mg5">
							<!-- 반품/교환 도로 주소-->
							<input type="text" class="readonly w300" name="rtnaRoadAddr" id="rtnaRoadAddr" title="<spring:message code="column.rtna_road_addr"/>" value="${companyDelivery.rtnaRoadAddr}" readonly="readonly" />
							<!-- 반품/교환 도로 상세 주소-->
							<input type="text" class="w200 validate[required] ${viewDlvrPlcyDetail eq 'Y' ? 'readonly' :''}" ${viewDlvrPlcyDetail eq 'Y' ? 'readonly="readonly"' :''} name="rtnaRoadDtlAddr" id="rtnaRoadDtlAddr" title="<spring:message code="column.rtna_road_dtl_addr"/>" value="${companyDelivery.rtnaRoadDtlAddr}" maxlength="100"/>
						</div>
					</td>
				</tr>
				<!-- 
				<tr>
					<th><spring:message code="column.rtn_exc_info"/></th>
					<td colspan="3">
						<div class="fTextarea gFull">
							<textarea rows="3" cols="200" class="validate[maxSize[1000]]" ${viewDlvrPlcyDetail eq 'Y' ? 'disabled="disabled"' :''} name="rtnExcInfo" id="rtnExcInfo" title="<spring:message code="column.rtn_exc_info"/>" maxlength="4000">${companyDelivery.rtnExcInfo}</textarea>
						</div>
					</td>
				</tr>
				<tr>
					<th><spring:message code="column.rfd_info"/></th>
					<td colspan="3">
						<div class="fTextarea gFull">
							<textarea rows="3" cols="200" class="validate[maxSize[1000]]" ${viewDlvrPlcyDetail eq 'Y' ? 'disabled="disabled"' :''} name="rfdInfo" id="rfdInfo" title="<spring:message code="column.rfd_info"/>" maxlength="4000">${companyDelivery.rfdInfo}</textarea>
						</div>
					</td>
				</tr>
				<tr>
					<th><spring:message code="column.as_info"/></th>
					<td colspan="3">
						<div class="fTextarea gFull">
							<textarea rows="3" cols="200" class="validate[maxSize[1000]]" ${viewDlvrPlcyDetail eq 'Y' ? 'disabled="disabled"' :''} name="asInfo" id="asInfo" title="<spring:message code="column.as_info"/>" maxlength="4000">${companyDelivery.asInfo}</textarea>
						</div>
					</td>
				</tr>
				 -->
			</tbody>
		</table>
		