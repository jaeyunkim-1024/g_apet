<script type="text/javascript">
	//개발자도구에서의 console.[log, debug] control	
	logger("<spring:eval expression="@bizConfig['envmt.gb']" />");
	
	console.log("session.mbrNo",'${session.mbrNo}');
	console.log("FrontWebConstants.NO_MEMBER_NO",'${frontConstants.NO_MEMBER_NO}');
	console.log("FrontWebConstants.NO_MEMBER_NO",'${ session.mbrNo eq frontConstants.NO_MEMBER_NO}');
	console.log("FrontWebConstants.MBR_GRD_10",'${frontConstants.MBR_GRD_10}');
	console.log("view.mbrGrdCd",'${view.mbrGrdCd}');
	
	// 사이즈 변경에따른 header show/hide
// 	$(window).resize(function(){
// 		if(mobileYn()){
// 			$("#header_mo").show();
// 	       	$("#header_pc").hide();
// 	    } else {
// 	    	$("#header_pc").show();
// 	    	$("#header_mo").hide();
// 	    }
// 	}).resize();
	
	$(document).ready(function(){
		checkURL();
		<c:forEach var="popup" items="${popupList}" varStatus="status">
		var params = {
				popupNo : "${popup.popupNo}",
				width : "${popup.wdtSz}",
				height: "${popup.heitSz}",
				left : "${popup.pstLeft}",
				top : "${popup.pstTop}",
				callBackFnc : ""
		}
		cookiedata = document.cookie;
		
		if(cookiedata.indexOf("popDispClsfNo<c:out value='${popup.popupNo}'/>=done") < 0){
			pop.dispClsfPopup(params);
			
			$("#popDispClsfNo<c:out value='${popup.popupNo}'/>").prev("div.ui-dialog-titlebar").parent().show();
			$("#popDispClsfNo<c:out value='${popup.popupNo}'/>").show();
		}else{
			$("#popDispClsfNo<c:out value='${popup.popupNo}'/>").prev("div.ui-dialog-titlebar").parent().hide();
		}

		</c:forEach>
	});
	
	function setCookie( name, value, expirehours ) {
		var todayDate = new Date();
		todayDate.setHours( todayDate.getHours() + expirehours );
		document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";"
	}
	
	// 하루동안 열지않기
	function todaycloseWin(pNo) {
		setCookie("#popDispClsfNo"+pNo, "done" , 24 );
	}
	
	$(function() {
		// 검색조건 Enter Key 이벤트
		/* $("#top-search").keypress(function() {
			if ( window.event.keyCode == 13 ) {
				searchHeader();
			}
		}); */
		
		$('.category_wrap').on('show', function(e, param1) {
			console.log("category show = " + param1);
			
			if (param1 == "cate") {
				$('.right_btn_wrap').hide();
				
				var options = {
					url : "/brand/listStyleBrand",
					done : function(data) {
						var html = "";
						for (var i=0; i<data.brandStyleList.length; i++) {
							var brand = data.brandStyleList[i];
							html += '<li><a href="/brand/indexBrandDetail?bndNo=' + brand.bndNo + '">' + brand.bndNm + '</a></li>';
						}
						$('.dep_box.style ul').html(html);
					}
				};
				
				ajax.call(options);
			}

		});
		
		$('.category_wrap').on('hide', function(e, param1) {
			console.log("category hide");
			
			if (param1 == "cate")
				$('.right_btn_wrap').show();
		});
	});	
	
	// 검색
	/* function searchHeader(){
		var searchWord = $("#top-search").val();
		if(searchWord == ""){ 
			alert("<spring:message code='front.web.view.search.searchGoods.msg.check' />");
			return;
		}
		jQuery("<form action=\"/search/indexSearch\" method=\"post\"><input type=\"hidden\" name=\"srchWord\" value=\""+searchWord+"\" /></form>").appendTo('body').submit();
	} */
	
	// 메뉴 활성화	
	function checkURL() {
		var menu = $('.top_area .nav').children("li");
		
		for (var i=0; i<menu.length; i++) {
			var url = $(menu[i]).find("a").attr("href");
			if (url == location.pathname)
				$(menu[i]).addClass("active");
		}
	}
	
	// 위시리스트 추가 - 상품상세제외
	function insertWish(obj, goodsId){
		
		var options = {
			url : "<spring:url value='/goods/insertWish' />",
			data : {goodsId : goodsId},
			done : function(data){
				
				if(data.actGubun =='add'){
					$(obj).addClass("click");
					
					if (confirm("위시리스트에 담겼습니다.\n확인하시겠습니까?"))
						location.href = "/mypage/interest/indexWishList";
				}else if(data.actGubun =='remove'){
					$(obj).removeClass("click");
					alert("위시리스트에서 삭제되었습니다.");
				}else{
					alert('위시리스트 등록 또는 삭제에 실패하였습니다.');
				}
			}
		};
		ajax.call(options);
	}
	
	function insertWishS(obj, goodsId, query) {
		var options = {
			url : "/goods/insertWish",
			data : {goodsId : goodsId, search : "Y", returnUrl : document.URL+"?searchQuery="+query },
			done : function(data) {
				$(obj).addClass("click");
			}
		};
		ajax.call(options);
	}

	function goEvent(){
		var id = $(".tmenu .list .active").prop("id");
		var url = "";
		var eventGb2Cd = "${frontConstants.EVENT_GB2_CD_10}";
		//펫샵
		if(id =="liTag_10"){
			eventGb2Cd = "${frontConstants.EVENT_GB2_CD_40}";
		}
		//펫tv
		else if(id =="liTag_20"){
			eventGb2Cd = "${frontConstants.EVENT_GB2_CD_20}";
		}
		//펫로그
		else if(id =="liTag_30"){
			eventGb2Cd = "${frontConstants.EVENT_GB2_CD_30}";
		}

		window.location.href = "/event/main";
	}
	
	$(function () {
		// 검색 메뉴
		$(".searchMenuContent").hide();
		$(".searchMenuContent:first").show();

		$("ul.searchMenu li").click(function () {
			$("ul.searchMenu li").removeClass("active");
			$(this).addClass("active");
			$(".searchMenuContent").hide()
			var activeTab = $(this).attr("rel");
			$("#" + activeTab).fadeIn()
		});
		
		//검색 : 카테고리
		$(".categorySub").hide();
		$(".categorySub:first").show();

		$("ul.searchCate li").click(function () {
			$("ul.searchCate li").removeClass("active");
			$(this).addClass("active");
			$(".categorySub").hide()
			var activeTab = $(this).attr("rel");
			$("#" + activeTab).fadeIn()
		});

		//검색 : 브랜드
		$(".brandSub").hide();
		$(".brandSub:first").show();

		$("ul.searchBrand li").click(function () {
			$("ul.searchBrand li").removeClass("active");
			$(this).addClass("active");
			$(".brandSub").hide()
			var activeTab = $(this).attr("rel");
			$("#" + activeTab).fadeIn()
		});

		//검색어 : 최근/인기검색어
		$(".searchKindSub").hide();
		$(".searchKindSub:first").show();

		$("ul.searchKind li").click(function () {
			$("ul.searchKind li").removeClass("active");
			$(this).addClass("active");
			$(".searchKindSub").hide()
			var activeTab = $(this).attr("rel");
			$("#" + activeTab).fadeIn()
		});
	});

