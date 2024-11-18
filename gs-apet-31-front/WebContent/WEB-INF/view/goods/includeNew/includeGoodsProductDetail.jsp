<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>

<script type="text/javascript">
	/* console.log("성분 정보 변동 여부 : " + goods.igdtInfoLnkYn); */
</script>

<div class="gdtblset"><!-- @@ 03.03 .gdtblset 영양정보,상세정보 감싸기 -->
<c:if test="${not empty twcProductNutritionVO}">
	<div class="gdtbl a"> <%--성분 정보 변동 여부--%>
		<div class="gdthdt">영양정보</div>
		<table class="tblist a" cellpadding="0" cellspacing="0" summary="제품표기함량,수분제외함량 테이블">
			<caption>영양정보</caption>
			<colgroup>
				<col>
				<col>
				<col>
			</colgroup>
			<thead>
			<tr>
				<th></th>
				<th>제품표기함량</th>
				<th>수분제외함량</th>
			</tr>
			</thead>
			<tbody>
				<tr>
					<th>조단백질</th>
					<td>
						<c:set var="newNum" value=""/>
						<c:catch var="numberCheck">
							<fmt:parseNumber var="parsedNum" type="number" value="${twcProductNutritionVO.crudeProtein}" />
							<c:choose>
								<c:when test="${parsedNum < 0}"><c:set var="newNum" value="-"/></c:when>
								<c:otherwise><c:set var="newNum"><fmt:formatNumber type="number" pattern="###.##" value="${ ((parsedNum*100) - ((parsedNum*100)%1)) * (1/100) }" />%</c:set></c:otherwise>
							</c:choose>
						</c:catch>
						<c:choose>
							<c:when test="${numberCheck == null}"><c:out value="${newNum}"/></c:when>
							<c:otherwise><c:out value="${twcProductNutritionVO.crudeProtein}"/></c:otherwise>
						</c:choose>
					</td>
					<td>
						<c:catch var="numberCheck">
							<fmt:parseNumber var="parsedNum" type="number" value="${twcProductNutritionVO.dryMatterCrudeProtein}" />
							<c:choose>
								<c:when test="${parsedNum < 0}"><c:set var="newNum" value="-"/></c:when>
								<c:otherwise><c:set var="newNum"><fmt:formatNumber type="number" pattern="###.##" value="${ ((parsedNum*100) - ((parsedNum*100)%1)) * (1/100) }" />%</c:set></c:otherwise>
							</c:choose>
						</c:catch>
						<c:choose>
							<c:when test="${numberCheck == null}"><c:out value="${newNum}"/></c:when>
							<c:otherwise><c:out value="${twcProductNutritionVO.dryMatterCrudeProtein}"/></c:otherwise>
						</c:choose>
					</td>
				</tr>

				<tr>
					<th>조지방</th>
					<td>
						<c:catch var="numberCheck">
							<fmt:parseNumber var="parsedNum" type="number" value="${twcProductNutritionVO.crudeFat}" />
							<c:choose>
								<c:when test="${parsedNum < 0}"><c:set var="newNum" value="-"/></c:when>
								<c:otherwise><c:set var="newNum"><fmt:formatNumber type="number" pattern="###.##" value="${ ((parsedNum*100) - ((parsedNum*100)%1)) * (1/100) }" />%</c:set></c:otherwise>
							</c:choose>
						</c:catch>
						<c:choose>
							<c:when test="${numberCheck == null}"><c:out value="${newNum}"/></c:when>
							<c:otherwise><c:out value="${twcProductNutritionVO.crudeFat}"/></c:otherwise>
						</c:choose>
					</td>
					<td>
						<c:catch var="numberCheck">
							<fmt:parseNumber var="parsedNum" type="number" value="${twcProductNutritionVO.dryMatterCrudeFat}" />
							<c:choose>
								<c:when test="${parsedNum < 0}"><c:set var="newNum" value="-"/></c:when>
								<c:otherwise><c:set var="newNum"><fmt:formatNumber type="number" pattern="###.##" value="${ ((parsedNum*100) - ((parsedNum*100)%1)) * (1/100) }" />%</c:set></c:otherwise>
							</c:choose>
						</c:catch>
						<c:choose>
							<c:when test="${numberCheck == null}"><c:out value="${newNum}"/></c:when>
							<c:otherwise><c:out value="${twcProductNutritionVO.dryMatterCrudeFat}"/></c:otherwise>
						</c:choose>
					</td>
				</tr>

				<tr>
					<th>조섬유질</th>
					<td>
						<c:catch var="numberCheck">
							<fmt:parseNumber var="parsedNum" type="number" value="${twcProductNutritionVO.crudeFiber}" />
							<c:choose>
								<c:when test="${parsedNum < 0}"><c:set var="newNum" value="-"/></c:when>
								<c:otherwise><c:set var="newNum"><fmt:formatNumber type="number" pattern="###.##" value="${ ((parsedNum*100) - ((parsedNum*100)%1)) * (1/100) }" />%</c:set></c:otherwise>
							</c:choose>
						</c:catch>
						<c:choose>
							<c:when test="${numberCheck == null}"><c:out value="${newNum}"/></c:when>
							<c:otherwise><c:out value="${twcProductNutritionVO.crudeFiber}"/></c:otherwise>
						</c:choose>
					</td>
					<td>
						<c:catch var="numberCheck">
							<fmt:parseNumber var="parsedNum" type="number" value="${twcProductNutritionVO.dryMatterCrudeFiber}" />
							<c:choose>
								<c:when test="${parsedNum < 0}"><c:set var="newNum" value="-"/></c:when>
								<c:otherwise><c:set var="newNum"><fmt:formatNumber type="number" pattern="###.##" value="${ ((parsedNum*100) - ((parsedNum*100)%1)) * (1/100) }" />%</c:set></c:otherwise>
							</c:choose>
						</c:catch>
						<c:choose>
							<c:when test="${numberCheck == null}"><c:out value="${newNum}"/></c:when>
							<c:otherwise><c:out value="${twcProductNutritionVO.dryMatterCrudeFiber}"/></c:otherwise>
						</c:choose>
					</td>
				</tr>

				<tr>
					<th>조회분</th>
					<td>
						<c:catch var="numberCheck">
							<fmt:parseNumber var="parsedNum" type="number" value="${twcProductNutritionVO.ash}" />
							<c:choose>
								<c:when test="${parsedNum < 0}"><c:set var="newNum" value="-"/></c:when>
								<c:otherwise><c:set var="newNum"><fmt:formatNumber type="number" pattern="###.##" value="${ ((parsedNum*100) - ((parsedNum*100)%1)) * (1/100) }" />%</c:set></c:otherwise>
							</c:choose>
						</c:catch>
						<c:choose>
							<c:when test="${numberCheck == null}"><c:out value="${newNum}"/></c:when>
							<c:otherwise><c:out value="${twcProductNutritionVO.ash}"/></c:otherwise>
						</c:choose>
					</td>
					<td>
						<c:catch var="numberCheck">
							<fmt:parseNumber var="parsedNum" type="number" value="${twcProductNutritionVO.dryMatterAsh}" />
							<c:choose>
								<c:when test="${parsedNum < 0}"><c:set var="newNum" value="-"/></c:when>
								<c:otherwise><c:set var="newNum"><fmt:formatNumber type="number" pattern="###.##" value="${ ((parsedNum*100) - ((parsedNum*100)%1)) * (1/100) }" />%</c:set></c:otherwise>
							</c:choose>
						</c:catch>
						<c:choose>
							<c:when test="${numberCheck == null}"><c:out value="${newNum}"/></c:when>
							<c:otherwise><c:out value="${twcProductNutritionVO.dryMatterAsh}"/></c:otherwise>
						</c:choose>
					</td>
				</tr>

				<tr>
					<th>칼슘</th>
					<td>
						<c:catch var="numberCheck">
							<fmt:parseNumber var="parsedNum" type="number" value="${twcProductNutritionVO.calcium}" />
							<c:choose>
								<c:when test="${parsedNum < 0}"><c:set var="newNum" value="-"/></c:when>
								<c:otherwise></c:otherwise>
							</c:choose>
							<c:set var="newNum"><fmt:formatNumber type="number" pattern="###.##" value="${ ((parsedNum*100) - ((parsedNum*100)%1)) * (1/100) }" />%</c:set>
						</c:catch>
						<c:choose>
							<c:when test="${numberCheck == null}"><c:out value="${newNum}"/></c:when>
							<c:otherwise><c:out value="${twcProductNutritionVO.calcium}"/></c:otherwise>
						</c:choose>
					</td>
					<td>
						<c:catch var="numberCheck">
							<fmt:parseNumber var="parsedNum" type="number" value="${twcProductNutritionVO.dryMatterCalcium}" />
							<c:choose>
								<c:when test="${parsedNum < 0}"><c:set var="newNum" value="-"/></c:when>
								<c:otherwise><c:set var="newNum"><fmt:formatNumber type="number" pattern="###.##" value="${ ((parsedNum*100) - ((parsedNum*100)%1)) * (1/100) }" />%</c:set></c:otherwise>
							</c:choose>
						</c:catch>
						<c:choose>
							<c:when test="${numberCheck == null}"><c:out value="${newNum}"/></c:when>
							<c:otherwise><c:out value="${twcProductNutritionVO.dryMatterCalcium}"/></c:otherwise>
						</c:choose>
					</td>
				</tr>

				<tr>
					<th>인</th>
					<td>
						<c:catch var="numberCheck">
							<fmt:parseNumber var="parsedNum" type="number" value="${twcProductNutritionVO.phosphorus}" />
							<c:choose>
								<c:when test="${parsedNum < 0}"><c:set var="newNum" value="-"/></c:when>
								<c:otherwise><c:set var="newNum"><fmt:formatNumber type="number" pattern="###.##" value="${ ((parsedNum*100) - ((parsedNum*100)%1)) * (1/100) }" />%</c:set></c:otherwise>
							</c:choose>
						</c:catch>
						<c:choose>
							<c:when test="${numberCheck == null}"><c:out value="${newNum}"/></c:when>
							<c:otherwise><c:out value="${twcProductNutritionVO.phosphorus}"/></c:otherwise>
						</c:choose>
					</td>
					<td>
						<c:catch var="numberCheck">
							<fmt:parseNumber var="parsedNum" type="number" value="${twcProductNutritionVO.dryMatterPhosphorus}" />
							<c:choose>
								<c:when test="${parsedNum < 0}"><c:set var="newNum" value="-"/></c:when>
								<c:otherwise><c:set var="newNum"><fmt:formatNumber type="number" pattern="###.##" value="${ ((parsedNum*100) - ((parsedNum*100)%1)) * (1/100) }" />%</c:set></c:otherwise>
							</c:choose>
						</c:catch>
						<c:choose>
							<c:when test="${numberCheck == null}"><c:out value="${newNum}"/></c:when>
							<c:otherwise><c:out value="${twcProductNutritionVO.dryMatterPhosphorus}"/></c:otherwise>
						</c:choose>
					</td>
				</tr>

				<tr>
					<th>오메가3</th>
					<td>
						<c:catch var="numberCheck">
							<fmt:parseNumber var="parsedNum" type="number" value="${twcProductNutritionVO.omega3}" />
							<c:choose>
								<c:when test="${parsedNum < 0}"><c:set var="newNum" value="-"/></c:when>
								<c:otherwise><c:set var="newNum"><fmt:formatNumber type="number" pattern="###.##" value="${ ((parsedNum*100) - ((parsedNum*100)%1)) * (1/100) }" />%</c:set></c:otherwise>
							</c:choose>
						</c:catch>
						<c:choose>
							<c:when test="${numberCheck == null}"><c:out value="${newNum}"/></c:when>
							<c:otherwise><c:out value="${twcProductNutritionVO.omega3}"/></c:otherwise>
						</c:choose>
					</td>
					<td>
						<c:catch var="numberCheck">
							<fmt:parseNumber var="parsedNum" type="number" value="${twcProductNutritionVO.dryMatterOmega3}" />
							<c:choose>
								<c:when test="${parsedNum < 0}"><c:set var="newNum" value="-"/></c:when>
								<c:otherwise><c:set var="newNum"><fmt:formatNumber type="number" pattern="###.##" value="${ ((parsedNum*100) - ((parsedNum*100)%1)) * (1/100) }" />%</c:set></c:otherwise>
							</c:choose>
						</c:catch>
						<c:choose>
							<c:when test="${numberCheck == null}"><c:out value="${newNum}"/></c:when>
							<c:otherwise><c:out value="${twcProductNutritionVO.dryMatterOmega3}"/></c:otherwise>
						</c:choose>
					</td>
				</tr>

				<tr>
					<th>오메가6</th>
					<td>
						<c:catch var="numberCheck">
							<fmt:parseNumber var="parsedNum" type="number" value="${twcProductNutritionVO.omega6}" />
							<c:choose>
								<c:when test="${parsedNum < 0}"><c:set var="newNum" value="-"/></c:when>
								<c:otherwise><c:set var="newNum"><fmt:formatNumber type="number" pattern="###.##" value="${ ((parsedNum*100) - ((parsedNum*100)%1)) * (1/100) }" />%</c:set></c:otherwise>
							</c:choose>
						</c:catch>
						<c:choose>
							<c:when test="${numberCheck == null}"><c:out value="${newNum}"/></c:when>
							<c:otherwise><c:out value="${twcProductNutritionVO.omega6}"/></c:otherwise>
						</c:choose>
					</td>
					<td>
						<c:catch var="numberCheck">
							<fmt:parseNumber var="parsedNum" type="number" value="${twcProductNutritionVO.dryMatterOmega6}" />
							<c:choose>
								<c:when test="${parsedNum < 0}"><c:set var="newNum" value="-"/></c:when>
								<c:otherwise><c:set var="newNum"><fmt:formatNumber type="number" pattern="###.##" value="${ ((parsedNum*100) - ((parsedNum*100)%1)) * (1/100) }" />%</c:set></c:otherwise>
							</c:choose>
						</c:catch>
						<c:choose>
							<c:when test="${numberCheck == null}"><c:out value="${newNum}"/></c:when>
							<c:otherwise><c:out value="${twcProductNutritionVO.dryMatterOmega6}"/></c:otherwise>
						</c:choose>
					</td>
				</tr>

				<tr>
					<th>수분</th>
					<td>
						<c:catch var="numberCheck">
							<fmt:parseNumber var="parsedNum" type="number" value="${twcProductNutritionVO.moisture}" />
							<c:choose>
								<c:when test="${parsedNum < 0}"><c:set var="newNum" value="-"/></c:when>
								<c:otherwise><c:set var="newNum"><fmt:formatNumber type="number" pattern="###.##" value="${ ((parsedNum*100) - ((parsedNum*100)%1)) * (1/100) }" />%</c:set></c:otherwise>
							</c:choose>
						</c:catch>
						<c:choose>
							<c:when test="${numberCheck == null}"><c:out value="${newNum}"/></c:when>
							<c:otherwise><c:out value="${twcProductNutritionVO.moisture}"/></c:otherwise>
						</c:choose>
					</td>
					<td></td>
				</tr>
				<tr>
					<th>탄수화물</th>
					<td></td>
					<td>
						<c:catch var="numberCheck">
							<fmt:parseNumber var="carbohydrateNum" type="number" value="${twcProductNutritionVO.carbohydrate}" />
							<c:choose>
								<c:when test="${carbohydrateNum < 0 }"><c:set var="newNum" value="-"/></c:when>
								<c:otherwise><c:set var="newNum"><fmt:formatNumber type="number" pattern="###.##" value="${ ((carbohydrateNum*100) - ((carbohydrateNum*100)%1)) * (1/100) }" />%</c:set></c:otherwise>
							</c:choose>
						</c:catch>
						<c:choose>
							<c:when test="${numberCheck == null}"><c:out value="${newNum}"/></c:when>
							<c:otherwise><c:out value="${twcProductNutritionVO.carbohydrate}"/></c:otherwise>
						</c:choose>
					</td>
				</tr>
				<tr>
					<th>기타성분</th>
					<td colspan="2" class="alg_l"><c:out value="${twcProductNutritionVO.other}"/></td>
				</tr>
			</tbody>
		</table>
	</div>
