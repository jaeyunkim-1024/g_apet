<tiles:insertDefinition name="default">
	<tiles:putAttribute name="script.include" value="script.member"/>
    <tiles:putAttribute name="script.inline">
        <script type="text/javascript">
        
            function inviteJoin(){
            	if(loginCheck())  $("#inviteForm").submit();
            }
            
            function inviteSnsJoin(snsCd){
            	if(loginCheck()) snsLogin(snsCd);
            }
            
            function loginCheck(){
            	let pathUrl = window.location.href;
     	    	pathUrl = pathUrl.split("?")[1];
            	if("${session.mbrNo}" > 0){
            		messager.confirm({txt : "로그아웃 하시겠습니까?", ycb:function(){ location.href="/logout?returnUrl=welcome?"+pathUrl}})
            		return false;
            	}
            	return true;
            }
        </script>
    </tiles:putAttribute>
    <tiles:putAttribute name="content">
    
    	<c:choose>
	    	<c:when test="${view.deviceGb == 'PC' }">
				<jsp:include  page="/WEB-INF/tiles/include/header.jsp" />
	    	</c:when>
	    	<c:otherwise>
		    	<header class="header pc cu mode8 show" data-header="set10">
					<div class="hdr">
						<div class="inr">
							<div class="hdt">
								<!-- -->
								<!-- mobile -->
								<button class="mo-header-backNtn" onclick="location.href='/'">뒤로</button>
								<div class="mo-heade-tit"><span class="tit"></span></div>
								<button class="mo-header-close" onclick="location.href='/'"></button>
							</div>
						</div>
					</div>
				</header>
	    	</c:otherwise>
    	</c:choose>
    	
		
        <form id="inviteForm" method="${method}" action="/join/indexTerms" style="display:none;">
            <input type="text" name="rcomCode" value="${frdRcomKey}" />
            <input type="text" name="returnUrl" value="${returnUrl}" />
        </form>
        <main class="container page login srch" id="container">

			<div class="inr">
				<!-- 본문 -->
				<div class="contents" id="contents">
					<!-- PC 타이틀 모바일에서 제거  -->
					<!-- <div class="pc-tit">
						<h2>로그인</h2>
					</div> -->
					<!-- // PC 타이틀 모바일에서 제거  -->
					
					<div class="fake-pop t02">
						<div class="pct">
						<!-- 친구초대 회원가입안내 -->
							<div class="about-join">
								<div class="pic t02">💌</div>
								<div class="txt">
									지금 회원가입하시면<br>
									<span>5,000원 할인 쿠폰</span>을 드려요!
								</div>
								
							</div>
							<!-- // 친구초대 회원가입안내 -->
						</div>
					
						<div class="pbt pull">
							<div class="btnSet">
								<a href="javascript:inviteJoin();" class="btn lg a" data-content="" data-url="/join/indexTerms" >어바웃펫 회원가입하기</a>
							</div>
							<a href="javascript:location.href='/indexLogin';" class="text-link" data-content="" data-url="/indexLogin" >기존회원이세요?</a>
						</div>
						
						<dl class="sns-set mt50">
							<dt>간편 로그인</dt>
							<dd>
								<span><a class="naver" href="javascript:inviteSnsJoin(10);" data-content="" data-url="" >네이버</a></span>
								<span><a class="kakao" href="javascript:inviteSnsJoin(20);" data-content="" data-url="" >카카오톡</a></span>
								<span><a class="google" href="javascript:inviteSnsJoin(30);" data-content="" data-url="" >구글</a></span>
								<span><a class="apple" href="javascript:inviteSnsJoin(40);" data-content="" data-url="" >애플</a></span>
							</dd>
						</dl>
					</div>
				</div>

			</div>
		</main>

    </tiles:putAttribute>
</tiles:insertDefinition>