							<c:forEach items="${seriesTagList}" var="sris" varStatus="idx">
	                            <li>
	                                <div class="thumb-box">
	                                    <div class="div-header" style="cursor:pointer;">
	                                        <div class="pic" onclick="fncGoUrl('/tv/series/petTvSeriesList?srisNo=${sris.srisNo}&sesnNo=1');"><img src="${fn:indexOf(sris.srisPrflImgPath, 'cdn.ntruss.com')> -1 ? sris.srisPrflImgPath  : frame:optImagePath(sris.srisPrflImgPath, frontConstants.IMG_OPT_QRY_786) }" alt=""></div>
	                                        <div class="tit" onclick="fncGoUrl('/tv/series/petTvSeriesList?srisNo=${sris.srisNo}&sesnNo=1');">${sris.srisNm}</div>
	                                    </div>
	                                    <div class="div-img"> 
	                                    	<c:choose>
	                                    		<c:when test="${view.deviceGb eq frontConstants.DEVICE_GB_10}">
		                                    		<a href="#" onclick="fncGoUrl('/tv/series/petTvSeriesList?srisNo=${sris.srisNo}&sesnNo=1'); return false;" class="thumb-img" style="background-image:url(${fn:indexOf(sris.srisImgPath, 'cdn.ntruss.com')> -1 ? sris.srisImgPath  : frame:optImagePath(sris.srisImgPath, frontConstants.IMG_OPT_QRY_750) });" data-content="${vod.vdId}" data-url="/tv/series/petTvSeriesList?srisNo=${vod.srisNo}&sesnNo=1">
			                                            <%--<div class="time-tag"><span>${sris.totLnth}</span></div>--%>
			                                        </a>
	                                    		</c:when>
	                                    		<c:otherwise>
	                                    			<a href="#" onclick="fncGoUrl('/tv/series/petTvSeriesList?srisNo=${sris.srisNo}&sesnNo=1'); return false;" class="thumb-img" style="background-image:url(${fn:indexOf(sris.srisImgPath, 'cdn.ntruss.com')> -1 ? sris.srisImgPath  : frame:optImagePath(sris.srisImgPath, frontConstants.IMG_OPT_QRY_751) });" data-content="${vod.vdId}" data-url="/tv/series/petTvSeriesList?srisNo=${vod.srisNo}&sesnNo=1">
			                                            <%--<div class="time-tag"><span>${sris.totLnth}</span></div>--%>
			                                        </a>
	                                    		</c:otherwise>
	                                    	</c:choose>
	                                    </div>
	                                </div>
	                            </li>
                            </c:forEach>