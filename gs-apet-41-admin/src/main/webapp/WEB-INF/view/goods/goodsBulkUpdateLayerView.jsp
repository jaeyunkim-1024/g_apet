<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<form id="goodsBulkUpdateForm" name="goodsBulkUpdateForm" method="post" >
	<table class="table_type1">
		<caption><spring:message code="admin.web.view.app.goods.update"/></caption>
		<colgroup>
			<col class="th-s" />
			<col />
		</colgroup>
		<tbody>
<c:choose>
<c:when test="${goodsSO.goodsUpdateGb eq adminConstants.GOODS_BULK_UPDATE_STAT }">
		<tr>
			<!-- 상품 상태 -->
			<th scope="row"><spring:message code="column.goods_stat_cd" /></th>
			<td>
				<select id="goodsStatCd" name="goodsStatCd" >
					<option value="${adminConstants.GOODS_STAT_40 }" ><spring:message code="column.goods.stat.40"/></option>
					<option value="${adminConstants.GOODS_STAT_50 }" ><spring:message code="column.goods.stat.50"/></option>
					<option value="${adminConstants.GOODS_STAT_60 }" ><spring:message code="column.goods.stat.60"/></option>
				</select>
			</td>
		</tr>
</c:when>
<c:when test="${goodsSO.goodsUpdateGb eq adminConstants.GOODS_BULK_UPDATE_SHOW }">
		<tr>
			<!-- 노출여부 -->
			<th scope="row"><spring:message code="column.show_yn" /></th>
			<td>
				<select id="showYn" name="showYn" >
					<frame:select grpCd="${adminConstants.SHOW_YN }" showValue="true" />
				</select>
			</td>
		</tr>
</c:when>
<c:when test="${goodsSO.goodsUpdateGb eq adminConstants.GOODS_BULK_UPDATE_APPR }">
        <tr>
           <td colspan="2">
               <strong class="red-desc"><spring:message code="admin.web.view.app.goods.update.only.appr"/></strong>
           </td>
        </tr>
		<tr>
			<!-- 노출여부 -->
			<th scope="row"><spring:message code="column.goods_stat_cd" /></th>
			<td>
				<!-- 40 승인 -->
				<label class="fRadio"><input type="radio" name="goodsStatCd" id="goodsStatCd1" value="${adminConstants.GOODS_STAT_40 }" checked="checked" >
					<span><spring:message code="column.goods.stat.appr.40"/></span>
				</label>
				<!-- 30 승인거절 -->
				<label class="fRadio"><input type="radio" name="goodsStatCd" id="goodsStatCd2" value="${adminConstants.GOODS_STAT_30 }" >
					<span><spring:message code="column.goods.stat.30"/></span>
				</label>
			</td>
		</tr>
		<tr>
			<!-- 거절사유 -->
			<th scope="row"><spring:message code="column.goods_appr_reason" /></th>
			<td>
				<textarea name="bigo" id="bigo" cols="40" rows="3" ></textarea>
			</td>
		</tr>
</c:when>
<c:when test="${goodsSO.goodsUpdateGb eq adminConstants.GOODS_BULK_UPDATE_RATE }">
		<tr>
			<!-- 사이트 선택-->
			<th><spring:message code="column.st_nm"/> </th>
			<td>
				<spring:message code="column.site.select.placeholder" var="selectStPh"/>
				<select id="stIdComboCms" name="stIdCms">
                   <frame:stIdStSelect defaultName="${selectStPh}" />
				</select>
			</td>
		</tr>
		<tr>
			<!-- 수수료 율-->
           <th><spring:message code="column.cms_rate"/> </th>
           <td>
               <input type="text" class="w50 rateOnly validate[required, custom[onlyDecimal], max[100]]"
                      name="cmsRate" id="cmsRate" title="<spring:message code="column.cms_rate"/>" value="" />%
           </td>
		</tr>
</c:when>
<c:when test="${goodsSO.goodsUpdateGb eq adminConstants.GOODS_BULK_UPDATE_DEVICE }">
	<tr>
		<!-- 웹 모바일 구분 -->
		<th scope="row"><spring:message code="column.web_mobile_gb_cd" /></th>
		<td>
			<frame:radio name="webMobileGbCd" grpCd="${adminConstants.WEB_MOBILE_GB }" selectKey="${adminConstants.WEB_MOBILE_GB_00 } " excludeOption="${adminConstants.WEB_MOBILE_GB_30}"/>
		</td>
	</tr>
