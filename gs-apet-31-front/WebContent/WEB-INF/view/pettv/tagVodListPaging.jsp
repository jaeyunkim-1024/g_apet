							<c:forEach items="${tagVodList}" var="vod" varStatus="idx">
	                            <li>
	                                <div class="thumb-box">
	                                    <div class="div-header" style="cursor:pointer;">
	                                        <div class="pic" onclick="fncGoUrl('/tv/series/petTvSeriesList?srisNo=${vod.srisNo}&sesnNo=1');"><img src="${fn:indexOf(vod.srisPrflImgPath, 'cdn.ntruss.com')> -1 ? vod.srisPrflImgPath  : frame:optImagePath(vod.srisPrflImgPath, frontConstants.IMG_OPT_QRY_786) }" alt=""></div>
	                                        <div class="tit" onclick="fncGoUrl('/tv/series/petTvSeriesList?srisNo=${vod.srisNo}&sesnNo=1');">${vod.srisNm}</div>
	                                    </div>
	                                    <div class="div-img"> 
	                                    	<c:if test="${view.deviceGb eq frontConstants.DEVICE_GB_10}"> 
		                                        <a href="#" onclick="petTvDetail('${vod.vdId}', ${cornSo.page != 0 ? (idx.index + (cornSo.rows*(cornSo.page-1))) : idx.index}, 'N', 'PLY'); return false;" id="player_${idx.index}" class="thumb-img" style="background-image:url(${fn:indexOf(vod.thumPath, 'cdn.ntruss.com')> -1 ? vod.thumPath  : frame:optImagePath(vod.thumPath, frontConstants.IMG_OPT_QRY_750) });" data-content="${vod.vdId}" data-url="">
		                                            <div class="time-tag"><span>${vod.totLnth}</span></div>
		                                        </a>
		                                    </c:if>
		                                    <c:if test="${view.deviceGb eq frontConstants.DEVICE_GB_20 }"> 
		                                        <a href="#" onclick="petTvDetail('${vod.vdId}', ${cornSo.page != 0 ? (idx.index + (cornSo.rows*(cornSo.page-1))) : idx.index}, 'N', 'PLY'); return false;" id="player_${idx.index}" class="thumb-img" style="background-image:url(${fn:indexOf(vod.thumPath, 'cdn.ntruss.com')> -1 ? vod.thumPath  : frame:optImagePath(vod.thumPath, frontConstants.IMG_OPT_QRY_751) });" data-content="${vod.vdId}" data-url="">
		                                            <div class="time-tag"><span>${vod.totLnth}</span></div>
		                                        </a>
		                                    </c:if>
                                          	<c:if test="${view.deviceGb eq frontConstants.DEVICE_GB_30}"> 
                                   				<a href="#" onclick="petTvDetail('${vod.vdId}', ${cornSo.page != 0 ? (idx.index + (cornSo.rows*(cornSo.page-1))) : idx.index}, 'N', 'VTHUM'); return false;" name="autoFalse" id="vthum_${idx.index}" class="thumb-img" style="background-image:url(${fn:indexOf(vod.thumPath, 'cdn.ntruss.com')> -1 ? vod.thumPath  : frame:optImagePath(vod.thumPath, frontConstants.IMG_OPT_QRY_751) });" data-content="${vod.vdId}" data-url="" >
                                   					<div class="time-tag"><span>${vod.totLnth}</span></div>
                                   				</a>
                                          	</c:if>
	                                    </div>
	                                    <div class="thumb-info">
	                                        <div class="info">
	                                            <div class="tlt k0426" id="petTvListTlt_${cornSo.page != 0 ? (idx.index + (cornSo.rows*(cornSo.page-1))) : idx.index}" onclick="petTvDetail('${vod.vdId}', ${idx.index}, 'N', 'TTL');" data-content="${vod.vdId};" data-url="">
	                                            	${vod.ttl}
	                                            </div>
	                                            <div class="detail">
													<!--<span class="read play"> ${vod.hits}</span>-->
	                                                <span class="read like" id="like_${cornSo.page != 0 ? (idx.index + (cornSo.rows*(cornSo.page-1))) : idx.index}" data-read-like="${vod.vdId}"><fmt:formatNumber type="number" value="${vod.likeCnt}"/></span>
	                                            </div>
	                                        </div>
	                                    </div>
 	                                    <c:if test="${view.deviceGb eq frontConstants.DEVICE_GB_20 || view.deviceGb eq frontConstants.DEVICE_GB_30}"> 
 		                                    <div class="lcbmenuBar">
 		                                        <div class="inner"> 
 		                                            <ul class="bar-btn-area"> 
 		                                                <li> 
 		                                                    <button class="logBtnBasic btn-like ${vod.likeYn == 'Y' ? 'on' : ''}" onclick="vodLike(this, '${vod.vdId}', '${cornSo.dispCornNo}', ${cornSo.page != 0 ? (idx.index + (cornSo.rows*(cornSo.page-1))) : idx.index})" data-btn-like="${vod.vdId }"></button> 
															<%--${vod.likeCnt} --%> 
 		                                                </li> 
 		                                                <li> 
															<%--${idx.count + (petSo.rows*(petcornSo.page-1))}--%>
 		                                                	<button type="button" class="logBtnBasic btn-comment" id="cmt_${cornSo.page != 0 ? (idx.index + (cornSo.rows*(cornSo.page-1))) : idx.index}" onClick="petTvDetail('${vod.vdId}', ${cornSo.page != 0 ? (idx.index + (cornSo.rows*(cornSo.page-1))) : idx.index}, 'R', 'CMT')" data-content="${vod.vdId}" data-url=""></button> 
 															<%--${vod.replyCnt}--%> 
 		                                                </li> 
 		                                                <li> 
 														<c:if test="${view.deviceGb eq frontConstants.DEVICE_GB_30 }"> 
 															<button class="logBtnBasic btn-share" id="vdoShare" data-clipboard-text="${vod.srtUrl}" onclick="vdoShare('null', '${vod.vdId}', '${view.deviceGb}', '${vod.srtUrl}', '${vod.ttl}');" data-content=""  data-url="${vod.srtUrl}"><span>공유</span></button>
 														</c:if>																														 
 														<c:if test="${view.deviceGb eq frontConstants.DEVICE_GB_10 || view.deviceGb eq frontConstants.DEVICE_GB_20}"> 
 					                         				<button class="logBtnBasic btn-share" id="vdoShare" data-message="링크가 복사되었어요"  data-clipboard-text="${vod.srtUrl}" onclick="vdoShare(this.id, '${vod.vdId}', '${view.deviceGb}', '${vod.srtUrl}', '${vod.ttl}');" data-content="" data-url="${vod.srtUrl}"><span>공유</span></button> 
 														</c:if> 
 		                                                </li> 
 		                                                <li class="ml20"> 
 	                                                		<button class="logBtnBasic btn-bookmark ${vod.zzimYn == 'Y' ? 'on' : ''}" onclick="vodBookmark(this, '${vod.vdId}', '${so.dispCornNo}');" data-btn-bookmark="${vod.vdId }"> 
 		                                                	<span>북마크</span></button> 
 		                                                </li> 
 		                                            </ul> 
 		                                            <c:if test="${vod.goodsCount > 0}">
 			                                            <div class="log_connectTingWrap"> 
 			                                            	<a href="#" onclick="petTvDetail('${vod.vdId}', ${cornSo.page != 0 ? (idx.index + (cornSo.rows*(cornSo.page-1))) : idx.index}, 'T', 'goodsCnt'); return false;" id="goodsCnt_${cornSo.page != 0 ? (idx.index + (cornSo.rows*(cornSo.page-1))) : idx.index}" class="tvConnectedTing"  data-content="${vod.vdId}" data-url=""> 
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