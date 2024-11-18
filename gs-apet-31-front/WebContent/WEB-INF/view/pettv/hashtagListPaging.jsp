                        	<c:forEach items="${optimalVodList}" var="vod" varStatus="idx">
	                            <li>
	                                <div class="thumb-box">
	                                    <div class="div-header" style="cursor:pointer;">
	                                        <div class="pic" onclick="srisDetail(${vod.srisNo});"><img src="${fn:indexOf(vod.srisPrflImgPath, 'cdn.ntruss.com')> -1 ? vod.srisPrflImgPath  : frame:optImagePath(vod.srisPrflImgPath, frontConstants.IMG_OPT_QRY_786) }" alt=""></div>
	                                        <div class="tit" onclick="srisDetail(${vod.srisNo});">${vod.srisNm}</div>
	                                    </div>
	                                    <div class="div-img"> 
	                                    	<c:choose>
	                                    		<c:when test="${view.deviceGb eq frontConstants.DEVICE_GB_30}">
	                                    			<%-- 펫TV 홈/ 영상목록에서 자동재생 삭제로 인해 주석처리-CSR-1247
		                                    		<!-- 자동재생여부 true -->
													<div class="vthumbs autoTrue" video_id="${vod.outsideVdId}" type="video_thumb_360p" lazy="scroll" style="height:80%px;display:none;">
														<a href="javascript:petTvDetail('${vod.vdId}', '${vod.tagNo}');" class="thumb-img" data-content="${vod.vdId}" data-url="${view.stDomain}/tv/series/indexTvDetail?vdId=${vod.vdId}&sortCd=&listGb=TAG_N_${vod.tagNo}">
					                                    	<div class="time-tag"><span>${vod.totLnth}</span></div>
					                                	</a>
				                                	</div>
													<!-- 자동재생여부 false -->
				                                	<a href="javascript:petTvDetail('${vod.vdId}', '${vod.tagNo }');" name="autoFalse" class="thumb-img" style="background-image:url(${fn:indexOf(vod.thumPath, 'cdn.ntruss.com')> -1 ? vod.thumPath  : frame:optImagePath(vod.thumPath, frontConstants.IMG_OPT_QRY_751) }); display:none;" data-content="${vod.vdId}" data-url="${view.stDomain}/tv/series/indexTvDetail?vdId=${vod.vdId}&sortCd=&listGb=TAG_N_${vod.tagNo}" >
	                                   					<div class="time-tag"><span>${vod.totLnth}</span></div>
	                                   				</a>
	                                   				--%>
	                                   				
	                                   				<a href="#" onclick="petTvDetail('${vod.vdId}', '${vod.tagNo }'); return false;" name="autoFalse" class="thumb-img" style="background-image:url(${fn:indexOf(vod.thumPath, 'cdn.ntruss.com')> -1 ? vod.thumPath  : frame:optImagePath(vod.thumPath, frontConstants.IMG_OPT_QRY_751) });" data-content="${vod.vdId}" data-url="${view.stDomain}/tv/series/indexTvDetail?vdId=${vod.vdId}&sortCd=&listGb=TAG_N_${vod.tagNo}" >
	                                   					<div class="time-tag"><span>${vod.totLnth}</span></div>
	                                   				</a>
	                                    		</c:when>
	                                    		<c:otherwise>
		                                        	<a href="#" onclick="fncGoUrl('/tv/series/indexTvDetail?vdId=${vod.vdId}&sortCd=&listGb=TAG_N_${vod.tagNo}'); return false;" class="thumb-img" style="background-image:url(${fn:indexOf(vod.thumPath, 'cdn.ntruss.com') > -1 ? vod.thumPath : frame:optImagePath(vod.thumPath, frontConstants.IMG_OPT_QRY_751)});" data-content="${vod.vdId}" data-url="/tv/series/indexTvDetail?vdId=${vod.vdId}&sortCd=&listGb=TAG_N_${vod.tagNo}">
		                                        		<div class="time-tag"><span>${vod.totLnth }</span></div>
			                                        </a>
	                                    		</c:otherwise>
	                                    	</c:choose>
	                                    </div>
	                                    <div class="thumb-info">
	                                        <div class="info">
	                                            <div class="detail top">
	                                                <ul class="tag-txt">
		                                                <c:forEach items="${vod.tagList}" var="tag" begin="0" end="4">
		                                            		<li><a href="#" onclick="fncGoUrl('/tv/collectTags?tagNo=${tag.tagNo}'); return false;" data-content="${tag.tagNo}" data-url="/tv/collectTags?tagNo=${tag.tagNo}">#${tag.tagNm}</a></li>
		                                                </c:forEach>
	                                                </ul>
	                                            </div>
	                                            <c:choose>
	                                            	<c:when test="${view.deviceGb eq frontConstants.DEVICE_GB_30}">
		                                            	<div class="tlt k0426" onclick="petTvDetail('${vod.vdId}', '${vod.tagNo}');" data-content="${vod.vdId};" data-url="${view.stDomain}/tv/series/indexTvDetail?vdId=${vod.vdId}&sortCd=&listGb=TAG_N_${vod.tagNo}">
		                                            		${vod.ttl}
		                                            	</div>
	                                            	</c:when>
	                                            	<c:otherwise>
			                                            <div class="tlt k0426" >
			                                            	<a href="#" onclick="fncGoUrl('/tv/series/indexTvDetail?vdId=${vod.vdId}&sortCd=&listGb=TAG_N_${vod.tagNo}'); return false;" data-content="${vod.vdId};" data-url="/tv/series/indexTvDetail?vdId=${vod.vdId}&sortCd=&listGb=TAG_N_${vod.tagNo}">
			                                            		${vod.ttl}
			                                            	</a>
			                                            </div>
	                                            	</c:otherwise>
	                                            </c:choose>
	                                            <div class="detail">
													<!--<span class="read play"> ${vod.hits}</span>-->
	                                                <span class="read like" id="like_${so.page != 0 ? (idx.index + (so.rows*(so.page-1))) : idx.index}" data-read-like="${vod.vdId}"><fmt:formatNumber type="number" value="${vod.likeCnt}"/></span>
	                                            </div>
	                                        </div>
	                                    </div>
	                                    <c:if test="${view.deviceGb eq frontConstants.DEVICE_GB_20 || view.deviceGb eq frontConstants.DEVICE_GB_30}">
		                                    <!-- menu bar -->
		                                    <div class="lcbmenuBar">
		                                        <div class="inner">
		                                            <ul class="bar-btn-area">
		                                            	<!-- 좋아요 -->
		                                                <li>
		                                                    <button class="logBtnBasic btn-like ${vod.likeYn == 'Y' ? 'on' : ''}" onclick="vodLike(this, '${vod.vdId}', ${so.page != 0 ? (idx.index + (so.rows*(so.page-1))) : idx.index}, '${so.tagNo}')" data-btn-like="${vod.vdId }"></button>
		                                                </li>
		                                                <!-- 댓글 -->
		                                                <li>
		                                                	<c:if test="${view.deviceGb eq frontConstants.DEVICE_GB_20 }">
		                                                		<button type="button" class="logBtnBasic btn-comment" onClick="petTvReDetail('${vod.vdId}', '${vod.tagNo}', 'R');" data-content="${vod.vdId}" data-url="/tv/series/indexTvDetail?vdId=${vod.vdId}&sortCd=&listGb=TAG_R_${vod.tagNo}"></button>
		                                                	</c:if>
		                                                	<c:if test="${view.deviceGb eq frontConstants.DEVICE_GB_30 }">
		                                                		<button type="button" class="logBtnBasic btn-comment" onClick="petTvReDetail('${vod.vdId}', '${vod.tagNo}', 'R');" data-content="${vod.vdId}" data-url="${view.stDomain}/tv/series/indexTvDetail?vdId=${vod.vdId}&sortCd=&listGb=TAG_R_${vod.tagNo}"></button>
		                                                	</c:if>
		                                                </li>
		                                                <!-- 공유 -->
		                                                <li>
														<c:if test="${view.deviceGb eq frontConstants.DEVICE_GB_30 }">
															<button class="logBtnBasic btn-share" id="vdoShare" data-clipboard-text="${vod.srtUrl}" onclick="vdoShare('null', '${vod.vdId}', '${view.deviceGb}', '${vod.srtUrl}', '${vod.ttl}');" data-content=""  data-url="${vod.srtUrl}"><span>공유</span></button>
														</c:if>																														
														<c:if test="${view.deviceGb eq frontConstants.DEVICE_GB_10 || view.deviceGb eq frontConstants.DEVICE_GB_20}">
					                         				<button class="logBtnBasic btn-share" id="vdoShare" data-message="URL을 복사하였습니다."  data-clipboard-text="${vod.srtUrl}" onclick="vdoShare(this.id, '${vod.vdId}', '${view.deviceGb}', '${vod.srtUrl}', '${vod.ttl}');" data-content="" data-url="${vod.srtUrl}"><span>공유</span></button>
														</c:if>
		                                                </li>
		                                                <!-- 북마크 -->
		                                                <li class="ml20">
	                                                		<button class="logBtnBasic btn-bookmark ${vod.zzimYn == 'Y' ? 'on' : ''}" onclick="vodBookmark(this, '${vod.vdId}',  '${so.tagNo}');" data-btn-bookmark="${vod.vdId }">
		                                                	<span>북마크</span></button>
		                                                </li>
		                                            </ul>
		                                            <!-- 연관상품 -->
		                                            <c:if test="${vod.goodsCount > 0}">
			                                            <div class="log_connectTingWrap">
			                                            	<c:if test="${view.deviceGb eq frontConstants.DEVICE_GB_20 }">
			                                            		<a href="#" onclick="petTvReDetail('${vod.vdId}', '${vod.tagNo}', 'T'); return false;" class="tvConnectedTing"  data-content="${vod.vdId}" data-url="/tv/series/indexTvDetail?vdId=${vod.vdId}&sortCd=&listGb=TAG_T_${vod.tagNo}">
			                                            	</c:if>
			                                            	<c:if test="${view.deviceGb eq frontConstants.DEVICE_GB_30 }">
			                                            		<a href="#" onclick="petTvReDetail('${vod.vdId}', '${vod.tagNo}', 'T'); return false;" class="tvConnectedTing"  data-content="${vod.vdId}" data-url="${view.stDomain}/tv/series/indexTvDetail?vdId=${vod.vdId}&sortCd=&listGb=TAG_T_${vod.tagNo}">
			                                            	</c:if>
			                                            	연관상품<span>${vod.goodsCount}</span></a>
			                                            </div>
		                                            </c:if>
		                                        </div>
		                                    </div>
	                                    </c:if>
	                                    <!-- // menu bar -->
	                                </div>
	                            </li>
                            </c:forEach>
                        
                  
   