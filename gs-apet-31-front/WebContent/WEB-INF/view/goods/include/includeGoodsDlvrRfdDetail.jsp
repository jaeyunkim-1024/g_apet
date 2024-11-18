<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ page import="framework.common.constants.CommonConstants" %>
<script type="text/javascript">

</script>

<!-- @@ 배송정보 설명 추가 02.18 -->
<div class="deliguides">
	<ul class="gdlist">
<%--		listDlvrPrcs--%>
	<c:forEach items="${listDlvrPrcs}" var="item" varStatus="idx">
		<c:if test="${item.dlvrPrcsTpCd eq CommonConstants.DLVR_PRCS_TP_20}" >
			<li class="dl1">
				<div class="ht">당일배송</div>
				<div class="dt">
<%--					<div class="tt"><em class="b">오늘밤</em> 도착예정</div>--%>
<%--					<div class="ss">11시 30분 전 결제 완료시(00시 00분 남음)</div>--%>
					<div class="tt"><em class="b">${item.dlvrTimeShowText.replace(" 도착 예정", "")}</em> 도착예정</div>
					<div class="ss">11시 30분 전 결제 완료시(${item.restTimeShowText} 남음)</div>
<%--					<div class="ss">11시 30분 전 결제 완료시(${item.restTimeHour}시 ${item.restTimeMinute}분 남음)</div>--%>
				</div>
			</li>
		</c:if>

		<c:if test="${item.dlvrPrcsTpCd eq CommonConstants.DLVR_PRCS_TP_21}" >
			<li class="dl2">
				<div class="ht">새벽배송</div>
				<div class="dt">
<%--					<div class="tt"><em class="b">내일 오전</em> 도착예정</div>--%>
<%--					<div class="ss">21시 전 결제 완료시(00시 00분 남음)</div>--%>
					<div class="tt"><em class="b">${item.dlvrTimeShowText.replace(" 도착 예정", "")}</em> 도착예정</div>
					<div class="ss">21시 전 결제 완료시(${item.restTimeShowText} 남음)</div>
<%--					<div class="ss">21시 전 결제 완료시(${item.restTimeHour}시 ${item.restTimeMinute}분 남음)</div>--%>
				</div>
			</li>
		</c:if>

		<c:if test="${item.dlvrPrcsTpCd eq CommonConstants.DLVR_PRCS_TP_10}" >
			<li class="dl3">
				<div class="ht">택배배송</div>
				<div class="dt">
<%--					<div class="tt">당일 출고 예정</div>--%>
<%--					<div class="ss">16시 전 결제 완료시(00시 00분 남음)</div>--%>
					<div class="tt">${item.dlvrTimeShowText}</div>
					<div class="ss">16시 전 결제 완료시(${item.restTimeHour}시 ${item.restTimeMinute}분 남음)</div>
				</div>
			</li>
		</c:if>

	</c:forEach>

	</ul>
</div>
<div class="deliguides">
	<ul class="gdlist">
		<li class="dl4">
			<div class="ht">업체배송</div>
			<div class="dt">
				<div class="ss">결제완료 기준 2~7일 소요 예정</div>
			</div>
		</li>
	</ul>
</div>

