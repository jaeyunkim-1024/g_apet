<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>

					<form id="counselOrderInfoForm">
						<input type="hidden" name="mbrNo" id="counselOrderInfoMbrNo" value="" />
						<input type="hidden" name="noSearch" id="counselOrderInfoNoSearch" value="Y" />
						<input type="hidden" name="stId" id="counselOrderInfoStId" value="" />
						<input type="hidden" name="ordAcptDtmStart" id="counselOrderInfoOrdAcptDtmStart" value="" />
						<input type="hidden" name="ordAcptDtmEnd" id="counselOrderInfoOrdAcptDtmEnd" value="" />
						<input type="hidden" name="ordNm" id="counselOrderInfoOrdNm" value="" />
						<input type="hidden" name="ordrTel" id="counselOrderInfoOrdrTel" value="" />
						<input type="hidden" name="ordrMobile" id="counselOrderInfoOrdrMobile" value="" />
				
						<table class="table_type1 border_top_none">
							<caption>주문 검색</caption>
							<colgroup>
								<col style="width:120px;">
								<col />
								<col style="width:120px;">
								<col />
								<col style="width:130x;">
							</colgroup>
							<tbody>
								<tr>
									<th><spring:message code="column.ord_no" /></th>
									<td>
										<input type="text" name="ordNo" id="counselOrderInfoOrdNo" class="counselOrderInfo" value="" />
									</td>
									<th><spring:message code="column.goods_nm" /></th>
									<td>
										<input type="text" name="goodsNm" id="counselOrderInfoGoodsNm" class="counselOrderInfo wthTa" value="" />
									</td>
									<td style="text-align:right">
										<button type="button" onclick="counselInfoOrder.reload();" class="btn">상세조회</button>
									</td>
									
								</tr>
							</tbody>
						</table>
					</form>
				
					<div class="mModule mt10">
						<table id="counselOrderInfoList"></table>
						<div id="counselOrderInfoListPage"></div>
					</div>