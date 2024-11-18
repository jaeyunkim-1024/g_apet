<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>

<script type="text/javascript">
	$(document).ready(function(){
			if($("input[name='dispPrdSetYn']:checked").val() == "${adminConstants.DISP_PRD_SET_YN_N}") {
				var date = new Date();
				var year = date.getFullYear();
				var mon = (date.getMonth()+1)>9 ? ''+(date.getMonth()+1) : '0'+(date.getMonth()+1);
				var day = date.getDate()>9 ? ''+date.getDate() : '0'+date.getDate();
						
				$("#dispStrtDt").val(year + '-' + mon + "-" + day);
				$("#dispStrtHr").val(date.getHours());
				$("#dispStrtMn").val(date.getMinutes());
				$("#dispStrtSec").val("00");
				$("#dispEndDt").val("9999-12-31");
				$("#dispEndHr").val("23");
				$("#dispEndMn").val("59");
				$("#dispEndSec").val("59");
				$("#dispStrtDt").removeClass("validate[required,custom[date]]");
				$("#dispEndDt").removeClass("validate[required,custom[date]]");
			} else {
				$("#dispStrtDt").val("");
				$("#dispStrtHr").val("");
				$("#dispStrtMn").val("");
				$("#dispStrtSec").val("");
				$("#dispEndDt").val("");
				$("#dispEndHr").val("");
				$("#dispEndMn").val("");
				$("#dispEndSec").val("");
				$("#dispStrtDt").addClass("validate[required,custom[date]]");
				$("#dispEndDt").addClass("validate[required,custom[date]]");
			}
	});
	
	//배너 검색 팝업
	function bannerSearchLayerViewPop() {
		var options = {
				multiselect : false
				, callBack : searchBannerCallBack
		};
		layerBannerList.create(options);
	}
	
	//배너 검색 콜백함수
	function searchBannerCallBack(data){
		$("#contentSearchForm #contentId").val(data[0].bnrId);
		$("#contentSearchForm #contentTtl").val(data[0].bnrTtl);
		$("#contentSearchForm #bnrNo").val(data[0].bnrNo);
		$("#contentSearchForm #vdId").val("");
	}
	
	//영상 검색 팝업
	function videoSearchLayerViewPop() {
		var options = {
				multiselect : false
				, callBack : searchVideoCallBack
		};
		layerVodList.create(options);
	}
	
	//영상 검색 콜백함수
	function searchVideoCallBack(data){
		$("#contentSearchForm #contentId").val(data[0].vdId);
		$("#contentSearchForm #contentTtl").val(data[0].ttl);
		$("#contentSearchForm #vdId").val(data[0].vdId);
		$("#contentSearchForm #bnrNo").val("");
	}
	
	$(document).on("change", "input[name=dispPrdSetYn]", function(e) {
		if($(this).val() == "${adminConstants.DISP_PRD_SET_YN_N}") {
			var date = new Date();
			var year = date.getFullYear();
			var mon = (date.getMonth()+1)>9 ? ''+(date.getMonth()+1) : '0'+(date.getMonth()+1);
			var day = date.getDate()>9 ? ''+date.getDate() : '0'+date.getDate();
					
			$("#dispStrtDt").val(year + '-' + mon + "-" + day);
			$("#dispStrtHr").val(date.getHours());
			$("#dispStrtMn").val(date.getMinutes());
			$("#dispStrtSec").val("00");
			$("#dispEndDt").val("9999-12-31");
			$("#dispEndHr").val("23");
			$("#dispEndMn").val("59");
			$("#dispEndSec").val("59");
			$("#dispStrtDt").removeClass("validate[required,custom[date]]");
			$("#dispEndDt").removeClass("validate[required,custom[date]]");
		} else {
			$("#dispStrtDt").val("");
			$("#dispStrtHr").val("");
			$("#dispStrtMn").val("");
			$("#dispStrtSec").val("");
			$("#dispEndDt").val("");
			$("#dispEndHr").val("");
			$("#dispEndMn").val("");
			$("#dispEndSec").val("");
			$("#dispStrtDt").addClass("validate[required,custom[date]]");
			$("#dispEndDt").addClass("validate[required,custom[date]]");
		}
	});
	
