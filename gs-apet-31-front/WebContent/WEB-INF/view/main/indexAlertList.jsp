<tiles:insertDefinition name="common">
    <tiles:putAttribute name="script.inline">
        <script type="text/javascript">
            $(function(){
				$(".mode0").remove();
				$("#footer").remove();
				$(".menubar").remove();
            });
            
            function goUrl(url){
 	    	   toNativeData.func = "onNewPage";
 	    	   toNativeData.type = "TV";
 	    	   toNativeData.url = url;
 	    	   
 	    	   toNative(toNativeData);
 	       }
        </script>
    </tiles:putAttribute>

    <tiles:putAttribute name="content">
    <div class="wrap" id="wrap">
   		<!-- mobile header -->
		<header class="header pc cu mode7 logHeaderAc" data-header="set9">
			<div class="hdr">
				<div class="inr">
					<div class="hdt">
						<button id ="backBtn" class="mo-header-backNtn" onclick="storageHist.goBack()"><spring:message code='front.web.view.common.msg.back' /></button>
						<div class="mo-heade-tit"><span class="tit"><spring:message code='front.web.view.common.title.notify' /></span></div>
					</div>
				</div>
			</div>
		</header>
		<!-- // mobile header  -->
        <!-- 바디 - 여기위로 템플릿 -->
        <main class="container page 1dep 2dep" id="container">
            <div class="inr">
                <!-- 본문 -->
                <div class="contents" id="contents">
                  	<c:if test = "${fn:length(pushList) > 0 }">
                    <!-- 알림 리스트 -->
                    <div class="notice-list">
                        <ul>
                        	<c:forEach items ="${pushList }" var="push" varStatus="stat">
                                <c:choose>
	                                <c:when test="${push.ctgCd eq frontConstants.CTG_60 and fn:indexOf(push.landingUrl, '/tv/series/indexTvDetail') > -1 and view.deviceGb eq frontConstants.DEVICE_GB_30}">
                                   		<a href ="#" onclick="goUrl('${push.landingUrl }'); return false;">
	                                </c:when>
	                                <c:otherwise>
	                                    <a href ="${push.landingUrl }">
	                                </c:otherwise>
                           		</c:choose>
                            <li <c:if test="${stat.index ne 0 }">style="padding-top:20px;"</c:if>>
                                <p class="img">
                                	<c:choose>
									<c:when test ="${push.ctgCd eq frontConstants.CTG_60 }">
										<img src="../../_images/common/icon-noti-pettv@2x.png" alt="">
									</c:when>
									<c:when test ="${push.ctgCd eq frontConstants.CTG_70 }">
										<img src="../../_images/common/icon-noti-petlog@2x.png" alt="">
									</c:when>
									<c:when test ="${push.ctgCd eq frontConstants.CTG_80 }">
										<img src="../../_images/common/icon-noti-petshop@2x.png" alt="">
									</c:when>
									<c:when test ="${push.ctgCd eq frontConstants.CTG_90 }">
										<img src="../../_images/common/icon-noti-common@2x.png" alt="">
									</c:when>
									<c:when test ="${push.ctgCd eq frontConstants.CTG_100 }">
										<img src="../../_images/common/icon-noti-live@2x.png" alt="">
									</c:when>
									<c:otherwise>
										<img src="../../_images/common/icon-noti-event@2x.png" alt="">
									</c:otherwise>
								</c:choose>
                                </p>
                                <div class="text-bx">
                                    <p class="tit">${push.subject }</p>
                                    <p class="txt">${push.contents }</p>
                                    <p class="date">
                                    	${push.strDateDiff }
                                    	<%-- <c:if test = "${push.dateDiff ge 60}">
											<frame:timeCalculation time = "${push.dateDiff }" type="M"/>전										
										</c:if>
										<c:if test = "${push.dateDiff lt 60 }">
											방금					
										</c:if> --%>
                                    </p>
                                </div>
                            </li>
                            </a>
                            </c:forEach>
                        </ul>
                    </div>
                    <!-- // 알림 리스트 -->
                    </c:if>
                    <c:if test = "${fn:length(pushList) <= 0 }">
	                  	<div class="noneBoxPoint h100">
						<div>
							<span class="ico_noalert"></span>
							<div class="noneBoxPoint_infoTxt" style="color:#666;"><spring:message code='front.web.view.common.msg.no.new.notify' /></div>
						</div>
					</div>
                    </c:if>
                </div>
            </div>
        </main>
        </div>
    </tiles:putAttribute>
</tiles:insertDefinition>