</c:when>
<c:when test="${goodsSO.goodsUpdateGb eq adminConstants.GOODS_BULK_UPDATE_PRICE }">
	<tr>
		<!-- 가격변경기간 -->
		<th>가격변경기간</th>
		<td>
			<frame:datepicker startDate="bulkPriceStdDt"
			                  startHour="bulkPriceStdHr"
			                  startMin="bulkPriceStdMn"
			                  startValue=""
			                  endDate="bulkPriceEndDt"
			                  endHour="bulkPriceEndHr"
			                  endMin="bulkPriceEndMn"
			                  endValue="${frame:addMin('yyyy-MM-dd HH:mm:ss', 30)}"
			/>
			<label class="fCheck ml10"><input name="unlimitEndDate" id="unlimitEndDate" type="checkbox" onclick="checkUnlimitEndDate(this );">
				<span><spring:message code="admin.web.view.app.goods.bulk.price.period.enddate.unlimit"/></span>
			</label>
		</td>
	</tr>
	<tr>
		<!-- 가격변경유형 -->
		<th>가격변경유형</th>
		<td>
			<frame:radio name="goodsAmtTpCd" grpCd="${adminConstants.GOODS_AMT_TP}" excludeOption="${adminConstants.GOODS_AMT_TP_30}" onClickYn="Y" funcNm="checkGoodsAmtTpCd(this)"/>
		</td>
	</tr>
	<tr id="trQty" style="display: none">
		<!-- 판매수량 사전예약상품일때만 -->
		<th>판매수량</th>
		<td>
			<input type="text" class="w50 numberOnly validate[required, custom[integer], max[100]]"
			       id="rsvBuyQty" name="rsvBuyQty" title="판매수량" />
		</td>
	</tr>
	<tr id="trExpDt" style="display: none">
		<!-- 표시유통기한 -->
		<th>표시유통기한</th>
		<td>
			<frame:datepicker startDate="expDt" startValue="" />
		</td>
	</tr>

	<script type="text/javascript">
		var defaultStart = '';
		var defaultEnd = '';

		var bulkPriceEndDt = $('#bulkPriceEndDt').val();
		var bulkPriceEndHr = $('#bulkPriceEndHr').val();
		var bulkPriceEndMn = $('#bulkPriceEndMn').val();
		
		$(function(){
			//[일괄변경][조건] 종료일 날짜 input box 활성화 여부 체크
// 			checkUnlimitEndDate();
			
			//[일괄변경][조건] 가격 시작일자, 종료일자 비교 체크
			//$('#bulkPriceStdDt, #bulkPriceEndDt').on('propertychange keyup input change paste ', function(e) {
			$('#bulkPriceStdDt, #bulkPriceEndDt').on('change', function(e) {
				var value = $(this).val().replace(/\s/gi,'');
				var id = $(this).attr('id');

				if(value != '' && value.length> 9) {
					if(!validateDateTime()) {
						if(id == 'bulkPriceStdDt') {
							$(this).val(defaultStart);
						}
						if(id == 'bulkPriceEndDt') {
							$(this).val(defaultEnd);
						}

						return false;
					} else {
						defaultStart = $('#bulkPriceStdDt').val();
						defaultEnd = $('#bulkPriceEndDt').val();
					}
				}
			});

			//[일괄변경][조건] 가격 시작일시, 종료일시 비교 체크
			$('#bulkPriceStdHr, #bulkPriceEndHr, #bulkPriceStdMn, #bulkPriceEndMn').on('change', function() {
				var value = $(this).val().replace(/\s/gi,'');
				if(value != '' && value.length == 2) {

					if(!validateDateTime()) {
						return false;
					}
				}
			});
			$('#trQty').hide(); // 사전예약 선택시 선택 가능 $('#saleQty').attr('disabled', 'true');
			$('#trExpDt').hide(); // 유통기한 임박일 경우만 선택 가능 $('#expDt').attr('disabled', 'true');
			$('#expDt').val('');

			/* 마감일 미지정 체크해제 */
			$(document).on("change","#bulkPriceEndDt, #bulkPriceEndHr, #bulkPriceEndMn",function(e){
				if($("input:checkbox[id='unlimitEndDate']").is(":checked")){
					var endDt = $("#bulkPriceEndDt").val();
					var endHr = $("#bulkPriceEndHr option:selected").val();
					var endMn = $("#bulkPriceEndMn option:selected").val();		
					if(endDt != "9999-12-31" || endHr != "23" || endMn != "59"){
						//종료일 미지정 체크 해제 unlimitSaleEndDate			
						$('input:checkbox[id="unlimitEndDate"]').attr("checked", false);			
					}
				}		
				
			});
		});

		/**
		 * [일괄변경][조건]
		 * 종료일 날짜 input box 활성화 여부 체크
		 * @param obj
		 *
		 *yyyy-mm-dd 포맷으로 반환
		 *
		 */
		function checkUnlimitEndDate() {
			var chkbox = $('#unlimitEndDate');
			if(chkbox.is(':checked')) {
				$('#bulkPriceEndDt').val('9999-12-31');
				$('#bulkPriceEndHr').val('23');
				$('#bulkPriceEndMn').val('59');

				//defaultStart = '9999-12-31';
  				defaultEnd = '9999-12-31';

			} else {
				$('#bulkPriceEndDt').val(bulkPriceEndDt);
				$('#bulkPriceEndHr').val(bulkPriceEndHr);
				$('#bulkPriceEndMn').val(bulkPriceEndMn);
			}
		}

		/**
		 * [일괄변경][조건]
		 * 일반 제외 종료일자 활성화, 종료일 미지정 체크박스 체크해제
		 * @param obj
		 */
		function checkGoodsAmtTpCd(obj) {

			$('#trQty').hide(); // 판매수량 // 사전예약일 경우에만 선택 가능 $('#saleQty').attr('disabled', 'true');
			$('#trExpDt').hide(); // 유통기한 // 유통기한 임박할인일 경우만 선택 가능 $('#expDt').attr('disabled', 'true');

			if($(obj).val()!="${adminConstants.GOODS_AMT_TP_10}") {

				//사전예약 상품
				if($(obj).val()=="${adminConstants.GOODS_AMT_TP_60}") {
					$('#saleQty').val('');
					$('#trQty').show(); // $('#saleQty').removeAttr('disabled');
				}
				//유통기한 임박할인
				if($(obj).val()=="${adminConstants.GOODS_AMT_TP_40}") {
					$('#expDt').val('');
					$('#trExpDt').show(); //$('#expDt').removeAttr('disabled');
				}

			} else {
				$('#unlimitEndDate').removeAttr('disabled');
			}
		}
	</script>
</c:when>
</c:choose>
		</tbody>
	</table>
</form>