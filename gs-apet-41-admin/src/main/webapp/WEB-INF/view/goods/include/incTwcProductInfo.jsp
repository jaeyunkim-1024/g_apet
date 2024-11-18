<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>

<script type="text/javascript">
</script>
		<div title="<spring:message code="column.goods.twc.productNutrition" />" data-options="" style="padding:10px">
			<table class="table_type1" id='igdtInfoLnkYn_table'>
				<caption>GOODS 등록</caption>
				<tbody>
					<tr>
						<th><spring:message code="column.goods.twc.igdtInfoLnkYn" /></th>	<!-- 성분 정보 변동 여부 -->
						<td colspan="3">
							<label class="fCheck">
								<input type="checkbox" name="igdtInfoLnkYn" id="igdtInfoLnkYnY" value="${adminConstants.COMM_YN_Y}"
								 ${goodsBase.igdtInfoLnkYn eq adminConstants.COMM_YN_Y ? 'checked="checked"' : ''} ${fstGoodsYn eq 'true' ? 'disabled' : '' }  >
								<span id="span_>igdtInfoLnkYnY"><spring:message code="column.goods.twc.igdtInfoLnk" /></span>
							</label>
						</td>
					</tr>
				</tbody>
			</table>
			<hr />	
			<table class="table_type1">
				<caption><spring:message code="column.goods.twc.productNutrition" /></caption>
				<tbody>
					<tr>
						<th><spring:message code="column.goods.twc.crudeProtein" /></th>	<!-- -->
						<td>
							<input type="text" class="w400 readonly" readonly value="${twcProductNutritionVO.crudeProtein}" />
						</td>
						<th><spring:message code="column.goods.twc.dryMatterCrudeProtein" /></th>	<!--  -->
						<td>
							<input type="text" class="w400 readonly" readonly value="${twcProductNutritionVO.dryMatterCrudeProtein}" />
						</td>
					</tr>
					<tr>
						<th><spring:message code="column.goods.twc.crudeFat" /></th>
						<td>
							<input type="text" class="w400 readonly" readonly value="${twcProductNutritionVO.crudeFat}" />
						</td>
						<th><spring:message code="column.goods.twc.dryMatterCrudeFat" /></th>
						<td>
							<input type="text" class="w400 readonly" readonly value="${twcProductNutritionVO.dryMatterCrudeFat}" />
						</td>
					</tr>
					<tr>
						<th><spring:message code="column.goods.twc.crudeFiber" /></th>
						<td>
							<input type="text" class="w400 readonly" readonly value="${twcProductNutritionVO.crudeFiber}" />
						</td>
						<th><spring:message code="column.goods.twc.dryMatterCrudeFiber" /></th>
						<td>
							<input type="text" class="w400 readonly" readonly value="${twcProductNutritionVO.dryMatterCrudeFiber}" />
						</td>
					</tr>
					<tr>
						<th><spring:message code="column.goods.twc.ash" /></th>
						<td>
							<input type="text" class="w400 readonly" readonly value="${twcProductNutritionVO.ash}" />
						</td>
						<th><spring:message code="column.goods.twc.dryMatterAsh" /></th>
						<td>
							<input type="text" class="w400 readonly" readonly value="${twcProductNutritionVO.dryMatterAsh}" />
						</td>
					</tr>
					<tr>
						<th><spring:message code="column.goods.twc.calcium" /></th>
						<td>
							<input type="text" class="w400 readonly" readonly value="${twcProductNutritionVO.calcium}" />
						</td>
						<th><spring:message code="column.goods.twc.dryMatterCalcium" /></th>
						<td>
							<input type="text" class="w400 readonly" readonly value="${twcProductNutritionVO.dryMatterCalcium}" />
						</td>
					</tr>
					<tr>
						<th><spring:message code="column.goods.twc.phosphorus" /></th>
						<td>
							<input type="text" class="w400 readonly" readonly value="${twcProductNutritionVO.phosphorus}" />
						</td>
						<th><spring:message code="column.goods.twc.dryMatterPhosphorus" /></th>
						<td>
							<input type="text" class="w400 readonly" readonly value="${twcProductNutritionVO.dryMatterPhosphorus}" />
						</td>
					</tr>
					<tr>
						<th><spring:message code="column.goods.twc.omega3" /></th>
						<td>
							<input type="text" class="w400 readonly" readonly value="${twcProductNutritionVO.omega3}" />
						</td>
						<th><spring:message code="column.goods.twc.dryMatterOmega3" /></th>
						<td>
							<input type="text" class="w400 readonly" readonly value="${twcProductNutritionVO.dryMatterOmega3}" />
						</td>
					</tr>
					<tr>
						<th><spring:message code="column.goods.twc.omega6" /></th>
						<td>
							<input type="text" class="w400 readonly" readonly value="${twcProductNutritionVO.omega6}" />
						</td>
						<th><spring:message code="column.goods.twc.dryMatterOmega6" /></th>
						<td>
							<input type="text" class="w400 readonly" readonly value="${twcProductNutritionVO.dryMatterOmega6}" />
						</td>
					</tr>
					<tr>
						<th><spring:message code="column.goods.twc.moisture" /></th>
						<td>
							<input type="text" class="w400 readonly" readonly value="${twcProductNutritionVO.moisture}" />
						</td>
						<th><spring:message code="column.goods.twc.carbohydrate" /></th>
						<td>
							<input type="text" class="w400 readonly" readonly value="${twcProductNutritionVO.carbohydrate}" />
						</td>
					</tr>
					<tr>
						<th><spring:message code="column.goods.twc.other" /></th>
						<td>
							<input type="text" class="w400 readonly" readonly value="${twcProductNutritionVO.other}" />
						</td>
						<th><spring:message code="column.goods.twc.aafco" /></th>
						<td>
							${twcProductVO.aafco}
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<hr />
		<div title="<spring:message code="column.goods.twc.material" />" data-options="" style="padding:10px">	
			<table class="table_type1">
				<caption><spring:message code="column.goods.twc.material" /></caption>
				<tbody>
					<tr>
						<th><spring:message code="column.goods.twc.material" /></th>	<!-- 주원료 (원료구성) -->
						<td colspan="3">
							<textarea class="readonly" id="content_material" readonly cols="30" rows="10" style="width: 95%">${twcProductVO.material }</textarea>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<hr />
		<div title="<spring:message code="column.goods.twc.twcProduct.info" />" data-options="" style="padding:10px">	
			<table class="table_type1">
				<caption><spring:message code="column.goods.twc.twcProduct.info" /></caption>
				<tbody>
					<tr>
						<th><spring:message code="column.goods.twc.packagingType" /></th>
						<td>
							<input type="text" class="w400 readonly" readonly value="${twcProductVO.packagingType}" />
						</td>
						<th><spring:message code="column.goods.twc.innerPacking" /></th>
						<td>
							<input type="text" class="w400 readonly" readonly value="${twcProductVO.innerPacking}" />
						</td>
					</tr>
					<tr>
						<th><spring:message code="column.goods.twc.type" /></th>
						<td>
							<input type="text" class="w400 readonly" readonly value="${twcProductVO.type}" />
						</td>
						<th><spring:message code="column.goods.twc.recommendAge" /></th>
						<td>
							<input type="text" class="w400 readonly" readonly value="${twcProductVO.recommendAge}" />
						</td>
					</tr>
					<tr>
						<th><spring:message code="column.goods.twc.manufacturer" /></th>
						<td>
							<input type="text" class="w400 readonly" readonly value="${twcProductVO.manufacturer}" />
						</td>
						<th><spring:message code="column.goods.twc.importer" /></th>
						<td>
							<input type="text" class="w400 readonly" readonly value="${twcProductVO.importer}" />
						</td>
					</tr>
					<tr>
						<th><spring:message code="column.goods.twc.countryOfOrigin" /></th>
						<td colspan="3">
							<input type="text" class="w400 readonly" readonly value="${twcProductVO.countryOfOrigin}" />
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<hr />