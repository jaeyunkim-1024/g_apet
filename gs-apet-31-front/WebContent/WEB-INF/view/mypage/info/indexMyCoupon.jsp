<tiles:insertDefinition name="mypage">
    <tiles:putAttribute name="script.include" value="script.member"/>
    <tiles:putAttribute name="script.inline">
        <script type="text/javascript">
            var isApp = "${view.deviceGb}" == "${frontConstants.DEVICE_GB_30}" || "${view.deviceGb}" == "${frontConstants.DEVICE_GB_20}";
            var mp = parseInt("${mp}");
            var mt = parseInt("${mt}");
            var up = parseInt("${up}");
            var ut = parseInt("${ut}");
            var isAsync = false;

            //시리얼 쿠폰 입력
            function fnInsertSerialCoupon(){
                var isuSrlNo = $("[name='isuSrlNo']").val();
                if(isuSrlNo == ""){
                    ui.toast("쿠폰코드를 입력해주세요.");
                }else{
                    var option = {
                        url : "/mypage/info/registIsuSrlNo"
                        ,   data : { isuSrlNo : isuSrlNo}
                        ,   done : function(result){
                            if(result == "${frontConstants.CONTROLLER_RESULT_CODE_SUCCESS}"){
                                ui.toast("쿠폰이 등록되었어요.",{
                                    ccb : function(){
                                        window.location.reload();
                                    }
                                });
                            }else{
                                ui.toast(result);
                            }
                        }
                    };
                    ajax.call(option);
                }
            }

            //화면 초기화
            function fnLoadDocument(){
                if(isApp){
                    $("#footer").remove();
                    $("#contents-ul").css("height","100%");
                }

                if($("#emptyImg").length > 0){
                    waiting.start();
                }

                $("#header_pc").removeClass("mode0");
                $("#header_pc").addClass("mode16");
                $("#header_pc").attr("data-header", "set22");
                $("#header_pc").addClass("noneAc");
                $(".mo-heade-tit .tit").html("내 쿠폰");

                fnRemoveBackSpace();

                //안내 팝업 동적 binding 위한 ui 이벤트 off
                $(".alert_pop").off();
                if($("#emptyImg").length > 0){
                    setTimeout(function(){
                        $("#emptyImg").show();
                        waiting.stop();
                    },1000);
                }
            }

            //모바일 일 때, 알림 팝업 문구 set
            function fnSetCpNotice(cpNo){
                var id = cpNo+"_notice";
                $("#default-mobile-notice").empty().append($("#"+id).html());
                $("#popCpnGud").addClass("on").css("display","block");
            }

            //이스케이프 문자 및 이용안내 공백 처리
            function fnRemoveBackSpace(){
                $(".cp-notice-list").each(function(idx){
                    var c = $(this).find("li").length;
                    if(c == 1){
                        var t = $(this).find("li").eq(0).text().replace(/\s*/gi,'');
                        if(t == ""){
                            $(this).closest(".alert_pop").remove();
                        }
                    }
                });
            }

            $(function(){
                fnLoadDocument();

                //쿠폰존 바로가기
                $(document).on("click","[name='cpZoneBtn'] , #goCouponZoneBtn-1 , #goCouponZoneBtn-2",function(){
                    var r = "/mypage/info/coupon";
                    var t = $(".uiTab").find(".active").attr("id");
                    window.location.href ="/mypage/service/coupon?r="+r+"?t="+t;
                });

                //쿠폰번호 입력 가이드
                $(document).on("focus","[name='isuSrlNo']",function(){
                    $(this).attr("placeholder","");
                    if( 0 < $(this).val().length){
                        $("#insertSerialCpBtn").removeClass("disabled");
                    }else{
                        if(!$("#insertSerialCpBtn").hasClass("disabled")){
                            $("#insertSerialCpBtn").addClass("disabled");
                        }
                    }
                }).on("blur","[name='isuSrlNo']",function(){
                    $(this).attr("placeholder","쿠폰코드 입력");
                    if( 0 < $(this).val().length){
                        $("#insertSerialCpBtn").removeClass("disabled");
                    }else{
                        if(!$("#insertSerialCpBtn").hasClass("disabled")){
                            $("#insertSerialCpBtn").addClass("disabled");
                        }
                    }
                }).on("input change paste","[name='isuSrlNo']",function(){
                    var maxLength = 20;
                    var inputVal = $(this).val();
                    $(this).val(inputVal.substr(0,maxLength));
                    if( 0 < $(this).val().length){
                        $("#insertSerialCpBtn").removeClass("disabled");
                    }else{
                        if(!$("#insertSerialCpBtn").hasClass("disabled")){
                            $("#insertSerialCpBtn").addClass("disabled");
                        }
                    }
                });

                //모바일 일 때, 쿠폰 이용 안내
                $(document).on("click",".alert_pop",function(e){
                    if(isApp){
                        var cpNo = $(this).prop("id");
                        fnSetCpNotice(cpNo);
                    }else{
                        var cl = ($(this).attr("data-pop") !== undefined) ? $(this).attr("data-pop") : false;
                        var $par = $(this).closest(".bubble_par");
                        e.stopPropagation();
                        $(".bubble_par").removeAttr("style");
                        $par.css("z-index",10);
                        $(".bubble_open").not($(this)).removeClass("bubble_open");
                        $(this).toggleClass("bubble_open");
                    }
                });

                //스크롤 페이징
                <c:choose>
                    <c:when test="${view.deviceGb eq frontConstants.DEVICE_GB_30 or view.deviceGb eq frontConstants.DEVICE_GB_20}">
                            $(".contents > .cupon-wrap.mode_fixed > .uiTab_content ul li").scroll(function(){
                                console.log('ㅁ호바일');
                                var st = $(".my-cupon").innerHeight() -$(this).innerHeight() ;
                                var point = $(this).scrollTop();

                                var activeTab = $(".uiTab .active").prop("id");
                                var $target = $("#cp-list");
                                var url = "/mypage/info/paging/my-coupon";
                                var p = mp;
                                var t = mt;
                                if(activeTab == "uc"){
                                    $target = $("#cp-used-list");
                                    url = "/mypage/info/paging/my-use-coupon";
                                    p = up;
                                    t = ut;
                                }
                                if(p < t && st < point && !isAsync){
                                    waiting.start();
                                    isAsync = true;
                                    var scrollPaging = setInterval(function(){
                                        var option = {
                                            url : url
                                            ,   data : { page : p+1 , t : t}
                                            ,   type : "GET"
                                            ,   dataType : "HTML"
                                            ,   done : function(html){
                                                $target.append(html);
                                                $("#contents-ul").css("height","100%");
                                                st = $(window).scrollTop();
                                                point = $(document).height() - window.innerHeight - 20 - ($("#footer").innerHeight() || 0);
                                                isAsync = false;
                                                if(p<t){
                                                    p = p+1;
                                                    if(activeTab == "cc"){
                                                        mp = p;
                                                    }else if(activeTab == "uc"){
                                                        up = p;
                                                    }
                                                }
                                                fnRemoveBackSpace();
                                                waiting.stop();
                                                clearInterval(scrollPaging);
                                            }
                                        };
                                        ajax.call(option);
                                    },2000);
                                }
                            })
                    </c:when>
                    <c:otherwise>
                        $(window).scroll(function(){
                            var diff = 50;
                            var st = $(window).scrollTop();
                            var point = $(document).height() - window.innerHeight - 20 - ($("#footer").innerHeight() || 0);

                            var activeTab = $(".uiTab .active").prop("id");

                            var $target = $("#cp-list");
                            var url = "/mypage/info/paging/my-coupon";
                            var p = mp;
                            var t = mt;
                            if(activeTab == "uc"){
                                $target = $("#cp-used-list");
                                url = "/mypage/info/paging/my-use-coupon";
                                p = up;
                                t = ut;
                            }
                            if(p < t && st >= point && !isAsync){
                                waiting.start();
                                isAsync = true;
                                var scrollPaging = setInterval(function(){
                                    var option = {
                                        url : url
                                        ,   data : { page : p+1 , t : t}
                                        ,   type : "GET"
                                        ,   dataType : "HTML"
                                        ,   done : function(html){
                                            $target.append(html);
                                            $("#contents-ul").css("height","100%");
                                            st = $(window).scrollTop();
                                            point = $(document).height() - window.innerHeight - 20 - ($("#footer").innerHeight() || 0);
                                            isAsync = false;
                                            if(p<t){
                                                p = p+1;
                                                if(activeTab == "cc"){
                                                    mp = p;
                                                }else if(activeTab == "uc"){
                                                    up = p;
                                                }
                                            }
                                            fnRemoveBackSpace();
                                            waiting.stop();
                                            clearInterval(scrollPaging);
                                        }
                                    };
                                    ajax.call(option);
                                },2000);
                            }
                        })
                    </c:otherwise>
                </c:choose>

            })
        </script>
    </tiles:putAttribute>
    <tiles:putAttribute name="content">
        <!-- 바디 - 여기위로 템플릿 -->
        <main class="container lnb page my" id="container">
                <%--<div class="header pageHead heightNone">
                    <div class="inr">
                        <!-- PC 타이틀 모바일에서 제거  -->
                        <div class="hdt">
                            <button class="back" type="button" onclick="window.location.href='/mypage/indexMyPage'" data-content="" data-url="/mypage/indexMyPage">뒤로가기</button>
                        </div>
                        <div class="cent t2"><h2 class="subtit">내 쿠폰</h2></div>
                    </div>
                </div>--%>

            <div class="inr">
                <!-- 본문 -->
                <div class="contents" id="contents">
                    <!-- PC 타이틀 모바일에서 제거  -->
                    <div class="pc-tit">
                        <h2>내 쿠폰</h2>
                    </div>
                    <!-- // PC 타이틀 모바일에서 제거  -->

                    <div class="cupon-wrap petTabContent mode_fixed hmode_auto"><!-- 2021.03.15 : mode_fixed, hmode_auto 클래스 추가 -->
                        <ul class="uiTab a line">
                            <li class="${id eq 'cc' or empty id ? 'active' : ''}" id="cc">
                                <a class="bt" href="javascript:;"><span id="mCnt">사용가능한 쿠폰 ${totalCnt}</span></a>
                            </li>
                            <li class="${id eq 'uc' ? 'active' : ''}" id="uc">
                                <a class="bt" href="javascript:;"><span>사용/종료된 쿠폰</span></a>
                            </li>
                        </ul>
                        <!-- tab content -->
                        <!-- listMemberCouponSize -->
                        <c:set var="test" value="0"/>
                        <div class="uiTab_content"><!-- 2021.03.15 : style 삭제 -->
                            <ul id="contents-ul">
                                <li>
                                	<!-- // 2021.09.10 : 위치변경 -->
                                    <c:if test="${listMemberCouponSize eq 0}">
                                        <section class="no_data i1 auto_h" id="emptyImg" style="display:none;">
                                            <div class="inr">
                                                <div class="msg">
                                                    사용 가능한 쿠폰이 없습니다.
                                                </div>
                                                <div class="uimoreview">
                                                    <a href="javascript:;" class="bt more" id="goCouponZoneBtn-1">쿠폰존 바로가기</a>
                                                </div>
                                            </div>
                                        </section>
                                    </c:if>
                                    <div class="my-cupon">
                                        <div class="input flex">
                                            <input type="text" name="isuSrlNo" placeholder="쿠폰코드 입력">
                                            <a href="javascript:fnInsertSerialCoupon();" class="btn md disabled" id="insertSerialCpBtn">쿠폰등록</a>
                                        </div>
                                        <!-- // 2021.03.25 : 수정 -->
	                                    <c:if test="${listMemberCouponSize gt 0}">
	                                        <ul class="cupon-list" id="cp-list">
	                                            <jsp:include page="./paging/myCouponBody.jsp" />
	                                        </ul>
	                                    </c:if>
	                                    <!-- // 03.18 수정 -->
                                    <!-- // 2021.09.10 : 추가 -->
                                    </div>

                                    <!-- // 2021.09.10 : 삭제 -->
                                    <!-- /div> -->
                                    <c:if test="${listMemberCouponSize gt 0}">
                                        <div class="uimoreview bottom">
                                            <button class="bt more" name="cpZoneBtn">쿠폰존 바로가기</button>
                                        </div>
                                    </c:if>
                                </li>
                                <li>
                                    <!-- 03.18 수정 -->
                                    <c:if test="${listMemberUsedCouponSize eq 0}">
                                        <section class="no_data i1 auto_h">
                                            <div class="inr">
                                                <div class="msg">
                                                    사용/종료된 쿠폰이 없습니다.
                                                </div>
                                                <div class="uimoreview">
                                                    <a href="javascript:;" class="bt more" id="goCouponZoneBtn-2">쿠폰존 바로가기</a>
                                                </div>
                                            </div>
                                        </section>
                                    </c:if>
                                    <!-- // 03.18 수정 -->
                                    <div class="my-cupon">
                                        <c:if test="${listMemberUsedCouponSize gt 0}">
                                            <p class="info">최근 1년 내역만 노출됩니다.</p>
                                            <ul class="cupon-list" id="cp-used-list">
                                                <jsp:include page="./paging/myUsedCouponBody.jsp" />
                                            </ul>
                                        </c:if>
                                    </div>
                                    <c:if test="${listMemberUsedCouponSize gt 0}">
                                        <div class="uimoreview bottom">
                                            <button class="bt more" name="cpZoneBtn">쿠폰존 바로가기</button>
                                        </div>
                                    </c:if>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </main>

        <div class="layers">
            <!-- 쿠폰이용안내 -->
            <!-- @@ PC에선 하단 팝업.  MO에선 툴팁으로 해달래요 ㅜㅜ -->
            <article class="popBot popCpnGud" id="popCpnGud">
                <div class="pbd">
                    <div class="phd">
                        <div class="in">
                            <h1 class="tit">이용안내</h1>
                            <button type="button" class="btnPopClose" id="btnPopCloseMo">닫기</button>
                        </div>
                    </div>
                    <div class="pct">
                        <main class="poptents">
                            <ul class="tplist" id="default-mobile-notice">
                                <li>‘미용/목욕’ 카테고리에서만 사용 가능한 쿠폰입니다.</li>
                                <li>쿠폰 등록 시 이용안내에 입력한 내용이 노출됩니다</li>
                            </ul>
                        </main>
                    </div>
                </div>
            </article>
        </div>

        <!-- 플로팅 영역 -->
        <c:if test="${view.deviceGb eq frontConstants.DEVICE_GB_10}" >
            <jsp:include page="/WEB-INF/tiles/include/floating.jsp">
                <jsp:param name="floating" value="" />
            </jsp:include>
        </c:if>
    </tiles:putAttribute>
</tiles:insertDefinition>