</script>

<!-- header mo-->	
<header class="header mo" id="header_mo">
	<div class="hdr">
		<div class="inr">
			<div class="hdt">
				<!-- <h1 class="logo tv"><a class="bt" href="javascript:;">AboutPet &gt; TV</a></h1> -->
				<!-- <h1 class="logo log"><a class="bt" href="javascript:;">AboutPet &gt; 로그</a></h1> -->
				<h1 class="logo shop"><a class="bt" href="javascript:;">AboutPet &gt; <spring:message code='front.web.view.new.menu.store'/></a></h1> <!-- APET-1250 210728 kjh02  -->
				<nav class="menushop">
					<button type="button" class="bt sp"><span class="t">강아지</span></button>
					<div class="list">
						<ul class="menu">
							<li class="active"><a class="bt" href="javascript:;"><b class="t">강아지</b></a></li>
							<li><a class="bt" href="javascript:;"><b class="t">고양이</b></a></li>
							<li><a class="bt" href="javascript:;"><b class="t">관상어</b></a></li>
							<li><a class="bt" href="javascript:;"><b class="t">소동물</b></a></li>
						</ul>
					</div>
				</nav>
				<!-- <button class="back" type="button">뒤로가기</button> -->
				<!-- <h2 class="subtit">타이틀</h2> -->
			</div>
			<div class="mdt">
				<button class="bt schs" type="button">검색</button>
				<button class="bt cart" type="button">장바구니</button>
				<button class="bt alim" type="button">알림</button>
				<button class="bt gnbs btnGnb" type="button">메뉴</button>
				<!-- <a href="javascript:;" class="golist">시리즈목록</a> -->
			</div>
		</div>
	</div>
</header>
<!--// header mo-->	