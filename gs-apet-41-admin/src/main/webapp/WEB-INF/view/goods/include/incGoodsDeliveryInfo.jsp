<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>

<script type="text/javascript">
</script>
		<div title="배송 정보" data-options="" style="padding:10px">
			<table class="table_type1">
				<caption>GOODS 등록</caption>
				<tbody>
					<tr>
						<th><spring:message code="column.dlvrc_plc_no" /><strong class="red">*</strong></th>	<!-- 배송 정책 번호 -->
						<td id='dlvrcPlcNo_td'>
							<select class="w200 validate[required]" name="dlvrcPlcNo" id="dlvrcPlcNo" title="<spring:message code="column.dlvrc_plc_no" />">
								<c:if test="${dlvrPlcList ne null and fn:length (dlvrPlcList) ge 0 }">
									<c:forEach items="${dlvrPlcList }" var="dlvr" >
										<option value="${dlvr.dlvrcPlcNo }" <c:if test="${dlvr.dlvrcPlcNo eq goodsBase.dlvrcPlcNo }"><c:out value=" selected='selected'" escapeXml="false" /></c:if> >${dlvr.dlvrcPlcNo }.${dlvr.plcNm }</option>
									</c:forEach>
								</c:if>
							</select>
							&nbsp;<!-- span id="plcNm" >정책내용 표시</span-->
						</td>
						<th id='freeDlvrYnY_th'><spring:message code="column.free_dlvr_yn" /></th>	<!-- 무료배송 여부 -->
						<td id='freeDlvrYnY_td'>
							<frame:radio name="freeDlvrYn" grpCd="${adminConstants.SHOW_YN }" selectKey="${goodsBase.freeDlvrYn eq null ? adminConstants.COMM_YN_N : goodsBase.freeDlvrYn }" />
						</td>
					</tr>
					<tr>
						<th id='rtnPsbYn_th'><spring:message code="column.rtn_psb_yn" /></th>	<!-- 반품 가능 여부 -->
						<td id='rtnPsbYn_td'>
							<frame:radio name="rtnPsbYn" grpCd="${adminConstants.COMM_YN }" selectKey="${goodsBase.rtnPsbYn eq null ? adminConstants.COMM_YN_Y : goodsBase.rtnPsbYn }" />
						</td>
						<th><spring:message code="column.goods.seo" /></th>	<!-- SEO 번호 -->
						<td>
							<input type="text" class="w300 readonly" name="seoInfoNo" id="seoInfoNo" readonly value="${goodsBase.seoInfoNo}" title="<spring:message code="column.goods.seo" />" placeholder="<spring:message code='column.goods.select.seo' />" />
							<button type="button" onclick="javascript:fnGoodsSeoInfoPop();" class="btn"><spring:message code="admin.web.view.common.search"/></button>
						</td>
					</tr>
					<tr>
						<th id='stkQtyShowYn_th'><spring:message code="column.goods.stkQtyShowYn" /></th>	<!-- 재고 수량 노출 여부 -->
						<td id='stkQtyShowYn_td'>
							<frame:radio name="stkQtyShowYn" grpCd="${adminConstants.COMM_YN }" selectKey="${goodsBase.stkQtyShowYn eq null ? adminConstants.COMM_YN_Y : goodsBase.stkQtyShowYn }" />
						</td>
						<th id='ioAlmYn_th'><spring:message code="column.goods.ioAlmYn" /></th>	<!-- 재입고 알림 여부 -->
						<td id='ioAlmYn_td'>
							<frame:radio name="ioAlmYn" grpCd="${adminConstants.COMM_YN }" selectKey="${goodsBase.ioAlmYn eq null ? adminConstants.COMM_YN_Y : goodsBase.ioAlmYn }" />
						</td>
					</tr>
					<tr>		
						<th><spring:message code="column.goods.ostkGoodsShowYn" /></th>	<!-- 품절 상품 노출 여부 -->
						<td colspan="3">
							<frame:radio name="ostkGoodsShowYn" grpCd="${adminConstants.COMM_YN }" selectKey="${goodsBase.ostkGoodsShowYn eq null ? adminConstants.COMM_YN_Y : goodsBase.ostkGoodsShowYn }" />
						</td>
					</tr>
				</tbody>
			</table>
			<c:if test="${adminConstants.GOODS_CSTRT_TP_ITEM eq goodsCstrtTpCd}" >
				<hr />	
				<table class="table_type1">
					<caption>GOODS 등록</caption>
					<tbody>
						<tr>
							<th><spring:message code="column.goods.ordmkiYn" /></th>	<!-- 주문제작여부 -->
							<td colspan="3">
								<frame:checkbox name="ordmkiYn" grpCd="${adminConstants.ORDMKI_YN }" checkedArray="${goodsBase.ordmkiYn}" excludeOption="${adminConstants.ORDMKI_YN_N }" />
							</td>
						</tr>
					</tbody>
				</table>
			</c:if>		
		</div>
		<hr />