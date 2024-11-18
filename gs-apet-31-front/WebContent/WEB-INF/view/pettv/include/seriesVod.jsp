<c:forEach var="cornerList" items="${cornerList}"  varStatus="status" >
	<c:if test="${param.dispCornNo == cornerList.dispCornNo }">
  		<!-- 독점 시리즈 --> 
        <section class="alone">
        	<!-- 변경전 마크업 APET-1103 -->
            <%--<div class="title-area">
                <h1>펫 TV 독점 오리지날 시리즈</h1>
            </div>--%>
            <!-- //변경전 마크업 APET-1103 -->
            <!-- 변경후 마크업 APET-1103 -->
            <div class="hdts">
				<span class="tit"> <spring:message code='front.web.view.new.menu.tv'/>  독점 오리지날 시리즈</span>  <!-- APET-1250 210728 kjh02  -->
			</div>
			<!-- //변경후 마크업 APET-1103 -->
            <div class="swiper-div">
                <div class="swiper-container">
                    <ul class="swiper-wrapper">
                    	<c:forEach var="seriesList" items="${cornerList.seriesList}">
                        <li class="swiper-slide">
                            <div class="thumb-box">
                            	<c:choose>
	                            	<c:when test="${view.deviceGb eq frontConstants.DEVICE_GB_10}">
	                            		<a href="#" onclick="fncGoUrl('/tv/series/petTvSeriesList?srisNo=${seriesList.srisNo}&sesnNo=1'); return false;" data-content="${seriesList.srisNo }" data-url="/tv/series/petTvSeriesList?srisNo=${seriesList.srisNo}&sesnNo=1" class="thumb-img" style="background-image:url(${fn:indexOf(seriesList.srisImgPath, 'cdn.ntruss.com') > -1 ? seriesList.srisImgPath : frame:optImagePath(seriesList.srisImgPath, frontConstants.IMG_OPT_QRY_791)});"></a>
	                            	</c:when>
	                            	<c:otherwise>
	                            		<a href="#" onclick="fncGoUrl('/tv/series/petTvSeriesList?srisNo=${seriesList.srisNo}&sesnNo=1'); return false;" data-content="${seriesList.srisNo }" data-url="/tv/series/petTvSeriesList?srisNo=${seriesList.srisNo}&sesnNo=1" class="thumb-img" style="background-image:url(${fn:indexOf(seriesList.srisImgPath, 'cdn.ntruss.com') > -1 ? seriesList.srisImgPath : frame:optImagePath(seriesList.srisImgPath, frontConstants.IMG_OPT_QRY_790)});"></a>
	                            	</c:otherwise>
                            	</c:choose>
                            </div>
                        </li>
                        </c:forEach>
                    </ul>
                    <div class="swiper-pagination"></div>
                </div>
                <div class="remote-area">
                    <button class="swiper-button-next" type="button"></button>
                    <button class="swiper-button-prev" type="button"></button>
                </div>
            </div>
            <!-- //Swiper -->
        </section>
	</c:if>
</c:forEach>