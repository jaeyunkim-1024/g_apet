<tiles:insertDefinition name="mypage">
    <tiles:putAttribute name="script.include" value="script.member"/>
    <tiles:putAttribute name="script.inline">
        <script type="text/javascript">
            var isLogin = false;
            var isApp = "${view.deviceGb}" == "${frontConstants.DEVICE_GB_30}" || "${view.deviceGb}" == "${frontConstants.DEVICE_GB_20}";
            var isCanDownYn = "${isCanDownYn}";
            var isAsync = false;
            var p = parseInt("${p}");
            var t = parseInt("${t}");

            //쿠폰 모두 받기
            function fnAllCouponDownload(){
                var isAllCpCnt = $("#coupon-list-body .bubble_par").length;
                var isDownCpCnt = $("#coupon-list-body .disabled").length;
                if(isAllCpCnt != isDownCpCnt){
                    var option = {
                            url : "/mypage/service/allCouponDownload"
                        ,   data : { deviceGb : "${view.deviceGb}" }
                        ,   done : function(result){
                                result.forEach(function(o){
                                    if(o.resultCode === "${frontConstants.CONTROLLER_RESULT_CODE_SUCCESS}"){
                                        var cpNo = o.cpNo;
                                        $("button[name='cp-down-btn'][value='"+cpNo+"']").parent().not(".disabled").addClass("disabled");
                                        $("button[name='cp-down-btn'][value='"+cpNo+"']").prop("disabled",true);
                                    }
                                });
                                $("[name='all-cp-down-btn']").addClass("disabled").prop("disabled",true);
                                ui.toast("쿠폰 다운로드가 완료되었어요.");
                        }
                    };
                    ajax.call(option);
                }else{
                    ui.toast("다운로드 받을 쿠폰이 없습니다.");
                }
            }

            //쿠폰 다운로드
            function fnCouponDownload(cpNo){
                var option = {
                        url : "/mypage/service/couponDownload"
                    ,   data : { cpNo : cpNo }
                    ,   done : function(result){
                            if(result == "${frontConstants.CONTROLLER_RESULT_CODE_SUCCESS}"){
                                $("button[value='"+cpNo+"']").parent().addClass("disabled").prop("disabled",true);
                                ui.toast("쿠폰 다운로드가 완료되었어요.");
                            }else{
                                ui.toast(result);
                            }
                    }
                };
                ajax.call(option);
            }

            //화면 초기화
            function fnLoadDocument(){
                 //모바일 타이틀 수정
                $("#header_pc").removeClass("mode0");
                $("#header_pc").addClass("mode16");
                $("#header_pc").attr("data-header", "set22");
                $(".mo-heade-tit .tit").html("쿠폰존");

                //모바일 때는, 하단 메뉴바 숨김(사이즈로 체크) , 푸터도 숨김
                var footer_min_height = $("li").last().offset().top;
                if(isApp){
                    $(".menubar").hide();
                    $("#footer").hide();
                    $(".btnGnb").remove()
                }else{
                    ui.shop.lnb.set = function(){
                        $(".container.lnb .contents").css("min-height",footer_min_height);
                    }
                }

                //로그인 여부 플래그
                isLogin = "${isLogin}" == "${frontConstants.COMM_YN_Y}" ? true : false;
                fnRemoveBackSpace();

                //안내 팝업 동적 binding 위한 ui 이벤트 off
                $(".alert_pop").off();
            }

            //쿠폰 유의 사항 escape 문자 치환
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

            //모바일 일 때, 알림 팝업 문구 set
            function fnSetCpNotice(cpNo){
                var id = cpNo+"_notice";
                $("#default-mobile-notice").empty().append($("#"+id).html());
                $("#popCpnGud").addClass("on").css("display","block");
            }

            $(function(){
                fnLoadDocument();

                //쿠폰 모두 받기, 쿠폰 다운로드 버튼 클릭
                $(document).on("click","[name='cp-down-btn'] , [name='all-cp-down-btn']",function(){
                    if(!isLogin){
                        messager.confirm({
                            txt : "로그인 후 서비스를 이용할 수 있어요.<br>로그인 할까요?"
                            ,   ycb : function(){
                                window.location.href = "/indexLogin?returnUrl=/mypage/service/coupon";
                            }
                        	,	ybt : "로그인"
                        	, 	nbt : "취소"
                        });
                    }else if(!$(this).parent().hasClass("disabled")){
                        this.name === "all-cp-down-btn" ? fnAllCouponDownload() : fnCouponDownload(this.value);
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
                        $(".bubble_open").not($(this)).removeClass("bubble_open");
                        $(this).toggleClass("bubble_open");
                    }
                });

                //스크롤 페이징
                $(window).scroll(function(){
                    var diff = 50;
                    var st = $(window).scrollTop();
                    var point = $(document).height() - window.innerHeight - 20 - ($("#footer").innerHeight() || 0);
                    var $target = $(".cupon-list");
                    if(p < t && st >= point && !isAsync){
                        waiting.start();
                        isAsync = true;
                        var scrollPaging = setInterval(function(){
                            var option = {
                                    url : "/mypage/service/paging/coupon"
                                ,   data : { page : p+1 , t : t}
                                ,   type : "GET"
                                ,   dataType : "HTML"
                                ,   done : function(html){
                                        if(p<t){
                                            p += 1;
                                        }
                                        $target.append(html);
                                        st = $(window).scrollTop();
                                        point = $(document).height() - window.innerHeight - 20 - ($("#footer").innerHeight() || 0);
                                        isAsync = false;
                                        fnRemoveBackSpace();
                                        waiting.stop();
                                        clearInterval(scrollPaging);
                                }
                            };
                            ajax.call(option);
                        },2000);
                    }
                })
            });
        </script>
    </tiles:putAttribute>
    <tiles:putAttribute name="content">
        <main class="container lnb page 1dep 2dep" id="container">
            <div class="inr">
                <!-- 본문 -->
                <div class="contents" id="contents">
                    <!-- PC 타이틀 모바일에서 제거  -->
                    <div class="pc-tit">
                        <h2>쿠폰존</h2>
                    </div>
                    <!-- // PC 타이틀 모바일에서 제거  -->
                    <div class="cupon-wrap">
                        <c:if test="${listSize eq 0}">
                            <section class="no_data i1 auto_h">
                                <div class="inr">
                                    <div class="msg">
                                        다양한 할인 혜택을 준비중입니다.<br>
                                        조금만 기다려주세요.
                                    </div>
                                </div>
                        </c:if>
                        <div class="cupon-area t2" data-dh="60">
                            <c:if test="${listSize gt 0}">
                                <ul class="cupon-list" id="coupon-list-body">
                                    <jsp:include page="./paging/couponZoneBody.jsp"/>
                                </ul>
                            </c:if>
                        </div>
                        <c:if test="${listSize gt 0}">
                                <div class="pbt fixed">
                                    <div class="bts">
                                        <c:choose>
                                            <c:when test="${isCanDownYn eq frontConstants.COMM_YN_N}">
                                                <button type="button" class="btn xl a disabled" name="all-cp-down-btn" disabled>쿠폰 모두 받기</button>
                                            </c:when>
                                            <c:otherwise>
                                                <button type="button" class="btn xl a" name="all-cp-down-btn">쿠폰 모두 받기</button>
                                            </c:otherwise>
                                        </c:choose>

                                    </div>
                                </div>
                        </c:if>
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
                            <button type="button" class="btnPopClose">닫기</button>
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

        <!-- 플로팅 추가  -->
        <c:if test="${view.deviceGb eq frontConstants.DEVICE_GB_10}" >
            <jsp:include page="/WEB-INF/tiles/include/floating.jsp">
                <jsp:param name="floating" value="talk" />
            </jsp:include>
        </c:if>
    </tiles:putAttribute>
</tiles:insertDefinition>