</c:if>

<c:if test="${not empty twcProductVO}">
	<div class="gdtbl b">
		<div class="gdthdt">상세 정보</div>
		<table class="tblist b" cellpadding="0" cellspacing="0" summary="원료구성,포장상태,소포장 단위,사료 타임, 권장연령 테이블">
			<caption>상세 정보</caption>
			<colgroup>
				<col>
				<col>
			</colgroup>
			<tbody>
			<c:if test="${not empty twcProductVO.material}">
				<tr>
					<th>원료구성</th>
					<td><c:out value="${twcProductVO.material}"/></td>
				</tr>
			</c:if>

			<c:if test="${not empty twcProductVO.packagingType}">
				<tr>
					<th>포장상태</th>
					<td><c:out value="${twcProductVO.packagingType}"/></td>
				</tr>
			</c:if>

			<c:if test="${not empty twcProductVO.innerPacking}">
				<tr>
					<th>소포장 단위</th>
					<td><c:out value="${twcProductVO.innerPacking}"/></td>
				</tr>
			</c:if>

			<c:if test="${not empty twcProductVO.type}">
				<tr>
					<th>제품 타입</th>
					<td><c:out value="${twcProductVO.type}"/></td>
				</tr>
			</c:if>

			<c:if test="${not empty twcProductVO.recommendAge}">
				<tr>
					<th>권장 연령</th>
					<td><c:out value="${twcProductVO.recommendAge}"/></td>
				</tr>
			</c:if>
			</tbody>
		</table>
		<!-- @@ 03.08 문구변경 -->
		<div class="gdtinfo">
			* 브랜드사에서 제공한 정보로 모든 책임은 브랜드사에 있습니다. <br>
			* 해당 정보는 브랜드사 사정에 의해 일부 변경될 수 있습니다.
		</div>
<%--		<div class="gdtinfo">* 위 원료는 공장 사정에 의해 일부 변경 될 수도 있습니다.</div>--%>
	</div>
</c:if>
</div>


<div class="gdtbl c">
	<div class="gdthdt">상품 필수 정보</div>
	<table class="tblist c" cellpadding="0" cellspacing="0" summary="품명 및 모델명, 제조사,제조국,A/S책임자,인증허가,안정인증여부 테이블">
		<caption>상품 필수 정보</caption>
		<colgroup>
			<col>
			<col>
		</colgroup>
		<tbody>
		<c:forEach items="${goodsNotifyList}" var="goodsNotify">
			<tr>
				<th><c:out value="${goodsNotify.itemNm}" /></th>
				<td><c:out value="${fn:replace(goodsNotify.itemVal, '&amp;', '&')}" /></td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
</div>
