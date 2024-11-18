<tiles:insertDefinition name="no_lnb">
	<tiles:putAttribute name="content">
		<script type="text/javascript"  src="${pageContext.request.contextPath }/_script/orderPayment.js" ></script>
		<script>
        (function(j,en,ni,fer) {
            j['dmndata']=[];j['jenniferFront']=function(args){window.dmndata.push(args)};
            j['dmnaid']=fer;j['dmnatime']=new Date();j['dmnanocookie']=false;j['dmnajennifer']='JENNIFER_FRONT@INTG';
            var b=Math.floor(new Date().getTime() / 60000) * 60000;var a=en.createElement(ni);
            a.src='https://d-collect.jennifersoft.com/'+fer+'/demian.js?'+b;a.async=true;
            en.getElementsByTagName(ni)[0].parentNode.appendChild(a);
            }(window,document,'script','73848c73'));
        </script>
		<script>
			// GTM
			var digitalData = digitalData || {};
			var cartInfo = new Array();
			<c:forEach items="${orderGoodsList}" var="item">
				var thisProduct = {};
				var thisOpt = new Array();
				thisProduct.name = "${item.goodsNm}";
				thisProduct.id = "${item.goodsId}";
				thisProduct.category = "${item.dispCtgPath}";
				thisProduct.brand = "${item.bndNmKo}";
				thisProduct.quantity = "${item.buyQty}";
				thisProduct.price = "${item.buyAmt}";
				//묶음 상품일때 variant 옵션명으로 표시
				if("${item.goodsCstrtTpCd}" == 'PAK'){
					thisProduct.variant = "${item.optGoodsNm}";
				//묶음 상품이 아닐 때  variant 옵션명으로 표시
				}else if("${item.goodsCstrtTpCd}" != 'PAK'){
					<c:forEach items="${item.goodsOptList}" var="opt">
						thisOpt.push("${opt.showNm}:${opt.attrVal}");
					</c:forEach>
					thisProduct.variant = thisOpt.join("/");
					//variant 가 "" 인 경우 상품 아이디로 표시
					if(thisProduct.variant == ''){
						thisProduct.variant = "${item.goodsId}";
					}
				}
				cartInfo.push(thisProduct);
			</c:forEach>
			digitalData.checkoutInfo = cartInfo;
		</script>
		<style>
			.custom_ellipsis_dlvr{
				display: -webkit-box;
				text-overflow: ellipsis;
				-webkit-box-orient: vertical;
				-webkit-line-clamp: 1;
				overflow: hidden;
			}
		</style>
		<main class="container page shop od order" id="container">
			<!-- 페이지 헤더 -->
			<div class="pageHeadPc">
				<div class="inr">
					<div class="hdt">
						<h3 class="tit">주문결제</h3>
					</div>
				</div>
			</div>

			<div class="inr">

				<!-- 본문 -->
				<form id="order_payment_form" name="order_payment_form">

					<c:set var="goodsCnt" value="0" />
					<c:set var="goodsQty" value="0" />
					<c:set var="totalGoodsAmt" value="0" />

					<%--<c:set var="birth" value="${memberBase.birth}" />--%>

						<%--주문번호--%>
					<input type="hidden" id="order_payment_ord_no" name="ordNo" value="">
						<%--주문생성 값--%>
					<input type="hidden" id="mbrNo" name="mbrNo" value="<c:out value='${session.mbrNo}' />">
					<input type="hidden" id="gsptNo" name="gsptNo" value="<c:out value='${memberBase.gsptNo}' />">
					<input type="hidden" id="ordNm" name="ordNm" value="<c:out value='${memberBase.mbrNm}'/>">
					<input type="hidden" id="ordrEmail" name="ordrEmail" value="<c:out value='${memberBase.email}'/>">
					<input type="hidden" id="ordrTel" name="ordrTel" value="<c:choose><c:when test="${memberBase.tel eq null or memberBase.tel eq ''}">${memberBase.mobile}</c:when><c:otherwise>${memberBase.tel}</c:otherwise></c:choose>">
					<input type="hidden" id="ordrMobile" name="ordrMobile" value="<c:out value='${memberBase.mobile}'/>">
					<input type="hidden" id="mbrDlvraNo" name="mbrDlvraNo" value="${address.mbrDlvraNo}">
					<input type="hidden" id="gbNm" name="gbNm" value="">
					<input type="hidden" id="adrsNm" name="adrsNm" value="">
					<input type="hidden" id="adrsMobile" name="adrsMobile" value="">
					<input type="hidden" id="adrsTel" name="adrsTel" value="">
					<input type="hidden" id="postNoNew" name="postNoNew" value="">
					<input type="hidden" id="roadAddr" name="roadAddr" value="">
					<input type="hidden" id="roadDtlAddr" name="roadDtlAddr" value="">
					<input type="hidden" id="dlvrPrcsTpCd" name="dlvrPrcsTpCd" value="">

						<%--<input type="hidden" id="rfdBankCd" name="rfdBankCd" value="">
                        <input type="hidden" id="rfdAcctNo" name="rfdAcctNo" value="">
                        <input type="hidden" id="rfdOoaNm" name="rfdOoaNm" value="">
                        <input type="hidden" id="refAcctCertYn" name="refAcctCertYn" value="">--%>

						<%--쿠폰정보--%>
					<input type="hidden" id="cpInfos" name="cpInfos" value="">

						<%--상품--%>
					<input type="hidden" name="cartIds" id="cartIds" value="">
					<input type="hidden" name="pkgDlvrNos" id="pkgDlvrNos" value="">
					<input type="hidden" name="pkgDlvrAmts" id="pkgDlvrAmts" value="">
					<input type="hidden" name="goodsNms" id="goodsNms" value="">
					<input type="hidden" name="goodsIds" id="goodsIds" value="">

						<%--배송요청사항--%>
					<input type="hidden" name="goodsRcvPstCd" id="goodsRcvPstCd" value="">
					<input type="hidden" name="goodsRcvPstEtc" id="goodsRcvPstEtc" value="">
					<input type="hidden" name="pblGateEntMtdCd" id="pblGateEntMtdCd" value="">
					<input type="hidden" name="pblGatePswd" id="pblGatePswd" value="">
					<input type="hidden" name="dlvrDemand" id="dlvrDemand" value="">
					<input type="hidden" name="dlvrDemandYn" id="dlvrDemandYn" value="N">
					<input type="hidden" name="mbrAddrInsertYn" id="mbrAddrInsertYn" value="">
				
						<%--배송 권역 매핑--%>
					<input type="hidden" name="ordDt" id="ordDt" value="">
					<input type="hidden" name="dlvrAreaNo" id="dlvrAreaNo" value="">

						<%--결제수단--%>
					<input type="hidden" id="payMeansCd" name="payMeansCd" value="${paySaveInfo.payMeansCd}">
					<input type="hidden" id="defaultPayMethodSaveYn" name="defaultPayMethodSaveYn" value="Y">
					<input type="hidden" id="cashReceiptInfoSave" name="cashReceiptInfoSave" value="">
					<input type="hidden" id="cardcCd" name="cardcCd" value="<c:if test="${paySaveInfo.cardcCd ne null or paySaveInfo.cardcCd ne ''}"> ${paySaveInfo.cardcCd} </c:if>">
					<input type="hidden" name="cardNo" id="cardNo" value=""/>
					<input type="hidden" name="halbu" id="cardQuota" value=""/>
					<input type="hidden" name="CardInterest" id="cardInterest" value="0"/>

						<%--결제 관련 금액--%>
					<input type="hidden" id="payAmt" name="payAmt" value="">

					<!-- 포인트 정보 -->
					<input type="hidden" id="ordUseGsPoint" name="useGsPoint" value="" />
					<input type="hidden" id="ordUseMpPoint" name="useMpPoint" value="" />
					<input type="hidden" id="ordRealUseMpPoint" name="realUseMpPoint" value="" />
					<input type="hidden" id="ordMpCardNo" name="mpCardNo" value="" />
					<input type="hidden" id="ordPinNo" name="pinNo" value="" />
					
					<%--NICEPAY--%>
					<input type="hidden" name="PayMethod" id="payMethod" value="">	<%--결제수단--%>
					<input type="hidden" name="SelectCardCode" id="selectCardCode" value="<c:if test="${paySaveInfo.cardcCd ne null and paySaveInfo.cardcCd ne ''}"> ${paySaveInfo.cardcCd} </c:if>">	<%--결제수단 카드사 코드--%>
					<input type="hidden" name="GoodsName" id="goodsName" value="${orderGoodsList[0].goodsNm} <c:if test="${(fn:length(orderGoodsList) > 1)}">(외${fn:length(orderGoodsList)-1 })</c:if>">	<%--대표상품명--%>
					<input type="hidden" name="Amt" id="amt" value="">	<%--결제금액--%>
					<input type="hidden" name="MID" id="mid" value="">	<%--상점아이디--%>
					<input type="hidden" name="Moid" id="moid" value="">	<%--주문번호--%>
					<input type="hidden" name="BuyerName" id="buyerName" value='${memberBase.mbrNm}'>	<%--주문자--%>
					<input type="hidden" name="BuyerEmail" id="buyerEmail" value='${memberBase.email}'>	<%--주문자 이메일--%>
					<input type="hidden" name="BuyerTel" id="buyerTel" value='${memberBase.mobile}'>	<%--주문자 휴대폰--%>
					<input type="hidden" name="ReturnURL" id="returnUrl" value="https://${pageContext.request.serverName}${pageContext.request.contextPath}/pay/nicepay/popupPaymentResultForMo">	<%--ReturnURL--%>
					<input type="hidden" name="VbankExpDate" id="vBankExpDate" value="${vbankExpDate }">	<%--가상계좌입금만료일(YYYYMMDD)--%>

					<%-- 앱일 경우만 파라미터 전달 --%>
					<c:if test="${view.deviceGb eq frontConstants.DEVICE_GB_30 }">
						<input type="hidden" name="WapUrl" id="WapUrl" value="aboutpetpg://">	<%--결제완료 후 돌아올 앱스키마--%>
						<input type="hidden" name="IspCancelUrl" id="IspCancelUrl" value="aboutpetpg://">	<%--취소버튼클릭시 돌아올 앱스키마--%>
					</c:if>
					<!-- 옵션 -->
					<input type="hidden" name="GoodsCl" id="goodsCl" value="1"/>						<!-- 상품구분(실물(1),컨텐츠(0)) -->
					<input type="hidden" name="TransType" id="transType" value="0"/>					<!-- 일반(0)/에스크로(1) -->
					<input type="hidden" name="CharSet" id="charSet" value="utf-8"/>				<!-- 응답 파라미터 인코딩 방식 -->
					<input type="hidden" name="ReqReserved" id="reqReserved" value=""/>					<!-- 상점 예약필드 -->
					<input type="hidden" name="DirectShowOpt" id="directShowOpt" value=""/>				<!-- 직접 호출 옵션 -->
					<input type="hidden" name="NicepayReserved" id="nicepayReserved" value=""/>				<!-- 나이스페이 복합 옵션 -->

					<!-- 계좌이체 옵션(현금영수증) -->
					<input type="hidden" name="directRcptType" id="directRcptType" value=""/>				<!-- 현금영수증 발급 유형 -->
					<input type="hidden" name="directRcptNo" id="directRcptNo" value=""/>				<!-- 현금영수증 번호 -->
					<input type="hidden" name="directRcptNoType" id="directRcptNoType" value=""/>				<!-- 현금영수증 번호 유형 -->

					<!-- 카드 옵션 -->
					<input type="hidden" name="SelectQuota" id="selectQuota" value="00"/>					<!-- 할부개월 제한 -->
					<input type="hidden" name="ShopInterest" id="shopInterest" value="0"/>					<!-- 할부개월 제한 -->
					<input type="hidden" name="DirectCardPointFlag" id="directCardPointFlag" value=""/>			<!-- 카드포인트 사용 옵션 -->
					<input type="hidden" name="DirectEasyPay" id="directEasyPay" value=""/>				<!-- 간편결제 제휴사 인증창 바로 호출 옵션 -->
					<input type="hidden" name="DirectCouponYN" id="directCouponYN" value=""/>			<!-- 신용카드 쿠폰 자동적용여부 -->

					<!-- 카카오페이 옵션 -->
					<input type="hidden" name="EasyPayCardCode" id="easyPayCardCode" value=""/>				<!-- 간편결제 카드코드 -->
					<input type="hidden" name="EasyPayQuota" id="easyPayQuota" value=""/>				<!-- 간편결제 할부개월 -->

					<!-- 페이코 옵션 -->
					<input type="hidden" name="EasyPayShopInterest" id="easyPayShopInterest" value=""/>			<!-- 간편결제 상점 무이자 미사용(0)/사용(1) -->
					<input type="hidden" name="EasyPayQuotaInterest" id="easyPayQuotaInterest" value=""/>			<!-- 간편결제 상점무이자 설정 -->
					<input type="hidden" name="PaycoClientId" id="paycoClientId" value=""/>				<!-- 페이코 자동로그인 ID -->
					<input type="hidden" name="PaycoAccessToken" id="paycoAccessToken" value=""/>				<!-- 페이코 자동로그인 토큰 -->

					<!-- 네이버페이 옵션 -->
					<input type="hidden" name="EasyPayMethod" id="easyPayMethod" value=""/>				<!-- 간편결제 지불수단 지정 -->

					<!-- 변경 불가능 -->
					<input type="hidden" name="EdiDate" id="ediDate" value=""/>			<!-- 전문 생성일시 -->
					<input type="hidden" name="SignData" id="signData" value=""/>	<!-- 해쉬값 -->

						<%-- <input type="hidden" id="CashReceiptType" name="CashReceiptType" value="0" />현금영수증 타입 (0: 미발행, 1: 소득공제. 2: 지출증빙)
                        <input type="hidden" id="ReceiptTypeNo" name="ReceiptTypeNo" value="" />휴대폰번호 또는 사업자번호
                        <input type="hidden" id="bankCode" name="BankCode" value="020" /> 은행코드
                        <input type="hidden" id="vbankExpDate" name="VbankExpDate" value="" /> 가상계좌 입금만료일
                        <input type="hidden" id="vbankAccountName" name="VbankAccountName" value="정정용" /> 가상계좌 예금주명 --%>

					<input type="hidden" id="authResultCode" name="authResultCode" value="" />
					<input type="hidden" id="authResultMsg" name="authResultMsg" value="" />
					<input type="hidden" id="nextAppURL" name="nextAppURL" value="" />
					<input type="hidden" id="txTid" name="txTid" value="" />
					<input type="hidden" id="authToken" name="authToken" value="" />
					<input type="hidden" id="payMethod" name="payMethod" value="" />
					<input type="hidden" id="mid" name="mid" value="" />
					<input type="hidden" id="moid" name="moid" value="" />
					<input type="hidden" id="finalPayamt" name="finalPayamt" value="" />
					<input type="hidden" id="reqReserved" name="reqReserved" value="" />
					<input type="hidden" id="reqReserved" name="reqReserved" value="" />
					<input type="hidden" id="netCancelURL" name="netCancelURL" value="" />
					<input type="hidden" id="cardCode" name="cardCode" value="" />
					<input type="hidden" id="resultCode" name="resultCode" value="" />
					<input type="hidden" id="resultMsg" name="resultMsg" value="" />
					<input type="hidden" id="tid" name="TID" value="" />
					<input type="hidden" id="authCode" name="authCode" value="" />
					<input type="hidden" id="authDate" name="authDate" value="" />
					<input type="hidden" id="bankName" name="bankName" value="" />
					<input type="hidden" id="rcpType" name="rcpType" value="" />
					<input type="hidden" id="rcptTID" name="rcptTID" value="" />
					<input type="hidden" id="rcptAuthCode" name="rcptAuthCode" value="" />
					<input type="hidden" id="vbankBankCode" name="vbankBankCode" value="" />
					<input type="hidden" id="vbankBankName" name="vbankBankName" value="" />
					<input type="hidden" id="tivbankNumd" name="vbankNum" value="" />
					<input type="hidden" id="vbankExpTime" name="vbankExpTime" value="" />
					<input type="hidden" id="prsnCardBillNo" name="prsnCardBillNo" value="<c:if test="${paySaveInfo.prsnCardBillNo ne null and paySaveInfo.prsnCardBillNo ne ''}"> ${paySaveInfo.prsnCardBillNo} </c:if>" />
					<input type="hidden" id="birth" value="<c:if test="${memberBase.birth ne null and memberBase.birth ne ''}"> ${memberBase.birth} </c:if>">
				</form>
				<input type="hidden" id="gb10Cnt" value="${gb10Cnt }"/>
				<input type="hidden" id="ciCtfVal" value="<c:if test="${memberBase.ciCtfVal ne null and memberBase.ciCtfVal ne ''}"> ${memberBase.ciCtfVal} </c:if>" />
				<div class="contents" id="contents">
					<div class="ordersets">
						<section class="sect usrs">
							<div class="hdts"><span class="tit">주문 고객 정보</span></div>
							<div class="cdts">
								<div class="box">
									<c:choose>
										<c:when test="${ empty memberBase.mbrNm or empty memberBase.mobile}">
											<c:set var="memberYn" value="N"/>
										</c:when>
										<c:otherwise>
											<c:set var="memberYn" value="Y"/>
										</c:otherwise>
									</c:choose>
									
									<div class="cdts" id="noMemDiv" ${memberYn eq 'N' ? ' ' : ' style="display:none;"'}>
										<div class="ptset">
											<a href="javascript:;" class="btn md d" id="nonMemberCert" onclick="selectCertType('nonMember');">본인인증</a>
										</div>
										<div class="ptt" style="margin-top: 10px"><b class="t">상품을 구매하기 위해서는 본인확인이 필요합니다.</b></div>
									</div>
									<div class="usr" id="memDiv" ${memberYn eq 'Y' ? ' ' : ' style="display:none;"'}><em class="nm" id="memDiv-mbrNm">${memberBase.mbrNm},</em><i class="tel" id="memDiv-mobile"><frame:tel data="${memberBase.mobile}" /></i></div>
									<!-- <div class="bts"><a href="/mypage/info/indexManageDetail" class="btn c sm btMyMod">개인정보수정</a></div> -->
									
									<input type="hidden" id="memberYn" value="${memberYn}">
								</div>
							</div>
						</section>
						<c:choose>
							<c:when test="${not empty dlvrInfo.mbrDlvraNo}">
								<section class="sect addr">
									<div class="hdts"><span class="tit">배송지</span></div>
									<div class="cdts">
										<div class="adrset">
											<input type="hidden" id="order_payment_gb_nm" value="<c:out value='${dlvrInfo.gbNm}'/>">
											<input type="hidden" id="order_payment_mbr_dlvra_no" value="<c:out value='${dlvrInfo.mbrDlvraNo}'/>">
											<input type="hidden" id="order_payment_post_no_new" value="<c:out value='${dlvrInfo.postNoNew}'/>">
											<input type="hidden" id="order_payment_road_addr" value="<c:out value='${dlvrInfo.roadAddr}'/>">
											<input type="hidden" id="order_payment_road_dtl_addr" value="<c:out value='${dlvrInfo.roadDtlAddr}'/>">
											<input type="hidden" id="order_payment_adrs_nm" value="<c:out value='${dlvrInfo.adrsNm}'/>">
											<input type="hidden" id="order_payment_adrs_mobile" value="<c:out value='${dlvrInfo.adrsMobile}'/>">
											<input type="hidden" id="order_payment_demand_goods_rcv_pst_cd" value="<c:out value='${dlvrInfo.goodsRcvPstCd}'/>">
											<input type="hidden" id="order_payment_demand_goods_rcv_pst_etc" value="<c:out value='${dlvrInfo.goodsRcvPstEtc}'/>">
											<input type="hidden" id="order_payment_demand_pbl_gate_ent_mtd_cd" value="<c:out value='${dlvrInfo.pblGateEntMtdCd}'/>">
											<input type="hidden" id="order_payment_demand_pbl_gate_pswd" value="<c:out value='${dlvrInfo.pblGatePswd}'/>">
											<input type="hidden" id="order_payment_dlvr_demand" value="<c:out value='${dlvrInfo.dlvrDemand}'/>">
											<input type="hidden" id="order_payment_dlvr_demand_yn" value="<c:out value='${dlvrInfo.dlvrDemandYn}'/>">
											<div class="name tx">
												<em class="t" id="dlvraGbNmEm"><c:out value="${dlvrInfo.escapedGbNm}" escapeXml="false"/></em><em class="bdg" id="dftDelivery" ${dlvrInfo.orderDeliverySel eq 'default' ? ' ' : ' style="display:none;"'}>기본배송지</em>
											</div>
											<div class="adrs" id="dlvraAdrsDiv">
												[${dlvrInfo.postNoNew}] ${dlvrInfo.roadAddr}, <c:out value="${dlvrInfo.escapedRoadDtlAddr}" escapeXml="false"/>
											</div>
											<div class="tels" id="dlvraTelsDiv">
													<c:out value="${dlvrInfo.escapedAdrsNm}" escapeXml="false"/>/<frame:tel data="${dlvrInfo.adrsMobile}" />
											</div>
											<div class="bts"><a href="javascript:;" onclick="orderDlvra.addressListPop();" data-content="layerAlert" data-url="/mypage/service/popupAddressList" class="btn c sm btnDeMod">배송지 변경</a></div>
										</div>
										<div class="adrreq">
											<div class="tit">배송 요청사항</div>
											<div class="pwf" id="existDemand" ${dlvrInfo.dlvrDemandYn eq 'Y' ? ' ' : ' style="display:none"'}>
												<em class="t" id="demandGoodsRcvPstCd">
													<c:choose>
											  			<c:when test="${dlvrInfo.goodsRcvPstCd eq frontConstants.GOODS_RCV_PST_40}">
											  				<c:out value="${dlvrInfo.escapedGoodsRcvPstEtc}" escapeXml="false"/>
											  			</c:when>
											  			<c:otherwise>
											  				<frame:codeValue items = "${goodsRcvPstList}" dtlCd="${dlvrInfo.goodsRcvPstCd }"/>
											  			</c:otherwise>
											  		</c:choose>
												</em>
												<em class="p" id="demandPblGateEntMtdCd">
												<frame:codeValue items = "${pblGateEntMtdList}" dtlCd="${dlvrInfo.pblGateEntMtdCd }"/>&nbsp; 
													<if test="${dlvrInfo.pblGateEntMtdCd eq frontConstants.PBL_GATE_ENT_MTD_10}">
										  				<c:out value="${ dlvrInfo.escapedPblGatePswd}" escapeXml="false"/>
										  			</if>
												</em>
												<div class="txt custom_ellipsis_dlvr" id="demandDlvrDemand"><c:out value="${dlvrInfo.escapedDlvrDemand}" escapeXml="false"/></div>
												<div class="btt"><a href="javascript:;" class="btn sm btMod" onclick="orderDlvra.changeDlvrDemandPop();">변경</a></div>
											</div>
											<div class="pss" id="noExistDemand" ${dlvrInfo.dlvrDemandYn eq 'Y' ? ' style="display:none"' : ' '}>
												<a href="javascript:;" class="btn btPdPl " onclick="orderDlvra.changeDlvrDemandPop();">상품 수령 장소를 선택해주세요.</a>
											</div>
										</div>
									</div>
								</section>
							</c:when>
							<c:otherwise>
								<section class="sect addr">
									<input type="hidden" id="order_payment_post_no_new" value="">
									<input type="hidden" id="order_payment_road_addr" value="">
									<input type="hidden" id="order_payment_mbr_dlvra_no" value="">
									<input type="hidden" id="order_payment_demand_goods_rcv_pst_cd" value="">
									<input type="hidden" id="order_payment_demand_goods_rcv_pst_etc" value="">
									<input type="hidden" id="order_payment_demand_pbl_gate_ent_mtd_cd" value="">
									<input type="hidden" id="order_payment_demand_pbl_gate_pswd" value="">
									<input type="hidden" id="order_payment_dlvr_demand" value="">
									<input type="hidden" id="order_payment_dlvr_demand_yn" value="N">

									<div class="hdts"><span class="tit">배송지</span></div>
									<div class="cdts">
										<ul class="adrlist">
											<li class="name">
												<div class="dt">배송지 명칭</div>
												<div class="dd"><span class="input"><input type="text" maxlength="20" id="order_payment_gb_nm" placeholder="배송지 명칭을 입력해주세요."></span></div>
											</li>
											<li class="usr">
												<div class="dt">받는 사람</div>
												<div class="dd"><span class="input"><input type="text" maxlength="20" id="order_payment_adrs_nm" placeholder="이름을 입력해주세요."></span></div>
											</li>
											<li class="tel">
												<div class="dt">휴대폰번호</div>
												<div class="dd"><span class="input"><input type="text" maxlength="11" id="order_payment_adrs_mobile" placeholder="'-'빼고 숫자만 입력해주세요."></span></div>
											</li>
											<li class="arr">
												<div class="dt">주소</div>
												<div class="dd">
													<div class="adrbox a1">
														<div class="adr" id="addressInfo">주소를 검색해주세요.</div>
														<a href="javascript:;" class="btAdr" onclick="orderDlvra.openPostPop();">주소검색</a>
													</div>
													<div class="adrbox a2" style="display:none;">
														<span class="input"><input type="text" maxlength="30" id="order_payment_road_dtl_addr" placeholder="상세주소를 입력하세요."></span>
													</div>
												</div>
											</li>
										</ul>
										<div class="adrreq" style="display: none">
											<div class="tit">배송 요청사항</div>
											<div class="pwf" id="existDemand" style="display: none">
												<em class="t" id="demandGoodsRcvPstCd"></em>
												<em class="p" id="demandPblGateEntMtdCd"></em>
												<div class="txt" id="demandDlvrDemand"></div>
												<div class="btt"><a href="javascript:;" class="btn sm btMod" onclick="orderDlvra.changeDlvrDemandPop();">변경</a></div>
											</div>
											<div class="pss" id="noExistDemand">
												<a href="javascript:;" class="btn btPdPl" onclick="orderDlvra.changeDlvrDemandPop();" >상품 수령 장소를 선택해주세요.</a>
											</div>
										</div>
										<div class="saves">
											<div class="pp"><label class="checkbox"><input type="checkbox" id="order_payment_adrs_insert_yn" checked value="Y"><span class="txt" ><em class="tt">등록한 정보를 회원정보에 반영합니다. (휴대폰번호/주소)</em></span></label></div>
											<!-- <div class="pp"><label class="checkbox"><input type="checkbox" id="order_payment_adrs_dft_yn" checked value="Y"><span class="txt" ><em class="tt">기본 배송지로 등록</em></span></label></div> -->
										</div>
									</div>
								</section>
							</c:otherwise>
						</c:choose>

							<%-- 배송마감 템플릿 --%>
						<ul id="dlvrAreaClosed01" style="display:none;">
							<li>
								<label class="radio">
									<input type="radio" name="rdb_deli_a" disabled >
									<div class="txt">
										<div class="hdd">
											<span class="tts">새벽배송</span>
											<span class="msg"></span>
										</div>
									</div>
								</label>
							</li>
						</ul>
						<c:set var="goodsNm10" value=""/>
						<c:set var="goodsNm20" value=""/>
							<%-- 대표상품 --%>
						<c:set var="preBookYn" value="N"/>
						<c:forEach items="${orderGoodsList}" var="orderGoods" varStatus="idx">
							<c:set var="goodsNm10" value="${(goodsNm10 eq '' && orderGoods.compGbCd eq '10') ? orderGoods.goodsNm: goodsNm10 }"/>
							<c:set var="goodsNm20" value="${(goodsNm20 eq '' && orderGoods.compGbCd eq '20') ? orderGoods.goodsNm: goodsNm20 }"/>
							<c:if test="${orderGoods.goodsAmtTpCd eq frontConstants.GOODS_AMT_TP_60 }">
								<c:set var="preBookYn" value="Y"/>
							</c:if>
						</c:forEach>
						<input type="hidden" id="preBookYn" value="${preBookYn }" />
						<%-- 배송내역 표시 템플릿 --%>
						<ul id="dlvrAreaTmpl01" style="display:none;">
							<li>
								<label class="radio">
									<input type="radio" name="rdb_deli_a">
									<div class="txt iconArea">
										<div class="hdd">
											<span class="tts"></span>
											<span class="msg"></span>
										</div>
										<div class="cdd pd_tog_box ${gb10Cnt ==  1 ? 'open':''}" style="display: none">
											<c:if test="${gb10Cnt > 1}">
												<button type="button" class="btTog">버튼</button>
												<div class="htt" style=""><span class="tt">${goodsNm10}</span> <i class="aa">외 <c:out value="${gb10Cnt-1}" default="0"/>개</i></div>
											</c:if>
											<ul class="lst">
												<c:forEach items="${orderGoodsList}" var="orderGoods" varStatus="idx">
													<c:if test="${orderGoods.compGbCd eq '10'}">
														<c:choose>
															<c:when test="${orderGoods.prmtDcAmt eq null or orderGoods.prmtDcAmt eq 0}">
																<c:set var="goodsAmt" value="${(orderGoods.salePrc) * orderGoods.buyQty}" />
															</c:when>
															<c:otherwise>
																<c:set var="goodsAmt" value="${(orderGoods.salePrc - orderGoods.prmtDcAmt) * orderGoods.buyQty}" />
															</c:otherwise>
														</c:choose>
														<c:set var="totalGoodsAmt" value="${totalGoodsAmt + goodsAmt}" />
														<li>
															<div class="tt">${orderGoods.goodsNm}</div>
															<c:if test="${orderGoods.goodsCstrtTpCd eq frontConstants.GOODS_CSTRT_TP_PAK and  not empty orderGoods.optGoodsNm}" >
																<div class="ts">${orderGoods.optGoodsNm }</div>
															</c:if>
															<c:if test="${orderGoods.goodsCstrtTpCd eq frontConstants.GOODS_CSTRT_TP_ATTR and fn:length(orderGoods.goodsOptList) > 0 }">
																<div class="ts">
																	<c:forEach var="goodsOpt" items="${orderGoods.goodsOptList }" varStatus="optStatus">
																		${goodsOpt.showNm } : ${goodsOpt.attrVal} ${!optStatus.last ? ' / ' : '' }
																	</c:forEach>
																</div>
															</c:if>
															<c:if test="${orderGoods.mkiGoodsYn eq 'Y' && not empty orderGoods.mkiGoodsOptContent}">
																<c:forTokens var="optContent" items="${orderGoods.mkiGoodsOptContent }" delims="|" varStatus="conStatus">
																	<div class="ts">각인문구${conStatus.count} ${!optStatus.last ? ' / ' : '' } ${optContent}</div>
																</c:forTokens>
															</c:if>
															<c:set var="dlgtFreebieYn" value="N" />
															<c:forEach var="freebie" items="${orderGoods.freebieList}" varStatus="freeStatus">
																<!-- 대표사은품 1개만 노출 -->
																<c:if test="${freebie.qty > 0 && dlgtFreebieYn eq 'N'}">
																	<c:set var="dlgtFreebieYn" value="Y" />
																	<div class="ts" data-isFreeBie="Y" data-buy-qty="${orderGoods.buyQty}" data-goods-id="${orderGoods.goodsId}" >${freebie.goodsNm}</div>
																</c:if>
															</c:forEach>
															<div class="ts">${orderGoods.buyQty}개 / <frame:num data="${goodsAmt}" />원</div>
														</li>
													</c:if>
												</c:forEach>
											</ul>
										</div>
									</div>
								</label>
							</li>
						</ul>
							<%-- 업체배송 템플릿 --%>
						<ul id="dlvrAreaTmpl02" style="display:none;">
								<%-- 업체배송 --%>
							<c:if test="${gb20Cnt > 0}">
								<li id="dlvrPrcsTp10">
									<div class="denor"><!-- 여러개 일때 -->
										<div class="hdd">
											<span class="tts">업체 택배배송</span>
											<span class="msg">2~7일 소요 예정<br>(상품 상세페이지 참고)</span>
										</div>
										<div class="cdd pd_tog_box ${gb20Cnt == 1 ? 'open':''}">
											<c:if test="${gb20Cnt > 1}">
												<button type="button" class="btTog">버튼</button>
												<div class="htt"><span class="tt">${goodsNm20}</span> <i class="aa">외 <c:out value="${gb20Cnt-1}" default="0"/>개</i></div>
											</c:if>
											<ul class="lst">
												<c:forEach items="${orderGoodsList}" var="orderGoods" varStatus="idx">
													<c:if test="${orderGoods.compGbCd eq '20'}">
														<c:choose>
															<c:when test="${orderGoods.prmtDcAmt eq null or orderGoods.prmtDcAmt eq 0}">
																<c:set var="goodsAmt" value="${(orderGoods.salePrc) * orderGoods.buyQty}" />
															</c:when>
															<c:otherwise>
																<c:set var="goodsAmt" value="${(orderGoods.salePrc - orderGoods.prmtDcAmt) * orderGoods.buyQty}" />
															</c:otherwise>
														</c:choose>
														<c:set var="totalGoodsAmt" value="${totalGoodsAmt + goodsAmt}" />
														<li>
															<div class="tt">${orderGoods.goodsNm}</div>
															<c:if test="${orderGoods.goodsCstrtTpCd eq frontConstants.GOODS_CSTRT_TP_PAK and not empty orderGoods.optGoodsNm}" >
																<div class="ts">${orderGoods.optGoodsNm }</div>
															</c:if>
															<c:if test="${orderGoods.goodsCstrtTpCd eq frontConstants.GOODS_CSTRT_TP_ATTR and fn:length(orderGoods.goodsOptList) > 0 }">
																<div class="ts">
																	<c:forEach var="goodsOpt" items="${orderGoods.goodsOptList }" varStatus="optStatus">
																		${goodsOpt.showNm } : ${goodsOpt.attrVal} ${!optStatus.last ? ' / ' : '' }
																	</c:forEach>
																</div>
															</c:if>
															<c:if test="${orderGoods.mkiGoodsYn eq 'Y' && not empty orderGoods.mkiGoodsOptContent}">
																<c:forTokens var="optContent" items="${orderGoods.mkiGoodsOptContent }" delims="|" varStatus="conStatus">
																	<div class="ts">각인문구${conStatus.count} ${!optStatus.last ? ' / ' : '' } ${optContent}</div>
																</c:forTokens>
															</c:if>
															<c:set var="dlgtFreebieYn" value="N" />
															<c:forEach var="freebie" items="${orderGoods.freebieList}" varStatus="freeStatus">
																<!-- 대표사은품 1개만 노출 -->
																<c:if test="${freebie.qty > 0 && dlgtFreebieYn eq 'N'}">
																	<c:set var="dlgtFreebieYn" value="Y" />
																	<div class="ts" data-isFreeBie="Y" data-buy-qty="${orderGoods.buyQty}" data-goods-id="${orderGoods.goodsId}" >${freebie.goodsNm}</div>
																</c:if>
															</c:forEach>
															<div class="ts">${orderGoods.buyQty}개 / <frame:num data="${goodsAmt}" />원</div>
														</li>
													</c:if>
												</c:forEach>
											</ul>
										</div>
									</div>
								</li>
							</c:if>
						</ul>
						<section class="sect deli">
							<div class="hdts"><span class="tit">상품배송</span></div>
							<div class="cdts">
								<ul id="dlvrArea" class="drlist">
								</ul>
								<c:set var="selTotCpDcAmt" value="0"/>
								<c:forEach items="${orderGoodsList}" var="orderGoods" varStatus="idx">

									<c:set var="selTotCpDcAmt" value="${selTotCpDcAmt + orderGoods.selTotCpDcAmt}" />
									<input type="hidden" name="order_payment_cart_ids" id="order_payment_cart_ids" value="<c:out value='${orderGoods.cartId}' />"
										   data-cart-id="${orderGoods.cartId}"
										   data-buy-qty="${orderGoods.buyQty}"
										   data-goods-nm="${orderGoods.goodsNm}"
										   data-goods-id="${orderGoods.goodsId}"
										   data-dlvrc-plc-no="${orderGoods.dlvrcPlcNo}"
										   data-sel-mbr-cp-no = "${orderGoods.selMbrCpNo}"
										   data-sale-prc = "${orderGoods.salePrc}"
										   data-comp-gb-cd = "${orderGoods.compGbCd}"
									/>
									<input type="hidden" name="order_payment_pkg_dlvr_nos" id="order_payment_pkg_dlvr_nos" value="<c:out value='${orderGoods.pkgDlvrNo}' />" />
									<input type="hidden" name="order_payment_pkg_dlvr_amts" id="order_payment_pkg_dlvr_amts" value="<c:out value='${orderGoods.pkgDlvrAmt}' />" />
									<input type="hidden" name="order_payment_goods_nms" id="order_payment_goods_nms" value="<c:out value='${orderGoods.goodsNm}' />" />
									<input type="hidden" name="order_payment_goods_ids" id="order_payment_goods_ids" value="<c:out value='${orderGoods.goodsId}' />" />
								</c:forEach>
							</div>
						</section>
						<section class="sect disc" id="existCoupon">
							<div class="hdts"><span class="tit">할인 혜택</span></div>
							<div class="cdts">
								<div class="cpset"><!-- @@ 02.22 변경 -->
									<div class="ht">상품/배송비 쿠폰</div>
									<div class="dt">
										<input type="hidden" id="tot_goods_cp_dc_amt" name="tot_goods_cp_dc_amt" value="${selTotCpDcAmt }"/>
										<input type="hidden" id="tot_dlvr_cp_dc_amt" name="tot_dlvr_cp_dc_amt" value="0"/>
										<em class="prc"><b class="p" id="tot_goodsdlvr_cp_dc_amt_view">0</b><i class="w">원</i></em>
										<span class="txt">할인적용</span>
										<a href="javascript:openGoodsCouponPop();" class="btn sm btCpnMod" id="goodsCouponBtn">쿠폰 변경</a>
									</div>
								</div>
								<div class="cpset">
									<div class="ht">장바구니 쿠폰</div>
									<div class="dt">
										<input type="hidden" id="tot_cart_cp_dc_amt" name="tot_cart_cp_dc_amt" value="0"/>
										<em class="prc"><b class="p" id="tot_cart_cp_dc_amt_view">0</b><i class="w">원</i></em>
										<span class="txt">할인적용</span>
										<a href="javascript:openCartCouponPop();" class="btn sm btCpnMod"  id="cartCouponBtn">쿠폰 변경</a>
									</div>
								</div>
								<!-- <div class="nodata"><p class="p">사용 가능한 할인 쿠폰이 없습니다.</p></div> -->
							</div>
								<%-- 상품쿠폰리스트 --%>
							<div id="goodsCouponList">
								<c:forEach items="${orderGoodsList}" var="orderGoods" varStatus="idx">
									<c:if test="${not empty orderGoods.couponList}">
										<input type="hidden" name="couponInfo"
											   data-cp-kind-cd="${orderGoods.couponList[0].cpKindCd}"
											   data-cart-id="${orderGoods.cartId}"
											   data-cp-dc-amt="${orderGoods.selCpDcAmt}"
											   data-sel-mbr-cp-no = "${orderGoods.selMbrCpNo}"
											   data-tot-cp-dc-amt="${orderGoods.selTotCpDcAmt}"
											   value="${orderGoods.couponList[0].cpKindCd}|${orderGoods.cartId}|${orderGoods.selMbrCpNo}|${orderGoods.selCpDcAmt}|${orderGoods.selTotCpDcAmt}|${orderGoods.selCpNo}"
										/>
									</c:if>
								</c:forEach>
							</div>
								<%-- 배송비쿠폰리스트 --%>
							<input type="hidden" id="dlvrcCouponYn" value="N"/>
							<input type="hidden" id="cartCouponYn" value="N"/>

							<div id="dlvrCouponList"></div>
								<%-- 장바구니쿠폰리스트 --%>
							<div id="cartCouponList"></div>
						</section>
						<section class="sect disc" id="notExistCoupon" style="display: none">
							<div class="hdts"><span class="tit">할인 혜택</span></div>
							<div class="cdts">
								<div class="nodata"><p class="p">사용 가능한 할인 쿠폰이 없습니다.</p></div>
							</div>
						</section>
						<%-- GS 포인트 적립율 --%>
						<input type="hidden" id="gsPntRate" value="${gsPntRate}">
						<input type="hidden" id="useGsPoint" value="0">
						<input type="hidden" id="usableGsPoint" value="0">
						<section class="sect pont">
							<div class="hdts"><span class="tit">포인트</span></div>
							<div class="cdts" >
								<div class="cpset gs" id="useGsPointDiv" style="display: none">
									<div class="tit">GS&POINT <span id="usableGsPointTxt"></span></div>
									<div class="ptset">
										<span class="input amt"><input type="text" id="view_use_gs_point" value="" onkeyup="this.value=this.value.replace(/[^0-9]/g,'');" placeholder="10P 단위로 입력해주세요."></span>
										<a href="javascript:;" class="btn md d btnAll" onclick="useAllGsPoint('Y', '');">모두 사용</a>
									</div>
								</div>
								<div class="cpset gs disabled" id="getGsPointDiv"><!-- gs&point가 없을 때 .disabled 추가 -->
									<div class="tit">GS&POINT <span>000P</span></div>
									<div class="ptset">
										<span class="input amt"><input type="text" value="" disabled></span>
										<a href="javascript:;" class="btn md d btnAll" id="getGsPointBtn" onclick="selectCertType('gsPoint')">포인트 조회</a>
										<div class="ptt" ${memberYn eq 'N' ? ' ' : ' style="display:none;"'}>GS&POINT 사용을 위해서는 본인인증이 필요합니다.</div>
									</div>
								</div>
								<c:if test="${not empty mpPntVO }">
									<input type="hidden" id="mpSaveRate" value="${mpPntVO.saveRate}">
									<input type="hidden" id="mpAddSaveRate" value="${mpPntVO.addSaveRate}">
									<input type="hidden" id="mpUseRate" value="${mpPntVO.useRate}">
									<input type="hidden" id="mpMaxSavePnt" value="${mpPntVO.maxSavePnt}">
									<input type="hidden" id="mpPntPrmtGbCd" value="${mpPntVO.pntPrmtGbCd}">
									<input type="hidden" id="mpCardNo" value="${mpPntVO.cardNo}">
									<input type="hidden" id="pinNo" value="">
									<input type="hidden" id="usableMpPnt" value="0">
									<input type="hidden" id="useMpPoint" value="0">
									<input type="hidden" id="addUseMpPoint" value="0">
									
									<div class="cpset wooju ${not empty mpPntVO.cardNo ? '' : ' disabled' }">
										<div class="tit">우주코인 <span id="usableMpPntTxt"></span>
											<!-- alert -->
											<div class="alert_pop" data-pop="GSpoint">
												<div class="bubble_txtBox wooju"> 
													<div class="tit">우주코인 안내</div>
													<div class="info-txt">
														<ul>
															<li>우주코인은 최종 결제금액에 대해  <fmt:parseNumber value="${mpPntVO.saveRate}" integerOnly="true" />% 적립되며, 최대 <frame:num data="${mpPntVO.maxSavePnt}" />C까지 적립됩니다.</li>
															<li>적립 포인트 산정 시 쿠폰 할인 금액, 배송비, 취소/반품 상품 금액, 포인트 사용금액은 제외됩니다.</li>
															<li>포인트는 구매확정 시 적립되며,  1일 1회만 적립됩니다.</li>
															<li>여러개의 상품을 구매한 경우, 같이 구매한 상품이 모두 구매확정 되어야 포인트가 적립됩니다.</li>
															<li>우주코인 적립은 SK텔레콤 우주 서비스 정책에 따르며, 별도의 서비스 이용 수수료는 발생하지 않습니다.</li>
															<li>우주멤버십번호는 우주 앱 ‘우주멤버십’ 공간 내 나의 우주멤버십번호에서 확인 가능합니다.  (구)T멤버십 플라스틱 회원 카드 번호를 등록하여도 가능합니다.</li>
															<li>우주코인 비밀번호 미설정 또는 잊어버린 경우, 우주 앱 > 설정 > 우주코인 비밀번호 등록/변경 메뉴에서 등록/재설정 해주세요.</li>
														</ul>
													</div>
												</div>
											</div>
											<!-- // alert -->
											<span class="tog_wjm">우주멤버십</span>
										</div>
										<div class="ptset">
											<div class="ptt wjmemNo" ${not empty mpPntVO.cardNo ? '' : ' style="display:none"'}><!-- .on -->
												<b class="t"><em>우주멤버십</em> ${mpPntVO.viewCardNo}</b>
												<a href="javascript:;" class="lk mod btn" onclick="mpPnt.insertCard();">변경</a>
											</div>
											<span class="input amt"><input type="text" id="view_use_mp_point" value="" disabled onkeyup="this.value=this.value.replace(/[^0-9]/g,'');"></span>
											<c:choose>
												<c:when test="${not empty mpPntVO.cardNo }">
													<a href="javascript:;" id="mpPntBtn" data-type="20" class="btn md d btnAll" onclick="mpPnt.aplMpPnt(this);">포인트 조회</a>	
												</c:when>
												<c:otherwise>
													<a href="javascript:;" id="mpPntBtn" data-type="10" class="btn md d btnAll" onclick="mpPnt.aplMpPnt(this);">멤버십 등록</a>
												</c:otherwise>
											</c:choose>
											<c:if test="${mpPntVO.pntPrmtGbCd eq frontConstants.PNT_PRMT_GB_20 and mpPntVO.useRate gt 0 }">
												<div class="notiP" >
													<div>
														<p><span>부스트업으로 <em class="fc_blue" id="boostAddUsePnt"></em> 추가할인이 적용돼요!</span></p>
													</div>
												</div>
											</c:if>
										</div>
										
										<script>
										// 우주멤버십 토글
										$('.tog_wjm').click(function(){
											$('.ptt.wjmemNo, .cpset.wooju .ptset .input.amt, .cpset.wooju .ptset a.btnAll, .cpset.wooju .ptset .notiP').toggleClass('on');
											$(this).toggleClass('on');
										});
										</script>
									</div>
								</c:if>
							</div>
						</section>
						
						<section class="sect binf">
							<div class="hdts"><span class="tit">결제 수단</span></div>
							<div class="cdts">
								<ul class="bilist">
									<li id="easyCardPayLi">
										<div class="hht">
											<label class="radio" onclick="selectCardPayment();">
												<input type="radio" name="rd_bill_set" id="easyCardPay" value="easy">
												<div class="txt"><em class="tt">간편 카드결제</em></div>
											</label>
										</div>
										<c:if test="${paySaveInfo.prsnCardBillNo ne null and paySaveInfo.prsnCardBillNo ne ''}">
											<c:set var="orgPrsnBillNo" value="${paySaveInfo.prsnCardBillNo}"/>
										</c:if>
										<div class="ddt" id="easyPayCard">

										</div>
									</li>
									<li id="commonPayLi">
										<div class="hht">
											<label class="radio" onclick="selectCommonPayment();">
												<input type="radio" name="rd_bill_set" id="commonPay" value="common">
												<div class="txt"><em class="tt">일반 결제</em></div>
											</label>
										</div>
										<div class="ddt">
											<ul class="biltab">
												<li class="card <c:if test="${paySaveInfo.payMeansCd eq frontConstants.PAY_MEANS_10}">active</c:if>" id="cardLi"><button type="button" data-ui-tab-btn="tab_bils" data-ui-tab-val="tab_bils_1" class="btn" value="10" onclick="selectPayMethod('${frontConstants.PAY_MEANS_10}');"><span class="txt"><spring:message code='front.web.view.common.payment.creditcard'/></span></button></li>
												<li class="vert <c:if test="${paySaveInfo.payMeansCd eq frontConstants.PAY_MEANS_30}">active</c:if>" id="vertLi"><button type="button" data-ui-tab-btn="tab_bils" data-ui-tab-val="tab_bils_2" class="btn" value="30" onclick="selectPayMethod('${frontConstants.PAY_MEANS_30}');"><span class="txt"><spring:message code='front.web.view.common.payment.virtual.account'/></span></button></li>
												<li class="card <c:if test="${paySaveInfo.payMeansCd eq frontConstants.PAY_MEANS_20}">active</c:if>" id="realtimeLi"><button type="button" data-ui-tab-btn="tab_bils" data-ui-tab-val="tab_bils_3" class="btn" value="20" onclick="selectPayMethod('${frontConstants.PAY_MEANS_20}');"><span class="txt"><spring:message code='front.web.view.common.payment.realtime.bankTransfer'/></span></button></li>
												<li class="payc <c:if test="${paySaveInfo.payMeansCd eq frontConstants.PAY_MEANS_72}">active</c:if>" id="paycoLi"><button type="button" data-ui-tab-btn="tab_bils" data-ui-tab-val="tab_bils_4" class="btn" value="72" onclick="selectPayMethod('${frontConstants.PAY_MEANS_72}');"><span class="txt"><spring:message code='front.web.view.common.payment.payco'/></span></button></li>
												<li class="npay <c:if test="${paySaveInfo.payMeansCd eq frontConstants.PAY_MEANS_70}">active</c:if>" id="naverPayLi"><button type="button" data-ui-tab-btn="tab_bils" data-ui-tab-val="tab_bils_5" class="btn" value="70" onclick="selectPayMethod('${frontConstants.PAY_MEANS_70}');"><span class="txt"><spring:message code='front.web.view.common.payment.naverPay'/></span></button></li>
												<li class="kpay <c:if test="${paySaveInfo.payMeansCd eq frontConstants.PAY_MEANS_71}">active</c:if>" id="kakaoPayLi"><button type="button" data-ui-tab-btn="tab_bils" data-ui-tab-val="tab_bils_6" class="btn" value="71" onclick="selectPayMethod('${frontConstants.PAY_MEANS_71}');"><span class="txt"><spring:message code='front.web.view.common.payment.kakaoPay'/></span></button></li>
											</ul>
											<div data-ui-tab-ctn="tab_bils" data-ui-tab-val="tab_bils_1" <c:if test="${paySaveInfo.payMeansCd eq frontConstants.PAY_MEANS_10}">class="active"</c:if>>
												<div class="cardinfo"><!--@@ 02.17 추가 -->
													<div class="select cd">
														<select id="order_payment_cardc" name="order_payment_cardc" onchange="selCard(this.value);">
															<option value="" <c:if test="${paySaveInfo.cardcCd eq null or paySaveInfo.cardcCd eq ''}"> selected </c:if>>카드선택</option>
															<c:forEach items="${cardList}" var="card">
																<option value="${card.dtlCd}" <c:if test="${paySaveInfo.cardcCd eq card.dtlCd}"> selected </c:if>>${card.dtlNm}</option>
															</c:forEach>
														</select>
													</div>
													<div class="select nm">
														<select id="order_payment_halbu" name="order_payment_halbu" onchange="selHalbu(this.value);">
															<option value="00" selected>일시불</option>
														</select>
													</div>
												</div>
											</div>
											<div data-ui-tab-ctn="tab_bils" data-ui-tab-val="tab_bils_2"></div>
											<div data-ui-tab-ctn="tab_bils" data-ui-tab-val="tab_bils_3"></div>
											<div data-ui-tab-ctn="tab_bils" data-ui-tab-val="tab_bils_4"></div>
											<div data-ui-tab-ctn="tab_bils" data-ui-tab-val="tab_bils_5"></div>
											<div data-ui-tab-ctn="tab_bils" data-ui-tab-val="tab_bils_6"></div>
										</div>
									</li>
									<c:if test="${svrEnv eq frontConstants.ENVIRONMENT_GB_DEV}">
									<li>
										<div class="hht">
											<label class="radio" onclick="useBaseTerm();">
												<input type="radio" name="rd_bill_set" value="PPP">
												<div class="txt"><em class="tt">성능 테스트용 결제(결제프로세스 넘어감)</em></div>
											</label>
										</div>
									</li>
									</c:if>
								</ul>
								<div class="defbilchk" onclick="checkedDefaultPayMethod();">
									<label class="checkbox" onclick="checkedDefaultPayMethod();">
										<input type="checkbox" id="order_payment_default_pay_method" checked> <span class="txt">기본 결제수단으로 저장</span>
									</label>
								</div>
							</div>
							<c:if test="${view.deviceGb eq frontConstants.DEVICE_GB_20}">
							<div class="info-t2  mt24">
								팝업 차단한 경우 결제창 연결이 되지 않습니다. 핸드폰 설정에서 팝업차단 해제 후 이용해주세요.
							</div>
							</c:if>
						</section>

						<section class="sect bprc">
							<input type="hidden" id="order_payment_total_pay_amt_ex_gs_point" value="0" />
							<input type="hidden" id="order_payment_total_pay_amt_ex_mp_point" value="0" />
							<div class="hdts"><span class="tit">결제 금액</span></div>
							<div class="cdts">
								<ul class="prcset">
									<li>
										<div class="dt">총 상품금액</div>
										<div class="dd">
											<span class="prc"><em class="p"><frame:num data="${totalGoodsAmt}" /></em><i class="w">원</i></span>
											<input type="hidden" id="order_payment_total_goods_amt" value="<c:out value="${totalGoodsAmt}" />" />
										</div>
									</li>
									<li id="couponDcLi">
										<div class="dt">쿠폰 할인</div>
										<div class="dd">
											<span class="prc dis"><em class="p" id="order_payment_total_dc_amt_view">-<frame:num data="${selTotCpDcAmt}" /></em><i class="w">원</i></span>
											<input type="hidden" id="order_payment_total_dc_amt" value="0" />
										</div>
									</li>
									<li id="gsDcLi">
										<div class="dt">GS&POINT 사용</div>
										<div class="dd">
											<span class="prc dis"><em class="p" id="order_payment_gs_point_view"></em><i class="w">P</i></span>
										</div>
									</li>
									<li id="mpDcLi" ${not empty mpPntVO  ? ' ' : ' style="display:none;"'}>
										<div class="dt">우주코인 사용</div>
										<div class="dd">
											<span class="prc dis"><em class="p" id="order_payment_mp_point_view"></em><i class="w">C</i></span>
										</div>
									</li>
									<li id="mpAddDcLi" ${not empty mpPntVO  ? ' ' : ' style="display:none;"'}>
										<div class="dt">우주코인 추가할인</div>
										<div class="dd">
											<span class="prc dis"><em class="p" id="order_payment_mp_add_point_view"></em><i class="w">원</i></span>
										</div>
									</li>
									<li>
										<div class="dt">배송비</div>
										<div class="dd">
											<span class="prc"><em class="p" id="order_payment_total_dlvr_amt_view">+0</em><i class="w">원</i></span>
											<input type="hidden" id="gb_01_total_dlvr_amt" value="0" />
											<input type="hidden" id="gb_02_total_dlvr_amt" value="0" />
											<input type="hidden" id="order_payment_total_dlvr_amt" value="0" />
										</div>
									</li>
								</ul>
								<div class="tot">
									<div class="dt">총 결제금액</div>
									<div class="dd">
										<span class="prc"><em class="p" id="order_payment_total_pay_amt_view"><frame:num data="${totalGoodsAmt + totalDlvrAmt - selTotCpDcAmt}" /></em><i class="w">원</i></span>
										<input type="hidden" id="order_payment_total_pay_amt" value="<c:out value="${totalGoodsAmt + totalDlvrAmt - selTotCpDcAmt}" />" />
									</div>
								</div>
								<!-- 01 주문서-리테일멤버십 가입 안한 경우 -->
								<div class="gdpnt onlywooju" ${memberYn eq 'N' ? ' ' : ' style="display:none;"'}>
									<ul class="">
										<li><div class="tit">GS&POINT</div> <div>GS리테일멤버십 회원가입시 <em class="p saveGsPnt" ></em></div></li>
									</ul>
								</div>
								
								<!-- 02 주문서-우주멤버십 등록 안한 경우 -->
								<div class="gdpnt onlygs" ${memberYn eq 'Y' and empty mpPntVO.cardNo ? ' ' : ' style="display:none;"'}>
									<ul class="">
										<li><div class="tit">GS&POINT</div> <div><em class="p saveGsPnt"></em> <span>적립예정</span></div></li>
									</ul>
								</div>
								
								<!-- 03 주문서-멤버십 둘다 등록 한 경우 -->
								<div class="gdpnt member" ${memberYn eq 'Y' and not empty mpPntVO.cardNo ? ' ' : ' style="display:none;"'}>
									<ul class="">
										<li><div class="tit">GS&POINT</div> <div><em class="p saveGsPnt"></em> <span>적립예정</span></div></li>
										<c:if test="${not empty mpPntVO }">
											<li class="wj_addp saveMpPntLi">
												<div class="tit">우주코인</div>
												<div class="saveMpDiv">
													<em class="blt max">최대</em>
													<em class="p saveMpPnt"></em>
													<span>적립예정</span>
												</div>
												<div class="wj_point_box addSaveMpDiv" style="display:none;">
													<div>
														<em class="blt max">최대</em>
														<em class="p saveMpPnt"></em>
													</div> 
													<div>
														<em class="fc_blue">+ 추가 </em>
														<em class="p addSaveMpPnt"></em>
														<span>적립예정</span>
													</div>
												</div>
											</li>
										</c:if>
									</ul>
								</div>
								<div class="info-t3">구매확정 후 포인트가 적립됩니다.</div>
							</div>
						</section>
						<section class="sect agre">
							<div class="hdts"></div>
							<div class="cdts">
								<!-- <ul class="agreeset">
									<li class="all">
										<span class="checkbox">
											<input type="checkbox" id="chkAllTerms" name="chkAllTerms" onclick="selectAll(this)">
											<span class="txt"><em class="tt st">주문상품 및 결제대행 이용약관에 모두 동의합니다.</em></span>
										</span>
									</li>
									<li>
										<span class="checkbox">
											<input type="checkbox" id="chk1" name="ordTerms" onclick="checkSelectAll()">
											<span class="txt"><em class="tt">주문할 상품의 상품명, 상품가격, 배송정보를 확인하였으며, 구매에 동의하시겠습니까?(전자상거래법 제8조 제2항)</em></span>
										</span>
									</li>
									<li>
										<span class="checkbox">
											<input type="checkbox" id="chk2" data-terms-no="48" id="terms_48" data-index="4" name="ordTerms" onclick="checkSelectAll()">
											<span class="txt"><a href="javascript:;" name="termPopBtn" data-index="4" class="tt lk">개인정보 수집 및 이용 동의</a></span>
										</span>
									</li>
								</ul> -->
								<ul class="agreeset">
									<li class="all">
										<span class="checkbox">
											<input type="checkbox" id="chkAllTerms" name="chkAllTerms" onclick="selectAll(this)">
											<span class="txt"><em class="tt st">주문상품 및 결제대행 이용약관에 모두 동의합니다.</em></span>
										</span>
									</li>
									<li>
										<span class="checkbox">
											<input type="checkbox" id="chk1" name="ordTerms" onclick="checkSelectAll()">
											<span class="txt"><em class="tt">주문할 상품의 상품명, 상품가격, 배송정보를 확인하였으며, 구매에 동의하시겠습니까?(전자상거래법 제8조 제2항)</em></span>
										</span>
									</li>

									<!-- 기본약관 -->
									<c:forEach items="${terms}" var="item" varStatus ="stat">
									<%-- <c:if test="${item.termsCd == '1008' || item.termsCd == '1009' || item.termsCd == '1011'}" > --%>
										<c:if test="${item.termsCd == '1011'}" >
											<li id="thirdPartyTerm" style="display:none;">
												<span class="checkbox">
													<input type="checkbox"  id="terms_${item.termsNo }" name="ordTerms" data-idx = "${stat.index }" data-terms-no="${item.termsNo}" onclick="checkSelectAll()">
													<span class="txt"><a href="javascript:;" name="termPopBtn" data-index="${stat.index }" class="tt lk">${item.termsNm} </a></span>
												</span>
												<a href="javascript:;" name ="contentPopBtn" title="내용보기" data-content="" data-url="" data-index="${stat.index }"></a>
											</li>
										</c:if>
									</c:forEach>

									<!-- 나이스페이먼츠 -->
									<c:forEach items="${terms}" var="item" varStatus ="stat">
										<c:if test="${item.termsCd == '1005' || item.termsCd == '1006' || item.termsCd == '1007'}" >
											<li class="nicePaymentTerms" style="display:none;">
												<span class="checkbox">
													<input type="checkbox" class="chkNiceTerms" name="ordTerms" id="terms_${item.termsNo }" data-idx = "${stat.index }" data-terms-no="${item.termsNo}" onclick="checkSelectAll()">
													<span class="txt"><a href="javascript:;" name="termPopBtn" data-index="${stat.index }" class="tt lk">${item.termsNm}</a></span>
												</span>
												<a href="javascript:;" name ="contentPopBtn" title="내용보기" data-content="" data-url="" data-index="${stat.index }"></a>
											</li>
										</c:if>
									</c:forEach>

								</ul>
								<div class="bts">
									<a href="javascript:;" name="contentPopBtn" class="btn a lg btnBill" onclick="validNonMember();">
										<span class="prc"><em class="p" id="order_payment_end_pay_amt_view"><frame:num data="${totalGoodsAmt + totalDlvrAmt - selTotCpDcAmt}" /></em><i class="w">원</i></span> <span class="txt">결제하기</span>
									</a>
								</div>
							</div>
						</section>
					</div>
					<div class="banners">
						<div class="uibanners">
							<div class="banner_slide">
								<div class="swiper-container slide">
									<ul class="swiper-wrapper list"></ul>
									<div class="swiper-pagination"></div>
									<div class="sld-nav"><button type="button" class="bt prev">이전</button><button type="button" class="bt next">다음</button></div><!-- @@ 03.18 추가 -->
								</div>
							</div>
						</div>
					</div>
				</div>

			</div>
		</main>
	</tiles:putAttribute>
	<tiles:putAttribute name="layerPop">
		<!-- popup 내용 부분입니다. -->
		<article class="popLayer a popDeliReq noClickClose" id="popDeliReq1">
		</article>

		<article class="popLayer a popCardinput noClickClose" id="popCardinput">
		</article>

		<article class="popLayer a popBilPwdMod noClickClose" id="popBilPwdConfirm">
		</article>

		<article class="popLayer a popDeliPop" id = "popupAddressList1">
		</article>

		<article class="popLayer a popDeliMod" id = "addressAddPop">
		</article>

		<article class="popLayer a popCoupon" id="popCoupon">
		</article>
		
		<article class="popLayer a popWoozooJoin" id="popSktmp">
		</article>
		
		<article class="popLayer a popWoozooPass" id="popSktmpPwd">
		</article>
		<!-- 약관팝업 -->
		
		<!-- 주소 검색 팝업 -->
		<div class="layers" id="orderAddLayers">
		</div>

		<div class="layers" style="display:none;">
			<c:forEach items = "${terms }" var = "term" varStatus = "stat">
				<!-- 이용 약관 -->
				<main class="container page login agree" id="container${stat.index }">
					<div class="inr">
						<div class="contents" id="contents">
							<!-- 팝업레이어 A 전체 덮는크기 -->
							<article class="popLayer a popSample1" id="termsContentPop${stat.index }">
								<div class="pbd">
									<div class="phd">
										<div class="in">
											<h1 class="tit">${term.termsNm }</h1>
											<button type="button" id = "closeBtn" class="btnPopClose">닫기</button>
										</div>
									</div>
									<div class="pct">
										<main class="poptents">
											<!-- // PC 타이틀 모바일에서 제거  -->
											<div class="agree-box">
												<div class="select">
													<select name ="termContentSelect">
														<c:forEach items="${term.listTermsContent}" var ="content" varStatus ="stat">
															<c:if test ="${stat.index eq 0 }">
																<option value ="${stat.index }">현행 시행일자 : <frame:date date ="${content.termsStrtDt }" type ="K"/></option>
															</c:if>
															<c:if test ="${stat.index ne 0 }">
																<option value ="${stat.index }"><frame:date date ="${content.termsStrtDt }" type ="K"/> ~ <frame:date date ="${content.termsEndDt }" type ="K"/></option>
															</c:if>
														</c:forEach>
													</select>
												</div>
												<c:if test="${term.rqidYn eq frontConstants.COMM_YN_N }">
													<%-- <div class="agree-btn" style ="margin-top:20px;">
														<p class="txt">${term.termsNm }에 동의할까요?</p>
														<button name ="agreeTerm" class="btn a" data-terms-no="${term.termsNo }">동의</button>
													</div> --%>
												</c:if>
												<c:forEach items="${term.listTermsContent}" var ="content" varStatus ="stat">
													<c:if test="${stat.index eq 0}">
														<section class="exlist">
															<dl>
																	${content.content }
															</dl>
														</section>
													</c:if>
													<c:if test="${stat.index ne 0 }">
														<section class="exlist" style = "display:none;">
															<dl>
																	${content.content}
															</dl>
														</section>
													</c:if>
												</c:forEach>
											</div>
										</main>
									</div>
								</div>
							</article>
						</div>
					</div>
				</main>
			</c:forEach>
		</div>
		<div class="layers" >
			<article class="popBot popCpnGud k0427 on" id="GSpoint" tabindex="0" style="display:none;"><!-- 04.27 -->
				<div class="pbd">
					<div class="phd">
						<div class="in">
							<h1 class="tit">우주코인 안내</h1>
							<button type="button" class="btnPopClose">닫기</button>
						</div>
					</div>
					<div class="pct" style="max-height: 510px;">
						<main class="poptents">
							<ul class="tplist">
							<input type="hidden" id="mpSaveRate" value="${mpPntVO.saveRate}">
								<li>우주코인은 최종 결제금액에 대해  <fmt:parseNumber value="${mpPntVO.saveRate}" integerOnly="true" />% 적립되며, 최대 <frame:num data="${mpPntVO.maxSavePnt}" />C까지 적립됩니다.</li>
								<li>적립 포인트 산정 시 쿠폰 할인 금액, 배송비, 취소/반품 상품 금액, 포인트 사용금액은 제외됩니다.</li>
								<li>포인트는 구매확정 시 적립되며,  1일 1회만 적립됩니다.</li>
								<li>여러개의 상품을 구매한 경우, 같이 구매한 상품이 모두 구매확정 되어야 포인트가 적립됩니다.</li>
								<li>우주코인 적립은 SK텔레콤 우주 서비스 정책에 따르며, 별도의 서비스 이용 수수료는 발생하지 않습니다.</li>
								<li>우주멤버십번호는 우주 앱 ‘우주멤버십’ 공간 내 나의 우주멤버십번호에서 확인 가능합니다.  (구)T멤버십 플라스틱 회원 카드 번호를 등록하여도 가능합니다.</li>
								<li>우주코인 비밀번호 미설정 또는 잊어버린 경우, 우주 앱 > 설정 > 우주코인 비밀번호 등록/변경 메뉴에서 등록/재설정 해주세요.</li>
							</ul>
						</main>
					</div>
				</div>
			</article>
		</div>
	</tiles:putAttribute>
	<tiles:putAttribute name="script.include" value="script.gsr"/>
	<tiles:putAttribute name="script.inline">
		<script src="https://web.nicepay.co.kr/v3/webstd/js/nicepay-3.0.js" type="text/javascript"></script>
		<script type="text/javascript">
			var simpChk = false;
			$(document).ready(function(){			
				// history를 이용한 접근 방지 (파람은 GTM의 페이지 구분값)
				storageHist.replaceHist();  
				history.replaceState("","",'/common/wrongAprch?sc=step3'); // 브라우저 back
						
				$("#header_pc").find('.tit').text('주문결제');
				$("#header_pc").addClass("logHeaderAc");
				$(".mo-header-backNtn").attr("onclick", "fncGoBack();");
				
				//$(document).off("click", "[data-ui-tab-btn]");

				// 기본결제수단 정보 세팅
				let loadPayMeansCd = $("#payMeansCd").val();

				if(loadPayMeansCd == '${frontConstants.PAY_MEANS_11}' || loadPayMeansCd == undefined || loadPayMeansCd == null || loadPayMeansCd == ''){

					$("#easyCardPay").prop("checked", true);
					$("#easyCardPayLi").addClass("open");

					loadEasyPay("N");
					
					//기본 결제 수단 클릭
					$("#easyCardPay").trigger("click");

				}else{

					$("#commonPay").prop("checked", true);
					$("#commonPayLi").addClass("open");
					//기본 결제 수단 클릭
					$("#commonPay").trigger("click");
					selectPayMethod(loadPayMeansCd);

				}

				// 휴대폰 번호 유효성
				$("#order_payment_adrs_mobile").on("change input paste blur" , function(){
					var value = $(this).val();
					var pattern = /[^0-9]/gi;

					if(pattern.test(value)){
						$(this).val(value.replace(pattern,""));
					}
				});

				$(document).on("change focusout","#view_use_gs_point",function(e){
					var pnt = $(this).val().replace(/[\D]/g,'');
					useAllGsPoint('N', pnt);
				})
				.on("click",".gs .btnDel",function(){
					useAllGsPoint('N', '');
				});

				let initPayMeansCd = $("#payMeansCd").val();

				if(initPayMeansCd === "<c:out value='${frontConstants.PAY_MEANS_10}' />"){

					let initCardc = $("#cardcCd").val();
					selCard(initCardc);
				}

				// 개인정보 수집및 이용동의팝업
				$(document).on("click" , "[name=termPopBtn]", function(){
					$(".layers").show();
					popServiceList($(this).data("index"));
				});
				//닫기
				$(document).on("click" , "#closeBtn" , function(){
					$(".layers").hide();
				});
			
				// 주문서 띠배너 가져오기
				$.fncGetBnrList(503);

				//위탁상품일경우  제3자 동의 뛰우기
				if($("#dlvrPrcsTp10").length > 0){
					$("#thirdPartyTerm").css("display","block");
				} else {
					// thirdPartyTerm 체크 제외
					$("#thirdPartyTerm").find('input[name="ordTerms"]').attr('name', 'thirdPartyOrdTerms')
				}

				//상품공급사명 치환
				if($("#partnerCompanyNameInPolicy").length > 0){
					var pcNm = "<c:out value='${partnerCompanyNm}' />";
					$("#partnerCompanyNameInPolicy").html(pcNm);
				}

			}); // End Ready
			
			//[<] 뒤로가기 처리
			function fncGoBack(){
				if("${callParam}" != ""){
					//App & 펫TV 영상상세 화면에서 호출일때만 callParam값이 있다.
					var callParam = "${callParam}";
					var params = callParam.split(".");
					var newDomain = window.location.protocol+"//"+window.location.host;
					var url = "";
					if(params.length == 3){
						url = newDomain+"/tv/series/indexTvDetail?vdId="+params[0]+"&sortCd=&listGb="+params[1]+"-"+params[2];
					}else{
						url = newDomain+"/tv/series/indexTvDetail?vdId="+params[0]+"&sortCd="+params[1]+"&listGb="+params[2]+"-"+params[3];
					}
					
					// 데이터 세팅
					toNativeData.func = "onNewPage";
					toNativeData.type = "TV";
					toNativeData.url = url;
					// 호출
					toNative(toNativeData);
				}
				storageHist.setHist();
				storageHist.goBack();
			}
			
			//이용약관 상세페이지 진입시 AOS 단말 BackKey처리를 위한 함수입니다.
			function layerHide(){
				$(".layers").hide();
				console.log("단말 backKey누를시 이용약관 상세 닫힘.");
			}

			$(function() {

				let sBtn = $("#cardSelDiv div.sld-nav");

				sBtn.find("button").click(function(){
					let selBillNo = $(".cardsel_slide").find('[id^=cardBill_].payM_choiceCard').data("num");
					selectBillingCard(selBillNo);
				})

			});

			// 주문서 띠배너 가져오기
			$.fncGetBnrList = function(dispCornNo){
				const now = Date.now();
				const url = "/shop/getDisplayCommonCornerItemFO"
				let options = {
					url : url
					,done : function(data){
						if(null != data && "undefined" != data && null != data.cornerList && "undefined" != data.cornerList){
							$.each(data.cornerList, function(i, v){
								if("503" == v.dispCornNo){
									if("Y" == v.dispPrdSetYn){
										if(now >= v.dispStrtdt && now <= v.dispEnddt){
											$.fncSetBnrHtml(v.listBanner);
										}
									} else {
										if(now >= v.dispStrtdt){
											$.fncSetBnrHtml(v.listBanner);
										}
									}
								}
							});
						}
					}
				};
				ajax.call(options);
			}

			// 주문서 띠배너 HTML 생성
			$.fncSetBnrHtml = function(listBanner){
				let tmpHtml = '';
				let bnrCnt = 0;
				if(null != listBanner && "undefined" != listBanner){
					$.each(listBanner, function(i, v){
						if("Y" == v.useYn){
							let bnrMobileImgPath = "${frame:optImagePath('"+ v.bnrMobileImgPath +"', frontConstants.IMG_OPT_QRY_330)}";
							let bnrImgPath = "${frame:optImagePath('"+ v.bnrImgPath +"', frontConstants.IMG_OPT_QRY_310)}";
							tmpHtml += '<li class="swiper-slide">';
							tmpHtml += '	<a href="' + v.bnrLinkUrl + '" class="box">';
							tmpHtml += '		<img class="mo" src="' + bnrMobileImgPath +'" alt="' + v.bnrDscrt + '">';
							tmpHtml += '		<img class="pc" src="' + bnrImgPath + '" alt="' + v.bnrDscrt + '">';
							tmpHtml += '	</a>';
							tmpHtml += '</li>';

							bnrCnt++;
						}
					});

					$(".banners .uibanners ul.swiper-wrapper.list").append(tmpHtml);
					ui.banner.init();

					if(bnrCnt > 1 && "${view.deviceGb eq frontConstants.DEVICE_GB_10}" == "true"){
						$(".uibanners  .swiper-container .sld-nav").show();
					}
				}
			}

			//이용약관 레이어
			var popServiceList = function(index){

				// 레이어팝업 열기 콜백
				var checkbox = $('input:checkbox[data-idx='+index+']')
				var agreeBtn = $("button[data-terms-no="+checkbox.data('termsNo')+"]");
				if(checkbox.prop("checked")){
					agreeBtn.text("동의철회");
					agreeBtn.removeClass("a");
				}else{
					agreeBtn.text("동의");
					agreeBtn.addClass("a");
				}
				if("${view.deviceGb}" != "${frontConstants.DEVICE_GB_10}"){
					//$("html, body").css({"overflow":"hidden", "height":"100%"});
				}
				ui.popLayer.open('termsContentPop'+index);
			}

			function orderActionLog(){
				$.ajax({
					url : "/common/sendSearchEngineEvent"
					, data : {
						"section" : "shop"
						, "content_id" : $("#order_payment_ord_no").val()
						, "action" : "order"
						, "url" : document.location.href
						, "targetUrl" : "${view.stDomain}"+"/order/indexOrderCompletion"
					}
				});
			}
			function orderAdbrix(){
				var goodsIds = new Array();
				$("input[name=order_payment_cart_ids]").each(function(index, item){

					goodsIds.push($(item).data("goodsId"));
				});

				$.ajax({
					type: "POST",
					url: "/order/listAdbrixGoods",
					data: {
						goodsIds: goodsIds
						, ordNo : $("#order_payment_ord_no").val()
					},
					async: false,
					dataType:"json",
					success:function(data){
						//최초결제 adbrix
						if(data.oldOrdDtlCnt == 0){
							onFirstPurchaseData = {
				    			'func' : 'onFirstPurchase',
					    	};
							//앱에서만 호출
							if (navigator.userAgent.toLowerCase().indexOf('apet') != -1 ) {
								toNativeAdbrix(onFirstPurchaseData);
							}

						}

						let goodsTotalAmt = parseInt($("#order_payment_total_goods_amt").val());	//상품금액
						let dlvrTotalAmt = parseInt($("#order_payment_total_dlvr_amt").val());		//배송비
						// 상품/배송비 쿠폰
						let totGoodsdlvrCpDcAmt = parseInt($("#tot_goods_cp_dc_amt").val()) + parseInt($("#tot_dlvr_cp_dc_amt").val());

						// 장바구니 쿠폰
						let totCartCpDcAmt = parseInt($("#tot_cart_cp_dc_amt").val());

						var onPurchaseData = {
							'func' : 'onPurchase',
				    		'orderId' : $("#order_payment_ord_no").val(),
				    		'orderSales' : goodsTotalAmt,
				    		'discount' : totGoodsdlvrCpDcAmt + totCartCpDcAmt,
				    		'deliveryCharge' : dlvrTotalAmt,
				    		'paymentMethod' : 1,
						};

						let payMeansCd = $("#payMeansCd").val();
						if (payMeansCd === "<c:out value='${frontConstants.PAY_MEANS_10}' />") {	// 신용카드
							onPurchaseData.paymentMethod = 1;

						}else if (payMeansCd === "<c:out value='${frontConstants.PAY_MEANS_11}' />") {	// 카드빌링
							onPurchaseData.paymentMethod = 1;
						}else if (payMeansCd === "<c:out value='${frontConstants.PAY_MEANS_20}' />") {	// 실시간계좌이체
							onPurchaseData.paymentMethod = 2;
						}else if (payMeansCd === "<c:out value='${frontConstants.PAY_MEANS_30}' />") {	// 가상계좌
							onPurchaseData.paymentMethod = 4;
						}else if (payMeansCd === "<c:out value='${frontConstants.PAY_MEANS_70}' />") {	// 네이버페이
							onPurchaseData.paymentMethod = 4;
						}else if (payMeansCd === "<c:out value='${frontConstants.PAY_MEANS_71}' />") {	// 카카오페이
							onPurchaseData.paymentMethod = 4;
						}else if (payMeansCd === "<c:out value='${frontConstants.PAY_MEANS_72}' />") {	// 페이코
							$onPurchaseData.paymentMethod = 4;
						}else if (payMeansCd === "<c:out value='${frontConstants.PAY_MEANS_00}' />") {	//0원 결제
							onPurchaseData.paymentMethod = 4;
						}

						//Adbrix
						var productModels = new Array();
						//구글 애널리틱스 - GA
						var items = new Array();

						$("input[name=order_payment_cart_ids]").each(function(index, item){
							var cartId = $(this).val();
							var saleAmt = parseInt($(this).data("salePrc")) * parseInt($(this).data("buyQty"));
							var totCpDcAmt = 0;

							$("#goodsCouponList").find("input[name=couponInfo]").each(function(){
								if($(this).data("cartId") == cartId){
									totCpDcAmt = parseInt($(this).data("totCpDcAmt"));
									return false;
								}
							})

							var adbixData = data.adbrixList.filter(function(adbrix){
								return adbrix.goodsId = $(item).data("goodsId");
							})

							var temp = adbixData.length > 0 ? adbixData[0] : null;
							if(temp){
								var cate = new Array();
								if(temp.dispClsfNm1){
									cate.push(temp.dispClsfNm1);
								}
								if(temp.dispClsfNm2){
									cate.push(temp.dispClsfNm2);
								}
								if(temp.dispClsfNm3){
									cate.push(temp.dispClsfNm3);
								}

								var goods = {
									'productId' : temp.goodsId,
					    			'productName' : temp.goodsNm,
					    			'price' : temp.salePrc,
					    			'quantity' : $(item).data("buyQty"),
					    			'discount' : totCpDcAmt,
					    			'currency' : 1,		// 고정 1 , KRW
					    			'categorys' : cate
								}
								productModels.push(goods);

								//구글 애널리틱스 - GA
								var item = {
										'item_id' : temp.goodsId,
						    			'item_name' : temp.goodsNm,
						    			'affiliation' : temp.compNm,
						    			'price' : temp.salePrc,
						    			'quantity' : $(item).data("buyQty"),
						    			'discount' : totCpDcAmt,
						    			'item_category' : temp.dispClsfNm3,
						    			'item_brand' : temp.bndNm,
						    			'currency' : "KRW"

								}
								items.push(item);
							}
						});
						onPurchaseData.productModels = productModels;
						//앱에서만 호출
						if (navigator.userAgent.toLowerCase().indexOf('apet') != -1 ) {
							toNativeAdbrix(onPurchaseData);
						}
						var purchase_data = {};
						//purchase_data.affiliation = $("#purchase input[name=affiliation]").val();
						purchase_data.coupon = $("#cartCouponList input").length > 0 ? $("#cartCouponList input").data().selMbrCpNo : ''; //장바구니 쿠폰번호
						purchase_data.currency = "KRW";
						purchase_data.shipping = dlvrTotalAmt;
						//purchase_data.transaction_id = $("#purchase input[name=transaction_id]").val();
						//purchase_data.value = $("#purchase input[name=value]").val();
						purchase_data.items = items;
						// 호출
						//앱 심사로 주석
						sendGtag('purchase');
					}
				});
			}


			// GS포인트 모두사용
			function useAllGsPoint(allYn, usePoint){
				var allUseGsPoint = parseInt($("#usableGsPoint").val());
				if(allYn == 'N'){
					if(usePoint){
						usePoint = parseInt(usePoint.replace(/,/g,""));
						if(usePoint < allUseGsPoint){
							allUseGsPoint = parseInt(usePoint);
						}
					}else{
						allUseGsPoint = 0;
					}
				}

				allUseGsPoint = Math.floor(allUseGsPoint/10) * 10;

				//결제가능 포인트 금액
				let stdAmt = parseInt($("#order_payment_total_pay_amt_ex_gs_point").val());

				if(allUseGsPoint <= 0){
					$("#view_use_gs_point").val("");
					$("#useGsPoint").val(0);
				}else if(allUseGsPoint >= stdAmt){
					stdAmt = Math.floor(stdAmt/10) * 10;
					$("#view_use_gs_point").val(format.num(stdAmt));
					$("#useGsPoint").val(stdAmt);

				}else if(allUseGsPoint < stdAmt){
					$("#view_use_gs_point").val(format.num(allUseGsPoint));
					$("#useGsPoint").val(allUseGsPoint);

				}
				orderPay.calPayAmt();
			}

			//본인 인증
			function confrimCertAndTerms(certType){
				var config = {
					ciCtfVal : ciCtfVal
					,	callBack : function(){
						var option = {
							url :  "/gsr/getGsrMemberPoint"
							, done : function(result){

								$("#gsptNo").val(result.custNo);

								if(certType === "gsPoint"){
									var separateNotiMsg = result.separateNotiMsg;

									if(separateNotiMsg && separateNotiMsg != ''){
										//분리보관 해제 noti
										ui.alert("<div id='alertContentDiv'>"+separateNotiMsg+"</div>",{
											ycb:function(){
												$("#useGsPoint").val(0);
												$("#view_use_gs_point").val("");

												var gsrPoint = result.totRestPt === '' || result.totRestPt == null ? '0' : result.totRestPt;

												if(parseInt(gsrPoint) <= 0){
													gsrPoint = 0;
													$("#view_use_gs_point").prop("disabled", true);
												}else{
													$("#view_use_gs_point").prop("disabled", false);
												}

												$("#usableGsPoint").val(gsrPoint);
												$("#usableGsPointTxt").text(format.num(gsrPoint) + "P");

												$("#getGsPointDiv").hide();
												$("#useGsPointDiv").show();

												$(".popAlert").remove();
											}
											,   ybt:"확인"
										});
									}else{
										$("#useGsPoint").val(0);
										$("#view_use_gs_point").val("");

										var gsrPoint = result.totRestPt === '' || result.totRestPt == null ? '0' : result.totRestPt;

										if(parseInt(gsrPoint) <= 0){
											gsrPoint = 0;
											$("#view_use_gs_point").prop("disabled", true);
										}else{
											$("#view_use_gs_point").prop("disabled", false);
										}

										$("#usableGsPoint").val(gsrPoint);
										$("#usableGsPointTxt").text(format.num(gsrPoint) + "P");


										$("#getGsPointDiv").hide()
										$("#useGsPointDiv").show();
									}
								}else if(certType === "registCardBill"){
									registBillingCard('Y');
								}else if(certType === "registSktmp"){
									mpPnt.insertCard();
								}
								//본인인증 X
							}
						};
						ajax.call(option);
					}
					,	okCertCallBack : function(data){
						//본인인증 
						var option = {
							url :  "/gsr/getGsrMemberPoint"
							,	data : data
							,	done : function(result){
									//KCB 인증값 = gsr.jsp line 81
									var mbrNm = data.mbrNm;
									var mobile = data.mobile;
									var birth = data.birth;
									var ciCtfVal = data.ciCtfVal;
									var mobileCd = data.mobileCd;
									var ntnGbCd = data.ntnGbCd;
									var gdGbCd = data.gdGbCd;

									if(mbrNm != null && mbrNm != ""){
										$("#ordNm").val(mbrNm);
									}
									$("#ordrMobile").val(mobile);
									$("#ciCtfVal").val(ciCtfVal);
									$("#birth").val(birth);
									$("#memDiv-mbrNm").text(mbrNm+",");
									$("#memDiv-mobile").text(format.mobile(mobile));
									$("#buyerName").val(mbrNm);
									$("#buyerTel").val(mobile);
									$("#ordrTel").val(mobile);

									if(certType === "gsPoint"){
										if(mbrNm != null && mbrNm != ""){
											$("#useGsPoint").val(0);
											$("#view_use_gs_point").val("");

											var gsrPoint = result.totRestPt === '' || result.totRestPt == null ? '0' : result.totRestPt;
											gsrPoint = fnComma(gsrPoint);

											$("#usableGsPointTxt").text(format.num(gsrPoint) + "P");
											$("#usableGsPoint").val(gsrPoint);

											$("#noMemDiv").hide();
											$("#memDiv").show();
											$("#memberYn").val("Y");
										} else {
											$("#memberYn").val("N");
											ui.alert('GS 포인트 연동이 실패하여 본인인증을 다시 시도 하여 주십시오.');
										}
									}else if(certType === "registCardBill"){
										registBillingCard('Y');
									}else if(certType === "nonMember"){
										$("#noMemDiv").hide();
										$("#memDiv").show();
										$("#memberYn").val("Y");
									}else if(certType === "registSktmp"){
										if(mbrNm != null && mbrNm != ""){
											$("#useGsPoint").val(0);
											$("#view_use_gs_point").val("");

											var gsrPoint = result.totRestPt === '' || result.totRestPt == null ? '0' : result.totRestPt;
											gsrPoint = fnComma(gsrPoint);

											$("#usableGsPointTxt").text(format.num(gsrPoint) + "P");
											$("#usableGsPoint").val(gsrPoint);
											
											$("#noMemDiv").hide();
											$("#memDiv").show();
											$("#memberYn").val("Y");
											
											// 본인인증 후 우주멤버십 등록 팝업 열기
											mpPnt.insertCard();
										} else {
											$("#memberYn").val("N");
											ui.alert('GS 포인트 연동이 실패하여 본인인증을 다시 시도 하여 주십시오.');
										}
									}
									
									orderView.changePntView();
							}
						};
						ajax.call(option);
					}
				};
				gk.open(config);
			}
			

			/* GS포인트 조회 */
			function getGsMemberShipPoint(){

				$("#getGsPointDiv").hide();
				$("#useGsPointDiv").show();

				let url = "<spring:url value='/gsr/getGsrMemberPoint' />";
				let custNo = $("#gsptNo").val();
				let sendData = {
					custNo : custNo
				};

				$("#useGsPoint").val(0);
				$("#view_use_gs_point").val("");

				let options = {

					url : url
					, data : sendData
					, type : "POST"
					, done : function(result){

						var gsrPoint = result.totRestPt === '' || result.totRestPt == null ? '0' : result.totRestPt;
						gsrPoint = fnComma(gsrPoint);

						$("#usableGsPointTxt").text(format.num(gsrPoint) + "P");
						$("#usableGsPoint").val(gsrPoint);

					}

				}
				ajax.call(options);
			}

			function registBillingCard(firstYn){

				let url = "<spring:url value='/pay/nicepay/registBillingCard' />";
				let sendBillData = {
					mbrNm : $("#ordNm").val()
					, email : $("#ordrEmail").val()
					, mobile : $("#ordrMobile").val()
					, birth : $("#birth").val()
					, firstYn : firstYn
				};

				let options = {
					url : url
					, data : sendBillData
					, dataType : "html"
					, done : function(html){
						$("#popCardinput").html(html);
						ui.popLayer.open("popCardinput");
					}
				}
				ajax.call(options);

			}

			function nicepayStart(){
				<c:if test="${svrEnv eq frontConstants.ENVIRONMENT_GB_DEV}">
				/**
				 * 성능테스트 후 삭제
				 */
				if($("input[name='rd_bill_set']:checked").val()=="PPP") {
					orderComplete();
					return;
				}
				</c:if>

				if("${view.deviceGb}"=="${frontConstants.DEVICE_GB_20}" || "${view.deviceGb}"=="${frontConstants.DEVICE_GB_30}"){//모바일 결제창 진입

					if("${view.os}"=="${frontConstants.DEVICE_TYPE_20}" && "${view.deviceGb}"=="${frontConstants.DEVICE_GB_30}") {
						// 20210907 장바구니 쿠키 유지를 위헤 추가
						toNativeData.func = 'onLogin';
						toNative(toNativeData);
						// 20210907 장바구니 쿠키 유지를 위헤 추가
						
						toNativeData.func = 'onShowPG';
						toNativeData.url= "https://${pageContext.request.serverName}${pageContext.request.contextPath}/pay/nicepay/popupPaymentRequestForMo?"+$("#order_payment_form").serialize();
						toNative(toNativeData);
					} else {
						// 1. 팝업열기
						var pgPopup = window.open("about:blank", "payWindow");
						
						if(pgPopup==null) {
							ui.alert("팝업차단을 허용하시기 바랍니다.",{
								ycb:function(){
								},
								ybt:'확인'
							});

							return;
						}
						setTimeout(function() {
							$("#order_payment_form").attr("action", "${pageContext.request.contextPath}/pay/nicepay/popupPaymentRequestForMo");
							$("#order_payment_form").attr("target","payWindow");
							$("#order_payment_form").attr("acceptCharset", "euc-kr");
							// 2. 팝업에 submit
							$("#order_payment_form").submit();
							$("#order_payment_form").attr("target","_self");
						}, 1000);
					}
				}else{//PC 결제창 진입
					goPay(document.order_payment_form);
				}
			}
			<c:if test="${svrEnv eq frontConstants.ENVIRONMENT_GB_DEV}">
			/**
			 * 성능테스트 후 삭제
			 */
			function orderComplete(){

				let url = "<spring:url value='/order/insertOrderFreePayAmt' />";

				let options = {
					url : url,
					data : $("#order_payment_form").serialize(),
					done : function(data){
						orderActionLog();
						orderAdbrix();
						
						//앱 마케팅 처리 딜레이
						setTimeout(function() {
							$("#order_payment_form").attr("action", "/order/indexOrderCompletion");
							$("#order_payment_form").attr("target", "_self");
							$("#order_payment_form").attr("method", "post");
							$("#order_payment_form").submit();
						}, 300);
					}
					,fail : function(){

					}
				};
				ajax.call(options);
			}
			</c:if>
			/**
			 * 가상계좌 채번
			 */
			function vaccountSubmit() {
				ajax.call({
					url : "<spring:url value='/pay/nicepay/indexVaccountResult' />"
					, data : $("#order_payment_form").serialize()
					, done : function(data){
						orderActionLog();
						orderAdbrix();
						//앱 마케팅 처리 딜레이
						setTimeout(function() {
							$("#order_payment_form").attr("action", "/order/indexOrderCompletion");
							$("#order_payment_form").attr("target", "_self");
							$("#order_payment_form").attr("method", "post");
							$("#order_payment_form").submit();
						}, 300);
					}
				});
			}

			//[PC 결제창 전용]결제 최종 요청시 실행됩니다. <<'nicepaySubmit()' 이름 수정 불가능>>
			function nicepaySubmit(){
				$("#nice_layer").remove();
				$("#bg_layer").remove();

				ajax.call({
					url : "<spring:url value='/pay/nicepay/indexNicepayResult' />"
					, data : $("#order_payment_form").serialize()
					, done : function(data){
						/**
						 *주문완료 페이지 넘어가기 전에 loading bar 띄움 (주문서가 나오면 결제 실패와 착각하지 않도록)
						 */
						orderActionLog();
						orderAdbrix();

						waiting.start();
						//앱 마케팅 처리 딜레이
						setTimeout(function() {
							$("#order_payment_form").attr("action", "/order/indexOrderCompletion");
							$("#order_payment_form").attr("target", "_self");
							$("#order_payment_form").attr("method", "post");
							$("#order_payment_form").submit();
						}, 300);
					}

				});


			}

			/**
			 * 모바일 웹/앱에서 사용되는 complete페이지로 이동되는 페이지
			 */
			function nicepayResultForMo(stringJson) {
				/**
				 *주문완료 페이지 넘어가기 전에 loading bar 띄움 (주문서가 나오면 결제 실패와 착각하지 않도록)
				 */
				waiting.start();
				var data = JSON.parse(stringJson);
				$.each(data, function(index, value) {
					if (value.value != null)
						$("#"+value.name).val(value.value);
				});

				orderActionLog();
				orderAdbrix();

				//앱 마케팅 처리 딜레이
				setTimeout(function() {
					$("#order_payment_form").attr("action", "/order/indexOrderCompletion");
					$("#order_payment_form").attr("target", "_self");
					$("#order_payment_form").attr("method", "post");
					$("#order_payment_form").submit();
				}, 300);

			}

			/**
			 * IOS앱에서 사용하는 빈 javascript 함수
			 */
			function blankCallback(blankJson) {

			}
			function nicepayBilling(){

				ajax.call({
					url : "<spring:url value='/pay/nicepay/indexNicepayBillingResult' />"
					, data : $("#order_payment_form").serialize()
					, done : function(data){
						orderActionLog();
						orderAdbrix();

						/**
						 *주문완료 페이지 넘어가기 전에 loading bar 띄움 (주문서가 나오면 결제 실패와 착각하지 않도록)
						 */
						waiting.start();
						//앱 마케팅 처리 딜레이
						setTimeout(function() {
							$("#order_payment_form").attr("action", "/order/indexOrderCompletion");
							$("#order_payment_form").attr("target", "_self");
							$("#order_payment_form").attr("method", "post");
							$("#order_payment_form").submit();
						}, 300);
					}

				});

			}

			//[PC 결제창 전용]결제창 종료 함수 <<'nicepayClose()' 이름 수정 불가능>>
			function nicepayClose(){
				ui.alert('결제가 취소 되었습니다.',{
					ycb:function(){
					},
					ybt:'확인'
				});
				return;
			}

			function selectPayMethod(payMeansCd){
				if (payMeansCd === "<c:out value='${frontConstants.PAY_MEANS_10}' />") {	// 신용카드
					$("#payMeansCd").val("<c:out value='${frontConstants.PAY_MEANS_10}' />");
					$("#payMethod").val("CARD");
					//$("#selectCardCode").val("");
					//$("#order_payment_cardc").val("");
					//$("#cardcCd").val("");
					$("#directShowOpt").val("CARD");
					$("#directEasyPay").val("");
					$("#directCouponYN").val("Y");
					$("#easyPayMethod").val("");
					$("#nicepayReserved").val("");

					//$("#cardLi").addClass("active");
					//나이스약관
					useNiceTerm();

				}else if (payMeansCd === "<c:out value='${frontConstants.PAY_MEANS_11}' />") {	// 카드빌링

					$("#payMeansCd").val("<c:out value='${frontConstants.PAY_MEANS_11}' />");
					$("#payMethod").val("");
					$("#selectCardCode").val("");
					$("#order_payment_cardc").val("");
					$("#cardcCd").val("");
					$("#selectQuota").val("00");
					$("#shopInterest").val("");
					$("#cardQuota").val("00");
					$("#cardInterest").val("0");
					$("#nicepayReserved").val("");
					$("#directShowOpt").val("");
					$("#directCouponYN").val("N");
					$("#directEasyPay").val("");
					$("#easyPayMethod").val("");
					$("ul.biltab > li").removeClass("active");
					//$("#naverPayLi").addClass("active");

				}else if (payMeansCd === "<c:out value='${frontConstants.PAY_MEANS_20}' />") {	// 실시간계좌이체

					$("#payMeansCd").val("<c:out value='${frontConstants.PAY_MEANS_20}' />");
					$("#payMethod").val("BANK");
					$("#selectCardCode").val("");
					$("#order_payment_cardc").val("");
					$("#cardcCd").val("");
					$("#selectQuota").val("");
					$("#shopInterest").val("");
					$("#cardQuota").val("");
					$("#cardInterest").val("");
					$("#directShowOpt").val("");
					$("#directCouponYN").val("N");
					$("#directEasyPay").val("");
					$("#easyPayMethod").val("");
					$("#nicepayReserved").val("DirectRcptType=1|DirectRcptNo=01012341234|DirectRcptNoType=HPP");
					/*$("#directRcptType").val("1");
					$("#directRcptNo").val("01025802460")
					$("#directRcptNoType").val("HPP");*/
					//$("#realtimeLi").addClass("active");

					//나이스약관미사용
					useBaseTerm();


				}else if (payMeansCd === "<c:out value='${frontConstants.PAY_MEANS_30}' />") {	// 가상계좌

					$("#payMeansCd").val("<c:out value='${frontConstants.PAY_MEANS_30}' />");
					$("#payMethod").val("VBANK");
					$("#selectCardCode").val("");
					$("#order_payment_cardc").val("");
					$("#cardcCd").val("");
					$("#selectQuota").val("");
					$("#shopInterest").val("");
					$("#cardQuota").val("");
					$("#cardInterest").val("");
					$("#nicepayReserved").val("");
					$("#directShowOpt").val("");
					$("#directCouponYN").val("N");
					$("#directEasyPay").val("");
					$("#easyPayMethod").val("");
					//$("#vertLi").addClass("active");
					$("#easyPayMethod").val("");

					//나이스약관미사용
					useBaseTerm();


				}else if (payMeansCd === "<c:out value='${frontConstants.PAY_MEANS_70}' />") {	// 네이버페이

					$("#payMeansCd").val("<c:out value='${frontConstants.PAY_MEANS_70}' />");
					$("#payMethod").val("CARD");
					$("#selectCardCode").val("");
					$("#order_payment_cardc").val("");
					$("#cardcCd").val("");
					$("#selectQuota").val("");
					$("#shopInterest").val("");
					$("#cardQuota").val("");
					$("#cardInterest").val("");
					$("#nicepayReserved").val("");
					$("#directShowOpt").val("CARD");
					$("#directCouponYN").val("N");
					$("#directEasyPay").val("E020");
					$("#easyPayMethod").val("E020=CARD");

					//$("#naverPayLi").addClass("active");

					//나이스약관
					useNiceTerm();


				}else if (payMeansCd === "<c:out value='${frontConstants.PAY_MEANS_71}' />") {	// 카카오페이

					$("#payMeansCd").val("<c:out value='${frontConstants.PAY_MEANS_71}' />");
					$("#payMethod").val("CARD");
					$("#selectCardCode").val("");
					$("#order_payment_cardc").val("");
					$("#cardcCd").val("");
					$("#selectQuota").val("");
					$("#shopInterest").val("");
					$("#cardQuota").val("");
					$("#cardInterest").val("");
					$("#directShowOpt").val("CARD");
					$("#directCouponYN").val("N");
					$("#nicepayReserved").val("DirectKakao=Y");
					$("#directEasyPay").val("");
					$("#easyPayMethod").val("");
					//$("#kakaoPayLi").addClass("active");

					//나이스약관
					useNiceTerm();


				}else if (payMeansCd === "<c:out value='${frontConstants.PAY_MEANS_72}' />") {	// 페이코

					$("#payMeansCd").val("<c:out value='${frontConstants.PAY_MEANS_72}' />");
					$("#payMethod").val("CARD");
					$("#selectCardCode").val("");
					$("#order_payment_cardc").val("");
					$("#cardcCd").val("");
					$("#selectQuota").val("");
					$("#shopInterest").val("");
					$("#cardQuota").val("");
					$("#cardInterest").val("");
					$("#directShowOpt").val("CARD");
					$("#directCouponYN").val("N");
					$("#nicepayReserved").val("DirectPayco=Y");
					$("#directEasyPay").val("");
					$("#easyPayMethod").val("");
					//$("#paycoLi").addClass("active");

					//나이스약관
					useNiceTerm();


				}else if (payMeansCd === "<c:out value='${frontConstants.PAY_MEANS_00}' />") {	//0원 결제
					//나이스약관미사용
					$("#payMeansCd").val("<c:out value='${frontConstants.PAY_MEANS_00}' />");
					useBaseTerm();
				}

			}

			function checkedDefaultPayMethod(){

				if($("input:checkbox[id=order_payment_default_pay_method]").is(":checked") === true) {
					//작업
					$("#order_payment_default_pay_method").prop("checked", false);
					$("#defaultPayMethodSaveYn").val("N");
				}else{
					$("#order_payment_default_pay_method").prop("checked", true);
					$("#defaultPayMethodSaveYn").val("Y");
				}

			}

			function checkedSaveCashReceiptInfo(){

				if($("input:checkbox[id=order_payment_save_cash_receipt]").is(":checked") === true) {
					//작업
					$("#order_payment_save_cash_receipt").prop("checked", false);
					$("#cashReceiptInfoSave").val("N");
				}else{
					$("#order_payment_save_cash_receipt").prop("checked", true);
					$("#cashReceiptInfoSave").val("Y");
				}

			}

			//카드사 선택
			function selCard(card) {
				$("#cardcCd").val(card);
				$("#selectCardCode").val(card);
				
				$("#selectQuota").val("00");
				
				setCardHalbu();
			}

			// 할부 선택
			function selHalbu(halbu) {
				$("#selectQuota").val(halbu);
				$("#cardQuota").val(halbu);
				$("#shopInterest").val($("#order_payment_halbu option:selected").data("frinst"));
				$("#cardInterest").val($("#order_payment_halbu option:selected").data("frinst"));
			}

			// 빌링 할부 선택
			function selHalbu2(halbu, prsnBillNo) {
				$("#cardQuota").val(halbu);
				$("#cardInterest").val($("#order_payment_halbu" + prsnBillNo).find("option:selected").data("frinst"));
			}

			// 할부정보 가져오기(무이자)
			function setCardHalbu(){
				let stdAmt =  $("#order_payment_total_pay_amt").val();
				let optionHtml = '<option value="00" selected>일시불</option>';

				if ($("#cardcCd").val() !== ""){

					let options = {
						url : "<spring:url value='/order/getOrderFreeHalbu' />"
						,data : {
							cardcCd : $("#cardcCd").val()
							, minAmt : stdAmt
						}
						,done : function(data){

							let freeHalbuList = data.freeHalbuList;
							
							if(parseInt(stdAmt) >= 50000){

								for (let i = 0; i <= 10; i++){
									let instmntTpCd = 0;
									let isHalbu = "(무이자)";
									try {
										instmntTpCd = parseInt(freeHalbuList[i].instmntTpCd);
									} catch (e) {
										instmntTpCd = 0;
										isHalbu = "";
									}
									optionHtml += '<option data-frinst="'+ instmntTpCd +'" value="'+ (i+2).toString().lpad(2, "0") +'">' + (i+2) + '개월'+isHalbu+'</option>'
								}
								
								$("#order_payment_halbu").html(optionHtml);
		
								let attr = $("#order_payment_halbu").attr("disabled");
		
								if (attr !== undefined && attr === "disabled"){
									$("#order_payment_halbu").removeAttr("disabled");
								}
								$("#order_payment_halbu").val("00").trigger("change");
							}else{
								$("#order_payment_halbu").html(optionHtml);
								$("#order_payment_halbu").val("00");
							//	$("#order_payment_halbu").attr("disabled", "disabled");
							}
						}

					};
					ajax.call(options);
				} else {
					$("#order_payment_halbu").html(optionHtml);
				}

			}
			
			String.prototype.lpad = function(padLen, padStr) {
			    var str = this;
			    if (padStr.length > padLen) {
			        console.log("오류 : 채우고자 하는 문자열이 요청 길이보다 큽니다");
			        return str + "";
			    }
			    while (str.length < padLen)
			        str = padStr + str;
			    str = str.length >= padLen ? str.substring(0, padLen) : str;
			    return str;
			};
			
			function setCardHalbu2(prsnBillNo, selCardc){
				if ($("#order_payment_halbu" + prsnBillNo + " option:selected").val() == '00') {
				
					// 처음엔 일시불로 세팅
					$("#cardQuota").val("00");
					$("#selectQuota").val("00");
	
					$("[id^='order_payment_halbu']").html('<option value="00" selected>일시불</option>');
					$("[id^='order_payment_halbu']").val("00");
					$("[id^='order_payment_halbu']").attr("disabled", "disabled");
	
					let stdAmt =  $("#order_payment_total_pay_amt").val();
					let optionHtml = '<option value="00" selected>일시불</option>';
					if (selCardc !== ""){
	
						let options = {
							url : "<spring:url value='/order/getOrderFreeHalbu' />"
							,data : {
								cardcCd : selCardc
								, minAmt : stdAmt
							}
							,done : function(data){
								let freeHalbuList = data.freeHalbuList;
	
								if(parseInt(stdAmt) >= 50000){
									for (let i = 0; i <= 10; i++){
										let instmntTpCd = 0;
										let isHalbu = "(무이자)";
										try {
											instmntTpCd = parseInt(freeHalbuList[i].instmntTpCd);
										} catch (e) {
											instmntTpCd = 0;
											isHalbu = "";
										}
										optionHtml += '<option data-frinst="'+ instmntTpCd +'" value="'+ (i+2).toString().lpad(2, "0") +'">' + (i+2) + '개월'+isHalbu+'</option>'
									}
		
									$("#order_payment_halbu" + prsnBillNo).html(optionHtml);
		
									let attr = $("#order_payment_halbu" + prsnBillNo).attr("disabled");
		
									if (attr !== undefined && attr === "disabled"){
										$("#order_payment_halbu" + prsnBillNo).removeAttr("disabled");
									}
								}else{
									$("#order_payment_halbu").html(optionHtml);
									$("#order_payment_halbu").val("00");
								//	$("#order_payment_halbu").attr("disabled", "disabled");
								}
	
							}
	
						};
						ajax.call(options);
					} else {
						$("#order_payment_halbu" + prsnBillNo).html(optionHtml);
					}
					
				}

			}

			function checkSelectAll()  {
				// 전체 체크박스
				let checkboxes = document.querySelectorAll('input[name="ordTerms"]');
				// 선택된 체크박스
				let checked = document.querySelectorAll('input[name="ordTerms"]:checked');
				// select all 체크박스
				let selectAll = document.querySelector('input[name="chkAllTerms"]');

				
				if(checkboxes.length === checked.length) {
					selectAll.checked = true;
				}else {
					selectAll.checked = false;
				}

			}

			function selectAll(selectAll)  {
				const checkboxes = document.getElementsByName("ordTerms");

				checkboxes.forEach((checkbox) => {
					checkbox.checked = selectAll.checked
				})
			}

			function cardFormat(str){

				var tmp = '';
				if( str.length < 4){
					return str;
				}
				else if(str.length < 8){
					tmp += str.substr(0, 4);
					tmp += '-';
					tmp += str.substr(4,4);
					return tmp;
				}else if(str.length < 12){
					tmp += str.substr(0, 4);
					tmp += '-';
					tmp += str.substr(4, 4);
					tmp += '-';
					tmp += str.substr(8,4);
					return tmp;
				}else if(str.length < 17) {

					tmp += str.substr(0, 4);
					tmp += '-';
					tmp += str.substr(4, 4);
					tmp += '-';
					tmp += str.substr(8,4);
					tmp += '-';
					tmp += str.substr(12,4);
					return tmp;
				}
				return str;

			}

			//간편카드결제
			function selectCardPayment(){
				//나이스약관 미사용
				useBaseTerm();
				loadEasyPay("N");

				let billNo = $("#prsnCardBillNo").val();

				if(billNo === null || billNo === ""){

					setTimeout(function(){
						selectDefBillCard();
					},200);
				}

			}

			function selectDefBillCard(){
				let prsnBillNo = $(".cardsel_slide").find('[id^=cardBill_].payM_choiceCard').data("num");
				
				if ($("#order_payment_halbu" + prsnBillNo + " option:selected").val() == '00') {
					selectPayMethod("<c:out value="${frontConstants.PAY_MEANS_11}" />");
	
					setTimeout(function() {
						let selCardc = $(".cardsel_slide").find('[id^=cardBill_].payM_choiceCard').data("cardc");
	
						$("#prsnCardBillNo").val(prsnBillNo);
	
						setCardHalbu2(prsnBillNo, selCardc);
	
					}, 500);
				}

			}

			function selectBillingCard(prsnBillNo){
				selectPayMethod("<c:out value="${frontConstants.PAY_MEANS_11}" />");
				$("#prsnCardBillNo").val(prsnBillNo);

				let selCardc = $(".cardsel_slide").find('[id^=cardBill_].payM_choiceCard').data("cardc");
				setCardHalbu2(prsnBillNo, selCardc);
			}

			function setBillCard(){


				/*let prsnBillNo = $(".cardsel_slide").find('[id^=cardBill_].payM_choiceCard').data("num");
				let selCardc = $(".cardsel_slide").find('[id^=cardBill_].payM_choiceCard').data("cardc");

				$("#prsnCardBillNo").val(prsnBillNo);

				setTimeout(function(){

					setCardHalbu2(prsnBillNo, selCardc);

					//if(ui.check_brw.pc()) cardsld.slideTo(ind);
				},900);*/

				let prsnBillCard = $("#prsnCardBillNo").val();

				if(prsnBillCard !== null && prsnBillCard !== ""){

					cardsld.slideTo($("#selBillCard"+prsnBillCard).data("index"));



					let selCardc = $(".cardsel_slide").find('[id^=cardBill_].payM_choiceCard').data("cardc");
					selectPayMethod("<c:out value="${frontConstants.PAY_MEANS_11}" />");

					setTimeout(function() {
						//setCardHalbu2(prsnBillNo, selCardc);
					}, 300);

				}


			}
			//일반결제
			function selectCommonPayment(){
				useNiceTerm();
				let loadPayMeansCd = $("#payMeansCd").val();
				selectPayMethod(loadPayMeansCd);
				//$("input[name=ordTerms]").prop("checked", false);
			}

			function confirmBillPassword(){

				let url = "<spring:url value='/order/confirmBillPassword' />";

				let options = {
					url : url
					, data : {
						birth : $("#birth").val()
					}
					, dataType : "html"
					, done : function(html){
						$("#popBilPwdConfirm").html(html);
						ui.popLayer.open("popBilPwdConfirm");
						simpChk = false;
					}
				}
				ajax.call(options);

			}

			//나이스 약관사용
			function useNiceTerm(){
				//나이스 약관체크 되도록
				$('.chkNiceTerms').attr("name","ordTerms");

				//체크해제
				$("input[name=ordTerms]").prop("checked", false);
				$("input[name=chkAllTerms]").prop("checked", false);

				//나이스약관보이게
				$(".nicePaymentTerms").css("display","block");
			}

			//나이스약관 제외 기본 약관 사용
			function useBaseTerm(){
				//체크해제
				$("input[name=ordTerms]").prop("checked", false);
				$("input[name=niceOrdTerms]").prop("checked", false);
				$("input[name=chkAllTerms]").prop("checked", false);

				//나이스 약관 체크박스 이름 바꿈  전체체크시 제외되기 위해서
				$('.chkNiceTerms').attr("name","niceOrdTerms");

				//나이스약관 가리기
				$(".nicePaymentTerms").css("display","none");

			}

			function selectCertType(certType){

				if(certType === "gsPoint" || certType === "registCardBill" || certType === "nonMember" || certType === "registSktmp"){
					confrimCertAndTerms(certType);
				}else{

					setOkCeretCallBack(function(result){
						let ciVal = $("#ciCtfVal").val();

						if(result.CI === ciVal){
							confirmOpenResetPasswordPop();
						}else if(result.CI !== ciVal){
							ui.alert("회원과 휴대폰 명의가 동일해야 <br> 이용이 가능합니다" ,{
								ycb:function(){
								},
								ybt:'확인'
							});
						}
					});
					okCertPopup(99);
				}
			}

			function closeLayer(id){
				ui.popLayer.close(id);
			}

			function loadEasyPay(firstYn){

				let url = "<spring:url value='/order/incEasyPay' />";

				let options = {
					url : url
					, dataType : "html"
					, done : function(html){
						$("#easyPayCard").html(html);
						/* if ('${paySaveInfo.payMeansCd}' == '${frontConstants.PAY_MEANS_11}') {
							
						} else {
						} */
						let cardRegibox = $(".cardsel_slide").find('[id^=cardBill_]').first()[0].className;
						if (cardRegibox.indexOf('cardRegibox') == -1) {
							$(".cardsel_slide").find('[id^=cardBill_]').first().addClass("payM_choiceCard");
						}
						selectDefBillCard();
					}
				}
				ajax.call(options);

			}

			function validNonMember(){
				// 정회원 여부 valid
				let memberYn = $("#memberYn").val();
				if(memberYn === "N"){
					selectCertType('nonMember');
				}else if(memberYn === "Y"){
					var isGsptUseYnY = "${memberBase.gsptUseYn}" == "${frontConstants.USE_YN_Y}";
					var gsptNoIsNull = "${gsptNoIsNull}";

					if(gsptNoIsNull == "${frontConstants.COMM_YN_Y}" || !isGsptUseYnY ){
						var config = {
								callBack : function() { orderPay.excute(); }
							,	okCertCallBack : function(data) { orderPay.excute(); }
						};
						gk.open(config);
					}else{
						if (!simpChk) {
							simpChk = true;
							orderPay.excute();
						}
					}
				}
			}
			
			// 우주코인 멤버십 등록/변경 팝업
			function popupSktmpRegist(){
				let url = "/order/popupRegistSktmp";
				
				if ("${view.deviceGb eq frontConstants.DEVICE_GB_10}" == "true") {
					let options = {
						url : url
						, dataType : "html"
						, done : function(html){
							$("#popSktmp").html(html);
							ui.popLayer.open("popSktmp");
						}
					}
					ajax.call(options);
				} else {
					window.open(url, "sktmpWinPop");
				}
			}
			
			// 우주코인 멤버십 비밀번호 확인 팝업
			function popupSktmpPwdChk(){
				let url = "/order/popupSktmpPassword";
				
				if ("${view.deviceGb eq frontConstants.DEVICE_GB_10}" == "true") {
					let options = {
						url : url
						, dataType : "html"
						, done : function(html){
							$("#popSktmpPwd").html(html);
							ui.popLayer.open("popSktmpPwd");
						}
					}
					ajax.call(options);
				} else {
					window.open(url, "sktmpPwdWinPop");
				}
			}

		</script>
	</tiles:putAttribute>
</tiles:insertDefinition>
<script>$(".menubar").remove();</script>
