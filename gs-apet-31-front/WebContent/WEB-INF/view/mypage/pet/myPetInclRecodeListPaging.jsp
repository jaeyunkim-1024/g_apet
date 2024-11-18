<c:forEach items ="${recodeList}" var="recode">
	<tr data-inclno="${recodeList.inclNo }">
		<td name = "inclDtTd"><frame:date date="${recode.inclDt }" type="C"/></td>
		<td>${recode.inclNm }</td>
		<td>
			<div class="box">
				<p name ="itemNm" class="t">${recode.itemNm }</p>
				<c:if test = "${recode.imgPath ne null }">
					<span class="icon"></span>
				</c:if>
			</div>
		</td>
		<td>
			<div class="box">
				<p class="t">
					<input type ="hidden" name ="inclKindCd" value ="${recode.inclKindCd }">
					<input type ="hidden" name ="intervalDay" value=${recode.intervalDay }>
					<!-- 다음 예정일이 지나지 않은 경우 붉은색 -->
					<c:if test = "${recode.intervalDay >= 0 }">
					<span class="f-blue" name = "addInclDts"><frame:date date="${recode.addInclDt }" type ="C" /></span>
					</c:if>
					<!-- 다음 예정일이 지난경우 붉은색 -->
					<c:if test = "${recode.intervalDay < 0 }">
					<span class="f-red" name = "addInclDts"><frame:date date="${recode.addInclDt }" type ="C" /></span>
					</c:if>	
				</p>
				<a href="#" onclick="fncGoPetInclRecodeView('${recode.inclNo }'); return false;" data-content="" data-url="/my/pet/myPetInclRecodeView?inclNo=${recode.inclNo }"><span class="icon2"></span></a>
			</div>
		</td>
	</tr>
</c:forEach>