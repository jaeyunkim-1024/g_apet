<c:if test="${not empty view.popLayerEventList }">
<!-- 팝업레이어 A 전체 덮는크기 -->
<script type="text/javascript">
	$(document).ready(function () {
		var thisPagePath = "${requestScope['javax.servlet.forward.servlet_path']}";
		
		if(thisPagePath == "/tv/home/" || thisPagePath == "/shop/home/" || thisPagePath == "/log/home/" ){
			var cookieData = document.cookie;
			
			if("${view.deviceGb eq frontConstants.DEVICE_GB_10}" == "true"){
				if(cookieData.indexOf("popLayerEvent_PC=done") === -1){
					ui.popLayer.open("popLayerEvent");
					//$("#showPopLayerEvent").css("display","block");
				}
			}else if("${view.deviceGb eq frontConstants.DEVICE_GB_20}" == "true"){
				if(cookieData.indexOf("popLayerEvent_MO=done") === -1){
					ui.popLayer.open("popLayerEvent");
					//$("#showPopLayerEvent").css("display","block");
				}
			}else if("${view.deviceGb eq frontConstants.DEVICE_GB_30}" == "true"){
				if(cookieData.indexOf("popLayerEvent_APP=done") === -1){
					ui.popLayer.open("popLayerEvent");
					//$("#showPopLayerEvent").css("display","block");
				}
			}
		}/*else{
			ui.popLayer.close('popLayerEvent');
			//$("#showPopLayerEvent").css("display","none");
		}*/
	});
	
	//링크이동
	function fncGoUrl(url){
		if(url){
			if(url.indexOf("/tv/series/indexTvDetail") > -1 && "${view.deviceGb eq frontConstants.DEVICE_GB_30}" == "true"){
				toNativeData.func = "onNewPage";
				toNativeData.type = "TV";
				toNativeData.url = url;
				
				toNative(toNativeData);
			}else{
				if(url.indexOf("/event/detail") > -1){
					location.href = url+"&returnUrl=${requestScope['javax.servlet.forward.servlet_path']}'";
				}else{
					location.href = url;
				}
			}
		}else{
			return false;
		}
	}
	
	//오늘 하루 보지않기
	function fncTodayClose(){
		if("${view.deviceGb eq frontConstants.DEVICE_GB_10}" == "true"){
			setCookiePopLayerEvent("popLayerEvent_PC", "done", 1);
		}else if("${view.deviceGb eq frontConstants.DEVICE_GB_20}" == "true"){
			setCookiePopLayerEvent("popLayerEvent_MO", "done", 1);
		}else if("${view.deviceGb eq frontConstants.DEVICE_GB_30}" == "true"){
			setCookiePopLayerEvent("popLayerEvent_APP", "done", 1);
		}
		
		ui.popLayer.close('popLayerEvent');
	}
	
	function setCookiePopLayerEvent(name, value, expire){
		var todayDate = new Date();
		//todayDate.setDate( todayDate.getDate() + expire );
		//todayDate.setHours( todayDate.getHours() + expire );
		//document.cookie = escape(name) + "=" + escape( value ) + "; path=/; expires=" + todayDate.toUTCString() + ";"
		
		var newDate = new Date(todayDate.getFullYear(), todayDate.getMonth(), todayDate.getDate(), "23", "59", "59"); //당일 자정으로 셋팅
		document.cookie = escape(name) + "=" + escape( value ) + "; path=/; expires=" + newDate.toUTCString() + ";"
	}
</script>	
<!-- 팝업레이어 A 전체 덮는크기 -->
<article class="popLayer a popEventLayer" id="popLayerEvent">
	<div class="pbd">
		<div class="pct">
			<main class="poptents">
				<div class="swiPopCont">
					<div class="swiper-container">
						<div class="swiper-pagination"></div>
						<ul class="swiper-wrapper slide">
							<c:forEach var="eventList" items="${view.popLayerEventList }" varStatus="index" begin="0" end="4">
								<li class="swiper-slide">
									<div class="inr">
										<a href="#" onclick="fncGoUrl('${eventList.evtpopLinkUrl}'); return false;"><img src="${frame:imagePath(eventList.evtpopImgPath) }" alt=""/></a>
									</div>
								</li>
							</c:forEach>
						</ul>
						<div class="remote-area">
							<button class="swiper-button-next" type="button"></button>
							<button class="swiper-button-prev" type="button"></button>
						</div>
					</div>
				</div>
			</main>
		</div>
		<div class="pbt">
			<div class="bts">
				<button type="button" class="btn bd_n" onclick="fncTodayClose();">오늘 하루 보지않기</button> <!-- bd_n 클래스는 버튼에 보더 없앨 때 사용 -->
				<button type="button" class="btn bd_n d" onclick="ui.popLayer.close('popLayerEvent');">닫기</button>
			</div>
		</div>
	</div>
</article>
<script>
	var len = "${fn:length(view.popLayerEventList)}";
	var booleanLoop = false;
	if(len > 1){
		booleanLoop = true;
	}
	
	var popSwiper = new Swiper(".swiPopCont .swiper-container", {
	    slidesPerView: 1,
	    slidesPerGroup: 1,
	    freeMode: false,
	    //loop: true,
	    loop: booleanLoop,
	    watchOverflow: true,
	    /* APET-1151 2021.07.20 추가함 start */
	    autoplay: {
		   delay: 3000,
		   disableOnInteraction: false, // touch or click 시 autoplay 멈춤현상 수정 2021.07.28 추가함
		 },
	    /* APET-1151 2021.07.20 추가함 end */
	    pagination: {
	      el: ".swiPopCont .swiper-pagination",
	      clickable: true,
	    },
	    navigation: {
	      nextEl: ".swiPopCont .swiper-button-next",
	      prevEl: ".swiPopCont .swiper-button-prev",
	    },
	});
</script>
</c:if>