<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<script type="text/javascript">
	var sriesCheck2 = true;
	$(document).ready(function(){
		layerVodList.searchDateChange();
		
		if ("${vodSearchInfo.srisYn}" == "${adminConstants.SERIES_YN_Y}") {
			$("input[name=srisYn]").attr("onclick", "return false;");
		}
		
		$("#sysRegDtmStart").change(function(){
			compareDate("sysRegDtmStart", "sysRegDtmEnd");
		});
		
		$("#sysRegDtmEnd").change(function(){
			compareDate2("sysRegDtmStart", "sysRegDtmEnd");
		});
	});
	
	<%-- 시리즈 여부 변경 --%>
	$(document).on("change", "input[name=srisYn]", function(e) {
		if ($(this).val() == '${adminConstants.COMM_YN_Y}') {
			$("#srisNo").removeAttr('disabled');
			$("#srisNo").removeClass('readonly');
			$("#srisNo").addClass('required');
			$("#srisNo").val('');
		} else {
			$("#srisNo, #sesnNo").attr('disabled', 'true');
			$("#srisNo, #sesnNo").addClass('readonly');
			$("#srisNo, #sesnNo").removeClass('required');
			$("#srisNo, #sesnNo").val('');
		}
	});
	
	<%-- 시리즈 선택 --%>
	$(document).on("change", "#srisNo", function(e) {
		if (sriesCheck2) {
			if ($(this).val() == '') {
				$("#sesnNo").attr('disabled', 'true');
				$("#sesnNo").addClass('readonly');
				$("#sesnNo").removeClass('required');
				$("#sesnNo").val('');
			} else {
				let optionSeason = "<option value='' selected='selected'>시즌 전체</option>";
				let options = {
						url : "<spring:url value='/contents/listSeason.do' />"
						//, async : false
						, data : {
							srisNo : $(this).val()
						}
						, callBack : function(result) {
							sriesCheck2 = true;
							if (result.length > 0) {
								jQuery(result).each(function(i){
									optionSeason += "<option value='" + result[i].sesnNo + "'>" + result[i].sesnNm + "</option>";
								});
								$("#sesnNo").html('');
								$("#sesnNo").append(optionSeason);
								$("#sesnNo").removeAttr('disabled');
								$("#sesnNo").removeClass('readonly');
								$("#sesnNo").addClass('required');
							} else {
								$("#sesnNo").attr('disabled', 'true');
								$("#sesnNo").addClass('readonly');
								$("#sesnNo").removeClass('required');
								$("#sesnNo").html('');
								$("#sesnNo").append(optionSeason);
							}
						}
					};
	
					ajax.call(options);
			}
		}
		sriesCheck2 = false;
	});
</script>
<form name="vodSearchForm" id="vodSearchForm" method="post">
	<table class="table_type1 popup">
		<colgroup>
			<col width="150px"/>
			<col />
			<col width="150px"/>
			<col />
		</colgroup>
		<caption>영상 조회</caption>
		<tbody>
			<tr>
				<th scope="row"><spring:message code="column.sys_reg_dt" /><strong class="red">*</strong></th>
				<!-- 기간(등록일) -->
				<td colspan="3">
					<frame:datepicker startDate="sysRegDtmStart" endDate="sysRegDtmEnd" startValue="${adminConstants.COMMON_START_DATE }" required="D" />
					&nbsp;&nbsp;
					<select id="checkOptDate" name="checkOptDate" onchange="layerVodList.searchDateChange();">
						<frame:select grpCd="${adminConstants.SELECT_PERIOD }" selectKey="${adminConstants.SELECT_PERIOD_20 }" defaultName="기간선택" />
					</select>
				</td>
			</tr>
			<tr>
				<!-- 시리즈 여부 -->
				<th scope="row"><spring:message code="column.seriesYn" /></th>
				<td colspan="3">
					<frame:radio name="srisYn" grpCd="${adminConstants.SERIES_YN }" defaultName="전체" selectKey="${vodSearchInfo.srisYn }" excludeOption="${adminConstants.SERIES_YN_N }" />
					<select id="srisNo" name="srisNo" class="w300 readonly" title=<spring:message code="column.vod.series"/> disabled="disabled">
						<option value="">시리즈 전체</option>
						<c:forEach items="${allSeries}" var="series" varStatus="status">
							<option value="${series.srisNo}">${series.srisNm}</option>
						</c:forEach>
					</select>
					<select id="sesnNo" name="sesnNo" class="readonly" title=<spring:message code="column.vod.season"/> disabled="disabled">
						<option value="">시즌 전체</option>
					</select>
				</td>
			</tr>
			<tr>
				<!-- 컨텐츠 타입 -->
				<th scope="row"><spring:message code="column.vd_tp" /></th>
				<td colspan="3">
					<frame:radio name="vdTpCd" grpCd="${adminConstants.VD_TP }" defaultName="전체" />
				</td>
			</tr>
			<tr>
				<!-- 영상 ID -->
				<th scope="row"><spring:message code="column.vd_id" /></th>
				<td>
					<input type="text" name="vdId" id="vdId" class="w200" value="" maxlength="20" />
				</td>
				<!-- 전시 상태 -->
				<th scope="row"><spring:message code="column.disp_stat" /></th> 
				<td>
					<frame:radio name="dispYn" grpCd="${adminConstants.DISP_STAT }" defaultName="전체" />
				</td>						
			</tr>
			<tr>
				<!-- 공유 건수 -->
				<th scope="row"><spring:message code="column.educonts_share_cnt" /></th>
				<td>
					<input type="text" class="w100 inputTypeNum" name="shareFrom"> ~ <input type="text" class="w100 inputTypeNum" name="shareTo"> 
				</td>
				<!-- 좋아요 건수 -->
				<th scope="row"><spring:message code="column.educonts_like_cnt" /></th> 
				<td>
					<input type="text" class="w100 inputTypeNum" name="likeFrom"> ~ <input type="text" class="w100 inputTypeNum" name="likeTo">
				</td>
			</tr>
			<tr>
				<!-- 제목 -->
				<th scope="row"><spring:message code="column.ttl" /></th>
				<td colspan="3">
					<input type="text" name="ttl" id="ttl" class="w450" value="" maxlength="30" />
				</td>
			</tr>
		</tbody>
	</table>
</form>
<div class="btn_area_center mb30">
	<button type="button" onclick="layerVodList.searchVodList();" class="btn btn-ok">검색</button>
	<button type="button" onclick="layerVodList.searchReset();" class="btn btn-cancel">초기화</button>
</div>
<div class="mModule">
	<div id="resultArea" style="text-align: right;">
		<select id="vodSortOrder" onchange="layerVodList.reloadVodGrid(this)" title="<spring:message code="column.sort_seq" />">
			<frame:select grpCd="${adminConstants.VOD_SORT_ORDER}"/>
		</select>
	</div>
	<table id="layerVodList"></table>
	<div id="layerVodListPage"></div>
</div>