<!-- 배송/환불 -->
<article class="popBot popDelInfo" id="popDelInfo">
	<div class="pbd">
		<div class="phd">
			<div class="in">
				<h1 class="tit">배송/환불</h1>
				<button type="button" class="btnPopClose">닫기</button>
			</div>
		</div>
		<div class="pct">
			<main class="poptents">
				<section class="sect">
					<div class="hdt"><span class="tit">배송안내</span></div>
					<div class="cdt">
						<ul class="gdlist">
							<c:forEach items="${listDlvrPrcs}" var="item" varStatus="idx">
								<c:if test="${item.dlvrPrcsTpCd eq CommonConstants.DLVR_PRCS_TP_20}" >
								<li class="dl1">
									<div class="ht">당일배송</div>
									<div class="dt">
										<div class="tt">11:30 배송마감</div>
										<div class="ss">${item.restTimeShowText} 남음</div>
									</div>
									<div class="dd">
	<%--										<div class="tt"><em class="b">내일 오전</em> 도착예정</div>--%>
										<div class="tt"><em class="b">${item.dlvrTimeShowText.replace(" 도착 예정", "")}</em> 도착예정</div>
										<div class="ss">
											<ul class="bls">
												<li>서울, 경기 일부 가능</li>
												<li>토요일, 명절연휴(설날/추석 당일) 제외</li>
											</ul>
										</div>
									</div>
								</li>
								</c:if>
								<c:if test="${item.dlvrPrcsTpCd eq CommonConstants.DLVR_PRCS_TP_21}" >
								<li class="dl2">
									<div class="ht">새벽배송</div>
									<div class="dt">
										<div class="tt">21:00 배송마감</div>
										<div class="ss">${item.restTimeShowText} 남음</div>
									</div>
									<div class="dd">
										<div class="tt"><em class="b">${item.dlvrTimeShowText.replace(" 도착 예정", "")}</em> 도착예정</div>
										<div class="ss">
											<ul class="bls">
												<li>서울, 인천, 경기 일부 가능</li>
												<li>명절연휴 (설날/추석 당일) 제외</li>
											</ul>
										</div>
									</div>
								</li>
								</c:if>

								<c:if test="${item.dlvrPrcsTpCd eq CommonConstants.DLVR_PRCS_TP_10}" >
									<li class="dl3">
										<div class="ht">택배배송</div>
										<div class="dt">
											<div class="tt">16:00 배송마감</div>
											<div class="ss">${item.restTimeShowText} 남음</div>
										</div>
										<div class="dd">
<%--											<div class="tt">1~4일 소요 예정</div>--%>
											<div class="tt">${item.dlvrTimeShowText}</div>
											<div class="ss">
												<ul class="bls">
													<li>토요일,일요일,공휴일 제외</li>
												</ul>
											</div>
										</div>
									</li>
								</c:if>
							</c:forEach>
							<li class="dl4">
								<div class="ht">업체배송</div>
								<div class="dd">
									<div class="tt">결제완료 기준 2~7일 소요 예정</div>
									<div class="ss">
										<ul class="bls">
											<li>토요일, 일요일, 공휴일 제외</li>
										</ul>
									</div>
								</div>
							</li>
						</ul>
						<ul class="blist">
							<li>배송비 : 기본배송료는 2,500원 입니다. (도서,산간,오지 일부지역은 배송비가 추가될 수 있습니다)  40,000원 이상 구매시 무료배송입니다.</li>
							<li>본 상품의 평균 배송일은 2일입니다.(입금 확인 후) 설치 상품의 경우 다소 늦어질수 있습니다.[배송예정일은 주문시점(주문순서)에 따른 유동성이 발생하므로 평균 배송일과는 차이가 발생할 수 있습니다.</li>
						</ul>
					</div>
				</section>
				<section class="sect">
					<div class="hdt"><span class="tit">교환 및 반품 안내</span></div>
					<div class="cdt">
						<ul class="blist">
							<li>취소/반품/교환/환불은 배송 완료 후 7일 이내에 가능합니다.</li>
							<li>상품 하자 및 오배송의 경우 수령일자로부터 7일 이내에 보내주셔야 펫츠비 부담으로 교환/반품이 가능합니다.</li>
							<li>교환/반품 물건을 보내실 때는 반드시 상담원과 통화 후 CJ대한통운으로 보내주시기 바랍니다. <br> (타 택배 이용 시 발생하는 초과운임은 고객님 부담입니다.)</li>
							<li>교환 및 반품 시에는 배송된 포장박스와 포장재를 사용하고 사은품을 포함하여 처음과 같이 안전하게 보내주시기 바랍니다. </li>
						</ul>
					</div>
				</section>
			</main>
		</div>
	</div>
</article>

<script>
	// ui.popBot.open("popDelInfo");
</script>