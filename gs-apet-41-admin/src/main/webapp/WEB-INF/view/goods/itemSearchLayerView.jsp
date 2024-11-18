<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>

<form id="itemListForm" name="itemListForm" method="post" >
				<table class="table_type1">
					<caption>정보 검색</caption>
					<tbody>
						<tr>
							<th scope="row"><spring:message code="column.common.date" /></th> <!-- 기간 -->
							<td>
								<frame:datepicker startDate="sysRegDtmStart" endDate="sysRegDtmEnd" startValue="${adminConstants.COMMON_START_DATE }" />
								&nbsp;&nbsp;
								<select id="checkOptDate" name="checkOptDate" onchange="searchDateChange();">
									<frame:select grpCd="${adminConstants.SELECT_PERIOD }" defaultName="기간선택" />
								</select>
							</td>
							<th scope="row"><spring:message code="column.goods_stat_cd" /></th>	<!-- 상품 상태 -->
							<td>
								<select id="goodsStatCd" name="goodsStatCd" >
									<frame:select grpCd="${adminConstants.GOODS_STAT }" defaultName="선택" showValue="true" />
								</select>
							</td>
						</tr>
						<tr>
							<th scope="row"><spring:message code="column.goods.comp_no" /></th> <!-- 업체번호 -->
							<td colspan="3">
								<frame:compNo funcNm="layerItemList.searchCompany" />
							</td>
						</tr>
						<tr>
							<th scope="row"><spring:message code="column.goods.brnd" /></th>	<!-- 브랜드/시리즈-->
							<td>
								<input type="hidden" id="bndNo" name="bndNo" title="<spring:message code="column.goods.brnd" />" value="" />
								<input type="text" class="readonly" id="bndNm" name="bndNm" title="<spring:message code="column.goods.brnd" />" value="" />
								<button type="button" class="btn" onclick="layerItemList.selectBrandSeries('brand');" >검색</button>
							</td>
							<th scope="row"><spring:message code="column.goods.series" /></th>	<!-- 브랜드/시리즈-->
							<td>
								<input type="hidden" id="seriesNo" name="seriesNo" title="<spring:message code="column.goods.series" />" value="" />
								<input type="text" class="readonly" id="seriesNm" name="seriesNm" title="<spring:message code="column.goods.series" />" value="" />
								<button type="button" class="btn" onclick="layerItemList.selectBrandSeries('series');" >검색</button>
							</td>
						</tr>
						<tr>
							<th scope="row"><spring:message code="column.goods_id" /></th> <!-- 상품 ID -->
							<td>
								<textarea rows="3" cols="30" id="goodsIdArea" name="goodsIdArea" ></textarea>
							</td>
							<th scope="row"><spring:message code="column.goods_nm" /></th> <!-- 상품 명 -->
							<td>
								<textarea rows="3" cols="30" id="goodsNmArea" name="goodsNmArea" ></textarea>
							</td>
						</tr>
						<tr>
							<th scope="row"><spring:message code="column.mdl_nm" /></th> <!-- 모델 명 -->
							<td>
								<textarea rows="3" cols="30" id="mdlNmArea" name="mdlNmArea" ></textarea>
							</td>
							<th scope="row"></th>
							<td>
							</td>
						</tr>

					</tbody>
				</table>
</form>
				<div class="btn_area_center">
					<button type="button" onclick="layerItemList.searchItemList();" class="btn btn-ok">검색</button>
					<button type="button" onclick="layerItemList.searchReset();" class="btn btn-cancl">초기화</button>
				</div>
				
				<div class="mModule">
					<table id="layerItemList" ></table>
					<div id="layerItemListPage"></div>
				</div>