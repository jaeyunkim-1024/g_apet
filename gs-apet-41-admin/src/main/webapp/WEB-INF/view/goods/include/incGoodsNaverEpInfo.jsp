<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<script type="text/javascript">
$(document).ready(function() {
	fnControlNaverEpUI($("[name='sndYn']:checked").val());
	if("${adminConstants.GOODS_CSTRT_TP_ITEM}" === $("[name='goodsCstrtTpCd']").val() || "${adminConstants.GOODS_CSTRT_TP_SET}" === $("[name='goodsCstrtTpCd']").val()){
		textlengthCheck('naverCtgId', 8);
		textlengthCheck('prcCmprPageId', 50);
	}
})
// 글자수 체크
function textlengthCheck(targetId, limitLength){
	var conts = document.getElementById(targetId);
	var bytes = document.getElementById(targetId +"Byte");
	var cnt = conts.value.length;
	
	bytes.innerHTML = cnt;
	
	if ( cnt > limitLength ) {
		$("#"+targetId).val($("#"+targetId).val().substring(0,limitLength));
		bytes.innerHTML = limitLength;
	}
}

// 파트너 존 이동
function goPartnerZone(){
	window.open('https://center.shopping.naver.com');
}

function fnControlNaverEpUI(value){
	if(value === '${adminConstants.COMM_YN_Y}'){
		$("#naverEpInfo input").not("[name='sndYn']").prop('disabled', false);
		$("#naverEpInfo select").prop('disabled', false);
	}else{
		$("#naverEpInfo input").not("[name='sndYn']").prop('disabled', true);
		$("#naverEpInfo input").not("[name='sndYn']").val('');
		$("#naverEpInfo select").val('');
		$("#naverEpInfo input[type='radio']").not("[name='sndYn']").eq(0).prop('checked', true);
		$("#naverEpInfo select").prop('disabled', true);
	}
}

// 네이버 ep 정보 노출/미노출 제어
$(function(){
	// 단품, 세트 상품일 경우 UI 제어
	if("${adminConstants.GOODS_CSTRT_TP_ITEM}" === $("[name='goodsCstrtTpCd']").val() || "${adminConstants.GOODS_CSTRT_TP_SET}" === $("[name='goodsCstrtTpCd']").val()){
		$("[name='sndYn']").change(function(){
			fnControlNaverEpUI($(this).val());
		})
	}
})
</script>
	<div title="<spring:message code="column.goods.naverEpInfo" />" id="naverEpInfo" data-options="" style="padding:10px">
		<table class="table_type1">
			<caption><spring:message code="column.goods.naverEpInfo" /></caption>
			<tbody>
				<c:choose>
					<c:when test="${adminConstants.GOODS_CSTRT_TP_ATTR eq goodsCstrtTpCd || adminConstants.GOODS_CSTRT_TP_PAK eq goodsCstrtTpCd}" >
						<tr>
							<th><spring:message code="column.goods.naverEpInfo.sndYn" /></th>
							<td>
								<frame:radio name="sndYn" grpCd="${adminConstants.SHOW_YN }" selectKey="${goodsNaverEpInfoVO.sndYn eq null ? adminConstants.SHOW_YN_Y : goodsNaverEpInfoVO.sndYn}" />
							</td>
						</tr>
					</c:when>
					<c:otherwise>
						<tr>
							<th><spring:message code="column.goods.naverEpInfo.sndYn" /></th>
							<td>
								<frame:radio name="sndYn" grpCd="${adminConstants.SHOW_YN }" selectKey="${goodsNaverEpInfoVO.sndYn eq null ? adminConstants.SHOW_YN_Y : goodsNaverEpInfoVO.sndYn}" />
							</td>
							<th><spring:message code="column.goods.naverEpInfo.goodsSrcCd" /></th>
							<td>
								<select class="" name="goodsSrcCd" title="<spring:message code="column.goods.naverEpInfo.goodsSrcCd" />">
									<frame:select grpCd="${adminConstants.GOODS_SRC }" selectKey="${goodsNaverEpInfoVO.goodsSrcCd}"/>
								</select>
							</td>
						</tr>
						<tr>
							<th><spring:message code="column.goods.naverEpInfo.saleTpCd" /></th>
							<td>
								<select class="" name="saleTpCd" title="<spring:message code="column.goods.naverEpInfo.saleTpCd" />">
									<frame:select grpCd="${adminConstants.SALE_TP }" selectKey="${goodsNaverEpInfoVO.saleTpCd}" />
								</select>
							</td>
							<th><spring:message code="column.goods.naverEpInfo.stpUseAgeCd" /></th>
							<td>
								<frame:radio name="stpUseAgeCd" grpCd="${adminConstants.STP_USE_AGE}" selectKey="${goodsNaverEpInfoVO.stpUseAgeCd eq null ? adminConstants.STP_USE_AGE_ALL : goodsNaverEpInfoVO.stpUseAgeCd}" />
							</td>
						</tr>
						<tr>
							<th><spring:message code="column.goods.naverEpInfo.stpUseGdCd" /></th>
							<td colspan="3">
								<select class="" name="stpUseGdCd" title="<spring:message code="column.goods.naverEpInfo.stpUseGdCd" />">
									<frame:select grpCd="${adminConstants.STP_USE_GD }" selectKey="${goodsNaverEpInfoVO.stpUseGdCd}" />
								</select>
							</td>
						</tr>			
						<tr>
							<th scope="row"><spring:message code="column.goods.naverEpInfo.srchTag" /></th>
							<td colspan="3">
								<input type="text" class="w800 validate[maxSize[200]]" name="srchTag" title="<spring:message code="column.goods.naverEpInfo.srchTag" />" value="${goodsNaverEpInfoVO.srchTag }" />
								<p><spring:message code="column.goods.naverEpInfo.srchTag.desc1" /></p>
								<p><spring:message code="column.goods.naverEpInfo.srchTag.desc2" /></p>
							</td>
						</tr>
						<tr>
							<th><spring:message code="column.goods.naverEpInfo.naverCtgId" /></th>
							<td>
								<input type="text" class="w300 validate[maxSize[20]]" name="naverCtgId" id="naverCtgId" onkeyup="textlengthCheck('naverCtgId', 8);" title="<spring:message code="column.goods.naverEpInfo.naverCtgId" />" value="${goodsNaverEpInfoVO.naverCtgId }" />
								<spring:message code="column.column_msgByte" />
								<span>
									<span id="naverCtgIdByte" class="red-desc" >0</span> / 8
								</span>
								<p><spring:message code="column.goods.naverEpInfo.naverCtgId.desc1" /></p>
								<p><spring:message code="column.goods.naverEpInfo.naverCtgId.desc2" /></p>
							</td>
							<th><spring:message code="column.goods.naverEpInfo.prcCmprPageId" /></th>
							<td>
								<input type="text" class="w300 validate[maxSize[50]]" name="prcCmprPageId" id="prcCmprPageId" onkeyup="textlengthCheck('prcCmprPageId', 50);" title="<spring:message code="column.goods.naverEpInfo.prcCmprPageId" />" value="${goodsNaverEpInfoVO.prcCmprPageId }" />
								<spring:message code="column.column_msgByte" />
								<span>
									<span id="prcCmprPageIdByte" class="red-desc" >0</span> / 50
								</span>
								<p><spring:message code="column.goods.naverEpInfo.prcCmprPageId.desc1" /></p>
								<p><spring:message code="column.goods.naverEpInfo.prcCmprPageId.desc2" /></p>
							</td>
						</tr>
					</c:otherwise>
				</c:choose>	
			</tbody>
		</table>
	</div>
	<hr />