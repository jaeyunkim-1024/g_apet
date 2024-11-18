							<ul class="list vodList">
								<c:forEach items="${foSesnVodList}" var="vod">
									<li>
										<div class="thumb-box">
											<div class="div-img">
												<c:if test="${vod.newYn == 'Y'}">
													<i class="icon-n">N</i>
												</c:if>
												<a href="#" onclick="srisDetail('${vod.vdId}', '${vod.srisNo}'); return false;" id="srisIndex_${idx.index}" class="thumb-img" style="background-image:url(${fn:indexOf(vod.thumPath, 'cdn.ntruss.com') > -1 ? vod.thumPath : frame:optImagePath(vod.thumPath, frontConstants.IMG_OPT_QRY_765)});" data-content="${vod.vdId}" data-url="">
													<div class="time-tag"><span>${vod.totLnth}</span></div>
													<c:if test="${vods.histLnth == null && vod.histLnth != '' && (vod.histLnth/vod.totalLnth)*100 >= 10.0}">
														<div class="progress-bar" style="width:${(vod.histLnth/vod.totalLnth)*100}%;"></div>
													</c:if>
												</a>
											</div>
											<div class="thumb-info">
												<div class="info">
													<div class="tlt">
														<a href="#" onclick="srisDetail('${vod.vdId}', '${vod.srisNo}'); return false;" data-content="${vod.vdId}" data-url="">
															${vod.ttl}
														</a>
													</div>
													<div class="detail">
														<!--<span class="read play"><fmt:formatNumber type="number" value="${vod.hits}"/></span>-->
														<span class="read like" data-read-like="${vod.vdId}"><fmt:formatNumber type="number" value="${vod.likeCnt}"/></span>
													</div>
												</div>
											</div>
										</div>
									</li>
								</c:forEach>
							</ul>