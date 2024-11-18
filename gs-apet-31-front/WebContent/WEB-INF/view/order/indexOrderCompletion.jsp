<tiles:insertDefinition name="common">
	<tiles:putAttribute name="script.inline">
		<script>
			$(document).ready(function(){
				// history를 이용한 접근 방지 (파람은 GTM의 페이지 구분값)
				storageHist.replaceHist();
				history.replaceState("","",'/common/wrongAprch?sc=comp');  //  그대로.
				
				<c:choose>
				<c:when test="${view.deviceGb eq frontConstants.DEVICE_GB_10 }">	
					var clipboard = new ClipboardJS('#copyBtn');
					clipboard.on('success', function(e) {
						ui.toast('계좌번호가 복사되었습니다.');
					});
					clipboard.on('error', function(e) {
						ui.alert('다시 시도하여 주십시오.');
					});
				</c:when>
				<c:otherwise>
					var clipboard = new ClipboardJS('#copyLink');
					clipboard.on('success', function(e) {
						ui.toast('계좌번호가 복사되었습니다.');
					});
					clipboard.on('error', function(e) {
						ui.alert('다시 시도하여 주십시오.');
					});
				</c:otherwise>
				</c:choose>
			});
			
			// GTM
			var digitalData = digitalData || {};
			var orderInfo = {};
			var products = new Array();
			var actionField = {
					order_id : "${orderBase.ordNo}",
					revenue : "${frontPayInfo.orgPayAmt}",
					shipping : "${frontPayInfo.orgDlvrAmt}",
					discount : Math.abs("${frontPayInfo.orgCpDcAmt}"),
					coupon : ""
				}
			orderInfo.actionField = actionField;
			<c:forEach items="${orderDetailList}" var="item">
				var thisProduct = {};
				var thisOpt = new Array();
				var pakId = "${item.pakGoodsId}";
				thisProduct.name = "${item.goodsNm}";
				thisProduct.id = "${item.goodsId}";
				thisProduct.category = "${item.dispCtgPath}";
				thisProduct.brand = "${item.cdBndNmKo}";
				thisProduct.quantity = "${item.ordQty}";
				thisProduct.price = "${item.saleAmt}";
				
				if(pakId.indexOf("GO") != -1 ){
					thisProduct.variant = "${item.pakItemNm}"; 
				}else{
					thisProduct.variant = "${item.optGoodsNm}";
					if(thisProduct.variant == ''){
						thisProduct.variant = "${item.goodsId}";
					}
				}
				products.push(thisProduct);
			</c:forEach>
			orderInfo.products = products;
			digitalData.orderInfo = orderInfo;
		</script>
	</tiles:putAttribute>
	<tiles:putAttribute name="content">
		<style>
			.custom_ellipsis_dlvr{
				display: -webkit-box;
				text-overflow: ellipsis;
				-webkit-box-orient: vertical;
				-webkit-line-clamp: 1;
				overflow: hidden;
			}
		</style>

		<main class="container page shop od order com" id="container">
			<div class="pageHeadPc">
				<div class="inr">
					<div class="hdt">
						<h3 class="tit">주문완료</h3>
					</div>
				</div>
			</div>
			<div class="inr">
				<!-- 본문 -->
				<div class="contents" id="contents">
					<div class="ordersets">
						<section class="topbox">
							<div class="hdd">
								<div class="hd">
									<em class="nm">${orderBase.ordNm}</em>님 <br>주문이 완료되었습니다.
								</div>
								<div class="dd">주문하신 내역은 ‘주문/배송’ 에서 확인하실 수 있습니다.</div>
							</div>
							<%--가상계좌일때만 보이는 영역--%>
							<c:if test="${orderPay.payMeansCd eq frontConstants.PAY_MEANS_30}">
								<div class="cdd">
									<div class="msg">입금내역 확인 후 배송이 시작됩니다.</div>
									<div class="inf">
										<ul class="lst">
											<li>
												<div class="dt">계좌정보</div>
												<div class="dd">
													<a href="#" class="lk" id="copyLink" data-clipboard-text="${orderPay.acctNo}" >${orderPay.bankNm}&nbsp; ${orderPay.acctNo}</a> 
													<a href="#" class="btn sm copy" id="copyBtn" data-clipboard-text="${orderPay.acctNo}">계좌번호복사</a>
												</div>
											</li>
											<li>
												<div class="dt">예금주명</div>
												<div class="dd">${orderPay.ooaNm}</div>
											</li>
											<li>
												<div class="dt">입금기한</div>
												<div class="dd">${orderPay.dpstSchdDtNm}까지</div>
											</li>
										</ul>
									</div>
								</div>
							</c:if>
						</section>

						<section class="sect odnb">
							<div class="hdts"><span class="tit">주문 번호</span></div>
							<div class="cdts">
								<div class="box">
									<i class="nums">${orderBase.ordNo}</i>
								</div>
							</div>
						</section>

						<section class="sect addr">
							<div class="hdts"><span class="tit">배송지</span></div>
							<div class="cdts">
								<div class="adrset">
									<div class="name">
										<em class="t"><c:out value="${orderDlvra.escapedGbNm }" escapeXml="false"/></em>
									</div>
									<div class="adrs">
										[${orderDlvra.postNoNew}] ${orderDlvra.roadAddr}, <c:out value="${orderDlvra.escapedRoadDtlAddr}" escapeXml="false"/>
									</div>
									<div class="tels"><c:out value="${orderDlvra.escapedAdrsNm}" escapeXml="false"/> | <frame:mobile data="${orderDlvra.mobile}" /></div>
								</div>
								<div class="adrreq">
									<div class="pwf">
										<em class="t">
											<c:choose>
												<c:when test="${orderDlvra.goodsRcvPstCd eq frontConstants.GOODS_RCV_PST_40}">
													<c:out value="${orderDlvra.escapedGoodsRcvPstEtc}" escapeXml="false"/>
												</c:when>
												<c:otherwise>
													<frame:codeValue items="${goodsRcvPstList}" dtlCd="${orderDlvra.goodsRcvPstCd }"/>
												</c:otherwise>
											</c:choose>
										</em> 
										<em class="p"><frame:codeValue items="${pblGateEntMtdList}" dtlCd="${orderDlvra.pblGateEntMtdCd }"/>&nbsp; 
											<if test="${orderDlvra.pblGateEntMtdCd eq frontConstants.PBL_GATE_ENT_MTD_10}">
												<c:out value="${orderDlvra.escapedPblGatePswd}" escapeXml="false"/>
											</if>
										</em>
										<div class="txt custom_ellipsis_dlvr"><c:out value="${orderDlvra.escapedDlvrDemand}" escapeXml="false"/></div>
									</div>
								</div>
							</div>
						</section>
						<section class="sect bprc">
							<div class="hdts"><span class="tit">결제 정보</span></div>
							<div class="cdts">
								<ul class="prcset">
									<li>
										<div class="dt">총 상품금액</div>
										<div class="dd">
											<span class="prc"><em class="p"><frame:num data="${frontPayInfo.orgGoodsAmt}"/></em><i class="w">원</i></span>
										</div>
									</li>
									<c:if test="${frontPayInfo.orgCpDcAmt ne 0}">
									<li>
										<div class="dt">쿠폰 할인</div>
										<div class="dd">
											<span class="prc dis">
												<em class="p"><frame:num data="${frontPayInfo.orgCpDcAmt}"/></em><i class="w">원</i></span>
										</div>
									</li>
									</c:if>
									<c:if test="${frontPayInfo.orgGsPnt ne 0}">
									<li>
										<div class="dt">GS&POINT 사용</div>
										<div class="dd">
											<span class="prc dis">
												<em class="p"><frame:num data="${frontPayInfo.orgGsPnt}"/></em><i class="w">P</i></span>
										</div>
									</li>
									</c:if>
									<c:if test="${frontPayInfo.orgMpPnt ne 0}">
									<li>
										<div class="dt">우주코인 사용</div>
										<div class="dd">
											<span class="prc dis">
												<em class="p"><frame:num data="${frontPayInfo.orgMpPnt}"/></em><i class="w">C</i></span>
										</div>
									</li>
									</c:if>
									<c:if test="${frontPayInfo.orgAddMpPnt ne 0}">
									<li>
										<div class="dt">우주코인 추가할인</div>
										<div class="dd">
											<span class="prc dis">
												<em class="p"><frame:num data="${frontPayInfo.orgAddMpPnt}"/></em><i class="w">원</i></span>
										</div>
									</li>
									</c:if>
									<li>
										<div class="dt">배송비</div>
										<div class="dd">
											<span class="prc"><em class="p"><frame:num data="${frontPayInfo.orgDlvrAmt}"/></em><i class="w">원</i></span>
										</div>
									</li>
								</ul>
								<div class="tot">
									<div class="dt">총 결제금액</div>
									<div class="dd">
										<span class="prc"><em class="p"><frame:num data="${frontPayInfo.orgPayAmt}"/></em><i class="w">원</i></span>
									</div>
								</div>
						</section>
						<c:if test="${not empty orderPay.payMeansCd && orderPay.payMeansCd ne frontConstants.PAY_MEANS_00}">
							<section class="sect binf">
								<div class="hdts"><span class="tit">결제수단 정보</span></div>
								<div class="cdts">
									<div class="result">
										<div class="hd">
											<c:choose>
												<c:when test="${orderPay.payMeansCd eq frontConstants.PAY_MEANS_11}">
													<em class="b">간편결제</em>
												</c:when>
												<c:otherwise>
													<em class="b">일반결제</em>
												</c:otherwise>
											</c:choose>
											<c:choose>
												<c:when test="${orderPay.payMeansCd eq frontConstants.PAY_MEANS_10 or orderPay.payMeansCd eq frontConstants.PAY_MEANS_11}">
													<i class="t"><spring:message code='front.web.view.common.payment.creditcard'/></i>
												</c:when>
												<c:when test="${orderPay.payMeansCd eq frontConstants.PAY_MEANS_20}">
													<i class="t"><spring:message code='front.web.view.common.payment.realtime.bankTransfer'/></i>
												</c:when>
												<c:when test="${orderPay.payMeansCd eq frontConstants.PAY_MEANS_30}">
													<i class="t"><spring:message code='front.web.view.common.payment.virtual.account'/></i>
												</c:when>
												<c:when test="${orderPay.payMeansCd eq frontConstants.PAY_MEANS_70}">
													<i class="t"><spring:message code='front.web.view.common.payment.naverPay'/></i>
												</c:when>
												<c:when test="${orderPay.payMeansCd eq frontConstants.PAY_MEANS_71}">
													<i class="t"><spring:message code='front.web.view.common.payment.kakaoPay'/></i>
												</c:when>
												<c:when test="${orderPay.payMeansCd eq frontConstants.PAY_MEANS_72}">
													<i class="t"><spring:message code='front.web.view.common.payment.payco'/></i>
												</c:when>
												<%--<c:when test="${orderPay.payMeansCd eq frontConstants.PAY_MEANS_10}">
													<i class="t">신용카드</i>
												</c:when>
												<c:when test="${orderPay.payMeansCd eq frontConstants.PAY_MEANS_10}">
													<i class="t">신용카드</i>
												</c:when>--%>
											</c:choose>
	
										</div>
										<c:choose>
											<c:when test="${orderPay.payMeansCd eq frontConstants.PAY_MEANS_10 or orderPay.payMeansCd eq frontConstants.PAY_MEANS_11}">
												<div class="dd">${orderPay.cardcNm} (${orderPay.cardNo})/<c:choose>
																											<c:when test="${orderPay.instmntInfo eq  frontConstants.SINGLE_INSTMNT  or empty orderPay.instmntInfo}">일시불</c:when>
																											<c:otherwise>${orderPay.instmntInfo}개월</c:otherwise>
																										</c:choose>
																										<c:if test="${orderPay.fintrYn eq '무이자'}">(${orderPay.fintrYn})</c:if>
												</div>
											</c:when>
											<c:when test="${orderPay.payMeansCd eq frontConstants.PAY_MEANS_30}">
												<div class="dd">${orderPay.bankNm}(${orderPay.acctNo}) / 입금기한 ${orderPay.dpstSchdDtNm}까지</div>
											</c:when>
											<c:when test="${orderPay.payMeansCd eq frontConstants.PAY_MEANS_20}">
												<div class="dd">${orderPay.bankNm}</div>
											</c:when>
										</c:choose>
									</div>
								</div>
							</section>
						</c:if>
						
						<!-- 포인트 적립 없는경우 노출하지 않음 -->
						<c:if test="${orderPay.ordSvmn ne 0 or (not empty mpVO and mpVO.saveSchdPnt ne 0)}">
						<section class="sect bprc point">
							<div class="hdts"><span class="tit">&nbsp;</span></div>
							<div class="cdts">
								<c:choose>
									<c:when test="${empty mpVO or mpVO.saveSchdPnt eq 0 }">
										<!-- 02 주문서-우주멤버십 등록 안한 경우 -->
										<c:if test="${orderPay.ordSvmn gt 0 or (not empty reviewPnt and reviewPnt.useYn eq frontConstants.COMM_YN_Y)}">
											<div class="gdpnt onlygs">
												<ul class="gsr">
													<li>
														<c:if test="${orderPay.ordSvmn gt 0 }">
															<div class="titbox"><div class="tit">GS&POINT</div> <div><em class="p"><frame:num data="${orderPay.ordSvmn}"/>P</em> 적립예정</div></div>
														</c:if>
														<c:if test="${not empty reviewPnt and reviewPnt.useYn eq frontConstants.COMM_YN_Y}">
															<div class="log-p" style="">로그 후기 작성시 <em class="p"><frame:num data="${reviewPnt.usrDfn1Val}"/>P</em> 추가적립</div>
														</c:if>
													</li>
												</ul>
											</div>
										</c:if>
									</c:when>
									<c:when test="${mpVO.saveSchdPnt gt 0 and (empty mpVO.addSaveSchdPnt or mpVO.addSaveSchdPnt eq 0) }">
										<!-- 03 주문서-멤버십 둘다 등록 한 경우 -->
										<div class="gdpnt member">
											<ul class="">
												<c:if test="${orderPay.ordSvmn gt 0 or (not empty reviewPnt and reviewPnt.useYn eq frontConstants.COMM_YN_Y)}">
													<li class="gsr">
														<c:if test="${orderPay.ordSvmn gt 0 }">
															<div class="titbox"><div class="tit">GS&POINT</div> <div><em class="p"><frame:num data="${orderPay.ordSvmn}"/>P</em> 적립예정</div></div>
														</c:if>
														<c:if test="${not empty reviewPnt and reviewPnt.useYn eq frontConstants.COMM_YN_Y}">
															<div class="log-p" style="">로그 후기 작성시 <em class="p"><frame:num data="${reviewPnt.usrDfn1Val}"/>P</em> 추가적립</div>
														</c:if>
													</li>
												</c:if>
												<li class="wooju">
													<div class="tit">우주코인</div> 
													<div>	
														<c:if test="${(mpVO.saveSchdPnt + mpVO.addSaveSchdPnt) ge mpVO.maxSavePnt}">
															<em class="blt max">최대</em> 
														</c:if>
														<em class="p"><frame:num data="${mpVO.saveSchdPnt }"/>C</em><span>적립예정</span>
													</div>
												</li>
											</ul>
										</div>
									</c:when>
									<c:when test="${not empty mpVO.addSaveSchdPnt and mpVO.addSaveSchdPnt gt 0 }">
										<!-- 04 우주코인 추가적립 진행하는 경우 : 21.08.10 -->
										<div class="gdpnt wooju_">
											<ul class="">
												<c:if test="${orderPay.ordSvmn gt 0 or (not empty reviewPnt and reviewPnt.useYn eq frontConstants.COMM_YN_Y)}">
													<li class="gsr">
														<c:if test="${orderPay.ordSvmn gt 0 }">
															<div class="tit">GS&POINT</div><div><em class="p"><frame:num data="${orderPay.ordSvmn}"/>P</em> 적립예정</div>
														</c:if>
														<c:if test="${not empty reviewPnt and reviewPnt.useYn eq frontConstants.COMM_YN_Y}">
															<div class="log-p" style="">로그 후기 작성시 <em class="p"><frame:num data="${reviewPnt.usrDfn1Val}"/>P</em> 추가적립</div>
														</c:if>
													</li>
												</c:if>
												<li class="wj_addp wooju">
													<div class="tit">우주코인</div> 
													<div class="wj_point_box">
														<div>
															<c:if test="${(mpVO.saveSchdPnt + mpVO.addSaveSchdPnt) ge mpVO.maxSavePnt}">
																<em class="blt max">최대</em> 
															</c:if>
															<em class="p"><frame:num data="${mpVO.saveSchdPnt }"/>C</em>
														</div> 
														<div><em class="p"> + 추가 <frame:num data="${mpVO.addSaveSchdPnt }"/>C</em><span>적립예정</span></div>
													</div>
												</li>
											</ul>
										</div>
									</c:when>
								</c:choose>
								<div class="info-t3">구매확정 후 포인트가 적립됩니다.</div>
							</div>
						</section>
						</c:if>
						
						<div class="my_btnWrap">
							<div class="btnSet">
								<a href="/mypage/order/indexDeliveryDetail?ordNo=${orderPay.ordNo}&mngb=OC" class="btn lg d">상세 주문내역</a>
								<a href="/shop/home/" class="btn lg a">계속 쇼핑하기</a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</main>
	</tiles:putAttribute>
</tiles:insertDefinition>
<c:if test="${view.deviceGb != frontConstants.DEVICE_GB_10}">
	<script>
		$("#header_pc, .menubar").hide()
	</script>
</c:if>