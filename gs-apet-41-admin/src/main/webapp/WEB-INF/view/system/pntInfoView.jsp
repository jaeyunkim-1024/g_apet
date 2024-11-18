<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">
			$(document).ready(function(){
				// 적용 종료 일자 빈 값으로 수정
				if ("${empty pntInfo.aplEndDtm }" == "true") {
					$("#aplEndDt").val("");
				}
				
				var pntTpCdDefault = $("#pntTpCd option:eq(0)").text();
				if(pntTpCdDefault == '선택'){
					$("#pntPrmtGbCd").prop('disabled', true);
					$("#pntPrmtGbCd").addClass("readonly");
				}
				
				$("#pntTpCd").trigger("change");
				var useRate = $("#useRate").val();
				if(useRate){
					$("#useRate").val(useRate * 1);
				}
				
				
				var saveRate = $("#saveRate").val();
				if(saveRate){
					$("#saveRate").val(saveRate * 1);
				}
				
				var addSaveRate = $("#addSaveRate").val();
				if(addSaveRate){
					$("#addSaveRate").val(addSaveRate * 1);
				}
			});
			
			$(document).on("change","#aplEndDt, #aplEndHr, #aplEndMn", function(e) {
				if($("input:checkbox[id='unlimitEndDate']").is(":checked")){
					var endDt = $("#aplEndDt").val();
					var endHr = $("#aplEndHr option:selected").val();
					var endMn = $("#aplEndMn option:selected").val();		
					if(endDt != "9999-12-31" || endHr != "23" || endMn != "59"){
						//종료일 미지정 체크 해제 unlimitSaleEndDate			
						$('input:checkbox[id="unlimitEndDate"]').attr("checked", false);			
					}
				}	
				
			});
			
			$(document).on("change","#pntTpCd", function(e) {
				if($(this).val() == '${adminConstants.PNT_TP_GS}'){
					$("#saveRate").val("0.1");
					//GS 포인트
					$("#useRate").val('');
					$("#useRate").addClass('readonly');
					$("#useRate").prop('readonly', true);
					
					$("#addSaveRate").val('');
					$("#addSaveRate").addClass('readonly');
					$("#addSaveRate").prop('readonly', true);
					
					$("#maxSavePnt").val('');
					$("#maxSavePnt").addClass('readonly');
					$("#maxSavePnt").prop('readonly', true);
					$("#pntPrmtGbCd").val('${adminConstants.PNT_PRMT_GB_10}');
					$("#pntPrmtGbCd").trigger("change");
					$("#pntPrmtGbCd").prop('disabled', true);
					$("#pntPrmtGbCd").addClass('readonly');
					
					$("#altIfGoodsCd").prop('disabled', true);
					$("#altIfGoodsCd").addClass('readonly');
					
					$("#ifGoodsCd").prop('disabled', true);
					$("#ifGoodsCd").addClass('readonly');
					
					$("#aplStrtDt").removeClass("readonly");
					$("#aplStrtDt").prop('readonly', false);
					$("#aplStrtHr").prop('disabled', false);
					$("#aplEndDt").removeClass("readonly");
					$("#aplEndDt").prop('readonly', false);
					$("#aplEndDt").prop('disabled', false);
					
					$("#aplStrtHr").removeClass("readonly");
					$("#aplStrtDt").prop('readonly', false);
					$("#aplStrtHr").prop('disabled', false);
					$("#aplStrtDt").prop('disabled', false);
					
					$("#aplStrtMn").removeClass("readonly");
					$("#aplStrtMn").prop('readonly', false);
					$("#aplStrtMn").prop('disabled', false);
					
					$("#aplEndDt").removeClass("readonly");
					$("#aplEndDt").prop('readonly', false);
					$("#aplEndDt").prop('disabled', false);
					
					$("#aplEndMn").removeClass("readonly");
					$("#aplEndMn").prop('readonly', false);
					$("#aplEndMn").prop('disabled', false);
					
					
					$("#aplEndHr").removeClass("readonly");
					$("#aplEndHr").prop('readonly', false);
					$("#aplEndHr").prop('disabled', false);
					
					$("#useYnY").attr('disabled', false);
					$("#useYnN").attr('disabled', false);
					
					
					
					var date = toDateObject(getCurrentTime());
					$("#aplStrtDt").val( toDateString(date, "-"));
					$("#aplStrtHr option:eq(0)").prop("selected", true);
					$("#aplStrtMn option:eq(0)").prop("selected", true);
					
					
				}else if($(this).val() == '${adminConstants.PNT_TP_MP}'){
					//MP 포인트
					
					$("#useYnY").attr('disabled', false);
					$("#useYnN").attr('disabled', false);
					
					$("#aplStrtDt").removeClass("readonly");
					$("#aplStrtDt").prop('readonly', false);
					$("#ifGoodsCd").prop('disabled',false);
					
					$("#ifGoodsCd").addClass("readonly");
					$("#ifGoodsCd").prop('readonly',true);
					$("#ifGoodsCd").prop('disabled', true);
					
					$("#altIfGoodsCd").addClass("readonly");
					$("#altIfGoodsCd").prop('readonly',true);
					$("#altIfGoodsCd").prop('disabled', true);
					
					var txt = $(".btn_area_center>.btn.btn-ok").text();	
					
					
					if(txt == '등록'){
						$("#pntPrmtGbCd").removeClass("readonly");
						$("#pntPrmtGbCd").prop('readonly',false);
						$("#pntPrmtGbCd").prop('disabled', false);	
					}else{
						$("#pntPrmtGbCd").addClass("readonly");
						$("#pntPrmtGbCd").prop('readonly',true);
						$("#pntPrmtGbCd").prop('disabled', true);	
					}
					

					$("#pntPrmtGbCd option:eq(1)").prop("selected", true);
					
					$("#saveRate").val("10");
					
					$("#aplStrtDt").removeClass("readonly");
					$("#aplStrtDt").prop('readonly', false);
					$("#aplEndDt").removeClass("readonly");
					$("#aplEndDt").prop('readonly', false);
					
					$("#addSaveRate").removeClass("readonly");
					$("#addSaveRate").prop('readonly', false);
					
					$("#useRate").removeClass("readonly");
					$("#useRate").prop('readonly', false);
					
					if(!$("#useRate").val()){
						$("#useRate").val("");
					}
					
					$("#maxSavePnt").removeClass("readonly");
					$("#maxSavePnt").prop('readonly', false);
					
					$("#altIfGoodsCd").removeClass("readonly");
					$("#altIfGoodsCd").prop('readonly', false);
					
					$("#ifGoodsCd").removeClass("readonly");
					$("#ifGoodsCd").prop('readonly', false);
					
					$("#aplStrtHr").removeClass("readonly");
					$("#aplStrtHr").prop('disabled', false);
					$("#aplStrtMn").removeClass("readonly");
					$("#aplStrtMn").prop('disabled', false);
					$("#aplEndHr").removeClass("readonly");
					$("#aplEndHr").prop('disabled', false);
					$("#aplEndMn").removeClass("readonly");
					$("#aplEndMn").prop('disabled', false);
					$("#unlimitEndDate").prop('disabled', false);
					$(".date_picker_box").css("pointer-events", "");
					
					var date = toDateObject(getCurrentTime());
					$("#aplStrtDt").val( toDateString(date, "-"));
					$("#aplStrtHr option:eq(0)").prop("selected", true);
					$("#aplStrtMn option:eq(0)").prop("selected", true);
					
				}else{
					$("#pntPrmtGbCd").trigger("change");
					var pntTpCdDefault = $("#pntTpCd option:eq(0)").text();
					if(pntTpCdDefault == '선택'){
					
						$("#useRate").val('');
						$("#useRate").addClass('readonly');
						$("#useRate").prop('readonly', true);
						
						$("#addSaveRate").val('');
						$("#addSaveRate").addClass('readonly');
						$("#addSaveRate").prop('readonly', true);
						
						$("#maxSavePnt").val('');
						$("#maxSavePnt").addClass('readonly');
						$("#maxSavePnt").prop('readonly', true);
						$("#pntPrmtGbCd").val('${adminConstants.PNT_PRMT_GB_10}');
						$("#pntPrmtGbCd").trigger("change");
						$("#pntPrmtGbCd").prop('disabled', true);
						$("#pntPrmtGbCd").addClass('readonly');
						
						$("#altIfGoodsCd").prop('disabled', true);
						$("#altIfGoodsCd").addClass('readonly');
						
						$("#ifGoodsCd").prop('disabled', true);
						$("#ifGoodsCd").addClass('readonly');
						
						$("#aplStrtDt").addClass("readonly");
						$("#aplStrtDt").prop('readonly', true);
						$("#aplStrtHr").prop('disabled', true);
						$("#aplEndDt").addClass("readonly");
						$("#aplEndDt").prop('readonly', true);
						$("#aplEndDt").prop('disabled', true);
						
						$("#aplStrtHr").addClass("readonly");
						$("#aplStrtDt").prop('readonly', true);
						$("#aplStrtHr").prop('disabled', true);
						$("#aplStrtDt").prop('disabled', true);
						
						$("#aplStrtMn").addClass("readonly");
						$("#aplStrtMn").prop('readonly', false);
						$("#aplStrtMn").prop('disabled', false);

						$("#aplEndDt").addClass("readonly");
						$("#aplEndDt").prop('readonly', false);
						$("#aplEndDt").prop('disabled', false);
						
						$("#aplEndMn").addClass("readonly");
						$("#aplEndMn").prop('readonly', true);
						$("#aplEndMn").prop('disabled', true);
						
						
						$("#aplEndHr").addClass("readonly");
						$("#aplEndHr").prop('readonly', false);
						$("#aplEndHr").prop('disabled', false);
						
						$("#useYnY").attr('disabled', true);
						$("#useYnN").attr('disabled', true);
					}
				}
			});
			
			$(document).on("change","#pntPrmtGbCd", function(e) {
				
					if($(this).val() == '${adminConstants.PNT_PRMT_GB_20}'){
						
					$("#aplStrtDt").removeClass("readonly");
					$("#aplStrtDt").prop('readonly', false);
					$("#aplEndDt").removeClass("readonly");
					$("#aplEndDt").prop('readonly', false);
					
					$("#addSaveRate").removeClass("readonly");
					$("#addSaveRate").prop('readonly', false);
					
					$("#useRate").removeClass("readonly");
					$("#useRate").prop('readonly', false);
					
					if(!$("#useRate").val()){
						$("#useRate").val("");
					}
					
					$("#saveRate").val("10");
					
					$("#maxSavePnt").removeClass("readonly");
					$("#maxSavePnt").prop('readonly', false);
					
					$("#aplStrtHr").removeClass("readonly");
					$("#aplStrtHr").prop('disabled', false);
					$("#aplStrtMn").removeClass("readonly");
					$("#aplStrtMn").prop('disabled', false);
					$("#aplEndHr").removeClass("readonly");
					$("#aplEndHr").prop('disabled', false);
					$("#aplEndMn").removeClass("readonly");
					$("#aplEndMn").prop('disabled', false);
					$("#unlimitEndDate").prop('disabled', false);
					$(".date_picker_box").css("pointer-events", "");
					
					var date = toDateObject(getCurrentTime());
					$("#aplStrtDt").val( toDateString(date, "-"));
					$("#aplStrtHr option:eq(0)").prop("selected", true);
					$("#aplStrtMn option:eq(0)").prop("selected", true);
					
					
					var txt = $(".btn_area_center>.btn.btn-ok").text();			
					
					//포인트 수정인 경우
					if(txt == "수정"){
	
						//포인트 프로모션 구분 
						$("#pntPrmtGbCd").prop('disabled', true);
						$("#pntPrmtGbCd").addClass("readonly");
						$("#pntPrmtGbCd").prop("readonly",true);
						
						//초과  사용율 설정하지 않은 경우 
						var useRate = "${pntInfo.useRate}";
						
						if(useRate == ''){
							$("#useRate").val('');
						}
						
						var YMDStr = "${pntInfo.aplStrtDtm}";
						var YMDEnd = "${pntInfo.aplEndDtm}";
						
						var YMDStr01 = new Date(YMDStr);
						var YMDEnd01 = new Date(YMDEnd);
						
						$("#aplStrtDt").val( toDateString(YMDStr01, "-"));
						$("#aplEndDt").val( toDateString(YMDEnd01, "-"));
						
						//시간
						var aplStrtHr = YMDStr.substring(11,13);
						var aplEndHr = YMDEnd.substring(11,13);
						
						//분
						var aplStrtMn = YMDStr.substring(14,16);
						var aplEndMn = YMDEnd.substring(14,16);
						
						$("#aplStrtHr option:eq("+aplStrtHr+")").prop("selected", true);
						$("#aplStrtMn option:eq("+aplStrtMn+")").prop("selected", true);
						$("#aplEndHr option:eq("+aplEndHr+")").prop("selected", true);
						$("#aplEndMn option:eq("+aplEndMn+")").prop("selected", true);
					}
					
				}else{
					<c:if test="${empty pntInfo}">
					$("#aplStrtDt").val('');
					$("#aplEndDt").val('');
					$("#aplStrtHr").val('');
					$("#aplStrtMn").val('');
					$("#aplEndHr").val('');
					$("#aplEndMn").val('');
					</c:if>
					
					$("#addSaveRate").val('');
					$("#maxSavePnt").val('');
					$("#useRate").val('');
					
					$("#aplStrtDt").addClass("readonly");
					$("#aplStrtDt").prop('readonly', true);
					
					$("#aplEndDt").addClass("readonly");
					$("#aplEndDt").prop('readonly', true);
					
					$("#addSaveRate").addClass("readonly");
					$("#addSaveRate").prop('readonly', true);
					
					
					$("#useRate").addClass("readonly");
					$("#useRate").prop('readonly', true);
					
					$("#maxSavePnt").addClass("readonly");
					$("#maxSavePnt").prop('readonly', true);
					
					$("#aplStrtHr").addClass("readonly");
					$("#aplStrtHr").prop('disabled', true);
					$("#aplStrtMn").addClass("readonly");
					$("#aplStrtMn").prop('disabled', true);
					$("#aplEndHr").addClass("readonly");
					$("#aplEndHr").prop('disabled', true);
					$("#aplEndMn").addClass("readonly");
					$("#aplEndMn").prop('disabled', true);
					$("#unlimitEndDate").prop('disabled', true);
					$(".date_picker_box").css("pointer-events", "none");
				}
			});

			// 종료일 미지정
			function checkUnlimitEndDate (obj, id) {
				var orgEndDt = $("#"+ id +"StrtDt").val();
				var orgEndHr = $("#"+ id +"StrtHr option:selected").val();
				var ordEndMn = $("#"+ id +"StrtMn option:selected").val();
				
				if($(obj).is(":checked")) {
					orgEndDt = $("#"+ id +"EndDt").val();
					orgEndHr = $("#"+ id +"EndHr option:selected").val();
					ordEndMn = $("#"+ id +"EndMn option:selected").val();

					$("#"+ id +"EndDt").val("9999-12-31");
					$("#"+ id +"EndHr").val("23");
					$("#"+ id +"EndMn").val("59");
				} else {
					$("#"+ id +"EndDt").val(orgEndDt);
					$("#"+ id +"EndHr").val(orgEndHr);
					$("#"+ id +"EndMn").val(ordEndMn);
				}
			}
			

			// 포인트 등록
			function insertPntInfo(){
				if(!valid()) return;
				messager.confirm('<spring:message code="column.common.confirm.insert" />', function(r){
					if(r){
						var options = {
							url : "<spring:url value='/system/insertPntInfo.do' />"
							, data : $("#pntInfoForm").serializeJson()
							, callBack : function(result){
								
								messager.alert('<spring:message code="column.common.regist.final_msg" />', "Info", "info", function(){
									updateTab("/system/pntInfoListView.do", "포인트 관리");
								});
							}
						};

						ajax.call(options);
					}
				});
			}

			// 포인트 수정
			function updatePntInfo(){
				if(!valid()) return;
				
				messager.confirm('<spring:message code="column.common.confirm.update" />', function(r){
					if(r){
						var options = {
							url : "<spring:url value='/system/updatePntInfo.do' />"
							, data : $("#pntInfoForm").serializeJson()
							, callBack : function(result){
								messager.alert('<spring:message code="column.common.edit.final_msg" />', "Info", "info", function(){
									updateTab();
								});
							}
						};

						ajax.call(options);
					}
				});
			}

			function valid(){
				
				var isValid = true;
				
				if (!$("#pntTpCd option:selected").val()) {
					messager.alert("포인트 유형을 선택해 주세요.", "Info", "info");
					return false;
				}
				
				<c:if test="${empty pntInfo}">
				if($("#pntPrmtGbCd").val() == '${adminConstants.PNT_PRMT_GB_10}'){
					messager.alert("프로모션 구분 ‘일반’으로는 등록 불가합니다.", "Info", "info");
					return false;
				}
				</c:if>
				
				if (!$("#aplEndDt").val().trim()) {
					messager.alert("종료일자를 설정해 주세요.", "Info", "info");
					return false;
				}
				if (!$("#aplStrtDt").val().trim()) {
					messager.alert("시작일자를 설정해 주세요.", "Info", "info");
					return false;
				}
				
				var startDate = new Date(getPntInfoDateStr ("aplStrt"));
			    var endDate = new Date(getPntInfoDateStr ("aplEnd"));

			    if(startDate.getTime() >= endDate.getTime()) {
			        messager.alert("적용일시의 종료일보다 시작일이 작아야 합니다.", "Info", "info", function(){
				        $("#aplEndDt").focus();
			        });
			        return false;
			    }
			    $("#aplStrtDtm").val(getDateStr ("aplStrt"));
				$("#aplEndDtm").val(getDateStr ("aplEnd"));
				
				if ($("#addSaveRate").val().trim() && $("#addSaveRate").val() == 0) {
					messager.alert("포인트 추가 적립률은 0% 초과하여 입력해 주세요. (30% 적립 시, 20 입력)", "Info", "info");
					return false;
				}
				if (!$("#pntPrmtGbCd option:selected").val() || $("#pntPrmtGbCd option:selected").val() == undefined) {
					messager.alert("포인트 프로모션 구분을 선택해 주세요.", "Info", "info");
					return false;
				}
				if ($("#useRate").val().trim() && $("#useRate").val() == 0) {
					messager.alert("추가 사용률은 0% 초과하여 입력해 주세요. (120% 적립 시, 120 입력)", "Info", "info");
					return false;
				}
				if ($("#maxSavePnt").val().trim() && $("#maxSavePnt").val() == 0) {
					messager.alert("최대 적립 포인트 한도는 0을 초과하여 입력해 주세요.", "Info", "info");
					return false;
				}
			    
			   	if($("#pntPrmtGbCd").val() == '${adminConstants.PNT_PRMT_GB_20}'){
			   		if($("#addSaveRate").val().trim() && $("#useRate").val().trim()){
			   			messager.alert("부스트업과 적립프로모션을 동시에 설정할 수 없습니다. 추가 적립률, 사용률 중 하나만 입력 해주세요.", "Info", "info");
			   			return false;
			   		}	
			   	}
			    
			   //중복 체크
		    	var options = { 
					url : "<spring:url value='/system/getValidPntInfoCount.do' />"
					, data : $("#pntInfoForm").serializeJson()
					, async : false
					, callBack : function(result){
						if(result > 0){
							messager.alert("이미 등록 돼 있는 포인트 정보입니다. 포인트 유형, 프로모션 구분, 기간을 확인 해 주세요.", "Info", "info");
							isValid = false;
						}
					}
				};

				ajax.call(options);
			    	
				return isValid;
			}
			
			// 적용 일시 valid check
			function getPntInfoDateStr(objId) {
				if(typeof $("#"+objId+"Dt").val() != 'undefined') {
					date = $("#"+objId+"Dt").val();
				}

				if(typeof $("#"+objId+"Hr option:selected").val() != 'undefined') {
					date += " " + $("#"+objId+"Hr option:selected").val();
				}

				if(typeof $("#"+objId+"Mn option:selected").val() != 'undefined') {
					date += ":" + $("#"+objId+"Mn option:selected").val();
				}

				if(typeof $("#"+objId+"Sec").val() != 'undefined') {
					date += ":" + "00";
				}

				return date;
			}
			
			function isNumberKey(evt){
				var charCode = (evt.which) ? evt.which : event.keyCode;
		        // Textbox value       
		        var _value = event.srcElement.value;     

		        if (event.keyCode < 48 || event.keyCode > 57) { 
		            if (event.keyCode != 46) { //숫자와 . 만 입력가능하도록함
		                return false; 
		            } 
		        } 

		        // 소수점(.)이 두번 이상 나오지 못하게
		        var _pattern0 = /^\d*[.]\d*$/; // 현재 value값에 소수점(.) 이 있으면 . 입력불가
		        if (_pattern0.test(_value)) {
		            if (charCode == 46) {
		                return false;
		            }
		        }
		        
		        return true;
			}
		</script>
	</t:putAttribute>
	<t:putAttribute name="content">

		<form name="pntInfoForm" id="pntInfoForm" method="post">
		
		<input id="pntNo" name="pntNo" type="hidden" value="${pntInfo.pntNo }" />
		<input id="aplStrtDtm" name="aplStrtDtm" type="hidden" value="${pntInfo.aplStrtDtm }" />
		<input id="aplEndDtm" name="aplEndDtm" type="hidden" value="${pntInfo.aplEndDtm }" />
		<table class="table_type1">
			<caption>포인트 관리 등록</caption>
			<colgroup>
				<col style="width:140px;"/>
				<col/>
				<col style="width:140px;"/>
				<col style="width:37%;"/>
			</colgroup>
			<tbody>
				<tr>
					<!-- 포인트 유형 -->
					<th><spring:message code="column.pnt_info.pnt_tp" /><strong class="red">*</strong></th>
					<td>
						<select name="pntTpCd" id="pntTpCd" title="<spring:message code="column.pnt_info.pnt_tp"/>" class="${not empty pntInfo.pntNo ? 'readonly' : '' }" ${not empty pntInfo.pntNo ? 'disabled' : '' }>
							<frame:select grpCd="${adminConstants.PNT_TP}" selectKey="${pntInfo.pntTpCd}" defaultName="선택"/>
						</select>
					</td>
					<!-- 적립률 -->
					<th><spring:message code="column.pnt_info.save_rate" /><strong class="red">*</strong></th>
					<td>
						<input type="text" class="right readonly" name="saveRate" id="saveRate" title="<spring:message code="column.pnt_info.save_rate"/>" value="${saveRate}" maxlength="5" readonly="readonly" onkeyup="return isNumberKey(event)" onkeypress="return isNumberKey(event)"/>
						<span> %</span>
					</td>
				</tr>
				<tr>
					<!-- 적용 일시 -->
					<th><spring:message code="column.pnt_info.apl_dtm" /><strong class="red">*</strong></th>
					<td>
						<frame:datepicker startDate="aplStrtDt"
										  startHour="aplStrtHr"
										  startMin="aplStrtMn"
										  startSec="aplStrtSec"
										  startValue="${empty pntInfo.aplStrtDtm ? frame:toDate('yyyy-MM-dd 00:00:00') : pntInfo.aplStrtDtm }"
										  endDate="aplEndDt"
										  endHour="aplEndHr"
										  endMin="aplEndMn"
										  endSec="aplEndSec"
										  endValue="${empty pntInfo.aplEndDtm ? frame:toDate('yyyy-MM-dd 00:00:00') : pntInfo.aplEndDtm }" />
						<label class="fCheck ml10"><input name="unlimitEndDate" id="unlimitEndDate" type="checkbox" onclick="checkUnlimitEndDate(this, 'apl' );" ><span>종료일 미지정</span></label>
					</td>
					<!-- 추가 적립률 -->
					<th><spring:message code="column.pnt_info.add_save_rate" /></th>
					<td>
						<fmt:parseNumber var="addSaveRate" integerOnly="true"  value="${pntInfo.addSaveRate }"/>
						<input type="text" class="right comma numeric" name="addSaveRate" id="addSaveRate" title="<spring:message code="column.pnt_info.save_rate"/>" value="${addSaveRate}" maxlength="5"/>
						<span> %</span>
						<br>
						<span style="color: blue;">추가 적립률만 입력해 주세요.(30%시, 20입력)</span>
					</td>
				</tr>
				<tr>
					<!-- 포인트 프로모션 구분 -->
					<th><spring:message code="column.pnt_info.pnt_prmt_gb" /></th>
					<td>
						<select name="pntPrmtGbCd" id="pntPrmtGbCd" title="<spring:message code="column.pnt_info.pnt_prmt_gb"/>" class="${not empty pntInfo.pntNo ? 'readonly' : '' }" ${not empty pntInfo.pntNo ? 'disabled' : '' }>
							<frame:select grpCd="${adminConstants.PNT_PRMT_GB}" selectKey="${pntInfo.pntPrmtGbCd}"/>
						</select>
					</td>
					<!-- 추가 사용율 -->
					<th><spring:message code="column.pnt_info.use_rate" /></th>
					<td>
						<fmt:parseNumber var="useRate" integerOnly="true"  value="${pntInfo.useRate }"/>
						<input type="text" class="right comma numeric" name="useRate" id="useRate" title="<spring:message code="column.pnt_info.save_rate"/>" value="${useRate}" maxlength="5"/>
						<span> %</span>
						<br>
						<span style="color: blue;">추가 사용률만 입력해 주세요.(120%시, 120입력)</span>
					</td>
				</tr>
				<tr>
					<!-- 상품 코드 -->
					<th><spring:message code="column.pnt_info.goods_cd" /></th>
					<td>
						<input type="text" class="readonly" name="ifGoodsCd" id="ifGoodsCd" title="<spring:message code="column.pnt_info.goods_cd"/>" readonly="readonly" value="${pntInfo.ifGoodsCd}" maxlength="10"/>
					</td>
					<!-- 최대 적립 포인트 -->
					<th><spring:message code="column.pnt_info.max_save_pnt" /></th>
					<td>
						<input type="text" class="right comma numeric" name="maxSavePnt" id="maxSavePnt" title="<spring:message code="column.pnt_info.max_save_pnt"/>" value="${pntInfo.maxSavePnt}" maxlength="10"/>
					</td>
				</tr>
				<tr>
					<!-- 사용 여부 -->
					<th><spring:message code="column.use_yn"/><strong class="red">*</strong></th>
					<td>
						<frame:radio name="useYn" grpCd="${adminConstants.COMM_YN}" selectKey="${pntInfo.useYn}" required="true" />
					</td>
					<!-- 대체 상품 코드 -->
					<th><spring:message code="column.pnt_info.alt_goods_cd" /></th>
					<td>
						<input type="text" class="readonly" name="altIfGoodsCd" id="altIfGoodsCd" title="<spring:message code="column.pnt_info.alt_goods_cd"/>" readonly="readonly" value="${pntInfo.altIfGoodsCd}" maxlength="10"/>
					</td>
				</tr>
			</tbody>
		</table>
		</form>

		<div class="btn_area_center">
			<c:choose>
				<c:when test="${empty pntInfo.pntNo}">
					<button type="button" onclick="insertPntInfo();" class="btn btn-ok">등록</button>
					<button type="button" onclick="closeTab();" class="btn btn-cancel">취소</button>
				</c:when>
				<c:otherwise>
					<button type="button" onclick="updatePntInfo();" class="btn btn-ok">수정</button>
					<button type="button" onclick="closeTab();" class="btn btn-cancel">닫기</button>
				</c:otherwise>
			</c:choose>
		</div>
	</t:putAttribute>
</t:insertDefinition>
