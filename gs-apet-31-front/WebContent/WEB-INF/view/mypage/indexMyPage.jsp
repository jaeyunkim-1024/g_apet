<tiles:insertDefinition name="mypage">
<tiles:putAttribute name="script.include" value="script.member"/>
<tiles:putAttribute name="script.inline">
<jsp:include page="/WEB-INF/tiles/include/js/gsr.jsp" />
<script type="text/javascript">

	$(document).ready(function(){
		if("${session.gsptNo}" == '' || "${gsptStateCd}" != "${frontConstants.GSPT_STATE_10}" || "${gsptUseYn}" != "${frontConstants.USE_YN_Y}" ){
			$("#gsPointTit").after( '<a href="javascript:fnGetGsrPoint();" id="searchPoint" class="bt point">포인트조회</a>');
		}else{
			$("#gsPointTit").after('<em class="blue" id="gsPoint">'+fnComma('${gsPoint}')+'</em>P');
		}
	}); // End Ready

	//GSR 포인트 인증
	function fnGetGsrPoint(){
	   var config = {
	        callBack : function(){
	            var option = {
						url :  "/gsr/getGsrMemberPoint"
					,	done : function(result){
						var separateNotiMsg = result.separateNotiMsg;
						//분리보관 해제 시
						if(separateNotiMsg && separateNotiMsg != ''){
							//분리보관 해제 noti
							ui.alert("<div id='alertContentDiv'>"+separateNotiMsg+"</div>",{
								ycb:function(){
									var gsrPoint = result.totRestPt === '' || result.totRestPt == null ? '0' : result.totRestPt;
									$("#searchPoint").hide();
									$("#gsPointTit").after('<em class="blue" id="gsPoint">'+fnComma(gsrPoint)+'</em>P');
									$(".popAlert").remove();
								}
								,   ybt:"확인"
							});
						}else{
							var gsrPoint = result.totRestPt === '' || result.totRestPt == null ? '0' : result.totRestPt;
							$("#searchPoint").hide();
							$("#gsPointTit").after('<em class="blue" id="gsPoint">'+fnComma(gsrPoint)+'</em>P');
						}
	               }
	            };
	            ajax.call(option);
	      }
	      ,  okCertCallBack : function(data){
	            var option = {
					  url :  "/gsr/getGsrMemberPoint"
	               ,  data : data
	               ,  done : function(result){
						var gsrPoint = result.totRestPt === '' || result.totRestPt == null ? '0' : result.totRestPt;
						$("#searchPoint").hide();
						$("#gsPointTit").after('<em class="blue" id="gsPoint">'+fnComma(gsrPoint)+'</em>P');
	               }
	            };
	            ajax.call(option);
	      }
	   };
	   gk.open(config);
	}
	
	function fncGoPetList(){
		//location.href="/my/pet/myPetListView";
		storageHist.goBack("/my/pet/myPetListView");
	}
	
	function fncGoPetInsert(){
		//location.href="/my/pet/petInsertView";
		storageHist.goBack("/my/pet/petInsertView");
	}
	
	function fncGoPetView(petNo){
		var form = $("<form></form>");
		form.attr("name" , "petDeatilForm");
		form.attr("method" , "post");
		form.attr("action" , "/my/pet/myPetView");
		form.append($("<input/>", {type: 'hidden', name:'petNo', value:petNo }));
		
		form.appendTo("body");
		form.submit();
// 		storageHist.goBack("/my/pet/myPetView?petNo="+petNo);
	}
	
	/*
	 * 주문상세 페이지 이동
	 */
	/* function goOrderDetail(ordNo){
		var inputs = "<input type=\"hidden\" name=\"ordNo\" value=\""+ordNo+"\"/>";
		jQuery("<form action=\"/mypage/order/indexDeliveryDetail\" method=\"get\">"+inputs+"</form>").appendTo('body').submit();
	} */
