<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<c:set var="dlvrcPlcNo" value="${goods.dlvrcPlcNo}"/>
<c:if test="${goods.goodsCstrtTpCd eq 'PAK' || goods.goodsCstrtTpCd eq 'ATTR'}">
	<c:set var="dlvrcPlcNo" value="${goods.dlgtSubDlvrcPlcNo}"/>
</c:if>
<script type="text/javascript">
	$(function(){
		// 배송 정보
		//goods.dlvrcPlcNo: ${goods.dlvrcPlcNo}
		//goods.dlgtSubDlvrcPlcNo: ${goods.dlgtSubDlvrcPlcNo}
		getDeliveryInfo('<c:out value="${goods.compNo}"/>', '<c:out value="${dlvrcPlcNo}"/>');
	});

	/**
	 * 배송정보
	 * @param goodsId
	 * @param compPlcNo
	 */ //goods.freeDlvrYn: ${goods.freeDlvrYn}
	function getDeliveryInfo(compNo, dlvrcPlcNo) {
		var options = {
			url: '<spring:url value="/goods/getGoodsDeliveryInfo"/>'
			, data: {compNo:compNo, dlvrcPlcNo: dlvrcPlcNo}
			, done: function (result) {
				// 배송 정보
				if(result.deliveryChargePolicy) {
					var deliveryChargePolicy = result.deliveryChargePolicy;
					var dlvrFree = '';


					if(deliveryChargePolicy.dlvrcCdtStdCd == '20') {
						dlvrFree = numberWithCommas(deliveryChargePolicy.buyPrc) + '원 이상 무료배송' ;
					} else if(deliveryChargePolicy.dlvrcCdtStdCd == '30') {
						dlvrFree = numberWithCommas(deliveryChargePolicy.buyQty) + '개 이상 무료배송' ;
					} else {
						
					}
					
					
					if(('${goods.goodsCstrtTpCd}' == 'ITEM' || '${goods.goodsCstrtTpCd}' == 'SET') && '${goods.freeDlvrYn}' == 'Y'){
						
						$('span[name=dlvrFree]').text("무료배송");
						$('span[name=dlvrFreePop]').text('무료배송');
						
					}else if(('${goods.goodsCstrtTpCd}' == 'ATTR' || '${goods.goodsCstrtTpCd}' == 'PAK') && '${goods.dlgtSubFreeDlvrYn}' == 'Y'){
						
						$('span[name=dlvrFree]').text("무료배송");
						$('span[name=dlvrFreePop]').text('무료배송');
						
					}else{
						
						// 배송료
						if(deliveryChargePolicy.dlvrAmt>0 && '${goods.freeDlvrYn}' != 'Y') {
							$('span[name=dlvrAmt]').text(numberWithCommas("배송비 "+deliveryChargePolicy.dlvrAmt)+"원");
						}else{
							dlvrFree = '무료배송';
						}
	
						if(dlvrFree) {
							$('span[name=dlvrFree]').text(dlvrFree);
							$('span[name=dlvrFreePop]').text(dlvrFree == '무료배송' ? dlvrFree : '('+dlvrFree+')');
						}
					}
					// 교환/환불 정책
					$('#rtnExcInfo').html(deliveryChargePolicy.rtnExcInfo);
				}
			}
		};

		ajax.call(options);
		// 배달 시간
		getDeliveryTime();
	}

	/**
	 * todo[상품, 이하정, 202010314] 연결 데이터 확인 후 작업 더 필요함
	 * 체크 결제 완료시 연결 데이터 체크
	 * 체크 업체 배송일 때 문구 확인
	 * @param
	 */
	function getDeliveryTime(){
		$.ajax({
			type: "POST",
			url: "/order/getDlvrPolicy",
			dataType: "json",
			success: function (data) {
				
				$.each(data.list, function(i, v){
					let ordDateTime = new Date(v.ordDateTime); // 배송완료 예상시간
					let dlvrPrcsTpCd = v.dlvrPrcsTpCd;
					
					if (dlvrPrcsTpCd == "20" || dlvrPrcsTpCd == "21") {  // 새벽배송/당일배송
						// 1. 마감시간 체크
						// 마감시간 가져오기
						let closeDate = new Date(v.targetCloseDtm);

						var onedayCloseTime = '11:30 배송마감';
						var dawnCloseTime = '21:00 배송마감';
						if(v.isHoliday) { // 휴무일
							if (dlvrPrcsTpCd == "20"){
								$('[data-delivery="day"]').hide();
								$('div[name=onedayText]').html('<em class="r">'+v.restTimeShowText+'</em>');
								$('[name=onedayText]').data('time', closeDate);
								deliveryTime('oneday', closeDate);
								onedayCloseTime = '';
								$('#popDelInfo [name="onedayText"]').closest(".dd").siblings(".dt").children(".tt").text(onedayCloseTime);
							} else if(dlvrPrcsTpCd == "21") {
								$('[data-delivery="dawn"]').hide();
								$('div[name=dawnText]').html('<em class="r">'+v.restTimeShowText+'</em>');
								deliveryTime('dawn', closeDate);
								dawnCloseTime = '';
								$('#popDelInfo [name="dawnText"]').closest(".dd").siblings(".dt").children(".tt").text(dawnCloseTime);
							}
						} else { // 정상상황
							if (dlvrPrcsTpCd == "20"){
								/**
								 * 당일배송
								 */
								$('span[name=onedayHour]').text(v.restTimeHour);
								$('span[name=onedayMin]').text(v.restTimeMinute);
								var ondayText = '<em class="b">' +v.dlvrTimeShowText.replace('도착', '')+ '</em> 도착';
								$('div[name=onedayText]').html(ondayText);
								deliveryTime('oneday', closeDate);
								$('#popDelInfo [name="onedayText"]').closest(".dd").siblings(".dt").children(".tt").text(onedayCloseTime);
							} else if(dlvrPrcsTpCd == "21") {
								/**
								 * 새벽배송
								 */
								$('span[name=dawnHour]').text(v.restTimeHour);
								$('span[name=dawnMin]').text(v.restTimeMinute);
								var dawnText = '<em class="b">' +v.dlvrTimeShowText.replace('도착', '')+ '</em> 도착';
								$('div[name=dawnText]').html(dawnText);
								deliveryTime('dawn', closeDate);
								$('#popDelInfo [name="dawnText"]').closest(".dd").siblings(".dt").children(".tt").text(dawnCloseTime);
							}
						}
					} else { // 일반배송
						$('span[name=dlvryHour]').text(v.restTimeHour);
						$('span[name=dlvryMin]').text(v.restTimeMinute);
						deliveryTime('dlvry', new Date(v.targetCloseDtm));
						//var dlvryText = '<em class="b">' +v.dlvrTimeShowText.replace('도착 예정', '')+ '</em> 도착 예정';
						//$('span[name=dlvryText]').text(dlvryText);
					}
				});
				
			},
			error: function(request,status,error) {
				alert("배송방식을 가져오는데 실패했습니다.");
			}
		});
	}
