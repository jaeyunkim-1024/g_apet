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

<!-- header pc-->	
<header class="header pc" id="header_pc">
	<div class="hdr">
		<div class="inr">
			<div class="tdt">
				<ul class="menu">					
					<c:if test="${session.mbrNo ne frontConstants.NO_MEMBER_NO}">
					    <!-- <li>
					    	<a href="/logout">로그아웃</a>
					    </li> -->
					</c:if>
					<c:if test="${session.mbrNo eq frontConstants.NO_MEMBER_NO}">
		                <li><a href="/indexLogin" class="bt">로그인</a></li>
		                <li><a href="/join/indexCertification" class="bt">회원가입</a></li>
		                <li><a href="javascript:;" class="bt">로그인/회원가입</a></li>
					</c:if>
					<li><a href="javascript:goEvent();" class="bt">이벤트</a></li>
					<li><a href="javascript:;" class="bt">고객센터</a></li>
				</ul>
			</div>
			<div class="hdt">
				<button class="btnGnb" type="button">메뉴</button>
				<h1 class="logo"><a class="bt" href="javascript:;">AboutPet</a></h1>
				<nav class="tmenu">
					<ul class="list">
						<li class="${view.seoSvcGbCd == frontConstants.SEO_SVC_GB_CD_20 ? 'active' : '' }"><a href="/tv/home/" class="bt">펫TV</a></li>
						<li class="${view.seoSvcGbCd == frontConstants.SEO_SVC_GB_CD_30 ? 'active' : '' }"><a href="/log/home/" class="bt">펫로그</a></li>
						<li class="${view.seoSvcGbCd == frontConstants.SEO_SVC_GB_CD_10 ? 'active' : '' }"><a href="/shop/home" class="bt">펫샵</a></li>
						<li><a href="javascript:;" class="bt">MY</a></li>
					</ul>
				</nav>
			</div>
			<div class="cdt">
				<div class="schs">
					<div class="form">
						<input type="text" class="kwd" placeholder="어바웃펫이 만든 깐깐사료 30% 할인">
						<button type="button" class="btnSch">검색</button>
					</div>
				</div>
				<div class="menu">
					<button class="bt alim" type="button">알림</button>
					<button class="bt cart" type="button">장바구니</button>
				</div>
			</div>
		</div>
	</div>
</header>
<!--// header pc-->