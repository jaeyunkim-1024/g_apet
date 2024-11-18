<!-- header -->	
<header id="header" class="fixed">		
	<!-- dcg_header -->
	<div class="dcg_header">
		<!-- header_wrap -->
		<div class="header_wrap">				

			<h1><a href="#" title="VECI world"><img src="../_images/mall/common/top_logo.png" alt="VECI mall"></a></h1>
			<!-- search_wrap -->
			<div class="search_wrap">
				<form method="post" id="searchForm" name="searchForm" action="/search_new/search">
					<input type="hidden" id="pageNumber" name="pageNumber" value="1"/>
					<fieldset>
						<legend>통합검색</legend>
						<input type="text" id="top-search" name="searchQuery" value="<c:out value="${searchVo.searchQuery}" />"  onkeypress="javascript:if(event.keyCode == 13) {goSearch(); return false;}" onfocus="dq_setTextbox('0',event);" onmousedown="dq_setTextbox('1',event);" onkeydown="dq_setTextbox('1',event);" autocomplete="off"/>
						<button type="button" id="inputClose" class="close" style="display:none"><span>닫기</span></button>
						<button type="submit" class="search_btn" onclick="goSearch(); return false;">검색</button>
					</fieldset>
					<!-- search_Kind_wrap -->
					<div id="search_kind_wrap" class="search_kind_wrap" value="test" style="display:none;" onmouseover="dq_setMouseon2();" onmouseout="dq_setMouseoff2();">
						<!-- tab: searchKind -->
						<ul class="searchKind">
							<li class="active" rel="searchKind1"><a href="#">최근 검색어</a></li>
							<li rel="searchKind2"><a href="#">인기 검색어</a></li>
						</ul>
						<!-- // tab: searchKind -->
						<!-- tab: searchKindCont -->
						<!-- 최근검색어 -->
						<div id="searchKind1" class="searchKindSub">						
						</div>
						<script type="text/javascript">
						displayCookie("DCGSearch");
						</script>
						
						<!-- 인기검색어 -->
						<div id="searchKind2" class="searchKindSub">
						</div><!--// tab: searchKindCont -->
					</div><!-- // search_Kind_wrap -->
	
					<!-- search_auto_wrap -->
					<div id="dqAuto" class="search_auto_wrap" style="display:none;" onmouseover="dq_setMouseon();" onmouseout="dq_setMouseoff();">
					</div><!-- // search_auto_wrap -->
					<!-- 자동완성 스크립트-->
			       	<script type="text/javascript" src="/_script//dqAutoComplete.js"></script>                
			       	<!-- //자동완성 스크립트-->
		       	
				</form>
			</div><!-- //search_wrap -->				
			<div class="util_menu">				
				<ul class="header_menu_group">
					<li><a href="#">로그인</a></li>
					<li><a href="#">회원가입</a></li>						
					<li><a href="#">주문배송</a></li>
					<li><a href="#">마이페이지</a></li>
					<li><a href="#">고객센터</a></li>
				</ul>
			</div>	
		</div><!-- //header_wrap -->
	</div><!-- //dcg_header -->
	<!-- header_menu -->
	<div class="header_menu">
		<!-- top_area -->
		<div class="top_area">
			<a href="#" title="메뉴열기" class="show_category"><span><em>메뉴열기</em></span></a>
			<ul class="nav">
				<li class="active"><a href="#" title="트랜드"><span>트랜드</span></a></li>
				<li><a href="#" title="스토어"><span>스토어</span></a></li>
				<li><a href="#" title="디자이너"><span>디자이너</span></a></li>
				<li><a href="#" title="브랜드"><span>브랜드</span></a></li>
				<li><a href="#" title="베스트"><span>베스트</span></a></li>
				<li><a href="#" title="이벤트"><span>이벤트</span></a></li>
				<li><a href="#" title="DC 딜"><span>DC 딜</span></a></li>
			</ul>
			<a href="#" class="cart_btn" title="장바구니" ><span>장바구니</span><em class="cart_num">99</em></a>				
		</div><!-- //top_area -->
	</div><!--// header_menu -->
</header> 
<!--// header -->	