</script>
<div class="deliguides">
	<c:choose>
		<c:when test="${goods.compTpCd eq frontConstants.COMP_TP_10}">
			<ul class="gdlist">
				<li class="dl2">
					<div class="ht">당일배송</div>
					<div class="dt">
						<div class="tt" name="onedayText"></div>
						<div class="ss" data-delivery="day">11시 30분 전 결제완료 시 (<span name="onedayHour">00</span>시 <span name="onedayMin">00</span>분 남음)</div>
<%--
						<div class="ss">
							<ul class="bls">
								<li>서울, 인천, 경기 일부 가능</li>
								<li>명절연휴(설날/추석 당일) 제외</li>
							</ul>
						</div>
--%>
					</div>
				</li>

				<li class="dl1">
					<div class="ht">새벽배송</div>
					<div class="dt">
						<div class="tt" name="dawnText"></div>
						<div class="ss" id="dawn" data-delivery="dawn">21시 전 결제 완료시 (<span name="dawnHour">00</span>시 <span name="dawnMin">00</span>분 남음)</div>
<%--
						<div class="ss">
							<ul class="bls">
								<li>서울, 경기 일부 가능</li>
								<li>일요일, 명절연휴 (설날/추석 당일) 제외</li>
							</ul>
						</div>
--%>
					</div>
				</li>

				<li class="dl3">
					<div class="ht">택배배송</div>
					<%--
					[기대결과] APETQA-1626
						1. 도착예정일 노출
						ㄴ '당일 출고 예정(주말, 공휴일제외)'
					--%>
					<div class="dt">
						<div class="tt">1 ~ 2일 소요 예정</div>
						<div class="ss" data-delivery="parcel">16시 이전 주문 : 다음날 도착 (98%) (<span name="dlvryHour">00</span>시 <span name="dlvryMin">00</span>분 남음)<br>16시 이후 주문 : 2일 이내 도착</div>
						<!-- CSR-1309 건으로 주석 처리 20210622
						<div class="tt">당일 출고 예정(주말, 공휴일 제외)</div>
						<div class="ss" data-delivery="parcel">16시 전 결제 완료시 (<span name="dlvryHour">00</span>시 <span name="dlvryMin">00</span>분 남음)</div>
						-->
						<!-- 04-23 QA 요청 안보여도 되는 데이터 
						<div class="ss"><span name="dlvrAmt"></span> <span name="dlvrFreePop"></span></div>
						 -->
					</div>
					<%--<div class="dt"> 20210329 APETQA-1626 QA로 삭제
						<div class="tt">1 ~ 4일 소요 예정 예정(주말, 공휴일 제외)</div>
						<div class="ss">토요일,일요일,공휴일 제외</div>
					</div>--%>
					<%--<div class="dt"> APETQA-769 삭제 -> 이거 다시 부활할건데 히스토리 남기려고 놔둠
						<div class="tt"><em class="b">당일 출고</em> 예정(주말, 공휴일 제외)</div>
						<div class="ss">16시 전 결제 완료시 (<span name="dlvryHour">00</span>시 <span name="dlvryMin">00</span>분 남음)</div>
					</div>--%>
				</li>
			</ul>
		</c:when>
		<c:otherwise>
			<ul class="gdlist">
				<li class="dl4">
					<div class="ht">업체배송</div>
					<div class="dt">
						<div class="tt">결제완료 기준 2 ~ 7일 소요 예정</div>
					</div>
				</li>
			</ul>
		</c:otherwise>
	</c:choose>
