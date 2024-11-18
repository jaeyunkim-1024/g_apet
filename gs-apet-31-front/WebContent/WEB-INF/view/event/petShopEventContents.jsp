<tiles:insertDefinition name="common">
    <script type="text/javascript" src="/_script/corner.js" ></script>
    <tiles:putAttribute name="script.inline">
        <script type="text/javascript">
            function fnLoadDocument(){
                $(".mo-header-backNtn").attr("onclick", "goPetShopMain()")

                var isMo = "${frontConstants.DEVICE_GB_10}" != "${view.deviceGb}";
                if(isMo){
//                     $("#alertBtn").remove();
                    $(".subtopnav .inr .swiper-container .swiper-wrapper li").each(function(i){
                        if($(this).find("a").text().replace(/\s/gi,'')=="<spring:message code='front.web.view.event.title' />") {
                            $(this).addClass("active");
                            idx = i;
                        }
                    });
                    ui.disp.subnav.elSwiper.el.slideTo(idx);
                }
            }
            
            $(function(){
                fnLoadDocument();
                //펫샵 - 서브 - 이벤트 ( 김재윤 )
                $(document).on("click","#event-slide-tab li",function(){
                    var ti = $("#event-slide-tab .active").data("section");
                    var $t = $("#"+ti);
                    $t.show();
                    $("section").not($t).hide();
                });
            })
        </script>
    </tiles:putAttribute>

    <tiles:putAttribute name="content">
        <main class="container lnb page shop dm event" id="container">
            <c:if test="${view.deviceGb ne frontConstants.DEVICE_GB_10 and not empty view.displayShortCutList}">
                <nav class="subtopnav">
                    <div class="inr">
                        <div class="swiper-container box">
                            <ul class="swiper-wrapper menu">
                                <c:forEach var="icon" items="${view.displayShortCutList}"  varStatus="status" >
                                    <li class="swiper-slide">
                                        <a class="bt" href="javascript:void(0);" onclick="goLink('${icon.bnrMobileLinkUrl}', true)">${icon.bnrText}</a>
                                    </li>
                                </c:forEach>
                            </ul>
                        </div>
                    </div>
                </nav>
            </c:if>

            <div class="pageHeadPc lnb">
                <div class="inr">
                    <div class="hdt">
                        <h3 class="tit"><spring:message code='front.web.view.event.title' /></h3>
                    </div>
                </div>
            </div>

            <div class="inr">
                <!-- 본문 -->
                <div class="contents" id="contents">
                    <nav class="smain_cate_sld mb0">
                        <div class="swiper-container slide" style="padding:15px 20px;">
                            <ul class="uiTab f swiper-wrapper" id="event-slide-tab">
                                <li class="swiper-slide active" data-section="ing-sect">
                                    <button type="button" class="btn" data-ui-tab-btn="tab_event"><spring:message code='front.web.view.event.title.in.progress' /></button>
                                </li>
                                <li class="swiper-slide" data-section="end-sect">
                                    <button type="button" class="btn" data-ui-tab-btn="tab_event"><spring:message code='front.web.view.common.msg.end.event' /></button>
                                </li>
                            </ul>
                        </div>
                    </nav>

                    <section class="sect dm event" id="ing-sect">
                        <ul class="list">
                            <!-- s : 진행중인 이벤트가 없을 때 -->
                            <c:if test="${eventIngListSize eq 0}">
                                <li class="nodata">
                                    <div class="msg">
                                        <p class="txt"><spring:message code='front.web.view.event.msg.no.in.progress' /></p>
                                    </div>
                                </li>
                            </c:if>
                            <!-- e : 진행중인 이벤트가 없을 때 -->

                            <!-- s : 진행중인 이벤트 리스트 -->
                            <c:if test="${eventIngListSize ne 0}">
								<jsp:include page="./include/eventListBody.jsp"/>
                            </c:if>
                            <!-- e : 진행중인 이벤트 리스트 -->
                        </ul>
                    </section>

                    <section class="sect dm event" id="end-sect" style="display:none;">
                        <ul class="list">
                            <!-- s : 종료된 이벤트가 없을 때 -->
                            <c:if test="${eventEndListSize eq 0}">
                                <li class="nodata">
                                    <div class="msg">
                                        <p class="txt"><spring:message code='front.web.view.event.msg.no.end.event' /></p>
                                    </div>
                                </li>
                            </c:if>
                            <!-- e : 종료된 이벤트가 없을 때 -->

                            <!-- s : 종료된 이벤트 리스트 -->
                            <c:if test="${eventEndListSize ne 0}">
								<jsp:include page="./include/eventEndListBody.jsp"/>
                            </c:if>
                            <!-- e : 종료된 이벤트 리스트 -->
                        </ul>
                    </section>

                </div>

            </div>
        </main>
    </tiles:putAttribute>
</tiles:insertDefinition>