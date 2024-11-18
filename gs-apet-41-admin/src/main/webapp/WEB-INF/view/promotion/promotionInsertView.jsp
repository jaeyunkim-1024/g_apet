<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">
			$(document).ready(function(){

				$("input:radio[name=prmtAplCd]").change(function() {
	                prmtAplCdChange("");
	            });

			});
            
            // 프로모션 적용 변경
            function prmtAplCdChange(aplVal){
                var prmtAplCd = $(":input:radio[name=prmtAplCd]:checked").val();
                
                if(prmtAplCd == '${adminConstants.CP_APL_10}') {
                    $("#spanCpAplCd").hide();
                    $("#spanCpAplCd10").show();
                    $(".prmtAplCdView").show();
                    $("#aplVal").attr("maxlength", 3);
                    $("#aplVal").val(aplVal);
                    objClass.add($("#aplVal"), "validate[required,custom[number],max[100]]");
                    objClass.remove($("#aplVal"), "validate[required,custom[number]]");
                } else {
                    $("#spanCpAplCd").hide();
                    $("#spanCpAplCd10").hide();
                    $(".prmtAplCdView").hide();
                    $("#maxDcAmt").val("");
                    $("#aplVal").attr("maxlength", null);
                    $("#aplVal").val(aplVal);
                    objClass.add($("#aplVal"), "validate[required,custom[number]]");
                    objClass.remove($("#aplVal"), "validate[required,custom[number],max[100]]");
                }
            }

			function insertPromotion() {
			
				if(validate.check("promotionForm")) {
					messager.confirm('<spring:message code="column.common.confirm.insert" />',function(r){
						if(r){
							var data = $("#promotionForm").serializeJson();
							var arrGoodsId = null;
							var arrGoodsExId = null;
							var arrDispClsfNo = null;
							var arrExhbtNo = null;
							var arrCompNo = null;
							var arrBndNo = null;
							var goodsIdx = $('#promotionGoodsList').getDataIDs();
							if(goodsIdx != null && goodsIdx.length > 0) {
								arrGoodsId = goodsIdx.join(",");
							}
							
							var goodsExIdx = $('#promotionGoodsExList').getDataIDs();
							if(goodsExIdx != null && goodsExIdx.length > 0) {
								arrGoodsExId = goodsExIdx.join(",");
							}
							var compNo  = $('#promotionTargetCompNoList').getDataIDs();
							if(compNo != null && compNo.length > 0) {
								arrCompNo  = compNo.join(",");
							}
							var bndNo  = $('#promotionTargetBndNoList').getDataIDs();
							if(bndNo != null && bndNo.length > 0) {
								arrBndNo  = bndNo.join(",");
							} 
							var exhbtNo  = $('#promotionExhbtList').getDataIDs();
							if(exhbtNo != null && exhbtNo.length > 0) {
								arrExhbtNo  = exhbtNo.join(",");
							} 
							
							var dispClsfNo  = $('#promotionDispList').getDataIDs();
							if(dispClsfNo != null && dispClsfNo.length > 0) {
								arrDispClsfNo  = dispClsfNo.join(",");
							} 
							 

							$.extend(data, { arrDispClsfNo : arrDispClsfNo }
							             , { arrGoodsId    : arrGoodsId }
							             , { arrGoodsExId  : arrGoodsExId }
							             , {arrCompNo     : arrCompNo}
								         , {arrBndNo      : arrBndNo}
								         , {arrExhbtNo    : arrExhbtNo}
							         );
							var options = {
								url : "<spring:url value='/promotion/promotionInsert.do' />"
								, data :  data
								, callBack : function(result){
									addTab('할인 프로모션 상세', '/promotion/promotionView.do?prmtNo=' + result.promotionBase.prmtNo);
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

		<form name="promotionForm" id="promotionForm" method="post">
		<table class="table_type1">
			<caption>할인 프로모션 등록</caption>
			<tbody>
				<tr>
					<th><spring:message code="column.prmt_nm"/><strong class="red">*</strong></th>
					<td>
						<!-- 프로모션 명-->
						<input type="text" class="w300 validate[required]" name="prmtNm" id="prmtNm" title="<spring:message code="column.cp_nm"/>" value="" />
					</td>								
					<th><spring:message code="column.prmt_stat_cd"/></th>
					<td>
						<!-- 프로모션 상태 코드-->
						<select name="prmtStatCd" id="prmtStatCd" title="<spring:message code="column.prmt_stat_cd"/>" disabled="disabled">
							<frame:select grpCd="${adminConstants.PRMT_STAT}" selectKey="${adminConstants.PRMT_STAT_10}" />
						</select>
					</td>
				</tr>
				<tr>
					<th><spring:message code="column.st_id"/><strong class="red">*</strong></th>
					<td>
						<frame:stIdRadio required="true"/>
					</td>
					<th><spring:message code="column.prmt_tg_cd"/><strong class="red">*</strong></th>
					<td>
						<!-- 프로모션 대상 코드-->
						<frame:radio name="prmtTgCd" grpCd="${adminConstants.PRMT_TG}" useYn="Y"/>
					</td>									
				</tr>
				<tr>
					<th><spring:message code="column.prmt_view.date"/><strong class="red">*</strong></th>
					<td>
						<frame:datepicker startDate="aplStrtDtm"
										  startValue="${frame:toDate('yyyy-MM-dd')}" 
										  endDate="aplEndDtm"
										  endValue="${frame:addMonth('yyyy-MM-dd', 1)}" 
										  required="Y"
										  />
					</td>
					<th><spring:message code="column.prmt_apl_cd"/><strong class="red">*</strong></th>
					<td>
						<!-- 프로모션 적용 코드-->
						<frame:radio name="prmtAplCd" grpCd="${adminConstants.PRMT_APL}" />
					</td>
				</tr>
				<tr>
					<th>프로모션 비용<strong class="red">*</strong></th>
					<td colspan="3">
						<table class="table_sub" style="width:450px">
							<caption>가격할인 프로모션 비용</caption>
							<colgroup>
								<col style="width:150px;" />
								<col />
							</colgroup>
							<tbody>
								<tr>
									<th><spring:message code="column.spl_comp_dvd_rate"/><strong class="red">*</strong></th>
									<td>
										<!-- 공급 업체 분담 율-->
										<input type="text" class="validate[required,custom[number]]" name="splCompDvdRate" id="splCompDvdRate" maxlength="4" title="<spring:message code="column.spl_comp_dvd_rate"/>" value="" />
										<span id="splCompDvdRateUnit"> %</span>
									</td>
								</tr>											
								<tr>
									<th><spring:message code="column.apl_val"/><strong class="red">*</strong></th>
									<td>
										<!-- 적용 값-->
										<input type="text" class="comma validate[required,custom[number],max[100]]" maxlength="3" name="aplVal" id="aplVal" title="<spring:message code="column.apl_val"/>" value="" />
										<span id="spanCpAplCd10"> %</span>
									</td>
								</tr>
								<tr style="display:none;">
									<th><spring:message code="column.rvs_mrg_pmt"/></th>
									<td>
										<!--  역마진 허용 여부  -->
										<frame:radio name="rvsMrgPmtYn" grpCd="${adminConstants.COMM_YN}" selectKey="${adminConstants.COMM_YN_Y}"/>
									</td>
								</tr>
							</tbody>
						</table>
					</td>
				</tr>
			</tbody>
		</table>
		</form>
		
		<div class="btn_area_center">
			<button type="button" onclick="insertPromotion();" class="btn btn-ok">등록</button>
			<button type="button" onclick="closeTab();" class="btn btn-cancel">취소</button>
		</div>
	</t:putAttribute>
</t:insertDefinition>