<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">
			$(document).on("keyup", "#msg", function(e) {
				byteCheck("msg", "msgByte");
			});

			// 전시 코너 아이템 리스트(상품평) 추가 Layer 기간 변경
			function searchDateChange () {
				var term = $("#checkOptDate").val();
				if(term == "" ) {
					$("#start").val("" );
					$("#end").val("" );
				} else {
					setSearchDate(term, "start", "end" );
				}
			}
		</script>
	</t:putAttribute>
	<t:putAttribute name="content">

		<div class="mTitle gTitle">
			<h2>전체 SMS 발송</h2>
		</div>

		<form name="memberForm" id="memberForm" method="post">
			<table class="table_type1">
				<caption>정보 검색</caption>
				<tbody>
					<tr>
						<th>가입일자</th>
						<td>
							<frame:datepicker startDate="start" endDate="end" startValue="${adminConstants.COMMON_START_DATE }" />
							&nbsp;&nbsp;
							<select id="checkOptDate" name="checkOptDate" onchange="searchDateChange();">
								<frame:select grpCd="${adminConstants.SELECT_PERIOD }" defaultName="기간선택" />
							</select>
						</td>
						<th><spring:message code="column.mbr_grd_cd"/></th>
						<td>
							<!-- 회원 등급 코드-->
							<select class="wth100" name="mbrGrdCd" id="mbrGrdCd" title="<spring:message code="column.mbr_grd_cd"/>">
								<frame:select grpCd="${adminConstants.MBR_GRD}" defaultName="전체" />
							</select>
						</td>
					</tr>
					<tr>
						<th>성별</th>
						<td>
							<select name="gdGbCd" id="gdGbCd" title="<spring:message code="column.gd_gb_cd"/>">
								<frame:select grpCd="${adminConstants.GD_GB}" defaultName="전체" />
							</select>
						</td>
						<th>구매금액</th>
						<td>
							<input type="text" class="w100" name="" id="" title="" value="" /> ~ <input type="text" class="w100" name="" id="" title="" value="" />
						</td>
					</tr>
					<tr>
						<th>적립금</th>
						<td>
							<input type="text" class="w100" name="" id="" title="" value="" /> ~ <input type="text" class="w100" name="" id="" title="" value="" />
						</td>
						<th>나이</th>
						<td>
							<input type="text" class="w100" name="" id="" title="" value="" /> ~ <input type="text" class="w100" name="" id="" title="" value="" />
						</td>
					</tr>
				</tbody>
			</table>
		
			<table class="table_type1 mt30">
				<caption>회원 등급 일괄 변경</caption>
				<tbody>
					<tr>
						<th scope="row"><spring:message code="column.content" /><strong class="red">*</strong></th>
						<td>
							<textarea class="validate[required]" style="width:98%" name="msg" id="msg" title="<spring:message code="column.content"/>" cols="50" rows="20"></textarea>
							<div>
								<span id="msgByte">0</span> / 80 Byte
							</div>
						</td>
					</tr>
					<tr>
						<th scope="row"><spring:message code="column.snd_no" /></th>
						<td>
							<input type="text" class="phoneNumber validate[custom[mobile]]" name="sndNo" id="sndNo" title="<spring:message code="column.snd_no"/>" value="" maxlength="20"/>
						</td>
					</tr>
				</tbody>
			</table>
		</form>

		<div class="btn_area_center">
			<button type="button" onclick="memberUpdate();" class="btn btn-ok">발송</button>
			<button type="button" onclick="closeTab();" class="btn btn-cancel">닫기</button>
		</div>
	</t:putAttribute>
</t:insertDefinition>
