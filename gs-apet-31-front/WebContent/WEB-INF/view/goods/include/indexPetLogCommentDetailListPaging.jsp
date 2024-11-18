<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<c:forEach items="${petLogReView}" var="petLog" varStatus="status">
	<li class="swiper-slide" id="petLogDetails_${petLog.petLogNo}" name="petLogDetail" data-idx="${status.index }" data-pet-log-no="${petLog.petLogNo }">
		<form id ="updateForm${status.index }">
			<input type="hidden" name="goodsId" value="${petLog.goodsId}">
			<input type="hidden" name="ordNo" value="${petLog.ordNo}">
			<input type="hidden" name="ordDtlSeq" value="${petLog.ordDtlSeq}">
			<input type="hidden" name="goodsEstmTp" value="${petLog.goodsEstmTp}">
			<input type="hidden" name="goodsEstmNo" value="${petLog.goodsEstmNo}">
			<input type="hidden" name="petLogNo" value="${petLog.petLogNo}">
		</form>
		<div class="box">
			<div class="rhdt">
				<div class="tinfo">
					<span class="pic"><img src="${frame:imagePath(petLog.prflImg)}" alt="사진" class="img" onerror="this.src='../../_images/_temp/temp_logDogImg02.png'"></span>
					<div class="def">
						<em class="dd ids">${petLog.nickNm}</em> 
						<em class="dd date"><frame:timestamp date="${petLog.sysRegDtm}" dType="H" /></em> 
						<c:if test ="${petLog.bestYn eq 'Y'}"><em class="ds me">BEST</em></c:if>
							<nav class="uidropmu dmenu only_down">
								<c:if test ="${petLog.mbrNo ne session.mbrNo || view.deviceGb ne frontConstants.DEVICE_GB_10}">
									<button type="button" class="bt st gb" name="menuBtn">메뉴열기</button>
								</c:if>
								<div class="list">
									<ul class="menu">
										<c:if test ="${petLog.mbrNo eq session.mbrNo }">
											<li><button type="button" class="bt" onclick="petLogUpdate(${petLog.petLogNo} , ${status.index } , ${petLog.mbrNo });">수정</button></li>
											<li><button type="button" class="bt" onclick="petLogDel(${status.index});">삭제</button></li>
										</c:if>
										<c:if test ="${petLog.mbrNo ne session.mbrNo }">
											<li><button type="button" class="bt" onclick="layerPetLogReport(${petLog.petLogNo} , 'Y' , this);" data-pet-log-no="${petLog.petLogNo }" data-rpt-yn="${petLog.rptYn }">신고</button></li>	
										</c:if>
									</ul>
								</div>
							</nav>
					</div>
					<div class="spec"><em class="b">${petLog.petNm}<span>(${petLog.petGdNm })</span></em>
						<c:choose>
							<c:when test ="${petLog.age ne '' and petLog.age ne null }"> 
								<em class="b">${petLog.age}살 </em>
							</c:when>
							<c:otherwise>
								<em class="b">${petLog.month}개월 </em>
							</c:otherwise>
						</c:choose>
						<c:if test ="${petLog.weight ne '' and petLog.weight ne null}">
							<em class="b">${petLog.weight}kg</em>
						</c:if>
					</div>
				</div>
				<div class="hpset">
					<em class="htxt">도움이돼요</em>
					<button type="button" data-likeyn="${petLog.likeYn }" class="bt hlp on<c:if test="${petLog.likeYn eq 'Y' }"> me</c:if>" onclick="insertPetLogLike('${petLog.petLogNo}' , this)"><i class="n">${petLog.likeCnt}</i><b class="t">도움</b></button>
				</div>
			</div>
			<div class="rcdt">
				<div class="stpnt starpoint">
								<span class='stars sm p_${fn:replace(((petLog.estmScore/2)+""), ".", "_") }'></span>
				</div>
				<ul class="satis">
	 				<c:forEach items="${petLog.petLogGoodsList}" var="goods" varStatus="item">
						<c:choose>
							<c:when test="${item.index eq 0}">
								<li><span class="dt">맛 만족</span> <span class="dd">${goods.itemContent}</span></li>
							</c:when>
							<c:when test="${item.index eq 1}">
								<li><span class="dt">유통기한</span> <span class="dd">${goods.itemContent}</span></li>
							</c:when>
							<c:otherwise>
								<li><span class="dt">가성비</span> <span class="dd">${goods.itemContent}</span></li>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</ul>
				<div class="opts">
					<a href="/goods/indexGoodsDetail?goodsId=${petLog.goodsId}" class="opts" data-content='${petLog.goodsId}' data-url="/goods/indexGoodsDetail?goodsId=${petLog.goodsId}">${petLog.optName }</a>
				</div>
				<div class="rvPicSld">
					<section class="logRvSet" style="padding-top: 0px;">
						<c:choose>
						<c:when test="${petLog.vdPath ne null and petLog.vdPath ne ''}">
							<div class="picture mov"><!-- 영상일경우 mov -->
								<div class="vthumbs" data-video_id="${petLog.vdPath}" type="video_thumb_360p" style="height: 100%" lazy="scroll" uid="${petLog.mbrNo}|${session.mbrNo}" ></div>
							</div>
						</c:when>
						<c:otherwise>
							<section class="logContentBox review">
								<div class="lcbPicture sw">
									<div class="swiper-container logMain">
										<c:set var="imgPathList" value="${fn:split(petLog.imgPathAll,'[|]')}" />
										<c:if test ="${fn:length(imgPathList) > 1 }">
											<div class="swiper-pagination"></div>
										</c:if>
										<ul class="swiper-wrapper slide"> 
											<c:choose>
												<c:when test="${fn:length(imgPathList) > 1 }">
													<c:forEach items="${imgPathList}" var="imgPath">
														<c:set var="optImage"
															value="${frame:optImagePath(imgPath, view.deviceGb eq frontConstants.DEVICE_GB_10 ? frontConstants.IMG_OPT_QRY_650 : frontConstants.IMG_OPT_QRY_640)}" />
														<c:if test="${fn:indexOf(imgPath, '.gif') > -1 }">
															<c:set var="optImage"
															value="${frame:imagePath(imgPath)}" />
														</c:if>
														<li class="swiper-slide">
															<div class="inr">
																<img name="lazeImg" data-src="${optImage}">
															</div>
														</li>
													</c:forEach>
												</c:when>
												<c:otherwise>
														<c:set var="optImage" value="${frame:optImagePath(imgPathList[0], view.deviceGb eq frontConstants.DEVICE_GB_10 ? frontConstants.IMG_OPT_QRY_650 : frontConstants.IMG_OPT_QRY_640)}" />
														<c:if test="${fn:indexOf(imgPathList[0], '.gif') > -1 }">
															<c:set var="optImage" value="${frame:imagePath(imgPathList[0])}" />
														</c:if>
														<li class="swiper-slide">
															<div class="inr">
																<img name="lazeImg" data-src="${optImage}">
															</div>
														</li>
												</c:otherwise>
											</c:choose>
										</ul>
										<div class="remote-area">
											<button class="swiper-button-next" type="button"></button>
											<button class="swiper-button-prev" type="button"></button>
										</div> 															
									</div>
								</div>
							</c:otherwise>
						</c:choose>
						<c:set var="dscrt" value="${petLogReView[status.index].dscrt}" />
						<c:set var="pstNm" value="${petLogReView[status.index].pstNm}" />
						<c:set var="nickNm" value="${petLogReView[status.index].nickNm}" />
						<c:set var="sysRegDtm" value="${petLogReView[status.index].sysRegDtm}" />
						<div class="lcbWebRconBox">
							<!-- span class="iconOm_arr"></span -->
							<div class="contxtWrap">
								<div class="lcbConTxt_content" name="logDscrt">${dscrt}</div>
								<!-- more btn -->
								<button class="btn_logMain_more onWeb_b"><spring:message code='front.web.view.common.seemore.title' /></button>
								<!-- // more btn -->
							</div>
							<!-- // content txt -->
						</div>
					</section>
				</div>
				<c:if test ="${view.deviceGb eq frontConstants.DEVICE_GB_10 }">
					<div class="msgs" name="logDscrt" style="white-space: pre-wrap;">${petLog.dscrt}</div>
				</c:if>
			</div>
		</div>
	</li>
</c:forEach>