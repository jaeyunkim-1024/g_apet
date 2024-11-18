<c:if test="${view.deviceGb eq frontConstants.DEVICE_GB_20}">
<script type="text/javascript">

	$(document).ready(function () {
		var cookieValue = $.cookie("notMobileApp");
		var thisPagePath = "${requestScope['javax.servlet.forward.servlet_path']}";	
	
		/*
		
		$(".dim_back").click(function(){
			$(".dim_back").remove();
			ui.commentBox.close($(".commentBoxAp.app .btn.txt-btn"))
		});
		
		$(".commentBoxAp.app").click(function(e){
			e.stopPropagation();
		});		
		*/
	
		if(cookieValue != "N"){
			if(thisPagePath != "/log/popupPetLogInsertLoc" && thisPagePath != "/goods/indexGoodsDetail" && thisPagePath != "/event/indexExhibitionZone" &&
				thisPagePath != "/log/popupPetLogReplyList"	
			){// path 예외처리 
				ui.lock.using(true);
				ui.commentBox.open(".commentBoxAp.logpet");/* 팝업 오픈 */
				/* // 2021.03.11 : 만들기영역 swiper 추가 */
				var tagSwiper = new Swiper('.tag .swiper-container', {
		            slidesPerView: "auto",
					watchOverflow:true,
					freeMode: true,
				});
				$(".commentBoxAp.app").before('<div class="dim_back" style="position:fixed; top:0; left:0; z-index:305; width:100%; height:100%; background:rgba(0,0,0,0.5); touch-action: none !important;"></div>');
			}
		}
		
	});
	
	function okMobileApp(){
		$.cookie("notMobileApp", "Y", {path:'/'});
		if("${view.deviceGb}" != "${frontConstants.DEVICE_GB_30}"){
			/*
				if("${view.os}"=="${frontConstants.DEVICE_TYPE_20}"){ //IOS
					location.href = "https://BXPD5Og4xEKwhWif2aXoog.adtouch.adbrix.io/api/v1/click/q0Tv42H19kWYmqRJzTFsyw?m_adid=__device_id__&cb_5=__callback_param__&cb_1=__AID__%5F__CID__%5F__CAMPAIGN_ID__&cb_2=__UA__%5F__UA1__&cb_3=__IDFA__%5F__OS__%5F__GAID__&cb_4=__TS__%5F__IP__%5F__SL__";
				}else{
					//location.href = "Intent://splash#Intent;scheme=aboutpetlink;package=com.petsbe.android.petsbemall;end";
					location.href = "https://BXPD5Og4xEKwhWif2aXoog.adtouch.adbrix.io/api/v1/click/kMT9ioBptEGz51TtzV712A";
				}
			*/
					location.href = "https://BXPD5Og4xEKwhWif2aXoog.adtouch.adbrix.io/api/v1/click/xPWhuHQHn0S3KoW83DVLAg";
			
		}
	}
	
	function notMobileApp(){
		$.cookie("notMobileApp", "N", {path:'/'});
		
	}
</script>
	<!-- both popup -->
	<!-- 
		data-priceh : 처음 오픈 시 높이
		data-min : 최소 사이즈
		data-max : 최대 사이즈
		data-close / data-data-autoCloseUp : 닫을 시 화면에 사라지지 않게 하는 옵션
		data-autoOpen : 드래그 종료 시 자동 닫기 열기 옵션
	-->
	
	<div class="commentBoxAp logpet up app" data-autoCloseUp="true" data-close="true" data-min="20px" data-max="252px" data-autoOpen="true" data-priceh="252px" style="z-index:310;"><!-- data-priceh : 오픈 시 올라가는 높이 -->
		<div class="head bnone ">
			<div class="con">
			</div>
		</div>
		<div class="con">
			<div class="box full">
				<div class="logo-box">
					<img src="../../_images/common/image-appicon-popup@2x.png" alt="">
					<p class="txt">
						어바웃펫 앱 설치하고 <br>
						다양한 혜택을 받아보세요!
					</p>
						
				</div>
				<!-- content -->
				<p><a href="javascript:okMobileApp();" class="btn lg a">어바웃 펫 앱으로 보기</a></p>
				<p><button type="button" class="btn txt-btn" onclick="ui.commentBox.close(this);$('.dim_back').remove();notMobileApp();ui.lock.using(false);">모바일웹으로 볼게요</button></p>
				<!-- // content -->
			</div>
		</div>
	</div>
</c:if>