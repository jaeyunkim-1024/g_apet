<script>	
$(document).ready(function(){
	/* 하단 고정 레이어팝업 모바일경우만 노출 */
	ui.commentBox.open(".commentBoxAp.logpet:not(.app)");
	/* 2021.02.02 : 추가 */
	
	$(".swiper-slide button").not(".none_click").off("click");
	
	
	/* // 2021.03.11 : 만들기영역 swiper 추가 */
	var tagSwiper = new Swiper('.tag .swiper-container', {
        slidesPerView: "auto",
		watchOverflow:true,
		freeMode: true,
	});
	/* 2021.03.11 : 만들기영역 swiper 추가 */


});

// 로그인 사용자의 펫로그로
function goLoginUserPetLog(petLogUrl, mbrNo){
	if( checkLogin() && checkRegPet() ){
		location.href = "${view.stDomain}/log/indexMyPetLog/"+ petLogUrl + "?mbrNo=" + mbrNo;
	}
}
</script>
					<!-- popup 내용 부분입니다. -->
					<!-- both popup -->
 					<div class="commentBoxAp logpet up" data-autoCloseUp="true" data-close="true" data-min="83px" data-max="180px" data-autoOpen="true" data-priceh="180px"><!--data-priceh : 오픈 시 올라가는 높이 -->
						<div class="head bnone">
							<div class="con">
								<div class="tit pic">
									<span class="picWrap">
									<c:set var="prflImg" value="${loginUserInfo.prflImg != null and loginUserInfo.prflImg != '' ? frame:optImagePath(loginUserInfo.prflImg, frontConstants.IMG_OPT_QRY_786) : '../../_images/common/icon-img-profile-default-m@2x.png'}" />
									<img src="${prflImg}" onclick="javascript:goLoginUserPetLog('${loginUserInfo.petLogUrl}','${loginUserInfo.mbrNo}');" alt="dog">
									</span>${bannerText}
								</div>
							</div>
						</div>
						<div class="con">
							<div class="box full">
								<!-- content -->
								<div class="filter-area t1">
									<div class="filter-item">
										<div class="tag">
											<!-- 2021.03.11 : swiper 수정 -->
											<!-- Slides -->
											<div class="swiper-container">
												<div class="swiper-wrapper">										
													<div class="swiper-slide"><button class="active none_click" onclick="goPetLogMake()"> <span class="iconWrap20 iconPlus"></span> 만들기</button></div>
<c:forEach items="${adminRecTagList}" var="tag" varStatus="idx">	
													<div class="swiper-slide"><button onclick="goPetLogMake('<c:out value='${tag}' />');">#<c:out value='${tag}' /></button></div>
</c:forEach>
												</div>
											</div>
											<!-- // Slides -->
											<!-- // 2021.03.11 : swiper 수정 -->
										</div>
									</div>
								</div>
								<!-- // content -->
							</div>
						</div>
					</div>
					<!-- // both popup -->