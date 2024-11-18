<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>

<form id="couponListForm" name="couponListForm" method="post" >
	<table class="table_type1">
		<caption>정보 검색</caption>
		<tbody>
			<tr>
				<th scope="row"><spring:message code="column.common.date" /></th>
				<td>
					<frame:datepicker startDate="aplStrtDtm" endDate="aplEndDtm" startValue="${adminConstants.COMMON_START_DATE }" />
				</td>					
				<th scope="row"><spring:message code="column.st_id" /></th> <!-- 사이트 ID -->
				<td>
					<select id="stIdCombo" name="stId">
						<frame:stIdStSelect  defaultName="사이트선택"  readOnly="${so.isReadonlyStId}" stId="${empty so.stId ? '' : so.stId}"/>
					</select>
				</td>
			</tr>
			<tr>
				<th scope="row"><spring:message code="column.cp_kind_cd" /></th>
				<td>
					<select name="cpKindCd" id="cpKindCd" title="<spring:message code="column.cp_kind_cd" />">
						<frame:select grpCd="${adminConstants.CP_KIND}" defaultName="전체"/>
					</select>
				</td>					
				<th scope="row"><spring:message code="column.cp_stat_cd" /></th>
				<td>
					<select name="cpStatCd" id="cpStatCd" title="<spring:message code="column.cp_stat_cd" />">
						<frame:select grpCd="${adminConstants.CP_STAT}" defaultName="전체"/>
					</select>
				</td>
			</tr>
			<tr>
				<th scope="row"><spring:message code="column.cp_nm" /></th>
				<td>
					<input type="text" name="cpNm" id="cpNm" title="<spring:message code="column.cp_nm" />" >
				</td>
				<th scope="row"><spring:message code="column.cp_apl_cd" /></th>
				<td>
					<select name="cpAplCd" id="cpAplCd" title="<spring:message code="column.cp_apl_cd" />">
						<frame:select grpCd="${adminConstants.CP_APL}" defaultName="전체"/>
					</select>
				</td>						
			</tr>
			<tr>
				<th scope="row"><spring:message code="column.cp_pvd_mth_cd"/></th>
				<td colspan="3">
					<select name="cpPvdMthCd" id="cpPvdMthCd" title="<spring:message code="column.cp_pvd_mth_cd" />">
						<c:choose>
							<c:when test="${so.isReadonlyCpPvdMthCd }">
								<frame:select grpCd="${adminConstants.CP_PVD_MTH}" selectKeyOnly="true" readOnly="true" selectKey="${empty so.cpPvdMthCd ? '' : so.cpPvdMthCd}"/>
							</c:when>
							<c:otherwise>
								<frame:select grpCd="${adminConstants.CP_PVD_MTH}" defaultName="전체" selectKey="${empty so.cpPvdMthCd ? '' : so.cpPvdMthCd}"/>
							</c:otherwise>
						</c:choose>
						
					</select>
				</td>		
			</tr>
			
		</tbody>
	</table>
</form>
	<div class="btn_area_center">
		<button type="button" onclick="layerCouponList.searchCouponList();" class="btn btn-ok">검색</button>
		<button type="button" onclick="layerCouponList.searchReset();" class="btn btn-cancel">초기화</button>
	</div>
	<hr />

	<div class="mModule">
		<table id="layerCouponList" ></table>
		<div id="layerCouponListPage"></div>
	</div>