</script>
</tiles:putAttribute>
<tiles:putAttribute name="content">

		<%-- <jsp:include  page="/WEB-INF/tiles/include/header.jsp" />
		<jsp:include  page="/WEB-INF/tiles/include/gnb.jsp" /> --%>
		<%-- <c:if test="${view.deviceGb eq frontConstants.DEVICE_GB_10 }">
			<jsp:include page="/WEB-INF/tiles/include/lnb_my.jsp" />
			<jsp:include  page="/WEB-INF/tiles/include/menubar.jsp" />
		</c:if> --%>
		<!-- 바디 - 여기위로 템플릿 -->
		<main class="container lnb page my home" id="container">
			
			<div class="inr">			

				<!-- 본문 -->
				<div class="contents" id="contents">

					<!-- 회원정보  -->
					<c:import url="/WEB-INF/view/mypage/include/memberInfoBanner.jsp" ></c:import>

					<section class="myinfo">
						<!-- 마이펫관리 -->
						<c:import url="/WEB-INF/view/mypage/include/myPetInfoBanner.jsp"></c:import> 
						
						<dl class="zzim">
							<dt>
								<span>마이 찜리스트</span>
							</dt>
							<dd>
								<a href="/mypage/myWishList" class="allmore" data-url="/mypage/myWishList" data-content="${session.mbrNo }">전체보기</a>
								<ul class="zzim-list">
									<li>
										<b><spring:message code='front.web.view.new.menu.tv'/></b>  <!-- APET-1250 210728 kjh02  -->
										<a href="/mypage/tv/myWishList"  data-url="/mypage/tv/myWishList" data-content="${session.mbrNo }">${fn:length(myWishListTv)}</a>
									</li>
									<li>
										<b><spring:message code='front.web.view.new.menu.log'/></b>  <!-- APET-1250 210728 kjh02  -->
										<a href="/mypage/log/myWishList"  data-url="/mypage/log/myWishList" data-content="${session.mbrNo }">${fn:length(myWishListLog)}</a>
									</li>
									<li>
										<b><spring:message code='front.web.view.new.menu.store'/></b>  <!-- APET-1250 210728 kjh02  -->
										<a href="/mypage/shop/myWishList" data-url="/mypage/shop/myWishList" data-content="${session.mbrNo }">${fn:length(myWishListGoods)}</a>
									</li>
								</ul>
							</dd>
						</dl>
						
						<!-- 최근 본 영상  -->
						<c:import url="/WEB-INF/view/mypage/include/recentlyWatchVdoBanner.jsp"></c:import> 
						<!-- 나의 쇼핑 정보 -->
						<c:import url="/WEB-INF/view/mypage/include/myShoppingInfoBanner.jsp"></c:import> 
					</section>
				</div>

			</div>
		</main>
		
		<!-- 플로팅 영역 -->
		<c:choose>
			<c:when test="${view.deviceGb  eq 'PC'}">
			<jsp:include page="/WEB-INF/tiles/include/floating.jsp">
			       <jsp:param name="floating" value="" />
			</jsp:include>
			</c:when>
			<c:otherwise>
			<jsp:include page="/WEB-INF/tiles/include/floating.jsp">
			       <jsp:param name="floating" value="talk" />
			</jsp:include>
			</c:otherwise>
		</c:choose>
<script>

	// Swiper 최근
	var swiperRecent = new Swiper('.recent .swiper-container', {
	    slidesPerView: "auto",
	    spaceBetween: 18,  
	    navigation: {
	        nextEl: '.recent .swiper-button-next',
	        prevEl: '.recent .swiper-button-prev',
	    }
	});
	
	// Swiper 최근
	var swiperFit = new Swiper('.zzim .swiper-container', {
	    slidesPerView: "auto",
	    spaceBetween: 7, 
	    navigation: {
	        nextEl: '.zzim .swiper-button-next',
	        prevEl: '.zzim .swiper-button-prev',
	    }
	});
	
	// progress
	var wTimer = null;
	if($(".circlePie").length && $(".recent").css("display") !== "none"){
		var price = $(".circlePie").width();
	    $(document).ready(function(){
	        if(wTimer !== null) {clearTimeout(wTimer);}
	        wTimer = setTimeout(function(){
	            price = $(".circlePie").width();
	            createPie();
	        },1000);
	    });
		//createPie();
		function createPie(p){
			$(".circlePie").each(function(i,n){
				var can = document.createElement("canvas");
				var ctx = can.getContext("2d");
				var p = ($(n).data("p") !== undefined)?$(n).data("p"):100;
				can.width = price;
				can.height = price;
				ctx.beginPath();
				//ctx.fillStyle = "black";
				ctx.moveTo((price / 2),(price / 2));
				ctx.translate((price / 2),(price / 2));
				//ctx.arc(0,0,60,Math.PI * 0, Math.PI * 0.1,false);
				ctx.fill();
				ctx.font = 'bold 20px serif';
				$(n).html("").append(can);
				drowC(p,can,ctx);
			});
	
			function drowC(angle,can,ctx){
				var n = 0;
				var max = 30;
				var angle = (angle * 3.6) * (2 / 36);
				var add = (angle / max);
				var timer = setInterval(function(){
					n += add;
					if(n >= angle) n = angle;
					ctx.translate(-10,-10);
					ctx.clearRect(0,0,can.width,can.height);
					ctx.translate(10,10);
					ctx.rotate(Math.PI * -0.5);
					ctx.beginPath();
					ctx.fillStyle="#669aff";
					ctx.moveTo(0,0);
					ctx.arc(0,0,(price / 2),Math.PI*0,Math.PI*(n * 0.1),false);
					ctx.fill();
					ctx.closePath();
					ctx.beginPath();
					ctx.arc(0,0,((price / 2) - 4),0,Math.PI*2);
					ctx.fillStyle="#ffffff";
					ctx.fill();
					ctx.closePath();
					ctx.textAlign = "center";
					ctx.fillStyle ="#ffffff";
					ctx.rotate(Math.PI * 0.5);
					if(n >= max){
						clearInterval(timer);
					};
				},50)
			};
		};
	};
</script>
</tiles:putAttribute>
</tiles:insertDefinition>
<!-- // 위시리스트 -->