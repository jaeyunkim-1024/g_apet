                        	<c:forEach items="${optimalVodList}" var="vod" varStatus="idx">
	                            <li>
	                                <div class="thumb-box">
	                                    <div class="div-header" style="cursor:pointer;">
	                                        <div class="pic" onclick="srisDetail(${vod.srisNo});"><img src="${fn:indexOf(vod.srisPrflImgPath, 'cdn.ntruss.com')> -1 ? vod.srisPrflImgPath  : frame:optImagePath(vod.srisPrflImgPath, frontConstants.IMG_OPT_QRY_786) }" alt=""></div>
	                                        <div class="tit" onclick="srisDetail(${vod.srisNo});">${vod.srisNm}</div>
	                                    </div>
	                                    <div class="div-img"> 
	                                    	<c:if test="${view.deviceGb eq frontConstants.DEVICE_GB_10}"> 
		                                        <a href="#" onclick="petTvDetail('${vod.vdId}', ${so.page != 0 ? (idx.index + (cornSo.rows*(so.page-1))) : idx.index}, 'N', 'PLY'); return false;" id="player_${so.page != 0 ? (idx.index + (cornSo.rows*(so.page-1))) : idx.index}" class="thumb-img" style="background-image:url(${fn:indexOf(vod.thumPath, 'cdn.ntruss.com')> -1 ? vod.thumPath  : frame:optImagePath(vod.thumPath, frontConstants.IMG_OPT_QRY_750) });" data-content="${vod.vdId}" data-url="">
		                                            <div class="time-tag"><span>${vod.totLnth}</span></div>
		                                        </a>
		                                    </c:if>
		                                    <c:if test="${view.deviceGb eq frontConstants.DEVICE_GB_20 }"> 
		                                        <a href="#" onclick="petTvDetail('${vod.vdId}', ${so.page != 0 ? (idx.index + (cornSo.rows*(so.page-1))) : idx.index}, 'N', 'PLY'); return false;" id="player_${so.page != 0 ? (idx.index + (cornSo.rows*(so.page-1))) : idx.index}" class="thumb-img" style="background-image:url(${fn:indexOf(vod.thumPath, 'cdn.ntruss.com')> -1 ? vod.thumPath  : frame:optImagePath(vod.thumPath, frontConstants.IMG_OPT_QRY_751) });" data-content="${vod.vdId}" data-url="">
		                                            <div class="time-tag"><span>${vod.totLnth}</span></div>
		                                        </a>
		                                    </c:if>
                                          	<c:if test="${view.deviceGb eq frontConstants.DEVICE_GB_30}"> 
                                          		<%-- 펫TV 홈/ 영상목록에서 자동재생 삭제로 인해 주석처리-CSR-1247
												<!-- 자동재생여부 true -->
												<div class="vthumbs autoTrue" video_id="${vod.outsideVdId}" type="video_thumb_360p" lazy="scroll" style="height:80%px;">
													<a href="petTvDetail('${vod.vdId}', ${so.page != 0 ? (idx.index + (cornSo.rows*(so.page-1))) : idx.index}, 'N', 'VTHUM');" class="thumb-img" id="vthum_${so.page != 0 ? (idx.index + (cornSo.rows*(so.page-1))) : idx.index}" data-content="${vod.vdId}" data-url="">
				                                    	<div class="time-tag"><span>${vod.totLnth}</span></div>
				                                	</a>
			                                	</div>
												<!-- 자동재생여부 false -->
			                                	<a href="javascript:petTvDetail('${vod.vdId}', ${so.page != 0 ? (idx.index + (cornSo.rows*(so.page-1))) : idx.index}, 'N', 'VTHUM');" name="autoFalse" class="thumb-img" id="vthum_${so.page != 0 ? (idx.index + (cornSo.rows*(so.page-1))) : idx.index}" style="background-image:url(${fn:indexOf(vod.thumPath, 'cdn.ntruss.com')> -1 ? vod.thumPath  : frame:optImagePath(vod.thumPath, frontConstants.IMG_OPT_QRY_751) }); display:none;" data-content="${vod.vdId}" data-url="" >
                                   					<div class="time-tag"><span>${vod.totLnth}</span></div>
                                   				</a>
                                   				--%>
                                   				
                                   				<a href="#" onclick="petTvDetail('${vod.vdId}', ${so.page != 0 ? (idx.index + (cornSo.rows*(so.page-1))) : idx.index}, 'N', 'VTHUM'); return false;" name="autoFalse" id="vthum_${so.page != 0 ? (idx.index + (cornSo.rows*(so.page-1))) : idx.index}" class="thumb-img" style="background-image:url(${fn:indexOf(vod.thumPath, 'cdn.ntruss.com')> -1 ? vod.thumPath  : frame:optImagePath(vod.thumPath, frontConstants.IMG_OPT_QRY_751) });" data-content="${vod.vdId}" data-url="" >
                                   					<div class="time-tag"><span>${vod.totLnth}</span></div>
                                   				</a>
                                          	</c:if>
	                                    </div>
	                                    <div class="thumb-info">
	                                        <div class="info">
	                                            <div class="detail top">
	                                            	<c:if test="${so.dispCornNo == '569'}">
	                                            		<%--(http://jira.aboutpet.co.kr/browse/CSR-1142) 해당이슈의 요청으로 인해 임시로 추천 일치율 미노출로 수정->2021.05.26 by dslee
	                                            		<c:if test="${vod.intRate >= 50}">
                                                			<span class="match"><em>${vod.intRate}%</em>일치</span>
		                                                </c:if>
		                                                --%>
		                                                <ul class="tag-txt">
			                                                <c:forEach items="${vod.tagList}" var="tag" begin="0" end="4">
			                                            		<li><a href="#" onclick="fncGoUrl('/tv/collectTags?tagNo=${tag.tagNo}'); return false;" data-content="${tag.tagNo}" data-url="/tv/collectTags?tagNo=${tag.tagNo}">#${tag.tagNm}</a></li>
			                                                </c:forEach>
		                                                </ul>
	                                                </c:if>
	                                            </div>	                                        
	                                            <div class="tlt k0426" id="petTvListTlt_${so.page != 0 ? (idx.index + (cornSo.rows*(so.page-1))) : idx.index}" onclick="petTvDetail('${vod.vdId}', ${idx.index}, 'N', 'TTL');" data-content="${vod.vdId};" data-url="">
	                                            	${vod.ttl}
	                                            </div>
	                                            <div class="detail">
													<!--<span class="read play"> ${vod.hits}</span>-->
	                                                <span class="read like" id="like_${so.page != 0 ? (idx.index + (cornSo.rows*(so.page-1))) : idx.index}" data-read-like="${vod.vdId }"><fmt:formatNumber type="number" value="${vod.likeCnt}"/></span>
	                                            </div>
	                                        </div>
	                                    </div>
 	                                    <c:if test="${view.deviceGb eq frontConstants.DEVICE_GB_20 || view.deviceGb eq frontConstants.DEVICE_GB_30}"> 
 		                                    <div class="lcbmenuBar">
 		                                        <div class="inner"> 
 		                                            <ul class="bar-btn-area"> 
 		                                                <li> 
 		                                                    <button class="logBtnBasic btn-like ${vod.likeYn == 'Y' ? 'on' : ''}" onclick="vodLike(this, '${vod.vdId}', '${so.dispCornNo}', ${so.page != 0 ? (idx.index + (cornSo.rows*(so.page-1))) : idx.index})" data-btn-like="${vod.vdId }"></button> 
															<%--${vod.likeCnt} --%> 
 		                                                </li> 
 		                                                <li> 
															<%--${idx.count + (petSo.rows*(petSo.page-1))}--%>
 		                                                	<button type="button" class="logBtnBasic btn-comment" id="cmt_${so.page != 0 ? (idx.index + (cornSo.rows*(so.page-1))) : idx.index}" onClick="petTvDetail('${vod.vdId}', ${so.page != 0 ? (idx.index + (cornSo.rows*(so.page-1))) : idx.index}, 'R', 'CMT')" data-content="${vod.vdId}" data-url=""></button> 
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
 			                                            	<a href="#" onclick="petTvDetail('${vod.vdId}', ${so.page != 0 ? (idx.index + (cornSo.rows*(so.page-1))) : idx.index}, 'T', 'goodsCnt'); return false;" id="goodsCnt_${so.page != 0 ? (idx.index + (cornSo.rows*(so.page-1))) : idx.index}" class="tvConnectedTing"  data-content="${vod.vdId}" data-url=""> 
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