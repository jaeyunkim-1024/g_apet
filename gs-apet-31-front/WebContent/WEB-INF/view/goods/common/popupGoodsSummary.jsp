<%--
  Created by IntelliJ IDEA.
  User: ssh
  Date: 2021-02-23
  Time: 오후 7:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<script type="text/javascript" 	src="/_script/file.js"></script>
<script type="text/javascript">
	$(function(){
		//ui.commentBox.open('.type01');
		$(".bt.btCart, .bt.btOrde").click(function(){
			$(".commentBoxAp .product-option").addClass("none");
			$(".commentBoxAp .product-buy").removeClass("none");
		})
	})
	//공유하기 버튼 클릭
	function shareBtnClick(){
		var goodsId = '<c:out value="${goods.goodsId}"/>';

		$.ajax({
			type: "POST",
			url: "/goods/getGoodsShortUrl",
			data : {goodsId : goodsId},
			dataType: "json",
			success: function (shortUrl) {
				//app인 경우
				var deviceGb = "${view.deviceGb}";
				var shareImg = '${frame:optImagePath( dlgtImgPath , frontConstants.IMG_OPT_QRY_756 )}';

				// APP인경우
				if("${view.deviceGb}" == "${frontConstants.DEVICE_GB_30 }"){
					// 데이터 세팅
					toNativeData.func = "onShare";
					toNativeData.image = "";
					toNativeData.subject = "${goods.goodsNm}";
					toNativeData.link = shortUrl;
					// 호출
					toNative(toNativeData);
				}else{
					//web인 경우
					copyToClipboard(shortUrl);
				}
			},
			error: function (request, status, error) {
				ui.alert("공유하기 실패하였습니다.");
			}
		});
	}

	/**
	 * 초대코드 복사
	 * @param val
	 */
	function copyToClipboard(val){
		var textarea = document.createElement("textarea");
		document.body.appendChild(textarea);
		textarea.value = val;
		textarea.select();
		document.execCommand('copy');
		document.body.removeChild(textarea);

		// messager.toast({txt: "추천코드가 복사되었습니다."});
		fnGoodsUiToast("링크가 복사되었어요", "share");
	}

	// 배송 시간 카운트
	function deliveryTime(targetId, targetTime){

		var curTime = "${currentTime}";
		var serverTime = new Date(curTime.replace(/\s/, 'T'));
		var now = new Date();
		var dateGap = serverTime.getTime() - now.getTime();
		var realTime = targetTime - dateGap;

		$("[name='"+targetId+"Hour']").countdown(realTime, function(event) {
			$("[name='"+targetId+"Hour']").text(event.strftime('%H'));
			$("[name='"+targetId+"Min']").text(event.strftime('%M'));
		});
	}

	// 금액 콤마 처리.
	function numberWithCommas(x) {
		x = String(x);
		var pattern = /(-?\d+)(\d{3})/;
		while (pattern.test(x))
			x = x.replace(pattern, "$1,$2");
		return x;
	}
	
	// 콤마 삭제
	function removeComma(str) {
		str = String(str);
		return str.replace(/[^0-9\.]+/g, '');
	}
	
	function fnGoodsUiToast(text, cls){
		console.log("fnGoodsUiToast text : " + text);
		ui.toast(text,{
			cls : cls ,
			bot: 74, //바닥에서 띄울 간격
			sec:  3000 //사라지는 시간
		});
	}
	
	function openPopupCoupon() {
		var goodsId = '<c:out value="${goods.goodsId}"/>';
		var goodsCstrtTpCd = '<c:out value="${goods.goodsCstrtTpCd}"/>';
		//쿠폰 목록 조회
		var fnGetCoupons = function(goodsId, goodsCstrtTpCd) {
			//쿠폰 팝업 열기
			$("#cartNavs").css("z-index",-1);
			$(".hdr").css("z-index" ,99);
			ui.popLayer.open('popCpnGet',{
				ocb : function(){ $("#cartNavs").css("z-index",-1); $(".hdr").css("z-index" ,99);} ,
				ccb : function(){ $("#cartNavs").css("z-index",""); $(".hdr").css("z-index" , "");}
			});
		}
		fnGetCoupons();
	}
	
	//상품상세 이동
	function fnGoGoodsDetail(goodsId){
		var $btn = $(".petTabHeader .uiTab li[class*='active']").find("button");
		var callGoodsId = "-"+goodsId;
		
		if(document.location.href.indexOf("/tv/series/indexTvDetail") > -1){
			//App일때 영상상세에서 다른화면으로 이동시 화면 닫고 이동해야함
			if("${view.deviceGb eq frontConstants.DEVICE_GB_30}" == "true"){
				var callParam = "";
				if(sortCd != ""){
					callParam = nowVdId+"."+sortCd+"."+listGb+"."+$btn.data("id")+callGoodsId;
				}else{
					callParam = nowVdId+"."+listGb+"."+$btn.data("id")+callGoodsId;
				}
				
				// 데이터 세팅
				toNativeData.func = "onCloseMovePage";
				toNativeData.moveUrl = "${view.stDomain}/goods/indexGoodsDetail?goodsId="+goodsId+"&callParam="+callParam;
				// APP 호출
				toNative(toNativeData);
			}else{
				if("${view.deviceGb eq frontConstants.DEVICE_GB_20}" == "true"){
					var replaceUrl = document.location.href+"-"+$btn.data("id")+callGoodsId;
					history.replaceState("", "", replaceUrl);
					storageHist.replaceHist(replaceUrl);
				}
				
				location.href = "/goods/indexGoodsDetail?goodsId=" + goodsId;
			}
		}else if(document.location.href.indexOf("/tv/school/indexTvDetail") > -1){
			if("${view.deviceGb ne frontConstants.DEVICE_GB_10}" == "true"){
				var replaceUrl = document.location.href+"&goodsVal="+$btn.data("id")+callGoodsId;
				history.replaceState("", "", replaceUrl);
				storageHist.replaceHist(replaceUrl);
			}
			
			location.href = "/goods/indexGoodsDetail?goodsId=" + goodsId;
		}else if(document.location.href.indexOf("/log/indexPetLogList") > -1){
			if("${view.deviceGb ne frontConstants.DEVICE_GB_10}" == "true"){
				var replaceUrl = document.location.href.split('&selIdx=')[0];
				replaceUrl = replaceUrl + "&selIdx="+$("#popconTing").data("idx")+"&page="+$("#popconTing").data("page")+"&goodsVal="+goodsId
				history.replaceState("", "", replaceUrl);
				storageHist.replaceHist(replaceUrl);
			}
			
			location.href = "/goods/indexGoodsDetail?goodsId=" + goodsId;
		} else if( document.location.href.indexOf("/shop/indexLive") > -1 ) {
						
			// 라이브 상세화면에서 이미 storageHist.setHist(); 실행하여 히스토리 저장했음.
			location.href = "/goods/indexGoodsDetail?goodsId=" + goodsId;
			
		} else {
			location.href = "/goods/indexGoodsDetail?goodsId=" + goodsId;
		}
	}