</div>
<div class="layers">
	<article class="popBot popDelInfo" id="popDelInfo">
		<div class="pbd">
			<div class="phd">
				<div class="in">
					<h1 class="tit">배송/반품/교환</h1>
					<button type="button" class="btnPopClose">닫기</button>
				</div>
			</div>
			<div class="pct">
				<main class="poptents">
					<section class="sect">
						<div class="hdt"><span class="tit">배송안내</span></div>
						<div class="cdt">
							<ul class="gdlist">
							<c:choose>
								<c:when test="${goods.compTpCd eq frontConstants.COMP_TP_10}">
									<li class="dl1">
										<div class="ht">당일배송</div>
										<div class="dt">
											<div class="tt">11:30 배송마감</div>
											<div class="ss" data-delivery="day"><span name="onedayHour">00</span>:<span name="onedayMin">00</span> 남음</div>
										</div>
										<div class="dd">
											<div class="tt" name="onedayText"></div>
											<div class="ss">
												<ul class="bls">
													<li>서울, 인천, 경기 일부 가능</li>
													<li>명절연휴(설날/추석 당일) 제외</li>
												</ul>
											</div>
										</div>
									</li>
									<li class="dl2">
										<div class="ht">새벽배송</div>
										<div class="dt">
											<div class="tt">21:00 배송마감</div>
											<div class="ss" data-delivery="dawn"><span name="dawnHour">00</span>:<span name="dawnMin">00</span> 남음</div>
										</div>
										<div class="dd">
											<div class="tt" name="dawnText"></div>
											<div class="ss">
												<ul class="bls">
													<li>서울, 경기 일부 가능</li>
													<li>일요일, 명절연휴(설날/추석 당일) 제외</li>
												</ul>
											</div>
										</div>
									</li>
									<li class="dl3">
										<div class="ht">택배배송</div>
										<div class="dt">
											<div class="tt">16:00 배송마감</div>
											<div class="ss" data-delivery="parcel"><span name="dlvryHour">00</span>:<span name="dlvryMin">00</span> 남음</div>
										</div>
										<div class="dd">
											<div class="tt">1 ~ 2일 소요 예정</div>
											<div class="ss">
												<ul class="bls">
													<li>16시 이전 주문 : 다음날 도착 (98%) (<span name="dlvryHour">00</span>시 <span name="dlvryMin">00</span>분 남음)</li>
													<li>16시 이후 주문 : 2일 이내 도착</li>
													<li>토요일,일요일,공휴일 제외</li>
												</ul>
											</div>
										</div>
									</li>
								</c:when>
								<c:otherwise>
									<li class="dl4">
										<div class="ht">업체배송</div>
										<div class="dd">
											<div class="tt">결제완료 기준 2 ~ 7일 소요 예정</div>
											<div class="ss">
												<ul class="bls">
													<li>토요일, 일요일, 공휴일 제외</li>
												</ul>
											</div>
										</div>
									</li>
								</c:otherwise>
							</c:choose>
							</ul>
						</div>
					</section>
					<section class="sect"><div class="cdt" id="rtnExcInfo"></div></section>
				</main>
			</div>
		</div>
	</article>
</div>