</script>

<form name="contentSearchForm" id="contentSearchForm" method="post">
	<input type="hidden" id="dispStrtDtm" name="dispStrtDtm" value="" />
	<input type="hidden" id="dispEndDtm" name="dispEndDtm" value="" />
	<input type="hidden" id="bnrNo" name="bnrNo" value="" />
	<input type="hidden" id="vdId" name="vdId" value="" />
		<table class="table_type1">
			<caption>어바웃TV 콘텐츠 등록/수정</caption>
			<tbody>
				<tr>
					<th scope="row"><spring:message code="column.content_id" /><strong class="red">*</strong></th>
					<td>
						<!-- 콘텐츠 ID-->
						<div style="float:left; margin-right:5px;">
							<input type="text" name="contentId" id="contentId" value="${content.bnrId }" class="readonly validate[required]" readonly="readonly" />
						</div>
						<div>
							<button type="button" class="btn" onclick="videoSearchLayerViewPop();"><spring:message code="column.video_search_btn" /></button>
							<button type="button" class="btn" onclick="bannerSearchLayerViewPop();"><spring:message code="column.banner_search_btn" /></button>
						</div>
					</td>
				</tr>
				<tr>
					<th scope="row"><spring:message code="column.ttl" /></th>
					<!-- 제목--> 
					<td>
						<input type="text" name="contentTtl" id="contentTtl" value="${content.bnrTtl }" class="w500 readonly" readonly="readonly" maxlength="50" /> 
					</td>
				</tr>
				<tr>
					<th scope="row"><spring:message code="column.content_disp_date" /><strong class="red">*</strong></th>
					<td>
						<frame:radio name="dispPrdSetYn" grpCd="${adminConstants.DISP_PRD_SET_YN }" selectKey="${adminConstants.DISP_PRD_SET_YN_N}" />
						<!-- 노출기간--> 
						<frame:datepicker startDate="dispStrtDt"
										  startHour="dispStrtHr"
										  startMin="dispStrtMn"
										  startSec="dispStrtSec"
										  startValue="${empty displayBase.dispStrtdt ? frame:toDate('yyyy-MM-dd') : displayBase.dispStrtdt}"
					 					  endDate="dispEndDt"
										  endHour="dispEndHr"
										  endMin="dispEndMn"
										  endSec="dispEndSec"
										  endValue="${empty displayBase.dispEnddt ? frame:addMonth('yyyy-MM-dd', 1) : displayBase.dispEnddt}" required="Y"
						/>&nbsp;&nbsp;
					</td>
				</tr>
			</tbody>
		</table>
		<br>
		<table class="table_type1">
			<tbody>
				<tr>
					<th scope="row"><spring:message code="column.sys_regr_nm" /></th>
					<td id="sysRegrNm">
						${content.sysRegrNm}
					</td>
					<th scope="row"><spring:message code="column.sys_reg_dt" /></th>
					<td id="sysRegDtm">
						<fmt:formatDate value="${content.sysRegDtm}" pattern="yyyy-MM-dd HH:mm:ss"/>
					</td>
				</tr>
				<tr>
					<th scope="row"><spring:message code="column.sys_updr_nm" /></th>
					<td id="sysUpdrNm">
						${content.sysUpdrNm}
					</td>
					<th scope="row"><spring:message code="column.sys_upd_dt" /></th>
					<td id="sysUpdDtm">
						<fmt:formatDate value="${content.sysUpdDtm}" pattern="yyyy-MM-dd HH:mm:ss"/>
					</td>
				</tr>
			</tbody>
		</table>
</form>