</script>
	<div class="con">
		<!-- shop_02_02_03_02_01_01_펫샵_서브메인_LIVE_라이브상세_상품옵션 -->
		<div class="product-option over-auto k0430" id="productOption">
			<p class="pic">
				<c:choose>
					<c:when test="${compositionImgList eq null}">
						<c:forEach items="${goodsImgList }" var="img" varStatus="status">
							<c:if test="${img.dlgtYn eq 'Y'}">
<!-- 								직사각형을 정사각형으로 변경함. frontConstants.IMG_OPT_QRY_210 >>>> frontConstants.IMG_OPT_QRY_756 -->
								<img class="img" src="${frame:optImagePath( img.imgPath , frontConstants.IMG_OPT_QRY_756 )}" alt="${goods.goodsNm}" onerror="this.src='../../_images/common/img_default_thumbnail_2@2x.png'"/>
							</c:if>	
						</c:forEach>
					</c:when>
				</c:choose>
			</p>
			<div class="page shop view">
				<section class="pdInfos p1">
					<!-- 공유하기 -->
					<div class="share">
						<button class="logBtnBasic btn-share"  data-message="링크가 복사되었어요" id="share" title="COPY URL" data-clipboard-text="${shareUrl }" onclick="shareBtnClick(); return false;" data-content="${goods.goodsId}" data-url="shareBtnClick();"><span>공유</span></button>
					</div>
					
					<!-- 아이콘 -->
					<div class="flag"><!-- @@ 03.03 수정 -->
						<c:set var="iconCnt" value="${not empty goods.cateIcon ? 4 : 5}" />
						<fmt:parseNumber var="iconIdx" value="0" />
						<c:if test="${not empty goods.cateIcon}">
							<em class="fg a"><c:out value="${goods.cateIcon}" escapeXml="false"/></em>
						</c:if>
						<c:forEach items="${fn:split(goods.icons,',')}" var="icon" varStatus="idx">
							<c:if test="${icon ne '업체배송' and icon ne '무료배송'}">
								<c:if test="${iconIdx < iconCnt and icon != ''}" >
									<c:choose>
										<c:when test="${icon ne '타임딜' and icon ne '1+1' and icon ne '2+1' and icon ne '사은품'}">
											<em class="fg c"><c:out value="${icon}" escapeXml="false"/></em>
										</c:when>
										<c:otherwise>
											<em class="fg b"><c:out value="${icon}" escapeXml="false"/></em>
										</c:otherwise>
									</c:choose>
								</c:if>
								<c:set var="iconIdx" value="${iconIdx + 1}"/>
							</c:if>
						</c:forEach>
					</div>
					<!-- 브랜드관 노출/비노출 영역 -->
					<c:if test="${!empty goods.bndNo}">
						<div class="pstore">
							<%-- <a href="<c:url value="/brand/indexBrandDetail?bndNo=${goods.bndNo}&cateCdL=${goods.cateCdL}&cateCdM=${goods.cateCdM}"/>" class="bt">${goods.bndNmKo}</a> --%>
							<a href="javascript:;" class="bt">${goods.bndNmKo}</a>
						</div>
					</c:if>
					
					<div class="names">${goods.goodsNm}</div>
					<c:if test="${not empty commentTotalCnt && commentTotalCnt != 0 }">
						<div class="starpoint">
							<span class="stars sm p_${fn:replace(scoreList.estmAvgStar, '.', '_') }"></span>
							<span class="point"><fmt:formatNumber value="${scoreList.estmAvg/2 }" pattern="0.0"/></span>
							<span class="revew"><a href="javascript:;" class="lk" name="pdRevCnt">(${not empty commentTotalCnt ? commentTotalCnt : 0})</a></span>
						</div>
					</c:if>
					<div class="prices">
						<div class="price">
							<c:if test="${goods.orgSaleAmt > goods.saleAmt and ((goods.orgSaleAmt - goods.saleAmt)/goods.orgSaleAmt * 100) > 1 }">
								<span class="disc"><fmt:formatNumber value="${(goods.orgSaleAmt - goods.saleAmt)/goods.orgSaleAmt * 100}" type="percent" pattern="#,###,###"/>%</span>
							</c:if>
							<span class="prcs"><frame:num data="${goods.saleAmt}" /><i class="w">원</i></span>
							<c:if test="${goods.orgSaleAmt > goods.saleAmt and ((goods.orgSaleAmt - goods.saleAmt)/goods.orgSaleAmt * 100) > 1 }">
								<span class="ogpc"><frame:num data="${goods.orgSaleAmt}" /><i class="w">원</i></span>
							</c:if>
						</div>
						<!-- 쿠폰받기 -->
						<div class="coupon" id="isCoupon" style="display: none">
							<a href="javascript:;" onclick="openPopupCoupon();" class="bt cpn"><spring:message code ='front.web.view.goods.coupon.get.title'/></a>
						</div>
						<jsp:include page="/WEB-INF/view/goods/includeNew/includePopupCoupon.jsp" />
					</div>
					<c:if test="${goods.mdRcomYn == 'Y'}" >
						<%--
						<div class="checkpnt">
							<div class="tit">Check Point!</div>
							<div class="msg">
								<div class="txt"><c:out value="${goods.checkPoint}"  escapeXml="false"/>
									<button type="button" class="bt more" onclick="ui.popLayer.open('popCheckPoint');">더보기</button>
								</div>
							</div>
						</div>
						--%>
						<c:if test="${not empty goods.mdRcomWds}" >
							<div class="mdmsg">
								<div class="ment">${goods.mdRcomWds}</div>
							</div>
						</c:if>
					</c:if>
					<div class="tags">
						<c:if test="${not empty tagList}">
							<div class="tit">연관태그</div>
							<div class="box">
								<ui class="tgs">
									<c:forEach items="${tagList}" var="goodsTags" end="9" varStatus="idx">
										<%-- <li><a href="/shop/indexPetShopTagGoods?tags=${goodsTags.tagNo}&tagNm=${goodsTags.tagNm}" class="tg">#<c:out value="${goodsTags.tagNm}" escapeXml="false"/></a></li> --%>
										<li><a href="javascript:;" class="tg">#<c:out value="${goodsTags.tagNm}" escapeXml="false"/></a></li>
									</c:forEach>
								</ui>
								<c:if test="${!empty tagList}">
									<div class="more"><a href="javascript:;" class="bt">더보기</a></div>
								</c:if>
							</div>
						</c:if>
					</div>
					<hr class="hbar">
					<div class="benefit">
						<div class="box">
							<div class="tit">할인혜택</div>
							<div class="ctn">
								<c:set var="gsPointValue" value="${(goods.saleAmt * memberGradeInfo.svmnRate) / 100}"/>
								<p>GS&POINT <em class="pt"><fmt:formatNumber value="${gsPointValue+(1-(gsPointValue%1))%1}" type="number" pattern="#,###,###"/>P</em> 적립 </p>
							</div>
						</div>
					</div>
					<div class="deliys">
						<div class="box">
							<div class="tit">배송정보</div>
							<div class="ctn">
								<p><span class="dawn"><span name="dlvrAmt"></span></span></p>
								<p><span class="free"><span name="dlvrFree"></span></span></p>
							</div>
							<!-- <a href="javascript:;" class="bt more" onclick="ui.popBot.open('popDelInfo', {'pop':true});">더보기</a> -->
						</div>
						<!-- 배송 추가 정보 -->
						<jsp:include page="/WEB-INF/view/goods/includeNew/includeDeliveryInfo.jsp" />
					</div>
				</section>
			</div>
			<c:if test="${empty session.bizNo}">
				<div class="btn-area" style="padding-bottom:30px;">
					<%--<a href="javascript:void(0);" class="btn round" onclick="goGoodsDetail('${goods.goodsId}')">상품정보 자세히 보기<span class="arrow"></span></a>--%>
					<a href="#" class="btn round" onclick="fnGoGoodsDetail('${goodsId}'); return false;">상품정보 자세히 보기<span class="arrow"></span></a>
				</div>
			</c:if>
		</div>
		<div class="product-buy none">
			<jsp:include page="/WEB-INF/view/goods/includeNew/includeGoodsOrdpanDetail.jsp" />
		</div>
		<jsp:include page="/WEB-INF/view/goods/includeNew/includeGoodsOrdpanCartNavs.jsp" />
		<jsp:include page="/WEB-INF/view/goods/include/includeGoodsCommentImgPop.jsp" />
	</div>
<!-- //drop pop -->
